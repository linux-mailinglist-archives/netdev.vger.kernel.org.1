Return-Path: <netdev+bounces-106560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5222D916D14
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 17:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A36E1C22DD3
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 15:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E618B16F919;
	Tue, 25 Jun 2024 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWQHz05g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DE316C68B
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719329341; cv=none; b=kFIB5O2Fuglh9LBDZc6x0Y1K7oon6119RHIeuQ/+prYZf7r3BOgmIAw1uS6+p78cgzBgqoxeTO6X+LZK4n+kJtgo38Ro2kVG+KB/t8mP7HfWLm3sjQWx44hvq4ZM8YET/QjHjy31N62t82ayGsXlPer0UuT/5H0y2xjmwnoEkI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719329341; c=relaxed/simple;
	bh=EO8O6EdfdyW9dTDdUDeQNLaDEsua3G/9Ft1sAUrp0YU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OgqYbf6Kaor4LVNboLwF1ydK6zh9EXfnpCj/1YkPDWkl6AZwDsPIhdUmPd+T+OjiFjIfnUa5JAMESnwFbJFbYFNlnZNAaNGm716bAfCbkTuM0D7iqaE2FHGlBIJRDdsprB4nHz4Ye/kiIWlKEWqdS/zInZTtpd9HYcrwk2usAIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWQHz05g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E0BC32781;
	Tue, 25 Jun 2024 15:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719329341;
	bh=EO8O6EdfdyW9dTDdUDeQNLaDEsua3G/9Ft1sAUrp0YU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OWQHz05gNIJvw1ca46i+Gw5aEwmyWiB2A1rNPDyFssY3aM8nFWcRM0PIEydBEW0xJ
	 oJXsbYTdo4nTXe+mpe37CFOulb4PmcZyu1jGhXxSQ09lYH6o45BFxX+MRKpMHavo+q
	 HEvmkwOsalIXrNDPSkyAxuezL4AgFZ/pxce0R100N9crw7rZQAjikPsfK98D4QRAUa
	 rajak+/LG0ZSxWQfRL/BhNUVD5TvR8NZ6j9lz6+T8clAVsuw9MD35FvcsNzsGnB53D
	 nEjMy57aqOT7b3pKsqBxjcm2XPqDussRMDyeOnKeA7ye7jQllqn6l+zOOwqMsFC6Zp
	 vPPlJUbdxc5EQ==
Date: Tue, 25 Jun 2024 08:29:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chris Gregory <czipperz@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] net: core: alloc_netdev_mqs reduce alignment overhead
Message-ID: <20240625082900.1928b932@kernel.org>
In-Reply-To: <CAH6RvXgctKWU0rdByDZgUNJ9k=6Wf6c=Tw_9ZzH7Un2mZbi-uQ@mail.gmail.com>
References: <CAH6RvXgctKWU0rdByDZgUNJ9k=6Wf6c=Tw_9ZzH7Un2mZbi-uQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 03:58:04 -0400 Chris Gregory wrote:
> I was reading over alloc_netdev_mqs and noticed that it's trying to
> align the allocation by adding on 31 bytes (NETDEV_ALIGN-1).  I'm not
> an expert on kmalloc, but AFAICT it will always give back a pointer
> aligned to ARCH_KMALLOC_MINALIGN.  On my x86_64,
> ARCH_KMALLOC_MINALIGN=8 so this saves 7 bytes which could mean an
> 8-byte allocation is freed up.

We're reworking the priv handling to use a flexible array:
https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
one more series of prep needs to get merged, and we'll convert.
-- 
pw-bot: reject

