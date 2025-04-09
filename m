Return-Path: <netdev+bounces-180651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 975D1A8204C
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 10:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8CC8440418
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 08:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447F225D1E2;
	Wed,  9 Apr 2025 08:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HtrEObUA"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011062.outbound.protection.outlook.com [40.107.130.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8745925C71A;
	Wed,  9 Apr 2025 08:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744187924; cv=fail; b=KnP6jrSxLSD2y0YyXKVXvCsidjJCl7m6v43q2Xc0SVP26Wb4bij07Dtbrcwz6XsTqWtq/eX+P6gwVSZFy6I/u4WAwz8YaDRMGnLuPkjACx7WNGwOhA+6jjwQmPoYNlRQV1XMjVdJDldgTfRri+I6Abe1mEmlQ5PLoe6LdV66C2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744187924; c=relaxed/simple;
	bh=axDwTUwyjALvKR3CXoAoO1ZlJ3CH8W3VhCwQaHqX+5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SfhInM85Hec340oShyYZGpdRYxsTvUd7WDKY2Wih7RvnEAwi8EQ2ZTUE/2/eWnTli8dGop/bK28bWZmp4VYbHzycpRCKX1sKS1OpowYVxMPMKRq+zreX71fu8+lMmMpBlkM6gP2qoD56IjwfNN4P6HA45HE/+E7PzJT63wxFzEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HtrEObUA; arc=fail smtp.client-ip=40.107.130.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0FUyASp7dBWqhxfvVoiUJvUC0bU8vadr2iW/NI/ceTBIKPKBDb4/z3rHHt8A3qiV9jA6YwtHahpD7isYYNdLcE9ZcwlEc84AmNv/o9ZpHn6LITTeW53AuO0r04wX6P8UbV9th29cG0G/nl7caTzLTMQg9cu+kpFSxO5kYwBr1dhkcdB8vEp7CV/b+6b2c2JLbyiiDQmvQbBExqiewwcr4z5chAlSxp8lMk5jIR1C4bfhYKzv3maMN+HO27AuZ56E6N8w0pxfCJP8ossOju5ycRV8e0/Bqg3URxMJRt5kG6I1tcSm9yF7BlJAN1w+EOB4vHLx9CmB1PD0emxAKTZLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q86rURsLZYQ4fUC1s+uE1A3NXS2AhTZM87Z8vZ2nbvQ=;
 b=j5woNyJkV32V96/HdQxTVznG5dD+hdX/CvN11utkF2glBnCblG6mlY9CsIADbPiweUEg29XScs7O79YfLi14Fwj9hTqwrDD+uDatwKhdjuIOQ/p9nTc1paWyHTsQf1KuQiTQ08h9UmhVLlGz14dc4uLfLxSL/aZZmZYH0vZIBriwAeYJRg4S7Nr6IfT3LYO1j/zdeCtFIJEl6OaNNuBnSSsfmCkzt1i3R8AvIx5c18vSgxaOE9E4mWddYKykbzGZGNQEuLhOKq5jgWwMHk/Xz3soC/LsTXv3lNBs36+QGqDb/Hp9MX4IfP6nxIYBdVMdWSxMS/EMLDg4MP3J6po/gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q86rURsLZYQ4fUC1s+uE1A3NXS2AhTZM87Z8vZ2nbvQ=;
 b=HtrEObUALOtUj4yRNYUA8P7rGsCggz1aiJDgRHsgoxFy8FHgSrUTVyOpfvg7dPte1mt6OJZul93VrF8+JeLJK1sYKKfs0LaLYT4jywpN9nFfSf3ZYFQemXL19bJ9DsHZEZAA5wpk0zkcSH6aPteExjybBrR6e7ACVzVKe6GBlLkDoEKXcZyj49E3E6876f1CfoacHSDBkBiGf+cRDEZ/WObiFnrHv+mLKRM3k2+homYgxuCxPKGowRmDh3+xvFuOmAzjkh5P3Yoij5JX3K/GqJqVKj8eZTixmEFAKAIIQ+utJajBhT1QC8uiqWSfCI6XPmRRL3onIJZoH3zctRc4Yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PAXPR04MB8592.eurprd04.prod.outlook.com (2603:10a6:102:21b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.28; Wed, 9 Apr
 2025 08:38:38 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 08:38:38 +0000
Date: Wed, 9 Apr 2025 11:38:35 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Kory Maincent <kory.maincent@bootlin.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?utf-8?B?QmVo4oia4oirbg==?= <kabel@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] Add Marvell PHY PTP support
Message-ID: <20250409083835.pwtqkwalqkwgfeol@skbuf>
References: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
 <Z_P3FKEhv1s0y4d7@shell.armlinux.org.uk>
 <20250407182028.75531758@kmaincent-XPS-13-7390>
 <Z_P-K7mEEH6ProlC@shell.armlinux.org.uk>
 <20250407183914.4ec135c8@kmaincent-XPS-13-7390>
 <Z_WJO9g5Al1Yr_LX@shell.armlinux.org.uk>
 <20250409103130.43ab4179@kmaincent-XPS-13-7390>
 <Z_Yxb6-qclDSWk01@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_Yxb6-qclDSWk01@shell.armlinux.org.uk>
