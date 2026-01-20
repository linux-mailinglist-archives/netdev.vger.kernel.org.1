Return-Path: <netdev+bounces-251609-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMzPEfvsb2m+UQAAu9opvQ
	(envelope-from <netdev+bounces-251609-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 22:00:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E85EF4BE3C
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 22:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E81A88E0AAB
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE2847B438;
	Tue, 20 Jan 2026 19:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="c23KRbGj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FD944BC89
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 19:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768938129; cv=none; b=mdsuJ9NcqBP50bLKbgMQIdxUmDShhAqRumOyCXzUjSJL7oeNmqsmhpKXgTJveb8xe0+AlyJ2PdPC1oSlhCC5hGoXSEYfGNoH99KDzTB8O3N63ldQERgNPldHB/DBuWRoQHlDtgxSufSy8pHqTCnWyh4p52XxreFtb77rphPCJmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768938129; c=relaxed/simple;
	bh=GZ1p+HqV7KqAGO52zVx0hi6GLjR1nwg1KP14+R79c7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RStvXwhMfok73i/4JQVamVHfcC9VTsZgRvweEOtvl1eDCBagT7MupwGUBYioTA2SzD4Epl4AU7Py0WmBMsSj4YIZQFrR1tcgag+xVniZnXg0AZaiETn4cOzSojHqlK9YcoqrRvErwL9Xt+gwzaF8EDguw2oRt1AkKZgtx3P/iN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=c23KRbGj; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-8804f1bd6a7so51003616d6.2
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 11:42:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768938126; x=1769542926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3o0kX59oQsIDgSNDDrsm01GVqwHkP/rCJPQYdRB3/Fk=;
        b=L9CJsqxUnhlz/uuPGdAjetI1LtbBsaFuMwvIuRl6mNIdG+2Iu8vtEPtnaCYTUMb7xt
         tbDvl1Sj54W0/kdeoBAwbWaLY8hDG4TBTVM8Xve6Z6mLMUgn4EG6JzdSMX0UUN8Ka5Wq
         LQN9mQ1Z03tVgf0wBxY3pVUU1tVvWTbODtiqU3TM0ov/fPND64F2ODrr5ZCbueno4Z4P
         wUfcj+OuK551gFaEAQvxQB67I8HvrrUVjKv46vWWQTDz7qAZbcGPp2ub0UJHj3RFShop
         6IQmxu/ca7Lm6S15EtbM3V6CdNc7oi8Ss8nxUYPMCWJLMVgMR0BgcRArGTPtLkakBEiJ
         f45w==
X-Gm-Message-State: AOJu0YyRLhEHd8Js01rQ0ij3yI3xCYC65zoi8k4MuMzGDywunnOQeNso
	u5ByTU3DHbbeBIokL69wsOggeTWBR00hLHJAXAwRdRKqLw2HM5E27ATIgbTGWKCpeE9fYu+Ua22
	D0rPdPS9LvaV3aQV1SQke+a7JkZQ9nmtCS4u9zV93gm74kTnkM+Ax58joKzevgXYtALZvwsnx6C
	c+fwNsy3C1o/NyrUU8QNfHDcBjlOSaESQ66jJGND8LZueQPSPCj3Kd670Hcq9s8MBs77jzyp0rX
	J5BTVy3pw==
X-Gm-Gg: AZuq6aIyDWINqz+eGBjfTOtJl9cyJ7br7mryEDjSQdUo7G0JciC2lNwuvvplJyCCT9U
	wXzkWxebIAJduvKhLcMs0BsWiA1GxPo6feaVzWztnW+Y0n42GqtnKm/YeXp2kOQeoDrPbu56CdP
	cohinDl0Y6j0ZF23iqDGwxv6rqZ/V/3jb6Dn3GmEJ3eyI391q2MCh1FMBiugVzRSi/XIF5Gypd5
	Vcczyz69NkdEJi4qTltAP9RSMp7Qp9sHgqyIdrlJbMrNehHfixNr9h3SZoaN9swjfl4SEAjkpbW
	k8IeHBoemDuo90ApdPHbNajqS/U9qHrjD4TJbgXnP4DGiizk6Zbr2Wu0LOKXCZHh0ljm/PRfVbP
	qEc1JaIYLoGgE47TtZelpRLKNayAzBuA1dtR19FzGULgkDgP+30OjG4kFE/FvCmA4OmgpCjyfnZ
	C55pfV9diypdrzdTeC+nllh55orAG0r2JxIHAjc7cZ1vQ=
X-Received: by 2002:a05:6214:19c4:b0:880:4695:4626 with SMTP id 6a1803df08f44-89463865ffbmr45487826d6.15.1768938126366;
        Tue, 20 Jan 2026 11:42:06 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8942e6cd881sm10026036d6.18.2026.01.20.11.42.06
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jan 2026 11:42:06 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-890587d4e87so165819836d6.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 11:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768938125; x=1769542925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3o0kX59oQsIDgSNDDrsm01GVqwHkP/rCJPQYdRB3/Fk=;
        b=c23KRbGjeOskyYM5Bx6dyaps21cbhI0yY6bhoctdxMWJDedD0MBmuHgDPClGIdoV1c
         59CzihT8yohp1UZqzHy1xJUtwv3F4H/EtRDaVdvE0SdzTQOyHdWoJHHXSWbXS+8L3Q/v
         qROq/yLQ+R1CaEdGxH5aNpBNPQEjY/5owoNOk=
X-Received: by 2002:a05:6214:d08:b0:880:48c6:ad02 with SMTP id 6a1803df08f44-894638f6297mr39800296d6.52.1768938125211;
        Tue, 20 Jan 2026 11:42:05 -0800 (PST)
X-Received: by 2002:a05:6214:d08:b0:880:48c6:ad02 with SMTP id 6a1803df08f44-894638f6297mr39799986d6.52.1768938124798;
        Tue, 20 Jan 2026 11:42:04 -0800 (PST)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6c9b83sm110887586d6.46.2026.01.20.11.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 11:42:04 -0800 (PST)
From: Justin Chen <justin.chen@broadcom.com>
To: netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net-next v2 2/2] net: bcmasp: streamline early exit and fix leak
Date: Tue, 20 Jan 2026 11:41:54 -0800
Message-Id: <20260120194154.2047656-3-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260120194154.2047656-1-justin.chen@broadcom.com>
References: <20260120194154.2047656-1-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-251609-lists,netdev=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[broadcom.com,reject];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E85EF4BE3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix an early exit cleanup leak by unregistering of_phy_fixed_link()

