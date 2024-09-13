Return-Path: <netdev+bounces-128212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E66F0978825
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 20:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A32288EAA
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 18:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF6C139590;
	Fri, 13 Sep 2024 18:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BseMTovv"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010071.outbound.protection.outlook.com [52.101.69.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF098172A;
	Fri, 13 Sep 2024 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726253464; cv=fail; b=r3pe5AmJ1Mg62CFhCfy+6Hq4X4JG77/ccdJBjO6Igx5jqE+Zew8xzVGXWmoTUC453RtsSYY3DskbIYQg4fZq7DqK4J688bZyVIgpusrqHI//wfn6Zq9Bj4fRSnEHikUWSg6gW/hmI5WKfPMLyaHIcCBSGF5MOnAghH+MnVh33xY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726253464; c=relaxed/simple;
	bh=fkMZwTS7XmR89TqxoZ9Twwy8SRdBCMwt0gsrttYOqak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LK9HxD8QaUWpciyVh3ZsBCKFxsgzbvgtYJPUIz72Rd5Ydyb7o7eScco5dmEjfkX6oQyOUAJcqjL+1BPSQ3YbbvvMkAInXhwsj6acVHgc0m/XnZicWcf2u58civA6PN1L6AKYE/u+Gi0WruzclqS1kcurxy/WMRi2qEl4+8KoUoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BseMTovv; arc=fail smtp.client-ip=52.101.69.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ML/K5JGVKk16TYfPWltNNfq9SP4zVSKhEpAByPJIEd6eiZ2Fe6BZYxG6e3FsOkivlgcnhF/n1nkWyBQ9E2vri8yLXtpdMbdn0Iv3Isk7CW2OH9TnwGFt4cBsJ76seVS8roizmwAriHMAKR5CLpoifCn4PHHbPLk3WnmketXMKjZBn9HF20y76VGyNrIfAbgYl4DJAsHJZe3qrrbrmGeMYLKR1IJYzdWwS/vjIky4ZYzkIf595Nr08PEGXYZsqUUwwS83qJ1rxMRXWpMD6njRadwlIxzOmL4+hf/KWM0IiqOpvsIOCbM1RhIgsHTaxAVzUlp4daSfKz2KZ0p2fsRL+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioX1cMPY0xF+YU4kcQrOtY2Gu0TZmvawWi6+xcSz150=;
 b=m72pH+7Lxj/X6cXmnTNFvuPiXoy2g6sfg5sY4NxRsQvfPIv8QyX2iTlK5sjENny1Q9YUw427tkJuyICK2UZQXqpiE4VFipp5wUlgwuMvcFWtCJlExH+ACSIbl2jDzU1lNs22/GgnjFuDjPCH1+WIh3DE8cyOCgPeP9dr1iJKFByo+hR1cSIJAJIwWrn/m/bCMFJ6ACOzqaM8r78VA0hAP1GCYteOh7Zv7f+q5fQbIxnQ1T5R2n/4879HT11kfgXUXvYZF/n/Gi2+1J/Yyjl2vczJlZrrTJQ/ZyWxdX3sqZM37okI92xhI2slakqzkLwLVQ307bga7mhQHwUwvKVQCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioX1cMPY0xF+YU4kcQrOtY2Gu0TZmvawWi6+xcSz150=;
 b=BseMTovvw4fpBFzxSHmXGlHbpc0VwTixewLgVKlJtOf4ok8y3v2C9sZbDCXUd6ths+oxhonYPzTaFLUzK6yG+ul+kVtE3OsryFTNZSu5WqJMdSRdtwLG9Ztuiyud2/Lmr5DLq1CcrWHtWg/7GmVrlgo6NjjZTEqX8jYqJALUbrrAUuEyjlPRZt/Fv8VVd6ZDiCOWAhl0OWXOLla351thoHcQRUGbxRz/aexkl1Z7QCtZ0SLwsPKdwnMisIyhJr0yJoFtbP6/LiyjmN2uGctmd4qE0h/M3W9BfyllvMl4ANTVE/0EbxFDB+XIz82h7p7nJPtrLeBaGAeuT7sHx+G+Ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI1PR04MB10025.eurprd04.prod.outlook.com (2603:10a6:800:1e0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Fri, 13 Sep
 2024 18:50:56 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7962.017; Fri, 13 Sep 2024
 18:50:56 +0000
Date: Fri, 13 Sep 2024 21:50:53 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Conor Dooley <conor@kernel.org>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] dt-bindings: net: dsa: the adjacent DSA
 port must appear first in "link" property
