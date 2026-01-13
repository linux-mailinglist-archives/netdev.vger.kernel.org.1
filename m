Return-Path: <netdev+bounces-249527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC8ED1A6E0
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 17:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 670F73011B12
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 16:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FAB2F2607;
	Tue, 13 Jan 2026 16:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cBIMd1RN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dcEuPnwG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855FF2E541E
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 16:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768323316; cv=fail; b=Vni9Mjm0kLslhU5pC4BNkNG37czQo480saJMQeuwmiPWHF19wZGe1bO7c8kSKYOuyIk94je7DGGfcwpM3vi3whlMbGOhj4EVqnwKU0TVelCZE4x0zv6JvLEHHgHJVytA4+14E0fqbvSdpmWMnQploUR9wIfH4luxmf8HvJwpZQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768323316; c=relaxed/simple;
	bh=OP0LjI1VSdLc+QQkhwue0whDaYzApQVnuPHidzMw7yc=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=DOVmDfJAauOkTO2TMeTRZGO8UR2JOIfiMdfAhuTme/PO8LZCWssS7SVAnZKriZ2igutM/0axTeHq02fI4FVD+qAqmzO/PsgT9AOEuJdfl9G3Z6VssBzkWjSnXkvRrROrFRaFKjPch1KOV4dbEJ6j0bgnl08lgb96U5SOq3Xgg9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cBIMd1RN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dcEuPnwG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60DGOu5L2686260;
	Tue, 13 Jan 2026 16:55:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=yN3AHeARsGgtQ5q6
	rP942gRboe9iLwkqL6gu1nHRGjM=; b=cBIMd1RNjrvbQlilwP7UcFNGbX+ImJ8v
	nS8WW9Pt/+ey6tjT8lDTcxKjSFkMnIy8ngNmyLMKeEUgDudyF8dalV0qvIrpqjao
	Ce+P6bQ8t+pg03m6ZAtj5xBEuzBe66FwD2W/FKARYiIM++WSam+IwId2CurIJAvd
	IuLl/3N3SqOkQSqRiuNSOo2L5uD1eyiWnwncBEddBKm3+o2C5V3VL9DSksgm+erz
	BeSST7oquTkfJ2Vvc8ANZsCzOJVOLYB20G0/ijJEGauODi1a8ec9HsUb0pMUnOsT
	N65/ao+ds3lew91IYN/vcZE7SPKXAsTW2f0N5GKTY+BUxyHNP7lhEg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkntb3tvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 16:55:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60DFukAK008167;
	Tue, 13 Jan 2026 16:55:03 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd78qa9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 16:55:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rA3EomiqxZSmwjP5y6B3QABbUVgwOZZpMr7eEE55cBiuBc2RzCtZXYA2YaRjxGC1K7S5HbW6fWPUmxUhahkrQp4LlU5ZVxHgaOeXGOrjDThl+XUtFzid0DaYZ1PdwKuZDm2wjhGUbnJm084ae25Sscp6sfxlOPwc9F2lN0KbOB6duc9NPQyaivPFZzmutlxkmQO+BB/He+pgjR8DWy1jNdimHD7cyJOAlkhc2Q1NTTjDXaVM1jKa2kA3LzyIyyz5nQ5C20UVeN6F4vD8KeReTmlIsr0iLPldOB/TNvohP6a94BURh/MXMx7ZNb0JMXbFWZcD6RupfgXR7e1s1S2nYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yN3AHeARsGgtQ5q6rP942gRboe9iLwkqL6gu1nHRGjM=;
 b=fYvRX9GQnsilmt5QaspQM2ssYG4DNLpfA/EVTANHPmvpGKlZeSq1cbnjW1uBi9C8+2UGXxXRkZsE0ivpiwSp7VAg14VigeUk3IjFd5E1EczJtQLWFT78cO4DPH5zpXWnDNXRZT9LvDniouX4hfzrVOfOxFRmZUYUpjTYRrmEg3bPoHq7Y9h2YdAShuzhflSd2LdK8yaKTtb7N5LySUbcsx7df/i1uZpfY7Jf9uEW9dghMfkhD2/tNxecuevBODkum4vz3T+GzDhrLWW5vEhEZvPc5Fr3YILKIbSnopU8kPgj8fTfhTOVvp/siUgZ2Q2RFEeMd+MgBT+k8PkxM7zrgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yN3AHeARsGgtQ5q6rP942gRboe9iLwkqL6gu1nHRGjM=;
 b=dcEuPnwGczXhm1J+eN1gmQcCfl1HM7a6ou8hyWh5UTmA3YQE5wNcn5Ws09//MGTlFNfs7QlWUXSDCNh3vodHBTVfZPv0vfjRafV3gpdA7lC7mENiLCiKzHN3HOO9zFxQhQHaEryVaYvrJveDLsuQntilu0IOR1X8R98yiSm68GA=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by CH4PR10MB8100.namprd10.prod.outlook.com (2603:10b6:610:23b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Tue, 13 Jan
 2026 16:54:55 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 16:54:55 +0000
