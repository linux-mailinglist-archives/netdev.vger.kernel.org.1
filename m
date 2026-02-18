Return-Path: <netdev+bounces-259323-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNZ3HXrjlWmrVwIAu9opvQ
	(envelope-from <netdev+bounces-259323-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 17:06:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1C315799F
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 17:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 614C0300F123
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 16:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BF533372A;
	Wed, 18 Feb 2026 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HWcwUvGg"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012069.outbound.protection.outlook.com [52.101.66.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230FE334C09;
	Wed, 18 Feb 2026 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771430775; cv=fail; b=cZiL6OfCvY+EY7kBKe18XtGyj1ocYnm4rIJUprPO2qwFzFkNlZXH4EnrqHZT+jujfcA3UQVxHAHryXjwxKNtMibe7UPdEo6SnMIC1HucW6IZRhpjxcnCboT5q1NMSe3k8c0P0x9wy3wt9ol8+M1bIIVOpUqVjSf6fSBYk+ywXLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771430775; c=relaxed/simple;
	bh=X64j1KKcuB+gxmmSzHopK+maBVYj7hdjjMveFY9eWB8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VkTYpmV6hlEZfbWxjJRooaPAMngW6J+JZ/NOQWPmotTYR3dI1q7/7Y5tDYYehF8uz7GOHpEBBpthO6anvL/Iq2EV/tH1rzuaSL2CjLK/gvLkonEDfd6JD3jjaLMgWtplgC/BK8sryXfI6U2WHBdy29M8OOdht6+ytsNt83flaTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HWcwUvGg; arc=fail smtp.client-ip=52.101.66.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M9LGkkBPnYwrJrC6L6bTnl0AydhCezO9SmoFCR7kU7J7dldPUR9nkvSe3QlUlHpVuCZJhIUcLQLmJnnz50DpMva2XMNU+r8H1rDannYFA/0h+WBrxoT38JIF6tA7HdjploN1bRTQ3gomTEMH9890dCp60FcNQz3EtqNC/hM4pjlHIYvm/Zw/DQNVMRxdvgecR/HkwzaKO8mgGJ+vlMiBB4V93DPO9TEuBajU4P3OwI7EbONCj6G1iuYoSkVICIXYT1YEyhfp5qdckY5rzmYxgi5vIi+2EluqwQ66F7wQdy2xILVTnkeMX/2O0z/kTNkZJmj2ambmSI9NAFdEOYkioQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifeKt4oa2PaBtW/OpVYkTQoLH7cN7Sg/C+vYVNBTbVg=;
 b=A0d2UlBPcvE6jLBDHrj7E40p6ksqA1MMKCG+YkLE+R2Lf9cqtMlUkz4eLu1HCqsV5NKFsiWNnxT69PJWq2L1lCWFjK9e6kKDcjhZ0fg6Qa6qT8iRZ6gL9XFNEXtC3j9FK1P6f+SzP+qufscOE2r183T6eu42IP/ffB+KfwVOPN9IqMtI1MWYegU0+Wodp6Sh8SJQ+a63gHJfz0L+wIsrrX48v25nBaSdeCDBuu4nLjHuvtImZUc0wx7xzLjNOWbwIgJyuzvnCbqwNSMRRtGUpxsNjdU3/4JjX2L1VgOaFh09XIIb/Pmh8sGDoDGYKc1ZD+fbdFeppYX0QKzrpLFZ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifeKt4oa2PaBtW/OpVYkTQoLH7cN7Sg/C+vYVNBTbVg=;
 b=HWcwUvGgt098OLeVsxdsq2vru9Zxy+rUefjAugrgB8eXx/m3c5IoH4j5yHDNSJxukj6MW+h/gBN5MVxkGh3tVzwPO8BkGHsam9mqUtGNlGNGexSp3iDcmEoiKIgMQbWq23YvwlNHhDAZb4/9mgn+4RJZSGS1wPKy/+VHEQuloh4ytO9S70ghhn78wsp0Sm8rJp6//mVEZYt3d23wtTzbd2QmuOyohgyszpiheN2xY5M+XecsDo2tId91WyYn33FGxAElFy465vJbUg9XrqHVEqLgcBvKcFuPttgBHYR5WEnvpW8hedSrMwXGjnSBolfBVbPptWg/EuELrBgff5eB/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB8PR04MB6779.eurprd04.prod.outlook.com (2603:10a6:10:11b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 16:06:11 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9611.013; Wed, 18 Feb 2026
 16:06:11 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net] net: dsa: sja1105: protect link replay helpers against NULL phylink instance
