Return-Path: <netdev+bounces-166932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F1AA37EEF
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 10:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD3083ADA5F
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 09:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CBE216393;
	Mon, 17 Feb 2025 09:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CXPiNryf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759E4216399
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739785827; cv=fail; b=oBMOM9AOcSL2KcAtJBN0hucsojmCL6XYrMBctvlIfe9ovTc3EBYuw8+4xnxpXHJDL1FHNQ/+P5rAMKimzcGLaMgeeuEuMnSaWoqS0zbMeUYtac+8JKoUx3jdKuhfjK67tdFnW8470H8AK0iNqRWFOjI6A8oWaPHfFHKezcAuI30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739785827; c=relaxed/simple;
	bh=a4fVjMsw/SgGJh8eHoSPw8USgMbNCBnCD0yO4puxhVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mxYZG7IhUrmDCHsIprROEWe09toHxrzwMlEgJBji0c2v0JvwgnpiXwFU8Pivlxnbz37A7ARf+iLB/gCtFBLyCr/sJEMlQSyocDZirh5TtKrvDa730/W7izEg5p5FXRvdI4v+3mkNbrmzxMndH241HJJa22fqK3mD20CoszrQFFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CXPiNryf; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGN8nRZLjx1Ow8P7Etk4U57/qchqQpX7+iVCAfWPe5PEwcCYnM+0Yv9bKpP4/Ukfhfe5qVP1x9MM7Z7w/XcpEBpC+HS9DhYPVIeVXDOXAaEcmh0pfs9rxSqjcZtjhi6yZJBpB30d9eNPNetMBQWTIZXCVAJtmMbYs2XB0PkOQmCmpQKGkIEvwqiSXoaOsULQy1yFeDOiT0ywgzjgt5xe8ju9LeqZzz+BD2X64el8WjowRHWlhoW9XLC/RtQSbTAVp+wgLcog6tD1K9UqgApEf+VE/xBya0/k+6pTGWL4TEULjdfe5Q/krsJ1rm17lhhu6CIdpu4zadXR9iCIpCsn6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t62VDqDzF3H1w3UM9AIn7il/Fbd9FXz4Zv3s6wQWrWI=;
 b=nks20dq/55cO8/e4sHnsTQtETJdLFTIrhOfin9NK2swdZdv/Q+ve5DsuPIYPHAYsFINIiKlzAsYiQL0Q4u4M/u7a0rGrXxU2MsYrjJtgg9vrBbrmA7qkDnASeN/eUzWFW1lsKaYfgZE37OaPUJAUZC/oAIuDeh6z22y4SWZu5KdsNPzyrrAVYlIuxkFMmcpJYRh5ziSgqYKXQ+1llmptw9bT1EKIZ9PKnK8h4rsSYTs6ncPTiZxrlOLUwUTOUx0B5akZrbla/KzVb7X8O/xG07SlaZGuLwq/GEtr3IKv01ZKbI+LZjNpI6bH+BJkZ/nX/OSYXwOLqtDgLTa62ovqyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t62VDqDzF3H1w3UM9AIn7il/Fbd9FXz4Zv3s6wQWrWI=;
 b=CXPiNryfhNym/S8PndVmG7gOHwCUucy/gqUsGAA56opD2dHrKRvkrKsZdswOa/Uj8h02AezHItbI+vgr+03r5cUvcc0LsVxIY7LUhW3QISx0xc56ANsxuhyBhzesUGVCHdC1mSm1GuWhUij2SJcsSWL1BkdE91FGbXOx3AEAvGMzyN2VmU1fE5dKFw9kcMV5/wfqeBP4JSWQ6gBe/P0N/16GuVaX0WVmdMTWC4ourp61nx78VwVNwmIYSlfw7e+99dzpdmtlanBupfPWbeJtSYgUDgx0dqEcMAz0SWATgSxxVz0y08x5L7uRf+JCCoyc61gKT1ty+vATQyXNmYxLiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by SJ2PR12MB7961.namprd12.prod.outlook.com (2603:10b6:a03:4c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 09:50:21 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703%5]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 09:50:20 +0000
From: Wojtek Wasko <wwasko@nvidia.com>
To: netdev@vger.kernel.org
Cc: richardcochran@gmail.com,
	vadim.fedorenko@linux.dev,
	kuba@kernel.org,
	horms@kernel.org,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	pabeni@redhat.com,
	tglx@linutronix.de
