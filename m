Return-Path: <netdev+bounces-100235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5762E8D8471
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 15:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11AF9287872
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 13:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD6412D76B;
	Mon,  3 Jun 2024 13:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6gDLAr8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1FA1E4A2
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 13:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717422867; cv=none; b=ZcTU4HqM81o8+yk3TNH4Vc4IzZ9CYGNDziRCTRvFsUnW8t5Ms8i9CQEchETCIPQhKAUZ8vVUY1Ldz8afL/V00Ml0Wb6Cgkl13AAzM9aKkIs22NhTjLJwtaUGms7ZbMEaYEdSjph4Qb2psCDsQvLabhrDFL/8g8MUTVqeTTzI+zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717422867; c=relaxed/simple;
	bh=YZUJy869G64jOKYXyew8yBg1kPppbVs+C5Nv/LjYYPU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bN1kXKkdLBc6TQazEKeCSwXuQantXOxTe3YN2+b4UpeEUoHygp0XOavKQm741LJ/fTumCbew6dw3RVEUFnbDp4GveQQJ+E9lSUxLzAQL/WuRnk5IKtGKF4zZIQJHGCwyYJFZ0rRhC5Qsgip+3/4os7KpfKrPq4jJPEVjRBt3KE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6gDLAr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A462C4AF08;
	Mon,  3 Jun 2024 13:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717422867;
	bh=YZUJy869G64jOKYXyew8yBg1kPppbVs+C5Nv/LjYYPU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f6gDLAr8sn35Jkdf0aQI7jrF3YvAaPLZtKyw60IZcUBmoeAGj5kiqxO7mhjynfiE/
	 TIX0dtfR9/XAOMTW/5/GvkXtXbGPAtRS+yHUD/7HjqSmGwrLG01hOE+DpysX55W/+v
	 lPCWk0KiBklOOw1M2mFYVPx4zGsbrcWs+nlr+zCj5/pgutuk+OBB2bYWkaHUikG0Kp
	 ASVVat0AQVB35evbP93/mPJ4i4XL/Qys5Hx8zLf+x9JTvJzRrDHMHp0SZORsUauNA9
	 hQhxli9vmuCAu1FIB0EJ9wQCU3z974hvOMlSOcMuF8XHKsosI9oyxbQcBzht7tTiu4
	 Z3cDN7BYzCP4w==
Date: Mon, 3 Jun 2024 06:54:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>, Stephen Hemminger
 <stephen@networkplumber.org>, davem@davemloft.net, netdev@vger.kernel.org,
 pabeni@redhat.com, Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Subject: Re: [PATCH net] inet: bring NLM_DONE out to a separate recv() in
 inet_dump_ifaddr()
Message-ID: <20240603065425.6b74c2dd@kernel.org>
In-Reply-To: <20240602152102.1a50feed@kernel.org>
References: <20240601212517.644844-1-kuba@kernel.org>
	<20240601161013.10d5e52c@hermes.local>
	<20240601164814.3c34c807@kernel.org>
	<ad393197-fd1a-4cd8-a371-f6529419193b@kernel.org>
	<CANn89i+i-CooK7GHKr=UYDw4Nf7EYQ5GFGB3PFZiaB7a_j3_xA@mail.gmail.com>
	<20240602152102.1a50feed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 2 Jun 2024 15:21:02 -0700 Jakub Kicinski wrote:
> Netlink is full of legacy behavior, the only way to make it usable
> in modern environments is to let new families not repeat the mistakes.
> That's why I'd really rather not add a workaround at the af_netlink
> level. Why would ethtool (which correctly coalesced NLM_DONE from day 1)
> suddenly start needed another recv(). A lot of the time the entire dump
> fits in one skb.
> 
> If you prefer to sacrifice all of rtnetlink (some of which, to be clear,
> has also been correctly coded from day 1) - we can add a trampoline for
> rtnetlink dump handlers?

Hi Eric, how do you feel about this approach? It would also let us
extract the "RTNL unlocked dump" handling from af_netlink.c, which
would be nice.

BTW it will probably need to be paired with fixing the
for_each_netdev_dump() foot gun, maybe (untested):

--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3025,7 +3025,8 @@ int call_netdevice_notifiers_info(unsigned long val,
 #define net_device_entry(lh)	list_entry(lh, struct net_device, dev_list)
 
 #define for_each_netdev_dump(net, d, ifindex)				\
-	xa_for_each_start(&(net)->dev_by_index, (ifindex), (d), (ifindex))
+	for (; (d = xa_find(&(net)->dev_by_index, &ifindex,		\
+			    ULONG_MAX, XA_PRESENT)); ifindex++)
 
 static inline struct net_device *next_net_device(struct net_device *dev)
 {


