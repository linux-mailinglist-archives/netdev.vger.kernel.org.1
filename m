Return-Path: <netdev+bounces-184337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05891A94C24
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 07:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C34741892650
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 05:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA56B1E9916;
	Mon, 21 Apr 2025 05:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i1vvmjZT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CB74A3C;
	Mon, 21 Apr 2025 05:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745213646; cv=fail; b=cQHnvaIgY9uMT7f/7ql5hpGelDPN4b4i3UwQmbJTvqLtLTlzWgTda3zI18Mk4zj2HfmqVUe9kMN579r8mLrC1TJ+TfG0GWK/CuKBOOL+lAD6naI/pv9SAizrM3BOZlQARyMRhKzaH5vjyTZHF+tEGLu4g2Np3i9TYYGEWfY32wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745213646; c=relaxed/simple;
	bh=IaQyC54gTUeFpC9DhlDvDskpNSgKXPoU7GqKayL+moY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XI5FLFlFiKwkXQ61edlN8b32tXIUg6bpmdbsAM0BpbwFrjCFURlTScGdm/uUT3w7rjWFw/vkVoYsBIFuFjD7FjLWu/RG7lFJQKc404O7DyJrUjPHZgMHu3W5lzi/B62CY5AZH1uzct36N6LCaLl3GtpJ0PQ5jDdDBaL+ZV7aFDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i1vvmjZT; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iH+ZYt5Ow2wTWBZJuva+HDYAPjgfAKSj9Yl5zhw1yK2Jh5EbM6sjDkCPqh29UfLzVBNHpz2ZpfzGbwIOKcPd1xHMiZpfv6XSiCRUapcIe75u5cdN51/v8X9WAFRIPec5vQjPErPASR+b83LbSMWiRGcfORJV/oJLb/YAKUnHGWfJlL/tTQY3y9NM91jyLLfpaJUQg++ZsCjAzoKbvAZOwFv7wP3x8Lxp+ZSuwFXATVELzKJGCAo3EcE5kc18H6SxzGlIL9kKgsemuU4OicsSOEZhLKVmGrSguc/u2MytIx99GrxulURO52bhzEeZmP3TZ+HxRB2u1PzKW7XOHgJoEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaQyC54gTUeFpC9DhlDvDskpNSgKXPoU7GqKayL+moY=;
 b=cwCdfJDFolN78JEkN5cNnAifwRPNq+IofOWsU/UqLr138jQE4LlfxFx/qZtH5BVqNdIkzYVpcCrl/FbkezMOlgyj9mOUS5gh0B8ISDmQVFoXpDKSjooGzW599ah88wnmwuwsf0dCp8IDklFLCDy0tm+CI27QVQ5uVRbmAGUPCLHUr/m9f1Jnb9BwPLWVMjPKZRJiQ/6XVO/95I8qze4SZKyb71XihkyEGK5mk1ytQDWMeXLpnHwJpATQjJXUmo4OfJR/Q2pE2V+wjO3esjsJJHw7Ug6tcOyVugAHfgC2DpJZ4/wb2j2fKUILdAC5Li2Vv2us1kGgiUN70bmCrvLz/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaQyC54gTUeFpC9DhlDvDskpNSgKXPoU7GqKayL+moY=;
 b=i1vvmjZT7EgBSJC8g4BMUnQQ/8SLHh1JKX83boMrQ9hyaBXAxg0+5Geuh9x5SsyrhYwO/xrio2lqRyjMzpBLLzhtxjEK7RDloGARrP8LEyket6+lWnoCqd3wpTRM3kdNajtRSwsIgT8zzJhGldfQZ/ORz7FdBp0P4GJK+hdVAWA=
Received: from BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18)
 by DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 05:34:02 +0000
Received: from BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6]) by BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6%4]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 05:34:02 +0000
From: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
To: Colin Ian King <colin.i.king@gmail.com>, "Pandey, Radhey Shyam"
	<radhey.shyam.pandey@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simek, Michal"
	<michal.simek@amd.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] net: axienet: Fix spelling mistake "archecture" ->
 "architecture"
Thread-Topic: [PATCH][next] net: axienet: Fix spelling mistake "archecture" ->
 "architecture"
Thread-Index: AQHbsFSL/Mj1kF7EaUybL+UivlLcN7OtnIRA
Date: Mon, 21 Apr 2025 05:34:01 +0000
Message-ID:
 <BL3PR12MB6571DC0AA8A521078E442E48C9B82@BL3PR12MB6571.namprd12.prod.outlook.com>
