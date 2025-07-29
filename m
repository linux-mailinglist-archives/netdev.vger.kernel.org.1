Return-Path: <netdev+bounces-210789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 463D9B14CDA
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 13:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6971518A3660
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 11:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA21628A1FB;
	Tue, 29 Jul 2025 11:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jGBXIXCB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2CF1E3769;
	Tue, 29 Jul 2025 11:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753787793; cv=fail; b=Q3N5d3DoSAAKNZRTVElQvTDoKFrNRcwXf+OqLsWagVLnJ1h/oxETRGCr+3D1KO7CXTEPQqyDOXVEpD9mFmCEljihn1lXSk0iIg7nlOARo+qxTAeVY38J/5M+VTfO8QoagMO9H49qtgH+N1M+8ZQTJrKvO4gZfqYSRtM+MxwALYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753787793; c=relaxed/simple;
	bh=sNVVnTxoErQUpgMwTBU5V3u5wCDN2wQzfi1G2EFAnRU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kg7oDPbDCNOyyMnZls1IMz2X96333+RqG0c5NPXF8QU/McRtQHXBXGSs70SyYMh1YbHpGQUWWAeLZF9M/ozq/sWQ8cU/pkzlGgLCDeha2u3yPZLlgBwXlvNdgNFGZ/Zy8V7cKOwjwGghrzSm7PAS8h07PSqn89J3YvQ5yzDU6H0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jGBXIXCB; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753787792; x=1785323792;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sNVVnTxoErQUpgMwTBU5V3u5wCDN2wQzfi1G2EFAnRU=;
  b=jGBXIXCBg7wABaxgb5E1qV+7OsPp83aoyOIB4bed93rAhpjg4ltmvWqJ
   c3EcwL9UaoH2Ky1Q1EBAzuBp6MYIgty3LGSwxnZwBBnpp/7Muu2ECAut7
   U576zrSqK70/89glBff8a4tj5l3WJZ9lBLadQk8ogLOL5KDmPo7kphJ6J
   mJYxWGVru16CnMoU7u5TbZR3ig0528H27Pvu3JuhpA3KjZ5H3KV5xeUTx
   bj1EQE/XtmiCk+6bSuIBjyc+ohhkD7tpgneBI9NyNLA095GcVR8Kwj+qA
   wfFtb3rZTa28y8JAobiDKkHFCmqfHNdkSgofSEIA4ENa7R7VBpPPoafpV
   g==;
X-CSE-ConnectionGUID: cwhkdbCAQwq25fgu9I6zcA==
X-CSE-MsgGUID: S9jWQQzaRgmlhOiUmUFVtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="59858287"
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; 
   d="scan'208";a="59858287"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 04:16:32 -0700
X-CSE-ConnectionGUID: eGeRr+l9Sr6KPNygHNKYXg==
X-CSE-MsgGUID: iYKIhtnKTyq5u6aVy0zAIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; 
   d="scan'208";a="193666834"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 04:16:31 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 29 Jul 2025 04:16:30 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 29 Jul 2025 04:16:30 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.50)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 29 Jul 2025 04:16:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9Fax2o62Vd/v0zHAt8Vs02KCBfcc018KOF9+ET8SpUich5mUwXIoNs6fJ1gMwPmTrhaalSc4ouUCyVFXrgaLC1hZyTuNJprrrtpepijgsacZj5Hv1FwHgaFZ4zbfoGxbqEm0rv72EC2dGerYBWdo3ysDP1G+iNNlO6Pm2pPlSy9Uym1ZoM4iHzBqGNABylGVv6AdW0OQi2KZMqHX6Heml0ARs+Njg7eiSjoH0ju76v7SjK6J/CinObAGiY8abpkSv5YN+fYUp4WeWpyGEgZ5wQ4inIcu8VWNYoFoeIvZS3b9es3VrNE0Lt5XsCRwauhPJw0Stg98tH0mKDgOfKMMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5tCClkq9dwnAiNElO4qftAWPm+aJVEfPiZyNEYGXhc=;
 b=GZWzW+1uV0K4U0+Qif+ggBwT1YgMqsTqPKsiCOZ7Yzgq6Wc3FSENp0G5Kiaf4koZdBICfwBbdyCZwL8E15PH83avLhuNtA/MBj2XMK+y+5HoVPh+5+th24ebuu2XGJFFLz0+qWMDiE6CdN1QAigcqd8DqnVr5mdIBBY6elU/vSCHiZB/Iggou2nBPlw1333c2mCdOusOHHDI4i886+U3nr6nFT1BjD9QSvt+DlPqAN4/whA1n8blp2QL7gHZxRSgm+HKFB29Iww6hzmY7PdmoPg43f2lJVwvdgmmB9dkrU0t5viH71ZXBuf3UdmwIeBNpo3UvS8sCmoD6R/fnjv2eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA1PR11MB8279.namprd11.prod.outlook.com (2603:10b6:806:25c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Tue, 29 Jul
 2025 11:16:28 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%4]) with mapi id 15.20.8964.021; Tue, 29 Jul 2025
 11:16:27 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>, "Nguyen, Anthony
 L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "sdf@fomichev.me" <sdf@fomichev.me>,
	"almasrymina@google.com" <almasrymina@google.com>, "asml.silence@gmail.com"
	<asml.silence@gmail.com>, "leitao@debian.org" <leitao@debian.org>,
	"kuniyu@google.com" <kuniyu@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>
