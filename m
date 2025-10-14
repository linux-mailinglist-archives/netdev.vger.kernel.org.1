Return-Path: <netdev+bounces-229114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA79BD84E0
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53E854EADB8
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C4A2E62DC;
	Tue, 14 Oct 2025 08:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="StxdurEr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A76E2DC785
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 08:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760432112; cv=none; b=kbu7//Z3NLz2tdMUfCkLS14I75ZgAh985Gwt3ntWY8Qd1if/Sr51BCUsw+vJwpde/1VVjdhkGyFFifLexCUTz00ndYo7KfPzKq4Y3QLIPGvPZhnHVUbmFSUxEMQBX67RdyHh75KGcwMhmromflsRjFZQ96d6aDH5LXRbpPLVESw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760432112; c=relaxed/simple;
	bh=XmVZxL3Grj83XcH+ZS+ytQRp6em9DeekCbOWgku9hIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hVd7kiab5i8R0SYqp+nHTTwVw42l49G/L+tDdf7xHM9ZoojHDST3nsmhLmfnVeQ6t7yXuhj5yFv8ba2S7ap23j46spwDZMt5mtkyRiwIjh3LemadcDO1BkzYVQ+w0g+DI/F93htW61iZ/DnyMITnTrBYEU/qJqtAFGwfQQmyVTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=StxdurEr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760432109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oqPRg2ro9xBxSN344p+L1BaUDWdpu8yzEem7qRevF4M=;
	b=StxdurErTIoq+NM1wwW/TnqHu/8aytOHZ5WFOOJcbmZ98gx59zfPUSz7FaTMBxyybx2skr
	RAq5rKrm4mDCZeku++WUxEkB/pq5sDl2oGGhI2Wm5zIRqyHmMRrvRdkDQM/tIzOMClbECh
	QHd+aOgyDzg3lL5vCrESwTID7/24T4A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-z3Rwr1oROGeL4Tnngyqi8w-1; Tue, 14 Oct 2025 04:55:08 -0400
X-MC-Unique: z3Rwr1oROGeL4Tnngyqi8w-1
X-Mimecast-MFC-AGG-ID: z3Rwr1oROGeL4Tnngyqi8w_1760432107
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3fba0d9eb87so3157099f8f.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 01:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760432107; x=1761036907;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oqPRg2ro9xBxSN344p+L1BaUDWdpu8yzEem7qRevF4M=;
        b=QYXzuX13wxeUDUmEkcqyWmhk9Zf9uccR8r8886fk0pUTcahiOhcpL1pgouF/2qfrdt
         /bzPab7h8OhENXSRFwmgKPTr00f1Mq5ThiS2eaXAPV2yxN2l7Wlvm0uliSEq1sz/lMAN
         u1ZSfkbVUo4dxtA+CvtS1MJhAtQD5VHee8SXzj1fgwlYKOCwDAhTZeB2sTDvZTrWDTEe
         XJGORUvPWJ+COqqbihi9SnkToM5LT7eB/LWh4P1zBAGc+qDF0DZI7UlTzDh09qJ5nHOv
         Au2WEUZ9+QRuRteaMxys5ODwwap+Jnbda0C+7pZh+pXafCVXCB29ES9CBA5b26/NcDmg
         xeNA==
X-Forwarded-Encrypted: i=1; AJvYcCWBXcSn2RcYI/32QXI3GoRJP7gyzZDAK8bmNhEyEi+/rwobRgygKUjSRenQz4DXBnfaKdGlLiY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5uO7vwcyC25u89qts0EgtLirw/ejElt0DcYUGqzT67BJaFzeb
	i6MM6YjBKDxoKhQ217aFVXmqAaW/EDii3PhH3bHovrJGAQsKt6ugnS01qpCXd/Kho0zBV5KaOln
	seFdTBcMK8s5ox8kPWsWDl+2HD9HSdxwfHAnWUnUXbCibyGjdpTwlBVmo6g==
