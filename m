Return-Path: <netdev+bounces-289819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KmEOwJtDWrgxAUAu9opvQ
	(envelope-from <netdev+bounces-289819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:12:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BF05897A8
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9515130FC442
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B363A545A;
	Wed, 20 May 2026 08:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eC0Qud10"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C5736683B
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 08:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264344; cv=fail; b=RgGFQrp/XDjYkfICOtrDBMhLOeth7j0yiBUfgjqkFcZt+jM2EUX29yjSLT+87UWMH/mY4U4TYVRAp1Cyfq4InJ6CYRhYuSxpmFff1Jkq1sVG5w5Zl8OSG54IiTMsHKic8vwMhLZ5Sd/7zAkk6rTeYaiyrIDkAdh/KX37spGwzd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264344; c=relaxed/simple;
	bh=43TYURbuxacJj93wmYFrxwLat9daOZMGOA6JVDdzAHY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UrYAABRNq1iEfXA1BlvijCixZQi+Aia3MSVU9T74Aw3RIcH2Fhlg6voWcwudiZJA9K6hSdUQhTR/N5NIlyAG0V03+ufeGYBJ0cCsTL6Sk1Axuk4X9oDAYoH3j6hidqPzWSsC42wsQGPppr08s688LRnlOBi0K6WA4UYDMs9peyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eC0Qud10; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779264341; x=1810800341;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=43TYURbuxacJj93wmYFrxwLat9daOZMGOA6JVDdzAHY=;
  b=eC0Qud10CzfCcIde735tr3Wkc1AamFzqxc2JMN0Q2m6qWHBdbbGMbQSg
   CiRXd9P4flTnALqBZoCi+uF5W6mkqzFdF4VVQOv76o0/PQ+1s3AdQLs/h
   J1pNXXXu3sD/+GLVlxa67K3fuwd0wl+qeeM39fCQyZUg5CesXXaw+6on4
   WLdfv0m224uuoztTyQQ8CTRoLtUQrS2MysTWQXMZ5t8R8KSbrOe/VhWLs
   +madvYzlVF/VXqGcy/Rw+y1wzCzQl9Q4biMjWmGJ/y4WBMssQuPp9PElp
   fl2b3IdljKC6he2En/bvzTMurWUSKN0iEIem3j4nRZV+HISjah9MOxKs7
   g==;
X-CSE-ConnectionGUID: HUJycIwXS4a7Nvlb6d9QPw==
X-CSE-MsgGUID: xfgg1bW6RWCaYuuDSXCI9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80004902"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="80004902"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 01:05:39 -0700
X-CSE-ConnectionGUID: J5Zf0yFiTTC5yUUTLaodVQ==
X-CSE-MsgGUID: QeGnDD63Qp+xuCtJySVkPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="239076226"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 01:05:38 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 01:05:37 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 01:05:37 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.43) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 01:05:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KyehT8qCReNomLmpesc5+m1b25bPM3/b2G3dPzQAKv3tQZsADOp8suvVyoPUFkXDvr53zkKrprtkits5lVfCLvlSvQ/B0qiFojSSwaE2URnzBf57oeRZ2rH0L66JzUoK1gYXC4ASKcFzIuPMHsaqsvcizqv76W5Jau/3IN7pWO2PUnM98SuooWxWE95K+FylWQ498yjAdan3Y87rxqs8nfrEESfmgXEWN+FIT0nWrLOZa53j+MISgPxzsP0NyTVOjObzldSAz6a8AGp6MtlmQy4R/mVdseWJJjUaRLxKjv/wEDVJVns3OtPBb1beCoRmz9r5v2qUbkpESTezxlTFbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mchfuu9JZiB4g5GMPqZZj3wD5JAnO1Bhv2V8uzd9lgw=;
 b=WrnZKn3Jql0A6dxwjbrOL3UNCk57Xk+SSLJTNRR3dFTBwf9W+1+L7/6r8qL1oFTZ/yx8kvSE2WTbnEZhVAnX0qFbO7O/J/6OeMCFWah4AD6bDv9By/OKYRfz6AdJIXc+0e0lwAmEmUs04DB1DIGMzwFewUjzFZ1oSZlcAqje2GMJyumQvjrIjpj912mpTkeHUkPRBqxyZrtoen3RGhGz1x9JxeSlkHwsnQAGN4jz6WMZSs8m7nDAIrqLHe8GyE0y9qEoC9TzvnnpR0MyKLp063mruaacRrJFlvktjk4KAmh68vEp2NCr6RamrnEysoSsQ+/wWsqG6xDi9CS/hXDeCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by SA1PR11MB6760.namprd11.prod.outlook.com (2603:10b6:806:25f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Wed, 20 May
 2026 08:05:34 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%6]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 08:05:34 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "horms@kernel.org" <horms@kernel.org>,
	"jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>, "Nguyen, Anthony
 L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [Intel-wired-lan] [PATCH net v5 4/4] ice: skip unnecessary VF
 reset when setting trust
