Return-Path: <netdev+bounces-261981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHacLw0EomkGyQQAu9opvQ
	(envelope-from <netdev+bounces-261981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 21:52:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F377A1BDFA4
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 21:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A6010300608C
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 20:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFA536D4E2;
	Fri, 27 Feb 2026 20:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nA+jGx3/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8552033A9EF
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 20:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772225541; cv=none; b=NUo15z5Oai6v+glFlpVervdZNDdzNETDC5TVuvAiF+gF7vHdRFYwcNCU6LAv6HfU6Yo5sqAixukeC+5mPke4hOpJ4iu33FAltHtwJ1B3kzWA7uPfjGm15FHsibG12WYWEdRadL8ZZ1VLgHo8HRoA3sTegbTXH1WaZ9Cdj0uihYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772225541; c=relaxed/simple;
	bh=GqjKoTi3sqjM4DFWEK5EeqFz+57uitIUOBAcAYymFh0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=IUP03PwdipEaOc9IBe0wWmwQ5rJBgPnsImaIrYuFTFKDRFSUjQ1u1cOmmTCFwvu0L9fAIxZUNsKHMURQlyWDKatoHoBicf9rM+FZ1j0LSmTH8jgdm1TjQoVeEHeSeaWhWTyphMX7Ih+MrdqFk0Sl1PANpHmMtpXOv6wU96REZdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nA+jGx3/; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4836f363d0dso19698135e9.3
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 12:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772225538; x=1772830338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91AmFn1bnJ1j3RF9zOPMDgsmX8OjH1RBUGMrbZi7xFY=;
        b=nA+jGx3/AUZeX+U3ufEQ2egXe+Tjp3CNeTB0mQ4UWRIc/6XJMLoYe5mYgusZXNEMYl
         YYWaFOpeBGh42lG1g/UjoTpQ6gpIZIE6TrNaHvS0wh7me7zv9LbH834QvcU8IWM+wC5+
         U/yxWN5LgL9InzldZpK10azlZgVi86YQDE5sAuH3Xz8rLkoGOkTmsVYywlAORSsIGVYW
         D4vRkEj5s2hqHptXdhgCtQlpKvCtYJrFfb35ZAgsuv6CFnYoZ7PE5zKqmlrZ2UlvYJWV
         c5E8GmKMqV6aXfolXl0arVsfPyxdQnTOK7BkvYAPdj/x2YbgVYE0r+CSJLkS+GDZzLPZ
         yv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772225538; x=1772830338;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=91AmFn1bnJ1j3RF9zOPMDgsmX8OjH1RBUGMrbZi7xFY=;
        b=sIb6Ytgk3FMOsbyDJ9xAhLDJoHTjI6te9EdjUc4lie2KvdGK/gJWv/OmHmQKO7qgIG
         bR465rlowtKuzO8wzCOIyUnmGz8oPxjJYXYiTBCjf1ghUaj70dlzdhv2ZpT6/80TYzNm
         ThGYCaTmrD00mSwT+rJSWrrX7tr8aCY5qj4NqgUCTamjt4eK7yavE/mj65rkLzhf/POC
         AkzL5k+GYxKYr4nZDtyimkdO2mqa6VIKgG0BUzU2WLIqryKXkmEGWI7xt8YC+x9I500o
         ltsKTghTARTAV95AishGuuup49D5iqU4OV+OKVOSJI675Q2iDgcydGFV3aKzn0PEpzch
         rY2A==
X-Forwarded-Encrypted: i=1; AJvYcCUooQ0xjLMKt93xVwUozj0v1wpfajFf+7HQDu4p/mpdJKX31iVn2zAqlo5WYAVKIu17llMV2Sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDUiHRTsTjtCT5UHdxNZCHRKdFzEVPRLj9mHP5EQq1kVOsGSpO
	DEHBv35gO5/L0Qdi/rMrpSQt7Lw1f2sz7XDYZYEp0jIXVdKE/cUgdW38DbncWA==
X-Gm-Gg: ATEYQzx1o2x7JPCCWGO76ry316XPE4NusLM31x1xF3YI0dw/gt5U6v3mkRuuRCnGOjT
	BqoycO7fPIR6U4/TXxP2EqeqJqOn3tVPR1n2Twu/uAtUGmHWQKnp14au9EdA+pDHtu7EZxIw41N
	WN7RYVyYXV97xqCwkc32WkjeflT8KTW7JvlbfwTzFDxbhqnQI+w0/t3QcwAKq/2QDNIekgbKh+M
	eSHjVt4gj7akSveigzLiYh/JbGKvHRlzydmeZhqPtcx+XBAreQCzjPB3d0kkc1PEYCJrpT+Z99t
	rNI8///hhPZF6sl1QhyK2Ot6QpQcu5FLr53reAXU3yZPlds5I4KSC0ND4zDjYdVsax6fdSVXY7i
	LWgyITPpRYglqzGYrfLxVmJQcGAmFe8g0/e9Q2g8PCdOntu44t3+cW4vboxINvESKQgf/1lTFYv
	XiV6RHTJGkvfjGg+CfFHPmLu94oE8cOXwUooxhaXQ0SQiZmUn+GKa95LfAp1h1LwtLXJzy8J1Wr
	aNo3EJh5v8spGoiKGZfszMy/CSlW2qiy2w05Jr00vS3RmbPjV6wjkQKr3hwwiLp+Q==
X-Received: by 2002:a05:600c:3b18:b0:459:db7b:988e with SMTP id 5b1f17b1804b1-483c9bc1f39mr72749215e9.13.1772225537679;
        Fri, 27 Feb 2026 12:52:17 -0800 (PST)
Received: from ?IPV6:2003:ea:8f14:5500:d4cd:9f12:bbf5:9c93? (p200300ea8f145500d4cd9f12bbf59c93.dip0.t-ipconnect.de. [2003:ea:8f14:5500:d4cd:9f12:bbf5:9c93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b7713csm114349145e9.11.2026.02.27.12.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 12:52:17 -0800 (PST)
Message-ID: <cc8e83aa-48c3-4497-b6ad-760a7f9e25dc@gmail.com>
Date: Fri, 27 Feb 2026 21:52:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: ti: davinci_emac: stop using bus type
 mdio_bus_type
To: Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>
Cc: linux-omap@vger.kernel.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261981-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F377A1BDFA4
X-Rspamd-Action: no action

This driver is the only user of mdio_bus_type outside phylib.
Using mdio_bus_type isn't strictly needed here, so use an alternative
approach. This will allow to make mdio_bus_type private to phylib
in a follow-up series.

Compile-tested only.

Note: Devices supported by this driver are OF-only, therefore the string
      comparison in match_first_device() isn't needed any longer.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/ti/davinci_emac.c | 39 ++++++++++----------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index 22d14fa5fe3..052ecd83f80 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1389,15 +1389,6 @@ static int emac_devioctl(struct net_device *ndev, struct ifreq *ifrq, int cmd)
 		return -EOPNOTSUPP;
 }
 
-static int match_first_device(struct device *dev, const void *data)
-{
-	if (dev->parent && dev->parent->of_node)
-		return of_device_is_compatible(dev->parent->of_node,
-					       "ti,davinci_mdio");
-
-	return !strncmp(dev_name(dev), "davinci_mdio", 12);
-}
-
 /**
  * emac_dev_open - EMAC device open
  * @ndev: The DaVinci EMAC network adapter
@@ -1417,7 +1408,6 @@ static int emac_dev_open(struct net_device *ndev)
 	int i = 0;
 	struct emac_priv *priv = netdev_priv(ndev);
 	struct phy_device *phydev = NULL;
-	struct device *phy = NULL;
 
 	ret = pm_runtime_resume_and_get(&priv->pdev->dev);
 	if (ret < 0) {
@@ -1502,20 +1492,22 @@ static int emac_dev_open(struct net_device *ndev)
 		}
 	}
 
-	/* use the first phy on the bus if pdata did not give us a phy id */
+	/* if no phy-handle and no fixed link, use the first phy on the bus */
 	if (!phydev && !priv->phy_id) {
-		/* NOTE: we can't use bus_find_device_by_name() here because
-		 * the device name is not guaranteed to be 'davinci_mdio'. On
-		 * some systems it can be 'davinci_mdio.0' so we need to use
-		 * strncmp() against the first part of the string to correctly
-		 * match it.
-		 */
-		phy = bus_find_device(&mdio_bus_type, NULL, NULL,
-				      match_first_device);
-		if (phy) {
-			priv->phy_id = dev_name(phy);
-			if (!priv->phy_id || !*priv->phy_id)
-				put_device(phy);
+		struct device_node *np;
+
+		np = of_find_compatible_node(NULL, NULL, "ti,davinci_mdio");
+		if (np) {
+			struct mii_bus *bus = of_mdio_find_bus(np);
+
+			if (bus) {
+				struct phy_device *phy = phy_find_first(bus);
+
+				if (phy)
+					priv->phy_id = phydev_name(phy);
+				put_device(&bus->dev); /* of_mdio_find_bus */
+			}
+			of_node_put(np); /* of_find_compatible_node */
 		}
 	}
 
@@ -1523,7 +1515,6 @@ static int emac_dev_open(struct net_device *ndev)
 		phydev = phy_connect(ndev, priv->phy_id,
 				     &emac_adjust_link,
 				     PHY_INTERFACE_MODE_MII);
-		put_device(phy);	/* reference taken by bus_find_device */
 		if (IS_ERR(phydev)) {
 			dev_err(emac_dev, "could not connect to phy %s\n",
 				priv->phy_id);
-- 
2.53.0