Message-ID: <20240913185053.rr23ym5otprgiphb@skbuf>
References: <20240913131507.2760966-1-vladimir.oltean@nxp.com>
 <20240913131507.2760966-3-vladimir.oltean@nxp.com>
 <20240913-estimate-badland-5ab577e69bab@spud>
 <c2244d42-eda4-4bbc-9805-cc2c2ae38109@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2244d42-eda4-4bbc-9805-cc2c2ae38109@lunn.ch>
X-ClientProxiedBy: VI1P190CA0050.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::15) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI1PR04MB10025:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c0dd374-93b0-4d13-f263-08dcd425005e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LXCEGau85UjjJhhQw+SIxtz8atG0PRFyWclek3V7WsuB4h2cc5B23gB84sVO?=
 =?us-ascii?Q?vG/N+56LdwcZNqTrdUZ85BfNRhQECiKSU3hl+G7oMnyNHnLrPHQtJyAFRvhJ?=
 =?us-ascii?Q?qGb/H6MUotWF4h1r5TBYd1127/ameF4yIXVBwh4ywEiFQb0MnKjNcwY2hdIM?=
 =?us-ascii?Q?rJ6MjgsnKBQhOJOOA4o1edzL4QnvfWP9LkF0eGwmL79BI3s3mlxsTA741SCg?=
 =?us-ascii?Q?wIzKYyiQvUxHIU3PgUJB7RafIIgwPH6SwYTOUoQj95xgVUSb8NW6RFhHEDGw?=
 =?us-ascii?Q?3nj1J7WT3eum8eNCI+DRPY+kEmpGIDzcfK6qiC2WO4XHGZcy5ggHPIkfJlwp?=
 =?us-ascii?Q?DAuskF5svj904OqtUoDQq0tZSgYWUmDVysROBJ8l23tHmF8vd59ybaT8CCKy?=
 =?us-ascii?Q?cYOtbfht3GePqnJABaN8vfcy7nnSgyK9sAbYz0rnzWUBxfjgMGSsl0TxMRPT?=
 =?us-ascii?Q?aBZgufXXCm5acnYPVNrdFfUS/v3wFpbOyzi7hz+ep8XXh9sW0hcpkY7soeh/?=
 =?us-ascii?Q?lkasWJyrUnxgtAinEQLkpj1cOcEcYLcDRWK8mPWPIMZOCRdl9zgtQ73bZQiI?=
 =?us-ascii?Q?55MutW8kHqyQIwJlxqu6/NawBG4Ae9IviJKIManOnwmUKDBHvtm8aXF+uOOp?=
 =?us-ascii?Q?iRdgh3F90XzuHuKgRZqmomr1iyY5SUY+NVOauw5pEc3nfL9OyvI0Bs51FLtF?=
 =?us-ascii?Q?RtjfGaHdJYSFypFdPIyGgtsv77NivOhdSGRbMbrUHtUIPd5NPEB195NYryH+?=
 =?us-ascii?Q?ZJ5kHj7KWSicKc8vqCgBOSbJfpD1IjHF5zv50NQYqFVhHqG7aBO/g4122gqO?=
 =?us-ascii?Q?sTNmKZEEuff9QMsRg0P9m6Sq4OgclKzwofj9KZDmvnCfkrC3JyXwZka8xnEU?=
 =?us-ascii?Q?upmcsE3adTCaijt3/xmE5TKGmMI2rYVKP+lzTVY/HoZgxjLiHMkFbgvU4+mh?=
 =?us-ascii?Q?jDHrx1Z6UCkbc1ZKHgeQ4+EbKOrGr3WbGvtcAv6aC4+GcyqOUrslPPdrXTPT?=
 =?us-ascii?Q?S8q79jbMLznOkqK0ZihGG1VDTGPniXtG3rfxvadXBfzOpo1UaVS5/pccfICT?=
 =?us-ascii?Q?9bz7oDefp2EYMYpgrPJTnJublQvWVlJjZbKKlxt6QdKfJhWbGQ7Xrj4TRVEP?=
 =?us-ascii?Q?1eQ0YQpZ728Ca5GLOThKKWdQgkc9Nl5jh2AaWLFeIiPcxXS9Qx8foaDBkNsl?=
 =?us-ascii?Q?OeEcgObWTUltxY9ET4luNmV/UDK3/DVQ7hDkpgvQyXmygQtWkTxyexww/gCY?=
 =?us-ascii?Q?dQ07EPcqe4reUq0CPvcdBAj5/PvGrJ3+pOwRhpvETgRb+arbSh/NusPiSpwi?=
 =?us-ascii?Q?qQjIWotj6LdydQ6AK6c/wk6t2xInNZGdcOgcBRrSxO3HHw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MSy2UnkZ3oIau8HL+2z/uV9wedkpDde22/qI2e3QJrahMO6lM+JpUzuWM5jJ?=
 =?us-ascii?Q?qS0VP8Ibj5pZ9mwlPK82W2T0U0IHcIxuBwQqjMRVzmydcKAmHOPWlIBQXOeN?=
 =?us-ascii?Q?NJCnF9fP/EVh68N8H5fqv2NTqyKOY+s+OouLmuhjOApB+dHTPd1UDdw4Rjo2?=
 =?us-ascii?Q?AbtEY4avuBRGwp7J5fywAQhgyom7UCA29z5zBLpucgnyHvPZ+2eS96YdOTMV?=
 =?us-ascii?Q?/mJfDJUzzx6nFFy5Z3ek5+mqQqhowM4x2wuO+BxhKuafNET3MymI7/tnbF37?=
 =?us-ascii?Q?1NkLZBzWX85mhqKpqTa26g015L5bzwdVD3tphTWCwsgO2rpQvj0xUUkwN1lR?=
 =?us-ascii?Q?JsTy1meJPpkd3pEVWMIX1gex6TLrY9Mtm5w8yQXabSJjVCh4VqfVC9Hj/qTY?=
 =?us-ascii?Q?UI2nag5JkbLrinR8RxiiQ02MOE3z+Ujfk24kgcVnIB7IssubEWpu6zGnwvGq?=
 =?us-ascii?Q?IKbC3wbSx5pa1C2a+wD0zLf7PTOC0vwNXP2QXVzvPptgNDlrhehG1Ez7X+gN?=
 =?us-ascii?Q?DVxAtROxn1OZp/9qiNR7VL14TlsJgSYnjG6s+wFM5caxU09O+oY8YKwdskiA?=
 =?us-ascii?Q?GwSq/k2lTiQBtwODb/OrVMIUytq2r+wpKbuScZTbt9jta4vtHD7j523v7GXO?=
 =?us-ascii?Q?/03fG2ITtfKrO/+Hjy8TfHlkchnKbvMByWKUtLbIZeyBm59h+Z5iEY99Y2Gg?=
 =?us-ascii?Q?UAyBxcT7nkzt2xGYiBFMVfghRtsoHBxkSC0RAEhrHzeczloLso3iygs4Admk?=
 =?us-ascii?Q?H+pinI9qJhF38Za8dRj3KoXGMQtn44DyST0fCzYOfjyXpgoxYTWyR57IzT8u?=
 =?us-ascii?Q?Lj9DuEsyRHFxYa1/ekjuCFtoXIWd5UToptio4FJrVVewi8B4atyWgR+fpY0E?=
 =?us-ascii?Q?PY6GI1rVzG9SErMWzsPuBRm3AV+JdvC3ebxltiPws9uPP45SsQMj1uM862Vl?=
 =?us-ascii?Q?83TXSP3b93C+L2lANXRDFFgk5l8/qtZj1lc55nSZLxwwY/jngkFMmf0muOVS?=
 =?us-ascii?Q?S5cLQkeb60u82R/WxUtiRrozmdujleWPue5zQNQfb/g2vDKAFQxCq+RksyiN?=
 =?us-ascii?Q?n6cmwQyPnWjlGLoXADr3OmjqTcqv6oDI8A3rIIa5/tbdwb1sKRvrTrwTbTIc?=
 =?us-ascii?Q?aCh/tzpdOh/6caQ5wXFmkKZnLYxZNygfBB1UXMQ9CKA662h0xCWv2snVw92C?=
 =?us-ascii?Q?FjsQMdDSEb7y1QvYvXcY7BNLz6nhKIsJ6WDOE0x46CjpqhoYwUIkliVHGmQ5?=
 =?us-ascii?Q?tT3d/090zG3zFqmxajcPcn9AzRKch0wdWOLc4ZLYibgTLcUlBtPwuC17plW1?=
 =?us-ascii?Q?OeAET4IzCj0IQ66Fu9KWeImu8vHY604JTxM22A+PtsoGltGmLAm4oTRHvKyk?=
 =?us-ascii?Q?LA6a/5nJvZpCaxJw/zXhvtPOktgrRFot0qHG2Iga1wBcGik7v+JV8+6vSkno?=
 =?us-ascii?Q?J+lqxrEU8Xwci9fRPffZ3FHJRYVROIOCTQ6GPUaGfQSdaSSrmqLk17mk1POu?=
 =?us-ascii?Q?K37Kg9HIAZK6D+mde5/cFalIlg8zu0EyF12we3Zlj/3UGoBClwoSntPNFuen?=
 =?us-ascii?Q?N3MMyT5xmC14H3KX+j7vEG/l/i/EBA+CFT+jwOHlOdBq6DF2L9Mdnvboys7+?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c0dd374-93b0-4d13-f263-08dcd425005e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 18:50:56.7619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jP2G8COsk9sP69Z3ODoKDntyvVNxXfY75zyedvY+g1kg6XJo7I58iuh6coxL7P4XMWLysH36v8S2kSK0sFj3XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10025

