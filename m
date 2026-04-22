Return-Path: <netdev+bounces-280473-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0InMC37z6GkdRwIAu9opvQ
	(envelope-from <netdev+bounces-280473-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:12:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C9144851C
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C1A6302D0A6
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2DC2FD665;
	Wed, 22 Apr 2026 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k+QOIxo+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E8C3264F7;
	Wed, 22 Apr 2026 16:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874217; cv=fail; b=CGXmljL3cX056tcSMNqOBTGwqXBlIpFkFxdpUoPmFSVvJo9acBNQW53Vs7L5H2qmeY6dG4TRLvJk7KPqecMzm99ESYBhdValKday4ob+FhvVVg87+I5JskD9s4t4Zzt+owNWwWlT7IClw6lmEq8CnL7hpB11N/QFoXKhxn8wS8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874217; c=relaxed/simple;
	bh=3g3GcEhvP2b5Px7zfmBbWGStZEJr2TakZK5JVg1tUkU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l50Bay98TTfmrZuCxpl7OnvaheU/z6Y5M6dvBDyG9I5jKeyP0+Vgr2ybcvS/WkPHB/oe6xxUBTKyMpzmNZrh3nC8a5IaCIaAn3hHXfTwmc+XaAi6opw8ywrTWkYqdVKuAKfRQ0k0BrB992xCAGJTaEHrM160gwwd3+w45g7qQdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k+QOIxo+; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776874216; x=1808410216;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3g3GcEhvP2b5Px7zfmBbWGStZEJr2TakZK5JVg1tUkU=;
  b=k+QOIxo+oO75reWHEYg/pvWrXEtjrqo5mqEw9tjN7cGwTvH+4g8ybaZW
   n2o2qpSRsa+WJVCAAdX9uZ7QfHoEELwZQuiVJgnBE3GXTIw0nHwAtQ+HE
   XtkXK1KxpJx1o3JVhDEJffUS/yswU5yDdmcVL+aEB46S1l2BhIi75xZqM
   /BdFNlN3pk9W/q2/EotU6Tt+C6AgV3UEL/DYwrdz8iGyPZjTOqw2/xv1+
   VSI1ePktcCaDLkOmaPSdlnJDBQTvHF0pPu5d5nVD+ZfGe9xNnP/QV+HDE
   /m84+siyQ0ZcM45iYncPZcy69L1zL/EzUpq9uQfkrEBJ5R5SR0tOmJfES
   A==;
X-CSE-ConnectionGUID: CrVYriBdQ/WYltBMyU8rFA==
X-CSE-MsgGUID: hyscmmQfShOPL6ZTy28Qag==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="103292661"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="103292661"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 09:10:15 -0700
X-CSE-ConnectionGUID: 5hqJZdpySjOPj75xYhSw+g==
X-CSE-MsgGUID: mfo8qKj0QnOUBvMbaI4JwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="231357863"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 09:10:14 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 09:10:13 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 22 Apr 2026 09:10:13 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.64) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 09:10:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fm2JgIFtJNSJsjh1rC2+WWZKOLmcAG30xNwZOrsbsisR76jO26n6A0tvQBrnONGh9QT8pnUSoheSH8Q+mulE8kuct4EqBSms3/TPEgY1+vsOH4RH6q1PGG9KCfOF25Ma1ugBXYIgH9lJp977XSALeJkBYl1R/nBcjaLaehpbr0hIipVJWpkdWMi/PzyyNVEJc4ANkAbi15OWUF+0wu1h9ZHVmDflQB2qBqa2cVcB6yu+UOIUJMfFb7vyUAyeu/81j2jdeSawJMGvbsX275zed7ekyXs29mAMbNwRbs9kTKSK39f2wsg3SUoNYKEooHq9R/ZmZO2XdqMUOL82O8W79g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Da6o1mS9uO938ltxkSExaMk3gL+AfCogfstCQL49TMA=;
 b=BXWmMlLAo1jy+avndPZKXDiwh1DonZp6dcLUgWnVYCrWQLk56rrPdES0sm2NBPWybd31+/gZQ/YHYrxM3XVKXeHL2UDcd5YIO/6afMk9rMIIuicS22doCElnB/6Vi/zEX4O+PxbxIUOhBtM+FMKYZmp49W0Id+9Hy+NkvHRirzbR2v3EkbBXZnA9NCXyK9HpsP2ZgI1N5pBLp2gqvVf8wk9oHs1a/j2JwZUwDZNmIe1sVp4svpeUFg4g89AJNz/iQYBL4Z0L05OaTYZv0D57o5WeZxCdKRgdYDDAsKcuMm/SC8HeZqdqstiHiFM60IMs3LoO4m/AEcpt29R6TP8lrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8722.namprd11.prod.outlook.com (2603:10b6:408:207::12)
 by SJ2PR11MB8371.namprd11.prod.outlook.com (2603:10b6:a03:543::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Wed, 22 Apr
 2026 16:10:08 +0000
Received: from LV8PR11MB8722.namprd11.prod.outlook.com
 ([fe80::b10:6045:9014:a81c]) by LV8PR11MB8722.namprd11.prod.outlook.com
 ([fe80::b10:6045:9014:a81c%5]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 16:10:07 +0000
Message-ID: <2e0e0e18-cb75-4638-9a12-5906de6a8308@intel.com>
Date: Wed, 22 Apr 2026 18:09:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 8/8] xsk: don't support AF_XDP on 32-bit
 architectures
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<maciej.fijalkowski@intel.com>, <jonathan.lemon@gmail.com>,
	<sdf@fomichev.me>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
References: <20260422033650.68457-1-kerneljasonxing@gmail.com>
 <20260422033650.68457-9-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260422033650.68457-9-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::10) To LV8PR11MB8722.namprd11.prod.outlook.com
 (2603:10b6:408:207::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8722:EE_|SJ2PR11MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: d7981461-4de0-4df0-bf49-08dea0899ee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: r1r/DWhtwDZkyDRh9D8V/MvZjqG8L0sFk5P3rRBfWZcVSuaR9ACig/gw778/w5I1KFr8D78e/eUU8OaQmYcTm3SW8b7kyqIC+Q79Ui10IMVhKoILOoq1cmL+MwYeWZItpgOFvRsd+BDMIJn7vYSTfhgKrJXDfcm+5UQailBMG22fe+CCCuvKIHF+llC9iLu/TZq9YwQ6WVkrFfwxtuP4BAh+vXV6QATtbHbOzROHEjUZiGog+85zvqvz5W4BRy9dB7xC7pJIayqw0Zx6aOwJ+ScVxYv1te6kK0sPB6UlMHsX1HCriMV03shDQfQ6qYDU98X6fuMTXSTvWIdQ8JTQayaZ2x19Yyg5iyUz7/F+PiOH2kFmmajcSox3KZJWGoppQJzwEkKRzpZ8BFFOfkZMK2piwmlGdWOJEyEhVxea2xULUQDyvdwpzf6D7jrusKjLvBgqbDI0GNyJbgtw7RXdp2crleXrOGXRJgmUr9yaTyKCuIxZGpGwOtPGpsQIsp7i0wqLxXk7Ck9wtE4iCw5ZxaARfjEPonfjvthNtmuVYL48kYgFWI4ZtpKAQXpggOqOVeWAbTKlGF0hINtq9KdDIWjTyTDDDtyMsEPfVmlgVyik/6ayxL/VURB7Q59IEkD6285u+m7d3i2S88XJu7swInD+tAsRRg/R7N0yPnxSx82kWFizTVL9HTjmOIqvnkh9+iJeYXwbSGSelcWiFxrCCnAjXM5hDmG1n9lEolVctCHQa0PLJCASwf+9tUzYi5dt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8722.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3cwdkpLK3lUcXorUTZCN0NlMXVVTjd5WDF5RkVTNzliZGo4empBN3pRaDVs?=
 =?utf-8?B?d1NOdGxvU3ZDTmhselVjdnBVeW1HRnpjNmVjQUc3bGVtL3ZXVDdoWkFhZjBK?=
 =?utf-8?B?Q0hHZEhhNlhSQ2RFWTdJM0dNbmM2SzNoN0FrdHQzdW8vUTlWRkJRdE1TeElG?=
 =?utf-8?B?S0xwVEpRSkFZc2xjMkV4dTZ0YW9za0J1QnhTdWREVlpVTDcwcXB2blJGZUVF?=
 =?utf-8?B?NytMMjRmTU0zU0tscElxSjNsb21uVGZBZit1V2sycHdTRVc2RU80eS9aS1ZU?=
 =?utf-8?B?Tlp2dVdGSUFRSWpFVFllYzFmbVVObEQwSjdhTFAvN1dmcC9rWDZySjNFOXV5?=
 =?utf-8?B?UTFnSklLbEJ5aTJEL2owVEJPUUtsYlJCSGoyMTZ0ZUU1dFIvczBvaGNqbERC?=
 =?utf-8?B?SVBwUENvaVp2ZGdCMmpxZERWd3Vyd0JxSlJURk9qblYrdi9HNHFpY2xDLzZM?=
 =?utf-8?B?eW9NeVZjRGgwTE50TDhEcXh5cWxBeC9EbEtzOUdqQ25jM3Z1S3p1QTBiUmVr?=
 =?utf-8?B?SVAvK2JPZlJwdlhrZGRhKzF5TlAzWlphd0tFNlFmUkpmODVVd1hxdEpwM2ZG?=
 =?utf-8?B?V1RQQXZLQ29CNlU1RlR3SjhRUTBOYTRhYjN5VHNQRFJnUWFiTWRPRDIwZ2xh?=
 =?utf-8?B?eHl6RDFYTWVCa2h2S1Bid21temIvUStVbjg5SjZqcFFVSVY1RzdHcjJaSHVO?=
 =?utf-8?B?aUJQRU9Lek8yVCtleGtHMTc2SFRYQjVIbzlUdHNsMFBabEIxU1E1R0hscUtx?=
 =?utf-8?B?Tm5NR0lrU2d1TUR1bWo1bFZLSDB5dzRSSnMrS1c1UTdBc0E4cXdpajVQYlls?=
 =?utf-8?B?U1VqY05JRFBROUpubkNpZE1naExjVlZkQlpxUHExdGVNWFlyQ3dJUnVxVHBZ?=
 =?utf-8?B?SEZMUUw2OGVDUWxVWmJSdExuWUpDc2hLbHVPLy82M2R3bWV4aThmd0s4V0dM?=
 =?utf-8?B?eG5ORlVEbXZhN2xBQmlNUUFYUkJMaGg1U0o5Y2tQT0xvdyt3Mzl0d0huT3lj?=
 =?utf-8?B?cjdaNWFlWEJvcTh2cHBnYS8yVVlMU1ptNWJDTWFUbEhweEI2NjRuMFN1dC9i?=
 =?utf-8?B?aG5Mc2NRYmxwZjROTGhLSzg3anRrWEtqWlloM1ZFZ1NyRlcxb2k5WFZPanRK?=
 =?utf-8?B?V3d1YXBmRHlCemxRTm1YNDZ4S0pZWnhsUUYrUVdvUWdzQUR2NG0wTXppSlZo?=
 =?utf-8?B?NjhxemJhNjcxMDUwQXFIWWczRVR2NExQZ3VYVy9zZnJNL0pjZENZdUJOU0VQ?=
 =?utf-8?B?a01la0RTY1FyTmN2TWpLQmpMYSsvTytiNzN2ZVZCVHI4YXhEZmMxK0RCN2ZM?=
 =?utf-8?B?enRJSEU1UGQrY1kwakFhK0tScjRjVXh6TThERnpDQ2ptZzBMdUxLczFoejRx?=
 =?utf-8?B?RC9NZzE5OTFLK0lGMTRKUzZHVXVNYnZabnFLZHpMS2k0ZlpBRldFbW9Tcml4?=
 =?utf-8?B?eTE0a0JRaC9ZVC9FdmNPK2tiV0FGYk1iR2Nrb3RQNUFDTWhyaVgxRlBNREsy?=
 =?utf-8?B?WW9KRFpaSmI4dytBN2lNU2dmMm5GK1hlc3gwblV2dVY1VndWeTFmQWNBTEVQ?=
 =?utf-8?B?QVJvQWtxUndzSGU5RjYwT3ZFL01KZnJaLzI0em5nZHpkTXh0Z2FXZGsrSU05?=
 =?utf-8?B?dURxU2hWSkp6ZUdXbnkzd3NnK3pNYkM3TGdGQXNkRzF5Y3R5OXhCa3RBVE1B?=
 =?utf-8?B?dmJ0ZFovRVl2MjBxRjl6bFdlb01VcFcwL3MvdWNRVENTVDZrQS8wc3YxOEJG?=
 =?utf-8?B?bTJUeGp4MjlmMkVpNTBkS2Frc0MrV016eUM0dUpZc1lUS3pGV1pKV3dvN0ls?=
 =?utf-8?B?Z1pSdW9uSXNFTGhocUg3Sy9BeCtjRFRZaW5zWkRrSHEvZ3VLV2VmQnJ2V09j?=
 =?utf-8?B?QWQ3SjIrRXkvT0d3OHVhdmtKa3IreUxUY2t3QnNuc1hOV2dDbUNwbXd3dXJl?=
 =?utf-8?B?eWRVU2pzbEpaSTl0UGNRM2hiT2xFdTNJSzFzTG5kRjNmSTNnaWVRUE1zQ3RY?=
 =?utf-8?B?QnBIZnRsNDlCZUNtUzNuQWwzR3ZwU1JoQ3FoSzZ5enFMNTMzcGZVdU5VNzZH?=
 =?utf-8?B?OXNjcTMxektoZmNRZ0VMSXVyM3RCY3dTd0hyR3E3YiswUnJQUTZKZFRJUFAz?=
 =?utf-8?B?Mk52V2lzVERsKzc1WWNpYU5PK0toU09wdkJ0b0RvSUhCcFVYMzZybnh0UDND?=
 =?utf-8?B?dlkycUNxYXpWeitqdG5JbUk1VHpDZ04rbXd2MDd4aXNaaENpWllDcUI0QWZR?=
 =?utf-8?B?TU1IZlViVHI2T1pyMDY5d2lMOGprQ2lZdHhSWnBhVEFwQzRQVVk1Nmt0NjFr?=
 =?utf-8?B?aXpyRWRsUW9aQnVpaUhHSkpDMDBLaVoxSjR4eFBNcjVyWkszNVUydUIyaFlq?=
 =?utf-8?Q?HBkaW5hnIkkwBQiE=3D?=
X-Exchange-RoutingPolicyChecked: gVU24oERNjRl+T7N5Uxrm1NjQYSgpERccfjxsh77Y9VtjV1j8GkTtolw/TQbtFg71uJFckIt3k9bxoNd6uq1WMDgouuOT4taoT5R7DfodYysmbFB4emnteRt4NM3ZnZIscYfp7rFooB8qO1tcuu6s57KFpBIoy+DyJXPJZat2ZJfsFavujDer2h5NSIqaVS6F8EutriSOUMar2kZg9+LDQTcSeQrVTfivqafK9ic8OixtA44Q5+ZmadL+56c2SqBn2I/RQB6vfrinPkAADhQuJ/u9NjY09ofYusKGjIwxRl+aNZRpBNqFLsxc7Hh8YfaXue5aVmbFfFGz2Gwf2uvPg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d7981461-4de0-4df0-bf49-08dea0899ee1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 16:10:07.3403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDRJdU/88m3Sa/XMdqXKD6i+40O/kYkKBgkB9jw4cZXiGCzFMqRMgcyflhpt6f+Ft27aKN/oFSt1FERsLd5FY2Ee0Nsp1lyteuuDzZAPB8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8371
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280473-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid,tencent.com:email];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,vger.kernel.org,tencent.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: D0C9144851C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 22 Apr 2026 11:36:50 +0800

