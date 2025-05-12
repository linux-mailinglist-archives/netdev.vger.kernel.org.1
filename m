Return-Path: <netdev+bounces-189622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D86EAB2D28
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 03:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54F74189D810
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 01:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9938621ADB5;
	Mon, 12 May 2025 01:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="BUKbWHP4";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="Gm5+HLT5"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0024c301.pphosted.com (mx0a-0024c301.pphosted.com [148.163.149.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A29212FBD;
	Mon, 12 May 2025 01:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.149.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747013310; cv=fail; b=KarPRghLGmlqaYqiI58+AMxGGLKXSrzbRCtqxwwF54Flguv1gHzfZENdlLjSQdwHxb7thux3Qu9etU8DL+Kj2HRXDcwkqlgmDEldg8kLJN7P1b70ZZEgmBGFHZD21yG5Rjwvac741sGQIQhfyrUUDDf3BqHvT5GZrX/BdmZ/AdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747013310; c=relaxed/simple;
	bh=BOlevcCcopUqKn3RQdHywD/3nNBn2LVTd6rEH5JZs+0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W0jx9CwkZiDuLWeAmT9O8TEuAjkafRbU3JDIhFVZlYmyGC4hizl5HjsJpd6RyhTxFM3BElX2IZKPGmevu+UOaYVwJrGmkiG3tObZpj4zOioxCP/b2vbzVUq8C3P077lP4fosox62rjRdD/Fyy68tzk2vLvi9za9XcAaVZCMD54k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=BUKbWHP4; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=Gm5+HLT5; arc=fail smtp.client-ip=148.163.149.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101743.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54BMe1Rs027700;
	Sun, 11 May 2025 20:28:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=pyZqhMwr/SpNd+33ZfcKpTFgNZPEpMjHNd7ROlVnCXk=; b=BUKbWHP41o4k
	1NqoE0jj8ZajAqVYWThEnTD9r73zJqwUJll6PDTkzZOOM8ShOyiJ7w/E9AvHttvA
	K/+QpAtvutVXX+SgbahsE8h2FcyEDhabaARqxOHmLo9JCusyw0paFDHDmLFUYSUp
	XLRkNVNuI+QgKs2IkguAn6w5RlIudKWkO4+Jo/9fykfHk3jHaiT2AXJX5mG0E37S
	+xccuXj2aR4nMQeNyisf1sDdLl5GXjnQfl7hYOoJHHX19TER9FLq9K32L4CPhIyR
	VBjC5kwg3Td7vu10vFmhAFM4xN+mCFbeJyyjNqFlyfZmuPNnTN33Se8Y31F72H5N
	4psJKyeILA==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 46j34csvw9-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 May 2025 20:28:09 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tzp7n6fWsSV8onLhEBDLV6Ff1vLqb2MRkwxMzFDMizlWJu8/fwTxczEJVy1YjMHdFxVIhOQBrHnuz/lj5p0nrYFiQsmsEPiLF+Luq+NPv1YS6jaAf+uCbep9/Ekjsbu2JCdHy4UpTpWC0vL4Wr8BpNM1YarZuyBYZ2WRDMxMYrxDPL0Ixv2vx1toilUN+zcMwGHR++I78ENEmqr1qJDJ464ks5skQe5FnnQgsM9EyE8jLesbhKNand2bx1PDLMPJwiUuFIaNqDG7su6yf8HDb9GtWBbhU/XSHHfOZ7Y9gLkqppnhrKKkwZQ27Hq0CGJgFFJggp6/lp/YoZ/mFcuiPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyZqhMwr/SpNd+33ZfcKpTFgNZPEpMjHNd7ROlVnCXk=;
 b=oaCPfN1EhwRKrzodeaZD5W/baH4g69FDCdHl7vd7t8G2d1Kjh+YKW0VxbyCGEdf8dlXr+DnbKgNkq/kqJg/gLauQn4tx/TEUwdG6BRb8NCqWbZimyY7/MzXiiXTidgbohiCXMmJZEjy2y6AUnk/xjMUp7I55B4AjLiZanpO2fkkeC/iHyTWaNHCqQb1xQHaWC3zWQWV+F2rGHu78dxAwR75dlC6sMFCPMrqEIgoGwMxYXmNJ9X4LvNeReeWW5iju1vAFa6jYE9KxSlRagCQuQRHF+NiOVVGQM+ahFaguLk5FBzVj8+C2QfhKP2CUo7La8rnQeN1Sd3cO0LmRd+arZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyZqhMwr/SpNd+33ZfcKpTFgNZPEpMjHNd7ROlVnCXk=;
 b=Gm5+HLT5FBKGHNHgmhe9nPTlzwIl6v/9j4JcGZaDkasBMQB/HHDQxfYWyCwo42cTzZs1O6BWCppqLE7d9Md1rvuO/x/qxQwzo0Jsje7FHOuwSJE/mxgQ/HuIrqQgIW6lpsv5TwZPbQjQMmufeWdf/7hT8E12y7mWISl/jy52WV8=
Received: from DS0PR11MB8205.namprd11.prod.outlook.com (2603:10b6:8:162::17)
 by PH0PR11MB4920.namprd11.prod.outlook.com (2603:10b6:510:41::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.27; Mon, 12 May
 2025 01:28:05 +0000
Received: from DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a]) by DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a%4]) with mapi id 15.20.8699.026; Mon, 12 May 2025
 01:28:05 +0000
