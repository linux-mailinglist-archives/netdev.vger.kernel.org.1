Return-Path: <netdev+bounces-281573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJpGEswG8GmoNQEAu9opvQ
	(envelope-from <netdev+bounces-281573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 03:01:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A945747C4A0
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 03:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD3FD301D32F
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 01:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FEC1B4257;
	Tue, 28 Apr 2026 01:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MQ7/s1jM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80C614F70
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 01:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777338047; cv=fail; b=BpM1pUzbVU7a9V5mlOXTT95Zqj2txHvT2ql4v58q7z0JRaznyfuzLQ/LyP1JMUaacR6RjA08AQnwHuJ5wZUbzMBMOJcKfeOa1gExq2Wfm9QrJGdjpVHBSEP9tuqMw0d1LM7mUALUkwnrN7Auz9GV2XjPDRM0MZ9BsRTwi/yZkkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777338047; c=relaxed/simple;
	bh=j+X4Q+quZ7mzIOUMlQfc/ERc2qeXUck52wKKE80PWgY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GIjughymv/58NdLnlRdoo46LNOuT++X2db2FHX8BNij6YBEnFkaGKV6T6yNVQwehLkWUz0SJzlJSJaYqQ+P+oI/0NlrN4w28hLKzjgeDY3Qid4tWPd0Be7ztiV5LvcRObEi43ppCJ59Ct8cTL6BO6TADq1/7ABt95F8NeGvm2pU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MQ7/s1jM; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777338046; x=1808874046;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j+X4Q+quZ7mzIOUMlQfc/ERc2qeXUck52wKKE80PWgY=;
  b=MQ7/s1jM7qugfmAt/+ICiexpANQb0KibN+hKIZmxipFZZ7g0AVSI344s
   6G+XCkSNlRUlnHY7OqfHXE8wobHfSPptlnoB7ycNzTwtDlwlJGv6B07uc
   /Rc/AF9pW3zglwEQJOUPwLTtTFc4IsPdBdsXm57YL2cXGxyX2SWKxzqFj
   lmqsRfhRJe1FyVxfXtJZHxzLfCmY2TeTDFfKEr3PQTQoFQ1WrEIphKxg7
   4BdmTxTh3FzuhRwTyz4gBE0I5kGFCk2i8HwA5/GuFd9mllfIL4r/HaeK+
   13OdXaz9Z7LdszldWkmGaxeCjmmYjcfBuj5jkDCDjuUy1ce5UZsXSA/1s
   g==;
X-CSE-ConnectionGUID: /DFoW9H2S8qL29P7pqyS6w==
X-CSE-MsgGUID: HCplW14fRlGeqoWgBm4Jmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="88935542"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="88935542"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 18:00:45 -0700
X-CSE-ConnectionGUID: A9aIqJ4XQc6RNs72lYKXpg==
X-CSE-MsgGUID: GcX4A/1FQ4CahBIDITVyqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="232789649"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 18:00:46 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 18:00:44 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 27 Apr 2026 18:00:44 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.47) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 18:00:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WU+JUYVew8ztulS4lSjPFIq1d62gok5AIvyGnjXVfSW4o3Hs3did61iesaRqDmhZBXlCPOAfQWeATuP0pyXruGGO7U2eJAyh5slgMW8T8ZuClRgT8RnZFORvs7VggGHRVVsTNVVuRjGa/IJ7tDyqmn6y31pAPFnczXtqB6bOAhO/ZnML1qN/8wxkKQtMxdVZlczb7ruLg+FSUzHX2XJTMG/X67E3wnC40QE0ldpgwjOEKARvKk/tkilpDN14cdLRVjEaWl1V8xABfqgpvOpKjxEjBj16KQyghcJzCv13rUOjYRP3d5EeNtKY5BlbkpRpMIng2gSBC38IzDHCcZaWzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qObNaBZGHsbLuYZrYCm4lpy10dPcVp35QR4qL3U9+g0=;
 b=VoUeQhpubPTTgfTsBrTXA4Pxhp7esOfNK6Ai3BraCd0ELmpStjAuXwP6JACOb0LDap4eTwca96DqpeinY7rI8pb4isXadFZTSppbgKjGX2DmeXlYxXDNgKD4uZvqFEq5xqgFsfFJaVC9g6izYa3kt4R59V3FybjzeLWs+MStIf8QL7s9gteVY5E4TVsfX9HSh7xbWjAc+U9RIQ2x/93Bn1j8uzBw8NXPnx24avhiSHgvKsfec8ihNkNaJzJvV67aNsRhZU0nmbuZDLZnSpB3YKfaqc8aOQ1/mTYDA7VURCXERymhn9qGOmXZLk1SOtKo5Xq/ZmXd0OXVgqqN783H0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by IA3PR11MB9061.namprd11.prod.outlook.com (2603:10b6:208:57c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 01:00:35 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.20.9846.011; Tue, 28 Apr 2026
 01:00:34 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net 2/2] ice: ptp: use primary NAC
 semaphore on E825
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net 2/2] ice: ptp: use primary NAC
 semaphore on E825
