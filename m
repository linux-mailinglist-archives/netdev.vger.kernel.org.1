Return-Path: <netdev-owner@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CDF740D1A
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 11:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbjF1Ji0 (ORCPT <rfc822;lists+netdev@lfdr.de>);
        Wed, 28 Jun 2023 05:38:26 -0400
Received: from mail-bn8nam12on2084.outbound.protection.outlook.com ([40.107.237.84]:60479
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233143AbjF1JWx (ORCPT <rfc822;netdev@vger.kernel.org>);
        Wed, 28 Jun 2023 05:22:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3FaAYzy782llQwYMegmEhKtheVWHJ671XPi9hhf2PsKpccPHAOReac1F4Hnk4t9mpy0zucmOmQj7BU7MzfHNCGKVnFffrmavzpNmDhgMiX8YdvdYE1ecvJaJZCWvM97nGZTVegVxIIQ8AgzrReY0/rqkF7LnG6c4+vQ3jWYGYji3WLJAuEVosxjgdKQMoePLADZTUZ4WYu5N6Ihn/qWLMHa3QldQRIwt7aSibOghqbd39d8q3Of2TJ6z/ls9GGSP8fUCzA4/o6bwR/lBrJ/WXi8g/fihH6C75nBK5m3FVJofYT9MgMmN6hBsO3Fi8ieGOBqYiMuEbQqMHIeaF8LPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvY/i04K6R7R4TaBdmXEGZN6rMcPGO9zjBtfnJDAlng=;
 b=cq5Og3iL8XhfjTfDpINxxv5KKChImCHIwKZLq2NXhQ0eaHBeuTZnLUq33UhR0eMXD1kRlSXWCyKp+Sm41BLXY5rNWSFqHANVZQ8hiwvuM+ZclpknYbCveqaqOcG8gWPTNuofDppuZRN1AmKU6CBCe/SNjd+yNl6laVtmlDoMM99gmNcVLjNcDs/fAZ6kVWmPXks4eXOLt4hK2SFzVCCAjqZ5t9EWDuSBeYXMvtcklvXo+wPI5aTcB9CtIHo8FSsBHgfSXucIVW++pGda07Zpff3wgCSya1w14KLK3mxPTKpnAg/e85Z5tR1kSiRQMZet8x5BIAOMBld1wU0Udnk8rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvY/i04K6R7R4TaBdmXEGZN6rMcPGO9zjBtfnJDAlng=;
 b=Y1zCty6pO0ePfjFVVA/c7op1Zr0BcuVLTuV9535CYXOKOSrza+aVGNOlC1JPzzK4C19Goxu2T3MAXHvwQmfO17OGLQTQa0Ee1dJdeqmhShgUYCKx1wLFJ+kKMhr6uzAid0C1wX9jlbh6xumbWArOM3N4fuqvle10qgLRq/s5TK7G4Ixn2gojMbpuxZ30sZcbuaaT/B+/anaHb+J6MQ/a12aXhJvpoW+nBJuVRoGW3SN9M8XMAQ07cGA9F4O8KgfATnl4WHRtsqAZGtUWGDnukDOKwHUXXBvSYd/ZwXZi2lomeWdC6RmvhtFxsoWg76QXtMho6bcDK5cuU8yLWwcdCQ==
Received: from MW4PR03CA0174.namprd03.prod.outlook.com (2603:10b6:303:8d::29)
 by CH0PR12MB8506.namprd12.prod.outlook.com (2603:10b6:610:18a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 09:22:47 +0000
Received: from CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::88) by MW4PR03CA0174.outlook.office365.com
 (2603:10b6:303:8d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.34 via Frontend
 Transport; Wed, 28 Jun 2023 09:22:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT085.mail.protection.outlook.com (10.13.174.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.47 via Frontend Transport; Wed, 28 Jun 2023 09:22:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 28 Jun 2023
 02:22:32 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 28 Jun
 2023 02:22:30 -0700
References: <20230628005410.1524682-1-shaozhengchao@huawei.com>
User-agent: mu4e 1.6.6; emacs 28.2
From:   Petr Machata <petrm@nvidia.com>
To:     Zhengchao Shao <shaozhengchao@huawei.com>
CC:     <netdev@vger.kernel.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <idosch@nvidia.com>, <petrm@nvidia.com>, <jiri@resnulli.us>,
        <vadimp@nvidia.com>, <yuehaibing@huawei.com>
Subject: Re: [PATCH net] mlxsw: minimal: fix potential memory leak in
 mlxsw_m_linecards_init
Date:   Wed, 28 Jun 2023 11:20:22 +0200
In-Reply-To: <20230628005410.1524682-1-shaozhengchao@huawei.com>
Message-ID: <87bkh0eyb0.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT085:EE_|CH0PR12MB8506:EE_
X-MS-Office365-Filtering-Correlation-Id: c5bfc4de-f433-4026-a09a-08db77b93bd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0/wlJGsTpkT2fVyOSHL/l64YNtX2VKKPwXg2le5XIBoIbCtWfpaKPwoDScfuapAoCKIFlSQF7bnKZjMxCpGQjRIK+5tatJZthIgelFV0Svt8o4BIrlK2NjKIPqedhO9dqkaOCU3PeuxYkd5BLz+/oQ3zGimHOsabPE7p3lWVo6XwYAx1fjoTwU29ibljUzuQz5kJF9t8ereZrH9FeNiPiPw1rSqdblgt6Pv7dRX6jhlBaPMuLaewFDzIm/KgxL2sqL5KXH3h1M3UaDadjNPMT4EJsciqI55sTzu/YUOu5WwSjq8EI/pt15l4+OOlUDTI2pNq35lZZjKIn5G8E97vI7ATElus8RkVlgPtnK+/566iihDhesdfvzNVcKpFgqoIx8XKozrGHQye58itmaorL6qat51X+Ggc/11O7LA3iIe6kdUsKpGYItT4/vo431C49gcVEBxbxlQpECWUyrpWc9063WRV3QVKlTr47rq4AuhHrZ7iGnqFBp5bNYU3h0eecLUH50EP8kwbNuMjDWm9WGL4jOXmgMjEYv4tjErAdBX5jBX7U3pU8Xja7oshFfNGqnuNSWJsdYict2enTvSEj7eDDkmK0qqpa23GaR0nl2Dxt/UZ76Xq6KuLBIlQoTp9aE/uuJaqV6+8veM/RI7z/i3yAdcebJMMtsn2DutL7kqC1kdlURVaniCUzt9J89ufdusP1MCcXb+sCnrKSVAN98Ms67YNsMNY4fSeDIwfcCMscoU90xNYrjE3qX7iAgJE
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(186003)(2906002)(5660300002)(26005)(7636003)(6666004)(82740400003)(36756003)(336012)(6916009)(82310400005)(316002)(54906003)(8676002)(86362001)(4326008)(478600001)(47076005)(2616005)(426003)(41300700001)(70206006)(70586007)(40460700003)(8936002)(36860700001)(356005)(16526019)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 09:22:45.7743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5bfc4de-f433-4026-a09a-08db77b93bd1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8506
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org


Zhengchao Shao <shaozhengchao@huawei.com> writes:

> when allocating mlxsw_m->line_cards[] failed in mlxsw_m_linecards_init,
> the memory pointed by mlxsw_m->line_cards is not released, which will
> cause memory leak. Memory release processing is added to the incorrect
> path.

Yeah, it's only releasing the memory on cleanup. This function itself
just never releases the array at all.

> Fixes: 01328e23a476 ("mlxsw: minimal: Extend module to port mapping with slot index")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

> ---
>  drivers/net/ethernet/mellanox/mlxsw/minimal.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/minimal.c b/drivers/net/ethernet/mellanox/mlxsw/minimal.c
> index 6b56eadd736e..6b98c3287b49 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/minimal.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/minimal.c
> @@ -417,6 +417,7 @@ static int mlxsw_m_linecards_init(struct mlxsw_m *mlxsw_m)
>  err_kmalloc_array:
>  	for (i--; i >= 0; i--)
>  		kfree(mlxsw_m->line_cards[i]);
> +	kfree(mlxsw_m->line_cards);
>  err_kcalloc:
>  	kfree(mlxsw_m->ports);
>  	return err;

