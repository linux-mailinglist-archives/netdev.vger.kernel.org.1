Return-Path: <netdev+bounces-18884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B905758F66
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 09:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E15E1C20C4C
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 07:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28447C8EF;
	Wed, 19 Jul 2023 07:46:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C02BD2E0
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 07:46:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061e.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::61e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11071997
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 00:46:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+P4jW9jBsZeD4N11g8UKBEaBg2/d6mWYk6QcTSeRwk4fhOtnoVkry+p3rGl1owN2WjPZVXChVCMHsVr3PwS8X7SHRZDri8W36mcHY63fanWexIhdC9hRlnAD6ka/VWstRR0dxMbfBse8/Q87FEIzjJKl45IfGfl2yAHBGQtFenxG1lhQnp0/4N01dMlnY5n7LWE5udOxO6BKhGFKR+Qs6gTNpmPmOvhiJXSeKuwSXWK46i8zxh/j9oYCaQpZ2LFi6cqUX6Fu/zzzr26GLTj8eIBKhtsZan8NijXSyOFeQIYxoUcHITkVk/ztSX6VpiltxBRXz+Tud8mfo1tq3G6sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfVkX4r+/SKsl0g/5n0qy5MxWz5RDzph+Pz/ifF5EN0=;
 b=A6Gpa4Ql0Q5lL6oVOzNczqXML/awdLMxnHrxg2jVvMQiGnR8BI1fuGundgK6I8yeRSYqKQQ2AvNCy1VmtyX/S5LOJwjOu9Rq3t4vE9rlqhL9DeEcEhxv23Bch6nlJTfbyh83XU5O4YqAFk2aq6Y/H5o0r1oNVM2vM4tsqCQOkbgUCAXQAjswNL/zJLraK+4yPoAa8X/p8OGNWNpa9BbtXWzdMJIXVbORunV/49lrJWxaSdk13IrNdHiJ7SpW9bsdcdwGKHRh8QTVBcrQU8BQS4jZAEU2SKO8WkXLD+X1TlbIn3xnltyPWJ1voH5iERVyd+y6HsjTOHTqgIs3l3AiqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfVkX4r+/SKsl0g/5n0qy5MxWz5RDzph+Pz/ifF5EN0=;
 b=W0ULaCCNioiEs8Gws1ROzeat4NJ0fIw2XHjKqJE3kcUc7xwGVSQ8rE0NTXok4UfsPibjQhDGDyAlBG4Cvy6BoTgQQG+Jv9TkFv9lEodGVUErSaKWcIp6Sr5BxcFmGYX9FFgYAZmruLbGbyFBAHjw0G4rXS/EcTQM0mdBjNW7GQnhRCo82Rnl3PYCS45fDUWBaiJNefNxt88ehqBfzOS4ba8SBLm1rgjkLZSyfpunJ08XXXAOMDOD1H+xINBN86Q2jPGSLMV7QVyyBPtrIMUdgsfZ5zgYURIMQ1y5pYr7sEnhh94Ca7GcFUJaKZPdaXGTiVnOZBm40dl5MJFYzBmFPw==
