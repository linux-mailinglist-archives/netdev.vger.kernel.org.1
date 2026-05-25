Return-Path: <netdev+bounces-291234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PVsL+TLE2onGAcAu9opvQ
	(envelope-from <netdev+bounces-291234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 06:11:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C21CF5C5A1A
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 06:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5AE73001849
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 04:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568F0306775;
	Mon, 25 May 2026 04:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TIcCYMyi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BED214AD20
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 04:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779682269; cv=fail; b=k9muT8EF4GDNnrLLZturjSDjX6JjydCGf5BqrVboZV/ZlOl7YC+bTLoSA6Voh9jG54NQLvLYwe/A6eM0i8WyLuG2vMOtQSbPO/yzP4xGjEZi7rNQfsabvBvWNe8D5BaKHiLUv9AEPiXFgkR8RMTM+XZRmzY12EGhNSxT8+86FrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779682269; c=relaxed/simple;
	bh=aIM4/9xDYGurXuV14AmgEWf+ZWGzbrAgKl5rTjJ47uc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ucAOR/jAObDViU0MgYHAvUCp8FN/62TlHhljNq+VF2BOKvbCGWx8ezdPBf79zKdQ1P2DijL8fzu1waXROKi272bMKf5cudK0CJgBX0EeeDnDCoSxHTdiWpHrP9JlvGlRAfnlFuEb6ETgUuw6ht85Nb2G517HBwEmNbvgjD+LdMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TIcCYMyi; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779682267; x=1811218267;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aIM4/9xDYGurXuV14AmgEWf+ZWGzbrAgKl5rTjJ47uc=;
  b=TIcCYMyiUti2j9XZ7292il9I6xS7zFwlqPHzkpMfCVSuiMvfz33pVM7A
   5jTN77Cw7imKc62DbaW5/Z3uhLHgAeus1EtQaSoXSY8IL+FFQHxwDAI7m
   eYrn68JWqzXa94E2rLJ3EXGP7b+K0CS/ogqDyY1H+U0cZxtmK9ui4TSsm
   Cu/mtQ/FVR64+jVll7LL0LMuQPP5MabApT7Tlvnq9m2U9/9vLCovhO44b
   Y2Nl6g3ajTOhdpcyAs+477g8zbGDgRqJFu1PYYFe3mVsp9BYI12C18Esm
   ez+3Y0FxuSW/V6a754KFOUz4F2INjhMchZ4SzmFf7G5jr9/GedcqU7BRr
   g==;
X-CSE-ConnectionGUID: 2I4t+zJvQM6zg78KEtKOkA==
X-CSE-MsgGUID: BlRwj48eTna9rlmnVmHCQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="91974033"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="91974033"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2026 21:11:06 -0700
X-CSE-ConnectionGUID: bb7Qf3yYRAGjxABPkzRpGw==
X-CSE-MsgGUID: JDOHlHd6TZazgVaDjowWoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="241349071"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2026 21:11:06 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 24 May 2026 21:11:05 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 24 May 2026 21:11:05 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.30) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 24 May 2026 21:11:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCa5oL8l/rBfO1XxSZtor0XM+BccTAj52ufmcumNV+L2+NZ01bj3i/XrHbDm33AIhK5jO4jWAmouJM9RaLvBeKhSb2fg7CMLDDSNHeK2recTR6leDVuIcowGgicnWwwzcCowMfCYuV3mEXGEd0Xr5srU5cQoe+CpJ2Kw6hnTJ7fAPHKsAa19MgjqNHIFlv2VSUFIs1qSsq+lPqvZfUiijW2XlaHPN/VVFIGzjoCS1FT/sgVURREUolE9VjETmuIAUSwxITm9n9F8TSH/b1EgBkHHN5OxpQhH3MIc+nrQueup8RUXo4K62VA5JSLUx4m83319vVS9FEZSRgooh9Ew4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3dSovdKIoYYEuhTtG5GDFqrXydRbeQnNc72Gk0m9yg=;
 b=aIiA7Q9WOyF9UrumVvuL8YuSQsP31G1aqRftYVjcJEAEjBnXy8jtR0sKu9LtgGUkDtcysmAq/5j536hnXF7TKwrDJuW87DxIolHUGRQOzezGpESPSbnIqQ1C7EctyCtaQmUNxdyfqP6gtmtrzKFBIM0XFlEEUEc7JMS2n3QS+4yTSKhagrXlZppL8TbevG5MbntlfEcxmi19NBh6aLB4P3L3VH02K+V8ntRp07dPbiCtrxBaf+JgBsf9ufsR4CsSeGzmY4OqKwAuTwUvCDtZgIbRsGjA9oxWR6UUIivzDX7mOCe+5I8QN6OKnrcnXkMUD+FIKb/3NEslMvD10WV9ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by PH7PR11MB7004.namprd11.prod.outlook.com (2603:10b6:510:20b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 04:11:00 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 04:11:00 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Korba, Przemyslaw" <przemyslaw.korba@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "Korba, Przemyslaw"
	<przemyslaw.korba@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next] ice: add rx timestamp
 tracepoint for debugging
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next] ice: add rx timestamp
 tracepoint for debugging
