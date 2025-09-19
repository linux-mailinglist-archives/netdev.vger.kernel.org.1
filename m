Return-Path: <netdev+bounces-224793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F791B8A63B
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 17:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31E571C8476C
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 15:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C4B270553;
	Fri, 19 Sep 2025 15:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ey7Smg5r"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78964314D33
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 15:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296889; cv=fail; b=CmWCKwhGlgU5WS9MrxqNFtfE+0WrAacvPqLW7/+jFHad9GYT1fiMHXOUHWdCJKNP38dW4bEsFniKw/fKYxkGjJfPTsFI1hfHCER+ZTEcstZ3Rib5B7kaTdwl3tWWC9WahaakR0UffN4MUv5ucHlXgfUP9v4PlxOxxjqjU+U18cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296889; c=relaxed/simple;
	bh=t9j8tzLC45Z43KL3Bhp+yIHcuZlfOxPXvLioFQYRdAA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H2/AbbefQ2xGNA42wUq0PMRqLXWKcp7qGfcPscUygfBTuwhQFgiNL1o5XM6dGr70zHIgTCrNooPUH0Lm2aI5rbBMeg1kv4sdCKk2BeU7Eam3M2sezkNm1jcyCZVbKrYnFxyKA0NmXofjLtPu8X6tkdrbxmt2+lWGMBI/icsZT34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ey7Smg5r; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758296888; x=1789832888;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t9j8tzLC45Z43KL3Bhp+yIHcuZlfOxPXvLioFQYRdAA=;
  b=Ey7Smg5rxx35oRMm7Vn5L3N5ujkunCFdN9BnXxJ7sAS7FNVolTedcqlH
   hQpfoxd1rQm1bFPbOqie5OT4NTl2+vk1rrZztSZL9G/PKPBjtCVHoFVSx
   a6U6rTYJvVfhV5MxKcoTK7V8X63XGau/nrI2U/f6JaENmdwqS3NHn3BD7
   yK9tLktxOiWzpP0v5N96dg79XWGobEGW5MaBDbn22Cx9y7DNsNTOwP53W
   vge49MvbuWr/Mx9y+hGSfw12vltgcTHMLpGZ9re69KXoxVQ0A2wTN1+HT
   qJJXtYUTpIVoj5csI60Tr8HcndZoTtTummUHzLTmXHho8pCp4zbBBjH/6
   Q==;
X-CSE-ConnectionGUID: er7NgHS2T+KG5P+fL4xksQ==
X-CSE-MsgGUID: pGgIvMa8TN6sWIu+YEWzTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="60533413"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60533413"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 08:48:07 -0700
X-CSE-ConnectionGUID: W9l0Ml0kRRCccsg6dKamhw==
X-CSE-MsgGUID: xZU3XrpcTpi08FaU/ejtcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="206609336"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 08:48:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 08:48:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 19 Sep 2025 08:48:06 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.4) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 08:48:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tninechkOgjyZX/WZKc/MVLkhwWE7KN76J7rccWuqZINNono4WereQWMm0KL+OTxI6DjVbGIMRUTP+kg5FsbqbqsCREMGxRsDP+LmALqO8vDEI0cjiXCduYdf4OTToXAk67XHw4c4uKbt357Kj/i7MFL5AKQKPobcQUT8ZcmJ9PG9uAursbNyTl7wX2utZVugK4d+w72fB7RxLo21/Q1XS0nh6T1Bd8BqFhWipdRUtHI3G95Gmcg9EMa4/d1P0/FSJqisYRAcfFHXlZApFRSrWbUGZRDunSjuwCM55ZwvZYX3d8+MOfm1aiFlKMPM/u6kcN3m1VQNAjzIbayOlBCfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnYS9WtAbN0BQJJj+4Y42SBIjfekIQrFWj9BkrRE3WE=;
 b=NCShL1KJ0HFi6C6JQlIZuB6I2DbLDjwsVseRGc8NC43+hsA6f4UGjizO72yfMOB1cliAD9f1VNdDqiNoWbqdbu1qenRN2FZxOCBb48G3yKUdjry6SVNoOaIOHTAttn76eCBObcafN0GBpPhNRDDBWTpritjfss00d1nQGZZFeLdoT1czVvKLFaPkfgpMngvGx2kCWebtdshux0EjV2ln4G41YO6L2i9Xq6vphqTIusj9vuPvZ2Ogr8vTuXBKsZFudupvUuC6N4/9zy+Deg9vNx10QTDn1VCoqbbLoslss6sdO3JZKYLzV4scPw3pl1EElWlxAGK/U2amn+I1YQKQoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by CY5PR11MB6281.namprd11.prod.outlook.com (2603:10b6:930:23::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 15:48:04 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21%5]) with mapi id 15.20.9115.020; Fri, 19 Sep 2025
 15:48:04 +0000
