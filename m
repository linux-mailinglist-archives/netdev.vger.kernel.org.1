Return-Path: <netdev+bounces-104610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0611290D8F9
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 18:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EBBF281152
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B58328371;
	Tue, 18 Jun 2024 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lTOcliMu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F661C69D;
	Tue, 18 Jun 2024 16:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727651; cv=fail; b=sEDiTeYZv4ID3m9cOqSYVRUZhGNoDWL9+XSRocB6Ho5RRGBAVS7Ri6EGHSpLmkWtywZYDyL5KBuWthvQENb5TrG3IM6hwtx9nKaERHjThcNfai+xoGhyq7bsIaMrq0e9RZ5TgGzHIPVVi7cks5jGgejjz2/Ou8UR0WlNSHFExJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727651; c=relaxed/simple;
	bh=DnYVGHgmKOv1xXCg3+xi7n4hyLUKT9Eo42TvZR+zPaw=;
	h=Message-ID:Date:Subject:To:References:From:CC:In-Reply-To:
	 Content-Type:MIME-Version; b=UtOFTNsed/fPT6kzMagYyWqqwoW/I5rB1SXg3u2GZjH1EIViROHKuF1qiIBdkAIrvDkKfAj0ovPebU/5T/BJt6Iyzy3R/MQD6wCTlyV0KTyrofBFlOowPfISZseBFk4H1PTpCZSZUDjJviycohpQwV+rrCVXPNRXvhgpqR32uGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lTOcliMu; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718727650; x=1750263650;
  h=message-id:date:subject:to:references:from:cc:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DnYVGHgmKOv1xXCg3+xi7n4hyLUKT9Eo42TvZR+zPaw=;
  b=lTOcliMuC/KDg9vCImv1vzfHbIUFaHscfG4K8tmjx7EFpiRdpgyytUu0
   bWQo5NmQKF/yThmaKWw5epwgKF7tbBxR3q3GQpjOcTZxDM74J33yW36s6
   epISeGxKI1FX3y/oaavvwz2jVO3QcdkSJTxBI+PrFsfCDagsN+Jsfi66U
   Vt482D4LcgJF8tnpn6R2W2uDvXFJ65sfeIvoq/O8wE6r2nDuAOt94d95u
   NAgTL5IRnNgOWe2gV02o6eSr/zp+HIJTniWk+yMAcMXF8Ao3R3Dk/xlP8
   pFYyzUquQ15Ykt9wzBPdqhGTaYJcrRko7y1FM9yR7mvm9XNFibRheYD+6
   w==;
X-CSE-ConnectionGUID: EXQ6goRlRpODcYMQF6FTlw==
X-CSE-MsgGUID: KW2QRQKiQlyECpYjtHMr3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15591468"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15591468"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 09:20:49 -0700
X-CSE-ConnectionGUID: ay9zQD4bT825XcJfPgMJVg==
X-CSE-MsgGUID: MvRFoFuHQAeLIYTWjaem8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="72358715"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jun 2024 09:20:48 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Jun 2024 09:20:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 18 Jun 2024 09:20:47 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Jun 2024 09:20:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRINV8qek2mtB4ES4swzwTzy8yT/ro7FLPKwtHBPM3qrg/A+6c2txRdEfzWe5mBQY25wgQtod8L2v+zL7eu5fjEMm4UQ+On9EbhOenXkhdN9Qv7qYyUuDuOcK6ISddctMBP/T9rHZNl3D9/409bE5VmpENZtuClVgQoTmgCqQpg3rn/nU3am63de4ZH5YpsqjS6tQlp4vHsdWHsZ7cgwIeaeyCY0Nxw+nUP+6v4tymM0ZzoDVnBPoL7I4ZKJ8ZVxMvWXjLPxev5fGJQEjm+eONRndFUxGHcNQGJpcS8I1W68lhJ0Id4MZGpaHWXOVKRZBgwEnffeFskcmV9Q7xRJGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtJrCo07DfhCeSrX69AFNxeZHKHUEaE524oP5De31kg=;
 b=gP5nRmEh2N65BDG0NRuRHYMtBp4Q3jLURH6IkamLp7Y6Svj+r7qpWG754y14I0JoJnrYx0PqYU1W+XuhnUspmAktbmdRXd3EeE6bNaoFGWIfobpGhdeUMm4P6IXZ70XgDcLzLbgXcQyPga3ueEmRf0IRA+aoZLaKPj+GjvD6v/aetorI4VPNPStewMfaVipMhySa1fE1UvLGBmC0JHz6dbZWN34SOtBu10YU8H2jcs+NxDvUFXp9e008zWylj8M0TztTNOE7w2whvSUUdGoOh2O4uADw9HOTWPuOb72CPhkYweBMWz4M46/2LoChZpwOSbJ/PO5MJw58gjtI86K9Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 16:20:45 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7698.017; Tue, 18 Jun 2024
 16:20:45 +0000
