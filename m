Return-Path: <netdev+bounces-143587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B5B9C3228
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 14:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B3428134B
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 13:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22634101EE;
	Sun, 10 Nov 2024 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVY7iBPy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FF9C13C
	for <netdev@vger.kernel.org>; Sun, 10 Nov 2024 13:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731245506; cv=none; b=nklJWQSD7WsysInKnLs+0clgQCGtzPiM/wm9qzvCEmYUEM8vOAVboTUQjqIdMj/cGtrjbojLZuQNxeWqfg4aSvuhgrzyxbe2JHsooceOBBs+sAo5CYjI7+/8TEQmZZ62juLE1e1m2c+HrSl328uk+Yzsmaxn9PFHHnbT+D7cXJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731245506; c=relaxed/simple;
	bh=VNBdV47EGFR+JVQgcO3mjSACcZCsxTHBYhlLqfmtixA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VR7RImwdzAKAw3974vEO3d+VEMLWDpNRouEq1sUraeUr+CwGRWOSLzSU3GgWkYJbrSzgafoxFD3mazgx7rr9I2EWjc+a5NbJPoJYw1GhyNIZvfsw4UthVzElLLQIexF8ikcFxKrL6tzLQ2iKYQb/FqfVTKUwsdZbIueGAM1fTgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVY7iBPy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A64C4CECD;
	Sun, 10 Nov 2024 13:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731245505;
	bh=VNBdV47EGFR+JVQgcO3mjSACcZCsxTHBYhlLqfmtixA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hVY7iBPy98gYKQ8ZMWDb/VBRjfBe+KRqpEK2VGBZvQbo7eTEsQxZKn5/lHUZPIMmK
	 1welYCaSK5Fzea/IrWLYbuuQxB1qCLfaBzWTkahIVbVyUq+iusDCvskOxFaim4eHaw
	 kIfj5LvJQdssrGHsu5Pwti0AwUruz/hGokjxXoH83u4U0gJxSegYdnwwrGZodCX+Sw
	 IQ5WhFhtnqXCUIh2ShI0IRXQk7ItbqwTo2qutqqgTDEttrIoBXyFYtSSJ2GqQteSWz
	 87C67cnVljR7QWYt0P/9jydYOtR7QXanLJ6baceH7PlQDS9rUNIfMXI3W5/ryfUHfg
	 6hRey/f9HObdw==
Date: Sun, 10 Nov 2024 13:31:41 +0000
From: Simon Horman <horms@kernel.org>
To: Mohammad Heib <mheib@redhat.com>
Cc: netdev@vger.kernel.org, irusskikh@marvell.com
Subject: Re: [PATCH net] net: atlantic: use irq_update_affinity_hint()
Message-ID: <20241110133141.GN4507@kernel.org>
References: <20241107120739.415743-1-mheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107120739.415743-1-mheib@redhat.com>

On Thu, Nov 07, 2024 at 02:07:39PM +0200, Mohammad Heib wrote:
> irq_set_affinity_hint() is deprecated, Use irq_update_affinity_hint()
> instead. This removes the side-effect of actually applying the affinity.
> 
> The driver does not really need to worry about spreading its IRQs across
> CPUs. The core code already takes care of that. when the driver applies the
> affinities by itself, it breaks the users' expectations:
> 
> 1. The user configures irqbalance with IRQBALANCE_BANNED_CPULIST in
>    order to prevent IRQs from being moved to certain CPUs that run a
>    real-time workload.
> 
> 2. atlantic device reopening will resets the affinity
>    in aq_ndev_open().
> 
> 3. atlantic has no idea about irqbalance's config, so it may move an IRQ to
>    a banned CPU. The real-time workload suffers unacceptable latency.
> 
> Signed-off-by: Mohammad Heib <mheib@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


