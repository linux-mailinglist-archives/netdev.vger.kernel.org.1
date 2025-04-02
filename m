Return-Path: <netdev+bounces-178902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CC1A797CE
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 23:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54828172410
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 21:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593841F4725;
	Wed,  2 Apr 2025 21:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GQCkamtf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F35C1F4C86
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 21:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743630119; cv=fail; b=Tqu310rqgqWhfWA/tBJkfPl24c72thgA2WlWXQRmiBRVX63E6W2GdikSPulhFtSyN8o3vOS44GtsxsYWDC7lNXmXafgCmc75oSygKk+Ff/JkQjqnWoZKIF8iaO2XBVJLJgzJpbcGPCexEgMqZ6/Q5dSyp3Y/ZX68ySa0SzCoCZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743630119; c=relaxed/simple;
	bh=Z8kTc5t+JIcIKplJmig8nYv11PkkAOTQBsrQsI4xoLQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lF3O58WJO00pO4Gj3yx3Db2cD1bD4r02P6uVBDdGgQxIX/9TiuAwrZojYd0GXBNFP0/XJwdHiYhxjiV4OC7oiKwT1UYVK4AJ74/iMlQLUVECHfwphPzG3asIfcWWmowundDTqTYEyoyPHJMtcVyI4QlF7jbbvJeiYHyYcJnxkF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GQCkamtf; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1S0ARWpJL6m9jokP++vEaTl3rxQ+WMWt1uSlcXfEYs30A60odjHvMtEeEDmHxby+chUlrDbgGoPyRpGmh2y2ATULKq6AUk6o6vgXMT+588DGMc1po4H1MciV7+Alo7NcifZ62EJ6MizwAs+wWiiPW5chjHZEQ7qPO+jIZ6jQdfO9lptppEpjXzxMW/lDDbHziSZlY+PHdsAno6E0pUK+jZ+1mgz4dGVnVafPY/PLwD4yjgVT732AlBczgwvNiYQBzFwnDWsomXTrAPfQhZGLvJqExS7U26QUqhQZ7N1OKpSwsYbiV4/G3f1im1PnhH2QwKCBUygsADGK8mBI+NOKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8kTc5t+JIcIKplJmig8nYv11PkkAOTQBsrQsI4xoLQ=;
 b=YQBwCvBQjHbTa8OzjHwuZsMQgthra33jDQhwiyggn4y0nG/qR+VuMXhFgGCDVgU48/lQlrcIz9/9MW2fL2zcXboTmEWsKqz7rlu9JrFkH8QMXV8i8zjRHxN8qjql6qsXHZg7e/AjN7SOWSAz1iv8XZSS5C1/eJlogq5D6Rb/u71cuslKF+IC9yHA6Z/UD0oH0WXTB0gUTESuzLE7k9d7KztAVavqXSSaRC4SbTwm8PaUYkKRsDTm/5fbTSITxubl2s04TAZM3oFpwri3u9GwLFZVzR2M+5mnxtXDSZ9VlY0IoY0rxwopoFCNFxjNFIFSef/T5jSxlgtbS3XtzrRhAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8kTc5t+JIcIKplJmig8nYv11PkkAOTQBsrQsI4xoLQ=;
 b=GQCkamtfug2THCQZbnqnw3CsOluJvwdgqZ9ytPunmwhPccTgkYmlPg9YxjcsKOwYOk/pUpG3F5okRQAj8YjJvcLDWyOaMBJXttiJrINZLzYMH/YjXXc+hfVtd0GHnP4rUBEHt3ylJHRKfhxBLHirtMm1RsvqlQ5zTRiE668WxXp/8GNJBDlsVuwG4aKuC34UOjXyAd5HGaMka8sqTTEOzT1o1RTa85E5b7jwJJ1ZMXT0Z9LiQZLFMk6FMREyYdg6JaIGTNcGBkOX1xrsoQf/QMzqVnlIrgBPMwPHd+AQpAbzD7kAHOgDpIOoLjfeD9jScGXgAO49tJ+PcObNlzk98A==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 CH3PR12MB8934.namprd12.prod.outlook.com (2603:10b6:610:17a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.54; Wed, 2 Apr
 2025 21:41:55 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%2]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 21:41:54 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "sdf@fomichev.me"
	<sdf@fomichev.me>
