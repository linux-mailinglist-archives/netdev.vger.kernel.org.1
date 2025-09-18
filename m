Return-Path: <netdev+bounces-224270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE95B834D6
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 09:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66C81C2181A
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 07:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066DB2EBB80;
	Thu, 18 Sep 2025 07:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fss0MCn/"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012044.outbound.protection.outlook.com [52.101.66.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05092EA472
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 07:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758180131; cv=fail; b=My9ywKRAo8G0IpAFPeenSomiBc7kWZQrOa2sHLQ8cnCv+7H6C72/gPf0RXMlprxujWKrICD2/DIlgYV1PoLce70OUH28q6HoaTNzLXe3n5in7+rufThAeHSbWdYU+KzdIpvbPqbNdDIKXEUnEuGfYVrrKfd2PCHS0og/+o6T/mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758180131; c=relaxed/simple;
	bh=82rBHbzNQzib+7WpTZS3LU5T1gzdzaginkgA5Mnk54o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rHvoH58N32QIJ/ejAkGqM4zER0ZAhA/r66nB0n8dI9Keu+jVHuPNrb5GTBEb9KsZFjjZuJf4VOD966qLlVVu3Oyhz2uDAPHq5gE2j3Pa0Dbvsrg6+vUClKoCXnNa4tE9NNiaWFlt85MmKGLMxYWCzSaZCbQ5GIkQYbOmgaoKUBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fss0MCn/; arc=fail smtp.client-ip=52.101.66.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LqpQ8Tkyr7OoOytLXGlE+kPgR1xGgL6LoYiZeGBLAQQhsGgvISdh1RKpqu+tjdd4iWGR8s9hjF+K69jxgUztNic5wfOpcYx3iMVnmHnx3ABjuyfdJ+YjPb3j0ETQZe1nBH+6FVwzeUhUQtbGLDk7SguSV8e6WvT1/EgD4Qut9aReFfeKkY6aNNPdLzF/Yus2CwYhcMOtJRMJZ5xqOcV3KAXSG3L++U3zhyd0aoUTEUpod6umoMBpZKDu7bo7kY0ompb6P/n2i4vWDBf6XgRrbVDuRjrhl0+0oHlGROBecvBWXItqydolQhaSV8KYFU65HFjwBVl1q+Ns10kgAPPKGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tWdPAo9ggfhO2Lp4hADbj6ICmmVL4BjxVkYHNAFet8=;
 b=Jc3qgGy3BI5NVKFJLDdzERcwhL9luZzsvKeMM08J3ED6AxC/OkNz+29dbde+7qVKRW82z545T//riOywRwOcUUBkRYUCpfzRZoV91YyXaAMDA/WrVL1e2ExzOAk0q4amxYk2w9gVratjN11PSjRISq+llcGNfcoDgTuYHzPgmqhpkadKT3tGbeax2vVYnvpqkvyYUO04sRXmMtby47dtHtm52aTAe/qxAt+puf5p8qz8PnbKm2j8bf3zBBg919aF/Zrp28NoL/OaVtktpAySY+UG211mHA38goXjcS7uYAC8A0BnB79gCcvzyxDKun6z2LjN8BOx28ovbwto9ll3MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tWdPAo9ggfhO2Lp4hADbj6ICmmVL4BjxVkYHNAFet8=;
 b=Fss0MCn/t+sOQyLXrBl5MAvBx2cHhmPceMpddaDG193W+aFTkgMMlCAdfbnDv3a4HcX6NZPYWTVkUVpYF6AK1fomYKGRrDNkk1KfFES9BVNOSO2PfNd5gj9NvAx1HP1I4C0pwPObIJUImUT3jSahLP+SgbcI5B97LXRzlvQgHiklswTc+iL2NRZABQub7NVg4uPyNuCc2IriHMET6mvxV5AxdQXXgDN/nh1V6fQqfLsb40UsbUhWmfY1m3Ecw6rdOGToqCRuvWSh7hNUOCoSmUf/pdLtrhdD1CYwSJRdlJwlR+R1YwRU20llcsb+aMU7Tz4F3CvebCzkzQgOsIemXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GVXPR04MB10045.eurprd04.prod.outlook.com (2603:10a6:150:11a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 07:21:58 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 07:21:58 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Daniel Golle <daniel@makrotopia.org>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net 0/2] lantiq_gswip fixes
