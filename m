Return-Path: <netdev+bounces-128705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C0397B1E3
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 17:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9910D1C233E0
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 15:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6071A08BC;
	Tue, 17 Sep 2024 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0i2z9oJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662FB1A08BA
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726585827; cv=none; b=iJOfAiaEKN4I8cOUeYRY9aCaUVZ+tkfmYPk+i0FcYGr9ymoHpCXooEZq7n7mf2FzN7cCwnClrcTph+RmC6X86hCMX2oJff4W/kYggQ7P0i4Y08v2lGijKZ4qR9Ao+tG8i68ojv2UB6HkVggxAYdftVhPAtHppp3OoKVeq2pjQC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726585827; c=relaxed/simple;
	bh=zvSlv1a/AKpIl3lLRPp+jlFr+bJSkT6qaU2dFq/1Y3w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D+iFkXw/M/VTYdL7QpiE+7kd/m6HC2TARCvS7VBoqp2D7Xu9TV/BtW0cUbww1KIWQVRBgPdRuLAkVnGcVJBXiz3gKv1wKQGLwHmuMgSi4pVP6rJavz0w42W+pQauqrU1qR6qkqdYGyokH08JXaaHuSdctNRV4PA9hrr4BYJYmeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0i2z9oJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7BEC4CEC5;
	Tue, 17 Sep 2024 15:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726585826;
	bh=zvSlv1a/AKpIl3lLRPp+jlFr+bJSkT6qaU2dFq/1Y3w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M0i2z9oJz1huPOQHu21cKIwvEVThHqT15sbAiPRJXSzhvE/8qtrT7pzHYViRiycsK
	 LHPuefZ/xWWRxMojSTSSI1qYrwhipY0arxaJfU9EOSBEoVdSJWoFM3o3tcLHX3vQSI
	 oY07/mDJrQMSp7hxf3+3f5bNvotN97RJhbyH6AAcqMKcIruC05GY4DULR7MjSJC/qA
	 0ghjieETxHfKKLsWFhVtKILXRk0iFrt5YRF1nVOPPSawfas6TC6UFcwA8ZtNTBR3Ny
	 SyIezepNPfvpRxmtD03US9Ddv4L3LBp3j8M8vGmlyVARCHHheNFbFKJUUxe9cTRlPI
	 V5b+dMsNNwcEg==
Date: Tue, 17 Sep 2024 17:10:21 +0200
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
 Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
Subject: Re: [PATCH ethtool] netlink: rss: retrieve ring count using
 ETHTOOL_GRXRINGS ioctl
Message-ID: <20240917171021.1b7bce2f@kernel.org>
In-Reply-To: <2fsnu2mhk4x5j3bh33pugjfs4e34ys72hmzahdlbctxolfagxj@obbdtitbnax3>
References: <20240913093828.2549217-1-vladimir.oltean@nxp.com>
	<2fsnu2mhk4x5j3bh33pugjfs4e34ys72hmzahdlbctxolfagxj@obbdtitbnax3>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Sep 2024 21:38:14 +0200 Michal Kubecek wrote:
> I have asked this multiple times but I never got a direct answer: is
> this only a formal terminology problem or is there an actual difference
> between the two? In particular: is someone aware of an example of
> a driver and device where these two counts differ? Or is there a reason
> to expect such device either exists or will exist in the future?
> 
> (Actually, I seem to remember that the first time I asked, the general
> consensus was that combined + rx is indeed the value we need here -
> which is what current code does. But it has been few years so I would
> have to look it up to be sure.)

The change in perspective comes from the potential for dynamic queue
allocation in the future. We don't have the exact details but it's
possible that we'd choose to treat "channels" as NAPI instances rather
than queues. And more queues can be dynamically opened by the
applications and attached to the existing channels.

