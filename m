Return-Path: <netdev+bounces-114420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF63694286A
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 09:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 956ED284B0D
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 07:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62481A76A3;
	Wed, 31 Jul 2024 07:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="N/WKGPWQ";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fa8Ihuvg"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A02D450E2;
	Wed, 31 Jul 2024 07:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722412553; cv=fail; b=KnrxYcc7Bzkqahkua3E9cz3Pk9PLz7nnP3UV6Zf61Amd+J6uakFQrvyg9/G/VdxG46RDYhI7Xu7WWflLABHPoNudxDqchVD/w1DQ6zOqmvYICXnQ6zfOgBcZ+/9IbCQOlTwoYuiBbVB+pJDS1jrsOXf/YGXfZ56oXd+ZcUZJYoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722412553; c=relaxed/simple;
	bh=twGhPuaLBWuIwFuqPEm6o6lA2uYRUgNUf+pasWlkiBc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kDouF3f1Qg+R2Wbf/oSNL26fRskrZum2ecMdiQpXhdoEHWEDJBIXlsQYn4Asi46UAI6MOZDRZwLjO3kEk2PnaCxPjVTnUTyme3JWcuBkqYsQk90pViRK0sQWn/gcosrwxU2EBjLoS3fBDBAmz4pfYVP6n+Ye+xh+DTpYivZLwGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=N/WKGPWQ; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fa8Ihuvg; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722412550; x=1753948550;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=twGhPuaLBWuIwFuqPEm6o6lA2uYRUgNUf+pasWlkiBc=;
  b=N/WKGPWQbLmWnsXj5XXRZn06XN7K1Aru41PwqkQBSAiNQVFIeJr27x/v
   ++g/2i6726mdOzTsPjpMHU6h9bRT+Ubm+9EN+Joad/jz/MtJ2VXkRtphC
   /4Yy30eyLkObi4PqLyvOOSG/2/GWwF8z3bthufGwI11I5WrIVU0Xs4s/k
   gwQ7s3DRn2afmFIfRd/QiyM8WacegUK0toZ8diC5YwQCbazZz5diL5UaY
   5FBZ+J/uPfUMW3Gvx2PwXAfRd5Sh7tD/8XuApLNpUPxHABf4POeYt4SSC
   b+DDQbx/9Ho+6JcsQfpE4HuBVFGxw8K3VipNlutKo+K0Uefq3IgMl2J8n
   Q==;
X-CSE-ConnectionGUID: E44E5yLcSSi7THEmw6H9sA==
X-CSE-MsgGUID: PKT5KzrzQrGjujXgpMZ07A==
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; 
   d="scan'208";a="197322511"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Jul 2024 00:55:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jul 2024 00:55:37 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jul 2024 00:55:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wPILky6pptwPNW1Pyjf30Iz6opoGGHDVNhR7VQ5rk9krSfGgBStcEWAe0bFffQ5KOS117lKFEUwndnge0Aq9wVp7wPM1NKTVoSk0A/yFwIQBjUoZl3qR1mzDjDR4sWYAyByyQnSZ1s5ZeDkhvBMPA08krMuSIJTGkeQQkGtUZQgkZf5Y9rZ+EerzwhYI8eILZpTsteBQSnyGq60y9ojimpY9u1IwG+Onk3K/JAP61xTnSFnkMc7y++moVPowJZlMKhAm7Cb9gvjP1ljvB9mzFGoRAlGhAyoyAALLI8AmGB/cUH+PPtmSK0Sr7eIDJIQAXZ86JASzoyoWLIfqP8kcAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twGhPuaLBWuIwFuqPEm6o6lA2uYRUgNUf+pasWlkiBc=;
 b=DyFfG0lPVVRZtH/CI5DBDElIEnqCSVVcUY90wzZwMDSEk1EzXehMTKshNCfL5WMe4qdD/BZ5sHNc+1VM+0fxNNnf+0NopaTTc1WKjvL+5/YJeF2MKEwoK77wxCxchzpYYZEAO3+Bchimf+sUGNqldfRvuef8ivt2hr0P3nhV3sS5ZSiPiLQFFuHW+8eTQN6N0pS9jt2v2Htpn+Ef5Otu8MTkF819LFLS933McjIMsc+Nr9EbLZunyVHTQtMvWsHgHNSRru/D9sA4vc3WMdLfM07xK7jidrbR5j9N84m9NDD69SFaLKSlLaEQbv4al6SOrRCXiZDxW1E36i/INoc5tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twGhPuaLBWuIwFuqPEm6o6lA2uYRUgNUf+pasWlkiBc=;
 b=fa8IhuvgGpSOXldKvdySi0JI8mHQNlU6VWjJ4er9a8i0wwlKFbZB88nNAMtJvuwBnSaMfVPAWTCH8EOZOcRUMVjB9twmqSqFaeT0ZWyqejLFGmqj3b3YPBStyYzLG5Z7vlKJWNnDg0EPnL7NEyY70G0UVlLxsoIZHCHqRRAj6JWnyzP8D/oESgML7l1m3bY5PERag1/JNgrGubXVzZzL6TkVogoB/eiazEnuvN34hy9gqMhaBvjsx7PYnrsDu5TQm2lvwMaxiSQ1qd4HacFFCWzjZBWeMN+kHuftD+Xl2HTgyrhuvO1pdT7njSN2BpNbTL/+otynXO93LY8WNLPu+Q==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by PH7PR11MB7962.namprd11.prod.outlook.com (2603:10b6:510:245::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 07:55:34 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%5]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 07:55:34 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <rdunlap@infradead.org>
