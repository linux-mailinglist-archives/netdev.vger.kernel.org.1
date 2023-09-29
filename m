Return-Path: <netdev+bounces-37095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B66547B39B8
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 20:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 1CBBD283F00
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 18:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D752466DD1;
	Fri, 29 Sep 2023 18:07:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BED66689
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 18:07:53 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806CC1B1
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 11:07:51 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c3cbfa40d6so129745895ad.1
        for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 11:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696010871; x=1696615671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+OUXUGuXcJBjG1vjBPXQ48YFM5VCEcB7cIToPK1BuE=;
        b=YsLbaIi+Z54JGdna1Uvf1EVWSGngBtHHD7+2x3QgK547Xp2CQNNggVStgV0kFZ1YTy
         SR7qUcI8WS+zSQM1xaO/dc5IJBZH2CY6VECA0XFDR5jxuo//jVtKFlb3InnyVLi/BLNf
         rlsZoHKlZUCqO5WVAT0t7HUbn9HrTYidAl21M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696010871; x=1696615671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+OUXUGuXcJBjG1vjBPXQ48YFM5VCEcB7cIToPK1BuE=;
        b=NxLR923MhNIaNKhr4HFGamUt9ijHzAmBClV2D8aMoLyxZptiGDfXLYZ3f/jxmdZzyJ
         TW4rxyKUOmES3SKwPLzKXxVRTpRBwWPMipxTtdbi5etBuOlQqHg1styz0ebxlFU0GviC
         pyEvh+i33yXbV7/P0zeGr019/2FN9GiCf1nx35EZzTcqaArjtUZ37Tvh2z4o0z0KFtLo
         IBqP6dCXsu0Fwzkpw8OtZNrahytUgVeViKdq+Ensv8j/4f4wutVHwWCNj2UHndJyu2pX
         oJDPcrcKBXcs6yN3viS1ZT70OncIH/WnTUC7Xd3yiq87do7umTFIOMWxaWJhPWQKE5H3
         APAw==
X-Gm-Message-State: AOJu0YzbbA07zB5DkPDLui9DFWYm7eBwJa1xyyHgyGrsoepi1NIbMPRc
	4FtRRrX6wf6/PcGG2vrIhHtOUg==
X-Google-Smtp-Source: AGHT+IEUS5Q6CItC18bYsvchkQTR8lfIdVZ9unfjKsIV5LAfE1xlw6Gtd4iK7tOPYWs64fb0cikyIA==
X-Received: by 2002:a17:903:1247:b0:1bf:8779:e045 with SMTP id u7-20020a170903124700b001bf8779e045mr5483760plh.50.1696010870993;
        Fri, 29 Sep 2023 11:07:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jc1-20020a17090325c100b001b8a3e2c241sm10147160plb.14.2023.09.29.11.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:07:49 -0700 (PDT)
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
Subject: [PATCH 5/5] mlxsw: spectrum_span: Annotate struct mlxsw_sp_span with __counted_by
Date: Fri, 29 Sep 2023 11:07:44 -0700
Message-Id: <20230929180746.3005922-5-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929180611.work.870-kees@kernel.org>
References: <20230929180611.work.870-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1497; i=keescook@chromium.org;
 h=from:subject; bh=jOjkutl+FN0Q0NcydftzDs97qCbfIf1phadYTLsXBco=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlFxJwlBbholfX/29SJCBAGZf8A8xz38gXp6NGn
 iJOOuDg+hWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRcScAAKCRCJcvTf3G3A
 Jl1kD/90JOuRmIMhCW3kVJu4Gf7kOSWnfxMGxbUxzN86sjU+wC/P4QEzsQgpQHekYaH3EkKx7w3
 hZY3FZcnwP5TRImzUsKk3CTw9Mh+q5lC+9myfP1SslNwswdLHQFuNlACOS3ib7oQcKfwl/L+0+C
 4nNsIZCoUyPTYoHcC5bpZ2/WYHFFyzk1INSN5bwLVHjUtbYzN8WfOnbhXAh2UCBZx6M241VRFt8
 GdGwT6UEKT/WxeFImZc1/we2T3lPaFgJL6cTsFwBsC7VzwsJjSGrozdK64zfdYXL8GR0hu6IFON
 q1m8C/5hOkI5Roxt+ixnIcsJCMEtG/toG1nRVfNmwbrvS47XKtz/9suOKadveDxhgjmE8ly8vb9
 7I8Y68+f9/E2SZs1lLgKDlALZRHfjrUcCQKkaSOdncpJ79tVuDV1WHvLwlkOXKcS5PZp79wPxwU
 C1nBv+Fb8S9rOV2GUWx4CwY6gPSJITjbsK8OwtN2gpaZ4HEwqJNynjJKdJ3pnlxS8L5G7JQQ0Z0
 sL2oqyF2kseDrtIcEFZjha2dZXLaLgCwgW5bGfqsUbO/7bxD82ySZTA7UMqKtDu7ukVDDnrHoPM
 34KCVIJKR5OuqECReYCfRgG35+fh2+3yxWpNQu+qbdDtXvkRWrF76jUvTEoG0cSZ9AhOMB2wrUZ ptq+XEqPzyVUZaQ==
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

As found with Coccinelle[1], add __counted_by for struct mlxsw_sp_span.

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
 drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
index b3472fb94617..af50ff9e5f26 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
@@ -31,7 +31,7 @@ struct mlxsw_sp_span {
 	refcount_t policer_id_base_ref_count;
 	atomic_t active_entries_count;
 	int entries_count;
-	struct mlxsw_sp_span_entry entries[];
+	struct mlxsw_sp_span_entry entries[] __counted_by(entries_count);
 };
 
 struct mlxsw_sp_span_analyzed_port {
-- 
2.34.1


