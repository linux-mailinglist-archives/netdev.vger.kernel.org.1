Return-Path: <netdev+bounces-235166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1C4C2CD1A
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 16:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B590D4F94E9
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 15:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EB3314D34;
	Mon,  3 Nov 2025 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KeZt4ShV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D249F314D2B
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 15:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183724; cv=fail; b=WsdR82IFp8baURSzMKcgwYH9gmQerxjelS8cEvRQWwn81/qV6i795o7qnXjrOFivXp8u7ZxtQm6V8qEafORZDmbhcpWwvQRaDLuING6e6+HBQYuLVuyv/uxbgSzLCJeVP+DCWLO+70W96g1XtEtcZ+mLfx6oPWCfNDKAgZCmjaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183724; c=relaxed/simple;
	bh=ol3zpAtWHFWfXL6DlGOysg9lvvE40Oy3b2U+lfu7jOk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fcmPW0klvEPyGB51nWk04TEEz16Pm+By/1FhuvUqtBopIDJuE5lLIiXQIr0/km+mR2zNo28QQYOUnPgIXIi5zOihn0cHBQxT88cayVIgrC+XJ37fKot4Bya3ZWPvR8V3LRGtPQgrSJSSN+SgxK9MPZcG0TY1WQc9CsklW8bf/Es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KeZt4ShV; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762183723; x=1793719723;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ol3zpAtWHFWfXL6DlGOysg9lvvE40Oy3b2U+lfu7jOk=;
  b=KeZt4ShVIt/YoGvLlyqxqeuRDTR7q3bbNTqmdVfsc6h6qTGs8leXA+7K
   aW4rD/FUH1tzFDjrgjWd2s0pCfoArhfdNhdU1emCBBDPqXlO+MDaWoxWh
   kcSy5xKrRbZj5h7oDQr40BHoLActvGBK03CkDrAobfKT8QMh9BHGS5D3X
   fLTCo7kJnZXUzcfoixmIb4xtyzdxVXDFJ2ZF2rXB1VhsKORQdrOe2asE7
   IWRrJQDH3LZUFcXS2en5qrZkUFjuz87AfhY0RuZijgCtJLuecsAdzAbaq
   SlUO2f5g9FsDlCFT9Ng73hak7SmV1+DPMA1yhquPFNDKUkpFGKRq8iL2C
   Q==;
X-CSE-ConnectionGUID: 828yF59/S0mSArnZSjgfiQ==
X-CSE-MsgGUID: EmLXNWzUSyK7R/awJQYyXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="63274555"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="63274555"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 07:28:42 -0800
X-CSE-ConnectionGUID: iyFPFYChQn+i/yS8nvcsrw==
X-CSE-MsgGUID: NkATSaG9REWAYfEcK1076g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="224142642"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 07:28:42 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 07:28:41 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 07:28:41 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.2) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 07:28:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Au88/Az5nzPj3D7B/WE2IqEjvayBZRv/KBjbzN0mwbQU9M3qRzY24tsMl1rpgWQXXu5dU0nkCK0j2I2Ghi9bsrwxyHzsrAublMsgQlgbW+fuTToh1G1jtu6W3bWhxHehqqlrlIRQ0Hu2MVZaJt1VuqMP3Wdcuu5SyTFfqA7c33xEWqvSnVVeBHxrholylshfOVnkr9GinQbHHnjk8I0PaBv+5SpBcGzV0FDQA9mHoU65V9PvAyh6awV9uTkU0QsD6068R/pakZ99d6FlJJVkVK8lFKdoculWqTCP8Zabes9lSRVW3H7AshOxV3F7FEAa/DeDKySzWdBjZp3GZfb7tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ol3zpAtWHFWfXL6DlGOysg9lvvE40Oy3b2U+lfu7jOk=;
 b=axd49LMBvhmAWyDe1jmReghdSX8YrTTqczYQByWeQSUQDoOEqTT5BhjhxlIIIm77y8b6W8t2BPJ3SUuAiO5XY+csmydjPcxp1GRKMlhmftqVYe+KcncZY5Sxx7+itaZpMnQ8AIb8FsdbC5fpMo01XlooaFQwwuKq8W5t1qrDUYad1vGJCFf3E9i4yps/EH/Q8xOQ2xg/mXbzTXPZA2LKIbzMgwadJAwoHR3BWy6oxgZPqy5gY1Zf8gOUzw++qL+C4l9rCF2RssQhEFPr1YIS23KPgdYglcQZTDtGO1vzLjpaRt9Q/1sUl1UJCB2Af5i32Vl81QNDFDOmApGqc4PPkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by CY5PR11MB6211.namprd11.prod.outlook.com (2603:10b6:930:25::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 15:28:38 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 15:28:38 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Hay, Joshua A" <joshua.a.hay@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v9 08/10] idpf: generalize send
 virtchnl message API
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v9 08/10] idpf: generalize
 send virtchnl message API
