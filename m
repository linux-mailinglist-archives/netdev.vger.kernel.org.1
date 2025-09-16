Return-Path: <netdev+bounces-223778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BABB7D4B2
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB86A174E2C
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099592D0C69;
	Tue, 16 Sep 2025 23:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rty/Th3W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D496E23B616;
	Tue, 16 Sep 2025 23:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758065141; cv=none; b=BEJS6t0yyoEBB0lvGVPouzL/29o/ckVdlHAlxPy/AAJxrPQDbAFTjXl1eQe0hu6NvA8RMc6UVGdma2pXaF9MG43VeRqiGygR06zvTfmNdSy+2CxJZv6RAjr3eP5S9uqLqQwRfL45pNeT9YszsMBmDPjClGaAv4kXk8zDyZkyOis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758065141; c=relaxed/simple;
	bh=QUkQxqi9eu0Fc1MZt9sDJxSWsrT4iMYqyFWbayxC8MU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C4fvfSXUkLAUPiZfOjFR2R6SRnsmEcbn/y3qDlgRdJxSq5uZrxVXvokS4xzhNFoWItR7HqIXoMUZuxwgQgoWIearNMaRu8FlYXrcT+EHZKyAgXhGU1PSqAMkrYvrG9/DKvnTzpT9mzu1bPYVy8jaX3wFiwwwsKQ64aQUptnZMkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rty/Th3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B54C4CEEB;
	Tue, 16 Sep 2025 23:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758065141;
	bh=QUkQxqi9eu0Fc1MZt9sDJxSWsrT4iMYqyFWbayxC8MU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rty/Th3WlhiYvzDabglkQXR361MVxbn1Xm6UnSJGXO5GUC22IOf2G/ncHPMYWBZ5K
	 oGmhm7DFM/4GqZHfFdyBwT3oq/PJC3Cr2EXNoE7jax/B+QYq7D00p2AdgajznDGlHz
	 sPNKVhfHe05y3eqO7KAN4TN6Sh9CFmxzwBSzIJxM+qFj8El4nBfPFWjAvvciQD3Vq6
	 HvIoXCVc7dprTeZfESb5RyG3xaZCw1r6djDJG2gnI9xmehcUWZAsmP4VKKz2B0dZ1I
	 Kx52NZGB2dzhgmujF5kMUnAcYWGXZgSaddNOd0tOvYkGMkSDA11ysLyQa8sOvDY3AY
	 ONfGbgJqsmijA==
Date: Tue, 16 Sep 2025 16:25:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Konrad Leszczynski <konrad.leszczynski@intel.com>
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 cezary.rojewski@intel.com, sebastian.basierski@intel.com, Karol Jurczenia
 <karol.jurczenia@intel.com>
Subject: Re: [PATCH net v4 2/2] net: stmmac: check if interface is running
 before TC block setup
Message-ID: <20250916162540.66ae3091@kernel.org>
In-Reply-To: <20250916120932.217547-3-konrad.leszczynski@intel.com>
References: <20250916120932.217547-1-konrad.leszczynski@intel.com>
	<20250916120932.217547-3-konrad.leszczynski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Sep 2025 14:09:32 +0200 Konrad Leszczynski wrote:
> If the interface is down before setting a TC block, the queues are already
> disabled and setup cannot proceed.

I asked for more details in the commit message earlier.

Also where did the Fixes tags go? The Fixes tags should only be removed
for the patches which end up going to net-next.

