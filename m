Return-Path: <netdev+bounces-195432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E278AD028C
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 14:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6CD91898DA9
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 12:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF87A288C2C;
	Fri,  6 Jun 2025 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DC0DTMFs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1811E4AB
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749214237; cv=none; b=G3FD6jxgFlJ9A4IksjKkmdW+g0cJyWCPiDipNPiHoCFejqqTficrugcWsi5RpaqqVk+aDmse9K17F7/P0JfzbdgDTDX2VC5837Pw8IRczOScoUVKkFGo+lnRfP03vnSxuY2Pfdb1Ep1JiCA81Hj3vDKGiAraZMiHt8xKUvV/mmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749214237; c=relaxed/simple;
	bh=Y9Ehjey0xM3eYVfCO+7TEYRwO8bqgzMAV/QVkKHoEFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjmpZtbBWNTvrFg80qCbJkMfQ7tHL9pC35vrY2pF9XrzwXBDwf02EJLO3mKJ/2mBNbgMXF7hg3CBAK8sVdFYIUpxzzCPSEsedma0x0LGLFyo6WlDdfqlfGeTfw+/MU33pYDKo/EOZjEXTl8pJxMl4xaSh/oi9/KIGzB+iZ5iRug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DC0DTMFs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918D8C4CEEB;
	Fri,  6 Jun 2025 12:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749214234;
	bh=Y9Ehjey0xM3eYVfCO+7TEYRwO8bqgzMAV/QVkKHoEFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DC0DTMFsK6anySta3wA8JTUm9A3dA9VESqrSZpG9KRI0icQAj98IRYYo6BCVKZdjs
	 eE01zENJtckTn9kAoOckVyMZywYTetOBoXEbeZ0KcflVEfFsY8WIdr+jApA6tsvZj7
	 qhMCRZzi3iQUxgmEZXwB9r58Zm9kFRUhnR9FHH0rxDXa/ItAhjBSya1NsYEj7By6FY
	 0cIQ7eqzmepuSfEcg4VoPCdege5TlusIqFHbEZpUDvbmMkpieUXy/PyTMUp4jNiCYa
	 IP5Etn0a6cZzqPerRk386RF0XviAVkpEw6hoiwi4yXtcwPawg38ATvdprPcUx+jiKp
	 nxSB2n/KnXqDg==
Date: Fri, 6 Jun 2025 13:50:29 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com, Milena Olech <milena.olech@intel.com>
Subject: Re: [PATCH iwl-next 2/4] ice: refactor ice_sq_send_cmd and
 ice_shutdown_sq
Message-ID: <20250606125029.GC120308@horms.kernel.org>
References: <20250520110823.1937981-6-karol.kolacinski@intel.com>
 <20250520110823.1937981-8-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520110823.1937981-8-karol.kolacinski@intel.com>

On Tue, May 20, 2025 at 01:06:27PM +0200, Karol Kolacinski wrote:
> Refactor ice_sq_send_cmd() and ice_shutdown_sq() to be able to use
> a simpler locking, e.g. for new methods, which depend on the control
> queue.
> 
> Reviewed-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


