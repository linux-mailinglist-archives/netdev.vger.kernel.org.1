Return-Path: <netdev+bounces-182492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBA8A88DCD
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 23:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8C61899659
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 21:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FFC1A5BAC;
	Mon, 14 Apr 2025 21:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lDvBAr0e"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011052.outbound.protection.outlook.com [52.101.65.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA931CACF3
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 21:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744666151; cv=fail; b=SJavWStcM1LeTgkCC9jVwIwS1gOOvtIdhrKqdH25ErlcrBPNiiDWl8Lqm7aPgTk4YEtgIF4OAepWQOJxGGKPE0EMRwkG4xBiyzPVjrhRXCSrTfvDo8qV1RolVxAOXapIgj4y8iAdWZX+6S9i7Wh91CuSGIOu+DL2X7IV0gYaRAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744666151; c=relaxed/simple;
	bh=vCV+06ZU0zQmbMlxAoa7LqBXhdQ6IHTo/80zGDWLg4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pg9IHbrfmPkMpJT7vdMzTqEcpBSuP+3zdapC7N8H8nC33GZsr0cU6O1qvgqCDGyKCJObPkl/Z94UK9W+dlO0KY8eFRKPcPhEzITPqf1OMhYVC+/9MxSaFKVPSggywOWtAAzWIFCc+WTjTjqYfYmEJCyb8coy2Ykhx2EIHVzPI4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lDvBAr0e; arc=fail smtp.client-ip=52.101.65.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGDxD358CaJdhZogov2IqGOSr9C184NsxVukkijH+e3PuqgcEew3Y2RSQRPtfeMx1YDlODCiQLAavD0Co4dYRnDU8Zi6SyV7WsvZ2APIMD3EZElxR1wWR1KU0cPdCynqPcnTbFfvBMuL94QtoT27lZjlrqBCqj2tmyBamBcC5gEH5T4hyMKnaV3MMWxWY+7LVB+vatvO6FN+9r4vVEjpJCBICw0qIN0RplXPyho4FAdjlJ0EFZhrr6OvuV/RB2YvxSIR7ArTAK7gwTrw2CrPpaVpRpBheYVskf9x0QQ/64xGkG9VLKT1VjeiCncWg8F/072JcOeeS3tLNy/JC/czZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViETTFtcp3xFUEJ2AMsyh+jUPKGCUr7UzpZDJs0Sebw=;
 b=xUZn96wcPvq5N2lbj9GwxJrGKl8FqrKFynCEVJM/kgMe5iZXKoU9bnqdN5fnJUr4cJWESnXHh+FTTrVb8qotl50NNJHrxSCCLLDbv8WQIqeyED/AF8nNdnOv8NZJbVEPA/uFzYRbe2cTupmq3hIrtJ2wwDNgYNNwBygrvQmAuD6T94kPujcARZQ0WXfYC6EPaQmujjS8qZGpALwcXJ0C0ElJW3U/i6vXo4lHgXO/vL6ElY4Vg80We1yBE7hsN5eFcr4sJyCZ0InGQ8dfJL5+g3721qKPtV/kQXw8hwdOs0d+GqLQW7LAbWnTaxZCh5pEukcizdKmlsgQuP5GXDxO4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViETTFtcp3xFUEJ2AMsyh+jUPKGCUr7UzpZDJs0Sebw=;
 b=lDvBAr0e9uHUOec+TR0d+GmNyHgYkpeldoa51aovAjaddX5CGwJ8NxY8NV3LDUqMfZFX8FB+8VdmdhXB0ldeDi1n7I6wK/UkAZ2OCYr68DhfM3zMKDsi444uQu9BIb57xeZsOdT+Wn3FPvBav6xFcKvk09T8ziQZPVOfNaKfASHvMIH1zOb/61xFNrWM8J2pMgQwTlQOkIXvEIqosbViZi/QAaWUk8GT+vHVdt3FAC2cI9qZ8xVckhoNYIJcadhhADAvNMwvAkGmBt3uH1ltTbz0Wt70dGhSnIGSywHWNZXLRPtoexVCMdH00esRE7ocTnMNID67YkmNcQy1967yDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS4PR04MB9506.eurprd04.prod.outlook.com (2603:10a6:20b:4c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 14 Apr
 2025 21:29:06 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8632.035; Mon, 14 Apr 2025
 21:29:06 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@armlinux.org.uk>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH net 1/5] net: dsa: mv88e6xxx: avoid unregistering devlink regions which were never registered
