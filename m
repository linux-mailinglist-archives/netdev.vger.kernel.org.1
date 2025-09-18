Return-Path: <netdev+bounces-224463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EAFB854BA
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 16:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9261C7AE2B2
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 14:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD022206BB;
	Thu, 18 Sep 2025 14:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIL1fY4r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B2F1F9F70
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 14:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758206446; cv=none; b=ZW2wJZ+yJ7bN2xwoQEe21arR/hBPysqd7wPBrwJHS4+Y3OHT/jG6kd76A/RLpTEoLyTuVoN0FnrLVPogk1hoRJiRvp2NAGb+B21joMiKD3XcHXTO8J9tkXLirBIBhGFMcL42u+LeeyQEW+IE5+ht/6Z9SEXvq4goDkyNJOSNatE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758206446; c=relaxed/simple;
	bh=Lf3DkMG5CSfOckaU6onnP263E2CUT5+6A9+k8/tvYqM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LHtbJk6Jp7DtvHZLxRViskGIwCxhQa3p2Xbt8gn/H7Vs5sRQQFJpXqd4G6HKG+SnViCnJeLbG+HSI/oYIm3YIMTSNDXnNsay+rEQ17XgtdA2/Uk6MJGicgTrPK1FA7nh4fyULi/pJ0pHOdj9s4edR+czr3B4btkB0wic43yGDkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIL1fY4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08552C4CEE7;
	Thu, 18 Sep 2025 14:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758206445;
	bh=Lf3DkMG5CSfOckaU6onnP263E2CUT5+6A9+k8/tvYqM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZIL1fY4rmW6BOX721LiMRpVNCdWyKsX/5ajxk+VSvpH6f/FllLOdcRMGCh/CD4v5B
	 CL0rkh6FsbBs5oJrW/17+IX5scqPkpX+ekJWmxcYk0Kg0Btn1SOmAJAlNgC/FyhCEq
	 qF/YTykFUWbqU1BpvmgqH+EA20+ZhLm+U52elFLkbXONw1YVSsHlE/mRHOZph+uO2h
	 Hu0cauc5PVCeB/V5sUkFgJRKzxxJhLKIrkxCdDRxMrQttTrRaOTX6IhYguZBT7N3A0
	 PpLT+tD8QT9aZnSNjhm64RjNOJQsnphuXV3t5pStapRIDA461cPBzmUP7Ka4sn0oSm
	 7cCiNp7fvKsPg==
Date: Thu, 18 Sep 2025 07:40:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, intel-wired-lan@lists.osuosl.org, Donald
 Hunter <donald.hunter@gmail.com>, Carolina Jubran <cjubran@nvidia.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Yael Chemla <ychemla@nvidia.com>, Dragos Tatulea
 <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next v3 4/4] net/mlx5e: Report RS-FEC histogram
 statistics via ethtool
Message-ID: <20250918074044.4b3e8ac2@kernel.org>
In-Reply-To: <28315831-21f7-49e0-b445-b3df0cb123e0@linux.dev>
References: <20250916191257.13343-1-vadim.fedorenko@linux.dev>
	<20250916191257.13343-5-vadim.fedorenko@linux.dev>
	<20250917174837.5ea2d864@kernel.org>
	<28315831-21f7-49e0-b445-b3df0cb123e0@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Sep 2025 15:32:51 +0100 Vadim Fedorenko wrote:
> On 18/09/2025 01:48, Jakub Kicinski wrote:
> > On Tue, 16 Sep 2025 19:12:57 +0000 Vadim Fedorenko wrote:  
> >> +	for (int i = 0; i < num_of_bins; i++) {  
> > 
> > brackets unnecessary
> > 
> > in the other patch you picked u8 for i, good to be consistent
> > (int is better)
> >   
> >> +		hist->values[i].bin_value = MLX5_GET64(rs_histogram_cntrs,
> >> +						       rs_histogram_cntrs,
> >> +						       hist[i]);  
> > 
> > could also be written as:
> > 
> > 		hist->values[i].bin_value =
> > 			MLX5_GET64(rs_histogram_cntrs, rs_histogram_cntrs, hist[i]);  
> 
> this doesn't actually fit into 80 chars (84 chars long)... unless we are
> not too strict in the drivers..

Thought it did, ignore the suggestion, then


