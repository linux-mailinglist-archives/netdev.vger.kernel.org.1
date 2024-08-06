Return-Path: <netdev+bounces-116049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD221948DA4
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29DD0B217DA
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 11:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB871C2325;
	Tue,  6 Aug 2024 11:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GB5nGWwP"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010070.outbound.protection.outlook.com [52.101.69.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3856C13B2AC;
	Tue,  6 Aug 2024 11:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722943678; cv=fail; b=Yo3yfERI4IUcdLkSOWIypxp4nVCclanskruHT7BP6J75iV1f7NXFMwJ28iAuOfeOxO1LXjbfdT/w3gDLiCQe2cZnxJrM8XNoOZHdh/W34ufTe/CV9TjwpBgUMe1HjLM/Jy3H51GSVNAvTVaszQ0fdFUVU6FQtd5zayYvrYN4ffE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722943678; c=relaxed/simple;
	bh=Fffe1334guEbasi2ewFbkqpOHEQ1Vja5+yjJmlG/6Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y0uNYTuB8HRUDZ+RI+rIN0fRh8oNaoZs6Cq4Yvw/6kWu+K4Ki9axygUgvuLQC7a73StAcTgi236xtyRiKfdz73TqN/pdp1h5cUEFqhEiNgARtkFeNLV78bx8k6OBgf4xr5oziMPxcvzqq/WmISl/wLA0BmSxx5u4rG+LEoXHXxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GB5nGWwP; arc=fail smtp.client-ip=52.101.69.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WtuDT14WNKKkhU8r1ByaW6xu9yV6GibyS5ACS6yB1Or68BwTYE6zsPA8If5ov/t+Id+iQKBk6WXBrPF5XiJsYOtFNS44+jVvzgLhDFgmpRN6hDUPJftW6t/Zu3FuX8EVtt3/r+8r9Nnj12D5BLLkV/enfkJKcWweF14uEKKrcctEQLbLGNPSTcYnKKqA0SswvIi0Chz/I5dsoCJJPBscKKxV9H0wgV1tj6E4uLzQPMFrdZZs0B+TyDijZakq32fCjrmBnkvLlnR6QJtMY8v3PIzIav2kCcOezaa1GptF72a5jVljY8oIll8qlT0bBOtm7wL+P/V5yhDuMo4oB3GGhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0Dp6EFxy+Y9SolB2I26SzwVzooUKoPaqbEPyfxfoAw=;
 b=vRe/w++Hmevd/ZltARFGYD4bBNkfhwqEqgWXFhFXIAlw+CnqzcGve2KTF1PORT1ZVHdHHDLdc6euvx/w/6WzssigvpRc99539hOk904DGLehXmGsNOLiRQRCLBqeYMAuUPX/Y7KrYkpDA8rlp33P5cLw03Ef4CRP1igchc+aqBW3mG9a7JDkWU5Yd0xw/qz0frF6tp9Xe8ZEfZ8wNYClSLZB2701XqdTJCFbvpjGLFgNEJIptOwASR3Z7/lZGHQuvCkTyjVbV73mQL7ojNDFc/jnGjXu90KB640uNsqAYmZUFCSkD+YX5QmyIvdUkDY+9Dd3EDuf7oYq8JqbFIwdDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0Dp6EFxy+Y9SolB2I26SzwVzooUKoPaqbEPyfxfoAw=;
 b=GB5nGWwPTRHWelWbdD1U4vmDjG6VPpTnVXMw5k2tJQpoQ6exSUzUpgSUNu+8+dKEfvHuARwfl2HMhz5rnFa6VFmQ9u7vH9qiHzmPFpTxy31GrE01cfuUWyFUpznjYH3TaxubDGjfSObC5P3j7bpYLPgZziFLxGIzvNVfByKcHiQ7OOeM3xpJ4G2eNrnjgyhT81CAhn20GdUe0fwkDKU8BhQgIY3rBMzCihKzp/SgNaINNKKWqjVs58pQUklx18+CrzV/m9wnAbjTcuVh6p+EKbQPbNVG2NW1PTQL9BHVlSqguy9EhzLOkwN1F/6KQ2+fSkc+XHUuuH1ZVN/N85slBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com (2603:10a6:5:33::26) by
 PA4PR04MB7824.eurprd04.prod.outlook.com (2603:10a6:102:cd::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.27; Tue, 6 Aug 2024 11:27:51 +0000
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a]) by DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a%5]) with mapi id 15.20.7828.021; Tue, 6 Aug 2024
 11:27:51 +0000
