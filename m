Return-Path: <netdev+bounces-182587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA83A893A0
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 08:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14CA1895295
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 06:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2141EE7C4;
	Tue, 15 Apr 2025 06:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nwE0X+eu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D617C218AAB
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 06:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744696865; cv=fail; b=GouGtXorkMYv483KrTWKdX3YyoMRp4pkx8O3Wi4GVcwAjFu7dal/N6Us/nr05AOtXQntyGDG/esZIjLujNggh/p/xjTXMYrAalrR6TY/xWIauLS7Hqe6fAl9vKrfXmb+aZjwXuVNEVlE6ARVBfhUNyjfNP4QKFKRum5S6TsPDTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744696865; c=relaxed/simple;
	bh=T5prbyLiZmpWSXRyv4Cbal8YRIdwHBOd2GhfSngTlA4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aEhbwRbA9ZNVEZvrXKmEl9tkaFomKkgLxhkXaa6VZEM0aQX7tkVEeq4i55H8aT2wM32AT/Xrz3Jud1OecbGJ00q+DP3i6kUvqhZTOVPo6gtkRiGq7GvZCDqi1u0Haw0wo6lGPc6cXaBenjoPURVwAeB/aSBtMoFVryYkrcdWR54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nwE0X+eu; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744696863; x=1776232863;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T5prbyLiZmpWSXRyv4Cbal8YRIdwHBOd2GhfSngTlA4=;
  b=nwE0X+eupXjX5AUvYy2Fv7IN1Tz1r6/Mh0I5DGz3TgAD8jhq2eAay6zj
   929mm6AH2TA+W3ZvolDD+8FaavaHsJsvOmioRaZg6ofaGiUsozhn0B3rf
   GLRzSpW08Y26tuVmZkmL27Y5uf+Lh0WCZZo2WcONkcjOd8B3A6WCpTW0s
   lJ3OeXntSC2/cgpvp/U3FV7gpHdG3uemZtNPq3UcXTppS3mAgjrO/8Swy
   7TLJruR/mBVIzlwkt71dE126bUPJAJimQi4c1THEAM7OgHiuVvqLE2Cd0
   WvBF/sGFIsuTMtnBQqpq27SoIuC8nfExCWIUQxd5xBhuzOFoRHuPSo3ZQ
   g==;
