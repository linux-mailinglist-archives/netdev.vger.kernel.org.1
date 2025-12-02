Return-Path: <netdev+bounces-243252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7780FC9C461
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 17:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E57D4E17FB
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 16:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B8A28642B;
	Tue,  2 Dec 2025 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdrlpD4a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3E029993A;
	Tue,  2 Dec 2025 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764693912; cv=none; b=NkXLyVM/IDOyvFCwfDSrSMepVmFltNBmOWO/p++8CteQOFWR3MueosV2uOO0ATSbfTiuRc8WP1nseH8g5De2EFS3XCUZLLsrUBQYLRkHpqpkgfW6hYV/wBw++DWTWVM7/hnpOyTA6v4HgGyfmymFJ7+YVOX38ep2TrwfluwojVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764693912; c=relaxed/simple;
	bh=q4Xwekv7pUq2JA7Xkd2P4hK4oUcLcByTrqcodh8MAi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpPUkfUoyot8Vck4slY8LogRl+f+GfA0O5XyMsfuDBn1qBX9g+swpu9YfaWq75dov8YCASX+dDoxDNQX9/IszS4t4J8FrkMeDQIBt9tU6oBVegKRwT3QPkcI4MdccmeGJqCElDIAkXDStKBqdWupsTTLHqQ1x/tDg2PTsMd+O6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdrlpD4a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55239C4CEF1;
	Tue,  2 Dec 2025 16:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764693912;
	bh=q4Xwekv7pUq2JA7Xkd2P4hK4oUcLcByTrqcodh8MAi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JdrlpD4aoy+Fk/wTyRtFCtNUrQ8Ba6ZOnI+jYUb4N7ikhpivknHJWuxgOs6hPk4KD
	 G0IEnklxiHd3gdUUtMzwqdjLfyuNsNQZVUgZXYAQiLbVLjFLyPCaTi2SPsljf4/QsP
	 IoRjTKmicI5Mbh9QxCoS31eV/IWJw3juXx33k6LbO6SmhfSlWlOERkbMu2zC4b1xYI
	 2Gd+edo4QalwFJYSdLegL2DVigrObimzCQqZlpP8AH5XgBkUT8CMDKRPRDj6/mLKik
	 sgR40xN1TdQuxu9c9QHO2QAMQG5M9hWOrTG8RbuJXay+2XE7NswuDK05XCuUA1iqDI
	 0EOi0ukeGlMiQ==
Date: Tue, 2 Dec 2025 16:45:07 +0000
From: Simon Horman <horms@kernel.org>
To: Chwee-Lin Choong <chwee.lin.choong@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Bouska@web.codeaurora.org,
	Zdenek <zdenek.bouska@siemens.com>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Subject: Re: [PATCH iwl-net v1] igc: Use 5KB TX packet buffer per queue for
 TSN mode
Message-ID: <aS8Xk-CeuEG2ptmf@horms.kernel.org>
References: <20251202122351.11915-1-chwee.lin.choong@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202122351.11915-1-chwee.lin.choong@intel.com>

On Tue, Dec 02, 2025 at 08:23:51PM +0800, Chwee-Lin Choong wrote:
> Update IGC_TXPBSIZE_TSN to allocate 5KB per TX queue (TXQ0-TXQ3)
> as recommended in I225/I226 SW User Manual Section 7.5.4 for TSN
> operation.
> 
> Fixes: 0d58cdc902da ("igc: optimize TX packet buffer utilization for TSN mode")
> Reported-by: Bouska, Zdenek <zdenek.bouska@siemens.com>
> Closes: https://lore.kernel.org/netdev/AS1PR10MB5675DBFE7CE5F2A9336ABFA4EBEAA@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM/
> Signed-off-by: Chwee-Lin Choong <chwee.lin.choong@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