Thread-Index: AQHc0lSgwz/RfMjH5k6CluUWyK1sUbXzsAXQ
Date: Tue, 28 Apr 2026 01:00:34 +0000
Message-ID: <LV1PR11MB8790B76677F71878E4A2818E90372@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260422123144.485930-1-grzegorz.nitka@intel.com>
 <20260422123144.485930-3-grzegorz.nitka@intel.com>
In-Reply-To: <20260422123144.485930-3-grzegorz.nitka@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|IA3PR11MB9061:EE_
x-ms-office365-filtering-correlation-id: 02471709-2224-4ea4-d484-08dea4c18dcd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: HeNS3zP8TvkcJ3vqEahIQfP7M2xzz5fK6FedO27h4mipYVt0/T5p3WrmE8OReKNo5rFFqjZ5Ki2gV5vqB1narijAWRoCjK6I9VydVIzVGBM8nrhn9pjIG8Dounl7OdiOTHfJ1l8oyuT+s2+lo8I8s6i2rPb9z9zA5ujrDcjpLaAk1GuyEi5rzcde0ysPuRQjyxk37HefnyoBQydq9nro/ufurxzJLQRSASAIgIM1QXo7iqhCOqkbkiaIRDbE1lrsZC9zNIry3N+W+Y260iUI9Z6Vsl/7NL1bg2uia4gpNtBQSz8JckGwfHgWO9iyza5+1AUAq6n/3TI7837Pdqng4qkPir0o1jAxLiYSF8VKZrlEczKwK7w1cU8Atb0nOuQNzlMPZ5AAPFSQx2BGB8dexElyl+NFp+O2ai3KKtVuSBjp2NeaKCh4QnIrbwZXeorAxlwGX3Pl1/Pqt3AgQq9arhNEQKUN9MvvalQLXHaVuSdgCLtAVCJsGhn8Y6bclc2DkVUDiOFUE7VoIWMjfvzWOgCNUpgytZF9Xy3lErdkcyLFdVCLCSWJQdbh6XKu0rRYs+0hUFUxxOxoy1AfBxdUrCuEbWjQaJQ1ifEsRg4EZ44FHl+YY4T+ejtQ71IZDUI1ZhsJNpPLm/0+7uXkqY9cuNmoTwhR2rWgVbGf1GZ+DoEDlTTxafOIzC0ASuGO+TUDGrd3zBgAWKuTPhg9wIlSk433cCXvMEF5gfmjSkbYwBciv95OATlWZXuxp7l858M28gKq2ZBf7ei7HFVgUzg5hKwUqZUfkdvWKyGPxRtV0SI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eKA1BzCbBj3rhhTkG6pL+tE9HuFdNCuxXExcreNlZbA/X6mzww14mKd51alz?=
 =?us-ascii?Q?uGdMk6YWcWgDyfzl4gU0h0qEixt2qrCYLSbNqviFKyKrqHc1hhv/V7NMIkiH?=
 =?us-ascii?Q?nJ0+ZyxJHQSZ8yjp2YkKO6CGo8Y3LwJ/bFH5kAsXKm/dDHon1HfDp36hoXjP?=
 =?us-ascii?Q?nnwrhfq3oDGj2iokCcRPACEFQ5zqBIN1HQyKnrovt1fyQqpADO2r7+csQiuJ?=
 =?us-ascii?Q?KWJGgxNS7DuWSenLYVGaqfUoOwmuxdrkiCzTXN+mNYu2zMRhc3PFJ1rq0P57?=
 =?us-ascii?Q?Mc1K/ritH7GfZwW8N6gUs/XNEkI8LVagIuzcEAEEjyrcyfVv699zWB0RIraU?=
 =?us-ascii?Q?rrMPxCiV66fj3sKZeWP9wZ2X1gulKePp1NtAPluQM5CLQE2KniEpWy1PpqYj?=
 =?us-ascii?Q?D/IdsBFF/Swi2FVJen9KIXQrt32q9yWkIWw0eFLHu03SqJnBc0flMQGXt4TX?=
 =?us-ascii?Q?vLTWsz2L2eaWOD5EfByHMwDjhpByeKI65qZ1Yr4vVUzC8clhjEd552fWJqdD?=
 =?us-ascii?Q?zSM5QUzoqM5OJawsqq6ygE4RpBLjUCrwip4Dy5JOtC1oqYna6d4HRn+KDaN/?=
 =?us-ascii?Q?C8F/ynuhV6I2lPbSZbjSFD5Cit1Nkk0P2/ob4qWAANFlAlK620BuNV/A4ZIs?=
 =?us-ascii?Q?QVrI8YV4Jupi+sAod4zQDxvuVN9MAVZ5t71yoztAL1bHTQrCVwL0AnTnR06V?=
 =?us-ascii?Q?eK/sZzxF9NzfpXH6TuwqgJw2MAcFfs2Lb0sYP8UvfFSWekQ+0jMMmXf8fsbx?=
 =?us-ascii?Q?oBhUuU8OECNoW6Y5j3/htqQXKGpASrRGQWxcS95Vdcul0DylNNrEAiKeOl33?=
 =?us-ascii?Q?YMPP3nk2mgfOU6fyp69n87TyUB0rTyyAuddODhGX002J2Tu01iiBBjfeI9d2?=
 =?us-ascii?Q?IbEB3LUe3x8+kNRVs2oXX5qpKu1Ur8XUi+OheHV2zgneEdFnjye/r3XczY73?=
 =?us-ascii?Q?8r0xcmOmus2h/HMuUCigCqs06OQoiM8yD5D3t8XVyUa4drgED830YMJ9Zml1?=
 =?us-ascii?Q?UU3uwYuz3FTQQYg/wbWKodbC6mYrBQcXWXRxHdNBMORS+ivviJ15MwiFy8xi?=
 =?us-ascii?Q?hjpYwNRVOjRz6XGPKFTP4oAqkLp9kdyvBEWQjMcl4cgBeclYhUmaXZa6qq7T?=
 =?us-ascii?Q?NA7LMGkAa3JUtqGzr6TUeNMXPxtYpc4qhLBQx/xyHJ+qpcOKxpn9dQy1j5Kb?=
 =?us-ascii?Q?DjLT9y2mctc4tOd/pxRI0cDKsPuoOCDYvwzM+CfI/+FJdtGT5lv5yoOOUcDP?=
 =?us-ascii?Q?U7ZxmGXmpSbbAbA57kpY9O6ZqR8c6tsuL+t76qsq0HDrGmypAMKF7vzNzPxS?=
 =?us-ascii?Q?Be+a7mJ0DCEeuytRXXsLsUZwj147UL60M8NhHeEM3U++nycXjyRDKIWPquMI?=
 =?us-ascii?Q?mdZyuq6rFkolJl+D0g6kVbrpAhIiqlCSRD15xaDSw8Hz40UOQWEFV3XgAnls?=
 =?us-ascii?Q?bUKg9Cmo85Bk2m5mjCt4MnrBVpgDpkEQ6tv4b6wN5ZfSjNp3EEzCjEQoWW1n?=
 =?us-ascii?Q?XQLxTGo5oH9K2UGt8h1+aYITb+Wn4qM3D4wEIvPglVkNgLY4YbUc5dmYiSzk?=
 =?us-ascii?Q?IgVKX8m3iuXdYTeFEy794+HTiI4jK8f8C44muoEKvuTHyRYN9ez1erermpbp?=
 =?us-ascii?Q?XTf6fUUrGtU2vpBMd/YAyWPlqAUOxuc1FX0/Fd3wDF/ldWVQkDHK4zau7e3d?=
 =?us-ascii?Q?JQTb0PbpBQ/Tt7xBqwBwUxDPKdGsJpK9RavgNDcbTdEbZ58uOhM+dU23hNXU?=
 =?us-ascii?Q?S2m1G2QMAw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dVSxgWKKvYVwZaxFjBwdjq5Y/O97mpbDlQGb/A+WdUn4+ZjDeVMR70ez6z1p+s6uDeHNcHhniEHPLs3+r7qDw2VxmVeFq31u/WKshaAtlQLJsiWAYqqaLUTiHbl0G13/5WIRvUKhHMhSWLXJvR425pXHGNzeYqWuW8Tl/4rfBkNmobLRqQ1KpqMnlVfsX3UxKMLsKIRHRZyKhDGbnkxqqqOYoLHeyZZjG/a4EK96LMggUkcR8+zKjf8ydDrqGOXjyd14O1oafuAl6YaQzeNddc6HgW5t/FO43h87s3XXBNZi94OmpFmlibvolJ55KvIESOKAQ41C/QFnzAK6D3w0Mw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02471709-2224-4ea4-d484-08dea4c18dcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 01:00:34.7617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tf2crSALTZk2acw9j63fONm5mF3IX/AnXlxhNoh/YUhVDGAzvF3iLiODjYg6UwlweZUUI+VXvjIN975b6AYNHmWGrbYNkwfHVmckbj9sfEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9061
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: A945747C4A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281573-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,LV1PR11MB8790.namprd11.prod.outlook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.nowlin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of G=
rzegorz Nitka
> Sent: Wednesday, April 22, 2026 5:32 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kubalewski, Arkadiusz <arkadiusz.kubalewski@i=
ntel.com>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemys=
law <przemyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net 2/2] ice: ptp: use primary NAC =
semaphore on E825
>=20
> For E825 2xNAC configurations, PTP semaphore operations must hit the prim=
ary NAC register block so both sides coordinate on the same lock.
>=20
> Commit e2193f9f9ec9 ("ice: enable timesync operation on 2xNAC E825
> devices") updated other primary-only PTP register accesses to use the pri=
mary NAC on non-primary functions, but left ice_ptp_lock() and ice_ptp_unlo=
ck() operating on the local NAC. As a result, secondary NAC > PTP paths can=
 take a different semaphore than the primary side.
>=20
> Select the primary hardware in ice_ptp_lock() and ice_ptp_unlock() when t=
he current function is not primary, keeping semaphore operations symmetric =
and consistent with the rest of the 2xNAC PTP register=20
> access path.
>=20
> Fixes: e2193f9f9ec9 ("ice: enable timesync operation on 2xNAC E825 device=
s")
> Reviewed-by: Arkadiusz Kubalewski <Arkadiusz.kubalewski@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 9 +++++++++
> 1 file changed, 9 insertions(+)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>

