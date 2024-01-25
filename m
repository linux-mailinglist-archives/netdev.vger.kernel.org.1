Return-Path: <netdev+bounces-65833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C62A83BE74
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 11:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60956B215A6
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 10:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFC61BF3C;
	Thu, 25 Jan 2024 10:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ENoqLywx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D4DF511
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706177810; cv=fail; b=QFQ6pbTu3H9OcxGH0IWchXEVecliu0Fsft6v5pAe0V/o5g8tiFsTmXbiIk1wSXWogxCXeaJAUA46VAt2B4iQeREWVht90CwiKPSDc7TyrvK0nZ0HShLR9k9Ap5zXQ/LXBLobPOy3yG8IXHZbSw6apXdF7dLU+WzBxbGBd534APE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706177810; c=relaxed/simple;
	bh=siwGfq6nfond0DIkqW0CJBpAgf5X/heyR35LN76fhyg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NgenNZoaOpGLQwWeMLKhyimNiO5p+w8QlDXKq7CKqPoqPUuhSga56mdlBw/+no0X0cfsN5AY52pG6l+ylkGCBqDGlvUpfHVDkaewiOSpojVl9o5zZM66Cx3wXkgbBYOWN0zcIBvVOH8/R1QImSbb1sElufZ3Y6igyTWdQvo5DtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ENoqLywx; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706177807; x=1737713807;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=siwGfq6nfond0DIkqW0CJBpAgf5X/heyR35LN76fhyg=;
  b=ENoqLywx9kFxi2wgog0KiFrczdfV9lj842/HwmtHYVkXpzTQfqoCGe/F
   V+dm1BVCCUcRcmPmbIEqIUG0jZ+3FzjhyRL/5CjDFHF5ICxVZ2aUNnAfv
   m750JHaqQRQqGB/bbLNKFvMrLQXaUwglTJH4h5D38sVkTvsSZldxi01Ao
   q9atKcz/ARy8/jIc4gu00SMCOnalvSJ0YxBgC9bZq4Jjgltz6oUMhSX2I
   iq71RHk76XVzKDhYTQw+Rt+iBMLOAIbT0W3G6pnSgHo+i5lbSbOVBSDf2
   BMUFGDjhYRZCRFzipwdTbNa6CQXy+V1bC3DZjSWq6mKegvfHG4TCMUtaw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1045405"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1045405"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 02:16:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2376583"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jan 2024 02:16:46 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 02:16:46 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 02:16:45 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jan 2024 02:16:45 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Jan 2024 02:16:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CovkPE3Gt9YJmjXTdNRcYM4HSmvAGAnnVdDjgn8u3BPRaAaS25fHyrQOfjdS3XrRxBqJ8fIu+rWR7FvUEA5wAz6+h7lbmyMRPWBOSb8U6x9IJS4sBPe6aKoyJPJhVv+WnRFQfNk4kLRiwoN25olSLwT7LdDnAxqYC+aNzmiOFWWos0FQWp/XZA5qA6o2KRbLUUvqeE2pkDDpPDJr8ihoDxqxhmcSe9jh7+g5Bvh8N6hRJSNoSFOQ51dxw6cO0XkJkyE46MK4lRhJw4CP3MAV/IijrJVOc5qWTSYWCo5hyBxQgW507g0PUebJ2oPDXHzM4KhaaLhROM1gXrUfgtB0jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siwGfq6nfond0DIkqW0CJBpAgf5X/heyR35LN76fhyg=;
 b=MyRy1X0or99IFwTBlJ0e80dHCqST1bp9fht67LflVpWTMi5JoT/kZ9zEpV/wPGVnRoGOi1GJbwHqbO44QgmqF5utMCQ3R7BB1FYzWO7iTXJIi0YaLfr4Mz0qfSkXxqKTsXFlN9s2UHMmxgK/q3P2F+D8n4IXltjlBBMoNkXqPankec0cXHlN6gTW8rk7iosXjFVgh1MOFCAXtCPASbIceJvwaYHJ5QxoLELK2V1MFPVsqyUBsCS/NFWqz6BcviwLi8Uuwg7jwpdw3FIlQAcrOJh3FEp1ygHkmTuE8hzdNHFkR41i95f/WVc9phqGSPcxjlnW8woSb/U4OvVGkaH0zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7785.namprd11.prod.outlook.com (2603:10b6:8:f1::8) by
 DS0PR11MB8205.namprd11.prod.outlook.com (2603:10b6:8:162::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.22; Thu, 25 Jan 2024 10:16:43 +0000
Received: from DS0PR11MB7785.namprd11.prod.outlook.com
 ([fe80::7bfe:b8bd:8b8:7128]) by DS0PR11MB7785.namprd11.prod.outlook.com
 ([fe80::7bfe:b8bd:8b8:7128%4]) with mapi id 15.20.7228.026; Thu, 25 Jan 2024
 10:16:43 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH iwl-next v3 1/3] ixgbe: Convert ret val type from s32 to
 int
