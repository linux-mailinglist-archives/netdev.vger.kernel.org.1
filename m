Return-Path: <netdev+bounces-67557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4899184406E
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 14:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D625C28DD8E
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 13:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A63B7B3E2;
	Wed, 31 Jan 2024 13:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eO8HWt8H"
X-Original-To: netdev@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF977BAF3;
	Wed, 31 Jan 2024 13:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706707438; cv=none; b=ahS9MJDTu+3lAQSPNyfTcgIbyWXo3GbqG2w4gL+ydkE3LHRopyU3jM3w4LpJGmWYtgihi2CnYKoUK0l+xHo3eew1I9JoNC5y/Ww+/rAsS3XGHMUKbSlTm7uA2sYZx3gfHR4psmORDY3lL2kXDiLqs4iwsRwtUhls+yIh4AmsrpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706707438; c=relaxed/simple;
	bh=IGvMso4zw2819zDPSG7jetJFq4uCWajG6/aSyluyjzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/1kuJ0hzh//kVSNuN7O9VlbvKgme6DDbs8hzB7vcF2zvQgQcQoZA/U4Uhqr/g0M/59K7X1yxV412om6WuwCngdzsxV/OBTwQRODwP62ZhTf5Bs7FKHZhwwECyN53G52DM0MBDeQ1RPFWTI08m3QnhLSKLVG6qe0fds79IfVyp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eO8HWt8H; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 417615C0158;
	Wed, 31 Jan 2024 08:23:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 31 Jan 2024 08:23:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706707435; x=1706793835; bh=OrVXpkh6/GxYIQJfx8cQuBzt1xv7
	UiE7g8dc4xQBBAQ=; b=eO8HWt8HJ9gNBILmr2JL03l+R0n5GkZCW1EVkb/Tf1Do
	2Qs+VnrGjA1GFOesoedyucaWNYv/xuhuGp7c/KdjTZZ1oSeq6xVd5cILiWc+pIb9
	VNZxU2PFaVL6SFY9fh8w8Ep3rVLnbsFiDvHSkuHHChOy6lAscFQ5hiSWs8ngXpTb
	pNIWwJdYIdgnLoHU/7j8AbKQPcQvZUaA8fWcM1I80BB1QwdBHzzP3HIfnIBP4I9Q
	9DT+wcssVL6TR8xwdJOur+brMxrILh8EyokG0jBYmb2KedkT6pguZ1MJ2gNdXiG9
	ELwRSApVyqPbHummQsduDtqybPBN4xnZN6aOmMtXBA==
X-ME-Sender: <xms:60m6ZXrZcpqtJjvkdKQNy1BvpkrXyt5NC_Lnl5DWylrgD4-zrYu8Vg>
    <xme:60m6ZRpRuIIh_imJvZIDG441ME0-z7fax0xwkTvLUMDJr5OaDkBACb3kqkwJw-3Qw
    PqlhDlA4w9Bu3k>
X-ME-Received: <xmr:60m6ZUM8sIht4FnL5oXpm_oITOXYLkTd9o_qoqUJ1nsSQMnZIIf64BPB4QO->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtledggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihgu
    ohhstghhrdhorhhgqeenucggtffrrghtthgvrhhnpeeiheffiedvtdehjeejffekffdtie
    ehueejvefgteeiueegkeelleefgfelteduieenucffohhmrghinheplhhinhhugidruggv
    vhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:60m6Za5G1XW9M0b9xrtQU0xb6hdaPTVx3KfMA6gT4Ygv2gAOOwhFBg>
    <xmx:60m6ZW4w-xEUTe5rwtPptJak_p3GjMtYpmemGldzn1c19NBsgvariw>
    <xmx:60m6ZSgPxd_xK1TNElNAqjepSYHB9tdzAur0B8bTh4VF72-ZfHqqIA>
    <xmx:60m6Zbh-IY_Zvy8WfJ79nrbKnI4E-NritAHvABu9XhkSIFnEU9CqcQ>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jan 2024 08:23:54 -0500 (EST)
Date: Wed, 31 Jan 2024 15:23:50 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"netdev-driver-reviewers@vger.kernel.org" <netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [ANN] net-next is OPEN
Message-ID: <ZbpJ5s6Lcl5SS3ck@shredder>
References: <20240122091612.3f1a3e3d@kernel.org>
 <ZbedgjUqh8cGGcs3@shredder>
 <ZbeeKFke4bQ_NCFd@shredder>
 <20240129070057.62d3f18d@kernel.org>
 <ZbfZwZrqdBieYvPi@shredder>
 <20240129091810.0af6b81a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129091810.0af6b81a@kernel.org>

On Mon, Jan 29, 2024 at 09:18:10AM -0800, Jakub Kicinski wrote:
> On Mon, 29 Jan 2024 19:00:49 +0200 Ido Schimmel wrote:
> > > Installed both (from source) just in time for the
> > > net-next-2024-01-29--15-00 run.. let's see.  
> > 
> > Thanks!
> > 
> > The last two tests look good now, but the first still fails. Can you
> > share the ndisc6 version information? I tested with [1] from [2].
> > 
> > If your copy of ndisc6 indeed works, then I might be missing some
> > sysctl. I will be AFK tomorrow so I will look into it later this week.
> 
> Hm. Looks like our versions match. I put the entire tools root dir up on
> HTTP now: https://netdev-2.bots.linux.dev/tools/fs/ in case you wanna
> fetch the exact binary, it only links with libc, it seems.

I tried with your binary and on other setups and I'm unable to reproduce
the failure. From the test output it seems the NS is never sent. If you
can, attaching the verbose test output might help:

./test_bridge_neigh_suppress.sh -t neigh_suppress_ns -v

Thanks

