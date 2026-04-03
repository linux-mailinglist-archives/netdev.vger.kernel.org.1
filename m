Return-Path: <netdev+bounces-275208-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OcHBMgi0Gkp3wYAu9opvQ
	(envelope-from <netdev+bounces-275208-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 22:27:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 049C3398285
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 22:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 23709300BE01
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 20:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81193D7D83;
	Fri,  3 Apr 2026 20:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MdPvsNR9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C15E2D781E
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775247985; cv=fail; b=S2GYM/dX2tBf9O6jCrd6+ADzLLOnS1bQxlWj4ejTE8C/doMMeYcF9KohOIozLbda0CByvcKY2Mz4ebciAeZHS2182X9aml54MO3pECs6O3Hu4OCZwRuUs2n2rCgmCt5OnGo1kS8fy0HpfAl35oqny+oJ/HQmbifMA51iWXV3XwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775247985; c=relaxed/simple;
	bh=7Zew1VOyf79rNudxDYle9PJPLAFepmPEvwn3Hydzr2o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UL0R1WY+Fe5Fbngc0G/WJ/jrKeQuO1FECtjcBZRyvhfB9V3IhjBHZP1t1+uVNgzjtxw5OW3KJe9VDVvExBEHx7lP1BQavKd6205PPRZIBnUuvoD1WEQGMe6AzMkt3gsuTyLFrpcQC4KATeRVoxn/uKx79gNIpdf7L10WIeO08dI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MdPvsNR9; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775247984; x=1806783984;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7Zew1VOyf79rNudxDYle9PJPLAFepmPEvwn3Hydzr2o=;
  b=MdPvsNR9E5iBkeer9Ih6pc71tKnyqJZH8fxU20S7v5ApdV53qKzgU1Q5
   ykZ1yzRL9KMlPNAQ/3nNWm39eJJPpCg/IJKBAuIGOe2tRYgaMTjtgziGs
   1vjUn5Gf7WWTGAPnFy9IVsDGOeDScpJSoernuaaBfCcz7dI2wBBo/01I3
   axMwQ/bJBnfTaB1PqarWaE0nHRHzGrr+uFN3SpV5arhJh5vYwQLCdUSu4
   RaTx3OngsryjeBbS10JhI8gd5wtxW3sxSC78HwCWK4Ic0Z4U7qeOSshc4
   F5+C1qr5HLHikyN+iI97P46vUFt3SyL3wFxyJEHy3HLbu/QVT3yZ0yV5D
   g==;
X-CSE-ConnectionGUID: edKhH3HDSnmHZ06U3e0xxQ==
X-CSE-MsgGUID: yLAugPqQTdO8MqjHfm3GOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="101763693"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="101763693"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 13:26:24 -0700
X-CSE-ConnectionGUID: uybf8PieS6Spcpb+YErDQg==
X-CSE-MsgGUID: BEqEFHBaTx2mk0vTg6gXLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="222989158"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 13:26:23 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 13:26:23 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 13:26:23 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.59) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 13:26:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/4t9OCCJylmElr/6bQAggU2HNXWdiBYCGwd9YC/sJTlxcsv9oukbX8DpM6CKTBz8iZHJQgGKIUBSpwXV3G140n1tTblWhg8PYrwdWx4nYPy1RVG1ennZWn4apItweGpZ70Teyw4IjeuDpK7Y/j/mm84HkNF51jC7KDRL7nJ+sqVFOsHSJ1/1AOPu4i91MSQWgUXSIPnN4E0yiGHITUYQ7ULKw1CHJ/Uzqq0iXu7OXUUF5F4NQPnMtlBc/0qO1ImryXmCJ4Bkcj+fcDM1tyNLQavyEnHUML4ycxAnxPI/xg57nJe8gUNtOkqSdW94iFiedti60GDSNAhqbP5ZPUJqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpmpTUJ7U1JsnKcf0TJ8qbaYD5AHqQ16A0BHXrSpkwc=;
 b=nYA6g71QPTObe/bDtYdVKhvP+h9bCmUvfouR9f4t0xd91DjQCnD66B/nLChdN/HpdwDAb25fh378GpFGIcbRJo8JAWpgSh3b1GcLoYhmq3pTTPcmfGZSR21u+SQR9zA8IvZxLYdswKyoEhnyY8/bPSpiuWcJRII5yvi2SiNKCkwKvQKMWIfB6QsFGA464+aN4Tzgz/9lTm8GwIKG57tH1oUTzX/rb6y+dYuhywz1Ufg3kdDc5Ungjp681cBQYEgKabYXs9sqYJs1aWkgZdGddTDOFR+ZRbhWpM3vk4eeZjChzIdg6t8UBQGznfowAZ17z4tTFghJOdfdPilLDlMWjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 CY5PR11MB6161.namprd11.prod.outlook.com (2603:10b6:930:2a::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.20; Fri, 3 Apr 2026 20:26:20 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9769.020; Fri, 3 Apr 2026
 20:26:20 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Simon Horman <horms@kernel.org>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: RE: [PATCH iwl-next] ixgbe: use ktime_get_real_ns() in
 ixgbe_ptp_reset()
Thread-Topic: [PATCH iwl-next] ixgbe: use ktime_get_real_ns() in
 ixgbe_ptp_reset()
Thread-Index: AQHcvbuslFT1IkBCqkS1WAEavkSv6rXNWwyAgAAAZICAAHkwAA==
Date: Fri, 3 Apr 2026 20:26:20 +0000
Message-ID: <DS0PR11MB7579E948B1DAEF3E8D28C1EBD65EA@DS0PR11MB7579.namprd11.prod.outlook.com>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
 <20260327073046.134085-5-aleksandr.loktionov@intel.com>
 <20260403131035.GA113102@horms.kernel.org>
 <20260403131159.GA114708@horms.kernel.org>
In-Reply-To: <20260403131159.GA114708@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7579:EE_|CY5PR11MB6161:EE_
x-ms-office365-filtering-correlation-id: 577740c9-0d94-46b7-8cba-08de91bf447f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: qish4bHGcpem/IT/L26uTgXs/M/+9oyFhRlMrPeM21DlbWCbstARcdgR0fHbg2ysUhIbgo4pekvZseqsfVNr4UOwz2xJDtiLQtjUOdE3IAzjh+5CtGWw6iTpUaS9SJ2fwrqmzblGb88Q9eCPAVhFOLSq+897qb/pNQsSlVHseKnVSy1cXSrQBpn4pVxDvJe/EXiFSMgd8urVrTfelIgeqo96YCBNhoCVapRxg842qWdeeEtaX7QWwfZ3PptAB1u+R0btHF5nxNYf97taV5t0zljb+XyoVjAGxe19Ygxf4C5yhnIXJPszTqt3IzPfu4cVRjMcm3G96J4zK9660pF5WtzE0uVmVoU0+Sjrs60y+lKLBrXcOpiA4at7xYgiWXJ3+6ZNhPtWcdXDElfJMV5eGlGHBCNb5EBLT2xXeagh9PgXW0jYVVerI6vikZHidaBWxw9/WbgVJsj9APVdpInTXstLsAF+QFuqwocYYIZonDi1fVqFj+az/VpIcF3u1zs4YtmUbdeVwCRvcZfhKdbrDCmz6Nsg9Oc1b7W/Mk5KLBHT/eg/rQ1Bfg4q2u+L7XM5Y8D+9huRT/FcDiylcp3bEgtRX8T44C9ZC9XXanxRI0zpA+nchrmpnEAgHot/0ZHtXlDnBfvIGBGw/0i7ac7kkun2Ccx24K0eV6wRT0SIbM6tV8PL95VRDwdFrwwsp0eaSDwUSwJbxKx3iEhWAEc5tZdJjvaM3td5sSyK1/TkphDHUIpVvjf/eXyXdvpV8Xr53x1ep8+S6Pu1QgV+kQmQEHId8rpavDAAcNJXy71GSnk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pJTisZk5om96F6UZFIu3VONWOZ3aBOBRoJDrM2PwIqthTwXI3EBdmVeOeJBL?=
 =?us-ascii?Q?anHpaKlLttj5Tks3CRYhePBB0Na0q+BLohdyAxB550ewjbmrrpS68Aj2Sd6E?=
 =?us-ascii?Q?/B3AxFqSu6XajO9rjb2DsaIMonOYT/g9l3FxfDo0pHf2DpjvRfFUI+RgKCpl?=
 =?us-ascii?Q?e+n/oyUXDzcMvSlYvq+k/66O4d6PT69D3qgHrMLX/zBN0NJppgAnbb6/iMp3?=
 =?us-ascii?Q?6FrYb5DR19V8+DY/Q65uVk/ARPVilHprf65EH7DAJtJOJq64BPngJHw9y+fh?=
 =?us-ascii?Q?415nua7XF75LptTySCNlc5qIdO5XPTaTFpDzMXs6Urojstohyy0jliyTg2qy?=
 =?us-ascii?Q?D+c91klM4QlrugyJBcxGtR6Vzt1iVniuH2+8O1L1qZu7MUCMULoR66YpQwlH?=
 =?us-ascii?Q?A6ejipvFSkjqE3RWfxi+NZLkS4jcyRdtPp1CFMTwqkXltTa5KcpAbl9WctnW?=
 =?us-ascii?Q?Wr0zIjM2a8tLeGp0BR71UdppLO0zBeu1LKGe4OJtN/J1ay8VK4FkiZBwhDTw?=
 =?us-ascii?Q?2P1fjzX2qiYn2JCaUwCMs7C3slIgN/W1K0DRjVyMpMAHb8nOkwDUPjTWTtp1?=
 =?us-ascii?Q?kgEedZ+uHwQPIs80870H4e7Hw0ERE1v4dRjbeB0CsAS6PL7icwffR+vlo+FY?=
 =?us-ascii?Q?88PzsybljjZsUqpuO0nYmx0tW1SZAoIE7PpC3hGYPavUwK9z2hIQD2JyVs0w?=
 =?us-ascii?Q?y6nXd3LqmKjON7JKUFu77vMOfgxuTjkwcPVnn1Mpg4d2kFAyONIIv9Q8Ph56?=
 =?us-ascii?Q?3SLgS7EVL2zPrKPlG8WC3FLiHFSZfl4oR+UwoIdPnGqPw4e+snOZeKhkmPvd?=
 =?us-ascii?Q?iv0lxr9z/BOZPPdmoViepmnnx0HNdyayyu1gdx/rzE18yNp4oUEzR59DUnu8?=
 =?us-ascii?Q?kLcU+aE6vDzt0yBfWD3n0If5O0F2GVxVdq4vnKSOfaSzoy9xupQcjGX/zve4?=
 =?us-ascii?Q?ckoHexXnXk/xFynNroY0HQoGk0R+Et8J0sQLY7iZz9HqepZQD81bF5wuxKmV?=
 =?us-ascii?Q?dbV8FeVtwxZ2h06KhJT86wW9t+VPwHLrXVDFJsfPqhNtDu53dv6QTFvI+p8+?=
 =?us-ascii?Q?FgtXbPHLpDCBdksKJAypS9VFQ5zwXmG0a6+sHbb79Lp7KWTMzB/EWU0uliot?=
 =?us-ascii?Q?iV2OPMowX9W8g3S7BKwKxFwNbcpSz9R7EW36folhu6x/tBee280TcD8tFjxc?=
 =?us-ascii?Q?PlEIXDQP38HGC/4JFPaKHSGNkXYuEIDCf/dNAPnq/Qv88Iv7wIXMjpJCl58d?=
 =?us-ascii?Q?TSVHC0QqM3KUMllnUK4tvszPDuGiwyfkwlARQ2htALpVeds2OnbwkwN8lFrT?=
 =?us-ascii?Q?HtwPz7M553LhibHp8QFtcw0Wx0ibyybfMjqbD7AMpObyWDU74q66d+x8ilEJ?=
 =?us-ascii?Q?5tsTaUgFD3YzGR3e0q6K+KccrmZsz3gzTaESAw6h+GE826o9j6LjcV3MAvRA?=
 =?us-ascii?Q?bUbwmuLdGp2YXCZQEuUQQ858FHk+0VpgSW4JG/465Kz4YhHuneCmjCudUhqd?=
 =?us-ascii?Q?vhM+IvxCrjRFGG14S2aermdQQGI7RVoYy4zEpeK47zRrNhJ9I371soz2plNT?=
 =?us-ascii?Q?YR8kNaabxy4vz+lx7fqy2rlEArDZ8a2zjme7yCsfuBMtMUHmzbIq5KiZeGoq?=
 =?us-ascii?Q?YTWHP4y+YxpZm9YsJPSNhk0EQjeQ3YUiIiwmLUj/j29KvYIpO81KT4svkAFo?=
 =?us-ascii?Q?b6Ys2a3iwR1E+70guyPaGrn5omKfi5EBj7xEUoBxVLWAujJPAKvJG3MjVKYB?=
 =?us-ascii?Q?AyGD6MVOVA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: haWVHevnbfi9LVy7jk4dBkMZCVJcKOpsZssrlEKpbCzHjgUsJhuvZpMDTAwZhmQbq2apEGs8W2VHuKnz92bGKLvbBscDYUBaG80lufwRUcLybWc1Iz63gVW9gM1iU81qSdEWDdvBKwO68Ik5hP/A5osqeqXunghj7jqJW/hrLvmdIj0DdfEZwyTyBJSP/VJoCjugWpAao/J3vfyy/y+si2Rjzwiwa2776s0caiQ5NIW7G2CK148+BdHnWY/CcmkejrmNMydoFRMV1TeG9UwZ8WoFUMPdr3laqw4oETsbskYx7oSY1ueU1YHlgWoBHPkpj3N/9oLmcnmc3b0fUyHPEw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 577740c9-0d94-46b7-8cba-08de91bf447f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 20:26:20.6925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xc5L9rXretO+UK3b382cdMAF7c+tkv/I7RnqIlHS7+XCVWigK/xsxqdfTOweLnpwpYcQfE+4Ayub2AIZHn0JGv4IjyRGUMCNZdYtieCGRzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6161
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275208-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,DS0PR11MB7579.namprd11.prod.outlook.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 049C3398285
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Friday, April 3, 2026 6:12 AM
> To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; netdev@vger.kernel.org; Keller, Jacob E
> <jacob.e.keller@intel.com>; Marcin Szycik <marcin.szycik@linux.intel.com>
> Subject: Re: [PATCH iwl-next] ixgbe: use ktime_get_real_ns() in
> ixgbe_ptp_reset()
>=20
> On Fri, Apr 03, 2026 at 02:10:38PM +0100, Simon Horman wrote:
> > On Fri, Mar 27, 2026 at 08:30:39AM +0100, Aleksandr Loktionov wrote:
> > > From: Jacob Keller <jacob.e.keller@intel.com>
> > >
> > > Replace ktime_to_ns(ktime_get_real()) with the direct equivalent
> > > ktime_get_real_ns() in ixgbe_ptp_reset().  Using the combined helper
> > > avoids the unnecessary intermediate ktime_t variable and makes the
> > > intent clearer.
> > >
> > > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > > Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > > Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> >
> > Reviewed-by: Simon Horman <horms@kernel.org>
> >
> > FWIIW, this pattern also seems to exist in e1000e, ixgbe and igb (twice=
).
>=20
> Of course, with this patch applied it's not present in ixgbe anymore :^)

Right. Given that e1000e and igb are basically on life support only, I woul=
d limit touching them unless we have relevant work to do in that area in th=
e future.

Thanks,
Jake
=20

