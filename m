Return-Path: <netdev+bounces-81744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B997F88AFFC
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 20:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700D03478CE
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 19:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42BE1BC2A;
	Mon, 25 Mar 2024 19:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gkn2jAAm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3E718645
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 19:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711395046; cv=none; b=jYDuUfNxgH8E0sCWZ7qwE8O0LbtdOeVf8+5H5L0U4qXj8hliB/E5LPdfNINMtuMdCcvxzvrCw/LPaNIEClj89C7ddcABxgxzCu3rXIil0u4CDN0tSl+YQzyUsfyx2MZYQn+b5bmuB5uO1q5vacpSQsxZDs9TD2VBUF4GFi8ra6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711395046; c=relaxed/simple;
	bh=FBMXuIzYL3sVByMb6OSrjXnRMs36vLvJJRs8pWF9kk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oe1ymq8w4dNKNT19hvv3A1FcxMrpSbIZx6t1LARX1FMpOCQ/oyM4E8g9EGTiuAhB5ktUBEiyEGzQ6bt7Q9XeAupJGW4xZ7t/thWUZudHpJGZP43LjnuM5A5EbbJDK/qa1I0ClReY6Tg3fEIwmRmUJK64mNUst91sR65FK7dcsXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gkn2jAAm; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c35c4d8878so1954985b6e.1
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 12:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1711395044; x=1711999844; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/h9nZ9qVLHAFis9t9DwFmltM3uknoACCwP4nAYD05Ic=;
        b=gkn2jAAmFLnwZG9mbx4hCKsr6YIXNhoftCoAgDI/XZNJlmcgvMuxNoafjMV/AzhBWG
         B7sLSV0aSrOmppYmoG7QhcOSk5Jrbyz7uWXcCKMX+PAbTOMlJ9VQ2VJYQra6bIT65kN2
         WqfVXEbfSgCsJ/vrLSR3wBAQwx1AUZ5QUdGqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711395044; x=1711999844;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/h9nZ9qVLHAFis9t9DwFmltM3uknoACCwP4nAYD05Ic=;
        b=deOt4qulHVo8/lMIpODVLLj+k30nSHiIiVL15zcc4T3Xw4U3Kj4X25jrJnvspaOVoE
         XuCmzKkfAjU0NdOb0zUX5w1jQ/VKxHIEKPvR9mc051C/P8p+Z3baOicEuS+0RuXFeAFz
         xtkIW9Vf4uNGHEOP+4Fe5neiEH0d75243ocNYOvKcKyUuaNgpdjc0zAfiGVCTYgvN/tg
         cbp0NfULwq7sAQygFmH6tO6vkawO9YZ+R6+AQf/w8dyGMA+f2t4fQggV96cs59vzdhmV
         U++G+vJf1I9dGI7PgDrI+0t3iDeah5XQbVeWMYXfEduYm3BiPmlVZbMKaF4t+KFiEv7a
         MwOQ==
X-Gm-Message-State: AOJu0Ywqd8NMf8nsb+HAZAcKQo0rDKZDkGYszOzBnMMy1E8xO/s/0wXb
	FiRZaPKxYJZ13rSm70vppk7aH/7TuqE+dVq6XSHv7orr9dkfVBPtMhlUGl+pjgD9l6UsJsgfKyz
	IPmqsbC0Lf8SDMxuad3OIf+JR6G67KpFyhWDUzqwHUig4eyKJVj5CH4e6r/7WfnDJ1Ctq9DBECy
	QOJ9EY1TQVhkQ1m/8hFBnBLBody+zd4qSKnjTjJvDEqA==
X-Google-Smtp-Source: AGHT+IG8R+Xj7/ikggljZ37vdPPws3UjjTJFeFQPyxu+OyBOb9z6UlwN+CE8sI/u32jQFz14ejIHSQ==
X-Received: by 2002:a05:6808:278c:b0:3c3:7c52:fc23 with SMTP id es12-20020a056808278c00b003c37c52fc23mr8407886oib.19.1711395043633;
        Mon, 25 Mar 2024 12:30:43 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id ey5-20020a05622a4c0500b00431612e7111sm689448qtb.41.2024.03.25.12.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 12:30:43 -0700 (PDT)
