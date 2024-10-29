Return-Path: <netdev+bounces-140196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8759B5818
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 00:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1F391F23D80
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 23:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714C420CCCD;
	Tue, 29 Oct 2024 23:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VaRuJ6Kc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6281620D4FC;
	Tue, 29 Oct 2024 23:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730246107; cv=fail; b=A/ZCj7LQM0WJDtvkxIms9HV9LIZXmrILqRLk2RCBuPE4ZEMgS6M+56wxQnF3rDfD88LyVA80gTgd1q25l6Ayf1J9B7i0GDY3ZS5YsXyMH8JsNgNoGp3IFlhiJ6L4CXw8erXcKDiXIWq8zSJC1flC3JBrXWs4zA5E99qrlfaPb40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730246107; c=relaxed/simple;
	bh=qALW2MU91/SXr8agw0p99RcjrAE21NW4Rmp2deZ+pMc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BwGH4DoTmCaDo6JuDWNayRlBtOur5cKPN1fbWA9xqLItLKJvH5csAzpauVWE3nImlx50VPaVCrBt+EPp9VUD4SMuiEEgxB8ln3IibbUA8ozdiJ4oiR7cNLMEfT5maGbxLYzizy+Fm3pV1WysBsMSXKvkwl7wp5CJf4sJ4kgsZyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VaRuJ6Kc; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730246105; x=1761782105;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qALW2MU91/SXr8agw0p99RcjrAE21NW4Rmp2deZ+pMc=;
  b=VaRuJ6Kccw6ZFQrVt5hkDaPdIf04v1FUunBQRgTTXy3yrL9bcaCLeurN
   cwJWhBgBn8Xd7rr+v08yFC4DHnPxJWkJWC0+gXF1hVasaEAL1DgxVAXU2
   CbGtCpkGiRJDadRGPZXh16D/euNpOCCV1PfxBOLF0FH3KApiO0YcbvE4I
   6F2mWzVztKhSt+yzMQe3c1lxjxeZy9yoyOtmtsKlVyb3ejyrskyRqXrsM
   v1KKJuVyutQnkMqWeuBWyo1H4uZDikBOevy6m5+8aPFzcLtPRK92z7hUj
   sVv7Rwc0aTn+4LUC4QlDBuWyVaHZAJskB7iZWjjafUrvxEIAZCFpcvXRg
   g==;
