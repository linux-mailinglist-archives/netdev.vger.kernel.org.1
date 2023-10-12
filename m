Return-Path: <netdev+bounces-40423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B977C74C9
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 19:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5C79282C4C
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 17:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11E83588A;
	Thu, 12 Oct 2023 17:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="33YFYnxs"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88CF266BE
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 17:30:12 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B40B10B
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 10:30:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itb0EAmBZ8DkBcvt8DpAuuCqqfSwFKaSS8uJ1SuJJQWqJPxpnGK7YgFbMGDSmhKO7oM70HHMuXZgcVWQu/RzWFJsZPXRM2KcAXdyO9m8zIG8wCHedbcn0PoIR/X1RhEDU8SC5huxny3VQ2lrgajB6516fBYM9BaclHgE1fYRsV9PQpkamgwUNjgHvfndMi12g1nt3DeXoG1mPhV9G5Vb/viSKlZehKjIcVaqBghFYqg17Gihl/rflb77XciW8JfJZUUVz1nxqSo/A20QximnyPoenNomvGxGB/hS45gvsan19XJ8egZxSQoYnt1RLcDDhkLd68/iNrkfLyryI41gUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/irzlsg6kVYVBqiTR4R8WuwZ2vjXD3hC5lcvFVj0vA=;
 b=ogDQ3uqibi4OhQSZ8XyOzsVbbjFAjxEGlcbkgAN9d+Vy/MFq+K9mvzHFaPZF5JKAt7gdisqxppLzDFvFncSA8oRwrzxOPave+o5/r3o5S4Ep7YaQ735k44r0Hyl4e/rfd8lPc8ctfM8d36qbUecO2Pp4xMWOtFoFahMB3v8SGrdgcqroP7cB4JbE+sG6keYZiYOwvT2gRV4UbMBsWJE2pHZrHaK8TelEpnqOue9ZkvGJPQvf15nvZ9ksjKIUxptsECWmsbcXrEFVZDLB39d6dq0D6raUO9ru91q53X1QHFGpah2Vl0Kmsv+PEjTOmocWGFily6WGwp2VHr4kG6cVPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/irzlsg6kVYVBqiTR4R8WuwZ2vjXD3hC5lcvFVj0vA=;
 b=33YFYnxs7UvkXzCkv28FGNGj9WubGDR/jUc7Hg+em//TcwO7ipPGiT6kKGOi7DtX3MIVSQVp8QQw4hM2+sStXKZdZZ0xsqYI+/g4REqYgncnT+03Wu/0iuGxgsoYIY8nKJF5O0SLOB1QS8e4bumFkXF1NtGfPo8xLLUoWeOPl7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by SA1PR12MB9245.namprd12.prod.outlook.com (2603:10b6:806:3a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Thu, 12 Oct
 2023 17:30:08 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::69d5:951c:32bf:8dfb]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::69d5:951c:32bf:8dfb%4]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 17:30:08 +0000
Message-ID: <8804726a-cc2d-fcac-093b-8cd34209d662@amd.com>
Date: Thu, 12 Oct 2023 22:59:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH net] amd-xgbe: read STAT1 register twice to get correct
 value
