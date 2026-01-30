Return-Path: <netdev+bounces-255151-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEbEF9y0fGm7OQIAu9opvQ
	(envelope-from <netdev+bounces-255151-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:40:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0FEBB3AE
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1EFD300DD78
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 13:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6F3253F05;
	Fri, 30 Jan 2026 13:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T6IFXlqJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dkwEW+e1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43F130BBB7
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769780438; cv=fail; b=O+xtlCfjtHN+Kx8nEdgIgskMhH6e3z+8LIF5zcJVoU9JB668RSwss4hj5s5zejTRUQuLYZ9qxhes2VZ/I0rljhVm5L4whJHCW0x1WH4Fqqt7Ou0jqTNzERfCWzKoS7o1nR7gSCBVTNiWD4K1vOGS3RP7xryATAYRGdi8XDaV210=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769780438; c=relaxed/simple;
	bh=CwVAWTl8gu3SZCWdzRcxW2Lf13UpY10cvJJl4WiSuZ8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Pd1NvSFMilXstB2o4ygKNv6DrB6PZaHFd0uONjRrwihFEicoVJ/QTIXl5USvqdo9nLdbQGhHAK66cYZMWMWmToQhkeJsY93tljzRSzrJz4OwusVWfVeKYnUtqHW5yilVwl2mul97cAUyU8jv3vY7D+AR0zOxunUsH+Nz0SWaR6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T6IFXlqJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dkwEW+e1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UChIMF3156562;
	Fri, 30 Jan 2026 13:40:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5prdxSKO8pRzQcovb4fcZYGOqYNABM7tiXMGgmQ7KFI=; b=
	T6IFXlqJYQOwA2XiTrDS6E+occ+IcJe8FwbP4J/bp6ryNCVhBExDBTx133qxF+Pg
	j5rXOv5tdASPNft154JPRAicpZIrIg1Sus2BRhMjsmZ4vnuNsEFhcochK43Oi4+3
	MaGfWpnbBdd6qSMOiTxMs7HbFFXjqfvg8Xoskf3B/tla33qjGZ8gU+01G+Kura03
	478FMLQ06xdJ2ARcXge80kxz6vRsJ9k/UpV32C70MRMD6NDwmfWsaPl0kIG0WrEh
	jylJ7H1Cn2B5BPO0adn1QCqNw3XhdpF8/8aH1u9cjIkJHsiBwZQJAUlHTz/vnGYC
	3l1dgQXlSph4MQjyflfygw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bxx09nxq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Jan 2026 13:40:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60UDKs7L019813;
	Fri, 30 Jan 2026 13:40:24 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011067.outbound.protection.outlook.com [52.101.52.67])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhk0a7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Jan 2026 13:40:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UzZbuJQZLbGoUgzZP8j5Cwl1cSR48K+TVwM5LgnFUfOFXgC9Le0Oqa0JakrkzyNrG+UgfIxpq3sPL6KFCwQ9mgiASc8ASM/0RSWz/NBuMop3Lu6rjVfEIsOx0f2G7FDuJx4wmSVMHcnqBjdiT3EJ1S6p9VDdFOsXn9zEt3KsgCDZmXqVEhQB9w89qQ6P/KfaqX+K+2QfHrYzmSui8QAnWKFGJavXrmzyj8dwo80rUk0ABhP8O7JoURzXRLr5s7khTWZPLSCns7jT/9dfOtM9I9pWWjnXLCuxW7NpYB5TJ7t9cTGxrus8xpznRVv5+NVCBvTaGrxZyKaPyZcQTdBw1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5prdxSKO8pRzQcovb4fcZYGOqYNABM7tiXMGgmQ7KFI=;
 b=MVgSlFVdMK4vfT9lxlc00TG9K+CelsI/hKXJD6ZBTrfxPWBRu/wj2Xqc8NeeQ2jwFSxMDOoxjsPew09bTz+d4+ffvaVkEqyQvuye/aulme+Sv4HChukvbG+w+0rF1SO8MFiaAcOs5oaPGKRhmQb4Uuz36NggbqW/klcWpegws8pHG0IpoUra/yDMi7hzrtCPALXu/+9o20GFw9I3sBN1yca97/Fu+evo2EL8mn9QwKWSsOqhb4iW62ncZN72YXzJP4Wy6bECm0VVl00Wz0vqP6+YaZzXnKsROKSu5lXot9Wptuq+DmV6wgLUL39v2y7jjWbC4UWGeO//1f2GarBhcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5prdxSKO8pRzQcovb4fcZYGOqYNABM7tiXMGgmQ7KFI=;
 b=dkwEW+e1Ms8JUwqGT4szEdCQrYaM/SWHw+YoQfG2PF17XbeoQgf/N6v81Z0CnqX2x3GnktyJmUdJEwRfEVr4UKV42n2HRj5hTrxkwwTZQaVI6/BbTiCy2yVHwHb5f4acLRqYM6BSjOwAFxm/Vz3OUOKbE6S3Tyl34hgLkTjl7J8=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by PH0PR10MB5643.namprd10.prod.outlook.com (2603:10b6:510:fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Fri, 30 Jan
 2026 13:40:21 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 13:40:21 +0000
Message-ID: <c19fdbaf-e179-4bbd-b51e-4de154233776@oracle.com>
Date: Fri, 30 Jan 2026 19:10:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] bng_en: fix misleading error message for generic
 firmware version
