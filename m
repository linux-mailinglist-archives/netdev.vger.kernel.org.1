Return-Path: <netdev+bounces-254284-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAErNroeemlS2QEAu9opvQ
	(envelope-from <netdev+bounces-254284-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:35:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B05A2D99
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B60DA3002D18
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B762935772A;
	Wed, 28 Jan 2026 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="dC8PjFl4"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011066.outbound.protection.outlook.com [52.101.65.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517B7286416;
	Wed, 28 Jan 2026 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769610888; cv=fail; b=XW1XD7AsKcliUps+RNhtFHjbyw3v8U0adutsN25iS3cQtEBWivj8rFD2DiW7x11G7PgpGehgb+Wsm18jlhEuUIvGPcMWyjrsOh2luhPs0QxHzUaAWXS040MVLsSZJd9bR7wleF4wUm90QEii4B/bnf5BdPBlS8FzL1uvRBQE2FQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769610888; c=relaxed/simple;
	bh=8D/hlBiK1IhKtktBSWbeStGwoyz+BxIaA+y82l57eXk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bBvO/DqOvJ6nxNIpSDWXrecCHAFwfXwHQ+PXzql0U2hsZNQDtxKzYtBx2vGMqkbmUEYDeGPEItMahg8yMQ6LsBaIs9iS2nLotmm0d+bSO50PD4SpKwCs+ZuFeMR721VU54jKdRSiXCbUd+Vhos62SZ1dVwqbeYZyX/PfAa3dL78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=dC8PjFl4; arc=fail smtp.client-ip=52.101.65.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iW+8geZAttcRY6u3KiU+7gLJ/TSAH8Gxmap2kvaYBSoGT/VyJcKATCsb5zqyzllQl5TfFmuyKsFIM0gnridKGc0b6osjeYIc5SShL5cBxkcicSRpRSLfHZq6yIobSQQH5MCRAX8OmlZTIXt6MV0irZgTKI1Fbf99ZYSGJb3bWIO25wchhME5a5F8nnaF4BE162xqZJwU3hqKTG2nnLnoqhCqNW1tyDqQzDWlWyopc8RPU71f79dBg+I2gKERmwt8Uqipvox37OQZ6tc3xuSi7e85Hd0bvALFtWM93bDmVlL39ea+2N2FDqKa9eOlUKPhLXilJBoVmr8eEitO15m7Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nC5csDobMApaWohfIOdvssTKIrKr2Jf5sNOX0l864Gw=;
 b=Icto4YDmgbueO8fMwh0UP8SDD7VwmEOpzKCjWzElHz5zA3epXeLTD5/MKV+x2OIfe7ntHsszZjzDNqLRh8N3Q7/hnRxg6lMO1MGFb8sdpUuX1J0M+980SuDSR411FYhGjEIrMHjqHjlsxhPRLfupFilPQBsbINAApO7s9GxiUmN3tx9BJRPzDYzPTRl6lTU4KTpK7YgyYx5nuntFoDWI6aue32QixzOCcR/cZMgKpHns1BeOmPno1G6qXm2/ehj4JwHY+zkRfuwIDt8rBRNcWZtO75IbCC/bY03dDhiu+d69a/n8ouzp2pz26hcKPk8iXgcaOae+q2Lq+X0tNt1sdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nC5csDobMApaWohfIOdvssTKIrKr2Jf5sNOX0l864Gw=;
 b=dC8PjFl43VAvtE4LR/ztcvxYuzq4uxTB+eQmb1UbNnHJWntIf6PVujttFQT1Y7jJ7WDqYiZPbC8rejsjXTsHdzCWhAQEKNtaxleLhQUW6KZ+4XmzzEiamp/3mkNIk7rOpMX59gHDiWE283d2HIu6vPgK0s8EiuSDRpbRGpEEx24P5tMfQu2irqelh6gl9ckCSjWImXVnPa2FJkEAd6YKpWOPXUMPm/Af7qlziEpG1V0h6C4+zCGBf2wrST4/XJK6Nt7pjDbrwKV8bX9sSYF4oBDcOtcgZ7xzxPI1xzQIi+nZcRPcpRCs98q6vLYxNMqkKX5/8dbVt4U3bcbS281fhw==
Received: from AM0P190CA0027.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::37)
 by DB8PR07MB6378.eurprd07.prod.outlook.com (2603:10a6:10:13f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Wed, 28 Jan
 2026 14:34:40 +0000
Received: from AM3PEPF0000A78D.eurprd04.prod.outlook.com
 (2603:10a6:208:190:cafe::7b) by AM0P190CA0027.outlook.office365.com
 (2603:10a6:208:190::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 14:34:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM3PEPF0000A78D.mail.protection.outlook.com (10.167.16.116) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Wed, 28 Jan 2026 14:34:39 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 04846236BE;
	Wed, 28 Jan 2026 16:34:37 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	parav@nvidia.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@google.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
	ast@fiberby.net,
	liuhangbin@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v12 net-next 00/15] AccECN protocol case handling series
Date: Wed, 28 Jan 2026 15:34:20 +0100
Message-Id: <20260128143435.15708-1-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A78D:EE_|DB8PR07MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ec0a67e-4d2d-4130-9873-08de5e7a5e6f
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|18082099003|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?b1d5Yi9BMEhWUHMwZ2ZmS3U1ZGtDRWpMTnk3SVdTalBkc1RoMDQwNHdwdkMr?=
 =?utf-8?B?RTIzdWUzcXAzMTlTNUhGRG1HYmVVNmZrNHFnSFhQcnR4bHdpbUp1R0xuWXJZ?=
 =?utf-8?B?TFNCam9pV0lNNTdlSkJGSkdpTVhyam90SWJjQUNBRHQxRFRUdmsrQmR6L3pa?=
 =?utf-8?B?Z1R2aytoTkVEbW5rWmExZFNqeng2RHVVZDVja21CRGpxMEcwaVF6UWNVbzdt?=
 =?utf-8?B?MTV4cnEvdEd2dFg2L3kvUXJhMEdseEd5cDRXYlpBM1diaHR3L0dQMnlkYWd6?=
 =?utf-8?B?cHl0U2ZUZ1l4ODBDSHJLb2p6K2I3d2FSdm9DaUs0Y1Z4dEZGaWxYd2FzaTV3?=
 =?utf-8?B?cktmVE9pOGM1cjhRTlpUUit3L0J6eXJhbDhWbEY5VXB2RXZIN0d5U2V4VUdt?=
 =?utf-8?B?cFdIQWFuWUVyS3lPK2ZOU1RGNDZRQk9PZjdJMEYvM0xPaFZXbVZBNzhmVWt1?=
 =?utf-8?B?SmY1UzB1MW5XR0trdmwwbjhLVnFwRWxtc3MwbVU1OW4vT3dXdXh1T1ZxUUJz?=
 =?utf-8?B?T3ZhUUx5OXEvMU1pejJWMjMwSjdLU1kyVENWcnpNRGFweHVTWUYydFNqK1Vw?=
 =?utf-8?B?dC8wUktJNU9PSkJZd2N2dmlxWHV2TnRzVWNDWVZ2TzhSaHdCOE9pNlpiUjk0?=
 =?utf-8?B?K3VFUXBXekREMmlSWHNDcW1WRlVySWhpSnVZOUl1UE95T25sRHhOVkZPZmVG?=
 =?utf-8?B?dU15d0YyREZ0VDZtQ1g1bnZhYVlObzFRT29IckdwQjJEUU9lbGFndkxFNDIy?=
 =?utf-8?B?OFJGUmdvNWlCa0RuRnljcTZDR3hBTGdMdXNzZlRmV0xiMkhjSHpPWW9xZEVI?=
 =?utf-8?B?RHNib2FCYW1zVU9BeE55T3oyc3N4SllGZ0Iram9KVWsrTDVxSHZTRHJyRnVV?=
 =?utf-8?B?VzFvVVhtVFVYcGNTQkZXRkM1NnhVWiszT2pPU3NFeXZaYlpaTHVhUmdkRE54?=
 =?utf-8?B?eTFUcW05QWcxV1haeVUrVmhKeXBjVWFkUEhoZitsQ2R1amQySFNpTFhwMWVI?=
 =?utf-8?B?WDg2c1NoR3ZDSkRBazM0dmJMR1dIcTJaRmtVZkdlUHVBLzROa29vTitXZGxp?=
 =?utf-8?B?K2ZRUHFmK3ZnTDlvekNhbWdYK2xSNUR2SVlqVGZUR3lLNmdlRmdxTUtIMXdD?=
 =?utf-8?B?MzZKV1NoNDd0RUxlNnU2amtmZUxsSmtpTHlPeHpiQmFTbThYTTlGZFZoRmdl?=
 =?utf-8?B?eGs0VUd0Y0hPOXpFTGNPbGF0T1g1aGlueEMxWm53c1NiOCt4ckRzd0haUGRD?=
 =?utf-8?B?N3hXTVdOZDFCaWsrTzIrNjFuNnAyZ040d3lHSDdqMTM4eGVxWktzK2tNTHhh?=
 =?utf-8?B?TnlYN3Mwbm8rd0hOWUN3Y0hlRFoza2lwTEZXQVYzYW1TSHRhQ1VKaXVYWE1u?=
 =?utf-8?B?S0liZzQ4YVg5VDgrbVFVLzF3MGhCdTNIdjdaNzRrWklFMXlsNWlLVmxUbVNS?=
 =?utf-8?B?bDI4RXFJT2t0TzZSbWoybzE2QkNaWkE3TG9uQXlVMXFycVpPZU0wYWZCSlE2?=
 =?utf-8?B?K1VRYmpTdDZFb0VGVXQzQkNrUnU4TDlJVWdjVWo1TUMyMmMvYnp3UlI5K1ds?=
 =?utf-8?B?a3hxbUFIeDFyUzNYM2NOckh2ZnJjQi9zcUZ6elR4YTgxRk5ud0Rla0lkQncy?=
 =?utf-8?B?NHovTExaaE5Hb3gyYlVRRHlDSkJkb0YzbVpkM1prb2J6bFYyWk93ZXZZUTcv?=
 =?utf-8?B?NEJFZjAycGpnZWhIcUZKT0IvNVNLYjFSajNMUmphZExuUEdyUDNZVGRmN0VR?=
 =?utf-8?B?RElJN1lTSERObTdLRjBHNmN0TkRhWHdUTzRVam5FZkFlbjllMklDL2NKN3hN?=
 =?utf-8?B?OVpHTWlCK2tyVGYrY0k1OWZadXpwQnhuNjgxRFFDMkl1Vmo3SkRwK1ZGMVh4?=
 =?utf-8?B?Rk5qMERMdUNoMExON25saXJ6bVZyaHVCYW02aCtzOXY2OTFiTVZDTFMxc3hP?=
 =?utf-8?B?SVBoLzVGK1NnVUpjQk5ETndQUXkwTXdoSGtkS1VqYzNlU3AwalVZV3lwVVEv?=
 =?utf-8?B?ZkVJTXZzY2FTb2pqMXF4QVJZYUk0Wm1vdUVjclJnWCt5VytJTnYyOVcxTUdW?=
 =?utf-8?B?ZEFIVUF0VnU5ZVkzeUJ3WDhTbGpOMUl0SDZVSFBkUG1TVTVOeE0xTm1MSUpB?=
 =?utf-8?B?STFmS0VGRjVtM2thYzB1VnFxMFlGYXpiUEZGME1EeW5sM1hKREZPRGRYYXFh?=
 =?utf-8?B?aDZjNTBQQ3p4ZEo3KzY5VlpGS3ovdU9aQk11YTdDK3Z3NTFLUHl3MkZyUC9I?=
 =?utf-8?Q?jZgoruw0o5qYLKBBFoko1F+rlkN6ORscThrEehQ3Co=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(18082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 pVhbWg8UUk7EbfMGDixENXSxpm1nJuoDZz/b0FzmUU9RP2bCyBPuWTI0Tl/Zp6ffaX9zmaDQ8TCbfCFLQ3e3aeF2aEJZ5iBPWdhiiZN/UILwg0FoQo+0rEPVWXiKjVm2wXGFAih3D3yXpJq0fIv7znZPCQptxsezNlNucBNkunZGziITuSkEwL3VCLarhDK7cQl+RX0ZEwcecBGwLrwvXmQFyGD3y+Ci2o+kBSBFLjXw10wQeC4ZlnQ34drS/TKyzXDCQOnDUQN5LbNk5dI7aTNAISaBhHwjo32jnvz/GPUBzsKIvFQmV1AIMNp94fkXGXShSEQI3api/kCsnppoUH+HU79JxLLnI+muGGRLqeVN/zEYHC/hQyK2zdKQLOHNXmWVYFQv1+SbvunIFguikxrUscu0mbivtTH+2O5Y5+TJPplZQ+GTODWyjtzmyk7y
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 14:34:39.5581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec0a67e-4d2d-4130-9873-08de5e7a5e6f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF0000A78D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6378
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254284-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NO_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 14B05A2D99
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Plesae find the v10 AccECN case handling patch series, which covers
several excpetional case handling of Accurate ECN spec (RFC9768),
adds new identifiers to be used by CC modules, adds ecn_delta into
rate_sample, and keeps the ACE counter for computation, etc.

This patch series is part of the full AccECN patch series, which is at
https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

Best regards,
Chia-Yu

---
v12:
- Update patch #10 to set AccECN error flag on request socket (Paolo Abeni <pabeni@redhat.com>)
- Remove new blank line at EOF of packetdrill test case in #15 (Jakub Kicinski <kuba@kernel.org>)

v11:
- Modify accecn_opt_sent_w_dsack to indicate valid prior D-SACK info in #12 (Eric Dumazet <edumazet@google.com>)
- Update timing in tcp_accecn_client_accecn_options_lost.pkt (Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>)

v10:
- Update commit message in #4, #6, #7 (Eric Dumazet <edumazet@google.com>)
- Set AccECN error flag on request itself via tcp_rsk() to avoid directly chaning on listener (Eric Dumazet <edumazet@google.com>)
- Mover new tcp_info fields at the end of struct (Eric Dumazet <edumazet@google.com>)
- Update timing in tcp_accecn_client_accecn_options_lost.pkt (Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>)

v9:
- Add 1 patch for 2-bit tcpi_ecn_mode and 24-bit tcpi_options by reducing bits used by tcpi_accecn_fail_mode and tcpi_accecn_opt_seen in tcp_info (Neal Cardwell <ncardwell@google.com>)
- Add missing comma in patch #3 (Jakub Kicinski <kuba@kernel.org>)
- Update patch message of patch #15

v8:
- Add apcketdrill patch #14 into this series (Paolo Abeni <pabeni@redhat.com> & Jakub Kicinski <kuba@kernel.org>)
- Add helper function in patch #10 (Paolo Abeni <pabeni@redhat.com>)

v7:
- Update comments in #3 (Paolo Abeni <pabeni@redhat.com>)
- Update comments and use synack_type TCP_SYNACK_RETRANS and num_timeout in #9. (Paolo Abeni <pabeni@redhat.com>)

v6:
- Update comment in #3 to highlight RX path is only used for virtio-net (Paolo Abeni <pabeni@redhat.com>)
- Rename TCP_CONG_WANTS_ECT_1 to TCP_CONG_ECT_1_NEGOTIATION to distiguish from TCP_CONG_ECT_1_ESTABLISH (Paolo Abeni <pabeni@redhat.com>)
- Move TCP_CONG_ECT_1_ESTABLISH in #6 to latter patch series (Paolo Abeni <pabeni@redhat.com>)
- Add new synack_type instead of moving the increment of num_retran in #9 (Paolo Abeni <pabeni@redhat.com>)
- Use new synack_type TCP_SYNACK_RETRANS and num_retrans for SYN/ACK retx fallbackk for AccECN in #10 (Paolo Abeni <pabeni@redhat.com>)
- Do not cast const struct into non-const in #11, and set AccECN fail mode after tcp_rtx_synack() (Paolo Abeni <pabeni@redhat.com>)

v5:
- Move previous #11 in v4 in latter patch after discussion with RFC author.
- Add #3 to update the comments for SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN. (Parav Pandit <parav@nvidia.com>)
- Add gro self-test for TCP CWR flag in #4. (Eric Dumazet <edumazet@google.com>)
- Add fixes: tag into #7 (Paolo Abeni <pabeni@redhat.com>)
- Update commit message of #8 and if condition check (Paolo Abeni <pabeni@redhat.com>)
- Add empty line between variable declarations and code in #13 (Paolo Abeni <pabeni@redhat.com>)

v4:
- Add previous #13 in v2 back after dicussion with the RFC author.
- Add TCP_ACCECN_OPTION_PERSIST to tcp_ecn_option sysctl to ignore AccECN fallback policy on sending AccECN option.

v3:
- Add additional min() check if pkts_acked_ewma is not initialized in #1. (Paolo Abeni <pabeni@redhat.com>)
- Change TCP_CONG_WANTS_ECT_1 into individual flag add helper function INET_ECN_xmit_wants_ect_1() in #3. (Paolo Abeni <pabeni@redhat.com>)
- Add empty line between variable declarations and code in #4. (Paolo Abeni <pabeni@redhat.com>)
- Update commit message to fix old AccECN commits in #5. (Paolo Abeni <pabeni@redhat.com>)
- Remove unnecessary brackets in #10. (Paolo Abeni <pabeni@redhat.com>)
- Move patch #3 in v2 to a later Prague patch serise and remove patch #13 in v2. (Paolo Abeni <pabeni@redhat.com>)

---
Chia-Yu Chang (13):
  selftests/net: gro: add self-test for TCP CWR flag
  tcp: ECT_1_NEGOTIATION and NEEDS_ACCECN identifiers
  tcp: disable RFC3168 fallback identifier for CC modules
  tcp: accecn: handle unexpected AccECN negotiation feedback
  tcp: accecn: retransmit downgraded SYN in AccECN negotiation
  tcp: add TCP_SYNACK_RETRANS synack_type
  tcp: accecn: retransmit SYN/ACK without AccECN option or non-AccECN
    SYN/ACK
  tcp: accecn: unset ECT if receive or send ACE=0 in AccECN negotiaion
  tcp: accecn: fallback outgoing half link to non-AccECN
  tcp: accecn: detect loss ACK w/ AccECN option and add
    TCP_ACCECN_OPTION_PERSIST
  tcp: accecn: add tcpi_ecn_mode and tcpi_option2 in tcp_info
  tcp: accecn: enable AccECN
  selftests/net: packetdrill: add TCP Accurate ECN cases

Ilpo Järvinen (2):
  tcp: try to avoid safer when ACKs are thinned
  gro: flushing when CWR is set negatively affects AccECN

 Documentation/networking/ip-sysctl.rst        |   4 +-
 .../networking/net_cachelines/tcp_sock.rst    |   1 +
 include/linux/tcp.h                           |   4 +-
 include/net/inet_ecn.h                        |  20 +++-
 include/net/tcp.h                             |  32 +++++-
 include/net/tcp_ecn.h                         | 103 ++++++++++++------
 include/uapi/linux/tcp.h                      |  26 ++++-
 net/ipv4/inet_connection_sock.c               |   3 +
 net/ipv4/sysctl_net_ipv4.c                    |   4 +-
 net/ipv4/tcp.c                                |  10 ++
 net/ipv4/tcp_cong.c                           |   5 +-
 net/ipv4/tcp_input.c                          |  40 ++++++-
 net/ipv4/tcp_minisocks.c                      |  43 +++++---
 net/ipv4/tcp_offload.c                        |   3 +-
 net/ipv4/tcp_output.c                         |  32 ++++--
 net/ipv4/tcp_timer.c                          |   3 +
 tools/testing/selftests/drivers/net/gro.c     |  81 ++++++++++----
 tools/testing/selftests/drivers/net/gro.py    |   3 +-
 .../tcp_accecn_2nd_data_as_first.pkt          |  24 ++++
 .../tcp_accecn_2nd_data_as_first_connect.pkt  |  30 +++++
 .../tcp_accecn_3rd_ack_after_synack_rxmt.pkt  |  19 ++++
 ..._accecn_3rd_ack_ce_updates_received_ce.pkt |  18 +++
 .../tcp_accecn_3rd_ack_lost_data_ce.pkt       |  22 ++++
 .../net/packetdrill/tcp_accecn_3rd_dups.pkt   |  26 +++++
 .../tcp_accecn_acc_ecn_disabled.pkt           |  13 +++
 .../tcp_accecn_accecn_then_notecn_syn.pkt     |  28 +++++
 .../tcp_accecn_accecn_to_rfc3168.pkt          |  18 +++
 .../tcp_accecn_client_accecn_options_drop.pkt |  34 ++++++
 .../tcp_accecn_client_accecn_options_lost.pkt |  38 +++++++
 .../tcp_accecn_clientside_disabled.pkt        |  12 ++
 ...cecn_close_local_close_then_remote_fin.pkt |  25 +++++
 .../tcp_accecn_delivered_2ndlargeack.pkt      |  25 +++++
 ..._accecn_delivered_falseoverflow_detect.pkt |  31 ++++++
 .../tcp_accecn_delivered_largeack.pkt         |  24 ++++
 .../tcp_accecn_delivered_largeack2.pkt        |  25 +++++
 .../tcp_accecn_delivered_maxack.pkt           |  25 +++++
 .../tcp_accecn_delivered_updates.pkt          |  70 ++++++++++++
 .../net/packetdrill/tcp_accecn_ecn3.pkt       |  12 ++
 .../tcp_accecn_ecn_field_updates_opt.pkt      |  35 ++++++
 .../packetdrill/tcp_accecn_ipflags_drop.pkt   |  14 +++
 .../tcp_accecn_listen_opt_drop.pkt            |  16 +++
 .../tcp_accecn_multiple_syn_ack_drop.pkt      |  28 +++++
 .../tcp_accecn_multiple_syn_drop.pkt          |  18 +++
 .../tcp_accecn_negotiation_bleach.pkt         |  23 ++++
 .../tcp_accecn_negotiation_connect.pkt        |  23 ++++
 .../tcp_accecn_negotiation_listen.pkt         |  26 +++++
 .../tcp_accecn_negotiation_noopt_connect.pkt  |  23 ++++
 .../tcp_accecn_negotiation_optenable.pkt      |  23 ++++
 .../tcp_accecn_no_ecn_after_accecn.pkt        |  20 ++++
 .../net/packetdrill/tcp_accecn_noopt.pkt      |  27 +++++
 .../net/packetdrill/tcp_accecn_noprogress.pkt |  27 +++++
 .../tcp_accecn_notecn_then_accecn_syn.pkt     |  28 +++++
 .../tcp_accecn_rfc3168_to_fallback.pkt        |  18 +++
 .../tcp_accecn_rfc3168_to_rfc3168.pkt         |  18 +++
 .../tcp_accecn_sack_space_grab.pkt            |  28 +++++
 .../tcp_accecn_sack_space_grab_with_ts.pkt    |  39 +++++++
 ...tcp_accecn_serverside_accecn_disabled1.pkt |  20 ++++
 ...tcp_accecn_serverside_accecn_disabled2.pkt |  20 ++++
 .../tcp_accecn_serverside_broken.pkt          |  19 ++++
 .../tcp_accecn_serverside_ecn_disabled.pkt    |  19 ++++
 .../tcp_accecn_serverside_only.pkt            |  18 +++
 ...n_syn_ace_flags_acked_after_retransmit.pkt |  18 +++
 .../tcp_accecn_syn_ace_flags_drop.pkt         |  16 +++
 ...n_ack_ace_flags_acked_after_retransmit.pkt |  27 +++++
 .../tcp_accecn_syn_ack_ace_flags_drop.pkt     |  26 +++++
 .../net/packetdrill/tcp_accecn_syn_ce.pkt     |  13 +++
 .../net/packetdrill/tcp_accecn_syn_ect0.pkt   |  13 +++
 .../net/packetdrill/tcp_accecn_syn_ect1.pkt   |  13 +++
 .../net/packetdrill/tcp_accecn_synack_ce.pkt  |  27 +++++
 ..._accecn_synack_ce_updates_delivered_ce.pkt |  22 ++++
 .../packetdrill/tcp_accecn_synack_ect0.pkt    |  24 ++++
 .../packetdrill/tcp_accecn_synack_ect1.pkt    |  24 ++++
 .../packetdrill/tcp_accecn_synack_rexmit.pkt  |  15 +++
 .../packetdrill/tcp_accecn_synack_rxmt.pkt    |  25 +++++
 .../packetdrill/tcp_accecn_tsnoprogress.pkt   |  26 +++++
 .../net/packetdrill/tcp_accecn_tsprogress.pkt |  25 +++++
 76 files changed, 1678 insertions(+), 102 deletions(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_2nd_data_as_first.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_2nd_data_as_first_connect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_after_synack_rxmt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_ce_updates_received_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_lost_data_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_dups.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_acc_ecn_disabled.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_accecn_then_notecn_syn.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_accecn_to_rfc3168.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_client_accecn_options_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_client_accecn_options_lost.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_clientside_disabled.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_close_local_close_then_remote_fin.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_2ndlargeack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_falseoverflow_detect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_largeack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_largeack2.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_maxack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_updates.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_ecn3.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_ecn_field_updates_opt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_ipflags_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_listen_opt_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_multiple_syn_ack_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_multiple_syn_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_bleach.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_connect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_listen.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_noopt_connect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_optenable.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_no_ecn_after_accecn.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_noopt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_noprogress.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_notecn_then_accecn_syn.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_rfc3168_to_fallback.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_rfc3168_to_rfc3168.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_sack_space_grab.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_sack_space_grab_with_ts.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_accecn_disabled1.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_accecn_disabled2.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_broken.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_ecn_disabled.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_only.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ace_flags_acked_after_retransmit.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ace_flags_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ack_ace_flags_acked_after_retransmit.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ack_ace_flags_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ect0.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ect1.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ce_updates_delivered_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ect0.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ect1.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_rexmit.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_rxmt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_tsnoprogress.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_tsprogress.pkt

-- 
2.34.1


