Return-Path: <netdev+bounces-214644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B62B2ABFB
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 17:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C831AA01408
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 14:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AFF23D298;
	Mon, 18 Aug 2025 14:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="doClhLNL"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011017.outbound.protection.outlook.com [52.101.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A89238D54;
	Mon, 18 Aug 2025 14:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755527860; cv=fail; b=Ma5k/mf+olNcVBkDS647O6/Ki4ET2GNRGMYZI7ku4Cam+TjVNBsfHlBr74E46pxCKMXQk5lgwIVFG/FlT+7Jxoh2+UIB6dOxooZB7maFbQ/wt5bMVX2Ck2Zz2faJYOGMmDYimqPT/NKJ2+J4ACwzH5rRzUj+Z4L74gsBFOmCoQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755527860; c=relaxed/simple;
	bh=FsWGWbKOazysx254ktikTIAWBWQGCq8lyMzRs+oY5kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hg637tRLzbeT5Q1AQafKSidJW9c7nGws5Lv8XCRMsbTikHveumPoIlTa0yry0Pxq7njRspvAx1XVKOrvfC35lF7XAW9KyleXICou0lIFStylfV83Lqvda2TWC76S6LcFXYAvTW6dmYLsdOp8z9LtK69PQ9yixzwib3CpWfxPTtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=doClhLNL; arc=fail smtp.client-ip=52.101.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNQKCZ61CjT/6VzL1zi4IIhuE9e3cJ70MCbZEMxPica3mhWByMQJbLZkkcJm+jnFeKETJGPgzNXg3kt/zsGtepWVxR6cTbM+tCtm4ihqrRX451D85cwLp6ddgUkvEBZEh0zPKBCCevRo6v5XBa6VXg/z+AtmBbUGEIz4S+c0hWm+niiyT3bOu1UyTTQqk1ow7uY6W6SIjW7I2ntY3TlcrPFD8OjwpSThHBUMmYE/gPYJwdcHAZKJXyCqpiAjQUfvnnAY/o0Y6sk9KwAWyU93tE8uiPL0TbEhsM1t7fr6DIui2PVnXDi2CSuQPARDQ/66rCloLxKOjWOE5+VbFYHZeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7eAIKYBfZPnr1HR5RsQrSTd7GBtcTePM/Djvnz/kVc=;
 b=eiRRjF8RUsMzHa2Sg14ppgmhMcUFW+14qXiX9YyxiVrG/3O4JMSZ7M5zGtVMxGYRjFomhBp+9HmUbIH6TIgnBttxF0qdwcX3uczKsndWvWAPjKQdwFvLdO1wN4WpYwwN9wOcdrT7H8epH7D1HNZhEB75HqR+dW2KYQt1J7DIskvRubhNt+ZU4QNVPr26Hk3D5+b1lC5WIYm4hJPLqcdFRF1dCnBycLhTQV4IVDNyfM/7fdbxCszbGa8IVBNYUhPItIAu/dktvHfd7CJqWf3NXQ1w1Agwi8URNPbCQfrl4nRDuDWTpSCeG6IuTO0IFLu+s6EGpOMZ4U9u+8VVykD/nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7eAIKYBfZPnr1HR5RsQrSTd7GBtcTePM/Djvnz/kVc=;
 b=doClhLNL3rsJinvgROBefPLFwVV0T9LhpIIvCM0iLNwxiNAqB1F1zQXPchCWPjYrxp/jDoIcWw33wA0uQ7zVISg7dKVo0cORzsUVk/IiykN6W9YwVFBnh2hnK41kwpG9g0Qwfq6/qGf94pkCE7zMA/xWXAqEH77aFFB2W9usNLGsU+joPs+h75kXEJmaGpA6L0Rty6oRuAE36g2KOVJMGiafghWbUSFNbtIsvV6XPDGCSmIeoyXA+Xxi3pNutVxthxdeVxognEyzInDPSXhKQbxNTFMsR+nsp4/V9gWmkLODoFXFnjJvg8Ze+LoZ+wYmHYlU1hVi8xlVWMS5c5QoCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB8658.eurprd04.prod.outlook.com (2603:10a6:20b:429::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 14:37:35 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 14:37:35 +0000
Date: Mon, 18 Aug 2025 17:37:32 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com,
	rmk+kernel@armlinux.org.uk, rosenp@gmail.com,
	christophe.jaillet@wanadoo.fr, viro@zeniv.linux.org.uk,
	quentin.schulz@bootlin.com, atenart@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] phy: mscc: Fix timestamping for vsc8584
Message-ID: <20250818143732.q5eymo65iywz44ci@skbuf>
References: <20250818081029.1300780-1-horatiu.vultur@microchip.com>
 <20250818132141.ezxmflzzg6kj5t7k@skbuf>
 <20250818135658.exs5mrtuio7rm3bf@DEN-DL-M31836.microchip.com>
 <20250818141306.qlytyq3cjryhqkas@skbuf>
 <20250818141925.l7rvjns26gda3bp7@DEN-DL-M31836.microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818141925.l7rvjns26gda3bp7@DEN-DL-M31836.microchip.com>
X-ClientProxiedBy: BE1P281CA0243.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8b::8) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d517c82-f042-484f-5eec-08ddde64c5e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|19092799006|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pHilCDku6DXXeLB3ROf59lJX2dZkrkv2hiy6oBBAMVj68zoG8Oa5vr3rdj/m?=
 =?us-ascii?Q?cdGe3KzeapBWVk03YAm+b7/7YOAmN1VFxZqLX2w9o8DwcNkxxpEbBIcFsmXE?=
 =?us-ascii?Q?DiU96hTYbwATlXyFGBeUYTi60Fvy+ARqhymnCM2LcYjndp8rhaTxseVunc/V?=
 =?us-ascii?Q?M2YZVM5c3pOQLusYBISqvpu/LbWnXLlPjmE3CIUOKpMgSBE620074xBdf3D9?=
 =?us-ascii?Q?pvqPYtzavqXhESzWdvLTYBbJOfZon6OKcf9KzXLwPEaJij6N9R7SeFIxM/OH?=
 =?us-ascii?Q?a96ZpyX+TltOCpYUomFwIDGOtKIDwnRcS8a7pDnLD6K6aIoOCDaYgG1MrdRC?=
 =?us-ascii?Q?r0FNRUP38sdRZC47pLwS9tb1zxXHV+RlQKbvm7LadxUwQvQr1G8UB2V0L7Vs?=
 =?us-ascii?Q?PdvBoRb8KmIWHjWcbzS/qvEMS2ogXmJbIKn4g45/fXM1gz53h50ONtUMmwDs?=
 =?us-ascii?Q?Aong3JIRRNyA7s7Ta8nfZaqInTuPAcPzhSw1L/Pm3D5uvay3qlRBJ5zyHGO/?=
 =?us-ascii?Q?432AODDALElroznUoEDR3by+LB8tOXtVFKyDdZ4PAIgpCPx0XyljXa8VKGGv?=
 =?us-ascii?Q?4aE8Cxcs3KMfcYj891HUZfboCKZB61zECxUPoERAmDKz1N+wovBFmorq3kBB?=
 =?us-ascii?Q?6n9IFOkAgx8aCBN0NzvtMiuk0SW3U5xSYx6lT/drIePM17ogwylrzL9BE6Hu?=
 =?us-ascii?Q?zGyQVX4lfQBu7VPNvtQp2ZdBg9hiXnTZDnO0Ncqgf02qjLLRQnMyPSPrHdkO?=
 =?us-ascii?Q?jbbtPLUMLQlWq/b/g6Eo9NCBBiKFCJpBr98N2/6ouC+veK/VXkRgZoidFBtI?=
 =?us-ascii?Q?60UBJfStug45ETVw1ni9JueMkHAULKP3/LYSMFCUUtpktwNMwKNhnqL2lDhq?=
 =?us-ascii?Q?TJl7Ov/VJd+1qs20bxmYpvDs9K2whsNTapEw3/mdTpNJpBSRNKgvWijQ3/93?=
 =?us-ascii?Q?H6h0AEGE+0QyrfNuct4d5Mt1H0Kb+VYpcwzPieSBDJMUkr8KR846kGN3Z5nJ?=
 =?us-ascii?Q?hA/EpiuUVfWDo4De4JAG9jx+I5fidPklK32Jt61lqqr8BeQG0sHimxmJnyB7?=
 =?us-ascii?Q?m86RUsz/w/ddAjHZKJEAydtQuN1USZLTaLMZJq4Kz/H3h3xTuIegn1ndCvpU?=
 =?us-ascii?Q?lBZ6vEjBsegYTSGsWF2Vdvml5sVxYPbdNa8UinEPi9XZxgwyO1yfEDnmIA3Y?=
 =?us-ascii?Q?q4GWhpKRAQ6HPpfvTaVyukt/nSgrJ/6rLi8bhqVWfM2UJQrqcH95BBEczRrc?=
 =?us-ascii?Q?vrdqwkjnRggMKIMZK/hJLGo43/5nj6O/r8+ItU4FZ/apXAb7KJYm72G6gYbJ?=
 =?us-ascii?Q?uGzDXbqlphdGvH5BF0+S5OPszW9W7/kU6l/botftj50rtoyXN7CpKqYDri+V?=
 =?us-ascii?Q?ePRSvfTyUOdnk4FQeJoCHG3LSIsJNZqqt5wWyLIx9XhRJSE3ZGNZWGjIDKJ2?=
 =?us-ascii?Q?lRTXyoy1j1s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(19092799006)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fPXnSM1JrftdTV9Bv5hUwNvp7R73g26LIAxqSxGXKd8drd4u0b5dJ4e1SenU?=
 =?us-ascii?Q?NZHoWs659fWPg8pTbThEo0GuwaIURsNmXwZ0zXfHS1TSIAaQb6F9ppBUGH2D?=
 =?us-ascii?Q?U9NhD2RQH/Zx7ptUQFK1DIchKEgdod8Dn0n/BRimLvw3lHqC4F0aWmRKsz6d?=
 =?us-ascii?Q?2hMhYgTbrRsXgmg0ngqovOvClXe1+eO+1tGN0J+Nkqoc5doEeL+GLmm8i7pl?=
 =?us-ascii?Q?QwhLM/F6GHV37ipjZEeUeIxUYHhMscZS87JNmsPIaz/Fkc3pkh0pdn/io1rT?=
 =?us-ascii?Q?JrfnJ3HJrcmwsVYfwNRUFkDt+ncKzchVNveHjVEZuYgPvG21VdhWsWYCsyJo?=
 =?us-ascii?Q?Jsc/UxmfXCw19vThZviC5HGtTxK6cI00s9X8F7ky90l1Ql2sH5LepFzAQhaF?=
 =?us-ascii?Q?ZGxbB/lrLcDGwzrBNbLDgJYOGDLPliOvNfp18MN3YP7xFtiw1kIXV21ZYyo0?=
 =?us-ascii?Q?apAEGKiPy1uQiN5Jsl30Ncuf7vlObRmzZLebPiqS48ERz2KCXf/6kBhpoSuM?=
 =?us-ascii?Q?0kpJpTKF+n3c9bU3JpqOovD5zjv3hYKn1ES2w5YZYM4+V0YZpM863GmxJuzT?=
 =?us-ascii?Q?dG2g5mjkp6CvFkEx2uYPMDLPJ7f0VlBbKzu2pX3tplva2PlmyjwOAER7W6wR?=
 =?us-ascii?Q?NpL97Ind4OMgHtyWHOPUzhqq++LzTxjXix3i0LtwElQGElosSPL9KXM39zks?=
 =?us-ascii?Q?rFu1E0ubDIrAtaszVRBUs9LqEaFWAnh7o0Je7dZFmMAWtrdduZjg2K4ItXB3?=
 =?us-ascii?Q?m9nVHUhslWnF+9G1bUFdNjk5RnoKfRG8KWxDVrd+eOLYmOblSbQni/cUDYbR?=
 =?us-ascii?Q?GZ4DETtI9/BrX++XV7/qxtW9MZQayhf02ht8bxlGWK6cf/C2dQKQY3CE1j4j?=
 =?us-ascii?Q?43Plhr5Zss4eALoq1oUisegmYY6B22pdU/KYqjAwIR/kq4VVy+96kaCZOR/c?=
 =?us-ascii?Q?2TDsHjw/zNUWgK8GOBreR7IqvNolRDS+RMBZ4V/8jpXSEYFxGkkkH+sdr4AF?=
 =?us-ascii?Q?FqJpyXyB/RHVTGwLswbO8xgfaJ5luKdfyUln650JMpviTSw6dMZ9VPoTs5D8?=
 =?us-ascii?Q?6DvLBYNKDYCn6hh3b4PweqdVOf8GK2FtXtF/rXEA9VEBF/uLk08sl34EIPKn?=
 =?us-ascii?Q?3pIbS8AyFCkssVkvGxw8qDRJpgwKSvo2vEnfz68v7gJ3SPe+92livTWa4PwN?=
 =?us-ascii?Q?AFQ/biq74bycrwievWNZjQpvb0h2xGWurOXJPEoZd09nxyZgpdhGRl9DTcpS?=
 =?us-ascii?Q?QLhjurh/wUMJ3GdfP+FsRJ82kO1ydWvVyR9BXaD3Imo0aj4OiZnYSdYdVzl0?=
 =?us-ascii?Q?x1eLNa14yQerNkmMZxWd/HBeDfolH8IYbO762fX5I3d50W+VhXFoaadWELgO?=
 =?us-ascii?Q?eCogKxOz0TXWbId1lB3udnLLOEEokjHOXOYOhYFaiCbXKC0V0/acQpZvbjoU?=
 =?us-ascii?Q?IWg+yJA11IKXIeYTNHAQOGKEZ3hPhk+YZHZNmQtBDD/zLUSB2OH3O9T+V+iW?=
 =?us-ascii?Q?b72TebETkIom+C2M/38Xo3fMtp8GEmHXYV+oOmgjWkbL70lNZCVkVnBLbNGB?=
 =?us-ascii?Q?WmsDWeOghPoXgpKMRc/+rM7SemwJNESaxqwo+yncRYBrmXgtvaDkSP7RsSu5?=
 =?us-ascii?Q?Uc6i9TddWXSAOKB5Q70hjMzpygbrduKsa4woeWySfIdhZ+32UacYQh0WqVMl?=
 =?us-ascii?Q?gUKdZg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d517c82-f042-484f-5eec-08ddde64c5e1
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 14:37:35.5541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9mbDP3NQGYsJYRCz2daYUkUE75Nkl7jKyL/BNgMDwoIZLovKfxLObKkDC4glzBh7kL3lbfZqTfx8aavSxQRyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8658

