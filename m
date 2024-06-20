Return-Path: <netdev+bounces-105100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BD590FA69
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 02:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9E571F21A3A
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 00:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D17A4C8C;
	Thu, 20 Jun 2024 00:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcwqRKMF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282184C81
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 00:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718844199; cv=none; b=m4R5OAk0YcLxQFxzYwoq94oFtc1BLzrtArvE15mQ+hY31RIA4jlqLOLAuHXxPAwEtV65G8TNO9WRJIQimsKItDS+GEMYdrbY1jlnB52kSFqp9avRJ9EwmxcpNJCQfGuSDKApaZn8hPaUr1bGZ4FrQTmm7fGy9ijxDI8zHtKKxXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718844199; c=relaxed/simple;
	bh=knOHUbhAJ8xKxscuEzhB7K4tH1Ov44i5XCTCnoa5YbU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SGV4WmoUeTuBCYrL4mjyepZ45STlBiew+4/ZtGLLBbUduEurGm+SzdQUEyeHL321LZnKknbOHGtlIxUi309tda40PoC4AwAFpgG46ZQ5u5gfn3BhFnMpoWVf/pGC3P1MrCdLr48SdfBQWemzRgy9R58/EBAwzthumqXbAJ05YVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcwqRKMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39CA7C2BBFC;
	Thu, 20 Jun 2024 00:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718844198;
	bh=knOHUbhAJ8xKxscuEzhB7K4tH1Ov44i5XCTCnoa5YbU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FcwqRKMFHL3RALOeW2OID/pUVMTJw1au/MR1+X5R/Pe+/60jQfVALXJuUogCwPPZg
	 NuosTI1IN35yWusybix4ULVC9xRUpWm87byrBeYwI2U4dZeBdcs8jofUFEMCKmYNfE
	 KpMP/69WgAjEN9U6+H+SweYMiWzLXWY2ncn4eK/VN+iZixdzfCw95o6J3cXZt1mWOQ
	 miJda0btMIVsDl4zAtHEs3YNqQuBZ0OoMAXQLyztMhXJrQAoFCSMucE/SGV2P8tzgO
	 pQK2B3GaxYygD9Qt+hmCfksFLf3Q2v3DoujVlcMf6q4jMYHhk0HgYI1BwDfBw+n5v/
	 uhESwA1dzD03w==
Date: Wed, 19 Jun 2024 17:43:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <David.Laight@ACULAB.COM>, <andrew@lunn.ch>,
 <brett.creeley@amd.com>, <drivers@pensando.io>
Subject: Re: [PATCH v2 net-next 2/8] ionic: Keep interrupt affinity up to
 date
Message-ID: <20240619174317.6ca8a401@kernel.org>
In-Reply-To: <20240619003257.6138-3-shannon.nelson@amd.com>
References: <20240619003257.6138-1-shannon.nelson@amd.com>
	<20240619003257.6138-3-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 17:32:51 -0700 Shannon Nelson wrote:
> +	if (!affinity_masks)
> +		return	-ENOMEM;

There's a tab here instead of a space

