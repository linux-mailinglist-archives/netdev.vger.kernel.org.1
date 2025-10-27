Return-Path: <netdev+bounces-233247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E81C0F357
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 17:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73DE55613E7
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 16:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689A63101C0;
	Mon, 27 Oct 2025 16:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYb0q1IV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBD530FC04
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 16:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581334; cv=none; b=cxayDdNBHx7W34geZ9hVl6D5k/QwRYcZ7NV9TV8KK3pGoqvAMSQ+Uv27GwyQeCdQhuS7cUG/IPcLcrO5jq1eRFWZeWzwl0jabrEcb9oJjpf0wSTxIVLb7rxWG/pFp7ljT1KaZqPvwNy00D+267ZSdyZLiceMYhUzBx+0BZOrivc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581334; c=relaxed/simple;
	bh=fbDYJN+jZ1MymhQBKdbPsKqGnPjINAkJQJSVn0S5FIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CqoKY4yk/BqXUb0RYp+m1cndIbM4L0gb3Qqdb0HC8QSTqbh9HKioJNtLZVWybDM13RiBmWbkM8dEAa9ByQ+oyTp87k6tM90kwZLIvZeznj98wDReEsFqKrzz4lj431zkqVzx8BgnjQBDaWLOyI6iMxbWnY0QYtM2Sxf2M8xh6jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYb0q1IV; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4285645fdfbso696752f8f.1
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 09:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761581331; x=1762186131; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9+nFHdhEn9QZ3B5n0rJ6cFeS3k3aD4NWWF/na73TE3A=;
        b=PYb0q1IVThG2gforkbn221N9SuOGwPTNqCwPYpt2chtnp2KAruh/zvSb/7WnIfj7Wv
         xQwEfj6XjJAh2Q7pBfQP3EKxNJdn6qEMEa67tlJvl6EP5Or8Fs031Ll70OSjniakdPt5
         EpEnmPKf3T5vhXK3OCpvtPMBvo6wxZH5gudYfF79sZXiTa9PMtoj9Bd4jzry/wM/6VvL
         MgaoyehauUuwjHGz1APWbfBxDixEXlJttQrFTAn9hKV46t0OKfK9cDuU5Gbk1uI1U/U9
         /CO8choEB6fGnOWV37V9489zWFLg3RdYbJPRaYB82g2u3CnlFz56NBoNMS4XEKlIYLVk
         P58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761581331; x=1762186131;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+nFHdhEn9QZ3B5n0rJ6cFeS3k3aD4NWWF/na73TE3A=;
        b=vswRC3qBUwxhkmO9dHsuQKO80I5AGI8LfWZRpOAAR4fD5svdulmXxL8UWYA6BTHgQ1
         90ujZFYq27drQJPBXMVvEVLMKveSElb0yT/hxjA8+AVZofdn9b+5q92DSWT2Zg8YEIY8
         f7AYNbZxTEdnN85KqSspa+w5slkCF7WMIMtvvuwQEf46qdBPZ6zxooz7hg4zMuoJboiY
         kAaoT2fgFEbTppSHYmrb1bMZ/iF0GdMlIPPOqcb/KL2skR+FvcdYJR5K4RsSL/8Ly02x
         1M8BBytEwcQSFsgNHsYb/PRxz8zMS1yioppjjYe5UMpX99aWwCSVj8lGtxbZVnFVk54u
         hUcA==
X-Gm-Message-State: AOJu0YzD3kSR9kKkLcZGAp3KOfcJqbfNfB+Ae5IOZcA6R0+O/eRluItc
	ndRUbcbJZU5BaVw2iCAKU6bH+WXZaYovkHL1BKRIlh9heUSAAlHN0f8L
