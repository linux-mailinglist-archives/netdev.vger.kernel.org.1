Return-Path: <netdev+bounces-125556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2361996DAE8
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 15:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F89C1C22313
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 13:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F6119D8A3;
	Thu,  5 Sep 2024 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uOAXWNYL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA4619CCFC
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544600; cv=none; b=hNtMeeK7fR0TYQ+hgJzKLvhDgpTGn9ZYudKIYv/h21+OThmZl7wvFEyXchZpWkvNAGLey1cMKpt6CWVlNeeUcTiZUZSVcc9enUf+QvCAlcAUMWcYr4vjq8KzF4dEn6CSV7aRX8ZF1N1AnyWF+7vqHeErjJRR898aP6vYKIjVUT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544600; c=relaxed/simple;
	bh=saAVnOyB1hBAecO8rTbHv66AvH7CjUBClh/3YOe6jbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GACjhpkcg/TdFaBpKmEitPZvWzIz6vVXUK7aTDU7Dx4+qZvWj9lz7CVX/6tR/V3ekbASBdXbPpzA3dfhxDLVJe8WqmCnNyMHVZ2f1QF+WLP7OvCP/9zbYRzdweKsY8Bzzt6aPfeE/1H4HZ/c6xrMBL+ZFy25jpm25QnwumeGdR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uOAXWNYL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726A1C4CEC3;
	Thu,  5 Sep 2024 13:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725544600;
	bh=saAVnOyB1hBAecO8rTbHv66AvH7CjUBClh/3YOe6jbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uOAXWNYLlUJYKH5n8Aa5z4tsZjSr65Nr3NhyzUvazwdvGfk0sW//nJ3NAw2Xz8Wwu
	 pUqwRnTP28t6fVO+0BA+xtmcWgX2jxsAxcGWtLSu/egON9zY1KDwOcTgvg9VWaUvYV
	 ooh0pyAOy42GZYfILwSHLMQhQxl1GhkC6liV2MdeQoNqkp8iv6dcB26j/RrlLEYJQm
	 qWp58pOVrGPQBHsN4ooV2QTL5nBsdJh7T2OKrg6+TT23mth6Gh5XZBcDeTa6S1EFzk
	 AxV0PVZjyJkCy6cQhYpUXcJUXaiaTFRqOrq3AUHSsclZnDhGI6ooqq0OGkUggNk/92
	 VW2cIV+WzEDqA==
Date: Thu, 5 Sep 2024 14:56:36 +0100
From: Simon Horman <horms@kernel.org>
To: edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com,
	Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] sfc: siena: rip out rss-context dead code
Message-ID: <20240905135636.GI1722938@kernel.org>
References: <20240904181156.1993666-1-edward.cree@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904181156.1993666-1-edward.cree@amd.com>

On Wed, Sep 04, 2024 at 07:11:56PM +0100, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Siena hardware does not support custom RSS contexts, but when the
>  driver was forked from sfc.ko, some of the plumbing for them was
>  copied across from the common code.  Actually trying to use them
>  would lead to EOPNOTSUPP as the relevant efx_nic_type methods were
>  not populated.
> Remove this dead code from the Siena driver.
> 
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>

Thanks, this looks like a clean removal of dead code to me.

Reviewed-by: Simon Horman <horms@kernel.org>


