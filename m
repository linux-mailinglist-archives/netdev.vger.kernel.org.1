Return-Path: <netdev+bounces-150467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C939EA513
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 03:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DCBA1886061
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 02:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6689713D8B1;
	Tue, 10 Dec 2024 02:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXFEgb6N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4285A2AEFE
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 02:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733797551; cv=none; b=NbwdQ4ZzN7R7Un3BKTXgeotIJUKqHArmCmudMsjf/hRcCSH5CGxhZLoOUGbhf8//Zu1GkTLajUvqd/BTxM8k2YFpEdobaPNN8BL5T42zU2zbx8rNUMRgtC2Uc/LjaPSp0lxBv/iCQU1GYBb23s5UpxfvERBBuPMm3uwRCkZACR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733797551; c=relaxed/simple;
	bh=sNs17j2n43hURVBVZ6TNpMsEUuYtvpEeDbivp8qaO/0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RD0FNXe85b2nUh5CF0Zi/yT6mX/VOhbC070v6jVZ4CYo+h/9Qj8vXg86IOjhGde+Pi+K5joiV24ykSzvmjtHeneoNXQFgaJkJttqd1a/ufS4MjCsH3Erps/JbaOVxzdkKUF0Sz7NEJw3LhtiMfD1q0paB38/aZiZCZr7jrfqT38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXFEgb6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DD1C4CEDE;
	Tue, 10 Dec 2024 02:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733797550;
	bh=sNs17j2n43hURVBVZ6TNpMsEUuYtvpEeDbivp8qaO/0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RXFEgb6NRMxF5S+1eyrprUt/ezmBuha6KipezdphOxS78TqFdqZPCJzVqEhehcdrJ
	 4kFN2D6HEHDDie02suh+kw4yVBYdwNSs/Io8MK9cXUm3EDDkW3LKsAiqeCwdyCjoE0
	 AckVFzOXj+czwL4uFPtyZguISfSDORTLldurKOIQPQBd4iaAry6/dn5rvPHHr3loCa
	 LuKxfZJuE/6ENhAQWQNt70m0Ff9QnFiITbs9SR5u2khKBDQmDjdOBNqeCLhZsIh45E
	 NVfpLv4gaQSHfSD8xecmDSk9GxfhNY0fy+5auM0EqJY1BEYckOII0mwz9iTrNDoACU
	 pzHhKcQ3RJeWg==
Date: Mon, 9 Dec 2024 18:25:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org,
 jimictw@google.com, prohr@google.com, liuhangbin@gmail.com,
 nicolas.dichtel@6wind.com, andrew@lunn.ch, netdev@vger.kernel.org, "Maciej
 =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?=" <maze@google.com>, Lorenzo Colitti
 <lorenzo@google.com>, Patrick Ruddy <pruddy@vyatta.att-mail.com>
Subject: Re: [PATCH net-next, v5] netlink: add IGMP/MLD join/leave
 notifications
Message-ID: <20241209182549.271ede3a@kernel.org>
In-Reply-To: <20241206041025.37231-1-yuyanghuang@google.com>
References: <20241206041025.37231-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Dec 2024 13:10:25 +0900 Yuyang Huang wrote:
> +static int inet6_fill_ifmcaddr(struct sk_buff *skb, struct net_device *dev,
> +			       const struct in6_addr *addr, int event)
> +{
> +	struct ifaddrmsg *ifm;
> +	struct nlmsghdr *nlh;
> +
> +	nlh = nlmsg_put(skb, 0, 0, event, sizeof(struct ifaddrmsg), 0);
> +	if (!nlh)
> +		return -EMSGSIZE;
> +
> +	ifm = nlmsg_data(nlh);
> +	ifm->ifa_family = AF_INET6;
> +	ifm->ifa_prefixlen = 128;
> +	ifm->ifa_flags = IFA_F_PERMANENT;
> +	ifm->ifa_scope = RT_SCOPE_UNIVERSE;
> +	ifm->ifa_index = dev->ifindex;
> +
> +	if (nla_put_in6_addr(skb, IFA_MULTICAST, addr) < 0) {
> +		nlmsg_cancel(skb, nlh);
> +		return -EMSGSIZE;
> +	}
> +
> +	nlmsg_end(skb, nlh);
> +	return 0;
> +}

Is there a strong reason you reimplement this instead of trying to reuse
inet6_fill_ifmcaddr() ? Keeping notifications and get responses in sync
used to be a thing in rtnetlink, this code already diverged but maybe
we can bring it back.

> +static void inet6_ifmcaddr_notify(struct net_device *dev,
> +				  const struct in6_addr *addr, int event)
> +{
> +	struct net *net = dev_net(dev);
> +	struct sk_buff *skb;
> +	int err = -ENOBUFS;

ENOMEM ? I could be wrong but in atomic context the memory pressure 
can well be transient, it's not like the socket queue filled up.

> +	skb = nlmsg_new(NLMSG_ALIGN(sizeof(struct ifaddrmsg))
> +			+ nla_total_size(16), GFP_ATOMIC);

nit: + goes to the end of previous line

> +	if (!skb)
> +		goto error;
> +
> +	err = inet6_fill_ifmcaddr(skb, dev, addr, event);
> +	if (err < 0) {
> +		WARN_ON_ONCE(err == -EMSGSIZE);
> +		kfree_skb(skb);

nit: nlmsg_free(), since it exists

> +		goto error;
> +	}
> +
> +	rtnl_notify(skb, net, 0, RTNLGRP_IPV6_MCADDR, NULL, GFP_ATOMIC);
> +	return;
> +error:
> +	rtnl_set_sk_err(net, RTNLGRP_IPV6_MCADDR, err);
> +}
> +
-- 
pw-bot: cr

