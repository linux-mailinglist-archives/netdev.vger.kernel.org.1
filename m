Return-Path: <netdev+bounces-231285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2EEBF6F45
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 16:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35E65505177
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 14:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0138338F43;
	Tue, 21 Oct 2025 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b="VKNmxeRL";
	dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b="XVw4t/iP"
X-Original-To: netdev@vger.kernel.org
Received: from mx-relay146-hz1-if1.hornetsecurity.com (mx-relay146-hz1-if1.hornetsecurity.com [94.100.128.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576D132ED3B
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=94.100.128.156
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761055333; cv=fail; b=rP5G5Dpsjr6vPltBVjY3opcwmxsancEtFmSzCaav1znbUWQiCRpziZg+x0UN4UrXM9lqIP7fDTwvDFuooYeGq/ESBWfBnyKYfCkIQsp17H1Wdw3tICvPwPB3n4ovD8i5r5QXW7TqKgLGvgNZAoW0RPTpMrs0zALetQXWZmP3+cQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761055333; c=relaxed/simple;
	bh=mmbfaop1dz0t5A/PnLC0kcdG0A8uSRpJlGCPDE7EIyg=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:
	 MIME-Version:Content-Type; b=Jq9Es8UW7rW4yZybTex3NdlNifnpfWAOLrlz0ecLo/Ew0b+Rq4Vf0mK3H9i2VPMzlhoOatQH6JIaB8+UCtt5ycELFdcNAaZaBWckDTC7wZIqxpIt9BLgOvngK7bFm2JdU0PepHE9ljERilXqCBJIYCB+Bq7ETb48rNV4O0jtJJo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de; spf=pass smtp.mailfrom=a-eberle.de; dkim=fail (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b=VKNmxeRL reason="key not found in DNS"; dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b=XVw4t/iP; arc=fail smtp.client-ip=94.100.128.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a-eberle.de
ARC-Authentication-Results: i=2; mx-gate146-hz1.hornetsecurity.com 1;
 spf=softfail reason=mailfrom (ip=52.101.72.124, headerfrom=a-eberle.de)
 smtp.mailfrom=a-eberle.de
 smtp.helo=am0pr02cu008.outbound.protection.outlook.com; dkim=permfail
 header.d=aeberlede.onmicrosoft.com; dmarc=fail header.from=a-eberle.de
 orig.disposition=quarantine
ARC-Message-Signature: a=rsa-sha256;
 bh=IdS30phEtln960wX+Qe3N7HFC6uqjXjkfGYndtbIVI4=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=2; s=hse1;
 t=1761055294;
 b=ZWP9NGj0z243U4S7Glz3LoL19g52PE4RTdRlg/GY7PHbwtbSEMtM52pOMDu8N0CBSQ1Bd4HR
 VD+mq4vY3dCY7iFMnzYTyLoa30M/pdEKJk8vAnSrCI5yHuVjYRrd73tukJy9o+yK48QdPrJpbEW
 2TTXbRYNI/3LQ9JdSpaoaxQB9+8eJyZr21g4TdNQHvI8V4TCjNu/+Mu8Bt1lFlQiiz5G0sH0MI0
 KrBv04EtVPFP1lUhA5lz4I4c7bWiedfvHFDrfJ5y5QopfzhJglIVI8zcOD2mCjW3KEREzas9bsO
 PsJaActhoYEGzpbBiX27WxoWJJ9X3VnRYogrUF4Air7ig==
ARC-Seal: a=rsa-sha256; cv=pass; d=hornetsecurity.com; i=2; s=hse1;
 t=1761055294;
 b=DF0Q2oaU7PEMJG0g3VjJzxuMbXqMiX81yhRkFxRVO85PkqnswFHEiNgSD7Yf5fEtwDvhxGf6
 qAC6gsMPUr3b4y8fiMlaFCAheJkYUjqKf+T7ENtsm4fSxeHomOhn15Z9yOgyrs9hNUaaenCT4cj
 GXGJ7fgzFUfzwkD0cnKEv/IBV6E8bYJuIoyYnmfjsee9JA6ADigu6saDhO35OVrQ0IrHruLWZZs
 fZspViGc/WRUNmI9oKXJft47b3zsn/mkDwJy87+cy6I98w2ufbpH63EtEYM1F18GCEZsTwK+wiD
 LzR1ct59oG9OUuqy6ffztI6fXdF1Bz1KEYRII0i5mO4IQ==
Received: from mail-westeuropeazon11023124.outbound.protection.outlook.com ([52.101.72.124]) by mx-relay146-hz1.antispameurope.com;
 Tue, 21 Oct 2025 16:01:34 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPkonl+wm1D17ZapoIwlzpIelCcUocbs+OzmLv1W5AklJ/17tc7rk1SlCzIjXdQpwmH2GikDuDx5r7h076pllL2rZK5AN9LZUmR83VNM47BHn/ml6Vrax9K1jMBdcAmTz3NqrAFuC0al3/yvhnb2Pk2zOOmM5ywdUUgVUJB2d4OtpguaPn+Z03lhWSdj9dcsD69C2xZfJzB2rWxyAsq9EZdKccGFZVnbXhkcmF1m2SjfAdE+VwbN734leXLdntC2m6mzBrsTc+4BVovC1dEysXa/oLV5ypJ2XQ1SBltMvB2MoKFLYMKMijMUomvwAbTmDmT5Npw39jVMnXVlpbdM9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHapfmY5F17adzy8/hf8WArGU0dZb6i1RBLWE4mC4j4=;
 b=DXAOlvGGf4tYr+NSJIScrgIBkNdZehApujJpva7zGGA6LCADkUc1HHJl8y5nH6Wqm+vURcLvfEh3luyrZTVQDOXqRGknN62db44OMJEIbK3FsNC1gxxKEFUX2EuAUfJNLy58nKY4AaPI+ErzQB/Yokt/DXaARV1qmHujGnXqRzR8zpm6ut8KG5o7p6O5l/O7mcU3Ls24gjgKnufz4IGvprGa00LK6AvYcKGS4g8SLJCA+/oWRGUoHr7dPbt9N6AlHlksu7ZLR1nGzHlqk9FLZXE0D+HDn5honZPKw/iasoQV6CIf4I941/UE82WiBA2f6/tm4G77Ro+02htlLPLdSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=a-eberle.de; dmarc=pass action=none header.from=a-eberle.de;
 dkim=pass header.d=a-eberle.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aeberlede.onmicrosoft.com; s=selector1-aeberlede-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHapfmY5F17adzy8/hf8WArGU0dZb6i1RBLWE4mC4j4=;
 b=VKNmxeRL1Ll8zjSGq1yweBt1RYSwCzQjYjv0BgEtH8o4WPYzoTga74ydRPp0Awx2vc6Zn6WHoEe5am+rI71h6Y3T+P1zMQj0tvLO1Y2gISWcsRyZEt36u4HasJiCddKdR3aYqCzrxlaA5yopbSd/yKv4cLcyAgTaLDnj2rch998=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=a-eberle.de;
Received: from AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17a::7)
 by DB9PR10MB5836.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:393::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Tue, 21 Oct
 2025 14:01:03 +0000
Received: from AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14af:ad35:bd6b:f856]) by AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14af:ad35:bd6b:f856%2]) with mapi id 15.20.9228.014; Tue, 21 Oct 2025
 14:01:03 +0000
