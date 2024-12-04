Return-Path: <netdev+bounces-148973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3621D9E3AB9
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 14:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD271168798
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 13:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2861C07F0;
	Wed,  4 Dec 2024 12:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OAcX4afa"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2079.outbound.protection.outlook.com [40.107.103.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AF1196C7B
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 12:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733317045; cv=fail; b=DT8r5O6OHlQ9JyxNTqirX358i43TbbFQ3Tw8oCiIIQHxCD83u9cK1VMvqk2kROCecu3Xl0wxbqMh43ne0rzbJH/I+FKHPcJSy8KXyscusPSN4UeDuz/63jGlk0SbywJPdfcy8he5neoLxJ4PMcdngO9udW0Ct3W6gsPYEv+P4bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733317045; c=relaxed/simple;
	bh=2sHGSAh1RTKcnamWtPDf09VAaApfwhdBqhh7o+LrCws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IjCJ9DVJ8KbH5vy39H4kUQBjZZvY0i4hrXa46bENgxVc5togHywbMvIp4H9H6qVBIiTgmprfiSBuzZMlagSDelJgjLrb3V2T2/KrMD2MKi8oaMxpDBL5HZFW96L5Of2yxQExxQrRG18B9AbZmq9C/0fLDIunKcnrSX72C6JxYiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OAcX4afa; arc=fail smtp.client-ip=40.107.103.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkt5R/5fnxh3O0NTxeqEitCNUsH4XQDMUPOo06Yf7F+WZt9vYkpbOiwDJrRcOZ2Qi2YAnPqHJ7ZrimdfYh2/1rij2SJG058+acdrkLzqghUxFPh0vPu4berNiad+slkFbx2P+7SHgBcRfpAAYfy0Obfl+IlHQLL7R0Ex1skKdDfa/9u427NEITci4XDylf2Oznbb7SLu+2iFQOL2cS3ezViBS2jWiONraN7Mgveg28s1fsavKO4cXavTypH6YdsrIgqiF5w0zT/PxlQdtkXyKaMqf6tdSPnh6oimQpFx6VfidtXciONaExZA5zP84xSHixokTuG9dtVBX6pBkvkXnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrzAktjhfZBMvF9U3M9ljUa/JQUFCjDBn2j06rlAGn8=;
 b=Xy9kIbI/sdIP9hWTObZRED+8RZl9L141wfv5UHOw9a9v8Qyyvd1mhxlQwirdDAsQwEdlkca43mAwL2ykBERgY0QM42rfNUwcWkh8hy8ZsD2DP+m79qKh5SU5T6bTgE9OQVj+Q1uJ6b91TY06jv75oUDf96lPwjO5sSv+83I9gSGLGxuZkjaz8+OUo77wIUEHD7/Ur4LI9i0F8ejeu7G+ISTsnPfA7rRUt1ou4EZ3tQP2P719t1U8dD0MJ6xb1jTPgHWAyc1gCzYQBNtqly4LiuzXVUtGUNrzckr/WgVX1bgwT98xbaeTyzJNt2IVDzapkF/OJTv9gHMmt+qmEEv3qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrzAktjhfZBMvF9U3M9ljUa/JQUFCjDBn2j06rlAGn8=;
 b=OAcX4afae3IDFSxuq5A2W/DnTjJ8nHACCdlr4WKfrWJ9Q9MQFCHMqZKEJHD+Po3cLHpAwEYS0GlFj2wfYbB5epWFrLBK+atiZ2LZjQ66GbWwqn+rYXKSN6i22M4yjj+9um0WUlPx50PKdlnCQk9fAMl9gI+n7MEuyGFcxh7BEZPpZHUHrSN70uKr6KI93/DS4sqD7Z9/GUabbJa0TQXxdqIgnXFAoJ9yZLIHxYUh0kdRMg/R1+qavC0QXwJKETp4q7HiSaGppIBtugSPtxILKfqRqCMSySfuOHfyWmgkX86GhDWxK9t7rAYYb15l45wMZUhijMWKCeZP7Iv+9JurTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA4PR04MB7950.eurprd04.prod.outlook.com (2603:10a6:102:c6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 4 Dec
 2024 12:57:20 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 12:57:20 +0000
Date: Wed, 4 Dec 2024 14:57:17 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot+1939f24bdb783e9e43d9@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: avoid potential UAF in default_operstate()
Message-ID: <20241204125717.6wxa4llwpdhv5hon@skbuf>
References: <20241203170933.2449307-1-edumazet@google.com>
 <20241203173718.owpsc6h2kmhdvhy4@skbuf>
 <CANn89iKpzA=5iam--u8A+GR8F+YZ5DNRdbVk=KniMwgdZWrnuQ@mail.gmail.com>
 <20241204114121.hzqtiscwfdyvicym@skbuf>
 <CANn89i+hjGLeGd-wFi+CS=HkrvcHtTso74qJVFLk44cVqid92g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+hjGLeGd-wFi+CS=HkrvcHtTso74qJVFLk44cVqid92g@mail.gmail.com>
X-ClientProxiedBy: VE1PR08CA0001.eurprd08.prod.outlook.com
 (2603:10a6:803:104::14) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA4PR04MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f1f1461-8584-41ca-fc73-08dd14633067
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjFXTHJ6cnNqKysrQStRMlN2N3ZPY1QvQks0VzVLZGgybXZXSHlIbEZ4Y3lh?=
 =?utf-8?B?WWw4UjRWVDRvRXIyQkhLajUrSVQwNVdDK0locDloRXQ5TlVSc3BKdFllRnRQ?=
 =?utf-8?B?TkVlQnpqWnRITlBzSk5XejVORmF5MDYxeHBVM01iVFZlOFM2aVRyL08ra25n?=
 =?utf-8?B?bnFOMlNlRFNsVUpiT29CNWplTWx1cDgyVThtc0xxazdXbjNFbWpQazk5TWFZ?=
 =?utf-8?B?czRScVZHYUZYOVQwR0JIMTA4M3lKOEZNQnFHSitIdGN2UmUxckIrbklxSG4r?=
 =?utf-8?B?NlVFcjJtNHYwNTMxYnJyeVFDRGdNcHhMOGJwTkxjZ3cvT1hIdmhORDJhR2N1?=
 =?utf-8?B?akdybVhrRXlaUWpjOFFIVnVxbzczbVRXeHNpZWorTjNlVEczMVNyWjJtMUNj?=
 =?utf-8?B?YlNXNXBvWVJ5blBPMlR2WmUwU2FTZHU2ak5SckhSYXY1QjIvVVVib3UzRi9K?=
 =?utf-8?B?d1pVSmxEOFlxSDNiOTBVVGprRUl4a3dSK1JFYWpTc2g3ckZ1WXgvRnJtbUZO?=
 =?utf-8?B?T1g1RUNuTnhyRktPSml1VXBMK1hZRXF2T1N0cjNLbGM1a09STSs3YUk1VVpw?=
 =?utf-8?B?UmdPSzkybHI3UU9aQXg2em9wY2dVRU54U3RMZW9NbWZhdm0yWWhidkUxWHcz?=
 =?utf-8?B?bEFuQ3FMM2lYR00yeWNmM0s3REEwZFlOOHk0WEZhNEQ1RERNQjlVYVE5QUta?=
 =?utf-8?B?T0xTOHF4SnNuTHBXcEZYM0FCK3hWWkczODdYOWswQ0JOZSt6R2dENCtWcnBC?=
 =?utf-8?B?cGtCd1A5aWdTM2gxM2F3bmRjdHRWbTBTRWFndTJlaGpzQXBFNDhKMDBYaVIy?=
 =?utf-8?B?NWw3YWYyL3dHaUJHdlByVEIwZld2SlBwalI4UG01ZnRUOXc1SG5WZWsvdXli?=
 =?utf-8?B?aEI4aW4rREhRWEU3NHR2cDYrK0tlZlpZUG55c1IwdDhld3RuMnFvRjBYVjNv?=
 =?utf-8?B?NTVuZXhkT2NrcGprOWU4TWxyVllkTDRTTnRDQW9taFZ4VUQ3dXRZcGVua0dp?=
 =?utf-8?B?aFVvYVRqZVFqWnRvajdESVl4WVo4SzA5c281emRua0lRcGluMnJnUUNvV2tv?=
 =?utf-8?B?cWdZNXFmMHh4Ym1rS0RHbTZIalNtcnBxMkVZZ2NQMTlpWnVnU0dNMGorcGxw?=
 =?utf-8?B?eUplRnBDcFl1WjRWTkpXaXNlWWdyKzhlSDRRVkZ0NGNPVURoNHRJU2xYTkZF?=
 =?utf-8?B?TmUyWHJDT3o3RVJuc3k1dVNQMi9wazlKYVd3VGRLcmNqTEFNSU53Z21FQVd3?=
 =?utf-8?B?dTJodGlWNENUeEpNalRLQlN1TzJqeFVZVm83MzJJQUxwaU1mZTMzbjJtL3Q3?=
 =?utf-8?B?Y0w4VnNxRFhIRlpCakpQN3VWOWEvSzQxY0w5cGNVT2lFZkhXd0ZqNERoZHZo?=
 =?utf-8?B?K0NPaGFxOWRRWk1pVnh6aDhmWGFHUDF1YUVtWUI0RTRzZmlSSGJEcmozYlRp?=
 =?utf-8?B?c1BNMTZvc0JEYXI4bXpYc21vZkFoY0ZaSjU4RHVTdnJtUEI5bmp6WTI4dm55?=
 =?utf-8?B?RG5WaVg0N1VEaWNBRGdTUXIxVnptdGVLbEhLRDNRaFBHb0N1OWIxTzBtdVA0?=
 =?utf-8?B?NUJRSkpjaWJ5Yk52WXdnM0s1ZjMxcnk3VGc0N1ExSklXcXhLa1RTUFc0bGNU?=
 =?utf-8?B?UjhlUlNBZ0dYWm8zNVhWTHhJRUZkcXRvZWZRcjVyL0N3VnBvZmozMThSaXhX?=
 =?utf-8?B?VVloVDQvZWFzM1ZvNWtXd2dCUUdzL2ZYUkVIM2lweGJxTHM4MVRpNDlrZDY5?=
 =?utf-8?B?d3g0M0YrT1VSVFkwaGxxUGhYYTdLN05hSnA1OFFMQUFsTi9YNEs1NXFTSlhL?=
 =?utf-8?B?ZlZROFZBWTRXMDlaVEh6QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzFIU0RLc2dXMWtqWUtJZ21NU2pxMVVBWkFML2ZHOTFHd2I3L2FWbHQrcDQy?=
 =?utf-8?B?Qmpabkx5dGkvYnBSUGdvS0pnSDRBVld4ZURSQnljR3U1akR6OWdIbExSUHRF?=
 =?utf-8?B?YWp2eXhHMVFZMGJpSzJQTnZsSldDQ3g0NG9vU3lUZFJGY2ZtcjhPM1B0TGtO?=
 =?utf-8?B?Q1BSeWE5ekpESHQrdlNMOWJqYXdHRDdKdmdScWREd0FvNzV1Q3QzNmVxZkt3?=
 =?utf-8?B?ZGtqTFZVT3hSdW5uaW1GZHQ3R0R3S08reDNCQXVsR2FUYkZzaXFvVGcwR3hy?=
 =?utf-8?B?ZURicWpodTNmcm50TXB6UE1JdSt2VGJCTEZYbUJndVlad0ZOUWtsKy9CT240?=
 =?utf-8?B?UlJmWHhKcG5TRjZob3djbTdEeXVsMDRpMFRnUWJ6ZitpYUZ0SXpPa0thZEdK?=
 =?utf-8?B?UFppM1ZCMjdBZVZveG10TGIraVVSMXlRVW1tc0JxRTFlaEh2ZWEvL0VveEYz?=
 =?utf-8?B?MFF3cTlwOC9QcEQyZ08yNVZlZ0VyN1FmN2xnd2w5bmY5ODJYeVB3N3BKN212?=
 =?utf-8?B?NGM3ZDR2ekdEN0pweWdwS3JESWJ6SkV2eFN2Rkl6N0FEaGZmbnZEMDk4L1dO?=
 =?utf-8?B?WDNrK0NBT3NIZTQ4OU9Kb29JV1NMTVhyYnRJb3ZoSllJTmxPM2t0dXpLd0JN?=
 =?utf-8?B?dmVnZC9LZi9DdXVsc0R2TlNJTTVvSE1UVXNmMFlmK0oxTHFlTlpDZ040bHJX?=
 =?utf-8?B?UG5Gd1dwOWtmOWZBdFk3TjZ1eTV0ZHRaM2UxUGoxOGh0cExOdUFSNHRuWUZE?=
 =?utf-8?B?RW82R3QyOUtvbVNOckNCbWVuQ2VXMWR4R3dPU0ZWK2dLY2J0UGkzMkhDa0pk?=
 =?utf-8?B?aDZndUJHbzJySTVjbHlZTWRwck80NXh6bHFRUWFQRnhGcG5DM21lRndtcVFa?=
 =?utf-8?B?Y3haUDNXNXFyQjlITEFHRTR3dUpTTHkwaTZzY2lSVnA5UmFNZW51S2gzTW95?=
 =?utf-8?B?NzMzU29kdzNkWkt6eDVUMUFZWTVzbUlpeXA1eXF1cHdkL1RiV3RqUXBpTzQ2?=
 =?utf-8?B?TkpuL1ZoQThsVE5uaUZobkR4NXJ4NW9QN01LcUxJL3d4WUYzeHVEakp6Vnla?=
 =?utf-8?B?VVlrU3JmTkRRWFJFVkZ2UE9kTnMxcW16N24xRXd0TUFGOXJ6Um9Nd0dzcGMx?=
 =?utf-8?B?SnkvK3NMRnh1TmtmR2h0MWx4TWtrNGhQZ25YVWpTSXR3QWZhTHhYTTBtNUxK?=
 =?utf-8?B?YnUrL1p3YUp4L1NnK2xTNkhhWUNDbFhTaVI0WXJGNjJlL3BGdm9XSnRIS3dJ?=
 =?utf-8?B?MVVuTlZzNmdWUWpObkVUbFBiOTR2MEZBSHMwOUtkbTdwaFE2SFZXQktFdURz?=
 =?utf-8?B?WkJPUGNZSGM1NWhQcW5pWXB4eHY1d1BrUEpGRk84di84UXRiamZjYjZZN2RU?=
 =?utf-8?B?bncydUxxWHllRHpLRWtYS00vcVNqalFJR1JMQmdtYkRZTGlTdSt0amRmQkpP?=
 =?utf-8?B?Ri9LN1Z4QWoxdGJHNUhDZmlBdUV2YXRTT3kzR0I4YjRwdWpGUFZYaFNzYlM3?=
 =?utf-8?B?cTFpYTlYRGZWTWVMWWQ0bnh0djBRUzNnOFNJUnp5dEFBR2RLWmhFd1ZtL29B?=
 =?utf-8?B?R3gyb0RRSDhod3BkbERRNG5WQSs3Qis3Y1ZwbStwOTIxa0QwZTBKcnhJSEhy?=
 =?utf-8?B?V2cvdDdoTWt1MjVYY0NkcndXbWFGQzM2bms1SWZ6bUNIQzVoV2tHcS9SS0Zq?=
 =?utf-8?B?MVFXanEyY2tvbHlWU2ROU3hVcyttU21lQi8rYzkreVpxazdZdmpRajc0N25h?=
 =?utf-8?B?ZmJXYzdLanNUbm1rNU5UaVRFS0tSQkFJamRrZ294NEhmRWE1VExjZUQxQWNl?=
 =?utf-8?B?ajdUN015Z25hUFhMdGNkNHNVdXRCTURza2dYN09pRkdOcHRTQ29jbk5Kc3JN?=
 =?utf-8?B?elBGNUJrYWtQR2o3Q3lkN25HOUhNVEI1SDZHN3p4VVIrRFJwdmVJdHJTVStQ?=
 =?utf-8?B?a2lGbG1oTXFRVFRvWlI0OElLK3UvVmR6OGZ0VGJjbVAyOVFLcVljQUVsTjdD?=
 =?utf-8?B?eWZwZHh6a2VkbnA3djFvZ1N0UDB6SXhqOTJlNzkxai9VQnZoV0NMeEhYVDho?=
 =?utf-8?B?N1ZBdlZlM21Id05DM1ppNmlYeStSZFU5RDFjYjlxUkZFWTV0RllaZjhwQTFC?=
 =?utf-8?B?bkl5VWMxUFBlRElYdXB5TE1ucGIwNnRDSjZ0ZzZCUStRcms3U0hLbW51VWFC?=
 =?utf-8?B?Y1E9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f1f1461-8584-41ca-fc73-08dd14633067
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 12:57:20.4321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPqnHfMZ2j8TZ+PJjVVymxcgIh0xUG4NHud2AXUJOMUnPvX8vMWFTet7Y644+q7AeeypAGgEuBhK+2V+TYjjRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7950

On Wed, Dec 04, 2024 at 12:46:11PM +0100, Eric Dumazet wrote:
> On Wed, Dec 4, 2024 at 12:41â€¯PM Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> >
> > I meant: linkwatch runs periodically, via linkwatch_event(). Isn't there
> > a chance that linkwatch_event() can run once, immediately after
> > __rtnl_unlock() in netdev_run_todo(), while the netdev is in the
> > NETREG_UNREGISTERING state? Won't that create problems for __dev_get_by_index()
> > too? I guess it depends on when the netns is torn down, which I couldn't find.
> 
> I think lweventlist_lock and dev->link_watch_list are supposed to
> synchronize things.
> 
> linkwatch_sync_dev() only calls linkwatch_do_dev() if the device was
> atomically unlinked from lweventlist

No, I don't mean calls from linkwatch_sync_dev(). I mean other call
paths towards linkwatch_do_dev(), like for example linkwatch_fire_event() -
carrier down, whatever. Can't these be pending on an unregistering
net_device at the time we run __rtnl_unlock() in netdev_run_todo?
Otherwise, why would netdev_wait_allrefs_any() have a linkwatch_run_queue()
call just later?

