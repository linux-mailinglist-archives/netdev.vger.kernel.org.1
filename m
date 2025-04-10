Return-Path: <netdev+bounces-181071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50844A83924
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 08:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFF30189B702
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 06:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC240202C53;
	Thu, 10 Apr 2025 06:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AyzUYCKI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AE318FC9D
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 06:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744266314; cv=fail; b=VkhrW6yFaur3qh6DsRCZ4eLXIvX9yGsSkz2eC9/1gcLUogGlHBmGLgVLNgwCW545hq8k5H2Aa8u16YjvQE1YZhcjS6MrpaYmcDCkL8ggwZ0vs0pk2jGD8qrDh7+vNyJlLEyW+vS7PSfTyPS1w31XIgKFgMjG4DCAw6Lk4ugwqic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744266314; c=relaxed/simple;
	bh=vRTNH3oPVmw6UvfgekZx4prlG3Z3225qx2yXgxO9Ma4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bAzNxIo5yubZTHsqBxky5tswUUeDYoHFUx9jImqY6e9hoBe94Gd3dwwuUKYIxiLPCuL3OpSWAGzIb3bCfYhTRVFdcU6Vd8YwXk9FWnENlGAykBIA0izT2iItA1x9V/fFiwZVm7mj1kXOsHbTVQ13eMeZA4tjmA/mSXgPsW2A5YM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AyzUYCKI; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVB36FIjwSFR1W1BDnM8ggA88aOuK3B2rYUcotLjAiXuUh2lTPadWp69MfW6R8hLDWD1tro8wrf9BLxvQns452gAZK5e0UGcNw6nLSjWB6Y2KsB5IYRxh8aGESTCSGo3VPW+oi9X4YbqG+iZxE9PC8e7xD6wnVcU+B8PI205m3Vb2hBAoGAgHXfs8Ksk+9lssqXGRU7gfFVG2lKTBuXqaFaQV/vwH49hMtcJtCPqULFLvFQc76lCnly8VehJpH6Ejvp5crqd8gRjotpM6E60dB00my1G2vQ+rTO9B8nvfBHwIOL8rDFZu7jpYTKpUYrxdweHTFPG3+B/GGyNB7EBOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72n4aJ3Qo/IzV6nfPBs/zFnW2y1cOGWWMq/JSvU+Ags=;
 b=YRi4ijPGhdpWdhXoXbwFRFDgHOiHuLig6deC2r8MX9DMYE04LXXvEJK2shuYAabsRqwoplMB/Mu7d4rT9Qnd56H1ASS5GZyltclEJ+dajwlgCf0dVS4NB32owj/eDdxBMvBVAEswWcoe8z/SCLiJwTlG8MuKulQGFhEtnzWL9XmsTf4HRd4mMHZ1gXMwJxyeTD9nFrQViS0/8EN6OfFKs/cMt6IZoWFSr010Pr5cSlgDoHe4RL30Qzl5LiagyL0/g32FO3/CTAjNChwg/buCCeg2mnaujRWkBfudzRti4U1Kl9+NYAzm/VU+ZsAqB7tO3EtQz8uH5a/NtJE7Dtb1Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72n4aJ3Qo/IzV6nfPBs/zFnW2y1cOGWWMq/JSvU+Ags=;
 b=AyzUYCKI04qBRTwXAS7BI0Vmy/U6lmMU+ZYPGHJlGnsTNgr9ZBSU+nnytbfA8OZx+lrPiR7+muT3UAS4Fn4QnB1qo/tc44koP+JzcCSU5nRCnFBcNTSOizSv2g54DmRskVLEIhvnfF0kRHIzOFzGyfEPxSwVMQscmg7H7/YK5Jg=
Received: from BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18)
 by CY8PR12MB7121.namprd12.prod.outlook.com (2603:10b6:930:62::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Thu, 10 Apr
 2025 06:25:09 +0000
Received: from BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6]) by BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6%3]) with mapi id 15.20.8632.017; Thu, 10 Apr 2025
 06:25:09 +0000
