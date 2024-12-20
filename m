Return-Path: <netdev+bounces-153577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9BC9F8AAA
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 04:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB2651889623
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 03:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986AD4CB5B;
	Fri, 20 Dec 2024 03:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMNOTu2v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7348F26ADD
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 03:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734666159; cv=none; b=pFVUGqh8/rkPppGC8XDgYQnCB9IA0uNGqD6TQ56yHBXhcGlSIY7MM/AUeCWLhHMRwK/Y5IFh6OJYTww0k/5p53BDyCQXOmU0I/H3YOawDBYrwKQ8xdGFUDMb24U+V2xt2qrg9HDF6APnzRJedLdp535IHPFO/IXM9L4QjjMmjdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734666159; c=relaxed/simple;
	bh=fnImh29yoKImg9f1jUzjkpruOXk0v2PvXOnZJPACOFc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZsJe+Bm0sZNKL+8+aPdPgxSlrVMsmdXTKJ9LhE4BfdxLtTH4sBkDxJ0ZLPUF+hKF8uMq5cKeJkEHk6YmhojOFPKRaz0e1Bans+UbmowBdZ4BVphaDLg9AghIRh5uOtFyPRdBV/PJ8LYBGs9dhVvZ5TyOWr4dOOkdX8vssXG1j04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMNOTu2v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC31C4CECD;
	Fri, 20 Dec 2024 03:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734666159;
	bh=fnImh29yoKImg9f1jUzjkpruOXk0v2PvXOnZJPACOFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JMNOTu2v8Xg3DzOhrHjiZuyQbDFlSCSy1rhNXN02tOCsEYU8vdb37WbOSX4UNR0H1
	 wtqvdCvJXmOicL5T8F1SNZh0THSic2U0JeHbWR58kqSdgnUHY/Z+0dSLnYaS1EC4+S
	 Vy6mTVs7w8Ht1LLHeA48N3Fn9YaKJB6vZBIF2qHRwTjIM2faRA3FwSUeQm8S9Yh5CS
	 Lj/LHORn4r9yWja+4CyqJpixEJ1A7xC/rUT+ISZCC6uAuZMticlgsRNQdKzSUW2Rne
	 0WrYzHBQCOR5z2kBHVqW9gm+9ZYtmuRlujfVUqKtL8H1KsRGvgK+L6rKbYFFIoeVd1
	 Ia/o+ppIuC5uw==
Date: Thu, 19 Dec 2024 19:42:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 davem@davemloft.net, michael.chan@broadcom.com, tariqt@nvidia.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 jdamato@fastly.com, shayd@nvidia.com, akpm@linux-foundation.org
Subject: Re: [PATCH net-next v2 4/8] net: napi: add CPU affinity to
 napi->config
Message-ID: <20241219194237.31822cba@kernel.org>
In-Reply-To: <20241218165843.744647-5-ahmed.zaki@intel.com>
References: <20241218165843.744647-1-ahmed.zaki@intel.com>
	<20241218165843.744647-5-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 09:58:39 -0700 Ahmed Zaki wrote:
> +	if (!glue_created && flags & NAPIF_IRQ_AFFINITY) {
> +		glue = kzalloc(sizeof(*glue), GFP_KERNEL);
> +		if (!glue)
> +			return;
> +		glue->notify.notify = netif_irq_cpu_rmap_notify;
> +		glue->notify.release = netif_napi_affinity_release;
> +		glue->data = napi;
> +		glue->rmap = NULL;
> +		napi->irq_flags |= NAPIF_IRQ_NORMAP;

Why allocate the glue? is it not possible to add the fields:

	struct irq_affinity_notify notify;
	u16 index;

to struct napi_struct ?