CC: <masahiroy@kernel.org>, <alexanderduyck@fb.com>, <krzk+dt@kernel.org>,
	<robh@kernel.org>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>,
	<linux@bigler.io>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<saeedm@nvidia.com>, <anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v5 13/14] microchip: lan865x: add driver support
 for Microchip's LAN865X MAC-PHY
Thread-Topic: [PATCH net-next v5 13/14] microchip: lan865x: add driver support
 for Microchip's LAN865X MAC-PHY
Thread-Index: AQHa4jaTAREq0XzH102IOZrpnjB75bIOqbGAgAHP4IA=
Date: Wed, 31 Jul 2024 07:55:34 +0000
Message-ID: <6acd6d65-7dfb-4b3d-9a39-edcc5728261f@microchip.com>
References: <20240730040906.53779-1-Parthiban.Veerasooran@microchip.com>
 <20240730040906.53779-14-Parthiban.Veerasooran@microchip.com>
 <6750b19d-4af3-44c8-90a6-9cb70fcec385@infradead.org>
In-Reply-To: <6750b19d-4af3-44c8-90a6-9cb70fcec385@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|PH7PR11MB7962:EE_
x-ms-office365-filtering-correlation-id: 373fb0cc-3a93-47be-399a-08dcb13628a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dFA4YjJJeVpKWlUyVWQ5SStWVmE1aTNuYXd3c1o1ZFZ1ZDlPZk5mZlV0bFlF?=
 =?utf-8?B?d3UxbE5hdHNweVhBYnhYSFJhTVI2WmY2NUszVXVoL0lXWXBpVUdMNHg1N013?=
 =?utf-8?B?TFEyNFBTZ000bTl1QUpWeUFKMEtKcEVPd0RmUWQ3RDB0N1JtYkNLNTQ0RWtQ?=
 =?utf-8?B?SXVzcklsMThXVDdCajJNMllWeEFmNnJTbTdMcG1TeG9wbUozbGZSNERwQk1z?=
 =?utf-8?B?OU1EUTJUZGxYSTNuYW5vbXRNSmVJdUpUUWZCaU0zN0lvRXdNbThFOUpJbVB4?=
 =?utf-8?B?S3VtVmdMTDB3RDgwRkRnZk5pb3dHVWcwTkM2YzVJd0RubjUvdk43cVBHcDdT?=
 =?utf-8?B?bUhHTHJITExyN3F2YjZTODQ2aERYNmdtbHRGZDBJVHVVUUl3UTlaUjgzVzVj?=
 =?utf-8?B?QVhOTDJpTHY3NmVWS2EzRXF5Vk4wbFVyNVd4VHpGRk5BQytSYlF0dk1VL0tp?=
 =?utf-8?B?WUZwN3FzVlpDRTZ2SmdUSUdmdzd3N3ZjdmF0eS9MSDZSZTYvM3VxMjZRUi9B?=
 =?utf-8?B?QkZ6eTRsMzFBejluZW9KNnJzMnZodjZHVWdFL2hKR2lDWWp1bHR4VUlLVnZM?=
 =?utf-8?B?U3JrdmQ0cVdsblRBallLQ3pLTHZ5VFc2VmZtMmt5VWR2ZTVha0s0dC9wVDBM?=
 =?utf-8?B?VXVNY0tLMkI5ZGdBVko3dWcrVFJDcW9PYk1oWm9yR000eHI5RGIzUXZhdzh6?=
 =?utf-8?B?MmUwTXFYRXJMaTJFTjlZRHNPWkJzdENDTHJ2YUJsSXVZL1VQd05hMDZjYkJS?=
 =?utf-8?B?alBjaUk3OExGbTEza2Qyek5ROEFkTllicWF2TkpaQThXcE5hOS83Ujd3eUdN?=
 =?utf-8?B?d3hGcm0rTVI0SnNDVjkyd1FzSUlBZTRIMTBBUS93RHB2UXFBNnhZVE42WG1h?=
 =?utf-8?B?NHE4TGJJSFgvTXkzVHA5ZnMvRGpyNUs4S1pERWdKRDBLQTQyUmZpR0FzZjRC?=
 =?utf-8?B?eXZFaTc5U3BsaFk3TVlPd3ZTLzNzajFja1hSNXRKT1lsaVFuYTlsZFp0RFZR?=
 =?utf-8?B?K3hoWVkxZmNKTVVDU2QrQXd5OU4vVUhuR3pMcUtlQ2pHVUkweTd5ZEtUMmVw?=
 =?utf-8?B?bnBReXJ0Vk5POHlEaHVBd3ZPcExLcEtYamJzRmpISTQ0MExZSG43ajVObGlM?=
 =?utf-8?B?UXpxVlFaelprWmpmQ0d0SGRlM0RqbjJPWXBxZjQybkVkYUlKOTMyUjNwK2s3?=
 =?utf-8?B?bzhjeHY3aXkyTzNlNDk0eHZqMlNiM2c0R1pzRDhSWnB3N2E1amlza1NwSVFT?=
 =?utf-8?B?Q0luRFpzZWNDN0Q0Ulcya09RdFpFNWpuT3hHemQ0dThBeW9zSDBLNTdOeEtK?=
 =?utf-8?B?WFMrRUNuTnFUODI4eXRVQndwc1BodTFCekc2RXVqclQ1dmlSeHFuMzArdk03?=
 =?utf-8?B?bys3L3VZV3p6aW9qelB4TGVqM3ErM1M1aHFwZVpzbnBFRnl1T2MyNzJBNnNO?=
 =?utf-8?B?WnVsMUtzNjc0bWR3NlY2TXRhYXhia25YcVZoU1hqSVZzL3pRSGZHaTI4bUg1?=
 =?utf-8?B?aGU1WXNtblRCN3BTd3hTUk84eDBnZlg3TW1zaW1ScEgzdEtobkdoWmhNUW05?=
 =?utf-8?B?UTM2MTUyRUVTcE1QSU9EUjBoaFpsb3B2Q2ZwaHphdWNONmFFNmJiVHorQnFW?=
 =?utf-8?B?TEphMGJWNWhBL3lodFhIK1p0eFp2ZGRMaTZRczhqYU0vZTlqV3k1NHZobWJR?=
 =?utf-8?B?ekoxRjduc0thbHhvM3RsMmYzZS93UWs4RHBzK2Ruc0tVRlhzWHorTTJOWHNY?=
 =?utf-8?B?TXZLVGNYcGMvWFZhYlpSajFkZUZHSjlRSjN6T21naU5tQVBQa1dvWWE2OW0r?=
 =?utf-8?B?eU4xTjlrUjN3SCtiS0xiSUlmeU03cEZoZkFaK1BKYUFaUXc4VlNYZ0U2K2d2?=
 =?utf-8?B?N1FZNXlSbDZSSU9LODhXUkk4Vm9Ba0FTY3Z1eGY3SkpYYkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTFSWWFDZkR3c1R2aUhLbkw2Vkg1eUxsaUpZMVV2MUFpTlhIZW5YZ0p6cGlh?=
 =?utf-8?B?V3ozVzJScFRoY1MrYktvWUthMHlJWklhemp3ZkdVcUdmU1o1blNTN1B3MzNv?=
 =?utf-8?B?eG5vR0lpcGQwenpSQTNuY3lOWWk5ZkZ4bTd4L09nYXNSbFY4R0FTOStVaXVv?=
 =?utf-8?B?emtWVkxxRSswUElOTmQ1WXNtRU9EeXdOZEVGdnFndUhNZmcvbWVtRWgvZ2Za?=
 =?utf-8?B?d2ptMWJYZ1drNmNZSE43RUcxdDYzTWRoY3VPVlRENmZLcXlWS0FnSUk0aDN6?=
 =?utf-8?B?RnpWQVlOUnlHdTViQ2hyTlY4OFYzNnZvZzFhMkphTWtBaFJTTWU5SFF4L3Mr?=
 =?utf-8?B?MEg1bXZrLzVwWDFUZ29NZlI3RFd3N2xqYjdlZ3BVaTZrOTNHUFRNa2Q5QWt3?=
 =?utf-8?B?UkNHRjI1cnIzM1c0SnN2OVY5MHNxOEpMVHZsM2dkZUNTZ0xrUlM4WndHRWxV?=
 =?utf-8?B?bnMzYUVEK1RNaGVmUjNCRTIzWk9oSkdQNWJyWlFtd2o0aTBnazJYLzB6ZXZv?=
 =?utf-8?B?QmZoS3NUYVJHcTV1VndzZllCYktXVjBLcWdhVFpSbjErYVBXZnhlWkltR3RV?=
 =?utf-8?B?OVBUYzhwVk9UNVoxUS9LZVJKdFVDaUNGR2x1TnQwTkdub2hxZnZMaElJOWFI?=
 =?utf-8?B?US9BTmpHRmFhMEtZUmpNWnYyV1JJeVVvbUxuMGIzQ2luVlB5QUlqUzFVZVAw?=
 =?utf-8?B?MkZTZDMxMVI0QmpBVDNEVzBLanhjOXFhL2wxSEl0Z3hmWWl4SlRCSTY1elVv?=
 =?utf-8?B?OUtYTjQzcmlBUU5lK05BMmRjRjBSMzNCSmc0Qkx4N3RnbWFBaFlOaTdrOUJk?=
 =?utf-8?B?UWtRbGI4ZGtqUUNRcmUxUHFZUjZ1SVBkZm5ZVGx5MjJxb2lPTDFHTy84TWla?=
 =?utf-8?B?c0dVN3BNcE44NENxZGh5UCt6Rml5U3RlN0JOTWdPMWtvaFZzcE4xQW4yUi8r?=
 =?utf-8?B?eEJWUW5OTXI3L0JvOVIwdXdGekl6UCtSc3g0WW5MYVk1MW52M3ZZMTVlV2R4?=
 =?utf-8?B?Q2dpWEJ1QTBWeVZwVlNLZkNkMDc2S3ZrWEg1SjFxUFBmMkhjbTFFUm5XVUdS?=
 =?utf-8?B?RDlmbmlxU0s3cm1kVnJNV2tRdGh2SUZFNkJVYWtpM2F2a0p0YVBNbEhnSVVr?=
 =?utf-8?B?WXNZVTFibWRXeEE5cDVnS0FERzdnTjA0M09PaTd3WmVHNFNBQmdUaENhclVE?=
 =?utf-8?B?c3c3T2xzcFJWaHZKUE5yblFlYTF2d0dxTkRGbVo1L3RNVFp1TkRaa1I1WEFB?=
 =?utf-8?B?a29ZYkQrbW04NDhPWE56amd5Y0VIL3BQNEVqa0MrMzQ1UmNibTlvNXF4V2dS?=
 =?utf-8?B?UVcrS3RnUVB2UDhYd1JLdHc4aUZHMlk0aDZFN2VYTWszWHYrL09ScFdGWmZB?=
 =?utf-8?B?eUR4UlhkNHpzNmh3VExuMHhzVU91S1Y3ZFIvbGhTVkRueCtGcUplWVJmUi9E?=
 =?utf-8?B?WkZBK1ZIMWRZV3YvZko5OVRQT2p5c3VUR3lYVUg2YytkblBCVUhVdTd0eW95?=
 =?utf-8?B?cnYvcDJEbWZYUHozK2VoTjhWbjdqVHA0a2F4RUlGdEdzODJGLzUveDRZTk5a?=
 =?utf-8?B?Rlh6TlZ1ZXJ3QWRUVEk2Qkt5Zk5UZWo1NWJRWW1UNURpZ21pSUVvWE1Yd1Fw?=
 =?utf-8?B?a2I3N0xqU0pJNml5bkJaRlh2R0hzakN6ZGpJVk5IQUlCMWVzRVBMZmIrZ3Mx?=
 =?utf-8?B?Zis5eCtIa2JhUU5seTE3Uko4bzBWRXY2aW1RNG1jV09kdktyN2s0YjB4Yi9X?=
 =?utf-8?B?WkovQ2ZCVE1wUUlJNmM0emcyUjA1MWhhMTZ1Mi9GdkdmM0RmUDZpaEhZUjcr?=
 =?utf-8?B?VmFmVFB4aG5vNU1FenVDcE9pTUcyNHY5ejJHNmVnVTIydi9YelNzSkVzUlg2?=
 =?utf-8?B?aEtXWTNMTjJFOVRrejlmTzZGWU5BNHdidGUwOVhOMUYzbnVnSFBhak91Rm1q?=
 =?utf-8?B?WmlnLzhCeWVhaGdSVmJkY255N2pZVyttZGg1a1NXNldHZmQ3bmpLTjZNSTNo?=
 =?utf-8?B?Ty93QUxrU0ZyWC93ODE2MkVYZCtkVXgvQjloQ1JpTmhJa0xvcGFkbnlzVWhZ?=
 =?utf-8?B?OXdWZ3lzcEhPZWVvaUp4ZUpJb0o0SVZZdHFsalNhNnFSZDNLa3hPU1hubUlF?=
 =?utf-8?B?Q3I5UXpoZGZEWVBiWkVuQTdjS1d6Y3ZMT2xyS3RwSnNXbEd1SVkyT09MQXBI?=
 =?utf-8?B?TXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10BC3A366DC1A94080F89E7201BBBF56@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 373fb0cc-3a93-47be-399a-08dcb13628a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 07:55:34.7357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NjpV1hbUlccydexEWEWPofINCZAuCLdqMtTSQC3t4Fc8hSXEXRZmUzBbPs2BkckAPU321E8MS6FaJqHy5d8W6GLl4C2/92vBbHe3jgiQkzFqmttwUPSLXmX77wrvNKo6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7962

