Return-Path: <netdev+bounces-23651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E893276CECD
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C8E2281BA8
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 13:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6825749A;
	Wed,  2 Aug 2023 13:33:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC89569C
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 13:33:22 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491E72703
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 06:33:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HraGoRV8/sE8z7QTd470o3uDUHTeQKfK0r6l25cWxoBWgr1vQ2aFNhNdO70sIbycTDTh28Feo+19Jq8IZ73YCq33xVC3NOJfbic2mogs3NlUTmwzDy2dbWKTuFII3YtaZXfmn0lDmqBcf6h6P3uVX4rwKE676PfMq5USIEFj6h9w8dAy0RU974RpThKuVU+eOOXPSqTlo28jlf3CTWupGshi51gAJ4X2R/ya/rb2lfEjy64kABLN4n6cT0N7DaOg+tn9XGkBB509V9+dpNmdgU48pcM7CALrqp6mKOgYsiI3D8ECVDWpPmOiVpK+XnwQ5+2T2dqeFJUfXT8PieksqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwospZjWCv+ekD5XakYogafKs4voZlvCaGSfIdj4o4k=;
 b=Kd0rQdp2XgF8gOHW0XstRVxWNZgYIyO9ly1eSx21iztd737/n3zNYrPErvEMLxWO0s1JgCniHJO6Z8HtqapWHZD9YXZ2y6+nHz8vlxcG+hlgOBRJYwQrPGY/dguXvRxbd/qMw/eemgyp0b85Fox+hvbELW7JgJY1lIiWFcAqkiMbaS+qDBCvCc0Kk9y3MOW2/yHO0/RYc+K7MxTn/xgPNExjBBdNo2YBa37R3zGEKbcl+h73R3a1XFvPPOJigUl8zeb+fNygEN+k1DRxEU6R5up8Cbi/qA7WqGQrd3opj/eFiUhO+xy4t/Gikm9ZW6HA+8ZPA04OMgH/4PVrPRmEQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwospZjWCv+ekD5XakYogafKs4voZlvCaGSfIdj4o4k=;
 b=dyCvXK5PqJPbeMZAodN4H2V12MBVeU+Gn/s7S9YZQvvZ7C0gDW8isPsQnv65xL1Nh6IDgsfm4lUzn7MN4NEHJGbGi+i20H2EqNG244eKKBc0ccaKKZTjda/Rbs8Q3WNzJy+6kO8dwX/pY+YgYJ+8cVYUdGByKlHlhssa+kKtXXI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB8142.eurprd04.prod.outlook.com (2603:10a6:102:1ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 13:33:18 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 13:33:18 +0000
Date: Wed, 2 Aug 2023 16:33:14 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, razor@blackwall.org,
	mirsad.todorovac@alu.unizg.hr
Subject: Re: [PATCH net 10/17] selftests: forwarding: ethtool_mm: Skip when
 using veth pairs
Message-ID: <20230802133314.xeiwztisym2a22sf@skbuf>
References: <20230802075118.409395-1-idosch@nvidia.com>
 <20230802075118.409395-11-idosch@nvidia.com>
 <20230802105243.nqwugrz5aof5fbbk@skbuf>
 <87fs51eig3.fsf@nvidia.com>
 <ZMpadrHS4Sp3zE9F@shredder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMpadrHS4Sp3zE9F@shredder>
X-ClientProxiedBy: AM0P190CA0008.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::18) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB8142:EE_
X-MS-Office365-Filtering-Correlation-Id: ef7ca0b9-aa31-42ea-cc6a-08db935d07e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YPIv7Pdc+ylANBR3izGmB02Ni62Z+NJH1PJP1e3o+1KYZ/Bi1zB0FmgZDVlJsgwrYHIY5ZgIqPJXIv0+4c+fncRrm/v0xuvvLtrqu9AaeS9ONQCkQOpJ0ZsrNp34Ork8al8PQPuUmX1uXucz68nSpbkBPsw31P3fJn84VQzo09JflJHtb9jSk3QMhbtfg3El5RPswxAHTCN89ITnRYv3yK/jbRuMJCu+L+b0fP3xXnlfzyOC6LO31FNdABjyr/DfngyjIPU5uc+3xo6nY26znXfqOvOkCa4ltbHdkfdtMj365QmHQ2uy3B1rdBMYz9xKT+vMtDBIjIZ24weUEAtq7hJTsl04WO+aw6zllt441Y+QFtaE+5Q7iT9FOxtuMWsIBKc+YgYjfve9X8tSYSGNL5MegDOCM3/swgyDyzjXFLc1LiyANgDVzNnhABgDao4M70wMXKM5vpC8mF2HZKz2MzRrAAK9IzJFec74Pg5PUCrEbc2MgrGzVSZSgf3yJzGYzyxQbB+SOGi+NOws/TOVnpvugdM1YldRXOVSWGdeF0d9OdpJHIIVJuXeSAeDyK1D
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(8936002)(8676002)(5660300002)(26005)(41300700001)(2906002)(83380400001)(44832011)(7416002)(1076003)(4744005)(478600001)(54906003)(38100700002)(316002)(86362001)(6506007)(6486002)(66946007)(66556008)(66476007)(6666004)(33716001)(4326008)(6916009)(186003)(9686003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iYnrGZpD1prMB4SgqaETVJn9PNUYE0EWAUSoK8t32Pxxvknlv0v52ntyk8tJ?=
 =?us-ascii?Q?e+aoh7p3ovNoutB7V95YeVmEd78q02/rBcrRrLvwj1zNYRHx35NtYktmxPWz?=
 =?us-ascii?Q?rAu03e1duz8x8hqx3XSdcjLPI0vIdtU9VzYQsujzvhbpEGejHnQ7Z/eGU8qa?=
 =?us-ascii?Q?coAqCeXaOpA2aJG31a8VzSJKm5YjZS8pcwzSfTPPeka0xXb9FlulO9z0iQYS?=
 =?us-ascii?Q?/fGMx5C/iyeV56VlozJ4ouAx+0zmgBjPmqupWzEZVRTJ0lDPNULBlivBo/tx?=
 =?us-ascii?Q?eqnKvhuegt6NQk/YyTbIOzTHvN91WBx+vSVpkRXtj3gXU8gA0IZLCK7YoDK5?=
 =?us-ascii?Q?bqG1dEkTweptefucI+n1cAvUgzU7XthAqc6yNvMsSL0MgEuL8xKkLaNQTmQp?=
 =?us-ascii?Q?lyGDYxNjkvHfbMZq8nnP/AWavMrbohStd5rRezZn2LC2GSp+C8189pIfWhS6?=
 =?us-ascii?Q?hAoHGnM6LRXdRZpSr9faL2ha6TK1e4aFNCGFa9VY81cJl0e353qThu/mfseZ?=
 =?us-ascii?Q?EVSgfoBBPIH7ca7CA/jYhthTa73AaC7bCenXj/S/oxUg6S/3+ZjnVmRT6hq4?=
 =?us-ascii?Q?nLmscwi1lYCmZkurSIFle7O5IHOapKuxt5LSdrO04UfvVTxzTplIoh4EftPI?=
 =?us-ascii?Q?nLrZy+mi0IfccWUnDXtRX/YNSrQj1MQdlq2P/LOKaS3BNZQqkiGA+wmgZtQx?=
 =?us-ascii?Q?LqVreErN6nc2QuglQE43hAXBRc2f8v8da1tVjQtzfyFnT/tEeXh/WbUw5UJU?=
 =?us-ascii?Q?yqORtoyihqBvaz0ko6w4trrZIWPMM0ybGENEPOyl8vEZV+4kCIDSx8PaL0eC?=
 =?us-ascii?Q?ykTbWSN7Ghi6LFFselEFKqn9c1tS0JQXRqkB9aMqbp3JGfp4fxTl0pPHzo3a?=
 =?us-ascii?Q?SW4wDAhGWYU5ByHN/QODsHzZhGZSaLOVqdk90JCoTE18oNPhIac1sFBNzKt3?=
 =?us-ascii?Q?XftZCzKsGUs/IVx0eNrBro+m/OfnIeTsD3U+Mwr6YyNkcJOfD9gEhIbknxkU?=
 =?us-ascii?Q?L/2+8J4+ZIEIU/R03IhvUmDy9jYqACrwqR7ki9rHr6yUEp6GRaVinXHAMaJk?=
 =?us-ascii?Q?iShhT+Fp6BHzFvcwpnUmk/XZxwg3mvEj9WXfWJHiqxQZyTE1ReI5erQwYFPU?=
 =?us-ascii?Q?tU0k2Ym3W1pdI+vO0rYSMPjiXz/dspfnH9+rQujE6A4sEPPu3nwRLf65UVTJ?=
 =?us-ascii?Q?fVrCYBFlYrFNV2aZKMXjriORPN0Az0xI+zQP0M/Cd/MhrGcBeZVAEIGqaku0?=
 =?us-ascii?Q?ej7LspPayyQ2DCV6hbmEKK7QAWd2cfjaaepE/UHL8J5K3ZkyPeMUR9UjoOie?=
 =?us-ascii?Q?7MzZ68wSBnuoAKWUa5dqAXrIzs17iIgYC1d1/6EL3mtQTfSMv8Geap5ckbbL?=
 =?us-ascii?Q?jcdg9Og6GeEBjntex1KNVxshJLpJe34RNnjNk7s30hmn5AQexh/MNnCk0YEW?=
 =?us-ascii?Q?SwoZZaz2X2/WqbhQvSWdevYPugjqb5N56LouHEfaVO7LLfNUS5SqGG4leFVC?=
 =?us-ascii?Q?0uwp0gWPUBdPJko/Mv3JNFls8IxVUVCTrUnGozx2Yj9DFsoAmb6rQylKHkxh?=
 =?us-ascii?Q?4DIxL/Xwj+kJZTMDAGwYnFk/pHygnnhToq+7F2NOqaZQHoDKtK4HSVMvDOHD?=
 =?us-ascii?Q?pw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7ca0b9-aa31-42ea-cc6a-08db935d07e9
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 13:33:17.9256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQ50iDvOHTX5F4y3u/PfW31i/JV5IWlQtuaDTbzL51rNIEVq8Qdqjo599F90wNYQUTpqxR1uO+jeD3gD09G7/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8142
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 02, 2023 at 04:30:30PM +0300, Ido Schimmel wrote:
> On Wed, Aug 02, 2023 at 02:27:49PM +0200, Petr Machata wrote:
> > Ido, if you decide to go this route, just hoist the loop to the global
> > scope before registering the trap, then you don't need tho hX_created
> > business.
> 
> I think the idea was to run this check after verifying that ethtool
> supports MAC Merge in setup_prepare(). How about moving all these checks
> before doing any configuration and registering a trap handler?

That should work.

