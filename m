Return-Path: <netdev+bounces-108014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EB891D8C8
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 09:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 963281C2101A
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 07:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F9E64CEC;
	Mon,  1 Jul 2024 07:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsPE8vfQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2662323A0
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 07:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719818242; cv=none; b=mBqotfQSrDjk7miydlwHZcHP2k8hMfkFlCXP5mqmAm+cJPDW6ZaZgSsrDPR8qN0VHMCmrXYQ4anlzSIklIMcQSopb8Qlv4G/nNcM7+8uXZKEeweeadcoU/FRhSPQ6+gb8r4vDrojqx4dxV5XO+hx1yOzyZV1u1G+FFzmHZO8bu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719818242; c=relaxed/simple;
	bh=nyfMjH+xq1DfvsjR8wyNnR+EV1kOCdQXGtlnpIKJCXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3S9xOquL9mOlLdT02vFe9Ixtovc/A42HdRtfs1whtbMaLlMBKcu0t8DA82K79Z4LOhPvQ5VhGcu7LtNCgvon1gzeoMKF4dBqE13by3SVSMUrS2f9f97iVzHjJlkj3NxsEF99WcQHl+FHQyv2MUNGC+i0X4B/5CFoo07ZI+VvkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsPE8vfQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04AEDC116B1;
	Mon,  1 Jul 2024 07:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719818242;
	bh=nyfMjH+xq1DfvsjR8wyNnR+EV1kOCdQXGtlnpIKJCXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dsPE8vfQYdbF3+EtbveaOSstpFBrBin2tEhbTfCLdJZYIWGLxFSkW8kfKaBME12uk
	 XVK97o3oPw5pakEM1+TFmJNzeiFp7ZOpxTpebHlMGZQNROlsnfoEd5OB0Nw+gLQC0h
	 ujOJASDWx5MHvVhu9jaf9cUFUKyhIbSdooET4/gaOhmDatKfMC3JFExnHSvyANPe93
	 g6pivLQrsFzAd3IevKASJszwdfQkoRWbATLgwHe7bcWaaUzStnhmUifLgZRKGWmADc
	 n9bHpSlVWKmojEzgjofqpDVD9j89c/iPizmTvR8X4hiwiykIrC/3eFdRqieMFjShDk
	 ZtgR6CfhQ733Q==
Date: Mon, 1 Jul 2024 08:17:18 +0100
From: Simon Horman <horms@kernel.org>
To: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v2 2/4] ice: Add ice_get_ctrl_ptp() wrapper to
 simplify the code
Message-ID: <20240701071718.GH17134@kernel.org>
References: <20240626125456.27667-1-sergey.temerkhanov@intel.com>
 <20240626125456.27667-3-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626125456.27667-3-sergey.temerkhanov@intel.com>

On Wed, Jun 26, 2024 at 02:54:54PM +0200, Sergey Temerkhanov wrote:
> Add ice_get_ctrl_ptp() wrapper to simplify the PTP support code
> in the functions that do not use ctrl_pf directly.
> Add the control PF pointer to struct ice_adapter
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


