Return-Path: <netdev+bounces-257572-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCYBGggDhmmyJAQAu9opvQ
	(envelope-from <netdev+bounces-257572-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:04:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07547FF6C1
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0AAD3048E0C
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 15:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2452773C1;
	Fri,  6 Feb 2026 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s6ziI3wI"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8A02765F8;
	Fri,  6 Feb 2026 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390187; cv=fail; b=B7T4jcP8Hn8Cariyqz477xGbVMr9gf8ssh1RxAcXZI9VDySoGiaqp44HrpGZRol3lKuWQQTfsIg/ym/hhxiXPvIa/2+HkHGhQO/XxxP2KVff4+MdfXQ5WiYScwWlwwN5br6esdiODBrNV5UPObZZhigExg8grarRl0wOfE9h59A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390187; c=relaxed/simple;
	bh=q+w8vLxYNyKjX7Es27XNXzenv1dicxTs5STWE8Yi0zE=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=of02+T+HkBL3cUlQNH7QecmRk0X1N/PligbOJKSN+p8Bqk4Gj9hHuE62HL/fvpc8ZcbYFFIuhssfZOY7IAncYt0KlVi0D8wtiLKCHiqCleF7kTjOR5l/TRXkwkW8x/taeSX+U1Rl18RsTxIe7+cRqnxnM/kMxG/jCrm+LR7ckUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s6ziI3wI; arc=fail smtp.client-ip=52.101.52.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nb/b3Y/t+6ovB7TOE7kgqBsX3NT2E4R8lPeQdgdQr7zFut0FZsBOZeK68mSar0cqudKGAv7hJEcV+aYJdsC+Q8IuwjDiC6wY4VrpdGpqWvx/fnUO2GXs4EepCoJdLAc2pIB2u+9CmGY7fVoMenh+0oRKQ4M9+JpL3myl/qF74DRqo1SV7r18YdApD6vTY6yEB4Xg2Z8/L+H9BgBFIlShbeqqD1sebVOvr5GkvEweZn5ufOR4PUyZ1QRTnxI1wa2xBkG/G+DXJzqsjmkkXIGUy5kf3HSsIHWyNctn+yrtCnsJ452ajbT/hfWvOeT5tVRpUNiwhazGv4zyhV2oJ6SR7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOuSLoQQL7jtMguh6UIM1yGrivZzpBPPULJHXlDBxl8=;
 b=FEzA1oYvrXdAhka721q0kTodKBCVrMBMOLryhTx6sBxJ8BEkWkJip9y47APJCn14h265HDwkit2fJDGQ4djof9p4bX7HZGw1OUHTV4+dONi/kHngKXkNuUOW7pO89fXFK5YfvAkqCZ8pASrkV1fLdt6MbcTvtUr6gz4bJtUx4gNZDGOpIRiRX2UCo9JvJjL7fltG7VBoB0EYbAmhBnNGTUBmc5gAVlQbDumAea9c7HUTBJ5tAD/iOlwHRP6YhpDKLtYVxE5izigXeBzvqGM1Xjp0WdClvWHPNjFRD2SMWamIEVu1G/Hh64oLrQR/7ODKhqC2pw8cMNWmsl8MMUNjew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOuSLoQQL7jtMguh6UIM1yGrivZzpBPPULJHXlDBxl8=;
 b=s6ziI3wIv9q1p4/J3WYpGcX/CTn+SK6UV6fOvJ3WEUifSrBvqCqb5OkhNj/E5HB4alIsW255gwkH22o4TGDKsuu9RwFbJw8KaNEatSwVEKBHSb9/OI4mM8C+5lMchPz0pQ7bRtrtnq7OqTvLYaE1MqkQcBDJJ36n5nZmdyNkiVDq0mt50KLKwE383mJfxP8nXlu1+aq1C5oz/VqNSc3DiymNS+e3CguhtXczcvR6Riv8LuZ3tmcFTAdJHbnF83WOsL1Qf8SkcIH0xV23qSsOlt+5CP8ZwdbLfdzrSST3BS0r5AEcIIgCWTHpCY1OoTfZaAdfy28GjG75NkZiRPq4pg==
Received: from DS7PR03CA0033.namprd03.prod.outlook.com (2603:10b6:5:3b5::8) by
 DS0PR12MB999106.namprd12.prod.outlook.com (2603:10b6:8:301::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 15:03:04 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:5:3b5:cafe::89) by DS7PR03CA0033.outlook.office365.com
 (2603:10b6:5:3b5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 15:03:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Fri, 6 Feb 2026 15:03:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 07:02:40 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 07:02:34 -0800
References: <20260205220541.2992807-1-kuba@kernel.org>
 <20260205220541.2992807-6-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shuah@kernel.org>, <willemb@google.com>, <petrm@nvidia.com>,
	<donald.hunter@gmail.com>, <michael.chan@broadcom.com>,
	<pavan.chebbi@broadcom.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 5/9] selftests: drv-net: give HW stats sync
 time extra 25% of margin
Date: Fri, 6 Feb 2026 15:40:30 +0100
In-Reply-To: <20260205220541.2992807-6-kuba@kernel.org>
Message-ID: <87cy2h29vj.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|DS0PR12MB999106:EE_
X-MS-Office365-Filtering-Correlation-Id: f35a2b9a-fbd5-4f82-9937-08de6590d409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C4LFKmYlntpds2FPRcFrwRCi8EgCqL4skAaztYD1/Ip18ne0QC9GUgrevmgJ?=
 =?us-ascii?Q?B88gZjhsAsbbIHLjzYC9HfrZYFD9p0rg5zi+J8eRFAJX5O94Nd73wya561ev?=
 =?us-ascii?Q?0eTu2t897BYg+cSH5kGW2WUxORS3MH+34dVbx7zxwabWiiuYe7YMGfr5Ldvb?=
 =?us-ascii?Q?qCZ0xyXQ6kbpJel9pv8L9XSEscrSIxHQN9vBuSjXw5/QFWpG4QPux9te7IhR?=
 =?us-ascii?Q?+VOabEgXTMoBanPpb4JDR7bJGPSB8KhCpt3a+C7yOHo6zB4awn9kOyVJgTMT?=
 =?us-ascii?Q?SqKJB7WBs1kz+DnSLwad5Qzaxg1TWpbSEX27qNw+DNO28cZOIWROKlHX7IA1?=
 =?us-ascii?Q?B2syTQWJzVSo7pnKj/j7d8ffI9R8LJgh3eXAukd0+x+OX7ynFx6YAfSOMBjT?=
 =?us-ascii?Q?YWqw069aXHyZ74TobgYi8fzM6vhKMl7wfHFo9mlNdThDH0wDOXkDBN4a9fiV?=
 =?us-ascii?Q?0h1HogtWsOwBIqChs96TxkE4uiK6+Kk3VPbzUE3G24nbSvZVwVnM+ChdYkz5?=
 =?us-ascii?Q?83yT9RYJ8KVllBKvX9vSJnFql3x/hsVEqgNPs8NTT6u1H2M4RxVJROyxmswj?=
 =?us-ascii?Q?9ZQs0E0HH+fo4Vb2BI7VXiPZX7e6HT+m7a8btxf4s3I2GANW/Z4Xc041wAlj?=
 =?us-ascii?Q?UzMk/17NN7ezj1ZJ3e+co3Ds0PVwNt8gwJ+VDdpz6+49L8O0XEBqQFOJu9I2?=
 =?us-ascii?Q?Dx410YAtaFXnw5xHRxJhl5iMim+WmKmzG/qroqRBAwQ90MkvdWG3h/ZB/PSG?=
 =?us-ascii?Q?+j38PsK2umXwNTp9GLJHI4/3QttHu7r7i2lADeBuvriwBTQ2AhIWJsZRCDmA?=
 =?us-ascii?Q?1FRJQ3uWNr6sWVRXwIJC1A2DegvALUJCDb3KaB/obXfWJ1+VED8ggeJTj3oM?=
 =?us-ascii?Q?wE0LxKr+gIdkA4Wd0V0B4mjq2rtYdFFxhd53HbwS6/OTLZVqA6gE9y2cO1R/?=
 =?us-ascii?Q?DJbMY1ItLXCLepEJNcKptvAjSmtZ+B+b1+VS4g2QKIBkCfW/IdHe0bcqCNik?=
 =?us-ascii?Q?ovNK3rq1F+4AP9WL82kRQj36HYAI16ujQb+IZJzD3TIFa+nTVIC4AZs7E/uF?=
 =?us-ascii?Q?1eFBL5OcoorQt/EF6KrlLKCf4/FuuunMbvUr5x4w4YNRUE1g3yMULgLn6LeQ?=
 =?us-ascii?Q?Oa/t71dYXjMklOoKGdGYGG0EZOE2JM4I2yj+1M59+1DX3fPpqlkbbhqf9cI5?=
 =?us-ascii?Q?DKg+/qNUeENJI7KJhq0oVy/VEOZw9iiHPktN2Kb1zPHy3gYgYwX2/dvw6O0I?=
 =?us-ascii?Q?uVwMwn+zHQSQzfK23X0RXvmnh/NcLFReKj8WAEyD3sGeTwIgARf77/Q7yGVh?=
 =?us-ascii?Q?Y5ZYVdQ9gYQ8jeo+svt+LF0cdyxIvF8G8Bcx/c3LHOPmKWwlaHyVVfHB4wqF?=
 =?us-ascii?Q?tD0HmuluBe38wqQJwpo1C1L4h0i2gPJNICznIJcsqZNiK32EpQJMewIs9GgL?=
 =?us-ascii?Q?w1GdottaOPEuzUeDgNPg/iOuMS2omcpsNI2yDdiDLPbUIt/B/UySF2hrqfuw?=
 =?us-ascii?Q?TgN25FYAs9TxBOJaZSNsaJoQWwjI5x3PEqqm4/oL0u+opbz/dEAHOS56Ax+b?=
 =?us-ascii?Q?+hY/f39dZo87yWjzNkrfoCOcBd281NDFDnxCZNQSoxCU9Q+yCotLhvLDS50Z?=
 =?us-ascii?Q?XoqpwFkriVH7kmqjjILRvvs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WJf/0u5bdfDA8b37UQ43Fq0uvSCtR/M95NqEAqNjoAJMk5TaWF9Or4lU+n3nIcLuTqaxKJKk9joUtwO/XHhq3UE2FQqeo3e1EDxyvj8huAm1iif3pNZ2DvpRKh+6o2SVimf4WUyTBXs5ykEdSHM6pmNrZ3+QMjrMDRSEVJDCyl15jNWdvLJ1kp6IIqsb0nM3v76rHUFDU8P7WR56kuQaxADkcbrI4674skw7k8+yuFNlj4lN3uxXC4dziuxie0/x3JlAIz1FqBqVyG48ynkirmCuB79MZK4DnZkbwzkBbzMgauW657IiiUam2C+Uea15xXpxN2QGMUdqkUVRL7fg49lc8u8n8No9DFpENw2esHFsxXKMFvweC1BuKMBsw7TXhOn1PHvqkm8vSBkaDj4Pxu9HWUEMo5c77BBP0hodCQA0kyPXd7GULMmgNr8mqGIj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 15:03:03.8637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f35a2b9a-fbd5-4f82-9937-08de6590d409
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999106
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com,broadcom.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257572-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 07547FF6C1
X-Rspamd-Action: no action


Jakub Kicinski <kuba@kernel.org> writes:

> There are transient failures for devices which update stats
> periodically, especially if it's the FW DMA'ing the stats
> rather than host periodic work querying the FW. Wait 25%
> longer than strictly necessary.
>
> For devices which don't report stats-block-usecs we retain
> 25 msec as the default wait time.

Right, because now the default is 0.2, and we apply the 1.25 multiplier.

> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

> ---
>  tools/testing/selftests/drivers/net/lib/py/env.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
> index 41cc248ac848..39a98eb2592e 100644
> --- a/tools/testing/selftests/drivers/net/lib/py/env.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/env.py
> @@ -285,7 +285,7 @@ from .remote import Remote
>                  if "Operation not supported" not in e.cmd.stderr:
>                      raise
>  
> -            self._stats_settle_time = 0.025 + \
> -                data.get('stats-block-usecs', 0) / 1000 / 1000
> +            self._stats_settle_time = \
> +                1.25 * data.get('stats-block-usecs', 20000) / 1000 / 1000
>  
>          time.sleep(self._stats_settle_time)


