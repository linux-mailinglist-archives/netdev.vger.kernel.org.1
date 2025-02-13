Return-Path: <netdev+bounces-166034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D41A34060
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 14:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8D79188B74D
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 13:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51077227EAE;
	Thu, 13 Feb 2025 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QKQ+xC5M"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765E6227E98
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739453320; cv=none; b=CgMJP28cloSTj7W1+L5izEzdTs2infz6ARma+8LcmpY2/QAFQ1C5rcfm+fhw3ZIHzZt7tQ0jBmTIq8c4t2k+oq9kl4+Z7D58dgP54k7OWPreBzp2hbEwJcs/WGH2XCDD/9YM7kXyy4uEzFu6iTZzNrJNJod1gKcg5idm2vYGfrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739453320; c=relaxed/simple;
	bh=/Qn77Ocxe2sbex4mb5tdrKAaEqON4VTAP1evl/u6Uew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evywovXJmHULm3rkOQw00J+iFNx6/Nc6EXGVpg6ugEq+VvOgBw04xf20cva69sFwh4QtmQ3EO+QnOWxsp44WrFOBQ4LvTVy6IrxFilFUSpf/OJwdw0lKDUKeffkX40oTiNi1sb1LqxPnF7PKs9+3bH89sPjWQVlZmqb2jk7SCr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QKQ+xC5M; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 34ACC114012C;
	Thu, 13 Feb 2025 08:28:37 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 13 Feb 2025 08:28:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739453317; x=1739539717; bh=OepDTwXHKL8Rz7EnGtrIUBcgHm7TFwIup3O
	HKhJ9sNU=; b=QKQ+xC5MiokoOI6Yu7qwSpJzoTHS+YTD9eL+RvZuXArt3JC+9RZ
	R/d4964S3G+VXsbiBoQ+++F/v0J0tyt0aCoIWh3+HJpjieBIPXCXx1tgf9+0TWzT
	uy+B+uvoBGwbBlY7cYkS+Fs54lZgwUpSl+9gBnQ3msHORi6g79S4XodIzFUSBkoS
	olMurHvyoq6L0oU2daXeGnM5EtMtaPfhcNfPgJiBLKAhg0td1cpHPZJJ1k8tl+uT
	+At2/3PSwXc7cuPdSrkRxdSol8TZo6+vIFpVwCm1iCv7dCgfcYdwjdzNMEA844L7
	fvDxkf522DJXJhNWC4AomjVmPw2Seq19AeA==
X-ME-Sender: <xms:g_OtZ6BE69h4R87xIy3vP9RB7NFEaFa25hvRIOJLJvoKZ_3pOFbP4A>
    <xme:g_OtZ0gUSgdWBQw_l4wlR1CTq1EJN30Yc2QVddKB7FgLvxOaPFuI5TdJhf8Alpo5L
    CDOIbzyNNPKfeE>
X-ME-Received: <xmr:g_OtZ9mqg8IjTMdDRH6CIuIDwBb2B57phMyKUtYtsxJ1d_HEu2da61PIhBM9ZVhKIEPAcSU_MZCBLUrkPC8TpDJl07w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegieeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrd
    horhhgqeenucggtffrrghtthgvrhhnpeehhfdtjedviefffeduuddvffegteeiieeguefg
    udffvdfftdefheeijedthfejkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghh
    sehiughoshgthhdrohhrghdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehjuhhsthhinhdrihhurhhmrghnsehulhhivghgvgdrsggvpdhr
    tghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegushgrhhgvrhhn
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    rggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheprghlvgigrdgrrhhinhhgsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:g_OtZ4wgfhDQ3JN85Aiz15h2XFXsGf18Bf--z15y_Ntu75yxdeAWtA>
    <xmx:g_OtZ_RnRfxXuHLfBbdljBme8_1v5YFToEX-X_gPuw7R3o9WyEgF6A>
    <xmx:g_OtZzYXybIfmXWmINt8tw3p1MfkAx0EtJItFeRLQiJU1gCmh-RjhQ>
    <xmx:g_OtZ4T33nbkLZpbCzJu4NuK8wxrlijk7HQtOjk7mz7p7EaHP_NVdQ>
    <xmx:hfOtZ098zIg6lcDp1oH3Wa3iZFMqF2pi09AiELSntw4dlZCTQMv_1c7g>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Feb 2025 08:28:35 -0500 (EST)
Date: Thu, 13 Feb 2025 15:28:32 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, Alexander Aring <alex.aring@gmail.com>,
	David Lebrun <dlebrun@google.com>
Subject: Re: [PATCH net v2 2/3] net: ipv6: fix lwtunnel loops in ioam6, rpl
 and seg6
Message-ID: <Z63zgLQ_ZFmkO9ys@shredder>
References: <20250211221624.18435-1-justin.iurman@uliege.be>
 <20250211221624.18435-3-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211221624.18435-3-justin.iurman@uliege.be>

On Tue, Feb 11, 2025 at 11:16:23PM +0100, Justin Iurman wrote:
> When the destination is the same post-transformation, we enter a
> lwtunnel loop. This is true for ioam6_iptunnel, rpl_iptunnel, and
> seg6_iptunnel, in both input() and output() handlers respectively, where
> either dst_input() or dst_output() is called at the end. It happens for
> instance with the ioam6 inline mode, but can also happen for any of them
> as long as the post-transformation destination still matches the fib
> entry. Note that ioam6_iptunnel was already comparing the old and new
> destination address to prevent the loop, but it is not enough (e.g.,
> other addresses can still match the same subnet).
> 
> Here is an example for rpl_input():
> 
> dump_stack_lvl+0x60/0x80
> rpl_input+0x9d/0x320
> lwtunnel_input+0x64/0xa0
> lwtunnel_input+0x64/0xa0
> lwtunnel_input+0x64/0xa0
> lwtunnel_input+0x64/0xa0
> lwtunnel_input+0x64/0xa0
> [...]
> lwtunnel_input+0x64/0xa0
> lwtunnel_input+0x64/0xa0
> lwtunnel_input+0x64/0xa0
> lwtunnel_input+0x64/0xa0
> lwtunnel_input+0x64/0xa0
> ip6_sublist_rcv_finish+0x85/0x90
> ip6_sublist_rcv+0x236/0x2f0
> 
> ... until rpl_do_srh() fails, which means skb_cow_head() failed.
> 
> This patch prevents that kind of loop by redirecting to the origin
> input() or output() when the destination is the same
> post-transformation.

A loop was reported a few months ago with a similar stack trace:
https://lore.kernel.org/netdev/2bc9e2079e864a9290561894d2a602d6@akamai.com/

But even with this series applied my VM gets stuck. Can you please check
if the fix is incomplete?

