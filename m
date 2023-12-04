Return-Path: <netdev+bounces-53462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C49803143
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 12:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D46AC280E4C
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 11:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5136224DC;
	Mon,  4 Dec 2023 11:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oPNvB1oS"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2043.outbound.protection.outlook.com [40.107.247.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB237CD
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 03:10:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3cfuS/rOUJuq9Ttk9yOlDZL9q+G4ZRAG8kgkbXJYiIejuavSYBifXGXKgkwEra2Z+PpcOphok0zsx1c5Q85+lrHg9L0L3t4UPHDS4bFJAu23Id2dR3zlRYP770OvxpDIhRJZSOfC8GH7YWjLdQuJrePX2jqhS0VJrv2bw596dFyMEW8LrTRxc1883/9EyE5UEWyeXjpID9/2fFc6AUOXpjYXkKKZXcArYuMvZgYOwnyA+MbXMwSj8dLnhOgQ5aJbZYEspWHOquOZVi8tHV4XUE84sXW7eB+icwzn60GPEaWJEP0X7gbIqrlY/KZnnXOcr82qa90A706qQnc+3mGXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TP8h/I25JgsXt3L2WFBPI+ygTbNoqpONtrryMX9wZF4=;
 b=Cv/XnPLRzR/xTXRzvirOIEVMwl4Rh/xPwEgOImWINBZzC6wT44gwrthSOnxIQgsKFm2cmu23CeOQgF+WtRmW/xzYdNNQhmwDrKAGYvXQ3Su+m0iqsSfyUIgj3iAY0is8pFCRgHtAsyHaiez+QJYKSuejbu+3A8OlCB1Vs4oP8gZr1790ho0hB27jIoXbbEr+0v/sIregtz0KZkB8nipy1dZNpWgOl3IOyhbH0fMhCUJz8cIxAbAVt3PiKYLr+GHx2bLSs3M+9MRkwtoZNJGWAqsOLAKBio/mF/xWTNoAN+7X228P3bhp++MVBiAanzvyQlPxrR2X+wrxKfiqNE9ozA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TP8h/I25JgsXt3L2WFBPI+ygTbNoqpONtrryMX9wZF4=;
 b=oPNvB1oSmleiHemuw2CU1kYXvmLetl+CDuAmcg2YRuWRBXWJD2bV4U42qMlAB2BSNnVfmvAjGdXwpO+UCI610nXkO7n4Pfb+giY/1m+ymtEMyYemA2WC5QehRTOk3+TJjkBwszFkksdfPazRI6yBwjfTqp98eGkrygyg80XRt/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VE1PR04MB7470.eurprd04.prod.outlook.com (2603:10a6:800:1a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.22; Mon, 4 Dec
 2023 11:10:14 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.012; Mon, 4 Dec 2023
 11:10:14 +0000
Date: Mon, 4 Dec 2023 13:10:11 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
	vigneshr@ti.com, srk@ti.com, horms@kernel.org, p-varis@ti.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH v7 net-next 6/8] net: ethernet: ti: am65-cpsw-qos: Add
 Frame Preemption MAC Merge support
Message-ID: <20231204111011.q4yfdmx6nbgj3ydw@skbuf>
References: <20231201135802.28139-1-rogerq@kernel.org>
 <20231201135802.28139-7-rogerq@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231201135802.28139-7-rogerq@kernel.org>
