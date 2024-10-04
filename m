Return-Path: <netdev+bounces-131851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF5C98FB7C
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 02:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97F83B21671
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 00:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DFA647;
	Fri,  4 Oct 2024 00:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRDc4xiW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA5417BA7
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 00:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728001449; cv=none; b=J+ErCqGCXOE2oxbGEXs+sIB4Do1ouOgAu2rMNroDfM1Z3Mw2/EOimuvshzUzoUfP2LyXkkTgK1Xs/7pvVUK2+uP6uUrknpHy6lPm/SAfVI2cCtFztLX510DHprPXvzCLPLaxHQZsLazdjzrW0o8cFRh+dNPHzfRENcQF89ZJEJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728001449; c=relaxed/simple;
	bh=VV/M8B6D4ybuFpByBidICXy+GE+2iyQZz9Zy1n63kEE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bBOQfHidzFiSyDaUEvLOmQyFDinKKdwZbf7TOyrazvTzhyaCi/5ftNU2OWWSavh/0d1z901NClmxDjGrIjnvraPYQ0UJlXKb6O1N8XFAMv53Sqp/m6lCMch3dLBk/8x6wm5zBjVnmtVBqU0RYrv5C2N35nq0U8I+AaplsTmFqOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRDc4xiW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F4DC4CEC5;
	Fri,  4 Oct 2024 00:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728001448;
	bh=VV/M8B6D4ybuFpByBidICXy+GE+2iyQZz9Zy1n63kEE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XRDc4xiW+6w0E3UJqID2Xtw2o0K3Wm4mI+L5vxrMetgFOUdx02Ihj1toI36TShH3h
	 P5Bl0eNE/iJjXcr+R6xqWPmM4ilQkGKHqc9QClU89MBRLbfwi7RkZAPSdqpKOPPiha
	 8bMuDCeec3RgUNl8Wy5Y1+A6THRMUJsF+5/VCO+bImWthJNdJ9/+0NtZ2aMttxYtSN
	 stzwGDvKtQarZOKlmqaFwrzP0y5PGGr7qxggoJW5rIBeyQHCAWjahz4WCucoFU9c3b
	 TTI0qjlwXg2TTHD18+MgXNgAdTilMHtGOBlmJJ1vnQOgw9QIv+ZD+leYfQ1MJguF/b
	 LNeFV3KbmRbcg==
Date: Thu, 3 Oct 2024 17:24:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, Mark
 Lee <Mark-MC.Lee@mediatek.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, upstream@airoha.com
Subject: Re: [PATCH net-next] net: airoha: Implement BQL support
Message-ID: <20241003172407.1bf35bf1@kernel.org>
In-Reply-To: <20240930-en7581-bql-v1-1-064cdd570068@kernel.org>
References: <20240930-en7581-bql-v1-1-064cdd570068@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Sep 2024 14:58:35 +0200 Lorenzo Bianconi wrote:
> Introduce BQL support in the airoha_eth driver to avoid queuing to much
> packets into the device hw queues and keep the latency small.

This patch got set to Superseded in patchwork, somehow, but I don't see
a newer version. I think you're missing resetting the BQL state in
airoha_qdma_cleanup_tx_queue() ?
-- 
pw-bot: cr

