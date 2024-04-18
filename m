Return-Path: <netdev+bounces-89348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 333C38AA1A2
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 19:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2144281471
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 17:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96843171092;
	Thu, 18 Apr 2024 17:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roMUL7sI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724D51442F4
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 17:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713462939; cv=none; b=qaEGNpgNmqIJ0Kf4eHTtdXP40pxF/ENFcun0zOI3yyhucIlCoEF+IjzCTVaNMPoTrWvmRmsD7JC59Q4mltk7s7vky2luP1OyZW+r2GqRHJw5UB4uc5Ew/UX3s4sGpgbQsM6JPmhSa/CMUduei9G2o7n9g9HJsTYHfFKZEZ81wQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713462939; c=relaxed/simple;
	bh=BdabkZsjgYaVgIK5J0ay6Z/7d02H+4Buup2AEjH1E7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faiJxxm4N10IJwlr5yex91vAdWLblf2ZRV5OqtPMIG6G9X/VQFlDeLBGG2RIfcIlyT8JW8zyskIUK8P5uqkUnPnbuYK0KAppTe2oxVM8isKEPhVO5iCLWdPpU0lPZTYfcO83BG2eFjBpPDip8RprWIh81Joy3LbMRa3h+9ChjuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roMUL7sI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A87FC113CC;
	Thu, 18 Apr 2024 17:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713462938;
	bh=BdabkZsjgYaVgIK5J0ay6Z/7d02H+4Buup2AEjH1E7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=roMUL7sIXNe68QhF1eF6gk8UtL4Gh4djfJvhRe4V1TCfnlHOFRAxVz01HwZLwzy79
	 dR9WUBNv5nklDsbAE5tG1l5CnS3wgQbWNGvwiMYPv79we1nNwHS4OGthMCQEw/nvEQ
	 UI4ac2atLjlSiPZ3K7af4grwMfCM9GydJpbZLOgqx9LxX1TSXKvb4B9lz2hpSqX9gM
	 w7iYjPvq7HNiH0kTTJhE+NRJYMYzgTuaaFzNu7xLOvuukq7tssyBNMPai+SpcG96vz
	 95cBwzWd126aYzdFXHxXcgXJpCdr262zSB+dhGGRjySi2vsCW4j8jUG0QHZDwTTHA3
	 fN2TNVLs1zJwg==
Date: Thu, 18 Apr 2024 18:55:34 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	mlxsw@nvidia.com, Tim 'mithro' Ansell <me@mith.ro>
Subject: Re: [PATCH net v2 2/3] mlxsw: core_env: Fix driver initialization
 with old firmware
Message-ID: <20240418175534.GJ3975545@kernel.org>
References: <cover.1713446092.git.petrm@nvidia.com>
 <0afa8b2e8bac178f5f88211344429176dcc72281.1713446092.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0afa8b2e8bac178f5f88211344429176dcc72281.1713446092.git.petrm@nvidia.com>

On Thu, Apr 18, 2024 at 03:46:07PM +0200, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> The driver queries the Management Capabilities Mask (MCAM) register
> during initialization to understand if it can read up to 128 bytes from
> transceiver modules.
> 
> However, not all firmware versions support this register, leading to the
> driver failing to load.
> 
> Fix by treating an error in the register query as an indication that the
> feature is not supported.
> 
> Fixes: 1f4aea1f72da ("mlxsw: core_env: Read transceiver module EEPROM in 128 bytes chunks")
> Cc: Simon Horman <horms@kernel.org>
> Reported-by: Tim 'mithro' Ansell <me@mith.ro>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
> 
> Notes:
>     v2:
>     - Make mlxsw_env_max_module_eeprom_len_query() void

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


