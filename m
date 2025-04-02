Return-Path: <netdev+bounces-178833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C24A791DF
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 17:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 612127A3428
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 15:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50FC23C8A0;
	Wed,  2 Apr 2025 15:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BvTUfeAd"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012060.outbound.protection.outlook.com [52.101.71.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C7A23BD15
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743606572; cv=fail; b=I1MBG0WjV7/UNB9xZrPOFxDkZVRonLkNUPpDnM4g7latRrJSCuRObhkOigc1uJaTpHVd93g64JfdXnoFmxmRvJV71K+OoK5jdWrxpJVCPnkF8vxHOSF6ZEp9PJ04CAsNfTLCWNlFpEd9aT9fAh2A3LbS8CexMxNiEy1gJx/bDL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743606572; c=relaxed/simple;
	bh=WiaE7LpmtzG+iBM7QVjXtmGT19I91ij4/UmIpdLFLwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uh7Ws2+DklJ308wh5+JPt9V91XvBnrnsCxldSZBmRGL6BkFGB2m4KD7BEpxWTUwRtVxHlaWkTJq9hLYVuBwmY0G64Zj7kT7/S6UpKefY8UqUHgbg4XyeSGFa6SYQ189UdyEANQ51JxrHHuAOUtDsOJ2Y6MgIaVbvQ9dEeFRtF/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BvTUfeAd; arc=fail smtp.client-ip=52.101.71.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=beiJZRgjSIyH4etS8wMpg8wHyyly7iwdS+IuTDjiG33cBB1p4Z/5QiSSWR8kT8JUyWZQ1d47IiqPGBMiCaYjE8n+zRgsVxRB2sveQH9Ks4Nr5IGT+gjkw/wVbEG8njqnNDC6ptBhFc6zVS6R2INxLnXi13U3vaAVbeftYolPOHKH9wX2vYszoZyU93gnc3f+D1ZfOm4AtuOGeOD3P/kU8+CnnBdgSyT1hwINDB+/zRvEha/HtGgcNjhx2WgP8V2fgts/KhHqeRiK5Ksej6qKxy8TcYkaai13IPuyvj9nqcA2RlR1xUN5nxCgvNKlWVbwNh0tmCQo60k/3tzZ8R7urg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jhzlzi26q2yyEkizHqStRElEjlzKox2nMIbHPSYcAc=;
 b=T2ir3ywfEEiy3/53hnIQWlUD4DnHRRMY3uWAiQPfv2heoMZCsIO17PT9idnN4hbZmVjXjvyt/NWeTMA228/D4y0qYDK4F3HMRTMDzCIG/soASeLZH2jg/i6M5qw4WjyRc7e7hBZAJ0aAs5CrSKwajZPlg7pnHg4HtToYLdF1Xaj/c4zPy8yy50WLJ6JF3HrED2y3G6mPsHt2rg/YBwBW+LOfz32xQ+tDknNsb820nnFh1TVkFLMwbxDau+BUWiZJDEZ49ZXHjCCu9IAIwVootqarzWYxjtnwwCjhK5OhsZAq6Xxt27bdtpFFRiJuVWAwxODgIfE8/safxPp0VN9G0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jhzlzi26q2yyEkizHqStRElEjlzKox2nMIbHPSYcAc=;
 b=BvTUfeAdJGACnyWmpotUoenzMO1OaykLe4AzZib0Dnn12hF6p5ASCKKtG5eu5dCvn0j2UF7T/quuY0Wkwx15dRY7/I4J8yxXAgQyFHjxNaMmcgUsa0nHQRs3DprbWMQ1O23+RhoQsu8GN8/aX0XCWGsKvsTEyL2lnWHTskpMyit0eHWrR7EvjXDZrSF5HgnMvSoSV9joloaneUVHxLcgYi2FeiMd7IiCJqQE9DMH2F2jZab+z4yF4FCbQnUrVoZvmNeOQ9tujxGbkn78wAJ6A0G4dOwG9F2bY4qQSBqRXMtgg5gImNZWV4olD4DGw23SGlHrVWhObFtZy/Q1SlQLcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DBBPR04MB7609.eurprd04.prod.outlook.com (2603:10a6:10:1f7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Wed, 2 Apr
 2025 15:09:26 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8534.048; Wed, 2 Apr 2025
 15:09:26 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Wei Fang <wei.fang@nxp.com>
Subject: [PATCH v2 net 2/2] net: phy: allow MDIO bus PM ops to start/stop state machine for phylink-controlled PHY
Date: Wed,  2 Apr 2025 18:08:59 +0300
Message-ID: <20250402150859.1365568-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250402150859.1365568-1-vladimir.oltean@nxp.com>
References: <20250402150859.1365568-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0131.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::24) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DBBPR04MB7609:EE_
X-MS-Office365-Filtering-Correlation-Id: b4db098b-b79c-49fc-244c-08dd71f85b96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ng+wm0urZJg2UmuzVqpIIuKZmxtqwZ2Sbbab0TzhV8WEnqQqw57qilqFM+eA?=
 =?us-ascii?Q?hNJkCWJkW8VawCIHa3TNM8wEYQ7YMukr5PZU7F9KVxnIUJz7atD/7jcJLkmf?=
 =?us-ascii?Q?xnioD/Y3HPlgZ/pYGuT5RLWnBV3ToNPYzE2cGZHToUoPBqRcYd7Sk8Tfo4BI?=
 =?us-ascii?Q?RPSk/7VD1PHI8N07LxBD3xIGH5X+yRnJ2yneLSIz1cGDOy6wM6X3wH0PW68Y?=
 =?us-ascii?Q?63C0KFVlyjs/IlURvI0Qx8RqOUr6FLqmaK0UtRVSUQRJxq5vfj+01wvO6PiJ?=
 =?us-ascii?Q?tIy8ZFtUhkigNWg7NUDl89T29Zrq+fZgmzeonTswDtQeFiuivH3EgYqV2FHP?=
 =?us-ascii?Q?MmvUcHud2J54Cb5Lx4eh4nmOLkky6I91ATHqc1M03Ug2AA2MBbpDVKNSQjKO?=
 =?us-ascii?Q?tuBhj599tDyzUohWaL4oEDkH4izachI1Z9oAvT9PpcrhmAUNJ3/FR4zex7x2?=
 =?us-ascii?Q?giIPUrJ0tvvhki7niY73a2EzvtJr8m5YcQvLA/zNsT4Id4VWVdLhhPDaDY3d?=
 =?us-ascii?Q?FHYReMwEVdp1QVFWOuWg8ND+t+IdKP7oMH9yVS6cImjPPs+d+OXLvmLlfMDu?=
 =?us-ascii?Q?k0As3/Dj/6Dd1szLPDQ3daUIe3h1wL6omy+Oj/fIRWzuxc1ID2G35cLw2Tei?=
 =?us-ascii?Q?/Qp0yGnIDuU3W+zuSl3kUFzQ/9q2ouZDPRFyGQO+uQ3ImHQvogf5bLWkthoV?=
 =?us-ascii?Q?f4v/4a4Jz5h6J2YpYGTL9E9OwXj8V3GiBzXJ+w3t7Rcr4B5/mN5hl29e9l2a?=
 =?us-ascii?Q?UI8EKsoHtVmXBEx//iz0q7KTUaOSAJlDGoZbYwcRW40xYFyv9e8IYOk4tsOj?=
 =?us-ascii?Q?f6mJaAO2QlU+Rps0luXifkA2tCgL310NBOIqKZMwHBAXLCa4q8peAOGZTnGl?=
 =?us-ascii?Q?Bpwff5qGvuuULPhdNTbdu2WMDx7B+6zsDixHye22A5G5UsTIqcQQBcEGsHnc?=
 =?us-ascii?Q?+w5ToY0YVERehaTvqyAmwchkrlRHLgjnfR3zbJ6ru02aqWjXXqXXU9IKeiH0?=
 =?us-ascii?Q?HtAz3WEGXAQDxZwXIsRZiqFuFFnvtquP7IFnislR2MgIGQc+aL4Lx/SN7PR0?=
 =?us-ascii?Q?9H8BlfpIOvFCsMVkf0WwH1gpDDl2YO5DHQUequdLfdBOaps4aJAt6wmIP3w3?=
 =?us-ascii?Q?D4kClKcaIqskBVWQVUrBo5u725Iwq5Y/nCzDCM6G4n1jMLGT1HQxUMfbNyuE?=
 =?us-ascii?Q?yc6osaGbAxQB3Pb0BOkyUzqXrENaOZpBLUtgPDPyoudJWzRjAmoP9rSQ6YH0?=
 =?us-ascii?Q?S3pj8nVQcQxvkMo2GDd7RJ3HDVfBBkErwDNlaG8HG6gEk0hkYcx3JmjfkXIz?=
 =?us-ascii?Q?B/FM849FtR+GjyikVl0ecw0hJfu4xURTmZRBKPcvg2aGkazBjZcmDY/8WF08?=
 =?us-ascii?Q?ozsUpkNoLsDCdI/IDJ0vommhjemXDo1b/7NKR82jXCLdWdCvBOV1uRhs+nDb?=
 =?us-ascii?Q?bhxW/7lwR4pq+yGbZPQDxfq1SfVv+xSb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1D8SspNt2pLMWuEZQtD/PpmrQYwJKPjPlf55w9SXNohZ8QvIF5VZKoicMuSm?=
 =?us-ascii?Q?+hweCbBKH7OokJXrCg37ICSX4ZAxH/hpVIUgzxGbI4bQmj5Of6OB3EJNNm6b?=
 =?us-ascii?Q?uLy6Kc52KETDHV1X9vu4xIhfBXfXNWWPhQ+N+MvNZp9TMANK7T+F1lheaQI3?=
 =?us-ascii?Q?h8ypXbOrfFpF5us4LQLQZyyLTn5z0uWu00GRxxMIVrHPtogXgm/0i1485lTa?=
 =?us-ascii?Q?iXS18ImmPlUfGKDPpIBf3yvwz00ngn78D4HRxhcFmy5mKoymEy42rSjWhini?=
 =?us-ascii?Q?pY2QJvX2LTNOa43omJgNkW/WXhdaUbA4VbtUKhypXo/nhrcFlrCrmzh6pLK8?=
 =?us-ascii?Q?wq89Mhs3jQw8WZFyfHFHTaFUvqKaK9Z/YwWI3JIn7KeJs1NMi6DnWXAm6p4H?=
 =?us-ascii?Q?oZM23PrlU6P6InriJHPAZ3oseTgac2n6GKPvgNjM02EiHj6L/0mXYhpNSanr?=
 =?us-ascii?Q?0jZVAEJyV+Wqs1269PCDsoAxRv74+LG34qoDq/7Ymjetqz5kF4eXf1D/3E8p?=
 =?us-ascii?Q?GRU4ThFUrRWNpuar5aIbklH3EvMVXK2u8xbznKWYZJD6tSAb1sLXLLIyDdA+?=
 =?us-ascii?Q?kk90g4Ztplpb4LEKUDjI9MXC7HGF27UVo/E65OZ+mdPOKQLX8DBuBs3rN/b3?=
 =?us-ascii?Q?Nuf9Z8llFRzyDCtp7GcKdY5O5/Y7vgBucXdoH03joAtbc0dqi1e+tp03bt21?=
 =?us-ascii?Q?6r+TjceqZCv47BuiRrAWEtOwln0xq4byKYqndLDU5QsDDsd/y2ZkvM9/YihZ?=
 =?us-ascii?Q?g/AO1lC9F5gAj0Ye2ShQVPF31B+mE+CBlLuUUmmr+imiCs5qfcvs96/NKhMb?=
 =?us-ascii?Q?pkjov7QBkTmXr/iAtred7YWbXkBhTnkAeUXKLJjMX3H+F8mO65bcEwqlp2yG?=
 =?us-ascii?Q?Pl+OOJGohfM0oZZk/hTTh0T11+lpPhMQmsWefuL21DWV9GAvYvE5JRAVYJ6N?=
 =?us-ascii?Q?v/ZIiTW7FCjJqTfal6+j/j6ms16OGbfRFzLSIsCVC0pkyvPlTCWh2Wu2ZNS1?=
 =?us-ascii?Q?+abyIx/tkbg0rLGGsdrUnz1oiFSyGZjBC/36YEdGU+GPkywu+32RkDIME7wZ?=
 =?us-ascii?Q?S5LDC9vKc2EyIaL39U1Q3iioGXRaf6rIqmHLhxXZSm8lB/aOxo/ss5zkBIKO?=
 =?us-ascii?Q?02dHs1FD3h3OVuhjuZr3y8nV4pACU8BQLjVQqjfqi4CAgk40x3hTL6U4qnSH?=
 =?us-ascii?Q?K+Pi8hmv2M1TAiSvLSg6fbLn+jHhbwuEmCIxcTwLoDBX6pWwmpNth/8xAwpb?=
 =?us-ascii?Q?04cIwRqRQ/onilqYlIkCkKcZI5xdaygXeoFxfBT5inJRj9lCMCc4tYteUiOa?=
 =?us-ascii?Q?5RjioYroT8FwFc10C99eAeWmfCZ4WUho3U8e1CsHr1Ot/RfXKw4yk28DDRs/?=
 =?us-ascii?Q?+/H95Lsa6Ab1xWnU4yXVoMYfNsv1riDf+jjyj/NJBqIGSAB4qJWksXwusxnC?=
 =?us-ascii?Q?ePBn99XU3HxDslOX4egg6iCi8W9y170+gy4HnH5UoKQRNTAyy5rMYJlcOjDJ?=
 =?us-ascii?Q?+/XQGmclPJa6SpBIoxRAwIs3QrWB1tHCx7zFL04/lmFWsBdPHPBiDA4SoU0j?=
 =?us-ascii?Q?TXbS4KAvZF/bPXKbGIIbeKwuJ4L6uB8HnH5ZrNDe8gQr2X61mdlnSWX/1fYn?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4db098b-b79c-49fc-244c-08dd71f85b96
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 15:09:26.1325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FTD159jgjFwSTd2Ps/tac+yxbVjMxb9fVPnftQTy8DyrfnrHXu3pbxx8BQxenEuh3zjg692js9tXGGMmTRD53A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7609