Subject: [PATCH net-next v3 3/3] testptp: add option to open PHC in readonly mode
Date: Mon, 17 Feb 2025 11:50:05 +0200
Message-ID: <20250217095005.1453413-4-wwasko@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250217095005.1453413-1-wwasko@nvidia.com>
References: <20250217095005.1453413-1-wwasko@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0343.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::6) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|SJ2PR12MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: b79df807-cc63-479d-051e-08dd4f387d9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjhXTGo3RzdJcThjM1A1NVNzU09uMEVzalZKN0RiL2plY2RxRk5YRFZhV1kw?=
 =?utf-8?B?NVFyMzF5YWthYVlTSS9lNyszVE9DUmhBYlBZK0ovTmE2RnJzVkxBdi8zdkRV?=
 =?utf-8?B?bXdYY2VXSXhKUUlwOW9GQVpTaXFIa0xaSWZ6Qnc5YmRFZnlwMmR2OEJRSnFS?=
 =?utf-8?B?V0lFdE52VWl2ZWdrU1d5MHB0clhkNHhQUlBqdmpVS2VzYXNzV3VweEo4L1NX?=
 =?utf-8?B?K1YzbGpnd0FUeXRIbWZXZlF4anVudmE5amczTnByUmR5cGk5c0x0SWJKbEh2?=
 =?utf-8?B?SGs0YTFLMjc2Q1dycDJha1pRRkpZR1JsdGFteUpYVXkwU3gvc0RIKzhkTE1W?=
 =?utf-8?B?QzduQW9aTHpPT1FucUtHZFpCMXhncEhNMXc4cTdDMVFYNXBTbkJ3S21XTllX?=
 =?utf-8?B?V1d2N09GUWcyS2pOR25Rc3BaVk9HUzZSTm1kaEhhTnBpR2hsSXBhOEdDNHpo?=
 =?utf-8?B?bStMS0l0UzJaalBUTThVbkI2NlRwc0xteUdaa0RCL1BKcnZBQlRFWGVxWkhX?=
 =?utf-8?B?cXdBT1FQSHNhams5NktyUzhPcjBLMWVnVGxvUmI1VU9BbVZJRytydm9MeWJS?=
 =?utf-8?B?YUliYzRrT0JzL1ZubEwzeG1samZTelZra0Z6TTNuL2JyOGVUbGUzSGFxMFh6?=
 =?utf-8?B?Y3I4T3pGTzg3YStUZm16VURGRll2R0cyczZWdmdiNGVGZTlwZG5GNnlIZDBi?=
 =?utf-8?B?TVJZQVdtb2V4TWFZZGxlbGRoekZBKzlhc2ZKMXpYL2VSa1Jvc2Jja09wcENX?=
 =?utf-8?B?R0J2QUZyMnpNU1FPamVsN0tZZ1oxQkVVLzllR0RSdDYwR3ZNci9vUjVNTGlD?=
 =?utf-8?B?RmxHRG8yZStlZTY4NGl0aFJxejFiREczTTRmYkNVMFI4TEJUUUlDSi83Zi81?=
 =?utf-8?B?MXBQbFJveXd0Y2p0c1plbkU3VWRYN3FyTTJLQ0puMkkvanJrTFNkYjhwWVR1?=
 =?utf-8?B?ZE1GVVNxT2swUWpWTGROcE1wdG92NmI0VU0rZEprM09jKzdWeXo0dmpHUElt?=
 =?utf-8?B?b0ZOc29IRkRXZVB0RENaRXZHMCtUYlJ2bVhEZVJvczVMRnNTUGtmU2MwVTdw?=
 =?utf-8?B?YXUvcXZCQWxFem9RUFZpYTlPUFlaZHFqa3d4OXZYWDdFcHVjUEJOYnlJZjdF?=
 =?utf-8?B?MXRQQlg2MEF6cXhJOVJoYnY3S0FjYytVOG5IdU1odTN5R2tuQXRkNGdWM1ZX?=
 =?utf-8?B?QWVSY29lcGNZRjNZUVlHUUtZY3VxazEzN0k3b0VzTHFPb2gzY0Vkc2NUT2JV?=
 =?utf-8?B?Q2J4Q29xbEdzRlBKcDNlZUpMT1FBYm1mcitpV3JSYlFSdXc2KzdqUjJDbElG?=
 =?utf-8?B?OUVRWGRaSGJEbkpGRzZzbFJERnRCS2hLWW54L3psYzl4SUdXaWhPNUk5dE9h?=
 =?utf-8?B?UW91STlQZnlFdTVhZjl1UkxjMVNTTkw1TmQ3citMTDhoVGZWVG1PTThIMmRH?=
 =?utf-8?B?c2RpSFo0YVp0dHNlZHpwM2c5NHF6M0N1L1FkWStoSklJd1NraFN1YTRMUjlt?=
 =?utf-8?B?M2JNSDF3bktrb2syZE9FVlN5KzdQYW54L3hjMk1iaVFWNzB3dy9xeUZWNnRG?=
 =?utf-8?B?UmI3RGNXSnMvOW9CZlIxR3NjR3NFU3BKRHpYdEVQQ2NMd1IrbDBQQ3NMbWtt?=
 =?utf-8?B?bm02ZTNuQVBpNzZBZE1KYzF3OExiWTFnWGFucFdTbWhaam9NWktKb2xhMExr?=
 =?utf-8?B?QjVNK3VkNFUxclVqT3ZVK1ozTE9KcXVSbVdybnVaWUM0Rk1LcEpjVXRMSnly?=
 =?utf-8?B?NFVWYnZGZGNpSEE2aGwwelQwSTBFdnI4ekxWd2o0bWUvQUpPL0lIYXJpR2sv?=
 =?utf-8?B?VGErTXBOdEp3VkZ3cnRtUllxcGRiRDNmU0tUYldBN3RTMzNDZWdzWTk0ZUd2?=
 =?utf-8?Q?5orJE/PJ82SB8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1Nhcm5CelJMUFlNZE4venM1elZvL0xlbU5yOE1aNVFoWWtWbnZoM1V2K1pH?=
 =?utf-8?B?V25KbFplMFBZcXJ1Zy9sZUdjWWRKMHdWYVRnRFNjUTBlZFRKTTB0NGxDc0hG?=
 =?utf-8?B?MjRYV3lmaEcrVC9JcmVZT2NMSDF4bWhXQm9FT2ZmZnhPcVo5RlRzcXo4SUxI?=
 =?utf-8?B?VkV3OE5ZUUVvV0hCdVJUUEQ0QWhhMG5kRWI2dXlHUmZhYXBQaTRnWDBtVzBo?=
 =?utf-8?B?KzlMcnJ3N1pneWRwSEdyUGZ6eWg1YThsekZWNHIrNE9Pei9qQk1YV3UxTmsv?=
 =?utf-8?B?QkthamIrVnA0SDBPTlVLUHlxY0hGeStYZ2NTZTJpL1cxZUF1RzcrdFZhUXVa?=
 =?utf-8?B?c0hGT3g0L1pXMm5HSmpYYWZXeXNxL0tVdEZFbkQweEQyT2hlMlNRME1iNWJy?=
 =?utf-8?B?TDR4a0NZcnFnck55a1dGbThZb2NHMitVSVFrSWxuK09kTTMrRnRiU2ZNdlZ3?=
 =?utf-8?B?U3plSmtIdGpuMG44VHQzbjJFQkJsVGtPZGpGemVvUHp5Wkg0MWRwTFYxRUVV?=
 =?utf-8?B?cGZKdXVZdm4wTFVhN0JYdVNEK3pjMGl1NUJtaktYM1hXOHNGdVVQTmRWamRk?=
 =?utf-8?B?cWhLKzlNSlVoTmVkbnRDV1JGV2cyb2YzUHREWmJzOTV4S0R3b3dWT2tpS0Jk?=
 =?utf-8?B?eEh2d0RKOHJKS3pwaTU5VVl1NVZ6VG5PVnUwc2lORXAzcjV6VXNybmpOeG9Y?=
 =?utf-8?B?aVhITFAzMDRFVmJBUjBpVXF3NGphbVFPMEZyWXE5UWxGblg3eURTdXdZWlBU?=
 =?utf-8?B?a1F1VlNPK21ZRXU5ckhXaHAySlZXNlYrbEhsdENmN1FrTm5Ec1NuNFFSS1Bi?=
 =?utf-8?B?TkVnRHQwZURHZnVNcnBucjk1eng3anl0dHl2dU04WmtBV0owVlJaUHQ0dGt1?=
 =?utf-8?B?OGp2UEpEVWdRR0F5ZDVqUFJ2SVl1aktGcGUwMGYzb2VKRDB1WjlDNlR4ZVdx?=
 =?utf-8?B?VnRoT0VhVXBodmltKzl1NkswMjA4UlIzUXZ1bWZoUzFqY0pnUkJ2R1VhK3cv?=
 =?utf-8?B?bHUrbFo2TXVnTmtkNVdBcGlQbGtjSENOdFNZRTJxOUJsbzhTU0V0S3I2UmJC?=
 =?utf-8?B?bDVkM1dOUkYxMCt1a3lPNmppUXgwYVVZSVYwekdTenBlWCtzRVZLc3VjL2lS?=
 =?utf-8?B?eWZJMTRpblMvMU1oaDRRQWkzUzRWMEpGeDd6ZGJOa2c0UVBPdE1EdzRyY3o2?=
 =?utf-8?B?VnRUVW5GejNZSUlCNDlTL2lYMmFVLzhiS0tqV2pzako2cjNNQklmdmp4blFC?=
 =?utf-8?B?VGhTZTlMR0RGaVV1R2xQeGp4UkU2dUljUHhmMExmcGhJUjU0WUtBa0h4ZFJB?=
 =?utf-8?B?UWErSlp1OVg4RmRldjJZalQrQmlBNHBPeG9MMmU2TGpON1VsWk9tN0dCRGJC?=
 =?utf-8?B?cE4yZmRVdWY2bDl3NlErL3dzYUNsbkEvQ3hManZNdnk5Z0tNQmlZdlp4SzRh?=
 =?utf-8?B?aE9kdVJmNDhXZ0lWNEZDN21GNW5zUVp2ek9kOWpFaXdad3NIS1VRcmhPR3dx?=
 =?utf-8?B?bWpUcTRYTWxUUzhWbVRzYUZXdVdmaTlFZHhLTllvU0ZFZU1zbVBpR3hQOFdF?=
 =?utf-8?B?SSt0RGIrei9nUDB2c210Q1RSTXYrdUlRcFVBOGRnVHN5dmN5WmM2U0g0K0FG?=
 =?utf-8?B?UUpHVmZVZVpaVzFBenNiR1VnU1B2UElBSjN3ZUZwYkJQbXJQeG1kRXVqQW9W?=
 =?utf-8?B?QTRDRTFsMWdiZmJBeDhlT3hkTnBCKy9FNGdoSHpDSWhyZmlNd1dzczZrUTh4?=
 =?utf-8?B?Mm81bW00OWVZVDNMeWRycE5uZ2ZNK00wOUlVOXFrV2U3c2JpWENGaFUvUktO?=
 =?utf-8?B?bzVhWktEOS9sOEpKKzhzQWVHWUpWUTVlL3pLRllkL1E0TFdKTFozOVJDSk1W?=
 =?utf-8?B?YkNHZ0FwM3ZNNEtMdEhmRkhVVVAycDRHRFkxN2YralNSNG02MG1aZnZsZkt3?=
 =?utf-8?B?NE1ydHNhemx3ODJXL21iVHlsZ0tSbmZzZ2x3V1ZGeDFEdks2NGxQa2EwajQ5?=
 =?utf-8?B?c0xBZm1wUlE4Vlkzc1ZnN1FTTW5LQ0tUckpBV3Zva0NqbVJyTlJNZXV0clpE?=
 =?utf-8?B?d09YTEdRWkZBR0FnMG96aTEvQVJvVCtxU3owbWVMcytpcUJFLzc4VjVLMjhq?=
 =?utf-8?Q?/sogLCfBmU7ZSU7b5ejFah3wm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b79df807-cc63-479d-051e-08dd4f387d9f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 09:50:20.1791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DkJt09jHSkxFEkerRcpGdt6PRF3SjN+OjO624hmQovcoti8depkDyM4HCU1X+xNvJUyFX0Oi3z/3LY930FTBEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7961

