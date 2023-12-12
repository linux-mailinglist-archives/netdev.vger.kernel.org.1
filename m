Return-Path: <netdev+bounces-56485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDA080F13E
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 16:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FCF82816A6
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 15:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F1876DC4;
	Tue, 12 Dec 2023 15:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Yn07hkSg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2070.outbound.protection.outlook.com [40.107.95.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374B9E4
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 07:38:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPqNXfOAm6wAO2U9hj3fMasCGti1rqMdt1O9y3+NuOWWSkRfV4evXSj3MBMQLUDkqVTN6h6valW0aXGxWDRZurjQNJtnnnWHebk3Fak464DnMBt3CPLwpuoUMIZ+Y1Lf4qQbZ/xiKTqcepmmLYLzOsfQaPN7BNShphtQIUXaCL3d43/uqLGRWb6x82r5KAO2ZamajsbJpffXiyVE/wGQRvKXIBafmxpJqGq5YPEzr7DNfTRx7kHOXa6ekgfH1lyyS0/NABFRvacgtJJW61vhUCNXjF+T6QbfTr8tEAik/ZIUj6kjgLIMUwWqHDTjrVpEHxbLdjj4qVizfgvYuU7e2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J68EffhYMY5sZLPjSe61jNsPfH2Aq/MvMhB8wtHwkY0=;
 b=Fxak13o5LpzMS6cmi7sFo9b5wVozwZ1DIob3q/qM0bAWFguR2JLShIlG3cFpZQqOit4MR071EcIIh4gkiJL3vlqgTIDOELf88FyKudka8xDgJPTS88Bmz/BnXiPF3jBVlLm1n4wUB4wU0dVNA/b1EVaIhYm2DyIFUsN6ZFSJy5Y+s46pf4BvtUPYvodIW5lZISu/9Hq0zNaww+4P9OhuomJ9le6ZmNeIGNFSeol2C2tEbp9triH2E/n6S14oNJv89tkmXMz8iuAPo+uO4kU0BmUmHw4Ql2po4bWM7fLlyQ7/WG2BC9j8CPrikfWeO0PpF3BgV5kKGJngQIcxw2ydgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J68EffhYMY5sZLPjSe61jNsPfH2Aq/MvMhB8wtHwkY0=;
 b=Yn07hkSgPoswfPH8bnkN5DhToBIqfn9O/cpjtnLC9n0ftomeoIVUuw0r1ulneEqcmxrAP3Fc0frfV0ieCupyzgwQXcqBVBejIZr4UXopVRtG+xzkFrSC8Jzp1jRanv7R4lFDPSr3lL0thgVDjytg8SMi3zOj5/IajBWsAXBVsc4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by PH7PR12MB7260.namprd12.prod.outlook.com (2603:10b6:510:208::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 15:38:33 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43%6]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 15:38:33 +0000
Message-ID: <68c52e74-dd8d-4211-bdb9-9541b41c6900@amd.com>
Date: Tue, 12 Dec 2023 09:38:31 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 3/3] amd-xgbe: use smn functions to avoid race
Content-Language: en-US
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, Shyam-sundar.S-k@amd.com
References: <20231212053723.443772-1-Raju.Rangoju@amd.com>
 <20231212053723.443772-4-Raju.Rangoju@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 1NhFSLKvfA==
