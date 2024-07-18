Return-Path: <netdev+bounces-112113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3842C93519E
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 20:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 662BB1C21DE5
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 18:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752AD53E22;
	Thu, 18 Jul 2024 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c9CX+aWK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0B84D8AF
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 18:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721327581; cv=none; b=OOpyt4C5jJlEGsiX8fdkwqazT4zN7TIvFx6l4uTLKRH9bhNnrWcIgFutGPtdpl/kHMMmxOXx/5iuIyNYVwqNsXtQdF0Q6jSo4DfXW6y0bzdGMlD2QisdtygQyJyJl6PgSX6pTx0fOt1l/SYAkhgqwYxcuQiLHVKnm9SXbDL6U5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721327581; c=relaxed/simple;
	bh=KSq0CvK4W4WOq5vKLLANNho8gvq698Kp24TwARV+3AE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=d1ezBo59jhfarHyFE4qTNXaPElJf4PMrTrM8JNRht24kNQutVb3DXuyxdkugDBxHWy1wkgkLP0p27ZtZavnvrZ/WmiFl+gUyestV3XmnnrxG0JjhEb3mfB8T6lvpe0f+kwzbJrm+mGJ62gUUn1M/hA3MJvzT6iwL9ZRhHjmtq9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c9CX+aWK; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d9e13ef8edso706330b6e.2
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 11:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721327579; x=1721932379; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JZoF3PGllS+ykKe0k+A8Fb6SI5VjVBwQNrkvYDcCXSQ=;
        b=c9CX+aWKqd1faqcrQCEDOMA71q9s0PW8Fi5sLYra+/bhFl+xplKMwqNNFdUUvHnRQn
         4npkmKqSkGArPNLD6mz6jTfSBs/0rkujmlCPvsUrGWWCa5kKR6YwesKOtIUhYQnCzV+Q
         ILZ1FZkFOb2KYOPUy1kKsehkcP0mcyNruNQVxoY7ViiLQfn8WltXbfJxwsv4Y/gc7H54
         R/U4wNeIlbLqv+bVjhq/IgCRb/8mS6NDcM/fwIQeKWEy2Ikk2fLTwA9pgwfpUf+SzCL4
         m9Ed4bI1QZ6jlgKTOiknHNMeCPQjw6Syd8yW66Mq74vgI8cp+sYW5e75hw3qN/E8FUD8
         k4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721327579; x=1721932379;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JZoF3PGllS+ykKe0k+A8Fb6SI5VjVBwQNrkvYDcCXSQ=;
        b=Ba9EPO10UeSZZC7iaeNaJQY9Xy+cV2hs9yW3LQBjCYDURiKbxA/t+aUvqj2X4iSOeI
         gbi77drY9qCKDc6AiNHHzHz2Us4+CGUSiBCGgS1HjFjVoaKgr8FmsKBj/Xt2QRWRtina
         +Zi74Gc4sXcMj32x2apSZMzp9bw83wZ3BnWIKLFTvYy/XWXBCDePtBd/BUrb3w30xg5h
         TyY6+z8Mh41v6Q9SelQyTw5U3JvK3XkQaCniLdl/wg4ovlGxtXHHLyVGiomvFGCLEf3F
         UZzrjL/os1NgyhlJpLGv2CWqYkj+sJVEPIX14kxw8I6mdS7umcToyV3LuUNbhN31ekbk
         Uvng==
X-Forwarded-Encrypted: i=1; AJvYcCW3IvI24VkJ6NXiHV6oZVFx5urkw6W7vMydzTVG7y0k5tkmK34TCBFb80wCP3qbKwSlbVbEIaoiy8ZUN8JB9IQ1rAsOxvXK
X-Gm-Message-State: AOJu0Yz9QZwcu5rlwXe5TwX8OL+pYt5+PJ950wliQ9LIYRsVkqaaKgSW
	yQKgDBR2gDJfF+foUxQtioKGVx+TaHcA7gK9F5Ca2Z0bS/KrbSMKwhbVwBPRt+8=
X-Google-Smtp-Source: AGHT+IEFyVDue4003XGqdQn9OI/JuHlnkRU4Kud0hIHuOq6RiiYeXuyi970NX/bzpTixUC9Cjj2hoQ==
X-Received: by 2002:a05:6808:23ca:b0:3d9:dc70:10f7 with SMTP id 5614622812f47-3dad1f88752mr7226128b6e.42.1721327579036;
        Thu, 18 Jul 2024 11:32:59 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:8d5a:14eb:55d7:f0ba])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dad5297cb7sm503186b6e.37.2024.07.18.11.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 11:32:58 -0700 (PDT)
Date: Thu, 18 Jul 2024 13:32:56 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] net: airoha: Fix forever loops in error handling
Message-ID: <693c433a-cf72-4938-a1aa-58af2ff89479@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

These loops have ++ where -- was intended.  It would end up looping until
the system died.

Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 7967a92803c2..698835dc6da0 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -977,7 +977,7 @@ static int airoha_set_gdm_ports(struct airoha_eth *eth, bool enable)
 	return 0;
 
 error:
-	for (i--; i >= 0; i++)
+	while (--i >= 0)
 		airoha_set_gdm_port(eth, port_list[i], false);
 
 	return err;
@@ -2431,7 +2431,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 
 error_unmap:
-	for (i--; i >= 0; i++)
+	while (--i >= 0)
 		dma_unmap_single(dev->dev.parent, q->entry[i].dma_addr,
 				 q->entry[i].dma_len, DMA_TO_DEVICE);
 
-- 
2.43.0