X-ClientProxiedBy: VI1P189CA0028.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::41) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PAXPR04MB8592:EE_
X-MS-Office365-Filtering-Correlation-Id: dc1e1e50-aa79-4372-3b24-08dd7741ec95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xct+QU2MLQDtC/Ta+o6hPzjmpwRo7qPW7BDFAf9Du4ElnAylJCbmwjZ5wcal?=
 =?us-ascii?Q?KQUoZbrEjeLAZ+3nkywC8+eDr98BtwN66ZOTTcd6VkJ97OpTZnAp1LkbNhOu?=
 =?us-ascii?Q?2nxgdNw6D3SijLmn6e9grh1X/PtIdkAb0Z73htAe34OneVryRRP2vp70fqgj?=
 =?us-ascii?Q?T5fbnL9k17n70m4o9pz5Gigyd+j6S1aMpMqRh7aQOrS62MkKlgI9A8jN3CL4?=
 =?us-ascii?Q?X+u1ibvs1dghaWWJidwpCtMJ38O/6XBI2oijH4ueA8BYgP70ODh5c1A6yVl9?=
 =?us-ascii?Q?31zR21XfN5LnSL6bQB1pDX20OJ29CVNhzdUcSbhfgHj185sC8L1vnjiufRqU?=
 =?us-ascii?Q?5H2KL4tXJKCwzXS56LhSvR7scY1chF1oW5KlwDDll8fi7FOea8OcLe7ULd/N?=
 =?us-ascii?Q?uz6DkkjRxLq6pF9hDLWjPGwRuAh0M0SUFvFerhlMYZqD952LBeMwRZsq1z5B?=
 =?us-ascii?Q?vM1FfzLDLGI9EXAED2dY+4ORmhijRp8p7zopSmVJco7sIMzdphM8jPopAnZA?=
 =?us-ascii?Q?rA7iS9MrkCP2qcH7WL69NacjbcaffwmdN7YBN1rLbLTDclWrb95ukN6V2Zrw?=
 =?us-ascii?Q?SnJtJt6q0G1IxV71A5eBcUZZWSkxzdcrHLPmDe3SHZc00OekmN+UBV4RNbjN?=
 =?us-ascii?Q?CukXjjmn8K1Zz4OmnRDL8TUqlinKu/DmU81JTEwoqdF21d/fMfnC21/gI+Ha?=
 =?us-ascii?Q?1aG+qf/Zsj9hARxFovqjjpz0JZMh/eNxdtCH1beYU14BbZwB58ZcN9dnGeFc?=
 =?us-ascii?Q?aOzbtX0HZiYoQnEAOoXk72n3IUOoPLMi11AdmKQR2Z6Pb9d3uWno2mTw1oj7?=
 =?us-ascii?Q?yNukL3wAzFfB63vfel2y0WMvvPpcerMCUUnVCJ6GZNYYHNMibDDDYy8qKWKI?=
 =?us-ascii?Q?XKL2MT2DK5QTTRo3Iix5Eyn2Dz1J6D017qdBHj/foMXt8IuMTYFLDRv/8an2?=
 =?us-ascii?Q?nMQ2ySNGikMCWfFF4N0jk8YgTJTgIZX3uldIO+5PA3BluCCKHzdXcRy8uZR0?=
 =?us-ascii?Q?8lMenfhmfu4WeELc3kWR7F+Ehm0h1SPUVV00zpwBqW51PZifISH+o+W327IW?=
 =?us-ascii?Q?3P/I94zy25KAczQXMDd/43pZjtij0h21843HLQcxaXt32bsVUEDMJPHmFJdR?=
 =?us-ascii?Q?74GKSReJryTA0QeuZ4todpJY0Ea+vaGtluivDYuX796XCFDgqtzM0TSRkQH7?=
 =?us-ascii?Q?t87hkml/j1dq0XUs5QX43H87sFYh9rWtJ8GRuxcnRSaSU/uc4W6dNMK8nr+F?=
 =?us-ascii?Q?XQQf3QWR6OI5sAfiyFQdoWWwaa5NRA+8EeDUBfrVxaLWqKxhn8qMF9AoJMUG?=
 =?us-ascii?Q?10hin4xEFKqhTP/3oI2q7TzE8en8oYENNvWVOUDFQ5WMfQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ISdLXDcw4HVqswsy/sE5zrHUez2mOsU8sAsO5TB7Y+cfuG8K/7+c/8m07N6H?=
 =?us-ascii?Q?JvuvDyGrd8I23xN7QOcnG9Kp1gPq+nW6cOxUZbfQbBRBqB1mWQ/Gbg/p5saH?=
 =?us-ascii?Q?BPBHc6Z+741a+46UpSX2nLo9VoKMV1fCmFRTXwFac77wm6AdIHs7xO47Wesh?=
 =?us-ascii?Q?ejruY68n0QtSCZVO+7+tCVPkgqqZkVC7k6pqOYjttLWhjSvvEvRZ05i5dUMD?=
 =?us-ascii?Q?aH4z6yKXQWMKTMM9Nc46KUV8R8XczXEJ4VE2QEihG1raLfXriG6KfK0U/fFy?=
 =?us-ascii?Q?CPcph+KT8CU4WO/q0jyJRJ8HwJrVcnU980P7E/u+RiDBY8l1D/Ty5UVN1OOp?=
 =?us-ascii?Q?1l5NMuEPx8HxonaAMlR53UNLWypgGHo4WIdM2ZZlvPcJrwQo7aMgwb2rrClC?=
 =?us-ascii?Q?1XTZut8K+iQnUNqNTWJEu4LW7RYoT9iS8aQsofhglP9qzF5C5APt/MINP341?=
 =?us-ascii?Q?cmMi1ttQyirJMmY2DJVg2gUbb9z9PqyUdHS/7PTZqBXnomSTteMJGY89obn3?=
 =?us-ascii?Q?op2Mo2PwTZv+D5cin1FRaX+aQT7xTBgcmZScW13BG79JAHvBSxZ/jbINK8FW?=
 =?us-ascii?Q?UIT0OJWbqWqpFQ1950cBGTZTcZDZDBkA7BiQr66AMyM/sKugZTqchpO0szvv?=
 =?us-ascii?Q?jV/kot8WH0aDOahq05Pt3q6062mO80OxWSifUDzr037+5a6wFldnuEn+e4+S?=
 =?us-ascii?Q?CexRh8DRF9GIeBEjkJbKV27WCkBNaaBBzRFyEc8ityuCoeNVvA+NRk6Yby7i?=
 =?us-ascii?Q?yg9sDWEkrYLxF0EE3EN/pJ35BJyUSW4cLPfeBys44gFIZ/BnJ0+uThgZRTz5?=
 =?us-ascii?Q?dqyuJjXSeQPgQOoyOSvKTP2o47k9wPMk/BlgHKl+PjWusPjJBUek2QJ9u2hs?=
 =?us-ascii?Q?wac67OsVxDvUXxvFTCXx4P2paTenOlSpoeB+GKV5Xy7XJtmG4u0NjitaqePt?=
 =?us-ascii?Q?/Q4ZkAq+AW5UOARlF6dLHxHIZi/OxN5rVxj+PK22Rs0ML2zsvS9ADBbDdskC?=
 =?us-ascii?Q?zmaus7sPdYpvHMGFySM0dyZjtlE1syaCEuddE+UZ5RFNCjywo2tMJIdxRweW?=
 =?us-ascii?Q?IP4WD5b+rpxVFx2zRb1Z9Y6W0R4DA6qtElBBNi4uw0CYIJWh0K81Pw/QVP1Y?=
 =?us-ascii?Q?B8NCOPcCmPfZ1DKhmzeDCsrXgmi4QdHUU2b/QSOiKjnnQVxJ/M1gP/sw6v1C?=
 =?us-ascii?Q?5CA2wqMeMu/Hxrx7BuO+nitDiYy944r0ZQgCjI8vAGIFJUJQt18KHBcTrpWl?=
 =?us-ascii?Q?VOSb1sUmYx0b8nsVzhYXHH4UghaI5ce+sqyJnjbQfobX8xPwhEkxyXkMGN0x?=
 =?us-ascii?Q?BK/wu4LywgJgT/Wf+OwRm4ejo/VwgdWcoRXwlNah5Isoy1HaP47Jp3wpluuD?=
 =?us-ascii?Q?AYy1RljFHR0F30Oni8410s5rDo8yag52FilY2QFhfuPQqAfoNoc+/CoaUA4N?=
 =?us-ascii?Q?LolI/JoGEQPCFkNzPRO2LgKe9hWB+emhL4E9gq9dL0RW5zubUQts73EKLozX?=
 =?us-ascii?Q?imTJxH/Kvzz5okW+9zBy9J4EqjsYK6JRfYRZoJsqGz7qCP0jqCfxWmuq9O8z?=
 =?us-ascii?Q?mTeGHBvX5tMFUX4Xu8/ZswYN0+h7C15nn1XYVSMGgtDfTtrh+1PUZ/EXfYJh?=
 =?us-ascii?Q?yA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1e1e50-aa79-4372-3b24-08dd7741ec95
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 08:38:38.4607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XDTd0iFDGNrb5QRMa691uzkb/M1xTsKUzLuf1Z+vKwBkCaJBpiCi5oNkoTZckVR+hIgH7qJd7rbUW//Tbw44QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8592

