Return-Path: <netdev+bounces-259516-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHjpFFM/l2lXwAIAu9opvQ
	(envelope-from <netdev+bounces-259516-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 17:50:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA70160CA6
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 17:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B22433006088
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 16:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1ED63271E8;
	Thu, 19 Feb 2026 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IyrGJnw5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF49329B8D0;
	Thu, 19 Feb 2026 16:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771519821; cv=fail; b=Tr3GZG6xuQI+FL4EmziSCgD57uUnLt2YhxjCg1mBNJMBsMdflKimhWVgT8wmF9l90pAWgcyrlC1nLkhguZfq+SNp/iDMYN2LVmzT76XJBlnRJLfddA8/Wa5qdrYe9tXV4agJC7rkGX11/OLagKLl+5mOZtIYfmyVzf0zrnc8r9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771519821; c=relaxed/simple;
	bh=sDpHtEB2ET+ZgKwdfUwTmhG6uvft14bD9BhumnVJNjU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CoCWjL29SABg/bJ5/FqrvCKsgIHX8UAC0eb9+m7Ih28D6+AF7zQq8zbbMjZ99eynofRFfA4E9BKBJjf5TT5VV+m8PLnY/pftEdKs9U2aPyQ1y6rxSy1sXgEN4LB8SicIOEqstCijw33JIcBU6BXb9gJ2X94WkCRLdk7o5nMOPak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IyrGJnw5; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771519819; x=1803055819;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sDpHtEB2ET+ZgKwdfUwTmhG6uvft14bD9BhumnVJNjU=;
  b=IyrGJnw5yCKcOudw3CBkycthbq/F2i+oYeopbrxJKiu10hwusuYhSWwn
   HnXyIUQcry/7vJmOJtRqloCKF50gPB9kWCuX7ASMKb8taXcvifDnwzAQp
   X8dQvUayxHEeymF1NveERRZjrBXU/4R9p1CKaMWcP/ihULN1H+DVUgoNa
   2SHBQQBoQm/bq5q7tJ7tOdSJq4iMpewSGEfOlltiPmgjt77IKUJkR+4Fj
   kph+5BGYNN6NLX/vA5XAGa+kS7sAmV2WuiDXa53LPRVIDlCLMX+tZSMO4
   SfT4OPE5Fqw11DIVTAwvmj2IiWa4rSPMgbpacZItvrPtP6g+mf4h2e8gk
   A==;
X-CSE-ConnectionGUID: X6eGraTiRjiTHZQZifRoIQ==
X-CSE-MsgGUID: WE30DB7fQLeYWmYl+DhtYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="83234485"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="83234485"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 08:50:18 -0800
X-CSE-ConnectionGUID: Ul63gXB5TZCWQmUkjfo5Bg==
X-CSE-MsgGUID: oS6B0N5SReSAEgLplmR+pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="218333595"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 08:50:18 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 19 Feb 2026 08:50:17 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 19 Feb 2026 08:50:17 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.38) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 19 Feb 2026 08:50:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRZfYWd0ioPSbfJjt932AV2IPNk2Rx6hDY+xhyliu1UcSNqt5AOBkBRhR8OIKqzwCOsf+eN01GJaoH+IGDwknAWustsJboGr2/kxNKmd2iQz2Ve2n50SSk0kTnTlvewOhX35PtJZUuW2Dv4dp7T1TNA0wFj6vBWPAx1TLnBY9WFAvCmazmzn5id1yP1DhQIBP0OGQ4c4XyE+aKbDDC2X4Hm6GVp1U8v85wOHytwm1Fvd4Cl/PjHkakRLnb8CjCo+qf0vmESiOQrYblOEZwUXoH/1RAZg0aoqfXAUc/yHOc8n/xbDmQkdFC+zSHjnEDURd5qo4WSQKRND/ZtVFM4vBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUc4xjUfhkBFrPOQeU0hCYo/gnxl0V9zR0kihuGznkQ=;
 b=x15Tad78a7c8WA0T4POxQuB2Qpp6ZVFFZP355xzJ61+nT9tGrdoxhtEan/gUlIBsM0fioqf/BHDn59b3FskkUnaQ3beC9+z/Imr5LA+lZl4A2Cz3+n+OIbctY1MQMsIC0G0wYAECClS+k3o//5AngQGsqEyH76X4m7Klp4ZIxj+nkyFCIBbJQZ4qDXRrzE5NlJ62aeS6PQhJSnX9C9uTOrAaB4cAYQ8c2gQzqWXu8RvBEOQnGrPfuEUce2MMAdOf/TXjCLvmmXVJpfAysUb2W/pEnEfzJLKAvSCTEuqu7ljHOyVu2kb2zRrklWywuMSbhUpG6SctqH8fCftjgXyO/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 CH3PR11MB8444.namprd11.prod.outlook.com (2603:10b6:610:1ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Thu, 19 Feb
 2026 16:50:13 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 16:50:12 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Gabriel Goller <g.goller@proxmox.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] docs: net: document neigh gc_interval and
 gc_stale_time sysctls