Date: Wed, 18 Feb 2026 18:05:51 +0200
Message-Id: <20260218160551.194782-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0015.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::25) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB8PR04MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: fde12f36-f4fd-4a14-bdff-08de6f07a256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qbc4qDkVeamqdagL0wVCzYzf/aJBgTduSi7cRG92KSLccLjInOyU4jFinpS2?=
 =?us-ascii?Q?J48yR4ANqv3+FxiymBC4Kq2VHR6/vNokYW+R0gz9m/d8q/L+33dplzKNf254?=
 =?us-ascii?Q?BPHG7VMDK2+QhK8afTgHqRfX/2E9cF8pilhSqYb4xUCirPvg6BwsDFCruLVi?=
 =?us-ascii?Q?FwE6VBf1zWValhZ8OcZLpca6rBPR/aFS6sMzavfivjPPkDQCEFzahcyToWSv?=
 =?us-ascii?Q?vOvvcrn0n4l2UyNq4m3bBvDLz58xAtmKaAnXMnrJEzGoZ1GZCv7+/cUIKPeC?=
 =?us-ascii?Q?DfJpiC7FJlnBnyVikbCtvlZz+XlnQKZx0p5UaPhIPu198iDmcmdEC9aAqvyD?=
 =?us-ascii?Q?CHxcNDym8cazzSaiL+iG2La+yd4Sc6W7Ob8DiXQY8Gk8jfHB+VPD+N/dGYH6?=
 =?us-ascii?Q?1zRC4dFamN0zRr6bVpJa5YV+tN8Z1Eh7lTD7pls/BIbRO+NCwrySjubPtqen?=
 =?us-ascii?Q?1AHbzygkxHeMTr5ZL8jeYxnRA4i+Q/1ZkBFGN8Jq43WIGowPcOjENFFQh9TN?=
 =?us-ascii?Q?8Hkvd6gY4urrASKd79I2QkDRL7YkaTDX2XANqmiEEIHA/Ghhb0syGXDGWnYu?=
 =?us-ascii?Q?Z0y4m+7au5T0Xpj+08e6DFHeR2BIjvmE2fe92N8+RX2jFNLJP2AZALswmeaE?=
 =?us-ascii?Q?J3Q0k1l13WwJ9kyflxOCliIT1D42Kld+yR6hRH+PcFjGiFkGQ3F+yUEV5gSD?=
 =?us-ascii?Q?xDQQA8DuxwOF6XH6TV90rzjLfMqZ+gZCEquLJv6UY16hjhMh1Cij8OQuy4e8?=
 =?us-ascii?Q?1RoLk61U8U8tQEpYMeSY4NcEnL6/qbKjXppheAlC+W3NaHOHHiBaN8GM9QWJ?=
 =?us-ascii?Q?Rqo0V1NaLniLOtZjRn2Wk602XUjwoWmkI3+PSX4tGYDyL3DAKgZPCggzZrgZ?=
 =?us-ascii?Q?LcWBm+Pw4Le+nttGUcSzwAulkPH5+lspDruug0AjabKKgJxNxLi2SVGIAZgS?=
 =?us-ascii?Q?jPdbEjWAFNSqz9FefzYW9oVCCl/QhY+Fq8RyeGYobJtJXOJef1hHkoVxuEbA?=
 =?us-ascii?Q?9jHwEqPQxXnb93o9BAd4KwhpIu//cEFMMDoL43ArC1aEkf86Xm9fUM91c0Kc?=
 =?us-ascii?Q?MnJ5IDCBLIYmE8MZdsDka52Z8fHAcius871QFv+Dw1BpjYaq18HnRArXlG34?=
 =?us-ascii?Q?fMBGuA07gby2RvRhRsmd2Ee9u/SEmjLRGHqQ/gLvfK5DDDIzsLrWTqCMzmMt?=
 =?us-ascii?Q?6GpfvVNzTjl6qIxOqcL55qq9gF6YNV0dVHDKy+snq+dbaGESgR5KNvOcbTMi?=
 =?us-ascii?Q?0KNUusQiTjOWRdYrvuJ9XwTOwz6r9wGiGx2CG7u2Lz3dRfxRDZ0xAX4a+dC7?=
 =?us-ascii?Q?RP1Vwxy+n0rTiRUAx4F5BBfRlpNV/CT+ObgPllADd2e2LNOs9JxiLwpE2dUi?=
 =?us-ascii?Q?Sa7lFlT2wTZ4hwrG+lq/bkPtgK8XtpVN/pzIA5KOlV79972GsdHRHauL4+gB?=
 =?us-ascii?Q?6g/UXZpmDOvvYmGUFjdGWVgofQ6/sSUGp36qqQOQkauk37+9elp2pHwNSlAe?=
 =?us-ascii?Q?edffYmSLtq/PPUexqAY6Y1dp4v5Egn3asU1x783NEznwjg2/HZFp5xJ1GNFR?=
 =?us-ascii?Q?SUj19ssxM95IBO88jeD2k1Xi8aqg7lXqP0ThMytnAlXkVVa4g7fbWCMf+fIH?=
 =?us-ascii?Q?YndU2SZFfI+bSczJX5niHZc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VkuNI9QADbHaG4/rz3aDga5hc12dCjZ5DHFGwBFxAvcn2lQOIFQGVfd9oI2m?=
 =?us-ascii?Q?ksB0dau8J6uYz9vk1UUQok+AUWp9PFzw+wfXaJ7MkQXcNOOPdsbc3Bi9e+HU?=
 =?us-ascii?Q?Byy2bLodt+G/bDriPTY8E9Uns7wKzKxdwvHH1W/4kOW2f1OIPDJwXdbZ6mrM?=
 =?us-ascii?Q?wGqYOwTOTeuzg+Rvy+szhLoPZXL8CyqQFyDvRfy3iB6iTEwVEPcse3deOIO2?=
 =?us-ascii?Q?mG0zWGcBnOst7571eanF0zbbMT6NpPHLDSouT5fbgevnH+3a7HioQ8o49Z5z?=
 =?us-ascii?Q?mkpr+O5vjreoFj0/SRK7+HLdItQmg4DePQ20dKHEkqySh/1/ZL0Gjk3D7pRM?=
 =?us-ascii?Q?yFTW5yD3RxNbsaY2mLa7vC0aRyv9ivlZmb9x4pwbZv5BP8E/SaH4RHyMBih6?=
 =?us-ascii?Q?5eoECKRKZNxefEG6jsDFX+c1X64B4NI2n+m91LWRM1kyKywYp1mPBJIiIBTU?=
 =?us-ascii?Q?o7DaSFmL0yKTS59c/u4zHnDcbxpDjMIDS0GldlKPGLTLWW73rrogJOsvBoFJ?=
 =?us-ascii?Q?Y9KQ20FgkVxK5MeysOSz63ckTabqH5+xe0dw4EH0ivJPmgkT/0VphmVNvZZN?=
 =?us-ascii?Q?Guh8/2PxrwskjCUVDTllN1GLOzDFDQPbqTL5OM6zbC0KJtUZFKrr4uI5MWHy?=
 =?us-ascii?Q?luB36UFgcYKNXraTT/DGZro2MgnB1JSVy+8zHXsKqEb8nH7VsllAtP8PdGSl?=
 =?us-ascii?Q?wPgcSW8eaT0U+JH7eckDiiaVqxN3WShOhPUnkUZP667AQ0zwABo7qt+8X8hD?=
 =?us-ascii?Q?qochk9Je804n9ysNqKK761aRh/ExLDVa9zYxugkiVwFvipmeBAtL4OrRGeUt?=
 =?us-ascii?Q?FN/+kjSr6ZLrBhP9/z7LA06nic9TqzDLKeX3Cyw0YVfzs35RozL6DsmLaxim?=
 =?us-ascii?Q?fke2KiRm8qBMqWGwL1fd7q+0y/S4hzRXxIiYM7J6RaDH3oEMiRO84uxq2Ca4?=
 =?us-ascii?Q?lZz9GztVa6nt7bes1Pq3t5KezYHbM9r20nKIGnwtTThI7U4qDmUxFN0P0R8/?=
 =?us-ascii?Q?w30kcd6ToV7h17H/6IDKtXKzaCWSl4oLSI0jkKUlCFkE36JLAAc/doecMzEq?=
 =?us-ascii?Q?iqGjbTdtKHrBzkIICyaebSXAoGsDXbHoWC8ONjjc0DZvI9RfA7bczbQFgc/2?=
 =?us-ascii?Q?v75vs9AeP+NwibL8kh34GU+At4Axo37RsHp3oQKIMZn4yRTH291/7s7GVd3l?=
 =?us-ascii?Q?zJ5TVKktU+KK19SEXDWbUvSje9qgTb1i76jOe1AntbB3NvooCjfvvwwGjZWy?=
 =?us-ascii?Q?zCKiyga235S2kC/f+GFsGQKOn8tZrwV+wgAsgk4p/t6rDbBGORDVs1UqIahL?=
 =?us-ascii?Q?AUi7SR0uK/WRXyl2PoF5FB+5hWk4ZsFiO75ucG8f11HusjDWpieAqFfwmWFR?=
 =?us-ascii?Q?3imA6YsIlauBLbuQpqztrdGqNX6tIlt/QlBQktPvBgiVOioNBiFbL3bqz9Wv?=
 =?us-ascii?Q?yS6Mm67xRb0LMImoavHtgwJ2GTv1347X9TGARXaTHru5JKGqrGTEyo3C5HwU?=
 =?us-ascii?Q?dObwVlZZ+DaDOWYU1s9ozVarjiXu7T2tExzldmrSh6GF9zXOYBXth9qR++Jk?=
 =?us-ascii?Q?UlaF2C7ysd41x37AdW/Hjoq7dVE6s+82M92N7mFZAE/NRHhJ3h/1EJZ2GJNz?=
 =?us-ascii?Q?nEOPgk+9TezeiJVZvGPRXIRHfzrM/ZBYNOYi2GYgu3ZZLXOKK69J6gbIZsO/?=
 =?us-ascii?Q?bNF3Gea9+0kfxZjHGs/DO+77twraiOWutvZe+URujvy0JeUGlytnC7/3mgtU?=
 =?us-ascii?Q?wYO3ZdKHJQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fde12f36-f4fd-4a14-bdff-08de6f07a256
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 16:06:11.4236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukj85GoSmXXoZZfYR5qlvDD/dj84YptSoav7jrUGNx8x5UJH47RfHotnnPyOLIi1jrh30cPgv6nS69XljgpAaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6779
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-259323-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:dkim,nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF1C315799F
X-Rspamd-Action: no action

