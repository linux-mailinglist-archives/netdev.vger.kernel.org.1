Return-Path: <netdev+bounces-58095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 025EF815054
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 20:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817DE1F253E9
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 19:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9B341843;
	Fri, 15 Dec 2023 19:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CIWbYwWf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F614122E
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 19:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dB9rtYXIgSBYCswZWq2s72DnwEo8p4XFjFga5+W9pWv5+gk6CvxZ0di3hS4+lY+ce7XhdmFUDGYqqflTKe3yH8TzW4Zcy0OBmQW6Jt/qS5WwQ6wlatwU95V7/udx3vio8GVlkQuAxlM5U0eT7WbzAiMw5cXjuDlT3DC7pJMDvtyCQPVlhQA+iUlgi6GmM+9LVTyqL5kqYJllIhGpQpv4xGJTuBmbIKRw6TqlIYIs4424nPRrnLuCZdLOGs5S/dfF6sWbfDhxZam2uKuUml8Om5/mYv9YoWIcwJkH9ZvVP4snZZ7MITGi/j/2sGjy4eCEOKcD42fwDuz4TYupI1RPSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vg6dfyUVcxADAtE/hZVnmT+ljEM15lh33LhCRDXIO4=;
 b=Ntid2hbaaEQhsIBY8rVgAGi8046KwQdWaRfHj1A5rKOqRPp3/TLl+DEW4d1x4sQpCYqJvuhJhoJYAHFF+Ikyb3itfy79oBf4yRU6pmFFXoYNgBlUqeokxpmnVXAjfYY9lEbw8ipFL4IcFZNYxo5LopAU54CAO06JkEh30X/LXRsc11IAFx4brzsFDbwPTf9nztDGfR986i3dD+YOsS7zw7ePJyZ/Ceg8Ha2yiAJshVQtvnJlPVpiATrKDPyhLYyHJNqCI4cSaErnAvhRjWYEnJNgy9ugDi/dKdgstJuf2Q7WgjUlHRR1lpCv7o9DwTt7D/msUCPDFtBH5pKkV7SIHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vg6dfyUVcxADAtE/hZVnmT+ljEM15lh33LhCRDXIO4=;
 b=CIWbYwWfiFmnNgHBRPF1SdzB6bjWK5F5elPm5GnTawje/n6ngd1XyN8v4MCTiixsgXBTg2H5/lMseg1H6Epuw56W19BU1+51Y2Gppzl1NOQyfKenqeTJn44r1PS+2OKFpcNFaRYs6OvqK0I+CYdQuZP91t0CJx3fR57v/MYmf8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 19:45:13 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bec4:77b3:e1d1:5615]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bec4:77b3:e1d1:5615%5]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 19:45:13 +0000
