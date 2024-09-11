Return-Path: <netdev+bounces-127190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A89974850
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 04:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D271F2563A
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 02:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E64273FC;
	Wed, 11 Sep 2024 02:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHd2OcxB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEBFB676
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 02:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726022832; cv=none; b=THaO7QQcLaYy+vBlQ6r8MlPZdcDxNT8zGatuWVj3/OgQO4pbKIRVmzp1cEu2dR3wpyKqBZFB0rr8uQxw/SEhMMRW2IUrwt6fUe/Xv85yDBzjj+B6WXgBT+KDEidyvcwqCdL2O38w0QF7SCaNUcknOVQtAOc4nTkQtRVCKi0beTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726022832; c=relaxed/simple;
	bh=hlk1hTCFSRd48EFd0aHEmczsATYcqRa30JLCV4ubyUk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JiIAvLY/TvSI712K+XZo/GqExDRA6piPTYtxuFwCaIMOzT5kr+pX8LoyXxlQqlTgElPueQC1EvOZgY1RUUDfGsZXL+/pF1Xw5A/VfdsLGU5KjWMtNzDA4tXCYtDdDVovCTdSflmkl/6bm2LfsAIQSoWhNM3E6lh5KeewMKS1lrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHd2OcxB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A405C4CEC4;
	Wed, 11 Sep 2024 02:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726022831;
	bh=hlk1hTCFSRd48EFd0aHEmczsATYcqRa30JLCV4ubyUk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IHd2OcxB9rglrpT8ZTahN+5KU2ZQzEw1ukeG1q5wrA0rY7GuZ6vG5GRIkfYIoMd/u
	 cHGJGvauwRuRoMcizmV3uudF7frlWDGIcXHBMQWryRv8VqtMeUoKZpSo4DeJQdM4U1
	 EZFG5S4Oo8nVSKE5c0h/2kU7K1Sb0vk0xpP5/nMq8nSIUHzYKoTjRVBR9vGjjm5sVq
	 YUHFENPCkSLlJHia5ZUVfmbrupJ+jRvReuVS6JeFMSn/Zwe8VOcjBa+ofEtNba6g0B
	 oz+Z4RF/WgkOmWHZu9boNCLHF7aY9nJFBmks3U1vk1kpJudfljIwZx0m13esDbnwjL
	 ze7655l0BcsHg==
Date: Tue, 10 Sep 2024 19:47:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Itamar Gozlan
 <igozlan@nvidia.com>
Subject: Re: [net-next V4 04/15] net/mlx5: HWS, added tables handling
Message-ID: <20240910194710.668b1ff0@kernel.org>
In-Reply-To: <20240909181250.41596-5-saeed@kernel.org>
References: <20240909181250.41596-1-saeed@kernel.org>
	<20240909181250.41596-5-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Sep 2024 11:12:37 -0700 Saeed Mahameed wrote:
> +out:
> +	mutex_unlock(&ctx->ctrl_lock);
> +	return -ret;

the -ret is on purpose?

