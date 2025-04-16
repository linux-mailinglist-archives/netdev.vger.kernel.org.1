Return-Path: <netdev+bounces-183167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF3FA8B3AA
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E881B7A218F
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 08:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF8D23370D;
	Wed, 16 Apr 2025 08:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MK8dOefb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B53922FE11
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 08:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791785; cv=none; b=ewSQovQO/fPhSjzIeLgy81aCu8JYKy2pulaBn7cJ47N+tX5xy19I6oUFU7mmZTqAFjetuFmWSl+gYBOYXE9w3FAqPOFNWPL3yqi96iMha5bZ7KdNWdcHHwuu1+7CIiiPIlU/4Kqc+Aw3dHFMSIAqDMMGjt85nTJZocHqpSDiGZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791785; c=relaxed/simple;
	bh=wXmwsQQp6Vwg4oaQutbdG+rNrGjG26mnk2yUGKGUuCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wqe5vKsD3aKdP4zHxyHe09LTE7zUiyRlDdlh08MoM7gcno0yKgkFczrIredOX6NURknNQIxrJcqbUhjfJs+QViK5fF8+LVvr/SD4D9ackl6vAtq5f3o0LEZXio2GLPrUsUQ23x7Yf6CPOjmkk/rP81ZuAbtgo36pswNRP124o+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MK8dOefb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744791781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bY9TBhLj/RdTbyW1EPeC8znilCVFFCdnICLbP/FeQ3w=;
	b=MK8dOefb1JzGdkT6rV7O/Yv94eSTGWyWTWKj4KvptEAVNzYdKYxQBpM3adML7DovO7O5aH
	N0lob0U2wUeX2XWt1Nqw5jXpZz2kNi8yCLKxMipvjNEmI8DkdI0b47sjeoQFTGtArLJwJK
	R82JkG3Lh4cVDTuVVkKepM6a5yfLQ8g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-JCibdM8jNlustNKUTKxK9w-1; Wed, 16 Apr 2025 04:22:38 -0400
X-MC-Unique: JCibdM8jNlustNKUTKxK9w-1
X-Mimecast-MFC-AGG-ID: JCibdM8jNlustNKUTKxK9w_1744791757
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43ceeaf1524so2542085e9.1
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 01:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744791757; x=1745396557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bY9TBhLj/RdTbyW1EPeC8znilCVFFCdnICLbP/FeQ3w=;
        b=usQv/sBVmGp0HFIsSyKQ/cWuPs/Pp60jXj2a9jucZyQ0p+dm7SIujUN/As6H7Bfp6r
         RsljoXEcPZGROa+pYUUaeYsAwQ7o1zGOcKrMvS1y/kHvbYYfDJkPOgp4+v04lJ5eSZjQ
         705QUNlBNHS/Pm3NGvRt57rye75hUhRfH6NPOmR8hpRwFbyKbkua+XyTGQ+BKSEhpSIy
         cw5ZP1nAtBJA8ZcurOoBiZ+QBPeHrijxFgYOpyUQAmJkmknsr1G4QRltTZbmr9DpG4js
         wpIQCYVgXAROEIFTGsrfA/ulym87cyak9S0Zhz9WL/RywYHn4BA75Dri+3YsxEf2QF7q
         SUOA==
X-Forwarded-Encrypted: i=1; AJvYcCXTN/WoDVgeNh532RCsq/x3Fs2U3EtoisDWX9r1KmyxpEbfamklrmQtiVze2sjqN5gZcXbhgtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmfCGEG84i0Bcs5VcAHwGIU8Q//9YIBX7hh4eu/ylyTesGJrbi
	QuzJOlpxQfZyicYH5fzQTIPUDIMIGdq1l+Rr5bfrBmlAL7ceA5AFQ/qOxiJX4pf9V2WpXmcSCWw
	8HcmdmWrHEagpmJRqA/uQG9lMjexNpJ3j89sSrKI+ApK4937jT9XNIgNRBc2EBg==
