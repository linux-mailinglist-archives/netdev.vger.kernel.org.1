Return-Path: <netdev+bounces-37830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBCF7B74A5
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 01:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 5235C1F21866
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 23:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699273F4D1;
	Tue,  3 Oct 2023 23:18:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C343E496
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 23:18:39 +0000 (UTC)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C72FD
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 16:18:35 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-578d791dd91so275029a12.0
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 16:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696375114; x=1696979914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+2FSIWN70TIGw3orK2+O3bir1YHHopkUZ3z5rVFgFT4=;
        b=RyQeqh+1BD1E/Nd/fG6drmZUbhheGx+P4zlFgFV2ctDtAC9IGpTGNKWavFroI9RyzW
         Ao5mcVoTCTsmQ/JZ5k1EuZtP0NyfXnHCUCNjskfsCCIpP/kdlOGBQ5fDRAIHQsf2N5sG
         KtS3lDAtCGS/bGc17Sp9H4nC67LytQq1+3oQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375114; x=1696979914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+2FSIWN70TIGw3orK2+O3bir1YHHopkUZ3z5rVFgFT4=;
        b=hKRs30WDllK3LbjErNP8JXctLvfwtBtFVLKCWsaZml1k6TZVdppSIHwRRN8S9X5a80
         iWgJg6G5ijTjPsLUnhK7M1XkPmnFmoKFfeWF2g+fkTMui4htsvg4RsLRaitIcBi4Bhij
         z2LSaCdvBtelOVrs4n51Q8dhJ9obyYBUeoModwkAE+wXAnfj2/sfFCO2FllLAKJtDqPO
         66+zZmK66PrznD1i+oZ8CFZXSGMtydw0ybQYF1OyGSbMi9GzNFu0Fhn5QxNUMZTVq6jB
         Shyds49POuRvgVd3FvXIf0Ydy4Wfb/JLNwrTxlMXLYdkr5pdFBGScw09fNeMxTOn+eLF
         RK/w==
X-Gm-Message-State: AOJu0Yzoxui7mQBY7CPIcrq4vBrvKcxETshleOiOoxJ5ZpLH0PT5TaBq
	cWlGfBXMzL44EKvArRKOnJwT23WtR7X1c2BzkeA=
X-Google-Smtp-Source: AGHT+IG/GfalIBIjvZJxqoUuM/q9d85zcgnjKWe5dC0Jl1ycHfoTvdk5+3M3ZBdvZlxTKrWxUVwyHw==
X-Received: by 2002:a05:6a20:8e22:b0:140:d536:d434 with SMTP id y34-20020a056a208e2200b00140d536d434mr1057230pzj.10.1696375114587;
        Tue, 03 Oct 2023 16:18:34 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f9-20020aa782c9000000b0069102ae6d93sm1985422pfn.14.2023.10.03.16.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:18:34 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Kees Cook <keescook@chromium.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] xfrm: Annotate struct xfrm_sec_ctx with __counted_by
Date: Tue,  3 Oct 2023 16:18:28 -0700
Message-Id: <20231003231828.work.527-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1428; i=keescook@chromium.org;
 h=from:subject:message-id; bh=0lpEMudeRdiAAJIqHbj0Q7ZoTR7IUMUOYn49nl4rZJo=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlHKFEUwVcABd7A9e7Zjv1HFmOM3RO2gbBm9SPK
 yjLOR3pgGWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRyhRAAKCRCJcvTf3G3A
 Jk/LD/98iwmykBFHGUKgLRet43isHedtc34kHI9bKIJctwTbVdN0V8AOWh+GeV7UHmS8EaRHVZs
 A3pwy4kIX7SyU8CCIbKEqdPuIpRmbEx+0UBi5ROffUF7fIHvQqL4SFC2QCvL2c4DDiBtLzpxPhv
 25pOUS/+LdxmaakSd/M1MPWcHWC4cNg3iifoeEi5B3S2c+u0sKhT7pEzrDfrAm+4F9FIIdPcUuf
 vwTOYkePCiOABdXSJ5I5x0QgpBMsYu2B/LZst0w+v2wj0Wm4gYB69R/xuiOwf+4CsUf6K+yyBkr
 TN5boRm+2WdQvAqiJh6tCaF9WbDYs+9EDERXFyYSyuCV/iZUcl/Y3oSg2fTIBRhP4S+aSkvjJnH
 fqKS+E20wJLcf5II9sCRIbNsJEI1E5yYcZj+OUBWvy9+U45ob4R7AhGZakKn01vtORIyXEKtOpM
 XJOTMdPqamTQo2CvrQlMVbYdVYWM4RAvwVpIO1UBuO1lsl4Z6WhoPyqdo6+0A11NnR7dPYW1SaJ
 CG0A4MBd95paZ3fuciiJOF4tSpWpVGP2J6Zn5LEPTa1syIXwx0O7RSZuGj7QpfY4q4ONXJu1/P1
 D8IT5ehGSVkSPdbyWZ+Zl8roYh4PCu7nKGe89yG+3u98P7qzb3btTte4G/aXH/jAWWIYsDZJsl2
 23uiuZ0 GVqYc+ow==
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
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct xfrm_sec_ctx.

Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/uapi/linux/xfrm.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
index 23543c33fee8..6a77328be114 100644
--- a/include/uapi/linux/xfrm.h
+++ b/include/uapi/linux/xfrm.h
@@ -4,6 +4,7 @@
 
 #include <linux/in6.h>
 #include <linux/types.h>
+#include <linux/stddef.h>
 
 /* All of the structures in this file may not change size as they are
  * passed into the kernel from userspace via netlink sockets.
@@ -33,7 +34,7 @@ struct xfrm_sec_ctx {
 	__u8	ctx_alg;
 	__u16	ctx_len;
 	__u32	ctx_sid;
-	char	ctx_str[];
+	char	ctx_str[] __counted_by(ctx_len);
 };
 
 /* Security Context Domains of Interpretation */
-- 
2.34.1


