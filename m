Return-Path: <netdev+bounces-158447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A112A11E89
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6E433AE3FB
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10CD2045A5;
	Wed, 15 Jan 2025 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CL8YMDPr"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A94C1EEA46;
	Wed, 15 Jan 2025 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736934527; cv=fail; b=Y7lJs4EMB7IKL6kDJTxBUX4c/AA+f4afoQKM7a9pgegrcbwSgWpOnnoegNos3wKA0Yg0EypbWE3AlmZMJ3fDRaeJtlrZSsiry6rmcS9wfR7LjLuuvf3bWPwlzcJBruuzoBnxBDQ1FgElMSFHPNP5f2RKgXnp5WlL38RXKbHFizo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736934527; c=relaxed/simple;
	bh=oP9OGd3l6O9kxmdOMgD/Yllp2dGLyfgtqv5FrBSX2ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QRROu3E5BJwzNlB2m+Pdctr2tdJ/1qcONb7CmxIvodY0h1O/8XGf0BeGCCu7fJU3az+jHJlyskrMSsn9vqfgk4R8pIwu4pf73fqc2LBx6yx5fHQB+SydIIyVnlZ1xmpso0PcYdK67ZqoqAN1q+2dw1CQuT1jP/nqKBgeacVjvXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CL8YMDPr; arc=fail smtp.client-ip=40.107.21.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/Y6oLY0KfZR2+lpLwnzbBEPs67WCWKM06KLCZJdU4X1qNksKKYjc4gFoSnHfWqNkMOoJ7hyAhX4EyHc3sLVd/okbquLNdmOfi5e0QVrVU0p2EMYoq7P7TCDnGt+WBc7ESTfoq8TPjLIzcpo39L/FOrXpJjwuIJg0SlgDoHc4X8XQpqULppfb9oAHnsZTzn/pxPBdZhXvI0rhei8+PXtox7afjdEHMBUKNfDhkEQXJQxK7BtvhiM4LKbzyIJJif7HQ71/tv1OVOlfzCuQKKFSPfXslKR2P8u16gRZcSvZL+xCZjM6crw6lxPO+yxR3MbvNLGl5QUAroaaFbNQ0q1iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1CO75ijDW/muDDEb9R0W2PQG1wo++ITfNZtOe5tlEo=;
 b=zPwEaUouYICTXzulkLKiwAeuJoBLINuDyqLWRN04be4F1CF/IFxcdLvSbHa4yj2rELNioIA0rI9Kt8Hi/PSybw0ZyImKjZ3H7ok78GfSeQrU/VnHEYfMms8p9HNKe5E9bowFP0NP3RzQ9V1rCh1fpm1gykevYn/L03qcgJ0su3SwFtBJH1F4NgMxVxgtQsbb4CRZmVWWlSyE11GfsImTVpiu2P3r+TY4iPrFOTpVWaZUyefM58CZQRauqU00VM0z43DWs4ahzRyksoQcQ3jOPtwVl3DZM+YeAZvCiHUyyV+1KmS5VrIGyFORpwyRGaXSv+IL6LDSPx/X2pLL8Pf4Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1CO75ijDW/muDDEb9R0W2PQG1wo++ITfNZtOe5tlEo=;
 b=CL8YMDPrzgdLoQKtnY+zGGIw+g1DW9cv2hVAH2g845Qc9+CxD43kfF4M9h7yvl9JIhGfxfzGalMn2TOAIjQy1jlnMcM6LWFm5g+LG0jE0z2i4FaiR+kibbFlxwk/RDHb9ENcX5FPAxUfHu+/pc4kpl/pJyV2qpHHIIPKH9sDxY0E3OvcQAHb1MkjNYfvNyHhH4v8Hik3Fn+EAudY/3aSe/oiQ8e+Kq8mWoznfDTluyZxNvf5/U93ihpYLaR9w9xj3jBebuzYt8IRUd+vI+URcc53XxE15NaJk8QDQBdVqjSROC+J+DxRLDXEYojXSqzSgigQj7DFnzkN5rH4Rvm4sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA4PR04MB7696.eurprd04.prod.outlook.com (2603:10a6:102:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Wed, 15 Jan
 2025 09:48:42 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 09:48:42 +0000
Date: Wed, 15 Jan 2025 11:48:39 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Furong Xu <0x1207@gmail.com>
Cc: Chwee-Lin Choong <chwee.lin.choong@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/1] net: ethtool: mm: Allow Verify Enabled before Tx
 Enabled
