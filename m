Return-Path: <netdev+bounces-253998-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOcNDRMbeWmPvQEAu9opvQ
	(envelope-from <netdev+bounces-253998-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 21:07:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 963769A3A8
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 21:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE9E23041D75
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 20:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286F732FA00;
	Tue, 27 Jan 2026 20:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccQldlGq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538EF2848BB
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 20:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769544412; cv=none; b=j8pW399vH4lS2aPYAIfuXIdKUiXLrpP6kKqKSuwzJY0qVmYWhZQ3owtZRM7RpbLdFNr4yzlfbdYtXOTLOHGdYVgomIWiecnKQkDIKIPVKaCZLFTgvkxxCGQ4e4LpOoVVATqWcwsadwZSBbMOdBZvEdjHp/hzfSHoF9vhJpEYzXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769544412; c=relaxed/simple;
	bh=cS3xPt2Uz7dflzBckY+kfYGzoIUu+Qwt+GVL6t7mcF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bP5U43PLc3aeaVPStq0Xrsz/bK6+52ETPYOp6gat+B+70t66AprnVmTHy2YkdbwRnTe+wF4RdtZh5o2Wxj2bqaHpqbiz54fCiOoCSGPpWJzGQHBu3dEsNujKO/GgsswfFCMNkbDUsozfM690IRy6UVOUOI2ptXFNbgmqzL/3hxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccQldlGq; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c537a42b53so833031885a.0
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 12:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769544407; x=1770149207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzavdBuDWuj5ps1qnC4fqx6pxQUMtDYVb/jgTGk4OnM=;
        b=ccQldlGqxZIsHFUkaF8ZuLaA192REjzDbXJeGSLWRrVEtAh8mrZfMa9IEiY6A0w5mG
         TowoWzmvFldzndr5y7/4BFVEI4qtqR8DFlDq22lezCvRILlBRFsIJZjHKd3kkE0IzEGT
         FGw91b3/JrVPBWoz7ANcSPF884i28EXct2ORIP1URIN5rDydeCAjhi1xidtg5sc3TuxX
         WWoBN6UTQh0yG5eANCkTNqrLWCkxLVhTyeO8ZteWGiNxiu2jUWQDaRhcNGvHv2iC3Vgd
         hkR44+I5RpaeQpwCq2QwkQ9XUVVflJhrB6CojXxnMVyXiCCZRkzQ8vgunPbM2NkbWvSj
         PwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769544407; x=1770149207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LzavdBuDWuj5ps1qnC4fqx6pxQUMtDYVb/jgTGk4OnM=;
        b=auy/mW8WsNblQqhiZUzPu3yRdigpKzgZZgfZbsLojiZJ7KRpJvuWJVS/nCbzHcAJuL
         vY84YpzBR69VW2E31qVkk0rFLNzAyiYR2FK3mtjJCI/7kVHHtZdJVdEKphAyC+803wMo
         nSsx8I1+0faOHmkgAoNWQW+yRFtRS3fF9457KdzMeuYYwJjLCpE/x9R+488haLSBkC4A
         l3Dael47NJPf55LGJlIXOyzm3h1f+YliQsbzBlv4WqGRnsOJF0mVY8ffgXDWfZhsLa9l
         v9G1P5ILb2uJ4XMBrJMVIbsdJHrjbJz7VY/oWDP6HsYIMZAr7qT947mIeWYiaV7lGby6
         cOAg==
X-Gm-Message-State: AOJu0Yw5u9BAY/yb+x5rFimhBdTIB/rd3Q75YT3IAXzS0yGjKqRPpdLQ
	k8ihiHFYR0QWBma4Vk0cteNxs+1JJW6BrvemHFSVcJFnYOwnisepTDoDCjgAZQ==
X-Gm-Gg: AZuq6aJbKQzWWpah9nrcFVyo2D2m0Gc+JV4ELCAVfyC/r9hVYaV3c8f7Xk3PelkiDIB
	D7g0iS6ph5+KA+ZlkLDpppPvFjGpwkFVNM3sbA/FzOUKJKBPpDe2PGzl+pQfIz0pSm3pU+uAaAq
	LLcBWXqOJLmREPW+X7zXtgsCo7tA5bEFWFklGtLKOwa0jVIJCnxJgHD90sx5yVf6WxR954wmKKE
	/fjkZWfjcklYGY8O/pyfm9Mxq0veGUWNzrSnviZmwRYP/6T+LE0BeQpLhaFrT80EVSBb2K3rT9I
	DStTTbHHRlSQaqfMHBuKSANXsJDqbKUoCX9X9DFZNWOzM9ndG3ilgdnFXlczUmvH2q+WEcRNmFs
	hp9hW1WjPK9zpNutkwQXQQVe1TAL59OMW7KXb6tjXjOcZBwKB+by2wuO+jnG1evlv4pCv0aSngY
	/Zvi2IwKW2JgnjVl0GeNnMiMSrw3b5VcujC5lnbo+8W9Ya
X-Received: by 2002:a05:620a:7014:b0:8c7:a84:d0fa with SMTP id af79cd13be357-8c70b8fb62amr357150385a.55.1769544407598;
        Tue, 27 Jan 2026 12:06:47 -0800 (PST)
Received: from PF5YBGDS.localdomain ([163.114.130.7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d37420c5sm3450696d6.31.2026.01.27.12.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 12:06:47 -0800 (PST)
From: mike.marciniszyn@gmail.com
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>
Subject: [PATCH net-next 1/2] eth fbnic: Add debugfs hooks for firmware mailbox
Date: Tue, 27 Jan 2026 15:06:43 -0500
Message-ID: <20260127200644.11640-2-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127200644.11640-1-mike.marciniszyn@gmail.com>
References: <20260127200644.11640-1-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253998-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org]
X-Rspamd-Queue-Id: 963769A3A8
X-Rspamd-Action: no action

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

This patch adds reporting the Rx and Tx information
interfacing with the firmware.

The result of reading fbnic/fw_mbx is:

 Rx
 Rdy: 1 Head: 11 Tail: 10
 Idx Len  E  Addr        F H   Raw
 ----------------------------------
 00  4096 0 000101fea000 0 1   1000000101fea001
 01  4096 0 000101feb000 0 1   1000000101feb001
 	.
 	.
 	.
 15  4096 0 000101fe9000 0 1   1000000101fe9001

 Tx
 Rdy: 1 Head: 4 Tail: 4
 Idx Len  E  Addr        F H   Raw
 ----------------------------------
 00  0004 1 00010321b000 1 1   000440010321b003
 01  0004 1 00010228d000 1 1   000440010228d003
 	.
 	.
 	.
 15  0004 1 00010321b000 1 1   000440010321b003

Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../net/ethernet/meta/fbnic/fbnic_debugfs.c   | 50 ++++++++++++++++++-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    |  2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  1 +
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c b/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
index b7238dd967fe..9cdd03bfec34 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
@@ -170,6 +170,52 @@ static int fbnic_dbg_ipo_dst_show(struct seq_file *s, void *v)
 }
 DEFINE_SHOW_ATTRIBUTE(fbnic_dbg_ipo_dst);

+static void fbnic_dbg_fw_mbx_display(struct seq_file *s,
+				     struct fbnic_dev *fbd, int mbx_idx)
+{
+	struct fbnic_fw_mbx *mbx = &fbd->mbx[mbx_idx];
+	char hdr[80];
+	int i;
+
+	/* Generate header */
+	seq_puts(s, mbx_idx == FBNIC_IPC_MBX_RX_IDX ? "Rx\n" : "Tx\n");
+
+	seq_printf(s, "Rdy: %d Head: %d Tail: %d\n",
+		   mbx->ready, mbx->head, mbx->tail);
+
+	snprintf(hdr, sizeof(hdr), "%3s %-4s %s %-12s %s %-3s %-16s\n",
+		 "Idx", "Len", "E", "Addr", "F", "H", "Raw");
+	seq_puts(s, hdr);
+	fbnic_dbg_desc_break(s, strnlen(hdr, sizeof(hdr)));
+
+	for (i = 0; i < FBNIC_IPC_MBX_DESC_LEN; i++) {
+		u64 desc = __fbnic_mbx_rd_desc(fbd, mbx_idx, i);
+
+		seq_printf(s, "%-3.2d %04lld %d %012llx %d %-3d %016llx\n",
+			   i, FIELD_GET(FBNIC_IPC_MBX_DESC_LEN_MASK, desc),
+			   !!(desc & FBNIC_IPC_MBX_DESC_EOM),
+			   desc & FBNIC_IPC_MBX_DESC_ADDR_MASK,
+			   !!(desc & FBNIC_IPC_MBX_DESC_FW_CMPL),
+			   !!(desc & FBNIC_IPC_MBX_DESC_HOST_CMPL),
+			   desc);
+	}
+}
+
+static int fbnic_dbg_fw_mbx_show(struct seq_file *s, void *v)
+{
+	struct fbnic_dev *fbd = s->private;
+
+	fbnic_dbg_fw_mbx_display(s, fbd, FBNIC_IPC_MBX_RX_IDX);
+
+	/* Add blank line between Rx and Tx */
+	seq_puts(s, "\n");
+
+	fbnic_dbg_fw_mbx_display(s, fbd, FBNIC_IPC_MBX_TX_IDX);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(fbnic_dbg_fw_mbx);
+
 static int fbnic_dbg_fw_log_show(struct seq_file *s, void *v)
 {
 	struct fbnic_dev *fbd = s->private;
@@ -249,6 +295,8 @@ void fbnic_dbg_fbd_init(struct fbnic_dev *fbd)
 			    &fbnic_dbg_ipo_src_fops);
 	debugfs_create_file("ipo_dst", 0400, fbd->dbg_fbd, fbd,
 			    &fbnic_dbg_ipo_dst_fops);
+	debugfs_create_file("fw_mbx", 0400, fbd->dbg_fbd, fbd,
+			    &fbnic_dbg_fw_mbx_fops);
 	debugfs_create_file("fw_log", 0400, fbd->dbg_fbd, fbd,
 			    &fbnic_dbg_fw_log_fops);
 }
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 66c9412f4057..1f0b6350bef4 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -40,7 +40,7 @@ static void __fbnic_mbx_invalidate_desc(struct fbnic_dev *fbd, int mbx_idx,
 	fw_wr32(fbd, desc_offset + 1, 0);
 }

-static u64 __fbnic_mbx_rd_desc(struct fbnic_dev *fbd, int mbx_idx, int desc_idx)
+u64 __fbnic_mbx_rd_desc(struct fbnic_dev *fbd, int mbx_idx, int desc_idx)
 {
 	u32 desc_offset = FBNIC_IPC_MBX(mbx_idx, desc_idx);
 	u64 desc;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index b40f68187ad5..8f7218900562 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -94,6 +94,7 @@ struct fbnic_fw_completion {
 	} u;
 };

+u64 __fbnic_mbx_rd_desc(struct fbnic_dev *fbd, int mbx_idx, int desc_idx);
 void fbnic_mbx_init(struct fbnic_dev *fbd);
 void fbnic_mbx_clean(struct fbnic_dev *fbd);
 int fbnic_mbx_set_cmpl(struct fbnic_dev *fbd,
--
2.43.0


