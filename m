Return-Path: <netdev+bounces-254483-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPTlAxCJemkE7gEAu9opvQ
	(envelope-from <netdev+bounces-254483-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 23:09:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC45FA9691
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 23:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 292703020D7A
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77C0342528;
	Wed, 28 Jan 2026 22:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W1B4EYTq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D7F2D6E75;
	Wed, 28 Jan 2026 22:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769638136; cv=fail; b=RiBb167q0j+WFRwx8OspOKUrYfq5AdZEJfxSWSraUaCNNJiezzO017hI1wW1spOB8rHEkAKECoDper6djg4FoLo/JYjFSJ01du3JFpU9LG/oYsSp2wbKmf1PzTAgnZQzb1DzcLf5Mg+5i9bQDC2spHUKxPrqLtYHswjYbuSdvC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769638136; c=relaxed/simple;
	bh=8wGAvdtC3MyoD2/aKnb7gz9dL/XitCua8FZSiF3OyJ8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B17HYMDKdRFqCphc16nF8lucX6j49kc31TTkQfFT+Pa+RvFQo7Ks+IvM0tApiIfwkoB4iABEuQsuiaSobAGRGJ7LeKJ//rs2uAnyTir4Nz9mF1m0NUbeTHYyzYYeJhPvYwrX4JDrFkDigj4ansaUYq4fGjW/QTFdiHyoGHRoXQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W1B4EYTq; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769638135; x=1801174135;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8wGAvdtC3MyoD2/aKnb7gz9dL/XitCua8FZSiF3OyJ8=;
  b=W1B4EYTqQZAO8RJixgQiK6h+0kxG69Eudkyx4dITO+TTP8F9q9tJrJ41
   qwd08SpwZ/rxNWnjDug9FvnaWZNHjt14w+e60x3Kdf0UIQtUO7tn8GBW+
   ZNQXKSuvLrMZXV8EGB882953HxKmDLaKBEonCYHFf9N89Hyn2cyiPjM10
   stcxvIOR8m8D2LASoX38TUefmkxYIEifjKdkpYfDsFOHrdihX5iaYXxB0
   wAGYdY4UghK0KoyC7PxOrtzl3yh6wgSURot+9N3SaczPUEKoGQNr2OLKf
   TGhZcuf4/pJ5yPwBM42pX7720yoZ47uo9jx87cWog7MNROGOsQ9xTCyWS
   Q==;
X-CSE-ConnectionGUID: eUACHQ+gQ1moKuaTR0uNIA==
X-CSE-MsgGUID: Ujy8o89TQ7aKg5kqLD9AQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="70062855"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="70062855"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 14:08:55 -0800
X-CSE-ConnectionGUID: Gn8FN9zyRdisaZzFU9RPHQ==
X-CSE-MsgGUID: rI7uF24cQ6iQ3ew7qe98uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="213355175"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 14:08:55 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 14:08:53 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 28 Jan 2026 14:08:53 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.54)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 14:08:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJ4uo+iK3h4kXUUdz0xO7U8iepTgP/gfGNaib8q6XGTZjTQIemTV0OB09zJP03PKJxswLjbbUMTeiwjpOFoYSU7BcpxggwJ3dcSH4ojeNd0hJnMi1bA95UnOnyeuFWxWwOPDjFb55QTOC7z9tJnMstNoqJEJOmHiZ+wn9Pr/TkFZQ2107w2T5w0MkxulFprMzZGHnTzPKuCenAz7LpY9Rn8BWU7ScJjn6p4Y9HM+24h/JxgYOSbdUknSOPWuIArZiBZzGraS97qZ8FNoX34QFNOamSbfQ5hscLXfns/wcdTVpuegPEQHLd8VlIEclXvrouW14l/w7xWfRBvEEW45Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08mgTEjYrNUMMoyF/8NDAHgCcJUlSRjo+S02XCghXus=;
 b=CpYJZzCpKpd9YotuyXn0PPWVId9QFkZaXJ4qt4h3ttZAv/5gOmtJ01EOgfotSvlJ79LYNzaGPl55PsCepqEdK7MwVFM5Df9I6W5O518blF0own1GAM5QoqSlbhvFPDKSRHXr2CWBIb7dlbmpA9L1pC1cb3AHtvyt3AFNwAA8yJAnc1FWlDbcw9we803GgSFMzCzCvnmt/PsIbX/1eAnSQ8bOYkQO03v1MK7cyLYlv3STqN2LoR9zNFn289uSUJEPI4xZU0UT7Z6wCQM35obwvX5tj1K+ESS5AvUHzL0sy8qbN7U05UZ+8sUrd/gP6HZs3drIvISoFoyyTxwSb84r2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH3PPF8C0509479.namprd11.prod.outlook.com (2603:10b6:518:1::d37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 22:08:51 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 22:08:51 +0000
Message-ID: <09681668-57ca-4294-afa8-95af7eebe630@intel.com>
Date: Wed, 28 Jan 2026 14:08:50 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/25] kernel-doc: make it parse new functions and
 structs
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>,
	Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jakub Kicinski
	<kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>, <bpf@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Randy Dunlap
	<rdunlap@infradead.org>, Shuah Khan <skhan@linuxfoundation.org>, "Stanislav
 Fomichev" <sdf@fomichev.me>
