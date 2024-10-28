Return-Path: <netdev+bounces-139524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF129B2F44
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 12:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F59A1F211F9
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 11:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6541F1D0E38;
	Mon, 28 Oct 2024 11:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H0/5+iD1"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA6F1D3648;
	Mon, 28 Oct 2024 11:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730116278; cv=fail; b=mjcSgjFC+iWxP8ChHjT7t0ZF6igIJZ7q6oryLaS8xaqw8Uugq3SdzT3O/W2Njp9nTONBooi+RHbbIv8mWpqYAlwh+Jup+4/7Tom0m/6tUDb+pebAIi8C5H1Ax4aZt/AJFaONQORT1KdUVxgMZvmovSBk1X3+oC5v9CNC3m2buD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730116278; c=relaxed/simple;
	bh=B4lqmFvewEe0COhxHk1Sg5C4GiH9Ge0lSnejzwkMlhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LvZ7rk+tc96dBH19Uro3QWCDL1roXikoLv4W2uZ8TnUTwjb92J1ZhYtvUjRLogMKGoqTt7kgYIrABYrc9Oc6TCP6U9mSXE2xGWHS1iA8S0IG9AVQLrWW/pFGb4IutbCm95gFiSEhoC28uqqSTFTdyDuR4Zr3AIA6dOcpRlJJdjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H0/5+iD1; arc=fail smtp.client-ip=40.107.22.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLjO4v5e1VoWVNXEqyTIhLozw3JC+UuNZLUXtaA8D+rwaBf9TVg5f9gT7R6A0iDLRiHtUAI2NyQ7pNvUmTy8XhhbqPyEhyyj2Zo09KS0gZye2xMfKlmyA963yE9na3KpBOZRqeh5Yr20vPBiOH4C3qhoJRTXJx3wO9IYlfykDAE0afmDofxreBYNShI+46nWHg8qo2O2KJhe6ek0eaztJrp9TJ9aJUe9niUl7wSjYr4QH5/F1YzhynK+SiX9CG9RXYAD0WWwfq1SID1Q7S/If9IWudT+JConidlllAQrdqyoo6PXV36V8EfvMudOWszxee3Wkqk6xfYbkUtEgI2fPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwhaiktcemK24ZksOWKKCOz2aM1eU1UhFxIt4l3dijE=;
 b=Ut75/SdlUYW0FrUm1xOKPfk6ltubjj0lF487ikdk9LDsaMjUgYlWgoJxQ3lVW1htZqRF+8E29YqMT4+5L2xl/AHxT8b3cbukOyJHWjfvTJT4EHKpnGSvTzU3Hfizy09B1pkNdsphMhVcJMdAlBFP/cP2dwOcTrQaY+kDYPtAG83FXSooAEVwVkwlkgcbqzAtWCnHPaF7B67zurebiHxsUAN2739P5kDZVVa2Y8iJSNioPR/zTdY9qMUGQ/HdenfmDMi1uwmcPURQItdoclNFY3rVvDWUUv0hEpqF4ew/ElByN4k+o38KSLImGm8XYBJJwo0hhE5w4vUHN7v5ibPtmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwhaiktcemK24ZksOWKKCOz2aM1eU1UhFxIt4l3dijE=;
 b=H0/5+iD1MyzQD/yX1wUpZOqJXgi0cnly53wqDfEJ0/tphRISp1rNg1xZN3jXOxRN4a1gkIE4UE4GqjjYE2RL9SbAt+/ePOXX6ibBObek0JCoDfWvYNPqfdfyAhIsej6npgfRqTQfxZTH+XKt8+lTIzQzQpSar742YhIAlUhV8/f0Vud4SJKf56+uPz/qrnbnr8PkvQmx5+b3GRjUQOPKhhthgL97jMr9RzLlSTf9yGlBa+csp371e7F/rhE07+ziabGvGxrTEhoG3IOPPsmzqXI0FoZz3vr4w/XmexsVwCGlpQKN4kUxiomlwcN6PZhHWkRaefsyxX1sTIJbvM2sCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DBAPR04MB7238.eurprd04.prod.outlook.com (2603:10a6:10:1aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 11:51:12 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 11:51:12 +0000
Date: Mon, 28 Oct 2024 13:51:08 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, claudiu.manoil@nxp.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH net] net: enetc: set MAC address to the VF net_device
Message-ID: <20241028115108.b4wzjsdxketvfehl@skbuf>
References: <20241028085242.710250-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028085242.710250-1-wei.fang@nxp.com>
X-ClientProxiedBy: VI1PR07CA0222.eurprd07.prod.outlook.com
 (2603:10a6:802:58::25) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DBAPR04MB7238:EE_
