Return-Path: <netdev+bounces-224867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D52E1B8B180
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 21:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9D851CC371E
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 19:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CD52F49EF;
	Fri, 19 Sep 2025 19:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k7eOwj7x"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64FC2C1786;
	Fri, 19 Sep 2025 19:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758310500; cv=fail; b=J3nTDDftkK5MpvK6POaH2as+aAfaGggKV1BOEwoQ8KMZp6zc5qDVBujwzXAfFXUiNwEEnWnBD+fu9ykuuQao5+bmZFyRqEYOxhgIA4P0vVl+/10fO6ku5l89rZTbrMx5vX2m9gYW5wdl/2LrpBiCWMkWl1ydqYbhnhjtZgTZHMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758310500; c=relaxed/simple;
	bh=IL/lyDIUz/UpMaIh/+sYYrCL3QUCT/fnnzO3pao0fCE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BcnUznj1TsWoQmo8WCDFAwoqHmeQqW1b+9vIkC6qggz8suWp3vzvtbS7rSZ/SzUCHhFQIQHDwQay3nZWiuevqgmXqE97Pw6bxvJ8P3RXOF5zDjVeZGzrFaJe0VWZCsoJ+T3rLPC2ENQK7q++MJ7pKmV+TJ5RLUZU9VFcgqh5xmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k7eOwj7x; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758310499; x=1789846499;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IL/lyDIUz/UpMaIh/+sYYrCL3QUCT/fnnzO3pao0fCE=;
  b=k7eOwj7xZjRjM2PD64hj9MhsjGmg6SodiEifHRxJe9bx6GwN4uGN1G8X
   iquCuk93c+5aWRWG9X8YtetGz6t/+socO+mQJAsHY3YVj2dLjCXEcRJiE
   Mho3ap9LhakROAinRMcO92pZlOU8A5/TEYG7ZHbzMVhnpuqsuU2BZhWMk
   rGThIlvSb4rUiY897yLbmOrLdHicfc3OXtMDeutggvoiNoQlquriVwA6v
   Pubs+qTskJjgklu2tvnbH6dfoaBKZviMOkCJBO1lYVrIdNhco1jPJTJvI
   ILqso4vHyD4KTFkq8d6iuF62uvQCnor6naRofxLaURiKR91pDmm9cX3Bd
   Q==;
X-CSE-ConnectionGUID: wcrJqhbfQVCNnZ9QC1IocA==
X-CSE-MsgGUID: Htfv93JySU6UVXkDmBmImA==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="60777962"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60777962"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 12:34:58 -0700
X-CSE-ConnectionGUID: 8YJhX/6ISPqr1MQeu0x6Tw==
X-CSE-MsgGUID: BQ9Hhb1hS3+ErcZ4n3Gl+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="180317708"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 12:34:57 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 12:34:57 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 19 Sep 2025 12:34:57 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.49) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 12:34:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZsiMdJhoKt6LgEWSagwMks/nGjG90V8TqOVfcbMvgyxNS6TA4Zkbw6EkyG7GDl6POJP7wMbtqukm0UvWzs5DouPQJALquKIqXmfvty7KnUetOcL7X76ZX8NJjSe2GHGQSW4vKSqb7FTQoAH02vFm8+umNNxQCp3wYR6PruVSVOxsCvvoK3hA5+iOjCMnL99nzRVBcuagpn+IoXU7+pUc/jKXqICEcoLKd8mZqJMcUbBMwOOFM9K8wWk6X5+PsguZbXRSNmbFdixFXuVOdY6KaloLT7iKf5JZQphWVyf/pgClFMhCRtg6ZUP/Z7mH9BvLBvyubpnMt55APouQdU9bfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCVNtIQIu31T5oqDkx7sNLS15mxyYrCRjiKA1dBeBVg=;
 b=OMDJWzkd8NnNckwjlEjnkJ9JD9AKOspl8q5Qt4Il0ikYm0wbWS5nKc+TUIdcOl0dclBYylvKNZuUK1UnfVyEaBW9Xux458ngeIlIXjqwNzeSXkgfU6Aqt/lakwQi4l4M0E/x1BPio8czBCcvAhHFZPSLrlB0U9TKt9b9vLyEd84tIZrjRU0SlayndatlLWSOqM5ymcd3KOwCk9tmY3MAtjtlVgFuHX1NWVUbTgdpgi+Eb3ErOroZ494Vyf4Alj/T8rxQBH4EcneZFZBWHuiqdvUxF39kRT7LDqr7KoCcQ6pKgVfI2f9gV4LFOTyXdLv/OLEeQSW8nMjDyRXUCvxxVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA2PR11MB5180.namprd11.prod.outlook.com (2603:10b6:806:fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 19:34:54 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9115.020; Fri, 19 Sep 2025
 19:34:54 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Choong, Chwee Lin" <chwee.lin.choong@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>, "Gomes, Vinicius" <vinicius.gomes@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Shalev, Avi"
	<avi.shalev@intel.com>, "Song, Yoong Siang" <yoong.siang.song@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v1] igc: fix race condition in
 TX timestamp read for register 0
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v1] igc: fix race condition in
 TX timestamp read for register 0
