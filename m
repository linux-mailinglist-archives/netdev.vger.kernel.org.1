Return-Path: <netdev+bounces-212977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B5CB22B69
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5827C177E20
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098612EBBA4;
	Tue, 12 Aug 2025 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ainRZyAB"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011014.outbound.protection.outlook.com [52.101.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F3B2E3B17;
	Tue, 12 Aug 2025 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755011224; cv=fail; b=G36/Xzytlr2f8ldMpuJr/10BTHQmJI58wT0ffex2hgsrhf/I3lZrGMTWvngTh3YLC+c8nZ8Gp9mHoIVvKmc6CHidRftjezo2F2OPT1GVX7I5fxHMXeXNhI1sxQPoUY5WhNEhXZbDxFZh1f/u1Wh+cWj1tSPFv0KiymQ8DbnYLoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755011224; c=relaxed/simple;
	bh=okn7+90zFyKtxnRpmy6a55SjedZH7yCCv0ksXg+4+WY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MPd+aETT/DS8v42+78cGk0kEly3fghcV9gv6rqGguLyOgTF58lMKI/oY6LTyGt4Mq6C8qo5nMxLSga/3WlQJooTzWBh0Weeaur9sTHVp+yLlwNDB9Yu8MyH6Itx56vucYY2pP6B3p8454ePj3iehNN3od+jseqY/YFd2bAL12J8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ainRZyAB; arc=fail smtp.client-ip=52.101.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QfTqnRR3sAxGdQTDqA6D816LR85uh/UMxG0epWuF57tCxwMBSTmQO7z4v9IDmlRKR4vitI8VexWphWE2QKxIH/rE9K/EMAsMI6tWi5xsPNfdFpbWLEABuukjFVVWhjy8dQbOv0thSg4nUgOchwGluaOHztVRUzt+5Q68jKeyqAh44WH69ERWaDQpP9uy7ULF+ldMlth5fCxtZ1QLQ+8aT72KUKrvlzuS+5Qntiiws/L7dgu0/o1fIc8BAeGRnrIJxWow/2v4VReBN8wUF6mPLkZbVGXyc+3pm2HHoQGeTUAcANpmGoz+iOL+KA8oVYF62Uk/1Ofva0kRl0tuEWS9ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4gomceGRBEYvnQFNLUx6Uk6oI9yiaxVkjFu7KbCEDo=;
 b=bFkzR+YEL7h1VstBMsIDD296Zgyz8Nxaz4tVTkH1a4B6U1KT+ctm//eIST6NHhsKDKR2PeS2b6XXrWMADk5nAudW5NzpSOg5TrkODnGZGL8CW8WEMMOI1SM5erLK7Jz3cI6igUkepU3B8O+VLCIr1vKaUAdJj3EH9sM3Ne3KuJ7XadgMHUMYz+6LeIbKCkwMxkgTgetNOarB828nsAlLCPv/3eR9HUmWEt0iwZuzvFh98zGqU/6WXPcZCtfhNDz4Hqw/BI5PDLmzX7J6ugg25fUlffQOr/lUc1ASrFWeROWHoaVXwyCgbz1mK+4/Wfiybbuf2uM8l1g9SMF41pXUlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4gomceGRBEYvnQFNLUx6Uk6oI9yiaxVkjFu7KbCEDo=;
 b=ainRZyABlVgbaYouya4u7aRprznmoMj/ijWYcWSfCu+iH2HyGsCDU7F38SHELlddpGEjbMggHTvbj/GDuMJoBJxtmjXxOmb4s2S5+LKmwOn2dYLi1TgJXfBWI/qOdGrD5qB+74kU/zODjH60YpvXx3UN4XY+sH2/WaxNCvH+0llRpKysnTEN3OEtHKyA3hjAnMov53u4ver38BPSo1gey4TkZVfEgZfKnKxPQhyC/ZiUTFPsLTrYTo0FSwhvzAvHze6Y7xnZADS2ZzrqLZnJFTcAQbIAEqiXCVo66eqKH+308VHYVy8/lA1clhOoIr5ebvN/WueFySnfW0uzYfdJXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB8722.eurprd04.prod.outlook.com (2603:10a6:20b:429::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 15:07:00 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 15:07:00 +0000
Date: Tue, 12 Aug 2025 18:06:57 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stas Sergeev <stsp@list.ru>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: explicitly check in of_phy_is_fixed_link() for
 managed = "in-band-status"
Message-ID: <20250812150657.mwsnor327tepkplr@skbuf>
References: <20250812105928.2124169-1-vladimir.oltean@nxp.com>
 <aJsj_zOGUinEke1o@shell.armlinux.org.uk>
 <aJsmkAiV7tvFEeyA@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJsmkAiV7tvFEeyA@shell.armlinux.org.uk>
X-ClientProxiedBy: VI1PR07CA0286.eurprd07.prod.outlook.com
 (2603:10a6:800:130::14) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB8722:EE_
X-MS-Office365-Filtering-Correlation-Id: f83ba839-75d9-4bf9-1736-08ddd9b1e32d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DXAUyDUglZFo7yemzu2iEs3iugE6K/aw7SVTS4vJvuPG+CUu0o7qDo4XYItH?=
 =?us-ascii?Q?mrl0SSroHPFS7FWPCLQmiCZIX5eCbPWXyy3BzbusFD/8SvqkW5VTPwPhAY4o?=
 =?us-ascii?Q?zYp3Afdcy7olrYXXs5KgdjG+tqWjEHuuu/Wh8mB3YTZcCrVASdqfJMqaUrKh?=
 =?us-ascii?Q?sLk+Xzg7TNZ6BkvQRWOPRn4Xow5TTWe5cKi8gsKKv44UV+MHOCIKHDQWsvJG?=
 =?us-ascii?Q?Hb07OUnzxqwnyOuMrJLbCd+JIt/2yJ74WgauTUm3850hu1U/uKfAuWRs+IWW?=
 =?us-ascii?Q?SVPppQ/Vo0hlfRBBb2I6SfAq5EV2LFmAn3TFXRRaTXmPwmihsUqWTXUklxH1?=
 =?us-ascii?Q?zeAMdCFbeUbE2KyHsTpnFIMUN22gM467ko+74uE6xnZ50yfx9AGvewzP1rtF?=
 =?us-ascii?Q?4uoLGrlE7wcwGXhA+47oTutffJgtQ8rFnsO9qdctSo6l+0RWsX5Jh5nQK9BA?=
 =?us-ascii?Q?ztLJ7at0UlCupJC6IkMrYUiib7U1JPxaGBSd64U9RYL/VxGSBaE1we27fOwK?=
 =?us-ascii?Q?GGHx1nelyutzxbicvS6yKKWhndjd+khOXYJf1Mudans1KC2cATxyyV3Alrwz?=
 =?us-ascii?Q?dybISEhaXlx5ASklgCmIHLWpmsD4nnj8E7u16PamEb+bMwUXsS6xn/MikPmO?=
 =?us-ascii?Q?kTJUpVs5+nvJAjryaNTHA4XasBKgFQJDyhXdJ75Mtm/XVhhk+mdKBnmxyNbW?=
 =?us-ascii?Q?cPuz/z3qj5lmf84L3X0JSXcu4pIfvYC5Xem2y1SvPmLPTjrgHtyU7JAR+MA8?=
 =?us-ascii?Q?MnsYbYQvgkc4wLzaJ5XO+445aBFh7OlmUbOb9/eitLZGb94x9S00VHZB+kZT?=
 =?us-ascii?Q?WJ+cbfAE893uqN5CamHHvVUL1LRK8JEBAWt1xMzmRXvXHE1i+H8h0bdDOUk4?=
 =?us-ascii?Q?v0NfJ6naeySawc5YGI09EoxBVPvLjcaRhdNCFecAhzl8y64j2r0fJqg/fOoh?=
 =?us-ascii?Q?4oEbLLnruK5KtlYpK2jwpxNruIDW4MhDVvIqR9dxgeh1p5MEU6gXlrQsIM2t?=
 =?us-ascii?Q?z28OnvHN3RjKwSTfXlNQOfrZ1Pa/+K4C3XTJnTYyuYQyLpANlZrgwqsVKir5?=
 =?us-ascii?Q?u55ebNpWlqmYmh9S+QtmJHtK2mbv4QK5X6thbQa8mc4IAOkwAMQWdrETTEEe?=
 =?us-ascii?Q?fhGMstzFwzZth2oly2qoxHzdIebFnUtHrI5dNy06Odgih6nNi6r2L2IyjS/d?=
 =?us-ascii?Q?gOKaBdz7vbd1uvY+rtIPqxuArZ4uqx4tU1ru004Axp1LQYEHro7sa16NR1uY?=
 =?us-ascii?Q?OHvmYcu5P0cLK5awC7EGQM8Qa5K/1pQICsf+LX6f8R+weOpJuBiNTbRHrato?=
 =?us-ascii?Q?CEBfyqp0pg4HdeFyk9w2DmxekDcJ46GZ9Y+9Ma3jhzl963SFL6RjpeH88Vxy?=
 =?us-ascii?Q?fIu09UaUs0EZ4TvQQCU20BgNpoEhLnHF+k7SLwj+elMH1T7Sw6oQfinHtAMr?=
 =?us-ascii?Q?yOTtYYeAuQk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e730jBwku54Xy08UalSlRPoomPW34iOf7nT4ZJRT/XzijVOjQEuRLqnUyRI9?=
 =?us-ascii?Q?5zdPMQlMrHgOeWeGPqFR0XMcUXzMkdVlMeyLQ5FlixoBIYUaVeCUx1lVId4S?=
 =?us-ascii?Q?7le9A7r+FqPT3eOWtfc4UGXOMINDYPZUD1V8UOvmsA7nCJF4eKExtNNh8U4A?=
 =?us-ascii?Q?CUEA4nw7BD82c1a2Z6eWwngY7v5iamPEXRAolNtgi6kDkudpM3RQOhl/IBvA?=
 =?us-ascii?Q?vhe6tnnJDixswxlSOElC3ZLfUk/7Hcwa6dOoV3fzdO2FOx69TWHLrgKhjOif?=
 =?us-ascii?Q?rLX4uqbbteVFREfgpVUhwBiPRhS4lQbBDt+bSAOeTQeJNGhls1BeyoPm3ba8?=
 =?us-ascii?Q?RsswHQB9uBDXEXDS/4IGnOPPgXwUzrIb1lHs7TpiTh/6kYrd4pmXivG5xEK7?=
 =?us-ascii?Q?UIYwyAnYwUWxn/9QQ2CGMoPD+h768S+F6BSiLhKC+BHeELQR5sX8OTAsDczS?=
 =?us-ascii?Q?cJrT1j4NG6wMj+3vOB2AsTu6Sukb3ecL/0KPEtFnxcwQG/DK0ioQCXbdd38b?=
 =?us-ascii?Q?2aO+5/xGnnw17SkYiukTFPRI059aPVxV3k552gYc/yxjofZ/a5Sag6oWky3u?=
 =?us-ascii?Q?8n0cTX5SVJyVUxOZBnKy6h1BnS1RAlWfJyRTlGvPR0zU6LQTrQmERC/N+fru?=
 =?us-ascii?Q?JdKkDi1A3UWQlC84Pa1Z5gY8hZbdNtzGyjXUxGL52ZUravDVRHJwx9uQqsQs?=
 =?us-ascii?Q?3dR9R5s3WsVA6FS382zax2dd1WDrrkJMzh3W1vRLnFLs68wuRmohvtxzL3iK?=
 =?us-ascii?Q?AmdxHJJlwIBns4KxZOCoZ2FB/+tuk6DM/42OfF9JFaJtGVZyLpOy8PtvxZ5F?=
 =?us-ascii?Q?UVhO2OM1/iDRO0ukwjS1WWdmWmpNUG5SrFeUp/dx30hRrl+yWS3f5IXEoIFQ?=
 =?us-ascii?Q?AAlcxlk1AQ8B/dmRZRhfTvj1VumGeJoc37Leqte+HwOeZrPv/zfDLGAKOFn1?=
 =?us-ascii?Q?5wqRspuaNlz5v0xQN+cGE8RZD7RBWRcTOc/Y1rnk/LIFr+lY8y8kIsCeJrf8?=
 =?us-ascii?Q?KnXnb9ROvZ9jf9n7h5u3rU+4+8alBweZzTa9gxeZHaJj/sIFYKgs3J1ShrwA?=
 =?us-ascii?Q?V/xQYrPlk6d5Qmm+8D93+lMbjaOJ22aTrYfk6IzhrQnFqsPDRdlXxT/kvBxs?=
 =?us-ascii?Q?fqZ0WqKfI/1Jc5iyl5SEzJBQM0pBWXfYx32ANebM3NQYAnhxp/VSQbTC/LR2?=
 =?us-ascii?Q?VYmWLBCwCsnoZV8n0Av8VR5LUd+YIQAjz5s2kfIvlpgYQElhrGpiQPaiIt0L?=
 =?us-ascii?Q?gvPzIowaZv6F3wwmJ0q2UrXA99xqVitM2U0dZMF4U9nJvd2/1NnKKy5xUz8d?=
 =?us-ascii?Q?0MSQdq4TjGy6i5zDYJPPo3PmwPYbogoieAUL0PJ67ecBQlGktzGEELQlgKgz?=
 =?us-ascii?Q?jJpTNazUfpTEREZIVaA7n8AQlgWpqaUVCwi/LwOHlnJNgsEUpynn/U8ni9f/?=
 =?us-ascii?Q?oOC58hRRLd0vU7xPdQag6yk5w0pk2sDE8DcfMHDosu8Vgmfop5Czn4AqVkIS?=
 =?us-ascii?Q?+GmD9phwTq2OJw68pIUlo8qCtPua0agR0W/jK+XWXe5aNl+eAUWUQCtzLdlk?=
 =?us-ascii?Q?AjK3YHqxudUxQ4NYAOtPYT1bEL7E2MqN1KVbR5qM7e7+UBIf/COHqjFmTW20?=
 =?us-ascii?Q?is8QXxkvnCI/vwF+4Ark1K3Yj9gHD7Up1h8pUngq03cMOraR6hPiXm3/eeCj?=
 =?us-ascii?Q?cK75Rw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f83ba839-75d9-4bf9-1736-08ddd9b1e32d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 15:07:00.2495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMGgrbY35wVInZTLCeHXugA+PIFK2Dm1S+LhoN4rhyWzGsFIYgKlN2zafrTmzS6e2l3JaJRKmdCTnz3IyKriLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8722

On Tue, Aug 12, 2025 at 12:33:36PM +0100, Russell King (Oracle) wrote:
> As an additional point, I'm not sure what has broken that justifies
> this change for the net tree. You mention at one point in the commit
> description about wanting to use "c73" as a string for "managed",
> which suggests new development, and thus shouldn't this be targetting
> net-next?
> 
> Note that at present, all dts files in the kernel either omit the
> managed property, or have it present with value "in-band-status".
> 
> Thus, I think the commit makes sense for net-next.

Correct, thanks for challenging this, nothing seems to be broken if
stable kernels are left alone in their thinking that managed = "c73"
would be a fixed link. It was out of caution that old and new kernels
would disagree on this when faced with the same device tree, but it does
not seem to matter. I will re-target the patch to net-next.

