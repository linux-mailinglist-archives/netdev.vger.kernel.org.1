Return-Path: <netdev+bounces-277794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uODqHGSj22kqEgkAu9opvQ
	(envelope-from <netdev+bounces-277794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 15:51:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C24B53E40FA
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 15:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38CCA301FD62
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 13:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3664D1A681C;
	Sun, 12 Apr 2026 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KPdF9wEU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE1C78F4F;
	Sun, 12 Apr 2026 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776001834; cv=fail; b=UovYhRnI3MX645d1FwuAhLdJn+nez9fBfiGpBavRL9O6bPOTquGABdr889R9Xu09i0zkexa+izZOFb50bkW7yLiQgR8alisNPGF0g1PYqnt1t0Q6EuL6NOfcO5hFuYrVSHuP8P3kZyOJrFJGKXy418Uus2QnHLun8JqkXGBOsrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776001834; c=relaxed/simple;
	bh=YbvQTwqky+oI6pKqe3iqKbyW7M8HuFvrflJOds2AYLs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GgcrZAJO+CMz03TWNv5+39BuaIhSlP5IjVNUBKH76LkroTj8h57nJil8/uFmrEBWV+kfrda43vaikDPzuYn/rvrJDhORrJ62qXIhoSznsqKHxFxCvvYtyxD1PdR2OX6OTkGNWn14lE2pD8yMX0jReQfmcez6t+1UtohUURDu0Z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KPdF9wEU; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776001831; x=1807537831;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YbvQTwqky+oI6pKqe3iqKbyW7M8HuFvrflJOds2AYLs=;
  b=KPdF9wEUTvRVpveNvxAuGygwRD6jI/GGl9nPy95gcs2U8AspOcNf2Q+F
   eRzJmN/66sil8qcLhcAUPOj8R5sDlLoxYDN6j96IRyQN1dln/+/7eC1nC
   xxI2sz4NlPebzOqsBBsBxrJzcZK9+1nVZ0jPohu5JOthgox9a424AJzTR
   BVaYo5dOGnlFWvJNd+irTxrXbSp2IcNOu4PjR6XokOoDDYS0YmVxtt5e5
   ph+5c+9UY4VQATRP+tHpU/LDlNrn+xQFBwWd3unbomxeSEvMHx/dCCJdT
   tlJTRkG4UNxxg0bSjcDn1xTz9iwZSE55QcvpZryirZXL4r6b3GE/peK0v
   Q==;
X-CSE-ConnectionGUID: 3dVQUArvTjiJZ+vDJs+tNw==
X-CSE-MsgGUID: E6yQQf0xQ+m7yxPo12guPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="88402093"
X-IronPort-AV: E=Sophos;i="6.23,175,1770624000"; 
   d="scan'208";a="88402093"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 06:50:31 -0700
X-CSE-ConnectionGUID: rVrAJw/pQDSujLW+5DO9Cw==
X-CSE-MsgGUID: oSuTF655SAGS1GvrDPf8YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,175,1770624000"; 
   d="scan'208";a="252953013"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 06:50:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 12 Apr 2026 06:50:30 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 12 Apr 2026 06:50:30 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.56) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 12 Apr 2026 06:50:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNzbQHD04ZJY+9wHCKZM2uD605DmeVGubrZhrmrWI/8MoHq3SNqKeGVAPxZ74lS3ANAH8o265tkY8bJYwxlqxZf6lltcl3RICaokhcojg1dR5VKkSuu1ehHUchwr6q8mrAdkXs3kV7WX1+kSdti0qnSPO3FrkBjNJZB3p5Ul69AAbv6pRSHGlmcwSVQLpYRrH9Xv1siP1YIK7cCFVvkAU0T90w8rjTDrGcx4HrahZKqMFu3MJ6W73e+PulmOaI/2PGNJ3OHvHYa7fGCh8ixdofYrLrMty+SFafEwU/YZNR2MYvu1ZivkeyZpVYxIduiIO86hGf8+x7Lknyy8j8UXAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrxcOmts9qZJKTVfGBQIZ/aF8ubyipowGnIQvpmEcEw=;
 b=gBdxBIUZStVoq4HikifoOFi/sQfqyU7rP8wXCaGOZ1l60l+dx0quJZGe7Odwbgck31FGgrx2ZbdbUegoG/1qYiOsIC2APQizPLEVDq6d89pLPSVCF7OuIM/c/aiQgATvQBBkhNwYaEuFQ7bmNH1O0sR6erucUwHs6Uq0brc98U+E12brDXsQgVAGMX6DcTgECk5sQllRRp0b3NTd3UIraZw9dmz4fTJVpY28zfcnA1miBeUtUqxkAX2Ejg5aN7W6SFF2UHVbKSgodvKB3aTVm1vIC5Tj9688Yg7ViwyuKqM0iyeb1uhpP5svwMXcX+lBYdGofFoDEgxcOXELM0LAVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6219.namprd11.prod.outlook.com (2603:10b6:208:3e9::15)
 by MW5PR11MB5905.namprd11.prod.outlook.com (2603:10b6:303:19f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.34; Sun, 12 Apr
 2026 13:50:24 +0000
Received: from IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31]) by IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31%5]) with mapi id 15.20.9791.032; Sun, 12 Apr 2026
 13:50:24 +0000
