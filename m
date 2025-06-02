Return-Path: <netdev+bounces-194625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DBFACB8A4
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 17:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D1B44A5FD4
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 15:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C939222571;
	Mon,  2 Jun 2025 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ifuRmfE6"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011017.outbound.protection.outlook.com [40.107.130.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1603221FD0;
	Mon,  2 Jun 2025 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748878565; cv=fail; b=ZrjHZDPKU9cGNR4iYYv7CxEA5pUasgM1n8O1sdpmzx97o4dDZTZbCIf9bD/wlMpGabaFd87zhYecPXafzFf8hcKye8jtpYsadJSf6ko4/iGGDV+jNLFQYwiXLjh9SAQLUWJ8T8xxxJg5/Hpf7Jlz8/Ei5pGKtLithVUuIOJsRCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748878565; c=relaxed/simple;
	bh=sDK7lc8oLTazG7XXg7wwhHNnJSUDmhNZ87nHlr7RW1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nMzYDeaVy4ULPgsiwAMrbiXGvWvQhnK/KCsVGd6iebg/S127lugWp5lEIyFv/0QU4yP6pO9EQ3H0guRQ1Iu3wdiO2+29zqGqC2CDKPbHx7Wu95RLdLmAUpwKuaODxeGbAKdjlx4VLWd/FP2n7wMKn4Ar3yr1LTsYEAPN/NV686g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ifuRmfE6; arc=fail smtp.client-ip=40.107.130.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nm78blvVl/1OEAA/a/PIJ2f0SfoX7dRj5HcAfS5+YKHQ+Xk0AvjoyP14XVfGcHL5JUAOocMu8ne+Ff8b91+2bYeKZ/yhy8NAOOQdOtcXqaclm7o7BVZrfucz+UwnhYPRuEDo3gFoviUEH3/d2qq4yP9j7ZkaKCPkaLsaTDNq1KRqzrmol3o1XJWZyv2R8KrxaYgGo6WCuvlpyGI8MfMvNM9UUKlPjWbVR2FUJp49nJzRgWvSl6gG5J/IKt+dbxwCpZ6t37nk26RNSbLvXI9sQ2AvNPytibJ6V/Hu35Vc5xFdKmtOPFBWmOknyWrcoUweDguAzs07NQzziYwmR2ZN8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DChxUJEJ6k3tEydSSmsri0Uj34BaVdQKnqzQHRHLadw=;
 b=PDeJOQEoThGhUVEklkxQJKh6ptaE1gQuNOol8HD2DWqcU6/Ft/+HHStapNDBt+UXXo9ZHCYC7Rr8z/aMt9YKIt6eJvws7oXrz1nG0jNV7uORtjTqpanfki+MtVQRcmlKli0m29CsYRG4vLcY1qB+Ot7Am+iYCA3IE3mKmYMP8CskHws5atoyjFjL1ydodQWir6XWLGv8xMrkTvnFZGmcIZJOsdVI8MYXbTEssqvhP3FgYsYEjjAm4lzCg6MBYAVHI6qMb3vRI0EEOds5jhkAoIhUjCFnRwbpTEt/TvQrZtw0SbnEL9P2eWQcI+ZDblonvlGttHvTN11MYR1BbCijVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DChxUJEJ6k3tEydSSmsri0Uj34BaVdQKnqzQHRHLadw=;
 b=ifuRmfE65D1ZO6sKLJTS1mEZzA8yM2YZMmmObfzgwLt0jwFrNPBAfLWkTk+giuvKX42N+k7oRMPSMTOdU70PSq1kWTHgHqDHRUnk2DJK1tHqWKcER/FGPRQEASjNfYm26bqmoQkaVFXTYB65c4qICHofN+hRzo6HU58hhuT9wBKbAHtAOqrc1oKVR0TevhX9wa+uhzz0edlQt6OqnTOaNnOawmeVSSLrhXbBd9oEXvCw5N/YBpSMZdDWOjyJpmltbsR7t4E7Wf+3TNEdb5nM1og+c4q/AdCeQerELTolTXp+yE4q1Hshwfn61+1hTBiKWDOoaZTgvRKNJI8XDJhBxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7420.eurprd04.prod.outlook.com (2603:10a6:102:93::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 15:36:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8769.025; Mon, 2 Jun 2025
 15:36:00 +0000
Date: Mon, 2 Jun 2025 11:35:52 -0400
From: Frank Li <Frank.li@nxp.com>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: net: convert qca,qca7000.txt yaml format
Message-ID: <aD3E2ONB6Ay1wwmk@lizhi-Precision-Tower-5810>
References: <20250529191727.789915-1-Frank.Li@nxp.com>
 <047fb49e-1ca8-43a6-b122-0d6fa9a61c74@gmx.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <047fb49e-1ca8-43a6-b122-0d6fa9a61c74@gmx.net>
X-ClientProxiedBy: SJ0PR03CA0049.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7420:EE_
X-MS-Office365-Filtering-Correlation-Id: bc25c9fa-eaba-4395-5a77-08dda1eb2cd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xhgecGJlHh8+pgslEJF5ar47H9Yxz2FzwzzkRIjtDgGf4Nehaj8CjsNEUWw5?=
 =?us-ascii?Q?47WC3h+6mRQnwUZOLEoZMF0l5ih6yxOc86If9bsqfB1dNlTZ+QNYHJ4a3MvW?=
 =?us-ascii?Q?WXjQAMUuc65anJ7MpSrB9BwdHYmbhNY2d6UHilS1g2DnLINX5NgIBRZ5h/TT?=
 =?us-ascii?Q?cO2KIHsFuEnu2XV9D7USE5//XOD+5d/ee1T0q3lGm27PnBUzLR+8KQaTOZ+f?=
 =?us-ascii?Q?CipJP/rVPwWWa/u+mzAxGhnbyNpenzCFzT5fJ9PT7mCY6IOhIlnNQ7SQu+/w?=
 =?us-ascii?Q?2R3PNwCiFn0tzXZdIFy+b5pVsIpghX8ashD131KHOc8Z/YFkMAqZjOTmawnP?=
 =?us-ascii?Q?SLzX7eRw+UC7cOfU+qQL22rbAXuigHAbUCO/mZeIN35Db4je72f9TtisVC9Q?=
 =?us-ascii?Q?IzoCTR7aKoW116naGzvcXwQdsPLYhgZY4UPs0ZLpRVjzguYSqNljNs6yn5B1?=
 =?us-ascii?Q?oad7horMUtqzx4K+eg3vohdEiAU6EGYgADNbKVn0YnmRX/xTHqzUisMEBAuW?=
 =?us-ascii?Q?yLYPylY2XxXHSxHXBlvwdQta8qBo0QQ2a3f7l0qbGVHP109tXi6nqKQ3/zT/?=
 =?us-ascii?Q?PmnFOphFbUwcpqM5u4HldWFQdnQAdd36VacSKr6AGjrh6UHOc2JL18+tae/0?=
 =?us-ascii?Q?LmvQv3XKlJKDP4UFIFfXDw2CoxG/6gCgLXvIt/TGJGRHNVC7Sfsr9v5F4Pax?=
 =?us-ascii?Q?XpQMtye8+nmBxw9UJIGBrwQ6AOOELW7IWrPHYeUe5VxreXCPfjiJmv2QkZj9?=
 =?us-ascii?Q?4LtjSkXnMzFbq+jV/bk96kWgz1UOr3/3apVU+z8Kz3xIAoufz81LqAYNLbjo?=
 =?us-ascii?Q?tG36esxY/djoanQprBYVsrbyg0ej6W8zuwunhYkH5EbDJnTuEOHnUoacdnhD?=
 =?us-ascii?Q?laaVthSeM5IR1Fa3uOvN+k9vdi0t41hISTvwwWGK75vNa1e/P/zDenWzY/t8?=
 =?us-ascii?Q?C8mNJJkY8ClxDUti67aEipaNwl6IoGd21U/tu1DXfvbfkj/rxOG46qSP+b20?=
 =?us-ascii?Q?n4VmlvtubKlLBt9YDy34Bm4OEUkct1UH+8429RwkvhwamCXgr2TZD/igY+/z?=
 =?us-ascii?Q?2NweGtxGDb6yAFvCoscED+7igAWmjHzASYc6wQg4iar4eEJzcutzfoRHuAgF?=
 =?us-ascii?Q?LsGR0x6wHuODOkJ3FgR6rxIlE77jbAdmPDOigFfVR3ojbLLyVTAS+Ij4BLih?=
 =?us-ascii?Q?rwXWTgfp74c5gTdB44fc7VCTpnFX4N6B/VKeCmAUHfbsNGSxYZm3TZRmF23Q?=
 =?us-ascii?Q?PipYq36t0TCnXwGLHjXEjKfLtbnPTPzavvXqg5D5w61qoKfEfaODPkf2br8m?=
 =?us-ascii?Q?eNUCRBs+wkzWEAsLnXzn8EAUDjg0cKtdkGNHojapq2UN0lgnXhYUE9CQJUgW?=
 =?us-ascii?Q?XayaxJyQ/51cxA7vxMDSwJ/9o+pggdqeWwhCTxHrsSkpUhMYyQch0Kiddu6j?=
 =?us-ascii?Q?bkHHWKAP1zw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FB5sRqeJVnHFqPxqPQXdyMhl7dZmMR/x3sN0cY8AmlVdKPTugVe/Wbqzew3E?=
 =?us-ascii?Q?6c+oIvZ3nzdqhTUISOTlH2gjrrrXbB9/nz5b60JEM1Q6AME53i9DnNZ7ysnd?=
 =?us-ascii?Q?nksz0L9XkgXkBIIcU61/vzqUhE5fEeD4RZ+cmhmkgn4WzVb9xViK+KFLzAYh?=
 =?us-ascii?Q?GahpD5BmdBaC7EEb8FJGO46ZHC/VdJYu84CyH9soays1qzMrAOfqhNXwDvNa?=
 =?us-ascii?Q?Nm142AHVbI8+zHsQF/ZTmGofUSQJbHunnVIDLA3OhstUbuj5VTpgBslutgdu?=
 =?us-ascii?Q?MdOGBgXopDqw1i0sWFKNzxl0hbNlk+cxLIqTy3CMmjqMwAMHk+Oi5IGPQluP?=
 =?us-ascii?Q?QMd9KtBFhoTYY7NMCLRPBwuX21BJWXnpWc7UtmLWX+dWvq+vvdVTsJXvvXnP?=
 =?us-ascii?Q?badzWpcVYZwu5wXLopbs1OxiN0X8OMXSvGWkVfahAO1SvUEzgxUppKWjWS8M?=
 =?us-ascii?Q?VmTvuNnT0vZuAS4KxiW76oou/GgOlEeuATZcus4JNNyD5RBb0n1v5mDCk+0n?=
 =?us-ascii?Q?NmYGuFuXFc+q5NJostnL8R3sMvM39jazO++/LazqQcoz2XL6/Zi5eH/XCqdc?=
 =?us-ascii?Q?ySNXWEOWzChpzYBVuJ/y39PClZ2m8FYvOitm8kkYMu2Ho28k7Sy7nBTcuiab?=
 =?us-ascii?Q?L2ZHuO/jgQDqgKpQV/JqF5JnS0yhjOOwx4vbioG1fBs0CEHag8NovGBvaVm/?=
 =?us-ascii?Q?uc2fyJuSfUaaF0okVnxYOI1aqK398RAHX1j6e0e+EJ8KXaL+jBhhdQB9VqLa?=
 =?us-ascii?Q?w3VEfvuzM+T7ReEpqjXuEqt0il/RvHLD78Wic3g6gCWtuGdUHMcndKLBSbPV?=
 =?us-ascii?Q?SzCnNyMwbbl8wC32zOs+6V8LH36+ibzDli7efkk9g/c/5sT/7iWo1btohXhO?=
 =?us-ascii?Q?HUzm1eSg/AwuKu4Wwm7e1BERcQrez1H+ywFeiw9xtC+P7NlwlE5PsKoTj+OL?=
 =?us-ascii?Q?NAHuRe0csQiQMFGDbt3pYUg/zlha+E8HmXaXtyCmmHa9HDOwLEqeuGi2sC9v?=
 =?us-ascii?Q?XpBZwyKDOsBcfFADS61+6XnGbjw7aDSq++f7sXscGr3m9UrW2dTaxeld8ab0?=
 =?us-ascii?Q?/Z1EMU7WjkGe/Hms4Rmz+NexeM1zgjYQGZ/xaqwcqUawrxbUoMMH6obXdEDa?=
 =?us-ascii?Q?Bgip9Z41t+3t2TgCt7BI+8mfB89GUtA2khtWwIMrFfuboxoOcbAbOtlvLcwE?=
 =?us-ascii?Q?b03z4ulLQbcaiQGJGlX3bW8Jwg2UU5tL2xYMq0zhurlWZimigd5BTe5tgTS6?=
 =?us-ascii?Q?b3zgYOVf/ZJPh0R7Kt+V4MWlBuJbKd+BTsy+x4BEVg9LOTOkvLKvU8gN4v27?=
 =?us-ascii?Q?nPC25l18lICsQiYctfOs8cn3iyvdcW9QNk3bj47nyXvdQXo58xFvR8OPBLBt?=
 =?us-ascii?Q?cDOqigvd7ZdFLIVj7uW/hTX1BAl6d97oBBHzVJIwUXxavYZ+sX/VmjUFG3xl?=
 =?us-ascii?Q?2sl9EREYnpmREe/N2vbKK0Fw+vBAv/yrT+bH91ibV957aF8u17Ae0WUfmzPn?=
 =?us-ascii?Q?trAlOsU3AKhomCRYAr5EGPfrMOwV0b+BnY0FLC6MCfnbvhxWX5Wfmp4iMIUo?=
 =?us-ascii?Q?GBmwm0zIuJYfyimgKLNyOrf3nBf5hxl6VGqvHTiS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc25c9fa-eaba-4395-5a77-08dda1eb2cd5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 15:36:00.0857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZ+MtBe9wine5RKtVEJY6Yf/MyrdwRs2j/DLwJP2uoreHAPzWPVtnzXVCrYs/Dyjiq8iz9ka7MSSZ0pDIfKWsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7420

On Fri, May 30, 2025 at 10:33:28AM +0200, Stefan Wahren wrote:
> Hi Frank,
>
> thanks for this patch.
>
> Am 29.05.25 um 21:17 schrieb Frank Li:
> > Convert qca,qca7000.txt yaml format.
> >
> > Additional changes:
> > - add refs: spi-peripheral-props.yaml, serial-peripheral-props.yaml and
> >    ethernet-controller.yaml.
> > - simple spi and uart node name.
> > - use low case for mac address in examples.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >   .../devicetree/bindings/net/qca,qca7000.txt   | 87 -------------------
> >   .../devicetree/bindings/net/qca,qca7000.yaml  | 86 ++++++++++++++++++
> >   MAINTAINERS                                   |  2 +-
> >   3 files changed, 87 insertions(+), 88 deletions(-)
> >   delete mode 100644 Documentation/devicetree/bindings/net/qca,qca7000.txt
> >   create mode 100644 Documentation/devicetree/bindings/net/qca,qca7000.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/net/qca,qca7000.txt b/Documentation/devicetree/bindings/net/qca,qca7000.txt
> > deleted file mode 100644
> > index 8f5ae0b84eec2..0000000000000
> > --- a/Documentation/devicetree/bindings/net/qca,qca7000.txt
> > +++ /dev/null
> > @@ -1,87 +0,0 @@
> > -* Qualcomm QCA7000
> > -
> > -The QCA7000 is a serial-to-powerline bridge with a host interface which could
> > -be configured either as SPI or UART slave. This configuration is done by
> > -the QCA7000 firmware.
> > -
> > -(a) Ethernet over SPI
> > -
> > -In order to use the QCA7000 as SPI device it must be defined as a child of a
> > -SPI master in the device tree.
> > -
> > -Required properties:
> > -- compatible	    : Should be "qca,qca7000"
> > -- reg		    : Should specify the SPI chip select
> > -- interrupts	    : The first cell should specify the index of the source
> > -		      interrupt and the second cell should specify the trigger
> > -		      type as rising edge
> > -- spi-cpha	    : Must be set
> > -- spi-cpol	    : Must be set
> > -
> > -Optional properties:
> > -- spi-max-frequency : Maximum frequency of the SPI bus the chip can operate at.
> > -		      Numbers smaller than 1000000 or greater than 16000000
> > -		      are invalid. Missing the property will set the SPI
> > -		      frequency to 8000000 Hertz.
> > -- qca,legacy-mode   : Set the SPI data transfer of the QCA7000 to legacy mode.
> > -		      In this mode the SPI master must toggle the chip select
> > -		      between each data word. In burst mode these gaps aren't
> > -		      necessary, which is faster. This setting depends on how
> > -		      the QCA7000 is setup via GPIO pin strapping. If the
> > -		      property is missing the driver defaults to burst mode.
> > -
> > -The MAC address will be determined using the optional properties
> > -defined in ethernet.txt.
> > -
> > -SPI Example:
> > -
> > -/* Freescale i.MX28 SPI master*/
> > -ssp2: spi@80014000 {
> > -	#address-cells = <1>;
> > -	#size-cells = <0>;
> > -	compatible = "fsl,imx28-spi";
> > -	pinctrl-names = "default";
> > -	pinctrl-0 = <&spi2_pins_a>;
> > -
> > -	qca7000: ethernet@0 {
> > -		compatible = "qca,qca7000";
> > -		reg = <0x0>;
> > -		interrupt-parent = <&gpio3>;      /* GPIO Bank 3 */
> > -		interrupts = <25 0x1>;            /* Index: 25, rising edge */
> > -		spi-cpha;                         /* SPI mode: CPHA=1 */
> > -		spi-cpol;                         /* SPI mode: CPOL=1 */
> > -		spi-max-frequency = <8000000>;    /* freq: 8 MHz */
> > -		local-mac-address = [ A0 B0 C0 D0 E0 F0 ];
> > -	};
> > -};
> > -
> > -(b) Ethernet over UART
> > -
> > -In order to use the QCA7000 as UART slave it must be defined as a child of a
> > -UART master in the device tree. It is possible to preconfigure the UART
> > -settings of the QCA7000 firmware, but it's not possible to change them during
> > -runtime.
> > -
> > -Required properties:
> > -- compatible        : Should be "qca,qca7000"
> > -
> > -Optional properties:
> > -- local-mac-address : see ./ethernet.txt
> > -- current-speed     : current baud rate of QCA7000 which defaults to 115200
> > -		      if absent, see also ../serial/serial.yaml
> > -
> > -UART Example:
> > -
> > -/* Freescale i.MX28 UART */
> > -auart0: serial@8006a000 {
> > -	compatible = "fsl,imx28-auart", "fsl,imx23-auart";
> > -	reg = <0x8006a000 0x2000>;
> > -	pinctrl-names = "default";
> > -	pinctrl-0 = <&auart0_2pins_a>;
> > -
> > -	qca7000: ethernet {
> > -		compatible = "qca,qca7000";
> > -		local-mac-address = [ A0 B0 C0 D0 E0 F0 ];
> > -		current-speed = <38400>;
> > -	};
> > -};
> > diff --git a/Documentation/devicetree/bindings/net/qca,qca7000.yaml b/Documentation/devicetree/bindings/net/qca,qca7000.yaml
> > new file mode 100644
> > index 0000000000000..348b8e9af975b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/qca,qca7000.yaml
> > @@ -0,0 +1,86 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/qca,qca7000.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm QCA7000
> > +
> > +maintainers:
> > +  - Frank Li <Frank.Li@nxp.com>
> > +
> > +description: |
> > +  The QCA7000 is a serial-to-powerline bridge with a host interface which could
> > +  be configured either as SPI or UART slave. This configuration is done by
> > +  the QCA7000 firmware.
> > +
> > +  (a) Ethernet over SPI
> > +
> > +  In order to use the QCA7000 as SPI device it must be defined as a child of a
> > +  SPI master in the device tree.
> Could you please add the dropped "(b) Ethernet over UART" description here?

Okay, I will add back.

> > +
> > +properties:
> > +  compatible:
> > +    const: qca,qca7000
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  spi-cpha: true
> > +
> > +  spi-cpol: true
> In case of a SPI setup these properties should be required. Unfortunately
> i'm not sure how to enforce this. Maybe depending on the presence of "reg"?

But It think depend on reg is not good idea, which too obscure. Ideally it
should be use two compatible strings. It should treat as two kinds device.
It is really old devices and not worth to update compatible string.

Maybe some one in dt team can provide suggestion!

Rob and Krzysztof Kozlowski:
  any idea about this?

Frank

>
> Regards
> > +
> > +  spi-max-frequency:
> > +    default: 8000000
> > +    maximum: 16000000
> > +    minimum: 1000000
> > +
> > +  qca,legacy-mode:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      Set the SPI data transfer of the QCA7000 to legacy mode.
> > +      In this mode the SPI master must toggle the chip select
> > +      between each data word. In burst mode these gaps aren't
> > +      necessary, which is faster. This setting depends on how
> > +      the QCA7000 is setup via GPIO pin strapping. If the
> > +      property is missing the driver defaults to burst mode.
> > +
> > +  current-speed:
> > +    default: 115200
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +  - $ref: /schemas/serial/serial-peripheral-props.yaml#
> > +  - $ref: ethernet-controller.yaml#
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        ethernet@0 {
> > +            compatible = "qca,qca7000";
> > +            reg = <0x0>;
> > +            interrupt-parent = <&gpio3>;      /* GPIO Bank 3 */
> > +            interrupts = <25 0x1>;            /* Index: 25, rising edge */
> > +            spi-cpha;                         /* SPI mode: CPHA=1 */
> > +            spi-cpol;                         /* SPI mode: CPOL=1 */
> > +            spi-max-frequency = <8000000>;    /* freq: 8 MHz */
> > +            local-mac-address = [ a0 b0 c0 d0 e0 f0 ];
> > +        };
> > +    };
> > +
> > +  - |
> > +    serial {
> > +        ethernet {
> > +            compatible = "qca,qca7000";
> > +            local-mac-address = [ a0 b0 c0 d0 e0 f0 ];
> > +            current-speed = <38400>;
> > +        };
> > +    };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 7761b5ef87674..c163c80688c23 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -20295,7 +20295,7 @@ QUALCOMM ATHEROS QCA7K ETHERNET DRIVER
> >   M:	Stefan Wahren <wahrenst@gmx.net>
> >   L:	netdev@vger.kernel.org
> >   S:	Maintained
> > -F:	Documentation/devicetree/bindings/net/qca,qca7000.txt
> > +F:	Documentation/devicetree/bindings/net/qca,qca7000.yaml
> >   F:	drivers/net/ethernet/qualcomm/qca*
> >   QUALCOMM BAM-DMUX WWAN NETWORK DRIVER
>

