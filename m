Return-Path: <netdev+bounces-70567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1F484F8C4
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 16:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90A611C2352B
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 15:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C73771B3A;
	Fri,  9 Feb 2024 15:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XLC6FxZn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3629969971
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707493431; cv=fail; b=B48tmuARemnIT787J2gQjko1CGzo67G4zpBvKfGEOylbUS+ZFP45hFAqihmeODOzYtT6Jcht8ibkm+G9kHbOhb0LBeH5Ly3qC7dluqMqgrbZ8yE3FIEp368Jotmys6PColsRbdSIsV7qyJhpj9wTMiebf3gCq8qYqJ5fNhVknzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707493431; c=relaxed/simple;
	bh=jXjpLfHExwdndCqOy8X9icvMwSMcsH1GcLAMPCWcb4w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FpqG7FJ0dy+whwldBndm34qnV/UZCbw+3w4jA+iSGlXep0V/WHWqmXuLi07vYsjAlUyxa3Au6Mq+B9kRcIVD0i5GsBj0hq0GsveyEwlM2tZ2B4HISOAGhDbwjsxG4Df4OG53rvnalnDTRB5G07RlNvu7WjNvq93S359BxIELsUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XLC6FxZn; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707493429; x=1739029429;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jXjpLfHExwdndCqOy8X9icvMwSMcsH1GcLAMPCWcb4w=;
  b=XLC6FxZnQs/iMA677XhnZ8FT0ugDzSx8Odq35Pf15PSyhAt6JN8+Fvzi
   iD4/ltEblqaP/oEvzrRsmWCDpHmVwK6/+2ZkJyE/UNFD8UwuL6Tlj2Fuj
   uMtfG0u07lQS9EnMYMctihz868ckPsaeUlCr3idRBrQZPwyx97RxFEkTF
   kyeB/OMHTdEXW4EbBedsDjN32Jv9DrqwX4w3Cat5lrxaLkJXMzFZg/twe
   bCrGzwistPOlHv6P5MUDLYRxkwJsseeRe/yR43q/+X+40VNg+wnV2SpSG
   UtLKfYSc/PWwtr6mNuCR6SABQgI2u9gF7I1zelRKyGs7Vl2M0xkg2fskg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="5265905"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="5265905"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 07:43:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1969035"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Feb 2024 07:43:49 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 07:43:48 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 07:43:47 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 07:43:47 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 07:43:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0jk3yq9lvIKTQhU64UyWGiw4TQ+x9vXIjqOZOm4OCJS6Y49dlK0Fv+8gltoPsKdvXC2vBMNniY1MR45HoF/J84yp6TCCArTMhMi4NDXCscaAOpxyfH5hg5qExKWdnx7cFHYZANZ9KzrtcjFOafhJj3ixhFHMdXPVIXfSBPVHgrJT/182c7Skx/arFVWpjrUpeNwTLv0U4DmcqlZFYNcfaOogNeHP413buOuL+U/Szg5eBO6VYpIx2UIge01CTlqqKLzMAhUd9MVL/JOh9pBgykoyhfj4nqVefuRKax2psIxBeLnbmuihc5lJ05fT9dHIJKdoVgU5F33EKWshGZdow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXjpLfHExwdndCqOy8X9icvMwSMcsH1GcLAMPCWcb4w=;
 b=nw4dRNWBpA/2NZKmMvfO19i6VqUdANiqSjlCP7gCTZCOhiZeSPK8yLEJ/I0D3ofmV1GUcsgdbjp0ITwty1VMBYJCg5Zg/SSAhHu6IzAUKMMecZ9PDVEIKmf2dJC6oB4TtJtx0/F+MZ5l9HnuYJrNyWE1U3UySzjyxKnfDUoeQ8Nb6EbEV9uJG+Um3kMcCmbGebvz/tCDL2GqOkLo19v+r+7oqWaHin/ZvLIiG1YA8A+a1wl3nYnFHY9UfigywGa+J2k1+yZEavYywvPXCFRvu7mo8PVrzZ94q3ZpeK1McjmL8w+vhIp+aGH7dN6RKeIVlek7wQZZXnnhSXsVBIvxHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8313.namprd11.prod.outlook.com (2603:10b6:610:17c::15)
 by CH3PR11MB7321.namprd11.prod.outlook.com (2603:10b6:610:150::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Fri, 9 Feb
 2024 15:43:46 +0000
Received: from CH3PR11MB8313.namprd11.prod.outlook.com
 ([fe80::42fe:dbf5:e344:f60]) by CH3PR11MB8313.namprd11.prod.outlook.com
 ([fe80::42fe:dbf5:e344:f60%6]) with mapi id 15.20.7249.038; Fri, 9 Feb 2024
 15:43:45 +0000
From: "Rout, ChandanX" <chandanx.rout@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, Seth Forshee <sforshee@kernel.org>, "Simon
 Horman" <horms@kernel.org>, "Karlsson, Magnus" <magnus.karlsson@intel.com>,
	"Kuruvinakunnel, George" <george.kuruvinakunnel@intel.com>, "Nagraj, Shravan"
	<shravan.nagraj@intel.com>, "Pandey, Atul" <atul.pandey@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v2 iwl-net 2/2] i40e: take into account
 XDP Tx queues when stopping rings
