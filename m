Return-Path: <netdev+bounces-227380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A20BAE305
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 19:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4670916E06F
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 17:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115C31F5434;
	Tue, 30 Sep 2025 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJjW2OaF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CD2381BA
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759253422; cv=none; b=dId8hvj1tcSr6oH28wVSo/D9M3BcRkanPpfBkpzEZqfBXF2bHKW+ggAADFK4wGnXDcQZeK2LUEmiu1AieOXZyBxmMuLJmD8JRO9ymvfhlpiQU9+S5lUhfqzMxM+HHSTsyvlrt6iX3hfrgZe8+t4C2CKxh6A3HgIZu8vZqDX8lXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759253422; c=relaxed/simple;
	bh=UEiITu5ojLhKvcyc75YZjFh80OX1gQbnlUYXdE4rxdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JsaDbTirv/zskx70sjZHAn3jF3I7Wxjuxiyv+vRyUyUNC17ry9X/ToRnLezJmG3UZbYEYPLtedAUY6J+krItILus0MJZlMWbDvD9EY1rBFoX1JaO0hS39nQXI/ddH7S8nB5yDN4/hn84eV9SG+i68bKTPInA+0cN/fzwRUcFKkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJjW2OaF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F1DC4CEF0;
	Tue, 30 Sep 2025 17:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759253420;
	bh=UEiITu5ojLhKvcyc75YZjFh80OX1gQbnlUYXdE4rxdQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MJjW2OaFsgHweaZH+7LdqLvBJhyH6Nsl909V1vIQQry15tICZ5eJqYu6dRfsbrZYD
	 FeOErlISC8NYM+k2Z0tn+wNalshAjOXFsRH+uv4ylsHy/I5E60ayMFx2eyEdJUnuiZ
	 ENTHcGf37V1dLTyHu4oCk2JySO7uWg/UgO1XdyPr/ElRK9trHaFDuWEfufRx5qyI+w
	 9aGW3w36subQgzDOQEW8h1LcW0MS4RvXmtXF0o+3/lSrq5452rkg8LoE/pGZpuZSUC
	 FcxxT08lD6GVHtO7LB+sxp23xghohBGAY6eDnu0wyUFQRUTgj1lThcoOdnMHAILnuv
	 KTncqGxgLRd6w==
Date: Tue, 30 Sep 2025 10:30:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: horms@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH] usbnet: Fix using smp_processor_id() in preemptible
 code warnings
Message-ID: <20250930103018.74d5f85b@kernel.org>
In-Reply-To: <20250930084636.5835-1-qiang.zhang@linux.dev>
References: <20250930084636.5835-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Sep 2025 16:46:36 +0800 Zqiang wrote:
> The usbnet_skb_return() can be invoked in preemptible task-context,
> this commit therefore use get_cpu_ptr/put_cpu_ptr() instead of
> this_cpu_ptr() to get stats64 pointer.

We also call netif_rx() which historically wanted to be in bh context.
I think that disabling bh in usbnet_resume_rx() may be a better idea.
-- 
pw-bot: cr