From: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
To: =?iso-8859-1?Q?=C1lvaro_G=2E_M=2E?= <alvaro.gamez@hazent.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Katakam, Harini"
	<harini.katakam@amd.com>, "Pandey, Radhey Shyam"
	<radhey.shyam.pandey@amd.com>, Jakub Kicinski <kuba@kernel.org>
Subject: RE: Issue with AMD Xilinx AXI Ethernet (xilinx_axienet) on
 MicroBlaze: Packets only received after some buffer is full
Thread-Topic: Issue with AMD Xilinx AXI Ethernet (xilinx_axienet) on
 MicroBlaze: Packets only received after some buffer is full
Thread-Index:
 AQHbovQu0/POKRhQ2UyFaqdX6vyCjLOQm5yAgADVjoCAAAKLgIAJw6gAgAAD2ACAACBDAIABILtA
Date: Thu, 10 Apr 2025 06:25:09 +0000
Message-ID:
 <BL3PR12MB6571795778D97F64C39C3B71C9B72@BL3PR12MB6571.namprd12.prod.outlook.com>
References: <9a6e59fcc08cb1ada36aa01de6987ad9f6aaeaa4.camel@hazent.com>
			 <20250402100039.4cae8073@kernel.org>
		 <80e2a74d4fcfcc9b3423df13c68b1525a8c41f7f.camel@hazent.com>
		 <MN0PR12MB59537EB05F07459513A2301EB7AE2@MN0PR12MB5953.namprd12.prod.outlook.com>
	 <ce56ed7345d2077a7647687f90cf42da57bf90c7.camel@hazent.com>
	 <MN0PR12MB59539CF99653EC1F937591AAB7B42@MN0PR12MB5953.namprd12.prod.outlook.com>
 <573ae845a793527ddb410eee4f6f5f0111912ca6.camel@hazent.com>
