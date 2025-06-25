Return-Path: <netdev+bounces-201251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08673AE89B7
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1F0617DAB1
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BAA2C08A5;
	Wed, 25 Jun 2025 16:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8oGxvRD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9231C5489;
	Wed, 25 Jun 2025 16:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750868695; cv=none; b=N1GJzXd0rbYoy1uIkAowDs4YdIC96hn6u/ZMNRwnnHGoKOr4ZTk8ZF0oYpTzwdnzcMPywp0zFYX6t/Uh+NTp/G4fNO36XeJu5M+o+/X0O8mdKTUGuhICUQ2iJBpwGCZAGFLK1fR3BII1u2E9+pHcZ4vKhri7cE0GCEGiCKGR+C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750868695; c=relaxed/simple;
	bh=dI8Ewk5x5/Ua6ZxKfjFaMZFziQLJQTcMfppX0jaLiO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEoM4WteroBoSs/yPl+OaZN0KAJJUV0Bbw1fIxDG1ZotH9nrek3rgnJ3GUmsWzgRSsS1mzyYJCjFRazA0R8fKU5yLjEkWD6TR3QLctiTdKpKOSxPjMuxp4IqcRuwc7lAf+90f+jSF9y3UMiXzy3JdfCmO+2MpV2ACcfIQjsJHiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8oGxvRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300FBC4CEEA;
	Wed, 25 Jun 2025 16:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750868694;
	bh=dI8Ewk5x5/Ua6ZxKfjFaMZFziQLJQTcMfppX0jaLiO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N8oGxvRDPF5mAjaIXHzpI7jZY/vVYBiOTqwOfIyMKXmxLkDbFaQr7igXo3p/y5DX8
	 4es8jvpBFhAtGc8tg0tUioIEXGfRHTKBZpfG6UVLy4+QU3xnPPIUtw9pxqYV+IdPWB
	 bLT4Bo1GVrdXcdCbNuL4u9++EyF2vMB2zO8f7YxY1jn6l+jz5rRX+0iQxxO5kF+Iy3
	 6g0P/C83Q12T6nb3ru0C7xt0Z7ku/VBAf5v+bWqV2yhfQVYJ5lIiGuIayDjW0w0Z1u
	 ravj+NASS/yLuPTRkVn9UO3sHy8ZUr6nrNshlowWndxrTVy76mr/eyuT02AjQDxE1M
	 3rnLbUUs1aMgg==
Date: Wed, 25 Jun 2025 17:24:50 +0100
From: Simon Horman <horms@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 net-next 2/3] net: enetc: separate 64-bit counters
 from enetc_port_counters
Message-ID: <20250625162450.GB152961@horms.kernel.org>
References: <20250624101548.2669522-1-wei.fang@nxp.com>
 <20250624101548.2669522-3-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624101548.2669522-3-wei.fang@nxp.com>

On Tue, Jun 24, 2025 at 06:15:47PM +0800, Wei Fang wrote:
> Some counters in enetc_port_counters are 32-bit registers, and some are
> 64-bit registers. But in the current driver, they are all read through
> enetc_port_rd(), which can only read a 32-bit value. Therefore, separate
> 64-bit counters (enetc_pm_counters) from enetc_port_counters and use
> enetc_port_rd64() to read the 64-bit statistics.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>

Reviewed-by: Simon Horman <horms@kernel.org>


