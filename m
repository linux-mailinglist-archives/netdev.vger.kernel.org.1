Return-Path: <netdev+bounces-104548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 431B990D315
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 15:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4BD51F21514
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893FE160797;
	Tue, 18 Jun 2024 13:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMOK6oyw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65848155354
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 13:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717606; cv=none; b=oYcV6wYhIzdLE7yvJr8J0nEVLuwgssoMuJgQ6+k72hVVwnBMxw/bReSRMbklU3m7jhvH3AZbA3fd2KGg/J34zMdQchURSGPT9iVfDXml6s4VOnJ0375b5uzIZmyxOFrpPwGF8As1dmwBkjtzZOFpfgQm19ldm49O3wiKwtlOpNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717606; c=relaxed/simple;
	bh=JZuxPolsAuRkq/uBpCeDrZdRmxqz2tm0CZN2xEu8kkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlN6wftBZr2te6PNNc0ccy6p6390ZOpA3fFqOiKNxRexyaCbyPRC0CgX7QcksZpd++BWLVgX7fnpZsW/BGUyBSza9874zkqTlk6+mLz2abHCoFL7eK1oVqRTIWUSRYozVwZl4sTt/Gj44BFDpsJDBXEhCOLpNPF/E9PVtaznr+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMOK6oyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F25CC3277B;
	Tue, 18 Jun 2024 13:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718717606;
	bh=JZuxPolsAuRkq/uBpCeDrZdRmxqz2tm0CZN2xEu8kkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iMOK6oywWe2jFel/MCtr2voYqPZp1PbAfEkZPwnNz8U82L97ffeEgbK/X/3V5Nt7v
	 NIOza4F1iQtjYocHeJOFJg6RFO0on6A4rAdVIJ54IbZc0/SsNlPZclVnA+CLtOk7tg
	 HjNj03vEWDJtb/ElnbD5jQc+6ww3HU6DVjdhVcc83ciok2+6wNywjli8F0WT8cmI1j
	 Q8dOMuxxX6FOiuDQlP2Ut+KNZEGjtCeCrU6heg528OYIn4yuwvw8ZXSQOaitoomW8h
	 Ofvi+w9LWQWwLqTb8li2mUEXhBXPLSl9wiXfi1OVFl/mimghgqXq5DRKV0A7YDjYIV
	 4zY0MYgl2Op9A==
Date: Tue, 18 Jun 2024 14:33:22 +0100
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Michal Schmidt <mschmidt@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [PATCH iwl-next v1] ice: do not init struct ice_adapter more
 times than needed
Message-ID: <20240618133322.GO8447@kernel.org>
References: <20240617132407.107292-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617132407.107292-1-przemyslaw.kitszel@intel.com>

On Mon, Jun 17, 2024 at 03:24:07PM +0200, Przemek Kitszel wrote:
> Allocate and initialize struct ice_adapter object only once per physical
> card instead of once per port. This is not a big deal by now, but we want
> to extend this struct more and more in the near future. Our plans include
> PTP stuff and a devlink instance representing whole-device/physical card.
> 
> Transactions requiring to be sleep-able (like those doing user (here ice)
> memory allocation) must be performed with an additional (on top of xarray)
> mutex. Adding it here removes need to xa_lock() manually.
> 
> Since this commit is a reimplementation of ice_adapter_get(), a rather new
> scoped_guard() wrapper for locking is used to simplify the logic.
> 
> It's worth to mention that xa_insert() use gives us both slot reservation
> and checks if it is already filled, what simplifies code a tiny	bit.
> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


