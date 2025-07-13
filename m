Return-Path: <netdev+bounces-206425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC004B03119
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 15:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2AA41898F1D
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 13:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95091EE7C6;
	Sun, 13 Jul 2025 13:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EchiCzM8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F4614A8E
	for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752412813; cv=fail; b=QF0Rc3LKTNhD4LhVfoeE8pCSQl9c2U4XcBT/mRy93TkN0dtZtXu4+8alVhZAWUYyCK7uoLZibBCN0pfqfkyqsvxqQxCJWgb1b0rOYKulhEDJYJU2wS5bbMv1Qy2uX/WGM4qIaWVw6vcsvo7TxsqJ+cn2iU4AX8H6r+90Ao8xwRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752412813; c=relaxed/simple;
	bh=Gew2cgapvAg0k4/L3JyO0AYN35NHFOSeFHfBKIx3Tmg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GXaWj0utz1jtOCK8GzVKMFvKGYLT7lkkZ9q1gfHtM+a80rePyXbYLihkR/hBjHOeYAGLxaPBEUI71J83zLqoaFCzzhoxDWzvAvgbSWhUMU6h5mJyIxwT6hU9LK1WMgz57Qg//MoNtz2rkysfTisyDI6h+5SbeikLuWh460fQI+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EchiCzM8; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y14lXYNSVtiuYR709WVQdKaStl1C82jrqchbgAa9cGfAUFjgS4nuGJrGtT1qGQazIdwYIPrDp9YKOTm+PGacVBMsf9cSfS9fE0jPb4mStBH73wSEEVcmSciTf0Oz6aoUPedGHY/j7LhkTvDpLm0PL8zg4wIA0LeD8+/Vvq4DcMlxRDdb6jRDlXNxAS9BrW/Qod86dcrAIo7NYTozUsnr8CH6ZxlIZWTwfJaMsgO5PaRebo/KMGV0Y06u6PoBRxS1Z3Z5d1DPiHcSHA14rdC1PZrBwwfrNA63gu5UMjnOaETT4lUNxHNWnzZC0dVw6+6NSidugJKkIFujs1iNThuZIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QJy/gTDiThVXjxxI9OE6OLbPXMV4Q9ENKWSO54Z058=;
 b=MVUFFBvklstj/ZuTd9OSs2cGGBXB1a1Xq4D3G6RR/hcwMrvl/bcwEd2Y+qCnKxcNSKLHzs/F4esVzwT6wHEcn3bDvEgOcmPkYH4RXmasXbpFjHNcogN8i6ab1ddRF0vg5jyOHbBrLUcCJ4Li5g6VcWuF1IDIsEnWOaS8NDtNxT71zMJhenD58RsKCx6ZqjpZGRb6B4fo0K0VXfSgschzctGo1aqJGm0tDPa96EdrbOHwL8ZrQ/maaZKvPVLEFyUjaZPZ27qywGWtJM0zgM3yB6I9dgFKcumWToTWvVXeHZ3EoBwLJczwpvt7HAa80GX6HJDh/6wld4hiKcKrzS/P4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QJy/gTDiThVXjxxI9OE6OLbPXMV4Q9ENKWSO54Z058=;
 b=EchiCzM8Wg+vlUsmKOYRd4PcDEVaFurfDo0cEJ9XK5AZvd9FhavSXFUHsNZo6cLgbAPKwxDnjcJjqieM/JFoYHoOPHCgsQ/i9Zbtm04IN9bSWX9LDR/wUbljL+vzndLTuWiDcrbuqb8s3OHrkdTpb9fiiMaybIS0Dd2FQdNGdo6MOg+ZNvVlGH/rAeVO5lL9mWXoKOx+WPhM/JsQ1Zj+sEsxskyhcxtsEErmeQpZ98cx1S/v5kDTrpeic1B8uS6wdEMeLhs2sMeGhpyCwzp2aHikUc3rgs2GTGjsF98yNydUyeWGxL6HPxjnLWnPsmOXG506KvXdKZoOMbjsfFjPAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by DM6PR12MB4092.namprd12.prod.outlook.com (2603:10b6:5:214::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Sun, 13 Jul
 2025 13:20:09 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8922.023; Sun, 13 Jul 2025
 13:20:09 +0000
Message-ID: <bb78e3b0-f7ad-4a72-9f08-63af08fd474e@nvidia.com>
Date: Sun, 13 Jul 2025 16:20:03 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 08/11] netlink: specs: define input-xfrm enum in
 the spec
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
 shuah@kernel.org, kory.maincent@bootlin.com, maxime.chevallier@bootlin.com,
 sdf@fomichev.me, ecree.xilinx@gmail.com
