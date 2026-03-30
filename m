Return-Path: <netdev+bounces-273187-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHmHOtR8ymlo9QUAu9opvQ
	(envelope-from <netdev+bounces-273187-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:38:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA8935C1D8
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 762FC303C8D3
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753E63876D5;
	Mon, 30 Mar 2026 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LIy4BdJ4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CED035DA60;
	Mon, 30 Mar 2026 13:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774877254; cv=fail; b=Wjmjhj1CgtPI6HB273JQd1XvPdpxqbTX/uzZkqLgnAoTZh9bQ7UpeITLv4HNvMfYKsGLI7Y3q9NrXcAjhLOCBsp8mXQXFvA5qi3wpV83cleTYCJICGsOwOf8kSlFTVjbvKLCaFkXxc/e1HDsS8bVi9+OT893WTAGpcKVvjzhsSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774877254; c=relaxed/simple;
	bh=5kPa+mQrVapDWKYpkQUxRDL2s84cJPRTDPtUaMLn+Q8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dlw4toXRw9tRPYKqVUnpw6W2xLJlDFBRXgnp9FnIrEvKhoQTI0hitfDQiH2rvpa7n+VSAndv/2MzsjRfcB+8SuR6sEFiRJCMVyXhRlAjwN3ObV7d0USs7qW07L8rXYOlaDztf21uNVAIYV60VzmvmG6fLst6kVwE6Y0gjwgRg4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LIy4BdJ4; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774877253; x=1806413253;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5kPa+mQrVapDWKYpkQUxRDL2s84cJPRTDPtUaMLn+Q8=;
  b=LIy4BdJ4hT6H9jSLAK6TPfO7A0yMSfiPiQvUSvX9y495OmD62tJC/AUo
   mEnsvRrVhSevjtrTESURpd95KrcegZfSqNzKFI+OM7g8EBU5ocTBFqlMT
   ssXh/zQWFnGPwN3XZBTFH5GhQmqAsxyjPhsl/tYRHSG3fVYvMlTOMFekA
   GhaYujf6axzV5ImttmVQfLelSSTwGq11rn608CHlist8k75v34KCMNOiA
   Tdc8cmDvBAb1x0pLWsPeyJ4tbj1+l8ywEVYwVIv9KfIreSFHx1Nc8v/4x
   7Y6FH47/aHFsx1/gJytIXEIYRCjdUt2EVmnTGs1R4Ls/t6BCZgBDOV8vv
   A==;
X-CSE-ConnectionGUID: dUrFPifbRUu37YmCkvRqaA==
X-CSE-MsgGUID: hjszo9jWT9e9XfP7HjPg5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="93451635"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="93451635"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 06:27:32 -0700
X-CSE-ConnectionGUID: 4g7K9w8MTBuGajCJc2xy6w==
X-CSE-MsgGUID: srxOL25MRaiot7LKFGr6nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="227673106"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 06:27:31 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 06:27:31 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 06:27:31 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.3) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 06:27:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwJjyBoqbzoWyUEpH2gkTxJCyq+8GfSBi57AyZFdve8NlhuXk8Ef0ywMJgCqRAeN06eMNZEhnO0H4IbqPLytPSkxwNftg3WSFHBvrWn1id+gbww0tsha170JtBpt8IiVqBA+Y0PXZL07SK4XC5CdIjfkEuHa4TEE26idcAuqiUK/FCMmqqUD8I8x/ief7SpXHdeKCMjqR5la97rgzwN3VZ7CizXvmK8mpQ1aVru9eQ23dA6K7IrXDMRQoCL2dWDLECr0vGePmlmfz8e0X0ORLzScsyjHTwKoUgy+RnO2kmki9Ea/v6jRnl+mtvb0ikVBxFJLBd35A1JPL93Ckpqvxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkRjtxd7Js4HJOpyL6gx7FIlQG47O5Yoh2+WsZVpado=;
 b=efMPuWyKAB+skvhwxgmuxnSDHUZ+Az8S0lgYt6Y3HRg9C9hmLIFPVf+oZ0cBh6urLbNMrbGNQdZj9vQhr6Q7k5hRMudMvSrixXjoY/T5VJ66a8dhSuKWubD2xOcvo0ftMczP/evEIOmc00eB+PNsIF6tXGjQLLkVhVjjqCVMs0PtMI4EM10m7HVz/RLGBzWDHT7hvqBus32U6ncJBHkrPpOXPVEv8zmY3NOH282oo+IngWm7/7EKjqU4bPMYblAzcIiVhReb1WaSXSmQKVFCzvRXsovG69DeOV+D1OjkMTjcSmylO65ZuisnQIEx6PX1DMyyaG6/MVpB+ud3YaBTzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6219.namprd11.prod.outlook.com (2603:10b6:208:3e9::15)
 by LV2PR11MB6072.namprd11.prod.outlook.com (2603:10b6:408:176::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 13:27:25 +0000
Received: from IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31]) by IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31%5]) with mapi id 15.20.9769.006; Mon, 30 Mar 2026
 13:27:25 +0000
