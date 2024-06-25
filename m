Return-Path: <netdev+bounces-106346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A6A915E9E
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 08:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87DBDB222C4
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 06:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F975145B2F;
	Tue, 25 Jun 2024 06:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VpsAQzFI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9676B1B806;
	Tue, 25 Jun 2024 06:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719295779; cv=fail; b=Rde7HhRkHjzxe+oSgfDV/dpOVXWS3xY7T4w3uvnusYFHYjV7DWes/rFu/SnlJcOAt6GLHEjC337any0j95lgyRI+WgkI58QgTRaLNCNGnvFyZbuhmR9Ax2MV88gUNJWDRlHm8QKxa15pzqtV0ScSxJWpQcXPqnlGkqoJ0bVpygY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719295779; c=relaxed/simple;
	bh=OWIbPAT4N6oYro0IYduK8QcI//lkbELQDYEWhlBFqWI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uu9bxjmIYYLnsgjTCJa8DVYlBcpGf+yi3dIw0KxQJrdbtMdCmxtvjqnBk5SKVZoiC2/O0BeGvUrdqp9Mh9AtFXOR8jtCOMkraYHZ+OkiUKDUEw1x0dG76BJ59KaMUZtwmwe2QZXS3A2JzBXjShv+S3628umCzuZoDPh/pBGCp1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VpsAQzFI; arc=fail smtp.client-ip=40.107.93.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMZEGuyYRYJ1UFpKRdE2NEVYQ1qzPIdeJxGYnnfRFWZ+iy3ncnnDTBRu/GVVqkFjRogQlWzaiUlHFDGRfNCrOItKVOIpqfgb4y+fi61+J/gCxcI3PMxPxRxmNBfBOHZwzvrTT92dfNSHQt4Ahs38JoDokeb1kXeOBMrvVZbMZ4b1QkiEZetj6YglYRffc2Xahi7Gn/VQuXUrdoZti2SM1bM3GEXYRXIUqo1JR75WJYFHAcI2M8otBFlVr81/bcfeIPN1YCi6Ecjlt8Wxo5PEyAdGuFmBQd9wk2O/HuLa64gWCiJRtNqBMTD6QjGGl2FvHGgZapbtX9KHZd0prSVLUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWIbPAT4N6oYro0IYduK8QcI//lkbELQDYEWhlBFqWI=;
 b=c1op/lAVS8dGxND9M8IcKDCzgMi8yocNsu9t7wNxJHBHD6QuKYgGbZ2bjgNPBJqYUL1TMCFxfc6EFFKiczEfj2izdDKFsUoSdUoakXSHnSzr3cUN6wdPdiCHEsvC9HAcFZvkhpkG12wDtm4ld6VL4BNawiHAzl1a+bqw3cXfOgM2n46jJJZusX8aiBBbKoc1e1QtKmw2tgfgxn7qNwfs6R97azk9A1vvGOV/0hWqI7ofFuRzN5qyFXJX052CD/DI5T9GCXII0vVUv/MH0blToV8IOIqc5oT8gPZYsSLY1SCSR7fmmuud7Bqx7fAaHaLFJnecoKZBX7hZnE0vHCzgMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWIbPAT4N6oYro0IYduK8QcI//lkbELQDYEWhlBFqWI=;
 b=VpsAQzFI+3jL3qTJb+OVKetji06bi0mB0nN24wF9zqrsqVHabo65LvZqTevD5KSwcnGNtVrIsYbbvaWnIgkfdGNvHZlI9XKMoQl4VsYDgKVOBpjTfXS2JVBTfqbBYA198auWdpM1oqi+B1UeLDs5JOcpl9vrc6GTHQkPDxvLPoT4CszZiN7ZBRmRLavLCkHPaIptF8muLAKJk/iQ3iNOXUt/6dnEZ3ClSOtCTXmNrSOWrIljY7p56qF9+VAQNzezjDUajHReEHRLg6fjuCPQs2E2REiomRGVQDwraDUriQCPo0phpzn7yLu3IWUQ6PrzXAZqfU1PAf3SZOJL9UlyWg==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by LV8PR12MB9084.namprd12.prod.outlook.com (2603:10b6:408:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Tue, 25 Jun
 2024 06:09:34 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 06:09:33 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "sdf@google.com" <sdf@google.com>,
	"kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"ahmed.zaki@intel.com" <ahmed.zaki@intel.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "shayagr@amazon.com" <shayagr@amazon.com>,
	"paul.greenwalt@intel.com" <paul.greenwalt@intel.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, mlxsw
	<mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>
Subject: RE: [PATCH net-next v7 8/9] ethtool: cmis_fw_update: add a layer for
 supporting firmware update using CDB
Thread-Topic: [PATCH net-next v7 8/9] ethtool: cmis_fw_update: add a layer for
 supporting firmware update using CDB
Thread-Index: AQHaxl9tZjEsViE6RUmSigLaeSJ6XLHXVKiAgACq97A=
Date: Tue, 25 Jun 2024 06:09:33 +0000
Message-ID:
 <DM6PR12MB4516D2B079A4AD6C410FD241D8D52@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240624175201.130522-1-danieller@nvidia.com>
 <20240624175201.130522-9-danieller@nvidia.com>
 <34a8b5b8-75ac-45b4-85d4-6b38aadf880c@lunn.ch>
In-Reply-To: <34a8b5b8-75ac-45b4-85d4-6b38aadf880c@lunn.ch>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|LV8PR12MB9084:EE_
x-ms-office365-filtering-correlation-id: fc9ef31a-b8fc-4b8f-fe45-08dc94dd6262
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|7416011|1800799021|376011|366013|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?UlR1M0hRVm11WHA0TUc3OXV4NDhJaERzNzR3K1NBcGdLSi9QQjB1QlNZVFBp?=
 =?utf-8?B?RmJwUGRFT1JyYXZyck1mcnFibUFwSDllZWNjV2JOVG5Ddlo3NTBEaVo4ank3?=
 =?utf-8?B?K3RjUlVVRVBWNG8rQjV2YWxPVjl4RFdNeVQxOEdmQ3had05SdmVvb0JKdU40?=
 =?utf-8?B?ZEVMSEFnVTg4QnBXZElSRDl2ZUZubUc2bmV3anlNc00rdG9hUmEyZEZZeEhF?=
 =?utf-8?B?d2o4QXlpalUrS0ZCVW1NTVNzK1N3eXZrTmZBcjVQTWlmZXdXc1lvOFpxcm9H?=
 =?utf-8?B?OGFPdEVCUjFIZEl6MGtORHo2Qk5qd1k1ZU5RUkRRS01FejlNUnYwVVRWcUxY?=
 =?utf-8?B?YndpSU54VlJzaFkvTjVRY09NV28rRk5BVnh1WlBURFFOY3dGK3FEay8wMkFr?=
 =?utf-8?B?REdOSnF1dlM1V1JSSG8xMEI4Q0V0STRHK05WUGxBaHhtSTRrSnJ1c1NEN05P?=
 =?utf-8?B?cUQ1ZkhMbFpVSitsWG0xREp5ZlV5QkExS3hFbGpEazBNcTNCazExSlBubTJS?=
 =?utf-8?B?WUJwc1NMU2NweEQyTTB0ZGppNC9qSEU2aE9Zcy9EYkRKUXpTMDBzWTI0RGlH?=
 =?utf-8?B?enR2TzE4UHkrOWxONTdqeHo3cmo0RWtFc2N1WnM4bTdValpBRVM2dlNXczB1?=
 =?utf-8?B?QTBia0NYOGtPR2E1N3RBaFgrVmxQcXV6cStvMldXT2lSNjUvdFdMRlhaQW9w?=
 =?utf-8?B?ckw5RUxEb1dkT1NEcytNaWY3cWIzdml3VmNDSDFDQncxRkxGTWJQUHNqOHBF?=
 =?utf-8?B?UktUaVdoY2lmNnlaQ1R4QnVKNy9xL0thTHpJVXJNSjVEOStXeFRXSGxPL2Z6?=
 =?utf-8?B?ekpEV2Q3blg1a1lSWk43YmVxVklyMUhFdDQwOVJxcFZhcTY2N1g4b1IyZncv?=
 =?utf-8?B?aHN2VkdSQWVpN1JZR0RkR3J4NkVUNTdpT1BvNU1vc0VYRGdIMkNnTmZhWjU4?=
 =?utf-8?B?S3JaS0ZYTjQ3dS9MN01kd2ZtaE8yTGo0VzdJNnVjVjJYT3lsT25hMTE3WEFp?=
 =?utf-8?B?bnNsS3JpZGNuanMzV1pPVkxkZFJvcDZGZWV5bExPa2p6QVhpRXNaNnhZc01n?=
 =?utf-8?B?cDZ4NE41NnlRQnhlZ1FtZDF5TmdGcG9hVnE2b2NEZitVQ1VxVFJDZnVMN0Yw?=
 =?utf-8?B?TzUrSUEreVUra1ljZisxd3dEaG9Ib2s1b0VyL3FBcTlnbmhvUVY0ZHg1a2tk?=
 =?utf-8?B?azExYVlWRUhZQTZTQlFyMUtFM1JPWFlSc2JmelQ3eDF5TDJKL2JEcFpOSGRE?=
 =?utf-8?B?U0pvWnVKRWlRNjM0WTZOWDFWczdBNkZPZTFwNDhIbVN1WFRacmRxQ0NXRUth?=
 =?utf-8?B?Y25LMGpvdkV2ZkhFbTAyalVXZ05OR3pNcTIxbnhHWnc5V0xTaWd0MXdsZi8z?=
 =?utf-8?B?STRLUG5DN3l5QUlwdmJkd3pXWHRteGlRa2dVOGlFUXRWQTNqOFdoZTlUOVNi?=
 =?utf-8?B?dVhHbzdzRU14eXUxUXNDVHR5clBPUGtGZXUwUHNkbHU3WVVCaVltZ2dRaVM3?=
 =?utf-8?B?RlBmU2JMQkg2SDVDM3lpWWYydHUvZ0pkekNqcXpjeXdadXNBWmhCVTJaU0Q0?=
 =?utf-8?B?ZjNnbUZLUUx4R09INVRDM2NlelFTS1haK3ZLYTdPajY0VEpXdUVmTHMvRXpG?=
 =?utf-8?B?T3hTSkxXdFAwL3pRRm81L0pEU1NFK1BKT1lLa0NUdS9lT3JaYU9wcG40STZa?=
 =?utf-8?B?bWV3V2hYMGZnWi9vbm8vN2VTZnBBMTBIZTJDNWJNZStkYlF5TXEycHpWSFdO?=
 =?utf-8?B?MkZONnlwQ2RidDZkcGdabTZmOTdzdHVHd0J4SHNFdWh5eVRYclB3RVkvRnZx?=
 =?utf-8?Q?2zxbL/Yk7jPPV/EJgzguzwEiq5cz8K6lA6QXs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(1800799021)(376011)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MjJWbU1tTHRUclplaEJGQzVSSFdiZEtPK0xKQm9SSlpKRGh6anRFUFNHSmtY?=
 =?utf-8?B?UFc0d2JJSUZ3cVQ1bTR4Ny95dU5waWNUaXAzbkdINm1EbU1QdmRJSTdDdVVr?=
 =?utf-8?B?S2NZMDFsYWF3Qk0wdGFOeld5Q0xhN2k2dXEyRmk1bHBDWmlBcCtPZGNOMDkz?=
 =?utf-8?B?UXpmcnZIREZaSGtGMU5wT1dSMno0SGlUVFdGNE45TUtXMnErU05SWERHUlJN?=
 =?utf-8?B?YlFiZ1pOVXR1SlVnQnpDQmdjRkp1a3lqMmM1RkVSdEo2NlViUUJET2Uva21V?=
 =?utf-8?B?ZEZWRzI0MGxkVXY1cG1xWnQwOHpFUnRpSEtPanhsa1RMMkpWME9UYnFaMFRu?=
 =?utf-8?B?MllCUlEweEZndjU5WG9Sby9xc1A2R0I1ODFhSG1LQ3AzOFdzNXdCajkwb2g1?=
 =?utf-8?B?UG4xTlU4TjhxbXU1Rmt3OHVES0k4UC9mSnRQVzdMZHRydGFBckpEdDd0OHBt?=
 =?utf-8?B?TGRQbGNSY1BUMC9qNWJNbjBBWmE0TitveFlwcE5LcFFIVmFXMlhVRWVnb2c3?=
 =?utf-8?B?NGd4T25VUGpjZy9VdzMzOWVyRHZJT2RpUm9BaE9LZVdnTk8zaVZocHc0TVlD?=
 =?utf-8?B?bC8xYUhUZjRkTnIwbDZ3b2ozL09zUzB1TThLVmVtK1RmVEdIVDZQRUZMTVR6?=
 =?utf-8?B?anpOaDhWYnlRUlFWQ2RrcG9hOHFQd0lJZEQ0L2pLRlJZTHBGMFFQbGlEN0Z5?=
 =?utf-8?B?MTZFZUVqeWVZUTdUYXJ5czhEWEZDRHo1WHc2dlJjeld3OU9VdjdtWDhJVWIy?=
 =?utf-8?B?eGZLaTRnSmFKYWtpLzgxT3JvM3AySWdGTVVYTkxEaWw0RXVIbnlVWFdnQUhV?=
 =?utf-8?B?djZlNTgweGU2U2liYnlvdjFWcTNYMDVwMGpqTDVCd2hwa2FRaWlnUXFYSUV0?=
 =?utf-8?B?TGVLcWQyTmJ4blJGK2FpQTBXSzZZSG1uUDVVR1YySVhrcUFhL2FtQjZsUFRN?=
 =?utf-8?B?UXRZZmhmWlFaWGcyM2FtVzM2UGphWWlxYUhRMnNFZUVUWGEzcnZIZzQ1cDVm?=
 =?utf-8?B?SC90cklNazNDMHpWUzJMN3BtZlVnZ1RpajA0YlZTYUg5YWgwSnFmVjlYYXF2?=
 =?utf-8?B?M1lSWk13ZUlZeU1lMXc4S1V4eUMxMlFHaGx3YUlHYmhONlc0U0lsbGd5Q2Nm?=
 =?utf-8?B?djFvRHo0RUZqWVZHSTVhNVRrWFVITUY0Tk51d3g3T1VHK1RHOXh5QXpacG56?=
 =?utf-8?B?T2VhVkJQRllYOGd6VUR1bjJweEZnVjZJaEF6VWhTanc1RERlMzJEL1dtOUZn?=
 =?utf-8?B?QUUxbGVsZTFpbTlTUy8xdTg4OTRMd0hZa3ZnYzM1b0VpTVo5dWRHTStaTmZG?=
 =?utf-8?B?T3pIKytmN3N6R0Z1MFVhdC8vNmxZSnZzMGtlYjZKeklNUUdpSHZUMkVwREVX?=
 =?utf-8?B?RTNUbW1MV2pYR0Y4U1RzMloyZXF0ZWlCN2ViM2RZeUdRQkNSQWswSC84VVk0?=
 =?utf-8?B?M0tQemY5WGFGYWNBb0ZvOUsva2pQVk9KU3VhVXZBWUxxQitqTlNTblFQL05x?=
 =?utf-8?B?cHcxME1NUExDeUdLU0x0b3I1bkJoTUQ0ZGR2aW5SSk5aUXVXWmd4cnYzNEY3?=
 =?utf-8?B?STQzdUNaQ0dhM1d2dHZDYTMxVU4xanlGQTJWaFBBU3RjaS8rSy9PZCswU216?=
 =?utf-8?B?Z1dzM213dVl0eFpnOG85RERRb296U0IrWGc2MkR1SE81cFRVcmVOS24wTUky?=
 =?utf-8?B?WXVLVlp1SVhZMVJlczF4ejVWazZjbXNLTGNtMUVHM1NURmZiOVFkNHpYaFE2?=
 =?utf-8?B?MW1YM1IvRXh3a0R4M1dBdHpSa2lZMjVyWWlyVExlNjc2ZHplWkE5ais0SHZM?=
 =?utf-8?B?bzNPdUhWU0o0OWFveXdrOGFVYS9HZVE1YzVUTW9Ia01EbEp2dEV5WnBHaFYv?=
 =?utf-8?B?bTNQL1JzaDdJU0lqU1hRLzlLNE1oYllGdnltMk95d1E1SStrSzJpMWZjZ0RJ?=
 =?utf-8?B?ZHBuTWs2M2pnNk5aMzhWdDdtVzVYSUFtK0JpdC9sQmw1NkRLK3pUM3pUVm9l?=
 =?utf-8?B?dGUwTEU4QTNmeTl4UlBIdVVsVmNVbUJsQS9GbEczemY0b3NVdTBtMmdQc0Np?=
 =?utf-8?B?aklLc1dGR2RqRW10NnEwcUgvTDYxVHJNTWc1YlN5N1cwNGZuMWVoN2NxelJY?=
 =?utf-8?Q?dAyfPfbXHjgqVynyP4mxmSchN?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9ef31a-b8fc-4b8f-fe45-08dc94dd6262
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 06:09:33.8847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RwSh68VYkCI1kufpWveXj0Ybduf2/SjXyIcRkX93PEmR9npFyK9aWjy4y5/RwwhKmy9SZIypWVACmnCnlOq97w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9084

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IEx1bm4gPGFu
ZHJld0BsdW5uLmNoPg0KPiBTZW50OiBNb25kYXksIDI0IEp1bmUgMjAyNCAyMjo1Nw0KPiBUbzog
RGFuaWVsbGUgUmF0c29uIDxkYW5pZWxsZXJAbnZpZGlhLmNvbT4NCj4gQ2M6IG5ldGRldkB2Z2Vy
Lmtlcm5lbC5vcmc7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207DQo+
IGt1YmFAa2VybmVsLm9yZzsgcGFiZW5pQHJlZGhhdC5jb207IGNvcmJldEBsd24ubmV0Ow0KPiBs
aW51eEBhcm1saW51eC5vcmcudWs7IHNkZkBnb29nbGUuY29tOyBrb3J5Lm1haW5jZW50QGJvb3Rs
aW4uY29tOw0KPiBtYXhpbWUuY2hldmFsbGllckBib290bGluLmNvbTsgdmxhZGltaXIub2x0ZWFu
QG54cC5jb207DQo+IHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb207IGFobWVkLnpha2lAaW50
ZWwuY29tOw0KPiByaWNoYXJkY29jaHJhbkBnbWFpbC5jb207IHNoYXlhZ3JAYW1hem9uLmNvbTsN
Cj4gcGF1bC5ncmVlbndhbHRAaW50ZWwuY29tOyBqaXJpQHJlc251bGxpLnVzOyBsaW51eC1kb2NA
dmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbWx4c3cg
PG1seHN3QG52aWRpYS5jb20+OyBJZG8gU2NoaW1tZWwNCj4gPGlkb3NjaEBudmlkaWEuY29tPjsg
UGV0ciBNYWNoYXRhIDxwZXRybUBudmlkaWEuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5l
dC1uZXh0IHY3IDgvOV0gZXRodG9vbDogY21pc19md191cGRhdGU6IGFkZCBhIGxheWVyIGZvcg0K
PiBzdXBwb3J0aW5nIGZpcm13YXJlIHVwZGF0ZSB1c2luZyBDREINCj4gDQo+ID4gK3N0YXRpYyBp
bnQgY21pc19md191cGRhdGVfcmVzZXQoc3RydWN0IG5ldF9kZXZpY2UgKmRldikgew0KPiA+ICsJ
X191MzIgcmVzZXRfZGF0YSA9IEVUSF9SRVNFVF9QSFk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIGRl
di0+ZXRodG9vbF9vcHMtPnJlc2V0KGRldiwgJnJlc2V0X2RhdGEpOw0KPiANCj4gSXMgdGhlcmUg
YSB0ZXN0IHNvbWV3aGVyZSB0aGF0IHRoaXMgb3AgaXMgYWN0dWFsbHkgaW1wbGVtZW50ZWQ/DQo+
IA0KPiBNYXliZSB0aGUgbmV4dCBwYXRjaC4NCg0KWWVzLCBpbmRlZWQuDQoNCj4gDQo+ICAgICAg
IEFuZHJldw0K

