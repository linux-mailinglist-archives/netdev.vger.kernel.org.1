Return-Path: <netdev+bounces-166573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61414A36799
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 22:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D82BF7A3EEB
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 21:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCD31C863E;
	Fri, 14 Feb 2025 21:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHP7nNRg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E719193404;
	Fri, 14 Feb 2025 21:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739568907; cv=none; b=XFSTmfEh5SO6afiOrRaVnFiZ10MLnnfyGvjngjsvt/Qmre7uKeLQsmn1wJGiV0QVpp5ep1S092eO/sd2Ic4Xrx6Uoy74xUsfJVcMCYexlwrJLiNLK4n47WZOFED9UqJ/0+eZanf1IBzn+3E8yuAiANZNioamDxL1xWgG/APUtss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739568907; c=relaxed/simple;
	bh=SjtjrT420mYUlb0fxYSKm7OFC++eW35bsr/vWZzU78s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N5ntl5uXTsYvOGsBlASAfk5jtj/jxNuyuIKtvFkzEwT6QTH3C/Z0i1fhnOtmCLRTLVWegiksyzh0hONk9wkjvAhdCpqmTpBhsLDJ5SWQYkN4MKbBUJvfOAFgKZhJlIlS3qkhXapxyz7NNRqtvTmQDo6JaEMzDm5ThMcSnV2kDT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHP7nNRg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A6BC4CED1;
	Fri, 14 Feb 2025 21:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739568907;
	bh=SjtjrT420mYUlb0fxYSKm7OFC++eW35bsr/vWZzU78s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DHP7nNRg/KFypnHBYoKCAJLXHKI2hR9YhY3Eb37iONUHFZB/fLQsjnPESclPsY/nD
	 N/esdW85cVJ1E0SEKs+rsK+fkn8J95H9LxfJfcx3M/4mmL1463DFfnRW51QdmPjsT1
	 3KbZxOGMjnZPdwUI8GLC+5TzJLtKO1A2pAOQjui3RBym2Zl3WzJjhGI5hapB5/EP5H
	 ZI6fV+n/dYNs0Iexv2P8FXQYKcLmYIRHUfliVaJkW+AQDKNT+iROQkKQpwmAG+62S2
	 XO5dbIi2D582s7cvgJlpKTCdp6LVDMiVd3/OgoLYu36HZc93ykppIEOA+EsD4QqnyZ
	 GuZbreVuLpLxw==
Date: Fri, 14 Feb 2025 13:35:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Felix Fietkau <nbd@nbd.name>, Sean Wang
 <sean.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Chester A. Unal" <chester.a.unal@arinc9.com>,
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 upstream@airoha.com, Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: Re: [PATCH net-next v4 01/16] net: airoha: Fix TSO support for
 header cloned skbs
Message-ID: <20250214133506.1e4a619b@kernel.org>
In-Reply-To: <20250213-airoha-en7581-flowtable-offload-v4-1-b69ca16d74db@kernel.org>
References: <20250213-airoha-en7581-flowtable-offload-v4-0-b69ca16d74db@kernel.org>
	<20250213-airoha-en7581-flowtable-offload-v4-1-b69ca16d74db@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Feb 2025 16:34:20 +0100 Lorenzo Bianconi wrote:
> For GSO packets, skb_cow_head() will reallocate the skb for TSO header
> cloned skbs in airoha_dev_xmit(). For this reason, sinfo pointer can be
> no more valid. Fix the issue relying on skb_shinfo() macro directly in
> airoha_dev_xmit().
> This is not a user visible issue since we can't currently enable TSO for
> DSA user ports since we are missing to initialize net_device
> vlan_features field.

Im gonna apply this already so you're <= 15 for v5

