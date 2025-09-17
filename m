Return-Path: <netdev+bounces-223979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 689D4B7C709
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4446F325A3E
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 11:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AB32F6561;
	Wed, 17 Sep 2025 11:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hq3tlXFX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E066929BD91
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 11:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758108291; cv=fail; b=PdWvDPpb7SSsHxond9dHZVPDfqhbjXwgQeX0VeHuu1aD0wSaiM4av2AnCHJLBquq/onSEItapN4U47+b+eSJ9UcAr0WUGEvUH9LXNwGimJjsDUnxO5lDg/0D64Ce/HTXAHF7ZMvJ4JssHbD6zwghho9oKbJiySKIIV+a7W7LmGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758108291; c=relaxed/simple;
	bh=PF0UpOv+6eYIoKpVZB90iv24nljk+MXwqa9ihHl4INU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ulck8K9xQXcXFh3PhCbuz4gUwPagZgbWVF0KhxSiANqRz4AX52IautpHv8aC3/ZJyz9cqrIqjBf45cXOhkJO1naD2hwmLtz1dBtSE+a82NZUFGSYVL6KZFARr9GqFjg9aLlAkvx9jcCdoAPadwRHEWD0XKNnq3vMhNSF3RZ5dEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hq3tlXFX; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758108290; x=1789644290;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PF0UpOv+6eYIoKpVZB90iv24nljk+MXwqa9ihHl4INU=;
  b=Hq3tlXFXKU8ERB7H9xC/5d02FlbhkUwt4V9T67vYEWKHuqZbI7LggFuG
   HxgTIl9rxPY9JSymj2u3m5IMjoxJ1/6Y7CIQ63NfqGx9e9rffxGZYI0gu
   UsKOrjNOvB33y/F8NhZH9WClfdx1/8JTvZyzEazT3hd+UP0JQsDoTr2jm
   vpUWLqnDbRB9+FC44n+pG+TBqFY5+uZ8q91hlLug9puaxaWrCIXqkdgg1
   SP1pp7EsJYtME6zitDBEvo4iTm5C2qK+oko/DldrNZAzXlTaUFUjUZ+3Q
   UDS5mzE435VLgBLRK36SwGoRs9bctwQDv7v03YzLR9S26s5fseam8NynA
   Q==;
