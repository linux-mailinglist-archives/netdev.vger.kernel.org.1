Return-Path: <netdev+bounces-231284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF80ABF6F3F
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 16:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4E118881D2
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 14:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C5A337BB7;
	Tue, 21 Oct 2025 14:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b="YOotIj8M";
	dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b="OH1004jD"
X-Original-To: netdev@vger.kernel.org
Received: from mx-relay146-hz1-if1.hornetsecurity.com (mx-relay146-hz1-if1.hornetsecurity.com [94.100.128.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511D61DA60F
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 14:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=94.100.128.156
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761055327; cv=fail; b=f9FjC1CBdLAqpMpo4uq2PdQ+Ut+JDjjWPJyHl/wOT1z5HH56EZUmIAOIti8jKyXfxOcL2TlQGRJfwNKv2xYRyTg+KD4xVbZIe6UxXZe67nUZjBvc+iWaSPovlMqOEKadWpO1IsDZlqaHaObo+t9sSDJL3ZYhh+856pNV8EUeVTg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761055327; c=relaxed/simple;
	bh=IfZRC/RemA4CSIpeHYCdWDNFNvmmcnGqfEVqeelRsDI=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:
	 MIME-Version:Content-Type; b=CmaRAQr3pRcBgVWXUHgzAFhOVR2S98CCeUoN8Th5+I6XtClz8L7ugQDxNtxXijDEYqccjl/LePivqzZ/M4zIkVO/SPYQNoshKJDjS1OJ0+ovViSjzojr4hDbmeCmEXP/c9N/YC4ReCFLGhCoVG4Nz9LnMPpUKRqqAOQ3LnkVzyU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de; spf=pass smtp.mailfrom=a-eberle.de; dkim=fail (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b=YOotIj8M reason="key not found in DNS"; dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b=OH1004jD; arc=fail smtp.client-ip=94.100.128.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a-eberle.de
ARC-Authentication-Results: i=2; mx-gate146-hz1.hornetsecurity.com 1;
 spf=softfail reason=mailfrom (ip=52.101.72.124, headerfrom=a-eberle.de)
 smtp.mailfrom=a-eberle.de
 smtp.helo=am0pr02cu008.outbound.protection.outlook.com; dkim=permfail
 header.d=aeberlede.onmicrosoft.com; dmarc=fail header.from=a-eberle.de
 orig.disposition=quarantine
ARC-Message-Signature: a=rsa-sha256;
 bh=gFEwdbiyYBRPJQvVCuWHkr4+msqzy+NjCHZiZ8gKZJU=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=2; s=hse1;
 t=1761055320;
 b=H/Ly9shijLld4MJogKHvFnll3wIWuWOFy7nmxssp8bP7DzSVimElfKIbo0pPYowwRYtdsj5m
 FITo5Mha3GfgZKmplRm4hYY/Q7LNxgyqVpybhK48syJuJe8kmaELS02HMMPyprLcFMJpd8/MX3v
 6b+0PJN5Tk9QqpGMPWecS3AYhptAhueRGjZzTiuqDTTUgRR8lFOfXT2FZpQ0IIb/eMMeMjQ6ITd
 S3mCiuyAXhDmeQCqbprGIQNxsUMlyrn0TIH9VcYXHnwfBKUa7cvhzBsVXSm8GoxuKC18uzh5HnC
 Y4gdnBNv2KMmWhPFgKvUJ2AGItKOFZvR/rPKhq37MH7Eg==
ARC-Seal: a=rsa-sha256; cv=pass; d=hornetsecurity.com; i=2; s=hse1;
 t=1761055320;
 b=SucDKVlLKDSR2/oMCVBrwTDD8CRcuQACxGjOj1VxJZf1EYBg4FUK2X3vhBiWh7+tbZ2v7OYO
 g2vYttoMJ4fsx/L5CfUhCYjINJCdX6u1QodrEqDEBcEawOxYcT0ecrtSgKKP8aAbxFig0H5gtsz
 Q7SuaAlCLtRa8BWxv/p96OIGw1oVO2CnuYFN+GGxweIsBfWzrZe7uThkJCgV2kXbumpCgnWEEgJ
 Rw6TqH0j19fALGLdeiKh3SWdivK1mL6t5QfH+GFALbY23OOh0SATQcEa0b2/xSM59hcfoWKriBn
 6ffz5TfBY/DpOOfEmADcVv5IWbVi+ifc/7SgTT+v+JSFg==
Received: from mail-westeuropeazon11023124.outbound.protection.outlook.com ([52.101.72.124]) by mx-relay146-hz1.antispameurope.com;
 Tue, 21 Oct 2025 16:01:59 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OGmAl2km3DiOoUpED/oJ6ab5c8WvnPeKsFJB+VcFiFEu1lB4mECex5D292L3SXzeWq5IPdB0JzObcUPqk+N+eVT7v+uWfvThOTqUkog+1uVLJhbxztRFn75Deug1JcixMmXYrQzWXXvkkpD/W/rzVKFH44GG1Ld5CGxKpbCDNvQTALaIzB/dAAroO1VhS8unr0vrbx9x/fxKf6/GmHnpxLyqUIKacGX1wRHl9ozHeFC56ysWLBUSsoAf23ce9kssjbLRHhOrIQtZ1Z4tgeXDW/2cLQ2OvcXMwriw58ryzJ5dAvy7VJdsj0UcMmiSUUxPX+UqKbuAy201dvI7naYpbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSQWd/VAFGhsEbto+dH7hOwxxSagHVGWfERZGfmsQlU=;
 b=j4VvPMVjw//9zP/HtTULvAHQOLKJeXQihAGtuj9ZZjROtngs13XAwyPHXyKZEpOmk0iKGXXDp+5UGdA9acdTXfrqVCPg4b2JgqleZvE/l7AvhF01ZD9ObdAthP2a2OV9jxWoWC8Vgqmvz7Bv/LAr0VW9oGAP/OEDob0U99cUbfFo1SetlbC1qEwchRRUkhITIOY4h0yI4uBG6SCPCnoA4SxYaCMPUKKpQMDHEJ8Ax6FB0HNzxhWryKZBHbccCTVfE/gJLuiSouJaJ7ls1zqDBorTLcAtI0JXgaI2aeS0WgbLhgNsyWqbyQpDd8I3jO/UTgKkAe/95cfdteLtC5bNtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=a-eberle.de; dmarc=pass action=none header.from=a-eberle.de;
 dkim=pass header.d=a-eberle.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aeberlede.onmicrosoft.com; s=selector1-aeberlede-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSQWd/VAFGhsEbto+dH7hOwxxSagHVGWfERZGfmsQlU=;
 b=YOotIj8MgO+05CYxGXgfWWEEM1enahqeg1LBeJRuC3byJqCZzWFXjDHR7+BGZmRtZHvrDP3MB/kLTZ6NPrLiRCTf71JRkGZeTi91R2s6zprlgNy/Bsy8HBWUDXdDe4gClmK54hoPBULarhvdfkuELNhggNGzcddsD1KO+Li+XEo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=a-eberle.de;
Received: from AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17a::7)
 by DB9PR10MB5836.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:393::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Tue, 21 Oct
 2025 14:01:04 +0000
Received: from AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14af:ad35:bd6b:f856]) by AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14af:ad35:bd6b:f856%2]) with mapi id 15.20.9228.014; Tue, 21 Oct 2025
 14:01:04 +0000
