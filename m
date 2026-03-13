Return-Path: <netdev+bounces-267296-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cB/DAvWps2lWZgAAu9opvQ
	(envelope-from <netdev+bounces-267296-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 07:08:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F7D27D99A
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 07:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A4E83025E10
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 06:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C16F336ED1;
	Fri, 13 Mar 2026 06:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiS8PQT2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A0F261B71
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 06:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382111; cv=none; b=DpoF7UK3VQXveWyhGZ02Ob0zXUhok9W7vj9R7AFj/eNn3q5pE7MKRiifniUxX5MSK9EUwOJdzKh+zlcD3lVQmFl1V/wEjlALJFyjrxRrAlDWh0VqcQP1aCL1QfDab1TijpWlDhQfdMGO1+Frj6qA5urRMqcCOp1+CGXt1u7VWGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382111; c=relaxed/simple;
	bh=SAsMW3yWgjPG74DpRvHq0xpKG+WLnRRIhRB/FVzVgWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ti1b9kbeMJm20CRwD8Toq0rRu5FFd1cpHAMENHN9TgdQHA8Tf5OjDwswE0CW1PuUkBYhMl7DYQOJEwH9rD/xu35GFucNo4A+jyJjcM3l4+10frfy73L8debOgYArupKo5oEpavOOkDFJOmEiSoV5rZbi+WSX6Iebs2LgoLTsg7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiS8PQT2; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so731702a12.0
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 23:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773382108; x=1773986908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/xBoiQBQi3pZpHXoWhUgXx+RczLmJXWiD3IkIZsSKDA=;
        b=kiS8PQT2ugFsZQDjxfJfPCOOc9sqAGca3KB+ZehUHxrJsn71nzmfqMkNjn6NtHKNd3
         oLPADRWqD4NHpt80tT811o0bh3XAKLHlg8SlOIWp2+5JcnjVxG9OCUnPffJGhO4JhrLc
         J1SRAP/uv6pXMb3KJERuuUG00avfZ+uImAv1WEwgundqkfkVDM1MauNTwZ85t+zFwYdQ
         AX1Fs95HU1SGCO/Tea1hGy4u3O3D7LjbfWD2N/hvaHEH2f6zLAP5OA/saZc0eIu1Zt+t
         jx7hNPRz+vRIOw9TDb6B18KHyv0v30R390BKttqiJd2Sy0Yh7lfDeNoVZRbGnRfgKOYg
         9lRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382108; x=1773986908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xBoiQBQi3pZpHXoWhUgXx+RczLmJXWiD3IkIZsSKDA=;
        b=WUXNhUtHtRSzPuHJyH9SCVuKPBEcSQiT28cdhOU6/p5HiGl2XJs6lvVYvDAy3JKfjt
         /B9gvedDXx/MI7jKEfjuwdukkfimePAC8Rp2NjmCCoylake6wWGLQRWOaJA2rebQ+3pJ
         IwMMaFZCutqxqmlOkZKZz8yE7k1rt6r6uJynBpvCj9Xs6fhWqz/GcmfJ7EGiSBBM6qdK
         v70YjdRPrLxFoVI+lo6wMZ70Dc8aUEEo1Pixgncaf5r7kYrPsDw2fWxM7hNPNf9P0PBA
         nnSZ8w7C0JDA6v+Hpr4LfrMFPSnSMthVJJ5DUpTusaaQrDxi4+x1PGk1eAiXeOOVc8eL
         WhkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzHRtatC3JvX4zp6AU6fRxz6VojniOF99PGkJhQhrFioa1hVPV+Q5EP94Cu8r51W6pzmksioE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG56NJIf+JB4LST2qau3wd1cNSF1OxM4UWQLdMzEnGoIx7lQpv
	WWnaw/yTln7NgYKzko70fKlBNPeb9sPoPi8TDtuRSIxYV9u+yKRsPNE=
X-Gm-Gg: ATEYQzyAy+/GfWbIRhSRgq7zNQTmu8bzQyv/cwmu+jPGN5OJfccEiyt3eMmfOqQPXuv
	0NP74Ua3Z1CtxQ4C0DNjs1IwwytYJ0wZqxJO4VE5otsIrRv+Baclo1okKQa4HJ0YcJn/ZBsdlQW
	fvWWg9mqzH9W7kv4JShKv/3HM0RQyvxAH6nHQc8B20ldfqu7tP84B/+wVY5+8/4f55c1tdUbL9G
	qmg2xSreBdLwyd+GHVK0dgeLHl/fU29Kq8SsG9pQCXYeE+2UcP5phh4XfNiyWO0QntPbAiR2PI/
	CfJi7tjcd5cNrAwWFwAaZFQSuUywJoJw3MC7XgTTwUjmeZzpNvzisqgZLFoALctMjlvQ6Q/O0k9
	r1VhDs6glAg/I8DaQ2GQtfgaFOgQNzL0Fmbkji/TOP0LQQnyv2dTP3OWGpvYPnaPTcU5Vke7GLW
	hOuV8IRofbkzMKg/tL823GWLxhOR5E6lK++igZip2C4pjkbz1S076snxhfeuWiszo=
X-Received: by 2002:a05:6a21:7107:b0:398:6461:6884 with SMTP id adf61e73a8af0-398ec67e2abmr1447737637.0.1773382108097;
        Thu, 12 Mar 2026 23:08:28 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([171.61.161.137])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73ebb6800fsm714631a12.16.2026.03.12.23.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 23:08:27 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Rishon Jonathan R <mithicalaviator85@gmail.com>,
	Vincent MORVAN <vinc@42.fr>,
	Paul SAGE <paul.sage@42.fr>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] tg3: replace placeholder MAC address with device property
