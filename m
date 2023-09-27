Return-Path: <netdev+bounces-36469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EDD7AFE69
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 10:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 9897FB20C53
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 08:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF601F616;
	Wed, 27 Sep 2023 08:29:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4926A53AE
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 08:29:28 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1239CD7
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 01:29:26 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so12269536a12.2
        for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 01:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695803365; x=1696408165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vqzMLrutU/O6W+UgakqlkbwTrx1oB6pMeuXfKi5IFhk=;
        b=CDQRBdR7nRJ3YnayfbI9c+ZMbHbZETcn+Lroddc68KepHY7tFhMR/XPmMmBC+gptfs
         mw1F97r+fGVFhbnRKqqLJLbEVp2kZ5Q3JtkQAfTPETHqjuQmy4DOat0bQX0j7PXHlyEs
         GXM1p84BE6SrgUISMCapAkkZWR7fhiRIHK9A/ZsyppKwBja2vFAwPV3Qemd96y+gdQDn
         ajCutqNp9E/DJ3BxLsdW478xeumEv/sD5bZeELt+vE/Kbz+jWxag2RvWQ/Ce3Qfb61hq
         SKB1Sf4O3MQl2sf1ZeyY5SJNiyfo9fi7By9cUhe7ZqhdhKb9DzAMJ3WiE0JSlQELrG+h
         jK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695803365; x=1696408165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vqzMLrutU/O6W+UgakqlkbwTrx1oB6pMeuXfKi5IFhk=;
        b=TLoc4bDLcrJN0EVxwX+e42AAtZK0qFO0GrUjueIt78V7hd5qbIfmRvxBvYzcBzODrt
         YGiV0RI/ulgNjxPllaPtOwrEVJFZ6wxQ5VSJcim6U7wNJivAXWr0tSgP3PbfCZB1jNBO
         dyTtJjUFOkFejamKD9Sj+TIWMMKfZBnXuyeRaROqycjIqVxHeQfyRbn+NKhck8F8xjpB
         nw/wtRa4fPbcXD5DkfwUpAOm0XqbkQBdiXKy7R/LkjQln02pxiIEwRi6oSgAtH6KwzNs
         iDVhbDE3NUmzJPISpaqFejF+qqieKjpwBgCsYbUXqOVC5hgx/SLv1hxP7eA4o6OADtZU
         oAYA==
X-Gm-Message-State: AOJu0Yy5EGsXlCb9SSG65dVTgNYxYV2SsDJaT1UZM98mh9d/9ZUVyqzm
	SOM6CrBDmpYdiiSQ2iFMaG4=
X-Google-Smtp-Source: AGHT+IGEvtWog5f46DQVKz2/HPmkwyHuufDzJwb3m/0rrIctLdakAOfl6oDV0S96vLRTi2Q5xclp+g==
X-Received: by 2002:a50:ec8e:0:b0:525:680a:6b89 with SMTP id e14-20020a50ec8e000000b00525680a6b89mr1297725edr.12.1695803364420;
        Wed, 27 Sep 2023 01:29:24 -0700 (PDT)
Received: from localhost.localdomain ([105.29.162.58])
        by smtp.gmail.com with ESMTPSA id f3-20020a056402068300b005256771db39sm7763953edy.58.2023.09.27.01.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 01:29:23 -0700 (PDT)
From: David Kahurani <k.kahurani@gmail.com>
To: xen-devel@lists.xenproject.org
Cc: netdev@vger.kernel.org,
	wei.liu@kernel.org,
	paul@xen.org,
	David Kahurani <k.kahurani@gmail.com>
Subject: [PATCH] net/xen-netback: Break build if netback slots > max_skbs + 1
Date: Wed, 27 Sep 2023 11:29:18 +0300
Message-Id: <20230927082918.197030-1-k.kahurani@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If XEN_NETBK_LEGACY_SLOTS_MAX and MAX_SKB_FRAGS have a difference of
more than 1, with MAX_SKB_FRAGS being the lesser value, it opens up a
path for null-dereference. It was also noted that some distributions
were modifying upstream behaviour in that direction which necessitates
this patch.

Signed-off-by: David Kahurani <k.kahurani@gmail.com>
---
 drivers/net/xen-netback/netback.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-netback/netback.c
index 88f760a7cbc3..df032e33787f 100644
--- a/drivers/net/xen-netback/netback.c
+++ b/drivers/net/xen-netback/netback.c
@@ -1005,6 +1005,7 @@ static void xenvif_tx_build_gops(struct xenvif_queue *queue,
 			break;
 		}
 
+		BUILD_BUG_ON(XEN_NETBK_LEGACY_SLOTS_MAX > MAX_SKB_FRAGS + 1);
 		if (ret >= XEN_NETBK_LEGACY_SLOTS_MAX - 1 && data_len < txreq.size)
 			data_len = txreq.size;
 
-- 
2.25.1


