Return-Path: <netdev+bounces-284204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MP1SNJt6+Wnz8wIAu9opvQ
	(envelope-from <netdev+bounces-284204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 07:05:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0464C6B07
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 07:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 400893041238
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 05:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107ED35F179;
	Tue,  5 May 2026 05:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mQDVOkoU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C211C8604
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 05:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957307; cv=fail; b=OhSQz4ISIS9co3yD1xUC/M6fzcAYXrV3r3nrcG4xCySQ7t259ag4mNoNEa/Fa8iLbAXpk+XoDCRExROovKnJcMGR9SyiGzL+pR8uesQ0pcyG44ipYnkYDHVSXkKrArzGRg8VfQ7oHYKrCAog+tvPA9dHTlKhPMNNTjtaoeZzj0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957307; c=relaxed/simple;
	bh=7dsKQ7ZBpXCOWHb7R9MyII9y9rVPI9ZfmJ+2IP+r0F8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aiMw8V2XQjSl4i3/5amplwy4MXIlsMK9dPn8YREHsgmhDkBWuvoCUycTw0IeJjDXmwCt0U9F4njY8RHXWPlQx/msZwXoKBJMva9UTMfSF+I23N0cxSmYkYQyMJVKW1JglryRKrAfpU6n9ualrMpILRue0oan+mRtJCr3L3YD0sE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mQDVOkoU; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777957306; x=1809493306;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7dsKQ7ZBpXCOWHb7R9MyII9y9rVPI9ZfmJ+2IP+r0F8=;
  b=mQDVOkoUiiCyxppmeo0kAzUytUhVS0GdXa/MHIcCwOwxczDhjJchW+rE
   OrsgoxCrzqgKDNedGVkCtKGhpwsM6KNh0QypsZGyGzZ6kGtuK2v6f4p5H
   ughGupfVYqtMb+XG6slsx19yjjUtdeSt99g9YMjcZkJzSCk2H5ZzBjRJB
   gjObhQ3Y24q8uTOnT7LsHfFVlr5epOxdsqpqua0i0RNI8K3EPjhmoqKz2
   UVWHRQZxpVGsnyUHx+WDJtXWzYKeiomSzurhZP74qmciV4nocUTIsO6eu
   VVfyszKsdJuWzB129344+SZ83TSqRqw5Ih3INOmF6Gv8Xy5Y7xNUlll8W
   Q==;
X-CSE-ConnectionGUID: +Ypi1cUcTEGh655JYxmqJg==
X-CSE-MsgGUID: PHovMes1QJCbK3s+1aOJWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78919739"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="78919739"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 22:01:45 -0700
X-CSE-ConnectionGUID: PVeYPPeiQgScUogPl4H4Mw==
X-CSE-MsgGUID: ASY1/+KnTxeh5rNmu+69/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="259374441"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 22:01:45 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 4 May 2026 22:01:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 4 May 2026 22:01:44 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.55) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 4 May 2026 22:01:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVb4xD1VJUKqn5ePVWYpz0MMdGdVqIyroAFy5Fr4pNndvHbQFzNooGiPW8yoGLAsFAbjRmnklIM7zTU5oocsG0CDmZiuhYgeViu8c1nc5zlJEw5iuDBD/Yd5/oO45hij0zEx7yDWBLd1keIhazOaLnKvbW7QBDG/pG7gtCN3yc0JFU7a1sl5n3uCBbW/0Vhg4u7+xR2XaAlAr0T6NqglFOeLYjOl4lZaFg4wrXpkIovoGcTzMsqqq0JbDnBTOECwaAqP+d4uSVQbbeE467J8cOj8q9xTeap1IHCws/qUETJfrKoylLUr5oe6VLBCmkXFSYxWiKwE/xjN1meM+ukL/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7dsKQ7ZBpXCOWHb7R9MyII9y9rVPI9ZfmJ+2IP+r0F8=;
 b=UkUNlSrUjEHWVVoF8NbRalInktO1cGlll4A0KqypTHt8rrsIIsz+F3Lre7I1btCmkJNSEbVa1F6BV6BX5gyENzaC1pqhUVqCFEKiVLAqHJt+f7ZwsPmp4dyEdP08pU9hriEmJXQnqriYfmnSFzLtyOa8NQ3KXwRp52PKZdJoY/Lvd72hP/pIXrnuUOHe6a72tuj3xAcEY2TKZ8icEKWXqKgOBgy0GSKgcL39rL9nbKo4OwbWNlXDT4tGIWP39n4ytWKsGPkKVftghEunVP2fSwrJ/3cpu8ajSw9fIu722YsTLtxGfOkqxGICir4lBiyGQaUUjfPO44MF92mfDykChw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by SAVPR11MB9551.namprd11.prod.outlook.com (2603:10b6:806:4e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 05:01:41 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 05:01:40 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Szycik, Marcin"
	<marcin.szycik@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH net] ice: fix setting promisc mode while
 adding VID filter
Thread-Topic: [Intel-wired-lan] [PATCH net] ice: fix setting promisc mode
 while adding VID filter
