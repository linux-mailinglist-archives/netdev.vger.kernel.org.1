Return-Path: <netdev+bounces-19457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 198CE75AC1B
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 12:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC391C213DA
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 10:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17DE19A0B;
	Thu, 20 Jul 2023 10:36:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9E2199ED
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 10:36:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20610.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::610])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65841710
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 03:36:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVt47/roIsUXoXfN2LYMvIE8drWWQi0cusD62u7xoK6oBNt83BKvi1a9kkMA+KsFjBjnPfhf7uHCC8UFD6MznVNJ2+1pMGkrrHfdf7XbIrtM2upJiTBZz9e4210FfIK4utL0t5LlB/GkZ9FTvgYVIH1p/ay+yzW/+pdUYTVmyGQlljaMo7X2xG55LhhtVnq2gGElS+CTGHHzHrEd9zgOa4zJkl8zAiL5HNXA+9IQYblUosmcK+1oxg62V6nu8wYF9XxOgMYTt6H6zkKrpPlDTbavqBxCavBq9Mzr5vTQ6zgMDzFzPQJ2GhEisHp7a/JcHwaZGuR20ITRXOAUZ+iMUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRM3GDapcD+SXnLEDwoW21Vo+nkjKVzAqT07LMG6xKs=;
 b=OZIG3SoCcbZcD7pskTLFgBc3WN1hpRw1fnLQPay0lBDq5F2wpJNeQgU4S4hpsHYvh1/SQx5KPUDXpBfOe9n04++C6kmK+T/8Kmk74wCQmpeQBr6rZlthlvJy1esKtfyQMkKZEwN+WX+YvHDSA29ferIRtArDczi6kWVw6NzXnwJzt74HkvGFJ967Srzu9pcm3cYjRrbyglpUvXyZxzta6lwHKxcFKEwqtIZsF30++cTz7Iz1Vz8cmVwT9ZZ+IhIHKXJ9owzqkZOUHZ2SYMV6Ymno04Zv8DPQQTqxhV2tQKW9jP6sBZjuKOiWtlq/SuHH7gaLURaoDEcDq1egx5AtZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRM3GDapcD+SXnLEDwoW21Vo+nkjKVzAqT07LMG6xKs=;
 b=LQzLMUOhwDypaGh7KnlmnsnMP0qRk1OGeFxy/KkuThSTCOf3+Gy9iMPynkbBU44nCfor7F0CR7Ukk+++f94th/x8pgM7LSqQoBKU/7aSlmpIput1OFU7GYQXRtgbdlG+Ef/t/clhq1/8HBKF04ULGEFaX/kQWRWz+HW9B2vmPwdott9GJoB5JHIWUXE7VI2B+BUZn3s3+Q++YwuNYqy5JDzqjj3xWKejIbY4ZXlV7C42ya9CoohJ1ZwCn3C3jKal6BgXuE1hXoEDNBDSqMajpO9xgpJPtNaqkSAz3pJhAEOY0qQnF+jpbVc9IlS9x2EZUeTTv881RXxtlzM2e+r+qQ==
