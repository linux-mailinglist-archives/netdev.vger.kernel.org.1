Return-Path: <netdev+bounces-224552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F713B8608C
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 18:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 623DD581F59
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 16:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C34314A92;
	Thu, 18 Sep 2025 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnarWw3F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A43312814;
	Thu, 18 Sep 2025 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212881; cv=none; b=LgYAaaF01JeBEkcT8H8kN56GAZK0ji9Jj+1aHEc0w2tmapK38jxpaT2tX1UYyEGDes7+vBXIbLEQKM3EAepOLYTzpKLDx/Axy0qu1R6xT9Pqh9N6OUs2+EsUXkFGQESvVeuzoHI1vJKMXCxFJKkFI19hNhtkdRWBGFebja8TgrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212881; c=relaxed/simple;
	bh=yGD3rd0ZgCpKN5/ib9YlnwYypPwsbITgq4CSUhmw/FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrEuFjhlw4mI842CX1/H1HnUkIJjqEpQ5BAvH1Ucpg5gF7HOwJETFCu/15O+ZsiAXEyQTqKdjnkNUCCdfspXsYDMYKhp1sHhwKb3taKZYdUqBg5flaM4QRdE/TIafe0vz64gy+iRKa5JQzsviR/znjOr6SA7LEMMtu5wMKmx5WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnarWw3F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350C5C4CEE7;
	Thu, 18 Sep 2025 16:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758212881;
	bh=yGD3rd0ZgCpKN5/ib9YlnwYypPwsbITgq4CSUhmw/FQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QnarWw3FJUtrtOMP50yvc5UH8uSKNOmSqz96oPjewbjN4GGyf1nK0rJco3NxORKWA
	 ewrgOof32hIj+7IAMSc6GZr/1ZWAWTcwoRcllf1KW6VOc8NfoYRz60Lul0ZJG+Xv+0
	 QdBV4J4NTgPF/kM6/16lCvvH08fikSs5zC4QfozCk76r3XWKs+Ah0DE8qseg18A9ev
	 HJbLQNC5hcof4gBI1qwxKy25wR2ZOjeyXIu51Lgxvv2AHpJ++b8wbP0q6lpMyYyU7d
	 bXZs9QP7lJIhRCkucua/zIE+iD/ZrvZTSl3sEpdhH6iRmFc8YSeppuMypNSLjveZza
	 YyNNrS7pHs3OQ==
Date: Thu, 18 Sep 2025 17:27:56 +0100
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Roger Quadros <rogerq@ti.com>, MD Danish Anwar <danishanwar@ti.com>,
	Parvathi Pudi <parvathi@couthit.com>,
	Roger Quadros <rogerq@kernel.org>,
	Mohan Reddy Putluru <pmohan@couthit.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Basharath Hussain Khaja <basharath@couthit.com>,
	"Andrew F. Davis" <afd@ti.com>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] net: ti: icssm-prueth: unwind cleanly in probe()
Message-ID: <20250918162756.GA394836@horms.kernel.org>
References: <aMvVagz8aBRxMvFn@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMvVagz8aBRxMvFn@stanley.mountain>

On Thu, Sep 18, 2025 at 12:48:26PM +0300, Dan Carpenter wrote:
> This error handling triggers a Smatch warning:
> 
>     drivers/net/ethernet/ti/icssm/icssm_prueth.c:1574 icssm_prueth_probe()
>     warn: 'prueth->pru1' is an error pointer or valid
> 
> The warning is harmless because the pru_rproc_put() function has an
> IS_ERR_OR_NULL() check built in.  However, there is a small bug if
> syscon_regmap_lookup_by_phandle() fails.  In that case we should call
> of_node_put() on eth0_node and eth1_node.
> 
> It's a little bit easier to re-write this code to only free things which
> we know have been allocated successfully.
> 
> Fixes: 511f6c1ae093 ("net: ti: icssm-prueth: Adds ICSSM Ethernet driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks Dan.

I'm pretty sure I reviewed this code at some point.
Sorry for not noticing this problem then.

Reviewed-by: Simon Horman <horms@kernel.org>

...

