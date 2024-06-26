Return-Path: <netdev+bounces-106945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947BA9183C0
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 16:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 534BF28264C
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 14:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7CE1802DB;
	Wed, 26 Jun 2024 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0PcymKw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987A88495
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719411410; cv=none; b=ezl93P9WGxmmpQoixIC2PtBO9IownIiVbkah8GGNV27zx5W5cNiHb0d99orenX+kHWFv+BibP1xE/Jvonh8Gq0DNZRhlRwTTiTi3ggN5GlhyNBHqdXO8wroUwin4g8nnwfIyPtLQjE9LumEilUSCGQKJr3CdiyOmgbOpiCotd6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719411410; c=relaxed/simple;
	bh=r7zgQT4bjsMpCcydwQQWdCqH9BUHLBn1pGS/N6ps2eI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XaZLH4vrrzt7cqlVbKO7O5xiCVqZRszi5OcHzXdWbd7vpwHnUZtVczfYgVMZo1bc9iDhbD937nS75psuZpfyC4Sl73VSYmkCDgX1icGq/wjjU5+gSYt4L8nsbrz21KOANNoelN6Qvh5lVsTGTZy3R3voCkqqrl5HTbRDVQ8YKrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0PcymKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00B7C116B1;
	Wed, 26 Jun 2024 14:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719411410;
	bh=r7zgQT4bjsMpCcydwQQWdCqH9BUHLBn1pGS/N6ps2eI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R0PcymKwizEG1NRSP8D/uv+p/zf+EdISevWaYXV9dlsvtRv3Wtyob7UGtCmyEKw3l
	 xvuahiHSKKHADxBvtxbWYTT1gyjZCMivzbu0xi2DNe4AJ5XEI0hhmsNDySP3G0dLy5
	 7TQ2pTwHkjtCiZEYiDosCR5E6PhzW1Oieqi2hKOBFitqcJwUAgiMQYevikyR/2pZJP
	 WtOgou9eYaRbm0c9vna5FEERA6vJL8fG3G1Ihb7dZTyt0pq65Bab1/creDr2aCLA79
	 K7RbWALEltl8oDS+r8nc7eFXDB0ILhEsn3tBxIM5rob+JRaplnPuf8J4aO0L/VAcrp
	 0c0SkfSwBWp3w==
Date: Wed, 26 Jun 2024 07:16:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
 davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH v2 02/15] eth: fbnic: Add scaffolding for
 Meta's NIC driver
Message-ID: <20240626071648.1fe1983d@kernel.org>
In-Reply-To: <171932614407.3072535.16320831117421799545.stgit@ahduyck-xeon-server.home.arpa>
References: <171932574765.3072535.12103787411698322191.stgit@ahduyck-xeon-server.home.arpa>
	<171932614407.3072535.16320831117421799545.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 07:35:44 -0700 Alexander Duyck wrote:
> +/**
> + * fbnic_init_module - Driver Registration Routine
> + *
> + * The first routine called when the driver is loaded.  All it does is
> + * register with the PCI subsystem.
> + **/
> +static int __init fbnic_init_module(void)

kdoc got more nit picky in the meantime, we need a Return: annotation
here.. or maybe make it a non-kdoc comment?