From: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "Vecera, Ivan" <ivecera@redhat.com>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "kuba@kernel.org" <kuba@kernel.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "edumazet@google.com"
	<edumazet@google.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kubalewski,
 Arkadiusz" <arkadiusz.kubalewski@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "horms@kernel.org" <horms@kernel.org>,
	"Prathosh.Satish@microchip.com" <Prathosh.Satish@microchip.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH v4 net-next 6/8] ice: implement CPI
 support for E825C
Thread-Topic: [Intel-wired-lan] [PATCH v4 net-next 6/8] ice: implement CPI
 support for E825C
Thread-Index: AQHcvT5EqK4skNIp+USPAOOLnecsMrXCn1gAgAR345A=
Date: Mon, 30 Mar 2026 13:27:25 +0000
Message-ID: <IA1PR11MB6219B66E40337DA49738B3D89252A@IA1PR11MB6219.namprd11.prod.outlook.com>
References: <20260326162832.3135857-1-grzegorz.nitka@intel.com>
 <20260326162832.3135857-7-grzegorz.nitka@intel.com>
 <IA3PR11MB8986A25079EA6C95E701DCDBE557A@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB8986A25079EA6C95E701DCDBE557A@IA3PR11MB8986.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6219:EE_|LV2PR11MB6072:EE_