On Wed, Apr 09, 2025 at 09:35:59AM +0100, Russell King (Oracle) wrote:
> On Wed, Apr 09, 2025 at 10:31:30AM +0200, Kory Maincent wrote:
> > On Tue, 8 Apr 2025 21:38:19 +0100
> > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > 
> > > On Mon, Apr 07, 2025 at 06:39:14PM +0200, Kory Maincent wrote:
> > > > On Mon, 7 Apr 2025 17:32:43 +0100
> > > > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > > > > I'm preferring to my emails in connection with:
> > > > > 
> > > > > https://lore.kernel.org/r/ZzTMhGDoi3WcY6MR@shell.armlinux.org.uk
> > > > > 
> > > > > when I tested your work last time, it seemed that what was merged hadn't
> > > > > even been tested. In the last email, you said you'd look into it, but I
> > > > > didn't hear anything further. Have the problems I reported been
> > > > > addressed?  
> > > > 
> > > > It wasn't merged it was 19th version and it worked and was tested, but not
> > > > with the best development design. I have replied to you that I will do some
> > > > change in v20 to address this.
> > > > https://lore.kernel.org/all/20241113171443.697ac278@kmaincent-XPS-13-7390/
> > > > 
> > > > It gets finally merged in v21.  
> > > 
> > > Okay, so I'm pleased to report that this now works on the Macchiatobin:
> > > 
> > > where phc 2 is the mvpp2 clock, and phc 0 is the PHY.
> > 
> > Great, thank you for the testing!
> > 
> > > 
> > > # ethtool -T eth2
> > > Time stamping parameters for eth2:
> > > Capabilities:
> > >         hardware-transmit
> > >         software-transmit
> > >         hardware-receive
> > >         software-receive
> > >         software-system-clock
> > >         hardware-raw-clock
> > > PTP Hardware Clock: 2
> > > Hardware Transmit Timestamp Modes:
> > >         off
> > >         on
> > >         onestep-sync
> > >         onestep-p2p
> > > Hardware Receive Filter Modes:
> > >         none
> > >         all
> > > 
> > > So I guess that means that by default it's using PHC 2, and thus using
> > > the MVPP2 PTP implementation - which is good, it means that when we add
> > > Marvell PHY support, this won't switch to the PHY implementation.
> > 
> > Yes.
> > 
> > > 
> > > Now, testing ethtool:
> > > 
> > > $ ./ethtool --get-hwtimestamp-cfg eth2
> > > netlink error: Operation not supported
> > > 
> > > Using ynl:
> > > 
> > > # ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --dump
> > > tsconfig-get --json '{"header":{"dev-name":"eth2"}}' []
> > > 
> > > So, It's better, something still isn't correct as there's no
> > > configuration. Maybe mvpp2 needs updating first? If that's the case,
> > > then we're not yet in a position to merge PHY PTP support.
> > 
> > Indeed mvpp2 has not been update to support the ndo_hwtstamp_get/set NDOs.
> > Vlad had made some work to update all net drivers to these NDOs but he never
> > send it mainline:
> > https://github.com/vladimiroltean/linux/commits/ndo-hwtstamp-v9
> > 
> > I have already try to ping him on this but without success.
> > Vlad any idea on when you could send your series upstream?
> 
> Right, and that means that the kernel is not yet ready to support
> Marvell PHY PTP, because all the pre-requisits to avoid breaking
> mvpp2 have not yet been merged.
> 
> So that's a NAK on this series from me.
> 
> I'd have thought this would be obvious given my well known stance
> on why I haven't merged Marvell PHY PTP support before.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

I will try to update and submit that patch set over the course of this
weekend.

