Return-Path: <netdev+bounces-202343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC00FAED6D2
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 10:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 205FF167AAB
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 08:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7EF23A9A3;
	Mon, 30 Jun 2025 08:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R8AqnpY1"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210AE1E7C34;
	Mon, 30 Jun 2025 08:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751271252; cv=none; b=lKI5iMzAPUFG+gLNnAlqw3ZrDpnjgpCHF3KS8OkYSoetIIBFc1CQ/MTIz1W7s5u5xSkG2Pa3O619WPa8g7N4EIJR7z4F6eK5GnSlctbLBXLRrxitAFXMeHZHBeCj/PWKitQr2BsWA6+Th2RyI8gxpgL8YHN+I9m3mLhuuE2TKLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751271252; c=relaxed/simple;
	bh=a60vtETJ/JM85TNVBagVjAMPzqFDljbRzobbmKIfqHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bi8P/ibRWaTyjZmuwrmXFpd5ZEK00bmfh3q5z8DnYpH7f74CZgXp+U2XN5WXYuC32UFXQf/ze81HuuRYiZ7VhDhANvki86lYV9IjzSGiHXZLJTwSd83Ve1uWXaAAExSAg1KUfMyQNr1mjnhqOoEJiadIE0EW9FzSKLe7Tz9X4CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R8AqnpY1; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 3AEE3EC0241;
	Mon, 30 Jun 2025 04:14:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 30 Jun 2025 04:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751271250; x=1751357650; bh=n61+67aB6zlZyFM7WxNTxjRswU97fHEw4Ql
	+K/EX/X8=; b=R8AqnpY1TrkNi4/1JO1gRV/8vAge7/jfv/0Cw1A4ZZQ4mecVZyq
	0pAWvMScWGYQFBPnumbUSdKatBiw1JsY5qTcgVlF+R+lm6U154bmYwqfW9yopAIw
	tK89De9emCJ58dDKDP8Rp7pzWvJeyH63Yap3uxC2eD3BBPyKlN0i4r92RGeyjtVd
	UZeQs//63fuVQ8t+Be/mC1paz4mEQlRHuVZiNwQYvPRt1/TAWSP/CJv1E3DjuOGg
	JNWBPPoOjewoDE8q0QbaL0vcyPErpwwia2xJ/CNiqjCG05UBw/PtHVTK0XCyQo0B
	DNmZ7SuWabEa8oAQzYUx0mYPzSD/Ls/ZCag==
X-ME-Sender: <xms:UUdiaE0KIAHKSAa_DghfFvYq8_l_f_-VHRe6V7v04xxuQNiZmKFGLA>
    <xme:UUdiaPGs19BDi6pWGRv7yTi8c1KQ6KNoHnNECLrc_p2twukECLrdby5xUajLm2757
    a_nHGEgIoBPjkQ>
X-ME-Received: <xmr:UUdiaM6AwRQmyXMlr9JTz1XNSF0orbx54Wn8PSl88LAgelt028vBAMGCnLoK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfutghh
    ihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtthgvrh
    hnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeghfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughosh
    gthhesihguohhstghhrdhorhhgpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepughonhhgtghhvghntghhvghnvdeshhhurgifvghirdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghv
    vghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhr
    tghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhirhhise
    hrvghsnhhulhhlihdruhhspdhrtghpthhtohepohhstghmrggvshelvdesghhmrghilhdr
    tghomhdprhgtphhtthhopehlihhnuhigsehtrhgvsghlihhgrdhorhhg
X-ME-Proxy: <xmx:UUdiaN1X6FZeaUd2gvbl2vIs2N6ib5BdkGMakus58m5yppiDbL2BQg>
    <xmx:UUdiaHG73aFweXKnlqUIlY2hhnR1gJ8OAU0JWyh-mhsRQfaCHkjI_w>
    <xmx:UUdiaG_x4myF7N0mREVrWUHPmOvs9YqHwuq7gOoJCeVlG7xrCjxSBg>
    <xmx:UUdiaMkXfIiT6kvdqBTBpfJ7_hSNzx0mKh9EXtkMPSYN7StNwT81gw>
    <xmx:UkdiaHvrvyHDDj5yVyIYyBvUlQ31KosWy-E385LKqaQA1Id9zk1jpoY->
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Jun 2025 04:14:08 -0400 (EDT)
Date: Mon, 30 Jun 2025 11:14:06 +0300
From: Ido Schimmel <idosch@idosch.org>
To: "dongchenchen (A)" <dongchenchen2@huawei.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	jiri@resnulli.us, oscmaes92@gmail.com, linux@treblig.org,
	pedro.netdev@dondevamos.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
	zhangchangzhong@huawei.com
Subject: Re: [PATCH net] net: vlan: fix VLAN 0 refcount imbalance of toggling
 filtering during runtime
Message-ID: <aGJHTh7aB26PGRFN@shredder>
References: <20250623113008.695446-1-dongchenchen2@huawei.com>
 <20250624174252.7fbd3dbe@kernel.org>
 <900f28da-83db-4b17-b56b-21acde70e47f@huawei.com>
 <aF6tpb4EQaxZ2XAw@shredder>
 <6ad61ca2-606b-4f1a-a811-47e5cfd48c38@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ad61ca2-606b-4f1a-a811-47e5cfd48c38@huawei.com>

On Mon, Jun 30, 2025 at 09:25:42AM +0800, dongchenchen (A) wrote:
> 
> > On Thu, Jun 26, 2025 at 11:41:45AM +0800, dongchenchen (A) wrote:
> > As I understand it, there are two issues:
> > 
> > 1. VID 0 is deleted when it shouldn't. This leads to the crashes you
> > shared.
> > 
> > 2. VID 0 is not deleted when it should. This leads to memory leaks like
> > [1] with a reproducer such as [2].
> > 
> > AFAICT, your proposed patch solves the second issue, but only partially
> > addresses the first issue. The automatic addition of VID 0 is assumed to
> > be successful, but it can fail due to hardware issues or memory
> > allocation failures. I realize it is not common, but it can happen. If
> > you annotate __vlan_vid_add() [3] and inject failures [4], you will see
> > that the crashes still happen with your patch.
> 
> Hi, Ido
> Thanks for your review!
> 
> > WDYT about something like [5]? Basically, noting in the VLAN info
> 
> This fix [5] can completely solve the problem. I will send it together with
> selftest patch.

Thanks. Please add tests for both cases (memory leak and crash).

> 
> > whether VID 0 was automatically added upon NETDEV_UP and based on that
> > decide whether it should be deleted upon NETDEV_DOWN, regardless of
> > "rx-vlan-filter".
> 
> one small additional question: vlan0 will not exist if netdev set rx-vlan-filter after NETDEV_UP.
> Will this cause a difference in the processing logic for 8021q packets?

AFAICT the proposed patch does not change this behavior. Users can bring
the netdev down and then up if they want the kernel to add VID 0. My
understanding is that "rx-vlan-filter on" without VID 0 will cause
prio-tagged packets to be dropped by the underlying device.