There is a crash when unbinding the sja1105 driver under special
circumstances:

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030
Call trace:
phylink_run_resolve_and_disable+0x10/0x90
sja1105_static_config_reload+0xc0/0x410
sja1105_vlan_filtering+0x100/0x140
dsa_port_vlan_filtering+0x13c/0x368
dsa_port_reset_vlan_filtering.isra.0+0xe8/0x198
dsa_port_bridge_leave+0x130/0x248
dsa_user_changeupper.part.0+0x74/0x158
dsa_user_netdevice_event+0x50c/0xa50
notifier_call_chain+0x78/0x148
raw_notifier_call_chain+0x20/0x38
call_netdevice_notifiers_info+0x58/0xa8
__netdev_upper_dev_unlink+0xac/0x220
netdev_upper_dev_unlink+0x38/0x70
del_nbp+0x1a4/0x320
br_del_if+0x3c/0xd8
br_device_event+0xf8/0x2d8
notifier_call_chain+0x78/0x148
raw_notifier_call_chain+0x20/0x38
call_netdevice_notifiers_info+0x58/0xa8
unregister_netdevice_many_notify+0x314/0x848
unregister_netdevice_queue+0xe8/0xf8
dsa_user_destroy+0x50/0xa8
dsa_port_teardown+0x80/0x98
dsa_switch_teardown_ports+0x4c/0xb8
dsa_switch_deinit+0x94/0xb8
dsa_switch_put_tree+0x2c/0xc0
dsa_unregister_switch+0x38/0x60
sja1105_remove+0x24/0x40
spi_remove+0x38/0x60
device_remove+0x54/0x90
device_release_driver_internal+0x1d4/0x230
device_driver_detach+0x20/0x38
unbind_store+0xbc/0xc8
---[ end trace 0000000000000000 ]---