CC: "edumazet@google.com" <edumazet@google.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: another netdev instance lock bug in ipv6_add_dev
Thread-Topic: another netdev instance lock bug in ipv6_add_dev
Thread-Index: AQHbpBgNsW0Cw2ElFUOEQjFKH76LcQ==
Date: Wed, 2 Apr 2025 21:41:54 +0000
Message-ID: <aac073de8beec3e531c86c101b274d434741c28e.camel@nvidia.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|CH3PR12MB8934:EE_
x-ms-office365-filtering-correlation-id: de51f62d-4aa9-4924-5cdf-08dd722f2fe7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WXM3OUdOcGRnYnpJU2tjdm5TZ1Y0YjRUdjluZGk0ODdranBZUU9TampmMU50?=
 =?utf-8?B?WC9VR3R1NFZYYlloZlMxckRENktBTVIweDFsVlZlUVdGSDVzL0xGalU5NDQv?=
 =?utf-8?B?UnRlbENLZzBNaTRoblpZcnVHZ3NMMit4bkR0ck5vVTN0WmlVeDUraW9hQ292?=
 =?utf-8?B?eFNLclZrY2tIRE0vdlhvanRTMnNiYkpMNWlJZmZMZmZuZWNQbzRha2plTy9o?=
 =?utf-8?B?YlZ2VURFNlZ5L2h2U0RNTktiSnB5SDBsMi9RTlJ2WnIwRkxab0hrdFBCUmJa?=
 =?utf-8?B?M2poYWEwclp5Y08ydTAzR2x2NGRkZkhuSkh5SjNKQUhTdDVzRmRndGxra0o3?=
 =?utf-8?B?T1c4UFlkSVh2TnhrVWV5Wm14L2JCQVc2Wjc5aE1GQ1pwRGZWRDUzQXJVK3kz?=
 =?utf-8?B?OE5JU2xDWmRHeUxHRlBYTjdJa1B1KzBMTFVxWFNlWEdIWlF0S0lnaWMyaHlB?=
 =?utf-8?B?QlZvZE10TkFvdW1kQ3ZOOHZsWlcySm1KY3JLcWFERnFJcjQzd09jMElzMU5F?=
 =?utf-8?B?eUF6ajh5a0g3Q1hlL0lUWThkOVlxU2V1US9yL1Rmcjdnb2lNaktVL24zZ1Zz?=
 =?utf-8?B?NkphZjhoVHJMcTkzOVRGMFRXOStMazVRa2R2TGdVRVN2YkpvR2ljaUV3QTk4?=
 =?utf-8?B?dVJQeUFsQmphaDkrSVBOemdyK2JQa3lVZEtjaTlGQ2Jqb2F4UTlRZDBLNVNm?=
 =?utf-8?B?bVdEN3FEcHVFblJ6cnVoU2JEdnkvTlhpVHpDblZ0dFJiMjFSbGVoVktpTjdH?=
 =?utf-8?B?Qko0S3ZtSkMwbURwK2pkVVJsQURDSTF3TWdUUXltRThkUE9aQjdxUWxCaVBI?=
 =?utf-8?B?NWxiNnZMdmlaV2d1RXd0QTE5Z091aXBvdkk2N2NJTU14cEROc0dCZmUrZmpP?=
 =?utf-8?B?a2hJZzE1emp2VnhrTEVBNjl0M2V5ZWJIZy9LWkNtellScTJsNnRXNEx0Qm5S?=
 =?utf-8?B?RXhWelFQaGFxbS9KWnFTL2Jja1ZoU1M0M1ZMOUxEMkd5a1dRSFE2K09QTTlU?=
 =?utf-8?B?eC9uRTdLampOYnpPVG8waXdwMURHUkdISWZzVHVhKytsNVVkS20xSkM3ak94?=
 =?utf-8?B?d3BQSFRhWWlCVitxMUwvZlBHUVJrZEZGZ1V6N1o5azVYMGhDUlNvUDFkRytz?=
 =?utf-8?B?K3VPbk95UTd2MzRJaHl4VGdmcjczOTZjYU5iK2FHS29VZ2R2cVZoYlhwTmtD?=
 =?utf-8?B?NVBpS1B4NDdZZkdkMllTYXVVSWVvZ25KdTZOWWgwYTB4RTJRRk5PdE55WHB5?=
 =?utf-8?B?N3pOc3E0ZFR1NmdrVVcyWTRTN09UTnh2cGlEZFpLK2swb25uSzlSUThLa0pl?=
 =?utf-8?B?Z0NjT1NvcDloYWsydG9ySmZ3V3RpN1R2S2hJYUFQcDZ5Q3UveHRGT09jREE5?=
 =?utf-8?B?cmRSakR4blFkWHNwNmw1SG83T2RPc0VueW5NQk5VK1k5c29BMmx2ZnpNWUl0?=
 =?utf-8?B?enhHTDlYRXBlK0dQUDg2NmI1Zmt5ZnJTNU53QnlBb2JRODFWdXRlMEtqMERC?=
 =?utf-8?B?STZqSVMyNkJBbHlSNGdiRWNqWTNxNEs3UmNXZ21PQS9jaWhaQVBHSS9ldjlM?=
 =?utf-8?B?WUw0SHhpMExXSEVmL1lHa2RXbElNNGgvL1ZzOGVUT2N6akFZMEFrbzQ0OU94?=
 =?utf-8?B?bmlnNHU1RSsyT2wyMDlxaHpOOTRwWGwrV1Jma0w2RXNNL2lJOTIzclFxemlH?=
 =?utf-8?B?d3BVbjdGNzdsZFo3Yjcvcm1ZOEtzSU95V1lwREt6VlppYWdzblkvYWVmR3Uw?=
 =?utf-8?B?T2pXRGZ3MmZ1WmY0RldQejM3dmQyOXppaXcvQlpWdmNMZi9zcEJNK2l6T0Zz?=
 =?utf-8?B?cERUbFVFKy82WjNVRjJlaVhjTmpRZGVlTmVrUXBxTXQ4NVM0QkRncWd0VE5P?=
 =?utf-8?B?STZtajVlZTl3REI2SDdCUUxsanhkTk5rVEg1NlVsT2F2YW5GY25hN0ZvSi9r?=
 =?utf-8?Q?JVtN4mdanmytDXwZuQAL5c9Aay0um76X?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V2pLbjNZWXc0Z3EydFlzTElNTUt2Z2FvUVU0enFHeTVOMjgrTk9FMDV2WnZD?=
 =?utf-8?B?NC9IY1NlclhZWnI2UENDWnVSekEzZ3lKd0RHTGREQjhrMXUvcW40N091WXVE?=
 =?utf-8?B?QnZCYXYwMllWZFlObDQybVRnQzRsOFRRQXJScWlFeWp4ZmxsV0laeHRxRk5S?=
 =?utf-8?B?WG85WStZZWFIK3U1bWFRN0xLMDVtZGthSnhWWXJ1ZmFXV3dBQk1RSjdtRlRX?=
 =?utf-8?B?V1ZCVW5ZSC94TjRPV25rNVdhaWxidk1OajRCZllhYnZwdFg1Z04weXRmdTBT?=
 =?utf-8?B?c1pEOTltSGNXWGx5MUpmS1RoTktYZC90RkZJVjNna1NKYmk1RjJsZ09rWDRr?=
 =?utf-8?B?b2p6dGtFQmFLUlJ4QkdTRmF0UXBxWFZldWZZL2oxUlkxMjdlZjh2Zi8yUkEz?=
 =?utf-8?B?Q0tnQmZuSnJsMGdJOGQ5Tmdva3pQUmtmK1p1ZzF5bDh4bXB2M29zR2dTRHQ1?=
 =?utf-8?B?Wm9ORW5xL05KNFFtaE9kZTFtbnlNSDJmZldyUkxvWFZqYllXRmJ0bkVsRjRB?=
 =?utf-8?B?SytFdE42YktJbjFOY3lENzR3dFgvNXRrUWI2eWIvbnRrVnplN0ZQNlJNd3Er?=
 =?utf-8?B?ckN1VGQvZW1hamg5cXJENVptdi9NRWplVk9YL3cyMHpBQkpkdEd1YytQajd0?=
 =?utf-8?B?elVGbzZWQVZlM1JXZlNkR083Uzg5eExDVS91Z2FOMFY3Rk1jT0NpdmxlaUF4?=
 =?utf-8?B?K1NzVmpjMnFlakZBM3RoWElTS1hJZElBWTg1TFVHalNXMnZ6Q1dpOHc2L1BG?=
 =?utf-8?B?Q3d6Z3Ira3haQkl0bStUOUpXVGVLaXRaTVZrbGM0TUl0MUFqQzVuUUVkdjhk?=
 =?utf-8?B?cGludUZyUmtsNHpielhHeFVnWW5rMFhOelVKWllqdkRYZU92eFA4bGRZZ0tR?=
 =?utf-8?B?QlBlMk9qVm40SGxGeGRETmczV3ZNTmtKSFRzWVFzUGIwcXhlM1Q4TlBhZkZV?=
 =?utf-8?B?UEM0V3hjblVSYXJIcDZFWWcyYnZ6V0NXb0FBM2prYjJuYTFLSFRGRXF6OFVz?=
 =?utf-8?B?aW9tWVh3eWNQT2xwMXV0ZzNIZnVsN2tpN3N4MlI3Vm1NUy9qMG9sY2FrTmNC?=
 =?utf-8?B?Z2dqamVMYjFxcTYralF0ZndyQTF6MXhMS2xLK1NLdTZkZXBZRGNoQVpTRTJV?=
 =?utf-8?B?T1FtdHpJQWpRTURFdW91R055WVIxZURMaFh4SG0ydjFLYUdrY2VrTWphTzc5?=
 =?utf-8?B?cWhmbFh3bkNHUGk0VHp1MDJ2YUkvcFFkMTU5S1NoN0NoNzdYaVN0WlprRDY4?=
 =?utf-8?B?MkF3ZTlhd29RTnF0anB2OFJlYU81b0tIdU1WTDJjNlVXcDhPeXdlR2NXeDF6?=
 =?utf-8?B?OVh3WnBiMUM0dElXMDkvWFpyTFFoajFGZFp6aGFBTnVES3hyOFdVMkRMTkZ0?=
 =?utf-8?B?ZTdUYmk1djYzcHJ5U3ZiTEdUdVQ2WTYrQ25sOERmaXJ2Z2dTTkhtWUEvbXJB?=
 =?utf-8?B?OHd0eTZFSlJCUmhhUEZiOVZIMjMrbmVVeHh6K0JERXlSOEtYa1dKOWRYNEtM?=
 =?utf-8?B?NDNKdGlOMFdrRjJ0bFFkczNLTGFGRE93SksvOHQ3NFh1WU41TWxMM3VHQWpr?=
 =?utf-8?B?OXJVUXRwVys2Ung3ZmtGbW5EeStGRHpWV2hHY1I2TVBBNGU4U1A2Uzl6ZHFS?=
 =?utf-8?B?SHNsUkk2cDlROEFoR2JydVd4NTVsajE1QldObnhtU2NLNnIrV1Q0R2ZObWIr?=
 =?utf-8?B?SXYxMGZqcG0zYnZoK1FEVm92YktNeFJOVVdaL1R4N2VyUVFyMmFQTkw3SUha?=
 =?utf-8?B?cHNwcDVZQWl2UlRhREZOdDV5WU9CeDF6d0RhZURacklkMDNQa0JVQ1NoeDN6?=
 =?utf-8?B?UEdwRUxaL2h6ODR1THg3UXVVUFp5WVNDZGE1akJ3NnZoa1c5c1Q2RzJraVV3?=
 =?utf-8?B?aWQ5NCs5ZW5obXcxbmRFKzI0M2NZd1pabDg0TEJnWmlLUFUxR0lQMm5Gd2FX?=
 =?utf-8?B?OFAxbU5mYm1YRWkxYTdoRGsxR2crQkFYc2VhNnhRY3h5YmhIWkNXRWthS09k?=
 =?utf-8?B?WFdWYk1OY3g5WTJqc2hQMGhFZ2p3TE03UThzVnVPelhzSlh6cWNQZ2MydEJC?=
 =?utf-8?B?Wk5IVldJMVhyLzhrWjhDekg4dDBsUGNXRW96WFUvcDF5VUhPSkN0Uk9xYmph?=
 =?utf-8?Q?nDWrm9YyFrBjno2o8F22MghA7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <77AFD1E5DBE6EE4FBA7CF57639A095C1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de51f62d-4aa9-4924-5cdf-08dd722f2fe7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2025 21:41:54.9135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nQUjBYosf1tE9VX4e315pVkOGueCCFQO/Fpup3v7T7rvsTqiLEgJbFCQEYV8aREPJ7nCzy0iwp3T5XcaduXi7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8934

