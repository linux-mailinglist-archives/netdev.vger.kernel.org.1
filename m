Return-Path: <netdev+bounces-166805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F88A375C8
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 17:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509413A21AD
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 16:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B5D182D9;
	Sun, 16 Feb 2025 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OWpKSwgp"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27761EB2A
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739723469; cv=none; b=RkYRU9nneX6X1vARHrzJg7LXMKd/sdPIEJDUVlSN45LXvhKHpLNwAWhP9y4IhNR0WhhdszJFkuPoeoiDvA5PYooKBrUQmzuQzqGOei6Rc4tOK5gagGdDd1rF18V0OUa8iXVdr9pvsDXxap0Ty+HDcRI9XNAZxpdhZFMm5JYLU5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739723469; c=relaxed/simple;
	bh=JBxW88opkFEQVbx2tg3G9I/mRJKKNOE6b3B8y35QQSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvFCgBf7WVwzeXSwCKl5aCcNoqtHbYQKuLG+Qa8iX9i+HasrNrD3WEqfhzIVPfT85g9tzUVL6WNLmVIWWEiZEFszVBZl8lfK9smvlI6f376Q4u2WZY9fewVhR/fRPdb/KuPcp/sY4rgLcv8uq/cWBXfcLBSra7J5xWrtXrGlx0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OWpKSwgp; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 69E4425400CC;
	Sun, 16 Feb 2025 11:31:06 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sun, 16 Feb 2025 11:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739723466; x=1739809866; bh=mCDrHix1+OtxAOeDd4aFl5V38H50hNnqGCq
	4ygl6dAA=; b=OWpKSwgpsehkfToaDSOk4hnY5uin0/6nQzcMvZD5e4zhkcstQ6G
	jbq2Qb0kyJCXWcYp0YeGagJDjO4pIaB6kEmNYqh5Fg9TJV3f0N2kGDfn3lqBFxok
	hdbqeA8qMsbHF+94MX9CUuwalewvxJ943Qan0+e3zyg7NxBBN6jkgEA5d4GLqvK0
	bf8Ad1rlxMmmjZY2ncCDBiqZTW1pHhIkx/LEfhEk/dG2KfeLpMuIYAh/ps0gJrQ0
	nF36mWwwx3ong8b2pLr4J/iJl8LOBaHxG7Vr20G/bdPUE29gzfBspsbSCOGyKlHG
	EWYPaZMqYWg+ni1hvQ5yBNWpbPrmKSSDWmg==
X-ME-Sender: <xms:yRKyZxvK7TQRYMPDwnFUMaS7wcm9Po6ia9s1b8xS6annS96U_bZAUg>
    <xme:yRKyZ6drrS8_O0Bex-Irqe9Q7OWQlqimMvedHny38Qaij_YCQzlgKMpUYYuaysdi3
    7E_FK0l-Jk85IQ>
X-ME-Received: <xmr:yRKyZ0w44yKEqdvwoslRMX6yha6cL6hUL5sEBpu1DDgjbD59xcW97jke53RU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehheelgecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:yRKyZ4OsRhLLQxmOM3fuZVV45c2UjfCxCDDfCY3dfhaTLBY0ujvJYA>
    <xmx:yRKyZx_qHCZi3mDD1NyL0S4JADq3wFN1ac0IVQ_i6lK0iXifuFtdVg>
    <xmx:yRKyZ4UlImzRlKTp06LcnBs_l9ho08DADLjQpJou00wyW14gIRzf6A>
    <xmx:yRKyZycJeReCY-Htb4VKoJe_MIxwZlqv9wpwM8f1KtBEK_Li6Moxdg>
    <xmx:yhKyZwb0u5m5I02k-q4klYEzjblFAyrsLSRsqFHUNCRSa-9snGnSWfzv>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Feb 2025 11:31:04 -0500 (EST)
Date: Sun, 16 Feb 2025 18:31:02 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, Alexander Aring <alex.aring@gmail.com>,
	David Lebrun <dlebrun@google.com>
Subject: Re: [PATCH net v2 2/3] net: ipv6: fix lwtunnel loops in ioam6, rpl
 and seg6
