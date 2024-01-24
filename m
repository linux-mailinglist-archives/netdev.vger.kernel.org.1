Return-Path: <netdev+bounces-65458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC7F83A9E6
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 13:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62BDD1C22393
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 12:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B56F63103;
	Wed, 24 Jan 2024 12:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YDmhcEY4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E9F7765D
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 12:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706099689; cv=fail; b=jxfAtZtqQpbm00zVtcwBx13OJ3yP4mDjf09d6O1gr94FSUQBNZyX2VzKmpDN7ikjTPnHcBMSORIJw4V9iwg2rh5AHbz6xNvE5OaTrkp+91/oQeyT8ayJIKLjlT3HCS++yuSaKMiCvDQpvA3FVJv1d0hARwjPkpJUtr0tmulL8Xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706099689; c=relaxed/simple;
	bh=WMX5TQBvP2eH/gcmzDp0k+llQrtZC+6IyHu76iAsBwk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vBjQMpY2KZdozjzMyXXFqyRLkX8SIYj0972AFaD/zBCCb9on0oFcKcib7mrynv7p98R47DfBhfudbS/lqZ5nZu7aInxOSZJ08NIhWTmBHfB4h6OOWkcW4eqc4UZKeqO9+P/LJm90MCt4p1s6sjLrtVGVjhYoSn9DeHcE5w9CCuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YDmhcEY4; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706099687; x=1737635687;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WMX5TQBvP2eH/gcmzDp0k+llQrtZC+6IyHu76iAsBwk=;
  b=YDmhcEY4DA2/U2Q8tnlhLkH9GmEN9PTyJsAe3ol2UAhVivd5U6Wa2baM
   VjE3QQqyrOWxE3a9upsd4c4zJeguB9B8P1tfqy1Qt627+QIGaaKhY2xn8
   RV6XALqX4cYjwScyHVPoWxmJJ4e6TnHe8q4qf97EXeguLSk96T3P0bHwM
   y8rIjZiB2WOk5J7wSxn76haDeWpT7WO8lQvLwsJSlzUGZpTvqSAamXQaR
   CegRP4H5kZSxcR9+1DVz41Y8qwKd+oAAPrss9iHlf8HXFMEVhuldLlKG7
   gtqi0rKLZQLfxbZclRBYS5DS5+N5Khip9PA+KzJcJ4nVejsxhTr8GxcFS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="8940269"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="8940269"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 04:34:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="820451450"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="820451450"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2024 04:34:46 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 04:34:45 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 04:34:45 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 04:34:45 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Jan 2024 04:34:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBCiGLO2J98OQv5Lg50z4Hgf1YiokBWkdwYB9dFWvO+RQU6vMt7eSWjs5nczFfCBQ3EHoYpvxxi0+fqLOmwNbm8+v53j9uQBjZk3QE6yl0eoXE0EPKryGyLIt3GdA6ImfTTatG+W5AP7VPfZMQp6oUxO5P37JLWi17rIuDwnX0eJ9bAEnopF7jLq2Xh87UKI+p/nqI5kYptKAGBTXXgyKfrvIDemipZ4vrLSPU8NLVlj8uTRquqFZvnqh+XNA5r2ALnyUHaRYTbfUy4AdG63MhVKmZhkJ57y2yS5qj3kyrpPQoUZ0F5Uy1xjmQ5JRO6Jf3aR9ALfOS9iGXaIIH1zsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMX5TQBvP2eH/gcmzDp0k+llQrtZC+6IyHu76iAsBwk=;
 b=idxCGKgK/vZc2xq7jG9umR+SN+UApjZA+PBAxhfnv2Uoi3042+d8ujTiwPmaDWf54u5AhPWz+FfNvVeUnBr6MXYqc4qkzjrXClxQ5XOWxqLaRlapAlkQYtBLqCWur+fB+QkWLOVAWAwFBUU/1w0S8LAh9hKU7638oey4jT34dqmydwrjoPRz+IddaiyvKsRZtc1mV0jlU4jYtV7aC6fXsSo7x/2f0pfW9/zI7fHHBbFe6OIKCSbValZl5f0VqLHDknaD6Y7uC2TeMBKrr/utAZsPyjNeV8IIrTqo6YSueQhc+5EgNu5BAh2ydijJAth4zQsarCMMpQyorfDyJClOtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7785.namprd11.prod.outlook.com (2603:10b6:8:f1::8) by
 MW6PR11MB8367.namprd11.prod.outlook.com (2603:10b6:303:249::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Wed, 24 Jan
 2024 12:34:42 +0000
Received: from DS0PR11MB7785.namprd11.prod.outlook.com
 ([fe80::7bfe:b8bd:8b8:7128]) by DS0PR11MB7785.namprd11.prod.outlook.com
 ([fe80::7bfe:b8bd:8b8:7128%4]) with mapi id 15.20.7202.034; Wed, 24 Jan 2024
 12:34:42 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH iwl-next v3 3/3] ixgbe: Cleanup after type convertion
