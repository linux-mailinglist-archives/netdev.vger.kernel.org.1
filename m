Return-Path: <netdev+bounces-73789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF8985E6CD
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 19:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A86EB26EF5
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 18:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FBE8594A;
	Wed, 21 Feb 2024 18:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9ux9o3d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B2A85923
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 18:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708541802; cv=none; b=LHNMOUl3smW3xKSDWiMc/TgMq65NGi8MTDoM3oBPQgQcuo3OBg5PFoyVhQIPUwLudGSFFD1drdfOk+U5dwUHYcevQiUzbUIT6iylokPaw+0yJWttp6qwc/+lrBGI9S7uox3oNJ9S8pj3yKjw27eGGiV/k++7rY4U6Ht0+7OzGSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708541802; c=relaxed/simple;
	bh=GTeUjlM3ghCSaX6FJV2FC8IbbxSts2XpayBDKQzuhSU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l0o4wUdP3WBsr/nZEHr2jL4KUi0fxPsPw1qOdGiUr9bAGwMerpdqqSrxzYwgys2lujaQSXOudNO7nVUuqNPMrJEn5xjLXd3aApvMEV3NxOBDH65IENGR4kVtML8dJqSsG5Pq9/J8JQikAeg8CHIQE1YTy/9ip/jhUdBCw0ndcxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9ux9o3d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EB9C433F1;
	Wed, 21 Feb 2024 18:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708541801;
	bh=GTeUjlM3ghCSaX6FJV2FC8IbbxSts2XpayBDKQzuhSU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X9ux9o3dYBcdRIDoYB/QVQutscXH2cS4t7O4jZb8Er52uH/EkK3NFmJYIgazG8Mqs
	 4MMPT4iaZC0V/RU3YXgEZlfDmIs9NQQysTJX2UkRn8c5PTR89oXE+kosKU/n6IA/ym
	 QMmoh5AKk7LpEIOqPNQtBc7WYgympDmbQQbtujk3k2Gse1jP9LtPrnWI54BHV++0EJ
	 Ug0zrHNEuN8PfvU/ZZfVsPiJg5LptIBBFusHFb11TdDU+nFwK/G2MEH972Hu3ADCGk
	 b8/4+Rd1bkmIupnKfiLYMxixmVgCFZ58Y4PBBluXMbOk3XRDInExp5vmCKSJau1WEm
	 PxWuCoYPqmTAg==
Date: Wed, 21 Feb 2024 10:56:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 12/13] rtnetlink: make rtnl_fill_link_ifmap()
 RCU ready
Message-ID: <20240221105640.59e6e813@kernel.org>
In-Reply-To: <CANn89i+CvOVkaiXuO5vgggHdzVP17Yzw1WaiH93-fjf2cqnN_A@mail.gmail.com>
References: <20240221105915.829140-1-edumazet@google.com>
	<20240221105915.829140-13-edumazet@google.com>
	<ZdYes3iPqzf0FCTf@nanopsycho>
	<CANn89i+CvOVkaiXuO5vgggHdzVP17Yzw1WaiH93-fjf2cqnN_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Feb 2024 18:15:11 +0100 Eric Dumazet wrote:
> > This check(optimization) is unrelated to the rest of the patch, correct?
> > If yes, could it be a separate patch?  
> 
> Sure thing. BTW, do you know which tool is using this ?
> 
> I could not find IFLA_MAP being used in iproute2 or ethtool.

FWIW I think it's just a blind forward-port of the ioctl functionality.
Would be really great to find a way to phase those fields out of struct 
net_device if not the uAPI :(