References: <cover.1769617841.git.mchehab+huawei@kernel.org>
 <87ecn97ild.fsf@trenco.lwn.net>
 <fced629d-2470-4673-ab0b-80de11f0e4c5@intel.com>
 <20260128230045.781937b5@foz.lan>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260128230045.781937b5@foz.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0261.namprd03.prod.outlook.com
 (2603:10b6:303:b4::26) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH3PPF8C0509479:EE_
X-MS-Office365-Filtering-Correlation-Id: e0560c78-9060-412d-db4b-08de5eb9d1e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TDMxb28xMGxyZGdtaFNKMGk3TXFOWUdjOHhUOTZkUmlUN3I0NUVEZVVTc2tx?=
 =?utf-8?B?M0ZnbzhpVmczbTF5ZS9pMmplbTZLV1J5QmxMaDREdk8wRmd4MEJDTXI0a3pi?=
 =?utf-8?B?eWl1aXJwRzJoTTE5NitSRnlJVkhEYUxCUnlLay81RUNSN1d0VS9DZ1ljVnJt?=
 =?utf-8?B?WEdaalE5NlV0TlcrK0xna05ZWE96WVNiYUdkdnVOdXpMbXl3bXlET3htaG8v?=
 =?utf-8?B?ZFlKTXJSVHRpWVhYM1lxNWYzV2p5V3VZVEtnak5ockZlU0xqTGJxY1dNaVpj?=
 =?utf-8?B?RHZsb1FkM3Q3Y2NWYTZ2WXgrcnVpOURuQUo2Q28ySHluQkVheFIxOUxyYlFV?=
 =?utf-8?B?V1loaUZWd00yU2ttbTc0b0M5NTN4RExQV20vVTNuSUhOdWNWQkxLKzlTdDZY?=
 =?utf-8?B?VldONUw0Vys5VHZNdHlwMG9Db1JwLzRtaXpvdWtKcTJxKzFnSkJaOFZXZStU?=
 =?utf-8?B?NEtWVE5YMDFrUFpkRytibjZYM2NVRFJUWG5Gc1VFbkR0MkV6WVBZZHBTUDJx?=
 =?utf-8?B?VHp1RGIxZFBEc0dnR1ZWamd1NExDRjN0enNCbWVYTFhRdlVtVm5iU0hNUFJN?=
 =?utf-8?B?YnVXczZvWGpUZ1RFdlFGS3UyTFpLVGRuUjJaVDhkbmlYMTZyaXlMejdhUW9I?=
 =?utf-8?B?UHhsR01LazNFT25rRW40ejhKYUY3RnUxam8xUkdha0poR3BYdU41K0tORUlS?=
 =?utf-8?B?aHphRHdoYk1RaVhzeFFWYnBzMTgvSGFTS1ZrS2s1MXFaZk03YXVZN0FzbEZt?=
 =?utf-8?B?NHVqNFhVQ2FORVNEdXRrQjNMK1FpdC9ZYmxkakpRR1JYY0RPVGV0b29OSG04?=
 =?utf-8?B?NlRaNzJxWDJ4eXRWbEV3MGhwTWs2WVpVSTlFRktuMTB4a0Z6NnhZeWFFUzAx?=
 =?utf-8?B?WDdlNExtWlVqY3VmTTVUYzR2MU9aTGlhOEREc25la2lCQ05kK08rNjVOMW81?=
 =?utf-8?B?MUdTOCtxeHphbVBuYk85MzliOVFhd0t4anRUSkxjOXJLbXEzRzRGQTVnZThq?=
 =?utf-8?B?anRrVU93RzlLUmxtWE9FSHpKUFh3Mm81NitxcTZxa3FxS24zamVLZmZiQ2lP?=
 =?utf-8?B?eFpkZm5mVU5oZktBY3VpN05sS3dkamxKVGtaSnNJNXNHOHBVZXVPTkt3Qlhi?=
 =?utf-8?B?NXkwcnhOZjBGeFRXUGJ2dWZZK0lJa0JWS010RGFiL0UzKysraHh4SlViaVBB?=
 =?utf-8?B?UCtIVThHTEhUcHBKNmtIcHJHU3dOd0VuZ0dhS1FQbmNSaTQzbUttbGxNT0Zi?=
 =?utf-8?B?SFZBWDh5c05CcWF0QmZ1eTBPWCs1L0ZhVi9vWDArOThIakt0ZUxLYkRTV08r?=
 =?utf-8?B?N2tpNkpSWkpGcUN0QTZ5UTRFU2RLanZzM1ZxVEZvWTVpNjNzRlJqMFpPQnVL?=
 =?utf-8?B?VG41Nkk4czBJUUk4R0dUMFV5RmtTa3BGR2NJME5NMGg4bHhaaWpxVlpjOUNx?=
 =?utf-8?B?RGVFZ2xQTnBWV3RtUXJhMjhPSkJuUkxWK1RwTmovRmt3dFB6Ky9PSmVwYWdy?=
 =?utf-8?B?OEh1ZS9QazdaaXU2bUd6SVlDeVM3TjJMYzNjUVVRbmtMN3laRmRFNFh6UTdR?=
 =?utf-8?B?N1FnN2xqem1kbzVhQ3dJZnZqc3IxT3E1U203U2RjeitXbHBneDl6Umtici9Z?=
 =?utf-8?B?SzltM1kxVlEzY2xxbTVIc1ZTSmxIL0xoQnRtajBxdlFObFhMSVdDQ2JzOVRj?=
 =?utf-8?B?OEpWK3FsUU00dzJpMmhpS2h3WElIKzllSUJBVkloVFdqazB1S1UzQW5RVDFQ?=
 =?utf-8?B?NkJQM1c1UXZrMXRFaFNDenJWTzRnR3RtU20ybDB4TDRmTkpvbWdGREFiVkZ0?=
 =?utf-8?B?akMvUExoREZzSVVLeDllL21ibzZYSzhkM3lzU3NZd2xVbGgrSExWYjlETnFV?=
 =?utf-8?B?eDY5NzFuc2JRM1NwVDdKUjBTOThLekVhVS81Y2ptaVFsZXJjT21pRC9EalNQ?=
 =?utf-8?B?OW5YdzdtU0xQZ2JMRUVPZnVVWE55TUJPVU9LQncrSCs1MS9RQ2dDNVN1b1dV?=
 =?utf-8?B?WHM1S2lUc1llVHdydjFVclhSUEtqN2NhTzdmOTdaeXlzL3c0ZUgvL2w4aXJv?=
 =?utf-8?B?ZEU0MDQ2YThCK2RBN2c4eGtiZnlVU3VvYTZNNUU4WWVwOSswRE8wSFdDcktF?=
 =?utf-8?Q?tvCc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjNKbDFwUzdYOG1SWDhUZGo4cEluc0VsUWphMDB5WnlyN3JKTjZjS2dVVEYv?=
 =?utf-8?B?VVR2RVN5ekJEQWptMm4yeVNTcExmTVcxSGJZSFM5RHl0VDllSUtJak9JWnNN?=
 =?utf-8?B?NFBGL2o3d2pReWtIQXpQTEJRdTN6L05zQ0xXLzBTaEpzRlRYYXpReklkU2RP?=
 =?utf-8?B?R1FhZnFoM0VTK1ZsaU13c0d1UE9xN254Nk5RcHViUlIrNWtjZmRTSG9YazFm?=
 =?utf-8?B?TG92b2czbWRFdkJILzBIdjFIYTM3RG5TMFN0REk0SkltTUc5VG9keWllODNR?=
 =?utf-8?B?ci9uUGcwOVloZlV3WjlIVTYvRkFKU0JlVis5RHdBTk93bHViOVNUZ0N6bVFI?=
 =?utf-8?B?cE5tOFVRYzVMbkN6bXNKNEJSSVVPNUdMdFYxS3J3OHZkQmtwNzlhZTlPRUdW?=
 =?utf-8?B?YVJMbnpqNlJZNjc3RHYvbUJ6dENzWW9ndGhoYnFKREd6TjlOellRVlU3K05x?=
 =?utf-8?B?c1dkSGIyZ1ZjWk9SMXVqaXYxOVluanRFRE9lUmZjNG52OGRHVzNFbWQwTWV3?=
 =?utf-8?B?NHdLa3RSNE01M3d5dGc3ZWtIdDdxSy8ya1FXODhzU1hNQkxkUTBZc2Z4eC9T?=
 =?utf-8?B?NEZlam1BSmRycGNPNzlTVVB0ejQ5d1ZqcC91dEp2dmx5VnhzZnNLaWh2UHp5?=
 =?utf-8?B?S3dNTWhPUCtpUW5wRUxSWmtDYlFsUjRNYmx3di9LZXhSRDQ5dDl6ZW04Z3Ir?=
 =?utf-8?B?SE40eStKSHpqRmYzb2k2dFd4b0VDKzE0Y0hDYStPcWo5WE5KdmwxMVBkS3pY?=
 =?utf-8?B?LzNBWHJnMGZCNzI3eS9BRXM2RTdTYlBIS3E0UWNXMkRqVUVkLzJ1aklhdWpY?=
 =?utf-8?B?Sm9JL0U1N0xjcGx0elpveExXRlNTTzEyQUFEdk9tYUlqVEtDdjN4TGNYYzFu?=
 =?utf-8?B?NXE5TnkyaGdLQjZCMkk0ZjJzN3JVYXJnUWxKZ0RrcFNTQU9UVisxejdncGdJ?=
 =?utf-8?B?TjNEWDZuSVMrRkl5SzRpUmpNcmZNbDlycEMyeDhQRXBXVjVuZlJicEh0dW1J?=
 =?utf-8?B?clBMSm5wQTlsek9lVjRwaVhVRmV6SUtQNk9MKzhYNmNOMnBEKzAwb2xyUDkz?=
 =?utf-8?B?Umg4S1JxaVlLTkZoM3M3MG45SHp5bDltWXRleEVXOG9LZzlpaGJla0MxSWxr?=
 =?utf-8?B?dHdBYktkdzl1QVpUYjg5ZHpJMUE3bzFTVmNnMmFESit3UkFNcENUSGxoQnpv?=
 =?utf-8?B?MzFzbGlBVmExYmZIVVRHYVcvN0txSnV0ZHZrZjhrMlM0S2ZDcW5RK2l4Wnpj?=
 =?utf-8?B?UlFCMUptdzJsUzlaWXBYVCtvTXJUZWNEd05GdmhhYndOTmxHUDV6SHlVMlNP?=
 =?utf-8?B?UGZZWGp6UmNEb1cwL2drekd2OTZKSHdldHdBV2JHUG82eUdmSEdEZitBMjRH?=
 =?utf-8?B?dHZuRFdSRU5zSzg1Qk5iUVFoK0NwR0RPa0R6RjNQekZWYzdRTGV3eDVBQjMz?=
 =?utf-8?B?MGRMdEpSOFRYNTRSRHZ3Ny93dlI0ZXpnbHFvRHFheFlwVXFWYVMydFpuc290?=
 =?utf-8?B?T09oU3VxeStPTThTeE51NHIyNWcyWUREYjNqUmwzQTdEaHlNU29KSHh4Ny9L?=
 =?utf-8?B?V0llMEl1cTdtbWF5MXlhN1Z0US9BU1VTQ3BVT3dTKy9Uc0dvdmdNeTRpZVp6?=
 =?utf-8?B?SGpaM2xZb1cweVZlVllKakNLTHkxZWZkellRTUxoQVZ0RmFQT2lEaVNKbXZB?=
 =?utf-8?B?QVkzeWxHUUlQMm96UGFkSEM1dzJHSGZXS2RRVHlWczlNL0tIeTd0Q0R4dnN5?=
 =?utf-8?B?RXRKYXNOMFh1V3R1L1FtL0FnWnlaYjI2d1JBcXp0T2s5NUZzMGJEWnRzQzVJ?=
 =?utf-8?B?SjBsc21zVC9qV3gvM1hwdC9YdTFQNVBjblppZWFpNEtDTHNjK2F0T3N0QnV4?=
 =?utf-8?B?SXpsU1MzR0JaakpIUFJjZlRtSmlySGdUeS9YRDRCaVFvRDhwL1BZUG1teE03?=
 =?utf-8?B?VFRpbnkremtuYkd2WGkvMWR0MERMQnhacG1IdzBxQjhQNTlIRnNJVkJPRWFx?=
 =?utf-8?B?eGRldnhZL3JXTHNBV3prcmxGZWZkZ3l1U2t6VE5lMTNiTnpJWGxDS04xa3Qw?=
 =?utf-8?B?cEZJYUN3cFZuckhDQ2ZOWnlhYW5YUDJDR1kzVGlXbEsrUXhCbnRZUXV5VUNz?=
 =?utf-8?B?czNMNkg5YmR5UE1oYmJOUVl4NnFOVWVYUXM3TUhLYlk3bFpKUjJWazlJM0Jt?=
 =?utf-8?B?MGFITHlwMjVUZ1JDdUg2K3p1VG5pNXNlOEpRNXBhV3Y2bURsa1BHM1RBQXY4?=
 =?utf-8?B?Z3hZb3pPWXFaNzQvcG9Rd1JyZEZCQWdPQkhrSXlVaUZNQWhwdmtRekpSMEU4?=
 =?utf-8?B?N0w1cTFZU1JFM1pCR2ZYUTBUTGxjWG9iZHZYSEhNdU82aEdqS0NyT3VQRzhr?=
 =?utf-8?Q?pUxzkQSvPxo6dado=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0560c78-9060-412d-db4b-08de5eb9d1e0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 22:08:51.7281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eiAowgpjIx8NboJ5b7Pwc0nkR8MtkU4GOgftXouvigRcLj1OXWhY38LdCg0f8S3QFNYkBx852EQZ/PpB0D+YDriHfdXPq4V/gDsFwHqhDOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF8C0509479
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254483-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lwn.net,davemloft.net,intel.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org,lists.osuosl.org,infradead.org,linuxfoundation.org,fomichev.me];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: AC45FA9691
X-Rspamd-Action: no action