To: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Cc: Vikas Gupta <vikas.gupta@broadcom.com>, rajashekar.hudumula@broadcom.com,
        netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
References: <20260130073055.1609162-1-alok.a.tiwari@oracle.com>
 <CAHLZf_vxzcOpavJ-rNUsmi3XQ-NAqmWBvy2MRgGb2A3iWFHFHw@mail.gmail.com>
 <c102db6f-c676-4bb9-a1ee-3a43b35e6290@oracle.com>
 <CANXQDtbG9cXkzAPoDF9p5sLon=4aOrKJQvojgbieyhQ=+8mWuA@mail.gmail.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <CANXQDtbG9cXkzAPoDF9p5sLon=4aOrKJQvojgbieyhQ=+8mWuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::14) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|PH0PR10MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: 6599ea2d-d6a4-430c-3cd1-08de60051cbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qklib1FNRDJUdHZsWk1PeFArKzVSS1ArY2wvMlo2Z0xVeU14YjBHKzdKUDZG?=
 =?utf-8?B?NERvMTdYdm91dGRrd2VoazNIQ3pVei95cmRrWC9LNjVBT3hRVzF0Rm9vQkJ4?=
 =?utf-8?B?RUhobWVuWHF6R0loTDdOQ1pFR2docTNTVERRV1BmTjZyZGlDL3NpeGQ1VXNt?=
 =?utf-8?B?bVZZcFZwZXJYRnVnMGRIZDh0YktHc2ZyMndkejdaeWdLeEo1TnlyVVdJRUZW?=
 =?utf-8?B?Y1RScE9JanE5T1RQaEpnYzFNTFZjTFZxZFdCUkJQWU53Rm1zVHk0STRWbk10?=
 =?utf-8?B?VERKV0tKWDExQTN1SStzUnYxNlBSTnJWY0hWOGNBYVVtd0had2sxU2FpOVd3?=
 =?utf-8?B?eVNycDJNeU56N3FXZlhCaHROMURNUG5ZSzdUdDJoaDg0OGxTN3EzeEdSQlJz?=
 =?utf-8?B?dDVWc3VCaCtyaktLSXFjcUFuWDQ4a0wwc0dFRlNsUG5GOXZLZWNndTBlT0xQ?=
 =?utf-8?B?Z3N1ek5zWFc0QkV2SkUzelhkdElmeWtXYXVMYlJ2QmFEU3ZKdWlVSXZFN2c2?=
 =?utf-8?B?Zis2VFhPTEY3aFFCMTcvZHBOYkppbzBLanJydENHQkZ2bUhUMGtleVBSanRW?=
 =?utf-8?B?SVA4SDZidnVxQ1NEL3k3aVNMVjQ1bHFoc0xYVUVGL25YaXJmMjlvd1hLZWtq?=
 =?utf-8?B?anhRV0pWSmZKQlA0cVovVWtsaDd0ZGJlZFBIN09pZFVXN0Y0bGtLZU9mMEtV?=
 =?utf-8?B?bnZYZjJWRGZyVUVDQVVLVk9hV1QwWWM4czV3b2V5RUczdVJuQ0s0TXRhUWNN?=
 =?utf-8?B?TkNRVXU3VStpYm5EaldyZ0Q2VUwrSDVvSitrUWdXSmRVQnlTaStzckcyUC9q?=
 =?utf-8?B?ZGpPYS9mTGc5L3NOWFZ5bExjemQwQ1FZYnMxRzQ5NGV5dUptbkpuM2Z5ZXBm?=
 =?utf-8?B?NGIzeHV2QS9tN2V3SGwyZkhMdWh0TmFEMnVrdm5pUmtSSWFaMUV2b2JRQWVK?=
 =?utf-8?B?WVNSaHZqNFl0b3ZFd1U3NmZPVnlSN20vb1lhYi9BcnpEbDRteGptUUZCalJt?=
 =?utf-8?B?UktLV0psTzVmaFVhS0JTM3dneXNTRit5dWJVdzZNc3BXeFh5emhqKzRXQk9N?=
 =?utf-8?B?YXR2RFNPd0FMREZ3djlNd24yaWt1ZkFlVjVXR29EVkVja0l5dkJMZ1Z1MEpw?=
 =?utf-8?B?L0cyZHNhQjB5SGdqS21HY0UrN2tyU2o3ekQzbUlHS3UrUjIwK3J6aXlmTnNG?=
 =?utf-8?B?Z0lTUTZXUVNhKzZ1c2ZLdTcvUm1jV0VwYTNDaDlSblE0cUdGYW9pQlJudjE4?=
 =?utf-8?B?U1g0U3M0ellENmdtNHp0V3pFMVdheE42dzBjdkVOUTJzc1YwM2hOS1NXTnll?=
 =?utf-8?B?UEhpTFJITDBoSk9mVmY2VGFtR3Brb1Zwbnh0QXBZd0V3cHJFRkFUY2EwNHJJ?=
 =?utf-8?B?WFkxeWNTdXExb0FGNHRSWnd0VWVrVVhEWXlxWEcxeGk3MytiYklHQVU1T1Rx?=
 =?utf-8?B?S2dGbzJKNjRreWt0WGFwMUJDTFc1eGl2UFlGcElQeEJ6Ykl6ampQWWkwMWc4?=
 =?utf-8?B?QlJENzlBTFJrUUNYVC9IaXpGZ0NSWlNRUkp3VFdKQWFBMCtiZSsveG5mdHJB?=
 =?utf-8?B?V3BabHFNMXR4S2ZyaFdBbXpZRHVMS3JKYUh2dnVGM2FoZmRRT1Yzekdia3Rw?=
 =?utf-8?B?M0cwWXdOaGVuSVJLZFIrRkl1N2pPdnRId1lCbFJXcDM1UHpnYlN0UlJXZjZM?=
 =?utf-8?B?RFViT0ZYVmFlSGRLNGt1Y1BxcU1NdnNqYXpsS3Q2MW45b2pSeHJSblZ1akc0?=
 =?utf-8?B?b1hVV2RaNEdRaTg1R1Rjbm1iZmk5dTg1clpBZXhiTHhyUWYwa2xWWDM3Z3lM?=
 =?utf-8?B?NUpZUGY0UDdlMjF6SGs4KzZCaG1QTC9ManRJeTJRVktWdWZHWVkwVzZydkN3?=
 =?utf-8?B?TjVlcUlybU5kS3YwUi9GNDYvcEVpK2RDMGprREozenhQNkxQbVIrVklHdGxw?=
 =?utf-8?B?WTBJOVlUQXZQcXNST1VNZkhSajYyVUpoSWJsZTlFRFF1NVBEeEN6K0tMWkZQ?=
 =?utf-8?B?dzZtRkJTZHJYVm5PMU1vQ2dsRUFabVgzaTh0RnlqRWtqWmpqTmZRMVRZSHVW?=
 =?utf-8?B?L1puQmtPY2NJTS9qU0JNS2diM1BOOWplRE4zemxKL3pQdTJBekZheWhVZWdF?=
 =?utf-8?Q?REv8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qm5DSTAwSUVtMkxLcVhicUQzU1JwQVgrY3RrNzBhUGhvZ2NUWUtDaU9OaUFQ?=
 =?utf-8?B?K0UyQTFiNW1Sbldqcms0V09rWmMvQWxCaFhPdmtWTG9BcXhQTC9xc3Uvdlo4?=
 =?utf-8?B?c2h6anBXRnZHdG9kL1NQQVNIVlBOTlQvK0xNVUtIUldQZ0pzVTBzZVU1Ynkr?=
 =?utf-8?B?SXBodDFjLzFMZkxHZjk2d1FvL01uWmFYK2Z4bVFrdHRhU3h1YnhrSXFmUVFU?=
 =?utf-8?B?eHduTndyOHl6Q05HZG1neUFFVk0rWHc1b21QNDFCZlVkK2F6UTZJcC8vMEFx?=
 =?utf-8?B?VW00b2VPSlFhelZ1Y1lGWHpNQlYvSVZuUHpBdUVHcTJvNkcrOUZUM2NqOG9x?=
 =?utf-8?B?Sm1SLzR0V3dVV3hnMjl3VTRzK1RaVGJ1eTFIMzdROHF0bG9DWWhkN1NScjYv?=
 =?utf-8?B?ZWNkUFhWbXpiS1NBenlibC9QTk1FdUQ5VndCRkJkK3Y2YUJyN21zV3J0bXFa?=
 =?utf-8?B?YWlJUS94NUd6WFBDMzZGVzQ1YnhQUWNONWhUc25qMmszQ0xTVDNUY3c0M1Nq?=
 =?utf-8?B?bWxRVUNURnRHRFdIR2g0N3AxYytqalJOQnV3VTdEaFdNajVmRmdvZmdhd3JV?=
 =?utf-8?B?dzNkQVZYc2ZWRjlnNUNFcGRqT1FsSUVJdVNSc0pubEVkdmZFaER0akkzTXVz?=
 =?utf-8?B?REJIZXluL0wwOG9QbHJQS2VXSnFsT29DRnFHeGNOT2thZ1lRRHJOQXp0SWxP?=
 =?utf-8?B?aG5iYnNUWDJkYnhqdCtKWlpva0t1KzRWRVFONFhoS1dvVGF6bmlLS250dzg5?=
 =?utf-8?B?Yk1aN0E1a1RlSEVjb2w1Ui9XdktyeDdzSU1MVDRDTktwZGxVRGY5bmVrNjg4?=
 =?utf-8?B?ZG83elNFL2xobmJ6aGE3Rkd1WVlBUWhJTDVhMDRIdUxFQS9VbGpZT0RiaXIx?=
 =?utf-8?B?L0VkNURrNEhDbWhQTmpjR3EyMlZUZXZWenhHTm9JNVF6OFlmSHh6am90eFZE?=
 =?utf-8?B?OThSN2FPZEdLZTdNdUladjhadWxmUTYzZHpFem5RTGpZTVJIc3RLdXBUUzlJ?=
 =?utf-8?B?R3AzalVQb0IyalRXMEpLNFdUcVRLeFAwSTVUSUF3NnRvWmtzTThFcGFocmRD?=
 =?utf-8?B?eDJjVFA0YlFCWW8zSGJjR1pOZEVmU05IMWZ4VkJRK1ZZQ1p2OWhLSVMvaFJT?=
 =?utf-8?B?cC9sMFB4ejFJWkQ0M1dYK0tITHpZSW42aTJEZCtXRWs0d2xZTGRoa1BVS2tQ?=
 =?utf-8?B?L2E1QzY3ckdNT0ZJUXY3N0hqL1hEdC80Ti91WHRyZlpERUpJaWdrYjFjZkNU?=
 =?utf-8?B?NmxTM0JoYjJTMUpNb3R0YWJvNUdoL0F6bUVLVkw3djhoQmh1QjJVeXBhNlVv?=
 =?utf-8?B?SEd3bWQ5RmJOaTVXZXVMMmxkMk5kaHJPc3pZTHBPZExRRFV0eVBkUXI0NWZU?=
 =?utf-8?B?NSt1bFJtQ2ErZ3h3NEdCaThHb0J0cmhjUXhObXhTNDM5ejZMZ3NXSzFCVjlC?=
 =?utf-8?B?Kzl6aDhVdXlyeVlkVmI2UXkyNTYvOHhuR1MyNUEyYkZIVnZFVzhWaEFyMWs0?=
 =?utf-8?B?ZG90Z2VRUFZIZjFNZkxiRi9meXhDK2Q2VTRBeUtzUXRJV2NNUGFOeFc4QUt0?=
 =?utf-8?B?QmJOakNxQlc0aGs2aG5yZ2ZWUVUzNWtCOWY1TGZlbnJMZHBqK1NtVndFREJG?=
 =?utf-8?B?Nk1OWUpZUk8vd3hrQ3JuRGJuano2L0VZYUd3dTJUT1hMcWZTZll2OFFVcjBj?=
 =?utf-8?B?OGpJb0l0dllTWStkQWhyeEpZRWhRVWJiUmZMMU9UTmFOdVE0c3o3ZmNMUXYr?=
 =?utf-8?B?NlFDYzBqQjZac1luKzFVMzB1MmdPbHkyQXZlOVV4R3RaU3FNNldDeUJoayt5?=
 =?utf-8?B?VGpPT1Q3eGhDU29kK2ZLenpTL2lsUVpIbGNwYXBFZkd0Z1JMV0VkckoxSE9t?=
 =?utf-8?B?aUVRZGNWQmt6L3VaVTBsa2hFcUcxdzFLajZaVlZ1VjNLTmJiYTgvcTlFR0lL?=
 =?utf-8?B?RkZ1VWV2aExxenI1aXJuaTZ3c1MyQmtrQXRKQmh1N05ZSDF5WENBdHRHZm5t?=
 =?utf-8?B?eGpxb0RxanpIY3ArekkrcGxkRXdjUWMwUEQ2M3RSOGN5d3B2WmExZ2diYkNP?=
 =?utf-8?B?NUJPWGh2U0ljc0dtNmRwWmtkaUY3bDdLNCt3OU5YaXpyNGhYNVBoaUI0c1pH?=
 =?utf-8?B?UkdpOHhBaFB5Mk1pRHlid0FwZ25HWjcxbDZFVUhHMTlEVTJGcmxKVFN6N1A4?=
 =?utf-8?B?eTFCS3BsdHJaMksycjg5ajdOd0dwZ281QTZKYXFCODJQYjYxeVd6K2pNSGFT?=
 =?utf-8?B?WitpZnFBbUVIMmtTRWQvZ1c1cXdsMGxCcGNQVHR5bUFZbjI3Z2VuWWtCV0RB?=
 =?utf-8?B?YjlnTWNiWi9vRmM4a3hEa0piTGdLRWxLZFJtZStUM0VtQzY2M0dLY0cyeCs2?=
 =?utf-8?Q?EG/zohtFd1E6NdZk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6016WTjBWtYBlmnlFDZxremzlHVsrhtjZK2wevT+7wIeYkb5t7f4nqLMj1F99q5CUBks/pv5xwx4jlBDiaDzUVEk+9WO7+pSqfI58OB9wkbAcm2xadgeu/E96hqVWJaoO2Uvs6f783I0fgfDWH70QdvUYO85qXCtRKnmzDJ6jeQCVyU+WLusCOMdlUQZv75kmsT+wzPRwB5Tri0wzQlaOuo6ow2EfFxzEgH+y2uuVmJdjx0x66Ru7u207z5TJcniCQVxTZ55SZcLD0wq7vnXgpFEnR46LWsOYzq5pwpHAXJ8F3twaZ1rOoPe/SRbRK8PHiBlVwCB5tO0MBV/Z/gvdI0hLWLXWuue1ICYAa7hH6JfACwgBItE5LcRiJYYSGdWrPwNcF9RvGFNxvKVh7FAl9KP3xoD5WrAC4HaTH8ZucN59oL/o8tMdbGhCFP2gED17wZjfLqJttTiBE5ESipez2Alv3DvQdr2tOL7HDTOSPIK0Z0j71Em+6DBV33kZUzk/VrW82VsIBriH8um2yfRguqYb84h+TBq1ru0ng7H7HoVmP91f2EP9bMxVZE2QT2DHw1n+vmbI2pyCZ6dDXEle26rNd3o7cUc0pwLZ89PR2c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6599ea2d-d6a4-430c-3cd1-08de60051cbf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 13:40:21.5708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ju40VlvqQc+iFxqGON0ycYXG9oSmLU+sOBIbNsP8TQV2c6qY+XfkZ21e79U/VevlE6ZpKX4GAHBNQmJsfZrAzlt5PQMn9hSiDuOCjRxAHGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5643
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601300111
X-Proofpoint-ORIG-GUID: G_EfsOldwwpfWOOLEdhzPBcn2KSqZSyK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDExMiBTYWx0ZWRfXzmoFYkVJKldU
 aEhRbEaAP6JzNZv1jW0rm+eKowvQHyiV2EGqqj198mjraoNRB0ErqZIKNTiEEP2k0wZt+pZpC3O
 41M8mjldxtJQRufUNflc0iUlMOwKtzFGtHgdmspGeWVxxGZWVWJJaSpq3v0LJ3nzVb1JxRJOjX8
 Q3tgaEVe1fmTfvApKcqlMdhsJYrWOtNXgoI59mr25Y2hg2rckqtXGIC1FVrpVa9PS7sMiDXXS0P
 xckiX1BsJUocQU1EJAfBjjhNG2cxl01yj0DKIJIuhynsIDoTHsnNSNDQ5O93+SUZjnhsbwYiBt4
 nIs3wxRF7dD/26pt9QHckK5dN3kKXONiJ3IFACO/cCH8izgtVY6NPxv8HxSYwpB2h9aqqvBVMrj
 upMBxHCheZtY5YQkf/BngdrWPe9/WhWtm8julZdOX+6r2RybKycPsNNhbRAkk/5S9UnRORtMHw/
 ZqwfEVb5avv5menQxX0WCm/RNjTfbN2m45kE7BoM=