From: Johannes Eigner <johannes.eigner@a-eberle.de>
Date: Tue, 21 Oct 2025 16:00:12 +0200
Subject: [PATCH ethtool 1/2] sfpid: Fix JSON output of SFP diagnostics
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-fix-module-info-json-v1-1-01d61b1973f6@a-eberle.de>
References: <20251021-fix-module-info-json-v1-0-01d61b1973f6@a-eberle.de>
In-Reply-To: <20251021-fix-module-info-json-v1-0-01d61b1973f6@a-eberle.de>
To: netdev@vger.kernel.org
Cc: Michal Kubecek <mkubecek@suse.cz>, 
 Danielle Ratson <danieller@nvidia.com>, 
 Stephan Wurm <stephan.wurm@a-eberle.de>, 
 Johannes Eigner <johannes.eigner@a-eberle.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761055261; l=940;
 i=johannes.eigner@a-eberle.de; s=20251021; h=from:subject:message-id;
 bh=lwpUxw22ogZtGG1FMlYvChmyNFaCsGg58YCAD8GzllE=;
 b=9CpnYfrfU3DX9mOBlRIW6tnmn82zWEaIWL0ssi9rD2ZTu91s+1K3eAtKZi7+NKAQ4GtRzEhvR
 Pf/tgrShh0ZDedWa473fCde+mEXFiAEao6Hcc4Uf1emEBoBCarjdAvR
X-Developer-Key: i=johannes.eigner@a-eberle.de; a=ed25519;
 pk=tjZLx5Tp2iwCN/XmbFBW4CrbjZnFMF6fyMoIgx/dEws=
