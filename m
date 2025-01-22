Return-Path: <netdev+bounces-160167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 391FCA189D3
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 03:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7290216B525
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 02:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A692E628;
	Wed, 22 Jan 2025 02:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePqHKXUO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3441D8F7D
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 02:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737512255; cv=none; b=fpUQAVOGIj4I4wZwXes6DD3DQzRrGKUwy/YgX3ffMi5NP1g+LQDWeNC2bZ4K2F4rb79MkuHDLSKTdgB/hlbJ18+U3b05+uAL6VLhREcUFH75KEv75pAwym2xUf04mC/hdSf+qMUMd5M+mqhWCxECfKIkRSbMHktWFLWcSoYWbTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737512255; c=relaxed/simple;
	bh=6BHJxUTIu6z9317IZRwwGRwXign7IZfjKVp0HHHfJWk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fUoCXmJ2gYLerQnkRN2PYw0yH7E1wwqYqMHy9KiMMQoDvkneZcaIqRe86fLAV3uRb4J3zJO0ySe29OKYuLu8xVBcPyxh78/4a21Qq1KQ1pq7NvABdUgPO2BBEbiFFzj8QMruldW5EH7bVuxg1JCsMgKXtvXBeP8hgRiiqNnlksw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePqHKXUO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861A9C4CEDF;
	Wed, 22 Jan 2025 02:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737512253;
	bh=6BHJxUTIu6z9317IZRwwGRwXign7IZfjKVp0HHHfJWk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ePqHKXUOgXjCzu+MtLPQ3Z5ZZj+sOZmjhAM+f/s5XLZDCSqOU6h7MNwqoxEoNaVzt
	 TadobhgK2h3ahpBzohZnIDweuQuWf94yGesc36ckUFge4+Oi5tvrSehNCyFashRiK6
	 V0zUmesORuC4EGsDSuM5JbVbK/57GSDhAw2GoLDbXPvKsnuTXd+P803HHf1ndP1atJ
	 l8AEaLEM8OKmTYFcPjtSTsF0kOROCCB4OBaQ1cdrkznCrG1JNSAQfP3OFw/CDnIZoZ
	 gz3T7m1+MudroI2cR32gA3M0Dfr5qflNLBr5MOp5uuw0la8T2w0Tn/Pln6Fi1vSkUo
	 E7o0AcwzQZIWw==
Date: Tue, 21 Jan 2025 18:17:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Edwards <mkedwards@meta.com>
Cc: <netdev@vger.kernel.org>
Subject: Re: [PATCH] ethtool: Fix JSON output for IRQ coalescing
Message-ID: <20250121181732.4f74b6a6@kernel.org>
In-Reply-To: <20250122011445.4026973-1-mkedwards@meta.com>
References: <20250122011445.4026973-1-mkedwards@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jan 2025 17:14:34 -0800 Michael Edwards wrote:
> Currently, for a NIC that supports CQE mode settings, the output of
> ethtool --json -c eth0 looks like this:
> 
> [ {
>         "ifname": "eth0",
>         "rx": false,
>         "tx": false,
>         "rx-usecs": 33,
>         "rx-frames": 88,
>         "tx-usecs": 158,
>         "tx-frames": 128,
>         "rx": true,
>         "tx": false
>     } ]
> 
> This diff will change the first rx/tx pair to adaptive-{rx|tx} and
> the second pair to cqe-mode-{rx|tx} to match the keys used to set
> the corresponding settings.

Missing 3 details:
 - your Signed-off-by tag
 - To: Michal K who maintains ethtool
 - Fixes tag pointing to the commit where it got broken

Renaming adaptive keys may be a bit controversial. We can decide
whether it's okay to change the key based on how long we had json
output for "rx" and "tx" before "modes" got added (IOW how long 
this has been broken for). If breakage is recent we need to leave
adaptive be, someone may already be using 'rx' and 'tx' as the keys
in their scripts.

