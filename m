Return-Path: <netdev+bounces-240539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2DEC7622E
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 20:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 96A45355770
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 19:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C78303A2A;
	Thu, 20 Nov 2025 19:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mk+OV9af"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013059.outbound.protection.outlook.com [40.107.159.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2872FE578;
	Thu, 20 Nov 2025 19:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763668791; cv=fail; b=mDL0aSopgKeuFRjCGYNLBbG7Io457YvXyth730AczoK+NJCP1gbeL+BOiWSX50YLqK/lRiBDSVRfUq/xCGqhrNGnNKo9LlxDG2D+fg6lWRpL+dGzJBX2Ew0n8gJ06hrc4+zmwiiSKwKefyVW02aQpW0fC8c5Z2L7oT0yJJIMSrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763668791; c=relaxed/simple;
	bh=txX2/Qm3+4NWCO+StyR01UpAZi2ENAGLVb7kD36oauk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S8GQIwlZSuZWb2szr70CjXh/njyCBt88B02IUn6wSfvcz6lthfucCJuRuK2FgRXm9rrxkU/JOIiXoccmbtCa9nYV07Xx2jWp4sejbTAeyO4Tr/gLdc29zlUPZg5rK4+tuFU0xrw9BPddlHi9Ckk4jVrkpsUQs9AcK/YMbj01rFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Mk+OV9af; arc=fail smtp.client-ip=40.107.159.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lKFIYLYczkTdQE9nXk6FDneCftLKG+VHmMcDrl/9qVKve5Z0aV5i8qy0fLwhCeCcdRtSMsgbVGuvOQXjKc211sZcutrmGSpzAMujJSPsBRO1mL7XfrydwqtTe+LvTYF5dZnoV0Ju0GK0N4L8yzhrd1/CfAcPy40jdjx/RKZalap4Oj2j5Sj7cV2ouz/VrvkYvRDwo2unWFnA+CpSEcRN5azkVAFopUsCKnIdR2Ixrl2fo/JkBW1+C9AZbDKc9EJN7gAyw4wfRXEHitsU3AkLQUGYA/EL605PEpo4Lv5FBPl7SZAAvGPxjUNSQQp4RsUGVDWLSierTFkaySI3OtgwRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txX2/Qm3+4NWCO+StyR01UpAZi2ENAGLVb7kD36oauk=;
 b=jJvrPYX6iyKO4qZEz05GdzLxDK4QFYl8qU2EDB+dtNppJetgTuPeJD01wIppp2C+OTZtW+M7AieGE8h27ga0CBOXYRP8CGdRlwbEZ8nnCGm0YBU0zwx2II8K+TusCsCEPIPoJyWyfAwMcG65f3TeuBPvcz7kmp5K1hDr8zwkJo+IUXKDtu0plFpCiLtBVDNCNW4mutd7GXaXEuS5R9kZcALYfNEJoiq1WIt8gQ0YXchUGlS+VwDJWYxIy4Z/pjhpgaNWKB0KnrF8U6EsuFRYyqYYWHY2/KR23rbvW71+9yH1oQ42rLtbRAB9VZPQubINkII1fDvdhaksoT8ajxafHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txX2/Qm3+4NWCO+StyR01UpAZi2ENAGLVb7kD36oauk=;
 b=Mk+OV9afFq/atIweOywWfJ8is8jG25aC0nGdTrsSN08d2B9KEPd8d4cwJ+O+3COn8EmJEQ/1XXbg0q6YIeUFDMJHAfLYM+GHczWpHP2/OokgzWmnvvqjRGj93a3RZUo1gl4IXG6XsLDNZLHSS7750OGP61OhhRZEgpBKj16CeCGz1TNR+DZ9lCb7SNsg1GhJlYUTOMVSI+YEgC+oy+Q5a5/mpTox7igjcX++7WHwLn8a7y2awrj4FsRtrJci5xBZti85QeRUkhMdhEqANZVZrMUbqsHTOuSHPwvFDDg+lJjMuJT8ED4u9FhAteFBNbO73H0fvkDjHXiPUv0ZZQUmoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9)
 by VI0PR04MB11865.eurprd04.prod.outlook.com (2603:10a6:800:2f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 19:59:45 +0000
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff]) by DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff%4]) with mapi id 15.20.9343.011; Thu, 20 Nov 2025
 19:59:44 +0000
