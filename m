Return-Path: <netdev+bounces-232409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4005C05861
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 12:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7809A3AD56C
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 10:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D99230E0CD;
	Fri, 24 Oct 2025 10:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avMbqJ+Y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEB730EF85
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761300581; cv=none; b=NA4GnVq1s5Y76MJ0ToNQxgtOM7KcKdckRUH93jbyc44/lFSRaPJFTD3KNX+u8rV2G3HARyhfNl/oc5mHbqJeHRm2PmEvXDs+QfC6MJryui4uNyRfwN4hkgnDovyfZLRPwqumPMKpoXoZIzqPcZmDgTqPVtGgwFp8q7uwSyV/HTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761300581; c=relaxed/simple;
	bh=mPv7qNpbkKREJr3IMSWaJ1CVH7jFqTHRHwS+I30+elM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aocuEOF3oZ9XZR1sZoXIcfRT9aOQtjs9ErTbi9vh1lunAIwQJUP4wSeGf8IB+ft1NzbnE/vg2NmAMIMoTGQU98Rgv6+c1STdAFjBg0z/P++CgY2K9X2Twg94ZQ5RVZ6jTF+NypuvphoIDH9A0Kj5SAacSoVvbvSIwmhWj+fa0sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=avMbqJ+Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761300578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x9CXYJKGjKQ5M63OGlLukH/RVv72WAJ2HVbJp9JVuWw=;
	b=avMbqJ+YVlrazSHONF6ob54QVsfPZqiTK5a3FihK7qB6xbfswvlegUCuPZtIpqUbADiQVz
	cuiarGB3b59S3h6N3OskqVDQLn6ehq8l8jrCT5eOIum0reNy1FtFwKeZWDlHCphbXgSTe7
	LTb8BaX74NdKOWkBZ4crB0MOYWBLmyI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-1nJZCgjhM5yU6R1BsU-pig-1; Fri, 24 Oct 2025 06:09:37 -0400
X-MC-Unique: 1nJZCgjhM5yU6R1BsU-pig-1
X-Mimecast-MFC-AGG-ID: 1nJZCgjhM5yU6R1BsU-pig_1761300576
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4710d174c31so19922105e9.0
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 03:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761300576; x=1761905376;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x9CXYJKGjKQ5M63OGlLukH/RVv72WAJ2HVbJp9JVuWw=;
        b=sX1gVSrHnsRajQDOwYEZ6qpWOnzwQK1NUhtvrRxiTcy7vg9iqS+bTylwxjcMUtZvfZ
         wHS3io18nlD8+/Q8Jrx95nCLBzumccdOHvOexmU5KjfqhRxTlsNT5MceWzty++TVpFSC
         nXbcD5mITARIR01OvhIWVz5AEnQhplPg0i2nb/bwJdSa3JFS7NGU2V7YTVSFFOaBQprD
         qiqn8d3fwWgM/Sfcdme0503VFozoMcMSwhItd3HYGTfcBC1sY/f5GVylyVAUMlcybuUw
         5itWTVZpm7VN0gDwkig7MuUslrpYPHBTyLEBApT7TLGWnpG6tNCn5vHtbMpJ2V6jRPrg
         oIGA==
X-Forwarded-Encrypted: i=1; AJvYcCW/zwrbQHqfnKCDAC008bOtLEtNRy12MJU9z1OtHX5FFY4wWotLKFqHVt1Us549WvC/lTqBm2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/yD3r5w+oZjVukhzNWQmlGVOeMHCEpHH94vJgWf2yi1tLxK0n
	KDXU+3n+rJZp/0ngLXrEBgeJPaYlvzvRMylD+Vb6LtGRzQPXU4lVGB4SAsPVypdVA7ShIZNteRP
	yfDPSxq7u3Ksam4UC4YuqTtKrBXdJqtfCr/z1JPqcMoL6TVkpgklT9sam6Q==