PTP Hardware Clocks no longer require WRITE permission to perform
readonly operations, such as listing device capabilities or listening to
EXTTS events once they have been enabled by a process with WRITE
permissions.

Add '-r' option to testptp to open the PHC in readonly mode instead of
the default read-write mode. Skip enabling EXTTS if readonly mode is
requested.

Signed-off-by: Wojtek Wasko <wwasko@nvidia.com>
---
 tools/testing/selftests/ptp/testptp.c | 37 +++++++++++++++++----------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index 58064151f2c8..edc08a4433fd 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -140,6 +140,7 @@ static void usage(char *progname)
 		" -H val     set output phase to 'val' nanoseconds (requires -p)\n"
 		" -w val     set output pulse width to 'val' nanoseconds (requires -p)\n"
 		" -P val     enable or disable (val=1|0) the system clock PPS\n"
+		" -r         open the ptp clock in readonly mode\n"
 		" -s         set the ptp clock time from the system time\n"
 		" -S         set the system time from the ptp clock time\n"
 		" -t val     shift the ptp clock time by 'val' seconds\n"
@@ -188,6 +189,7 @@ int main(int argc, char *argv[])
 	int pin_index = -1, pin_func;
 	int pps = -1;
 	int seconds = 0;
+	int readonly = 0;
 	int settime = 0;
 	int channel = -1;
 	clockid_t ext_clockid = CLOCK_REALTIME;