x-ms-office365-filtering-correlation-id: 4cbc5e07-7ed7-40b8-93af-08de8e60150b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: QpLFg148NUFWNDLsI42kOnJxWbaMkK32r00YKwCXfmQohtfu0n7VwiBtUzM2sWz7kBkUWlNUcLPOFUHG2wAZp6cy56eH3uBuznjwCNDoNTVOVBN5LTqYG9+LhaG15GZyAF8WguBsm1NIfGNvhC6WDo8WisG70nimEEhaNGP2+ITDWOUu3m1YJtremSQEjBFDVdRJKmd/zCXx81watb6szRb1ruf4IJr1HfCjLVwlumuEK8JvBeDygkpc4dfAKOtWRPGfoEtBpiKkrroyjlIGewsRGkLGvX5pPx+eVEhcmXa4zT2tZc8rvX07lszQTAIA2vNgZYUHo1WNK3Fh6ydWMGnHlhpLVQ7Q6UoxKbNoWCH9yBwwHrTfs49nJ/2p6gzkDGqrHQOknF8SQe1itAkKdJyygkIn5FxkmvUR/LkJnkDY5Dc5ixhx9U1Zvb0SJ3sx5VcSWLBwie4T8ka+3igQyNSyntkQh1tH/I9PccfW3AWsQ8p9Bspmtz0sYuWUKC5lmcFsTp99qWf2ZLdUzkerJKnC6IXx3Iq9Txt2HbamwBlidaVQosPRpe6iXhbLWDZyIxq7MmatIAgWIiBT6FYAYbOknPGVLxHtp+QxpZqIdsXmtn6/if+gICIeMQAwNFYS+RSAl6/Wg7Z4cByAzrRbJO8V5cEQF+p1/5oCcaf87bz+xX5SgNUTAIxIEk7PSThOKRww3FfqtUh1I3JSkYxPw3Ef80PUCsx9kRhfsZ/IolrvpZiqCmHooRkxsSs5kd0T9BVMXxduD1C9xfgL+FA7QBrlVJfAP9B9o81QFNt+Sj4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6219.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WGfmhqURQUVmaVCPyaLogmC88FgoWF0g9sVmdwEWq0/zQ6QhpI0gqjhhFfDo?=
 =?us-ascii?Q?FW+aNtt/jGtN27E7u7NgBDHYrRmP3sXF1jBZ9dhIhhahbSDFec2M8GFUJCjq?=
 =?us-ascii?Q?Tl6lpYwr3nKgf3uzguxgFqtUp8lukXg+15lncvV1en7Wh5uBLJ0POhUlsjw1?=
 =?us-ascii?Q?4T5YrNwfHXZLrRZ4SUsk94NtN9QTa9bjkwxFJ4ZUMEUml05XeHI8dS7Nw1V+?=
 =?us-ascii?Q?QK4J96OCNzYdIquufrl5BxdlOAMCnC7b5HkXsv0zdt7ibmDCz6UyrlP8Xxus?=
 =?us-ascii?Q?hDjfkaccxb7NP2TTUUz9u5i7O7RNji7Jz9yHutS6qUAb1LD6RQzvbOqTXkCD?=
 =?us-ascii?Q?9TB6kXbK6RHmBThIVzmMbh1jtx8rsk4X4XFKMplk2ylI8bFML0rexV4ZvMoR?=
 =?us-ascii?Q?BY5IHvNDldI5y4FkUBAJuRD4EEHGjXST9QXKc1XNfGAA9EhHQdj3zRAWw5Hz?=
 =?us-ascii?Q?mUssTYHV0+DMP7kMUDjvNuahkGoVUtUeucQ3pyWD1IsizdhSUfOTHTIAZSyQ?=
 =?us-ascii?Q?9zBYx95WPNIiybn3YkZx7oHRUaPMeP1BbCxkI8vovalkgMIWlko+GoSU5OU/?=
 =?us-ascii?Q?HMqzBz/2kOiAVpHb2wHtvrBIVjGIyTvaunZLwCBypBHfG6WP2JG9WfczjWGA?=
 =?us-ascii?Q?IlD7z2XS2rSiavq6y07ztCGJ9uJ/sOSGydwM7jnnqeAhgr/k8F9Fgcw0LgjL?=
 =?us-ascii?Q?A+YRuHNMLCZapOIszmpYbAKvXC9JXIR3O7WdIxs9DG5AYW/iSKmYrgV6BZjI?=
 =?us-ascii?Q?WoB2JxDUr/96iSBUGAI9ZHf56iBBtzQIAZAUNt0oXVJNY/kOE1BfIdk2n/2G?=
 =?us-ascii?Q?6AQmTqjEz/sdnRTkPS7SSU4o0ILzIci5qPEESJg+GsVHRpCiOVjiq1tculaa?=
 =?us-ascii?Q?v7YL42/Sd/4UVNveMT16kWa+uqP456VhnpIiuH2Z6dTlWwt6q/gVfJvVuSlo?=
 =?us-ascii?Q?QQYKj/wiCFE14PxXEYA1u5mWS5vn421MR4/L0SsFBZk3CQqU7iZUGIocwCIt?=
 =?us-ascii?Q?aM/PIYPRg7nEETuZy3V4XnSDAlFs+HILTtZS7TYW1PQawVZYBJlDvPKXcoKy?=
 =?us-ascii?Q?zgD18yfyP2CvQMYdFKVK62tCRx00kzWSt1Mlk3xIv+ys48l1FGP39Lklw99w?=
 =?us-ascii?Q?8rOqVoLeJwp00n9H+1STMk52k1HBuZADwFoUZUVxe9InLimb85vO/gO8o+z7?=
 =?us-ascii?Q?+2W1l4wUDG+MYJq4hxrrvKeBKkxoOkv8YSB4jTlB18emuxIOnNp0eWeqHR4J?=
 =?us-ascii?Q?JbMHCI0j6QMyIGIQrqQKojqF0KUwtALSlL+Ht6kMO1AQBJq1F0y+k7rmrU8Q?=
 =?us-ascii?Q?Ry3y5fN1Ot2hkE3YsU1neP3ynxqX2yUztlEgOlY9mbTFrYYgeiu6Gel7cUxJ?=
 =?us-ascii?Q?j14phOmH68UZwHTXkbF+jGokfYt41rrP/vydlc1LOYH6wnenGVy82k01BwxX?=
 =?us-ascii?Q?d55CCcdfCHnc4FW+lISAJAmcf4HD32hNiJ9KpcqGNOfHF1I4SwQgR9a1ABa7?=
 =?us-ascii?Q?bxCORSNCyHPFaLc1cnmWnjVZxVzQttCL3yLsC1xaCcEDhRNHV0Pb8EDOR3aj?=
 =?us-ascii?Q?sD30RLv/rMM/KF9pt7tqkAcdJjC6TE/hFbt+1ZzHT0r5LCrBF6dWqFINe5dZ?=
 =?us-ascii?Q?NxH+Ux5rUwW+jQdN+cZcNC3xfe82uIITq1CTECOwehmOUItuaZyWusscHgE9?=
 =?us-ascii?Q?rLNKZQOmRVeRXRCtVnFNdPBO22nAPQUF+mnIwyEn7oDTkAKimYzh8dOpqJ2X?=
 =?us-ascii?Q?En8+vlCvQw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bZOFbIisZCipkpUnB26td8Sw6okEElIdC/0rmKls5PtvTBjRdsaAUR3ZM3mh20OmsIB67g1viY91fKp7hpLtaSIs1jxIRJ9wu29Sw8SBktoQyvZ7eq1MALeJdhrXQEqemO5fnrM6NS2HuNivSd/KcnZ+EVIiHeR57GePQvOotCBg75o8+xUJ6Fd8Z+/15SkmeMlF9urGjOIox+UHshg4LEcyCmHuCwYr4S5WSTBjxAwseURIr8v5PpbSIhi7q6T5NHryw3N55ntE9UobC0jxDSantBBQfTIRUXmL9qHxT3UU9rFcHMG5Oa02ThL/9MI6fj4UrBgUvPTFDfV5fiQvvg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6219.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cbc5e07-7ed7-40b8-93af-08de8e60150b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 13:27:25.4069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TCYUjzr5yolgIr+UgxD/msfPtG4/TC2xJjpFJENGXZTBBVagt829vrLZEIdxYoIJbrzFFv7yZDkAoY/hdIFXJDYJY5b5Li7xzEWa/xiy0F4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6072
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273187-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,linux.dev,kernel.org,resnulli.us,google.com,intel.com,gmail.com,vger.kernel.org,lunn.ch,lists.osuosl.org,microchip.com,davemloft.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 5CA8935C1D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Sent: Friday, March 27, 2026 6:13 PM
> To: Nitka, Grzegorz <grzegorz.nitka@intel.com>; netdev@vger.kernel.org
> Cc: Vecera, Ivan <ivecera@redhat.com>; vadim.fedorenko@linux.dev;
> kuba@kernel.org; jiri@resnulli.us; edumazet@google.com; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; richardcochran@gmail.com;
> donald.hunter@gmail.com; linux-kernel@vger.kernel.org; Kubalewski,
> Arkadiusz <arkadiusz.kubalewski@intel.com>; andrew+netdev@lunn.ch;
> intel-wired-lan@lists.osuosl.org; horms@kernel.org;
> Prathosh.Satish@microchip.com; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; pabeni@redhat.com;
> davem@davemloft.net
> Subject: RE: [Intel-wired-lan] [PATCH v4 net-next 6/8] ice: implement CPI
> support for E825C
>=20
>=20
>=20
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Grzegorz Nitka
> > Sent: Thursday, March 26, 2026 5:29 PM
> > To: netdev@vger.kernel.org
> > Cc: Vecera, Ivan <ivecera@redhat.com>; vadim.fedorenko@linux.dev;
> > kuba@kernel.org; jiri@resnulli.us; edumazet@google.com; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>; richardcochran@gmail.com;
> > donald.hunter@gmail.com; linux-kernel@vger.kernel.org; Kubalewski,
> > Arkadiusz <arkadiusz.kubalewski@intel.com>; andrew+netdev@lunn.ch;
> > intel-wired-lan@lists.osuosl.org; horms@kernel.org;
> > Prathosh.Satish@microchip.com; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>; pabeni@redhat.com;
> davem@davemloft.net
> > Subject: [Intel-wired-lan] [PATCH v4 net-next 6/8] ice: implement
> > CPI support for E825C
> >
> > Add full CPI (Converged PHY Interface) command handling required for
> > E825C devices. The CPI interface allows the driver to interact with
> > PHY-side control logic through the LM/PHY command registers,
> > including enabling/disabling/selection of PHY reference clock.
> >
> > This patch introduces:
> >  - a new CPI subsystem (ice_cpi.c / ice_cpi.h) implementing the CPI
> >    request/acknowledge state machine, including REQ/ACK protocol,
> >    command execution, and response handling
> >  - helper functions for reading/writing PHY registers over Sideband
> >    Queue
> >  - CPI command execution API (ice_cpi_exec) and a helper for
> > enabling or
> >    disabling Tx reference clocks (CPI 0xF1 opcode 'Config PHY
> > clocking')
> >  - addition of the non-posted write opcode (wr_np) to SBQ
> >  - Makefile integration to build CPI support together with the PTP
> > stack
> >
> > This provides the infrastructure necessary to support PHY-side
> > configuration flows on E825C and is required for advanced link
> > control and Tx reference clock management.
> >
> > Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> > Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/Makefile      |   2 +-
> >  drivers/net/ethernet/intel/ice/ice_cpi.c     | 347
> > +++++++++++++++++++
> >  drivers/net/ethernet/intel/ice/ice_cpi.h     |  69 ++++
> >  drivers/net/ethernet/intel/ice/ice_sbq_cmd.h |   5 +-
> >  4 files changed, 420 insertions(+), 3 deletions(-)  create mode
> > 100644 drivers/net/ethernet/intel/ice/ice_cpi.c
> >  create mode 100644 drivers/net/ethernet/intel/ice/ice_cpi.h
> >
> > diff --git a/drivers/net/ethernet/intel/ice/Makefile
> > b/drivers/net/ethernet/intel/ice/Makefile
> > index 5b2c666496e7..38db476ab2ec 100644
> > --- a/drivers/net/ethernet/intel/ice/Makefile
> > +++ b/drivers/net/ethernet/intel/ice/Makefile
> > @@ -54,7 +54,7 @@ ice-$(CONFIG_PCI_IOV) +=3D	\
> >  	ice_vf_mbx.o		\
> >  	ice_vf_vsi_vlan_ops.o	\
> >  	ice_vf_lib.o
>=20
> ...
>=20
> > +
> > +union cpi_reg_phy_cmd_data {
> > +	struct {
> > +		u16 data;
> > +		u16 opcode : 8;
> > +		u16 portlane : 3;
> > +		u16 reserved_13_11: 3;
> > +		u16 error : 1;
> > +		u16 ack : 1;
> > +	} __packed field;
> > +	u32 val;
> > +};
> Why not use FIELD_GET()/FIELD_PREP() with GENMASK()? Bitfields are
> compiled differently on LE nd BE CPUs.
>=20

Thanks for your comment.
To be addressed in the next iteration.

Regards

Grzegorz

> > +
> > +union cpi_reg_lm_cmd_data {
> > +	struct {
> > +		u16 data;
> > +		u16 opcode : 8;
> > +		u16 portlane : 3;
> > +		u16 reserved_12_11: 2;
> > +		u16 get_set : 1;
> > +		u16 cpi_reset : 1;
> > +		u16 cpi_req : 1;
> > +	} __packed field;
> > +	u32 val;
> > +};
> Why not use FIELD_GET()/FIELD_PREP() with GENMASK()? Bitfields are
> compiled differently on LE nd BE CPUs.
>=20
>=20
> ...
>=20
> >
> >  #define ICE_SBQ_MSG_FLAGS	0x40
> > --
> > 2.39.3