Date: Thu, 20 Nov 2025 21:59:41 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Lee Jones <lee@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 08/15] net: dsa: sja1105: transition OF-based
 MDIO drivers to standalone
Message-ID: <20251120195941.qumgpiwvkxvfjkug@skbuf>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
 <20251118190530.580267-9-vladimir.oltean@nxp.com>
 <20251120144046.GE661940@google.com>
 <20251120151458.e5syoeay45fuajlt@skbuf>
 <20251120163603.GK661940@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120163603.GK661940@google.com>
X-ClientProxiedBy: VI1PR08CA0221.eurprd08.prod.outlook.com
 (2603:10a6:802:15::30) To DBBPR04MB7497.eurprd04.prod.outlook.com
 (2603:10a6:10:204::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7497:EE_|VI0PR04MB11865:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dea2cd4-07f6-4ee9-f7eb-08de286f59ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|19092799006|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B04zynKT7gcg3ytNEnz0M+1Lu+mEpsYAY6qyt0gGFRHXQMPf/sFUpenfxqY7?=
 =?us-ascii?Q?UxiY+T3DO2CbJuOmc48kf6jp+xfn/7QMC0iJGk+7Z1mBSdkvnCBUPX2VTV4G?=
 =?us-ascii?Q?uOlSMD9NfoTautUU9NhbQCbDLFKPzo1sgzh1T2CwqaGkdLZyf2TaAxHsshs3?=
 =?us-ascii?Q?wI66xriSwiLocXMLpOZDG4jpWeaTB7yTvcpk/JQthkVN3TZwx1L7rBv26i6u?=
 =?us-ascii?Q?iOVEoAsVA8RHLArUyREd1TgEJrGmPMmFEGNI3y1kbcHE4hVxY98j/43ek/tq?=
 =?us-ascii?Q?KauhnLGOXd0I36jwnJkD7u6H9UWNN6S6m9VuniyXHceLkTLUbYEwm9oAxvkD?=
 =?us-ascii?Q?1R92nB3JKl2u0gZD+GHPEBZi1ysrJgCt8oWs4r5B5tm923Cf9eceE9KIDQJH?=
 =?us-ascii?Q?j8mMZIHWaXo30KsVS5vdtKd+EX01NdxIbO8UNM+YHundmyOEy0tZHS42P4Kx?=
 =?us-ascii?Q?nHEARzdjefGOx9jZTOboam9LrFe4G2vbxkCr/ZUKO2pqLmAPdDDSygAFooXo?=
 =?us-ascii?Q?6OCxzobcFJCHwD8WrBxnvIT+gTnkLCcbTcw63sjZqshuOQfhMKrQsDyydKoX?=
 =?us-ascii?Q?8i6JZUvwydCP88OOIfXjGcgbExcaGidAy8SPcorwhD7wZyrvMdiN5/0NZFE2?=
 =?us-ascii?Q?Sx0/9w6atogGol8V6aFnSgD4FgCSGRkgdDa/nlxvVlYZwlpqPcmNJZxFnLD1?=
 =?us-ascii?Q?TC6pkrKr2tPNVewtw6UmxvDstkwPBJfTGY5i68cUFechv0Z4OXtRX+ZPsKAe?=
 =?us-ascii?Q?fHd7jJzrsOuzuqWfQ5xUlIyyjmYdZqWJNQq3S0x1E2ahDWYTd/80hyHLb0tt?=
 =?us-ascii?Q?oVJYNHOE0rMU8qalehDTd+MOybLuSx/M9HAn+FweWUs+YnWEbUYSwzy4zPE2?=
 =?us-ascii?Q?W8K3aGmJgJLZFtofY8RZl5Or6OY79afGuqXU2hXbEMI6GGGreWOIftNSaK8/?=
 =?us-ascii?Q?ATbYHm7/35td08srCmOLm0O825CEDujJ2m8OpJ4opeISQAeRn5uMdMUYo0sL?=
 =?us-ascii?Q?HoO4wfA+PDXZwIIR1G34SBlKYynDUApPoU4wtqyt6lCzS1WwA/z2hnUFItkk?=
 =?us-ascii?Q?z9X9G5v2/vIdN5GXYAg1CG5iks9vcyDOrbgFQyRlLkBVbq3+gI/hViEj/itw?=
 =?us-ascii?Q?QKuOAwjxn+KfyGn7kklU+VXTPAffnfVxSV66mvxIXEnMTAkjHkj6O3rOtMd6?=
 =?us-ascii?Q?IonlBA9T30MxnmNdgehEIHLdHAln4mGRn0he5vdmCDlISphiSiDd+GqAWZFo?=
 =?us-ascii?Q?O/YfGMIoZHWFIP/lVPlGXRoO2UWUvC2ChLut6DjrlniQLEdc91fBGNK82t/m?=
 =?us-ascii?Q?0voHC+QAxyp694YXoSVm5nhhRLy6Cz8HHpzLZmbi6SsfIqiSudGNFKB8j1Sl?=
 =?us-ascii?Q?daXkPQsHzbMYaqElU5Sg6uOvkvioC+WYC63/SbB6WOJkA+gdyfvJmRnXGeQ9?=
 =?us-ascii?Q?akzw3uEBUddr2AS4ql7L9savRApZMHTN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(19092799006)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rGHyL+8COcxQQ6hLGaWZTJx4bziY+EnUWwGqrKj0uw+83jWehyoujg+xZYPJ?=
 =?us-ascii?Q?JR223ht3Fobw8XxUJoFHlg6kbPCEIlyKa3RYHIGGK9cbWv/TgdlMxZQ1pW2U?=
 =?us-ascii?Q?KlopnQsFvurSOeaMcfX8sYH8uIzNCamAROaSmzx/G5HqrDiQDRXyymL6+mkX?=
 =?us-ascii?Q?Ld608LMGx1o8xXSvaRF/PrB5f6rx6kgyDOL/y80OdIphvSld1z2vQPFacWfT?=
 =?us-ascii?Q?U71o/W4npxxPbBoKHCEt1RdFIULyRaR+jHIS5bUXnU9G3RS2Wfk7g3jcMrqo?=
 =?us-ascii?Q?9sAOfGz9q7WXGX72CAr2st4WhHvT2YINmZqESlDqq/y030lF+f2wZHz+5SKJ?=
 =?us-ascii?Q?7x8U0YEv43xZwqk2EdgNQFE18HCjWJYY34BLgvn0jjPC6QV5REHO/xHwrBdb?=
 =?us-ascii?Q?cMXL9suOl7cpaYU1ALIFCDLywFiaGFChFl4G6KIVaXFhZe4GjN+EgrsVnBiE?=
 =?us-ascii?Q?z4dtjUxhyMFEjCe6X1nyMknvgEm3DjPuqzOs0f1mr9Q8dsFddyLBlD98OQPV?=
 =?us-ascii?Q?D6RPNGQxUFG9dv7J0peQttGPMdAr5c21PoRxq5EMZaRsi280Xk03oG6g8rR7?=
 =?us-ascii?Q?QBOheTikr5YsYzCle9mmEUi/Q5k/+f9ybFJAa6D2U4rLnzKCH4fTnqtJVjoF?=
 =?us-ascii?Q?7Dcj4TgfK9fiT3cMNM641WA7rNjlQ3fXNPddkNxpjE4k2qSP3UTEtQri0g7j?=
 =?us-ascii?Q?HpVLIM5jCqS+08qK38a9KO/PjOAM04E9BxnscfAWGKaRL0d1QYw7Q+16AuGY?=
 =?us-ascii?Q?jUoO4yLZCqxyP5o4CSiSILtq8xh/XDTjeVr2hB6QkVfF1l6ZGj03kmyM2Jby?=
 =?us-ascii?Q?ocziGaHQNo1uKlYNE/hclAR4QBuQMMpvdy/KgdnLFC8mWzQXghpbWfGl+0jG?=
 =?us-ascii?Q?DLYud+9ylGUa+44qIzcM36ApXv/emj7upvtI+jhQ0h1nou+HBvVCBUxvRLBE?=
 =?us-ascii?Q?lR9nlvHYr+yJv1qqDkxeBO499iU9biLti2RMwCPqpRytaQO43LFR3JcdTn/G?=
 =?us-ascii?Q?ho9KMHXjhAGFeE6NVwgM/1Me4qxfKLFyN8HfydOaNmev1LCmmWNN07xy+rVF?=
 =?us-ascii?Q?XL2+I3gq8gSjrEIZO8LaXxF6fK+oY67KZhrVeWrA1kbo8f6R4J270abc2hNO?=
 =?us-ascii?Q?kN66TL/KfJxDolsO8tq4NAlu5Pkos5X8G5yMFTS90w8ZkqZQd5h/AChr7YTq?=
 =?us-ascii?Q?+tSmE9zgF1vg7fmfagbTS54oL12uGT+k75UmjP0e/Cn6xFhrLZI1Qlsmy0N2?=
 =?us-ascii?Q?UrXvRtBlSPGFOU6dTEKXXjoqqOLbr3XI1D72vQT/HcJZhyhulz6cQuQ/dof5?=
 =?us-ascii?Q?rCTJcv0leZTjBId4J4+gQLheeQglCdnTIQYV5sMOlP9hQVYW1H9EfPudFfKl?=
 =?us-ascii?Q?1riK6VbLDpa19JE78MbPkMnMzy17SiKJucveP1MYe/9CHKt8viG55YdhZtq/?=
 =?us-ascii?Q?L/km41QuFbaVJXDgyr4V4qyTpdwrFLSLeOXVcdaX+69LquIrhwmqW8/YGtY5?=
 =?us-ascii?Q?nlBwii5iqZmAGMmVVF8Ijat2Eqa0c7ujwa/qhxQwWMUwHbdnuQASVYGQpfDu?=
 =?us-ascii?Q?Q93wACyRyCpMf+GuMpTfOagozcm8F8Ljxajtb7FUckcQw1PsWrVtMNRnoD2l?=
 =?us-ascii?Q?A4u+8LBJzIsYxIWCExca6oKcvusDQcoLN3Eqp7uT8K1bn2p1bqf14d/5hfhO?=
 =?us-ascii?Q?QsEWNw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dea2cd4-07f6-4ee9-f7eb-08de286f59ad
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 19:59:44.8248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OoB5X5QjZ626ZIFPemrmPhTNm5itcBThe1t9CyRsEMhNrPwSPa6An6VFB5q3+1HJPe95GBAw/GuT3JF6heyX6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11865

On Thu, Nov 20, 2025 at 04:36:03PM +0000, Lee Jones wrote:
> The canonical answer goes 3 ways: If you want to use the MFD API, move
> the handling to drivers/mfd.

Wait, so now it's negotiable? What about "this device is not an MFD"
from the other patch? Move it to another folder and suddenly it's an MFD?
https://lore.kernel.org/netdev/20251120153622.p6sy77coa3de6srw@skbuf/

> If it's possible, use one of the predetermined helpers like
> of_platform_populate() (and I think we authored another one that
> worked around some of its issues, but I forget where we put it!).

yay...

I don't need the code necessarily, just the overall idea if you remember it.

> Or if all else fails, you have to register the device the old
> fashioned way with the platform_device_*() API.

Do you realize that by this, you are inviting me to waste time until the
next reviewer rightfully asks, why didn't you use MFD, then I'll point
them towards this discussion, but you didn't really answer?