Message-ID: <e9fe2d3b-20cd-4e22-b14e-f395c483edd0@intel.com>
Date: Fri, 19 Sep 2025 08:47:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next v3 1/4] ethtool: add FEC bins
 histogram report
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>
CC: Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"Carolina Jubran" <cjubran@nvidia.com>, Donald Hunter
	<donald.hunter@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "Gal
 Pressman" <gal@nvidia.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Michael Chan <michael.chan@broadcom.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>
References: <20250916191257.13343-1-vadim.fedorenko@linux.dev>
 <20250916191257.13343-2-vadim.fedorenko@linux.dev>
 <IA3PR11MB89861635B2B78A559A8EAE12E517A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <6cffe63f-4099-40f7-afee-3f13f1464e56@linux.dev>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <6cffe63f-4099-40f7-afee-3f13f1464e56@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0222.namprd04.prod.outlook.com
 (2603:10b6:303:87::17) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|CY5PR11MB6281:EE_
X-MS-Office365-Filtering-Correlation-Id: a462ce61-307a-4b06-775d-08ddf793eb2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHNYQkJPZFk3enlWcVZEWkpxcnFVQ2RhTXVuMXlkQTdKN05HbnhFOWtpZ2I1?=
 =?utf-8?B?OVRwdnhxbFhyU0JDQVVHWjdGeUdldkloTXNkbW4ydE5aSHdydXJtaCtLZUxX?=
 =?utf-8?B?UjJKRmhURHN5TDcxQ05vYmh1akNxWXNmZDhaaU04OFUvVjY4T0VPK1NpVGxj?=
 =?utf-8?B?Zy9nRlpwcXZnU01xRWdveTllZjE0QldxUktBd0p4dEVNUEVTaHN4dUJMd2Rh?=
 =?utf-8?B?WStKWDd1TkZlc1Mzc2dTSVpiMCtOSzJNcTFtUnROc0w2aG5PeDJvYWpmZlZI?=
 =?utf-8?B?ZWpIQ09pTmNoTy9FSVJGOTBVdkphSExYSHJXNlJoakZUN2FDcGNkb2hQbHB0?=
 =?utf-8?B?dG5OdHhKRzZTOTRNY1lsd3F3bGNxKzJpd0V5U2YrUWRMM01UZ0NKLyt2MERX?=
 =?utf-8?B?dGdRbnV3Rjhza254RG15N01XcmdUQUtwdEYvUDdmZy9LV1BKUDFzc2tPdjBG?=
 =?utf-8?B?NUJLWktnZVNUZ0RpV1ozR2RiQkdaQ3M5b0IzV0R0YnVWY1AvSWl1czN5NzFE?=
 =?utf-8?B?ZXF2MHRadHVOcHZpMk1OdXFmdkRHSlo4OGtRZUhRcHJiUlhaemZyeEpNV3Nz?=
 =?utf-8?B?MFRTUnV4RGtHQVhKMkplY1NIczMxK3VSa25aSWNjQzRNQi9paTd2SkNaUTJK?=
 =?utf-8?B?RlIyYjd0WGd6bXZrK2pCODNvV0kwdlBpVFgyTDgwRmRLRTR3ck1TaGlsQThP?=
 =?utf-8?B?Mk8xRjVtV2R1b05LTUh5eGQ4eVFtUC9ubE9OdmF0aDhENmVXMG5KM0t1bzJL?=
 =?utf-8?B?cUpxOHFHTXkzSVpCOElPZDBWOXk4K3lIM0xoSVpWTWlUWVRQV2dmK0krcmN3?=
 =?utf-8?B?cUowL2xNS1czc24yVHBHeVdpSk9tandIQStGRGYwVEI4b1NxOEFuZWE4MHNx?=
 =?utf-8?B?cE5hOW83a3V3YkdjZ0twNmc4aGwyQ0FlK2NPVk5uNituUW1kRE5PeXU5dlZw?=
 =?utf-8?B?bytLU2ozek40dXh6ZWZWRHJlV3pJTUVkQ0s1amRnQnFXaTNza3ZUazEzbk1q?=
 =?utf-8?B?MUFVMkhDSHl6Rkt4NGJPK0loaWY1OGZMSjVmWlZ5WkhFdWYzbjJ3V3hYSWVL?=
 =?utf-8?B?eHM1VGNLZ2Rkd0dNczE3Z0ZucUwvVE50VWpROUd4dHg4YVNrcTdGTi9MNUkr?=
 =?utf-8?B?VlJzTll3S2dENVF1N0I5Zmd3MUNMRVF4UWgvdXFMRU5uS21JdFJJOE85M1U2?=
 =?utf-8?B?Zyt0WDRMK1dIREk2eGVJWDIrY0FIRUtKMXRObjI5aWRlZnZvVlFVMUJTUkpp?=
 =?utf-8?B?S2ZjTVJLN09NTkNVOE5JbllTTjczTk9zUmtpWlYrRnN5bUh5OTNJYzRpVDFN?=
 =?utf-8?B?aUtZTXE3ajFnQm96UkFGQjF2alQ0TWJib3lYbWFGT0RvbTB1K2tHTytNMVlK?=
 =?utf-8?B?YzFGdHh5N1d0NTZDbDk2OXgyN0hXS01GVjFDRkJhUFVEaThPbjBzMkxvNnhz?=
 =?utf-8?B?azBveGNqMzdUTEQvQTRxdFlkYy9md2RyR3g5VGJlQ2xxa241MHpLbVJWbXV5?=
 =?utf-8?B?L1AyVjhSRE1TVVVuUFFTQUQ0TkMxN2hENWRsQWhDVWtTV1lJS0VNczNrWEc1?=
 =?utf-8?B?aFVMaWN5VUtuTDNKc2FRZmU2VXNlMk5TRlNTYkhyM0F0MTdLOHg0VEgwRStk?=
 =?utf-8?B?UDNWRElEc3FTdWNnWEhYelVrWm1lTUllU0wxY0ZpUm90NVVpYmJHTXlCQmVy?=
 =?utf-8?B?a0Rzc1hsSU8xKzhwbWFzZUQrRVFEWkVGanJCeDVWUXVMdGJEd0pHZ0dQcEZI?=
 =?utf-8?B?VXRoSTY5cTQ0NDdNejh6N3hMdjloWk4zR2xjKzVsNUdOQjNpNXVZSm5qb2lL?=
 =?utf-8?B?Z1EwQVhhZmMwS3M1eWJwUFNjejg4d25jR2VvTHUwSFh4cHBUNHZ6b3V4R1FS?=
 =?utf-8?B?bEd2ajROWTVCbkJFQVJXZTNKU3VoOC9vVnpjNnRaZTc0M25TazhWZTZWNHRO?=
 =?utf-8?Q?skpj413nWYI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUI5MSsvWFJxNEtCTFRBSThNMW1laWtGZVRJRFBUdm5qQXl5QWFiSE93eUg3?=
 =?utf-8?B?RTFPckdsT0pSUG1DRXkyTDc1VTNNQTFUMmpRWWRTeHczS1VjMmwyQzlVaXBm?=
 =?utf-8?B?bU9kSHRCYWJEQzNwaUx2ZFhEMy9QbXIzZG1GVkZKTkRvbWNVUldRdUcveXZV?=
 =?utf-8?B?elR0UnJpSHdsNnVSUXpsQXVZM203NVJXb1NrYjNNQjNsTUp6bEo1bVVMS1Yw?=
 =?utf-8?B?MHRjZmV0d3AxVjlwOWtoQ05SWm9RS3FGUm91bkI2V3ZBOHd6cTF5MDQwdFY5?=
 =?utf-8?B?ODRkcVlQMVJldkg3REtlUE5BRTMzN2hHY2orVW96YlNGd1cyRjF5YUFrVkdm?=
 =?utf-8?B?MzVsOHZVY3BGN1RObHBiN3lxUmxUeVJ0S05MUFovTUVTcU9ISjNiZk93UldH?=
 =?utf-8?B?MitCS2k5d25JNVhRdEVpU1RjREowYkd4RCtuWlQ3dVhGbmcwNEx5M1NZWWYw?=
 =?utf-8?B?WERCcUZ0UklFWEVibUtqVXdRS0ZvcG5jVHdidHdKMHE5OGJaTmwyTVZmYW1s?=
 =?utf-8?B?bU54VS9FWFdsR1B0OW0vUldOdmkra1l3Y2svVm1MMU1oZUpTTHpQZytBVjRk?=
 =?utf-8?B?YndOdWxNK2RXY0ovck9xV0VucWh2S0JHekhEaXE3eHdEa0ZtZENUazhaaTg2?=
 =?utf-8?B?RFYrRURNSmpyVW9QcHloY1hVYjV3S0RXazZ0VDJ2STFGMHo0b3h5U1V3Nk91?=
 =?utf-8?B?WE9tR0dEM0xtV1A0STdEQXJRS1ArNjgwM0ZCV243NGVmVDJjUFBTaFdxays0?=
 =?utf-8?B?M1RQNHJ6OUZ4ZDhrbWpYdjNmSzVTVUlOcHJOVS9XM1NSTFVLOUEzU0hRSHpO?=
 =?utf-8?B?T1N5RUFHU3dYSHF6TllGOVprTEEyVlE4L1FwTEd5cFQyUlhnQ3g2QVhIM3N2?=
 =?utf-8?B?ZmVpcTdKQzFZazFpYkpCNWYxV3BtTlFVVFhtRUFhVmZKZkFrd3VDY3VUbTBs?=
 =?utf-8?B?V3dBR1lPNWtHSjBVS1phQjRIbzMyY1dreGdhR1oyNGFpVks3V1Fhbm4yckhM?=
 =?utf-8?B?TURSdzREeDhmYk5rc09hZXdEVkdBejloZHRVNG1Oc3luUUp6dS9EYVllalha?=
 =?utf-8?B?WHN1b3QrU3ZHQ1daaFBNSVJrQjBDZWRDKzk1Szg4aVdwVU1FSVYyenJjZE5H?=
 =?utf-8?B?YU9DQjVML2x1bnNSK041T1JZQnEzMit3Vkt4VHlqTllKTG1BZVFEWEhZOTFh?=
 =?utf-8?B?MUhCK041UFhhZ1l2c2RjTnhPZUFuSW9zdElHWU0zcUZ1M29WRXpXUi9VYzJ0?=
 =?utf-8?B?NXVLQkJUQWg0OW00SGpJbUx0Ui9RR2F1MmZqZEhDd1Q5T0ZTa09zL3VJVDBp?=
 =?utf-8?B?MUllWldKSTFqKzFENHBSdWNnT0JlQWFVODBNeS85TUVnd295aHZNZC9OZkw4?=
 =?utf-8?B?OGNPNWZ5bndZb016SUpKcE9HUitKQytHQWxIS1duZit3ZkJmbmRHYnZvdTdC?=
 =?utf-8?B?blYxbzNnOFhqcWJGZm5va1ZjSWREQ01NclRQalFuWlVnOFg1SjZLcFUyeHJW?=
 =?utf-8?B?WVhqdTl3UUw1cEl1ZHNjNmdLS0xiRlFzY254d0pFZVFOOGZ2R3RzWUwzaWZv?=
 =?utf-8?B?REF1MzJvWDYvZnJlVmtOY0gvMk9MYVJ3anZpMm91TDZENkxaVld0eUxPTVNR?=
 =?utf-8?B?UFFwL0pQUnM1UVhnM2xZL2RjK1JmSHBvejZOelhvdnBaZ2pDeHcxaVZFV3R0?=
 =?utf-8?B?Vmh1bE9SVWNqTWZ3WVFzLytBWHY4R2dMOWR2OFBpWk5xTkc0YzhGRXE0Rzcz?=
 =?utf-8?B?TGVuMXdUV1U2cXNicStFaEFpUlJ0NW9NakR4NmlDSE8zR2x4QUMyVFpDMXZF?=
 =?utf-8?B?aW9SN2JLNG1kZWJnUi9GUTEyRDhUR3Y5Sk15Tk92V0J6WHE0Y2RZQzRtMG14?=
 =?utf-8?B?Ymh0ZzM3YUVJRzVWeENuN1h6RlRXWnM1S3ZyT255YzFFck14TmEwbzdQRWFm?=
 =?utf-8?B?amVQcUljS29jNzNwejgwaU53TWNZT0NLeG1ZOXlMaEcwbTVOVERsV0MyUWZy?=
 =?utf-8?B?dnh3c3g0NExpN05NVGdQQnhnTXBRVXF0RHNibmVYSzVBUkpReS9MWm1ibStJ?=
 =?utf-8?B?T1c1c2ZsK3hNWkJJWUZHbzdDOFZ4MUdTOW5mVGZYYlNPanAzUFdrTEs3QlJj?=
 =?utf-8?B?N3p5WG5sYU52dmFVdzVaKzE2SjdMQWNMdUZSQkxjWUxFak1ETFFackRkUmZH?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a462ce61-307a-4b06-775d-08ddf793eb2a
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 15:48:04.0103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oWXtw1GrLdx3ORV2QrZKc9p9MaQfE6yu3wGXpmlaU/8NCklMROXkTkrF7qtI3EpZMXJpQ4ogmvO20U1pM/sWAnkVyrYfR2WYtWQxqFaeNtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6281
X-OriginatorOrg: intel.com



