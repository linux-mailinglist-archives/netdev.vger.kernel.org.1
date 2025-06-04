Return-Path: <netdev+bounces-195093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F867ACDF33
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 15:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74E6F188F30D
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 13:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D99128ECE4;
	Wed,  4 Jun 2025 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k1XgCbJY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AC528D828
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 13:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749044121; cv=fail; b=Wdw8amQH2qA3Br/54HnLe51Epntukbbbh1bcXmQGFe8MB3a5V5BgMUEvzV3kB6arxan+HGwBEHxgokDAnCL5yHfSs1ROnZN9M2TlyFMlzbKXdsQNArmYfEy+C+LtIvhIJZlNrKoIQBTJf1FaGofrX5Y0KAcXIyBwlBO4uEt/O6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749044121; c=relaxed/simple;
	bh=yFxciKkK7n4eatxFY7xMH0REQAO3dxRW/xf0a/Ey8+M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KKEkjdRTMalfsAzUCEeLhXLKyOjeJOT2fDz4HLv/UuMyiTmGKO261XddL24gtehAIQglpakUnEj9C9G/Nd4CwXoV4FP5yxov93a2cnnBsVYBDqGBtybYUJg2eYQDXcjb6IDdqKQuVwMyRGsMwF+r0XW5xQqnlEs2eUGNs94rars=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k1XgCbJY; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749044120; x=1780580120;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yFxciKkK7n4eatxFY7xMH0REQAO3dxRW/xf0a/Ey8+M=;
  b=k1XgCbJYtNYsD1XdsigeCEHnfdFtce2Om7CINwy4kPjlX0rT4bnxA/xY
   z1HW1PXvjqV8gnVRvpJKL67l346HDhlJcStGrrakiWhKBF0GpDYZpGHk2
   1/3SEvR1EF2ViiHCr0BAPxl0So9AkpHCh9jcjcOBhsu0WMPYYGW0iO7oW
   hid/4Ahm52bqTDDdlNuBtsfnhAp43yW3XqBGogOMjIXAHFQqJkqAL5d3y
   mzNvxDT/FaCoMkfdRPMjWXq4OQFwjqyiMYs9sguIsDbcS3s6wmoldmEtM
   1P4qvYb38Q4INkAi7bw8MVznkj5BvKgPrKo7Oz0bZV0AmBaMva4Ngl8Sx
   Q==;
X-CSE-ConnectionGUID: hq4qI6ZwQ4ChZ6QBhwP+DA==
X-CSE-MsgGUID: PjjD7gRpTyWHslFiixPDEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="62515286"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="62515286"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 06:34:00 -0700
X-CSE-ConnectionGUID: PInsGPsuR5G0bhPb4Ao8oA==
X-CSE-MsgGUID: pFNmpZn1QwyScLPY4nV+lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="145088744"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 06:34:00 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 06:33:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 06:33:59 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.57) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 06:33:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1gWphEBAmEKoxamt7kfVm85oCT59LPMfF1c6rXdQQ1iwPxt/UX8GqKvwfVkklAU4sRB4QWV1dUxbL8DOxi8ukuGP3uwvlH+j/fyFz5JSMYkYKoD8sF79q+Lu0ad+1Q7IYndGvJucvJ23TB+LK8245J2OxPVvyRRSaE9rOXz+sVZ9iknWmg7bye5mppnFZ1B7MD+1UZwO0gRp+bCIPQNDyxtzgv432DTBaBMRHimo6YCR4xA55Z6GCVI29hnGyv+Qw6PizWE9dlW+VTAb4A0g5fnP7cMFt8r+F/3pPurv09vQA8uGJSyKGuScPPl/2IkGZnctR4FWfC3v5OoKJeyeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pVaTVu4q/CCVoZVtFFlaQqGLO5JMdGJ4irvcGJnRQA=;
 b=VWiF2SDt79Q8wQt3yZeb57xWY5l9tEAXjwwUVp6bEqdIdGN7vzgitZY0QN4IGX8G2p0as3phHINEGIsucallKbAa6/S1C1eJ+24yfkW9KYAc658DT02nbojelzm1sRDnFfKV9vnWWTGMzzMxo0+ZHQ3yaChYBHIrckF8JiQL6ATLHUrz3rQsmeurOwqx5+LDggEmkeQD6Dl+LECKxoN+K5T8nYKVYO0BQ23nhkxtT8QMO2iLYUvTy44N4VPAJGQQqVOd91hBd7b8P8g9eVa2zKTUDm42JDUR9v32rh0wzCBBP09lvJE7IAxYitbtPTPJVUdn4CgG/keJQ6jo1mWp0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by DM6PR11MB4674.namprd11.prod.outlook.com (2603:10b6:5:2a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 4 Jun
 2025 13:33:44 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae%4]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 13:33:44 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Gomes, Vinicius"
	<vinicius.gomes@intel.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 5/5] i40e: convert to
 ndo_hwtstamp_get() and ndo_hwtstamp_set()
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 5/5] i40e: convert to
 ndo_hwtstamp_get() and ndo_hwtstamp_set()
