Return-Path: <netdev+bounces-210557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB9FB13E6A
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 17:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E5467A46F2
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 15:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE1B2BCF5;
	Mon, 28 Jul 2025 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FJYMLuNt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC1C70813
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 15:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753716761; cv=fail; b=NClg0XreaZgAS7dfnAPuiqrhRFYmX3POvgukg0efTOcbRrdqq4kn8yD4D+OkeIlGi69J95BK2TZ2QlgO5v+6Z2QPQQ+9kMMMjDZtRdNgXGvyq+JVstNZcRJpmYE6RjpO59KLisZI1r3mwDHLeB+WxtkAejOmU5cW961960zCHjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753716761; c=relaxed/simple;
	bh=eO3YPipM29Sw5O/lhcdHJPLk6B9T8wMs/1Oq/vgH6yY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ofxiEcQlFaFZfQsFUOzdjUEzi1WgnQbdQP7pastXP67SRIqdceYXF/cL43x87hZPlHxSvkniwA4Z6PVeQMHQ4cE7zyxqp3ZiEfPzxFSIx+THPE6wCjH+dZGDA0vgBlhxnnx4B04ZToeailIHNZxb2OJvpLRvHdlcVDL+gyMj/HM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FJYMLuNt; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c70pFf+ZOvbYGjzaVUm9f5av42SjufgY3g6NVQHEuLiix9GsYL2plzdOmK4A/TANKnCoZzQfRdeEvORQ5mg5qqOJne94KXZX6l0jqgn1NqdAXu0R7nERe3Pj5Y1fSB1lYaC1WBH4j1E9FQlBOLLP/A6QJHRnj8daljeHO5ofmwpVz1lzmnbrvQKSmoXOviqNWy881/piKki98VScE8iKhtpB02QkYZcF4/Ksb8jIUR2I8uXYCqvXWNt/GacruiW1F614EuZIy+Gwv4Kuly+hndua7QaWjxAd37D0lqw9Fm7BIOvCF25z5vT7DGYpcjXczVAI10O6bScscmdFb9M8yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naczotqTeIeZwExbfh9DIwlprUdrrl22/Axncyr1EhU=;
 b=DpMvxp2Xhy0+wkxdbgMF2oBdsHsLBu6bez2NlQOZhEj1K5fVQlWz+IpSLLG4bNOrNrC/k0iQGhEZ7V0/xhNjbl9j5XT2FQ/BPAkDGYmFyEHd0LDyRT2fwv92R4IpCm0PjF4YfVp2HfQooUbYhmwQKa8TZjstg06sdN5/zXEWWYrmEx1lWH4lOVZLoQ2KWvjb0BnXWzqTHToiNFtGXpLLIPHqqPRbjeSbADADCtttasB0kvm2HFWgadLJW0N9M2uqCRWNHdhYMhnzT+KLb/KLOkqn/cmjS7H53+PQQqeR6yOqPAWREfQ/Z+4va+17Fsxz62bmm7sqXqrWLECfQdS8XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naczotqTeIeZwExbfh9DIwlprUdrrl22/Axncyr1EhU=;
 b=FJYMLuNto2iO1UM2qyhfbIcbIqXt/uHp5vBN80+F/qlrp3/9192MjQD0KxQX4ukjXst0lGIqLGuwK40JEwr3LQ/aBs+RqkHtuC1kDi76pJh9m1rvyHd1sIxtl5M7lrKXs3s53xQcm+6fTZh3X9OnyxKGAze7VdbFbZrD55VqAT4iGauBeYcfJPLLdY44lLqX+tSXGxNw14ysK3SF1r8bEnpcTBT8ijuopSOSIN5JJieVTXrSjOX41QUODxc7axkh486eBo5aCMEXp0/29ytU+hKLf62lrtP9CgqorFTr4pVopODfIvEVrGIBZPuNScVJUtfRVNmNnzTLrGeVURM+ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by CH8PR12MB9790.namprd12.prod.outlook.com (2603:10b6:610:274::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Mon, 28 Jul
 2025 15:32:36 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 15:32:36 +0000
Message-ID: <3adcdb0a-6999-4022-8fbe-9881f8575286@nvidia.com>
Date: Mon, 28 Jul 2025 18:32:30 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] devlink: Update uapi headers
To: David Ahern <dsahern@gmail.com>, stephen@networkplumber.org
Cc: Jiri Pirko <jiri@nvidia.com>, netdev@vger.kernel.org,
 Tariq Toukan <tariqt@nvidia.com>