Thread-Topic: [PATCH net-next] docs: net: document neigh gc_interval and
 gc_stale_time sysctls
Thread-Index: AQHcob0xQr50MBpPKkaxHqtPC7p0u7WKPBZA
Date: Thu, 19 Feb 2026 16:50:12 +0000
Message-ID: <DS0PR11MB7579D48BF1295AF8D783BF0AD66BA@DS0PR11MB7579.namprd11.prod.outlook.com>
References: <20260219162200.510325-1-g.goller@proxmox.com>
In-Reply-To: <20260219162200.510325-1-g.goller@proxmox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7579:EE_|CH3PR11MB8444:EE_
x-ms-office365-filtering-correlation-id: bb2f7a31-ff0e-4359-4944-08de6fd6f312
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?HFSHkL6Ua+3bEzWHoE1d6xmaBHHfrEeSYTWhsF8tk7O666T6wUxfCE7cbmoh?=
 =?us-ascii?Q?+oMEG1i6S7kHgcxPZLA8tUGD3dXg+Ted4EBy1DWPH8rOvWKqVkxfJW581gZt?=
 =?us-ascii?Q?QkmMwtVL9oBMDsfJ08bEmQoIEmeA2eILiBnF0QUA6bJN/rEduBjfQmjia2ia?=
 =?us-ascii?Q?QA/iM+XWbbOR4PTgJLxgHUmm9yvPcekWUNM3+XGom+I48qDDXesmmNHYfAIb?=
 =?us-ascii?Q?3bARU5OwkpTq0NzRTjaRKfmNyMr5k+oVI+oY1qe+iw8PfmmpuTXFOqEjS3n7?=
 =?us-ascii?Q?FOBHPJ4N8rLJfd5oKSjeJeXFoUn2b5d+sohE6vcISntYsZGKNHLGQVvdBDbm?=
 =?us-ascii?Q?iPx/FAviLtsniuhoiwCGRR+lSNIbOfZOXvqa2BZxM7cD7CmvA6cUM8p2wU+Q?=
 =?us-ascii?Q?KRDuVsDirdJ/LhJHxeBM24sPaFjoa/UAOQm87x1ImGTx34Rzr5GGl/aUzDGO?=
 =?us-ascii?Q?GAMW4GZ5qAcVYO/C87Af1/GQ4zeBTrmsfudysK8HHQ14WLY0tPX+Jt/rCyGF?=
 =?us-ascii?Q?NjxTGUAiYVy1Mv6e11S/Ntym+cgZm031W4dIXIaaIfBAJvZEYzDabbBYen5u?=
 =?us-ascii?Q?i0McAlYT9EBsrguXbQ7mvVSGYps9z0FxFX5RpAiRoEXZgb5AqT2tncA1fb1K?=
 =?us-ascii?Q?hzL8p+4bkqmIfyQD4Y716KJOKbka8hYFxzQgeooaVDz3GmZ1fUEkwTk0c2Go?=
 =?us-ascii?Q?CSmaBfk5HFmJcj1Lg9VxFNIfM+7uMl37ZiKXpQeuIJ0whKBqFRyT5ktbOOHT?=
 =?us-ascii?Q?37ZZa3LT0R9+SpbmFQiY3wzuTsgsVRCMVz7x1syRI+lBiihrTug+io5Yhu06?=
 =?us-ascii?Q?A2v+ZjA4Xg7jofHV3JAsXHZW6VAqMRMwSZApJ4nNsLQ6gVxpxORxZyQpdp/L?=
 =?us-ascii?Q?bYUpAtc5r7HOiDYgKhBZYc0/hyLH2v2wLaGVJxTNHH25EZFfuyzFNzlpjQoG?=
 =?us-ascii?Q?2Rq9unIK1aPKPteQo3YOK0g0GWHhyt2Ckd+JeTEIlmpB5QQXbtzTstTgTJ9M?=
 =?us-ascii?Q?KmCIMDm5M5Ot1XnX2sHmWbaGEdHpnuQRdCgSR2We9Ow2XESLK0JoGcIBIgbf?=
 =?us-ascii?Q?hY1mvDT5SOOiH4UiFqTb3Bs8ZeWoc19kmQMMLOEWo/Q9XbjGHU80ZpMHpWrv?=
 =?us-ascii?Q?noIj4OZunKrFC9g/KMzmb5X+WGP3vz3PEjynogfnelfbWTYGOUqPA8q/F1O2?=
 =?us-ascii?Q?qKRy2aj/6nn8bQU3slQ/0KZ5pB7EmOOVdam2UX3LI2ubLVvEZ7Vc3+Jh9hFK?=
 =?us-ascii?Q?dFVVzw5ruapXh75I0ZO6drI1twwZlfMndCzrtICXnqayK2QBiKe9667J5otR?=
 =?us-ascii?Q?qlrjKYvDS+hBC2hDARU6rieyO7LtZQRvHOEF+Er4+aEoiNuM5BTMH1GqFDGI?=
 =?us-ascii?Q?FnG1++8G6ctmTAMIC8kh+t4oXSXt66ymNgk3y6gAl21NCMobcWienATS9g8f?=
 =?us-ascii?Q?wVL8kLcMR4IZk4uQPv4CVoJtH1s7HcNsYr8duRFrNS1BOVNBxsJL5OtI/VPE?=
 =?us-ascii?Q?AWX4TTsCIStraOitlczZR9TjIlUD5nZHdnF61VEggSvjTYF0D/eMK6+5xvaw?=
 =?us-ascii?Q?bJBadZLG1gtCiJAh5q1FPdKxk6x++GqHSSpVvw0jhmnGR84RCPZtlExlnZ+l?=
 =?us-ascii?Q?WDx2rwxiLoi0gTIsOZ7P/HA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bJv/VcbhGOcTA5C8sU1aSJHDrtjcH9hmaE8vbjIhyLblqJudin0hZjdAXbDg?=
 =?us-ascii?Q?4hBfqXlWLhmMsI1ibDEItaAR5Acfh/MuiXd7eSEOcDpiXhZWn1ZAIWqdoXN9?=
 =?us-ascii?Q?QCQkanqUF16OlvrWyWQ+FyWha2WRu8QeayRS/U/FJQspbBB9CUSjnprjEgZU?=
 =?us-ascii?Q?3huYOZwDw6Dig57jfqNLuoyCtZZNAJTmDPySt3MF8EkngkG46JS6Frc28hQl?=
 =?us-ascii?Q?jiFj6e0gb0/HcmBBpnp6LYK+PWkCD7709C6dfui/V3oxOmkRJdkCEyNzCSFO?=
 =?us-ascii?Q?As/7tVzoQCTpRYIaPJmygZ8uUQ8aoi39NvqCiFmxpaMQCinYUMwcIyp8KvGB?=
 =?us-ascii?Q?gXAssQApsweTC2VOS4Py7qj7fZYDKqIUvlcBbwUPlqxvpXLMMcgyHo9BYGLV?=
 =?us-ascii?Q?wT46GH+htA+5LAchiZiQhRTL9GLccM02Br/d0HBU/ZM4J7vIASnVB7CaqFnr?=
 =?us-ascii?Q?rLuXeAQAthJZjkcg1k4IfLrOEBljdXGQ6H9jYY7DEZkoncbjtapGEeTz9q/k?=
 =?us-ascii?Q?dLEZcgf4N/pK96OT8gxrrmjYTbSxICAvsyYHpyKrq5BQBf8gFVMmRK8ICw9a?=
 =?us-ascii?Q?+mmYS4i3RGsFUhhWA7484uouhuNbElFkz0MKsildxkpcJEaMjH2pXJWzydOJ?=
 =?us-ascii?Q?ces4tWlJSL8BenswTUNfKEboNPAj6E/r0ZjKAo6R7lzxnLMm9C16XQWLEtn4?=
 =?us-ascii?Q?0f7u4zM4VWjbswiH3M5Wq8mRwrIrsYOt+qUhIqRka3cHFrmKD+KQ9FIloKyX?=
 =?us-ascii?Q?DyAmV25NgMcrOsWpDzvRbZCSW0RH9xFkhLi/VV1m2MrmWKoqzpvhFTaahc5U?=
 =?us-ascii?Q?EIf3hOJKr5T/pfuwG8uZa5CiiSX9/OCtBBfqqrU28XgP0zax6Bugvo10fuAh?=
 =?us-ascii?Q?Tv/7AbWuQXF3bV6Mz9dGV/8qUbhB3NbrOVkcajal+L+005QHyen0ZJP9f18X?=
 =?us-ascii?Q?r35j7Ex8mlEo5kFI2xKNmGAAQHKLJV9dNAZNtdbwJqw05va4hy+wJEz3zzS7?=
 =?us-ascii?Q?WH8x2My0vrXIR0I9OTFMMggrTz6+CKOB9peGjtDXTr1Wx9tDteXp054U318q?=
 =?us-ascii?Q?bYGsfIjlFg0vcm4Nt10xu3+mx57YM3yzeRcsYNSqQ4OUOUD1/2JXPIxh6NTs?=
 =?us-ascii?Q?LpfpM5BKr7RP5plHvGizUFKZ18xMRzqv7IavO3he6SkSzcJqAwH24f6h2pgG?=
 =?us-ascii?Q?hnWH2i7SHpM/nq00y5yNcLfWfW9Dov2reiSiw32RmPzZq1r2CasOIAL9x1hn?=
 =?us-ascii?Q?13lqN0iXsLW9OMN9ZqpQG4ACjudUXbputRz32vDYG2sMLyOXCPTVC5O78BAj?=
 =?us-ascii?Q?AioTxof6BytYSEsEvNcX6RY5ywxvHSMgAgZtZLYPSndtl7MpudVdN1Bkv9As?=
 =?us-ascii?Q?0OI8y/0K/vFp4P+A0eRnFPQ0+E3X8+DkL7azBOY6MbK1XP3tJXs9z3LWjWtA?=
 =?us-ascii?Q?KbrlKy+WC8gnpl3pMBxjKB5PpAnnI84tmS8uIm8g8/7oqE7j5UbIkZA6dLiy?=
 =?us-ascii?Q?1eCx+Ld5gboC4Euw0NcGy+m8o2DVD9d1SgUIznJWvyd4xKEi3triJCoaEeZK?=
 =?us-ascii?Q?irVFtm4UeT0gpIbN4Gi0yh/nVqeiIy6t7LKi9fGCUvfySz11nLtYQ0d1Nw82?=
 =?us-ascii?Q?vodGgK3abtVskrye5GHtcQqoahnsUIgg1N9chiFCBBGjWi30lli3izns6D+c?=
 =?us-ascii?Q?JKT9madnFLFwb4yszz5a2RpU+8qu3IDkrkPuldyCrwdCNKz8WyL1Re+pcT3T?=
 =?us-ascii?Q?Ri1o8zOCJA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2f7a31-ff0e-4359-4944-08de6fd6f312
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2026 16:50:12.4565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hGfxQnf5Ooaqx3Rk39QFQtXojRZRerQqa5rrNRAd6MKvyZUo32amCRhDj2q6Y7kn2gd+XwxybU3prcIUj4T6WuoW8FdFyLYbR/TzF/hURbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8444
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259516-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,proxmox.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 6DA70160CA6
X-Rspamd-Action: no action



