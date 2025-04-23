Return-Path: <netdev+bounces-185304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABB9A99BAC
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 00:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C44813AE819
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 22:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAFB200BB2;
	Wed, 23 Apr 2025 22:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ozm0Hv8d"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D7C1F584E
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 22:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745448633; cv=fail; b=WH2plB7EDIBwBKZBBBqk2CH3Rlwd7zV04GPBaiaKPUHmfIvW4bYoR1wUnkTTKDeE3ojgezwYAxFfpnel24I5/P9I6DgCrhFG/HyxYha/UB910xBlyQQOaqSmpH/reLerb1hJpDzz4wz/bCaNNaTkUH1Nd8CUDs9UFYKgFMAY8Bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745448633; c=relaxed/simple;
	bh=EO/vMn9K6uZ9vuv0GnLZsQLD5VkmGTEQbY5r8al3Ipw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gGxluAEruQLeJ8T8916ocwaGs9OvnT+VVGBW2kU7692txf8jD52EJvZokasMeSO90G+JnAgZaHWBENQAj6Mqxo3MEq1EoIO6XOIssFa2YpKdjUbCJe15FxT1IbbU+druOEOjj6yUwZfUj6wKCodZcdCgsjMl21pTmzMsBFoJEn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ozm0Hv8d; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745448631; x=1776984631;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EO/vMn9K6uZ9vuv0GnLZsQLD5VkmGTEQbY5r8al3Ipw=;
  b=Ozm0Hv8dpDKSbgipmmbKXQrpaBHvw1Sdnd0WoAXSJr098fMH/Bx+0l9o
   rd/L+tWHtefATZdk7TqKp2gGUAVBhK1L8LvsBvNFUiLoI331EQ8VeRney
   3aVQ3HXkd2JMlgoQ6XVh4PmSG91jvVR8lxDbTQZtDK1RHozYaPDpx9bpo
   2Rq28IjPTsC5tRMeu9bsjh7BQB+YjUsZiUFLMhLWXAnzsu9GZjQiCLWMn
   BlE0DtBEh9grmzljA1rHu4gAFkjNRwc+KJ1orzA3dwhy4rhKHBnQAkPP3
   37DFPQZSPeYYQ7GGI8jVVVptfYubU9FC8jGA/Q2qE11tBhVzxCJZpcyQ/
   w==;