From: Johannes Eigner <johannes.eigner@a-eberle.de>
Date: Tue, 21 Oct 2025 16:00:13 +0200
Subject: [PATCH ethtool 2/2] sff-common: Fix naming of JSON keys for
 thresholds
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-fix-module-info-json-v1-2-01d61b1973f6@a-eberle.de>
References: <20251021-fix-module-info-json-v1-0-01d61b1973f6@a-eberle.de>
In-Reply-To: <20251021-fix-module-info-json-v1-0-01d61b1973f6@a-eberle.de>
To: netdev@vger.kernel.org
Cc: Michal Kubecek <mkubecek@suse.cz>, 
 Danielle Ratson <danieller@nvidia.com>, 
 Stephan Wurm <stephan.wurm@a-eberle.de>, 
 Johannes Eigner <johannes.eigner@a-eberle.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761055261; l=4035;
 i=johannes.eigner@a-eberle.de; s=20251021; h=from:subject:message-id;
 bh=gtOgqIDGWRsyn/ebulx4Fnr0SUtS4B2JngdidOl7vEQ=;
 b=3fJgK1ONv2WVgmc5HywWKDrOxdvGpNAIp6aL0UwHRjfwhujmQ8U9/+pIIrZ0kVr8cCXZtHtIU
 fOCdjTBI2JJB0H19BuwWSFUsD9NGsks6ytLlK2GpYdn1pW/bOTzVgP+
