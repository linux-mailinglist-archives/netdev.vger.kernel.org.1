Return-Path: <netdev+bounces-140625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03ADE9B7465
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 07:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 534CBB21E91
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 06:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608AB1482ED;
	Thu, 31 Oct 2024 06:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FeGYcJ2h"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2069.outbound.protection.outlook.com [40.107.249.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016F2146590;
	Thu, 31 Oct 2024 06:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730355485; cv=fail; b=jwDo+YIwVEP4KqQBudKwgDv2KJOc7BjL4RLnTb6cp8FqMA0/zLX1DWER3k0GH8s666OEoWM5IBjkYNEv11Qdkw+O70oMsox2kDBEh19DGgGHwjYh79MP3RlxlFbDKmoIh38CBKHegMwe9HWTFrvIWt2vJONIULCbq4G5oCp6B+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730355485; c=relaxed/simple;
	bh=v043fRlOSpAAFDN7KD1wwevdzqJ/acMrRBgCi1nD86g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bBwNUowbQ50j2qQx7W6AKR3xfwgfkrlMLtJXl1DUEufHl3RURxVThksTOL2VB7FnKqxZzKHoxdnVodmJmknv0JirYi89oy1oZQZdik3xAB08yrw+S35B6XzBRkLHLG6acHoQrZv+Ij48MKY0PYrtm2meU3OUN3vioGvkTsEoX/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FeGYcJ2h; arc=fail smtp.client-ip=40.107.249.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cp2Vqmz9/0U3inRAabPd9mucutBRzcN9uh0IG5Jrxh0t7FRvuOWeZhTb9BPZ3mfZX9OyvwsUG5NIzjqTu5erzBHzsclQ8Vr5ObclSdW5fKcPyb+QWJ8Un0L1wzk4DNTXUTMs6l+lqyUPoSMSchtiCark6wgDMJdueBCXaU3IkgWDVANJt8SGeWX+hqJGRDEpGkU8IypGoK3hV9lKFZIX9T8Jpc0tvtjSy+xeA8UHjrMMEzk7bknoxkoXE+ewBUaomLFWAgpjzFzfYSA9DfTTUUmS4C4DWfVUKV/QbEy5VyrV7TsVp0GXemKjdRaHUXniRZ/rQCgrMtm+uFp/O12FZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMJ0gXuX9CQ9tUEUlkyTyEk6Bgd7Jo6Qd29mGtOmxR0=;
 b=Ob4ZEVfdZy30WK48BbcU6ck2FXUWaNrE81Y+rZt2R6oIO1kkbO/7WOEq2gWHFTpXNthNOUaGFOhzA5dQU9bsds3sk9u/7rqLen61vsjnKQSdumjHonq77G9P719ChidoJuJQ0hcV/jYBSNNYZ3vGipKJSxDQDt4HQn9n3h5Iq8O8p0h3Oql8FQrfej5xERAZTFTw4KlcGmiG8z6sLI69tHskQiZ9IBa5I94h4ppctYN9dZTRRQAyOZ2IUNwgQlBtiBCYd5AhrxKlX45STK6oOKSu0vId0AexnKRMnbBqgJov9td57kZyrrFn7sb9EfXaCZFfWaPTyK54XvGQ+rwuwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMJ0gXuX9CQ9tUEUlkyTyEk6Bgd7Jo6Qd29mGtOmxR0=;
 b=FeGYcJ2hKfWFveDeBpyb50caQgiZlmrTD46ljG8p4chKxfnZctiHnqONw7CuZVZfXAzfQOjDh45A+Vb+Sai5UTV70pxWWId4k6qQmj2vyPVi26nyI3ShJAEY6h7hb244azPDsnY5VAPHEPTXXLWfUuRJPJuSbrPf066D2z14tC60eeyyrkgG8+Ecy6kYpDcY5PFKHSfw3vwdqLmvkD1us2PfPnNzdKeKqC2HjXo1rB/SLi2gRmPZqHZfLP5N3Ko/OabpUywLc4uFCF+acCgHP5VnigsnkcB1ZDsHOEL6ztceoOx6RUtDid4LM0pson9GwQQkaE7amFACl+fJ3eKnCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8742.eurprd04.prod.outlook.com (2603:10a6:10:2e0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 06:18:01 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 06:18:01 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net 2/2] net: enetc: prevent PF from configuring MAC address for an enabled VF
