Return-Path: <netdev+bounces-293183-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yP+xA4vSGWpCzQgAu9opvQ
	(envelope-from <netdev+bounces-293183-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 19:53:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE5D606DFD
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 19:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78BB6300852A
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 17:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E261376BD1;
	Fri, 29 May 2026 17:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WHGovhuh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E82390239
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 17:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780076695; cv=fail; b=P5D47iWYKEChrG0TvRqDB1OekvoqR00RsRVq7Pm3E62nPhMRo2qgvkLkiYeWlzgkr3p5i2QisEHFijIF+gMexHxW6hYC5nP/ecn0XT/eTnIDwasWNL6wLApW1sizHmFkGr9AU1wrqQ7r8d93aH7pEEZjaq48aqogSYlH7pbrXx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780076695; c=relaxed/simple;
	bh=EFPpmpI703Es3aYFEP2aQeAGobbZoGGK8A9B8jJRYFM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dh+fx8oyxcqe73bVXaIJk2z1I5doWDi1ArOw9x2Abrca7TQqQvZpFQtSx5U1Y7ZfjpFp99QNh5FdJ3TU+zOcnby+u5GnGJmSUv5NxMWmoWTY+IoVG+IF8PEJQTTQZxNh5SEquLhVpjWG0oPg5b+If4jDVNgmklgGcMfJZHkI/FQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WHGovhuh; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780076694; x=1811612694;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EFPpmpI703Es3aYFEP2aQeAGobbZoGGK8A9B8jJRYFM=;
  b=WHGovhuh90+AxiMBlStKuqcH289wqRSXNJzS8Aiwt9d920pK8jnre4mx
   QGOV5jvA4jgoGRl+BNPm595YopqIWPCzQhIuDIO5MM4n/4zWPyzZv1ABK
   UnZRX5s5JzBfjpMozSGxYiJNjRWswafvC94EKQJN49rdpvytl8f3oC5+8
   5hE8VYPqmdO075jUBZuFYML5Mh3pqKghJWXVmgG2qFy02aI/iP8pBViFr
   PSnUFiGMpo9Wx5yGV028y/iCPA8qE2iTMAtK6mzI32LMnENc8Da0/m9NF
   i4QalUzIDRudqWFXdt+udz8d0YCmn8awnB6knSbfbnbCWo1sBOeDB5XDA
   g==;
X-CSE-ConnectionGUID: T+nOOOGwQ+yoi0Uk27GA+w==
X-CSE-MsgGUID: Q9H6AXfsSsm2nVlGuVub0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="83510861"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="83510861"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 10:44:53 -0700
X-CSE-ConnectionGUID: nCaaPJWXS3ucso8whum0PQ==
X-CSE-MsgGUID: xTsEoI8jRGSTMoE60w613w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="248004626"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 10:44:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 10:44:29 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 29 May 2026 10:44:29 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.20) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 10:44:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VetZRvSkGC2pDC+abO+gttVZFL/uApBB9etqKyel8P+/LQdY3QUIdDi7rirs6zQMWbaJB1VOJllXWB/MnhznvQJlGPcy6r9Sdpo3z5j+fCNC6hKYIB+eAX5jWnYPk78vUxPnO48NtGc0FiWemt7xS2VSg/IZxm70q5w2S9YPJNPsMCFzRJk0RrRNMPgjik/pJl3d2aWpx+jOvXOyiMdZexkTQkwHoqDPXEtjAi2H1y07Gww4ZCMjFeWrtrkCW/QFnsKzkERiNQc2/EBrPqqV5bHo03sNMuCq6uWQeJFaZZuv2jqT563akgYTN988423uWU3tILssr9XHHjKiitHLQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9ahs07v28OD+MN4kRzFcAj4oi2H4X+lmAp6KhkmLXw=;
 b=A7JRVi7aoO9KHN0etFumOVHOKS2ndmG4vDaPcaMI3fRkRdJ9yqBqE126rMDSLrcs1YepzXXmCJoyQ6dZyk+4C1bcZG5rMwFyWJ/rEf7Cnce6gxymZv/fL4ve6rW2nDDcH0cAkDb/Cx8jO4bgGdh1JeiR/lCz8AAMtrIQm1sD65mpL8dnBDZv3Bebnmnpk1RmgYsIl4+RvAY3UgimR4eNeW43CxDGirKJrKK6HgfFZdNxFU509wVBrVYNmo4nhoLyf7YGbOP0twcTJ/tv88Ck2XUFe5GRA2J6iuBb2ztyr7zm7v2n4M0bhm3SvV51riDsgxFI9lWbKYrdgsxkEozUkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by IA1PR11MB8173.namprd11.prod.outlook.com (2603:10b6:208:44e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 17:44:22 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%4]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 17:44:22 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Penigalapati, Sandeep"
	<sandeep.penigalapati@intel.com>, "S, Ananth" <ananth.s@intel.com>,
	"alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, "Loktionov,
 Aleksandr" <aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v4 06/10] ice: use plain
 alloc/dealloc for ice_ntuple_fltr
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v4 06/10] ice: use plain
 alloc/dealloc for ice_ntuple_fltr