Message-ID: <Z7ISxnU0QhtRGTnb@shredder>
References: <20250211221624.18435-1-justin.iurman@uliege.be>
 <20250211221624.18435-3-justin.iurman@uliege.be>
 <Z63zgLQ_ZFmkO9ys@shredder>
 <a375f869-9fc3-4a58-a81a-c9c8175463dd@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a375f869-9fc3-4a58-a81a-c9c8175463dd@uliege.be>

On Thu, Feb 13, 2025 at 11:51:49PM +0100, Justin Iurman wrote:
> On 2/13/25 14:28, Ido Schimmel wrote:
> > On Tue, Feb 11, 2025 at 11:16:23PM +0100, Justin Iurman wrote:
> > > When the destination is the same post-transformation, we enter a
> > > lwtunnel loop. This is true for ioam6_iptunnel, rpl_iptunnel, and
> > > seg6_iptunnel, in both input() and output() handlers respectively, where
> > > either dst_input() or dst_output() is called at the end. It happens for
> > > instance with the ioam6 inline mode, but can also happen for any of them
> > > as long as the post-transformation destination still matches the fib
> > > entry. Note that ioam6_iptunnel was already comparing the old and new
> > > destination address to prevent the loop, but it is not enough (e.g.,
> > > other addresses can still match the same subnet).
> > > 
> > > Here is an example for rpl_input():
> > > 
> > > dump_stack_lvl+0x60/0x80
> > > rpl_input+0x9d/0x320
> > > lwtunnel_input+0x64/0xa0
> > > lwtunnel_input+0x64/0xa0
> > > lwtunnel_input+0x64/0xa0
> > > lwtunnel_input+0x64/0xa0
> > > lwtunnel_input+0x64/0xa0
> > > [...]
> > > lwtunnel_input+0x64/0xa0
> > > lwtunnel_input+0x64/0xa0
> > > lwtunnel_input+0x64/0xa0
> > > lwtunnel_input+0x64/0xa0
> > > lwtunnel_input+0x64/0xa0
> > > ip6_sublist_rcv_finish+0x85/0x90
> > > ip6_sublist_rcv+0x236/0x2f0
> > > 
> > > ... until rpl_do_srh() fails, which means skb_cow_head() failed.
> > > 
> > > This patch prevents that kind of loop by redirecting to the origin
> > > input() or output() when the destination is the same
> > > post-transformation.
> > 
> > A loop was reported a few months ago with a similar stack trace:
> > https://lore.kernel.org/netdev/2bc9e2079e864a9290561894d2a602d6@akamai.com/
> > 
> > But even with this series applied my VM gets stuck. Can you please check
> > if the fix is incomplete?
> 
> Good catch! Indeed, seg6_local also needs to be fixed the same way.
> 
> Back to my first idea: maybe we could directly fix it in lwtunnel_input()
> and lwtunnel_output() to make our lives easier, but we'd have to be careful
> to modify all users accordingly. The users I'm 100% sure that are concerned:
> ioam6 (output), rpl (input/output), seg6 (input/output), seg6_local (input).
> Other users I'm not totally sure (to be checked): ila (output), bpf (input).
> 
> Otherwise, we'll need to apply the fix to each user concerned (probably the
> safest (best?) option right now). Any opinions?

I audited the various lwt users and I agree with your analysis about
which users seem to be effected by this issue.

I'm not entirely sure how you want to fix this in
lwtunnel_{input,output}() given that only the input()/output() handlers
of the individual lwt users are aware of both the old and new dst
entries.

BTW, I noticed that bpf implements the xmit() hook in addition to
input()/output(). I wonder if a loop is possible in the following case:

ip_finish_output2()                                         <----+
	lwtunnel_xmit()                                          |
		bpf_xmit()                                       |
			// bpf program does not change           |
			// the packet and returns                |
			// BPF_LWT_REROUTE                       |
			bpf_lwt_xmit_reroute()                   |
				// unmodified packet resolves    |
				// the same dst entry            |
				dst_output()                     |
					ip_output() -------------+

