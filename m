Return-Path: <netdev+bounces-101795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACEA9001C3
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52D001C213E2
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 11:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D53187345;
	Fri,  7 Jun 2024 11:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ITdhGrIp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A4D14F11B
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 11:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717758898; cv=fail; b=Bcxkg3eCRCIualOdlk1G8Uk38628qnCdjBLACO49jP8URKX+rCoRA2/98+lUE3XUJ31T3m4YRw4rEYUe8kLhJS/id/lZaN3gzKof4GJoECKLMiQJHoNaFbDs/raAfPTDgBGG9W49L5X8HHHXITYLyEatLye3QOrSgSBxqghnhcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717758898; c=relaxed/simple;
	bh=4YJJgvWO5u4KmiGwMHuJBv8b1N+z9RDqAg6hSbN+psk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ay2v2D7PHGn6AhaD3vQ5TN6NkcUeXKhGV0gtv2uQfMoSfvS5B3Ho47WgJzGuDRO8mnw44q/DwOg+jQWSgv3fRUK/3ZVqosj0R7c2NwIZB4DCcVV75ZnEMUFB+ZwnjUssUVPpEy1QY7cznMZEZc0YTqjpaK9noq4Rc27M1SxBsjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ITdhGrIp; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717758897; x=1749294897;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4YJJgvWO5u4KmiGwMHuJBv8b1N+z9RDqAg6hSbN+psk=;
  b=ITdhGrIpUlXKKwbIl7xeid1TTGL0hsWRipLNbGBERBO6vrB/8cOEp6ez
   f0evOGUOoE5zngb/lfxd/YAyYlIaHA01NDJtTWXzrHqajlw/mO3EQOFz+
   Ikh3RLLpS+C/ECtcVWZtxMErZVWZqpTX9DJKko6v6jDBnlx5QMJHmHPfj
   8ln2uScfESLrxSN/p9GwBuKdpVQT61h8Hu215K3ayct1sHDl9v13sOoxU
   0DfxvOj8YXAfUiZz3Qqsq9gT5vhHQ5ELJA8yroQjLvHzvD1ZjQdQiCVH3
   7CscYiR0EzQKumi6AYP3yv16OC5e+zUHEsN5dA7LgdbkMqkJLKemr4CVR
   w==;
X-CSE-ConnectionGUID: NTbex6TNT1eKBM5qP180wQ==
X-CSE-MsgGUID: CcIK6x3oTbSGWHa34Zj6Ug==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="25129523"
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="25129523"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 04:14:08 -0700
X-CSE-ConnectionGUID: KvzAcERQT1mPNfeAUsmOIw==
X-CSE-MsgGUID: 1fIxdEroQqeQkOgaM5knjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="42710454"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jun 2024 04:14:08 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 7 Jun 2024 04:14:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 7 Jun 2024 04:14:07 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 04:14:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WA71zZxnrdaPNp/TzayDncs9j74UABmyJDXNTSIdDl1my12yk2J8iA6apgKOguEQBu+4MyeAbvUo1ObtnfPf+6fbF797xEv9JDr4cRVtiFloGuX94x9zpmi3YKucsIhsf569RPp7ID10Pu1od7C2QjACgAzdclMyGJSGFy9kft5zkFZ6KG9VW7uLzjghQJdgDiXWRqbx5L8Dvek1MO+cQexXrb6U8803wC+gqvc2YC3jy+OT7jRdDb0atC774TU6ZgFFVoNxq7BWelY5bs+ta6py2kmRS96tN50ETzbmBx4opcaJxm1EmAwgY7JIM2CWlnerhz3p6vYdN2g3PZlAXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bc9L9gSg/yZWsT/agw/WbeimpVfNeljVh6wivGUyKUU=;
 b=Tim54xe82N3h+un3ify4Frgex/C6s2AWOrBtTsmXEXFd2Yy0OZ0iqlGLQfbQhWrWRLeGRrTlHNtx8coEcJuczEAxQUk5HLOFFLEdl5n7l66wVXbFCsTq3TX1WIj/Qo5xX3ArtMEW/A2uEM3RQf+QazKUtmSlc6hVaq7J8FWGbV1Py5FxMjpzDPCV7kypgn0yYHbGTkWQV++nvzB7Dy/FARHUohat6hr2ct8tOQ/yqbPSKDBWcTAyxJ1/38OdpMRzKnYrdHgt3dj9VkDtM+1xXOsmEIdduhKLN29WqXP0RZ5RNfxQyY6vur3huvmpUeUs7/GMofPy8OoKrI+BHWgS3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by MW3PR11MB4633.namprd11.prod.outlook.com (2603:10b6:303:5b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.35; Fri, 7 Jun
 2024 11:14:05 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%5]) with mapi id 15.20.7633.021; Fri, 7 Jun 2024
 11:14:05 +0000
