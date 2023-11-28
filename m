Return-Path: <netdev+bounces-51525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5907FB018
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 03:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D72DD1C20AE7
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 02:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5A24A33;
	Tue, 28 Nov 2023 02:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhL9uGfi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBB010A1F
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 02:31:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397BBC433C8;
	Tue, 28 Nov 2023 02:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701138683;
	bh=12Z7HzUo3/r0spozVJVoWPFG9KwgUbNUj53Z2ukP+rg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hhL9uGfi10LhJYV8ay6kFzT/RkQdxTbkIUx5qvrpzkzYA2vhoJn8BN0cSowQCq9lz
	 7OfrQR28sPUC9e3x+8LJr35rF+vGcp4DlwCg5LmEd1UsGDdZ9QCXtxzg08C/P4T5hW
	 46yz76Y1YRf3/3k1h4KoyQ/GZ5d13GRuGkpPHlh22Bb377cvtG+azedvcXbcphQb5V
	 S6PQPnv/biGq5G5CZzISAKfvUxz+IO6IZi2dOXCx7fbH54JUdOPC3bN0G3NFyIZH2A
	 NnebbFjnWao5lvOVoKAv4ORwZnrgE0n57noE3mNoU3tbAN5Inosb/01lorDUzxxSqh
	 QFJ/WXZlBYl3g==
Date: Mon, 27 Nov 2023 18:31:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Elena Salomatkina <elena.salomatkina.cmc@gmail.com>
Cc: Sunil Goutham <sgoutham@marvell.com>, Linu Cherian
 <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>, Jerin Jacob
 <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>, Subbaraya Sundeep
 <sbhatta@marvell.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] octeontx2-af: Fix possible buffer overflow
Message-ID: <20231127183122.1e51a444@kernel.org>
In-Reply-To: <20231124210802.109763-1-elena.salomatkina.cmc@gmail.com>
References: <20231124210802.109763-1-elena.salomatkina.cmc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Nov 2023 00:08:02 +0300 Elena Salomatkina wrote:
> A loop in rvu_mbox_handler_nix_bandprof_free() contains
> a break if (idx == MAX_BANDPROF_PER_PFFUNC),
> but if idx may reach MAX_BANDPROF_PER_PFFUNC
> buffer '(*req->prof_idx)[layer]' overflow happens before that check.
> 
> The patch moves the break to the
> beginning of the loop.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: e8e095b3b370 ("octeontx2-af: cn10k: Bandwidth profiles config support").
> Signed-off-by: Elena Salomatkina <elena.salomatkina.cmc@gmail.com>
> Reviewed-by: Simon Horman <horms@kernel.org>

Marvell folks, at least one of you has to review this. Please see:
https://docs.kernel.org/next/maintainer/feature-and-driver-maintainers.html

