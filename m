Return-Path: <netdev+bounces-142595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5C89BFB50
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 02:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496231C2114F
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 01:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A67ABA50;
	Thu,  7 Nov 2024 01:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ja9eSf/Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342BA8F5E
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 01:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730942513; cv=none; b=IOQWZLKJTnbk/79xuHGuRfLct3uKNxXpbHoS5/jk8mlMZLm72zgvbZCo5tlmSUVQ1jNvJKTknY81xe4LeLN5l2CTJGCWh/CjGZtqWHTYxM+ZdiPBs9UnoG9S1M7rHodaVn9J6TotF0iQXCGYdvSafFwP2E2pnB1VWnWQp6buv40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730942513; c=relaxed/simple;
	bh=pkHD/OtCznwZzpggjAFdi8ei7lk7zqLHQRmlMD2nkBc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YRf1KAeqEqFutEVNH86wSsyjK3Uu3OJBhUnT2ZJOPfIN+ck+TFN2Cy7tB8LiEA2WAsJxAWmoKRhWDkODQtOR4PrKwLDSt/woDublNHdvDWWEJJ1jNNVbjxeTlRMQk2bvLNei/kqSseflGKnSez/4UvxmEi8wRApc8LgffrFq3aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ja9eSf/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E461C4CEC6;
	Thu,  7 Nov 2024 01:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730942512;
	bh=pkHD/OtCznwZzpggjAFdi8ei7lk7zqLHQRmlMD2nkBc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ja9eSf/QgHWjbxE6z2Ovitn7CYhEgzQrz4/cqu6YQa5LgBhzfRe4DaKf4EWX54I9g
	 vU3dEIGe1EZhJ/YV9sMpwdOI9yium0tdkDIVm4eiysfEJDhwYnAUMAdqmBPqmj9LaE
	 9NpAe/OWCEoC6/VR8AG3qpw8eYFM/1QW8THk7wryjQqglzGmOOJHMEqy5nsL+ggNgy
	 vXqLlHmRt9PqarvZ1mdMBgQqwcc4Lvn/ZmJalb2yK1JNx0NKQjeZeQw0TOfvQTMt44
	 bl9ACA/fYs6LE03jx/Cd5lpSOUdMjkZkj3sNTKBIfZZzq9DpNAxsCr3DhZRtuivlKv
	 ztGjt5BY+/Mgw==
Date: Wed, 6 Nov 2024 17:21:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Hangbin Liu <liuhangbin@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>,
 netdev@vger.kernel.org
Subject: Re: [Question]: should we consider arp missed max during
 bond_ab_arp_probe()?
Message-ID: <20241106172151.13cd3964@kernel.org>
In-Reply-To: <Zyt_58BFKnZvtsHx@nanopsycho.orion>
References: <ZysdRHul2pWy44Rh@fedora>
	<ZysqM_T8f5qDetmk@nanopsycho.orion>
	<Zys2Clf0NGeVGl3D@fedora>
	<Zyt_58BFKnZvtsHx@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Nov 2024 15:40:39 +0100 Jiri Pirko wrote:
> >> Out of curiosity, is anyone still using AB mode in real life? And if  
> >
> >Based on our analyse, in year 2024, there are 53.8% users using 802.3ad mode,
> >41.6% users using active-backup mode. 2.5% users using round-robin mode.
> >  
> >> yes, any idea why exacly?  
> >
> >I think they just want to make sure there is a backup for the link.  
> 
> Why don't they use LACP? You can have backup there as well.

FWIW I was asked to help with A/B setups in the past for facility
networks (building sensor etc). Those guys wanted to do as little
networking as possible, and had very low bandwidth needs but still
wanted the redundancy. Basic active/backup was a good fit.

