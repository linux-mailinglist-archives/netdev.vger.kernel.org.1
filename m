Return-Path: <netdev+bounces-179715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB4DA7E547
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E96B188ACF1
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 15:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEF52054F0;
	Mon,  7 Apr 2025 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkDFHFLu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FE8204879;
	Mon,  7 Apr 2025 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744040932; cv=none; b=bj9Gu8s1qyFHNYQ+AsgE9HIJSKWdXU1ZhIWG2zqpow0tu5M7V1jMhQczC+QWbn7wQ1VLB/28//lwzhSHQX329fFiGhbo+PmIH4AuGaRYygGfY9SMhAxuQYVF4QrnB4pZRzUhGShrl3eLHsYoTXSpYnIoaiSs4tq9OPTtMgr96Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744040932; c=relaxed/simple;
	bh=cXlAM7rZ33X+JzSByHY+99QsCWDsAzEWY+O1mXU5b5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2LoIn91/pyYiGjfuu3S0Ug519TeJCBDXNSMzLJeDswwMISgI7Pdo6v9MHA1+kuRE76UvoujMoGR1InykuAPbmMjBvCQfhcUcHLZ9/4HpzkRWBmkWFiYB7Gt+/S80fFVdn62YdRhgJrhlejOnHIIjxl0EcvehG46aPzsl0dv7zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkDFHFLu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0001CC4CEDD;
	Mon,  7 Apr 2025 15:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744040932;
	bh=cXlAM7rZ33X+JzSByHY+99QsCWDsAzEWY+O1mXU5b5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VkDFHFLukG529Eem400b0fyx8KA3ZciF240CH/ar1z6AZxGR5KW1Um2H00xzsakwI
	 uznTUp+3aZopEdSxbm4QanFh5sHuE1eBExljfeBw4VZ+XfKh8qlSbic2VpBLtLnk+n
	 eorr+ItFodt/2s2gwBHqADMrZj1kgvdQXpErScJPJvswdxH6OhRh43/yIUVUStsm4u
	 TQJYeCG9QwlSlwmX1s3PsEFuT/uCLJUHq+A9EZHh3nONGnQRW/AMfWNDQFRXr0DNZ9
	 231Q23Zuz48ARyAgNDSrFMdAbAm5OkgY6szAqBvze7/70Dk9PriKdHlBeD3W9bXlFj
	 tmsBeutNB3Tzw==
Date: Mon, 7 Apr 2025 16:48:46 +0100
From: Simon Horman <horms@kernel.org>
To: Julian Vetter <julian@outer-limits.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Louis Peens <louis.peens@corigine.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	oss-drivers@corigine.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eth: nfp: remove __get_unaligned_cpu32 from netronome
 drivers
Message-ID: <20250407154846.GP395307@horms.kernel.org>
References: <20250407083306.1553921-1-julian@outer-limits.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407083306.1553921-1-julian@outer-limits.org>

On Mon, Apr 07, 2025 at 10:33:06AM +0200, Julian Vetter wrote:
> The __get_unaligned_cpu32 function is deprecated. So, replace it with
> the more generic get_unaligned and just cast the input parameter.
> 
> Signed-off-by: Julian Vetter <julian@outer-limits.org>

Reviewed-by: Simon Horman <horms@kernel.org>