X-CSE-ConnectionGUID: 2Rz9vloaT0GJ0qrPBkT6Dw==
X-CSE-MsgGUID: MhLzvl+0Qcupka93m3e3LA==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="45322023"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="45322023"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 23:00:52 -0700
X-CSE-ConnectionGUID: ptV7e+F/QnOeFahx7HhqGQ==
X-CSE-MsgGUID: xGRG+8wSSxuViZJA1Iq1FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="129987121"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 23:00:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 14 Apr 2025 23:00:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 14 Apr 2025 23:00:51 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 14 Apr 2025 23:00:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7kssUPsnB3Ea6zeMc4rGrDH/0t/M0imgdmSrHGGIkXARoJ2yCKtmoih71Uh0LlGQBXITGweeXWdiHA3O541AVJS5AjkOVSRhhiRXz6Fjn498dHHSp4I/v6zrVdl705R5+iU20gsWMZ0vGiE5fELDf41raIRCfJIG7HQwM17kJDf8338X+wt+nziQT67ZkneXHY4+BG/OPiAofnvTk8rQ4zS6SJQaoiEo+c+sC9aiK6HM6TAHYwy9YgkxWl9whtomxSQjyd2PbD4/EFpEL+rMfWewuuDBZZrfD4aSyG7iY1U7ZvCGXjRVlk5vpK6KNblmkYH/vbyRy87eLP8CL/RNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8QHV7m4z6g5oHGFlSvnP54CP3BWmXOvvgVJeBkgQlc=;
 b=tbwp2QVeHQPX2ptrRlzQAfVHtfQyBHgPE6BKNNWeyDlToR3sn0BC3e5cq1qTaoNgVdymxX9fhpk8J22ojG2GUA9e27Mf2fksekVqstoCgTA2jygo9L6Kw7KBKv8LK8h96tyJNprQEhJxW/wm3iX6Xev63YqKiaJvixO4RhNnr4Bz4EAz0t/wp1//uDt2p2EA2pXmq9wwCtTIMcEBgfmkiJfKQNstUom6YHtiemUWSLRmdzUbys755ZrS2WCm14XZYHOCHmTDKgH6jMb2rqZW56OzYV4hJLxMV+ow1x/cPji924Fu+vrBPNvtr0UfkZOOIxbaPtN12KSAhBlP73KrTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5911.namprd11.prod.outlook.com (2603:10b6:303:16b::16)
 by SA1PR11MB8795.namprd11.prod.outlook.com (2603:10b6:806:468::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Tue, 15 Apr
 2025 06:00:20 +0000
Received: from MW4PR11MB5911.namprd11.prod.outlook.com
 ([fe80::1d00:286c:1800:c2f2]) by MW4PR11MB5911.namprd11.prod.outlook.com
 ([fe80::1d00:286c:1800:c2f2%6]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 06:00:20 +0000
From: "Singh, Krishneil K" <krishneil.k.singh@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Greenwalt, Paul" <paul.greenwalt@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2] ice: fix Get Tx Topology AQ
 command error on E830
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2] ice: fix Get Tx Topology AQ
 command error on E830
Thread-Index: AQHbg+1nCTIq0bu0T0+MvCJq4B1rcLNRXAYAgFMzNzA=
Date: Tue, 15 Apr 2025 06:00:20 +0000
Message-ID: <MW4PR11MB5911A2EE3BCA642A7C629822BAB22@MW4PR11MB5911.namprd11.prod.outlook.com>
References: <20250220-jk-e830-ddp-loading-fix-v2-1-7c9663a442c1@intel.com>
 <Z7gqrJkNSNrRg6IK@mev-dev.igk.intel.com>
In-Reply-To: <Z7gqrJkNSNrRg6IK@mev-dev.igk.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5911:EE_|SA1PR11MB8795:EE_
x-ms-office365-filtering-correlation-id: 1aa88c6e-a495-4bb7-1b92-08dd7be2cdee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?GfYyc761gc77JL/31ZjZmTVD1cENIuNn7puuW5/1/lAGpFXILAtgh+koRHiF?=
 =?us-ascii?Q?GeRs0DtkvtY9ZKvVwXwrzBDRTb+ZrP23dz/KpyivE3J91girDDIQuOQiZDc7?=
 =?us-ascii?Q?qd98Ca9qVHn0byeu1BBgWENZEBJv+E95SLtXH62rMHbJMkrYymnWizD3vz63?=
 =?us-ascii?Q?TmZFQM2ngZbeB3xSZC5S9jSnDdsZKD5BhKXjcVoIo/JmF5zsALZHGmUsc36E?=
 =?us-ascii?Q?N0BarXwWU1Cqpc6Ge8++1/owsAvMCCFgiAC/2Imo5vNUvL7VykxVxdG5Ep/z?=
 =?us-ascii?Q?QjEQdlO4ekP4Q0JIk0n9E8ZcC3CCDfP1lWZWBlF1sRpVHHSJz68SuxIEknRS?=
 =?us-ascii?Q?7QC5V51lz8PU9SltiZFvVxosGB27xjsoQkp3pL4b01lDw/Wrv5mov1StnXXO?=
 =?us-ascii?Q?1Sov0KyWaPovbLOxBS6+YWYupSHdoafYwl9GLE2BbFMqxB8vdK7WSk4v+gSj?=
 =?us-ascii?Q?mSjcZCG+R4c1vTTUEw9sxqvPCvcRLPKMCcqycPElAlSJKgMJXpXaHhvo4jG9?=
 =?us-ascii?Q?bY61RiMrUEnIKhotOoYNqT1jUO1F79mKom/SdhRjRROOIKg7XkpCuUPxZU5d?=
 =?us-ascii?Q?v3BejZFvX6XE/IITp/SIVlXmb6lDDUvyP6+K0kdLkrK3udfiGEPpEwd+AAp+?=
 =?us-ascii?Q?nO4MijXfyEN+OY9bvCumssCvNqrWrrXs5gTDgoorhzljV1A2Nh5U3D8+6w3Z?=
 =?us-ascii?Q?/mOjjiHT7AOFVI7ReGh/0gz+e9KoN9mDd/FfR/AjSF/VlAQB0sw00mR3DsJA?=
 =?us-ascii?Q?PjUmnCqxjbvSzqgd7Je+ayRUexdsHRVBon35UroZJoZGhuTQdJ1DGG8rxsuH?=
 =?us-ascii?Q?okqp5FryUXsMFT7S0S6BMoyikmIDW1eFFIoKUX8nDXLg1fAM3tqo1WpHpsbB?=
 =?us-ascii?Q?UrlpxstoMn7RVSzeB9to1fTxtQzH0gKEQbJ0udGpaeONQtoQjvGEbAzAbKvN?=
 =?us-ascii?Q?Sd7mrTygV4/0MmmnkF8rCHTynHAanIEWAXCi4ZNpb52WVHKtzgdOUm/xFJJ4?=
 =?us-ascii?Q?YUmooCK8mlnUgHt5CCNgKbPffyoxlWhPgOiUuOvUbh5YVvNof1/nby1k4gwl?=
 =?us-ascii?Q?pmzkE45S/NmEftwDMcwml5AeUC2YHkm9AmKvFWS0YrGdefM9+PWvuEzbxdN1?=
 =?us-ascii?Q?80ZuStTInd4PQBBz3Q+TS93DABZ9UnCpgQIhFVxSY09Z+4Y5gYmnlX0tQ0sj?=
 =?us-ascii?Q?VyRpAiRi+wGwAuMKy2rM0tbK+Pxm64bu9m3VujZNwMMsW39aW70S9WbT7jW3?=
 =?us-ascii?Q?sJFpP2iI5F/NWkrTMFhYg1lPSYKtOl6yKXF22hhBvVo9X6x8SXUnaJFKFxd1?=
 =?us-ascii?Q?z1tTpXXtWvmr9MVg7Y1JfCER1px6jhFrWg2y0Z3x8LAdkR/TwZgkHIKhy1If?=
 =?us-ascii?Q?6zwewYn8v43hMjRZ25D1yoWmVSMLM+2j3d1qGjCeBAWhYPOKkA7P8Suvha6G?=
 =?us-ascii?Q?EbOdFZ6afSR+pg6l6EqR8FoP12Gn/6GJXWPMsrzxh5c5Up5CVlYyW/oBuKrI?=
 =?us-ascii?Q?mYJFbKFeflozbhw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5911.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ugJUTJay6hPkhH10dlB51dy3PrLYRMRJ8sCONEWlZeAUAsyAOwgPUPL0I324?=
 =?us-ascii?Q?V6UJOrogoqm3rCjFR0iJ6TO3ye40kAOOnG2k6L/t+1iTOV+37t0Po88N3r8i?=
 =?us-ascii?Q?drU5xwaPluFFwZwiTkjCveOBKqbWDKVsx61IyoeIiYN0q/w3OPXJZBAHNoyg?=
 =?us-ascii?Q?R8/kRjb/rBrLIpJmfTnYVZmkNVB8Vtl3ikyj3DW1KXc1D9eMS7PYE4corHcz?=
 =?us-ascii?Q?xbiZI4dkfFfQfjJl2RP0wDLf08g/G87nQN3BJromg+VgrmpNHsm25l90siMp?=
 =?us-ascii?Q?h3UMUudfhedkTFw66p73DT0P6epTpw9UmKHnF8kHTH3n8mZz6U8BC21KwcP2?=
 =?us-ascii?Q?eUbgUp6AelYpVlscaDE2XDS/HL7rpd3MXw2vQkDzyIylGJYahDXoRCUmCe6p?=
 =?us-ascii?Q?eQ3vfvEy+y7s4DlcMH2t38HDfPbaCtW84S3UCgTWUMZHq3RBtpEMKiHLYv6R?=
 =?us-ascii?Q?zZrTH3RikMLjS65YLk3S08lqHzr0huUE6U6j0pWBQczVKrOi+M/H1tikWFMm?=
 =?us-ascii?Q?cNDYy902JMfo760Qvp5CGOmw2w5TgLD5IoXUmryTCZXfAWMs6jyLJDc+YaB3?=
 =?us-ascii?Q?3lAT62mrz1ImzmwVDDjMMUWYk43sXAuW92jdo0q+eMwD7zCZNq7MvHaDoi8V?=
 =?us-ascii?Q?JsBLkbKK8YfmTyel64Dandx8o9KbnAAV92fpXNCIE4xCppg+kNr8j/wAvPEE?=
 =?us-ascii?Q?VWS64m68WMK1bLHeJHL8HDpBn4G14GbCaWJOnp1I4PX3NcAb+rl10BRff7JE?=
 =?us-ascii?Q?awn9NmGelIsKONgsdo4uac66HxyaDEfUoa6wEb2BDrMBIg5ZYN+CqJpL9FKE?=
 =?us-ascii?Q?cXQyK2bh4G6SX84t7UcJWgvz7SB/NHmpc/tnfzVm8jfCLCfYw/ERckMKG5g6?=
 =?us-ascii?Q?rVv8bBwGDunqBmu/xSeExYiTzM1bsTIC41I0AJGdWetvibNUY/He7GZCZnx7?=
 =?us-ascii?Q?sBv31XXX9uM6PjQZRMk7RTuOxRfsObUdkZMPJaVfFnMjRTAUooba/ogICDyg?=
 =?us-ascii?Q?Q1lLIU42LNamHh6BlZHkNxs0wv4XqBA4y1hBeX1uXPM8P4ADDY/cmEKWlbWR?=
 =?us-ascii?Q?OO7G4h9zrdMAvvHjVDST7NTfPxTTlFCO11Bw4zEvx65eHvNrD/mhnLCyFPSe?=
 =?us-ascii?Q?WM4Mdq+bBtaKcn5BkKVh+uJj3EX2AqthUWbRyP+9WL9L+Be2J9HQTeEa5IAP?=
 =?us-ascii?Q?OwFXHEeYFVKS5SeTWX0Nzt/pCRfn/4mCFNv/cMHWXFU14gX/fWH5vcuWxn9I?=
 =?us-ascii?Q?+0u+i2QWHW1O8r6GLVPWcjNCNu57ai2wbKXqgshZKMsZxNr2LBJ8maq2sWs7?=
 =?us-ascii?Q?0ShUNGKgfpL1JWhfF7X+t/DTK8Dt83z0c7ZJzomU2tjFKosWAuh3yXiDtRMV?=
 =?us-ascii?Q?Z65CUJtAYZdDT0q6KaO7oaXlgCLFlGCfXBmDShNfvgMt3rK/FTBWI4WQjYgB?=
 =?us-ascii?Q?AIhUUrzLhRrTKR4ThAnkdZpx7j1DRJuJQjNGusCqCzbtSsPsYPlZ9t5UwYa0?=
 =?us-ascii?Q?5xS0bQoBnu0SkSGNzCYhejko4Fc0Ln3FnHxmIwA04u0DHlDCJOwsoBVm9f76?=
 =?us-ascii?Q?1+5Zm58taT67QfEtUOUl9LeBfbCTItO30AAiyy0l/F5YY9H1Q0bYqNbgvF2R?=
 =?us-ascii?Q?6A=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa88c6e-a495-4bb7-1b92-08dd7be2cdee
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 06:00:20.3645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O27y0BDa3imJzwyglLu4NbwEYSUNv3fAwBdrA/K1sgWVTJZ42QMxDtq6kbsKE4bmCtcOFcnxlcoQ7vQ5PqmPcpzQ46dN1B6kQGKpda+3gJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8795
X-OriginatorOrg: intel.com


> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Michal Swiatkowski
> Sent: Thursday, February 20, 2025 11:27 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; Greenwalt, Paul <paul.greenwalt@intel.com>
> Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] ice: fix Get Tx Topolog=
y AQ
> command error on E830
>=20
> On Thu, Feb 20, 2025 at 03:15:24PM -0800, Jacob Keller wrote:
> > From: Paul Greenwalt <paul.greenwalt@intel.com>
> >
> > The Get Tx Topology AQ command (opcode 0x0418) has different read flag
> > requriements depending on the hardware/firmware. For E810, E822, and
> E823
> > firmware the read flag must be set, and for newer hardware (E825 and
> E830)
> > it must not be set.
> >
> > This results in failure to configure Tx topology and the following warn=
ing
> > message during probe:
> >
> >   DDP package does not support Tx scheduling layers switching feature -
> >   please update to the latest DDP package and try again
> >
> > The current implementation only handles E825-C but not E830. It is
> > confusing as we first check ice_is_e825c() and then set the flag in the=
 set
> > case. Finally, we check ice_is_e825c() again and set the flag for all o=
ther
> > hardware in both the set and get case.
> >
> > Instead, notice that we always need the read flag for set, but only nee=
d
> > the read flag for get on E810, E822, and E823 firmware. Fix the logic t=
o
> > check the MAC type and set the read flag in get only on the older devic=
es
> > which require it.
> >
> > Fixes: ba1124f58afd ("ice: Add E830 device IDs, MAC type and registers"=
)
> > Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > ---
> > Changes in v2:
> > - Update commit message to include the warning users see
> > - Rework code to set the flag for E810 and E822 instead of to *not* set=
 it
> >   for E825-C and E830. We anticipate that future hardware and firmware
> >   versions will behave like E830.
> > - Link to v1: https://lore.kernel.org/r/20250218-jk-e830-ddp-loading-fi=
x-
> v1-1-47dc8e8d4ab5@intel.com
> > ---
> >  drivers/net/ethernet/intel/ice/ice_ddp.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c
> b/drivers/net/ethernet/intel/ice/ice_ddp.c
> > index
> 03988be03729b76e96188864896527060c8c4d5b..59323c019544fc1f75dc
> b8a5d31e0b0c82932fe1 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_ddp.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_ddp.c

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>



