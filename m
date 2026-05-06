Return-Path: <netdev+bounces-284951-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKBlO81w+2m7bAMAu9opvQ
	(envelope-from <netdev+bounces-284951-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 18:48:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 916574DE429
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 18:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6317E300824D
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 16:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45608481224;
	Wed,  6 May 2026 16:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKhDdbds"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21CD43E4A9
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 16:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778086090; cv=none; b=IuQjwC584zqLMpc8gicCirymBr9XDwy+O589Luw/sumi7YjDq+ZV5JZqB6Q//ydqsWcP4rKgXECVbU7rRfcSSyZtR/TZVz5tjPJJ6CbWRJs84bnEKuG+X5nFduGXOoLMM99p1PHctcIRbSlvcX0S7tyF8gLM7ta6u1f+XmUhPH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778086090; c=relaxed/simple;
	bh=4dmzSbmmw+DNF+WrXmgmnHMBAYVUq60hnV8ZXwFBP/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+fx9hVeblazF6PheJPZhCdVytEwyDRrnPQR0KvYziERU60sWS/lcrqLvJ0mtnWU6H27LFUETSCp2KzzSVSuqG9mFeW/Yv+N8Jj+Z0NOUqS3IRwKPhlHOUlbosmjaqaq6Ryq/yGfUfg/2ToMtq/6a7iPiIQjCr9tkFeb19HTufs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKhDdbds; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44a5174670eso3036569f8f.1
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 09:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778086087; x=1778690887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVORh6JNn+0XYtaz5jTVXMpA1GomYOXbazYzcdBmqLk=;
        b=FKhDdbds8NupWP443qcJxO7JVg3OD7UBwQDBK2whisuy/E05DEhiItq4rSwuv0c8g9
         vW68O98l9rrV0a701B7e2AmznzPR65ZQd452L9A1wHbUHWFwZ7AEy2mf8Sv0Rch3tgPy
         Wk8204Vh7oN1O0/BaE4IB+Y/g0Z0C9TQiauTOOVyYxKy6Nu2UPkMt8/vD7MDujSU/19T
         Q++vuO1bbrUpj/t9p9QHIRDXR2ulkCgB0mF+oVKnQnS6u7jnM4y9wHer9MK1R5XLthIN
         sEGQ1UC3byw2CeYtwxjK2apcSskuk+h/GtrMAu4yio622ADzRF85tTXyAdRtpxk85mgt
         yprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778086087; x=1778690887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YVORh6JNn+0XYtaz5jTVXMpA1GomYOXbazYzcdBmqLk=;
        b=CfOgmCNXFQo/bv40UbTqnGqYw3b4h8RE9b0yVhSEEClbHUr/4F01M1ci8hqcIzlbGM
         rP8+zkSEGFSYAhEmVdXaTjjRwSPXL/WCE0zrtGBSjFwC4w/4HvdUtkcrQkuHgxowwtmb
         B0y5gRQ/VfGHq4j9ZaV+7a2eD+L7x+M4VvWxxQo7nDuYcSJqQEDH+A0wtyfdE4U6x52I
         akTI3UthzRE4IsmkcUIwnyfgOIcKRakfLbBkgXXC9hZHw30wX+S6vSN2Wvuys+Sop5tq
         lRqBOUU+SjL45YxbX8LgXhvnv6jFMQa+Xv3FKs6gC+pvHxbLMSBkDePxPgIVo48WPkB0
         cOBA==
X-Forwarded-Encrypted: i=1; AFNElJ9lw9Cwj8va3yOlYMHIlRQdaSztbXJ/jU+7/wRG+t1IRw1ERe6y4ON01yGZpNHzqpXAlQhMJm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwOZ7V8v+43xWkyx0rDgl4xu4DcGXqrtue7NDMWC5/TrFUTq31
	JzYJ6SrLTvzFf/UtWSvKOAdw0nLkqtU9f0N4iLetEOiUa2cqVyweX5zU
X-Gm-Gg: AeBDieuhvBaJAre2PT2tUKIsIa4mibOc84O2ullofdo8ZaH0XmhpNOkSg5CDubbf/Ps
	4gGCzWnXs9sx17OLSjeXZrMWpt0mWvd7UiMz+kxvvSypPegGvRvJDGOx3m8USVj5cdaRilwazYk
	z9zSWBT6gX/S/NSApxeyXzSubnF0FjvMbcZb3VQYqS6k4amqA/CgLFLf6wrB2o3ARCpy+yUGIBi
	oLxGh2xPdDhyR9NtKM5BiSuXzbSnA+Te9a9XoE8DRbLRjxDiKnXi3JcbNL+mxWJlvpSAl9jenA1
	0gLkUDrBsDj1Ti8umtUu/LB0Al+1ZO9lEP78VIc2y6m5wuGPqmYoieyC3NmjFxPY11xLx5GgUUf
	Tni7LrM/0Ym1jOPGs2FBw97UK/+sY3d2dmMm2tpg/rKI9hICRbFhZKsh6D5BKXx390HQjuMWO7r
	XYbMjgsXR1CAy9+wThv+MIskU9H7QtYgwzPWd/MVOj1Jb0Ezax1fcXiEd5chf9SJYU2PEEvJ40Z
	4T6Hw==
X-Received: by 2002:a05:6000:22c3:b0:43e:a70d:763c with SMTP id ffacd0b85a97d-4515df65cc1mr7559336f8f.42.1778086087016;
        Wed, 06 May 2026 09:48:07 -0700 (PDT)
Received: from dev-linux.homserver.local ([51.154.251.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45054b03df9sm13269791f8f.24.2026.05.06.09.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 09:48:06 -0700 (PDT)
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
Date: Wed,  6 May 2026 16:47:39 +0000
Message-ID: <20260506164757.641640-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504182139.604925-1-vaibhavgupta40@gmail.com>
References: <20260504182139.604925-1-vaibhavgupta40@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 916574DE429
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,intel.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-284951-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vaibhavgupta40@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]

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


