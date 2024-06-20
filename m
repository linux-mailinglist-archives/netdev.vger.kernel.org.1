Return-Path: <netdev+bounces-105273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B58491052E
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 15:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BC032865E5
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BCE1B583C;
	Thu, 20 Jun 2024 12:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DP8QxE7m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C881ACE84;
	Thu, 20 Jun 2024 12:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888201; cv=none; b=hV5r/aw5In2Z7CK7B+p4SnlH7QcrSoUapBj85r2eaiWv+QG+aUj+RSPeZleZePFOOAb/boJ8FVAjfgEOQGK58LHifKIUGL4egclptFgVDmb3honQdlRxkduXqT2ymVs5pThjrOt5YehGZHA+GJCOtIQN81BIZbk3223E3W+RQCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888201; c=relaxed/simple;
	bh=gfOG6RZtS1ga2nENIYEOMowxHgyjveMF+/g99LNzO1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gh5yoL1rcz3S/770LZQVPcMNt3qCPGF/SoNo21Vgax/gQaKZTlJz0ZdfJxmGIXM2LTyGmlkTexRPHHJNji4v1yY/n1yJdBECqzIB2osPQz0RdQrg53SysAh8SxkmX++NDj83eX+QXaz3CjihKk5HcxoV5wK18DI4euR9xAhBnXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DP8QxE7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E57AC4AF07;
	Thu, 20 Jun 2024 12:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718888201;
	bh=gfOG6RZtS1ga2nENIYEOMowxHgyjveMF+/g99LNzO1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DP8QxE7mrJI2aqJvUNal54UIdfJVYWrLLVm+7EKB7QqmRTK1USMu236NK7fveApQD
	 lJnqjtafs7a/Ej4I2yk0DqIfbag43LL9iK1T6moVaLyqTpLo4vk9+QsKNCkCtAmY+R
	 +96KW/UQM8cnGtJWshwTEs7d6gMk8sfJAW5yxoCenflQbNcHWOK7wo8mZXDUt7cgEE
	 qT0Yl42CQPFNpDJXw4YG8bsuz4rbEELKgLqLxZBamdrjH+zSfuPmrSGsB+gcfKkoZX
	 HjL0D47+fPRyDFiDZFAuegzQtNTQEJ2kCaYXdUBL+ozDhwGUckqCUIBhwi6slUsJy7
	 RrMB5xh4BTMSA==
Date: Thu, 20 Jun 2024 13:56:36 +0100
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v5 07/10] octeontx2-pf: Add support to sync link
 state between representor and VFs
Message-ID: <20240620125636.GH959333@kernel.org>
References: <20240611162213.22213-1-gakula@marvell.com>
 <20240611162213.22213-8-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611162213.22213-8-gakula@marvell.com>

On Tue, Jun 11, 2024 at 09:52:10PM +0530, Geetha sowjanya wrote:
> This patch implement the below requirement mentioned
> in the representors documentation.
> 
> "
> The representee's link state is controlled through the
> representor. Setting the representor administratively UP
> or DOWN should cause carrier ON or OFF at the representee.
> "
> 
> This patch enables
> - Reflecting the link state of representor based on the VF state and
>  link state of VF based on representor.
> - On VF interface up/down a notification is sent via mbox to representor
>   to update the link state.
>   eg: ip link set eth0 up/down  will disable carrier on/off
>        of the corresponding representor(r0p1) interface.
> - On representor interface up/down will cause the link state update of VF.
>   eg: ip link set r0p1 up/down  will disable carrier on/off
>        of the corresponding representee(eth0) interface.
> 
> Signed-off-by: Harman Kalra <hkalra@marvell.com>
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


