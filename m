Return-Path: <netdev+bounces-88841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C174C8A8B2A
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 20:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76EFA281C11
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 18:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6711C79FE;
	Wed, 17 Apr 2024 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nwFUMCIC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505BCEC5
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 18:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713378717; cv=fail; b=p46oobV/idTMEnwNK4FRKT2q47ZLrNlnCJB48nBMOFQcNZ3dsBKEBlIghQaUwrklQj2BFhLc+AxkJTR2ixDwUb+ZoAycFEkeMM+tNq6pUL7iw5HNMU+7Xfsqj5YFgls4EmuPbDNSahoHypyRQf+Ys1bOSlkubhHJUqfx7WwkiKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713378717; c=relaxed/simple;
	bh=2+weThIvl3DpeEzavTjKbKfG8lwLtYHx/ocuF2FkhS0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EFzAPSrrhIRG7thvmLjjBEkVdkRt0uj/eTj+GpZSMkMuOnoip2Ryb5MG01nJvYelY8huQ1x4ZiuAc9PMuf+W1XgEy+QrjkLnb2y8QaUIv74CfksMGrBObAXxKFeAOl7xuCz+Xjnhrv4n8qUBl5eLPQPdSRlPVyL9Mj0D0gWnN8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nwFUMCIC; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713378715; x=1744914715;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2+weThIvl3DpeEzavTjKbKfG8lwLtYHx/ocuF2FkhS0=;
  b=nwFUMCICok1W3d0C9PkJfnssXIjryYrk8V3WbfOJtcoqDp0jo4xq9/T7
   WUu5ZswNjMD5jLNgDdHItD+PX9JEWol9Z/PmqYU6zg/WhDOv6Ib7oig9J
   e3kx5xQgkfIHBu44+OFD0rPI5YETuGc/AEKSZWgwaiefrPk38rqH6+GH0
   p0TL2T+CvCmlfMA7lQWZzEu22xYlClohHLEW9toLcMOaCQQCMkXwi4SXM
   tJqBeVutp9hUo89Hsayti0ClnoB9PfMWkOGG4YTJvVIpXtkmcuLnQcuJU
   A+nPXgohwzdCxnu7rnlwYrp7qRU4mAFzO3yR011sBGmAhH4mEYvxrzZ3A
   g==;