From: Justin Chen <justin.chen@broadcom.com>
To: netdev@vger.kernel.org
Cc: florian.fainelli@broadcom.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	opendmb@gmail.com,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net 1/2] net: bcmasp: Bring up unimac after PHY link up
Date: Mon, 25 Mar 2024 12:30:24 -0700
Message-Id: <20240325193025.1540737-2-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325193025.1540737-1-justin.chen@broadcom.com>
References: <20240325193025.1540737-1-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000adb1b606148135d0"

--000000000000adb1b606148135d0
Content-Transfer-Encoding: 8bit

The unimac requires the PHY RX clk during reset or it may be put
into a bad state. Bring up the unimac after link up to ensure the
PHY RX clk exists.

Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
 .../net/ethernet/broadcom/asp2/bcmasp_intf.c  | 28 +++++++++++++------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index dd06b68b33ed..34e5156762a8 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -392,7 +392,9 @@ static void umac_reset(struct bcmasp_intf *intf)
 	umac_wl(intf, 0x0, UMC_CMD);
 	umac_wl(intf, UMC_CMD_SW_RESET, UMC_CMD);
 	usleep_range(10, 100);
-	umac_wl(intf, 0x0, UMC_CMD);
+	/* We hold the umac in reset and bring it out of
+	 * reset when phy link is up.
+	 */
 }
 
 static void umac_set_hw_addr(struct bcmasp_intf *intf,
@@ -412,6 +414,8 @@ static void umac_enable_set(struct bcmasp_intf *intf, u32 mask,
 	u32 reg;
 
 	reg = umac_rl(intf, UMC_CMD);
+	if (reg & UMC_CMD_SW_RESET)
+		return;
 	if (enable)
 		reg |= mask;
 	else
@@ -430,7 +434,6 @@ static void umac_init(struct bcmasp_intf *intf)
 	umac_wl(intf, 0x800, UMC_FRM_LEN);
 	umac_wl(intf, 0xffff, UMC_PAUSE_CNTRL);
 	umac_wl(intf, 0x800, UMC_RX_MAX_PKT_SZ);
-	umac_enable_set(intf, UMC_CMD_PROMISC, 1);
 }
 
 static int bcmasp_tx_poll(struct napi_struct *napi, int budget)
@@ -658,6 +661,12 @@ static void bcmasp_adj_link(struct net_device *dev)
 			UMC_CMD_HD_EN | UMC_CMD_RX_PAUSE_IGNORE |
 			UMC_CMD_TX_PAUSE_IGNORE);
 		reg |= cmd_bits;
+		if (reg & UMC_CMD_SW_RESET) {
+			reg &= ~UMC_CMD_SW_RESET;
+			umac_wl(intf, reg, UMC_CMD);
+			udelay(2);
+			reg |= UMC_CMD_TX_EN | UMC_CMD_RX_EN | UMC_CMD_PROMISC;
+		}
 		umac_wl(intf, reg, UMC_CMD);
 
 		active = phy_init_eee(phydev, 0) >= 0;
@@ -1045,9 +1054,6 @@ static int bcmasp_netif_init(struct net_device *dev, bool phy_connect)
 
 	umac_init(intf);
 
-	/* Disable the UniMAC RX/TX */
-	umac_enable_set(intf, (UMC_CMD_RX_EN | UMC_CMD_TX_EN), 0);
-
 	umac_set_hw_addr(intf, dev->dev_addr);
 
 	intf->old_duplex = -1;
@@ -1062,9 +1068,6 @@ static int bcmasp_netif_init(struct net_device *dev, bool phy_connect)
 	netif_napi_add(intf->ndev, &intf->rx_napi, bcmasp_rx_poll);
 	bcmasp_enable_rx(intf, 1);
 
