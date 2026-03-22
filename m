Return-Path: <netdev+bounces-270313-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAxlLSsGwGm0DAQAu9opvQ
	(envelope-from <netdev+bounces-270313-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 16:09:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4192E9C16
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 16:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26956300D6A5
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 15:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDDF367F30;
	Sun, 22 Mar 2026 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgLBc8WK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BB335E92B
	for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 15:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774192146; cv=none; b=pDzs6KW8Mez5v5s+9K3Mcqh5aOj8BwQ47TQMyT41vnY3vmiJRqchEfrn/yy6kR4Q+dnzcTe6d4ClSGurDObXx/65ooEmEsPMjp56BRyZy+ZoX/rkW0P92IFwIc/V7ZF0JmvuxAXbdr2OCJxEK0ZjEDRzZoifOv3BHOi20uGbVnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774192146; c=relaxed/simple;
	bh=l4bXxMicugP9DCFFTxwsGFTgQ9PHmcEkAENgLhdDM1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BHS5rdvyn6aKFLwQtp6DyWonlqO1siLgVK64fzYx3/waJ4F5/ZsKWt5/HQjMj+ZOEu8mm1EvCQagmxQ1r39Fvz34OUYAyx4xtXr524lwRgtu4puwMSSj1ujoDyx+aYkNS2w0vM1+nNs+3byjHsM8DiWalSS6qPfjpdqfeAInpjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgLBc8WK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so20737335e9.3
        for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 08:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774192142; x=1774796942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O1ggrJzvUM4oVrQbKmG6pIms7djFV+UdSQ9TPdyUd38=;
        b=kgLBc8WKY88QLVH3sYydq/HFiltQ2z9OwEKl8tkiEdwhzSTJ8y44PXNr3WV/SpeWRa
         xbZ//V63a8lgeF+WS3mRTgc9RYntZpCIOwKxLxtJNNb1r5sYrXYyqbfoRfummp9LSM5p
         uylSyZIiPpH489DRyNiZO9H1aJRG8SUhsM8IaWfjDazSS8/kuBnHsB5HPVkgG8gKcdwC
         SEQvL7j0wEAA0C0+pjXFGUQSJ783slqmkhZqClR9LJic+IWE3lFaAiny1l8DvzHELblk
         m3rjKGUgVY1Vt6ydSKVG0Q0JNFoCpiXerb8btTig1p6KlAfxJQFkIZ48ns39UDQ/G/h/
         YhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774192142; x=1774796942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1ggrJzvUM4oVrQbKmG6pIms7djFV+UdSQ9TPdyUd38=;
        b=Lg9QheS50TwjtjGdK8Wjuvx2PS3gV6WZQW3r51DwxgcnTqXqNKb50slPtsLUugBJLf
         qS06ncZIYuIOB2BiEvwclY88Q44s+coUIRpKc+tSjvGSju7BddLi5ctrKv7ZaIXffHtz
         CMgoWtyAf6B6/SI0M8Am7+g1I4dydEZ1SiK2sI7BCYERTjeTDuincUj4Ytc6VInXhp5W
         ZxMGX3D9doqzFNqJLcycK+6etkDfuyp+8Clz4YbRdZg1xAR/fHvbXPld/sgVTMlDUaCF
         TRTsRDc79+GfJcYhJi+eO/y4pGmdgeT2wvedXVAdFxknuexDWvOOqfYomwNwOtjUo5q1
         jMgA==
X-Forwarded-Encrypted: i=1; AJvYcCVWesDsqh23oh/ftJ81Xxs8Gzv7LCy6pNY8bk42BTNYh3McmkJj3+j2zdGGsNcZ1g1al8aqhEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyihpDkwqBNreqBEpI1B/751elT8nwb4P0NzRAic4h7uxMd6doG
	FB283bq2mK+kseSAolmg84sUmtf7OBxLtSDx0g/mI0h+hLyh7wUdugs=
X-Gm-Gg: ATEYQzy/MWN5IevxX+5JjozrdMdXO+ikY3TXbpshAWqaIKrt9WkaNVpw+/t1uHUJjnp
	TnwE16BAWcHkeakOcIMRQsCO7WBlnTfSUC7DiQO9gQcBrpJMZNgrdSWhsTEdMgjzTSo/n8cctEx
	0eleMC8vwynObEZLf7AemOmddBTQEp8Q5bWMUarhmF2EoJ7M/7x0Vjz5kk4w2Z62E+OYBEQs96d
	kZco92zWuHMkKPMNPuXLaVMCjda85PWxMNLhFQWFuT5t645/yLZNv18+EEYswVHIY7xYEu9NobZ
	MHyzLftCaF0Ug+qhtaa6ScKE0rM2RRvamL489QM8pyi55DFuOCoEoSfi/RvPA8Qu9+d8W1PAg3s
	yVyhi5jekcTmTNrKfQrS0/GIFLn6cD7sv8Cw3MMxX3ubEPQSvnJe6DqOZxHge//tudak1WCGuLs
	uymPqjRn/gsbeJ6LDeBuIqW0L+CSMR05cgFAy0OZskVJ8vYKUq9NeCj+uFfsihWZQ2NKzT5c0=
X-Received: by 2002:a05:600c:1d15:b0:485:34b3:8587 with SMTP id 5b1f17b1804b1-486fedf9061mr128224755e9.10.1774192142264;
        Sun, 22 Mar 2026 08:09:02 -0700 (PDT)
Received: from hp-ubuntu.. ([41.249.139.113])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6470b243sm22384811f8f.26.2026.03.22.08.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 08:09:01 -0700 (PDT)
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
To: ecree.xilinx@gmail.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org,
	Mohammed EL Kadiri <med08elkadiri@gmail.com>
Subject: [PATCH net-next v2] sfc: fix spelling mistake
Date: Sun, 22 Mar 2026 16:07:33 +0100
Message-ID: <20260322150733.45817-1-med08elkadiri@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,amd.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270313-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[med08elkadiri@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7B4192E9C16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Correct the spelling of 'adress' to 'address' in a comment within
mcdi_pcol.h. This improves code readability and documentation
consistency in the Solarflare MCDI protocol header.

Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
---
v2:
- Specify 'net-next' in the subject prefix as required by netdev CI.
- Change 'Fix' to 'fix' in the subject line for consistency.

 drivers/net/ethernet/sfc/mcdi_pcol.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/mcdi_pcol.h b/drivers/net/ethernet/sfc/mcdi_pcol.h
index b9866e389e6d..a9a7076c00e4 100644
--- a/drivers/net/ethernet/sfc/mcdi_pcol.h
+++ b/drivers/net/ethernet/sfc/mcdi_pcol.h
@@ -21387,7 +21387,7 @@
 #define          MC_CMD_PRIVILEGE_MASK_IN_GRP_ALL_MULTICAST 0x200 /* enum */
 #define          MC_CMD_PRIVILEGE_MASK_IN_GRP_PROMISCUOUS 0x400 /* enum */
 /* enum: Allows to set the TX packets' source MAC address to any arbitrary MAC
- * adress.
+ * address.
  */
 #define          MC_CMD_PRIVILEGE_MASK_IN_GRP_MAC_SPOOFING_TX 0x800
 /* enum: Privilege that allows a Function to change the MAC address configured
-- 
2.43.0