Thread-Topic: [Intel-wired-lan] [PATCH net v5 4/4] ice: skip unnecessary VF
 reset when setting trust
Thread-Index: AQHc18KRz7QRmunUh0iOUoM/R957D7YWr0yg
Date: Wed, 20 May 2026 08:05:34 +0000
Message-ID: <IA3PR11MB8985E5BCE0EAB8D89E05CBD18F012@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20260429102426.210750-1-jtornosm@redhat.com>
 <20260429102426.210750-5-jtornosm@redhat.com>
In-Reply-To: <20260429102426.210750-5-jtornosm@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|SA1PR11MB6760:EE_
x-ms-office365-filtering-correlation-id: 26830d7c-1c1f-4071-704c-08deb646920f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|4143699003|38070700021|11063799006|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: qKn4UrefcgU07BwsE2s0nLHSnmMHUERP74pTAtORyI32HTDOS4bB4S16NWi+tUbeQtJFImv0UBav+/dTMc417BpGsx+A0A7ih4FsywAsfA8p/XZtWTVsYTJwvUygaDB5pkolzR+MI0S0x3JaHDJ/MnyPJ5wD9jf19HK43w22tk211MIOB/cyD2Rc1tjacFYRb9iGTSCpbxfnoWgqwTxQzm97XKCgal2hGGMiB2iFptZIz5QSPxZ7P3ESTQFzVCHezY/2oteRGyxb8QuSOhCGiBWPCDge64Sj6hLFr54xlvl1SQQQxPUgNFIv1mrl21gLATdwq9SD3UtTS7DRdNs5V2oV/ln3rczsd+CYI89iiYMqUBfICq5FUsOdy5lAJjqNpKNlIgjtqRw7mJJcGRlR1fsFeRays0tz0p78qtQTMdLsrOuzhkBIfxhJi06UsMAYgKC79daOLWVCcXJ0WeILhbslvKj4jIkPp0Wm1tZR0pGDhwrpJQr+ftns/7kUz1lJbiHXic8b6Y1lgnvkYv43/x5jJFsBSHkj1pqGVZxwNYQzUZZqYwAY3DKjICU22L8ikxChXx/BGN8BiZuFkzUqHPIYpY7MqIMGxIY5OYdLj3HdvEiQgxtVmRM7ObpjkJHgU1+Y7tJe7/KAp3Oae+MVXqiFKgAjpsiXke5sXpqCx8sBWaOFncjDa8gY82fZ0QUzviKys6wd8gXqUcEcIU8YvuAC1PoKP33xSV5+FTsFytkJCElz2fZwEr+J5hPg78/Q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(4143699003)(38070700021)(11063799006)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jTGuhs0EHgXmbG7TWG3cZMvN7xsrrBVNkZfg4eU3QwvpruMA8LcNiO7Cnt2Q?=
 =?us-ascii?Q?Qi0YpLZMeMTPv1P+82BRY+thwZgIJGvLh7dXZqymrFOkPumifSJZtQwSYzQJ?=
 =?us-ascii?Q?zaJEjFPxcKQn9BTs+BjlAPTYCMnmGYDdJRF0i9SpPHa+sUtoheI/HQiPd0n/?=
 =?us-ascii?Q?RQsq5G52IKCCActCisiddVWTSubuX8MPE+5jqx0TS45yQ8qNUrfi1VxBDpMs?=
 =?us-ascii?Q?9Em2uZc5UwzGm7E0VDP3C/BGLlxA5n5Gh9sDA9mhJjJ0N6D1ek+MXAHVSqnY?=
 =?us-ascii?Q?FubxhpeBUe7RSKR//wbL/8sNU/BnTMmsnqh12dkNOSFOhSPi5z3kcouckXB2?=
 =?us-ascii?Q?h3YbgZW/eqA4S6NNmtWmcT59EzjiCC/2eBIkvj+3rzhrteswJkfvE7sbntau?=
 =?us-ascii?Q?noM87bCNZTnDwyKl2+YqiJiKc+d6IMl7VkXws0R5PAEe7pmhz2ULZMtQZp9Z?=
 =?us-ascii?Q?enYfb84V2QUYm+vIs0ZzeM5ZjIEcAmAvYSblkY2WXbehr5VTiVi5+vQZJ4/P?=
 =?us-ascii?Q?jFYYHaAzgpuB13YhtgMkmuSGxk9Z4jMbOaFYT/n8euOaCuawdZxDbhRPidqd?=
 =?us-ascii?Q?0QrvZ+l+t8gQJGzzPxYMjR9zo50BQGUoZuoKKcQwzPzIklfBD5j3w5NVmtRD?=
 =?us-ascii?Q?456K12gIvhVjsd0K7p40EwpM2SLv/SQwtljx2QyIde3+nsoIxMze7lmf2MnA?=
 =?us-ascii?Q?ysFSBzyN22cC/KSvTGYr6jitvsSma+npUvf68PzQTFUeI8xw0yJLLOKGzqnj?=
 =?us-ascii?Q?APJUmMeGPQcPlAeCcJ/+MDJgOYvDpwHXRCUao5BviQii+SEvK/UYrvYCLbnT?=
 =?us-ascii?Q?wKKnanc7XNaEQI9m9UsyqWZmKJSSbJCl/FvZAktIqSiCJ1mbl64UMxRsZ6V4?=
 =?us-ascii?Q?6hEy+fyw6rOtoowxOMSEOzRH08N+94AMqj2JVopD2hS9o5b7R/xCBPozR0SE?=
 =?us-ascii?Q?aGyLnfVfB8CK1xEKxB2C/LXcR/8R/QSgZx7tYs+IvVn+9JQwNLc3n4MZJ938?=
 =?us-ascii?Q?A010XXG+m9ay5PQ9ZznwRyCrL3ZabBOod5Z/lO5gI97CAnFr0w7vhsRAveM/?=
 =?us-ascii?Q?DTysYeJGNNTs/1YYJKIA/yog6BcMzg9J5W5ProIKE6xWLDL/6NUAyDoXldr4?=
 =?us-ascii?Q?84LeEKCT+HpyfT0pjn3hyntjTMK2EINmYyXfQVcvYo7NYJx/R1yqG55LfIGf?=
 =?us-ascii?Q?xzlQxLNlNIDbXwjpbllELQLM8/XGIeBXuWlNQo2v4nYiLd/EeAZaqP/o3c1U?=
 =?us-ascii?Q?PUHZEzrjunalhtsgBMjoeZfUlPNkJ8dETWVn+AXnJjZRFLabdl5X+BpFUX9T?=
 =?us-ascii?Q?uyJGbYdt08ys8J9YUCF7d4eBM855N0744Ndx3zFY9nL3cCFuheSsGGx9KkP9?=
 =?us-ascii?Q?IDog+jklXiYHyjCa/f8PMkXA1mh4ZkJlZKeZmtoNpjY8bwzPtvnOeaNVrq7V?=
 =?us-ascii?Q?A1nHjh7fkzyyN/ctjOso4+kJ9Nmmys5WV6/n2x1ghrDeaxayNa221H/Z8CBS?=
 =?us-ascii?Q?iC9GH9chvksKhbAXrHQE/U+dAna0xiLLDTYPMZTF/Ysts74iSlfU4RlnJm4W?=
 =?us-ascii?Q?rESpWavMZaLBPfUIDYP6IPGixUVEwzg6jOlI11p8Tk+3xTTwyRMW7qSXWSN3?=
 =?us-ascii?Q?tor72NulXA2UnNiQzmk0BfvrqOHhSYbvCUrbs5hJMoDcbDFUzzN3KMycCi5J?=
 =?us-ascii?Q?b+tO93fEk+qniSgMsmzxMOQS4x/gk37zvqyp/wbrjGRB3MXKVw2BRN0dfuld?=
 =?us-ascii?Q?NgZ7E+70Hg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Mb/B26bAQx6f0tvDUT+TR0RPGFTfOUZ86s07sxbBt1+1cGZBtToGr0TqcXXcnfGaziFd+1X8Oq/5ZQCYz/41qMrgHTZQi/6gds5nwAoF4eOBKrcmt5E9D1WBLj/6HatH7gaSR4iFbyI/vODfjFJHxWOkL8pSja1cuKnekxRYU26qSTpGWPuLil7T6sBddWz4BvcOJmF+Zi9Ow/atv57sNLiBtEp+eGhKHssfKAmcXw1d0k0RVeJqNJQ2RKCC9PqASQ/nJb4hQOWjxs/FjD7B2Jw+k1Sg0pd8D0qeeH6JbCgjn+qVkiS2iRYyoenpDNN7i/blzzWzmLvVtvyQDlgk5g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26830d7c-1c1f-4071-704c-08deb646920f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 08:05:34.7337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: usFCmAWmHkQMJZjfewmfP3YmdvsmQzNkK5ntXmDp2VTOePjJuZ12EuS5cBTSc0tbS6oKBuibmXH5Uuey7tR7v/w0MZabf/zTWVU6e/nragQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6760
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289819-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafal.romanowski@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 52BF05897A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
ose
> Ignacio Tornos Martinez
> Sent: Wednesday, April 29, 2026 12:24 PM
> To: netdev@vger.kernel.org
> Cc: intel-wired-lan@lists.osuosl.org; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Keller, Jacob E <jacob.e.keller@intel.co=
m>;
> horms@kernel.org; jesse.brandeburg@intel.com; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; Jose Ignacio Tornos Martinez
> <jtornosm@redhat.com>
> Subject: [Intel-wired-lan] [PATCH net v5 4/4] ice: skip unnecessary VF re=
set when
> setting trust
>=20
> Similar to the i40e fix, ice_set_vf_trust() unconditionally calls
> ice_reset_vf() when the trust setting changes. While the delay is smaller=
 than
