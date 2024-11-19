Return-Path: <netdev+bounces-146124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EFE9D20DC
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 08:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD03FB22566
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 07:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224EB19753F;
	Tue, 19 Nov 2024 07:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGyb5G9H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D64195980
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 07:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732001973; cv=none; b=KyOjLZWvs9KKtYnOurkWWXZSMe9359mYpBCdfgoPOs0j86RqFT/3qB0LH3w9q6j5amuebSkT9q2TS0t2f+QvhSXHjSmXwHEP2YvmovIeiQOBeEGunyiCt/2dOJYadYLWeFB+dJkJq+5yUzMONHfR3PZ1gbrC/pHHftQONu2AaK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732001973; c=relaxed/simple;
	bh=y1gxeSdXa+OLNye8QRgDA6O9ga1141pXBFTenAFEcgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YI1g+dUwY7tnR2QKIHRzXU+EL3swV8r19wrxzMtOPiDBSX5Cl/edxbY1rBf960+UXomDenVzrrLdPErp45v0ATdnTqWUSEiMJZmxKXsdooJK56/SbTYSP3ehJ1cVAavcWo684BwiwEQyJzmYxPn2UL+f5CKj/Doy73nbYceNs7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGyb5G9H; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-72410cc7be9so555934b3a.0
        for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 23:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732001971; x=1732606771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MaztIjURTwWWaAImR6bdQDGzzjM7w9GvnLtOtZbUhPM=;
        b=gGyb5G9HT8K1l3c1/cjfT1YsJkOafRkYDLNL/64zTc7XKN3uW4dguLGeCAI9CiPLhm
         dLNMMf/Q+FiuG6adaqFM44/30o2T5DTNnY6A1Dm4eCqckw7DMk9MLnPMcHE140k0y1Ak
         1SOT+ugf4WX/2GLfpVBZY97GavmLoPJVwDxI1a64UAvbzuVeLa9KBtJiXknalKN1Du7J
         LX14rjghArv8vmZMYJz5F0V97HZFmIEOZ3zigCXZ/mOeTJs58b+U7Xd4FxQD7mYpeDmh
         uQktQRbp4v+Z3Z/bxwgpKB20OF88OQogl4Ka8XgiBFSMmHiaEHHUVh+VheXi9uiskvDl
         cCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732001971; x=1732606771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MaztIjURTwWWaAImR6bdQDGzzjM7w9GvnLtOtZbUhPM=;
        b=jpMFN6tIcfmhj/MPVynpNGZgp3I/IPg+4BE8mML5oBmYn1jhcsKbLD1xRcXiRwodGk
         VEf2oipPvuI08HfzpErEEfPczz/MQqibjA8EigQudWfk9DxrnlgcOuNe5H+Z231ytGWC
         thPPO1niPYlTzBuoE6VwGpb16RamWo5pcX4VTETh1geD5FZD3G5pEjR8/dlwcG1l8vMB
         5b9JE54HOzzFH/4zVCzI+EldsCRZG/afe8zMpgqTYAYTUfX7mWIOw3GqVquvzCWFhUmu
         jx6iC/i9/2gNu4hMF8A2/6Nz4S6+Uw+wap/B18TzJ/3CJJsaTs34zDuyznNMgfbsDQHm
         L/Ew==
X-Forwarded-Encrypted: i=1; AJvYcCVuxcc9EV67hLYwsyl8z6zqw39VAQhVXUQNTJlBxUE48KKsNatZ2Cox32aeZV/xqNycdu6t94w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqBgMEx/KHbpdmIpNiqkgF4HwHH1XBfarC37Oy1bXyp54Qn7mW
	IATsAB8nEBdpTUwHfqoHUIB9fTp4bOWxiuW9AfUmskiWNJvTJicL
