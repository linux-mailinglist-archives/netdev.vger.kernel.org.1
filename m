Return-Path: <netdev+bounces-212254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD59B1ED88
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 18:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5076D5A3841
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 16:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FDB287261;
	Fri,  8 Aug 2025 16:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TBWi2pC2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2851A274B29;
	Fri,  8 Aug 2025 16:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754672391; cv=fail; b=Qq/AJnv8mwb1+tudR4IRTw32PzQcz2yubEXA/Ugeg3rTsVHhVjXNdopaKzxEWD+XIHVdn6RoJXz+EM6sOvL3BEGn2NvnlprWN7CtIKXU8XTwiwxhBFXr+4UMNJwwzNcglrxZYHOo0DNCbUcJYiTMt8VgtHVdTfpdHWAf2l9SFag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754672391; c=relaxed/simple;
	bh=gomFIrF3EIPKVaci4ZhIBHVZ3h1XrULxooBnIIRRjSs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kvu/SyBWGgA49jTLnvNOZBpKxBM5Wst8dp+4Ot05diPZmjMcHCmu1eprjWnh3tU8Svv8eRYsxBhx8sdzT3jlmP4oZ8fjxuBwUTNWr1V3L5yNc/6zCAMq/KNavS8AtLC4F5GJ80feKBV2/jD6vYgh8T2lcg+Rh0VitCppbmf9C6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TBWi2pC2; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KlEmBcEuDh4hEQxZjyLatw4oDzoGvHcvcFJnor/hm4RcMPW+2EewX01cuQdu1egI33dDGkFndBrP5ZcUp3hlDI9FYzJaslHLyshK/UQDA0JU8bWtFiqpM2N9oOs9YItFI8XzTpwc5uZosI2tnrPZVR9tblulLoW+CGAmeXxmsGJQEMTaPbTVmiVHQt+t04wlHI7qPa1aWVa+VPhFDl+8Eh8rYqPFlmwZ3msCCc18Z5bfETAgzUtutbyBAdHiaEdTr126S9ghkDuM+XSLON0IewQbyAvjxwFjIioAfIBOToDiDdOFd/cZleqCfQYgIKkIsgQRMRSVCt/d6ykRCRGptw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e226wZ5F/ihFu8eWWu5W9cWMkkNCT1f9AUsbctYWQ+Y=;
 b=GcH4I+V519d8jIePIniUHU8aleGlj2dPdlZOOO3vGRkXCK1yLK0jki9NIUWeRRhdLB7nrgudnJCR6OUpGvhs8WRGrGw2dK6GQFHVGMqB7cbqiF7PunQ966eWHB+DC4YCYIbio5+aSUU9eEem/T7KHH4I9hIrA+8HPCQDQUVjBdhYtVWALABPRFa5hsi/9K/mehgIFfpwugYJ6A1NUg8wcMctf/HmEqNbIJzk53PK4CMUG4ORbqq11FRbSQmDo5XKYvv7S7feIXVf09J4/oXBiFrcWwVZNvNkALC7ZT86UTg/BdhuTUZIj4J5Ylw2/dQ5ThFRjmKpf9R1NqEVT55JDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e226wZ5F/ihFu8eWWu5W9cWMkkNCT1f9AUsbctYWQ+Y=;
 b=TBWi2pC2Ti/5jaE4naNYc/IlOdux9H6MlgNTjXdatBr2eoLMyjmsAh4b1zoGdf8B4mDCOnOkxCdpGnBREp2hBKFh//BqvHd32A0NI6o413S9y+//YFw690DwJlH5L8NxJLtZyAAwWepwHfagbnk7VHEbkbmSM8oraltcy74HDEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Fri, 8 Aug
 2025 16:59:47 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 16:59:47 +0000
Message-ID: <2d3236d6-d97d-4299-8295-c4a95239651a@amd.com>
Date: Fri, 8 Aug 2025 17:59:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 07/22] sfc: initialize dpa
Content-Language: en-US
To: dan.j.williams@intel.com, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-8-alejandro.lucero-palau@amd.com>
 <6884278d96724_134cc7100a6@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <6884278d96724_134cc7100a6@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0013.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::6) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB5596:EE_
