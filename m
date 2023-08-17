Return-Path: <netdev+bounces-28349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B626877F1D6
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 10:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0EB61C212C5
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 08:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C3DDF54;
	Thu, 17 Aug 2023 08:09:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33879DDC1
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 08:09:44 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931F8210D
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 01:09:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knIdqusugVrRqpGkFXvzS/qpK8Y9noVgy/Tw3qD5M7AajXaVZWLeyT4pPmddyveZjE87t725IbIsyWjkVUWoLGCRouIoNu9S0+rZQ68I2GN9POpmCAeiW/pPXJhhD9I1pPuEmx31oH6m+LoGUhI5gwZk5FsF/j/Q8pAz66w1f7OYYQsQAm9GL4Pd3ZcEsYyBBiATlPv/lXfnVnFcQECLolQuaFopAkGDM8RDaAl51APLGgc5C6D+U2IqzMoIbQ5jxI4ETFLWmUuoS13Kfg9etpi8MipE1gACoEUTRgZOn4pjtinjTxrlgt+5d4hBRO4aSg/cQ89S9cBdqqPlNZXbng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpoQmV4gEI2ACI193+DpbHZHlWf59GtJf1b8Eai+ADs=;
 b=nBHfl5C88tWKZfuk6oYry1nOa2bQDNKYOQMH8yVWcZ/gkFU1llxq7nmGzxtSZc6cUw3V9seFSKcTYGVSErPjXFpc44OVd/gVa1xDJ0Rymh9TLHo1wPaxOT9QHXmkildsY/UvsD2m8HcJUAu418IZZMExYO2JfuJ9GShoDAFOEMJMmITifYodm26lowU4I4/Mf/9vZ5cIk+o8aaqUbgjYOMSJZhaMOiL/27OqTRS+iCstrfxpULJaM8m5YDzUKJLD2E6xzqet9t0Tb5h0zSIQS1o7Nlgg3+H9nXVKAOFgAuFkLAYrnRezWkUdqdMTdAzlfb1d0j4VWERBFWEgBH1aNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpoQmV4gEI2ACI193+DpbHZHlWf59GtJf1b8Eai+ADs=;
 b=FGHMghB3/cajANDvM07LGNTLpFs4BLkwSOY4ewIeaPD4w/RKzCkebZ0L3FnMBl/VPRJfV1yrbSvWglRTn8PuuzZj5y5vry6L2Wgkmj6bYY+5JurLvEtC5IkKkJps3cqc1c38UP833gg1j5LBqvAO74Ah1Jk5W4D7mG+A5WngqWM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by SA1PR12MB6702.namprd12.prod.outlook.com (2603:10b6:806:252::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 08:09:41 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::67db:f6a5:6ffe:8fc3]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::67db:f6a5:6ffe:8fc3%5]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 08:09:40 +0000
Message-ID: <b7dd860e-12f9-551d-a712-16dc75213acc@amd.com>
Date: Thu, 17 Aug 2023 13:39:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH net-next 2/3] amd-xgbe: Return proper error code for
 get_phy_device()
To: Ruan Jinjie <ruanjinjie@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 yisen.zhuang@huawei.com, salil.mehta@huawei.com,
 iyappan@os.amperecomputing.com, keyur@os.amperecomputing.com,
 quan@os.amperecomputing.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, yankejian@huawei.com, netdev@vger.kernel.org,
 "Rangoju, Raju" <Raju.Rangoju@amd.com>