X-Gm-Gg: ASbGncvqyuZy4dQhn2StdS3k7HZsCK6o7Lqw+5IabP5kkhkURlSMo5x6UGmduAxmJVq
	MzWfvcavQeMPPEt5/nOyagSM5eL1ZdAfTEa3ejUY9RO5sut+y1SaYD9octkWdkYUnA+/pJTjwcA
	/4XkjEUUlqmlK0HoX9t7f5DcWxgajF7vt6FV9NamYW6xhwsEtxeYxmH/LbhRf7PnbdtD1Lk6HYN
	o5RS3W99/bHN1ww3fPKafwke6ky0SUWu3NJv8wtcSeD8fuTYPMVsYmy3XaCZ4POvlyCgDoLnJkw
	dmchiW0q9RyTPpgsR1Oiwv+kFAiZrQYIK9OQOoLD932dbYg58kzLfs+BRGUZRh0GCZOX24e2lJZ
	y42UvfeT6rI/f
X-Received: by 2002:a05:600c:3b11:b0:46e:59aa:cd51 with SMTP id 5b1f17b1804b1-46fa9a86409mr173314155e9.6.1760432106984;
        Tue, 14 Oct 2025 01:55:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHX8BWcTcunxn8A9kC7sxirtAX54R59ktx6EDeNPIPV0tcKePqF0T2wrbrVTpQwz92Plcrflg==
X-Received: by 2002:a05:600c:3b11:b0:46e:59aa:cd51 with SMTP id 5b1f17b1804b1-46fa9a86409mr173313855e9.6.1760432106631;
        Tue, 14 Oct 2025 01:55:06 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab36a773sm153672205e9.0.2025.10.14.01.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 01:55:06 -0700 (PDT)
Message-ID: <22bfd253-7d0b-4323-8314-5f4f49cc3dd0@redhat.com>
Date: Tue, 14 Oct 2025 10:55:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] udp: drop secpath before storing an skb in a receive
 queue
To: Eric Dumazet <edumazet@google.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Michal Kubecek <mkubecek@suse.cz>
References: <20251014060454.1841122-1-edumazet@google.com>
 <aO3voj4IbAoHgDoP@krikkit> <c502f3e2-7d6b-4510-a812-c5b656d081d6@redhat.com>
 <CANn89i+t9e6qRwvkc70dbxAXLz2bGC6uamB==cfcJee3d8tbgQ@mail.gmail.com>
 <CANn89iJguZEYBP7K_x9LmWGhJw0zf7msbxrVHM0m99pS3dYKKg@mail.gmail.com>
 <CANn89iK6w0CNzMqRJiA7QN2Ap3AFWpqWYhbB55RcHPeLq6xzyg@mail.gmail.com>
 <CANn89iLKAm=Pe=S=7727hDZSTGhrodqO-9aMhT0c4sFYE38jxA@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89iLKAm=Pe=S=7727hDZSTGhrodqO-9aMhT0c4sFYE38jxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/14/25 10:27 AM, Eric Dumazet wrote:
> On Tue, Oct 14, 2025 at 1:06 AM Eric Dumazet <edumazet@google.com> wrote:
>> Perhaps not use skb_release_head_state() ?
>>
>> We know there is no dst, and no destructor.
>>
> 
> An no conntrack either from UDP
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 95241093b7f0..932c21838b9b 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1851,8 +1851,13 @@ void skb_consume_udp(struct sock *sk, struct
> sk_buff *skb, int len)
>                 sk_peek_offset_bwd(sk, len);
> 
>         if (!skb_shared(skb)) {
> -               if (unlikely(udp_skb_has_head_state(skb)))
> -                       skb_release_head_state(skb);
> +               if (unlikely(udp_skb_has_head_state(skb))) {
> +                       /* Make sure that skb_release_head_state()
> will have nothing to do. */
> +                       DEBUG_NET_WARN_ON_ONCE(skb_dst(skb));
> +                       DEBUG_NET_WARN_ON_ONCE(skb->destructor);
> +                       DEBUG_NET_WARN_ON_ONCE(skb_nfct(skb));
> +                       skb_ext_reset(skb);
> +               }
>                 skb_attempt_defer_free(skb);
>                 return;
>         }

LGTM, thanks!

/P