X-ClientProxiedBy: FR3P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::16) To AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17a::7)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3873:EE_|DB9PR10MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a455a69-2505-476c-d253-08de10aa457d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDdJUmUxUzlla2dPazdERWVKQlI5V0plaXRsRzZSQWo4VmpGOC9wZ0xBaFZW?=
 =?utf-8?B?d2JTOEVMZDIwN0VTdTA3RmJXOGlPTUlQanVvNWQzUytydmRhQjFSNVkwNXdj?=
 =?utf-8?B?Q2cvdFFHTXZqOExFQmNaRkhrRXVNWVdaaDFhejVPblJvS21yaGc1ejJVQlNN?=
 =?utf-8?B?SHlIbEp0NGZiMGkvWlNIamJHMG11MmE5VGFsaExZSHFha3BVR3ZoMFVDTEZp?=
 =?utf-8?B?dDF6ODhRZHhYQkdFOUNMNWU1TGszVUtRbUdFQVVJZ0FnWGJyR0FHOGc2eU5x?=
 =?utf-8?B?Mk1IWkNjdGRkdFVielJidWF0YUtMZ0hTZFIvU210d2hmbFFLaUp1ajVqaTB6?=
 =?utf-8?B?MFo2N0RJaWhUcjl6Y08rMTRIWDc5OWdwTGxod20yTk12QUFVRTB1bXVJTEZo?=
 =?utf-8?B?b3NJcHg0NmIwUHZSREtpUVYrVlFCNXV5Y3NhSXpVbVVmdTFIS05QNm1LM0s2?=
 =?utf-8?B?TlB3c0tHTm1XZWhnQ3dIWGJyWUtmQ244ZE94VHJSd3pYaXgva3NHVUo5UHE0?=
 =?utf-8?B?cGVwYlhlWVhJTGJhRFpIVTg4TUJCejhRVDVvOFFLQjI4S3NhV3hxWlpCTmww?=
 =?utf-8?B?ZlFMck9XMVloa08veEVySzE4dmFGVjJEZ3llV3hEZFBKS2IzSXRWNTBoeXlK?=
 =?utf-8?B?ZkFZTXJRemNiK2IvZURtYk12NDZJcDEzU1FwVFJrRmVJbW1makZ6dDJIVExv?=
 =?utf-8?B?YU9rUUkrSkNrdy9jdWptcSttOUducWViY0RsQ2E4NzdTb0VMa2pnS2tZS1Fs?=
 =?utf-8?B?SWw3SWtFTTB2OFQ2U2JFWi9xNk5IazVSM0QrQTFzUG1EQXl6V1h0RWl3Zjhw?=
 =?utf-8?B?RDB3UXRlQ1E5MTQ2UXJBMXRrdFFWNExhb2NtMjlRT01jZHVWczlwVFJRNjFi?=
 =?utf-8?B?cFprRlpza3dFeDJlckVZdS8zNDhQS2RreGdrLzdRbGRCSkQ0WUhzbnRNVWdJ?=
 =?utf-8?B?bFRHWUlxVVFMd2xDVnlRV1F1YnlBWWxHUTdwNnlDUEdwZTA5a2ZyQWd4WVpK?=
 =?utf-8?B?SWJkSTVSdjBOeXhrcFVpOEVWMWV4eHM2dm5adFFJb002NXQ1Mk1uUWpPVXZO?=
 =?utf-8?B?TW5rcWg5ZDR5cDhxL2t2S2ZKblBGSzZVR3hKNmYzT3lQenlPbUxSQ3ZVWHd4?=
 =?utf-8?B?SEQrTUF5V0tQUFBjaUQ3V0taK0FpK2V0YWN3U1ZwNjNVT3RtNlNPa3F1N01o?=
 =?utf-8?B?TDJuTmFlcW9rUVBFRnRnNmN6SUZxM3AvTStTZDVsWHB4dzNCN1lLUDZaNS8z?=
 =?utf-8?B?aGhvaTBldFNFRzdIeGdtbzI3Rmo3bVVRdExBUFJiYVpjVXhlVXN2Smg2eHdS?=
 =?utf-8?B?VFZpM2RURytXVDNwSGY5MGZlZjE3RmhXWW5SVUtFUStUTldrLzJZejhETGRD?=
 =?utf-8?B?YVk4UHliVEZMQ0UwUzdmTTBDeUlzYXBQN1lOSHlEbkVLQ0NwS1YxVGx0Q215?=
 =?utf-8?B?YnF1MGVwbVlDU0pTWWY5dUZIZW9GR3Y2RithYmN2VVEzdE9KVlo5bUVSTmZ4?=
 =?utf-8?B?L3pXeHEvRm85T0ZqeUtIMlVoZFYvckZXczZzbytMYkprSzZPZEppOHpNZzQz?=
 =?utf-8?B?ZlR4NW1jZjVCM3dtRXdsYXhjc0J2Y0R1azA3elJ6K0dpT0ptRk0wRU50VVdm?=
 =?utf-8?B?RzRpSDYyT0RoTU1LeXZBWm1XczByaXZBS25PRXgwd0g2YkpjSkd2eC96RG9Z?=
 =?utf-8?B?K3NCaUc1Z2FuTkk2NTJTNjBOa1lvTWJETmdwSDNnaC9QSy9WU3QwTllPbHpH?=
 =?utf-8?B?TXVHSFpkOEhCWkVPQzZnQ1hoQnVNbExybEZHNy8wRytEYlkwcDdlT0l6bEpU?=
 =?utf-8?B?cEJ4bUNPdG8xS2JPY2d1dHVtM1ZPblh6MTkzaGF6TXNRTlJyTFZ5cUM3cE5V?=
 =?utf-8?B?UmlsY0ZTTW1CTFBNbnJVazAvTUVScWorTnBjSTB0NzdZcHZ3MEo3ckxSdkFY?=
 =?utf-8?Q?VgVkjZcI+YxmfXoDFGrV4ZMGQwuKWUlU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlhhZm14bTdDdm0vNVNuYVNmZ2EwWWhRWm53K0xyWDIzL1BZVTcvR0JwelVB?=
 =?utf-8?B?b3BIN1RQc2VKdGhSbXR3SWZqTHNETnM1Qkk0QlN3d2x5cmtmajV6V0JFajZM?=
 =?utf-8?B?cmVpTmlneHFHcUszbWNJQ2I2L3RHMnJIeXNGNEFZNGVZQXVYc25oNUJtNTlH?=
 =?utf-8?B?Nm5VME1aR2VBUW5BY0dveWowM3l2dzRaU0pZSjgzcjJ0T1BjQVAwcDY2aVBS?=
 =?utf-8?B?OEhVMFZsM2p5dno1OHNYS0h2K0JPUi9OQ1lQOGExTUNSaFdMSVRJMm5oR0p1?=
 =?utf-8?B?WE8zTUxHK2JjTmNGQkJ0dzRuSHZKbFZ0RHJURno3Mi9Wdll4RzViVHU1M2Zt?=
 =?utf-8?B?K3RQME5mUG1OTVJRbUYrWkNaZEJ0V1hnZ2p4b05YSk41ckk2bWJ4M2llYVVS?=
 =?utf-8?B?MmhVU3ZqVU82RjJzemJZa2ZmekFhdGNTZFpDUkR5QlVYT3YxUTV1SzFsRzZI?=
 =?utf-8?B?V2QxR2lJSXMwTkJPbzRSTzlrSEJBSkZUbmZWOGV6NGp2ejZrUkxGbEk4ek9I?=
 =?utf-8?B?aUFVQzZRSHdRVGVJNVNtOWxVenNUeVNob2FPdFRzUTlOVE14RE9TditDT3RC?=
 =?utf-8?B?LytjNWtGaVNYdnhmd0kwTnE1dVhGS3BMSFovNVRkYnQxYS9Ia09KNDVzVjE5?=
 =?utf-8?B?MEF5QXZTTVFtRHpXV1RpNTNmS2U4STJrSTJWb1lpei9XQ3c4a2N6eUlweDVZ?=
 =?utf-8?B?SkllUVh0NEMzQWhpaStMOURsc254UEI1a2xLL2dEaXQ1VUdMeEYrMHFUU0g0?=
 =?utf-8?B?WGdKZWtkMmIrN0RSVC9pRWpWSm1zOVo4TE1CM0hodTVaUGt1b0lvTFdtTDhG?=
 =?utf-8?B?VW9neGlFb3BNWWpBUzdENHpaaWk5djJCYnMzbmROa2tTU2pNVUJjcHA4azBT?=
 =?utf-8?B?UW5qK3hDTjl2SG5EYmR0N0wxREdpZGJCU3RZMXFzSWY0Zk1jTk00NVdEYTds?=
 =?utf-8?B?cjBraEhCWS9uRWRWZzlRMXA2emhxMS93bWd2L3JlR0tWQnJwdk1VdHM1YW9q?=
 =?utf-8?B?RzNEMDE4em9mWDRxT3hjRkJKNDBtaDdZWWEzMHlZN1RjTlg1akdLTlUxSGVJ?=
 =?utf-8?B?ZW9UMHFHdllNSXN5Y3h0MDFUSnA3RHpaekdZWVVPT3ZoVyt0Mnl1MUpSOWkr?=
 =?utf-8?B?NnZPT3ltcWFJYndsOUJqNHV4TjMyYTV4c0FZSFV5MnRXMHpNQ1p2Y1VSeGpO?=
 =?utf-8?B?ZlVDSzArUXkwSEo0UnFKeUlESExOSWZoSjJmOUNPTUVEeHZ6bXl6dFVTNVY5?=
 =?utf-8?B?bnVLUDVwWlVFM1hxcGlKMG9qRVhhT1Z2cnVYQTZDbnArancwTzE5am1ycHh1?=
 =?utf-8?B?TFBOM2ZvbG85S2RGc0R5blIxRVdQQWZvdmV4YWNRdmJJRUpVUzFwNDZ4bE5j?=
 =?utf-8?B?WXNLV3V5S3pRbDlWUVkwcnhnVW5ycHNqLzkyV1plUFhab0RZT0ZFaUw3dzA1?=
 =?utf-8?B?TVFmblBxQ09tZDBMcjdveTQ2blQzSjB5OXBmWWx0N3F2R2hRZGE0QU1OY0RT?=
 =?utf-8?B?TGFDVDdLRi9xbjlPVG1XZjU2Q3V6TW9ocERYMVhTNEwveFI1YTh1bitYZGx2?=
 =?utf-8?B?eS9xeUhPeXpCMDlVVE5kTWdUZ2hjeDB4b21YOFhjQjlzTjJrNUVmNWd6RnBi?=
 =?utf-8?B?cHd2akd0YS9WT25wU1ZvcDU2SmVoRUpaVzFLM3dhRFRNL0NLYkJUQTFTRWk2?=
 =?utf-8?B?ZTJ6VVV3QlV6R3MzMytKRnN3VEw5TE51aWJvZURUVVJiS0lTem9kbWNjclBq?=
 =?utf-8?B?UHc0QXlNS1BSeTFCZ2Q3cjk4VUYyc0tMVmtaNXJtMVIyS1ZVL3VLUlpDQTd3?=
 =?utf-8?B?TFozWG92clQ1cEsxMDlMbHVSSGpHN3dFT0NMZXpabXpHRlhZb3hkWUpiREl4?=
 =?utf-8?B?OTROdVN0YWlrRjJYRlMzZnlXeG9nNkdBZ3Q1RCtidGxQd1haclplUlhaTkFF?=
 =?utf-8?B?cUlGVjZMNDJpSWtubGx4Tng5dXYxQ3pZUVNGRG01eXpaOHRNNWxOQ3R4WERX?=
 =?utf-8?B?d2RHZENXQ2dyaXpucE1zNzZ1NXFuRmdCWHNTL3hqV0txakRoUExiVlJlOUFR?=
 =?utf-8?B?OHFNcDdJL25lZVFlZkdvM3orQU1SNHordWJoWVdWUUJsK1E0bjcwbGpmRGx2?=
 =?utf-8?B?SVNoZVF6YzcwWHNUMkx3bi9BT0NNMW5yQnNqb3B2R1l4OGFyYXIzeUNrMjgz?=
 =?utf-8?B?eGc9PQ==?=
