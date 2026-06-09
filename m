Return-Path: <netdev+bounces-296832-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y1+sBDdqJ2qRwQIAu9opvQ
	(envelope-from <netdev+bounces-296832-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 03:19:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF4B65B960
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 03:19:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=AjQ4acZu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296832-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296832-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F8D03077C81
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 01:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667872D7DC8;
	Tue,  9 Jun 2026 01:14:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107742D738A;
	Tue,  9 Jun 2026 01:14:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780967644; cv=fail; b=Lir7DUL1JMn5Q+a2gSSY/DMtQopxf9fQOyDCh3Czzo+p57En1/mte+gF+oe4L/+tQUvqnKtb60W3xdkDcRAxbbagsCqgqYZZkvpuIpFz86aV9bdzssK7GLsSc2qPJAlsfojxjUDil7tTSDgGOGjC+Jvsn8M1alqUeJB7FG0aapo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780967644; c=relaxed/simple;
	bh=s5lqGlDD0pDwUKlGb+B4OeWcRGAVzSTE7S+JkRtb6S8=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mTuRerPCNYtod0zC7vlP8rz/W4etKChcV63TRugvkKyqtPtrG/eTSaduN3sIabQLRmspvK/5I/MhFzW4Gdx0kbin2r6I/KfVPjoIcKe1BT7NmN8aB3YtJMQJ4IE+Z9ADd0ZN9uBLYDskHbUTbI6wSUEffq3W8/VpDIdBogGdAzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AjQ4acZu; arc=fail smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780967643; x=1812503643;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s5lqGlDD0pDwUKlGb+B4OeWcRGAVzSTE7S+JkRtb6S8=;
  b=AjQ4acZu/mmIZcdYsu1Y2oDgLUOk9NYt8Un5yuvpx9XIUO5cngIuy+JX
   qnr+V9PULxGhfd7im6VBriHH/9QVEyIOGq5RzpwGuGFcRFM6u43+EA61I
   /bP53QwoWSVJ7JmESFolnLtPLEhFSZF+Pg4ofcDrz+BEPpG/C/srdbISN
   SbjoKFOqQduyDWLWpNVMeuLVVXXwZk3dCw348cCEuhw/rsnuskxge8GCd
   mFt+d+gd2Az5s0Ry7F85jvYw9fC9DXdK/Lv4mI+5rVqwE9m4urWwdHsyp
   GRGpk8/Z7d/bQerqL2KIzl7LihEWrGavGNhkCmnPs/QwcKUyGl3matU7J
   w==;
X-CSE-ConnectionGUID: Dc7zyekhR4mG9ipUUTKfEQ==
X-CSE-MsgGUID: nG9C+7rfSUKORtOEEknYbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81904712"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="81904712"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 18:14:02 -0700
X-CSE-ConnectionGUID: cB9ypRPtQZ+SSc2jvUgGaA==
X-CSE-MsgGUID: NpPPpE1XT7ONeKeOYGkA7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="245804785"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 18:14:03 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 18:14:02 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 18:14:02 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.15) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 18:14:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sOs7lxwKNWXsQMaUC+/OgeOfq5+X+c5hlV6bbXW98B/6+eWYEt2IK0b5qEZLmxeXmN29xinGGa+Ptw2/zvTXA/yoS+5BIk156TTybWSCu1vbm+3A9nxHC+ylIA+Z8x2MoRMqty16s9wdSCr6qBcNyh+qIGiBICefWNT+NH1PjJ2mSUsWWUpDK+vITUz4pvpfj5zZmtnHGROIpF15WMGRKL0rHCCetbhSABBiZ9p0QmsQoYCUvBXZRtoMGBQoEXYSb7G1IEQFinCC3WdJNhHBwD8fOEl7bnZayHUnFDyygrRZhJF6N5ES8olR0tSTR14Z+E091e8Y6QH6faRsblmaDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKkAk+7jDj7GOYHz2x45TlLt3L7+jjsmik3QK1WQB9Q=;
 b=IydryCp6+/apd1+UlpX9n8f1ni7NFTlRWJgXLj15n+Sha7w/u5hL/lzsBYsN5D8+Dyf7ilouyMT4mOAWZ1p/5WixAY9bsGuX8e4PKgB2P+wiNuyEvlHlNieTH7nh7phV5juuD49kZQ+VYmtEoR30ps+8RjXbJC8QKSAeUvSxMBMrG0BY8U3BxxQaQ3Y0TdPPoDE+mVyQThlWMQZ1UW5p889vLbFWnL+4NSRGxzzFLrO6ie60H+tVV9iVyqsqv7TfITie9RsiU/EBHTOcK/MI7g0zcqukZaXnP8hLd0fhLdtjvqF9UzUT89qOaTaUgs9oT14us4c5atCzEFrXuIGhsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14)
 by BN9PR11MB5290.namprd11.prod.outlook.com (2603:10b6:408:137::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 01:13:54 +0000
Received: from CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3]) by CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 01:13:54 +0000
Message-ID: <4575ae96-2084-4f96-8260-5025fd1ea7f5@intel.com>
Date: Mon, 8 Jun 2026 18:13:55 -0700
User-Agent: Mozilla Thunderbird
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net] net: ibm: emac: mal: fix potential system hang in
 mal_remove()