Hi Conor, Andrew,

Thanks for taking a look at the patch.

On Fri, Sep 13, 2024 at 07:26:49PM +0200, Andrew Lunn wrote:
> On Fri, Sep 13, 2024 at 06:04:17PM +0100, Conor Dooley wrote:
> > On Fri, Sep 13, 2024 at 04:15:05PM +0300, Vladimir Oltean wrote:
> > > If we don't add something along these lines, it is absolutely impossible
> > > to know, for trees with 3 or more switches, which links represent direct
> > > connections and which don't.
> > > 
> > > I've studied existing mainline device trees, and it seems that the rule
> > > has been respected thus far. I've actually tested such a 3-switch setup
> > > with the Turris MOX.
> > 
> > What about out of tree (so in u-boot or the likes)? Are there other
> > users that we need to care about?

In U-Boot there is only armada-3720-turris-mox.dts which is in sync with
Linux as far as I'm aware. Also, we don't really support cascade ports
in U-Boot DM_DSA yet. So all device trees in U-Boot should be coming
from Linux. I'm not aware of other device tree users, sadly.

> > This doesn't really seem like an ABI change, if this is the established
> > convention, but feels like a fixes tag and backports to stable etc are
> > in order to me.
> 
> Looking at the next patch, it does not appear to change the behaviour
> of existing drivers, it just adds additional information a driver may
> choose to use.
> 
> As Vladimir says, all existing instances already appear to be in this
> order, but that is just happen stance, because it does not matter. So
> i would be reluctant to say there is an established convention.

