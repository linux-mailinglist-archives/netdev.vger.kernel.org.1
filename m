Return-Path: <netdev+bounces-37092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB937B39B2
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 20:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3D0A2283566
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 18:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E8F66DC7;
	Fri, 29 Sep 2023 18:07:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76E46666A
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 18:07:51 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D8C1B0
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 11:07:50 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c6219307b2so72472925ad.1
        for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 11:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696010869; x=1696615669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1fCnyMESIUDw106GjvVeHm07JaGiyNbi4ApDENYnlM=;
        b=i7xHrXvm+x+CXquDtwP3n/6SITwyQLaNnPs/iDit5wVSn9kPZ8ni8jT0KLjaFj1bCn
         Ol2D23xwnqUrGXkm0hdDWcquaq4LlQ6Z3+qZb8YvupZjLed4EqP4vMcKAl4Sce/U57Ne
         VNoIs2qPpRmdcN2+VHjE2NTdqJB+HGG2DulUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696010869; x=1696615669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1fCnyMESIUDw106GjvVeHm07JaGiyNbi4ApDENYnlM=;
        b=iCZNJpbcHCcG7OzSDO6I7lAFegrYi7FxfSMQyx2hJLcEnvmEkRBk99QG87VWkmzuT+
         kmW/tLwOkxkiIctaJ9K7qY01TP893VBoNAmslWL6/HLDztNSb07cT8XL+SsJduO/EFmL
         Nxqo/dvwGoRvme2t3G5P82kp0HZ3Hss7Km4pJ3OAMyXITN024OrBUvG1XGEeR5R4NQXK
         HZSuuVISMphNNq5z4Ws57tZ1fRPh0UFnP12nBb2rSMUNypOppG6K2cOJ24T0U9DBYjIZ
         UKBy88ygnojCIULP7YEie9FfxojXdvX6xxfXLvQFuS6mb0emSkZzL9T1Y9f+ud0Pm+DV
         QO6Q==
X-Gm-Message-State: AOJu0YzLnHv4oz3HXG10Wx/2Bc01A400wIsrTxBxAVmcinn8//6c1FfT
	CRJfs3uh4ggoohhtSWdBN4Zqnw==
X-Google-Smtp-Source: AGHT+IEYP50F7nEfHcXuhCVPvSqHJT+dGY9l357PrVksSC4o53t+1o2XfasILPny5/J4Mg6J6IWTvw==
X-Received: by 2002:a17:902:c408:b0:1c4:5c05:c3c9 with SMTP id k8-20020a170902c40800b001c45c05c3c9mr5808758plk.56.1696010869523;
        Fri, 29 Sep 2023 11:07:49 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902d18100b001b8b1f6619asm17332300plb.75.2023.09.29.11.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:07:47 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Kees Cook <keescook@chromium.org>,
	Petr Machata <petrm@nvidia.com>,
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
Subject: [PATCH 3/5] mlxsw: spectrum: Annotate struct mlxsw_sp_counter_pool with __counted_by
Date: Fri, 29 Sep 2023 11:07:42 -0700
Message-Id: <20230929180746.3005922-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929180611.work.870-kees@kernel.org>
References: <20230929180611.work.870-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1611; i=keescook@chromium.org;
 h=from:subject; bh=+RWfw0GyGwLXMxH+fSx74341Dume6vULCGctkWzJyII=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlFxJvQ2MJX5MIYubHbp+JLru78XV8PSD9HfCip
 MzkMrfhDwOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRcSbwAKCRCJcvTf3G3A
 JnRLD/9EGd9KZ/Tj7Icy70EINkAG/rdfxW+EXWV6I9tI7aqUVeByxYSzHqj8FOidkSGNCh4jARc
 +uXnybahYfPpBWVV41kZfAhAIpxzSoq6s8NuNmkX6T8LHkps1oWxj6pDoKaoFfCMdsAhNUK1xcK
 UiU2qHZHzc1qKNWo1sAcHnPjme+swZST7xHSQ8SF2E13eDaQvKKEpdPeGtSNgPEV8yLj58EN7a0
 iP8n1qZPDs7IoEuCGekv4cGmTTaSzUDc0R7Za2m+3bdHl4DcF9E+nOig6tbTybEZi1aNNjPdNL+
 s+j9/MzDWmw9GMUxIetw7H9laEtIav7YYaf6G8aRv+wTndvPDcfVqBcvfdYnZNx0/rgJSm4e1K+
 QhoQGun8o9/gzP/Y0vAq9j6Fqo2XYbAy9jfvjwol3QlvCJMu54iuM/U5nr6GkAWJ4k7d9jZiVFx
 W2aBOpvnHsbXQd8exwGC8sDd5XFNezCGfQ+qK0pWvD3xzZtJ8mgiQFrhnx7KZDh2+fYU33Hzy8K
 6beObhLWjwE4DYbXYUH8YXOE31yPMSY5K6435NP9Zhlwr4oB1bNxjmDgCqJC73O+PFfJuj6UzKl
 fpEuOHPJVmLtuWUTjz2a/oXMxNT4xkygpO3lIq/qJUoDhiJqrHWI4WM1E4GV4EiRdSAkrIFp856 Z9rPTNG+P+HSMvw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct mlxsw_sp_counter_pool.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Ido Schimmel <idosch@nvidia.com>
Cc: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c
index ee59c79156e4..50e591420bd9 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c
@@ -24,7 +24,7 @@ struct mlxsw_sp_counter_pool {
 	spinlock_t counter_pool_lock; /* Protects counter pool allocations */
 	atomic_t active_entries_count;
 	unsigned int sub_pools_count;
-	struct mlxsw_sp_counter_sub_pool sub_pools[];
+	struct mlxsw_sp_counter_sub_pool sub_pools[] __counted_by(sub_pools_count);
 };
 
 static const struct mlxsw_sp_counter_sub_pool mlxsw_sp_counter_sub_pools[] = {
-- 
2.34.1


