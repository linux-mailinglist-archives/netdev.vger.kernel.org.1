Return-Path: <netdev+bounces-264380-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EkYD0p9qWkg8gAAu9opvQ
	(envelope-from <netdev+bounces-264380-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 13:55:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BBA2122C5
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 13:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C29B930078BB
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 12:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D801D396D35;
	Thu,  5 Mar 2026 12:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RX5WIjvw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7925B2405EB
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 12:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715164; cv=none; b=ksOAYDm3DiimIoioKoCvhPZ662lJLDbrNbrmYPAyPLG9XAndde99TuWGQEPjXbciyQ3ph9uq7/Ost5t2DEnn3E1cHt09OV9curtg3AUhWzeUsqZViTz/45nYjW44gUihoesM7uZsdcjc0Y3wcKgL6HDBVLwILo19GjHE1nASFaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715164; c=relaxed/simple;
	bh=lWnduEXGTV4LtiDdWv2ZIuV7l0w4OIhRhpd9qvXQGiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U9fxcPqIvUvncj/Q8jJKz88RUE6N/Ev5Yp6Y4ZZpDYdxEDVOFoPpAG2NnJjVD1OBFSasi/iiv9QH5vW7M+lhr0y0VMgkQwMv65BIX74W1yJlu8erSiLAvu5I+tUx49L/90ai27P3x5F8aMVV29AEIxnqQ82ucHNRmd/70uDuumc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RX5WIjvw; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso66811885e9.1
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 04:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772715162; x=1773319962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nUIEkSZ26/0w9fRpWAiIvSCONvjyj8qvlCgOo0jrpAo=;
        b=RX5WIjvwbx5R2Qm6LxG861uX0DXBVQ+ezYNMOGQPQ9bhA3tz1hO+JC1W8TcYYwfy+g
         M9Gmw97sCSsg18U6UHauqZ/OtoYkrTlgVibd2LfjKsYbdDstGOc0lYHaUFQXa8PlTG3y
         xum9Cs/SjUTm0AuxNVYLpkrhuaj88SaV9PhqPSXkxHKWb7njmCnZkRdLJYASyx3h/tIc
         pVydqzkESVqT4cI/vzpTeZzii6XqxWYbiXiUlWWhUDLNWU4ieHUczdZM2rWtGPcS2lr7
         iXiUGUTFIbTkK6hA6nEc2DDdveFpnAt0agYIlNqev2B4DTC1lS7+rayR756b9LdgwFDS
         NFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772715162; x=1773319962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUIEkSZ26/0w9fRpWAiIvSCONvjyj8qvlCgOo0jrpAo=;
        b=mtd59VPXOP2Gne9d1BDkRlCx6wXray2szQt571/XyhUYsdw1hnXWJrBwq1bJV99xiG
         h8STp+VbozABtlKXFQ8a8y1IEcbT6qQpwkGEV+AOmS6xrSKUhx+reCCk/ifFlD0dkg1w
         khxxvv2k4u8iNV3x/kydMeGtJRKfRlkUsMq1Y+LAmJ+yKgvff7h2pIAcVYhu+JNKQiYW
         bkAAOiaZlQeI/p2C1lPro8IiXPulph2TSJp0gQkvmQ4sEC+yuQIpIrN8Mexqsg7qLAs3
         c9nuteGUdWH5qOhxmFDQgr8Vp0c+8DMrh6wa7i3aMOueqT9XZJGC6kqx9JsjRErczrqA
         z1+w==
X-Forwarded-Encrypted: i=1; AJvYcCWipu+qP8TYnaMQvxHOmDaLFHveAK14+Q6lyN8mc4B453eyo0Q32eAeFAbPDhC/VBvoIrfS/8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbfTxsk9yCkvik1YT/y0WPpFDewAVwxCw82EAIwSiNI+F2tBkI
	Ej0J0tewW5FTSdNLIUhQ3zfXCAhXtauC4CSOa8PDij8IrqDJosl8Aws5
X-Gm-Gg: ATEYQzxPxwSg5SZCfJ6T+Xm0QR89CADi39YjuVHRiIe3gvIvTmXKopdN5yFp8jFYfY5
	P2F015b7z22980/BfcEkU71/iaFsBtXJxzDViVHymE8KfuUQyPYYEhHVvnn+A347k9FqeGhee5f
	MWChgTkCKhAjhTCBv7ZzxmCQhU/yb6EMwj52ojUlS8I4BVJPszYU4rsfVBjyk6Q6BadRdCaL5U7
	nCv5jUW+vC8X0s19gxhQRXismQnheDtHL9JKFGxtoO4geFsRqE6aVhfVojNJ75AvxSwHv4Ju/Vv
	39T7Us5y780Cvi6NTMYbooD0CwI4Gv0e68YZUod+8Umec0BLZO9oHNbfxGQhjAKsb+VhaiMbn7V
	0OVP1Yr05d7t+qBF6uXyPLfmgEeW9xB2LoCm9CMdAwUewQ6ZA3rHnl4NS2Vvtr9VIA7IlyIRN8z
	UadKjYhjM2fHdQAHc49fegvDt28byoUakIdfOdNj+WDFxcpCRrlJpmcysR2AwzMGgGP2HMNck0s
	CoLVeToo1VfPRSq8cTzuCpxENvM
X-Received: by 2002:a05:600c:4fd6:b0:480:3ad0:93c0 with SMTP id 5b1f17b1804b1-485198a7288mr95964635e9.23.1772715161771;
        Thu, 05 Mar 2026 04:52:41 -0800 (PST)
Received: from skynet.lan (2a02-9142-4581-3b00-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4581:3b00::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fae475csm37865085e9.8.2026.03.05.04.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 04:52:41 -0800 (PST)
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
Subject: [PATCH net v2] net: sfp: improve Huawei MA5671a fixup
Date: Thu,  5 Mar 2026 13:50:32 +0100
Message-ID: <20260305125235.51286-1-noltari@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A4BBA2122C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.39 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.77)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264380-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[noltari@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
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
 v2: rebase on top of net/main instead of linux/master

 drivers/net/phy/sfp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index f4bf53da3d4f..34773cbbd811 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -372,6 +372,12 @@ static void sfp_fixup_ignore_hw(struct sfp *sfp, unsigned int mask)
 	sfp->state_hw_mask &= ~mask;
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
@@ -530,7 +536,7 @@ static const struct sfp_quirk sfp_quirks[] = {
 	// Huawei MA5671A can operate at 2500base-X, but report 1.2GBd NRZ in
 	// their EEPROM
 	SFP_QUIRK("HUAWEI", "MA5671A", sfp_quirk_2500basex,
-		  sfp_fixup_ignore_tx_fault),
+		  sfp_fixup_huawei),
 
 	// Lantech 8330-262D-E and 8330-265D can operate at 2500base-X, but
 	// incorrectly report 2500MBd NRZ in their EEPROM.
-- 
2.47.3