Subject: RE: [Intel-wired-lan] [RFC PATCH] net: add net-device TX clock source
 selection framework
Thread-Topic: [Intel-wired-lan] [RFC PATCH] net: add net-device TX clock
 source selection framework
Thread-Index: AQHcAHbOCr534cZchE2Cw5PXSDDqcrRI8l5g
Date: Tue, 29 Jul 2025 11:16:27 +0000
Message-ID: <IA3PR11MB8986B14D3CF3047845BD9926E525A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250729104528.1984928-1-arkadiusz.kubalewski@intel.com>
In-Reply-To: <20250729104528.1984928-1-arkadiusz.kubalewski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA1PR11MB8279:EE_
x-ms-office365-filtering-correlation-id: e06d4a8c-d6cc-4a4c-815b-08ddce915cc8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007|38070700018|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?/Ncku3A75ba4W+N5nDzwKYGZaXXGJ/z5H2giIAKd+fCRN2peux9fXCdTQSy6?=
 =?us-ascii?Q?empW+2p6sU8XqZL7j84iQEnG8/eHbFOWAZWL4JPr6OIAOANzrCL+uIomA0Jv?=
 =?us-ascii?Q?+QW+7VgTvFlDExSEQUJvct6xQgpi3FePcqj2CwZychKdu+gOkOt0+nrUji6H?=
 =?us-ascii?Q?st0IUXGG8VujKTmDDa0BfNGCPnj3wsVVzcP5BT34KwvLD33onvfMUv7Dybsr?=
 =?us-ascii?Q?wZrilv8zIeMOwPmU1OfitfDfZTF4P9BJ9Vpyb5MU7zB7OHFLCs5YFn/6JiyE?=
 =?us-ascii?Q?SvUQigg/gfcuKZYfo+AzmO4AnhfQrsva66YyP6Xte8yhVAwOr4HSX5LPi8Ke?=
 =?us-ascii?Q?7Tk7we1kzS0eSU/R84TwgR2gTcuROcG0QdMPvDwMw52q2AkGLdiutVoBV282?=
 =?us-ascii?Q?6Y+Xf5kx56P2NVgpqn4qt/mpWRekztu1IS1nozf5Bztm72s2H2WrRaRF19nP?=
 =?us-ascii?Q?uyqZ74FUPJek7kGxJPdtpdnR/dDfkD/7glGVnFLj9HJEG8Pt5qsoytK5KXTd?=
 =?us-ascii?Q?GR8q9K900D1JTbig4TxnjNPqDBJaSoEpXHZqzEdmF20qhmuGKnMCZy+qFuSB?=
 =?us-ascii?Q?+QiFjP8/8kzNioiyR6VHIteV409AWq6o8se7sKlIHdRW56e4noShT5w650Ws?=
 =?us-ascii?Q?MhLFrnS2+Tu6hLiUlHjTcGWC92V4vEnTYtIMz61dRfZa5aHOJO5kkawKF64S?=
 =?us-ascii?Q?LOYRNlFqy7QQpd8A79Y2mEk2QP9cjVEWnjFn1cxGZcBbsTs9yaAXPcgMR5Qc?=
 =?us-ascii?Q?2WC3LzncHRSjIuSZFpbiThB0s351LaUFcRzGB4q+6dB71NDs7g2qEbiTsh3Q?=
 =?us-ascii?Q?izq8Y2mxOEZJt7bnrECUCVo8ar+2YYvDDIj/R3dSjicsuXZvhVQEgriRspbp?=
 =?us-ascii?Q?oJ0eWeXq5ECg6V+kvRJVsQCElshzHEoPthmSdE8ZxImPDqXEK5XC6zpresC8?=
 =?us-ascii?Q?rfpNhhHxU2ucsvy81t1P0jsk9hsGZSvsN7/elcGCGdKUx2HPAVIo6Tewh+x9?=
 =?us-ascii?Q?2rDh8pYUa+ovI5SC/6PVitKdllXMZIfGD8m1DDdusq98JX0QY4uDFVXJArKF?=
 =?us-ascii?Q?gGMMB+n+Xy4SKDpecHICUddiIMiFJdhwTvF3eYHwfb0XIFmn2UOXGi0qugRj?=
 =?us-ascii?Q?iODmqw8LuelC8if7Zc1275hy6zg+iP3CfJDxiYyUOHpXR23xrlOEZVYXXvxy?=
 =?us-ascii?Q?W2ruJF9Q9VC/lVB8RTM0wubwe8bED0vHRF0DmN+uX7jJAe6oQmlRmHGq2p69?=
 =?us-ascii?Q?CShhR3qJSLa5w1b7vIvwYBiCY5bLYectB1ojOjC38oDbbBht1XzUK1xQy97V?=
 =?us-ascii?Q?U6cqMwe0blJT8XEshaOR64y85ep/2QwyA/+CXitu5dR/6R3Fjr7AoYE+tc3v?=
 =?us-ascii?Q?0Eg4KHO1wD0uGHk3wvmS8wuCVlyd1p2Wsu8Bc3hYCMrrJjLowHyLcB8d15Vk?=
 =?us-ascii?Q?ndkPVqBR3m2FGMrIKdRU8kwhPrvjhq6sl2YGAY/zzMNTVDgOzrL7jeJgZl2b?=
 =?us-ascii?Q?njdS9YAYhu+LsYQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qGTvAM8ngidqa1qPUzNtzgF9lxvMvEIlO6Ui9+bxW2wit0vBeYhQ/0KHqz9v?=
 =?us-ascii?Q?FE/0IHIKFwWQyhnWzL3TMYgdYiY8/qTjhOp+kx6W+J+XUqRukl8o6iPVdRmt?=
 =?us-ascii?Q?KtajA8KQqbO3I7qkO01KnCbLV60ssMc78VB7x9SZIpHHLGTM+8DcI9aAjmjZ?=
 =?us-ascii?Q?UXst8IGxzy7v5pCMKbXaX6jqGCAE9emHc2vA47bkKhJ34VtDgLRMg4FDhr2D?=
 =?us-ascii?Q?nkMgJ49yDSb1IvBqaXJRcp+Kj361JYQEpyNnnt1we/juMctv39byuqcsm7vW?=
 =?us-ascii?Q?wqyKyqmh6nZh82A87ObPmSQtnFdpNTD78aGiBse+WojPlwM8XoYuzoZ31Ki4?=
 =?us-ascii?Q?yyXZrcSGdR/aXqliXdQ84LjVtLGKMvygylgADdKPkXuAwUtmdmf14jlrc+8p?=
 =?us-ascii?Q?nY2LPgzDMXJj2XuSXDhdNYCixsAjdyPUePnXyOqPp5VO03O+0qENIg34xp9e?=
 =?us-ascii?Q?QPyzZlGpzuQkJcataOc34RvQwpP3E0eno7v7SWbkIHYdPlw7JAmDN40XUjGV?=
 =?us-ascii?Q?kTNNdvtse80yZetkpkhkKlYrIatmZ++N1oVv72pUNKsPwoMxX/dIYkSqiiXd?=
 =?us-ascii?Q?K0qO3nbyEBvW5zBEeI0rgY8LlTJiCxElOmgizaZHU5hhmZ6Rmjl2T3NYUWGy?=
 =?us-ascii?Q?m2jVUyoLQAY6DWstAVSv1grQUQbWWFVbMpBVvtzT0eh2hh1kwTLYJBqh8mNq?=
 =?us-ascii?Q?h8wG9FWaDiQFIVYeWcdabet0nqd1vq1BuRYJwDXzU2fOkRfJTXikKi7TYWMg?=
 =?us-ascii?Q?d1xqNaWKjgH8JbQcxpaiCpeOvv3sMFGubWAmnHAoBsmJzrTg7fpBUonr1e56?=
 =?us-ascii?Q?iOXsXd9PEp5WRDcJ0egcy6TBuqx14+GN6bCLNA1o7vGbc3qEjTtOafzhtMnZ?=
 =?us-ascii?Q?CpdYGV5VAVgX7UaFbawYUdmC1bSNR7ZiW9Ho/9zPrLrtAInWZY98lc213sG6?=
 =?us-ascii?Q?k0WkG3nb6X7q4YVnMXE1pteFqrZlB9hzsRhQwN9T3+kCfuVHJe/TdqIjUqrk?=
 =?us-ascii?Q?zPufhwPtFZ1za9PtHGKvCf2qzybQSCxUvbuv1k5xOWt8526XE3ZKXmW/aDvO?=
 =?us-ascii?Q?DP+s7qc+nHyHnwsRaR628yjqWKB3kisBopWD33hR9zCIvyZ/azgP4fThG2GD?=
 =?us-ascii?Q?gBYKZ8DsZDy+ZJbutwqX8esxFZA6/nXq+HJef7Ji8AWlisuVz1UxOSuuN/zg?=
 =?us-ascii?Q?EInIbjNUGK90+087DIKu5mMR7AuqJ/k8xakYWZ/KpYiUG8pP4IsHe9FF+rUx?=
 =?us-ascii?Q?6hS4hMEhPExdn+w3r6WoVqS1tig52FOgODZYSZxF1FQUDpGSjbe6bWfvVoll?=
 =?us-ascii?Q?iaZ0c/W8iIje7Bm6nhSnnQkkNGtn5W3G7csXSAVCVBdoAFuGjDmCnHcZyyHF?=
 =?us-ascii?Q?QhmXQJKwh8OW77dhSwJszEecjEtZ4pB8ZmDlC8LeR5pScT/+AAEFIntbVp3C?=
 =?us-ascii?Q?+mCiZWjx+hlv6K87QZeSMF650/t+7PZgf1NRGz6fQd3QwHd6y/YciUyVOHos?=
 =?us-ascii?Q?iMPK+N4LUHxkK/MeNxH4ThFIBW/wYL1lXO2HGe79ApVj8QuK8fvEHq8Sup2o?=
 =?us-ascii?Q?B2kyrwwgB5vnPMi1xgF8wZzYWgwPLXJIuTurPH8jBbg1Z9W1SQHsQlnJa4+6?=
 =?us-ascii?Q?Xg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e06d4a8c-d6cc-4a4c-815b-08ddce915cc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 11:16:27.8136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3FYX6ymfdo6NCe9bNY3dS4V4evRtxbGWVHKKdLtWM7iCcgBNwsUy5brqNwCdLGP6RwLIy+QDrP0TxJXSub3ocgPd/ly1dola7NoLBnJAQwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8279
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Arkadiusz Kubalewski
> Sent: Tuesday, July 29, 2025 12:45 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; horms@kernel.org; sdf@fomichev.me;
> almasrymina@google.com; asml.silence@gmail.com; leitao@debian.org;
> kuniyu@google.com
> Cc: linux-kernel@vger.kernel.org; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; Kubalewski, Arkadiusz
> <arkadiusz.kubalewski@intel.com>
> Subject: [Intel-wired-lan] [RFC PATCH] net: add net-device TX clock
> source selection framework
>=20
> Add support for user-space control over network device transmit clock
> sources through a new sysfs interface.
> A network device may support multiple TX clock sources (OCXO, SyncE
> reference, external reference clocks) which are critical for time-
> sensitive networking applications and synchronization protocols.
>=20
> This patch introduces:
>=20
> 1. Core TX clock framework (net/core/tx_clk.c):
> - per net-device clock source registration and management
> - sysfs interface under /sys/class/net/<device>/tx_clk/
> - thread-safe clock switching by using mutex locking
>=20
> 2. Generic netdev integration:
> - new netdev_tx_clk_ops structure for driver callbacks
> - TX clock list and kobject directory in struct net_device
> - registration/cleanup functions for driver use
>=20
> 3. Intel ICE driver implementation:
> - support for E825 series network cards
> - three clock sources: OCXO (default), SyncE_ref, ext_ref
> - per-PF clock state management
>=20
> 4. Kconfig option NET_TX_CLK:
> - optional feature + user documentation
>=20
> User interface:
> - Read /sys/class/net/<device>/tx_clk/<clock_name> to get status (0/1)
> - Write "1" to switch to that clock source
> - Writing "0" is not supported (one clock must always be active)
>=20
> Example usage:
>   # Check current clock status
>   $ cat /sys/class/net/eth0/tx_clk/*
>=20
>   # Switch to external reference clock
>   $ echo 1 > /sys/class/net/eth0/tx_clk/ext_ref
>=20
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> ---

...

> a/drivers/net/ethernet/intel/ice/ice_tx_clk.c
> b/drivers/net/ethernet/intel/ice/ice_tx_clk.c
> new file mode 100644
> index 000000000000..121e9fa0c146
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ice/ice_tx_clk.c
> @@ -0,0 +1,113 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* Copyright (C) 2025, Intel Corporation. */
> +


...

> +++ b/net/core/tx_clk.c
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: GPL-2.0
I prefer old style /* SPDX-License-Identifier: GPL-2.0 */
Everything else is fine for me.
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

...

> +EXPORT_SYMBOL_GPL(netdev_tx_clk_cleanup);
> |
> base-commit: fa582ca7e187a15e772e6a72fe035f649b387a60
> --
> 2.38.1


