Return-Path: <netdev+bounces-286513-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DWc5JNOTAWq7ewEAu9opvQ
	(envelope-from <netdev+bounces-286513-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:31:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DED0A50A1F3
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0324A3005795
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB3D332907;
	Mon, 11 May 2026 08:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MDhfyQsz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B5C3B19BA
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 08:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778487921; cv=fail; b=SWHq7opW9Inc/URbmxJ+0WV3Pd4cwDzqhAlli1Ygh0gMD4e9cj1TzW6eBtwcUyZ0sU7gLCQsjnrfYFcWxsOeXsUpPQ/dcVg4oFMGuB3U1muqfPKpjytCSqBai0lkdJjGeE/0hoHul2VsYVIpmsfho3FfpMG8TTjjZTtYmA/A2cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778487921; c=relaxed/simple;
	bh=Sa5Pv1v8xVF2QAbo6lUm+wKDEpS7Dg54KwtaPo3rrp4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rojiusTSAVt77lIMi1CgcW8xfRirmn0BeYZHVeIYc1viHh0FnQSmseOqcYoL3cz070ZHTbeDE/FOVAIkuq8OkRYxnc2tYq+p1Dbgd4P8pi7eAx7lu4e7PJPC/OCUnvZc/7hEc8gzrZT3FBRL00pwYbv0Q/5uRGLF6D4n2VvfYGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MDhfyQsz; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778487916; x=1810023916;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Sa5Pv1v8xVF2QAbo6lUm+wKDEpS7Dg54KwtaPo3rrp4=;
  b=MDhfyQsz1bcstDVSmVvnpmCztu6twRrvsqEjhkVQt5F1DOXPcYMlF0qV
   pXR6ejNUdnhanyrsnVb0jZsQn3U9k/lbGTeWJjriTcWlycYKzP4eI1bF+
   CuvbU709m7zDVkN5sIdSiohUjLlNKZzKMOx0ieQFR7ojWCTSOtWTYwIXM
   wr5jvynnxmpZlj81vnZ46w3tt0Z5rb1sLs/lR+RpO9/iWgiY3IVhKngeR
   z4CntejF/sUVtkXBZHUSuMF6BY6fub8Xb6lnc/ZGNfml7ORFYufA7LsQb
   emLyIZ2+CB27REZ7RJ4o5NNZd1NeL6vnUbOE78BzUG88v77dpKspetFF5
   w==;
X-CSE-ConnectionGUID: RXcd3SuCS4+obdCNdLSW6Q==
X-CSE-MsgGUID: 9KWZ4dHQQuCEpQbBKHR+yQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="66900507"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="66900507"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 01:25:12 -0700
X-CSE-ConnectionGUID: HexIP+UvR6a2d2xBaFzErw==
X-CSE-MsgGUID: C1ToB3BeTXOpMO1NxBivhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="242357522"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 01:25:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 01:25:11 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 11 May 2026 01:25:11 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.70) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 01:25:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdlEKzRUMOLMWfU57OsSV6Ls7m3+S1x0ur2IPlV6RmNG306QqDvTAIX52VW4SqhVc0QoWVauU3aOi2FLIFS7QfE5GaG4LVWbsHLtzAERLwQZFEfmuutA4Z7fn7SXRcbL8wjjXMTnZDAAv66ufblb4N/H0tODxHOnENnvLFqq80AL10cWlbCIPB6QyIUuNXCJxAk037NNvzgYxoFw4tQ8Uvlj0OX2gtdHOlw1BrtsgAy9yHfLBz5MqQ2xoW8IEyuQh7Xx49FuhhSVtq4OPAgkOwspJsBwE+jd56kiH8LxU398MBjdyt6W3ItDp++58juQBaeBG86FaLGBXAHgRdWC9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjrwGliZSwdnRS5rc6UuSDdgUBf3ZPiPGhKufLxYVvw=;
 b=L7nUhldNe58HImvh6gsHoVX4mkMUcdPB2CDCfnTFTzsZuGLgENNKuYKOrk8bb6h4cILAjN5xU0idq9LvlQJ7R0AGSHMjHDM5hJRIUp6l0lO9cTqUj2mw3RUbM0G9ZWuBT6aUjAY0HR/MzCLCbc84qMd7hUdG/kmpNqnKGEYtizOKw3EzIfhPcvvCsawiT7BhhwYmw/8a7rrk9cG5GHjMUH/MH9vb5BKqbjFvl1lMb2DW7zpwKvlXYK/zFyZbhH8gVpg5ndwf37XDmUnw950kYr951+F9W3lvAXAHzR5IFYcYgG9nXkloePwTmn4sM549GlBgaYcP5ZjuKAOdXVtUcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by CH2PR11MB8816.namprd11.prod.outlook.com (2603:10b6:610:285::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 08:25:09 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%6]) with mapi id 15.20.9891.019; Mon, 11 May 2026
 08:25:09 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Simon Horman <horms@kernel.org>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"kiran.patil@intel.com" <kiran.patil@intel.com>,
	"sylwesterx.dziedziuch@intel.com" <sylwesterx.dziedziuch@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "avinash.dayanand@intel.com"
	<avinash.dayanand@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net 1/5] iavf: fix null pointer
 dereference in iavf_detect_recover_hung
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net 1/5] iavf: fix null pointer
 dereference in iavf_detect_recover_hung