To: Jakub Kicinski <kuba@kernel.org>, Rosen Penev <rosenp@gmail.com>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Jeff Garzik <jeff@garzik.org>, Roland Dreier
	<rdreier@cisco.com>, open list <linux-kernel@vger.kernel.org>
References: <20260603230821.5619-1-rosenp@gmail.com>
 <f49d5ac6-ef78-4530-a420-d94e612581aa@intel.com>
 <CAKxU2N8oh03r2-zJhbOXF0Qqx7RzNSX=zq+i6Ld1c9YXJqDfKQ@mail.gmail.com>
 <20260608173638.74da73fe@kernel.org>
Content-Language: en-US
In-Reply-To: <20260608173638.74da73fe@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0293.namprd04.prod.outlook.com
 (2603:10b6:303:89::28) To CY8PR11MB7364.namprd11.prod.outlook.com
 (2603:10b6:930:87::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7364:EE_|BN9PR11MB5290:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bf7068b-eeed-4e5e-bc2e-08dec5c45f90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 2vRTxvQ5r2puzff5A4NAFxcCAGNDOWqTvIup8hcuYfD3WtEmW8w8pEgLEuulhXtyyY01IkIlwq0H/w4jQorrEInERplFE/NbxE6YmEdznd6iArwud8nbKCupn0+wgLb9QKlBmwO710wB6jVnpaP5zGLRXIuB5H6pwiJKnmBICvsO4Oie/ihwSX1f4OxAHi5jP8WvwhvScxvTzdLBpWbTr/TN/WkR1e3UuvzFtcahYUPyrCsmFzgVQGlHL8HNbKwjwmoAGLugytKBudgfllw5ZhBRcO9PZXOnP6UWiZ/VhxJkAdCVcq0u8Hkz7DQ3sFhs038f2dED/QxHuEm2Ecg7/lgmqrXpW4KsoyJNlEet9CZQyRISJr9jrxvK/xDWK+Qa8+Bk1D6L7EeV6+fDIGpkF7VuGfSouFv1ZYlmfMfljzb/HlqUFvS62JGPFRwk6nW1z/89UkxOpVezlMndoips+Qs49PigGngHV7XuK3vqEtiJtNtx9/cp1jHUXdNnK+xbR/V4sQlfgfa8mtsl9RGTfEO3j8QaBzUjKptukGzs3CacjLg4Xhav5frvQ1atLO0QXmCrZtt2HZ8Rp7bp0dGJgbvx4Mi81b4LkhSsTZzsHh4GV8tjtNgWOyG0/t7x7YakVn+cNyJrNHSWE6Fe0+3DTey2poFc2f5pQIwhU4uasADjjMi5vpUt6PM66Y+h+YT5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7364.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0o0ckV4b2oyVi9QV2VrT2o5UGZFMEVIeVRWTXRrMERFN2VzL09Ub0dvMjNP?=
 =?utf-8?B?SGtjMFpLM1JSWGtDam5wd0M1STRiWE1mYVNZdEJaMzFHWkNPeG90Y2hjb3Rz?=
 =?utf-8?B?UnZOM1Iyd0xVdytmSUgwUXIyNlcrRkI1MlNZb21RUWhGa0t2NE1URysxcHZN?=
 =?utf-8?B?akk5NStYWjhaWTgzVEtXbG1JT1hkSERmSzAwQkxuazJwN2I4eFllZ3hBTDJj?=
 =?utf-8?B?Y0dhUVptVlQxOVJCbkd2RXFFWktIVU5pU2k5ZUFXVnk0ZzAyd0JwcVFrUXBo?=
 =?utf-8?B?V0xxbDZkUExmVjNYT080LzcwSm1uNEdIT3JPWHVEOXFCa1htTVRhQ2ZYaE5D?=
 =?utf-8?B?WTBkYy9helNBMW1UQ1hVSk5rckk4WlRiU0JnTnhUbVI3ODNBOG11QXdUd0dP?=
 =?utf-8?B?eXZhN0xsRERXUkE2ZnZ0d2RuWTh6OWJsazl2M0tFUFo4bDY1Y2FQY0xBRUxx?=
 =?utf-8?B?QVExVjFMMWF0ZUw0a1JCV2xMV2pNa0ZSMU5OcXg1Mk5LdHQ2dFRRZCtwajl0?=
 =?utf-8?B?R0hKMjRDTy9GYU9XQUtqcDNUU2N5dkdLZk5TUE9WdE1JaHUzaitYMHk4bjJB?=
 =?utf-8?B?d1VWYlRMWGU5cWFhR3hxNTl1MnIxV3o4RVVZL3ZoakQzSitKeWZETXlxV3ph?=
 =?utf-8?B?NVRJc1grMnQ5S056Y04wTFJBZ1BUYnB0NlUxVVpvV2o0SVZmeDFLVXV0UzhY?=
 =?utf-8?B?VkRjemZ0WlhIYnZJZHdORXVaYUMreTFCWkh4R1BRV241UFNHRllSbVpxY3Jj?=
 =?utf-8?B?YXF6Vm1ReUN2MUNwdWVMZlJYZUFUREljQ01qZnhWbVVXbVMxdEVCWlVFUU5D?=
 =?utf-8?B?cmZmNFNvYUE2VnlnbUdEOHVSaXhGcFVkcGdsWkRJNjFpZG5QckQ2RW0wNmJy?=
 =?utf-8?B?SG9vVHZuNFN0ekR0Z2Rhc20rdEx0TDh0NmFaQTY1bUd5TEpvVWpDTUdEa3A5?=
 =?utf-8?B?eHJiRFl2bGtGMlBqL0ZWSHBReDFzZUo3aUNsMm9JbE9OVk10WkdHRmprQXE1?=
 =?utf-8?B?cERvNmN0eVBibE5PUEJRVDZIUTR5NlVQZU5CaTV2cG1OOUlNOTMxSlplNVVp?=
 =?utf-8?B?Z2haRWJ3YktycmFkdlRBSlMyRDk0NVdqc2lhZVROVHk0ZEdyVnlRcmVVdFpQ?=
 =?utf-8?B?RHlmdENkdytOSmxkOFh3dklKMk9qajUwb1Nvcnh3dDA0bFQxUlRNOGNMckJo?=
 =?utf-8?B?UVhTL1VuRUc5NzZWcVk0VDIvSFZFNTQyNGh0NWlzamQvVjBrRXFSL3RXM3Vz?=
 =?utf-8?B?SGJXTzNzU2VCYUZQV1ZoeFFqSlUxZnc1VlNLRnZqTXRuS0V5cXN0UEtBRGZz?=
 =?utf-8?B?L3QzT01HU1RGN2MvOUpkSlFxMnVPU1Ntem0yYmdZQU1qRk5Ncksxc3JsMFJS?=
 =?utf-8?B?MzE3Wkl0K3NMZGFuT1lmZzlFR21BYUIvUTBCVXFBM1FUS1IwVHU1TjVKWEwy?=
 =?utf-8?B?eEtxUDR1U00xSExScEhDVmNBYVFmdU1QZmNQdkppZ2FEd1Z1ZFJEME53OEQ5?=
 =?utf-8?B?ZDFLR1pBZG1vMEY5OHpubDAxcmJxTkhhTER3ZGthbis5RVJMYW8xTGFNWHh4?=
 =?utf-8?B?QThhRWNxUkVYNW8xcDFVY3NPb1YrVHd1WlhYbUcxbGVoaHU2c3pEVTNlUzRM?=
 =?utf-8?B?dEREcER2V21NNmd0d3c3UjBPazA4U3BXRFp1dlYxMHRDeUJNNGxnb0FrWWFz?=
 =?utf-8?B?a2tqS1BOQ3BiamRmU1B0c1g4UzE5KzhvSGN6T3ZES29rZ0UrbzA2S1pHcE5m?=
 =?utf-8?B?MG56UGx1N2RTbTNoNlBjSmxreGY5ZVNmUGxxaWhZQXdaeWVJR3ROVTBGZWR3?=
 =?utf-8?B?b0tFakErdGx0dnEwNG02SkIrTWNWR3h3VDRhMkovam8rdmJwSVJ4WVFoMnlV?=
 =?utf-8?B?S01KRzJRK1Z6dmJBR0ExWU9aUHZIcUVrVitVV21iaUxPME5KTUFWNHRNRTFC?=
 =?utf-8?B?cTduRENEbzJvNytvRjlTSXl4TUlFTDRBUE93TVdpMCt1WGZLVzN3YUtqZFlR?=
 =?utf-8?B?U2txOTIxYWV6RUVTdU5NMkxVMmkxSnltYTdRRG5vb0tZSUJsMmFRcmdHanJt?=
 =?utf-8?B?TitpNWlWcjhDSTZwRFdrUDk1emVIOWdjdnZRaldQK2tiWlZoL1BQSmJ3QVZh?=
 =?utf-8?B?MWhqWEtjb3pnQTZGQVJ2QlZ6SCs2b0ZqUFR2aFl6djdOQStmT0laWVdobC9m?=
 =?utf-8?B?MkMwdEJIZXQ4cTB2N1YvVUwwK3k2UHNvV0Jzeng0Y0tHaC8xRWZmd0dDMVNl?=
 =?utf-8?B?U2JNdWE5M2R6RCtoVm1VendvV0ZqMWZoQXFmRzRacFVGT2VCcGNqWVBQaFNH?=
 =?utf-8?B?RnJxemZNSVpjZThDMUlCS3RCRFdQVGFlVHNBeDNjMzNtM3lPTjR6UT09?=
X-Exchange-RoutingPolicyChecked: ZZA94ZrxxAGzItt0V2KWB+ileQQPctEMxQRc+ZLACiMCy8pZI8v7Xt4pq6jGlqAL4lpfQPoaH5tfB5tUjMj2gLbcN8jsK7R7pdb+XgcOYIGIkvFibNrAywiJjHdcKBFHe4buKtz4Vmp6h2d276PYWyvg6cqYX0BjVI32dc92bdI5po+zwrLKlpUPBYzwVExzfx/Bochf3wrwpsn5ph4QLqiekFJw0j45ICleBMDewZ1dRgQyVVTlX4XO1+Hp0iGZk+wu9o8caJk2JfZbQR89m/QSJjuIUfiVLt4iGLIlTtwFMpv305smjAmk/5POr46JQHOSIJrzu6h9oRPk55jE9A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf7068b-eeed-4e5e-bc2e-08dec5c45f90
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7364.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 01:13:54.2580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I4sWu4ic+ajkRuXs5zNxMzfGhB+R1d/UXsO88TCl+t3o1fvpW/kmqnfgc5pFRZWKWjGuPLg0ihPTQPbsanQRneUsrYjlFJuoHmd6aNZyxH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5290
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296832-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:rosenp@gmail.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jeff@garzik.org,m:rdreier@cisco.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,intel.com:mid,intel.com:from_mime];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7BF4B65B960