Thread-Topic: [PATCH iwl-next v3 3/3] ixgbe: Cleanup after type convertion
Thread-Index: AQHaShXJzryyinLSFUeti3Mk4ZMMULDfonmAgAlL8IA=
Date: Wed, 24 Jan 2024 12:34:42 +0000
Message-ID: <DS0PR11MB7785B40DAD766F1C31FFAB87F07B2@DS0PR11MB7785.namprd11.prod.outlook.com>
References: <20240118134332.470907-1-jedrzej.jagielski@intel.com>
 <20240118134332.470907-3-jedrzej.jagielski@intel.com>
 <b88cb347-9133-42f2-b41c-62f53666c488@intel.com>
In-Reply-To: <b88cb347-9133-42f2-b41c-62f53666c488@intel.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7785:EE_|MW6PR11MB8367:EE_
x-ms-office365-filtering-correlation-id: f70cf26b-8ae7-429c-699a-08dc1cd8d6ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bICPoyxBm2Mf1f8R3pbwW6yQ8nZwpteO926DvJ9RuK/ba/XZXLfOJmlfDPYkw+Xtsb5bp4Be/0JNJmtO+g77TNUdtvIpWcZiyKppsUpE0XoEEB31MkUaM6WggFpd3swoT5Bu/IJs1zVIoWSx1fOu16i5xwTvuaFGSvcM5kGannbbWVkk165VH8C/7BF7uR2agBlKn2CHEUd++J/CZioGeGwHnXSNlUxRjN45LgH6a10wgO20zRQpR7PDS1ZCv9a+aX61z1vvkg2T+jGaJALG9OYAgDNXN7MhUvpjEhQmnLN96aeGXunvBSNFM0NP3KWWx3fIXhcwVdc1qQ6jUnB6RnDxpkXllZSAZAP0Wx8rsH/q0O1a3Wvbt69ATJSD9C/OxGvQd8dtMZsSnXC8J+DoR9NY+Pd9FNdijXS8WvmlswWz1qqEcLMN86BMwkCfD9flNN94eeZfiPFU1VdiDgeAs9AcyONG1bgFPdG55J6yW/6KSj+rj/tHFPzIECljfSKlRqVw1mAk/mSo38keIaZDMx6IdxjN3+pxksciPVFqxdRiLPOGZ8CNMdZajU6ZLTsd8KhKeJ2Cr3rt26VCORFIEGqsIFpZbForKPHdYTN/kvg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7785.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(376002)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(71200400001)(478600001)(41300700001)(122000001)(82960400001)(38100700002)(55016003)(26005)(83380400001)(9686003)(6506007)(7696005)(64756008)(66446008)(33656002)(316002)(54906003)(2906002)(8936002)(8676002)(4326008)(52536014)(38070700009)(76116006)(110136005)(66946007)(86362001)(5660300002)(66476007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2hkZzJiRFlLY0Qza2R6emYyOEpPeEJMcmpJZ1BGMEhRUEZsQlB0VmZlcTRW?=
 =?utf-8?B?K1hpTm04aW1vZDJyNFBKUjkrWC94OWpYdGRnWml4SmtSNTVEQzBreHk2ZzJV?=
 =?utf-8?B?all2aXA4dEF4WExzYkxDVGpwd0E3azJiV0M3R2FZeUxWdkRMTHlJbE5ESDg0?=
 =?utf-8?B?VXlYUklPMzIxVWNsQyt6dEI4SDdFRHo3N1ZOKzQvRi9nd2tzZUtMZ1R6NTFD?=
 =?utf-8?B?djg5b2pRNVBYOVFhejZyUjM4bVoyUkN3NnltOW9jWUtZREkya0lkMkVXYXV6?=
 =?utf-8?B?ZnVjcEFEa3Q2MHAxY0JKRU5mQjdtdlczQy9MRyt6dm8rMXlJL1hhN01LeUti?=
 =?utf-8?B?Mlp0TXZ5ZHVLQjhpdTBST055VHIvVi95VllMNURFaDFtWWFJN29jUUZNL0J5?=
 =?utf-8?B?OWxIaFRnK2l2UGpRZVZyaEdRVHZoaDU3YmFkSmVaL1ZOeWduUXg5REdxaDFS?=
 =?utf-8?B?Y1QzWUtvTVVrcEhleW9HYkJyTStPbnZLZXRrS1RldUgzY3VWVDdCSmhyb2li?=
 =?utf-8?B?V3pwbzRHWE1UOTgxYiszK3N2NmxielJmbktXYUV3M1dDZW1JanZTVWNIUTNi?=
 =?utf-8?B?ZEcrV2srYTZuUUtvY3lJRE1hMVdnRW5wWEhEUmNvZTNXWFB3endJV3ZXVkFV?=
 =?utf-8?B?d1FrRlNEQm9kSm03QTlxVm9QT0dvNUkwNElJb0Nqd0RETkE3T3dNVkFKMVdq?=
 =?utf-8?B?SS9HUDU5S0tFK0FudHVlQzRZWjRRVE40UHJmVU5pUVRUVmkyaVdRUTRTbUhp?=
 =?utf-8?B?Zkp1L1dUK2RqU0pyNWppU0w1dkJUMThSSWprTWs2SUJTdXFSMkVhalJOS05s?=
 =?utf-8?B?THhzekZPM2ZxejJFSkJTWWVoWThkVmhNcmN1MWQwT2diQTdYYnVBSmY3M1ZC?=
 =?utf-8?B?RHdjMy9MRHNCSnVXdGNUdGlxVzR0K2g1UmJUMHVnN2FVeVRJVEswSUdaNGtk?=
 =?utf-8?B?eEVGUlN5Wk1TUDhxY2dJVmZJTE1nMExXMzV5RlVoNnMxSmROYzl6NURPVjNR?=
 =?utf-8?B?M05iQ2NlaUNhWURQOGFjWW01QWNYbVRLUlVMTmwvemVpbFlxSE4rbmJSQVpC?=
 =?utf-8?B?WmhINFNxaVZHaTkzWVdpMmc2SkM3SFVZOE8rRjFvMFpJYTgvZWg1cU9sVWJu?=
 =?utf-8?B?NXdPK283UGdEbmRzdCtiZklTdWNra25CZmRkVDl4eDdSZ1VSdlhMbS9ZQTJU?=
 =?utf-8?B?QUF6NFhrUTlxWTFKYUpMY3pDMUJUNUhCUUhIVHJrd1g1c2pkKzQ4WWJJR2Yz?=
 =?utf-8?B?M2JReHpjT0NjTUZPOE1NNWRta3VjVk1zRkNNamVzYXZjSkh5NzNyNXZwZTcz?=
 =?utf-8?B?eTAzeXl2TDdsdTN0RDE5Y2JvdlJjbFFSZFNHRWtIRXo2bFRRTUdPd0hQRUFU?=
 =?utf-8?B?dkpjRVgzajBzcEIwdzhmd0dKYmcvM0NKNXREMWo0cEpaZlh2Y0Y3UXM2RzNE?=
 =?utf-8?B?eTNnNVptTG41TnhCbWsxMFNJWlJ0ZzNsK3BxRHIxOFdkTGpPcjRISVRTcGor?=
 =?utf-8?B?bHRSeVVETkZEdmxXTitxNEIycXdLTE9ZY2FTcEdvT0w0aUtzeXpIYmJnai9m?=
 =?utf-8?B?Q1VPOFl5bjc5VlNQY09UTkZrdkJrdTMyK2ZUOVlpS3hZcElPYmZvQlY0NEJn?=
 =?utf-8?B?bjF5MFVlQytFaTRudjZEN2dOOHdhQ0Z2ZFhndXd2Wmo1MTVISXI3c0F2ZlpY?=
 =?utf-8?B?T3U2b1k3Y3YwblpFSXRITjVtRlJsRE9KdTZUVHNORDBGYmJob0Q1SnFxVGN0?=
 =?utf-8?B?Q0NZSGFpUGlxZFpyL2lVMk9YWjZKOWtLT203TXZaZE1YSUdyNXhrclNPNGM0?=
 =?utf-8?B?UnlVdnVaUENhWUgvWEllWFdUSXI2dk5Ka00xOEFrb3FjZ0ljY1cxKzVhOXVu?=
 =?utf-8?B?MWZtcmpzdTV1d0lMQjVvWUZlOE95QVFFWW5LV0d4ZCtaZEpnUlBETHNzQjNO?=
 =?utf-8?B?OEVPbHBHUXJEYjZrOFY2OHliajZyYWlVNWI5dE9hc09pelpjV0ZWVm5QVVJE?=
 =?utf-8?B?TmorNXlCM1VDekhDN2FZbVVvN01XUXExSXByeWlFampUL0VhYXpHRGI4djNw?=
 =?utf-8?B?R2I4a1Vab1B2M3VZVTZlTGdBcCtmUUZ0dm9Nc1lpRUJOakdtcVhCSEhNbFEy?=
 =?utf-8?B?aUo0dUN0cXYwRGYyNm9KekxBbFRpN2RWKzJFd1dmUXFvdVd6MEdkempIUWxG?=
 =?utf-8?B?SFE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f70cf26b-8ae7-429c-699a-08dc1cd8d6ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 12:34:42.3639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yk8FYUYBK/CHxjliMqI8kdbYzlDIYgQCm4uZMtgPmLT7kadd9cy0yXHYoc8sKLddBpXB7JU+5pje4KYcTednQPVPfqH6HqEIQz8paFItRzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8367
X-OriginatorOrg: intel.com

RnJvbTogS2l0c3plbCwgUHJ6ZW15c2xhdyA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT4g
DQpTZW50OiBUaHVyc2RheSwgSmFudWFyeSAxOCwgMjAyNCAzOjM0IFBNDQoNCj5PbiAxLzE4LzI0
IDE0OjQzLCBKZWRyemVqIEphZ2llbHNraSB3cm90ZToNCj4+IENsZWFuIHVwIGNvZGUgd2hlcmUg
dG91Y2hlZCBkdXJpbmcgdHlwZSBjb252ZXJ0aW9uIGJ5IHRoZSBwYXRjaA0KPj4gODAzNTU2MGRi
ZmFmLiBSZWFycmFuZ2UgdG8gZml4IHJldmVyc2UgQ2hyaXN0bWFzIHRyZWUNCj5JIGRvbid0IHNl
ZSB0aGlzIFNIQSBpbiBteSBjb3B5LCBwbGVhc2UgZml4IGl0Lg0KDQpJIHNlZSB0aGlzIGFzIHRo
ZSBTSEEgb2YgdGhlIHBhdGNoIDEvMyAnaXhnYmU6IENvbnZlcnQgcmV0IHZhbCB0eXBlIGZyb20g
czMyIHRvIGludCcNCldoYXQgaXMgdGhlIFNIQSBvZiB0aGlzIHBhdGNoIGluIHlvdXIgY29weSB0
aGVuPw0KDQo+DQo+PiANCj4+IFN1Z2dlc3RlZC1ieTogVG9ueSBOZ3V5ZW4gPGFudGhvbnkubC5u
Z3V5ZW5AaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogSmVkcnplaiBKYWdpZWxza2kgPGpl
ZHJ6ZWouamFnaWVsc2tpQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gICAuLi4vbmV0L2V0aGVybmV0
L2ludGVsL2l4Z2JlL2l4Z2JlXzgyNTk4LmMgICAgfCAxNCArKy0tDQo+PiAgIC4uLi9uZXQvZXRo
ZXJuZXQvaW50ZWwvaXhnYmUvaXhnYmVfODI1OTkuYyAgICB8IDQwICsrKysrLS0tLS0tDQo+PiAg
IC4uLi9uZXQvZXRoZXJuZXQvaW50ZWwvaXhnYmUvaXhnYmVfY29tbW9uLmMgICB8IDY2ICsrKysr
KysrKy0tLS0tLS0tLS0NCj4+ICAgLi4uL25ldC9ldGhlcm5ldC9pbnRlbC9peGdiZS9peGdiZV9l
dGh0b29sLmMgIHwgIDIgKy0NCj4+ICAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaXhnYmUv
aXhnYmVfcGh5LmMgIHwgNTQgKysrKysrKy0tLS0tLS0tDQo+PiAgIGRyaXZlcnMvbmV0L2V0aGVy
bmV0L2ludGVsL2l4Z2JlL2l4Z2JlX3g1NDAuYyB8IDEyICsrLS0NCj4+ICAgZHJpdmVycy9uZXQv
ZXRoZXJuZXQvaW50ZWwvaXhnYmUvaXhnYmVfeDU1MC5jIHwgNTAgKysrKysrKy0tLS0tLS0NCj4+
ICAgNyBmaWxlcyBjaGFuZ2VkLCAxMTkgaW5zZXJ0aW9ucygrKSwgMTE5IGRlbGV0aW9ucygtKQ0K
Pj4gDQo+DQo+Y29kZSBjaGFuZ2VzIGFyZSBmaW5lLA0KPlJldmlld2VkLWJ5OiBQcnplbWVrIEtp
dHN6ZWwgPHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+DQo=

