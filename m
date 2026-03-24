Return-Path: <netdev+bounces-271319-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJ0tMeMFw2lKnwQAu9opvQ
	(envelope-from <netdev+bounces-271319-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:45:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CC51D31CF9B
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A866F3052D15
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46390368972;
	Tue, 24 Mar 2026 21:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1v4AHM7J"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011025.outbound.protection.outlook.com [52.101.57.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD68366550;
	Tue, 24 Mar 2026 21:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774388609; cv=fail; b=hKJaC6mVOuIcnADUn5Hw0y6WSF9bj/mCxoFACs3oKe5BNdY8UxhtAtvCZdvD+0DLcZbDyl6pPDZW4BozAS14zXoeJ7NGcYjvnz/oS8604EpH3/v9uOOOhQ5QPQ1nCPacEFtJ4/GpiBHT/eMOijJ+HCcRwlI70QydbUVfc0jqAK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774388609; c=relaxed/simple;
	bh=KbaNMImu9pe3jsEFl4QUB8kWQiaG2Z3QO9bd0u6gEJ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f6b22eIBO9VtFvaYmghprsU3TyoMBkl1eqG7nyyxVDuoCPxwWGbMTIl1CuLJOG5/d78/AUpIOYuLCXVm85SdH++HqEmQk/0D3fLMBYESKixXIVE0iGHRUw3RluFUtvur3QVl34UqFzqhfJjTGpvdMIWcKmagHrNqiLRc6+LF8ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1v4AHM7J; arc=fail smtp.client-ip=52.101.57.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEN90TElrAKovvQ/ag/clMIDT22lN7QA/YTLPuLyVPOmzcxa5X0UnNRvYMl5iQ0MiRXiY/FLfWViZjWZ733Xm1qFTvRDcyhOtnjluGsx5/n1+lDgX3lX+wpCDZMUfjB+k0Yw/fKeX1WmIXKotkXz5zlJ32WgQd8qELwz4e/ZG+I86n/3/dPD08ilNUtVwM3ZtTAqrhBMQbf7Zw/8pwyvDBnKP3S9NUjDx9SZG2Q9gOSEj22Pm51kr3Ea3T3XMx+IifCF5WT/Pdrqm6bJb5Kt51pNzoFUBnyqW1zPBDqetianidTvvTBZKdUT4qxNzkyGNKS6YDNOac4nP7ED6C5uaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4U0lk8PLxuHgSqHvikn05nM/gSGgBHjOkWjJvEss6w=;
 b=S0AaMwacyZDiKWr4r6iobmiC27X9HsAbI1/aIrshQXxp6lfA0DPT+XSU5Pm1XughMmiuechgs4j9IIAijrRw5heOUwD/oRMA3Kf1Hro6i/+PTsAGPwxi6lS57E5nvhUD/LNK/n3weOvQQ0b8O/emsVtgj/rcCDXCOb/RIccm3RS/Gv0dPaOn6PGD4B5+HLx2SlzhUhgJh4eLT77GL+cyNBlegmfCmgYDS9Q8jOvmU+K5O6HB6x2YLE+57VwS9Grgvx3f8nxRk3iYt6DpkpAEWVA0GmRs19B2LndttFNvErZ2T3Oh+xS0l0ARc0OtNnMQaukQxdswA/sd2NMiZLSK5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4U0lk8PLxuHgSqHvikn05nM/gSGgBHjOkWjJvEss6w=;
 b=1v4AHM7JL/oGZjASE8CC/b2W0Yed8lfTbLFprq5Mbt2AFogmb8Pc7eKCTnhfs8EFIyMJOmVyL+O56p82NCz3gOrKNxgjwW6nhPFaLx+42oZGVtLhWyxy2ujw9Thjx1LTxCIpBYecuqnvy88gNGL3zch0xZPTExwOezFq0N5WGyQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 21:43:24 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 21:43:24 +0000
Message-ID: <c40e5106-838a-4977-bfa2-43b53561e72a@amd.com>
Date: Tue, 24 Mar 2026 21:43:18 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 09/11] sfc: obtain decoder and region if committed by
 firmware
