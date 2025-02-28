Return-Path: <netdev+bounces-170811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCDEA4A01C
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 18:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439A41890168
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 17:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDB01F4CAC;
	Fri, 28 Feb 2025 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rh0LMl0X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFFA1F4C86
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740763145; cv=none; b=SuiHdWHH59UpDFmwwQ+k7zVZ1fqfCNwNagU+d7B/PsCimqTmssyfo0m9HxfLvCC2YLDUEK9OYCesGOwnjnrfbq8RNvH6JUvtK5EXtcUPyJGAm8zvrA2m2X5mQ9jo9Z3wnd4eKrK3nsomnzQxtZf1JYy4ODZE/PfmSr3t8WgmiVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740763145; c=relaxed/simple;
	bh=3MrgstQePIvcsa2zhz0+y++t+2iL5vyrmilS1Ep7/NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lxg7Rw4j9LAVvEMf4r5YdoKH7jVNF7+b1AG+ctQNknUJ81G1bHIfs59Y7YNFyJCn1ZK8X9w9T3G75R3l+wK4V308qS78kAtKYzJg+Dee/IuQ8zWnPuOC0NPQEpLIn/WSBvOPt+3kBA03a2OjQX0AoiEFvvmGrUmKSeAgb/dy76w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rh0LMl0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9174C4CEE8;
	Fri, 28 Feb 2025 17:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740763145;
	bh=3MrgstQePIvcsa2zhz0+y++t+2iL5vyrmilS1Ep7/NM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rh0LMl0Xufcdsu8doj7CnKPlujmmfVXEBRMQ0niz2dnuyYshYkHePS+oGSc3OjXi2
	 b3X9F2oE+5WRd4lrZYprXx1xwXTvHI99bVaxMx029B0XEZWPoNCj7TfrL4gSx1Q8/x
	 7vYWABvIij1MoUOR7ZuDHpssnvtnHrTqv0EyuUuPUgtultqEZP8QyhhmRXNXbmXWn3
	 y1ButkIrzuRg7de96+lXuYg/CRwjAwxy/MSv+7Gwv53HPkUYZCcoUgRUPW28Ua752b
	 cAOmztv/Fim7hLcHmjSfsw22wV1C+2PF6OFtO0L/GSGyCCwRsU+fBDGDq+/UPSesCc
	 GRmfM639NKKwA==
Date: Fri, 28 Feb 2025 17:19:01 +0000
From: Simon Horman <horms@kernel.org>
To: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: Re: [iwl-net v2 4/5] ice: fix input validation for virtchnl BW
Message-ID: <20250228171901.GP1615191@kernel.org>
References: <20250225090847.513849-2-martyna.szapar-mudlaw@linux.intel.com>
 <20250225090847.513849-7-martyna.szapar-mudlaw@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225090847.513849-7-martyna.szapar-mudlaw@linux.intel.com>

On Tue, Feb 25, 2025 at 10:08:48AM +0100, Martyna Szapar-Mudlaw wrote:
> From: Lukasz Czapnik <lukasz.czapnik@intel.com>
> 
> Add missing validation of tc and queue id values sent by a VF in
> ice_vc_cfg_q_bw().
> Additionally fixed logged value in the warning message,
> where max_tx_rate was incorrectly referenced instead of min_tx_rate.
> Also correct error handling in this function by properly exiting
> when invalid configuration is detected.
> 
> Fixes: 015307754a19 ("ice: Support VF queue rate limit and quanta size configuration")
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
> Co-developed-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
> Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


