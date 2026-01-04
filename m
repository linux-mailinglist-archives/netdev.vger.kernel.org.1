Return-Path: <netdev+bounces-246775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6B6CF11FB
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 17:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 705723008FB6
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 16:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA4D27056F;
	Sun,  4 Jan 2026 16:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IR8b9gRw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5716F1F239B
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 16:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767543047; cv=none; b=JxuT9Fr/ORjx9KSv+6ZfgR2/azrh0guaL14EOid3nn70Z2YpzeLFCEZg/7kWo3tn4rR4L2b4dAoooNlrNvNpveO+eXt7FLF7DJttmwflOji+YPYVWOPuRKVpj5A/fM5MA+SlXq7AQenNUtT+jaJjOyUI/QlBxz3y0s3X4oe/hVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767543047; c=relaxed/simple;
	bh=X1e2cq1N8xoid8fOEbjgB2mmK0e1aW4HYWn4y8MvCoM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d5D9tKFPT6YprsjUzNre950WOIaeRwI1ldJAvQa08/wdwWd38XoQiNZMTFJ6SXxhQlfut2UChTbtFqRRaQXu49/1VLc4ocSjsFYzUsfFNqa6xsXZVIE2kNM0fa3PyU3ZP+8yxM0SMk7JogMlpwbN7SHOpVXkNWkrfmWv1S5zEhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IR8b9gRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F7AC4CEF7;
	Sun,  4 Jan 2026 16:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767543045;
	bh=X1e2cq1N8xoid8fOEbjgB2mmK0e1aW4HYWn4y8MvCoM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IR8b9gRwRdY9ktxV3bKy+K2ljT6KUvOsM2Z6SuNXUaLS9iRC/N0+/YVT76as9F+Rn
	 m6OLH4h0AAfXP6U9gBFrs4hmylFXwtHBolLIVsCgaZlH/rcCllayaWKUpyGxtW/vpr
	 hleZ8+yGM0KnlOM5uYNfBsBoxuC0XCVLK4DJxkyou81+k3dJUevwsR6QAw510ccJjs
	 rQopVbQZ6mJrxHSTyun4AzArRs9Hch2iqY5BiTFTs5rnLmSbNJJfEeg2dNERPKrHxz
	 PthjQV6a9HQpb8gxCMtwVKdBhmiJ6PDzogZ6Lc2aQIjOSx2zdWrojigMg10FHcYqvD
	 sv419+LaTs+6w==
Date: Sun, 4 Jan 2026 08:10:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, nbd@nbd.name, sean.wang@mediatek.com,
 lorenzo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH] net: ethernet: mtk_eth_soc: avoid writing to ESW
 registers on MT7628
Message-ID: <20260104081044.66dbc237@kernel.org>
In-Reply-To: <20251230091151.129176-1-joey@tinyisr.com>
References: <20251230091151.129176-1-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Dec 2025 11:10:41 +0200 Joris Vaisvila wrote:
> The MT7628 does not expose MAC control registers. Writes to these
> registers corrupt the ESW VLAN configuration. Existing drivers
> never use the affected features, so this went unnoticed.
> 
> This patch skips MCR register reads and writes on MT7628, preventing
> invalid register access.

please add a suitable Fixes tag and repost
-- 
pw-bot: cr

