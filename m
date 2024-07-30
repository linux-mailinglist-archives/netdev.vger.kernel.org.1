Return-Path: <netdev+bounces-113883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DCA940418
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 04:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EE951F21C72
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 02:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2485FC2F2;
	Tue, 30 Jul 2024 02:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LI5ezrIg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDD610E9;
	Tue, 30 Jul 2024 02:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722305196; cv=none; b=EoIBRsHPkoT+04437sL2FR0w0LSpaj8vCjssE1Gm0l/HGDOHMSDPH+/I1lAaQWdvPU5sqcaAIX5JxvWuomIld0qNEemqU1kj1Rwv5JtIRSo6tDrKv+FP0fHANwdsqghwcgpuGgNUYZ2nBm5ZYCY8sTT7NxYJ33m6xpRAM9KL2q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722305196; c=relaxed/simple;
	bh=LXY+kDi6JMe/6TkAfwSEh/KogLm8VrKx/SMDaXimoL8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oOO9lGh2Gq+oSSKxAbdhbUAotDZxTl/OTKaflhGUlsUu3Rn3O256gFJQxX7FuzRax2CvD8lfsDjXUhZTV83hBaMss5E0ZvBKL9k/JK6KW/BUj1ZOuncUL5P1fqkIFkyAqtVBp4xQJ43yuz3k5D3DLXaKFE6IJvkNqJqC3KccZ+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LI5ezrIg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0E9C32786;
	Tue, 30 Jul 2024 02:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722305195;
	bh=LXY+kDi6JMe/6TkAfwSEh/KogLm8VrKx/SMDaXimoL8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LI5ezrIg6oUbRtnewXQuQI+kZUsvNcs+b1GyigNN+psXRdih7hLqIepwgEA3K3xAJ
	 FbVvosf+XX9hskZjxWbXK/a41oe5FxZy30/TMcMdziFCXPPUtvpyYlepEfuJc4+p6n
	 scPMnvEb0y4fxmrGDljS93bDHVFN72m5JaCUwkNDmgDKA2Ua5UQ8wOZl9IOxtyvZFT
	 wQaUlJvrPLd5JgIJ37738VZCtnThQUY5cZGtlaoALoSUxXkRW1Yx64bMsAoehU2bnU
	 9P6R0sNDVegJDAPP6ZDI7I2HJZEIY8F/SxCd77tEyQm86+itG573+7A75LcBZVKSjh
	 vtfumjhDOMaBw==
Date: Mon, 29 Jul 2024 19:06:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, Mark
 Lee <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v2] net: ethernet: mtk_eth_soc: drop clocks unused
 by Ethernet driver
Message-ID: <20240729190634.33c50e2a@kernel.org>
In-Reply-To: <5f7fc409ecae7794e4f09d90437db1dd9e4e7132.1722207277.git.daniel@makrotopia.org>
References: <5f7fc409ecae7794e4f09d90437db1dd9e4e7132.1722207277.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jul 2024 00:00:23 +0100 Daniel Golle wrote:
> Clocks for SerDes and PHY are going to be handled by standalone drivers
> for each of those hardware components. Drop them from the Ethernet driver.
> 
> The clocks which are being removed for this patch are responsible for
> the for the SerDes PCS and PHYs used for the 2nd and 3rd MAC which are
> anyway not yet supported. Hence backwards compatibility is not an issue.

What user visible issue is it fixing, then?

