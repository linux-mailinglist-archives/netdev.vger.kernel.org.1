Return-Path: <netdev+bounces-198849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 211E8ADE0AB
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 03:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 802AB189D5A2
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 01:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41262AD2D;
	Wed, 18 Jun 2025 01:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPnWAZjJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E87828371
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 01:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750210366; cv=none; b=HqFXGCZY7PA5Uu1chF8VUNJsTo2b4236McLl69nHrXwDsKLor/Am4C3VJ5+XZzQoJDidmfn8uULC0LEHlj1W8CBwRfFBPp/twYMwv2SD5sm2SZh5IIo19I4TcOgkfABxpsfI03m9cjMoTbRgW3evH71Ksdu/Si4n8rPV8APiDjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750210366; c=relaxed/simple;
	bh=J75SlLYXLlBO7wssiAHVyOJ7VlFCCM338jXDoIyXWaw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y8qpVP1KtpI1el+tjN9VR2dymGsrLPxRh+GMIFb8vZ1SVCH1OHKbAYmLZLWFXClaGQN3zL3MI+EzPjRRKo0FtwrL9NXypQTf6+ZeD39ZR+rvnmgL8kW/T7VUrDRjNWib3aX+HAfrsXWJhQySNbOb5mPUNRAYAtBLONhsbnGBci8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPnWAZjJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98AE9C4CEE3;
	Wed, 18 Jun 2025 01:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750210366;
	bh=J75SlLYXLlBO7wssiAHVyOJ7VlFCCM338jXDoIyXWaw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nPnWAZjJQtcvGlZzCEcQjxYV2v10yVc7Zn2RCEHfikH8DNB3Eyjh9Hm5QoXwLEAY/
	 ocyCCrqfe0gqLkezku9M1RQ+j9NDTL0YyIuDN/RrJ8bGM8fr1nr89Gdg3x2ICcpmua
	 wFRtpwrvqex4w9Mdu/bKK0Xka5I8f1o+ecz/u8zAM76dSdN2+LQpgg1o4N6iz7CVzw
	 D6hDHsuZ8sHxT2zmiLpemMQM1Tz/sf+VJoS48p9LNpGU5i251C3AFXHsUEYbus21uw
	 30Aj+mEV3VK5iOALierPJ/1mYh3xe9Q5YLjd5xbhWZOB651M2ORglP3j1Ev0STPJeM
	 ztGHcgsEtoEUw==
Date: Tue, 17 Jun 2025 18:32:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] net: airoha: Improve hwfd
 buffer/descriptor queues setup
Message-ID: <20250617183244.641d9cd3@kernel.org>
In-Reply-To: <20250616-airoha-hw-num-desc-v2-0-bb328c0b8603@kernel.org>
References: <20250616-airoha-hw-num-desc-v2-0-bb328c0b8603@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Jun 2025 15:45:39 +0200 Lorenzo Bianconi wrote:
> Compute the number of hwfd buffers/descriptors according to the reserved
> memory size if provided via DTS.
> Reduce the required hwfd buffers queue size for QDMA1.

Same question regarding target tree, FWIW

