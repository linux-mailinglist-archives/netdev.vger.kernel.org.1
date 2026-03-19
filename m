Return-Path: <netdev+bounces-269460-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBe0EKoIvGkArgIAu9opvQ
	(envelope-from <netdev+bounces-269460-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:31:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC372CCD8E
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C295B3010686
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 14:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FD632E69A;
	Thu, 19 Mar 2026 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W82Arv4k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF3A371040
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773929947; cv=none; b=IA9qXLHGscrldMY7nVEfqZLnm1JQTK1asIOiGuGfRMNgaZcwApa9FaMD00ieZZ6N0lxnzWGVL11zfpY0auA9rqM4yVu3EiAdShgR60BH6gyj/qCf7AC2+sev2KrPtwEEmpGi64Q4vttGWyYGbqMDQuhK/GYgVX4xt5hJ+xlLk3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773929947; c=relaxed/simple;
	bh=LyOAcv8pOrNZtKwp9vpRm97qmAqdwUyyyBfIQEjIiu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WlmlKu1qabkU/qMIUf0PG5HQpIPzN/tM0FsihAINhS98994z7ze8QlpfnCHSlZ7hH6/kVVAwQrHagS6fXvKfRrpV7vIGBxBTDX87GeNIZu36YF7RT7NpYkuZ79l9kxgEMmzM+wtmQ+1nJ7gi7zKDX1ihISjT2S/d/cr6oa4q9LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W82Arv4k; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-359f35dfef6so579704a91.2
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 07:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773929945; x=1774534745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Juaqw75BGT6mprObL/AlBCbjvTBGCqm62mz9LEt4i84=;
        b=W82Arv4kxLwqLKYHBB/lchtnVYurezipBWqBFyKDxSwo/HTQ51mxBuVe3Z0pzSPG4X
         JfeYCRB9EGUuK3aZ6po5Ng/l/sgotiyxNtU7qoexZ6BW83PQN3/8rrwxC6XK5gZxkylx
         Df7OBNFbqXATubwo/KvBpGliLe/0q6amFmc45DoWFlXEAgnNBP5djdnTc87N1zoXF3hg
         OR9UyqDIGnABl8YwlJ/uBXoLcNdSzpGYYKldw5by9gDiiVNUIfTy6qEBMN4raf22C1LY
         VJ8BLJaePMS3atG0szN1ZlZY9JVYKiu42GToApobB2i2LrdVkW421yxBP1DBgZFmBM58
         W6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773929945; x=1774534745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Juaqw75BGT6mprObL/AlBCbjvTBGCqm62mz9LEt4i84=;
        b=DZvE3zwbBzJMtOBuXDYTrc0MLS6KPqEgV4PcxPxgx62kJ22s9ulb849cKtlC6w3vMi
         GhJKGQTBhVUvdZo7V333Af5HoYTW++TDHt/w8s06e92wsm7UQeG0K3L2du+pt0WYLspt
         I33mE8kUCPgHvV1N3U0dsk4P1OZUBeCRrCd8KQgEMEKrb4DuUCV+E1TnTEUuqz4/LcnY
         UT8LGVQ1GsO+V9SwWu9XJ9hQHXT1bLndOFniWgM9YqpurOGtYJT93PHQf5BoMSgCBC57
         HLVvjmfazg9Rf2Lt1IsOZcFyzI9d7bXVY3WJ2VIGJS4qUJlUjlMRM6ajcJ5u8Z1YjzR/
         B1Vw==
X-Gm-Message-State: AOJu0YyCi+5q8QLBzXe9ydkrAI9DCb+vHaRhVKl+M1diQDggKIdfBB2h
	f2/FEECmnWMGWDHz2OavzK2HXGS2fKKwDI5j/rVQ4fB/UrobdbguNT1u
X-Gm-Gg: ATEYQzx5A183XMXWU6J4uXk2J/1jmZFmnDh4NWknKadsg451dlpY3jeKvlmfqdk2ZGy
	CDpau2XjzsutQ6kuws4AEy0SStgwy4Mgo3bedhyIWBXPIdKajzsUOOZw8DevKFMNVOCp65LVOeG
	WrIZ1qiV9EVEac9aNKAM5iyGpDGwEx9GQ07voLXjvPD5zPcFJGEDU1cwN52o6+o/XYuidmRD2JO
	YqHMucKqgqHJ1ks0lviS1od0gyxTmm46yGexj3lCdpHir/VfPgl45dtVmL5+SNjyqW5+7+nukS1
	NNZx6Kx2K7ah2xgm/mpCZaTYVAd6PdK4QvLOJSHPGxqGYAdPH9TlHVFyaRmUKmDYcW7SoRloOpn
	Kq33mRpBiCN2KKDD8rhZAxB4XbQ/3Gs1Nkpx7pA2kNnwcNfgYW/pAPJCBiAxQM8I4q5TW7w9M9i
	JogEfBRgEkTOXcpcrxWfBOY0vN+RNSOFd/ciVUBUslFA9JWnTHv7mFgzQAnO3L0TNz8CYdLGw=
X-Received: by 2002:a17:90b:3d8e:b0:359:f2e1:5906 with SMTP id 98e67ed59e1d1-35bb9e456a3mr6473615a91.4.1773929945118;
        Thu, 19 Mar 2026 07:19:05 -0700 (PDT)
Received: from sean-All-Series.. (1-160-226-215.dynamic-ip.hinet.net. [1.160.226.215])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc63286ebsm2695321a91.17.2026.03.19.07.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 07:19:04 -0700 (PDT)
From: Sean Chang <seanwascoding@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Chuck Lever <chuck.lever@oracle.com>,
	David Laight <david.laight.linux@gmail.com>,
	Anna Schumaker <anna@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v3 3/3] nfs: refactor nfs_errorf macros and remove unused ones
