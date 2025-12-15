Return-Path: <netdev+bounces-244786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90401CBE8D3
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 16:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12B28307F63D
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 15:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2D233373B;
	Mon, 15 Dec 2025 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bEDfEb8a"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013067.outbound.protection.outlook.com [40.107.159.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE7F331223
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765810984; cv=fail; b=gy2UgTAc9E+Xwu07I4Y0lCRsoC2k8mOKlcnVRELED1px4NJUS8JF2yqhX0hlPNppbywBsgtzAzoFs/uc5MVFxiPNKDwV7dzjZp2J6PSaQxvDPpuRYJrsgNl5RLiHo6O2gyM8Xa0hngJfJoDhp/MX6nKFIoS+6NNQnZofPSbkTVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765810984; c=relaxed/simple;
	bh=S2BkbhL07Pd5LpoHMsQYXkim5Xjn2BBad+gFcMtnaC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZEwvBHxFCI11hlwBi5JDInTTzhinngTo47VpYJhc/2c7iFthieyRvtTL5Y7kF4jN2vSrOIimNPYUgoVSh6oC9dViwNVPNtWfvcZnjKMvztUmsyV7seSfqvXYvv2ER8hxXSoz2lZEw2eSzsjfHQmtMn3Az3DL9PrBti7bf3kRHSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bEDfEb8a; arc=fail smtp.client-ip=40.107.159.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JpAgF/EquNxutGnwebByrorMyOF2oPPSptSgUQ1t0Xess1BHD6SgpZ2zU1V9QL047IlFzi/pbkBhyBQIpCg2zdA8o4wWWAKozh2oAMEXjlzANml9M4qS/LM/QXIQR5E6nAEO6CfMdM2Yl2HWHTDXraH/xHJ0XBu6LbRVOiIj5/kFkk5DKkBJ9PGGFpOwPnTML1KZRRMGZVEXFFyN8PYLlkiuaD4W3PkLdpRb9+jCDS5fX9TAQip5b5fIyanMs/XAtZcB1BN3zmXKARInuPfrpayJYicWlTs8grQBwVm0lxx8FfyagB+/c92rueNrr7+1jMksS7EyA4v/6IyMQDng1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEbYbSc9/GTx+K9ZsNhOMihbSDobtRgMqgn07XalmY8=;
 b=vtMS2Z/e5mvOY5e+dldAdvYvYOKeQtdlAiAZg68IdSc1ImDkkEYPNYz1ooxEtu42lOY8DcY7NHQeaI179IV1T+JvLqwLcXRFHRI1BwUPUuOA03ilnuVT80/VTKWgDntproy0YlVSbYyzHoDnqQzFpnIzH4lIaBl2DdP8tZCmNCmN4RUrlNpE3ZE1B6ys5/XR/ppX/Lzv/8gQe4d/L2E5BsaJdcdLp6u1rzAPITU3eczt04FLym+03HSi2UeWQm+NCCCxAiJjAk9kVVsTweiK41htOG2K35f+oaORZUFNAQ8sa9LIoQET5c8dW9Soxs9eAwv7doS555dn3ypQSe5uXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEbYbSc9/GTx+K9ZsNhOMihbSDobtRgMqgn07XalmY8=;
 b=bEDfEb8au3iEqyToXFSbwjYOI/bBDG1Vx43Mcyxak4zpN/y1coBQ2xS5VMwf5WRHLPv+GfHZ84yALJodytNLyMD89t1YlgsMRvs0vRl0a9ED7QBUnduBPOHAHHpFRLCY/OG42llaDtSiutvfzVZSetI2ijX5G2ndntzUD6YY4z4K/SVpCKEHWI5gr71Ba46sbRXHX0aYZRghlMx0DrgpxymChL2u3q5qDOn6GLQbe57TfTHhaAiV6O6ljv1riNZmpfIEiJgkz2ow3H2noMIxxaGVqlISlGAIsmS1sK4SeBOwvBFuUb8RZG2u3UO9XWAxM7Zaf4v2DO/SDH6eP8XWjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DBAPR04MB7367.eurprd04.prod.outlook.com (2603:10a6:10:1aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Mon, 15 Dec
 2025 15:02:52 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 15:02:52 +0000
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
	Florian Fainelli <f.fainelli@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v2 net 2/2] net: dsa: fix missing put_device() in dsa_tree_find_first_conduit()