Thread-Index: AQHc6SB7JEc0A04Rj0Olb7LqFXlftLYlUxfA
Date: Fri, 29 May 2026 17:44:22 +0000
Message-ID: <LV1PR11MB8790665B33D61E4664F41CD590162@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260521115000.4637-1-marcin.szycik@linux.intel.com>
 <20260521115000.4637-7-marcin.szycik@linux.intel.com>
In-Reply-To: <20260521115000.4637-7-marcin.szycik@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|IA1PR11MB8173:EE_
x-ms-office365-filtering-correlation-id: 37be5fc9-205e-4665-53c4-08debda9eb29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099006|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: qejqS06kae1IGYXgmI6MhYn1T/sY/iIMV+ehCtV8GTMFII8heceD9r/eM6eTJCMaxnrcpLbcPPnPYlD700Sw8WMtrwbo2afc8HrGo2znbfSYa+T8bXZW1nEWJ92w7zTHXsybrjdgHZ5p5VKRkpFLqfU+4lmETqH2bYPxbtSiQgKwr4rhWu/ML2xOWWmhSHKimVg7iXlwKKspBX2J2ozTHI/dxgnURhtm8t6yxXxXBnWosvB1+h7inmvBWv9KRBdcs09V6mV3B/nm/4eynJ91gvZMcj2do2tffVofzBDARyn4TotZ5FjG9t/zFF1n52ywdCTJQ8FFBKFqImW3guCqCKbTuP4SPyucCJkol0NpeSyTD2VfsVgbVQrIRQ3uF4MKM50Lomn3fuQaaWsJlXBwuaktLgFMOSrnBhVPQfhDF6jyd1YLGmIp7XFqfa09D3Wm6RpMXys0Igy/28oGUT2ynSdC9nezNumOpvfY8W1Zwrreg7kmssBWCMguoc0q77+j0NF5a5HvNBec9tflGoEC1IZrkqaja9k4yiAdS7XKWcMUJFoKIFSTqmgZSf7IUVKJ7q9EShC3espGlu9GvRkXj4jlTmBRxl1wZIDUj0sxauV8YvxNR5Nl0DdCm8vBBCy02yLpraOc2AEub2SNI0gknkmMXI19pOT6MuFsvsMEFcOZtSTVxPg+grr+kKX0T5jUPy/siZEcJ348s6NbVokrNcjLaXjs7FhwxfJUiBImSS3ZtbWeySRTI2SpvSsGba6W
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IDJqnge8c0i6FqsEJQjfWKKdsgXXcylDghjFw7tul5DFBK8IOXO1mhQt2Ms7?=
 =?us-ascii?Q?TnG8VNVz1ukKJrg3wy6FbKLFzxBDAWOTOELMTEs0ylc8P5mZq5mxLS7uSyTY?=
 =?us-ascii?Q?zPfYFPRaiDPXSnnv5TX1QdqQSKw3Iqb273c7xOuHotmxXzVcnX+t1cHhQziK?=
 =?us-ascii?Q?i06Uj+d0EiLkHknBs0XFsUb9tfsBitXo9ykuYnd47UAGFWsA7oZ2oIjcaMRH?=
 =?us-ascii?Q?409IMeFOMAqp+vlJLrQQcLNkntQXr4vf1wzs2WwzQEcVBwO+9nSgR7F3vQMZ?=
 =?us-ascii?Q?O656p3dIFBi6cnScmLvU6izX08pzpB11bHSQibJ7My2+n94nOFO9nRjVoeQe?=
 =?us-ascii?Q?EL3F0NUrSKM7ggoLoKSnRpSv/qD5I7RcsRhBmmMAwW+92E1O6uf8l8bnYGjV?=
 =?us-ascii?Q?jC5/8qXM7J6HwlX5kH/eTxJ36xdgdBbIIDm+Yiy0Ce7AILXE5fmaFzH6njaQ?=
 =?us-ascii?Q?DEap48AJmc2lUbrhq59S3Y8zzVqthWAuAfjJv+zp6MrN67yPGKTI4ebzGbiJ?=
 =?us-ascii?Q?MpfwZWBEnbo3thQAxDT1gAtzsJ+VMnXadpSqZwsZn4we/VcNwn5RTWlEacln?=
 =?us-ascii?Q?vRSKnQU/zd3aHE3WiJSQZckr8qBBKIXX6tOCA0ktbwxQL60S78/A2l56qW+w?=
 =?us-ascii?Q?IQqhhQJy6FL+sIEF1RINFqcASkgPmbzKKenL7eroYNgJHiXOPAN8lyoYYSoK?=
 =?us-ascii?Q?UqjDFmDryctsQBOVHVeldguhvo89AzgsjLnfwjpb07gPPb07iYNnn0oUTAJ9?=
 =?us-ascii?Q?sWFAziZP0245VVHJzLmFgpJVeBGY5Ww9ygJsfupu8peSy+sr2fU0fyZo6K3d?=
 =?us-ascii?Q?Pr26gMrs6gHKNp4jTQnHJlSLlGVzHpyDp9GxUaM5HZ/2Z8W+enqq3lHadn8d?=
 =?us-ascii?Q?ZKXzH61mFJ4TmeTLYwo32qkKP5tayGCkNiirbdNcDhZSsmEDPp2N3+6HIQYh?=
 =?us-ascii?Q?BJeALC9tNZSLIOHBACcgH930pnGcBHyikCRcHN7e4Mz19AABz+DUdA1LzpQJ?=
 =?us-ascii?Q?RRmF+BACp4KTmZNSCmKZThpS2mWaZxp/rtrtEe/saDbU+5RExdblNwAMAqFd?=
 =?us-ascii?Q?6IdN8vANxu5n5HTM+Ie5U2nMQgJSqObkfwUbbItA2ZMZ8CUj7rg8hdxhj1JC?=
 =?us-ascii?Q?qfuuFDxkt0aLOiLcWurjNvOLXLBSaF3O9+cLMPbIyMR5+S4OF1dw5z3CUGHZ?=
 =?us-ascii?Q?68TU0wOTJ3XULNgCki26Uad/lupCf281BWQaFyQUcUIXRKP193M5/J9MooXY?=
 =?us-ascii?Q?o6Gc3b4dOFHZxbXdkNjAAvmvzLa5saGijCvITOqTL4bfo0+JjJpKtKZGQNku?=
 =?us-ascii?Q?78fpKmXrEpiKDg/GoI3w7bpSf1tfbYQAQtzpW97JEaYqRM/pgo7NSLnSkGo4?=
 =?us-ascii?Q?sR6WxQSGFrjw5Eq5acMwzmRSh94Gxt6HoP1kSfdh4nlY4zlNcRwCZBiXC4zx?=
 =?us-ascii?Q?+z1PQAz4r2K91inP9XQHPyyc9/mUV1FLZh0Q8HY1X39H1g+TfWy67vwsPQdF?=
 =?us-ascii?Q?0HP6BXj+XLf74gOLR8Q3sBeDf2Qm6zZ2kGwdKX44LKgFqGJIkJpqO7woJmZZ?=
 =?us-ascii?Q?Nt1fxCZO8N2JuKXa5fMrswIzyZTdHAwcsbw97JFYavueNwb9bMDWFxaUeZYM?=
 =?us-ascii?Q?0DFGjaLPYAY6nkJXVIZLstz2EJ0kRaf3byAh7xbUmWTmSfoNXRBiq0GV6Otn?=
 =?us-ascii?Q?xMeeRiz3ioHXMQ0xXy69WohWp1HDso7yRgNoAlarQoZvy/Y0H/+HlrGAbJDt?=
 =?us-ascii?Q?ScG6xZAggA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DaIsfV7xGL3Jj2+jvxjOlBRfUG2pVgLW2yiNuzmnedlm5dm8av7c/JiXWRO4oRyzmqs7eOTx9HuOZFoVz8C/sDnfaH+8d/Hv9MgE4cz9PCIiFCadZIOyOy0QngX5IwQTpDcjIMgG75Fg0AwabWNAWhxgy7VzC4T6a7FYCjstH+KMd8rinX3djXw565eLQVgRGFBleB6xwVzgo2BbbUG9Fwj0Xdbyh0M/+NCyL9C7ARTml8CvBKvcfPsNqSYGzsc1t8xl75GNDqhI4KFaTNzvjT9opKBeYVMJhvTatyiwGQrBAleqbvwOL66JylSmBOnYtKtt2gNDPig2MAKq633gXQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37be5fc9-205e-4665-53c4-08debda9eb29
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 17:44:22.4652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7D0H+Ovmogqyssk/LpocdMLrilD7XZK1+htwzaH4gHt7tc7aa3Cb3J+UtbXMMD3iGtHm262imAU3/gVwv9OXOV+EzuHbpxSOtWL2BIeVH50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8173
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-293183-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[LV1PR11MB8790.namprd11.prod.outlook.com:mid,osuosl.org:email,intel.com:email,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.nowlin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 7EE5D606DFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
arcin Szycik
> Sent: Thursday, May 21, 2026 4:50 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Penigalapati, Sandeep <sandeep.penigalapati@i=
ntel.com>; S, Ananth <ananth.s@intel.com>; alexander.duyck@gmail.com; Marci=
n Szycik <marcin.szycik@linux.intel.com>; Loktionov,=20
> Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v4 06/10] ice: use plain alloc=
/dealloc for ice_ntuple_fltr
>=20
> Change struct ice_ntuple_fltr allocation from devm_ to plain alloc, since=
 its lifetime is not tied to the device. All such objects are being removed=
 on device remove via ice_deinit_features() -> ice_deinit_fdir()
> -> ice_vsi_manage_fdir() -> ice_fdir_del_all_fltrs()
>=20
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v2:
> * Add this patch
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>

