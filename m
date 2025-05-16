Return-Path: <netdev+bounces-191115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29218ABA1B9
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 19:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B067A05CC2
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 17:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98CB26FA4F;
	Fri, 16 May 2025 17:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pvzpgd1q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DCF200B9F
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 17:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747415683; cv=none; b=lfvkREQNalrLyzQrcysOhC/TOWqCjNg6x2Sffo4zyGZq9vqNsshPQZNBu7mzIYNxkuWz399ANdAKBfH2wIpwibW39atJrEQhTkyXEQehz7AO1we5QzWdpTPKGgUwgCsJixcEDWIqro+yb0yjmZYcxFl/IH9U/fdDo1hf9olsJJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747415683; c=relaxed/simple;
	bh=djHJx/U1fACshlEXW1s5z2+2lfdtvle9nm+UBMEs5IY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GmEpTv4LEgsMQISldPFiV3XQHWzt+rABxayMc/PsOSEGAtz/sgSuTXgrLsoL73x6p7Xt5Yn7SUOW2Pe+WDjF0az5fTrcMFNg1Kme3nVKGxw1ogGICLtZky4mlGsrJXxzBb4g58SRJGpwjUQx3Ve/3U8b6lQyip5kUM/hMf0Szo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pvzpgd1q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDC5C4CEE4;
	Fri, 16 May 2025 17:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747415683;
	bh=djHJx/U1fACshlEXW1s5z2+2lfdtvle9nm+UBMEs5IY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pvzpgd1qDWlKVOQ0WKGTMYihob42TRiUlyNWV47v072E4L77Lk/jZQt25aEZeDZk3
	 5llbfoqu40L8rYGI2JGjTwfP1Zrj6FVwQip7hoXOn7BQvYfbn8EaxPr2qp+x0vhPWe
	 1rEgyj2eSgyZWM5quFag7ZU01EGdorUh6EnaVlaWhONPrtG5AFKZn02N9Eud54apL/
	 yhZmoN3ADM8iosaYoqRA6aXnfrmI0XBm450sbTlngFe7soIbMLA8elN5MJLQTWRbvw
	 LZRcOYyTsKzdAUjHermnVdelfbHd2MH8/5x3VUs9+gc2bcRX7EDF/9sn6UtstU2l5s
	 z6o5By2M9d/9Q==
Date: Fri, 16 May 2025 10:14:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <horms@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
 <sdf@fomichev.me>
Subject: Re: [PATCH net-next] net: let lockdep compare instance locks
Message-ID: <20250516101441.5ad5b722@kernel.org>
In-Reply-To: <20250516082243.1befa6f4@kernel.org>
References: <20250515193609.3da84ac3@kernel.org>
	<20250516030000.48858-1-kuniyu@amazon.com>
	<20250516082243.1befa6f4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 May 2025 08:22:43 -0700 Jakub Kicinski wrote:
> On Thu, 15 May 2025 19:59:41 -0700 Kuniyuki Iwashima wrote:
> > > Is the thinking that once the big rtnl lock disappears in cleanup_net
> > > the devices are safe to destroy without any locking because there can't
> > > be any live users trying to access them?    
> > 
> > I hope yes, but removing VF via sysfs and removing netns might
> > race and need some locking ?  
> 
> I think we should take the small lock around default_device_exit_net()
> and then we'd be safe? Either a given VF gets moved to init_net first
> or the sysfs gets to it and unregisters it safely in the old netns.

Thinking about it some more, we'll have to revisit this problem before
removing the big lock, anyway. I'm leaning towards doing this for now:

diff --git a/include/net/netdev_lock.h b/include/net/netdev_lock.h
index 2a753813f849..c345afecd4c5 100644
--- a/include/net/netdev_lock.h
+++ b/include/net/netdev_lock.h
@@ -99,16 +99,15 @@ static inline void netdev_unlock_ops_compat(struct net_device *dev)
 static inline int netdev_lock_cmp_fn(const struct lockdep_map *a,
 				     const struct lockdep_map *b)
 {
-	/* Only lower devices currently grab the instance lock, so no
-	 * real ordering issues can occur. In the near future, only
-	 * hardware devices will grab instance lock which also does not
-	 * involve any ordering. Suppress lockdep ordering warnings
-	 * until (if) we start grabbing instance lock on pure SW
-	 * devices (bond/team/veth/etc).
-	 */
 	if (a == b)
 		return 0;
-	return -1;
+
+	/* Allow locking multiple devices only under rtnl_lock,
+	 * the exact order doesn't matter.
+	 * Note that upper devices don't lock their ops, so nesting
+	 * mostly happens during batched device removal for now.
+	 */
+	return lockdep_rtnl_is_held() ? -1 : 1;
 }
 
 #define netdev_lockdep_set_classes(dev)				\

