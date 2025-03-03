Return-Path: <netdev+bounces-171272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA46A4C51F
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 16:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E51C1888DA3
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 15:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FFF215063;
	Mon,  3 Mar 2025 15:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="UO8uAg4m"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2036.outbound.protection.outlook.com [40.92.52.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A242144C3;
	Mon,  3 Mar 2025 15:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015502; cv=fail; b=fq+qUSrmDnWyqOqe9OWL2LZc/cE+PWOSF7j2T5RyJtHp0kOm7TgnBzMGqtaPyTKx82tcNk3YT3lP9j5DdqgKRfuV8xjtzWK8/ta/OvauwqRrL9jP3GDHEC1PX4zjTcfP5BPn9xKforVbNU1GRaohM6noRsCrmDAPLHHvYGmLpr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015502; c=relaxed/simple;
	bh=VksgpjwiCQl4YXu/GGTNwI6Dq+x+lB1rXSRlr7mOEpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tLmsYPTy/8eHXhJGuql8zR+Ca1+lDKd7Z6tijVmiU9xqT7kAdmUxa6PeiNVZHL5vD6HYw0oO7GaTwvY6fSpW24vbCIbtkYewIQbfxO/Ma6LF0XPAFgZw56TkJ8w4je70+MRpYiPPAQQb+N+nH/6oSptMYm3edhXhEW706uw/Foc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=UO8uAg4m; arc=fail smtp.client-ip=40.92.52.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wpKxeOO4dmN6e9xkbKJ4bULrhVZ8IZaZWQskjvm1lHsd91PwlHHmYKDIdp1Gkj6ovG6kpX0ihCvEzMUI5Yq7sKzOdqVzD3NuZxvg1+6Zv7oYG8IY8SoPlshLBoL5nlhSPP1AgTyihY6BCuTylWJqRA5nIndnneTrU0qVtFIbgTrUXEMd7qACB+64a523AZ6y+r+oGYo0VIkI1ib1/OFzwMfY/wJsI++rG6rOhlVsAz5kxr07SuXdHHRK8QpkFZ4O2aqdP2HkffYSjhZIg4L/UWxrNXn9rpj0FXuCBjEq6RMerfDWn8x/AMwx7nnmg6ecs7Y6hPIoNXG+y9Fp1oWrlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61VsuyHg6kErRAEzSgiimubzceyeiW1JEleDtpzKLAs=;
 b=zV7UM+SRuE1QOMlZr4Vhm9mRu8hx6Vqz19nJEw3EXdUMrA4Nsea9hPT1q50QPNa62Vt+LsCnYBxnNwtXaVfZB40SPv29JjQWg9+xzBLpE+ag3+jrurRS6UPszvRiBLXIpZc9hRCIEUmM51Sa8ebPf0qnMI9dNKKArRKNOjYP78EKWKXUHuq9jJtwm95AixGWml4tMcvHvFS8QudG5l9Bx77qTcK4UgqSfV5wxHAWQo7nAnTs8rNvkYw5ueADgknlFc65MmLv6BeQqjqRf0Qkf8Tgt6n+qKpyt8VYaZth9Hwokfk+Z+NDgCm4CPz9QuTW5GtATcmg4goYWIGQ+urdLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61VsuyHg6kErRAEzSgiimubzceyeiW1JEleDtpzKLAs=;
 b=UO8uAg4m1xBSpFi4htYH8cy3qfSvjrfE9org2poSSQJ74rYAxojcU1mejK8u9b8DqVsW7kuUJ1+78UwUxg+/9PVih7QFqb9NuW2SKXYvueCVX79NUGdRgcdJsUoRJRLLFOhHKpTktVAsTh3elHTSFFlm6yZVdlxrd5OtB4XrgWzBkKiIhVftx4pjL3LUu8bt7bwI9vqNdGQ+q44Q4zGrb/pcnJ6d7QVZtUigpWH5CGhFs1ykTWSBdCJVtCY2hxNdCEeDM6KN588PgUwCClz0LVeAZefRpB3IFO3bB0BeM9cNosuG0SvVPxaRniRYzfiTc39jfLzVUyxjiaoxI7EKdA==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by JH0PR01MB5560.apcprd01.prod.exchangelabs.com
 (2603:1096:990:17::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 15:24:54 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::3641:305b:41e2:6094]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::3641:305b:41e2:6094%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 15:24:54 +0000
From: Ziyang Huang <hzyitc@outlook.com>
To: andrew@lunn.ch
Cc: olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	rmk+kernel@armlinux.org.uk,
	javier.carrasco.cruz@gmail.com,
	hzyitc@outlook.com,
	john@phrozen.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] net: dsa: qca8k: support internal-PHY-to-PHY CPU link
