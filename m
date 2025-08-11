Return-Path: <netdev+bounces-212535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88949B21213
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 18:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65FB3188F2F9
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 16:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08CF214A97;
	Mon, 11 Aug 2025 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzNFb56K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CC81A9FA0
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754929714; cv=none; b=WhWhB7ItlVGE7YueN9hjoi1poXc9tWQpk66ywSXiHoFlKRq7tcZRCFwKxRFuTBVEFFqr4EVDaTY6JYdbeQPVKwOY+JYoKjHjW0r4cFAM/CBTgTNgy0/ilN63l8lqaPtK9PSyE13kwxxCxEF66FdYD/QHHl57gM8G4a77UJtp4MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754929714; c=relaxed/simple;
	bh=qGTYuWbixvnYQoKDwTnqfX7+SNb8tsIwO55KVEEJsH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hmS5tTuLLYHA4cF0DvEnNCEyd1M1b0jnZy/frfu+LdV4MLJfmzsIUm3gQNuMVhvy6t8xw8BlZud6Uidvj2u9Tajeku3JlFzeHkeHKPASaBVobFgtZUp8/ahakgyI/0wHSJuOLmvWa9TCH57Jxg8Uijb9orWUABgdWci/wfljQ9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzNFb56K; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a0feae86aso2736445e9.3
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 09:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754929711; x=1755534511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3aIbfUE0BOLMSKn/ZeEXXT1HW2OK0nZcUJVLAItwPk=;
        b=PzNFb56K7oSVQ+a+r9Ftm1DVBRdcgfKIT4WpP79uUt/iJJVntZqmlnY7ATeeGKPkyd
         1hbQ1U0Eops1f2XZMmZev5EU5NEH3dvyDWy6WCXEs00i+ABThvM02HQ2Igr6cKX8gT/K
         SUZGFApxRIH6ohCwk6Tjo1pDz+nXT2tWsjnq5hso/BFMs3nEvDh5eNzywTipLcPp2GCo
         QPWUAAsdHy0C6gcOJmzpYLlpxzEfP5FH5G8v6IvBgMuQWiSOqsQkMSPbb55SW24c0fMo
         GxUUp4qqdbGT+u7scRSRBhkjr0Mea9wLzVFYc0wbJ5VGwTIZJ159bfq6JmI481/kferI
         2HDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754929711; x=1755534511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3aIbfUE0BOLMSKn/ZeEXXT1HW2OK0nZcUJVLAItwPk=;
        b=jvubwmGJjq8AWWTtDMYsghXtyhGmUWh8JqwRI7mdr3x8F2JpF4a4vbuIE6QwKnn5Ff
         AgwseIeYK81Ipb0L4j5vsrirL+vkqapp64iVMLTgMstTGQmKTJibfnVRqczl1H8blU7d
         wQnqBwLin26BLHYi8cVc1piMpbN4yYer7dK2tV620dhOUPjopuY5pn1gugJVKP6jgrWI
         FwO/Jw/yQVTAkn5CK+KGxPB84UTZ3RHtp8o/L4NUEoLZYuxlFFg3nyky3Ci3q+fr2ccg
         yKVk7Uy67vChRwBjM8+JfFPMjsYfueehXjRZpfK9wD97EwoXBuudzNg3QGUs/COJXVPF
         H7XQ==
X-Gm-Message-State: AOJu0Yw6k7ZYKSSHI3XJjJd5BIDGJcFel5h9k5tX1e2KHOGQ0WyyVHQ+
	pckPLxkTSQHKE0Tjw+P8vtBTjvuflmorKmNT+exDwaLoXbpeG/JO78SClCLhsg==
X-Gm-Gg: ASbGncsRSC8J+xTFFJgsIEu7Dz6aPonBTCoaxK8B2KpEAWO7R6eQ0Vznab7H5dpo2sF
	geY/7qxrVQgKfVw309rAzUvuBbHO5wsqm3XxaVR/wgukJHQniBx38HudqBxJkv++XDVwIHfgpKx
	8Bqg5I3Kl+R2M8wIScHdF0dCJM1fakDIAyxCv7n5K7TV8wYBEx9kjCM36Nm2Co15qK9Ikvqucsc
	YGuQXUAvLoZmAy3ViV45WwKbJ8uIzR24e82DrVVap3vLgmP+j1BBSz0k6QzBTIMst7vyADrzccz
	Wgx7Iw/6vIytzzQY1ztLnF8w9M6s8DvKgu63IEIjeoWnRRKvKMpsRU4jl8c6r3CSYmVl3Vlm6kP
	qUNdFgw==
X-Google-Smtp-Source: AGHT+IGmR22SflOVfR9mRKukIRi0rGVYtzTYULa5fCRmpUWouIab4JPfn+klfuf7CiCKj3Ty8sOQ/w==
X-Received: by 2002:a05:600c:3547:b0:456:214f:f78d with SMTP id 5b1f17b1804b1-45a10beac53mr3151405e9.22.1754929711081;
        Mon, 11 Aug 2025 09:28:31 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:628b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58554f2sm260267515e9.12.2025.08.11.09.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 09:28:30 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Byungchul Park <byungchul@sk.com>,
	asml.silence@gmail.com
Subject: [RFC net-next v1 3/6] net: page_pool: remove page_pool_set_dma_addr()
Date: Mon, 11 Aug 2025 17:29:40 +0100
Message-ID: <7a23accc86f478bd1d4c35340211b87ecebfc445.1754929026.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1754929026.git.asml.silence@gmail.com>
References: <cover.1754929026.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

page_pool_set_dma_addr() is not used, kill it.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 net/core/page_pool_priv.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/core/page_pool_priv.h b/net/core/page_pool_priv.h
index 2fb06d5f6d55..6445e7da5b82 100644
--- a/net/core/page_pool_priv.h
+++ b/net/core/page_pool_priv.h
@@ -32,11 +32,6 @@ page_pool_set_dma_addr_netmem(netmem_ref netmem, dma_addr_t addr)
 	return false;
 }
 
-static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
-{
-	return page_pool_set_dma_addr_netmem(page_to_netmem(page), addr);
-}
-
 #if defined(CONFIG_PAGE_POOL)
 void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem);
 void page_pool_clear_pp_info(netmem_ref netmem);
-- 
2.49.0


