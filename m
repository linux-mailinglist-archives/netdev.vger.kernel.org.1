Return-Path: <netdev+bounces-157996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FDEA100FA
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 07:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 654783A31A3
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 06:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78444235BF7;
	Tue, 14 Jan 2025 06:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bnYMPaaA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C0924023E
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 06:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736837479; cv=fail; b=GSKXzuL5kSsXlQ2u/pgSsBi3VxZJSnmkuIdM9NUu1mcii1Pts7b9ri0iymbktJxGK5A2ysoXLgbH+a9HW+12JpRZl1Bhy1McZ3JICMN4bhBEpgaBo8z+rrM/7FkRxlNqoRveSIz8TIFm18cuBf+VV8siahT/T7CiCYn+L+b8VJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736837479; c=relaxed/simple;
	bh=p845G8cWWhM7OIJr2thNQDAnhyQOR6554fGCe1Jksqw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mw3PPjaagrKPHRbuX0Dfs84+thHyZI3fCwXHvTqJiO/W4LQoR22HcsUXHgNgobzKSERtHfCAZLjLj2Ix2hyEkeBG6pk9Nu09Shj+tsjH4cr/qRPQeQCfUGDFL3+9u0/d/Wv0u7rKHcJwS50XdlI5dyqFRVGi6T7PrPVUao5gGf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bnYMPaaA; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736837476; x=1768373476;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p845G8cWWhM7OIJr2thNQDAnhyQOR6554fGCe1Jksqw=;
  b=bnYMPaaAesz7QEBoGagLyImLAx2Y+GCM69ElUB8zegDlYr8xfC9wK4u5
   EPkLrAJwr3SjT+YtColJvtuGzWniA/8kHCDjVHWFIKAXajlwm5t5OOOom
   71q6vpnVgwa6WZZksrSRdBRF4qjsFvsywVXfialJKjyZilZ/Q3eeznVYA
   LNqdmg1Gjd1ClPiuShblY6qY1qUoq8IwTFFY7B4zNDBCfnJVsT1CY+7/w
   HVZkIaQedbimHTmofZNOGzipVzyv3koPt9TQscTTjajG2uDmivYAwyM92
   U/tgv5E1AkeF0UXH3k8z0kRsLKkKWXdUHCq1i2PUlRxgALAWN1pBLCrGn
   A==;
X-CSE-ConnectionGUID: zDy2/G1/TLS7FCpuTzsLbw==
X-CSE-MsgGUID: gk/4NDj4TJSS4yd/5Lxu4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39930567"
X-IronPort-AV: E=Sophos;i="6.12,313,1728975600"; 
   d="scan'208";a="39930567"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 22:51:13 -0800
X-CSE-ConnectionGUID: /Kwyw++8S+KBSwGt98X1Cg==
X-CSE-MsgGUID: GYVTdjveTWypUuyH+9HHBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,313,1728975600"; 
   d="scan'208";a="109705726"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 22:51:12 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 22:51:12 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 22:51:12 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 22:51:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSTyymiQsqI9Nb0OjVLZLZuLiKz8mzIYFqpsz/zUiY9ugD3t8kSXv4TK9eqi2ob9d1Np7QvkcWr8BMTJum5JEBmLjkH+KVLJVhZzzb9eICRV1MVS4HyxgcGJ6+LR0AIOM+qi0zzWG4oIPhZr7rZ7v/zR/I0Bo3JvleNe1GIU3F06WXSyM0Ra1W6EPOZXXyzxsViYeNmvfDq+rfAQrBh7dIMI+bJmVg8UW2WaqKXWOpoej7LCqGl2khcftCYJr+X7GxyKCgFDas81lB5XFFK5NNxourJXYgF4uWzAhUNY1bNLr3tsxKuH5M02LnsKleXv7Xhi0GRU0MLeFd44avuoww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyjkX6sZ2tY5dtdST6GHkLcLdVNVXbPAPVgzPyuV/KE=;
 b=mVe9EZKhfgOshIbYE28G4GMF+89tdFsTm65yxacN73oRv2hiB3RShhp9P0UrmORlWYkIlBHykYBqejZ04C8hCAl8X+nm3PhIG2r5HwDib8Ao3TtPIr5IK4K7zys/oJJIDOnK8JIwpejO9qp33wFPQ9XnJTtGFMsD56/xvTpi3PjOqdJD9+e7dRYt/2z+gVWwoIjLlvjkbym0oIRNLLLoRPV+bVxL+8YfK+w4zpWtASVFpMEsDsQemLeNNPG8j32e9N1gEcKPb+fqvWOMttRVkWQ+HiKLfJvFt6urAPXY0UG7Pa6yDelUSZsYlPZ4IpzyMeQ2ixtyjB51XkldpaqD6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5911.namprd11.prod.outlook.com (2603:10b6:303:16b::16)
 by SA1PR11MB7062.namprd11.prod.outlook.com (2603:10b6:806:2b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 06:50:56 +0000
Received: from MW4PR11MB5911.namprd11.prod.outlook.com
 ([fe80::1d00:286c:1800:c2f2]) by MW4PR11MB5911.namprd11.prod.outlook.com
 ([fe80::1d00:286c:1800:c2f2%6]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 06:50:56 +0000
From: "Singh, Krishneil K" <krishneil.k.singh@intel.com>
To: Tarun K Singh <tarun.k.singh@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v1 3/4] idpf: Add init, reinit,
 and deinit control lock
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v1 3/4] idpf: Add init, reinit,
 and deinit control lock