References: <20250711015303.3688717-1-kuba@kernel.org>
 <20250711015303.3688717-9-kuba@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250711015303.3688717-9-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::9)
 To CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|DM6PR12MB4092:EE_
X-MS-Office365-Filtering-Correlation-Id: a39fa31d-624b-4ab9-6df7-08ddc20ffd95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkNWT3BtVllhaHVHRUtoZ1Rab1dVbDBNaTg1OEtJMFlXLzBEcUlkT1JsbFBC?=
 =?utf-8?B?VTBGR0lJczRzaDh2a0pBdGx0NHU1UUw1ZFlWTzc5M1VqVDFtaEZLQXRBdStC?=
 =?utf-8?B?RXlmcWFCNWtiek5GbU1jZVp6dEkrNGNjLzVPTk5JLzhmZ1lQbWZSai9hUS9z?=
 =?utf-8?B?RksraWlJVFpkWVZBaDJKeUxORW1oRHVhZFpGcG5BaEpuYWRJM2k2ZkxBRGV2?=
 =?utf-8?B?ZzRmbm16cE1uUTRFanM5OWcrbTZXSmtyek5KWTAyNXFoOTVPTHpvaXY4VFBT?=
 =?utf-8?B?WWZyMHEwUDdGYitxeGhUZkdNL2U2UGRiMUdtOWttWGZSV2JTM3lXblI4NFJq?=
 =?utf-8?B?R3A4MGNsakUybmZDLzM2WTRJSWJYUFNMcG90U3ZUU2hRRDJYUDN2Qm9kQkEz?=
 =?utf-8?B?UWZXbk45ejg2d01tZnJUNUdGcDVPOWdNNHNUMFFoTnJJTlRraC82dCtaaHRq?=
 =?utf-8?B?S0FRMkt2Z0oyc1lWOXNNYTJEa29JcVU1aTVOSE9xVFViOXo2dU5VdnVVUUZ1?=
 =?utf-8?B?L1RCU0JaTk8vbGdtY3VxMHVVZlJoVno3M1Z2RUErVUlGL0tBNzZwaWZ3Q1lj?=
 =?utf-8?B?UmtuUU5lNEhZUHVrRGhCdmtJZm02eEQyUXJYT3JSMEs0bTlDbjlEM2xRZ2tU?=
 =?utf-8?B?aTJpU0k2TW5qbE1xdjV3K2VwVk1BYTVFbis1cHF1ZnJReUFZN1pISGxjRksx?=
 =?utf-8?B?OEJqK2V4RktEdFBKRzBuazlTbHdldzN3WXVRQWhtbE1mQTZQV3NOZnAxRW1o?=
 =?utf-8?B?WVdtbndETkNDcTBkc1Qva0tOWE12ZEhOZU15cGF2b1JNaWk3RGNSb2hmWWJD?=
 =?utf-8?B?eEZJZlRVdGxIK1pqbEl5UFBJdFRLUzk0c0hSTUJucHd6bjdIMXNmVTFiVlNC?=
 =?utf-8?B?aE9ab0oySFNiaXNjS0tPbk9TZDNwODZWMi9ydEJaSUdJNTNLdWNaeVJuY0NX?=
 =?utf-8?B?S3ZyYTJBUkVzZ0Rzd29Oa0dCZ2YwS2EzaTBOS1JXS3pXbG5vR3F4bHlNYlhM?=
 =?utf-8?B?ZzJ2TmZBbkhkMzYxSGQxSi8xN0E1MlJPMytTN1lBTU1wVllLbTBROTY4UDlU?=
 =?utf-8?B?a2crMmhrd2pxM1B1a3ZKRWVxczBFaHVnSU90b3BlKzYrS0tKK2dGMmxyM0Qr?=
 =?utf-8?B?L3pCcCtwS0NpaUJzMWZYb1dwSmVtbEtnV2g0S1lxU3FoTC9tbDJ1Q3lhR2dI?=
 =?utf-8?B?QkloUUlIVzliMWpQajRKbG5ORHNGemxkUFEyU29mcXRUYXlYQ3grT3ptR3pP?=
 =?utf-8?B?Q2RGSEp5RjlDWGFEeHJieVRjVXFFQXh3TTU4K1g5UXdWc1VIUmh4N256Sjk2?=
 =?utf-8?B?aUFRZmMxSXlYaEZJZldvQWhUM2t3YTNFT29YcDluUXpRZzJiZnc0RjF5bVdy?=
 =?utf-8?B?NW1CSnVFNEZ4bkhZcnBpczVKZHZWeCt2VUo3bmtWRzk1VmIvYU9ubXVYejc2?=
 =?utf-8?B?N2tLMVU3M0kwT0JqOHJtQjc2YmgzRzBZb09tc09RWmdnbjBYMTA4Z1VzVndP?=
 =?utf-8?B?RXo0bWdwbzJBVTJFVlBwT3R1cmdOajZic2xWL3JSZHROU01UOTFJTFcxMWZr?=
 =?utf-8?B?Mk1IaVFDNGVjTXhab3laYlBYMjAyZHhzdXdxTDBnR0ZOckpXSXRKb05pZ056?=
 =?utf-8?B?a3grc0xiZ0xKTVJETDZoVExMNDQ2NEI2K1BvckJtOWR5ME5aSlFjaTdUc2tl?=
 =?utf-8?B?b1hNanFPYXhoazloRzVXSVI5cVZiNThjWmJJMDRhb1hidlFLOEdWN1lIMHJU?=
 =?utf-8?B?Unc0TC91dkdoUWUyRHI2RGJHN09jaDNOUFlsMndMM0pzZkZrYnJIYTRWRk53?=
 =?utf-8?B?c2lTQWNXUjhPU283WHkweGtHR0V2d2Z1M3RBSjVSTjdicUtMNmMwRjRkd3p5?=
 =?utf-8?B?Y0ZwVlZEK2pkK2s0aU14Uklyck1XTHZmWnNCYjFSVnNWQ0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVlmMmUvUkEraktkeXU4eERlL205MEVUOGt3RzhWTWxnTjJUUVN3TXkyTnNO?=
 =?utf-8?B?cHJCWUowMzJ1TGJFakFjWEU2NlR3WmR3SER1VXI3YVpZaEYxcGROamtncXZS?=
 =?utf-8?B?RlNOdXlzRmpkbFRpSGNPc0lFQXB6KzJJOTBTdnloRTNCM2l2cVp4RVp3Zk1o?=
 =?utf-8?B?L0w4ck9jYzd1QUtoM20vRlYzZ1Z3SEk1bGxjTG42K3kyNXUwQVpBL1VUSkFH?=
 =?utf-8?B?c05ZRlVrTkM0MDk1alZFeUdkWlMyVmdwb0YwcFFvbTU2enFDRFBENDJ4dStm?=
 =?utf-8?B?ZENVMHU2ZlBkV2lqd01tdkFhZTlUN0FRWGl0SEp4QUhlckNlRWZBK1FNN0Vs?=
 =?utf-8?B?TnMwNU0xakk1VXIrNVBodXdXZzh4VFliT3dWOE5uancrYTQ1VVM3Z08yY2RR?=
 =?utf-8?B?dlBjd25EOVBxSzQ5aWU4MmZESzJYOWIxQklQZWhIR3lEUEo5RGNiV095VklV?=
 =?utf-8?B?Sm5jMmJzcGhYYXZLMHl1Zm5ZdXR4elNiN005YWQ0dXFoMDhxRy9HQzFub2VP?=
 =?utf-8?B?ZDIzZjF4RHhxeEVaQWFkSzBhWUg0TjJPYnZISVJPMVhtQ2QyTWZleGsxV1dG?=
 =?utf-8?B?N0dSRHJ5aHZ1bm9pYzJvcFhneTdQWWhRRDZuWHVEcVc4UkptZEdKZyt3WGtN?=
 =?utf-8?B?VjRDUkQzYWVGVk9sblJTMVNUdkpZdWFsN2NuMkdLR3htUlhQVVd2UUtuSlll?=
 =?utf-8?B?RmlGeW52aEVLQ3RPS0FZVnVkSzR4dkZ4Zm0xRmJVdHZzWWdBUFlrSUNXdXpF?=
 =?utf-8?B?TUd6RDQ4T25Zb3ZhM1hrQzFqZS9KR2VhVlNWSXF0WXhJSjl6UVMwZjhyUlRV?=
 =?utf-8?B?bTJCZlN6bEZVQ3BJSjhWMTJqT1paUHYrZ0dTNDk3VnBDZjAzMGhFd0RkSDEz?=
 =?utf-8?B?d1JBaFdDaDB3b3M1RVczVWZtYTRPVkFPOVR5VGdwVFBZV2RTdEE0cWMyQkZP?=
 =?utf-8?B?R0xPeHRDWHE3SUdBMHp3SEU1elBrbHlmTjQ1RE1aSEhCek5KUGU5ZktVQ1Vx?=
 =?utf-8?B?dkFydGs5QS9nMlNHWVNaOGRodnlxTTZmNHQ1N1hyZ3lybmt0V0NjOVpjWW42?=
 =?utf-8?B?dWRIeWZ1RmpoZ2NmWGFPZGNPN2w5K3QwYUF6Q1p1M2hvUk1TUTRLTmQ3cnR6?=
 =?utf-8?B?bHVRTXhKY1BSZlRBRTV3V1p5RmRrQUVkRUgyM2MxU2FoVUpJRUo4RWFCMWN5?=
 =?utf-8?B?djNqYVpMUld1RWpSYnY1ZTdVYVhxWXJ5QkZYR3BlK0J1dEd6aVJEMUEzTXN4?=
 =?utf-8?B?VVdvVEl2aVFIMm4rSUZwZ2hZekVCWFQvQkdObXQ1bnBqMlh4Sldrejk0dy84?=
 =?utf-8?B?Y0xQbHNvdGFhUTQ0VjlVQjFvSmw4SEprT2xKTnp4bkpSTDF3YWFJdkxBdURo?=
 =?utf-8?B?NXBoN2pidlh1TEhCQ1RXWW5NbVlnM3VLZVVacDVVVTFJZTArRFlwQ0pjeEIx?=
 =?utf-8?B?UVgrS2F4SkpuaHB2b2MwTjlhNk5kL3ZnVzcySkxhZGNpS3NKVW5hbDJXTVp2?=
 =?utf-8?B?bDRaVkRDcW14TlIzakJGcG5IS1JnVldvaHB3UmNTL0t1Mi9mZ1lKZXZTT1NC?=
 =?utf-8?B?WVVnTEVHNHBuUTJOaWdrRGFickh4c1RnWXo2QUJGYVBBa050YzdNYjZjenpj?=
 =?utf-8?B?TVFNVFNVQ3V1a2FNZ1RDNnlERHNqWm1WaFdCOTBZSUJFQ3dTWVhwdDA2dE1a?=
 =?utf-8?B?VExnM2tPR29FL0x1NWpQTFR3cDZodmlzcTNrd0VQcnREemtRbjJVcVZjd25y?=
 =?utf-8?B?SW5ac210STBLUjJybm9Nc2p1WUdKenlTTm5IZTJwMi85MXJpa2dLQUlrK0xH?=
 =?utf-8?B?SGZLQnVMK3ltRnV0bmk5OEs2Q0NRbGxhT2hMMEdnVS9rc212cllhVlZhM1M5?=
 =?utf-8?B?OUJrRTJKeWtDKzAwL2haMWVFRXpMcytOcW9OR1BZUkQwSHhHN3dMd2UrYUdh?=
 =?utf-8?B?UlFJMUZFTE5Xelo3OGpSNWpXN3lBMWVJQXV4YzRGOXRTRWdleGV3b2h3aUc0?=
 =?utf-8?B?aHRVNFZ2bGd1MFZObHBHT25WWXZvYjlTT0doUVZqaUJTZEdMK09nNUt0cGNH?=
 =?utf-8?B?emtheWZLR2Zrb2F0WVhkeDczL0ZiSCszVEFyLzVzUHZxTFp4VFJIMmtLSUh6?=
 =?utf-8?Q?owObS6e+JFA0M0hC1Mt/vw3n7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a39fa31d-624b-4ab9-6df7-08ddc20ffd95
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2025 13:20:09.4555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9LQpKZknd/0BauPnmwk1Qs2dl4UKxBv4Lh7jsJRiPGRYWQBNZBkpZGQRGW8Q1Akm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4092

On 11/07/2025 4:53, Jakub Kicinski wrote:
> Help YNL decode the values for input-xfrm by defining
> the possible values in the spec. Don't define "no change"
> as it's an IOCTL artifact with no use in Netlink.
> 
> With this change on mlx5 input-xfrm gets decoded:
> 
>  # ynl --family ethtool --dump rss-get
>  [{'header': {'dev-index': 2, 'dev-name': 'eth0'},
>    'hfunc': 1,
>    'hkey': b'V\xa8\xf9\x9 ...',
>    'indir': [0, 1, ... ],
>    'input-xfrm': 'sym-or-xor',                         <<<

I think this breaks rss_input_xfrm.py:

    input_xfrm = cfg.ethnl.rss_get(
        {'header': {'dev-name': cfg.ifname}}).get('input-xfrm')

    # Check for symmetric xor/or-xor
    if not input_xfrm or (input_xfrm != 1 and input_xfrm != 2):
        raise KsftSkipEx("Symmetric RSS hash not requested")

input_xfrm is now a string, the test is always skipped.

