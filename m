Return-Path: <netdev+bounces-273112-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPPEFZJQymmb7QUAu9opvQ
	(envelope-from <netdev+bounces-273112-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 12:29:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F4C359464
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 12:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F61C3005747
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 10:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA6C3B52E0;
	Mon, 30 Mar 2026 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ek8Oajnq"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013055.outbound.protection.outlook.com [40.107.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26533B583E;
	Mon, 30 Mar 2026 10:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774866374; cv=fail; b=jfgKmZ6GySRFpvyVq0J7tY3TvQ16agIS6/czo9LuTOtwiadPYDMpM3CxI2sXKJFYvWHemjuRaFCYCRaFga1I0dp4k6Sa2oJs5mmpDOOpUuNCuILaQ1Re5qRDDmYpG912l00eMYSxa2zyf43aywSKyxF0ndc/clmL9O0UBxGshks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774866374; c=relaxed/simple;
	bh=YXoSlkswqFybAszwxLvFzTjJLAuszkmRr9gkMugRyPs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jSEZ1PrYejvhiHK/GJLVYqmdqQp4scKSH5kFd0eDiobP1MBpY1mtiavDKJSDmH21sBeUWCZGMj91YolVmbeXJFlqNtV4/B3bx3f/U6H7ZzSvpyWHXbSrY9kLM6LTuNBbr857MGaUMBfh4P7yWjEq577JDg29WstOItOoU3vU100=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ek8Oajnq; arc=fail smtp.client-ip=40.107.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VzWMHOPF8PXTw9sz+IuFqW0pjDnX1eJPk0wbEqWlCyJ4yyna5F0AniRHZrn0DPAzd9V0NS2gxmyokfwYFcRPNtjA7IoMxzdRrULtLYcxryGPAnz79iVHBcl/kq9/ys+49SYjXK0iLWJO3ccSptqLIct9dmiTfGTGYwcaFBDSc+grLvyHqgzo/bDCfq14diilfDWp9Lkg/slBO7OcJ1Wio1/Op5c/wCKMtg3BdY1EKltw7IoXo2WkfXtjB7c+KfoQw4HL9yP2xX7MgNV+tnYxYkurkEueLyHmo7j33zyAjD/jHqOcx0unqaqPcUCT1/73GBkKIsZ4X/c88uiAsULFYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxA/LJ9g3JwvCX4FnomPol/5KJx7/w5tqqlRvizVwQw=;
 b=kIsUWYXEYWMutb03lwIo+1S/+ObMifnZSyY5ggFGev9D4eX0uUpbYAC3MI561oNYhq8C+ag6J2Dm7ySEoZMCdov+gUJUmd2/lXDYih+g86k2nSw+PXOVEOlLgjm/7L3+oX5Uz8mMp3u8sb0Uyh2zQoY5+Xd2gArKfJQppIbKub95UR7+gaAF/bF91RT1+8FmPshoal2/JEjP2iwDPcaw1osSordTF6Or6N/eA9ryCrrmK/utc+IYI0WiM5LVivYQX85X9tbpFkAMX79AYhdsZX+pCJ2EBY9KlXPkGUfzP0ZyPTdXeMiVLBBr1drwEXD8WJTqjHp0+s229xSI/H8ZQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxA/LJ9g3JwvCX4FnomPol/5KJx7/w5tqqlRvizVwQw=;
 b=ek8OajnqqaRwg7qbX9Gb+VvYxP9DwCUhk8ZlrWHLRjCT+fHw3zvJXWqnyEJSiECoPMtWqy+UpTy+i6s3BXc8D6+7Y+w6NjGXf8vdQG0+QDknmg6xiHfEQJv3DuAqpREfLceuBctjbENWWaJu9nZ4XST24u7MwPfRNmuYkqB0yCE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS4PR12MB999075.namprd12.prod.outlook.com (2603:10b6:8:2fc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 10:26:10 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%6]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 10:26:10 +0000
Message-ID: <acb46d37-7835-4c9a-9487-e3c3e181136f@amd.com>
Date: Mon, 30 Mar 2026 11:26:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 06/11] cxl/hdm: Add support for getting region from
 committed decoder
Content-Language: en-US
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dave.jiang@intel.com,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
 <20260323113117.2352709-7-alejandro.lucero-palau@amd.com>
 <40f6ebb4-383c-4526-a526-c405a1c702ea@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <40f6ebb4-383c-4526-a526-c405a1c702ea@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0036.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::12) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS4PR12MB999075:EE_