X-Gm-Gg: ASbGncsuQg14EzLOfSkF3/zUa8DaXoJobHOSp+/NXH0U1Ddnj+ouC/goOAu2juMglnr
	54dDZVlINL31uQFGHd3khGsVZEVcIXB3ry6Ee8TtMCYAWwAT4uZrIp0EBicAtb2U0wQ2EU/xzna
	uUqKCaUDwtYKNCLJNZnh0xOw9+dyxkSyACiuQEOpN7laU5Gne+XwlV20JSDMhi9bWhwKCI7aybh
	laKTh4hB89W4nssq0BdbIRybhAMG2l/oEwF8Bdi3wMCCx2cg5qnfpQuOUiAXl9jsdI2T6Q3CsbL
	rZNOMpzxc/e9br2UB8zrF11xyZZ6rv8HupQs2PzVllahQ9mr/JGgUuCyTnEYWu9euLavAl8UTOU
	Ukcgm5AJPCml5ozssTOHm4P25IbW5GTJ3T/ydy3ZviH/G0WCouKie5AsIfsEoUsrKonMVTJ5iqn
	lSIstB9s9JPtvrXtY=
X-Google-Smtp-Source: AGHT+IGvrhg+F72g/BI8ulMkITIB/tcbuDwYGmTzwpOa/eEfVBRFpcZ01FZkRBh2w0gLtr8yteHE+w==
X-Received: by 2002:a05:6000:2911:b0:3ed:e1d8:bd7c with SMTP id ffacd0b85a97d-429a7e35d6emr137633f8f.2.1761581330612;
        Mon, 27 Oct 2025 09:08:50 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:58::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952db80fsm14663359f8f.31.2025.10.27.09.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 09:08:50 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Mon, 27 Oct 2025 09:08:11 -0700
Subject: [PATCH net v3] netconsole: Fix race condition in between reader
 and writer of userdata
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-netconsole-fix-race-v3-1-8d40a67e02d2@meta.com>
X-B4-Tracking: v=1; b=H4sIAOqY/2gC/22NTQ7CIBCFr9LMWgwdiqgr72G6QJxaEgsGSKNpu
 LsT4tLd+8n73gaZkqcM526DRKvPPgY2ateBm214kPB39oASdS9RikDFxZDjk8Tk3yJZx2I46Em
 ZmzZkgZevRNw16hV4ACOHs88lpk97WrFVPyj+ha4opFDK4NArdZTmdFmo2L2LC4y11i9796flu
 gAAAA==
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

Fixes: df03f830d099 ("net: netconsole: cache userdata formatted string in netconsole_target")
Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
This patch fixes a race condition in netconsole's userdata handling
where concurrent message transmission could read partially updated
userdata fields, resulting in corrupted netconsole output.

The patch fixes the issue by ensuring update_userdata() holds
the target_list_lock while updating both extradata_complete and
userdata_length, preventing readers from seeing inconsistent state.

Changes in v3:
- Drop testcase.
- Link to v2: https://lore.kernel.org/r/20251022-netconsole-fix-race-v2-0-337241338079@meta.com

Changes in v2:
- Added testcase to Makefile.
- Reordered fix and testcase to avoid failure in CI.
- testcase: delay cleanup until child process are killed, plus shellcheck fixes.
- Link to v1: https://lore.kernel.org/all/20251020-netconsole-fix-race-v1-0-b775be30ee8a@gmail.com/
---
 drivers/net/netconsole.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 194570443493..1f9cf6b12dfc 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -888,6 +888,9 @@ static void update_userdata(struct netconsole_target *nt)
 {
 	int complete_idx = 0, child_count = 0;
 	struct list_head *entry;
+	unsigned long flags;
+
+	spin_lock_irqsave(&target_list_lock, flags);
 
 	/* Clear the current string in case the last userdatum was deleted */
 	nt->userdata_length = 0;
@@ -918,6 +921,8 @@ static void update_userdata(struct netconsole_target *nt)
 	}
 	nt->userdata_length = strnlen(nt->extradata_complete,
 				      sizeof(nt->extradata_complete));
+
+	spin_unlock_irqrestore(&target_list_lock, flags);
 }
 
 static ssize_t userdatum_value_store(struct config_item *item, const char *buf,

---
base-commit: 84a905290cb4c3d9a71a9e3b2f2e02e031e7512f
change-id: 20251020-netconsole-fix-race-f465f37b57ea

Best regards,
-- 
Gustavo Duarte <gustavold@meta.com>