From: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "Oros,
 Petr" <poros@redhat.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Prathosh.Satish@microchip.com"
	<Prathosh.Satish@microchip.com>, "Vecera, Ivan" <ivecera@redhat.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "horms@kernel.org" <horms@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>
Subject: RE: [PATCH v5 net-next 0/8] dpll/ice: Add TXC DPLL type and full TX
 reference clock control for E825
Thread-Topic: [PATCH v5 net-next 0/8] dpll/ice: Add TXC DPLL type and full TX
 reference clock control for E825
Thread-Index: AQHcwvXi5hF918e07EGu/X9NQPzLLrXS5QsAgAO6hfCAAOg2gIAA3TpQgABo+QCAArI4gA==
Date: Sun, 12 Apr 2026 13:50:23 +0000
Message-ID: <IA1PR11MB62195E2AF6FE5B102B2EECD392272@IA1PR11MB6219.namprd11.prod.outlook.com>
References: <20260402230626.3826719-1-grzegorz.nitka@intel.com>
	<20260406192312.0f7a2760@kernel.org>
	<IA1PR11MB621925C1718B838147404DC492582@IA1PR11MB6219.namprd11.prod.outlook.com>
	<20260409181041.395a0c37@kernel.org>
	<IA1PR11MB62194BF52262FCEB7FD5E76D92592@IA1PR11MB6219.namprd11.prod.outlook.com>
 <20260410133812.4cf9b090@kernel.org>
