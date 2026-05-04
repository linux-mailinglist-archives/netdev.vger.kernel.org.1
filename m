Return-Path: <netdev+bounces-283809-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJrHLv2M+GkVwgIAu9opvQ
	(envelope-from <netdev+bounces-283809-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 14:11:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1790D4BCC28
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 14:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C79C730151FF
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 12:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E793CE4BA;
	Mon,  4 May 2026 12:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q/aVz1gj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38943B9600
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777896699; cv=fail; b=SG8WMS2sUbsBnmWYf0OIT0nV8IwBRFGZYNLbcUO5CRsKeR7UtilDdxDQ5ndVpK7srEJIziZ+hBZw2eOxFyQgidUhVsG4bLMKGFOqrNeQ/QpHpgyxGMGrDV5BKv1r2YuwfVUPZ1XomOZTqfmb2OOhPwU12dK67uILvrFdi9bQbjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777896699; c=relaxed/simple;
	bh=udq35WEYSz1RTlUhslHXeM5jMsxbpiuhBf+byBgdUvQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iyhqwWaOyNX3sCdOW0VkbT0KA3SLKgrkQHhspLWgqS0ZP59F96IfuKVivdzW17RbJ3BS6MgJgVXlv8txw7XpysORxPQDZz7U/zSmYlASmVXFucKm87ZOR2tQZdyDDHRcjekhcx7aXKylWQr+MerVVbJboSnZrv0dlzFGoI7/UTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q/aVz1gj; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777896697; x=1809432697;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=udq35WEYSz1RTlUhslHXeM5jMsxbpiuhBf+byBgdUvQ=;
  b=Q/aVz1gjnI/oUzRHOU6KjtOaZ1btulr7CCNeN+D/HKHGJ3GvYbYRtGgV
   P/sHYUZFhTYKDu4+9Fi1nrcnv6KsDVmda1UPQ6KwCBfjKIi7Os6L/+N4w
   KhzBpGFqs7uUkyBTOkJwE4sPqPNr8+jFbPZ1bc7e+Ke9PYGZxuw/sRLaA
   B04xyj09EBZs6GbQnqB4oPhgo+NaeCI6y+EPLebuF2PnRl/kFAitKQQhC
   rUER/V+gaLRhX8PeYBDtyswstKQDRUoEMyBiJqWjfTYIFK1HgWI6FlgU9
   g8FUSHtuxEQ+VFj7tdFx+7lRUAudiB5q3JtHSKFH88INLKVW99YtlLtL+
   g==;
X-CSE-ConnectionGUID: 593RpCqtRd+ArvzYIB4Hjw==
X-CSE-MsgGUID: L8iuOIXcSkWza+Bx/B8Ytg==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="104200971"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="104200971"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 05:11:36 -0700
X-CSE-ConnectionGUID: bOFlvpe5TFiY7m4k+1ojuw==
X-CSE-MsgGUID: E//ZO7XuQ02++Iqela680A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="273617581"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 05:11:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 4 May 2026 05:11:35 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 4 May 2026 05:11:35 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.39) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 4 May 2026 05:11:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJwXhN9XNhcL7XQQShk9Dmk1IqFOpg7kay0cAY2MO/HP9sVRS2zPjjAX6h5tMdZHrmHnME5b7LXrkTAFNbcOKLMritgGaGa6z1vJCjOb1fdac2I47f1gq/QkYMSJia85koKTNw9rb0CRFxPK8oA8s89hmCot+yuiEQjlZf/kAJ5TvNANsJLM3XJ2G3rvHjvzRjDTbL3Et8T78/7iEsWH8G6tu5/emOyvNhBCo6mPfxclTIsDNXJY7O4xGsCS12cAoavMbHsBt8zZzyinbil4msllOW/wQJGwEyxSp3stUKp/X0Saw3SkLGtmabJoSSs9NzfmiN403nZKh+F9+EW8bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbDyB+/rSDY3Bmys3grz4HWQP6JRcIa8LSQ4oJLRVCw=;
 b=CbUD0fEvY3j2O/Menv+MnaTCOXsd99nfIix+Hz9ntztbNwZdilAR5euynuj2lWA7TocYrq3+AggFHAkNQrixPBYuz14eD56IK+fSBnyIsqm6MqswPeF+GsJsjfzbhLnzOXry+LICIDtfjsxfGbwEJzQxCRYx1wIPr4LzEhKDq6+8hmS27LAoNyxU22AWItD8HDadCmondhC3/9bvNBD+XTKbbdrhIzYFjka18vFST8oh4gCrunZ5+t+lJJveuxszX3eoxQcASerjcfTluFJOVouCGBZS1GJN7Ijg7aOPF2LtVa1mNAP6NTMqoMjvVDJl6Ne8HnST+cRUPaMTtidPoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by CY5PR11MB6257.namprd11.prod.outlook.com (2603:10b6:930:26::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 12:11:26 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 12:11:26 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net] ice: fix PTP hang for E825C devices
Thread-Topic: [Intel-wired-lan] [PATCH net] ice: fix PTP hang for E825C
 devices
Thread-Index: AQHcvbqvKS2CYSlvnkaZGA+pJV1BeLX9pW/w
Date: Mon, 4 May 2026 12:11:26 +0000
Message-ID: <IA1PR11MB62410636303305D93225E2578B312@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
 <20260327072332.130320-4-aleksandr.loktionov@intel.com>
In-Reply-To: <20260327072332.130320-4-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|CY5PR11MB6257:EE_
x-ms-office365-filtering-correlation-id: 983a7f50-fc2d-4d60-3cab-08dea9d64432
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: pP96Kffx4dTdx9582TEuyfGJNtRo9PjA5jR+UFXKBSJ5dEwxHhukX7/XbfFeef05VNkLe1yKST5/2HtqYk8wURyrUirG29L8o8oHS7hquy+Pazf9GVVGJi0PlmwzAqdA3fO1WDMPmjaZMMkWUPaUB4brASiZa3chl5NQHQOkMGkTjpmzu6XQkWYbo8QcB6H8Czrly150h6piD5FcA290ne1jReDlmzR6qRRb+Ya1Dl3tipx3Iq14xKHd9C5zWXY6XP9C98mW/oeGcRHKSk2NaZ9UkzWr9NREwICiHfVxGW3bpX7QCPc90ZHFqa6fcUMUrhtsWMlguCWhJVugjTCBWB4cTDF9N28+/Nbx21Svlm386lPsU09piBQmxIvjKvK14TVsjwx9o8HRHg4idQttQZ6kiBSSgw3mKQ36SP3T4LtZyQKvFP10N1mOdocZI2JaMtnz3gIBTvvT04IJvn2HVzfI0VQt5M5wrHERRqnFOlvgMLy8/vdqF0r0GSU1aMy0Ea6qsdVCIkLr9SdHwgxahxva//rJEXgAScPD6vzuFPozqrufOlxh2yPJJdF9ab+Y3fc5c8wJ9vbg7ORI0t9hMSqc9LM6kM6BhSGdg62SKSu6KkHUpiSbz1eCJU1Tw0prrDJvjAlzxMs9VK7cSO4R6KXKivOyUWyHhX9z+vq44k58KJBj+owUEqFbtWilS9mpaUcY2/TVeH/QydZSD2WgXD2uWNntmvFtn7pFrA/+zW1f2wOx23nmFy9FJXTH/TpZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3I8VoH0YBaLB+PvIqP6v6quv6iGs6YvkLZsB+YX+I4aRgKtRmEO3eXxrH1I3?=
 =?us-ascii?Q?sgo70TWZOd+F4wh/TS75bUU+49k8lbkfG1cQZFp1DJDTLKExvISu6sg0myCv?=
 =?us-ascii?Q?umxBGqMZQ3xpAfjLYD6lCYMZSeOffBPjrygPVUUQYr7/nU024OaMbInFq9wD?=
 =?us-ascii?Q?3R2kDQHhNJTg99/6DY3MdogGLF3muJRTGoDgRrhDUnoG4eQld/IFm9UUIkL+?=
 =?us-ascii?Q?mamHHfm1/a0IEuqSliis2SCAcRHd/fxU4KjHMM6QyAaVzy28bLXACBodMi9j?=
 =?us-ascii?Q?Rmv8G8J/pvqp0KDcWrXn7gI61K8be89uluma5LD74WJ6N7k2h/b+dg7nUlh/?=
 =?us-ascii?Q?8/OpzUKWMKNTeCNonLKQwHH5YjLAlDfpO+8PL5Po6V8PUplmlIoxsWo7Cfq3?=
 =?us-ascii?Q?m7lXo4CmSeXL42IuZYTQCS64sZpG4UFquWqwEBq6XuSQhK0ZSTOWpyJEPRCF?=
 =?us-ascii?Q?FalOCSPyYF+7GHtBksdDr7Dz4xvABG1Yri/HMzCjcYh8u63N2mYjMyRGWBnW?=
 =?us-ascii?Q?TVuk6xxXfpXRDEUx0HQr3MaNMbksipwminNChzyJj6xNyTQ00i+kUu/+aJm6?=
 =?us-ascii?Q?evO25cBJdRHsJPeKHnuRqFHH9ZmbRw268cwFdjEoLVKV+zLoBNduXfeXtTnu?=
 =?us-ascii?Q?JAZFcWL29xuv7rK2YGkEnmSHqlw1+p4LX+8RyMQEeALi3ZG8ZIAmi5v7v/TC?=
 =?us-ascii?Q?NBHuolmZznWKE06ZLe1xKjHqSmJu69DgbUYmT38nIXrOMf8eWDJRAekZiMG+?=
 =?us-ascii?Q?eGpf3+PuFOkIImDNAuFLQqzWtLGUemNdyRJOcIMkvInxfR4L2o/S8TM6klWs?=
 =?us-ascii?Q?EZUDCcT+amqkLYf7F3NWMvT3OB0PLT4FcBhzM+NMzo1+ozel0TWCKrF4WDw9?=
 =?us-ascii?Q?5CIbC0q/tAL1OqW1JrOEc2TAorJjGceg1bliFww9PPraF7oJnZJG0S67T4q3?=
 =?us-ascii?Q?khyKnonpZtamXgAGa4Qu0RDI3IbTpyAiwqCdbatIk9aTlHf2+UQEQ5AGPGTO?=
 =?us-ascii?Q?qh7Byt+tL26JWdWXerTtt0zPUmzBywapSlYrrOfeP38E580Gb4EDtBcr69kf?=
 =?us-ascii?Q?JZruUuHagySEQpecSkNhZDfL+pY4QPXy4rmhtlMX0zHSCfMAX0MZ9BB3N5pX?=
 =?us-ascii?Q?U7KAbN10zyV+FAj6HzZDpNfNjiUoAwmNhsQYgtWHEn3QtEAxLupdZjgQO6sN?=
 =?us-ascii?Q?TsaAuwumv7ROMy8bQrtxIN7BioOURuMkZhMyHmo+IDXpmC04UTvUFNQ65trk?=
 =?us-ascii?Q?c5CMT4ACMLPOpFt0i2hEUjzOaazTo3FIiTJ/wbGDiaYzF6zG9Hi7n28VsugR?=
 =?us-ascii?Q?liyDb0AKDxOZ7I6t4hf+9e+kdiUf6CJujReYD04KngTrg7o188J695GvwwEY?=
 =?us-ascii?Q?qtLs2f2RrtNuMLvk7yXNaDXKNkTeXiigZaLzpAzgkrOV/LST80XYdaeZVXVI?=
 =?us-ascii?Q?yrHvDXg9BdN145zXrDGOcw4ttpiKnSJN3UDkExZUUcpBTveZ2JnA+5Zc3+zQ?=
 =?us-ascii?Q?ej72bRFdvDQw72Ok7VLDLjiSIhX+A4l4TQaHxkJKMn4xLfKxuoBe6ciHErEp?=
 =?us-ascii?Q?o0yJadVCH1Wk6yR2K53mMDjKCfpCAuAuDhtfilEIZZYmLiluX6x29Ar9IE3r?=
 =?us-ascii?Q?Hp+PfT+RtOkUpTN0o6VWJ3Jx1bkahCVEDc+O0TIwC+5iS77EdWWEhV6u7Mbn?=
 =?us-ascii?Q?/JVwQMfw8hdCt0YyGycmWruhZKqGvd9VL/AkvLnRIGyT0we1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dYhk/6kaZWVn0lOSTaeMk8hvoHAHjaWjnNh5m6BpYyo4FgAaG3oKWFsMkfzEpYRnbYj57GXuKGiFp6fl5pAL+32pSMAdAwOdycL3WPNfQsh8ztNDN4ccoSKMAz87jN7GSOaL53gq2+sTFeEWdOGihlqMZ6v9hRTmOJ9UuKwchwaL2eXSvR3NURTOpm6JkM7xr6LrtbjVFxfAp1jcsFpaRidtPF3I3H6kVAuO93o/g/zVMsbhu0wPgYh0NiKEKjvFR70eNoTPgD4m40VfxVpI/KTZPGjJ0q3ZQMhLYejIrVL/C2ZuCkicAKANkcyxZ+z+dea7QcN6CEBBRU/v1LDinQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 983a7f50-fc2d-4d60-3cab-08dea9d64432
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 12:11:26.5190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YMvAyf2czGeJAMBJ3tekOXGYPKgcU/bO76izVjFA8zpBXnF2t+jRe2mpI/C1UzuI64ymOTWrGRBDu3Ot22RODw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6257
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 1790D4BCC28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283809-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,osuosl.org:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
leksandr Loktionov
> Sent: 27 March 2026 12:53
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net] ice: fix PTP hang for E825C device=
s
>
> From: Grzegorz Nitka <grzegorz.nitka@intel.com>
>
> Change the order of PTP reconfiguration when port goes down or up (ice_do=
wn and ice_up calls) to be more graceful and consistent from timestamp inte=
rrupts processing perspective.
>
> For both calls (ice_up and ice_down), accompanying ice_ptp_link_change is=
 called which starts/stops PTP timer. This patch changes the order:
> - while link goes down: disable net device Tx first (netif_carrier_off,
> netif_tx_disable), then call ice_ptp_link_change
> - while link goes up: ice_ptp_link_change called first, then re-enable
>  net device Tx (netif_tx_start_all_queues)
>
> Otherwise, there is a narrow window in which PTP timestamp request has be=
en triggered and timestamp processing occurs when PTP timer is not enabled =
yet (up case) or already disabled (down case). This may lead > to undefined=
 behavior and receiving invalid timestamps. This case was observed on E825C=
 devices only.
>
> Fixes: 6b1ff5d39228 ("ice: always call ice_ptp_link_change and make it vo=
id")
> Cc: stable@vger.kernel.org
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>
> drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

