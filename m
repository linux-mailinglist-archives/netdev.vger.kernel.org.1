Return-Path: <netdev+bounces-114442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6929429CA
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 10:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A4531C216F5
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 08:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72391AAE2D;
	Wed, 31 Jul 2024 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgcv9F/j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8338E1AAE08;
	Wed, 31 Jul 2024 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722416266; cv=none; b=MCE/fWqmoX+7kR0dpxr01aEAWJJ4for3F8ryHgNyPw+mkfVC9nqcadqerspQlcyoiH/xBCB5D8wg+xc7BJ4cHmmUL6GvxnIcxQvSJ2rLWn1NDzOpYjtgAdPeXs8cPj6sIvWmO9fHCjNWurQ3FdqLPSQl3352FWJtVw8Nz/0m4Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722416266; c=relaxed/simple;
	bh=hopejYkFDlRXosQSrN9FNvd2qXYNt97CgMPgExHWjLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHLfRSG799wYTA1w7RzRq4ubcbDxl3X8xNrRmqS6L2dIsm/thJsaliPBKVkz6zKI/onlR/GfZH/IjaX7COzhchX6f0e7D4JwiDJHdm8zPXVHhElMvF+MEqrZsopUkBSb/gf3w6nPHW5lJlalFsqO+TVO+/g/0mc1ce+6HWift9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgcv9F/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC84C116B1;
	Wed, 31 Jul 2024 08:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722416266;
	bh=hopejYkFDlRXosQSrN9FNvd2qXYNt97CgMPgExHWjLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kgcv9F/j4hbv4sY33GK6d58MNdprg7Tk6x7Afte7Yvm+pO9ukFm6JSZHFhVrQctV8
	 HCJvnQ2SmAqj0sAQJBgaQF2tt0TOI5PcJu9v2fmRxV2XUWaFGKRqLMu52qnFc79kh9
	 OZIH/2SJJc8An60ZA3qB06AemJlpRn3qE0hIldQMIveR5FOpyQA8u8NtVxm3+jHQKb
	 ZIR6/5PDzOSoOQ9rfNdotTn6qFvjblvNuBAip+B091FmD2fG07ijLMGLRyGcJCwF7M
	 F0eioAeNeRBymaNwU7QnKVLzgg6Jy9Kkg6kC/bxm0G3R6V0OdCYTZd0D5ASDSWuS9d
	 gv5IYS+rqKdFw==
Date: Wed, 31 Jul 2024 09:57:39 +0100
From: Simon Horman <horms@kernel.org>
To: Liju-clr Chen <liju-clr.chen@mediatek.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Yingshiuan Pan <Yingshiuan.Pan@mediatek.com>,
	Ze-yu Wang <Ze-yu.Wang@mediatek.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Shawn Hsiao <shawn.hsiao@mediatek.com>,
	PeiLun Suei <PeiLun.Suei@mediatek.com>,
	Chi-shen Yeh <Chi-shen.Yeh@mediatek.com>,
	Kevenny Hsieh <Kevenny.Hsieh@mediatek.com>
Subject: Re: [PATCH v12 11/24] virt: geniezone: Add ioeventfd support
Message-ID: <20240731085739.GO1967603@kernel.org>
References: <20240730082436.9151-1-liju-clr.chen@mediatek.com>
 <20240730082436.9151-12-liju-clr.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730082436.9151-12-liju-clr.chen@mediatek.com>

On Tue, Jul 30, 2024 at 04:24:23PM +0800, Liju-clr Chen wrote:
> From: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
> 
> Ioeventfd leverages eventfd to provide asynchronous notification
> mechanism for VMM. VMM can register a mmio address and bind with an
> eventfd. Once a mmio trap occurs on this registered region, its
> corresponding eventfd will be notified.
> 
> Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
> Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
> Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>

...

> diff --git a/drivers/virt/geniezone/gzvm_ioeventfd.c b/drivers/virt/geniezone/gzvm_ioeventfd.c

...

> +/**
> + * ioeventfd_check_collision() - Check collison assumes gzvm->ioevent_lock held.

nit: collision

     Likewise elsewhere in this patch.

     Flagged by checkpatch.pl --codespell

> + * @gzvm: Pointer to gzvm.
> + * @p: Pointer to gzvm_ioevent.
> + *
> + * Return:
> + * * true			- collison found
> + * * false			- no collison
> + */

...

