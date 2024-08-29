Return-Path: <netdev+bounces-123047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 537509638A4
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 05:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77D4F1C24319
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 03:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC8B38FB9;
	Thu, 29 Aug 2024 03:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="d4oC/oMh"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2052.outbound.protection.outlook.com [40.107.215.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3831F18030;
	Thu, 29 Aug 2024 03:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724900939; cv=fail; b=ZkCuWhAsF9Q83bqybyUYBbZHtqQcqDwfvo8TZcDG+Fpze+3glEMVFQh7gTvWE08sM14WF2Lcw+D3FaPBmb4nvoQ0OBfn6D6mkSlQoDrnIAd18ruU6zt7t6FcnjblKct7uCHGL1TQe4od2w3BUmuK4rpvUboHrY7AHWi3d4cGAsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724900939; c=relaxed/simple;
	bh=JF49wZ8dBUxQkoXszbw3+zT/9szycx3wHjh8pOb08pE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KUTKDDE5SmaHnytImX3F1yOkm5koddDwJyyxOayY+tjxrQrnK0yejAEA3LEPLGNrZ4RidMN4mGw+4URGbxSVO9Sj1MJsLfCg2WPEbdQfWwRPv+jaJ08/YyIfV7N7HpnTH8MUrIaapoFJ7jQxvPdOZHOnJOU00HkXSv9BTnKmn6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=d4oC/oMh; arc=fail smtp.client-ip=40.107.215.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=legrlMgXe9dNCUtfvhNJLam8tj+955MtkYJSAOnjPlxPMRHVcY6gbn0SbOI1N1hIGkXhy+NzFmrO0RAbhlUCHPa0yA5vbK03OM0dQozDTR2FkNzqFh2P/eX06IWrptO5WLDN0hUgAv1Z8rrX9DojGdQl8gCtF/XNgMmFAtaVBGI7ikVdc9mOIBH8BllVJ6M/5U7B1XYcmFpztCBAzC4bjm0dUMeGjnZcWd+k/q8JYPvaiMrD2TWMF8SyGQYUUOmH1e8Hh1ZezunO/fbXSbuywOVif88YF/mJEobRpNXHHTBpdcTw2lSrdsJk+Gp9rALeg3es2/03Y6U6yIvOj5K4CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGg4Cm0Nx005NjxkppQTOlx3gN1PN+UZabH6kOweOps=;
 b=dRr/nffymX5m9fAfH8gsQGl8r1Xe4JNkFEM3cQoc/e2FUl2LaEp+Dc9JzrXP96wfRgxT2Tx4F/UPSEjx30BQ6VNqyM18hrP79ktcLa2G/4C74Z0ax435vvzIAyqckblp6c9mgCJ7CYTHo8Sc7kALcsLcI+QEW29lehj83MOPLE3yAOWDfEYrGYdm2vVCRwjLPDfsZemIkkDOTsbOdha6rMZppcPFPbzEZKLvntfYEPit33d4KOQhWB+K+Yi7c63Ym3HPRBt7oXli+yuuIJvb4Zq7QkkIs0ntk48V/XtQqcCxb34QstSYfSBAB8jKQCSh5karT4/VK3KFkPrTyX0DDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGg4Cm0Nx005NjxkppQTOlx3gN1PN+UZabH6kOweOps=;
 b=d4oC/oMhp6Ra7NrjjXb+ZCEBT2j3PxW5sPyWv9nVlVjoOMA465+MwhTjRoNOOFVIlURJ35SzOjdxnUgVVtyFICkt33xzAY1c53Gbmvz6MLcIQt7YSqAHOgeUTWOJqo0PEOBVZkFoBE+Vce2U9jnQAACd2m+u1oAxRXf2fktz/W2SbOHHD5kzB8g8XlrTLMlpAgpCOKQqswjaU9t4nbjYH6WJvjjpYBfpcX3hU7Fp0Xa5B06h/iFg2+S91llW2HmabcHqTllA4f5q/TmQTejY9s9OG+gzFb+uPQAOlGjsJyenclgW15bebHyZYChZlEOKioorTt/ULPFFLcL7BmG36A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5709.apcprd06.prod.outlook.com (2603:1096:400:283::14)
 by TY0PR06MB5836.apcprd06.prod.outlook.com (2603:1096:400:31f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Thu, 29 Aug
 2024 03:08:54 +0000
Received: from TYZPR06MB5709.apcprd06.prod.outlook.com
 ([fe80::bc46:cc92:c2b6:cd1a]) by TYZPR06MB5709.apcprd06.prod.outlook.com
 ([fe80::bc46:cc92:c2b6:cd1a%4]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 03:08:54 +0000
From: Yuesong Li <liyuesong@vivo.com>
To: elder@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	lihongbo22@huawei.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yuesong Li <liyuesong@vivo.com>
Subject: [PATCH net-next v2] net: ipa: make use of dev_err_cast_probe()
Date: Thu, 29 Aug 2024 11:07:39 +0800
Message-Id: <20240829030739.1899011-1-liyuesong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR01CA0013.jpnprd01.prod.outlook.com
 (2603:1096:404:a::25) To TYZPR06MB5709.apcprd06.prod.outlook.com
 (2603:1096:400:283::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5709:EE_|TY0PR06MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: 2708e744-f6d9-4688-dcfd-08dcc7d7ea3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bAnrYBwMIq1KWIHKgKuitROpOQZagwT/e0Pm9+8dX+wRBMW9hIfoSmfzHkZw?=
 =?us-ascii?Q?eUKx6shkklKTD1h+fZkqaRXHSEcvPe+XSEu6JrBgxXse1/x0jBuS79TTJiQs?=
 =?us-ascii?Q?90VPBgw4HUXORud9jWkar39zBVGG6Xvjp/wVn3DceXxjVjox+85T6+ysxq7u?=
 =?us-ascii?Q?Nj36ZsSZNgJXVOpUX0L8ISxoLnCLdTM9u15kLNJSgbFA0ms214sK5CuD4PHH?=
 =?us-ascii?Q?NShvn1J3bz8fP5HNHEXTu6ImhY67U6FHPDRUeYYPEIBehnz9MUIA7mpKr+wK?=
 =?us-ascii?Q?72DMELkzbgEYKK+qBurTcpA5EYxnCApYGl91h5kxXDqkW7coBuvD9Yq9ntZ4?=
 =?us-ascii?Q?eHdknYR0ItnjFB4dUZMKfFswTNVXwq6KmEpGSl/peBQHzw99VUk6+fubvatY?=
 =?us-ascii?Q?M1uSc02ADMLiKw9GnlMcGcFg1AcEQB4e8txJR4HvbWmfKZT2RpHpGPX6gYBg?=
 =?us-ascii?Q?IXkJtf8inaq7cEe4AoHX/1iw/Nk8QrWcVzubx37DOfZdOfAQMSXZoFWwSYp3?=
 =?us-ascii?Q?izj4AhnLdLPp7o3P/zYWA/Qe3tq3SZCl3osYcKsftWRfNwTSU34383kXc5mm?=
 =?us-ascii?Q?J4EBFo8DLY32vZU9Q7/jX1dK+98gh6QBJ8Vij25YpOLKZH4jx5Xg2hccSHVg?=
 =?us-ascii?Q?ntERdneRqOUboPkx6Q19Pe437MAHZDXWEp/devk1E7mYMI0jumMz0XmuTpLX?=
 =?us-ascii?Q?uFDS3rZoqQRWehcguXkOZaQx+iu8XivsFO4M7KYdq6KxpIbLuUUZCPmHjP7w?=
 =?us-ascii?Q?Gtsw6AUKPvaNJaeE72i/2Vl14KuDVVt+gnXcVxQweyUgeb5o7s9iIDb9d1LE?=
 =?us-ascii?Q?HXjZeT53IvKG1g3Pj+o5aD5o+3oPogJHT3kvg1P5AvblKKPp78W3o1a1V8im?=
 =?us-ascii?Q?KRRUxhuvWO7kDPi08DBHja7/JPdl8p0PWRwWxhdK+lSkobRBj+lyZ4yc0YhO?=
 =?us-ascii?Q?OZ0WWLdvylRc9Jxy1LmwZ1sI3y/Y6p/yhMzv5YG1s/JB+HS5oXOEqKRJQJRh?=
 =?us-ascii?Q?rQtA7wdQCupD/MMP3H6M0Bp6FoAZslxDWF0YBf9QC8uaZ0sMd3JnPHc047r9?=
 =?us-ascii?Q?czcdqfo4hfHEEzCmrBzVaNEFHOjYM8DNpxH5WePrmg3GDIIQxGTWctdAVu7j?=
 =?us-ascii?Q?iYefsOrlvlbwSadJzzlKG7Bke4XJAS99/VKTqQg3Qkn06ko/kr2HfHyijUtD?=
 =?us-ascii?Q?hi0L++TEefELLZGBVsVtnhZXYGmaos2QNKiZX1x6KuyP+SIxO4Lyk6Iy1Yf2?=
 =?us-ascii?Q?SlWglXm3wmPcWHrCGg/I9F+ENU/smj4i5T4evsWw2KuODXP+tKexdo0IBTu9?=
 =?us-ascii?Q?LtQ1XjCpOCYUwOHKFyHxEarQnPhTqzulDq9VUuPF5pbR6SOV6Xf/1WjQptKx?=
 =?us-ascii?Q?yuX2khs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5709.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FmvbWrdk0R1dFolHTwnD27LRUm6eCgybkJ3EvGnwiF4Tz67qptU6mT0ZUa23?=
 =?us-ascii?Q?e/EaLrjK8ptK826jiplvNR4l5EcEa4XqT8q1V0fwetSufrnJiwPGa22EJy9k?=
 =?us-ascii?Q?vy+vP9JsZAQ4glr8+Q7BFK+AqmkrGDlA0yDpxfAvr4nwxlMaLuYRT7tcB6aE?=
 =?us-ascii?Q?+duLNkeDcnA3AmZmOodY0UjrbgiVdHB2zl6FouV2Ncpv7Tn4syXACgUZB9pm?=
 =?us-ascii?Q?5YNtxK8VZ5wdlFJfPa/hm5uAxBpS2AZ/c/j8GK87IE84Nk3ojgVjDeqyFZG4?=
 =?us-ascii?Q?3WNjyzJ9L6opt7mOYpheFFPDiPzotCQe6ncEX/uieS1gVrxLruil+g+q4aMm?=
 =?us-ascii?Q?59MFc2IatIA3CyHhDjW4yVuMVSaBvJzN1uJdxMJW635RZM5mJdzRimw+3gWl?=
 =?us-ascii?Q?Qo6dGCnC43luJL7NFQYhDgtPF+mkuJCmOVF38C4mco9fIB6LzZ82FWlV0OIu?=
 =?us-ascii?Q?9KEeOCT/8N9QgQWBxXgRHEjWFK/iGz+yRIKEaM1D1W+NwG7u+gjZIz0Wvfeu?=
 =?us-ascii?Q?M0JX9SgsKpSs9LkzHgiZiyuU27eLWO5rYaK5yOMJo9SqKDnd4jLla0KSKRL6?=
 =?us-ascii?Q?yNBixOJicyZanD7dQUf9FBOO5Jhi2+39K2I0JXWLYWX5hkGt7+cYUAPclhFN?=
 =?us-ascii?Q?zoKA1wfJBIkIiF8Gn3Jw2/6hnKFit/EBihunOrK9wb8SZnIr1dF3dyIRTXzK?=
 =?us-ascii?Q?8KdOTW3R4BKxtndwlWxoKeLL8yRlFEaopLVRoz3zPtjRbd5miO8k+zmgM+xc?=
 =?us-ascii?Q?WyMc+Y06qvE26CuJ1ogbL5Bks8HEf6d6+uR+LY6aXngJqivBE6fwbumMhbdc?=
 =?us-ascii?Q?NRTYf1Q2U8VbSH5CvrJiX5HJoF7X8lfFgBWxQL+92ldELkLplWmeKnkB6X6W?=
 =?us-ascii?Q?yNHOZOZMhiG3bO5Zn71UmQx2OkAkTyb4SJiKq8HF2xKZ7REhdMriaS1gJ/u9?=
 =?us-ascii?Q?y1lUobPb/2t+5DEOf+sli9LrKhPEhVdbq8J5BVjkJ0zNhdQgHinxk7DBYBwW?=
 =?us-ascii?Q?AzKDA57gaxti2w0RudV28ZAO6C2xkLJe2aPEgv2Yz172UTXclQKG9jKT5A1W?=
 =?us-ascii?Q?5D0Ns+cBR+PaaehotTSYj2VMUYDdO8BUjnDOnORlchhAyyA04/iNuwYVNRbP?=
 =?us-ascii?Q?36TBO2SdVmtVMbVKO4GV8OoFwYLVJ09tKS+qq28TAqMDg8NcBApsJGG9mHUV?=
 =?us-ascii?Q?+dIO/PdUViF5sbTr7nBGBhKoMS1Y6NdqHDtCZjx3s7GTGWD8itOh16MX9haF?=
 =?us-ascii?Q?nsKz0WmGzskZFF94BsAAgWIE/+6swLStbHGKYhGBQyJ38GVhV+nfCWEemIRB?=
 =?us-ascii?Q?orJFjqByrJGGcWfL4ovvONkrOoEZrswiB20pjb9Iwe7+RL52u1yQHIxqAdZB?=
 =?us-ascii?Q?ZNbrE+v+QCjcjpbP3yMwx/z8KHW/w1bW9QcLJ+rKf5WN9CQ/mb+yscKlj3EJ?=
 =?us-ascii?Q?44SqvrAjSMQARB4jGLWTIBvoVVomqI5pupBtwpr2rG9T5F2h6mENRHpHPuZP?=
 =?us-ascii?Q?63HHwLUrGEoUa7iN7tFZRL6IgbzGe0f0mptLr4m/iemmN41rGqPBGbjLKtty?=
 =?us-ascii?Q?Pm2VuDatTZKccEUdAar14F2Oyqg6zAcDmmJGYmqu?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2708e744-f6d9-4688-dcfd-08dcc7d7ea3f
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5709.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 03:08:54.3522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CaoJffzNIwRGuiKVUX9OZbPNVBA9wHcAKWeYY0CIUpJSKWw2ChdaC4PvI7CEr9e/sbZdQ5lfAU+eMZB7BgLPrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5836

Using dev_err_cast_probe() to simplify the code.

Signed-off-by: Yuesong Li <liyuesong@vivo.com>
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
v2: https://lore.kernel.org/all/20240828160728.GR1368797@kernel.org/
  - fix patch name
  - drop the {} and fix the alignment
---
 drivers/net/ipa/ipa_power.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ipa/ipa_power.c b/drivers/net/ipa/ipa_power.c
index 65fd14da0f86..3c239c3545e5 100644
--- a/drivers/net/ipa/ipa_power.c
+++ b/drivers/net/ipa/ipa_power.c
@@ -242,11 +242,9 @@ ipa_power_init(struct device *dev, const struct ipa_power_data *data)
 	int ret;
 
 	clk = clk_get(dev, "core");
-	if (IS_ERR(clk)) {
-		dev_err_probe(dev, PTR_ERR(clk), "error getting core clock\n");
-
-		return ERR_CAST(clk);
-	}
+	if (IS_ERR(clk))
+		return dev_err_cast_probe(dev, clk,
+					  "error getting core clock\n");
 
 	ret = clk_set_rate(clk, data->core_clock_rate);
 	if (ret) {
-- 
2.34.1


