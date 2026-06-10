Return-Path: <netdev+bounces-297451-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2WfYDmn+KGpVOgMAu9opvQ
	(envelope-from <netdev+bounces-297451-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:04:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 297C06660F1
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:04:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=sxkWv3Dt;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297451-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297451-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9636A3023C11
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B244E282F2A;
	Wed, 10 Jun 2026 06:04:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012029.outbound.protection.outlook.com [52.101.48.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A07E2DCF6C;
	Wed, 10 Jun 2026 06:04:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781071444; cv=fail; b=oyNz0QhtECKPJ7o1gZhxUnbBZoas1HWnht7DYXGBFuuAg/CpknpFuOXTZL6PPdzaVH9CnyWJMHKclwYdfyxNyMy92z2KW3hjnL4azLsZTXmAhRp87OSpAsbhEjJ8Eo72ZfwQOQ9aSgD7XQndDYcbMJDcAaxMBbaHgOiMrhrpcSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781071444; c=relaxed/simple;
	bh=oRQBolwRKakmBR2d98hIwQXqTbYRiG/n7S1FlUDX8kk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=blvfZo/thRO/NSdSsssnzGxLBDpdScuCNuAP/MDdUAVw1ArXSWYwa/Q7LyJWoVBDzaxoKYJNzeryOh2LEDBdzOzuUYEUids93e89ufOvmjRJo8iHbl5Cuh//TKGJjtncZrWVDxrfDlXpXyLVKp3tUy5tuy/R0pG1QFHJI5QVC8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sxkWv3Dt; arc=fail smtp.client-ip=52.101.48.29
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7HUOKvJaCEcI7GvIdIefEVH0ew8Xb7hZ9bpWlg3s+UCCsn2kKWgkV8u1xc9c18NhOCBFOeKnN9RfiQ397qXbQhXEOe/r+HdCBozYPmTTiXeV6SQxxSDXjkTIOsSb22oDvnxSJhCRXSz6h4pMyjqWzQOoocQoC3vs8KfHkNsY5xEfomgwj3ShgbSwu9EDwBanbZZFHUFvKGVkGPoxxkMn2ng1VGLHhYMoBr05UDn4kl0I54A5o6lFBnoCJT9PkHNsJ/1GmMMGCyI+Ef7kgnrb11m/hvlJOAWkiASfjMTje829NOVHG+vUmILizxm9KTHNtra3+ibQgSkVjXaz2ToTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4A5rDKLs5c1DfK3aRQLi2W+iLoqcDR+9XxDHsmCrRw=;
 b=DC+/qgWUiVQBPM3N7ie2hd3qxW7B9qzk2YqqTL3Pz4lN9XiPilyszTNnAmp9FeGTLNKpR1h8rrZ0Lkii4LCbfsYr4PDcAw7jq91Vly4qKV+ZY+JCDBmd2vnvfXkYgAt1wM6ZtDHC89lQYSttGyKvh/Fe84g+uR90n/uyF0iUMctpZU9qCJlAbNODiG/WFBpAhJ+sXcztat+vpAmiuyMiZflgRt5ypcfEENbcXpH6Bcx62QmjxN22bRCTK1+5zRiB4jXnbucFrg+1B7zAlf5kIKjV71xTOtkUV6Ny7oFopDMo/eMCqlaMFdcKODGZgjQgaBs1JTmurwPiWCOzLFXOtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4A5rDKLs5c1DfK3aRQLi2W+iLoqcDR+9XxDHsmCrRw=;
 b=sxkWv3DtgkYHUdr123nYeO75k3fa5LSD5hdQLissRjOPl9mDoPmhUGDIwttydCKX+Ui3xn69F9XmxK0NPP35seQgjVT1h0jHS4VtLchU4hBDQIfUXXUBNx9CC1W0+H/Ryl+qUmqQQbAKBwWS2TCfGc0S5uLVQ2gr/VGsJFtnBHk=
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 MN2PR12MB4062.namprd12.prod.outlook.com (2603:10b6:208:1d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 06:04:00 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 06:04:00 +0000
Message-ID: <17b68fb1-768e-49f6-884d-49e0952621b8@amd.com>
Date: Wed, 10 Jun 2026 07:03:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v27 3/5] cxl/sfc: Initialize dpa without a mailbox
Content-Language: en-US
To: "Dan Williams (nvidia)" <djbw@kernel.org>,
 alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
Cc: Dan Williams <dan.j.williams@intel.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20260609215755.8685-1-alejandro.lucero-palau@amd.com>
 <20260609215755.8685-4-alejandro.lucero-palau@amd.com>
 <6a28a0c349c9b_4fa7810099@djbw-dev.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <6a28a0c349c9b_4fa7810099@djbw-dev.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0286.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::13) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|MN2PR12MB4062:EE_
X-MS-Office365-Filtering-Correlation-Id: f193db5b-684f-4e38-91cd-08dec6b6109c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|921020|4143699003|11063799006|56012099006|3023799007|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	PExHHrP4c3D9H7kvIyHkM4XVjxNbp4roYvgLPfwxyUWKUMD8Y+kaOfDW5ekfmzyvK4ORRERCxM1B45kLqqi/HivBbOWK5uWGdctCOCjYunhN2mab85TSEgx7bqZd8et2xSgrHfx7uXhGX5H0WsGyafrQX9IoT7khQn7IGu37/UYlGud/G6JtyhhdJ8tbfZ3WnuKe/PTAOVyd/MPm7TutbQGmvZU1ppwaT1DYS1ZN4qpRKEetBXtlnEziSQO2up706H7FNbLPpyjT9tt9REPpYWO/BJxSMOwhoHZnTRUe59aLSV46D4dVFpdpK3rxiPRzFQhV036B24gM6nC+koDMpZV7+b8sp9EgFXniPqGm3YYtI0YGPUB+rg0svIa5IKbXBPQXnneDHBXKF8ke9lxUNSj8eEo6lo4heS5Sx96kJJNiNsi5lypdEl0SkAaNTDc55f1+EeKx14VUgIzlFpAkzq/kuYq6Tzyy8onmMhb9CFd8xk08s6EZ9qt6+BViEFyZHDfBXQ9+XiAQO0KgCsZV3dJ/ivujM/nXGX8QCtN1RSkGFvdpMpcX1J46QkTgSBhQx3xbjpIhLGCFajmOxPuVCfr+b7c8HZkUhFlgR+R3nKoMOoC+jzzGCrI6ghQmPQWT7MF0e115ADbdEkjklx1q884TJdPibK1xn3eaIH97YVoLZuVNvC8EaMP/+4A01RSYRDhCD1ye7umGW3IYN7T9z6dk7/9DPZnjES/SX+7VvGOvC/s0X7hZotYrYN+Y1eW2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(4143699003)(11063799006)(56012099006)(3023799007)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGx3RVEwNWlYWExjUmFSSWJPTm9oems5UFREOU4xcmxFWmppTzlMcnBJR09O?=
 =?utf-8?B?eEV0dGoxN2M1S2c4ZEJWZGcyTituaFhXV05EN1R0RE90TlRRZURwNkZLWlFx?=
 =?utf-8?B?T2dIeGE4YjNzZXU1Sm9tdnVVcGg5NzRIQStrOGNSY0kzSHBRS2cxczduZnJr?=
 =?utf-8?B?TVlqSVlPOGw1SmhaVXlkRnpyNVVxUHdVZG5mckQvdzBJd01iVGltcUU2a1Ar?=
 =?utf-8?B?bGp5SzZ0UWd5QVMydVE3Z3FYTjRNaFpqTWpzdkNZZ1M4OEtHTWp6RjRlWXc4?=
 =?utf-8?B?cjdIcktFUEtjajBIK0UxY05YZUpnUXU3NUs3TFFFbGg2US9SQm9DTSs1cVds?=
 =?utf-8?B?REhGeTdkdEVZNG9LeGt6blA4WTUzYll3Wk93dnFYdGtkNHJlVnZBUEdBaUFB?=
 =?utf-8?B?ekRJSzVreWQwWi9Mc1RIOTBBQmN0ZWsrOVNTY3JRUktXdmROeUEvQk9uRkJC?=
 =?utf-8?B?SDlHRkRicjRVSGQ3RGEwZXcrdTd6TFdzVzNidHpNaE5VcVlYYkpRYTUzK3Rq?=
 =?utf-8?B?ZWtHS1E3djBIWXZqUzF2Q2VZc1ZCTmZsYUswendhKzBCOVlCTVc3aTcrSGlm?=
 =?utf-8?B?ZFlhSDRBYnZabXhjQ1dzbU5HUkFPRndJcDA0R0ZnQkduQ0NjUnlOQWpYQjhj?=
 =?utf-8?B?WWhxejA4NXBIWldBYVVZK2I5czBMMEM0SUtKM3M4ZC9yS0NXZ1VhOHMyODZl?=
 =?utf-8?B?bUFVY2lOcGpJdjVOamQ3TTUvZlpoUUtQdW5iNU91K3BIL09VektVQ0FqOGNB?=
 =?utf-8?B?VXZVbU8rUEtkTmhlVDNyMXVVTlBUWkJjMWZpMlVLSG5yc0pVVys0YTFJQm9o?=
 =?utf-8?B?eUNsMTFDTHVaa1QzdTNoRnRuMGM4QW10YUJRNzlSWmlTWGpkbnp5SG80cWVv?=
 =?utf-8?B?UlJYTEtVRmcwRVBJRGM1Z0prY0kveUZiSE96R09VRUpxSXI5Wlo4RUNOTGta?=
 =?utf-8?B?ak1NakFvWXhFZm1Qd1dtYTZTQTBOaXpaZFdPRzFSN3RCeXdBNG82UmR6UVgy?=
 =?utf-8?B?R3VXQzhaRGp0WUJQNTBaWlB6cmdtNmlyZTg1ZWI5akdnaVR2Zy9KeW9BaWJX?=
 =?utf-8?B?dEZza1dPckZTRDZabnZmNFJVZ3A3TW1ocnRsaUVLaVAvU1VvYTRuTFhPZ0ZP?=
 =?utf-8?B?Ym4xVU0vV0RvMzladG5NdnBTeVVpQnVPTk84VVAvZVQxWFVDZzRrWGhtTWlL?=
 =?utf-8?B?OEIybmVrQkNmakY3Z3V0V2tRZTlSekR6VUcweGNGQlF0ei9NWmJvbHo3RmYr?=
 =?utf-8?B?ck93eUFRZUNJTWppaTUxYVZUb3ZDSnhDTitsWVFIbzBWM3hRanVrU0pTTU14?=
 =?utf-8?B?bVBVTlhXVGdqWVVpb2gyUXp2NUdpbkl5dWFrM1NSQnlwQWJzUHhFNm5wejdZ?=
 =?utf-8?B?cUYwT1cxdlp1cURaUDE2Qk92d0dnY2pRdVVZNkFIbkwvaXFEdFNYUXEwSVVn?=
 =?utf-8?B?c1VpdTZLUGhwT1B0Vm12cndnYjY3by9XWVFCMmdJZm81Y0pscVBnaHdaNENC?=
 =?utf-8?B?N0hrdml4c0FONTRlakMvclFOUWpSeGtmbit1a1JtbXR3WkpHazVza0tya2dX?=
 =?utf-8?B?TXYyYWFueDhFNVJsMklQTXZFU0VyT2R0NDIweGhMdWJkOXhqN1NGOU9CclhH?=
 =?utf-8?B?Z2pSUFJYTFNKL0E3R2FMTktXS0RxRzI1LzhzYlZEVlpzTmYzaURDTmEwMDZR?=
 =?utf-8?B?dCtLNmxLSHV5K08vMndNTEVaVlo2RFRGRjU1R21XNkI2bTcxNS83TTVEWkZB?=
 =?utf-8?B?VkloSHFrTVU0ZU5pUU11SzJNWFVuYXdvZDBRa3Y5N096ejFnbndtNm4xNkhQ?=
 =?utf-8?B?Q2hsYWoxbkZYclpveDJGL1JCNCtJb2IydUZuOStaQlVZTmhPdk9PbHBjeG1U?=
 =?utf-8?B?ZkpOcm9iM2lBQVdSZzFzUisyM25SN0NUMjhsVU9sMm9uWHFncU90YitQckNi?=
 =?utf-8?B?bVNTdFVOZ29mN3dEYmMxbmNUb2JsZGR5ZmtRWW1Obkw2Z0JnVE9HM1c3Yjdn?=
 =?utf-8?B?bXdUVS8xQjg1dVlhUnB5WjdLblJrVm05ZmsxU3RIdEw5VCtYT0dnL3ZzSDFn?=
 =?utf-8?B?TzNIanN4WTJKczJFWjdoQVhwYXZGN2pwaGlRdTdTSytaUFJpbEpXbis2ajFH?=
 =?utf-8?B?OXg3c21PNDdTN1VzMnFwTGlsZkFlQnpkN2JPUTZ4RTBiazJRY09PY2N2ZzNW?=
 =?utf-8?B?cHlMeUNDa2tFSHVTRDNlQllQbkZIdVpIeGJCcVBxRkdVODVBc2ZEZFRmQ2hm?=
 =?utf-8?B?alNPa0Y3bEZFYVJSQU84ekpwR0J1UlQ0Tm9PUEQ0dk9WSVJEM0RYU0Z0ZTd3?=
 =?utf-8?B?azZYYXdxWVBPTG1MWVFvaUtCQ1dKWmRiV3lDbytzOXM5UUExbC9FQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f193db5b-684f-4e38-91cd-08dec6b6109c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 06:04:00.2617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JvC1KQ7Uw4rsNDaC9ZiktN2Pywr4/FNN/4mHFzyE8/rDUYfKBBSZN6pWVe2I7mK/sDp/ulNgdVfSSpd8yfcmzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4062
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297451-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:djbw@kernel.org,m:alejandro.lucero-palau@amd.com,m:linux-cxl@vger.kernel.org,m:netdev@vger.kernel.org,m:edward.cree@amd.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:dave.jiang@intel.com,m:dan.j.williams@intel.com,m:benjamin.cheatham@amd.com,m:Jonathan.Cameron@huawei.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,vger.kernel.org:from_smtp,huawei.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 297C06660F1


On 6/10/26 00:24, Dan Williams (nvidia) wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
>> memdev state params which end up being used for DPA initialization.
>>
>> Allow a Type2 driver to initialize DPA simply by giving the size of its
>> volatile hardware partition.
>>
>> Move related functions to memdev.
> The code movement is not strictly necessary. Just add cxl_set_capacity()
> and we can consider a move later if mbox.o and memdev.o are ever not
> both included in cxl_core.o by default.


I think it is the right thing to do as the new function uses add_part() 
(moved) and the other add_part() client is the other function moved, 
cxl_mem_dpa_fetch().

Note cxl_mem_get_partition() used by cxl_mem_dpa_fetch() is the one 
working with mbox commands and it remains in the same place inside 
core/mbox.c and the only cxl_mem_dpa_fetch() client is cxl/pci.c


This was reviewed and accepted so no reason for not doing it ...


>
>> Add sfc driver as the client.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> [..]
>> +/**
>> + * cxl_set_capacity: initialize dpa by a driver without a mailbox.
>> + *
>> ++ * @cxlds: pointer to cxl_dev_state
> Stray "+"?


I'll fix it.


Thanks!