Message-ID: <6cb7c5b6-bf5a-dc1a-9676-d664fe1a7acc@amd.com>
Date: Fri, 15 Dec 2023 11:44:50 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH iwl-net v2] idpf: enable WB_ON_ITR
Content-Language: en-US
To: Michal Kubiak <michal.kubiak@intel.com>, intel-wired-lan@lists.osuosl.org
Cc: aleksander.lobakin@intel.com, larysa.zaremba@intel.com,
 alan.brady@intel.com, joshua.a.hay@intel.com, emil.s.tantilov@intel.com,
 maciej.fijalkowski@intel.com, netdev@vger.kernel.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20231215193721.425087-1-michal.kubiak@intel.com>
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20231215193721.425087-1-michal.kubiak@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::28) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|MN2PR12MB4256:EE_
X-MS-Office365-Filtering-Correlation-Id: e9bb3c9f-36ee-48c5-96e0-08dbfda64f4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2CqI8PUGzT0VV1TTrZ4+vcV9jZuRbewodtNrtNaFeVCx2S9pkgYrRrZk2UrP8CJ7R8/qoJF2cdgZnvmv5fOuJVOpaWy027TVygUn/qVeHaVyvpvZi6nqJopkipUtPOQmi4RZbvTQnl1XlPId3oOlNTOv9zS/E40vr7hsqE2Y+/iGto4DCzGLfAQFg5twwJCBCeRQ6Y9xOsoLbClPVqfxJT0OPqDqJMyRDkqe7HdjvMmOsSXQCnezZomWOGTcvDLJ54VMpZNijNpCf5jjnayYfwrioxpKQ3JjxfGpYv7aE4/mn31YMlOewdtCbBflGkuZ/8jMkx5+JU450EBbggCYDT7ZyJPsMUGl4oSjp2AvKe3N/GSGIQMud18DNWaG/j7wQFVjE6FoAVd/XaqMN6CPvVTSD7KMaPtipn+uL8kx/9muhZWKigm18IRgRQUFoXgoauvHQ2UuDo8lxfcl13ozjTFlvVcBGZPdxI2jWa7OWbDBlkN9o/6N3mcj/BoxlBCSRfhlaCFahZ6c89ZSUTjwKONDwlChCHaN//vaUgE53lDSPdfeDGtZ79/pqe9aDr/Xq0yafeJYCp2BymxNLJGklcguAGidQ3xPSUF6LAh3sNh1ZWCoobA445OMcPv0NU6fALUo3lZja5f82V9Dm17MVhe08oaBPd9EGQe6Y713CIfYl8Q8JSPGeV51MXGlBSF3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230273577357003)(230173577357003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(2906002)(7416002)(36756003)(5660300002)(83380400001)(53546011)(6666004)(6506007)(38100700002)(26005)(2616005)(6512007)(478600001)(66476007)(66556008)(66946007)(6486002)(41300700001)(4326008)(8676002)(8936002)(31696002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFU2OUdPTGVZcEIxUGRSTUhuWWFiSHp2NlkrOWFmcWY4WDlYM3B3L1lRbEFT?=
 =?utf-8?B?YUJHQnpRaGR3RVM3YTRwMDZFV0dRSmdvb1k0Q0lMTXVmL1M4SUdVOUYyQVhy?=
 =?utf-8?B?VGlXUTV4WC9vMEx3VWJNaW1raFBZWmdWbmdoQ2twUWw4RWNMSURxTXBOaG1U?=
 =?utf-8?B?NVV2dUFqbk9CbXhtWURicHFCZ2dITk9LUGphdVdBbk1rQWMzb1FUU0lIWFc4?=
 =?utf-8?B?QTVlbkY4Y2F0SjZLUW1QU0UzWHBSeGIzTVlIWjVVbmkxUUt4VEVlRFVEMzA2?=
 =?utf-8?B?aC82TGh6OGRFSWkxY2xpRUhBYUlpcklENlNNaURiK3A2TWtIV2ptM3cyVlN5?=
 =?utf-8?B?bGJFaFNrcXZnbFdjVGZrVzBCUmhpeERrbkJFeERkdG96cjRGcGkxSzUxM0ZY?=
 =?utf-8?B?eUZOV3lUeDE3WWp1WWZ3R2lzTmNWMEp5WVhkczZydlVBVG15dGY3WlV6SklY?=
 =?utf-8?B?L0JTb1czc0xXZ2MwWFpzS0dZQ2ZoSlEzZUFuektvOGNBdDRXWGlrWUdaenAy?=
 =?utf-8?B?Zko1bnN0Q05CejF1dms3QU15V2UxNHZtVjltYWdoQXlpMHRXa2NpUlBBb1pt?=
 =?utf-8?B?RmFPMlhOVVNERU5hQjhrMUhOMG9nVW0xb2ZINTlUMDdXSE9KOGxPNHB0SEtm?=
 =?utf-8?B?ZVR4WTlTc0kzTm42M0JCQyt6Vlk1cHBhbFB2VWpxaEEwU1gyMjYrSUZqV29n?=
 =?utf-8?B?MU5mWk01aVprdE8yTFczbFBEcTdMOEZscHdrcWorZnlTLzU3Mmw0dVZRdVhK?=
 =?utf-8?B?SzB5anV4VndJTS9qVEVYQTlEQ1lZNFdQSGdFVHpVNS9DclhsTkxMSnIrMHZS?=
 =?utf-8?B?WEo2THN6UERRYWFydUhnaGhzdExza0ZoYlBDb3RpdnZwUkpaWFA4eWN5U1dU?=
 =?utf-8?B?QXQ1QmVua2tyclVHVDFpTkUvNk84YTlIemtjZ3AwV3Btd2RZNlNrUlQ5bkNr?=
 =?utf-8?B?eW5OdG94N1N5NiswY3V1eXk3UE9JdnltSlhlQjdIM3NQRFJUNVdjMnAwNXhz?=
 =?utf-8?B?YzZPY2pVTGFTalRRZHZzWTFNMms5Qjl5ci80eWVING11TnRqR1ZPS2orK3Y2?=
 =?utf-8?B?L1dqdlYrWE0wV0ljRFVRa3dVOXdqWFhHTjZGR29OMXNtRUJVUW5UcXRFYVlU?=
 =?utf-8?B?ZG9QN3p1L0FlNzZUYlpoRTBQbnMzZVBqWTZIaURDOXBsQXl6ZEkrdjlCVnht?=
 =?utf-8?B?RFR1N1plc2R6Q3dQWDNlM21tMFpNcjA4ZVNKTFI3OWZNL0g5VGpmR3FXeWwx?=
 =?utf-8?B?WTBVMzBaa3IwZEdMUXY0TUQ5V3Ntd0FtSU1TL1hPMWVEUVJhU3BoNUh5czBQ?=
 =?utf-8?B?WmE1NGtuVEg0eTZxd0dVTnRXbXdpbjVqaWVySnMyWnd1WExxT0pMYm42QXlm?=
 =?utf-8?B?cHpETEhiUEdzb1RNOFNPRnJ4azF6aTEvNVhyMEF5Rkc0bXVIMTdkay9sbGtv?=
 =?utf-8?B?ZDN6Zmk3N1piUkxTZDFLaWM0NVZwN2ZCVEFaZ3lFRVNsbXJCWkpGbWVBdUhr?=
 =?utf-8?B?SmlMd0JqVXhpbkZwNTFtN3RKcFhxNDNwOEdUZ0dzaEc5dmRPaEtCR1RCYkhh?=
 =?utf-8?B?TnNsRStFS0FpUk0wcFVlNVZwU0FzY2pFWlhVQ2lVeXRhbE1QYWttVEpEMTlX?=
 =?utf-8?B?WlN4SmFoT1FOSnd4Ti9VdHgxQXZScUFQTjgzUUN6NGU5ZzRVNUhUbWRlK3lP?=
 =?utf-8?B?aEF1dU1EWm5xa01JR0YxbFZSTUF0a0dPcncyOUl2ZXBNV0VsQ2RxZk01WU1H?=
 =?utf-8?B?cXg5ajBnMEJRanh4NW1Wa0xkRWlyZVVLS2xnWFhyMCtEV05YNWNGd0NDa21Q?=
 =?utf-8?B?TTNObnF4a0hJYUZkSDMvM0RxVGNad1ZlaDR0N0NwY0xPd21hcGZyOGw5Q053?=
 =?utf-8?B?Ny9hcjk1RmhKZlp3Smk2M1NZMlpsQ3JDbURaTlF0dWh3blIyVE9kSk4vcjBB?=
 =?utf-8?B?eHBjaGpyRzhmNVVDUkJ1aVdKclhYQlNJS0lIV0tEQ0RFL1N5YlpaQ2ZCL0ZN?=
 =?utf-8?B?QzM5ZU41ZFlRVlJhUDROVVk3UWsrR3IveGRGUlBOR2NkSlNmMHQyOHZ0bmkv?=
 =?utf-8?B?RGJrZytwOWs3b2w1OElJN3dCNFdrWnA4aWxDaThpSmE5eWlJT3BsaGlYRmxn?=
 =?utf-8?Q?PDy1UiONmcEC9WH8qutPTnzKM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9bb3c9f-36ee-48c5-96e0-08dbfda64f4f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 19:44:54.1342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/551L9fJerR/UB7AvJ2FHSAUx/j+l+rTIZ6EVPw/qoCFDVEvIZKQRaNzkXCRPZGRWPHSGYt4iE2CcDkWmVfUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256

