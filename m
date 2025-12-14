Return-Path: <netdev+bounces-244638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE189CBBEC3
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 19:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED73C3006F47
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 18:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7870830C350;
	Sun, 14 Dec 2025 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="X773NiZ6"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011051.outbound.protection.outlook.com [52.101.70.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D391C84A0
	for <netdev@vger.kernel.org>; Sun, 14 Dec 2025 18:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765736756; cv=fail; b=IBEGLkf+R/S1LtfiahxOo864+C7ma1UnwE9UHYOn9GfufBwlAu66Ra52JHP/sW+iB6ZLo5l5ven9nZ+QcxoUT9UBKrijkDrRHJNJS6M3hPy8CjvAyDpleYa2VihlYC1GwOw+e8z2hHnzaKWsA+/mCREquhTBCfD9pcsKGXTXJaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765736756; c=relaxed/simple;
	bh=TjqQ3STNtu+XGePOraZMuA8OpTNLZVCU7P9ZPmkKLDI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=stjAl35ehwxiBi9ttHq8S4RtXhTLIt3OMO6W7tIJb5h46z5bfrVssa8B4wGheJq3DDXwdvkq/u6bvnloYIIYUM0kULp3Et4Yv7Cp6RkegFPxQQEqtC3GKCK+QMl98XDrRNo0qtiHm328lcN9xLt7qoOA98qSqh1g24fwAde/P8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=X773NiZ6; arc=fail smtp.client-ip=52.101.70.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fTQDMcMIaKp+s+5O6+yyb8g0L5Tn2YlRBsH8+Me8E0qd3aCI1aFPZj2y6/fOgmy271A+6Bf6z9Nq8Fyhg2CFT14HmoMgA6l7LcrZCo8JwtwigV5Zyq4JWMkJhw+ziigTCdFAVi31eS6wZwYPE/NK9rj/bN9cJxfBe1YwbYpGk2v7hJpFtQKZysRkCA6O2KN7ROxh+bY0R3fMuyt0xv+qUeFJPQkfpnJ0KI9t6QdGDugv+RN1lBr+7APlN0h7Ob+JjOYi9h6frRToiIgE1Cyx54JNdtLyvzzj2qrnXztkzToHXPBWQtBVT3HLJKE2W+CX+xVOgcMJ51ahaLuNckBWWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTZU6/8FTN9sHIq57ISWRMtWz1gNPOwt/nNaC/3PeeA=;
 b=Zjpb/gEngquVy+WHeTUs70dMzS4YO2PB5rIEXhfPCu1Lk3y3UNx0q63ZnI5YRSTMe4m8eDpvET4+PK7din0Xucp7i2Xnc6NwGp7ORU73ZHD97ahf3pAuJD7J9lOboJ+VXqhWW2tZZQsabE9nZN6R3wEsDjw+f5+fndqdhzYNvP8JQilTYMS5JRm40lt76yiPOAjw/AI1mzPBQMMzPo0Xadb8z2OEvBcLdKo09zo99wEnTHRXMoGnic56+wXZuTql0+adzNnJLLryiEnc7kFcPORJmuzbv+0FBnGkgMCApzGb0q3rAfWf8w4cGbedk17xsTkFgKIQ/N1urJVkdqN0CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTZU6/8FTN9sHIq57ISWRMtWz1gNPOwt/nNaC/3PeeA=;
 b=X773NiZ6U5BiKxEERAC2wPZDtP+bKtAZ8/szIbd7pucQ4YJULLqVjpVnuhH/WeMc9qiqeUJwSTpihS3jmjJX5WlQBeSwBqx1u/y0XaiuA96w/d70kYPSwRbrW3T7bxQT0J97+WANApFaDWVG7KHX8FfPK0lcloupMtq3lSETM1dob9aR1dwAW7EyNlRo1ezdnBNM3e9eybLp5saKOB+fgWMMVaWjIFPBc9lriEq7JFY+fdDFbUXDqEaUTr+wZZmcaLpwBW64pNLj18BkfAE/zgqDNxApY/OK/cs27PKUSmZuuPDhU5im4xv9UIkZbffTji9oNf5GCdbIlpp3IKDRrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS8PR04MB8038.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Sun, 14 Dec
 2025 18:25:50 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9412.011; Sun, 14 Dec 2025
 18:25:49 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ma Ke <make24@iscas.ac.cn>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH net 1/2] net: dsa: properly keep track of conduit reference
