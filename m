Return-Path: <netdev+bounces-172649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598DEA559DE
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 23:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91C517A5A40
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 22:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E0727CB0C;
	Thu,  6 Mar 2025 22:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ry/ziY7u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CF027CB06;
	Thu,  6 Mar 2025 22:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741300507; cv=none; b=SKKobOHUYAWRjHQQDjfvrxM7sVWgFTt0ALvx9txNpTizWb8Kmn9sV9B/vuefdPnxaIdshdxhA2xWehEA1Ci+mMs/jTSzABWzBKjYR7AYcm8g3QOS/q8AaHeCjzB2GUKSSL/XYACb6EyZ6iMAhdfaCAfUZn2dBXeuhFXNKUb8x9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741300507; c=relaxed/simple;
	bh=9tOUqspPzeq+F0GQa+rMAGCm66NYRjg83C8QJNrxPck=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZOqAeKPE/ty52GNLRlufgni4F5g3/I5UW1vK/ImnUhYd8Hky4GImYSVp+5/YIYlZakJZzw5pxeY9BOqy2pAI4nUisC39Hd520HrfSbxTPoo4JwImDo/s6zC27JQOOYaQJDy9fca8Sw9pe/0jetwmSDZS/iVW5wD3K+DZmGFY0JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ry/ziY7u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C275C4CEE0;
	Thu,  6 Mar 2025 22:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741300506;
	bh=9tOUqspPzeq+F0GQa+rMAGCm66NYRjg83C8QJNrxPck=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ry/ziY7u8lB46ueKJnolwAQkIdAkcTyrwQcNcUbydYGg1m6WjwI3DxBIMvCPcknzu
	 cpHCUaZaGZ4fQhhUyuskxugOFsO7zd/kwudSNSdyW4CE63k9l4+GoLXvbue0BwmNqh
	 8A6tAC3+Qb7H9bpIBwokqB5EPz8AuqaUyUZazU70Z8WmDJjoT96QuGpfe7hgNYMsES
	 vHpzCZMTwU2tN1yunWbN9EjxnrTPn66c+v+o6h0nF1sskAFmw4WKSpF0XJ+1yZFSf5
	 etRejYq8oUPDLkynYyKYs7lgZP5ah27ScjMF/b6N487rK1y1D3y+T/gxiBTxMF8gTD
	 pgOBUlH12Bfcg==
Date: Thu, 6 Mar 2025 14:35:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, christophe.leroy@csgroup.eu, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 net-next 07/13] net: enetc: check if the RSS hfunc is
 toeplitz
Message-ID: <20250306143505.00f034e3@kernel.org>
In-Reply-To: <20250304072201.1332603-8-wei.fang@nxp.com>
References: <20250304072201.1332603-1-wei.fang@nxp.com>
	<20250304072201.1332603-8-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Mar 2025 15:21:55 +0800 Wei Fang wrote:
> Both ENETC v1 and ENETC v4 only support the toeplitz algorithm for RSS,
> so add a check for RSS hfunc.

Rejecting unsupported configurations is considered a fix,
please send it to net with a Fixes tag.
-- 
pw-bot: cr

