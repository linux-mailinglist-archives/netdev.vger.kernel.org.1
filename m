Return-Path: <netdev+bounces-60601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B74B8201F8
	for <lists+netdev@lfdr.de>; Fri, 29 Dec 2023 22:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB15D1F21E16
	for <lists+netdev@lfdr.de>; Fri, 29 Dec 2023 21:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D5A14A84;
	Fri, 29 Dec 2023 21:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AmjCelrk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1751014A85
	for <netdev@vger.kernel.org>; Fri, 29 Dec 2023 21:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703886380; x=1735422380;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hO4Vn57qi6Gspht90qMmz+9KAeqHbyguyjGRD2rYsw0=;
  b=AmjCelrkQ6qE0r1m4rcdcCzmxDQM/u0tkT2G9X+mOX/JuljN3yqA6o6d
   x9RRqtpzeSI2UrnIbEHKZb/7CfNiu45hoXqW4g4ZPD3bRiqE3//Tgod2y
   r4niXJuEDcO0E/B4jd6L8oj69m2OaFgrfPTEaUFUC/N3/UrPDsVhbU8XU
   +Ohv7pWIfWGwbUz35N5Mf9fGEwNmVfYqlnwRinzoj1BB8W3COanocp5iM
   wQQjL8c4nn5TG9XG2MY6ERNpEVl6r/2nvOQdLteFyqY9zvTv9VYkV2BC3
   ICuHtQ6autUH/RVpc1BfiZKRQiGWraAbiGCvvf25K8d2EYW7OH2UMLfaZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="3513374"
X-IronPort-AV: E=Sophos;i="6.04,316,1695711600"; 
   d="scan'208";a="3513374"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 13:46:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,316,1695711600"; 
   d="scan'208";a="20643586"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Dec 2023 13:46:19 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Dec 2023 13:46:18 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 29 Dec 2023 13:46:18 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Dec 2023 13:46:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWYF6OzT2CjjP5533jGaEeQZaCyhgAniviYTlS/Ts31tNoy7EkdwRsa3t5h2/dQc9b41c4yXjSD/sfGmFzLpY0EoIDty595xUN3UIzEz25PgQcLZJYbi23JEE4ALMk4E54JLGLIZGMNajiMxhgbwP10J9RTDHN8PyyCmXhLKZ94hYxWuILZj+PqZgdKIs5xK93qj5e2IBSLO4YkZ+P3lY4RkI0350r1hiOmxqDLkR+9kswzaFoTwYnVoL1ZIynf2QnCAwF/gUtFcFHzxx7dlwhxUsmyffpdJQiErvE16wEqUB35Jf/mlXVAJdiE1xGJI89HCoLatyW0VjbKxZmiFQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDmJO0a78ljJqTSY68Cq8lW6+CT1rHeQl9d98Hk6+rU=;
 b=iw+GwOhfmWG0f4z03R43EDMSWP5bFh+YwjnZeZ98OhEMShrn4vx/pDkDOaE3VCSxyN35DxgRBf+9lquNFW5H6zZAQAZqRzqf41n61K4jtihAu4ahJZD2GmEzR7clc9dhiSdXrWvhAJxd18L0zKVC9UygNUclkHSQd6sR4KPgKD+4cvM1qogDY4grALYexooF9ItMKs94lxCc6r0Q5bp/dNZy+NiqEnGFufln5/3YgW5bT3I/GP0PAs3Y80Zz3GKg7F6Vs8/zWDNUWD3x1wV3+Gny8J4AXO98dznPx0olP2eUMHkjvABis/aioPsIwxxnbBsO0HHeHxOiZD/RbPvlYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5028.namprd11.prod.outlook.com (2603:10b6:303:9a::12)
 by DS0PR11MB7215.namprd11.prod.outlook.com (2603:10b6:8:13a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Fri, 29 Dec
 2023 21:46:11 +0000
Received: from CO1PR11MB5028.namprd11.prod.outlook.com
 ([fe80::bcf6:6bb9:953e:6a2e]) by CO1PR11MB5028.namprd11.prod.outlook.com
 ([fe80::bcf6:6bb9:953e:6a2e%6]) with mapi id 15.20.7135.019; Fri, 29 Dec 2023
 21:46:11 +0000
From: "Mekala, SunithaX D" <sunithax.d.mekala@intel.com>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Jagielski, Jedrzej"
	<jedrzej.jagielski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, Simon Horman <horms@kernel.org>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 2/2] ixgbe: Refactor
 returning internal error codes
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 2/2] ixgbe: Refactor
 returning internal error codes
