Return-Path: <netdev+bounces-53954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D13805654
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 14:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ADD3281B2D
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 13:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A945D91E;
	Tue,  5 Dec 2023 13:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dcsDTce2"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2069.outbound.protection.outlook.com [40.107.105.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE721B2
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 05:46:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7MRcU2GKGTByywnGhDFwraxDQWAR6c2MM2fvJO3NfE9MnRuLMc+QtjBoQPIBTTZPIeGW8JzSdpo7ylZaRVXpFwh0Tkk/IqDUKr3e9X64N0osgtMlwSeIern2tXH2gONmzldR2WV9BwD2iox8op9vN0DMdQnJEksFxYC4HZ83LyAPo0I0t7AGOBwEUTq6hs/unhRLem50eKBic2cYT0e+S5U21/Cn2RuQ/nw6ZYVhUfXMfT7hd8S0+uYAiku9lPAdHw8Q8t0mn5fmH6QIUp9CvBbBI0yqqHQnPB67Y6rpi6cMqxpJv1BYdNHQmJWFCSTkDRQqE5EjQofCCCzAi5UuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgq4Ua4r39YSkRe4bBi7T/ckbxZ/LXxkHL4iYThhWMs=;
 b=PK6F8Pzz+9NA7hUGCHR0jRqdGdTMCiXtJVZWJ/dO7F64NJjgSizaatddC/3m4msdA9ze86QizjOaXxXCwMvf3BfgQaq2RjIPPmRguqBMyw4QKiYkeuZxNRejbJFptsoXYH9Li8oGSSmczJU47LDhlmoNn2MFvF2+NBTjv6DAbStBmcv5okYXrjYv18YMLqNEKK5kLYNStCMTZszwPM8nvWpcuuK8k7SNxAAOhSEXD4OUxOKwGbeohR5xCCP0qomobXoTzHSZfyNvPjhEC8MU+EMKJIPqERAEKT4hg+zBcS6TCtN3bqgnZlZ2aKIcph5B9DbDeXhb8ns4hjAbzisYSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgq4Ua4r39YSkRe4bBi7T/ckbxZ/LXxkHL4iYThhWMs=;
 b=dcsDTce2+KDQAgBmn8KeFGdaSwOXF54H0qcru+7s67dJsnJyXLdgMnCF/mIvf+qAboinFsXteWW8hsztGBNriInDb0FeQUsllOvw3bAhunwE8mpdPjIlZ4yrrFCIeCMGHg6nOJJfSyyHsVm9BO1yO8zlD5e/rwkSjqfHCFiGQxA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS4PR04MB9649.eurprd04.prod.outlook.com (2603:10a6:20b:4cc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24; Tue, 5 Dec
 2023 13:46:52 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.012; Tue, 5 Dec 2023
 13:46:52 +0000
Date: Tue, 5 Dec 2023 15:46:48 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Alex Austin <alex.austin@amd.com>
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com,
	ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, lorenzo@kernel.org,
	memxor@gmail.com, alardam@gmail.com, bhelgaas@google.com
Subject: Re: [PATCH net-next 1/2] sfc: Implement ndo_hwtstamp_(get|set)
Message-ID: <20231205134648.zcdqvpmukxugbeb6@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130135826.19018-2-alex.austin@amd.com>
 <20231130135826.19018-2-alex.austin@amd.com>
X-ClientProxiedBy: VI1PR07CA0240.eurprd07.prod.outlook.com
 (2603:10a6:802:58::43) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS4PR04MB9649:EE_
X-MS-Office365-Filtering-Correlation-Id: 516ce40e-7d21-4c3a-2dab-08dbf598a2ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Mf8TxngqH55TIN+GzEH8vSCVqQJ6FTU2hqR5M1gWh0DV+F9t8zlxShvHQbgF7whPfjuTbbHBIvl7BUCfjKs5af6QXT6mPLD8Go2OTVbVdFBp2rYJF6XCWDEeb6leUmMNVDdQkBqWC2zX3FbCr8v6ivyLRmdHYJ4GoAw+gRv9QpBEWZv24u7TeEliJ+nsmN4nDWpadZ3Ir23klfN733OrU7+9jOX2K1YAxtjuBausrCD+4euHxJ36I5gg2E2HmENu3fJanWKdrBesmy8SvizefGy6e2/AIU/YRrKXTIxtXGZWjxK42BSJmOaBi1108oOhCuQRDrxbpUoo3MPloHqsPy56CcMqVk0ebSpaFFGcczlgz8pzROesRDOUZOOOygI7zttMdnue9Z/9yvPzShTGjx5kIt2cmYC5rjCZvDeFODtOVkAC1fj5rkBv74HusgSkTc98u/WsbSc30kPJjtD3oI3dgiMhhYz8MBSPeqRp2nSKldaHVhcayIf4ePesbLmRDcv5K+RUb1MkHOhgTjYPwKHLLay3zhSbK7yum9jeDNVVnO+ZsYWeqOzrL3Hr/ZOF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(39860400002)(376002)(396003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(9686003)(6512007)(4326008)(478600001)(8936002)(6486002)(1076003)(6506007)(6666004)(26005)(6916009)(66946007)(8676002)(316002)(66476007)(66556008)(83380400001)(4744005)(7416002)(38100700002)(5660300002)(2906002)(33716001)(44832011)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x+WUpt0y2gONVqRvBPbmenU3OvEnCaYYZGkBfQbmn1ZUle6jL1siYU+ZLV5J?=
 =?us-ascii?Q?42i528xwSgZHzMARqd3h877S9IwLStxxi0mnM2uCMnrOkv3VyK3L1HEGFD1M?=
 =?us-ascii?Q?3TfY7Y1/k96JWBXDgg4Kpqw7ihE0dSPnSVlBYEBHfjv+pLvh55Q0VeysOWTd?=
 =?us-ascii?Q?5ObTfGCOKoMpKU47O+3sSZEW02Vv23vFY5QhaMbeASRq62ayyveILHKdX4Ew?=
 =?us-ascii?Q?Hk+CIOlDriUzEs6I7+HiWeMyD7+9mKMgQqSs2CHzBRPH5Gchs6jnj/YSteGF?=
 =?us-ascii?Q?qsbjZ0UFBZcMviX2nnbskm46dcnHN6aVltAqTA7dfEHWsBi/ewweCBQU7hwN?=
 =?us-ascii?Q?szZh+H9ecLrCbilSi5rGjuAeYpHY4KgPGEaWbS9LWnQ4wnsm574avS7LsYW9?=
 =?us-ascii?Q?Z2jTi9+4hGkU1tqjcDQyC/TWOg0Zujau+0Ar2WkSWACPKDlrNAs1CvSq6sKz?=
 =?us-ascii?Q?xHOa4cPcpBPgviw5LF4XJ9Lj3DzsiTHDMq+8CUB1FY6TnAlzT5XZJNow00YK?=
 =?us-ascii?Q?As4d0SKHXB+7m7HBeoYmvNCq03YDQhnPuA9knzd8kXWXtZ7uMc6NGBF5DrFs?=
 =?us-ascii?Q?rxt22DT84I32Eu3CM5ZluMA+a4QpK4SooIsmIefWTQBTdRk1CoiZgKUMDCLs?=
 =?us-ascii?Q?hyp7UzNXC7YZ+wAPxUd6NgibqTL+2Wo+8xPm69qgR1/Nz+oy0UbHTikThJFQ?=
 =?us-ascii?Q?mCqknNYCIQMrOVIPj/cydSXYf4zkrtyost/SWulnRgdGExL2Wc0ITfwfrnvP?=
 =?us-ascii?Q?58IpnUk7F67AkwOZTbGtUeKn49WPwEOT/2skexF5DTm0ZF5hQdgOZNpVBSsf?=
 =?us-ascii?Q?J9b3PW10MJj6Mdy7sMLvFjkYZwVsiNxiPStdBYGGOZOHQgPbhrM7+EnM4VUn?=
 =?us-ascii?Q?dpljltsDp/f5kKNCYe+7zvWIfM4pTvk3oW6Xwj0BAOufajuxwk9l9HcfflHE?=
 =?us-ascii?Q?IBb+nngEsUWqn2BUkE71iWADctZNISnhj4eVl1OeZ704fKukkIRZXm2rKIfe?=
 =?us-ascii?Q?t66PYJpyPXzOqn1J7U8s3yfE9Y/h9xmOyNkqHXd6W3c4XE9xRnuTQKfFyFYG?=
 =?us-ascii?Q?3lNrm7WYw1cwC5ex2fROepW/gSt1miosgAm2Bo9YFMJjGfp4+GEM+ixgsU97?=
 =?us-ascii?Q?IJpP73wV2Pyrbo/VUiZUFOknn3gvx6Z111kScUOFBwFh49/MwWCLaMGAKuq5?=
 =?us-ascii?Q?Q+7SwcZHHfb1GMKX+WlSX+ks4gKy4eIZNDe7gHX9Y4zRCZ2H10JCE3Q/nLb1?=
 =?us-ascii?Q?PKYLG+owm2h8B565BgMAW84O6AnFZIqhGDqY6rKtLcyIjelGN9cExjI5Kkon?=
 =?us-ascii?Q?JpfNHx0gllBfXCu33XTSB8fSYIyC+fEnUQQQ8LCHM4tJMY3vlBHK7NZm3JMZ?=
 =?us-ascii?Q?TcN2EPDOYy2qNNg98xZq9Ig2oPgahR1Olxh20vAnvoP4n98I1uF5MKq8FxpJ?=
 =?us-ascii?Q?NEfuSXizrjPjtRcRfO8bXsHkU3IEZqVvT+Mni85Y1oaC8ryPfTU7hZRpQvDp?=
 =?us-ascii?Q?2fm1xl3BmvQnsMyV3jFwX6gXwLqAlP5inhlWpytY7bYHUAY+FzAuTFjxhDt0?=
 =?us-ascii?Q?ECR20sWR2ob51z/IagKyQbQUCMOxH0LtGcfpYCo9JcImSR25O1uPf+PKLLrZ?=
 =?us-ascii?Q?jQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 516ce40e-7d21-4c3a-2dab-08dbf598a2ab
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 13:46:52.2840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qaSq7r33Qgi7/4mYShCMoO4dLL/g/0pICsCy4BVyp4+a6+1eDqWsNk9ioZKNTtSyqxgj1ibY8gEjlb5XVTk11Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9649

On Thu, Nov 30, 2023 at 01:58:25PM +0000, Alex Austin wrote:
> Update efx->ptp_data to use kernel_hwtstamp_config and implement
> ndo_hwtstamp_(get|set). Remove SIOCGHWTSTAMP and SIOCSHWTSTAMP from
> efx_ioctl.
> 
> Signed-off-by: Alex Austin <alex.austin@amd.com>
> Acked-by: Martin Habets <habetsm.xilinx@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