Date: Sun, 14 Dec 2025 20:24:48 +0200
Message-ID: <20251214182449.3900190-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0223.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::44) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS8PR04MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: 763bc0ae-120c-47b2-36d9-08de3b3e3502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|10070799003|1800799024|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YE8NDcm0iANm0Kou0IWA9VuzKyOIBAHkdXythTJyh1u5mMKDqtYusVoOEYcl?=
 =?us-ascii?Q?FyixMSis6l2d85L4igTI79mv7dB/mvQei8OHt4/nsNkNksHIg7/iz+cqYXd/?=
 =?us-ascii?Q?XM4zU8glhchqN5VuLDttc5j2plv3ruLA4bjfS+wtJ5zbLlxT+MJU14eCqVOk?=
 =?us-ascii?Q?P6scCni/bFM6shEVcIsJwN/s2lbq3/TvWRtFXQVn8stVU0ZBKHBYQR4surk5?=
 =?us-ascii?Q?wJq8WlWeA3hwvyBhWFNTvuZlkEedivz7lkKf01flu3gMWgNYMSlYkCkzf1VM?=
 =?us-ascii?Q?mqm0SyjhHe2KMlfoNIiCdsctlrp1RolHliKs4bIOePB17fTsMFBNIP7u4zm3?=
 =?us-ascii?Q?WSrUDog964Uvoz4Gkuo3ejfjpvQhSk6PGKD7I/wxBZKConrP+XQUoWuM7vjB?=
 =?us-ascii?Q?2HIhG58St4rpY8itEuAzz5padnKjjkUbLFqAohSe6NAA/VkTU1fWamSr8p73?=
 =?us-ascii?Q?nYHtu+d7ESvUzyXJrxyFE1jJqIbrDsN7bt7RXf26XOnOp+H1frg0GK6ls0zG?=
 =?us-ascii?Q?raBdHv2PDbaf978gYA6qZFl0oGRmjpIlJe164y2O2CxHcqVoPUYuVYfhzMLs?=
 =?us-ascii?Q?Ho3T7Rr98kO4HHP8l7IN6mUKReOsWVQYC0WTbrRhK3Fj4rj8k9ox4sxO8iUN?=
 =?us-ascii?Q?V1WNgAU/D3jVwLWFHT3d3/QQXKc0Wm807sgsm9HDBglPrppAAgE4KDQgzGrB?=
 =?us-ascii?Q?97NDxXOKP1m78M8phV/SZkzfRTNRV6LPgJeWWFqq/kz8rM+u18WNx/c+JtE0?=
 =?us-ascii?Q?rdVM6HlSPnZlGFUMIxkHWssfQjq7l6umtyRGKGoNf/KQiPdZLrTYXymlShCc?=
 =?us-ascii?Q?XyFk5endqbljx29D1wxiedQUS4QNFrQ0dtwc76XkgAwbx5iKr1KEh6oAHfQm?=
 =?us-ascii?Q?Ngxx0nw6mNW6khbIamd0N3bGUes8lYrnR2OPP7M9c0yLPx+QSkJd/GAYXwUt?=
 =?us-ascii?Q?swbAUvathvv0iUuD3OalvHktCTHr6F8d0DYMmB98hnfUK36fJeaQcn5wv3Ja?=
 =?us-ascii?Q?FfACXgyy+Z0+6wvKSJpKVcpM7A3JwVfaFJHliT1nhOGnmJ0HS9xPOskrHs4F?=
 =?us-ascii?Q?VmdGFCZ0fcgAcbRoCb99D4VnVIKjRaVXZBe6kIE5SkeO5aVr6B0z4UejIRch?=
 =?us-ascii?Q?S6BFl0bdGXhETjLfCzGWmQw+g7albUJ7syu8Vq9p1NSKjklxlhnPVR/T/7Ih?=
 =?us-ascii?Q?nAMJTpFbpWct8lvBF21aVHuCzNEpRXl88R5SX7nfasP2sCvUbC9mgDMpiph4?=
 =?us-ascii?Q?tpMBgDMicP2ZqMCpJWgDJS/fFeZX9g15nmXBvNKqm1ds2jZ5dlT/R2d+p4/i?=
 =?us-ascii?Q?gopMc5nPwR+cuDnm106PJaKA8ejaRjG5Iydsk2lVa8csUjryo4Jw23fTme5r?=
 =?us-ascii?Q?EogcTDY+iSTjsUPdKGWjYNvImVMZNdt3QDF5WFB7uEb1bpcdHWLXcch4JlKq?=
 =?us-ascii?Q?Bxp/IQ7nxTaiYEqRZLbm5Z0gc1KVh5f7NJO+m6WJsT00uBYjAz7wWA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(10070799003)(1800799024)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MrA6R4oQqnnIBEd2VGwM41hdyqbJT2LEGdvMfWZjcj2K2mpQrfDZCjBuubCe?=
 =?us-ascii?Q?1R2TsB4GwtLh2X2JWbFclDt8S84t06E/qZ0QpTnJA64XbYGaQKsQ70gECRby?=
 =?us-ascii?Q?q4Nk4iEI6LMMkKzrtxj6deJk6YpfH+gm6tASW+5x7E1TiXPzFM54posO/JEG?=
 =?us-ascii?Q?nZE4hXziuHkSrJmK7A2mKeh5/fROHrZuomiOg4MRicK152XIspj8YtdOwwtM?=
 =?us-ascii?Q?6+jCppl0Rqn4moUKINh4WhjbtkPwZUwpDQnEF1uULAattTcj2O6AypFWQDR9?=
 =?us-ascii?Q?ZEMpnkZABRNWmIHsORlMuC8LVFvds1CAyzDq7xQci6WiiOTZokUv9gpm/mi2?=
 =?us-ascii?Q?rLVgHyEqe6xWqXKj1w+4O9Pu2kbrUoL6BppAB1cAmRh5mAljaXSrPxruNpoQ?=
 =?us-ascii?Q?t0qhItej+5MgxQ+8IVu/O3MxalTwgMtMRbNPbZaHmEae2CDmQQYhWWdrxGen?=
 =?us-ascii?Q?kz9BfQ6IDD4wvzPTK/jT7DvQMRZIxOE17gqQA0Vl9W1JEyqnSj5acm8lPJRP?=
 =?us-ascii?Q?w6P3PIScpmDBVS73+EhPUmNRDEPcbc6WlqgkMbKm6yRjpLlOSbK+FVTCw2lu?=
 =?us-ascii?Q?Bj3RRRTAckc4zaMH+nTYootPpbjZH4zCU2E6ZPDuYXIX+lcv1W8a7ojUXGFR?=
 =?us-ascii?Q?m1KXkhsA/cOSLHcxaEufLTMnGuwT6BjFauUclFMbAx3omp6m7zHwEo64d7V7?=
 =?us-ascii?Q?qxOF7IgB079zSyok1zKtZcoXgKpe9inNL4kM31GUMiqL9QCg4XIvChId4Fpf?=
 =?us-ascii?Q?Xbk/ZHM6g2ABN6W+H5cAQjkhGCFdMeYcFgItwwCG555hgxgmacZrOdTqm25C?=
 =?us-ascii?Q?N/f1xBl13fIb79YNQ7Rwqtp+ZfZ2wOvsZYso/G5ZEllD4L8jELjsG6OBKYML?=
 =?us-ascii?Q?bVTWOHbxmYqaFoRoaRzLR9wzEhG5Ujav/Wd2hTF/fbGpMzhj0GHLA8zV+xY8?=
 =?us-ascii?Q?DZV3gZZVtPfKhnOdFyWwwwGIZCJzDrj30vu9nCU+DmxNHlbzvfqkhFSkRx+a?=
 =?us-ascii?Q?rLyGcCnbnfOUOStZt064mf6/A2YPAPdSW/PlhJZ7UeukvIZd3fndQEAmyfsr?=
 =?us-ascii?Q?4Pa2ingx8YCWgYyOMSaTNgrDNH+d6DfyZyaSmGqJipFDEDElMuVd2NfZPjin?=
 =?us-ascii?Q?ROaMGzL+ZRFYYfNI+v8TF+wV+eOVGiyINZbhMXFSq77kWQMLyobIr3jtq5kk?=
 =?us-ascii?Q?HMemtW33DrponlMMqKbtUYXtWmozXD0x3PhtuMHI+rC5FTqjYm9J7RS3ssi+?=
 =?us-ascii?Q?M3W8PMrnKdpx0JQo3pD43XzZXxks1c3A2ijrtBhU10rgHhRv23terhdgdxld?=
 =?us-ascii?Q?oI/ku4AgODnb8u+F85SIY7/gb8HCKv2GdfSppKGkZ/FZLNnsjHMoUZUKX5Iw?=
 =?us-ascii?Q?1FDvaHoM0sqBN9Y0N4TbhZUZiUcFbeNI143xZuumZ+BdxXyu2cKxTO7mhbDc?=
 =?us-ascii?Q?J/mxJ3yxKEGpLzhdtf4jepDANOGFT9vafyH6ysBF96FWdckyesnraHrCGc9G?=
 =?us-ascii?Q?i4+UKwtNudsf4p43SRgKdwuQzEAd1GdGRA/uwZctnl0CqyZZfoo/RaDtlDnf?=
 =?us-ascii?Q?aTd3QCpgPxubh2/gT1B0RlMcZqnpURxSFeygXR+NvAQVIEUYBhMd2icmr4TC?=
 =?us-ascii?Q?GvDWbFMN/tsoGc2+lLzZ2oDzdqHa4gpOHIti86d0jCG/XxSe8RsCxO+GHlw+?=
 =?us-ascii?Q?+tMLXg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 763bc0ae-120c-47b2-36d9-08de3b3e3502
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2025 18:25:49.8146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fc/Rr5JNn3+tRzLtGxsHxhXrn5PYAQSswkn+4gUCdDvjG/XSDkQT8bI3qwtddJY29phYpKfgEmGYvtH6UXt56A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8038