Message-ID: <baa8f977-d2a5-420d-a617-306f951d3d1c@intel.com>
Date: Fri, 7 Jun 2024 13:13:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net/mlx5e: Fix features validation check for
 tunneled UDP (non-VXLAN) packets
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
References: <20240606203249.1054066-1-tariqt@nvidia.com>
 <20240606203249.1054066-3-tariqt@nvidia.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240606203249.1054066-3-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2P250CA0014.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::19) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|MW3PR11MB4633:EE_
X-MS-Office365-Filtering-Correlation-Id: 758068df-66cf-4271-7523-08dc86e2f1b8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGI3cUlncEZ0U2FBbzJMbTVZTkFkOFAwcVZ4MEtkRTNQTkNrSEhwZnY1NTJh?=
 =?utf-8?B?UElZTlNNdU9XR0xFY2VTNkpud1RwbjBZd1ZUZjg5aXJTeTFGTjVXWHF2WDAw?=
 =?utf-8?B?UTRDeFQ5bng0RldCUVdVVEw2bmV4aFB2ZVlXeDNKRm4yVmdrWElYaVlFTjg3?=
 =?utf-8?B?U0IvU0ZFZVhjTlhsUFVYMHJUZ2dTVkFRZ05sYlh1MTQ5MDZ4R1N2Wjd2ZERq?=
 =?utf-8?B?RUVWNTVIcldPL1IyK0NCRUFTUTZnYlk2cXhrY3dKbmJQT0x5cWFvbXg5SGRB?=
 =?utf-8?B?NWh0eWwrV1JCUklFcmpFdWdCMHBoL1A4RlRPTHZNR3hhQzdFblZMYXdoUTYw?=
 =?utf-8?B?VWJZZy9acWFETWpZeG9rRU9JVDhwaUxTYkFZbFlLMml4NGdSa0xTcG5RaFB2?=
 =?utf-8?B?R0N0dldjV2hmSWhHWGJGYzY0V3A5ZkU0K0tZQmJ5WUh4VWV3dVU4bjc0OFo5?=
 =?utf-8?B?ekh0WkQzU2pURU1FZjJLd3dvdmxRMHpvTUpoOHpvWnlRL2lRYkozVURMaDBS?=
 =?utf-8?B?N0I5MnFwelZzK25oT0c1bWZMUjNnU1JEQTFrZ2hDSTMyOWRodllwWTF3VytG?=
 =?utf-8?B?SE9aM0Ftby9kK2c2djI1RDZvTDFPWVQ0SmtWUjM1NG8zeFBTSUZmbFdnTFZu?=
 =?utf-8?B?d3pOYkR5RkM5WTdPL2dSaU1zQ0lnT0Z1bWM4L3V2KytyUVI2bXNXWEVncjVx?=
 =?utf-8?B?b3pGcTFVMmJmRHhCZGFYVkw5ZndnUE8vSi9Tek5XSnJjcHZ1UXFTVlVFUjBk?=
 =?utf-8?B?THlQR041b2pvMkhpdVFkSmVoU2swZEFyZmNJUlNIR3ZXLzIwTHgzRlVlcGpT?=
 =?utf-8?B?eGZhcTUwNnh3azQvSExnMWdpMmhuR213K24rZ0hOMXpScG5udHVDNVNDQ2Q3?=
 =?utf-8?B?bVA3OUJRVDFrSDVZcy91Q0hVY1pEVVpYK0VTYW9TMUhvRTJwQUl0ZnB4UkNr?=
 =?utf-8?B?bUNTQkFqa0JRS1hWREZiWWFvdDZlWmMzbER6UnFQS3FaSjU2dmdUdG5TZ3NU?=
 =?utf-8?B?VCtHVGFuWHpNQTFRM1p1ZjcwSDJKcHVKWU56a3JqYWtmcUJUV2UyK1YvTDhR?=
 =?utf-8?B?QzlraFVnS3pwaVIzQzdrc0NFZEg1eWNUWFJyd3AwUDYwazAvOUVsOWtMYVg0?=
 =?utf-8?B?MVJrUUkwUmlnY2UyMHh2NElOajBPRHcwclFreW9TQjdPRnZnbjVsRTVxVFM5?=
 =?utf-8?B?RkNkUGF5OHpaMm1QcklHREM1d3kxR0ZHTWFoMERJSWpzakdub0hoUzZ5MFc1?=
 =?utf-8?B?Nm9udEYzMmsxc0VJZkNZcDFZRjI1ZGdpR1RZa3d2dTB1YnJKcVBNc2V2bSti?=
 =?utf-8?B?RTY4WTlDUkhZRDRzNEJyNUEyOStvdy9hQWNoczIwUVBZdjNNZU1ZV3VSaDI3?=
 =?utf-8?B?QXRGbTd4K1lyS3duZlgrMlkrMW9YYlRmNnRaU1dOUXlFOVh6dXova0lnaEMr?=
 =?utf-8?B?NUg0TjNYQ2sra2xQNUxOWXV2Qjl3dk1YeTk3SE5KWnF6M2RvRVhUajZGSjNL?=
 =?utf-8?B?YnA1V2cyaTVkc2dpbUUrVGxQRlM0WHU5bGJXdFFBYXk5bU4xbVU0dmJnN05o?=
 =?utf-8?B?UE9BbVpVSWJDdzBqUnA4dm01V0VJMyt3MnZyZ0ttaCtjMU92M2s1RHdrS2g1?=
 =?utf-8?B?bkhCNlIxZFVnWCtpWHU5RkRObG5lREE1bUorL1Nxc0dLczZPa2YvZHpRTFRz?=
 =?utf-8?B?azBqTUo1SnhUTDN2OGxEZUxUNGRTN1dtS0t5eS9QbHUvT2lkN1FmT0xXT2I3?=
 =?utf-8?Q?egxBrpOaUHr95vGK62UJl4lP7d6rWY2jAkZd1nB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUVGRUU1UTYra1VjdEhXVUV1a2IvR01ZK3JGdkZnUkNQTzVZY1d0cHZoUWJi?=
 =?utf-8?B?R2xSSyt0MkpvcUdwWDRrTE1NTlpNT1lXVWRoWTN2ZWNKV2FnbWx4bkxrNUlj?=
 =?utf-8?B?WitUazlqK2pIVmRHQldnWVcvUmwxQVNhTlk2NXpmejg3bGhNcHBHamhLVi9U?=
 =?utf-8?B?YzdPREp3ekdlNVlJb0N3NFQvdVFpQlhRQlUxYUwxbzc3Wm8yZlcvd2xXMnRn?=
 =?utf-8?B?Nk1jZ29XTW9oUFlLTXVyclNISVZ2b0wyZ1ZJY1h6YXFmUkEwUVVCTU1PblY3?=
 =?utf-8?B?cEdVVEpkZWg4MUdXNzhnS25nMXFENHJGN3pKM3dBT20yQndvWXN6c3JpUXR2?=
 =?utf-8?B?TXd0NjM1aW93eFNtL1hoNDFYdkN1bU5KdnZHQm00TmxidWR2ejExZk14MnpT?=
 =?utf-8?B?bUZaaHJJRGhvOTNkR3llYXFhTGNGQVJwQXo4elZ0aUsvbFF5Y1FoQi9ZR0Nm?=
 =?utf-8?B?ZE1XVTc4NE1OQVlnY2V5TDJlVklhdVNnRGQxTVRPeDh5TmhyaHEyc0tWWWRz?=
 =?utf-8?B?ZjUvYW8wcVV3cVhsN09PV1RZU0ZDay9rTitzS2V1NUJsUjV2VDZ5UzNDWnBp?=
 =?utf-8?B?eC9WejNRNFh2ZU5RaXVqV29VSzhOQWJVQmFIb3FsUEFEOUd1R1RPRElWUXVU?=
 =?utf-8?B?R0dmYkN3bUx4aytkdlBhN3pYUDBkdXRqZEpuUG1DUkZxTjU5cFJpb0h6eVJF?=
 =?utf-8?B?RU93N2UwT0t0V240T1BmOEw1RGhmT1ArYkVjZzhwTGk0MytlblVKbWo1L2Rh?=
 =?utf-8?B?UklxUk1DQXBHZTFUYVRQTzZVcStaU0NKcVhJemE5bkQ0OXJTL3VmM2s3RWc5?=
 =?utf-8?B?VnZiK1I0ZFFwVTdVbWt1Q0tOdThBY1JER2d4ZWhRd1Npb3NwOTdGSlI2NU5r?=
 =?utf-8?B?Y0NLWmhkQWE1U242QTNXcFJVT1d2MnZsQzJJeEkxZlROajZlUXB5NHlqUHUy?=
 =?utf-8?B?b2o5bFV2NlloeVJuelNtY1hNNHNnbkROVVVBTzFseWRTbVVkUHorUVZBNmdn?=
 =?utf-8?B?eVgzdmtSNXUzNTE5MWU3QStva0JHTzNVTWxZdGZ1RHpUYjhEYXl4VlA2cUFR?=
 =?utf-8?B?eFM5dExoZ3VSd3RlMUxCRGR0clV1M2Vyb2JRcnJub3czQ3psMXpOVjZxLzM2?=
 =?utf-8?B?M1RnbmJIUWFLUDZTVnZFOW4zTDdVSGJIODdKNTdwM1EvRE55Q2hpOXBpWEs2?=
 =?utf-8?B?S1dONTEvZDlmd1NDVkhMcU4zZFpGcXBaQWRBNEcrV0RLSCtFZGRaYy9DUmJa?=
 =?utf-8?B?VGlQUjdVTWo0VEtOdFNUR0hhWGJ2c3UrRllWY2VzTHdCYVZVUmlBL1pDbDNa?=
 =?utf-8?B?QXBINktmMjNoTW5zVFhSNWF4ZGJSKy9aUXZQTzhTSXlDZjZQeExWUDJ6STVC?=
 =?utf-8?B?aHN1b3BNS2J3cFo0NXJKSlJaaHBjUVVqUTg4N2lyQlh3UG05S0F5bytzcFJN?=
 =?utf-8?B?T21KQ2hXMHh4YlJvUFdyWFg2RWlZdkZ5WXVIcFNKYzU0L1p6Yk4zc1l3bDdH?=
 =?utf-8?B?M3N4UGMxdFRwSFlhSm4yTzdnY1JJbng4TU5PeUNiQ2kzaDZCb2N2Y0VHVzFL?=
 =?utf-8?B?SHpwZ3NEQ1Z2RUxBREdlSldpSlhDZk45R0ZEK09OZm5LV2svc2o3b2hvSG5D?=
 =?utf-8?B?K2VWTitrU1FpRG85TlhCV0hINGs2MlhpM2x0aXJUMk1CSjFmQXlMYStPWVVK?=
 =?utf-8?B?UC9qWktrSkVQZ3U5N2VPZUgvZldScEpKUnFVWFNOMXVTdkdQcWlZNkRlRlNQ?=
 =?utf-8?B?NXkzT1pBbjZFL0JLSXYxL1hncmlFeEtDREdYVUQvSlo5Vng0TTg3cXlVckJr?=
 =?utf-8?B?bitkcjJGb3lCbm10aFZLM3NNNVl3SkFKOW05NW9JU2txM29zNXluQnV2OXFN?=
 =?utf-8?B?dUJ5UlBYc2dneVh3UDYxaG12eUZWaTFmSkE5MmNCVEFaaFh0WkkxRGZBc2JN?=
 =?utf-8?B?aVNIOWJlSzZjdnBsVVhuUkhiREJZbS9rcVZrNTN0dUNwZTNVUmlPc0FqR2FE?=
 =?utf-8?B?b1BRT3ZnTHFJVlR0N3p5VmNxSXo5dkdoTEt4dnZZQzE5SnBjVDdQNXNvck1F?=
 =?utf-8?B?Rk1sK0x5YUdmekROQno3Y05zUW56RUw1T1lTMEVXZGtDUVpIenRXVERmb2ZN?=
 =?utf-8?Q?1aL2yTb376SMvdobTzA68KEzv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 758068df-66cf-4271-7523-08dc86e2f1b8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 11:14:05.8035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0g7eJfJiMpJl7iPEQjYtHCMvI+eWInBx/K4zS5y9UkHIpuNWHfw6WTOHRIvd/2ggJXwfH9SOY4g5+El8MYBz9BXjETKmllMtjZkfPCtkwuY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4633
