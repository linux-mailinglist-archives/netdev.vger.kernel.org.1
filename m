Return-Path: <netdev+bounces-297975-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VQWHLTxfKmpOoQMAu9opvQ
	(envelope-from <netdev+bounces-297975-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:09:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5559466F426
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:09:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=c9nzDk74;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297975-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297975-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C756C3008C36
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 07:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBB03A5E98;
	Thu, 11 Jun 2026 07:09:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A993832FA14
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 07:09:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781161785; cv=none; b=jZyO9rZIloVihQswktNNMiPng+805mFNcGehW17AShM8NdCFmJKIslZqYAeoYQc738j2aopqYSvd2uaNSOD7KtynLnCIIMypx70tqOCDX9FwBrV/v3Tz4CvZX20RA1ljipLPmt7U5rmeu2hZZnmOUGgKtfdyPg5aP0N6PPcyTIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781161785; c=relaxed/simple;
	bh=LKZkxge+/v6SAk9zEBTdm7nNlWehxrJKWFBOkQa42X4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rkwXHQkJ/Fu3bPg+1/pWTwlonHg5rZAArp9Me9p4pUJQEPv5sUZQXclM+nBveyE6W4g0E3L+CqQyW2Egb1m1aPnEU8nEpFsYJXaQpHElRMtoSUzFKrgtY3912J4VQKr2d/J4p4h1BCd3zLSDwulL4esDAJBT6FWyQ5lOfbLSNtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9nzDk74; arc=none smtp.client-ip=209.85.214.178
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2bf20f6be6bso60337555ad.3
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 00:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781161784; x=1781766584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qc5McNJZWXcInPiqjiZYGkHhDZEjUFo5MulDJfEtkWc=;
        b=c9nzDk74r6kyHQcBdiR2VCkxckg8JHUr6ZN2hNPJV4AooR6byM8eEGrpWo10SDjAJ6
         y78v6g9VyjVjlUEDXlw4rDenobTTbCXPm6UITmhR8Qj8lzoltG/Tfk7huyQ1EyMu7mSY
         pVBCz0ROjHiFPOSkblr2XEhKwU/qCF7NFXqSAiswLFgAUg2eAMuu72dqcP3LgRi8PFmK
         bz/eYt/rbNMrOuXAE8QP7F21haGK/UrBJbSDXT9gmcNuKNU9ulAK6LjWMtuqVRjZasek
         QNTo3VKd+Q6tvRqxI2iTIQgx8FBEtgGVWahpU/Quo6/zPf0fTHwDojea2SvvD8ekEYl1
         MhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781161784; x=1781766584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qc5McNJZWXcInPiqjiZYGkHhDZEjUFo5MulDJfEtkWc=;
        b=q5cuV/twDxPYec0q4LC9PyVtBNAwA/Agpn3PUKRHi0V/MjJ/oVq0XxIc8RZ1z0Fwxy
         9woq2TaSZAo0rye62h+31qAc0xv1eXzzxyu0HJjp4a4dmOynOKO8IeJkXuo2UZFWEkmm
         2JQe8+hSyggdGXbMBR6wRW76DEWV5//9gvEMtvpGK2qmUOd24g5pMG0A2Y1HZtW+OIoQ
         m7LXTiyccXi9XFJmsWcr8TUhe9xJjTZZ+45ltp44sxy5QbJcLQ+VwAXo4tyt9+sXr5Vf
         hvziUs+ULCZSyv3tJyrx1xTE5GcKsleqSkoQmzCNQirELVyzjU6EuvQ7tVqRuBZROKo8
         tCNw==
X-Gm-Message-State: AOJu0YxJ8LJdd4Qz5T29J3wwcJgnO/rT9OkHVEBjLWx2UJqUA+gSIKoP
	/opn7wes6UqdmIXxxLEm7N0SoTHZvYzJX6GVDmVfl/K8qVJkhfysG4I+9iIyhwvt
X-Gm-Gg: Acq92OGD1pAuM4esZlPKfIvd92W1lrt4ugBL5IizP8kG2adSSO+5UV04nPFxCiiYcZi
	TofGV4ezT9Tah1q55hu/pDfatM9S7JpSGWn03q+YNHl44eM40aDVLph4dhzmgBQ4nb7C+QopygB
	VB3NAs3uuA/5qthAsiHjfJ4KTvnILvnyW7I4raKgpuRno1KgrhGICLcpu9dJ2olDPKZJHGDAh6G
	L2vh5sCMZzmdFDf0zG6OLeoXrG3YcPtT2/RF/Q7GqnF6ZKTeFJglQWb0iZIAejnGyccjmPjQX6C
	Ymz+yAIzekg+8DR7S2SgcvPP8DUvrA23o6fS/0gb6jpI482k5OJCyNoAklbljY6CK6/64ti3AwX
	fpV5AwWeJvn3Lc2xPbqzoUHJxhTCKhzvQ8BYE4pVCciV43kGhPpOytt73fSDOQXk83p0kJcJBwJ
	lvrR1399xGhWXsuyiw/YKY51IUsUBQqrZVRhkr9pmeI2JaQ34BFJDeawUUm2gF
X-Received: by 2002:a17:902:ecc4:b0:2b0:608d:d8a8 with SMTP id d9443c01a7336-2c2f0731886mr19433555ad.1.1781161783951;
        Thu, 11 Jun 2026 00:09:43 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661d:3046::4cf:39])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c2d9bb2199sm18818975ad.77.2026.06.11.00.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 00:09:43 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 4/5] net: dsa: mv88e6xxx: Avoid devlink resource IDs collision with PARENT_TOP
