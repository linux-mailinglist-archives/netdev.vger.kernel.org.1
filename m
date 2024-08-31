Return-Path: <netdev+bounces-123991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B08967334
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 22:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 807B4B21409
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 20:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B8C14B949;
	Sat, 31 Aug 2024 20:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pakqoYzC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA26524F;
	Sat, 31 Aug 2024 20:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725134863; cv=none; b=ADWDZk0rxvvNF8x1nuRaWVdugk2OQ5vneoWgXdzuIEs0DBXvpRzrpmLAPdsld0Uvpnh/D1McT+XodXDgg8g4kElksFiwOZpjkaCspbfFikBb9cx6wC0OvcYkDdduLoaFTJKKHBh0ED5k20bGG03DQMfIdlQ4Gb4/vjQ5e2tYIXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725134863; c=relaxed/simple;
	bh=w61CWRjQ/tWD0Rt1f3CNPyjy/rWQFUKjrkO71Cn6AmY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WgTmqkuckLs5PuFENvBS3EfBCxOk1ln8vsJxM2iE7i+RnN1ATGUm/T4W+stwzk9Vg4QGGKYU2SRSjYOntX+HzMkCKjrqqv9Lg0Q3lTRhyJ3SBVLNsTamCi8lFxvDdtEBo6XPdYmk4E2Z0LTu4u2LwbAJvYvWmo8N+uzn68YrsTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pakqoYzC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AAEC4CEC0;
	Sat, 31 Aug 2024 20:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725134862;
	bh=w61CWRjQ/tWD0Rt1f3CNPyjy/rWQFUKjrkO71Cn6AmY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pakqoYzC/OtKkNr2O7L/3vh8yC0azLcXaxWgxKDV2jxU2BiiSYmADJMWMG6GxLs40
	 QpnkCVyVKb8ME7bmLFppJ8xoGwM7uxWF7cSxaCIaaIFsdDl3PNLO3w3wf9UtzI1tLv
	 ZJkqhSuJQkMjzLFC4vXXnVSOg3rCbUUzYzoa/jjTQpma2/73qfzrG7FruXNXvFKsuN
	 s35BLcJT1lOLpzzJ6wcD+3p2HWy1PRtTFGqu0SSr2EvBKwlvQ44FzvXEJWhMsodJFq
	 /HvTVsreWLW3zD3Rd82sIK+6+46i1l0AW2hcdiOo0secaRzc3cwe1dCnryceNoEZqo
	 VBebEdHY5IBjA==
Date: Sat, 31 Aug 2024 13:07:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: <kees@kernel.org>, <andy@kernel.org>, <willemdebruijn.kernel@gmail.com>,
 <jasowang@redhat.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <akpm@linux-foundation.org>,
 <linux-hardening@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-mm@kvack.org>
Subject: Re: [PATCH -next 2/4] tun: Make use of str_disabled_enabled helper
Message-ID: <20240831130741.768da6da@kernel.org>
In-Reply-To: <20240831095840.4173362-3-lihongbo22@huawei.com>
References: <20240831095840.4173362-1-lihongbo22@huawei.com>
	<20240831095840.4173362-3-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 31 Aug 2024 17:58:38 +0800 Hongbo Li wrote:
> Use str_disabled_enabled() helper instead of open
> coding the same.

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 6fe5e8f7017c..29647704bda8 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -3178,7 +3178,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>  
>  		/* [unimplemented] */
>  		netif_info(tun, drv, tun->dev, "ignored: set checksum %s\n",
> -			   arg ? "disabled" : "enabled");
> +			   str_disabled_enabled(arg));

You don't explain the 'why'. How is this an improvement?
nack on this and 2 similar networking changes you sent

