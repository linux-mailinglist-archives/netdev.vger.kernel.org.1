Return-Path: <netdev+bounces-246787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 619F0CF12C6
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 18:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 018C030019CC
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 17:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2442B2D3727;
	Sun,  4 Jan 2026 17:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNlmOwGt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BF22D24B7
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 17:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767549470; cv=none; b=rJ+4x0gpVJB/zeeiPmWoGUnyMH6lKnU53TxdwspQcQfD4ZGpeA2WEV4GPPNTpNlwlFsLAqI7wz3SWCor+Vob+9ZnJyT+phw02b7qpZYesMllhpdHHanmtHmKrYVTZ4tJZjV1RKWMxZl3QOj2X3yjZJ+YIFAAX+oxcgVGuirYr48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767549470; c=relaxed/simple;
	bh=GogI6KoWMG7sQcRQST4tSXHnHsU61K4n/uzTVM7dT2U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SO5Es3lSc4mrnLkZPI3ptWBOhipKHXsF6qWCtElDNVrjUg3BpHnjLhoyTPz7R7sMnpFCU/N5snKHnMoYYTi6F5ZP3p5HEgX+9PbOd97/iiUVLKDwOaCG5Pr+yuUK9BEVNV2QcsJY/0dWwPV1aqOIPRw4L2rGFxdQuQFKtXgyVp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNlmOwGt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85112C4CEF7;
	Sun,  4 Jan 2026 17:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767549469;
	bh=GogI6KoWMG7sQcRQST4tSXHnHsU61K4n/uzTVM7dT2U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eNlmOwGt/ErVXDeQvrb5x/qUdjhqLGFlCC5iP6wYoNNvUFVP7cv000yCvfbY9Xm+3
	 t0bz76FZmYWEyQMjc56C/y8XInKLqwSmjpGLbondvk0JTc5JxPQgyTX8tLj4dIng8/
	 ExnUx4fTaZhZNsOUunMIUh7D9KDaKIEjIB8ETkd7VcEuBSysYTkyEvkvIlix/9SbFw
	 k121A6v0zYiVfiXUrRFD73zwSDF6lacJKsWuHqsCQI1b8yuw+snggzPOjY4rU++Qnf
	 WWkxV1i/NQdTfXrtbab97ljbHLNU1R0vyrBFrPidwil+oZDy6+pLf2SpYuX7Vp9nqt
	 2+uBB0ndeE5dg==
Date: Sun, 4 Jan 2026 09:57:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: Fix schedule while atomic in
 airoha_ppe_deinit()
Message-ID: <20260104095748.70107b9b@kernel.org>
In-Reply-To: <20251223-airoha-fw-ethtool-v1-1-1dbd1568c585@kernel.org>
References: <20251223-airoha-fw-ethtool-v1-1-1dbd1568c585@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Dec 2025 22:56:44 +0100 Lorenzo Bianconi wrote:
> Rely on rcu_replace_pointer in airoha_ppe_deinit routine in order to fix
> schedule while atomic issue.

The information in the commit message is not sufficient.
What "schedule while atomic issue"?

> -	npu = rcu_dereference(eth->npu);
> +	mutex_lock(&flow_offload_mutex);
> +
> +	npu = rcu_replace_pointer(eth->npu, NULL,
> +				  lockdep_is_held(&flow_offload_mutex));
>  	if (npu) {
>  		npu->ops.ppe_deinit(npu);
>  		airoha_npu_put(npu);
-- 
pw-bot: cr