Problem description
-------------------

DSA has a mumbo-jumbo of reference handling of the conduit net device
and its kobject which, sadly, is just wrong and doesn't make sense.

There are two distinct problems.

1. The OF path, which uses of_find_net_device_by_node(), never releases
   the elevated refcount on the conduit's kobject. Nominally, the OF and
   non-OF paths should have identical code paths, and it is already
   suspicious that dsa_dev_to_net_device() has a put_device() call which
   is missing in dsa_port_parse_of(), but we can actually even verify
   that an issue exists. With CONFIG_DEBUG_KOBJECT_RELEASE=y, if we run
   this command "before" and "after" applying this patch:

(unbind the conduit driver for net device eno2)
echo 0000:00:00.2 > /sys/bus/pci/drivers/fsl_enetc/unbind

we see these lines in the output diff which appear only with the patch
applied:

kobject: 'eno2' (ffff002009a3a6b8): kobject_release, parent 0000000000000000 (delayed 1000)
kobject: '109' (ffff0020099d59a0): kobject_release, parent 0000000000000000 (delayed 1000)

2. After we find the conduit interface one way (OF) or another (non-OF),
   it can get unregistered at any time, and DSA remains with a long-lived,
   but in this case stale, cpu_dp->conduit pointer. Holding the net
   device's underlying kobject isn't actually of much help, it just
   prevents it from being freed (but we never need that kobject
   directly). What helps us to prevent the net device from being
   unregistered is the parallel netdev reference mechanism (dev_hold()
   and dev_put()).

