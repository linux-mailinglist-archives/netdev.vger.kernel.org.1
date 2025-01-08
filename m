Return-Path: <netdev+bounces-156291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9F8A05EC4
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 15:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C834B3A7109
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 14:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B153139CF2;
	Wed,  8 Jan 2025 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NxSua1H8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F29155382;
	Wed,  8 Jan 2025 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736346750; cv=fail; b=AaO0HM3AhQ931lj5ywqkBRqLoTTmVBGp1tjl5GOokG0BS5v2l9kywGtp70l78XLk2slkIL/YwbSK6cKDXyjX+SfuYyY+eNwFfV3n//QGR9FRKLRI8YPQ/p3deNUqlb8tFwue5L6aPtqNzvYhWjyJt9pKFHkqugf7jOvgER3zD+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736346750; c=relaxed/simple;
	bh=q8tujhah7hCUwwfwhBm5OnwEPWiOoJtHLodlEerCyNA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HxUpHEkyzcND9JEiceWvbr2mrdp+WnauXIf8u314ResKAi+VdHVFzlE+x3rdX70D4TNxF2OlD/pH296xz8PyHhMDeJpnlIdrXUioVMnENEwa6lYRxvhhBZI+DobzELss0hTgiV3mPN0dGJDg08EpoU9mEQWIlk0zY/X1cUEvLb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NxSua1H8; arc=fail smtp.client-ip=40.107.100.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DbHooFQ+o/6XdOwQ/Qi3ewbCcexGl+mQJl1B2JB+fUywXgxzmCqZnKqNfFW/phFXxiWh4yXTArd8qoCodgSWxAo3kRubSA3zo8Xp3jsdYbv+qpD/OqPF3DCwHGTHF3dHUhlKd1o13YPbCETIwXiPD0QVrX/la8oKe3F+OeLIqxLEm9jh+aD+VZXSXoqhlZO70+FdIzPlbWtLBH2iw4JCI8v+0yRlKqf8iIk2eIjH+BRO5QgaXb7yQSidUku8xj2cKdfWdhRbkYHAsfSKCzmUKAJ5/gsVAC2XF6SsePhlxqAqd9nzbCYzslhDFByyIPkChjTRqwQOG8SEFi24c33TJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FiKPB52gG/0/sW8UAmrwIsojpeMW+Qpyt7kHJ/aN8Y=;
 b=uXe2zsm7ad9RlzWeNemeejxxCLFPsKSq3Nlyl1IuJHM6U6rIcVOXg4vB5aupMBLJwRTVFFcBYa5/ive32SCqnZ7pDxq2zJQ5szaTjIQObUHH+1X9CSU2x56W1oy+Ml7RrawEVW1z5+YYHSG5VWliN69R9TquXo0Hwus4y43SqI4itn5UqhtoKBkFx/6SLx0KhA1C0tS1JhRv9hsMwsWeAGHv8I+rRAVcUcKbk11ZfeP+EEhC/GVAQFzkaa4bxqloQVvwzSNf645QukIbBSFyazbcBpEHXf/J/IbHC0dOopcq1a58fvNz6t9QcKgpB+I5hFSdSwbIsZWPyglBAwCgDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FiKPB52gG/0/sW8UAmrwIsojpeMW+Qpyt7kHJ/aN8Y=;
 b=NxSua1H87WzT0IVXPQ3ZZTR3fQpdm5OvfZ7Va6KvzLiNsiyCh5HyAOZPK497hXyYIuBqn1vyPGSG1IAUhRwH4uU/0ssp9HWs9ySyy5hIOohmRJscMZM2MTcUt07s/aUEa7EscigV9/hlsFfoawGKkP4S1jua1KUi9E4LrezorHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Wed, 8 Jan
 2025 14:32:22 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 14:32:22 +0000
