Return-Path: <netdev+bounces-131611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A65598F071
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 15:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C6581C209DA
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 13:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6225195962;
	Thu,  3 Oct 2024 13:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGHKdCXb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B853615E5D3
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 13:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727962349; cv=none; b=U18TxGrREjxnlOko1XJ7SRjYkKdzD9cpybsTJPUEFS5h5/NY9rMuSEURAsJ29qbz1qedgfawtQjsorsXCEATVnOFWBRshvtjvlu0FO91ER2de7+6txiBAhlRAc+d0ZEgCx794L3zTGzmbDxigVcKBr5LOfYHhYeIh8nQ0GiBBL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727962349; c=relaxed/simple;
	bh=mgHYoUmlBkOxDJsSfmWy9DGOO2mWjqY3y0a9Y78YvcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYd/3ek/2D481D6YxbHf8iNYaD+Z0PSCRmGiiHiWAxiuYSnq/7dsSGTYHLh3zHOlBMVaADPr7vDG4rMA+FFYu09TaVbPEZDztVd31AzGoyA5E4NtGs6zk8BOw0GPhxIE5W4yq26tNaljnjox3HNhwJ9EWCBIlm6oFkG1qh25aFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGHKdCXb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EE1C4CEDB;
	Thu,  3 Oct 2024 13:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727962349;
	bh=mgHYoUmlBkOxDJsSfmWy9DGOO2mWjqY3y0a9Y78YvcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FGHKdCXbLi15mQTk8bLjEtLcDC0Ud6Z1On1IPbeuL9JehGC6AOtgoyNto09Y4Igb1
	 igp2tx+ZNkZIkvW00aXfB16zflRYiGgTz0v9ubXVMpgbSR/t0VnPrpDgGA3wuS2VGi
	 2+JE/JepJ5cR/6qVp871HPoL36tjK1rpES/R0u0H4j/h0I3UFh4Tmly2OhxCM7bHly
	 DQYpj990BWAYH3BhZHhyEYGK0BBK9DwzysjfobTF00+o4PWyDXh11/o39zluclKa1U
	 J+CLzPIgWS9QVksT81HL6J4UMxdTB9Qdwj9Kb907yOr/R35Bp6dF6crl8eKyJArLzd
	 jJjSctXoq0ORw==
Date: Thu, 3 Oct 2024 14:32:20 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH net-next v2 1/2] net: airoha: read default PSE reserved
 pages value before updating
Message-ID: <20241003133220.GM1310185@kernel.org>
References: <20241001-airoha-eth-pse-fix-v2-0-9a56cdffd074@kernel.org>
 <20241001-airoha-eth-pse-fix-v2-1-9a56cdffd074@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001-airoha-eth-pse-fix-v2-1-9a56cdffd074@kernel.org>

On Tue, Oct 01, 2024 at 12:10:24PM +0200, Lorenzo Bianconi wrote:
> Store the default value for the number of PSE reserved pages in orig_val
> at the beginning of airoha_fe_set_pse_oq_rsv routine, before updating it
> with airoha_fe_set_pse_queue_rsv_pages().
> Introduce airoha_fe_get_pse_all_rsv utility routine.
> 
> Introduced by commit 23020f049327 ("net: airoha: Introduce ethernet support
> for EN7581 SoC")
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