Thread-Index: AQHc4Ri3Nu32IPsjdUuO4Q8bswwctrYeL2eA
Date: Mon, 25 May 2026 04:11:00 +0000
Message-ID: <IA1PR11MB6241A226EF59F7F6D41C77D48B0A2@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260511073657.1073780-1-przemyslaw.korba@intel.com>
In-Reply-To: <20260511073657.1073780-1-przemyslaw.korba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|PH7PR11MB7004:EE_
x-ms-office365-filtering-correlation-id: debb7109-d88f-4342-01af-08deba13a14e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|18002099003|22082099003|56012099003|38070700021|11063799006;
x-microsoft-antispam-message-info: fb+rXiH34A+fqVHk//v+gsHnUYSnwA7dG1VVDbSxm0lwsf1XSFf+xnxivUDoK1KjSDdCMGRVBzUiqY3BS/m/srb4wz9bS0wkoPoWZRp4qhyfgq10Asw9wkVnl2Cm8JKP2N1zfMhFBEKyidfDtOGViwJ8QeAcNMFlpi5zbaZOj+iGRTv4+BavFXz2bSIG2wIihLBe5wQsge4DpCxdUlNjn2JCXi1vbM9PV74Vn48gRCgDU5xvAIngDSu77Jhu9u8dSQSmjikGc+6sWmlt1deVwaMbfTThLenXRmIyR4ppb2fjenQo7J4ODHQ7xIoMwzRO4fSUJnMxapZBcKqUPikE4E4+J+BAT1qmdEZMKEtUIQV9TSflW/eKSvspE8LbBERleQpxH0Dviha+Dq8ln+mozvaLPtkrctierMEmoUtvIz69qzJTFzXHvBMkTM3pQVAdvNAZiqpBvpBtg15L3leceCC0nLBuAf0XLfGp7LjBB0gyxoUhW0ZNjhCyVAjsx8DEDTSl+TDROp5MSWm8ygFO3VFfQ3h8LbLyATdrmH2dQcJq/ul9TZOEu/dLPlfLrnE3gI2hTk2lbH2E4rjXcg+DDAsrhfJ+353zJW8uCC/gFmmpBcVyxcDpsfU+auETrNi8BAL6TnEiDBI6m0NqXZqyQnm8p7isc54tZ7lOZqm2vAJPcCAVM+U4T80nHHedvSj3alXiWePXDE9Aj5j4VOD33PN8GRzwat6Acazkh3fbsOzRY8/jhTduddO3ru+l4ER1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(18002099003)(22082099003)(56012099003)(38070700021)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ID5ydNEcvXxA/0N1NZeNvDQrrhLb3CfWEkVYSs+6MHvfTIyMdbMAaPRrL68Q?=
 =?us-ascii?Q?r/n9x0s7swOht+HgcjKWIHMjdPiqhgWmb8zew7khUvq9FO6SuzOcQSUVPlS2?=
 =?us-ascii?Q?lFTK8HMpiUvqGR1xGawMlrPSOSj3lsXbpylvWiQ5gBMwOFd80kwmu//NZVPI?=
 =?us-ascii?Q?/mgqLScOHBrijzU3cP8+QRlXsVu4nFFpo1fUjV1X7JBVW3NgruCW2I6hGcmH?=
 =?us-ascii?Q?xHlj+Miz6apd23Bk9KgUYKKYO9QddcfVHdDk/XYooXso/9H8sUh/jt9PpeJl?=
 =?us-ascii?Q?7aQ1WvySk2l0eXgkPzOB8RuFa5jhqIU0iWWsdFxqBLknTz1s5hubiEScgC0U?=
 =?us-ascii?Q?T518riS/B09/+2vRX347sy/h6UMcDFGqnXE78r1e6kHS8KJSIhDf4y6yh/7U?=
 =?us-ascii?Q?rowX3rN1qY4anH0C3+mMxR/MccPiG9ASVhGXPe0opS0Cs1uJI/YhsMmn7rLW?=
 =?us-ascii?Q?6+F35KzDuqeEHuW+GW8RgK1b1dFwjIh17Gn7xKpnryil53edGmOj45gX8AUo?=
 =?us-ascii?Q?grg48hAozzf0bg/kqBJ6yEVyyeFQLWzwdhGGXrdJ4trlwmJYEgqAXFTbN/FI?=
 =?us-ascii?Q?QZ8fs1ptnTvkrdIeAlWO/ZsUh1LUuwIbeC0697G/0SOtaEDBBmDrceU63s3Q?=
 =?us-ascii?Q?g91brSxLTeBosm+pM7j7vg5GlS0nijPWCMQ0/s36fqqY8Tt0I5rU23f349x+?=
 =?us-ascii?Q?icqXeaXNye2ikC5U+FrkYFXE/uxifJEKq9uOeZa+f1EThe5NYzE91TpJvqmZ?=
 =?us-ascii?Q?iMMiYUUb6B86wjvhztnJSWtZZwYQcnal7oz96EDSgG1trVEKpLB1MMiHQWaZ?=
 =?us-ascii?Q?Q8HvFSDMhbvTwn8b98f9y5WK/btb3VIB3Gr3j8mkqGSagbPfT8AtnhIsa2Oz?=
 =?us-ascii?Q?Psugn9yxPWFwuEltbrMUygj80M99VkmW4i/2YYvHBVuCGM84zhxNdTRm3/rd?=
 =?us-ascii?Q?IgcV/o4X+Db+22RxyCtG8iaozh/HqePDmYkUeTqV8eYFwqXKr7v6QEqG11jw?=
 =?us-ascii?Q?a7sFxHttFVBDnpLbbu77wV0DG/YmsfmmRMIevyEbIsB9JdsjsmJSJoGC0UVk?=
 =?us-ascii?Q?BWvjOUNpRLZ7yGhVN6N/TZYewMO172sll92YLsEPee4XN3VgJTuTo8QRq1IQ?=
 =?us-ascii?Q?bq5zt4yHseHEFhxksVEa40aAwh/+ZtsSZ02CjN3e2y6EpCdZmtGn6aRa21ln?=
 =?us-ascii?Q?PsfpYdx42YYjhJblC0Ye2spppUWNrXpu6Ln19MuhSUz9RA2Fmksf+VSsSjT/?=
 =?us-ascii?Q?ffCQXrL5H/844gEDf1grjPb5LtcIrDDZ9akcZ0G0IqW2rObW7Kw8xPnUTV8C?=
 =?us-ascii?Q?KhdFfwjpw5elgwBkWluJd3cK06MmiQ0TK4djXU/nPCwSq58gTPM0aDaL2bmJ?=
 =?us-ascii?Q?+sGTXZUcgQsMg5ZbM+ecJa4/7F4vcJ/domUbm4xcyzaOW/k4T+HoxIBHfzLa?=
 =?us-ascii?Q?RJ4noB6BIAjTM63S/sqDPohf4Gy8K4Q/Xd8qSZUky5v/rZhwzJfjhCGFm4iQ?=
 =?us-ascii?Q?AggF5Mo2aRVMnpjCJB63mJ43wkBcfP7tJnvdhxV+79F3lYizwGxQRwLv6Kxf?=
 =?us-ascii?Q?TVCRoUIpIFgn/cWxKSsNSidciN0+oWeNxctZlCdoPp4YAafX5UlnD6gr7THM?=
 =?us-ascii?Q?YG5d+sIkVkOm7Vw2IahwR4rViMFdYgU1WnuhoAU19dOom/cR1UHv3TsQJx0L?=
 =?us-ascii?Q?r2KjCbIQ8NqLggP6qNlfuma91APhRCHoqYNQiRCQXL1hJh07FWd83io4YVEa?=
 =?us-ascii?Q?8USPqQDA24xvmKTTy+gUoy1c+TJoTfY/TJ00RcOCRCshYAxNX4wlf/2Hvuri?=