X-OriginatorOrg: a-eberle.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a455a69-2505-476c-d253-08de10aa457d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 14:01:03.1401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c2996bb3-18ea-41df-986b-e80d19297774
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aDXq4CmpFK9sOmWpaaHKADlHHCrjZEjSLb8oEKsevOmOKN2GWMY9URNv6XEn/TC5xd2QLc9sm1/CWV77wVpfrSM00Gy0MMYvHfzz2z3C4jQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5836
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----D2C50C4688A348DA37A7208A65DAEAD3"
X-cloud-security-sender:johannes.eigner@a-eberle.de
X-cloud-security-recipient:netdev@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-crypt-policy: TRYSMIME
X-cloud-security-Mailarchiv: E-Mail archived for: johannes.eigner@a-eberle.de
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay146-hz1.antispameurope.com with 4crYqP215nz1mxM1
X-cloud-security-connect: mail-westeuropeazon11023124.outbound.protection.outlook.com[52.101.72.124], TLS=1, IP=52.101.72.124
X-cloud-security-Digest:265840841f27277321ed1529ec6d93a1
X-cloud-security-crypt: smime sign status=06 sign_complete
X-cloud-security:scantime:4.825
DKIM-Signature: a=rsa-sha256;
 bh=IdS30phEtln960wX+Qe3N7HFC6uqjXjkfGYndtbIVI4=; c=relaxed/relaxed;
 d=a-eberle.de; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1761055293; v=1;
 b=XVw4t/iPgMuYk/fp4jseLwzHvbwGtM6KMBz6E8pzltSw9fndyo+0XbTGem2RUOjzPSZYLz3I
 blrVBA3NFyRa0NWRDMdpJcDDJ3asH3RjLn0MsnlPrK12u1APbf04DI8jBaap+tZiw9j2NrDvBGf
 Cih6CFCTprs/4NfXppugCTVtD1g/3n2Ml6Bcngp0i41FFs1/9Uv+9b6gkUz+YNluX4bCNApYZ+8
 JulA5SEw3vhMrDuQppbT0uP6vZrZLNUHK8G5B9THIMrcyQ8i7RmSZjXGapdWat3q3svEYxRhISB
 5ITqN6RWnhaDvXT59ktKamTlOiwSLQw11MplRv7lvHvyw==

