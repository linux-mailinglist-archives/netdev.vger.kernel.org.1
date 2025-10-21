Return-Path: <netdev+bounces-231398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F71BF8BEA
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 22:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AC244FE3A9
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 20:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20C0280327;
	Tue, 21 Oct 2025 20:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XM8OTQQz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A45F27F01B
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 20:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079236; cv=none; b=fWdD2aCzX8BZcR9VBbZ4k3LXM+Psg56kecy+wKqNZpFRz9CabOHlQToU8Q1frbbBGwl9+FTjPiXwuHJs4FhyzdsRabYjsCa78xjbJ1bSCVB8X/+FyD40TYKipZ4z8I6u8NVOObK1zJ8gMegrwQs6/594SrL2RTBg4Q6wiRRYQmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079236; c=relaxed/simple;
	bh=0Xq7H5Zqc7bJ8LoT75Cn4Cxisbj/4vXaazjZo4pkcyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDpYFMwbHyDdEPBbcqA0adEGzLXsv6bm0x9fKfR+aXv9mscGhkkSZU/WPIv/K5BHYgtXR1T+I3fIgU8u71dIDzoGA+Eot37fb3fTJhG5lyWzvAuO0DU/rpk8MIX6b+o1Q1kB5pCwBxZFUspEC3IhQdaRyZ/zlHqejCXwCudxvuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XM8OTQQz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761079234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IxVxgv6a54qoliJI6msppv7bT0rDjGK1QsEHLA3w6qc=;
	b=XM8OTQQzYTWXNXH2G029hEBTaBikaaKo0JMda6w0nR8uQqFnIlO4i8NGbwBhKjHycJ7opq
	lpU/IlO6ZB4pUXuPJuYk4iqZaVUWwrmc3i9V619xNEpsH9+TUZd0l658iXOAHyWVbaE6iB
	3+gW9w7uVJTrmmhlahx6TdZPRVvsgf8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-e61OZXhxPhiPCGDwa0gP-A-1; Tue,
 21 Oct 2025 16:40:32 -0400
X-MC-Unique: e61OZXhxPhiPCGDwa0gP-A-1
X-Mimecast-MFC-AGG-ID: e61OZXhxPhiPCGDwa0gP-A_1761079231
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A9A20180060D;
	Tue, 21 Oct 2025 20:40:31 +0000 (UTC)
Received: from tc2.redhat.com (unknown [10.44.32.244])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F122E18003FC;
	Tue, 21 Oct 2025 20:40:29 +0000 (UTC)
From: Andrea Claudi <aclaudi@redhat.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH iproute2-next 3/3] lnstat: convert to high-level json_print API
Date: Tue, 21 Oct 2025 22:39:18 +0200
Message-ID: <5adcb143681690619b109d79ff601309586588a4.1761078778.git.aclaudi@redhat.com>
In-Reply-To: <cover.1761078778.git.aclaudi@redhat.com>
References: <cover.1761078778.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Replace the low-level json_writer API calls with the high-level
json_print API to maintain consistency with the rest of the iproute2
codebase.

Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
---
 misc/lnstat.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/misc/lnstat.c b/misc/lnstat.c
index f802a0f3..8f359578 100644
--- a/misc/lnstat.c
+++ b/misc/lnstat.c
@@ -30,8 +30,9 @@
 #include <stdlib.h>
 #include <string.h>
 #include <getopt.h>
+#include <linux/types.h>
 
-#include <json_writer.h>
+#include "json_print.h"
 #include "lnstat.h"
 #include "version.h"
 
@@ -109,21 +110,17 @@ static void print_line(FILE *of, const struct lnstat_file *lnstat_files,
 static void print_json(FILE *of, const struct lnstat_file *lnstat_files,
 		       const struct field_params *fp)
 {
-	json_writer_t *jw = jsonw_new(of);
 	int i;
 
-	if (jw == NULL) {
-		fprintf(stderr, "Failed to create JSON writer\n");
-		exit(1);
-	}
-	jsonw_start_object(jw);
+	new_json_obj_plain(1);
+	open_json_object(NULL);
 	for (i = 0; i < fp->num; i++) {
 		const struct lnstat_field *lf = fp->params[i].lf;
 
-		jsonw_uint_field(jw, lf->name, lf->result);
+		print_luint(PRINT_JSON, lf->name, NULL, lf->result);
 	}
-	jsonw_end_object(jw);
-	jsonw_destroy(&jw);
+	close_json_object();
+	delete_json_obj_plain();
 }
 
 /* find lnstat_field according to user specification */
-- 
2.51.0