DSA has 2 kinds of drivers:

1. Those who call dsa_switch_suspend() and dsa_switch_resume() from
   their device PM ops: qca8k-8xxx, bcm_sf2, microchip ksz
2. Those who don't: all others. The above methods should be optional.

For type 1, dsa_switch_suspend() calls dsa_user_suspend() -> phylink_stop(),
and dsa_switch_resume() calls dsa_user_resume() -> phylink_start().
These seem good candidates for setting mac_managed_pm = true because
that is essentially its definition, but that does not seem to be the
biggest problem for now, and is not what this change focuses on.

Talking strictly about the 2nd category of drivers here, I have noticed
that these also trigger the

	WARN_ON(phydev->state != PHY_HALTED && phydev->state != PHY_READY &&
		phydev->state != PHY_UP);

from mdio_bus_phy_resume(), because the PHY state machine is running.

It's running as a result of a previous dsa_user_open() -> ... ->
phylink_start() -> phy_start(), and AFAICS, mdio_bus_phy_suspend() was
supposed to have called phy_stop_machine(), but it didn't. So this is
why the PHY is in state PHY_NOLINK by the time mdio_bus_phy_resume()
runs.

mdio_bus_phy_suspend() did not call phy_stop_machine() because for
phylink, the phydev->adjust_link function pointer is NULL. This seems a
technicality introduced by commit fddd91016d16 ("phylib: fix PAL state
machine restart on resume"). That commit was written before phylink
existed, and was intended to avoid crashing with consumer drivers which
don't use the PHY state machine - phylink does.

Make the conditions dependent on the PHY device having a
phydev->phy_link_change() implementation equal to the default
phy_link_change() provided by phylib. Otherwise, just check that the
custom phydev->phy_link_change() has been provided and is non-NULL.
Phylink provides phylink_phy_change().

Thus, we will stop the state machine even for phylink-controlled PHYs
when using the MDIO bus PM ops.

Fixes: 744d23c71af3 ("net: phy: Warn about incorrect mdio_bus_phy_resume() state")
Reported-by: Wei Fang <wei.fang@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2:
- code movement split out
- rename phy_has_attached_dev() to phy_uses_state_machine(), provide
  kernel-doc

v1 at:
https://lore.kernel.org/netdev/20250225153156.3589072-1-vladimir.oltean@nxp.com/

 drivers/net/phy/phy_device.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index bd1aa58720a5..b01123a24283 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -256,6 +256,32 @@ static void phy_link_change(struct phy_device *phydev, bool up)
 		phydev->mii_ts->link_state(phydev->mii_ts, phydev);
 }
 
