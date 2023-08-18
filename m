Return-Path: <netdev+bounces-28914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80047781264
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 19:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36B58282217
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 17:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8511AA88;
	Fri, 18 Aug 2023 17:54:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FDE168BD
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 17:54:24 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE55A3C16
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 10:54:23 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bdb7b0c8afso8860365ad.3
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 10:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692381263; x=1692986063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mgokGqPHO0YlcYJL+eizFkrm2SOg3pGMXQShFqwWIIk=;
        b=C+i6cLoAuCpUeWkiHluPrxJm503+BYR+kAF82fAHXfZXlci3rmX2SszO8dRCQz2+SD
         xcwVmYspIP1HJlh4sHlSmUSJlO8mIm0wdyVz9whSt90N1F1IC4DvE93eDs34XyITLObI
         gnuNutmoMoJSj/uARsbZIUFx0ROCUmLTuDUhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692381263; x=1692986063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mgokGqPHO0YlcYJL+eizFkrm2SOg3pGMXQShFqwWIIk=;
        b=TB4PZIQafDFNY8nJRZg9BECqsdpBeTYA4ECJ9gxy5Uo0QE3bh21PITYsM+iMaQepe4
         NCtsjR7GBtkTpLFmcFjw7ozm07tzz0xS+YKNqcv4KJHnyTQMQERQy3yG4NtPN4cndG5C
         Kq1lS2KPYKgtOHI1JIglP8sqNvHGll9MbDcTnqCjDDL1kkdUmiTI8rd4LOmYSnM3Ht9z
         Pu1FPmAxDkUysQe97NX17gFG3GiNgTe8hhyFYpV+EFDkAut3YoXRuqQwF9KYHBUW0YcY
         +EDAohncBCBaQdRRtkqwl/0cSRQ7XRY2NkrRJLwgGPU6iYfxRXSJgtgh3ICwh83iVnS8
         vQvA==
X-Gm-Message-State: AOJu0Yx7eVsG0BuIVPiau6ywF5Zm11AGZEuxhKaq9V8AHeTiermTmgc+
	WJKs4ZGWBbioGAgg9cB9L69asnkRXl1nn9iGfko=
X-Google-Smtp-Source: AGHT+IH/q+F1S/gkUp0u6TRVT8XSsZwsT26qFi4MEe+aOoh3Ei4MmwwZ8u99Ywrj8yPx5hpUt4+U5w==
X-Received: by 2002:a17:902:ea11:b0:1bc:3f9b:d96 with SMTP id s17-20020a170902ea1100b001bc3f9b0d96mr3307200plg.49.1692381263105;
        Fri, 18 Aug 2023 10:54:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h20-20020a170902f7d400b001b89466a5f4sm2050080plw.105.2023.08.18.10.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 10:54:22 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Siva Reddy Kallam <siva.kallam@broadcom.com>
Cc: Kees Cook <keescook@chromium.org>,
	Fiona Ebner <f.ebner@proxmox.com>,
	Prashant Sreedharan <prashant@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] tg3: Use slab_build_skb() when needed
Date: Fri, 18 Aug 2023 10:54:21 -0700
Message-Id: <20230818175417.never.273-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1521; i=keescook@chromium.org;
 h=from:subject:message-id; bh=l0mmsLVGH+CrHvrZXQxRZRb/0ioszhM7CEHTjrpeYl0=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk37BMmkdtnhTIWsR5ToZvLsbl/zm4J2IMNJinA
 ZffeIUNlr2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN+wTAAKCRCJcvTf3G3A
 JpE1EACicu9H1KwFfA69XLlwc9HkSfTfkXwHjghaPoVAvKEJWF2h2rRJvEa572+ONPIHFFT/YSB
 x+em9+AYhpXL5et5pIyHkXcoL5+3ohTaBIZT5bi1TV4sLge0Nh56nyidHgNffBDpvujhjHbjpV7
 1zXFEh8t0yi1cGvIUl9EH/ztXvXialrRvVWXoqpkJyH7bCrQdt+fZRBHaPQpeO0E1BkeFSfiTlZ
 xiXYeyQcbEllwrztLqto8snBZAP5nKWq6hUYfU2LIy3PZZcgWqyRVEOXfgHvLIlwhJVJGBv1G/X
 g8w4OH0MixMoT2Id7O+MrOAusM2pL4SPEn8IO+OnAMTtVaqqYEW2AEYWveoFSUnHOCtQBWyl+YT
 eXW9mkI0+Ao/remYhq2Ajq6w9xa0V+ofpcGIf6xH/GLLPaFt+mZgcdAKQ5T8QFlCRif1gush+Gi
 GRXmTtM9M38X7QypRLrCR7T+1V02S2GVUrj/3RFBz0k6G5j3H1SwyfivhW8+sxGYLZFc8mLhGSC
 CxKVvyqnaNoyHBoNWRrZPt7SIBaSrir41+Edsx/PI4c0QLlDMiimYZQwwWDYITBEtQ+2hM8znJd
 9QY9ZHyQwbfqNDLeeZmzZa4tAU+x55VKhSoiMgAVc2glhZoSzLBhV8P3EXRgTiYc7xeH/N+fK4m
 QcnOhyg 7Kk7cGZg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The tg3 driver will use kmalloc() under some conditions. Check the
frag_size and use slab_build_skb() when frag_size is 0. Silences
the warning introduced by commit ce098da1497c ("skbuff: Introduce
slab_build_skb()"):

	Use slab_build_skb() instead
	...
	tg3_poll_work+0x638/0xf90 [tg3]

Reported-by: Fiona Ebner <f.ebner@proxmox.com>
Closes: https://lore.kernel.org/all/1bd4cb9c-4eb8-3bdb-3e05-8689817242d1@proxmox.com
Cc: Siva Reddy Kallam <siva.kallam@broadcom.com>
Cc: Prashant Sreedharan <prashant@broadcom.com>
Cc: Michael Chan <mchan@broadcom.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/broadcom/tg3.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 5ef073a79ce9..cb2810f175cc 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -6881,7 +6881,10 @@ static int tg3_rx(struct tg3_napi *tnapi, int budget)
 
 			ri->data = NULL;
 
-			skb = build_skb(data, frag_size);
+			if (frag_size)
+				skb = build_skb(data, frag_size);
+			else
+				skb = slab_build_skb(data);
 			if (!skb) {
 				tg3_frag_free(frag_size != 0, data);
 				goto drop_it_no_recycle;
-- 
2.34.1


