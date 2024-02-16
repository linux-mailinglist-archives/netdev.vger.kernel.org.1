Return-Path: <netdev+bounces-72463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811F285832F
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 17:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 362242856F7
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 16:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CBB130E24;
	Fri, 16 Feb 2024 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZ2chPVR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B8812BF03
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708102748; cv=none; b=czgJ0cMm0nKhJ5RaxmEqQrufvS7ezQIkssLEtWCoGILUdZ4eCIfNGWre3Tkby9mjWJX8l+/f3pFvTMXuX6mzABgjzF1tuJs8dyUn9WSPGMdsoz9QD+xv8MXKSpM8UVpTG7VlYfoIicsysxXAVx7ps0JwmcC7ibFWwNXJtKYYJ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708102748; c=relaxed/simple;
	bh=v7y7uGngxNjvc3lNlktCBCQx7SFzp4iGK8w+eOOkpvM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zcky5Q+ykG9kc9BSV6mcak8kN1cA1pMSSkqKdymTnGgtah/OYhaY3PCcgqnsciQrCr+IWFvZPzdAI737XVRg87rjmmkSl5s2LgtlU8QsaHaQhp8tKF1XBG/8p6sYPAf96C+IQji8LUUhEsDxK+S7r8nXuVTlocA9E3qVhPuUL0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BZ2chPVR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708102745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=v7y7uGngxNjvc3lNlktCBCQx7SFzp4iGK8w+eOOkpvM=;
	b=BZ2chPVRhYRcpoG5Cuio/GaGR+VUiy6GZdDU8XHL2mTXe+58vqsSzBhY6WVLp6LuDV/iUj
	PQVkitR5wrm/OYIhLklK1Vq8hH+KKIRQXSW9fzVKxHGge2/UOaKwvCLVXa0arHbJgWMEHh
	wiMoQynjlfyuMQ8QDHz6P1B+/0AmHlw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-oz8kbfXNNiSfehjAP609rQ-1; Fri, 16 Feb 2024 11:59:04 -0500
X-MC-Unique: oz8kbfXNNiSfehjAP609rQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-410adb15560so1979165e9.1
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 08:59:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708102743; x=1708707543;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v7y7uGngxNjvc3lNlktCBCQx7SFzp4iGK8w+eOOkpvM=;
        b=iR0gG6wWcS96mJ0v0vt1xk4suTXvbAB4YMfUSDhX3Qo1AJUyaC5saw3j6vfvYiZf7g
         xDUNzHlUgoZQjyk9NsoicXbPgpX1lrxctA8VeqQkpcLZMf/pA71mQkVQGR27KRp62mgm
         QJhkYeP+te45x3meYfJ0NzsmjfDhXd2o8brMo7IeOYQZDQKitTygtaMpYp8kH0MNCWc8
         ylmB8XDuF66Gtgy83smks2WqLPWzHjGrgTmdvGiYnYTPsAto5zi9Ki2sKp/bIIInQnLo
         yvnLa8YdyvsIU56TMjp+nGDns+2galCLWDmx57mNIK3GdTpLvoyBwKst5u8NAXbzapFc
         iXFQ==
X-Gm-Message-State: AOJu0Yx1Ewp9a3lVQTjPVYpMybhRChngFEYzE8DQkj/sjXFlXumkhDj6
	jgTygAZU3fP1U+eZYS3tcaK+IcH+nGbp/9gUn+HrhNvPKXYcWC67uBshd3r1pJ48n7OKZn9vGkW
	MT7YehJWbZhcEI0aMMdUmjFtp5e9xyu1HqPKzh1LeAKgNIqlmLNuk9w==
X-Received: by 2002:a05:600c:1c18:b0:411:ee2e:ae4d with SMTP id j24-20020a05600c1c1800b00411ee2eae4dmr3965295wms.2.1708102743248;
        Fri, 16 Feb 2024 08:59:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxdk2pcN6ShnXNj0V7VaRO7JALodlD52Vcj/gevxyk1l+NkVTv6dpF8BPj1rf1jr1EOf8HSQ==
X-Received: by 2002:a05:600c:1c18:b0:411:ee2e:ae4d with SMTP id j24-20020a05600c1c1800b00411ee2eae4dmr3965283wms.2.1708102742892;
        Fri, 16 Feb 2024 08:59:02 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-239-108.dyn.eolo.it. [146.241.239.108])
        by smtp.gmail.com with ESMTPSA id bo6-20020a056000068600b0033d22b1272fsm280944wrb.50.2024.02.16.08.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 08:59:02 -0800 (PST)
Message-ID: <7904adc0b3ab1c6b4bc328b0509435c9d38fc98a.camel@redhat.com>
Subject: Re: [PATCH net-next] net: reorganize "struct sock" fields
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, Neal Cardwell
	 <ncardwell@google.com>, Naman Gulati <namangulati@google.com>, Coco Li
	 <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>, Jon Maloy
	 <jmaloy@redhat.com>
Date: Fri, 16 Feb 2024 17:59:01 +0100
In-Reply-To: <20240216162006.2342759-1-edumazet@google.com>
References: <20240216162006.2342759-1-edumazet@google.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-16 at 16:20 +0000, Eric Dumazet wrote:
> Last major reorg happened in commit 9115e8cd2a0c ("net: reorganize
> struct sock for better data locality")
>=20
> Since then, many changes have been done.
>=20
> Before SO_PEEK_OFF support is added to TCP, we need
> to move sk_peek_off to a better location.
>=20
> It is time to make another pass, and add six groups,
> without explicit alignment.
>=20
> - sock_write_rx (following sk_refcnt) read-write fields in rx path.
> - sock_read_rx read-mostly fields in rx path.
> - sock_read_rxtx read-mostly fields in both rx and tx paths.
> - sock_write_rxtx read-write fields in both rx and tx paths.
> - sock_write_tx read-write fields in tx paths.
> - sock_read_tx read-mostly fields in tx paths.
>=20
> Results on TCP_RR benchmarks seem to show a gain (4 to 5 %).
>=20
> It is possible UDP needs a change, because sk_peek_off
> shares a cache line with sk_receive_queue.

Yes, I think we need to touch UDP.

> If this the case, we can exchange roles of sk->sk_receive
> and up->reader_queue queues.

That option looks quite invasive and possibly error prone to me. What
about adding a 'peeking_with_offset' flag nearby up->reader_queue, set
it via an udp specific set_peek_off(), and test such flag in
udp_recvmsg() before accessing sk->sk_peek_off?

> After this change, we have the following layout:

Looks great!

Acked-by: Paolo Abeni <pabeni@redhat.com>

I'll try to run some benchmarks when time allows ;)

Many thanks!

Paolo