Message-ID: <a3fd45b2-bfed-4780-8351-a99f640df87f@oracle.com>
Date: Tue, 13 Jan 2026 22:24:48 +0530
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        bbhushan2@marvell.com, Hariprasad Kelam <hkelam@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
Subject: [bug query] octeontx2/cn10k: CPT LF IQ drain loop compares DQ_PTR
 twice
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::17) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|CH4PR10MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f5d15c9-606f-446a-a534-08de52c47a60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUdUdUdMcG9PUDh5Z1ZiN0tqdDdDc2ZSTzZiZ1hEd2pjbG9YSkNza3BpdDZK?=
 =?utf-8?B?YVhhR1k4S0ZtMGEvbmk0WTg3MWNRWGJpTDBBVExzbHh2TlVJd2NDS0dlWXl6?=
 =?utf-8?B?MVRqU3VIaThyOTltbFRaSllEMXFWdWx0TWRHeHZVMEhUREF6RVJRdC9EcmF0?=
 =?utf-8?B?bFpKaXQ5U3FYcy9iREVWSTBBUWRESzdkMDNaQWJNSlUvNEQyWlRUaXJJUkJC?=
 =?utf-8?B?am90dTZmTUxBUnpKUkhVRGRhV2RBQkZ0MndRbGd3dWhYKy9NVDU4ME9UNDZ2?=
 =?utf-8?B?ZmxJenVwUWFRb1prK2ZKMUc3endlSUE2MU05WUZYeWxpZFE2TkpvbkI4QnV5?=
 =?utf-8?B?TTMyd3JJVGM5WkZzTncwSlp5eFdjM2hoMGw1STZnYUx2OVptWTFKQUJzNWtu?=
 =?utf-8?B?dXUvUXQyVlRKdVk1NlZRdEVDWFpyOEIwU2YwTjRyZVUwcHdUZVoxQ2FQNks0?=
 =?utf-8?B?eldUcWtQUVk0bEFCZ0xrQTIxc2RIbUZ4bWhOT3gvM3hTVEpNYVU2Z1psNXkw?=
 =?utf-8?B?bHphTUhRYkR1QVpMZnY4S0h1bE5LYnd3SVU3dnhDcCtsUitGSENkSnJYVkdR?=
 =?utf-8?B?RGJBYzVHcjMxLzZBekZIOHV0cm9vZkE5UGl0QWZPZk16RUVyd3JwM2dWaXVw?=
 =?utf-8?B?elM2c1ZjZkRBQnJGVVlIRENIajFFbCtZYnE1eHpObzBhZXBSa1pWeE1Ld0JX?=
 =?utf-8?B?ekIrenZhZi9tTUtSY04yU21FL0tFdk9COTBmcWhTQzdXejVURGp0RXpycjRx?=
 =?utf-8?B?UHMwM0N6M0h6aUd1NlY1Q3Y1VU9YWVFycUFKOWF6czgxai9qNS8wenE0QUhN?=
 =?utf-8?B?V3hHdWxoczBMS20vV0tyUG9wbjVrcjNHNTMzQWtvcmxDdzRyZCsrL3AzWkdv?=
 =?utf-8?B?R1NrL09FQmt3dWxrTGVLQ2V0UkpHUzNQRk5XaUlIbUg1ZGRTNy8wdjd3RjZK?=
 =?utf-8?B?c2Mrcm5aSEVLVGc1Y0ZkSU96Z3NUVFI1MEJiT2x1SUpVQXdaSGlpKys2bXR5?=
 =?utf-8?B?Y1E0WkNWZVp1S0h3SUQzdldXRkFjbWo1d2xldjlyUVJiN00xWUkxQnFrN1Bw?=
 =?utf-8?B?THF4MDFkVlRDMm4ra0ZCYkdIYWJhdzB5ZVEvMU9MdkRPa3pqZ0J4S0NVYkdy?=
 =?utf-8?B?ejdrQU1iaVQzUWpiZGJGQmhSa00yeW0waFJoWU9kblNGd0RjRTZUbjdjQjhU?=
 =?utf-8?B?Q2kyZGliTmJWcXRiVWpqakZWcUY2bnp0Uy91NzNqM0dncFlsdDZBTmJVMFRQ?=
 =?utf-8?B?RE9tNE1oSklhbHM1NUJqY091T3Y1YXA1YVI2cU9QK0FGS3FyTjE2TGxURzZm?=
 =?utf-8?B?dERNSWk0clFqa3ZVRkZLUzBSTVpFZVB4cjFXQjlqdDVabnBvakVMTHJLUHdu?=
 =?utf-8?B?TFdhQmtMODFza1pBeGROK005VmF3VmFKSTQ3MGxLMHRPYWRmNU12WjZhQkRR?=
 =?utf-8?B?T3JzZUFoK3N3bzRORU0wYjBESzZGZ2hncXltNjkvb2dZTnJUcGpUODZndm90?=
 =?utf-8?B?Y1dXV2tJSlByZEdNUHpPM0Fsbm9yTXhrd1FHMUwwSmplcGQ5TFNTUHpBOTdn?=
 =?utf-8?B?ZTZCUmRaMTRJSG9mNTVNV00xYW5IVXpCVmRIMFFKUURTK0NRWnhLS1E3alFJ?=
 =?utf-8?B?T1lmdlBxMzNBTTVUU2Rpb01HVzhJRTd5M1VMQThQck5BMFNSczNwZnlJajRs?=
 =?utf-8?B?a05EZWdqMUM3cGxja0F6WFpZdkNlYWM4YXZjRDQ0WWMvTEpvYTg1MUk4NWxK?=
 =?utf-8?B?QXdWbFN2TExxUTRoVk5SVHBKRmFudUc3MGlNYXRBZlduOTBhV3I3R0N1S21B?=
 =?utf-8?B?YWVLOTBkWlM2K2JyTkd2aEVLUFVNc2czL21wUmdUMm42Z1ltZ0NXUHd6cWFG?=
 =?utf-8?B?YUtKZVZMbXFTV3JKcUJCa0ZEK2IwUmh2SnZKWmtBaXJBaW5nRzhKYWJJajB0?=
 =?utf-8?B?VzYrSjJVMFJ2TTRQQTRKK3VPUzd3TUhuWE1KNHkxZTVqSE05aGgrNDNKTTcr?=
 =?utf-8?Q?MJrspdxykrfE29xSA/nfR83wH7ja7A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmpFNnFkSUdxaGJ5RUJobW10Y0g5RjllT0xobTlNZXVtZjd5ank0ZDl6S3Ja?=
 =?utf-8?B?VENWM2lsaDd1RmZlRjlQMzFhd2s3bFYzK3ZrdEFpTEFIaXlvZXVjcDViSXRO?=
 =?utf-8?B?bmpZQ3l0NlVITDI1UHNRNzd4YmsvdGRheklZSFVwUS91Z2VOeEl0b2xjaVZL?=
 =?utf-8?B?WXRhL2lwNUJVZmQwYXo4WFJsM0JpKzRUT29EYUt0b0djRWVoKzV2UWY5ejFJ?=
 =?utf-8?B?b0l3aHA1UHloclB3MmJmaUNFa0xhQ1ROdEx0QVZYaitOMGVzNEVuem95STVO?=
 =?utf-8?B?c2RiOHlTSXhTMk5vVFI3T3VhbE43Nmc2ZnhRVWt0NGtjR1hHUXBhWnB4dkNN?=
 =?utf-8?B?N1htdzF2RU9wdmtZRklmTEZMN1hXZGlyOEt3Z3ZEaGVXUFpWQm54WDkza0hJ?=
 =?utf-8?B?ekRZTWlQeW1KN1pLZ0Y3Z20xaGJiSWpSaDVNT29vZjVjR0pJUnR1WDdFRUZk?=
 =?utf-8?B?a05tdEJnYnlNZlQxbDUrcFMzamJtbHRsOVpSSEVNbW5sY3dhVHFpSXFZbyt0?=
 =?utf-8?B?Y3pPQlRWVXZlT2FGalg3TjVHU0dRU0JpamdSWkUyZzhKaSszbVdOUTc5Nk1p?=
 =?utf-8?B?bHBQY2Juc1VmSkM5cjFweDJSYWFLZlZkWk1FQVBkNUNWUmdDcm92Nmh2QUtk?=
 =?utf-8?B?eVRUV2ZOR3Ywbk42eFFZV0dWU0lnT1ZDdDc0cFRZQWVualpkNUM2MWR5WWVY?=
 =?utf-8?B?MUZvbExwakhoRHRjRmhWTFZoak5oNXZJZ2RhRHNSODEvQk9kb0RqMFM4dktt?=
 =?utf-8?B?R29DTG9LM2NhUE1jWElhc1h5WGtKOGZoWDh1QTZxeHdIQy9lWVRUZU12dVFm?=
 =?utf-8?B?cXJYSXZNQWJITzl0Z0gzZ1ZYajdDL3graG5ySERqbW1pWU1UVXVLV25PUkh3?=
 =?utf-8?B?RWNFVHdheFVvOXNWYWlmVzhFRmluZ05EMXloRlRYZDloVWY1SFdYK2EvcVkx?=
 =?utf-8?B?QkVDWHhEMVBtSkd4NVpodC95bzZ2bXE4clg4anVXVGhoRkxnYU0zZ2VpRGFW?=
 =?utf-8?B?UC9CSVRXUFhoYUs1cmNQOXlVQzM4T1oxQ0JEVGxhV1hIbCs0WDIvUUQrV1hG?=
 =?utf-8?B?QlNaL0VNVHdlM3JQdlZHMlFTc2luL0lNTEcvMXlsUTdMY2czbG0rcE5WdVov?=
 =?utf-8?B?ZDNDRnFlWktQejE1WTk4ODVNaDRUdVlPcEZwSDhwNTQ4ZGwySHpGZEhFSDhi?=
 =?utf-8?B?b0JUemlORktObFZKYnR2elBNempnNmxyRWNMZU11WFdEVkhZd0xHU3hQSjQ0?=
 =?utf-8?B?Y1lSRFdJQlZKTENXU0xTQkZuSVlnSTM2eE52OEg2bnFJMDdZbU5rcHVyeVZu?=
 =?utf-8?B?K29DajR2UUYxeDNIUVBiSHl0Szd6WEVhckU4M2Z3M2orVkZCYytoRFBHOUEw?=
 =?utf-8?B?WURQbEZBaGE4Si8wY0dnaDZxZ1ArcHZHa0VRcWNzbTBoR0dzb2hXRTdaSWUz?=
 =?utf-8?B?amUwdFJVWFFpSkhIOTFOS3g2ODRuQVJXRHU1RENycEw5Wm9HUWJqdG4rVkYx?=
 =?utf-8?B?aFNDMmpyVDJkNkNEUyt0K3VlR082OVVzTmtTd3NMVzhzRk1QczNGMzk0aVp5?=
 =?utf-8?B?QnNwUWY1QnJncVlPb3l0d05jdUJEeHB2YWVNSHdUL0V5QkY5LzV1cjNaK2Uy?=
 =?utf-8?B?dHpvaHhGOC96ZjROdG12WEJMZ2d1dmJjMWZsSXpGTzVzN0hDNlBpL3pSWEd4?=
 =?utf-8?B?THhJM2dmZEtmQktiUUN6WG5MY1ZjRzNFTzFKaUhMR2dSb2tWYytNYzNFV01V?=
 =?utf-8?B?V2o0VS9DbEJIaHRKT0lIOVcrTGxQRXNrWUQ1RndiM3JBejh2WnBiTWtKQ0sz?=
 =?utf-8?B?MjZSamo4OWU1UnF2aklOQ29tWGx5L0FGNTdVSStFOTJKYkdXdjVGc1gvV1Vj?=
 =?utf-8?B?dHUrRjR1VXBjeTNpMkRYd3k0eDlBeGRiVDY1cXExZHFVT1JsaUprZDAzSXJ2?=
 =?utf-8?B?K21VZzF4MU1YTHR0VUJkdWxEcklWWHdzNDIwQ3hZNk1ZbzJEZ2JtVjZLaFhQ?=
 =?utf-8?B?bTVabzRUcFJLNXYxZVM5V1lSa1k1akRGNkNYSjh6OXA2aWJMWmY3c2V1NHda?=
 =?utf-8?B?NmhHayswVHNiUjN2SkZkZ0JSd0g2Nkp5YkN4c09kbWs5d1ZjbE83dzdXWDdX?=
 =?utf-8?B?ZlF1STR6Q2tHc3BOTklKYnBnWUM0VlB3bWwvTmNhWnhERjRBMzEzUEhPWXd1?=
 =?utf-8?B?MThtWG5EdTVQSDByU24xWFNsTkJZT3hrQ0FTeGZxblpna3BiMVlKK2trVlJS?=
 =?utf-8?B?U0o0ZldiVVQ2US95R2dMdU5DbDZPd241Zk5lWDFJOU1iTGFYcFRtWmp4TlBM?=
 =?utf-8?B?NEpuR1NzOEpyYTBGQkQwTnBZRmxya3RLbXM2ZTV3aTFwUW9hMXM3UGc3b1F1?=
 =?utf-8?Q?LUOkwVyGnakbAXlw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	noLSNvmTt6M0lsULwRjP5iPD90+DmbrW/5kRRkOVn3pbFNRWriyNiUQIF9YJ14ilyaaiV6E2eaPYfZNFbvVJfaOzPLaSyKl12gPKQASYsV9mfXlNbGvxVIKREzqRlGveFXIkUoQ8XcgmOWUlmAv1sfcbPPFx+Jl0wpNSVwCdHtNUTGvd2HK9sOyVMZpliv61CefiLgrtjSA5cY3QGQtc+9TF1j2jfGBdDEgVjY5Oe2zKRbC5Ag45vyMx88adcaHg51/IISgJSZn1/3WTAVwAriZii6UM6XTaVYWxz4oxXnXf62Tr9BAZXwImIunmMpJiLAFdPRr3RfJ85zb6y842pyK8mja0y4mPYBleBa8gcZYjuonzHY7ii+8mE7V1PlrbZNdtS0warfQ0RxoPMbExUbYOMdTJYUWJss8ibGjskqLNw7kvSOvMvXCKjbd80rZiq88OQY2+95YeaZnljQGjAkv5Trh8VhdTvNa8AxB1cD0CWvoLNdzXGM5yDr4Hz3hGnm/hxS5z0dh4C0fXCN/4uQe/LOoeDxoGajRfBjish20Bm9O1LmcNtUo3f4KyPEg9nWRu422JA8SE6Kxw3o7UWZpSd8UOzFIUofn7E+hVbmk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f5d15c9-606f-446a-a534-08de52c47a60
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 16:54:55.4860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKWbm3dR0+JGVk5zGsIqwwk4YCAbFQjNNzdkiFfgt5lUK3yl+CjihfuCPZiFG/g7MCdJnvcEVHbWQkhZburCNQdLO6J5d9pmnrszFSAn3NA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8100
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_04,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601130141
X-Proofpoint-GUID: CCP-6qnoWCsLxJ59u5bSyoKJ60QHRoWJ
X-Proofpoint-ORIG-GUID: CCP-6qnoWCsLxJ59u5bSyoKJ60QHRoWJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDE0MCBTYWx0ZWRfX0LvI76N9zHk3
 Xar+nbIpq+GSYN2mZUKFr1ez38mgre12rC2yuz3ZqqHt8YkXACzAffqVOCLa93+M8YzaLbb4rUz
 X5DTSmCVI0pzPd01eP1gesbzt8EsOyJJc/kGQX/Ap13lqfqy9SaqLVFCGS+PSl8RVYnX0CeoW9C
 nM0IaCJVWPLTx4TNgHfKJQFhIg4ypBgEMmAubohbGAboO22N07pP6Irvq9ZsvWISrkLP+aKAFFT
 WeNftgFnSqkX/P84HRUrHqw0AMyVPnoB3UYGVy1XrE2qqjt9LC4dH4m9lnikokdd84e+fJty2GG
 EgVmsK2Ay6Hh3wXd5nODQ6eithYaQBCu3L9FrtnKV660cdKeoYffcULQASGJuQcgSL6rt7UbhEh
 C+/uUpMmojS0KQt5uk2apcC+zlBp7quTvyEbWo0aC3IswP9Pr/lOX2GiP2BXCwTTIDpg6vNuMep
 qJ3A33fM2Qeykt7AIqw==