In-Reply-To: <20260410133812.4cf9b090@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6219:EE_|MW5PR11MB5905:EE_
x-ms-office365-filtering-correlation-id: 6d4fed80-ea70-4ae1-7c15-08de989a721a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|18002099003|38070700021|56012099003|22082099003;
x-microsoft-antispam-message-info: O5TK/W0UzvvbUjvD2nW6aKtAlVTsMQAfnmYEa2nK8/o6JqyBFffHRWgS5czaTpYC45i7kwz8K27eTyzKDBVnjLbvizZB7Dk1xexmywUfk3vKVnVsiksg0IvHslPlxLIxp1AJysB9AHtRgH+WE3VL+myGFlKcdyG6qHF/kuM/n48Dlkh+3Hrl0gCaTPzNMJ0e2r5ExaQbRyxIiyVPwP1QR6bXW9+2BhUAu7KJXQAzdu4XivldmE2b+rgLbY6sJAttjxenIwoES7ns8QzYi5kNeBRoipiJK8ds+u8HvGqC/SkdpuS2TXUiE0WSbwlzLbThOfiVEI3iF3dq64Pm/+N/vSYFD9TKcM+jKAnt+dZFpYE/Z8jScb+q3ydu3Pv83C8UDXDXyTAXQ411jgEqUEhFqp7IkyQPA/Fxr0OgGnoYn05Pwk/1t6gCut3fCG3ZSL1ZxcTV/vEeZlUbGajOSRcRfkrOqbwz1JSVbJ0t9g0mX7vgMzwVirz8b/P8HfhT1SHHDxACbmwMmNcWXs1dhkAF3vcYAmSw18QXjsJSVOiH5dlaDdIM0iWMXU0RPm27M+3Ozd1UC244DGofkKlfyFT0j1T6RMdqfb6aP8W7y2JjF1YvYk/kYu9o6hbxUO1PC8+BDOaL31saTVnIwXq6zg1EhmME8wTAwPHUgcAjF4GPfLyphmJI0kSdeJGqoMsFsIxj+57M+MNKsoe1tkCVJV1CMDo3PCja0WyQVn1ErB8lqbJ4US3Tk1oGerPo6HvvFRFZDxfo3+Yj625Gb9qCM5OLX7e1Jx9WPlXTxVn+BLk49cY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6219.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(18002099003)(38070700021)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qnByytyjOC8Y5koZHpjzUuXPCTzL7H3gILtnrjwKYqW7xCqEo6cXbLh2ONj5?=
 =?us-ascii?Q?YuRdOYhGLM9F3yO8VXoq+2T2BgAarVL6qPC78E0A+EDcra1SyeRDXIzyWKKs?=
 =?us-ascii?Q?A18ei7LJhJTpg0vZn3UUGAdGRhF0TYtT/3/ubTZ7qwDzZt+lc62vfcT+NFcz?=
 =?us-ascii?Q?+GZUdF1YFnLZsRu5BUDpOvkmgKyIDM8xXLJpawms6Da2jtlO0qq1PFUZfnLr?=
 =?us-ascii?Q?xwOGvSEoNN93hQLLgJI86SYjNirJerBAh02vF3G30IQFZZzOlBgigtyFyjAP?=
 =?us-ascii?Q?q2JnMwRE+7kQUu0O84JuBZdOkaRr+lycdzmh4f+extca+Xj7x/PNDHtRv18B?=
 =?us-ascii?Q?LQL5wGDyijJRnmdUXlsS5rAYXhIcjgFO4xERFKCHu3ICTNEaDziMa2z6UbcL?=
 =?us-ascii?Q?u917xGOJgy8cc3f8XQ9jh3ZWo7nb5OWAi090AHya8cUN/IVlMhu+yA1xm9BM?=
 =?us-ascii?Q?NAyb5ALa8HEMFmob8AJs/HFankq0Fi4SN6l9PHCbslZ2a5mOUbWe05J6VPoQ?=
 =?us-ascii?Q?zXsrdqpFKeg8rX5TzxYmOExpOakXmVFnl3MR3flaOs3S+Sy+Gc2OXAgR16Wx?=
 =?us-ascii?Q?hgZCeVrLgPn65IDmVYl9baZEnNn3DY1W38OYIeYOo9vlOjOUph09qMS9JUS1?=
 =?us-ascii?Q?dJxBIatoEwtHPH2jXgAdUz+ut8yTzOHsFU/0JEXg7MVKMfY+fLiix0ZTd6Ap?=
 =?us-ascii?Q?3qX2HPU7tJqRO8MpMxvH/dRw56MZz5DTln9Eue7vFArPPMMzHKs2l/s1tvy3?=
 =?us-ascii?Q?5MuLj6IVDQ64nr4gvLNVf6U2hGUi2e5HCINsOBz4O+KvYnCHthQzIxhgzlPc?=
 =?us-ascii?Q?/knI8GcqPKIy8s9QnmSONm5ajtWJGkKBwaVTbo/kGGxJ+If56qR6hkCC++Yz?=
 =?us-ascii?Q?1X/aEWPbEE3ZQjLgJ9if3YMuvy5FZFAotV+LQLcH5bTsXG3VXi0iEA52s/VA?=
 =?us-ascii?Q?qEHHT+XTwDcL7+nGuniyMSVkmlQhcSXlTJYM7d4irwOpT4Ioiu35MYgjJrLT?=
 =?us-ascii?Q?3lNBgzUXXcmn8zz5COnJ0Z5KHzzArZLjX5CddFyLIEjv9GjDVNFX7GXYW55u?=
 =?us-ascii?Q?wDDA1X7prLqnEB2Vq8domkQS4pG/iKzsDrQTA49zzoX5pdeoPck7ty131FVn?=
 =?us-ascii?Q?7GXA+ZL9kxaNOs34S3CuakFneVW+YdsXXYgnV0ah/MeNQZlnawiNp+PS2w9k?=
 =?us-ascii?Q?3b9k+GV4FvYAVjx7znuL5f28kp5rTUfv5TH4GdpL3pvV194WLgPKbK/Jx1Eh?=
 =?us-ascii?Q?Ll4uOX6Jk/s6SOS7YbjAjs6ndEmMi/uGMIbiVKzbSu8B1rQpvS+lZ+MrvYfP?=
 =?us-ascii?Q?9OrvDUhoRVT+Bgipv+w58htqBtaq5/olvPxDehgwQsQvrcozF/880wkVCW3o?=
 =?us-ascii?Q?EFMEmOaz8dPh45KUNI5mirPAGoFijyLGopIGXiBpXadFfLd/CpdmYpLFTVFN?=
 =?us-ascii?Q?AVeuxz6t4I8o+1FEeSmGoysMacT5QiOsl5aLf+hYqwFwxOG5KpaT/dOzq01I?=
 =?us-ascii?Q?GNl66KIE0DmRh0to7bn/yqkjSkLMHQQA1Z+JykvCvcejzvgat5dZb+kwrf/M?=
 =?us-ascii?Q?9gBmZp2QgJ6OBxeGBhdLSQe0DQRzTHAKNwDIVQk8XDq/si3Cl9pcqXYGdMVW?=
 =?us-ascii?Q?rinButBV54N9DwE8HWyxMi1a14bFCKshE7F8/95toYso7fQ82GaUfi9lsKLV?=
 =?us-ascii?Q?QJM+7S1xM1ImoS9d9O1uTRYxx9Vo6tQmOBs0FeYt5TdUz5WD+5fWQO+g7Ajk?=
 =?us-ascii?Q?DTOfzgevZA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: e6lht6GND8rt/xPYyGq8bvBl/Ry9y4qok3ElJtWJq1i0iu1LY/+atUa4I9ut86zShDfLKc9J8NpuMk+G/VQ3evCF1wpAAm2bYYHzqrYNL/6bZJjZmAs2D6xgL0OEPBoaDTIwy2wRU53jmu3oEROikfdGtHuKDFFyHNqhYxGjTMTKxfYQLRGqpoIT4zXz/WKT/x8jlGQvrR7dPx8uYs7OE9EPZA8JnAq3dbQUgkRqf0esmORB9geDEpnkDyZNbfNfLiL4aAFRweuUVXm9Jy6GMVp4rKCSQpOeTFilifyq0QCpA5RyAnk+TWfM+eCSWk94eNHK2pRadMlmLzrDZ863Yg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6219.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4fed80-ea70-4ae1-7c15-08de989a721a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2026 13:50:23.9663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5vsDYIE23X5I6EmpbPNbBOANP4Pw+xxlZkLoeuOHpVzwC05jNpIhRfMxYlrNqcvmGfqL3BKeiai6XGe+yydfo3PTibl/LD5rGUipkGzDsik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5905
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277794-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C24B53E40FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Friday, April 10, 2026 10:38 PM
> To: Nitka, Grzegorz <grzegorz.nitka@intel.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; intel-wired-
> lan@lists.osuosl.org; Oros, Petr <poros@redhat.com>;
> richardcochran@gmail.com; andrew+netdev@lunn.ch; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Prathosh.Satish@microchip.com; Vecera,
> Ivan <ivecera@redhat.com>; jiri@resnulli.us; Kubalewski, Arkadiusz
> <arkadiusz.kubalewski@intel.com>; vadim.fedorenko@linux.dev;
> donald.hunter@gmail.com; horms@kernel.org; pabeni@redhat.com;
> davem@davemloft.net; edumazet@google.com
> Subject: Re: [PATCH v5 net-next 0/8] dpll/ice: Add TXC DPLL type and full=
 TX