X-ClientProxiedBy: BE1P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7b::17) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|VE1PR04MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b4845f-dc06-4369-9540-08dbf4b9971d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sKqGJtHMqlyki+LqmQExWu8B2dUajRCJx5BdNCfUL6vLfBNa/kyUaujO8kol8cl74kJvYh1BgDf1OGtKC2QHdPGgt9+594pnf3IZZrHanNymYsqq7ZxCG2HtPSRliL9hRvc+EIktqgUDQNu242G4ZhbYEEomPqfAZm/jk1kt20cA841eeYYykxXKr0DYuMTS5ANFcZsBCLYzIvT3uHTx/E8u1Ca05ZQbb7P4eT5HuQ+RPO4/GqA8mq5+y3gBlxYYmgI97tQSrF6lVhqf/EuBElt0KjfGds7MfeRJ6h8JYxs1toO/tBcRpHFDW8qVzKPltfr9MZTbCZgtl2a26atAdoPPVobwFs1C7oeCRZvQf1BrKG9FLJ4gN2UdVbgbF0AjSf3+2amasmN5wWty9e2xhBNpNGvIMzabWdIpnujp8eEhgB+Qht6TzhMTRapxOAUtYI0qpEaN6P8PK3lzcGyfiJfFlGFzwxI+DISjoQdmpHd1vAqrVU2wg071ZqtgLQr+MvSCPQYYQe0p5eCTNXMZyc0DwmGgmT7BvwA/ZOU5Rin9HJQsrmATnAoqP5EvY9oMr4K9dlIANFq4Fj/59aLJ/Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(376002)(136003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(7416002)(4744005)(5660300002)(316002)(4326008)(44832011)(66946007)(66556008)(66476007)(6916009)(38100700002)(41300700001)(1076003)(83380400001)(26005)(8676002)(8936002)(86362001)(33716001)(6666004)(6486002)(2906002)(966005)(9686003)(6512007)(6506007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vnp6NXpGc2ZBekdsVlA4akY5a2laQ0JWTVhvRlpTZE0wZ0ZMQitrTlljWDBp?=
 =?utf-8?B?UTJFZVRGL2MySmQ3aXJyZXFGYmxYOFNlZ3BvdHRiZW5XTHBESFJDN0gwV0xh?=
 =?utf-8?B?U1M3cytEbU1WNUZFL0g1b1dwYTBsNWwreDFJRFVzaFFkbGthM1U4R1NRSzR2?=
 =?utf-8?B?RmsrMnJZT3NtdWRBb3d3VDZ2Zk9LYlpoUE9lK0lza0ZrQyt0SFdpSHdYeTV1?=
 =?utf-8?B?dmE0TUR5VXZ4LzE1RmVqaU42STJrTGV5bUtwVlRWQ2dLcU9ZMzJqcVVFSWNB?=
 =?utf-8?B?bytLaURHVXZncFQwVnRTTjJqQy9zTHRaV2xrYWQ0MUhzRElURUZkWmVCSTRz?=
 =?utf-8?B?NHdwMlZGVHJ4d3RhRVZVQS9wNW5qQXI2QjJQQkJzMnRKRHdqM0NhMERTYU4w?=
 =?utf-8?B?ckRkTkN0U25wZXhmRVNjdHpKRlJ0eWw4ZTJxVzU4T0pKcStINmpYTUgvc1Iw?=
 =?utf-8?B?VWd5NmNMaVFmYlgrb0UwMWhBSG9DclhsN0QrNHhYUHlKUW9hTUJoODBxWXNM?=
 =?utf-8?B?Zko3d0ZQTExRcVdaeFpaK1FmcFdvVi9pZEg1NjZTdXc3Q3d3TU1iUTlaYzlK?=
 =?utf-8?B?VXRKNTc1eW1FdC9HR253N0NXenVrTzRUc255MlQ2UUZGKzRaUTRKL0tva2k5?=
 =?utf-8?B?YUg5aEsvS0FzN1VBMDlXakgxUjhmalpPNlpwRFA0MXIyYU9hTlZUcDFZMEtF?=
 =?utf-8?B?V01jcFhRQmovdGVaT0tGdjFOZm80ckFUL3dZZW5uNnM2WXY1QjJ2ZmdtekY5?=
 =?utf-8?B?UlFBNVprQjBJalJYZkRIR1BSMHF1Z1VWajhNWEFEWjFOYXpBQVhNcXBLQVRi?=
 =?utf-8?B?Um1SdHA3ZmlFb1ArbEF6eFpGblZ0bXQ5VG02eE1iSDZnN3VVektEQ3lWS3Rs?=
 =?utf-8?B?clNoeTF3ZWJ1Mm54eFNIRGlmb3BCbXI4Qk9xNTZtUjVsVWErbzdaNk1UbDF5?=
 =?utf-8?B?R0NBQ2xUYTRhSWtJdlpHWTNPcHhMQTRVbmk0dnlEZU5BdUJMQ3hkOE5jMXdP?=
 =?utf-8?B?STA4d1ltV0FWdCtrQkVPeXY5VGpXL0NUYzBHT1M0UG5iU2I1eTBLdytvcWFq?=
 =?utf-8?B?NVI2bmpjVmQ0QVFpako2OUFtNy9DNmgrdmkzL3VsbVNyd2RkREh2WWhGS29C?=
 =?utf-8?B?dnlYSHZQUlpIRU1xbXdxMFJHekFTQmNVTHRmKzhYb0VHQnhjQ0czZ1lIWU9Y?=
 =?utf-8?B?WnltdUJ4SWJFUmFvbUUxaHdjclh5VzhnNCtjdUR2YVNpdWNxMlJxT2J6Y2Z5?=
 =?utf-8?B?RDI4ekhRSXYrTW9yYWg1SXpYbFBUaHg0ZkNLV292bkgvODREbkZybUgzS2VJ?=
 =?utf-8?B?S3dzeUF5eFlmR0ljSFRma0RBMm92RzNjMWl1YytPb0pDMG5vUmRZWEY4ZW9i?=
 =?utf-8?B?K05qbE01Y1pYajRHQ1ZEdHVmRlg5OGRsNnJGcTJJQmxkczdjcmY2bU5SOUxa?=
 =?utf-8?B?TG9MYnh4Zmx1N29BdUlnMGkzbVlxSWdYQnNQMmVlSDREeXJ5bGxUSEEwSlBJ?=
 =?utf-8?B?dGNDNkpEaW1tUVN1RXkvRUYzdzd4OHphbXVNRkIybFBXUWpMMGhaK01veTc3?=
 =?utf-8?B?QUtnZjVEMVRNck1EcWk1RHRIQ0JBeWd6VmMyM2lObDdyYUlwaGEycFcxcUVz?=
 =?utf-8?B?ckJ2ckIyd3QvYXFXT0JyL3AwbEFEYjgvYkRZNWk5dWsydURXeExZM3BNSHAw?=
 =?utf-8?B?ZjJwMFlnSHF1QlIwRjUybnRXMVFjR0pmUUk0UUNuUjl3bnZqRzhQOWRWb2pK?=
 =?utf-8?B?MXJwYjdRR256QWNpYnk5UVU4dno1OGVIWmFwczlkVHJCMlRFSTI4Zmd3MThX?=
 =?utf-8?B?ODcxOWwyV0ZHVUV4R0cydVg1TWhySEdTdUJ2ZVZ3WGJvaGY1OFE3WkVLUVZ1?=
 =?utf-8?B?MDNBUFZQRVFGTis0ZzMzQTFyWVo4MWl4eFRaMm5nYmtrODNlR1FUMXVsanA5?=
 =?utf-8?B?alU4eituYzNRc2d2ZHY1cDF3UlFJOFBvNnVPL3pxMVd1WkFFS3ZjNkZVazNv?=
 =?utf-8?B?dlZVNnNYWnlBUHN5aWVkclBIazZKRkgyYkJ0ZEMvMVJON0phbS9hRkQ1MDNv?=
 =?utf-8?B?NXRXVmg0d2NzQkMyVDliMHVrRFR5L0hSalY3RXkydnNHVGNOemhJMmVhTndY?=
 =?utf-8?B?bDFBTE83Sk5kMW9ISmxBTG9GN05xbjJZaU5UZGwzU2FUZHIxelNaU25XNG5W?=
 =?utf-8?B?MGc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b4845f-dc06-4369-9540-08dbf4b9971d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 11:10:14.6168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEilCUHfKUesZdE61KR5PCxGMvAGUA/n0n7FSXsDT+2An8dIGkDlPxpFh+IrAKPBn27nwOyzjbPVRM9pq7tv3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7470

On Fri, Dec 01, 2023 at 03:58:00PM +0200, Roger Quadros wrote:
> Add driver support for viewing / changing the MAC Merge sublayer
> parameters and seeing the verification state machine's current state
> via ethtool.
> 
> As hardware does not support interrupt notification for verification
> events we resort to polling on link up. On link up we try a couple of
> times for verification success and if unsuccessful then give up.
> 
> The Frame Preemption feature is described in the Technical Reference
> Manual [1] in section:
> 	12.3.1.4.6.7 Intersperced Express Traffic (IET – P802.3br/D2.0)
> 
> Due to Silicon Errata i2208 [2] we set limit min IET fragment size to 124.
> 
> [1] AM62x TRM - https://www.ti.com/lit/ug/spruiv7a/spruiv7a.pdf
> [2] AM62x Silicon Errata - https://www.ti.com/lit/er/sprz487c/sprz487c.pdf
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

pw-bot: under-review

