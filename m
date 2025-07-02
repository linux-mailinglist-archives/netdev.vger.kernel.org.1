Return-Path: <netdev+bounces-203508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D75CAF6386
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 22:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 486BA1C27E3F
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 20:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4082A2BCF51;
	Wed,  2 Jul 2025 20:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GQRkF2qT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844C32DE713;
	Wed,  2 Jul 2025 20:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751489196; cv=fail; b=EdxCCPKu9GrdStnVPzJf1k8TvJcRYQYLixkXY2qij4C8lfj6D853kmzaHO06dMv7xMx1aXLCCfHJcc0R/Jl0Zh5/Di0Xg+6QhO06I46OX+0xA2Cex29w383QerOGaCgp7CCsIWcpqGmv+ZGbiFbN/aRjVlzrb/2EWfUjrAZkyBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751489196; c=relaxed/simple;
	bh=wTmFLSPh853ivH3+rYPuDFPKSyLsihgBaB5d7nyEEuU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mkRFpMuP5zVDIUvQncofk0dsf44pcnM6+hFyLy32Dauhy+ltsRkqEw8ZlEfLCFxMnoJP+jblLwlHv77In7I4EU3P19wdtlp3EdTb3aG3RFhlhX7oE4gzi+X1h4ygY7/37nxVmfkg7RK74bb20w8bEEHLk3FGvQgSfWWZ0gJVLFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GQRkF2qT; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751489194; x=1783025194;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=wTmFLSPh853ivH3+rYPuDFPKSyLsihgBaB5d7nyEEuU=;
  b=GQRkF2qTnsx4D3NsMKHeUzyt9m9ggF2T+95m+my6KkbB1MVDiQ/2P0kV
   eGIHudctOAIkynkLOh2Sb1rArUWa4CAsxT0JY9yNBEb7G0WVLAj5dXC1+
   cPMIbw5Jjqyyl3IsKPXpmSX8XzIBY/a6oajHPc2Jcx6z6WjBYAp3PdpGv
   pwfUrXNcbhu5LCbEt/JQlFhMSnJzSMuL9VvtDxNRiX/F/LxeDs9KzdvNs
   8uuUqI5Qz3zCMBFwHXpEKBExSrw450BMhlwTJ2p19BYv7Suftz6sFazL6
   0dMnyJidZK0aQIsPMizV0HJHVnRubsf1bt45K5khYoZ9/XebEJwgwmD3s
   g==;
X-CSE-ConnectionGUID: hvE8+w3fQEC4EW3cEzu5XQ==
X-CSE-MsgGUID: PSE7tdPoREm1Z9Y6L/Yjqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="41430795"
X-IronPort-AV: E=Sophos;i="6.16,282,1744095600"; 
   d="asc'?scan'208";a="41430795"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 13:46:33 -0700
X-CSE-ConnectionGUID: LW/jhvZrQomkprsLV4dKUw==
X-CSE-MsgGUID: Yvy9mPRwRUeRu5NKQBN45g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,282,1744095600"; 
   d="asc'?scan'208";a="153628951"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 13:46:34 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 13:46:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 13:46:32 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.77)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 13:46:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFN7PKPoMq5Zek5UjvzmVf+C7IExEyA2zWSE3RSHtY4QSENhArkgjlOd3gzfuB8aXAObmktvMqrTYTJZF7l6G8Ex762lJ8MnBEaBHBxbcX2g0TgxL2UgFEU9jlURqKjelgVwZ5gVbSEM5t6FMpprvSLZq2jN5lLVaCqwCxGwXCi8V8JwXJkuIeweyan3Nn4TWfq0RX+HBYtW2WM5Ybt23hrDhSlGdIFRfS0eJCDMCSHJLvR/TG6q7ybcfaqgp+AVtwkNkrorzFXkA24F1l3PqUxtHzUUMfQqTWMz/dG10ifukeOd484Ej0Ze1VF/Ilv3VENLvwhDgRnirJSfpYAOKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WallE53qglJ+l1AlGXw7HnIuLSGF4eyzVr7vuScK9mw=;
 b=xB7UoLhd11BehiGvgI9byP45IWw7/gVjsPBo3LMe7cmh5aowy+mQ6E2flpRRJ19xQHIcBuup8xCFt6Ed6/bjh0Kqp+SRc1v3seEbp6N+ZgVNnTxAldVMTfA63aeCgVMwfQrVBGFOHcj7m43BABGI8FLsiVESqpYT/9RUsebg1ejhmf4M28CxQwnR2fSmbsk2PNcP9R8l5T0C5pshlcCiulBB3uwMApw2A/CuRvxX1Jb/1zKeTi1A45IneuWsa/Ds6A/lqkp8EkbBBhSyhg3nfYucwCPVoI8UsNQY3RNYaidiJYwCcnIpnzwZ5Z60liAn3kV1KvwvzVPFBG9/GVh+Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB7429.namprd11.prod.outlook.com (2603:10b6:510:270::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Wed, 2 Jul
 2025 20:46:01 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 20:46:01 +0000
Message-ID: <44ca3f26-fe6d-4758-ae4f-a22be7599b25@intel.com>
Date: Wed, 2 Jul 2025 13:45:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/6] eth: fbnic: Add firmware logging support
To: Lee Trager <lee@trager.us>, Alexander Duyck <alexanderduyck@fb.com>,
	"Jakub Kicinski" <kuba@kernel.org>, <kernel-team@meta.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Kees Cook
	<kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, "Sanman
 Pradhan" <sanman.p211993@gmail.com>, Mohsin Bashir <mohsin.bashr@gmail.com>,
	Su Hui <suhui@nfschina.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Simon Horman <horms@kernel.org>, Kalesh AP
	<kalesh-anakkur.purayil@broadcom.com>
