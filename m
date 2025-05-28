Return-Path: <netdev+bounces-193948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE83AC685B
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 13:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 125513B3C23
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 11:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7173227991E;
	Wed, 28 May 2025 11:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QZfzA0nX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FBC215F72
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748431629; cv=fail; b=rtuCAlEKsFoogajuDRTaVViYeaUSXfljs2B1gFdFw398HyW5V18vk0VXuSiG1mrUMP1BunNGcXnr1LkhAwCUbjRldK2k746q9JYY715a69cCF+fXRVC+k0vRg3rPoNT9zQvVFUiDLZdZmaSxj67NylDV9DyULv+kkNsYXGrSLmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748431629; c=relaxed/simple;
	bh=ptMeR4IM9gaTOtIS2ge3MFP5mHLDde3p1LtcEzXPebc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xw1QvmvIegH28vGqOgUdH0FXUR6UwaUkc4IK3mP9gadM9zNI7zfoE0sXKZSCIZbQnVwc5FeOCVrjP+kDziJIjhCuLtJh1RWJsClUy/1C8VngRM0iTc382UITrZlefVMTAyNLJAUZOZHxC6wtIuhJrBU+stKmMiPqXOIQEupXGyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QZfzA0nX; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748431628; x=1779967628;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ptMeR4IM9gaTOtIS2ge3MFP5mHLDde3p1LtcEzXPebc=;
  b=QZfzA0nXpMCGaBY/XUh+rd79uOIEVc2QzAbSwyzbgSBJDls2vTEq9dBZ
   QW8ZmzMbMCsSD2dar+5RWEqP4tMiRS3sp3+ta3rxRs3D0f2p+mh5qBdlH
   e5KstLDBGdvIQnocnmwwVeFv3zxQhs8ly3EQyLc28eSf/dUZKa0rV+NXG
   rnGV943GoqognScFu4LHguOcj4mspmQCBp/4La8oCoCJoFtCh5UEAUW8u
   QdwYNtxopq/c29erFkDeM7fjw4F9hduec193nWPRRXngiNhva3yFEKDZF
   XiyBRw9u3tKnuXoSMcRc0xum+YyqIsiXzDTR4hMl6Mef0py4pxz0Tl4cd
   w==;
X-CSE-ConnectionGUID: H7GUeJk0S861LpoXiqBbmA==
X-CSE-MsgGUID: 2lc593i+T6iLsuNAYonW8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50448550"
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="50448550"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 04:27:07 -0700
X-CSE-ConnectionGUID: w4o8ZE6/SmO0mRxLJumacQ==
X-CSE-MsgGUID: T1tXIij4SFyHuQxSLkXVTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="143854223"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 04:27:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 04:27:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 04:27:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.53) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 04:27:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lGuQ3W4ZPxj5jbhcmnVQbVCxUV+NtYfsYqIlgEr3w0i/kTsWbFco19tMJ+rwSn2+fbMlWmL0SJK9PkOQ1BOfSs2djioSTkN5I6txTUN8ZFO+6viM0VCDHU2bI0/+wSlyFlzeAudhQ3ADuHSAzaZb3ln3smXoH+aomWcDH+MwA8Z2QiFqn8iSARgH593mGTthX+yc9ldbhpr1u5NkAIP/MjbQLkpPQPlk+XdlY0sEgDxUlHktul0aLmzfrJJwKEzaobAGDIVt9AD3tdbkvmd69agPHp3M4CFSDA50BADZwelVsp9wucKkE8qEmyxIV4bV+iu3nauWR6xOP2b2zIEiFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEjYYKimtNoyVk0C13H6OqgBc8pmT/HsjglZL6lfREg=;
 b=Bpk3cPJKJW9mj1pDltULiPW13OAG/T6AdUEiCjkwS7LNh4Y54leA2TK+I8wO6oea0bI/5lTwcSKPKypC0tCw6bG8oZLVPhJfYDVeat/6kXWGlQBlldeSnob+KqMTP2lffMYYKbHZVGGJxrEXFGaBuhRTAhggorzBp9dhqYwcV4BORKJzTov+fzHwGvvzrjwu/tgj0G07aMiv5/r92wpI+sQOtAHvbKA8Bm/1JkK5Re3AXN+ZBAImfUMmqUUraFidU81AV6KbPMTzjr9D4lLhqgibP4uNxls6uguOhIB799lsXilDj6L9bMO2kS9FmZcBePGIVdPMp5w5WdQISoY1NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com (2603:10b6:a03:428::13)
 by CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.23; Wed, 28 May
 2025 11:26:31 +0000
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5]) by SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5%5]) with mapi id 15.20.8699.019; Wed, 28 May 2025
 11:26:31 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Zaki, Ahmed" <ahmed.zaki@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Zaki, Ahmed"
	<ahmed.zaki@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next] iavf: convert to NAPI IRQ
 affinity API
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next] iavf: convert to NAPI IRQ
 affinity API
