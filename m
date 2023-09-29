Return-Path: <netdev+bounces-37101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904207B39C6
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 20:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A77E0284A20
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 18:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6D166DC0;
	Fri, 29 Sep 2023 18:11:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283AA6668D
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 18:11:57 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07C41B5
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 11:11:53 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c62d61dc96so58221345ad.0
        for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 11:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696011113; x=1696615913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrmkuelEd3rJ28up92cyB2Np2I/dyvESECk2QEaqxqI=;
        b=flTXVNpO4qOVZlBAJzuGgI/EHIohwpzeMy/6PZ4cuSEtEmEfrjO4f4/PxeSuhSCiHa
         3KvLw0spqKmkQN4/Y08W1bR0V5YOWy4tm9t5IExSAqoN4qe0H89Clk55yFSaNHAORypn
         hyXYnXAQbzSRbHtcuXGjARxMPEEEfuiVlkA74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696011113; x=1696615913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrmkuelEd3rJ28up92cyB2Np2I/dyvESECk2QEaqxqI=;
        b=CFWMHY0pYfCQOI3ReraH0zrvOhQ8oQHQ2rTbeZu0K6/CoKqP1bABMWznTGv4dZSAtL
         IFHwG7f3hJIHIqmyiUWFDb2VaAMbKELdwtoTyruuW4IeVdECXpSuXzyrRY2eOKSL9uqo
         62I52JIK9yM8Dk729FqGjaOp00nra4hpUZOEskTVT4BqphMiBVFQT5U+vxHgcJeCPvpH
         gaHe+mzEbzrMAx4VXNbv9p8loqG0Fxj/z9tC6Ne3/P5m+BU069+wnq0Fr/0JqgQKRDOx
         XCJjljxCIIPkdTi6F3fQepx8YoaiOEPpgOb0Vg1ioFkIw844sQuZ758HTXfKJZLVzYgn
         vwiQ==
X-Gm-Message-State: AOJu0YzsEo/6TzEOHAkqJTQ1YuJij5pOeEaDEVt0VcqpyAPZbMrTi1iM
	R32i+Ay9+VWwu8W9twVM/vhhPw==
X-Google-Smtp-Source: AGHT+IF0+llAWLKGd5tXXfz3AaZJWSIgRckzd/8+Cbfq0HsBzZOPCAEvp67CPVp2BmJIO5snh7SQug==
X-Received: by 2002:a17:903:248:b0:1b8:8b72:fa28 with SMTP id j8-20020a170903024800b001b88b72fa28mr5257379plh.58.1696011113144;
        Fri, 29 Sep 2023 11:11:53 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u16-20020a170902e81000b001b898595be7sm17123630plg.291.2023.09.29.11.11.50
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
Subject: [PATCH 3/5] cxgb4: Annotate struct cxgb4_tc_u32_table with __counted_by
Date: Fri, 29 Sep 2023 11:11:47 -0700
Message-Id: <20230929181149.3006432-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929181042.work.990-kees@kernel.org>
References: <20230929181042.work.990-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1483; i=keescook@chromium.org;
 h=from:subject; bh=WNbLnqzZE+z+esp5efLnkGvq7OtgHHNunnfXU8ZF7oU=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlFxNk0t1kkwpfJqHrZx/YdrjBahRhU6dQg7Okx
 u6FscRO6QeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRcTZAAKCRCJcvTf3G3A
 JidkD/9HX3Au2/63QgH0EK6PoLXEVxhxTyzFmm55RQkNUQ12mIdkyPQhXOdXdPaHOzINQkl3IxD
 XtInCBrvYRQV2fX6pGVD1FzuCQ8SVPLSnzKPJ9MzkyBA8G85jQJa27qbc8nOjADf84SnqUCU3E7
 abcFVVjUIDSZ0Ra/x92q32EPlOOmtGen8/5bd8oxADgtB1544tA/KdDiSkdx3YCXjN8VB3z7xqX
 Wd/RfUFBxFKzvD04iU34CID25Fp2EVQpI9y40lIzMtT3PizWOSLDYoFQ3NMr9dd9j71i3jHRkhU
 GaapzNg4UDQBfvv+ux2J5b6i+IAKJu0b+8a7tIfhhaKBNp2ISI4vIk9HqloOnQd+BWuluLKBpWj
 hrNtFoV3awi1v4YzPnCKrK0MvAhSaBekPoVttFqzxYutyFR66bgQx8yWh+h1V8+PfuZXkEhqpbO
 716CDFdVDm5pX8SWdmfs34fHxXg7aaD0cbUiOzEgXBZdyIZfRo+jtvT7z3lSEKFowA6ob5zSrCQ
 WRJT6MRTbvYTC5OtncSF65Ban2SQYBF3y7H8RvBQP4DCLG/hISKlxmIE/gCdL5musZW/gOJEyXx
 pxcm/D9H08sb0IH4WQreDSfrwlrjgngkjeCI+ouNbR/ybBapAwLHlhNU8QpNMPwM/LW4Tu3f2aX RMyKWiztAyV60qQ==
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

As found with Coccinelle[1], add __counted_by for struct cxgb4_tc_u32_table.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Raju Rangoju <rajur@chelsio.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h
index f59dd4b2ae6f..9050568a034c 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h
@@ -331,6 +331,6 @@ struct cxgb4_link {
 
 struct cxgb4_tc_u32_table {
 	unsigned int size;          /* number of entries in table */
-	struct cxgb4_link table[]; /* Jump table */
+	struct cxgb4_link table[] __counted_by(size); /* Jump table */
 };
 #endif /* __CXGB4_TC_U32_PARSE_H */
-- 
2.34.1