CC: Andrew Lunn <andrew@lunn.ch>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <20250702192207.697368-1-lee@trager.us>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20250702192207.697368-1-lee@trager.us>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------lJrkmzQ4HSP9MyQ80c0rtXZw"
X-ClientProxiedBy: MW4PR04CA0388.namprd04.prod.outlook.com
 (2603:10b6:303:81::33) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: bf28b3bd-b9f4-4424-f067-08ddb9a974ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmQ2S25jSC8yLysrLytGUDJvRVc1K05RbjRtSEIzdnBoRTVhaEQ1c09KRUJM?=
 =?utf-8?B?YVFBMVlGSkQwQkptaGhKMUVabWhZaVhBNTJzc1VTQktWOFQzSHQ2bUNzVHN3?=
 =?utf-8?B?WGpEbXJueXJoVDcxTytWMkNGaS8zN3liTWVLQjFoR1lJakhoTXFLajNYUmlO?=
 =?utf-8?B?UGc5Qi82T2VhV2N4L0lBeXgwRHVhQ3NEMDZqek4zRGp2Z0x0a2UwMGMxRFN2?=
 =?utf-8?B?K0FhaTFUaStpTXI2SE9mV3hTNFUrSUdqM2ppWjNQSUI4YmRWck1KK2RENUta?=
 =?utf-8?B?dGVEWDR4L2FHcGtwWHJaS2VlSHVPbHBHMktWWG9YTG91ekFzbS9KaVFSYkk2?=
 =?utf-8?B?clJIOUZVTCt1S2VNK1F0QXhtTEJmaWRnOWFRNTEyelBCNlJPQ1NiY2hFbEVq?=
 =?utf-8?B?UldUbFR5ODREL2dTTllpZWhrbS9xUjNYcXJzVFIwSm4xR2xCMFVBK1dWMHBY?=
 =?utf-8?B?YitJUmZoNnpKRm10aXlvZTBmbFQ0TGt5VE1JMzZiU21BWEhRUUlzTWF5VmFs?=
 =?utf-8?B?S29QRTEvdHJwQzE0ZXVpSlVoR3VRRXE4MUw3M2lLUStwR1JRWGJTVHVnZ2JT?=
 =?utf-8?B?dk5zN2JZSTA3Y09VTGxjQUNjTGZ6dmJWbVNuZWJpekppUkZRenJtSyt0K3pM?=
 =?utf-8?B?QU5BeHhZbHd6aTZtMmxJeTd4ZVM5V2l0eTBEUCtHNStlTHFrN2RQTGRIZjd6?=
 =?utf-8?B?R2RXSkF4YnRvdnFXOXFhaUE5NDhjNUNTTzgzSmlBYUlOcTdiczJsYS9MRXRT?=
 =?utf-8?B?aE1sVzZVQWM3ZDJoMDRWNHB6b0FHNlhiK05rL1hMdHdJV2UrUm44Z3l0WUNE?=
 =?utf-8?B?RmtxemhCN3lpTVBLVHhwbEdEVWR0SlVuRFMxWjF4ZXQ2UytSL2g2K3dTYThi?=
 =?utf-8?B?OGJWRmZaUlZ2dk1iMHJUb3JvaDRYZDhCNWJwSXpuNlpaWUZyTEh0ODFKSGlV?=
 =?utf-8?B?U2d2WXZraG16VytsKzUwL2oyRWtYMXp5dGFoTldmWFAwRHVhTmxQVFZ3QzZm?=
 =?utf-8?B?dnNjZXh3MCtucm8vOUp2dytrZ251bWdNRDlFY0VBRHF6SXVCd2JmTmJEeXo5?=
 =?utf-8?B?L1I0dyt3RVJ3dmFjYi8ySHN0b29DSncrMHh5YUNYTmc4RVVSY1FnWjBZV0o0?=
 =?utf-8?B?SXBXUHJBdDdKVnVGdFNYRGYvNS9BSGVYVWIwT2NNYTF3T2xMRWZWYzFHZFZE?=
 =?utf-8?B?YlBpZy9BSFVjRDJnSER1NU5FYWlsTVNTcFlxNlplMjBRZTUxZGpvYlpTUnA1?=
 =?utf-8?B?RjJ2dU9CK2VNSlVJVkVuNENzZFJ0MkV6ay8zb2JpWjZnL1FlL0RIWmZtMWta?=
 =?utf-8?B?bk5zZXdraE1KZGRTNGZkdUxzSWlZZC8xZ2xWTWt4MDkrdkdTRUY1djVlbmts?=
 =?utf-8?B?M2F1QjJBQk5wdmpETklmczFEQzBqNlUvUmVUbnd1R2RqUjlyOFlMQWE5RDU1?=
 =?utf-8?B?OXZkMjdqMjFRdDhiWXk4L0t6UFZORU1DeERML3p1bXBpMmhEVXZteGM2WnRW?=
 =?utf-8?B?V1kwQTlyeXlvK0xUVUpCWXV1L3V2cmtNb1FuRFFUWGlubzAveUZva0tyWHd3?=
 =?utf-8?B?akowOG9zMzNnMXYvQ2Mrc1FqblpzL0lYeWV5cncwRkIrTnRtZmhOeUxEcWc0?=
 =?utf-8?B?czl2VlcxV1ZJNFQxeFd2VXZqdTlzMHhFcGlWeGdONXJ2UXlJNXhlRDNhR2R4?=
 =?utf-8?B?RDh4dVNQSkY1UG93clRXVTFJaThJRzlnMUY4VXNiTVpHcDdidG9JL3p0Y3Bv?=
 =?utf-8?B?a0lSWGNKUUFUb1J0cDBVekQ2WnpSZzA5cjlRTHZVdkUzaTlwR01lRDlSaTVL?=
 =?utf-8?B?aTZnbEFBbUl3cGE3QlVZcmdBdGtQOUZrbGpFZWZtUHlBYmN3MWRWVDdJT1dm?=
 =?utf-8?B?OUtaK0xYYWFZc01LZXY4UUhEMmo3Q3pmMmdjZk5Sc3FYaWRzNmpUeGVYOHM2?=
 =?utf-8?B?UkkvK2dEaHllcGxaMlBoMGVIZ1VEOUFSVU1UNURhMTZvait1TmgyNWg4VE9U?=
 =?utf-8?B?QmdUbHNPbk1nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjdpMnkweTVxdzdJS1M0WXRSakRiN1k4aEIxRmxtZVpzVXBoZXk4Zm9KZnpu?=
 =?utf-8?B?UEFKWHBBS1lvQVZNbU5ONTFxMmFNeXZEdWMxem5nWjZyMnNaTGIveXRONVVJ?=
 =?utf-8?B?dWx4aUpTM0xOR0h3UWFia29FZmdEVDU5TWpGUzU1bmRnZEExeTd6UEdCUWpj?=
 =?utf-8?B?b1BSdWpvV3ZRSDNkYzQwQlRtQ0hxV0JneHZSa3MwbE5uZ0pneDBZOE9VRUV6?=
 =?utf-8?B?VzJQWTZaaHU3R2ZKN0I2VVp4RWQ5MnRpQTkzYUVtaWhNTlM5ZUpFbE9UekJ6?=
 =?utf-8?B?MDdtVGtvaGZvbmhXYTZ4b3JRQVE5dHdzYTA3aHhzQ2k3VDcvZEpYNzZCQXVI?=
 =?utf-8?B?b3ZyUGR0RW1DVmRMME5FaWtsWmhxcFgxUUN5VC9ieVY1cjZSTlA2dm9jYmlK?=
 =?utf-8?B?aXBXMHpVZnJtWWR1ZjRBcUMrb045WHpYcFZzWHpoWVBGZ1h2aVc1NzhTZ2F1?=
 =?utf-8?B?QkFLTXZ2Q2p6dkdxZENVdXJndFE4U2p1bnZ3VDhuNjFMWGNhRk9vNUJkdWc1?=
 =?utf-8?B?Tmp1djJLTkhZNFVoWHhRZHVXdDlsY2FqekU5bTZiaDFQcWF6cEFDS2Z4Q0hs?=
 =?utf-8?B?ZVpDNFI2RW1uT3Q2L0Y5VzUvMUpNV3owVGdmMGIzQWVrVzQwdEJJZDk3OGU1?=
 =?utf-8?B?czdHMWpaaUVsa1RoQmQ4T3ZhSjV6K1NmUlBXUVY4NDFaR3Y1MW41OVc1eVR4?=
 =?utf-8?B?MkUvTGZkNVdlck1obUhDdmdrMjlqT0NoVEh3M1F1dUtyNnhPYW4xWk00dC9t?=
 =?utf-8?B?SWtBZlY3OFpBYW5iNFRMcmNnQWNzaVh2aFp3aFVZL1Z2RTV4NUE2U25WKytV?=
 =?utf-8?B?cjIrem90Mmg4ajF6aWZ3WDZCWUx1QVh0WXJjczRBTHZ3bzdpb2hOMFhucFJh?=
 =?utf-8?B?ci80T3pVZGRMU2N5WitGMXJxQUN2SlUzTTdhSE9ncFR5ODg0OW4zaTQ2a1Bn?=
 =?utf-8?B?RjRQYlM5eFFrSmN4QWlMTjFqTTVUTUgzRUp4QXk4NTR5N2ZZeXBMZmYwandT?=
 =?utf-8?B?TTRnbXpYbGtTS0ovYzZDZUlTZGtnZjZXa2VzendQT3duTTJoYytsYmdlMUVG?=
 =?utf-8?B?a0o5c2RtNjd4aHc3NFAzSm1EQzdkMkxYNmI3UHBRWEZxQkpDeTJxWEZaOHVt?=
 =?utf-8?B?SUV4bVlQTm1TNWxZQ3c3TWhpWHJoR3ArbmdROHI1RGNvUklxM3NnL210SWp3?=
 =?utf-8?B?VVprTklCMm9hQTZYanFLZEtmdnlSNkI5NDJJajE0a1BmUGY1VG1QOVpRUkMw?=
 =?utf-8?B?Q2VSNnRTNWd0ekM0NEIwMERDTWFzeXpvMi85bzhJdEpUckg3VGRjUzU2S2ls?=
 =?utf-8?B?cU8zVnB4K0o4eW5iVkVNYjcwT2VUU2F4V2kzKzlib0VwaVUxeFYzQ1BWZktw?=
 =?utf-8?B?T3pWdG5xK1o2eHhPRkdneFZrSmZYU3RlNnhaWEV1cGRzRVkxYWNSUHZjcW9S?=
 =?utf-8?B?NGVaTmtxNTduSXZJZUFqTExiMlk4K3V5Z0h5OElYREhtS21TR25ibitOMEdv?=
 =?utf-8?B?WlVHTWR0cW56YlJwYjJZNFJHRGRPM0RaT3N6WlFYNHFDc2p1bTJxTGtBSmFn?=
 =?utf-8?B?bUFGT2JxYktpZE5JaG1oNlkydXV0SkRodHoyYUUvNHR6VXY2YktxdmRIOUh3?=
 =?utf-8?B?V0N2N0l0QnlaaFVoVnRib3IwcU1tU2cvWml3M2xpSVRwUjR5U2hyOUNIV2Fh?=
 =?utf-8?B?WEd2emx3UVdOelU0TmFSVThsZmVBSW1HQjYrRk1rWWNlb0tKN3BKN1h2bW9a?=
 =?utf-8?B?ZG1wNUVHOHB0aWhucXV3d1pieFZuRlBnWHRhSk1xamtKa3NQSU50VW5vSXBj?=
 =?utf-8?B?UDZRa0YreDkvMWtDczJVekFvSnBpa0UyOUpOZGxCTHBMY3dYMVBSMXpYcXFY?=
 =?utf-8?B?cXVMeHE2M1dZcnJNVWljVHhyL29UOFZYdWI3d3VUaDNrQWZWVkZrdFJOU3dt?=
 =?utf-8?B?L0RZNjdnc1JyTk5SRkp6QjhYSjJ5UlVrenk1SGE3bTdTZDdpa205Y3NTU2VU?=
 =?utf-8?B?ZFpqL2Q1NVNzNnQzaGRvVU80T29wTjdqbzIwckR0cHpmNTFiL09GWDQ0WjlU?=
 =?utf-8?B?WFdyUVN1MG5ubmtIc3pMVUpJaXNqbWtyS3JJb1dxOWpoUFFDKytHc0FBWGk1?=
 =?utf-8?B?dllQR210T1RhYXpoaFByOTUvSnd0ellaYVJzWnAxblJoODIrTWl4aDBUTWZS?=
 =?utf-8?B?V0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf28b3bd-b9f4-4424-f067-08ddb9a974ae
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 20:46:01.5926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+ozgHfo5TYixPm+QVvAZYv8/o0vaOHXouB0FbAjUpD+rVkwLl2XGdWaMsZ9YWiEfZ7MrqCSuPCZoVn7025lPq+ya/TD3U3pXcTxm6ohkQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7429
X-OriginatorOrg: intel.com