X-OriginatorOrg: intel.com



On 06.06.2024 22:32, Tariq Toukan wrote:
> From: Gal Pressman <gal@nvidia.com>
> 
> Move the vxlan_features_check() call to after we verified the packet is
> a tunneled VXLAN packet.
> 
> Without this, tunneled UDP non-VXLAN packets (for ex. GENENVE) might
> wrongly not get offloaded.
> In some cases, it worked by chance as GENEVE header is the same size as
> VXLAN, but it is obviously incorrect.
> 
> Fixes: e3cfc7e6b7bd ("net/mlx5e: TX, Add geneve tunnel stateless offload support")
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index c53c99dde558..a605eae56685 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -4875,7 +4875,7 @@ static netdev_features_t mlx5e_tunnel_features_check(struct mlx5e_priv *priv,
>  
>  		/* Verify if UDP port is being offloaded by HW */
>  		if (mlx5_vxlan_lookup_port(priv->mdev->vxlan, port))
> -			return features;
> +			return vxlan_features_check(skb, features);
>  
>  #if IS_ENABLED(CONFIG_GENEVE)
>  		/* Support Geneve offload for default UDP port */
> @@ -4901,7 +4901,6 @@ netdev_features_t mlx5e_features_check(struct sk_buff *skb,
>  	struct mlx5e_priv *priv = netdev_priv(netdev);
>  
>  	features = vlan_features_check(skb, features);
> -	features = vxlan_features_check(skb, features);
>  
>  	/* Validate if the tunneled packet is being offloaded by HW */
>  	if (skb->encapsulation &&