X-CSE-ConnectionGUID: +oASr315TLWdu88CWNT2yw==
X-CSE-MsgGUID: 8UViPuO0Ruejyb4lJYY3Cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="46972380"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46972380"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 15:50:30 -0700
X-CSE-ConnectionGUID: lbxic1OZTfmi7TssXllLRw==
X-CSE-MsgGUID: dUff5hthTwSBzcmeyRutMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="155667192"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 15:50:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 15:50:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 23 Apr 2025 15:50:29 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 15:50:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mlcHFlkfCviIlAVKsKejJ2yU9CpeyI2vqItqElplbYPa6cEAmj9MKJoZyUiPnJvB2ndTH2nKfcQypU7gYwi1OFaJozPkTTitYfY+uaqpy0Sjikp8z2BLEu+1VcErJe5US49+0vwJ0yCUHnGQlQfc9UbZWzlWUSRZnPok+sH1MN4fl4xjH+LHBA8SXC+J0KS1b41n3GD0fdBNWIs+VAppvE2UWE9ul5TIczxACqyNnHNoy2jER9wN3O/CALOZXyEm4Zckgk1xmhjVQ6r+iLmNLjeSUB9YIMJzpiu5WezZ+1pVbGRFcpPi3d+Unu+aW89i7S3h+Z3R540X0Uahj5qP2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhMrfEjBpy4pqE9o7eGUcReWlE+S7njPbb/PacjitNg=;
 b=vED/sdSCWAMxG/T7fn7mP2r09QvhOuKYjGxpZZ9QIDOt7BtG8WCvr2PRlKYF6ysL20ysHC0FHvi4fjTHTTXWOMU001275hmNQFU1g1uEymzpdwwLd7spfWVnPjwKXFHu3K4bTkoHfRXHzDBIxYPeJXFUalSIsryW8X4ae81SHmMEaziCzRKOA4W9lP4B+BvwGmRtnqCCqYaR9jjoXU23Flx8yoE/Daq7Kg/hX1+1XmoZSZ0x2NkHTHVsSGnli0jJDgqOYQVDB6IODqqiY4if6zZmk9G+jwu2czcEhWavg9k0SU794w909oV6FucyiyOq/+5YmflJ/gSsZSqaVpDc+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW3PR11MB4634.namprd11.prod.outlook.com (2603:10b6:303:54::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Wed, 23 Apr
 2025 22:49:54 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8655.025; Wed, 23 Apr 2025
 22:49:54 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Dumazet, Eric"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "horms@kernel.org"
	<horms@kernel.org>, Thorsten Leemhuis <linux@leemhuis.info>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "danieller@nvidia.com"
	<danieller@nvidia.com>, "sdf@fomichev.me" <sdf@fomichev.me>
Subject: RE: [PATCH net-next] tools: ynl: fix the header guard name for OVPN
Thread-Topic: [PATCH net-next] tools: ynl: fix the header guard name for OVPN
Thread-Index: AQHbtJt0+dIqBDqntU2/oPCG3b6+0rOx2sfw
Date: Wed, 23 Apr 2025 22:49:54 +0000
Message-ID: <CO1PR11MB5089A6F67F87DDEB7B3F0711D6BA2@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20250423220231.1035931-1-kuba@kernel.org>
In-Reply-To: <20250423220231.1035931-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|MW3PR11MB4634:EE_
x-ms-office365-filtering-correlation-id: 70f4014a-10bd-4859-bf49-08dd82b92a5d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?0xdZKxahLZnWuw3khMdSEKj2U0Y+8vIFhRtJ8F8467+8kINfCiJFiEPITOj5?=
 =?us-ascii?Q?1FEoJPbqz4vXbBz2Nv9KYxa6IHAEDUIyb/pjibJMugr5Kr+fz1fSwi15vXXm?=
 =?us-ascii?Q?DTDRx/jj4VzqLLOqg8KWAF0OHgHQmf2VBvbOh8s69u3WS0oO1KCOcofccRYZ?=
 =?us-ascii?Q?peUZleKWtfSdK0hIQxUIu1sZQrD3tTni7fkc9rm0jzpNF6s4cqqQuop0uKEq?=
 =?us-ascii?Q?pcdRziEI56FHSUnOmyikidvLWNgFf9PJZ33Hk/yOFXVLNUz+TEKoYABl2Nz6?=
 =?us-ascii?Q?c+o8bRcrYc9QAGreTpqItIomIetHjGo50jM2LFcMOpukm6JuAFiL8E1JLBfb?=
 =?us-ascii?Q?Ol/fjnVFdXGuKCyNZMRA/Bymg0w+vky7XEd1Eig93Bqmn+c54Bg+XyLKGqbw?=
 =?us-ascii?Q?vTwcZAIWb1S1vDZ2ugRTp8Gsar+4uyIwp5RJhUE6zcr0D1wMKjWYix3IC9k8?=
 =?us-ascii?Q?IY86b/NdqfPCIIKkDGHLWWp2Lu92C4VqN0JHBNKGk8ifnz0i9SC3w+7b2WfW?=
 =?us-ascii?Q?pssHbrtcTZv+I4VYXf452vbPwURm3OvukuPwVOTygi17p68sxCx4f/DQQYti?=
 =?us-ascii?Q?NM5dfqxCKLLkLIybo0YWBsWnZaPtKYP0Y3lGSM2CD7mMFdw4rgbgtp7isloG?=
 =?us-ascii?Q?nYnwI2v0t89DM8EHqxybHMye2jsFDoppx7IaYbRTsjeVpKVK53IiqAkXmTfB?=
 =?us-ascii?Q?vImKb9/9ZHwjsgMDCjF+C7nq0r/7wIQW1AtwZB1hQWAD1uyx2ZViefXp5U2/?=
 =?us-ascii?Q?NpQSbS8jsn8CDrFhAFTGwpWcrlMeiN3pxv9qb930EIvFjXZCKGd+Jgf2gQK4?=
 =?us-ascii?Q?GEAZY/S33CDQkpPngBq5Hp6y9M649woFX+QG6SbHcKc1nrEWsyCgUB+9WZSC?=
 =?us-ascii?Q?c+kB7v9vVux/gkQ/6BFOv75zvn56FFWJA45Epcme6riBOPC2tapc5LmVohui?=
 =?us-ascii?Q?rr7pa3uZjjrMp32NfJn/k4koAXSjLrxv31dDMvP9WnkwBZxdDndLmwGeaKsP?=
 =?us-ascii?Q?pZs8Ea/jx4KN1EAkFZtgLtq/sQFWv8X5+VI82OWJ1t7QdzO47wuOX0VSGgDE?=
 =?us-ascii?Q?2Oolc3SztW0R//7CK7DdZXE8Rk09taVhvFTYPO0OUGRm9vAIh+/3GDXTqIDb?=
 =?us-ascii?Q?vnjMs7H6426RrKnEVlLuAPm4F/8flScrkKtTFyxEbYkoZaWUVyLDFqcs+yBa?=
 =?us-ascii?Q?v5VIgvzzLxBG4JRd00/iTmes8vEQwOqUMYk+3lBFGCG+x5om1BUTbDFKfGd7?=
 =?us-ascii?Q?kmGFoudJP/TCh/0Cis+Ht54+3GX4zNg0T1fJinvt5NpXP6jQJ400DDaNBX65?=
 =?us-ascii?Q?mb7tdyUs0eM0iorQC4CCdiKdtI4l4wPaeHvtPSACPDwlB8H5aB91qIyyvryq?=
 =?us-ascii?Q?BV+D9kRgxrbXzNfT1w6uHg16QOM0U/LBnUkc+aN2Hih7hM10pArxnkbfpqk3?=
 =?us-ascii?Q?jv5+yfHgyOqz0my599JYz36rGb5zc5NkjltwjmoNotc6LNIpqwqK+Lrosvst?=
 =?us-ascii?Q?JkFs3AQ90lQyz44=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N4SpqFpdUyeJ/t4vdeww+wUK3NU0a4Z/Ufl31kDZH7hWaooI/aHat+wPrDKw?=
 =?us-ascii?Q?pI/96d52t1XAhZ5IzBrAlaNczySprxeaLaiulY7Pn6p0nh15y37hFnsDE2GH?=
 =?us-ascii?Q?1ZOajOAoTUXBcpqxBHHHJoRdsQeQXx5u5dKa8gPmcQoui8cND5YCjkJ1v2GA?=
 =?us-ascii?Q?cWaK6COwCTa0/UhbdgvOveIkHG/hOdZE221yeLRQOcVTegw+sV/J/C4XaVjZ?=
 =?us-ascii?Q?pvtbtMHWhwthb4SePjmY10eiA293f+fO32XXZBSCDfETYHYQA1LWe/o2VdK9?=
 =?us-ascii?Q?6BunNlqbS8M0UqgihLYoOliRT52A9YJSQ0smUolkBKMSVW4Xw9ffoD3F653j?=
 =?us-ascii?Q?Sts34Ovms94hpNzqaVuo3dSy7s/VUIlyBdnRzYEgVb8nGOHUIw+TBhx09RhQ?=
 =?us-ascii?Q?+1LapUYOoPhrjU85q/l0zZLEtR0DiuOxcZ1y+dqi8M72BkvcXcIyp1y39Ztq?=
 =?us-ascii?Q?8MZUtuQpxgNYE4I8X2/W7xpKXlOpmbeRYqxfPJbsEeAOqkvxs7fq85FX1oPB?=
 =?us-ascii?Q?goAqVHXHpP72B7RLqbTm/uebEl77863t150uEWLr+0yaZa1n+Cdh2gpr7Nzh?=
 =?us-ascii?Q?D/qH6AbmzyduYd8So2DYdciTMUYJ+eaTtly1H+ErGAsiZZJ4gJ0NY9AhX53g?=
 =?us-ascii?Q?FF8WpeL979Xzq/f3HnC+w1hV9rmjucupi378RxbwqfoSvLAWCuxqpGsfPPMZ?=
 =?us-ascii?Q?pdP7+VgGz3wtrDOrfDQVbZfv0rAdaYOdr15USc27vDoK200q0/WR/iWaf2Tb?=
 =?us-ascii?Q?LI9nQ0JcRDxlLLGeqrtBmPwOGKJik2Vy49JOONKkdzCtuQCbF2h2tVkUZYZq?=
 =?us-ascii?Q?E19Gr1Qj1ZH9XUvGYN1zoe7RHXA+VPmH+i0G5FB+5g5ZyevUTha6iKVY2GFL?=
 =?us-ascii?Q?6fiZSodkuYlOLLhXBg2tH+ijLg/3UOSS/JEuVaeV6qs1ItLS05nIg2CoKTHi?=
 =?us-ascii?Q?pqpBKjj8qQQDipfkzFNvzO0q0FPwi1i9dFsfAo/lSxAvXZuqIAxz0y6f43Z9?=
 =?us-ascii?Q?YPVEskrGASkMEunDgfVtxuPQm5sPKuTPpel+rxbjeC99VmMo/YYza00N9dOJ?=
 =?us-ascii?Q?WaDcEiHvqhbMB7urDdcmQOwbh6ZBpA6uc8RGtUlc6uzXotOWuGktcLFerOnk?=
 =?us-ascii?Q?2BG3/2sAlvN5xsSOB+8ofycMENVXbz+FV4jgt2Wnvr9tG5rifksA5YgbL9jD?=
 =?us-ascii?Q?tBXmdopUrzpSuUuACJ2gbuNcZFH+wO6EncQKXwT5kGsgt2R1JgHdL+9ary8l?=
 =?us-ascii?Q?5qokTPbjM8iWWshEoTc2UoVT+MmewvMe23ecTohhkga4jCS+eNz4WlDrkXhF?=
 =?us-ascii?Q?lciQtUIV4N5kAxXuZj7/yTxNRmuguPxd4qz7t3l8uzBAqbKSRzKXJN+d9vcy?=
 =?us-ascii?Q?9giGp/v4mOhl69j0LslKGDhJX3SvIq7I75O5roCQ2ZDBB9HwsWaoWcqF3nps?=
 =?us-ascii?Q?yPBv4B3ygmjBOLQCkvYYe0VqP3BpVreakD7Xa1c3DPUIwlqY1Y4n6Xx/V+pa?=
 =?us-ascii?Q?0h1RFAnMx/VxdmK0FcFMk4F6CfDSiArqeymp0J2Q9k2fNNBszcxvOaxCyn/X?=
 =?us-ascii?Q?rZKvivfniY1vzLkgYrkoo24iAn+zfH4xR/z5tl1Lm7WqACmofCoIHGQQuVCK?=
 =?us-ascii?Q?1w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f4014a-10bd-4859-bf49-08dd82b92a5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 22:49:54.7417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7g3/opaA5mIlPKipu1IMWylPKp0mVqJI32wLIbnJpfVV345wm775jMhVl3ARIvxBohEsEC/wOdlTUCjj4cn86irYvb7/lGW8+XvIpFZMkaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4634
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Wednesday, April 23, 2025 3:03 PM
> To: davem@davemloft.net
> Cc: netdev@vger.kernel.org; Dumazet, Eric <edumazet@google.com>;
> pabeni@redhat.com; andrew+netdev@lunn.ch; horms@kernel.org; Jakub Kicinsk=
i
> <kuba@kernel.org>; Thorsten Leemhuis <linux@leemhuis.info>;
> donald.hunter@gmail.com; Keller, Jacob E <jacob.e.keller@intel.com>;
> danieller@nvidia.com; sdf@fomichev.me
> Subject: [PATCH net-next] tools: ynl: fix the header guard name for OVPN
>=20
> Thorsten reports that after upgrading system headers from linux-next
> the YNL build breaks. I typo'ed the header guard, _H is missing.
>=20
> Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
> Link: https://lore.kernel.org/59ba7a94-17b9-485f-aa6d-
> 14e4f01a7a39@leemhuis.info
> Fixes: 12b196568a3a ("tools: ynl: add missing header deps")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: donald.hunter@gmail.com
> CC: jacob.e.keller@intel.com
> CC: danieller@nvidia.com
> CC: sdf@fomichev.me
> ---
>  tools/net/ynl/Makefile.deps | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
> index 8b7bf673b686..a5e6093903fb 100644
> --- a/tools/net/ynl/Makefile.deps
> +++ b/tools/net/ynl/Makefile.deps
> @@ -27,7 +27,7 @@ CFLAGS_netdev:=3D$(call
> get_hdr_inc,_LINUX_NETDEV_H,netdev.h)
>  CFLAGS_nl80211:=3D$(call get_hdr_inc,__LINUX_NL802121_H,nl80211.h)
>  CFLAGS_nlctrl:=3D$(call get_hdr_inc,__LINUX_GENERIC_NETLINK_H,genetlink.=
h)
>  CFLAGS_nfsd:=3D$(call get_hdr_inc,_LINUX_NFSD_NETLINK_H,nfsd_netlink.h)
> -CFLAGS_ovpn:=3D$(call get_hdr_inc,_LINUX_OVPN,ovpn.h)
> +CFLAGS_ovpn:=3D$(call get_hdr_inc,_LINUX_OVPN_H,ovpn.h)
>  CFLAGS_ovs_datapath:=3D$(call
> get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
>  CFLAGS_ovs_flow:=3D$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.=
h)
>  CFLAGS_ovs_vport:=3D$(call
> get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
> --
> 2.49.0

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