References: <20230817074000.355564-1-ruanjinjie@huawei.com>
 <20230817074000.355564-3-ruanjinjie@huawei.com>
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <20230817074000.355564-3-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0136.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::21) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|SA1PR12MB6702:EE_
X-MS-Office365-Filtering-Correlation-Id: 21c07023-0d5f-44ce-458e-08db9ef94e85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D7CNPrLI1q3lWxXYXQggxVHsn1Ne3mqVAg26G7xEf4xALSLnj/iXvZsflMSTQCfa95NIgW1aGvmT/qfnwbXiyv5p1oqgi38muXAKRjaSbnbgNxfWwv+3k3el7E5sboYvFyDMSwsYLeUlsdGaEeruhw7gwymlvFEG3foY79pFbGgSI9ptGSXM+tJJgiZHuuaP0UYnlXLzo9W49Wyw5RqJEKHLHjXAjkOzq5dWNMMV4LndxMfKArGZNkWGT1SvNgTMJoqnmKlXKcm6uP3HcWE6PhJq6Kp+fFTRH2sTqbIQ6pkYBljlJ6Y6Z1V0fRvRjLxUqanoW+B+xrl9/QMRyr/heW8KQ8SVitc9BnziPHEuxg40f11vd7HDCPcRjPcOSR+bo1eOykoQ3JJTD1JqfMPZ/V270N2TOA9jQUjAUBaWodDDd4Za0Neoc9alNF9FTZODxvlY3iStM3o4f7hmbtWWhnNaX+ly4+CwMJcPthdAQzRrfaQedgGzJzLdO5/bZmReF/r2nKBqF6KeExIMhUmHCriycONcqXtq4ON/97XUrWFLF1ZwPBGpTh+bpgFW1dorEpmPbw5JBtiIpIz0/ceDqcnMCXNwLFH7KP5yj68isx34+qHWNV6sAaDxSct/q10QKjESQbJ2iA/c5lXGQTDib9g5tZHztpJ23IeXd40aLWk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(366004)(396003)(1800799009)(451199024)(186009)(316002)(6636002)(66476007)(921005)(110136005)(66946007)(66556008)(31686004)(5660300002)(41300700001)(38100700002)(8936002)(8676002)(26005)(2906002)(31696002)(83380400001)(478600001)(7416002)(86362001)(53546011)(6512007)(36756003)(6506007)(6666004)(6486002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmR0MzM5Zmh3dVJLR05mOFZXWnNUaFRjUG5iV3JiYVUvbGl1N2FIS2MvZWRo?=
 =?utf-8?B?MWZ2cE9zQzBCUzRla3c1VmlaMlZpVmE2UGRwRE1nb0dlTVpKR3NpUFhPaDVI?=
 =?utf-8?B?TjhGbmg2bDhacXpsRGJBR3BJeitrbGwyYWxxVDZPQVpBOVEwbFN1eDZic2tL?=
 =?utf-8?B?NlFrRmRSOTBtTFNkNGJwdERhU2lXK1lnNUNWcVFCUFl1MkpXbUlLdWZ2WjVV?=
 =?utf-8?B?Sy9XWEVaOUlOYmpNbXVDVUlkRE5HSFBTT1ZITnU1WDJjKzB3d2xyT1ByQnE3?=
 =?utf-8?B?RE9xUmt2ZUJUM2RkTDdYS1cydCtNOVlESzhuTExGaElORVRaSjkxSW1jVFY1?=
 =?utf-8?B?d2NMbWgwMWpsRVJjTVIxZjhnNFIvNEovT3oyTW5BOHNxb2pDWUp2NUJqV2Zz?=
 =?utf-8?B?dFZPYTJhWFgvVVRwaEE4SCtFaTFSbWRvMzhjRThzYmVUNlp4WkxUdGFxNDFD?=
 =?utf-8?B?NTV2dmVNU2hyK3J5V0xGbDlYQ3NVNi91K2VmTmlQTjlNVWY2SW5YaEdXaVdO?=
 =?utf-8?B?TENjY0k3SHU0OGM3dlBLODZHc1VibkFRN1A3bXJBaE5qN0VSQTR5VDh1ek1i?=
 =?utf-8?B?UWxBdkt3b1NvVUltSFlrRmY1d1pGN08ydDh4U21tdVNCK0ZIU014MXpYb0hm?=
 =?utf-8?B?M1VpMjNMcE4yb2F0UEsvRlBOYjRjbnVkdTRzVGZZRkhkL1ByMGZjdHVGeEVB?=
 =?utf-8?B?N2Y4VUJwQ0dYbVh2aG93YytlcndKNy9TcXFnMUF3cWhwTmZuZ2h5UFhmYStE?=
 =?utf-8?B?S0lJUVVFQjg1SDNPbTBkSnpBK3pXWFJCdm91MGY0RkZSVWxGSWlJVGhFM1lF?=
 =?utf-8?B?OUE5c3BOeENnZUM4RndQNUt1dGhFUG1UWS9CR0U4RjkzK3dHM3JaOHJBZmtP?=
 =?utf-8?B?ZGlTSlUza2RlRUVsSzJCODFsZUhULzBqOHdWYml4TnpLaUtwc0UyblEvbDVq?=
 =?utf-8?B?TE9odzUrREVZQVhKYzJqb1dZMWM3SjBBbFphSnpWS2VxYUVBaTBCT0MwVjFk?=
 =?utf-8?B?cnR3U21TRmQ2cVEvN3QyMGZ2dHoxZHZEVWV6VG10dytRQTlXWGFWU1BqUDNN?=
 =?utf-8?B?MFBvTlRyVVp0THdDTWp4aU9VdkJCOVQ3OTNHV1J6YTkzd09WUmFsMW9hU2RK?=
 =?utf-8?B?SjFSY2VBVmhaUkhEVXZyOFNOZzdmWDU3cFJ4YzhtOFQ4d2xzYTdVdGVzZ2Y3?=
 =?utf-8?B?aVlKenhFOUlBaWR2aURzc2ltZmx1aXdCU0dPMzZ3MGltT1RwdVVRR0xsYXRI?=
 =?utf-8?B?TzJpc0tsSU5aa3ZndVhmaTJxT2VVaFFNVDdxdFFHc1hiSVd0U3NGZU5uMGhZ?=
 =?utf-8?B?UzkzWGRFV0t5aVNiR1Q0ekMwbU9GazNIeFdSNHhWRlRDZVZaQ3RTei92R1Ns?=
 =?utf-8?B?MGhXbE1wL3NDQ3NOekxDOGpPRmNNOXdaSUNoa2FTL1lIUVphQzE4NXhjSjAr?=
 =?utf-8?B?N05JeERrNVBhcTlDL3lrT2I2dlZyRU4xWmgzQStrTGdUdC9UdzJLcFloWEZ0?=
 =?utf-8?B?aktGamJ5UUhieEhPTEgvRXNTQ1loVFphNXl5cUdjT0pFaGd5eGJhR25KUTVT?=
 =?utf-8?B?cEEyTHY3ZDE0RDE3dzh5aUk2aVdTOG5pMjhKUzBFTHNiOVVucWwyTDFMQStW?=
 =?utf-8?B?a3lVMzhNdi93V1NzK3U2WUhGc3pYN1Y3WnNsK0JSZFl6VUFCY0hYV054bU5S?=
 =?utf-8?B?SGw3UnBXNmlPTVdzem9aQkVoNG1RbUtqSlg4OXdFbVFqYlNIWXZDRWh2V0Q5?=
 =?utf-8?B?SUhRblJhb1JTeVFxQnl0UjRFQ0xybENsSXUveE1GVEsxeiswZHU4SVBMRnlm?=
 =?utf-8?B?c1F2K0FOL012aHF1bklsV2QxaUdES1J6NFdmWFFJaEdSOHlSTUJzRXkzeDdB?=
 =?utf-8?B?bEUwVVFpU3NwSEFJREZjVE5WMFNuV1FMNTl6OEZnOVN6bVQ3b0lRTXVhOUdU?=
 =?utf-8?B?bTBzZW5hT0R3WHdKbUJ4YmM5Q0NKVFlPc2wyV1BPYkhzMFJWM2IyMWFscnY2?=
 =?utf-8?B?YkgrTk5MYkJBZDRzbC9PRUY5SFhteStLTjJnSkxVYVR4TWZVNTdPcjZKRE5w?=
 =?utf-8?B?Zm1OanhhRVd6Q1JJZkZaMk8yaEQ1L0RVcjZYeWs4aHRiSVRSOG81cnFzM3FZ?=
 =?utf-8?Q?5ww+lR90HLT9hEmocA7vfpbOi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c07023-0d5f-44ce-458e-08db9ef94e85
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 08:09:40.8274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t4oe7c0khPDy7ypLIU9S+LnxzI8J5F8KyAt64L3D6UwQJCDaT8roubdyxwexJkJ3Guk89+g8vVC03Wv2q2Cy4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6702
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/17/2023 1:09 PM, Ruan Jinjie wrote:
> get_phy_device() returns -EIO on bus access error and -ENOMEM
> on kzalloc failure in addition to -ENODEV, just return -ENODEV is not
> sensible, use PTR_ERR(phydev) to fix the issue.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Looks good to me.

Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

Thanks,
Shyam

> ---
>  drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
> index 6a716337f48b..2f0a014ffc72 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
> @@ -1090,7 +1090,7 @@ static int xgbe_phy_find_phy_device(struct xgbe_prv_data *pdata)
>  				(phy_data->phydev_mode == XGBE_MDIO_MODE_CL45));
>  	if (IS_ERR(phydev)) {
>  		netdev_err(pdata->netdev, "get_phy_device failed\n");
> -		return -ENODEV;
> +		return PTR_ERR(phydev);
>  	}
>  	netif_dbg(pdata, drv, pdata->netdev, "external PHY id is %#010x\n",
>  		  phydev->phy_id);
> 

