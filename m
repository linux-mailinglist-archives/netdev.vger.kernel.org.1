Return-Path: <netdev+bounces-161460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14920A21A05
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 10:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36AFC3A60B3
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 09:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D001A9B2B;
	Wed, 29 Jan 2025 09:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UldCWMIY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2B7191F84
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738143626; cv=fail; b=iBYCPETTddPu0gMmx+S0gwBIXQ3jlG+yMfNL9Ck9/k5naAScxWo8yZDfHBJTUGK1IGO0FF2Lt67rZ7767pPbX0TxaVWiyeuVj1YuBZoObL/CxQZM09lQSSx9EK3McBDxuU9wM2LyvD5cfcgl3WcQufC+n1M0GZDcd5nXXcjSs4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738143626; c=relaxed/simple;
	bh=G8O98xrMCTq0hZNXuhGvmY12mvxG7gwhnyBJqVKix44=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rhHD2xOdDJrwHW3vcZvMhGvtE5r/TROwww6TOVh7+QToCKyfnyJ+ddNW3fwhUe8h9N2OiPlPcbXIQKuL/8U5yZShA0zdM/OfCJaqNI8/lvmnCaWaBDrEqeEFyTMWDHsKYSP4TPydVWkfGyai9lMLyAGTdU2R2nrUiSiq2MHGEmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UldCWMIY; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vseuhDT4GTzAcYxTq5pfayHUorDJ/AoF+IPM/8Sfxggy5AS22Jt/QdEq3mNeb5Z2t3lpNYof8WkrVAzVlfruqWdtp+lZQeGP72kvk7oh9EaJtE8U4EM2/rtOFsJNdGyzR1HE8FZ1E/h0fXMTxZUqn58ixeKMamkiqjpFDQ1+RTL6Quwsj+aqJXqsNmYp8vwIqdWXOsxE0Vku42se3cGlGtfr796FCLCvnQtbYMV8WL8x4b129J38V8n/omQwanOys2GfW4oQXSndICrEEafO6X2SR45dr0Md3fSocBDOdYUBLeJNoFtTYcnBt7VCmf4+2vYwlql2mz+ea07hhWzpXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8O98xrMCTq0hZNXuhGvmY12mvxG7gwhnyBJqVKix44=;
 b=MP1Vi+yBmIfBemlasDGj2bJc9rcYUATCtZpcka1SZaTMbBWEhrqOpraQthl80c8D6dxqigTl7c0MaQWQulLa70/ixSECErik0In8PoMmPmjh3pCtcWvnl++Oi/h2bEz9SlE2uMfZdRTNNUswbsOdIRMrnlWugtxBM5gi2J0ODYZ9iBZmp2kqLBxxzz3QSFW7GCqLLVSli13Ydip9rbCPtRGqRpf27GymRFxXbqiHYMnOEQeYmMYio8Pet1oIgiANSwOAdSlFkw01+4XiP4+fm+i5bUqca7hROwJ6jchYaUxAx7uESGpYpen3fnh0fO4XcQjGfIUq2OluiarnRcP7XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8O98xrMCTq0hZNXuhGvmY12mvxG7gwhnyBJqVKix44=;
 b=UldCWMIY6quePIf84K7i8ZsgJNAHdJo1S5TMz2yYzdvVyTs5QTL/ix1qw+/K5Oic2GD0GwABI1hcXgKjtlfOqFNXLJB+c+1b8rKrnlAwssac/Pc1cpt2OzTouSP0qTh1L3VvriLTXlDNj0pubibuQkET3NRJdC27kdgCnFlmevzox4wdisROi9SX50tDaqUbeaN6wgPnXNAHUBK5I5jM6AFzX7qDo3jthG2p1IRaNSX/A37I/kPQgN91w9c8Hnl9REsJVPUZd/vMj9gVuxuwlq7t5racHNUeO7kbev+Toj+DhniQN2h3Mjb56EQ7O2qLvhPLt/ACL7UrKddewAnISw==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by PH8PR12MB6986.namprd12.prod.outlook.com (2603:10b6:510:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.21; Wed, 29 Jan
 2025 09:40:21 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%5]) with mapi id 15.20.8398.017; Wed, 29 Jan 2025
 09:40:21 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mkubecek@suse.cz"
	<mkubecek@suse.cz>, "matt@traverse.com.au" <matt@traverse.com.au>,
	"daniel.zahka@gmail.com" <daniel.zahka@gmail.com>, Amit Cohen
	<amcohen@nvidia.com>, NBU-mlxsw <NBU-mlxsw@exchange.nvidia.com>