--------------lJrkmzQ4HSP9MyQ80c0rtXZw
Content-Type: multipart/mixed; boundary="------------1W5caA9uKyCT6OK2Uf21fftQ";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Lee Trager <lee@trager.us>, Alexander Duyck <alexanderduyck@fb.com>,
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Sanman Pradhan <sanman.p211993@gmail.com>,
 Mohsin Bashir <mohsin.bashr@gmail.com>, Su Hui <suhui@nfschina.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Simon Horman
 <horms@kernel.org>, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Cc: Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Message-ID: <44ca3f26-fe6d-4758-ae4f-a22be7599b25@intel.com>
Subject: Re: [PATCH net-next 0/6] eth: fbnic: Add firmware logging support
References: <20250702192207.697368-1-lee@trager.us>
In-Reply-To: <20250702192207.697368-1-lee@trager.us>

--------------1W5caA9uKyCT6OK2Uf21fftQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/2/2025 12:12 PM, Lee Trager wrote:
> Firmware running on fbnic generates device logs. These logs contain use=
ful
> information about the device which may or may not be related to the hos=
t.
> Logs are stored in a ring buffer and accessible through DebugFS.
>=20
> Lee Trager (6):
>   eth: fbnic: Fix incorrect minimum firmware version
>   eth: fbnic: Use FIELD_PREP to generate minimum firmware version
>   eth: fbnic: Create ring buffer for firmware logs
>   eth: fbnic: Add mailbox support for firmware logs
>   eth: fbnic: Enable firmware logging
>   eth: fbnic: Create fw_log file in DebugFS
>=20

