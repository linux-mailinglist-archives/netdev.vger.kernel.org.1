Return-Path: <netdev+bounces-172022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA4BA4FF2B
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 13:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3824171D24
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 12:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322C7248899;
	Wed,  5 Mar 2025 12:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="chUD6+7I"
X-Original-To: netdev@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266A824886C
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 12:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741179455; cv=none; b=CzH9CevdtZkQ+4GAuwHrXYKbrf9cQ6mutEIztpwMp3hwP5OossdWeQnLYJ7N4kkLPOoHZhlMz+PRMkqp+gL4S+dzgWoL5++AKFokxgCedkNXEPTL0otKAsnBQlY1TnmMv7TMxUocYUTh2ovQQj5DyE29b11Wb+PQ4r53YtHt28c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741179455; c=relaxed/simple;
	bh=3x5rvnjc4YPt99yxcqUJ9KPf1xj7NdsY0ZGal1jTXPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=VfmYWljDEoTO938sMw1v+Q4ZR8l0+BRoNPeOl6enmgjF5QLanemKxn+DGhUI6qPJrc2zcp2PetwuyPBymskMu9WUxD7j3coBZ/s1Az64S+c2NINUCFkZ3dF6XgpKBbgqBq+ZQyu6xHmgXIfUrbP4Ty+PU4GHA6Ad7b765oNbq8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=chUD6+7I; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250305125731epoutp044ef51173d7338c77f19f8fc397c53e4c~p6Xxjk2GA1646816468epoutp04H
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 12:57:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250305125731epoutp044ef51173d7338c77f19f8fc397c53e4c~p6Xxjk2GA1646816468epoutp04H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741179451;
	bh=s/gtT1lET+EceP3+qrGo1lcUcIaDdCHOw1iDN9Hwc8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=chUD6+7IzJiD2+mSdbegLmZF4CjZnQqsBm85H8YjA4vBvpVQrkVkETd7oZlGsVMpB
	 yrGtJvqoedP0UWnLgya5y8wMq2HQp6G4cSxyV2IId05BfjsDXKN/5iGi/qFNt5wAYq
	 vjZopuCQNkYNyfuYxXCCsyWa9jXt57WZjXcuUawQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250305125730epcas5p3ff191251d017d4ad7028a2ee6d2dfa56~p6Xw5DyMv1709517095epcas5p3a;
	Wed,  5 Mar 2025 12:57:30 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Z7CJ85JWNz4x9Pq; Wed,  5 Mar
	2025 12:57:28 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6D.97.19956.83A48C76; Wed,  5 Mar 2025 21:57:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250305091856epcas5p4228c09989c7acfe45a99541eef01fbcd~p3Y7m3GmJ1060110601epcas5p4O;
	Wed,  5 Mar 2025 09:18:56 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250305091856epsmtrp12f0b8a21dff24fc2ea5c8f10a39e39f2~p3Y7lyz0K1941119411epsmtrp1Z;
	Wed,  5 Mar 2025 09:18:56 +0000 (GMT)
X-AuditID: b6c32a4b-fe9f470000004df4-88-67c84a3817b2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	EF.D6.18949.00718C76; Wed,  5 Mar 2025 18:18:56 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250305091853epsmtip2e87376224a2f9c39b68270730788a1b1~p3Y4zcjMv1567815678epsmtip27;
	Wed,  5 Mar 2025 09:18:53 +0000 (GMT)