Yes, indeed, it's not a convention yet. However, it is a convention I
would really like to establish, based on the practice I have seen.

> The mv88e6xxx driver does not care about the order of the list, and
> this patch series does not appear to change that. So i'm O.K. with the
> code changes.
> 
> > > -      Should be a list of phandles to other switch's DSA port. This
> > > -      port is used as the outgoing port towards the phandle ports. The
> > > -      full routing information must be given, not just the one hop
> > > -      routes to neighbouring switches
> > > +      Should be a list of phandles to other switch's DSA port. This port is
> > > +      used as the outgoing port towards the phandle ports. In case of trees
> > > +      with more than 2 switches, the full routing information must be given.
> > > +      The first element of the list must be the directly connected DSA port
> > > +      of the adjacent switch.
> 
> I would prefer to weaken this, just to avoid future backwards
> compatibility issues. `must` is too strong, because mv88e6xxx does not
> care, and there could be DT blobs out there which do not conform to
> this. Maybe 'For the SJA1105, the first element ...".
> 
> What i don't want is some future developer reading this, assume it is
> actually true when it maybe is not, and making use of it in the
> mv88e6xxx or the core, breaking backwards compatibility.

Backward compatibility issues aside, the way dp->link_dp is populated
can _only_ be done based on the assumption that this is true.

I'm afraid that any verb less strong than "must" would be insufficient
for my patch 3/4.

I have unpublished downstream patches which even make all the rest of
the "link = <...>" elements optional. Bottom line, only the direct
connection between ports (first element) represents hardware description.
The other reachable ports (the routing table, practically speaking) can be*
computed based on breadth-first search at DSA probe time. They are
listed in the device tree for "convenience".

*and IMO, also should be. For a 3-switch daisy chain, there are 8 links
to describe, and for a 4-switch daisy chain, there are 22 links, if my
math is correct. I think it's unreasonable to expect that board DT
writers won't make mistakes in listing this amount of elements, rather
than just concentrating on the physically relevant info - the direct
connection.

Baking the assumption proposed here into the binding now makes the BFS
algorithm perfectly implementable, and the binding much more scalable.

Do you have reasonable concerns that there exist device trees which are
written differently than "first 'link' element is the direct connection"?