Received: from DS7PR03CA0101.namprd03.prod.outlook.com (2603:10b6:5:3b7::16)
 by CY5PR12MB6381.namprd12.prod.outlook.com (2603:10b6:930:3f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Thu, 20 Jul
 2023 10:36:12 +0000
Received: from DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::dc) by DS7PR03CA0101.outlook.office365.com
 (2603:10b6:5:3b7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25 via Frontend
 Transport; Thu, 20 Jul 2023 10:36:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT111.mail.protection.outlook.com (10.13.173.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.37 via Frontend Transport; Thu, 20 Jul 2023 10:36:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 20 Jul 2023
 03:36:02 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 20 Jul
 2023 03:36:01 -0700
References: <20230719185106.17614-1-gioele@svario.it>
 <20230719185106.17614-5-gioele@svario.it>
User-agent: mu4e 1.8.11; emacs 28.2
From: Petr Machata <petrm@nvidia.com>
To: Gioele Barabucci <gioele@svario.it>
CC: <netdev@vger.kernel.org>, Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [iproute2 04/22] tc/tc_util: Read class names from provided
 path, /etc/, /usr
Date: Thu, 20 Jul 2023 12:10:50 +0200
In-Reply-To: <20230719185106.17614-5-gioele@svario.it>
Message-ID: <878rba98fl.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT111:EE_|CY5PR12MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df6fbc0-7a31-4f54-f726-08db890d2348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	znNp7ChofRymRb5YJcf4W9aIpuO2E8HedNBgkfhd0QtUaQ5hAHE4WvZdqetLLPs9bIVB4Zc9VEpfFEQm0zAE6zkT0H+sp2m19Cy+7cH8ixtiV5+qBTEfoMRiVDA7N2el3GskQy7kzVlbeIRRjZ/pR1Cl8ADgeqMBa5ykTXOPbVS96MRN0jxbsDWZzv+j3PRErUYa3JrkkmE+11WAbpPcyZRIfba0MrcTpx3ewIFXFpiSFW9aNyhD6k+hRu5GMYogOjWI+u/FLawYrWOyMenVY8tg+s6oLAanUZnPfB7WtVQAjFizSVxOTIxYPiSTxshvQIKoGKRD5I4RNN23nDOc7jmXh8P9ZGwhWZOFXs7j0KDv0h0LV3vPTT/247X4hBm6SP88Zs6eCvg17b9HAAeP6nt1hrcSfMSHxMmc668z9xTggrYGguBPQrp0ZTFK+u+tO8qlkhXx+y4vdFPuSf2HxhcS1Qs6UwKQK0v1upKR2AbJKstXLja5wz04R6O9P2TAwvsyRBKxMEutOKbhlKu2L+eZjiIB2DsawCrC/5cvmq3TpzU1vCZt9H72lULv0ZLPPNx2x0h2ywp++HyBIMhBp0EuccoHk5PxPv5k1oYOmwB5UfKlABUhIfGXK2W5Je2KXVucOahWiMI4Er4BeUzi5sAOrmXcayIqlDbSid9+AwtRAOl8DZWGdgD6HJAKnWLjbFLT4QD8lvE/cqbEN9znnktCOgV9BVwWPfxVWc0tS1E=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(7636003)(82740400003)(4326008)(478600001)(5660300002)(8676002)(8936002)(356005)(6666004)(47076005)(70206006)(2616005)(70586007)(41300700001)(6916009)(316002)(336012)(16526019)(83380400001)(36860700001)(186003)(54906003)(26005)(426003)(86362001)(2906002)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 10:36:12.1059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df6fbc0-7a31-4f54-f726-08db890d2348
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6381
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Gioele Barabucci <gioele@svario.it> writes:

> Signed-off-by: Gioele Barabucci <gioele@svario.it>
> ---
>  tc/tc_util.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/tc/tc_util.c b/tc/tc_util.c
> index ed9efa70..e6235291 100644
> --- a/tc/tc_util.c
> +++ b/tc/tc_util.c
> @@ -28,7 +28,8 @@
>  
>  static struct db_names *cls_names;
>  
> -#define NAMES_DB "/etc/iproute2/tc_cls"
> +#define NAMES_DB_USR "/usr/lib/iproute2/tc_cls"
> +#define NAMES_DB_ETC "/etc/iproute2/tc_cls"

Is there a reason that these don't use CONF_USR_DIR and CONF_ETC_DIR?
I thought maybe the caller uses those and this is just a hardcoded
fallback, but that's not the case.

>  
>  int cls_names_init(char *path)
>  {
> @@ -38,11 +39,18 @@ int cls_names_init(char *path)
>  	if (!cls_names)
>  		return -1;
>  
> -	ret = db_names_load(cls_names, path ?: NAMES_DB);
> -	if (ret == -ENOENT && path) {
> -		fprintf(stderr, "Can't open class names file: %s\n", path);
> -		return -1;
> +	if (path) {
> +		ret = db_names_load(cls_names, path);
> +		if (ret == -ENOENT) {
> +			fprintf(stderr, "Can't open class names file: %s\n", path);
> +			return -1;

The caller always calls cls_uninit(), even for failures, so this
technically does not leak. Not great, but let's keep it as is,
fixing this is clearly out of scope.

> +		}
>  	}
> +
> +	ret = db_names_load(cls_names, NAMES_DB_ETC);
> +	if (ret == -ENOENT)
> +		ret = db_names_load(cls_names, NAMES_DB_USR);
> +
>  	if (ret) {
>  		db_names_free(cls_names);
>  		cls_names = NULL;

Otherwise looking good. In fact IMHO clearer than the old code.

