Return-Path: <netdev+bounces-278125-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLEGMG4S3WkOZQkAu9opvQ
	(envelope-from <netdev+bounces-278125-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 17:57:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD5F3EE3C9
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 17:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6725301464A
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 15:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847B131E106;
	Mon, 13 Apr 2026 15:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CyVTPYp9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD3535CB6A
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776095499; cv=fail; b=EAcVRUGukek5bajTJz2c6cLr7pYjW9q0Q4Gtvka+2S9P69fzPGD5SoyCsSpFWgt+lKMlrHhvAoODty1cON39wvfUtJIb15INZ0XeRiAnzT9emTpxCj5sLY2/m+vjZx5qA9PONtKedaLmipbw4Ls5j2zVuH/poZFP5Ke8c5OhBH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776095499; c=relaxed/simple;
	bh=/l58vE1JlSY3uLCUBv8SvwP+YVTZVgPLJc31IxUt6dg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nKwoAOo5qWR533O3ZciXdRUyvb3OOvyqzls8/YbeNG+vi2z0m0R0P07aShGR6Tweb1qg4zj4Da5QOiPR+EZKcUzW4igveqitd9EAcHP0HgEKjDRvHkxpUnEPvDbDKapHC9z0Cdd489VFXbv78ABMmjTjt8YMjY/GbxyQPCFzksw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CyVTPYp9; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776095498; x=1807631498;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/l58vE1JlSY3uLCUBv8SvwP+YVTZVgPLJc31IxUt6dg=;
  b=CyVTPYp9wHZtu++M6QnVhAnTFLbJI3BrGQoGdy3cII1PQTjXPk6Zn3LA
   +4db2Qf0mIYgMUPpSX7JRKJ6dP3kiLXMgR/R+v5VTLbPfciolMKExW6A4
   bW94+k65YU/I7LYRuMS+heIKSnYKusxGEUcVW5bbKvbeK5XlOzGb2+ZVZ
   iOUg6ijLes4kkne+XGeVnmZSzev5xQMuwPy0L8iSVjvRtsrwvbHEMR8bx
   6XNfnTRWMruW3WAXVEz+JGtkPZBFyyLpVWWsM9UtwWCcnLkju4qvsn2uE
   6GIfkAkxU8tF1JAzvqZ0bbYxG+DJXNJFWhbG7dbjAsVBVLwA7f0NfOnAb
   Q==;
X-CSE-ConnectionGUID: JeOlAxTDRwyti5bhdU9SwQ==
X-CSE-MsgGUID: crMbzZhGTGKhXCEog0bPqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="76999531"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="76999531"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 08:51:37 -0700
X-CSE-ConnectionGUID: FgzIKXG0QP6McT9RjoYXYQ==
X-CSE-MsgGUID: d5y33lq/RXGV5I2nAa5HRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="223326523"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 08:51:37 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 08:51:36 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 13 Apr 2026 08:51:36 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.15) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 08:51:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lIn9rTOiuFOQwTDQf0E5PQpEBFkL3rkSHSn4nBhI8wMcNrkUjhsVmTpredDcJ58fGrQnZJeEFg8fZ7BvPZyh2D7zZJm/bdLrOoBR/85/Lzx47hNTvjhtueLES5VUxXqR+2Pc6VnWlx2K9aoPV9cna0gnqE3gOeS41FRPjOntj79vLRBuwDhQVprMqIfMlBpDc9d2ok+GoeKVdLAJGz6ZJY5p0L/0A/iZSsSiCpLVc9fxCibpfPY2yTEs+3lh/ATmF9AnQs3C1qFt2PsXMoNAYFSWutSTWkHCRv4mtWeQm+y3qvqJlBM+4NQAISu9DggGdNt/fCi2qTThO4V7EsiiYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bX8wK8bSWgEjZJ3T5aU0MN/q2OtOm5b/42ow9P2K9PM=;
 b=UrdZiDErMH9zo+EFHBWonf9Hnz7dAbndtaPt7IKknNR270Jy5gHlDz/hJIjV2/fhq3BvCA8jvmtZBigT8t8EHcyHc7XUwdQ0TKg9e47ewEEIf/ONOl2xU3zeGp2Q0vcp29eGl6mNQ3ou/xRlX4qstz5TiFK23LQSd+P0FH9P7o1T4E+LKb5JMMmEB+4EiVcWT6zL5N+vRmKIsxbwC6TNsee7y7myrf3lOtiOBpqw9NJVnkGJ0P+5n8XmrlWRzZ58QXsGn/CeXTeKGadQ7k8gjpLmQP8dXlSBPwHZAia3QwFqHupu1mm3B7R+75Dylr1ZakptJtvW2irZN4ZMUnpGjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by LV3PR11MB8553.namprd11.prod.outlook.com (2603:10b6:408:1b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 15:51:31 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%5]) with mapi id 15.20.9745.012; Mon, 13 Apr 2026
 15:51:31 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Simon Horman <horms@kernel.org>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next] ice: fix FDIR CTRL VSI
 resource leak in ice_reset_all_vfs()
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next] ice: fix FDIR CTRL VSI
 resource leak in ice_reset_all_vfs()