Message-ID: <20250115094839.xjudiq2japopdqza@skbuf>
References: <20250115065933.17357-1-chwee.lin.choong@intel.com>
 <20250115174204.00007478@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250115174204.00007478@gmail.com>
X-ClientProxiedBy: VI1PR07CA0239.eurprd07.prod.outlook.com
 (2603:10a6:802:58::42) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA4PR04MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: 39007e69-2c5e-4c24-7891-08dd3549cb76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmtjYWYvbUFrbFBSWENJRk1tOWFNWnQ1V01idmRnWGhHcWNLbGxYbHJqa21S?=
 =?utf-8?B?czRHN0lRTlZlR205d0JNRkxUYmhtelUrekhOeHQ5QlJmV1NBTjBmeW1HTTU2?=
 =?utf-8?B?WnNXMjdmVmlVY2tWN3ZEajVobnVzV2QveUpPOWJabDU0c01lbDU1cDNJdzRF?=
 =?utf-8?B?bzZma3pjb2dYUGVQT2NleDJXSUFnTzdRZ3RwQ1BEQkszREhkSmVmME1QdW5G?=
 =?utf-8?B?TXRoUUZ6MTU4ZC9DTEs1MHVLMWt2Y0xWaFVSdHdyckV5ZEVvd2ZTamczWGJY?=
 =?utf-8?B?Qi9qS3JHeURNNmRNdlA5Y2dHRDJKVVR6cVN6ZUNsUHVwNzZLQ2VsVUJ4M0ZC?=
 =?utf-8?B?ZEVsb3FyN09oNTcvN3cwbU1JaXA1c0V0TVNqTzJpREhhK0JmbGdXbnJoekFk?=
 =?utf-8?B?Y3JUZjE1Y2puVEo4ZjZjZG1CQ2U2c1JzajJ0eS8vaXU1MmttbWMzZzUzbWd0?=
 =?utf-8?B?M2dOQWtZa0FESTd5alFycG5mbTI1eWQ1OHJLT0tSdDlMNFJ0b1dCYmtyRzgx?=
 =?utf-8?B?cFo0UVVVSitDdm41QVlFaERlb3VDQ1lhVXFlaUN2dlJGdlVQdEtpWERnY2Jn?=
 =?utf-8?B?eUNvTkhDcS9taklTbnhYbzhoVE5ZMjFiT2xMWnd1N0UwSGI4SnZWTUZIcjJp?=
 =?utf-8?B?QUZpdDhOQWNXWjZmSGJKV1JXVkdPRUpwYkpFRjJBVXNxSXNlMzNFSHAvWHlK?=
 =?utf-8?B?NEZkZjJid3dCSGZqdnNmbFIwM21UVmhsV29DaGJaRUJ3enZOcUxvWHVvNkhn?=
 =?utf-8?B?NTNTbWREaGRzV0VEaDdKdTcxclJQeVA5MFgvck1PQ1k0VkNCMFpEMmlCajlj?=
 =?utf-8?B?eWhKaUVLQjBzRURnMnQ2YnJXbHBXczVXSGJuNnZJMitzVFNHNnN0eCtmWjU0?=
 =?utf-8?B?WUE2L0JvQnRYcm5XVUVTUTd3VU5HV3FNTHVwaVhWRW13ejlZMTlmSU1FVmtF?=
 =?utf-8?B?TXVkTUg1c0xXUW5iNGg0anNUMSszL0RvL2ZKMHE4T2xZbUZJVERmd1E2bER5?=
 =?utf-8?B?MUdPQnQvcmwxRG9RWmVXbFp2K2ZLam0rYlpIVkhteUdaSDU0K0RqbEJ1UFRI?=
 =?utf-8?B?cDZwQTBUKzN3S2xWZnNVRUxtTW42NjdZZFFCQmovT1cxTG9lRnZIejNrVzhG?=
 =?utf-8?B?VG1pYXpkUzJ6VnVHNGF0T2lhWEwxSGFHdVZoSjIwZEFIV1FWZjF0bGEwaTZk?=
 =?utf-8?B?TWZMdjhDbVk4bFF0TkxpUmFialJhZVlnVkFpV3VTYm5MRVpZeGtwUkQxYXk2?=
 =?utf-8?B?L1VOanI4MDBCbkVqV3o1RHhPN1ViZ2RNZG9NaERqZVJMTCtNc2pCVklCaWxW?=
 =?utf-8?B?QWN6ZHNHNCs5ZFZncm9UUnNCYytiRXF5dSs5VlhYTExLMFZoN1ZoSTVYRGE1?=
 =?utf-8?B?c2xXYWpKWDZrQS84cDBVRVh0UXBBbloya04yS29TQms4Rk93WlIzaGJxZUIx?=
 =?utf-8?B?QzFqeDViTC9VR0FxMEc2R0FQNEVZVnBtY1dtUkEwUFJlQVN4MHBVK1RsUGo3?=
 =?utf-8?B?Z0pJQ1JuTmErTmw1YnpVYk1aMDZCWnVRbWcvWTg5SmFHLzZhY2NJeWo0WWg1?=
 =?utf-8?B?WjIvY3V2c1czVVlEeFVLYkh2cTExR0UvZmVqQmZSMnFlclYyTnI2bEp0QzJH?=
 =?utf-8?B?UnVGeXhpWmM0eVM3OVY5Y3ZIVUYyazRVY0NCYWNRYW43azg4L2JpQ09NeUts?=
 =?utf-8?B?TVBXM21jbnNjNnFSeXQ4NXlEOW9nQXA1K2wyYWlNd1BuVWtaTEQwNnpaN2Jz?=
 =?utf-8?B?MkxhbkJVQ0QzUnF4YXFxQmFLcUFnK25YUCs4d1B6S3FHQUQ2d0w1THF2RFox?=
 =?utf-8?B?MjJyc3pxcTEvTnQyRVBDazBMRVFaK0ZyUWNDNmYzVXFPUUNQWndYdTlOekU0?=
 =?utf-8?Q?VPiLDC+36UqY8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTFEQ09jV3ZUZFltb2hzYW1PQlo3NFRRbGpZVjNwbFVKV1FBcE5KNzQ4ak9J?=
 =?utf-8?B?M09RTUVoM3d5Z0h4eWhzS3BncW1KZTRKUitZSlNERGdTVndIL1QyRFJGVTIy?=
 =?utf-8?B?Z0ppeXpRR2dNUG1WcCtIWmdkcTFzc0RhQy9GdkdBMnJVc2p0QmxGMkl6c3hI?=
 =?utf-8?B?SDM3QU9BRTlwbGhzV0ViNVlPVGlkN3B3WnBMbGlYb1ZpSUhpNnEwOTV4dDRC?=
 =?utf-8?B?c1ZHM0JBa09qNjlEN1lUeEphWVprU2I4MFBHVzRndFBVVGRCa21ia1d6Q0dW?=
 =?utf-8?B?OUY4RDNzRVlQaXI3MkpMQ0JKTWFLY3ZGNzU0MTFNd1I3SjMwblZ4VGlvcDdX?=
 =?utf-8?B?TkR4amdpM1gwcXZMbTc1bk1Yem9EVWN1L2RWVDltdTBWcHpWbkJVVGtvb2lQ?=
 =?utf-8?B?by8zZUpEbC9LVVFKMnpzOUNES3VvcEpick5CSkFCbE1vOVNxQUlGaGJDaXlm?=
 =?utf-8?B?L3BkK21GbGFVNUI3NHRpZ2dHZGVrL0NWWVVzbmpRKzJCS0t2bmdKRHV3RG1t?=
 =?utf-8?B?SEQzK1Z5enJHQkRxUXdDU2NlbURaV2o5R0liWHJnRHBKdFpWaFlTbWhtZlVH?=
 =?utf-8?B?S0FHMjBOeWt1a3NES1c0ZDA2NEhOckJEYTVGNVdVTURMRG85TUNKNit4M082?=
 =?utf-8?B?WnpOWFpPaW1hYjFWOSs3NGZYd2NjeVpoQkZnVENIMEUrdVBJSzFmNzhVWHlV?=
 =?utf-8?B?N2ZhUS83Rml4N1F4ajNEcytoZDUySWE1c2JZbzZmeHV2enRsVDZVOEMzT3dC?=
 =?utf-8?B?VVJRNUZpRFhFd3owYVFVUHhveDZyZTA4OEZtZWZ2d3dHS0puaEhKeVRma3dp?=
 =?utf-8?B?ZE1kLzJWSU5KSk9qR29qVWhVUE9pekVPWUVpVUZhQWM1eENZaU1wYms0VnlP?=
 =?utf-8?B?MGc4RjVLWmVhWWhoSGs1S3hhaHVhNUtiUmxXOU5kL2xsZ3pZTWJ5OUVKMmpP?=
 =?utf-8?B?b3R4WE9SZUxEVUpUU040UlVSWUxvaTV4bmZLaXJQZ0hsZEUvVlB1WjRnWHFk?=
 =?utf-8?B?QmpmTHdWa2dvbEQyNlZnUTQzZ0VtSGdmbmoxWUVVVXNaYXBMc3VPM2FublR0?=
 =?utf-8?B?WDZHcUh5cldVbFBsMVRYU2lIbW1EenVOQ0RNbFFrVml3SVFHS0p1RURuSG9n?=
 =?utf-8?B?VEpOQ2lKaGhmL3pha2ExVHZvOEgrL1JuOUhVTXBLVXo2Z0s5eHlnUjhuZkVG?=
 =?utf-8?B?emFsNHBwMlRUamphNzFJWi92UGJ6OWpJN2Zxajd0aTduaDkzdjRsQmhubXds?=
 =?utf-8?B?amJtWEd2cXZwTWF2aUJxYmZ1Vks4ZWNsTzViVmxONVh2bG9odG0vY0tpOHlk?=
 =?utf-8?B?eGlPU05NSDVIS2szY29yNWRLaFhjWDVCNVI5aEY0dkg0djNzL2lod3ZSTWgv?=
 =?utf-8?B?ZVBpcDErUW5yOVhjU1F6SjhjUWpOYTF4cm1XZ1dhZFppcEMveGdLTDRmYUZv?=
 =?utf-8?B?enBQMU5JTXF0VGg0aFFteGJTWVhCWlhPRU9keDBGMlpHaVF1U0FTeVJsdU90?=
 =?utf-8?B?VFZlNVNWQ1BZQUpIYytITHpUMUR2NW1Xckw5OTJCMUtwUS9KbTlkaSszWUVX?=
 =?utf-8?B?dElEZGhEaHBEazZTUG5RbFJ5Ky9iVXFZS2RsTlNNOENsSGJ3RmR1MkpYSDJm?=
 =?utf-8?B?cmtKRmxpMng1VHBaaitkU1ZnVFRNc0x5Y3RMb1pBT01YN3FhaXhicTFLQWhz?=
 =?utf-8?B?M0RhcFlwc095UHZHN3lHd1RBQUR5ZG4wc21lOGhCamdyR2JMN2NVdGp5VXVR?=
 =?utf-8?B?QldZV1NkcE5FMll1NjBhMFprdnlsWmgwSHErbkpseGF0T0dqbkdwSFB5dlAv?=
 =?utf-8?B?YjRCWitIUGVmUjVLbzRQcjRrQXZ4d3dIbmhpRmQ0aXZCbHpqbGs5RFk4d1Z1?=
 =?utf-8?B?SS84WEw4NkRXK2ttZS9leGt6Y1Z3QkNXejM0bUUrN284UzJuK04wdnphNlQ2?=
 =?utf-8?B?R0k0bmtKemQwREZreUcyY1BkVGJhemMrRkxpZGpoVWpFYjV6WXRxSXJlYmlm?=
 =?utf-8?B?Y3VuM1d2TzlMUzdsVjQzbWdzTjNvWUliTkRsMHVBdHNNejBSd3lITnRMa2c4?=
 =?utf-8?B?dFJmTmxvN1VkU1FKY0RwSWF1VXV6eVg1NlNlMC9CK1hXRjJEcVRuYm9KTXB4?=
 =?utf-8?B?N1JIUWxuNDV6WGY0SVhTbis5Q2Z0bys5eXU5cGRXY1FYRjhBaWoraUluMGF0?=
 =?utf-8?B?dHc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39007e69-2c5e-4c24-7891-08dd3549cb76
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 09:48:42.0385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AerKMX5tyZQ+neQNLcpVWKiFOXbxNbUJ4eVcljGP8/HbR71Lc6g/IMjX8AcE0nmcrgWZYx34gk9r9chFkoA2tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7696

