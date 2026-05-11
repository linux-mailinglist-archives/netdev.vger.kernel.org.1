Return-Path: <netdev+bounces-286512-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIFfIMGTAWrsegEAu9opvQ
	(envelope-from <netdev+bounces-286512-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:30:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E06F850A1DD
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E4A53038C73
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C222DAFD7;
	Mon, 11 May 2026 08:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ahj+J2Gs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59203B776F
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 08:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778487800; cv=fail; b=VCL2HxEG2wLo5asjvr0Y+M8hrxlZWjIE4RRS4PpekAOWmzHBrL7ipQaBjJGRB5LH02w0EMpPGmR2ieOalbzZa1BFy4R1DiFYpItlMCxgl9fPy02GBhzHypeVFW8buWSCVVOv2nMipR6kAtwz0ZdU0qUz1T6A2a12bM6ZRf6xcoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778487800; c=relaxed/simple;
	bh=fc2tO/W7+cOxaAJ2WSaExKZaxKf9ppJMEhJvc8b/Kow=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W4XRU+EH6yjdZTjRuMkuDIHIoNySSxix1/wa3FZguyrygJhqG+FDfxSioEjiJ6QL018PX04B7Ab3D+nkpzvSzl7UIlGsrY7s7mRqFIHtuFc4b/G62xSlc6/wZIRh6c9tbJD37Sg2EP0pUkAtLEYQNdsBcB8YAH9HlwGtqzyXGhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ahj+J2Gs; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778487793; x=1810023793;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fc2tO/W7+cOxaAJ2WSaExKZaxKf9ppJMEhJvc8b/Kow=;
  b=Ahj+J2Gs8QFfS/D7krQW2OGEyHNHF6R1IdKpUG2/GjhbmMSEAPBVOHZ7
   zP+lUbcnjpAIDIuot/mHe47nNGfPP1Cd9rzc/L34twgUuGd71g/r0XN14
   r84csXaBQo3UD6hO7oKzf1IJK2alAcLN7e9G+oPO+jPoXOPcIly8oE2iQ
   D8QTW12YO6r7fNYCwj6dlINMOZYQy5lygjUuXGVr3cLyqDq/c8tbQbMqB
   AqEDUMrl8CEL7Vjh4/9/pZGMPLqV1TE0FhMYG5tUjglJr4+9YVJ8OQFaF
   ZUgW8NxiBRBEgRE2yOimOGveE85b14RYSxFuAIVp+ck3bta2vjz3acK3r
   w==;
X-CSE-ConnectionGUID: XjFKO9imRQG+79avTdzHVQ==
X-CSE-MsgGUID: +6mcrCKGQZeOlGj2t9iL8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="89952558"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="89952558"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 01:23:07 -0700
X-CSE-ConnectionGUID: n2VgnICgT4ud6BGiUrhNaQ==
X-CSE-MsgGUID: brd4XA6+TOyLgdI0dHkWsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="232906163"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 01:23:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 01:23:06 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 11 May 2026 01:23:06 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.37) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 01:23:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AxQLZdMButNPxm9y05qExuFvAdjfaJa+eLoFLsISObGO0EAP3gH5per9+EMYPWEexTRfr/eOda4545dYYZcN23QCxY5m6rE9RjvIbs4SvhEgOmQnKkJvldxl5m3ChcqiN7MbFj+a/oxftnltNPHYARUaPsbJOgcX+w/3NxZrPd/OIH94i08abzG9mSshXpa1fu400wiHjse6k1kUxzc4UlHpAC7bxa46HYaX5DvyBOobXJmPyx9ig94K5j9EgfYdUhTzra2IZM3O+PEU6/eAWkFVx8ayB61DqbIO9qeAcM/0KLx+KAMmzX/Mc7HwvEw2TD0XjoKTSTWnXE1f7LVbdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fc2tO/W7+cOxaAJ2WSaExKZaxKf9ppJMEhJvc8b/Kow=;
 b=L9rr5NBsEZdP1jFX/50dfxzWaYZIKtgIQqvyXImWpfu7NHsuM3uIozcf4pSoBfmsWDFL5iyQa2J7gAxxpVSEOWyz46+UaFLEV548OhofReWOzdAb2zcc4Vvl7upiFp1t9AAHi3seI+CG/hKfm9XYG09qb/AjKjONIBSyyyzRigtgv1vcWjUmlcsY7Z6V+NO3he+gL+wH4wsAsvoQj0p5AOdZDthuXEDcCHfar6+7gUYhN73QcgoGVxbIuZtIGWMl3oYR0uHDDSRvGsbXiKRA2weATehiSR+XvV/zk0gCYxx04FOY4UumUhXVQSNg4dsmR6wydWPRt5ctL4IJQlpk+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by CH2PR11MB8816.namprd11.prod.outlook.com (2603:10b6:610:285::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 08:23:04 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%6]) with mapi id 15.20.9891.019; Mon, 11 May 2026
 08:23:04 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Simon Horman <horms@kernel.org>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Kiran Patil <kiran.patil@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net 5/5] iavf: return 0 when TC
 flower filter not found after qdisc teardown
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net 5/5] iavf: return 0 when TC
 flower filter not found after qdisc teardown
