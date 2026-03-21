Return-Path: <netdev+bounces-270221-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WII+GQypvmmJVwMAu9opvQ
	(envelope-from <netdev+bounces-270221-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 15:19:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C41C02E5C16
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 15:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADC02304CA6C
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 14:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82ADE38C420;
	Sat, 21 Mar 2026 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kp+ztG+F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439D4309EE9
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 14:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774102544; cv=none; b=uHNcAPsKavU5Dtp+GsfP2XVwQHUyz/hT6FKWEXw5cg8y99jAgaOFV1WQod/3/41Me3xy+MB0xET1JPGir9qnd00TmEmdY+wZ+eOasyc7xUnFSlczBIFptR5Jma8Z3gTJ4t3wss8/GiDmQpzhwWhu3WObG9lPALrNpRutbLp07Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774102544; c=relaxed/simple;
	bh=S/UgzQXA3QLqhdcPFe6v/HB9WUgH0Mn6KE3pVNm35Go=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dLQ/fSGr9qJtOEsKHfqgAM37IJqlfVy5qY9Lwlop2jXRdrbIyR5e0MouxZTZX1vZ1KqSV0Yw81aSS6RSsTL3TXEc9flWIRgyUV7sqxFeN502OC0nLUnEnO9y+jVybp1qAzl/Eqi5E9ePetoZpS6i4Xd2A0hLr3bTew+PxYqBg9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kp+ztG+F; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a9296b3926so22200115ad.1
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 07:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774102538; x=1774707338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrbOXEwKxG45bbWSYaSRrFiYiD3hpjnUzEitvzAGFtw=;
        b=kp+ztG+FGkm/U2PLlnzBzA+Gg23QetfBREDEvyWPHjQVIdP7gGZfovMdR1w4gYadww
         6GssXfbQqOOpNarqcr5dWzvU/R3U84n7D5h2SGEvY7x/M81DZL2f5xjgGX1YVpb1lIsQ
         X3JEgvdX7V2jzHhNY3T3nwuSvGaaCo/enImymenBTQ4eBtAbewSLrJ6AQH44oSc3Avaa
         T2XT6nxMaGDi8eG51rgswh3XSGBMrmhVsXEszzACIJioSo97tu5pypm3vQaF7+/j68Jm
         T4krEjr5Eu3/AWOwvVrCqsT5HpxzD8/7K8b2xRL8PNZmBjo9Oa9UH3nPBLKbUmqrPjRe
         6/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774102538; x=1774707338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RrbOXEwKxG45bbWSYaSRrFiYiD3hpjnUzEitvzAGFtw=;
        b=Tt8/qURRrINsOTuoiMkuVZalqPp/b10GzUDV219JzRtlYULnKKfOA9aAIKkESeLHuo
         uHTaNTGRaK64Z9yDc5PlCY+BzzSQVwfwuoCj0AWGTPse2R+O/KYbGu9Ax0ivBuYQEou7
         DaZmYmCEL8Uis97YeijxrCszol1qbOOZUf0ISRtWcg5X/PCVdE9dvqgOoXveEJJVanPz
         iOj24Rl/a6LC8RHd+qQGYxAKQb7DR0CUUAGgBjpJO8jf7uxCQ1KqnIq0FXSJFL6KWY14
         /N+dhAhii8ZSnF3QJUTpT4x8k8GubtjH8gazwzknPJgzHQ1JRb5+CAzzaMFv4HWjwXQY
         /MDA==
X-Gm-Message-State: AOJu0YydBg/qEeZJoMB5ewk/mjuc/n44TrsWNEe134j8bOQ0yS+lngLl
	ieYjJAbwANz4Dwz4NXFXMRPnGrjrGNvkVg2etwH/JpFAgw7w7aJSJheu
X-Gm-Gg: ATEYQzy5KkxuA7SM/BFJYdfQwHZ78naBGp1tJzqVl0fImJg26oo5XkE6Yz41B4MW0Et
	if/J14Ng90mUvF1RyeGbqFcZeYFEVg9gaaY/kva8nUPDE9HDULepSdgzypWxwef0gToglGho4ru
	A4xO6x/Oqs2wZO7pJqMUSQeT+BBOGpevim8PJh3Z6fmlfsU5FGHkTb+1EoJWIxMwABlPhbYufQ6
	DvDAy8sVWJfTa1lgJrO8Uxw5xCRXJQ926/h9SEVZaSVl8saeVGDiJxos6KTAqOlfSTAVQlvJYEF
	7464vXv1BQvHsmXP5+hy/T0Mdhp5Ja4CmAzextuIHjzitswBhIvXMDHAXFdUut1RvcMmmCCeX36
	5qWuQg7yRhWOFfYNfi8VQkY+FWiKOz+ZLzWqMEbwZcpJhZo6oJfO0XgQekopgxlaxRy/EeTr0Jx
	/Y3TMFIBm5T+4/2pWQHoWAIfTW3rOgfvWOjq05vaUVxq1yW8+gnkv8wnyBMTtwrN42qa3Bw6g=
X-Received: by 2002:a17:903:2310:b0:2ae:572a:9f19 with SMTP id d9443c01a7336-2b0826fc627mr61129765ad.21.1774102537729;
        Sat, 21 Mar 2026 07:15:37 -0700 (PDT)
Received: from sean-All-Series.. (1-160-226-215.dynamic-ip.hinet.net. [1.160.226.215])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08353e94asm52680715ad.25.2026.03.21.07.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 07:15:37 -0700 (PDT)
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
Subject: [PATCH v5 4/5] nfs: Refactor nfs_errorf macros and remove unused ones
Date: Sat, 21 Mar 2026 22:15:09 +0800
Message-Id: <20260321141510.68214-5-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260321141510.68214-1-seanwascoding@gmail.com>
References: <20260321141510.68214-1-seanwascoding@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,oracle.com,gmail.com,kernel.org,intel.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,intel.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270221-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C41C02E5C16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Refactor nfs_errorf() and nfs_ferrorf() to the standard do-while(0)
pattern for safer macro expansion and kernel style compliance.

Additionally, remove nfs_warnf() and nfs_fwarnf() as `git grep`
confirms they have no callers in the current tree. Furthermore,
these functions have remained unused since the introduction in
commit ce8866f0913f ("NFS: Attach supplementary error information
to fs_context.").

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603110038.P6d14oxa-lkp@intel.com/
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Tested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
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