From: Swathi K S <swathi.ks@samsung.com>
To: krzk+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	conor+dt@kernel.org, richardcochran@gmail.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: rmk+kernel@armlinux.org.uk, swathi.ks@samsung.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	pankaj.dubey@samsung.com, ravi.patel@samsung.com, gost.dev@samsung.com
Subject: [PATCH v8 2/2] net: stmmac: dwc-qos: Add FSD EQoS support
Date: Wed,  5 Mar 2025 14:42:46 +0530
Message-Id: <20250305091246.106626-3-swathi.ks@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250305091246.106626-1-swathi.ks@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0zbVRTHc3+/viAr/uShFzYnljB5DGgH1FuBQRzOXxguJMRlEgxU+ksh
	lLZpiwrGbDhSpfJenNKwtSKIwJTR8eyA8CgPgSHQgrIMg4wlvCYgj2WbDEtb9L/Pufd7zvfc
	c+9l4a6DDC9WhlRFKaRCCYfhTGvt9/cLQnHDYm7Dkh96snwNoNr5djq62TWOocpf82lIZxqn
	o4eDC0w029OBoWXtHww00VpMR4YHM3RkNlYykGZmkY5u7P1ER4P6l9Du6BpAVS3bTPTnRicT
	mcaWcDRVUoah/c52JtpummXGeJDmmUmcbK6bxciHJS1MskM7xyT1hmzSUF/AIG9XXyI72rcw
	cr17mkEWN9cDsrebR24ZjiccScqMTKeEIkrhTUnTZKIMqTiKcy4x5UxKOJ/LC+IJ0Bscb6kw
	i4rixMYnBJ3NkFjPyvH+SCjJti4lCJVKTsjpSIUsW0V5p8uUqigOJRdJ5GHyYKUwS5ktFQdL
	KdWbPC73VLhVmJqZbtbUMeUWl0+uNuRjl0HvEQ1wYkEiDE59fw/XAGeWK3EHwLuPJpn24G8A
	q+q7MHuwC6C61Ew/TCnUabADdiW6AOy/m2MXbQO4aLrNONhgEH7wtx/bbKXciacAbpSP2kxw
	ohaDo/MW/EDlRrwFn49ft2awWDTCF/bt2xzYRATcMwxjdrdXYcOtHpvciYiEA70a2kEdSMyz
	4OPPnzDtoljYNL7kYDe4MtTsYC+4XKJ2cApsKJ6m2Tkdzj0tY9g5GvZYKmkHPeCEP2w0htiX
	X4Ffj/xs6wEnXGDRs0VHP2zYfuOQfeDe6oyjpCdsrVl3WJHQNF5Ot0+lBMCC6TxQCo5r/7fQ
	A1APPCm5MktMKcPloVLq4/+uLU2WZQC2Bx1wrh0szG8E9wGMBfoAZOEcd/bqyJDYlS0S5uRS
	ClmKIltCKftAuHV+ZbiXR5rM+iOkqhRemIAbxufzwwShfB7nZfaVjnyxKyEWqqhMipJTisM8
	jOXkdRnrZ8Sd8M1tU5xIqnnwae516Pl8ybi5qP/O0l38/ouXJsvlR/m76rqB2Ji0vWui6haL
	7sr9Y6HFq/SBouRUXuOye2Lb7AtJ64/Px1R8WWU+JhlOEw3t9J1cUTyKN56frBgpLMi7P6RO
	fM8vfEY+chHJTLVrboU7X7ndShZkGEsX/gksSmbv8LjNWEhtXPQH7kNNv0f8lak7XRa/GHB0
	zdfZPDZo2hQ821yZ7UlofMfjrPbtJm100P5mw9iE5cPOiz5rqncFxlOvTSllqVtq7ZmJC99q
	PkuYYH+jU38RFR3hk1rxg7c08Jccbc+cv+5enr7j9TurF26O6msKNxOrT7a54LmBHJoyXcgL
	wBVK4b9SEhIDWQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsWy7bCSvC6D+Il0g/+T1C1+vpzGaLH8wQ5W
	izV7zzFZzDnfwmIx/8g5Vounxx6xW9w8sJPJ4uWse2wWF7b1sVpsenyN1eLyrjlsFl3XnrBa
	zPu7ltXi2AIxi2+n3zBaLNr6hd3i4Yc97BZHzrxgtrjUP5HJ4v+eHewWXzbeZHcQ9bh87SKz
	x5aVN5k8nvZvZffYOesuu8eCTaUem1Z1snlsXlLvsXPHZyaP9/uusnn0bVnF6HFwn6HH501y
	ATxRXDYpqTmZZalF+nYJXBmXu1ayF1zhq5i8uoWpgfEgTxcjJ4eEgIlEz/wupi5GLg4hgd2M
	EvPm3GCDSEhKfGqeygphC0us/PecHcQWEvjEKDHjXQSIzSagIXF9xXZ2kGYRgQ4miT1TTzKD
	OMwCG5kkjl3aDNYhLOAk8e/cXKCpHBwsAqoSh/6DDeUVsJb4u+kEE8QCeYnVGw4wg9icAjYS
	Rw92sYCUCwHVnPzJPoGRbwEjwypGydSC4tz03GLDAqO81HK94sTc4tK8dL3k/NxNjOD40dLa
	wbhn1Qe9Q4xMHIyHGCU4mJVEeF+fOp4uxJuSWFmVWpQfX1Sak1p8iFGag0VJnPfb694UIYH0
	xJLU7NTUgtQimCwTB6dUA9ORBR2taTLesg2vFV6bvr9xQVt42pzvEzjX59o9k/nusq5IeSlz
	Z7WDoEbsd4aW5v8lm02ufa/UaujhurnkTv/8/VXTjpcpf/Kaff+Z0DT5T33Xps0qt+A7rmy8
	vWSBTCqjmp7zmz1KL8snb5T/9Orv/hcrpqz6F6ngEiAaUTtF+VmUsJxzFIe0+knxUxVndJcx
	6P/5Gdj8dJtmm1OsxotKRdbJDQI/4/WP5J7fnhhy2GdJxp3+xQFJ+8/6ac2v1lu+rnGVhZrh
	778f2F64X43sZDBuFD0qrsRhblB5IeTVcYFVlr+eFu3PXSTCcUR3orPyyy6+Te5/+9PzPF4G
	3T2VdCnv/iu7pE8XPVRDfZRYijMSDbWYi4oTAbJmoK0OAwAA
