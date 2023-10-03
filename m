Return-Path: <netdev+bounces-37832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B07E7B74A7
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 01:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 01079B208FB
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 23:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9C03F4D6;
	Tue,  3 Oct 2023 23:18:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D213F4D9
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 23:18:57 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39D4100
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 16:18:47 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c7373cff01so2636055ad.1
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 16:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696375127; x=1696979927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BfDQBScYxSUnSyfi4Uo6dvpGeAqp/VpjWLErGf4V/4Y=;
        b=c39GCY13A683WQCyXS91Ah+kckgiae7d4dciHzklFjcoQIB+TDGXGlWWf4PLFilZX8
         +1E8A99I6S3jAWXv5wkfYCAKs/b1ukQNYCj43Q+2nO2oLcLFnrZYft0BjxUWbj6kvu/u
         ulzUIJCN3AfQrOHaGQePEgSjrvC5/4Jp2U6aA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375127; x=1696979927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BfDQBScYxSUnSyfi4Uo6dvpGeAqp/VpjWLErGf4V/4Y=;
        b=q7GwHmarpcb1qMRo6oDrxdt740Se4P2bphrAai262Wxh1LExXxc7nohH4YkUKA5qLN
         Jkb7y5aLINAIjvjLqfRdFsA3HAp983wmC+AbDrQNRTENECCqFKy/cq1gvGQscyBgGl1w
         3+6dZoZRb65TxoqGCQFt70/n2kE5l9GApilX+bBN35I6e6UHHchMu1SgAiH1aV2Uqv5n
         cFnnU0RCbE/sfn0p7gp7RSAp4kGOvBWP/2S8XN6OcVgJpoh4hMHhQra8yThhRqSdbSTu
         tNLOVQ3i1SAvbQS900w+GAcQ+kBl1jsXpg9FarmHt9KhEl17bOP7bKhMRnv5vGeEnyZw
         Pdug==
X-Gm-Message-State: AOJu0Yy+Y0EQIlC7XDMRa4zDrw5ZEm2h+C3Mkfml3erAySHEcGP/ABhD
	tN/n9GqVBv7UdKS6BDwxHTqwgA==
X-Google-Smtp-Source: AGHT+IEQQoskUukjcV6UR3tDbZMEU82tUa1GjjWkAWraorZYJdgm/37PjJsSVWQuLq54fcBY2UxXAw==
X-Received: by 2002:a17:902:d4cb:b0:1c5:d8a3:8783 with SMTP id o11-20020a170902d4cb00b001c5d8a38783mr1089962plg.11.1696375126989;
        Tue, 03 Oct 2023 16:18:46 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902868200b001bde65894c8sm2155966plo.268.2023.10.03.16.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:18:46 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Simon Horman <horms@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Simon Horman <simon.horman@corigine.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	oss-drivers@corigine.com,
	netdev@vger.kernel.org,
	Louis Peens <louis.peens@corigine.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] nfp: Annotate struct nfp_reprs with __counted_by
Date: Tue,  3 Oct 2023 16:18:43 -0700
Message-Id: <20231003231843.work.811-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1385; i=keescook@chromium.org;
 h=from:subject:message-id; bh=GBdZ/bN+5XfvUCtrP1SCYpOVG1FCyQF4BGZ+0KiNObU=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlHKFT3XcaVjq8M5JxizadLIhdl5wOFCRk4jHmt
 IqwNVjEepmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRyhUwAKCRCJcvTf3G3A
 JjtdD/9D9R+8v9dgd3XY2WHug3rJjyK4+8aPw1mMYmILmQAYJrviLmccxjiM3F8I8PdZetcj6SX
 RbH4C+nQWdw5ItnpPFkHGDihNWS9JWqOKv+oGkwUa3Whsf7iRHBvZf7uB/OgbdEO293mVpH28xd
 KbDCTzrjImpUo55jjiQpypeXtqmMx9ETglaTTFwQcsy0AFJijWbvSS8agYnozYrZRQ/PImZqVtX
 SFpz7g3JLBAoGdtYE9fQ7jjJ03qrd+ZQrvXLw9SIaO9HFyflrYGihTFC1VCzd7kPAwollvn4m97
 HH7yUiaKoVQDlXMiCxjF1SJJJ5QIFF+rmU+yQNBLg/yzGofvOSNIHLJHsBoI1WCt1cuuf0mnJaC
 +99noNzwMdxYbz2ty0nd3nkKAgq9GWcgxUmxwAnh6DyTzhCdCyXTQFbQdFIwQPWMkk3XZzW/MBM
 oi4Nl8a1A7APm4f2ShQWBNUF+X5+K4WiwWDDm02GDNhGbhd8g4SqOBl0/u8VfysAI6ItMlF6Bmr
 hypptMkfiJr5Kgaw9lCUFKeoF4buVYEhf6KaQp/5D+vPYIEYbR/LYJZQC4OIlgi8AOgnMELTjFx
 ToEkiMcod9orNCiC8N2Sp0fIEREqeIVvOYH/MV1ScmN7S/nb6gSwPSSvo5KhnEOicTn5xHj2QxY
 Xabvqd3 WXqLy3lg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct nfp_reprs.

Cc: Simon Horman <simon.horman@corigine.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: oss-drivers@corigine.com
Cc: netdev@vger.kernel.org
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/netronome/nfp/nfp_net_repr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.h b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.h
index 48a74accbbd3..77bf4198dbde 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.h
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.h
@@ -18,7 +18,7 @@ struct nfp_port;
  */
 struct nfp_reprs {
 	unsigned int num_reprs;
-	struct net_device __rcu *reprs[];
+	struct net_device __rcu *reprs[] __counted_by(num_reprs);
 };
 
 /**
-- 
2.34.1