From: =?UTF-8?q?Damien=20Ri=C3=A9gel?= <damien.riegel@silabs.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Silicon Labs Kernel Team <linux-devel@silabs.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC net-next 11/15] net: cpc: add system endpoint
Date: Sun, 11 May 2025 21:27:44 -0400
Message-ID: <20250512012748.79749-12-damien.riegel@silabs.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512012748.79749-1-damien.riegel@silabs.com>
References: <20250512012748.79749-1-damien.riegel@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0451.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::17) To DS0PR11MB8205.namprd11.prod.outlook.com
 (2603:10b6:8:162::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8205:EE_|PH0PR11MB4920:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ddb6ab0-1822-4a4d-2aff-08dd90f43ed5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmhndEVHdU5BcUI4RnV6b0UrTGlmU0QzdlhxejFDc2FvVjJVRGR1UGp4KzhY?=
 =?utf-8?B?RlQwOEt4ZTRkTUxOZm4ybWVuaU8zYVVseTNOK2g2U0lDc1FoSXgvbGlaRmdB?=
 =?utf-8?B?YmFFclZncWdkV294SC9zendWOUlwVU5mR0JKOVIwTDgrSS81YWpZSFI0cjFK?=
 =?utf-8?B?bFR5YUY1RGNOQ1plRkJXeTl1QmFtVWY1Z3lEODV2TlhxYXpTeER0dUNyZHdQ?=
 =?utf-8?B?bStMMXEzaXdHT1NINnBoSHlTT2M0WUlhbWFFR0pSdkd6TFNvR0pvOHp5RlI2?=
 =?utf-8?B?RkJ5WE9QeXdtUmF3S3hNOVU1UlVYZjdOaDBGWGdPS3I2MmJjcXFqUFZDUFNh?=
 =?utf-8?B?blkrbUVPM2taRXpQWjA5bnlHZk1HaFpkNXVoV1Nqa25MUHZXd00rZ3FGV2Jm?=
 =?utf-8?B?V2JGS3hKS0d1TVRGSlM0QktabXNZeE84WnRjYTNHM3pvNmRGYS8zeFg2Rm1R?=
 =?utf-8?B?cGt1aXVRdXBoZVRmSllPYmtQekU1eUh6a3RDU1BXMFBzcHl6UUd4akNkSk1F?=
 =?utf-8?B?NTdsaWpZdUIycmFFOUFxTHRZNFkyQk1DVUZiRUphZWdwWG8yQkJpZ2puTXFE?=
 =?utf-8?B?TWZNYnVyVEl6eGxMenJqL3NOQTNOTG5OUVB0WXByUC9FR0QxT3BpbVdoY3J1?=
 =?utf-8?B?ejVKeE1lQXh1YndPWkZrSmwzSG5uT2NZTnB1TXd0L1FJZytNVXEzTTRTL2tK?=
 =?utf-8?B?VFNGaEdDTHh2b0IzRkphUm0rL1NrRkp2anpiTkRFdGcxdXBSRXNDU1ZJVnRN?=
 =?utf-8?B?b2NGWmJ0QTBhT3pZRmxvOFU5QUF0SEhnWDhvSFJvYVc1VDhEUlJiN1MrWUlw?=
 =?utf-8?B?S0tkamhJZnJMR2FkN3JzRWRhZFltbFJEWWoxWXJkYjVES1VTdkhzUzZDMzdT?=
 =?utf-8?B?eE80aU1rREJYNUNSZTR0L2Nqb1V1OVdkREE1aWsxN1MwK1k4SVRsQ2tudHdE?=
 =?utf-8?B?a0cvZTEvTjVkTFhQYStLZGRvNTlUSXN5cCs3ZS9CS1dnV0d3N2duY1ZUOXcw?=
 =?utf-8?B?RTJOTUs5cWRTVmd3dmwvY1JaT2hqck1KOC82ampSbndpWUtML1VPTjlPVUdy?=
 =?utf-8?B?Tk1pRTQzcnd0WnhDb3JIOW5JVzhOSEJRbElXZWtBYnQxQ0pKOFRUWFZCaits?=
 =?utf-8?B?am10Z1NQRGVSVGl3Qjl6eEV5NTFLZTFwbUN0Nm5ic255Wk5jN2ZtWHVhSWZ3?=
 =?utf-8?B?R25YaFN1WFhGdVdWOXkxODY4NFU1ZDZsMVBzbVg1c3A0R0poZFdhMGFMVnlU?=
 =?utf-8?B?aXZDT1k0U1U5Wi9MS2kzc1BzeDcvcXBRSTl5SUtyeTFqMlZBTkd2OXR5dy9x?=
 =?utf-8?B?ci90QjdwcXZFRjRXQ1d3QzF6UFY0bTU2bndXOEJFdGRzVjRjVFRpTVNmTTVV?=
 =?utf-8?B?K2ZLNkc0WUVXQWdXbWZCQTFRRGQvZDdMVSsrRTUraGVpL0FNeUJuVTNqb1F6?=
 =?utf-8?B?Qjk5dXM5VnNXUW5sWjhJcHk1NHpia0RVZ1hNUlhwajVFa3k0ZmNWWkNnZjdj?=
 =?utf-8?B?TlhMYUlWVnlwMDdlS21tOFlXN1BjbTl0VHdzdkVZSDBOZmppdTAyTXVnRGZa?=
 =?utf-8?B?WXI4WVQzM0FxQjIzeExCUWdibER6UUdZaGpEVmtXS05aSm5VS0o5TFUzNDM0?=
 =?utf-8?B?cjFUU1F1WHNLeHlrd3ZDVng2TkFUNFpwc0E1TENIZHo4aWNhc0poRmM4a3Nm?=
 =?utf-8?B?QVhKZThXT3A4bXRPbTNzYVF3d0ZNQTM3Nmc0cnUwMWRDRElHL2lSTDAwL2x0?=
 =?utf-8?B?Tm9BajVUc0pOOFlqbnFQdDMwMTVUSi9XbkJmK2dBR0hDWG1ub21ldko4QThZ?=
 =?utf-8?B?bENRbEJVcEZHWm1yL1BHd3V2bmt0TGxSWWY2M0dDbWh5MVo0L2xrM09NVklm?=
 =?utf-8?B?ZThZcHJRaUxxaEJuSVRIaDU5aUVBaDVzYTFyZTZRNUZBbUh6UXBzQkpPRitI?=
 =?utf-8?B?dnNHYkNJdHgzVXUvMHRpUC92bzBHQ0N6SGJOUkdZR251aENlM2swczkwR0Rv?=
 =?utf-8?Q?4/XT/EDCSXZENQv7KkC2p8C4W2NMWM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8205.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzlkMzBBMU9McWcvL3VPa2xFZGp6NnRzMFpzUVpSMFVIQ0czT0hVY0t0RUJY?=
 =?utf-8?B?Slk1cENHSGRkakNiaW1UTkx3QU0vUFVJWUFaeVVObU1NNkR3MHNNSWt1Rm5n?=
 =?utf-8?B?Qk1uTFRjNmNiUm9NVXVYSFUvbVlZRU1aRkp5K20zYmdTdlJGaUZVK1l3S2h3?=
 =?utf-8?B?WGsvUTRhRjNpNzhTTzgrbldYUEhNek0vdnhZSWd5Uk84bk5SYm5VOFBPS0pP?=
 =?utf-8?B?d2FpeEcwY0U5TUdzZ1lycitzcDFlcmcwODBBWnREYTNlM215a2xFcFowVkw5?=
 =?utf-8?B?ZUNFbzhpWXdrZllSeEZJK0JrL1Bac0NHTFZ1S0NxcnZ5UmhhWE51MUJzbGlE?=
 =?utf-8?B?WjNMUHNLbGNmMGVPS3piS2hCOW1IcnBzWm04N1NGazZwM2p0THpJSDF4RWt3?=
 =?utf-8?B?c0pZK0drOGRhWWx1MEE5cmVBRW5PenhiRHNLYytySCtETjZiOW91eU13ZjBN?=
 =?utf-8?B?ejh5bk9seDZxaVZRbW1OdFFpbUNNU0d1UWNjNU44NlFRRWZ3Smk0NGRSWDFh?=
 =?utf-8?B?NGNTT1ZoV2tTdDl6UGZvNlprZWQzVjJacmtkekNIanNNbVJJVE5rTUd3VTk0?=
 =?utf-8?B?angzcUtUZTJ0a0tsQ0VXMzh5bjBFQ1I0TWNJYmRZK1REZFBic28rMU5GQ0dT?=
 =?utf-8?B?Y1QxR3BCNEVXckNjTTFvbjdhRUhybW15anExWlAwVHo0UTEvbU1RQ0x5TmJk?=
 =?utf-8?B?OVYyMnJnRjdTVG5RdnI0NTUzamx5ZVNqTS8vL2pkeDFiMHliWkNSSkE0VFJw?=
 =?utf-8?B?azg1S21GemVHRzdwdWZkNFZWYW1vU2sxQUZnSW54cElqaEhHcDkrdE9ldVdF?=
 =?utf-8?B?dDdxUzlCdVB5cEZva0FIMmF2cXRtVzYzNm9zQ2Y5UlNtQ3pyT080Z1dKVnhw?=
 =?utf-8?B?TkNWbWtVOHpCVFFJZ2pvWnJBd25nVnZTTWZvZG5oNWFDcWxjNHdVK05GTmVH?=
 =?utf-8?B?OFZ1dXdJbjZJRlFNYnVVTjVDL2hJT0VVSWdQWHlLTHg2eHFMeFVSa0FtRnRU?=
 =?utf-8?B?aE14RGJXUE9FcTZuWjVsVlpsYXFLT1pneS96d0ZBNkJ5TytNMVNpK296K05z?=
 =?utf-8?B?Y0ZvUnFyNFN3WnJFcnZRMVpoejZJb2dBRWkybGh5Rmowbnc4eUV2Y3FWdWZL?=
 =?utf-8?B?NW91aHFUdXB1Q0NSL2dZRGhCWDBMYWZ0ZytyMVVucVEzQ2RtRGVLYXJWNWIv?=
 =?utf-8?B?VE1VN3VtRDBMRXBrUmdxTkFmQXp4L3o4QUREVUlYL0NnL1N6Z2FaMEI4ZFIr?=
 =?utf-8?B?UmNNSlpOZjBWaTNmU3dUZzB1MkdYOGRKMHBBVmpkelNVa2Vsc0gxcGR0cUJH?=
 =?utf-8?B?VURhVG5vRU9lbWlqVkVHYVVGU3Q1cjlHTFBmMXFKdW1LS0RaMVZ6ODJxTzRG?=
 =?utf-8?B?RU0yd3ZNYktLUWl0cENLeHV0SkdqdDJ2YkRaRWtmbFRNY1pINUJKYWFRMHI1?=
 =?utf-8?B?aktUZkwrNGxlemI1ZzR6TzBiSlJ4dWVkejNSdHcxYkFPeFZEeW1VYjFaVkZ4?=
 =?utf-8?B?Q0xMLzFJZ1dFRGJRNXA5c0hzb2JnOWlUZ0g1LzRZS285bEJmRUl4S0cyVjZW?=
 =?utf-8?B?M1ludFVHOGdtajlYakp0bXd6aTQrR0Z0L0ZGamJzYTEzZUxaTHFETUhFYTZl?=
 =?utf-8?B?WmNqWG1BckFQeVVjUVppZUpVeXZ1dVhlR3ZqdjNQSXpLc1pGZEI1cWxpQngw?=
 =?utf-8?B?TWdNQXBUcTRyZ29iaFVGVE9WcytPS0FZUGZNdzRZY3Y5U2tmSUFydU1xcko2?=
 =?utf-8?B?U1FGMVZBcnAySldlVHk5bzBBNHRzWWN3bWEyTGFKNzhtaGpLVTA0QWR1M2lK?=
 =?utf-8?B?YVRqYlQ0UlduV3JQYXBEMmYrd3RIQjlESTc1d3l4SU92VmtCUFZtd1M2QVdO?=
 =?utf-8?B?RytLY2Y1R2ZqajBGTmcrQlZuNFBvMjFXZTNkYmlFOFplSjQvcnJaUU1KaXRX?=
 =?utf-8?B?WFNKOU9vZ1NGSmxxZlJSV2Via1p2a2wvaUdYNThaaU9qdkMrMkswTWFlZnhw?=
 =?utf-8?B?ZEc4Z0dVZzJUcnZmZ3REZFN5a2k3Ri8vMnNYcm44L3dFNUV0cHc5WHM4YUxE?=
 =?utf-8?B?QytiWisrTkVyR0FONmkxT3V6dGZ0cGxZN0xrRVVJSmF5ZEY4VU9aYmhYY2tY?=
 =?utf-8?Q?WWBwW5y0m2yDdk0uELW+9wAQ3?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ddb6ab0-1822-4a4d-2aff-08dd90f43ed5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8205.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 01:28:05.8746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BhiUXTGm53iG+MGfjofIV0q7lXh6hfept/EXC8zWm+Itw5ALD//X1LZVa/lSFq6LG2jo7hUxDFHC9AulQD+OEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4920
X-Proofpoint-GUID: CrTAKVv6-MCkcgTejZi1BdaLBYMVfj01
X-Proofpoint-ORIG-GUID: CrTAKVv6-MCkcgTejZi1BdaLBYMVfj01
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDAxMyBTYWx0ZWRfX862RZeIVvQqk TGGRqCuf+vCNZHwloIlLQaVb3I3NmCjkuQxGXhkfF1V9ISM+w3So0LBUwHcZmUQw2+Mw3wME4Jc 4s5TtXzdhep/prHwy/dF0ivyjOTMlia0qwYMBfWcaFB+QsaiP0HWpHMLxMw+lBtA7g3bc8lk2uV
 AhGyLD8pnFusZef+6mwZl3oN95zQB47aNP4ciAkYUd+C9zI66mUrP8qP6Lb8Oz0XpCD/HgXY7vl kCcDlCJXuSlheqNCtRC9dx7KzIW/ov8XfvJ4kqlruuCYt+U1b1iTSz9g6TwNQsPzlX1GAD0M13S 0Jox2pQlksFfi8xoEB4AsPO7tzUCvcfBYvMi/bkJoPjW7cMZWKsdvZR0FLMkK58zNfqONjz8MRb
 x2Bq6vEn9cgE6ZaX5nwQNOKeOHtpDcT2zSdP6g+Hw6F6kbolckkQfbtN7IhI2XZgQ5njI4Pe
X-Authority-Analysis: v=2.4 cv=L/gdQ/T8 c=1 sm=1 tr=0 ts=68214eaa cx=c_pps a=coA4Samo6CBVwaisclppwQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=2AEO0YjSAAAA:8 a=J-GgsyN5KvRDZGlfWz4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-11_10,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505120013

The system endpoint is the main endpoint and is guaranteed to be present
in every CPC-enabled device. It is used to communicate device
capabilities.

One of the key element of the system endpoint is that it will send a
notification when an endpoint is opened on the microcontroller. When
such notification is received by the host, a new endpoint will be
registered.

As registering a new endpoint can be a long operation, as in the end it
calls device_add(), system's endpoint processing of RX frames is
dispatched in its own work function.

Signed-off-by: Damien Riégel <damien.riegel@silabs.com>
---
 drivers/net/cpc/Makefile |   2 +-
 drivers/net/cpc/main.c   |   8 +
 drivers/net/cpc/system.c | 432 +++++++++++++++++++++++++++++++++++++++
 drivers/net/cpc/system.h |  14 ++
 4 files changed, 455 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/cpc/system.c
 create mode 100644 drivers/net/cpc/system.h

diff --git a/drivers/net/cpc/Makefile b/drivers/net/cpc/Makefile
index 0e9c3f775dc..a61af84df90 100644
--- a/drivers/net/cpc/Makefile
+++ b/drivers/net/cpc/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-cpc-y := endpoint.o header.o interface.o main.o protocol.o
+cpc-y := endpoint.o header.o interface.o main.o protocol.o system.o
 
 obj-$(CONFIG_CPC)	+= cpc.o
diff --git a/drivers/net/cpc/main.c b/drivers/net/cpc/main.c
index 8feb0613252..fc46a25f5dc 100644
--- a/drivers/net/cpc/main.c
+++ b/drivers/net/cpc/main.c
@@ -8,6 +8,7 @@
 
 #include "cpc.h"
 #include "header.h"
+#include "system.h"
 
 /**
  * cpc_skb_alloc() - Allocate an skb with a specific headroom for CPC headers.
@@ -118,6 +119,12 @@ static int __init cpc_init(void)
 	int err;
 
 	err = bus_register(&cpc_bus);
+	if (err)
+		return err;
+
+	err = cpc_system_drv_register();
+	if (err)
+		bus_unregister(&cpc_bus);
 
 	return err;
 }
@@ -125,6 +132,7 @@ module_init(cpc_init);
 
 static void __exit cpc_exit(void)
 {
+	cpc_system_drv_unregister();
 	bus_unregister(&cpc_bus);
 }
 module_exit(cpc_exit);
diff --git a/drivers/net/cpc/system.c b/drivers/net/cpc/system.c
new file mode 100644
index 00000000000..1d5803093f8
--- /dev/null
+++ b/drivers/net/cpc/system.c
@@ -0,0 +1,432 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025, Silicon Laboratories, Inc.
+ */
+
+#include <linux/atomic.h>
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/skbuff.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+
+#include "cpc.h"
+#include "interface.h"
+#include "protocol.h"
+#include "system.h"
+
+/**
+ * enum cpc_system_cmd_id - Describes all possible system command id's.
+ * @CPC_SYSTEM_CMD_NOOP: Used for testing purposes.
+ * @CPC_SYSTEM_CMD_PROP_NOTIFY: Used for notification purposes.
+ * @CPC_SYSTEM_CMD_PROP_VALUE_GET: Used to fetch a property.
+ * @CPC_SYSTEM_CMD_PROP_VALUE_SET: Used to set a property.
+ * @CPC_SYSTEM_CMD_PROP_VALUE_IS: Used for receiving asynchronous properties.
+ * @CPC_SYSTEM_CMD_INVALID: Used to indicate a system command was invalid.
+ */
+enum cpc_system_cmd_id {
+	CPC_SYSTEM_CMD_NOOP = 0x00,
+	CPC_SYSTEM_CMD_PROP_NOTIFY = 0x01,
+	CPC_SYSTEM_CMD_PROP_VALUE_GET = 0x02,
+	CPC_SYSTEM_CMD_PROP_VALUE_SET = 0x03,
+	CPC_SYSTEM_CMD_PROP_VALUE_IS = 0x06,
+	CPC_SYSTEM_CMD_INVALID = 0xFF,
+};
+
+/**
+ * enum cpc_system_property_id - Describes all possible system property identifiers.
+ * @CPC_SYSTEM_PROP_INVALID: Invalid property.
+ * @CPC_SYSTEM_PROP_PROTOCOL_VERSION: Protocol version property.
+ * @CPC_SYSTEM_PROP_DRV_CAPABILITIES: Driver capabilities property.
+ * @CPC_SYSTEM_PROP_CPC_VERSION: CPC version property.
+ * @CPC_SYSTEM_PROP_APP_VERSION: Application version property.
+ * @CPC_SYSTEM_PROP_RESET_REASON: Reset reason property.
+ * @CPC_SYSTEM_PROP_EP_OPEN_NOTIF: Endpoint open notification property.
+ */
+enum cpc_system_property_id {
+	CPC_SYSTEM_PROP_INVALID = 0x00,
+	CPC_SYSTEM_PROP_PROTOCOL_VERSION = 0x10,
+	CPC_SYSTEM_PROP_DRV_CAPABILITIES = 0x11,
+	CPC_SYSTEM_PROP_CPC_VERSION = 0x12,
+	CPC_SYSTEM_PROP_APP_VERSION = 0x13,
+	CPC_SYSTEM_PROP_RESET_REASON = 0x14,
+	CPC_SYSTEM_PROP_EP_OPEN_NOTIF = 0x800,
+};
+
+/**
+ * enum cpc_system_status - Describes all possible system statuses.
+ * @CPC_SYSTEM_STATUS_RESET_POWER_ON: Reset was due to a power reason.
+ * @CPC_SYSTEM_STATUS_RESET_EXTERNAL: Reset was due to an external reason.
+ * @CPC_SYSTEM_STATUS_RESET_SOFTWARE: Reset was due to a software reason.
+ * @CPC_SYSTEM_STATUS_RESET_FAULT: Reset was due to a fault.
+ * @CPC_SYSTEM_STATUS_RESET_CRASH: Reset was due to a crash.
+ * @CPC_SYSTEM_STATUS_RESET_ASSERT: Reset was due to an assert.
+ * @CPC_SYSTEM_STATUS_RESET_OTHER: Reset was due to some other reason.
+ * @CPC_SYSTEM_STATUS_RESET_UNKNOWN: Reset was due to an unknown reason.
+ * @CPC_SYSTEM_STATUS_RESET_WATCHDOG: Reset was due to a watchdog trigger.
+ */
+enum cpc_system_status {
+	CPC_SYSTEM_STATUS_RESET_POWER_ON = 112,
+	CPC_SYSTEM_STATUS_RESET_EXTERNAL = 113,
+	CPC_SYSTEM_STATUS_RESET_SOFTWARE = 114,
+	CPC_SYSTEM_STATUS_RESET_FAULT = 115,
+	CPC_SYSTEM_STATUS_RESET_CRASH = 116,
+	CPC_SYSTEM_STATUS_RESET_ASSERT = 117,
+	CPC_SYSTEM_STATUS_RESET_OTHER = 118,
+	CPC_SYSTEM_STATUS_RESET_UNKNOWN = 119,
+	CPC_SYSTEM_STATUS_RESET_WATCHDOG = 120,
+};
+
+/**
+ * struct cpc_system_cmd - Wire representation of the system command.
+ * @id: Identifier of the command.
+ * @seq: Command sequence number.
+ * @len: Length of the payload in bytes.
+ * @payload: Variable length payload.
+ */
+struct cpc_system_cmd {
+	u8 id;
+	u8 seq;
+	__le16 len;
+	u8 payload[];
+} __packed;
+
+/**
+ * struct cpc_system_cmd_property - Wire representation of the system
+ * command property.
+ * @id: Identifier of the property.
+ * @payload: Variable length property value.
+ */
+struct cpc_system_cmd_property {
+	__le32 id;
+	u8 payload[];
+} __packed;
+
+struct cpc_system_cmd_handle {
+	u8 seq;
+	struct list_head node;
+};
+
+struct cpc_system_cmd_ctx {
+	struct mutex lock;	/* Synchronize access to command list */
+	u8 next_seq;
+	struct list_head list;
+
+	struct work_struct init_work;
+	struct work_struct rx_work;
+
+	struct sk_buff_head rx_queue;
+
+	struct cpc_endpoint *ep;
+};
+
+static bool __cpc_system_cmd_pop_handle(struct cpc_system_cmd_ctx *cmd_ctx,
+					struct cpc_system_cmd_handle **cmd_handle)
+{
+	*cmd_handle = list_first_entry_or_null(&cmd_ctx->list, struct cpc_system_cmd_handle, node);
+
+	if (*cmd_handle)
+		list_del(&(*cmd_handle)->node);
+
+	return !!*cmd_handle;
+}
+
+static void cpc_system_cmd_init(struct cpc_system_cmd_ctx *cmd_ctx)
+{
+	mutex_init(&cmd_ctx->lock);
+	INIT_LIST_HEAD(&cmd_ctx->list);
+	cmd_ctx->next_seq = 0;
+}
+
+static void cpc_system_cmd_clear(struct cpc_system_cmd_ctx *cmd_ctx)
+{
+	struct cpc_system_cmd_handle *cmd_handle;
+
+	mutex_lock(&cmd_ctx->lock);
+	while (__cpc_system_cmd_pop_handle(cmd_ctx, &cmd_handle))
+		kfree(cmd_handle);
+
+	cmd_ctx->next_seq = 0;
+	mutex_unlock(&cmd_ctx->lock);
+}
+
+static bool cpc_system_cmd_find_handle(struct cpc_system_cmd_ctx *cmd_ctx,
+				       u8 cmd_seq,
+				       struct cpc_system_cmd_handle **cmd_handle)
+{
+	mutex_lock(&cmd_ctx->lock);
+
+	list_for_each_entry((*cmd_handle), &cmd_ctx->list, node) {
+		if ((*cmd_handle)->seq == cmd_seq) {
+			list_del(&(*cmd_handle)->node);
+			mutex_unlock(&cmd_ctx->lock);
+			return true;
+		}
+	}
+
+	mutex_unlock(&cmd_ctx->lock);
+
+	return false;
+}
+
+static void cpc_system_on_reset_reason(struct cpc_endpoint *ep, struct sk_buff *skb)
+{
+	u32 reset_reason;
+
+	if (skb->len != sizeof(reset_reason)) {
+		dev_err(&ep->dev, "reset reason has invalid length (%d)\n", skb->len);
+		return;
+	}
+
+	reset_reason = get_unaligned_le32(skb->data);
+
+	switch (reset_reason) {
+	case CPC_SYSTEM_STATUS_RESET_POWER_ON:
+	case CPC_SYSTEM_STATUS_RESET_EXTERNAL:
+	case CPC_SYSTEM_STATUS_RESET_SOFTWARE:
+	case CPC_SYSTEM_STATUS_RESET_FAULT:
+	case CPC_SYSTEM_STATUS_RESET_CRASH:
+	case CPC_SYSTEM_STATUS_RESET_ASSERT:
+	case CPC_SYSTEM_STATUS_RESET_OTHER:
+	case CPC_SYSTEM_STATUS_RESET_UNKNOWN:
+	case CPC_SYSTEM_STATUS_RESET_WATCHDOG:
+		dev_dbg(&ep->dev, "reset reason: %d\n", reset_reason);
+		break;
+	default:
+		dev_dbg(&ep->dev, "undefined reset reason: %d\n", reset_reason);
+		break;
+	}
+}
+
+static void cpc_system_prop_value_is(struct cpc_endpoint *ep, struct sk_buff *skb)
+{
+	u32 id;
+
+	if (skb->len < sizeof(id)) {
+		dev_warn(&ep->dev, "command property with invalid length (%d)\n", skb->len);
+		return;
+	}
+
+	id = get_unaligned_le32(skb_pull_data(skb, sizeof(id)));
+
+	switch (id) {
+	case CPC_SYSTEM_PROP_RESET_REASON:
+		cpc_system_on_reset_reason(ep, skb);
+		break;
+	default:
+		dev_dbg(&ep->dev, "unsupported command property identifier (%d)\n", id);
+		break;
+	}
+}
+
+static void cpc_system_on_prop_value_is(struct cpc_endpoint *ep, struct sk_buff *skb, u8 seq)
+{
+	struct cpc_system_cmd_ctx *cmd_ctx = cpc_endpoint_get_drvdata(ep);
+	struct cpc_system_cmd_handle *cmd_handle;
+
+	if (cpc_system_cmd_find_handle(cmd_ctx, seq, &cmd_handle)) {
+		cpc_system_prop_value_is(ep, skb);
+		kfree(cmd_handle);
+	} else {
+		dev_warn(&ep->dev, "unknown command sequence (%u)\n", seq);
+	}
+}
+
+static void cpc_system_on_ep_open_notification(struct cpc_endpoint *ep, struct sk_buff *skb)
+{
+	struct cpc_endpoint *new_ep;
+	u8 ep_id;
+
+	/*
+	 * Payload should contain at least the endpoint ID
+	 * and the null terminating byte of the string.
+	 */
+	if (skb->len < sizeof(ep_id) + 1) {
+		dev_warn(&ep->dev, "open with invalid length (%d)\n", skb->len);
+		return;
+	}
+
+	ep_id = *(u8 *)skb_pull_data(skb, sizeof(ep_id));
+
+	if (skb->data[skb->len - 1] != '\0') {
+		dev_warn(&ep->dev, "non nul-terminated endpoint name for ep%u\n", ep_id);
+		return;
+	}
+
+	if (skb->len > sizeof(ep->name)) {
+		dev_warn(&ep->dev, "oversized endpoint name (%d) for ep%u\n", skb->len, ep_id);
+		return;
+	}
+
+	dev_dbg(&ep->dev, "open notification for ep%u: '%s'\n", ep_id, skb->data);
+
+	new_ep = cpc_endpoint_alloc(ep->intf, ep_id);
+	if (!new_ep)
+		return;
+
+	memcpy(new_ep->name, skb->data, skb->len);
+
+	/* Register the new endpoint in the same interface that received the notification. */
+	cpc_endpoint_register(new_ep);
+}
+
+static void cpc_system_on_prop_notify(struct cpc_endpoint *ep, struct sk_buff *skb)
+{
+	u32 id;
+
+	if (skb->len < sizeof(id)) {
+		dev_warn(&ep->dev, "command property with invalid length (%d)\n", skb->len);
+		return;
+	}
+
+	id = get_unaligned_le32(skb_pull_data(skb, sizeof(id)));
+
+	switch (id) {
+	case CPC_SYSTEM_PROP_EP_OPEN_NOTIF:
+		cpc_system_on_ep_open_notification(ep, skb);
+		break;
+	default:
+		dev_dbg(&ep->dev, "unsupported command property identifier (%d)\n", id);
+		break;
+	}
+}
+
+static void cpc_system_on_data(struct cpc_endpoint *ep, struct sk_buff *skb)
+{
+	struct cpc_system_cmd *system_cmd;
+	u16 payload_len;
+	u8 seq;
+
+	if (skb->len < sizeof(*system_cmd)) {
+		dev_warn(&ep->dev, "command with invalid length (%d)\n", skb->len);
+		kfree_skb(skb);
+		return;
+	}
+
+	system_cmd = skb_pull_data(skb, sizeof(*system_cmd));
+	payload_len = le16_to_cpu(system_cmd->len);
+	seq = system_cmd->seq;
+
+	if (skb->len != payload_len) {
+		dev_warn(&ep->dev,
+			 "command payload length does not match (%d != %d)\n",
+			 skb->len, payload_len);
+		kfree_skb(skb);
+		return;
+	}
+
+	switch (system_cmd->id) {
+	case CPC_SYSTEM_CMD_PROP_VALUE_IS:
+		cpc_system_on_prop_value_is(ep, skb, seq);
+		break;
+	case CPC_SYSTEM_CMD_PROP_NOTIFY:
+		cpc_system_on_prop_notify(ep, skb);
+		break;
+	default:
+		dev_dbg(&ep->dev, "unsupported system command identifier (%d)\n", system_cmd->id);
+		break;
+	}
+
+	kfree_skb(skb);
+}
+
+static void cpc_system_rx_work(struct work_struct *work)
+{
+	struct cpc_system_cmd_ctx *cmd_ctx = container_of(work, struct cpc_system_cmd_ctx, rx_work);
+	struct sk_buff *skb;
+
+	while ((skb = skb_dequeue(&cmd_ctx->rx_queue)))
+		cpc_system_on_data(cmd_ctx->ep, skb);
+}
+
+static void cpc_system_rx(struct cpc_endpoint *ep, struct sk_buff *skb)
+{
+	struct cpc_system_cmd_ctx *cmd_ctx = cpc_endpoint_get_drvdata(ep);
+
+	skb_queue_tail(&cmd_ctx->rx_queue, skb);
+	schedule_work(&cmd_ctx->rx_work);
+}
+
+static void cpc_system_init_work(struct work_struct *work)
+{
+	struct cpc_system_cmd_ctx *cmd_ctx = container_of(work,
+							  struct cpc_system_cmd_ctx,
+							  init_work);
+
+	cpc_endpoint_connect(cmd_ctx->ep);
+}
+
+static struct cpc_endpoint_ops system_ops = {
+	.rx = cpc_system_rx,
+};
+
+static int cpc_system_probe(struct cpc_endpoint *ep)
+{
+	struct cpc_system_cmd_ctx *cmd_ctx;
+
+	cmd_ctx = kzalloc(sizeof(*cmd_ctx), GFP_KERNEL);
+	if (!cmd_ctx)
+		return -ENOMEM;
+
+	cpc_system_cmd_init(cmd_ctx);
+
+	INIT_WORK(&cmd_ctx->init_work, cpc_system_init_work);
+	INIT_WORK(&cmd_ctx->rx_work, cpc_system_rx_work);
+
+	skb_queue_head_init(&cmd_ctx->rx_queue);
+
+	cmd_ctx->ep = ep;
+
+	cpc_endpoint_set_drvdata(ep, cmd_ctx);
+	cpc_endpoint_set_ops(ep, &system_ops);
+
+	/* Defer connection of the system endpoint to not block in probe(). */
+	schedule_work(&cmd_ctx->init_work);
+
+	return 0;
+}
+
+static void cpc_system_remove(struct cpc_endpoint *ep)
+{
+	struct cpc_system_cmd_ctx *cmd_ctx = cpc_endpoint_get_drvdata(ep);
+
+	cpc_endpoint_disconnect(ep);
+
+	cpc_system_cmd_clear(cmd_ctx);
+
+	flush_work(&cmd_ctx->init_work);
+	flush_work(&cmd_ctx->rx_work);
+
+	skb_queue_purge(&cmd_ctx->rx_queue);
+
+	kfree(cmd_ctx);
+}
+
+static struct cpc_driver system_driver = {
+	.driver = {
+		.name = CPC_SYSTEM_ENDPOINT_NAME,
+	},
+	.probe = cpc_system_probe,
+	.remove = cpc_system_remove,
+};
+
+/**
+ * cpc_system_drv_register - Register the system endpoint driver.
+ *
+ * @return: 0 on success, otherwise a negative error code.
+ */
+int cpc_system_drv_register(void)
+{
+	return cpc_driver_register(&system_driver);
+}
+
+/**
+ * cpc_system_drv_unregister - Unregister the system endpoint driver.
+ */
+void cpc_system_drv_unregister(void)
+{
+	cpc_driver_unregister(&system_driver);
+}
diff --git a/drivers/net/cpc/system.h b/drivers/net/cpc/system.h
new file mode 100644
index 00000000000..31307da3547
--- /dev/null
+++ b/drivers/net/cpc/system.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025, Silicon Laboratories, Inc.
+ */
+
+#ifndef __CPC_SYSTEM_H
+#define __CPC_SYSTEM_H
+
+#define CPC_SYSTEM_ENDPOINT_NAME "system"
+
+int cpc_system_drv_register(void);
+void cpc_system_drv_unregister(void);
+
+#endif
-- 
2.49.0


