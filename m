Return-Path: <netdev+bounces-120696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0328C95A41D
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 19:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3560F1C20CC1
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 17:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F98C1B2EDE;
	Wed, 21 Aug 2024 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfxiGxXV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC0B14D70A
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 17:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724262217; cv=none; b=tU9+FyWuVjacOBJN6arbVl4cvvQP03vSR5XtF/ZegtheptNdCoNGRnKZ998jsARDCB2jSM4adSQDT0eu9PtnkYmRADPxIsXXkLMrej6SLEuXZ/mmSvWndMKfbeoR8wl1ZPQ3a5oaQ8O8MWSJOvHLJ2IOR9xXtqFPsehkvg5xLW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724262217; c=relaxed/simple;
	bh=N+YkvIz99IGyeVfRPBrwZTovgPEWZeEgGq7aWXkRxbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1UoykyWCa77syFWXUupKkpboMOLL351zBrQ0KfViUO6KA/TYH0miw1wrrP9fwfdGl+8OuoB4SnAVobaW8j5Z8BO9FNR4fRsrzBc0JB3vcLHQAhmWl+Q4zhXwM3FUOTodSHAZL+MqjNZofJ+ARESwdyYfF0Hzi2Z5KAGsX6dS4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfxiGxXV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D6FC32781;
	Wed, 21 Aug 2024 17:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724262216;
	bh=N+YkvIz99IGyeVfRPBrwZTovgPEWZeEgGq7aWXkRxbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NfxiGxXVQoeHVFWGmB1WRmqch+umMkkHtCvWIsWVAJ7AJaGb5OJr6jd+BBvjdGwvA
	 CNoJFF9jKVVkKlsJRvOezcNzK8MaxYF6Vr10F1ATWVBG0V3xYT0WAfx3Ud4lwHZMak
	 B+1tx6kDz/nQ6fJ50gqVx/skv/sLY5oPhBk6xG7wL0ErB9icFieFvQ6KVJMTCkZ7Jv
	 d5KP60JR5FY15j7oppKJ0iHj2i3JKREB+tHHvl+BAJ3zlFacERVXZPLf/fxfcZHzaG
	 QV9s3gjiXXoWpoyGn7VFkq32HK6gjkN8vYbut8GwDwJiqKseqp7bkwaLKcA6Hb4NDu
	 R0o357Z3379ew==
Date: Wed, 21 Aug 2024 18:43:33 +0100
From: Simon Horman <horms@kernel.org>
To: Krzysztof Galazka <krzysztof.galazka@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-net] selftests/net: Fix csum test for short packets
Message-ID: <20240821174333.GE2164@kernel.org>
References: <20240821142409.958668-1-krzysztof.galazka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821142409.958668-1-krzysztof.galazka@intel.com>

On Wed, Aug 21, 2024 at 04:24:09PM +0200, Krzysztof Galazka wrote:
> For IPv4 and IPv6 packets shorter than minimum Ethernet
> frame payload, recvmsg returns lenght including padding.
> Use length from header for checksum verification to avoid
> csum test failing on correct packets.
> 
> Fixes: 1d0dc857b5d8 (selftests: drv-net: add checksum tests)

nit: I think the correct format for the tag is

Fixes: 1d0dc857b5d8 ("selftests: drv-net: add checksum tests")

> Signed-off-by: Krzysztof Galazka <krzysztof.galazka@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

...

