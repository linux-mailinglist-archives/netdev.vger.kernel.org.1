Return-Path: <netdev+bounces-119274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7B995508B
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 20:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 301991F22E47
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 18:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBC21C378C;
	Fri, 16 Aug 2024 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4voLZmR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087681482F4;
	Fri, 16 Aug 2024 18:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723831773; cv=none; b=Ot3cYLOBwBBEBOpTx+DCHvyhl8tatUbYxkaIBPl6HrsUMMgRI2ZGheVKAfODvP78adwh4vl6LjzzVW/pimU2TqfPCdBPfgDwz7MstYaBKysBFeFH5/+cibSW6/15UpH0NCP5ynF82O4Nn3b6SWdZ60pcjrtH2RkMrDEr9iZgs0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723831773; c=relaxed/simple;
	bh=2pwdYzQ2ojaf94uUSc3VfR/126ez82e5gZxfj8e+7BA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DIsHIdKwSrWuXfQZvJiwdE34oVT3gu5eISisLDXpNOOw2pW3kt9Uj/gDi3rP6WeV5WMx1T0Feiis1aJ7pIXvqXw2N+q5FGfdYTZZ/YhWNrwkX6S9sr0L7y4AM2pevwKp2aHToULuNTfY8QSbavG2cRQ2pNi+m+hOYWezNfvbZy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4voLZmR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2F8C4AF0E;
	Fri, 16 Aug 2024 18:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723831771;
	bh=2pwdYzQ2ojaf94uUSc3VfR/126ez82e5gZxfj8e+7BA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C4voLZmRQ5Wf7Hx+7sGeKAABNuyIbLbewF/VAV0+W+YSxA8X4e8A62Lo4Myd2tkCp
	 qS4TMHCH0Bs0gG+Ra4ABe5l7fK8XozXgNK1T31AqzAJ3AYTCbD7LdXBS9SV1JvBI8o
	 PWU+/tMTo2HqIV+CSEKqlm7w2NIDN+EBBRbFsG908yoOb1J4YosA7yRRM/pU+nYInN
	 dFkUU4GFP4JRAO4NsgO68P8OEJgeaCd1L0ggEN+q0zYv7I8R8ygoWeiAth2rEA3hx7
	 dM4yTPHqN9DD8IPgCT2iHNmU0jore++z0+JkyyXdQ47IWeq80GkFgAXMrb4MxB7SKS
	 6WgQBHYw6atmg==
Date: Fri, 16 Aug 2024 11:09:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: ende.tan@starfivetech.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, leyfoon.tan@starfivetech.com,
 minda.chen@starfivetech.com, endeneer@gmail.com
Subject: Re: [net-next,v1,1/1] net: stmmac: Introduce set_rx_ic() for
 enabling RX interrupt-on-completion
Message-ID: <20240816110928.1a75d223@kernel.org>
In-Reply-To: <20240814092438.3129-1-ende.tan@starfivetech.com>
References: <20240814092438.3129-1-ende.tan@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Aug 2024 17:24:38 +0800 ende.tan@starfivetech.com wrote:
> From: Tan En De <ende.tan@starfivetech.com>
> 
> Currently, some set_rx_owner() callbacks set interrupt-on-completion bit
> in addition to OWN bit, without inserting a dma_wmb() barrier. This
> might cause missed interrupt if the DMA sees the OWN bit before the
> interrupt-on-completion bit is set.
> 
> Thus, let's introduce set_rx_ic() for enabling interrupt-on-completion,
> and call it before dma_wmb() and set_rx_owner() in the main driver,
> ensuring proper ordering and preventing missed interrupt.

Having multiple indirect function calls to write a single descriptor 
is really not great. Looks like it's always bit 31, can't this be coded
up as common handler which sets bit 31 in the appropriate word (word
offset specified per platform)?

