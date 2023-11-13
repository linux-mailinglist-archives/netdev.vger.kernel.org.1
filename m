Return-Path: <netdev+bounces-47377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F26047E9DD0
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 14:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 917D31F21314
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 13:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47703208A8;
	Mon, 13 Nov 2023 13:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kLgtMgiv"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45C620B0F
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 13:51:23 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94427D51
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 05:51:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxVqeMCAMqu1SOpWt7C4cZBhoHFcksCCa1CV93raCSJPnTs5v5+p5kMdDeOnTPZmdbRlH+mVvPsQUzF3NJWzhAkJGBQE4vne71ukHuu5r5eOAZcmAXRh19JTkyr2MHZp+LnrIWVZGFgUjbVqALamHflf7Q3azsyGMzmt3AaXselJN/hREIY87pgfjfksvxWXxZOsIo6zQY/09qQ0yVNwwV07HM/3IKTkE1ZBe74/HsKR3dcqHSiveVTHZuXrozCjDEQ2FKt1FzdPe9krcRlqufAwNNWs0GMtpkW9ll9UiB8AOFQjVt5spvxgDrzXlJjv6pIvs2NomfvjSmmnc6GMRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEkFQQ8viebjvXxisb8Qvyutzr6fo+q98qsfyv9goHo=;
 b=BW4SNVF5u3jrvLmE+eTLbTsaPcIkpJGkggwEmN/bv1u30jgWecedkiUDppK9qPsVgcNGsZ2RMHqURgm2ABii5lOq6twvKokcYaaNw+JQth9G9OHxo0aTbEmS2Y/y9LZFRnG6HwIRqiM9XfrCi2Pnv3/pCV9C9v1GuUFkiR99Zk/sEa3FaxylXgDs1vQA7PcEIDQ0/vLNe+KcD2gAFt7AvspCwWDIXqBVtWRgjAyFuuwyWFg2Q8F2nbsj5mcGkLNtfkWc4W1o3PD9UqmzzRct56COKMn9bCgvR3YVMGvEwz1Qg/ShtBrgfuvETmJtvyq5pS5MISF8AgPbjsKTLVex6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEkFQQ8viebjvXxisb8Qvyutzr6fo+q98qsfyv9goHo=;
 b=kLgtMgivmlELqYjIl/dHNuCZSf/nhH7IzO1sJ9FR3izFBDVcJxDibncVyDjonYGAKy8QMkzAZ3bV784ICpQPVvoIziffHApdZFfJFKTqEJ0wC3U/Jp6BzJezg9wxhZ/1xvj86il/G8yZLso18Q6Ywb3tW0kkKnM3yWKbSdK0rte3DQ1y04GXkwkdVQwVz5HaMNPgxSKjJOaDJDQAjHT6IXzniQ1c40vaE0wBv6b7vaSj/7ols4turjDGdblPoIcU7YGtrxxarBZ32Ig1lsvX48mbYkHeXQI9Bso/oDgQEWvAC1hKCQ9EwBTUSQnBbqyIIN0cYUKPLUB+/M1DEtvw3Q==
Received: from SA0PR13CA0002.namprd13.prod.outlook.com (2603:10b6:806:130::7)
 by PH0PR12MB7864.namprd12.prod.outlook.com (2603:10b6:510:26c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Mon, 13 Nov
 2023 13:51:20 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:806:130:cafe::8e) by SA0PR13CA0002.outlook.office365.com
 (2603:10b6:806:130::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17 via Frontend
 Transport; Mon, 13 Nov 2023 13:51:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.13 via Frontend Transport; Mon, 13 Nov 2023 13:51:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 13 Nov
 2023 05:51:04 -0800
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 13 Nov
 2023 05:51:03 -0800
References: <20231113032323.14717-1-daniel@iogearbox.net>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Daniel Borkmann <daniel@iogearbox.net>
CC: <stephen@networkplumber.org>, <razor@blackwall.org>,
	<martin.lau@kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH iproute2] ip, link: Add support for netkit
