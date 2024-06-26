Return-Path: <netdev+bounces-107022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287F2918A09
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 19:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1874F1C2283A
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 17:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E432318FDC2;
	Wed, 26 Jun 2024 17:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oZ65p3ix"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF92218EFC7;
	Wed, 26 Jun 2024 17:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719422771; cv=fail; b=gKzIynES9/noELzwHo+AAC4s9UOJDG8S1NVcL5bQ/jT1OmxDIvPlQs8DgK7NctKV5oU9qTx3X7B4/UHeS4tsAhlsVSwi8gOc1CJpIYccQU1SgngsqIvoCFxw9vkX+OY+CVLP4oa4avHRUl0ZS3fMyQzD44nOvwPULBa+I3IuYxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719422771; c=relaxed/simple;
	bh=+h1+TVVsdqydG3blGgp5AUWLu4TMeUf8IY/OpVDn/I8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KagbFowzJi9AH5uLKyCpNj9mK8KetcDLePXf1kn6SFTKI2vG/zkrMxrFsWaBpQUBlJmGkoP1KcQTmuhKnGTSUqL1hOJzJSDLl/C1a7bx/b8X9s4R+0nblT3sl9oVE01kWrGPqJl0dQEG3suxD/SManYoVz3HLROYRaj79fqUsIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oZ65p3ix; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AP2KwABeJ8aDu9qEbjkCPHvuCYM4QcGKMwtJg3SXhL16MJrvXZ1eZY8sRNS+Jz1Yq3bghDARndZsv0RkcR5rmSLbddwbv/R+nXCNLved6YNxzAzTImvy9JrnNhm543z2/uSthPq7F23KYUzsws6590HXTTjNMZrDNBGEWZNKNCnSnGr4/y9un7cw188DIrOmnXCps9l02Ve751Gx4TVZr5XhpLrVJjmy5GiE5jzw1piVdIDbfP690ao9bpSTFVGscvOnGCo5t8P8EYIB2zE2b/kyYFrEf7kW5JlsjTjzrl6OkBZAPTr5Patg9noVt0/OMoyk3gd9sji6W45wTkz63w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+h1+TVVsdqydG3blGgp5AUWLu4TMeUf8IY/OpVDn/I8=;
 b=bFZGqLjpmDpkCFR5x8jrThucILHtzJaTuFkF2QdSSq046FDc8S8ry+RBIt07DGAu6LdfWiWFKdv6fwtPPWwuo125EtY2t64QyHXzCT9X1PQ0Ol/hK08U/TAVrC1ZMaslvbxgCEvFvM7RO9sT9YK5vTbm7Gq4n5wXcFlHe6ZDjs4yOxZHZ4qbIKr++K8p8BB9WIpFxrijtDsQEOPT+MVcLOJOnAA9EWGMu/M3FvtVpkIvAcTSDeB+6JfqNWZZShuV8YHWnkN3wVWUea6ph4m+lVBzkGJRqRPhY5RKtNKZCJdBSBnnIiVaDXevyxinAGgFrMTv7oat+FhODLUPdXS9Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+h1+TVVsdqydG3blGgp5AUWLu4TMeUf8IY/OpVDn/I8=;
 b=oZ65p3ix8goNeYeAbGd7pHojGWYZhDsKqAOCBFYr4afg2bkL/DYqAjqFkvHCvf/AWNV3yHl4Ld7I7gTroLlS74u94WjEZ9dPZnHeYUjIDB2NNOmlxauOdCEWiN9I337jNxjV2g0bdB71rtggYUsfwyRSFitmxLIKlnSi6ALbay6v/ru1eYCzcNmwTlrTyDdEYXYVMe2Hw8BZAyI3rV9KZiAgmpBtIXrZkdze+tQ0cYikDaS6lQ4qDK+xfrV+dffriGvfnDqQQEVlQPv9fL4LwGo9yw9WpBi1QwFmgxTV/13cg5Lpqq2CeFS6o/nJ5IRsHV5vQQ6mYNmVWBG4kdpAjQ==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.33; Wed, 26 Jun
 2024 17:26:06 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%4]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 17:26:06 +0000
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
Subject: RE: [PATCH net-next v7 7/9] ethtool: cmis_cdb: Add a layer for
 supporting CDB commands
Thread-Topic: [PATCH net-next v7 7/9] ethtool: cmis_cdb: Add a layer for
 supporting CDB commands