X-MS-Office365-Filtering-Correlation-Id: 90fac730-02be-4396-935b-08de8e46c2be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	KVSnWftdPSuhPXEZATedfC0L7IYiVqU+ghIXe4OFqjzAJPA5GKP1L1YCb/T6RYDtshHXLjgd/3YjJm/cTL0zWDHBE1mAgLCSlv14Q/F6qpog91GUGwVy8oOnz4Z1SMpkAwk9ETCTvc+ZWccCAwRK+LIq9DEmN3wpvZ6jlpLUyAsADY9N+0q86mElepBU+/K98Ph3toZAcDc+G8Y9YuBiWVQAM58Kpq43Hx6DJS+f3MFHeIV4o3zCOqyRj716e0iOpg0T8zUn7eO8Z9aQKLd05odgzksH3LS9TXKCk4qDTF2BXL2svWa7ObW0Ln+U1zS6MB8sETJClr7zHL87x+j7ArP6xiNNiQB+P0KjCR/NlvrGsoHSFtxhf6ZeAOOUsvHfYn25cjUZnvETktfJIDnllHpg+J+qfVz+NCRWgh+ARTbmLAlIHrAP3p2rxjCQUp93OWDmzIAXVISyf4hjP/9YuXAJBvsXbmOOCQDkr6T1zh9VaQzzyfCyUvsr8dVubRVuf2gsxUJsb3FI9c09pf4jGWCY14W+nGrx9mxgjyBUeZcCuI8cOFmpYela3PTMKttQFZWeU70vLFpCFjzATqUufNKMrIuUGBemdvGktc12fMX+WjC70M6ECZ4cwoaWpl7w9j78Wc3MubJukDJEUlwEN3/HnpqJglZHRS1wffuajF6Sqy3nbNS5rHPDJgPJ6mh06ScIl/B//PBxu9OqYgVo8dYbpsnUZejtnd9AW+mcVJc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkF4WnBmN2hNWUhDRVBDUnhQZUMrdW1CYmlxaHJOV3JyNklEN1Z5QXluclhr?=
 =?utf-8?B?K1J0T3BIMjVhRHNKZlVqamc4L1RqRno2Sjg3L3ZJN1VmdGxwcHFpNTlqOVI1?=
 =?utf-8?B?Z292YVdsMUpsdTlON1k5QmxKYjBnV3B1azdpays0WW1qWHhuWUdOeDZkUmVm?=
 =?utf-8?B?Z0wvS1VqWWk4RkZUbWt0OWxwNCtEalZqTFYyU2pLZGpCd085RlFlcWRudUkv?=
 =?utf-8?B?SU56L21wdERlN3hCeWNPNmh2b0cxTzJFTGlOU2JPcjFYUHZZM25JTmlOMTFC?=
 =?utf-8?B?cW1QRXowSnlyQllna2UzZG9kdEduamlYMkF0bnlrVHpMMFhQUHBtKy9IbEw5?=
 =?utf-8?B?VGFIbnM3WC9uNnZPczExaXYrWjlXRCtpZU9FNGlwU1dVTm5jZWVxZkFLa3Zr?=
 =?utf-8?B?NnkweUNBR2pNR2FoelpTK1NhNEJiSEJ2RnB2S2c1NGZSNHAzTTlLeWxQN0lW?=
 =?utf-8?B?NG1GRjZVZjF1WXRmbkdRSWZBV2ZJcXRycVlBQ0FiYzAyT04vNmdlenVLV0du?=
 =?utf-8?B?bTVsZEZSSDQ1cXJORlk3c2pMc2ZHOXlpd0FTWkdJZ0cwWWpXRHprSUhlMXlV?=
 =?utf-8?B?dWs5dGc3bUVKci9BQ1dteW5PQ3hMbkpld1l2d3VxeWZrNEFVOEp5d3Y5UTlZ?=
 =?utf-8?B?TjhNcC9NUytLNDllOURMQWtOYTBZdFRZdk12V1huQk1kbFFQb1h4Vi9ha0pF?=
 =?utf-8?B?czFqUXRtaUo4bWVSR1BLNlMyaFFTU1lMeWhpRXh2RTFSTllGaEhFTWYrd1Bk?=
 =?utf-8?B?YWNjRXcwb2d1N1QwMzRXelhHcDZzU095eXpIV3gwSEtCZlVDWW9DcHk4b08v?=
 =?utf-8?B?Tk1XM3ZWaldDaEJmUjNvQ1JGOWlCVkhDK0UzMUwwQXJ1T1E3YktzVlhqOFZY?=
 =?utf-8?B?ZDVVd0Q0NmVINWhyaGdzVjVZaGtMTjJDUERqZUN5NkI1R0l6TTlUcUJiSGhu?=
 =?utf-8?B?N2Z2K2xXelY5WEllUU1LZXdaNE9jM0hmQjk1eE1URnVnOER0MzlRSGdqWmNh?=
 =?utf-8?B?ajdSVTRML2llWlEyTHRPMStrU3h2OXRnWEtuVzk1V0I0aVpQeVUyejZJelZB?=
 =?utf-8?B?blpCREMvNk9TaWM4em1mK1F6V2JVaWVuK25NR0xYWnJXSEZWeUI2N0lIVllp?=
 =?utf-8?B?NlBHQUJuWnZUL0xjalNGQkhzOFBUaTVhN09wQklnVE5XcWVzYUNNbCtJWWlF?=
 =?utf-8?B?NTM2cUVnRCtMOTJaTWFxc1BvOTZUd1ZJNkp2dklwWlZ2SWRScER0Ty83OFdm?=
 =?utf-8?B?dE1BQUdESGNrOFB6MFpCTTMvMHlUNld1UEVLYnFaZlladUx0RXFWVW9OQ3VS?=
 =?utf-8?B?aXRib25ob3U2cEZoNWRoT0N2bDllaGFYbEZsUDF1bXpRK3lMZUdJKzFxN01M?=
 =?utf-8?B?cEZPZHB0d2lsZEQxL2UvaFNuK041VE1vS0V3RkdSTGQ3YnhZZThqeEwxekxs?=
 =?utf-8?B?ZlFQUUw2QWYzUUpZZ0tQL3M3RkpmcElVYytqTlM1VmRYWmVTRXgyVzdtZmdm?=
 =?utf-8?B?VEh2MVlrTGhkTkZ3cEhFdWxTa2xGWjZIK0VoVGZqQzEvMitJN2Z6c2EybUR0?=
 =?utf-8?B?emZOa3B4U0xuZ05nckVoWkNySFMzY2k1WmovS1ljU3VXWDdqK2tWZDZmRFNW?=
 =?utf-8?B?MFlDVHFRK3JWTnpRbGxMSmtXUGJPYlRPM2htQjJJOW9GYzRQdDkzWU5XUlg2?=
 =?utf-8?B?UFA3cHAzRzVSUkwzSGVoNWd6VDN1QndnVjY3MjVMTy9lSFZ0bnZBYy9WU1Qw?=
 =?utf-8?B?eUtDV0hMUk02aDQxdjBtSE8yUkUvTE9ZUFpXeHNWckJHMlh3ekdybUVxd3p5?=
 =?utf-8?B?RW9nMm1UTzllSHRDbE56QzB2cmRTd29YNjI5RGUzVGgvSkhtNnZ4VkFkdGNi?=
 =?utf-8?B?OStPWE9uNTcxWmVzREpxaWFnVkp6WXZORExVUVhRTXlYeUpuMzBOclRBWjhk?=
 =?utf-8?B?MnpIM010djN4ajI4QmNCbVBIYWFjdkkzOEd5Tng1bmp2WDBzTWFWNGpCZ3RR?=
 =?utf-8?B?ckRlM3lpNFJyZWY2M1psNDA2WWp5amhIbkowQzZzS20xUHlNVnZPbHRLU0RV?=
 =?utf-8?B?a1NJcFNGNVZGcEJjSTEzTGYvRVU1MDU0QUlteTRBVGdub1VvRXlTcTU5eERq?=
 =?utf-8?B?ZDdFcjhPRC8xN3QyN0s1VEw3TWJjYW8wcm5XcVhycjlMbXBUMVRjUVNlWnVl?=
 =?utf-8?B?Q0tMNFg0MStLQmlhNll1ZU40eHNkWnI4a3d0c1NvMndHY21UNnBPSGVFditG?=
 =?utf-8?B?ZFk1cGRFakYvTE1YcklNM1ZhNy8veUl3cEdFb2hydVg1NTNHTGdHMFlNekVE?=
 =?utf-8?B?QmtKbHo3WEhMMFdYWXBJZlJSNHp6L1B1cVJhd205U2djWjZ0SC9vdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90fac730-02be-4396-935b-08de8e46c2be
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 10:26:10.4301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJ+fwsxo/L4CiDuFaQvs9S2M9y44fjpF/GAoUBWvAh6DTkaz1WwLnAifFjgoC7pZyylJS0e5gI+VldyzuK0FVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999075
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273112-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A7F4C359464
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/27/26 19:36, Cheatham, Benjamin wrote:
> On 3/23/2026 6:31 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> A Type2 device configured by the BIOS can already have its HDM
>> committed. Add a cxl_get_committed_decoder() function for cheking
>> so after memdev creation. A CXL region should have been created
>> during memdev initialization, therefore a Type2 driver can ask for
>> such a region for working with the HPA. If the HDM is not committed,
>> a Type2 driver will create the region after obtaining proper HPA
>> and DPA space.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/hdm.c | 39 +++++++++++++++++++++++++++++++++++++++
>>   include/cxl/cxl.h      |  3 +++
>>   2 files changed, 42 insertions(+)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index c222e98ae736..006be88efaa5 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -686,6 +686,45 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>>   	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>>   }
>>   
>> +static int find_committed_endpoint_decoder(struct device *dev, const void *data)
>> +{
>> +	struct cxl_endpoint_decoder *cxled;
>> +	struct cxl_port *port;
>> +
>> +	if (!is_endpoint_decoder(dev))
>> +		return 0;
>> +
>> +	cxled = to_cxl_endpoint_decoder(dev);
>> +	port = cxled_to_port(cxled);
>> +
>> +	return cxled->cxld.id == port->hdm_end;
>> +}
> I am still not convinced this is the right check. I have two reasons:
>
> 1. I would be surprised if just always taking the last endpoint decoder is what we want here.
> There's no guarantee that the last endpoint decoder is programmed to match the range, which is only
> now an issue since you're not looking at uncommitted decoders anymore. Suggestion below...
>
> 2. I'm sure it's possible, but I'm not aware of any case (outside of interleaving) that there
> would be multiple endpoint decoders above a singular port. So, it may be that the whole check is
> overkill and we can just cast the endpoint port into the endpoint decoder and be done with it.
> If the rest of the set hasn't changed from v23, interleaving is still broken. At that point,
> I'd say ditch the interleaving support for now and we can complicate all of this later.
>
> Suggestion: If you don't want to abandon interleaving or I'm wrong about the topology, checking
> if the decoder is committed by checking the HDM decoder registers directly is probably the
> correct way to do this.
>
> That gets you *a* decoder, but I'm not sure it's the right one. Getting the right one would require
> checking the resource attached to the decoder and verifying it matches the HPA range expected by
> the accelerator and/or region. I don't know if we expect the accelerator to know the HPA range
> at this point, in which case this is pretty easy. I have an inkling of what to do otherwise, but
> I'd need time to think it through.