Date: Mon, 13 Nov 2023 12:38:09 +0100
In-Reply-To: <20231113032323.14717-1-daniel@iogearbox.net>
Message-ID: <8734x9yd6j.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|PH0PR12MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: bc14f179-fa40-459f-123c-08dbe44f9db5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+4BzEpjn7g1/6Uw/IBNOzYMOk2oDZ5YQHQ8XnHxQgsCw+JMzVbypsa/JOPvIpj7nu93+7R3YmpFqaFZJX+yo7Du+3ILEuoAcLlCm6QRWdt/K9z2ZetVsvsSbNdAZNPPYziHOPpEge8od89xwfpT0qLcdmBuTJ7ANENq6T6sx4K/xq30+CJaSDIXsPU0xnQbBrdOPsH4uoQ9DzSckE6CuKHvk2FkDG/zb9/HyPUNci0SiiFh0MxEu2YoGT9tdwJJ0rduz4g+X1oh4PiY09OElAYCag+qOsKKUzQS4DbM89KPxzIkDE4Fc6oOWxKy2WxAwAT9ttnxFy/3yA1Ta10DzQgucDxJDbbQEtyDVxQmTDKA+rdb94PAEanSB5KbqLeCqG/+jjNuPSEzRsg5n8VfBTWy5AxSBkaui829O9i4VIwysAzsnzFsuL15W0ZmQOLntLDMIpxytFDsdxVho2dASRphB4wzSDC+8lBiuL2sw1C1w92H32z/+rFQ2BtTccBZCd4J6BAgXS2EGRQwZdf862/waaxOytWhaJFonsw35TdTDnw39mGaioC8U55jWbznHFTPgPd7XLdth7VCi9/zbcNSZqfV95WQfZcQjCtwv6C7B61DrRNpUkxrcrqQU56PQ2vSaZrw6pwpYCqhs+gD4GlOClfKmmzYto7u37hpoAplthjxtiXeX6N/6VcvxbkgR9ZDiMCRWJtrVy6bDBSBCJ2nnQT2gN8LU4wa0JKXh2/DauhRvaj5QBALIGb08qSjL
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799009)(36840700001)(40470700004)(46966006)(40460700003)(16526019)(336012)(426003)(26005)(2616005)(36860700001)(47076005)(5660300002)(4326008)(8676002)(8936002)(41300700001)(4744005)(2906002)(478600001)(6916009)(54906003)(70206006)(70586007)(36756003)(86362001)(316002)(82740400003)(356005)(7636003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 13:51:20.1246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc14f179-fa40-459f-123c-08dbe44f9db5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7864


Daniel Borkmann <daniel@iogearbox.net> writes:

> +static bool seen_mode, seen_peer;
> +static struct rtattr *data;

Is there a reason to have these as globals? Neither seems to be used
outside of netkit_parse_opt(), nor seems to rely on maintaining state
between calls?

> +static int netkit_parse_opt(struct link_util *lu, int argc, char **argv,
> +			    struct nlmsghdr *n)
> +{
> +	__u32 ifi_flags, ifi_change, ifi_index;
> +	struct ifinfomsg *ifm, *peer_ifm;
> +	int err;
> +
> +	ifm = NLMSG_DATA(n);
> +	ifi_flags = ifm->ifi_flags;
> +	ifi_change = ifm->ifi_change;
> +	ifi_index = ifm->ifi_index;
> +	ifm->ifi_flags = 0;
> +	ifm->ifi_change = 0;
> +	ifm->ifi_index = 0;
> +	while (argc > 0) {
> +		if (matches(*argv, "mode") == 0) {

matches() has been out of fashion in iproute2 lately, because it makes
it not obvious that newly-added keywords do not break parsing of the
existing ones. Please just make it strcmp().

LGTM otherwise.

