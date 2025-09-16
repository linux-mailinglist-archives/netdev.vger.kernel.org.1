Return-Path: <netdev+bounces-223521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A03D5B59651
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44429188C278
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E54B30594E;
	Tue, 16 Sep 2025 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQA+EJx9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA9A2D73BA
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 12:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758026212; cv=none; b=HaxOb2/w7P+LvYQa4gwoWMrHMMfXT8uDH1TBRQliColkp5rHxY+wyOVrfDYxQy1F2LP2XTBM2BT+VwRPNVu3UqQ64XVNfRh6ajcMmpjIBDumu8SnkE0hdOQO11BocoRZJYJRCdR3R4ivnrpsEmQjzB9KoZmSDW9QFS1TzrwVCt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758026212; c=relaxed/simple;
	bh=CIyrTQFcJ//168fBZL2qztCmcJR1MF8wezSiB00scXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpJppD6k228oXY2EDrHRVSEHNG7Y4X1rw2e4yLVoJvTPArQa4QF+nGNXQbrQhKy1gs3kMeFrdawJh+S19mZVaTS1nxlA6E3n+YcOX0vW8+Rn8CO2ey804QBC/VvhuZCKkUjkt4hUKTqSb8Z8AXjHlBHoqXbjeJtuTnJtcXton9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQA+EJx9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5745AC4CEEB;
	Tue, 16 Sep 2025 12:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758026210;
	bh=CIyrTQFcJ//168fBZL2qztCmcJR1MF8wezSiB00scXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aQA+EJx9UVwPJ71WqWzBqOtQQbuH4piuTbVi6Non+iRG6Vemo2TEHsKRNXoR11JH6
	 WC26Jscxwd3xrCcDP0AeoGf4l89gx++RncVuJCDHu8Gj+ztPxzCYG4eoKk7entsFO+
	 647akn4E3I09zYNqc0KBkoNtDu3r1o5fvcrvNzcLCCuYjZq6SLUxYRA1eh3Xx1JR0c
	 Y60MixYAd4pBx83TlNmchZl45g4I5GYPIFcU7JndJeI4RxN5PBEWdUo6RXqmLaisN5
	 zmqmWxKooO2C++p3mpuWqvR9UFIfPQk8KbEC5XSyqdJncf6TPREA978d8hoP9zhKax
	 CnUxW7yynyZuQ==
Date: Tue, 16 Sep 2025 13:36:46 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, alexanderduyck@fb.com,
	jacob.e.keller@intel.com
Subject: Re: [PATCH net-next v2 6/9] eth: fbnic: support FW communication for
 core dump
Message-ID: <20250916123646.GE224143@horms.kernel.org>
References: <20250915155312.1083292-1-kuba@kernel.org>
 <20250915155312.1083292-7-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915155312.1083292-7-kuba@kernel.org>

On Mon, Sep 15, 2025 at 08:53:09AM -0700, Jakub Kicinski wrote:
> To read FW core dump we need to issue two commands to FW:
>  - first get the FW core dump info
>  - second read the dump chunk by chunk
> 
> Implement these two FW commands. Subsequent commits will use them
> to expose FW dump via devlink heath.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