which requires an explanation.

When a port offloads a bridge, the switch must be reset to change
the VLAN awareness state (the SJA1105_VLAN_FILTERING reason for
sja1105_static_config_reload()). When the port leaves a VLAN-aware
bridge, it must also be reset for the same reason: it is returning
to operation as a VLAN-unaware standalone port.

sja1105_static_config_reload() triggers the phylink link replay helpers.

Because sja1105 is a switch, it has multiple user ports. During unbind,
ports are torn down one by one in dsa_switch_teardown_ports() ->
dsa_port_teardown() -> dsa_user_destroy().

The crash happens when the first user port is not part of the VLAN-aware
bridge, but any other user port is.

Tearing down the first user port causes phylink_destroy() to be called
on dp->pl, and this pointer to be set to NULL. Then, when the second
user port is torn down, this was offloading a VLAN-aware bridge port, so
indirectly it will trigger sja1105_static_config_reload().

The latter function iterates using dsa_switch_for_each_available_port(),
and unconditionally dereferences dp->pl, including for the
aforementioned torn down previous port, and passes that to phylink.
This is where the NULL pointer is coming from.

There are multiple levels at which this could be avoided:
- add an "if (dp->pl)" in sja1105_static_config_reload()
- make the phylink replay helpers NULL-tolerant
- mark ports as DSA_PORT_TYPE_UNUSED after dsa_port_phylink_destroy()
  has run, such that subsequent dsa_switch_for_each_available_port()
  iterations skip them