X-MS-Office365-Filtering-Correlation-Id: 22c71427-988e-47fe-c56a-08dcf746d211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YPT5iKmV2y6Ur8LCuG7zZBC/xKS446g7jvNtlOAxLAze+AOg4yg3gzbhfqDV?=
 =?us-ascii?Q?bzTq/HtYdxYp/9ifS2UwXjSUx4OqoVi4UdZ1U+I84KgYOYmxdPB+c4l0ojja?=
 =?us-ascii?Q?wSV63BP+JAM5K2xpNUp16Wu3GOrgpsR1xLYR0ZxXBt7UoxYJh4sP28HV2Pw+?=
 =?us-ascii?Q?Xg+mSCupqo87c8kMjpzkb+5khdl5gzoFOi8atPerIP/9Q+sOOFHN0CYPdLFq?=
 =?us-ascii?Q?Ju+73J30HTavyw3dyhKDYU9jFDRFQuFVMZM7szR/VGOCCCLeQ92D3sD7rByx?=
 =?us-ascii?Q?GXtmrQmbR5FmHM35UyJob8Eqh9ehr0xYnOE9hN+VSBAQplB5EliC7RSqbv3h?=
 =?us-ascii?Q?wo8G075tg+WXC7V8r5b42Nu4YtVqvrYhFuqG3wC1ks7utDbK5aV3cF3wxBJb?=
 =?us-ascii?Q?s094orphpTjEjMq6ZIrUhQgJnQjc2VgCQg8V1XLILKgtRo17wDOvOTV28Xvo?=
 =?us-ascii?Q?XphCkDgLY5ux36yId8e8wZIlKz7DJFey9xZY6YVKPeXc/auuxTbb4fduSbZx?=
 =?us-ascii?Q?FJ5s1BxNAHqZ6jGPVL7Vyuims7i0gC322T50GmBj+IQi+Z1i3pCpj2ZprkPD?=
 =?us-ascii?Q?l6qQyKWGvuNxg63yhkKZ7IicUMb10yRt7G59FDvSPaeMt8t4Fv0IhrRvG8wB?=
 =?us-ascii?Q?egcmF6MmwpxEn0V/7v6SCXyQIUpjKP/SEjALwrz4WvVskmCdvIzvUtEFmjms?=
 =?us-ascii?Q?TtPH+JNrdXjRIwwaNlJrxo2tad1mKI8iS8eXz8gbMCZ+ERqtTgEMITEGeOVD?=
 =?us-ascii?Q?b/1fDhF0M5YVV+CdwClatSQVE4JV5XTxaVB74AbjxlakgOJd5p2EDN3IeQ4a?=
 =?us-ascii?Q?9vVL9BgitPh/Mw/PXTsCl78D0AYPIqMxxFjLuEuP393XEZg3ovznc1Xdv75U?=
 =?us-ascii?Q?OUYAKvFXGaHPnP4YEFuayP6EOlSViDZ82nblshIoNe1EFAKru/NVxV5BfyAw?=
 =?us-ascii?Q?a+T0fmbBJ4/LlO1uQGfvC/WqQEDUJ55iunPoClJJUvadx7z+56/myUEmMoB4?=
 =?us-ascii?Q?bIKJCV8OXs7Ph6s/Fu8Wj8m2nRY0Z+POhUFdIlbrTFOuCP8ujTteBVtc0/F+?=
 =?us-ascii?Q?BTS2Tf6EUCFCtA8xccrOh+K24gwqyUExzOKHWy0J617qSW8HrLl67REmfmQn?=
 =?us-ascii?Q?fPkUlC2BfZeFp2i4L/i0YDytYDKm8VfZZzDKb6gClqMksAcWZ77pdw0F93my?=
 =?us-ascii?Q?anUYhhqUJAFvRl/ec0hZdCZ8HX36ppQ5OK3zkd5khjSphPgrjhM/yeLTOgZK?=
 =?us-ascii?Q?ch60sKJKpd6oOTuqotGyU9+mVBYIxrAKk1u0kt6qCRz84N4smXRCHS30pDa4?=
 =?us-ascii?Q?9jHStVgoXnSeRXCKMADDVBNP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rBHsoKOeU25nGHqxzMHORyjWQT0vaJ+AgiBBwXRBOHOoZHPHaMuiJczMGXFC?=
 =?us-ascii?Q?ptj7J+AAWQVavv5Le3e4xsjxbvPSQcdQVMz9emuDuaK0Krzt+ZmWmSloWrZW?=
 =?us-ascii?Q?qRm2LXp8cSpfHmZUcT/ThObtBQlf6OIFf3A8ifSQ+PtBzLa6taFQQlA23Dkc?=
 =?us-ascii?Q?yD54QKarb0vgFhtfTgioxzsAo0VmBSLv2wHdAMrn6V0yBtkty9LHeDF80FUy?=
 =?us-ascii?Q?2x1AmqUzOry6q/wYsFQ9KO4UxGcuFb81ZMWx3epCHyGroQE1GEk3Wuxb6XoZ?=
 =?us-ascii?Q?gjkzd7Ab9cCKHmtWvaZTF7PmN5HdWXEezet1NG8d0kZ7ruvg1XF7Jk3uL4dM?=
 =?us-ascii?Q?OCs0FCRWe8xHFPzpjRRgMetwEQ6o3DP/SfNPV57/DVz86A1QY345XB0zA5T1?=
 =?us-ascii?Q?SSCqY7pV+Tw7sTHkoca3/sT5rvVtdkeF4fENGyp8uZ8RUgKVQ25EFpK45Fom?=
 =?us-ascii?Q?RjGcehDiYRI7ACW9w10W6yIg9/2wK+QMTOPej2fcEc/x5dVpgHcNGcrlWWfA?=
 =?us-ascii?Q?PAQaRilTH+bGUJUEqdpC7565yC3wy4Zbgh0xWMFLiidFtEtd3TH9xa/rd37I?=
 =?us-ascii?Q?SySVfP/dKCmPCXyP/LDDiDMIhPy7aHLNoUkkOEPU1gv/14W2Ga6MuYDBBTGg?=
 =?us-ascii?Q?giVpWduxKRkTyLG1RhWanHytV8rNszDHPHiH2h5f2P48oXIVF7f67fG5EkEr?=
 =?us-ascii?Q?WRWwQK/DajCYqvyk+KX3XBngwYmOo1p1MO9OVJ0QD3sM0T7XMaMWgYFs6+sP?=
 =?us-ascii?Q?nshtGfR3fji0NuRFOip+eN7mRwH/Q06bjL4n4V8X+NTvqhnZece8h3qRXk/U?=
 =?us-ascii?Q?2smlcc/VmiVife4S0qV8A4vB+npvyMUX363XLRw5pel27r41CJf3QJDEvzkn?=
 =?us-ascii?Q?XV5ANplk2eXTqldQk2u0xjvtjikxX2XQJT97NJRQmWYnQU/Ltjl0CS6WkZy8?=
 =?us-ascii?Q?Bjv3Wc+9wZOJZK4yYb5NgX63oMty5wf0TvJyVXLCDGDh/MdxgLBIouEhywXe?=
 =?us-ascii?Q?/psRe/+v3F90+Zx2Pr6AnEhnq93VrCoKiFDKi1K+IYJ8zxnhXSju3XlcWj5y?=
 =?us-ascii?Q?SgpQ7u4zQg6yMU1ClXVuhTP2iv26RsXGLwfVNZe8SUBSWbXKL777yUs3TApS?=
 =?us-ascii?Q?2bvw7NtF0w3qtMZaj2JVoYdhgMPpACBvMC0cr6SddtlnLn3fwfzl5Bg9Fq47?=
 =?us-ascii?Q?HSHd+MvY7bvMVcZlIo1TPvgeB9yjV9XgHdoaJLGpGhTdOxLrEXJRWRGk93AG?=
 =?us-ascii?Q?HxTdfr/4ptZf+t0KDpS7nMmyQtQUKm1lofEPh7Y9lpFmMmDogtZIk6iN9mIW?=
 =?us-ascii?Q?RXb5RdJaygKOFWT/QZ6+KSvQpibk4xfIPrQdY4NWjmKpILhro/cptTPLLKb2?=
 =?us-ascii?Q?iOtToPgnvNjHe23qjHfvZM3vB+zHyhkOcaPd/JhXoGkd7bQHqcC7MCFEquw/?=
 =?us-ascii?Q?VyA7cNKwgNz/fVncFt0lCd83QfJlgIcCs0jFfbhcT15fGBCfv5dEC7M+wsRo?=
 =?us-ascii?Q?4u5vxONX1904MRHuhzDgn5Qqs/AoVvk8lu4qH0hhy2UC1OFr6uodcde8rsAW?=
 =?us-ascii?Q?lhT2BicpLwhb0wPWCa/i8Zz+7BWsxzlfGA0A6Cf5ocas7L8DXYRosE2S59tv?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c71427-988e-47fe-c56a-08dcf746d211
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 11:51:12.5677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3TlbDr8/rox4dNeMxh2dRYsEARnAsQVKIBDSlntC7o1CtUXXlg24bVii3V4EwmGZNYzIE0cxXC2DbszIDEU6EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7238

On Mon, Oct 28, 2024 at 04:52:42PM +0800, Wei Fang wrote:
> The MAC address of VF can be configured through the mailbox mechanism of
> ENETC, but the previous implementation forgot to set the MAC address in
> net_device, resulting in the SMAC of the sent frames still being the old
> MAC address. Since the MAC address in the hardware has been changed, Rx
> cannot receive frames with the DMAC address as the new MAC address. The
> most obvious phenomenon is that after changing the MAC address, we can
> see that the MAC address of eno0vf0 has not changed through the "ifconfig
> eno0vf0" commandand the IP address cannot be obtained .
> 
> root@ls1028ardb:~# ifconfig eno0vf0 down
> root@ls1028ardb:~# ifconfig eno0vf0 hw ether 00:04:9f:3a:4d:56 up
> root@ls1028ardb:~# ifconfig eno0vf0
> eno0vf0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
>         ether 66:36:2c:3b:87:76  txqueuelen 1000  (Ethernet)
>         RX packets 794  bytes 69239 (69.2 KB)
>         RX errors 0  dropped 0  overruns 0  frame 0
>         TX packets 11  bytes 2226 (2.2 KB)
>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
> 
> Fixes: beb74ac878c8 ("enetc: Add vf to pf messaging support")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