Thanks for copying me, Furong.

On Wed, Jan 15, 2025 at 05:42:04PM +0800, Furong Xu wrote:
> On Wed, 15 Jan 2025 14:59:31 +0800, Chwee-Lin Choong <chwee.lin.choong@intel.com> wrote:
> 
> > The current implementation of ethtool --set-mm restricts
> > enabling the "verify_enabled" flag unless Tx preemption
> > (tx_enabled) is already enabled. By default, verification
> > is disabled, and enabling Tx preemption immediately activates
> > preemption.
> > 
> > When verification is intended, users can only enable verification
> > after enabling tx_enabled, which temporarily deactivates preemption
> > until verification completes. This creates an inconsistent and
> > restrictive workflow.

Where the premise of the patch is wrong is here. Users don't have to
enable verification _after_ enabling TX. They can also enable
verification _at the same time_ as TX, aka within the same netlink
message. They just can't enable TX verification while TX in general is
disabled. It just doesn't make sense.

> > This patch modifies ethtool --set-mm to allow users to pre-enable
> > verification locally using ethtool before Tx preemption is enabled
> > via ethtool or negotiated through LLDP with a link partner.
> > 
> > Current Workflow:
> > 1. Enable pmac_enabled → Preemption supported
> > 2. Enable tx_enabled → Preemption Tx enabled
> > 3. verify_enabled defaults to off → Preemption active
> > 4. Enable verify_enabled → Preemption deactivates → Verification starts
> >                          → Verification success → Preemption active.
> > 
> > Proposed Workflow:
> > 1. Enable pmac_enabled → Preemption supported
> > 2. Enable verify_enabled → Preemption supported and Verify enabled
> > 3. Enable tx_enabled → Preemption Tx enabled → Verification starts
> >                      → Verification success → Preemption active.
> > 
> 
> Maybe you misunderstand the parameters of ethtool --set-mm.
> 
> tools/testing/selftests/drivers/net/hw/ethtool_mm.sh will help you :)

Yes, see manual_with_verification() there:

ethtool --set-mm $tx verify-enabled on tx-enabled on

