Return-Path: <netdev+bounces-307367-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KYwyN0rbVWqmuQAAu9opvQ
	(envelope-from <netdev+bounces-307367-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 08:46:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C59F7519B9
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 08:46:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=kb7Hn0Yg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307367-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307367-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=outlook.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4813F302012B
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 06:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2463E0C46;
	Tue, 14 Jul 2026 06:46:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19013085.outbound.protection.outlook.com [52.103.14.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B717B3DD523;
	Tue, 14 Jul 2026 06:46:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784011591; cv=fail; b=suZXP7x4qPBwmgqA/rTnaXy5eYidodv3MHQkexm7UO7nIW5AHS2l4ixFn80Qx4TVWL5rVUbSgeBJ2j6nEbZGvCjabTJuvAxkwjmkpw3vxAUonaaZr+9nPiyciWpXSHQYADKryGbdpghDFtA9D+8qrNd6kC1V/l8NhAVVlo3RRYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784011591; c=relaxed/simple;
	bh=3KCsBimiV+FjxbSKQtREsy7HVC80cNgpGJlBRv8QWL8=;
	h=From:Date:Message-ID:To:Cc:Subject:Content-Type:MIME-Version; b=DfQN9SdLG/qQkXlQGEtr4r9o/n2EznL4mdTYvS1s7syieUG3SzUySsTJYGAmTOyY2bbH464W9Ltm8nRqXIqw0Skr+q+8Vxm7Urw4b+Zoi2iRh35NgWR68lvF9ICaBfaLuTZP1PghzvYIVvkIJ8OHkugpT/6O5QQBwK1I1ryzC/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kb7Hn0Yg; arc=fail smtp.client-ip=52.103.14.85
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/vx3m4xdNMc8eUJq29dYbAjSR9VW0DbPkCFqQoUH3uEQUiY7xRmtOdWgk8HBvkpm1EnF02/nF0oYe/QjU/Kgo2VD/bk9i/VuE1zR0EHrnGO6h5fbWH/T1630uAKWsXBxx2Kw2X+eKhFZTGzdBjmO+S58h04tgwbkitwBtjkLuJAFeQNXU9qFIz+m+6c4MaRwp15hQj9cB41Kuxkg9BR81r/V/B3uw2eLCsIF0QkxP6ExAZj1rse7dPWyKQAXkWOh9yUjZJu889BqN9LtFHslscgOkClQiH1Lr/I3LoSPDLzsRA3G7KTbQ8ra/lNxEbucAdWt0Otf1rlmZ3BPEPQ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AO9KgQgJP5qKxwIMh9Q4zFFF+GJEOKkD6+8w5uHL6Rs=;
 b=dOktV0H+25WPzLkR9ZOE3Yrhp87hPJQzv61S+Pm1Ord9EuPCTM0RPM7p1AfmNAy3RWHnEeQceXEcdvuHmMTCjxH7HxALcG+8XeCCHbIiEextb/j+mLNtaZgLl4734lvnzE4UkAPElLHBNEwpEMK1cEIvIgz4MkZtKyNyQLHI35pkQJiZWBv39yMEOSWq4CNH//9EiN9yX96Y/Mb04ucLEUpCmAEjuOfTnEghwelLaW7dtFDIGjmXFTqE8vUbIadpawZsEvo/WlpKpnitGIUAZ7/N+M+kcKHiUykCaOL5HDWlejXs4azRnmTqa1/gySTKZYwLvFsQYHLZT4WOi24a8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AO9KgQgJP5qKxwIMh9Q4zFFF+GJEOKkD6+8w5uHL6Rs=;
 b=kb7Hn0Yg5ol7ozsz44Edrt/ng5IPfNDyOXUGAl8WGU4hQxb0QS/K+xJdJgLeQNFVrxEp30XkCr6FBfFLYfKv8xu4BoIVjBplLGx6lOwyfgYDs0ArSVdUP4eFHaEcZZKnn6zQFJHYoX8OPJTu+ZGbvCmwvgRw6RYYz9MllkEhE3kTR0w9IFsa55YAJPu2MEK9rPs/6ZQrYqPvXsfrQ27S+yj+06ImZKsrhrLpWMr8QssBjIImi6NSojjxq4DfAcrHifnj+7sZhsVSEbaWrOp6poNZFOUqUMaH6Rm+V2Q6aRPG2MktX1qfeqgtgg6y5UW6vYwBQxacJw3YTs8H7CW0kw==
Received: from MN0PR19MB6091.namprd19.prod.outlook.com (2603:10b6:208:382::21)
 by CO1PR19MB4901.namprd19.prod.outlook.com (2603:10b6:303:f9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 06:46:26 +0000
Received: from MN0PR19MB6091.namprd19.prod.outlook.com
 ([fe80::af9a:4cc3:facf:9374]) by MN0PR19MB6091.namprd19.prod.outlook.com
 ([fe80::af9a:4cc3:facf:9374%5]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 06:46:26 +0000
From: Liu Changjie <liucj1228@outlook.com>
Date: Tue, 14 Jul 2026 14:46:20 +0800
Message-ID:
 <MN0PR19MB6091CD5A84D2DA5DACF434DAACF92@MN0PR19MB6091.namprd19.prod.outlook.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] net: phy: Add Maxio MAE0621A support
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0008.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:9::9)
 To MN0PR19MB6091.namprd19.prod.outlook.com (2603:10b6:208:382::21)
X-Microsoft-Original-Message-ID:
 <03b781d223194234bcf6e53df12880b4.1784011580644350.tspi3m-maxio-v1-cover@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR19MB6091:EE_|CO1PR19MB4901:EE_
X-MS-Office365-Filtering-Correlation-Id: 82b9d113-612e-4c08-63aa-08dee173a098
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|4140399003|12121999013|15080799012|5040399003|16041099003|37011999003|24021099003|23021999003|41001999006|19110799012|8060799015|26104999009|440099028|3412199025|40105399003|53005399003|3430499035;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SqTcaGw1AtjyxY6vL9z55n2yjZWlyI2eIpmG6tEuECLxu5TE0M/7XHWf3CLK?=
 =?us-ascii?Q?CSLzRpuw0WmGpLhVyWQQ2wmvfNaRlVqdstWSqQDJ9LurwN9WtlwKUKQPyJsL?=
 =?us-ascii?Q?HFwPkvjAbzC7xe1Zu12lDUj7aGlUNCckJNJ6iyA7C/B0RxblPem1OWayTqFG?=
 =?us-ascii?Q?DCrEAICoLuU0iAe6Fk7kXOiVv/i1GJAV8rJVG5UqrcPFgYivohwK68/s/EP/?=
 =?us-ascii?Q?DoKM3Mp+ezzVfM5CIofbSfXRR6qAT/DWDs5FJc5RVxnOR240AODeRMaeQijN?=
 =?us-ascii?Q?1gUh7eB9CyPuTADGlQjcUJMuU/fD9TFnNKURCm5v833AfWVq1RmgNQuwaVOs?=
 =?us-ascii?Q?rGIcYgC5jJapuPf6PUxovPhynquSCXW4K6emJaOVQjheKayPlUGE8yt/4X4U?=
 =?us-ascii?Q?S7YfYkfOn2HRHvEMzkv0kVzDOFFjAOB/kqfhIsmzIBTYwnEa4jcFlw1mRsP9?=
 =?us-ascii?Q?eAdSo3B2oKQ2/N0i4i8uk/UOaxYFtGL4TkKlWsYdrP0foaSNQK7u2B/lQqKZ?=
 =?us-ascii?Q?0hDJHxRi8r6J8BGykc/LjLMp9vSyQjwetEP1VaeDz7HEolFvp0X0LvU1a0iF?=
 =?us-ascii?Q?JKSU0OAp8ID4tx2mSAE6UBt0+f9BpprpWiueZVAofDCnnxjE8klG2NV3HgNv?=
 =?us-ascii?Q?pVGvz2f2zQV8+ZSP9vSZ3LM9yP3O66VgSiaaqGJkNCLE9qbL4pU3lwLo6so/?=
 =?us-ascii?Q?UqGFF5xO9R7LIxOMn7wWOf355dyv/gFxVkXOUMydMJvygneZgq7ry2lB/eaI?=
 =?us-ascii?Q?qxocNLFOBpJHHIKeUgpjxiWhkVHFA2enV5LC5Hgmk2PGLhH1URBU6zWbFv0s?=
 =?us-ascii?Q?kaw5Mp8nhXjliHLATpyVSB7Zaej8sRK80u6wac7ZAA67cpH2GsxyUMKyROh6?=
 =?us-ascii?Q?6zj5UNA4suxSSrxMfBrxJ7efkEdQ6e7Lsslrflr5g9BUnaUXN+D1lnGQUY2O?=
 =?us-ascii?Q?3CDRZ3NiW/GFc77WXwUbWOqGPulDq1ifoXlXG0ygoyZo5GOVRQRWg7QU/gCM?=
 =?us-ascii?Q?C06CJwdKVBAFVIWdOwAfa3fYmZufh4lcXKFvdIJ7BgCFGOjPXpXG9KsKkS9W?=
 =?us-ascii?Q?vzzW886Q?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?POJZuhfha2dLdMXFM2v6/RH+MzgjJy1JGYibHV21q3BibDW5UOM/Lkc0e6LW?=
 =?us-ascii?Q?5WFWwNboK7s1v7rTRH7SngGdwkRZHZ2ZLb6uW17kIO848q/FkN16cpeLvlZv?=
 =?us-ascii?Q?iuHaF8vl4AYjiN+Mv3aqLGzV377CFHiAjhbd/IePaPu/NiKHRZbh0x8HzAqg?=
 =?us-ascii?Q?akwAumgWhWXOxgunqynhQ88w/VrCpsq198iv/DMzIQG9b+tiMzEr/JX930By?=
 =?us-ascii?Q?9zH2TqbZ3IWzVtwp2NVc3brO7Dqrrm9teGHUQYuk8Ma0RsCrEo4/M+E0iOO4?=
 =?us-ascii?Q?mhnkpLdbzmre12WFVsBe2euC7Re8iBpvYsmSe6f+gdzvqmfc+gkm/RcRsgL4?=
 =?us-ascii?Q?lvUrNQGRtnSqHYky9bv4wThLyUGJqcGRJnoj0El2QWbTr4y1Rvd8euTSEcOt?=
 =?us-ascii?Q?ZWKlCHesxlnW0iSxh5si/640DCSZ/oaDEwYgxQzR2mzo/ICXMMX67ljp60pq?=
 =?us-ascii?Q?nP4nj0ub6ikoqziz4cbGlANQVIG5iAOl+Lz5MdaBRUw8/AO5x6jxvllDO0QJ?=
 =?us-ascii?Q?Pth0iV366TexdCDMde2axn9V5sWvMYic8c2oZ0Ou0D83Z8hrX6PWUks0LNAL?=
 =?us-ascii?Q?i0ZWsIh8+szm5Zj9HADxo2tiGJks0pcnR3LaUJBYAVZ8r4OpyVoEh1DxgQic?=
 =?us-ascii?Q?PvocryuNHy8Ovu+ZN07i99Q7ydMdJSHsHwttKWPIM4RcLsKb0Z6KZRFS4Elq?=
 =?us-ascii?Q?Mz5JLJwBD9FIm5hdKSZGLKe5Q+/K5TyEE/LPTRg47rnkzAbj4pKur1ZZVcGC?=
 =?us-ascii?Q?dUgI3QKq1idfrmtJiIYkLGZnpt+dTR875M0i0HuqFgsE7eiiS5R/a4lydn6A?=
 =?us-ascii?Q?LGAigAGGahDCqT/5HiA6eXzNYRysH0ghwBZzTy7ifV/iCL5Y2KEoDL1F9Vk2?=
 =?us-ascii?Q?iBvse+Wc3eoJMy9UQEGF8H99LTCo2uU+vNKNZctKvziCL87gW8i0YQ6jlKsy?=
 =?us-ascii?Q?js8+HjXUhM79m4B5opltYtQWd/PLva+7vUs0uG5T0q0zuwR4xyDdZbHsSdod?=
 =?us-ascii?Q?Cov9nCXlfAjuqaY+USXAa+HpL/miA4mpmnamOmcjgq+8JJtnEJ1EIK9qV/oU?=
 =?us-ascii?Q?pLI+YUUPyxWDBN4j0vmV8kA8vIk5w/294ZVaDUG4XOYn8Xl6ztUSnUzp50Cr?=
 =?us-ascii?Q?qsyR2LoSK/wCm3gFUHWXuepQtb3gTSxRM9+D9T8aL4KcAPwYWIs+Bra0Z35o?=
 =?us-ascii?Q?rsG+cPlPCZ5HjxeM3UTFoLW8PY5u881KSUZqcLCUXuupajvyE24fZThoCpTr?=
 =?us-ascii?Q?GV77tiJ51vME15PTdYU5/0IzREKc+fsSeORMlSo9ZOM5g9Z+Uu3kflIMdfsw?=
 =?us-ascii?Q?V+MxAZyLeJEIrj60zzQujiq4l0yTRqVQDH0gfLFtyr+m1CffmeZu076TcoWU?=
 =?us-ascii?Q?1Vh/kxBADXKlQ0l7ESOwKwxYDRXSpj5YO04zhdYFIfwEtwNVzA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b9d113-612e-4c08-63aa-08dee173a098
X-MS-Exchange-CrossTenant-AuthSource: MN0PR19MB6091.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 06:46:26.6907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR19MB4901
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307367-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[outlook.com];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux@armlinux.org.uk,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[liucj1228@outlook.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liucj1228@outlook.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,outlook.com:from_mime,outlook.com:dkim,MN0PR19MB6091.namprd19.prod.outlook.com:mid,checkpatch.pl:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C59F7519B9

Add a binding and PHY driver for the Maxio MAE0621A Gigabit Ethernet
PHY. The driver matches the exact PHY ID and optionally selects a
125 MHz clock on CLKOUT. When the property is absent, the driver
preserves the hardware strap or bootloader setting.

This was tested on the LCKFB Taishan Pi 3M. With the PHY's default
CLKOUT configuration, the RK3576 GMAC negotiated a 1 Gbit/s link but
the data path did not work. A read-modify-write of page 0xa43,
register 0x19, setting bits 0 and 11 produced a readback value of
0x0823 and restored the data path without changing the RGMII delays.
The readback also confirmed that the unrelated set bits were
preserved.

Only the 125 MHz setting has been exercised on hardware and only that
value is exposed by this series. The 0 and 25 MHz choices from the
initial draft have been removed.

Public documentation for the MAE0621A register is not available. The
exact definitions of page 0xa43, register 0x19 bits 0 and 11, their
reset defaults, and whether a soft reset is required after changing
them still need confirmation from Maxio. The register programming in
this series is therefore supported by the hardware A/B result, not by
a public datasheet citation.

Hardware tests with the 125 MHz setting:
- 1 Gbit/s, full duplex link negotiation
- 100 ICMP packets in each direction with no loss
- 936/934 Mbit/s host-to-board iperf3, no retransmits
- 943/941 Mbit/s board-to-host iperf3, no retransmits
- link unplug/replug and a normal reboot, followed by another 100 ICMP
  packets in each direction with no loss
- no RX errors, missed packets, carrier errors or collisions

Static tests on net-next commit f6f3b36c15ed:
- dt_binding_check with dtschema 2026.6
- W=1 arm64 defconfig build of drivers/net/phy/maxio.o with GCC 10.3
- W=1 arm64 allmodconfig build of drivers/net/phy/maxio.o with GCC 10.3
- git diff --check and checkpatch.pl

Liu Changjie (2):
  dt-bindings: net: Add Maxio MAE0621A PHY
  net: phy: Add support for the Maxio MAE0621A

 .../bindings/net/maxio,mae0621a.yaml          |  38 +++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/net/phy/Kconfig                       |   8 ++
 drivers/net/phy/Makefile                      |   1 +
 drivers/net/phy/maxio.c                       | 103 ++++++++++++++++++
 5 files changed, 152 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/maxio,mae0621a.yaml
 create mode 100644 drivers/net/phy/maxio.c


base-commit: f6f3b36c15ed44de1fbb44e645e4fae8c4a4453e
-- 
2.55.0

