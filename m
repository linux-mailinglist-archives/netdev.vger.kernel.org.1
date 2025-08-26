Return-Path: <netdev+bounces-217010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B323FB37097
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 18:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8277189F8B1
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 16:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490AD21C18C;
	Tue, 26 Aug 2025 16:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eu11srEW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2399131A54D
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 16:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226138; cv=none; b=rEguVDCgfq/C1YyHNWqUHdvG9MouUhurhSgcvvqa1i7RolHYPxBv6o6A76/AZ59qWpzAocEF63KPsTY7OzZmTT/WYknAJhHxvOIpggRY/pj/koRdz71/lNOjfCKAU//qdoVTCSyi9GRoLXgw7/FSxGlDEOMCf50nf1jbZMersYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226138; c=relaxed/simple;
	bh=MrQ8uwxf6gxIudqMpUeggOMfu3sqkRlub+VF2qkIMsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiqklAn0amVGt2v6SsqkwSOdOUF1h25r/8Mea/pdolZStjHO8MlnrDV2OwfWr/5dqF0uEEeJzhg1y5vvASdISV0NjbovVOUajRWENrAyxqvgupGRK4kMldyqEQDCL9rl7WANdKAC18szmTzWaJXHD4dcYZPhUjaBo8p4Das6prY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eu11srEW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA81CC4CEF1;
	Tue, 26 Aug 2025 16:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756226136;
	bh=MrQ8uwxf6gxIudqMpUeggOMfu3sqkRlub+VF2qkIMsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eu11srEW/0ONU2gaCerZBClYW1xleAxOocZPyAUpPRvKHcJLvVUvCNa2siZ8MlGWq
	 Dvhh4nliwf2dt3iUzrelE8+ITayX3TiPLWxEroZvzpRfIOTthcLiwUdDlAFEcK/XpN
	 /9JHOqj/QGLAsjtly+0Nd3gThHgwhmw4HOlmnLrrpBgZ99LdSI+VU10jkPM3+zdy3D
	 /JxTrgtSgYYj5rtOSqW8S9yW+dc7x20Km82lT4e8VNJ8JLd5epjk+Bm8dtcaax6ke+
	 RiBBsl14/RFGorx4+l+CH6P0jGf/sXy4CZYaX4CUHblozWyNvyZUTliluQrNSVBAMh
	 yHJ9pD/8XpuEA==
Date: Tue, 26 Aug 2025 17:35:32 +0100
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>, jeremiah.kyle@intel.com,
	leszek.pepiak@intel.com, Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-net 3/8] i40e: fix idx validation in config queues msg
Message-ID: <20250826163532.GH5892@horms.kernel.org>
References: <20250813104552.61027-1-przemyslaw.kitszel@intel.com>
 <20250813104552.61027-4-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813104552.61027-4-przemyslaw.kitszel@intel.com>

On Wed, Aug 13, 2025 at 12:45:13PM +0200, Przemek Kitszel wrote:
> From: Lukasz Czapnik <lukasz.czapnik@intel.com>
> 
> Ensure idx is within range of active/initialized TCs when iterating over
> vf->ch[idx] in i40e_vc_config_queues_msg().
> 
> Fixes: c27eac48160d ("i40e: Enable ADq and create queue channel/s on VF")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