This is an S/MIME signed message

------D2C50C4688A348DA37A7208A65DAEAD3
To: netdev@vger.kernel.org
Subject: [PATCH ethtool 1/2] sfpid: Fix JSON output of SFP diagnostics
Cc: Michal Kubecek <mkubecek@suse.cz>, 
 Danielle Ratson <danieller@nvidia.com>, 
 Stephan Wurm <stephan.wurm@a-eberle.de>, 
 Johannes Eigner <johannes.eigner@a-eberle.de>
Date: Tue, 21 Oct 2025 16:00:12 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Close and delete JSON object only after output of SFP diagnostics so
that it is also JSON formatted. If the JSON object is deleted too early,
some of the output will not be JSON formatted, resulting in mixed output
formats.

Signed-off-by: Johannes Eigner <johannes.eigner@a-eberle.de>
---
 sfpid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sfpid.c b/sfpid.c
index 62acb4f..5216ce3 100644
--- a/sfpid.c
+++ b/sfpid.c
@@ -520,8 +520,6 @@ int sff8079_show_all_nl(struct cmd_context *ctx)
 	new_json_obj(ctx->json);
 	open_json_object(NULL);
 	sff8079_show_all_common(buf);
-	close_json_object();
-	delete_json_obj();
 
 	/* Finish if A2h page is not present */
 	if (!(buf[92] & (1 << 6)))
