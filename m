Return-Path: <netdev+bounces-229768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1288DBE09F2
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 22:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BC0019C5386
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 20:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A84F2C027D;
	Wed, 15 Oct 2025 20:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g5qaeK2i"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC691DD0D4
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 20:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760559818; cv=fail; b=Xghf8PXwBFod8VRifGT1mgUY6Q9jSES1fHpAlMZ/GEDCS9VzfBs3Z3A6GcCEvDctJf6h+A1u+NzfjA/4bEiyfdyDhB5cBASJP8xEYBZt8W9t7G0A13BpXOMcakgu9uJlTp+2x9NCvnvPHzUl/db/R9/281E9EX2VMEAhOIrsSWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760559818; c=relaxed/simple;
	bh=AGWtjabTyWlp2gRVabQpAFkHhWjSLI+8OUaMKh43WIs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OGJGm3WUyralwq+UQg/Hu0e3eBC6IuCSPHNvyWwuXDQvzJ12sj+gn2MAkcexaEmqpcnTW0zh2pcyDZk+9f7QRXEkTM0v9KhU7cH9dskIeOWNmkj5t/Dkco6OsaeVcxtmBK+TthrdmiM2R5QdENdJsZXs5E5n4fv3wtbvSFvp5tI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g5qaeK2i; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760559817; x=1792095817;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=AGWtjabTyWlp2gRVabQpAFkHhWjSLI+8OUaMKh43WIs=;
  b=g5qaeK2ik+x5WVf/MqR2fhkw4BYU8m5sdbr1xZH1O6Yih6WxzwHptpeE
   iZvA7MuCRUoKGuYWHMEuVhhBLh6HCZjvZhepjzV7eM0alUZUDyltl4f8w
   nA5kPBXPknfQQNIMMZaRIXPE6OBfK7gm04VKD+3Qe9c54hVClD3YNQr2U
   7CMNhDpxqeHu3SH9/+Crn57NZEXhxt65mduxewxmyKWIpnh0yGosVOwqq
   n8qxsAiUZ2lE6w7ztniMf0Udhqw2FuqqeqoiTEN84XAV21ZCvRHjcKP4A
   O0oEgA8dBM+1SU9kzqL63+F+jMESvyvTaAuz/Ql4uwpE+yps4NLy8dZYv
   g==;
X-CSE-ConnectionGUID: 5RlCMIGMTn2INUZ8mROpQA==
X-CSE-MsgGUID: Olno4X7sQdK94YphQIYN5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62675990"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="asc'?scan'208";a="62675990"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 13:22:23 -0700
X-CSE-ConnectionGUID: FLp6RUXITvGB8vZbH8bHXQ==
X-CSE-MsgGUID: x2SnyZfpTKypstiTqKLEUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="asc'?scan'208";a="181404178"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 13:22:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 13:22:22 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 13:22:22 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.24) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 13:22:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOkqO/NU3yiI49F540FaUkd/LNvP0Xmpgyapb3Oa2xoS73xR3Ipu4qkDZCR01N69z9wtkX4RQhDI/Xpo4t1NaRzJ1d7w08QTv9pKZp2Vrimk4U13tpQUjmFbNGmUvuiHhUsQlzlEk+cTKf23tt2iewnMXdZn5y+NPco8cht/BRE0+4/oMBPMoiSM+xmNxUmLQEu6orTiQjXunXjUAfXA76NUfDZIpOPxmeao5p9842LJ/OtotaRnBzT3SjSybY+ZJrz0vkhSDFzBcEfi49udI0FiNpztkveCLGC5qCfHigvTZT6/8TI3Z2X8HXMbpm98rVFH7f18DwL+Z9tgQ/riMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ao5AfviDOFO59iXyyMDoyUKjm0OsPOYtuJ7nsDJD7Xs=;
 b=A6EYsTAOxruTzEmBefoUePoKWl0w0lLElM0DAoGHmWfWtQkDJrZjUiQCTUmLWViZTmy6Lofg85Ryh1b4Bc/tMKrS/kqCT+RXSxfi0ypkXVmNigohKUDpCk2mcQ8T422k2sVpePemkLeaDfLPgX8WHfbceQDHRW4Y5kJvWEugTPsxEg5r19ZndVq/D1zzEHbRELtbp5U5PS9JZgeQ4GOrQix9NzgaNztoj3LKwibzf70+suNBvm9pUbXp1hQ4eS9An+kBmMgrwvzoF64Tl+/YVU7m4I52ednW0amHpfoyysPwcHTeEpwnpC9gH4PHl3Cqe1Bg7zd4rx6NG5omeGqwnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH0PR11MB5297.namprd11.prod.outlook.com (2603:10b6:610:bc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Wed, 15 Oct
 2025 20:22:20 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 20:22:20 +0000
Message-ID: <d7f85aa5-6edb-45b2-9c8d-04874b720f8b@intel.com>
Date: Wed, 15 Oct 2025 13:22:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ethtool-next v2] netlink: fec: add errors histogram
 statistics
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, <mkubecek@suse.cz>
CC: Jakub Kicinski <kuba@kernel.org>, <netdev@vger.kernel.org>
References: <20251014212018.7933-1-vadim.fedorenko@linux.dev>
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
In-Reply-To: <20251014212018.7933-1-vadim.fedorenko@linux.dev>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------7O4yfYi7FAInBkvCgTffhZAO"
X-ClientProxiedBy: MW4PR04CA0091.namprd04.prod.outlook.com
 (2603:10b6:303:83::6) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH0PR11MB5297:EE_
