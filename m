Return-Path: <netdev+bounces-222205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 836D6B53801
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 17:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360365A4103
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 15:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BD7345752;
	Thu, 11 Sep 2025 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LVdOkP5e"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE9D20FA9C;
	Thu, 11 Sep 2025 15:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757605274; cv=fail; b=kiN7GF60UmeMaPpctiq+dIK8o2tGb15ec1Fdt622hO4Ty3dJiGZwivZwoZ1QrEciBToptkpWF68ZKahMgTNLwRPHjclzJ/1BvLk8gN9bSZg2h284LEGD91xZnxG9+GRLZQwdu9ZJBtN+QDh2kbi/PnCL52546FjPu+w9/+icnS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757605274; c=relaxed/simple;
	bh=5VuiKf7uePYlLDouK/jnTDbHJ9r3O7RBP6vsfDpi2bk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g4SjeO4lLLMWqnF2GazgnXZ2tUV6mIN7e4AWgEkfP+AE8L6H+kK05rgmqFTypPUjqYXqxzpiX1Ia0BhVQsOA2ig05qnaPZl/nGVif/21HyqGmel9P7BY/L8hgGKgfouY4I9fy493rHRgKbw33YepHdCVFERfCccnTpH5WumNvwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LVdOkP5e; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hdK3xjycymp6FF2LcZGUm7DEAZJAIAEOvFH1b9xjmegyJI9bVpe+UyiKHSTviVjtMIagMjsoprKAQIFxLdTP04lO/OSE4vbE5Iw8wAeSiX32jInqXOlWuY/OEX4l/dhej0A25tf8Kq+tzNsi4iPQdWWECmWhGCj7/7QKeKTbyGoe4XeocE8LCL0RUIqzQCoVQGqsAxrO8iO+sKyxwnGmpOn919/jhhCX7q0LtRd7by50qF7Ka8FrSluXJEve5K9305dJqDsc1VsZmuKQDYHl4OAjIxrHT5RjpqrO/5M6L5rMuy9BZnlRPWRs4c15TVNOCrq65fIvsQ4hdqspl08HBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/dzKFu5pmjAxFlzqXJLKewgA12KlzEgFjQwFQ8tSR8=;
 b=G3qESmR9R9lHnRkjZx28oDvehRqmxEzJ27+cHzrjt5OtkXWhrFfPh+RdKm4DOc9hZivxsuJhVDwa48YHeT7dHoi6R/+D71CbwS9eRf3p+lskhv2Lrp3CSsfia6zoRGTmmqb6i2Lwp2k4PfXWlolCDjGBqpTKsUxVsAi6B1CexVF5jVUfM18FPou9wb2wW5kVZnyYoDurGpI5BbCHqLGJML9Q5fyx4QsXw+emm0QAuMoarX1ZRAlC20a72D4KAQwFOh2n5fVqwzac0P8/i+Of/TSaHAKwnZR/JhLRoT+kyV5Iy2c8A171ypfcY7EXqueFItwFb9cUHLofmMDfU+TgWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/dzKFu5pmjAxFlzqXJLKewgA12KlzEgFjQwFQ8tSR8=;
 b=LVdOkP5eo6BMp0E/7XDJy8SIFAgEOs4q6vq42xZ2PdbOtQn1DfTJWqYkIg7YGg1piR43WrkTT/UtPZG+8ZihDEIcJ8OaXEnpOzcXfI2GBfNn5gQ3MkuW/gjdBQ3ZjyZaLI9f0D7f1OcKUAKvfanYBUqoL2VwW/vuRfMiVj2iijQ=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by PH7PR12MB6979.namprd12.prod.outlook.com (2603:10b6:510:1b9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 15:41:06 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%6]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 15:41:06 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: "Gupta, Suraj" <Suraj.Gupta2@amd.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "Simek, Michal"
	<michal.simek@amd.com>, "sean.anderson@linux.dev" <sean.anderson@linux.dev>,
	"horms@kernel.org" <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Katakam, Harini" <harini.katakam@amd.com>
