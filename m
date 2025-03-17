Return-Path: <netdev+bounces-175314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C62A650CE
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 14:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF5E31891660
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 13:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D7E23C8B6;
	Mon, 17 Mar 2025 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P82yj1ac"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E9FEBE
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 13:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742218093; cv=fail; b=mXtRiOMLVo6hRthf9xJiy/6HDMRkuGivOWuScqJz/mV8UUodHKEJz5gingkJtAFtZ/NqLhQy5F0Me7vul3wdMD8N7fI3da8+7EuCzyLxzo2XUq7Lq2fpngnkyTE6DhuBXWR0K1vqS12415DjjXTmy3wfdR3aTZctuvdFp00Uoag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742218093; c=relaxed/simple;
	bh=ByW44mYwiniQR1KkKEw/eU66tzLRhgXJdLofdyXfYIM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H7kl10sYWDVCwpq151g4g3IqaV5llfWC9NsTohV0vtp4ZM4CcAmgr3h4LMuV6BNcZnjmr65yAfhu9UEZiLOt3wXVe1ZCGqvEKIO9t1gxqwqDu8PsGee9XhLnbHz1palCtM4G21C1NGYsGQt31EUVdaSYsif6zfSzYTLTSrMm9IA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P82yj1ac; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742218092; x=1773754092;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ByW44mYwiniQR1KkKEw/eU66tzLRhgXJdLofdyXfYIM=;
  b=P82yj1acwTMlumjhwk9/R7bEv+QMM+7Xg2xniKx0vnwZr/i/8uFGSCyM
   ZZgvtBshOuQdo1ZDUBdAJqA+VUs75FhIWOVi5+8vyMRgPcKueGsWoIyob
   CfC8dZxg8LjPCRbZ8uk9Eb3XaHCJOa9AiUUxdmcttSl2fyO4L6Uv+Yg1E
   QpZJY8hM5/B1P2Gjj8lrSboUJkn9uhAYCEg2oKwlM3zwgYGNBvQvQaWj/
   dqZggVF7dcaoC9oOFxBm9MbfAzKOI7YSl2XQjWcpQw5QQ3EuJzy6kEY1+
   ZfEE5eJdT4zVKqCj2cLnxpuZUqo3UzQsXjteCrTEL1DjSVou7JwAsRFyD
   w==;
X-CSE-ConnectionGUID: RkUaVyxlTUSrYrFmB98wWQ==
X-CSE-MsgGUID: IUocb8ApQPys4z+w8uNM0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43336961"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="43336961"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 06:28:12 -0700
X-CSE-ConnectionGUID: dtn2jR3VROCRgBFXyxON/Q==
X-CSE-MsgGUID: oCImIH6rS+m+PeOzPuKLPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="121665634"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 06:28:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Mar 2025 06:28:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Mar 2025 06:28:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Mar 2025 06:28:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmIkYFja0dfhhCmrrBbztrRtIdFcJmBl9/kHZYMD+KVNO+DMZGYV1sR1+h/AsXLxQWwcv9Tbpc/GKUqTAcICrGhZ/l2RdkngwSP5lTHTvABq4NzPZrhiSi0mpJWyqH3xOrE8lQEHmWFeRE6dN+HuOL558ZWvXjEBRyygackL/0IrlyiD9yZyx2Z6dryXyAYJsK/ll5rmMOcI6Vv7McD+z1iqwv4/eeFr2roXGegCi5TEXdg6v/828Oj8w4ZYIzyxQRgEJf+nNzpmUjmcXT9Ai5fvAeDwzxAk8BxNqnCh0HYbd3nwSkSoUlZV3VnRptEHMFlA7mXS9LEwj/WtvcstlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIcSgRcA0z1nE6XLsKZ1m/eUNyawy9+WaWr8opEuLP4=;
 b=gDEp/CPGoaDx1miQywaH4HZdV4hztdMHcjubre/PWi6W2gqdcdOCo+CeEYM7hrtGnvasJUTSf5Qkvy+n/JmKn5z36o4nWP/PQpWMLsoR2E8EClmiR5jlPaxdARVFJbmoyqM8AEi/2HZiVeePzyQxNGtQyonKf7njxGcUKAKdqYHqVlnq5ETNlJ2Ua3y9djUsgiHLl67CdmXAYcHOyNlZMeG8PVXs6pNFPEg9i7ACxOiLAwBcKabjGGOHe7SUUbosEckF0tikhaUDx/KoOYJsuoEvl1gbkd4AOqWIUKesnOCN2LZ6G3oZr+Keuv7vz4T3xd65DfAotPRvkUQnoqt/Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com (2603:10b6:a03:428::13)
 by PH7PR11MB6676.namprd11.prod.outlook.com (2603:10b6:510:1ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 13:28:07 +0000
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5]) by SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 13:28:07 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Glaza, Jan"
	<jan.glaza@intel.com>, "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: RE: [Intel-wired-lan] [iwl-net v3 3/5] ice: validate queue quanta
 parameters to prevent OOB access
