Return-Path: <netdev+bounces-284952-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MpWCY1x+2kNbQMAu9opvQ
	(envelope-from <netdev+bounces-284952-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 18:51:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5F94DE52E
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 18:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44A9B301B4C5
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 16:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A9A4963AD;
	Wed,  6 May 2026 16:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAdKtR81"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BEC494A00
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778086225; cv=none; b=OBRlrI1wOUbtdpS+wFJyRAmbsT5bljjNC80Lc2ttqYn1Ac2LI/KdrvXTLMiuNuKQg7cvvF7yUBg9uxo06W3tDYFjRGfLd9epbV9rnqd7Yrqub1FDGO5knhY2fsShxsWUhz4XkW6kgQ/2128OpDSpi0+FK1Oy9WsHQqBafiwPbso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778086225; c=relaxed/simple;
	bh=4dmzSbmmw+DNF+WrXmgmnHMBAYVUq60hnV8ZXwFBP/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BJy4L16sN05t2QLUhy8I/weJQEhKysu1hrnUUxWy11IiDVikkA6qcIopLEDZQwBHBU5mGJ/csOVQmapD34yI3iVFdgw7RMGfAaVZQvQt5UcpayLGpDMRT1Byv8/VaCQIcVb1oZWmOl6R1QHlrqVz1Z6JETQdh9erCt/TlHHIRqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAdKtR81; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso51005365e9.3
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 09:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778086222; x=1778691022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YVORh6JNn+0XYtaz5jTVXMpA1GomYOXbazYzcdBmqLk=;
        b=FAdKtR81TB6Lz/Rm84kybq9RS+fxlWsVzr7vUJGY0wc6P9vO7H3u+rsEMVzr/chdWO
         FJbOtnTnhVUvVN4RQiHCNsCVJOVty5cofp98KmrYco/I91TKcRXx698j07mkStdKxOET
         hmj0/euKO9uAqusPZsDtaKjDqsfTRbwJjwVbkFz+jxTm5wnLsAgFDuYQ5Msgzp9kxdcv
         zNf7/8tVjaw1f0U0GgKlJ/tEEGxTIkXUgeIaVYvKJp4V1LgKnkVypWPmLU/e96bzxRnA
         ZIZkwl8GuUYghhFDS7ft3W+8RAzUUGwHWL2SGICX+es0QPbML/pzI5VPkMsLKlK8ZK16
         B4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778086222; x=1778691022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVORh6JNn+0XYtaz5jTVXMpA1GomYOXbazYzcdBmqLk=;
        b=kEl8wqBy63609c3ENL9M4X4nGxwxcWo/+9Nh3JYKdN1dsAznUVu49of03F4t3Gyjez
         iIZ5Yl2dRMHHE1NZGyNk0qZEiQMhGR5VB7Us4LVp7F7m8reJHtFzaMREeXjOIxzTkzGg
         /Smkpm3tvn0AolvzcYQLQqMJqApT5Pg9TawjYJBqLyuVgHhzcJMCn0jQvrhQEKgZNZU8
         mbiln8ZxXQiUrkDjzvvyKC/fzx2eJbyVIPtw3+8qJaXrbTvQnQaMeh2W7seZT2kw1PTf
         ldjYkjxceUIv0kOZrOpWQKgnYM2PcR7xqkpiaeQy/CXLZ/FAWtvM+lu7dQnAGgYnRY7Q
         5RZQ==
X-Forwarded-Encrypted: i=1; AFNElJ/4JKQzaUdxLl33CBQlnYNo2Nz+lkxt2fQvYPBhVQb330tpIsBDZX10cHl1hBJeaqQ4fZY14UY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfN9rZ7WnAbfKMb4l8tkrbUzbutl2ePutNidWNGA5/txIZl3Gv
	eWZJ5GIiF6aE1jgY64fl22soEVjmKm6uyoIArLcUJE6iyh6x8OUk3FGw
X-Gm-Gg: AeBDieuJ/XZr1NyD76DdyDwHTUdUHg7F5pvFvLRVTjFU0aM2VLFSg//WUy7aGdJ2EOR
	aAjnGbnbL3AqmGx3mwZXLYhV7L3xnIUFSpOV0hu7bsQ7RDZcykXvl0sjk9ePR84Y22VedM+QD8n
	6iz7OTFQA0rCrIVihmX32u43CQtuYj9UfpTA+S8qGgwHW2+82PeGVinNGIG5Ug1hKMigAM3EUZc
	xXmmomvAK+2p1oRfk9dtSQfFwk4J9a05xDh/xB1O93s+ZEgKiiGYkwr3BlOoo8Q+8IYvR7SGroi
	OeNOo3OWb18XsEkOFoHlrBYrkQj5SO1O6r/eTLoaIPLO5gzAGjkmdH6QKyuEUbjGzwBuu8kAuk5
	N9SCV3ueJuL5phO5YycCFexIBW6iFszTGyUlqQ4uefXGxyba/TIAn3ef0U2GQZOAxuDVc6Pgi2p
	pbZBpjeVQm4xq/lJrKhYIOTOdAJ627GFM7x541JjvXlUOitPTdKrCQkBFW
X-Received: by 2002:a05:600c:4e0c:b0:48a:54a6:b29f with SMTP id 5b1f17b1804b1-48e51f2f793mr76873755e9.17.1778086221544;
        Wed, 06 May 2026 09:50:21 -0700 (PDT)
Received: from dev-linux.homserver.local ([51.154.251.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e53891163sm65070235e9.2.2026.05.06.09.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 09:50:20 -0700 (PDT)
From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
To: Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Ankit Garg <nktgrg@google.com>,
	Tim Hostetler <thostet@google.com>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	John Fraker <jfraker@google.com>,
	Matt Olson <maolson@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>
Cc: Vaibhav Gupta <vaibhavgupta40@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH net-next v2] gve: Use generic power management
Date: Wed,  6 May 2026 16:50:06 +0000
Message-ID: <20260506165015.641738-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DB5F94DE52E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,intel.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-284952-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vaibhavgupta40@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Switch to the generic power management and remove the usage of legacy
(pci_driver) hooks.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
v2: wrap "&gve_pm_ops" inside pm_sleep_ptr(), and add 'net-next' tag, as
suggested by Harshitha.
---
 drivers/net/ethernet/google/gve/gve_main.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 424d973c97f2..00750643e614 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2967,9 +2967,9 @@ static void gve_shutdown(struct pci_dev *pdev)
 	rtnl_unlock();
 }
 
-#ifdef CONFIG_PM
-static int gve_suspend(struct pci_dev *pdev, pm_message_t state)
+static int gve_suspend(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct gve_priv *priv = netdev_priv(netdev);
 	bool was_up = netif_running(priv->dev);
@@ -2990,8 +2990,9 @@ static int gve_suspend(struct pci_dev *pdev, pm_message_t state)
 	return 0;
 }
 
-static int gve_resume(struct pci_dev *pdev)
+static int gve_resume(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct gve_priv *priv = netdev_priv(netdev);
 	int err;
@@ -3004,7 +3005,8 @@ static int gve_resume(struct pci_dev *pdev)
 	rtnl_unlock();
 	return err;
 }
-#endif /* CONFIG_PM */
+
+static DEFINE_SIMPLE_DEV_PM_OPS(gve_pm_ops, gve_suspend, gve_resume);
 
 static const struct pci_device_id gve_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_GOOGLE, PCI_DEV_ID_GVNIC) },
@@ -3017,10 +3019,7 @@ static struct pci_driver gve_driver = {
 	.probe		= gve_probe,
 	.remove		= gve_remove,
 	.shutdown	= gve_shutdown,
-#ifdef CONFIG_PM
-	.suspend        = gve_suspend,
-	.resume         = gve_resume,
-#endif
+	.driver.pm	= pm_sleep_ptr(&gve_pm_ops),
 };
 
 module_pci_driver(gve_driver);
-- 
2.53.0


