Return-Path: <netdev+bounces-220840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E7EB49084
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 15:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8532B4E1C53
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 13:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32A230B50F;
	Mon,  8 Sep 2025 13:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h2bP1CyG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276A322D9E9
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 13:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757339854; cv=fail; b=E+uf1pVPCtAPJrsUB17mL0V84McEIVJdZsmVV7KOLpF0P19+TxpohhH8Y1bY+vAKnQqxSmJOcChhNPOyDq2hGuiaUeZHqp6ipTEO0IR5bC4uDV/FnsOnWoyr39VFSBImg9wODf3sRreTKmFBwScsNJZtU8FkAzzR+4BNrCBgQE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757339854; c=relaxed/simple;
	bh=O7zWlpCimAmfc3EhOieyEU7LWrZ1B+wKMpzawS6O5Ng=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DDrlxyUY6QJkHcLbYgZtkuct8Ak/8FqRv16WVQavkMpDB9dMYNQbGPokpXlZgrKuqn4bOt5fqxcQ6bYQk+MARPIBWqnTwWGHW12r+XAFQy02NGFJturKCIIYYQCRYHGTGD4i5nyj/6RRXHPyQuB/yG2+kGfpLxt733pbaV7q+NA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h2bP1CyG; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757339853; x=1788875853;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=O7zWlpCimAmfc3EhOieyEU7LWrZ1B+wKMpzawS6O5Ng=;
  b=h2bP1CyGB3Ollv3phKH+URbx0EmcN0VlM0B0c1v0utqiwqOoIUdmbrwj
   kgE050IU+yBBk+NEKsXuzclUntzxiMpEuIGxB1gFKVjFxuwQ4Xqx+ixEB
   ayOP/TCMQCXLO3SoQbTtazlUkMS1Jp+KNQ2kc0LMmkUi+HNFu96eLShdd
   YZJZj/CzjkIpURBtLjtRFYOpcknKC7dJweqWkCdO1igvS9ufQqx2o1I6y
   gksG3MGlUuq9+OW+c3pOeoN+EB2t69fI76TdBHvejCBE3W74L2Z2M1LH9
   YUCnv3hoHpZqW0GcS3LWDAwIDG0br/gBCrdG1uuvrGolaEaMQQ7FPKJ+O
   w==;
X-CSE-ConnectionGUID: ZoN8jgehSUqG4DDTGMa2ug==
X-CSE-MsgGUID: v7oMEDSwTLOf1KS0JcjPKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63424020"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63424020"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 06:57:32 -0700
X-CSE-ConnectionGUID: 9GJkd5LESIyASQ3HHhAeqA==
X-CSE-MsgGUID: wfzFL2ihSE2V0KeQfu/F0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="172676333"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 06:57:32 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 06:57:31 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 8 Sep 2025 06:57:31 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.56)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 06:57:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jm4V/Tjme+eZs4+IoN2CStSub239ZIPgbDr//fjEEs93YL1B4jgvKFLaLgG33v8hTZ32F/LpvSXR+szIWzNw75jL6xHa9iSJkN6ljPL+FhTeDaLdLfmJiHP0mBRLYaLC0xUQwL27i4bFs9Zr9Z2W2ZOuyyZEQhQy5Cs8NjNcUuJlo78nRuvVH+ysNlucMIeWkCa0CRigH/lKQiQNoT0fi7nLhrls2ao9dmvo8RsPKJbvQGwr00GFKOpxstLE120rzOvpAvwddAjiLXy/dyCwBq5vyurefOc43FR1oNSGTCv/DNNDsUiKI07eYFavZwode9IwdmhsHNHc1Gf3x+q35g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJkUOLh0WbhqhNska4X5ZVSMcv6bhaDonRsozzhRMIY=;
 b=gOFBYkUYg8XYbslG5I/CoR/6bRx90eL3Fwp2lS+l49W7Sk2Q/pp+W98n5dMhwjgaCd9u3lCgwyolltMPwLsUcGgQz2hQrSgid1dN0PqP1HylZY1HYIOxf/rC+pLrXNs5V53w7xK92S0f5qzzMSCNapaAAYXGiG1SwhNo9J7ppnQ6g3ZAQjIGbBHXAa3nAbbM5na2NOTJo08pLM3q5G8uOTsNbczJOKwifrCC3tAsezkxoQake9gVdBveiEfo3g0LZLBA1qjtmEH5AslTbDVrcJLp8u5PPCjikiI8bDQvcAfxElUhCAysluR+8FKoRYFndudE8BMxKs0Bw+l25XUxXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA1PR11MB6145.namprd11.prod.outlook.com (2603:10b6:208:3ef::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.33; Mon, 8 Sep
 2025 13:57:28 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%4]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 13:57:28 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Simon Horman <horms@kernel.org>