X-Gm-Gg: ASbGncuBPo3rmzDoh/P8FopKdWxS+oehaRG7Bjsv7AeeUFkq0qFKO7hF5QBOz7XBXn+
	BVUNAHRi/sc8fZTUQKssYK/8aJd7y6jlmF/0esa+pCaeNV6IVkx8tMDxLyiryMv6qZ4IkuJ1Fwb
	crBOS27Ub1lyGZ3RLTbTFN1r8tIdhnYholVIWzdXsxCHD5LGmj98qHLB6wHj348jIRW1pzC2wGG
	TBwemqe1p4SxK4DeFO+6+Cg96Ft5fTLE0bn1a9j3RI6IiokTHnjdT3qFtvKgJEbuHBiBgbSLo6H
	kQQJYVibHYMPDPbZWdcKF2Q1MRMkl4BBWxsSQPI=
X-Received: by 2002:a05:600c:4d0d:b0:435:edb0:5d27 with SMTP id 5b1f17b1804b1-4405d77678emr6818115e9.9.1744791757110;
        Wed, 16 Apr 2025 01:22:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0pvVTEAUKKfXCgGK32tBmm8PNXfkA9kHafJpQ6A58Vd+BFkNGUGdMx6Zrw9t3nW+aGSyWPw==
X-Received: by 2002:a05:600c:4d0d:b0:435:edb0:5d27 with SMTP id 5b1f17b1804b1-4405d77678emr6817925e9.9.1744791756755;
        Wed, 16 Apr 2025 01:22:36 -0700 (PDT)
Received: from [192.168.88.253] (146-241-34-52.dyn.eolo.it. [146.241.34.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b53f29fsm13577605e9.37.2025.04.16.01.22.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 01:22:35 -0700 (PDT)
Message-ID: <37b0cc42-69ea-42bf-b4d8-304cba0d2dd3@redhat.com>
Date: Wed, 16 Apr 2025 10:22:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 net-next 01/14] ipv6: Validate RTA_GATEWAY of
 RTA_MULTIPATH in rtm_to_fib6_config().
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20250414181516.28391-1-kuniyu@amazon.com>
 <20250414181516.28391-2-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250414181516.28391-2-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/25 8:14 PM, Kuniyuki Iwashima wrote:
> We will perform RTM_NEWROUTE and RTM_DELROUTE under RCU, and then
> we want to perform some validation out of the RCU scope.
> 
> When creating / removing an IPv6 route with RTA_MULTIPATH,
> inet6_rtm_newroute() / inet6_rtm_delroute() validates RTA_GATEWAY
> in each multipath entry.
> 
> Let's do that in rtm_to_fib6_config().
> 
> Note that now RTM_DELROUTE returns an error for RTA_MULTIPATH with
> 0 entries, which was accepted but should result in -EINVAL as
> RTM_NEWROUTE.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/ipv6/route.c | 82 +++++++++++++++++++++++++-----------------------
>  1 file changed, 43 insertions(+), 39 deletions(-)
> 
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 210b84cecc24..237e31f64a4a 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -5050,6 +5050,44 @@ static const struct nla_policy rtm_ipv6_policy[RTA_MAX+1] = {
>  	[RTA_FLOWLABEL]		= { .type = NLA_BE32 },
>  };
>  
> +static int rtm_to_fib6_multipath_config(struct fib6_config *cfg,
> +					struct netlink_ext_ack *extack)
> +{
> +	struct rtnexthop *rtnh;
> +	int remaining;
> +
> +	remaining = cfg->fc_mp_len;
> +	rtnh = (struct rtnexthop *)cfg->fc_mp;
> +
> +	if (!rtnh_ok(rtnh, remaining)) {
> +		NL_SET_ERR_MSG(extack, "Invalid nexthop configuration - no valid nexthops");
> +		return -EINVAL;
> +	}
> +
> +	do {

I think the initial checks and the loop could be rewritten reducing the
indentation and calling the helper only once with something alike:

	for (i = 0; rtnh_ok(rtnh, remaining);
	     i++, rtnh = rtnh_next(rtnh, &remaining)) {
		int attrlen = rtnh_attrlen(rtnh);
		if (!attrlen)
			continue;
		
		// ...
	}
	if (i == 0) {
		NL_SET_ERR_MSG(extack, "Invalid nexthop configuration - no valid
nexthops");
		// ..

I guess it's a bit subjective, don't repost just for this.

/P