Streamline the bcmasp_probe early exit. As support for other
functionality is added(i.e. ptp), it is easier to keep track of early
exit cleanup when it is all in one place.

Signed-off-by: Justin Chen <justin.chen@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp.c   | 27 ++++++++++---------
 .../net/ethernet/broadcom/asp2/bcmasp_intf.c  |  5 +++-
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index 36df7d1a9be3..aa6d8606849f 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -1317,6 +1317,8 @@ static int bcmasp_probe(struct platform_device *pdev)
 
 	bcmasp_core_init_filters(priv);
 
+	bcmasp_init_wol(priv);
+
 	ports_node = of_find_node_by_name(dev->of_node, "ethernet-ports");
 	if (!ports_node) {
 		dev_warn(dev, "No ports found\n");
@@ -1328,16 +1330,14 @@ static int bcmasp_probe(struct platform_device *pdev)
 		intf = bcmasp_interface_create(priv, intf_node, i);
 		if (!intf) {
 			dev_err(dev, "Cannot create eth interface %d\n", i);
-			bcmasp_remove_intfs(priv);
-			ret = -ENOMEM;
-			goto of_put_exit;
+			of_node_put(ports_node);
+			ret = -EINVAL;
+			goto err_cleanup;
 		}
 		list_add_tail(&intf->list, &priv->intfs);
 		i++;
 	}
-
-	/* Check and enable WoL */
-	bcmasp_init_wol(priv);
+	of_node_put(ports_node);
 
 	/* Drop the clock reference count now and let ndo_open()/ndo_close()
 	 * manage it for us from now on.
@@ -1352,19 +1352,20 @@ static int bcmasp_probe(struct platform_device *pdev)
 	list_for_each_entry(intf, &priv->intfs, list) {
 		ret = register_netdev(intf->ndev);
 		if (ret) {
-			netdev_err(intf->ndev,
-				   "failed to register net_device: %d\n", ret);
-			bcmasp_wol_irq_destroy(priv);
-			bcmasp_remove_intfs(priv);
-			goto of_put_exit;
+			dev_err(dev, "failed to register net_device: %d\n", ret);
+			goto err_cleanup;
 		}
 		count++;
 	}
 
 	dev_info(dev, "Initialized %d port(s)\n", count);
 
-of_put_exit:
-	of_node_put(ports_node);
+	return ret;
+
+err_cleanup:
+	bcmasp_wol_irq_destroy(priv);
+	bcmasp_remove_intfs(priv);
+
 	return ret;
 }
 
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index 6cddd3280cb8..f3b8d94f4791 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -1228,7 +1228,7 @@ struct bcmasp_intf *bcmasp_interface_create(struct bcmasp_priv *priv,
 		netdev_err(intf->ndev, "invalid PHY mode: %s for port %d\n",
 			   phy_modes(intf->phy_interface), intf->port);
 		ret = -EINVAL;
-		goto err_free_netdev;
+		goto err_unregister_fixed_link;
 	}
 
 	ret = of_get_ethdev_address(ndev_dn, ndev);
@@ -1252,6 +1252,9 @@ struct bcmasp_intf *bcmasp_interface_create(struct bcmasp_priv *priv,
 
 	return intf;
 
+err_unregister_fixed_link:
+	if (of_phy_is_fixed_link(ndev_dn))
+		of_phy_deregister_fixed_link(ndev_dn);
 err_free_netdev:
 	free_netdev(ndev);
 err:
-- 
2.34.1


