Return-Path: <netdev+bounces-108894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 958319262C4
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 16:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69351C21478
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 14:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11D9139D16;
	Wed,  3 Jul 2024 14:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DKFLUPBN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6BA1EB3E;
	Wed,  3 Jul 2024 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015290; cv=fail; b=Jq3y6PEzSwYV57hu8GDk1dos9BsspZeP80WWGsrjYzANaB2CUq8DpsIl8LWG5xBGLDWOkBRkKy0qmQYnVZTMcsNsd8o+V+8JNvcKeH3jKM0mYRJ9sYpmtlDywhrf3cKfX4HBNrqWCDpXkt+0zt450MhZPrXU5E06p9hDF3S9Id8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015290; c=relaxed/simple;
	bh=LrXwVJtihEB16LiVvdfaOtHcNi8LufsAUsFokC4dwIg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hZmSvraD0JUKYVlo10qxahmf+8NbI9uYswqh20vS+tY+KvLjrNqWsD2Hco/0sW67Bo3MmPcml6R8hpDH8d6hWJVaQChMpIrNVR97noDG1QgEd6nyJ7KbYzPt4hb79xeWUSMPeLZ+Im6qDbzGzuwLHAio3y8ofyiqp+fmOOVkPnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DKFLUPBN; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720015289; x=1751551289;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LrXwVJtihEB16LiVvdfaOtHcNi8LufsAUsFokC4dwIg=;
  b=DKFLUPBNC/Bi5GwqcWABQcZ80JUBhNmtgFGGIfbi7snzly4PwKlJ4v8J
   Dw+PRQj0yJFV7EYwIkS7kLq6hlLNeg0b9LP9+cQwFeySUyM/8H7DMU97x
   bEv6LQkao7gjcE6yWl/D+AdIHMTp2oeiT6bi48ZdavzYPUMgGYl9zJEp4
   wuGi2XwEmpkYHHR5BXjkg9R15rgpl3KNDVIgilIDrF5ZbT33+fksLUaQ0
   FBom9Jv0yYHycn6VriNkeVXNZCoMXmOumBnuniUKE96xzEXPPPJdDHDMs
   FFEg9PrTpX5mPkzhrFAq14OEWD7akjZvZTdSQWc9iMdZeCYUMYOvAJJL6
   g==;
X-CSE-ConnectionGUID: bwiV0gjcQge5Qed+CBloeA==
X-CSE-MsgGUID: KGGZtIeJTY6H6rEHr49KqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="28636755"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="28636755"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 07:01:27 -0700
X-CSE-ConnectionGUID: U58XQPxGQWqwU4y7br8w/Q==
X-CSE-MsgGUID: uelKlhvBRNSrDIL/g/R7iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="46184054"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 07:01:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 07:01:26 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 07:01:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 07:01:26 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 07:01:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atomTelW6Wbzhj9czdHSlj/KpQokZgo+N3DeJxwQCcBr6mobE01yWVf216n2DWP7k1dXkiJmZzFPORjxk4WDYXhFCz5y9zrCwIMp19MvIlkzZ3tvnJkt6xbMWvDqb2/v8nW6e/HTHU7QyxJUC7f9LcqwSdgvqTXjeNEY6IkEpDDlstywG22QjHMzlc9SFjnc/omsglQaRig+nTABgemIMAMBh4ZCVYihAL/FasCvIomjo9+MiOHwxewyy8TrGwTiwKFI1NW/Q6HaBtExcjBph8pg2ytOIQC1KR91DwxMDjq+A0HqheL0aUzWoCGEgqrdBT7bPBExjZNFsR3vxGd8NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3InscnY14+XtjhcI0HD06EWq0AnSaz5nM2omgYIzcs=;
 b=XOmiCpzDAFTsKi+sgv6a490o9ZyCWbM12cG+e3tzwOipVIvZd+p6vLJGVxLSV/OyECuccLBmLYDsvEjEoyMHeR9Er7tsoBOtX74Kp+uUr5lYBNgoRjLfzCPttw0tKRT7ujeHzHTJulS0iqWmSA6o6ZkfrSDoGaOVnUorQ6IpRx7WDwKUJ5tJOPIYNbXcOQjFU3eHphf9gVUZSpbC609VOHFRWDKPO4qHX2aVo+Q6j8nGslnZdYRZuKJJyF1UdObHkoX2kVyXuMO+dX9gtSEBip8202jCeuU/9YoeF5NcWdTPSBo+lCd1nr3oGfIIMMu36oSsXc+ri0HhH+QQPAD7wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by PH7PR11MB6932.namprd11.prod.outlook.com (2603:10b6:510:207::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Wed, 3 Jul
 2024 14:01:22 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01%7]) with mapi id 15.20.7698.038; Wed, 3 Jul 2024
 14:01:22 +0000