Thread-Index: AQHcyxeEOXrcfoiLwkupHlFLVxHbLbXgFjWAgCiS49A=
Date: Mon, 11 May 2026 08:25:09 +0000
Message-ID: <IA3PR11MB89850DCE009BD7002D07C5EA8F382@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20260413073035.4082204-2-aleksandr.loktionov@intel.com>
 <20260415124845.797759-1-horms@kernel.org>
In-Reply-To: <20260415124845.797759-1-horms@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|CH2PR11MB8816:EE_
x-ms-office365-filtering-correlation-id: 7088ce2b-0954-403e-2a81-08deaf36d056
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|38070700021|56012099003;
x-microsoft-antispam-message-info: VhchNzJPUCVH0aibuvN6YErhvMZaZDYLzmxiFoKIaZ2Bl4XMhC2xXRGo5YgJ0WEB/Vrs0g16q6JP5Hzf21bdY2PCAk036OMOF0d6jAtF0R81YLWFL6Ce1TZiBjtuVZJ46DRYKimuY7xpP25xdKB+aJjMTOT9tbho2qwzmm5+UbZRfglqZMGWoB8jhOGHhNOFn8K1RfyA+TK+B4lxoj4SSwss2i5q2RFEB29BYkk8T7TpM86TNuyDSLaBq7hdQSXRF0oHuEa3RwXuVeA8Gw6TnRCo2EzZXk9dW+3j4eHWuNvmkY00UlXla5l0xTBGDpLqzbsnb2wBUsUXsmCnRBcrbcGYVFzRdNf88zb0YrFslMJYhXW1BMkL3YXRVzjwvjVwMfi9ZqJZJhfO6nJzOToOt/yJW3t7RYl5RDwbAhi3xRJxkYTWaUgAkwuC6OM4AH/TMv5KoIMDIS5Zgqh+5RCfcceezxVtez8+G2QsWWdUjUDEwymTIno2qqE5GiHdQ+/YV15ETk0ojsEEU2te9x+th6i0A2q35xXSjRp1k1xCnOq/xqylkZVH0jNhhRkoI8YUC1T5ykbFvFxVZ4rVJTvzo+8Kss/GyPmNH23ODuN5Hi4J1+911VAaF4bNrJtp4bn+rJx5PKf5S/SL8UsZhR5mG9hWt1uyhzk7/y/hPVno9do8nAp8QKWlQA0JucGPMNOpVS880HlT/v/xA457x3+JiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(38070700021)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gnRUH20AnimHwbjU/l/mr9bOCEJck9WQPUX+4Ugt0+Mx4j4UT2Qkx4Zru7Pr?=
 =?us-ascii?Q?8Q3FlsaXYDvheACPeOHyI8hGpKXqFRzVWlKptw9pK6SfN3zBGVLZksXPVUT+?=
 =?us-ascii?Q?/cumroHwFVuXHj9yUt2fkAsw5gXatUQxiA1xazqu039VCg1krAUcZMwJs3pg?=
 =?us-ascii?Q?bLLY2vHdlj1IgMxdr1A1PRbZnnYa+4Ia12XcV1vHFhwHhuSM0zyyxtZ8kT+7?=
 =?us-ascii?Q?okfzPME+R4zU+hjUCe5oODpZMPgJNnnniD3qzfIViDUV58sSFN9S7fPFfXuD?=
 =?us-ascii?Q?S3lnoQ8fR/V2B4E1igTLMIcT8gLh/2vMxqVpyOkRu/25hW/xLcJ0vy2mkfqi?=
 =?us-ascii?Q?NEiupv3Bv6VzFF5ofVn5FZ6tLdyGrawBu9vQyH5lsO0f1bWgyoQKhaL/C2jx?=
 =?us-ascii?Q?WCy99Kv/N8VCEZLEhS+cKfxSwj9bdQhs636XtHPUMCG5vpqWYZrX4E8Itazl?=
 =?us-ascii?Q?0KMyUW9TnMB2KRAtZFrGkvTCABFNzujflEOVyiqAuMEcp6MtgtSp5pCCMPTH?=
 =?us-ascii?Q?X7gKQ3Hj33Z+hKFCObKuPsrkGa4Tb1g+nFRKD0SMPIokTz6OctlTQsYm+RSO?=
 =?us-ascii?Q?GELrIin2nf8Tt6Gfn4AuMhaMGYaU+Ivs3lgn1S6qysy9iRr0KK8SyTXiUWYX?=
 =?us-ascii?Q?aNfiyN5GF7GXU07S9kU6kSWyClmFagvtCZbmk4b/QZQ6Q9990whEGl+I/RRW?=
 =?us-ascii?Q?5bTt2eNmcRbkNwPEXj+Jz5N7tpFIf6ei+lJwXvSLrM2ft4JkPTCMUY5Sccbs?=
 =?us-ascii?Q?9l3fT8LnQ2mDBgcr6qkVIBcs268+9TPhB3MjhDKagMCN+sSbVM8raMlniM6h?=
 =?us-ascii?Q?cIcUjqdjhrrgJisiTEW+JToJKIylxJGjzVw81rEDmqaX53QStIqd97kT504o?=
 =?us-ascii?Q?1MbIqWGWWQvZa5v42oTuESgF7h3lJ2egPr5djue8uuXHoWvs6+EVMKBxnWl1?=
 =?us-ascii?Q?CeyvSjhQ8/XHBGjLq2q7+otiHqy3jSuNLtcGxm5Hz+7UILlbc/6+0LI6TCI3?=
 =?us-ascii?Q?Vhx3ggKxR/f0jCLfaYWeuIzz4H2lEV3PeggtYmLMZLGqxWYnQIHxm8jQnTW4?=
 =?us-ascii?Q?zVKy0VGh0gx25VZN5wKkm4SFWA5s8cJO5OV3a8eeBhDltbM8X/vawX9b7ghx?=
 =?us-ascii?Q?+ue8oFblefjaOm7Sfb/4O8PQrd4BohOMAdWCAOEX/rjqCWp45ipDa2bgIiNf?=
 =?us-ascii?Q?T888Qa7G4vUwk0GX9ZbF9Fc1ZlR9jVEFrP+L4UirLeL6K/oV9627/z7O5su0?=
 =?us-ascii?Q?cwJdB7xvIvKP290hivq3ok7cdyOXTAmfN+D3cq02SOsNjIprjCRD0/V/gr++?=
 =?us-ascii?Q?4AXCpcVXrTufD7k2M0Zhes/tgcELvQTDb3l5hO+stUHpGXN9T7/3cnb+UKhV?=
 =?us-ascii?Q?+0l9A+QQQ8putBsbrjwE+4aLaxcozkmfrkec08yd27LpMKUOeuHQUZIpnYmd?=
 =?us-ascii?Q?D4fC0sZugRYIi90GJG7CUNKYS/MDQOgo+VEryebbFzBfblPQvbpPDTUS6uM2?=
 =?us-ascii?Q?s4OF+qfCnZLF12MFogcAWer6kEYukSfFQ2hHD0WXZEGOOkyYOxdL1RW8AtOL?=
 =?us-ascii?Q?5m1wm0SpbTM7VhNS9ndY6eULl7NoNSZDFSsV0gZA7UhV+VyLFWKqAJvk2b42?=
 =?us-ascii?Q?zu8+WTLmYZYGa5RiKZFa+Rcvx6RtDj0opsvUGjo/MoIvIBrfnF4fzizzwN7h?=
 =?us-ascii?Q?jNjiJJdUdEW4Nw9TaqNzVFMs3aqpHChjmlrlSD2Qc/wVekHucjja++r6t6kK?=
 =?us-ascii?Q?5QsAWnp4rQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iTvrMZCRrrsGf6ytVsgwvRDXqGonFZK1m/k3bVzKyPYkrxONhSDYQoOKaSTmbfIZ2N7VldTK/9DScb+jOTEyjZy1n5s5L3U4QXPXD3TznPCH3D9Ab8jrQpbJnUlu4C/I0ePt4muHRqr76/5BkHd5YKJd8PcgEtIXZRIMFrUvBPS05D+lQLE17+nzhKF7CAToznH1BQwYV3uu3pF7p1GKTJT6II22sny7wTNyI36a+vdN/uTM743Zjv1rYjReo6ncsWynapmlOwYmBD0+di2LarxnWQBzOcD2qfXk9Kc4bUP+TvPgqauZnaX+HtY93CMKEPUHrKmSTUEdo1Z4R7NonQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7088ce2b-0954-403e-2a81-08deaf36d056
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 08:25:09.1473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 62ltRu/D6lEiID1/8k5QerOhQWi4uYWJKOadhGudiMlDhNpLACn+yJoB0944oc9Eajc30iph+HC54LfZXJK06wZ/vGdO7BxhrHi5EDke0+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8816
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: DED0A50A1F3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286513-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,IA3PR11MB8985.namprd11.prod.outlook.com:mid,intel.com:email,intel.com:dkim];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafal.romanowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of S=
imon
> Horman
> Sent: Wednesday, April 15, 2026 2:49 PM
> To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: Simon Horman <horms@kernel.org>; intel-wired-lan@lists.osuosl.org;
> kiran.patil@intel.com; sylwesterx.dziedziuch@intel.com;
> netdev@vger.kernel.org; Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> avinash.dayanand@intel.com
> Subject: Re: [Intel-wired-lan] [PATCH iwl-net 1/5] iavf: fix null pointer
> dereference in iavf_detect_recover_hung
>=20
> This is an AI-generated review of your patch. The human sending this emai=
l has
> considered the AI review valid, or at least plausible.
>=20
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> iavf: fix null pointer dereference in iavf_detect_recover_hung
>=20
> During a concurrent reset, q_vectors are freed and re-allocated while the
> watchdog task may still be iterating rings in iavf_detect_recover_hung().
> Dereferencing a NULL q_vector inside
> iavf_force_wb() results in a crash. Guard against this by skipping rings =
whose
> q_vector is NULL.
>=20
> > Fixes: 9c6c12595b73 ("i40e: Detection and recovery of TX queue hung
> > logic moved to service_task from tx_timeout")
>=20
> The Fixes tag points to commit 9c6c12595b73, but that commit only modifie=
d the
> i40e driver and did not introduce the iavf_detect_recover_hung function.
>=20
> The bug was actually introduced by commit 07d44190a389 ("i40e/i40evf: Det=
ect
> and recover hung queue scenario"), which added iavf_detect_recover_hung w=
ith
> the code pattern 'if (tx_ring && tx_ring->desc)' that calls iavf_force_wb=
(vsi,
> tx_ring->q_vector) without checking if q_vector is NULL.
>=20
> Should the Fixes tag be:
>=20
>     Fixes: 07d44190a389 ("i40e/i40evf: Detect and recover hung queue scen=
ario")
>=20


> > diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> > b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> > index 363c42bf3dcf..e7e7fc9a5c68 100644
> > --- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> > +++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
>=20
> [ ... ]
>=20
> > @@ -195,8 +194,11 @@ void iavf_detect_recover_hung(struct iavf_vsi *vsi=
)
> >  		return;
> >
> >  	for (i =3D 0; i < vsi->back->num_active_queues; i++) {
> > -		tx_ring =3D &vsi->back->tx_rings[i];
> > -		if (tx_ring && tx_ring->desc) {
> > +		struct iavf_ring *tx_ring =3D &vsi->back->tx_rings[i];
> > +
> > +		if (!tx_ring || !tx_ring->q_vector)
> > +			continue;
>=20
> The check `if (!tx_ring || ...)` tests whether tx_ring is NULL, but tx_ri=
ng is
> assigned as `&vsi->back->tx_rings[i]`, which is the address of an array e=
lement.
> This address is always non-NULL by C language rules, as noted in the comm=
it
> message itself: "the compiler can never observe since an array-element ad=
dress is
> always non-NULL."
>=20
> This creates misleading logic. Other similar code in the driver correctly=
 omits such
> checks (for example, in iavf_virtchnl.c and elsewhere in iavf_txrx.c).
>=20
> Should this be simplified to just check the q_vector:
>=20
>     if (!tx_ring->q_vector)
>         continue;
>=20
> > +		if (tx_ring->desc) {
> >  			/* If packet counter has not changed the queue is
> >  			 * likely stalled, so force an interrupt for this
> >  			 * queue.
>=20
> [ ... ]

Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>


