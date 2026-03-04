Return-Path: <netdev+bounces-263857-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFVxA/tRqGnUtAAAu9opvQ
	(envelope-from <netdev+bounces-263857-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:38:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEE4202EE6
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 290D130F5FB4
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 15:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2D53321C8;
	Wed,  4 Mar 2026 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEfp5Ept"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5203B3328FC
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772637617; cv=none; b=YX/KDVNLOOuwZzRdKkinvdfSJmxc5Ndc8kZmHsfdZqahrEH9am8wP7XQM6+7JmJxN7rPNvTEPN95BUGIIrmPE6ekTDpUp8fOAsL0OgHYTf0XFIG8MhuvovFLb5Dkmfu+REibxdlaSLYgIaBilkZiPG8rSQoFwgQg2yLgcpVPjZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772637617; c=relaxed/simple;
	bh=xsk8yFUEc/W6lEaizHfwWc0dfqE5kqPRC8JIECszDBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SOBIJxHTf77l7f28rxugKUyjD7jKUcSxWkfub7KrGOZiFqeutKXad8Y+96DE+TgervdhpkB2IpaUQDtcwi+5GqyNMfJgRj7PRT19p+XAHs/C5Ab3+5CTNJnNR/hskrjQAdQoV1818Gpd3Oo57Oh1kjFFPxhkwSU/T1Q9rl/m+hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEfp5Ept; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c70b5594f4so719716885a.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 07:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772637615; x=1773242415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g+ReRhrlTgHhhDoolWoz5yaEOSPYBt3wvjBVfMBKeVo=;
        b=YEfp5EptY87/LDQGEVvpCKYvYxjOd9sSRFhzEpORiG3zNfz46iWiB9WvoPmomULIs4
         NpPjS6S2rPL8CgdMc/iW9vGYZT+J+w2jYl5DiTHIvV6t2+IKe0G3LdI6BQDqb2gM9Ztl
         eds3tMgnYWJr5uQJqFHkSVt/aDrQxynacvngfrXxHbCtS5mWbVtmw4ydsEy7oDr92dsG
         F3ZfDQGhVeEDdfQKXDk1yYfiP1rCkHtRZvifr+2uw91F4TooLQ3UqVA22isvC57Cu8lu
         ssvG1wnwNEYygd8e8T1/YlcFtJlnM8pO0iI0qxEC5bFnb7meKdM5JQvqrP4ZC/fyqm/c
         08pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772637615; x=1773242415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+ReRhrlTgHhhDoolWoz5yaEOSPYBt3wvjBVfMBKeVo=;
        b=ETX0TiJumGH/dCYWcTO56dQlfcu8dzx9dcMdkjmLg1CyPwhvKgC/V65IEGAWOiP1ts
         hiiQEz8hA0nMit50E5oXbCIZEaMRTeln7PEaJqA40M1C8dQXJk4+RPGpmNz11o0E8j1L
         QDjMPV5x/mlGCJsMnRrzPA1I05M0SgBjMfe3SzIBRu4NVZHVnmCPCVDfdm7DW3950ZDu
         guQ7tvM3WYOvmNiZ6aRL7EtZK72IF+nUG4MCwY0asYuO/BajtoRJR7dp+50GrLv5zANR
         77caIWNXZwDcOey2FBxXe/exGQvGHVnXMExT4DxfyFphUmdYIOkyJWoj2ICqstaROdae
         AedQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEWEq2XfPj4EwWf5+i4WjGVlAQasnK2dE6t/HVmshFPeiL1U11jqxmuxNe+0wcH2ypL7+ZMGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLigJ0NxzV3qr0Wpp7C81a9JtSLeloRTBVBAjzg25QAqDc7S5Y
	9E6pptd38F8VtJQQhKPxjqvpfOXnBI4Q3k1PqeTfplnK3PP42TE77hLk
X-Gm-Gg: ATEYQzwmGJAcVeWRKpzhcbNkWMDnk8dNWhCFMfqNUXJgjBwAs6jPXiUOIMWiteIGmsG
	mFKyG3MTY4wAKJ0YZYv7pHg8L7jAMY7PmXvOLR6RVg3CaKAgqV45wUPF0D5oxg9XgWI4/POZKiJ
	E6+QVlEkFvTQmdeDf0aOQqnKa0TbiJzSwEF3q1y8jbr8sRSfmVhO6abfHn2FTwrtJFLwsQuVFb1
	hLAdIXlUjOiYRnPeUXFsc2WytxE7ZJa9K3XdSLFisLakpjyCHzhCrpPuJ5DwCYwmFvpVxF3Tj03
	e+xPb6uUY1y7yIppLaecqC8t5FUFdNjfXP8DSfUvQfE/hvXv1luZHnhNeGJ1cAff4un2oDSs5Cg
	/REg4jpFjFse3iaKz0LY0+YoJI86ZcSvaOJz5DmOT2X1pQZYaUP+nI3cdXoqt8qfT10QNCq1AA6
	3QhihoBlQBvhphtp98j1ZTIuC2uF1ZUTSbtFWcrPYcSWid/9rXA/85
X-Received: by 2002:a05:620a:1712:b0:8cb:3d57:2447 with SMTP id af79cd13be357-8cd5b294907mr235642285a.17.1772637615250;
        Wed, 04 Mar 2026 07:20:15 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1145:4:d19b:d485:ed5f:e15b? ([2620:10d:c091:500::3418])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6f93b5sm1642631285a.31.2026.03.04.07.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 07:20:14 -0800 (PST)
Message-ID: <dba5daa8-a8a9-4431-a7a4-543aab28120b@gmail.com>
Date: Wed, 4 Mar 2026 10:20:13 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 6/9] psp: Add new netlink cmd for dev-assoc
 and dev-disassoc
To: Wei Wang <weibunny@fb.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
References: <20260304000050.3366381-1-weibunny@fb.com>
 <20260304000050.3366381-7-weibunny@fb.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <20260304000050.3366381-7-weibunny@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6BEE4202EE6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263857-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[fb.com,vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 3/3/26 7:00 PM, Wei Wang wrote:
> +int psp_nl_dev_assoc_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct psp_dev *psd = info->user_ptr[0];
> +	struct psp_assoc_dev *psp_assoc_dev;
> +	struct net_device *assoc_dev;
> +	u32 assoc_ifindex;
> +	struct sk_buff *rsp;
> +	struct net *net;
> +	int nsid;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, PSP_A_DEV_IFINDEX) ||
> +	    GENL_REQ_ATTR_CHECK(info, PSP_A_DEV_NSID))
> +		return -EINVAL;
> +
> +	nsid = nla_get_s32(info->attrs[PSP_A_DEV_NSID]);
> +	net = get_net_ns_by_id(genl_info_net(info), nsid);

I think this assumes assoc_dev is not in genl_info_net(info). Perhaps 
this could be made to work by adding a self referencing nsid, but I 
think it might be less complicated to have a path that deals with this 
case directly.

