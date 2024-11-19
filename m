Return-Path: <netdev+bounces-146091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CC39D1EE4
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 04:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67458282686
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 03:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0D2146D65;
	Tue, 19 Nov 2024 03:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkBm7RwT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7882CAB;
	Tue, 19 Nov 2024 03:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731987561; cv=none; b=sn74W4DZiWU6/bqQH3Frx0ahBKac/GQ1ia6N2KZ9V3xLnJZg8K5u537bLPfV+0YvuxOw449KJfcSH8rKjY0im7hQGulAcXXTEKcIwB0XIDDuZQ/MdzsRLAMpqSEiETOWZP/2kEbquA032rBhU1Gaehd2Xg2gQS+mPRnFv7aoC9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731987561; c=relaxed/simple;
	bh=Y24jbYMqd6Qqq3ic4qXTy5JxE4Q2q3WDMfUjDj/g6eI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zp4Alu1ObMLo9P+O3kIumsdn+pxfC9J+XOvypm6tlNjC9OnpvY5bkpLPMuIqvPo9fKXjriVpvUNzEh7hJi3AQyGVM5VOhWZgpPnq3mav96+ZW49cdpyOqjzyEp4Yvt4Dpa2UfGtm8V5wYjcrO4VrRTa0nN5/hhLXXSOpwiSLJZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkBm7RwT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90ACC4CECF;
	Tue, 19 Nov 2024 03:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731987560;
	bh=Y24jbYMqd6Qqq3ic4qXTy5JxE4Q2q3WDMfUjDj/g6eI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hkBm7RwTENjfgVB8yeaMj9r60i0tzNUDPNqKn0no1F9a14O1CPTiXAV7raEutJgx1
	 f1GVVihMeKOz5StPFrBHBkWQ2L290IdX/Y6Ah6xUxxKEHmSh3N+CWYDXc9JT0O6CAn
	 lRRPESdi988705bLodCK+8LrjNNJD8RTJ4tekyRe8hk1DoFUfH5IkzEEHfxh/kEfbG
	 ApM6njxlSkerMZkUn9GdQHDwhJSVNcKVtVaUM6o6XxfuMFLFXQlknHDD2jyXXWeZjy
	 m/8jq+QaFowdLfzobCCsL8tQOS4e+PBxPqgHmspQRa33oEdbV3Adx/b4xNein0utyF
	 MToCxRCYUKNXA==
Date: Mon, 18 Nov 2024 19:39:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, frank.li@nxp.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v5 net-next 4/5] net: enetc: add LSO support for i.MX95
 ENETC PF
Message-ID: <20241118193918.0a29dae1@kernel.org>
In-Reply-To: <20241118060630.1956134-5-wei.fang@nxp.com>
References: <20241118060630.1956134-1-wei.fang@nxp.com>
	<20241118060630.1956134-5-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Nov 2024 14:06:29 +0800 Wei Fang wrote:
> +		if (unlikely(dma_mapping_error(tx_ring->dev, dma))) {
> +			netdev_err(tx_ring->ndev, "DMA map error\n");

Pretty sure I asked to remove all prints on the datapath :(
-- 
pw-bot: cr

