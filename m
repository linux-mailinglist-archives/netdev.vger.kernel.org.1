Return-Path: <netdev+bounces-109338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C77928048
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 04:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 723E1B23D4B
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 02:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B940E168BD;
	Fri,  5 Jul 2024 02:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrXnsv7w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9259A171AD;
	Fri,  5 Jul 2024 02:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720145837; cv=none; b=nk/Nx5fnglgdM6ll9hWrEZCKz/rgHX2ehdH0+991Bm/Ad6ABrWQAMZNYQ/2qp5J8yYRRXAhYeL/hVsAxllSEaKk7bhAVhWvlo0uztoF8JER355wqPsxSPJPAkYzOqh8/TY8tu8TFTd6tL8YkBao8U9fg0Ps2sYW0P3DC4qBSxpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720145837; c=relaxed/simple;
	bh=j/FedBnAgJfV8rg03y8T0SddGEHM5JTOfp6I+w8XdBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rF1X9Pwokj6v/u14Z82vaf06P5X85V0HjU5VGhuvQ0AQb8aYV00+mgY5lBfc9WkonheJWkyt/nyoPbOMcQWjQTYOePP0Cp2xoprktFaOTwbhBnu4vxePUrmeS/7PdalaTNac9uK7xSN3BsfnBBjov1wH8cO5xsoehr75icdxs6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrXnsv7w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4AA1C3277B;
	Fri,  5 Jul 2024 02:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720145837;
	bh=j/FedBnAgJfV8rg03y8T0SddGEHM5JTOfp6I+w8XdBQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CrXnsv7wRq/Ztyib+Aa/xRHwQGdNsepqV7bPRSjRHOULJAQeQ90B5xRmjdyl2tYY5
	 9cmktgsVo6TskPrNABOxvWvkV7nLag8S8vQ+AKMec5cKy4PLovl2l5i3kHSp3b1J1Q
	 Fty6wOa6BBadv6NXs746HTAYmlx2tBHjMJTp5QPAVjgv2d+1rVgQdSm8dHYKpfpbZn
	 ywF8G0sUt38yCBBfn5cYbyHDnhE97DX4eXHl+MVvaHs67LNN4LCe7gHIG5f2wlLNqU
	 Ssa3NrH9OlFDRKI2N7xJvUnq7zkZsOaxjcsIdibaJa++9cwbzRpAcAboqqUq5BWztz
	 fVecqklGLKITA==
Date: Thu, 4 Jul 2024 19:17:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn
 <andrew@lunn.ch>, nex.sw.ncis.osdt.itp.upstreaming@intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/5] netdevice: convert private flags >
 BIT(31) to bitfields
Message-ID: <20240704191715.523f0ef9@kernel.org>
In-Reply-To: <20240703150342.1435976-2-aleksander.lobakin@intel.com>
References: <20240703150342.1435976-1-aleksander.lobakin@intel.com>
	<20240703150342.1435976-2-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Jul 2024 17:03:38 +0200 Alexander Lobakin wrote:
> +	/* priv_flags_slow, ungrouped to save space */
> +	unsigned long		see_all_hwtstamp_requests:1;
> +	unsigned long		change_proto_down:1;
> +
>  	unsigned		module_fw_flash_in_progress:1;

we need another rebase, Ed got here first
-- 
pw-bot: cr