Thread-Topic: [PATCH iwl-next v3 1/3] ixgbe: Convert ret val type from s32 to
 int
Thread-Index: AQHaShXG8vd8SRXnnkKHkWxGRpDNo7DmXQyAgAP9LZA=
Date: Thu, 25 Jan 2024 10:16:43 +0000
Message-ID: <DS0PR11MB778565E31D41DF8F8129E1E0F07A2@DS0PR11MB7785.namprd11.prod.outlook.com>
References: <20240118134332.470907-1-jedrzej.jagielski@intel.com>
 <e1fc9c7e-20fd-76ac-15e5-b50dcfc1ae9d@intel.com>
In-Reply-To: <e1fc9c7e-20fd-76ac-15e5-b50dcfc1ae9d@intel.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7785:EE_|DS0PR11MB8205:EE_
x-ms-office365-filtering-correlation-id: 9b215e1f-0e83-43a6-218b-08dc1d8eba77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BeGbuMNEJjI8HQwaGqBTSYSK1duAvJ75NbGx1CUSNdTlb+zsPk1gKNS0CItNbM+a9V4+afiLAWHEbWB75lDGZVp9Ol9XnLgoBUs0WQh2k+Lqauow1ojy6Bxhth09defznCNhtL5XgkwIoPtEQNgX549VA6e6kkL0jANIDrEo+wTLNpW1eYdJX85V7ps0nKfpfNXUIFMRcg6kPFf8CkPKoxoBveLPBP4Gd2tj3XDNO5qVPNppwo9XrkUKSTCJqHdD1IPixigdfruB2uzoAHiAd583YmvZieLZihuhuBz5ue69qxFBwhSQ77fegtUE0q/VwmQPVUkUW0Z9RlFpJiQMjKS+b/Hk36IIVvS+ZjTHT21630UCxTEhlcc0XUfjy6TxKtWSY0HvL/rHUCNrESnfcoX91wdl5AhLa3vrcEhMFIhki+bX5ehxk6Qhebyicy5ltlMu9DIcAu4VF962dN0iju9vivivYMVP67jo3TVOLlPMawfpaNKD0Oh78ouj9qw4kIiJ9q9v5Hp8GM6zU65TKwsLCQigeyt7IRI/uT8i2nJ2CAPZXNl+WuRpPyqKdgg8Dbm4y4p4MY/XDgK+K78wCGmFSOiatokf1HjKYCpCGhuuHFQRJNehs32/QWyEhhxk9DN4F3/3O02RuzC1IaQ1JkXcM8jBLTV7LuJGxhhYVg0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7785.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(230273577357003)(230173577357003)(451199024)(64100799003)(1800799012)(186009)(83380400001)(64756008)(66556008)(66446008)(66476007)(110136005)(76116006)(86362001)(66946007)(55016003)(33656002)(26005)(38070700009)(82960400001)(122000001)(38100700002)(9686003)(4744005)(2906002)(71200400001)(478600001)(41300700001)(7696005)(6506007)(5660300002)(316002)(52536014)(4326008)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVllNndTeWVtK0phT25ITHo5ZXJ5Q2dMZXJqTnQ5amYrQTJWSExKZ3hISFhG?=
 =?utf-8?B?UWc1ZWViOHdCYnRxSmtFMXhWcEJONy9WWUpSclRpc2ExUHk0QXFCSnBCYStL?=
 =?utf-8?B?Z2J2ekZKeDIyMTBZT1RuaXNvQkltWGRDZ2VXL1o2Q0FvdFlYNXlBVytLb1ZX?=
 =?utf-8?B?TUtjVzgwVHRsNTRDTFBVTkpDcUNiUXpxNWl6UzVkY2xhdG03U0YvNWtpU0Qy?=
 =?utf-8?B?YXgvNktvUklmSVFFVXl6R2gyMDBrOSt0TUgrVXNRSXBVeTNTemVOUEdoV3Rx?=
 =?utf-8?B?S3NZWGVxeWFVNFd6ck5oaEpERkJ3SWtiSVR4TjVyMStGVE5jTUQ2RnVLdVZw?=
 =?utf-8?B?clg3YXl4clcxTmh0UGZmalNHUDF4SEdUWkpoTkZxMTk2VTRZcC9QV2pnWDF2?=
 =?utf-8?B?U0k0STNPM292dTRFQS91WWZoNDl3blRBL29aMkgrWmFBcFJJUG1jWWdIK1ZI?=
 =?utf-8?B?em5GY2FnaGJMeXdsdEt6VXRoTEJRRmJUYWdLd1dyRkZnS0dnaXNHcExvV21W?=
 =?utf-8?B?dDZyaFcwQmhIM3hNV2VPb3VlelhOQnVEa3I1YzNESFNjSnFBWnVYTG9meUNn?=
 =?utf-8?B?MGhrbTE5MWhTUkdwL2dHK1pLQkM1MXVZMmxoNndMWnZrOU5qMWtoenJLTEll?=
 =?utf-8?B?TlNQci9lQWRUWmNRVWx2NDl5bVlTMjRIaVY3OHF0bDFMcXdraXI3a2xwajBv?=
 =?utf-8?B?RWZJRmdRR2F1ZWMxR0UxS2NRRk9pYjRKMWpYY28wSUQ0MEIwYWRQOWRwZWxx?=
 =?utf-8?B?MUp0L0VpNmt5Zk8xeW9RYmxuTHJPTFI4dTNkM2wzcjVmMFpVVTdWSDFRNVM3?=
 =?utf-8?B?TEJGN0trb05wbjJraXVFVEd2aGxKTHpkYzhyUWhiUGJVcHVrMnhWdzFScmFi?=
 =?utf-8?B?RnYvUmJGYlFtTTgycDQwbG1DVlJVWFhXd0kxb212T21Ca2Nybm0zQi9VaWJz?=
 =?utf-8?B?K0w1Y1dwczlzaFZkaGNJNjVWM3EwNWhmSWhKSDd6Z3l5c1VLWk4zUzk0T21u?=
 =?utf-8?B?SVJjUUE2TVZBcDMyQktnS1U0czhsMEZmSmxHVXVoQ0N1cUJnRXBRVjNYSjl3?=
 =?utf-8?B?RzQ5TkwwOTJPYVpFTDJtK0crRWxnbHN3OHhMVGRQaElkYmNLdTVsZVdNbSs2?=
 =?utf-8?B?anpBWmUxZm1SeDZDVGMrWXQvSVFHRFJ3VG9MM0ZsM0czVnNBdGNWYktKMWIw?=
 =?utf-8?B?SGRQQWZHOStuRUJzeGRTd1Y5clQ1cCtFckNOSUVkNHhRelJkOXlQVlRmVDJT?=
 =?utf-8?B?c3B4R1BOSnlMZTlrb3kwRHdSSVpSOURwbHczYWhyVU5YbWJCL2ZBY0Z6SENi?=
 =?utf-8?B?T1p1V0l2K2d1cERZbE1WNGx1WU1BVmVzTW50VmIvVFU4TFhWZURuZzc0Wm10?=
 =?utf-8?B?KzhOU1FaUEpaOXlwSXhDelVCWjUvVUczZGQ1YjJNcTBPOFgwcU1seFhSSnpy?=
 =?utf-8?B?TU1BaXZEVytjeHl2MDc2cUdYQ0pDTGxYV1JNME9XblpZNXhEMWw5Y202MUg2?=
 =?utf-8?B?cllwSVo5eU41T3E3M3hWaFRMcTNoZXZ4cElWVTVaSHhHZFc5STZLNStHbnR6?=
 =?utf-8?B?bmx6bFVYYkVtZDR4RlByQXMreUt5TVk3N2lCZU0ya0I3N2QvaWxQRU85blZT?=
 =?utf-8?B?NXBtcnFkRkdTWFBtay9rYkFLUGR3c0VPZWhBb2hYRFhNTGxjcEFUaE5lUFl1?=
 =?utf-8?B?RUQvZFBkbFl1UFFObVEvOE5SQzBMbk14aXI3eHVEZEszRTJlenliQnhHUlVQ?=
 =?utf-8?B?NzRsa2RmRkoyUWNXUzlEa0tieGlNMVJiV1VIYkE0aXdzS29SdTlMVlN1STRJ?=
 =?utf-8?B?cTFLZnc3M3JyMENMSUc4aUpEZzU4MHpjUkN3SVNQMEZkS0ZZNytBc2lNTlZG?=
 =?utf-8?B?djJobE8wYTFLZlJHK2NRVmI2andkS2M0UW5VclovSXhkRDZsdEt3U3RDNGM4?=
 =?utf-8?B?bmtIb2wyb3FBRXNUc2QwYjNUSkhuZEozSWlHTWJVdFNwU01ia0w2aFdQWjlk?=
 =?utf-8?B?TGZJaFQrYXBLNnlmWm1XTmlGeVp5eWJPWkNpMnJNWXFTR3k0QWUxcDROSTJ0?=
 =?utf-8?B?THVmdURJZWVTRkhmMHNreG9KS01aME01NWZrZmMrVFJRNFhpUjhlejI3ZjdS?=
 =?utf-8?B?VEVubWRKb0VtYm1YTitzM2lZQ2I4SThuUTBTLzBNbWpHNlhIWlZTTzlPejRF?=
 =?utf-8?B?dkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7785.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b215e1f-0e83-43a6-218b-08dc1d8eba77
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 10:16:43.0638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vaB4VLl4pByiJCAlxvIxi+eegAVF/K+Nzm6nr6qxH8p2s+/GgySfKxW+PRrqohb9xXYJrW2FV56R85rZJv0P8CZaJ8tHAWrKhMtJQ0k3p4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8205
X-OriginatorOrg: intel.com