X-MS-Office365-Filtering-Correlation-Id: f4c226f4-fdaa-44a0-58ea-08de0c288b12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWdrTVVJbC8vMk5WWHpCalRnaVRRVFpLRmlta3FseDFkVXZoWld0THR0OWZr?=
 =?utf-8?B?SWdDcmtNSDMvejFENnBmYzN4YzNGQk1YQWxtUUtGOC9HL2FMajhUeWd6RVd5?=
 =?utf-8?B?aGsyR2NhckVJUXlCeWpUOU9aRjdQWEdKcStpR0FGcjRJUVlUbEoyOEsxSXV4?=
 =?utf-8?B?OUpPV2Rkak5YWm9YVkpNd1M1OG1hd0pQNjBhamVrRkt1bFJFOG5HbEJmdmFo?=
 =?utf-8?B?Z1pYOFNVVnNrYWQzSzEvbFgzOFBZSWh2bWJyTTFsZU0wMzA2ZDJXakd2SW1s?=
 =?utf-8?B?UFdoSkF2SmYxUUpteGVnZVllQjJ6KzJDV0E3SmgrZU12dlo1a2lJYjJUT3ZY?=
 =?utf-8?B?L2lrWk0rYW5WWDFHQ2lYdW51VmY4SnoxWlpWZHROU25NTXZJZkdDTXBTTXpF?=
 =?utf-8?B?SWZWRi9mY1NPZ29ZdUVaYUlDYVJrTVQ4TGlnKzV4K1ZrZW1PK3RtYmk2TUFJ?=
 =?utf-8?B?eFRqa2wxWnMyVkZxM2RSWUEvb2xpWk4rSGx3T25UL2UyWFU0amFwVmU0MWE5?=
 =?utf-8?B?UkNCYUFQTWJLdzBlNkh3UVJyay81M0JTK09EeFRoSUNxWk43RS92dmFFVStM?=
 =?utf-8?B?Zmg2SjZVM0RsT2x0cDBkYzhyMzhkazVHWTIwUktlRnl6a2dkNnN1ajhPV09V?=
 =?utf-8?B?UzBxd1hMY2tYWjBLK3M2TytvbW1pRHBhMWxZU29vQ3VQRHo2NkZFamo1V0xp?=
 =?utf-8?B?Z1ZRZUYzYXdGNldqaTBXa3pUSHdKNmZjODBoOHpkbHVhdURhU05JajJYN0hZ?=
 =?utf-8?B?N2V4TkdZM1lFSmxlUytQNjdwbUlja29Ca0dYUUx4Wis4KzNrWTRCdHRQNVVr?=
 =?utf-8?B?bUJvdzNGU2Rndi9seXZBcUhtc2ZQQXBCeitSdDBJM01WellNOFpZTDNORXYx?=
 =?utf-8?B?N2kyU0Rua0dsMnN4Zyt0Rm9rQW9acExkU0ZRQ2ozZXZMbEp0RUUwUUlDUmN1?=
 =?utf-8?B?QjVBTzJEUjkxRDQwMkxJUks3TXhoaE5LNFZrbWk3SGFpZ3NDWGlWYnlIMzR1?=
 =?utf-8?B?YmhGU0wzME4vOC8yVDhFVG9ObW9pTVh4NXpBcTB5Rmh6dlFJS3VmOHFzdmRx?=
 =?utf-8?B?KzFpdnVxV3JKZE9OanRXaTF1Q2RVZ1lQdkxBei9kM0huMUVjS0JQaFE1VnAw?=
 =?utf-8?B?V29UZUpKdkduT0lBSStBU3RPMEhELzFyNUg3cytNUjVOeXo0TXFoSFV4VS9o?=
 =?utf-8?B?UWsyNG1JZ05SV1hoOTNHcUpoLzJxaG5tRmFRTndJRVBEeTVjd0JTSmI4NlNp?=
 =?utf-8?B?SmJvVDQyYjkzdVpHN2o1Q2FnUUFLQnhISnIvcW9tL2pQM1VxbkE0NmZya0Zv?=
 =?utf-8?B?SjNCcllBVTgvc0c5VERLWlVjU1ZhdDU0UllhcnBueXgzU3E2a2tCUDI2VXdK?=
 =?utf-8?B?ZzRVcnhoSnpqTjRCbS8zQW1SVkZTekRCdyt2eE9Rc2JNcUUyWVVGa3hVWHI0?=
 =?utf-8?B?cGVhQ1RnWEpEaEgyNU5UbndvdHkzZmE0MlNZQjExOWtDOWg5YWl3QVB2bnY5?=
 =?utf-8?B?bURodjJZQ2NWbkFCSjg4aUNpOGRzSVJCeDZvZFJzQnJKeGphUTlHRG0xWFB3?=
 =?utf-8?B?bC9rOU1yVVp3T1Vld0l6dVlreDF4eUwzVThpNG9mM2FNQS9kdkpnbnBnRnVw?=
 =?utf-8?B?czJPK2F3K0VuSWRLdWMrNVBnVEMrVkJ2K0J2ZndhS0V4am5mZzUveWo1Q3FF?=
 =?utf-8?B?UEdNQkx4WjQvWHN0SS9SSHNXbUVpVmU5MXVoOE5jK2tGS0JCekNwaVl6N2dU?=
 =?utf-8?B?dUhLR0pCZU5EdUd4Y3VJcWU2MnZXc0tpNUZwZkl4WXd2MGd1eXJVdTJ0ME1W?=
 =?utf-8?B?ekYzYWpUTC9WdmRuenQ4YmpjbUtOMVJLaXNLOE9LU0cxYnpRK2tUMVl0NUsw?=
 =?utf-8?B?cVNCcVpLSzNxNWFJazMrNU9TMDlDa1hvdmhwMXFWNndvVnduU0gzeENFcFB3?=
 =?utf-8?Q?mn/X/tDhdJq4OLBytgHl/7FjZE1rNjgG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STU4aWY4RHNmbXkrWXRMVUhiSmdNejBNUzlEUU9nWkNyNysxRUZ3aS9sVlMw?=
 =?utf-8?B?U0hQNG9VNTM0QTZXZTNSTUZzL20xVlZDSSs5UXU2eEhjbEF6SktXdHYwZlMy?=
 =?utf-8?B?TDlEZ2U1dDRBSjNVM2t4MGVBT1JJSzNmZlVLNnJwZENuQURQVlhzajAreDJp?=
 =?utf-8?B?c2RlVENBRGpHZXoxVkpZTHl6WFM0cm9oSXUzZzN3QzUzRUZpNVo2VGRoZG9B?=
 =?utf-8?B?UW9JTldKNkJUQmVuVXpoa3JUZFZMOEw1TThsTXFralBTTGx4d01mZk16cjZH?=
 =?utf-8?B?bjNxYnFzUDlXWW1sV0wzRGVuSExNVkpITHpQRk9JbnVmbnFDTDZvRHIwbW43?=
 =?utf-8?B?cjhRc2dab0pvZ2pEQUE0V3NXVDFZYUdTZDNmMlJ1cjF0KzZmbGJ6RFA0T0Fi?=
 =?utf-8?B?a0V0VDRWc0VMY0Urb2wzbUtMdlp1bzNLYU9YWFFhVWl6S1M3ZnV0U3IxVFY4?=
 =?utf-8?B?M20zZHlFYWhXaDlrTytOLy92TjJnanRYS1orSGhQVzhQOWp3d29kN2NlRlk1?=
 =?utf-8?B?UFJLNy9CMFhUSHJ6Mk5KWVlHMjY2MWhXZkw1cXJ1VjM4WGZVUGROUGVFalNl?=
 =?utf-8?B?eDJRR3UrZW0yV0ZHUlp5SGZVQWtCR0xXWU1sdjdlaDhuZ21lczFVQitIa0t0?=
 =?utf-8?B?RER3SE54ck9BNDUvbHpycVpGdGNMK0RqZ092OGlmSVNmVWZLbmtha3RWbEpp?=
 =?utf-8?B?V0twM0RTN0RwR01rbnMweVB6Z2loLys4SUlrOG9hVERUWXlmdUhESXFCZ04w?=
 =?utf-8?B?OW5Odm5FWS94RUJVNVlCeW1rNE9zY2xLRUhCOXVkM1RuVkpJaEU1OEpjaFlx?=
 =?utf-8?B?dDhUOTZFUGtzSnBhSndGU2l5RlBZazUwNUdTMnBKUnptSkRGQU5JOHJXMFNN?=
 =?utf-8?B?MHRoMnRwWTR4b05JY2tzb1B4QzNmV2dkWDNGeVFtOUpDejIydEZOZmtRbGlK?=
 =?utf-8?B?ZktFeEM0cE5ZMVBVTExMS25laGN3OStMMDhqQjc0d2NJZTYwa1kxNFVRU2Q0?=
 =?utf-8?B?UmRHZ3l6dUlwKytjV2x1d25tcmc1MjhkZUNiYWg5UEFCZFIybnRsV1FWZDVZ?=
 =?utf-8?B?SStWNHRZTGt5Q3pOendEUS9QVHNoQzN1MDlyVThvQks3aHd5WkNzT3pxSDV6?=
 =?utf-8?B?WkdvbWt5UkdIUmllc0N6ZlJOV2FWOC9hL2JBTDkyd0FVOTZUOWIwbUFuMnNL?=
 =?utf-8?B?T2RQSi9sTDlvUmlQMk52OFJ5TjRIOTFKUW8vY3o0ZlZTWElEUkNuamRpQnlk?=
 =?utf-8?B?dEFaQ0NwamRUamI0b0hGY2RMSDd6aVNHeXEzMzg4emg5MGFJQjVOL09EUUNO?=
 =?utf-8?B?RGgvOUlXblIrRkNaU2w2WHp4RGdLUXRua1J2RlFYdSsyYWVNa3R6eVM2OHcv?=
 =?utf-8?B?ZU1JTi9pMWdDZ3JsV3d6bWxLb2RmYlNXd3ozTHhQR05uUlhZNXlYQ2VJWkZP?=
 =?utf-8?B?RHNGVHhqQzMrbzdmWHNPWDMzWVc3a0ZJVmVMVFVIYUp5WFo4YlN5bG5NTUM2?=
 =?utf-8?B?L3duYVZ1Nm00UnJjZ0ZaUzdQNE1VdTJyNTNkWHlNSzNDZGJGV0JBZVBOMUJs?=
 =?utf-8?B?WDlYTG5xMUNxc3JqM08zdmVRMzErQWVuRUcrdUJwL3Z4WjY2UkhJT05iYzVW?=
 =?utf-8?B?SncxUnVLMkM3TTE0K0EvRm1IU3dDMVJwRm14WTBqVThUNnh6UjJ4VWJROURD?=
 =?utf-8?B?Z0xRdTVXTit5L1hPbXVPOUhIR1dlTGNYc0R5VzZQV2VZV1Z2Z1F0djBVN1Rh?=
 =?utf-8?B?WkdoR2piTlkzQ2dRM3J5U3B0QlZ0SXhOcGlkWkorc1dYbHJVL2VSUEdqeDU5?=
 =?utf-8?B?THBuSGgyOGZnT2QvRDN0N2djdjlLeHVFNlpkdDVwR2dpNWN2WmtjSTlXOCs4?=
 =?utf-8?B?dGI0OUdmRjFmSmZLQi95WVpIRXNYeW9Mck5Ub0NBKzZrdmpra3MzSWVOakE3?=
 =?utf-8?B?ajBobHd6cXFWWEtvcGFDR2JjcEFoZm9CU01KaUd3bFk0dWx3SUdlNWNScjZM?=
 =?utf-8?B?U0c1VzZaQVBSVE1pMENzUi8zNlpUQytlNHZMVTNQdEtiK1NSQVFicmgrbEVp?=
 =?utf-8?B?K2p4WEg2RFBXRUU4ckdMMzVCUnRRbk1XaXpVdUk3Q0EvNXpSVkVEYXJYekd6?=
 =?utf-8?B?cG1NbHNCL1dOKy9zVFlwUS9MdUhnUXgwN1dpR0RXS3Zma2c2TmpKUVlpMVBh?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c226f4-fdaa-44a0-58ea-08de0c288b12
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 20:22:20.5494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YRoNafboBrS5mBA/c/RmCNIJg20vQBoLlIHfdwsBNGigab9QIkmMCMDsosR18dReJ1/ypfSLJ2R6/CcTzTJpfpnwReiIL1UJ/aMR2t4iDCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5297
X-OriginatorOrg: intel.com