Thread-Index: AQHcvbqIhdFypAb0+0SYm2J+0X/mprXNRpUAgA/4pDA=
Date: Mon, 13 Apr 2026 15:51:30 +0000
Message-ID: <IA3PR11MB8985E3C35D3517A683234B0F8F242@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20260327072236.129802-1-aleksandr.loktionov@intel.com>
 <20260403115255.GA60103@horms.kernel.org>
In-Reply-To: <20260403115255.GA60103@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|LV3PR11MB8553:EE_
x-ms-office365-filtering-correlation-id: 58a8aa75-e75c-479b-681c-08de997487fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: RuEEijvoy3zAngQfpTtmNPI4uz0VzATv/68T83CwfKdGxiQKyoP5qmlRvOFf8eVW93DzqQm10OLf/sFX3wWsEPXO6h9oo9qFz2jAVQ2rj4YehTMsaDAZhHBpEc88xDunpHCSQnMI9jhW3hVZvNX6AXHfxClevSkxKv9+FDY4yBiFIw7IsydhqRnZRVyx4DnJBj9X+O749gcYcMy9ZtWBeYE/gSy+2uA0ulY6+ZX+fYexN+S/KHAmEcQdEplFWSzpJ3DbDHym6nCHHYaGXG12fyeGFZKIOJ5aPiFVZcmIbW7OE3U5/mOeOJw3yQVVo4azyuWmXEnTGy0BCflFgC3FpUta6pUlpnKsU/6+GfcmEV5CX52m760r8hCB/iiySi4zWp1LspoSBQhqc43N+XwkO8rNH/u32zcKYv4T+Yo7IQVTK7vKwYQ0AY08XgGvOEDjmuyyXcNHeScvmvCynqL3NngjHiVhexHJj6txtW/I8eMLFEHshYZohm5qEDOsInxsyPXBwj2g1U0Bnukg/2pxIQhamvkcwvPxYBKNmNT3fN6LNOErO0Y39j1m5xW7S+d07FeMBCCwvj9RzrqOHCPnU5OQclSP45hjaefHw+32rwSohPXwWORRzdbGjIVx+kuek/YXyeL68zZPc5T2JM5RT7YgUJicbgZMVEQb1XPciPD1nTvXAkWCRe6T0OuNP1QJill+fa0pG+XkhPR0DMmsKl+6zM4wpRzunhPFO4hnVQ7ET9SvmIBTISq59n+Ryn6QhOTb/Rby8CWA7DcuEOlBC+itx+JOBPymZ5XlqV6GiME=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ty2ki9gqQp3rT7+gpoGkJxO4aH8JWu2gVJqJz029eoDlVYnY9BvJsGK2HuX5?=
 =?us-ascii?Q?ZYeNCQhEuKzPoFf3SZuGjkk3VcsIlNf/ekqEV8Q4Fz5+IHlJzGVHGRCWvxLu?=
 =?us-ascii?Q?0RVQ4//A7CG4oefYuea/Uj/nMTEs2b97ek/LO76KGR+MiNjv5Ef6nN+1TGxl?=
 =?us-ascii?Q?8hjOCJMVQhPDAIeRlFANOWz+ttYNrfQTyeC0AgeUk5a+640klnmu6Gr9RC7l?=
 =?us-ascii?Q?PEubMKTOzkeKXutuDlqJmdE3RjuWkRw133+HBNEcg2BgKjcHlpq5oEJhrqgS?=
 =?us-ascii?Q?HE67Fa+/Ns3HGMCNKzO/m2Guuo+Xp39hCFs08OoivSiGYmK0/7nreoOh+c8k?=
 =?us-ascii?Q?eSB8v/lTta6bFjvuxVUCP+JwGy6YAMyhnluN3QurmB4G5RwS1ntB/R28sMA2?=
 =?us-ascii?Q?36q89/59Qfx6+qShxIp6uf5od2FWV42Gm6LSnJr9D02B5ZntXbkS4WKQwHEX?=
 =?us-ascii?Q?GIOmAw8DON6/Ba2hauF/2YXfZg5xwocnIPfwU+C5WdDLS3uBm4TA2SzMDNta?=
 =?us-ascii?Q?RxkS7S1zsAx33sbADEUFeqmEyKKN+s5TeywjcVwAmDF1w8iKddo2c4MmnI2v?=
 =?us-ascii?Q?w22InPJ+/olihl1CZM5/x4QhRoCDBReFjY5uys3dfzzQ57Y76SxyUDYtXvZq?=
 =?us-ascii?Q?zOdGfL/XnReY1cn6ekTCAWTj2WNpc4RMxeTFDgPcYhCwTz4KJq+snpyBiTxK?=
 =?us-ascii?Q?ANgNaPc63SH55vlb3k4YTb3iztSxHHonkKQnIDgVbJTLtjd+paVMaGzdzeP1?=
 =?us-ascii?Q?09Ao7cfdytJE7Y02WoL2AGV0QmoZlnhcdervh9+Tr+UH0KwgJl+jvi8zajTu?=
 =?us-ascii?Q?BdcuYa9Rg/P0tesWxrKhZetvldzyOdTnguylV7Em+0GnyioB7HhxBhHUdl0a?=
 =?us-ascii?Q?NWxKMtSinqkIvs5ZzYN7Tm3iB6Mbngpp6sveKw9WsP9khTGIPZKdsWm8ChUE?=
 =?us-ascii?Q?VOvqqmb1Hp2wCMBmnTYq2Z1GGa0V7YgzO1kc1YhsFlRnKuvvaXQPGsu2WsiI?=
 =?us-ascii?Q?Ok6cQvrFpVWR8pGnDWCo3gXbUx/OVSwdiiohTMxM4/llY6P0azPF10ATwLM2?=
 =?us-ascii?Q?cmxq80g+f+oBuTIX4o+Qf5bCYunsI4aEjN8Huvc/vgUbhNqX0Obm4I0iInSl?=
 =?us-ascii?Q?4pwp9QmE3lh24SlXUjDi45l/UEG5x/ppioBKwmmVl2e2phQk4+cBvMKAuojD?=
 =?us-ascii?Q?vr137LClbZat1UVYq6NarjD0Gmb3yENSXoXrJVCRLtNKqOrgkPID9wCodUon?=
 =?us-ascii?Q?lkGhe1Ep9gm6KyoeIb8tEMsnWtmTaWw2tw3O2QS4/Bg6P2r4XND7OBrHigNq?=
 =?us-ascii?Q?nIKt5lJiXOxTtrg/WWeL6EhKiketzN16gLstbUbC38zgiugGaoY11UuerMi6?=
 =?us-ascii?Q?hDRZDVOx0dZtW9ZBTLoiceo9fMieTargDgOAT4xIEnMoiGC2tXEqZ3+4HX/b?=
 =?us-ascii?Q?kzgHn93fWz79sioPyGQQEZ6/vGBBnCWxJ8G0SbNKqArLUHn6fWLkdTCj/Unh?=
 =?us-ascii?Q?rc68crqTnNTkfyHpn+AZBIDAdzK4qsnabZY3QkjK1vi6aNXuTGKxyX+bHnTE?=
 =?us-ascii?Q?DgtElPMixcqL8/tY5Oezkul77MtmS3mnAa9lEYy/kkl4ump26PZx3ANNxp3n?=
 =?us-ascii?Q?j/K0qN+C0XbrITuwvV5kK0B8gYmUgNx5QHhCkntK2F58AtTH4yD4ylzyuvjy?=
 =?us-ascii?Q?0naCgb48qhCZ5Y1tFK44xiuFI0jF4leLGfvMHlBk6ErdwDI4tp1Yj3ha+Cyu?=
 =?us-ascii?Q?39hPiU/KrQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ICoV1izTfJZSs5jRGykREGKYBmx4X/k47G9lUAVZn2HNb8HVsb32qMn8unda1Xqynv89m1rAi3EyJ40DlXMxizH1Z2YQ3mytbadD7nam46MY47cIR1xRDlZA5dzW4UMuQKnrfYlYKYi7O/mHqwXz2FhGfxjs6QOjorRkbFV2oGwY8mb/FXytAceW97mtenKRizjzMwDBG4VzrdBSIeF5vEM1MAR18amb1ATpG/dWkthkm2tZ2p7LkCB90NA78gEiksSZTRyZcphWwWfJAnUR/H15C+rIvuQVP+s5KyAKBq/mp2bzLIiob0DoWdwlikC1n06Zsx6Sxcr2cdeGkCoYzA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a8aa75-e75c-479b-681c-08de997487fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 15:51:30.9212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cWRQskkrNuA8MPHng/J1/jbeailf712MYKAxNr8Pdjomr6ghKVgYIK8WJlNFXlCrax4kHzMSWr7tVXbPSLQMEzvv0PAyCEh+YRV0irNelCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8553
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278125-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafal.romanowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 1CD5F3EE3C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of S=
imon
> Horman
> Sent: Friday, April 3, 2026 1:57 PM
> To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; netdev@vger.kernel.org; Dawid Osuchowski
> <dawid.osuchowski@linux.intel.com>
> Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: fix FDIR CTRL VSI re=
source
> leak in ice_reset_all_vfs()
>=20
> On Fri, Mar 27, 2026 at 08:22:32AM +0100, Aleksandr Loktionov wrote:
> > From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> >
> > Resetting all VFs causes resource leak on VFs with FDIR filters
> > enabled as CTRL VSIs are only invalidated and not freed. Fix by using
> > ice_vf_ctrl_vsi_release() instead of ice_vf_ctrl_invalidate_vsi()
> > which aligns behavior with the ice_reset_vf() function.
> >
> > Reproduction:
> >   echo 1 > /sys/class/net/$pf/device/sriov_numvfs
> >   ethtool -N $vf flow-type ether proto 0x9000 action 0
> >   echo 1 > /sys/class/net/$pf/device/reset
> >
> > Fixes: da62c5ff9dcd ("ice: Add support for per VF ctrl VSI enabling")
> > Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> > Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>

Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>


