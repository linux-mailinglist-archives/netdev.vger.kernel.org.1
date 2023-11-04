Return-Path: <netdev+bounces-46047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFB87E100E
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 16:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 470412819C8
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 15:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F390418B08;
	Sat,  4 Nov 2023 15:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyuiPhyb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55A91C683
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 15:24:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E07C433C8;
	Sat,  4 Nov 2023 15:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699111468;
	bh=WhRpo2xxmwK6pr+DM4yXtfrXne2vymGmCiN2nZ3RV4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UyuiPhyb1ogmVyBIYcMojgnzUw58fOF6eqDDrbR89yhuuv7TtKR4SoRTEZ5UAe+HR
	 Kw3JL46hOZJLahs6RZsGf3jr/xIRhOi+CRjytFBc5pAbiyEawFmUTRWu7HwNFvmLx0
	 m0CnufiE94fMcTcLHlEbFnDMaMTgDgGkLKgA7EmSkbxhOFCKuXhC0VEBsknoyI3pzO
	 K2Y/Q6qhwutQ3qH0lA6CcXiv5mU7cgcGqtPqIzAfErMfgLC/hjPH0RqUs2UVmRsCnO
	 +dxH54CKE/1kNKNuW0bKyOth00//RS6Yb1RVvd3beV5uOjdOemZ1WA7p7Sdx5l+Xfk
	 VRZaunFLRzWvw==
Date: Sat, 4 Nov 2023 11:24:15 -0400
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Anthony Nguyen <anthony.l.nguyen@intel.com>,
	Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
	netdev@vger.kernel.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH iwl-net 2/3] ice: unify logic for programming
 PFINT_TSYN_MSK
Message-ID: <20231104152415.GH891380@kernel.org>
References: <20231103234658.511859-1-jacob.e.keller@intel.com>
 <20231103234658.511859-3-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103234658.511859-3-jacob.e.keller@intel.com>

On Fri, Nov 03, 2023 at 04:46:57PM -0700, Jacob Keller wrote:
> Commit d938a8cca88a ("ice: Auxbus devices & driver for E822 TS") modified
> how Tx timestamps are handled for E822 devices. On these devices, only the
> clock owner handles reading the Tx timestamp data from firmware. To do
> this, the PFINT_TSYN_MSK register is modified from the default value to one
> which enables reacting to a Tx timestamp on all PHY ports.
> 
> The driver currently programs PFINT_TSYN_MSK in different places depending
> on whether the port is the clock owner or not. For the clock owner, the
> PFINT_TSYN_MSK value is programmed during ice_ptp_init_owner just before
> calling ice_ptp_tx_ena_intr to program the PHY ports.
> 
> For the non-clock owner ports, the PFINT_TSYN_MSK is programmed during
> ice_ptp_init_port.
> 
> If a large enough device reset occurs, the PFINT_TSYN_MSK register will be
> reset to the default value in which only the PHY associated directly with
> the PF will cause the Tx timestamp interrupt to trigger.
> 
> The driver lacks logic to reprogram the PFINT_TSYN_MSK register after a
> device reset. For the E822 device, this results in the PF no longer
> responding to interrupts for other ports. This results in failure to
> deliver Tx timestamps to user space applications.
> 
> Rename ice_ptp_configure_tx_tstamp to ice_ptp_cfg_tx_interrupt, and unify
> the logic for programming PFINT_TSYN_MSK and PFINT_OICR_ENA into one place.
> This function will program both registers according to the combination of
> user configuration and device requirements.
> 
> This ensures that PFINT_TSYN_MSK is always restored when we configure the
> Tx timestamp interrupt.
> 
> Fixes: d938a8cca88a ("ice: Auxbus devices & driver for E822 TS")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


