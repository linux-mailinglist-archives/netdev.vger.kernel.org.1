Return-Path: <netdev+bounces-253120-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHO8KGhgdWkAEwEAu9opvQ
	(envelope-from <netdev+bounces-253120-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 01:14:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0467F547
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 01:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E05F300CCAA
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 00:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C97A937;
	Sun, 25 Jan 2026 00:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1xz5idX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82C48F4A
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 00:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769300048; cv=none; b=Gf4zKY4/4ZjS9ME724Zn4VkSkkEGWevJAeVsrs7o0uB3S5Et7E4bIbtdoghYJWflu6Kt9vQquDVub86K7eSHUyovjQ7o35Gq4oe6H+p/82kVtKkAWNU0uYPMdU85S4VN36RNEKh4WDjOps65jCvQZZQbKWwBCDNP/RJxDguzECc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769300048; c=relaxed/simple;
	bh=iZJach6s8qYLr3vpM42GbXz2jpGMsX7usKV8PgWY/7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nfmYvFSWEsdV8qai97y1HjAJ/WF4F/Oxymqoyp3kDVBVfpAerb4UTDrNrRyOxYBH0Blvbl9WRYxIQqehodPdYC6TILe0kJBlQBYyw5EnGyNqzIhRo4OIhZbJapzlDrcvMNXXQ2VEoBqxe5yMKmfuEzo7Lh1qg8qwaVDK5Q4XtL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1xz5idX; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-81db1530173so1745475b3a.1
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 16:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769300047; x=1769904847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLHzhuxm7a5X2Q49ADNkLZ5qYk8a4yH9AKsfa8IpJ8M=;
        b=I1xz5idXT1APTVI8Pzd5IY9kVrQIa/rMj6byotHR9sGlFOjP8kpK/bkxr3zTe2fxBZ
         h6F0nawGYsVwhZqQIqw5aqUUo6o4ZXlKnHN2TeEetbZEaOrEG66DDTRhkqz53KA4YiNn
         IDgUQ8uVUFEijITjgB4WGgUbFYO8RCkPrHIKjCt8EuFdkspuTKr5oROKDxr0irw6ZJQu
         mD+tgVDFksCZ/7Iu+mP4fuibuheuImSNkKj1q+pDMsaUZlpVonkfw9l06/qo2+MP68NL
         SIY/ntOd7vwWH3Pl3o7hav/QPfxfWWkQTKqwyidYD8loWjJBnUGW8BI86G7mxXJV6XU9
         EBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769300047; x=1769904847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hLHzhuxm7a5X2Q49ADNkLZ5qYk8a4yH9AKsfa8IpJ8M=;
        b=lHLWv4KLb90qaf1R43GSrrI4iLHwZBzWfM/6AjmIiY0ToceoUw2NRjetkjud2EOb/Y
         xCxFs7t+grETO3aQpA6Nb7tNAZHLbHqWMzznPBRem/Nj8v+HLnX22A/6llxPNepoGQWV
         2okBdJ2HR7YvQNs3wihNB57Zs8jLcJIjT2Jk+kAqIIiY26RFyZFQBigLg0KJ730ZwEiZ
         q1cuPVVMFHaTshV8gWIMp+SKcjIVoq2Ih+RCV6iwqNvR5VN75AjACQD7kKtSCnDH1C+T
         6UTuuOgzfgQSRyKqgs8vnrLnnP9cARXf7My9W0R3uExiJDjk3CF3ZxZqUGOZkdN5Bkiq
         kG9Q==
X-Gm-Message-State: AOJu0Yw7RYqEGrBQ9g7fUXg0cZ/3WegkPhzgOA4EqM2yfeL0t0p7xSi3
	TNTcJgrQqvR2/WSAIty/OKiFNCHJTbEKYteNqvzFbTVt/5/+FNI8hI79D6iNKw==
X-Gm-Gg: AZuq6aJOOvC2QbOCu4kX9PidatEJODGX/ttALM9/DTJqq8Z8f9tRHBKnWICasHp/nsn
	x++WGWIPAsfVW+BuWeQBeDfp9sPy5vxydOjQKULqSpvIKMt7zsgHQJfuJZESxDuBs9JRMcRW7kb
	DkcDsfhGK9F1AaIcSyEelIijTXxZ+GJPpVdfGra5CcbENAv5RZe9VvsEJcrd0gzmjAFXSH60VHb
	v7jcPMeizscrBlb2RoSF0m9+hYtCLldIohxwerah20oiUPH20wt6gHvxXmBk4Xa9ef8S0q5bFvz
	SX5TxHg+rrWV2ET8t7c1/PH48JcyKq3+4jrdvF4PKCh3OdsI4zHWdcyAQt5Nmx6Zntl8bhfzsaz
	m2X6qpx9f43KHECBJS4cOhkTf7wj/3SjZ0hrgzKDQyT/QkEJyGOdDCQjVdmftgq24FcdOpX9Dba
	zjtU1PT1NCeFBg/9V4oa5zoihE3s8dbTQxMyChLACi32xqKfhKV7vrig==
X-Received: by 2002:a05:6a00:23ca:b0:81e:af19:34b8 with SMTP id d2e1a72fcca58-82341286a05mr171970b3a.43.1769300047047;
        Sat, 24 Jan 2026 16:14:07 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231873ec59sm5683488b3a.53.2026.01.24.16.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 16:14:06 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 2/3] net: dsa: yt921x: Refactor VLAN awareness setting