x-ms-exchange-antispam-messagedata-1: C/HL34T0/c9Acg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UdjxSUQJD/Eja6r3/wC1q7VTBNgcCy+VHL+fiY2X+9lCrxVY6VCwHCY7OrGN96h2Hr6WE6RoeaV331ws60DcA+6OdQWBsMXr3QAkcJv/DwGTiOkQLGpyw7/eU3L/ui0HKlVog3ktZYXhDiVL0e40zG9BBP9wex1vBdmpZ6nHnBDP8PFTWHMQ0deoTavNpmWfbErnIivh6eVzKijeoBHAfwaCj/sqcdh4UyFV0YfPQ8RLrsWO0/CAsrRCovvL5h2MKTwoz6OhFTtXFGKtuOfFgzZSxX5EA6FGN2KcLfJXky0bAzUk02Q4v2sae4Hj6U9tfnglCrD4/g4fCoTLiwAKeA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: debb7109-d88f-4342-01af-08deba13a14e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 04:11:00.6273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lQUeK1J4jiEMAmhIVVvuJGwix7o1dT3B2UKyD/YkahW5GJkNFGjsI3nP542y35SYFYyY4QZT7G5HxID1b7+P6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7004
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291234-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[IA1PR11MB6241.namprd11.prod.outlook.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C21CF5C5A1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of P=
rzemyslaw Korba
> Sent: 11 May 2026 13:07
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L <anthony.l.nguyen@intel.com=
>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Loktionov, Aleksandr=
 <aleksandr.loktionov@intel.com>; Kubalewski, Arkadiusz <arkadiusz.kubalews=
ki@intel.com>; Korba, Przemyslaw <przemyslaw.korba@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next] ice: add rx timestamp tracepo=
int for debugging
>
> Add ice_rx_hwtstamp trace event to help debug PTP rx timestamp issues.
> The trace captures cached_time, ts_high, and the extended ts_ns value in =
ice_ptp_get_rx_hwts().
>
> Enable with:
> echo 1 > /sys/kernel/debug/tracing/events/ice/ice_rx_hwtstamp/enable
> cat /sys/kernel/debug/tracing/trace_pipe
>
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> ---
> drivers/net/ethernet/intel/ice/ice_ptp.c   |  2 ++
> drivers/net/ethernet/intel/ice/ice_trace.h | 18 ++++++++++++++++++
> 2 files changed, 20 insertions(+)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

