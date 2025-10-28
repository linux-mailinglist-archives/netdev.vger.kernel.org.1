Return-Path: <netdev+bounces-233664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AFEC17221
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 23:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6FA6D4F1A2E
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 22:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FA9355818;
	Tue, 28 Oct 2025 22:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHW75JCN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9653557F1
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 22:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761689220; cv=none; b=iwf8IuY6uJW6k30cUUEtYeaGFE+3YRAwpftpzrxm6j0jzBqHbRcOROJl/QkR8EbN858jpZ/4+2JtqQ9wtxt8dLXaCjQORP8fWmhPkFb/ri6jGcPcXQM83BO9IcciNo5vSrmQrOqYiUrrMugr7BMJVxchSMDfvLXo4axa5XvAeDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761689220; c=relaxed/simple;
	bh=Wwnj1RJDEEH7kNnG3Exp5wbrfFvOh6M5yBUjVOuQzR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cbxaTY8UJpCeLDB3GbCBHsOFlXxL60L5p3EdptATfs6o3Jqov2nHJk79FIgr60qWIoLhs4tzx5HmtAN7GGyCfLHoHgs+RhOtgrdhmAvd5/4shKSVs9buo7uz3PPFbXWnwLM7uNluW7IYdjQ7/TAulgbLYqdLCB3jf2mqQTchH4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHW75JCN; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3fffd2bbcbdso437879f8f.2
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 15:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761689213; x=1762294013; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RRXfwTdqAHsi2uCJ8KceGlZlVmKcYCN3Wqr2dA2XgsY=;
        b=iHW75JCN+JWaOSgNd1erUBExxgs+Qj3frYJly98ocygAaAaZRokS4okiS06x1gkBTn
         JbLuJ19zWOtUtBNBz5p/wdfJuyZReqRBaZFfqKDYYZFvFPCkA1aHW/ye7S58jjlB8Hf9
         fGC9rOyxAnm2uDnq5fjCfZ43GjMHuD/Ynv5pbgSx97wMi+CELRBw6s+4KY/jh+e3ylor
         weyqdmPCu4L+03vN3UNg8CYRlRejUkHF5YWf8rYcGcNa0gs7nyovjval7nmSAgnMJ0j7
         PmzODpLYOWVs2xD1GZ0/xKsAY2r0Z6u801pdQJAIlLL4YoN2h/jGQMv942sRsfGYxlgz
         w1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761689213; x=1762294013;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RRXfwTdqAHsi2uCJ8KceGlZlVmKcYCN3Wqr2dA2XgsY=;
        b=p4ExGZ4U+QwdYLGQBdF3GQKDVPYW8ouLILqK2+MP02g5zNwa1wg1fUNPONfQ8wFxtC
         L3rYvrd4+ldZyAlSEBCmL8oaOByQDwGL2kgEGqxfs7wNlJCT6orwLLLVjo2Hj0tMab4u
         Mzc17u03luBgYRuXG9ZPE+2BBN+TZboNATsl7MHucfQOKi8Cc1vKRezIAtd2Xq+C1JfY
         bukpR5KrBSwJ/LIwjxlxiI9RV0BCl5Zk0icwzmHyN1WTbsL4cLei8M2faOV+okk5YHSR
         puOUq5RKt+UqR71N9ajQEABcP3BzW62BHeVtTRF/H/5ZkyAouq4PgqK7oVBnSI9cdDxa
         LHSw==
X-Gm-Message-State: AOJu0YzZE5YmMgIr+nWO1Tzqeii4cEruyrmyyoglQ//cguAOtEgbTTsq
	wO/+Y4IY9X18Xz+/iSbKG+pHaTkgPCthNZ7XOXCqPYgRF9oOVCpOP+cx
X-Gm-Gg: ASbGnctoy7j+Kbrn/0fJTaPBAVEavTBqz6OPcnhT6dZlVcAzI1jscqUDRro/bzTjisJ
	xaydpB7ZTZGi83QDxx3KDuMJR3QYA3tPKFt95B0G8wXJsW0Q3/4RDKaUsFslCPAChqWpw4K6vnD
	uHfNSFlI/lRsc9REMmPwWfE5N5yLNRTqT8cfFnlXVnGoriuVg8XlzBFVCL/nBC6o+tw2+s/fLqi
	TKtJSYSkXiyKUVfhlSo+INaxAchSWrvMblUpAabzByFtxMW40J9wmuw7ZVddzGgWLWl6fydOIsc
	eW/63UC5UjWO1Z8Ib4J0pfk1hpJdyvJQDL1NkWUae3cGNt1fWema3UQpxM5Ll5NU9p+8KGBo19j
	Fomh6YBt/Obz2H8yJ+Bl8WrBEAVXvRWGiGwVl18nkybWgU/NY4+B0CYrgInpM/NQGQ6n5H7sfuR
	ea+sFQ
X-Google-Smtp-Source: AGHT+IF1chgC33kvFN4rIJiWEFsZev65rNr2rCfRs36/VyXkv4r/1FvebOBJNEzWYPGfZIUQ5yYJDg==
X-Received: by 2002:a05:6000:288a:b0:429:8e79:a19d with SMTP id ffacd0b85a97d-429aefd2ed4mr259766f8f.10.1761689212570;
        Tue, 28 Oct 2025 15:06:52 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:48::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7b22sm22241724f8f.9.2025.10.28.15.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 15:06:51 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Tue, 28 Oct 2025 15:06:32 -0700
