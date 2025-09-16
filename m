Return-Path: <netdev+bounces-223777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEB2B7D454
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED70F174357
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD9C2D0608;
	Tue, 16 Sep 2025 23:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZXcq8fh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34182C3242;
	Tue, 16 Sep 2025 23:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758065104; cv=none; b=OJ6vTyuQeIDl8v2Y2UbAxKqzVIcICOkdocb+ll7G8g0H4eORH1yTBH5w8P0HjQXte5ObUkmXQx+pIQ43G8WqdnWfGA4n/eBDu40eIkQtYAdFGqKz+J/4fpwacl/5WHTnHSkYExzwimdF1M84rKbW2xwBi6vgpVBCDHgIycwSn+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758065104; c=relaxed/simple;
	bh=rQeheaB38YY+9A+IcXKdOsVPzWB/MYw/5UlgVC5BkEY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDplsjVns5KD4eiTG6BV9SE54GwTYt0OFEmZNC8bT0yF3hrf8tzKT2j1Pc9DWPomNlb1upAImsFWWWsrzLZh9LuJmsuXQ8Oy7K+/2tNbFlBmsI03RZNywfoMvzr8MpkNLrRMrJfRzOIPBP2h93BACePwy1fEUt81EmI16BQ9jVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZXcq8fh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB34C4CEEB;
	Tue, 16 Sep 2025 23:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758065104;
	bh=rQeheaB38YY+9A+IcXKdOsVPzWB/MYw/5UlgVC5BkEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TZXcq8fhHdP+Qrwtqam23H+1Ck3We430xTMOmgasKbebh8LsYJja/9Fi37uPU9rSM
	 5VXrjQhus+mnfPxF592rMEBHlplnCgoTF3BPYImrohWbEKcji7xp6YOFOdH1zkmR3f
	 BDK3BeJfYpZIMgeXFDZDZJc8D1eIbVePdkyjN1mF1+4QMYKCq1EwbOsNRhM9+BTS/H
	 mvXLm0YNJzF3ePtkTL/UXuHQIydVCGVmbeNrl4fMYDjPxqwnq9Gj+tP+gnL6MKqWwE
	 B0oVsuPXeDd/t7w6HzOodHFmasR6chsqqLYiL2pSXiBTvCMzYN5MHE6V2lCJ7csXX4
	 2FmQAfrJFSYKg==
Date: Tue, 16 Sep 2025 16:25:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Konrad Leszczynski
 <konrad.leszczynski@intel.com>, davem@davemloft.net, andrew+netdev@lunn.ch,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, cezary.rojewski@intel.com,
 sebastian.basierski@intel.com, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: Re: [PATCH net v4 1/2] net: stmmac: replace memcpy with
 ethtool_puts in ethtool
Message-ID: <20250916162502.0fcdaf9a@kernel.org>
In-Reply-To: <8cc527bc-41cd-48ae-a40a-05c69b2c4ac3@lunn.ch>
References: <20250916120932.217547-1-konrad.leszczynski@intel.com>
	<20250916120932.217547-2-konrad.leszczynski@intel.com>
	<20250916164530.GM224143@horms.kernel.org>
	<8cc527bc-41cd-48ae-a40a-05c69b2c4ac3@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Sep 2025 19:12:22 +0200 Andrew Lunn wrote:
> where desc can be any length, ironically making
> dwmac5_safety_feat_dump() unsafe. This is why i asked that this be
> changed to be the same stmmac_stats, so [ETH_GSTRING_LEN]
> __nonstring. But that seems to of fallen on deaf ears.

Yes, very strange.

Tony, Przemek, I suspect the folks here are from "different part of
Intel" but I think they need some guidance..