X-CSE-ConnectionGUID: /tyUdrxKRi6iqAVDtOgreQ==
X-CSE-MsgGUID: 6amygRJ5QsakZvSaAngyzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40451551"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40451551"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 16:55:04 -0700
X-CSE-ConnectionGUID: LTkmuxRGRf68MVKIUDYFdw==
X-CSE-MsgGUID: oZ6CnjXVQPWSAp+0rGi1eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="87256360"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 16:55:04 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 16:55:03 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 16:55:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 16:55:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UVVGAbBM6lfmBqMh/S6saY+DeSAdlpM+IxzgAPBx4LKK+UFbScCKWWDB1qxwQojuuAHh3E60sx04vTU9frwhWYZM3NMEqHdvv3VGmZEe3rHCEyN1vJZiGfmzcb4d3l38DrM30BZKMIsXKJxfBDd/2tHViXu3JArkD39MIuy/UjnjHRa7Q7sqt9Fu75hdg4cC1MNqiv9VTh1cdo430EVRNBH6wvZ4c5j2ltAEYcWWSPWQJjyYM5RHkYCWdablhetzjjnbDQN8NURmCUP3lTYUL+IFGZ5Ci4x+JpO/5e20SQXt395/tESe093tNXKwiPWbR4YolEBO3jqZBZKxLBuDsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/pn1+QmGFRnhW3NQb7De+lyGD1b0NVa64+/A8pRcEM=;
 b=Xz5DOtHAvRwr6v7XxGPSnPrQFAKi01wRjIFkmiypSTUzXj6wqTrdrpCqEFLvPqm0sGMD8DBZgW2/DKJPU1jX+iRt86idVZKzHIvo6r97Y6AlmJ1xZIkOTeaDqshZm/yoECVPaq7hLtEAHeLHMRkQDP+EtjH6P1CS7OPCc61eljr+fawibEMUmHdWybFxUTV5/17iRJ2DxPlKln89JHtHzGZqf8nsUJMJUxKuz18i5N/AF0ioCD65GWMyjYgVYMPEzyTX5cVu/ounL1LzwJR+jXttZDeZ4jeOyTYk5WPByQ1fIw79Ho5iXSCiSAp/eHMAwS9ZWhjpXb16y7YjjxQ/Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB6816.namprd11.prod.outlook.com (2603:10b6:a03:485::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 23:54:55 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 23:54:55 +0000
Message-ID: <b4f4eace-117f-4d55-bcf7-6718d70cbf88@intel.com>
Date: Tue, 29 Oct 2024 16:54:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: broadcom: use ethtool string helpers
To: Rosen Penev <rosenp@gmail.com>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Justin Chen <justin.chen@broadcom.com>, "Florian
 Fainelli" <florian.fainelli@broadcom.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Broadcom
 internal kernel review list" <bcm-kernel-feedback-list@broadcom.com>,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, Sudarsana Kalluru
	<skalluru@marvell.com>, Manish Chopra <manishc@marvell.com>, Doug Berger
	<opendmb@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>,
	=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, open list
	<linux-kernel@vger.kernel.org>
References: <20241023012734.766789-1-rosenp@gmail.com>
 <20241029160323.532e573c@kernel.org>
 <CAKxU2N-5rZ3vi-bgkWA5CMorKEOv6+_a0sVDUz15o8Z7+GFLvQ@mail.gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <CAKxU2N-5rZ3vi-bgkWA5CMorKEOv6+_a0sVDUz15o8Z7+GFLvQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0064.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::41) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: 8510cb39-19dc-4e45-e826-08dcf8751686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T1BIRUFsdEkwa0czcmNCTHFVUnFINEg2WE1ZWWdhVEpYNE4vM3cyRkNrbGx4?=
 =?utf-8?B?UkpmUkdOWTZKajFHOGkrWEk4YUlWYXFOd2dtYkZ2SlJUak14Zlp1cFhBdE5Y?=
 =?utf-8?B?dy9nbTV5SzFkK2dyQVd3ZXRJZ1ZGQStkVmo1RDNGbXVGOHlBZWFwY0JMWlIy?=
 =?utf-8?B?K1VXQ1lBT0lYVVJnVDh2S1l4dFZTRWlhMmwvcmtqQ01BakFoWG9md0Uxc2tw?=
 =?utf-8?B?bWN6TkNxNTlHWlBFOVcvWGJEc2NPT1EwOVRvMTlpVzVhU0wyakp4R0VpUm9E?=
 =?utf-8?B?RFRrODBIR1JrbUlUNmEzUTJGeFlvNnBwQnVpcmQwNUJ2M2MzdnhxZW5sVHZq?=
 =?utf-8?B?aG5nZGtPNDhOQjJYV0dQdmt2TGEvcitLZnZWQjVwL1AvMFFQR1Y4NVB4bTN1?=
 =?utf-8?B?ZGRzRXk1UmJ1Vk9Bd051cTM4NzN2eDBSZmpRZTlOK3pTZy80Q1plWXQyVTgr?=
 =?utf-8?B?ckdUWlBYMzRkZWJrYzJvalE1c2VWMzVBQzZaT1JNZXVJeGhvVy9VdXptc3VF?=
 =?utf-8?B?a3hYU1MvM1NrM2E4UXAzdXFDdUpZNm9zenk4WnRjWFVSQWRJSG8xTmVuejM2?=
 =?utf-8?B?MWdKYVpRMnZ3RmJiVndLdmRUZk1LcDE2aGV4NVRCUC9pL3kxamV6bDRwL2Zv?=
 =?utf-8?B?QUxRK05rc3B3LzFyR2JvYjBqdTNHelllU3kwQW9DekZQZUNDeHNVMjFhaTRt?=
 =?utf-8?B?TExOMVcyNTcwdjRFb0o3RmhXTml2MzB5bXo0WVVRaEtjbmFxZFU1SkVQWGlN?=
 =?utf-8?B?MnhoY1RpSjRhQ0NHQ1QwU2phdS9pajdZL1U4U3FESUdyWnUzWkMzSFNKT2Np?=
 =?utf-8?B?dGpiMTlTQVp1OUwxbFh0TElva25lSzd6VXk2NXRVRnp2ODV5SVlncmJEdW84?=
 =?utf-8?B?a2p0UTRXMmhsM0VGQ1pFRmdka1A5V0pUUEg2NVYwcldMakFzOElwYkF3VHhS?=
 =?utf-8?B?aXZoTVJzZTJvclFZOUpsS3NCblVVcW1kOFAvR01SeTYzSDZQaFJmTDVzMVBa?=
 =?utf-8?B?b1N6Nnc4RThZWHhPdmx6S0VKOWU0KzAwdWplSU9UVTBKZmpnTlZDVUdBUzlM?=
 =?utf-8?B?b25RdDVBS1Y0OTY0TjdwWFVQYjAwV3dpRFBQRWJTa0hMOGtSYm1sclVTdUJG?=
 =?utf-8?B?Rlk4RGhxallCOUZneXBMQVBuWkRRMmVZVFVDQWlLblZtVUxmMVF3djUrdHVU?=
 =?utf-8?B?cUVnQXZiWms1NW1yTWhUVUZZNzBTZDVNSUcwekVqeUN5M09naUtvbFhkMjQ1?=
 =?utf-8?B?U3pGY0puYktoSUJUMEJFaUxvRWYxNGVLTHcxY3lVZzFUZEtpSzJoOElacTd2?=
 =?utf-8?B?TDAwYzhHcGVTY1RMbEQxQkZxays0WWVRdE5EN2NOa0Q4azF4cTc0Z1doc0Yv?=
 =?utf-8?B?U3JzSEtOOHpOMDRMdndrUFZEVEtWc0toZDl6WmdtMm04bFJjR0lQaDUydlVF?=
 =?utf-8?B?NThlcVQ4NzRWTzZwOGNFWlJ1K2tzSGFqUkR4M2NjK29pNVk2T3F4RG8vNkxW?=
 =?utf-8?B?YUdDVnFCbWRFalFrNU9PSW96U2Q4K1JuOWduZEV1cVhHRnJyNnJsc0Y5Y0l1?=
 =?utf-8?B?ZFZ5TmZNRTF5Rk81NTJLRldTZSt4dEdDZldEVnJhdW1pWVhFTDByR1lrNnFp?=
 =?utf-8?B?alV4OE01N24vbEttNElXOVJXZFFOVFVTU21yVmFkRDFIckp4d1JHemdFTWhw?=
 =?utf-8?B?cnF6QVZmUTJKWlI4UFFlTmI1YmpGZ1VBK2hnN3dQZ01hUlZJdmRhaXFxOUE2?=
 =?utf-8?Q?H/dnxY2D7caDEBj1zeZXMeFVXkIbVlKUDxpl9H9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTNpd2hrQTNhSlVaYXUxUXBHMWQ0MXZsVVN0REIwdjltUEI4dTlLTlB4SlV3?=
 =?utf-8?B?djcybG4rc1g2MG1pY0dURlhGWnA3YU9LWjFYMzdZK1pMbERwbEk1c2lRRVJT?=
 =?utf-8?B?M3NsbUZjUHhmRm9hSmZjOW92WTZLMWhGd0ZEN0Z1VmdUbXp4MS9xNjlBQk5m?=
 =?utf-8?B?NUNmNTVEb2VIQlZVdzNLaHZYNkc3ZEFVR3BPQ0ZCbm9BZVZXN2pjYkt6NS93?=
 =?utf-8?B?QlpDVGpXRmhyK0VqcDBOc0ZDTUhzdG5ZdGJ2U1JYZ0IwMHpZYVlEVnlOalZM?=
 =?utf-8?B?THlXaC85MDNCc2JUelNzYzNjR3l2ZzVtOVZ4S0ovRmcrUm41cTZ6dDF6bHFF?=
 =?utf-8?B?NHhMTnd1T2M5K3E4RlNqN2dYc3ZYcFdMUjNYbFI2UWRqS2JVQjRicWlpT082?=
 =?utf-8?B?ZU44cTF4cm5OenNZZEpIaXQ2RVI2TTdSNmt3VTU5YWdhRDNmRDI5NVN4ZHVv?=
 =?utf-8?B?Vi95aUt2VWRDcEtTc2R0S2ZQNC8vbW02ZnB3elhaM0xFRHJ5dHJGMENETSto?=
 =?utf-8?B?VENnTCsyKzJuT1VJYis5bmxtY2hYZFdQeGxudkZGM1UyYXk0dVVNbFpwOU0z?=
 =?utf-8?B?UU1XUjVtSGJjMG9DbnNoSjBqVTJxM0RYY0NYQzNLL2kxQnF2RkJibTNjYlNP?=
 =?utf-8?B?K2dqdmZ5TEZGN1E4bUZaK3BaY2U2bFZxTHNzdVY5aWFvT3pDSEFMNnk2bjJL?=
 =?utf-8?B?Vkk2SkVCcDdHY1pCZ2VIYXcybGp6ODREbC96Vy9XM0VtUzhtU3NXR2FnMmNq?=
 =?utf-8?B?L0RDWm8rZWVYUXBXSHRxVC9NZVZSYmh2anVXRjhiY0k3c3FNMHFEVThpMWEz?=
 =?utf-8?B?cU96VGxQOXZJa3pCb1Q3aFF0VWRTR0VQWVVUQ2dndWZ4dk9nRkpFV3h4UnV2?=
 =?utf-8?B?STdOOURSNFNiYUxHWVZTWkw3RjZoNitPV0NVMy9Iaks4aUdMUnJGL2ZUQmha?=
 =?utf-8?B?cnVFK2ZtR3lQcXdMMVRyOXdNMGhhZFhmQ0pMU0JOS08raUkzVFNZK2pXYTZR?=
 =?utf-8?B?U1ZzY2trUXRlMjQ2NUhQQjd6TzFCUnhqWjYzdVBCaGgvdTN6K2F1QlZ5QzdL?=
 =?utf-8?B?Y2srSVFiOFNYSDEyb2ptNHJPV0ptTi9UU0Q3TGljR1RTbVZTMytLRnVrVTVu?=
 =?utf-8?B?REI1dWNuRjJXd3hHNGdXaEFxckkzWm5tNFlxMkZKbk1NZ2FQSXUrOXNrUFA2?=
 =?utf-8?B?RlZRMVNPa2NwQjR5VnRLWmdlb2kyczkvY0lzYWg0Y2xFZnp3OFd2V3pNZ1dF?=
 =?utf-8?B?b1FsQ3BId1RqM3QxQlh0bllYMHY1Q3pEdTlvTWR5YWF6d09DZ2MrQXE3L1VH?=
 =?utf-8?B?VWVrUmRiZmIxbTllWGxtOXVySzZtaXdkQ1R0bW0rUGFFSS9jYVpjNTFMd2ZM?=
 =?utf-8?B?alN3Y2wyM2ZBNVlIZjB5YU9yZkNlZlpyQ3ptVGxjT0hUZHo1bGRWSGxIdDhr?=
 =?utf-8?B?T0dDRzRMTGtvSlErWDhhZWwzVFEwT0ZiM2JOMmlYbExiNDM1dlB6elpvZ1pn?=
 =?utf-8?B?TmNDa3NxY3FRUkI4dVFMMHNXTGttRnhlZTU0eEI4aFpadmVRQnMxZkE1Y2xq?=
 =?utf-8?B?Uldxd2crRGtIUnpEK29GV2VJd01HeVVvU0tYcGJjOUFFMHgrV09RbmI0dDNG?=
 =?utf-8?B?OGd3dXhvOGt6b08wdzNpZCsxeU1DZFRjd01nT0xyNDJxYlRKRVltVDlEUEo3?=
 =?utf-8?B?V3lvZXJXVGpraTQ1M2hESVF4UG9wNERwK3A1S0p1NkRtY1ZvLy84OHJUOWxr?=
 =?utf-8?B?Z0ZhNHRUVDdtZ2lsbURkMG9IR1ArcnZlQUlRYWhxQzdqQitiZXA2SEsrbGEr?=
 =?utf-8?B?NFY4T0VOWm9ZOXhPamZ6d1oyRmwwaGtlVHdsME91MzBTUTV0MUE1VHdMbWpy?=
 =?utf-8?B?VS93L2dDSVBoMjJ0TGpBTk5EQ2o2T205dlFOVnBIdFBVN1J1THFoMjZXMy9I?=
 =?utf-8?B?VnF3UzBlVHJjZm55WFpkejA5OTZwYzVoZEVhckgwOVJ1MTVwV0t1THlmbkNw?=
 =?utf-8?B?Q1ZQQXg2MjJuL0dxMGg1Q2FsWDdGNmQvVnhNNnN1RVFpSG1SdUJPTjgzQ1U4?=
 =?utf-8?B?ZS8xMW1xKzRoUlp6NklaSWY1cVZNK3l5VkRzMUpBQ3lnODlBMjZqT0QxMnlW?=
 =?utf-8?B?T1d5OHl2eG5WUzUwdDNaOHZsTWkxWnVKUXUyTmN2ckN4djNGZ2s3MkZ1RE43?=
 =?utf-8?B?eVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8510cb39-19dc-4e45-e826-08dcf8751686
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 23:54:55.3572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GAyRocV+vEXptNl4Q8h4Gfz1UNuVvwo0BIEYZ6xwETnb+FMw92X9Y+jZ2nGmGFBdo++iCK3gwIblp99+NdBFv4YVd0h+3EwZgiJAKC0WeSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6816
X-OriginatorOrg: intel.com



On 10/29/2024 4:43 PM, Rosen Penev wrote:
> On Tue, Oct 29, 2024 at 4:03 PM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Tue, 22 Oct 2024 18:27:34 -0700 Rosen Penev wrote:
>>> @@ -3220,13 +3212,13 @@ static void bnx2x_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
>>>                       start = 0;
>>>               else
>>>                       start = 4;
>>> -             memcpy(buf, bnx2x_tests_str_arr + start,
>>> -                    ETH_GSTRING_LEN * BNX2X_NUM_TESTS(bp));
>>> +             for (i = start; i < BNX2X_NUM_TESTS(bp); i++)
>>> +                     ethtool_puts(&buf, bnx2x_tests_str_arr[i]);
>>
>> I don't think this is equivalent.
> What's wrong here?

I was trying to figure that out too...

I guess the memcpy does everything all at once and this does it via
iteration...?

memcpy would actually result in copying the padding between strings in
the bnx2x_tests_str_arr, while the ethtool_puts turns into strscpy which
doesn't pad the tail of the buffer with zeros?

>>
>> Also, please split bnx2x to a separate patch, the other drivers in this
>> patch IIUC are small embedded ones, the bnx2x is an "enterprise
>> product".
>> --
>> pw-bot: cr


