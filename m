Return-Path: <netdev+bounces-191030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 677F2AB9BF9
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 14:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2A953AC2FE
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 12:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D862C23C38C;
	Fri, 16 May 2025 12:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tv7ymdFC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B7CA32
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 12:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747398389; cv=none; b=ANdYcR8xc6mDR3Wuc5GL22WdHfoTiqyQGOotlh8gKmIXrVMjD1HZBcF0+ch6uM+1c/P6AyJc/tQHZw/NQ3cKIqnXyEj9jMIep6DjrFkyJaIuitWoSbnCDfG5I4AncQePQw9HjuXJGki5QshfbkJBdbu+1P4yVjeNLQfiMvZmwTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747398389; c=relaxed/simple;
	bh=rrrJY39WUsVKR4mN1I8MidxOAchZp2nqdeCYWmKpuZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8fcBiTU0FjfYCDJ4Abmy/9oEpZE3Vc4a/oduLrnk6S16fHDMozMTsC/jwMoOukm+4l5wYZNAMjY/Z0JhkWyVSntxGFdS5uOg9stPoFHg59d9LSQaR9F7ohzjwzQFN4Pg8nxEkm60gXjwNH2Oeqk836bM0+RiW3R1zSF4Wq2vD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tv7ymdFC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D365C4CEE4;
	Fri, 16 May 2025 12:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747398389;
	bh=rrrJY39WUsVKR4mN1I8MidxOAchZp2nqdeCYWmKpuZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tv7ymdFC3ANdYCOX6Of0UF9n0CESfkmk1WipLweY9qMefFBbhzwioh7V6qpRqEkdI
	 jh+M9g4nC9kwe/LvUcp6/Q2EA0jO//Z/hllb0mEXq+Gi7hKToXfkds7jCGF554mFJa
	 LojGdgsYal4IONuNxiDVVABrme9UhLeogx78t545iqawA0E9+jzXkReDhUK8HLhRRf
	 rVqIIFjFl7EHy/mlErUKlQhh7xTCj6j++GjJVsbKcb1iXKrg089YBpIEPBRFlOcOo0
	 I3ydXVOkXp2ifIJXOmJDCivFVQLqdK+YE9hXr2ZxLQfEj0tsX4CdxoMjNAK/BWUXmg
	 xA6tp7/yvRBjQ==
Date: Fri, 16 May 2025 13:26:25 +0100
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH iwl-next 3/5] igb: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
Message-ID: <20250516122625.GB3339421@horms.kernel.org>
References: <20250513101132.328235-1-vladimir.oltean@nxp.com>
 <20250513101132.328235-4-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513101132.328235-4-vladimir.oltean@nxp.com>

On Tue, May 13, 2025 at 01:11:30PM +0300, Vladimir Oltean wrote:
> New timestamping API was introduced in commit 66f7223039c0 ("net: add
> NDOs for configuring hardware timestamping") from kernel v6.6.
> 
> It is time to convert the Intel igb driver to the new API, so that
> timestamping configuration can be removed from the ndo_eth_ioctl() path
> completely.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Simon Horman <horms@kernel.org>


