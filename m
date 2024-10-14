Return-Path: <netdev+bounces-135084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5455999C27F
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 10:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8D17B22732
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 08:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B041494BB;
	Mon, 14 Oct 2024 08:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="nOZ1ZQvu"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B602B9474;
	Mon, 14 Oct 2024 08:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728893128; cv=none; b=MxW0hWrDnLkeKj4D6N9uX8BhwGL7VwWjTBQtPKN2OjzfEaCkuSX8ithTsQ7/SisEPCc9tamN+y0ceIT9YIXuZRFgPkH4UCS1f40skS2nmphKZLCLbXSGp8l/W0Uu8JEsWfOCo2KSMG//9i2/+UvotSw2rj7PsRPf50bDsqKV7j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728893128; c=relaxed/simple;
	bh=ghHR9xYtPEMyE+B+UBYLByre8yHdDV2nLf9d1R1aI88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S8KbYQhgERubPw25E0BMCvnyUTd6o3kEo+QyJcuozJE8+1/4LZPpuKAOYU0EUTjDT15vraJQnhVOfb+F3HzrFcLPlxgDVSIw9Q2TpIlwhldJmij2xb+e8Pk65VqWTDTnQaMoBg0lBCNwyvnQFePO5rPZHuYN/11uLLsqjoF2IuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=nOZ1ZQvu; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1728893124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zyaTDsN1XoKhBPqzkBTu2vo53snDIfUEQ3rGqDhYYKY=;
	b=nOZ1ZQvuRBsUvKB9OayMwB2dpSItOfv3z27X2LC5efvLcjRZLYHH+7cT2fYvb/gJ7DXTus
	1PQ1Hzcf6NZi6iMKvnq5+CawKmcTto0lb7Q3yuhkOd6k0PxMm+A/aByKGouR8txBbDt8Xr
	ERg9gfPmpg6IIgpWiaZEdt7L5hqIMxE=
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <mareklindner@neomailbox.ch>,
	Julia Lawall <Julia.Lawall@inria.fr>
Cc: Sven Eckelmann <sven@narfation.org>,
	kernel-janitors@vger.kernel.org,
	vbabka@suse.cz,
	paulmck@kernel.org,
	Antonio Quartulli <a@unstable.cc>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/17] batman-adv: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
Date: Mon, 14 Oct 2024 10:03:41 +0200
Message-Id: <172889278843.62571.16579786403204721631.b4-ty@narfation.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241013201704.49576-7-Julia.Lawall@inria.fr>
References: <20241013201704.49576-1-Julia.Lawall@inria.fr> <20241013201704.49576-7-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 13 Oct 2024 22:16:53 +0200, Julia Lawall wrote:
> Since SLOB was removed and since
> commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
> it is not necessary to use call_rcu when the callback only performs
> kmem_cache_free. Use kfree_rcu() directly.
> 
> The changes were made using Coccinelle.
> 
> [...]

Applied, thanks!

[06/17] batman-adv: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
        commit: 356c81b6c494a359ed6e25087931acc78c518fb9

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