Date: Thu, 31 Oct 2024 14:02:47 +0800
Message-Id: <20241031060247.1290941-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031060247.1290941-1-wei.fang@nxp.com>
References: <20241031060247.1290941-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0169.apcprd04.prod.outlook.com (2603:1096:4::31)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU2PR04MB8742:EE_
X-MS-Office365-Filtering-Correlation-Id: f988f7b2-f882-466f-b4ed-08dcf973c582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gH21K7BiA2eiUe6hCnNNI8/CeocbFv7ylfrGUbzJoMQX7x7prnNnsoLbY3qv?=
 =?us-ascii?Q?0ha/AC58QRVp/bRMrPist/yL6yQ6DjE2obkHG71VDKcaFpHACG9ww7HV6TLQ?=
 =?us-ascii?Q?JNhERa0ILGc47yjxJYtppNSAPJYa0JKS/onY41S7i2Y+tWxiE0Bp9fo3tCb2?=
 =?us-ascii?Q?OON9XWrfZJKY51wEGtvzCD554tngqrn7kMcTFCCH1JwbWD8IWFNmC50wUQLK?=
 =?us-ascii?Q?VBrFuTCQBuQ6TEfW8SDsVjl+9Me+O+k7e49FH6PeFPEeuZXGwmABGXlR89qX?=
 =?us-ascii?Q?1jJc1xqXIgKnX30xCWBJ4RRhnODCNqrXnRvlNcJOLkNU9sHDxtFIlGhh7Hvw?=
 =?us-ascii?Q?eVkNX88HeCPoGs4xWHxZn9r+mRcfCaFT2+tPfMhnzgyL1l8giSQBjOXJskTE?=
 =?us-ascii?Q?3FxhofoDQGz1udUypECtlrWFVh9KGZvMXiwId4sp9OdHtMGCAY3o9B22ezL6?=
 =?us-ascii?Q?HpeZbPdl+SUauvMM5qy/+LvtNEdftBAXvpvFB94IgeUL78JMERccWUdkD3OK?=
 =?us-ascii?Q?ayrL1oDGyzgK4ctqVupZTXU3Ht1+m2nvkIQSqp4951z69S43Q20i57+9cULC?=
 =?us-ascii?Q?JcXBNi1RIFEg6iDi1QsTzrwlAJJzPKaSobtleRmyLOQkip0VBTuL7Pa6vz51?=
 =?us-ascii?Q?BtWdJ5PGzHZt5sP3LWBjlKpwxHI0YaaLoBuNWssfwyGNTYcRy/av5bBhyHRX?=
 =?us-ascii?Q?AXZhfW1gdP40alcxEbs6AbHtq9dtH7D5quodfJyj32vFKIiKnxSAeOFQ1VQV?=
 =?us-ascii?Q?2YxycOQtcWgavcPFNK1ArMveGKqpT/yuV2zWv8ypqY0cIUtLVF8EzATKh4A7?=
 =?us-ascii?Q?A6gp4cyQJARMwrueM4wmtu2DF2tqJytFpZzvSfvVt+OdgDVtzHWAUhS9JUa9?=
 =?us-ascii?Q?p8eDEODCzwfnJ86sg3d8/IbevBeHZYocXT2gZFf4a17r5QWopC0r4SH+IcxT?=
 =?us-ascii?Q?+hIq/BYCwrQjdWpI21sK7CR3GnJvGe7rb1Lzik8R6yd0FK39wFZ830kvY+B3?=
 =?us-ascii?Q?k1g3Y8HEOE8BD4ZUXE2sXVeElbEgscM2HvPCGhi4hjB0+MWIcxPSdH5nXBJ1?=
 =?us-ascii?Q?9ON5Rs+ymmJu9qYBGN3hWxsTQpsQAYo9ghMZLoh0NfwH9N0aQZ9ZCcQu/V0Q?=
 =?us-ascii?Q?mmq/RZsO8hYBCh/rVeqdPmgvWf8Eb6yO8rWO5k9c6VnYWjea1UOoaPspLWMi?=
 =?us-ascii?Q?Zsr/4Aw91xQ28RX9or8qYEAoKSBq0lhdBRvANcWLlVdXUwcKHrJ+EW+nV+aF?=
 =?us-ascii?Q?THaS9TgPoLfRKWd5g9CLaMPx5EXZz2MBw3viki8uH7S2+wgRuPdjjbPOhJiC?=
 =?us-ascii?Q?ps41p+Kq3epEL+bYsgKnobQF+pJov2Y9zGHHJ+FiQ1ilXJoEG0TwwNKCYrJB?=
 =?us-ascii?Q?JKukYmY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gZ4XaYpVDCvlpCz3BUA8fTOJr80g2vnZP0Is4MD1eJEzQYq+GSup7wIp9UXk?=
 =?us-ascii?Q?3a+zuBZzDr9rLze4tk6S/5xadpYFWhWbU7BvMFT9PhO0dqg9Wh11Hd7vcXbg?=
 =?us-ascii?Q?RXeQHakudJ2tSQAYwXaC7Nn8MEOUpRGGWp4cc7j/QJXLdASs/D7mHYacmuow?=
 =?us-ascii?Q?Nxy3bszaltCKJHTAfEqAihy+PBA7hD6GkFrAoBKgNqvCMjl76YQaz46o+3/R?=
 =?us-ascii?Q?peR+9WkzoWJTuUElPubam6D1QNZS2a4pcO5U8XnTkKOTBObIq6uvroxrJ6IY?=
 =?us-ascii?Q?BBfO/W4YvvGM7vtZIGbg7bKdP/Hn2yLi41kkEp4zcDlLoytySXnKw10SaFVu?=
 =?us-ascii?Q?NEgfrLQsUtuy+TPwC/GgEI0EV2HSEB1O10AnnnLDPtHAcVNvqndhBC+PByWY?=
 =?us-ascii?Q?F7Fv97znJOXOcid6bSHyYM7oxaJSpG42WDgVWKupNaA+FvFksB1Q0WDMXX/Z?=
 =?us-ascii?Q?wgBXkHxAlTyedX6C/z+lJuxyAzYYmJCcWT2d9lETXX/6mif5xxHSakFXdpVV?=
 =?us-ascii?Q?PDaYrvVc0QDS/6QLKz8WdwLF41ZUtYhtA+ZIn493QbGBDzatupE8oBvnwxZI?=
 =?us-ascii?Q?RU+jmfqqsKOxKtUg6C+QlZex3hkaOAbJN4ndcOJuYV+8kCvk3cgnB4DJuKzk?=
 =?us-ascii?Q?9iFNudpbmVHoPgNiEkUGoZEpD5kN9Hkvc2ntZK1M+K2IQSXA7nBrW+vnbQsr?=
 =?us-ascii?Q?TNE6to6nTrOW3vngSHFbitKTDexwCBUk15jAgz+LWYCScgAV3pHXWtb/VpAn?=
 =?us-ascii?Q?CzA0nbQASSUq01oHLCjhneJHdx80SjzYLCH9VBSDRiqWAITv9m3ZreUiOen0?=
 =?us-ascii?Q?HcmnxpoGbmnhtuo+crx41dwoZ9tye/OAC4APw4thOZ9ApayGmm11McsW1dXZ?=
 =?us-ascii?Q?1g4gklnKbW6LnxT2izOUQ4qOcixz7WRSRvuhe6NDo3plSkczi1dfxBqvA26J?=
 =?us-ascii?Q?mOBwsTpGYY9Z621wph03je5GU1cYrnw5HjcRgKvQxgk1b35OHZZ6VaKyiG1F?=
 =?us-ascii?Q?70L/T3tTF2NnxKYL28HdCF6ale5WN2NBgmIjHEHXPIiRn/ZExJNYPewL2cOR?=
 =?us-ascii?Q?eEpLUIVlXeI5dX4bE0D9mUMBq+n1MR9PWrg4HpG+QesSoY8tuvZ6ZeFW/Ec3?=
 =?us-ascii?Q?eXermnnSQYIrDYA1h7v2/SMLMKC8U1wH63OVoN7rG0XsKfZMTemAevJvFcsE?=
 =?us-ascii?Q?mT58rsdbws94W8Qw3dhs3NCaATrZoLWxXOrhW+tF5uohy7hzGuW/Wr8NXDg1?=
 =?us-ascii?Q?P8d0oeSpO4pbE5yPYnmwoSFg7tRxK1a8qoChl5vJB6x6tf7gdGDcUX9P1BLD?=
 =?us-ascii?Q?fwMSWzFQxOvrflEUkWRv6iDGfZ0L0pzYwDPKIyLBzpF525Hfiy3rDO2mR9wl?=
 =?us-ascii?Q?+S0wkKMa8zy8I35eyT7yAtv4qvXIOZy21CLdnulUpgSODxDUmkwOdDc+3iYP?=
 =?us-ascii?Q?0t0k+gKqVFYYlWfkuRsjd9muF0PZ8aMbF0RnmGqmaPYyOcS/erSOw58o/NAR?=
 =?us-ascii?Q?sNfmPtOLVOp4yr9ZgtZrG9vWTJN7MLQdkPtkfMDBZogFyqLq4seCW65tyR/J?=
 =?us-ascii?Q?XMZgUwIqt24BmkZuPU9DG9imS5y8Rqpy/k+4LIul?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f988f7b2-f882-466f-b4ed-08dcf973c582
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 06:18:01.2469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImgGyKFpWU1/FU31rTff5cljHMAiD4hTs4AI03ZqHIaf+0xO3ldPOP/8KQNcsbmW9sVhuYcwQyhdiWpLfq/IGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8742