In-Reply-To: <573ae845a793527ddb410eee4f6f5f0111912ca6.camel@hazent.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=42e58e14-ac39-484d-bbc0-f82b22eafc37;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-10T06:23:20Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6571:EE_|CY8PR12MB7121:EE_
x-ms-office365-filtering-correlation-id: 8ff5bb21-2b3d-4f1e-4863-08dd77f87150
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ZC9QNVV4dYHlA+zCjoPeiWvbzUw+5q8SksaF2ecgAPc0RHdfRWaD/YzMpt?=
 =?iso-8859-1?Q?cHwUcHlUC/r561DbTGYBgZv7Ks3bdNkwbXs6j/f0AGOwfxF3xI9Ex+ILFx?=
 =?iso-8859-1?Q?izNDxElTMxVqqe3ccxbeZJ0ZnTf7M9Jhf407UqLqogBVYiUND2syaChLSy?=
 =?iso-8859-1?Q?w9z91hRYkQ+EhzqKXv3vNNgdjGaUb/Xm8uay66YoWJ41cPiVFkwxvPj6M4?=
 =?iso-8859-1?Q?0Fvfv/rltmGOQVAVt0Ska7BxhvQ8ZBj+JRJ2F/p9gtXG79ZkjvYg9y8IDC?=
 =?iso-8859-1?Q?1HalrZxfZJSTcj985025Osj/L+Xn9QqeqLzvKa0JxaxxBzBea0FdzeLsCT?=
 =?iso-8859-1?Q?g+J/HckkEcRDXj57rzgV6fSopKtmiO4lBqSll8BuvC3CDrol/qOG/w7W22?=
 =?iso-8859-1?Q?+DFWc9Cg1IDNKqcKSL+WCPtWN8UWSlC0cyloTLQ6qC9N/IBmBT1nILSTw9?=
 =?iso-8859-1?Q?5hUZWKOW4qnxe3qkgt8clnUMvDaQiMEpWpN/kKQNCQU8OTqAxz5xRi6ztA?=
 =?iso-8859-1?Q?YySID5HsdhmHa2Nf3S/VO2B+zt4YojKwp8RE28fl003UstUdHBp17gg4H7?=
 =?iso-8859-1?Q?5kmGaU/r6HJws296FtpWaIVrbLDnTM4JmRfkjJF/2uolZltd/FSrdKp/xy?=
 =?iso-8859-1?Q?in/+q10EMMY5MSvsmPjBz2KCH10UjjkGaGkxOJTG/mOjeA9wVwRIDQwaA0?=
 =?iso-8859-1?Q?EtsCsEmDFAoe4zVdWfvjtkD0BB8bR/EjeXE5MDAHTgJqErU8JOEyETGJ22?=
 =?iso-8859-1?Q?vab4+PskinxesnYm+4iC+d4JdyCYOph9kx3kSze6ch5dN2Ob/8CmCFjHSu?=
 =?iso-8859-1?Q?dqXZGbKz0WOFU5dNXFalY5bv8vOJEhj+MTpxiIs8DlOEcSoGxt3Y676qcw?=
 =?iso-8859-1?Q?xnYmWzyj/M3AdEvBQ6tG9MhTVoL4dKEYslfEqYYOcR1GsgvYzzbw1r5c4s?=
 =?iso-8859-1?Q?u4E+/jH/s9G8u8rK5ATFd0Y7Y4CWrjq62tR4pKltoKzQFboQ6Br4K5ygZQ?=
 =?iso-8859-1?Q?PvpK5t6pQMwLCnz3dGYcLvqMEU/uO/r4ocXV4jX4fQkrbAsGhYeXhtHBUl?=
 =?iso-8859-1?Q?4IZkjPq+n7vfthbhBFaTlWZnte+NDKpmISxYhb4G+VY3w/MKP9k1WFfLai?=
 =?iso-8859-1?Q?GGUvrcaWyZhN8XK/5RuU8JEPa/daLlzZZ5u2qFm3Vbs2ka6ZozZwUicx4b?=
 =?iso-8859-1?Q?7SdQ4SLPuKYVlFnj4i97rkBOYJEuWCRqMHVJ4fSzeTTqO0Zy37RYlUmzJT?=
 =?iso-8859-1?Q?avXQluLUbSOqfSe57zUdgJ5NlxlQRT7FGxQU1s/MZOlzCwwV79jjF+nE/j?=
 =?iso-8859-1?Q?stApvRcl4EiUoGQBJBkIwiSF88dzMP/r2DbQAd0GfY8vddhbqSU5xrfJ9R?=
 =?iso-8859-1?Q?JYa9aHHCTJBE6kOiiGjQJE87fvGkMAMp7TKvE12/UrGJ0y4vJ+txdGpvuF?=
 =?iso-8859-1?Q?ooVuuKCmt4DMlyhsu2P3c8httH+v53h+Lv+H4mp6Qv19RxmTWB3B4YAgox?=
 =?iso-8859-1?Q?0xPGxN19UE9pc8qHLCbVb8?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6571.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?1Go7SFkly7Mcpimn+2jKOhAmGPn8VxRhIoVT/y/3T7iGluOQaYlcVIneXW?=
 =?iso-8859-1?Q?oQ90rUtZBK53yN/NeDbop+7+kvmImRHw9AZYXrB4iDXoJr1+LHMEN94pWZ?=
 =?iso-8859-1?Q?agQIi5evjO1vuZcv9pYJoRLBNHe6PVm5HAVwGmyfJDZHhNPgUpmwHZOcSr?=
 =?iso-8859-1?Q?D+7eV/w/g2whhvjfQEUna8Hebr8O02cDREXUCyzR7/IwAcAarXDuFPX32O?=
 =?iso-8859-1?Q?PY+Rmwtw8vKWn+4jwNiIlq9DeKbPaCahOripv0jqyrzX/aH0DB643/PHK5?=
 =?iso-8859-1?Q?e/Y9LTjjEX2pZ+DXjB8q52JDUbSbXc/7vuKo9G2pc+p77RZIV0IqbcTuJV?=
 =?iso-8859-1?Q?eel1ONp2q0GIPJzmbPNlCVliNwPRsfNsf+we4EfgkphQWZIT7AAYms2vvk?=
 =?iso-8859-1?Q?XCxPj8DeTCVwqxIiZjgZMEJHqkj37sDE1RwJrV2v0s9htdRwAQVwz2DHAY?=
 =?iso-8859-1?Q?s+Fv2DcheMSGjy9H843IEEidV5BmYF66H453/GhjtxUP1abHRzrwQxCURU?=
 =?iso-8859-1?Q?v/YaNwamv79VlV/vLIuI6yzrTGYdZdKp5Yx7XDSv7l4pibHVl0IOy2Fhnk?=
 =?iso-8859-1?Q?rpKcd+2gC+k0g1wMW84l6IotyD166Tlo7izmS2u+90h/C2E2YurWhoys1l?=
 =?iso-8859-1?Q?AIGojirenjxVTLy3Xc37Dnuodi4mpmVc/UD51xwHiitzV4UTe7XuvylYj/?=
 =?iso-8859-1?Q?I3+Ivb9LZlRUE6qp/LsCNyK1tB48ad3Liwd+ci0SCqeNGJxnKnAKBnrK7W?=
 =?iso-8859-1?Q?cD5CUSuX4RG4docys7zciXpEDReEQJ9H0gqqAEfPG0OXyD1J/gN/RhJRQ0?=
 =?iso-8859-1?Q?rmljkm5UPHIj3/GRC7CyZdRk9DzbAZp3qjuHgSP89B0PLhUVzvvLEhIS4e?=
 =?iso-8859-1?Q?AV2OgsyzoPS9acyIhQh0sR6XnbyY2li9bCheJs90YCdsLFuNYnnbdtLg52?=
 =?iso-8859-1?Q?d9LiLVwl1BNU7sUMqa/IgP1BgUVbSnptcnIVbJfrv0tSg8lkCQ7gh4+D/Y?=
 =?iso-8859-1?Q?pTGCKONpP0AetAbHPX0EDqty4K0LYLpOTRqZ6R5ui9xyE8I2wQsuMeUsrd?=
 =?iso-8859-1?Q?mRTTP4r91vIL2uNWyMPe7vuNfWKa00IjCu3NB7w1AasrcelYVckOtg3J4j?=
 =?iso-8859-1?Q?G/dLK+uJwUiPO/WLanisGtgpFyi2daZIGd+RKIvPA4NNVkYkFKnLTiJQEm?=
 =?iso-8859-1?Q?QOuiJnHM9seSzHnsB/kMO8vW/9SRnBBb1A92i55Bax0nYR2BeBtAvBi6Ak?=
 =?iso-8859-1?Q?MEkvxfC/X0WYNpPkTNojKOLDfBYnNKDLwiQRsGt1axnZwuvTU5RJMSw9VB?=
 =?iso-8859-1?Q?x8TuMXS1rGsXZgOgTj9u//2i663j8PATHMlZqAIL27gRfH4/lerkkOMI+S?=
 =?iso-8859-1?Q?xqFzQa0bV2vabH7wXypwTQIWDuuzYp1YVEUOR/8E2TjN2IVbQ2bmQgot19?=
 =?iso-8859-1?Q?ArDONM78X/X5lK45PFxvvgbDKCyuASQg+57wBNuNLj9w2kGwDPCa9Yvwsc?=
 =?iso-8859-1?Q?fARRsuDGtZFKi+AmjnOG+LZO3wH2KmqBXTMVZ/cqZ1rXb1r5ZMUhlAe8a7?=
 =?iso-8859-1?Q?ywnG5PL4zy2P08bv2l1ggFyQtJ2zN9ftB5ROZesf2TKTKCNT5XvqNT3iDz?=
 =?iso-8859-1?Q?5H7yTl/ht/bBo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6571.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff5bb21-2b3d-4f1e-4863-08dd77f87150
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 06:25:09.2849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bq3g+McXj6IgN1SYf32baDUjx4KWCQnLLZcuwtQHFdTDoJcNehS4orQksv9oA7Vm+0+01JH7OynzCNuqtSWtHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7121

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: =C1lvaro G. M. <alvaro.gamez@hazent.com>
> Sent: Wednesday, April 9, 2025 6:40 PM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; Jakub Kicinski
> <kuba@kernel.org>
> Cc: netdev@vger.kernel.org; Katakam, Harini <harini.katakam@amd.com>; Gup=
ta,
> Suraj <Suraj.Gupta2@amd.com>
> Subject: Re: Issue with AMD Xilinx AXI Ethernet (xilinx_axienet) on Micro=
Blaze:
> Packets only received after some buffer is full
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Wed, 2025-04-09 at 11:14 +0000, Pandey, Radhey Shyam wrote:
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > > -----Original Message-----
> > > From: =C1lvaro G. M. <alvaro.gamez@hazent.com>
> > > Sent: Wednesday, April 9, 2025 4:31 PM
> > > To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; Jakub
> > > Kicinski <kuba@kernel.org>
> > > Cc: netdev@vger.kernel.org; Katakam, Harini
> > > <harini.katakam@amd.com>; Gupta, Suraj <Suraj.Gupta2@amd.com>
> > > Subject: Re: Issue with AMD Xilinx AXI Ethernet (xilinx_axienet) on M=
icroBlaze:
> > > Packets only received after some buffer is full
> > >
> > > On Thu, 2025-04-03 at 05:54 +0000, Pandey, Radhey Shyam wrote:
> > > > [...]
> > > >  + Going through the details and will get back to you . Just to
> > > > confirm there is no vivado design update ? and we are only
> > > > updating linux kernel to
> > > latest?
> > > >
> > >
> > > Hi again,
> > >
> > > I've reconsidered the upgrading approach and I've first upgraded
> > > buildroot and kept the same kernel version (4.4.43). This has the
> > > effect of upgrading gcc from version
> > > 10 to version 13.
> > >
> > > With buildroot's compiled gcc-13 and keeping this same old kernel,
> > > the effect is that the system drops ARP requests. Compiling with
> > > older gcc-10, ARP requests are
> >
> > When the system drops ARP packet - Is it drop by MAC hw or by software =
layer.
> > Reading MAC stats and DMA descriptors help us know if it reaches
> > software layer or not ?
>
> I'm not sure, who is the open dropping packets, I can only check with eth=
tool -S
> eth0 and this is its output after a few dozens of arpings:
>
> # ifconfig eth0
> eth0      Link encap:Ethernet  HWaddr 06:00:0A:BC:8C:01
>           inet addr:10.188.140.1  Bcast:10.188.143.255  Mask:255.255.248.=
0
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:164 errors:0 dropped:99 overruns:0 frame:0
>           TX packets:22 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000
>           RX bytes:11236 (10.9 KiB)  TX bytes:1844 (1.8 KiB)
>
> # ethtool -S eth0
> NIC statistics:
>      Received bytes: 13950
>      Transmitted bytes: 2016
>      RX Good VLAN Tagged Frames: 0
>      TX Good VLAN Tagged Frames: 0
>      TX Good PFC Frames: 0
>      RX Good PFC Frames: 0
>      User Defined Counter 0: 0
>      User Defined Counter 1: 0
>      User Defined Counter 2: 0
>
> # ethtool -g eth0
> Ring parameters for eth0:
> Pre-set maximums:
> RX:             4096
> RX Mini:        0
> RX Jumbo:       0
> TX:             4096
> Current hardware settings:
> RX:             1024
> RX Mini:        0
> RX Jumbo:       0
> TX:             128
>
> # ethtool -d eth0
> Offset          Values
> ------          ------
> 0x0000:         00 00 00 00 00 00 00 00 00 00 00 00 e4 01 00 00
> 0x0010:         00 00 00 00 18 00 00 00 00 00 00 00 00 00 00 00
> 0x0020:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0030:         00 00 00 00 ff ff ff ff ff ff 00 18 00 00 00 18
> 0x0040:         00 00 00 00 00 00 00 40 d0 07 00 00 50 00 00 00
> 0x0050:         80 80 00 01 00 00 00 00 00 21 01 00 00 00 00 00
> 0x0060:         00 00 00 00 00 00 00 00 00 00 00 00 06 00 0a bc
> 0x0070:         8c 01 00 00 03 00 00 00 00 00 00 00 00 00 00 00
> 0x0080:         03 70 18 21 0a 00 18 00 40 25 b3 80 40 25 b3 80
> 0x0090:         03 50 01 00 08 00 01 00 40 38 12 81 00 38 12 81
>
>
>

