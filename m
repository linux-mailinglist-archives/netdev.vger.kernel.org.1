Return-Path: <netdev+bounces-201962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D54EAEB9AC
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 16:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60980169296
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 14:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB612E2656;
	Fri, 27 Jun 2025 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="msTzeCQ4"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012003.outbound.protection.outlook.com [52.101.71.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903662F1FD0
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751034122; cv=fail; b=MNQV/hJGcJF08BT4UupbZSwgmyaCMCCokasS28lAOS8CYvv0CJ6dR4OHNCxtfkBSPPaN+nuAVLadCcwmAo0oOSkoOqOwbvhh+XXpUBM+C2N/TE775/TZ8T2oS9xhqNlqo0pfZ0ejw1ncb+Zd0NLv7J7UN/W7Mx+Xaia8iZqhqqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751034122; c=relaxed/simple;
	bh=mqBMGtTYTJwiseNxTR778nX1nbMXnPssNFFNm9EQvSU=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CdOO/JRXyVjuhGN77omYGnxmL52PdorPTiTI14h1q10EZYBV+o1+JRAFd05fV/bdFWqkKAC5rF6kDKXCQZ4bDon7RY3Jdl8xJVtNJXY7dwAKsmxt69Ph568cI82NLRzUwYNwfYRPUjAotNjhsDuYJ+DV5Ou0BPHhgyvNq4E6y48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=msTzeCQ4; arc=fail smtp.client-ip=52.101.71.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRcHs9CZyHfEavGrqp4BEOwNiu+S8Xxdbn7RFtPb6VMdEgdHMrX+2iIRy6QrNvAA/Pjl30WNsdIvg04VrivXewatw4XoNV4TlKxznd++V3h4YPKRMadeCNyJ0cHqaio82TsCwSeBimg7z8XsqQjG95TMaambj2xWHcmyIQRSpfxcTGD3if4p1Zh3LDTfxdVEsvp/1sKup7QTcxkAm586agkkl82ALmKnmtxJy7a5RKy1UpYioU4ZrsVR+yl3r23rK16JvWP8ER2kc13ck3xFJ4Z8mDo/hUVnMrLmNYFBb2TQwqlPnoYpUt/sC7bHaBWQp6/rbqNWjVo5fytn1gu4RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7kNJvg2iNe7gTUEpGu3Rczf9xUNKHfZfajDQgKuSoo=;
 b=stRt0EswgKH5nMuQxmDdStxE5tPkPMUVitmQ81JS2KsouYCs+w20C7yihWlFG1M6N5yvlZ8bJe8LVW57rTnFYQ+kgi/dRwanWCtD6Z91oxQqpjC/uaZt0mKgngnxv1yiiKWJ2pgMh6TOavCh4NBi96dydkrpAJ9hp53NsgBfYaWDVRHGC6+2RlyTHw2tpFs/B2hbGKx106pVy/VSdhla4VDSa2dcqU7i0Uftee66zbO1TVMBbqlqqymARAotGwBLxZEmD5mNzFHmE6Xana9MzR7APH+X7gk3/KUR2r1d1TRBtPGHyk8TPivxfW4Rwt4qEgmxKeShsd3oSukWIgfdBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=2n.com; dmarc=pass action=none header.from=axis.com; dkim=pass
 header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7kNJvg2iNe7gTUEpGu3Rczf9xUNKHfZfajDQgKuSoo=;
 b=msTzeCQ4ujTRbSMdZD+Ij8xrYeigChLZ3RtZmn5U1VP9NZ0XIJ2iAV7yWbokUIC2JCJf+mcNckU2B2qrBUlp9zz3BIywj1SVRtay8h4ESaujbVxAxbGqWMSPEqxzc//q0EHTsOQoVFTQwBmjcGewtXZ3bw+yXJu5iSId3Da23Mc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com (2603:10a6:10:488::13)
 by DU0PR02MB9345.eurprd02.prod.outlook.com (2603:10a6:10:414::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Fri, 27 Jun
 2025 14:21:58 +0000
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::2a25:783c:e73a:a81d]) by DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::2a25:783c:e73a:a81d%4]) with mapi id 15.20.8880.015; Fri, 27 Jun 2025
 14:21:58 +0000
Message-ID: <bc1d0fba-f81f-4524-aabc-65e72b448eb1@axis.com>
Date: Fri, 27 Jun 2025 16:21:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/4] net: phy: MII-Lite PHY interface mode
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
References: <20250627112306.1191223-1-kamilh@axis.com>
 <20250627112306.1191223-2-kamilh@axis.com>
 <aF6Xch-qv-3zzMja@shell.armlinux.org.uk>