X-Google-Smtp-Source: AGHT+IF+VONEjHfQK0sUiFNQIApwTGmUebP5Tm25zJ2JGV/YIwYM104ILvmiPGjwcO4woYqBUu3jTQ==
X-Received: by 2002:a05:6a20:7283:b0:1d9:2b51:3ccd with SMTP id adf61e73a8af0-1dc90af1fc7mr23826606637.7.1732001970946;
        Mon, 18 Nov 2024 23:39:30 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7247720c2e2sm7228672b3a.196.2024.11.18.23.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 23:39:29 -0800 (PST)
Date: Tue, 19 Nov 2024 07:39:22 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	roopa@cumulusnetworks.com, jiri@resnulli.us,
	stephen@networkplumber.org, jimictw@google.com, prohr@google.com,
	nicolas.dichtel@6wind.com, andrew@lunn.ch, netdev@vger.kernel.org,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
	Lorenzo Colitti <lorenzo@google.com>,
	Patrick Ruddy <pruddy@vyatta.att-mail.com>
Subject: Re: [PATCH net-next, v2] netlink: add IGMP/MLD join/leave
 notifications
Message-ID: <ZzxAqq-TqLts1o4V@fedora>
References: <20241117141137.2072899-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241117141137.2072899-1-yuyanghuang@google.com>

Hi Yuyang,
On Sun, Nov 17, 2024 at 11:11:37PM +0900, Yuyang Huang wrote:
> +static int inet_fill_ifmcaddr(struct sk_buff *skb, struct net_device *dev,
> +			      __be32 addr, int event)
> +{
> +	struct ifaddrmsg *ifm;
> +	struct nlmsghdr *nlh;
> +
> +	nlh = nlmsg_put(skb, 0, 0, event, sizeof(struct ifaddrmsg), 0);
> +	if (!nlh)
> +		return -EMSGSIZE;
> +
> +	ifm = nlmsg_data(nlh);
> +	ifm->ifa_family = AF_INET;
> +	ifm->ifa_prefixlen = 32;
> +	ifm->ifa_flags = IFA_F_PERMANENT;
> +	ifm->ifa_scope = RT_SCOPE_LINK;

Why the IPv4 scope use RT_SCOPE_LINK,

> +static int inet6_fill_ifmcaddr(struct sk_buff *skb, struct net_device *dev,
> +			       const struct in6_addr *addr, int event)
> +{
> +	struct ifaddrmsg *ifm;
> +	struct nlmsghdr *nlh;
> +	u8 scope;
> +
> +	scope = RT_SCOPE_UNIVERSE;
> +	if (ipv6_addr_scope(addr) & IFA_SITE)
> +		scope = RT_SCOPE_SITE;

And IPv6 use RT_SCOPE_UNIVERSE by default?

> +
> +	nlh = nlmsg_put(skb, 0, 0, event, sizeof(struct ifaddrmsg), 0);
> +	if (!nlh)
> +		return -EMSGSIZE;
> +
> +	ifm = nlmsg_data(nlh);
> +	ifm->ifa_family = AF_INET6;
> +	ifm->ifa_prefixlen = 128;
> +	ifm->ifa_flags = IFA_F_PERMANENT;
> +	ifm->ifa_scope = scope;
> +	ifm->ifa_index = dev->ifindex;
> +
> +static void inet6_ifmcaddr_notify(struct net_device *dev,
> +				  const struct in6_addr *addr, int event)
> +{
> +	struct net *net = dev_net(dev);
> +	struct sk_buff *skb;
> +	int err = -ENOBUFS;
> +
> +	skb = nlmsg_new(NLMSG_ALIGN(sizeof(struct ifaddrmsg))
> +			+ nla_total_size(16), GFP_ATOMIC);
> +	if (!skb)
> +		goto error;
> +
> +	err = inet6_fill_ifmcaddr(skb, dev, addr, event);
> +	if (err < 0) {
> +		WARN_ON(err == -EMSGSIZE);

Not sure if we really need this WARN_ON. Wait for others comments.

Thanks
Hangbin

