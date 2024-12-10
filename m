Return-Path: <netdev+bounces-150874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 966489EBE02
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 23:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ED75168854
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 22:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B4F1F1931;
	Tue, 10 Dec 2024 22:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PqYYxAEz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF061F193B
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 22:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733870708; cv=fail; b=kfXJeX7drngzNTxqDs1jRwNz5iWWKQj9IDXDo6xqBg6QwHGiP2n9QgHmvoQzP1x/bElY9NuYXHxN/at01OCrMu8+hHBE/g+SldJllQJOVjEJbl4Ri26jLsFqvFQM3l8vGKJKM/r7g8awXO/qivcicWL+lAhfgYPQXYrxpEHxNXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733870708; c=relaxed/simple;
	bh=jszrJYk6e4t8cm0WDgiI3C7jwHrU/PFlP+uBlfJyv0U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RO61fgaQzX9rezXG/8/Pfgeb7EwTZY2RdkGLyt4T5n5YRDD9IAWV4Gl3f/kcALJuVQsMN+QYSyOMpJ+OPZJNZ6QmIVNF6SYiKHmMii5V7MKdMz1FGaTShHP+BXS2uaxS23gJ/F2l2UPwwxf7AKOPu55eRAVTi9b9l3BbR8JCd0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PqYYxAEz; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733870707; x=1765406707;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jszrJYk6e4t8cm0WDgiI3C7jwHrU/PFlP+uBlfJyv0U=;
  b=PqYYxAEzfCzrhOLe8oRRPE0QPQfOIfzvE+rVCHKcf4slIZRkJ0I2xSFN
   Sjl6arjiSICUMnWBgsWQc/uliwcyBQ5vpg7nuyhNwHVgbdUCbh274wHdu
   uSakHXaMB4X9EtbWB9ZqrpbhrTbmxiPxSkjkW3OeU35iWNDZRLIRfv8jd
   ThxKMG3q6ZCXEkS7D5SCe/DN6N5YSX9SnGXxd7i5k/gusp0LBrzFKSenN
   zGnqnXTqopu+RCWtawJvo4Fd7Q+iSoyICM8wg6uon+ADOpdy8J1SLQHTQ
   etr6feNes5HQpL0+Q1HLgFW5qxzvxMrVLEGDP0e9iD9P79g8KWlJwmXIY
   g==;
X-CSE-ConnectionGUID: 4Jw7tDYDSE+KKL2gP+nNxg==
X-CSE-MsgGUID: XAxtgNqpQ8yFnMNcYkQEDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45249479"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="45249479"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 14:45:05 -0800
X-CSE-ConnectionGUID: 5QqX1GMySo+b1TxL8pihwg==
X-CSE-MsgGUID: iNte4CJzSEmlJktCB912BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="100069089"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2024 14:45:04 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Dec 2024 14:45:04 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Dec 2024 14:45:04 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Dec 2024 14:44:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=riBXGUlv6LyphHW4/g2GOLTxGRvUNZR82YY3HJyG8xxa5FjuE8C1x3Nsv90D7Zlss6XkR7XOI00Br/B49oIIBunDmoIPBS9E3G8x4/ZeQWyg06d/vTeyVuwcFs0oP23WVPkNFq3lHWH+sATMuZAV8fB1VBGaih+7mTf/fi3zr1B11DtDcyrJJCegGAKQPFJdkVLeN6sKshh+PddtdRENqeQQYMfjnxt6ufu/Rx8KELh2YPbmGa6YPtBf7ZRxKlDTVWhdhT3rZBI7TTYgUWWPSRCufbKzszm2jbHebn49/8K7KnM4VO3hkHj5fJwsVB08KSg0UytEqD5mf1jtT7iMEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0SZRbsNJuu3RpZyPn4GJeXDq9VpCDfUN4EVB1ZZ57Y=;
 b=ce1b06yWg50rC0t0Pfc30h/bqeoJzi3eyfZZnLO9ALGpk3hOvFROxCkcIbXQGrbi2Vb4de69mT3zaeqRb+Z+i0IR4SVALtxS3qtzdGyQESg7+pLv9cv0scVAttAaZW3qJUxwZ0XUsisn72HjMCOFLaT47FENZrUUIje9OJgLkP3RCdBv0DD+IFsMPAxCBNPKl/4gjrQWwP44/Dh5LQgavtx2JbLP9GnE2UvgP/byuVAOSlKguEBZX8uW2xMgsrt16/5qy99Hke7tPxpslIdVh6X9QfC/v6rC8eEAbPa2JrgMGwWNYop0+KeiwzN622k7qL1E/Q+36Ggt7gaXhGM2fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB8342.namprd11.prod.outlook.com (2603:10b6:610:167::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 22:44:43 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8251.008; Tue, 10 Dec 2024
 22:44:42 +0000
Message-ID: <710c5445-4949-4143-8dce-75dc97e455fc@intel.com>
Date: Tue, 10 Dec 2024 14:44:41 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] ionic: add asic codes to firmware interface
 file
