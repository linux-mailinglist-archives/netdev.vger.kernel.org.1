Return-Path: <netdev+bounces-132107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B9C99071C
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 17:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338A8281AF4
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ED21AA7A7;
	Fri,  4 Oct 2024 15:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="REuRMeEq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64011D9A47
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 15:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728054311; cv=fail; b=fPLPO/lsUNJ6llGAD4yOLWX5c+YRxuP2ChBugK77K+9v5s1eedQC95OjxjAP7Ly6/85hs2cOgEhr9bAf8e9EX6Z0lGvi26lRH7CRjndao/B03N20WmqIH4J7EWEtsdsXWs4hQq6KXeIqxY0H6Y7Snclnu8NtmVgEMwMSMvIQ1PQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728054311; c=relaxed/simple;
	bh=dwntumV6Vaw2cGeaD3aXnroIZBTjCN3Gx30cYrtobyk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L00bb/r5WQfGAvVsbFnZdFqJjrjK00pfoDFRqj9nsIMiXpEhYsqbo9LnSBxqKaEH5jHykPYH3jlNNBGscvraNmDKojAkQNGPoLrdBiU6JLX/syV/ZftR2TLylXzqHxYErnbPB3VaIJdQH8qzuuVlP1qELV4SAG3NbUelO1MQR5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=REuRMeEq; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728054310; x=1759590310;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dwntumV6Vaw2cGeaD3aXnroIZBTjCN3Gx30cYrtobyk=;
  b=REuRMeEqlgxJ7GdBHn1c88u2CEslZ9FshbqMv5uLZB5T3pTd7anXcreN
   /muKMwaaujeC293/yeDtW55BCeH7UwzR6uTmtn+qKncGZJ/MkFjR6EKFD
   o6puybw03ZGiGez335TEVg/l8+xavOPl99BbInCwjNoUsXuDjdS+9k4oM
   FEExf7XTw1yQx322SRa8YVOnM1/0U56bzeFDt0XfM2noX2j9VigVMjQXM
   cNKbTuKRjDikBToVmNEtyA5mNCfxrk63KKlvoAaHEBiukMg4nCnSEYLos
   bpfS+kRBTUPcDAj+sn5hCY+0f/cdZ1xZuHqotITeAPqNDujPm7uG+Cq0e
   g==;
X-CSE-ConnectionGUID: 32JadygESsS2ziuN+Rtcxg==
X-CSE-MsgGUID: SvwQs+0eSDOcWCGC66WtaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="27369978"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="27369978"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 08:05:00 -0700
X-CSE-ConnectionGUID: H/79ZKR6T2WqLmNcNnwfOQ==
X-CSE-MsgGUID: w9ygUIesStCqDWA7X1uupw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="79302828"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2024 08:04:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 08:04:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 4 Oct 2024 08:04:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Oct 2024 08:04:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJJoEEORoCfJp1TaX8qDYPGq3khdS1YBtGaXQTuLD+OS3LyQl9zBpFJ6mf4ovsOIAyrovByMoz5ZBKkVykP+dQOZUXKq1NpOgUpBygZIneh8WEXxdjZhGdJb8YlArMkFdEbDJAR/Xwxq3zZ5PwArGzLT64t1lZnZQRheN3iwyQHeDbo3S//ywEzQiMb5JxTzpx31IexjJ8MjW1cM+MwNwIhUnP5/GmkYE59sHcDtmqEy6zSIzzeKRQApOo6DaLnaWGQmDWmK4DvEqQYvirY20rq+RmNyOAGJM9+nZL2jRUpPWzaNZ1OjovkAubfbWmJQnVFcqq6fKsFk3+0+0aEN5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ow0B/ZNGyeAsDFxjmXFGjLllkz16QmV4ifO5CrLtEo=;
 b=YYvpKZKRSjg9JSAELIulwN7U4Dp/Tmkwt3fJHjm+7nkplM/lXZWVhq/ZJ2NFYX/+LoBrGtOiOeuPj7bILa99wiIHdymiDUjtTQ4U0P17iFLSZKnt37PEG+9OVq44dC3rHBTSJx30niwWBQ25L3n/vWapouHsIe6TRgRSqjc4pl7xz4Yt90c6MlDMmnvfe+TtvH5KQ/TMy2f3r53xnmMdo46Zlub0NSUqxT78wEnhSeQi1TIF67NMkpltZ1VEpd6BdzjhQyOoVBccRljf6vwf7Q0sSRuWCn3K8VsDimQ3O6jpQBfSDEfaJDsHwWq/PJE3nDuxfFuX3C9l1HteHor/XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by LV8PR11MB8771.namprd11.prod.outlook.com (2603:10b6:408:206::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 15:04:53 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%5]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 15:04:52 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Kolacinski, Karol" <karol.kolacinski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kolacinski, Karol"
	<karol.kolacinski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v12 iwl-next 1/7] ice: Don't check
 device type when checking GNSS presence
