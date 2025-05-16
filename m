Return-Path: <netdev+bounces-190981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2F2AB9921
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 11:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEE671760AC
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 09:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6216231821;
	Fri, 16 May 2025 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clUeDqR+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE07163;
	Fri, 16 May 2025 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747388647; cv=none; b=AX+Nc503bGf3FUz/dbI+Q7PNBZ9ymgfh7oWh+7elwx8eh/vdZJVgkQN74aOPWLEHxFxg0G5TmTDnD70P4CBzPI2tw1bEd9W8Nny17hB0Ls0eZBe+bT8g8IZCiYy6/U2ggqOcnBI4Znca4SQ6CGtjJtGZjpQUiiocO89YFBnOvzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747388647; c=relaxed/simple;
	bh=2o6PA4KQ6CYl1W4ahVFVFPxLG72HP/+8o7tzv5Djm3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfyAZVw7G74/S5SAzAkEMDSdVtf+j9I2t9RLevZADtiWw184WpdDMvLlgcEJwRU1BenyVzRjGNXPjfqxZJJ8dixNHHu24bynTw7Zu3fKhFkhV582rGoM4QQOAcF175nVLVQ8XU+dFoMIPRTZX0e/zqAumGQU8A17WnmMLL2XrQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clUeDqR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F0DC4CEE4;
	Fri, 16 May 2025 09:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747388647;
	bh=2o6PA4KQ6CYl1W4ahVFVFPxLG72HP/+8o7tzv5Djm3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=clUeDqR+NZG4PuFvMckbwKkaDff8q+Fw2o6c178dTJWmUn+zS0xofnY/fAn4MaXYF
	 G3IlTT7m6tjkj0aI01lmNZ+5m6I6CHswzdMJ7eYdGf2pFatmYw99M+G/2HkodwLLN6
	 5iya/tZTGu2o17P4TGIJFx4ZpG8yUuUyBBbA/KNGq9lfnkKRGeDGY6guiqnQTy2dIL
	 nkfjaWtBL4wmvopUukdtUX37UBCWnfhVPFki0eFc1FaOQ/JGpeaVUNzpxCQTpc8HV0
	 JcD414OVBJocQiZSF+tVDI4Xizr/tmSBiH1+3QGe51slqC2mqNz9V9J/6LjqrX0DjO
	 8B6+hpEnveebQ==
Date: Fri, 16 May 2025 10:44:02 +0100
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
Subject: Re: [PATCH iwl-next v2 1/8] igc: move TXDCTL and RXDCTL related
 macros
Message-ID: <20250516094402.GI1898636@horms.kernel.org>
References: <20250514042945.2685273-1-faizal.abdul.rahim@linux.intel.com>
 <20250514042945.2685273-2-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514042945.2685273-2-faizal.abdul.rahim@linux.intel.com>

On Wed, May 14, 2025 at 12:29:38AM -0400, Faizal Rahim wrote:
> Move and consolidate TXDCTL and RXDCTL macros in preparation for
> upcoming TXDCTL changes. This improves organization and readability.
> 
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