X-Gm-Gg: ASbGncvpuNkJVxHC2xB9AofaMRiVyOLJeEdDHxvsYs9e+PoAw5+HINejbYTYX3siWDG
	wI52ezOKuqPSlyrIJ89lr6T7SeMFRzF5zCmQ73r2qtP+NvR7K+7HPHCXPc9pGP61l0efXtvyHpZ
	b2VtFSLTXwtOZg6tLDt84qTpYCR7mXEiOVbNdFtzGVgUja50U34cVTDUBocax5nF8xnl7fmAxDo
	Q2zn+n6pWzHNGYLOgrOHcDZu++DxpVGg+nhddUI9nxsHf5PvH6LfEm4SvbfGMmosh4ilnKF9MeA
	7U0Fg20mXM1X5WPRZmRF8Js17NebdHAsTnrl06lJOwF18lmucUjqmITKw6gKg0VeoVqJftewTdv
	HNUq+T2XX4GPBdb24HgIFxPBfAyIjAXXJhHJsacT0Hb2Ldhw=
X-Received: by 2002:a05:600c:811b:b0:471:14b1:da13 with SMTP id 5b1f17b1804b1-4711787dcfbmr193695645e9.14.1761300576433;
        Fri, 24 Oct 2025 03:09:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETibeIrtl42VoQ+Lk0GbrYT9Rg6ea/LmRSPEcN9uxfU4nql8d+aEJiYQz1MNcmdV6aSuIPeQ==
X-Received: by 2002:a05:600c:811b:b0:471:14b1:da13 with SMTP id 5b1f17b1804b1-4711787dcfbmr193695365e9.14.1761300575998;
        Fri, 24 Oct 2025 03:09:35 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898adc81sm8542515f8f.26.2025.10.24.03.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 03:09:35 -0700 (PDT)
Message-ID: <67abed58-2014-4df6-847e-3e82bc0957fe@redhat.com>
Date: Fri, 24 Oct 2025 12:09:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] tcp: add newval parameter to
 tcp_rcvbuf_grow()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, Matthieu Baerts <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20251024075027.3178786-1-edumazet@google.com>
 <20251024075027.3178786-3-edumazet@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251024075027.3178786-3-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Eric,

Many thanks for tracking this down!

Recently we are observing mptcp selftests instabilities in
simult_flows.sh, Geliang bisected them to e118cdc34dd1 ("mptcp: rcvbuf
auto-tuning improvement") and the rcvbuf growing less. I *think* mptcp
selftests provide some value even for plain tcp :)

On 10/24/25 9:50 AM, Eric Dumazet wrote:
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 94a5f6dcc5775e1265bb9f3c925fa80ae8c42924..2795acc96341765a3ec65657ec179cfd52ede483 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -194,17 +194,19 @@ static bool mptcp_ooo_try_coalesce(struct mptcp_sock *msk, struct sk_buff *to,
>   * - mptcp does not maintain a msk-level window clamp
>   * - returns true when  the receive buffer is actually updated
>   */
> -static bool mptcp_rcvbuf_grow(struct sock *sk)
> +static bool mptcp_rcvbuf_grow(struct sock *sk, u32 newval)
>  {
>  	struct mptcp_sock *msk = mptcp_sk(sk);
>  	const struct net *net = sock_net(sk);
> -	int rcvwin, rcvbuf, cap;
> +	u32 rcvwin, rcvbuf, cap, oldval;
>  
> +	oldval = msk->rcvq_space.copied;
> +	msk->rcvq_space.copied = newval;

I *think* the above should be:

	oldval = msk->rcvq_space.space;
	msk->rcvq_space.space = newval;

mptcp tracks the copied bytes incrementally - msk->rcvq_space.copied is
updated at each rcvmesg() iteration - and such difference IMHO makes
porting this kind of changes to mptcp a little more difficult.

If you prefer, I can take care of the mptcp bits afterwards - I'll also
try to remove the mentioned difference and possibly move the algebra in
a common helper.

Thanks,

Paolo


