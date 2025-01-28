Return-Path: <netdev+bounces-161331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1AEA20B38
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 14:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9EB93A0759
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 13:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742C71A264A;
	Tue, 28 Jan 2025 13:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RGR2qPb8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D0818DF86
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 13:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738070340; cv=fail; b=UO1j+XJtPaNTT6+DyVDdf0Gj2jUrdLihbuiT9o5Tm1Sof3UE/L9uXzc2IkjCo4CVpCmiPC7X+eaNd9lQxdfDGr+Gp5zX11aZ+CkUWWwFQIJqI2qrM+2iB5NhzGTuLDQAKQPmzdZi8hJxxK9iQJL3pRpwgocYWyExyLcsmXG9l5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738070340; c=relaxed/simple;
	bh=cFP/qqjBTKQ3f792B+5Wd4F2Y863vsTdjKlRzPXd95U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SUhuFAPBHAU4KJCrzQU+dZBrMaDE3ViHD2CtT7njgT6XXybdgdwo5oA2Hx/HqLdeKUhYjWvob1MlDT2cyDJ7mY6OP3vhWD6gzb1dodzEA2fTWrKMbzlmIBlCf0yKS5jujOVYCTmDeAaFWtHDlU8tM6EruyZvFEJcrz8nY70x3Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RGR2qPb8; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyiIGBfEtmrAk8Ea6sBDlabjAYO/Py3ft8cHzDpkQfWOr+6f69ATvBZWobVBg7piiB8fxQqZlHqWCX0nDk51mhL98m86IibQy0nLK+Do854xdCmPyiZgFnf+mLSk4euUPDUnYLpfdpmt7udCQrdh90LW1xzWjU6RZ+6lcx4cxp8jrlIXJK8TBdIUORz6ZIzlsXSvItG71aAz12LatRGmQVmpkzRYtWq6HmsBnz0rvnPTEIxnleICAvDNwT/1DVPvGAZkUPvnCt3RrHPH4VesbQMdGlt+zIiA3sgrRMBh2DnAXsEl674h8z8w/UuqSZ8j/H8GZE9+g/HmJUql13Q1cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFP/qqjBTKQ3f792B+5Wd4F2Y863vsTdjKlRzPXd95U=;
 b=nphEVJUy7MDTiTr8h4Fvimw2ai7pOAdoY1MptT8xQRy/wQJW0Mz58T480TijEnzNZu+KyMJR5YLH+05sB+sZd5fUx3BA4+gA0hjU/h0zI8YQZvgI8eOcxG/yWqtj+Pc3utqtJ7NUrjB9lw7pYyh/ctFkHqZ10A0UnAn8YORksR9dXWWMTPoMt8jnqXxpNCdhUd2XglT/2p03eRKpMRtRBTfgKlyG3iseI1R5I+sbGpIHkp1qmDqwARlHo7qPqMeXisfwpHQDvDmL6LhfeppzjtLzINZl3616eBTj97O+30lMGIpuxOnKlD8CIVDdPgOFjNS0W1uaAEbMqsa3e2hVqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFP/qqjBTKQ3f792B+5Wd4F2Y863vsTdjKlRzPXd95U=;
 b=RGR2qPb8vb5avK2O+Pz5BmRnocGyECbGPBWAd4pxpG4smIcHTrj2Ya4yecAFjmwuA5nO5c4NjYHwxObpuC682x6LWLUB+jeCiIsY2Zdfmj0pvHFJDZXAQzVlOcEuQdiX64vwYg9CBro05pK4nHBMQHeBLNmBiA49+hw5zgaudnGD6WbahzdT+GsQAhP5EMwM+HgSiESxKYoe9nBZuoPBAp71ZJqfhm1y2r4ZcZbilkkzbx+ZJfFBxV9WbThd/6tEz0gBjTcZb/nRrMs3oHyXcJmrcAMpEgBczPEln3SZufcyUUH3FX4aShk7blbnMC2cGQJ0C8NV8wEIpaq1ZskNwg==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by PH7PR12MB5735.namprd12.prod.outlook.com (2603:10b6:510:1e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 13:18:54 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%4]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 13:18:54 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mkubecek@suse.cz"
	<mkubecek@suse.cz>, "matt@traverse.com.au" <matt@traverse.com.au>,
	"daniel.zahka@gmail.com" <daniel.zahka@gmail.com>, Amit Cohen
	<amcohen@nvidia.com>, NBU-mlxsw <NBU-mlxsw@exchange.nvidia.com>