References: <20250418112447.533746-1-colin.i.king@gmail.com>
In-Reply-To: <20250418112447.533746-1-colin.i.king@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=597de204-3808-40e3-833e-34778afd968f;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-21T05:31:10Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6571:EE_|DS7PR12MB9473:EE_
x-ms-office365-filtering-correlation-id: d22b5d9f-b5eb-4ffd-b01d-08dd80961f7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TjVhQVdGSDhsVGMrdG5yT2tYSm0raGR0dVNLdDR6WnVWU0xFRkZ1cEhyeTgy?=
 =?utf-8?B?Si9qRmQyTUc4Y1JXaHJrblJIZ1dINDRIa2o1RDI0WnNXR09pVGFua0RpRlVr?=
 =?utf-8?B?ckR0eFF1T053dHZyTzJNRktLVDg4L0x2TW1NUmgxYmpZaC9wTlM2bGg4NnIr?=
 =?utf-8?B?bi9ZQW5vaDEwUzJhYzJuNHE0SUx6djBmcWYwU250OHBOMG9ydkFFVDhuVll1?=
 =?utf-8?B?TGpmMHNsM3o4VHpmM2ljTzhwcVBPWCtVOHRhMmQzVlV2dHROMHpQRUZUSlpx?=
 =?utf-8?B?QUF0RzlSdkFSdjQ1TVRvSWxBYlUvU0lZQUF4eGVQM2RPaWhLZlVsR1N6MHVi?=
 =?utf-8?B?OXovTnRUZDRUb2JDS2FaQkUzL0h5NklUUWsvYkQ4R2gzNG5YQUNVR0xtdkhK?=
 =?utf-8?B?Z0tuTEZ4bnZRYjh3d1RIZ0MrQm9PRUVYcjYyYysyY2xsU1hzamYrdFpENXho?=
 =?utf-8?B?bDh2WTloeWRHUWdYVjhHUEVGYTE0ZG9ZUWpvalhKZGtxa09oUm1ncmVSV2sx?=
 =?utf-8?B?bXZSMWlvSUpLQjNodXVMZEFGVmQ1QWN5ZkRXUFh2U3VDUzNZaUxMVjBNVnRj?=
 =?utf-8?B?a3hJS1c4V09HOHhmUDZJMDhRUGpZNnNMcmw1YW4wTWtVUlRZRElKNXNHUTk1?=
 =?utf-8?B?MHBMWGl6bnNKNHM3U2t5dktJM21mV2R3TmY5Y1hzdFRNQmhacklZejNzY3o3?=
 =?utf-8?B?bUVqM3NCTDZWOVEzeHpKcjQxZGsxK0tDK0tzM3UwcG5aUWhkZXhsTjlnUnFN?=
 =?utf-8?B?S1YyZWN1VlJTQk4waVM5TkZpRFVyaVZRcmlVcWdUblB3cml1aE5MUlNHY2JF?=
 =?utf-8?B?YVp0ZDRTejVpTm8yQjlRT0JLUWtWM3JKUlFKVjR5c3ZqMkFibjhTVXhkb09y?=
 =?utf-8?B?akIwenQwSWY1N2xiU0ZtaVlBSHpERFhDcHMvZXh3MEFCdGFUU1ZWOWJlbWJx?=
 =?utf-8?B?TzZjTFNsZEgyNjlodHJKbkxxR0JuQ3k5SThmdmdEdGRwaTNiSlpmcSsra1Fl?=
 =?utf-8?B?ZVM3aVNuRDhDSFBUZE9CY0tsS2gwdkpiMUJ6Q3FmcUVUeTlrV0xyWlozbjgy?=
 =?utf-8?B?OUxxdjJnWFBST1JiekdmaE94a0FjUm9wRFNKTEhvelpvdk1kSVhKREQyY0pv?=
 =?utf-8?B?U1pNWVIwNnNBUWZlbzlKdVVqVFg2VERlTkdkYjhtZGNjVTlKbEEyRWlOVmtI?=
 =?utf-8?B?THUyVU1tTGtZWEZRWG1tTmRJRE82dUxUaE5PUCtjL3ZMNHRpSE8vYzJQR2dJ?=
 =?utf-8?B?MEtBQWVzeHA3R3RCQ0VsVFZVMWhpSk5YSWw1dEMvMGdPNUNaTlVNalJnTkJp?=
 =?utf-8?B?VXZTUXRWclNNNFZweVRKZTVIeUJZdkpwWWtOb3htUHpEL2NmVDdVYURKV2hk?=
 =?utf-8?B?bDE3Vzkrb3cxMmdPejFIMGh2bmE3QWhmUTU3R2RTdkUxZXc0N29Ld0UwdUZx?=
 =?utf-8?B?NHk2VjBWejBuRTFzendYRDg4UVVUcjlXZzB6ZGk3N0pSNjR3aFJXTkQvTVJO?=
 =?utf-8?B?SnZVK0hDdURzZFN3d2dtcnFoVndqTFFLZHJ4bklVc1gvQWc1b1M4aVorOXdL?=
 =?utf-8?B?b3BqYjZ6eUlzazRML2g2V1ZSUHNWR1E2TFg0VDVPT1Uzb0s2N3NQbUxZZnBy?=
 =?utf-8?B?K3NZK1FUZ2FoQTVpdDRxN21VVTVYSEplYzhuTjNlYjdRYy95b0U0NkZGeHFB?=
 =?utf-8?B?c0IzOWhGMVVoZE5nUGdiVTZ5UXBQbm1JYTE2Yy9vcXk4anZna3YrVlhmZnAz?=
 =?utf-8?B?bHBKY09jenVGUktUWmlyYktMYjJJUDYzWjNxUmFuNGFoTTU5cU1kbE95REht?=
 =?utf-8?B?Yi9xVTlnZ21VdmIwejZLbi9IUmtYclRWRFJDOEoyMlRvaVZ3bHE1VWRQOUdp?=
 =?utf-8?B?RHkwaURDZGRDVG42RllQTzB4M0hPbFBYQm9obzJCSFlPeWh1MFpZd0dWL2J0?=
 =?utf-8?B?RXFSRlRDaDJ5ZDhMdlc1RjdMaENUaWs5MHpMdU1FSFdHa1Roc0Fpd1haUzVJ?=
 =?utf-8?Q?uAbpfPpWj4vxkBYKrMJsF070K0GLc4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6571.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?anJCSHUrdUtvcjNwQVFUWWsrdDB1YmM2Z3BuRXhDUGw5TnJFUDZJNTgwOE1n?=
 =?utf-8?B?N014OXluYmZsQy96N2l1SDN5SjVMa2RYUHpralRGU0RQaDNyOUMyVnMxTzV0?=
 =?utf-8?B?cmU2ZmZtWUkwTkE0YjNRT1Raa2tScmhVSjErRzRKUUx5eFhPVkxiTEhweGxF?=
 =?utf-8?B?OTRZOFlaa1R1b3Fwb0EwbTZhL0N3VnVsT0NBZE5tdEJvZGVyeTlzdUk3TGZv?=
 =?utf-8?B?QTJ3dE83YU02NHkyL0JFVUJ1b2VubTRTejA2cWpLZldyL3hUQm1kb0tnd1N5?=
 =?utf-8?B?S09BZ3IwZWhHV3NFbVNjOHB6ODJDcisvRTd2cEtKMHpEbXdXQnowRXFZdzB1?=
 =?utf-8?B?WFhtVzBxZzRuOUUwR2oydEJhL2x5Y3V1cFhxZ05EZlBBN0M2aXFRRHZzK1N3?=
 =?utf-8?B?NXA0VUozMXhSMERhSHdWMEZrVDJzM2JhL0NSaXFIbnNkVzFlOFlLUzJFck92?=
 =?utf-8?B?MjdPQTFkOThlRVBmMStKYUwrTDlDQzhsdXA3Y05GS01wNjcvMFRJWEZraU1S?=
 =?utf-8?B?MEpJMzk5c3c4ZDhMVzJ4N2tJNDA4UXFjNVBNRVJZUkV3dXo2VFJpZ1RqdHJm?=
 =?utf-8?B?QTNPZTkxK1FJOXh1am03UjB6R2lZTjdRS0lnK1NJYU5jTUhJSjhPWDBNVXo1?=
 =?utf-8?B?bnA0d2VDOVhXanZjNktrZlNsSnVGZ2NsSFE5R3RUOWtVeUpyMSsvekRHdnBi?=
 =?utf-8?B?RWF1WGpHUzBOVGVxOUM0dHBadWhBZFgxM0RQalVvVVROZFR6TGIrOEx5Q3BC?=
 =?utf-8?B?cXBUcU45QmlpQW0wQVNBZ2VpZWFZU0FKZWNsL2hQOU5DcEovWnZQc2ZZWVJE?=
 =?utf-8?B?SlZDcDRlclVFVDl4dnFDVmdERzh3V2wzWlFlTHJXWmVKZStYYWdSVTZ6TGxV?=
 =?utf-8?B?V2FZWXJaUTdEWkRsV0RDd1I2TVZWTVFEREdyQ1FBaTNoTGlYaDNrbTE0V2Yr?=
 =?utf-8?B?TG96ZWZvdnJ5ZG1SMkprOHpkT09hSWlKVE81Yi9UMS95YnhWNE1mbFN2blVQ?=
 =?utf-8?B?bkowUG9lbVlDZXBOL2FuQ3owRnpBeGd0TGRpMm42d0QrMUE3QjRWUS9BTW14?=
 =?utf-8?B?Kzhoc0llMGhKV0xzQmUzQVdpc3Q1MjBaRFRXRXgyWWg2Vi9wQ1p3ZFZlMFRl?=
 =?utf-8?B?R2xDWVdOM0RycmhHa3lseDRpRTd0aEFlVHlpUDVSSEdoSGV4T09FSGZtcDZ4?=
 =?utf-8?B?ZFhtT2lWRFJEN0U4dk9UTWRVQ3ZnMGRtWkVXbFNXMWdMUWl6d0tPaFBUMVV2?=
 =?utf-8?B?bTRFak9mNTVhSTg0NUhHTmR1Nm5mak1RUVJxeFlrNmxFdkRlK0RzSjJ4eGlN?=
 =?utf-8?B?ZlpWUFBVeElOOWwwNUorTlZyVmd2d2tOUXNyYk1uaGYxUTJtb0JHcDFLM0NF?=
 =?utf-8?B?NDB1ODFRcEdJWXZUWmpONTZWRHJGb2NoU1hieCt1cVRuTHVQNmFsRWZHMjhp?=
 =?utf-8?B?dEJEWG0zYzkxbjZQNjE4WkgyOHIzZlNsbzZCN1k3SHZZMjI2Z3FiRHdUbDZn?=
 =?utf-8?B?d2JzT3hCZjZoN3BZZ2ZMTHZoMzQxeDM0VllWcWEwOXh2VmoyNTdTOXFMOXFr?=
 =?utf-8?B?YTBmbjVTM2hoVk1tVmxtWjQxMUhEQkJMNFNxNUxmUE9JOGlMTDBDZk9pV3pn?=
 =?utf-8?B?cm1rQWNrNXEreTZ6cmwzWXM5QklpTXVidU1rVVhINTI1YU4yVkFjbXp1UlRt?=
 =?utf-8?B?cnNacktLV2x0ZE9rRExHelFMd201TG9CdU5HblEvUE13YnN0UHgrQ0kvVjFT?=
 =?utf-8?B?djVCOUt3aEhxR1JxZUl5d0FqVWl5THJEUVZSbHE1VFV5TlJOekdzZlVza3Rs?=
 =?utf-8?B?ekhHWmx3QVIvKzc0b3BmOEV5RW9yZG0xcWEvRmg3UTJvYXRCbll0dzBYQ3Jk?=
 =?utf-8?B?d0UrY2gyVkJEWm41enZYWFh6dE8xNnBqaWpZc2J6eE9DNEFtVmFuWFRNLzFz?=
 =?utf-8?B?NnNBUjRlUC9BMHpnR3kzNFFTQkRwYUpJaGNOWDVWb1RVZ1EwR2cyU2U5RExH?=
 =?utf-8?B?Uk1BODBUdG5CdFIvTFlpMC80dVUzeU1OcDFwOGVMV0FVemEzQnFmRlpFRm1S?=
 =?utf-8?B?dFVRYXh6UEV4OG9Wc3FUbENLaXV2a296bWVlWUtSRWpZTkFHUmhOeE5QS3dI?=
 =?utf-8?Q?3QTc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6571.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d22b5d9f-b5eb-4ffd-b01d-08dd80961f7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2025 05:34:01.7581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RPrT9FvVdalLzh3MAyYWsNzAnyn/N/A0Wc1PkAMfInJUwBgx/6JRzf8gLadOOQbpdaaRr6U0M0Va+y24J5XJSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9473

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDb2xpbiBJYW4gS2luZyA8
Y29saW4uaS5raW5nQGdtYWlsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBBcHJpbCAxOCwgMjAyNSA0
OjU1IFBNDQo+IFRvOiBQYW5kZXksIFJhZGhleSBTaHlhbSA8cmFkaGV5LnNoeWFtLnBhbmRleUBh
bWQuY29tPjsgQW5kcmV3IEx1bm4NCj4gPGFuZHJldytuZXRkZXZAbHVubi5jaD47IERhdmlkIFMg
LiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljDQo+IER1bWF6ZXQgPGVkdW1hemV0
QGdvb2dsZS5jb20+OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8NCj4g
QWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsgU2ltZWssIE1pY2hhbCA8bWljaGFsLnNpbWVrQGFt
ZC5jb20+Ow0KPiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcNCj4gQ2M6IGtlcm5lbC1qYW5pdG9yc0B2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIXVtuZXh0XSBuZXQ6
IGF4aWVuZXQ6IEZpeCBzcGVsbGluZyBtaXN0YWtlICJhcmNoZWN0dXJlIiAtPg0KPiAiYXJjaGl0
ZWN0dXJlIg0KPg0KPiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4
dGVybmFsIFNvdXJjZS4gVXNlIHByb3BlciBjYXV0aW9uDQo+IHdoZW4gb3BlbmluZyBhdHRhY2ht
ZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+DQo+DQo+IFRoZXJlIGlzIGEg
c3BlbGxpbmcgbWlzdGFrZSBpbiBhIGRldl9lcnJvciBtZXNzYWdlLiBGaXggaXQuDQo+DQo+IFNp
Z25lZC1vZmYtYnk6IENvbGluIElhbiBLaW5nIDxjb2xpbi5pLmtpbmdAZ21haWwuY29tPg0KDQpQ
bGVhc2UgYWRkIEZpeGVzIHRhZyBhbmQgdXNlIG5ldC9uZXQtbmV4dCBzdWJqZWN0IHByZWZpeC4N
Ck90aGVyIHRoYW4gdGhhdCwgY2hhbmdlcyBsb29rcyBmaW5lIHRvIG1lLg0KDQpSZXZpZXdlZC1i
eTogU3VyYWogR3VwdGEgPHN1cmFqLmd1cHRhMkBhbWQuY29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVy
cy9uZXQvZXRoZXJuZXQveGlsaW54L3hpbGlueF9heGllbmV0X21haW4uYyB8IDIgKy0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQveGlsaW54L3hpbGlueF9heGllbmV0X21haW4uYw0K
PiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3hpbGlueC94aWxpbnhfYXhpZW5ldF9tYWluLmMNCj4g
aW5kZXggMDU0YWJmMjgzYWIzLi4xYjdhNjUzYzFmNGUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
bmV0L2V0aGVybmV0L3hpbGlueC94aWxpbnhfYXhpZW5ldF9tYWluLmMNCj4gKysrIGIvZHJpdmVy
cy9uZXQvZXRoZXJuZXQveGlsaW54L3hpbGlueF9heGllbmV0X21haW4uYw0KPiBAQCAtMjk4MCw3
ICsyOTgwLDcgQEAgc3RhdGljIGludCBheGllbmV0X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIH0NCj4gICAgICAgICAgICAgICAg
IH0NCj4gICAgICAgICAgICAgICAgIGlmICghSVNfRU5BQkxFRChDT05GSUdfNjRCSVQpICYmIGxw
LT5mZWF0dXJlcyAmDQo+IFhBRV9GRUFUVVJFX0RNQV82NEJJVCkgew0KPiAtICAgICAgICAgICAg
ICAgICAgICAgICBkZXZfZXJyKCZwZGV2LT5kZXYsICI2NC1iaXQgYWRkcmVzc2FibGUgRE1BIGlz
IG5vdCBjb21wYXRpYmxlIHdpdGgNCj4gMzItYml0IGFyY2hlY3R1cmVcbiIpOw0KPiArICAgICAg
ICAgICAgICAgICAgICAgICBkZXZfZXJyKCZwZGV2LT5kZXYsICI2NC1iaXQgYWRkcmVzc2FibGUg
RE1BIGlzIG5vdCBjb21wYXRpYmxlIHdpdGgNCj4gMzItYml0IGFyY2hpdGVjdHVyZVxuIik7DQo+
ICAgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IC1FSU5WQUw7DQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgIGdvdG8gY2xlYW51cF9jbGs7DQo+ICAgICAgICAgICAgICAgICB9DQo+IC0tDQo+
IDIuNDkuMA0KPg0KDQo=