X-Authority-Analysis: v=2.4 cv=Qe5rf8bv c=1 sm=1 tr=0 ts=697cb4c9 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=MiX8jvjbh3gFFrygRhgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12103
X-Proofpoint-GUID: G_EfsOldwwpfWOOLEdhzPBcn2KSqZSyK
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255151-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alok.a.tiwari@oracle.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: CC0FEBB3AE
X-Rspamd-Action: no action



On 1/30/2026 6:36 PM, Bhargava Chenna Marreddy wrote:
>> On 1/30/2026 2:05 PM, Vikas Gupta wrote:
>>>>    drivers/net/ethernet/broadcom/bnge/bnge_devlink.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c b/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
>>>> index a987afebd64d..57db3caabcfb 100644
>>>> --- a/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
>>>> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
>>>> @@ -221,7 +221,7 @@ static int bnge_devlink_info_get(struct devlink *devlink,
>>>>                                 DEVLINK_INFO_VERSION_GENERIC_FW, buf);
>>>>           if (rc) {
>>>>                   NL_SET_ERR_MSG_MOD(extack,
>>>> -                                  "Failed to set roce firmware version");
>>>> +                                  "Failed to set generic firmware version");
>>> Thanks for fixing. I believe instead of generic, "Failed to set
>>> firmware version"  is enough.
>> ACK. will send v2.
> Should this be a candidate for net with a Fixes tag?

I am open to either approach. It does not break functionality, but the 
current message can be misleading so I am happy to tag it for net if you 
think it’s appropriate.

> 
> Thanks,
> Bhargava Marreddy

Thanks,
Alok

