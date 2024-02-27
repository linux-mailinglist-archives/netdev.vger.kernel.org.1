Return-Path: <netdev+bounces-75305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A819C869120
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 13:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F02CB29DE9
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 12:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B910013A896;
	Tue, 27 Feb 2024 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="VXVXS6x4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BED31EA7A
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709038759; cv=none; b=WYE8FpLg7Ni72/H17APtWumz/5ouyVjKPWCdRy9jj9I1b2jgpuep2+CNiLmNttNFvHwYhp1lr8H73FM+OlVHhET5QtdgOARuE+W2Xl/MgqEPESA9sm64ePJhh4eym3fiLOCQOm8i73p/pDo4n4d2n2N0f2bTJeULTIoMqvpJ9O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709038759; c=relaxed/simple;
	bh=3pDEa5hNkGra1/7DG9PBHY7d1OoDtKS13xcZuQS+ino=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7H80kBP1P/u9ZykyxmXzwKpsGWj0suXeccmFg5heYh94tlGjIXcBgU4B2vjSpUyKA+6scNrxZH1JQYMdhbqwB5y2hkKFYR8bCSyjy4cN1CBSX45z9QXssDGC4b2WhemhgRivAAoptgz/bKHxQ6SotaJj9iMXhgPAHJuhUrDcUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=VXVXS6x4; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d204e102a9so50383821fa.0
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 04:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709038755; x=1709643555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0p5z9jbWvhpBfq4izTpJQlY/e3W902HZ8jgMRfx5NPw=;
        b=VXVXS6x4ubbYN45smpUBsnTX5cqKppDk6cajhVk9gjLFB2QDA9JlTM8yNWvQUNozxW
         oo1n+dkfzmcX/jMOsZf7JUGZdhsu/e3//+QAAOnj1JF+1bJk0B8aSmb8VdxHrn5vTi2d
         NcpTcKnHSMvJopM1Qay1L8/1UVvf3ZDs5DT4Z8xq9equQkJw2PNzx+thSyGJrS1FI6At
         nV2HYDTLB1St0EUbeGNXF0LMFbhPlYlHHU65PGOuSSk4k8b4ZxwKSBos8r9BaOfWfuje
         Qm4bp1QnGrw9Z8gvHYP2Vgp7QMaNkz6k9rVB/+o98oSOyb6KhVh1j9jOUmjureQ3THpf
         Dxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709038755; x=1709643555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0p5z9jbWvhpBfq4izTpJQlY/e3W902HZ8jgMRfx5NPw=;
        b=KlGOD78jojwkkExtb98WE+AFSvgDjIkTaExMGgpFRhfUu9LzlAl568B/W1Q4neotZ4
         R6DLju3fjqL/q5t1XbgfKTC/E8QB31hgeUqqZK4OLdNL7QeYtEg4BJ4sLXoJnFfG7j4A
         JesObxJYgbKXbYHEFyMZr7CC4fhSzL6QRImVP/IODOpyvBvtiWmPxvLJ8oLQAubDmOOX
         tsnC2H+uz7J3ikCEheU8o9PorTddm9gLSc7XYljtR16Yo/NPGey//a5EM6pDzp6b4njj
         iNWCHqc8eZhL1wBkDKvaxMyg2JHf7EGbbZKZkitG9DmKrQ+eiccodX4nST73cnAsqzZ/
         MlKg==
X-Forwarded-Encrypted: i=1; AJvYcCV0ULYZbvyQ71qlorSoaMZuFIEXO88b9UT++sqU/QYy00zMN1y5yzXWnbTdOIFRd30PaOn0JoeN8DI9ftOfXVPDuB/YCykr
X-Gm-Message-State: AOJu0Yy1RT+2B0jhaRPpUgX5ApEG4vaFF8dcR42i1tvzGD3Nv89642nS
	h5pEBjdlquVc4qRjt/ime8D/m35NIyR5Q2sAPxP0U5+cda54h6Zvdd693NHqsnQ=
X-Google-Smtp-Source: AGHT+IEg3/3cqmtzOSXUYcLFCuzRi4GmORMbP8GRFqcXthPWyNs5Nz2svLgxQBsuDHA8ebxVZnQzyw==
X-Received: by 2002:a2e:8401:0:b0:2d2:532f:bdf2 with SMTP id z1-20020a2e8401000000b002d2532fbdf2mr5513593ljg.51.1709038755270;
        Tue, 27 Feb 2024 04:59:15 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a19-20020a2ebe93000000b002d283718d89sm986570ljr.56.2024.02.27.04.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 04:59:14 -0800 (PST)
