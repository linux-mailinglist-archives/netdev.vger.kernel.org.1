Return-Path: <netdev+bounces-274176-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNInJqJMzWl6bgYAu9opvQ
	(envelope-from <netdev+bounces-274176-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 18:49:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E82DA37E279
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 18:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4196C3192A5C
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 16:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A513A9DB2;
	Wed,  1 Apr 2026 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ASAi34KS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D273F0AB6;
	Wed,  1 Apr 2026 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060974; cv=fail; b=f4WwLEJF3eV5tSsHGYd1xZ2lVJMX02MhlOEBIOi5il5go3wncOzh3vUsnML8Hzpz/bQPY3ihFzaXqj2/rDVVc1qRLOqlE21cbjzHRv0RrXpiDvTC+ArmwS1OOw2PKcJb+gj9wpSi+jPBK3PFQoTveRqdMf7h7HSc1MlXcI5A1Pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060974; c=relaxed/simple;
	bh=cECccxUoO47rDh5XrjS+CG3q1srbOb2H3flnBqoL6ZQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O4XHKIHIei9N5gEO5TlFZOsEzRREbUH75/DccE73zMidaBzz66lW4OcwHmhlaNaTjGGXYbbpaTyPKdNBiJ3uMng8qCUiPLuSEuN9gA4ZS8EpPT3qE7LGXuM0jJSryF8t2hbRIrlKX9R0eWbC+oJvcZXuc2Z9lDf98W/lfou/1xY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ASAi34KS; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775060972; x=1806596972;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cECccxUoO47rDh5XrjS+CG3q1srbOb2H3flnBqoL6ZQ=;
  b=ASAi34KSA+5qzH5vNBwBBnr6QKD6ncVufxx2KsVMwsR6RgT2N6AtHKK9
   BIGJWCh6JyBQSzSQy0oKPCjHBkGtrYdwWL2pH7wGf2//pXvC+D1xWCC6t
   5b08x4YGU8b0oIZPfYXKkF4sBHof0naC9tmvJyRwoUcDiEpO/zlJa1P/W
   aFJH6bnqxGz2Ri0nnk6fOtoktSPScZEv42tVcuDyfqLaLwy8pRwQWKn27
   u4pEGH7RHyRl5FxIB7YwNcqjqbESF+2SL5fu+CNyfhUjyJ4AsHL/UB9Zc
   qOG8uopbX8N88vTebdQnPY3xS3kBRpt4dZ1lqbAa53D/YUYUqf3qrYVPN
   A==;
X-CSE-ConnectionGUID: FwxVhm6hSQKPCh5URBkdJA==
X-CSE-MsgGUID: +BhS8p7GQIyifG9+eXNwdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="87181482"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="87181482"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 09:29:31 -0700
X-CSE-ConnectionGUID: ql1dmBY2SnKubyC2jYSFoQ==
X-CSE-MsgGUID: hKRzI54PTI+gn6eoBhieyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="257198843"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 09:29:31 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 09:29:29 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 09:29:29 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.38) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 09:29:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAuoSfSi9SaM1FM9dAd/jFKDZ7DL814/R5MRyTuDVrxvSKhbNy32oEoX1Kkti7n9CmldlxCzjxg9ntTwHmrdY2xFHom/o8QCM33jnjLHa7QMo21+8DcmNIF01ShxHwvROIM1fiaqPK6Q10zeDxJbZr3gc0fcGLsY3D/qb+pQHisGhIUkLHt5gSDCQ8jn/CofH+r/vyU5l3yVM0ovXtK7BbZFsnNCxi10iZTtjTL2XXAp1+ZrOBZKeJYhRc9P0O50IVIAVzjaSlBkwqgUCyIhw/mJ0Bx4muH6JSpqPdX2k3zeCa1DyMrWxL+AIu6YfYGYRI1MkxQTVSdmL0icBSv0TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cECccxUoO47rDh5XrjS+CG3q1srbOb2H3flnBqoL6ZQ=;
 b=O8Tzc6+LI1qnJolahEzsOeIlKM2UxAlpGp2r+Vf85cGTDoapsm/HFPP659ii2kKBXjri7yYkmuL2yhMYSuXvcc18IR2ZMo0SflJqyRVODKrp53Y6/Vs7F5ab8G9mBngg+W0ADetcdM/9Mk/rC7fD3lJ5o0Vn/fS09zHc5BZtigTzyJ9DV0XlpYJ1OK3RLHtZxWbT2duqH6fYh4NoWemrw4INYds/CDj6YHXjJ6hU8YFS8BGh33YL5JiaKvBpgRggZZwTe8zcDbulyIshjHdRBWrd+bLxV0EwD97pa+l4PDT0MT6m79wB1w+Hw3iroQnulilHzuNd0o0ilovwcpvn8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by CYXPR11MB8730.namprd11.prod.outlook.com (2603:10b6:930:e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 16:29:22 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 16:29:22 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Vecera, Ivan" <ivecera@redhat.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Eric Dumazet <edumazet@google.com>,
	"Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	Simon Horman <horms@kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net] ice: fix missing SMA pin
 initialization in DPLL subsystem
Thread-Topic: [Intel-wired-lan] [PATCH net] ice: fix missing SMA pin
 initialization in DPLL subsystem
Thread-Index: AQHcnPOFLJ8u6prFWUyUWp5KXzlc8rXKnUHA
Date: Wed, 1 Apr 2026 16:29:22 +0000
Message-ID: <IA1PR11MB6241B58FF425A8684CFAE7A28B50A@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260213141651.2231124-1-poros@redhat.com>
In-Reply-To: <20260213141651.2231124-1-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|CYXPR11MB8730:EE_
x-ms-office365-filtering-correlation-id: e1627892-b6f8-4f0e-bd73-08de900bd4ca
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: NDBCxTeoE7c2yLiiBWRK0vEwtZUzLA84sw+iCM5gzDa1/fT5UQiN4wyr/0wotrMpu1dwvVe1Z1NIR+Dmlg4P72hCm7hoEmIHR+Qbn1nU6X0Q8XiG6BS57eppDUcruIU+NkrmJTKi7hAAIov1ltmT0ob6R02xUq9HGL5PsVTnBqqCMB6j40pQxxRbIbZ487cIX39UrXAxXfhIz+WBsdZb8mA19q5qSdevshTq5dNzYYiANTCUphf84JpvCA6662h0TjhBEpo5FdzGW2fhmxTx38thU4pIcY4w/tIIh2CJzoM/Jr54c0fgS+mblaoEp7et5LryzyWFaqFjH30y/wak2VREAfjsJZWkE9d41Ywtj+JOAbRPzitDq9zc2X4qcspasZ+YkAh3N5iST+oZoM6AYZpLQT2DiVFdB6pq3Bd11c0J4HvLHPTR0/Yv69Q9rmLOgXjkeykoqk16drF7qSymMHMNs9iJoYWaie7btzu3RQaXqNgbASHFHaKoeYT5Ke6XC6sonMoP0ZVjsRiP7+n2MfIvYbHzWcv97nos1LeE1hPV/UiL6DO7deAu82NXtAaLc4nEC20njNt4+1IgDvobLDZPDeatWI7lnSya+BUr4mc+s1WD03tNrDgZPFsRobm37TOvy/nOTqvBF0roKvAm0Q233gJ7EVGnV1Gbagphb6L8rwtXlTOeLzDk/OOcPWyIi2GKg2dgbQqaEvh56fArkbv/Aw0/Q82zcxBdQRB08fQgJLJf17sj7v2pIFHMBDPJxtdk2xhGO6p9ZxP4EOcQRUGJfQCieUqDKVDm26wzl5A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWp2STA3Zmd5bWlVbjZmeW4wMmFaM1NUbjIyMFNQYmpacldQdzZJYXFLYVpu?=
 =?utf-8?B?Q2R4SmtETE40c2x3RWorRjIrUlNnd2VpdFQ2TUl2U2FvekZPZGpTajlsQWcy?=
 =?utf-8?B?eTM1d0VIdjA2c0Vxd05QZGRaY0NGSVFBQzdVeXJzeVk1NEQ5R1h2REFjRjA3?=
 =?utf-8?B?TDcyY2NZR3NvNm85RmI5WERPeVlEM0N4THBBeHJld2RyVkt1aWVoQ1RGRHBx?=
 =?utf-8?B?bjdzRFdETmNreCtORXlJTkc4blJmeUI4YzJDemNwMitSWTkwNzkreTJUNER6?=
 =?utf-8?B?RElybjJaNVVQY2duNDJabVExcCtJa0luM0F6RzJFNFFOZVZtYnVYUGhIQ1Bp?=
 =?utf-8?B?R1NobjVuMTkyZDhTNlJVYzlwWkNkRHJoQjlFb0UwcUwzSStTeWhicVo3L2J1?=
 =?utf-8?B?NXhwOTRlTHpFKzQ1VzlGMlBVSXpkaStHMlVwMnE0Wit4ajhhQVlzYmcyWUto?=
 =?utf-8?B?S1ZnOUJEV3RXOVRGVU1NS3loNXpZUGhNSlBObjBRU1lFeWV0UFV5NlJndWpL?=
 =?utf-8?B?M3laS3drSVdRenFMeEZMT1RjMm5jSjVwUGw4K0lxQmJTWmtlRnoySVdUaytx?=
 =?utf-8?B?TkI5NFBrMndDb2VuS0x1cmtkZmxjYjBRUnpSQnRMZzMwOGl1YXZiSkQ2b2Jn?=
 =?utf-8?B?UzVtRkJYWWxCcDhJa1FMTktTVmJEWXMrd2ZmaWoxRnV3SkNYekowVFIzTXBh?=
 =?utf-8?B?OWhtb3pRSHI5UkpyeTVpU2NNcXRwQVEzVFA1NXhQWm44NzZ6UTYxeE56R2FK?=
 =?utf-8?B?Rk5qOUtwYVM1VjgrRXZnNDNaUUdzNUhiN25nS3ZTZDlRK2hqWndwUEoxMEhz?=
 =?utf-8?B?Njd2N2VjeWJHaDd4eWVyN3J1ODNwWGJtNWlBZTlmOGlMT29tb0tlSHBXNFhS?=
 =?utf-8?B?OXdwRFdvQW4vaDRmeDdrVEZPMGVRMi9sUUlrU0QrRU5yUTl3YXdDTFY1NzJY?=
 =?utf-8?B?MC9Xa0J2NmhRVnJUVkJ5R1lXZHdtTDA2UldOVnZNejJPVWpVcnkzTVljdmUr?=
 =?utf-8?B?YkkxZ1dEQWs4ZnVtSS9xdjg4UGQ3RFQ1SE0wbGdJQWtDOWdxb01lR05kaU1w?=
 =?utf-8?B?MW1wazJ3emtQMHRMdUFvdExEMjZqZ1VBZFMvMmsyTDVEc1RIZTFRL2hNcUJE?=
 =?utf-8?B?bGVNckVPSDRyT29iUFNuVzRCOEp5b0MrenlsSnFnck85Vi8zclZNVGd0WWh0?=
 =?utf-8?B?bDhMSkpQLzNxelVFMmFYdm1WZDI0dzlFRkpEOGNPWFBmcXVTb3N2c2pJQTNP?=
 =?utf-8?B?Zy9PNWNSWUlkYWFEbmRnajFkWkU3NmlVNHBxUHpWTzBOSnN4Y1VUeHo4RTdF?=
 =?utf-8?B?RWhaTXpFRXRyVDR3aDdKRE44WFc4MVovWlRmTFBNOEcvTk9MTE5yVkVCbmFp?=
 =?utf-8?B?S0RQY2IzUk1JOExnNWFJN3NIeHVaVmJGZXc5Tm5CcXVncmJYc1NUb3VjbTg5?=
 =?utf-8?B?S1BXR0dPdjR0UitKNFYvK21Hak5NWk5jZ1BnUVRIeTd2R0l1OWpObTZ1NHo2?=
 =?utf-8?B?OEVrSGF4SnNpZ3VDY1c1elhVRHY3T0ZtcTY4dWtDUU4zcXlrUWJJL09meU9x?=
 =?utf-8?B?aHhhbVZkVng4YXJlUDFxQmtGUTlybitCc01UQXVFdjhTSWJXQ05ULytEZ0FP?=
 =?utf-8?B?cjlCUXJHcGM5cUVRNWJTaytrMGRpMmVuSDkzd2ZmUityS01qbU5lbVB4dHhn?=
 =?utf-8?B?RWVTUXRTeWVSRFZQamZaN1prRHdOblZHSk8rWlZPaFdrOXpvWkZXOERvMlB2?=
 =?utf-8?B?NVpvRFRHdDNIMmR3ZFBTQjk1U09HdHpmeW5TYUtDY3JDSXJNN1Vqb3ZJMmNW?=
 =?utf-8?B?UnkvYk5MVUd6SzJ6U05naVlKOW5Qb2w5bVBTQVg1MXBaNjFaS1QxQytDMG5E?=
 =?utf-8?B?OWVlTG5NSkFRT1RHU2NCNEpCeFhrT3daTDh6bjg1OFNRa2lPV0VCYlRqdHJl?=
 =?utf-8?B?dUJYTUVOOEhVR0ZmSEh1dWxoYndZNFQyQU95dld0S1dNc0ZBUWpMWFlFWXlM?=
 =?utf-8?B?NUxHMzlJOE02aHgxb21JaXBwT2RzemVpOW5vMnU1S1VCSGpqdzBnY2Vud1JY?=
 =?utf-8?B?bnhkaGQ1YmZnbUxobS95MmZBQTQ2VlF5MGRzdFBENitkTnBod3Mrbi9QOGFj?=
 =?utf-8?B?YmowaXRVS1FaZEp6ZmVCTmgwenR2c1Mxa09MTm91NVhoRkJVYWtSc3VNNVpp?=
 =?utf-8?B?YzRUZjVUT0RXU1BNTm5paUdjZU5EYjNBNDlXZkM3ZlRHaTBza3ZyWE9oSHhI?=
 =?utf-8?B?L2NwUEp0MTBlS2t4U3dRUDFDdXczWm5YeVBZZE43ZEtkbGR5Qi9vZ3RlZmhm?=
 =?utf-8?Q?5zEkemcGTmGdedubEv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NSKzGrhvcQUvg0s3wU21w5HsUV5E+93Ti5nSXqGUulKRmWK/6F+x7qoJu8T+swHxtTHfGPWxdxi7C3nuNs+PK4hMHeoQIowFaYo0YMjlblFcqdAvRVSb+hOafFLiG3oTmKitaM/XncMbThKP8LGoLOoJaCHExqJ5LIaiix3IfTm3fY2xUwKgb8xc20wpR3ZOlpyNQwnukA5RHDm5o23rpO542vm8j1E7FgNlBghbMYu4ymhtKvTCWRt4vEWkVFjHVfXNhJDrYKEeZzEsFTXH5FiahPG9Ns0k+O2Jl5tqDGF+ZlgAjAqA0Jke6bfKJo+2Minghs1KYTPl2eoqIuzx1A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1627892-b6f8-4f0e-bd73-08de900bd4ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 16:29:22.1825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +AMAIMt9UDXBZJO/yixzTzfbFjsa4gSw5jzl8f5PXmVERD9xh5XVcXJRyOtXfwptGrxcxxM8Ifz1mDzN2ppLmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8730
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274176-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,osuosl.org:email,lunn.ch:email,IA1PR11MB6241.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E82DA37E279
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBQZXRyIE9yb3MN
Cj4gU2VudDogMTMgRmVicnVhcnkgMjAyNiAxOTo0Nw0KPiBUbzogbmV0ZGV2QHZnZXIua2VybmVs
Lm9yZw0KPiBDYzogVmVjZXJhLCBJdmFuIDxpdmVjZXJhQHJlZGhhdC5jb20+OyBLaXRzemVsLCBQ
cnplbXlzbGF3IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPjsgRXJpYyBEdW1hemV0IDxl
ZHVtYXpldEBnb29nbGUuY29tPjsgS3ViYWxld3NraSwgQXJrYWRpdXN6IDxhcmthZGl1c3oua3Vi
YWxld3NraUBpbnRlbC5jb20+OyBBbmRyZXcgTHVubiA8YW5kcmV3K25ldGRldkBsdW5uLmNoPjsg
Tmd1eWVuLCBBbnRob255IEwgPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgU2ltb24gSG9y
bWFuIDxob3Jtc0BrZXJuZWwub3JnPjsgaW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmc7
IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaSA8cGFiZW5pQHJl
ZGhhdC5jb20+OyBEYXZpZCBTLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRD
SCBuZXRdIGljZTogZml4IG1pc3NpbmcgU01BIHBpbiBpbml0aWFsaXphdGlvbiBpbiBEUExMIHN1
YnN5c3RlbQ0KPg0KPiBUaGUgRFBMTCBTTUEvVS5GTCBwaW4gcmVkZXNpZ24gaW50cm9kdWNlZCBp
Y2VfZHBsbF9zd19waW5fZnJlcXVlbmN5X2dldCgpIHdoaWNoIGdhdGVzIGZyZXF1ZW5jeSByZXBv
cnRpbmcgb24gdGhlIHBpbidzIGFjdGl2ZSBmbGFnLiBUaGlzIGZsYWcgaXMgZGV0ZXJtaW5lZCBi
eSBpY2VfZHBsbF9zd19waW5zX3VwZGF0ZSgpIGZyb20gdGhlIFBDQTk1NzUgR1BJTyBleHBhbmRl
ciBzdGF0ZS4gQmVmb3JlIHRoZSByZWRlc2lnbiwgU01BIHBpbnMgd2VyZSBleHBvc2VkIGFzIGRp
cmVjdCBIVyBpbnB1dC9vdXRwdXQgcGlucyBhbmQgaWNlX2RwbGxfZnJlcXVlbmN5X2dldCgpIHJl
dHVybmVkIHRoZSBDR1UgZnJlcXVlbmN5IHVuY29uZGl0aW9uYWxseSDigJQgdGhlIFBDQTk1NzUg
c3RhdGUgd2FzIG5ldmVyIGNvbnN1bHRlZC4NCj4NCj4gVGhlIFBDQTk1NzUgcG93ZXJzIG9uIHdp
dGggYWxsIG91dHB1dHMgaGlnaCwgc2V0dGluZyBJQ0VfU01BMV9ESVJfRU4sIElDRV9TTUExX1RY
X0VOLCBJQ0VfU01BMl9ESVJfRU4gYW5kIElDRV9TTUEyX1RYX0VOLiBOb3RoaW5nIGluIHRoZSBk
cml2ZXIgd3JpdGVzIHRoZSByZWdpc3RlciBkdXJpbmcgaW5pdGlhbGl6YXRpb24sIHNvDQo+IGlj
ZV9kcGxsX3N3X3BpbnNfdXBkYXRlKCkgc2VlcyBhbGwgcGlucyBhcyBpbmFjdGl2ZSBhbmQNCj4g
aWNlX2RwbGxfc3dfcGluX2ZyZXF1ZW5jeV9nZXQoKSBwZXJtYW5lbnRseSByZXR1cm5zIDAgSHog
Zm9yIGV2ZXJ5IFNXIHBpbi4NCj4NCj4gRml4IHRoaXMgYnkgd3JpdGluZyBhIGRlZmF1bHQgU01B
IGNvbmZpZ3VyYXRpb24gaW4NCj4gaWNlX2RwbGxfaW5pdF9pbmZvX3N3X3BpbnMoKTogY2xlYXIg
YWxsIFNNQSBiaXRzLCB0aGVuIHNldCBTTUExIGFuZA0KPiBTTUEyIGFzIGFjdGl2ZSBpbnB1dHMg
KERJUl9FTj0wKSB3aXRoIFUuRkwxIG91dHB1dCBhbmQgVS5GTDIgaW5wdXQgZGlzYWJsZWQuIEVh
Y2ggU01BL1UuRkwgcGFpciBzaGFyZXMgYSBwaHlzaWNhbCBzaWduYWwgcGF0aCBzbyBvbmx5IG9u
ZSBwaW4gcGVyIHBhaXIgY2FuIGJlIGFjdGl2ZSBhdCBhIHRpbWUuIFUuRkwgcGlucyBzdGlsbCBy
ZXBvcnQgZnJlcXVlbmN5IDAgYWZ0ZXIgdGhpcyBmaXg6IFUuRkwxIChvdXRwdXQtb25seSkgaXMg
ZGlzYWJsZWQgYnkgSUNFX1NNQTFfVFhfRU4gd2hpY2gga2VlcHMgdGhlIFRYIG91dHB1dCBidWZm
ZXIgb2ZmLCBhbmQgVS5GTDINCj4gKGlucHV0LW9ubHkpIGlzIGRpc2FibGVkIGJ5IElDRV9TTUEy
X1VGTDJfUlhfRElTLiBUaGV5IGNhbiBiZSBhY3RpdmF0ZWQgYnkgY2hhbmdpbmcgdGhlIGNvcnJl
c3BvbmRpbmcgU01BIHBpbiBkaXJlY3Rpb24gdmlhIGRwbGwgbmV0bGluay4NCj4NCj4gRml4ZXM6
IDJkZDVkMDNjNzdlMiAoImljZTogcmVkZXNpZ24gZHBsbCBzbWEvdS5mbCBwaW5zIGNvbnRyb2wi
KQ0KPiBTaWduZWQtb2ZmLWJ5OiBQZXRyIE9yb3MgPHBvcm9zQHJlZGhhdC5jb20+DQo+IC0tLQ0K
PiBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2RwbGwuYyB8IDE3ICsrKysrKysr
KysrKysrKysrDQo+IDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspDQo+DQoNCldoZW4g
U01BMSBpcyBjaGFuZ2VkIGZyb20gb3V0cHV0IHRvIGlucHV0ICwgVS5GTDEgKGlucHV0KSBpcyBl
eHBlY3RlZCB0byBnZXQgY29ubmVjdGVkIGJ1dCBpcyBzdGlsbCBkaXNjb25uZWN0ZWQNClNpbWls
YXJ5LCB3aGVuIFNNQTIgaXMgY2hhbmdlZCBmcm9tIGlucHV0IHRvIG91dHB1dCAsIFUuRkwyIChv
dXRwdXQpIGlzIHN0aWxsIGRpc2Nvbm5lY3RlZA0K

