Return-Path: <netdev+bounces-145167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7469CD5EA
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 04:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC3831F222F1
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 03:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E9F1547CA;
	Fri, 15 Nov 2024 03:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qX3UxvD9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A7533997;
	Fri, 15 Nov 2024 03:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731641938; cv=none; b=dF9wYxh5N06PULXXOa4wB74eUWKnzzE+U+rBVVB4Nmc7afz7ji1PTlBkmIQ/h+YueBR5Ru5NQtRRR6KYBXBWPpL9SlF/G4ntL+REAMuqI4e/kQQnTZpvhXRp2u37j+YiPcPDbGNXkghy8vbKGm0dnqftpPlW58dfhUbXygkvDSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731641938; c=relaxed/simple;
	bh=9HzmVJP4oHruyDz99UWxbbz6B5JZ98GftxutXSPlUEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OoEsWHLJXON2Fl6M56IOoHuXTAfQX/PoUu1yEGMU0vLRe1ZH6N8oatdIFrRTmO010UeBs/0+Y5Gvj7wn3EjOPrFJ6C6kRHo+RX3wMEFB7fvprmR3S3gA356gf0CDf547nHXvjecUQXrkIdh5nQBttj7FPtwshUQpPgl4QHTaibM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qX3UxvD9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6967C4CECF;
	Fri, 15 Nov 2024 03:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731641937;
	bh=9HzmVJP4oHruyDz99UWxbbz6B5JZ98GftxutXSPlUEQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qX3UxvD9h7XljW4poktyFxR10c1V4DW/BXt78AjTUsrWRP1ury+I9Bbevzebmjl1v
	 AsbgONjPLblTm3Ja9Xi15bkG165zAXiLs1WCkrn6g85zbSPzEvMJwc3UuVwTI4O4ak
	 UZgn36f82jdn6Mos8rp6GSXeyYwAsYE4gI7RMesZxSn/NUAqGy+xYnW4bDQdo27L/R
	 FTP0xEaFRNeqtPM0D54QqZVa1wWKuY4bGWlVtyy3WK893tljjWZAwlKUnCrYP96yw9
	 tdCvUz7VLwlurXyJzw+KIs0egFglXrzSNzx0kh/EEbsxGdsgaGOlBy2RuN669kMPr7
	 FwHGA3/x22QpQ==
Date: Thu, 14 Nov 2024 19:38:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Cc: Ronak Doshi <ronak.doshi@broadcom.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andy King
 <acking@vmware.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Raphael Isemann <teemperor@gmail.com>
Subject: Re: [PATCH 0/2] vmxnet3: Fix inconsistent DMA accesses
Message-ID: <20241114193855.058f337f@kernel.org>
In-Reply-To: <20241113200001.3567479-1-bjohannesmeyer@gmail.com>
References: <20241113200001.3567479-1-bjohannesmeyer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 20:59:59 +0100 Brian Johannesmeyer wrote:
> We found hundreds of inconsistent DMA accesses in the VMXNET3 driver. This
> patch series aims to fix them. (For a nice summary of the rules around
> accessing streaming DMA --- which, if violated, result in inconsistent
> accesses --- see Figure 4a of this paper [0]).
> 
> The inconsistent accesses occur because the `adapter` object is mapped into
> streaming DMA. However, when it is mapped into streaming DMA, it is then
> "owned" by the device. Hence, any access to `adapter` thereafter, if not
> preceded by a CPU-synchronization operation (e.g.,
> `dma_sync_single_for_cpu()`), may cause unexpected hardware behaviors.
> 
> This patch series consists of two patches:
> - Patch 1 adds synchronization operations into `vmxnet3_probe_device()`, to
>   mitigate the inconsistent accesses when `adapter` is initialized.
> However, this unfortunately does not mitigate all inconsistent accesses to
> it, because `adapter` is accessed elsewhere in the driver without proper
> synchronization.
> - Patch 2 removes `adapter` from streaming DMA, which entirely mitigates
>   the inconsistent accesses to it. It is not clear to me why `adapter` was
> mapped into DMA in the first place (in [1]), because it seems that before
> [1], it was not mapped into DMA. (However, I am not very familiar with the
> VMXNET3 internals, so someone is welcome to correct me here). Alternatively
> --- if `adapter` should indeed remain mapped in DMA --- then
> synchronization operations should be added throughout the driver code (as
> Patch 1 begins to do).

I guess we need to hear from vmxnet3 maintainers to know whether DMA
mapping is necessary for this virt device. But committing patch 1 just
to completely revert it in patch 2 seems a little odd.

Also trivial note, please checkpatch with --strict --max-line-length=80
-- 
pw-bot: cr