Everything looked straight forward to me.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/meta/fbnic/Makefile      |   1 +
>  drivers/net/ethernet/meta/fbnic/fbnic.h       |   3 +
>  drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  27 ++-
>  .../net/ethernet/meta/fbnic/fbnic_debugfs.c   |  29 +++
>  drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 179 +++++++++++++++++-=

>  drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  36 ++++
>  .../net/ethernet/meta/fbnic/fbnic_fw_log.c    | 123 ++++++++++++
>  .../net/ethernet/meta/fbnic/fbnic_fw_log.h    |  45 +++++
>  drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  21 ++
>  9 files changed, 451 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c
>  create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_fw_log.h
>=20
> --
> 2.47.1


--------------1W5caA9uKyCT6OK2Uf21fftQ--

--------------lJrkmzQ4HSP9MyQ80c0rtXZw
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaGWaiAUDAAAAAAAKCRBqll0+bw8o6Ek8
AQCOKkdFPoxlTF57qHQcD8GZ6xUPa7afsxNVI/CblFategEAyh4RRiIuGigk9+k1ULxgeI2o+w4G
XqJNCIyq3ntd2g8=
=/tII
-----END PGP SIGNATURE-----

--------------lJrkmzQ4HSP9MyQ80c0rtXZw--