Thread-Index: AQHaMZ/gudxWYl1jZUaho8dHqmld2bDA2jIw
Date: Fri, 29 Dec 2023 21:46:11 +0000
Message-ID: <CO1PR11MB5028E442DAE211D28EAC6BFCA09DA@CO1PR11MB5028.namprd11.prod.outlook.com>
References: <20231218103926.346294-1-jedrzej.jagielski@intel.com>
 <20231218103926.346294-3-jedrzej.jagielski@intel.com>
In-Reply-To: <20231218103926.346294-3-jedrzej.jagielski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5028:EE_|DS0PR11MB7215:EE_
x-ms-office365-filtering-correlation-id: 36da46ab-f2f6-46e1-52e4-08dc08b79290
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L0vwDAZLR4xG+Fg5aTkNuRUZVsC2qDRx+Ga5jt8ZboZpDfMNc6ZyrydUMPTSJA1YQLK2tr3937Lmo500ImXaubZ9kfWh2PqophB5SXA99U86s34qQz3oIVIwNs+qmrnaN1DpLkU2qHSQM5WGFpl6WgDKSW9eVU7ezJ188V0eDXa+0k8OyqwTrLHMXDhksHLkEo9UpKl8pP4Ye/7zMZJRJsuBQPICuHuqVMuw+jWyGRZd+m95LCM6M6gAdOR/yh2ow2HAS+usjjNGoHHC6No5tptA5GEh4zWzbh7wpVSsM/RtUGzp2jQ2sveNrX/DRWk9YAl0zFMx93OQDNxaOR+9V3leOmmMt1c05I90lhs3ohN6B+m6i3bLiWHjOrGjtkMVQFTzxu/6uUAqk2RRsCk/ZwwRizbnM6J7VltEVt4f9qKRbAROtI+AwCswRPedzoQQtFxVE+9CwUMesPsxtfLhn/BrCpd4zT10ud+zcaAt/w8Y3/DWXGqDojzeM/VNhNLSMlcsvYOadthb66zMbMOHd8FExVRAuGCQrK0s4Q6UpzquUIsRn5UQZvHWFxlutGH8WKWbQmn0hbeByHXU2GuVJcFDKvV27SlP+/tS8RWQ6tkdMiE46aIhozNdWjKlC8Li
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5028.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(136003)(39860400002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(7696005)(9686003)(64756008)(54906003)(66446008)(66476007)(66556008)(6506007)(71200400001)(76116006)(110136005)(316002)(66946007)(478600001)(8676002)(4326008)(8936002)(5660300002)(38070700009)(52536014)(107886003)(122000001)(55016003)(86362001)(38100700002)(83380400001)(26005)(2906002)(82960400001)(33656002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jk47iotXevqba6ZTa2G8ix7QKYHQH/X/OAE6gQK89eqSUsDhyrfcsxt04DB/?=
 =?us-ascii?Q?Z9tbdHP8tAyplnDc4NrxtihKv0PEOAXgTVxkaRWc2X1qN+puzj4mRfYuwZQv?=
 =?us-ascii?Q?H1N5jFyQxIkodyHSQxCZqKmE96fzEpAhVC3erL8yjjd3vm2O8cjrB2sJF1eo?=
 =?us-ascii?Q?xE769ctgfp4F6o9MNPoRWAmo92log6IGxu921XQxdQRkJ76vFdpwx2WSSlgf?=
 =?us-ascii?Q?PMVKAHXEPvlO5qepFPHhFeGkmHgD28LuASCoCH8Z5zR1+HTOBYvyT61Fu3IR?=
 =?us-ascii?Q?hFHt7PfA+FiVxkk3HOrq+qVemU8ajJPJqk5o1Ii3P8wCkQuhfK0NtcY+xSNX?=
 =?us-ascii?Q?XaQQCZpASCxRUFQ2sJKpjoQgfftyM4Gz0xgO2NeXqEc7qtH/+u98Uqz0aDf4?=
 =?us-ascii?Q?NLdYfKOlvrnEhgen2Sba74pNdIP+BU3wBYehg37geAKGLU9k4P6bMET/ey43?=
 =?us-ascii?Q?t8xebk+62/LinXF3luVYooethH/Kyn9UOHD+LRN+AKMxyhkhTv7fJjnOVSvt?=
 =?us-ascii?Q?xim0mh4rO0/ppTdFhn0uSJ3iomsSKjIYNFKNK1LM9W+2l/9DHhAQ1+Up/ki6?=
 =?us-ascii?Q?jlwYcXbXM8vWe0VrvJniDbzfoCwssMosy+Lag33eh61QdlicVdb/WH1kCem2?=
 =?us-ascii?Q?Cx2Po55zRFzOvFPScZAH8KxxLjvXtOOlndOe32i8Vm3nBajGDT8LFoaboJeZ?=
 =?us-ascii?Q?fAp3XjNXmmTkhmv4Zl8grdj15+dJsMmKNpEpo6X+ODpAmIRFhIkT8nFe92jY?=
 =?us-ascii?Q?a+s16QlP+tt4fQQe3Ra1pCeRG86quFjGb5MUBEfZ1FWDS9htCjbdNAKGVMlH?=
 =?us-ascii?Q?//9AXTNK2rUsA74Gn1g2/4HX1VqS4wzJCwTZVF9RnD+5yD4r1wnS6hoY4nuk?=
 =?us-ascii?Q?dgci8ckg1J6i7D5KJMBm+HAyDs0lsTvMnhP0hZ9lKU8h4Xd3ZWn61TY+efX0?=
 =?us-ascii?Q?ndL34ukAqQP2XkNdw6y1sFtdKuCw8LCb6qwKqEtSqqQX0QDFzcBT3defQQVq?=
 =?us-ascii?Q?5Vfg8tUCE2y9jQpgksH8e+yuHw2vuSAQ15SmgZmhd4UvYMIuYaqAvObF6ePd?=
 =?us-ascii?Q?I+gnCgX1F4Xd0AtEM49h81trvTb+uabj4g4liQnVXHUPndG1pua2s+f7V9+E?=
 =?us-ascii?Q?GyniCiMNRRBVtqGBnRf2XJiuoxD2KRthlUGmpi7jwzr6DS+4DW0JYAuW7tvo?=
 =?us-ascii?Q?kVwBH1+ZjnS0H1rtfCQ37RRvX+ibIONxwcZHJW3t9qEkuf4lNVrZOl0qiuzz?=
 =?us-ascii?Q?j5babzfZsN6sc9UMYcnJ4pPYuXYSWv1+jPbcyLZGYbcw+FfWYCv6lVX90AXq?=
 =?us-ascii?Q?FSmSAL8gYMfuMrImEeGfQvCkRlZAMobzwMIa/skJcA8LdM0a7pFSn631lDbB?=
 =?us-ascii?Q?L5V+UqBlnEnTF7AJRLTEdckrZSi6+giNT87BEOp5C+brhtTzBdeJVdPuEXqb?=
 =?us-ascii?Q?/4iNcz7hKLhP7OI1WVK2/Hb3i6iQst2X3MPnM0ZGQjKyF3cUyjBVfj8/o+r3?=
 =?us-ascii?Q?ppsuHi8r9HCgURstR9DifW+KyQcfolxtk3yYz60Bwks5KTmmcthfFTdGmZ+0?=
 =?us-ascii?Q?evqiFyR0I80UmeZ7ZvzjtrDAyOlsaII5fNzcXRnxTBU3ra6wQAKi4BeYGzht?=
 =?us-ascii?Q?tA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5028.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36da46ab-f2f6-46e1-52e4-08dc08b79290
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2023 21:46:11.0596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d55XNwzoMy6TVhNo1+XhUmL4oKi4hXiVBhDxjGv03aw6w7vEeuA8HchJPzFmI/AKTVDdycFXlsSp9v6uHCUCt6jkL5hDkf7gYMZVDgCqnSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7215
X-OriginatorOrg: intel.com

> Change returning codes to the kernel ones instead of
> the internal ones for the entire ixgbe driver.
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> v3: do not use ENOSYS; rebase
> ---
>  .../net/ethernet/intel/ixgbe/ixgbe_82598.c    |  36 ++---
>  .../net/ethernet/intel/ixgbe/ixgbe_82599.c    |  61 ++++----
>  .../net/ethernet/intel/ixgbe/ixgbe_common.c   | 145 ++++++++----------
>  .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |   2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  26 ++--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c  |  34 ++--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h  |   1 -
>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |  84 +++++-----
>  .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    |   2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  39 -----
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |  44 +++---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 109 ++++++-------
>  12 files changed, 266 insertions(+), 317 deletions(-)
>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worke=
r at Intel)

