Return-Path: <netdev+bounces-71951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD608559AF
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 05:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1466CB237CE
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 04:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299F39476;
	Thu, 15 Feb 2024 04:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1nTFXC/u"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2083.outbound.protection.outlook.com [40.107.212.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401626FD9
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 04:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707970458; cv=fail; b=A8DObsHsFlKs4PNZ14MOfO8cKDY1mvNgYoYRZxEQeBit+5x8pbuKiPAxYfycZcu27i2Prkt0qlmkL/N22GMVGSeaxCKibLPAk+NZUQwkYM9OouepOTBdUMZu2u7m0pbRocaOeRm+jO9DG1CLkVOPndO2DrUC2y19TjcIeTfBrT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707970458; c=relaxed/simple;
	bh=9p+gktORETbG5s4arN+zJGswLiDNumevDXlpQPLS/68=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=imSlCOhSbRfGlN2cwBQZjI25Ne1DRiAPGHwtdCmwShgnDgzS9XBrk34wbUv9mVjVQrd9X9PyiwdRM6PClw/NKPto93IaSHsmkE9Edn0x9w3QKpqaYNUkWlagJymKweYU+X2gMbiBNgs3fdMBRlQHT1uyQpKtQwscyN3pWE8A8HY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1nTFXC/u; arc=fail smtp.client-ip=40.107.212.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHVw/wnMkEh/U3ZF1LgMu3F8ImoKRXAsaJc4ZY+IVjAfZlPPv2905bOHPrdC09RAXyUwttTVCK+kT2uP0aBrEJuNQK76HevIjeh1TUqJvTCQjfPFmC+fZs+LABISVye3j55wmGIl+OoDGLQQtUYDxVL3sj8j6z01CuBPQXYn/efTMnNBB1xvQ/NJLz97moox0xDIBEke5WSnJ5lo7xE+6Xl0+19XMuhAwLLGwQH0A+codbGTVTtgg7Y0SHEKWa1KAU8tvotn21KR/ufC2IgHE3KPXRSnmhiIub2jXLYfAKzRhddMtJhdA6nqXUDsuZFsxMX8e8ysboMeEuIqMLaxsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddfvvPbTvuahZ3zQAoEP7Vrmf8pCZfybWhYO1D3WyfA=;
 b=Y2+P4VXW2p1dJyesjfq6HKlg2XCcau+saK2LiGmilT4XGZOiaUhX8O3urLE6Mv21vyl3XmkaUeJqTDLz2tXC8kanoevVX/8FIV0g+5r+LhoTHWH97Xkg/4+rk4qS5JmyZ+ZmLzoQfiyV6pCQxv3Vowp65RgmOk3U5BDAiKdih5eaqvgQLpfWHvgdop6sW67xNMXX6CkXQp6Kow6VkWX2qDhKS4j3aWqzAfOJvIgcS2H0JrfLP8Cg4uO0ZFXZ3y6HBqgYfJZmygj6pUttjwoj6oQdzn8FWM7SjbcwCL62BPkMclKxWDT/4H9+L0aHJb+wM/d89EQl4tGCCOv6plRuoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddfvvPbTvuahZ3zQAoEP7Vrmf8pCZfybWhYO1D3WyfA=;
 b=1nTFXC/ulagV0q4AT6QrvrLe5jjTDZPSka6ZtABkpH+lAhah0zzPcX1j3WFiI/K59/gOc2D603VtKbW1OQSN0ZS7d81mDTAOVb71zOZAKeRydu9feoaT1JSmOXhmdGSwQKKpDQO1hSALxLBU/JPq43qmGSoePt7I2BXMqJp/+ks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 PH0PR12MB5677.namprd12.prod.outlook.com (2603:10b6:510:14d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25; Thu, 15 Feb 2024 04:14:13 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::e4b7:89f7:ca60:1b12]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::e4b7:89f7:ca60:1b12%4]) with mapi id 15.20.7292.022; Thu, 15 Feb 2024
 04:14:13 +0000