Date: Thu, 18 Sep 2025 10:21:40 +0300
Message-ID: <20250918072142.894692-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P189CA0022.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::35) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GVXPR04MB10045:EE_
X-MS-Office365-Filtering-Correlation-Id: 8166bec5-8301-4299-5f04-08ddf6840d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|52116014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wMEw8GMkqAiz7+U99IcgFA3YrHUXbT2ioGvjRF3L5rNs8syUBYUY9opvjaC7?=
 =?us-ascii?Q?xWCTfzlcWD/ecTD4Fo+wKRJgdHUQ96wDV7gB9RnZqMA+GirP5eQ30U0DPS2h?=
 =?us-ascii?Q?vHQcCKqK6DXEhqSj3QiTehgoSRwyllOH5cVeL+uxOkuadjjIKpcJdvgTFMnm?=
 =?us-ascii?Q?ethD8OKD8NvkRUtgNLOo08WBaeCIwB7yD05zvKAUKuq9bTbXtvCAORNCov+e?=
 =?us-ascii?Q?X6lbKw/RSOogjzja74j9h1vxhAOE8Wi2Lc6WesuwtoWHLW7quJL3cUVAe7OT?=
 =?us-ascii?Q?+NE06jjaeFC7q3GbjJMt8zO0VZItiYVyUKxP0YhawmhTqVw8FQIN+d1oGJpi?=
 =?us-ascii?Q?O+484HIPmHFbaDxZCEIT+7y8VzlYelaj1TVJ0FJN8/F2Ef9bq1jjH4xS4IDk?=
 =?us-ascii?Q?puhjBOeVwGsZLRy53K3l7hHpR1HLtWDPWgUdz5RbxjDs6d605dgbuIcvG/ct?=
 =?us-ascii?Q?6ZMXbQHmkuzEa2NdK1SUajEu55rwGXT51c+KLV53w9sggBr9PwmNGHZDIwqD?=
 =?us-ascii?Q?rMmXzpJiIhYg1M58YDF8DhEjjaEkTcskn3NIN7sLhD0o8dJLs9EY0ZOBkTwB?=
 =?us-ascii?Q?nM7RvGV8a+WrOBN4YouYNBAIOvcdD0SETYQg86rUd68VTf1DSwxPJNktU40O?=
 =?us-ascii?Q?C+QWkbbECtHmH8ZHYDMT6Cx+S/5aLdFL/D4JqS0BBubyiQEU78J19r7HQl7/?=
 =?us-ascii?Q?2QmsJxS9hAyuCoRpbWZCne+oN5SCYsDcl1tlSSWb7WW2yQMZye8kn+dAANay?=
 =?us-ascii?Q?PZbIFZ8azSwG9ZKzqqJI3LSDzC9ieM7KV6ELDYfMEMzXsA6306mC0TKmlybz?=
 =?us-ascii?Q?HfA3A86rPuBlsgbmYw6/c/IBC1HzKEhZKFz9Buyn6FoDEm6JiW5nrTEZa2Fb?=
 =?us-ascii?Q?6DxPK0U8As/8Xx1lx+PoCTMmn0lgW0QqsLrQAJ0yXWQNNDFUTyPkd8ppPGsd?=
 =?us-ascii?Q?ktWCeDH6x2lyvDXPolEsUT6puBmtdDjl/sZgGCvC8qqEvdfXT640m8fpZXdJ?=
 =?us-ascii?Q?7t1eSZU8BTh/SJ7gA+oiIOSXxeIz7fmmHzamjqzjAe1KUPZm4VlKHqGrOpXs?=
 =?us-ascii?Q?VGi/LmXvUioCnMAsox0alLIu/PCziMNRxndMa2sVilZplDMBkItKmp0OabTk?=
 =?us-ascii?Q?Fc2h6w0y+qKaxoapAcz/u7uYsWND8rFUwmRUC7kzkZNWJttp8RToUagr3rhL?=
 =?us-ascii?Q?JFl/KXrB8ZBMnMpaa91kCQqcNotLnVaW5vHQrxn/yHWv9ffHvrUHPbR05om2?=
 =?us-ascii?Q?bQLTe9uh1qf1aky1LzZfio/yzmDJt7o21g7glUvWn7AsJ7oBU3owsofbG563?=
 =?us-ascii?Q?K6m75OjKGid/f4KHuOD4t8iJPyp4qa0gkMNH8Cwgggd7hsUjGuP7COb0lVSc?=
 =?us-ascii?Q?msT3ZlqJyn3DRxGTI08rN4QfsnX2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(52116014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3hoaG4VfmRpkXc0BWOc6o0dKAYYkLh8WOB+PV8EHE/V7Kua/RlgXUHbiSciq?=
 =?us-ascii?Q?5lr36U+bMsaMsxLgAFIZB9LLo46mOyQqJcBI6VlahkwLPvQph77OXHnY7MMD?=
 =?us-ascii?Q?xDf0k0xopF/IqyIMh2+YqIK+1zyb+RWkMhaQuEpiJKG5CsCzrzDbRAHGJTqt?=
 =?us-ascii?Q?b80uK75+93nvT1x43cUyXS7N8lUkiHMoPinNFH/93/9ImTLvaTnHgkFQcm3k?=
 =?us-ascii?Q?IKlHKtoPbaVFVpUXAMJeUhYRzmPlhVokZur2jmSCKSVBjmdAGWCLfOPD4VlM?=
 =?us-ascii?Q?g6yevKwemrh+1NLdVfaIGvJTESIervxQuxuWpwqQvgNK1P/VNm2xVnMxoJ5t?=
 =?us-ascii?Q?cWPIY4zK+VLscs+tC3NiOFQNMja8WqctG5iZQyonpto/fGZzXiePHyJp4ZEb?=
 =?us-ascii?Q?Y5kl42knZxQtODoMdLoCK4thxVYDBt3BPn9wokytDX2f/b+kgbYEr/RyMtAP?=
 =?us-ascii?Q?l5/VOxWvRjc5Dd0MxL3hh1e2nWR0G5KFKWzKnBjyPvUg7sJYexbNePmTzvR5?=
 =?us-ascii?Q?goV1Vd4dIUz9FX0ELl64E4L0yZqVyeI2iWhLSNBsqrCzfhee/DhsPSFmpoZM?=
 =?us-ascii?Q?jBxOyOPLx+Vxb1/zSZoC/qmR1rvB5KPz/EC1rE4WObGKPKuRc+wkABmcupNj?=
 =?us-ascii?Q?sfGQgd+/xWV2buY8B9MaXipF3UsnSohC6xc3YZz15J/aXYUYZWSEyLAtoibf?=
 =?us-ascii?Q?gkKwQxkQX1OSBemLELWLoP+8qt63lzclN77/IDcAh/8jwpFHwC/ZwWWKeyfw?=
 =?us-ascii?Q?ua4xLy0oIHy8j91uEvY+f64GhBnL8uFZfSbTqSvxw7Y3QVCpl3AQE10lJZPY?=
 =?us-ascii?Q?pIDOF2L7JZfPNbORkgjIxX8cL0M9xqFkbNV0if8T0kR+nGkDR7vc+NXN6dg2?=
 =?us-ascii?Q?Oz1TjcRe0SIXitJFLmvpt4S/ZZyrtcGXRU+0BSkSTNMNkStteWViWXOVsYj0?=
 =?us-ascii?Q?/qVEcKynk6OLsktof9r5o5jE6R9/7MGGaGLzYMjoFCmXUzt982Op7v7rfEni?=
 =?us-ascii?Q?Lpsy38zbYxZwYpEHs6noC+FBLUEHu0T+ep0gh81cQNGosewqM+vvcxhL/YuE?=
 =?us-ascii?Q?Hvm52AYdE8eYXWwq38MfyBqULKGa688xRIGsxeOQ9QX6bX2F66084NiyJbdH?=
 =?us-ascii?Q?0hmGtU3X87pgYDCXjMLo0xI1VTXSifKGI5kDe+C5FC4/sWXOhHklJYfIlxRw?=
 =?us-ascii?Q?c/3d/6hYTerTr8Vy2diY4suk15Q7+S+PPnubaqAmda6Bev0DmPK3Cyq+ajzc?=
 =?us-ascii?Q?MBt+18gRLXX77AkNnuR3aqLDHdsYkdovS+m2HLva/w1qtWPUBTIMKgmBAtYd?=
 =?us-ascii?Q?DflaOAcAZC3Uhs7Lw8rwaBy1xmSYln/kji3YMh+zhjFXH1CjaaXSw4oEBWQk?=
 =?us-ascii?Q?qMSpLWAt04tH3T+5QFIWAr/ATkLY3aKR50SAN5S5TqNfSM0Lz7cjVdbXjeI8?=
 =?us-ascii?Q?nrlQ++w07LJDvi98ln3ZUtHspr4FfEdB58bzOSipEz0gZE2ylt54kn/nj7II?=
 =?us-ascii?Q?F+GElucSbH6pfCerU8hYoAdYvyAyV3m9EVKqISLzdNYq2O7WJ0VNTVFbQY25?=
 =?us-ascii?Q?lHmE0dpONbT7DREao1WHEtOVeq3aWLIt/tPMiqpptflfDXv4fzzw0pg52qv9?=
 =?us-ascii?Q?S/60mGWhQesyxuqtTqQpAw/8L1N8f81KsSmbTUosEJv0yr0kvrBqMkPw2fS3?=
 =?us-ascii?Q?IzlznQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8166bec5-8301-4299-5f04-08ddf6840d96
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 07:21:58.2683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xEMhIgCPFmb7gNHpZXYgrogJzrULzh2Y3xigDVCCuETbr/rV4HETsvST9ti1YRiCpTRKJSTeBAsMwzU4QNxEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10045

This is a small set of fixes which I believe should be backported for
the lantiq_gswip driver. Daniel Golle asked me to submit them here:
https://lore.kernel.org/netdev/aLiDfrXUbw1O5Vdi@pidgin.makrotopia.org/

As mentioned there, a merge conflict with net-next is expected, due to
the movement of the driver to the 'drivers/net/dsa/lantiq' folder there.
Good luck :-/

Patch 2/2 fixes an old regression and is the minimal fix for that, as
discussed here:
https://lore.kernel.org/netdev/aJfNMLNoi1VOsPrN@pidgin.makrotopia.org/

Patch 1/2 was identified by me through static analysis, and I consider
it to be a serious deficiency. It needs a test tag.

Vladimir Oltean (2):
  net: dsa: lantiq_gswip: move gswip_add_single_port_br() call to
    port_setup()
  net: dsa: lantiq_gswip: suppress -EINVAL errors for bridge FDB entries
    added to the CPU port

 drivers/net/dsa/lantiq_gswip.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

-- 
2.43.0