-	/* Turn on UniMAC TX/RX */
-	umac_enable_set(intf, (UMC_CMD_RX_EN | UMC_CMD_TX_EN), 1);
-
 	intf->crc_fwd = !!(umac_rl(intf, UMC_CMD) & UMC_CMD_CRC_FWD);
 
 	bcmasp_netif_start(dev);
@@ -1306,7 +1309,14 @@ static void bcmasp_suspend_to_wol(struct bcmasp_intf *intf)
 	if (intf->wolopts & WAKE_FILTER)
 		bcmasp_netfilt_suspend(intf);
 
-	/* UniMAC receive needs to be turned on */
+	/* Bring UniMAC out of reset if needed and enable RX */
+	reg = umac_rl(intf, UMC_CMD);
+	if (reg & UMC_CMD_SW_RESET)
+		reg &= ~UMC_CMD_SW_RESET;
+
+	reg |= UMC_CMD_RX_EN | UMC_CMD_PROMISC;
+	umac_wl(intf, reg, UMC_CMD);
+
 	umac_enable_set(intf, UMC_CMD_RX_EN, 1);
 
 	if (intf->parent->wol_irq > 0) {
-- 
2.34.1


--000000000000adb1b606148135d0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
NhTY3E+cXCB11wty89QStajwXdhGJTYEvUgvsq1h8CwJj9w/38ldAQf5WjhPmApYeJR2ewFrBMCM
4lHkdRJ6TDc9nXoEkypUfjJkJHe7Eal06tosh6JpAgMBAAGjggHZMIIB1TAOBgNVHQ8BAf8EBAMC
BaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJlLmdsb2JhbHNp
Z24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYIKwYBBQUHMAGG
NWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwME0G
A1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxz
aWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqGOGh0dHA6Ly9j
cmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3JsMCMGA1UdEQQc
MBqBGGp1c3Rpbi5jaGVuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSME
GDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUIWGeYuaTsnIada5Xx8TR3cheUbgw
DQYJKoZIhvcNAQELBQADggEBAHNQlMqQOFYPYFO71A+8t+qWMmtOdd2iGswSOvpSZ/pmGlfw8ZvY
dRTkl27m37la84AxRkiVMes14JyOZJoMh/g7fbgPlU14eBc6WQWkIA6AmNkduFWTr1pRezkjpeo6
xVmdBLM4VY1TFDYj7S8H2adPuypd62uHMY/MZi+BIUys4uAFA+N3NuUBNjcVZXYPplYxxKEuIFq6
sDL+OV16G+F9CkNMN3txsym8Nnx5WAYZb6+rBUIhMGz70V05xsHQfzvo2s7f0J1tJ5BoRlPPhL0h
VOnWA3h71u9TfSsv+PXVm3P21TfOS2uc1hbzEqyENCP4i5XQ0rv0TmPW42GZ0o4xggJtMIICaQIB
ATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhH
bG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwj8BKLXNpALfemdRAwDQYJ
YIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFpQrA46RKlfrLoQ3nzksIkYz8vwuqPBsP8/
X7cE4RPoMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDMyNTE5
MzA0NFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATAN
BgkqhkiG9w0BAQEFAASCAQC3zvf8QO3xL92LxNN468ZL+4SIIJ12iTBdejciwnICNqSkP5IB8p58
F8Zk+a0WlFSquiEyGmzccnEy3HXCTMvm/egH/KA6TJ3wnXDUkify+P7akLis7sh2XDoYbA/n7ctJ
LotMArltm1/45Uv1VB3kDHYoKPW/BaHgv++tSMF2Yo+/9/EX+aBXxFy1QaUg3hWPr1VLhDR+d7hj
AbkvYu7Sf0KY6plL9oD4GW+kUM+04mvQ+rp0RzHIWhwcdT6aa5c8paEvkcVI34NakYJ5RzKnJ0+q
tfiqHQ/Z16i2rdv4+k5npYzBzpgrdtwbhTg/jnDD9frbO2gFUIoDx3OWHe8n
--000000000000adb1b606148135d0--