Date: Tue, 15 Apr 2025 00:28:50 +0300
Message-ID: <20250414212850.2953957-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250414212708.2948164-1-vladimir.oltean@nxp.com>
References: <20250414212708.2948164-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0119.eurprd09.prod.outlook.com
 (2603:10a6:803:78::42) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS4PR04MB9506:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d50db3f-f702-43a9-02b9-08dd7b9b62bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mJeIU+bz2uUFy8J1DpnO5AhecreRzRGZygixx8J/u6X3EW8prJ8lbT1AnsCc?=
 =?us-ascii?Q?1thbfmTH27E+RoCNhoJOolZ8B8bqLnUAvQWGSDNCAdiCQP7C+CLbh29Q7gP4?=
 =?us-ascii?Q?XpQeJTBVsqhyrXI3lbqn8Z2B8F0oDxCNWUYwTngGJdA7/7yaQ5+kEaSJs1Q0?=
 =?us-ascii?Q?qHFBxKP3Ge4WRbymOF2Y6gqh1zgx7SPacbrclnaALxtutridMkeeZoq89HNn?=
 =?us-ascii?Q?X/1cRGneAwgQiuzY9Km5j14zFKn8zVaQEqBbK7y73g+VCcis00WhMkHqjmT2?=
 =?us-ascii?Q?Z5gVeTE+HoU0VLRUPiTp6rIe6DpXKy6ShyAmEeFOvT5lXaipnPHWPolzgb2V?=
 =?us-ascii?Q?Rg5N1sZnQ8V0OTCMvMo52o7EeFiDN/8kahopBYJXXXWHN9WcvNfsh/8yt4E+?=
 =?us-ascii?Q?jQcI9kv6GgIO0P7pxphjQNd8z3Xs3j9MZ1DjW45euOyjRgrKfNIj1K+unHkC?=
 =?us-ascii?Q?FAoqQZQXdV5jX4huinrhnJmzcj7m6xOg4V7POFfBXuBHdl0zasaP2wD3FbO4?=
 =?us-ascii?Q?7knufWW5p3BqXRSPPyo7c+syCIMJt1vDuAE8LjhWbNEOn22QHQPH2XaLgNTi?=
 =?us-ascii?Q?bLtDmDW0cstHLtDMIAFhUVWgWkHi8++C9s/7IY0NuoNERIsW+6fjjrOP+ekl?=
 =?us-ascii?Q?rGQQ8ANNSv3h5gh5MLJ4kPRw34c3wWvOUUO1euJSgA/RaIi/RWBEaJ2z45vm?=
 =?us-ascii?Q?nj1H3HBBAdrY6TLylBggnSB19rqa0sXi1orxWzt3+N20JU27gCzWXgjw9/XG?=
 =?us-ascii?Q?iCa5qFc+ICi8MRfHF9GtoJTLCJ9yGguXTQgMkvfK1/5aJDWhM/by2iPqCYW8?=
 =?us-ascii?Q?s5wkBkcgf/l+18EmB19Vzsilx/yM42+7kJul/l/UHRr0MQGVKFw5YEuBCYHE?=
 =?us-ascii?Q?+cd6QU+USY8XwsbFGxRA+PE6XGQEaBDKk1iXWY8hgyQZ2AHPjEw+VjjZBpx9?=
 =?us-ascii?Q?PoY0vtyfnCty5mYKPqW91jz3mA3r5FgTnZTISUPLZ4LcQInaoZRLv+C/mSxV?=
 =?us-ascii?Q?u9H819PBczZOHhv7MLtnbVWenGqt1kj/ySLGuZ3cpQd3iQXUie20L9X48ze/?=
 =?us-ascii?Q?N0R+yTTbQ6qT+krpVfN/BVsIF6JhuYnSWTyfpX7z1RXFrd6KD9wgzjp0Dh5b?=
 =?us-ascii?Q?x/0zPj2EBwFd+g30V4Mvgc4XqXVLyuzekzQDl2NU2/6z9tTxBL5TR59+EpZE?=
 =?us-ascii?Q?KMtsnKBc0Gk/9t/6sSgrsiYTgHGlcY5t0UDrOdG81s10lhw5NsguZ17dIR+N?=
 =?us-ascii?Q?eb5s+1Epx9LayZenFRq+fHjvW+jItrgBmOk+TsklSk5vWPpHBXl9QOHC8mpS?=
 =?us-ascii?Q?h+NmCJsx9w1lAO5XAOoUWmdx/AEcMFosFSD97yGToMVhCuE4Kpt9LleCh5Ic?=
 =?us-ascii?Q?ZYScahkJyTs7lTLTdwIO2/KyMWYyQ4pgiKkSJQLAYg1ZuHpUiukIqP2z8Yii?=
 =?us-ascii?Q?1TEuJl+ZLJNumnwXmEI1vV7avn5FyaoTZ2mnrJGfBzghc5ViVX3Yb8hsycfC?=
 =?us-ascii?Q?lFvaHlZmUPvNUM8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VbdjcrD57gCIhINeotdiJthWukLPAXJbogH6OL5vp4DtglI7MyMuQhBTRe/W?=
 =?us-ascii?Q?lA5E5JvsEJoJ74PY2OCQSVz4VvbG4i0tvMsK2Hmb9pEUFkcCITwTxiXaO6c2?=
 =?us-ascii?Q?5jM4fthVBu2XN3Y/wS/SfAjtSRFRqIjRxa3ROyJQtEGoFcJtoRQ/wgyq0VLR?=
 =?us-ascii?Q?BDPa+IxvkoldL9YaDinyrZCShZf/WTprmcpZ/3hHzf2wM3ueGDyQRQYJJNBN?=
 =?us-ascii?Q?/d3kItMxvBVsI2ozmZvBDVqF3qWZLNrEKcI2P7pnh6pxWZPhbmLxsFRslTvY?=
 =?us-ascii?Q?xG7pWvmHQ6gSM4Ya4X+KHbbZ01X3Tk4h2NhraQkMcr5K0m9r2qG1u8eEH15n?=
 =?us-ascii?Q?SnAVE9H//YpzkeCPjJtP25eyW+qxjQ949ZdPHKvMCVA4vKZfuiFMc7X9Vjj3?=
 =?us-ascii?Q?5tYq7MeNtd70WlRExjBXCzKAz4JPyFsG++T+zFtVjlh8jp14YfeaDXjTAZ9u?=
 =?us-ascii?Q?EM8BSor6sQnjnZ1w/6ppTgy/63H3ZvebsWttpYdfCtJzbyh9jQ2MGrkfPz+K?=
 =?us-ascii?Q?r9l3VeC1E0qVWQ9V0tuXOAMM36/tB526J2aKItMraAuLtUABHWAPyHONcgLa?=
 =?us-ascii?Q?GwPnpLuhvKfw+SeuHg4fcB85LRyktf7GnQPtWHMA51BoRoTEVPdk5j3gOB7v?=
 =?us-ascii?Q?KMnbC/RfitTItY2H09NdrtmGP4vaLNU27IKSn16Hbf4KYktEakmPhcBblScc?=
 =?us-ascii?Q?CNiY+FcdA8s3EmF3gFNZdD2TlonvTG4LL54Y+9RF8GNz6UWaqvIkyZ1VKPg9?=
 =?us-ascii?Q?uZHW+9M5MD84/Cm7b5RWKnUWHSrud2p+ganwLcughZSM6LQDlgQ8vWoOrL3L?=
 =?us-ascii?Q?DUiCuMFP22cPRQ0BqFkW0rKhpBsUsYhPyPqqa6OUfu9Ryy6KD5L8oTJfkwXe?=
 =?us-ascii?Q?TWOg97vIlJJiy6DKTWGHKfSB743kfTio5+Fp2fDF9bxki6pdDvBDwggjwaRa?=
 =?us-ascii?Q?ydWjJnwpeACTPg1rOyYofYDLRq8WZ8EnrvRaXOVkWEepq3woubhe6olDhyWb?=
 =?us-ascii?Q?goPI6fRuiP4BLk2iF7zpL+b/A6Rzt1jiFGm+YrL2SnL7NDqPv7+nwOx+00TP?=
 =?us-ascii?Q?PvcA9ZBASx/tVv1wcbVS2dB2rMFx7txj6PexkeGAX87UN+W4xlEyd4mbCruW?=
 =?us-ascii?Q?8bE0RJh3NSmIlOFwCk8YLN28+JnW+YbkT8mvXYFnoQnoagtSEcbWvTY7tptz?=
 =?us-ascii?Q?6Il+Fu6LfUu2mYzLEa9YPsjdGzf7YbGrGFs2TAVU8SRRSJdzg1abMlKs8KlU?=
 =?us-ascii?Q?YvDFX+c9P5DZJxoIddv95UDNN9suyxbOLKK0GJ7Gc+kF6fbOPjcvlscN8trT?=
 =?us-ascii?Q?PSF6uSmKhtL5+iveIc4wogOtxnXAKkRPPz0S5Pu3Y6X6eY2WX8KAkLA9fcFL?=
 =?us-ascii?Q?qjj+ezE9kOFCJ3+MCPFk1HJODKljIK7+/aGv6gTsQuOJUNN8tif6q1TklCxu?=
 =?us-ascii?Q?oSjWfFO1F3IUXAbx779yY6wUH8NKnq7mCEhBwtm/uqhT8UWNleGvchG1aw2Z?=
 =?us-ascii?Q?1bmrh7HPvmb/Co95HN4QExbI0EOzbfbUcc3MVtw8T7+g1QRWaffeOX8s+zv6?=
 =?us-ascii?Q?LzHw0FO2f4onYcRpZXTwaEUfUGT1gGzMi1Ohep2GJS9/J+J+5ySWHFLoe6Ds?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d50db3f-f702-43a9-02b9-08dd7b9b62bb
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 21:29:06.4935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPf+m+n7jXXKm2xufr+y8bhMwdw95hd6hNEkidXVtTgVox+4qfDC8gM+AMzJPQK/7g/+Z3K6W+ChoKtnBHskcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9506

