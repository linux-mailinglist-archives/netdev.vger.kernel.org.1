Return-Path: <netdev+bounces-19167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3130B759E0D
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61EAF1C2118F
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 19:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4FF275D7;
	Wed, 19 Jul 2023 19:00:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865C2275A1
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 19:00:01 +0000 (UTC)
X-Greylist: delayed 462 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Jul 2023 12:00:00 PDT
Received: from mail.svario.it (mail.svario.it [IPv6:2a02:2770:13::112:0:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63261171E
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 12:00:00 -0700 (PDT)
Received: from localhost.localdomain (dynamic-002-244-020-234.2.244.pool.telefonica.de [2.244.20.234])
	by mail.svario.it (Postfix) with ESMTPSA id 5F415D9004;
	Wed, 19 Jul 2023 20:52:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
	t=1689792737; bh=fVJIe+M12SqLupS1brjLG68tYO0ZY1sx+3iG/Ny62wo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XT6mqFZqEizj3TREFHDNaVngF1fCbBkYPIEReoCGOLdT7RjHRi5C2cjiO2OmkUEPd
	 ZOwKRKsdE3kZ8xQsCE4WBfYJfxACea2co3/jd1NVcNbNRT8uGuBA4h1r10H9zYRMKl
	 lHtlexqw45Z+/WGxNl/zpqDumK3B+UJ+C+LZau7ZQl8OrKh0zwDLBhMd6W37KtLI9R
	 4XGbzb/+kMaeoqox2N2JWXFjn+TiIjSK1aKS/meCbKuRBj3U0hnKy8I+9EfVt/pzf7
	 HSdCVAqOHfkd1+Wz/VPPQLcUTMJEt4ROGukGo2LAtYIKbVPktZkLu0JfEFGX520v62
	 ME/lkWEWVBIag==
From: Gioele Barabucci <gioele@svario.it>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Gioele Barabucci <gioele@svario.it>
Subject: [iproute2 06/22] lib/bpf_legacy: bpf_hash_init: Relay returned value
Date: Wed, 19 Jul 2023 20:50:50 +0200
Message-Id: <20230719185106.17614-7-gioele@svario.it>
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
 lib/bpf_legacy.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/bpf_legacy.c b/lib/bpf_legacy.c
index 706820f5..4bb3f7d8 100644
--- a/lib/bpf_legacy.c
+++ b/lib/bpf_legacy.c
@@ -2751,7 +2751,7 @@ static bool bpf_pinning_reserved(uint32_t pinning)
 	}
 }
 
-static void bpf_hash_init(struct bpf_elf_ctx *ctx, const char *db_file)
+static int bpf_hash_init(struct bpf_elf_ctx *ctx, const char *db_file)
 {
 	struct bpf_hash_entry *entry;
 	char subpath[PATH_MAX] = {};
@@ -2761,14 +2761,14 @@ static void bpf_hash_init(struct bpf_elf_ctx *ctx, const char *db_file)
 
 	fp = fopen(db_file, "r");
 	if (!fp)
-		return;
+		return -errno;
 
 	while ((ret = bpf_read_pin_mapping(fp, &pinning, subpath))) {
 		if (ret == -1) {
 			fprintf(stderr, "Database %s is corrupted at: %s\n",
 				db_file, subpath);
 			fclose(fp);
-			return;
+			return -1;
 		}
 
 		if (bpf_pinning_reserved(pinning)) {
@@ -2796,6 +2796,8 @@ static void bpf_hash_init(struct bpf_elf_ctx *ctx, const char *db_file)
 	}
 
 	fclose(fp);
+
+	return 0;
 }
 
 static void bpf_hash_destroy(struct bpf_elf_ctx *ctx)
-- 
2.39.2


