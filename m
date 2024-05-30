Return-Path: <netdev+bounces-99234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBC28D42BE
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 03:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C101F21DC6
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 01:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA552EAF9;
	Thu, 30 May 2024 01:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CV09LSnI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844D6BE58
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 01:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717031542; cv=none; b=ox7IafdhjbCuzbNvG5vL3KrCvA63rCUvRUkM78ntkYurFW4Mtip9yLkpXUvRHj3C+o4GUzegoMveVqpGDWqCw7oVUmZFnMZVYrR2xQHE3AG0IlrXO0LXaX/1j/yboZGdeGF/1omtGpN7IrXlHHVOkmpsNcqoXR4K5Tc48V2iEK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717031542; c=relaxed/simple;
	bh=0orKCRChGhu3XZP12v1Y8XnxTDukfxwRxdTrlS+JTiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YxV68+IVOlkyGbH0z23y2FesBI1xP1W2fTvBO3vFkwpHq82QZhN4WPjw9YJFtaEgQVK34bm0v69hU3jQk/piE4FSoMdG358CUrEF5iPph9YdIGbhV+CKFKIrEJIvLqoL8pl5nVRe2SCotP3vboxa3jQ83bGJhDACVmoLrx9qS6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CV09LSnI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F802C113CC;
	Thu, 30 May 2024 01:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717031542;
	bh=0orKCRChGhu3XZP12v1Y8XnxTDukfxwRxdTrlS+JTiQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CV09LSnIEfEUaxnurLwRgRXgm8k07BI6RdYB+iwWiK3RaSdsjn7/iYMQAtDVYeZPA
	 DosRiqfaWCiRJKMzzYGdzGcWNv6l3s/fBecaYaM3IpCUD/GrOjHs3Pt9H1VcbZNMSG
	 u25Ql4OVz7urphl4uAcTg4Fzhe+6rCjehOBAxoQO+RUEmEo4yu9R2IRev3F0vkpepA
	 m0bPsXPQTbMU8H397ONHMI5Z+ail/BnJT+IlPCpf7154kl1UBHsWNHnyTlVQV07gIX
	 5DywRTv4vmALw/GAhH4+n5U3JwJvLYUlBBzbHPmhdEAkQb7Fv4NxtVpsvXGE9Ertqp
	 C73NtkKjGt4hw==
Date: Wed, 29 May 2024 18:12:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
 <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next 02/15] net/mlx5e: SHAMPO, Fix incorrect page
 release
Message-ID: <20240529181220.4a5dc08b@kernel.org>
In-Reply-To: <20240528142807.903965-3-tariqt@nvidia.com>
References: <20240528142807.903965-1-tariqt@nvidia.com>
	<20240528142807.903965-3-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 May 2024 17:27:54 +0300 Tariq Toukan wrote:
> Fixes: 6f5742846053 ("net/mlx5e: RX, Enable skb page recycling through the page_pool")

Sounds like a bug fix, why net-next?