On 6/8/2026 5:36 PM, Jakub Kicinski wrote:
> On Thu, 4 Jun 2026 16:03:43 -0700 Rosen Penev wrote:
>>>> -     if (!list_empty(&mal->list))
>>>> +     if (!list_empty(&mal->list)) {
>>>> +             napi_disable(&mal->napi);
>>>>               /* This is *very* bad */
>>>>               WARN(1, KERN_EMERG
>>>>                      "mal%d: commac list is not empty on remove!\n",
>>>>                      mal->index);  
>>>
>>> This one doesn't make sense to me. The list_empty check does a WARN()
>>> indicating that this is not supposed to happen.
>>>
>>> This implies that list_empty should be true, otherwise we'd see a WARN
>>> every time mal_remove is called.
>>>
>>> But in that case, we'd have been calling napi_disable incorrectly in
>>> most cases where it was previously unsafe according to your claim.
>>>
>>> At best, this list_empty check is the wrong way to tell if the napi is
>>> disabled, at worst, this whole change is pointless.  
>> I asked the AI. It doesn't agree:
> 
> FTR I agree with Jake, the patch seems to indicate bigger structural
> issues. Then again I don't want to encourage the stream of patches
> to this driver so let me just apply this..

I don't see how applying this discourages the stream of patches?
Wouldn't that be encouraging?

Or I guess the patch "does" fix something (an extra call to
napi_disable) and you don't want to encourage a raff of future changes
to try and fix the overall structural issues? I guess that makes sense.

I still don't follow how this fixes