> -----Original Message-----
> From: Gabriel Goller <g.goller@proxmox.com>
> Sent: Thursday, February 19, 2026 8:22 AM
> To: David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Jonathan
> Corbet <corbet@lwn.net>; Shuah Khan <skhan@linuxfoundation.org>
> Cc: netdev@vger.kernel.org; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH net-next] docs: net: document neigh gc_interval and
> gc_stale_time sysctls
>=20
> Add missing documentation for two neighbor table garbage collector
> sysctl parameters in ip-sysctl.rst:
>=20
>  * neigh/default/gc_interval: controls how often the garbage collector
>    runs for neighbor entries (default: 30 seconds)
>  * neigh/default/gc_stale_time: controls how long an unused neighbor
>    entry is kept before becoming eligible for garbage collection
>    (default: 60 seconds)
>=20
> Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
> ---

Reviewed-by: Jacob Keller <Jacob.e.keller@intel.com>

>  Documentation/networking/ip-sysctl.rst | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/Documentation/networking/ip-sysctl.rst
> b/Documentation/networking/ip-sysctl.rst
> index 28c7e4f5ecf9..033e18303d79 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -202,6 +202,21 @@ neigh/default/gc_thresh3 - INTEGER
>=20
>  	Default: 1024
>=20
> +neigh/default/gc_interval - INTEGER
> +	How often the garbage collector for neighbor entries should run. This
> +	value applies to the entire table, not individual entries.
> +
> +	Default: 30 seconds
> +
> +neigh/default/gc_stale_time - INTEGER
> +	Determines how long a neighbor entry can remain unused before it is
> +	considered stale and eligible for garbage collection. Entries that have
> +	not been used for longer than this time will be removed by the
> garbage
> +	collector, unless they have active references, are marked as
> PERMANENT,
> +	or carry the NTF_EXT_LEARNED or NTF_EXT_VALIDATED flag.
> +
> +	Default: 60 seconds
> +
>  neigh/default/unres_qlen_bytes - INTEGER
>  	The maximum number of bytes which may be used by packets
>  	queued for each	unresolved address by other network layers.
> --
> 2.47.3
>=20
>=20