X-Authority-Analysis: v=2.4 cv=fIc0HJae c=1 sm=1 tr=0 ts=696678e8 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bpLJjGG0hZqKZgjgWq4A:9 a=QEXdDO2ut3YA:10


Hi Bharat,

In cn10k_outb_cptlf_iq_disable(), there is a potential issue in the 
instruction queue drain loop.

The code reads CN10K_CPT_LF_Q_GRP_PTR and compares nq_ptr and dq_ptr to
check whether the queue is empty.
However, both values are extracted using CPT_LF_Q_GRP_PTR_DQ_PTR, so the
comparison is ineffective and may allow the loop to exit while entries 
are still pending.

The fix extracts nq_ptr using CPT_LF_Q_GRP_PTR_NQ_PTR, which correctly
compares the enqueue and dequeue pointers.

Diff:

- nq_ptr = FIELD_GET(CPT_LF_Q_GRP_PTR_DQ_PTR, reg_val);
+ nq_ptr = FIELD_GET(CPT_LF_Q_GRP_PTR_NQ_PTR, reg_val);


Please confirm whether CPT_LF_Q_GRP_PTR_NQ_PTR is the correct enqueue
pointer for CN10K CPT LF.


Fixes: fe079ab05d49 ("cn10k-ipsec: Init hardware for outbound ipsec 
crypto offload")


Thanks,
Alok

---

--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
@@ -195,7 +195,7 @@ static void cn10k_outb_cptlf_iq_disable(struct 
otx2_nic *pf)
                 else
                         cnt++;
                 reg_val = otx2_read64(pf, CN10K_CPT_LF_Q_GRP_PTR);
-               nq_ptr = FIELD_GET(CPT_LF_Q_GRP_PTR_DQ_PTR, reg_val);
+               nq_ptr = FIELD_GET(CPT_LF_Q_GRP_PTR_NQ_PTR, reg_val);
                 dq_ptr = FIELD_GET(CPT_LF_Q_GRP_PTR_DQ_PTR, reg_val);
         } while ((cnt < 10) && (nq_ptr != dq_ptr));