Subject: [PATCH net v4] netconsole: Fix race condition in between reader
 and writer of userdata
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-netconsole-fix-race-v4-1-63560b0ae1a0@meta.com>
X-B4-Tracking: v=1; b=H4sIAGc+AWkC/23NwQ6CMAwG4FchPVszusHQk+9hPMxRZIkys5FFQ
 3h3l8UDB25t//xfF4gcHEc4VwsETi46P+VFHSqwo5kejK7PO5CgphYkcOLZ+in6J+PgPhiMzYN
 qm0Hqe6PZQG6+A+esqFfIBbjl4+ji7MO3fEpUoj9Ku2giFCilJlVL2Ql9urx4NkfrX4VLckvof
 UJijV2vhGk1C+ppQ6zr+gN4NDq2/QAAAA==
To: Andre Carvalho <asantostc@gmail.com>, Simon Horman <horms@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthew Wood <thepacketgeek@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

The update_userdata() function constructs the complete userdata string
in nt->extradata_complete and updates nt->userdata_length. This data
is then read by write_msg() and write_ext_msg() when sending netconsole
messages. However, update_userdata() was not holding target_list_lock
during this process, allowing concurrent message transmission to read
partially updated userdata.

This race condition could result in netconsole messages containing
incomplete or inconsistent userdata - for example, reading the old
userdata_length with new extradata_complete content, or vice versa,
leading to truncated or corrupted output.

Fix this by acquiring target_list_lock with spin_lock_irqsave() before
updating extradata_complete and userdata_length, and releasing it after
both fields are fully updated. This ensures that readers see a
consistent view of the userdata, preventing corruption during concurrent
access.

The fix aligns with the existing locking pattern used throughout the
netconsole code, where target_list_lock protects access to target
fields including buf[] and msgcounter that are accessed during message
transmission.

Also get rid of the unnecessary variable complete_idx, which makes it
easier to bail out of update_userdata().

Fixes: df03f830d099 ("net: netconsole: cache userdata formatted string in netconsole_target")
Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
This patch fixes a race condition in netconsole's userdata handling
where concurrent message transmission could read partially updated
userdata fields, resulting in corrupted netconsole output.

The patch fixes the issue by ensuring update_userdata() holds
the target_list_lock while updating both extradata_complete and
userdata_length, preventing readers from seeing inconsistent state.

Changes in v4:
- Avoid calling WARN_ON_ONCE() while holding the spinlock.
- Link to v3: https://lore.kernel.org/r/20251027-netconsole-fix-race-v3-1-8d40a67e02d2@meta.com

Changes in v3:
- Drop testcase.
- Link to v2: https://lore.kernel.org/r/20251022-netconsole-fix-race-v2-0-337241338079@meta.com

Changes in v2:
- Added testcase to Makefile.
- Reordered fix and testcase to avoid failure in CI.
- testcase: delay cleanup until child process are killed, plus shellcheck fixes.
- Link to v1: https://lore.kernel.org/all/20251020-netconsole-fix-race-v1-0-b775be30ee8a@gmail.com/
---
 drivers/net/netconsole.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 194570443493..5d8d0214786c 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -886,8 +886,11 @@ static ssize_t userdatum_value_show(struct config_item *item, char *buf)
 
 static void update_userdata(struct netconsole_target *nt)
 {
-	int complete_idx = 0, child_count = 0;
 	struct list_head *entry;
+	int child_count = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&target_list_lock, flags);
 
 	/* Clear the current string in case the last userdatum was deleted */
 	nt->userdata_length = 0;
@@ -897,8 +900,11 @@ static void update_userdata(struct netconsole_target *nt)
 		struct userdatum *udm_item;
 		struct config_item *item;
 
-		if (WARN_ON_ONCE(child_count >= MAX_EXTRADATA_ITEMS))
-			break;
+		if (child_count >= MAX_EXTRADATA_ITEMS) {
+			spin_unlock_irqrestore(&target_list_lock, flags);
+			WARN_ON_ONCE(1);
+			return;
+		}
 		child_count++;
 
 		item = container_of(entry, struct config_item, ci_entry);
@@ -912,12 +918,11 @@ static void update_userdata(struct netconsole_target *nt)
 		 * one entry length (1/MAX_EXTRADATA_ITEMS long), entry count is
 		 * checked to not exceed MAX items with child_count above
 		 */
-		complete_idx += scnprintf(&nt->extradata_complete[complete_idx],
-					  MAX_EXTRADATA_ENTRY_LEN, " %s=%s\n",
-					  item->ci_name, udm_item->value);
+		nt->userdata_length += scnprintf(&nt->extradata_complete[nt->userdata_length],
+						 MAX_EXTRADATA_ENTRY_LEN, " %s=%s\n",
+						 item->ci_name, udm_item->value);
 	}
-	nt->userdata_length = strnlen(nt->extradata_complete,
-				      sizeof(nt->extradata_complete));
+	spin_unlock_irqrestore(&target_list_lock, flags);
 }
 
 static ssize_t userdatum_value_store(struct config_item *item, const char *buf,

---
base-commit: 84a905290cb4c3d9a71a9e3b2f2e02e031e7512f
change-id: 20251020-netconsole-fix-race-f465f37b57ea

Best regards,
-- 
Gustavo Duarte <gustavold@meta.com>


