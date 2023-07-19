Return-Path: <netdev+bounces-19185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F1D759E2B
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF36F281B91
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 19:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DB126B15;
	Wed, 19 Jul 2023 19:00:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED5F26B06
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 19:00:07 +0000 (UTC)
Received: from mail.svario.it (mail.svario.it [IPv6:2a02:2770:13::112:0:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA837199A
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 12:00:05 -0700 (PDT)
Received: from localhost.localdomain (dynamic-002-244-020-234.2.244.pool.telefonica.de [2.244.20.234])
	by mail.svario.it (Postfix) with ESMTPSA id A5B35D9006;
	Wed, 19 Jul 2023 20:52:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
	t=1689792737; bh=0H0svtQ0SIYq0aZtnwxfo6TE2JP6u64lU0YVS632IXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WRj46qxKo0l2eldNgoYOSxd+cNtL5AMsOOhInD1GE+pjXylqRN54szJNHHDIycSbf
	 sHQA3O9nuecW5avPSc/9dtPMARjaAs6SspNO+njQb0vfQKRWkln/e6Y3x2tKONStPf
	 JazVVgQb/ykH9C8hIMiuyj9WWfSves4fTTJdFulYlk0Jpdvh8t3mSo5YfoEbKx1a9H
	 e3RmlQ0z8VAgZ2UmVMg0jA7KK4/rAOIAKJUsqANG91E8cE0oFkp8YgnsgcZVrPbMBA
	 3axcVIIXIv8jO0C9Fm5wLjb39GSQKckq8sn3LmyWVRikjcw45uHq5t1nvVH4ArJD19
	 XqEgBOMwh9zUQ==
From: Gioele Barabucci <gioele@svario.it>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Gioele Barabucci <gioele@svario.it>
Subject: [iproute2 07/22] lib/bpf_legacy: Read bpf_pinning from /etc and /usr
Date: Wed, 19 Jul 2023 20:50:51 +0200
Message-Id: <20230719185106.17614-8-gioele@svario.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230719185106.17614-1-gioele@svario.it>
References: <20230719185106.17614-1-gioele@svario.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Signed-off-by: Gioele Barabucci <gioele@svario.it>
---
 lib/bpf_legacy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bpf_legacy.c b/lib/bpf_legacy.c
index 4bb3f7d8..52a951c6 100644
--- a/lib/bpf_legacy.c
+++ b/lib/bpf_legacy.c
@@ -2926,7 +2926,9 @@ static int bpf_elf_ctx_init(struct bpf_elf_ctx *ctx, const char *pathname,
 	}
 
 	bpf_save_finfo(ctx);
-	bpf_hash_init(ctx, CONF_ETC_DIR "/bpf_pinning");
+	ret = bpf_hash_init(ctx, CONF_USR_DIR "/bpf_pinning");
+	if (ret == -ENOENT)
+		bpf_hash_init(ctx, CONF_ETC_DIR "/bpf_pinning");
 
 	return 0;
 out_free:
-- 
2.39.2