SGkgUmFuZHksDQoNCk9uIDMwLzA3LzI0IDk6NDUgYW0sIFJhbmR5IER1bmxhcCB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiA3LzI5LzI0IDk6MDkg
UE0sIFBhcnRoaWJhbiBWZWVyYXNvb3JhbiB3cm90ZToNCj4+IFRoZSBMQU44NjUwLzEgaXMgZGVz
aWduZWQgdG8gY29uZm9ybSB0byB0aGUgT1BFTiBBbGxpYW5jZSAxMEJBU0UtVDF4DQo+PiBNQUMt
UEhZIFNlcmlhbCBJbnRlcmZhY2Ugc3BlY2lmaWNhdGlvbiwgVmVyc2lvbiAxLjEuIFRoZSBJRUVF
IENsYXVzZSA0DQo+PiBNQUMgaW50ZWdyYXRpb24gcHJvdmlkZXMgdGhlIGxvdyBwaW4gY291bnQg
c3RhbmRhcmQgU1BJIGludGVyZmFjZSB0byBhbnkNCj4+IG1pY3JvY29udHJvbGxlciB0aGVyZWZv
cmUgcHJvdmlkaW5nIEV0aGVybmV0IGZ1bmN0aW9uYWxpdHkgd2l0aG91dA0KPj4gcmVxdWlyaW5n
IE1BQyBpbnRlZ3JhdGlvbiB3aXRoaW4gdGhlIG1pY3JvY29udHJvbGxlci4gVGhlIExBTjg2NTAv
MQ0KPj4gb3BlcmF0ZXMgYXMgYW4gU1BJIGNsaWVudCBzdXBwb3J0aW5nIFNDTEsgY2xvY2sgcmF0
ZXMgdXAgdG8gYSBtYXhpbXVtIG9mDQo+PiAyNSBNSHouIFRoaXMgU1BJIGludGVyZmFjZSBzdXBw
b3J0cyB0aGUgdHJhbnNmZXIgb2YgYm90aCBkYXRhIChFdGhlcm5ldA0KPj4gZnJhbWVzKSBhbmQg
Y29udHJvbCAocmVnaXN0ZXIgYWNjZXNzKS4NCj4+DQo+PiBCeSBkZWZhdWx0LCB0aGUgY2h1bmsg
ZGF0YSBwYXlsb2FkIGlzIDY0IGJ5dGVzIGluIHNpemUuIFRoZSBFdGhlcm5ldA0KPj4gTWVkaWEg
QWNjZXNzIENvbnRyb2xsZXIgKE1BQykgbW9kdWxlIGltcGxlbWVudHMgYSAxMCBNYnBzIGhhbGYg
ZHVwbGV4DQo+PiBFdGhlcm5ldCBNQUMsIGNvbXBhdGlibGUgd2l0aCB0aGUgSUVFRSA4MDIuMyBz
dGFuZGFyZC4gMTBCQVNFLVQxUw0KPj4gcGh5c2ljYWwgbGF5ZXIgdHJhbnNjZWl2ZXIgaW50ZWdy
YXRlZCBpcyBpbnRvIHRoZSBMQU44NjUwLzEuIFRoZSBQSFkgYW5kDQo+PiBNQUMgYXJlIGNvbm5l
Y3RlZCB2aWEgYW4gaW50ZXJuYWwgTWVkaWEgSW5kZXBlbmRlbnQgSW50ZXJmYWNlIChNSUkpLg0K
Pj4NCj4+IFNpZ25lZC1vZmYtYnk6IFBhcnRoaWJhbiBWZWVyYXNvb3JhbiA8UGFydGhpYmFuLlZl
ZXJhc29vcmFuQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+ICAgTUFJTlRBSU5FUlMgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA2ICsNCj4+ICAgZHJpdmVycy9uZXQvZXRo
ZXJuZXQvbWljcm9jaGlwL0tjb25maWcgICAgICAgIHwgICAxICsNCj4+ICAgZHJpdmVycy9uZXQv
ZXRoZXJuZXQvbWljcm9jaGlwL01ha2VmaWxlICAgICAgIHwgICAxICsNCj4+ICAgLi4uL25ldC9l
dGhlcm5ldC9taWNyb2NoaXAvbGFuODY1eC9LY29uZmlnICAgIHwgIDE5ICsNCj4+ICAgLi4uL25l
dC9ldGhlcm5ldC9taWNyb2NoaXAvbGFuODY1eC9NYWtlZmlsZSAgIHwgICA2ICsNCj4+ICAgLi4u
L25ldC9ldGhlcm5ldC9taWNyb2NoaXAvbGFuODY1eC9sYW44NjV4LmMgIHwgMzkxICsrKysrKysr
KysrKysrKysrKw0KPj4gICA2IGZpbGVzIGNoYW5nZWQsIDQyNCBpbnNlcnRpb25zKCspDQo+PiAg
IGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC9ldGhlcm5ldC9taWNyb2NoaXAvbGFuODY1
eC9LY29uZmlnDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC9ldGhlcm5ldC9t
aWNyb2NoaXAvbGFuODY1eC9NYWtlZmlsZQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVy
cy9uZXQvZXRoZXJuZXQvbWljcm9jaGlwL2xhbjg2NXgvbGFuODY1eC5jDQo+Pg0KPiANCj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9taWNyb2NoaXAvbGFuODY1eC9LY29uZmln
IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWljcm9jaGlwL2xhbjg2NXgvS2NvbmZpZw0KPj4gbmV3
IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uZjNkNjBkMTRlMjAyDQo+
PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9taWNyb2NoaXAv
bGFuODY1eC9LY29uZmlnDQo+PiBAQCAtMCwwICsxLDE5IEBADQo+PiArIyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQo+PiArIw0KPj4gKyMgTWljcm9jaGlwIExBTjg2NXgg
RHJpdmVyIFN1cHBvcnQNCj4+ICsjDQo+PiArDQo+PiAraWYgTkVUX1ZFTkRPUl9NSUNST0NISVAN
Cj4+ICsNCj4+ICtjb25maWcgTEFOODY1WA0KPj4gKyAgICAgdHJpc3RhdGUgIkxBTjg2NXggc3Vw
cG9ydCINCj4+ICsgICAgIGRlcGVuZHMgb24gU1BJDQo+PiArICAgICBkZXBlbmRzIG9uIE9BX1RD
Ng0KPiANCj4gU2luY2UgT0FfVEM2IGlzIGRlc2NyaWJlZCBhcyBhIGxpYnJhcnksIGl0IHdvdWxk
IG1ha2Ugc2Vuc2UgdG8gc2VsZWN0IE9BX1RDNiBoZXJlIGluc3RlYWQNCj4gb2YgZGVwZW5kaW5n
IG9uIGl0Lg0KPiBPVE9ILCB0aGF0IG1pZ2h0IGNhdXNlIHNvbWUgS2NvbmZpZyBkZXBlbmRlbmN5
IGlzc3Vlcy4uLiBJIGhhdmVuJ3QgbG9va2VkIGludG8gdGhhdC5ZZXMgdGhhdCBtYWtlcyBzZW5z
ZS4gSSB3aWxsIGNoYW5nZSBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQpCZXN0IHJlZ2FyZHMs
DQpQYXJ0aGliYW4gVg0KPiANCj4+ICsgICAgIGhlbHANCj4+ICsgICAgICAgU3VwcG9ydCBmb3Ig
dGhlIE1pY3JvY2hpcCBMQU44NjUwLzEgUmV2LkIxIE1BQ1BIWSBFdGhlcm5ldCBjaGlwLiBJdA0K
Pj4gKyAgICAgICB1c2VzIE9QRU4gQWxsaWFuY2UgMTBCQVNFLVQxeCBTZXJpYWwgSW50ZXJmYWNl
IHNwZWNpZmljYXRpb24uDQo+PiArDQo+PiArICAgICAgIFRvIGNvbXBpbGUgdGhpcyBkcml2ZXIg
YXMgYSBtb2R1bGUsIGNob29zZSBNIGhlcmUuIFRoZSBtb2R1bGUgd2lsbCBiZQ0KPj4gKyAgICAg
ICBjYWxsZWQgbGFuODY1eC4NCj4+ICsNCj4+ICtlbmRpZiAjIE5FVF9WRU5ET1JfTUlDUk9DSElQ
DQo+IA0KPiANCj4gLS0NCj4gflJhbmR5DQoNCg==