Content-Language: en-US
Cc: netdev <netdev@vger.kernel.org>
From: =?UTF-8?B?S2FtaWwgSG9yw6FrICgyTik=?= <kamilh@axis.com>
In-Reply-To: <aF6Xch-qv-3zzMja@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0368.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::15) To DB5PR02MB10093.eurprd02.prod.outlook.com
 (2603:10a6:10:488::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PR02MB10093:EE_|DU0PR02MB9345:EE_
X-MS-Office365-Filtering-Correlation-Id: a8771096-d68f-499a-d559-08ddb585f98f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVlESzRGcElwUXNkQWZvOUJiMmh3dE1GWDBqR3ZOcW5QOFJSTyszWEJ6TkQ5?=
 =?utf-8?B?TnlvUE9YWm42RmJ2WmhPRWZHV3BZYUpiZDM1ZXhieWlTRDNaSnVuNmlWM1Rn?=
 =?utf-8?B?TkFjaFgvbDBRcmJheGNzb29aTGM2cGdsU0VZdjl6Y0pRZ05RR1pocTNqNmla?=
 =?utf-8?B?WEk1bmk1NjNEdzhlb1cwUFp1SGxzNENSVEtSTmMvNHBvOGtVT0M4TlJEZkNj?=
 =?utf-8?B?UFlZTlVyaURRL0pTSjZCVGttbXMrZEtxdFJqZEhQNlRyUjViTFFMVE9CcXlL?=
 =?utf-8?B?K20wWTIyd1VDNGRUbzNudU1yWFhDYU00eldkYkZWNHIrMGxWZm1aVVlDaWl5?=
 =?utf-8?B?SWJJR1I2OCtRRWdpbzBoNFFaK2hRZmVJRUxNZTdvNm1SbjVuU3JxT2FDZ3U3?=
 =?utf-8?B?QnhGU3RKT0FjNlZmVHF3UDBGRjk5SnJwLzRxWHpHaEhIOWUzRnQybk5MNDho?=
 =?utf-8?B?YTMyV0JnUEdzbVI4dXBxS2R0cERsa2JDY3h3dDloRmxoOEpvdDR4UkJHRlND?=
 =?utf-8?B?aC95UXdwVTMvVXJ5eEVlZWF4anJ1dElYdk1adFdjWlowbW16QUdTQTAxTFFE?=
 =?utf-8?B?WG1leXdrQytaZHlkMThhbXM0NG1rOWVSL0YzY1RsUkJoZkdlOThITGJvcXhJ?=
 =?utf-8?B?cnUzdjZ0NHpnY2hIVVpNeG1VeHEvNkpxL2U5WDdUTjgzUmV2K0xvMGJ3dmdx?=
 =?utf-8?B?Nk5jZUlhWFpGL29JRmFybTFLZkRJUVV4TDhneFRGOGlHMytPM2tjcnIvaVZD?=
 =?utf-8?B?UVY1REhHVjFRNXVDaHRWWHZKL2lnL3psTCtVeGg5NnliVG1LQzN2Vy94MHU4?=
 =?utf-8?B?eXh2QjFvMHBraldGYklJV0Rqa3A1WHlEY0ZZY1JJRDh2aVltdGVGN3NwbmpX?=
 =?utf-8?B?THhLM0lhbzFDN3FtazR3cjNVSTZXTVU4WkNQNkFvcXRBTkdmdHZCcXdPWTVm?=
 =?utf-8?B?ejdySWNXY2dnUWNTN2Q5dXJPd3VkTlVTaHliNHAwSVhTWlZYTVRaRWt4Mlo2?=
 =?utf-8?B?UjJXbk1MM3EzeVFQWGhaeWpLVTArN3NHbW1WeE0wdEhtZUVDWU9NMVdoaHdV?=
 =?utf-8?B?Zit3KzJEcExXR2ppbkdwVzk2U2t3UjZvSmJYUDFaWWhUcHlrN2hIRjE0WlA5?=
 =?utf-8?B?Vzgwc1BEelVncE5SNEpMSUJ2ekszNUc0Yk1JaDZxR3htaCtDYTBKeWhGL3RY?=
 =?utf-8?B?L2dGWk5qK2Q3NHkzZ2R1eC92dEpHbWpkeCtvOTBjeVVXd0Q0VmxxdHVwWUlG?=
 =?utf-8?B?NmFsUGVENE1VUHFsc3RSVE5sclhLSTlReXdIU1REcXFQYlNLVUhKeko5RGxB?=
 =?utf-8?B?R0ZmV0xlUlBvV2lHazY4YTNpN2k5Nk1IREQyVWV0WndES1NGSUZNS0xhREtj?=
 =?utf-8?B?eXM0b2xxN2ZibVhTRWprVkJBS05QNDZTR2pJVmR1eXdGaVVFNG1KcDhUK2ta?=
 =?utf-8?B?Y1FFVnVYYnNBaGJSYWxUWG1KdzZKRGpiN3QrWVdWV0QzSURJb09LaXVpbG9I?=
 =?utf-8?B?SlF1MW5RK3RsWVdRcEsxRkZxcUthMDlUaXliUFgzL3g2cEVBNkR4TlJYODk4?=
 =?utf-8?B?alNyZWpwYTFqVDdwbVNFdEE4dWU3RlJNYW5VUlZtbG9DeGxrK1JzRTk0eEpI?=
 =?utf-8?B?eHFFd0lsWXo4bXFldzRLK0YvZVhwc2NjRG16eFJiR3c0WkFtdEVjQVJaNkRh?=
 =?utf-8?B?dWdueG5yT092Sjc4VkdFUld4S2FkNmFIMHVRODN1eTRZdjAraFAzL0dZZnN1?=
 =?utf-8?B?QVRGK08xci9zRTBNRHljM2hYd3FkVk9vV2ZMc25sWC9XVFNsL3pPL2pmU3dj?=
 =?utf-8?B?QjRvbTd2aElkeEZnNlNpa0Mxc1hRb09GcXFoTXg0QW5zRFRobXd1Qmg1Nmxj?=
 =?utf-8?B?S1poTUczZ0dIeEVzcmxJc29xeWNxYzdLSmtpV0RKN0xyNVdCV3VOdFRCdGRj?=
 =?utf-8?Q?dulQtaWd4UQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10093.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2VwbE1jUmZHdzJpSTFsSkpXdkZFQ0hMVUdSZkFoY0lDeW1BU1hDbGY5bWNq?=
 =?utf-8?B?QUllakIvd1A5cXJVRzVmZXBVekFOWDI2c2I4MHA4enhjMUZuSHYxZUx1eUpP?=
 =?utf-8?B?UDJ3UTFFQUUxdGxzd2E4dzFzVUVXeDZ6SXRMTG5reUZHV09CaUozNjFhUEt3?=
 =?utf-8?B?YWkvbXltTGsyelRSN2RQOXpkUzFHQ21FS25TcUlHVHVPMFB6S3JRQXU4OWhG?=
 =?utf-8?B?Q0p1OHNkcnFYNk5PV0N3d05DQm9YeWl2dHEzeTFDSDJ2WHdrUyt3VmhQTklY?=
 =?utf-8?B?MmU0Lzhld2EyOXBWNW5qQ2VMVW9wMFdOZXBIS1FibFFQOTJNYkxEQW9DeUxh?=
 =?utf-8?B?WVlpc1NhVHo2czROZnpOT0Z5M2VteDBDNXo0L0xBNURXM3ZmdFBYbG04TkZw?=
 =?utf-8?B?c05qdmk1T0tMRXBHaWxjYytjbVFVYzRzYWdjYzJ2azAyZytodHNYdFdHa1lP?=
 =?utf-8?B?SE9LckZZS2w2T2NFbGFhZ1U3ek91bmVSM2dSQU5Ha2REV0I5MUE0aWJDU2hS?=
 =?utf-8?B?ZlZxSmR3dG9OL0l1clgwMWZ2YWZIOHUvbUhtem5HT0w5UlUyV2JoY3RRQWdH?=
 =?utf-8?B?MkhQaER4TkRRYkhLcE9obTVZY0RSVEl1ai9lc1UwZGY3enFzM1VreFJSc1RT?=
 =?utf-8?B?ZndOVzY5TnpGZ0dvVnF2L3dyajNmRDROYXQ5V0J4THhWcEtmSnJDV0krdnY2?=
 =?utf-8?B?MDk3NmczamQySlh2a1FFWlNFYTRiS1kvSm5tVHRYSHlka0ZpeVRLTFdSVWxP?=
 =?utf-8?B?czI3aVk2VFJYOS9sZ3RRZHdLVndaY3FCdFl6TCtJODJSS1d1QlhJRkZBNmFm?=
 =?utf-8?B?VnZWMGNRWi9nYUJ6REUxZkZ0ZUtSME9nZUZvSThTVHpmQm9ERUVMY2lRMGdJ?=
 =?utf-8?B?aW1GSlR3UmZQVWRVZW11REpRMmh3d3pnVzZSaCt4Ky9VdUdzTmNXNU16S2lK?=
 =?utf-8?B?T1JmWS9ZMFJ2NnFORS80eXJTcm8xWDlvaURDbnVabWlNSUJCbHcweUVMNlZH?=
 =?utf-8?B?VVZ3bFRYdFFxYTFjd1Arc2hIZnJxWU93TjdWRlExdFhta09SdzZBT3VUbCtP?=
 =?utf-8?B?MUpZUVJ4MzY5OHh2WkN1WVkxR3dEaklTeVI2aDNCbWorekcwQXBRenZ6NTFW?=
 =?utf-8?B?aXVqTWZHbDVmQVB6R0NDRlVwZG85dTdBWjRoNHNiamNxcWI5bm0vZ0JCbWRz?=
 =?utf-8?B?NmpDbS82MnBDZyt1N3EvUkdXbnBIaXdhWnlOSSt5Rm5pZzRkRXlTN3Nia0hu?=
 =?utf-8?B?ZWNWcFpFNEdJQVpBQzNqaHZabFUxZDd2RUs1RExOazJpQmw1N0k2M1gzb0dM?=
 =?utf-8?B?aFUvWEsveHp6MDc5ZGtyV0pCTUVFZTVNZ2xRZUZxa3BlSW5BVFF2SUZseEx6?=
 =?utf-8?B?WWtBZFdkUjI0bzVTVEc3bmRLM3RVN1JhMkx2UHI3YzNDcm4vNjFXVm5SRE10?=
 =?utf-8?B?V3kxVVNsWFRXb3pYYzV2ckJxNTR2UXN5TGt2dDYwaDZVWWQ4bDA0bFE2azFj?=
 =?utf-8?B?Q1RPbU9mcy9aQ2JuYkxYeldsL0RXY20xUlhPQU1vRkM2c1M4VC96Rmlqck54?=
 =?utf-8?B?a1pWdUN0cnUzenJGQWh3NStEY0l0amJtdTNRTWpsam8xa3RzbHZmRFQ3bUpF?=
 =?utf-8?B?VFdybWRoRm9DNjA0S25tTk5qR2JqYS85L0JrTW1HT21MUmdqK0pFZ1dhd3Na?=
 =?utf-8?B?NFlxV2lzcmZKUE8vVGlBbmdNUlBRL3g4SFdYZVorK1hkV3o3dllRQ1lUUVd6?=
 =?utf-8?B?aHRUcTJqVCtHb1Y2K25EUTNXM1ZLck9ERnk3TitkdytUKzlGL2dNbEpBNExP?=
 =?utf-8?B?Tm5kZ0Z6OEFKbHF1Lzh0Q0F0RzVtaWUzcnM5SmVmc2NNUlI4Snkwc25oWmo2?=
 =?utf-8?B?SGJqSVI3QlNra0pZSmVCTWhMaExUNWtaWkkzdjF2T1pTVWZjZGxHMWRUV1JE?=
 =?utf-8?B?b3QvYmpaWGRCdTBSZ2RKUDk3Ymp3Mzd3Q0xvdm5GclZMeU5xQVZjWDBiYmc5?=
 =?utf-8?B?T1k2NmtKV3dmUWpUaHU0Ull0VE9sdU9KaTJLRmdnOXN5eFpyMGd0bUc4R2Ux?=
 =?utf-8?B?K2FBS0Irdm1YVU85M0lMbUdEVDh4RWJydkZ1ZlEzSWxCNWg5bi8wdE14bGYz?=
 =?utf-8?Q?OolHMa/wHC7hBzf0B8SQ4hsfD?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8771096-d68f-499a-d559-08ddb585f98f
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10093.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 14:21:57.9801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VX7SwCRnaguUq1/0p4w3OGGVwBqxOCMW3iufJDQfT1jed3zo0kg6O1sLWy9HohY+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9345



On 6/27/25 15:06, Russell King (Oracle) wrote:
> On Fri, Jun 27, 2025 at 01:23:03PM +0200, Kamil Horák - 2N wrote:
>> Some Broadcom PHYs are capable to operate in simplified MII mode,
>> without TXER, RXER, CRS and COL signals as defined for the MII.
>> The MII-Lite mode can be used on most Ethernet controllers with full
>> MII interface by just leaving the input signals (RXER, CRS, COL)
>> inactive. The absence of COL signal makes half-duplex link modes
>> impossible but does not interfere with BroadR-Reach link modes on
>> Broadcom PHYs, because they are all full-duplex only.
>>
>> Add MII-Lite interface mode, especially for Broadcom two-wire PHYs.
>>
>> Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
> 
> Very sorry, but in the last review, I missed that you aren't updating
> the description of interfaces in Documentation/networking/phy.rst
> 
> Please see the section "PHY interface modes".
> 
OK I see it.
So I am supposed to put a paragraph for MII-Lite containing the 
information as found in this commit message?

As for the patch division, this may be in the one introducing the phy 
mode itself or there must be separate patch like it is required for 
dt-bindings?

> Thanks.
> 
Kamil