Thread-Index: AQHaxl9qSClTcs0l902JzHpAxldWxrHXUtgAgADOufCAAc1zQIAAIPQAgAA22tA=
Date: Wed, 26 Jun 2024 17:26:06 +0000
Message-ID:
 <DM6PR12MB4516062B5684DA1F4C5F49FED8D62@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240624175201.130522-1-danieller@nvidia.com>
 <20240624175201.130522-8-danieller@nvidia.com>
 <003ca0dd-ea1c-4721-8c3f-d4a578662057@lunn.ch>
 <DM6PR12MB4516DD74CA5F4D52D5290E26D8D62@DM6PR12MB4516.namprd12.prod.outlook.com>
 <DM6PR12MB4516907EAC007FCB05955F7CD8D62@DM6PR12MB4516.namprd12.prod.outlook.com>
 <baf84bde-79d3-4570-a1df-e6adbe14c823@lunn.ch>
In-Reply-To: <baf84bde-79d3-4570-a1df-e6adbe14c823@lunn.ch>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|SA1PR12MB8641:EE_
x-ms-office365-filtering-correlation-id: 1d474ca0-b6d1-4250-a57a-08dc96050fdb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230038|366014|1800799022|7416012|376012|38070700016;
x-microsoft-antispam-message-info:
 =?utf-8?B?YXZtci9rT25kSHRlNDJhZG1TanJvUGJ5V1JYRFYzMTFZTFU0NnhPNGhTN2Zx?=
 =?utf-8?B?bjBGYjJyVUtGbW84U0ZUdU43VTVoYjRGYUhEejhOWlhLMy8zeHcxNnVDRUxs?=
 =?utf-8?B?K3NHZ0hic3ZicXM2SzZkMFVtdEczN0hEbGVBdFFPd1hqRjdrdlA1Uis4MWR1?=
 =?utf-8?B?dkJTNWIwcmdrdXNabUNiVjJVVVJCWFVrczlpbnRPOGpaaGluODJFQ3hSL3pn?=
 =?utf-8?B?ZUxoMGxIMzZhdGtoWGNPM3VKa3FzTEhlelJiMFMvTDdhcVVKc211NE5vVVpl?=
 =?utf-8?B?cng3R1VkekErU0JlNzNOcERtMUhhL1lSak50YUZCWC9XbHZYU2hRQjF4anNG?=
 =?utf-8?B?clAvWWZKYlFrUU1VMFRtaWxmZFkrN0F4OHVwQWF1Qk5FL1VBTlZjZThTam5r?=
 =?utf-8?B?UFVYVkp1MGsvYUE2K3ZoaDJuWWRFWUpxejlPVXFPRk1SS3JBdE9ZNzVQMi95?=
 =?utf-8?B?RFpvNmY0SVdFUVhLMzJiWGFOTG5WSDRyaUp5UDF2WGdvQmtiM0Q4RXhIZFlJ?=
 =?utf-8?B?bCs3Q20vN0E4c0xobmwyTFRaQ2d6VmdnL1IvRWZUdnpmbjdGSzB1TllyN0sy?=
 =?utf-8?B?eUF4d25EK2tRaFB5MXVlZTJuU3hZdlpNZXNrYnB5ZXkzSkxLSjFUbnZQSklN?=
 =?utf-8?B?cmdlS3FBT1h0ODlYKzdBNGJuQmd3QWhkaUV4TGdRRXp5SEgvOUk2RHVWTjRI?=
 =?utf-8?B?UzRrZk11aUNDSUN2QjhKUXBxS2VtKzAvVWt0OE0rZ25NZkpnTVlNcGZzN1ZX?=
 =?utf-8?B?S1dlNXVvSzB0NnptVS9XdDlsS0tiQy84MVR2VUxWMWJDZHRzcEY5a3BUczND?=
 =?utf-8?B?R3ViNzFaR3FmVnVKRkE2VnpWUFFjU1V2aGVuUnp5Z1F5YjN5UW4wS2Qwdk1D?=
 =?utf-8?B?eU9tdXlKVkJtdE1CcVFaTStCR1dXRXNUVzg5SFBIQkNQY0pjbFFmcG5Zd1JE?=
 =?utf-8?B?bGZzY29MMkNwNVJTSUROUVkrVGc1OE9qNm5FNjFrQkRsbXY4VDhlVkZZRWNB?=
 =?utf-8?B?eitURGhrazZlVHdSdlpBVG1XTjRkUUdsWjZpejNBMmhRMFdBT00yYVcvWjJl?=
 =?utf-8?B?bG8reG4yTEZUVzFOUXdabnUwVHh3VS9HZzQzLzNad1huL3pBZ0pKdUlDTXNF?=
 =?utf-8?B?RzZENUtkTWZ4SXRFclpoKzlZeUtNTDB0OENmU1JKN1RaUkN1K3gzRWhmSlVG?=
 =?utf-8?B?ZDJFWFJuQlFlalNrVzY5dmtsZUFJZEJvT3NVV28zMzdKakt5bWtoL25GQk04?=
 =?utf-8?B?VWtWcDl2MGVKZ0h5ZGZSVStSU2tucE1vVnZPV3hLQmhhR2VRd2RRZzc1MmVF?=
 =?utf-8?B?SnEvOUtpcnNsa3BvcExjSU1zQ29WWEZtU3hvVEs1cXNLVy9OWmwwdURDb3ZK?=
 =?utf-8?B?eTJ5VHc5T2N0MTVWRkRXRFVqWXpSdURIVnE3WFVGRFFHS0pEV0dFRS9EWmFR?=
 =?utf-8?B?L2lhT0lNYmxYK2RibllnY08wMzZhMDVQVDhNQU5kS0NJM3JoakErU2tCMTBL?=
 =?utf-8?B?ODF1QVZaQUs1c0o3Z2hNMUlqalBBU1FTdTVBY0NEeURoTE9nWFRFUHUzSHJQ?=
 =?utf-8?B?TzEveUlYTDNhaTU1UVZrdk1VWFVWTmRBZU9yS0xURGRvMDd0eTh3RE5pRlZZ?=
 =?utf-8?B?RFhPcExNY3FUd0ZPcUtILyt3NjZlWCtONDRSMngrQ1NKZnpPc29sblZBdXox?=
 =?utf-8?B?MlAyUG10TW9ua1hhNmFiTUZuVEM5ZUtiUVp4N1R1LzR4S2pFZ1F2akpZYkU1?=
 =?utf-8?B?RDlVZ2pNYXVjUjNZb3NucGJXaG1VUDhTYXRTbitFK2tkUXFiS1VmbEhWNHJ1?=
 =?utf-8?B?KzRzd1FBVGV3cURYRW1PR0xsS0trQkl6M1NIRUxERnVqaE5DMHF1OXVwUWkz?=
 =?utf-8?B?eUo1WGtJZGEvSWdOOXNwUzl0NE9PMFRWc3phNkVIK092U2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(1800799022)(7416012)(376012)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T1lSMFo5bjFQN2dXSysvejM3b3ZMQnhRZW14dytjSUVaOGRpT2g0YlBkeXhy?=
 =?utf-8?B?TDdocndOdjlLcGZVdzZDVGpZSHlnVVpZTGZhRmFybGtjTkQwUVRwQVRNTFFK?=
 =?utf-8?B?YjFnRDlsSjc0Rk53dDlHRlN4clRPZlFyQVBQV0hOZ01vSTIrTU9ITWdiNkxM?=
 =?utf-8?B?eUR5UVJlb2dsVEdlSEM5cXhuaTVsVVdHd2ZmR0hVbmZ2VVFBclcvMXN1TGFK?=
 =?utf-8?B?ZkVsWmQ5SHdpSTRlNkhGRnF5SXJxRWZyd0dDWk5va1pqWlhGT1h2RlIvQ0hm?=
 =?utf-8?B?aFplL0Z5a0g2UUcyZGdnNE12WkZkR0kweDRqUVdCZytSbEZWMFliM2JGbFBL?=
 =?utf-8?B?M0NzbDJrZU01V25YcjBwY1ZHYWZqdEYwTWdZVUpjb1ptTHgybEtQcmVJa2hO?=
 =?utf-8?B?TVBhVjRod29wRDRyQm44VnVOOWQrajRqcEFzblh3K2dOY1RJem9QSUg4b3Vn?=
 =?utf-8?B?NkxqVlNvUVJuOG5QT3VsY3c1Ulhxb0pUSCs3eGdKc0tERkVQYWlWTzBTYUo5?=
 =?utf-8?B?TTNTR1NST3d3WW1pMXBXZkhZZEpPUnJ2amg2VTdkYlNLend6ZXEzUVdhSmtv?=
 =?utf-8?B?em9ISkZtUUgrbnJTZU1qTWg0cHVWeUNxOHlxVUtSYkw5eXhrdTlKaGp2Z0hW?=
 =?utf-8?B?UGFOTFRQV2ZZTjR2ZmtFNDBDMDBDeWI3R2pmM2w4OUQzbWwxQi81RTFKNEc1?=
 =?utf-8?B?QmxqaGc5NUhCUFhUalM0VmJhQ2w5OEVQTEYwOUJWN3ArajZCWXdhUEV6RGVx?=
 =?utf-8?B?RFZZcUloejhoY3JnbG5CT2tRUC83aXprRGp0bWI1SVAxcVo4d1VFWk1wQnp5?=
 =?utf-8?B?NXkzVFZXd2hzZDVrL1FJbll4SUdySDBlZDVDSW5ZdDJmSHE1cXJGc2VjakFN?=
 =?utf-8?B?dVF4NnMvOEZWRW5iRDE0QjJFS1lxL0ZiQ2dwVVZEQjZ4ek5sMisyTmVaT1li?=
 =?utf-8?B?SWRXVVhsYnZXZGtTUFk5NmRjZG50Q2d2MmxWTVFERW5oa0VvQllmeENrT0xv?=
 =?utf-8?B?MmhXUGdKRDdrMXVrVk8xWE9QSlFiWjdRcCsySmVJc0J4NktFWlZvYVZ0dVJr?=
 =?utf-8?B?QU9CSEFxUGpqQy81ekNzZldYMHNjcG11R1pOYUVSSnhBcHZ2SmhRVEhJMG1M?=
 =?utf-8?B?S1V2TXp4VWdVWGR6czBHVzlvU05mV3E2ODY0eHZxTWx6T1gxNHE5QTl5b2NK?=
 =?utf-8?B?eTBCT3lmTjhNSnUxUHoxRVQ1MTJrNklhZUQyMTdtdXErbWFHZW1vNU9JNlk3?=
 =?utf-8?B?NTFkUE1WMXpUSXpvdC9oUWdjemtYR2VNczZvWVQ4bW1kZG00d1MxQjlaZTgy?=
 =?utf-8?B?T01TZElUd3VYU0FhR1lUb0RsMG5naHJCdm5RSEdLVC93dktTRXRIYVZhTStM?=
 =?utf-8?B?a21GQnlpTm52NzdPK1Q0OGlZYXkwWlBhcDRiZHppdFkxeFF0ZzQ0by9tMHhE?=
 =?utf-8?B?dkRncFBXcndzblh2WjhGZE50ek9wMElNalFiQ3o1cm5RMGdKZUwyc1M0QzVL?=
 =?utf-8?B?OFZGY0d1S21YQndwYjZjejhEcTh6amlsbEQ0SmJ1c1FGYk9raEJvd3BJRldU?=
 =?utf-8?B?RnJTclhLNHRhbnNKd0dud3p4dGhhdStpeTBiMUhzK3lCcFNWdVRiZFV6MUJi?=
 =?utf-8?B?SXhZYkE0Y010eVJjdk1nR0RBdWJMODU4eUxXbDBQWVlPTWxwSjh5dWJBUSth?=
 =?utf-8?B?UGxhQ3Q3QkhmSXM0TjM1UW1OQm9XdG4yR29kcU9waWIyWGIyOXJhdnFyY3Ju?=
 =?utf-8?B?TGpLV3RHcEpHMzVBZVFyNFJqTkVoY1FkUnpSdnFYbnp1c3ZqR1NZS3orMGxX?=
 =?utf-8?B?WFFVdnFCcmR4TlRtazBCclA0RXBGcGZSYUw1WWFuRjhJejczVGpxUjBwR3p1?=
 =?utf-8?B?TUlORk1McGgyS0tYNkYxZklteWlXc1hsRDhVWC9hc3QxSTd5Y1N4YWtweDJJ?=
 =?utf-8?B?d0YvWnlhN2lCMVVHckgyZml2UEQyaksrQU1JdDRGR2JnZklOVTR6Vm9BeVVk?=
 =?utf-8?B?aFRRazRNRUJ0eEc5dHZhWDQyTlVFT3FCSFdzbFdnMUpkS1p3V1N4NUlkUVl6?=
 =?utf-8?B?VnZCU05UUklKRG1VMnl4ZlJYUWNoNHdNUHNGY3N2R1pJTWxodElXN3RaNmwy?=
 =?utf-8?Q?KUUmAIF31dkPedmg9we8rncy8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d474ca0-b6d1-4250-a57a-08dc96050fdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 17:26:06.4601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NLOaigdDBsvX2SAPUNCkoinYfNzMHh/NZGdGOit8e5STXqOWHWzNGc9jsxuyNtyLaVfyv6o+IwhgewWx+3eInw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8641