Subject: RE: [PATCH net-next 1/2] net: xilinx: axienet: Fix kernel-doc warning
 for axienet_free_tx_chain return value
Thread-Topic: [PATCH net-next 1/2] net: xilinx: axienet: Fix kernel-doc
 warning for axienet_free_tx_chain return value
Thread-Index: AQHcIu3ACEM8+K2X/UGMrGFnoxpALLSOHqhg
Date: Thu, 11 Sep 2025 15:41:06 +0000
Message-ID:
 <MN0PR12MB59534339999B93E3C8D25E90B709A@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20250911072815.3119843-1-suraj.gupta2@amd.com>
 <20250911072815.3119843-2-suraj.gupta2@amd.com>
In-Reply-To: <20250911072815.3119843-2-suraj.gupta2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-11T15:39:37.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|PH7PR12MB6979:EE_
x-ms-office365-filtering-correlation-id: f29b3066-2115-4f9c-9e1f-08ddf1499f91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|7053199007|38070700021|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?awEixjLY2IxIeHVMt8GBrrAoK1Z14N7aOa2vNpfSHC22bV4n0iqIgR7HqdQ0?=
 =?us-ascii?Q?TNdhHWWl5YgQeFcIPKuNeuGoqkvuKxeVCbtpueKEbOPdN8kuW3AWbmhvqa/W?=
 =?us-ascii?Q?mOGsAl/gxj2SannDgjsGh5iTde1/0tIk8bknJK4hE3g/QnCpz01Yaeuo8PDG?=
 =?us-ascii?Q?W9QK9Nq5NrbxPtXXPockwIA6ilUZfdpsjPkbR7IIQNGUGJ0mJr4JMXshL4g3?=
 =?us-ascii?Q?gdm6o4UJSKFdBPciDyoCDhgym1MXJISoTOjQN9daAzXOYP4qb6L2IvJOZ2BL?=
 =?us-ascii?Q?7S7Cdk0BWkMucGzgYMTQ5fYZpJH+JTDielQALhgJXhJsR4LRu/dVSqGp9bTj?=
 =?us-ascii?Q?ObIYkO9Eb6rsXs1pnJ4Bmu3eT9im2KpF88xpjdHpO2mhj3gGKkXvZdGHigWv?=
 =?us-ascii?Q?+qahwHS1NVIUexw1kJTXB2lbqGBBLOQCD6q3jsykU2rlwranJGuNHHrFmHCJ?=
 =?us-ascii?Q?84E+Po8Y9mwNXvjD8JbCzvohwtr9kZDovD8xRt4oS7LMtK4uHWNnt4f7mp7D?=
 =?us-ascii?Q?NyqLuaaoCm4UGY3jGpv++nVWX2k9CmsmpSW1POQh1/tVd7YB/AnLGS7U/dSh?=
 =?us-ascii?Q?Gh1RSuPX8RqYYtvjeOL7P9yUMMphSbY5SsZUt4D7itB5XZyUHkfeCzBTa3V8?=
 =?us-ascii?Q?GnsYUsUulIzwwhRlzkfMoDDQImxYtYQZ+5ANSApAFrmSbb8XjGcDXnUS/RIL?=
 =?us-ascii?Q?+NWsMBchk/jLmT5Lql+XZHU6RLcrtZEpXGMQ142rMBbJ6KqAn+VsGTaDlK2R?=
 =?us-ascii?Q?yr1k0tSt2wHhMr3zMG9AEW+H9LwKnFGXApJ9VC1RKfX4p/8jLEHWqwrB5Pyi?=
 =?us-ascii?Q?x3SEU4TFkrJKNC9clTCSWbHUFv4o4m1uM1jcuLsNhiREzK82Jl0lXy956aWN?=
 =?us-ascii?Q?OwqjuW5+hRJ45aYh2wRzRq0WOXpwlPUbV7+DPOuFnYL+hkb8gt+pHkwcM//5?=
 =?us-ascii?Q?5L8O0m4f1z1QPxTNcIRgh2XUZS1yd2V3OW5JtHbFHrS80rLnIJYnctpiBGpk?=
 =?us-ascii?Q?5IAty7eJDoPHRomqHCN67X95GTOnAu8h3B0qwpQS8UuBr+Hm5kJSoV28u9cm?=
 =?us-ascii?Q?L3/aaMz2elLqxAGGR0j5iv4zD8fuV+qYNn6kpsJMt+GguQ/Sx15DAgbI/tLT?=
 =?us-ascii?Q?H7+DBNaYkt8w1bDtcTWK22pv5rGvi7Zv+WB7IJu3suSePEhrIJpxXkETn1js?=
 =?us-ascii?Q?hBi0f8cDxrgCyofzpEj1xeELROY10hkAs/736cfSYeEDdmFOiqJiklCJMnNh?=
 =?us-ascii?Q?EfAJgdUolESpH4Be7xl5rWmO5Q/x896IO3aUzJ4THUF4LIihGYhsAVsMPgMh?=
 =?us-ascii?Q?Xo2N/KU2jXILkEy/uVIaiJfw7PK5zcaC+cILgGUCDVnP916AbnElGxf5sgwm?=
 =?us-ascii?Q?le2UI9+uzHrkpiOAGnQFSf+ExB8wWIGVzHywOCOdVnj2d6QMcfOveR6ksReZ?=
 =?us-ascii?Q?D38P2F3AoIolUKdsVI8/gPpNJkxQPQLMYLm/SeOnK34UEBSckX5tMvV9fdrS?=
 =?us-ascii?Q?zKKeUVgId9TL1nw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(7053199007)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+idUZuHSXpDbZ+vYsU6L0og4Q2G/wio0WrlUAru1twC1B6lr+NRACVJNXCjt?=
 =?us-ascii?Q?YyyfHVqceiAo3O8YCtIoTLtoS0p77FGBKQ/RF4DdDgRujv9Ig5bsWOffxLrw?=
 =?us-ascii?Q?vDdRwF+3A/m4EQYckhZvZ70Y0+ShmL1bCbw6p/GODTxaQ4Q4EwUrMau7pk2W?=
 =?us-ascii?Q?HQI08X6l/0rJ5A30VHC/Z6uqg2wfLC7rrCovQYlHzAgLYjZUe20yIMus/RVW?=
 =?us-ascii?Q?rWEDl7v35RfnYLYrvG1ElFe6fKZYyhHVY9dXNMq0VNK+vYd//QiNb2TVyyNB?=
 =?us-ascii?Q?h2iMiVzFUIk+F5co7uP+epmW7PD9X59QFzc2ssepbyQ1PxVQtHIeyySEAweH?=
 =?us-ascii?Q?ZE0QepkGUjDPwi34Fg8bkVDA6wv6zXIDlm3rb1Sn5/xo7cJ+lQ5AgqabDQGT?=
 =?us-ascii?Q?f8jSy/GLfVUbNo2CMq8XuZwUNBFy69oLZhNEj3yHK/gvNH33F1M8SrVGdShg?=
 =?us-ascii?Q?oVvP0OxsEpQj3zcVt+i3iickQWC+AIrFduH8m+u3BKFCNSP7IYM5p04y9Xtf?=
 =?us-ascii?Q?3ViaTv1WIM0swu9CeDyke0KLd2y/WPfNAs7SFHhPTNvC9TDHkxOCerXsjVik?=
 =?us-ascii?Q?8vP63lnvp7y/2oYMz+iO79doteLyORaMSKCZkBwMyws4Y3bzBckzbTCBYlsH?=
 =?us-ascii?Q?oyoNxRSIC7rbxePTUsSUBaM7hCu61A6vULHmNYcRjKTjsvX7KsRYFGXoytJr?=
 =?us-ascii?Q?Jiqc9ZmrSJYC7Aqn+gNi7RuXGdAbmpwVzg+Y9Q1CrsvBxFE+ZUG0l1X30nyN?=
 =?us-ascii?Q?T4cx/dq8lpZkiClQSdT9/blMoIGA9VRDnbx3f34bkwjP5AywP2UXB7fGx857?=
 =?us-ascii?Q?N9ypJdLfVLuxw5fc0pwLR+CrfbUi3+Rn7DVnHKck9jti4hOrn7NZFH2zwwC8?=
 =?us-ascii?Q?asarbmIEt8eRp4h6Lb2p1NyGwd+IkKptWkjojNc1qJwyx6YYAIG0jOMgeXyT?=
 =?us-ascii?Q?DEfy5Lqkk9WC1YBJBHvS34j7LgWQ2M3vSWKb0XBbTbuDwOOqeKe3K77l2+5J?=
 =?us-ascii?Q?0YtREXExh0SGRQMt46R5ewdhLdKzLCZs4bZGdHhATjBTLKTXU4+Lw6fqvZIP?=
 =?us-ascii?Q?em9Ug1EtWx2ueiz8f3awy2Ei2UXK89nIbGTaN4xlsA4SQlU/UW3RwTgk3VNF?=
 =?us-ascii?Q?id4fG/8/SEnlmUaIhEhcpgALBFPuDGhf+2orx6askHm6swOvjebwRUG/6g2E?=
 =?us-ascii?Q?RR1Ne9JT2SNzXMnODDYVOguWK6nHMkYKBT9LQ2LxGfexeq1JrInn/TfjMJBK?=
 =?us-ascii?Q?1cuAhjNkeGBtzDRGsZSDsMmoLoN9qblvNKSbKHvyqX292NT8khP9wafd145v?=
 =?us-ascii?Q?fiU0fWG31prd3P2osaatTW6/jf696DF0U1g3NYgAgYbL+7huJrUZ62u7K5rH?=
 =?us-ascii?Q?cWP7ItTfjcsUMwDMoPJYPcKheFAqkZPlEIpH9uH/y4J6udWEse2ZqPWjah1j?=
 =?us-ascii?Q?x6o+ZfoZWEGCqJFeks4YewF5eCIzyPyhGEMpYwfDgaHnoad8LXOn2j93ouci?=
 =?us-ascii?Q?sTq9S9ugW81CrsduVd3CwjB5mSUWfe4J+NTfblrcTbqvewYDhZZcmdmResAW?=
 =?us-ascii?Q?X033LHRpKweHDdYk03w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29b3066-2115-4f9c-9e1f-08ddf1499f91
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 15:41:06.8185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bf7evDC5Z8yKx5xnl8VzT3k81NhE88hnpamhqGxHu/23rt/8sLWNYf2Jm59r3uZ/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6979