Message-ID: <51a446e5-e5c5-433d-96fd-e0e23d560b08@intel.com>
Date: Tue, 18 Jun 2024 18:20:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] enic: add ethtool get_channel support
To: Jon Kohler <jon@nutanix.com>
References: <20240618160146.3900470-1-jon@nutanix.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
CC: Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Larysa Zaremba
	<larysa.zaremba@intel.com>
In-Reply-To: <20240618160146.3900470-1-jon@nutanix.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR02CA0075.eurprd02.prod.outlook.com
 (2603:10a6:802:14::46) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SJ0PR11MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: d514b2e5-117d-4ee2-68b3-08dc8fb29b29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NkhzWUQyYnBYcnJFUTJ3TWtMeDA0cFdQaHMzQWV2M29WbnZmR2hDUU9VYW0y?=
 =?utf-8?B?c3duanZBMEFnTUNWd2xVRW9uRUJhNTZucXRqNklaWTRqYlJQUFFBcUkwcHFR?=
 =?utf-8?B?V0hKVXh2SXhjTWMyQTZ2dm1UdjFiWXBXcjVjTnpkL1EwUCtTdVczdVJlMUtX?=
 =?utf-8?B?RVkvZ0tlaUdlWHpKcUZaSm9lR0dMRjAvMm1qMWs2WjhUT3RhdlpwM0Fkc2Rv?=
 =?utf-8?B?RjR6bWNvNjdwZXRXa1kwTDBhZWNOeHVlUktIMEI3UGZXaXBqdUo3NTZmQTRL?=
 =?utf-8?B?MUFjM1RxTHY0aEJYa2plVEQxQnlmNGdNMCsvVzB2RnphSnZ3cnJyc2RFdnpE?=
 =?utf-8?B?M0FZN3pmNll4QVowaEVHTmlxbVZtakpqdEZ6MU9GRldhZVpLVTZVVFVpeFNL?=
 =?utf-8?B?U3krT3diMHBuYXJnaGRKRVp2emtib0orbkVISDcwc25wRkhDNy9SNDQvTlI3?=
 =?utf-8?B?cFgvMjNINGx1MUIzSEZOUW9WVGVEWkNGRkNBSFB2WENnTmdMZVpKSWtxRFRv?=
 =?utf-8?B?bkN1QXlWWDduRWNLTmU3elhnYzBSbDN2KzA0RG00cTBpUzJ1dHdvOG9kNU1a?=
 =?utf-8?B?K3VLeENOMjJTeUR0cXJwdTBqUXVFNkVhTWpDOTdPT3lNREF0Q2hyd0Z0STlW?=
 =?utf-8?B?VWVmZFFYQXVySCtRbUN4WDZFTDZUaGdIU21UdldXOXhtbXdUOTdiQ2F4MHVX?=
 =?utf-8?B?SVJ2MkRRaWxhamVRdWZmaU8yNmhhRWlZZzJyZ3dkK1dMUGMyVlNzRVFGcUtz?=
 =?utf-8?B?cjkvNTNQanc4Ym5tQm5uUjhkNXZPQWQyelduVXFwK1J5YnpSbFZzV0hqSWl1?=
 =?utf-8?B?VHZBeTNZcml3eW9rREpLYjE2YXN1dFhud3VIRzN4OU1IdC8vWERlTDhlbkhP?=
 =?utf-8?B?NUN4YkpFSGY1WXdrV1FsRXFYKzcxT1p2amt4YVRHZlh4LzdYUnVBZThaK2Fh?=
 =?utf-8?B?T2srTThNRiswSEVHNU5OVEhqY1lkNmdyT3VRZG9wbHdLNW5ZSHFkRmNOeG9G?=
 =?utf-8?B?OThMcm8xcEVqYzFJVnNsK25LbHRqc0RFL3VSampzTnRFc25UWU9LeXNRWmtX?=
 =?utf-8?B?WHYzNFZ6SjRLNk1LenJ1ek5ZdmppeDlsNVVCR0huYUIrQmQvUzRoemZITzNZ?=
 =?utf-8?B?WGJVUGt1emhBM3c0NCthZndKY0xic05hNUdvZlk2UFU1R2NSK0dJaUJRV0w1?=
 =?utf-8?B?SVhxNDZJajdrNGtVcGJOY2RsaWx1VkJiaEh5N1crVVFFZDBTT3pCR0Y3alpx?=
 =?utf-8?B?Qm40ODIyTGdjSnBRRlRiSkNKT3hpeEpzQXFvUm5ZS0JRcW5iNGZtYkxtZU8x?=
 =?utf-8?B?dlJOUWdaaVNWazBWOEdkMndQVkVTNWxmT2x0VkFHN3g5ZmoxTVlja2h5WUpC?=
 =?utf-8?B?VVdFTjEzb2FOdWNoU01tWVYrV0drdFJFQkNMclFtQ2VjcTd1OFYvMmptRkNL?=
 =?utf-8?B?ak9qTUwrTGpja1dqL3BrVnFqQVBTa0UxVm94TTB1K3craE9vTXBEV3NrcGRu?=
 =?utf-8?B?Y2hMdVRmc2FsbVE2eHB6SENEK0Z6aW1pc3Z4WDlwVXpWWHYvTWpuc2hTTFZr?=
 =?utf-8?B?czMvWnlJYVhJVTZRSC9zRnEzUEI0VHVIVWpiOGZXamJoUFVQNEVGK2RqZ2dO?=
 =?utf-8?B?bzkrLzJJOEVsUmlSK2w4QlhubEZYNkxvSEljd3NzcTNrTVA0Wkx6MG1BelJV?=
 =?utf-8?B?Z1FzMWt4bFErU05JR01VZHA4U3VyN0plNFpsdmNpek9jVnpuY2lZR2JjMkF4?=
 =?utf-8?Q?WAAorXrJWANmX29lyd92Y6jVDKtaAKW3XGWW71F?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3ZsQ1RHU0d1azdnQ0Nob2VRZzd1SEcvOFhQamp0WGc5STR0VVZFblhwOWs1?=
 =?utf-8?B?UVBwVlpzOWlScjd4MitHcDhFQmdTbFVDVU9rK3o3TTF2YlFMcmI0ZFhSWFpm?=
 =?utf-8?B?Rkw1bS81ZnQ2ZStLS0ZaZUxVT1NsWmk3NXo3L3UwazZKendFcnRZL1dFblB1?=
 =?utf-8?B?Mk5qSnRsQmlKbExlUytvSnJlZVhHZkg5OWs0YmIvOGQrTm02Mk9aYzh2dm1r?=
 =?utf-8?B?aWtramxiVXBLczY1eURnOG1SVHVvUTdTZnNhODRjd1p3V0RPdlg1a2ZNKy9T?=
 =?utf-8?B?aFJyRWEzUmp1MU9maWhHWm1KbTNLOXZmanRoZUsrNTVmbXBHTHV3M1Rha3Rp?=
 =?utf-8?B?VTJqbkpiNjhsVFRaWE5EUTdIdkhTQUJzMW5seXY4RnI3RnpoZGpFODdRYU5W?=
 =?utf-8?B?bnREc2lrTEZjdk5LcHFSWms1QllVUllmU1hLY2hoY0ZobHptdjRXR3ovdTFu?=
 =?utf-8?B?T2l1S2FiY2JDOS9pUjhzQVZXZkZ5RjlKNFRaMmRKTzQ3dFNUUEtOMFV0Mm9T?=
 =?utf-8?B?MlpScmJkYWM0NnoyREpWMmFYOUwzY3RhTDYwc3BXREJ4SURtU0c5NVE5eE9M?=
 =?utf-8?B?RW1iL3p5REgyVHgwN2hjbnhYRWVPNHFJMUFYUmtWclU0RmtmR0JZQ2t3dFpu?=
 =?utf-8?B?UXFzcWoweGQ1SU1zL01nM0E0T0k0MllBejgxbzJOS0MrVEo1d0FQcFZvQ2px?=
 =?utf-8?B?bjBEYTdrMytvUmJhM0dmWFhnc1FZZTBBazM5Q1piV1EzWVE4dG5qMnArZFQ2?=
 =?utf-8?B?c2haT1hEU0twcHAvc3Vocy9LaURTb0hRKzRuNWplSkRoR0ZZRElJc29Wc1JW?=
 =?utf-8?B?UzRlZjZhOFY1SnBCak5LL0IzTUo5RmdDQyszckp5dFlidUZiRnJWRGdDZWdU?=
 =?utf-8?B?Uk9RSmtaU3dMaEYzQm9Xd1hzWTVkTlgydEhPakV0UDNER1lIOEw3a1NsY2E4?=
 =?utf-8?B?OFBUSDlNMnd3Vml2L3JiRjh4RDFmZDRId2lYaUNRK216bzE4eUROK3pFL2Vy?=
 =?utf-8?B?dHJNTzVGcXFhTWtxekUvSThuTFd5VEhEYjR1VkpUMkZGR0p6dFg4Sks2VHU0?=
 =?utf-8?B?UXk2eXBRQllRY2ZDN0pWQVk1bTNXM3djd1JuYlZ6YzZZa05BcEljbi9uc2Y4?=
 =?utf-8?B?SUhVUTNiSFdzOUdyL3RPZGxDdVk5RHNFdEF3Q1kxdjdrS1paQS8reXNFTURi?=
 =?utf-8?B?WEg4QVEyTmdseEJVZkhHelhBTU9iYlNSWnZrbnFqS1FkSE5JcWRhaElCQWpY?=
 =?utf-8?B?c3FiMUZSa2dzVGRkRlB1VEFvakRRZ0gxc0Y4WmZraFNOcUtsLzZ4V2pPbk41?=
 =?utf-8?B?L3J5Z1pTS1hSdkpmZEc5WDc5OUQ3YWJ4RUxjNjJrYjYvdUJvWjlCZkdjVFFK?=
 =?utf-8?B?YlNac3RCbStENThQNzhhTEU2bzc2QUsrdFREdGRnYmxSclk2TlFGU2c3RGVx?=
 =?utf-8?B?Uk5pNktNL1cxcmQzL3hNdVhWQ054Um5KUysyVVcyMy9EenlLMVk1MXFzNjVj?=
 =?utf-8?B?SzZxdytxQmxMMGphYjBBTVJtY3k4Skl0eGlLUkdoTVFCaERyY1JtcWtFdE9H?=
 =?utf-8?B?UmtrK0ZoaXpFR2lCOXhZL2dUUnh2U0w5Mjh0ZSthSzREcTRxZlp1cHFIQnZF?=
 =?utf-8?B?MWtDM0EzaGZ2VXF3eHh2SzlZSzc3ZS9JUjZXRVNrYmFId1RFNkdVMVNSQjZD?=
 =?utf-8?B?MzdnK3BZaVo4bFZkVEF5dE1RcU9vVytMZndGazRCRzJ4Zm45UnZnb1VwS3JI?=
 =?utf-8?B?clBJdFUyVUphS2UvendSYld5TDEycDAxWFNad3VLTnM3RHRrQTkvcWdCUmZT?=
 =?utf-8?B?NFBreWZqdmNPWkNHb0dSTmhGcDJwMzNWYlQxRmhHL3BkRnJ2Vk12RG5KVjI1?=
 =?utf-8?B?ZkFoT1FVekFoOWdjSW0xdmY1UEpoNGlaclRJNmw1OGJ3NWsybkNBN3k3SFVU?=
 =?utf-8?B?UlVJc0phbVMrb0l5Q3pUeGQ2T1VDQ3IvNHRGNnJGdmZRYU1WbkhxY21kdkh4?=
 =?utf-8?B?dU1VcmRmOHJGMjdrcEVZOHludHQwWjlEMU11cmZnUEVOeDNKbk5vQXZDU1JO?=
 =?utf-8?B?NmgvRDdld04xeFdzV3FCbCtNREdzUWNPd1Mrc2FCd2Q1WHFXWmZKcGNTbUhU?=
 =?utf-8?B?cXkweFpGZWVsK1NUdDZVc3lRVVJpRzZFNmErRTFaanZGQVRJVExPdmFLWk1i?=
 =?utf-8?Q?dz0yWFQ5EI9a2WGCoN3OCMw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d514b2e5-117d-4ee2-68b3-08dc8fb29b29
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 16:20:45.1911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gFtNCdl4V1wcEjZoRyRzhIy3vFwZDYDDZLGAKlJ7VFZekwvhlDclUsLKjTHtJf5X0vj8GvcYkRoId0a6KgZRmoExSOd9TOCEacoKt3rTx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5866
X-OriginatorOrg: intel.com