X-Developer-Key: i=johannes.eigner@a-eberle.de; a=ed25519;
 pk=tjZLx5Tp2iwCN/XmbFBW4CrbjZnFMF6fyMoIgx/dEws=
X-ClientProxiedBy: FR3P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::16) To AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17a::7)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3873:EE_|DB9PR10MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: 2be022f1-f952-470f-c9fb-08de10aa4618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGZEREczRGNUVzdNYXIyQ3dOSUI3a0dSWnBhVURrcmc2RHMzbHc4ZXVMTCtv?=
 =?utf-8?B?QzdzcW5GQWZsUktQdVBPZ253RWFyN2hXclJGVmV2RVFBcEFXNFMrSEltMkx5?=
 =?utf-8?B?L2FhUHp0ZE1TV3ZIRC9pbC9jcko4d2JwMW1SWklUZFhPNnpETXU0aVZMeG9o?=
 =?utf-8?B?Z2YrclN3Vjg0TWpacHNRTEVna2MxVXQvT1g2dlRENHRQdjhua1kvWGRTRHVx?=
 =?utf-8?B?LzVWZzhXbU03SW1rTUtzalFRb0E0eG95UU9VUkJDZCtuSmwrRmZnQVQvck9K?=
 =?utf-8?B?d2M0Ylc0U20weTZDQXptaTI0WjlmdWNFWXFlS2xOTmdPeThyZXU3aTM0TFZB?=
 =?utf-8?B?VHVQRVhpVXAvNG01ZSs5ckJLRUlvUVA4bEJIbjdNcUhORFp4aWk3TkhicnRR?=
 =?utf-8?B?SytWOThRMGRvcSt2NjIrVS91TlhIdDBiYmppK3QyU3lDNiszUHMwcXVSdGxo?=
 =?utf-8?B?SXFSclNrMDg3ZmdrTmZVY3JPYzFOL1hKZ0x6eFIvYm5aOGM1M3IyVXdRNzFJ?=
 =?utf-8?B?bStXbktyU0hWbUExRDZyOWRqMzVEdStoQWh2dlBuNGg4RTN5Z3lzVjc4Mmox?=
 =?utf-8?B?Wi9aU1AybzBKaTdxSHFGbDhqZ2NPSVMzVmdlelBaUjkrQ25sVi9Wb3ZNbjZB?=
 =?utf-8?B?QTd6blZJTitVb3Z0NmIranNJUDhhL3NIU0w5Uk5VV2NYYXQ5eWRrUkJSNzB5?=
 =?utf-8?B?Rmk0SHRtdXZlK09URzVwQnc5K3Z6MlhhWSs2anl0V1hBbjRjVDZ1MFhBTFhw?=
 =?utf-8?B?UkhwV2Z3clZEUTFKaFc3Z1ZPTXQ3d3ROU1RsSUx6RjJPMGE1T2NvS3ZEOTZU?=
 =?utf-8?B?bXNyMmhmTVBnWGRlQ1Y5RXV5SVJvT2p4VHNla3I0UlhTVkZmRzUwRm5kU2dW?=
 =?utf-8?B?OVlscWNXY1lEbHNPQ2RUWGxHNXBCR0VuK3Z3SFV4N1JKcEpzK1FKbjVjVXZS?=
 =?utf-8?B?ek1IMmtIMlNoZmRjV1A4OVZPN3VMekJteFFtbk9kMXl4YW1HT290bmhZT05C?=
 =?utf-8?B?R0dKVXY2cG1LTk42Ry9yaTF4Y2JaT2FTL253VUlUalZ4NFhscVJqczdTdm5j?=
 =?utf-8?B?NkxJU2UvR0ttZ2hOVEF1RWJqSkZ2V08vM3BvSjB5eXFtc09uM1dsWTZlQXll?=
 =?utf-8?B?cENWclRQdW1EK1hSSHN1VkMrTy96SGZMS01ob2tSQXZ0MzJEdDBvYW9QZUdN?=
 =?utf-8?B?RENGMmZqWjg1RTFoWWU3SGc2M0R3VHRIKzgzclVBaHF1VDRvSEN6RktSRzQx?=
 =?utf-8?B?WVlSblRKTjhCNnVTVGpNMlhrbzh5eVdsTUxndU1aS2xoaldja1Y5czBYZVR1?=
 =?utf-8?B?UGllT1JjN3A0aVUwdjVqbFNWTjdIUVppTXZoU2lVeGlSWnFGUXFtN016bzNT?=
 =?utf-8?B?M2FTSXRPSXplbW5PdGtnb1B3RmN2VGZTb3hQajYxT1IwSkVyTVdWQzhIcWVo?=
 =?utf-8?B?NERuaFB2d1BxYytGWCsyQ1A1MGx6d3duTXA4NVFGQWV5bUVzSVkwTlJtVGNX?=
 =?utf-8?B?NFlOSHNmaHdRUVYzUTNtS1pJQUEyZkZwei9MS3Bwb3N5bjlwM2xPeU5GMG5S?=
 =?utf-8?B?Wndya0UzWkM0Qk1CSmVvWnJwK2tZUkJuRXgzeURocFY0S0FxTUR2dlpyUm80?=
 =?utf-8?B?T0hGZWlpVFJZSjdkR21UZFhRQ1dCQTI2anRlaTFSVDJFc3hiNlQ4STc4K2Iz?=
 =?utf-8?B?UnlNOEYyVENrYUhmWk9ySDhMMU01cmNXUHZxYlVNZHFIV0ZQb09GV0hmTnhr?=
 =?utf-8?B?NFZXSThDRGIyT0pnVnZuQjdYWE5pNis5ZUJ5YjRwRGhGaG5sMjhPb0lic3dl?=
 =?utf-8?B?NkNXc0ZlWFJmczg3RDFhdWFxVkNZbW1ON1hhQ3I0K00rUDdOeDNTNWdRZ25G?=
 =?utf-8?B?bWRHRGdnYzlpaXdwcURPeEhoUjVnNmx2dUFtQm82U0dPUlJmUEtmTDJpNjZX?=
 =?utf-8?Q?ITi06Dk/XQFp+uzcQ+EKiz0Q3K8R50Q4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVlURkhZQ1dQL2ozVUFGa2o2T29HK01WeENibHlXdVB1SG8zTVcvOWpZY01m?=
 =?utf-8?B?anVvUHNiUG5JNlVlN25DcHdzQTVLVXI1UUdxSEsvUUJBRTdFSWVDR3RjSWdj?=
 =?utf-8?B?d0R3SUo0VmdvOXlFTWVUUEUrQkpxMi9DSzdvR3gwWnpiLzVYYjkzeEdTZ3E3?=
 =?utf-8?B?MUd3Z3pScWV1ZFg2V3kwMmo0VHFFbDBiN3F0QzlxclJOek94ZUIvcmZKOElG?=
 =?utf-8?B?Y2hKWlhiWFhkejVjSWtFTlhic2ZZS0o3SnZxbUllNlZ6aCtndVlhTy9KeUdo?=
 =?utf-8?B?S1lxdVE5WU1GOU53Z0h1Njh6dkNJMkI4TlN1aktVMEZwVGtJZkdUb05xbTJL?=
 =?utf-8?B?SnJnUE9oSWM0cU1zS2JjL3Q4cWYzZ3BGZGI2eGFkdFNjSW00M3hRRUJiSDVw?=
 =?utf-8?B?eWNMeW9GUk4rcG43cTZmditjY3RhanNpcnFXSjZHbVdJVlQzTXlmWnFpNEtr?=
 =?utf-8?B?Z0RnUW54SURUQUhqK09nbG4xWWdtcEZUYXdMSnErWVc4aXR0VXg3bFhURVZ0?=
 =?utf-8?B?ZnZESE01eWhyMnhCbFBCYXFCNmhhQUltWjBjaFB1UDZqZVkxdWpXVnhJdE5o?=
 =?utf-8?B?am5aR09sY3p0UFloZHlWSnlnejloNWwrUnp3WWFGNU5NU29ySVlMbkl1WSsy?=
 =?utf-8?B?OEVUMjVQank4eUVmV0d5WnRxaDkzWWlPWEhGeE5Bb25aMktMTWZGNGtnV3Bi?=
 =?utf-8?B?YVd4MVpGN29LajQ0YW1MTzZKWEhMdEpqZkpoWFFkRXdzUTRiU1dUc1VHc3U1?=
 =?utf-8?B?Wm5FVjdyWGcwK2tYODU3ZmdXTkI4dEIyK25hK0FQVmJScVp4aXBvNllzR09W?=
 =?utf-8?B?emJZSUhWcEdRVU9jOFFRMkxodEFwNEhvSVBobHA4cTNyMUhMVkFTczdDZWYw?=
 =?utf-8?B?VzVhV1RPaEcrOFI4Y2l5M293aG0zenpZbzhubWY4eWJ6b2VSbjArSmNCeG1I?=
 =?utf-8?B?UW1TcnNreGRmdHRjV0k1Z3dvcjF6aUF1T0JpT1VYdDA2Y21TekVsWURSQnYy?=
 =?utf-8?B?TDQrV3dKUzYwQWxwcUd4ZGVjL2hzeDlBZXhzekNISnBETGNmZ1dLNUs2TDZ3?=
 =?utf-8?B?eHluUkNTYUdRSU41ckZXdUhFd21BU3V5cmVDODBzRjFTNzd1THdONDdlNnRr?=
 =?utf-8?B?ZUlSVVhNOTR4TEo3b1ZVaG1tdENDa2dRcWdvUUpTWXU2Q29EOTc0V0tOaDho?=
 =?utf-8?B?dlVyZ3g3bTdMZEZGekxWL0J5QW8zZzRKa2VUZm41TXJaWmhPZ21FUE5DUGtj?=
 =?utf-8?B?REZRbHZOMmdwTHJBeGJ1d3g0U25FSWFXTzFSTkM3M0pMWVJNNGtFSm9Vbk0w?=
 =?utf-8?B?cVlVaWR6Y1pvLzBJQ2IvRUtBb2dIbWk4MnZtYzlNbUxzR2NqQjV0aHd4UmtK?=
 =?utf-8?B?K1ZPdGpyem02OWR0azlvOGVRZjhwcWtaRkUzY1J0WHIxeEhHeFREUW0rczF3?=
 =?utf-8?B?MUkwTy9jTHVqTVh4N29EeDNGU1pGU0xyYjRMQ1JoUUp2VFRiME4wMnIyTVoz?=
 =?utf-8?B?TWRqZjRZM1pqQ1gyQVZCR3dJcnliclJ1c3B4cUF0bTMwd0k2NGhpVDFjSm1j?=
 =?utf-8?B?aDZLYURRZ0dQWkwxK1pHOTVtNlQ2RHNzcEZIZTEzWmR4L1ZaekFGOTJuTDcw?=
 =?utf-8?B?eHlmMGdaSXVIdC9qejM4RG16S00wdnhvbDJNa2gvdGpnck4xZ2dmdHBHNGFl?=
 =?utf-8?B?amVEZ0lKaTRDaEZNQnV4Y3N1ZE5wN2dFa2lYbDlvTkRpRDFzc2xoMkRvTWN4?=
 =?utf-8?B?QUtqTmdzM2ZsVzlCdzUwT3Vsd1M0bk5KVTRYWU83Q0s0aUFVblZyczZ2eGd6?=
 =?utf-8?B?dHpPL1dBeEh2KzJNcFRtOVpuQW1CaldNVzlCaDBvSkVmc0wrT2hmU2h0akYz?=
 =?utf-8?B?VWhSdE5ZcmpBb0J0bVR3TjZDQmVTRFNXRUNsWkQ5V2tRdmdiSGVqaWJIa01M?=
 =?utf-8?B?N0NjUGR4TzhVMUJCVVZ4RzVkcWFwV1BFVlgvRFUyWllxcmEzQk0rUG9vQlBL?=
 =?utf-8?B?VE1iSitHY0pTcWRPRXQyUVc2VXpDY1Bwb2IraDY2aXE2cFhQT3JjMndCbUxR?=
 =?utf-8?B?QUdIYitMNXZRVk1wVUthaXJYVXF1b28wR3JzM0Q4UGJ3VTRLalY1Vm5ESGk3?=
 =?utf-8?B?VnI3VCs1MW1URkpyeXJ3UGV3NjdtNWc0bnV2VFNob1lNNUREK0M5MkpmQzBG?=
 =?utf-8?B?V1E9PQ==?=