Date: Sun, 25 Jan 2026 08:13:23 +0800
Message-ID: <20260125001328.3784006-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125001328.3784006-1-mmyangfl@gmail.com>
References: <20260125001328.3784006-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253120-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0F0467F547
X-Rspamd-Action: no action

Create a helper function to centralize the logic for enabling and
disabling VLAN awareness on a port.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index a4b346ddf8dd..880e3b5966f8 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -1768,6 +1768,18 @@ yt921x_dsa_port_mdb_add(struct dsa_switch *ds, int port,
 	return res;
 }
 
+static int
+yt921x_port_set_vlan_aware(struct yt921x_priv *priv, int port, bool vlan_aware)
+{
+	u32 ctrl;
+
+	if (!vlan_aware)
+		ctrl = 0;
+	else
+		ctrl = YT921X_PORT_IGR_TPIDn_CTAG(0);
+	return yt921x_reg_write(priv, YT921X_PORTn_IGR_TPID(port), ctrl);
+}
+
 static int
 yt921x_port_set_pvid(struct yt921x_priv *priv, int port, u16 vid)
 {
@@ -1818,13 +1830,7 @@ yt921x_vlan_filtering(struct yt921x_priv *priv, int port, bool vlan_filtering)
 		return res;
 
 	/* Turn on / off VLAN awareness */
-	mask = YT921X_PORT_IGR_TPIDn_CTAG_M;
-	if (!vlan_filtering)
-		ctrl = 0;
-	else
-		ctrl = YT921X_PORT_IGR_TPIDn_CTAG(0);
-	res = yt921x_reg_update_bits(priv, YT921X_PORTn_IGR_TPID(port),
-				     mask, ctrl);
+	res = yt921x_port_set_vlan_aware(priv, port, vlan_filtering);
 	if (res)
 		return res;
 
@@ -2021,8 +2027,7 @@ static int yt921x_userport_standalone(struct yt921x_priv *priv, int port)
 		return res;
 
 	/* Turn off VLAN awareness */
-	mask = YT921X_PORT_IGR_TPIDn_CTAG_M;
-	res = yt921x_reg_clear_bits(priv, YT921X_PORTn_IGR_TPID(port), mask);
+	res = yt921x_port_set_vlan_aware(priv, port, false);
 	if (res)
 		return res;
 
-- 
2.51.0


