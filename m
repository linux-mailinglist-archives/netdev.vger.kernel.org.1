Return-Path: <netdev+bounces-87979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719238A519A
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C6C288C40
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E605971754;
	Mon, 15 Apr 2024 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b="V78IU9n/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2102.outbound.protection.outlook.com [40.107.93.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF365745E1
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187804; cv=fail; b=lfZzgUacCgOrebzS1PUvEMxv12+KSE1XSok26QTPaBrxP5hC2JiGCXozI6TmuR0sWglxdz5kiP0rQh46DvwxlidvNZx2VjTVv728X7QMOE8aXbY/Y9KbIFT4KaAL8MmNaTj+jTRUbQXQqXfht75d76QxlyxTwaUjJhEsjAB1KiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187804; c=relaxed/simple;
	bh=Zd5Ho9BQbSU4PFFrw+gGEpwLJ4m4xFHSRse96jw52CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iVlza9i7tKj7kr/d4zmLFo4UNrnlylFQh/KFVbGQzQfsACIcBrDv6tWcW3Y4NywYpFSiRUg6eXqcaVrabE+4izj+Oy4mkDATf89yUHTBtf7RERVPiCYzbHh/oSfuE1cxjwGLdUStH1oCTWFTE9m2ipgSRIT5PhFAHoT5rVU4NqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com; spf=pass smtp.mailfrom=in-advantage.com; dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b=V78IU9n/; arc=fail smtp.client-ip=40.107.93.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in-advantage.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKnFiG+CFwFb6YX2kCMqS04uFjCBeyOMMYhCihEskJemgcjpjAySg4RTK7Z6OPLBYSrW/63SlVbpvQwV3ekBHL96Hv0xh24pUH+r79NlAobPK4JnrTZcPod0ivjrsCHTMvJnrOieomdPZzqtq75Dm95VBhqXBHGK4uktNxPnQYKNWhqFqOgfrESlhSdBSUR9zwSmuoNBba8phn+9w4MDW8D86TXkfqsAVC0s400fZn3RgpFeCiM4TlHTnDiGjOT2W0KRT6EujdLt4l5oZIm9NGvBg/ZR0daneq+4BoIYMXYQAN3yokieiGpTB+oRBhKJMvBp4ifpQJ+CcqstelQn+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/33wolPyqLRjsvyA7ae6WjSzEUcBtqx4IxTdK6frdNw=;
 b=dXb4zqjWw59qP2NXNmev+v6/05Pp7QYfOlUGYu/bloFyYPVEn8Fs1/HxiV71+9PK55fE2ytyLuI079kiR+WNC8XMq8CefvuX1OH/vUggSEvntzbCWvscbQ9EntMKuBxYwNsZ19FogOW9/KtnsROLXBGwM29Ln2jiYchKCTJt4eH0GVDXO0hJafUMZiQ8WHpGfgcaHQSV5vgdNR4txLNzMxp/94MG+RGh+1YWrughY9LHbxpcOTDZAHKwVpjmY69gQ/WB0zxoz5qEBIDkDIo3FYqejR+Yno3DGweaJV0sVDs1vrgqw8s5SX5jUpXCiBQOCXJR7heim3V4eGtI6kx/YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/33wolPyqLRjsvyA7ae6WjSzEUcBtqx4IxTdK6frdNw=;
 b=V78IU9n/yz+ApMqgupHXrfNiLdv8r0MY0ZGqzHmFTElHgGhjliWMuaaZfjW/5/XMqh+38ymvcncuyOkqnhVNOkdr1qXBu8EY+eznTlA7w2ukADExmkv9FSnnnHUSFzlpTKN6COJXLjgCIU3LzpD3BsAE4kx4cDCyJcwURSPG3us=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12)
 by SA2PR10MB4443.namprd10.prod.outlook.com (2603:10b6:806:11b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 13:29:59 +0000
Received: from DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::1e22:8892:bfef:6cb6]) by DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::1e22:8892:bfef:6cb6%5]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 13:29:58 +0000
Date: Mon, 15 Apr 2024 08:29:44 -0500
From: Colin Foster <colin.foster@in-advantage.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: felix: provide own phylink MAC
 operations