If PF changes the MAC address of VF after VF is enabled, VF cannot sense
the change of its own MAC address, and the MAC address in VF's net_device
is still the original MAC address, which will cause the VF's network to
not work properly. Therefore, we should restrict PF to configure VF's MAC
address only when VF is disabled.

Of course, another solution is to notify VF of this event when PF changes
VF's MAC address, but the PSI-to-VSI messaging is not implemented in the
current PF and VF drivers, so this solution is not suitable at present,
If PSI-to-VSI messaging is supported in the future, we can remove the
current restriction to enhance the PF's ability to configure the VF's MAC
address.

Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drivers")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_pf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index c95a7c083b0f..a295236cd931 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -343,11 +343,18 @@ static int enetc_pf_set_vf_mac(struct net_device *ndev, int vf, u8 *mac)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_pf *pf = enetc_si_priv(priv->si);
+	struct device *dev = &pf->si->pdev->dev;
 	struct enetc_vf_state *vf_state;
 
 	if (vf >= pf->total_vfs)
 		return -EINVAL;
 
+	if (vf + 1 <= pf->num_vfs) {
+		dev_err(dev, "Cannot set MAC address for an enabled VF\n");
+
+		return -EPERM;
+	}
+
 	if (!is_valid_ether_addr(mac))
 		return -EADDRNOTAVAIL;
 
-- 
2.34.1