PiBGcm9tOiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+DQo+IFNlbnQ6IFdlZG5lc2RheSwg
MjYgSnVuZSAyMDI0IDE2OjQwDQo+IFRvOiBEYW5pZWxsZSBSYXRzb24gPGRhbmllbGxlckBudmlk
aWEuY29tPg0KPiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgZGF2ZW1AZGF2ZW1sb2Z0Lm5l
dDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsNCj4ga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0
LmNvbTsgY29yYmV0QGx3bi5uZXQ7DQo+IGxpbnV4QGFybWxpbnV4Lm9yZy51azsgc2RmQGdvb2ds
ZS5jb207IGtvcnkubWFpbmNlbnRAYm9vdGxpbi5jb207DQo+IG1heGltZS5jaGV2YWxsaWVyQGJv
b3RsaW4uY29tOyB2bGFkaW1pci5vbHRlYW5AbnhwLmNvbTsNCj4gcHJ6ZW15c2xhdy5raXRzemVs
QGludGVsLmNvbTsgYWhtZWQuemFraUBpbnRlbC5jb207DQo+IHJpY2hhcmRjb2NocmFuQGdtYWls
LmNvbTsgc2hheWFnckBhbWF6b24uY29tOw0KPiBwYXVsLmdyZWVud2FsdEBpbnRlbC5jb207IGpp
cmlAcmVzbnVsbGkudXM7IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBtbHhzdyA8bWx4c3dAbnZpZGlhLmNvbT47IElkbyBTY2hpbW1l
bA0KPiA8aWRvc2NoQG52aWRpYS5jb20+OyBQZXRyIE1hY2hhdGEgPHBldHJtQG52aWRpYS5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5leHQgdjcgNy85XSBldGh0b29sOiBjbWlzX2Nk
YjogQWRkIGEgbGF5ZXIgZm9yDQo+IHN1cHBvcnRpbmcgQ0RCIGNvbW1hbmRzDQo+IA0KPiA+ID4g
PiA+ICtpbnQgZXRodG9vbF9jbWlzX3dhaXRfZm9yX2NvbmQoc3RydWN0IG5ldF9kZXZpY2UgKmRl
diwgdTggZmxhZ3MsIHU4DQo+IGZsYWcsDQo+ID4gPiA+ID4gKwkJCSAgICAgICB1MTYgbWF4X2R1
cmF0aW9uLCB1MzIgb2Zmc2V0LA0KPiA+ID4gPiA+ICsJCQkgICAgICAgYm9vbCAoKmNvbmRfc3Vj
Y2VzcykodTgpLCBib29sDQo+ICgqY29uZF9mYWlsKSh1OCksDQo+ID4gPiA+ID4gKwkJCSAgICAg
ICB1OCAqc3RhdGUpDQo+ID4gPiA+ID4gK3sNCj4gPiA+ID4gPiArCWNvbnN0IHN0cnVjdCBldGh0
b29sX29wcyAqb3BzID0gZGV2LT5ldGh0b29sX29wczsNCj4gPiA+ID4gPiArCXN0cnVjdCBldGh0
b29sX21vZHVsZV9lZXByb20gcGFnZV9kYXRhID0gezB9Ow0KPiA+ID4gPiA+ICsJc3RydWN0IGNt
aXNfd2FpdF9mb3JfY29uZF9ycGwgcnBsID0ge307DQo+ID4gPiA+ID4gKwlzdHJ1Y3QgbmV0bGlu
a19leHRfYWNrIGV4dGFjayA9IHt9Ow0KPiA+ID4gPiA+ICsJdW5zaWduZWQgbG9uZyBlbmQ7DQo+
ID4gPiA+ID4gKwlpbnQgZXJyOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArCWlmICghKGZsYWdz
ICYgZmxhZykpDQo+ID4gPiA+ID4gKwkJcmV0dXJuIDA7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+
ICsJaWYgKG1heF9kdXJhdGlvbiA9PSAwKQ0KPiA+ID4gPiA+ICsJCW1heF9kdXJhdGlvbiA9IFUx
Nl9NQVg7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsJZW5kID0gamlmZmllcyArIG1zZWNzX3Rv
X2ppZmZpZXMobWF4X2R1cmF0aW9uKTsNCj4gPiA+ID4gPiArCWRvIHsNCj4gPiA+ID4gPiArCQll
dGh0b29sX2NtaXNfcGFnZV9pbml0KCZwYWdlX2RhdGEsIDAsIG9mZnNldCwNCj4gc2l6ZW9mKHJw
bCkpOw0KPiA+ID4gPiA+ICsJCXBhZ2VfZGF0YS5kYXRhID0gKHU4ICopJnJwbDsNCj4gPiA+ID4g
PiArDQo+ID4gPiA+ID4gKwkJZXJyID0gb3BzLT5nZXRfbW9kdWxlX2VlcHJvbV9ieV9wYWdlKGRl
diwNCj4gJnBhZ2VfZGF0YSwNCj4gPiA+ID4gJmV4dGFjayk7DQo+ID4gPiA+ID4gKwkJaWYgKGVy
ciA8IDApIHsNCj4gPiA+ID4gPiArCQkJaWYgKGV4dGFjay5fbXNnKQ0KPiA+ID4gPiA+ICsJCQkJ
bmV0ZGV2X2VycihkZXYsICIlc1xuIiwNCj4gZXh0YWNrLl9tc2cpOw0KPiA+ID4gPiA+ICsJCQlj
b250aW51ZTsNCj4gPiA+ID4NCj4gPiA+ID4gY29udGludWUgaGVyZSBpcyBpbnRlcmVzdGVkLiBT
YXkgeW91IGdldCAtRUlPIGJlY2F1c2UgdGhlIG1vZHVsZQ0KPiA+ID4gPiBoYXMgYmVlbiBlamVj
dGVkLiBJIHdvdWxkIHNheSB0aGF0IGlzIGZhdGFsLiBXb24ndCB0aGlzIHNwYW0gdGhlDQo+ID4g
PiA+IGxvZ3MsIGFzIGZhc3QgYXMgdGhlIEkyQyBidXMgY2FuIGZhaWwsIHdpdGhvdXQgdGhlIDIw
bXMgc2xlZXAsIGZvciA2NTUzNQ0KPiBqaWZmaWVzPw0KPiA+ID4NCj4gPiA+IElmIHRoZSBtb2R1
bGUgaXMgZWplY3RlZCBmcm9tIHNvbWUgcmVhc29uLCBpdCBtaWdodCBzcGFuIHRoZSBsb2dzIEkg
Z3Vlc3MuDQo+IA0KPiBQbGVhc2UgY291bGQgeW91IHRlc3QgaXQuDQo+IA0KPiA2NTUzNSBqaWZm
aWVzIGlzIGkgdGhpbmsgNjU1IHNlY29uZHM/IFRoYXQgaXMgcHJvYmFibHkgdG9vIGxvbmcgdG8g
bG9vcCB3aGVuDQo+IHRoZSBtb2R1bGUgaGFzIGJlZW4gZWplY3RlZC4gTWF5YmUgcmVwbGFjZSBp
dCB3aXRoIEhaPw0KPiANCg0KV2VsbCBhY3R1YWxseSBpdCBpcyA2NTUzNSBtc2VjIHdoaWNoIGlz
IH42NSBzZWMgYW5kIGEgYml0IG92ZXIgMSBtaW51dGUuDQoNClRoZSB0ZXN0IHlvdSBhcmUgYXNr
aW5nIGZvciBpcyBhIGJpdCBjb21wbGljYXRlZCBzaW5jZSBJIGRvbuKAmXQgaGF2ZSBhIG1hY2hp
bmUgcGh5c2ljYWxseSBuZWFyYnksIGRvIHlvdSBmaW5kIGl0IHZlcnkgbXVjaCBpbXBvcnRhbnQ/
DQpJIG1lYW4sIGl0IGlzIG5vdCB2ZXJ5IHJlYXNvbmFibGUgdGhpbmcgdG8gZG8sIGJ1cm5pbmcg
Zncgb24gYSBtb2R1bGUgYW5kIGluIHRoZSBleGFjdCBzYW1lIHRpbWUgZWplY3QgaXQuDQoNCj4g
TWF5YmUgbmV0ZGV2X2VycigpIHNob3VsZCBiZWNvbWUgbmV0ZGV2X2RiZygpPyBBbmQgcGxlYXNl
IGFkZCBhIDIwbXMNCj4gZGVsYXkgYmVmb3JlIHRoZSBjb250aW51ZS4NCj4gDQo+ID4gPiA+ID4g
KwkJfQ0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArCQlpZiAoKCpjb25kX3N1Y2Nlc3MpKHJwbC5z
dGF0ZSkpDQo+ID4gPiA+ID4gKwkJCXJldHVybiAwOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiAr
CQlpZiAoKmNvbmRfZmFpbCAmJiAoKmNvbmRfZmFpbCkocnBsLnN0YXRlKSkNCj4gPiA+ID4gPiAr
CQkJYnJlYWs7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsJCW1zbGVlcCgyMCk7DQo+ID4gPiA+
ID4gKwl9IHdoaWxlICh0aW1lX2JlZm9yZShqaWZmaWVzLCBlbmQpKTsNCj4gPiA+ID4NCj4gPiA+
ID4gUGxlYXNlIGNvdWxkIHlvdSBpbXBsZW1lbnQgdGhpcyB1c2luZyBpb3BvbGwuaC4gVGhpcyBh
cHBlYXJzIHRvDQo+ID4gPiA+IGhhdmUgdGhlIHVzdWFsIHByb2JsZW0uIFNheSBtc2xlZXAoMjAp
IGFjdHVhbGx5IHNsZWVwcyBhIGxvdA0KPiA+ID4gPiBsb25nZXIsIGJlY2F1c2UgdGhlIHN5c3Rl
bSBpcyBidXN5IGRvaW5nIG90aGVyIHRoaW5ncy4NCj4gPiA+ID4gdGltZV9iZWZvcmUoamlmZmll
cywNCj4gPiA+ID4gZW5kKSkgaXMgZmFsc2UsIGJlY2F1c2Ugb2YgdGhlIGxvbmcgZGVsYXksIGJ1
dCBpbiBmYWN0IHRoZQ0KPiA+ID4gPiBvcGVyYXRpb24gaGFzIGNvbXBsZXRlZCB3aXRob3V0IGVy
cm9yLiBZZXQgeW91IHJldHVybiBFQlVTWS4NCj4gPiA+ID4gaW9wb2xsLmggZ2V0cyB0aGlzIGNv
cnJlY3QsIGl0IGRvZXMgb25lIG1vcmUgZXZhbHVhdGlvbiBvZiB0aGUNCj4gPiA+ID4gY29uZGl0
aW9uIGFmdGVyIGV4aXRpbmcgdGhlIGxvb3AgdG8gaGFuZGxlIHRoaXMgaXNzdWUuDQo+ID4gPg0K
PiA+ID4gT0suDQo+ID4NCj4gPiBIaSBBbmRyZXcsDQo+ID4NCj4gPiBUaGVyZWZvcmUsIHVuZm9y
dHVuYXRlbHkgaW4gdGhpcyBjYXNlIEknZCByYXRoZXIgc3RheSB3aXRoIHRoZSBvcmlnaW4gY29k
ZS4NCj4gDQo+IE8uSy4gUGxlYXNlIGV2YWx1YXRlIHRoZSBjb25kaXRpb24gYWdhaW4gYWZ0ZXIg
dGhlIHdoaWxlKCkganVzdCBzbyBFVElNRURPVVQgaXMNCj4gbm90IHJldHVybmVkIGluIGVycm9y
Lg0KDQpOb3Qgc3VyZSBJIHVuZGVyc3Rvb2QuDQpEbyB5b3Ugd2FudCB0byBoYXZlIG9uZSBtb3Jl
IHBvbGxpbmcgaW4gdGhlIGVuZCBvZiB0aGUgbG9vcD8gV2hhdCBjb3VsZCByZXR1cm4gRVRJTUVE
T1VUPw0KDQpUaGFua3MsDQpEYW5pZWxsZQ0KDQo+IA0KPiAJQW5kcmV3DQo=