Thread-Index: AQHbL8yhVH6eCnrrJUiFR9hYcuE6BbMWQZAw
Date: Tue, 14 Jan 2025 06:50:56 +0000
Message-ID: <MW4PR11MB59113501B8B665F165CBF0D3BA182@MW4PR11MB5911.namprd11.prod.outlook.com>
References: <20241105184859.741473-1-tarun.k.singh@intel.com>
 <20241105184859.741473-4-tarun.k.singh@intel.com>
In-Reply-To: <20241105184859.741473-4-tarun.k.singh@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5911:EE_|SA1PR11MB7062:EE_
x-ms-office365-filtering-correlation-id: 49ed458f-edc2-4773-46e7-08dd3467cbce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?e1QGHKUEH0pjRRIjoaf98o3p6eoAk+PtAk2cNTwcFSHlCOlzfpzPra3Oakjd?=
 =?us-ascii?Q?WsW2BPVJsHPDjYfXNz9yOVamA9lT/0G3YtPWPtFxLz2i8J2SOezlS3XcsqJJ?=
 =?us-ascii?Q?nhF/zJV8blyHLxEgGlFo6lgjrDIpiV8XfO49Ak4QpVASMJCiNK5ZBusbqf31?=
 =?us-ascii?Q?tGepMhHhWCvLJQ1qMTX/QPugMjkHUuVAWnmxWcwD/H75suyAAfMlX8uxl4ln?=
 =?us-ascii?Q?jIicimiQBUqYYFDu2Reuea9UFcjB91STzxEhsTcVPBh3aDKprsFsTI0RlFGD?=
 =?us-ascii?Q?Fc2u3b2YPcaAh2I7vjA6omljbDma1AI8EPxwo4KnHLtp8161UaBm3VX3Dwcy?=
 =?us-ascii?Q?TMaQI3WJGqzZI1hT6gRJ8rHmTRRIXmA7Q5SQr5L/lgWaGqyXCSW+36HEOMDd?=
 =?us-ascii?Q?bBhdwGElr2CboNrfw0Gkkm5jkg33gRGdgIVWirev+dErDI6xInYGtcfOpt6Z?=
 =?us-ascii?Q?/cUHSOhduuOqJIHmsxjhjWn29jeTPGrAbB4sobmept0m7YlzLnQHxWC1E3c/?=
 =?us-ascii?Q?HtjtTQllYo1TSiYCfZCtGtsAeXe6s/+a4dKWFthPRBAoogvjowrrJFqOjkAD?=
 =?us-ascii?Q?t5WI/ayMWJglmvCT0Frh5Z8nXAblKRLV+Kmn0BZm01RUSGlOrXe4W8k8uyKU?=
 =?us-ascii?Q?IojDxG1xSB97iaQ4S4PqFWAP73gRNLJDe9Uu+zTgRZ5ZI4ryUqU4SYlaipla?=
 =?us-ascii?Q?CKd4sViCvKnyEjEJTim5vv4xTiLZ0m5gw+Px+QOb6Iom5LHkabkdqJUgGzSk?=
 =?us-ascii?Q?O3Q94hOq0nO1/QuNIkvJplVYpoYtXyACPSju74Ti+hNwmEVcj5uuPm2gZkA4?=
 =?us-ascii?Q?FIjsHNfhDXClzqvnNVqAT/fgVVE4eBP6YfKV16z/dwaXzGHQ0/6WUbhrpRU/?=
 =?us-ascii?Q?3IyxAU4Dqb9Gbk9kjA/fBkNRGEZ06pEN0F7DW2AXsA/9L7IlIT23rCDPlgOE?=
 =?us-ascii?Q?TyMV6N4Zz3lAeuqcbNOgcTkd1IDr+a2sGCzXTyZXELu7vbFThqDqLoA0g4Yj?=
 =?us-ascii?Q?YScX4aINjJ64pFDoOGdk7yfEYeFIr/60sN+72MP+/QLlywdqamssAG/l1njE?=
 =?us-ascii?Q?6xhqH1wXQPpR4WDkUrCRbaMol5Cknbgn/llUWllFVHjpm3z9ecQXz6saTvwk?=
 =?us-ascii?Q?sTcuwaYT8tQKoPAuGs2CX/YCplrlGnCYWnsaPuxd6/DQUKIBEIpvxBU6AXFN?=
 =?us-ascii?Q?1kmiuFqat0YNyLN3O3DloMkxIZu4qoHNOhxfaoX5dw62eP5x0TlFl18jggMK?=
 =?us-ascii?Q?xUOmzqLEk9gCq0zo4hQyKIMU8oKqZhsJH+AJIdDgEpd//SHwK1GYfz0VQXdx?=
 =?us-ascii?Q?AlLp67X2hu8UWItJzEZtCFFv4Xjs6tA1ViuGaHlvwEPKqSS95rywdmhBIZDm?=
 =?us-ascii?Q?bSveXH4hrzjlilxHjuK8rIzWxhQ9V2WfZN2R3u65mcX2T82OaxTOkKctYBWT?=
 =?us-ascii?Q?r9gJTAN25KloK9oyL3Xws7w/jJoyHnMG?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5911.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vrE8hbWoGgabhkcG8sEchQ9PpytzmOZgw6HxYiZyfhyM5lntVBzg8Wis1qAL?=
 =?us-ascii?Q?vfSN2PjujwgllYX6dkpDtMI8G+Vt7DgdiQLawx1I//OAVaYj4gLRIGe54K5J?=
 =?us-ascii?Q?tALaZ6omzIW/U3u5ArDu7adGRZKOgJZlv7A6HYo3u+3qZrQtM2cSmHwyAGqg?=
 =?us-ascii?Q?j6fSVl7TpIFK5XFSRBFR1ex+l+dZQsiae6DZUefuXA4iaAuWmt0A/YNhzdnL?=
 =?us-ascii?Q?6Tz2aalSBVL1WTrKko9fBwwxQo5PeA8kCWyHGxPLWFHeG0RS8cNT9EgZn8FF?=
 =?us-ascii?Q?qIhMDpGaIJXI1W8ay7UoCPJj/ImNSttGBqjvUW3qgRyQnnND1VjGYsGaCEh0?=
 =?us-ascii?Q?XovvZdMOZLQ6wejyqPJjGTGpelDIKiThE56UjsZwZwbRDvp/3A3IGHRuX1OO?=
 =?us-ascii?Q?/jsd+gE3LC87H2E0bHbf+UIPTUjo5cbjReydt/9NVoAQhahIlc42RZE/fulf?=
 =?us-ascii?Q?q9TUF02OnR4TsMenxNyWDWVdEzCXUreEFgD4wfwwtCFwXEyv9IiHGrp3kSpt?=
 =?us-ascii?Q?nS1GudpwW2PR9aotSAsbZSKefm75Bw4T7IPyril0rLfwgGcq8WA4RJab+XN2?=
 =?us-ascii?Q?nDgdKZkdp2aOOfIFScQoxDm4t/GxW4j9IroHrUAeeyiUON1bbvu+n1fWWnVZ?=
 =?us-ascii?Q?vd/x1k6Avo6MBnyVWbnvcDf7LqJJ4hnc8o7TJJLXlf4BAnuSYqHrPsS8NMCu?=
 =?us-ascii?Q?3lKH0FysUlgfMnhYWMoXI+NAaeM2FQmYWzN310wLIxPD3kn7r1QD4fLWg0Gd?=
 =?us-ascii?Q?e/IFs0WPyWAM+BDyluBHuNJcfv42UgPnnaKTjbiy4zzzviJcTPxNMSQa84h3?=
 =?us-ascii?Q?1tX9R9tUHPxIwMFkTCtVYLmG6B5H1Upd32rFRpA//8V/MijZwOrPDP7EYF2D?=
 =?us-ascii?Q?PivIgN4IKAXhHtSwLjdn8c9wXBNbcrJGm63iFj+brQl7l8kDNWo1Sht8nHMa?=
 =?us-ascii?Q?9UiH8sjvy7vLFrrsA8xkfvhNDOCAa+hdkDao9+c8JKYfTywBYkims13+IbVY?=
 =?us-ascii?Q?blo7pak6cEm40yiG1ydkxU7Aed11qL4oc5gTK5M7PYgH23YDfOjeiVUU8mV6?=
 =?us-ascii?Q?Qd+0DGVMs1eMUL5EAW0iT1yGtlSYXNgAHto6rD1OyD9F0N/VMjEz3ZXf2hgT?=
 =?us-ascii?Q?ySiN5h/vffkDIy55lJdF525sn0hNUUYXViRNXTBJw9YUbpzWNCXQHfawwJQY?=
 =?us-ascii?Q?OxfQHTn1qyzZAdGuaK8VWX7LKEp5nBtxlNBM74RB8bIgvkO9Q8KYbKKopnco?=
 =?us-ascii?Q?6UsVnBgIuWaW/07Kp1/KYXu7JpODdYWju9AW3UU+5fdQq6C/thTnviD2mA71?=
 =?us-ascii?Q?szzjy6BEFgXO1yfWXDY2wv8Xxhu6BxsJMkdv8I+h/ooHZYzI6PDARbfbwOaz?=
 =?us-ascii?Q?UXpiisS5CSwdNUsG1/JEBkaXuYxj3o1PR0RO43Tw1spFfco7hS7LA2Q9VrHt?=
 =?us-ascii?Q?G/7LsbdsE0I83oyAmc/PK5Pf9bswVmjfNuXFB7M2gUqmmqrY5dRrWwUY61mv?=
 =?us-ascii?Q?s6Nby4ZQaERvbkLf9wzbR+6vEB9Fk0BuP41OjQm92w68VEWunSuodjh3ShVh?=
 =?us-ascii?Q?HchMDVemADsFZBtl/LOPXdsPxu3Msqbd/5x+ICne?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5911.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ed458f-edc2-4773-46e7-08dd3467cbce
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2025 06:50:56.2015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4EOFnigjBcrn/pIFULe7ywxUljDOhc7YvyH1JjEZ3q1H81WYiS1yMac8K5sQeIuuO34jdRdAgeB0OWWRfvvJv7K2O4fS8LUeuW4WGS0HN1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7062
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tarun K Singh
> Sent: Tuesday, November 5, 2024 10:49 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-net v1 3/4] idpf: Add init, reinit,=
 and