SGksDQoNCk5vdCBzdXJlIGlmIGl0J3MgcmVwb3J0ZWQgYWxyZWFkeSwgYnV0IEkgZW5jb3VudGVy
ZWQgYSBidWcgd2hpbGUNCnRlc3Rpbmcgd2l0aCB0aGUgbmV3IGxvY2tpbmcgc2NoZW1lLg0KVGhp
cyBpcyB0aGUgY2FsbCB0cmFjZToNCg0KWyAzNDU0Ljk3NTY3Ml0gV0FSTklORzogQ1BVOiAxIFBJ
RDogNTgyMzcgYXQNCi4vaW5jbHVkZS9uZXQvbmV0ZGV2X2xvY2suaDo1NCBpcHY2X2FkZF9kZXYr
MHgzNzAvMHg2MjANClsgMzQ1NS4wMDg3NzZdICA/IGlwdjZfYWRkX2RldisweDM3MC8weDYyMA0K
WyAzNDU1LjAxMDA5N10gIGlwdjZfZmluZF9pZGV2KzB4OTYvMHhlMA0KWyAzNDU1LjAxMDcyNV0g
IGFkZHJjb25mX2FkZF9kZXYrMHgxZS8weGEwDQpbIDM0NTUuMDExMzgyXSAgYWRkcmNvbmZfaW5p
dF9hdXRvX2FkZHJzKzB4YjAvMHg3MjANClsgMzQ1NS4wMTM1MzddICBhZGRyY29uZl9ub3RpZnkr
MHgzNWYvMHg4ZDANClsgMzQ1NS4wMTQyMTRdICBub3RpZmllcl9jYWxsX2NoYWluKzB4MzgvMHhm
MA0KWyAzNDU1LjAxNDkwM10gIG5ldGRldl9zdGF0ZV9jaGFuZ2UrMHg2NS8weDkwDQpbIDM0NTUu
MDE1NTg2XSAgbGlua3dhdGNoX2RvX2RldisweDVhLzB4NzANClsgMzQ1NS4wMTYyMzhdICBydG5s
X2dldGxpbmsrMHgyNDEvMHgzZTANClsgMzQ1NS4wMTkwNDZdICBydG5ldGxpbmtfcmN2X21zZysw
eDE3Ny8weDVlMA0KDQpUaGUgY2FsbCBjaGFpbiBpcyBydG5sX2dldGxpbmsgLT4gbGlua3dhdGNo
X3N5bmNfZGV2IC0+DQpsaW5rd2F0Y2hfZG9fZGV2IC0+IG5ldGRldl9zdGF0ZV9jaGFuZ2UgLT4g
Li4uDQoNCk5vdGhpbmcgb24gdGhpcyBwYXRoIGFjcXVpcmVzIHRoZSBuZXRkZXYgbG9jaywgcmVz
dWx0aW5nIGluIGEgd2FybmluZy4NClBlcmhhcHMgcnRubF9nZXRsaW5rIHNob3VsZCBhY3F1aXJl
IGl0LCBpbiBhZGRpdGlvbiB0byB0aGUgUlROTCBhbHJlYWR5DQpoZWxkIGJ5IHJ0bmV0bGlua19y
Y3ZfbXNnPw0KDQpUaGUgc2FtZSB0aGluZyBjYW4gYmUgc2VlbiBmcm9tIHRoZSByZWd1bGFyIGxp
bmt3YXRjaCB3cToNCg0KWyAzNDU2LjYzNzAxNF0gV0FSTklORzogQ1BVOiAxNiBQSUQ6IDgzMjU3
IGF0DQouL2luY2x1ZGUvbmV0L25ldGRldl9sb2NrLmg6NTQgaXB2Nl9hZGRfZGV2KzB4MzcwLzB4
NjIwDQpbIDM0NTYuNjU1MzA1XSBDYWxsIFRyYWNlOg0KWyAzNDU2LjY1NTYxMF0gIDxUQVNLPg0K
WyAzNDU2LjY1NTg5MF0gID8gX193YXJuKzB4ODkvMHgxYjANClsgMzQ1Ni42NTYyNjFdICA/IGlw
djZfYWRkX2RldisweDM3MC8weDYyMA0KWyAzNDU2LjY2MDAzOV0gIGlwdjZfZmluZF9pZGV2KzB4
OTYvMHhlMA0KWyAzNDU2LjY2MDQ0NV0gIGFkZHJjb25mX2FkZF9kZXYrMHgxZS8weGEwDQpbIDM0
NTYuNjYwODYxXSAgYWRkcmNvbmZfaW5pdF9hdXRvX2FkZHJzKzB4YjAvMHg3MjANClsgMzQ1Ni42
NjE4MDNdICBhZGRyY29uZl9ub3RpZnkrMHgzNWYvMHg4ZDANClsgMzQ1Ni42NjIyMzZdICBub3Rp
Zmllcl9jYWxsX2NoYWluKzB4MzgvMHhmMA0KWyAzNDU2LjY2MjY3Nl0gIG5ldGRldl9zdGF0ZV9j
aGFuZ2UrMHg2NS8weDkwDQpbIDM0NTYuNjYzMTEyXSAgbGlua3dhdGNoX2RvX2RldisweDVhLzB4
NzANClsgMzQ1Ni42NjM1MjldICBfX2xpbmt3YXRjaF9ydW5fcXVldWUrMHhlYi8weDIwMA0KWyAz
NDU2LjY2Mzk5MF0gIGxpbmt3YXRjaF9ldmVudCsweDIxLzB4MzANClsgMzQ1Ni42NjQzOTldICBw
cm9jZXNzX29uZV93b3JrKzB4MjExLzB4NjEwDQpbIDM0NTYuNjY0ODI4XSAgd29ya2VyX3RocmVh
ZCsweDFjYy8weDM4MA0KWyAzNDU2LjY2NTY5MV0gIGt0aHJlYWQrMHhmNC8weDIxMA0KDQpJbiB0
aGlzIGNhc2UsIF9fbGlua3dhdGNoX3J1bl9xdWV1ZSBzZWVtcyBsaWtlIGEgZ29vZCBwbGFjZSB0
byBncmFiIGENCmRldmljZSBsb2NrIGJlZm9yZSBjYWxsaW5nIGxpbmt3YXRjaF9kb19kZXYuDQoN
ClRoZSBwcm9wb3NlZCBwYXRjaCBpcyBiZWxvdywgSSdsbCBsZXQgeW91IHJlYXNvbiB0aHJvdWdo
IHRoZQ0KaW1wbGljYXRpb25zIG9mIGNhbGxpbmcgTkVUREVWX0NIQU5HRSBub3RpZmllcnMgZnJv
bSBsaW5rd2F0Y2ggd2l0aCB0aGUNCmluc3RhbmNlIGxvY2ssIHlvdSBoYXZlIHRob3VnaHQgYWJv
dXQgdGhpcyBtdWNoIGxvbmdlciB0aGFuIG1lLg0KDQotLS0NCiBuZXQvY29yZS9saW5rX3dhdGNo
LmMgfCAyICsrDQogbmV0L2NvcmUvcnRuZXRsaW5rLmMgIHwgMiArKw0KIDIgZmlsZXMgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9uZXQvY29yZS9saW5rX3dhdGNoLmMg
Yi9uZXQvY29yZS9saW5rX3dhdGNoLmMNCmluZGV4IGNiMDRlZjJiOTgwNy4uMDAyZjE4YjExZDg1
IDEwMDY0NA0KLS0tIGEvbmV0L2NvcmUvbGlua193YXRjaC5jDQorKysgYi9uZXQvY29yZS9saW5r
X3dhdGNoLmMNCkBAIC0yNDAsNyArMjQwLDkgQEAgc3RhdGljIHZvaWQgX19saW5rd2F0Y2hfcnVu
X3F1ZXVlKGludCB1cmdlbnRfb25seSkNCiAJCSAqLw0KIAkJbmV0ZGV2X3RyYWNrZXJfZnJlZShk
ZXYsICZkZXYtPmxpbmt3YXRjaF9kZXZfdHJhY2tlcik7DQogCQlzcGluX3VubG9ja19pcnEoJmx3
ZXZlbnRsaXN0X2xvY2spOw0KKwkJbmV0ZGV2X2xvY2tfb3BzKGRldik7DQogCQlsaW5rd2F0Y2hf
ZG9fZGV2KGRldik7DQorCQluZXRkZXZfdW5sb2NrX29wcyhkZXYpOw0KIAkJZG9fZGV2LS07DQog
CQlzcGluX2xvY2tfaXJxKCZsd2V2ZW50bGlzdF9sb2NrKTsNCiAJfQ0KZGlmZiAtLWdpdCBhL25l
dC9jb3JlL3J0bmV0bGluay5jIGIvbmV0L2NvcmUvcnRuZXRsaW5rLmMNCmluZGV4IGEyNzM2ZTQz
NDcxMi4uYzc3YjM3ZDg5N2ViIDEwMDY0NA0KLS0tIGEvbmV0L2NvcmUvcnRuZXRsaW5rLmMNCisr
KyBiL25ldC9jb3JlL3J0bmV0bGluay5jDQpAQCAtNDE3NSw3ICs0MTc1LDkgQEAgc3RhdGljIGlu
dCBydG5sX2dldGxpbmsoc3RydWN0IHNrX2J1ZmYgKnNrYiwNCnN0cnVjdCBubG1zZ2hkciAqbmxo
LA0KIAkgKiBvbmx5IFRYIGlmIGxpbmsgd2F0Y2ggd29yayBoYXMgcnVuLCBidXQgd2l0aG91dCB0
aGlzIHdlJ2QNCiAJICogYWxyZWFkeSByZXBvcnQgY2FycmllciBvbiwgZXZlbiBpZiBpdCBkb2Vz
bid0IHdvcmsgeWV0Lg0KIAkgKi8NCisJbmV0ZGV2X2xvY2tfb3BzKGRldik7DQogCWxpbmt3YXRj
aF9zeW5jX2RldihkZXYpOw0KKwluZXRkZXZfdW5sb2NrX29wcyhkZXYpOw0KIA0KIAllcnIgPSBy
dG5sX2ZpbGxfaWZpbmZvKG5za2IsIGRldiwgbmV0LA0KIAkJCSAgICAgICBSVE1fTkVXTElOSywg
TkVUTElOS19DQihza2IpLnBvcnRpZCwNCi0tIA0KMi40NS4wDQoNCg==

