Return-Path: <netdev+bounces-168091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3FDA3D6D9
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 11:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54F7E1889951
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 10:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D801F12E0;
	Thu, 20 Feb 2025 10:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+i/YW5K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0060D1F0E42
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 10:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047764; cv=none; b=ev9tNXMHXszom67hUt2h8U2Drsn27OGbo4ntCDog0leN077gEhEpfMg+A0KhM2s8+psXNSGV6zOQUZpaMPtcyi6giLdEG/u/gc2ST6hFR6L1mPrs/6p6KyKEld31aMiebcm3IdTGcrtRGeQZoMRKABo9waOuWtC/diR4meFK4NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047764; c=relaxed/simple;
	bh=CJnGEjaN9vYPa25ichp/mCuT5HuHhCyp+4a++Igkrws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qx8TdJ04TOVV/9n9G4waUYa3FM5lPYG6gtsW6Ss88asdrO38gxadxBObrOIOODPDvY77gYYxtt778KdhcWV6J7jY9Qskc6ytZ84YH+AqsE7dHsVbh/kIPsJ+cL4oH4WO+yrwHqgfssmkzSNKc8JWi9QVthn33AibcQpYEaiv14Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+i/YW5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7436DC4CED1;
	Thu, 20 Feb 2025 10:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740047763;
	bh=CJnGEjaN9vYPa25ichp/mCuT5HuHhCyp+4a++Igkrws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N+i/YW5K01c/vmNLsoX0b6y039HTdNmzs3uIkVEL3i7LuUKa/NBZqUKprY+OcQjdJ
	 gWDWx9nlWXQzYG4BqnqtnoSw2GFUqG5kk3x6puzJ/CpMLY53oR44VRsKwSXQoAaaG2
	 3pEin/gXlmUMk66SNktzB8TB3g1BsP2ISQBxVAJx7t7GJzCvLrnhjGHYhbDhwaqevE
	 wHxErKA87hVcvT1GSqPaY0Ps62zFZz2RtrPFU49qhyGytQYUTcYplNnOthTfnwZDh+
	 i7dH1pt/rYgigkpLCMwFBDTSHcZSjsbngkcbvaI3EnaUipaI0PTrdrdKbXihli+LbI
	 rbJtvPyI+5+gA==
Date: Thu, 20 Feb 2025 10:36:00 +0000
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev <netdev@vger.kernel.org>,
	Anthony Nguyen <anthony.l.nguyen@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: Re: [PATCH iwl-net] ice: ensure periodic output start time is in the
 future
Message-ID: <20250220103600.GS1615191@kernel.org>
References: <20250212-jk-gnrd-ptp-pin-patches-v1-1-7cbae692ac97@intel.com>
 <20250215145941.GQ1615191@kernel.org>
 <bb42f26c-ee15-4ff9-a8fb-09669b727ced@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb42f26c-ee15-4ff9-a8fb-09669b727ced@intel.com>

On Wed, Feb 19, 2025 at 02:30:25PM -0800, Jacob Keller wrote:
> 
> 
> On 2/15/2025 6:59 AM, Simon Horman wrote:
> > On Wed, Feb 12, 2025 at 03:54:39PM -0800, Jacob Keller wrote:

...

> > Thanks for the excellent patch description.
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > 
> > ...
> 
> Lol.. can't get anything right this week.. Just noticed I had already
> sent this but forgot CC to Intel Wired LAN, so it wasn't showing up in
> our patchwork.

Lol, but the patch description was good :)