Content-Language: en-US
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dave.jiang@intel.com,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 Edward Cree <ecree.xilinx@gmail.com>
References: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
 <20260323113117.2352709-10-alejandro.lucero-palau@amd.com>
 <20260324165655.00006ae8@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20260324165655.00006ae8@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0166.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::10) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM6PR12MB4235:EE_
X-MS-Office365-Filtering-Correlation-Id: 428c8d6e-bd45-457d-9e8c-08de89ee6060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JpfBIbm6WBih5/ov3lG4+fPKMO+ZYW1dIX/vq0dUATZOuLnx/JgP0xcG/IVuGL+VHW4lHLaiJmwYcOTf9S+PPOl4s9ol7WTFZKoAAdp+35p7v9iBlOb6axldq5ydI6ozfKGfs8dWtwEvB3mE9DPHQx5DbNYxBZuQlhkqhTG55mwnxxEfFwRSrhs3t8ePL6sRSBGY73KjnRD5z3dS4DX6fSI4WDaW1yjQu1bydkzPNjj2DCzHjgFGgnyUvIN2rOpynoSMCpQsTFKGdFt/LVKLb0kgOQb1MZmePF3+UZjpVVTWhwZ/lsgz5yCS5We9AUpICaG5Ed8tgKec1Nfb0PANrIYwL2s7P8PFYEU1gS1jCEQ14Xapx0b3SQZjkwrAzQ5llNts7DQR6rDFlud/1XK7kkE2DptQBWirxsfFCEo2wUT9o/rGnzod/paKczu+3KJCmkX/iBGgWzNOc3j9Yb9F06VLcho2N2WwdSFi0q7iEeuiYLH3+JEZl8gMAEEx/yNopQxGvpW7zvQgy4B3UjjBQyhHYgn/fs5UngYUorjt3BdNoMpZtuNXayWN5bECZI3wqmlVIYAHCv3my4ixOQeFEkSSeeDnmnC7UYer5odmlWJGdppNQmLKqRFDlP12KKHO0Lz04eevNHsrpV4O7B02CQGN2LqJ7dpkDzVBnT25sfiA+sSo7zb+XMf6U42AD6+dFe/NqOX5B+Loa4ZVAOZCR/4IE6Ndhn2Z51/mqKDF2s8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tk9aeGZGbklvV21mamY4RTRqVDUvbjZjZlJPN2ZiV3U2Z2s5WGlwYm1kZTFj?=
 =?utf-8?B?WHNkaUlHa3ZFaklzRWRYSVBmYUxLR0grdHg4NmlHb3Q4ODlaTkZDZGxxeS9M?=
 =?utf-8?B?TEQ5dll5NEliMDRsYk9rc09KZUFmYUJMa0VibUp1bzFIZlRmZjhDL1hISmVY?=
 =?utf-8?B?VXpvN25kaFdvM1JsaTVZanJMOU03MTFSRkxZeEhtYUxtNERyYTlhWEZtcDhm?=
 =?utf-8?B?MEFGZ0ZDRitoUkpwdEZPNWhnUkkveXN2QmxZM0dYMXhmUVVzVFRaNHo2WnRB?=
 =?utf-8?B?TUMyNDFkRUpyODNjZS95Z2JUdW1sZHJXUlM5THlPYkVtNEFaNkJOV0hna25Q?=
 =?utf-8?B?ZVJ6TVRFaXNFaldZTjgxaHpBTHVraytvRm5YVEJxeGhOYW4wWHVSeStUbG5I?=
 =?utf-8?B?WVkzNXhKMThzdW1HNCtrTVVBbk1WNHFPWjNNY0E4L1pkYjNyK3VWeTdIcmlE?=
 =?utf-8?B?cktsbmsxNm1SYkQzWmhpZmZsM1N1RWFFenF6dmNrcnE2dFpWcHEyQllwU1Yv?=
 =?utf-8?B?VGkxblZBQ0dPcloyUE41NlNJaGhEanltUmtMZDNXUHgrNU1tcjlYMk9sUlFa?=
 =?utf-8?B?L0xMZ2xJZ2xRam9waEptKzJvSzRqTW8xTHhQZ0ZvczhTVlh2NW43RHVqSDlI?=
 =?utf-8?B?SmhFZ2NJTXB1Vlc0cUlPSUp2OFMyZyttSzhLVTBEcStTY0ptMTZaYlJlTGYz?=
 =?utf-8?B?Tkw5UWxtVVljVFhobWRDYTVCNXpyWEdyOWwxTEV2UXFKcFJ4WU1wUlBuM3ZT?=
 =?utf-8?B?SWkwR2N0S3NWS0dRU29YajducUJqWnRITThXT0plN0F4cWQrdTU0Mi9GMmxX?=
 =?utf-8?B?ODNEdncySmNpc0llM09LcGdYWm4vU3JrK1h4UFhrZUQ1a0FTTlU3MWRLN205?=
 =?utf-8?B?TDF4UngrejNaTzlVaFl4TFpyNXd6NEFsZ2JWRHZPR3hUVGZnRnhidjRmSUl3?=
 =?utf-8?B?dzBjSGI3aU84MDZDeVBFRitMZFZpMHhiMjZ2d1NjdTJJMkRETVVPTlZJakdY?=
 =?utf-8?B?bzNoaXNLcTFaandUMXpTbjJOdURRSHcwK1QvbEtGVHlObjhnR2x6eWZIWXpU?=
 =?utf-8?B?YnRzdFZvRVYzeVVvT0x3eUhMLy9ndDlKZVU1dGM4Y3ZzMjFxZm9uK1hWMFM3?=
 =?utf-8?B?cDl4TkFCZklqZ2RITzZ3VXBET3RrMVpWOVUxQmRNc01LTWxFdHlCS3pJbzRa?=
 =?utf-8?B?QjRFT1krRmpxWDkxd3cvMzdIZ3p6NXZFcW0xZlZ2T2dMazZROHpFRDBsbzYv?=
 =?utf-8?B?azFjVFpoUEVNL0VBVDZyamkxTzg0SmxtajQzRmdUSmhSeVJpZDgwYi9PZnZs?=
 =?utf-8?B?Ynd2ZmFqb3g5dUFYTHkyZDh2L0NkOGZISE1ZOTZ3Z0ZGNEhPdU9CUTB2T0pk?=
 =?utf-8?B?U0RrbXRzSVI0eERjMktldjliNXhWT2VpcVhBNjZmUU5PNnZ5cXAwelJKWStE?=
 =?utf-8?B?R2ZDT0JsNUR1aVoxY09ia1ZyTzBkMUtsV1Jva2l0RWNOWkVvVCt5ODFjRzhT?=
 =?utf-8?B?UnNRTCtCSXBsNGZJbTAwakNNTmtIR0xxNWprZXVNMFRWRTlJWGd3ZWE1aHhV?=
 =?utf-8?B?UnY2a090ZkpuUUtXU0hvYWtjYlhQZWNIaXkwVVMxNVl6bmxhTFNJSzE2d3hm?=
 =?utf-8?B?ZVh5czI0ZEk3dHlWa1V0U0pmTXl1ajVhYmtNTXdIYVlEMVZpUU81OUc1UDQz?=
 =?utf-8?B?UDhRYlcxRjM1a3NtdnhMeFNETlBmMDBmdTJmNThlM2RqSS9Mc09aWGFsQXBI?=
 =?utf-8?B?aGVoSzkxekUvRHA0M09VaGkrREFWeUNMcGl4emVycEZ3aElRR0lraFBYV2J6?=
 =?utf-8?B?MHA5UmRtZmhtenhwYitUdXBILzlpbXh6RWpKNXF2RUM4YXhjM20zaG1FY0Nn?=
 =?utf-8?B?Vnh3VERxNjVjOVcrZDZweVZ5dm9KL2dGR0c1eC9vc2xQc2txcEJNY014T0po?=
 =?utf-8?B?bWJOYk50WUZKS1Z4R0JiL3VsN1B0bERkWkhOZUo0NEN1U09TWE9TaVRrM2Z1?=
 =?utf-8?B?ZGIwWnZ1YVpFbFEzaVJROWwwUUhPV3RoVDBHRjZWa3RpbitnTzM0eUNtc1hw?=
 =?utf-8?B?aUg5Q1JLU25GMkRtc3MyLzZqcDJxbTRrZ1NFdzhSdi94anlCQXdHcmN6cjF0?=
 =?utf-8?B?ZEd2VTY5b29EMys1V3lFQThXOWdSYUg2MlJhZS9XeE5acjQxRHluTTBkMFJl?=
 =?utf-8?B?YUtYWHptdGZaT1lLTnlKdk42WFRSN1J0OFhsSzg1TjJwM3ZrRHhLT3FUcFFu?=
 =?utf-8?B?bjhlQVR0VVhqcStTWS9id0ZzKzVGRGQ5RnZTYkcxQmRCNmxhMDVmZTVYUExp?=
 =?utf-8?B?NHhici9yVy9aVmt1UmhUdkR6UjB6ZS83dGczcU9kQTQ2OGlBL3FIUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 428c8d6e-bd45-457d-9e8c-08de89ee6060
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 21:43:24.6513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SN05kcagN8mkx+NGj6nyioVPlsWM3bmHKq0vBy6c3zt5Lxk22OjW1dgZamphF1leHhznLALCh5knSmJNQy+7fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271319-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,amd.com,davemloft.net,kernel.org,redhat.com,google.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:dkim,amd.com:email,amd.com:mid]
X-Rspamd-Queue-Id: CC51D31CF9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/24/26 16:56, Jonathan Cameron wrote:
> On Mon, 23 Mar 2026 11:31:15 +0000
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Check if device HDM is already committed during firmware/BIOS
>> initialization.
>>
>> A CXL region should exist if so after memdev allocation/initialization.
>> Get HPA from region and map it.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 22a7d1d95425..78f926300943 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -19,6 +19,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   	struct efx_nic *efx = &probe_data->efx;
>>   	struct pci_dev *pci_dev = efx->pci_dev;
>>   	struct efx_cxl *cxl;
>> +	struct range range;
>>   	u16 dvsec;
>>   	int rc;
>>   
>> @@ -82,6 +83,24 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		return PTR_ERR(cxl->cxlmd);
>>   	}
>>   
>> +	cxl->cxled = cxl_get_committed_decoder(cxl->cxlmd, &cxl->efx_region);
>> +	if (!cxl->cxled || !cxl->efx_region)
>> +		return -ENODEV;
>> +
>> +	rc = cxl_get_region_range(cxl->efx_region, &range);
>> +	if (rc) {
>> +		pci_err(pci_dev,
>> +			"CXL getting regions params from a committed decoder failed");
>> +		return rc;
>> +	}
>> +
>> +	cxl->ctpio_cxl = ioremap(range.start, range_len(&range));
>> +	if (!cxl->ctpio_cxl) {
>> +		pci_err(pci_dev, "CXL ioremap region (%pra) failed", &range);
>> +		return -ENOMEM;
>> +	}
>> +
>> +
>>   	probe_data->cxl = cxl;
>>   
>>   	return 0;
>> @@ -89,6 +108,11 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   
>>   void efx_cxl_exit(struct efx_probe_data *probe_data)
>>   {
>> +	if (!probe_data->cxl)
>> +		return;
>> +
>> +	iounmap(probe_data->cxl->ctpio_cxl);
>> +	cxl_unregister_region(probe_data->cxl->efx_region);
> When something called cxl_unregister_region() is called in exit() I look for
> where cxl_register_region() is....  and I can't find it (more than possible
> I'm failing to search the code though!  What is this undoing?


It obviously requires a comment for avoiding this confusion. The region 
is auto discovered when memdev is created:


memdev->port->hdm->region


so if the sfc cxl initialization was successful, it implies the endpoint 
decoder has an auto discover region which is the one we need to remove 
on exit, otherwise the region will be around until the root port is 
removed. That is something that maybe should change likely linking the 
region release to the endpoint memdev removal.


I will add such a comment.


Thank you


>
>>   }
>>   
>>   MODULE_IMPORT_NS("CXL");