On 12/15/2023 11:37 AM, Michal Kubiak wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> From: Joshua Hay <joshua.a.hay@intel.com>
> 
> Tell hardware to write back completed descriptors even when interrupts
> are disabled. Otherwise, descriptors might not be written back until
> the hardware can flush a full cacheline of descriptors. This can cause
> unnecessary delays when traffic is light (or even trigger Tx queue
> timeout).
> 
> The example scenario to reproduce the Tx timeout if the fix is not
> applied:
>    - configure at least 2 Tx queues to be assigned to the same q_vector,
>    - generate a huge Tx traffic on the first Tx queue
>    - try to send a few packets using the second Tx queue.
> In such a case Tx timeout will appear on the second Tx queue because no
> completion descriptors are written back for that queue while interrupts
> are disabled due to NAPI polling.
> 
> The patch is necessary to start work on the AF_XDP implementation for
> the idpf driver, because there may be a case where a regular LAN Tx
> queue and an XDP queue share the same NAPI.
> 
> Fixes: c2d548cad150 ("idpf: add TX splitq napi poll support")
> Fixes: a5ab9ee0df0b ("idpf: add singleq start_xmit and napi poll")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> Co-developed-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> 
> ---
> 
> v1 -> v2:
>          - reordered members of 'idpf_q_vector' to optimize the structure
>            layout in terms of cachelines,
>          - added kdocs for new structure members,
>          - added description of the example problem fixed by the patch,
>          - fixed a typo in the commit message ("writeback" -> "write
>            back").
> ---
>   drivers/net/ethernet/intel/idpf/idpf_dev.c    |  2 ++
>   .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  6 ++++-
>   drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  7 ++++-
>   drivers/net/ethernet/intel/idpf/idpf_txrx.h   | 26 +++++++++++++++++++
>   drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |  2 ++
>   5 files changed, 41 insertions(+), 2 deletions(-)
> 

[...]

Reviewed-by: Brett Creeley <brett.creeley@amd.com>

