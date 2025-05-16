Return-Path: <netdev+bounces-190980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 194C0AB991A
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 11:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A6CF503373
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 09:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE08E231833;
	Fri, 16 May 2025 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AA7tcPpu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C597D230BED;
	Fri, 16 May 2025 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747388621; cv=none; b=RiIftQp+q/yTmLpN8GzwCicDsq8ObeI0ntxOOA526w6Zb3boohq4Yw3JJEJX9lu4U9pyqAMzkYTaclB30NJTW6ImmOWx9YNMGasfMzpsVqWqn6wNjv4PPXwlBl7LaZen8Xw7M6GXKC+ZEzVbT1drYbBM5kyf2IJD5PNN0Z5Ae4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747388621; c=relaxed/simple;
	bh=NP6mTkOPwLJDrCmSPzzyuQwIji4vlTM5i4FIApv+93E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVOI4jlEiIHlyhUozsJF239OTGpMejleSMWF0GctBhmkfhy4/6tCfjRa+fTc3wQAScETz0MIyGHoxKvHTJMeoJu4ydmAZ+BlwZDoecas7whwxK3KQgIwlJlhv+TS6F89rzb7a0jHpcLd2GpD6VMkDVUEqGMRlAvgLqjyFFLxB1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AA7tcPpu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96455C4CEEF;
	Fri, 16 May 2025 09:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747388621;
	bh=NP6mTkOPwLJDrCmSPzzyuQwIji4vlTM5i4FIApv+93E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AA7tcPpuuBBOKSESNckNFwlPbcMV3qNttniRQMmbV2GTxUw/NUIwVFpLjIEZyiE2p
	 B0MuUmTLo/4Siki/ts2ZDDf2shTu5xui/f12/8Xvxe3KzF3P0Bn2+wsdpNKQMu70KJ
	 eOmxV2zNefmpE2BZ/S/V1BmbaHbcJiTON8sR3r5dyt0o4hEppnw6Ia2zx6kt0AueWc
	 Vg87lujeX8CdTuJu1P6ZA7itWXaoiT4hyTomJreJ/uXSDNelxYvy7Nkf02GeXJBc+b
	 2J36/FAHRtaqqliE64LQN3NL79mOFVLVz+xweNJf9QhVuCSCs0kRn/CuvMrcylyBCE
	 hB/amVK/N0uSg==
Date: Fri, 16 May 2025 10:43:36 +0100
From: Simon Horman <horms@kernel.org>
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Chwee-Lin Choong <chwee.lin.choong@intel.com>
Subject: Re: [PATCH iwl-next v2 8/8] igc: SW pad preemptible frames for
 correct mCRC calculation
Message-ID: <20250516094336.GH1898636@horms.kernel.org>
References: <20250514042945.2685273-1-faizal.abdul.rahim@linux.intel.com>
 <20250514042945.2685273-9-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514042945.2685273-9-faizal.abdul.rahim@linux.intel.com>

On Wed, May 14, 2025 at 12:29:45AM -0400, Faizal Rahim wrote:
> From: Chwee-Lin Choong <chwee.lin.choong@intel.com>
> 
> A hardware-padded frame transmitted from the preemptible queue
> results in an incorrect mCRC computation by hardware, as the
> padding bytes are not included in the mCRC calculation.
> 
> To address this, manually pad frames in preemptible queues to a
> minimum length of 60 bytes using skb_padto() before transmission.
> This ensures that the hardware includes the padding bytes in the
> mCRC computation, producing a correct mCRC value.
> 
> Signed-off-by: Chwee-Lin Choong <chwee.lin.choong@intel.com>
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

Hi Faizal, all,

Perhaps it would be best to shuffle this patch within this series
so that it appears before the patches that add pre-emption support.
That way, when the are added the bug isn't present.