Date: Wed, 3 Jul 2024 16:01:13 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
CC: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Woojung
 Huh" <woojung.huh@microchip.com>, Arun Ramadoss
	<arun.ramadoss@microchip.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Yuiko Oshino
	<yuiko.oshino@microchip.com>, <kernel@pengutronix.de>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net v1 2/2] net: phy: microchip: lan87xx: do not report
 SQI if no link
Message-ID: <ZoVZqVQNSyRVW+wh@localhost.localdomain>
References: <20240703132801.623218-1-o.rempel@pengutronix.de>
 <20240703132801.623218-2-o.rempel@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240703132801.623218-2-o.rempel@pengutronix.de>
X-ClientProxiedBy: VI1PR07CA0146.eurprd07.prod.outlook.com
 (2603:10a6:802:16::33) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|PH7PR11MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: 565ee054-ab94-45d9-87b7-08dc9b689eac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XwQM84qiFkcwou5lJN1/AUO/gVmNbSNpxRxNTtnR508Mpl5Bqv0Py+I9NzqM?=
 =?us-ascii?Q?9hNtI6SMZiDHt55qjGb9dGcshx4+4viDOayEol6X6QCdA5RK4jrNCufXf7V3?=
 =?us-ascii?Q?kKD0wSL0EDdL5HXEGboqnXm9NPORk3bCI4eSKfQFtTJm+KhR61sk+Y7O9QIX?=
 =?us-ascii?Q?QFRd5WJ5LEe9f+1jORYMTCKcHZdae5SmwBV5miaVzuXQMSJewMLKm81QoG57?=
 =?us-ascii?Q?5HVTWkMzIbHeiGrfNGYjxuqt496PbOVpC0HMaUXbUAmg3+wfNeTa10S57227?=
 =?us-ascii?Q?QTOu7Dx+x3DAbyquvrgJU8Q43FnkhgmbTpLwqvyiQtrfCA13ZBtk1DfQq4hz?=
 =?us-ascii?Q?uoszyhV1443YVjrttO0XWo6cNqTbeLdaKT5crTvIbpvfPijojX6XMmKxjHs3?=
 =?us-ascii?Q?U+dd/WpX2CLQYwx5p53oaJ3ufgldwEiixmGcNXWJ4jhms5Qf7gFZ383txI/R?=
 =?us-ascii?Q?M/BfIMXB45Tp5Ly9fZiY9kbZF670Xi++2EJrMFlpv680Gf7zq8LuUihhX3i7?=
 =?us-ascii?Q?b3XfDDpg76sP8b8OParrCTNi8ef8D5uWleVsUnR94CG196Kf1I+YGK0UcdtE?=
 =?us-ascii?Q?9j2OVzP40Q+PEPVmH6A8B1ngjf4tS8/tXLlUQoLtSJuweEBIOdEASb16wR6P?=
 =?us-ascii?Q?QVoZn+cLQvxqDBW6pqQwAA80pCXSJc5vNt/AKUGMf3he0ea0Gbemmx2zFg1q?=
 =?us-ascii?Q?+SUYgQODZH3SGTZQrK0MPkq/+fYXUR7n8m2SvM02UXwzF3eu6xqCTijFOoAS?=
 =?us-ascii?Q?ZZR3UaEO37Kii1exsT1MsMap2aHyelqMzItHFhx3Go+rETOvgWLG4c9dPdpN?=
 =?us-ascii?Q?iRe41t2YKP738Jld9QsJkuwETEgxMFuwDo3c7zft1dOBbb1P4zeoegc3wrWF?=
 =?us-ascii?Q?svDVARD0koHz1t96TS0Eum+g8G6neqo0FZc7/R3HDsE0wu3fO3uWjeQ2tARI?=
 =?us-ascii?Q?4ACVDZECSbwlG2hoAdnVbk79649ToEcIzU7k/vHOvHM0+GEKbul6GnPsi1r8?=
 =?us-ascii?Q?/ATFmo088zSdOfcULltMjPKd2Fm8g1+rwVutK6SiRa3g0tQVYX4DUBsWWs/G?=
 =?us-ascii?Q?S9DzQB3R68fLyx18hdTETnK8o/2jAGQ5VCG5HkMI+VQo9PYSW09KlQ15bXFK?=
 =?us-ascii?Q?C8tsMk6ILyFqL1HWjI+GqxsnxD/dnN1E6iczs2TLyz8M2oPK3tGwpyVDy0t3?=
 =?us-ascii?Q?a/rSsmH5ZQFTyGKnDS32NpoJU5spfqAexJ0hCWjDaEMI+nBYsOtywrn6CKsv?=
 =?us-ascii?Q?sJ0Fhx3TBJ1e6AxrRXlnybXt3NEW2BakmEFP9vZkDtjqDYeoX2qDwA2I4Ar1?=
 =?us-ascii?Q?jy6YYgo6CyDtVzU9SOv6TV1NHwdNLRVIcbMJIJLPkp7Obg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DWkCvODnn6ZeGgTplZrSaBSTrC9LGs5+3JWlSF268l5u/dboLH41zZTE1e2o?=
 =?us-ascii?Q?7X62QmbF25uqwN03248xUFMo1GQuniO2WnmudUlGbu9rPqt2KSSkJjuWZxGJ?=
 =?us-ascii?Q?yNrNoFeL0FB2t+rZsdVU3KuFce+0enKwQA4yHKHcE41v41wMky/P5oQlDPQ1?=
 =?us-ascii?Q?IfaPMOk37SblawH1nr3CEjAzoQYiCMZxlhq4UcdBqjbf8J6dbF/tvKy4/LjE?=
 =?us-ascii?Q?zG+/hrDwt9TEF1HZ4IvbDNbLCabJuVaXCfR0PMxps+UIsfscNC64baqfro2u?=
 =?us-ascii?Q?QSmIWnQevIsJpO7tJNZNIhcng+X80X6km6RwvfuCBcs/JlBefW8thE7NnVuJ?=
 =?us-ascii?Q?DPOt6XvAGC0jR6dE7qOy334+W/2QfDjfT97qvdbwt4lhyOehmFuCTBz9us/Z?=
 =?us-ascii?Q?LNw6vxhDBfpAaaHoY89DpfBFW4nFXxccuf6A+WmGM6JZT8hwawfN37cN5YCt?=
 =?us-ascii?Q?o4k7/xi6pS6wXZGesZouy9wf2GQgBzT564+3kH63koJim2YEMHrzBwcTQG0O?=
 =?us-ascii?Q?0Kc9opCw2PGRcAPuHz+X4Jh/Sm50Yz2WOrXfG/XQznrKI7L6gPTFQjPUVvfG?=
 =?us-ascii?Q?PZNCXQm2h+CuXtuREQGFBP1eteAyDv+7kaAwROZnuGCw/tcD+1r8hoqsTiEk?=
 =?us-ascii?Q?kz+cbcN48iPmk70vyD/U6Mc2lO+yGTeUx6pMfwzNy6cp5cQbeY+QNPWER5P1?=
 =?us-ascii?Q?+fHzM4hVYlKRMwGxn4mJrHg7d0Org23OKd+QrcUAnDrvOJALqvK58iv6VGkw?=
 =?us-ascii?Q?j6Eyhj2fh6wfdqQTZGKuBzYK+ZfUh7kie8mPLyIodU5fjJES5ZRihp/+rClM?=
 =?us-ascii?Q?QJoX1phPEO4dgYYr2tK4AloBh9yRTGhuNPMvkQsPn6uuDYJM6P+aCHmNP7Cj?=
 =?us-ascii?Q?jsTERJKFlDssorPm3e2YTg+Xq1M1ErkFRP8Hoylco0fqetN33HkV5FMXWwQ2?=
 =?us-ascii?Q?bFwbOCD65UWXY2F637E1tpbvCiplAoiK2UvhRyhyr5AGlHPvddwFEMJZ3bur?=
 =?us-ascii?Q?xMLkz2TrooVINgHHNsopt1m6GqB41gZ5unFuCTfux05epg5IOrSf3e98IeX1?=
 =?us-ascii?Q?/DpjnSzqzWoB2kD0X2KGO3/xUrEZ637hi9daioSGaVoucvVugXSlPdPrp0Sg?=
 =?us-ascii?Q?ExZUAgrH9JYtHorXb6OO8M7UVgDYSTYVG0vBCRss8kDbFpPXVUzAeoVe5oX+?=
 =?us-ascii?Q?bR/33YUfKWvWBQLCtCLnbbS1QhIQjAUM2BV7294+qrc+V5IFstSWn0yCyuAK?=
 =?us-ascii?Q?hIUOpozdHoxP11RrW+yptCrOGaWQRunhLJGTC1zd7ghiu7BtF7HpEbEbEnEQ?=
 =?us-ascii?Q?ewJW8dc3hUItWzSaDFXE6gz2MueyeC9JZPB25CfAkNa2VoTPV1Ri3yKhOIRy?=
 =?us-ascii?Q?nUvBPthI5jg7gZEeBltF+07IHHYSExKxppnrd46gzO0viLaP/pRkDKhe8paL?=
 =?us-ascii?Q?l0G0276aOR7GqzKmH+JGtPfZ1sZzfmHBVODLnVrr26iJkMgmfdBPduT8RWfs?=
 =?us-ascii?Q?82uxDaOVuZHqCFRSaRUdFz99sTVtMlRP8SbMp7Whpd48XUhfIv9hlVUmflXZ?=
 =?us-ascii?Q?QOvO7VKhPE0uCTNOuASeL+9pS5FEzuFQywIoXxrkV2+alM5gznpHruA4/loV?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 565ee054-ab94-45d9-87b7-08dc9b689eac
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 14:01:22.2232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1RWdCv6a6mUxPyO3fTx1bkVdE2tmVJ4qudn+UjMBxUgwjBXt46lLMqGJINjgEyfHw+awOSrfJGI5f6xfa6nOTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6932
X-OriginatorOrg: intel.com

On Wed, Jul 03, 2024 at 03:28:01PM +0200, Oleksij Rempel wrote:
> Do not report SQI if no link is detected. Otherwise ethtool will show
> non zero value even if no cable is attached.
> 
> Fixes: b649695248b15 ("net: phy: LAN87xx: add ethtool SQI support")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/phy/microchip_t1.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
> index a35528497a576..22530a5b76365 100644
> --- a/drivers/net/phy/microchip_t1.c
> +++ b/drivers/net/phy/microchip_t1.c
> @@ -840,6 +840,9 @@ static int lan87xx_get_sqi(struct phy_device *phydev)
>  	u8 sqi_value = 0;
>  	int rc;
>  
> +	if (!phydev->link)
> +		return 0;
> +
>  	rc = access_ereg(phydev, PHYACC_ATTR_MODE_WRITE,
>  			 PHYACC_ATTR_BANK_DSP, T1_COEF_RW_CTL_CFG, 0x0301);
>  	if (rc < 0)
> -- 
> 2.39.2
> 
> 

Thanks,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