Subject: RE: [PATCH ethtool-next 08/14] cmis: Enable JSON output support in
 CMIS modules
Thread-Topic: [PATCH ethtool-next 08/14] cmis: Enable JSON output support in
 CMIS modules
Thread-Index: AQHbb+l4mmigAbpb8kyWjZyRHuAtqrMrD+QAgAJznEA=
Date: Wed, 29 Jan 2025 09:40:21 +0000
Message-ID:
 <DM6PR12MB4516090628694AEA53EEB3A0D8EE2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20250126115635.801935-1-danieller@nvidia.com>
	<20250126115635.801935-9-danieller@nvidia.com>
 <20250127121258.63f79e53@kernel.org>
In-Reply-To: <20250127121258.63f79e53@kernel.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|PH8PR12MB6986:EE_
x-ms-office365-filtering-correlation-id: e0d8476d-7248-4063-9a9b-08dd4048f2e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VHVBYjhVTmdvOElZUXNSeiszRkU4UFFnNnU4L3JiSHNIMzdvSUxoSmJhTlZr?=
 =?utf-8?B?ZVlMR1BqUHJDb2RCYytkSDFhK2tXNWNncElvMWNWSVFEZnRjVGxtWGtQRDlT?=
 =?utf-8?B?emhyeXRKcjUzazJoR3dnZ3lFUGJISjJuTlNIV1UrNnU5L1FmcFRscG5aM1k3?=
 =?utf-8?B?cDd0NVNvenk2QW90aFpBdFBKcmtEMkdIdWNURzJXUGYzaGJnNkFkWVJuMHl2?=
 =?utf-8?B?emIwZGV2ZVRwWDFUaW5oQTlzYXJXeEZiL0UvOU95ZTNXTWdrQ08xdjF3UnJs?=
 =?utf-8?B?QitNWXJjS25PR2FUUkdnS3VDeDhFRWlhTDNaek4vVUlycjRmM1pPUVVxdWF5?=
 =?utf-8?B?Ryt6TlhuenBIZUZoQ0NNbS93NlgxYkpza3BMNklzT1BTMEdtTFJjeDk3Rkc4?=
 =?utf-8?B?RVAxUmNWTng4T0Y5TXFNaFAvci9WWUdqNnIvRHR1dUkwVVVVejFNRTAzYWRS?=
 =?utf-8?B?bUxXSVJaVUFQamRTVldxQ2xNUDd1RzljWk1QRzdlUEpVOVlhM0JhcEFCRzAz?=
 =?utf-8?B?OU1icXJIU2ZzanM4dk9tR2ZsZ2czdEtnNE02K1hOWnB4NzVNa2c3SGxNcThh?=
 =?utf-8?B?VmY0dTl3VTNsM1FEL3NjSWh5aVJzTlFtWnU0czhrVjJlV3pFR1hENDdrSUdw?=
 =?utf-8?B?eU1tM2U0amZoQjRaMlVudVE3QWZpTlhYN1hoUkROWndhWU9sa1JNOXNhLy8w?=
 =?utf-8?B?eDRDV3ZLSS8yb2ZYREQ2M0lkMTBQTzVpbWF2ckFReVNSenZGakZpK3ZGTFl0?=
 =?utf-8?B?S1hvSmg3Q0dNV0lTTzdtc212R0p3cml4bXdnSVBxdjAyRGVhTkhxSWNrbEVx?=
 =?utf-8?B?NHlIYnQxYkkzK1EvdWFma2FDN280dkR3SkhqMEVQS0hpSlViWGNtV1FjdUx0?=
 =?utf-8?B?SCthZjVlT0tsOWVMVkZLejhDS09GQ0Z0MTZTZXhQVXViMGxpa0VwMkp2dW1x?=
 =?utf-8?B?ekJtaUg0ZnQyMDdrME41dm5ncVA0VWlGWmtQMXhTQjZtS0RoT29lam5FemZK?=
 =?utf-8?B?Qmg0WXRxbG9mTUZQWnBheHdQdFVaYmxYaytqK0t4T1ZkYWwrYXVHb3VrZVF2?=
 =?utf-8?B?Q3ZBeGhQUDcrUkRNbDRFOWhCZzhpUmJ0cTFncU1uMGU5UmxIQnB1bW5oWFhw?=
 =?utf-8?B?YUh0NklBa2FpWXQwb1ZySkwvVnBVNnZpS1gzbE9kQWFuSTd0Ym5YSGI4RFNV?=
 =?utf-8?B?Mk8wSkZialZvS3lxaG5xa0o2bWdQVDl0VlVUYW9pV1BZYkdWejExUjR0UXEr?=
 =?utf-8?B?dTRuNnZod1VJM3hCSDVlZkZrOXpIaGJUWDJQdDlKZjBEZDVFaXhPbjdUN1NH?=
 =?utf-8?B?R0hWbEd5VENldzEyVVNtV2ErUkdrSW9tN2Q3L2dCVGkzd2p6MG5NNFZ5K0M3?=
 =?utf-8?B?cnlVcFhoOUhiY0J3NjIySTZTcEpIajFPdStJeXR3eFBDOHJQWTkrOFBuM01y?=
 =?utf-8?B?WFBna1Fsc0o2VCtoVy95MEJHYzZ1ZWJUaXFadUE0ck9VUUVMTGFnRlBqYVVY?=
 =?utf-8?B?NUdpS1BSYUFOalR2dGFsRW94bHB3a0NHMnBKdE8wVFpJZUJTQVlwc21tUXhj?=
 =?utf-8?B?RWdieHRHN0pOdjAyR1o0UzEvQnE2bXVzenQ4bG1neVJWL08xcWJtbnljSlk0?=
 =?utf-8?B?a20wYUhVbjdDRjFUejdoRTluc2RNQ0dQMVhLU08ySkk1N2IrYld6VHhXRXZX?=
 =?utf-8?B?VDVONGxKYnRsMzJPaHM3WVBIQTlhQ3h2T2ZTRWJ5Z2tJU3N3UmtIaVFFMU41?=
 =?utf-8?B?QVIzdm1qSG9XZnV1aVN1eWZ3Yk0vRWJuV1NuZ0dDcXFJR2JoNnpidFVJZDdy?=
 =?utf-8?B?dWdYVmU3c2Z0ZndablJZTTdYQWFCK2tjMmcvMUYyckpFRXpBUm1VbWlRdENT?=
 =?utf-8?B?cVZ6NVhzbWZrSWNWTVBHMU9GcmJoa0V2ZlhmOEE0SnNGcnByQm5KeUpub2J2?=
 =?utf-8?Q?5j22+K5I0TOYJQTNEyO/wSS6hFyY/yQX?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WXgrU2NmQityTkdSRUlLRXg2cWE4d2ErdEgwS243N0xQdWN1bjFlOHM0UklU?=
 =?utf-8?B?Y1Uvak9aK0NpWXN2WlloenNKRTFLUzZuNEJRQStCZDdUeFh0YzJyY2VaVTJK?=
 =?utf-8?B?YWo5OXVIMDduQ3BhMTdRd1E4ZVhGa2tvaU04elAzQS9BUE5yNkFFbHlKZlJL?=
 =?utf-8?B?aEdSUzZuQTFXeHZkVXNxOXdLR3A3Mmc3VGVtZlFvd3QzMWhwcjRTeDFlSXVn?=
 =?utf-8?B?VUh2OEFsbE9MWmZLRmtTM3loZk9ZSnlXMGxMN2QrNkJBVGt3c3ZSaVZkK3d1?=
 =?utf-8?B?Wlo5dWo1Mk5LYWt0S2l0Qi9NYk1JNW91cVg5N3Ewa0NMcU9USG1QTEVTYUhB?=
 =?utf-8?B?SUgvcFk2YXlvK2pOeGV0UkxoMXpyS2tacUp5WEZKaVM0U3NvU3BtWXQvMWlI?=
 =?utf-8?B?SlVYUzAzdHpacnlidWFiU0VuamJIZ2VIMVZjT2wxRVM1OXlrRXQxaTcwd3dl?=
 =?utf-8?B?Z1FVQkJXYjV1TjRlemZMMWN5OWZEZHphVEVLRmlhemVGUGg1RDhBM1JsUW5F?=
 =?utf-8?B?VzRQWkpDVEhtNTd4SG8wQ2lzZUsybll6Zlgyc2JFeWFqVTNkWFJWVEkzUVA3?=
 =?utf-8?B?anRjQ1JwS0cydnd1Uk5IdHQ2NnFLKzcxVExwNXY1NVhkNVVtRjBGOFA4dTRL?=
 =?utf-8?B?eEM0MXpkSWRIdWxRS0gxbnVjbXVyV0ZBTng3bFR3QUdIUjNqZnZ6L0NpMVA1?=
 =?utf-8?B?NmFJeVdKRm0yRnZsRzdzclh3RmdIMGhybmtsODZTRVVxb3RqOG9Rekh5dFpr?=
 =?utf-8?B?cmZRT3VuVTlaTkFOSG9uaDI3eElDaWh3aGRoV2FOU25XSWppVFVsR0hrZUtl?=
 =?utf-8?B?bUZ5dTNWZkx0bkdMSjVTWWlzSEJhY01EcGN4VTVzME00SVEyZGNwcHcrWCs3?=
 =?utf-8?B?TlU2TlNXK1hvaXJyU0ovdXRTV0dpRkxQNjVHNkx1eGNhdGJUbGJ4T0IzekdS?=
 =?utf-8?B?MDZXWENmWTZQYU5YT29nM241dmhBd0JqUXlZa3U5Z2hzeEtZQjNTb1p0RUtH?=
 =?utf-8?B?S1hKekdBOUJQek03TzZ2TVlxd2ZGcW1uUnZzaGdWbEZsamJ5Q1Q1RUJ5LzJJ?=
 =?utf-8?B?bzZsM05kRkJ4a0VuYmpNdXlRRHNJTFVuT3NZemRmbUp4WENPYStRNU1tNjlj?=
 =?utf-8?B?UjIzYWJob1EvbFJuLzhGYitFY1pnZ3lUK0ZFTjdUQXBDTHNQays4V1NpS3Jh?=
 =?utf-8?B?WXEvQkFJRHR6czNndVFqWE5Pd2x2RzhvRnZveWZXOUdCV3E1WUFDMnVhWEQ0?=
 =?utf-8?B?bWs4NjY0S2hnRkdpTXhOVVUrbXhoRzYrZ3p4TSt5bmRhQkt4cDY2VStXK1k5?=
 =?utf-8?B?U1B4amkyWGE2MTZZVEJnb0x1a2RiWDFVQTN5VUFtOE4vVXJVNzR2UlpRMGFi?=
 =?utf-8?B?OHdoamVsQWZXTVB6aCtBVkJvSURpRzVIUGs1c2JlN1V3NWkzTVhJaisvZlVG?=
 =?utf-8?B?Z200RzJ3amg2WGh5OVoxblRWU1hPMTdVZ2EwOTd5ZG5aeGlQSXFTbE1zUHJi?=
 =?utf-8?B?aWJkMVRRM2l5OUd5TXNLZXA0RE00MGxTdzdZbVdQZG8wZDZsalU2VmxwaVk0?=
 =?utf-8?B?aVdGUlhKdE5MSm1NemY5ZFlDUkRIYkZxYXhDWTFhdnV2Q3NMQWU1bDhnM2Rk?=
 =?utf-8?B?czlKMVZ4d0ZGMUJXMHBBOW9NSzJTS1ZqNHcwRExnNXNaSjVuRWZxTWJtQmJq?=
 =?utf-8?B?MnYydlVxanZ2eG9CcDJvZzlqTlc3MGhmUVExS2xKZlB4SjU0T3UvbGdYRmxH?=
 =?utf-8?B?cXFhMER0MUhyOGxaZFZaMzkvVm51UHc3TUNtOG5FQnVKcWFCc28xYS9LcnpE?=
 =?utf-8?B?Q2NUNHV0RGNzSis3aCs0ZVJETWxPdHE2dU9jSG93ejkxYmtPRmF4TUNNY0Ro?=
 =?utf-8?B?TVQ1VERUdytBRTlyS0VPdkM5U05KVjlqajNCNlNZdktlLzlabjN4Y0greGgr?=
 =?utf-8?B?YWVpK1lQWkpHa2lHcjJjaWNEOXNSOFVHRS9YZ2w2Y2hjZmxKQXFZL25ieDI2?=
 =?utf-8?B?ZzlZVnlWLzhCUWI0di9neEttYkFBU3FnQVJKaGJZMjJiclVhZmVTNDhQTjdE?=
 =?utf-8?B?S21RTW5Yb1l2V3ZkVlZDZWJiZktvYnJUMXVqWmdqeFdNblEwT0lERVV3bTQv?=
 =?utf-8?Q?kJaXeGtm2Rqln1Ej4VywhkJsy?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d8476d-7248-4063-9a9b-08dd4048f2e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2025 09:40:21.2786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GBkbs82k1inVDw5BSAivZ1tHril2i5dLCYlFqDieaTWZmEknOrDbMvQJzKBFfC2xWFitu1d/rnTqPZnhqtLubA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6986

PiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXks
IDI3IEphbnVhcnkgMjAyNSAyMjoxMw0KPiBUbzogRGFuaWVsbGUgUmF0c29uIDxkYW5pZWxsZXJA
bnZpZGlhLmNvbT4NCj4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IG1rdWJlY2VrQHN1c2Uu
Y3o7IG1hdHRAdHJhdmVyc2UuY29tLmF1Ow0KPiBkYW5pZWwuemFoa2FAZ21haWwuY29tOyBBbWl0
IENvaGVuIDxhbWNvaGVuQG52aWRpYS5jb20+OyBOQlUtbWx4c3cNCj4gPG5idS1tbHhzd0BleGNo
YW5nZS5udmlkaWEuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIGV0aHRvb2wtbmV4dCAwOC8x
NF0gY21pczogRW5hYmxlIEpTT04gb3V0cHV0IHN1cHBvcnQgaW4NCj4gQ01JUyBtb2R1bGVzDQo+
IA0KPiBPbiBTdW4sIDI2IEphbiAyMDI1IDEzOjU2OjI5ICswMjAwIERhbmllbGxlIFJhdHNvbiB3
cm90ZToNCj4gPiAgICAgICAgInR4X2xvc3Nfb2Zfc2lnbmFsIjogIk5vbmUiLA0KPiA+ICAgICAg
ICAgInJ4X2xvc3Nfb2ZfbG9jayI6ICJOb25lIiwNCj4gPiAgICAgICAgICJ0eF9sb3NzX29mX2xv
Y2siOiAiTm9uZSIsDQo+ID4gICAgICAgICAidHhfZmF1bHQiOiAiTm9uZSIsDQo+IA0KPiBXaHkg
Ik5vbmUiIGluIHRoaXMgY2FzZSByYXRoZXIgdGhhbiB0cnVlL2ZhbHNlL251bGwgPw0KDQpBbGln
bm1lbnQgYWdhaW4uLiBJIGNhbiBjaGFuZ2UgaXQgdG8gZmFsc2UsIGJ1dCBudWxsIHNlZW1zIG5v
dCBoZXJlIGFuZCBub3QgdGhlcmUuDQoNCj4gDQo+ID4gICAgICAgICAibW9kdWxlX3N0YXRlIjog
MywNCj4gPiAgICAgICAgICJtb2R1bGVfc3RhdGVfZGVzY3JpcHRpb24iOiAiTW9kdWxlUmVhZHki
LA0KPiA+ICAgICAgICAgImxvd19wd3JfYWxsb3dfcmVxdWVzdF9odyI6IGZhbHNlLA0KPiA+ICAg
ICAgICAgImxvd19wd3JfcmVxdWVzdF9zdyI6IGZhbHNlLA0KPiA+ICAgICAgICAgIm1vZHVsZV90
ZW1wZXJhdHVyZSI6IDM2LjgyMDMsDQo+ID4gICAgICAgICAibW9kdWxlX3RlbXBlcmF0dXJlX3Vu
aXRzIjogImRlZ3JlZXMgQyIsDQo+ID4gICAgICAgICAibW9kdWxlX3ZvbHRhZ2UiOiAzLjMzODUs
DQo+ID4gICAgICAgICAibW9kdWxlX3ZvbHRhZ2VfdW5pdHMiOiAiViIsDQo+ID4gICAgICAgICAi
bGFzZXJfdHhfYmlhc19jdXJyZW50IjogWw0KPiA+IDAuMDAwMCwwLjAwMDAsMC4wMDAwLDAuMDAw
MCwwLjAwMDAsMC4wMDAwLDAuMDAwMCwwLjAwMDAgXSwNCj4gPiAgICAgICAgICJsYXNlcl90eF9i
aWFzX2N1cnJlbnRfdW5pdHMiOiAibUEiLA0KPiANCj4gSG93IGRvIHlvdSB0aGluayBhYm91dCB0
aGUgdW5pdHM/DQo+IElmIHRoZXkgbWF5IGRpZmZlciBtb2R1bGUgdG8gbW9kdWxlIC0gc2hvdWxk
IHdlIGFpbSB0byBub3JtYWxpemUgdGhvc2U/DQo=

