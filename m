Return-Path: <netdev+bounces-227494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB9FBB1286
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 17:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7D634A7E26
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 15:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E55126E71F;
	Wed,  1 Oct 2025 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUo/NYvy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790141FCCF8
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759333438; cv=none; b=UCVm9tc8Ftp2zTvxloTupLtJE1Iv5Gxd33i3oBulUQM80eLc0YQJYnxdBOFaP+gCUyB4VPWyTMSuSEVLV9VD5IE5DKCWOcdYslWruOrzeQXLY3TwKILPmuOYH15z5R4EaHph3iZvaLl7DqgrHUF4ig6tuj88JPsedI+208ckBbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759333438; c=relaxed/simple;
	bh=0FjaBLp0dpdaIUjdsYa5N7xObF6Jj6Zej+/l9PeTTFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSBzqtZUAZQX/IIzde0NOFtNT8cM4noJx3tGFRsv4aBfWIUnKHRb7GNlnPQIM9yZaW6kK9QHwrk1leDFREYhzKJhHhi1LemahBjHvxE3bErTMVBmOoiBiBZXmrGrJewhm5s12d/xcLGGEJ4aLPagrLEwJTcqyFNWUthbA0UioGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUo/NYvy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED794C4CEF1;
	Wed,  1 Oct 2025 15:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759333438;
	bh=0FjaBLp0dpdaIUjdsYa5N7xObF6Jj6Zej+/l9PeTTFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QUo/NYvy4edVIFlngPRGMBTo3I/nXh1GHvulMs54p+zyrbtN+QV9WepZZuTVwX7cn
	 gOa4X09GobHbSZf0FtxcPjGSGahRJIydO2CNrV2UYLd+DHyaWNBBIVzYC8/gujcPEg
	 0wwoEfLuwv/BcDnON143SFR2h+2qi++dy88wdSnZDSDU1zhmkYExpASY0D6BsBDbXq
	 qEPWdVx/pSVLNeDQ09m8nNPM5WUJxt+fgK6hww1etRDCdFbmdaEIgEiU2xRUFQ9Q2j
	 1shDXHrTDz39BnY66gsXvhW6MrAIlF6w5Q1LF/fZJAatkn7c3wauI0S/MRgWxAiEio
	 4ZjwYJhdbE/Tg==
Date: Wed, 1 Oct 2025 16:43:54 +0100
From: Simon Horman <horms@kernel.org>
To: Sreedevi Joshi <sreedevi.joshi@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH v2 iwl-net 1/2] idpf: fix memory leak of flow steer list
 on rmmod
Message-ID: <aN1MOnqvkl7nZxZ7@horms.kernel.org>
References: <20250930212352.2263907-1-sreedevi.joshi@intel.com>
 <20250930212352.2263907-2-sreedevi.joshi@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930212352.2263907-2-sreedevi.joshi@intel.com>

On Tue, Sep 30, 2025 at 04:23:51PM -0500, Sreedevi Joshi wrote:
> The flow steering list maintains entries that are added and removed as
> ethtool creates and deletes flow steering rules. Module removal with active
> entries causes memory leak as the list is not properly cleaned up.
> 
> Prevent this by iterating through the remaining entries in the list and
> freeing the associated memory during module removal. Add a spinlock
> (flow_steer_list_lock) to protect the list access from multiple threads.
> 
> Fixes: ada3e24b84a0 ("idpf: add flow steering support")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