References: <20250728140554.2175973-1-cjubran@nvidia.com>
 <a1e239c0-ee99-47c6-af63-c9fba3b903ca@gmail.com>
Content-Language: en-US
From: Carolina Jubran <cjubran@nvidia.com>
In-Reply-To: <a1e239c0-ee99-47c6-af63-c9fba3b903ca@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::15) To MW4PR12MB7141.namprd12.prod.outlook.com
 (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|CH8PR12MB9790:EE_
X-MS-Office365-Filtering-Correlation-Id: 41cfd3e2-2013-4f07-8485-08ddcdebfa64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEZUKzlBVUt0dmFnbzNlZ3R5aHZQbTNpZDJ2OGp4VnhFckw3dlBNb0grcE1W?=
 =?utf-8?B?Mit2RWRxQzloS0JmSEkyMkhvaG5HVFBON0lRSHNvdG5ucFJjaFFpc0Mra2tB?=
 =?utf-8?B?dDRlWmU2Vjd2MWFTeFJqZ3VLZ05Fc2MvcUZjbmtldlV3TlFLWFYyUG8wRHNZ?=
 =?utf-8?B?WlZyUmNqSFFLeURzOFNOUlRlSzJKaGdJTldBNnA2Z1kwSTN5TUJwMlhMUERW?=
 =?utf-8?B?a3lOZmJWMkRzQnpWWVRMc3o3Ti9jd0NTb1BLLzVDVHQzVVJYZ0dSV3FWbzRu?=
 =?utf-8?B?OEZ0QjUwbDhzaUlmaDlTWDF4bkdWSWZpL1JFQzVJQnNLaDdRaXlWT2VpdUpu?=
 =?utf-8?B?WEc0KzA1eGVjbmN6cTUyRy9URmtiUWZvT2djOXc0Y2ZnVUs1SnZFUU1lM28w?=
 =?utf-8?B?OTMxSnFoRTBDTVB6UzZEc2h2Tm1oSjVIOVZUUjdpdlJDT0dTVkdVOWx2YWZx?=
 =?utf-8?B?V0hmY2poZHE0bC9TMzdhOStDOWZvaXJrZ3hSNmtuVm9FS3REbVJsK3o1SVNt?=
 =?utf-8?B?cSs2RnpNbXd2SmRpSFpSQ0dHZExPTGxKdENrdlpxbUk0cjRqUzRYc0RmL3JI?=
 =?utf-8?B?MjdDaXFoQXhvbWpkLzBZRVJCdGNhUTNDdk1JZTU2MVpTRVU1ZDF4ZHpsckdT?=
 =?utf-8?B?b3FRdldmNGd2S3Y0d3RUaENWNGJQK29rV09HZkwrSHJJcjhOQkF4TU5MOGhN?=
 =?utf-8?B?cDl1YW0xNDAzT29EK29hWHhMMlIxbjNEa0dyY2VXSW1pVDRHb25MZTdaKzBR?=
 =?utf-8?B?YkVhRStFOG1aR3NRQk13ZHVGc0tTa0k2S2pGbzBFUWxCTkxHVTJNWEhzamtL?=
 =?utf-8?B?czF1aDc4aTZIUXp2QmtjTVY5YnZPK29oZ2xmSUd2WXZwZWI4MllYNUFkNGxw?=
 =?utf-8?B?WTBtMnY2WUdGbHdZbzBuN214QjZzN1kwSEZBODlQR3kxaityMzlVSEhsbmVQ?=
 =?utf-8?B?RHZFUDNCMlFwUjdsVFV5b1RDSzdZeDMwSFQ5dm84OGlTRFpDdjYzVGl5eFEy?=
 =?utf-8?B?L0FiV0ZlWkw3bGVvbis2QWkrd3U0YlMrVE4zNTFYc0xpRlBydElJMTloaHJ6?=
 =?utf-8?B?dmRUMDcrUlV5NmowUldYTGVYQlZnZU03K2o5Ylp5WnBNRHFYTUNDN3lSRFoy?=
 =?utf-8?B?QjhobmdGQkVuZG9WbTY3U1Y0cjJZV3Q5TG42TnF4OEhkYktNQTZXUU41ajk5?=
 =?utf-8?B?VzZXSUNwWlFLT1VJVkVoM2trVzRkWnB3N3JTVlNNR0tDUkp4WnJpQlJuT1Q4?=
 =?utf-8?B?L21uMGJETnBtd2doOFo1Yk1Uajh1ZGxiQWZXL2ExNDd4bW1jZkVSc3EveWFN?=
 =?utf-8?B?RXNid1YvK0JySE9ldDVKL2VqUkZvRGlvN095U0RydHNVVVI4MWVIMmEzYmxJ?=
 =?utf-8?B?MDYyb3owWTMxVzVGWkdaMFh5SjV1QWIwc3k2L2RuMTVVVzMvUHBreWcvdytE?=
 =?utf-8?B?aWxmSG1GdFBscGpkVTZzSEVxNzdqUWVhUWtINi9GSlp4eFFXSUovSHNFR0Nv?=
 =?utf-8?B?MFUyTHNHeEtySU9lVW0xcy9CYVF4N0k1cFVZTG5lcUtubE1zMDQrL0JCVXJT?=
 =?utf-8?B?SHZWc1lKOTUxYURSVmpUaWNoMU5xdEdZa2RUbTNmOFpibm15REgvTmwrMlZz?=
 =?utf-8?B?RWxvam8zYXFLNG9OTHFqYWlaVVhkTGpkWjg0N094MHVIWDBlYWQ4N1BaeWk2?=
 =?utf-8?B?MG8yMDZmWUpVZHd5ZHpqaHRaeCtLb2YzT003MnlwTC8zYXJjZEErT0gvMmxm?=
 =?utf-8?B?UXhUS3ROOXhYOGVnQitTcEJEOFN6Ky9lU3FKelpxSFhxUHoyajVHWndPckhs?=
 =?utf-8?B?b2o4WTMxRld6WlI3bytxbHZnRjF3TEJod2tmMkFkcnVrY1d4Uldsblk2Z1Rr?=
 =?utf-8?B?ZERzTko3ektyd1RMRHFKTGFCQ0lmcUxhZ003a2U2bFZDR2dYcDUrNGJmanJ3?=
 =?utf-8?Q?BaXUXlSe12Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clJOUHRHeklTWnBQRXNNUUtyNTJMQSszOW4zRzQveTBZQW5UWmZpWEUzb2tx?=
 =?utf-8?B?SDJ6MElhMXdkeWppUVNNUFNpSEZuM1FjaGowRklNQm9FYjQ0cXh4ZFZmYzc5?=
 =?utf-8?B?dWROR01Kd1lNODVkMzg1WUZSWnFSUVZnRHBWSFhwWXdVQXRVRjVzWG9lM2NX?=
 =?utf-8?B?RHpSVnB5d1locXMza1ZkQ3E0RjV5QWNWS3hOeU9QL0NSTENVOTU4MXdOaUhE?=
 =?utf-8?B?TVEyZGZOR2xXRm9vRCsyamFNQU5BQ3Fpc1dQci9NZjNtMXJFOHZiZTdRMGV4?=
 =?utf-8?B?MHRkTS9xOW9zY3U5SWdlVE1NbVVJQUdFZ2J2UC9wTTlLN21hSHczNkFlZDhH?=
 =?utf-8?B?b0VDb1lqR2w4V1RyWDdqMUJpbmc2TGxoQUsyNjh1TUZ4ck1qeDdGcFQyVktL?=
 =?utf-8?B?WS8zTFdFQUlvdVF6eVA0T0VxVFkzdzNkRkdyUDN6ajhuMEdDb01jMkIwNGV6?=
 =?utf-8?B?S0dGcG5vMDArKzVJYzhWb3E5ekh1S0hBbm5QbXVQV3V6N0dLazNhNzEybkZN?=
 =?utf-8?B?RWNGM3RGZHFROXBWRmplSHEvajk0VzB6TWJ2TTdDMTN5RkZQOXlPSFQrN0tj?=
 =?utf-8?B?OUZ5a3BuWkhWR3RnQWNOMnlOZkpVZ3gwdzVLMTRrSnpqYUE4ZXN1NVE0S1Av?=
 =?utf-8?B?VkFnbXZEbytTbitiRHA0NDJwNXN1ZVlORmYxeVlyWmVPOXRKWGM2VWpDZjl2?=
 =?utf-8?B?bmJTRDlING4vMkhyaWE3S2c0eFRYRU8xNFFpKzZCTU9sU2hBOXFob1hEU2Qw?=
 =?utf-8?B?dG95WUJKei94QU42MUsxR1FTTG1Pakpkdzh2VjIwNS9nV1FUcWwvM3FNSklG?=
 =?utf-8?B?L3F4eENMbGoxNVIvUVlpeG84MEZUN0FnK2VoeEtQa2xPVkFwb2ZXbzRQdmNE?=
 =?utf-8?B?UVpzWWQwRUVyTjBPTXhQZTltWjNyMGl2TjVxR3NHRk1sdzZrVGtQOVNYM2Z3?=
 =?utf-8?B?aWplWFh0Ukd0S2VPenUxb3pVRzFkaHpRVElTQlk2cGJwQmwxVEs1V2s5R0k3?=
 =?utf-8?B?cWdHckdZd01IZjV1b0J4bFZMN1A5NVdQSmZWWGJISEJDanFuN1pvMVVZUTE2?=
 =?utf-8?B?Z1RScE1MRFRiWS9kUktINjJYZTJTZ2pqOGZTSTFmRGxFMkFjV2d0OFprNGlZ?=
 =?utf-8?B?MkdrM3AvNjh6ckJpUXFUNktxcWV1cm1GVko1M1JQaDZQaVNJc1pySTMyemlP?=
 =?utf-8?B?d21PVGQ1eGdrL0FteEVCL0pudFk1UHpxLzgvZ25YaUtKa2phTlRubWxCUGhN?=
 =?utf-8?B?ZHo5aXlLMHU0Rk1ha1hGZ3lFZkhoS3kvRnZqVXVKNlV6WEVsNkwzMzlxaFZk?=
 =?utf-8?B?M0xtRUtKZkxnU0YwRG45eUtjaDUwdnk1SDhjNVRXNTlYbUUvUmlQeVRHWlhw?=
 =?utf-8?B?aDYyZ2piZCsxT05kTG03QmZ6eTdlbFl5dFVNUm5BcGpMY1k4K0pjS0VLUHJT?=
 =?utf-8?B?MHNGd0h3WUJOQkRJemIyVzJjdHArQzhZZ1NPM1lpWUMvZEJPVVhqb0ZFVEFh?=
 =?utf-8?B?OVFsYldScWRYcEQ5NmRYcHVtV0pZbnhhQW5oSWVLZmRHcEhCUmlSbnlqcUlh?=
 =?utf-8?B?dmRJcjZacS9VS1RzdzBMOSsrRVppM1lPeXJsS0xtd3MzN1ZIZjZ0U0ZJS3F5?=
 =?utf-8?B?alVka3pWb0M3RmVKenhNS1ZxOXRhZy8xeGhjTTBkREFEUTU2OXoyNnlsTUZy?=
 =?utf-8?B?YklDb1BBQ2FiWFdMbTZZZS9ZVndhMkVJZ0VkdjY5eDI5RVF4aUsyeFhub3Qy?=
 =?utf-8?B?NThTUFRacUVEc1FtMmNpR0pYZmRyODV3YlhJVk41eDAzUTZHblc3YWxlY0dO?=
 =?utf-8?B?Rm5JSXNrdnBXekJ5YmR6UUZLWHdMRXE2OTZtN3BIQThYbnlmMURYQ0puUmNk?=
 =?utf-8?B?MTZCSk9jT1NCUE9ycXZUSU9od2tid3RIcldESExlYThhTEloVUdnTHprU2ww?=
 =?utf-8?B?aWNZYzRHTUhjSDZFT2s2K2dDaFpwc29BWVFCL0FUM3I4RWg1SmdOMGtuN09L?=
 =?utf-8?B?cG9KZVZ4VSt0UWhVcHNTaUtMMHdEc0dtWjNxRTMxSDd3TzBLTGtVdDBpQ3RM?=
 =?utf-8?B?bkJUdzFmTUpMdTJVeWcvRDNweFVkR2hDK1RqMlYxMUE1cHhVK0lYRGx2ZkZv?=
 =?utf-8?Q?BzyBvhR/zKuC6OEycP3zNQic6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41cfd3e2-2013-4f07-8485-08ddcdebfa64
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 15:32:36.2582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cEbq20iBDfQjxyu05bRSLzkSdapjw2rX7i3oY2R4W/ENzLj8sodxeWc6Ib+bqKGeOkKQUWPolWGVIu4/lJl9/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9790


On 28/07/2025 18:02, David Ahern wrote:
> On 7/28/25 8:05 AM, Carolina Jubran wrote:
>> Update devlink.h file up to kernel commit 1bbdb81a9836 ("devlink: Fix
>> excessive stack usage in rate TC bandwidth parsing").
>>
> 
> This is doing more than just updating the uapi file. Please re-send with
> an better subject line and description of the change.
> 
> Since it blocks my ability to sync headers using the normal process,
> please re-send as soon as possible.
> 
> 

Hi David,

You're right, I should have made it clearer in the subject.
I'll resend it shortly. Sorry about that!

