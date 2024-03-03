Return-Path: <netdev+bounces-76907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B70F86F59C
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 16:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F595B21320
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 15:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0386F679F8;
	Sun,  3 Mar 2024 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BGMaGp1Y"
X-Original-To: netdev@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1815A0EE
	for <netdev@vger.kernel.org>; Sun,  3 Mar 2024 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709478082; cv=none; b=VqacALiMVkF18pUZsgdw3zX/itUEDeTztPmcpWRHb09GHDwTUMCMYPITOdORmUPi059ohUvly1CnlOGE9ng5pCvbYYDPOyKmGazt5hGEwDz5msTMV5hG/bKSR4qIiGzE6+sXs7IzDn3ylJ5S4uLONb2bCkIu4Sc+UU0HsUo3Wu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709478082; c=relaxed/simple;
	bh=bILND8YWjOYvjOTmT+97G+b37D1PbOYwPbqL05nvdVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMh6LU4QAy5lZdx3yhdB0rfW+K4V7rqvCgDecdhlaMgJmGLsB5ImNiFdicG/s9r4LMUegkaTU/Hz1i0yNC1Vtm8DHfmDjr9BqLGIvsizl/SweraNplIle4rtrMjzgwrlStHJkVfygZrieq+SalfzcoMjOzooJ4S8nxFWVpXWA0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BGMaGp1Y; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 238ED32001FC;
	Sun,  3 Mar 2024 10:01:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 03 Mar 2024 10:01:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709478078; x=1709564478; bh=F/r5qzy6ZlODJGq2nNcoJYTvQKeO
	xRpsDZj/vp1dI7g=; b=BGMaGp1YeRMb5sjZaYZFgsCiAusryntOXQ2uZB3xAB+E
	pcSFurBxwuo8T5OReQ60sa2XaGR+xy7/pFa6GjW+z0VJXpD8UkHre3JRnq/Ep26a
	8Dtyuk1I8S8/xiqubiNh8Mds86yS/cvkprApqokYhfbuAaxaBqh4JYaNsOhbZYKg
	Ao7bTTs/DDON9ui7ADss1YwV+K52nZv6+jBJJrwX9VlkYFNwfmHUvXkwhsJDCrjG
	T7+HsDH4KRKY90a2KTyWK6zxdn5f2H8qlrGznktVJvjN3vZGkjUUp1M5q3YEjseQ
	IzVhkwNdcH7suNmQQFTeHuWHwIFwj+6aLuqjjS4BDQ==
X-ME-Sender: <xms:vZDkZeWZCk-havHWGTaWZyCre0cqu0Lla6EDfJua-_67JvgkE3IwBQ>
    <xme:vZDkZalg2ep5KhnGNVU67Nd1hRmvFkVsFMxXMhDh7kVjhIeJxEp8RxQ4rxo2g_YHl
    gObZi6-zpLiuWU>
X-ME-Received: <xmr:vZDkZSZWkuy4RPeUvxGIh_RAkJHc3i4z-2_gYQr5d-N1lfSOd2YOAXbclCqT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheehgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiugho
    shgthhdrohhrgheqnecuggftrfgrthhtvghrnhephefhtdejvdeiffefudduvdffgeetie
    eigeeugfduffdvffdtfeehieejtdfhjeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhr
    ghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:vZDkZVU-oNcl9irKnibgBoshy-BboUtoFi2bLQ1uYgJSeDRLF4OOFw>
    <xmx:vZDkZYms2i8DQMnWD2Wg7EzYpYUGMEb5cTk31Y6Xz92Nzc2EDQYfYw>
    <xmx:vZDkZacoUTRjCx_VubwnRKwd59VjwtXN3af19tgele-Y6KR6xrCtrQ>
    <xmx:vpDkZSVn8HLi6t2D5k_z8wcGMrJGDNf_ZJGNG5op9v1m_835uF_oaQ>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Mar 2024 10:01:17 -0500 (EST)
Date: Sun, 3 Mar 2024 17:01:13 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, jiri@resnulli.us, johannes@sipsolutions.net,
	fw@strlen.de, pablo@netfilter.org, kuniyu@amazon.com
Subject: Re: [PATCH net-next v2 1/3] netlink: handle EMSGSIZE errors in the
 core
Message-ID: <ZeSQuYVI3PTX0nha@shredder>
References: <20240303052408.310064-1-kuba@kernel.org>
 <20240303052408.310064-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240303052408.310064-2-kuba@kernel.org>

On Sat, Mar 02, 2024 at 09:24:06PM -0800, Jakub Kicinski wrote:
> Eric points out that our current suggested way of handling
> EMSGSIZE errors ((err == -EMSGSIZE) ? skb->len : err) will
> break if we didn't fit even a single object into the buffer
> provided by the user. This should not happen for well behaved
> applications, but we can fix that, and free netlink families
> from dealing with that completely by moving error handling
> into the core.
> 
> Let's assume from now on that all EMSGSIZE errors in dumps are
> because we run out of skb space. Families can now propagate
> the error nla_put_*() etc generated and not worry about any
> return value magic. If some family really wants to send EMSGSIZE
> to user space, assuming it generates the same error on the next
> dump iteration the skb->len should be 0, and user space should
> still see the EMSGSIZE.
> 
> This should simplify families and prevent mistakes in return
> values which lead to DONE being forced into a separate recv()
> call as discovered by Ido some time ago.
> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

I read your comment here [1] and I believe this patch [2] is needed to
avoid another pass in case of an error code other than EMSGSIZE. I can
submit it after your series is accepted.

[1] https://lore.kernel.org/netdev/20240229073750.6e59155e@kernel.org/

[2]
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 70509da4f080..b3a24b61f76b 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3241,10 +3241,6 @@ static int rtm_dump_nexthop(struct sk_buff *skb, struct netlink_callback *cb)
 
        err = rtm_dump_walk_nexthops(skb, cb, root, ctx,
                                     &rtm_dump_nexthop_cb, &filter);
-       if (err < 0) {
-               if (likely(skb->len))
-                       err = skb->len;
-       }
 
        cb->seq = net->nexthop.seq;
        nl_dump_check_consistent(cb, nlmsg_hdr(skb));
@@ -3439,11 +3435,6 @@ static int rtm_dump_nexthop_bucket(struct sk_buff *skb,
                                             &rtm_dump_nexthop_bucket_cb, &dd);
        }
 
-       if (err < 0) {
-               if (likely(skb->len))
-                       err = skb->len;
-       }
-
        cb->seq = net->nexthop.seq;
        nl_dump_check_consistent(cb, nlmsg_hdr(skb));
        return err;

