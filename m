Return-Path: <netdev+bounces-267868-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sO1VDCjZtWkn5wAAu9opvQ
	(envelope-from <netdev+bounces-267868-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 22:54:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8297B28F218
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 22:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77FAA3023DCF
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 21:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521423859DB;
	Sat, 14 Mar 2026 21:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2I1SjAC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247DC3859CB
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 21:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773525283; cv=none; b=kYxI6f+HYFjpDoF/VSpCcf3em4rhHzdO+c2ZAUVhRBVujOaXjweEV9Tv7O50EkW1rUkRJuqjzjKks0x5VY8yRZ1X9G2hTjDYdQYpEPhdMYzdfauA3phsvltSnRrNW0d43Go7dlYNElZoPf/75Ar6V+m85xL+HhKrVX8j5FQkt+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773525283; c=relaxed/simple;
	bh=zyBvR66gBNHj30TAvIUG+Ee3ZkIChPpji7xJjFmHr/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qVC9/ak1iOIsUT0uSeKDkye0Mty9GGbgIKnnza3EAB96FOspC1mUDRHcqgbHgnrsepPfdNrUIE6NxwbpL6KC6pDCzGGLSIAl7+s8NCvwVQh9DulQ1ufLF+GP3fSJ8ZJi5JWM1g2FynG9XzbEpQiR0oAWVPVmpuxAzsBh3QNYeIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2I1SjAC; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-829781b2b01so2116793b3a.2
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 14:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773525281; x=1774130081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2MZxltuowMU3t5Y9YR+g7TQKDjpiH5GQi6XASz0zH0=;
        b=D2I1SjACXRUvYqurV7N1vg7Pa1dGO9C+b6GtfWuCWRcNqt941Q6dFZSU3Sc9y6180I
         7oY7KSHdZkTK+Qvj1CzozLUHN42gCD6g2ILem469oVfFIm0kPScJYlONGul5AboXeRFw
         mYv9mfomLW5R4B5Li5xYs9MiEu4CQb7KsDze6ZFqfSr/O0ygGh/sL3h7hy7heLZOU2qU
         RlkJybwNakZZ58YEbv8EVICPkUcBut/Z6FVrmV7JiGbwDNhS1Kje+uzbDmyl7bZQR3yj
         w7PjclJn/XCTpEX3kIDowVBgJNuuIDDCdGrbMN0s5cJ4mVso3VABeZViJuxpF/BPL7YQ
         dX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773525281; x=1774130081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2MZxltuowMU3t5Y9YR+g7TQKDjpiH5GQi6XASz0zH0=;
        b=b4irA4Wnk9TZZ+m7ahtOKKHaRSnNIpnDpsA/Xy9FrGDrM9B43SlRlU9C8MJOaazxJw
         ITgxY3pbSu8sGe9Nr/d4QdvOKliL32m+et8garRlNYlCLV2zmwlDWJkfNKjyzGbsyuaW
         kPgWrS7DH256qlep6fbVAoCpR/RAqCc14PzDt9yxIRyFsHd9OUKZHDd5cQt2GtcKlBss
         o7ux7Ol3xmjTcEAWp/otGbEtrgtU3l4FCcGoK/89paOWm8BYP/6WMrAKAWe02EWoaJdI
         K9HuH1cwmbF0GuueEHGYNJ3Yu15n/HI0x0AskdowYFKko7WPXbwbkjt10ItJ4MbtDsIG
         exSA==
X-Forwarded-Encrypted: i=1; AJvYcCX1p5lt6ZWI23SRDJsuciqrL5eoNvvMIKP9wrxJbIcuMMWiHose1OGlMVvaskDM07neFO8KAE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTbVxLcl7nwkFFIzePRkRNvFivuEsRuNdL/v+BtDC3v67smR3n
	YxepQRqiO6f9fA3xg6xRKqTQDgYi6HWJ0s+ZvymNZqaYMNMe7sqzjHI=
X-Gm-Gg: ATEYQzz22ca1DDkIHdvtBzD5TOGi5+USTRiz/MKCfSsZz6vzUjZZyUsf/uZzxA01c1J
	fmyBi+WeMtHgD/wr4SAcYGCXm17G05lod/8CoMToCJtvhccneSei9RldrSPHX3hzpVrpO0lxQsd
	SljQOJ2DpLA4J1HcMZteEAGhTMM7Ra8PlPAzIKOJyDcxqPMYH1L4M3XP0aS3NJga6It1jqEGZHb
	bVoEO50s7e2je5x4/k2utNTf2d5Wnse4meMHr4DBzfJmxpEXHOXSuZSmgsatkpiDONlaHaU8KOJ
	ALms/wkuwMPTlTWKHd/B6kWmjsKJXrJHJvboXoES/ppLHAAtZob4o5ITVT5Ontr1cQQuulvKQUL
	btf07ihEwLE28+TzkMfPVhMPu79yFKUBkAJeUARaxhgPXbBUzobVwfBuv/qPDr24FFRmTPvsVVd
	Rz/6LEgkzdCybaVolKqV1nyzMycHrvq+YkjKxJeFfDnXrZEMejntDH/otiptDbDLUQq6BbY2NPa
	w==
X-Received: by 2002:a17:903:3d0f:b0:2a9:62ce:1c15 with SMTP id d9443c01a7336-2aeca796da3mr73368685ad.0.1773525281384;
        Sat, 14 Mar 2026 14:54:41 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([171.61.163.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece594b4fsm57292725ad.20.2026.03.14.14.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 14:54:40 -0700 (PDT)
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
Subject: [PATCH v4] tg3: replace placeholder MAC address with device property
Date: Sun, 15 Mar 2026 03:24:30 +0530
Message-ID: <20260314215432.3589-1-atharvatiwarilinuxdev@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,42.fr,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-267868-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atharvatiwarilinuxdev@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,42.fr:email]
X-Rspamd-Queue-Id: 8297B28F218
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
---
v4:
- Used static for default_mac_address
- Returned the value of device_get_mac_address in tg3_get_device_address
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
index 75f66587983d..a80f27e66ab5 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -17030,6 +17030,13 @@ static int tg3_get_invariants(struct tg3 *tp, const struct pci_device_id *ent)
 	return err;
 }
 
+static int tg3_is_default_mac_address(u8 *addr)
+{
+	static const u8 default_mac_address[ETH_ALEN] = { 0x00, 0x10, 0x18, 0x00, 0x00, 0x00 };
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
+		return device_get_mac_address(&tp->pdev->dev, addr);
+
 	return 0;
 }
 
-- 
2.43.0