> i40e this reset is still unnecessary in most cases.
>=20
> Additionally, the original code has a race condition: it deletes MAC LLDP=
 filters
> BEFORE resetting the VF. During this deletion, the VF is still ACTIVE and=
 can add
> new MAC LLDP filters concurrently, potentially corrupting the filter list=
.
>=20
> When granting trust, no reset is needed - we can just set the capability =
flag to
> allow privileged operations.
>=20
> When revoking trust, we only need to reset (conservative approach) if the=
 VF has
> actually configured advanced features that require cleanup (MAC LLDP filt=
ers,
> promiscuous mode). For VFs in a clean state, we can safely change the tru=
st
> setting without the disruptive reset.
>=20
> When we do reset (MAC LLDP case), we fix the race condition by resetting =
first to
> clear VF state (which blocks new MAC LLDP filter additions), then delete =
existing
> filters safely. During cleanup, vf->trusted remains true so
> ice_vf_is_lldp_ena() works properly. Only after cleanup do we set
> vf->trusted =3D false.
>=20
> When we don't reset, we manually handle capability flag via helper functi=
on,
> eliminating the delay.
>=20
> Fixes: 2296345416b0 ("ice: receive LLDP on trusted VFs")
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
> v5 Address the comments from Aleksandr Loktionov:
>    - Error handling when ice_setup_vf_trust is called is not necessary
>      because ice_vf_clear_all_promisc_modes is not used due to the
>      conservative approach to solve AI tool review concerns
>    - kdoc should end with '*/' not '**/' (new function)
>    Address AI review (sashiko.dev) from Simon Horman:
>    - Adopt a conservative approach checking multiple conditions before
>      skipping reset: MAC LLDP filters, promiscuous mode
>    - Simplify helper function to only handle capability flag
>    - No need to export ice_vf_clear_all_promisc_modes
> v4: https://lore.kernel.org/all/20260423130405.139568-5-
> jtornosm@redhat.com/
>=20
>  drivers/net/ethernet/intel/ice/ice_sriov.c | 33 +++++++++++++++++++---
>  1 file changed, 29 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
> b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index 7e00e091756d..3c64ed1b41a8 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -1364,6 +1364,23 @@ int ice_set_vf_mac(struct net_device *netdev, int
> vf_id, u8 *mac)
>  	return __ice_set_vf_mac(ice_netdev_to_pf(netdev), vf_id, mac);  }
>=20
> +/**
> + * ice_setup_vf_trust - Enable/disable VF trust mode without reset
> + * @vf: VF to configure
> + * @setting: trust setting
> + *
> + * Update VF flags when changing trust without performing a VF reset.
> + * This is only called when it's safe to skip the reset (VF has no
> +advanced
> + * features configured that need cleanup).
> + */
> +static void ice_setup_vf_trust(struct ice_vf *vf, bool setting) {
> +	if (setting)
> +		set_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
> +	else
> +		clear_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps); }
> +
>  /**
>   * ice_set_vf_trust
>   * @netdev: network interface device structure @@ -1399,11 +1416,19 @@ i=
nt
> ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)
>=20
>  	mutex_lock(&vf->cfg_lock);
>=20
> -	while (!trusted && vf->num_mac_lldp)
> -		ice_vf_update_mac_lldp_num(vf, ice_get_vf_vsi(vf), false);
> -
> +	/* Reset only if revoking trust and VF has advanced features configured
> */
> +	if (!trusted &&
> +	    (vf->num_mac_lldp > 0 ||
> +	     test_bit(ICE_VF_STATE_UC_PROMISC, vf->vf_states) ||
> +	     test_bit(ICE_VF_STATE_MC_PROMISC, vf->vf_states))) {
> +		ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
> +		while (vf->num_mac_lldp)
> +			ice_vf_update_mac_lldp_num(vf, ice_get_vf_vsi(vf),
> false);
> +	} else {
> +		ice_setup_vf_trust(vf, trusted);
> +	}
>  	vf->trusted =3D trusted;
> -	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
> +
>  	dev_info(ice_pf_to_dev(pf), "VF %u is now %strusted\n",
>  		 vf_id, trusted ? "" : "un");
>=20
> --
> 2.53.0

Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>


