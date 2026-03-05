Return-Path: <netdev+bounces-264352-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCsZB+J0qWl77wAAu9opvQ
	(envelope-from <netdev+bounces-264352-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 13:19:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 516382117C6
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 13:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 98A4F30378D8
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 12:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556AE39659E;
	Thu,  5 Mar 2026 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXallV0k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F37377EB4
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 12:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772712842; cv=none; b=Z2UWhpAOQgh/NJi9c4SxKambyQtgucLto/VigYszKc9ewda9IbR9YGY0QYHL2sBPec97yilIb6EQshobiJxjCRDT+2YDBVb4ljXcVV0HOO5OHsW7aOqkOdxeMNLYojmJSb5UXxAP6cS363s4PblJYRDgWP2BZ1csMDtsFgfcTIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772712842; c=relaxed/simple;
	bh=iwX2UcBl7tP30h9WaByuWXJH1KsY4yDRWRnRss61q8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YiHkW6fAaOHFnWzEfIZBy3zfQ2mtfaU4rtIPu/oKv1WTMr0N5LwkqbR5nlJRp/FxOBiXVFa4Z49PC+O6lf3mByb6kWk3ou8v2DN09AUy7pQXP9k8cQNbNadsZdcKP5yAfb5LdDYUZSSGNskgsjwoP+gjoQEmDE5v56qi1t1O+RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXallV0k; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48371119eacso95079965e9.2
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 04:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772712839; x=1773317639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yPy3h4xaTybaSqSbqk4gaOiETs94bm/62y+eylc0szI=;
        b=UXallV0kEoDcEatFGIcj67KN2TTHI0K6M7MJHzTzvGS0wUxselM5tumRPfcaKGrcmg
         9Yy1yCCkzE8Z5i17vWT9kPfz6qAZTh2Ony6hHNf4fzEjZQhHdPok1YYDXZSfwm0cX8sK
         mF69uErdq++Lxn49LVym8He3jSCpMQNnJH+BQ8pWuDsiBuN9MYPnlfuOO2th/oncE3cE
         zPcJtSa7R/ZYkBAw9YSGxi0nukpUyaziZJOa5E2DotpCHR+AFivhKQeUygXk4RHyjGs0
         HRTgGReahuxRAh/SC6iqvGFEC1tFcZMJrtnhTsnyLghu7I1pKvu61856bfkzmnwmubr/
         N7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772712839; x=1773317639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPy3h4xaTybaSqSbqk4gaOiETs94bm/62y+eylc0szI=;
        b=kSJtJveGZx10UOxvLg3se/euOfvIkuXo63pCWZ8fymROwXhhhZWcu+bL3lxv7z9lTu
         2Eit33URUDbwa9UYptFe86An56ZozbXK7x9hQ5+u3t18Y82uSyX/oIn5UNnWObsR3DxV
         vBZSM3TIy6xrE1W5nWwipPU6DXZ0z2E7NFQsGQCFiqAnReLRfJDESqpHyVWAERmlS/kK
         m36LJncP7tbOzM0eDOSc+c8YcaexH4IzXYCd64lknHhMQ8o91Ms32K2Pz5mV6T2st3rI
         9KTB5huGlBAtDK+hZVU7zBThh8NVPwc6/xDbFEUb+MI0Cfsieg5/M8x4hxNVX4sApqiw
         Xr1A==
X-Forwarded-Encrypted: i=1; AJvYcCWa+vYM2meIF9lZOmPQGLFy2qIbUef1jtPigZoc6xzE9PMgU01+z2TSC3m6clGXUbxC4wmWwDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx285R5VtMYRvN1aVBvUn5k1sun03aR1fFcxqNzXJ+Q6oYEw2Lb
	Ecy/08EOJsLDpCBZam5D4n4WWJOFpd3Q0QhruLUDIfksMebwLnVyltz4
X-Gm-Gg: ATEYQzyQUKi/ngKT76vEujqq1zZM8ok6oOUT7uTHGYMHAHCr7RuxYq3vVg/GZHXp6Hr
	2ziCqUYSr5aHKJcStbWeYLjje/OhbGoHs82gTJ67d+IQGVbcvSBGrQZJ9sAxvTqv2zp5l1/3qfv
	N97HP675mmZyWOW0s6xzZIFZ6GOZdJ8DPUJ4hXkTMVZsY8LjxnqYmPRQFW90ntne1FBtiORuX9n
	c++npPIgQPb3iUoTRCTzeNo/3XwB51C42HqoWzJ1TqIUhRMNKR7whCkgbtDRAU+jupzJ+1luutQ
	Lop/A902TrLg1qXtMsgndq8oLt+IUwezTbjDKsfPq1M5ksEBc6apRvDLw9mKPHUt07t7btxmb6+
	7TLVJmlooXUp5l5mQJYh3YqMbyamyfZngTdOBkre0S6tkJ5LQ4E6xuFlaiHOkxGipz1XBfy9sY4
	OiErgzyJudXMTaytGO4J+jAuU1yxq9fg6Refyrrc7Z324gTnyNx53Q6kD8TC4KRdmw9RqYxk2Fv
	lExPeW4Nyb/+5H+hxLB+KE9Dby5
X-Received: by 2002:a05:600c:470d:b0:47d:18b0:bb9a with SMTP id 5b1f17b1804b1-485198b340emr99599985e9.33.1772712839130;
        Thu, 05 Mar 2026 04:13:59 -0800 (PST)
Received: from skynet.lan (2a02-9142-4581-3b00-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4581:3b00::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851acf9ac7sm32219815e9.15.2026.03.05.04.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 04:13:58 -0800 (PST)
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
Subject: [PATCH] net: sfp: improve Huawei MA5671a fixup
Date: Thu,  5 Mar 2026 13:12:39 +0100
Message-ID: <20260305121354.40674-1-noltari@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 516382117C6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.25 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.91)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-264352-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
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
 drivers/net/phy/sfp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 347c1e0e94d9..bcea137ad5f9 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -361,6 +361,12 @@ static void sfp_fixup_ignore_tx_fault(struct sfp *sfp)
 	sfp->state_ignore_mask |= SFP_F_TX_FAULT;
 }
 
+static void sfp_fixup_huawei(struct sfp *sfp)
+{
+	sfp_fixup_ignore_tx_fault(sfp);
+	sfp_fixup_ignore_los(sfp);
+}
+
 static void sfp_fixup_nokia(struct sfp *sfp)
 {
 	sfp_fixup_long_startup(sfp);
@@ -499,7 +505,7 @@ static const struct sfp_quirk sfp_quirks[] = {
 	// Huawei MA5671A can operate at 2500base-X, but report 1.2GBd NRZ in
 	// their EEPROM
 	SFP_QUIRK("HUAWEI", "MA5671A", sfp_quirk_2500basex,
-		  sfp_fixup_ignore_tx_fault),
+		  sfp_fixup_huawei),
 
 	// Lantech 8330-262D-E can operate at 2500base-X, but incorrectly report
 	// 2500MBd NRZ in their EEPROM
-- 
2.47.3