Thread-Index: AQHcQuFX8lmytvB5xU+jgH7FMqJqxrThJl+A
Date: Mon, 3 Nov 2025 15:28:38 +0000
Message-ID: <SJ1PR11MB6297ADE2F43A33F2EE2999C79BC7A@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20251021233056.1320108-1-joshua.a.hay@intel.com>
 <20251021233056.1320108-9-joshua.a.hay@intel.com>
In-Reply-To: <20251021233056.1320108-9-joshua.a.hay@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|CY5PR11MB6211:EE_
x-ms-office365-filtering-correlation-id: e48b9108-e6aa-47c1-e2d2-08de1aeda985
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?SwBEVrDk97fusNY3P56oZcO34d7/eEcy/AOaC7WWqTNSYGXUMnKhzDhuN692?=
 =?us-ascii?Q?DE67/S4Tj8YI7NGTbnHevUKbQv++OGfbwwcoeUQRgk2GbCdKxLJ3CvQeFsTo?=
 =?us-ascii?Q?jH+QVzXv1XyPKAb7v8dIEMFPqUbPwJmFBwbBXj/fN78Kvt6H8dW61YWDvmlk?=
 =?us-ascii?Q?7JMwv1v4vDa1OZw+pFakXmmicXYgQesXTiGMDSC2+15crScHhKZS0TmgjUj8?=
 =?us-ascii?Q?bDbOWJBejec+PmhtpC4IQUBF2gRkE9lEaYtj6AnLUdzOE49uQ/aXLkq/syql?=
 =?us-ascii?Q?JF5WtMh8nuoy+ELTFJtC+/6aFHUSmzBzWI1F4YVcJMAOlPPoAbM/4iMAI7oB?=
 =?us-ascii?Q?+YU5kCJedd2ypV2QspJbrAUUuU8cmyc/kUhsu9pESi4h7oDUzhiB+nEqti09?=
 =?us-ascii?Q?lZMoH2fMTNEMijbPbsn2OAC78OaBjLtzh55bQSBvJeVsKBlzpF+bW7eXz52C?=
 =?us-ascii?Q?L5Cx77cmXeTVaB6stil2MX4C0fX2eVkSVsx5tl5kA2fP9hqJsgtlgIx06iLu?=
 =?us-ascii?Q?3AlFnp8xZZIK4CyuNuAuIq6jNuI3K6zW5+23sa6QLFY3ij5IyrErqXjFQCA6?=
 =?us-ascii?Q?OBpMav4BxnUD4/XYso0DusXpAMbNqfbwUvoQTqfR0mgvHHt+0VTY88wyukS2?=
 =?us-ascii?Q?cVRsQNObBp3CCe2onNiAB8Jf8fzdakUGO/zMeKwAt3k/I9Bw/MxkmB/uQzI8?=
 =?us-ascii?Q?rn82hBbyN7ZRt07ncm6XBVyN3b/30+A9H6pnUL72zkmYLwZMMW8llC20ovE4?=
 =?us-ascii?Q?wjzX1GyzCO7JGlcQukpR98N5R6t7jTDObTlqL+HMbVn6/ELfAg4n39UoqQnA?=
 =?us-ascii?Q?dlboeoEjxxzblc/5DvS2gtQ99UrAZ3GFH3f4RXLjxtD62DI/B5IFLghBT+jZ?=
 =?us-ascii?Q?VEQ999fzypM9FQ9tE14RM0TQvLTOVuLV/FNpJB8z9BIl+Gn2ohVzCAybnCfj?=
 =?us-ascii?Q?UL9B+eaNEY/HRGHKu0A2zICmSkjNiR2vp6NB4ej2SCzO0tYjPm0Lrcsotoho?=
 =?us-ascii?Q?rByUphri/Fc19lCWdab5LRIvsDnDk+sTQrosuR/8dJXa8yce5KGFiW6Dn/gr?=
 =?us-ascii?Q?MdIY2JJ8FpcT5Wru+pfEqCi8/pJ08YbRbaplFR6L2hPRNrh2D9uAJdeVfa3V?=
 =?us-ascii?Q?TOpqDcjSLgplwHgTdH8hHBgg5SkLkP3xbJ2wUUln6keHZz0bwk1s+/BlvzTj?=
 =?us-ascii?Q?BZDFsyLojUMibiK1XVMqrltdzVdIIz8NuTDAOG5x0FWTGjxIGRhIBSNLOujL?=
 =?us-ascii?Q?mZKR1VruhVUo+eqY5EEWvgybB0iZDjFP2ionmsn18wm6g+VCHxyQLvsg5M7J?=
 =?us-ascii?Q?iYNK0lPJNYa2v20OPO1PG392BTnm0wr/iXdDhlrayT6CWc0ZqDU818J/+6Dv?=
 =?us-ascii?Q?Y/tAHQKYIHvkvsdHXt5Z+VZ23JxqPjJhrakxsBISWws1CjoycSdiA5tqXPMC?=
 =?us-ascii?Q?uZTHCU+KBYvHQBgi/qUcSpI+VA6kTslnsVlCwFk1S6NiTeeEF+NTwEIM5LyK?=
 =?us-ascii?Q?iK7lFTkTRKscIHXKagqrCXa2ejPyjB/F9tLX?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NTvnW2ebJZgkn8KCv9MRlkNP0tVQLNdug2KNOxBddc+EexcrNNl/E3PEO/Ix?=
 =?us-ascii?Q?HzKC+4cTwD0xmXaiF4aMhNft06qqggTZ7bXdwc8qiF52kHvi37s977jMOuMu?=
 =?us-ascii?Q?5goZmTM8dWZaJL49lfOWLMH22woxIHaOsH47ZZ+Vhc3cghDQVu+GlbIPGDHo?=
 =?us-ascii?Q?jKpFtl3IEb3QanQtbP9jySNvWmGDcWOwJnWXGnzeIJozKuf10lMWfxSUpPdD?=
 =?us-ascii?Q?o00a02WrOPZfqrE4TsYontj6d3JcU5tvhwmdrPl16H9ekR1N+Vw6K9KedZfE?=
 =?us-ascii?Q?jakbqXkS+9I2OdHUprfNjF5aDDEHkz5fZonsG83fvAVtY8JjOZuvPBaIbSaJ?=
 =?us-ascii?Q?elWdK1xn1QlzSQWAnKNjgevl0jE7gYXD413Hm05MA5dPXzAc8WbZrHZGBV1+?=
 =?us-ascii?Q?4mzMvimzvs0ukmWtWj2moUo1lOquB8zcZPlgCaRyZJ6CujiYmfi8xiLr21SW?=
 =?us-ascii?Q?29atLih2GrwvGANx7YsAAUU+6veYaBcq0A+YhkvRVq6q3Yr7ShLA66i/AT22?=
 =?us-ascii?Q?6obWgo5yTsXrrBvi0VyZdHuGUB2Wte+6Ubd2boC7xUUQ2IoTTQn+rA98ljUu?=
 =?us-ascii?Q?kvmsbcvykUx+x8JfAN+p0lz5cbyohUj7OyQcIWoyCyK3WKsP/iICq14iJIAS?=
 =?us-ascii?Q?Powu7hdWPSziBUqMtfx3NQSDOZ1wZzqpdaPhM20m7T924pU1B+BXA3i3AiSB?=
 =?us-ascii?Q?/eTMeqnDHfEO57+cIKIk5vu/4KSUR0r5LWLS0YjalPaIYUR9jZWZs/oBN/2M?=
 =?us-ascii?Q?1+3HPVCq7shgz/atSXhh/b7zD4cexxvTDYIrpenrkVr6W5x9uyR6kZx515hM?=
 =?us-ascii?Q?9kEjg1NJ8iKJg1DOTZ4Nxp2+QyEaUj6I3sfqOA6ENXAqIXpMmm8wy/vZAoQt?=
 =?us-ascii?Q?RS8a3S+qrm7onE0KuByqhqhq5aF09j+ortuvan/fgfLq4EdIdX75QpU7qQWm?=
 =?us-ascii?Q?gXVV5SB0KEOnECAUS0XwiDVP/872uCiif1c8/nC8sGAD9lMkFuaup5XK3tW1?=
 =?us-ascii?Q?tYrJHgb2ecDQ0xSA9uxCsorl99cYPdW/D8aCnRROaZLBIiZy4ZlTma/clYMp?=
 =?us-ascii?Q?R+oaacX8WJIxJIvMYoc5AF4lZ+4eisRGvK7SBdqj9sifO+A4+aTBCPPtIm3M?=
 =?us-ascii?Q?Q9/ucBVc4Ttm1pUYe7ubKfAt+yQKXoZEXmdzHjeZ/qcTRWC4fjuaximZHYVB?=
 =?us-ascii?Q?irGAUjrS81+UmUUyeEVwycSDGlGoZaz0plY+6EH7hw0Fgvi7nAVGwpvitrbO?=
 =?us-ascii?Q?t+GjAgiEh3xhmGIC4qSFBcQw0r6nQe8vVjld3NI20Z0BFWERIUiRSWoswAsB?=
 =?us-ascii?Q?a5xj89JuAu+p26Q1m9htWc6FyoIOLRZ6OqSRYDmYiSuCE07jQdzYpcHMuPqn?=
 =?us-ascii?Q?iFhRi3Z9+cN4cCBVdMrFCkcCpRDtVbaLBGRu7x4cVkxgwHVlO7WfdoUBhqUN?=
 =?us-ascii?Q?TDYLJQJh3Bk8OYVEULcg66/2onadj/pCb7Taacl425prH2aJChlvuSo9456O?=
 =?us-ascii?Q?+BlOhT6dJNUX5ZFnWowhe7mGWd0yuHx5bVzvxXwBCm+++MXlL0naTPJnMCWr?=
 =?us-ascii?Q?NPxZRjYJ601naF+qS1S5vXWgGyfSPEES87GWr8S8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e48b9108-e6aa-47c1-e2d2-08de1aeda985
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 15:28:38.6314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mVbdQuJdHZ+W+7LaSyQiacqTZhSLsPFnuYtW96u9Bop3dS96nYi1r5ZXaHVOKl7EKSDaxtumc3MYJc+PkB9RWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6211
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Joshua Hay
> Sent: Tuesday, October 21, 2025 4:31 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v9 08/10] idpf: generalize sen=
d
> virtchnl message API
>=20
> From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
>=20
> With the previous refactor of passing idpf resource pointer, all of the v=
irtchnl
> send message functions do not require full vport structure.
> Those functions can be generalized to be able to use for configuring vpor=
t
> independent queues.
>=20
> Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> ---
> v8: rebase on AF_XDP series
> ---
> 2.39.2

Tested-by: Samuel Salin <Samuel.salin@intel.com>

