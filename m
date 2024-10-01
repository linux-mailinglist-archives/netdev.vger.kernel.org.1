Return-Path: <netdev+bounces-130905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB19698BECF
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 16:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 563F1281F3E
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AE61C243B;
	Tue,  1 Oct 2024 14:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b7H7T/uk"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011043.outbound.protection.outlook.com [52.101.70.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DF228F4;
	Tue,  1 Oct 2024 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791352; cv=fail; b=n5D2a0WwrgGQtU/nI6bsDu8hSbrulmoH5ww8utP/37xZwoUILW47G3XeqYSVgW52K7nI9zMtqfBGey1A5QlQJ8cgDgfHyTRVx+Amr26s8xaNpyO8v2B4AZcB2DrXMZ3wr2e+mDX8EGVl2Pjme6zqMTaWA00QWGDsdmDSs0Dail0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791352; c=relaxed/simple;
	bh=YhRHfZ55OKgxvk2HYG39We7O7AFr4I/I8uG5Pmp6U3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YpNzbh1mAbuqq06eB7vnkKF1sKN02Huj4A+mmTmoGetC1l4GLZaz78b00Uup294ozr+Srz0jkAvebC8r1zFKu8m/ESarG37Xks5CBOFsMJwkk9Ziq8Gbh33NFGvhSjg3GI6M7jt6LnpNP1yPjJTbRjDATh93BzNXkl0g2nBXuzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b7H7T/uk; arc=fail smtp.client-ip=52.101.70.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ww36jA7m8VLC4NioobBfAlngiOBau1qOD/jpt8ZiDJaC/LlXoEWQwUPC6oYuYbVZJg5qgvPs5UAuOyNbKJVXX0DrIVVolTXN3LabmGhB6641Xan4y40RLsGuRKQBJ33O5ktdlC9sWAqf0Qh9TOKlUXCDPSrTQZ2AGOFBdHGBcbBE0s2IoDwBP30UtAuxLyA7Tn1+ilst0SGqlpttkygFt5H+lwxPSkL4V330A7ZyOOiVllUEmxv+5lr0IfwPhQT+HNBugO6mMcBawZn4/ICxDu8yD+ar+4z8FZIqPszqjQnIZb+J3F65lwV9Pae8r5eEmTkYSlW8hdRnS6hCI36tWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cS0wPm3raaus2TWqKlY36hHWRj6/hX868KknPYFnyd8=;
 b=axpn0MoTH4O7UWe76eNTeHKxu2xb+Rmmqj4svUJOxUcn08wGrBkDqtZGc5rE4JWLw9T7oVvvBmglQ+irwUJA6hnowSWQqYDZ5yymPjuWo2X/hzkYmh33RCB0LInFxU2QhHtuObkWChM0ipgPNnCNTa7fHfUMctkxtnejBFDrhPmtHRzvT7by7rfbkdjzuGsMonm3bd4Xk5CXbqS0hL5VacPd0QkL9l+fFT0OZA80gl2cWQFUioqazz7n5NzXpLq24ZNZ+I26+6RvKZXFsRNAihiFcGWnIO8Ochmmm7sVSOMU+JXVL7FiVOGKikS7Gu3oaPH1Zm/PZVzEYJOLMBw2uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cS0wPm3raaus2TWqKlY36hHWRj6/hX868KknPYFnyd8=;
 b=b7H7T/uk1ULfvOiC5Jg/tX6RxnizqXWMS2VizChOBQLKGqQ0A4eh46Dnklx1XpNqxu/7Rk3D51TyllHCYPBMwSSTWMKJT1GrulfPNHKb32MU2W4pWzQWsAPtLkprx3EFdJvKnXJRN4TrR5hriYcWQm80BbQZxj+9RZSVG1DbP5uKUmi/B87PFi0qymjgfAc0fDD5Akpuv+MHiO0TBAOivJCddia/XtAsfnXaxgziVifsRQIb24/ArJTpHZjSorF4J6RdGBc2+rOFcveOyz05iRUujaos14udbRIXKmrqpqJg+f8M/5uebjHTojt5rP5M5eD2RLK2x3okp0pzlL9VoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VE1PR04MB7213.eurprd04.prod.outlook.com (2603:10a6:800:1b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Tue, 1 Oct
 2024 14:02:19 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7982.033; Tue, 1 Oct 2024
 14:02:19 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dsa: sja1105: fix reception from VLAN-unaware bridges
Date: Tue,  1 Oct 2024 17:02:06 +0300
Message-ID: <20241001140206.50933-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0202CA0004.eurprd02.prod.outlook.com
 (2603:10a6:803:14::17) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VE1PR04MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: d4a17c6f-0e0b-446b-3348-08dce221a9f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L3dF0sgHpenK6+k4+tqhIQGNYP1+ELqUFPO30uSOOgv+anJULarYSrhYhVW8?=
 =?us-ascii?Q?/6GaOPL+wwG2nHsFX8kC4Kw3u+XiR4EqMLJfaTLzYE0reVRZog8ctOyjtRrN?=
 =?us-ascii?Q?reJUMPKUkF9rG2MTWCr4t5zwVgfEHc3NarSLAakOywJkhSQ0G4RJ5WAN+t+c?=
 =?us-ascii?Q?+VV8xZQPGGwvFY9TOqum0xylCYBy4hgLSMjBQ3ar95hWOBcxolHPZspXB98l?=
 =?us-ascii?Q?MpdgTup1FUnyts+1Wkfk9qsEnKbJngDRf0uFS5/Cb5E/2/IDUt/xvW/ExtMC?=
 =?us-ascii?Q?l6hj0DQ29DoCTOviEsva03wgKTc0L+JtR1rizcKn1XyzXmK7cDIaBIn1hZ9m?=
 =?us-ascii?Q?j3tEuZDgL6bETwQgcl98Bq0oMNfIR56oH9IM/G6foOf4jHhsA6W/T/F0k9aj?=
 =?us-ascii?Q?GhBAphYNMyvfj//EXsy6r9+aDa2aWqA9bWPDqHyvaAq6W85cIUfK6ClRdvLq?=
 =?us-ascii?Q?6RS1tLi/qpS2jGMfKAGOnwyTGPUExszs//X3KwIv99UILKAq5ti37V4JDxDt?=
 =?us-ascii?Q?fbI5k1xwZISKyXhTEQj+dIGfgEa+X8z5yGqTvUGkW0DGhwOqyQUJpeDWM9Ma?=
 =?us-ascii?Q?Tu+IqCQjgpbNy1LorqW+vXSHbnr60erJkpk2qNeoVVbCq9+YBa2UiDuHa6Zq?=
 =?us-ascii?Q?JYwb9EMh/f3YVC3FZMx3NlIBuQW7CwvO9JPMk2jPElBJXgBg+Je09qGK89vK?=
 =?us-ascii?Q?bGFPbLtl4HRuhRl7KuigW0og20otklQXD9ybsvmbIFlAFk06ZHr0I9bgZ5Cm?=
 =?us-ascii?Q?c1JvrrP1AyJeNXyNgvm4LkahH9qi/tdJo5n7+qEjyraZS5sJnZoyvMGLhZiR?=
 =?us-ascii?Q?SMwVBQJvM59VzUIRQ4rwt+lJShlKnvWA4PmgDqKwxsz2JeF+/kax2IjbYRRz?=
 =?us-ascii?Q?JuAgyHxJ85HUA2mZ6dqCTEQaXsEH5tbapjzPftSw9Jp5f6fo+kmYGCxsc/P7?=
 =?us-ascii?Q?Kx3d0QYirNK1FvcXx0A8Q7AG1Wh2X13N94dK6nJUfsVGmI4DRlJE6s+Fkfh8?=
 =?us-ascii?Q?TLdo3QX8/FwMT6gD/ao87UZESTZrVarN8lnvgugqjRt1RfvCwtERzKoLJA3F?=
 =?us-ascii?Q?hD5JC/fxJeK8eq81AhYeTOhwp2f8FDcWYA7649TYpaMsJ9w6UAVWEzpgrvkg?=
 =?us-ascii?Q?nzi6z8o4Hy8JUoyMVWpb/AiCe4opmLzdc85E3rwD2bN5yJH3J4KAaisDQrPD?=
 =?us-ascii?Q?rQ71NjC/gtsvAYRHUW7y/TGB2bKeMnNhGWrHyHZ70r4RaPZYyt2SPxVM/FxP?=
 =?us-ascii?Q?zW7QBWnmP9lEcq+na2HLC4Ni9XkTZu7PQZK2LKUNF5ACJ1i94FLvSq7AfLTn?=
 =?us-ascii?Q?BvNybNVy576crBKdRR/+dtm+EhMIfGDEq10GTR1TeVKNyQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ctSZGJWVpyhrRcxooXC6SjBb21AqfpJqWOwTcif8Dl9iwB60ifmndsdBDXVG?=
 =?us-ascii?Q?0FI23sippS0QLiEyGU3H+Nyajf/2GWKZ16rttQGGEHTE+TWAJcFiyZvRF2sM?=
 =?us-ascii?Q?+ibRZhyXZUr9BDjsmTztiA2ZDXNCKJh0kP5dqEciqXbfumRkrwr9KgZPxvuY?=
 =?us-ascii?Q?i33/X6WI0k8bKwoyb6mLShKoYg6zq+sVatQVUUvuo9zOEXWjoEtMJvXQZr22?=
 =?us-ascii?Q?hv1ANu4he24+zbDIwOTLLnUFz032HEOUIg7IjvZp259FX99WksYk2/yCLCsb?=
 =?us-ascii?Q?uIPRYm+zEzm4eewLtSZO/wcjfv9A6AQlxMpy+8AmoR4BfD3ZUq7u38G/JMSh?=
 =?us-ascii?Q?r9IBGiw+XDp6hoR+rH1B/q6HJTrlAwAzD5C4c6JbVaJE3RWJn+Vv1nEHRANb?=
 =?us-ascii?Q?cddVB7krSvDUDD0tSg301rQ8BDntM9HU2TSGwDe2Ba7I40fVAeVQ5zPZX4at?=
 =?us-ascii?Q?qsy7CCdVrZjzlrXHQKEKXJEU7x0Vyaqcpq3AbVfJ25OFMtcVhyUmAR3VO9so?=
 =?us-ascii?Q?n/XiKEMFCfvokcGXCE+hsnoEzO/xBkS9J5inbcD25G5EGFhBd1IPEOyHJgJv?=
 =?us-ascii?Q?JXe7lnCHpQpRpWbk8lPaVxfhGw/lJDnRcR/E+WbtAcGciKl4Pwxc+k+AERYl?=
 =?us-ascii?Q?d6tjTFW7JfcI5Rpb/rZ3b2h7wIQOlUiQzLv7nIk1vWva61/32BGZc8zDaf71?=
 =?us-ascii?Q?pYgUEeIGT/ib2LPS40IFvqChRX5A/xRS3VabLTYLr0B+m0bhGQncc9S8hgz9?=
 =?us-ascii?Q?G0HpFJ5dsgWXMEzjMprfrgUN/dcuEcERuY8dKXJgn2m3KXc0zJ5WXJRypnQc?=
 =?us-ascii?Q?11hIf3ERcrGnVfMxoZe/APfy4zP/T5/MXw63ex8TlscDLmnCTbR8sQcq2CXS?=
 =?us-ascii?Q?hzKUbkhXKWJI+2IfayafKxzKV3lbi2VSD06J3OgdjxHp3XxYDamsgtxZqEUu?=
 =?us-ascii?Q?5LiUxshb/uQzWrLTHgkM7EKpNTuVvypxK/GdO/HUSEb2zAcJ31nc2PouYMeu?=
 =?us-ascii?Q?3HE+uv9XWwSSXka3qMUHKLxNeLgXgZjm7bl3Dn5jqbsxX3mf1alp1V7UIEV3?=
 =?us-ascii?Q?Unc0YgV5HtbfNjzAod4a7FIQjcSQ984HzkgekuZ1dxLrs9RMp33XIrrblCKz?=
 =?us-ascii?Q?3hUs8b1IDPr1nMOEfC1QJiyIM1wGb+2lRiTQto7++z8hhmWDSVGZDNFtF6TH?=
 =?us-ascii?Q?uCIld47lCXg4TCiSp7mSCVwNMXEy99Eh7mGPw062ltg4UxEQz7lrjaqGCjKq?=
 =?us-ascii?Q?0ptNOciop2TGrM4ODiBUIhE0AsVGjB0Vnrglm3zOfEiuWXvEUjjUKMcjgiPZ?=
 =?us-ascii?Q?ETPnMrMcI5dv1qLh4cbo5y/iSsQhoKQtK9SjmtKD+k+wU7aR0jChvMWMWrx7?=
 =?us-ascii?Q?KOCaf6g1jSx/9QikWsQrxVo0a9Q1A0HEUk8Q7LFymKWfyqGAtsSmFlUWL57A?=
 =?us-ascii?Q?AdzUHiCfkGIxXQzuTD7dgYFQHTQKtfSCMIo2E/WdmvFyQKrcSNMJEOrsZEu7?=
 =?us-ascii?Q?bgGdJfb0QWJpc+wQGyh6zv99F8xnMQNSRJKk8NaAOyJSVbNk0tFi7SjQf92g?=
 =?us-ascii?Q?I9UoNTI+UJDDITYMcSzQoSjix1qaXSspWLrH9SY+P/qlEKpGuDq61gAF7/Ni?=
 =?us-ascii?Q?EQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a17c6f-0e0b-446b-3348-08dce221a9f3
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 14:02:19.4702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qkUOAo7JuN5KZ00ftNBBmFxhPUeIC2venXTlFfb1p/vWyo9Q3G3e8pWu8WPs7gzqDSsc0RJs6MR57ckF6Q2zNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7213

The blamed commit introduced an unexpected regression in the sja1105
driver. Packets from VLAN-unaware bridge ports get received correctly,
but the protocol stack can't seem to decode them properly.

For ds->untag_bridge_pvid users (thus also sja1105), the blamed commit
did introduce a functional change: dsa_switch_rcv() used to call
dsa_untag_bridge_pvid(), which looked like this:

	err = br_vlan_get_proto(br, &proto);
	if (err)
		return skb;

	/* Move VLAN tag from data to hwaccel */
	if (!skb_vlan_tag_present(skb) && skb->protocol == htons(proto)) {
		skb = skb_vlan_untag(skb);
		if (!skb)
			return NULL;
	}

and now it calls dsa_software_vlan_untag() which has just this:

	/* Move VLAN tag from data to hwaccel */
	if (!skb_vlan_tag_present(skb)) {
		skb = skb_vlan_untag(skb);
		if (!skb)
			return NULL;
	}

thus lacks any skb->protocol == bridge VLAN protocol check. That check
is deferred until a later check for skb->vlan_proto (in the hwaccel area).

The new code is problematic because, for VLAN-untagged packets,
skb_vlan_untag() blindly takes the 4 bytes starting with the EtherType
and turns them into a hwaccel VLAN tag. This is what breaks the protocol
stack.

It would be tempting to "make it work as before" and only call
skb_vlan_untag() for those packets with the skb->protocol actually
representing a VLAN.

But the premise of the newly introduced dsa_software_vlan_untag() core
function is not wrong. Drivers set ds->untag_bridge_pvid or
ds->untag_vlan_aware_bridge_pvid presumably because they send all
traffic to the CPU reception path as VLAN-tagged. So why should we spend
any additional CPU cycles assuming that the packet may be VLAN-untagged?
And why does the sja1105 driver opt into ds->untag_bridge_pvid if it
doesn't always deliver packets to the CPU as VLAN-tagged?

The answer to the latter question is indeed more interesting: it doesn't
need to. This got done in commit 884be12f8566 ("net: dsa: sja1105: add
support for imprecise RX"), because I thought it would be needed, but I
didn't realize that it doesn't actually make a difference.

As explained in the commit message of the blamed patch, ds->untag_bridge_pvid
only makes a difference in the VLAN-untagged receive path of a bridge port.
However, in that operating mode, tag_sja1105.c makes use of VLAN tags
with the ETH_P_SJA1105 TPID, and it decodes and consumes these VLAN tags
as if they were DSA tags (aka tag_8021q operation). Even if commit
884be12f8566 ("net: dsa: sja1105: add support for imprecise RX") added
this logic in sja1105_bridge_vlan_add():

	/* Always install bridge VLANs as egress-tagged on the CPU port. */
	if (dsa_is_cpu_port(ds, port))
		flags = 0;

that was for _bridge_ VLANs, which are _not_ committed to hardware
in VLAN-unaware mode (aka the mode where ds->untag_bridge_pvid does
anything at all). Even prior to that change, the tag_8021q VLANs
were always installed as egress-tagged on the CPU port, see
dsa_switch_tag_8021q_vlan_add():

	u16 flags = 0; // egress-tagged, non-PVID

	if (dsa_port_is_user(dp))
		flags |= BRIDGE_VLAN_INFO_UNTAGGED |
			 BRIDGE_VLAN_INFO_PVID;

	err = dsa_port_do_tag_8021q_vlan_add(dp, info->vid,
					     flags);
	if (err)
		return err;

Whether the sja1105 driver needs the new flag, ds->untag_vlan_aware_bridge_pvid,
rather than ds->untag_bridge_pvid, is a separate discussion. To fix the
current bug in VLAN-unaware bridge mode, I would argue that the sja1105
driver should not request something it doesn't need, rather than
complicating the core DSA helper. Whereas before the blamed commit, this
setting was harmless, now it has caused breakage.

Fixes: 93e4649efa96 ("net: dsa: provide a software untagging function on RX for VLAN-aware bridges")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index bc7e50dcb57c..d0563ef59acf 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -3158,7 +3158,6 @@ static int sja1105_setup(struct dsa_switch *ds)
 	 * TPID is ETH_P_SJA1105, and the VLAN ID is the port pvid.
 	 */
 	ds->vlan_filtering_is_global = true;
-	ds->untag_bridge_pvid = true;
 	ds->fdb_isolation = true;
 	ds->max_num_bridges = DSA_TAG_8021Q_MAX_NUM_BRIDGES;
 
-- 
2.43.0