Actually we actually use that netdev tracker mechanism implicitly on
user ports since commit 2f1e8ea726e9 ("net: dsa: link interfaces with
the DSA master to get rid of lockdep warnings"), via netdev_upper_dev_link().
But time still passes at DSA switch probe time between the initial
of_find_net_device_by_node() code and the user port creation time, time
during which the conduit could unregister itself and DSA wouldn't know
about it.

So we have to run of_find_net_device_by_node() under rtnl_lock() to
prevent that from happening, and release the lock only with the netdev
tracker having acquired the reference.

Do we need to keep the reference until dsa_unregister_switch() /
dsa_switch_shutdown()?
1: Maybe yes. A switch device will still be registered even if all user
   ports failed to probe, see commit 86f8b1c01a0a ("net: dsa: Do not
   make user port errors fatal"), and the cpu_dp->conduit pointers
   remain valid.  I haven't audited all call paths to see whether they
   will actually use the conduit in lack of any user port, but if they
   do, it seems safer to not rely on user ports for that reference.
2. Definitely yes. We support changing the conduit which a user port is
   associated to, and we can get into a situation where we've moved all
   user ports away from a conduit, thus no longer hold any reference to
   it via the net device tracker. But we shouldn't let it go nonetheless
   - see the next change in relation to dsa_tree_find_first_conduit()
   and LAG conduits which disappear.
   We have to be prepared to return to the physical conduit, so the CPU
   port must explicitly keep another reference to it. This is also to
   say: the user ports and their CPU ports may not always keep a
   reference to the same conduit net device, and both are needed.

As for the conduit's kobject for the /sys/class/net/ entry, we don't
care about it, we can release it as soon as we hold the net device
object itself.

History and blame attribution
-----------------------------

The code has been refactored so many times, it is very difficult to
follow and properly attribute a blame, but I'll try to make a short
history which I hope to be correct.

We have two distinct probing paths:
- one for OF, introduced in 2016 in commit 83c0afaec7b7 ("net: dsa: Add
  new binding implementation")
- one for non-OF, introduced in 2017 in commit 71e0bbde0d88 ("net: dsa:
  Add support for platform data")

These are both complete rewrites of the original probing paths (which
used struct dsa_switch_driver and other weird stuff, instead of regular
devices on their respective buses for register access, like MDIO, SPI,
I2C etc):
- one for OF, introduced in 2013 in commit 5e95329b701c ("dsa: add
  device tree bindings to register DSA switches")
- one for non-OF, introduced in 2015 in commit 91da11f870f0 ("net:
  Distributed Switch Architecture protocol support")

except for tiny bits and pieces like dsa_dev_to_net_device() which were
seemingly carried over since the original commit, and used to this day.

The point is that the original probing paths received a fix in 2015 in
the form of commit 679fb46c5785 ("net: dsa: Add missing master netdev
dev_put() calls"), but the fix never made it into the "new" (dsa2)
probing paths that can still be traced to today, and the fixed probing
path was later deleted in 2019 in commit 93e86b3bc842 ("net: dsa: Remove
legacy probing support").

That is to say, the new probing paths were never quite correct in this
area.

The existence of the legacy probing support which was deleted in 2019
explains why dsa_dev_to_net_device() returns a conduit with elevated
refcount (because it was supposed to be released during
dsa_remove_dst()). After the removal of the legacy code, the only user
of dsa_dev_to_net_device() calls dev_put(conduit) immediately after this
function returns. This pattern makes no sense today, and can only be
interpreted historically to understand why dev_hold() was there in the
first place.

Change details
--------------

Today we have a better netdev tracking infrastructure which we should
use. It belongs in common code (dsa_port_parse_cpu()), which shows that
the OF and non-OF code paths aren't actually so different.

When dsa_port_parse_cpu() or any subsequent function during setup fails,
dsa_switch_release_ports() will be called. However, dsa_port_parse_cpu()
may fail prior to us assigning cpu_dp->conduit and bumping the reference.
So we have to test for the conduit being NULL prior to calling
netdev_put().

There have still been so many transformations to the code since the
blamed commits (rename master -> conduit, commit 0650bf52b31f ("net:
dsa: be compatible with masters which unregister on shutdown")), that it
only makes sense to fix the code using the best methods available today
and see how it can be backported to stable later. I suspect the fix
cannot even be backported to kernels which lack dsa_switch_shutdown(),
and I suspect this is also maybe why the long-lived conduit reference
didn't make it into the new DSA probing paths at the time (problems
during shutdown).

Because dsa_dev_to_net_device() has a single call site and has to be
changed anyway, the logic was just absorbed into the non-OF
dsa_port_parse().

Tested on the ocelot/felix switch and on dsa_loop, both on the NXP
LS1028A with CONFIG_DEBUG_KOBJECT_RELEASE=y.

Reported-by: Ma Ke <make24@iscas.ac.cn>
Closes: https://lore.kernel.org/netdev/20251214131204.4684-1-make24@iscas.ac.cn/
Fixes: 83c0afaec7b7 ("net: dsa: Add new binding implementation")
Fixes: 71e0bbde0d88 ("net: dsa: Add support for platform data")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 include/net/dsa.h |  1 +
 net/dsa/dsa.c     | 53 +++++++++++++++++++++++++----------------------
 2 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index cced1a866757..6b2b5ed64ea4 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -302,6 +302,7 @@ struct dsa_port {
 	struct devlink_port	devlink_port;
 	struct phylink		*pl;
 	struct phylink_config	pl_config;
+	netdevice_tracker	conduit_tracker;
 	struct dsa_lag		*lag;
 	struct net_device	*hsr_dev;
 
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index a20efabe778f..ac7900113d2b 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -1221,6 +1221,7 @@ static int dsa_port_parse_cpu(struct dsa_port *dp, struct net_device *conduit,
 		dst->tag_ops = tag_ops;
 	}
 
+	netdev_hold(conduit, &dp->conduit_tracker, GFP_KERNEL);
 	dp->conduit = conduit;
 	dp->type = DSA_PORT_TYPE_CPU;
 	dsa_port_set_tag_protocol(dp, dst->tag_ops);
@@ -1253,14 +1254,21 @@ static int dsa_port_parse_of(struct dsa_port *dp, struct device_node *dn)
 	if (ethernet) {
 		struct net_device *conduit;
 		const char *user_protocol;
+		int err;
 
+		rtnl_lock();
 		conduit = of_find_net_device_by_node(ethernet);
 		of_node_put(ethernet);
-		if (!conduit)
+		if (!conduit) {
+			rtnl_unlock();
 			return -EPROBE_DEFER;
+		}
 
 		user_protocol = of_get_property(dn, "dsa-tag-protocol", NULL);
-		return dsa_port_parse_cpu(dp, conduit, user_protocol);
+		err = dsa_port_parse_cpu(dp, conduit, user_protocol);
+		put_device(&conduit->dev);
+		rtnl_unlock();
+		return err;
 	}
 
 	if (link)
@@ -1393,37 +1401,27 @@ static struct device *dev_find_class(struct device *parent, char *class)
 	return device_find_child(parent, class, dev_is_class);
 }
 
-static struct net_device *dsa_dev_to_net_device(struct device *dev)
-{
-	struct device *d;
-
-	d = dev_find_class(dev, "net");
-	if (d != NULL) {
-		struct net_device *nd;
-
-		nd = to_net_dev(d);
-		dev_hold(nd);
-		put_device(d);
-
-		return nd;
-	}
-
-	return NULL;
-}
-
 static int dsa_port_parse(struct dsa_port *dp, const char *name,
 			  struct device *dev)
 {
 	if (!strcmp(name, "cpu")) {
 		struct net_device *conduit;
+		struct device *d;
+		int err;
 
-		conduit = dsa_dev_to_net_device(dev);
-		if (!conduit)
+		rtnl_lock();
+		d = dev_find_class(dev, "net");
+		if (!d) {
+			rtnl_unlock();
 			return -EPROBE_DEFER;
+		}
 
-		dev_put(conduit);
+		conduit = to_net_dev(d);
 
-		return dsa_port_parse_cpu(dp, conduit, NULL);
+		err = dsa_port_parse_cpu(dp, conduit, NULL);
+		put_device(d);
+		rtnl_unlock();
+		return err;
 	}
 
 	if (!strcmp(name, "dsa"))
@@ -1491,6 +1489,9 @@ static void dsa_switch_release_ports(struct dsa_switch *ds)
 	struct dsa_vlan *v, *n;
 
 	dsa_switch_for_each_port_safe(dp, next, ds) {
+		if (dsa_port_is_cpu(dp) && dp->conduit)
+			netdev_put(dp->conduit, &dp->conduit_tracker);
+
 		/* These are either entries that upper layers lost track of
 		 * (probably due to bugs), or installed through interfaces
 		 * where one does not necessarily have to remove them, like
@@ -1635,8 +1636,10 @@ void dsa_switch_shutdown(struct dsa_switch *ds)
 	/* Disconnect from further netdevice notifiers on the conduit,
 	 * since netdev_uses_dsa() will now return false.
 	 */
-	dsa_switch_for_each_cpu_port(dp, ds)
+	dsa_switch_for_each_cpu_port(dp, ds) {
+		netdev_put(dp->conduit, &dp->conduit_tracker);
 		dp->conduit->dsa_ptr = NULL;
+	}
 
 	rtnl_unlock();
 out:
-- 
2.43.0