Date: Mon,  3 Mar 2025 23:24:34 +0800
Message-ID:
 <TYZPR01MB5556CE5DD202A8F5FBFBB6ECC9C92@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <TYZPR01MB555632DC209AA69996309B58C9C92@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
References: <TYZPR01MB555632DC209AA69996309B58C9C92@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR01CA0094.apcprd01.prod.exchangelabs.com
 (2603:1096:990:58::19) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID: <20250303152435.6717-1-hzyitc@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|JH0PR01MB5560:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d6190d9-b627-4de0-0e9c-08dd5a678c25
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|15080799006|8060799006|461199028|440099028|3412199025|41001999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?14HVJWq1jZ8bQbguNxNn1/XR+Iu9lXaSV4PlJuhtP8lqNpZGjfEz5fA6xkq+?=
 =?us-ascii?Q?rikoATsdhHOsD4v2W0WNKlAOKt8FZkPGzLza15rGLFrYVlvZBr4dwI3pD0L9?=
 =?us-ascii?Q?zsbyeglLDWtuJ5JXcge1WYYI3u2XDkPD6xFoArp5rwKHcT6CZyuezs1zlL1+?=
 =?us-ascii?Q?vwM6eRQciO8wmvjzagTAht8PnGt6Rpa+b7TjxXZFvu3CWfoHTIVJR1nU4Por?=
 =?us-ascii?Q?i/TP27X9AmlV49ZuYzfNbmoy+E1cJDoqW3a8stjj4AVNqEO52H6LqnltoLeZ?=
 =?us-ascii?Q?NdDEpSQvfCFrPPZMHb9MZG+n6Yab/xN6ypAkModI8n5NUDPoDNI2d2RND1F1?=
 =?us-ascii?Q?nCEN/mIVip6/loM2dkl3ahnIDUcxHSDVg8O5cpSK3dvYifjQoU7sdlroi3vW?=
 =?us-ascii?Q?nYQqTrOVvORjzBuy4bi79dQE2NUJr7w9wbg+MyhhpKcfEXFRY9vNZIEHpz+x?=
 =?us-ascii?Q?9LlXJ58qmcCRoFAQgkvoPB5iOiHJTAWu3cXlTU6W23QEqA7qhMwbXov0mhf8?=
 =?us-ascii?Q?Bg76aUj1dVpa7lMTbnd/D6Vp91nlO8+UbBaS26C9Sx+tJZdQHm6b+dlOmuWk?=
 =?us-ascii?Q?aqNM8VF91YK0lJbt68Ck0zBk2fYBUrgpQ/cSaS0w4Fyc4rbcyD0KF/7jAg0b?=
 =?us-ascii?Q?L6K6CWgGPSZXY5OWCrsXcP2BAfBRID+lJzA2z2NtzVzXCfIWM1qDyQTrljGi?=
 =?us-ascii?Q?hon9lzrYMhvP14xUhLbY8/qPELLbXBK6ugKf9GYlVP2nQvPLbnXDY8cmFWwO?=
 =?us-ascii?Q?JiKoY8pdA0SpJ6H5dRgl/QQOmgQvpdw5ry2ck0Qmpuz11TSvSJPC+LE0+gma?=
 =?us-ascii?Q?sgfoEp7drhZkPcx2zeF2NxeqfPJyAhT9Mg1v2K8bBHmTdazSDfH4sEqgd6fQ?=
 =?us-ascii?Q?bGG01S9SzNgvzXBpxgjRRuHIGfqH/5951l5trAvw6h0v3eP80rS7jK9cKnd/?=
 =?us-ascii?Q?SkBVLgwZgTACYAp1zt0WAvxafZAVWMhI7Z5g64ffSbxbbNp/FwsThhOQRLrU?=
 =?us-ascii?Q?r9rFn9wBgenOiDlUNcyncydCbUCUdOWiRoVmAb5KsRxCA3uxF0Sil4tgokO7?=
 =?us-ascii?Q?PbHcNkM6iGWQvOEdSDl1ndLzd2DHHy+86pd3ATgBnNFlFRuX9uA=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aLZLgCZ1nM0rkceMDAG7syPOfe/odKcfdTJ4A9oek7iMq38/vDaP4ykhDP1g?=
 =?us-ascii?Q?cIOTCvC3tW0rOgjp1WbwlLHuhKa9ezJ4kinTzjk8TGJVqtG5zAU2C/1x+ZlT?=
 =?us-ascii?Q?HbzUbuj49IQDxiujVVjBSzdwLI6Ht33Xlo+BmT1uqVzARs7ZgW6mvOe8PcC0?=
 =?us-ascii?Q?nf0o4fYcNYBhxj5sD3hLW0qKQ5JXNCBt+xELKFaVaxnCAnT7gS4MIemBXUn6?=
 =?us-ascii?Q?bdyMlvtVOzIQ02zjYA7zpvthhtbDc6ElUhulZ2ic/vkntfDfh6Pf4h6cM24Y?=
 =?us-ascii?Q?zq23xNOr+Me2Hi/71XLZXEBKq5O67DERSe0b1Q9IqGVQn6ngGs8Mpu0mJt7W?=
 =?us-ascii?Q?Shk1sQmAWfm5mBn0OOa94WEovCYX69WIYV9nxAKs+LsV2yjRtSl/ZrHPWPli?=
 =?us-ascii?Q?tfmSG6aBKTRMVx9S/84f9ij8Z063rTTHygxyMTsqKTtNx1Ol68KLxlsnDEMW?=
 =?us-ascii?Q?yKCBGQoZQbotuenp0a5U6RFvBS2Rs0RSCEWqrW1EIYTyEdfMjnNcUdYAT8et?=
 =?us-ascii?Q?fyYfc8n5p9zjlx/+tFj9VXVebnoFydzvWrtsr+b9JhwE0jiPGcHvKjSOd1ym?=
 =?us-ascii?Q?+1qHAaNvL4N5b4FRh5s9JnkluXyCN6jc6B+q+u/tHlm4PrnM6bx6+H/0+ily?=
 =?us-ascii?Q?5w0e6mVPXhwdd4S4c0Tccx3WsGTA6qbZsbLH+brBDEYWkrIMx7Ruq1AXK1G7?=
 =?us-ascii?Q?+LHSTWeNW9cFaAmzEH/ZbOT94NbCMxlJ4q1YlBEVwjbe/VUbmC+SfbF7Voqu?=
 =?us-ascii?Q?aQ3sbzpl3xqhraMSlakNAxv/ytajm5TbeX30VKTecyP/q0Q6UGf+2YgefHSi?=
 =?us-ascii?Q?OEjKshMGFNQvxiXzMMhEPjVbDyTARoYqrWOy6uSstQt587t80FB3qZ8CueFc?=
 =?us-ascii?Q?rjzB8qQi/DzLxWOeoHkkvdwuVx586gBG84dB40vPcVPANVwxFOUVQeq41SpS?=
 =?us-ascii?Q?lmc62mDH4GGDlQVLqtyPevq/hCkrz1AfNTsHXdc3ld354Wt8xIv0PIpWbOoh?=
 =?us-ascii?Q?ev0TVg5PcEyudjJ1NK+htZejuC8+33BqHggk6qeXVVlwRfhKf7sjpszUJybe?=
 =?us-ascii?Q?PuF1Y7iHlOmnfAWyW+vY3sC1fPTHqkPeZQSI4y+uAyFz56GYCCJs/XCFRbdV?=
 =?us-ascii?Q?ltN3fIAqDA5V2Z7eY+rLPJUA1VoRNu1lugaE7ynt64svGgYLhQ5jj5U+56J1?=
 =?us-ascii?Q?dP8T3Ezsn9qKsouoBjIjwr6zcSrsDzeN7xETsIC4BcgWewIgluLopp8NpFY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6190d9-b627-4de0-0e9c-08dd5a678c25
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 15:24:53.8578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR01MB5560

