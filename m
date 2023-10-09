Return-Path: <netdev+bounces-39350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDED7BEE7D
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 00:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247FE1C2094D
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 22:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CCA18B1F;
	Mon,  9 Oct 2023 22:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FMCRLjm9"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DD91428B
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 22:49:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAFB9C;
	Mon,  9 Oct 2023 15:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696891779; x=1728427779;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uUfwCPYHdzrTZoeJhWD2IerxGRIvGaDAJMV2yDfTa0g=;
  b=FMCRLjm9kNQ2pp9mP3ROcpLI+eOOcAk7oGds5PyCAGOx6ubAMvJl5nI7
   Gc6LwVxifY/vSmpYoKIHHtg/EKpvBNgztQsAOB0x9BDnnsS5onGPefQX+
   ZVx/6tVbHrtzquIzsJRMtzvdC0D6uUlEQPgA3X970+PuQNU14ngrWSnb1
   ALpX5MmJkW4VM4Sruyy6ZYv+paPdG4E1Ey9ga/SibUwHiNvdEIBJM40Ig
   J5ZLVsbS07Soslrv6oyzci8pvgLAs5gI1DnALE2LfnwGXnYeMA0qL3waF
   MKOx17+CuJslQ4ou7DJp+YDkdIXoZvZ6yAA+qBoY75werIKcBJDliT/3D
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="374603583"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="374603583"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 15:49:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="818993266"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="818993266"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 15:49:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 15:49:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 15:49:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 15:49:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvCyG9XqmBZgWe3XSWVDjLQ+Bvda/AhHl5IQLEKBzMsk2xEvx5NgEnmEwmcGUQXIRhSorOQVWfVx0410kcEtpfkSwDnxJiXPkCoduDiu01IPA1RsovJlGNB/PkoxYRiUqHT6Nj4EuM9Nl9XvYszfIrxOL+VuqAJp5Z1fFAtg1SCIU85PYLEHHZzrTZXy/kpbTAeHIPn/R7/s7ABOJqojJiOb+PYOlr1i6Cm2Zi71iVsBXXBnjQMbxodK+2F1lN7rgt8seRsvAl09wK1grRhM5RPlcpBYae6BA9+Wzx0WMGLsPVftLDT3d/K6k3DPzhjmFIxFtb5lNoHE3yJYE2RiXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bl3aRZE9z9UMX4P96Oy9L2Xi9dAYOc6CiaEncYN98tc=;
 b=EwUh/eM6C3dmJG2BlfAvwYbS4hTlEVyLcfmJs/WdSFulf6ia3PncrCD3PDwV4WgeVT+ZSFPJ/lljPpPw+ta2Px3gyUiY5hnqasAg0/2GVUPMRKtfH1ATV2ftciU5rBlNg8hZUfbG1JUmpQ/hwruaAEZzR6bVGTKpRoTfR1vDq2hOEnQ++uueE4CXTCnULNVRJInljxlSxIOHQi31WnZWKtZdqE47W88eKzMf2gPnx/tlhbteJ2XgAjW8qFQ11Hk5m9wvAd0OQ3ymflQo7SphVbmTDc3Y3Q5GEJGvjZB3wNu1745Z3spwS90B6fpVE/ahMbM4lC1+zf3H3Siv9T7xMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 CY8PR11MB7897.namprd11.prod.outlook.com (2603:10b6:930:7d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.37; Mon, 9 Oct 2023 22:49:35 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::4c69:ab61:fea5:5a7f]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::4c69:ab61:fea5:5a7f%3]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 22:49:34 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "corbet@lwn.net"
	<corbet@lwn.net>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
Subject: RE: [PATCH net-next v3 3/5] dpll: netlink/core: add support for
 pin-dpll signal phase offset/adjust
Thread-Topic: [PATCH net-next v3 3/5] dpll: netlink/core: add support for
 pin-dpll signal phase offset/adjust
