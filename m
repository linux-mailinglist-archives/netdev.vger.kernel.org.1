Return-Path: <netdev+bounces-285399-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6F8sBFGz/GnlSgAAu9opvQ
	(envelope-from <netdev+bounces-285399-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:44:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B344EB45C
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 998EE301CCEF
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 15:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B42F436373;
	Thu,  7 May 2026 15:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NulYzmp8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E785931E846
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 15:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168528; cv=none; b=M6HDSpYEYaocuSO6/9w+yb62wNfcMnJ95NYtCpvqaP7V2Ao+esR24hB436rqpJ7yma/83kBBNcJhIXZ77Yd+IqNOWJ56atuMc4D17omGNR7wTOaDQJTTHVnkQcT3vrZNxrhizH2C37nlcuB4UMTZlqjmwcQMU4AYUIvJBKyZfYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168528; c=relaxed/simple;
	bh=kWMsC60KuOenv/OhjsZywQS1is+m2U13eftrFS6m3XU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XJ2zDrITcSW1Z5fRJc/Un7Omu9/J9qzka0FxjM0oxqnKthuIvZA05n81J1W86bJ3+PTeM+aTgBwQnIw5r5AITAvCKdiz+lLZooQv3T1rNUVk4lkKi7M+ydGYXmEiWjZGbaAwTzAe6sZGTX9+dQu8osDK2ugLmHFPqsIrEhMUHZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NulYzmp8; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8d67a483d3eso111930685a.1
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 08:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778168526; x=1778773326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JHHH4P/NGTGaNyvY8S1ryGT52QZc8oMkXSg9F92YVIA=;
        b=NulYzmp8GedNunKdEpq+7bRuXeJ5APBdyxCpJ/X6EHijeFKQsZv6vkIStdW1aHifiv
         kH6x0iEfTgwnxeRYhQpqkPoy8nWjf3NiPe4iwxgqa3cWcBHLNnqECEM5IvUqDVAt7sZD
         PCNweZNjkyoSUz8FmXX9Zow93qwK9tLwN0e2rZXFnUSPKJvdj7w0nsqARX1GQ/p8RfTm
         /DiZ9Evrd/oVx7NnRD4FDoE7XZkJPRYWg/szpORp0omQZ19eHinuPot/XWdYjtmsuvWD
         k1SZyuLq/hNxQ2+wUHyVpkWWrMQTTabnV76td+bNtJlilxbP4WBfLU8tlBS5L0+GUw1A
         DSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778168526; x=1778773326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHHH4P/NGTGaNyvY8S1ryGT52QZc8oMkXSg9F92YVIA=;
        b=cCdUNmq1hUpBVsVcCLtWfqrZW1daC8eOsqondfO2ZIDR/ACOaT57WWSV6Gq+1jIWaG
         ZDF+aMtCEDc7RZORnwioANceLSI873IouMi4bd29cmBOqVl0uByvTYXdxrfx5NITW7A0
         lIYb/JokuvEqeF58Ep05HvZeKDyxsxCdKNJ+fzfm5cTLTb3MP0ax+QlyhlPULgwJJrBI
         V6lvztahrbXHk+ih5OwJahaJrTMGfBQ7w620n2zKbnfAE0phbfNN4RLwjPjhV3gwKy/w
         qAC+rI+vLcJ8J6/0akpcdxilII984RqqDKKyq9YDqx4zbGrfRRknVKkEeRKb2Q5J8rv1
         p7Mw==
X-Forwarded-Encrypted: i=1; AFNElJ/2c8nbUQERpEBmJydSkIxACrDDgVmLXs1Lab2v/u7W0ZJNUkkxNj4w3O5XtSzR/UZn6ZZNF1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdUJ+cumlwrdFgEu7GDqaj7f/dPuxrqQpZH6OW0jZ3Gt80k7O1
	l1eBbeStHrmt02WiIB3nl/RQPKnYnUllSDU/EYtOiLt0SRjIe/V+Au7r
X-Gm-Gg: AeBDieugPlhYPEC53Lwm5EDCyVZv4bzlHFvVGLQdfp1PDyls5dJskfJNO8sU9F5v311
	JS0/Tyu4c+ndBDl6pkz396aPduKSrS7x2da92KdPR2j5Av3AHsGascQVfcE76nOrx0TzfrsywEg
	ftBebe0HZDRp9X7C+Bbcj/aEUEBJIqseLDBovAxN0hOpX3nw1nUyCL1wojkzD4ftK7Tpgt8sy5a
	X60m2BJZnH7YaGoygiywst9l6JTHzoFL495AjMGgyuMcynq1llKl4OWyzhn2VTOihsq5WgQxHye
	fCvHGkTHmFQMfM1h3JEpcMlptqLXyF8weCMWWk/qw1U6UFDZHgBdvKUHYGRzHEomc9LDBUf8jWD
	SOU9a27Za2TI/1N0GWy7GnFjyZsBzzdQYjcSeqXFI8ErK+Dbs5ySI74Q3JJAfGl3upM4rBZpm2g
	JJul8XUsKiHFbh5YOAD5v1ixhK19HaSWPbPk/7VqsTZ8haEI9F+AsBUv8GD+d0Madd34BYW13cJ
	xnmwg==
X-Received: by 2002:a05:620a:454d:b0:8ed:d6df:c778 with SMTP id af79cd13be357-904d5ffbb46mr1206673285a.37.1778168525682;
        Thu, 07 May 2026 08:42:05 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc29383c15sm1996496685a.6.2026.05.07.08.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:42:04 -0700 (PDT)
From: mike.marciniszyn@gmail.com
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: mike.marciniszyn@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3] net: eth: fbnic: Fix addr validation in pcs write
Date: Thu,  7 May 2026 11:42:03 -0400
Message-ID: <20260507154203.3667-1-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 71B344EB45C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-285399-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

The DW IP has two distinct PCS address ranges cooresponding
to the C45 PCS registers.

The shim translates the PCS addr/regno into specific CSR writes
into one of those two zero-relative ranges.

This patch fixes a one off in the test that could allow an invalid
CSR write if an addr == 2 was called.

There are is of yet, no real impact for the bug as no PCS writes are
present.

Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
---
v3:
  - put back into the series based on https://lore.kernel.org/all/9ec11642-8035-419c-a896-52f902020bb8@lunn.ch/
  - revised commit message will additional details
v2:
  - omitted from patch series
v1: https://lore.kernel.org/all/20260428172810.175077-2-mike.marciniszyn@gmail.com/

 drivers/net/ethernet/meta/fbnic/fbnic_mdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c b/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
index 709041f7fc43..d6a124889f52 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
@@ -125,7 +125,7 @@ fbnic_mdio_write_pcs(struct fbnic_dev *fbd, int addr, int regnum, u16 val)
 		addr, regnum, val);

 	/* Allow access to both halves of PCS for 50R2 config */
-	if (addr > 2)
+	if (addr >= 2)
 		return;

 	/* Skip write for reserved registers */
--
2.43.0