X-CSE-ConnectionGUID: Mli9z7HjTPqljQtEyDHQbA==
X-CSE-MsgGUID: RMSM9U8xRzGHx3ZCElmoWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="59630433"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="59630433"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 04:24:49 -0700
X-CSE-ConnectionGUID: Phc8hAf6SWCgoskT0am+PQ==
X-CSE-MsgGUID: mYkvON6zTp+TiXtT8nIXfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="212369248"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 04:24:49 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 04:24:48 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 17 Sep 2025 04:24:48 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.24) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 04:24:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sK89U/6wjC04v/qFodptLjIRvmDDK6JNYZNYS6d39j+fmIQYVT/2ZTplZHzhOE82L8j+nBnT38LicBCOvPHMWKa2NjdGKrEbrIDie3hUufjHm9Onlh5c7XlgvOE6zCuNwpX100nXTgLzWCpCB9n+aBip5h7mCA5zpvcAKy1fEZZT2sruKW2hJYkl9H/y2CX9yU+YN5OcYMpgM4H9vO7H06K8OtuE1BNcb8jsHkSD0w1E1EC6QtWeVLzUjnQqn5MzNveMnS41FK0tL+ysPjjjxegHdI4p32T9vLyV+gsUZeJt8xK1NXbznUFruclo1WVqFUi0uTXoFRlEYG9D7vMpag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IitjIEfvXD4Pua+WTmmTpUstTpSlOP9gg7iVb0LJ8cE=;
 b=r1vm06NdV8YEu8KNPcOsdKbwLDYD4GWb8Y+JzmQMzYjMDznhcxz41FOJEdLrCdsMaaI3htEbgRlYQJx2vt2iPwnlWJP3NGViRiBt2Rhuotdj4CHkJnG+fFRJUgM0J1D8hLmY7ntKTNFkie2vt8LacE31zL7IS91Ji4wVy4v6PXauHdO8q19s+1EgrCyhtQ5Sh6Oug72FnN+Z6AZ8giqyEu+0wezfGJd3xzLtWZWoxZWKsAPq1nbGOcU/T7TW1mCPivQvhQHQGVuJypdCFe/ibOIoTQs2w8Y0pltRafpt4p6DzWKKM42skpVa5qG7RjSxupwh8nCHjJ12pj3QtNtomA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ0PR11MB4845.namprd11.prod.outlook.com (2603:10b6:a03:2d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 11:24:43 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9115.020; Wed, 17 Sep 2025
 11:24:43 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jakub Kicinski
	<kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Michael Chan
	<michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, Donald
 Hunter <donald.hunter@gmail.com>, Carolina Jubran <cjubran@nvidia.com>
CC: Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Yael Chemla
	<ychemla@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: RE: [Intel-wired-lan] [PATCH net-next v3 4/4] net/mlx5e: Report
 RS-FEC histogram statistics via ethtool
Thread-Topic: [Intel-wired-lan] [PATCH net-next v3 4/4] net/mlx5e: Report
 RS-FEC histogram statistics via ethtool
Thread-Index: AQHcJz8niYVWbktAMUeBMIVFmjCp6LSXPMSw
Date: Wed, 17 Sep 2025 11:24:43 +0000
Message-ID: <IA3PR11MB8986892A39A86709F55EA379E517A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250916191257.13343-1-vadim.fedorenko@linux.dev>
 <20250916191257.13343-5-vadim.fedorenko@linux.dev>
In-Reply-To: <20250916191257.13343-5-vadim.fedorenko@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ0PR11MB4845:EE_
x-ms-office365-filtering-correlation-id: 60797063-6269-4da5-fb5e-08ddf5dccc97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014|921020|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?ACLH/yk4SUyptxSoo9H//jNnFlhNaRFpth4mMWoK5tzk+6tMJrvKcQ1gYfVT?=
 =?us-ascii?Q?Pdq4xhkFxwlM99LUi1q3Vyuk9n/0RIQomuje/VhwGKvwcB+QeMRPNWwcPop+?=
 =?us-ascii?Q?QZXEqS+DNEx/CcB3qnk+lT2bwkxwEGHS506bZxJd7U7NLglVntNx+/AKM57c?=
 =?us-ascii?Q?0/xByDIQlrUlIgAgx/QuN+TlDICcRf8jS7IV5KWFq9J5Y+e/Y/Qthq9IEVSZ?=
 =?us-ascii?Q?RJVfTzy+Tc007Bq/Zq6UcJgguW7GZP04ZflXoIsd3Hr0d3m56e7+DFsG2xuv?=
 =?us-ascii?Q?R6KIJJWGDTjn9ifpZ7VtJ90WQEw0J1HHv1bFfA4qOipBnBRSXtG6DGxGw9h/?=
 =?us-ascii?Q?h6MtR6j0Ci11VE2w6HgOy0q7GiVhG2BL6GhqTepi4Nn8XutVwQ9yYY2jov/G?=
 =?us-ascii?Q?lw2vQy08jD5ObXe3V0FSzATxEQTbG/u0sMsWF+DtLEt4aVAzf2IFDVu8guZg?=
 =?us-ascii?Q?OOf92A657tJQnkrG0UAiv2DfNBP2CakhAzl03VtkxONk3+O/95DMmU2q69v4?=
 =?us-ascii?Q?kyk/P8ZAtwyoH480XUNemB96JFRZN1qxbLb0DLXqdod2q0p9UcwDXgR9BCjE?=
 =?us-ascii?Q?wc5fThpiSFbi9l1hGJKV/wR62ziAYQkTeMcGOCv6iiBkL60nTwv3ZMXykPq4?=
 =?us-ascii?Q?iH2OIvxy8GGxaJVfMI8KeXZLYg1bLx0XHHV9xxeNhdl7GSenjpTi4YNQmrRU?=
 =?us-ascii?Q?T6tLBLaYuzd2TFvuA1IvpQzBbr1Gtiy+dGu9YyGJGkIg4sGjZTDPbqs/R7Pg?=
 =?us-ascii?Q?7GmF49GvNKmVY7dTiPnccQe/XdM/WIdU7GvdPqxx9ZzyuZTXMADAXSUjZ5AS?=
 =?us-ascii?Q?9J57geu5SccqSfMza0bS4oUf5tnjQD0vZjBltmUV6tBw+37qk562IPXMw3EO?=
 =?us-ascii?Q?vvrUxkCTEGLDwwHHVyNV47iPN6Z6K6NrEteBos9e49fnXjsU2ZHWjqeN8i3B?=
 =?us-ascii?Q?ipTOiWLvA/jhTNurrl7deJJ0p1CwWoT6reEwq7Nwo3F6eUu85fne5unJkwtQ?=
 =?us-ascii?Q?bUhmnf4s0DY5cJmDtoTe2nl+sBndkwv4Lnva2aWSt7K/hSvCtoPito2By8DO?=
 =?us-ascii?Q?ICkCDBCXd07K35fixMVA6UiGIX01ujgL5mujZEmtbUkDz/JJSx+vQpVS1Oxq?=
 =?us-ascii?Q?ZdQVctiOMP9txxMr7DhXgx57l5JoM05Ysogfap04SPIT0kj/F1VE9WfZm/E8?=
 =?us-ascii?Q?5eBc+apaPg5kadgAZB9h5ed2bA8OUbIWdRvMjrVp3QC/Fe6BcOKyGtEiolqA?=
 =?us-ascii?Q?Dn5HHh5dKgbOg5H+Kad54Y8bfW3rHTfj27INI4SilLrNXSVz/IR4zoq5f8NE?=
 =?us-ascii?Q?U8Y6oYv6Dq1qZJzyl6lDWhFEyPUytKK3mdPoAZ/9/hLjOMfjqetLruCeP404?=
 =?us-ascii?Q?vlxX1kxU9bSUBL8s1cDpiYnweF+igtODU65sjQAEfs9OJQAhKGMzM4wlUTw+?=
 =?us-ascii?Q?nhvmGh/dfG+KgowLMyPfAHRenrYDKHunfUURslFUkTFWNLb3yEGPbAw8Uu/i?=
 =?us-ascii?Q?qr1MGrUXaIkUctQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Sw3G/XCWRCDJPmADJDGGO+T7UeZLEvFU8paeQG8/n2NzhxLEOE7EHqVdPFTg?=
 =?us-ascii?Q?Sgyc/9SFMJDaMqSfQ18DSoWRGgu+Bz+Z6SUDe+jVNLk6hq5hBtsx5y3EAljr?=
 =?us-ascii?Q?WJ73EWW0qLuca5R7JrPcg9VDfmqI56WAAybOrbYH5ck1IAt+3QXrL/Vn+Uja?=
 =?us-ascii?Q?Cm/BVdxJUIVppicyjXiSOUtuEcWR3qZTsuLSm5U9SOt4ckjlGRYuRb61w5pe?=
 =?us-ascii?Q?n2ymdEftXjiiAA93Dj75VmvQ6j9IqwORkHuDSgEcshOpUbzs3jgHJwLWdipZ?=
 =?us-ascii?Q?MwgdnrV6nbMWFJ4lrTEeM+sPrE8n73702+ZtDqQRaOn2W9U1NUBzZOzq1JpV?=
 =?us-ascii?Q?lG6XKvhM+sD4cB0M7QqmuScI5dhRIBJbTSxFSKAs1cZvfOrOWMEOjJT3ZQSr?=
 =?us-ascii?Q?xeJ2ZiF7DtUUvogSaPvaqh6P62EEe5EoDqTkKrgOJxqnklirctL3kME0LmJd?=
 =?us-ascii?Q?gTbqbXWn7HJe+rRFoWFESO/dq7WXSyK01YVN2x9tvmWmJkwxhMsTIUaM3llp?=
 =?us-ascii?Q?prcsb9G5JGJJzngwHICgz0aRPZqPh5WV8wOAnrBbb4BMYQTmCbdgZ0ZYtoaS?=
 =?us-ascii?Q?5fUDt6hHgdPLHLBMy0MVQVMo+y6I89xwaLRawmh5QH4cWiU0D5haP8UHUN8u?=
 =?us-ascii?Q?lpXzzN13GYf2mBmubaYwry0dOEllisrwA957wAaf8OBUE9jOaZt7ztsatuwl?=
 =?us-ascii?Q?FglXxJN9ynDwP6sJGrygacnoaquRNgN+ZPpJ46ukeB2+aTyBJo2BrP8Dhia4?=
 =?us-ascii?Q?x3p2vV+fQnVe0lZl51tEkRnbHHv3NdeJ8U4Fjtat5a7xWVfICcsDJBzpb1DE?=
 =?us-ascii?Q?AxxkXUhjjQK2RAGmCVGvi3cqvmKA90emwBgmv6U4wP0TJq4cpZOwiO6sxX+i?=
 =?us-ascii?Q?C3KBgI1cUukrvvroEG+tY37gd0vjxuT2HZuaxmTh8MT6RopWap9TDqbr6QTJ?=
 =?us-ascii?Q?Vu6nsgQHI1G+CPxDRO5CZuRzxLiTay4/A+4TD5dCBPdz5p0oVvPxKEtNJDju?=
 =?us-ascii?Q?lAZ5ILlO55nqc+h1mGCi1a9JiZh1cLkrldcZtxQ3+z8ZWBwoHswmhpesDlCc?=
 =?us-ascii?Q?fKQdXuQjl8qknEhHRdSqlaz8TZxLnkzrf71qvswU1h4S49UHgirtr6bAbjyB?=
 =?us-ascii?Q?DISCNlGrtsFHSznAydRWTKvcY6/5je1VBU9hhC9X3NxgW7ZB5HES4ATWJul0?=
 =?us-ascii?Q?zTlsoXn8y/ZfpOXhWPALOqx+xcXaHWst1GP9efgpW3PIz6s1MZStKniY38bR?=
 =?us-ascii?Q?p65HNsbtJgrVTTk4C14ITn6TjVR/5L/6gdbQWdnSPJnI26jWbFT+a0QktCxv?=
 =?us-ascii?Q?r1pPoWpSrTB1BGdq0kbhrdZ40n95ZmQyRPsXflyggUdPNjllEWLD18CNZXhj?=
 =?us-ascii?Q?DDDm7uq9kUFtszYfQLU4jEXOP+2EAwQzLoV8a9hYVXJzH/PVOfNPGFOWjYLR?=
 =?us-ascii?Q?rN7eZa+YV02aNMJcueAF4HxhvlJM+BKFnVjokuB6ox6FQ4JM3JnssfOumS7F?=
 =?us-ascii?Q?5SZoZRJMHHdd9w/+6EacwFQZw9PSfLcH8zr7kHwkCgdP+MZ5UW7CDJ3xvyWq?=
 =?us-ascii?Q?rv2wjfaw4/HZ7M+wxbv4Yb4eSbI/YUXoZyRBb4e1Hda8bfhWcejT/9stnGKI?=
 =?us-ascii?Q?uA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 60797063-6269-4da5-fb5e-08ddf5dccc97
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 11:24:43.0530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cAp/IeR+toExxUDu1SmLlm4AJ3qPTxK6zw2E/g8wBdOSU4/MdknUGuK4wItgCY+BPYAQongGdDb8rIZRMYj89OotBo+DMW/6F8TIiS1stdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4845
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Vadim Fedorenko
> Sent: Tuesday, September 16, 2025 9:13 PM
> To: Jakub Kicinski <kuba@kernel.org>; Andrew Lunn <andrew@lunn.ch>;
> Michael Chan <michael.chan@broadcom.com>; Pavan Chebbi
> <pavan.chebbi@broadcom.com>; Tariq Toukan <tariqt@nvidia.com>; Gal
> Pressman <gal@nvidia.com>; intel-wired-lan@lists.osuosl.org; Donald
> Hunter <donald.hunter@gmail.com>; Carolina Jubran
> <cjubran@nvidia.com>; Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Cc: Paolo Abeni <pabeni@redhat.com>; Simon Horman <horms@kernel.org>;
> netdev@vger.kernel.org; Yael Chemla <ychemla@nvidia.com>; Dragos
> Tatulea <dtatulea@nvidia.com>
> Subject: [Intel-wired-lan] [PATCH net-next v3 4/4] net/mlx5e: Report
> RS-FEC histogram statistics via ethtool
>=20
> From: Carolina Jubran <cjubran@nvidia.com>
>=20
> Add support for reporting RS-FEC histogram counters by reading them
> from the RS_FEC_HISTOGRAM_GROUP in the PPCNT register.
>=20
> Co-developed-by: Yael Chemla <ychemla@nvidia.com>
> Signed-off-by: Yael Chemla <ychemla@nvidia.com>
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Yael Chemla <ychemla@nvidia.com>
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
>  .../ethernet/mellanox/mlx5/core/en_stats.c    | 33
> ++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
> b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
> index 476689cb0c1f..1da439dda323 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
> @@ -1529,15 +1529,46 @@ fec_rs_histogram_fill_ranges(struct mlx5e_priv
> *priv,
>  	return num_of_bins;
>  }
>=20
> +static void fec_rs_histogram_fill_stats(struct mlx5e_priv *priv,
> +					u8 num_of_bins,
> +					struct ethtool_fec_hist *hist)
> +{
> +	struct mlx5_core_dev *mdev =3D priv->mdev;
> +	u32 out[MLX5_ST_SZ_DW(ppcnt_reg)] =3D {0};
> +	u32 in[MLX5_ST_SZ_DW(ppcnt_reg)] =3D {0};
> +	int sz =3D MLX5_ST_SZ_BYTES(ppcnt_reg);
> +	void *rs_histogram_cntrs;
> +
> +	MLX5_SET(ppcnt_reg, in, local_port, 1);
> +	MLX5_SET(ppcnt_reg, in, grp, MLX5_RS_FEC_HISTOGRAM_GROUP);
> +	if (mlx5_core_access_reg(mdev, in, sz, out, sz, MLX5_REG_PPCNT,
> 0, 0))
> +		return;
> +
> +	rs_histogram_cntrs =3D MLX5_ADDR_OF(ppcnt_reg, out,
> +					  counter_set.rs_histogram_cntrs);
> +	/* Guaranteed that num_of_bins is less than
> MLX5E_FEC_RS_HIST_MAX
> +	 * by fec_rs_histogram_fill_ranges().
> +	 */
> +	for (int i =3D 0; i < num_of_bins; i++) {
> +		hist->values[i].bin_value =3D
> MLX5_GET64(rs_histogram_cntrs,
> +						       rs_histogram_cntrs,
> +						       hist[i]);
> +	}
> +}
> +
>  static void fec_set_histograms_stats(struct mlx5e_priv *priv, int
> mode,
>  				     struct ethtool_fec_hist *hist)  {
> +	u8 num_of_bins;
> +
>  	switch (mode) {
>  	case MLX5E_FEC_RS_528_514:
>  	case MLX5E_FEC_RS_544_514:
>  	case MLX5E_FEC_LLRS_272_257_1:
>  	case MLX5E_FEC_RS_544_514_INTERLEAVED_QUAD:
> -		fec_rs_histogram_fill_ranges(priv, &hist->ranges);
> +		num_of_bins =3D fec_rs_histogram_fill_ranges(priv, &hist-
> >ranges);
> +		if (num_of_bins)
> +			fec_rs_histogram_fill_stats(priv, num_of_bins,
> hist);
>  		break;
>  	default:
>  		return;
> --
> 2.47.3


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


