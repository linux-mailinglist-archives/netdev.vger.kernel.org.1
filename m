Return-Path: <netdev+bounces-163921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E70A2C078
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 11:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43BD9168E95
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 10:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0C81DE4EA;
	Fri,  7 Feb 2025 10:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VrqrRAkm"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9E680BFF
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 10:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738923658; cv=none; b=JuLtbviFx2KhSLU+ZRhSTxN3QynJ6ggqJgE+09fAuFleq/8harspha8IBZYP2yQWksJ5mP2ZRtWgzCdnzYhg8GzETYwkUQhTQC6eChIL+MDoxza1SnhYSF4rITLo7wGyL7VJhH7bw2kXs3lDRtwhomPpQeTMt3a1HpYvtkD7dJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738923658; c=relaxed/simple;
	bh=ggZjxOnu5YXJz/Yx2yanKyEKxn3BYEv0ZC4rdCMwxoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5fbJx1NICnJudsU7WobjeEgnt9Ku2SIwvjddR4VloRiONL4GuWatbByY2hPERLwuCGCCcK1mRVDoj6u4FkAwvNv/W3diaFw2VNIKw371QDuGOes40E0/jBJHlM/Wk5tZp9mOI2VZOxk7MafYzXIR1LQlosKYSW0ERrKwDr1bSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VrqrRAkm; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 73CE711400FB;
	Fri,  7 Feb 2025 05:20:54 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 07 Feb 2025 05:20:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738923654; x=1739010054; bh=ggZjxOnu5YXJz/Yx2yanKyEKxn3BYEv0ZC4
	rdCMwxoU=; b=VrqrRAkmc+xCD9KLW9ObeH9Tp98OFarfIgxYc8+BGKMYFkbarXR
	hGA8nc8HlKvwWW1PhdphmNlD4gkFeouc1YIs/RKnOQugC8v2HOgyZja7Fod8qjTB
	hMCy47AjaUf1Mt7+/LdOKPUESGqUSSSIY/+Z2r2TqzO55dZDXj3rnXOep3Dhe69B
	+pQlPrJ9/GUaEFushd2MpenIq0hazbOY4GvjdMqNkKpnVTPrLVAGJLZHiGkX2vaI
	EWoW24/LJTVlWkaXlNW+Y3oIpWqu4TTa+cj7xbSM78f48HxxX/OLRMoqDXVK0ldu
	BrUWr45sxqCURutKmS0O7EHKAiIo7EE1xZA==
X-ME-Sender: <xms:hd6lZ_ixIkEP6-vt9gWmAgRVh_toypQlzIIIwMBpIOWuHfgcZCJRDw>
    <xme:hd6lZ8CyQFCNJtqaWtYlHbvlspjLExmn2CWiIpMz9k6XddVaZpIkRtbF3e34-KFpd
    q8qW_iI9EswO9c>
X-ME-Received: <xmr:hd6lZ_HzhIyrmDRyWRl_JAaR8ypIXebu_HhdNKmS3l_5yjtKrfahCDlLOFutYpaWqV5SlFivbYbeoEQpOx6IaDa-Ifc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrd
    horhhgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudei
    fefgleekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphht
    thhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkuhhnihihuhesrghmrg
    iiohhnrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdp
    rhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkh
    husggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrght
    rdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epkhhunhhiudekgedtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:hd6lZ8TP1WyNx1kbxMojOOtwmY070Ywq6tlelPUO_mARR1hfqo6reQ>
    <xmx:hd6lZ8xSpyyhWe9f-LZLIPB7pI_Yj4r4RlZTQRXxKRxUp0pKwdEwwA>
    <xmx:hd6lZy4lmBTAHkMowxYCwsofkyR5Bgv3JfR1OmKYehHyINQlIh5K7A>
    <xmx:hd6lZxy6NBNqNHGKE6_t7p0N2X0dkm5EiZIO_ZhpiNqr9JPp8Q3OHw>
    <xmx:ht6lZ_xsPNOW1ihsEI9YoHlBC1FoiwpDmJvUhT0egU0NBumRt40dc2a->
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 05:20:52 -0500 (EST)
Date: Fri, 7 Feb 2025 12:20:45 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 0/8] fib: rules: Convert RTM_NEWRULE and
 RTM_DELRULE to per-netns RTNL.
Message-ID: <Z6XefRMDYOQqOmcW@shredder>
References: <20250207072502.87775-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207072502.87775-1-kuniyu@amazon.com>

On Fri, Feb 07, 2025 at 04:24:54PM +0900, Kuniyuki Iwashima wrote:
> Patch 1 ~ 2 are small cleanup, and patch 3 ~ 8 make fib_nl_newrule()
> and fib_nl_delrule() hold per-netns RTNL.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>

