Return-Path: <netdev+bounces-214112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EE9B284EF
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 19:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B22297B4F97
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 17:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14C430DEBA;
	Fri, 15 Aug 2025 17:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkpVqzuq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8960430DEB2;
	Fri, 15 Aug 2025 17:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755278676; cv=none; b=t4/xBJCsjupKDxL3DbosbC+VTozXlHdoFFKEyEYO9xTOrODgr7/xd92EcePJQXUVcpHdkubn5sot7yA4fY4xE2A/7g+cb8waHuoCOHgv0nVk1g+aT/rimh9K1RotKqBuf/MK1gNYRxo9+SDhUPTIF0sJjLj7x2ghYj12gjs9kqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755278676; c=relaxed/simple;
	bh=A+OQyI61NLcPmKbw1WVrKnfedrqjUSPJDvRkfIV3WQs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ViIkgG6OuB9Q9fTTt6L4brihPRrieDS8CEyOsPpH/X5FHu8iWQxtTSc2NINceSp4rO+1/m2zwPEYhrB9i+JxX939aUds0WNBBTd0Q6KwAd2AUelIw3U/aUA8GyUteQplfxHvqOx9I6wE/1FE4CUMo1F8/N8/BS2kgphC2xJvAhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkpVqzuq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4CFC4CEEB;
	Fri, 15 Aug 2025 17:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755278674;
	bh=A+OQyI61NLcPmKbw1WVrKnfedrqjUSPJDvRkfIV3WQs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pkpVqzuqd7kteBQJPGP/lQfIiNoRfRLhjlBLeYkWWkupcMvhCQ+Qew3WdAmKBpeUK
	 FooqUZsYywCC1X37rAM1WKF9/3ouB5TtYODdsKjyaSLLECQYdWRwxgMaDWZy4BQjVS
	 hPvCC/78K4+F9GH4ATX2CWMP9KwRFraX9csst7b23ECcg4NVnZ8DFuSY8MnwsUYwop
	 FJCKHVQFLWh/onPx7OGy40bkbKfO20jfUyZxz0lADV1a71ohOvJympuxwxUR65psMR
	 dDgfnSmPyMIxODUPpsBC/uatxlIMMykuisftNfexpvmyTLhWAu0HePj+GDe/l073FG
	 kZUQWkh46P/Jw==
Date: Fri, 15 Aug 2025 10:24:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: <almasrymina@google.com>, <asml.silence@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, <cratiu@nvidia.com>,
 <tariqt@nvidia.com>, <parav@nvidia.com>, Christoph Hellwig
 <hch@infradead.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v3 7/7] net: devmem: allow binding on rx queues
 with same MA devices
Message-ID: <20250815102433.740eb2a6@kernel.org>
In-Reply-To: <20250815110401.2254214-9-dtatulea@nvidia.com>
References: <20250815110401.2254214-2-dtatulea@nvidia.com>
	<20250815110401.2254214-9-dtatulea@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Aug 2025 14:03:48 +0300 Dragos Tatulea wrote:
> +		rxq_dma_dev =3D netdev_queue_get_dma_dev(netdev, rxq_idx);
> +		/* Multi-PF netdev queues can belong to different DMA devoces.
> +		 * Block this case.
> +		 */
> +		if (rxq_dma_dev && dma_dev && rxq_dma_dev !=3D dma_dev) {

Why rxq_dma_dev ? =F0=9F=A4=94=EF=B8=8F
Don't we want to error out if the first queue gave us a DMA dev but the
second gave us a NULL ?

> +			NL_SET_ERR_MSG(extack, "Can't bind to queues from different dma devic=
es");

_FMT the conflicting queue IDs into this?

