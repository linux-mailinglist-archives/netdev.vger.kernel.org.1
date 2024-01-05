Return-Path: <netdev+bounces-61939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1B382547F
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 14:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8BF1C21562
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 13:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B8A2D61B;
	Fri,  5 Jan 2024 13:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K2s5/TpN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9B82D787
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 13:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704461526; x=1735997526;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/q0uv6FRgDLDNYwacCgVD+Nci3hCTW1C8bXUBWy9/LE=;
  b=K2s5/TpNIi4gfd4SVDvWQ3HbKk+DBZZxbVLPv5QhMU++qXWAM/cYYBX1
   1G8Ny3qE86U8sQ2NtnOmgjXahZy/WZ6JYMqYeAElp5uRuuOJecfToGU5P
   LObYqE47p7DMvVKYQIhST4csvmV7++a6oZ0qj1XClxwvQ5Fo6csGhMVvK
   xnqLjM8NtoR1MJ0+KTTmxo7qYX9mpEz5uUWn6aRvTZdtlscyhZgA7YwKK
   2ANgPtfZkwk8cBicrqASu4MlCxvmkYjak3aDTnd9Mao3ofdKZlrp4Q+Ip
   yMaT5It78upJ0CGR9BiFVRSuwaC1SJhwNQkgmxl6VyGxB66dldmFHh27W
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="401291309"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="401291309"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 05:32:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="730475987"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="730475987"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jan 2024 05:32:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 05:32:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Jan 2024 05:32:04 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Jan 2024 05:32:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqUxANQsRJVKZX5UVitGmeR8QP5xzmL0FxgrlHlhGJ20nvUW9CCPMejT4b2Hg/44mizxwlIwwWnAm6NchjcHyNrIrPQSLkPQu9+VgMum/zIR0NaEzP695v7gQJg1zf8+9sVjpM6BSpQbdr2Qkrn6o4CjJnN/dq4S0+x6n+ambgPuT/Ma6QL1A3z4hDtYTHPHlSit8LAukqvcfQroa745flL8sDtyMzJzZz/etUjkdRWgs5PcxxEC1sLKU2iRR0+cLwoHMApRT2FSC21DWsgO1en8YhPwuoWXFA/jwLq34hSixdFu/DG2S9+p5wf6sh8+lk28WGeQlEIjSL9ELhcidg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMvekyNf+gNQzwssaFwmQYMoQSbIofgs1UHu5AUktBY=;
 b=fac625Qb55y05/v6Uf6tzJiPI1buuYuNakeFhbIv6JHWtCJka7sC7CM1ANRdPjASJCCARtvfJK4f74ob1MfPRxtCPctFa240KXjX1pLSmRA3QyWwbcR2qReLQ/PaBWERlKzL6vFL3fl9HtfPJ34qvekpq/5kSxjBUN/XoxTCcl6uDzf/1Ii1MpIhCvFPF8ITlTUQK05682Csmgf8C/YcUvc63GyPCKDMYKQgi45YNC+7DvNVlpe4Tky+E1Zi0OYd0SZkWdGE0CA6vWx6wjMKn5jlTMsC8ua/aEe2kMo1Z4B+wbS4YciuMcfkkHMabzwd3TrEY/zxSws/ynoMzygu3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 PH0PR11MB5593.namprd11.prod.outlook.com (2603:10b6:510:e0::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.16; Fri, 5 Jan 2024 13:32:00 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::89c2:9523:99e2:176a]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::89c2:9523:99e2:176a%6]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 13:32:00 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "M, Saeed" <saeedm@nvidia.com>,
	"leon@kernel.org" <leon@kernel.org>, "Michalik, Michal"
	<michal.michalik@intel.com>, "rrameshbabu@nvidia.com"
	<rrameshbabu@nvidia.com>
Subject: RE: [patch net-next 1/3] dpll: expose fractional frequency offset
 value to user
Thread-Topic: [patch net-next 1/3] dpll: expose fractional frequency offset
 value to user
Thread-Index: AQHaPkjaiDPlYuBq0k2gBv76bCVBXLDLOQCw
Date: Fri, 5 Jan 2024 13:32:00 +0000
Message-ID: <DM6PR11MB46575D0FFEE161D2C32D26C99B662@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20240103132838.1501801-1-jiri@resnulli.us>
 <20240103132838.1501801-2-jiri@resnulli.us>
