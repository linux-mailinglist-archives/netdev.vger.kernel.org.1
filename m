Return-Path: <netdev+bounces-37100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1BA7B39C5
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 20:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 107FC283A38
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 18:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBB866DE9;
	Fri, 29 Sep 2023 18:11:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA64D66DC0
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 18:11:55 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF2819F
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 11:11:53 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c364fb8a4cso130398995ad.1
        for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 11:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696011113; x=1696615913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDRQEh16G/ipKRezI+KzovNtgIHUYl51I1aN5U61Mmg=;
        b=RV3QaUXCNHZVtSSY+yAdRYFkjPVOJfCFKbNJiV4df5lpiBMUt4YFEfb6czBBtG9x4p
         l13uGVE8Qv/YTRgMTjETGR1ZB4QwYX7zBOcKLTXDJO5IFWDirWUYmuMWx/MEvdWwlfF9
         X2hqNROldY7k050FDM7m4HETqR0fklrhZo8Eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696011113; x=1696615913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDRQEh16G/ipKRezI+KzovNtgIHUYl51I1aN5U61Mmg=;
        b=Ryvg4fWeh+TbmAF7F5ls2pdZPafKlpBnnpLf3PBi5X0ynxauWng49oWdko40JXgPZL
         DjWPmhi2d+5DpwcFa8+XxyVf8dURZisRu09PZouzluUQXS813gflomPH/NHMmUUA6w31
         0OXTthOVewGGZymTeKl73jReHVQ3tFBRhPRbXpJW9Qog7Tfo88cPlDnD7v6TFDjvJhZB
         Tl5nyXN+HfGDHQjB0KuCciXL9x91jv1dR4FCjSGtXIZsYk5+3uDbiA9snR2di5tyJ5CL
         HPKOBOdsW+cozllW4wpURajzQbas8gF/69TpdUWpgUvXl6VFQB091ghHloBrpagIBGai
         5lZQ==
X-Gm-Message-State: AOJu0YzruJ+S5SEiUbkUzaIX4zFKnOO3xnI1zRPYAc2F7rMMsfOZxVa1
	8t80R1A+5+4/CyJlEwo7l9Z98Q==
X-Google-Smtp-Source: AGHT+IGFwlJWyVkm3A0mUQlX8g9/99iOnnwZlUWPyYk2xMspY3q7K0JlfsqBEcTTaZjRplBDOBuiwg==
X-Received: by 2002:a17:902:bc4b:b0:1c5:b1a6:8118 with SMTP id t11-20020a170902bc4b00b001c5b1a68118mr4839960plz.42.1696011112843;
        Fri, 29 Sep 2023 11:11:52 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c15500b001c5fc291ef9sm13312784plj.209.2023.09.29.11.11.50
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
Subject: [PATCH 4/5] cxgb4: Annotate struct sched_table with __counted_by
Date: Fri, 29 Sep 2023 11:11:48 -0700
Message-Id: <20230929181149.3006432-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929181042.work.990-kees@kernel.org>
References: <20230929181042.work.990-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1384; i=keescook@chromium.org;
 h=from:subject; bh=kcIodOTCVIvY76AS2Uf+/xwdtFjYx7zCzGpQXcox5NQ=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlFxNkxHK+/1uBSnROiVBnNQXzF7bg+qpdlTfz8
 ywFHOxF76eJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRcTZAAKCRCJcvTf3G3A
 JvRwD/4vZRzCzyJ7qZ5e0LaFPcNTQJBX3MNd8d1CbPHzcNnsTiUzvwr2QTMa+SJNHbJz1OW0YkF
 F8oDEfY8iB86DNWrxXtU8Mh3SxWPpOWhGm5D1NYhVVOxsc3lD9nY+CMXj/H1ll8yIc9ZOPDTlXl
 sbpzhQSqKnzMh0pruH9XXBjZdMOcPY541+f1VcAWUR15XNGVYztINFkCllOwGK7/TfFUkGa67xK
 /OFPRD/X5XA40emcOai1thpLYunfLuJT65xmN9IiPI/43TO8t9O+990Gk2tsSLFSxh54Jym8nXj
 WjDX6F4t5K5a80F8HuSOL7xkxbslxqmV1QoPUCLSWpTOhyX6ysRsd3YDRxNomMJAjaz0QIWUuM2
 BEwG12H7dp8Uq/JgicSWz3qgEi+NnCp0T8n7PsDod43AaAQOg0hY5f+PjAS+kcj2N5EL6f2YXxG
 rQVl/O12pw7A5Uz5FQkUklt7d2uYQ3ZUQuhx+S7bfzC6tGPBK+c5tGq1gN19O03rnPjOmcpoTG9
 Yn6B340GmCnWDHH2xaAZn5Vi1qAY9krgGCjtRMTM0T4JJRDT43jON6staRXoccxa1ReFpqv0TW+
 qpSBF1Xzr7UAXSbT56sXO7mAN64CubXJtY8Y28rYrWzq68zey/FU4c2JFbmLKUGO47FVhZ6kXoC k6U28UbshZcl60g==
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
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct sched_table.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Raju Rangoju <rajur@chelsio.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/chelsio/cxgb4/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/sched.h b/drivers/net/ethernet/chelsio/cxgb4/sched.h
index 5f8b871d79af..6b3c778815f0 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sched.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/sched.h
@@ -82,7 +82,7 @@ struct sched_class {
 
 struct sched_table {      /* per port scheduling table */
 	u8 sched_size;
-	struct sched_class tab[];
+	struct sched_class tab[] __counted_by(sched_size);
 };
 
 static inline bool can_sched(struct net_device *dev)
-- 
2.34.1