> From: Jason Xing <kernelxing@tencent.com>
> 
> In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bit
> descriptor address into skb_shinfo(skb)->destructor_arg (void *) via a
> uintptr_t cast:
> 
>     skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
> 
> On 32-bit architectures uintptr_t is 32 bits, so the upper 32 bits of
> the descriptor address are silently dropped. In XDP_ZEROCOPY unaligned
> mode the chunk offset is encoded in bits 48-63 of the descriptor
> address (XSK_UNALIGNED_BUF_OFFSET_SHIFT = 48), meaning the offset is
> lost entirely. The completion queue then returns a truncated address to
> userspace, making buffer recycling impossible.

What if we relax the restriction a bit? For example, refuse to configure
an XSk socket in unaligned mode if on a 32-bit arch? Or add a check
under CONFIG_32_BIT like it was done in Page Pool:

skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);

#ifdef CONFIG_32BIT
if (((uintptr_t)skb_shinfo(skb)->destructor_arg) & ~0x1UL) != addr)
	// WARN_ONCE or whatever + error path
#endif

I never used XSk on a 32-bit arch, but back when I was working on 32-bit
MIPS 1G routers, I wanted to add native XSk support to the Eth driver.
Sure, just for fun, now that we have cheap AArch64 and other 64-bit
embedded chips, 32-bit embedded networking SoCs are almost dead, but
OTOH, as you can see, other subsystems like PP still try to support 32 bit.
Especially given that this issue applies to only to the skb XSk path,
not native in-driver implementations.

> 
> Since we hear no one is using AF_XDP on 32-bit arch, we decided to
> strictly stop supporting it at compile time.
> 
> Closes: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp.kernel.org/
> Fixes: 0ebc27a4c67d ("xsk: avoid data corruption on cq descriptor number")
> Suggested-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/xdp/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/xdp/Kconfig b/net/xdp/Kconfig
> index 71af2febe72a..819aa5795f50 100644
> --- a/net/xdp/Kconfig
> +++ b/net/xdp/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config XDP_SOCKETS
>  	bool "XDP sockets"
> -	depends on BPF_SYSCALL
> +	depends on BPF_SYSCALL && 64BIT
>  	default n
>  	help
>  	  XDP sockets allows a channel between XDP programs and

Thanks,
Olek

