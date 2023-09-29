Return-Path: <netdev+bounces-37098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF3B7B39C0
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 20:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 1845B1C20B87
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 18:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D3566DC9;
	Fri, 29 Sep 2023 18:11:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DF266689
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 18:11:53 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797EF199
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 11:11:51 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bf6ea270b2so112123065ad.0
        for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 11:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696011111; x=1696615911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LelDNgIaKJAGv8m5QtAniz9H43KU5lbEctjO62ftcqY=;
        b=c6JXIVj8+lpK/dfbLFSBBXWCRfw/iOqrSjbUE9h28HcY5xoTuqoUYrChI+t9ZpwZuU
         JAWSdZxLk04I308cwN7stuS6ROcscZTvhh8N3J6jarqvnP4DwINMJ2qa3nC4A3CEi1Wd
         J1Cfi7W5VK3YwrWjia9nk4/rIiDGc6c5uqCIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696011111; x=1696615911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LelDNgIaKJAGv8m5QtAniz9H43KU5lbEctjO62ftcqY=;
        b=pURSHl4cJ1U4XaVdIWzj2u9V66+kfFpYhliFyERGGaLTMTx4lPh8mj+dNfkxvz/bZl
         LO/Wx75AsyO0QgVV2T4UVGM0QIbp9XlCIAa5QV8YOVkD8ndQ8xWE+1A4kKRtCp7jdOi3
         adIcwqPh42y15LYmARzwv1jAuiPBZoi3Yb0efx/sgzUeGtnCXDhIpHkyFuuoAt2a5Xal
         /wV8xKm6xai/f6ANzR0O32jbezSu4SwDlZLbVAcoxY1aZrgYBZuyT9OhqpoprVYYyL1s
         qq78H1PeWpLWHI8+v/7YoaXTJmywwanaF5/wnaK9TPfFaZkgf0n3S+CLdOrRRKStznag
         KRjw==
X-Gm-Message-State: AOJu0Yx4Kv6gjmz0/Wg8s/hxmfNQJyM4aRaWpNI8Tr/Z3OFme0f4/5Ll
	/i4O247eAIoZGC3+sLPhizUQ2A==
X-Google-Smtp-Source: AGHT+IFp3bhP+Nqbdbpr+lLgR4vtr77JK8lxcWx2zxMlaCWdtIt61fdrd8th89qUIyLgBpTfPNGTAg==
X-Received: by 2002:a17:902:e545:b0:1c0:d17a:bfef with SMTP id n5-20020a170902e54500b001c0d17abfefmr4502026plf.30.1696011110955;
        Fri, 29 Sep 2023 11:11:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g10-20020a1709026b4a00b001b8a2edab6asm17075217plt.244.2023.09.29.11.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:11:50 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Raju Rangoju <rajur@chelsio.com>
Cc: Kees Cook <keescook@chromium.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 2/5] cxgb4: Annotate struct clip_tbl with __counted_by
Date: Fri, 29 Sep 2023 11:11:46 -0700
Message-Id: <20230929181149.3006432-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929181042.work.990-kees@kernel.org>
References: <20230929181042.work.990-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1345; i=keescook@chromium.org;
 h=from:subject; bh=1xjwdL5f1ZwQtlSjHraq4S6Ct1cTzMptk05f7F0Knyw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlFxNkClAByZ2t2imOLxlyWRMjihvubRYuwVOju
 CbJdpqAEYiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRcTZAAKCRCJcvTf3G3A
 JmRDD/4xcFd2xErFHHO52g54sKzulxzUwaY7hKB/cJqB+eXbtFGgB2tt9GnWDUYTucvNWfGfrRO
 WefuPoFa1In2irZrcx0pjDUGznGE0qFXLd86FJtIOeSIEJq35TMjFQOnq6tqhTenU3znVkbQZev
 64kT7WHWe+/WYF1syArYm5+LofMLkW1zctxLTdrpIRXBXpxbK9IzCd6gG7yQPGh/nCDZaZJR++k
 D/oSNxxnkr/cGbxRxhf5s/8qYKXv5Y8uzNPu2q5G9yzEf6e+8urdbYNlDIn4WGlWwpOVsGubTh+
 ef8O9z++/PzDHpk+g5s6fMxH3IM1sNyQbzRSblOMYA6ciGJzENjrSxqVZKJtIVk/gu4cEYIdRSC
 MZTZgdpN+v10komKMPQwIO/PiQ/38irV/eA1mWTw5lLAm8tqB6LPg6MgYOuOGXtFoI+neSJYPf/
 x5hWOqzImqqP2rxs3VchpeExsk3srsZJl6fPJKZxcRQ2K8rIR49s8wzZr3k3xKhPdYXoqMAu6lK
 whn/87qgrQShDDdmtGChdFZuoQ8jBLDXo1Y37dgkk0uN1pnVazzfaYydiESmJYIMAqDs7eiDSb+
 dMhc2XY+KeQ78Dvg0PDZtR//QWpS5+pG+iPfaLmlEqG6/1pQASs8+LUwdkJXtia2ClOU5W+qlcR fszdrCV9cNLMyTQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct clip_tbl.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Raju Rangoju <rajur@chelsio.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/chelsio/cxgb4/clip_tbl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/clip_tbl.h b/drivers/net/ethernet/chelsio/cxgb4/clip_tbl.h
index 290c1058069a..847c7fc2bbd9 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/clip_tbl.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/clip_tbl.h
@@ -29,7 +29,7 @@ struct clip_tbl {
 	atomic_t nfree;
 	struct list_head ce_free_head;
 	void *cl_list;
-	struct list_head hash_list[];
+	struct list_head hash_list[] __counted_by(clipt_size);
 };
 
 enum {
-- 
2.34.1