X-CMS-MailID: 20250305091856epcas5p4228c09989c7acfe45a99541eef01fbcd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250305091856epcas5p4228c09989c7acfe45a99541eef01fbcd
References: <20250305091246.106626-1-swathi.ks@samsung.com>
	<CGME20250305091856epcas5p4228c09989c7acfe45a99541eef01fbcd@epcas5p4.samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The FSD SoC contains two instance of the Synopsys DWC ethernet QOS IP core.
The binding that it uses is slightly different from existing ones because
of the integration (clocks, resets).

Signed-off-by: Swathi K S <swathi.ks@samsung.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index 6cadf24a575c..e9038d015cf0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -325,6 +325,10 @@ static const struct dwc_eth_dwmac_data tegra_eqos_data = {
 	.stmmac_clk_name = "slave_bus",
 };
 
+static const struct dwc_eth_dwmac_data fsd_eqos_data = {
+	.stmmac_clk_name = "slave_bus",
+};
+
 static int dwc_eth_dwmac_probe(struct platform_device *pdev)
 {
 	const struct dwc_eth_dwmac_data *data;
@@ -365,7 +369,8 @@ static int dwc_eth_dwmac_probe(struct platform_device *pdev)
 	plat_dat->stmmac_clk = dwc_eth_find_clk(plat_dat,
 						data->stmmac_clk_name);
 
-	ret = data->probe(pdev, plat_dat, &stmmac_res);
+	if (data->probe)
+		ret = data->probe(pdev, plat_dat, &stmmac_res);
 	if (ret < 0) {
 		dev_err_probe(&pdev->dev, ret, "failed to probe subdriver\n");
 		clk_bulk_disable_unprepare(plat_dat->num_clks, plat_dat->clks);
@@ -406,6 +411,7 @@ static void dwc_eth_dwmac_remove(struct platform_device *pdev)
 static const struct of_device_id dwc_eth_dwmac_match[] = {
 	{ .compatible = "snps,dwc-qos-ethernet-4.10", .data = &dwc_qos_data },
 	{ .compatible = "nvidia,tegra186-eqos", .data = &tegra_eqos_data },
+	{ .compatible = "tesla,fsd-ethqos", .data = &fsd_eqos_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, dwc_eth_dwmac_match);
-- 
2.17.1