Thread-Index: AQHbxrCopGRtF/oal0WfcGYlErEs7rPn+UEA
Date: Wed, 28 May 2025 11:26:31 +0000
Message-ID: <SJ0PR11MB5865DE8A38128C052CA522918F67A@SJ0PR11MB5865.namprd11.prod.outlook.com>
References: <20250516221909.187879-1-ahmed.zaki@intel.com>
In-Reply-To: <20250516221909.187879-1-ahmed.zaki@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5865:EE_|CO1PR11MB5154:EE_
x-ms-office365-filtering-correlation-id: 7c7ad598-ed06-4a61-dd7d-08dd9dda7eb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?5Y60WFzg8EVXwFWH3D8S+Ec5dJE4coayil0S6UM4qHBE81hD/RFWRxGv4pos?=
 =?us-ascii?Q?nc/q7A/Qe71rBvT31uZArGLmoEJb+zHvZbizsTXYbyEaf098ri0hMAO0cqVp?=
 =?us-ascii?Q?NvQm0bTQwPXeoHJIlQLPG1CPvrLzxirinnbExH2wedYC5T1t+ejX/j/zGCzU?=
 =?us-ascii?Q?W64qXFnISXE5znddSFj7NcQDHgWU8FQwJs2w1lS345aMJfsuirLdrJ0gDXYp?=
 =?us-ascii?Q?oiBB5X81izzUUxtRud5iy/812OCYUwZj+veuhhfpoLugR/9qtZou7jRGKns0?=
 =?us-ascii?Q?i4g+SKn0P+p0wnbUKE5C3oNZm4Eb4k4kRPjxLEsy3d6TlFgq+p81Uyh7ORGb?=
 =?us-ascii?Q?AnLp7bvYg5w7pjSSz0GKRA16n80kmqVZVc/4Aj/J8jyh7N5MJ//UCQtzqtv4?=
 =?us-ascii?Q?9IN4E23ow5lqpOpJCPPrdMIYeuOFerkS39ZpD196wi7NN2eps3s6jlhWVaMT?=
 =?us-ascii?Q?8k1Zjwyn00DfzgKpPeqlFnDdYz/mpCxD5DxlCJwPnxUEX6/ZuJqsT6QTXoOx?=
 =?us-ascii?Q?t65M+3gbPPI4Te/KrS6A4S0BKMOAQx1vwpFG9tEWRyWp+R3jWX3RxI4wrv7u?=
 =?us-ascii?Q?lQZ0YSHPXQLWl3kc4uRd1hxhdK6R7C182BISJveCmQLC3HsgJzaPshw0hQ+m?=
 =?us-ascii?Q?XSZ4S5CdVeYeJTzX+pvv751cKvRWXvnHsr81pGmb43LXkjxQ461FzP1vYEip?=
 =?us-ascii?Q?VAjPOqWimZlB8ho5vs/GwtrvQKFGcBDQK3M83pJaNeL6+ZbHBkU46roJrqGi?=
 =?us-ascii?Q?6o0M41l2XgkwQA1ngIMY+LQC9d0/VHqcP4Y1H62RUWbr6orHikY2Khj374DN?=
 =?us-ascii?Q?kDkhQoM1dLzSdSBCFak/zcctk+gEcnvxhWNxBn+zhdJLAi0Ud6PHJqooOMDh?=
 =?us-ascii?Q?JbTgUFoWQ4nIHmqC6Lkf8b6c03APqW6Ftp13rZ/acyAgM359mMrWCTeQWm4v?=
 =?us-ascii?Q?Dmn4es9EVT6JuApVvxvaKtRB3VW5ijPNecwjUHvWA7StysaPVeuhCd9Q1YWD?=
 =?us-ascii?Q?Xd7Xw92qZp/sfhKf9Yb+R/L0dbsvxTIBaunYoDx5bNqw0te4hKzF0a8dLOOq?=
 =?us-ascii?Q?mdSHoiB6zhVlfVDNf/DB9LPG5T8H+fSxLh3+dbUn8bF27h0OWIysSrVww7fh?=
 =?us-ascii?Q?13YB/BVQ+KHtCnd12/eC/IA/+ck0RuvJ3pANulRhqc5nzqS8JTew7szclB4D?=
 =?us-ascii?Q?Z/qKe5brmTgFQCiXsX+O9Gsb11u/LTmEOj7fR0HfkWKSLtYX/X2j6gUS+8j1?=
 =?us-ascii?Q?SphzrJnit07eJZvB4SjZubhV5THaIcUlukwbVNMpNvq2+q/Bybcscu2sM4Ln?=
 =?us-ascii?Q?oNfurTTEWwjSJTiIlWGO0qAwuFA0MwhwIz4Kn26I2TZ3TmR22yS+u6h1p+97?=
 =?us-ascii?Q?VllPB9y9c9b0r2jZpf/segU5RUNkNWMmclvvtqW+QhP2kD5Y2PyYURV2qrDs?=
 =?us-ascii?Q?HJGNCJyx2rq+EdxSC9sIVU+5FF0DOgkwOFpeXQhQazQO6Hx1+5QD8V0j3W8t?=
 =?us-ascii?Q?UuBeVOO1/00aSVg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HbehaLi6bikD72AemeU3h/fLEq0Ym2TvAW3xHWn1xuyA55o2aLPaYnlZEjaV?=
 =?us-ascii?Q?G/vLmbOHfu1NPbXSJZUtVeZRqhMtQu/z+UF1/WnePyJh1g7UsAbVlK4V+GpA?=
 =?us-ascii?Q?4TU6ougmJe3BJasza7RJ2iDXQKrANChfDH9bAc3JGZDOvcGpdegzwn98oEWa?=
 =?us-ascii?Q?ePM4XmjHIbtrDyyjY+U1Gpcsz/RUO04NRjDLnKEoevHHCw7WPC341sECm41t?=
 =?us-ascii?Q?TIgm2hFM4pnR1vEpQwaZWRtVkUWRCRtU5yFDaMYcOfUTn6UrGQkIbiejeb1M?=
 =?us-ascii?Q?/fz1Bff7TIjWuccZWxQ6y4EdO0W5TnsEjVoZBatZCg5ab+2OTAwNUI3bTNfP?=
 =?us-ascii?Q?maYfzX8v5G0TF4+VCD+6Uaykq27SZTB2aNOUF3DkSGi0YkMqYyZxxPS39Z5b?=
 =?us-ascii?Q?sYQyZQllF4NqYCwIDi5bbNBv2sGjmAmgGWGhwb9jCCxezV4dd9I95Kd/3/jV?=
 =?us-ascii?Q?Tn37oog6U04Z7wM39LhIzQ9gt07qD53p5GECN1jjHJ20KF4+5t2Sn/2TBp+Z?=
 =?us-ascii?Q?J71/L6QRzYAhCAqApLmc8soZH5p9GWQ6P1ZxjJlAHIpdkUTxNQzDrFbIyF1P?=
 =?us-ascii?Q?WR4nP/DulBYHbQBrHZdJAAn4PuCSe08FItQuejIHnPWE5U+hrCIcAcVpPrc6?=
 =?us-ascii?Q?MHaTZ+81NsDXF6nR3VgD9Q79f3C6o8FyG2ekC20MSqvXjPI9aAnpExINzQCj?=
 =?us-ascii?Q?pM5LZilVeH/6pxoRFN5OT0/3zGLSXvdl7kYqPcT9Nnf99bNpteJ7z8QteKDJ?=
 =?us-ascii?Q?QQ4ZvyugudUxTJYqLixRew8sQBJflA+Do2+ANuLNkadJ/IdUnN8UQR4zKm6L?=
 =?us-ascii?Q?QZTyt6NoE+EWvugOW+11Qtqyj0n9gpy/r9ruLHbmLjZGD3InfmLQ0NdW4+9i?=
 =?us-ascii?Q?bIope0m9ry4Yg3IKMDeYrUbVTXOGAmzcSDZWxOcZh0DnNltBHR3AGsf7pou9?=
 =?us-ascii?Q?lQ+vID/Gtc7NmzLa2LEcswJ8QWitTktQA6KY1G6vQxyomKHx/o49ZKWmsyMz?=
 =?us-ascii?Q?k32Rn/3NtdDG0zedHRKrIZN2qk9qXkjyB/eu16nX0kZJy/Y6T/oe038jJqa9?=
 =?us-ascii?Q?bfVhyja64vIAPZJ5vvLYhDkek8N9HqmDazisCw9s9blNQRfy9+55HtCbEmnU?=
 =?us-ascii?Q?SkSEoRKWfYGt3BfOB10ffIZmIhehn7Afkw0CtrY4SzGY46N0lC5iZSw54pEq?=
 =?us-ascii?Q?vghHnB80c9RMNKGydPfyEWTlwWDrEU49c7OKgWSit7yUpG5X7HVOF3m7rhKJ?=
 =?us-ascii?Q?KmgtHgkL51hk3rPYxx9nCmg1y58c7eaKLHXJ63moANomW9+WQANmnONcnane?=
 =?us-ascii?Q?pZ5RT/XUXzM1IEs5/+lO/B0x2yrx95dkctBAcBB/4jb8a7EFiuZllLY0yEV+?=
 =?us-ascii?Q?5vEtNuRHrMw0lLKI9EqJEX4VxCHyreZAh7q2BkTSCFRkqRwsfphpbQ6dz9Ef?=
 =?us-ascii?Q?860qvhBwzkFxZOIXX2uzcnJ1EWoWK1tlQrpRQ2Ir8eSmvSvbCURPpgJSjnXW?=
 =?us-ascii?Q?2UcZW5zPfXIfZBGgPFtkFXdZm0z64REr42AR0n1UBmqZJv5OPlZDtClJ6tql?=
 =?us-ascii?Q?q5JdmeOVv4nFgot/5BAyiQMGikx9+q64cxgypXYxD8eYMmQ9+lRMdpQxdKex?=
 =?us-ascii?Q?PA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c7ad598-ed06-4a61-dd7d-08dd9dda7eb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 11:26:31.0483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /JO1KhjnbKiTk7PgUeuoCgVNegcIyx9LPJ8a4KqBNvL1sWUAE9i9Pb9+3IZ54Ut120AyBIfgodyCPhJ4xtbxjc20p3xgcgTTOEUguY4uZsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5154
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Ahmed Zaki
> Sent: Saturday, May 17, 2025 12:19 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Zaki, Ahmed <ahmed.zaki@intel.com>; Keller, J=
acob
> E <jacob.e.keller@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next] iavf: convert to NAPI IRQ aff=
inity API
>=20
> Commit bd7c00605ee0 ("net: move aRFS rmap management and CPU affinity to
> core") allows the drivers to delegate the IRQ affinity to the NAPI instan=
ce.
> However, the driver needs to use a persistent NAPI config and explicitly =
set/unset
> the NAPI<->IRQ association.
>=20
> Convert to the new IRQ affinity API.
>=20
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h      |  2 -
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 58 ++++-----------------
> drivers/net/ethernet/intel/iavf/iavf_txrx.c |  3 +-
>  3 files changed, 12 insertions(+), 51 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h
> b/drivers/net/ethernet/intel/iavf/iavf.h
> index eb86cca38be2..a87e0c6d4017 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf.h
> @@ -114,8 +114,6 @@ struct iavf_q_vector {

Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