X-MS-Office365-Filtering-Correlation-Id: dcba011e-e32c-4593-3058-08ddd69cfae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkFuUWk1dndXVU1CVkRjWFdEVzYyNUNnOE41N0JkVWlCMXk4bXhuMTRFR1dQ?=
 =?utf-8?B?dFZSR2VCWEh4VXVwMmorRFgvNitZU2xZTUdaWldCTmJRVFg5RVF5Nlp4aTl6?=
 =?utf-8?B?RTZGTEVDd0ZBK1ZvZGxjZTZIaFoyWFlPVy9WRlBUM2UySStHWGlpR1NKTVhT?=
 =?utf-8?B?Y3lURGtOaU15WVZGZmozalg5QUQ5VE9WcGljc0tNM2YrL3NpMkdFSXhvZEpP?=
 =?utf-8?B?eDY5eXpUN0FiZmRFVVNDYXQxT2E3MUVUa2hjY1l0ZTJvejAxSGs2TW9pcDkr?=
 =?utf-8?B?bGFIWWlxMk1BUGtYOXpsRUdQU0Fpc25RTXk3TnJObTJDczkxVTZ3R1J4UFo5?=
 =?utf-8?B?VVpmRDBtK2hnaXVQYnd2OU1abkVIeU5oYXNjOU10emJCenE0cy9iVnUwN3J3?=
 =?utf-8?B?azJaT2FCVkhnaVpUSGNpakgwZHpxOVVBSmU1dWhnQTkwczRzMElDK1RGbURU?=
 =?utf-8?B?UDNFSUo0VjhaL28yemhOMDZLSGpvZGlOSEJCQmFqNzU3bHBERGIyY0dibWhz?=
 =?utf-8?B?VFpMc1dwbzFEMjJPYjlYVGZ2MU1zQkF4OGxObG5NZjNhRzhFSnNUdDlMbjlC?=
 =?utf-8?B?VlJsRXhhUmxEMzJodWlicFpWRkNuWWVFRkJmeDVQOUltSm8zc2s5bHd5RC9T?=
 =?utf-8?B?Z3BqSU5HMHZESkZoOVFoWGo1Snc2cXBpTjBiV3ZlTmd2VHJzY1ZaSk1NbVZo?=
 =?utf-8?B?c2JyWFRhanpTQVBUYS9XcUVvRnY5NWZDZm5Ubm90Nmo4UnNNMHNqZlpyUGFV?=
 =?utf-8?B?ZytVUmp4V3c4TVJhdnZYTUdTVEpkZ1Z1N2tGc1NOTnU4NVg5MUdYZjRyVmYw?=
 =?utf-8?B?NWc1UXp4eGVsUGhaRUhSZElpY2tQVW9rWitMT3ExZzI4OVdzaGhCUDhYSzRB?=
 =?utf-8?B?UzEwSFFIb3JhMFh1cVc1SW5QMU5MQmNBQXZ4OUc2NHRFbmtPNEhud2NKOERp?=
 =?utf-8?B?Nk05cmZ2a0RzWnRONkoydVlBTnYxTUthU2lUSC9WSXlvR21Ja0JFeTVYTk5h?=
 =?utf-8?B?TFdFVnRGSWlUV1lFNlpxWitUMHFCcE5JbGYvVXZoTGRSN3o3SmlaWFc0ZHZl?=
 =?utf-8?B?QlNReitDd3NsMEtCWW85K0tVbllnOVc4c1NuQmFXQzR1eWR6QWhva3BYTUc1?=
 =?utf-8?B?eXFWbFB0K2ZSSEczNzFyL2J4OVMxQlNqei9uc0prSlBEVktlV1JLM2xTR1JY?=
 =?utf-8?B?VnJtZWRHTUY3aE1RNllVZnRMb0krZmNlSWNWYVJmaFFLSW42TW9PNUZlQms3?=
 =?utf-8?B?TTB5dmVrRVJ2QVgyVXJINjRFZS8xQ1MvL0RDNTROV0pEbm1Ka2VVSFFjYndO?=
 =?utf-8?B?TnRXOGs3M1hlK3pycWN1Q29Mbjdzb1hBZ0M0YkhLT25vSzE4MVFpNnNMVUtK?=
 =?utf-8?B?TUtnQkN1L0YxWFhLM09Ma3NTdUZsNmV6MzFlSER0WlNoOExPMElKb2xvSUZy?=
 =?utf-8?B?bGlzcmNLbWdXSUtKVCt3SDI4QmJuSVRINTc0TkFoU1V1UG82V2xJQkMrajh6?=
 =?utf-8?B?Wnd6K2Z0RDlCUWFOTVk2NmF0UytRc09FSiswU2pjRStSWWVPK2hCRStNNnAw?=
 =?utf-8?B?VVRWQjh0eGEwVmhDYnpTZ3h5QjVCelhDVWlkck9tbUUrYVFhZ0ZsRHVBNDZi?=
 =?utf-8?B?K01SZGxESmxtUTc5ZHM0Wjh5MEpXRWMxNlg4YTFwYmp3NXJoZ1UvWXFXanBT?=
 =?utf-8?B?WkpwaVpnSWMvLzdHZ0hUTndoU3RnMmJUcE9teHJrYzBIajY0RmhhS1hGUkVL?=
 =?utf-8?B?UHFDalk2UWZDZS9kUFlDU3lTT0RHcEdPNXlwQW0wZW5GNjlCaEJFeVlySW5V?=
 =?utf-8?B?WDcyNm5wblJ1dnQ5MDJxK3lERWRMNzRtQVhXdE5QQXVmRlVnaFlBdmxEMTJQ?=
 =?utf-8?B?bEJTVWhFZ1A4Qmh3KzloT3VXK0ZFQTZVN0ZPY01aSzZJdXNMUkJUQXpUZW5w?=
 =?utf-8?B?R2lqaGJTK0VhQ3FmOWNYcTVjSjNxT0FmdS8xN1hSTHUxVnk5RTIyaXBROG95?=
 =?utf-8?B?TGtzVUpYa2R3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amlmMjUzVGJYRUl4Qzg0QmhoT2NqT3k0MlB0MHN6djlmeXQ4Lzl6OFZuTDNN?=
 =?utf-8?B?K1F6SnlvOWdXRTVjbmJkZmdGcCtvd2EvSVpYQ3ExVDdWMUVFRGNUQm8xSENG?=
 =?utf-8?B?cG16RlRybzJKcjQ4czVjV2hIY3Zoc3BUdzZJZ1NMSWNYSHNYbkFYcEZEMWZW?=
 =?utf-8?B?M01pWXUwdkhEWTg4TFR3NjJHUEZITVZQZW1UTkxFMFQvUkVFcGZzcUg0dThu?=
 =?utf-8?B?R2cvYmt5aEZUZnVYNGZkWnNTSHQ3WnE5V0daVk9ZNFVPRHlXM20rUDU0Y0hh?=
 =?utf-8?B?b3N2STJSUUFLM1BhQVd1bHNCQkdNOGZhMCtQRDkrdUkrR3hESEhWNFFDODha?=
 =?utf-8?B?RFRBTWhHMDc2YzhNZjg4cTM5L0JxS2YrY1pDV3d2Mk9ycFVubzBHOXlhSncv?=
 =?utf-8?B?REx1S245MmVRaXg3cko0cjlldWZwV1dpcVNQWldhV1VXckRKUHNLOUp4OWd1?=
 =?utf-8?B?N2dFN2xkRDd4T0NwR0tKMEdjb2ZZQzNlWnJoZUxnZ1VaaUtZK0lOUzFvOHhm?=
 =?utf-8?B?SGpURm1mUmZxQnRTTWx6aFp5RHdlQnJaanNyc2tac0x0MmhsekF2TDFEYnRC?=
 =?utf-8?B?WVdSZ0k0bWtZYlMxclBlQkZLTkEzSi9nYmNESHQwZ1lzZjNnWHFQSmE0c2Mz?=
 =?utf-8?B?UW5EZ0JUV2gxWWhERUswdGVOVDh5dGNLZ1RQNnJzUzE4VEh5SGxSWVpBM0ZU?=
 =?utf-8?B?UnBSa3FNT0dkTVNZUUlGeG0yL2k1ZzVzTWhXQXF0UTg3UUxLQnNWaEVPcUVJ?=
 =?utf-8?B?SE9aa1pXV0I5TE5EOS9jWlhFQUUya0JEekg0K0NUbUhnVDlhWHN6WWdHQ0Yx?=
 =?utf-8?B?N0xmaUdtUytzcWVDaEExNGdwNEY1dFJhT1dQa29mRlZPV2NleGFqRi9saFNo?=
 =?utf-8?B?cnFLeXVKcldZVWE1Wmdaa015VkpOdXhyM1pUdDB0YUQ0Z3o3WHVlQ0N1TnVN?=
 =?utf-8?B?alVhQ3Vpb29pV2J3ZTMyM09JMDFrUllQaUpLeXJYZm91cUh3ak1wYmEvL2J1?=
 =?utf-8?B?cmh3RHpnaEF3enJqUDJZc29RVWl4cjEwbVIzUjNydVZ2QTA1S1RsWE1TYlVW?=
 =?utf-8?B?WUdMUnpvVTd2cm41Y2pwNWc0ZWF6eWwwK2wrV2lXTzFHdG4zaEFtMjRubUR5?=
 =?utf-8?B?K1l3ZUhyTDA5MndLa1U1NVdhSGZDalN2STNFL3d5WHJRaUJMbHgxbEJKVGhJ?=
 =?utf-8?B?RXRhS0xrSnY4T2RPN2dXbWdhUjRmbnE3cGVBN1prVEtzbDl3ejlWckxrTFlJ?=
 =?utf-8?B?S1hxU3F1c2Z5cytjTENlMDhwWmpzMFc1eFpJWDlxUzN4TEJRY050L0laZDRT?=
 =?utf-8?B?TjZTM0VEbitSY0QzeXRUd3d3TXZyNmJZTEVuOERCcFJLdXFicDRNZ1RBN0hM?=
 =?utf-8?B?M0swTjc4bDFlVVFEUTZqNTBoM0paQzhQTHVaUHJxQkFzdjJGTDAyOUlVN3p4?=
 =?utf-8?B?SEhNczRtU1d3Z3ZTUC9qVnRDZ1BrWEMxNnQ3a3ZNeTR2WTNPTFFlUjdaclZH?=
 =?utf-8?B?TFFXT1pJdUNBUDdNaUoxdW1yVkFub3JjdXVIQnFuSHJ2ZmllYUFQamY2bno3?=
 =?utf-8?B?L3ZzRUgxNVlIZkdudms4ZzQ5cjhVb3J0R21SRlcyMTZHWkpjZGZTZEc1ZWdy?=
 =?utf-8?B?V3k3ZkQvTVFqYy9rMFhTT1dlU2x5MHJQNTVTdTIwTncxcHZraiswS0Jab0hZ?=
 =?utf-8?B?MjRWcXZWanNuUVcxWkJrU3Y3K3F6dStWdy8zZzlXczRNNk9MNmFSWXB2RFpE?=
 =?utf-8?B?cDhJaC9YTVRyTnlOYUhwb2RHaXhEZVdYZmJabHVQQXA4MmhTZGVESndYOFRs?=
 =?utf-8?B?MFhTNEZ4c25odU8vdm1pbTNlOW9hc1JoZWFNODdybEV6Ty9sR1FsMFlDL1lE?=
 =?utf-8?B?Lytva2RkVXR1RGh4Q0FRc2FxSkJIem1QbXhNZlBpUXZoMVdBRVVDKytabkFN?=
 =?utf-8?B?N3VVd3VVVGlRSXB6T0pHa3pSOCtFaWo2OXhLYXhoYjhTWHVYMDQ5MzNtcFY2?=
 =?utf-8?B?MHhtQzVreWlpbnRkNmk2enUwcEFKdVowZXJueHFzS1M1VWo2NmtGTVZaOCsz?=
 =?utf-8?B?VlpGY3NhUWJzdW1SbExOcy96SjRHZFlBczhCT3M0U214T2VBNWpjM2NKdVRj?=
 =?utf-8?Q?s+zpVuCXa6bTktspOexbMRwMM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcba011e-e32c-4593-3058-08ddd69cfae9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 16:59:47.1544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QSusnNGB4p92v0cDjN80sXrIvRbbBa7Fq46xPxcTbHkrA3kM8jx/eQ7HjDkpgMBBnYNdySljABdhOVBeFmjRsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5596


On 7/26/25 01:55, dan.j.williams@intel.com wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use hardcoded values for initializing dpa as there is no mbox available.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index ea02eb82b73c..5d68ee4e818d 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -77,6 +77,8 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   	 */
>>   	cxl->cxlds.media_ready = true;
>>   
>> +	cxl_set_capacity(&cxl->cxlds, EFX_CTPIO_BUFFER_SIZE);
>> +
> Yes, definitely squash this with the last patch and you can add:
>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>


I'll do so. Thanks!