Thread-Index: AQHcvbqxqUmv2LlcjkqkKIm8d8wZarX/Guyg
Date: Tue, 5 May 2026 05:01:40 +0000
Message-ID: <IA1PR11MB6241D9DF8B2100C4F88147258B3E2@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
 <20260327072332.130320-5-aleksandr.loktionov@intel.com>
In-Reply-To: <20260327072332.130320-5-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|SAVPR11MB9551:EE_
x-ms-office365-filtering-correlation-id: d18dd223-a375-4d6a-4895-08deaa63652a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: KxolF0FhMHtrlk3ffD0WY91r62oEvF0JkUrimSleRxmnDRWOYKY5x0ffg65BXyWAbDePb5ePuwPvOcQHXqfMkRPe6A3ZWg13jiChu2u+0iih2hfAEq8VC08u6rh+poNVZa4zhudFSMPzC/usrfStVnx228GHt4/McVaZmFz4KRwF65C8y091ryvEskFT4LTnlD2TixUpolHYXAhNRrGGVD5ctOD7DreHuiB44gBmpZ/PEV7IgXhqKCgS7hSyt2I8ZF5BUC5JxuRZdI+6VpNDiQVkMKUCqxqnr328/8eRf+cHeMKk1j+kwaPKRRmVjBKdDEPA1gwT1WzaObX+ER2wPeBbNrAdk5ujSmHs5rZpm/KIjETvKiUiE4BkSD0xuhzF7d//88rGlGg8ReLNndM1E9SMGZnD5GXptNw0B9eW8+TDwW9x+LQo1q9jpni06B55RGmgp89MbHejjmcla6iFStwPfWai8gPusMOc5HlEQk5FqBaaisvnYCpNQ4Nj93U8H16NTFlHF0AWQCbb4nKr0FxmhW/loypj+mdiKCkgPgamr3b6KYxw/HuCGgC4Fe1Vetswz2y/zv6Llk/m+5z9kA1xK7g8/PpjlC9DlauK+mmvCH5p8yN7u+Gkwf3YKvctUaOBONDhYD1Bf577zKVqMvzDVQVo6YOAsVGYncEyjOBjT6CbKxUesorIuKdlFe0z2vTXGr6EVQJj5MG5ynXBlSEMV/TZ0nAj0ACjHF+dGdSd4pHSSDgebojFodq4zQja
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Es1iuKhiC70GsJb+rCYcewsHVHuB/JYmsv9O8kJ6WbKcj6pztrHihP4Dfiym?=
 =?us-ascii?Q?vtuSmbaBJR5/qEnvhKxfhTRaIF6Q/TQxii0G5M4hrA2TEVa7qMGeK9IC49UC?=
 =?us-ascii?Q?dEwhsHxHwXgzdesuMnArZvPsoyRRc3/38q8PS4vKYFB9pCUL/uryB+kf/B+8?=
 =?us-ascii?Q?fzAo7DSDvY/RWWSIjFqscpGZLx1/m9+05MbIPqmuVA+yTm/rSFkVkbW0TC9u?=
 =?us-ascii?Q?0rtqJmNvG9WO7mwXOwQyQs+hXa/jVlqEPjsup0dEOA7EJ7Zd1X6CAxSoRtpa?=
 =?us-ascii?Q?0Ieu2eIT/QOfB8lOU4L3AlttI3P6WiXhC23mHxiA/xCmrdqe9Dw5qyqNe1se?=
 =?us-ascii?Q?6b62PKiSEbFe3uIQYywWdUrcFb1TNvEHNkpjFsan3xIbUtWzwWi5UudNqqRW?=
 =?us-ascii?Q?rfDxIg5gFu96QnEksslL4K4JnYU4J0u6q2Tw8DKpAGz8mwXa+lN/EIhfLALB?=
 =?us-ascii?Q?vqK8dABfNUw+5iG+CEX5eMZShCBYs5GPyp1BLRo7903TA39sOCO43B4CQeoa?=
 =?us-ascii?Q?avOTnAnlYq8HWnzYEHTusXV56juf1sLCRfT2VH5j5xMAsA1TOwYKwEJPc4gQ?=
 =?us-ascii?Q?EG5SzwaztkmU3TMF3tnSMcg/w2mawdgs0iLDMyak5+rbs0IDNL+uEEkTxG0m?=
 =?us-ascii?Q?VUtIEFo05JTyXV/8wcXQg327m6maGuMIMuIfeTzMBvuEAQLuCxNUHM3Vm2aJ?=
 =?us-ascii?Q?cIFeCz6snP607OLe4bTLX+whDaiVgJKO9ibHvhpJ63rHetFD5B4ofcdhBgPk?=
 =?us-ascii?Q?J7JcUu5zIVTxekxvnNqQ1+T9sucQC/nF+eF/mAGTZanNd+eFZKR7vQZh1XcZ?=
 =?us-ascii?Q?dNLqdFzVCswmoIriUjyRQBYdOpE/u5C6E+UErgYF2VWZkWRaac1wHtPK628d?=
 =?us-ascii?Q?zKPmxLdgisB2juSwz8DSPorYF/wAqXKHTCPm+a6w/6Xdp4DVJTy3caBFwlfN?=
 =?us-ascii?Q?Zd+GDGI+ura0DymxEGbqVOmAQg7FXOov/h1cv0nnZ5Z9nA/q0pTq5yeR2IIY?=
 =?us-ascii?Q?Vn0K9gYN/VwG2hsehMelTrY2c1AyqxMjJkjigOJwK4BTlhXTzyXE7fLZ6e0f?=
 =?us-ascii?Q?XFbtoDdE9sy7xYmI4SwZmqr0C9Ph71E8C2r6UshBUIMCLxNxEYBGMQ62w3kb?=
 =?us-ascii?Q?wiamYDyh+CrvQtfUvYCZ+zihJUUOCbqWdXEcd1oEMSlodPxcMwt4qwdCxfA3?=
 =?us-ascii?Q?rxlTIGCditEb59Gs0JrIMwIVz/YvuPn58RG67EgatT7wU2RSqaJPLdARO3CH?=
 =?us-ascii?Q?0jvJIIcvZxlWu07sM64w4KWon2UBye8bSUF+TMm6unTTRPSU2Vn4qUHKx1zw?=
 =?us-ascii?Q?l2l1zmClgtw7ZD+x94o5SRk9eqtzh5zB6Ruq2/0PUAmiKjMlFn6Edp5yWipd?=
 =?us-ascii?Q?v9ujDQ1TzkKHxdX2RX5tUA8PS1phcCRwbGpHPomZBwUO/emyMt0SW+CY+4Gc?=
 =?us-ascii?Q?dDCDmjj6EDjEMOzlA1OJLBIfuwWLhaVny3MwWLK0sb7HmXY7jvDhunWZGSv5?=
 =?us-ascii?Q?RWteqhYjn15/aQrD7bc5L1MZUZh0fUxmblqlfMoikI3FKZ9ozQDHTrpQZwe3?=
 =?us-ascii?Q?MuF4KYkQJ7PCNClY0JlDQhOcB5H/cg5L/rfA5W5C6hT8efh+WmPiFlYVj/Xf?=
 =?us-ascii?Q?frqEN1basUKs0b1PavF1o0/3Gs4C6x6EJgScWA0a1DrM9rhyvxjj8Xj8IjDt?=
 =?us-ascii?Q?atqJkd7+E7rdMJMD8AEBJCEwQ+80eYEpNAfHHALnjWPDN8UP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: B78OrDh/C89x4UQ0nzgZ69nbeHHPqoW2o+0JlY3wgajoaNliHWOstc8LwzK2eO5xAGB3V+H2ZmnACfR1ATTBP2p2ntvnUY5R0dKPhSSmpQTyK0U+pWdr86rI35W9izZ/ElA76pTpJ5GZL3Q299CsMqQEJFZkBdsavT1K3DSReXVARhLod4D7XGdTaILSMwtUovKcQoBy+untPUCUN3MpqpO9Lu1SHaxTWC6mMhGI69lDq75IJYf/8ge59vZY4x6xtsAzDNbPNjUiKXibHP1l5I7cLO7/pVrD5HQhRap7KzIorDsK4zCed83061jnJfIkUs+2uauDgZcTbhVS6s6iMQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d18dd223-a375-4d6a-4895-08deaa63652a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 05:01:40.8792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WVYrrq+kXpRtL6xuDOL45nhfpIRbIkCovpGGirw3gVYauzf0fg6kISnQj5YXlwOf3u/nQT1Nnzjl2mIOm1XwtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR11MB9551
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 4C0464C6B07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284204-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,intel.com:dkim,intel.com:email,IA1PR11MB6241.namprd11.prod.outlook.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
leksandr Loktionov
> Sent: 27 March 2026 12:53
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: netdev@vger.kernel.org; Szycik, Marcin <marcin.szycik@intel.com>
> Subject: [Intel-wired-lan] [PATCH net] ice: fix setting promisc mode whil=
e adding VID filter
>
> From: Marcin Szycik <marcin.szycik@intel.com>
>
> There are at least two paths through which VSI promiscuous mode can be in=
dependently configured via ice_fltr_set_vsi_promisc():
> - ice_vlan_rx_add_vid() (netdev op)
> - ice_service_task() -> ... -> ice_set_promisc()
>
> Both paths may try to program promiscuous mode concurrently. One such sce=
nario is:
>
> 1. Add ice netdev to bond
> 2. Add the bond netdev to bridge
> 3. ice netdev enters allmulticast mode (IFF_ALLMULTI) 4. Service task pro=
grams promisc mode filter 5. Bridge -> bond calls ice_vlan_rx_add_vid()
>
> Crucially, ice_vlan_rx_add_vid() fails if ice_fltr_set_vsi_promisc() retu=
rns any error, including -EEXIST. This causes VLAN filtering setup to fail =
on the bond interface. ice_set_promisc() already handles -EEXIST correctly.
>
> Fix by adding the same -EEXIST check to ice_vlan_rx_add_vid(): if the pro=
misc filter is already programmed, continue without returning error.
>
> Fixes: 1273f89578f2 ("ice: Fix broken IFF_ALLMULTI handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>
> drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