Russell King reports that a system with mv88e6xxx dereferences a NULL
pointer when unbinding this driver:
https://lore.kernel.org/netdev/Z_lRkMlTJ1KQ0kVX@shell.armlinux.org.uk/

The crash seems to be in devlink_region_destroy(), which is not NULL
tolerant but is given a NULL devlink global region pointer.

At least on some chips, some devlink regions are conditionally registered
since the blamed commit, see mv88e6xxx_setup_devlink_regions_global():

		if (cond && !cond(chip))
			continue;

These are MV88E6XXX_REGION_STU and MV88E6XXX_REGION_PVT. If the chip
does not have an STU or PVT, it should crash like this.

To fix the issue, avoid unregistering those regions which are NULL, i.e.
were skipped at mv88e6xxx_setup_devlink_regions_global() time.

Fixes: 836021a2d0e0 ("net: dsa: mv88e6xxx: Export cross-chip PVT as devlink region")
Tested-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/mv88e6xxx/devlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/devlink.c b/drivers/net/dsa/mv88e6xxx/devlink.c
index 795c8df7b6a7..195460a0a0d4 100644
--- a/drivers/net/dsa/mv88e6xxx/devlink.c
+++ b/drivers/net/dsa/mv88e6xxx/devlink.c
@@ -736,7 +736,8 @@ void mv88e6xxx_teardown_devlink_regions_global(struct dsa_switch *ds)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(mv88e6xxx_regions); i++)
-		dsa_devlink_region_destroy(chip->regions[i]);
+		if (chip->regions[i])
+			dsa_devlink_region_destroy(chip->regions[i]);
 }
 
 void mv88e6xxx_teardown_devlink_regions_port(struct dsa_switch *ds, int port)
-- 
2.43.0