I'm changing this code in v25 not using the current check but just if 
the decoder is enabled inside the helper function for any endpoint 
decoder child. This assumes there can only be one or just one supported 
what I think is fine for current expectations regarding Type2 devices. A 
type2 using more than one HDM will need its driver to support that.


Regarding interleaving, after your comments I decided the support was 
not consistent for the case of none committed decoder, so current v24 
and v25 are only covering the case of a committed decoder what is the 
expectation from current known BIOSes.


Thank you.


>> +
>> +struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
>> +						       struct cxl_region **cxlr)
>> +{
>> +	struct cxl_port *endpoint = cxlmd->endpoint;
>> +	struct cxl_endpoint_decoder *cxled;
>> +	struct device *cxled_dev;
>> +
>> +	if (!endpoint)
>> +		return NULL;
>> +
>> +	guard(rwsem_read)(&cxl_rwsem.dpa);
>> +	cxled_dev = device_find_child(&endpoint->dev, NULL,
>> +				      find_committed_endpoint_decoder);
>> +
>> +	if (!cxled_dev)
>> +		return NULL;
>> +
>> +	cxled = to_cxl_endpoint_decoder(cxled_dev);
>> +	*cxlr = cxled->cxld.region;
> I think the region type should be set already at this point, so I'd check it's set to
> CXL_DECODER_DEVMEM here as a sanity check.
>
>> +
>> +	put_device(cxled_dev);
>> +	return cxled;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_committed_decoder, "CXL");
>> +
>>   static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>>   {
>>   	u16 eig;
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 10a9b8fa2f6b..2a61138e2a73 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -231,4 +231,7 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
>>   int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
>>   struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
>>   				       const struct cxl_memdev_attach *attach);
>> +struct cxl_region;
>> +struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
>> +						       struct cxl_region **cxlr);
>>   #endif /* __CXL_CXL_H__ */