--------------7O4yfYi7FAInBkvCgTffhZAO
Content-Type: multipart/mixed; boundary="------------9x62XZOzHQukFZFZDpMXicOd";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, mkubecek@suse.cz
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Message-ID: <d7f85aa5-6edb-45b2-9c8d-04874b720f8b@intel.com>
Subject: Re: [PATCH ethtool-next v2] netlink: fec: add errors histogram
 statistics
References: <20251014212018.7933-1-vadim.fedorenko@linux.dev>
In-Reply-To: <20251014212018.7933-1-vadim.fedorenko@linux.dev>

--------------9x62XZOzHQukFZFZDpMXicOd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/14/2025 2:20 PM, Vadim Fedorenko wrote:
> Linux 6.18 has FEC errors histogram statistics API added. Add support
> for extra attributes in ethtool.
>=20
>  # ethtool -I --show-fec eni8np1
> FEC parameters for eni8np1:
> Supported/Configured FEC encodings: None
> Active FEC encoding: None
> Statistics:
>   corrected_blocks: 123
>   uncorrectable_blocks: 4
>   fec_symbol_err_0: 445 [ per_lane:  125, 120, 100, 100 ]
>   fec_symbol_err_1_to_3: 12
>   fec_symbol_err_4_to_7: 2
>=20
>  # ethtool -j -I --show-fec eni8np1
> [ {
>         "ifname": "eni8np1",
>         "config": [ "None" ],
>         "active": [ "None" ],
>         "statistics": {
>             "corrected_blocks": {
>                 "total": 123
>             },
>             "uncorrectable_blocks": {
>                 "total": 4
>             },
>             "hist": [ {
>                     "bin_low": 0,
>                     "bin_high": 0,
>                     "total": 445,
>                     "lanes": [ 125,120,100,100 ]
>                 },{
>                     "bin_low": 1,
>                     "bin_high": 3,
>                     "total": 12
>                 },{
>                     "bin_low": 4,
>                     "bin_high": 7,
>                     "total": 2
>                 } ]
>         }
>     } ]
>=20
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------9x62XZOzHQukFZFZDpMXicOd--

--------------7O4yfYi7FAInBkvCgTffhZAO
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaPACewUDAAAAAAAKCRBqll0+bw8o6Mu8
AQDt9lgpoUpTKG8yX0D/oXEnQceQDuUp48x7jEVCR4HyJwEAxKlo5BqBGhmkZzdgPV04eJJuQ1PT
UgmVz+ZtGge67g4=
=K5fC
-----END PGP SIGNATURE-----

--------------7O4yfYi7FAInBkvCgTffhZAO--

