Return-Path: <netdev+bounces-277964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJwTG8SU3GkkTQkAu9opvQ
	(envelope-from <netdev+bounces-277964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 09:01:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CF13E8094
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 09:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8388F3016915
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 07:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58273128B2;
	Mon, 13 Apr 2026 07:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAuh95Uk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE78265CBE
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 07:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776063622; cv=none; b=DRRMiaRazSB7AsdwLR4J1TVmQvr39064pDZLyTCi4Mf85smIeyrqx1sDeZI2PsSU7dTi4gZd//9G0PaqU7Lnwcug1DPk9HkW8a0DLwIAXeAopwLN21EEifv9EgOwtEvbY1x/drJdvIghHw/UocoRNeuffsU8pQ4CrNgbpaEMHkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776063622; c=relaxed/simple;
	bh=KwPKKI8ujdK13H/nCvSAP0++ttyw8CHmOYPRVTAvVEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rAq9xB01t+j2t05saM57XqZLQKTgwS4G3n8gj9kqUz3CJ5o3jYR8vLE/97RU4nfVdbxcK+aWI7ummiGVTSekamllYQPKrR+vx9bPe8WitjNXcdNXA6FWcEjW/fgbEAAujmtKw6IsWJ3JXqesf057a3GQX3JqZAzKpOX05d2JfZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAuh95Uk; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2d832f2f44cso1187082eec.0
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 00:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776063621; x=1776668421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wcf1iWSRA87AUV2HNsi+KD2GJOFrP0HPCIjQVH9/1OY=;
        b=WAuh95UkbamVEXg5fTfavwmmeU8lMug+M4R0ijRVEnMLWu+8b8TPfeXAtZhfKoRqGZ
         1XBUq13LAkwrpVg8J3Q5mwa/SdU1B/zxiqBshGQc8zmyNPROTg6Fp9olyCqOJsYuF0s9
         lPdBFu90i9W5IKaYO13GSJedf2ORXJqZC6m/SLKyHw0kExcPG0vGVzsOQ/wzrdfKeUd9
         xWutG4hgT0MlZfVkov/EJX4MDfHctHdSA/ZH3NWnjsLEMod5ovv9SPy22AhIWVGLx15R
         ViMVnlHVxwo00FSKvIC8rSctNzJHpmjmBkVbtqJ72+8VlrIhr02H6McPn5rv+DWy4oa/
         CyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776063621; x=1776668421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wcf1iWSRA87AUV2HNsi+KD2GJOFrP0HPCIjQVH9/1OY=;
        b=GjEtInn3tJCQzqwIJ78g04YXuyfkhQW2+S21wBwzFSvDYcwdzbh4n3JRCl47MiwFpT
         h3hwUoHDix7aE4Tjbv9b08Tk3gI845FgMAhD8XNlxu69jPTYuhIj8bpF5gTi8H8sJ5BY
         XgeTZ09hHiQukk9OYG+b5JKrYBmbhhKtcLFRWuJG1kcYTSnfyTYnbzt/a3XcRx+Zrz9U
         WJHrW4Gjhr9XmCEPv0HaywcpyH8/sOlozxwG6SbqcA/N0oGBL2FXfjv0LIYBsNh3dw3a
         W+8SpUGoLxDMpVeZ2Sa7Vdfp6WgAGed+zM9royQIhTr4X29zbIVgSkiAKaAz1TaymEyl
         T2Mg==
X-Forwarded-Encrypted: i=1; AFNElJ9/xdFrF1ZBYNOAtNt6NlCfUb2sL70GJnDtH+AkaKva7WpZadBunevcN+QGEzejtI9xNaxJUbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyymWadGweAgRj5RLBX7IK/qjpJG7FzkXHHqtv3DvwT2IwdrbMi
	DmG9KyiJ6B/WE8mjdeomYYY601XC3MgwIDXHrjeY9Fh33sRcZ0qUIsHG
X-Gm-Gg: AeBDieudAr5iRv04AStg0WapIIwaEI7oCW4e4HhfsAEmkuE0dh4IUasIeHHlfhizcZL
	AHMVFQZsWRMIFhy0y4FiV0tfSqryGuneTRi67lHIaWjBp7JlH8EjP0OgSBpuXTdZHmgXiTKUfx1
	Nc6VIa+kL9B7oCQcBP25vbsDZFAPvVN+xSCCczPhOIwEbGd47DsxxKvaruiLKb/TFMLkvRH8bjK
	hVDgXCAmOsyKXwbITwFpNzQ4+u0b7ASYvl0NMh/6K9/e7sai73KvbpWlsT4wQ5tum6wAnBOyTDd
	U7JkCfRO2dRamhtAUUGGOP8UvN/9r6daSxbr5hVUep8uhqWytIbAD8jxPxE2NmkQJS6Ad0q0rec
	1kDWRRsQeWnTg2n5xQSJyMYFiFE+JyrsJuCGheWJL1GiZoczw7ijskomJCpHxIMZSvpgvN8MUJV
	ykEWSgzPcmhOEfiuxpcY82Ivmfx1WFoYjTQA==
X-Received: by 2002:a05:7022:517:b0:12b:ee92:a60e with SMTP id a92af1059eb24-12c34e89e20mr6767610c88.8.1776063615726;
        Mon, 13 Apr 2026 00:00:15 -0700 (PDT)
Received: from localhost.localdomain ([154.29.155.10])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c3459f7ffsm12678394c88.3.2026.04.13.00.00.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Apr 2026 00:00:14 -0700 (PDT)
From: Xiaobo Liu <cppcoffee@gmail.com>
To: Allison Henderson <achender@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org,
	Xiaobo Liu <cppcoffee@gmail.com>
Subject: [PATCH net v2] RDS: Fix memory leak in rds_rdma_extra_size()
Date: Mon, 13 Apr 2026 15:00:05 +0800
Message-ID: <20260413070005.15272-1-cppcoffee@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,vger.kernel.org,oss.oracle.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-277964-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cppcoffee@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A2CF13E8094
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Free iov->iov when copy_from_user() or page count validation fails
in rds_rdma_extra_size().

This preserves the existing success path and avoids leaking the
allocated iovec array on error.

Signed-off-by: Xiaobo Liu <cppcoffee@gmail.com>
---
 net/rds/rdma.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/net/rds/rdma.c b/net/rds/rdma.c
index aa6465dc7..91a20c1e2 100644
--- a/net/rds/rdma.c
+++ b/net/rds/rdma.c
@@ -560,6 +560,7 @@ int rds_rdma_extra_size(struct rds_rdma_args *args,
 	struct rds_iovec *vec;
 	struct rds_iovec __user *local_vec;
 	int tot_pages = 0;
+	int ret = 0;
 	unsigned int nr_pages;
 	unsigned int i;
 
@@ -578,16 +579,20 @@ int rds_rdma_extra_size(struct rds_rdma_args *args,
 	vec = &iov->iov[0];
 
 	if (copy_from_user(vec, local_vec, args->nr_local *
-			   sizeof(struct rds_iovec)))
-		return -EFAULT;
+			   sizeof(struct rds_iovec))) {
+		ret = -EFAULT;
+		goto out;
+	}
 	iov->len = args->nr_local;
 
 	/* figure out the number of pages in the vector */
 	for (i = 0; i < args->nr_local; i++, vec++) {
 
 		nr_pages = rds_pages_in_vec(vec);
-		if (nr_pages == 0)
-			return -EINVAL;
+		if (nr_pages == 0) {
+			ret = -EINVAL;
+			goto out;
+		}
 
 		tot_pages += nr_pages;
 
@@ -595,11 +600,20 @@ int rds_rdma_extra_size(struct rds_rdma_args *args,
 		 * nr_pages for one entry is limited to (UINT_MAX>>PAGE_SHIFT)+1,
 		 * so tot_pages cannot overflow without first going negative.
 		 */
-		if (tot_pages < 0)
-			return -EINVAL;
+		if (tot_pages < 0) {
+			ret = -EINVAL;
+			goto out;
+		}
 	}
 
-	return tot_pages * sizeof(struct scatterlist);
+	ret = tot_pages * sizeof(struct scatterlist);
+
+out:
+	if (ret < 0) {
+		kfree(iov->iov);
+		iov->iov = NULL;
+	}
+	return ret;
 }
 
 /*
-- 
2.34.1


