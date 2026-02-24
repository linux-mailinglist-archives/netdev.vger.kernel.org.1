Return-Path: <netdev+bounces-260461-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGIxHgmHnWnBQQQAu9opvQ
	(envelope-from <netdev+bounces-260461-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:10:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC63185E81
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 763ED31402A9
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE60372B28;
	Tue, 24 Feb 2026 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BhJKf+yb"
X-Original-To: netdev@vger.kernel.org
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010017.outbound.protection.outlook.com [52.103.72.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B4377F39;
	Tue, 24 Feb 2026 11:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771931231; cv=fail; b=MAsOJol+7TwFCgD4THxjDiU+7RHAEKDsJEDOpl/sZiQI0iS2evyJr5LteDSUGeI8rxGbS/5Q+fUkr/iBYIchUIOSLVy45DzdPPNw9k7+bldODMzwlJMWjLFD+oCE5DcbeCix522BPPkZG6PgEwsszqptqvomAhE2kgeW6GuXZ3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771931231; c=relaxed/simple;
	bh=5+4jDXAFZfILgGhgveBSiZ0bo2DVEEaepwm2o2+Y77g=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=HPd6TPH58Pwgrng0vkYLmS+lbfxmd+hSAAWzgCbDyESdjSnKXo0t7NSmuokJ72rWYm5x8pixb3IVLMQOJjC6qbtEearorioln+hz0AKRNyN1uu1pNjq0lSE7NKA5a09+dtT7MbggsHUbHpMRwYMK9+zLr2MrsVNCSN2Gg/MXDGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BhJKf+yb; arc=fail smtp.client-ip=52.103.72.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpdUbOZwn3EdDUfAQWvrSozI5ZH21XW9J5qnS6wiNauaMgHEZ4Dtkp0lZVtOpPgOu0uHVZ5kpPh3ElHUuTOFSF+AdZI1Le6wwqGtOBMGHLjjxF0ipzNnpwLOmVCSaI0dNZKf7rMWeeJ1NDEOLMsiGVfWhPnOglQ51OifTCJLfinhMe/p5dVYaU8Rd81y242YxeYrWCtIcA9rdMuYQgzX9LDDjssTC0gpscbRnt5pGtj3616/PJL6QvoCQLs/F+Zwf23XNlMdrKwIPjKwWLMUCAFc0AtVteKgLNP4+5iT0GQXAV9L3MMc0KpsJZqpGdYKbv5UR5jD6Bp3I9CFd1PG4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wK7ukD5rVvKAjcDE4KrxA96FgAGHtFehvXla+1qSiY=;
 b=mM0Kw56aVZ3rxamrBwOQE4LITZCTdUU3n8+KwVXobG+RnifRgI81X2+4Ec3pkBWZ/IOCjyaJalosZ2lhAlGSK7jMlERAZCIpsZOjDJJ7tcl/F8DIqenrWjBUlugi2o8OuaGwEZ6KmZMrP4+amw9bww4ciycnl4PNxki+UpnbpeOJRbvSPlOiH/Tz8hdkFH/AxVOXJWE/NuVi6SzI0KmzzsrBXnufnSFz69cLoLY1Yq46qtX8FGpN6CsflBnDBvqK1ObyQCIj9oA2WDXj5H7jWBfM17arTGVPhT80QeE80d3FIHfE/MNQ+pVGBw+IMmV0OGia17GKJlmZAPQ529Pe9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wK7ukD5rVvKAjcDE4KrxA96FgAGHtFehvXla+1qSiY=;
 b=BhJKf+ybQpjTxzgm+Nuam8RdTLSZCRO+G5KTIaYLICjeuCLnYMEkp1FNhl1uWk4dKfRmdWk9JchOQu4q6oR+wpL7lOU8O/Lyl+l0M2krcjECk7ZPkYr8mSZ21p61wcWneg2pGAIYEv2qHBgN4vVm2+9fxqPet7VMatKB+OcGNcA2gME/+U0iBOz0WytO5lJF8pVU1gxwtPap1mba2VR48qjQOxyAmcQ9xWjMNx5ZNHjek2RaYcq7TSOWtCo5E8OM4ByhxMdu+gUkNjeIJ7J2UIJDC+mtLyQdis6Un93Ps6EHMI8Mrmfn0Sn6dGrk/LZEUuCo9mUG6OmXomWypJ8hLw==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY7PR01MB10246.ausprd01.prod.outlook.com (2603:10c6:10:2ea::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 11:07:05 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 11:07:05 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Tue, 24 Feb 2026 19:05:56 +0800
Subject: [PATCH net v2] dpaa2-switch: validate num_ifs to prevent
 out-of-bounds write
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB78812B47B7F0470B617C408AAF74A@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2KSwqAIBBArxKzTrCxDLtKtJCcajYWGhKId89av
 k+GSIEpwtRkCJQ48ukrdG0D62H9ToJdZUCJWiL2YuOHorBKmdE4N0gtob5XoD/UdQZP9+cSwlL
 KC1cJhJliAAAA
X-Change-ID: 20260224-fixes-a33979dd5060
To: Ioana Ciornei <ioana.ciornei@nxp.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2221;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=5+4jDXAFZfILgGhgveBSiZ0bo2DVEEaepwm2o2+Y77g=;
 b=owGbwMvMwCVW+MIioLvvgwPjabUkhsy5bX6G712N2csYfbbxSfXOLH2y9sSEBMXM473+LVr7W
 hRj2t06SlkYxLgYZMUUWY4XXPpm4btFd4vPlmSYOaxMIEMYuDgFYCIesxn+qdVNfHYwsWZevo2c
 7r4lh5wnHNGLX6zcuOWyz70vc++vdGRkuMcgfdEo9b25x+mox90SpzweJ5/4d+ajSpKPYAPz26U
 P2AE=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: TYCP286CA0060.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::15) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260224-fixes-v1-1-a95b8232c629@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SY7PR01MB10246:EE_
X-MS-Office365-Filtering-Correlation-Id: ecadfbdd-3676-43d7-4f32-08de7394d6a5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|8060799015|12121999013|15080799012|8022599003|19110799012|23021999003|461199028|6090799003|5072599009|1602099012|4302099013|3412199025|440099028|10035399007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzIrcnc4ZGJIZVdQYzhTOFRaak1PM1ZoMkl0ejJGanBiNlBHN01kOXJWb3BT?=
 =?utf-8?B?dkpNN3M5SDNMQ2xwMmRUQjZlM1VIL2lKdituYnZ6SEtHM1hYRnlnTnJhNkpi?=
 =?utf-8?B?WFIvSDluNTNrbFh2RlczMUNnN0hmdG9SdE5pcG9yYVBWVjliR2s1eUhGYURF?=
 =?utf-8?B?NmFBdlNVRW9rbXdxVU9ZbnlSdjFQTWw0Y2xiOE1TeHFHQXBUc2tCQ0VSekRC?=
 =?utf-8?B?OG1YZVFzcDVqeGdSYUo3bURuQTFRZ1dxQlhSRVZlN01hY2ZsWUpvUXRETnJR?=
 =?utf-8?B?WFZYeXRvbERUWVAzaUpwZ2hCenlKWjEvdG1jaEdnTlFCQlc3TXJHR240SjBL?=
 =?utf-8?B?K2ZuQ1FTWmp6K3VwTDl6VkUxZUU4a0xLbE54R25IOS9UYzhkNm1SN3lwZTFI?=
 =?utf-8?B?OHVjVzNyRzBYbmhWaWJFRnBiOGxrNzVlKzY3VHE0K1E5MFpHekRmbzdEVXVU?=
 =?utf-8?B?NlEwSm5QOTRMbGJDalJHUDByaWNtTms5cU1HR1huYXJ3ZmJxSmtadFZpaG9y?=
 =?utf-8?B?UlNUZVo3ZnZaZ3NLTjJWMk1RbHErY2dmTGhUcUdWdXd0K2ZQSmRCRmoxbFVj?=
 =?utf-8?B?aTliL1R4MFNuTUJCY3EvOTlIZEZCdU5MRjNyRG1Bbk9HSkZ4Y3VhMWsrNGxi?=
 =?utf-8?B?eEFKUEljWW0wMUFsWWJLNncrWlRaL1VJVGFJS1hXa1VPdTRVek9UMDJhbklN?=
 =?utf-8?B?MWdlNldDRHVUV2kxd21XTjI1K29LSWM4TE8vNGljejZEWFNRUUxoNUZRUngy?=
 =?utf-8?B?YjhhRGRwVkZpZk1qSUlUSkFHWkpyTExkUlVTQ0d6Z09zbnVJOHAySExQaE1O?=
 =?utf-8?B?V0NYUlRySG16NnV2cmc3TVl4cmRxblQ0T0Z5K3g2Y3VNWlRKNVIzSzQxTDZy?=
 =?utf-8?B?VmZ0bmpGR21vQTBVR0NPck9EQnFFK3FRRGhoc1VPVDJhYWtWampDcVFPNkc5?=
 =?utf-8?B?dnBCTmptZTdCZ2tibDZFV2lGUmJJOUoyVXFlMGNvKzlpQmRVa0pPN0Z2SEE4?=
 =?utf-8?B?UC9OUHd5RlhIR08xUWlxYnhsN3lpVGNTb0ZVd24waDU3Y0pibUdaSXN6Vkk1?=
 =?utf-8?B?aldaL2RUZHpLaDI0Z3ROa005bVI0NmRWK3ZuVXg5LzFyOEV0RUdJRnBwSFl6?=
 =?utf-8?B?Tlp3VXhuOFN0aE9zN3N2ZUdxY3l1L0ZBdXY2VUdpanViaG9OV2FBeVZMc3lu?=
 =?utf-8?B?bVRjSkZDQm9NMXpVWjFkbXRoMytnMEFHL1FQU0k2K3k2MzRxcFdHa3oxVDFu?=
 =?utf-8?B?QTZSR1prTU05RG50c2x1dFlaMjdQanpmalNQcEc2UHplekJRVGpQZWxMUDIr?=
 =?utf-8?B?RnRSOWNNQmpoVUF4YkRjNDk2VDhlVGNTcU5SczBiVnQySUpobEkybzd5UG5v?=
 =?utf-8?B?dkplWHFBK21lbTIzakNPS3ZpSC9KQ21ydTlFM0twOG52ZHpOZ21US1YyNDZW?=
 =?utf-8?B?UnFEMisrZHJPelhpZDh4dXdlbVBESzQzZ2VFWEVHYWxhaEpSK29YdXJQVzJi?=
 =?utf-8?B?bnRmbWYxMUhBenRvY21kVytOalYvWlZlSVJZZjM1WjRzNWxkK29iUVNTM3ZQ?=
 =?utf-8?B?T0dUdjN0Qys3YVRkYmVoTW5EODdTZEE0UzFLK1FlMi9PSVZqMFJVaHRFTitK?=
 =?utf-8?B?R0JBSXJKcGdnV2V1bnh0VzVTZGNqN0NQbXlsb095QVlKa2xmODdUU1ZHS3JE?=
 =?utf-8?B?NURqYUJUcjBMejhBY0xibTNNMnZyWVRMeDYwUjdnUHk1LzRIM2xUVktvWGEv?=
 =?utf-8?B?WUovdEdOQXhjcEc3QUxPRTQreFhhdHBnMUJmbW9md1VMUEFxczNTU3Z3ZjlH?=
 =?utf-8?B?SzRTZXNFNHpUT0E1RXVZditSY2VXYnBPSlhYSkpCSjlyQXNNRXliS2VNNDlS?=
 =?utf-8?B?a3A1dStUMHpTUkJCZ0EyVGt1Q01yRncrSzhMbEJGS0FnSHc9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sit0alIxZFpYZ2VRcUhkU2NSSml3SGFVeDZKTU9MMFRjeW8rU2ZpVlJGMXkv?=
 =?utf-8?B?YkhWOWVRNXNCR1UzTzF2cmZkcG5xVDZHTUpXY0lGYlVxdGMzMWh5K2M0aFRX?=
 =?utf-8?B?bUlZYStING1qOGxqcGN0TEkwYjdZUXJGMkRrZFlJZW1raVY5UytSd3VMQU0v?=
 =?utf-8?B?bTNCZVY2MU5HTU1JckgzSlVKNXdvajVzTDJ4Q0paTGVySW5rRHBlQ20xZzJF?=
 =?utf-8?B?clc3bTA2TzFvQnBBVW1Lbjd3dGtsUjYwQkJxSSt4OWg2VytFOVBKUjczUWhS?=
 =?utf-8?B?VWZvQXJOTlBhOGJQeEFvY3g4QUNRenBDMVQ4REw1Sm5xSVFpK2I5akR4SGll?=
 =?utf-8?B?SUxlUmtodzFicW1iMDJuTkNpSnhMNTdYcmdHenR1OFdOcVRsNll1N1B5Ynl2?=
 =?utf-8?B?VTFURnlLRVdTZTZMWGo0U29UTkNrRXJ4TW5OR21TS0x2OTRlYjVKT2xEaVRu?=
 =?utf-8?B?ZnhvMkp1alZmYVE0QmxBTmkzWTlXNXgva21jSmpBRnArTTExa1Y0aDg5NVlB?=
 =?utf-8?B?cnc3UzNqelA2ZjFLRWU1d3h6djBjR28zRW9oTnZML054WURzck5FZlBEbk4y?=
 =?utf-8?B?RE5ieXI1NUwwVDdYbFZEeUppaGVDOHhtVEIya2RMZVJYTXo3dnZzVm9MTGRD?=
 =?utf-8?B?ZnRqL0ZodnV5bWxPcWhRNXJka0JHbnFxWHgxcEZmVDhydHZYam9SNDlvOXJN?=
 =?utf-8?B?elAwbEs4czFWZm1oYUFoVy9RQmtLZnljaVNyMEdkZ1ZiZm9ObmRkdGtyUGF1?=
 =?utf-8?B?RDgxSWJheFB1T3lTckVUZHplRmlyMmswa3hNblZvV3V6Q1FtODM2bWZ5M2tK?=
 =?utf-8?B?SUkrYmo1T2QwNFZMdkJ5OVZPaWUyZXZ4VUhTQXZSYWZBamoyaTkrTHlhRWNt?=
 =?utf-8?B?TVN0Q2RpZ3Z3S1FVUkVxVytGQzhpdDcwbFJBbGxqb0RQTCtxNkR3a2pKMlNv?=
 =?utf-8?B?Yi85NVYyVm1RSVZrNTRROEU0dHdWTXhjVFpwaGFDSHNLaUNPM3hJdjQwVmN2?=
 =?utf-8?B?aytUVk9KR3FlVTZnanRTTmRheW9Kd0lweGUwSy9vbnhaZUVldWVKeDBTNzJW?=
 =?utf-8?B?a1VIRmpLYkI5TVk4ZHhvaXV6MlY5YVBTVHR3TFFFZExMZ3lRaWNHK2Y4Mmx0?=
 =?utf-8?B?andLd09rR0JGRXpsUmJVc0NUZ01KZndpK3EwQnRjQzVJTzNtK2xVUnU2OXFu?=
 =?utf-8?B?VHVoZkNFVHpzREVPVUVUZEZ6SUVhNjZMU2gvcGFDRGxwZ2Rabm9SYkc3QUVW?=
 =?utf-8?B?eXhiRlFvRi9JRkNpaUVOREthWmNzbEhlU1YzVkRVNmxGMjlmalpTWVNOTlRB?=
 =?utf-8?B?T0haL0xWRG9DS0lhNzQrN1U2aTU0QkJ3NmJQaUQybUYxdXVpU2U2WFN1ZWhR?=
 =?utf-8?B?TWhqRDRCQ0hUYzB4Sk1JZExnZlJidlJkeTdEUmFreSt0bW9PakxvMU1lbm5l?=
 =?utf-8?B?dU1OQ2E1ZG9qeEk5UndXYVNVUWFpcVMxKys3U3ErQTZtRlA1bWU4Y2QxUGh5?=
 =?utf-8?B?VU9XanhMclo2bUlCZmtIRVl1cDdFZUFhbTJMSzZWNStoM0pTTFRlQmt5YlBO?=
 =?utf-8?B?T3pUeVNQS25QSVgxOHl4dTYrY1dyL2E4NVYwcDhrSjdTUUltRHI0aWRrREts?=
 =?utf-8?B?OEh5bzc5dVI2MnB1eVR6eWQvVlQwWHJqVDQrc1QyUDRJL1lkU082Y1o5cVJn?=
 =?utf-8?B?ZEFoOXRDbGdRdTVyeVpjRmxTU3BPNVVVREw5SVJ1ZTdpVTRpRmVPUS9HZDNO?=
 =?utf-8?B?eXowR2k0RWhKMXVveVRwTzl4M2pSZGNYOGpnSitTWHJvYUVRZXFZeDNsWlZE?=
 =?utf-8?B?bTdUejgyYWwrVVIyajFaY05yaDdVcVYzbkhoWFRCMDZKcUsveWF4RW5aeWg5?=
 =?utf-8?B?cnlpVDFxcG1qTVl6bXVLR1dYcEFOYUhQY0llRzBGUnhUaWc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecadfbdd-3676-43d7-4f32-08de7394d6a5
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 11:07:05.4000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7PR01MB10246
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260461-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,outlook.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email,outlook.com:dkim,SYBPR01MB7881.ausprd01.prod.outlook.com:mid]
X-Rspamd-Queue-Id: EFC63185E81
X-Rspamd-Action: no action

The driver obtains sw_attr.num_ifs from firmware via dpsw_get_attributes()
but never validates it against DPSW_MAX_IF (64). This value controls
iteration in dpaa2_switch_fdb_get_flood_cfg(), which writes port indices
into the fixed-size cfg->if_id[DPSW_MAX_IF] array. When firmware reports
num_ifs >= 64, the loop can write past the array bounds.

Add a bound check for num_ifs in dpaa2_switch_init().

dpaa2_switch_fdb_get_flood_cfg() appends the control interface (port
num_ifs) after all matched ports. When num_ifs == DPSW_MAX_IF and all
ports match the flood filter, the loop fills all 64 slots and the control
interface write overflows by one entry.

The check uses >= because num_ifs == DPSW_MAX_IF is also functionally
broken.

build_if_id_bitmap() silently drops any ID >= 64:
      if (id[i] < DPSW_MAX_IF)
          bmap[id[i] / 64] |= ...

Fixes: 539dda3c5d19 ("staging: dpaa2-switch: properly setup switching domains")
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
Changes in v2:
- Drop self-referential Reported-by tags
- Update Fixes tag to reference 539dda3c5d19
- Expand the commit description
- Link to v1: https://lore.kernel.org/all/SYBPR01MB788110DFE66BA1A5CE7E594FAF6DA@SYBPR01MB7881.ausprd01.prod.outlook.com/
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 66240c340492..78e21b46a5ba 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -3034,6 +3034,13 @@ static int dpaa2_switch_init(struct fsl_mc_device *sw_dev)
 		goto err_close;
 	}
 
+	if (ethsw->sw_attr.num_ifs >= DPSW_MAX_IF) {
+		dev_err(dev, "DPSW num_ifs %u exceeds max %u\n",
+			ethsw->sw_attr.num_ifs, DPSW_MAX_IF);
+		err = -EINVAL;
+		goto err_close;
+	}
+
 	err = dpsw_get_api_version(ethsw->mc_io, 0,
 				   &ethsw->major,
 				   &ethsw->minor);

---
base-commit: 9702969978695d9a699a1f34771580cdbb153b33
change-id: 20260224-fixes-a33979dd5060

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