Thread-Topic: [Intel-wired-lan] [PATCH v2 iwl-net 2/2] i40e: take into account
 XDP Tx queues when stopping rings
Thread-Index: AQHaWPnx9BK1Ihikn0m1fAUihrLQI7ECKvPg
Date: Fri, 9 Feb 2024 15:43:45 +0000
Message-ID: <CH3PR11MB83130D9CE3E3EAF392A6AB1EEA4B2@CH3PR11MB8313.namprd11.prod.outlook.com>
References: <20240206124132.636342-1-maciej.fijalkowski@intel.com>
 <20240206124132.636342-3-maciej.fijalkowski@intel.com>
In-Reply-To: <20240206124132.636342-3-maciej.fijalkowski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8313:EE_|CH3PR11MB7321:EE_
x-ms-office365-filtering-correlation-id: 44c5ffb9-1dbd-4d56-0be5-08dc2985e6b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gi7f4J8vB0Y7+EnEQLYOUvBAXvyiyGYTvThPtvgveqSAby1KPVhfYIbVNKPWwe+Ams6z6UTid4FMZ3cDUpsm0AD9cxZHpJ9NW3CCoTkIIKJIbAnto9+WH7Z1mYGOEdJzJ9eeniuHvQxZrG4xqRgmmqViuyLju0E3FIPGlXRKN58dtQ3MSeZnMWJ2HakX2/JHo7r0em1OGCF8N3c3+WeKxWe1HwnvKZUd4nGu407hMQgBWMl+rI5pCi8EEKVxY7kUDdZNQx3pGE277yL6UeiBobuyCnn6R2WcaI5FVk0SMX8pryRvD+3/5hk7SVww4xxCu54vfhr5s0Of2HmNmH24L+f6bKjtHdv8akOM3KKdPZx66Kutk8XI5/ezocboqrB6r46pqeCzu6T8h+0TVdySQG9WiajD/KHIiLNsApZKhBk4/a4wfFtRfIhy+SsVpSyYNMonK3rWzlZM1/a5r4z05w4qWY0+Y3jIpFm2ip3+tgcrP1tcjM/w9eFQOp+qAWrqNhQ5gvrJIw26dMGI+0lpPTMUwtybPPoBpNd4HNZSHAs93Bm9oQ3dQ608AF6h+DnVghZLPcgA9BajNWqwtYITPlBrTRz8eM52wk5CrJ8kr0w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8313.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(376002)(366004)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(2906002)(5660300002)(52536014)(15650500001)(41300700001)(83380400001)(26005)(107886003)(82960400001)(38100700002)(122000001)(86362001)(38070700009)(54906003)(66476007)(71200400001)(8936002)(64756008)(33656002)(66556008)(66446008)(7696005)(76116006)(966005)(478600001)(8676002)(66946007)(9686003)(110136005)(6506007)(4326008)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7sPiE/JFHN2jG+/erjj6ql2J1n/ivXXLtq6niec9p0KARqpEhg2ZjD4A9XZL?=
 =?us-ascii?Q?AbbZYBOgv0xXbyVI58/OpJkEIH1bHbfQlBzNupGgI6wIJE1yNhRTDUjsk7+1?=
 =?us-ascii?Q?lHMLJVuXy+D1jXf0Whn58psx0LAHa589loP2lf5BQ6bnQ/toR4fenAYPMGN1?=
 =?us-ascii?Q?jxxDwdVwdBDBwZmWtDjUOVpo2H2TgMjWZhsI2NYyhdSJdzGdb0LvUf6J56TC?=
 =?us-ascii?Q?xmZlmr4nkoBllHJDjWBxseydmcld2aPrKqXDz04laEksOd50WNlLIrWU1zJt?=
 =?us-ascii?Q?gOJmYpNX3oRb3KjpVbu/KkG5h0pPy+b2P8fDjmuYzvqfZbRx7gezvPZi9qvi?=
 =?us-ascii?Q?eTTecg2sQiANDhQ/Q+VarO1+i++DnU+PLuE+MzphVUo/bViG91PBGfO1+9vn?=
 =?us-ascii?Q?UdQgbZsC949IsviJFWT1lGdi6J95LQaOUaDZrbXnJ1LoRfyt98tbivhUyaEx?=
 =?us-ascii?Q?KPK5MJXR5ZshJf1GtpHm0vX5r/RTL150gR0DRrAGryHTXkrNx8grjg7dT3jA?=
 =?us-ascii?Q?gVTTRr/h0abd+s/uYlDL4o57rvncWOS9yxtMnCkGyPswtbigwWsAA3rWfFw0?=
 =?us-ascii?Q?1/ubq6Tk/FXbSU0peVW2SfB7QmuPHONwWcZg3GoFYI7o2sF8ir9+oOT8orB/?=
 =?us-ascii?Q?4yFirBxbTH3A1+nwuN6Ec4FXTcHAP3mkhgIB4q1GPfLDuHa98lkvsfqoW8v+?=
 =?us-ascii?Q?ZT1V5K7G8YY/BB1XdLmM82Qq9xHcLr7awvJZ4X1qlnqhrOW1hfhJzEXgSrqw?=
 =?us-ascii?Q?opcpMwD5apZZGzKWFubUm0+g2oSrZNsCnSFfVSaJWesv2inOlWsZju7tnkg9?=
 =?us-ascii?Q?1ojvdkjpbHNIYktYypYRxHUqrbTCEXwHPTjF7qlHhPQWxU9cNELoIfOorLSh?=
 =?us-ascii?Q?r8cE+iZSKzxNNG8xZvVPK/ghGclWu+S6ZY1Q5fyRKVsxPhIej9ToxYXo8Dgv?=
 =?us-ascii?Q?e12g4arlidr8q5r5h6FWSLjo8IRc0j0Jj8UhQkH+b8IksgYC27iKbyAguzBZ?=
 =?us-ascii?Q?GXQskET1R7X9gtLsw6gCmXHGUhWAbDkgBTGVeHO5YA5UcDfmF3oWAfCJySTP?=
 =?us-ascii?Q?Cj/ZbMhGMav89jIGcpAU0JpOMhU6c33dfQWGQWqmDEbDdvNXp8NTN/Lbm7DV?=
 =?us-ascii?Q?RcZSn8XJQyZsP/xGujwpap4U3mmSJN5ptqr/LHFWE0b7C3uw/unRyCIptRUS?=
 =?us-ascii?Q?FqhjQNL7teJL4dH4cH+G6d4i6M7v/Bhy1g4FOdj//heUtTugW+s7nOGDUnIE?=
 =?us-ascii?Q?d8dBbcO/02jUEc7dqUg+seHNVejCpwH6sdRgubMv/zbBW4KhUzusr06dj4P1?=
 =?us-ascii?Q?HQslqAQnF0Ei9QHhcYnqtzRF/5WlIeVBXnxfiAF82tCLksyjrTzW++BbkMHN?=
 =?us-ascii?Q?Un7SeSNy7zuyOi+8K7u+5M1fhCB2ZW2sfUEJvoBNlCh+AMtZBCcXxwMGn/gZ?=
 =?us-ascii?Q?d/82E6Q1rWpkCb+1pnW3yO6zxngu3gDgmzjzju5iYLDrZkuZigCpYmPrEubr?=
 =?us-ascii?Q?4pITslv2GV/dPvru1OKFWWB1t/lz0Cnpo6JlILHGsjSBVrcM8uvdYz+DNQJL?=
 =?us-ascii?Q?meHi+buKYqaczRoRL+HDnbHQIQ1ianyyKx6X894h?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8313.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c5ffb9-1dbd-4d56-0be5-08dc2985e6b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 15:43:45.7558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K157JrRzMoyXPruEu2XhsoiS/+Uekuq2jirPvZukUmItmr5+mIqFG1ZzL/yZ1zQFzcpYXYrBqcv0baV18SKArQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7321
