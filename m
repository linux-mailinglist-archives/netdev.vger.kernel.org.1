Return-Path: <netdev+bounces-224931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E853B8BA86
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 02:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EC141C01445
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 00:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E8429A2;
	Sat, 20 Sep 2025 00:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7M9QiAO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FA9A48;
	Sat, 20 Sep 2025 00:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758326689; cv=none; b=sZ3JUq+aKzUj3Q/EIzRwO+SEkRlMEC58JCVwrJ0yuehJMDLdLfIaCg/CghUIpfj3jIiyKLCPVuXyby37BrirZ6hg+WUVbQEIgAGHvetTvJt14u5hPdmqLj4IpGgSpDan1GBklB6YvODhsbM9qMLFuEUNxMIK/IRr9RLIP9n7RVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758326689; c=relaxed/simple;
	bh=+oMLUm3zyALPkDtD4PORikxHxeN8AHGD4CqWBRc13hs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nrdColrAGZd86Lz5ZOGj2IU8OTPPUC/kfJIsamlYNKZvtyqIRYnqWKjmk/zGDAZcW4Ds3jSb4Vb873VQl0q71Rs3pSJUb/dV2BAq7lNNbE7oHCW4qgVPzpW26KN0UHQXpFGN8jqS0AbqCFNRroPotxjUUNMeg+BERaITUbRe70E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7M9QiAO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F82C4CEF0;
	Sat, 20 Sep 2025 00:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758326686;
	bh=+oMLUm3zyALPkDtD4PORikxHxeN8AHGD4CqWBRc13hs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I7M9QiAONNpmtiZgJSDVEw+mRgtc+5SXWYiErZIgkpc4NzxO8Yj3spZVrKtaV1pmo
	 2oezTp6n6DIkAIiLzeEZ9eVpnOxO557t2GW6oKqdQ6jQFZBTrWb21xlgziBfEC4J4e
	 Uh0bulDA63J+fv96fDB27pVyRAbNOrp2xPt5iWPH6jxgu/6XRWkt6F0E9lhgdNWEK0
	 DLTYd6H6VWL+OHzT8X+VqqZOmZF/SoTUkNnVxOFiE1RECfeeB1OQ9j72NV3SUAg6hb
	 lCD/tqf5UlSBPKzgmtQvy15xzZaci0sEsjgGAFoLpAFhMhXC+adxEkh44yxJG+LePk
	 O2E/MGuCYFx+Q==
Date: Fri, 19 Sep 2025 17:04:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: James Clark <jjc@jclark.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>, Kory Maincent
 <kory.maincent@bootlin.com>, Richard Cochran <richardcochran@gmail.com>,
 Yaroslav Kolomiiets <yrk@meta.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/3] broadcom: report the supported flags for
 ancillary features
Message-ID: <20250919170445.45803d42@kernel.org>
In-Reply-To: <20250918-jk-fix-bcm-phy-supported-flags-v1-0-747b60407c9c@intel.com>
References: <20250918-jk-fix-bcm-phy-supported-flags-v1-0-747b60407c9c@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Sep 2025 17:33:15 -0700 Jacob Keller wrote:
> James Clark reported off list that the broadcom PHY PTP driver was
> incorrectly handling PTP_EXTTS_REQUEST and PTP_PEROUT_REQUEST ioctls since
> the conversion to the .supported_*_flags fields. This series fixes the
> driver to correctly report its flags through the .supported_perout_flags
> and .supported_extts_flags fields. It also contains an update to comment
> the behavior of the PTP_STRICT_FLAGS being always enabled for
> PTP_EXTTS_REQUEST2.

James, would you be willing to test and send an official Tested-by tag?