Thread-Index: AQHcKLGjPJAydz31xUamh5mdpL2LfbSa53qw
Date: Fri, 19 Sep 2025 19:34:54 +0000
Message-ID: <IA3PR11MB89860D4DD0D79426AE6C7447E511A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250918183811.31270-1-chwee.lin.choong@intel.com>
In-Reply-To: <20250918183811.31270-1-chwee.lin.choong@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA2PR11MB5180:EE_
x-ms-office365-filtering-correlation-id: 9ae40c71-0218-4757-4987-08ddf7b39c05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?AI8Zg+Pdp5Fx95dBQZN4f9HtmxnlsaGPi0oU5oFQeoy2TYKN0/E9Sw8lqHlX?=
 =?us-ascii?Q?qAC9crl7SOhyi2+VikT6ZJNzjH7sjd/EpzW8hLS0fBhgPAMnD5wmcKq2quVh?=
 =?us-ascii?Q?DJRPhVKSqdaAu3lKE9GQ5pFog8/NGWnhjfUk0wF5KmMqjzVU9VAKr1PMS/pB?=
 =?us-ascii?Q?UlQqloK49+T4iWUgNE3eDpkpHo0NFEoRpmhcAQ3DL2tVgGdoGGEtpsCJIfPZ?=
 =?us-ascii?Q?xa8ENNl/wcF/ENS9Hi0UJRJgRK0ulsMAsTGZVF0oEjThG5IHbmc1fRkCnLuN?=
 =?us-ascii?Q?PQjsa250tUH76XG9E7noSo3Jcp16yStFy4Rx0iNs7OA5TaVUEj0awsWJeZeN?=
 =?us-ascii?Q?eFeDH+Ys/zVc9Y5n9QtKnUUiLtSHVLL8AD/7xEdJEIZap2W4PINaBKHbBUMQ?=
 =?us-ascii?Q?SucErOYKNV58HEEc6DBkFnA5H75coTUFq7d8jL/DSXnvJ5leknCKEM76rh9g?=
 =?us-ascii?Q?tsZZxyOsbFA1gDnl3l9QJTWU+rN3SFVPQE797EtMOstSOild9OgBDmCx+VBB?=
 =?us-ascii?Q?ZqIoP0NrjCLKDRLrU1xRD5e0abpzjztYXln9ezW7qY5xrz+kZvM7qsq5y1V/?=
 =?us-ascii?Q?FsqrV/59hC+NUaqbGIFIwv1CZGbVsYJcymvLv3tWDEVlHEovPdFI+tTVnrnM?=
 =?us-ascii?Q?D9sr3vWEhG150xjywIf0mSIIpGRArmkNFraSzyW3UDuzEoxnWTSH7n0QyiBX?=
 =?us-ascii?Q?3DsR0a8DclMyK69jX9itdCWkQXlTUqahBwbZ0AC1c05BMon6fGVvJUkiBZaV?=
 =?us-ascii?Q?IL4+GaGXEh+SPRr1KrIJ7ioXrZwqK+vEU+AO3qPrNyCHjJr+lOCFN4uonRqK?=
 =?us-ascii?Q?q+bDNQuCv8BJk3vhmbzlAS2t2+n6RrwYxqfp/DbMIC+bUo0t/7YzezLADasx?=
 =?us-ascii?Q?4zqH8mYKSJxuXUuPuyK5RBgSWfIWJOQ02OMAK58nvQn6ipDIXTAva1pirkR8?=
 =?us-ascii?Q?yZCTloSqJjyNNvvLWjmjUQ7PRj2GYEsKYupom1tTqDZoB0qmR4Kdp2tJXEAE?=
 =?us-ascii?Q?Wls10C4H6ljpHOGpk4QbvFOwOmxo+/y010zrgczG2C0YcOnOaXmzhcxxuujt?=
 =?us-ascii?Q?3hFPVMIK6mtD9L1/upbpSlMLr8HbC72k04AkYew5mZrITQT/pqmMNFJynE9O?=
 =?us-ascii?Q?oVu9HXhjND2pUCMluv0D+MFXyiFtHL6y0Yi0wrqXVB7g2MWZJUdw0rFQ4UD1?=
 =?us-ascii?Q?ZnKuDKrjrbjQ6rKlVmi+X/8Qbl9D5OphyxK5JmJ98WCIToQ9ZucKqGWkG0qr?=
 =?us-ascii?Q?0+iT6BKL5fG2rZ/VUpocKkEuj7Yo2Ua8HL+T6HFntAElkhcEpPMBC9DbZZm7?=
 =?us-ascii?Q?vKe+ynXvA8RG4ZxpGxdt4JuY+FtQi7F17RHJubVWFVvbnfxYLcIDKWgySqSG?=
 =?us-ascii?Q?amim8KyXC72oNUslmF9jBeZ+WD0Y6FxVq+lre2LpbaPMhspNL0SPMv9AySeB?=
 =?us-ascii?Q?3fJXjpLa/UBu1/th08EzutD5ExB84O8m29TUjAFB0DO7Qjh8odmjWvgMrafA?=
 =?us-ascii?Q?8rsuLVtTSC+bpFI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H+I+FAqpbim+n33a+uJX8fIndZRd1ioXA1rZ9pSJNO9bRkUq1GUqm7Kgn/pP?=
 =?us-ascii?Q?GOBrHHJVzf7IPSg5SypP0QChlY42bcIQ4iki9WIyVvz6pRhLpmhdc20wqfda?=
 =?us-ascii?Q?HEI4ewgls8NYNby0hAjkkZCbA1Gi9O7wYqBaD/mAEfNBNEaAxrb+/KyPguhu?=
 =?us-ascii?Q?auuNQjGq4iy8qQQyI2uffGYcdoHR6xOp3YhD4dwTRrI+cwm2WwHnc6YNEdaN?=
 =?us-ascii?Q?NoC0ESi3ICZEbFuggjCeV+qnu3LIiKh8jlrXXX3wjnPZPg1I2ijN4sNS0Zjz?=
 =?us-ascii?Q?SAyxVGf/3J+sPciM7et39HnZh8NUfAJ6g0ygGpoTxEhzDjeBQHoLaFueg1Fj?=
 =?us-ascii?Q?48HtTbFZ9wPLQ8hPFwc6tL1rHy4X/g51lWpeBahc+wqEL38+Wuqjcdhdtcqp?=
 =?us-ascii?Q?wGtUoOGKg7mrdj5hkMKPQ7C3DdnApcuczliVqoB1oWOtuTrnW5gWrFrOgFsG?=
 =?us-ascii?Q?2CI+ZQXumNsmGVnoFN6axvjXUdY9TBgU1hhDSXLwZqPHy/RGmkCE2E8zPgbk?=
 =?us-ascii?Q?4+A91JMQz0XXQ8utNDceEkEpUTVJ+iW1FIpDnt60QnFSXaZBWOToV4gkA1rU?=
 =?us-ascii?Q?S1DgfBcwDtHu6g3pLLkDxfl9utQ5Xuagtt0fzVSQ5zC8q4QSmRoCwzeRN3eK?=
 =?us-ascii?Q?l5PNxjobpTnGgMyJKp758xJlCQVOEtkK1XLpH3+ag3zz6pjJJGmubmBtnC2N?=
 =?us-ascii?Q?agKeXcuf0n6UaIJ3oXjzpi4bexil+wLaRNkbmwAULZe8Ky0D/3x0GAqS67Ul?=
 =?us-ascii?Q?cJsl4IIb9xE8neOr0vsyiIpo6cHzxdHsVixaxrsY85b8/SntEBzC7MAs9Pq3?=
 =?us-ascii?Q?nSQl6ngNPGhdotDsy/5blMHEVj7QWRUFBs1nlIAsQsnWama4U6VwSNOc+ZVr?=
 =?us-ascii?Q?hre4WYCW/wj8UGAa3jNOFVvZfaeBSRbJ7HaF6slvoU7jqmq0AEIB8kZRYK8r?=
 =?us-ascii?Q?p183SUEIKe/9cyQPpCo9q447wgWTRwVQ46KyZ1a5x8HKxHN+yKOfd7ahu4AL?=
 =?us-ascii?Q?yxl4N3zqQw59RE/2ZAwzexsT4Vz7DY9aLvrjgRxAVC7kCj1VyKo5Y9HLIbUq?=
 =?us-ascii?Q?VePRQaf3PkhovYJzCHiKp1H1pgChaEieCSsvTjHvk4Kh4UkrGz/kD2i1tu3G?=
 =?us-ascii?Q?wmqqeFcCDxmqSQife19yVSUOrC/HTHnwTZy3PEF5p1Xq31lRsGQaK3e9pt/f?=
 =?us-ascii?Q?CMh5QJMP4VTb0IvIMMFkbG8aSl7QSG6f0U0gBLCAIKd0gy0dgpfIWJp1PtRU?=
 =?us-ascii?Q?T639EG86msi8LqycHk0EM/UwlaJD+bfJpvj2/7dBl8BmXuxis+7MWjAQoAsY?=
 =?us-ascii?Q?3bXP5icq8ne/OE3JRJ5sP37Dd4a5MT8H9fudkEHGZPv2J6U1r7JMe8ZtiqHX?=
 =?us-ascii?Q?QitQsrtpYvGdoo8TAqrWC+p09uvaRQ8qINyNZw+fxgSHjLmm5iLoCv/cDHQ7?=
 =?us-ascii?Q?ZYeihjRlkQjN84TOEA8JhJTjnoVWKIr4iGupcLIYMUV/SVQfXJjtIjyK+QKY?=
 =?us-ascii?Q?MJw3b5g3LY494uztc8kyc8NRpmkOsMJRMzu47Sx3d/0gfk9Z1cjFnsxo8YDx?=
 =?us-ascii?Q?eLOe/GoqPr4T2++JOqkHQ+s/WHYZiWHvHfc8Fcqgk4RKs+swStYpi0NBM0oM?=
 =?us-ascii?Q?Ug=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae40c71-0218-4757-4987-08ddf7b39c05
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 19:34:54.5174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pOtNymnKSrr2X9qh7KICAp+gleyITAM6FvVQqrhDVgbmc7eJpOwaI+mhjqB1VJ9clz+sQQvCmCgK7KyidboBlW5XOLh1Z5mH98YAVJyqD0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5180
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Chwee-Lin Choong
> Sent: Thursday, September 18, 2025 8:38 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S . Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Richard Cochran <richardcochran@gmail.com>;
> Gomes, Vinicius <vinicius.gomes@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Shalev, Avi <avi.shalev@intel.com>; Song,
> Yoong Siang <yoong.siang.song@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net v1] igc: fix race condition
> in TX timestamp read for register 0
>=20
> The current HW bug workaround checks the TXTT_0 ready bit first, then
> reads LOW -> HIGH -> LOW from register 0 to detect if a timestamp was
> captured.
>=20
> This sequence has a race: if a new timestamp is latched after reading
> the TXTT mask but before the first LOW read, both old and new
> timestamp match, causing the driver to drop a valid timestamp.
>=20
> Fix by reading the LOW register first, then the TXTT mask, so a newly
> latched timestamp will always be detected.
>=20
> This fix also prevents TX unit hangs observed under heavy timestamping
> load.
>=20
> Fixes: c789ad7cbebc ("igc: Work around HW bug causing missing
> timestamps")
> Suggested-by: Avi Shalev <avi.shalev@intel.com>
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> Signed-off-by: Chwee-Lin Choong <chwee.lin.choong@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_ptp.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c
> b/drivers/net/ethernet/intel/igc/igc_ptp.c
> index b7b46d863bee..930486b02fc1 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ptp.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
> @@ -774,10 +774,17 @@ static void igc_ptp_tx_reg_to_stamp(struct
> igc_adapter *adapter,  static void igc_ptp_tx_hwtstamp(struct
> igc_adapter *adapter)  {
>  	struct igc_hw *hw =3D &adapter->hw;
> +	u32 txstmpl_old;
>  	u64 regval;
>  	u32 mask;
>  	int i;
>=20
> +	/* Read the "low" register 0 first to establish a baseline
> value.
> +	 * This avoids a race where a new timestamp could be latched
> +	 * after checking the TXTT mask.
> +	 */
> +	txstmpl_old =3D rd32(IGC_TXSTMPL);
> +
>  	mask =3D rd32(IGC_TSYNCTXCTL) & IGC_TSYNCTXCTL_TXTT_ANY;
>  	if (mask & IGC_TSYNCTXCTL_TXTT_0) {
>  		regval =3D rd32(IGC_TXSTMPL);
> @@ -801,9 +808,8 @@ static void igc_ptp_tx_hwtstamp(struct igc_adapter
> *adapter)
>  		 * timestamp was captured, we can read the "high"
>  		 * register again.
>  		 */
> -		u32 txstmpl_old, txstmpl_new;
> +		u32 txstmpl_new;
>=20
> -		txstmpl_old =3D rd32(IGC_TXSTMPL);
>  		rd32(IGC_TXSTMPH);
>  		txstmpl_new =3D rd32(IGC_TXSTMPL);
>=20
> --
> 2.42.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