Thread-Index: AQHcyxeGkq5hOcJbGU+fsqOPo3AIlbXgKDqAgCiAUNA=
Date: Mon, 11 May 2026 08:23:04 +0000
Message-ID: <IA3PR11MB8985BC9EE7E5ABAB7D90A8658F382@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20260413073035.4082204-1-aleksandr.loktionov@intel.com>
 <20260413073035.4082204-6-aleksandr.loktionov@intel.com>
 <20260415135315.GK772670@horms.kernel.org>
In-Reply-To: <20260415135315.GK772670@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|CH2PR11MB8816:EE_
x-ms-office365-filtering-correlation-id: b9123342-23de-40d4-c650-08deaf368601
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|38070700021|56012099003;
x-microsoft-antispam-message-info: Gbuab34+9cEQN2DpkG1GWw+iEfPyelwxS9dgG9hmu/sc1J7FNRZfdLrvNWuc7PCgD2MXh1F6xKn/wVfEnSF6rOfzcMMlHkgFqulnSoKJLBGVbXXP7uNP5xMK+N9euZniWSPFEP7ceKQ7g+gDDyilgFpGZPa0rrBd2NxT8V+lK/hgyIDkk0PS8yNq2YtkKY74QdUfw6SpSC32HbmxyHkaseQwCL1VbnrvO4M36HCy/AZygA4rU0bYTDZbuHAb9Y6Y/bwItuDdlyB0TMcxpPkhZkng91WNSUoAwSYYeiShb2hYdUQhxEAzsu35jtnDRAkkz36EI7kx5ieHeZCYosm7Uzcyga520jsiKn64QAm6H++DFhQF86zPBAEI7Uvy7yIYJY5Y+QF5p+CjdRh4/NOzT6QFahttSGcBs9zXHzYI92ZlGhcexwWpSACxDOMvKpQnOuuOeRdnU4fYozvGEN5euYRHSGePOc03vcroBH5qXXCCBREl/X8dUSrkKlZAVyntSXTKTCa84F5RjmpwWa46zy/CagNcPSFsHpgVAfv13qDfm/Pwjw+/jxmSX7ex+1K9AioIc1dZl5Ae5KaldVqhGgbuLbGwU+csnb42crVZ2akOjLOFHLDXQ8N+ZfRxoN9+bSOt7OU1lrVAj+OBuBFonQFvkRJFbhecIN8G/QuD7Jha5jy36/1TJVOYX6ofMyMAmMI9XcwgjR3K7U8QqeLkDpO4s7Qv785sZIy7kUKi4PDZq245yxLZi5rHzKvU5Hts
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(38070700021)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8tqW6sCLQYVSW/Yp3Z/HQUnN2q3hn/Bt40tjLLfZ6zONspTdxTmcSOcUJiRt?=
 =?us-ascii?Q?21bfcjffX/UN54yrCpf4M0fly01lzTFFY5U+lAK8rFcqayph9eMOQ5jqnabW?=
 =?us-ascii?Q?3zIcyjp5atA8VKcCsAUZh+Dsr3GhVwsiRnZGVPx37RQPB65bsrn3e0Qsmx0h?=
 =?us-ascii?Q?5AJb9Tu9SZpHF0Sdz17lPL9YQWVR3pah5XPEQVQU6O9GyVWnzTj2ajA8O+Rt?=
 =?us-ascii?Q?c3cBAGET7ZdB6SoNBz2y+nz0q19I6ZCkAeuX6SVT6zpHRuF1q4o/Lv/Pk+1X?=
 =?us-ascii?Q?bA/MW0DRVJyYjeTt5Gtibxj/xYtAhIfZPHtjS9CLaoB0EjqW9H3u2sjzqh7A?=
 =?us-ascii?Q?WbGIeep2xxxu3tiNqlf/tVIeqk8NhdEs+6rvq5azV6pDxSA/1L8LKiN6Pole?=
 =?us-ascii?Q?xbwCO964kEaPyS9voPJ/Cz9BCWglnu3eGH2+wvxKJiqKUdIJcVdsbdE9Z/Kc?=
 =?us-ascii?Q?uD3J/acaADNaSH1VoXEq6ExIYwzxBArDO7qp/qOETxIrU1eSTxefWeyWx0c1?=
 =?us-ascii?Q?JnZNT00jSl1nIUs85Z1EZsQkpP4O1a/fWiRqKkqEkVuToyuKdt9EKaPrd9SH?=
 =?us-ascii?Q?uMveSaK5GsOv0+VnViX7yBuBTeJmCRnz0AFx7TAGMj/HzSgg2+j9egru7WfD?=
 =?us-ascii?Q?6dgS5wfjGeNS6WhOclDGrB3bfkXnlmi41eLSqRoquNfXx5IVutPcWhrEOLge?=
 =?us-ascii?Q?ymSKVfCnStU9go/RMAwW3s/ayneT45/OQhYEZ0Nx6s6dy22IrUstKix/e7/Y?=
 =?us-ascii?Q?pNA3fvHj1B9Ew8VgZN7Vni2WLRjJTqw1SsthRi9E5b4VG2e2eCXYdP4LNBfh?=
 =?us-ascii?Q?znDfwRL5mkoCOYll9Bo7fWO6dVig62RGcIxADamvhAwhDW7e9gE/1E4yu8yd?=
 =?us-ascii?Q?nI/QbhgJM1lPD64cJi6JA+WKOntNIsFajpS+IUijFmFZYLjLDtOXz0K1qcGl?=
 =?us-ascii?Q?hgYUSeq2uVkAtYiIrSSgzaOIi6VoCT55S9gllV/K0wGwDoKXiRxzIiNTgF8d?=
 =?us-ascii?Q?sgR8cwKr354JlA38To9kDXHBlIVGCAx/JJoDGJb3ddpOL3IovjN30dbPeeOy?=
 =?us-ascii?Q?txcVnKNaR2xvhY633G7pEjbGt2PURCtUusazf95OMIneI67+Xd6PjWKhcaxa?=
 =?us-ascii?Q?3R6FXVHwaDELfkmHodian+e1M1IskpEB08s2v6o7DpvysIDm0j1H+/b0nQI6?=
 =?us-ascii?Q?nqkPJHxq7vRyWp/zwV9IDsMz6qAm5kWBa8SPjl85BYwAx22+FJs2EPgr8wv7?=
 =?us-ascii?Q?ycEClA3MoDKFOdxWE9DM5lYmNNYfQAf4mFZrq3U59poC0qa4i7i0HiFFvm61?=
 =?us-ascii?Q?v1Dvd+dwaTbKXLIj8otqu+zRO5GDO2KIJEtxw7AXrLTa6RM77ztfUcRT6+SS?=
 =?us-ascii?Q?dkPHtBZfm5X7Uc54MBar2qMeiD9a7yeKLUEezG3GMMmrr7nNwV5Hux3w94hW?=
 =?us-ascii?Q?byVYJDzCKpJnEqs0xb+ClOckl2X5uM2xcVkHWuLdInS0pRV1IyCECSxKP+4w?=
 =?us-ascii?Q?wlvogbDg6n8nsyseQzZlv9bUZZpfFuTpGt9q4q9yjIDsSmKLCbIX41Cv8qYi?=
 =?us-ascii?Q?/9KKnFqK7svjR639b1EWocr+1ZaY3UrAtuCWoc6P2MSNP6bM6a4yYAH1T9lY?=
 =?us-ascii?Q?Lpy97omZo3B2qDWU85TJciijVQ/iGHEjfwGSzYuErSfqfwyTP1BiP8HOBila?=
 =?us-ascii?Q?MqHTsMHowafQTtfUKT/ILeka+i27igi1FCafYTa71+BqutxYrN6Nxs296v/K?=
 =?us-ascii?Q?2MfjMgMtxg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HDDZDD5BWiWAKOCUzN+Vll+LIepwxDQQGf51GIXHdT52Cnapq66HlgrEkbY/YoHymHqgj9dwdJuaMVpu1qc0ycczGaMoHaCzwO+b0k6rtHIu9ywibd+H9c1q095Sfh4E/lGPBX8lW9nCNEBGcOJutTZf1gmim4n/kUEPWbSeTwJ1deTcchM9cFs7qm1nMrzqPc33A4zHSpFC9u6kIqOJlmVAmZyR50cnqDYCovSM0375N5nV0K+3nBDDZHe8IVFIPvW3WugcZj8wiDQrj6/mk8qS3ElLSq54ajuy8u3rStM6kEvHkGzGAgZCkatBD7JHbVQXToBZQa7sG10hgN+xpw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9123342-23de-40d4-c650-08deaf368601
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 08:23:04.4193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vixImgp5LqiDhy0QKLNxdabGMcPEFtZSWyqijTBkX+v9lQY861T30n5bBJYPd2sjy6MEvYhWMd9tP/kmgKQRslL8Tbi5DXyYGCcoCu1hjoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8816
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: E06F850A1DD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286512-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[IA3PR11MB8985.namprd11.prod.outlook.com:mid,osuosl.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafal.romanowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of S=
imon
> Horman
> Sent: Wednesday, April 15, 2026 3:53 PM
> To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; netdev@vger.kernel.org; Kiran Patil
> <kiran.patil@intel.com>
> Subject: Re: [Intel-wired-lan] [PATCH iwl-net 5/5] iavf: return 0 when TC=
 flower
> filter not found after qdisc teardown
>=20
> On Mon, Apr 13, 2026 at 09:30:35AM +0200, Aleksandr Loktionov wrote:
> > From: Kiran Patil <kiran.patil@intel.com>
> >
> > When an egress qdisc is destroyed, the driver proactively deletes all
> > associated cloud filters to prevent stale hardware state, decrementing
> > num_cloud_filters to zero in the process.
> >
> > The kernel netdev layer is unaware of this implicit cleanup and may
> > still try to delete the same filters individually. If the filter is
> > not found in the driver's list and num_cloud_filters is already zero,
> > return 0 instead of -EINVAL to avoid confusing upper layers that
> > believe the filter is still offloaded in hardware.
> >
> > Fixes: 0075fa0fadd0 ("i40evf: Add support to apply cloud filters")
> > Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> > Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>
>=20
> Sashiko has some comments on this function - which do not seem related to=
 the
> logic this patch touches.
>=20
> I'd encourage you to take a look at some point as a follow-up activity.
>=20
> ...

Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>