internal-PHY-to-PHY CPU link is a common/demo design in IPQ50xx platform,
since it only has a SGMII/SGMII+ link and a MDI link.

For DSA, CPU tag is the only requirement. Fortunately, qca8337 can enable
it on any port. So it's ok to trust a internal-PHY-to-PHY link as a CPU
link.

Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index e8cb4da15dbe..be9a8170c048 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -1014,7 +1014,7 @@ qca8k_setup_mdio_bus(struct qca8k_priv *priv)
 			return ret;
 		}
 
-		if (!dsa_is_user_port(priv->ds, reg))
+		if (reg == 0 || reg == 6)
 			continue;
 
 		of_get_phy_mode(port, &mode);
@@ -1089,17 +1089,19 @@ qca8k_setup_mac_pwr_sel(struct qca8k_priv *priv)
 
 static int qca8k_find_cpu_port(struct dsa_switch *ds)
 {
-	struct qca8k_priv *priv = ds->priv;
+	int i;
 
-	/* Find the connected cpu port. Valid port are 0 or 6 */
 	if (dsa_is_cpu_port(ds, 0))
 		return 0;
 
-	dev_dbg(priv->dev, "port 0 is not the CPU port. Checking port 6");
-
 	if (dsa_is_cpu_port(ds, 6))
 		return 6;
 
+	/* PHY-to-PHY link */
+	for (i = 1; i <= 5; i++)
+		if (dsa_is_cpu_port(ds, i))
+			return i;
+
 	return -EINVAL;
 }
 
-- 
2.40.1