In-Reply-To: <20240103132838.1501801-2-jiri@resnulli.us>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|PH0PR11MB5593:EE_
x-ms-office365-filtering-correlation-id: d0a77b34-a9e1-4124-6a44-08dc0df2b22e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YYRGBBY1AJdqV2yD2DaPFp4Qon8wEdeSfU4YoCXcpSIrQfLIA1gzLfpb08kzAszvaGOsWpHpDy2f7/sNfdiOhbg2+8d31qBAvcmkCiYtlQXnBfyVkJQKtOde86qFwmqtJAgU2nalu4BMeRHbPxDoRd30j0FAZ/0e9jR5viPucOpwE2Q3LHRDWxZ/o+eO7AC3JODQL/vV3h9CiSX5+0shIy0/TWxVefTbb3cCZSb4RZtKJCqkcieO1sm/2IIty36ybA1P7MVk4QOB25+vUA1Tfqh7OTpbx1JWQJraxtELfWyPTGxSDzLQ969Kv3HqOL0bfPIu/IldH4gUUoBrQfyOMwoMMHMIihtsDKFg4VvonO8EZcm5d/8TjJCgba2/Xz/5iFz01DXmrPKgJT5BqdbIzxAzXZCOmXVIfGkd1k1OtRSlrMqv33/lx/qvWIlP2+xxVCOTJuYJ9QuXcQYjp00Hnh0cuKKDhYd955Ccxj0Y4AM2mO+qiQ4UmVGO/k6tm9Evp63NcYxki+5sjyIYaEkDBHz3y1B8A4gAxNc3InwPpRJd+49Bt7RwxiUo/6rhFzV5yb6HNrGeHOmZaqOK2lAfx3d+durVDgetN8wRMQY55a2i29OmVuk+a5GH1///xTNa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(376002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(66446008)(66946007)(66556008)(8676002)(66476007)(82960400001)(8936002)(64756008)(76116006)(316002)(110136005)(54906003)(5660300002)(7416002)(86362001)(2906002)(41300700001)(33656002)(38070700009)(4326008)(52536014)(6506007)(7696005)(55016003)(83380400001)(71200400001)(9686003)(26005)(122000001)(38100700002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+JHc+AXyo7buZZfF0UaPiQFvqYi3On3CIZFqkdCF7Q06cB49Awuhek9D/ds3?=
 =?us-ascii?Q?K6dr+jjNY5fbOxhN+zlEVye0Q6iX05pMJyED+IGMMgOBE+cBzAfTUMpEmxnc?=
 =?us-ascii?Q?ZkGYmARwWeQoipfgFFq3iQdEPW14dHDogluTFH74dGwEIXzsKWNLGzRIu5Rm?=
 =?us-ascii?Q?vc2kGPo7gTt4F2O+6V3hv9G6UN9ux0vRRlkEOJIjnyDlszlILiEL2GnpT0t2?=
 =?us-ascii?Q?421mhTZnk/kbjv5BwIC8XIsv+j6HFwF55gkQwghzzkDtCUeDA0SVCCrLb+Jt?=
 =?us-ascii?Q?e4y9HbbTHrz8/5gQpkch6Aond6ONHB4t9p9F4RaK/ZNfh8xJBwvkU5VAMpuN?=
 =?us-ascii?Q?HTgYxwkNGtl0LdMgN0N1Is9AD0Zfi0htdDApeKFZ9BWUpngsgY4g/6UNTwvd?=
 =?us-ascii?Q?mvSqUtAGd2SqPycf64Ss8LXpDwESjKQK3hscoLn4IAlkQrrsqFbg8DEamQ2v?=
 =?us-ascii?Q?nPVdDUw/aCcLAyyKl6l6Zn+/rjEVFABQlU+0qcKbi+UegUqJQuq35XkJHvss?=
 =?us-ascii?Q?Cn5G19dsMdl9gp9hXT4t8j+oYzygEoWUu3AQU/lgWSrAiO/HcXP0joueigIe?=
 =?us-ascii?Q?hEuwC9zv0ai+FNm2sphb577Gejf9HMsT2Kb2nn+U7guL2bdn/iIrO36+XHoA?=
 =?us-ascii?Q?Af6iIaMRcO3qL53FEqJiwSTCQmnzBUD/2A1mLOw3ZwdILrTbdP6ZLLNZ9Sar?=
 =?us-ascii?Q?IksvTQFYbgM0Z3fY9OevHaa17HWNoj/tchjDnPz2La+4fFhLUWjiTJCMJdfY?=
 =?us-ascii?Q?el77jamLzeK4UKt0aOJSgk59aSes2f3AnAL5Z2IpxBErk5Na3VH1dGvtXCR4?=
 =?us-ascii?Q?iLaTPiG3oX2er4E6Qdom3ejelrW8e6eolqEckaI6M9TtvWm31nu8biM3mYak?=
 =?us-ascii?Q?r6wpdUtROOLc5DbzZBV3vLbqFW15qVSeHoO7pB9RZtu1DGIIio50ExbqC1Bo?=
 =?us-ascii?Q?XgogFXNnRe+Yrm6eZn2hVar9+XsI/XNmj9pIhcvPaXa94iGhi05G1aoqrv9F?=
 =?us-ascii?Q?03s1MeWrgHoiv5Y/5s7OjQVNGEWVzHgCj/pQ6dKsPSXx6T6C3DrBI+mMTrhz?=
 =?us-ascii?Q?8rXrehmUIB0KytyJxYorpY3wR4n+cZ/F7NIQOm+fuX+xdoAQ2usU67iQ/YRi?=
 =?us-ascii?Q?v0ozNBNJI6u+cwHDxgqkTb8E4QoKg8rsIlLtPz8OHah6qQiK2FNLWcZXHA6u?=
 =?us-ascii?Q?L3VOb7kWfGx9tFhzsIclbPu+z1vJUEMbE5JsZee+56mCvG/ScY+Gw/afeoDS?=
 =?us-ascii?Q?WDrHzg4UvGbArm9tfZK13dToTdwCgvo2b7VIXPyoDoZiQ09E6U+UPLYsk2o8?=
 =?us-ascii?Q?lrNj7WULczgO63TWjtmX4wNxWsDSTXYjJEZh2JizPpLARTsvr6Td64u0dFgK?=
 =?us-ascii?Q?lWwmFG0quqdE56p51WztFswr2IKaf1RIlqZUaB/1X+urM9b4yZ7SnANPJ5rz?=
 =?us-ascii?Q?FCUheUJPMzUL4JFuLeLLR1y/s8O6Ka3/ChXuL1ZUKVc3i0U56uF/xA9zdrI6?=
 =?us-ascii?Q?Ysz32e/DmE8AJJ+iduEddYF9md/NRYpiJ6Wwv5H0HfpTLVDPiUQOMzl3DFrw?=
 =?us-ascii?Q?d6TM34d1A1z+0zheh1JQ/B0zPkzoeVFyHO/U4TaEpbeByyLOCk3FXb0bH/dK?=
 =?us-ascii?Q?0Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a77b34-a9e1-4124-6a44-08dc0df2b22e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2024 13:32:00.1868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ELaa3vZs/Q1VtqQc+wcvMkazkdXzTbQ6CGIXItB5CQeQ45h209vW6ZYzxccoSH+LT/emFGsj6o7ZEOE6QZPkjY+h4mz9KPX6U/qr7yU8TBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5593
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Wednesday, January 3, 2024 2:29 PM
>
>From: Jiri Pirko <jiri@nvidia.com>
>
>Add a new netlink attribute to expose fractional frequency offset value
>for a pin. Add an op to get the value from the driver.
>
>Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>---
> Documentation/netlink/specs/dpll.yaml | 11 +++++++++++
> drivers/dpll/dpll_netlink.c           | 24 ++++++++++++++++++++++++
> include/linux/dpll.h                  |  3 +++
> include/uapi/linux/dpll.h             |  1 +
> 4 files changed, 39 insertions(+)
>
>diff --git a/Documentation/netlink/specs/dpll.yaml
>b/Documentation/netlink/specs/dpll.yaml
>index cf8abe1c0550..b14aed18065f 100644
>--- a/Documentation/netlink/specs/dpll.yaml
>+++ b/Documentation/netlink/specs/dpll.yaml
>@@ -296,6 +296,16 @@ attribute-sets:
>       -
>         name: phase-offset
>         type: s64
>+      -
>+        name: fractional-frequency-offset
>+        type: sint
>+        doc: |
>+          The FFO (Fractional Frequency Offset) between the RX and TX
>+          symbol rate on the media associated with the pin:
>+          (rx_frequency-tx_frequency)/rx_frequency
>+          Value is in PPM (parts per million).
>+          This may be implemented for example for pin of type
>+          PIN_TYPE_SYNCE_ETH_PORT.
>   -
>     name: pin-parent-device
>     subset-of: pin
>@@ -460,6 +470,7 @@ operations:
>             - phase-adjust-min
>             - phase-adjust-max
>             - phase-adjust
>+            - fractional-frequency-offset
>
>       dump:
>         pre: dpll-lock-dumpit
>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>index 21c627e9401a..3370dbddb86b 100644
>--- a/drivers/dpll/dpll_netlink.c
>+++ b/drivers/dpll/dpll_netlink.c
>@@ -263,6 +263,27 @@ dpll_msg_add_phase_offset(struct sk_buff *msg, struct
>dpll_pin *pin,
> 	return 0;
> }
>
>+static int dpll_msg_add_ffo(struct sk_buff *msg, struct dpll_pin *pin,
>+			    struct dpll_pin_ref *ref,
>+			    struct netlink_ext_ack *extack)
>+{
>+	const struct dpll_pin_ops *ops =3D dpll_pin_ops(ref);
>+	struct dpll_device *dpll =3D ref->dpll;
>+	s64 ffo;
>+	int ret;
>+
>+	if (!ops->ffo_get)
>+		return 0;
>+	ret =3D ops->ffo_get(pin, dpll_pin_on_dpll_priv(dpll, pin),
>+			   dpll, dpll_priv(dpll), &ffo, extack);
>+	if (ret) {
>+		if (ret =3D=3D -ENODATA)
>+			return 0;
>+		return ret;
>+	}
>+	return nla_put_sint(msg, DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET,
>ffo);
>+}
>+
> static int
> dpll_msg_add_pin_freq(struct sk_buff *msg, struct dpll_pin *pin,
> 		      struct dpll_pin_ref *ref, struct netlink_ext_ack *extack)
>@@ -440,6 +461,9 @@ dpll_cmd_pin_get_one(struct sk_buff *msg, struct
>dpll_pin *pin,
> 			prop->phase_range.max))
> 		return -EMSGSIZE;
> 	ret =3D dpll_msg_add_pin_phase_adjust(msg, pin, ref, extack);
>+	if (ret)
>+		return ret;
>+	ret =3D dpll_msg_add_ffo(msg, pin, ref, extack);
> 	if (ret)
> 		return ret;
> 	if (xa_empty(&pin->parent_refs))
>diff --git a/include/linux/dpll.h b/include/linux/dpll.h
>index b1a5f9ca8ee5..9cf896ea1d41 100644
>--- a/include/linux/dpll.h
>+++ b/include/linux/dpll.h
>@@ -77,6 +77,9 @@ struct dpll_pin_ops {
> 				const struct dpll_device *dpll, void *dpll_priv,
> 				const s32 phase_adjust,
> 				struct netlink_ext_ack *extack);
>+	int (*ffo_get)(const struct dpll_pin *pin, void *pin_priv,
>+		       const struct dpll_device *dpll, void *dpll_priv,
>+		       s64 *ffo, struct netlink_ext_ack *extack);
> };
>
> struct dpll_pin_frequency {
>diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
>index 715a491d2727..b4e947f9bfbc 100644
>--- a/include/uapi/linux/dpll.h
>+++ b/include/uapi/linux/dpll.h
>@@ -179,6 +179,7 @@ enum dpll_a_pin {
> 	DPLL_A_PIN_PHASE_ADJUST_MAX,
> 	DPLL_A_PIN_PHASE_ADJUST,
> 	DPLL_A_PIN_PHASE_OFFSET,
>+	DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET,
>
> 	__DPLL_A_PIN_MAX,
> 	DPLL_A_PIN_MAX =3D (__DPLL_A_PIN_MAX - 1)
>--
>2.43.0

Hi Jiri,

In general looks good.

But one thing, there is no update to Documentation/driver-api/dpll.rst
Why not mention this new netlink attribute and some explanation for the
userspace in the non-source-code documentation?

Thanks!
Arkadiusz