As per registers dump, packet is not dropped by MAC. It's dropping somewher=
e in the software layer.
Since you started bisecting linux commits, could you please try reverting s=
uspected commit and check if that's actually the first bad commit?

> Running tcpdump makes it so that ifconfig dropped value doesn't increment=
 and
> shows me ARP requests (although it won't reply to them), but just setting=
 the
> interface as promisc do not.
>
> If you can give me any indications on how to gather more data about DMA
> descriptors I'll try my best.
>
> This is using internal's emaclite dma, because when using dmaengine there=
's no
> dropping of packets, but a big buffering, and kernel 6.13.8, because in s=
eries ~5.11
> which I'm also working with, axienet didn't have support for reading stat=
istics from
> the core.
>
> I assume the old dma code inside axienet is to be deprecated, and I would=
 be pretty
> glad to use dmaengine, but that has the buffering problem. So if you want=
 to focus
> efforts on solving that issue I'm completely open to whatever you all dee=
m more
> appropriate.
>

We're not planning to make DMAengine flow default soon as there is some sig=
nificant work and optimizations required there which are under progress.
But this buffering issue we didn't observe on our platforms last time we ra=
n it with linux v6.12.

> I can even add some ILA to the Vivado design and inspect whatever you thi=
nk could
> be useful
>
> Thanks
>
> >
> > > replied to. Keeping old buildroot version but asking it to use
> > > gcc-11 will cause the same issue with kernel 4.4.43, so something
> > > must have happened in between those gcc versions.
> > >
> > > So this does not look like an axienet driver problem, which I first
> > > thought it was, because who would blame the compiler in first instanc=
e?
> > >
> > > But then things started to get even stranger.
> > >
> > > What I did next, was slowly upgrading buildroot and using the kernel
> > > version that buildroot considered "latest" at the point it was
> > > released. I reached a point in which the ARP requests were being
> > > dropped again. This happened on buildroot 2021.11, which still used
> > > gcc-10 as the default and kernel version 5.15.6. So some gcc bug
> > > that is getting triggered on gcc-11 in kernel 4.4.43 is also triggere=
d on gcc-10 by
> kernel 5.15.6.
> > >
> > > Using gcc-10, I bisected the kernel and found that this commit was
> > > triggering whatever it is that is happening, around 5.11-rc2:
> > >
> > > commit 324cefaf1c723625e93f703d6e6d78e28996b315 (HEAD)
> > > Author: Menglong Dong <dong.menglong@zte.com.cn>
> > > Date:   Mon Jan 11 02:42:21 2021 -0800
> > >
> > >     net: core: use eth_type_vlan in __netif_receive_skb_core
> > >
> > >     Replace the check for ETH_P_8021Q and ETH_P_8021AD in
> > >     __netif_receive_skb_core with eth_type_vlan.
> > >
> > >     Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
> > >     Link: https://lore.kernel.org/r/20210111104221.3451-1-
> > > dong.menglong@zte.com.cn
> > >     Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > >
> > >
> > > I've been staring at the diff for hours because I can't understand
> > > what can be wrong about this:
> > >
> > > diff --git a/net/core/dev.c b/net/core/dev.c index
> > > e4d77c8abe76..267c4a8daa55
> > > 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -5151,8 +5151,7 @@ static int __netif_receive_skb_core(struct
> > > sk_buff **pskb, bool pfmemalloc,
> > >         skb_reset_mac_len(skb);
> > >     }
> > >
> > > -   if (skb->protocol =3D=3D cpu_to_be16(ETH_P_8021Q) ||
> > > -       skb->protocol =3D=3D cpu_to_be16(ETH_P_8021AD)) {
> > > +   if (eth_type_vlan(skb->protocol)) {
> > >         skb =3D skb_vlan_untag(skb);
> > >         if (unlikely(!skb))
> > >             goto out;
> > > @@ -5236,8 +5235,7 @@ static int __netif_receive_skb_core(struct
> > > sk_buff **pskb, bool pfmemalloc,
> > >              * find vlan device.
> > >              */
> > >             skb->pkt_type =3D PACKET_OTHERHOST;
> > > -       } else if (skb->protocol =3D=3D cpu_to_be16(ETH_P_8021Q) ||
> > > -              skb->protocol =3D=3D cpu_to_be16(ETH_P_8021AD)) {
> > > +       } else if (eth_type_vlan(skb->protocol)) {
> > >             /* Outer header is 802.1P with vlan 0, inner header is
> > >              * 802.1Q or 802.1AD and vlan_do_receive() above could
> > >              * not find vlan dev for vlan id 0.
> > >
> > >
> > >
> > > Given that eth_type_vlan is simply this:
> > >
> > > static inline bool eth_type_vlan(__be16 ethertype) {
> > >         switch (ethertype) {
> > >         case htons(ETH_P_8021Q):
> > >         case htons(ETH_P_8021AD):
> > >                 return true;
> > >         default:
> > >                 return false;
> > >         }
> > > }
> > >
> > > I've added a small printk to see these values right before the first
> > > time they are
> > > checked:
> > >
> > > printk(KERN_ALERT  "skb->protocol =3D %d, ETH_P_8021Q=3D%d
> > > ETH_P_8021AD=3D%d, eth_type_vlan(skb->protocol) =3D %d",
> > >        skb->protocol, cpu_to_be16(ETH_P_8021Q),
> > > cpu_to_be16(ETH_P_8021AD), eth_type_vlan(skb->protocol));
> > >
> > > And each ARP ping delivers a packet reported as:
> > > skb->protocol =3D 1544, ETH_P_8021Q=3D129 ETH_P_8021AD=3D43144,
> > > skb->eth_type_vlan(skb->protocol) =3D 0
> > >
> > > To add insult to injury, adding this printk line solves the ARP
> > > deafness, so no matter whether I use eth_type_vlan function or
> > > manual comparison, now ARP packets aren't dropped.
> > >
> > > Removing this printk and adding one inside the if-clause that should
> > > not be happening, shows nothing, so neither I can directly inspect
> > > the packets or return value of the wrong working code, nor can I
> > > indirectly proof that the wrong branch of the if is being taken.
> > > This reinforces the idea of a compiler bug, but I very well could be =
wrong.
> > >
> > > Adding this printk:
> > > diff --git i/net/core/dev.c w/net/core/dev.c index
> > > 267c4a8daa55..a3ae3bcb3a21
> > > 100644
> > > --- i/net/core/dev.c
> > > +++ w/net/core/dev.c
> > > @@ -5257,6 +5257,8 @@ static int __netif_receive_skb_core(struct
> > > sk_buff **pskb, bool pfmemalloc,
> > >                  * check again for vlan id to set OTHERHOST.
> > >                  */
> > >                 goto check_vlan_id;
> > > +       } else {
> > > +           printk(KERN_ALERT "(1) skb->protocol is not type
> > > + vlan\n");
> > >         }
> > >         /* Note: we might in the future use prio bits
> > >          * and set skb->priority like in vlan_do_receive()
> > >
> > > is even weirder because the same effect: the message does not appear
> > > but ARP requests are answered back. If I remove this printk, ARP requ=
ests are
> dropped.
> > >
> > > I've generated assembly output and this is the difference between
> > > having that extra else with the printk and not having it.
> > >
> > > It doesn't even make much any sense that code would even reach this
> > > region of code because there's no vlan involved in at all here.
> > >
> > > And so here I am again, staring at all this without knowing how to pr=
oceed.
> > >
> > > I guess I will be trying different and more modern versions of gcc,
> > > even some precompiled toolchains and see what else may be going on.
> > >
> > > If anyone has any hindsight as to what is causing this or how to
> > > solve it, it'd be great if you could share it.
> > >
> > > Thanks!
> > >
> > > --
> > > =C1lvaro G. M.

