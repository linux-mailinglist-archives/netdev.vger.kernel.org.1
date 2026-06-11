Return-Path: <netdev+bounces-298072-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FLWyIzCNKmr/sAMAu9opvQ
	(envelope-from <netdev+bounces-298072-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:25:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 25313670D5C
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:25:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sartura.hr header.s=sartura header.b=btB2mJIT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298072-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298072-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=sartura.hr;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A581F3019C93
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BED43CC32E;
	Thu, 11 Jun 2026 10:25:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4643C8738
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 10:25:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781173534; cv=none; b=ehGu+zhZMG4WA+NXw9avvC3HDCKrv50TJrJs//Tx9Pdtj0ZnACEuo3yR32x5dJBF0zQh+VBfjrK17Sqy5Q2fGVJwu/59u5YUWlP8epy7Q+QQcL7NHJhsu8/eYErQNU9zfGdXtI6diY41b9tCxPi6OCOHNcQOgdfWM8S55oOnsxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781173534; c=relaxed/simple;
	bh=YPVGhyrz93VWfclNKtS6TYiy2rQgGU/zy47IB2JY+8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DUqeBHIKLqtc+y8OP/fm0XTtgnw8LXnT5aT4C0wMDiiNQKD3Sg8eiAR1v1ekcv4y+9ONjQ6F4XRc0zV88DzC/x2kMP8ybzzebWDJnb8DRWdbBRhV3Gd3L5l+0JhG3yMBiry5DRR4ldVBFKAWtUeDJ0nXe9884hat5z40tB5sJzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=btB2mJIT; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490b9318997so57280795e9.2
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 03:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1781173530; x=1781778330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ajtLdf6kOQl/9ntlN63rJuIpsbywFjT1rs7cS24D84g=;
        b=btB2mJITteSdzWc/TyDZXuPvlf2DaXPxV18ylWc8ZVyTd7qSt5gf6UrjOVgsQfynLV
         ZnLN7oxNKwXsztid7b2Ybe6UicVLhi6956uJjEBVmRuUx6L3w+Y3QxwQvo+yDFijZOBg
         pWh5OU4Sq1h17vqqWt2U1NSiGd5EFjwJE2+KjU48TsfCkOAuExZPHFCwAgj2F0xlVxdw
         JmReiLkPkbFKLn68FwwTPd7E9ePag0x1WZ8YP1owYMBmk3gfHjKPfKkupGmrxD6r/kDY
         WtstYQNQF/LfebsRYd+E5B3a/ni/gu9Wus+jjTx2J/ldN/ryY8o4mfdRIbrgpOMJQD09
         dylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781173530; x=1781778330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajtLdf6kOQl/9ntlN63rJuIpsbywFjT1rs7cS24D84g=;
        b=Llzq+V7JzYi7koQQIXUv4IDLAzjv/7GfWVbriXDtRv1thWq8ATIfhn1Ubk1aDK+XK1
         Sut1To53C9WxeWysycxFIEVdLVjWY1Cp7CYgZHKfFCnzLwB0yBMCnidlJSDHgUm4ukZU
         jqHPuRR1ywLX8Dd4CuuDO73Bl3Qgze3xf8MjoiHzMZlCYgZHEt1vmntVH/gTmS3A1kAe
         B0ZCphOxNOjism6FEDh/bzTan2qXXbuTu0pLZNKBKqMMS4kEM9zFpZa6opAOTjHRIeSW
         V3qWVN9k5whG8epv6DmNJqTM2CSWf1f3bqVA+ww6M3cQkD8cbgfmexRdrp1fgVi55KFW
         UhnQ==
X-Forwarded-Encrypted: i=1; AFNElJ9NaAI3Qq+sJpqsR5hNGTTmlE5pnEAIhb09lg/HseBFDbpRs7p8ZtDYsfUzrK9vF2IGOTnzy94=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuLvilX5XhaPPieCQizr0kqz6a87eq16sHizORp0BO5X53xD4b
	m52EVNX929vJyTEWuexhcEmNZoRgCvu4iE1vmHU6Y4hxhs70KjKgJ9Xh3JMgG5mTBbuVOFAoahA
	B2IwM
X-Gm-Gg: Acq92OGuA7NazsFzo8GQZ5s7saHmL9V5wrQsxYKZEb8ROLADssT+pIZtHrZFEzyaPHt
	+rNTxQU01z2fBbAuzkilLs6LU97vRq2Yds8EcvYRowzr4PhIGvMVVA+U+4AyosvUhYko7fq2AoO
	Qv6yQmAY6pgVPnEFWU1PkKAX9jPXXbuxGV/RaQZS2DKGiMNykTr9yNJmZuphs18PDqnhbxZeVZ6
	k66oq11W1WXtK99l89wdSgBymbRqXVHGTGAlGcQc7FFEcdI3b6+apc+ZSdH4rsbGXRAfDpZ8suM
	uX3W5QLk/1ymsYbCF48/kIpmJRCPoGS/2l8yLc4pRZner1VtzzYfuROEi/6/Aqnm8oJugzm5uIb
	U+n+yUNm3ulsAyA1LfO+qXGe5Smpm9tBB+WJ87l4Y683MDXpkMEhMtRg2ZEtDeP91yDfLD42bky
	e8y4FpTyS+6U82Pp5d/LyB554YZQbkiGphPIIrrGNmVIiFJmAIzmhWxFFqutvRysGLfN6cfcSV+
	O1Aeh+tOK7sEbMSDx25mhAZZGoMOlB221QY2Yvq09R9bqif3pfAY5S6sm/QmI4GiIrtCRWYqjP5
	v7LeZWz0o7uZ
X-Received: by 2002:a05:600c:3b15:b0:490:e196:e8aa with SMTP id 5b1f17b1804b1-490e56176f6mr27546145e9.28.1781173530218;
        Thu, 11 Jun 2026 03:25:30 -0700 (PDT)
Received: from threadripper-fedora-workstation (cpe-94-253-164-203.zg.cable.xnet.hr. [94.253.164.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e5314f4dsm36929705e9.11.2026.06.11.03.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 03:25:28 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: o.rempel@pengutronix.de,
	kory.maincent@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH net-next] net: pse-pd: set user byte command SUB2 field
Date: Thu, 11 Jun 2026 12:24:49 +0200
Message-ID: <20260611102517.445549-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sartura.hr,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[sartura.hr:s=sartura];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298072-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:luka.perkov@sartura.hr,m:robert.marko@sartura.hr,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER(0.00)[robert.marko@sartura.hr,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[robert.marko@sartura.hr,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[sartura.hr:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sartura.hr:dkim,sartura.hr:email,sartura.hr:mid,sartura.hr:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 25313670D5C

The Set User Byte to Save command has three subject bytes.
The PD692x0 protocol guides defines SUB2 with value 0x4e, while SUB1
carries the NVM user byte.

Template only initialized SUB and SUB1.
Fill SUB2 explicitly so the command matches the documented layout.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/net/pse-pd/pd692x0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index cb377d5ba7af..209de9cec849 100644
--- a/drivers/net/pse-pd/pd692x0.c
+++ b/drivers/net/pse-pd/pd692x0.c
@@ -200,7 +200,7 @@ static const struct pd692x0_msg pd692x0_msg_template_list[PD692X0_MSG_CNT] = {
 	},
 	[PD692X0_MSG_SET_USER_BYTE] = {
 		.key = PD692X0_KEY_PRG,
-		.sub = {0x41, PD692X0_USER_BYTE},
+		.sub = {0x41, PD692X0_USER_BYTE, 0x4e},
 		.data = {0x4e, 0x4e, 0x4e, 0x4e,
 			 0x4e, 0x4e, 0x4e, 0x4e},
 	},
-- 
2.54.0


