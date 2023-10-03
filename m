Return-Path: <netdev+bounces-37831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A28197B74A6
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 01:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 3713A1F21927
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 23:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A013F4DF;
	Tue,  3 Oct 2023 23:18:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564453F4B8
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 23:18:41 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3B7B8
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 16:18:37 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c60f1a2652so2891685ad.0
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 16:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696375116; x=1696979916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cs/y+xaFiHWEOz6Orvy1iq9h94Wx2pdzVIF/nLH5ouQ=;
        b=of9zwq4so6JvnrmFQXDJe7dWqOSRgSSDWZQRgZKmRK51JJyEvkIDT8bUtmUHRElqiQ
         g+mGTqFnsfhmGD0y3ZzdKjDTmifhuzWzBdOFZlDGKsy1u3VlkUWsnux0PBBQGKhkktPk
         rCMNkpPlU+o6Drn894KU7APOs9RYLpPAvmNVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375116; x=1696979916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cs/y+xaFiHWEOz6Orvy1iq9h94Wx2pdzVIF/nLH5ouQ=;
        b=SY0QwjyNd53OCBtZHMMrM7JzPzXPTHO3UNTAgQPi9X9EI+QtOkrzl3zBS5az0gCy1U
         67vkw0zWzd/4js4iB8sIlsrrFa1Ytch2jLwR91/GfAA3ZWEvS13fBIWlsL/49T3Gt5XJ
         6DhogVNDn4u1v9xZlgXRM2vlMoMSLWFhATuxOLTXVypHRBrLVxC7Y881zpUjHtjvFAXa
         sFAhsHpzjhQakklvFMAmO3Igc5klymcNFB2gPROtHjVXOuLhuEX7olVpMrpFAyOHwL1E
         GcTSyyUFTH+YJj6phXyTsYgCfR/9ppUVRt3W5SEk3+/hCXsvUeVgrARFaQSQ+EV1e2et
         UAGg==
X-Gm-Message-State: AOJu0YxV3LCV59dKkvaim4GLUa+DsAvrWgbDR09/AXuDv5GDuCfNU/JB
	xUSegnkUg5RoMw4wPWM/a4Lamw==
X-Google-Smtp-Source: AGHT+IG2rmxvRQTV1QqeWHHUBymNu1S3TU8uYeUrwUlYaT3KK2tpSvc/uvywB/UQwgvWxExDCrsMbg==
X-Received: by 2002:a17:902:db86:b0:1c3:e5bf:a9fe with SMTP id m6-20020a170902db8600b001c3e5bfa9femr886524pld.30.1696375116475;
        Tue, 03 Oct 2023 16:18:36 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t12-20020a1709028c8c00b001b89466a5f4sm2192072plo.105.2023.10.03.16.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:18:36 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: Kees Cook <keescook@chromium.org>,
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
Subject: [PATCH] flow_offload: Annotate struct flow_action_entry with __counted_by
Date: Tue,  3 Oct 2023 16:18:33 -0700
Message-Id: <20231003231833.work.027-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1296; i=keescook@chromium.org;
 h=from:subject:message-id; bh=0boqWAsd/6ZiDm6IubJhgrIAyAV2i1CalHaJrRP30Sg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlHKFJjLDxYFWAIlzLyPwWgmZ9hiaj7VEOr2oHY
 k08COfXcdCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRyhSQAKCRCJcvTf3G3A
 JrK8D/9KEPYj/M8bXAiIzxWF2ZyJR84xb9ciEEfjEjN2R4UHdjtchwNrtasquYrt3ny+WIGBbhe
 0JtnoSkCuYrCzaTNpFQpAVzcKZMYAWOoTfq8XhRw2t8wwKrsiTpXgFd03LDFVgqgqamzoOXwyCi
 VIsbY5R7xwYN9QoafMgKzwFlNt0gNdb0JALM9kFi1qxxKVXJKh7hJB6BepurEVM9/3t3qR/AeqX
 2Xp5re530r88nPiId+lrJucvtIiZGC+EWjgwcMP9ZLg3sIdrmtXVDqeEXTLl9cSRMVnlPLRyk9o
 BVFl6eI3bjvpX9XG1Hk7XEk9UkjIOvK5d7ybgYiQIELVfYgt3SM19+jQFcg0opDFiTiFTVLeOSr
 RZ62m/4MMT+blNcje0k+2kr0KBdkZ2QPN1yBuvvQUQGiEOiAst/XtSRQRzcurQnB71jd7rvzbhY
 8mK+AXpzzX6mSSquLFzpQYS/DNsfZuda9IyoJ4cBNa/aC6Lll7qGFFJIhu7waaUmJ4GD7u/WE0i
 hYaMBUWBon4+wbtKUUgLqI8HJhyNfxSoXaA1JwhKA7liruJEb7wSadoNZKL51HpVQgvv6mNShDe
 oWrRx5uLCPSPzgKjEhQIHY8foSPVBmtvbRWzmEenClfkDY4KC6Y3KelbIByzdKscBCONl9tL/9+
 XLbpVM1 KEBl5urw==
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

As found with Coccinelle[1], add __counted_by for struct flow_action_entry.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/net/flow_offload.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
index 9efa9a59e81f..314087a5e181 100644
--- a/include/net/flow_offload.h
+++ b/include/net/flow_offload.h
@@ -333,7 +333,7 @@ struct flow_action_entry {
 
 struct flow_action {
 	unsigned int			num_entries;
-	struct flow_action_entry	entries[];
+	struct flow_action_entry	entries[] __counted_by(num_entries);
 };
 
 static inline bool flow_action_has_entries(const struct flow_action *action)
-- 
2.34.1