[Public]

> -----Original Message-----
> From: Suraj Gupta <suraj.gupta2@amd.com>
> Sent: Thursday, September 11, 2025 12:58 PM
> To: andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; Simek, Michal <michal.simek@amd.com>;
> sean.anderson@linux.dev; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>; horms@kernel.org
> Cc: netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; Katakam, Harini <harini.katakam@amd.com>
> Subject: [PATCH net-next 1/2] net: xilinx: axienet: Fix kernel-doc warnin=
g for
> axienet_free_tx_chain return value
>
> Add proper "Return:" section in axienet_free_tx_chain() description.
> The return value description was present in the function description but =
not in the
> standardized format.
> Move the return value description from the main description to a separate=
 "Return:"
> section to follow Linux kernel documentation standards.
>
> Fixes below kernel-doc warning:
> warning: No description found for return value of 'axienet_free_tx_chain'
>
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!
> ---
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index ec6d47dc984a..0cf776153508 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -773,7 +773,8 @@ static int axienet_device_reset(struct net_device *nd=
ev)
>   *
>   * Would either be called after a successful transmit operation, or afte=
r
>   * there was an error when setting up the chain.
> - * Returns the number of packets handled.
> + *
> + * Return: The number of packets handled.
>   */
>  static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
>                                int nr_bds, bool force, u32 *sizep, int bu=
dget)
> --
> 2.25.1