Message-ID: <c3812ef0-dd17-a6f5-432a-93d98aff70b7@amd.com>
Date: Wed, 8 Jan 2025 14:32:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 01/27] cxl: add type2 device basic support
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-2-alejandro.lucero-palau@amd.com>
 <677dbbd46e630_2aff42944@dwillia2-xfh.jf.intel.com.notmuch>
 <677dd5ea832e6_f58f29444@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <677dd5ea832e6_f58f29444@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0601CA0054.eurprd06.prod.outlook.com
 (2603:10a6:206::19) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ1PR12MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: 432a2a75-dd6e-46ff-cc65-08dd2ff14363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWI4US9oajNTL0wyM2c1ZXNOZ2pUQjRDaEh5VTZ6NnM1emgzZ0JoWWVLeWN2?=
 =?utf-8?B?d21mVDZKWHYwNFMxVSsxTWNRV3dXVXhZZm1JUDB1blNIVlRIZDI0cDNzejZR?=
 =?utf-8?B?ZzVJUmtBUkdLQjg1a0FMbSt3N0FMaitmdnBleUZYRCs3dlJsQlRtcVkvK3dL?=
 =?utf-8?B?MTRDbGJjc3JqQVRPUGxoMHdNOTdVWW1uU2dxd2hRTlArM2ZQS0dRb0k5cnJs?=
 =?utf-8?B?YTRNWHpuNUxwdUhiZk5FRjhGL3pjREk5SFNQLzBkdXJoQndWOVVuTERVWG4z?=
 =?utf-8?B?SVYxWjJLcVBlKytGQU9KdjRmNnF4TlZXeWdleW1taFA4d0ZlVWZzSWZPQjVT?=
 =?utf-8?B?cTNCR2plVjhzWXZrTDJDQXVYNFpxMG15SkVKdWUxU2p4Q0trWnNzNkFjWXZP?=
 =?utf-8?B?Q2NRcWxhOVdBNzl3ajBmdlRtMWsxaFcxV0JXVXZQTDAvL2lBaHp6cXV2UVBJ?=
 =?utf-8?B?NUY2R0VzcjYyd2VFcS8ydnNTOVJZTWlnV1QyaGFuWG9RVE5nTVhiUUZMdkhC?=
 =?utf-8?B?aXZiS1hxaHpSaWRpZjVMWFI5Njg1aGlaQ1poVEdqVkVQK3BhV09KV0tLWVZw?=
 =?utf-8?B?MTdqRmpsNkZWWk9nMzRSajcxNGJzd3ptSDMwU01FVlVzSkJZUnNwK3laV2Fi?=
 =?utf-8?B?a3hjdXBIUkVRb01HS3V5eHBwTyt1QWhnbW80T0Q2Y2MwMHRwYlkrVDE1WXVB?=
 =?utf-8?B?SnlON0pnK2xVRWVFNXpIVytNQnpNaXZWR3NVV2tDVG9ndHRwWU12NXhaeWx2?=
 =?utf-8?B?MTR5SUhNOHhITE9hLzRQdDlqU1VUSmVRVVZCKytTbGo4dHhUV3lydWNNRkVT?=
 =?utf-8?B?cjI3Yy9uUmhzMnhPOWZ4dzRDZ0FoZGRWY05YcDBrZStWZ0xJK2ZMS0ZzZmQ0?=
 =?utf-8?B?QXVCWVZHRnNHQ3dRY0F6WXA0R2Q4Z3dwSGdkbmhFUjdtV3RyTXlPVHI5L3Fu?=
 =?utf-8?B?emU4TU5sMEYvNlhhWVFyM2Jub2FzQm5VVXdaci80TWk2OFZIZFQ1ZHNVUSty?=
 =?utf-8?B?dmZTT0hOb3lhc0tZczM3WFFCL3FSSjVhZUxEVW4weUZ6bVRKNWxpQkI4MFk1?=
 =?utf-8?B?a2NkT3labHh1cWJwOGZ0VHRCY3BIUjlLdGovMnJkdVlaejBGVEJ6dVh1WUV5?=
 =?utf-8?B?Rmt6MTBGT2k0aGRKbS9zTHcrU3ptSDNKNHp2UXZOaVFOWkdlOUhPanUxNzNF?=
 =?utf-8?B?NzgrQjEybHhoeFl3UFFTWTlncHpmemd4cjIvU29IcnlDY2wvOGN0SHZVcTI5?=
 =?utf-8?B?ZysxZTZob3hsK2ZYTmpBU3IwNUFtd0hsWGJ2R28vOTJ5b0tTU1JZM2EwRm1D?=
 =?utf-8?B?ZExpRjVJUGl3UzZ5L0haZzBueDVVaEpoUXpxYnRsYk1jVTllS3NQbFk1REQ5?=
 =?utf-8?B?OVRzSm9GbU9Nbnp6TlF2TURGdlBqaGk1RDRkbW0yR0JvdW1razB5cUxYZzBu?=
 =?utf-8?B?ck5lSHN3aC9LRnFRNDlQc2VsSFp2Zmw4b2RIQStMcmU1eDB3QURZY2RsTHVI?=
 =?utf-8?B?VXcyUnd4cVZyNlpreEprb1VwSW9aRW52MjMyTUN3amhSTlljNEtldTlOTFAr?=
 =?utf-8?B?TjhmTlorZUpsT0RTVVlmZjBvN050S2xESUxyUEZTYks1LytnbXdxRE90c0pN?=
 =?utf-8?B?S2xpeEtmc1Y5aktnejJjRG9MVHAralR5TVJGdXkrUWtSeE41VUwzdVFmZFU1?=
 =?utf-8?B?enJ6eFVqemhpRlc3Z3hXRXNqQUkyTjRPQnFuL2xTWWZ0bFErK0hMQnpMb2Z5?=
 =?utf-8?B?MGhmZmd4TUJhbEZDVFExdk4xclAzNHh3UkFiaW0zVHhHUWtUT3FBR24xeDFn?=
 =?utf-8?B?STFzeXhoMTVtZWppVDg4ajZ2UGJ6bUo4RG1QVnBIVjVjWW9hejVXMXZuRTd4?=
 =?utf-8?B?dlhlT3dKN2U4amxjUDEwNDBXdW5IRTR5Z0lPTTFFQW1zR09ld0lBd2xYTml2?=
 =?utf-8?Q?Xfz7emLibOzgLcyx4zdtY0mqY8EFyCr7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WW9zVjEvS0xORG5KMGo2UUtlV1VVMHVNWUpOOVUydXlTNFl3Z2tTZEZUS216?=
 =?utf-8?B?OWRZOFpzRXk3UEFYam43VWZJb01tREU0bkdRc0hNY2haWGUwOGdQWUdKNG4r?=
 =?utf-8?B?am5XM3BYMEFXQzFucjJsT1J4MjdQWlBhWkxsL2FFRXM1RWpoR1UvcnBIRXZV?=
 =?utf-8?B?UlhnNXozWldtdTQ4RWdLRmkvNzdpRTFZSnRwcFJydDhEN2JkTjRMV0t5emlj?=
 =?utf-8?B?bDNBOHRUa296bmVPK2VqZlBSZmJBcEtFa0dEK0Y3K1dEZTZrendpUkNUcGFi?=
 =?utf-8?B?SU1Meml4cGRnSDRINmQ2V1RmZTNNaWNYTEdXN2xRL0p6K0xxTld3eElwYzFp?=
 =?utf-8?B?b3FjS3RSeEViYVJvUXhWb2UzREl5YnZFLzRPTDU4WVFtRE1ORFlDUFFtcVYv?=
 =?utf-8?B?VlgwdVM4WlRTKzhIaXgyL3VBckdKRXc3b2lrWDFEamp6KzUwMSsySVZRL1F1?=
 =?utf-8?B?K1hiZDN3OGRSdzdSaCtYRDJRTWxpOFZ0U1ZrSm1OUnhwREJXZmFCZFpQTERv?=
 =?utf-8?B?bkhpOGRKNDRJb2xyalZGY29kREJkSnBVV0FiQU5JU0xzTkxEemdsLzNoSm5i?=
 =?utf-8?B?TjFkSFd5Y1JtMEowOWFKK1JMSUVxeVoreXFEcGZWcTI2dXptcE1pdHEwUWpj?=
 =?utf-8?B?anVCbHBWdWFiZ1FnK1MwL3pOUDVXdjZWdWc1LzVRZXg0UWwzdUNkMnJaZ0dD?=
 =?utf-8?B?bE1XTVVQbml0bk5oVThkVisvaE1zcVZ3N1MzbWMrRjA2aFYrc2hTTEFMdUJX?=
 =?utf-8?B?aXo0VGEvaGtxbUlhOWZxZ1FabWFCdXdNd1EvZ1VMNXdYV2h0aDRJbVhXck5D?=
 =?utf-8?B?dVF5WGRndU1HOWJLbGdBdzJJQzk2TW9ZM0xGdy83TGZGOVB1TWNNQTVweERD?=
 =?utf-8?B?NkluZzBHbEMyM3o2SGNKVDVta0trUjFEMzhzSDF4a0NWY2pPTnZydGRvVDFl?=
 =?utf-8?B?Mm10QklMbitMK3dvTmNSRkVYR3NKaXVWYkMvekJMdzNGOWUvRmx3WXVKd0tz?=
 =?utf-8?B?blZUQ2VvNFN3UndZS1NaK2puWkxqcXpyajVPUHVRbVFLUlFLLy83blBMOGpR?=
 =?utf-8?B?NlZMc3dLbGJUSEI5aGJlNDNSNWxoand0N3ZydTBweUJBUThhbjYvL3RxZVFM?=
 =?utf-8?B?Z0UzcWl1ZFVEMTVacW9RV21pRGlCMStndUZBdUNpV1BHazdUNHoxM293NUhJ?=
 =?utf-8?B?N2FQY0Y3MTRrL2hzbk9iSlhQY1lNSUVxQXYxSDFlUm9NSDNnSHM4dVNJSklN?=
 =?utf-8?B?QlpCYTlHRGIyMHN3anQwN2pCWDlpTHBpREFCV00yVU1YNkR5T3V4N0ZXYmE4?=
 =?utf-8?B?SVBPZllKNy8rZ3BpNVVySzFHR241aDJsZU9WelpZZ1M4RDBBenZrVWlCaytO?=
 =?utf-8?B?dmNlS01DWmdHazV5QVlySlg2d0dicnpOZ3ZZTW05dkRFSWxkclhsbnJ0SS9G?=
 =?utf-8?B?TFZQem8veDdwZ2YxYzNLdVBmV0xyZUVMY1VLR3BlYjFnbFU4MVpZaHBJUXFK?=
 =?utf-8?B?QnFMZmJyU2xzamlJMmlOT2NVSW5iOUFnVnZ2SXpuVzNCeFdmTkgwbUxhaExY?=
 =?utf-8?B?ZlFkdVhjL2JFS1V0V2Fmd0lWdUlGOVgvcnZqNXBsNHVXM0cwbFgvejAzTFMz?=
 =?utf-8?B?S0dLdHRjM21OSS9vY243TFR4cS85ODBGcDhVaDVyUTZPMGVsWXpjQ2xWQXNE?=
 =?utf-8?B?Sit3Y21XQ2psZnU1Ny9Jc1k0cjBDOHdqeUt5eld3K2lScDNTSkRybzdPcTBu?=
 =?utf-8?B?bVJ1MENoaGdLaU9LRHpiMnpmY0xwckRIdnBkSFk1UkhJRXZ6Rnplc0ZCOU0v?=
 =?utf-8?B?dmt4VzZDdVFUSGRxNkFxM3oxSUdXa1RHTkorZzBvdysweHNEbEg0QzN4ODFK?=
 =?utf-8?B?WWtxNzE1a3RMTTBxZTZHbUJkVzY3WitCVTgrSStBaTBKOFBFaUFSQ2xhUmN6?=
 =?utf-8?B?dThXRk1XQmg3NFZwN1J0UWVjbDcrTVZXRGtYcFZBZ2J0ak10cWN2end5bGRE?=
 =?utf-8?B?VDhKTjNFRytpb3FQNS9iZVFRRGVxeis5VlFnZFc4VzQ1RXVPTUJtSE1XU3JL?=
 =?utf-8?B?TWxDOFB3SFJ6VklQUXkyai85QTNVQUhxaXdDOU9sWTRhRzIyVXd4Wk42TXJI?=
 =?utf-8?Q?U1qZfux7PQK0lksLvNgPOAiar?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 432a2a75-dd6e-46ff-cc65-08dd2ff14363
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 14:32:22.3373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JeBi0e7moT2AzUvnZyOTMs183rVTDi2vQsgUtkFKrBFqrhO47rO3lBcCe8xpEZi2X7SRgPtDd7zIOdogKiItcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6121