On 1/28/2026 2:00 PM, Mauro Carvalho Chehab wrote:
> On Wed, 28 Jan 2026 10:15:51 -0800
> Jacob Keller <jacob.e.keller@intel.com> wrote:
>> On 1/28/2026 9:27 AM, Jonathan Corbet wrote:
>>> Do we really need another unit-testing setup in the kernel?  I can't say
>>> I'm familiar enough with kunit to say whether it would work for
>>> non-kernel code; have you looked and verified that it isn't suitable?
>>>    
>>
>> I'm not sure kunit would be suitable here, since its meant for running
>> kernel code and does a lot of stuff to make that possible. It might be
>> able to be extended, but.. this is python code. Why *shouldn't* we use
>> one of the python unit test frameworks for it?
> 
> This is not using kunit. It is using standard "import unittest" from
> Python internal lib.
> 

Right. I think it makes perfect sense to use unittest for python files. 
That was the point of my reply above :D

>> We have other python code in tree. Does any of that code have unit tests?
> 
> Good question. On a quick grep, it sounds so:
> 
> 	$ git grep "import unittest" tools scripts
> 	scripts/rust_is_available_test.py:import unittest
> 	tools/crypto/ccp/test_dbc.py:import unittest
> 	tools/perf/pmu-events/metric_test.py:import unittest
> 	tools/testing/kunit/kunit_tool_test.py:import unittest
> 	tools/testing/selftests/bpf/test_bpftool.py:import unittest
> 	tools/testing/selftests/tpm2/tpm2.py:import unittest
> 	tools/testing/selftests/tpm2/tpm2_tests.py:import unittest
> 
>> I agree that it doesn't make sense to build new bespoke unit tests
>> different or unique per each python module, so if we want to adopt
>> python unit tests we should try to pick something that works for the
>> python tools in the kernel.
>>
>> Perhaps finding a way to integrate this with kunit so that you can use
>> "kunit run" and get python tests executed as well would make sense?
>> But.. then again this isn't kernel code so I'm not sure it makes sense
>> to conflate the tests with kernel unit tests.
> 
> It shouldn't be hard to add it there - or to have a separate script
> to run python unittests.
> 

Right. Some way to have all unit tests run is nice so that its easy to 
hook up into various CI processes. Sounds like you have a solid idea on 
that.

> That's said, some integration with kunit can be interesting
> to have it producing a KTAP output if needed by some CI.
> 
That could also be interesting, as it would make it easier for other 
tooling to work with all the tests.

Personally I am not sure how useful that would be vs just making use of 
the unittest stuff provided as-is with python.

