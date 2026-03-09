Return-Path: <netdev+bounces-265525-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOohOei7rmn6IQIAu9opvQ
	(envelope-from <netdev+bounces-265525-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 13:24:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F412238BFD
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 13:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2323C30E95A2
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 12:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB7A3A4F2E;
	Mon,  9 Mar 2026 12:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsgKK1Ci"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F263A9015
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773058369; cv=none; b=Snb+PUpFON8bKG+UQiR6prJ1zNGGUFZLX+mt0UQTxJLh2pJnln3VuOU9ZyPHIhO16Mz8UBRLTRt6HXWXGL6sbWFMURIWieshPfxHvzB1pBh/O4ne0OcIp48luBscFst07rnruaAbU2ji+JpLV4yBuLZPBlYM5PYisOqTfNqc1jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773058369; c=relaxed/simple;
	bh=mK8ba0zQUtMMWmfrPH0LzLNN7RK7BfVtsz0sSCJ89DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L3bn7hwvFXb5Y3RKv5idEVmsz2s0TRR4RaZNb890OoCyv6kmxbobhS0X/o+R9Hxw10o5e5bIrQ81LWIhMxQSGLJVXgAi4ULuvE1nPjOaP2tiNBGvAibBa5IH+4JPMgmTdSlaFrMfzSDxFseR+VQHduy0nn90MTPMXRNP8Mk5S1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsgKK1Ci; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-89a465bd7edso9258916d6.0
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 05:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773058367; x=1773663167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RmEaX9ELRnGJqvenm9+FC9k70ngtQcC8pzYFVYzrDy0=;
        b=XsgKK1CivjPd+LsM2k2pMNNI1ZJrMd3ikINEN6TjMbV6ub8S4mJBfpboH0YEPBwjEG
         CRt5ysonyHXell4RuHCY95D4sHa6opv8oLQ0mgYYSP8quhVpVhM26u1yLKGiTeNq3+K1
         P+YY1V/P97WRXGxP6Pdg+mejMjyySXZTt7ns/cyKaNx25lSgTTCeBvkCrZrFgjt3E6sX
         1yP5LtqH7QQn8Jq5CkDO4ONtQu45XrnqAJG8hyy4hyV09vMLQv2wQclFs3RxUUUZYnaC
         KEIQBRHGoRe9dxQCnl9ue475aHhtOCrwWf/xp/ODncuUEqOjJYZMX62rEvPPny3PRm7C
         Q2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773058367; x=1773663167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmEaX9ELRnGJqvenm9+FC9k70ngtQcC8pzYFVYzrDy0=;
        b=uz0vZX6tbstdFft+QkiMmPkIlQ4lBd6JlYpnTkoWGAaskvMbhrRJg/jdeybVqqG48c
         WhOohBYVSVKC4r9qc9IfqofqZD6D/kxQFPQtaHYyHn3UbMRxlYMwmL3xP4whBBzaF+/i
         Qfk2PrCzJUmYxIwYM4mXoTxLZepfcJVjqlhpADB4pF6QjqVojKxpfvDT4frCrj0F8+y+
         j9nggh1Z0lBGMU1zdfVk2AQEXwWPNg94+aTk0HRWQq3jXeEqRLSjoCoX1I45rkYgES0L
         ofEU27qQvMMmMTBnCcRSH+5e1T9iyHrqJmfB2LAUoAya2q00MnxlE+QJKLt3UTCD19D9
         PHHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzF7NZiABdYDRy5DZDUzi/GHsQpDlSSUpZjaO3JcwJDpBEEYOiRkZifHwCmtcp+r69tfCw3iI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7WqagS6xjyQHAn5SIqpcmYxvKGLEMunuOSYXth/uQpWI0KGJ8
	GwDvDVDZ7xLrjuSjP14UR8AzGxF4p2XCLWyhk+w+traxPV/nQXTY/yW8
X-Gm-Gg: ATEYQzxl9/NohZ0qNZjVLd8S9o9DIKpnzzGvxtWO5N/UVfJrSbX6qGh6CuY9Qsmwl1o
	QF0d3pKM6gK8xHvYPiOmhqCtweY0S3ZSoKQ+vT2IIqvMv7wjQxhPSbsyC/S4OK6DjhyWnYJClz+
	dDhsl0KZWxaImcjosz3JtlEUhk7NhFxRbWhsIptDOxNlt/AaHgNbQWPDws+ULGV9Lc9uDOTfybv
	ujQ0RawQuecmemM3sAlY3MUbOFA7aAUNY7rY1u7QLeRnXt2EvWmFYjL99Zi05UxZKT89uDnvj1M
	4CxQFSx1F0Qx8o6ZoYM87Qwd5vMCmc1EL6CKqj/5BebVXF/JbmM0Iaie9b52QT0iGQReegVrl/k
	0gIrafcjAR7QHEl/hj6A/lle/YeuWcVmU1c4jLa/IhwO1KnF2iErxISRJ/A5V8WC7wS1uULFJwL
	AAezUDFYyiY8Ytc67gk+LDTktrjqS2wZA8WMWoRmEDE6W1W6vrQXUMofFws/ZzkpU=
X-Received: by 2002:ad4:5d42:0:b0:899:f24d:1243 with SMTP id 6a1803df08f44-89a30a9e980mr164604486d6.37.1773058367505;
        Mon, 09 Mar 2026 05:12:47 -0700 (PDT)
Received: from cr-x-redhat96-client-2.fyre.ibm.com ([129.41.87.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a316d86ddsm72715236d6.26.2026.03.09.05.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 05:12:46 -0700 (PDT)
From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
To: leitao@debian.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org
Cc: davem@davemloft.net,
	pabeni@redhat.com,
	john.ogness@linutronix.de,
	netdev@vger.kernel.org,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: [PATCH] netconsole: Fix compiler warnings when PRINTK_EXECUTION_CTX is disabled
Date: Mon,  9 Mar 2026 05:12:33 -0700
Message-ID: <20260309121233.135231-1-chelsyratnawat2001@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3F412238BFD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,linutronix.de,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265525-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chelsyratnawat2001@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

The netconsole change that started using nbcon_write_context for CPU
and task information assumes CONFIG_PRINTK_EXECUTION_CTX is enabled.

However, when this option is disabled, struct nbcon_write_context does
not contain the cpu and comm fields, causing compilation failures:

  error: 'struct nbcon_write_context' has no member named 'cpu'
  error: 'struct nbcon_write_context' has no member named 'comm'

Guard access to these fields and fall back to raw_smp_processor_id()
and current->comm when PRINTK_EXECUTION_CTX is disabled.

Fixes: 79ba362b4337 ("netconsole: Use printk context for CPU and task information")
Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
---
 drivers/net/netconsole.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 3c9acd6e49e8..bbd39b2e7a36 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1494,17 +1494,30 @@ static void populate_configfs_item(struct netconsole_target *nt,
 static int sysdata_append_cpu_nr(struct netconsole_target *nt, int offset,
 				 struct nbcon_write_context *wctxt)
 {
+	int cpu;
+#ifdef CONFIG_PRINTK_EXECUTION_CTX
+	cpu = wctxt->cpu;
+#else
+	cpu = raw_smp_processor_id();
+#endif
+
 	return scnprintf(&nt->sysdata[offset],
 			 MAX_EXTRADATA_ENTRY_LEN, " cpu=%u\n",
-			 wctxt->cpu);
+			 cpu);
 }
 
 static int sysdata_append_taskname(struct netconsole_target *nt, int offset,
 				   struct nbcon_write_context *wctxt)
 {
+	const char *comm;
+#ifdef CONFIG_PRINTK_EXECUTION_CTX
+	comm = wctxt->comm;
+#else
+	comm = current->comm;
+#endif
 	return scnprintf(&nt->sysdata[offset],
 			 MAX_EXTRADATA_ENTRY_LEN, " taskname=%s\n",
-			 wctxt->comm);
+			 comm);
 }
 
 static int sysdata_append_release(struct netconsole_target *nt, int offset)
-- 
2.47.3


