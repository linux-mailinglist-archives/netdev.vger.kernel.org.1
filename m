Return-Path: <netdev+bounces-217105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD71B37620
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 02:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 368B5360A5A
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 00:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE091DFF0;
	Wed, 27 Aug 2025 00:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3FU/Jzj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A39186A;
	Wed, 27 Aug 2025 00:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756254803; cv=none; b=ssmbP7U3hjXQ/49kydcf723/DYHUYvgfOXL0LKlROj9zgymzjdJDVGsHidLX6pxn+B/8wEQTc8QsINEBHJ8rYD02XJPASund8+Dq49PHNdaOhCOoCRTjJeCW7h3R43bEGPcqzjRaiUtBWOCSmxo/lasRKAPLc+phed1OrBYGvKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756254803; c=relaxed/simple;
	bh=TwZUc1h8AHqKrGzgu7xaatr7DZAYU/mP32X+lNAdyG4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ey3K43EiSO9hPxSSyVMPrRRg2LNqtDqaiISxei8Ns1l3uoIl4XpGVNF/SHiyXpOFHtvWK4EOjmDqYnRA+3/o8iwfcVQ4XBllGvDcxWclj0NWFHXaZceFvYdUcQtBo/wBkQYqk22usisycpn84lR358RL7cZ7nf+v5y1OGl9h2Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3FU/Jzj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9390FC4CEF1;
	Wed, 27 Aug 2025 00:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756254803;
	bh=TwZUc1h8AHqKrGzgu7xaatr7DZAYU/mP32X+lNAdyG4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j3FU/Jzjd/hHLESRE9ExvC7750xDZxU/hyzJPTncFpXzcQYCojfZGSg2DqC5bEkH/
	 3PN37JTDyxai8GRliT4iFxn529C78vc9JI7mMoheEsU3aLtjXdAPJnISnValZala6J
	 1cyzMpfZ2eFCVYurXiBygwpAzQFWr7ddG/rCt20dlLPIU2ai6Nq8wgKRbTn3HRC0D3
	 eBDsrYCPokmDJFj4DbNbQHeTLM/4sIQYR8+dOe89y2MKAGDACQ7wRmWVp7ujc7VhvC
	 pt3bgmJlKHpIyppSsKX+PSG4FWEPrFmUj6eDSvbFSD5mxZvKAUk/lOXnGZu/5LIvwr
	 L1RXq3UgxduzA==
Date: Tue, 26 Aug 2025 17:33:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: <almasrymina@google.com>, <asml.silence@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, <cratiu@nvidia.com>,
 <parav@nvidia.com>, <netdev@vger.kernel.org>, <sdf@meta.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 6/7] net: devmem: pre-read requested rx
 queues during bind
Message-ID: <20250826173321.4ad50edc@kernel.org>
In-Reply-To: <20250825063655.583454-7-dtatulea@nvidia.com>
References: <20250825063655.583454-1-dtatulea@nvidia.com>
	<20250825063655.583454-7-dtatulea@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 09:36:38 +0300 Dragos Tatulea wrote:
> +		rxq_idx = nla_get_u32(tb[NETDEV_A_QUEUE_ID]);
> +		if (rxq_idx >= rxq_bitmap_len)
> +			return -EINVAL;

Sorry, missed this in v4, could you add NL_SET_BAD_ATTR() here?