Date: Thu, 19 Mar 2026 22:18:46 +0800
Message-Id: <20260319141846.78222-4-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319141846.78222-1-seanwascoding@gmail.com>
References: <20260319141846.78222-1-seanwascoding@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,oracle.com,gmail.com,kernel.org,intel.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,intel.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269460-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.769];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 4BC372CCD8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

refactor nfs_errorf() and nfs_ferrorf() to the standard do-while(0)
pattern for safer macro expansion and kernel style compliance.

additionally, remove nfs_warnf() and nfs_fwarnf() as git grep
confirms they have no callers in the current tree.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603110038.P6d14oxa-lkp@intel.com/
Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 fs/nfs/internal.h | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 63e09dfc27a8..59ab43542390 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -161,13 +161,19 @@ enum nfs_lock_status {
 	NFS_LOCK_NOLOCK		= 2,
 };
 
-#define nfs_errorf(fc, fmt, ...) ((fc)->log.log ?		\
-	errorf(fc, fmt, ## __VA_ARGS__) :			\
-	({ dprintk(fmt "\n", ## __VA_ARGS__); }))
-
-#define nfs_ferrorf(fc, fac, fmt, ...) ((fc)->log.log ?		\
-	errorf(fc, fmt, ## __VA_ARGS__) :			\
-	({ dfprintk(fac, fmt "\n", ## __VA_ARGS__); }))
+#define nfs_errorf(fc, fmt, ...) do { \
+	if ((fc)->log.log) \
+		errorf(fc, fmt, ## __VA_ARGS__); \
+	else \
+		dprintk(fmt "\n", ## __VA_ARGS__); \
+} while (0)
+
+#define nfs_ferrorf(fc, fac, fmt, ...) do { \
+	if ((fc)->log.log) \
+		errorf(fc, fmt, ## __VA_ARGS__); \
+	else \
+		dfprintk(fac, fmt "\n", ## __VA_ARGS__); \
+} while (0)
 
 #define nfs_invalf(fc, fmt, ...) ((fc)->log.log ?		\
 	invalf(fc, fmt, ## __VA_ARGS__) :			\
@@ -177,14 +183,6 @@ enum nfs_lock_status {
 	invalf(fc, fmt, ## __VA_ARGS__) :			\
 	({ dfprintk(fac, fmt "\n", ## __VA_ARGS__);  -EINVAL; }))
 
-#define nfs_warnf(fc, fmt, ...) ((fc)->log.log ?		\
-	warnf(fc, fmt, ## __VA_ARGS__) :			\
-	({ dprintk(fmt "\n", ## __VA_ARGS__); }))
-
-#define nfs_fwarnf(fc, fac, fmt, ...) ((fc)->log.log ?		\
-	warnf(fc, fmt, ## __VA_ARGS__) :			\
-	({ dfprintk(fac, fmt "\n", ## __VA_ARGS__); }))
-
 static inline struct nfs_fs_context *nfs_fc2context(const struct fs_context *fc)
 {
 	return fc->fs_private;
-- 
2.34.1


