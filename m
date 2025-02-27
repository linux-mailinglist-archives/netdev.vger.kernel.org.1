Return-Path: <netdev+bounces-170383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC425A48715
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 18:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C63441698FB
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 17:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA261E51E6;
	Thu, 27 Feb 2025 17:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UawygaGF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB6F1DB361
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 17:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740678764; cv=none; b=TXetzixUXRZ3UuLdxiqQw5qoay96iUYzvJFMN6quFYuw4WP7Y3NmbF+AxhEcaptmZg494WiZFcthyYsHyG17G+WN9+QGNhKpklMoqSL9mNIYMIW8ACyiBx9O1Gxs8g4x1rDcGUhQteraB6DL6ikko/NLJJkH7Ud5x+55AB/ptv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740678764; c=relaxed/simple;
	bh=dThrQP7ix+WzmU48o7oNgP1GWMYf7MsMTrUWSD3Dh6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQudD9RGptlti5j509Qm6labiEg2GlxtgZwIP7u/OgkfRKT3fdo+uiTeO6E9uSuwEGNgBjyrvdW7GWuwql+hMofNjqdHnR9JBpqIvKEAj1tph+VTLbeYMjhgLy+5v4GVZFPx8Oqk8McBsxP4d2tkxJBQcF3xX4tqn1RVNZ6jUhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UawygaGF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199F4C4CEDD;
	Thu, 27 Feb 2025 17:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740678764;
	bh=dThrQP7ix+WzmU48o7oNgP1GWMYf7MsMTrUWSD3Dh6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UawygaGFyAOEaEp0itLr3m3kCqIwZxygzLvZau9WUPSsglmE7znuv8Rt3mNRTJTJK
	 vhs7PQXuqHKbuUHrB3OTBrbe+T90kSUj/6n8MZltTh5mbypbrWnA9G8MmwQ8HxrHEN
	 eHBm0UhMn3KG8NeYg82YJSmU3cw9mneg5N7Gd+SIOKzUsI/7Pwwonj6jBBjBIVrT2i
	 eyErY3MRB17tazP2iGEFvmpt+5jXHinVMJMUdJ7pePDXjd9Rq+6AMt40XqVUVjteyC
	 86p+2lyAiPowHzpswMcDpKVjGkqCUUbogpkvpjtvRG4L4JfL3aXTHKVTNeTDp2seH3
	 FpqY3l+vzZsbg==
Date: Thu, 27 Feb 2025 17:52:40 +0000
From: Simon Horman <horms@kernel.org>
To: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	pmenzel@molgen.mpg.de,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-net v2] ice: fix fwlog after driver reinit
Message-ID: <20250227175240.GH1615191@kernel.org>
References: <20250225134008.516924-3-martyna.szapar-mudlaw@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225134008.516924-3-martyna.szapar-mudlaw@linux.intel.com>

On Tue, Feb 25, 2025 at 02:40:10PM +0100, Martyna Szapar-Mudlaw wrote:
> Fix an issue when firmware logging stops after devlink reload action
> driver_reinit or driver reset. After the driver reinits and resumes
> operations, it must re-request event notifications from the firmware
> as a part of its recofiguration.
> Fix it by restoring fw logging when it was previously registered
> before these events.
> 
> Restoring fw logging in these cases was faultily removed with new
> debugfs fw logging implementation.
> 
> Failure to init fw logging is not a critical error so it is safely
> ignored. Information log in case of failure are handled by
> ice_fwlog_register function.
> 
> Fixes: 73671c3162c8 ("ice: enable FW logging")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