Thread-Topic: [Intel-wired-lan] [iwl-net v3 3/5] ice: validate queue quanta
 parameters to prevent OOB access
Thread-Index: AQHbjPXnEIToo3GJj0icD4TWxm7EA7N3ZtoQ
Date: Mon, 17 Mar 2025 13:28:07 +0000
Message-ID: <SJ0PR11MB586553D8C05A600B42D33AF38FDF2@SJ0PR11MB5865.namprd11.prod.outlook.com>
References: <20250304110833.95997-2-martyna.szapar-mudlaw@linux.intel.com>
 <20250304110833.95997-6-martyna.szapar-mudlaw@linux.intel.com>
In-Reply-To: <20250304110833.95997-6-martyna.szapar-mudlaw@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5865:EE_|PH7PR11MB6676:EE_
x-ms-office365-filtering-correlation-id: ff51b1cc-b806-4d8d-3e7b-08dd65578e2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?OSSGrUmXYHQZOFaLxDojLrKv6FCSvBxCutq3bRIdhCORaVQNpiO2JHshRNfq?=
 =?us-ascii?Q?qlphxCEVls+khm78UY1BHeeJPQ4GTkGzovipNd/9mBuORCCu/WYryKqNiNOn?=
 =?us-ascii?Q?YBamq4vry8u9+qSfshbtKzcrznypvJFU4FzfYqbb7o1kJa9Kd15XTV4qbpcS?=
 =?us-ascii?Q?HjdR13Y3DE2QwrPUPfpaY+2w/OLOejG90rvwixdPWk/tpNo8dqjEDPnZK+O2?=
 =?us-ascii?Q?m8VYRRW8o066pFspmFCsBOyfyIVG4eiSU3H6ENxtp5dH0dK/wD6cuOu9Ys5J?=
 =?us-ascii?Q?dXDPrO79GpEe7Us2MBfjc5rYWsg5m8p2gsUQqDRM9c3SUMxq8+7Vz7pis1xj?=
 =?us-ascii?Q?9GyR9xLZpvi8DCeanl++JzWJ4/zb9d5aN/CBO2HUUo8dXOCYZJolnPNcC+np?=
 =?us-ascii?Q?uwFOScf/2g3BnM3pe7RjupJDFhfNpzbfsldJlHUkXuWYJfc/h+8zoPpGL5GE?=
 =?us-ascii?Q?B7cFWTi2l+StdL6VrC/6hkWv58AEWyUQ1mGoRqIIK8O11taoar74bqHn7FZj?=
 =?us-ascii?Q?f4hIPNDBfISB3w2y4bPvzuF16ZA5hPw/4/S7KIofxVfCu4R4aI+uJ5OTnT+N?=
 =?us-ascii?Q?rv5hl+R6nMtfGpnlNgKNG/IO/eCRCKqcRyhypiVHgjOXLgFJqjTxtBqQokZC?=
 =?us-ascii?Q?gTkCSP9dWnRB//7/1rTR/S+wtprcfu2yJsZFis9pCbR1051KFw+YtFBshXvV?=
 =?us-ascii?Q?byB2NtiyTq8I2Q4dehwg6/6+qTx1ZTdcF/J9ps19aQojhxH4cwlHcrnpVipX?=
 =?us-ascii?Q?yxdyAzcSbl1r6W1JKy+B1PdsE3ODH0ojYPxADcxR88AMX/0w8Si5kv2vev9o?=
 =?us-ascii?Q?ECn4KTiPtZCQLBaZ4dFbmKnAWpMw4nX+BXqq+1SslEWvNep3gJuOiWol28mQ?=
 =?us-ascii?Q?hpqQxZyjzm+jMCGWGG68l4O9QEARVSekDUGkYMpx+2tYtCguOquqz54iu+gU?=
 =?us-ascii?Q?tmbBVqrxdB9St33apmRmemnycLp0BE4jx7jdMQn1SMMb4eizIjagWNo2a/dw?=
 =?us-ascii?Q?WNmD4csw8A41wUFi2SzdM2znHfaAU7Fd+zuuIRTbKh7ivD/LT81dAi8nfsPN?=
 =?us-ascii?Q?jJnJSS7dIMY6gM+kKsvkljke38h1nMJSARctSFbbecl4nXjl1fAFcwPDN7/Z?=
 =?us-ascii?Q?bVCTerh7DohfjPcP6I2zn8EAE49VQQt5ncOIBteN7x58NK8R+rpYxBxAfO9+?=
 =?us-ascii?Q?GLNEuYpuZp2m9345yct1eSqZdeRUD7ke+EzinUzHyefMVAT+dZWpr16xNL55?=
 =?us-ascii?Q?+wtHQ/1Ol/F5fDnHDmWLpDs7yfK19QRErbK29hyGUZgf46Tn9dqrIs+cpvUu?=
 =?us-ascii?Q?6LWIUtW/lVz1VE4Tvd76EVYrfn631cxJK6P2h62U8MtJNOljrphyCEDD6VEU?=
 =?us-ascii?Q?tUFIdq6kpm4AcWRFBNEWuUIeEr0N/V3wun4QhF+4gZUm+ca20iRHj1atiGRa?=
 =?us-ascii?Q?JuNzp9k8JEj6wd/WN90BAfi7O7fwkXAF?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N8SNrWzXwylaJ40X4hrpRXl82R6uS2UgH6vLoDnSJfSn+KnLTxBPzA3JOsHM?=
 =?us-ascii?Q?QzdfYPaYGON4yXQliPPFy/ZMYz9t5ONZWvwbg6PJjro9XvFesWJRbDqY73U0?=
 =?us-ascii?Q?rUiAnCXCBPcwI1uj94X5kYjMSg4IsbwbhdVQ9CyE+9zKIo1853jkIcJyEhtt?=
 =?us-ascii?Q?Mhi7VePezA7YUWJ0rtT6H4ye4/hYM2358EiSx3XCsFL0hMtBM7PGCIfjKdjr?=
 =?us-ascii?Q?Il5lP3bykqrgRHeQJKNYJha+Fl4LiayjXAE2RJ9MwE1zSSoBoMxDVvTmLGeY?=
 =?us-ascii?Q?q8BQDd5WaGlat/d3aVt8UzPVo4q9y7swPyrc0m1zpjB66ArMfLB6/wg0ReRf?=
 =?us-ascii?Q?5PQdi87BhPMWOELX17fDVk2DcBDp1u/AcIeK/2J1MaEjr4fvUcUcgfFV0QJe?=
 =?us-ascii?Q?Dpol8VUPs4LwYFwOdz5AiFDhOX1ufXldx8k5nvgXquNkNPnSKsx/EAO4zuMT?=
 =?us-ascii?Q?Q3TtX3EtErATPTQ0pfLTzJ/cFUbuCPnM1hn1gvR4B+d6AVC0gE16LaAUr2kq?=
 =?us-ascii?Q?wpcpsaw7DWtgWvlYSIh8buGLMiswrQ6Q8qlxPlwTVrjChW5VmxiovlTYzVzv?=
 =?us-ascii?Q?h9QOylgPAAIaou8GWX/VidJK81EO8q1uxRmHslk3s+jFrV+nrOADk65i6htw?=
 =?us-ascii?Q?IqSX14Ecp8osBmLyjAc4bW9bdTpmm+VdSiThx/Gk9/fvvqHkm6rKQZ5BqukL?=
 =?us-ascii?Q?XIXrLJkcIz0aEkXmj0xQ0qsDARvtEp3Y9KCZDQz6yCd0dIN2qa1qIuQfQyJ1?=
 =?us-ascii?Q?G1w88dYzS6guBCddT5JbRJRzdEd1Er54kbRUIxILNXPz6+asiBhzAwvjB9+d?=
 =?us-ascii?Q?2dXXfNncCYY9LS4BL0SXNN+Zjmh08Deu1x58zIXejl6GvDGo6VHeaIn/atCw?=
 =?us-ascii?Q?HT2lmT7nNnGnCxsnJjtpl3EadnwT+9DgwKRET4Qcc96xB1he30BKRXlesuqh?=
 =?us-ascii?Q?y1NPieG2ylxi30PA8a1UJ+ClORIuZDqoXufqrDkyih1o6eyVTACAW4CeS+0Y?=
 =?us-ascii?Q?Qz3/wdjSnj61FPXtvjKcZ8BZK9ywCwcHwfzE1SaJOnLggWkvu0GKfeApuEna?=
 =?us-ascii?Q?Z6WXb8Td3xul4Bvty6/JT8Mi4AHoVCzHwk6XkqIjV0WS2PYfCn+xfjkeN9vo?=
 =?us-ascii?Q?geqZ5l+40Ar4ukrfiTCGwL/re4QuI5mD8D42+M34My/xOnvuSSLaM+3eM/D+?=
 =?us-ascii?Q?ykMfAh20zGjUoeQPL2PyWJOi/a17gvMAvuoTq0hBXVH+h4W0v0RaU0mCttWU?=
 =?us-ascii?Q?uzkt7rkV/0lwGqoJWuxqoeMtLJBdiVb9GxG4b+MYFyFXj4zSgMjz1MsQYK9z?=
 =?us-ascii?Q?iLXYwFkbcWIu40rj0OlRMWbQ9ZQq6jm9hqc5Gmw9MMwTi+yRjeOGjqYgvzEr?=
 =?us-ascii?Q?38B8O1VZVYieXpCwrVIwUFGX9p+QpYUCbWA6xb3uT5aTIf6pWl0o5JEuIGRN?=
 =?us-ascii?Q?UXN0VQx9scMT7ip1UK8d1if76iYQaEscnSkBVAMqufRa9IOUad/rrqw1vQ9I?=
 =?us-ascii?Q?p5/rStmtTv9ELHPRC4eaZB80hCSrMb7DDGcc7DE4bw+V+OZIz+lYU46bHoYQ?=
 =?us-ascii?Q?kwgSjcZIZU8FWO05mTSdNdCcCHsOJX+lqrh0mhwneEFnJQ8MQ4q4qlyrrvWY?=
 =?us-ascii?Q?6Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ff51b1cc-b806-4d8d-3e7b-08dd65578e2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 13:28:07.8203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pz+bheiFbR84bZ4HqRTvZzfa+6q5K9gm8BYPK5PBjy0rc5PDXWCIaL6ZojgUZnVWZqxlW/PBr8L7oOx3nyyMEXchvh/cFaBY04YY6kEwPMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6676
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Martyna Szapar-Mudlaw
> Sent: Tuesday, March 4, 2025 12:09 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Glaza, Jan <jan.glaza@intel.com>; Jagielski, =
Jedrzej
> <jedrzej.jagielski@intel.com>; Simon Horman <horms@kernel.org>; Martyna
> Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
> Subject: [Intel-wired-lan] [iwl-net v3 3/5] ice: validate queue quanta pa=
rameters
> to prevent OOB access
>=20
> From: Jan Glaza <jan.glaza@intel.com>
>=20
> Add queue wraparound prevention in quanta configuration.
> Ensure end_qid does not overflow by validating start_qid and num_queues.
>=20
> Fixes: 015307754a19 ("ice: Support VF queue rate limit and quanta size
> configuration")
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Jan Glaza <jan.glaza@intel.com>
> Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-
> mudlaw@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> index 343f2b4b0dc5..adb1bf12542f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> @@ -1903,13 +1903,21 @@ static int ice_vc_cfg_q_bw(struct ice_vf *vf, u8

Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