@@ -537,6 +535,8 @@ int sff8079_show_all_nl(struct cmd_context *ctx)
 
 	sff8472_show_all(buf);
 out:
+	close_json_object();
+	delete_json_obj();
 	free(buf);
 
 	return ret;

-- 
2.43.0


------D2C50C4688A348DA37A7208A65DAEAD3
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIQNQYJKoZIhvcNAQcCoIIQJjCCECICAQExDzANBglghkgBZQMEAgEFADALBgkq
hkiG9w0BBwGgggw7MIIGEDCCA/igAwIBAgIQTZQsENQ74JQJxYEtOisGTzANBgkq
hkiG9w0BAQwFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCk5ldyBKZXJzZXkx
FDASBgNVBAcTC0plcnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5l
dHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBBdXRo
b3JpdHkwHhcNMTgxMTAyMDAwMDAwWhcNMzAxMjMxMjM1OTU5WjCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdv
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTCC
ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMo87ZQKQf/e+Ua56NY75tqS
vysQTqoavIK9viYcKSoq0s2cUIE/bZQu85eoZ9X140qOTKl1HyLTJbazGl6nBEib
ivHbSuejQkq6uIgymiqvTcTlxZql19szfBxxo0Nm9l79L9S+TZNTEDygNfcXlkHK
RhBhVFHdJDfqB6Mfi/Wlda43zYgo92yZOpCWjj2mz4tudN55/yE1+XvFnz5xsOFb
me/SoY9WAa39uJORHtbC0x7C7aYivToxuIkEQXaumf05Vcf4RgHs+Yd+mwSTManR
y6XcCFJE6k/LHt3ndD3sA3If/JBz6OX2ZebtQdHnKav7Azf+bAhudg7PkFOTuRMC
AwEAAaOCAWQwggFgMB8GA1UdIwQYMBaAFFN5v1qqK0rPVIDh2JvAnfKyA2bLMB0G
A1UdDgQWBBQJwPL8C9qU21/+K9+omULPyeCtADAOBgNVHQ8BAf8EBAMCAYYwEgYD
VR0TAQH/BAgwBgEB/wIBADAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQw
EQYDVR0gBAowCDAGBgRVHSAAMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6Ly9jcmwu
dXNlcnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5
LmNybDB2BggrBgEFBQcBAQRqMGgwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQudXNl
cnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FBZGRUcnVzdENBLmNydDAlBggrBgEFBQcw
AYYZaHR0cDovL29jc3AudXNlcnRydXN0LmNvbTANBgkqhkiG9w0BAQwFAAOCAgEA
QUR1AKs5whX13o6VbTJxaIwA3RfXehwQOJDI47G9FzGR87bjgrShfsbMIYdhqpFu
SUKzPM1ZVPgNlT+9istp5UQNRsJiD4KLu+E2f102qxxvM3TEoGg65FWM89YN5yFT
vSB5PelcLGnCLwRfCX6iLPvGlh9j30lKzcT+mLO1NLGWMeK1w+vnKhav2VuQVHwp
Tf64ZNnXUF8p+5JJpGtkUG/XfdJ5jR3YCq8H0OPZkNoVkDQ5CSSF8Co2AOlVEf32
VBXglIrHQ3v9AAS0yPo4Xl1FdXqGFe5TcDQSqXh3TbjugGnG+d9yZX3lB8bwc/Tn
2FlIl7tPbDAL4jNdUNA7jGee+tAnTtlZ6bFz+CsWmCIb6j6lDFqkXVsp+3KyLTZG
Xq6F2nnBtN4t5jO3ZIj2gpIKHAYNBAWLG2Q2fG7Bt2tPC8BLC9WIM90gbMhAmtMG
quITn/2fORdsNmaV3z/sPKuIn8DvdEhmWVfh0fyYeqxGlTw0RfwhBlakdYYrkDmd
WC+XszE19GUi8K8plBNKcIvyg2omAdebrMIHiAHAOiczxX/aS5ABRVrNUDcjfvp4
hYbDOO6qHcfzy/uY0fO5ssebmHQREJJA3PpSgdVnLernF6pthJrGkNDPeUI05svq
w1o5A2HcNzLOpklhNwZ+4uWYLcAi14ACHuVvJsmzNicwggYjMIIFC6ADAgECAhAl
5qzXGH8Da+FSta/hHFZ+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEb
MBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgw
FgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENs
aWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIzMDcx
OTAwMDAwMFoXDTI2MDcxODIzNTk1OVowLDEqMCgGCSqGSIb3DQEJARYbam9oYW5u
ZXMuZWlnbmVyQGEtZWJlcmxlLmRlMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIIC
CgKCAgEAwEFNcbuq7Ae+YCfg2alacqHWh08bvE6bFOZZ1Rxl1w/sFuXUwJ8o+gbB
TA/mmITzst+fnsjwMmrjtCecn8wILPitSD2wXy+yiaWmn8ywuBBw8toRX0xSMgif
KM494f9SSFjJDOgZGmAG+umMO6v5KNA1K0wSWrlZmG0yC0pzp6FFVVyMnp4/vJh3
6BuYgOf0s7KK5ShCQ4mKOD0dOOcMTBFHcQuD8d2Ha9lH5KzF4CVR6W3p+DUs2r6o
WwSPc0MrTqq0Ci9KPaKmvxzMQRZqSqa5ySqyw4guw0vnPYwtS0BEYZM+mL/5BwAP
Uga7nUg/9tjzyEgUY3tmimfWD0UIi9oDHT59n4s5iriWcnZNS5dAWnu7NqEBs+w6
lpWo2g60mmxPULNnwSUYxqdfXn5udIde0boYLKfEy11JC9xkshXBgLPhq4xTkbWs
fkoH+EQyEdep5AhaLeTsJHpw0tp2whpeH9Fwck8tx/nWtudo7bfYZUF4lDtyEHmi
p7UJa6x4LKEO2XFlY5v6ZOfVAm+zqNWEdDGO3bfv3HO5ciIHjXHLVFx/XI73OVsC
aObazBuEcqXafTK9ThLS5Sh4uZ3nLv3n5m8m/UUUKbOmOI7MTId7WlP9hOeNAzEu
SiA/n8VFk4RO7iwajXximGU/0rxuUJtN7RJFumksH7sbO5ypjCcCAwEAAaOCAdQw
ggHQMB8GA1UdIwQYMBaAFAnA8vwL2pTbX/4r36iZQs/J4K0AMB0GA1UdDgQWBBSz
BXMVnJ+omSJdNUgpzP64lg+gRDAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIw
ADAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwQAYDVR0gBDkwNzA1Bgwr
BgEEAbIxAQIBAQEwJTAjBggrBgEFBQcCARYXaHR0cHM6Ly9zZWN0aWdvLmNvbS9D
UFMwWgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDovL2NybC5zZWN0aWdvLmNvbS9TZWN0
aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCB
igYIKwYBBQUHAQEEfjB8MFUGCCsGAQUFBzAChklodHRwOi8vY3J0LnNlY3RpZ28u
Y29tL1NlY3RpZ29SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWls
Q0EuY3J0MCMGCCsGAQUFBzABhhdodHRwOi8vb2NzcC5zZWN0aWdvLmNvbTAmBgNV
HREEHzAdgRtqb2hhbm5lcy5laWduZXJAYS1lYmVybGUuZGUwDQYJKoZIhvcNAQEL
BQADggEBAMJhsGQW6C4UBZr7OpMg/n65GOd5Iy7i3vXW7gO7sgPe1pHYi1LJZ68J
lB9sP93yDViPMJ4Cir+/QqU7AtLyKkf+oo8nQTlx5gQeJnftZ/O6RkCS20I18GxC
aRDRRwD2JViL5Dk9uB87sV5DlOZV8w2VNWh+mm8wZGonaQ3NoNX+7jHcF5QX23Hx
x8ikwfv4jj3qajpv1l362Wl5FySKhdEXB/hhyxLjMfHEYs8PKHnjeWGbMPnqyTtt
xgnK+Gtmc4fjSlRf8Nzpr/q3iPppdSOmVk1lGmaGTJ+7ItiA1OTcFf7Atm8GomFp
QXdyoI/DW3zj355K+YADYhwhosfaQY4xggO+MIIDugIBATCBqzCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdv
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQ
Jeas1xh/A2vhUrWv4RxWfjANBglghkgBZQMEAgEFAKCB5DAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTEwMjExNDAxMTlaMC8GCSqG
SIb3DQEJBDEiBCAuImbtX9HZQl+8NkZNVGr2EfMLbLR3BkesuB1wAN/2nzB5Bgkq
hkiG9w0BCQ8xbDBqMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUD
BAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAH
BgUrDgMCBzANBggqhkiG9w0DAgIBKDANBgkqhkiG9w0BAQEFAASCAgAOt7vLa2T1
e/pej5jftPSLRTfIPD1/y095qWdb/mwz5na9yWqXlCLxaImCm6k4XBgHk/6Irl6K
/nB2YuTw3JgyQngJVUfy47/8PECNtzNmh/jGffuPOfLrnTd6/nFSDTnecW0mUTC9
YrkfBHhILkLy+oik2Kf707+Vyu4QiKrVdo7lG8aySsj5pl3XbNNS6OfTMIG4+SP7
Vqh2eEPzakz15FwHJZ5lJv5RTE+j3oLBvAXcqcsYqN1erX9kc7kNoxi279Lv/cz5
idf+SpmituvUv1HtOrizYhluB3KZfFOoKPk4sZy6qClTiI794SMxQ1DwLPFUIvb3
etW8PGUr5uwEGQli6y5Mk2SoLcl7uGvA6jEfcJSCuxMNIE6v6xfG3CR7mAqalq+e
A5N30UYrZQNAHoy9FCxBrzq+9kof2xfnL9YfGRPtyH7JUAfGepqVJJGuNh2pDOAm
/PuTIcl5cc6KNXjxz8jTPvF9FS/jYPyw4xUIsdMGgIsR0n0tiXpOLEOk8eVP9a9Y
Az621UuO4pflZlee6UiifxkSvKrsCU3bXh6r1IvtvwBKPiRkQZS3FJHdzg86Y0j7
ldTlAuzUyJTgvFEqg9jwtq9eQEU7HFcF7wHfTZfLQhVMGQqiCEc+4zA1lQiwfhfF
9kBe5HEQKur0ScTAxV1YjthiHt8GwrfSeA==

------D2C50C4688A348DA37A7208A65DAEAD3--