Date: Thu, 11 Jun 2026 15:08:50 +0800
Message-ID: <20260611070856.889700-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611070856.889700-1-mmyangfl@gmail.com>
References: <20260611070856.889700-1-mmyangfl@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297975-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linutronix.de,resnulli.us,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mmyangfl@gmail.com,m:florian.fainelli@broadcom.com,m:jonas.gorski@gmail.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kurt@linutronix.de,m:jiri@resnulli.us,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:jonasgorski@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5559466F426

The devlink resource ID for ATU collides with the sentinel
DEVLINK_RESOURCE_ID_PARENT_TOP (0). As a result, ATU_bin_* are
registered as in fact registered as top-level siblings, not as children
of ATU.

Whether intentional or unintentional, clarify it by keeping the real
resource IDs starting at 1. Unfortunately ATU_bin_* are already
registered at top-level, so keep their parent to PARENT_TOP.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/mv88e6xxx/devlink.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/devlink.c b/drivers/net/dsa/mv88e6xxx/devlink.c
index 0f84bffc8ef1..6f034841883c 100644
--- a/drivers/net/dsa/mv88e6xxx/devlink.c
+++ b/drivers/net/dsa/mv88e6xxx/devlink.c
@@ -91,6 +91,7 @@ void mv88e6xxx_teardown_devlink_params(struct dsa_switch *ds)
 }
 
 enum mv88e6xxx_devlink_resource_id {
+	MV88E6XXX_RESOURCE_ID_NONE,  /* DEVLINK_RESOURCE_ID_PARENT_TOP */
 	MV88E6XXX_RESOURCE_ID_ATU,
 	MV88E6XXX_RESOURCE_ID_ATU_BIN_0,
 	MV88E6XXX_RESOURCE_ID_ATU_BIN_1,
@@ -200,7 +201,7 @@ int mv88e6xxx_setup_devlink_resources(struct dsa_switch *ds)
 	err = dsa_devlink_resource_register(ds, "ATU_bin_0",
 					    mv88e6xxx_num_macs(chip) / 4,
 					    MV88E6XXX_RESOURCE_ID_ATU_BIN_0,
-					    MV88E6XXX_RESOURCE_ID_ATU,
+					    DEVLINK_RESOURCE_ID_PARENT_TOP,
 					    &size_params);
 	if (err)
 		goto out;
@@ -208,7 +209,7 @@ int mv88e6xxx_setup_devlink_resources(struct dsa_switch *ds)
 	err = dsa_devlink_resource_register(ds, "ATU_bin_1",
 					    mv88e6xxx_num_macs(chip) / 4,
 					    MV88E6XXX_RESOURCE_ID_ATU_BIN_1,
-					    MV88E6XXX_RESOURCE_ID_ATU,
+					    DEVLINK_RESOURCE_ID_PARENT_TOP,
 					    &size_params);
 	if (err)
 		goto out;
@@ -216,7 +217,7 @@ int mv88e6xxx_setup_devlink_resources(struct dsa_switch *ds)
 	err = dsa_devlink_resource_register(ds, "ATU_bin_2",
 					    mv88e6xxx_num_macs(chip) / 4,
 					    MV88E6XXX_RESOURCE_ID_ATU_BIN_2,
-					    MV88E6XXX_RESOURCE_ID_ATU,
+					    DEVLINK_RESOURCE_ID_PARENT_TOP,
 					    &size_params);
 	if (err)
 		goto out;
@@ -224,7 +225,7 @@ int mv88e6xxx_setup_devlink_resources(struct dsa_switch *ds)
 	err = dsa_devlink_resource_register(ds, "ATU_bin_3",
 					    mv88e6xxx_num_macs(chip) / 4,
 					    MV88E6XXX_RESOURCE_ID_ATU_BIN_3,
-					    MV88E6XXX_RESOURCE_ID_ATU,
+					    DEVLINK_RESOURCE_ID_PARENT_TOP,
 					    &size_params);
 	if (err)
 		goto out;
-- 
2.53.0


