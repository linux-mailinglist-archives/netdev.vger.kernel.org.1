Return-Path: <netdev+bounces-252261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AG79NAv4cWmvZwAAu9opvQ
	(envelope-from <netdev+bounces-252261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 11:12:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FF465118
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 11:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 880544FE44C
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 10:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157AD34E776;
	Thu, 22 Jan 2026 10:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="LHUsRVmv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BED3101C2;
	Thu, 22 Jan 2026 10:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076358; cv=none; b=cAas8f7tUJ0HS6LLE7YL0lj2t6tZ8BmZUqXNAuaEBh25i+fdG8GiVUs5fXzFn8Yl4U95tqMCr3SrH1Tj0V9z4qFAhJDSV3K0sxoUyeP/U5eD0pZeK5o8H2IR3rZpTevmTX6PEVHEYgavFGG3ouv88SFSGM6QJbFoUg8mqdoIkXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076358; c=relaxed/simple;
	bh=cGp+zXvCyabGEJ5o8bfPn8TJ5ek4Bqj68EqSYi4LCr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DLTxf32auOOPgGedTvT+3JUaTUqOo/xCJTMrX0UpWPBq/xuvjWbanDmuG7DMuQBwITH2uEkSAHRbF8+Uf4l/ZicKAY8ayeUsc5V2B0ICr7e0WcFZhiDfgXPWPyu/jBWCPdTqxdKEkcjEx80qtdOVkiV3ZIX4PuZ3aUNWY/xwmAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=LHUsRVmv; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 31967edbb;
	Thu, 22 Jan 2026 18:05:30 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: pavan.chebbi@broadcom.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	jianhao.xu@seu.edu.cn,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	zilin@seu.edu.cn
Subject: Re: [PATCH net] bnxt_en: Fix memory leak in bnxt_alloc_mem()
Date: Thu, 22 Jan 2026 10:05:27 +0000
Message-Id: <20260122100527.527027-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CALs4sv3STBARmMOZiBSXHtFkXd3E_hJwjWJ0x8zJ1_cYYw=ioA@mail.gmail.com>
References: <CALs4sv3STBARmMOZiBSXHtFkXd3E_hJwjWJ0x8zJ1_cYYw=ioA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9be52a8f9503a1kunmdf65d6e6371cf
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCT0MeVh5CGR9DSUJJGB8eSFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVU
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=LHUsRVmv1s1wZP+Lh6IzvzouxiSnYBrjlCklRW3eYtRlcNTvXHNfx169ZVEj42XV5v5LNNbikh0nnEf35SmrUJlHYxc0wY1FJYc4Qnx3qHRdrjnhPNE2XnVL2yqfGijZDvQ3It0mptBvzHVlhfDNr8pr3g3t5YfVZgSZ4/atL3Q=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=bQqpcQaH3kR/GUt1iQi9xbGhZRZgFhliy7b89Do21Uw=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[seu.edu.cn,none];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-252261-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zilin@seu.edu.cn,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 94FF465118
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 03:14:08PM +0530, Pavan Chebbi wrote:
> On Thu, Jan 22, 2026 at 2:56 PM Zilin Guan <zilin@seu.edu.cn> wrote:
> >
> > In bnxt_alloc_mem(), the function allocates memory for bp->bnapi,
> > bp->rx_ring, bp->tx_ring, and bp->tx_ring_map.
> >
> > However, if the allocation for rx_ring, tx_ring, or tx_ring_map fails, the
> > function currently returns -ENOMEM directly without freeing the previously
> > allocated memory. This leads to a memory leak.
> >
> > Fix this by jumping to the alloc_mem_err label when allocation fails,
> > which ensures that bnxt_free_mem() is called to properly release all
> > allocated resources.
> 
> This fix is not needed. The memory is freed by the caller of bnxt_alloc_mem().

Hi Pavan,

Thank you for your review and clarification.

I observed that most allocation failure paths in bnxt_alloc_mem() jump to 
alloc_mem_err for error handling, which led me to incorrectly assume that 
this function was strictly responsible for cleaning up its own allocated 
memory upon failure. I failed to realize that the caller also handles the
cleanup for these specific cases.

Thanks for pointing this out. Sorry for the noise.

Best regards,
Zilin Guan