> reference clock control for E825
>=20
> On Fri, 10 Apr 2026 14:23:58 +0000 Nitka, Grzegorz wrote:
> > Here is the high-level connection diagram for E825 device. I hope you f=
ind it
> helpful:
> > [..]
>=20
> It does thanks a lot.
>=20
> > Before this series, we tried different approaches.
> > One of them was to create MUX pin associated with netdev interface.
> > EXT_REF and SYNCE pins were registered with this MUX pin.
> > However I recall there were at least two issues with this solution:
> > - when using DPLL subsystem not all the connections/relations were visi=
ble
> >   from DPLL pin-get perspective. RT netlink was required
> > - due to mixing pins from different modules (like fwnode based pin from=
 zl
> driver
> >   and the pins from ice), we were not able to safely clean the referenc=
es
> between
> >   pins and dpll (basicaly .. we observed crashes)
> >
> > Proposed solution just seems to be clean and fully reflects current
> > connection topology.
>=20
> Do you have the link to the old proposal that was adding stuff to
> rtnetlink? I remember some discussion long-ish ago, maybe I was wrong.
>=20

Hello Jakub,

This is the patch from the discussion I put the link in the cover letter:
https://lore.kernel.org/netdev/20250828164345.116097-1-arkadiusz.kubalewski=
@intel.com/

Regards

Grzegorz

> > What's actually your biggest concern?
> > The fact we introduce a new DPLL type? Or multiply DPLL instances? Or
> both?
> > Do you prefer to see "one big" DPLL with 16 pins in our case (8 ports x=
 2 tx-
> clk pins)?
> > Each pin with the name like, for example, PF0-SyncE/PF0-eRef etc.?
>=20
> My concern is that I think this is a pretty run of the mill SyncE
> design. If we need to pretend we have two DPLLs here if we really
> only have one and a mux - then our APIs are mis-designed :(

