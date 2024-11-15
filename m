Return-Path: <netdev+bounces-145172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E549CD608
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 04:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C166282D47
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 03:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F3A156F3C;
	Fri, 15 Nov 2024 03:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMAo2XOQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211CF42ABD
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 03:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731643027; cv=none; b=rTfwdvqmVQSS2+PaU00CBayZ3OZ4iyQbItCjJ++NTptyquBX4db+xSj1+DWyrwAxA6E5Ei1TfEhJr6398xOEqT3hJMgDfLa9vYDi25AP3wmLav7SDHSW9Eb18KuKGYkgiKXZLsnHvvu0kX208cFDWSTIvWKdz0TBwCacOi+hfX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731643027; c=relaxed/simple;
	bh=Pr2GqMqQ7tO5s2YN/pEEpRUWI2nFDuuFsweUPN8Ayfs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yu+Ce0rfr5E13wsGpW9F1lREZuz+wo+W8WoDovFgzZRcu86bWyLFpuvsk1bY8CWzqVkTvcED4OYt6voyXY8dXZCrhBB6Mwl6K7OQ+7ABnULadDhudP4Rg0ac4Lz272xuw/FJybVKS4TJI48ZPCmqPJ9w7vmp7mGkcoWQBgk8bcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMAo2XOQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D67C4CECF;
	Fri, 15 Nov 2024 03:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731643026;
	bh=Pr2GqMqQ7tO5s2YN/pEEpRUWI2nFDuuFsweUPN8Ayfs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hMAo2XOQtPTvfJyfF+evyNZs3aF7m1cKKn5fDNl/Io+lPseUVHZAx1MJpu1kcL387
	 ibUdvh/UNvidquz5WyvuFd6DzAqCjQYiu/0ShUy+vEhN1g/PuIVsarjAFVK6URjXfn
	 iVW8z3nnMTeA8gAM3m6LEbPypK98TrtwNR+UQafC9qHiLZ3LVyAJXs6OgGkOc30Q6o
	 GIKmU7UJpFGTFdjfgo5gUGjmJyE98ZarNNiZbymDRESMYo8bMSUlVyH8wBAXevtgXT
	 0WYnMs7PWcJ7VICWAMEJlwaCWUaWks+hQ2VCNiGoxC4TEGdnsKWT8dS4uFHQnSZpxd
	 yrG+g0Fl5ye4Q==
Date: Thu, 14 Nov 2024 19:57:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, andrew.gospodarek@broadcom.com,
 hongguang.gao@broadcom.com, shruti.parab@broadcom.com, Sreekanth Reddy
 <sreekanth.reddy@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: Re: [PATCH net-next 08/11] bnxt_en: Add functions to copy host
 context memory
Message-ID: <20241114195705.635ab748@kernel.org>
In-Reply-To: <20241113053649.405407-9-michael.chan@broadcom.com>
References: <20241113053649.405407-1-michael.chan@broadcom.com>
	<20241113053649.405407-9-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Nov 2024 21:36:46 -0800 Michael Chan wrote:
> Host context memory is used by the newer chips to store context
> information for various L2 and RoCE states and FW logs.  This
> information will be useful for debugging.  This patch adds the
> functions to copy all pages of a context memory type to a contiguous
> buffer.  The next patches will include the context memory dump
> during ethtool -w coredump.
> 
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
> Signed-off-by: Shruti Parab <shruti.parab@broadcom.com>
> Signed-off-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com

Truncated signoff tag.

nit: I don't know who Shruti is but my guess is that she co-authored 
the code, in which case a Co-developed tag would be appropriated.

> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

> +/**
> + * __bnxt_copy_ctx_mem - copy host context memory
> + * @bp: The driver context
> + * @ctxm: The pointer to the context memory type
> + * @buf: The destination buffer
> + * @offset: The buffer offset to copy the data to
> + * @head: The head offset of context memory to copy from
> + * @tail: The tail offset (last byte + 1) of context memory to end the copy
> + *
> + * This function is called for debugging purposes to dump the host context
> + * used by the chip.
> + */

return values must now be documented, per ./scripts/kernel-doc -Wall
-- 
pw-bot: cr

