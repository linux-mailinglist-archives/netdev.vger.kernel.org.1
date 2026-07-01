Return-Path: <netdev+bounces-303537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Xm9MAbnNRGqc1AoAu9opvQ
	(envelope-from <netdev+bounces-303537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 10:20:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1516B6EB078
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 10:20:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=kjIp1lIa;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303537-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303537-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 369A1305F72E
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 08:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357EF3D9DDE;
	Wed,  1 Jul 2026 08:16:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E563A48D5
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 08:16:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782893783; cv=none; b=KdHkgYosNa4lajZLYcD7WHoy2JQa9CaOvmt1m15dz2opDqCkwqjdBj7bnOjWKn8oowDUBY7+bBqPSO94J1PbUmYnNi7AkupySEkuYG3GA9+KQFFQ4uOupNu2bjaNUmw2qt1DLsIKnq4xA64ukuZxziwzgBX6HhQVk2PIUFDi5Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782893783; c=relaxed/simple;
	bh=177yDnaR9yPvT58j2LfyrOVRkGL76Chc8Mj0N3D33Xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gPZHp9js776OZGfblarN2tH2nEUW0xMXggFkGo8SbcJVWiGPNkZa/jvcdm9pRMsjTNEWhX+OEWlsrQN4LI+Rj/JJ8kZ+ckC4w4xK9CA6BsBx2YEML6Dg3CgLb4GruTjSqFJxea7sCm785myxxLA9k7oE6KxW3fioGiIclz4YFe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjIp1lIa; arc=none smtp.client-ip=209.85.216.53
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-37defb2f231so167806a91.2
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 01:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782893781; x=1783498581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sw4CMyJ7o4eJHTpqYUHzkvZXiVgvqV7kRPHSd5Gk6d4=;
        b=kjIp1lIazDuiSy4r9tE2SA+CRp3loAP/8OzXrA9ebpQLgXWhvIiGuFFlsi1jhPeVPh
         /SVjNircpn5yDOEdmN6KzF+N5He6tXsf2UsBCPysDETpqp/jNsp61IviJs9ArjsR9alb
         a3wsuzLAyZ5+WihmeIqRXAUSfg4faNaAlVrhrjI9JlGMtN8Z4RSQLc9R9+Kv9Fo/rSmp
         0gGy3uIjYNuOVztTp1mSnoZORyMB4dVL/j4gxcUZSsSJoTrw8kP7hwkEc2noZIKI2c02
         D2QHw7VAppYcFoxiAyS9SVPtm/JTlPcsE43ObLajDznagMl+87+7lVCi3v0GTvcPMDUq
         ST8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782893781; x=1783498581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sw4CMyJ7o4eJHTpqYUHzkvZXiVgvqV7kRPHSd5Gk6d4=;
        b=O2qRc0y+PqFNYhiJOUU3zMAVPxcoozgGSLqy0oWQS+O9AGc0+Q/PaeRs0LvL+DlUCb
         FPgUbQgiMfh4EPZnROtYmxcIGqBTTp9O8FU2fUxF9uOPsamxn7tTCEv7cpZ66PBL0SvL
         XeyjQI3WkA5QFkfBz6KrX0JYXjcgLt9DY6kEVcHZRdcVcEydPKHvLhiUuM4/OQH4SsBo
         aZj7XTN7fDEeL43U9WxGhboINqoPSBKRmeS9YW9aM/9XVNx5zCE+QnfeyEwpRc5zJDgg
         kOFVq09gFdaHAwVIDK8Eu4Td9J34kh93ElGd5LJ3kWPZ8zIySQv/n+6eoeDuvHSaQawq
         idUg==
X-Gm-Message-State: AOJu0YzwnF1xQAJOLz62kwFNuF+ZiEEoKdkEztZRbzLyuVHGRu5xrT6/
	7wvKkKbgCBMfS5Lb55PSjFugpjF4ZqxJoxsbn4cqutNaPrXwUTEkYTOR7+Erou/K
X-Gm-Gg: AfdE7clRS/EE+pG6f5laS199hqQ9EXGDgCGD52e0tlwUV+LDi8M1bHoPMmMN7Wfr0CB
	X70O+TnxHyFz9JkxWB4zPx28XbYdh1syW1u6AdDmoiRh8NRwRMhzq3sd9/NWT7Io5M5d8nm91vD
	NEJAeVkRO8wVMVS5afT3FIpaOxBPFk++N6pitbfaPcL8Fm+ZmD393+WEQxVEaPK+vVxArqx7g0M
	x5SOAvGpx7dscM67ueCbQYWk1E+NHZGuegro3qinGHqvHhGF0dpLXPF3HY5/iWp/djd8V5wI3Hg
	jCDlbS60Yjxdlm6I7TU4s7kA11p8cGCgYQb8d8D4JMZFXf9WwcUkDoHOzZjU8kWVvCrFF8WtJBv
	UO/ygnOp2auQlu4s4tTdlEywBlJVgjitH6VKm8J9IYPAbUYZAnqKEwVZghYbZRYQ3P/K8EOAWwj
	EWMNVgDdhjfDpbXe2/iBBDVNRvfN8=
X-Received: by 2002:a17:90b:3dcf:b0:37e:1ff4:44c0 with SMTP id 98e67ed59e1d1-380aa0f4adbmr625565a91.12.1782893781227;
        Wed, 01 Jul 2026 01:16:21 -0700 (PDT)
Received: from amd.com ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3809641c894sm1364627a91.11.2026.07.01.01.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 01:16:20 -0700 (PDT)
From: Paritosh Potukuchi <paritoshpotukuchi@gmail.com>
X-Google-Original-From: Paritosh Potukuchi <paritosh.potukuchi@amd.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Paritosh Potukuchi <paritosh.potukuchi@amd.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v2 2/2] bonding: reuse neigh_setup from slave neigh_parms
Date: Wed,  1 Jul 2026 08:16:00 +0000
Message-ID: <20260701081602.3185086-3-paritosh.potukuchi@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701081602.3185086-1-paritosh.potukuchi@amd.com>
References: <20260701081602.3185086-1-paritosh.potukuchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303537-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:paritosh.potukuchi@amd.com,m:jv@jvosburgh.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[paritoshpotukuchi@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[paritoshpotukuchi@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1516B6EB078

bond_neigh_init() currently relies on the slave device's
ndo_neigh_setup() callback to obtain a neigh_setup() handler.

When an initialized neigh_parms instance already exists for the
slave device, reuse the neigh_setup() callback stored in it instead
of invoking ndo_neigh_setup() again.

If no neigh_parms instance is found, or no neigh_setup() callback is
present, retain the existing ndo_neigh_setup() fallback path.

This avoids unnecessary ndo_neigh_setup() invocations while preserving
existing behaviour.

Signed-off-by: Paritosh Potukuchi <paritosh.potukuchi@amd.com>
---
 drivers/net/bonding/bond_main.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index e044fc733b8c..d2e4dae4e97c 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4719,7 +4719,7 @@ static int bond_neigh_init(struct neighbour *n)
 {
 	struct bonding *bond = netdev_priv(n->dev);
 	const struct net_device_ops *slave_ops;
-	struct neigh_parms parms;
+	struct neigh_parms parms, *p;
 	struct slave *slave;
 	int ret = 0;
 
@@ -4727,6 +4727,14 @@ static int bond_neigh_init(struct neighbour *n)
 	slave = bond_first_slave_rcu(bond);
 	if (!slave)
 		goto out;
+
+	p = neigh_parms_lookup_dev(n->tbl, slave->dev);
+
+	if (p && p->neigh_setup) {
+		ret = p->neigh_setup(n);
+		goto out;
+	}
+
 	slave_ops = slave->dev->netdev_ops;
 	if (!slave_ops->ndo_neigh_setup)
 		goto out;
-- 
2.43.0