Date: Tue, 27 Feb 2024 13:59:11 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@nvidia.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 2/3] inet: do not use RTNL in
 inet_netconf_get_devconf()
Message-ID: <Zd3cn-kct8PdrvGg@nanopsycho>
References: <20240227092411.2315725-1-edumazet@google.com>
 <20240227092411.2315725-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227092411.2315725-3-edumazet@google.com>

Tue, Feb 27, 2024 at 10:24:10AM CET, edumazet@google.com wrote:
>"ip -4 netconf show dev XXXX" no longer acquires RTNL.

I was under impression that you refer to the current code, confused me a
bit :/


>
>Return -ENODEV instead of -EINVAL if no netdev or idev can be found.
>
>Signed-off-by: Eric Dumazet <edumazet@google.com>
>---
> net/ipv4/devinet.c | 27 +++++++++++++++------------
> 1 file changed, 15 insertions(+), 12 deletions(-)
>
>diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
>index ca75d0fff1d1ebd8c199fb74a6f0e2f51160635c..f045a34e90b974b17512a30c3b719bdfc3cba153 100644
>--- a/net/ipv4/devinet.c
>+++ b/net/ipv4/devinet.c
>@@ -2205,21 +2205,20 @@ static int inet_netconf_get_devconf(struct sk_buff *in_skb,
> 				    struct netlink_ext_ack *extack)
> {
> 	struct net *net = sock_net(in_skb->sk);
>-	struct nlattr *tb[NETCONFA_MAX+1];
>+	struct nlattr *tb[NETCONFA_MAX + 1];
>+	const struct ipv4_devconf *devconf;
>+	struct in_device *in_dev = NULL;
>+	struct net_device *dev = NULL;
> 	struct sk_buff *skb;
>-	struct ipv4_devconf *devconf;
>-	struct in_device *in_dev;
>-	struct net_device *dev;
> 	int ifindex;
> 	int err;
> 
> 	err = inet_netconf_valid_get_req(in_skb, nlh, tb, extack);
> 	if (err)
>-		goto errout;
>+		return err;
> 
>-	err = -EINVAL;
> 	if (!tb[NETCONFA_IFINDEX])
>-		goto errout;
>+		return -EINVAL;
> 
> 	ifindex = nla_get_s32(tb[NETCONFA_IFINDEX]);
> 	switch (ifindex) {
>@@ -2230,10 +2229,10 @@ static int inet_netconf_get_devconf(struct sk_buff *in_skb,
> 		devconf = net->ipv4.devconf_dflt;
> 		break;
> 	default:
>-		dev = __dev_get_by_index(net, ifindex);
>-		if (!dev)
>-			goto errout;
>-		in_dev = __in_dev_get_rtnl(dev);
>+		err = -ENODEV;
>+		dev = dev_get_by_index(net, ifindex);

Comment says:
/* Deprecated for new users, call netdev_get_by_index() instead */
struct net_device *dev_get_by_index(struct net *net, int ifindex)

Perhaps better to use:
netdev_get_by_index() and netdev_put()?


>+		if (dev)
>+			in_dev = in_dev_get(dev);

The original flow:
		err = -ENODEV;
		dev = dev_get_by_index(net, ifindex);
		if (!dev)
			goto errout;
		in_dev = in_dev_get(dev);
 		if (!in_dev)
 			goto errout;
Reads a bit nicer to me. Not sure why you changed it. Yeah, it's a nit.



> 		if (!in_dev)
> 			goto errout;
> 		devconf = &in_dev->cnf;
>@@ -2257,6 +2256,9 @@ static int inet_netconf_get_devconf(struct sk_buff *in_skb,
> 	}
> 	err = rtnl_unicast(skb, net, NETLINK_CB(in_skb).portid);
> errout:
>+	if (in_dev)
>+		in_dev_put(in_dev);
>+	dev_put(dev);
> 	return err;
> }
> 
>@@ -2826,5 +2828,6 @@ void __init devinet_init(void)
> 	rtnl_register(PF_INET, RTM_DELADDR, inet_rtm_deladdr, NULL, 0);
> 	rtnl_register(PF_INET, RTM_GETADDR, NULL, inet_dump_ifaddr, 0);
> 	rtnl_register(PF_INET, RTM_GETNETCONF, inet_netconf_get_devconf,
>-		      inet_netconf_dump_devconf, 0);
>+		      inet_netconf_dump_devconf,
>+		      RTNL_FLAG_DOIT_UNLOCKED);
> }
>-- 
>2.44.0.rc1.240.g4c46232300-goog
>
>

