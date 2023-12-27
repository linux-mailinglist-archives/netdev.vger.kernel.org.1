Return-Path: <netdev+bounces-60410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E2881F1A5
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 20:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56EFB1C21A01
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 19:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D0747776;
	Wed, 27 Dec 2023 19:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C9dpc4R7"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D5D47771
	for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 19:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTroJLtlZF3pu49jO27hbby5tjWiAs+bD4TCbKCfsn5Ej6fR0BRq/xsDVNoUk4S4JjWAtZQy2yLStOPoPiCbFF/lzW3DA47Ku9lbI7mrorhzGEI6T5zLttvIH3HEfjWYxYIV4u+xRI8lcKZ9QcPXw90CvG91SYY1WZmZnNedDRQoI1X/GWEz5ji/jN7cIPBtT83cUaU2CB/xrfVNT2m1Puq22M/B+bdZ+BmYJa0y6OpYFmtmdTftbcQ+6UYGtbw3I1A8BJuO8VnBlUf0Q7GGMkJpBA4qvgzzeAAI38cMXwHox1B2mKSIbVxUYKuxpSJDRLvNMOkc4RmWUDZYS6EW8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dLUFk4taxhP1+BnKOQSxa3miyE9jIZRUq+1CME4In8=;
 b=Ut8EOJquYN2lfHS6HWCLxAMxTLERMEVQBNUbr6FZ4R3k0EimGMLhuMEBlvLmmeS5TX7Q37Gz+zlIZBoRD5/aXKkBkvmWvfLOdS8ZqA8ho2tj9/ujEOpgmEu0IBAs/UriBICcaB9FJ9g/6RHmp7VlPGkj0qK2wLMt4ElIexXJ9ayh+OGvMQatW0E8f588vK/9/y+W8jnw5NLzey/Gu0g344nurLV0SaWOVDMDAMxaTEYed0ctWRirhgtKVpCm9Fsi2Xo2abOZN2A7IjkBOdm6WadqPbg0BXiEfeoaAtQqP1gg9Xd4yalRtvJwSYo5mEemnCQbH0kIYHzgiuWDM9IsWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dLUFk4taxhP1+BnKOQSxa3miyE9jIZRUq+1CME4In8=;
 b=C9dpc4R7kVPtvGoh6f++i08ugE+JQpdQ5aWF3dk9b50mt2N/ytzJjcrda76Uo3qQNBbk7nCyTH0ug0Y2C5EGEFEmGeu6f5yHq583x+c/xH3H1E1fNvXQiZ+Qx2K2yU+KyepsH7alUzIrLpBFKBOD9gpCg5DJrDcbl2FzCnpFjOk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM8PR04MB7220.eurprd04.prod.outlook.com (2603:10a6:20b:1d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Wed, 27 Dec
 2023 19:44:00 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 19:44:00 +0000
Date: Wed, 27 Dec 2023 21:43:56 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>
Subject: Re: [RFC PATCH net-next 05/10] selftests: Introduce Makefile
 variable to list shared bash scripts
Message-ID: <20231227194356.7g3aec3kujnk2qo2@skbuf>
References: <20231222135836.992841-1-bpoirier@nvidia.com>
 <20231222135836.992841-1-bpoirier@nvidia.com>
 <20231222135836.992841-6-bpoirier@nvidia.com>
 <20231222135836.992841-6-bpoirier@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222135836.992841-6-bpoirier@nvidia.com>
 <20231222135836.992841-6-bpoirier@nvidia.com>
X-ClientProxiedBy: VI1PR07CA0232.eurprd07.prod.outlook.com
 (2603:10a6:802:58::35) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM8PR04MB7220:EE_
X-MS-Office365-Filtering-Correlation-Id: 70b5103a-aca2-48d8-f9c4-08dc07142bc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0u9Indc7g8jna6IA526KFh0wXMlXsUQsC5qG2+Lv+vAAYSfEQ4cvYUjX+HQtXEPIer7sPyQw8NN12MUmHCCwnBc67pSq29rNhk6JiGqi+Ua1/99SIXwL4ZsJH8HmppCXHrV+jJoi7RqkKONtD9DOF/Jf0o5dBUCH+0z+qLtyz1Pey39oAasOUCXr/68sHkjdNi3P2JTR8kgxe6K3BJ5bryjIKAcAauoYQmN3lwB95/QYNpL/k/XzPnY82IW8o/QhA9aTWsYwKE6etLpdIMELOCTjV3ifu8hKXTS5YT6VfoX1jRYvB4c3Wldr+vllfspCOEFGT31mv916McmiO27z8fgJDFbo4nzk4kbI6KRsT3m8zIvyAiVZHowhqtg2DATdTSOhkeEwIY/r7rJN1eebUypDyOGpET9+xAW1YkEOuX4sop46j5b7ikN6FxMwKrNmYAjodVynKdpf9mSOCqydgQe72971dRUfNqBSr+kQC3qLNToGKAR2T+O3Z5xo4ETNFjlWxLCGkYtVeDxDGhwKQqtRbl62coAesdX6Ko89bX2qUPL2nb+GpNnxbmoVSB/2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(136003)(396003)(376002)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(478600001)(6666004)(6506007)(9686003)(66476007)(6512007)(86362001)(6916009)(66556008)(66946007)(54906003)(316002)(41300700001)(6486002)(8936002)(8676002)(33716001)(38100700002)(2906002)(4326008)(44832011)(1076003)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?liHXK9KYfaJ5RzwR3NoR3XO8+gUqVDIrI/sf187FRnTTG3H/We+EC5p6Waql?=
 =?us-ascii?Q?0ylqnu2XZ9Zmyrzu5cDW2KDNplZBy9S8xIPndjquz+PPm6rhrvF9Dfe8jnwx?=
 =?us-ascii?Q?3TyDoOvVQN50RsmGeevY0e+fbirrKlUIVBoJhVjE555Aqq60jy5i6FeGmOX7?=
 =?us-ascii?Q?Dhxurzif1yMM7UB9uvnzD5SFr8M7ivLT8HG+d6jj4GPMk/lFvNbYMLcwXmJR?=
 =?us-ascii?Q?TzwVUB3HFQrmzfBZ0WJqjRoe7f/KBZmcYSB++MB2Lbot2AkiRSjPSH98q43B?=
 =?us-ascii?Q?JB177liqMr9Vz0RJRW8edlWd1OSCpEpPX9eMcbAH/N2qYUhx1a1paAXc4K42?=
 =?us-ascii?Q?fwTn29XdW25gERKI7zcOvbld7ORoFEv9asXZdlnWQyMINN6dQuz4ose1vvoo?=
 =?us-ascii?Q?F46M/v3BI4q0N1MXG9BbpzVI8ccoAyQAwvsj+IvPIiW09YGJO22P3ovWiSc6?=
 =?us-ascii?Q?ZMGSCs1JO/xKEn/Eb4h1IBAjFGF25+aTkCvJMfDij5rBkSRLxz2metKWVLYz?=
 =?us-ascii?Q?xJtyVWDD8nBeP8REHIt/QIRi1BTszL+VXOP/8i0CwUX7sJoy7FIqN7gLz3LX?=
 =?us-ascii?Q?GciiD5Sud/LYMwinTpjyiOXjL0w+ckBMEA6QNLyKnPU9d3zfDxBQze5Z2nnz?=
 =?us-ascii?Q?PsRbmSWX3KYWGFeelvgki3s+tFpAJFn++r5WMYb06LkuQNbhGpDYGNLhdiHm?=
 =?us-ascii?Q?zZ1zfHYwWECgaWR+aORjqcj+QaThYAM6B/KeK6gniXWnDGCDS0v4Pa5t/lOx?=
 =?us-ascii?Q?J4GvxMQo40lTg+qond0zkgmC4DLiaU8hm9JzSEAXjL/bHP6z2tYskZOEnOlb?=
 =?us-ascii?Q?RC/FkDuJ4v3AXfOh2ctGqp/jGRJtQWtv9KmqW1nBrL7aoz9BFsPv6MG/NQmf?=
 =?us-ascii?Q?my6pwMenMS9lfiS9WoM5KfEQM+RdHJloPCIAwb3LNu+oK3Pu6Avb6GtMlc37?=
 =?us-ascii?Q?WMn4q0dYRumbMVZ94UlZGTAw15y79CQZRpKdJFMl7xa7pwsYaEQ0xJXecfLj?=
 =?us-ascii?Q?JZgERgfxy1IMOjjT964Ug234sd+W18BFeh/4X0o+R98pIwuWVbD2Qyd4QFfV?=
 =?us-ascii?Q?Tl2yp0GxfpLFC/HZEr6AeXjHtAgBMrePMZIpn1t9qNIFpoNi6I6S4/ndDIxf?=
 =?us-ascii?Q?ZqZm6vkjKQqns3EKBVWBZUfwAbR9jbiwdvClMLss439QWSwQizdfRdIusN1e?=
 =?us-ascii?Q?jtLSPjPYBdt4XStirWZ+P9dgzE3q5sisKbQLx8KyHtz+XcYOSZsaWrXo9qDh?=
 =?us-ascii?Q?oG5+N/AUfCE3YeOW08w1cfiZuLL0Ebu3/tkiOglk5dJvT1DYfsZAMXPEhjD1?=
 =?us-ascii?Q?O5nxUmz4YU/hbjO6UYe4uU0InTTT1W56yT6vzzuxCHgR2Enavydl6qiO3zfh?=
 =?us-ascii?Q?WfxVCuRoHB+dc4wkMAlyD6hl0/ybIBogwl0XB8XoBc9NZiTEYn7GTpiphduE?=
 =?us-ascii?Q?FzCkG8cN1JdcywGYOsF3cBgE+wemsroB4EqlSwqQgXEroq62klYhdmHieG21?=
 =?us-ascii?Q?I+FnGEdiklcrNi0H4V9vZIIJ5TbvcUA4nw0UYkFAUZYskx69JeLU6oGgZhDO?=
 =?us-ascii?Q?ek2ZN544bLrw19L+kKkkr1O/VLj6M7270YwJpE9OYTxL/lqETqVsXB/B+8nb?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b5103a-aca2-48d8-f9c4-08dc07142bc7
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 19:43:59.7807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jnF8//VOys7KAamxeDW8/lHz2gNURqgtRVtYxFzebmyEbgzX7clyEWocH9Tc42xjQ/v4v8C53tw69rbsRgbnzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7220

On Fri, Dec 22, 2023 at 08:58:31AM -0500, Benjamin Poirier wrote:
> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
> index ab376b316c36..8b79843ca514 100644
> --- a/Documentation/dev-tools/kselftest.rst
> +++ b/Documentation/dev-tools/kselftest.rst
> @@ -255,9 +255,15 @@ Contributing new tests (details)
>  
>     TEST_PROGS_EXTENDED, TEST_GEN_PROGS_EXTENDED mean it is the
>     executable which is not tested by default.
> +
>     TEST_FILES, TEST_GEN_FILES mean it is the file which is used by
>     test.
>  
> +   TEST_INCLUDES lists files which are not in the current directory or one of
> +   its descendants but which should be included when exporting or installing
> +   the tests. The files are listed with a path relative to
> +   tools/testing/selftests/.
> +
>   * First use the headers inside the kernel source and/or git repo, and then the
>     system headers.  Headers for the kernel release as opposed to headers
>     installed by the distro on the system should be the primary focus to be able

I've never had to touch this infrastructure, but the fact that TEST_INCLUDES
is relative to tools/testing/selftests/ when all other TEST_* variables
are relative to $PWD seems ... inconsistent?

