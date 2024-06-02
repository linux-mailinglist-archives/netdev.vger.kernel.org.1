Return-Path: <netdev+bounces-100032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7C68D78CD
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 00:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8BCE2810B3
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 22:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D4236AE0;
	Sun,  2 Jun 2024 22:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKKAxac0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD07D3EA7B
	for <netdev@vger.kernel.org>; Sun,  2 Jun 2024 22:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717366864; cv=none; b=gh9YgLsQ0sKKwcSfqzInoKSE7JxT5kg4uHlLDbZFcAiYN8syq1MuiA6LdGqw/V7+esjtINHFDMg/h1jpprNByJHB4+LWmLt87Bb6QG89Ydi/FkOpKK/e+XZbZN+buuI/giXr1mHb+Owe3Z5ybdEBJGAuNZV7wwZtoSYvFyxONdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717366864; c=relaxed/simple;
	bh=g403DQTBkZppbzdbE34JrqtiUIljdABlVaRuJreldQE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OMvObrk3USYNLeq2pVTgxzS7cYQAwyfFn3InzG6eZu+6Y/EpzVtPFAI1/PlBxGSnPZ1F6PU6yiD0+/sLnA79lUrpMYaqvHnivNPCBviGG17PThXi57iYFFomXuB4mdgsNK2Ad3GFaB4Ie+TX2nzX4CC8LuwC7hz7zgYS4FkWNW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKKAxac0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58AAC2BBFC;
	Sun,  2 Jun 2024 22:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717366864;
	bh=g403DQTBkZppbzdbE34JrqtiUIljdABlVaRuJreldQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gKKAxac0dXkeCfwvQz4SzHHUCAFIl1wCZeBxB1/+OMVK3x+DsYQ2FB7pRAuu3KXHy
	 SLmYQ+Z643Bu0P8PgEANtq0Hjhwsy3kj2jB3TlbPCpcRcp9D+ONg/44gnYczrAXrCI
	 yY11rwiv8/bsF2cuI2H/ybJA9IDbsg/FqQ53gBNsuESWtWtg+zA37jx4wobdyrrQ8g
	 41tJcU6BbTsGZwVE8aKR09Hhl/D+eKMEmttkhZbvvcJUvqK2sxkIVaOhkmWnf+m0jm
	 +ZAvqUHsCSJbhupDpOwDw0x10qiNW2SX2Lkjbj8i99bgTsrNGN8lDddIwcrGp7BQvc
	 YR+oy64P/9HFw==
Date: Sun, 2 Jun 2024 15:21:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>, Stephen Hemminger
 <stephen@networkplumber.org>, davem@davemloft.net, netdev@vger.kernel.org,
 pabeni@redhat.com, Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Subject: Re: [PATCH net] inet: bring NLM_DONE out to a separate recv() in
 inet_dump_ifaddr()
Message-ID: <20240602152102.1a50feed@kernel.org>
In-Reply-To: <CANn89i+i-CooK7GHKr=UYDw4Nf7EYQ5GFGB3PFZiaB7a_j3_xA@mail.gmail.com>
References: <20240601212517.644844-1-kuba@kernel.org>
	<20240601161013.10d5e52c@hermes.local>
	<20240601164814.3c34c807@kernel.org>
	<ad393197-fd1a-4cd8-a371-f6529419193b@kernel.org>
	<CANn89i+i-CooK7GHKr=UYDw4Nf7EYQ5GFGB3PFZiaB7a_j3_xA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 2 Jun 2024 12:00:09 +0200 Eric Dumazet wrote:
> Main motivation for me was to avoid re-grabbing RTNL again just to get NLM_DONE.
> 
> The avoidance of the two system calls was really secondary.
> 
> I think we could make a generic change in netlink_dump() to force NLM_DONE
> in an empty message _and_ avoiding a useless call to the dump method, which
> might still use RTNL or other contended mutex.
> 
> In a prior feedback I suggested a sysctl that Jakub disliked,
> but really we do not care yet, as long as we avoid RTNL as much as we can.
> 
> Jakub, what about the following generic change, instead of ad-hoc changes ?

Netlink is full of legacy behavior, the only way to make it usable
in modern environments is to let new families not repeat the mistakes.
That's why I'd really rather not add a workaround at the af_netlink
level. Why would ethtool (which correctly coalesced NLM_DONE from day 1)
suddenly start needed another recv(). A lot of the time the entire dump
fits in one skb.

If you prefer to sacrifice all of rtnetlink (some of which, to be clear,
has also been correctly coded from day 1) - we can add a trampoline for
rtnetlink dump handlers?

(just to illustrate, not even compile tested)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 522bbd70c205..c59b39ee544f 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -6487,6 +6487,18 @@ static int rtnl_mdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 /* Process one rtnetlink message. */
 
+static int rtnl_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	rtnl_dumpit_func dumpit = cb->data;
+	int err;
+
+	err = dumpit(skb, cb);
+	if (err < 0 && err != -EMSGSIZE)
+		return err;
+
+	return skb->len;
+}
+
 static int rtnetlink_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 			     struct netlink_ext_ack *extack)
 {
@@ -6546,10 +6558,11 @@ static int rtnetlink_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 		rtnl = net->rtnl;
 		if (err == 0) {
 			struct netlink_dump_control c = {
-				.dump		= dumpit,
+				.dump		= rtnl_dumpit,
 				.min_dump_alloc	= min_dump_alloc,
 				.module		= owner,
 				.flags		= flags,
+				.data		= dumpit,
 			};
 			err = netlink_dump_start(rtnl, skb, nlh, &c);
 			/* netlink_dump_start() will keep a reference on

