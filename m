Return-Path: <netdev+bounces-264782-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NhpGGbQqmn3XQEAu9opvQ
	(envelope-from <netdev+bounces-264782-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 14:02:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B2022143C
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 14:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E1B831ACCA2
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 12:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E3938F252;
	Fri,  6 Mar 2026 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCEse1HL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3F4386459
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 12:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772801540; cv=none; b=LVeywxv8ajenPZ8Kr1arieKosbrf60O9l+ouIPKPFNt5btxWDZ59pIU9BfZjv5n9ifEOyUA/UD0phxnG77+oB/k6UCd7DdGQQASZB3NHq5cvmErbgXm0XG3C8BBxVXU5pF7atPS23kBqM9ptxsv3IaeH/fDFcj6k6SH61rGEpuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772801540; c=relaxed/simple;
	bh=HAy43ssDo0xlUcBDIU7vQZtNnpxG03JPCL6Ldi51ASI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OBk8kI0I91psFRaIxb6nCnAzQlsc7jrXkOPW8lL7cYCosY08yfQDwAlWBFfdFs/VDuVJjD5VEdeQeMt2K4kWGgjLNXhTrRqgs6JNe7PxALDJKvt+kcJ833TRz3hKl2eb2Ft6WnKPf/6hp5Q3qm8+/Q703ixD4sF/0aDNw1BrDY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCEse1HL; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439b7c2788dso4008389f8f.1
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 04:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772801537; x=1773406337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y8B8kg8ACcCsMXy3SgsyRYngVEpIsqkcoCsLOS/nNqQ=;
        b=RCEse1HLoUtQApOdbPXFvYItGrEKWhMZ5FH1L4npAxteGeWOhAEAekijg3Ur83ovNu
         D7j0Aio5nwazNQz3y4rO88a+svlEbLx5fyxypjkMFUV4PDnOpv7HYjT9Aw1NVdIwO6l+
         sTgZ1jssfWdVnLQwQe6naotyBRoBV2AugdTmASE0Okxrsi3juIOafyTCxnp4K0weRpaH
         XodiSWNrkHzZSWM6/wl3D42yExGGPiuDybF+9otR/5TaBWNzrcLkSb73hvP6va35kQWK
         mnp6OV+L7iHTbxYpTfTm4axD+IZ/Q/dtFxxA6XolA28oMQbRPK0SIHepheSZx4bgl64w
         FM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772801537; x=1773406337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8B8kg8ACcCsMXy3SgsyRYngVEpIsqkcoCsLOS/nNqQ=;
        b=KomubXrbvHQI4WbFxBztyfrvNNRRWm7V46yQSwx0bP8PXKIJP38kAYzK+ZKWhmcd7e
         LpS7422VcYyLywLRxlevD2YaXsF0CK6e00YpTtixakHxYs/4KxGaU21vfwYV8mRhfu7g
         HVmxKvNQ6DTdC7wAIGT6TrcZCK4VCvgCx3z9yC62hQc8C6w+9mDnnGPvXNR74ofvvXdC
         eVZjm56layRoEr4PTpR2F33OVSt8+HRikH7eBzIKtQ5n/lEKtmJKDHRaodAaCyFGWMWa
         qDVoOR8VI4NIJABfsOT6OqisXLPLf+jkKpGkCY2ioRPRKK9GzW4PgIuNcKvPQilQQkgD
         Xlnw==
X-Forwarded-Encrypted: i=1; AJvYcCVcziiSg1n0cDakmiQXH3869FECP24dcIqrZzs8zKakP+vHT958hnq9Bp0alDnLeVtXgo0B8T4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2OF1e3PiuR4Zqpe9qXA6kz6T2CCtro6kv8eL2j4Zh2HCjWywo
	/rZTavazOZRoq7zTvc4fGZ/yupjkTT9xRPZCKRkM9pc0UuK/KDSP4pan
X-Gm-Gg: ATEYQzx75s3OlYg8XKMgu042++2+ZPa/CZDw09DYtnwEHHBsuylQF0+eXzcFM166JtP
	EMuM6Nq/sGQx2WNTPNEyu1BRGci/SV005CzkExhd1KK52D/nC1c76MBxvAtioaI/+5tgNoyCg8v
	ZFRyiqDReKfJ6JHa3YRI213dTzMluN1sZTYNSqlWI1MwW66gaDCf0myU81ehAfiAff34wmxnm8C
	PUF0YrLYtgZl1I/ZcYM1npoL3PBOnrhaulSqhbn7S5NaZMkHLrNQm6ns1lof+7Ciju05dQpEcBe
	pumVg15Dy+PcSXQSSQt4CULH7bbuJvZ0PHJ7dS+74i/OqFSgxD4E7LCqM5ufHYdbESx0/ERaR/z
	CAyT3oTz6S1oMQCUTPevHjHjTbDOWhu74SqyTZETzwGnjZnfrPMa56ebQVRfYgOYW0bbx6j3O2M
	v3CSEBiXpdFTdaLuRcqIb56JeDryaHx87SOThqnYP6gMiu7EljKYIhr572Rpgz+UIRkrYyNjL9c
	BLmrcmhsXX4hU4X5KocoApkO04w
X-Received: by 2002:a05:600c:8b8b:b0:483:103c:b1ee with SMTP id 5b1f17b1804b1-48526922599mr34173745e9.8.1772801536778;
        Fri, 06 Mar 2026 04:52:16 -0800 (PST)
Received: from skynet.lan (2a02-9142-4581-3c00-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4581:3c00::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48527681a3esm76085715e9.4.2026.03.06.04.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:52:15 -0800 (PST)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mnhagan88@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH net v3] net: sfp: improve Huawei MA5671a fixup
Date: Fri,  6 Mar 2026 13:29:55 +0100
Message-ID: <20260306125139.213637-1-noltari@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 70B2022143C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.39 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.77)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-264782-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[noltari@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

With the current sfp_fixup_ignore_tx_fault() fixup we ignore the TX_FAULT
signal, but we also need to apply sfp_fixup_ignore_los() in order to be
able to communicate with the module even if the fiber isn't connected for
configuration purposes.
This is needed for all the MA5671a firmwares, excluding the FS modded
firmware.

Fixes: 2069624dac19 ("net: sfp: Add tx-fault workaround for Huawei MA5671A SFP ONT")
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 v3: avoid using a vendor name in the function
 v2: rebase on top of net/main instead of linux/master

 drivers/net/phy/sfp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index f4bf53da3d4f..5db841377199 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -367,6 +367,12 @@ static void sfp_fixup_ignore_tx_fault(struct sfp *sfp)
 	sfp->state_ignore_mask |= SFP_F_TX_FAULT;
 }
 
+static void sfp_fixup_ignore_tx_fault_and_los(struct sfp *sfp)
+{
+	sfp_fixup_ignore_tx_fault(sfp);
+	sfp_fixup_ignore_los(sfp);
+}
+
 static void sfp_fixup_ignore_hw(struct sfp *sfp, unsigned int mask)
 {
 	sfp->state_hw_mask &= ~mask;
@@ -530,7 +536,7 @@ static const struct sfp_quirk sfp_quirks[] = {
 	// Huawei MA5671A can operate at 2500base-X, but report 1.2GBd NRZ in
 	// their EEPROM
 	SFP_QUIRK("HUAWEI", "MA5671A", sfp_quirk_2500basex,
-		  sfp_fixup_ignore_tx_fault),
+		  sfp_fixup_ignore_tx_fault_and_los),
 
 	// Lantech 8330-262D-E and 8330-265D can operate at 2500base-X, but
 	// incorrectly report 2500MBd NRZ in their EEPROM.
-- 
2.47.3


