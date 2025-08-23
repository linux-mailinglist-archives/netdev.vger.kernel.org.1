Return-Path: <netdev+bounces-216212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97056B328FC
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 16:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 532551B6832C
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 14:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DD0246326;
	Sat, 23 Aug 2025 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="bLcvBQEd";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="bLcvBQEd"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021123.outbound.protection.outlook.com [52.101.70.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C965324500A;
	Sat, 23 Aug 2025 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.123
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755957868; cv=fail; b=r/15G5pbNAY67nWSyQ7DPitWkwe18eBWOpM+zSaxLzpaVKrv3W6u/gn3zzspDEccQNMyT3gNgTYXz5J3HtbFLKl3qChe7fnwiGufw/98qM3KcMVE6Fbpz8SHGJth9eSsvmoplk/fWRrRmG0DfrirKLj40qsMbW5yD0X4TKVr+Tg=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755957868; c=relaxed/simple;
	bh=own6X2o3CNPjIf7/ii7zOibV1WTDjbfKa8oAlENdtuQ=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=RIxQm6l0U8u8l2cf0ENCw7P9toDaLBecBFGlnXPgUMBknoT9tC+GbxV+6/C4GLd5zOUIImIjqz1w48MHAKohtbn+ZxorLifgTVUuIMtyBPHpCZDc5aGfEDRyqGll9nbwhOR5Rqf0MOlZnaZMymgrpsZxPE2zb5SlHiEqWYDVAao=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=bLcvBQEd; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=bLcvBQEd; arc=fail smtp.client-ip=52.101.70.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Ox96QA0fq8o7Zg+dFZ91Y/y/5aTansFuo8ahciWQ7Vh2wgtdVJwQayYeP9cfdxTGzEdgaKVY+d7AZGc+LpActpTLQS151iFJpGam/5sxa1BQI5Y6qPOGQpS30AOwwDWyK5smrnEoLmwPLbJfMKiemEUT80WY/qIqEcfchh1zpy7XM1BXoag54biFftg6yEMZxpFn0FlORtxMOcsFGzJ251+R/x8ULBmpPRAflSoNOe399kLRg4y7CFQqCYoVJta02FMev0rNgUgLylCZtgcIcBrs6KOy7CKX+99WQwISBB/3zO5+bXj5BVLe7WADiKrnZv/zjD8xAok0pYyQYkPybA==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQK1lBeCc/0ugb5+7/moJkDzuBtmAiVUN3sF0IKtNs4=;
 b=fao+y8uSEktctUZ3Q+SwHusQOWSf1qI/oWup4F2THc1RsV1NA/WCV4vqpmv8swI0OcXVwYsfzEn+xWmbU7QDdQRstbHgNaFNdJb/+rQGrpb3pf7cgdFtsJw8PD7+T82N6KWqkIU6Ty1KqIike3yjuZ60qSzaWFeCbr/oqaOiUiKCfqsW5XqkZyeECudYVnt0Hw7eJ9+giT6YbdfrpZQP4padk791xNFn5sChPEfuIs195Vr69UcuMMJ8ppXQmuXpMpV515npW55mAAvTLxH8WcVlnot2WVQIkex8xffbKmkBEmPJuwdTo1lz1scs27mTYjpafFKp8qOVkLP5irx+gA==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQK1lBeCc/0ugb5+7/moJkDzuBtmAiVUN3sF0IKtNs4=;
 b=bLcvBQEddGNeoLK6IxbnNOKYWhsN1f1sZSZFEG+f19t4GMEAYVyYYbURdvoRF01cMUrs8AUd8eiFxUb7ZBE+ZIi/7xLblQNdgKDn8X3USM6P9rE+sxEfe7FueaYBpopRWa5QC/wJL7mPWmLJvYk+pqQfs1Tpvh/lydD3i7VU08E=
Received: from PR1P264CA0011.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19e::16)
 by GV1PR04MB10127.eurprd04.prod.outlook.com (2603:10a6:150:1ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Sat, 23 Aug
 2025 14:04:20 +0000
Received: from AMS1EPF0000004A.eurprd04.prod.outlook.com
 (2603:10a6:102:19e:cafe::e6) by PR1P264CA0011.outlook.office365.com
 (2603:10a6:102:19e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Sat,
 23 Aug 2025 14:04:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS1EPF0000004A.mail.protection.outlook.com (10.167.16.134) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.8
 via Frontend Transport; Sat, 23 Aug 2025 14:04:19 +0000
Received: from emails-2415305-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-236.eu-west-1.compute.internal [10.20.6.236])
	by mta-outgoing-dlp-467-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 426E77FEF8;
	Sat, 23 Aug 2025 14:04:19 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com; arc=pass;
  dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1755957859; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=LQK1lBeCc/0ugb5+7/moJkDzuBtmAiVUN3sF0IKtNs4=;
 b=WgW9dYd8gSOC6Eo7NvobsVwqJeBs52VggaKm1g+0z9/9z+bcxvvYmickvFFO1Wf4IP600
 Hv+HEoSOuFSIT0F9oNqzx05bdjOfhEgloz/Id81bTVz0CXxntQJk/21fYLnkLtsy2w5q+02
 +wB64OUCBYPgWfItsCcZGv3fy7GVl6Y=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1755957859;
 b=e/FbL5e2oHmK9Y+Xg9aKOTTS55O4+I+V4QTitFfq7Ha7bXbXsC2O8MbmRHSfw/1FG4qxr
 VMhkEcmHLsRTxwQ9quCU6svnWbETCTCnNxYI4YLnsCYj2QoMrzkSWJ9tazDWfeYjVzlCk3z
 o3Ae2iR6Q2zlSW+LJF7RGdDx79BBJ18=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJ+x19qtZ6Ux6+T76kAT5ku6poYOAi+khbe3qC7JGK4pI2hcw6QjUp3jlJv1ktulzGL9lMlZLHR/acGBU3+G/WhfWCK+RBaRpnhgdYkDn7TcQ/ihiaXw9xswhiECslYxQGFApGuvDIeKKYQo0KonrQVa1nZL/cc6ZaSBWnFlCkf/zGJlD7HH6jZDgDL7wV0fuaRkiBOYohX6h6aj/7Epolh2vTNGz29Inciu6Eh0z+W/45CmfeAx/jOj6SmF8v7xuimsc33dXJzBxWCBrKxU630nw4HF0ARj/HB1OL70VD//c4u6ggY27hNcs2RcsahTEwllut3M39XvhlYcQiG9ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQK1lBeCc/0ugb5+7/moJkDzuBtmAiVUN3sF0IKtNs4=;
 b=FiX89GyV/iwf0t9S2upxgeNZrFlTQszkkZ6D/T14X0VQjndJdJTdu/yjmnxfGr2T88IpPmaBZ2p+WIWODpohoa4D49tdShdroZwlMMI9B4SHcRg/4BaYtU8nhSDsioX0BHGfzQbHeigNc4UZmsS/79ReTo7w2Ya+/VQVGgarW/Gh6EYrtU3nshkekdtNsPJwDweazwsAkg1UUA7DRe+iaiEdbnmLYeg0ergNlHeoJpvwH57TEy5kgJK13d/ht6cVXMjCy8ykpdDJr/lQu8YrFGQ0AiY+yzHvjD90wVdhgCZrjSbB3V7OP4rsWKMas8U5DEoxVE9VkkMUzWnQZRr2tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQK1lBeCc/0ugb5+7/moJkDzuBtmAiVUN3sF0IKtNs4=;
 b=bLcvBQEddGNeoLK6IxbnNOKYWhsN1f1sZSZFEG+f19t4GMEAYVyYYbURdvoRF01cMUrs8AUd8eiFxUb7ZBE+ZIi/7xLblQNdgKDn8X3USM6P9rE+sxEfe7FueaYBpopRWa5QC/wJL7mPWmLJvYk+pqQfs1Tpvh/lydD3i7VU08E=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by DBAPR04MB7223.eurprd04.prod.outlook.com (2603:10a6:10:1a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Sat, 23 Aug
 2025 14:04:09 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9073.009; Sat, 23 Aug 2025
 14:04:09 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sat, 23 Aug 2025 16:03:12 +0200
Subject: [PATCH RFC net-next] net: phy: marvell: 88e1111: define gigabit
 features
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250823-cisco-1g-sfp-phy-features-v1-1-3b3806b89a22@solid-run.com>
X-B4-Tracking: v=1; b=H4sIAB/KqWgC/x2MQQ6CMBAAv0L27CZLFQGvJj7Aq+FA2i3spTTda
 jCEv1s8ziQzGygnYYVbtUHij6gsoUB9qsDOY5gYxRUGQ6ahzpzRitoF6wnVR4zzFz2P+Z1Y0VJ
 /JddfGkctlD4m9rL+3y94Pu6HC5wx8Jph2PcfqaZe2XwAAAA=
X-Change-ID: 20250823-cisco-1g-sfp-phy-features-c0960d945d07
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: FR2P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::18) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|DBAPR04MB7223:EE_|AMS1EPF0000004A:EE_|GV1PR04MB10127:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b379798-4469-41d6-15cb-08dde24df45d
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?VEF2VE44YXN3TFhZM3VPN1h3bGxvMHhwUHYxNzJTRGhGUnlLMzdSaXMyT0Vq?=
 =?utf-8?B?Wkg0K3RGZldtTFoyZEg2K25UVkxwM0hxekhydThHU0trOHJXYmZEQmVkNlpM?=
 =?utf-8?B?bmdvUVg4V1hBK08yTWx2MmhYOXNTUy80SEE4UGtZVEUrY3lwVkNMemVPVGZU?=
 =?utf-8?B?c0V5Kyt6ejBscU5ESzBlc1ZUYjhUNXdVbisxZUJ0MW11eUdYOHhmalRZeDRX?=
 =?utf-8?B?YTd5aUNPYjVIczdwQXhDMWZiQ1FRdkpIRkFlSTQ1K2RuVjlrc3JCdEk3Y3lN?=
 =?utf-8?B?NmtrRXNCYlBYS09YbG5NcytPajVyYUYvMlhUZTFFQXIzaXFGSjV6blpBc1l5?=
 =?utf-8?B?cGczWGdVZWw2eHB6N0ttaFpDN1NtL09icWRIS0VYeWdmWFpPUGkrWHVEanZ1?=
 =?utf-8?B?aXZDUUZ4dHg0azNOaG4va3NwckVuUWdLUVluc3VwbjY2aCt3cEhRRE5PV3Bz?=
 =?utf-8?B?cnJqUXUyZTZpQlR2VWdGaVc3TXlkU3FBNkQ0V3RoTGVRYk1uMUNQbnVzZ3dD?=
 =?utf-8?B?clFDVGUzbTBEY1RTTUdsQVlDN0VhVDNDOUV6WUMrVi85YnpTTVRDUmhYVTcz?=
 =?utf-8?B?RytmeU5uWHd0WlMxc2x1dWpocExLVzMvUTc0WHpKNXlNWWVmME9EczMrMjNR?=
 =?utf-8?B?ZGs3SHZTTUhRbllMWXpDaGE4Qit3UlovNU9JMDl0ZmVUaVMyVnBnb3F3TFFo?=
 =?utf-8?B?YlJOcWZRaGpnbDlYblBRTjRCeVh5V3IzSFhYS2VhNXdScmNsSThzUk9qcE9P?=
 =?utf-8?B?VWp4K29MTmpFWEpESGhEaDRUdHY1RGswTVE4TWc2N3RoUHdrUHhkQzVza0JB?=
 =?utf-8?B?clFkYi9FVGpOcjFOREF1YU1SbWFYRXltS1dKZk4rS2dMaHZIWDVKRU1YVjZs?=
 =?utf-8?B?LzUrWGx2WFEvVTIyVnJWYmFKVEpEeGVhNXQybWxrR0ZNdWlpMmVPQzRxYzRG?=
 =?utf-8?B?aS94M0YrVWx3cjEyUkRCSTc0TkhwdytHZE9CS1VOZ1I4NTh6YVUzMmU1VkZh?=
 =?utf-8?B?VG4rNkd3a1Fxbkl6djBSNVRuclFaTDdWbzVQZmgzNXFybzB3ekY4MmxJMGUz?=
 =?utf-8?B?c1dRV2srd3pQSTJacVNGbHREVzBVL1JXbkM0WEhLemFwWTErNG8yRzBlZERY?=
 =?utf-8?B?aE9lVTRKTkxJT0F4cGtlUlFFZjBHVVJkYWZldU0vTVRwQzAvQmU5czNTVnlx?=
 =?utf-8?B?WitSaDRtb0tZTDJsa0xDd0cyb09DQ29OSWFTZzJoUFhJNkJHTFBNLzlKYWpm?=
 =?utf-8?B?dlVsUEdBRldyQWJZV0c1WStPekFqL2NpbGxEVG5Rc2ttTDQzcENlK0NDR01j?=
 =?utf-8?B?Q2xneUJLbWVzSDNoUTYycmozZ085cWxtMW5LT0VaTE9uTlNUMDF4WVk1aEU2?=
 =?utf-8?B?TUkzUXkrVmxJVDdETm9GNzQreGpmTmVUM0ZJYytIRWgwN2hwcWZqVVhzSXhz?=
 =?utf-8?B?WVdiWklTcFVMSVhQaFhjbzA0dTMrYnh1aFk4cnFXZVRmTkowM0tZTWlNVTFL?=
 =?utf-8?B?VTVwWG1KWGRjOHdYOEQrWFNOSzhSU0hCTVE3U0JmZnBUb2s2b3R3NG1teTM1?=
 =?utf-8?B?UkdnZU1RRTZBcFMwN1dxNXdWYlVnNVY3ZFJtN1llWnZsUG5WbkZlTlJ0MUt5?=
 =?utf-8?B?Zy95N2lTZjZ2SFhxM29oZ0lwdy9XdXRyU0FwNXVXYWJpN1F1WStXNW5pemxX?=
 =?utf-8?B?WWJDbUNYenY0OWwzNGI4SUNUclBoTGlRcEJER2FkVGZ2azFXSlM5eDBwZ3M3?=
 =?utf-8?B?czZ0Vi9rMWErRjVyYVBsU01jb28yYzBIaWpGRUZSWmRVeXExQjRYbmhzNWll?=
 =?utf-8?B?eWZaTGtJbEJMNU1Tdzk1MDM2Sk5FakJqUVVYNDFKenpDUTRmMUtyTmJ4dWRa?=
 =?utf-8?B?dWlDWXhsMmFmdU1taCtIYm1tbEFEVEwzbjZYYkFnaktneWJDbng1dERIKzJ0?=
 =?utf-8?B?MTFMdFExaVVDV3R0OW13N0EzSFFERGJscmhUZ2VDTllpbGVtaTNvM3VXWmpH?=
 =?utf-8?B?SXFCTTIyMzVBPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7223
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: c5d8807fc23c4e798ed3fe715c4d6030:solidrun,office365_emails,sent,inline:3543046d6dcd52ebe74ff387f2f8ac99
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF0000004A.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	618ca881-9cb5-4220-da9e-08dde24dee2b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|14060799003|376014|7416014|36860700013|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzJmNXc3ZDN0OGNkQjl0RUI5SjV3cVFHUDZndlF4RkdZN0NtU0x0RjlqUC9V?=
 =?utf-8?B?TFViWURGc2N3NmpCOE5nc00vUVhCYlJUWG5xYVQwWk8vSW1PRFY4OEJVSi9T?=
 =?utf-8?B?SnF1UnZIUGVhQnpZMGs0YUFPMi9zK3U1NTh0V1pneW9lSXRjYmFObHVDdGF1?=
 =?utf-8?B?WTRKWFgvN2tENjNJSUtnQXFvbHVmRHRQVzYvT3lXQ0thS0NNV1VmQlduREVB?=
 =?utf-8?B?TVphWjBUdDk5ZHpXNXNzbndKQlhsMkNJbWdRdnNHSy9aU0FVQ2dxS1ZKKy9F?=
 =?utf-8?B?VUpRelEyUlFrTk04aURVOU9TU2QxS2l4bWh1R0tRRWhXekdYd3R5ZXNyMWN3?=
 =?utf-8?B?aW1TV1J5cnZnM3BoM0dxN3pid2g3eUozdXZhWGROUVR0MFBJb0k4V1kvMEpx?=
 =?utf-8?B?TnZ4QUcvUGpBMnBKUVhIRHd4T3dIakpNc2xrWUxuYjdWN3M2T1VHTERSY1k0?=
 =?utf-8?B?NlozYkFKU1pyWmJMNGxBUVJFMVUyL1RCc3JzWVd3UFZpL285WkxuVmRoNkpO?=
 =?utf-8?B?VWJSODJlZUY3cFRsbU9lN01seFRaQjFzdjVpOG1KNUdFT0JkNmhDVHpsSi9i?=
 =?utf-8?B?cTh1NFJNeXRZWmxkSG5jUWtCQXJ0NnVibktIVkF5ZDRiZmVvaE5JZHdKTE0r?=
 =?utf-8?B?VnVaclJnUlA1dFpHdERZdE1ZdWVhc0pKellldGF6WGJxUm11Z2xSNmp1U1Uy?=
 =?utf-8?B?bDBoaTNEMkZ3YzNSRGJzYm0wVmZSVWc1cWtHaGhETVpJc2lyRldPZ0twSzg0?=
 =?utf-8?B?NUtKcVVKbzZLc08yb1BCbWZia0N2NlFmSmJ5L3hmcy9MK0RRb3JOQ1BlMGpB?=
 =?utf-8?B?VG1LOW9FTFovN1JVMUFiY2FTMm1DdjcyYWJkaHQ2R3gvNW03T2gyMUwvWUFj?=
 =?utf-8?B?OGN2TFdCaUQ4VXdVeG5FR0FsdHZYZ2ZJTktrR0E3dVlGRlBuR1dzT0l4UnY4?=
 =?utf-8?B?WmlWV1FkUnowZDNKQmdxZm1HS0lCeVUwWTQzcElleVM0Z3cyMzNVSzBSeEtB?=
 =?utf-8?B?c3RFQkEzNWtFSGNHODZqWkovY1FOU1dCQ29ia3dDVGhGSVhCZEFGUFpJWGJ5?=
 =?utf-8?B?eUZFTzZpZHNkNTAyNXJ5ajZhY1MvajNRUnR0dksvN2JaY3VwSE5hNytZbWcv?=
 =?utf-8?B?bStBNEoxSUViQUgwak9TMnBXVHpCNDE5N1NJa2FJWkQxbGZ0OEJKL3prZDR1?=
 =?utf-8?B?QURFbXpOS25kNjdHTllKdFlKVFJKN1JiWlFacnNWTHhHSXBnQWpzR1dDTCs4?=
 =?utf-8?B?Y3hPVHNlbi9WYjBLTVQwQXlINnZHRS9IN0FTdEU1cDZJMmZoMzlJamhBQXBZ?=
 =?utf-8?B?WHI5d0UzT0Fhc2RCbyt1VUl4WmNvS3g3ejM2Nkhad2s1RjZ0Y2p0L3JRc1po?=
 =?utf-8?B?Tmhia3BZRjV3bW9IL3pWazhHWURpQ1JaNCtJTmJvTkNJTWhSeS9ha1NHUGtO?=
 =?utf-8?B?VkFtYk9LMkR2VVp1WVpwNThGV2YxNUJJVXp1ZUFOTUlGT2hlVlllN0Rrb0s2?=
 =?utf-8?B?OXVGSnBNK25HYXlDZkc4YVlQMUtKbGVydXhsVGswbDZzQVRwemh1RVdWajBM?=
 =?utf-8?B?QnduZ2xWVlVKRXNyVnAzekVib1JVcGdDWWZmOUZkdXZrVUpmQlppQXFENWxT?=
 =?utf-8?B?SmJnTTNKSk5ROEN3bjIvVVpNMlB2dlFEQmlyUkhJOEVQcWtOU21MUHFqdTQ0?=
 =?utf-8?B?ZmtUUUZFTUQzUjBvUDBYS2w5ajJiK2hlS2dLRldaSVZzdTZ0RG5lNDVFMjhU?=
 =?utf-8?B?QlhTVGd3MXFFUzZZRG5uRWd6dmppY01jdVlqY3JiSmNvdU1MZElBVjlWaGtE?=
 =?utf-8?B?czRQM0VWZFBQSi9udTArL2dGNDIwNDZMU0tJWTd0U3o2Nzl5QitjRmhFaGdS?=
 =?utf-8?B?ZlZMcE4rNnFKaVV2cDhYUVlha2h0aTloSGdMTVk4REMvNGNTeHEydVVEN3Rq?=
 =?utf-8?B?S2FBRWxIekkvUE50OEJmeHk5cDAzMm9pK0hLM2pHTFhzMGtoY0dORERCbkhK?=
 =?utf-8?B?NmJxN1VvdGhleVQ0Lzd1dzczSnV5Y1F4V0szNDR1Y1VxcFhSUVVIcmg2eVRv?=
 =?utf-8?Q?XoSRko?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(14060799003)(376014)(7416014)(36860700013)(35042699022);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 14:04:19.5686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b379798-4469-41d6-15cb-08dde24df45d
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10127

When connecting RJ45 SFP modules to Linux an ethernet phy is expected -
and probed on the i2c bus when possible. Once the PHY probed, phylink
populates the supported link modes for the netdev based on bmsr
register bits set at the time (see phy_device.c: phy_probe).

Marvell phy driver probe function only allocates memory, leaving actual
configuration for config_init callback.
This means the supported link modes of the netdev depend entirely on the
power-on status of the phy bmsr register.

Certain Cisco SFP modules such as GLC-T and GLC-TE have invalid
configuration at power-on: MII_M1111_HWCFG_MODE_COPPER_1000X_AN
This means fiber with automatic negotiation to copper. As the module
exhibits a physical RJ45 connector this configuration is wrong.
As a consequence after power-on the bmsr does not set bits for 10/100
modes.

During config_init marvell phy driver identifies the correct intended
MII_M1111_HWCFG_MODE_SGMII_NO_CLK which means sgmii with automatic
negotiation to copper, and configures the phy accordingly.

At this point the bmsr register correctly indicates support for 10/100
link modes - however the netedev supported modes bitmask is never
updated.

Hence the netdev fails to negotiate or link-up at 10/100
speeds, limiting to 1000 links only.

Explicitly define features for 88e1111 phy to ensure that all supported
modes are available at runtime even when phy power-on configuration was
invalid.

[1] known functional 1Gbps RJ45 SFP module with 88E1111 PHY
[   75.117858] sfp c2-at-sfp: module LINKTEL          LX1801CNR        rev 1.0  sn 1172623934       dc 170628
[   75.127723] drivers/net/phy/sfp-bus.c:284: sfp_parse_support: 1000baseT_Half
[   75.134779] drivers/net/phy/sfp-bus.c:285: sfp_parse_support: 1000baseT_Full
[   75.141831] phylink_sfp_module_insert: sfp_may_have_phy - delaying phylink_sfp_config
[   75.204100] drivers/net/phy/phy_device.c:2942: phy_probe
[   75.212828] drivers/net/phy/phy_device.c:2961: phy_probe: phydev->drv->probe
[   75.228017] drivers/net/phy/phy_device.c:2983: phy_probe: genphy_read_abilities
[   75.246019] drivers/net/phy/phy_device.c:2502: genphy_read_abilities: MII_MARVELL_PHY_PAGE: 0x00
[   75.263045] drivers/net/phy/phy_device.c:2507: genphy_read_abilities: MII_BMSR: 0x7949
[   75.279282] sfp_add_phy
[   75.287150] phylink_sfp_connect_phy: calling phylink_sfp_config with phy settings
[   75.302778] drivers/net/phy/sfp-bus.c:445: sfp_select_interface: PHY_INTERFACE_MODE_SGMII
[   75.302778]
[   75.320600] m88e1111_config_init
[   75.334333] drivers/net/phy/marvell.c:905: m88e1111_config_init: MII_M1111_PHY_EXT_SR: 0x8084
[   75.348694] m88e1111_config_init: sgmii
[   75.364329] drivers/net/phy/marvell.c:787: m88e1111_config_init_hwcfg_mode: MII_M1111_PHY_EXT_SR: 0x8084
[   75.450737] fsl_dpaa2_eth dpni.0 eth0: PHY [i2c:c2-at-sfp:16] driver [Marvell 88E1111] (irq=POLL)
[   75.461329] sfp_sm_probe_for_phy: tried to probe clause 22 phy: 0
[   75.461333] phy detected after 0 retries
Settings for eth0:
        Supported ports: [ TP MII FIBRE ]
        Supported link modes:   10baseT/Full
                                100baseT/Full
                                1000baseT/Full
        Supports auto-negotiation: Yes
        Advertised link modes:  10baseT/Full
                                100baseT/Full
                                1000baseT/Full
        Advertised pause frame use: Symmetric Receive-only
        Advertised auto-negotiation: Yes
[   77.445537] sfp c2-at-sfp: module removed

[2] problematic 1Gbps RJ45 SFP module with 88E1111 PHY before this patch
[   84.463372] sfp c2-at-sfp: module CISCO-AVAGO      ABCU-5710RZ-CS2  rev      sn AGM1131246C      dc 070803
[   84.473218] drivers/net/phy/sfp-bus.c:284: sfp_parse_support: 1000baseT_Half
[   84.480267] drivers/net/phy/sfp-bus.c:285: sfp_parse_support: 1000baseT_Full
[   84.487314] sfp c2-at-sfp: Unknown/unsupported extended compliance code: 0x01
[   84.487316] phylink_sfp_module_insert: sfp_may_have_phy - delaying phylink_sfp_config
[   84.548557] drivers/net/phy/phy_device.c:2942: phy_probe
[   84.557011] drivers/net/phy/phy_device.c:2961: phy_probe: phydev->drv->probe
[   84.572223] drivers/net/phy/phy_device.c:2983: phy_probe: genphy_read_abilities
[   84.589831] drivers/net/phy/phy_device.c:2502: genphy_read_abilities: MII_MARVELL_PHY_PAGE: 0x00
[   84.606107] drivers/net/phy/phy_device.c:2507: genphy_read_abilities: MII_BMSR: 0x149
[   84.622177] sfp_add_phy
[   84.631256] phylink_sfp_connect_phy: calling phylink_sfp_config with phy settings
[   84.631261] drivers/net/phy/sfp-bus.c:445: sfp_select_interface: PHY_INTERFACE_MODE_SGMII
[   84.631261]
[   84.650011] m88e1111_config_init
[   84.667424] drivers/net/phy/marvell.c:905: m88e1111_config_init: MII_M1111_PHY_EXT_SR: 0x9088
[   84.676137] m88e1111_config_init: sgmii
[   84.697088] drivers/net/phy/marvell.c:787: m88e1111_config_init_hwcfg_mode: MII_M1111_PHY_EXT_SR: 0x9084
[   84.794983] fsl_dpaa2_eth dpni.0 eth0: PHY [i2c:c2-at-sfp:16] driver [Marvell 88E1111] (irq=POLL)
[   84.805537] sfp_sm_probe_for_phy: tried to probe clause 22 phy: 0
[   84.819781] phy detected after 0 retries
Settings for eth4:
       Supported ports: [ TP MII ]
       Supported link modes:   1000baseT/Full
                               1000baseX/Full
       Supports auto-negotiation: Yes
       Advertised link modes:  1000baseT/Full
                               1000baseX/Full
[   86.149536] sfp c2-at-sfp: module removed

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/net/phy/marvell.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 623292948fa706a2b0d8b98919ead8b609bbd949..2da4b845ef4c854a445be2888c3776e44f24fb33 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -3717,7 +3717,7 @@ static struct phy_driver marvell_drivers[] = {
 		.phy_id = MARVELL_PHY_ID_88E1111,
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
 		.name = "Marvell 88E1111",
-		/* PHY_GBIT_FEATURES */
+		.features = PHY_GBIT_FIBRE_FEATURES,
 		.flags = PHY_POLL_CABLE_TEST,
 		.probe = marvell_probe,
 		.inband_caps = m88e1111_inband_caps,

---
base-commit: b1c92cdf5af3198e8fbc1345a80e2a1dff386c02
change-id: 20250823-cisco-1g-sfp-phy-features-c0960d945d07

Best regards,
-- 
Josua Mayer <josua@solid-run.com>