To: Shannon Nelson <shannon.nelson@amd.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>
CC: <brett.creeley@amd.com>
References: <20241210183045.67878-1-shannon.nelson@amd.com>
 <20241210183045.67878-2-shannon.nelson@amd.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241210183045.67878-2-shannon.nelson@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0062.namprd04.prod.outlook.com
 (2603:10b6:303:6b::7) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH3PR11MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: f20d9817-2463-4aa8-fd39-08dd196c3cd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anVsWXEyamtON1U4VCt4aFZKQTFIVGpKa0JFUWdVaHdYTVdUK3lyMXBMSlM1?=
 =?utf-8?B?elFvazg0M3Y2S1lZaFBIZGhMRmpDcEpSdU9veDZsaEU2T2VxSVJvOURZTzEr?=
 =?utf-8?B?dVl2OWJwTHAwa0JwVkxiKyt6d055N1FpdTBFT3JabmFXaWhnZGRSWUViQWZS?=
 =?utf-8?B?Nk5DZjlieXlZbkRzUnIybk41KzdiQWNWamNoZDFsMTZIdk9QTkptSUdVWU9p?=
 =?utf-8?B?QW9XaEx5Tk8ySVBacTJtRFEzdi9YbkFOeFJOVDdudWY0cXdSS3RjRnhEZGZi?=
 =?utf-8?B?L2s3SjVWeGRJREIzR29MZXU5VHdRZjUzVlg4Si9KUWN4M0lXcGo0QjNBMjBo?=
 =?utf-8?B?TEMwcVlwNDk2L0dqWWJSNW51cmxKMnYwVVpJazZSNG5yR1ppcEpxRW1CcXdR?=
 =?utf-8?B?TXlZQ0lEVkhZQW5IbkdEcmV5VDlYODZiU0NXYWZSN2pxSDF1ZlM1eUREWXhr?=
 =?utf-8?B?RVVqUWM1Z2loY2h3N3lIZjg5c3VWazFhd2hoRnNqLy9VdEhjbnAwTGE5dGJl?=
 =?utf-8?B?K0RhNmh5M0wzNmhWNENURnB5bllrWmhWVG92Q1Q0SEg4dHk1VlRpQ3QzaGF2?=
 =?utf-8?B?QVdBTU5TeVFGNzVTQXFuUzAxTTMyQVdYUVpZYjhWYm1XSHEzbHhMQ2tUM0Iy?=
 =?utf-8?B?T3ZCMWo1V0ZuTWxneElyRnIzSEhJY0lUYW5JYmFubDZyNVZyUENDQmhCZTdF?=
 =?utf-8?B?VTc5ZmhSZWh1UkY1aTNkT3R3NGdCZDBNaXlJb21GWm1ZRVBoV1hLR2dqbTdR?=
 =?utf-8?B?VTdKNHd0aFJQdEhsc0ttbGFZMTNySWdrWTUvbk5SNStFMmxzY1ozU0QwMW9k?=
 =?utf-8?B?dlRRRFZxTlRQT2FGSWZ1MXVhTGl2YWJUV2Jqdlh2MTdza0ZCUlJTbjZsc0Zm?=
 =?utf-8?B?WnVOVm9JYlZlSHY5L0VBdlFvM3R2Q1Y2NnZBelUxTWlDY2N6RDJoT3pnTEUy?=
 =?utf-8?B?YzUzTkUxVWxyVU50ODhMSVQ5WHFNRGJ0UDdrMjk0Y2lnNmVHaXROZnhrWk9Y?=
 =?utf-8?B?ZEFGOWZld0lsNGRTT3dSc2UvQ01XN3lvcGdHNSs2b0hWUHdGblJPb1NvZWVz?=
 =?utf-8?B?M3JxOTE3TjV5WnRHSnlSNXdUZFBDaWptcHdxYWJJYVNvNnRtczkyTFBBOXNM?=
 =?utf-8?B?T1FjK1RIS1JVOFZIeTR5ZEcxOE1tcE44UWl1US9OR0g1bkZIN09hM2tLOHM3?=
 =?utf-8?B?T1RTWHNlNVZDNXpFR3orNEsrVmlva1liQmlzUFZ4ajdNWkRrdWh0cyt3djNP?=
 =?utf-8?B?Qy96Rm0zdGx0ZFBDVTJ0elR1SEZsaDFjdzV2VCtySWFIckpMWmg0aENpanUr?=
 =?utf-8?B?bkcwQklrSC91ZnR3ZFVwMlpqblZGVEx1Tjc4M1RuZ3NoYTlONXRFVmtDdi84?=
 =?utf-8?B?bnFiUC9tamFJaEdpRWhvVmx5UkRTMGNHMlg2Wm5wOUFqMjVWNCtjQkZGUyto?=
 =?utf-8?B?a2VHMUNHNnlTaFQydE9GeFlJbGZrMjF0VGI2M003T1JjRWFaN3k4c0dpeG1W?=
 =?utf-8?B?aEh4Vi9EaDJOY2FYSUZ6QnpHYmZPUnVTMnBmbENKcnllUUVGQVVxVGNxOEtP?=
 =?utf-8?B?eHR1czQwZk0veTVGMEhkZHdkYjRyZS9yZ3I3NlNsemFkK1Bwd3BraCtNOEw5?=
 =?utf-8?B?SEtCY2V2cWlMQk5aVHdhd3QwZ0E1ZlpyN2ZjekF6TFNMQmZxVFNralp3TTVT?=
 =?utf-8?B?dXlXTnROaENReGdYRGM2blVKWkZEUkNhRG5EeUpTT0V6L0ZzalgvbmRDb3dk?=
 =?utf-8?B?U21GQUNEL2Z4akV0Qk9tYXh3TnRFQVErVnJkSEtjQnFDNG9aQjFySW9yNnQy?=
 =?utf-8?B?Y2M2eTdvbEZXSDhIU1B0UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anBDcHNVbkdUdElwTEwwOEZ5WENOblRwanpvYzFBRDh6dmtMcW85L1dOa0Z2?=
 =?utf-8?B?UVEvSWNXOTY0NXhWMU53anEzcDhjMXFJTXhmT3M2STEzbVFLeTUycTh2VnUr?=
 =?utf-8?B?MzQzNWJQZ2FPL2gyckJjdjVkcUJXdkVqWnRkb2dmRC9tWjhNTlFiNHFnUlRO?=
 =?utf-8?B?ZEZ6TVlYb1BpQy9LUzZPSDdqYm9LR1JYWjdtalkzUUd4UHhqdk1rZWlmcnpj?=
 =?utf-8?B?VlJHZmpka2EvYWdZZUtTUlUvMlRpMEIvTHFmR0h5b3lzZjJzRUNpaHZZT0FJ?=
 =?utf-8?B?eWpiVENNMDdON2tTcDcrRkZ5RVVodDBERVk1QUpObFFKMUZFVGl6em02ZU9L?=
 =?utf-8?B?SUtYRWloaTNieFJ5RzlNRFhmNiswZkh3NE5aOElwZ05wZHlEMUE4NU1DTFdy?=
 =?utf-8?B?UlhGN2ZTVDZBUUhjNkJqZHB6MGZxYjRJYmJuYm5MMXhxazUwZzlRZW9HOGcv?=
 =?utf-8?B?ZWhwa2lLdThZMEdpeGxkOUV3U21MMmpjaXVTVU1KcXlQOE1DNUlHeFhSeTJs?=
 =?utf-8?B?c1hTSWtVVmgyeUFJQXlIR3JEYmRFdGlkRElvQWxHa040MkgyOFlSejJkL3hT?=
 =?utf-8?B?WEdFK1diSy91dE01bEJJUjc1b2tiYXZ5TTlCN21vUjN1YkM3TzdJOCsrbXNC?=
 =?utf-8?B?dkpYcFh1bGxZYzcrdFdBc0JtSjRoc0JDZTYxN3BQdHZ5T0ZhUThPWGYzTEpI?=
 =?utf-8?B?WFpNRk1tbWlWVTRaTmJ6ZjBjSHFMR1N1T1Q5MUcwK25PTmJVUUREVlFvZDVt?=
 =?utf-8?B?cFdSK2h4d29mZml3akJXNkdaL3FWTGUxTHhPRnErQzJOaThvTjVRZmNWS3pq?=
 =?utf-8?B?N1Evdlk4dE5uNmR4M3NoZ3VJalpHcUw4RE8yZFV6U0ZlMzZiYTlNUmcveWFQ?=
 =?utf-8?B?UjZES3RIbUYvTDFUU2Z3Q3F1TzYxQnJaVDJkbXR6M3ptQ2t1bS9TM1g5aHhC?=
 =?utf-8?B?ZEZlUm1GQjlDKytZSVg0cnk0MVQvWjF2d1Urc1FKWjcvOFF1eGlMT2JVbmpm?=
 =?utf-8?B?TU9qK0txd1d0cDZseTh1YVA3bmJZNUt1MStiVWdEakhzRGQ1bDAwUmhDY05X?=
 =?utf-8?B?OWoxNDJqZnVRK2tIYlFxMUdndzRvTWhNWlhBbGJzci84NlpYbUtVbGdnV2xi?=
 =?utf-8?B?cmxlOUdZWUE1SURLRFpxdWY5NFN3RE1rUmg1UUJHNW1QaWE3cFlhWktwRlZz?=
 =?utf-8?B?TlVVa05UalFoZDl4aWdEVmtBb204ZEtJM0t0RzZHdkloOGRtSFpHNHhOZW40?=
 =?utf-8?B?Q0hIcnVrOHE1YnN5TlJ0SDNDUXNRS2EySnM0M21tT1JDaysram95MUNYZUc4?=
 =?utf-8?B?YVVCU1RwN3VHdm5udDI5bDlwWGt2Z3ZCdnh1Um9NbjV5Zndncm5IbldUZDY5?=
 =?utf-8?B?SUloQWlSdzNad3hOU01jLzd1UGphK0ZPTkQxbFBBWGRObXlwS2VrTG5nZ0Yz?=
 =?utf-8?B?bW9FMUpXd2ZMMG9wQmF1ZVBaVnFLRzJpMDVOLzQxbzUrd1FCTVhJRHVlSTho?=
 =?utf-8?B?eWg5T0xvOGZrdVd2dCtCM0hveFdxQkIxbEJ3K1hiQ2Zob0dzK1ZZN2NpZHd2?=
 =?utf-8?B?eFBlU3FSdmYzREovN005SVArUStqZXJ1UzhYaW5vcS9JREZJbDI0VVhaYVJG?=
 =?utf-8?B?RTkxMk1RR3U2T1AxWUg3VzFpb1JERDJ2TE9NTlZYOU9waCs1cnhOcWtqbnox?=
 =?utf-8?B?MzhnSEhjempYL0VpakZBUXRWOVFGQzFEK0hQSTJCMGMyK2cxOEVlTUtHZkRp?=
 =?utf-8?B?di96UGtiS2FnbnpWWTR5U3lyeUFkemRKS1BpUEpITXVPRGhTQXJneGVlSnJM?=
 =?utf-8?B?R2lVRlNuK09KRnhpN0FDVE9DbGg1RHhJOUVHYlNlQzNJYnAzemZnNmR6bmpu?=
 =?utf-8?B?ZVpMWWswVHFuM0ZvS2dUS0hRTTBKSmNvL1hqdkR0TEJ4YlhMMFZJWVhjbnZI?=
 =?utf-8?B?ZWFPTnVraDIyaFRtdEVVU1dhTUJ4ODYvR1B1czJYUndyd1FLc0hLVFh1dUow?=
 =?utf-8?B?UkFEREtxT3NvNm4rMEJ6b3F3Q2lIajk1bEpwam93YW0vTU0rNWthRDVjb0xo?=
 =?utf-8?B?dnZRK1U3VmhDMzNaeDM3bzF6VlY3U3lsMXIzWXNtMU81ZUFmTFhCMFkwN0E3?=
 =?utf-8?B?c0ZWQzBPa1FUYXIvbWg0VUNjTXNaVlFDSXVHVTZaeGs0RVJwVVFYZVAvb0xZ?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f20d9817-2463-4aa8-fd39-08dd196c3cd7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:44:42.9052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kahitxMW6/JdOl5h6TfA24M2u+ZdgI+ZwdYL5XpU5mlj9j5J5I84JDAC9AUh5viFBHW0S/TZKq8hdR91OQc0/GaiibJuSdtwyKlGhlH16OE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8342
X-OriginatorOrg: intel.com



On 12/10/2024 10:30 AM, Shannon Nelson wrote:
> Now that the firmware has learned how to properly report
> the asic type id, add the values to our interface file.
> 
> The sharp-eyed reviewers will catch that the CAPRI value
> changed here from 0 to 1.  This comes with the FW actually
> defining it correctly.  This is safe for us to change as
> nothing actually uses that value yet.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

