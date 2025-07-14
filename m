Return-Path: <netdev+bounces-206720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46821B0432F
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 17:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B1744E1654
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 15:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEE925C713;
	Mon, 14 Jul 2025 15:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ETBqISfH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEA425A2DA
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 15:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505949; cv=none; b=fRP7gyfu3wFqHUyLDIG2H8XuJRmeXHlYbLJWhOccoCMKygtydDjU4mHfHyOd2Xpkpzu1tei2Ezr1/ZbQ/kIdWej2iub92jUHf47dRKpEtyPIUel1zuMi7UwYER2L4t1UIBHvZx7P4ssoNQqsBOCbXa2Uo2OBAQp7V942tk0u3jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505949; c=relaxed/simple;
	bh=nUBsyJw1CVVySBdkscf0wKBNx6+3aTki+UmriA4CZ7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QH3Lie73QfvTPrTxhYS6k02SbrwnbiI0yYHmZ8glNlGcL+SySMvKXc1yc+Cn2fEUPCng+/4KCTDB1bSF4tVHvT/ki0jp7nR1JH0UDN3p+fMJiaPFm6or48Ztp7CC5FEYi8rcbVHyHsW4jDBITCCU0CVaroTlFs3OyBvhJ8afr6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ETBqISfH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752505947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MByh1M8hBJM6ZO7YZ21H+SItyH0RTixPX6ghJ1VgS10=;
	b=ETBqISfHJY3VDnaAVF83crtiScZNbQl2mOMgLQwbygjw8nRJVOBEw00d2lnzbi8zGVJlte
	a0l+fuXQcgI3+goPlRfDP3p04U5MTJN3fHqu+efSehBPoeRN4UmdfuAlsp3pcmq5JuDU7l
	57hTICfxvn21Ia18H/09zhcIkDoFSSo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-Bat7G34KN4aEA43tgel-RA-1; Mon, 14 Jul 2025 11:12:25 -0400
X-MC-Unique: Bat7G34KN4aEA43tgel-RA-1
X-Mimecast-MFC-AGG-ID: Bat7G34KN4aEA43tgel-RA_1752505944
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451d3f03b74so25477665e9.3
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 08:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752505944; x=1753110744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MByh1M8hBJM6ZO7YZ21H+SItyH0RTixPX6ghJ1VgS10=;
        b=SbafuTHf/b9xHtSUdvB6ONHhrn0zu1oJ6R+u4FrlYqsf3JGmsLdlTW4mOfVO0qk+dZ
         X4dsY17d2i/KO3ctDXuL6vJcBDYpZs21N3S+FVvcYUCNikon+pK9nkpDhC6xmoqLvbAl
         9DgTAPO4S8iJMM2fG6wgcpJMY3iMXadFMLf8yR5BjTQs6V+a2L0XG3gYJFY60V4m28oa
         nkoK79gfmEkCvQQZ8qMjKb6yu6lqd9clLknX5sMEo8iPRQQttjX7DLgK8U7L9FjtvV6k
         XW7P8PzaJZ2MK4Niy9nEDwj0TG30jh/HfkWgjF14pvzB/9y6cYbyebUTY3GtYZW52VM7
         5TWg==
X-Forwarded-Encrypted: i=1; AJvYcCWN2DTD+yGNgIH8LyC45XZE4YrXuVZ31LB6OAPv9HKqw03df5S489bT+WirF7vQoJ68k8bVd+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfh+URf+bFOjMeoymArhfaWJj9EgyLxuHym9s2nlwayHp8LKOt
	str2P3hwCRY5Rx9Q4VYx0sDQU1ngEdym4N1hpn3mZH5XQirS+rG2IRBnWk+EIrDL9HFsYoCzGG+
	7JzSQ1qy2VrA+7cPT3GFUDg3PVKfLc2ZEzR8hqjzxZEPjfG0UAsxP4cvamA==
X-Gm-Gg: ASbGnctDuIofSlhT0qIQkG83QP8p95XzhRRFgohiRM5UnrZfTL/kCrMGwRUViGWEsjK
	uCERhQugdtLZxRPbFg1FjKbpkx5hjySxEiB6TqMu01Zb8+sLXn3egacRHaWUAuHhVkxpZGSJ4x4
	2w0l/Qd7f6S8wQpkw+euF60gk3RwaxsrfuylSw2Vyd+jzAFDkIcLUYs1PPxc6W9qlZ3vkWltDbv
	yirguBfrP0btzupIry2VskPikF/mgLrSXcCkUNDy76BjYTqtBPr8t6cxmP/GLmpsUjoLT2qi+3P
	6+JGcEEDaIj6h6nJhCAQqMvYCY/SHWv4XSJ4ufcjd+U=
X-Received: by 2002:a05:600c:841a:b0:456:1b6b:daaa with SMTP id 5b1f17b1804b1-4561b6bdd3amr38487995e9.29.1752505944241;
        Mon, 14 Jul 2025 08:12:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGI8sx2a/TCHL+bqItM/OhugxGKDQcaU6p5roxACLJIP/WtAGE/GxnvHPR1UMcQFIC+o2xoAQ==
X-Received: by 2002:a05:600c:841a:b0:456:1b6b:daaa with SMTP id 5b1f17b1804b1-4561b6bdd3amr38487625e9.29.1752505943842;
        Mon, 14 Jul 2025 08:12:23 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.155.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd56d936sm117404425e9.0.2025.07.14.08.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 08:12:23 -0700 (PDT)
Message-ID: <e3bef5ed-535f-4ce3-9ea4-f6a40df448ff@redhat.com>
Date: Mon, 14 Jul 2025 17:12:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 net-next 12/15] tcp: accecn: AccECN option send
 control
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
 <20250704085345.46530-13-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250704085345.46530-13-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/4/25 10:53 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> @@ -1151,7 +1155,10 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
>  	}
>  
>  	if (tcp_ecn_mode_accecn(tp) &&
> -	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option)) {
> +	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) &&
> +	    (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) >= TCP_ACCECN_OPTION_FULL ||
> +	     tp->accecn_opt_demand ||
> +	     tcp_accecn_option_beacon_check(sk))) {
>  		opts->use_synack_ecn_bytes = 0;
>  		size += tcp_options_fit_accecn(opts, tp->accecn_minlen,
>  					       MAX_TCP_OPTION_SPACE - size);

whoops, I almost missed it...

Please call READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) only
once, i.e.:

	if (tcp_ecn_mode_accecn(tp)) {
		int ecn_opt = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option);

		if (ecn_opt && (ecn_opt >= TCP_ACCECN_OPTION_FULL || // ...

/P