Message-ID: <Zh0ryOJ4zihHvz1Q@colin-ia-desktop>
References: <E1rvIcO-006bQQ-Md@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1rvIcO-006bQQ-Md@rmk-PC.armlinux.org.uk>
X-ClientProxiedBy: BN0PR04CA0197.namprd04.prod.outlook.com
 (2603:10b6:408:e9::22) To DS0PR10MB6974.namprd10.prod.outlook.com
 (2603:10b6:8:148::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6974:EE_|SA2PR10MB4443:EE_
X-MS-Office365-Filtering-Correlation-Id: cc1b43de-78a4-4081-3a24-08dc5d50256d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y4C1pN141NtXUYuTFjeIgfQGeRPismPJXJjUsmjfnrYVmla3qBHSXZBacOItKEGf0PDn8vLB3bgYW1VazV5gyTlhdoZgA1fdodYUOmxKUFzi7Azt3FbBRZMjS8PkXWb18ocInW9f+5Puoa/PlBbXWPgbDPTLwT6RKWrC8TeiwTGY2PAKQS/Q9MsOQ/mB8QdOcYv8lOYlutsas9Of7KAYIAcC+r/pRzAMvS6+DWMAHkiJ3J/uJY5J0CoBFtk1IGgZytmpRPstDdYGTSrObmKsWO6rIPOQN4Ggii2SY3MVLoegA39HUo+9oT//p/weYJP0oWqAbnY+tfO8OIw3tUViLJSggA2Tawt2fR3Az5DxOd+fdVe6gt26FUgheCFNAbYzcJ66H/WI5Ii45G3BRZeGAOfuttj5NcvkqDV2Jy7FkjHkrmNrpg+6D3kV/tLjO15c5xckYI+dYd5rohXHwiKJj1b5YEbAokTNrZeHnmPLOFIzdANPfqpPFkkUElFwlj8iO5lHtlahAS2ox+VFbmnXJDkFoyt9kFRlldUmaD9Jc5Hirr15X0LIga5kK/bEtyHZf9jy0E0S2hnBktXR9WY2JoF2J1ZjA7pun2ZaCtp1KswbBFAv07CNobGpIlr/qPKujqtUmRBEvSOYFzJDyBSnhJl7Lfv6pYVhkcL33g6rsGw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6974.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GEPVJpnojqI8KAffJH2/Ryrc/FssysZD3we1hPElf/pBMChileTsaleUlEeI?=
 =?us-ascii?Q?9oxnsQiN2lqRdZ63WO/TYT9YypOoI/7qTCZFUEEWkfF3Xn3w8AgdR0ArPluu?=
 =?us-ascii?Q?BzGFkkkc66j3EOsyBWCBsW0CGhkP9QA3YcFR7icRijCQ18p7/0m5ySRqHgia?=
 =?us-ascii?Q?k2goHQD+D6TGIJKOsc9JJSTyDRMyybxAXGjep10VRtV140HXGdTc6Kdj0Nnb?=
 =?us-ascii?Q?feNJTvElEDvPca7nkZ6p8UeegM1t5aKcT0TOkBE1Ib50ejIFk8aXeZRfMiZo?=
 =?us-ascii?Q?BvHBeGpNXtIrAS8bpAFA8hN2NMM0C9K6X8jNqI1iSovR+sqbEuULE/gXw8Ex?=
 =?us-ascii?Q?RehLJX1n4ahTIkXMVBwbujGUr67INRvK+ZmflwcmgvIjaEd0w77Rl7TDedkD?=
 =?us-ascii?Q?O/rzR67xZ8Lb143j4K6Ej0F4INwqHshUnJRb5dlnMU0lDW5Q/LdLjYRFkMZU?=
 =?us-ascii?Q?k0YRmslMxquJR28pv4AA0vYLn7me5GSz9odUj4dAp1kBEiT6lfYUTdHyGmk/?=
 =?us-ascii?Q?68OGfHYS4qhSHmlF932QNuxcoTRuo/NxHNGLu8rdszJ7T1fe8kvj9LFZZAOJ?=
 =?us-ascii?Q?fnpi+WLRdGpld/+tcBoxZaSXsnnZGHJjifwk0JLI0mheF8lGcA4dMhstgobT?=
 =?us-ascii?Q?HyhW8oqTFnhF4xcTsnh50gKVDiw5FqUfmccu/12luqlJJPeoz4aOxl//phhT?=
 =?us-ascii?Q?9kXTh8vkA7toVnPnUUoBPRcx90ToUDb86zkXfA85l45vxICpUVrDXVjiitV3?=
 =?us-ascii?Q?2BXxN1OW6vl9LdXqZYpUReI4PhR3pjGdq/9vE6hVGhe9qpzrhpyZLDsP9PTq?=
 =?us-ascii?Q?0FdAyXk1fPznD7ENi4o+N5nFQgNnI7qbdiLcKF5oKStPVpv55dDFL+zHtW3c?=
 =?us-ascii?Q?Z2BMz/9lmADFhdNGrxRrPYI4K4SAmFvyntoxk4iXENjvqEoXuhYjsURl1DYp?=
 =?us-ascii?Q?vfH5peLUWXWHbS0lvV0DUMUDc31J30MLlDVy3Uqpe9eNQQMhVq7rJ+1vWcUm?=
 =?us-ascii?Q?WmLfCTKD5KaA9a09YQZ49bmJLwNo0qn7OoRUlR+sieHBRxc4EyrGXvWqgFfy?=
 =?us-ascii?Q?gVAX8wqYuXHlZWM8a2iwwDHV7pmDDspKBGXnspNCiPmB/t0DzSTMEZlVIZ5F?=
 =?us-ascii?Q?slKJrjsl85TWLe7dTzlyhcCS5iwWpEZ0Z57EHB87NoZUw31BsM0xLi8tPwgj?=
 =?us-ascii?Q?XMFU4T63byi/cAndaQanLOTgmxihQ/r7yqOhDxL3Gc+GmZ8IADzTodVkav+O?=
 =?us-ascii?Q?0fYXitSIbRDIdAQMbrWOAPgmdVH/FxZ6i2A5y3r03NMBjlG14I8aVkxgWFq5?=
 =?us-ascii?Q?n4bDp3woMzAANezzj0ocj8ku5d7qK/OAPa31+46uq0juXJfGo+Ivj4aAcl5u?=
 =?us-ascii?Q?MwBj/Tojw/f943rWP/webzeexw640mzpPj4TJEslYyyagU+ggsvJ/qpL+g5F?=
 =?us-ascii?Q?CWpDcd3fp2+QweFVYSCefmo1Nu5mbYr/usq1hlgE/XMlvcPc234PUAvJroMm?=
 =?us-ascii?Q?lfiPAslRJpnI87jOb9AsMEoT2xpk6g6CCtxFQ6HAzHUS8zaeXwJVbiUZcU/F?=
 =?us-ascii?Q?NF6ZJ8csYbjcuX/MOjfak6/gxrIkoomXybGr5TUhKzxAoaxpEIiksfbO8OCb?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1b43de-78a4-4081-3a24-08dc5d50256d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6974.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 13:29:58.8151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EAyOUnnWA+6yUztz4vR/cy3Hc4DzRQ/KRbWElTR6xJ4OOWjZkbKyfhKupdQyAvt8g5OmS34q7ZQctD2rj8JT2RXHnMGJ16PacF53WiQkXGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4443

Hi Russell,

On Fri, Apr 12, 2024 at 04:15:08PM +0100, Russell King (Oracle) wrote:
>  drivers/net/dsa/ocelot/ocelot_ext.c |  1 +

The patch looks good. I'm chasing down an unrelated regression so I
don't know if I'll be able to test it on hardware until after EOSS.

Colin Foster