- disconnect the entire switch at once from switchdev and
  NETDEV_CHANGEUPPER events while unbinding, not just port by port,
  likely using a "ds->unbinding = true" mechanism or similar

however options 3 and 4 are quite heavy and might have side effects.
Although 2 allows to keep the driver simpler, the phylink API it not
NULL-tolerant in general and is not responsible for the NULL pointer
(this is something done by dsa_port_phylink_destroy()). So I went
with 1.

Functionally speaking, skipping the replay helpers for ports without
a phylink instance is fine, because that only happens during driver
removal (an operation which cannot be cancelled). The ports are not
required to work (although they probably still will - untested
assumption - as long as we don't overwrite the last port speed with
SJA1105_SPEED_AUTO).

Fixes: 0b2edc531e0b ("net: dsa: sja1105: let phylink help with the replay of link callbacks")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: select option 1 instead of 2

v1 link:
https://lore.kernel.org/netdev/20260205192344.21797-1-vladimir.oltean@nxp.com/
---
 drivers/net/dsa/sja1105/sja1105_main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 71a817c07a90..94d17b06da40 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -2278,6 +2278,12 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
 	 * change it through the dynamic interface later.
 	 */
 	dsa_switch_for_each_available_port(dp, ds) {
+		/* May be called during unbind when we unoffload a VLAN-aware
+		 * bridge from port 1 while port 0 was already torn down
+		 */
+		if (!dp->pl)
+			continue;
+
 		phylink_replay_link_begin(dp->pl);
 		mac[dp->index].speed = priv->info->port_speed[SJA1105_SPEED_AUTO];
 	}
@@ -2334,7 +2340,8 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
 	}
 
 	dsa_switch_for_each_available_port(dp, ds)
-		phylink_replay_link_end(dp->pl);
+		if (dp->pl)
+			phylink_replay_link_end(dp->pl);
 
 	rc = sja1105_reload_cbs(priv);
 	if (rc < 0)
-- 
2.34.1