Date: Mon, 15 Dec 2025 17:02:36 +0200
Message-ID: <20251215150236.3931670-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215150236.3931670-1-vladimir.oltean@nxp.com>
References: <20251215150236.3931670-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0157.eurprd09.prod.outlook.com
 (2603:10a6:800:120::11) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DBAPR04MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: 10615ab5-df73-47af-569b-08de3beb0505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|52116014|7416014|376014|366016|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RFKb6eoDJJdBg6wD90YZGDFGg8MZzxQXmSEi3jAEaGZMc0u022Rm2HKhN+gi?=
 =?us-ascii?Q?AaYd7/eVIcg3Kg8IkvVZzB+NcAqVIv4QA8m+zKsVgsi+GrqegfQXAdgCdKqV?=
 =?us-ascii?Q?thQ6SXpzM2c9VSnC2nGj3uUS44Hwc2vCLxggB3QkwH7PC62gQzKOSuNUYaWK?=
 =?us-ascii?Q?4E6OSdNVdgXbXqPEc3Os50v+Tl/cUFiIsgtZK/Dy1Rx9e0wd6aemko0On3o8?=
 =?us-ascii?Q?dfltZKKBLUu7eVJ32WbDkWAKXbuI7aWoiZX7tIuXlOv04M89e60+vahQ5HbU?=
 =?us-ascii?Q?P3Uk8tEnpBu/46lxKa/vMH7Ow359elt70OEhZh/4ky8eXvEAGitqlWE3eRGG?=
 =?us-ascii?Q?7xBOeqqGP3vaJ8VsgS68KQ4E3vfI4MJK8cBOj4pdKTnAHCQdSjy6/pqBJQ9x?=
 =?us-ascii?Q?KXJNFcPkot25JpsXvzMU2e3oXN4Ay12YGhiaHupea3iMYXEqB1N1lFLg7wvf?=
 =?us-ascii?Q?2FAI+GEkmKW9ezaQaRiB9PEXAECZp/RANLmw1mTkwjo0wCcnCJgPY0EgGnGm?=
 =?us-ascii?Q?XhG6Gfvl7+uWuYrKXqJ/ESNETcJtGb+A1sX5pw+HSRFm4AjZfKb2O/rr6Rbv?=
 =?us-ascii?Q?CR/PdWw25/H+Ju/ezG5ePYImr/ncE793/7R9PSwaq/stqvXdL0jPb1EO2Z52?=
 =?us-ascii?Q?hT9xBF1Pk1EeTWLS/mURrNiYZdZQoquDPzqrUf92YVS74SfOXtXsJY8948Sp?=
 =?us-ascii?Q?A9UpcMjMuSB5930UAqcCXTDQ04p8oYhUqA+YkPSHvQ2dU0vxTJayPHwpVdut?=
 =?us-ascii?Q?twCy8/wsH8kx9d3p/5oh4zS9A863NDXZi5btUPrdg1oOiPBQmS+Ua2bFwZsS?=
 =?us-ascii?Q?iPiJJzVXy2Be+A8AN58j3X3rEwYSd7/OjFvTwcNx2lqgns+zoT2C4n2+80nN?=
 =?us-ascii?Q?qPwNvYqC/8diQnpTDB3ATxv5H5avoJQRLNulcBCU4oCTR/eabDA7ikbrtSm1?=
 =?us-ascii?Q?8SK6cAOBqPr+Uw4TRaNf4ab6NAGIEFNHDeEc3wI88tS1y/9DWALlILs1HqSu?=
 =?us-ascii?Q?4gz5uJt6VSbTjxTXpeiNfdu7uMwUbx/d7beI+7sOu/el15WIoRU2MIPHnYWh?=
 =?us-ascii?Q?ALO9RKJn4YX5+rTVJ+4o9xDL8e4GkeTUE+uKCbp/wUgq8jcB5RwjMiKAg7ht?=
 =?us-ascii?Q?fSKlNsN3KtN12q5ZKEx2q0xHYHTQcv5amYj80kSvHUPPisPcdzBMjmSy0x4W?=
 =?us-ascii?Q?wLY3liiNDfeotzwtbdX2aUFF6zRHymUfDNve56SaOhS4aSkhjkLWQCHISPM5?=
 =?us-ascii?Q?XNSPh+4g+DFiLI2F1zKJPpRUXYIPVIMr06/oA/bzyVBf9hAPzOH4hzwufa+s?=
 =?us-ascii?Q?OWBKQsgrmVQ4iLAP5HwxVI1Vlg4AczA5i9ueAJroIz/zUfOBf7GIya5a4YZ5?=
 =?us-ascii?Q?kLLX+t32NwhD2eKfSgVjMZteFhJNnTa2L/bsHpG9nlNXeJT860pzMDTLpG3l?=
 =?us-ascii?Q?UE5MxOokJUvS7hXZ7/N5TkypaNANgRKz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(52116014)(7416014)(376014)(366016)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2s1foXIg7u2a4jpC5eLve2aApLb3AnsIoto7JWRZdHqu76wYbN/gdScrivSS?=
 =?us-ascii?Q?J+G5HBIZ8xFSuTmqQtxMbm9GtrwO4wWRbUurLg1Z7k+zzDfLus6Z8pAJcoD5?=
 =?us-ascii?Q?Ky3GIyCf/Yv8W61dsblU5amOC7bND+tmy4oYb76sHppaQgfUdXJDd+Hh7qO/?=
 =?us-ascii?Q?0DPCNyLl8km5iAw3Tx1MC7YnXO5Kygx/4OwmppZeHifvZdOpZYNYKqafsRnL?=
 =?us-ascii?Q?XglcBERxLGdn7WbGRZTlGMF947OhV7ezXDtpxZwM0LQCfyz9cbSKb7fxY5QY?=
 =?us-ascii?Q?P6P7HbIizbnSjggP5pUeJGo5DvaWx759HW8zTxQj/xi273v7aUJiHTFEajlE?=
 =?us-ascii?Q?EkPqfBY0PTfMgGoC7SZGYftQFpzE2WZJ2tCpm62iGVfeEZizQGrbW2G4ozBj?=
 =?us-ascii?Q?0yRmJtPPvcwLBq8y0T2IU1KqQDQq9zLKmGh99HPb22luglpbwvqX9+ijBNU4?=
 =?us-ascii?Q?Km/zjEFtQXUaUiN4lMYEY6fiv8pm4jWfrFKt+g4xlDy6H2jzXqNJyVoaHGsL?=
 =?us-ascii?Q?U7EfUnRCY82WFgIvJx5lAkrwgBc1H+wTD900s4mMt+K3VkdYL8e2H0T/13sd?=
 =?us-ascii?Q?TbiFUxcSVi5tOEzSTlOlrfVQroa318YSqfWoKZRgDp4aUrj+Th9LZBaFtfQj?=
 =?us-ascii?Q?/UiG3XXIccuY1k++xqn8s8Gg3lhLkCn2M/xE/HZ7Q0iYtpmW3V1IOhCmPyKQ?=
 =?us-ascii?Q?lhN1brxomDjaGGpSLQ2GaRKOQ80lESJtZiVEt72ihJ0qmQFxc1XZQCpPEgST?=
 =?us-ascii?Q?S5CledIjC/R7bVeOuF8kYNUSfm/g5un7arSUiCd1DGjD1NidNnjnRflS5q5l?=
 =?us-ascii?Q?itFCDLdKAEb8AaOaxWPJ1u/7txqI5zURk3hMlugb8dCqHru3X8ybkLgDGVLV?=
 =?us-ascii?Q?CPB1LXqOtlU75P4L3zVe5pR3NEO9WybkMAG4Gy8o/8Tb8+xBzadb3t+V4xOb?=
 =?us-ascii?Q?puMigHI1EAXt0VuSZxaQ2uSwogjCemPg27YdprfI6ofkw851oV/LvMs63lF8?=
 =?us-ascii?Q?0JfZlkwtY/KbAbswWZjfkqU6tVTX0tCmJmPAoH9zVszvS5sWJhl9mB7s4pN9?=
 =?us-ascii?Q?Cokn2vSSMKxggEjGtupXkaKfsapAO7EHaUjh8Q3NwEhzUrCTkrBgcawVy3b2?=
 =?us-ascii?Q?IsEO9wpzvozJSR7JmZtq3YkXVCw2yGphgHMR1aWPALEVKKWBFI/8T2iX0rYr?=
 =?us-ascii?Q?DT+EbYj5yxzvBG6MiHlZeVjoE3g5tFmD4jeLCEfb2F8OyBNmB+91VxjGKRLj?=
 =?us-ascii?Q?M+fuad7moiUL0nF6KyOWPt+T03rz8a1goxP6FvKbBtvlU2YrXyoX2htytkRQ?=
 =?us-ascii?Q?LjTirv1PUUTgu1P8xf3+entE4JVYVty8EiCDwV1RSLjUbJeBryyKvz/hYd/k?=
 =?us-ascii?Q?1GJS1smPrNf7EuX4rJDn7Qlv22dFA5jADAEX+WuJuSrKWP6g+2+5Pygng4qo?=
 =?us-ascii?Q?KMib2o8eMnuoOUoKzkXl/X97ZAccFnyk4Q3CcyNp9tnbGk4GOu4XNZQ3h4eM?=
 =?us-ascii?Q?JyyhTd+fKicKTLwZ8/DOYp78R0qBTcqL5JQKuJ4XdT5irk/a0tFjXhcI9vR3?=
 =?us-ascii?Q?OSmWaijXoozMLTZA1NxvDAD+8bcVS6z9Z2F/plka73bgKf+2Zc7NWAlRCNBI?=
 =?us-ascii?Q?EkJwLL1KPYVrDUq5QcNnhUglvQaqM5ttb+YSl70+mLk+uqbbHIbakxhYuEyK?=
 =?us-ascii?Q?/XjGYw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10615ab5-df73-47af-569b-08de3beb0505
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 15:02:52.2941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEhLJztgchj+z+5rgwNsr1kD7Sd4wvkN4YQRwYzt5p6AhsmFr7Lis7UPom2eZsh2HLJEPn6eIK9iKYYjC1w6Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7367