X-OriginatorOrg: a-eberle.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be022f1-f952-470f-c9fb-08de10aa4618
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 14:01:04.0759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c2996bb3-18ea-41df-986b-e80d19297774
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rdIk/r+DvGPg012IVXYaE+mJmPW0OLC47uPODqDXWhvF2bAJkigdg93+/4ZJHabmRXvQQ/5zGdMhDdS7U86zAdi3T98EFP44DZWvq0rmfyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5836
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----EBF644B6FEA5972154CACB5BC699717C"
X-cloud-security-sender:johannes.eigner@a-eberle.de
X-cloud-security-recipient:netdev@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-crypt-policy: TRYSMIME
X-cloud-security-Mailarchiv: E-Mail archived for: johannes.eigner@a-eberle.de
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay146-hz1.antispameurope.com with 4crYqz2VGcz1mxb2
X-cloud-security-connect: mail-westeuropeazon11023124.outbound.protection.outlook.com[52.101.72.124], TLS=1, IP=52.101.72.124
X-cloud-security-Digest:09f5d02650dd48299c408eb2d531c672
X-cloud-security-crypt: smime sign status=06 sign_complete
X-cloud-security:scantime:4.006
DKIM-Signature: a=rsa-sha256;
 bh=gFEwdbiyYBRPJQvVCuWHkr4+msqzy+NjCHZiZ8gKZJU=; c=relaxed/relaxed;
 d=a-eberle.de; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1761055319; v=1;
 b=OH1004jDoOZlzVKT0SAzo/icUVdFvKMgn1J0PSUKk6OJ+H7tGVOltuwMvFDwQk6Z3NBYkUOh
 0Di/SvKLJ8oZM8+Ou1dXtYnOH5/xr2kkBjzQhqYyFMViMvmDD878+lBEZJM5jL6IVodGUwlmPxJ
 Y+/4hAZBDYlPeT2FyQBNFvso5T05niUktyRMeEfmnh4bhMqoEdMirS1K8qgWiOiJKAGhtApZvB0
 RWdNQWFWbWUHhw438XpV80oZpqAP8M0xv5iitkpi+lfRp+rA/GcBVocUHdRm+Uajfh0EMgGhW8B
 FzfgMQ73nm74G/2DiFgZClZnma98Uv08CattbINJMuTEw==

