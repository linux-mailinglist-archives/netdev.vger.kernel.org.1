Return-Path: <netdev+bounces-110082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DD492AECB
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 05:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1375F281983
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 03:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7E142067;
	Tue,  9 Jul 2024 03:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdZRhDKz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7A92772A;
	Tue,  9 Jul 2024 03:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720496019; cv=none; b=KYv5RQozy4+7guy1Y7FvbzffSFmB3TSG96xKOgBSmuS6yoxGxQp7sb17j8p37+RHVI/Oy3jBdME/AoWNP5W3RKK0c57EbCRqoyVHNFAJKng+TAhQArAWrariEXZwS9naJblv7F25DgYyME4JVXlrsQ+6iDfuf/0Qk5AxMR82/6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720496019; c=relaxed/simple;
	bh=7iwTvXHDzwgw8YBNkBLPDrFgP38NPzhCLm2zPjlIwH0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+0k+54aR+PnvtvQfZBSrJAqtG8HeBktOzTBhg70P5O3Mx/inRbQgXKwIomv59S5UitN3XROvlc6lZr45meGkNSNesGJz5tm+cHH3mpKLgXHuqgcN6Y6FHR7pvTNvdQoFyMPmm3a7h5eoieA5GtSJ0qVRraJovIt2dPkkmy4+P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdZRhDKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076FAC4AF07;
	Tue,  9 Jul 2024 03:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720496018;
	bh=7iwTvXHDzwgw8YBNkBLPDrFgP38NPzhCLm2zPjlIwH0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VdZRhDKzwmvaHLAR5gfZQ1uc6ZTw3EN1TIl1WINSCHUspfmHky+i/thyrvTrXoaFd
	 3IMJyFM5XSsy3LfCLQb3LhATu5NeVAQ86Nzf2Ord1X8kQtrZW9Pg5WjnGUqDQgRnjQ
	 r+SLNYvydEBMZVF5k3THRP6PG6la0tI/DijcoevumZR+1b+lsetvZobQ4mYwIrKZwh
	 ZKL1nrSOdtYZbfQCZWzj7W39kAicODz5WKkcMSE08d6ve05HOKVuFd1a1RHlAH62Q+
	 oBLHVUaEZtTjOnZ3C52gAQUY/R93RpLwSeABtpXcNYx7ZC51vSSqkL7kczhC+GB7qX
	 AuxSOclXTkiaw==
Date: Mon, 8 Jul 2024 20:33:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
 <sgoutham@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: Re: [net-next PATCH v8 03/11] octeontx2-pf: Create representor
 netdev
Message-ID: <20240708203337.0e20c444@kernel.org>
In-Reply-To: <20240705101618.18415-4-gakula@marvell.com>
References: <20240705101618.18415-1-gakula@marvell.com>
	<20240705101618.18415-4-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Jul 2024 15:46:10 +0530 Geetha sowjanya wrote:
>  .../ethernet/marvell/octeontx2.rst            |  49 ++++++

Your documentation is insufficient.
-- 
pw-bot: cr

