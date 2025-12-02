Return-Path: <netdev+bounces-243249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 115AFC9C3D7
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 17:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2F563A1DEE
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 16:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0376728980A;
	Tue,  2 Dec 2025 16:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wqbf8w/2"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011062.outbound.protection.outlook.com [40.107.130.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088802848AA;
	Tue,  2 Dec 2025 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764693527; cv=fail; b=j5kWd2Qdn3WvodBRc09/fv+uty9khs7GnUBcuAUYM+z7QKOq8qMJiyaNZ2pxlyYsqUWvoXEFAnGAjCpjrcR0wZiHXJ5PTju74GHEj+FqQr2R0GQ1KzbwYF82pzNcmYzn7UR8KAwzq3lzMP8DKAKZukxCbHcEMkQ4qBVYTR65lnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764693527; c=relaxed/simple;
	bh=D3zW3HfJrUs+B+ZeXIkpOjjzrlXxTuXF69cr3g3O6Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aC3jh92g0NDyTXb3Q6s+Ia4stSOmJOGukSGpF/ZLTUuKvDpyo+QpgTypXDIb8RTSRlvYSkl160+S1Y5s0XjGsWH1mEtfjGMKZQE9aqScCw8z0lCe1FNodnTWwMr8n4ZZhlYSif9SXww2mULizJV6iwJON2hZZ45pO89vYQZQY08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wqbf8w/2; arc=fail smtp.client-ip=40.107.130.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qRDWSkpSXDym2A2uN9JAbkM9aP6jmmmqkHhXheSbe3UygZUp+hN4hzNNm1cILjeVKusXwRImxdTyiICkLzIE8Zkmwra3yVOcBbfR3Gc6VvXliefgAhjjfWIucCP1uVE0zITZHb9CVnVVvs+a1BZCxbBKaW6mvWKZzCqt0myTpVAtet2vBQ6sg/FUkwvHQPFdmJx3YbbUc8ecdDEoumXcWX4DLevUf0hG0c00KZAd+SVA/D8Z974tPbpMSQUuzLJ0lzEdvAhhegZCFg8b+0spyCWdpyhK6TDuDFRcVESoG7I4Wed2X2ON8dJ8UxPH/2wVkkrC44M+QeDwNyqE217jHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qwhOgso47QPRhCOirQ1VpDzP1OAdDukmFNSVEctJEc=;
 b=ersb3wuxHH+jDWftI1KjUI37Z0AzN4DtN//p4pOnw/xzMWagA90GyFAGuLhaNz8hiEBZ2NX4lbhtN/x9EdfSlWQZsEhDyTKio3PimUvRNn3ctBOEAisFRlHrvG//9Fc2tqh+vZXj8tAf6JeVtq22qtR/WFxLqXU5qGN65fB2FM7NI/yXt6iqsLT1krtFwz+m7S/TIXMUGVstL5ISagpQ+IDeqHKFmGyWoDWKNhdwTmHDBUdvRABa84vkB/cgkwirHLLp9PGRZCnHD1yKA5dWyUU1OZiNgi7o43MeR+z/YkB6eP0aodbu8OsVgTgYxAJb9VDc2+eto77rwR1hmg09MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qwhOgso47QPRhCOirQ1VpDzP1OAdDukmFNSVEctJEc=;
 b=Wqbf8w/25xuNi7X8v0lIyHgR8vrOVE3S/Oarx+b3+963nsMAcP1Om4TSBEpEQcytJJHQ7qqu8nJsW2uBDIFp7Zk84Bq7EDylva0oN/7XQfmLRkAJjF0y6lj6/Xlpmy4RKYXjbT8VtudVqSXuZHhmA6SAhO3wtytBTxrU5xQFfapcYmFSwE6UdvgMNr9Qedh8K6iCt65acDYtX3nzuFk6aYcsP0d8td8+A/vuSWev/15csb1/sW+fCCcScXZALO9jsdYq1BcSf3xtdlFZXM+9RfFFtW7zUnmvYjWDnamOW0n7jJyjsuVBpDcqVPRUoxcxrg0CDU0XDg3idP8f99oCSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8590.eurprd04.prod.outlook.com (2603:10a6:102:219::10)
 by GV2PR04MB11374.eurprd04.prod.outlook.com (2603:10a6:150:2a0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 16:38:41 +0000
Received: from PAXPR04MB8590.eurprd04.prod.outlook.com
 ([fe80::8cc7:661f:ab20:7d18]) by PAXPR04MB8590.eurprd04.prod.outlook.com
 ([fe80::8cc7:661f:ab20:7d18%2]) with mapi id 15.20.9388.003; Tue, 2 Dec 2025
 16:38:41 +0000
Date: Tue, 2 Dec 2025 18:38:37 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Ivan Galkin <ivan.galkin@axis.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Marek Vasut <marek.vasut@mailbox.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@axis.com
Subject: Re: [net-next PATCH] net: phy: RTL8211FVD: Restore disabling of
 PHY-mode EEE
Message-ID: <20251202163837.geymkous5dn76pgh@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202-phy_eee-v1-1-fe0bf6ab3df0@axis.com>
 <20251202-phy_eee-v1-1-fe0bf6ab3df0@axis.com>
X-ClientProxiedBy: VI1PR06CA0134.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::27) To PAXPR04MB8590.eurprd04.prod.outlook.com
 (2603:10a6:102:219::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8590:EE_|GV2PR04MB11374:EE_
X-MS-Office365-Filtering-Correlation-Id: e52de27d-a6c7-4fc5-4cf7-08de31c14032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|7416014|376014|10070799003|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SlGANtpQ7EBOOrjlvN58FyNPShxD988AVkGJKQlY3ipGE0iVO2g8qzX7cvLb?=
 =?us-ascii?Q?CKjxBw2a7yYq1iizfaxjp7vv8P8PK6hSxxYtWXn/HI658Nr6MUS0Wf6n9eu4?=
 =?us-ascii?Q?m10KnVkQxcEUM/B4gY4AAodWbGMTl6kqXjOP5HKo/fF1kJo3b7mY8C8igCJ8?=
 =?us-ascii?Q?6JWcXnOF8NIZaBNNZRKgIsF5frq4K1XvthXs3tGd85ZIA8WLUS6oYlqVjUdH?=
 =?us-ascii?Q?Z/XyUZAUPkng5RFkq0q3WwWPOVeuh9y7MqmH/X+MftmGVALAv/NF5aPhliIO?=
 =?us-ascii?Q?i1YRDNROQBhocvyBS6Kx651oJ/Yk520nYQiN5clPDYPmXUre3EpAxm/AIPel?=
 =?us-ascii?Q?EiEPXbK9AfsnoLmA2BxqmwZakmPbNT9sHOdiOp186jDhPO+UKi0cTZe0NcfW?=
 =?us-ascii?Q?u852Yql+oWwosOQn7zdBxIDgOyBZtvo2NfARODCs0KWW25xLJBywVgg+ph78?=
 =?us-ascii?Q?PyFX9B5v6D2PD1UWOeSKhb0UOaW/72THSPLVknkCFeWEDPkJ1QU7VPcg8Nzv?=
 =?us-ascii?Q?twUKNixSu3QG8VWIoLmpvn4k/DFIA3CrnbbSdEg/+PkR/klsAiw/rl/WKd4Y?=
 =?us-ascii?Q?FOJ/p2C0rEb8RJz2piyY+jwriP1Z3qAGhsRPb0hmisEmGrGXdH86ofFDAf4x?=
 =?us-ascii?Q?oSSVB2gNbL2hYqFe73uGvQJv1qFlpdDLQP/z11WnGWdQ0KIuLPYb1ZGb3i1h?=
 =?us-ascii?Q?1KzN0H2Ja+uiyD2SmNMBEseBuyovumF8ajfEqmS1Hkqcu2BmeraCfINyphlN?=
 =?us-ascii?Q?KZOf5OVrM93HIuXKgvYVsJV3AvrwZJ4Cbv0rL62vrP4WGwmwi6YWBadn3oe9?=
 =?us-ascii?Q?Xj9zfgOyKDsRxGAXr77HE8d1cO4QtByoxqCjWVP6rTQb7+DcpTocGzBPExgN?=
 =?us-ascii?Q?2sjECEQxZrTjOYTwd1m+Ml0pEpJWqzLTLz7BtHQkk52U5PzHy/Vc/PHCPYQ5?=
 =?us-ascii?Q?PC8a5E21taPrAwu8Msx5j9+P9hW072Lk/NQQzVVfZiyIm2hq/nq4uCvKDDI+?=
 =?us-ascii?Q?JeLihBnM1Cp0Dm1iu5RnwCU60z7QJq744cXTvqGAZC3WpLh778znLTtdFZyT?=
 =?us-ascii?Q?5YNjZce18VKFN3UZWqDit9eT65t+mAGlQrJ7j7TMs0whPhXEMf+NIR90OjWu?=
 =?us-ascii?Q?JI73kr6zldMBRiZ3MWdBY3K/y4wPQxQUQbiD8X9gZ58EYWjC8pOmxmBf8JGI?=
 =?us-ascii?Q?p4YZm1L4g5+tzFwTSGqr7w7M+0C8rfc4zyo6kwT6Bt5H5uFEIP5V94/D20H+?=
 =?us-ascii?Q?obzPTj0VAXTlUPGuihz947eDg+TUrCZr24Qz+tBBB6b2MIxlnGIfL2rRef48?=
 =?us-ascii?Q?84jdz36Bu7FNct+ZXDsEAaBwCmehbgY0IshN3S2gaiQLkQs49ISMosxtu5nF?=
 =?us-ascii?Q?aUre+PEV1K6DODBhzZw4oiYKBFxf9IdLsc2os0+WG47ua88NFQAcNBKcQBIc?=
 =?us-ascii?Q?726w/A9MfsvEHKDY0Tfq1CC1PAXKCzhm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8590.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(10070799003)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0bf0jDJNRCQmvPlyak9pgHohfRqsg6TJhUjTp6srt2L58jrDGYM0F//D6z1T?=
 =?us-ascii?Q?+JlnN9Uy2LObSVZIH7s8AYXqQHed8dgblzUUcI3tsf711PCgDqaoUqigt9Qs?=
 =?us-ascii?Q?P+no2eadtlx4dXA2MKJUZPRtarsS5b7EjarGZ8pNiPeXEnZrwXZgMjt3yFyg?=
 =?us-ascii?Q?1EdBKuWeyylfmQAsEE5yxccku4eS0xk0CAXCczRIiVgz7rvzvid2Xpl40ByC?=
 =?us-ascii?Q?DBWAHQ1XFDKnKaqkWCcQpUDgueHEQ2b/otn2zaeRhO8QimNV7adW2VO3JBh2?=
 =?us-ascii?Q?gye3b+8o/pSlutUZheLqFoIRZFHu+OHdBs7JiY1hq2H/e41SYC4D30goIpGW?=
 =?us-ascii?Q?PAQd98KhZ89w7zeYOKQZ7YIzsDGPo1/9Mmp8TiEgkPSvA6oDoik9iJblyA5F?=
 =?us-ascii?Q?oAwspqTbxI2g3x896ztcccDLEhEZIqWjH3I7IoW/QE7EwyoiMhmU2q0czyWx?=
 =?us-ascii?Q?+uCYiFcIKsJ8Dv/17mXntIii2zQUceVqIbuHhmSF8FScvsjlUrpJDjeBXd42?=
 =?us-ascii?Q?H8lqati7jL7Tds5IsfLb9OnXzUfV9TxGZcLlJAXe7WHCQZh/Zo9AySJL8pa2?=
 =?us-ascii?Q?w9cl0vKZP3RLAMh8yHuiu8ER4i5OhvY+T1HpQIaO6vOKZeCLaSTY8iPhDmNj?=
 =?us-ascii?Q?AWJ0QN4EqGOlzo9DLdUV3cvaETdHauszntiLVMqa/pjTOESZtqm9KkQovh9o?=
 =?us-ascii?Q?koeiNWczvKTXztEyPPN40LDRlmYEhmxyTwaGu5QYeFvm/8U+GeFg0anPA+qW?=
 =?us-ascii?Q?Qu+jT1qBBmpJ0LQlhELv3D21vRPCz7SNS+hUzGcYIOhUR1mCBr1vTxVgws2n?=
 =?us-ascii?Q?pMFxaWYgWz94ldxNde7IGvJFgk3r2RncoJ+Dwz+6cdeHK9s+Wzeishhg3pot?=
 =?us-ascii?Q?XJ0/smivp2YPiDCRn0T6QPQlHUgaG4p4rOtMM5bhIXswdPa+9NJl0KmuvNe3?=
 =?us-ascii?Q?AF6i4aRLPj/hR2HTr7edK181MKi9AYUdttpUjVmLuDxgGt5UmS1CuwCgKEar?=
 =?us-ascii?Q?HFg3zba9VStbvmcbQ5PrYGs2zMTq7Fx3Q7PIMXrhFWlMOMCp0hYdMxvW3Zez?=
 =?us-ascii?Q?WCnlFl83oB+x2jGF7Ue90LGgfA2pDbYxBdkCNwg9abOZotMgmKbqbA40ngJR?=
 =?us-ascii?Q?tXQas9ehjfEvmYyMXW2Y8djbQ40ie1v+NHgHitfhzV1hq9Px11oOllHzKIDx?=
 =?us-ascii?Q?TEuGkjBKpbJln0l59n7Ux2jb7+vwXdxytg1KE/ZPJkxteFlRC/VGVfEJaIGL?=
 =?us-ascii?Q?7Bht2F2eMDpAegTmSir9SvrMOLpxdqTUo05i13/SILJ+cG4wlnZNmAu1UyQF?=
 =?us-ascii?Q?F6FGrQJZusnp7ivL3OaO8glrmrG/UxK1uvvQKQhRMEkk6KQJxQ1FhgucJuq3?=
 =?us-ascii?Q?0XBJaVz/9IdeJw8TMHDMx6lNdbDq7w0fqwTvoun4IJZMHBVG9YMtYSTo12yk?=
 =?us-ascii?Q?HG2/7euyMk/MPwVPbSx2hipYH468mxTdz1XpQQHkOAt2J0MC0m6gDk4lq5kQ?=
 =?us-ascii?Q?pZc5WHi6KHwoU4DwC1vb1/qa7GPIFVdMjnVuZT+GzzhnWSKlhbhMDwNlipL9?=
 =?us-ascii?Q?MjThv3wHCesI/3kM+uMegByq/3GCzW5clIJ9+MZUNkvHgHfIHb/7yVpjoXK+?=
 =?us-ascii?Q?jnZSvXBJRvIw2G01rLgFN2ZLBoQi/eceir72NK1lgFqJZnR2cXRz3npH9aMu?=
 =?us-ascii?Q?Lm/HPg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e52de27d-a6c7-4fc5-4cf7-08de31c14032
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8590.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 16:38:41.1475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVAMyTKoeQZJ2bCuUwngBc1BdD/+QbSKzFMZ9LkJ398XL3fr8rmS2MAvyO9yFzWjEb51M7Qy1gAM7bFPESxvAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11374

On Tue, Dec 02, 2025 at 10:07:42AM +0100, Ivan Galkin wrote:
> When support for RTL8211F(D)(I)-VD-CG was introduced in commit
> bb726b753f75 ("net: phy: realtek: add support for RTL8211F(D)(I)-VD-CG")
> the implementation assumed that this PHY model doesn't have the
> control register PHYCR2 (Page 0xa43 Address 0x19). This
> assumption was based on the differences in CLKOUT configurations
> between RTL8211FVD and the remaining RTL8211F PHYs. In the latter
> commit 2c67301584f2
> ("net: phy: realtek: Avoid PHYCR2 access if PHYCR2 not present")
> this assumption was expanded to the PHY-mode EEE.
> 
> I performed tests on RTL8211FI-VD-CG and confirmed that disabling
> PHY-mode EEE works correctly and is uniform with other PHYs
> supported by the driver. To validate the correctness,
> I contacted Realtek support. Realtek confirmed that PHY-mode EEE on
> RTL8211F(D)(I)-VD-CG is configured via Page 0xa43 Address 0x19 bit 5.
> 
> Moreover, Realtek informed me that the most recent datasheet
> for RTL8211F(D)(I)-VD-CG v1.1 is incomplete and the naming of
> control registers is partly inconsistent. The errata I
> received from Realtek corrects the naming as follows:
> 
> | Register                | Datasheet v1.1 | Errata |
> |-------------------------|----------------|--------|
> | Page 0xa44 Address 0x11 | PHYCR2         | PHYCR3 |
> | Page 0xa43 Address 0x19 | N/A            | PHYCR2 |
> 
> This information confirms that the supposedly missing control register,
> PHYCR2, exists in the RTL8211F(D)(I)-VD-CG under the same address and
> the same name. It controls widely the same configs as other PHYs from
> the RTL8211F series (e.g. PHY-mode EEE). Clock out configuration is an
> exception.
> 
> Given all this information, restore disabling of the PHY-mode EEE.
> 
> Fixes: 2c67301584f2 ("net: phy: realtek: Avoid PHYCR2 access if PHYCR2 not present")
> Signed-off-by: Ivan Galkin <ivan.galkin@axis.com>
> ---

Makes sense. Thanks for the in-depth analysis.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