Date: Fri, 13 Mar 2026 11:38:09 +0530
Message-ID: <20260313060810.1314-1-atharvatiwarilinuxdev@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,42.fr,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-267296-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atharvatiwarilinuxdev@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[42.fr:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 48F7D27D99A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Paul SAGE <paul.sage@42.fr>

On some systems (e.g. iMac 20,1 with BCM57766), the tg3 driver reads
a default placeholder mac address (00:10:18:00:00:00) from the
mailbox. The correct value on those systems are stored in the
'local-mac-address' property.

This patch, detect the default value and tries to retrieve
the correct address from the device_get_mac_address
function instead.

The patch has been tested on two different systems:
- iMac 20,1 (BCM57766) model which use the local-mac-address property
- iMac 13,2 (BCM57766) model which can use the mailbox,
    NVRAM or MAC control registers

Tested-by: Rishon Jonathan R <mithicalaviator85@gmail.com>
Co-developed-by: Vincent MORVAN <vinc@42.fr>
Signed-off-by: Vincent MORVAN <vinc@42.fr>
Signed-off-by: Paul SAGE <paul.sage@42.fr>
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

---
v3:
- Used ether_addr_equal
v2:
- Wrapped commit message to 70 characters
- Removed BROADCOM_OUI constant
---
---
 drivers/net/ethernet/broadcom/tg3.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 75f66587983d..1a074ebdf58b 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -17030,6 +17030,13 @@ static int tg3_get_invariants(struct tg3 *tp, const struct pci_device_id *ent)
 	return err;
 }
 
+static int tg3_is_default_mac_address(u8 *addr)
+{
+	const u8 default_mac_address[ETH_ALEN] = { 0x00, 0x10, 0x18, 0x00, 0x00, 0x00 };
+
+	return ether_addr_equal(default_mac_address, addr);
+}
+
 static int tg3_get_device_address(struct tg3 *tp, u8 *addr)
 {
 	u32 hi, lo, mac_offset;
@@ -17103,6 +17110,10 @@ static int tg3_get_device_address(struct tg3 *tp, u8 *addr)
 
 	if (!is_valid_ether_addr(addr))
 		return -EINVAL;
+
+	if (tg3_is_default_mac_address(addr))
+		device_get_mac_address(&tp->pdev->dev, addr);
+
 	return 0;
 }
 
-- 
2.43.0


