Return-Path: <netdev+bounces-304738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Yg3fCmGcSWrE4QAAu9opvQ
	(envelope-from <netdev+bounces-304738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 01:50:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE4A708A96
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 01:50:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=KLiZf2kF;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304738-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304738-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2ED513012EA1
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 23:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CA539AD49;
	Sat,  4 Jul 2026 23:47:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271EA30C14B
	for <netdev@vger.kernel.org>; Sat,  4 Jul 2026 23:47:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783208859; cv=none; b=QvsJOJS6sB+OIQ1QSLVCAnZr8HZ7enOZBEKefASFVRgBamQ/I8boJ8epNr4o/JY3eqhWnhPuEY5Vg4KWiE8ljrOqTXWhT0Nq4Ffy3ssrQU+FnqsabEGtBKx5SdDiyLRmhW8sEgl1o5JoRaHJBrdHbanYDsl86fRq9qmGMmKU5iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783208859; c=relaxed/simple;
	bh=XRhIVVXGg+e7/ghtao2LStSD4aCHgtklHbpMTVfJ10E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ocj9IjuOuHxnbXH2C0TlI3CmynDJ5zalgQ50brVNTz8mVJOuYELsc+XISNa+rh+hWMlwijlQEAkwDnOr+m3Qw0q8V2VioZuK24GbN/3prJUiw0844aOrP2iYPqYmdXKWvHGzViVRUt4PKfUDsi1PJD6HYABE0QznMcNtIm7RYdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLiZf2kF; arc=none smtp.client-ip=209.85.210.180
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-847a483e344so1377439b3a.0
        for <netdev@vger.kernel.org>; Sat, 04 Jul 2026 16:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783208857; x=1783813657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LAV38zDEB+lLR8E4aIVKK3GslMa+YpWK0KGFz69oGdE=;
        b=KLiZf2kFRfJl9XHzTEX4x62bzRXhO1klmCvPxzk06fbIfZO8yRH6cPCGeldzsP86Li
         q0xwpU4PN8SYB+42cwfdI293HfyNXzfSDs9pDWxdho0kYVA+TfrCgTl9KWBcnUppyWwY
         JY8mxCm5Th/krzt/MNGT8PeSFxDsgcZFMSzQ2ZiG0uSDTmB2kh1ahTI49b/y3D4nXuF5
         47UI3GF1hSheMqozPo8D+AZCfGb16tzf3mHU+H/t61YrxYKgDlDCUwZWra4NXPKCLpq2
         jcKMDkEa1XKNuJCJ9kimDmYvH0WN5igrZSYIqp7f/SKcWes7VEFZ73WpbZ0IwlTiPCBs
         Zorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783208857; x=1783813657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAV38zDEB+lLR8E4aIVKK3GslMa+YpWK0KGFz69oGdE=;
        b=WpYHZ4Ekzoz1k9uMlnJNZRnUs8t7BsZlWRJpsRDm7QltKbKGDPzYDUoJv+XVnkT1hj
         OeKNIk2gBu5HHc6wb9Xel2FtBESQMEpHQCLP3HlmSJ7eQSHme9P3B+8Bk46wAwET8lmw
         MpmvDRMzjUDFh9FYNbqy5OciN3Y4syOZGMLj7HtHhFtjhqsfnWQBSNaPopEVzfTWtIaG
         fLgaCDhMhuppzAwxJqzdUefXyGc2fdCYnIJLbh+X8S21LzQ6ro2DejNlE48NhPfKs8wq
         kq10Awhq4Vl2fdrOuvpQh8bAe6AJjBYkDkbRzCsEdduw4E6xtakiddaAcDRc8MufiTv2
         x1GA==
X-Gm-Message-State: AOJu0Yw3wohfHCtzFH6ZbqxM2vlSy4DTUzGMfzZkZl9fo1aBaL/FNJ6v
	0vLkLmGR7XWm8E+fS+jH5bBezIUUzM42x/UDiVsmT/F3l4o0z+IWqkUpZeY5CQ==
X-Gm-Gg: AfdE7cnhVFrP0e/q0xpvFecY1d0p9euYrcpNrrEV7UymRiwJlO8QHXLRXnEFZCTxUac
	PzYTBxYMMR4YEAN4E5mTS20bwqW9WpEYhZR7QaiEc+1LV6vKacIRQAHms8nbOszGIL0gvIZ5pjm
	we1N+FSX6qUAj1p/QrAj/My7Obwey9o4UeoZKeYZUpZVE9/cgezucHjG2E9WUlUj1LxP6XzRsDB
	5H1NdDZiL8Aagn1fhwiJAf3cAjnvPKptx08fRSotwsAxjh6pr8KIXi7twSZfXSnzrDtSD8vUtBY
	ezdn7kV1heaGk82PDlSTAbpJ5xQjUhgKJawDURTpKkIWDL8R1dBVABqAJ5oKQvG432cGwGOx9To
	ZD7Mk9RkbTn5rFC3bGj0uyYB22LKslGUyUr4KD6Ru/0yUVbEIkvrRn6KuNC58XHFSUpB9gfwnSl
	3lRD90xuTA4wqT8CHZiHrdNRLH2OIMq4tUbKoLKNk1OUAsYwvIaKAmJFWPFZWfVirz2Dr6i0SCJ
	6+f4gaDWQ==
X-Received: by 2002:a05:6a00:1743:b0:847:7cf2:a8ff with SMTP id d2e1a72fcca58-847e190526dmr8079170b3a.30.1783208857480;
        Sat, 04 Jul 2026 16:47:37 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d82382sm1609264b3a.49.2026.07.04.16.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 16:47:36 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net: gianfar: fix use-after-free in gfar_enet_open on startup_gfar failure
Date: Sat,  4 Jul 2026 16:47:34 -0700
Message-ID: <20260704234734.1779991-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:claudiu.manoil@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304738-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7DE4A708A96

If startup_gfar() fails in gfar_enet_open(), the PHY remains connected
and IRQs remain requested. Since ndo_open returned an error, IFF_UP is
not set and ndo_stop (gfar_close) will not be called on unregister,
leaving the IRQ handlers registered against freed net_device memory
when the driver is removed.

Add proper error unwinding: phy_disconnect() and gfar_free_irq() before
returning the error.

Fixes: 80ec396cb6b5 ("gianfar: Don't free/request irqs on device reset")

Assisted-by: Opencode:Big-Pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/gianfar.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 89215e1ddc2d..4b3a5eaadfb5 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -2878,8 +2878,11 @@ static int gfar_enet_open(struct net_device *dev)
 		return err;
 
 	err = startup_gfar(dev);
-	if (err)
+	if (err) {
+		phy_disconnect(dev->phydev);
+		gfar_free_irq(priv);
 		return err;
+	}
 
 	return err;
 }
-- 
2.55.0


