Return-Path: <netdev+bounces-38236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA957B9D3C
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 15:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id AC2F928195E
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 13:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0068318E1D;
	Thu,  5 Oct 2023 13:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Br8zoP4+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B0A1A262
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 13:11:33 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on20617.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8b::617])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AAF2754D
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 06:11:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvFSd+lBUjVrYMzEot2vh75vZqyJQbXCsdM62hzl0NDORyWBetKPQ0/+cZGMQDscbyp6we+KvOdPhj2tIrYni62hzxIUZseSSCCamre3Ln/jarXcJtXzCi7BdFofVmhwAqdi+trrErCK25RNnA9hfIMkw5NKpi9PX1bPZ/tQyLbiNVaHL5Vb/I29zckKXKW6aQYXMDTYBioHcpmSm3NxmeFjY3Rr9Er0mMFggUJ42/HSe9E1T8XRJmv7jLRoO5v5qDhvBAZoCnTSjPkG95dX/SNFY7PMmJi0BbI5PT/S3J3nZ7xum8mj/oMlYwnJiEoWfPdk5TzjqABonu4tOxku/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xc/uoW0WelnHhf59V53Se9wB5NxbONqnKQke3f1yxSU=;
 b=DvZWMaIRmIXmFPw/pj/wDSbUkfdNXAW1sx1h3X7y56lGg0ikNUMbFplVZwChJDyI7FuU6eDF2rdwNXSJJeRbXZ1Z0df1H1IgVJw1phzinHcJRpMVG9kagUXs6aSvNHx95wscK768dBq2Eb8fsDAgh0vwpifiRktcHW/3sn5YRpf2g2bhVDv6fiqPZgS9m3VuHFc78mwZEZNkXLx7+ntJqvYFx87p+WYDFJqRSgNZCD/ClSkc0zyXzuA/JbnRRGAyRxRb7ERn6f29cQPqsAbkmocLeXp8q7y3PWT6ujIZMw7qf0XcUtTTINbFKMNAQc1IifhbuKOoi8s+R19KMrV/Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xc/uoW0WelnHhf59V53Se9wB5NxbONqnKQke3f1yxSU=;
 b=Br8zoP4+vX/PNsZ7wXb5XRoNCuy569ZcbWKjOTXKmEdEzLKIhFWy2X+IAgAGmGPDoj3Xf/rqzjg5nAZu/GoRYKjOfx7sliNuZuO4/4kOJ1GU1Wj4wQWfWNmmOTCfXiNKYRo0FGeYM6nOGWTvKlCZGvasMMJ8cD4vbkSCZk14jKsjutRu3IJC2a2M+i/DZgj8d3FFE71haeqM/I8yYKQSTls1QCbjARqPxw0Uy5mAY6+BxKGKTlhEOTJ3z1LOidioxcVPTGuuNEFe/B8oigWkz2cbuYmOQ8lCYoOapsrRIItOkO9SbUTTYRlfHn7yc9tmQEBKm4lVci1iCJlyoqYspQ==