Thread-Index: AQHZ+Epp4G5oik609kSdIhZl6Ji+LbA8s1KAgAVhXnA=
Date: Mon, 9 Oct 2023 22:49:34 +0000
Message-ID: <DM6PR11MB46574AF7CDE51D16736A47DB9BCEA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20231006114101.1608796-1-arkadiusz.kubalewski@intel.com>
 <20231006114101.1608796-4-arkadiusz.kubalewski@intel.com>
 <ZR//rQ7WGmHeRBOP@nanopsycho>
In-Reply-To: <ZR//rQ7WGmHeRBOP@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|CY8PR11MB7897:EE_
x-ms-office365-filtering-correlation-id: afa5efc4-73b3-428d-a05a-08dbc91a01f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YE8Sbyqh6AJ9dpq/f8DjGauaPEuXyTXnn1NL7JLa5sJYtBLIXk3TkmIiAR0o4a/0UP0ZK275e9mzDnl0uJNTeMbo4HWLPwY0YhelhvX4ZaCq04Ee1w+Mr95CFBqEwo0QT9viG1VI/pj6/LYbpnuoGOa/+uTBCy+aUfnNhUxkszWqTEcAWyYhhM6cbCdhVaY3zfxHbtxhPXsrzt8B5bMoz9jFgXNLIP2rzO5c9VUtjh+I8fdicrO4IvozCTpmIR2lKl3mNCf6kfKWsrIz4srB5gDBBXrP8fMRH6BIbuAqQy3m8tHs1XCRsBSzqtMCqIxVVNooWQWeS3i4uWnv5fB4KlBIp23h7TwuSGurJEz/f9XfjbmZ1DNEYYj8l1MqCBJlYo9vReyT2ju8G0qf7u4X6ZxXsGH3w+nH1x8E8dNNPQdYyWWvPjvTqxOOEqDQLWSm22Jn2DDYfUozyFktFHqFBFI8OCkHC6gf0DOM/AHG1/sFGUgDX9UvXbAXKUBDtdJ8W9jKiUUHo18VyyN5+N68bpRmgHTTANj7ZKAGNBLM0hf0wvgFub5PLaMMK3z2itQLKSqdYosJKb2AyaRcfaEwH/G6NGc34kLRK/S4wW3mw48qeZZs0rgS4IGnjj0zFSxz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(376002)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(55016003)(83380400001)(76116006)(26005)(54906003)(66556008)(66476007)(6916009)(66946007)(64756008)(316002)(66446008)(4326008)(5660300002)(8676002)(7696005)(41300700001)(6506007)(71200400001)(52536014)(2906002)(9686003)(478600001)(8936002)(33656002)(122000001)(82960400001)(86362001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d+hTjVBflLhgM8oKZ+KaDrEm0W031QnW7bDWhF337pNLQNrUsVTv8UWIg1qJ?=
 =?us-ascii?Q?L1wzsyM3uWlT6Ho6admtQtg7wbCbkf5JZL4BNuUDEqRxX7uW2VRSoIDcVGIF?=
 =?us-ascii?Q?9Gfqe1rJvQzFo7bvg8Ds0FeR0UzXDCYkeF6Par9aQ5RoOCunauIrZCE+CE1q?=
 =?us-ascii?Q?dSTBpm6a09ReEgnYgKgad5ZOIfzD5BMTU2xeNCyOSmMNOwm3F8riMJmdv/FV?=
 =?us-ascii?Q?rGD33mJrjiIhfiXfhBzfIjGk+xHCsOsBkS5tDMust2DQN2G1cu7La0EFk2lz?=
 =?us-ascii?Q?2Yt7HsiccT3Ts605h+cDLWr9JWzj6jxvzruV74ArvkXdl3hlwrAWr8+jIJn1?=
 =?us-ascii?Q?T84112tx9Jy4aQjR0ZVXT/SOyCwcpp86mwY3w+TNFMwCP5qLEnm/bvsPDuAa?=
 =?us-ascii?Q?lM290LD3YXrrRq/NoZCrO0D1l84O5+ca7yx1pnmgQ9oVtnHn7fk5ErekJM0V?=
 =?us-ascii?Q?XGbf+nfo8tF+eqM8tcSgw3VPm+4DxnCbBF3E5yLo9yNHBISbyUrvC9z4KQhs?=
 =?us-ascii?Q?JpGr04me4du/1lY3sw1+pwAlW1gNotIcK6Pugp7QvY2Y8Z+4QBvA35cBI1Dm?=
 =?us-ascii?Q?q6LNdW2C6YC0+Q8ohfuCZNOIE7f2F3q1YQQh1jmtd8T1ASZPDAeBWM6ms4jH?=
 =?us-ascii?Q?lSlyBu3uJel9fM+jA0Yz+/HXQmQFluXxy7n18+6auJzhHjnYyWG5huLg+s25?=
 =?us-ascii?Q?pXvv56ETZJHejeMnvK+yL5T9jbYVAyUS48MbFLeR5cYfviAG2lkCBX85A+Is?=
 =?us-ascii?Q?BPa9IU8/YkQSUMnIg7L8FMnxTXWljd30DUjczjs6BKcRBR86vNGza48+f+fB?=
 =?us-ascii?Q?oL9BUzaGyWeXDptaXerbIbE02B43BmLjNaLbfsvT9Mcix2G6NQrV68epvmvS?=
 =?us-ascii?Q?1rmNxmiNtJq1USW1eXkQO8ZbzJsL0Oo8mu5VMRAArQsfs81zaFlFbyBa0DYx?=
 =?us-ascii?Q?jeo8duHRseI62/cQtbrc4pCQbbAOF8tHNAQ3hFgn7YnSYhtOoSnMqlOloRw9?=
 =?us-ascii?Q?H9T+j8o3fbA6Wkn2NoLV+uIssA6e8NhB0TnE5dXF1q+5lGWAeSqOrb2b/p8f?=
 =?us-ascii?Q?eUbtjgqlCM+EutRd6EfyvfhcOT1KzehkGNJwvxXdAe1AOm855hxjC/PvkAH7?=
 =?us-ascii?Q?xGIg3rvOlKLwPjo2yyPEWsos53dbuuOvydQDfXTjrL42jADQWu9Ve0upiXgj?=
 =?us-ascii?Q?jPKSYyDP+7nI2cYTBx6KVDbNsO69ypKpkkcLxDtQg+UONYZuZK85gW6TtVau?=
 =?us-ascii?Q?N2epAahQJJaksARYIuKe3Iw6MENTDiEP13bnaBrzgXfhjSPCU5E8uTyABw+U?=
 =?us-ascii?Q?pUCJ6wAFNP+aYWdvsKoUI2rjVY6Hnl4TC4ReN9ZMZqYXGCSQLlPUsaluW2Qb?=
 =?us-ascii?Q?MqRlNdNW4Pxo/orKDnMVe7vDbH7gZWkfspNs04RrE0uDB2bt1N5tGEEpLpei?=
 =?us-ascii?Q?g9GyMsbQJ9xm0p8vquyd9gWELO/ab1J9hQzYVe6xW0gQZsEFbsWtiLi1fD0k?=
 =?us-ascii?Q?5Z1djtd74DDcTHIkPRRB/i3HpBx+J+GpPeR8JlTMYW8exqhxDdKS8pJneqFG?=
 =?us-ascii?Q?ySzwiWei1kiLEedXepzQGDTz+7VwEQ9/8+OIo10wEQobg3CICm4fBTvtXyuB?=
 =?us-ascii?Q?WA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa5efc4-73b3-428d-a05a-08dbc91a01f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 22:49:34.2206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xb7tUiA4Dm82TzMZeXZG2BDeKSeDTf8vuvJGAqs/bXOsvgVoH637VMshT04P402PT4DDVDONMINX00eVoobf7omrs476n1JOTsj3JsNJ46A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7897
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Friday, October 6, 2023 2:38 PM
>
>Fri, Oct 06, 2023 at 01:40:59PM CEST, arkadiusz.kubalewski@intel.com wrote=
:
>>Add callback ops for pin-dpll phase measurment.
>>Add callback for pin signal phase adjustment.
>>Add min and max phase adjustment values to pin proprties.
>>Invoke callbacks in dpll_netlink.c when filling the pin details to
>>provide user with phase related attribute values.
>>
>>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>---
>> drivers/dpll/dpll_netlink.c | 130 +++++++++++++++++++++++++++++++++++-
>> include/linux/dpll.h        |  18 +++++
>> 2 files changed, 147 insertions(+), 1 deletion(-)
>>
>>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>>index e20daba6896a..97319a9e4667 100644
>>--- a/drivers/dpll/dpll_netlink.c
>>+++ b/drivers/dpll/dpll_netlink.c
>>@@ -212,6 +212,53 @@ dpll_msg_add_pin_direction(struct sk_buff *msg,
>>struct dpll_pin *pin,
>> 	return 0;
>> }
>>
>>+static int
>>+dpll_msg_add_pin_phase_adjust(struct sk_buff *msg, struct dpll_pin *pin,
>>+			      struct dpll_pin_ref *ref,
>>+			      struct netlink_ext_ack *extack)
>>+{
>>+	const struct dpll_pin_ops *ops =3D dpll_pin_ops(ref);
>>+	struct dpll_device *dpll =3D ref->dpll;
>>+	s32 phase_adjust;
>>+	int ret;
>>+
>>+	if (!ops->phase_adjust_get)
>>+		return 0;
>>+	ret =3D ops->phase_adjust_get(pin, dpll_pin_on_dpll_priv(dpll, pin),
>>+				    dpll, dpll_priv(dpll),
>>+				    &phase_adjust, extack);
>>+	if (ret)
>>+		return ret;
>>+	if (nla_put_s32(msg, DPLL_A_PIN_PHASE_ADJUST, phase_adjust))
>>+		return -EMSGSIZE;
>>+
>>+	return 0;
>>+}
>>+
>>+static int
>>+dpll_msg_add_phase_offset(struct sk_buff *msg, struct dpll_pin *pin,
>>+			  struct dpll_pin_ref *ref,
>>+			  struct netlink_ext_ack *extack)
>>+{
>>+	const struct dpll_pin_ops *ops =3D dpll_pin_ops(ref);
>>+	struct dpll_device *dpll =3D ref->dpll;
>>+	s64 phase_offset;
>>+	int ret;
>>+
>>+	if (!ops->phase_offset_get)
>>+		return 0;
>>+	ret =3D ops->phase_offset_get(pin, dpll_pin_on_dpll_priv(dpll, pin),
>>+				    dpll, dpll_priv(dpll), &phase_offset,
>>+				    extack);
>>+	if (ret)
>>+		return ret;
>>+	if (nla_put_64bit(msg, DPLL_A_PIN_PHASE_OFFSET, sizeof(phase_offset),
>>+			  &phase_offset, DPLL_A_PIN_PAD))
>>+		return -EMSGSIZE;
>>+
>>+	return 0;
>>+}
>>+
>> static int
>> dpll_msg_add_pin_freq(struct sk_buff *msg, struct dpll_pin *pin,
>> 		      struct dpll_pin_ref *ref, struct netlink_ext_ack *extack)
>>@@ -330,6 +377,9 @@ dpll_msg_add_pin_dplls(struct sk_buff *msg, struct
>>dpll_pin *pin,
>> 		if (ret)
>> 			goto nest_cancel;
>> 		ret =3D dpll_msg_add_pin_direction(msg, pin, ref, extack);
>>+		if (ret)
>>+			goto nest_cancel;
>>+		ret =3D dpll_msg_add_phase_offset(msg, pin, ref, extack);
>> 		if (ret)
>> 			goto nest_cancel;
>> 		nla_nest_end(msg, attr);
>>@@ -377,6 +427,15 @@ dpll_cmd_pin_get_one(struct sk_buff *msg, struct
>>dpll_pin *pin,
>> 	if (nla_put_u32(msg, DPLL_A_PIN_CAPABILITIES, prop->capabilities))
>> 		return -EMSGSIZE;
>> 	ret =3D dpll_msg_add_pin_freq(msg, pin, ref, extack);
>>+	if (ret)
>>+		return ret;
>>+	if (nla_put_s32(msg, DPLL_A_PIN_PHASE_ADJUST_MIN,
>>+			prop->phase_range.min))
>>+		return -EMSGSIZE;
>>+	if (nla_put_s32(msg, DPLL_A_PIN_PHASE_ADJUST_MAX,
>>+			prop->phase_range.max))
>>+		return -EMSGSIZE;
>>+	ret =3D dpll_msg_add_pin_phase_adjust(msg, pin, ref, extack);
>> 	if (ret)
>> 		return ret;
>> 	if (xa_empty(&pin->parent_refs))
>>@@ -416,7 +475,7 @@ dpll_device_get_one(struct dpll_device *dpll, struct
>>sk_buff *msg,
>> 	if (nla_put_u32(msg, DPLL_A_TYPE, dpll->type))
>> 		return -EMSGSIZE;
>>
>>-	return ret;
>>+	return 0;
>> }
>>
>> static int
>>@@ -705,6 +764,70 @@ dpll_pin_direction_set(struct dpll_pin *pin, struct
>>dpll_device *dpll,
>> 	return 0;
>> }
>>
>>+static int
>>+dpll_pin_phase_adj_set(struct dpll_pin *pin, struct nlattr
>>*phase_adj_attr,
>>+		       struct netlink_ext_ack *extack)
>>+{
>>+	struct dpll_pin_ref *ref, *failed;
>>+	const struct dpll_pin_ops *ops;
>>+	s32 phase_adj, old_phase_adj;
>>+	struct dpll_device *dpll;
>>+	unsigned long i;
>>+	int ret;
>>+
>>+	phase_adj =3D nla_get_s32(phase_adj_attr);
>>+	if (phase_adj > pin->prop->phase_range.max ||
>>+	    phase_adj < pin->prop->phase_range.min) {
>>+		NL_SET_ERR_MSG(extack, "phase adjust value not supported");
>>+		return -EINVAL;
>>+	}
>>+	xa_for_each(&pin->dpll_refs, i, ref) {
>>+		ops =3D dpll_pin_ops(ref);
>>+		if (!ops->phase_adjust_set || !ops->phase_adjust_get)
>
>Extack msg.
>

Fixed.

>
>>+			return -EOPNOTSUPP;
>>+	}
>>+	ref =3D dpll_xa_ref_dpll_first(&pin->dpll_refs);
>>+	ops =3D dpll_pin_ops(ref);
>>+	dpll =3D ref->dpll;
>>+	ret =3D ops->phase_adjust_get(pin, dpll_pin_on_dpll_priv(dpll, pin),
>>+				    dpll, dpll_priv(dpll), &old_phase_adj,
>>+				    extack);
>>+	if (ret) {
>>+		NL_SET_ERR_MSG(extack, "unable to get old phase adjust value");
>>+		return ret;
>>+	}
>>+	if (phase_adj =3D=3D old_phase_adj)
>>+		return 0;
>>+	xa_for_each(&pin->dpll_refs, i, ref) {
>>+		ops =3D dpll_pin_ops(ref);
>>+		dpll =3D ref->dpll;
>>+		ret =3D ops->phase_adjust_set(pin,
>>+					    dpll_pin_on_dpll_priv(dpll, pin),
>>+					    dpll, dpll_priv(dpll), phase_adj,
>>+					    extack);
>>+		if (ret) {
>>+			failed =3D ref;
>
>Extack msg.
>

Fixed.

Thank you!
Arkadiusz

>>+			goto rollback;
>>+		}
>>+	}
>>+	__dpll_pin_change_ntf(pin);
>>+
>>+	return 0;
>>+
>>+rollback:
>>+	xa_for_each(&pin->dpll_refs, i, ref) {
>>+		if (ref =3D=3D failed)
>>+			break;
>>+		ops =3D dpll_pin_ops(ref);
>>+		dpll =3D ref->dpll;
>>+		if (ops->phase_adjust_set(pin, dpll_pin_on_dpll_priv(dpll,
>>pin),
>>+					  dpll, dpll_priv(dpll), old_phase_adj,
>>+					  extack))
>>+			NL_SET_ERR_MSG(extack, "set phase adjust rollback
>>failed");
>>+	}
>>+	return ret;
>>+}
>>+
>> static int
>> dpll_pin_parent_device_set(struct dpll_pin *pin, struct nlattr
>>*parent_nest,
>> 			   struct netlink_ext_ack *extack)
>>@@ -793,6 +916,11 @@ dpll_pin_set_from_nlattr(struct dpll_pin *pin, struc=
t
>>genl_info *info)
>> 			if (ret)
>> 				return ret;
>> 			break;
>>+		case DPLL_A_PIN_PHASE_ADJUST:
>>+			ret =3D dpll_pin_phase_adj_set(pin, a, info->extack);
>>+			if (ret)
>>+				return ret;
>>+			break;
>> 		case DPLL_A_PIN_PARENT_DEVICE:
>> 			ret =3D dpll_pin_parent_device_set(pin, a, info->extack);
>> 			if (ret)
>>diff --git a/include/linux/dpll.h b/include/linux/dpll.h
>>index bbc480cd2932..578fc5fa3750 100644
>>--- a/include/linux/dpll.h
>>+++ b/include/linux/dpll.h
>>@@ -68,6 +68,18 @@ struct dpll_pin_ops {
>> 	int (*prio_set)(const struct dpll_pin *pin, void *pin_priv,
>> 			const struct dpll_device *dpll, void *dpll_priv,
>> 			const u32 prio, struct netlink_ext_ack *extack);
>>+	int (*phase_offset_get)(const struct dpll_pin *pin, void *pin_priv,
>>+				const struct dpll_device *dpll, void *dpll_priv,
>>+				s64 *phase_offset,
>>+				struct netlink_ext_ack *extack);
>>+	int (*phase_adjust_get)(const struct dpll_pin *pin, void *pin_priv,
>>+				const struct dpll_device *dpll, void *dpll_priv,
>>+				s32 *phase_adjust,
>>+				struct netlink_ext_ack *extack);
>>+	int (*phase_adjust_set)(const struct dpll_pin *pin, void *pin_priv,
>>+				const struct dpll_device *dpll, void *dpll_priv,
>>+				const s32 phase_adjust,
>>+				struct netlink_ext_ack *extack);
>> };
>>
>> struct dpll_pin_frequency {
>>@@ -91,6 +103,11 @@ struct dpll_pin_frequency {
>> #define DPLL_PIN_FREQUENCY_DCF77 \
>> 	DPLL_PIN_FREQUENCY(DPLL_PIN_FREQUENCY_77_5_KHZ)
>>
>>+struct dpll_pin_phase_adjust_range {
>>+	s32 min;
>>+	s32 max;
>>+};
>>+
>> struct dpll_pin_properties {
>> 	const char *board_label;
>> 	const char *panel_label;
>>@@ -99,6 +116,7 @@ struct dpll_pin_properties {
>> 	unsigned long capabilities;
>> 	u32 freq_supported_num;
>> 	struct dpll_pin_frequency *freq_supported;
>>+	struct dpll_pin_phase_adjust_range phase_range;
>> };
>>
>> #if IS_ENABLED(CONFIG_DPLL)
>>--
>>2.38.1
>>