In-Reply-To: <20231212053723.443772-4-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR06CA0009.namprd06.prod.outlook.com
 (2603:10b6:8:2a::28) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|PH7PR12MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: 867d8bbd-2b66-4941-bd51-08dbfb286649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ccRqS1EzA680u40vKVKeXmP+KcrRIXsjUtzJOrtjUGitpTrN0g5v1i4aJaQeKBL//Gw9usE4I+kXgq0HPk9CDcfUS+Gr0HvfF4CHhUDBhAVEzq0CKAUcOZPCP/mJnQi6yIvQrLpMh+5dlkxH7IQwJogRpzi+GiD1QTUiReO0E7GioZF6W4sgemIz7CZJylssWSrCCwbV89qGlNZ2e6O+cC6wjjYzXoPYlpMgeAsEG2ruxxwnOwALQV85CWNvP/iBbdjt+V1haJL26koZkXZsaO5p+4kbEfmZ9dkvgJ8T3sAwTT43LtOYb+JubEF3xo+onVtfrF6G+Zq7PHv2A4c3NeY/+xXw32FNOJ8N8BiLoDIqoXBdvTGP8XRhsNg6rbT4IH0r2GiO8yZjIsvPQugYiGoYQX31wtLZSNbiS+G2/aHXzJZY/4QNPCfWPXoa1MnCkKhDmwZFW9KfQSMG3qfmK+wiYfRLfKEoDvNic/v2OOiTt2J1KygapGZRXxVw3CsVyfuKgfUvcVTdYzeg/141FUkJXelyguDXGFRqiSMMfhtxi6kEt2epMOtMR717sqMopCN4YgwpskosvCqtlESVrfMLFU4i60UblkOoihrDOyoAcMT5dJND7amB7PiTRc9MQvzwdKnT+yQhP/oaABX6Hw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(6512007)(38100700002)(26005)(2616005)(4326008)(8936002)(8676002)(316002)(5660300002)(2906002)(6486002)(478600001)(53546011)(41300700001)(66476007)(66556008)(66946007)(6506007)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjJHeEJBVis2b1I5dHVqNzJreXpqVUlUMzNCMFJmc205dnA1NENCeWpLRVBo?=
 =?utf-8?B?S1JWNUVnWG9MeWFuZHF1VU9rWnZ6NTZ0S0dESzYwK1ZleU9NWU9rMUExVjhV?=
 =?utf-8?B?RUU5cHB3N25iR0x3RjlLcHA0WUhUTmFtOXlkNEhDZ2MrQVRybXRSVzNuNmhF?=
 =?utf-8?B?a0JPTWpYUXJLMldFU1JFQkRNYldmMGtMMUNZQ2VBMGFqKzBXWlkxT1lPMThH?=
 =?utf-8?B?cGFMOFZuUmhndXQxb2JwWVFNZHg0bEpYcHRhUUxrU3A0emt5Y1lNZS9nNmFq?=
 =?utf-8?B?MFpiZUtLMHZrOEJ3SnFpNWtabjhPVFdRZmtjTzl6KzV5VytBVmtYeTQ2RGFy?=
 =?utf-8?B?NTdBOXZ0Q1Z0MGtNTHIwV1pjZElXRDJqUTFQY3dlQVZHUUNJV0MvUkxuRCto?=
 =?utf-8?B?ejNlRVNUbXh3c3IwbDFxajZIRDZWQi9xRUdHcjlDMkJlRUtFVGtORkVNUy9x?=
 =?utf-8?B?TExSVHdteUFXZWJwZ2NwVm94eXBPVXhWQjU0M3RLNmJEV3NPb3BhK2xGSFdG?=
 =?utf-8?B?Y1Qvd1IxTjZ0TWFWU1kwUVNoMnJpb3UxTUFmUk00YjcvcXFVeWRNUHJISVRa?=
 =?utf-8?B?SWxiWmk1SFg1a2drMld2WXQ5U1JLTDVmTzl5U2E2a05GNkZ5a250S2V6aklw?=
 =?utf-8?B?blkzNitpUnZ3MlNYOUtOK1Z4RFBxNzJqVExhVEpsR2p5S05zZ0NsVHZVTUJI?=
 =?utf-8?B?SjR3OHZ6UVA1SWI5OFZjMGlaQWZzZG5GNG1TYUJjRkphNXJYbVZaL1pHY1Nr?=
 =?utf-8?B?aHNvY0R3STJPdXZjWkRHM1FMM3Y3RWlDb0pYSGhqVUIvU2gvZnJHUUFxWEIr?=
 =?utf-8?B?UWdKV3N2NENWR1ZsNkcrbGZZUmRzYkJqRE5IQll4cE1XK29VRUhlUDhoUjNi?=
 =?utf-8?B?aG1tNjFWTVo2U05hYVN5ZnFKa0xYcGJ5eW11U21RRVJCYStVbnhIUFRkbnpj?=
 =?utf-8?B?Z2VTVGZWTlFzeEdqejR2Z1hEcFRKdkNrQ04zcGwySnlkMmR1UVNpTStDbUkx?=
 =?utf-8?B?VmhEeWtNRUNmbnE1UnJrNUpOYXNsUDRHeUJGdUFSdHgrK1dDRUZzODVwemE2?=
 =?utf-8?B?OXFMTDBoNzdPNGdxbk13SjVuV0pkS0p5NW9YSk9jNmxLbEVYcnVqUG8xOEtr?=
 =?utf-8?B?Y0p1MFc4WWpsWENiM3FuMkR6Y3lOK1I3cVZKY1pYMklTYWV5M01FaDFSMjFF?=
 =?utf-8?B?TERNbHRxNkI1YzFoOUJrWUZUVlBEV1d0aC9VRG5CaXlaVXNObzZHWTNNUWd1?=
 =?utf-8?B?aWxYekxaUkZ3WHhFc1Y1MWhCcndJc2xYckRWdDhSNHhMeFhtS3M4dTNtM2VE?=
 =?utf-8?B?b3p0QUJ4bUR2V1orQzNTVnBOdStTQmpBTnlmelliUEtpZTdHRWlOS2RYSE80?=
 =?utf-8?B?c1B2TVVwZHFoYW1TbUdQZ0hGa25MOEF2YXV4M09zNlVFZ3JKbHVLS0QyMjB6?=
 =?utf-8?B?dkM3M2xtZFhqc3pPWC91aXphZDVDWkJ3SnVKcy9jWm00MjF2aHYzMjRncnZE?=
 =?utf-8?B?RDh2NVlGTmY0WmU5S2NwYzdWMEgyN3NwTFAvYWVvMUZsVHkwKzRIc3NzZE1o?=
 =?utf-8?B?NGhXK1FmYklYQUV4a2tWTytxQlR6WTFLNFVKK1d2c3NVYmtWd2JvbExGZXBI?=
 =?utf-8?B?RkRxb1MzaHcvT1Y1dkRPYXdKR2lCbkNNakFJbGZPcHZUcU9CanlPaGVET1FN?=
 =?utf-8?B?U21kNGNpSEZKNFk3cWJncmlWcWlaMENwbEFRWkRJN1NzeG1KL1I1c205a2pw?=
 =?utf-8?B?Tzl4eVFaeFNJQ1JRZDBiOVp5RlVadmdNeWtvRTh0V0dlcktPUS9zYlZuelA2?=
 =?utf-8?B?N1dqNDVCekpuQmdTQXdzQWFYbE11NEpOalJXTFpwYUUrc1JsTStCVUFTcEtV?=
 =?utf-8?B?UEd6cjFEODUyUjlNZ2p3Qy9uMHIwWUszLzVzQTJ6a2YyZmt1YlY5aFhGTG52?=
 =?utf-8?B?M0Z4bmJvRmlUTmVZM25zOUZOUDlCQkVVVGhHZXNNcExNWUk5Z0w1SHIyRUh3?=
 =?utf-8?B?c0RQSlR1ZjB0N1YvMTR4WFlVbjVKQW53djVxMENyYlA1T2FkQWtoMURNQnYr?=
 =?utf-8?B?UXRWRGxTTE8rMlVhQkdUY0RTSzNSc0lZTWNldzMzaWF0K1oxRzZCSmRQOFpJ?=
 =?utf-8?Q?0jMweGGDl7Kn/kuehzLoEG17Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 867d8bbd-2b66-4941-bd51-08dbfb286649
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 15:38:33.7694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TNJKWiOumMJgVVxWbzUE8SBB7sQoSNOU/4zZGHAOU4EflYakBPV+VB+NDRYtQuV7aQs8sPH69pH+NdziE4/u+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7260

