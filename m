Return-Path: <netdev+bounces-223460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD74B593E5
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFFD33A307F
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 10:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8575128AAEE;
	Tue, 16 Sep 2025 10:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dth/vhQW"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013000.outbound.protection.outlook.com [40.107.162.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEA51DE4F6
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 10:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758019083; cv=fail; b=MeEW+pzhn3b6xNyG54ERIOye25s8NnHCvyIb6VOSv9bmVE7Y0H4jFn9zx8btLrV94V+rb0haF5UpjLQ5H5+m81dpyYHnEACwuKZdIcRvz8NnKjVLipJwRQ8thacbzCE2k6XDhDOoLi2annRogaWdlVUJ+DWdz9PFVvxd5Y+LImY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758019083; c=relaxed/simple;
	bh=LkMXLYXOnvFY6ymUSYTfz1VjfDxq7oN6MIgN4Fh57GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c49OCI3I0L9YI3Ow3XWfc6QUAcTa1PfkBcFV9S614YZ+uoOYuSZf4SZzb6qhA91U71dqzsoV07wKkds/BNF1UhYtfT2cx9+m6GrZGc5o0hBW2TMoCBevCtQGszmyJZSVerMVL1bXBpcW3nXe/unvKXJacAiiD5M2H6V/kmh5WRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dth/vhQW; arc=fail smtp.client-ip=40.107.162.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dlMfHNwOdPngT5ADb8Zth40+YNiNh670JjejGOIGIHi3AmFz5NR1Oc7V18qE8W8j+NkAUq0hynH6ANXNulguY8vl1Xxit1kMG8D29FGqJM4Nw1YUyUGhKSf3NmPmTo2+jjT0UZQAMKeBQgZiCGo36DvPOHYzJ6o9IhxzlbP0e3Bm6n4h53eOBmprx80YgTLxqdhW9yU2GErvCxQuoU0lmljO99ZdGLy2daFcDAXt5iMvLKy+ayzD7ljS2aKsXzRLcckiOsr6nHIXgyVLfcqXfsriYtgR7LXIDYJeewpc/U3QTiBB/18NhDDLCpOP3/c1UTyzQOm5e+W5tnv2sH8m+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5MBoEp/ZgkzrzGgGzQBGkELYxt7wYZSSQFKZjgTcJE=;
 b=A2E3v3T/y7t+sBfNHl8f+E7ZXpEL527+/YRIhotSs5Dqg0bgqaeJh0s1TPihFL3uxqA3vcvorgG+ZJrL0y0EMjC6bOzzK+5Aea2SQwZDKsHEJQ0E/x1V/9G1JOTlp8GeNdsQC4Ye4adL49XWdJrxVfKLgGSRLf8iIZerVzynddF3xL373+4U1dbg++lbhrmImJ5BXBi7QGCn58gX3nqB99ERvUzkpiGDs5xwlNvmNJmPE/+cYoIMZpOW1ZlRFWokP8HQoe8lbX9qPZNaJfHsd8irRNgyXVPxX3azv1L7ENwjj2ddz+YPVrBUXLNW6UbS/TE1YPCaOxvOjcMe7HDg6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5MBoEp/ZgkzrzGgGzQBGkELYxt7wYZSSQFKZjgTcJE=;
 b=dth/vhQWPgxnq6Z9YCdGOoxwFRrONwtz7rOsry/5rdoMfTaamX9s2FxWNwytQ1B+UgQ/+YcX1Dex/xP7pA8HdBPRWcsrOWYLqstWrVAki4ZxHe6czxxu33GVySvunLitiNlLGT8xTvKhK42Up/zFzqO3F1KTyMOJgns0uCV3PMickk4mOjKR/8WcQXTaOtNDmgqByMJh5KLe3sJP9bKr+glAAm7KEHOt0wfD+oGUP0H55EFuol7RPJI/daWLqDt9RP80kgj138IydwotAuFE28HTZZZoErTyx2Awpby8x0hp8XHTFXiIxGqvTG5sGe5up5GTCrMilaXkMoCCUkVtBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by OSKPR04MB11463.eurprd04.prod.outlook.com (2603:10a6:e10:9c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Tue, 16 Sep
 2025 10:37:58 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9137.010; Tue, 16 Sep 2025
 10:37:58 +0000
Date: Tue, 16 Sep 2025 13:37:54 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Dumazet <edumazet@google.com>, imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>, netdev@vger.kernel.org,
	Nick Shi <nick.shi@broadcom.com>, Paolo Abeni <pabeni@redhat.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Wei Fang <wei.fang@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>
Subject: Re: [PATCH net-next 1/2] ptp: describe the two disables in
 ptp_set_pinfunc()
Message-ID: <20250916103754.lvr2a5fs44h7odaa@skbuf>
References: <aMglp11mUGk9PAvu@shell.armlinux.org.uk>
 <E1uyAP2-00000005lGk-2q9l@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uyAP2-00000005lGk-2q9l@rmk-PC.armlinux.org.uk>
X-ClientProxiedBy: VI1PR04CA0082.eurprd04.prod.outlook.com
 (2603:10a6:803:64::17) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|OSKPR04MB11463:EE_
X-MS-Office365-Filtering-Correlation-Id: e1f2be09-935c-4a1e-3923-08ddf50d1a2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|19092799006|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oSMVwP+vyH0FesaOVBoEjSoV5PwaI/FfPY51jDoRDcgcLRMKeJHDA5Cquu01?=
 =?us-ascii?Q?old9Uit5Ude/KiqfAjwbMCr5o1Ab96qq6LqsiAgLAcb2FUSae6/CMirvJyL0?=
 =?us-ascii?Q?Dew5G5/Es5+Rrog3kdwwDXS7d6nGyqfndj3ca0uWRQL+TfZSfdJg/UJe9NUZ?=
 =?us-ascii?Q?3AJBj2lOA/Itgm06odTIwBs7xjSkk49KlzwtubLkNSMPE5lueRb/2z77++z9?=
 =?us-ascii?Q?9DKxu2IuE3NLnnIsZmTmJPn6tQNADkjUfb7JJHEpNSsSVl9lAvpFGww7zWpg?=
 =?us-ascii?Q?4BPbHaKzqrTL87F2sm3hj4DYiPJzqpPiPTXbuIm+blMWENeS8+2nrdX2RHbQ?=
 =?us-ascii?Q?xQXZQcwDrPtw/MJ4phP7WK98n2GuANwAaytvDF+ikJAlUp0ZU7wR4LHKpiUy?=
 =?us-ascii?Q?H5GoQrsunf/2Iddio109HZHaolw9EURRqCl+4eVL3P4W/lpk142TB+2N02Rd?=
 =?us-ascii?Q?Aoj/ODaRUa5HnZeueJ9qSXG9h3NEQ4/eLf1hp3fDtfjRHWN58FB6jr8immL3?=
 =?us-ascii?Q?nRlERsaZX4IKS56p+wH2FFoBb69Ii9epKdMHjW36TJOnJWQUJzu+7+lUVr/j?=
 =?us-ascii?Q?85NVLblEoYa7cInhdfcAok94gSwjYp/fh/3yAEguL5Wb2UTnHnoKbK+ajilc?=
 =?us-ascii?Q?A8pOYFHMaxuzAdf33p7/cZpg5jTiZeVQt7BHDVIZtrcidczBGDB3ViwKwJ+P?=
 =?us-ascii?Q?JV9ow2ldD4t/xXQ44J7bCeLlWIBM6SbNTnRVcebFsI4ddLRl/QXjx6fkooP+?=
 =?us-ascii?Q?wi/BfEt9WnfTXGrT+OhcJuWMKHLBtR1x29I/KdVDq+9un3RXrNTZn9Cf5kke?=
 =?us-ascii?Q?oj8CbSMfY7V8h4hVyYWbXmXVvq8yGZjhVULgk9+5azf8m/SHYhe9y5hpHW3m?=
 =?us-ascii?Q?sBksm+SrbQ1ZsAtB3mWQwjNy4zkVhugZ3bockmlISNy43hjZSAPLJClOteWC?=
 =?us-ascii?Q?MdIDKRoP8qwVE6xDGWzLEplmK1iVLFDnELBIVcBAMDz8iCSNn/ZMPrnNzUYW?=
 =?us-ascii?Q?IGf7ANsTNPZYjwKg5koAhopVHxK+/fQEVLZ7S6zgiC6Ts+lrxPn/1JeMS+W6?=
 =?us-ascii?Q?2b/xt6jbUkD71mIDSZY/WOg2m3FX/6CbgZ2Qpw0DcKB1qfptWnxlKLk9uiO8?=
 =?us-ascii?Q?QBUV5PB7J9Q4gxmkSXcRaCBX69ExmsUWKouHr29gmfWpDRVt9jH1WfyuDCms?=
 =?us-ascii?Q?wz5yCzErDi1ZSNUcWUvrnpy2gJUqQY3QsOZ6YVMQOi7C4DvQuzwHDl8TcQl/?=
 =?us-ascii?Q?OaRq4aUmic41BynFcrVRyCK917+Z2bbHGKV/OFPPn6OIh/7OdjjgSNqVu/i+?=
 =?us-ascii?Q?mT9ZuhQy61EincrPNLcCHRAJmMPph5fJKaBdwuDVS3mwM3XTNOGBsk0fDE4l?=
 =?us-ascii?Q?itLjqOuYfKXoYRciDzAlMtzKbTotM3Nd5wAZPpX35qz6d0CZZ6v7Ei+B550l?=
 =?us-ascii?Q?8VWvFiyHs5g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(19092799006)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6/KK2PYOUVrHgdGiDWdnhqBNVqDHCi5R/39WnVHrAPxIXIfd0/Q/128E/x5m?=
 =?us-ascii?Q?xtnYvTYoZAxkPC1UUhG8pYPMFoINmPbEtWlm5gGr9VCXbhIWs1Mw/fGmEzkD?=
 =?us-ascii?Q?AQnh8EjSzaGkKmBDJVDcE3+G0PhWFmUS5pLKYM6jyHsjEsQ6PrryUlD3G94m?=
 =?us-ascii?Q?7EJ5tMPcAa8e5vUGRjmsqBKVSota3LqPQ6iTMChSgJCl4/9xAV4E5uSnrsf5?=
 =?us-ascii?Q?rAnUj4RoYSDkyN3YLvX1jNuKe/2b5QaTmtaOwnssy5If/hwDElXTdjdnVVme?=
 =?us-ascii?Q?me5vG2mZUfIDsgIGASaz+P8aT3oai9f4j6NUCVmswy0KP2WNaRvJMc1/mXk6?=
 =?us-ascii?Q?jjjQDRm/6xFm00yUmrSqhAXwfciQtWahDZCo9cOJsOhXHtBhl9pnxXeBe/gg?=
 =?us-ascii?Q?WIRJBCZ328DMLkVw/9rpuiDbYU1jF4aovn/1q9z1fwgh2zaCrV2S/m5Okd/X?=
 =?us-ascii?Q?prYjr7zfIunB6vxhd/gtUfq3C23Yh2DoTdWqbi5M4fIXeqbQbmt5xLb+D5f2?=
 =?us-ascii?Q?T9c0WWDRK76Dn7DP2NlS/vqOiRLko3QKw8g31Eaf69q4e1HJaLKubdQQ5+Js?=
 =?us-ascii?Q?ehu6+n33lQe9bThS4H7ZLB7MHpTCIhd6FLFY9w02my7aaxqY2GdQwHOmuCIy?=
 =?us-ascii?Q?Z0QtAZPGbA2X7ZqP/147MkGh0av5r2obUAk0odBgmTM6RjB2qfTCAJIF8nGj?=
 =?us-ascii?Q?ueYM2HVrZEww4c/xv6V5IF1mVFNOL+wr3Impg95GdohGJsw9LkzQhWQxe1oA?=
 =?us-ascii?Q?Bwuo16QO6gn1Bjice6V29q1DQqYeDsECzJqj5mg5jDH7Kw7mx3uhnhecK/B+?=
 =?us-ascii?Q?1kZQ0EWkuyuiGO2fScMucLZDCBxF8odPWESuUh2xBKuu+k5/W8g5f7Bor5P7?=
 =?us-ascii?Q?+ie6f5lCT+5FkikljxFKCPjVf9QFfYlxrMb8kARd0VNUQVOY1zepokctZmVv?=
 =?us-ascii?Q?Dl31lgw1mquWHeXkPNmUyM1Zx0pYkROVFVttPdFU0hmu76J5x9L12EALIfZ/?=
 =?us-ascii?Q?tcQ/k/DpM0wsHo0ceOyF3XpOwAoi1qMK1OobIInrf5J1CQaGhKEu21tTWxJP?=
 =?us-ascii?Q?8etZ2093FS4ltPcuf8tKVJbgpYPV+MYe9X6jp/CrHIxazMZX533zrDiJUIRO?=
 =?us-ascii?Q?/dFAJ9P/uSDCux2HnmdjSWGP/bMkgMJgOZ14yLfioQBy8Kuqwjoav9EpJB9T?=
 =?us-ascii?Q?oi+gOCeTOPQmwq8HQRudLZ9FG4Q/u4e7J82ZkGckE4k2zfHFHuEusKJUPuKI?=
 =?us-ascii?Q?y2wKNFqp9Bm2muKfLTzxTwLEF8KBX8ThwREsxOvBg/sWqne3Vfv1sy3r+M9b?=
 =?us-ascii?Q?AIxa1XSTy7LMyaa8TxK8zpaYrK+u7ZMo2ZSJXZJr9hY8sL6mS7EFQL/Jt85d?=
 =?us-ascii?Q?O7Vjhjw5gI8zo3+7XvfS0+B0JLBf74g0+XdFKgxY4HGZxrxBTp8VYL+Fyb7Q?=
 =?us-ascii?Q?6p0kHD3QlsCPWOa3mkpJpw+ySx6Hlc740Zg1ir3mFD22q1pdVsF7GCWXPyXw?=
 =?us-ascii?Q?ytOVee78T6tG2gFebPtbb4rzeEijxnd8fSVVd8DVTTthLXx4NARzIvRTX+t+?=
 =?us-ascii?Q?QtDeH2HBB2fannDPEtVJMsBvIL+CS5T8jC2s+U0V3x+pkmMywJ95NUOaT3ut?=
 =?us-ascii?Q?XqY0USQ1LTS8rzjxQNfXEAk+XPk29rEDYD+Am0kToRme7YVyjXAHUF2tAsFg?=
 =?us-ascii?Q?gLui8Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f2be09-935c-4a1e-3923-08ddf50d1a2a
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 10:37:58.1997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0iDMXWVbR7HQZqzQNux+RCGIpQ60TU+zQChSiP/O5MiNBk4pX+5gGgUtWipfhq8Od1qY7Pwgy/sWnxiUyg0aUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11463

On Mon, Sep 15, 2025 at 03:42:00PM +0100, Russell King (Oracle) wrote:
> Accurately describe what each call to ptp_disable_pinfunc() is doing,
> rather than the misleading comment above the first disable. This helps
> to make the code more readable.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