RnJvbTogTmd1eWVuLCBBbnRob255IEwgPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPiANClNl
bnQ6IE1vbmRheSwgSmFudWFyeSAyMiwgMjAyNCAxMDoxOSBQTQ0KDQo+T24gMS8xOC8yMDI0IDU6
NDMgQU0sIEplZHJ6ZWogSmFnaWVsc2tpIHdyb3RlOg0KPj4gQ3VycmVudGx5IGJpZyBhbW91bnQg
b2YgdGhlIGZ1bmN0aW9ucyByZXR1cm5pbmcgc3RhbmRhcmQgZXJyb3IgY29kZXMNCj4+IGFyZSBv
ZiB0eXBlIHMzMi4gQ29udmVydCB0aGVtIHRvIHJlZ3VsYXIgaW50cyBhcyB0eXBkZWZzIGhlcmUg
YXJlIG5vdA0KPj4gbmVjZXNzYXJ5IHRvIHJldHVybiBzdGFuZGFyZCBlcnJvciBjb2Rlcy4NCj4+
IA0KPj4gU3VnZ2VzdGVkLWJ5OiBKYWNvYiBLZWxsZXIgPGphY29iLmUua2VsbGVyQGludGVsLmNv
bT4NCj4+IFJldmlld2VkLWJ5OiBKYWNvYiBLZWxsZXIgPGphY29iLmUua2VsbGVyQGludGVsLmNv
bT4NCj4+IFNpZ25lZC1vZmYtYnk6IEplZHJ6ZWogSmFnaWVsc2tpIDxqZWRyemVqLmphZ2llbHNr
aUBpbnRlbC5jb20+DQo+DQo+VGhlcmUncyB2YXJpb3VzIGNoZWNrcGF0Y2ggaXNzdWVzIGJlaW5n
IHJlcG9ydGVkOg0KPg0KPkNIRUNLOiBBbGlnbm1lbnQgc2hvdWxkIG1hdGNoIG9wZW4gcGFyZW50
aGVzaXMNCj5FUlJPUjogc3BhY2UgcHJvaGliaXRlZCBiZWZvcmUgdGhhdCAnLCcgKGN0eDpXeFcp
DQo+V0FSTklORzogcGxlYXNlLCBubyBzcGFjZSBiZWZvcmUgdGFicw0KPg0KPlNlZW1zIGxpa2Ug
YSBudW1iZXIgb2YgdGhlc2UgY2FuIGJlIHJlbWVkaWVkLg0KDQpDYW4gdGhleSBiZSBhZGRyZXNz
ZWQgaW4gdGhlIHNlcGFyYXRlLCBhbHJlYWR5IGV4aXN0aW5nIGNsZWFuIHVwIHBhdGNoLg0KT3Ig
b2JsaWdhdG9yaWx5IHRoZXkgbXVzdCBiZSByZW1lZGllZCBpbiB0aGlzIHBhdGNoPw0KDQpUaGFu
a3MNCg0KPg0KPlRoYW5rcywNCj5Ub255DQo=

