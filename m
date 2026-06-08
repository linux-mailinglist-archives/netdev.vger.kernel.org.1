Return-Path: <netdev+bounces-296366-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fhsbN59LJmoCUgIAu9opvQ
	(envelope-from <netdev+bounces-296366-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 06:57:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 472F6652A9A
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 06:57:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=j65H1irC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296366-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296366-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31BF2300809D
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 04:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A14348C46;
	Mon,  8 Jun 2026 04:56:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B482771B
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 04:56:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780894619; cv=none; b=ITowywGKSKbcikZthOaCHhMGelWF7vkXS8gdbqYu664DVHJNi+UMLYMBILOKlPKWztOdsW9R4jyXuPiuW/s59FxuRa0C3kocilg2XUfMc3D5eQhtEMEOsjsQbyMZkdQ1N2QLc+nA7RVcak8FiKBzgpYJVPgFt+u3T2WvostkSP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780894619; c=relaxed/simple;
	bh=UxPfLkXqVlLOC48avJUerJTK76kgWBRfei3wU2Rv2Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f1VTE7yAz03UhNmpuBxUCa7Kw3qi5CiyNVr8gfy0haLHR9b/V1KvFsXG4KGCQ8z+8NOJvIwHjJRg1ThtylRC6VERNwq2HCXr4hP6mX5eD9HrK/6jeAy/CAf6zGYytLFnG2e5pY2yuLDoK8B1p3TA+p2vh3XSkaclwPg4UUxauG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j65H1irC; arc=none smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bf237e1433so44482555ad.1
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 21:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780894618; x=1781499418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hcfRELKVzsufQjiMAtIWYOk3+MKhEkU5OXgP88O0/Jk=;
        b=j65H1irCEeE9O2ulER8wfz+16eFsdHdQW/P+ojCSW70KaJstqG2wxpT/z+qHQYOFzQ
         6dkUqUUkBQFyHg/62rUFxDpWhcLQPouYEW5tsHDR5L+5k/qZE++lW8Qhf66u1v2xPMkx
         4ydAM1en3UWOyRJhC3m7VRCgMyrIuZFiMngXmAZ4ep5npUloKkNmD5JBWHyleA4sNsgJ
         l2nEF3x++jCNEBT/xdtT6jGK0kwjA2SgjXgvVWsefk1FpN2qs0GOn/t7dP6mKM43Po5K
         dHDzCs95PeCWgSV+89MmGqQ6upDunJ5VvyB0+QP6Z2ya0+KFQjUMFn7jwq9FKdDoI08F
         0AtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780894618; x=1781499418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcfRELKVzsufQjiMAtIWYOk3+MKhEkU5OXgP88O0/Jk=;
        b=TZjwO0ndTJ6c+l6aVqIe1DAEX9bWp9BE/jkGNl+eihQ25wb4yNjCGLLbaxyPBcydPj
         MIqL+Q7GYEpcAGpcQIdqvA5I8FyZz+DFZG9GT1RziqblxdL8Kze9RYGEnYtdFWhJjltp
         yfLDws0sYurgJC2hlyGGqzPq9/fMUJREcy80vQaqsHz7j7yhJF1JKhScCWHVOMhfdeuv
         A/SobjlcCgJ4+kJbXUS1y0eReiZBDOzF1jYg26qYXCsqlAWBlAtEZ0l/LHqUgGeLCedh
         uiFFxWnn4pn71ptf5LMTp3kjJ3P2c1KWpftgNM/bjIqRTj28r0kiMHnE3EF9ppoC0JlZ
         dsKQ==
X-Gm-Message-State: AOJu0Yz/ckNdplnilyep7g9hjAXYLmPYDvuGLRncx4ijZq8kDfQ+vtkE
	Ko/3Gg5UzfSxW/i3hILw8Dbl4+PqJmqZkhi3yOZJEYQeGEOuRs1jAkm/U3g/Vg==
X-Gm-Gg: Acq92OEN7l/xFMdi0qqYJNTjCk15hiouc+ggRMRduyDFaY7JOOh2vblYbgv5X8q9Zrw
	WFkWhjc5l9Stnv8iuSLiF1XrGwatMNsFZX8nl8nWCezp8DmPPwC0mR+0fg9BjlqGASbejJF9qsF
	6e1gVMF7FDu7NoXp1B7FDkH6YfLlgZUvNY2BtS9Emapvdm2REyUly58mA+Iz2N8GXKV84V0z1TG
	ua131WKuE78Glpbm81QljWBjhQZUlIYwbIIElM9bLjbDxeKTWiGGMCNT0K3R3LVBzyo3bD18VQ3
	rDjIVmOYgAi/fnZ6VdrWidUG/IxT1w9QIN7d94NljdJ6hh0ucWrWMNiYxpq2a4BV1Rk9diaIiCN
	GvwGQL7J3l6BkA18c7yyTjXQUi67c360EG8wohVIyEdvryCiEHjI2nImRT9ZDyxkVUlW1acbVG8
	YjzAALEaRwsZKm86POpVt3GddhIbNxcRiQNUxE75ckrgCRjoZwUd0bNUUA1z/ue8Vj9mP80304G
	cPZbcm2VskxkVsBUNOR7GmTMOGsd/gwHtgFz8lACqgL4w==
X-Received: by 2002:a17:903:faf:b0:2c0:db23:4c4 with SMTP id d9443c01a7336-2c1e82191bamr152609735ad.16.1780894617827;
        Sun, 07 Jun 2026 21:56:57 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164fa0236sm173041715ad.33.2026.06.07.21.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 21:56:57 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net: dsa: hellcreek: replace kcalloc with struct_size
Date: Sun,  7 Jun 2026 21:56:40 -0700
Message-ID: <20260608045640.5172-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296366-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kurt@linutronix.de,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 472F6652A9A

One fewer allocation for the priv struct.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/dsa/hirschmann/hellcreek.c | 14 +++++---------
 drivers/net/dsa/hirschmann/hellcreek.h |  2 +-
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dsa/hirschmann/hellcreek.c b/drivers/net/dsa/hirschmann/hellcreek.c
index b369c1cc89e8..2c6cabf61143 100644
--- a/drivers/net/dsa/hirschmann/hellcreek.c
+++ b/drivers/net/dsa/hirschmann/hellcreek.c
@@ -1932,29 +1932,25 @@ static const struct dsa_switch_ops hellcreek_ds_ops = {
 
 static int hellcreek_probe(struct platform_device *pdev)
 {
+	const struct hellcreek_platform_data *data;
 	struct device *dev = &pdev->dev;
 	struct hellcreek *hellcreek;
 	struct resource *res;
 	int ret, i;
 
-	hellcreek = devm_kzalloc(dev, sizeof(*hellcreek), GFP_KERNEL);
+	data = of_device_get_match_data(dev);
+	hellcreek = devm_kzalloc(dev, struct_size(hellcreek, ports, data->num_ports), GFP_KERNEL);
 	if (!hellcreek)
 		return -ENOMEM;
 
+	hellcreek->pdata = data;
+
 	hellcreek->vidmbrcfg = devm_kcalloc(dev, VLAN_N_VID,
 					    sizeof(*hellcreek->vidmbrcfg),
 					    GFP_KERNEL);
 	if (!hellcreek->vidmbrcfg)
 		return -ENOMEM;
 
-	hellcreek->pdata = of_device_get_match_data(dev);
-
-	hellcreek->ports = devm_kcalloc(dev, hellcreek->pdata->num_ports,
-					sizeof(*hellcreek->ports),
-					GFP_KERNEL);
-	if (!hellcreek->ports)
-		return -ENOMEM;
-
 	for (i = 0; i < hellcreek->pdata->num_ports; ++i) {
 		struct hellcreek_port *port = &hellcreek->ports[i];
 
diff --git a/drivers/net/dsa/hirschmann/hellcreek.h b/drivers/net/dsa/hirschmann/hellcreek.h
index bebf0d3ff330..851822adb09e 100644
--- a/drivers/net/dsa/hirschmann/hellcreek.h
+++ b/drivers/net/dsa/hirschmann/hellcreek.h
@@ -280,7 +280,6 @@ struct hellcreek {
 	struct dsa_switch *ds;
 	struct ptp_clock *ptp_clock;
 	struct ptp_clock_info ptp_clock_info;
-	struct hellcreek_port *ports;
 	struct delayed_work overflow_work;
 	struct led_classdev led_is_gm;
 	struct led_classdev led_sync_good;
@@ -297,6 +296,7 @@ struct hellcreek {
 	u64 last_ts;		/* Used for overflow detection */
 	u16 status_out;		/* ptp.status_out shadow */
 	size_t fdb_entries;
+	struct hellcreek_port ports[];
 };
 
 /* A Qbv schedule can only started up to 8 seconds in the future. If the delta
-- 
2.54.0