Subject: RE: [PATCH ethtool-next 08/14] cmis: Enable JSON output support in
 CMIS modules
Thread-Topic: [PATCH ethtool-next 08/14] cmis: Enable JSON output support in
 CMIS modules
Thread-Index: AQHbb+l4mmigAbpb8kyWjZyRHuAtqrMrD+QAgAEebmA=
Date: Tue, 28 Jan 2025 13:18:54 +0000
Message-ID:
 <DM6PR12MB45169E557CE078AB5C7CB116D8EF2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20250126115635.801935-1-danieller@nvidia.com>
	<20250126115635.801935-9-danieller@nvidia.com>
 <20250127121258.63f79e53@kernel.org>
In-Reply-To: <20250127121258.63f79e53@kernel.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|PH7PR12MB5735:EE_
x-ms-office365-filtering-correlation-id: 8a51f64f-4efa-488f-0d04-08dd3f9e5056
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dCtGM0JnY1RVSCtEMXVISDJ5TTR0OEc0bk5ZQXZYcmNjbmFOeEhiTzlXSkFv?=
 =?utf-8?B?SGh3eG9CQi9KZDNETkEzZW12Y2sxekZWT3Z4MzB2eGdoS01PbHgrRysvbTlS?=
 =?utf-8?B?UC8zMGRHdmN2QllVV3JSWGQrNmtQdlhkUEJMVWhqN0ZYT0Uzc1dld1R5RmRp?=
 =?utf-8?B?RmxnZDVFdXVBVzVLUkRTVjdTbWtSMmpBa0VTa3BnSHVwd0lMbWxSTU9pWXIy?=
 =?utf-8?B?L0N1eXhtYzZSaWRKWDNJbGZEbkJxUTFYLzQvamxFaVhSY1lMdTdpdkc5eTVi?=
 =?utf-8?B?OEFnMEFyaE82MUxIZU5BTng0b1JZUXdHL1JlWU9jbDRPSkxrcmcvWVpvREpu?=
 =?utf-8?B?K1dpZ1psajZSdXdTL0xqazV4a1FqOE5YUjFlK2VIdm1CZmd4Q1k0dUVzY1pZ?=
 =?utf-8?B?dHYvYmw2MmhzU3V3UzhOWk1NTHBMTS9aUktmd3k4UTJxaUpVNVBoNDlSa3dM?=
 =?utf-8?B?RXVrOEdFZ2JBZEdaRnNpc1k4NnlySERNYXhGZGlZaXNmM1BnRzZFWStkeFda?=
 =?utf-8?B?TU1kZjRDV1FLNkYvcURLRVNvcm1kVHI0L3FzQUwzb1pEWUFGVFk1TkltL1FH?=
 =?utf-8?B?SkQ5WTkySlFocWtyaDNvbWlpN0EzdFVPY1NSenMzOCtNcUlZL1NScytFc1l0?=
 =?utf-8?B?U2dLZ0xRRjZESTJXMVFuL0p2Q2hHOXdoWk5KVWN0NnJoQ0NIdVVlK3BvZ2Nm?=
 =?utf-8?B?bWxzTFZkd2dVVFFiM3JVZmlHR3Q2RnRwendlSUZ0cDVhUk1IWDVYVjdQMGs2?=
 =?utf-8?B?WkI3ZGJVK2pRYm9lSU1yM2owd3FGSTYwTWtnNWxISW5vYi9XcHlUUlRPb0Vh?=
 =?utf-8?B?aUZadjhVOVZ4ZitJeGFhM0pjQUQvSGZ3MTBoeko2aXY0aWY0UkVSRXZyMnM1?=
 =?utf-8?B?c3hjaE5ZQVhhSmJ3VVVzSFVCZXh1UG1SQlRtNnMvZEFQR3lDNjR2dzl6a2lt?=
 =?utf-8?B?T1pQb2ZoVmwyUlFtZm1Kc1duRm0ydkZ4RjhIR0dkREVyc1hJVFJGdDUyYjV4?=
 =?utf-8?B?MGJMRSsxdXRFOXJNZUN5Q0VsVmx5ZE4rb2tVenFGU0JZQ0drbGtmQ2VERnA4?=
 =?utf-8?B?V011WWZVQTdVc0oxekxjMXFDcnRMbk1hRGdyQVU3NDNTbk1GVklKb3o3VmFH?=
 =?utf-8?B?UDJveDVnTWkwdkY3ZmtmdGlKcTVuR05JTExjTTNoNkMrRk1pWmh2UEtQektz?=
 =?utf-8?B?a3FvUmxqV0NrSFhiNEcyWUFZb0JwT1RKSVcwaVJHRkZDeVcvdEN5Wk9QNDMy?=
 =?utf-8?B?SGxDZWc4RXRGQ21IMzFtTUc1SEd4SXhabzluajlneUpMd3E3V0tOZytYZ2hT?=
 =?utf-8?B?Y2tMU1BjcDFjaFc4T002OVRmNkxTQzR2R2NkcHhYSWFPbHhOYmJGR1ZFT0tG?=
 =?utf-8?B?NmNmQkFvaHVWaGlPOXZSdnRROWVDalNSTk5mNGQ4aW5DOEp5VWJiYXZqbHor?=
 =?utf-8?B?Rlg2RmQ3YmFiempQSmJBT1llSWR2ZDdpamRRWUxpOUhYRVRRc0k1KzNuOE5i?=
 =?utf-8?B?S0FtRkdrRG5SUnUybFdJMDF3eG1raUE5MXlnZHovcVVvQnEzc29vQnZuYlBX?=
 =?utf-8?B?bWFrcXhWZmdhRitHcjJjZmpxOGRtSmdqRUZGZ3pOSEJWcXoyQTJldXhBZTVI?=
 =?utf-8?B?WlVXc1RJNUxSUHp0aThXTE9zamxvN1RSVHpkNXJxN0I0bVlmTmVGMnZ5b0x1?=
 =?utf-8?B?MVd0SUkrenJvb0g3S0U5bzhPc3JyWjZ3VUNaYytGVjBPOXFXM2lweDlxbW5W?=
 =?utf-8?B?N2JGa0dDZG9aMitTOXlyUXNlK3FVWDllWHowUVhrbVJVNCtHTzdCWmZpS3NU?=
 =?utf-8?B?TGpRU3RLZGF0Sm1UWUp0YzFYK3ZTdUJRbUp0NnIrTHprNWJsVlVYRWUwd0c5?=
 =?utf-8?B?MnpibGhLbkNPeXFXV1VVanUxOEpHd0V5RTV1c1kzLytUeEJ0emIrc1c4Ti8w?=
 =?utf-8?Q?Th8ejU+sFW2tuPsqBSBUzLgD/0yUOLoj?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K3lxbDEzL3hKQTdXb2wybmFSc0U0NjIraDUvZENIZUd5Z0daMGd4eDdQdHNK?=
 =?utf-8?B?WDM3bkdUM3lzekx1MTRnR3NGdGs2WmhIOXhZQ2ViR3QwUy9xOFM4bDNLM1Vl?=
 =?utf-8?B?M1l6Yyt4cnV6VXM2QS8xSXdIRCs3dzIybkw5a2tsbTFSWFc3UEphTk04QVdx?=
 =?utf-8?B?RkFsaGo0NDdxSkx6RTFNKy92K0pTT0tyUExleWx1aTFMZi9hcmIvU09WbUl5?=
 =?utf-8?B?ekl6cHJoT0dHZkhBOU9UUmNuTDF6SmlUYTVYRnlGTVlkdWlvcE5IZnNXN2VZ?=
 =?utf-8?B?bXhFeEF4eUxBeGYwU1ZGSmVWVUdtYVNtaEF6bXdKS3lQT0xaazd1N1ZwNWFX?=
 =?utf-8?B?RFk0azJOb0RyWUIybXE2K2tRUFE2Lytac1J2VHJFVXhVYWY5aktmdUdac2tj?=
 =?utf-8?B?NSszTGFXT2swcCtGd2NwQU5XYjlXNU0vTTVXckR6SitOOWhDYnBKemJ5aXVC?=
 =?utf-8?B?NUxheWY1OWN2YXFPRVhCMTg0TmZwMEQ0RmZvNkpHKzdSd3N1Mml0VlhDOXBH?=
 =?utf-8?B?SzhCRWFJU3prWmF3TFZkRUN0RXE0eFN2T3dsb0VVenhOSzZVNFZzTnlqd0Nj?=
 =?utf-8?B?YW1OUFJHZ0xmZENNMVVsVnRhbjhrWWRpbmFrSVBMRklMMkRWMlRNQjdndlF3?=
 =?utf-8?B?a1FTYkhJUnBsa21MVDAvMityQ3hHOEN6RkxINkdCL3ZmaWJoc2Z2K3dGWGJm?=
 =?utf-8?B?VVhTNFZ6NHYxOXFFYUNmaVhvenhaZEwxQVZBNU9mZk9XTkR6dXczckVXdjNn?=
 =?utf-8?B?Y2FzRHJ3T2s5NWlkZTk0MFlwNHpPTm93Sm9Od1JDVy9CNmVjVkxxbmpBRlYy?=
 =?utf-8?B?THdzR0ZjQnZ2dmVMek9rYThFWTg1OThSMUhPSkNMMEZmZ3ZCRWJVV1M4Rnlr?=
 =?utf-8?B?MFhaZ2VqSFlRNkorT1J4K1U1bWlKOEFsdmE2VkpjWCtDL1RocG5UN0ljckZI?=
 =?utf-8?B?V0FIeVBEOVgwWnNDNUllT0VmRkF6cHlETEhwUWxLQ3VWTUlDZ1YvQWQ0RC8w?=
 =?utf-8?B?cWMrMjd3bGIzVWtJdDN3RjVBTThxR0JHeVM3NFdzREhtaVpjc2JUc1J2a2J1?=
 =?utf-8?B?VloydmNiOUsxdVQ5dHdsV3NCRFhUT240ZU53by9pK3d2S3NldEhnN1BlbXcr?=
 =?utf-8?B?RC9Cd3JGcWNWVnlEZmRJMFJNRXlJTGI0WVJNZDZyYU9EeWJGWW85MWhMZlY4?=
 =?utf-8?B?b0llRDRFZWZlMTRjN1lyc1NIaExCR1hEV1duazlrdURra2lMczdodkJSazFL?=
 =?utf-8?B?OENlWkF2YU50d3Jvdk9Yb05FWFhqd3RvYWY0N2NkTFB0eUZXanRBc2pnaDlM?=
 =?utf-8?B?aUFPTjVsQXg5WEZKYkthUjVXMXJua24wWU9xVWQxMUU3VFcrOU9zdzlKalFi?=
 =?utf-8?B?MGZTUWxYZjZUTWtaWm1qeGZWbFh6RjlaYVlmUVFyTjBpVVZGcnNFSnBsWG94?=
 =?utf-8?B?M1hkZDl4YWt0R3VTVEtJQkhXZWhVYmt0TWQxWjAybC9QWEkxNUZ3ajcvUWlN?=
 =?utf-8?B?dzlLMmh0NzVkUGYzVmR0VzBsU0lWL0NkMkxHUlZwNGxjaHQzbnZ6MXNzTk9x?=
 =?utf-8?B?M0lsRXpCK1RNZFlkTk9SVFpjNEcvM0ZPWlNVY2M2RWpnNzdIUlhBdlpHQ052?=
 =?utf-8?B?VC9iZkc0a05UZUYyNmVMeHpDZ2NvMWJ6RTRtOHdiaFcza21hTTBmWXhuNEoy?=
 =?utf-8?B?TSs0SDJuSVZZeFkrRFhFRWZzVVdvaGN4NEdWZmV1dEF4WFhpdWF0a3B3TDc3?=
 =?utf-8?B?alNvdytvQWI5UWMwM1lZSTZXaDNzQ2RFNG5CREluMnJvbVBUMVRYMFg0RGFU?=
 =?utf-8?B?NC9TVkJTNjFPS01UT2lTTnFwVVBKV05jdG8yZDNrUFRGekJURHlyblVuQzdD?=
 =?utf-8?B?ejVPaXYvNUtyN05uTkRrSytnRm9JYmY5REs5L3RqS1RZcHc2VjlRNmpuS2Qy?=
 =?utf-8?B?R1MyUHFLaVhXVEgvaTM2WEpaU2NsTGlmUExpSUQwTktUY3UzZkFZTzFqclg4?=
 =?utf-8?B?amZ2SDVvMWJEeXRPM3dCUUtGOUV3d3FpNGR4c2dnZFh0MmhaalcxM1RDQk5O?=
 =?utf-8?B?UWI4MVRYTFlTdm5qanFZdVgyS2Q0MWEyZEZpUklMUVJwL2t6b0NkYk5QNWUr?=
 =?utf-8?Q?OGByyQMd/ky+Zy0ha+a9i81b3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a51f64f-4efa-488f-0d04-08dd3f9e5056
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2025 13:18:54.1330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PmiDl37GuLRHp7/0wBTaqBtUpvJtPRlw5df6H/keipv/TpX91qBaKal/76D1USdIg+HCIq1ocrOkHnyXCA1EYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5735

PiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXks
IDI3IEphbnVhcnkgMjAyNSAyMjoxMw0KPiBUbzogRGFuaWVsbGUgUmF0c29uIDxkYW5pZWxsZXJA
bnZpZGlhLmNvbT4NCj4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IG1rdWJlY2VrQHN1c2Uu
Y3o7IG1hdHRAdHJhdmVyc2UuY29tLmF1Ow0KPiBkYW5pZWwuemFoa2FAZ21haWwuY29tOyBBbWl0
IENvaGVuIDxhbWNvaGVuQG52aWRpYS5jb20+OyBOQlUtbWx4c3cNCj4gPG5idS1tbHhzd0BleGNo
YW5nZS5udmlkaWEuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIGV0aHRvb2wtbmV4dCAwOC8x
NF0gY21pczogRW5hYmxlIEpTT04gb3V0cHV0IHN1cHBvcnQgaW4NCj4gQ01JUyBtb2R1bGVzDQo+
IA0KPiBPbiBTdW4sIDI2IEphbiAyMDI1IDEzOjU2OjI5ICswMjAwIERhbmllbGxlIFJhdHNvbiB3
cm90ZToNCj4gPiAgICAgICAgInR4X2xvc3Nfb2Zfc2lnbmFsIjogIk5vbmUiLA0KPiA+ICAgICAg
ICAgInJ4X2xvc3Nfb2ZfbG9jayI6ICJOb25lIiwNCj4gPiAgICAgICAgICJ0eF9sb3NzX29mX2xv
Y2siOiAiTm9uZSIsDQo+ID4gICAgICAgICAidHhfZmF1bHQiOiAiTm9uZSIsDQo+IA0KPiBXaHkg
Ik5vbmUiIGluIHRoaXMgY2FzZSByYXRoZXIgdGhhbiB0cnVlL2ZhbHNlL251bGwgPw0KPiANCj4g
PiAgICAgICAgICJtb2R1bGVfc3RhdGUiOiAzLA0KPiA+ICAgICAgICAgIm1vZHVsZV9zdGF0ZV9k
ZXNjcmlwdGlvbiI6ICJNb2R1bGVSZWFkeSIsDQo+ID4gICAgICAgICAibG93X3B3cl9hbGxvd19y
ZXF1ZXN0X2h3IjogZmFsc2UsDQo+ID4gICAgICAgICAibG93X3B3cl9yZXF1ZXN0X3N3IjogZmFs
c2UsDQo+ID4gICAgICAgICAibW9kdWxlX3RlbXBlcmF0dXJlIjogMzYuODIwMywNCj4gPiAgICAg
ICAgICJtb2R1bGVfdGVtcGVyYXR1cmVfdW5pdHMiOiAiZGVncmVlcyBDIiwNCj4gPiAgICAgICAg
ICJtb2R1bGVfdm9sdGFnZSI6IDMuMzM4NSwNCj4gPiAgICAgICAgICJtb2R1bGVfdm9sdGFnZV91
bml0cyI6ICJWIiwNCj4gPiAgICAgICAgICJsYXNlcl90eF9iaWFzX2N1cnJlbnQiOiBbDQo+ID4g
MC4wMDAwLDAuMDAwMCwwLjAwMDAsMC4wMDAwLDAuMDAwMCwwLjAwMDAsMC4wMDAwLDAuMDAwMCBd
LA0KPiA+ICAgICAgICAgImxhc2VyX3R4X2JpYXNfY3VycmVudF91bml0cyI6ICJtQSIsDQo+IA0K
PiBIb3cgZG8geW91IHRoaW5rIGFib3V0IHRoZSB1bml0cz8NCj4gSWYgdGhleSBtYXkgZGlmZmVy
IG1vZHVsZSB0byBtb2R1bGUgLSBzaG91bGQgd2UgYWltIHRvIG5vcm1hbGl6ZSB0aG9zZT8NCg0K
Tm90IHN1cmUgaWYgSSB1bmRlcnN0YW5kIHdoYXQgeW91IG1lYW4uIFdoYXQgZG8geW91IHdpc2gg
dG8gbm9ybWFsaXplIGFuZCBob3c/DQo=