On 9/18/2025 3:58 AM, Vadim Fedorenko wrote:
> On 17/09/2025 12:27, Loktionov, Aleksandr wrote:
>>
>>
>>> -----Original Message-----
>>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
>>> Of Vadim Fedorenko
>>> Sent: Tuesday, September 16, 2025 9:13 PM
>>> To: Jakub Kicinski <kuba@kernel.org>; Andrew Lunn <andrew@lunn.ch>;
>>> Michael Chan <michael.chan@broadcom.com>; Pavan Chebbi
>>> <pavan.chebbi@broadcom.com>; Tariq Toukan <tariqt@nvidia.com>; Gal
>>> Pressman <gal@nvidia.com>; intel-wired-lan@lists.osuosl.org; Donald
>>> Hunter <donald.hunter@gmail.com>; Carolina Jubran
>>> <cjubran@nvidia.com>; Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>> Cc: Paolo Abeni <pabeni@redhat.com>; Simon Horman <horms@kernel.org>;
>>> netdev@vger.kernel.org
>>> Subject: [Intel-wired-lan] [PATCH net-next v3 1/4] ethtool: add FEC
>>> bins histogram report
>>>
>>> IEEE 802.3ck-2022 defines counters for FEC bins and 802.3df-2024
>>> clarifies it a bit further. Implement reporting interface through as
>>> addition to FEC stats available in ethtool.
>>>
>>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>
>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>>
> 
> Thanks for the review!
> BTW, do you know if Intel's E8xx series can provide such kind of 
> statistics?

Hi Vadim,

I'm not finding anything that suggests we have this information 
available/accessible; I am checking internally to confirm though.

Thanks,
Tony

> CC: Tony and Przemek as maintainers of ice driver