Subject: RE: [PATCH iwl-net v2 1/2] ixgbe: initialize aci.lock before it's
 used
Thread-Topic: [PATCH iwl-net v2 1/2] ixgbe: initialize aci.lock before it's
 used
Thread-Index: AQHcILXe3VIPArRpykmN4wUszitv/bSJT5Hw
Date: Mon, 8 Sep 2025 13:57:28 +0000
Message-ID: <IA3PR11MB898670EC7D20A2CA809180CAE50CA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250908112629.1938159-1-jedrzej.jagielski@intel.com>
 <20250908112629.1938159-2-jedrzej.jagielski@intel.com>
In-Reply-To: <20250908112629.1938159-2-jedrzej.jagielski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA1PR11MB6145:EE_
x-ms-office365-filtering-correlation-id: 07c61f7c-8113-4015-abaf-08ddeedfa607
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?Jl98O+Tx+QsAB2MiAufgmulqd898r41IOZmuFe87Ep5wvz8KyAGodtG+oPsl?=
 =?us-ascii?Q?0/c6XPXLXIL34pDMXVBVP7pOrYjKgdnM/BfRHblDO1be96I+f6BNmTnbzSvW?=
 =?us-ascii?Q?nvOOY4vs3JMZhHO+eWncUU8ZWcz3RFXFqqCh81o7Y29Dy1PdZHBUak30Mz4o?=
 =?us-ascii?Q?MBhWq5DAVzrvQZ8fmgVijzLFJFrUpV1kfopuaiyhzYGIgAQ06pRD85lroqSf?=
 =?us-ascii?Q?LzHcSOmBN6h6WM3xX+b63CgtyGSmhv0SVkPTzTd+ss7giq0TV+yj9X9+yNa3?=
 =?us-ascii?Q?/DrepGtMlgOucYjaL/hrMQQ1B5rYVeUGOsLufL5RwvPRrPk5CjLaD9URO2lh?=
 =?us-ascii?Q?TybK/MLqhNtpjV3uJ+/YwDVoiMNzti3F4yRdCjd+4Jh1WihdiPT7hyL/CepY?=
 =?us-ascii?Q?xc1oaVly/XwJxmofglpD02DuYHKiV317OM4rNZFKeLulUMhBdQQKAIyhc71L?=
 =?us-ascii?Q?Z0JsGapTKgPB1V28QcbldL+u/1QYM2xJe0Z8gretxtq47ITm4xIdyskxLTOR?=
 =?us-ascii?Q?2KT11Ge6NST8CgkRIDF0o47r65w744uU3fZjwGmDU3FuqeOhlKCsE+tqWsNV?=
 =?us-ascii?Q?0CbLWanevcCApJUCpFM3qcS9jfzEGSR1RgGp2o/nnv4r78DJGwUS2r9g3CEt?=
 =?us-ascii?Q?4Donzz7/glWS724hYPhMHhN7dXBfNw4exjV2yDupcektSjsm1ktZ6hcjLxjv?=
 =?us-ascii?Q?WwwgqJZswx6MwRMHebSgx3XNs5pdsljCZlSetFk3p1YY5HmF9A4ea8OEHUhU?=
 =?us-ascii?Q?b4+ZWxUnZmXYiiMNVzz0NxDbJvGICkKVSVezUYHlALJ0XMU4v2PapIIYkFHa?=
 =?us-ascii?Q?eqMXsSFGguOD96YVscEDRMZY3a/ro/pT4RzuaK7OSBSiyVn1ynnxVSDILBTe?=
 =?us-ascii?Q?01mN/XsTRtFtt4ErGp3bRxEkNOlt2GLRcnv9c0oQsbomqbT6MHHykXwNP+Hf?=
 =?us-ascii?Q?+rF8MI9jAE2PbLXSAUbvvPlldE7LfgzxNbRnAxHAsPOMlsmew88ovcnI/dx3?=
 =?us-ascii?Q?wnzlpYpIy2ON3qFcEDfPfWvJDGVymUM8XtwuUhaskr8SQcL4FPFOKrKpKa13?=
 =?us-ascii?Q?apQMRqPYuY4kWZlMEeeCfaOZRsAnfIedOW4dcfEZESfkMv9AK1k7DPVp/F0s?=
 =?us-ascii?Q?crdyCtKIiFhd+ebekP0xR2Td/n7TnlJJPfirqSDcxMB6ieYx13xYIr05zbx2?=
 =?us-ascii?Q?eK0AUUybPnjpTZLxhb4Vn3sdNMU9yfLSEHimNVhMD/MupiEsijxvuGb/ZCF7?=
 =?us-ascii?Q?Qdmu/NQRk5ikJYZ2A7AK1nyikxxGcsLlyzl2e3PC2AzPR+x7HiT+Yv5hubmY?=
 =?us-ascii?Q?+NlnbZZPdRHfrjnbh+h/LediHUP+UjyJQ3KugQVH32g5w3H6KZI3LN/CRs2Q?=
 =?us-ascii?Q?S9xRomV2hFLe1t59RReEm7MEfE8YI5L2awtlOiw5huVm9Dz3ep10a+0GNDIf?=
 =?us-ascii?Q?iZFxHuc8gjdPLovEvgwGVA1JU3IiMYZ7Y4ZzeogbhaAXkpH9lc1LDA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lQ6CqDZ2aq/A+5kiqtnwztvc29RY/Ivi4qcegKNEUSBHgmdqHE0qiKSKrPtO?=
 =?us-ascii?Q?raWVGXtSTfLODKoSWmiMohn1fjYwh8BUUHfwJMaSnDh1XomQTnx5s+TzlCFR?=
 =?us-ascii?Q?Tr7SSNnZbueqFaDfLdyqnnklCx5aXLbnStTv06QZKuOsb88BmT0O7JdsCPV8?=
 =?us-ascii?Q?FcB0dPPsrwBb3lV5yXxm5g7B5zSu5yWVkorx1t/6n7SUJijcOzqWQK3q32vy?=
 =?us-ascii?Q?5TkmILgrisw7+Yay86q2QTUqSsappSk2QMNDBmFElbZgxeRZB0LgFAsy/AtX?=
 =?us-ascii?Q?Zsss7FGiyXuFwNZEODzngNAbIYqq+aZj5WXRD+Wj31DcB8CIizAsuOWEf/8E?=
 =?us-ascii?Q?F6kRlzsA+iqnlM7MUWfq8WwxVHpFm+GO1GT0LDmLLk2uVZ4ksxILWchIyNm5?=
 =?us-ascii?Q?62urJt6eZpc3Q+bEWC7DpyQvcQhsAE9AEI+MzTEcftwzo9QkJRENXfNzmiat?=
 =?us-ascii?Q?Ccwk56Ou5Bu6sk6VY3CzUBEY11DuvayGXn5QnHjqkn8ZRdizRwApAR/cWmIo?=
 =?us-ascii?Q?K03V1yKEM0qP3ys3xhbAu3Lb9n80qdFaxhLHaGUwyr0hhH/06yPdRQzT25gL?=
 =?us-ascii?Q?o2/B3oxDGQemWAI8t8zp31PPDTKMsIKvYHHDP09t3OH8UfHYEVHoc6grdqx8?=
 =?us-ascii?Q?qmnFPeqaM2C2c3fJ0rv/WlPXnUG5mjuiHgj0faotqFRpeRc02FHZpOfD4M8G?=
 =?us-ascii?Q?sGA6Loq6E4YYBwZ279j3Fk1+AoDgtXFOqT9aqT9ZXoB7i4gTLpIzrntH3tJt?=
 =?us-ascii?Q?LC/TdNDK7GxM2wZx8sKfFEdbjrVn+Y8FQRey3oN0vUt6tF650namOAlLb0gd?=
 =?us-ascii?Q?E1iHy7cuGYyjL6uuJbb4/ANUT5J0jqoeQyJrt9fEJgemPxelC+FfnjtcFcO7?=
 =?us-ascii?Q?dSWkR8//NFXKbZS4nDcnM9DDBbeLe/xZunSWdeZAC7FXWCacy8OMMkvNKWuD?=
 =?us-ascii?Q?HO0NRAZGKd+R3RrY1hbexhltvgQfYF3ZzAX2vKf6+ZaeOhpX5fqgAVFH41ws?=
 =?us-ascii?Q?AlEZ5sB+IIrfc5wVbM5PKlLUU8kxPdY20KlcV415RsmWZaGpYdTQGVdZcILy?=
 =?us-ascii?Q?LgxuSLhKxuyYdFbG5Yn0YligBn/zqJ1OiPwFcQwklJqr33fOS9290dvTCwSD?=
 =?us-ascii?Q?GzAh3vlTGwxUpzghrAnA4ioq+Jlp1UuxyvHwiabmksD8luFhI/nh41YnFVBw?=
 =?us-ascii?Q?eJvun4Zl/v5xahfipkn5cqfee0O/VbyeGclS+tTESuSoqxd2vRlMPaiPBjco?=
 =?us-ascii?Q?bAnFFOEOJDffe+wNwFpvybDTRxCKVMZ0hxL+QIS4ZD+MaHlMZZGqlYBkpDoJ?=
 =?us-ascii?Q?+zSjreO4dCHT1idIQIzdMrV3TwaeDsHDSHZirXCBDZRHYzAejAaSIO8rljb/?=
 =?us-ascii?Q?Q/NwHlMQsqPLfxJF9G8fHXpjVp5et+PjLrUldYv6+Gz1Kej70lbV4EK/cBkU?=
 =?us-ascii?Q?mqMsL0oWn93JL41RF4gGH9XZf0M9OI9iL4rBH+h5sOQpbPuJ0NXm5B84lNit?=
 =?us-ascii?Q?OomOvif83hxX4c9gYNQFKZS92RFp/OsDRRyhbDNcdMD97lLyfpYtw/xnuOhb?=
 =?us-ascii?Q?zwbyOUTD/XqeGNxelxq9UrgJP08s50JVYvMv7lGbdbt2PeDVFwKc2zWgAt//?=
 =?us-ascii?Q?yQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c61f7c-8113-4015-abaf-08ddeedfa607
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 13:57:28.6785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gYqZWeK+ur9VAIL9ZiBLqK1g3smo2WuAhOjExtWuE8mrcy6f70VVA8bfbdUHPVek/vYdSZiA272MyJjXA1KxxBrCcwCocFfyQ1i/5FIIqys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6145
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Jagielski, Jedrzej <jedrzej.jagielski@intel.com>
> Sent: Monday, September 8, 2025 1:26 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> netdev@vger.kernel.org; Jagielski, Jedrzej
> <jedrzej.jagielski@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Simon Horman <horms@kernel.org>;
> Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [PATCH iwl-net v2 1/2] ixgbe: initialize aci.lock before it's
> used
>=20
> Currently aci.lock is initialized too late. A bunch of ACI callbacks
> using the lock are called prior it's initialized.
>=20
> Commit 337369f8ce9e ("locking/mutex: Add MUTEX_WARN_ON() into fast
> path") highlights that issue what results in call trace.
>=20
> [    4.092899] DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock)
> [    4.092910] WARNING: CPU: 0 PID: 578 at kernel/locking/mutex.c:154
> mutex_lock+0x6d/0x80
> [    4.098757] Call Trace:
> [    4.098847]  <TASK>
> [    4.098922]  ixgbe_aci_send_cmd+0x8c/0x1e0 [ixgbe]
> [    4.099108]  ? hrtimer_try_to_cancel+0x18/0x110
> [    4.099277]  ixgbe_aci_get_fw_ver+0x52/0xa0 [ixgbe]
> [    4.099460]  ixgbe_check_fw_error+0x1fc/0x2f0 [ixgbe]
> [    4.099650]  ? usleep_range_state+0x69/0xd0
> [    4.099811]  ? usleep_range_state+0x8c/0xd0
> [    4.099964]  ixgbe_probe+0x3b0/0x12d0 [ixgbe]
> [    4.100132]  local_pci_probe+0x43/0xa0
> [    4.100267]  work_for_cpu_fn+0x13/0x20
> [    4.101647]  </TASK>
>=20
> Move aci.lock mutex initialization to ixgbe_sw_init() before any ACI
> command is sent. Along with that move also related SWFW semaphore in
> order to reduce size of ixgbe_probe() and that way all locks are
> initialized in ixgbe_sw_init().
>=20
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Fixes: 4600cdf9f5ac ("ixgbe: Enable link management in E610 device")
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 03d31e5b131d..18cae81dc794 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -6801,6 +6801,13 @@ static int ixgbe_sw_init(struct ixgbe_adapter
> *adapter,
>  		break;
>  	}
>=20
> +	/* Make sure the SWFW semaphore is in a valid state */
> +	if (hw->mac.ops.init_swfw_sync)
> +		hw->mac.ops.init_swfw_sync(hw);
> +
> +	if (hw->mac.type =3D=3D ixgbe_mac_e610)
> +		mutex_init(&hw->aci.lock);
> +
>  #ifdef IXGBE_FCOE
>  	/* FCoE support exists, always init the FCoE lock */
>  	spin_lock_init(&adapter->fcoe.lock);
> @@ -11473,10 +11480,6 @@ static int ixgbe_probe(struct pci_dev *pdev,
> const struct pci_device_id *ent)
>  	if (err)
>  		goto err_sw_init;
>=20
> -	/* Make sure the SWFW semaphore is in a valid state */
> -	if (hw->mac.ops.init_swfw_sync)
> -		hw->mac.ops.init_swfw_sync(hw);
> -
>  	if (ixgbe_check_fw_error(adapter))
>  		return ixgbe_recovery_probe(adapter);
>=20
> @@ -11680,8 +11683,6 @@ static int ixgbe_probe(struct pci_dev *pdev,
> const struct pci_device_id *ent)
>  	ether_addr_copy(hw->mac.addr, hw->mac.perm_addr);
>  	ixgbe_mac_set_default_filter(adapter);
>=20
> -	if (hw->mac.type =3D=3D ixgbe_mac_e610)
> -		mutex_init(&hw->aci.lock);
>  	timer_setup(&adapter->service_timer, ixgbe_service_timer, 0);
>=20
>  	if (ixgbe_removed(hw->hw_addr)) {
> @@ -11837,9 +11838,9 @@ static int ixgbe_probe(struct pci_dev *pdev,
> const struct pci_device_id *ent)
>  	devl_unlock(adapter->devlink);
>  	ixgbe_release_hw_control(adapter);
>  	ixgbe_clear_interrupt_scheme(adapter);
> +err_sw_init:
>  	if (hw->mac.type =3D=3D ixgbe_mac_e610)
>  		mutex_destroy(&adapter->hw.aci.lock);
> -err_sw_init:
>  	ixgbe_disable_sriov(adapter);
>  	adapter->flags2 &=3D ~IXGBE_FLAG2_SEARCH_FOR_SFP;
>  	iounmap(adapter->io_addr);
> --
> 2.31.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

