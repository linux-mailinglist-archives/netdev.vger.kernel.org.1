Return-Path: <netdev+bounces-118795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C1D952CB4
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7F061F2277A
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 10:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746B819DF63;
	Thu, 15 Aug 2024 10:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="I8aqU7vg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16E4187348
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 10:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723717753; cv=fail; b=sOvdI4iu+jD4u5/YtE9wMQRibA8lVoJFjdl1qeSc7GuDNrXDtiPabOFcrgfcojjAFEe479EHf0yFYk5oUAYaUw+yDqxY8/KP9KIwkmvQnr3ZkzLdsqVrnlSDj+zxTF0vF7VtkmAh7KPFlhysn7XH1mVgmmT8ZsJWL30vVFUPSbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723717753; c=relaxed/simple;
	bh=lVsslvgL1iGoV9fgvPEhXWt6sJcKkrgtJCOuDrMUySg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=hRhsZ9bv17nNbRBA0eyy3wv4RJwctuxz89LpTGIu2nRohn2UUV29iL7j+SPxjprp9mzNyjPGirjaSqHwsETngInE61Xj68kWiaeRC58rSa1/mPTDaJwSfgp2zT0ZsNpj3FyD7uRvcVvE2/nFJUASWs+Brp7tsS6kRgB48I7vulg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=I8aqU7vg; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47F76rG9023042
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 03:29:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:mime-version:content-type:content-transfer-encoding:content-id;
	 s=s2048-2021-q4; bh=lVsslvgL1iGoV9fgvPEhXWt6sJcKkrgtJCOuDrMUySg
	=; b=I8aqU7vgsMXPoKR8sNeEGu74onHxLv9IflaADXO1Rt6PGYlWzA/nT/Hu9S0
	BTfcGMQm7BZenqcotzSQfT0to21s8OtI7X7z9jz8oHY1M5hPepVvDkrHnRwpn0YB
	YqvMhmkTvZX1Hv4aP+G17ylCjDx3Jk0I3YCtDGK/NEIXLKJIiaLGF+MSyhpSzGox
	KR7LFiSHEt4xkZdpo46SGjJwQoikQ9cnY0eKYjZYuOoPvmsEuz6JCmlSDJMsV/d1
	T5Y0InzQTEUixoKJxFPqEU15GQKJzZpsrv//B9Woqcrkdg2jKhKID65ktlLbJ8HX
	foJsR+LRI/KDrl/jK7xFBl/eWnA==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 411b0u93qf-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 03:29:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zCeNx/8TTA9CtfcPG6HdXm5fUeM0aGUGdYsgm1y49umN+DQtCHVNiIGKWEp/9FIl1RU4RAp8exAqiNN4cJB65zZhLbZMDoDymI2OGY1HcEl1zwDAhySIR982WwLt0Jc+jouGRFwmekWQeP9HCQiD1rG7NSTM8YPC0TkGUGog3zUEvS4o5zdy3rPCNLzmxdnJhrK2eVREjnAKwNlH2Mwe0UmnQzR/293YRyB/Q/J8jBgbRz/9CmkZ5xxAB5BpCXUErUQDcXEZ6KJM5STlfYeRDRZlRttpuhw5G+jGAX+3crM7x+F4E+HGOoTn8l/CR7I19Hzibhp711uvOJGt4Jz78g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRLPNi9pHxeP6dId71KQro0b93BaSDAaghmEV804Eb0=;
 b=L6lgoRfmMuD7sIhZ2BeKHS822AuHzwrVst7Ti7affUQm5JJW0BF9MxrYtcJ8qDL+HvTDSomRXiDCUpsVrGmP59R4DgtkAK/ngtnpet3mlk2ViUn0cAeUEaHzGodT8BoIxXAfZwvitySDJO9phoB5a5cNRVZdabbZzUvc2bgMZ630zIvb3Cw3VLTkYro/nr5R4I3UDq4/MgldXYecGhu/SHsrW1d68ERWfXS13P0fOHsWFCP5ITeZwOQk0SL4kqBTOoD5j8df43yqNE/YAo/PTv6RSrb+8glIOQdpx5Ax6Th58qCX+H/eW+09jBj0wIaEXxIu/td/1YgsuCtUyyKx5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BY1PR15MB6176.namprd15.prod.outlook.com (2603:10b6:a03:531::18)
 by PH0PR15MB4413.namprd15.prod.outlook.com (2603:10b6:510:9f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 10:29:07 +0000
Received: from BY1PR15MB6176.namprd15.prod.outlook.com
 ([fe80::9d0f:34a3:efe5:2a58]) by BY1PR15MB6176.namprd15.prod.outlook.com
 ([fe80::9d0f:34a3:efe5:2a58%7]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 10:29:07 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Maciek Machnikowski <maciek@machnikowski.net>,
        "kuba@kernel.org"
	<kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "jacob.e.keller@intel.com" <jacob.e.keller@intel.com>,
        "darinzon@amazon.com"
	<darinzon@amazon.com>
Subject: Re: [RFC 0/3] ptp: Add esterror support
Thread-Topic: [RFC 0/3] ptp: Add esterror support
Thread-Index: AQHa7YA43RNHG1guCEC4fCyG5krtqLInfNCAgACVMgCAAA7mAA==
Date: Thu, 15 Aug 2024 10:29:07 +0000
Message-ID: <9a15379e-9c1e-4778-bda1-38474a8d9317@meta.com>
References: <20240813125602.155827-1-maciek@machnikowski.net>
 <20240814174147.761e1ea7@kernel.org>
 <38459609-c0a3-434a-aeba-31dd56eb96f8@machnikowski.net>
In-Reply-To: <38459609-c0a3-434a-aeba-31dd56eb96f8@machnikowski.net>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR15MB6176:EE_|PH0PR15MB4413:EE_
x-ms-office365-filtering-correlation-id: 0294ddba-c562-4d06-4b8e-08dcbd1517d6
x-ld-processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UG1QbkFWcGozWFA2TXNRU1E4ZkdMckM3b0dtUGViczhvTUFYbHN6b3hZYlFE?=
 =?utf-8?B?eU41SVk0UUVienRHZnVRSVBaeXV5VkNjTTlQSTU3TGJQeVBNZ242UklLWWZ5?=
 =?utf-8?B?RERxbjd0aTVUVTFpL2JEVmZOSGVHa1Bja1hYK1RtV082ZTlFdjZvLzJIbzJj?=
 =?utf-8?B?SjVvbkRiaWlMdDh3Um9seTBYOGNVbk91TXVFaWRyR0UyRWNJN3RpeURhU1VG?=
 =?utf-8?B?L0Z1Z2p6SmNFeXZST1VhSEt3dEpGVVZLL09LZGtxSUNZNE8vZ3lXV0g0OGg2?=
 =?utf-8?B?eldIbnl2ZHlnUVo3dW1kVmFrQTlTWUtjYTBQdDZwV1dCcHBJSGE5QVlpaGFU?=
 =?utf-8?B?eHV4bWdSanVNZHd1eWt0V2ZCc0g1amkxdnFKeHVSaS9nM2lBRzVQTTREUlox?=
 =?utf-8?B?bVpSbFEvZzdhekJDSFdSb2llTVVSVVBxOUluWE13RlpYeTdSak1uQWJKRk01?=
 =?utf-8?B?YTUyZ3NTRTlaelpEU043TDdBQWtObkdWenpKRHdydWh2QnpsY1UxZjVLZWs2?=
 =?utf-8?B?Y21KSzNkYkx5Vy84MmNLQlBSVWVVai9UZW1Ub0x4b0RKNmVpbmhUbkw2RUVj?=
 =?utf-8?B?cTVBZjdScXN2SmVUQzFRQmtYTmpGU24zWXRsd0FJNzljSFhtRXAzYzJpV3BT?=
 =?utf-8?B?aWxjSXpvbXFYWTJ5QTZWbUJyQ1RLQjRRRlVSVk5CZ1J3L0lsRmxtR3V5UlZ3?=
 =?utf-8?B?RzNrVWs4V2I0NGVma3lNR25BUjNjbXY5SmpzaDFld2pMS3puZWNtRytrN3E0?=
 =?utf-8?B?cVJIUjVJZkpXK2kwdmxvSUNFMTFQMVA4alJlMnhuUGVIQW1UVWVyM0JMbjlD?=
 =?utf-8?B?Lzl6TlFyeGM0dG5nWHJQSk8vem1xUXZIdjN4OHBTTmM3cXc1L0dGVUtGRXd4?=
 =?utf-8?B?RUdneFk4M2dKQVNTWVBOdzJzNmEwaG80cU0veUppV0lUMzNKVXFoclRXMitm?=
 =?utf-8?B?Zk00RHpvR1pDdE1GWmlaOTFIeXdadmQ2dmpnY3NlUHA4akVUWXh6RzZLejY4?=
 =?utf-8?B?clBaTnZIL3h2RytqbnhWRTlKTzJJaUxZemR3cHlmV1ozYkI4dDZwRmMwMlBa?=
 =?utf-8?B?RmMrTXY3Z2ZoMGNzOXNWZDhuMVVFeWVJVHdzYjVwVWVyQ05BSGRYT1N0em1S?=
 =?utf-8?B?bFZhaHNGRVJjZlNNTitrVU4vUysvZ0U4YUtGdVd6YXAxc1JBT1ExTXZkSmls?=
 =?utf-8?B?blBvcVNRVWpQcU1DRFpLS09GUDNmclhDdVltOTVKcDZ4T1VBZ2ZrQVNFZWhS?=
 =?utf-8?B?cWNGZWl1YzhXRmFiOUVxMzAvU1AwN1JPVlYzb2hhbk94NjllWnZvOGFnNjV4?=
 =?utf-8?B?YW4rYkNrcmoycmZpQzh2aWYyS3UySkV4Ty9uYUhiRGdJenJKZHl5NUQxa2h2?=
 =?utf-8?B?N0xaa1ludnNaTWRnbVZFbDM0eUhWQUdPSlJLRkhtekpobkFDelZuU2tTVmZT?=
 =?utf-8?B?M3VKaHZnRTJRQWhmN2NlT3dpemI4aHVoVk1tOWxGQTZ3OGFTZ0lzQkFrTHI4?=
 =?utf-8?B?R09MTEd0NGRCYWhRbkV3am44K3RFVkNNUVBMUnVHSERpNjVxVHZObGNQOVBy?=
 =?utf-8?B?alM4bzFSRTZZZEk2N2dJMHFicDVyK0tFa0k2M0QyVzVoODFNQ3ZKZkNRenJl?=
 =?utf-8?B?Nko0cUFGTC9aVW84VTZkTXB3QWZvZkM1dnhKd2JYbzloRWlFVUpvUkk4SHdW?=
 =?utf-8?B?UFZVVWNuRjRLbk9qTFlteTJ0QWV0NEFldmVjM0ptaHhKNFNoZlZ6eHM2Mkx5?=
 =?utf-8?B?WUFLUlJ2a1BaZnovNTdJSFREY3dJeDlxWVludGdNanNiSTkwZHRWL2NNaDIv?=
 =?utf-8?B?OGZOeDNlbEVlYVVXdWxyOGhIQjB3NjQxbWZqWTUyZmE1UExxTElHVklUMHoy?=
 =?utf-8?B?QjIrajJRRUU4czNYS3lqSFdFZnlDOVROaE1WMDE2NGxwcUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY1PR15MB6176.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L1YycnNnT2xCSTZDTTZwWXMzUDZwZ0JLeHltYVVoTzkyTzI3bTJMSE12RWtN?=
 =?utf-8?B?SS95MDk0S2loVThkVHFlTDlyZmlkemh5QlNtQUlyQWVtVnlWRmFMWElKNmdm?=
 =?utf-8?B?ZUNUNUR4Z2FYUEgxUzVVY1F2ODdIRFkwbGNUVUNMajJEblNjbWZsMDlOeWtw?=
 =?utf-8?B?d0t6WDZsMGVLSDZ4Vks3dUM2OHdrampZckt0Tk9uS2kydkh2QUlKcTlHdENJ?=
 =?utf-8?B?Snk2VmNHMWV6RDc2eUxESFpkZVBRbnV1TkhkMFI1SkJsVG9oTmdiU2xwOEVn?=
 =?utf-8?B?b2IvZ1QzelhwczZlL0N0MHY1aVExVm51MUVRS3B6eGhBcm5VYUhrN2VGWnZv?=
 =?utf-8?B?N1dmTHBlYVRGRnJvTGZnd204VWlsZ0UyWFJBMWRCSkxzQ3lPbVNRMlVBZXk3?=
 =?utf-8?B?V1pZd2owM1I2cnlJMzl3cVJ3VTMvSkFQYTI1Y3c4SnkzK1FZNDRlOFhydkRK?=
 =?utf-8?B?YTlucWdjL2pzc0xBeHpkbHErM1NaUnc3NWl0bXoyNmZ4VmtEYlByMDhPV2w5?=
 =?utf-8?B?aXQxdG95NE10bHoyYkZiM3h0T2lPc3c2QVpEYytTbXdhelJjNGFyT2xNbllY?=
 =?utf-8?B?T2dxWDVxdVBqRnhTOGUyc2JsTkluRitIMnFqVzEwVGNLNXpWWXYzbzZMVFl4?=
 =?utf-8?B?TVVPczZCVGRaQ3JEK0piUTJXeUJwQ3RhUzhHWm9rQlFQRHJwd0lIWXBOK05I?=
 =?utf-8?B?YlQ1Mlh6RHBGVkErcVpVamZGS0JVTkM4Si80N1drWkdyNjFkdEZDa09meThB?=
 =?utf-8?B?ZStybVZJYkFBdVNHcHViVUlrSGt5elV6NWMwbm5lRkI5QkpXQUdCaFJqS29K?=
 =?utf-8?B?ckVpNjNkYVB1bHUxcW5TUWRlUmQwbktiOGpFdkZON0dCNW40Y24xczZ5OGVo?=
 =?utf-8?B?NDJKc1ZyODBtNmR5aWtwRlJITnVWOTV0WHYxdCt5a004aUNBTHZRU3paTkhJ?=
 =?utf-8?B?Y0NJbDNVNTR0Q2IzZTc2NUQ3MEV6ZVlKSjBqODVYWlVNdWFtc2tmdGJKWFdv?=
 =?utf-8?B?YjFOZmFuZjVZN00xZkpLRmdPV0puRUJyM0ZEMWJ5dllSV2RkZFBJbi85Z2dR?=
 =?utf-8?B?NkQ3bGpKTlJub1VmWitHMVdoNmFVdEw1QmJXQlViTTFReWRqaWpWWWNTei9p?=
 =?utf-8?B?WGRERStmY2E3TnhGZEJxUkpTb0gyQXM2aVczTEYzd21JcjVITW9wRkZsV3M2?=
 =?utf-8?B?bytOUDl6UWQrcUN1UVhiOS9KVGxPMnJ2cElWV3FvcnJQUzRjcUIvU1VKODJl?=
 =?utf-8?B?bURYcDZmeldDZkZkMm1qNDdCZlNseDc3b1d2akNMWGdvMEVid3ZjUFRsbW91?=
 =?utf-8?B?YXgzZmxyVzhVcjNrYm1qemlKS3R4SElPQzZXaEI0WC9Sb3kxemVIbjlKQk5O?=
 =?utf-8?B?ejlodU44N0x4VlNGME0rYy8vWlhoMUc3T01qRWY4TFdFbGNsb2hWQ3pqSzhH?=
 =?utf-8?B?T2Yrdng5Z0Z2NE9UeEdaRlFCZm40UFZ1R2l0am9rd25tVlVIUjNoQyt5L09r?=
 =?utf-8?B?NjVnZDdMSjViRDFNZmthODYySU10dDR2TzdlSWk0TkVMUGNLZGdRa3FGdlJR?=
 =?utf-8?B?R1ZKMnR2cVZpcjE0T3BGOVBFMjlkdmxaRWVnSFVHbWdNMEd2dE03Si9ZZGFP?=
 =?utf-8?B?Nzk1Y2xGb2lTUVphWGZxSkx6SVRNR3lVd29jZ1hRNzBUd24wOUY2VnVWNyt2?=
 =?utf-8?B?eVRmdEhyY3ByaitLUjUvbUtjSWJpOHRzWnR5VmlQVHRmb3RWVnl3Rnd6YkJW?=
 =?utf-8?B?V2dWeGlmTHhIS3FMWEZMY3NVUlFPMmlWN0ptVHBJY3AvdmVsd0xLNDcyRjdh?=
 =?utf-8?B?SHFXblMyZ2ppNi9MNWpUcnR6NVMzZ0lLUVZUN216S2hUT3ROekFEWXgyMG9k?=
 =?utf-8?B?V1VaUTJYS3FjcnVRaHRQYUYwaXFRQnNxVWRCSFF5ai95Nkw4Rmt4QW13R0RM?=
 =?utf-8?B?TmJrbG9KSnhCWWUzYzNvaDl2M1czYVI5LzBtQnVVdWI4U0ZhVmdRMkVDYmcx?=
 =?utf-8?B?V04wUHZDTTIvUTVjSjZUM3BoQkh3MkJuNm1wVEJVQlRTa1hjTitkN2NxVXRM?=
 =?utf-8?B?UXpwOGl2MEN6SUE3cUk3WnZpUmNDYlByaUExb2sydC8zL3NWQkxwWlU4R2h5?=
 =?utf-8?Q?gZWxe/OR6tTm8FY1OrVRULiGQ?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR15MB6176.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0294ddba-c562-4d06-4b8e-08dcbd1517d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 10:29:07.1287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 01zSgE/mxdEGPFv+39id0+SZ9cUu5qS6cg5G7YIIx8zT4lDOpAsKdlLO++Yq8/wS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4413
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <E4FCA15CEFD6204D871257E2BF79410B@namprd15.prod.outlook.com>
X-Proofpoint-GUID: Tgux5oxMIty5p1xXL6hj_jhbZ8Y-neaQ
X-Proofpoint-ORIG-GUID: Tgux5oxMIty5p1xXL6hj_jhbZ8Y-neaQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_02,2024-08-13_02,2024-05-17_01

On 15/08/2024 10:35, Maciek Machnikowski wrote:
> >=20
>=20
>=20
> On 15/08/2024 02:41, Jakub Kicinski wrote:
>> On Tue, 13 Aug 2024 12:55:59 +0000 Maciek Machnikowski wrote:
>>> This patch series implements handling of timex esterror field
>>> by ptp devices.
>>>
>>> Esterror field can be used to return or set the estimated error
>>> of the clock. This is useful for devices containing a hardware
>>> clock that is controlled and synchronized internally (such as
>>> a time card) or when the synchronization is pushed to the embedded
>>> CPU of a DPU.
>>>
>>> Current implementation of ADJ_ESTERROR can enable pushing
>>> current offset of the clock calculated by a userspace app
>>> to the device, which can act upon this information by enabling
>>> or disabling time-related functions when certain boundaries
>>> are not met (eg. packet launchtime)
>>
>> Please do CC people who are working on the VM / PTP / vdso thing,
>> and time people like tglx. And an implementation for a real device
>> would be nice to establish attention.
>=20
> Noted - will CC in future releases.
>=20
> AWS planned the implementation in ENA driver - will work with David on
> making it part of the patchset once we "upgrade" from an RFC - but
> wanted to discuss the approach first.

I can implement the interface for OCP TimeCard too, I think we have HW
information about it already.