Thread-Index: AQHbw++RzetsMtANIECfeBHo3CBxYLPzIImQ
Date: Wed, 4 Jun 2025 13:33:44 +0000
Message-ID: <IA1PR11MB6241F48B66B526E9B01F84C48B6CA@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20250513101132.328235-1-vladimir.oltean@nxp.com>
 <20250513101132.328235-6-vladimir.oltean@nxp.com>
In-Reply-To: <20250513101132.328235-6-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|DM6PR11MB4674:EE_
x-ms-office365-filtering-correlation-id: 9f31dc5c-72a1-4603-b9b3-08dda36c6d9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?733uLeZuOz+s3rGsD64GsvDjFr3D+QxfI/lGLxOKbiSDEsXjXr45C2mkdlZD?=
 =?us-ascii?Q?af4BBiwbiRrpT3Wdl39cOlJmPtAGb+/MmweztiimgaClT2mO4QSQi1W1K5Wi?=
 =?us-ascii?Q?sb1tVz4oPUdheBem/T9u9IDdwFp2iy+c/m8KPbGqBkPn7lbgCnYceM19slic?=
 =?us-ascii?Q?JRd5iVTZ6cm0H84LNtgYuIJw3nXz50MkbVFbgVJYVhvpeieb6YbKLF/f8y6y?=
 =?us-ascii?Q?p/hEg7skQ5jY5y/6tTTNkUAp75ur8Z2PuTY+F0lH3tEM8SfN7vJrPkrRPpoQ?=
 =?us-ascii?Q?kNIaJB6IHwTvr+EWZDCqJ11wLsiNPAaXXFNXFImrNNxbGeGwauR7TnEHGm07?=
 =?us-ascii?Q?4ghRtdui6sMoOnzDDU0QULshpg+x8lb9x0+T2DN3wuLzUibs7HRNoHimWShA?=
 =?us-ascii?Q?axLkqjPswQV+Bsetv/zBAN8cSbcLETCdBY4sNzLyWXOVq/7nfxosTchfBUzD?=
 =?us-ascii?Q?s2SBQYN2WEmhiP07e1Eumrmbj2N+xHG+57ioavt9UC1nu8BmvPoSEscuy6y9?=
 =?us-ascii?Q?TxvMpSzVLO1S2HL43sVv69lvxmbQqAVdLauP9XQ4nd+3tSnW6bi+ZJ/PX9AL?=
 =?us-ascii?Q?ie5ZiD26U0G2Xxiz8zOSxGErnlU6j3xgT7udDDhYdSvBecPkoUvTGFTW7x+i?=
 =?us-ascii?Q?ILWG4ZmjjrsGmZ2vU2XH5AolMbdZUlJGPC1pWiBQIxeCkQHmyTo6Q2wxtcbb?=
 =?us-ascii?Q?BcF0wsLgMa4qB9HNsm6RGR+U+XevP+5QVfQ9vvQ66Hwn6r/1yUelbZXvO2VN?=
 =?us-ascii?Q?wc7q8QeF5780bejugckE+cNIomiBmWN77brSEBZgXF7QTxZtn7tcT+cka7AZ?=
 =?us-ascii?Q?6nf+MPunZDFGEs35qyBnKOJgOUb7GTS3ILukPkT2/tOUZeDkRbPFTojCnMEU?=
 =?us-ascii?Q?xU/IWngSHPgVP/RWIs3t898JGsynAlrY21nct7Xo5oKgSEWVhc9LPTGvEaOB?=
 =?us-ascii?Q?D29He3siegZkCAYUYMbHqpwBMFjuvmaABLYavyW/a2/3qW/kxFxZHz3wvesV?=
 =?us-ascii?Q?0FNaRIRddP8l5Bw5XeiKyV/tA72W30u0VmnQHVY47AMpBGPwdY0uBpumLK8T?=
 =?us-ascii?Q?mO+pgS0aCjflt2KWb1yeOA6d3nsLRG1/rew1Wax1qWQwWR8S19it7k9IJnS9?=
 =?us-ascii?Q?XIWjI+8DRFyu3nuZDEcz0joa7lajR3vH/NYbakO/iUNGueuIVPhGEyl7JyaN?=
 =?us-ascii?Q?0S+zFaZKoEUI0mpQVlY1cbbIjhJDbwzLh7IwnsBLgYQSwa6uT8aDMpYG/Bg2?=
 =?us-ascii?Q?Lx84NIylJwBeh9IKWOfgFnCXRwhL6gTG1R4EzgUVAqKG1QAYio96JbrZrZtU?=
 =?us-ascii?Q?7wl2Za9COThQsCmBiJ2Wamh/S4Sfsxp3Ybu3mWJ1pTsZ+F/QNJS5gHiplub7?=
 =?us-ascii?Q?jwsBCbUk1bbg8GyAq/klknIdQ9fi8DNK6JI6SQxRu9eBsySsPkSOsFJBnsOG?=
 =?us-ascii?Q?DIbn4Lw+SHxkaae7RZrAKoRFvjhhZhVGdwAw+UJSIlCKa5cvsw86TV4WfdTP?=
 =?us-ascii?Q?xFeFTDoMVkAGH9E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Eb5wWBgrp2kOXAKzmYsMfroZ/wdUb/6vQ0fdpIaR5P2JKM181YJpvG7TJdit?=
 =?us-ascii?Q?j/AmJVCuhV8bcqMg7ugEyjfenBz8q25IA8s8WBxleemipedTaojzSobQVohq?=
 =?us-ascii?Q?RhjLvI1yw2HmbWJCc2/+jcQ7K4hHn9hI3ADx+eD2AWiCUZcFPotd828kgPQ/?=
 =?us-ascii?Q?m04vWVOG3czvarDutjq0A05f7zZmeQEB80ini/76S/9Qc+B48f3bV+xYFfP7?=
 =?us-ascii?Q?jzKY1cZ4VVLO2Yxzk5MTzAvbIye7K+tduQVTIkExl0fXh7nbYe0BxbwZk0ob?=
 =?us-ascii?Q?U24Q7BtMrccXfwN8ctwn4pmv9ppSrkvVjA+VjXWvLTBoXIes0t2J9ky6US6u?=
 =?us-ascii?Q?SKBNcvh23yrd7D8LEVvs8QsdLvAoY3XsKSEvj/kc4bsD7rdFVoTE/jv0XGXR?=
 =?us-ascii?Q?IJqcY+bfc7INFMxO+020rkXyG/seQSmsnybreCc+E6gyHiSAV0P7eXLfaOK7?=
 =?us-ascii?Q?hzG0tg9ik/US7UpziNpqs65JjadZcOzD8wKzhoAIPPsyZ7J2AndEbJNnYyGy?=
 =?us-ascii?Q?pAoPYfPl8azeWWUBaKpNFt7x8U4nLGP59wuCyBBeHFUcuNuvjJN9Q4QutGTt?=
 =?us-ascii?Q?llng/KS9foBg69UO9m1grbjUTpInMhX9Qv00sq3IJ1fFz+f3HJ2KwqJ7vyij?=
 =?us-ascii?Q?Bgw0th4olG1Urbdst06AUUgny9b7AL4PxPzM59gyBC+mScnk8SCIkjRDaiIz?=
 =?us-ascii?Q?obsMXe1rfeJxgJ8cvvbwe9K0f6SKJr4HDwswwkFxxqBsCRU85K1KM7fNS3si?=
 =?us-ascii?Q?hoEb9z4pGjad1FQv4MPibxa5k3MhOvERkTuwMhsE/C4FeAojD/NBxUn0m5Kq?=
 =?us-ascii?Q?79NZJEjTQITQ4Vn7ESjRs/LC2CtAAaO16wH9acZ+hGU5stmuMtLBaFTdyUeH?=
 =?us-ascii?Q?qzhoAgVpptMl3rzz/HxR8jaEDk7nxaEHUHpVtA7XNPzAe11CJwhhn/CPWobv?=
 =?us-ascii?Q?oVmacc0ILCGFjT6BudYLUvwV+ao9yjZMo6AXawJyLNMQJZ1mKatt08e3EU12?=
 =?us-ascii?Q?0Od6OJZtnXiVmqpjO9fyg2sz/hqFiQgw9pT7g/kMbJV178Ak35VBP7oJpTPM?=
 =?us-ascii?Q?vAv9DT4dJtVvpYWcxjHE48sS5Diw18JxwVlbcdtLxj6rT8iUQxoWdJzItqO6?=
 =?us-ascii?Q?YWQe8xRTpGIFO7wIlfKh1/2ytE/iUwcxu4H6zkkbhqN/ftHt68MPNKh9dNKI?=
 =?us-ascii?Q?L25t/JE/orBlTgNMwCnOiIY26u4NWyfOAoDkTmKRJSs0cyEuQOdLzb7P/1xy?=
 =?us-ascii?Q?H22/yc6zGL9Z9UBmZyRrxZRk/pCzU9GAN/dc2PyfMbw1qB4msRvGakBeriId?=
 =?us-ascii?Q?ReZDHydpv6zm+qQJW+GR2BaAInqekhlXepM7D33JHRzemWaUXoVsQLx1r4/s?=
 =?us-ascii?Q?xBbW8Kq78TMSkdmYGEfLCcp1itgwmY9wsn2JYDuTs3aF34Udd66XDXRBcCQe?=
 =?us-ascii?Q?rYw7Q7pDfY4jeR7xGnR6CSFypAO3UpaWktdLqzfAsBOC7Fv/hasuXtgIGK8A?=
 =?us-ascii?Q?px9rHiZHZMu3Bvt+y/GBY73vGN0lMKU/1rR+g5gdNSoic+xZHQ+ATVdrvHzv?=
 =?us-ascii?Q?SOq2Dk9MOBt44COllJUiEgY+qsZrY2ORqjh9eKWx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f31dc5c-72a1-4603-b9b3-08dda36c6d9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 13:33:44.7074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /8cO+lnrh6gLNg7jC4IC7dKZiXLNAGO5DCkpTAjd8OpZ7vVA2lZ4U7vx8nqDmlXoMU+LfKCXim77amIEhm7/0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4674
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of V=
ladimir Oltean
> Sent: 13 May 2025 15:42
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Keller, Jacob E <jacob.e.keller@intel.com>; N=
guyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <przemys=
law.kitszel@intel.com>; Gomes, Vinicius <vinicius.gomes@intel.com>; Vadim F=
edorenko <vadim.fedorenko@linux.dev>; Richard Cochran <richardcochran@gmail=
.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next 5/5] i40e: convert to ndo_hwts=
tamp_get() and ndo_hwtstamp_set()
>
> New timestamping API was introduced in commit 66f7223039c0 ("net: add NDO=
s for configuring hardware timestamping") from kernel v6.6.
>
> It is time to convert the Intel i40e driver to the new API, so that times=
tamping configuration can be removed from the ndo_eth_ioctl() path complete=
ly.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> drivers/net/ethernet/intel/i40e/i40e.h      |  9 +++--
> drivers/net/ethernet/intel/i40e/i40e_main.c | 24 +-----------  drivers/ne=
t/ethernet/intel/i40e/i40e_ptp.c  | 43 +++++++++++----------
> 3 files changed, 31 insertions(+), 45 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