Date: Tue, 6 Aug 2024 14:27:47 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	Brad Griffis <bgriffis@nvidia.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Wei Fang <wei.fang@nxp.com>
Subject: Re: [RESEND PATCH net-next v3 2/4] net: phy: aquantia: wait for FW
 reset before checking the vendor ID
Message-ID: <20240806112747.soclko5vex2f2c64@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ac00a45-ac61-41b4-9f74-d18157b8b6bf@nvidia.com>
X-ClientProxiedBy: VI1PR04CA0120.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::18) To DB7PR04MB4555.eurprd04.prod.outlook.com
 (2603:10a6:5:33::26)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4555:EE_|PA4PR04MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c1ead07-5f10-4cdd-052a-08dcb60ace98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?stYoOnHuaisgaiRUqHyCwLuW8v0vQYQ5SXklcFFq2qkTMP7HHaocPeqT9f4s?=
 =?us-ascii?Q?hUceVv2hS6Wd29yiQfnLPEsut6dJcKXdO42OWA+kht8IuZD8SUTaDdk+cvB/?=
 =?us-ascii?Q?rEFI9NHRiVoexv2gTl14mAJouhFtoMWLHEBK9+uYZPvC6nECWF6TSNbXIayD?=
 =?us-ascii?Q?8hjDGjPgaB6qS86qYPayDDZ+tGKyokq5BCWxezN9qup3PJz0+hAuvnntM7d1?=
 =?us-ascii?Q?UtR0I9+HdVnwXeABlKu2VxgcikHIjGFKUoH5snU0YicrOrThfNsFK9ZX9FJ6?=
 =?us-ascii?Q?6gWQF0lv5YUWwCJp/CYOIGxPzmmfvIKncu8TMElwiGN7hEj7o597XTrDCtyv?=
 =?us-ascii?Q?rz1WBCGF/fXS0lUUKNfwBWB3VTGOsrbV32vPhNLVYk/qih2Y7ghVX9V2uI7/?=
 =?us-ascii?Q?ACne8a1hQOE2lN+y9o2P8QZYna1haqT40xEr/DmRoDctna5n197B19IbPPaL?=
 =?us-ascii?Q?+PpjKZ1ocltMs5Rm+s2/VCNqmbKh+NpyNO1JNGfr9ev6IzJRa7Anwjrloqd5?=
 =?us-ascii?Q?NMqjfuIFZ/XPR3XfldxXRsooiThch2TPEhGWkOmGG1skG4ktM9I+SZLiMcE4?=
 =?us-ascii?Q?6GbqURd4aikVXVfDeucYZq73OVHm5a5mgB08XluyjI+xXFD4XNI/5Dkjg7YQ?=
 =?us-ascii?Q?31L/bDAESRf4+Ybt8za0Y6ERucQPVGSYXAM1VQP8+Mb9Iu10vMo6PXdycK+G?=
 =?us-ascii?Q?BZWns4Z9UfEeeREFKcz5KVIz7C+OiiD/+KSTiuPz0DkD50kawNtYId5+epkW?=
 =?us-ascii?Q?B03Irl3QqibzGbGNIEvcdTI3g25UZN/uqwQSH/YRHjOCvOXQ5nbmesCPtkjj?=
 =?us-ascii?Q?lxA0pCXKSymHvg+cMJmzJVnsy+wqAKswJEnG02diPKEE6sFYHR9PGmao+FNf?=
 =?us-ascii?Q?KGm1WaueHdsHTKT8ow8ecmpIwZKtELec72oePTflu20Q/sBxBv48RnUnjOTS?=
 =?us-ascii?Q?piXnDnd3wIJSANYivPcmK/jj0CMkN6HYYZqH1r0hddC9+rQUxkdSUBSqKVeM?=
 =?us-ascii?Q?HVvodOJMF2doklE8/W+rMP2S9jbXtIfREDJqE2AyoRqWZUpk5YhHFeOXm/8q?=
 =?us-ascii?Q?Armxp6poHXGHULpuESgwSI+aMKb7I4UhIp0XvP8uf/If1ofF62TlDhH3byfw?=
 =?us-ascii?Q?oDsUKYUul5qrFZJFV25JOkNXq1t0tLUlhJDhqMlS4boSXGfso4gn7T1Z7YbA?=
 =?us-ascii?Q?ixeg9PRiPgk85ukXswqgw1KovisKGIJrA1W/+6Y+vtotdMX5biYTsQBHWdSU?=
 =?us-ascii?Q?msJovv6Yc0D1/TbCp04CQ3yhUYVJIvCcJnBMSwzKcpANpMv59fn/8jLcSSlL?=
 =?us-ascii?Q?bJHbzjZbTFuohaAjdeYZpOidyjehbEF99Nqj6+EaCLZ8tQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gYsLprG0uhV4rDLi8jfJpebqbBU/by+cIIyihMxpz35P9wfxjKPpOH4xq4yl?=
 =?us-ascii?Q?BPTIqMLFAtkLio+4gRpC937pSwzosdLmxs7a83hZtaSkJjWzQ3M6JKCuv9mM?=
 =?us-ascii?Q?vRI3MdIbLgkw7EKhG7B82vihDqX/0sGMTNFpSxNER27Vn3DHL7PWHDlKpbQk?=
 =?us-ascii?Q?KaZUtLe+5BF1UYSsappt1Y7gbHeVD4q7QJx7Va/va1NjCfwYH9MqHELu0npk?=
 =?us-ascii?Q?7M0eIjHrIebi9haM8RssV1p6ykzNQItH56ny79lZO8O6oOHIjUUENczx3jWG?=
 =?us-ascii?Q?PoIVqOvAIKE+Ba6hxVRk2VTv2np0yAME/Xxw2MjIr9uo/KJWGBMtgXzRHW0B?=
 =?us-ascii?Q?36r8K3e3YJo3h98ybcwodNwvaSVJN8ZGWidv1nxHaIKZZV4Y+sFOcO1JdPst?=
 =?us-ascii?Q?/DyVT5jhQ3eXuy2PVUU3b8nWukybSW2n2klFtkffLvCJjQBP/wBSb9ElPBiV?=
 =?us-ascii?Q?VQDKya6gcmx18rzVXurLvUlk4rUitXEOeaHDHqeKOyPDPzIMhwIlz4apIOGj?=
 =?us-ascii?Q?QVY3qjSucBfGx+owl17YEjwCiC/+p0uvO8DV66TZcYl9prTGJwti6g4Om9wR?=
 =?us-ascii?Q?6hWJCZVbP3RyXUe1P3MH+LQmVvzHdhz7/jeeEgpJ1G50RIbf+/RDAILC81jQ?=
 =?us-ascii?Q?20MAxoABabAe3BVs9ld0h8EUwZFSCj6twsLJr3V47yelso44q8hMWwKn/UCz?=
 =?us-ascii?Q?iTY/D5cZjDQq2HyROUzBhclHhIkacfjovMD43X5wcEyB12YBs3f73DYEfEIm?=
 =?us-ascii?Q?y6+W4aWLEwiG2J6fddSs4fZTHSEMUbf9h/FfsXpb+2D04gPm/3tOhh8+iJPj?=
 =?us-ascii?Q?FVVRwJiA53BnW1v4izXUzrwBD6hPIAxyYGAgUBYZ2oI40qPT0svmFkHA9qRQ?=
 =?us-ascii?Q?muV4VWAfd6U3uxl07RHGNnJBIkluMavZh/q8dXU5LTWlzcX5ubeYV5wTX0Hd?=
 =?us-ascii?Q?zbZhK7iNEwE643ilPREGwQky/jqXhOst/WxbJg32T+BgtArilBQuYZULjPr5?=
 =?us-ascii?Q?0iTIEwjwnGhxA4mrX8dms9nbrMPBrk04BBJlkbz6WzuudNZDB8dtxSQYQfDR?=
 =?us-ascii?Q?c/rxM4eZYeVavu3Fpiivoq+dOxg7gBDFZAYHrfAmxWT1t+OpCGv9oig4j2Us?=
 =?us-ascii?Q?T8qAED11Nglk4yF2HLldb4klsYZ5sQmQ47znaNX+2lD/RX1PgaMe2NhyZM+Z?=
 =?us-ascii?Q?1UdO2SHDaLIRCT/IQs5mYbSHTNJDmR2cWJzIKLEo2UCcaEguR10Rdz04Of/n?=
 =?us-ascii?Q?5IUd6nZgWahKUfqsfzqtRSYXZYCpgyE4QF8C3Iwwoimuv4S7HmcfC+H6Dj1s?=
 =?us-ascii?Q?+vIu7YBy1SqD2iK7lbGvF2p1i01FOKZ1zumSyGHjmWJCoukPPQK7vU6TOG5G?=
 =?us-ascii?Q?Hg3m1IU07S/82ozTZXIrG1AMybsTtOh+FfQO5VQ22pM/861GokE39lUJmSnc?=
 =?us-ascii?Q?Xg8LWs3J8PwnHg3CVkwrdi6u06muZYFFfk7drCu+saFExVcdJIqdMv99B1qE?=
 =?us-ascii?Q?9JdCynqIctP7yFM8vQiSRH7OOqhRduu1YcOZZHn02my9Mnvry63ayhvX79Xf?=
 =?us-ascii?Q?/y+8vitXzUK8EglxatQgf3wFnd4Oir6kz2P8yPZaFyzP1Y7Dkvs7Y+he1IzO?=
 =?us-ascii?Q?jQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c1ead07-5f10-4cdd-052a-08dcb60ace98
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 11:27:51.4615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: odkTKVzEo2RYFMfUr2P+DV3A8Hc3qFXwr9YWBc1t53h4szOs0/7urW3NoE4AgXz8u8a7LUQLWXLC0IKBxK1OsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7824