of_find_net_device_by_node() searches net devices by their /sys/class/net/,
entry. It is documented in its kernel-doc that:

 * If successful, returns a pointer to the net_device with the embedded
 * struct device refcount incremented by one, or NULL on failure. The
 * refcount must be dropped when done with the net_device.

We are missing a put_device(&conduit->dev) which we could place at the
end of dsa_tree_find_first_conduit(). But to explain why calling
put_device() right away is safe is the same as to explain why the chosen
solution is different.

The code is very poorly split: dsa_tree_find_first_conduit() was first
introduced in commit 95f510d0b792 ("net: dsa: allow the DSA master to be
seen and changed through rtnetlink") but was first used several commits
later, in commit acc43b7bf52a ("net: dsa: allow masters to join a LAG").

Assume there is a switch with 2 CPU ports and 2 conduits, eno2 and eno3.
When we create a LAG (bonding or team device) and place eno2 and eno3
beneath it, we create a 3rd conduit (the LAG device itself), but this is
slightly different than the first two.

Namely, the cpu_dp->conduit pointer of the CPU ports does not change,
and remains pointing towards the physical Ethernet controllers which are
now LAG ports. Only 2 things change:
- the LAG device has a dev->dsa_ptr which marks it as a DSA conduit
- dsa_port_to_conduit(user port) finds the LAG and not the physical
  conduit, because of the dp->cpu_port_in_lag bit being set.

When the LAG device is destroyed, dsa_tree_migrate_ports_from_lag_conduit()
is called and this is where dsa_tree_find_first_conduit() kicks in.

This is the logical mistake and the reason why introducing code in one
patch and using it from another is bad practice. I didn't realize that I
don't have to call of_find_net_device_by_node() again; the cpu_dp->conduit
association was never undone, and is still available for direct (re)use.
There's only one concern - maybe the conduit disappeared in the
meantime, but the netdev_hold() call we made during dsa_port_parse_cpu()
(see previous change) ensures that this was not the case.

Therefore, fixing the code means reimplementing it in the simplest way.

I am blaming the time of use, since this is what "git blame" would show
if we were to monitor for the conduit's kobject's refcount remaining
elevated instead of being freed.

Tested on the NXP LS1028A, using the steps from
Documentation/networking/dsa/configuration.rst section "Affinity of user
ports to CPU ports", followed by (extra prints added by me):

$ ip link del bond0
mscc_felix 0000:00:00.5 swp3: Link is Down
bond0 (unregistering): (slave eno2): Releasing backup interface
fsl_enetc 0000:00:00.2 eno2: Link is Down
mscc_felix 0000:00:00.5 swp0: bond0 disappeared, migrating to eno2
mscc_felix 0000:00:00.5 swp1: bond0 disappeared, migrating to eno2
mscc_felix 0000:00:00.5 swp2: bond0 disappeared, migrating to eno2
mscc_felix 0000:00:00.5 swp3: bond0 disappeared, migrating to eno2

Fixes: acc43b7bf52a ("net: dsa: allow masters to join a LAG")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: none

 net/dsa/dsa.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 50b3fceb5c04..99ede37698ac 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -367,16 +367,10 @@ static struct dsa_port *dsa_tree_find_first_cpu(struct dsa_switch_tree *dst)
 
 struct net_device *dsa_tree_find_first_conduit(struct dsa_switch_tree *dst)
 {
-	struct device_node *ethernet;
-	struct net_device *conduit;
 	struct dsa_port *cpu_dp;
 
 	cpu_dp = dsa_tree_find_first_cpu(dst);
-	ethernet = of_parse_phandle(cpu_dp->dn, "ethernet", 0);
-	conduit = of_find_net_device_by_node(ethernet);
-	of_node_put(ethernet);
-
-	return conduit;
+	return cpu_dp->conduit;
 }
 
 /* Assign the default CPU port (the first one in the tree) to all ports of the
-- 
2.43.0


