Return-Path: <netdev+bounces-229119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDD7BD8566
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A79E3B72F4
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4BA2D2497;
	Tue, 14 Oct 2025 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jx3g/GRY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D9B267714;
	Tue, 14 Oct 2025 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760432524; cv=none; b=D02T/VFdAwbJjFBqTEt7YYoVoGAx+9x0Te/zXKD1Nx9I+3VskTTijZzDT+DbsHqq9FiIuvdiNL2Cb/gYYgCq2LgNLvDBFn7cgaSrRvc4r9Miz9XISzgZGcAN367qTl5qUONBbvk0a5RpLzz0akz6U/DdW/ht48t82eMNTJSp6V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760432524; c=relaxed/simple;
	bh=7oolUNCSU743Tu+xJgP5+fFoQv4MvnDxo4k7EPwmuxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwQ3QvOw0d71Gxsf9lcJzJsGlk5gKkjO7MT+fnkR8l7H3Jwq1Aa3E+E4GjQCHFkRyMBowC1N/pify9f0554YGNqREScjFOgNL/zgHZe1snQTbcNKcaiDJ/cKw1Y0A5s65n1V1DbkHyKrN4bKoTIcgVF3PyavM08A7EumHQvokEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jx3g/GRY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52F4C4CEE7;
	Tue, 14 Oct 2025 09:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760432524;
	bh=7oolUNCSU743Tu+xJgP5+fFoQv4MvnDxo4k7EPwmuxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jx3g/GRYyYhSCQet6qJKA6iTilmsObB3FLf80pqSVFg+jw0S+mB9v5zgAIT1n7z/7
	 LPQIIAklg6LgXgruyoFKG1AxWpMd7jx5OggbvRCRtjidunfYrnrtkg0aEeoe5xFXsf
	 n4FHJM3+XZzV0e3Yc+pSYfWbtzKCsy5jAzQ8uR/ofyx0uL1CIKTaV2cQFa2/cYSIZA
	 3zqnh4rlZiLiLDUCGGsFgZDMqlylscHb85GV1mHL+WebVuFZUERPErpG29oFz79oya
	 AUqizcAEdZ7PyrgSRZWHqt3CXsecHQnvAYUl9iujBAiBtVkdIDeLuf70FjaJIsiFLh
	 pVNugW9lIX+4A==
Date: Tue, 14 Oct 2025 10:01:59 +0100
From: Simon Horman <horms@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	kernel@pengutronix.de,
	Dent Project <dentproject@linuxfoundation.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] net: pse-pd: pd692x0: Replace __free
 macro with explicit kfree calls
Message-ID: <aO4Rh5rUEjYoABCZ@horms.kernel.org>
References: <20251013-feature_pd692x0_reboot_keep_conf-v2-0-68ab082a93dd@bootlin.com>
 <20251013-feature_pd692x0_reboot_keep_conf-v2-1-68ab082a93dd@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013-feature_pd692x0_reboot_keep_conf-v2-1-68ab082a93dd@bootlin.com>

On Mon, Oct 13, 2025 at 04:05:31PM +0200, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> Replace __free(kfree) with explicit kfree() calls to follow the net
> subsystem policy of avoiding automatic cleanup macros as described in
> the documentation.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Simon Horman <horms@kernel.org>


