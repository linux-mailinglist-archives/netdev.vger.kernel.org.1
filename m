Return-Path: <netdev+bounces-203093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2157AF07F3
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 03:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A264A6454
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 01:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAC7151991;
	Wed,  2 Jul 2025 01:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaDhnoPQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3879B24B28
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 01:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751419818; cv=none; b=rQ7Y4B2kVySlZ6J1Vqjz2/UfPpGn2QDAT+kPfn9u511Q5uVhFQc/I1BqZBvDJR6Y+sxeUzxK/aMGLMXPqNomJvxywOTetBwFQYTUxjihAFHy7+XpMFXGO8OacdMuX3gNy5IIEFBf82lNzZKzVeskF4/K5cvp6UrgOXcn4RzfveE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751419818; c=relaxed/simple;
	bh=cJgnEQ3tD9ypOvFlW4hTKNUK8cZgELcb8vW0hBsz6Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s+7stUIa4xH4INjM7oP5pkwGfnUGW8MD5c/P4aE1i6wdeCBHBKykCsKErR1+bClScGHcwdogWKoj2z2ixrATujQemewASikEhcWImdR8LgRYo4NeEybQICj4OUhkq/ShsA2KavCtawRSoHbyJbHUCoiI1/FzhOcOrzDfhJPIO+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaDhnoPQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B47AC4CEEB;
	Wed,  2 Jul 2025 01:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751419817;
	bh=cJgnEQ3tD9ypOvFlW4hTKNUK8cZgELcb8vW0hBsz6Ck=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DaDhnoPQi3qEuupBm/YUJDYwX/+K1sROEgsLVOtYIc0JngmpyJO7lB70DMG3ZA2AE
	 uQXRBqj72ZUzeq82flZaltdo0xxhEd3OGWXdkibCWa9LRap6mInhgFIiyrFoZk+RrY
	 Mxu6xUkyuJdXUlnZuf8FWhhGFB3Vk2ntllAQXo6qsWMkYcA6yxuZxKVv0Sa7CE72YI
	 rFgFBOM9dyvFnCX74CvLsLDId6c/oaUUvJLwPGLsHO0y/xamdbEoNCqLz7K/J2tEAa
	 9GIKgW74fWyBdXvvu3yNeFtUFks5mw6ISTpU0WAEUOQyPrUy1npZA9YRUWsYEjinlS
	 QWYC/145Qnh+A==
Date: Tue, 1 Jul 2025 18:30:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mingming Cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
 ricklind@linux.ibm.com, Dave Marquardt <davemarq@linux.ibm.com>
Subject: Re: [PATCH net-next 1/4] ibmvnic: Derive NUM_RX_STATS/NUM_TX_STATS
 dynamically
Message-ID: <20250701183016.26212cec@kernel.org>
In-Reply-To: <20250630234806.10885-2-mmc@linux.ibm.com>
References: <20250630234806.10885-1-mmc@linux.ibm.com>
	<20250630234806.10885-2-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Jun 2025 16:48:03 -0700 Mingming Cao wrote:
> Replace the hardcoded #define NUM_RX_STATS/NUM_TX_STATS 3
> with a sizeof-based calculation to automatically reflect
> the number of fields in struct ibmvnic_rx_queue_stats.
> and struct ibmvnic_tx_queue_stats.
> 
> This avoids mismatches and improves maintainability.
> 
> Fixes: 2ee73c54a615 ("ibmvnic: Add stat for tx direct vs tx batched")

Fixes tags are for changes which fix user-visible bugs. Please remove