On Mon, Aug 18, 2025 at 04:19:25PM +0200, Horatiu Vultur wrote:
> Nothing prevents me for looking at this issue. I just need to alocate
> some time for this.
> 
> > The two problems are introduced by the same commit, and fixes will be
> > backported to all the same stable kernels. I don't exactly understand
> > why you'd add some code to the PHY's remove() method, but not enough in
> > order for it to work.
> 
> Yes, I understand that but the fix for ptp_clock_unregister will fix a
> different issue that this patch is trying to fix. That is the reason why
> I prefer not to add that fix now, just to make things more clear.

Not sure "clear" for whom. One of the rules from Documentation/process/stable-kernel-rules.rst
is "It must be obviously correct and tested.", which to me makes it confusing
why you wouldn't fix that issue first (within the same patch set), and then
test this patch during unbind/bind to confirm that it achieves what it intends.

I think the current state of the art is that unbinding a PHY that the
MAC hasn't connected to will work, whereas unbinding a connected PHY,
where the state machine is running, will crash the kernel. To be
perfectly clear, the request is just for the case that is supposed to
work given current phylib implementation, aka with the MAC unconnected
(put administratively down or also unbound, depending on whether it
connects to the PHY at probe time or ndo_open() time).

I don't see where the reluctance comes from - is it that there are going
to be 2 patches instead of 1? My reluctance as a reviewer comes from the
fact that I'm analyzing the change in the larger context and not seeing
how the remove() method you introduced makes any practical difference.
Not sure what I'm supposed to say.