Content-Language: en-US
To: kuba@kernel.org, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 Shyam-sundar.S-k@amd.com
References: <20230914041944.450751-1-Raju.Rangoju@amd.com>
From: Raju Rangoju <Raju.Rangoju@amd.com>
In-Reply-To: <20230914041944.450751-1-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0152.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::22) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|SA1PR12MB9245:EE_
X-MS-Office365-Filtering-Correlation-Id: 25e615da-cdc7-493a-4862-08dbcb48e141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8eDhosEH3Q4DS94xykvkIdh+5YG9QQIbJy2YUwovW/yHMrsuldvyFRZ/NN/THcidnqlVTDg9u/jL1fu7ZfsGarFbVk2OnUU18St+xe5mXb1F8ruZbC5ilqWdiUzuZ0fXd1Ym4v/BSG1Px/IdWm7klGl92ARvf1RbNsMwPe8ofNO8UtPuPzJ4Ss3pm77uPCzOTzgtt8E5vukdkOnXwa0XIef5+bcFBbank800KwsfIXa6MhA4L5IsAZROQ6rCCSOd653pUuqzGs1Fw089NsOgMegWkQZuyKfUPQhYLdsPdelP23ZDWyevoyrDSU2u956sxM7ineqNx6wqCUOTCMCJseF/1kjWyzU0HxCmyBiDx532PoH8xtMrdWoulpWYEejkWV2CAlaALz0MZZyA9BY8TMkwaANu5KsRWyTDw7EqzIn5HQZxPgcSBEyh0mbieHEFW1pgWpdtZ5a+6ZBHZEspdMDB76YNFABfqiCKoBwKsEUhDfrOI2m9OUrWpYSR+Yle21zj5aEbMfPhbdxrptufelAmhROvU1LnQH1gcclW0szQ6v5qqEZ4/A9wppbIBAYhQoWYD9kP+nAORsrqEVaWHeP51HagNRMNagQcn80HRpV8RsxxXDcck+y0UjsaU6eXvslJbItoV3xXm66hZZyJWw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(39860400002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(6486002)(478600001)(8676002)(4326008)(2616005)(5660300002)(8936002)(2906002)(53546011)(316002)(6666004)(31696002)(6506007)(66556008)(41300700001)(31686004)(66946007)(66476007)(6512007)(86362001)(26005)(36756003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SW1HcDBrejJoYmVnQW1kMjI2c0lmTFJuWkJ1NmZseG9nTGQvUDJLSmI0M1ZJ?=
 =?utf-8?B?K0prYm51L0VZeCtHNUVZMVN6RnRsQ1I0eUoxcE9GVFlDZW9FOStLeE1EdlZl?=
 =?utf-8?B?djQybTFVampIUXV5SDVSZHpiTktiZVdKWGRZeExhWm1rY0V3Rkx6WFZ6UDFR?=
 =?utf-8?B?NXI0RkZQRGhkbUJKclhaRUVJWVhLT1VwbVFTSVpnVjhYakEzQzBxdEVJd0NZ?=
 =?utf-8?B?N3NsYkFiQk5PMElzNkMxU296LzM2TXp0ZXdSb01HVFdsV1E2QUhLRDRoaTd5?=
 =?utf-8?B?VGt3REZxTG9aeUc4VnNqK1Q4OXJ2bzRyZ1FvSTBRVitueGhXYnloMlRESlIr?=
 =?utf-8?B?cDYrNy9seDlaV0liVVBMWVV0YnRuOG1VdHBoWXAyQ2ZKWnlQbXhTRkRYTzdM?=
 =?utf-8?B?T3RsWjRkSUpXK2cyWm9QZjZ0U2tsQnFySUpNK3g5OHlQNGpsaHpZSVRXczAr?=
 =?utf-8?B?V1hPK2FxSzJQNzVOa0oxK29wd1NwSnMvcDcxRlFlY0JSZ2dXQVh5Q3BseHRa?=
 =?utf-8?B?c2c4WEY2TFdKTm9Ta0doN2k4ZjdjZTVtQmNYQm1OTis5RTFaS1I3Yzc4ZHRG?=
 =?utf-8?B?bzdGY0Y5SmNsRW5rd1ZRL2lBQ291Q2tMWCtuTEdmZlRqdklyNnkxcjZJekZ5?=
 =?utf-8?B?WFNRMGZsSEhOUmpUWW42VENESUs1cTRFbTZBbjBjTS9iUHVFR0ZCdDBsMzNI?=
 =?utf-8?B?eGI1RWh6V1haRXFUb0hjMWYzTVVFRU55RTIvd0hkaml6aVowcTRiaFlhUnlw?=
 =?utf-8?B?MWVKUG9jM2tXTWdzbnV0b1hBc1FaZnpibVkwR0Z6S1g1U3dmUXdmRUtEd0Vw?=
 =?utf-8?B?Z2lsL3pFQ3ppQyt1S2hvaEpPN0pVdVpOci9NK0FaZGw5K0Z1ZUZ3TUxMTTA2?=
 =?utf-8?B?QnRnZEF0dWFtbmIxNzBpcCt0N2V6VkxvOGFZQkJEb0ExY2QzTlhuS1BkMkZl?=
 =?utf-8?B?b2xtUTIwZkNnNzJsVmVPcnF4cEVDL0NMbjdjK3dRNzEvR0xBeTRXVUJienlF?=
 =?utf-8?B?dmNvSm1HRkdkN29ZWFkxUDBzUlYvSEFzQ2lJdzIwTlIyTkltakZQbTVQT1Fz?=
 =?utf-8?B?RjZZZGZZTkpWRnc1TUlNbW9tWUtvOUZodUR6cDhtU3hFTmR5d1hPZXRwQkt2?=
 =?utf-8?B?am04VCs0bEJWNW9xbWRMYnNrdDMyTVdSUklqb3EvRUY3MTM2Z3NtK080S0xj?=
 =?utf-8?B?WHplaEZtb3pIenI2VVk5eGcwOFRVYTJ0OHBnMjA4RTBjNVNxK0I2OGgwL3BJ?=
 =?utf-8?B?akpvTG5POFpldmZodWd1T05rTUZVdUZ2bHJIMU9lNnNSS3M4VndJQVZLSWhM?=
 =?utf-8?B?dk4yaWtHVE5RRkwyTXc2SzB0c1dRbkZZUHczWnpoSXRqNG91Y0kvNU5HejFi?=
 =?utf-8?B?dG1XNE1waXlubDRqekl3NVhWN1ZFNXA0OW5GV2t4aXFRWUNsc05nVGlXcE1w?=
 =?utf-8?B?aUhMeEx4RVRxT2tPMXNZMGt6WDBHRWk3TnJ6amZhUDVJMDRZeFMxVlhyTk1N?=
 =?utf-8?B?ME5zVGlVbTFHTU11bHdnOHJLSnlZQ0xrUGtrMjZicWZrNUFiYVErL2FYc3Bu?=
 =?utf-8?B?cVA3TURWanllN1hJOGRYSUJoUzdDak93Zk9ad3NQM2JDRGhOb0UrSUc5OFYw?=
 =?utf-8?B?dUFPdzExMC9scnI0NTd1UUhWKzFaMzdiQzFBS204aGZPVTNRZFI3SE5PcGV5?=
 =?utf-8?B?K1FQajlSdEc5MVNzODBHSHRYZGh6REUrQjRoaS9xWlZOamtzSklLVERLL2sr?=
 =?utf-8?B?eHJrSmdFWWtMTCtPTWl3SGtaSlZjZ1Nxd2JKV1l4MEE3cXo3Zy9YNldmaGtm?=
 =?utf-8?B?NmJJSWl6a2taWTJVZnJXYk41SnZLNDk4TDdJaDJTMjBtQlVOTnNoTVlsRzdz?=
 =?utf-8?B?MGV2TVlobjFlYnpranNpeVBEMHZtSEh5ZTF2ZTVrdmcyc2VQa2dVL2tpZkYr?=
 =?utf-8?B?WjQ5VEtEUXpCSjR1enFPQ0VmQjlBWGVoLzBiRHQxL0xXY1U0d3U3TFBwUlpJ?=
 =?utf-8?B?TUthT3hERWFUWC9RaXVyS1FmZkh1MHFEbjhxUEZ0MUNnS3BQdnFlaGNLc09o?=
 =?utf-8?B?ckdpRXZzUndOajNhRmFWcUg1cTdQMTN6SThhOUxSUDVCQkUrWnVoVXhWVERo?=
 =?utf-8?Q?R25EleydZyJxoWLxb9mIujLB0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e615da-cdc7-493a-4862-08dbcb48e141
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 17:30:08.4268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KMGCWoRCOsM6B4965v/5H2k/mu4A3D3+mb/ktP/ZOPD1yidIYWWGNK+90g9YljT3gc+AXTWzofp+5vc42Feliw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9245
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Hi Jakub,

Can you please apply this patch? Let me know if it needs to be resent.

Thanks,
Raju

On 9/14/2023 9:49 AM, Raju Rangoju wrote:
> Link status is latched low, so read once to clear
> and then read again to get current state.
> 
> Fixes: 4f3b20bfbb75 ("amd-xgbe: add support for rx-adaptation")
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> ---
>   drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
> index 6a716337f48b..c83085285e8c 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
> @@ -2930,6 +2930,7 @@ static int xgbe_phy_link_status(struct xgbe_prv_data *pdata, int *an_restart)
>   
>   		/* check again for the link and adaptation status */
>   		reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
> +		reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
>   		if ((reg & MDIO_STAT1_LSTATUS) && pdata->rx_adapt_done)
>   			return 1;
>   	} else if (reg & MDIO_STAT1_LSTATUS)

