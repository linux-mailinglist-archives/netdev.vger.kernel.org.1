Return-Path: <netdev+bounces-204381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF57AFA35B
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 09:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9095F189DA1B
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 07:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A790C1F61C;
	Sun,  6 Jul 2025 07:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BnDO4eCu"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CF92E370C;
	Sun,  6 Jul 2025 07:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751785234; cv=none; b=NQn9NZzimi4xOOuFymTJ9Xl855SOspmzoBlAPaHeX03mwINCtebI4PFrw8W1wEOczMDHxroB2iu1+pdG0LARyeEkw8Z3l6e0942ydZXI7H6FM/XeTLT2Rfg24SMv9sh/Zh/GfzpCbZh6I2jKxw/+RpbdMcvD2/+4BnMnyi5ildc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751785234; c=relaxed/simple;
	bh=mDNbyJhGKr/Bu9cvC3JXiC/YDLUC3F229aAzmKLlHR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6HkP2CaEJzgr8aqRq+nNrPREkJYfs6K2MeDa5szehVN5zcMB7giXILMgN64myRw6WvhmvgiFo67TmmlBQHGYFACHR1Nh8mBZIpEUuBRKyeESsfpLmd/SWBvTccxMIfPGC46aC3TZZRCEeofPiFzLVPM4Yr/dmoAdNk5vzHKVdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BnDO4eCu; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BF3A0140024C;
	Sun,  6 Jul 2025 03:00:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sun, 06 Jul 2025 03:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751785231; x=1751871631; bh=mDNbyJhGKr/Bu9cvC3JXiC/YDLUC3F229aA
	zmKLlHR0=; b=BnDO4eCuWgQ4clsN671QEXUdgXN9YMG/RI34cWl+SYOaRvM5zxT
	dz1wJgzICbzgmm0evQcqlCTC6g+kxJxwIMILCxkc9o2MZHpCgi1sdwQnO/ryR+gh
	Hat160Ht3cYw8dzdnm9QfPq7J9yV9eHV+/R4SzhYBMhktfsi/Z+tqP7VFEkkAj3w
	yhSyCG3AMqHkS3a4Av1kkhJ47Iupovei3Xyw7zUkguPqnv33Xa0DAeh5g8Nw5wCv
	9CIyC5FFcQPcRsYiMKETIFJYJX5ihRH4ujt5U3D0SeGAfs5rhZOf1r9HlQXcwXSb
	vi0jV4aipcuJqQevBQRvYpAkHntdfFZyhNA==
X-ME-Sender: <xms:Dh9qaAP7p9Vg6PR7ad3pDqfFZGnNBbVOi0rqr4uoLzYJ2kGeX5QfWw>
    <xme:Dh9qaG-uxCz0gocGRhSigDnyKkqzBALhsOg8hC4rCra15zNmNgK1cTr5st-K3_2DK
    _sGeRAeB6sFw5c>
X-ME-Received: <xmr:Dh9qaHRXKswoxEnExR4PvTOwyqo6C2psO_7yiT_drRdf5vLUn2ZqZH-Er_Uo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvkedvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfutghh
    ihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtthgvrh
    hnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeghfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughosh
    gthhesihguohhstghhrdhorhhgpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepughonhhgtghhvghntghhvghnvdeshhhurgifvghirdgtoh
    hmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthho
    pegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhr
    tghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhirhhise
    hrvghsnhhulhhlihdruhhspdhrtghpthhtohepohhstghmrggvshelvdesghhmrghilhdr
    tghomhdprhgtphhtthhopehlihhnuhigsehtrhgvsghlihhgrdhorhhg
X-ME-Proxy: <xmx:Dh9qaIvgbHTY2rhOoIVZ3yuH5KcEK2cof9gRPAJk1-Bmr9DaXn1Cyg>
    <xmx:Dh9qaIdBgCqo4YKx6xIuCRUPNTegckfApD6QnUfg8U0ElwilIC86BA>
    <xmx:Dh9qaM3M1U6jF8-e8IEgbzH41QEdOY25BwpGgX2ReuOYkq6YjzkhtA>
    <xmx:Dh9qaM_yoazUsI3817crBC6KkqrOFhs7IyaDIxpydhPXrIpc8vNnaQ>
    <xmx:Dx9qaEneYxRdO1v43cP-u5WUxjo6REoP9XqQZOVfIXF12GKsr_0jJJcr>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Jul 2025 03:00:29 -0400 (EDT)
Date: Sun, 6 Jul 2025 10:00:27 +0300
From: Ido Schimmel <idosch@idosch.org>
To: "dongchenchen (A)" <dongchenchen2@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
	oscmaes92@gmail.com, linux@treblig.org, pedro.netdev@dondevamos.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhangchangzhong@huawei.com
Subject: Re: [PATCH net v2 1/2] net: vlan: fix VLAN 0 refcount imbalance of
 toggling filtering during runtime
Message-ID: <aGofC6FPhiA3tCKa@shredder>
References: <20250703075702.1063149-1-dongchenchen2@huawei.com>
 <20250703075702.1063149-2-dongchenchen2@huawei.com>
 <aGf11IS6Blvz_XOm@shredder>
 <86aad556-51a7-47b8-872f-8ba1e06727a9@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86aad556-51a7-47b8-872f-8ba1e06727a9@huawei.com>

On Sat, Jul 05, 2025 at 11:05:38AM +0800, dongchenchen (A) wrote:
> I apologize for adding your signature to the patch without your
> permission. Perhaps I should use "suggested-by"?

I'm fine with "Suggested-by".

Thanks

