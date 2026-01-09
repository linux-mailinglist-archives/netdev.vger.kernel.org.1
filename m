Return-Path: <netdev+bounces-248309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2AED06C69
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 02:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22B0930399B9
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 01:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C4F23A99F;
	Fri,  9 Jan 2026 01:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4NxBbCe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FA11B4223;
	Fri,  9 Jan 2026 01:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767923639; cv=none; b=OIMj0nKZBB6+8fgwSCaPc7n6W/i5rMc67v0g30LM/jMQfq48ZvmwCEaabp2UDhuvat/NCQPNK/ptrYJzLJ2v1KQP7YrU/2D1NlPj5drxmwrUWrde1ujc8JTS3tFYfShwvIE6/8vTRVZBxl1LyG8DIhl4CU35IgUfPjhBTvW3+MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767923639; c=relaxed/simple;
	bh=9js/tucdgd1QhyQtfDMt6pyRupJeeRIaYQbve9E1rK4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dob1F1alP77DyctiR3HhryPj1HkojE72IWQc57gwOVnkNgRBzW/TFDd9Xo0GOYS6JZ7gRUx3Wr6lOb4nH1ual+Er01rBgx+3CX1j1WdxDCM1+s4KsuIQTcRzgXDyGmlPlPGITIvtEPU9JeM8r1fmYQziOsQmJEHzqlNRFBZwNdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4NxBbCe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D9CC116C6;
	Fri,  9 Jan 2026 01:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767923638;
	bh=9js/tucdgd1QhyQtfDMt6pyRupJeeRIaYQbve9E1rK4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B4NxBbCeGivUGwuqv5urifCLCWsgGmlkdHuCuTb5xbFr6xI4/dsAh49VAo38wPx61
	 nhcD+KYCaob3IpQNSHyuvCmax7J26Ym6IgF/wZZ0H8NY8JG/ykSsgU7vUmlfsXNJuM
	 Q5+NL0F5mCG/dnE4SmHUhVvAfVFhKpsju/vJvuS9GxWdOh+XZhDGSqDkJWnrrwnclb
	 TXpaeT/eP18AvcUHeQfF3kg8/i1hErpqC088Gg1KKhTi2leyKf96mlr1CTJdBciNkr
	 d88Ld4k5HNM+du2M5u8v1MNL1+TxqMPaXGkb01+F+CW1Hv4V1iZPJIu36MFxl9shVs
	 8En2SunPPKufQ==
Date: Thu, 8 Jan 2026 17:53:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tuo Li <islituo@gmail.com>
Cc: ayush.sawal@chelsio.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, kernelxing@tencent.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] chcr_ktls: add a defensive NULL check to prevent a
 possible null-pointer dereference in chcr_ktls_dev_del()
Message-ID: <20260108175357.52ad56c1@kernel.org>
In-Reply-To: <20260106123302.166220-1-islituo@gmail.com>
References: <20260106123302.166220-1-islituo@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Jan 2026 20:33:02 +0800 Tuo Li wrote:
> In this function, u_ctx is guarded by an if statement, which indicates that
> it may be NULL:
> 
>   u_ctx = tx_info->adap->uld[CXGB4_ULD_KTLS].handle;
>   if (u_ctx && u_ctx->detach)
>     return;
> 
> Consequently, a potential null-pointer dereference may occur when
> tx_info->tid != -1, as shown below:
> 
>   if (tx_info->tid != -1) {
>     ...
>     xa_erase(&u_ctx->tid_list, tx_info->tid);
>   }
> 
> Therefore, add a defensive NULL check to prevent this issue.

There seems to be no locking here.
It'd take much more to make this code safe, sprinking random ifs
here and there seem like a waste of time.
-- 
pw-bot: reject

