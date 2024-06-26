Return-Path: <netdev+bounces-106956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C96C91842E
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 16:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66F6C1C230F2
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 14:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCB2186E55;
	Wed, 26 Jun 2024 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=SILICOMLTD.onmicrosoft.com header.i=@SILICOMLTD.onmicrosoft.com header.b="LgY0Ttxm"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2099.outbound.protection.outlook.com [40.107.21.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CD31B950
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412206; cv=fail; b=Utd3zq0O90vRJeUriq9RdDTb0hqPRkJUv9wjlJ8d8ORKrTAXRHjPQc6JvcK+EH+OgG9SILdDEgUIjyuqtLCZhfzarWAfL8T9QJutA5Ldbv44t0eujF0j3iBtZ32zbX3MtT1pJ/e4IY6hkCfhGNQK57GbMt4np4vzMmYAEaJzS6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412206; c=relaxed/simple;
	bh=OmuKUl3dbE8kyh+Ff3KGO6SbW3JGOfcvgENqZEYAf14=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gZNXqnaT4SJJVEfl54/EJTx1VMA+BSSCo9TOJkfq9kkvN5vOVdfERZBVhINZ8zcSTlfVl0uIGox7bMc2e8eqHkmrbpMDc0Ka1jxe+Pw3qV1srTjr6r7FFKzYzlal8HiNgPIgUKKvU9WqRQsbS8EkxqHVCjSpWtq0OTL9ArMfELE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=silicom-usa.com; spf=pass smtp.mailfrom=silicom-usa.com; dkim=pass (1024-bit key) header.d=SILICOMLTD.onmicrosoft.com header.i=@SILICOMLTD.onmicrosoft.com header.b=LgY0Ttxm; arc=fail smtp.client-ip=40.107.21.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=silicom-usa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silicom-usa.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNFWsZ1HsmhvybsE2/kVXZDOOZJ5sA8HeVawwOQRbrOOqHWYOS3T2Gpu4z9/KCcbsRXha3wJrKIUxZ55reFghFspaIcTyAWcE0ta/gt0VubjPv0P+Pcpd2lMnv0AICN2ZGgs99HuXDQ2No6ZPtzd+CJjCFhFu3nC3OVfRU75eDvQblSw47EePBR4yydISZH6a4zqIJYML61xNHyuFM2AQHkdZu15Z523GG4ZlKwAELQz2tV71T/kwJ5kOSTnmoHRNwPvAonwNk/L+UeNJ+7dVcXhbguJUmc64Jw3VoZ3+aEedoJ36SAXgYK+HBbPlL1m59LxYYRcb3UpPaq6ie7oHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmuKUl3dbE8kyh+Ff3KGO6SbW3JGOfcvgENqZEYAf14=;
 b=m42vrp5HNuH/X2J0v9JMDFk2QUKKC9Vgx9Fh+FfbIY+BG9TtrwZuQLXqIt9gaKjbUTHtFuOak/XlW5xFR4zlAD6dxX6vyNLoUqrfz4XryWT8vEJwcUWvtNnStLgqsSzBDN7O6Na4qdX2IQa+PQ7SuCd1CEvVCJXoh+IUfoizsal4aBBpjDlaFsCKXr9MbM1IYKQ1ctGYPW+4k1NEjCpVYwG6KwuuPnp2DOf2KpqBEAlKY3+6KZlgib5F2uiVGEe8r8ckyJUyAGYLzjD6D6SCb3LQ7Fnm8aLjp+oAiSvhXfDwZMj/8RN6sYZpChRIvwK5jar2LtNRZOXPooUivpPwDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom-usa.com; dmarc=pass action=none
 header.from=silicom-usa.com; dkim=pass header.d=silicom-usa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmuKUl3dbE8kyh+Ff3KGO6SbW3JGOfcvgENqZEYAf14=;
 b=LgY0TtxmNwqLjkTxFEsW2jhSuW+IvpGQwwWaoVLAjTCxdDcrJb1KzCC+7tXVWfR1sHMKas3ehYoveXU7ZOTpKaeir2CmDOUBdRRU9fKlBjCH9jZhrehPh8JeI3VaZWIUyjoLdjdszqAPC3kQ0eKYM3q8CzqGLinRgXzaCQ6W2Y4=
Received: from VI1PR04MB5501.eurprd04.prod.outlook.com (2603:10a6:803:d3::11)
 by DB9PR04MB9476.eurprd04.prod.outlook.com (2603:10a6:10:366::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 14:30:00 +0000
Received: from VI1PR04MB5501.eurprd04.prod.outlook.com
 ([fe80::610a:d9da:7bd3:b918]) by VI1PR04MB5501.eurprd04.prod.outlook.com
 ([fe80::610a:d9da:7bd3:b918%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 14:30:00 +0000
From: Jeff Daly <jeffd@silicom-usa.com>
To: Jacob Keller <jacob.e.keller@intel.com>, "kernel.org-fo5k2w@ycharbi.fr"
	<kernel.org-fo5k2w@ycharbi.fr>, Simon Horman <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net] Revert "ixgbe: Manual AN-37 for troublesome link
 partners for X550 SFI"
Thread-Topic: [PATCH net] Revert "ixgbe: Manual AN-37 for troublesome link
 partners for X550 SFI"
Thread-Index:
 AQHaqxTYUzZ49rg8C060RnZ0M3bByrGh5VyAgAABhHCAAAcCAIAAQSsAgALTooCANVCEcA==
Date: Wed, 26 Jun 2024 14:30:00 +0000
Message-ID:
 <VI1PR04MB550168D3245C3D5B9F311359EAD62@VI1PR04MB5501.eurprd04.prod.outlook.com>
References:
 <AM0PR04MB5490DFFC58A60FA38A994C5AEAEA2@AM0PR04MB5490.eurprd04.prod.outlook.com>
 <20240520-net-2024-05-20-revert-silicom-switch-workaround-v1-1-50f80f261c94@intel.com>
 <20240521164143.GC839490@kernel.org>
 <1e350a3a8de1a24c5fdd4f8df508f55df7b6ac86@ycharbi.fr>
 <c6519af5-8252-4fdb-86c2-c77cf99c292c@intel.com>
 <655f9036-1adb-4578-ab75-68d8b6429825@intel.com>
In-Reply-To: <655f9036-1adb-4578-ab75-68d8b6429825@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silicom-usa.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB5501:EE_|DB9PR04MB9476:EE_
x-ms-office365-filtering-correlation-id: b0d2d27e-a11f-4e0b-2798-08dc95ec75dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|366014|1800799022|376012|38070700016;
x-microsoft-antispam-message-info:
 =?utf-8?B?OGFMMXgwZTI0aEV4Y2xBRmx4eUJhUnpySFRjbGNqSTcvankrL04vT283ZjQr?=
 =?utf-8?B?eVFtRHoxUmtPejNUZUR2K2dERkFwWTZ3WFpVYU5rYkRtSWtneEdMVnlXczBp?=
 =?utf-8?B?VU42VjVwbG1DYXUrSEc0QXpPT1lTaSt2ZWpwZnIwTzBjM3IvQVhwaFBZMlZQ?=
 =?utf-8?B?ai9xMGZMSXN3M1ovbGZSWlorRDFRellMYTY5MzNZUk1kT1J1Q0piZ0MwMHhz?=
 =?utf-8?B?UnR6S0JwWmFWZm5LajJoY0UzV3ZUZ0VHTFluQ25sbEVJaitLWlpWZFlYZnll?=
 =?utf-8?B?Q3M3akowdnFTS0VuZ2grVXhEYm9oT3crRVV4eGxZVXNwWitUYmFKb01kdGxU?=
 =?utf-8?B?YUs2L201cGN2RTJZSjdaT09hajNMNjZLWTdPd2tCYmFKU2xmSVVYSkJ3aXBv?=
 =?utf-8?B?c1VQOTNIUHNDMG5qT2N5TlJBRjRLSDRzajBEMFVoSk5OV1pTZXZ3ZzN4azlz?=
 =?utf-8?B?KzliWThRNndGaVZKazFhRzNuQ1dnZEdZb0JnV2c5a2lOU0thYlljQ1pBZmpX?=
 =?utf-8?B?MzZyRjNmaStLTTEwWUpHTUQ1eHp6dklYd0R1Z0RoYlFHVnVDeGY5V3hGV3F4?=
 =?utf-8?B?elRwSDlRZzhvSDZmREkvREVFbzVLOTN1ZVo1OEFIcHgwRGJLZ2FvWDA5Qmd2?=
 =?utf-8?B?T011R0tPcjFaWjBHMUVPbFNGWmYwYjNNb1kxa2hvQ05TNmJCcHl1ODZZZmN1?=
 =?utf-8?B?b2JVclE4V1lJTkNyTmNCa3p5T1Z0TitVZWNNRmlTUE8wYmJxRTM5SjJzQmNL?=
 =?utf-8?B?YnBYbTV5dXJyQnY0L0JPYmhoekFVdStVSDl0c0plYy90Y1NoT1BpR1BHMDZ2?=
 =?utf-8?B?c0xEYmVjVkJJcm1UMzgxRGpOMlkycGtOZWRLZDlNempyTTdXeUxtVmZ3NGNW?=
 =?utf-8?B?bVBWdnN0WE9NbjRpMHY5ZFN2TWEzR1JPTy9MR1dZL0E4YUlaSDVwRFhNOGpz?=
 =?utf-8?B?QW8xS1htNG1TVXVyT01PMWxtKzF5b3ZJNjRiaU9rYkhCODBYZktsdG41cEUv?=
 =?utf-8?B?amxtY0FrUGZWR2JtTThEQkxxZ0RxTWdTbkV0NzZiVmZiSm5VU1htWUNoc0xD?=
 =?utf-8?B?bWk0azV2RzgxUkFmZ1MyaTI2d0lRb1VyckZuSlJMbElsMUtucEJVWFM3TGNY?=
 =?utf-8?B?WU53b3RNc3RCUm5JN3M3bHFBYUhmRlZpdzRrei8zMzVvdExXcGdCaWFDVFkv?=
 =?utf-8?B?blhqZUE0cEtIWjNIcWZzSVNBSGJ0V3dnR2duVE12SVlqOXpmTXoxS2xZYzJY?=
 =?utf-8?B?NXBweVBBUUhhajdqUkJ1elUwdXE2am4wWHpIMFRIWlR0T2VKd2E2MEFXRnJG?=
 =?utf-8?B?Q1FlUTFiNkhhNVJtdVVpb3VTZVc3Z1RjSkRWQnROZEdFeXRTZVh6RXhRa3do?=
 =?utf-8?B?SG96dXlmL3NiaDdkYS9oOTdQcWZzalFGeHhSRThIVXplV1FHVkIyUG82RDNL?=
 =?utf-8?B?SVNtOWdxWDBTaUFlOFk0dk5lRGdLeFA4UkQvblJPaTJRRUVZMXE5ZFk3Q3Ny?=
 =?utf-8?B?c3B4Z0htL285VzZXMHkwdVFzbUMrU2RUVVNwcHU3d2IybWNIdnFxODJLMkc2?=
 =?utf-8?B?aXNFMjNpRmlnbFVVK1VsNVpWRHRPUlhSR1hkMUVHSyt0eVFSOE5GNXR5Rkkx?=
 =?utf-8?B?SFhJa0RMZmtMeTZuc0U3c2dlcVVZdS90ang5cDhnWkluU2ZkcUhFTC9RbExV?=
 =?utf-8?B?VUpFa0VxeEVSZ09pcldJT0lwQXE0NjVORWJiUU4ydWl1bXVjMTU3R0FVSmN2?=
 =?utf-8?B?QnJYdkZqUWxnWWNwZDQ0UTdFM1hkR25JanpadXVyU0E4UnlEY2RSMXR3dnBR?=
 =?utf-8?Q?5LLS5R4O9A+N1CBPSGEEJtowmF4xTyRp4moQk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5501.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(1800799022)(376012)(38070700016);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MXNvd0JNUUdtTWxyUHEvMmM3VzFHNlJpOEhWWHNaeGhTTHV2cVpoRlcyM1Jt?=
 =?utf-8?B?K3VwdllISjZXMHJPeFp6WTFHTkMzZ1pVS0hYVVdQRzdLbjNaeDhLUEllc2dt?=
 =?utf-8?B?K0JKbXhQTU5lMG41UjYvaWNIZjJzTis3dC9MYXJtaUZRbzJqMkFGOUh3L1Np?=
 =?utf-8?B?bjJreWRRdHJuVVlaOUNmdDV6OU1IUjNOQUd4Wit6eEo1VVl6MS9UdWc2Q2lC?=
 =?utf-8?B?aFlTR0d2T1JqRzJwMngvMytZd0s3NkYwUjZ1ckVoSXd0OEVzVy8rbEZLaG9E?=
 =?utf-8?B?WFpubE1yaTJOMWxVNTUzUWFQR0M3OGpoeU5XdmVCbEh4MGlMeHpGM0pYcmQw?=
 =?utf-8?B?SURsQUFYek1BcG9tMXhKTE9DS3FpYW9ZUEkxalhHVTV1UmgyR2tLOGliU0lq?=
 =?utf-8?B?NHFiUm55MDNuUThXd09iMWlmQmhSZnBEd2JobzUxUFpTZHE0WHExQjNjdy9B?=
 =?utf-8?B?cG9RNnF1NHZHdVFUMmVnL2NUcnlYWUx2cGlMbzI5SGp5NUtaM1NSY2dXdmNO?=
 =?utf-8?B?aUN3Nnp5d0hNWER6R3BwN1dmSlI0UVhIN1ZPQS9pMjljWDlJZWJWZXQydjJr?=
 =?utf-8?B?cFdWTTQ2OFh6b3RiZ2xpbDlDdXRvZmgzaHVjbzZneDlWS1dIWk1wRUtOcjNs?=
 =?utf-8?B?MGVtaDJxdXVqdk00VWFRam92VkxoNHVWb0Y5bzZYM2gzL2RWNk9JZFpsM095?=
 =?utf-8?B?VGMyK0MyMG9EYWpmQVpiRE8wWHdSdEV1RHorNUpHYUhxS3VGNER4R2pKUDZv?=
 =?utf-8?B?citJWjdKUjJCbGFUOXE3Q0RyRGhQLzZDUlFmZkxhNWtaTW1vMnFTR2lmQXFC?=
 =?utf-8?B?ZFUvckllcE84N1NCWUFHRGw3VDNFT2NLRU1PK2xCK1dWVzdtQzFsMDB1bU1M?=
 =?utf-8?B?YUdlcnU5MXpzL0RXSlh1azduU0tBU1RRZnptODB6Z01UTDBJRzFxaWI2TnZp?=
 =?utf-8?B?SW9pY0NoQWE4aWNmU3lGL3liMjY5SERpd0xZVDRpN25zNjIvL3NBaElpc0xy?=
 =?utf-8?B?eHRaa2pGNHAzN1ZXeFh2cHM2TFNRalVNc1M1eWFXVnpmMTc0dTRoUExQb3Na?=
 =?utf-8?B?M0c0L0tuS21wM1NQSExLcnRxRXNQUlVFV2E1cjZTUE5TYmxXMzM5WG5Pc3h1?=
 =?utf-8?B?RHo0V0hhVWhldEpja0lWWkdLN0c2b0NaeDIrU0Nxc1AzWlg5ZkVSelpNRlFU?=
 =?utf-8?B?VStaM1VWU0lNaEFaa0I3YndVL2F3SkhPNVdOTUpXbGVyeWNNdlZPSEVoNE1Y?=
 =?utf-8?B?cUtOM1lxdmpwUENSZHNBWGVlRElLa2E0Wjk3d3BaVjlkMlNkOExqV1BPSngv?=
 =?utf-8?B?OGREVDl0MUNDZTV6WWw1VjNlRkRFOWJDWkxDbGFubUhEbXN2eUZmTElqR2x0?=
 =?utf-8?B?Qk1lUFdKcStCdFo2cEUxaUNNTFgvL0NnSXJZN04wSzJMMGlLVDB2dndPOVRv?=
 =?utf-8?B?UG5xU1U2TFdaU28wL3RkTFhSbzRwS2lKMHJpNGpOZE11RktCcmdEYW8xbVJr?=
 =?utf-8?B?dEFSOWh5K3RJNHBIdnV5SlpXaThNWkRPdUU3OStvcWVNWkFPUlpaVmsvZFIr?=
 =?utf-8?B?Z21qU3lDLzFrL1UrYnJOV1ZORG9lN1FiQjVhLzlnWDhBNlZIenVhcTZhOTI4?=
 =?utf-8?B?NWFwOU5TZ0FwY1NvYlV5VXpTenNxN25PNnhCMkdsYmJmTi9pU280TE5aRERX?=
 =?utf-8?B?UmdKRGZkaVplVVBwVDJhbFRhek44anBoc0xCUG1IZXVpcVBnK0FnenJ0TUdt?=
 =?utf-8?B?M09WMHBZZGNMdlFZWlc3bkRHa1NXaDk4bHAyclBwZzE3enAyQjdCcUpQcnJW?=
 =?utf-8?B?UXlmRFlEUENMMFdKNWxsUmU1Y1dZMzVOTUw3VjV6c0QzRnR0c1lna2paTTU5?=
 =?utf-8?B?cGkwUU5MRndHTDk1L3VzTTBkQkJpbGw3R043d2tIcUFDSU9DQ3JXaFQyUDNF?=
 =?utf-8?B?bjczQ1lYVzZYd2w3YkVmT1hXdlc1ZXo5VGVPcTFPVDE4UUJQVC9VQTFMTVZm?=
 =?utf-8?B?K3lwYUVZM2RpSVhDd09MaTEvMSsybjRMN25HeVpBSTJIN0ZnNDZWcm4zZG5Y?=
 =?utf-8?B?RjN0TmsrdUM4U0lLaUM3dWduVHdpZEVPS1Ftb2pLb3BsalNzditkVUlDSHd3?=
 =?utf-8?Q?nNMTvE1yHCyG2+oE4vx15H9/C?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: silicom-usa.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5501.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d2d27e-a11f-4e0b-2798-08dc95ec75dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 14:30:00.1799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d72D2btpp6wx18RwyHFvSONfnYMOicYtqB+CrtZbPeCzkMGADZifFS9TVgQkRE5Q8RWTIBrxxr/iwTuoAL8tbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9476

TG9va2luZyBmb3IgYSBzb2x1dGlvbiB0aGF0IHdvdWxkIHNhdGlzZnkgZXZlcnlvbmUuLi4uDQoN
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFjb2IgS2VsbGVyIDxqYWNv
Yi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBNYXkgMjMsIDIwMjQgMTI6
MTUgUE0NCj4gVG86IGtlcm5lbC5vcmctZm81azJ3QHljaGFyYmkuZnI7IEplZmYgRGFseSA8amVm
ZmRAc2lsaWNvbS11c2EuY29tPjsgU2ltb24NCj4gSG9ybWFuIDxob3Jtc0BrZXJuZWwub3JnPg0K
PiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldF0g
UmV2ZXJ0ICJpeGdiZTogTWFudWFsIEFOLTM3IGZvciB0cm91Ymxlc29tZSBsaW5rDQo+IHBhcnRu
ZXJzIGZvciBYNTUwIFNGSSINCj4gDQo+IENhdXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1h
aWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBsaW5rcyBvcg0KPiBvcGVuaW5nIGF0
dGFjaG1lbnRzLg0KPiANCj4gDQo+IE9uIDUvMjEvMjAyNCAyOjA1IFBNLCBKYWNvYiBLZWxsZXIg
d3JvdGU6DQo+ID4NCj4gPg0KPiA+IE9uIDUvMjEvMjAyNCAxMDoxMiBBTSwga2VybmVsLm9yZy1m
bzVrMndAeWNoYXJiaS5mciB3cm90ZToNCj4gPj4gSWYgYW55IG9mIHlvdSBoYXZlIHRoZSBza2ls
bHMgdG8gZGV2ZWxvcCBhIHBhdGNoIHRoYXQgdHJpZXMgdG8gc2F0aXNmeSBldmVyeW9uZSwNCj4g
cGxlYXNlIGtub3cgdGhhdCBJJ20gYWx3YXlzIGF2YWlsYWJsZSBmb3IgdGVzdGluZyBvbiBteSBo
YXJkd2FyZS4gSWYgSmVmZiBhbHNvDQo+IGhhcyB0aGUgcG9zc2liaWxpdGllcywgaXQncyBub3Qg
aW1wb3NzaWJsZSB0aGF0IHdlIGNvdWxkIGNvbWUgdG8gYSBjb25zZW5zdXMuIEFsbA0KPiB3ZSdk
IGhhdmUgdG8gZG8gd291bGQgYmUgdG8gdGVzdCB0aGUgYmVoYXZpb3Igb2Ygb3VyIGVxdWlwbWVu
dCBpbiB0aGUNCj4gcHJvYmxlbWF0aWMgc2l0dWF0aW9uLg0KPiA+Pg0KPiA+DQo+ID4gSSB3b3Vs
ZCBsb3ZlIGEgc29sdXRpb24gd2hpY2ggZml4ZXMgYm90aCBjYXNlcy4gSSBkb24ndCBjdXJyZW50
bHkgaGF2ZQ0KPiA+IGFueSBpZGVhIHdoYXQgaXQgd291bGQgYmUuDQo+ID4NCj4gDQo+IEl0IGxv
b2tzIGxpa2UgbmV0ZGV2IHB1bGxlZCB0aGUgcmV2ZXJ0LiBHaXZlbiB0aGUgbGFjayBvZiBhIGZ1
bGwgdW5kZXJzdGFuZGluZyBvZiB0aGUNCj4gb3JpZ2luYWwgZml4IHBvc3RlZCBmcm9tIEplZmYs
IEkgdGhpbmsgdGhpcyBpcyB0aGUgcmlnaHQgZGVjaXNpb24uDQo+IA0KPiA+PiBJc24ndCB0aGVy
ZSBzb21lb25lIGF0IEludGVsIHdobyBjYW4gY29udHJpYnV0ZSB0aGVpciBleHBlcnRpc2Ugb24g
dGhlDQo+IHVuZGVybHlpbmcgdGVjaG5pY2FsIHJlYXNvbnMgZm9yIHRoZSBwcm9ibGVtIChvYnZp
b3VzbHkgbGV2ZWwgMSBPU0kpIGluIG9yZGVyIHRvDQo+IGd1aWRlIHVzIHRvd2FyZHMgYSBzdGF0
ZS1vZi10aGUtYXJ0IHNvbHV0aW9uPw0KPiA+Pg0KPiANCj4gSSBkaWQgY3JlYXRlIGFuIGludGVy
bmFsIHRpY2tldCBoZXJlIHRvIHRyYWNrIGFuZCB0cnkgdG8gZ2V0IGEgcmVwcm9kdWN0aW9uIHNv
IHRoYXQNCj4gc29tZSBvZiBvdXIgbGluayBleHBlcnRzIGNhbiBkaWFnbm9zZSB0aGUgaXNzdWUg
YmVpbmcgc2Vlbi4NCj4gDQo+IEkgaG9wZSB0byBoYXZlIG5ld3MgSSBjYW4gcmVwb3J0IG9uIHRo
aXMgc29vbi4NCj4gDQo+ID4gSSBndWVzcyB0aGVyZSBpcyB0aGUgb3B0aW9uIG9mIHNvbWUgc29y
dCBvZiB0b2dnbGUgdmlhDQo+ID4gZXRodG9vbC9vdGhlcndpc2UgdG8gYWxsb3cgc2VsZWN0aW9u
Li4uIEJ1dCB1c2VycyBtaWdodCB0cnkgdG8gZW5hYmxlDQo+ID4gdGhpcyB3aGVuIGxpbmsgaXMg
ZmF1bHR5IGFuZCBlbmQgdXAgaGl0dGluZyB0aGUgY2FzZSB3aGVyZSBvbmNlIHdlIHRyeQ0KPiA+
IHRoZSBBTi0zNywgdGhlIHJlbW90ZSBzd2l0Y2ggcmVmdXNlcyB0byB0cnkgYWdhaW4gdW50aWwg
YSBjeWNsZS4NCj4gPg0KPiANCj4gR2l2ZW4gdGhhdCB3ZSBoYXZlIHR3byBjYXNlcyB3aGVyZSBv
dXIgY3VycmVudCB1bmRlcnN0YW5kaW5nIGlzIGEgbmVlZCBmb3INCj4gbXV0dWFsbHkgZXhjbHVz
aXZlIGJlaGF2aW9yLCB3ZSAoSW50ZWwpIHdvdWxkIGJlIG9wZW4gdG8gc29tZSBzb3J0IG9mIGNv
bmZpZw0KPiBvcHRpb24sIGZsYWcsIG9yIG90aGVyd2lzZSB0b2dnbGUgdG8gZW5hYmxlIHRoZSBT
aWxpY29tIGZvbGtzIHdpdGhvdXQgYnJlYWtpbmcNCj4gZXZlcnl0aGluZyBlbHNlLiBJIGRvbid0
IGtub3cgd2hhdCB0aGUgYWNjZXB0YW5jZSBmb3Igc3VjaCBhbiBpZGVhIGlzIHdpdGggdGhlDQo+
IHJlc3Qgb2YgdGhlIGNvbW11bml0eS4NCj4gDQoNCk9yaWdpbmFsbHksIHRoaXMgd2FzIHRoZSBp
ZGVhIHRoYXQgd2FzIHB1dCBmb3J3YXJkLCBhbmQgaWYgSSByZWNhbGwgaXQgd2FzIHF1YXNoZWQg
YnkgdGhlIG1haW50YWluZXJzIGR1ZSB0byB0aGUgbWF0dXJpdHkgb2YgdGhlIGRyaXZlci4gIEkg
d2FzIHRvbGQgdGhhdCBpbnRyb2R1Y2luZyBuZXcgY29uZmlnIG9wdGlvbnMgd2VyZSBhIG5vLWdv
LiAgSWYgdGhlcmUncyBhIHBvc3NpYmlsaXR5IG9mIHJld29ya2luZyB0aGUgcGF0Y2ggdG8gaW50
cm9kdWNlIGEgbmV3IGNvbmZpZyBvcHRpb24gZHVyaW5nIG1vZHVsZSBsb2FkaW5nIHRoYXQgd291
bGQgYmUgc3BlY2lmaWMgdG8gb3VyIGZpeCwgSSdtIHN1cmUgd2UgY2FuIGNvbWUgdXAgd2l0aCBz
b21ldGhpbmcgYXBwcm9wcmlhdGUuLi4uICBJIGp1c3QgZG9uJ3Qgd2FudCB0byB0cnkgdG8gcHVz
aCBzb21ldGhpbmcgdGhhdCB3aWxsIG5ldmVyIGdldCBhY2NlcHRlZCwgYnV0IEkgdGhpbmsgaW4g
dGhpcyBjYXNlIGl0J3Mgc29tZXRoaW5nIHRoYXQgY291bGQgYmUgd2FycmFudGVkLg0KSSB1bmRl
cnN0YW5kIHRoZSBkZXNpcmUgdG8gbm90IGhhdmUgc3BlY2lhbCB3b3JrYXJvdW5kIGNvZGUgZm9y
IGEgc2luZ3VsYXIgY2FzZSwgYnV0IGluIHRoaXMgaW5zdGFuY2UgSSB0aGluayBpdCdzIHRoZSBv
bmx5IG9wdGlvbi4NCg0KPiBJIGhvcGUgdGhhdCBpbnRlcm5hbCByZXByb2R1Y3Rpb24gdGFzayBh
Ym92ZSBtYXkgbGVhZCB0byBhIGJldHRlciB1bmRlcnN0YW5kaW5nDQo+IGFuZCBwb3NzaWJseSBh
IGZpeCB0aGF0IGNhbiByZXNvbHZlIGJvdGggY2FzZXMuDQo=