On 6/18/24 18:01, Jon Kohler wrote:
> Add .get_channel to enic_ethtool_ops to enable basic ethtool -l
> support to get the current channel configuration.
> 
> Note that the driver does not support dynamically changing queue
> configuration, so .set_channel is intentionally unused. Instead, users
> should use Cisco's hardware management tools (UCSM/IMC) to modify
> virtual interface card configuration out of band.
> 
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> ---
>   drivers/net/ethernet/cisco/enic/enic_ethtool.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cisco/enic/enic_ethtool.c b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
> index 241906697019..efbc0715b10e 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_ethtool.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
> @@ -608,6 +608,23 @@ static int enic_get_ts_info(struct net_device *netdev,
>   	return 0;
>   }
>   
> +static void enic_get_channels(struct net_device *netdev,
> +			      struct ethtool_channels *channels)
> +{
> +	struct enic *enic = netdev_priv(netdev);
> +
> +	channels->max_rx = ENIC_RQ_MAX;
> +	channels->max_tx = ENIC_WQ_MAX;
> +	channels->rx_count = enic->rq_count;
> +	channels->tx_count = enic->wq_count;
> +
> +	/* enic doesn't use other channels or combined channels */
> +	channels->combined_count = 0;

my understanding is that effective Rx count is combined_count+rx_count,
analogous for Tx

and:
uapi/linux/ethtool.h:547: * @combined_count: Valid values are in the 
range 1 to the max_combined.

> +	channels->max_combined = 0;
> +	channels->max_other = 0;
> +	channels->other_count = 0;
> +}
> +
>   static const struct ethtool_ops enic_ethtool_ops = {
>   	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
>   				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
> @@ -632,6 +649,7 @@ static const struct ethtool_ops enic_ethtool_ops = {
>   	.set_rxfh = enic_set_rxfh,
>   	.get_link_ksettings = enic_get_ksettings,
>   	.get_ts_info = enic_get_ts_info,
> +	.get_channels = enic_get_channels,
>   };
>   
>   void enic_set_ethtool_ops(struct net_device *netdev)