@@ -200,7 +202,7 @@ int main(int argc, char *argv[])
 
 	progname = strrchr(argv[0], '/');
 	progname = progname ? 1+progname : argv[0];
-	while (EOF != (c = getopt(argc, argv, "cd:e:f:F:ghH:i:k:lL:n:o:p:P:sSt:T:w:x:Xy:z"))) {
+	while (EOF != (c = getopt(argc, argv, "cd:e:f:F:ghH:i:k:lL:n:o:p:P:rsSt:T:w:x:Xy:z"))) {
 		switch (c) {
 		case 'c':
 			capabilities = 1;
@@ -252,6 +254,9 @@ int main(int argc, char *argv[])
 		case 'P':
 			pps = atoi(optarg);
 			break;
+		case 'r':
+			readonly = 1;
+			break;
 		case 's':
 			settime = 1;
 			break;
@@ -308,7 +313,7 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	fd = open(device, O_RDWR);
+	fd = open(device, readonly ? O_RDONLY : O_RDWR);
 	if (fd < 0) {
 		fprintf(stderr, "opening %s: %s\n", device, strerror(errno));
 		return -1;
@@ -436,14 +441,16 @@ int main(int argc, char *argv[])
 	}
 
 	if (extts) {
-		memset(&extts_request, 0, sizeof(extts_request));
-		extts_request.index = index;
-		extts_request.flags = PTP_ENABLE_FEATURE;
-		if (ioctl(fd, PTP_EXTTS_REQUEST, &extts_request)) {
-			perror("PTP_EXTTS_REQUEST");
-			extts = 0;
-		} else {
-			puts("external time stamp request okay");
+		if (!readonly) {
+			memset(&extts_request, 0, sizeof(extts_request));
+			extts_request.index = index;
+			extts_request.flags = PTP_ENABLE_FEATURE;
+			if (ioctl(fd, PTP_EXTTS_REQUEST, &extts_request)) {
+				perror("PTP_EXTTS_REQUEST");
+				extts = 0;
+			} else {
+				puts("external time stamp request okay");
+			}
 		}
 		for (; extts; extts--) {
 			cnt = read(fd, &event, sizeof(event));
@@ -455,10 +462,12 @@ int main(int argc, char *argv[])
 			       event.t.sec, event.t.nsec);
 			fflush(stdout);
 		}
-		/* Disable the feature again. */
-		extts_request.flags = 0;
-		if (ioctl(fd, PTP_EXTTS_REQUEST, &extts_request)) {
-			perror("PTP_EXTTS_REQUEST");
+		if (!readonly) {
+			/* Disable the feature again. */
+			extts_request.flags = 0;
+			if (ioctl(fd, PTP_EXTTS_REQUEST, &extts_request)) {
+				perror("PTP_EXTTS_REQUEST");
+			}
 		}
 	}
 
-- 
2.39.3