Received: from DM6PR12CA0013.namprd12.prod.outlook.com (2603:10b6:5:1c0::26)
 by PH7PR12MB7892.namprd12.prod.outlook.com (2603:10b6:510:27e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Wed, 19 Jul
 2023 07:46:23 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::c2) by DM6PR12CA0013.outlook.office365.com
 (2603:10b6:5:1c0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23 via Frontend
 Transport; Wed, 19 Jul 2023 07:46:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 07:46:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 19 Jul 2023
 00:46:12 -0700
Received: from [10.223.1.249] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 19 Jul
 2023 00:46:10 -0700
Message-ID: <9bdb9b9d-140a-7a28-f0de-2e64e873c068@nvidia.com>
Date: Wed, 19 Jul 2023 10:46:09 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: EEH recovery failing on mlx5 card
Content-Language: en-US
To: Ganesh G R <ganeshgr@linux.ibm.com>, Leon Romanovsky <leon@kernel.org>
CC: <saeedm@nvidia.com>, <netdev@vger.kernel.org>, <oohall@gmail.com>, "Mahesh
 Salgaonkar" <mahesh@linux.ibm.com>
References: <c13fa245-64ed-f87c-fd1e-e618fe017359@linux.ibm.com>
 <20230717131006.GA346905@unreal>
 <5c8e2eba-88c9-5913-ad18-db272484adf5@nvidia.com>
 <b7ad516f-da16-2ba0-98e3-4f16f47e0fc8@linux.ibm.com>
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <b7ad516f-da16-2ba0-98e3-4f16f47e0fc8@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT011:EE_|PH7PR12MB7892:EE_
X-MS-Office365-Filtering-Correlation-Id: e1087acd-ad21-437b-0819-08db882c3f7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D1/arPqMjvAT2Hz1tlt08wjPXCTEYx3l48lp/+HncIwLi4/RFPuAQdAORV6HLvU8ntLeAjfs79tH4rPcBq7p9P0XuRSl+a+0/IcrB6kuowjIbJ+z+WspAwwxE4Mg24lOBIx5VBNTMRdPZkOVBL5xXXw/CdaVB/sABEuaqgffUtElS9AsirVdSQMy1r9DR8xURbVxCYmz2U3S4da7AUoz2Cl/alqqnMTCPaB5n4cBdUtBSJXiy2n3UZBo3lpNRiGGplSR6FaBXpD5JyYgbBY7PbGXCRsHj2p2SFuGIEptIzVLDAw6RvZoKAC1uiVI/Omvxmc+d8H4z0A7ExCT3ghQN1fXC7V8O5uIb5l/dJujq/sKmpVHam5ePBeGh1s1heiaLxelsoYyTsV/Ns6OQBtqTzyKIs5DPCpjMwF5hqieLwtF78T86jBR7u+MG/p5kRS2OcpwLz4yhVAzbjaPwuBYIo3MI7seY/YCyMaO6LnTeJIJEz6esjCzwFRsfSzsWbEF93aMORHPj/d/GL52mSx/CQZrBVbMVMAEvvz4ByUQy6wwWnpXuVo1vbNY20Bj5awRXfime/6XGh0IyNJfsdkqvdOan+3DMkUbbX4E4rEebvve69F55q/KCGzHEO2YHFz5QxM8g08Ain4qEL/QxRWDQVUdq9nkU+2QnJDb6tUBxKEXZEVRvNxvO66X5y0w02EY8kQHmx21WaF8q211257BJjWLcRRVs/gg1cnajfeWa32NPavAKDVZpgFqDAQ9O0GAXlOaIB/50PuFY+YhhhnYXQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(53546011)(40480700001)(31696002)(82740400003)(83380400001)(16526019)(40460700003)(186003)(336012)(26005)(110136005)(478600001)(54906003)(8676002)(41300700001)(2906002)(8936002)(70206006)(70586007)(36860700001)(316002)(4326008)(16576012)(5660300002)(36756003)(426003)(2616005)(47076005)(7636003)(86362001)(356005)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 07:46:22.6526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1087acd-ad21-437b-0819-08db882c3f7c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7892
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/18/2023 9:47 PM, Ganesh G R wrote:
> 
> On 7/17/23 9:48 PM, Moshe Shemesh wrote:
> 
>> On 7/17/2023 4:10 PM, Leon Romanovsky wrote:
>>> + Moshe
>>> On Mon, Jul 17, 2023 at 12:48:37PM +0530, Ganesh G R wrote:
>>>> Hi,
>>>> mlx5 cards are failing to recover from PCI errors, Upon investigation we found that the
>>>> driver is trying to do MMIO in the middle of EEH error handling.
>>>> The following fix in mlx5_pci_err_detected() is fixing the issue, Do you think its the right fix?
>>>> @@ -1847,6 +1847,7 @@ static pci_ers_result_t mlx5_pci_err_detected(struct pci_dev *pdev,
>>>>           mlx5_unload_one(dev, true);
>>>>           mlx5_drain_health_wq(dev);
>>>>           mlx5_pci_disable_device(dev);
>>>> +       cancel_delayed_work_sync(&clock->timer.overflow_work);
>>>>           res = state == pci_channel_io_perm_failure ?
>>>>                   PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_NEED_RESET;
>> Hi Ganesh,
>> Thanks for pointing to this issue and its solution!
>> I would rather fix it in the work itself.
>> Please test this fix instead :
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>> b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>> index 973babfaff25..2ad0bcc0f1b1 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>> @@ -227,10 +227,15 @@ static void mlx5_timestamp_overflow(struct
>> work_struct *work)
>>          clock = container_of(timer, struct mlx5_clock, timer);
>>          mdev = container_of(clock, struct mlx5_core_dev, clock);
>> +       if (mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR)
>> +              goto out;
>> +
>>          write_seqlock_irqsave(&clock->lock, flags);
>>          timecounter_read(&timer->tc);
>>          mlx5_update_clock_info_page(mdev);
>>          write_sequnlock_irqrestore(&clock->lock, flags);
>> +
>> +out:
>>          schedule_delayed_work(&timer->overflow_work,
>> timer->overflow_period);
>>   }
> Thanks Moshe, The fix looks clean and It worked.
> 

Great, thank you !