On 12/11/23 23:37, Raju Rangoju wrote:
> Some of the ethernet add-in-cards have dual PHY but share a single MDIO
> line (between the ports). In such cases, link inconsistencies are
> noticed during the heavy traffic and during reboot stress tests.
> 
> So, use the SMN calls to avoid the race conditions.

So this patch replaces all the PCI accesses you added in patch #2, so why 
not just do this from the start?

> 
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---
>   drivers/net/ethernet/amd/xgbe/xgbe-dev.c | 33 ++++++------------------
>   drivers/net/ethernet/amd/xgbe/xgbe-pci.c | 10 +++----
>   drivers/net/ethernet/amd/xgbe/xgbe-smn.h | 27 +++++++++++++++++++
>   drivers/net/ethernet/amd/xgbe/xgbe.h     |  2 +-
>   4 files changed, 41 insertions(+), 31 deletions(-)
>   create mode 100644 drivers/net/ethernet/amd/xgbe/xgbe-smn.h
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> index a9eb2ffa9f73..8d8876ab258c 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> @@ -124,6 +124,7 @@
>   
>   #include "xgbe.h"
>   #include "xgbe-common.h"
> +#include "xgbe-smn.h"
>   
>   static inline unsigned int xgbe_get_max_frame(struct xgbe_prv_data *pdata)
>   {
> @@ -1170,14 +1171,9 @@ static int xgbe_read_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
>   				 int mmd_reg)
>   {
>   	unsigned int mmd_address, index, offset;
> -	struct pci_dev *rdev;
>   	unsigned long flags;
>   	int mmd_data;
>   
> -	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
> -	if (!rdev)
> -		return 0;
> -
>   	mmd_address = get_mmd_address(pdata, mmd_reg);
>   
>   	/* The PCS registers are accessed using mmio. The underlying
> @@ -1192,13 +1188,10 @@ static int xgbe_read_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
>   	offset = get_index_offset(pdata, mmd_address, &index);
>   
>   	spin_lock_irqsave(&pdata->xpcs_lock, flags);
> -	pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + pdata->xpcs_window_sel_reg));
> -	pci_write_config_dword(rdev, 0x64, index);
> -	pci_write_config_dword(rdev, 0x60, pdata->xphy_base + offset);
> -	pci_read_config_dword(rdev, 0x64, &mmd_data);
> +	amd_smn_write(0, (pdata->smn_base + pdata->xpcs_window_sel_reg), index);
> +	amd_smn_read(0, pdata->smn_base + offset, &mmd_data);
>   	mmd_data = (offset % 4) ? FIELD_GET(XGBE_GEN_HI_MASK, mmd_data) :
>   				  FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
> -	pci_dev_put(rdev);
>   
>   	spin_unlock_irqrestore(&pdata->xpcs_lock, flags);
>   
> @@ -1209,13 +1202,8 @@ static void xgbe_write_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
>   				   int mmd_reg, int mmd_data)
>   {
>   	unsigned int mmd_address, index, offset, ctr_mmd_data;
> -	struct pci_dev *rdev;
>   	unsigned long flags;
>   
> -	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
> -	if (!rdev)
> -		return;
> -
>   	mmd_address = get_mmd_address(pdata, mmd_reg);
>   
>   	/* The PCS registers are accessed using mmio. The underlying
> @@ -1230,10 +1218,9 @@ static void xgbe_write_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
>   	offset = get_index_offset(pdata, mmd_address, &index);
>   
>   	spin_lock_irqsave(&pdata->xpcs_lock, flags);
> -	pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + pdata->xpcs_window_sel_reg));
> -	pci_write_config_dword(rdev, 0x64, index);
> -	pci_write_config_dword(rdev, 0x60, pdata->xphy_base + offset);
> -	pci_read_config_dword(rdev, 0x64, &ctr_mmd_data);
> +	amd_smn_write(0, (pdata->smn_base + pdata->xpcs_window_sel_reg), index);
> +	amd_smn_read(0, pdata->smn_base + offset, &ctr_mmd_data);
> +
>   	if (offset % 4) {
>   		ctr_mmd_data = FIELD_PREP(XGBE_GEN_HI_MASK, mmd_data) |
>   			       FIELD_GET(XGBE_GEN_LO_MASK, ctr_mmd_data);
> @@ -1243,12 +1230,8 @@ static void xgbe_write_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
>   			       FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
>   	}
>   
> -	pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + pdata->xpcs_window_sel_reg));
> -	pci_write_config_dword(rdev, 0x64, index);
> -	pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + offset));
> -	pci_write_config_dword(rdev, 0x64, ctr_mmd_data);
> -	pci_dev_put(rdev);
> -
> +	amd_smn_write(0, (pdata->smn_base + pdata->xpcs_window_sel_reg), index);
> +	amd_smn_write(0, (pdata->smn_base + offset), ctr_mmd_data);
>   	spin_unlock_irqrestore(&pdata->xpcs_lock, flags);
>   }
>   
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
> index db3e8aac3339..135128b5be90 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
> @@ -121,6 +121,7 @@
>   
>   #include "xgbe.h"
>   #include "xgbe-common.h"
> +#include "xgbe-smn.h"
>   
>   static int xgbe_config_multi_msi(struct xgbe_prv_data *pdata)
>   {
> @@ -304,18 +305,17 @@ static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   		pdata->xpcs_window_sel_reg = PCS_V2_WINDOW_SELECT;
>   		break;
>   	}
> +	pci_dev_put(rdev);
>   
>   	/* Configure the PCS indirect addressing support */
>   	if (pdata->vdata->xpcs_access == XGBE_XPCS_ACCESS_V3) {
>   		reg = XP_IOREAD(pdata, XP_PROP_0);
> -		pdata->xphy_base = PCS_RN_SMN_BASE_ADDR +
> -				   (PCS_RN_PORT_ADDR_SIZE * XP_GET_BITS(reg, XP_PROP_0, PORT_ID));
> -		pci_write_config_dword(rdev, 0x60, pdata->xphy_base + (pdata->xpcs_window_def_reg));
> -		pci_read_config_dword(rdev, 0x64, &reg);
> +		pdata->smn_base = PCS_RN_SMN_BASE_ADDR +
> +				  (PCS_RN_PORT_ADDR_SIZE * XP_GET_BITS(reg, XP_PROP_0, PORT_ID));
> +		amd_smn_read(0, pdata->smn_base + (pdata->xpcs_window_def_reg), &reg);
>   	} else {
>   		reg = XPCS32_IOREAD(pdata, pdata->xpcs_window_def_reg);
>   	}
> -	pci_dev_put(rdev);
>   
>   	pdata->xpcs_window = XPCS_GET_BITS(reg, PCS_V2_WINDOW_DEF, OFFSET);
>   	pdata->xpcs_window <<= 6;
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-smn.h b/drivers/net/ethernet/amd/xgbe/xgbe-smn.h
> new file mode 100644
> index 000000000000..bd25ddc7c869
> --- /dev/null
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-smn.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * AMD 10Gb Ethernet driver
> + *
> + * Copyright (c) 2023, Advanced Micro Devices, Inc.
> + * All Rights Reserved.
> + *
> + * Author: Raju Rangoju <Raju.Rangoju@amd.com>
> + */

Shouldn't this license match the license in all the other files?

Also, you need header protection here, e.g.:

#ifndef __XGBE_SMN_H__
#define __XGBE_SMN_H__

and a #endif at the end.

Thanks,
Tom

> +
> +#ifdef CONFIG_AMD_NB
> +
> +#include <asm/amd_nb.h>
> +
> +#else
> +
> +static inline int amd_smn_write(u16 node, u32 address, u32 value)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int amd_smn_read(u16 node, u32 address, u32 *value)
> +{
> +	return -ENODEV;
> +}
> +
> +#endif
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
> index dbb1faaf6185..ba45ab0adb8c 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe.h
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
> @@ -1061,7 +1061,7 @@ struct xgbe_prv_data {
>   	struct device *dev;
>   	struct platform_device *phy_platdev;
>   	struct device *phy_dev;
> -	unsigned int xphy_base;
> +	unsigned int smn_base;
>   
>   	/* Version related data */
>   	struct xgbe_version_data *vdata;