On 1/8/25 01:33, Dan Williams wrote:
> Dan Williams wrote:
>> alejandro.lucero-palau@ wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> Differentiate CXL memory expanders (type 3) from CXL device accelerators
>>> (type 2) with a new function for initializing cxl_dev_state.
>>>
>>> Create accessors to cxl_dev_state to be used by accel drivers.
>>>
>>> Based on previous work by Dan Williams [1]
>>>
>>> Link: [1] https://lore.kernel.org/linux-cxl/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>> This patch causes
> Whoops, forgot to complete this thought. Someting in this series causes:
>
> depmod: ERROR: Cycle detected: ecdh_generic
> depmod: ERROR: Cycle detected: tpm
> depmod: ERROR: Cycle detected: cxl_mock -> cxl_core -> cxl_mock
> depmod: ERROR: Cycle detected: encrypted_keys
> depmod: ERROR: Found 2 modules in dependency cycles!
>
> I think the non CXL ones are false likely triggered by the CXL causing
> depmod to exit early.
>
> Given cxl-test is unfamiliar territory to many submitters I always offer
> to fix up the breakage. I came up with the below incremental patch to
> fold in that also addresses my other feedback.
>
> Now the depmod error is something Alison saw too, and while I can also
> see it on patch1 if I do:
>
> - apply whole series
> - build => see the error
> - rollback patch1
> - build => see the error
>
> ...a subsequent build the error goes away, so I think that transient
> behavior is a quirk of how cxl-test is built, but some later patch in
> that series makes the failure permanent.
>
> In any event I figured that out after creating the below fixup and
> realizing that it does not fix the cxl-test build issue:


