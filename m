Return-Path: <netdev+bounces-85111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 861678997E9
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 10:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2352B21D0C
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 08:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B5315FA66;
	Fri,  5 Apr 2024 08:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqlMh6fA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFB415FA95
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 08:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712306079; cv=none; b=clduofWWJYmiMqsIVmExda6bAB5IWPu++9hB8DUL6hYUqYrmDZutuRMraN6ytaMsPh1uriHiV7etX7TaE7+6x4UuE5nm/LQfBMJTlgRXvP3TB+z5SxIU4ykbzfwdX7VFHc/HKbjYO6hv1SilegGuN2foF0Bj0wNyA2UDOpa9bl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712306079; c=relaxed/simple;
	bh=qm6TnS1OEfgYoeCHQolapAEQCWvFv3wqYvT2tGPeW38=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rmhSHQ2zfrr4fATDG4gKMezdvpIeZyHKq56L8ZV1xyt0LTn6cBtj/0x543D5q3GSUkhguANhagJsxyTua0YyWXUYDkrbGX3+k4Jz6nR7MCvLdCPjdc4GuKxwBa93J6SGLWpnxjmQbDPQMBRZwXUD9oLZhjgAqIa/6g04OX81bUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dqlMh6fA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712306076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qm6TnS1OEfgYoeCHQolapAEQCWvFv3wqYvT2tGPeW38=;
	b=dqlMh6fAWHqwQjBDpZmbcY6AujJLTCJ3zdHs1NgX8cEo7k1/umqp5shc3nD3WxDjGVWUE3
	GUrFK0ITxEamFxGKbFrQM/RmHKQsgyF95Z39mu1u1X8XJJnHhK2qJlgM+m12kBgFQIAns/
	ijmR3INHIx/5yz8wkiwTWKdUtc+ScYQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-5iLb9Po5O4mUt1iQS8UY3w-1; Fri, 05 Apr 2024 04:34:34 -0400
X-MC-Unique: 5iLb9Po5O4mUt1iQS8UY3w-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-516ce9afcabso187859e87.0
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 01:34:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712306073; x=1712910873;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qm6TnS1OEfgYoeCHQolapAEQCWvFv3wqYvT2tGPeW38=;
        b=EF3SYFfSVp+QqSm0g30JS3RJyJCYn0N0dZx6uZRqUIaLZH5SrLMZWyFOJ3lQ3Ml+7I
         FSAdb6zKxd0prPvti7xCJNAGk+CdeXduZnu/03gQpMp/3Hq5Syp9ewPq6lerFTBou2wH
         tbb9Nf6K0u0Q/k4OzzneeBjW9Dgv7WnSFJxXp4ab+P+cxh25ntkKBxi2BNUFwbqKsVKL
         QF9KFSYs5cIO18o2083U5p4i5fdw0YYNhVn98Zh3bJ3lBVnz+VTPasTqtDCNOTYoAlmu
         gWHCW79xtTSkNXLhm9lyOlT8OSFKQ/ko1bmGwA1Q2JjJ6Uq+l+/tFl3m6AJMIoF1e21Y
         zK4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV485pUa4lsaks255ytjbrX1vanKirEHIbQLiRIHlhaziGJgz/0sO3jvtJsx1jBkCy6s3trpckS/tt9t/TQD/393X9lCZ/S
X-Gm-Message-State: AOJu0YyykRJgtmeTnU2Az7SUvGuQyiLNEHdhC+jk81VpJDSg0CzDW9Zp
	GcJlyTx3k5zxwSVxidWort7HQSP3gDhaTnzUN17kinqZxF5p3FTj77thP2N/8s/rGGrbR6nup3R
	XJdOOpk+jG9bGeZunM6mPx2ZhQK6egMQKkbCPu2ySPgAmZ2y0JKI//A==
X-Received: by 2002:a05:6512:34c4:b0:516:d538:d559 with SMTP id w4-20020a05651234c400b00516d538d559mr462237lfr.1.1712306073027;
        Fri, 05 Apr 2024 01:34:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwzObbsy85KEmqb+6x/QXyc3wKmM6tmRM3Sby2LIhrZ2yAgf82e4tcAjeWZXNnpyCpSfSdHg==
X-Received: by 2002:a05:6512:34c4:b0:516:d538:d559 with SMTP id w4-20020a05651234c400b00516d538d559mr462219lfr.1.1712306072560;
        Fri, 05 Apr 2024 01:34:32 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-213.dyn.eolo.it. [146.241.247.213])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d668d000000b0034354a99d43sm1457613wru.43.2024.04.05.01.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 01:34:32 -0700 (PDT)
Message-ID: <6b77ce4f71dae82a0be793cf17fac4fda0884501.camel@redhat.com>
Subject: Re: [PATCH net-next 1/2] mptcp: don't need to check SKB_EXT_MPTCP
 in mptcp_reset_option()
From: Paolo Abeni <pabeni@redhat.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 matttbe@kernel.org,  martineau@kernel.org, geliang@kernel.org,
 mptcp@lists.linux.dev,  netdev@vger.kernel.org, Jason Xing
 <kernelxing@tencent.com>
Date: Fri, 05 Apr 2024 10:34:30 +0200
In-Reply-To: <CAL+tcoBEkK-ncB6zdJrq7kkd3MEdyT7_ONOyB=0cVVR_oj-4yA@mail.gmail.com>
References: <20240405023914.54872-1-kerneljasonxing@gmail.com>
	 <20240405023914.54872-2-kerneljasonxing@gmail.com>
	 <a0e75cbda948d9911425d8464ea47c92ab2eee3b.camel@redhat.com>
	 <CAL+tcoBEkK-ncB6zdJrq7kkd3MEdyT7_ONOyB=0cVVR_oj-4yA@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-04-05 at 15:58 +0800, Jason Xing wrote:
> Hello Paolo,
>=20
> On Fri, Apr 5, 2024 at 3:47=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
> >=20
> > On Fri, 2024-04-05 at 10:39 +0800, Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >=20
> > > Before this, what mptcp_reset_option() checks is totally the same as
> > > mptcp_get_ext() does, so we could skip it.
> >=20
> > Note that the somewhat duplicate test is (a possibly not great)
> > optimization to avoid jumping in the mptcp code (possible icache
> > misses) for plain TCP sockets.
> >=20
> > I guess we want to maintain it.
>=20
> Okay, I just read code and found the duplication but may I ask why it
> has something to do with icache misses?

The first check/mptcp_get_ext() is in mptcp_reset_option() /
tcp_v4_send_reset(). For plain TCP socket it will fail and the
execution will continue inside the same compilation unit. The code
locality should avoid icaches misses around there.

Removing such check, even when processing plain TCP packets, the code
execution will have to call into mptcp_get_reset_option() in the mptcp
code, decreasing the code locality and increasing the chance of icache
misses.

I don't have actual profile data, so this is an early optimization (and
thus root of all evil), but sounds reasonable to me (yep, I'm biased!)

Cheers,

Paolo