> deinit control lock
>=20
> Add new 'vport_init_lock' to prevent locking issue.
>=20
> The existing 'vport_cfg_lock' was controlling the vport initialization,
> re-initialization due to reset, and de-initialization of code flow.
> In addition to controlling the above behavior it was also controlling
> the parallel netdevice calls such as open/close from Linux OS, which
> can happen independent of re-init or de-init of the vport(s). If first
> one such as re-init or de-init is going on then the second operation
> to config the netdevice with OS should not take place. The first
> operation (init or de-init) takes the precedence if both are to happen
> simultaneously.
>=20
> Use of single lock cause deadlock and inconsistent behavior of code
> flow. E.g. when driver undergoes reset via 'idpf_init_hard_reset', it
> acquires the 'vport_cfg_lock', and during this process it tries to
> unregister netdevice which may call 'idpf_stop' which tries to acquire
> same lock causing it to deadlock.
>=20
> To address above, add new lock 'vport_init_lock' which control the
> initialization, re-initialization, and de-initialization flow.
> The 'vport_cfg_lock' now exclusively controls the vport config
> operations.
>=20
> Add vport config lock around 'idpf_vport_stop()' and 'idpf_vport_open()'
> to protect close and open operation at the same time.
>=20
> Add vport init lock around 'idpf_sriv_configure()' to protect it from
> load and removal path. To accomplish it, use existing function
> as wrapper and introduce another function 'idpf_sriov_config_vfs'
> which is used inside the lock.
>=20
> In idpf_remove, change 'idpf_sriov_configure' to
> 'idpf_sriov_config_vfs', and move inside the init lock.
>=20
> Use these two locks in the following precedence:
> 'vport_init_lock' first, then 'vport_cfg_lock'.
>=20
> Fixes: 8077c727561a ("idpf: add controlq init and reset checks")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Signed-off-by: Tarun K Singh <tarun.k.singh@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf.h      | 25 +++++++++++++
>  drivers/net/ethernet/intel/idpf/idpf_lib.c  | 41 ++++++++++++++++++---
>  drivers/net/ethernet/intel/idpf/idpf_main.c |  7 +++-
>  3 files changed, 67 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h
> b/drivers/net/ethernet/intel/idpf/idpf.h
> index 8dea2dd784af..34dbdc7d6c88 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf.h


Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>



