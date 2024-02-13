Return-Path: <netdev+bounces-71545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5435853E2F
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 23:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19FC7B300BE
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 22:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAAD627F5;
	Tue, 13 Feb 2024 22:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xKRvJu1b"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A1D6341A
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 22:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861907; cv=fail; b=FlfRWorGpoVi9VGmUs5Uz7vX/BhD+2zZ8/wqQcDYqpMhBKUJj4wWMEtqRdd6L7bbMfEH20BmJxnw03d7DKb4SlCp3LBauFU1fPcb7tI2TvTEiPOn+FGFLhgleEcJOpZSQI6cm6F6U8QVTzymS3Ku7ACal7cpYthG5quZ0EbTvPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861907; c=relaxed/simple;
	bh=9yYneMRE8wXwcjn3JkeEKBGbSWmTPzB1TzBGxvAlDzA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VwUv5BOA8kzYQvH3Rq13t0b89jIeyY4m9UPPoOIDnoDtfskA11LCIDtnK/XDLBeUY8nAu/vlO/3IrrQYqg2wytM9KWnVaQuCT9GaSDAAerAAtA1wSnoeK+mxAuTkbajtYEpyvoQobcbmP3IYW4+7yii61YcPX6XWZAkZ5tVvIcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xKRvJu1b; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+e9tIPZY4pAmiDXOGmFIdTJJx1moC7GSVgRLXSzcLQFAGwFElvGUthCUqDeNJCK9F7bVb57yD1M3oUfR1xmHNP8T7+BsSnKRANnISCJ61ryFfrgrrT5BdFqZJTYgza0oIRtbw4+aBMuMpATbUVOMNBwqLbydUEQE6+YC1IPXo6GvNGawnvS7pW4H8IZnuozLe66qSn9p4RsI9W5JE/P+hHKwB8AbsDhBf8RjjKV61GLjytyTopwXyuOfhjjaSPnzncVNVGWfW9GETxtuOP4n1uR4gXE7IkBCpajLWfIhgTeSUZhxGWzv8J+qSSJFygtZ8Vl2dJq1BgTrULTlAJsag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQQuFtECCiQ33gxVCiA/E62DXu3kbFS13kIXdSv0fNQ=;
 b=YfDS81n5qceReek3dmAkIksZmnFWnYP2fK8VasOVA8FmjjcqSYxd2E2/jkL4dS9gHMi5iK6eoEYNKqyHPu/BAD2TptpPCResQAo0kOxlu1gwOjY5atX8mu3tw3P6darr90tf/gwN/BMAbnSXPlpyokUrBW/D6w02/ZlnZ0xr7rv01NiSsjCfDbAH7+yUiW4EFJhL+O5tXtWj7VRtmEf117k2GHeKzLHdFB2T4xPvNJRdBn9Y5EXeGdk5GVYstirsImR0FF1m3KAiX+PfuNAHoXn5+rUaX/UNqdDzMniQfc4hPSjXTlQSxzca93LQiIapKBsYRT+Ieoh4z2h6OXfzZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQQuFtECCiQ33gxVCiA/E62DXu3kbFS13kIXdSv0fNQ=;
 b=xKRvJu1bCtx9RvZjtvHW0yXW50ttFnjKxF8trT396pQFiQruNqZnElkCWYolj9+R5B0u9rqRo0mqo634fUItKY84H+Yxs2FJd4Quke/HGzqbesIXiSUgMPsYqZmBs6B46NHg0/CbOzlOzq/4HD2T/BU4xqcriStEht497ZAFhBo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 MN2PR12MB4080.namprd12.prod.outlook.com (2603:10b6:208:1d9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 22:05:02 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::e4b7:89f7:ca60:1b12]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::e4b7:89f7:ca60:1b12%4]) with mapi id 15.20.7292.022; Tue, 13 Feb 2024
 22:05:02 +0000
