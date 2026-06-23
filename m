Return-Path: <netdev+bounces-301250-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bVe0N272OWrezQcAu9opvQ
	(envelope-from <netdev+bounces-301250-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 04:58:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8785A6B3A94
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 04:58:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=GBlxLa6Q;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301250-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301250-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 428C3304E0EE
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 02:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD543876B5;
	Tue, 23 Jun 2026 02:58:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B125F3845C1
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 02:58:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782183490; cv=none; b=Okz32plBei7oRBpeeVcWPHpxOqs5+DTrKPr2D8likkGN9wk72dG3ZNvgWEt77GcMB14p3AUaK5j1LcGGVqBijng0arjXEZqUg7WlDW4Lp4f47b8+l/mk6xahs6KZ4ipOT3xB9adMmCHGqvALKmDUJ10FU+ZWO3hw/W6Hyw+Bhmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782183490; c=relaxed/simple;
	bh=10LxfMihCDI07JP40FbER5KATJ7S8AnZMvYM5yOOyjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YMTQpR6u8nG/6IB7z49GVCsXVdbuBYd0Q3jrYAqTML1oKACRFF8gxDzj2iP1FKWKiqWf60bII4iQ99kJStVmbjxewl/peus5WOidAIeJsLi+p3uyv9lysJPzVxRlwJ8ozfYZLy4RV+MyCfudG0any7E9e10tfiJ0QPuHnCvZXuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBlxLa6Q; arc=none smtp.client-ip=209.85.216.43
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-37ce68a54f8so3132526a91.0
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 19:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782183488; x=1782788288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+n6BllR4lDnKy4Yg9p1K0cx3Xigbsi+B/pKNJ/jZbsE=;
        b=GBlxLa6QPx7GNPW0R5q61ecBH+1BNHhoyWqQvHFjL6Lg71rJ0UjRIKqRuhwHaamczO
         BnpsVWQmDsUc5r4sxfEIpVjiSODWlpscD1tgCVgTYaZ0sttT0f2C7xUUATLBfn81EecI
         iMhLRV03IwKw7HNnTG0qT0upKcGSm8rOzgCTUZYy6hFn2ciNVuqYxhOUbqgW2oJdto88
         QAQcb0gyfA/v4s7VS/c8LSgz/ZLd+cIwzRbQUDTxN60KeaK/VxUa602wuiRZ4Hv3erNv
         BqSmZ2KzwnBkTaq701AN1khtvzmgV5USRigJkYLw3ya7clA31dXWCKkgeKWmNUNJsxYh
         HQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782183488; x=1782788288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+n6BllR4lDnKy4Yg9p1K0cx3Xigbsi+B/pKNJ/jZbsE=;
        b=QszMQTJVjir/JpEONmqbAa7H9ycNjsiv1mwJKbHAACHMFaplOG3/UfLV/6dKbqyx2y
         1Cyw2VBGusrZ7dvojkcc5eVFW3XqC4+hmI0dbLrLeAP//Efzbcyq8yrzP73/a6V42ZRp
         O+ka45Knyqx4fqv28aLgPzTwRNIOwwtS2h4fOzGqVZpKK6DYG7p9nSHgJ9ijLvndRFAb
         oH8x/x9lXuA+xoVSGRWoK3vSPTEBAqYxYrSWXmN+PF9LUIWas1YBrr9e5cRU2VIcgbKw
         hwEfgdnsG0rTMweyBgZq79twqvP0jJL9et5xJDuF9j2j3QZP/z53Tk1pWxUREpObhxiG
         zLWQ==
X-Forwarded-Encrypted: i=1; AHgh+RpVy9gsAGiyvhGFAsvDZhiJAkSLmD9xHsoZUCgrOUTD7ss1FaHB0j737kEOuCr8/4GI+SbYFUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpCEd6z4PeanBaUdr+TKkK4Wopyd18ExRQHRV7YPPrvyquSPVB
	yZtKeQKxqa0N1Gqw5Qfor394FZJB/DSQGfyauhW8Qvembqr+2aO1bKCx
X-Gm-Gg: AfdE7cnxMFpk/ftxRCoO4wf9Q+jy9jfhSwXUIxlE5OyZThH2gCKq9DL7wkj+uQXhsM+
	I4lj9ZgIGh3KjjoPAobhwqydbeledrsZrzfjIzvhNb4zunlXyVWVJOgMfN6wRvoKEaGlOh7jGtx
	MrGCF3mqPrIbAnI+MglWSg4duBSDyKnKtCMCUpHwrpExpkP8IFD748LXBqa2F5UQOrbRWLjFL74
	kHtn3fh6sNps4Vl/86JvGZBqxF9SDSvBUJx+0EeppS74TTxAcoZOibdKCdSfgpLukQMBh212Ls6
	ziZFquUSd7h+vQOb1I3LR59nsxkbh4rupo9B/lEkTsIO+Jnwv/geX9iVqtcJ0MVD+xia9sSv6t+
	626xTBESVF7kepfsTjXJAP6ow/Df1ozw2igKMAAtFNxQ4wJQVfajXD4TR0rK4gWfzxBVvMS+y0X
	OD3QhleDGjlyBzWxTls5CuRyGpOcNDgahpB9prRKqLNRI=
X-Received: by 2002:a17:903:41c3:b0:2c2:245a:3366 with SMTP id d9443c01a7336-2c7c76ea630mr10145015ad.27.1782183487772;
        Mon, 22 Jun 2026 19:58:07 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:932e:e78a:5805:78b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436af305sm101944795ad.6.2026.06.22.19.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 19:58:07 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH net v2] net: sungem: fix probe error cleanup