X-CSE-ConnectionGUID: OaiL7gUSRFCjDMHXrB7AEg==
X-CSE-MsgGUID: zxQIaSb6RAuG2VVb0xImcA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="12669539"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="12669539"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 11:31:54 -0700
X-CSE-ConnectionGUID: ervnOOwORBSNS55pPXfJFw==
X-CSE-MsgGUID: +bWKT2agRIeCd2UQN/sRYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="22788196"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Apr 2024 11:31:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 11:31:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Apr 2024 11:31:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 11:31:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+BZovaVwH/GNk0vT2m3WbAa3JynY8KDdZyHNNjzjbieS7l4jApuXBXHRIytY9k6bF9Yjyj6A+hCGqBTFS19/Pz06JA6iLR+qDFdEz0atctMRIRAngsewJLCAHR1qD3e/27vsyAPL4Sqr/SZNGhvE/2ujPYvmAZO40zk6L39U2BEV02OkKnQVt3APuTM9hPFTakHQCb/3oalJXl3wv8aUpZP0K72JHQYa0WmfCndNb5ZP5wuMbXWWHNSF7a7h0Hr2T8KfSAUDklJp5vktmmXc6z3Q9sNMEqKEF8wCnGlAiv2kYU0uzpnYOk57kAYr7/j1bZtJ4eVoW91BCvQkO0okw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+weThIvl3DpeEzavTjKbKfG8lwLtYHx/ocuF2FkhS0=;
 b=G9JQ/VM0/mXlH92BXdwTJ+0zpx6Ty0f94/QiQR7sMH7CsYiBmKH15Kludtnjb4bcm1JZXFD6yNQsHBoDkyCg5/byZ6SCh9ixnWy4bIz4uiIiQSbQMtct7rh2yO6J/Ht6OWwphpyNoQmJ+ZAq3LCSMMm3Cz2NIQhhaZsT/xeeaxDtlNnRE4OHrCqzk5X4vd5etvBa/8Z02GVh+w67y4JhNtRE/tGAouRrYKIZyHgzVVYA7+lQyYaYh9k7af5Ud+i0rSCg3kJJZ0ZFKyJK74Jaqc6NxCtbNGtS8cTHMOsUupGnQOVRo4ohmbOxnxh0WOatW8rWaIQ8q0J7ZZ0FVvfV8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA2PR11MB4923.namprd11.prod.outlook.com (2603:10b6:806:fa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 18:31:50 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7472.027; Wed, 17 Apr 2024
 18:31:50 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Alexandra Winter <wintera@linux.ibm.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Gal Pressman
	<gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "M, Saeed"
	<saeedm@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Michal Kubecek <mkubecek@suse.cz>
Subject: RE: [PATCH ethtool-next 1/2] update UAPI header copies
Thread-Topic: [PATCH ethtool-next 1/2] update UAPI header copies
Thread-Index: AQHakD3zK618L9O1fES/ZFNzMifjPrFsGOCAgACxkZA=
Date: Wed, 17 Apr 2024 18:31:50 +0000
Message-ID: <CO1PR11MB50890484E43A79F051AB90C6D60F2@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20240416203723.104062-1-rrameshbabu@nvidia.com>
 <20240416203723.104062-2-rrameshbabu@nvidia.com>
 <584f28ff-597b-4ab5-b363-a5f142905fcd@linux.ibm.com>
In-Reply-To: <584f28ff-597b-4ab5-b363-a5f142905fcd@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|SA2PR11MB4923:EE_
x-ms-office365-filtering-correlation-id: 0c5c93c7-57da-4efd-ed79-08dc5f0ca5a5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JEuw4Y5xfOAgQmQTcVrl/6kRyC6nc8Rj5xdsdbTxKmLMbXPvb0dKHCzxDFGXVTfrDgpMlvlXwexskQ3SChqA3Kh62ZY8BS8/K9Ry6VWV4OmsKC6NytRyPG5+1QtM7E/pOFrxzqr1C2FWqWiNigM6byQZyNgb+Az5+rmam3igVJvg2kQg7IDU1752gnYtlcbDVs6aGNmezBdNl29ulh7uaojchzcOS6abhpwJG+pjAUNquQ0JUY1uoBgYLEB47FX3JamKLiOa1vFenk7unywEcR3NdzX2nX0bvn4AsdalrnUTRNbCiCvys+reQxJlzKfN3AuAqhgPyTtxJAZBfSw5TOYMwOg9OFBDheLjO8j+dlXvCYpuugxdHUV57L2cB/cGj691p4mWp9ITuyRkJv6pLp0Up0OlrovRSKyOrYVmecJSwk68DpOkI4JJljnvCNv+lsIqQKfFo+u6AtFVhwtSlNznDyePDnPK3yfkAKIxihgGD0szmHGY8/GiOHc+4lFVFqg0bWDGEZw2n39e7g8oNzRE7i7euK0H9PwGpYhoaU3s8XUmdNdSjuxUoWu7/aRoem90yQKy/0CebuTbX4vnFXMb7JR+TEjdt+JbU7QcXjcV24gZqZZKaGvJXJZKQupeJS8tLbfDpcy//RUNFklM4kjQQlKe+GeFEFlr8eJSqHh+A3uaBnjSK4Lgkzh0OntU1Qdo6hOdtCExoQRYpw+kWadmxR9s+RZiUXDo6JUYrMI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0lDaUw4b2Jna2xjYUVkWEY2L0NaMGlEZ1RpT0JRanVjK004R0N5cU1aVDBK?=
 =?utf-8?B?bXFOdjJwZTJ3ZmVVN0ZNcFRQVFhSbVdhRnFIa2xqa1NHSHM4elE5QVhxTmZW?=
 =?utf-8?B?MC9VQkg1UUg2K3JZL0NmTWVMVkhMSU1XVkw4WEhnaDh0UTdyTUt2b3ZVYWRP?=
 =?utf-8?B?dEE5N29ianYxRlJhODBONDJtMjFKQXFuQVNobzY4RXVUbnF3eDhBMVVFLzNZ?=
 =?utf-8?B?UnhvdmcyVldCdkRXaSt1VlpRT0p4bXBEc2ZETGpzYkhZQWFPZ2F0M2t5SG5X?=
 =?utf-8?B?SnBYVkpWTEZpdmtnU2hJeE5hajFCUm1HdUllSmtCb3RLSEorNFp5NG5qT09S?=
 =?utf-8?B?UWQ4QXF6akQ3Z1JmUGNsaWwwYVVYa1RwZGU1ZHg2dEF2K01CL1c0RVFEYjh6?=
 =?utf-8?B?STRNS3RSSEFOVjI2alcyNTFQTTZ3K3ZXZjNWWmljVnVJazhkV0JZSU5BNnJY?=
 =?utf-8?B?MmtmTkd3T0lIQkRDSnZ2MXZRT25yTG40aTI2MkZuZWZpM2ltb1YzQnFYMjIv?=
 =?utf-8?B?L2tkTTlVOU1HckpBczFZMDR1YjR3OGZ6b2pWeVhUU0MwUVRnenlaTmswRE15?=
 =?utf-8?B?QjJVMlB3K0dCb1hvSENSS2YvUk8xZkVMc3ZkY3c0K2tOK2VKOFdzR3Vxelgr?=
 =?utf-8?B?WU50WkxpaTdLelI5aEFCUVlGdnFlSUdhS3lzQmNUYVlBWmRRSUNsWUdwclFS?=
 =?utf-8?B?YXRjVE81NlhjN3lmSEhSY1ZENkQvUXB0UTAxN1ZxMzNIRVVQWG9NR1FKYkRB?=
 =?utf-8?B?UDNTRGxxLzdLbEt0NlhPU2lpWHFqT0hyeDE4ajFyYnlMMjdNbzE3QzV5WWZx?=
 =?utf-8?B?YkptcWorRW4wMkdEUEc0UU9IRE5QdnRLSDBGYlE1VHdBbWdXT0lsWHJIejdp?=
 =?utf-8?B?NzU4bUhWbGNkb1pLWTFIa2tiTkxYbVFNSkZyYXNXTTNra1JWM3RZZFNPeW5S?=
 =?utf-8?B?QUVESFBJaEI2UVZBdngwUzhhUlFId0greG1IVVJZWnpsek5XeXpNcWhOVDR2?=
 =?utf-8?B?cjhMc3lhUGZFK2pRdGhBYVc4Uk9qMUVUMmpNOHZ1bjI3Qk1rNmYzTk05Ykxp?=
 =?utf-8?B?ci9ta3diM1YrU0RqVkpJMVpnNE4vN3FoSG9Qa0QvNzI2QmQxOWhyb3o3bmhv?=
 =?utf-8?B?WHZtUDA0N2tJdFhZR0xHVXU0clJvWXBrZld6eUNYdXZ2eEpEelljUDdoR0wx?=
 =?utf-8?B?amRyTGtpbjM4aWxpRnlrU2gzcWhweWZiSEhKbHhlZWp1ek9kUkxqeGxsWVVs?=
 =?utf-8?B?M0hnTnQyaVhweHVwSitpUE85YzYvYlN1SmtTdU02cDIvcHg2TkkvNEE3V1R0?=
 =?utf-8?B?cGs0Z24zbDZsM1pUbkxvUkhobC9zMFZ5VVEwY05WS1MwSUhIZlNQVUFqa20r?=
 =?utf-8?B?WEl5dTBRY0lRc0xnalFITG1IOVRwR3QwNWNBK0FBZm5sL0hCSjBVQzhBSWZz?=
 =?utf-8?B?amFmWXJYZzFYZjcvT2FBVUplWlU4Ukl6SE5QWEphalRGRUxBU2pxNEd3VUta?=
 =?utf-8?B?U0ZPSkdaUGxMbjR5SHgrT2EzekFIaWxxcHBFUEM5QVZTcTBlRy8xNmFRQzdz?=
 =?utf-8?B?MURmMGVqb2JZMGdsbFg5bkdHTElMOHpndG5pRExWVjFPVzg5V1ZHT0NrOFlp?=
 =?utf-8?B?ckdtWllsTG5XVTdIUzdiSmhoWmpqQVh5Nmlzb2FrZHNPZkU3d1BPY0N1TjBk?=
 =?utf-8?B?WUh1QjFmVWRyMXJrNFZOSngrTGxSN29pV3hURm83bVFYTTRWQlUxK1RLSzBN?=
 =?utf-8?B?aFpaNllQQ3BpR1JyZzFUS2tqN0tQZzBldm0vdEtZWDNLY1BnQ3NOQ2pHcHhv?=
 =?utf-8?B?WlhId21DbXQ3Y0xtYWNHYzVNZFdHUUlNeEZvV3E1RVJib3VNQWZKSktCc0Jw?=
 =?utf-8?B?QkRpV3E2RERldEM5YS9DRU8vRmd2dkNYMkN5U1NiTTF2Nml0MnBINXNQc0pS?=
 =?utf-8?B?UDhYekliNGl3Njhub3Y3NjNCeS9iQ2htK3R2dmlWaTZLNm5OR0FCclRHZGwv?=
 =?utf-8?B?eU1GMnpxV09LdjV0WmFJNjhwTG5QQWJndG8zQVNEL3oxTERMU2FhYTBCcjdY?=
 =?utf-8?B?NDU1Rm9qWW9TWFhSaldEUE96UXh2MnU4bmZ0WVcwM1dvcXJSZ1hlNCsxaVlH?=
 =?utf-8?Q?C/5QEvAwJ+dYm+S42w0X7t9AJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c5c93c7-57da-4efd-ed79-08dc5f0ca5a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 18:31:50.2918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pin0BNteM8Bcby2Qmu6gDZTV/ziYcwrBFfc8Zh9SplrrQqsbZr/1z0aDR/BX8BsCsEBDqfCEO4RdaBYgUU+nlnVa5BqpE3dnhofUnS+DF3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4923
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleGFuZHJhIFdpbnRl
ciA8d2ludGVyYUBsaW51eC5pYm0uY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDE3LCAy
MDI0IDEyOjU2IEFNDQo+IFRvOiBSYWh1bCBSYW1lc2hiYWJ1IDxycmFtZXNoYmFidUBudmlkaWEu
Y29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KPiBDYzogVmFkaW0gRmVkb3JlbmtvIDx2YWRp
bS5mZWRvcmVua29AbGludXguZGV2PjsgS2VsbGVyLCBKYWNvYiBFDQo+IDxqYWNvYi5lLmtlbGxl
ckBpbnRlbC5jb20+OyBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+OyBKYWt1YiBLaWNp
bnNraQ0KPiA8a3ViYUBrZXJuZWwub3JnPjsgRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxv
ZnQubmV0PjsgRXJpYyBEdW1hemV0DQo+IDxlZHVtYXpldEBnb29nbGUuY29tPjsgR2FsIFByZXNz
bWFuIDxnYWxAbnZpZGlhLmNvbT47IFRhcmlxIFRvdWthbg0KPiA8dGFyaXF0QG52aWRpYS5jb20+
OyBNLCBTYWVlZCA8c2FlZWRtQG52aWRpYS5jb20+OyBDYXJvbGluYSBKdWJyYW4NCj4gPGNqdWJy
YW5AbnZpZGlhLmNvbT47IENvc21pbiBSYXRpdSA8Y3JhdGl1QG52aWRpYS5jb20+OyBNaWNoYWwg
S3ViZWNlaw0KPiA8bWt1YmVjZWtAc3VzZS5jej4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBldGh0
b29sLW5leHQgMS8yXSB1cGRhdGUgVUFQSSBoZWFkZXIgY29waWVzDQo+IA0KPiANCj4gDQo+IE9u
IDE2LjA0LjI0IDIyOjM3LCBSYWh1bCBSYW1lc2hiYWJ1IHdyb3RlOg0KPiA+IFVwZGF0ZSB0byBr
ZXJuZWwgY29tbWl0IDNlNmQzZjZmODcwZS4NCj4gDQo+IE1heWJlIGEgdXNlciBlcnJvciBvbiBt
eSBzaWRlLCBidXQgSSBjYW5ub3QgZmluZCBhIGtlcm5lbCBjb21taXQgd2l0aCB0aGlzIG51bWJl
ci4NCg0KSSBjYW4ndCBmaW5kIHRoaXMgY29tbWl0IGluIG5ldC1uZXh0IGVpdGhlci4NCg0KVGhh
bmtzLA0KSmFrZQ0K

