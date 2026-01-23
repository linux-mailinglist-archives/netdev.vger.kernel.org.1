Return-Path: <netdev+bounces-252968-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OXsEevjc2mjzQAAu9opvQ
	(envelope-from <netdev+bounces-252968-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 22:11:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1107AD40
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 22:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A22F03023A5E
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 21:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533AE2F6907;
	Fri, 23 Jan 2026 21:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMaj5Fc4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A65B2F3C22
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 21:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769202652; cv=none; b=Bt5sdDmcF+du20DLPkeSP/sMA3ZORm3E1UOBScwIKt7PwOLHpNx7AgWlWwyAIiYmUpXIg3NmJcU8FqJ9gwtiiZY84tHviKAROe4pIeVLDTT/KdsgH/p3LU/Z7mNtbqcUmcjnjF2piTLeK1DO6NH0kzpGo2jYQLcvfXjpNBrDxuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769202652; c=relaxed/simple;
	bh=Be53D6pKmPcYdTpNJVEfk1jJ3RT4jCyrusGvCtJrluc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kyobV61LxmavyfuiE/OSsvWs1XwvOXcdvV/+4O+GnecMCoyzhNW5n38l18gSc+a+3O/vtHV+wizJd5fgjufuVh3d1WPNQN+cc48hOkz8/sywItjzIXVE1BaYoxDru1eF+G5YjDgAYnV4vaFixN065yPzddszZ9OfP8iGRJFfC/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMaj5Fc4; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so29919495ad.2
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 13:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769202650; x=1769807450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XaIB4jAIwQJAbyKIhxwkktHEa0cxLoXn5gAW3Xs2KS4=;
        b=QMaj5Fc4sVJ2T15Gw1v5TM8gWSuEnypf7OmCUx9joBkgaqCCzZV7jgGlOp/bz6AaSM
         dks/hDqAIu+0hKBJOKRb5pn6SCescAYfbdPfgiA+B1wMOxkOxylkdku/prfFfrw/QFyf
         qRpSZTyO6d6+VIcpXy2yjpD62dhREivFYwYTAq3DbqTfVs8MoukEr6BJxiyJR/Bssu9p
         6QoLV3IUXDEa0hmOw9k+nODKsB3ue9nFNPLftomklW/r8oFxt9ORFMSYiJWTP++ID252
         pDUfBDJTyLbdpaNlEratYc9lOq7J1vfg3mZ18IotiNI58vsUFlR+rng5GXxanX5G02Ky
         dcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769202650; x=1769807450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaIB4jAIwQJAbyKIhxwkktHEa0cxLoXn5gAW3Xs2KS4=;
        b=WSaOA6Y8Y4xAkzsMOPDLQ9LR4DpkabIjgN5AvQe6UV3zvBLRe0i/MDW69lC8hv/gKj
         GEFK2bsu0mHlRCOpNPkvF8yYV0eGoLaODQ3JDTiIaIpHn4z5si9xZ1+xN+HaTwnKZayj
         l6jyOGGZjaPxeQvgzwGi0QCZXQVizUslJamnsDQ0bdpdi3iBPRTVavZtJcQw24JVKGyE
         1RPATlq1PXPNl0aUmfeWBEwEiisJvH7RmMgnSvY7TeQrUg+quCrYZOUOh1gaOfII02/t
         4sj3HLSIkh7gpY854RlL9atOILvctBaC1zVbmA2dw41zMtyiAg4IrBHEAnY2cyr1zJem
         s9kg==
X-Gm-Message-State: AOJu0YylWDwfNfM50jnS76lfju3ilxw0JrcRH6T4dRDsMfGpC81rdfln
	z6SDageUD+I+XQJjEYeoOOYSGsc9b+u5D8YQ3h+XJIvprJspNtsdx8U=
X-Gm-Gg: AZuq6aKgdhPDm6u2eoKiBwt8ba8j9X+u3u7HGUnfyTqOgKZVq3L+NbxAr82H91QeMrp
	a48EW2R2o0YCZU9LVUUiqVLrsi+2Ufo7lUcdxs2IOHSLa6BmVq8u2e1nHwk9WA3Pmf3xzxMCvLS
	o4WF+uEwWFsJBjt0sIo9JQNPdcxO5je9HoZxpIYQjT2zzIardi610lE7B2UssckyWqrnWwO4+w5
	EZNrCYe5bOqcnzoQzIYSC+CnX6d40QM0wBKhoYizEqlmTBPJb5MgzLunVxmRNMdzEyhZzQYf8PK
	QzqqjlL9FCad3G+e5D2yYY5zjIoJM9giUgTq0Ikl6B9w1E1J1Crm5Lz3XS5H1LVTXdsIVTdX5VO
	fCcCvj2fiQcuK2DIN7f+tP9xQpfn2Q7sapaxpz/6Lr4E3O7V5d44HDDglnXSL2Wsb1HIYeEV51R
	NN7Tg3LkDUIj3pRlA=
X-Received: by 2002:a17:902:e5cf:b0:2a0:8be7:e3d7 with SMTP id d9443c01a7336-2a7fe75c6d4mr40090285ad.57.1769202650382;
        Fri, 23 Jan 2026 13:10:50 -0800 (PST)
Received: from DESKTOP-BKIPFGN ([38.76.140.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802f978b8sm27313745ad.46.2026.01.23.13.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 13:10:49 -0800 (PST)
From: Kery Qi <qikeyu2017@gmail.com>
To: jiri@resnulli.us,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kery Qi <qikeyu2017@gmail.com>
Subject: [PATCH] rocker: fix memory leak in rocker_world_port_post_fini()
Date: Sat, 24 Jan 2026 05:10:31 +0800
Message-ID: <20260123211030.2109-2-qikeyu2017@gmail.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252968-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qikeyu2017@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB1107AD40
X-Rspamd-Action: no action

In rocker_world_port_pre_init(), rocker_port->wpriv is allocated with
kzalloc(wops->port_priv_size, GFP_KERNEL). However, in
rocker_world_port_post_fini(), the memory is only freed when
wops->port_post_fini callback is set:

    if (!wops->port_post_fini)
        return;
    wops->port_post_fini(rocker_port);
    kfree(rocker_port->wpriv);

Since rocker_ofdpa_ops does not implement port_post_fini callback
(it is NULL), the wpriv memory allocated for each port is never freed
when ports are removed. This leads to a memory leak of
sizeof(struct ofdpa_port) bytes per port on every device removal.

Fix this by always calling kfree(rocker_port->wpriv) regardless of
whether the port_post_fini callback exists.

Fixes: e420114eef4a ("rocker: introduce worlds infrastructure")
Signed-off-by: Kery Qi <qikeyu2017@gmail.com>
---
 drivers/net/ethernet/rocker/rocker_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 36af94a2e062..2794f75df8fc 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -1524,9 +1524,8 @@ static void rocker_world_port_post_fini(struct rocker_port *rocker_port)
 {
 	struct rocker_world_ops *wops = rocker_port->rocker->wops;
 
-	if (!wops->port_post_fini)
-		return;
-	wops->port_post_fini(rocker_port);
+	if (wops->port_post_fini)
+		wops->port_post_fini(rocker_port);
 	kfree(rocker_port->wpriv);
 }
 
-- 
2.34.1