Date: Tue, 23 Jun 2026 10:57:59 +0800
Message-ID: <20260623025759.3468566-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301250-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ruoyuw560@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ruoyuw560@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ruoyuw560@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8785A6B3A94

gem_init_one() calls gem_remove_one() when register_netdev() fails.
gem_remove_one() unregisters and frees resources owned by the net_device,
including the DMA block, MMIO mapping, PCI regions, and the net_device
itself. gem_init_one() then falls through to its own cleanup labels and
frees the same resources again.

Keep the register_netdev() error path in gem_init_one(): clear drvdata so
PM/remove paths do not see a half-registered device, remove the NAPI
instance added during probe, and let the existing cleanup labels release
the resources once.

The issue was found by a local static-analysis checker for probe error
paths. The reported path was manually inspected before sending this fix.

Compile-tested with CONFIG_SUNGEM=y. Runtime testing was not performed
because no sungem hardware is available.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
v2:
- Add a Fixes tag.
- Describe how the issue was found.
- Add testing information.

v1: https://lore.kernel.org/netdev/20260620155326.80582-1-ruoyuw560@gmail.com/

 drivers/net/ethernet/sun/sungem.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
index 8e69d917d827..26974ee71352 100644
--- a/drivers/net/ethernet/sun/sungem.c
+++ b/drivers/net/ethernet/sun/sungem.c
@@ -2986,10 +2986,10 @@ static int gem_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	dev->max_mtu = GEM_MAX_MTU;
 
 	/* Register with kernel */
-	if (register_netdev(dev)) {
+	err = register_netdev(dev);
+	if (err) {
 		pr_err("Cannot register net device, aborting\n");
-		err = -ENOMEM;
-		goto err_out_free_consistent;
+		goto err_out_clear_drvdata;
 	}
 
 	/* Undo the get_cell with appropriate locking (we could use
@@ -3003,8 +3003,13 @@ static int gem_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		    dev->dev_addr);
 	return 0;
 
+err_out_clear_drvdata:
+	pci_set_drvdata(pdev, NULL);
+	netif_napi_del(&gp->napi);
+
 err_out_free_consistent:
-	gem_remove_one(pdev);
+	dma_free_coherent(&pdev->dev, sizeof(struct gem_init_block),
+			  gp->init_block, gp->gblock_dvma);
 err_out_iounmap:
 	gem_put_cell(gp);
 	iounmap(gp->regs);
-- 
2.51.0