This is an S/MIME signed message

------EBF644B6FEA5972154CACB5BC699717C
To: netdev@vger.kernel.org
Subject: [PATCH ethtool 2/2] sff-common: Fix naming of JSON keys for
 thresholds
Cc: Michal Kubecek <mkubecek@suse.cz>, 
 Danielle Ratson <danieller@nvidia.com>, 
 Stephan Wurm <stephan.wurm@a-eberle.de>, 
 Johannes Eigner <johannes.eigner@a-eberle.de>
Date: Tue, 21 Oct 2025 16:00:13 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Append "_thresholds" to the threshold JSON objects to avoid using the
same key which is not allowed in JSON.
The JSON output for SFP transceivers uses the keys "laser_bias_current",
"laser_output_power", "module_temperature" and "module_voltage" for
both the actual value and the threshold values. This leads to invalid
JSON output as keys in a JSON object must be unique.
For QSPI and CMIS the keys "module_temperature" and "module_voltage" are
also used for both the actual value and the threshold values.

Signed-off-by: Johannes Eigner <johannes.eigner@a-eberle.de>
---
 sff-common.c | 50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/sff-common.c b/sff-common.c
index 0824dfb..6528f5a 100644
--- a/sff-common.c
+++ b/sff-common.c
@@ -104,39 +104,39 @@ void sff8024_show_encoding(const __u8 *id, int encoding_offset, int sff_type)
 
 void sff_show_thresholds_json(struct sff_diags sd)
 {
-	open_json_object("laser_bias_current");
-	PRINT_BIAS_JSON("high_alarm_threshold", sd.bias_cur[HALRM]);
-	PRINT_BIAS_JSON("low_alarm_threshold", sd.bias_cur[LALRM]);
-	PRINT_BIAS_JSON("high_warning_threshold", sd.bias_cur[HWARN]);
-	PRINT_BIAS_JSON("low_warning_threshold", sd.bias_cur[LWARN]);
+	open_json_object("laser_bias_current_thresholds");
+	PRINT_BIAS_JSON("high_alarm", sd.bias_cur[HALRM]);
+	PRINT_BIAS_JSON("low_alarm", sd.bias_cur[LALRM]);
+	PRINT_BIAS_JSON("high_warning", sd.bias_cur[HWARN]);
+	PRINT_BIAS_JSON("low_warning", sd.bias_cur[LWARN]);
 	close_json_object();
 
-	open_json_object("laser_output_power");
-	PRINT_xX_PWR_JSON("high_alarm_threshold", sd.tx_power[HALRM]);
-	PRINT_xX_PWR_JSON("low_alarm_threshold", sd.tx_power[LALRM]);
-	PRINT_xX_PWR_JSON("high_warning_threshold", sd.tx_power[HWARN]);
-	PRINT_xX_PWR_JSON("low_warning_threshold", sd.tx_power[LWARN]);
+	open_json_object("laser_output_power_thresholds");
+	PRINT_xX_PWR_JSON("high_alarm", sd.tx_power[HALRM]);
+	PRINT_xX_PWR_JSON("low_alarm", sd.tx_power[LALRM]);
+	PRINT_xX_PWR_JSON("high_warning", sd.tx_power[HWARN]);
+	PRINT_xX_PWR_JSON("low_warning", sd.tx_power[LWARN]);
 	close_json_object();
 
-	open_json_object("module_temperature");
-	PRINT_TEMP_JSON("high_alarm_threshold", sd.sfp_temp[HALRM]);
-	PRINT_TEMP_JSON("low_alarm_threshold", sd.sfp_temp[LALRM]);
-	PRINT_TEMP_JSON("high_warning_threshold", sd.sfp_temp[HWARN]);
-	PRINT_TEMP_JSON("low_warning_threshold", sd.sfp_temp[LWARN]);
+	open_json_object("module_temperature_thresholds");
+	PRINT_TEMP_JSON("high_alarm", sd.sfp_temp[HALRM]);
+	PRINT_TEMP_JSON("low_alarm", sd.sfp_temp[LALRM]);
+	PRINT_TEMP_JSON("high_warning", sd.sfp_temp[HWARN]);
+	PRINT_TEMP_JSON("low_warning", sd.sfp_temp[LWARN]);
 	close_json_object();
 
-	open_json_object("module_voltage");
-	PRINT_VCC_JSON("high_alarm_threshold", sd.sfp_voltage[HALRM]);
-	PRINT_VCC_JSON("low_alarm_threshold", sd.sfp_voltage[LALRM]);
-	PRINT_VCC_JSON("high_warning_threshold", sd.sfp_voltage[HWARN]);
-	PRINT_VCC_JSON("low_warning_threshold", sd.sfp_voltage[LWARN]);
+	open_json_object("module_voltage_thresholds");
+	PRINT_VCC_JSON("high_alarm", sd.sfp_voltage[HALRM]);
+	PRINT_VCC_JSON("low_alarm", sd.sfp_voltage[LALRM]);
+	PRINT_VCC_JSON("high_warning", sd.sfp_voltage[HWARN]);
+	PRINT_VCC_JSON("low_warning", sd.sfp_voltage[LWARN]);
 	close_json_object();
 
-	open_json_object("laser_rx_power");
-	PRINT_xX_PWR_JSON("high_alarm_threshold", sd.rx_power[HALRM]);
-	PRINT_xX_PWR_JSON("low_alarm_threshold", sd.rx_power[LALRM]);
-	PRINT_xX_PWR_JSON("high_warning_threshold", sd.rx_power[HWARN]);
-	PRINT_xX_PWR_JSON("low_warning_threshold", sd.rx_power[LWARN]);
+	open_json_object("laser_rx_power_thresholds");
+	PRINT_xX_PWR_JSON("high_alarm", sd.rx_power[HALRM]);
+	PRINT_xX_PWR_JSON("low_alarm", sd.rx_power[LALRM]);
+	PRINT_xX_PWR_JSON("high_warning", sd.rx_power[HWARN]);
+	PRINT_xX_PWR_JSON("low_warning", sd.rx_power[LWARN]);
 	close_json_object();
 }
 

