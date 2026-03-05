Return-Path: <netdev+bounces-264358-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDpYLkh2qWl77wAAu9opvQ
	(envelope-from <netdev+bounces-264358-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 13:25:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B66C21194B
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 13:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B7583015122
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 12:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A15D39C627;
	Thu,  5 Mar 2026 12:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmZLVues"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E6F383C8F
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 12:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772713540; cv=none; b=ra0zaBM546ou+SYK5vzYX9Aj3yQGFtVBW1FjPC4TCrm0KajV9wCdxlOv6eQoFxmp2O4U3+sJVaBDrX83jYOt9ikfmCXQVZad0dpQejRzkvdbYcePPXn2XA630SsPOjUnnhtS0RonFqwrcIwy5azhpz1E0BkL4uNN86A5S2OPzFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772713540; c=relaxed/simple;
	bh=iwX2UcBl7tP30h9WaByuWXJH1KsY4yDRWRnRss61q8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r7hYiR6i8PRtMfZlVBYZ/Hjy5hjbAfJdqL00RG3dX0fyVEw+w6PmvORau39J4URO0zS4QNzRIrpwMS+n6UJBYxnD8qZGW7w8f568c9kSn/xV9qysgtxpwYgmRAC4FtnZNWY1G2o7REIhEhlegIoZ3Q6ueDnVXQVB0GOTpV8FmDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmZLVues; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-480706554beso86409125e9.1
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 04:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772713537; x=1773318337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yPy3h4xaTybaSqSbqk4gaOiETs94bm/62y+eylc0szI=;
        b=SmZLVuesbvl82vVQCoj29Y0E+JIo6ZFpZHfXGFW2p9cB1kUhXVsf6i1EhC2f3OMiD7
         g8y6eD6tc/gSLlKTjUAQzCOzj2DodvjnpFTX0TMj+ZPj2O2ObT+E0RbQAOG/7FbKQfnW
         2Z1Ss7xuqENFAkWdGM5jqmTOn0sSNGZsH7LpsjO2F/oQLZkBphUhb2whMrEHJG7ScbX1
         9UfnMefJ9z+m6f2w5cqVLfWeqZ4A/ZTbfnHBlM0g8WZRqnxKvyNCh6Vpj3R3q4imLBXN
         BQ1m8liOLJWHC8EAPUOkNVs5EXLE3XiVmY5gNBOFw/XnSsFCHgwDStyp/59Y3EKWfdHD
         5DvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772713537; x=1773318337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPy3h4xaTybaSqSbqk4gaOiETs94bm/62y+eylc0szI=;
        b=mPQqpKT3IfqE+FJWwqNkYJ/pQ/BPFfVMGmqxSeIaucm3frljTGfW7wFOdpPMKW2bjr
         ve6CahSNulCY9IG12yJ/0BVDDKFANyWhmtKfZqIZ3dHiDole2fwp3WH8+A2CCiS6OLx4
         zwNUvrUoDxGDQuxmnGjCfvk1SFTTc+Gafyl+7pPufdAo8d25jq2/TQGbI4SvuszeGeWG
         tgIqG80GGoHqnZ5/rBC5OzcDKxNk0cg0QdqVllVGMLtwehcMgy0OJZ93Mr0sN4QGBCA4
         d4FtJTGR3JC0yMW9t1VCSTohHy8SQdy0Dl1dGafeNtrYrU4mZcns0Yl0WjXhpmna//Zr
         vYFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiAp+8fax+dD0OyUKcThCue7xTYgwszQO8NZucHbGLT5Ewz7ui+snR4r6XDOPVfWCWqp5Oy8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjNRiUE4LOqhkPxfAgS9WMjvXqMMgYWfgS1jNdFEC2pwNzHGto
	/5yI43rfPf30jXk6lAIlR9SbzEiTH13eHYvWAuBnxY684eo+/m9APHwO
X-Gm-Gg: ATEYQzy6cWTaelRw7s522lgwvsxk4wvIVM8AZs+vJ2JJ4jSeh3y58G56nStd//YiYWb
	OEOQhtDT6ojIxWccoto0AFJiagIpeEMVNI4qcQf5lbHf1TOWlDF2axkAt3DvPnz4ik6+TR7ayhf
	binajlwdLvI9hK/bY0Sly9S6c4QrezNU1yj5/zQzMrQDGSfPRDIUSm//SJN4RZjLLXt36pEdMyU
	Ytcaw5SyUdb/bPzq5E5sw/xnYLh1DZkHeTOgvRxj2HjYozACCoEYXwOf2UywBGInRJsR2VoYevU
	MQB/C4tbsV5DA76OVMzsKsE/bVRPva9l/Fgqg9N5NjG19keR7TChVzo80X2sXjPsFL8bhpYenfF
	HTJ8HCWDP1ngsr91PcaBI/HP+Fj9mAqo4bm2GppjQt1PlFAH1ntZrJmTZWduz2Vqu4FN9r95kOX
	Ql1eH7YkjfV0UWrvFtIQyqgXocZAFC6rR2jQlZ+zVnhTCDS71EJrLClYwfixTxLFiU1L3l9lxB+
	2glhT1+S688qsHESoCukm+Km2lV
X-Received: by 2002:a05:600c:64c6:b0:477:a219:cdb7 with SMTP id 5b1f17b1804b1-485197eb4d5mr103855525e9.0.1772713537033;
        Thu, 05 Mar 2026 04:25:37 -0800 (PST)
Received: from skynet.lan (2a02-9142-4581-3b00-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4581:3b00::8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b8807a4esm30025156f8f.4.2026.03.05.04.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 04:25:36 -0800 (PST)
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
Subject: [PATCH RESEND net] net: sfp: improve Huawei MA5671a fixup
Date: Thu,  5 Mar 2026 13:25:15 +0100
Message-ID: <20260305122533.43820-1-noltari@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5B66C21194B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.39 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.77)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-264358-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
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