Hi Jon,

On Tue, Jul 30, 2024 at 10:59:59AM +0100, Jon Hunter wrote:
> Hi Bartosz,
> 
> On 08/07/2024 08:50, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > 
> > Checking the firmware register before it complete the boot process makes
> > no sense, it will report 0 even if FW is available from internal memory.
> > Always wait for FW to boot before continuing or we'll unnecessarily try
> > to load it from nvmem/filesystem and fail.
> > 
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >   drivers/net/phy/aquantia/aquantia_firmware.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/net/phy/aquantia/aquantia_firmware.c b/drivers/net/phy/aquantia/aquantia_firmware.c
> > index 0c9640ef153b..524627a36c6f 100644
> > --- a/drivers/net/phy/aquantia/aquantia_firmware.c
> > +++ b/drivers/net/phy/aquantia/aquantia_firmware.c
> > @@ -353,6 +353,10 @@ int aqr_firmware_load(struct phy_device *phydev)
> >   {
> >   	int ret;
> > +	ret = aqr_wait_reset_complete(phydev);
> > +	if (ret)
> > +		return ret;
> > +
> >   	/* Check if the firmware is not already loaded by pooling
> >   	 * the current version returned by the PHY. If 0 is returned,
> >   	 * no firmware is loaded.
> 
> 
> Although this fixed another issue we were seeing with this driver, we have
> been reviewing this change and have a question about it.
> 
> According to the description for the function aqr_wait_reset_complete() this
> function is intended to give the device time to load firmware and check
> there is a valid firmware ID.
> 
> If a valid firmware ID (non-zero) is detected, then
> aqr_wait_reset_complete() will return 0 (because phy_read_mmd_poll_timeout()
> returns 0 on success and -ETIMEDOUT upon a timeout).
> 
> If it times out, then it would appear that with the above code we don't
> attempt to load the firmware by any other means?
> 
> Hence, I was wondering if we want this ...
> 
> diff --git a/drivers/net/phy/aquantia/aquantia_firmware.c
> b/drivers/net/phy/aquantia/aquantia_firmware.c
> index 524627a36c6f..a167f42ae36b 100644
> --- a/drivers/net/phy/aquantia/aquantia_firmware.c
> +++ b/drivers/net/phy/aquantia/aquantia_firmware.c
> @@ -353,16 +353,12 @@ int aqr_firmware_load(struct phy_device *phydev)
>  {
>         int ret;
> 
> -       ret = aqr_wait_reset_complete(phydev);
> -       if (ret)
> -               return ret;
> -
> -       /* Check if the firmware is not already loaded by pooling
> +       /* Check if the firmware is not already loaded by polling
>          * the current version returned by the PHY. If 0 is returned,
> -        * no firmware is loaded.
> +        * firmware is loaded.
>          */
> -       ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_FW_ID);
> -       if (ret > 0)
> +       ret = aqr_wait_reset_complete(phydev);
> +       if (!ret)
>                 goto exit;
> 
>         ret = aqr_firmware_load_nvmem(phydev);