+/**
+ * phy_uses_state_machine - test whether consumer driver uses PAL state machine
+ * @phydev: the target PHY device structure
+ *
+ * Ultimately, this aims to indirectly determine whether the PHY is attached
+ * to a consumer which uses the state machine by calling phy_start() and
+ * phy_stop().
+ *
+ * When the PHY driver consumer uses phylib, it must have previously called
+ * phy_connect_direct() or one of its derivatives, so that phy_prepare_link()
+ * has set up a hook for monitoring state changes.
+ *
+ * When the PHY driver is used by the MAC driver consumer through phylink (the
+ * only other provider of a phy_link_change() method), using the PHY state
+ * machine is not optional.
+ *
+ * Return: true if consumer calls phy_start() and phy_stop(), false otherwise.
+ */
+static bool phy_uses_state_machine(struct phy_device *phydev)
+{
+	if (phydev->phy_link_change == phy_link_change)
+		return phydev->attached_dev && phydev->adjust_link;
+
+	return phydev->phy_link_change;
+}
+
 static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
 {
 	struct device_driver *drv = phydev->mdio.dev.driver;
@@ -322,7 +348,7 @@ static __maybe_unused int mdio_bus_phy_suspend(struct device *dev)
 	 * may call phy routines that try to grab the same lock, and that may
 	 * lead to a deadlock.
 	 */
-	if (phydev->attached_dev && phydev->adjust_link)
+	if (phy_uses_state_machine(phydev))
 		phy_stop_machine(phydev);
 
 	if (!mdio_bus_phy_may_suspend(phydev))
@@ -376,7 +402,7 @@ static __maybe_unused int mdio_bus_phy_resume(struct device *dev)
 		}
 	}
 
-	if (phydev->attached_dev && phydev->adjust_link)
+	if (phy_uses_state_machine(phydev))
 		phy_start_machine(phydev);
 
 	return 0;
-- 
2.43.0