-- 
2.43.0


------EBF644B6FEA5972154CACB5BC699717C
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
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTEwMjExNDAxNDdaMC8GCSqG
SIb3DQEJBDEiBCDcEvCw8dM9563Pg971mJhHFn9r9tQ9emF0JBRoQ0LtwzB5Bgkq
hkiG9w0BCQ8xbDBqMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUD
BAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAH
BgUrDgMCBzANBggqhkiG9w0DAgIBKDANBgkqhkiG9w0BAQEFAASCAgCz7sikMM34
mdCJCa6nPaRzYJ4o40e3cDAjymSDeXqiwKFk7ICL1sLTbMHIF4RaksfBs+GlspS3
WZ2eu0khtdjvQLN+RLJAFzY24eiG5++TlJuINx344SU5Y9B3nXxw1Vp/Og5pX45u
OjDyGm9lT3oICj7NsntGfayw27CdAQ/B8j9T0Ms0lxBMv5AkieOv6fv+REgtHKPV
h2+kVVThMNKCgu/+Aqu1+9LCd7c8fDZt3SJiZWxvtIkyQiLy2opnFO5pM/KHHW+6
PHZkODHtA0mWUZvjSt2AgQ9dcBD+2hKvgu5gHKhUx565njVGn5NoRqS/EfeEE/eu
Usm+Rwclxw/Dihrb30r3A7A8y82oPaZ/PE5vEXHKAM24aPqXUQ8/XKkW+z8fP5IQ
hitTTwSwb8QKOaI5d/LwU4sjpEOQ/qPVi5b0rnl5e3C8iY3/fhdZbYXmogtxw2ab
YUhiiJyj/KhJIm4XYh5h+7d04j0lwFHzw/LQ4zrqlyT2tqGhW10FIMGdr6QSyY4/
ob2HZSJQnooG1rXme3V8x87mPBhHcsbrfG6Ad8aSaLqVVKx7EChXLiq6jgLy9V5O
6dzoQdnbNpvyydlvGggya53fgz6jnVb82Vk5AC0nnl69c4FvxNoM55cyS+vAFWTv
MRb8RxQlc3A4Vc9FSeIoXUmEPT1Zfaj4BA==

------EBF644B6FEA5972154CACB5BC699717C--