I agree with your analysis and we also noticed this.

But actually, you wouldn't want to ignore other return codes from
phy_read_mmd_poll_timeout() like real errors from phy_read_mmd():
-ENODEV, -ENXIO etc.

I found that the logic is more readable with a switch/case statement as below.

diff --git a/drivers/net/phy/aquantia/aquantia_firmware.c b/drivers/net/phy/aquantia/aquantia_firmware.c
index 524627a36c6f..d839f64471bd 100644
--- a/drivers/net/phy/aquantia/aquantia_firmware.c
+++ b/drivers/net/phy/aquantia/aquantia_firmware.c
@@ -353,26 +353,33 @@ int aqr_firmware_load(struct phy_device *phydev)
 {
 	int ret;
 
-	ret = aqr_wait_reset_complete(phydev);
-	if (ret)
-		return ret;
-
-	/* Check if the firmware is not already loaded by pooling
-	 * the current version returned by the PHY. If 0 is returned,
-	 * no firmware is loaded.
+	/* Check if the firmware is not already loaded by polling
+	 * the current version returned by the PHY.
 	 */
-	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_FW_ID);
-	if (ret > 0)
-		goto exit;
+	ret = aqr_wait_reset_complete(phydev);
+	switch (ret) {
+	case 0:
+		/* Some firmware is loaded => do nothing */
+		return 0;
+	case -ETIMEDOUT:
+		/* VEND1_GLOBAL_FW_ID still reads 0 after 2 seconds of polling.
+		 * We don't have full confidence that no firmware is loaded (in
+		 * theory it might just not have loaded yet), but we will
+		 * assume that, and load a new image.
+		 */
+		ret = aqr_firmware_load_nvmem(phydev);
+		if (!ret)
+			goto exit;
 
-	ret = aqr_firmware_load_nvmem(phydev);
-	if (!ret)
-		goto exit;
+		ret = aqr_firmware_load_fs(phydev);
+		if (ret)
+			return ret;
 
-	ret = aqr_firmware_load_fs(phydev);
-	if (ret)
+		break;
+	default:
+		/* PHY read error, propagate it to the caller */
 		return ret;
+	}
 
-exit:
 	return 0;
 }