Ok. but it is a good way of showing what you had in your mind about the 
suggested changes.

I'll use it for v10.

Thanks


>
> -- 8< --
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 548564c770c0..584766d34b05 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1435,7 +1435,7 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, "CXL");
>   
> -struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
> +struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial, u16 dvsec)
>   {
>   	struct cxl_memdev_state *mds;
>   
> @@ -1445,11 +1445,9 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>   		return ERR_PTR(-ENOMEM);
>   	}
>   
> +	cxl_dev_state_init(&mds->cxlds, dev, CXL_DEVTYPE_CLASSMEM, serial,
> +			   dvsec);
>   	mutex_init(&mds->event.log_lock);
> -	mds->cxlds.dev = dev;
> -	mds->cxlds.reg_map.host = dev;
> -	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
> -	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
>   	mds->ram_perf.qos_class = CXL_QOS_CLASS_INVALID;
>   	mds->pmem_perf.qos_class = CXL_QOS_CLASS_INVALID;
>   
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 99f533caae1e..9b8b9b4d1392 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -617,24 +617,18 @@ static void detach_memdev(struct work_struct *work)
>   
>   static struct lock_class_key cxl_memdev_key;
>   
> -struct cxl_dev_state *cxl_accel_state_create(struct device *dev)
> +void cxl_dev_state_init(struct cxl_dev_state *cxlds, struct device *dev,
> +			enum cxl_devtype type, u64 serial, u16 dvsec)
>   {
> -	struct cxl_dev_state *cxlds;
> -
> -	cxlds = kzalloc(sizeof(*cxlds), GFP_KERNEL);
> -	if (!cxlds)
> -		return ERR_PTR(-ENOMEM);
> -
>   	cxlds->dev = dev;
> -	cxlds->type = CXL_DEVTYPE_DEVMEM;
> +	cxlds->type = type;
> +	cxlds->reg_map.host = dev;
> +	cxlds->reg_map.resource = CXL_RESOURCE_NONE;
>   
>   	cxlds->dpa_res = DEFINE_RES_MEM_NAMED(0, 0, "dpa");
>   	cxlds->ram_res = DEFINE_RES_MEM_NAMED(0, 0, "ram");
>   	cxlds->pmem_res = DEFINE_RES_MEM_NAMED(0, 0, "pmem");
> -
> -	return cxlds;
>   }
> -EXPORT_SYMBOL_NS_GPL(cxl_accel_state_create, "CXL");
>   
>   static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>   					   const struct file_operations *fops)
> @@ -713,37 +707,6 @@ static int cxl_memdev_open(struct inode *inode, struct file *file)
>   	return 0;
>   }
>   
> -void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec)
> -{
> -	cxlds->cxl_dvsec = dvsec;
> -}
> -EXPORT_SYMBOL_NS_GPL(cxl_set_dvsec, "CXL");
> -
> -void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial)
> -{
> -	cxlds->serial = serial;
> -}
> -EXPORT_SYMBOL_NS_GPL(cxl_set_serial, "CXL");
> -
> -int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
> -		     enum cxl_resource type)
> -{
> -	switch (type) {
> -	case CXL_RES_DPA:
> -		cxlds->dpa_res = res;
> -		return 0;
> -	case CXL_RES_RAM:
> -		cxlds->ram_res = res;
> -		return 0;
> -	case CXL_RES_PMEM:
> -		cxlds->pmem_res = res;
> -		return 0;
> -	}
> -
> -	return -EINVAL;
> -}
> -EXPORT_SYMBOL_NS_GPL(cxl_set_resource, "CXL");
> -
>   static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>   {
>   	struct cxl_memdev *cxlmd =
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 2a25d1957ddb..1e4b64b8f35a 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -4,6 +4,7 @@
>   #define __CXL_MEM_H__
>   #include <uapi/linux/cxl_mem.h>
>   #include <linux/pci.h>
> +#include <cxl/cxl.h>
>   #include <linux/cdev.h>
>   #include <linux/uuid.h>
>   #include <linux/node.h>
> @@ -380,20 +381,6 @@ struct cxl_security_state {
>   	struct kernfs_node *sanitize_node;
>   };
>   
> -/*
> - * enum cxl_devtype - delineate type-2 from a generic type-3 device
> - * @CXL_DEVTYPE_DEVMEM - Vendor specific CXL Type-2 device implementing HDM-D or
> - *			 HDM-DB, no requirement that this device implements a
> - *			 mailbox, or other memory-device-standard manageability
> - *			 flows.
> - * @CXL_DEVTYPE_CLASSMEM - Common class definition of a CXL Type-3 device with
> - *			   HDM-H and class-mandatory memory device registers
> - */
> -enum cxl_devtype {
> -	CXL_DEVTYPE_DEVMEM,
> -	CXL_DEVTYPE_CLASSMEM,
> -};
> -
>   /**
>    * struct cxl_dpa_perf - DPA performance property entry
>    * @dpa_range: range for DPA address
> @@ -411,9 +398,9 @@ struct cxl_dpa_perf {
>   /**
>    * struct cxl_dev_state - The driver device state
>    *
> - * cxl_dev_state represents the CXL driver/device state.  It provides an
> - * interface to mailbox commands as well as some cached data about the device.
> - * Currently only memory devices are represented.
> + * cxl_dev_state represents the minimal data about a CXL device to allow
> + * the CXL core to manage common initialization of generic CXL and HDM capabilities of
> + * memory expanders and accelerators with device-memory
>    *
>    * @dev: The device associated with this CXL state
>    * @cxlmd: The device representing the CXL.mem capabilities of @dev
> @@ -426,7 +413,7 @@ struct cxl_dpa_perf {
>    * @pmem_res: Active Persistent memory capacity configuration
>    * @ram_res: Active Volatile memory capacity configuration
>    * @serial: PCIe Device Serial Number
> - * @type: Generic Memory Class device or Vendor Specific Memory device
> + * @type: Generic Memory Class device or an accelerator with CXL.mem
>    * @cxl_mbox: CXL mailbox context
>    */
>   struct cxl_dev_state {
> @@ -819,7 +806,8 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds);
>   int cxl_await_media_ready(struct cxl_dev_state *cxlds);
>   int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
>   int cxl_mem_create_range_info(struct cxl_memdev_state *mds);
> -struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev);
> +struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
> +						 u16 dvsec);
>   void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>   				unsigned long *cmds);
>   void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 36098e2b4235..b51e47fd28b3 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -922,21 +922,19 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   		return rc;
>   	pci_set_master(pdev);
>   
> -	mds = cxl_memdev_state_create(&pdev->dev);
> -	if (IS_ERR(mds))
> -		return PTR_ERR(mds);
> -	cxlds = &mds->cxlds;
> -	pci_set_drvdata(pdev, cxlds);
> -
> -	cxlds->rcd = is_cxl_restricted(pdev);
> -	cxl_set_serial(cxlds, pci_get_dsn(pdev));
>   	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
>   					  CXL_DVSEC_PCIE_DEVICE);
>   	if (!dvsec)
>   		dev_warn(&pdev->dev,
>   			 "Device DVSEC not present, skip CXL.mem init\n");
>   
> -	cxl_set_dvsec(cxlds, dvsec);
> +	mds = cxl_memdev_state_create(&pdev->dev, pci_get_dsn(pdev), dvsec);
> +	if (IS_ERR(mds))
> +		return PTR_ERR(mds);
> +	cxlds = &mds->cxlds;
> +	pci_set_drvdata(pdev, cxlds);
> +
> +	cxlds->rcd = is_cxl_restricted(pdev);
>   
>   	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>   	if (rc)
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index aa4480d49e48..9db4fb6d2c74 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -4,21 +4,25 @@
>   #ifndef __CXL_H
>   #define __CXL_H
>   
> -#include <linux/ioport.h>
> +#include <linux/types.h>
>   
> -enum cxl_resource {
> -	CXL_RES_DPA,
> -	CXL_RES_RAM,
> -	CXL_RES_PMEM,
> +/*
> + * enum cxl_devtype - delineate type-2 from a generic type-3 device
> + * @CXL_DEVTYPE_DEVMEM - Vendor specific CXL Type-2 device implementing HDM-D or
> + *			 HDM-DB, no requirement that this device implements a
> + *			 mailbox, or other memory-device-standard manageability
> + *			 flows.
> + * @CXL_DEVTYPE_CLASSMEM - Common class definition of a CXL Type-3 device with
> + *			   HDM-H and class-mandatory memory device registers
> + */
> +enum cxl_devtype {
> +	CXL_DEVTYPE_DEVMEM,
> +	CXL_DEVTYPE_CLASSMEM,
>   };
>   
>   struct cxl_dev_state;
>   struct device;
>   
> -struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
> -
> -void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
> -void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
> -int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
> -		     enum cxl_resource);
> +void cxl_dev_state_init(struct cxl_dev_state *cxlds, struct device *dev,
> +			enum cxl_devtype type, u64 serial, u16 dvsec);
>   #endif
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 347c1e7b37bd..24cac1cc30f9 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -1500,7 +1500,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>   	if (rc)
>   		return rc;
>   
> -	mds = cxl_memdev_state_create(dev);
> +	mds = cxl_memdev_state_create(dev, pdev->id, 0);
>   	if (IS_ERR(mds))
>   		return PTR_ERR(mds);
>   
> @@ -1516,7 +1516,6 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>   	mds->event.buf = (struct cxl_get_event_payload *) mdata->event_buf;
>   	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mockmem_sanitize_work);
>   
> -	cxlds->serial = pdev->id;
>   	if (is_rcd(pdev))
>   		cxlds->rcd = true;
>   

