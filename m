Return-Path: <netdev+bounces-65154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 843CA8395EC
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 18:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 348E51F2E15E
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61BF80021;
	Tue, 23 Jan 2024 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sh1gGDQN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919EA62A0A
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706029635; cv=none; b=UF4hsTEOH185pcdn6rE3E7lj29Zg374/AACF+LFQMRdDvzOSf+TuAkKJKBCtUQYQcwC5Lx9bazpSzWppvUwIj3jZ+xWisVQH6TXsAfVkg7SVmNOFrjVSbVWIYL4YYKG3TIUv1avfIWrmI3xMYDhQ/zlJbkjdoOWP87RLOtPoBLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706029635; c=relaxed/simple;
	bh=wpbM9x7x1JCmm5dR/KOBtftHAc6l/wBK2x9iHxRpaRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3Yfnu0/VE02eNEj3QumIyKZwuISsVe6wDHMQAM3Po2xMtSESUNm36lQi8XZBXVdH5dYJw6wKqqt61EhVM31/owD0KVF+6yib0YSuCi7+MyMXVLdc7AjjRCd8fGVSEBBOUblywPTA+brn/N0xoJ7WxN3Nqt6KO/6jdXzQKPqVz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sh1gGDQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFD7C433F1;
	Tue, 23 Jan 2024 17:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706029635;
	bh=wpbM9x7x1JCmm5dR/KOBtftHAc6l/wBK2x9iHxRpaRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sh1gGDQNxukoNdgoRrl8bGFO1xwzQczRNhj93Uf7HbdHR+DsOORXnk3A3o6B3Zisj
	 1gkP5TefdckfqOUDr1L0+sVXxXptBo6WFRZth2cW02RjdZ4KrvYeJnDUli4uG2ymHH
	 VtXLRehJFEXBlY/JoCcvWpnfl+BO/P+VeNoOzJQKmO8QENcewp9OUbA5IgoU350BC6
	 wZxW6VvQw//iApftxJr6ah8Kml8+2iOBieLbpVoJdBG2o3eNaCJ3ZiLxU/9Dxr0Mfg
	 PtdiqPqXCzsSB3s7ZTHRIe1q7o7zJDbE893L0RRwePneF2vDAxsinsuRmYWrr7dqhu
	 8OioapS3WSLjA==
Date: Tue, 23 Jan 2024 17:07:11 +0000
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, jesse.brandeburg@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v7 iwl-next 6/7] ice: factor out ice_ptp_rebuild_owner()
Message-ID: <20240123170711.GL254773@kernel.org>
References: <20240123105131.2842935-1-karol.kolacinski@intel.com>
 <20240123105131.2842935-7-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123105131.2842935-7-karol.kolacinski@intel.com>

On Tue, Jan 23, 2024 at 11:51:30AM +0100, Karol Kolacinski wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The ice_ptp_reset() function uses a goto to skip past clock owner
> operations if performing a PF reset or if the device is not the clock
> owner. This is a bit confusing. Factor this out into
> ice_ptp_rebuild_owner() instead.
> 
> The ice_ptp_reset() function is called by ice_rebuild() to restore PTP
> functionality after a device reset. Follow the convention set by the
> ice_main.c file and rename this function to ice_ptp_rebuild(), in the
> same way that we have ice_prepare_for_reset() and
> ice_ptp_prepare_for_reset().
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