Received: from MW2PR16CA0013.namprd16.prod.outlook.com (2603:10b6:907::26) by
 SJ2PR12MB8034.namprd12.prod.outlook.com (2603:10b6:a03:4c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 13:11:14 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:907:0:cafe::1) by MW2PR16CA0013.outlook.office365.com
 (2603:10b6:907::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Thu, 5 Oct 2023 13:11:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Thu, 5 Oct 2023 13:11:14 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 5 Oct 2023
 06:10:55 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 5 Oct 2023
 06:10:53 -0700
References: <20231004170258.25575-1-stephen@networkplumber.org>
User-agent: mu4e 1.8.11; emacs 28.2
From: Petr Machata <petrm@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <netdev@vger.kernel.org>
Subject: Re: [PATCH iproute2] ila: fix array overflow warning
Date: Thu, 5 Oct 2023 12:16:22 +0200
In-Reply-To: <20231004170258.25575-1-stephen@networkplumber.org>
Message-ID: <87jzs1qko5.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|SJ2PR12MB8034:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd6269e-ba9f-4d8a-75f8-08dbc5a48d85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eHuIsqBd7eo/CDxKK1rprfW9uWhLnrtj2zzkhhzE6nfXd/GfgZqhPzJ7XfkTJGy9g0Xm95ujwOox0v6JjEQ5o/6sellX3I5gCR30DRVh+uaQ5Kb78eXo6SXMhgvSLOb6CXf5tDcOIncyYiZjwsahuziaP7yfL6ysBYxenQEyB335ro3n+EYHw2+oinC38W0SjnVQxVwfPE7WrzsUCDGHLEKHDgbnuYIvqH0N5CPpqSrHKlk+iDz/CkzIRQsHnBk9ok1XOj2Ef5eWChTCLr0e1knr7ekn7ht4ea5OIy77DyghYJ8nc98z8Eq22m0GqtjNZpSpV7SFswP07dLcriO70DYK6OYCk7hX0wGq5oQCc9hqa1qpQNNUE7nznn/BhiaXW7q/RsTw+ARjcWoyDTMRZXXAuMeEjIDC0cmOqQyqWt+scJRnmPt8YTa1qhXKczcFDjKqW2doXCQiv3SBTdmiDBmBZ+EmXxA1GLv2A0i2SrmQ78/52zIE0qQWLsAYmiWqBVPhF6FETnSE9qiSQS8Famy5LzM7yO4/26sBUiFErX6Rg7oG9sjXppfbN0Jc/JJbcJQGleR6noaLuJ8hRHyiF/A1Ln8Zr7x726IlYGZYnpFU0VrzIjJG+FXBxoz4QboJ6wljpTNuGYWLOa62NHUERO9Cw7vq+iReKY4lZdHMTqlJbpjt0R+MArJFIDDc50pzJttqUYkJBULo3PgNB914wjDckFiVmVfD2lm/2A8w2jDgWuvv3h4ULxqi3WMgYfOr
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(451199024)(1800799009)(82310400011)(186009)(64100799003)(46966006)(36840700001)(40470700004)(41300700001)(2616005)(426003)(336012)(5660300002)(40480700001)(8676002)(8936002)(16526019)(40460700003)(83380400001)(4326008)(26005)(36756003)(2906002)(47076005)(4744005)(36860700001)(6666004)(7636003)(82740400003)(86362001)(478600001)(356005)(316002)(70206006)(70586007)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 13:11:14.1918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd6269e-ba9f-4d8a-75f8-08dbc5a48d85
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8034
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Stephen Hemminger <stephen@networkplumber.org> writes:

> Aliasing a 64 bit value seems to confuse Gcc 12.2.
> ipila.c:57:32: warning: =E2=80=98addr=E2=80=99 may be used uninitialized =
[-Wmaybe-uninitialized]
>
> Use a union instead.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

> ---
>  ip/ipila.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/ip/ipila.c b/ip/ipila.c
> index 23b19a108862..f4387e039f97 100644
> --- a/ip/ipila.c
> +++ b/ip/ipila.c
> @@ -47,14 +47,17 @@ static int genl_family =3D -1;
>=20=20
>  static void print_addr64(__u64 addr, char *buff, size_t len)
>  {
> -	__u16 *words =3D (__u16 *)&addr;
> +	union {
> +		__u64 id64;
> +		__u16 words[4];
> +	} id =3D { .id64 =3D addr };
>  	__u16 v;
>  	int i, ret;
>  	size_t written =3D 0;
>  	char *sep =3D ":";
>=20=20
>  	for (i =3D 0; i < 4; i++) {
> -		v =3D ntohs(words[i]);
> +		v =3D ntohs(id.words[i]);
>=20=20
>  		if (i =3D=3D 3)
>  			sep =3D "";


