Return-Path: <netdev+bounces-82459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF32F88E101
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 13:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8D2DB25D79
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 12:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA05152E10;
	Wed, 27 Mar 2024 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYfnWiDT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA28B152E0D
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541700; cv=none; b=M9usZ/1LYKExQkMvcFwy0VxsgICngIP+s45C8SQeecPAIUII2WjD1t74SPnrAVYlBeAy96ycch4pnQqHwJMpvbDoHtIAW+qMxg6VvhfSZS4hPcxN3pQbUE5md7AT4SBfE/C/n2sa4JihSxQwYyEiK0rnL/fvmyUlpXDBo7d+Dzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541700; c=relaxed/simple;
	bh=TGBhXpvpwt3Sy3sv2afWOztmZwM+ykD/J2PKpMOqi3Y=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=ChLwK8K0j+JsavhSXJS8h1h9W+C9PIBLONO8QEZfdO8UC0LcUgavdYWnB24vryAfEaODJSYrvtqmCFIeuToATu6hS4sY5YG6tJXLEQM4n35NOMEFxhyPRiRoGIp+lp7MbMQgqyj/k2q/rkuI0DFk/aG8fU7qyGabFLm1ePRZKG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYfnWiDT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A77AC433F1;
	Wed, 27 Mar 2024 12:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541700;
	bh=TGBhXpvpwt3Sy3sv2afWOztmZwM+ykD/J2PKpMOqi3Y=;
	h=Subject:From:To:Cc:Date:From;
	b=PYfnWiDT6yaDffCHSBNbxd/CZkoZKj1v7nQKhcq6vzD0VwH0OXGv5VfOGgyBD8v90
	 qPS/mJPXlpPhOIP/niHhiwqrUUuy7iFAF5tDaoxYXOqlQAxob4/po+74o3HWUt8Y6q
	 rpZKtfaNZhR4jePfk7Z36DZq7ruT8yciszVfOSFQhudT+jKvdiIIMSBfGKWcx36tys
	 F4UQDnywU4BH0/TJqSXPpVoq+rnv68d7dUgRKXCngCUEWtKswYL9GWa96/O/mRhovJ
	 zLRenmEYeFHF+yPH1saJv1oWQ75ayKDq0vRsuPhfJKf4SaPo/YiVPGXhED/aVDoEYw
	 AfISea9uz1zRg==
Subject: [PATCH net] xen-netfront: Add missing skb_mark_for_recycle
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, arthurborsboom@gmail.com,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, wei.liu@kernel.org,
 paul@xen.org, Jakub Kicinski <kuba@kernel.org>, kirjanov@gmail.com,
 dkirjanov@suse.de, kernel-team@cloudflare.com, security@xenproject.org,
 andrew.cooper3@citrix.com, xen-devel@lists.xenproject.org
Date: Wed, 27 Mar 2024 13:14:56 +0100
Message-ID: <171154167446.2671062.9127105384591237363.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Notice that skb_mark_for_recycle() is introduced later than fixes tag in
6a5bcd84e886 ("page_pool: Allow drivers to hint on SKB recycling").

It is believed that fixes tag were missing a call to page_pool_release_page()
between v5.9 to v5.14, after which is should have used skb_mark_for_recycle().
Since v6.6 the call page_pool_release_page() were removed (in 535b9c61bdef
("net: page_pool: hide page_pool_release_page()") and remaining callers
converted (in commit 6bfef2ec0172 ("Merge branch
'net-page_pool-remove-page_pool_release_page'")).

This leak became visible in v6.8 via commit dba1b8a7ab68 ("mm/page_pool: catch
page_pool memory leaks").

Fixes: 6c5aa6fc4def ("xen networking: add basic XDP support for xen-netfront")
Reported-by: Arthur Borsboom <arthurborsboom@gmail.com>
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
Compile tested only, can someone please test this

 drivers/net/xen-netfront.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index ad29f370034e..8d2aee88526c 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -285,6 +285,7 @@ static struct sk_buff *xennet_alloc_one_rx_buffer(struct netfront_queue *queue)
 		return NULL;
 	}
 	skb_add_rx_frag(skb, 0, page, 0, 0, PAGE_SIZE);
+	skb_mark_for_recycle(skb);
 
 	/* Align ip header to a 16 bytes boundary */
 	skb_reserve(skb, NET_IP_ALIGN);