Thread-Topic: [Intel-wired-lan] [PATCH v12 iwl-next 1/7] ice: Don't check
 device type when checking GNSS presence
Thread-Index: AQHbEzKp0ck11sgywEGpa9OZleMcJ7J2sw/Q
Date: Fri, 4 Oct 2024 15:04:52 +0000
Message-ID: <CYYPR11MB84299C1AA0AF50BFF64A97D0BD722@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240930121610.679430-9-karol.kolacinski@intel.com>
 <20240930121610.679430-10-karol.kolacinski@intel.com>
In-Reply-To: <20240930121610.679430-10-karol.kolacinski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|LV8PR11MB8771:EE_
x-ms-office365-filtering-correlation-id: 1c9dc728-a660-4e0a-68fe-08dce485e68a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ozgTglMWWQ1b8BkIM5J+UKfg50IDqHkv1xc3BRwEqSq3Su6npf3FxqnRGfcb?=
 =?us-ascii?Q?a4TX++03O77pBHRveFgRCjgeKKg/gRpFpo/x5OVIpuqOlKxgA9BaLHDqHQrf?=
 =?us-ascii?Q?5Sfk2jiKjDds9z1BvPtUdIedfAmTBjpAQcmbQy51dVGbDgO/LPMVnoZXVriY?=
 =?us-ascii?Q?z3rjKnj5q5jvvxCfXqASFQx9dV61IeCZmaCrKbILcWtfh3gw/7t7zBMcVEcf?=
 =?us-ascii?Q?qRADtvNrG8UO/7/JmsCUVT2+OlBSmS576SnrQlMFklRp+YiREnyfpcgTCAqF?=
 =?us-ascii?Q?bx5LumxmiJh6L9s7W6/XZeS7w5rS1M+oHjAsfNiQzuQOEsvcTM+qhaa7cA9b?=
 =?us-ascii?Q?M2e/KmYj5GSFqNPkCSacUZZDNBPBDEBjlI6kIYALt79wQE+RDcKxEKK1W6TW?=
 =?us-ascii?Q?+4z5wBorFnyxK1Hq5EOUzSVLesgpi4xvvnBFdPd+4+VHcAM4boU/EBH//Q5c?=
 =?us-ascii?Q?CD3snMeV7ljSqzHzjNApFurdp1LWqx8LUQMRW88ehfafeJATdKZRGhvZtHV1?=
 =?us-ascii?Q?KBPQkNwv1XXL9r1a8v94KavjFnQrQpD3Sruo7qKkhvu/4RE64mZzbd2Qu9Cy?=
 =?us-ascii?Q?F765hV/fQoPt37C8VboHznWiMf/hxFvhorbKJbiZIUd+y/qISl+ZS9GutypP?=
 =?us-ascii?Q?PofGflCvsqZVqM9COFPfUT7tnEGqP3vm6UuPD2zdYJ64z88JWhXTyz4pQrG2?=
 =?us-ascii?Q?bTJlH0+FLUrQiH/GdN3hPpom7Nt9Q4LsFgGYmSrhtyHMQ/4ctVsAgsuY5zsB?=
 =?us-ascii?Q?paDjDvQi+HwXIo0SVq+UfBZPTmiKk1ySx0QMIxu+bac4uajA18tqDUpaLnPS?=
 =?us-ascii?Q?+A3m3QIrPV0M20hGalKH5JBEr8kx8hYf3CYSFBYifbMNlx9U/fwJo2Y5007b?=
 =?us-ascii?Q?IIWAFUL4yaQJ0nKyaPmXmvtPjBdErbOngYxUsfiymidjwTDDx5TZk9eIWfLl?=
 =?us-ascii?Q?Nqb2diUyD57ZWeuRVRJzNIRpHzuRVgzcbM7CO2HY4b5/7Hf7iXWWmhLZcheU?=
 =?us-ascii?Q?ZKMe2/Oh4+iP6XVG1uyxPFVV/ctODe9sEuDXYY3Whs5J4Igv4yCyuNrB94za?=
 =?us-ascii?Q?HhiJkgEtkaA8NPq5DqV7WUPRWc9R+B0aWBCDbka5XDCLknjEfO4CTg2fw29R?=
 =?us-ascii?Q?aXvAj3ruSw6Wi+gKs9UQYwW5vmZOhOAm0ZqHMCmPjCgHt3HdgbiGuvf7I/WI?=
 =?us-ascii?Q?xn9SCjEitjdKtAs+97fzbMSjW/KrBOu9ka7vVLjid6DWAjSr+8AveQunBuHx?=
 =?us-ascii?Q?orb+nIguiTbajH8NG8shPVl0TDTCPPo2FqN3IM31/y8pQGx4SQooQ/XYH91F?=
 =?us-ascii?Q?IRYqFz1dyQByAVQlJlKPT51Kfoz3yiB0n1Lysyz6pa93yg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UpDze0P0GyAL9aIZpsXFlqkxySSpUawfiID2PbogdREKoXP1h3mWPrGi1S0P?=
 =?us-ascii?Q?oiibjoKcOKzVho0bnXyCPPQElwO0DFMdgZQTISB9NTx5cDQHUAZy1/7fLq1R?=
 =?us-ascii?Q?LvfsfbY4Sr4QON109JM9FCp/Xwv59wVkYurf5jj4psp6O+gJ/Yk8Z3QyEEOg?=
 =?us-ascii?Q?fqApYRxIiwcIJvSsVOsxu26zsPnV5UVu8/OwROQny5uLM8sQ2bSLl5cZHHUb?=
 =?us-ascii?Q?fuUIqm6T25DAVZ+hKhZt0DHYGqo1z6AWDTC6b+OMAM25Qei7UuJEQb/VIIfX?=
 =?us-ascii?Q?f0DBoTNrsCRz12eD/HFGJyvYx3bGk5OUQiI6rOTlraO/ErftL6iDM7AuhFVP?=
 =?us-ascii?Q?7y39KGfS6c/HAWbmorbsacR6ceHnUNZrz9k5sjn9DkyGpWQmgRHW4dRTgbOQ?=
 =?us-ascii?Q?FWUpYXiPau80yREIM/ull0XxEUMKqRb7pesOHVeFkhVa0yaCRMikmt4guWYy?=
 =?us-ascii?Q?V5GHeu7cXvsKPGFmv5Zx9SEDKNoIBQC/qs4aOfnvUjA09zDVFfbAgjJE/7OI?=
 =?us-ascii?Q?KjSZ3V1+NvNCk/rQwcElFd9zkcnmAYlTDCLajJKQQnDJdwHKb6CkTqKg/iQM?=
 =?us-ascii?Q?9KdalXbqhRYkIgdlkU0LCAagmOJUU1jlxSeV+WR3K3IR9oZcvcVJ86X4lUuq?=
 =?us-ascii?Q?wUvKZ+MOzlGjs17ZcFgkEOx7fSwxNWohmEEHPzJW5FcLUYbISEjYks2KwBXY?=
 =?us-ascii?Q?n4KS2LOfGL+jOGkXHI9/+gqaln91DYLdaYZ6gV0B9+u9kFix9JSCgSdKpfP2?=
 =?us-ascii?Q?XePWAosXUXfbhX2sIHzoa1geUqH5ZA+2VVGBP454gtqj2xkVmUXilJslqmp6?=
 =?us-ascii?Q?XLSyJmiZeqHRFVSgreSazhgqE5Zl60kFxKATZRwmiEbMvQPlDdCyXVcahlHn?=
 =?us-ascii?Q?/adm7Fp9ETjwhgb30MoyGAPYXak+kVAiBZrmuRk2HcAKVNm35+R6/4sY8arG?=
 =?us-ascii?Q?2R/krIkNr6wj+5X7SsSWzzfBMqXcJ3hDLSRqqedNXNetJ9hW36XmetuJMi7u?=
 =?us-ascii?Q?MhPUbzt/6OsxuckUqbrirQXreVOEOVD89TX8EtKlDQqK5ZawKUqyzHbXplvr?=
 =?us-ascii?Q?lIRJ0SNLGONhghy3/jaJxuWvP9N9VtuTkpN8b2rg1W/Cr4QKoMrTORxwliXj?=
 =?us-ascii?Q?qxJAFe+XWmEGa2ZzbHHWvi84S8eQ7W/84GJXMbjThG++nj6Cq9VFTtNVUytr?=
 =?us-ascii?Q?q4TeY8kN/4GOV9uHEbFaOsz74o8ZoeIXgXfGNHhn/5Wa0EEel/Z3qKQG2Q5P?=
 =?us-ascii?Q?+mjScRaF1OGB263tJ1y7NulMi4GYA9Rp1N7ntgjgcniFbqSOcY06BcHSGFRt?=
 =?us-ascii?Q?DS2iCt4qVBk0MDIO66S0qZPAYvImhqTvnDwBevG8fO/5A+DTE8l+5MliOnY1?=
 =?us-ascii?Q?R+1xUo1AOCr/ZK1/bPibeZ/eGQ6SC2BMGaIctsK/HlhkekVqqfM7iHzewpUd?=
 =?us-ascii?Q?3BEbLWGjOSI5ef6/sUVaUEeHm4H8VLBqmErdG5zLeUbhDDOlAP/Mj+yC8UcV?=
 =?us-ascii?Q?IGeDlxRMCpgpa9QpZUAkcOh86NCreYJ+wnaiQ7pOsLmj1pWQmcSP4XXpwrYO?=
 =?us-ascii?Q?asn/Ls8Jheleh/Tjy+4obmBGQdJNOfV5RITxp6Z/IwjraoPnLybu2J/Shu3E?=
 =?us-ascii?Q?JQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9dc728-a660-4e0a-68fe-08dce485e68a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 15:04:52.8822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EdaGW4wbTEDxrrqeHuSYQuznHXX9/UZB4WSq0+sE75UXjFUK0S0dhDqhoxVjpk5piGqGkqh1+aFlEZvdGxJLL6wSx0j4BU/7oL++9Jm3jSa06HDRBj8hKKUDG17jBSR9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8771
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of K=
arol Kolacinski
> Sent: Monday, September 30, 2024 5:43 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kolacinski, Karol <karol.kolacinski@intel.com=
>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <prz=
emyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH v12 iwl-next 1/7] ice: Don't check devi=
ce type when checking GNSS presence
>
> Don't check if the device type is E810T as non-E810T devices can support =
GNSS too and PCA9575 check is enough to determine if GNSS is present or not=
.
>
> Rename ice_gnss_is_gps_present() to ice_gnss_is_module_present() because =
GNSS module supports multiple GNSS providers, not only GPS.
>
> Move functions related to PCA9575 from ice_ptp_hw.c to ice_common.c to be=
 able to access them when PTP is disabled in the kernel, but GNSS is enable=
d.
>
> Remove logical AND with ICE_AQC_LINK_TOPO_NODE_TYPE_M in ice_get_pca9575_=
handle(), which has no effect, and reorder device type checks to check the =
device_id first, then set other variables.
>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 90 ++++++++++++++++++++  d=
rivers/net/ethernet/intel/ice/ice_common.h |  2 +
>  drivers/net/ethernet/intel/ice/ice_gnss.c   | 29 +++----
>  drivers/net/ethernet/intel/ice/ice_gnss.h   |  4 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c    |  2 +-
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 93 ---------------------  =
drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  1 -
>  7 files changed, 105 insertions(+), 116 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)