X-OriginatorOrg: intel.com



>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Fijalkowski, Maciej
>Sent: Tuesday, February 6, 2024 6:12 PM
>To: intel-wired-lan@lists.osuosl.org
>Cc: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>;
>netdev@vger.kernel.org; Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
>Seth Forshee <sforshee@kernel.org>; Simon Horman <horms@kernel.org>;
>Karlsson, Magnus <magnus.karlsson@intel.com>
>Subject: [Intel-wired-lan] [PATCH v2 iwl-net 2/2] i40e: take into account =
XDP Tx
>queues when stopping rings
>
>Seth reported that on his side XDP traffic can not survive a round of down=
/up
>against i40e interface. Dmesg output was telling us that we were not able =
to
>disable the very first XDP ring. That was due to the fact that in
>i40e_vsi_stop_rings() in a pre-work that is done before calling
>i40e_vsi_wait_queues_disabled(), XDP Tx queues were not taken into the
>account.
>
>To fix this, let us distinguish between Rx and Tx queue boundaries and tak=
e into
>the account XDP queues for Tx side.
>
>Reported-by: Seth Forshee <sforshee@kernel.org>
>Closes: https://lore.kernel.org/netdev/ZbkE7Ep1N1Ou17sA@do-x1extreme/
>Fixes: 65662a8dcdd0 ("i40e: Fix logic of disabling queues")
>Tested-by: Seth Forshee <sforshee@kernel.org>
>Reviewed-by: Simon Horman <horms@kernel.org>
>Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>---
> drivers/net/ethernet/intel/i40e/i40e_main.c | 14 ++++++++------
> 1 file changed, 8 insertions(+), 6 deletions(-)
>

Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worke=
r at Intel)