Message-ID: <e91243b1-a5d8-4b61-8674-6fa6400b10fb@amd.com>
Date: Wed, 14 Feb 2024 20:14:11 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 9/9] ionic: implement xdp frags support
Content-Language: en-US
To: Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, edumazet@google.com, pabeni@redhat.com
Cc: brett.creeley@amd.com, drivers@pensando.io
References: <20240214175909.68802-1-shannon.nelson@amd.com>
 <20240214175909.68802-10-shannon.nelson@amd.com>
 <1c64d64f-23c6-4efa-80d4-e39fdaf16280@intel.com>
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <1c64d64f-23c6-4efa-80d4-e39fdaf16280@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::32) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|PH0PR12MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: 480beb64-8b98-4ed9-e4b4-08dc2ddc915d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XtcbYYYTJHF7p0il5R7ARY2G7oakdmHc6JkdA10lqavhAMPL0GzcRU5Gk9bkRggUbOtDmaktYeqmHrV6SgRhcVRKBNo9wvF2bT0f9ChsUYO9LojEQUHR/dAJ0lLamRCbdwnuk0+VZU6zNubYofiGT0e1WYUUYHbv7Kt2saC6UxpSRqJaUMuXX09atzE2xmxro4KhOiRus2yyNJ8qKH3U/1FXEXt8t58j+Fv9t11HCtqTWsEjI6H+HsnvSVh4FSMcjlKXHo5375qN1wINbCiAr4mIDl4XiWOssFRxWWYihRCrGZfN+2SC5D374CEu8fOMxICaOyLzdAO85lBgOaYfP+tPK+jYfG1P1viwmLuztDV3MqX+41HgC2SzUVXewL1Fhk12zExlM/0LyiO5RiT7Mi+2+auxWaxPgXixxneRTA14bE1Vxs014iXgPdp3kHtRTJOM+WwSuW0M+t6u0/goGsbxECaHtImzokCFS3Ap4QMIKIUxbRIFc77AwoWK+bar2dW0U/R0z9PZ9lhfUDpaP1XwfjBVUdC3StjKEYd7tmGAoutogPVFK6QtfqkVuGeY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(136003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(31686004)(478600001)(6512007)(6486002)(41300700001)(5660300002)(8676002)(2906002)(8936002)(4326008)(4744005)(53546011)(86362001)(66476007)(66946007)(6506007)(316002)(66556008)(2616005)(31696002)(38100700002)(36756003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjBRY1ZVYXE1a0U1d1gvaEVDd2M3RmZHbks0NTNpYU5va043d3RBcGlENHg4?=
 =?utf-8?B?ak9oYlFvK2JVTGFxSkV4UlRUZEZ5dW0rbTl5djNoa210S0VIT2liVDBFVER2?=
 =?utf-8?B?cHNWN0JFa1FnSVg5ckt0elI4RzdpZUpzT1NUVG1LK2M4ZjVLTWhKMzFkNGFr?=
 =?utf-8?B?QWEvMlRFdmxHc3hkQ2UxazY4VDRXaVlxQm8yNXJ5NHIxNnRyNkdQQnZLWFUv?=
 =?utf-8?B?TDEzR3lEUXF3SUM4YjdrUnYxVk1jWTJwcXkxNGgyZDRVdW9VSnhlMTlzUU40?=
 =?utf-8?B?RVRqaGFpcm44RWFGdWVlSXlFT3U2N0o0disrMGlQeXVLZVhGRllMUXh6WHo1?=
 =?utf-8?B?RXlodWFvZERHemZUZ0RndTdDRWNmdUR0NDdPaXl0UG4xUzZmTER6UkNIZmZn?=
 =?utf-8?B?eTc0WVBkU2RheS9hWlgzMFRxTEhXcWpyV0o0eFFYUE1vNW5lVzd1UFZoWW1m?=
 =?utf-8?B?TlBWbzRGZXF2L1dWcGVadGpjZklFWkxUU2FBTmlranBHNkQxN3JuT0xZUHdU?=
 =?utf-8?B?eEdSU1NocTQ4MUU4dk4yRG52RWRDdWtPSGNhcFdVOTIyUG4zalg4RGlGUWdw?=
 =?utf-8?B?ZHhIUVBIcjZ5eit2M1pIT3BrNDNxT21FaFlrcU9iSkVsZnp0Y3ZyMFYvRVpT?=
 =?utf-8?B?dk9rREhJU2tJbitUblAvcGZRUnhTSjFRSVB4eVg5ck92REZ4ZDd0VUExNE5I?=
 =?utf-8?B?T3pHRlcxV1VwQU1lOTJ1aUpBS3JEdkVwVmxFRXNqSVVoUGdmUVhSTjNmNWQ2?=
 =?utf-8?B?QytlVXRla0ZTWHhUODJmQ0Z2OUFVSDZ1aEFjZEFqYi9iMWVNUUJmVnRjbTd6?=
 =?utf-8?B?NWZ6djFSUG5nMHIwbUV3aW13STE4c0IvNC9aR0hiRXFnRzBKYXIyb1o5YThj?=
 =?utf-8?B?VUZPeHowQk1wb3RSVnpvSlRvYXpQRGFoM1o2dm1nck84aWdIYlB1NVZJTXZH?=
 =?utf-8?B?ZWNQRk4vQWNXNk9ZZUFQekVqWE1TVjVmTEM1WEEzcXZOWk1sNDZvQjlwN29h?=
 =?utf-8?B?Q2R4L1F3QlR4dzExQ2JlVWw5UEVoYkFRenhlQ210VFV1Zmt1V0dPazhueFhC?=
 =?utf-8?B?dmU4NmlrMWpkZ29oN1JYK1BFQncvbmlJTHozOGtNeVRpMTNaclpiUkc4a2dv?=
 =?utf-8?B?SVNtNWtUZE85RU04SEVrWEYwRXdBUGVoc2FEakVoeTZHUytlZnFmZ1lnWXBS?=
 =?utf-8?B?bUlCMHpoMzdUZUQ3MFkwMVA3VlZDalJ1N05zb3htbXV4VG1IdEkvWDZCWWQ2?=
 =?utf-8?B?S0xtektORUJkaXFHdEhLUmZDWnp2c0Z0ZHFSNEUvTWROZHhGQVVvWlpqVnV4?=
 =?utf-8?B?TjhrRXNleVd5NnJUMDRQYzRNQUpZNU1tMVpaVFNaNythNk9zVi9wZ0g5REFT?=
 =?utf-8?B?MFZDems4VmJaUjhhcVBxWTkrNnBBNE0xbVN6WE5ic0t1a1l2Nm1iN3lhTnov?=
 =?utf-8?B?OVR0LzlKaXZ2Ynp0aUx1Sk9uZ1p2Wi80YUNBTjhDQTBncHJUbXBpY2hHY1JO?=
 =?utf-8?B?aXpPa2loRXFOV0kvRXkrOEo1SHVadW5MQVJSZXA1bGtsUWplL3F1Ujh4eU1z?=
 =?utf-8?B?THlRc25wZWpvMXVKMVVEbTFJbTFHUWJWSlhRczFTQlJIMUVaUktWeVlZaU4y?=
 =?utf-8?B?ZUJYU2hZN0RLeUQyN2FQY3phbTFaT1N3b20rVlJqcUtuQVdkajdrRkluaEJy?=
 =?utf-8?B?UFdTS0JFRWc0UzNySVZ2NVBQSHJ6QTdDYVMyY2xLVFdMQXFOUWZOMElVdTMw?=
 =?utf-8?B?TWJDZ1FTYkkzYUFpQUFvUm0xVG1MeEhtRkcwQy9DeURqWElXYWxTSG14NnFK?=
 =?utf-8?B?VGJ3SVA0WFdtdjl5Z0tHQno3NmQ2V0RaWFJsOTZkSG1BMmx4Tk94ajJHaEdO?=
 =?utf-8?B?YlBCZ2xOTW1PRTE1ODM3Q2pOVmkweWo5cHJ1UC8yQ1hLZDVySGFpeW5EejZx?=
 =?utf-8?B?YTBnR3FjQ2djMTVJZTJqZ3pWNXhmODBNWDRwUUhGVkQ5amRUUklNbUpTaXpr?=
 =?utf-8?B?OVBLdUtrUUNWRGM3MnM3OWVhWEM4NkdLSHVzV3RPTkRwWjVUZFh5SFprSmph?=
 =?utf-8?B?NVN5UFI2TkZVSWJ4OC9laFNDdlF1OHJWWllTN2JWNXVZdVczUXBwSndzYWpi?=
 =?utf-8?Q?y1traLEBtV9sdJydnbHBK2veY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 480beb64-8b98-4ed9-e4b4-08dc2ddc915d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 04:14:13.6615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPq291RkYFNLVmnsstalBAp2enp4SVHNchMA7RvnXS0R5Uhmc/q9T//FIvypupmXT98Awph9iJ6pMj6B02Ak1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5677

On 2/14/2024 2:06 PM, Jacob Keller wrote:
> 
> On 2/14/2024 9:59 AM, Shannon Nelson wrote:
>> Add support for using scatter-gather / frags in XDP in both
>> Rx and Tx paths.
>>
>> Co-developed-by: Brett Creeley <brett.creeley@amd.com>
>> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> 
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks, Jake, for all the reviews.

sln

