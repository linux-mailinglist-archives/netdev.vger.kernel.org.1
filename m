Return-Path: <netdev+bounces-289051-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CS4IFQIC2r4/QQAu9opvQ
	(envelope-from <netdev+bounces-289051-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:38:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E68DA56CD3D
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D61630207F8
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B4F413223;
	Mon, 18 May 2026 12:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="IBLepXDv"
X-Original-To: netdev@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010019.outbound.protection.outlook.com [52.103.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3410413239;
	Mon, 18 May 2026 12:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779107803; cv=fail; b=TcoH84zFRQGYHozWTKIfDQTl3cdQVoOwwBzuht+qxd2XEA686H/GkzUKZPdJlHrgHZDTtY4bQeCPlFm5oD0pH286/g4L7rqk6+06p/DWZwL7fs8V85vRFB/zhDZoIODsYPSwyp31WYvKY43yFJlpukDkenkwacEpdjKcIfX2CrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779107803; c=relaxed/simple;
	bh=A5f2QYJFeSMB8AiI5OgmBN7hefjQIwCjEt0jwY39Z58=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ir98Xgom09qrLmtkVqFnQ1nzeCgL2ybH6NAPNus0M9kol+E/IS62bC5lGyxj9AQwi7HUSb4VWxVHocbjPIqWypE7NlETL1g3PWpVDbrxGTmb34iOmZh1pQxXOr64+X+0fnbORnb3XyKM+9CMUfYcfFNIRjDUjL5yq77JJ+nPKlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=IBLepXDv; arc=fail smtp.client-ip=52.103.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1auipLHjvPyze1VtBK9ywECKzGn8PH0TO984lNRREu8rlpw8vhYzY/RbHAGymThgCm5gXf1Dce6DlXM5dU0gWa5izgOjr2hY7FD7ARRCW3zpWWjRoQ3qWIuigdyBzbV1gjk4we/B8PM1807dAKu7lSH0itM8ukmLEePxlBtoRSiTBNf7HyODTL8tjxZQPxS9/eGlFYwU2HqxLSMdcqO15ZUL5y5shWXUUW1vG9/fdhwdEukJRHiJgtHbwfXLXvDsgmTU2RkVSE7O+ujbPHwxx6Gw/Jz/PkOpwk2SqItJztV+CoN2gHqmMu5EZUPKjODEfBSSC6RWMl6FqfNeX1WOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Vw2HT5SUew7uPaMxLEcPH0GZVk0ip3KaaAtww9GyVo=;
 b=PfWBPTYOnp4dfTswbooY3DTb4l/G12vo2cDiptipTn9t4L3Wng1EP23D0BB+5/b7EsZ3wYLFVlsKkjPxGwGoU8ECYnbpmeDyZPiPenhlrwXM9ytA1dO2Cu33BCPA+2cMTG3JR7cg2clnRIrChFHW+QHT2e9owAcWmUkWmqCD83RbvOEGF8DZB7RyjEW3k1sTxddAfYBcDD/3UgHQ17nK7hhwVwmKuA5PHLrWZMpiKDpjAScd+Jcy8h5sPW9BSKwKI2JiMcbYCUrj5Yu9sStlbppyuP+su5FajPCZbo27a7X8X7KzGtFeT4UqHoWvrt/uUl3eI48OvTZoIkwx/xa4sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Vw2HT5SUew7uPaMxLEcPH0GZVk0ip3KaaAtww9GyVo=;
 b=IBLepXDvfJ3wH2Sx0R/XSXXv6krD2uHqSyuSdbKM1thcZCLms4wj6e8qRBu4X/t9WDlUpPJvvdY+qEkD+kVqj8U38PfSm0rmw7OdcpBz/w8ZYkQPDlWbnaSAA69Cm0994sHU3jq2vo7Mk46w+yhwUiZ96Omld8X5HDWGVnhA9P3VXVAw3KvEr3T9WTtBRKXBH43R/WHpmnzzpllhf7obBByuI0RSqZe2si+xRQMvuULlUB8AJA4ZJm1qaBnkbghcncXtvWdLvGgQ2xus5nj6WV8OfuVKqfneLDhzi3V9cSaJHhSBR1gy2vgDV9ugQP/ghiRtcjUE7i9fJN9A7tZ0qw==
Received: from TYRPR01MB12666.jpnprd01.prod.outlook.com
 (2603:1096:405:1b4::11) by TY4PR01MB15938.jpnprd01.prod.outlook.com
 (2603:1096:405:2c7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 12:36:38 +0000
Received: from TYRPR01MB12666.jpnprd01.prod.outlook.com
 ([fe80::6ded:56c7:8121:fa0e]) by TYRPR01MB12666.jpnprd01.prod.outlook.com
 ([fe80::6ded:56c7:8121:fa0e%5]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 12:36:38 +0000
Message-ID:
 <TYRPR01MB1266606B1144F3896FC712C3CCA032@TYRPR01MB12666.jpnprd01.prod.outlook.com>
Date: Mon, 18 May 2026 20:36:25 +0800
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
From: Xavier HSINYUAN <XavierHsinyuan@outlook.com>
Subject: Re: [RFC net-next 10/15] ipxlat: add 4to6 pre-fragmentation path
To: ralf@mandelbit.com
Cc: andrew+netdev@lunn.ch, antonio@mandelbit.com, davem@davemloft.net,
 dxld@darkboxed.org, edumazet@google.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
References: <20260319151230.655687-11-ralf@mandelbit.com>
In-Reply-To: <20260319151230.655687-11-ralf@mandelbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SEWP216CA0142.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2be::10) To TYRPR01MB12666.jpnprd01.prod.outlook.com
 (2603:1096:405:1b4::11)
X-Microsoft-Original-Message-ID:
 <d128f118-4a4d-42fa-891b-8c71b005d864@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB12666:EE_|TY4PR01MB15938:EE_
X-MS-Office365-Filtering-Correlation-Id: dcc7106f-a3c4-4b45-aaef-08deb4da1959
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799012|8060799015|15080799012|23021999003|12121999013|6090799003|41001999006|25031999004|8022599003|24021099003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emZYQURlODVVUHpqcFE1TUlMTXpHWlRzeGZyMWpDS0cwRnpnd2NaYmJCQnVG?=
 =?utf-8?B?SWVhVlpXTnJBVFRrK21PdTQrSDBydS9Ha1MzWVBGNm1sQmFWWUtuamg5bmFx?=
 =?utf-8?B?QWwxUnU2Nkh5V1RyTVp2K3Q1TXhTUTBpNW1oaWprT2FHeXdMaUlSbEVWWlNE?=
 =?utf-8?B?QmZWeHhuSDQyczRFT3JnbS9SQm1rWWRKZ1pwdDMyczJkQ1RjUEtBOGhKZ2FI?=
 =?utf-8?B?TVZrNTVMR0ZEZ0g3U050NE5Fd1Z2RlBGYUpWL052aHh2NnpWb1dHbUFUSkNH?=
 =?utf-8?B?azgrMnJBRzM1QVZwRy9TSnpiWHhSVDBBcUxaand0TGRHeVdybUx1c2ZPUkxw?=
 =?utf-8?B?SnpKcmZWdTlxVTBDMGtiREg2d0RlMk5zWk02ZUhoQk5RQlZjalV6M0sxNUZU?=
 =?utf-8?B?aEdNcTYxYktkamw1TkV4YUV0aVVid0hQdDhIOExyUVlMeEwxcUxxcFpveWhJ?=
 =?utf-8?B?Mm1MVE53YW1La2FZNmpYWFJBazNYZFRWUVMvQW9jeGtZdlJpT3o4aEtuWm42?=
 =?utf-8?B?M2IxVTh6U2xmOUVOeUlIT3IxeFZNMkxqZVNLdEhJZkFwdEkwTjdBWWFXK0lI?=
 =?utf-8?B?NEpSZkF4N3FLWlRkalRXUDNJbXRiVU4wUnp4djdCK3BySmdRQ0RyQlQ5Rkw0?=
 =?utf-8?B?MWdsdWw0bkZMbkFwRXNraWl1ZXF3cnE1ZVUxL3p3UnpaUzYvRnZBblQzYklT?=
 =?utf-8?B?MThNdDRIbFI2Y1o4RTlKdkdQdFJMc2c2aXdQdDZZNkZTU0tsMFBoTU5TeWMy?=
 =?utf-8?B?eE9hOFcyUHZHMWdBWlFYb1ZTc2tOaytYekdvTklWaElzSitJYS9MT3dnOW5l?=
 =?utf-8?B?SHo4Nk9iSytSTjhuTGxheVFXeW9QWHBjczBzTnVsTGEydDd5T2tmeEpGUSto?=
 =?utf-8?B?NWxlZy8ydTU0Z240dHNUbFRJNFVoNm1JUkx3bnZOeWJiTEJmSDJPL3JNN1lV?=
 =?utf-8?B?c0hDeTVyVXFMclZIRjhYVUZ6UTMwTUdXMW8wekpxVk5hU3QweWVJNEQ0VitF?=
 =?utf-8?B?TmNXcHZVZXYrWk9NOUFUUFpEUEthcHFhSWg5QUhwRXNFWkljc0tUa21aNk00?=
 =?utf-8?B?RWFkRStqSzlaVzZTRFlKTEhHWjNVWGNkaG5OY21ya2JrOEpqeFNwQ0J0d0NE?=
 =?utf-8?B?NEQ0QTNpeG44Qk01U2VvekVTaXoxWDZVaUJ4c2VheWVOU0RiV3BISS9Kb2w2?=
 =?utf-8?B?YkF4c1M5RjBsUzZLSm5JM0lOSXZhNGFUZDhuTXgvcVVIVjRvdmRjMldvZC9E?=
 =?utf-8?B?SldhUXFCMHM3OHBOSUk1NTRBc0dzM2lBczRXbTVqTktIdUxiUHRvS21KNlUw?=
 =?utf-8?B?amJqSnY4OTRCWG5DSXk2WDc0T2NhMzdXNnFUMkFWLzNDNDhVcDF2R1Z3UnlE?=
 =?utf-8?B?cFhLNTZ5Z2ZYK2c9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2dxUjJqeDc5VE93YzFkVjV3KzF5NWYyYklXVXNBZVlYeXFHUHpXbzcvVWJs?=
 =?utf-8?B?b0VEVlp1TVdlaUZsdm5QYVhhSFFEN0VqWWVxYXg0c3k5cmNINzMrZjlhUFV5?=
 =?utf-8?B?NFpCaVVuS2xyQ2s1NUU3TnM1WEFNTFgzM0wvN1V0V2FoYVBiZXF3aTFnekpG?=
 =?utf-8?B?VHl0RVZpZzVjTHh1MEplb3VQQ0pDR01XRDVrU25TWVdNcHBNc1FOaE9CTzA5?=
 =?utf-8?B?MDcyb0pIT2t5QllCblBoa1R1MExIV2dPNkhDbEFneGh2SmJBcFBoWGVIL1Ex?=
 =?utf-8?B?YkVGNmZGci90RVpONHN3ZlNPYUl2M3dtUld6R1pnMVZwT1FBOFhSY0hIaDQ1?=
 =?utf-8?B?MlB3RUJRRk1TbVNlWlBRbHNRRDlpWTlMaHRlU2sra2lDL0hkVU5rSEg1VFVN?=
 =?utf-8?B?ZG45REZKekhhenhLOFBlVWlKdW5YL2x2MEJGblNpSUUrcE9id0Y0MkdJbW9M?=
 =?utf-8?B?Z0dxeGN5UkdxVzlPOFI2cktEU3BFVU45OEZTeVFDYVRDUkpkUnhBS2RKSC9K?=
 =?utf-8?B?NElBR0srbllzemtvK0VqQ3lkbEdNV0RVNG0xZjcvSTBYSzhWRVZVbkJFSTRl?=
 =?utf-8?B?allGWXFqTlE0eXZnaVpHNDFCc1VvUm1FdUZ1aFZ6Y3JybjJGRi9UTUVZNDZk?=
 =?utf-8?B?dS9iQS9yZlppbGVBQ2JUTm5aVmdvblRoK0dvRmVBVEpTeXZTZ3JCL0l3dnVG?=
 =?utf-8?B?VmI4TE1JSThzdi85VGhUQ2xUTytaSjZDSmxmcFpZemJRUnpobC9jSGRrMFhZ?=
 =?utf-8?B?czJOQkJNZGQ4S0ZZc3RLUHdDSHdhcEErTXZ3cXU1bVd2V2pBeVEyeGtpRDZn?=
 =?utf-8?B?dThQTFE5d3B0SkZURjZwQjR3eFhheUYzNkN3SHNpQlBLVFV6dDNZdVJVZTNG?=
 =?utf-8?B?SHVITlB3TGs4dEFVQnYxQ2V0NWl1OTk5SjV6aXJtSElsMlk0TXZSOHlKVDhn?=
 =?utf-8?B?RjkrbUVxem5LY0xveWR3YzBtcVRWVEZxSXVWeTYwQWw1aEU2eFFJZWdDbTZm?=
 =?utf-8?B?a1Bya3FXWGxnS1hLaDhxQ1VVYWRhVTd5by9WQmhQaVZrQ3J0K0tVWUNhWVJj?=
 =?utf-8?B?RmZpUHJFTTJ0a1NEV1FwRjZaRi9nbkdvaTJlc2hnMU53Rnh3dlN6SUxkTFdC?=
 =?utf-8?B?MkVESE04RWtGTEZubkROQ09sQWNrLzdYb0o0ekxQOXNIR3l4SVBXUENSbGtP?=
 =?utf-8?B?U3N4OGs1dEx4amR6c1Nvd3d2cGNqTER5SDRLQkVvNGlRUnZoeWFPektRcE13?=
 =?utf-8?B?QmRWMERNWE9vc1ZJQSsreXNDYXhJY3Yzdkk1alViZ0ltK3luR3FnSTlRcFdP?=
 =?utf-8?B?enlXSENTbWhzeGpqRTBxdWQxVnY3bGpMNWpiTU04SVU2SytLN3dMZVNoajRE?=
 =?utf-8?B?SnIyV1hjN3ZLSXNGMUxpcDFCRXNyQmZrSmFsZWxvcHVlcXU5dG14ZFFUSm9y?=
 =?utf-8?B?QnJWWXhGeHNHYko2K3RrTjZTbzhWUnRZWWF2ZDVIZWo0Zk1mZ0cwV0MrTHkr?=
 =?utf-8?B?a1J4VDJrVTE0YVpKYUNRTlZHOXVyTnhEMVo2Y2hBemhodjhCaUlBWE1ZanV6?=
 =?utf-8?B?dFhacWVnWEc4eUY0VjR5dzFNYW5jelI1QkNla3UvTWVJR2xaeE1RTWZtZTly?=
 =?utf-8?B?TldVT1RJUVJpaTFGcUI0NGwvdGUxRUJqbzNxc0QwR1poUDFkeEoxQ0k2YjFU?=
 =?utf-8?B?R051YVlxdmxWcVB0L1hpQkJqUFVybXpsT3RuRnpMVDdnZFZSN3BBbkE2M3lw?=
 =?utf-8?B?a3F3d211eEtnelJSK3BGaXpUU2tLcWJjQmU2bm5qQjNWSDRzSFR4ZkNsSGtq?=
 =?utf-8?B?OUtkSGRRSzF1d1ZFVXEwMnYxWFcwZW4zYW1QS1J0NlRkSU81bkNIMWY1Tm9H?=
 =?utf-8?B?S3I0ZDdWdVZZRmhVNjl2WVdFd0syeDZ5eXhQVmJzR1BLS2NyZkE3d0owRUhP?=
 =?utf-8?B?YnkzeEZSSGs0RHFYRityQStkaktid25nVzFsaTBPWnJWRmtEVHZUR3dERHRp?=
 =?utf-8?B?WDJRU0ZoSWlnPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc7106f-a3c4-4b45-aaef-08deb4da1959
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB12666.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 12:36:38.5236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15938
X-Rspamd-Queue-Id: E68DA56CD3D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289051-lists,netdev=lfdr.de];
	FORGED_MUA_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[XavierHsinyuan@outlook.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[outlook.com]
X-Rspamd-Action: no action

Hi Ralf,

>+int ipxlat_46_plan_prefrag(struct ipxlat_priv *ipxlat, struct sk_buff *skb)
>+{
>+	unsigned int pkt_len6, pmtu6, threshold6, frag_max_size, pkt_len4,
>+		old_l3_len, new_l3_len;
>+	struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
>+	const struct iphdr *in4 = ip_hdr(skb);
>+	int l3_delta, frag_l3_delta;
>+
>+	if (unlikely(cb->frag_max_size)) {
>+		DEBUG_NET_WARN_ON_ONCE(1);
>+		cb->frag_max_size = 0;
>+	}
>+
>+	pkt_len4 = iph_totlen(skb, in4);
>+	old_l3_len = cb->l3_hdr_len;
>+	new_l3_len = sizeof(struct ipv6hdr) +
>+		     (ip_is_fragment(in4) ? sizeof(struct frag_hdr) : 0);
>+	l3_delta = (int)new_l3_len - (int)old_l3_len;
>+	pkt_len6 = pkt_len4 + l3_delta;
>+
>+	pmtu6 = ipxlat_46_lookup_pmtu6(ipxlat, skb, in4);
>+	threshold6 = min(pmtu6, READ_ONCE(ipxlat->lowest_ipv6_mtu));
>+
>+	if (likely(pkt_len6 <= threshold6))
>+		return 0;
>+
>+	/* df packets are never locally pre-fragmented */
>+	if (likely(be16_to_cpu(in4->frag_off) & IP_DF)) {
>+		/* Let the IPv6 forwarding path raise PTB when needed and rely
>+		 * on the reverse 6->4 ICMP translation path for feedback.
>+		 */
>+		return 0;
>+	}

How about putting the DF check before the PMTU lookup?
ipxlat_46_lookup_pmtu6() requires ip6_route_output() and dst_release(),
but the DF bit is much cheaper to test and is typically set on most
TCP/QUIC packets. It looks like a pure reorder but I have not verified
it carefully.

Best regards,
Xavier