Message-ID: <6bee09ad-c2b6-492a-9658-52968776e4e2@amd.com>
Date: Tue, 13 Feb 2024 14:05:01 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 4/9] ionic: add initial framework for XDP
 support
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, edumazet@google.com
Cc: brett.creeley@amd.com, drivers@pensando.io
References: <20240210004827.53814-1-shannon.nelson@amd.com>
 <20240210004827.53814-5-shannon.nelson@amd.com>
 <e8b9b82644de7acbe7a7f8059d17ed7908f3df17.camel@redhat.com>
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <e8b9b82644de7acbe7a7f8059d17ed7908f3df17.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:254::6) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|MN2PR12MB4080:EE_
X-MS-Office365-Filtering-Correlation-Id: f7effebc-8dd7-41a2-1063-08dc2cdfd3fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EBz7q1QYb1VDrns4/oNh9o0vbGWyhwPk0dus9oz5gY7oOth+5iM0VrxA0/H/+0Cbp7x7zMnt5hBmY2Vx5Eu9PLFukVVhkG7DThZGA84OgYAbT1KZnYS2cO8LqCBVQCSM2CnM0QikA1CFxUx4+vpB5iSyZRoxHb8xDMg83auCX0+J0I+dxbnlfUoC8r0eLOrDjTOLgp/LHd23xRZ6XUxuL5VfGOGxK8EuJuygR5F81bWxvQcG/E0/8t4CGNk2afj6lOgsZ0y2e3OIak+x+Ea6llQa/MIol8ILtmJ0Z7Og2X3kBZMekxC8wtcF3OpIaMidgbHMc0g0LKNv2pURgCYqqEyx8kDtfn75JP4nZ3v5sRmSEu0XrG1nUxFahd8lPHKQ/E50cmqEoP3hmhLOT/tje9vGiKxd5yOQCLCmVz5GVzSuZZto/CKQRuVyHesZnxIeK9eiWWS5417WKBo0OHYp2v6rG1ISxoi7119RDb9/WjYSULbkaSQJj9DfzsQ6gbd/ITIhzkmghkNOeVrrtnAWvfp7U6tOzvqjeGEzLxM2WbT8IwEPQbUACOXWW9Q6Z2bi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(376002)(136003)(230922051799003)(230273577357003)(451199024)(64100799003)(186009)(1800799012)(31686004)(2906002)(41300700001)(8936002)(83380400001)(5660300002)(66476007)(6512007)(8676002)(66556008)(4326008)(66946007)(26005)(36756003)(2616005)(53546011)(478600001)(6486002)(316002)(6506007)(38100700002)(86362001)(31696002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SU9LMm8xdEs1TjBLV2U3MHprR0QwS2hWWmxsYTlGdS9zdlJ1NCtJRkxCZktO?=
 =?utf-8?B?VGFPUVNCOWx0S0ovU3MxbGZwdXQ1eUw0TzNWVTc2NjNBMWZDYlhLUVFYMmtZ?=
 =?utf-8?B?ajNFZTRzbU9Nc05xNWk5aVBmcSt5MjJSRHMwdnU5NFJ6YXRodHc4dlpYaGZZ?=
 =?utf-8?B?YlJJQ25KSTVtOVFuenZseWh6QjA3Q2J5aEUyRGpnZ3hvTVZHV0k5c3RVWXgw?=
 =?utf-8?B?dmluS1RybVhtVHg4dVNvME5DN2RCckt3d0dNNm11VmNJcW11VFYvc2FJWDZQ?=
 =?utf-8?B?S2VlYy9CZkMzUldLVmJEMDluY3NjZnZzb3o1ZTRTNG5hT0tmVjYzYlhLbVhR?=
 =?utf-8?B?bVJicjQyWVIxeXZKUWswUVJZMHVGbjNmdWxjQWdodHZVZmE4MzA1WlVVNGJG?=
 =?utf-8?B?SmVGRjlqVWRySG5UbDVFL1NVZjgvV3JHck5nWlJuQ21NNG5sNXFDdUppN0F0?=
 =?utf-8?B?Y3hycWxtdXA1ZGdIZFVHUkdtZkZyV0hDNEFlVVNUamR6cGpWbW1jV1RzOW9C?=
 =?utf-8?B?V2pYY2w2RWhhalcweVVoWi8yZHFjRzRTUjZhTHJ3TmZlNzNRN25EQ0NBeFQy?=
 =?utf-8?B?a0tnWDlLVSt3cmxZTThQM1h6cXZtakliNTRBYTNjMzFzQjVIRjgxbHFtVTFi?=
 =?utf-8?B?OXAwRnRKLzU0aG1ybkVEL2xvckl5ZTIrYXhLZGl2aHNISDhQNzEzWEhKbk9U?=
 =?utf-8?B?dWpYcjc0MVFuNE1xZW1XM0NtT3kwcFBaVTNTbFNjRlAyZE5NM1AxbDBybzlO?=
 =?utf-8?B?UStFYUVCY05ySkR5UUdweFVBOSs4eFlWQUsxUEM3Zll5RGdKZk1HZGJCK25T?=
 =?utf-8?B?dkNWb2dmTW8ydFdMMkxxWjhrMHMyUXVySDN1dk1MMFhHb3Q4SXNSbWVUSWtJ?=
 =?utf-8?B?YktESWppOGhRN29SKzdMemhxK2VvZ3lqOTlaU1UxT2hWMjdsNlBlSFRHVnUx?=
 =?utf-8?B?ci9MWWxnbW51TUZnOXltR2V1R00xN0R5K2xseXhnZUdlVFN4NkFKaXZJblg4?=
 =?utf-8?B?VjA4blV2ZUh2R29vZzZObUtINFdjTHVHNy8rbWFOUDRBL3JWZWFRdFZvVlZw?=
 =?utf-8?B?Nmg4ZWFvQmdpdHdpQ2E5eGZEZFROamVadEgyUzNrOW5kTVd5WG9Iam1SUENT?=
 =?utf-8?B?T3RsTklRZ3hsK0Z4QkZoNnZOTE9qdWM0anRRUnFRQjQ3c25haFRnU0Jid1p0?=
 =?utf-8?B?OHd0c21DTVdlRVIydWtQZ3pxTVhranQ2M1ZZVDBhTStzYmVNb3ZTTXpOTTlY?=
 =?utf-8?B?MjRpKzNhS1ZDbnNoMlp1UFB3czZIM20wUmNnVGhhcHcwL0dJQ1pQWlp4bzlU?=
 =?utf-8?B?OGpZd01rNGlYZGNJRjdNUmJ2M1FuQ29EOVJTbHNkV04xRGlqTXhpczY1SGdU?=
 =?utf-8?B?WDlrNnkrY253a2YyeUY3TCtqZU0wbnN1OHBocCs3QVNUTG1qSTVIbUJOZEM1?=
 =?utf-8?B?Y052Z3YxTmhheFdvbkpLeUc2RzdYNy9vYjJSamgxWnBLUE92dkE4Smg2cUlK?=
 =?utf-8?B?eTYrSXp2cElvODZVK2FRQ1UvNVhFMDYyZlRBRndVbitYMVRhY0Z6b0drc1Iv?=
 =?utf-8?B?VjJCKzNjdXpCNTNUYXpMM0s3QlJYeVBRNW1zd0kxb28rcUd4dXVMdzNGTVdk?=
 =?utf-8?B?c1I2b0ZPTGVISUVrUENpeHd4M0NtSFBDM1dIbDlEMGdwMjlpR0tpYVltL0Vn?=
 =?utf-8?B?bHJoUk1xMmMyeWt4dk1oeUtFRVloZzlxRXUzK2c3eFR1cHFFMzR3cGNzY2lw?=
 =?utf-8?B?N1B4b0wyYjZCYWZ2ZzIzY0hQUnNGZjQxaXBtbjhoSTdjVERHbzZxREl0MU92?=
 =?utf-8?B?VHRLSzBxL01QNGh3YmFoVEhPRVVXNWFlcFMxWkNnMFdMWGQxYnluOEhBNmlN?=
 =?utf-8?B?TktCdXRXaHRXY2ZUVlFab2FkTlZVMEtNYjBHTCsxczZOVWw5MmZjNVFCWks5?=
 =?utf-8?B?MUxxWHg2OGE2Z1NsWlNxcEErdTVoeWt2NjMxclVyWkFwa2pjWm1qL3Q4SU02?=
 =?utf-8?B?UHF6SU53RVcwQW1rclMwU0VTQjU0bUxlNkIrTlQ2QUNrdVVUaCtLbEM1S0Yx?=
 =?utf-8?B?bkJlYU1oaDl6SFRBSUsyTWpoMTdLbGNySXgrTHM5a0wzcFdNRDdxRW1SdSsw?=
 =?utf-8?Q?TqoTpLq2jZPOr9dsPTOGx3p6m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7effebc-8dd7-41a2-1063-08dc2cdfd3fb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 22:05:02.6710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbmDttn5jZSsaS6yOkn//xolV/19MYHMlZzNLH8ZaZEIqVgQ7OEBuPNec83PBJkXTnsi95+Lf9d9AmzBFMuz/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4080



On 2/13/2024 3:20 AM, Paolo Abeni wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Fri, 2024-02-09 at 16:48 -0800, Shannon Nelson wrote:
> [...]
>> +static int ionic_xdp_register_rxq_info(struct ionic_queue *q, unsigned int napi_id)
>> +{
>> +     struct xdp_rxq_info *rxq_info;
>> +     int err;
>> +
>> +     rxq_info = kzalloc(sizeof(*rxq_info), GFP_KERNEL);
>> +     if (!rxq_info)
>> +             return -ENOMEM;
>> +
>> +     err = xdp_rxq_info_reg(rxq_info, q->lif->netdev, q->index, napi_id);
>> +     if (err) {
>> +             dev_err(q->dev, "Queue %d xdp_rxq_info_reg failed, err %d\n",
>> +                     q->index, err);
> 
> You can avoid some little code duplication with the usual
>                  goto err;
> 
> //...
> err:
>          kfree(rxq_info);
>          return err;
> 
>> +             kfree(rxq_info);
>> +             return err;
>> +     }
>> +
>> +     err = xdp_rxq_info_reg_mem_model(rxq_info, MEM_TYPE_PAGE_ORDER0, NULL);
>> +     if (err) {
>> +             dev_err(q->dev, "Queue %d xdp_rxq_info_reg_mem_model failed, err %d\n",
>> +                     q->index, err);
>> +             xdp_rxq_info_unreg(rxq_info);
> 
> and using the same label here.

Since it is only the kfree(), I wasn't going to worry about a goto, but 
sure, I can tweak that.

> 
>> +             kfree(rxq_info);
>> +             return err;
>> +     }
>> +
>> +     q->xdp_rxq_info = rxq_info;
>> +
>> +     return 0;
>> +}
>> +
>> +static int ionic_xdp_queues_config(struct ionic_lif *lif)
>> +{
>> +     unsigned int i;
>> +     int err;
>> +
>> +     if (!lif->rxqcqs)
>> +             return 0;
>> +
>> +     /* There's no need to rework memory if not going to/from NULL program.
>> +      * If there is no lif->xdp_prog, there should also be no q.xdp_rxq_info
>> +      * This way we don't need to keep an *xdp_prog in every queue struct.
>> +      */
>> +     if (!lif->xdp_prog == !lif->rxqcqs[0]->q.xdp_rxq_info)
>> +             return 0;
>> +
>> +     for (i = 0; i < lif->ionic->nrxqs_per_lif && lif->rxqcqs[i]; i++) {
>> +             struct ionic_queue *q = &lif->rxqcqs[i]->q;
>> +
>> +             if (q->xdp_rxq_info) {
>> +                     ionic_xdp_unregister_rxq_info(q);
> 
> You can reduce the nesting level adding a 'continue' here:
>                          continue;
>                  }

Sure, will adjust.

> 
>                  err = ionic_xdp_register_rxq_info(q, lif->rxqcqs[i]->napi.napi_id);
>                  // ...
> 
>> +             } else {
>> +                     err = ionic_xdp_register_rxq_info(q, lif->rxqcqs[i]->napi.napi_id);
>> +                     if (err) {
>> +                             dev_err(lif->ionic->dev, "failed to register RX queue %d info for XDP, err %d\n",
>> +                                     i, err);
>> +                             goto err_out;
>> +                     }
>> +             }
>> +     }
>> +
>> +     return 0;
>> +
>> +err_out:
>> +     for (i = 0; i < lif->ionic->nrxqs_per_lif && lif->rxqcqs[i]; i++)
>> +             ionic_xdp_unregister_rxq_info(&lif->rxqcqs[i]->q);
>> +
>> +     return err;
>> +}
>> +
>> +static int ionic_xdp_config(struct net_device *netdev, struct netdev_bpf *bpf)
>> +{
>> +     struct ionic_lif *lif = netdev_priv(netdev);
>> +     struct bpf_prog *old_prog;
>> +     u32 maxfs;
>> +
>> +     if (test_bit(IONIC_LIF_F_SPLIT_INTR, lif->state)) {
>> +#define XDP_ERR_SPLIT "XDP not available with split Tx/Rx interrupts"
>> +             NL_SET_ERR_MSG_MOD(bpf->extack, XDP_ERR_SPLIT);
>> +             netdev_info(lif->netdev, XDP_ERR_SPLIT);
>> +             return -EOPNOTSUPP;
>> +     }
>> +
>> +     if (!ionic_xdp_is_valid_mtu(lif, netdev->mtu, bpf->prog)) {
>> +#define XDP_ERR_MTU "MTU is too large for XDP without frags support"
>> +             NL_SET_ERR_MSG_MOD(bpf->extack, XDP_ERR_MTU);
>> +             netdev_info(lif->netdev, XDP_ERR_MTU);
>> +             return -EINVAL;
>> +     }
>> +
>> +     maxfs = __le32_to_cpu(lif->identity->eth.max_frame_size) - VLAN_ETH_HLEN;
>> +     if (bpf->prog)
>> +             maxfs = min_t(u32, maxfs, IONIC_XDP_MAX_LINEAR_MTU);
>> +     netdev->max_mtu = maxfs;
>> +
>> +     if (!netif_running(netdev)) {
>> +             old_prog = xchg(&lif->xdp_prog, bpf->prog);
>> +     } else {
>> +             mutex_lock(&lif->queue_lock);
>> +             ionic_stop_queues_reconfig(lif);
>> +             old_prog = xchg(&lif->xdp_prog, bpf->prog);
>> +             ionic_start_queues_reconfig(lif);
>> +             mutex_unlock(&lif->queue_lock);
>> +     }
>> +
>> +     if (old_prog)
>> +             bpf_prog_put(old_prog);
>> +
>> +     return 0;
>> +}
>> +
>> +static int ionic_xdp(struct net_device *netdev, struct netdev_bpf *bpf)
>> +{
>> +     switch (bpf->command) {
>> +     case XDP_SETUP_PROG:
>> +             return ionic_xdp_config(netdev, bpf);
>> +     default:
>> +             return -EINVAL;
>> +     }
>> +}
>> +
>>   static const struct net_device_ops ionic_netdev_ops = {
>>        .ndo_open               = ionic_open,
>>        .ndo_stop               = ionic_stop,
>>        .ndo_eth_ioctl          = ionic_eth_ioctl,
>>        .ndo_start_xmit         = ionic_start_xmit,
>> +     .ndo_bpf                = ionic_xdp,
>>        .ndo_get_stats64        = ionic_get_stats64,
>>        .ndo_set_rx_mode        = ionic_ndo_set_rx_mode,
>>        .ndo_set_features       = ionic_set_features,
>> @@ -2755,6 +2922,7 @@ static void ionic_swap_queues(struct ionic_qcq *a, struct ionic_qcq *b)
>>        swap(a->q.base,       b->q.base);
>>        swap(a->q.base_pa,    b->q.base_pa);
>>        swap(a->q.info,       b->q.info);
>> +     swap(a->q.xdp_rxq_info, b->q.xdp_rxq_info);
>>        swap(a->q_base,       b->q_base);
>>        swap(a->q_base_pa,    b->q_base_pa);
>>        swap(a->q_size,       b->q_size);
>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.h b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
>> index 61548b3eea93..61fa4ea4f04c 100644
>> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
>> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
>> @@ -51,6 +51,9 @@ struct ionic_rx_stats {
>>        u64 alloc_err;
>>        u64 hwstamp_valid;
>>        u64 hwstamp_invalid;
>> +     u64 xdp_drop;
>> +     u64 xdp_aborted;
>> +     u64 xdp_pass;
>>   };
>>
>>   #define IONIC_QCQ_F_INITED           BIT(0)
>> @@ -135,6 +138,9 @@ struct ionic_lif_sw_stats {
>>        u64 hw_rx_over_errors;
>>        u64 hw_rx_missed_errors;
>>        u64 hw_tx_aborted_errors;
>> +     u64 xdp_drop;
>> +     u64 xdp_aborted;
>> +     u64 xdp_pass;
>>   };
>>
>>   enum ionic_lif_state_flags {
>> @@ -230,6 +236,7 @@ struct ionic_lif {
>>        struct ionic_phc *phc;
>>
>>        struct dentry *dentry;
>> +     struct bpf_prog *xdp_prog;
>>   };
>>
>>   struct ionic_phc {
>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_stats.c b/drivers/net/ethernet/pensando/ionic/ionic_stats.c
>> index 1f6022fb7679..2fb20173b2c6 100644
>> --- a/drivers/net/ethernet/pensando/ionic/ionic_stats.c
>> +++ b/drivers/net/ethernet/pensando/ionic/ionic_stats.c
>> @@ -27,6 +27,9 @@ static const struct ionic_stat_desc ionic_lif_stats_desc[] = {
>>        IONIC_LIF_STAT_DESC(hw_rx_over_errors),
>>        IONIC_LIF_STAT_DESC(hw_rx_missed_errors),
>>        IONIC_LIF_STAT_DESC(hw_tx_aborted_errors),
>> +     IONIC_LIF_STAT_DESC(xdp_drop),
>> +     IONIC_LIF_STAT_DESC(xdp_aborted),
>> +     IONIC_LIF_STAT_DESC(xdp_pass),
>>   };
>>
>>   static const struct ionic_stat_desc ionic_port_stats_desc[] = {
>> @@ -149,6 +152,9 @@ static const struct ionic_stat_desc ionic_rx_stats_desc[] = {
>>        IONIC_RX_STAT_DESC(hwstamp_invalid),
>>        IONIC_RX_STAT_DESC(dropped),
>>        IONIC_RX_STAT_DESC(vlan_stripped),
>> +     IONIC_RX_STAT_DESC(xdp_drop),
>> +     IONIC_RX_STAT_DESC(xdp_aborted),
>> +     IONIC_RX_STAT_DESC(xdp_pass),
>>   };
>>
>>   #define IONIC_NUM_LIF_STATS ARRAY_SIZE(ionic_lif_stats_desc)
>> @@ -185,6 +191,9 @@ static void ionic_add_lif_rxq_stats(struct ionic_lif *lif, int q_num,
>>        stats->rx_csum_error += rxstats->csum_error;
>>        stats->rx_hwstamp_valid += rxstats->hwstamp_valid;
>>        stats->rx_hwstamp_invalid += rxstats->hwstamp_invalid;
>> +     stats->xdp_drop += rxstats->xdp_drop;
>> +     stats->xdp_aborted += rxstats->xdp_aborted;
>> +     stats->xdp_pass += rxstats->xdp_pass;
>>   }
>>
>>   static void ionic_get_lif_stats(struct ionic_lif *lif,
>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
>> index aee38979a9d7..07a17be94d4d 100644
>> --- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
>> +++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
>> @@ -177,7 +177,7 @@ static bool ionic_rx_buf_recycle(struct ionic_queue *q,
>>        if (page_to_nid(buf_info->page) != numa_mem_id())
>>                return false;
>>
>> -     size = ALIGN(used, IONIC_PAGE_SPLIT_SZ);
>> +     size = ALIGN(used, q->xdp_rxq_info ? IONIC_PAGE_SIZE : IONIC_PAGE_SPLIT_SZ);
>>        buf_info->page_offset += size;
>>        if (buf_info->page_offset >= IONIC_PAGE_SIZE)
>>                return false;
>> @@ -287,6 +287,54 @@ static struct sk_buff *ionic_rx_copybreak(struct ionic_queue *q,
>>        return skb;
>>   }
>>
>> +static bool ionic_run_xdp(struct ionic_rx_stats *stats,
>> +                       struct net_device *netdev,
>> +                       struct ionic_queue *rxq,
>> +                       struct ionic_buf_info *buf_info,
>> +                       int len)
>> +{
>> +     u32 xdp_action = XDP_ABORTED;
>> +     struct bpf_prog *xdp_prog;
>> +     struct xdp_buff xdp_buf;
>> +
>> +     xdp_prog = READ_ONCE(rxq->lif->xdp_prog);
>> +     if (!xdp_prog)
>> +             return false;
>> +
>> +     xdp_init_buff(&xdp_buf, IONIC_PAGE_SIZE, rxq->xdp_rxq_info);
>> +     xdp_prepare_buff(&xdp_buf, ionic_rx_buf_va(buf_info),
>> +                      0, len, false);
>> +
>> +     dma_sync_single_range_for_cpu(rxq->dev, ionic_rx_buf_pa(buf_info),
>> +                                   0, len,
>> +                                   DMA_FROM_DEVICE);
> 
> in case of XDP_PASS the same buf will be synched twice ?!?

Yeah, that is kind of ugly.  I can pull the READ_ONCE of xdp_prog out a 
level and use that as an indicator for blocking the 2nd dma sync.

sln

> 
> Cheers,
> 
> Paolo
> 

