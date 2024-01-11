Return-Path: <netdev+bounces-62991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D33382AA85
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 10:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179D71F2339B
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 09:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D6FFBE5;
	Thu, 11 Jan 2024 09:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CmTJkXrM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBCE12E4D
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 09:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704964018; x=1736500018;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xckr5rs2gEJHR07xYZ9B5e2IDU565822wEg8V4j/kb0=;
  b=CmTJkXrMnir+i8m5AHHlteR+21oHW3uCMRuwUyuvQ+7UE4SIA4e29BNq
   czYLHDZ7f+31uLiN0ioyUjoXqg6HOtSslCu68DHNgRFfcX4jIJpOd8myB
   cGabRV+ognKjTGx2H+LhXO6Oa9dySKjZYMZa7RXCxe3RPOsrtl93SNZ8B
   D0sGbE0jo9mbE0nqc6rkOaD2j6i4MZO/bFV1uziyRVfzbTI+M6q5pz5uQ
   PGKO4PY2U6GwzXAAnMjH0zezWmRbgkm/GmQHjCWZf/aOAWXZjTxbBViXc
   Jq4X1f136rl2Z70Utjg82Jvz58+RM789OZY8StupIVCmxSyDI1Z3h5IeO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="17387973"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="17387973"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 01:06:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="782551254"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="782551254"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jan 2024 01:06:52 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 01:06:47 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Jan 2024 01:06:47 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Jan 2024 01:06:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyvMOQZb2VwfquSIH1ZG4HMgJFQdlYTLtczv6JZ8F5TAsREj0KZMDah0fqSfaTAy58dpVesUKfua8k/Y1HVn2aUlGmPi5L17RlSYUGMQxPYWPmcFciqXXYAI8c3mKjvRc8Olw2zig8y0ILh9TrRQege2nALdbQwfwIWAOEIpVqIhKyQVAGry5OaaHuyhCiMcBsuerW7TzVXZJzK2KqoHzJGpQ1hkIDnSG4YBw9IPqIdXGmCAHybYuR67g2/I/dCogPwlKvHv19j4gRhk7d04LnVzXqJ+PQwrzBDasXIF8QxQZykBEw2t5kMcMG7KF0hmNGjAlMmdJQLXWGdiOMHcrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=leEcoRqu1puvsKvNi67ZZDd+RZYev9oNmSdZoZ/3DdM=;
 b=iuF9xBQJaygQy5gt7qRya+95X2xmArIeEaJNwtnjsL5sh2p7+gvHH8alkrRggC5SwS3YcQYsba+tv4Bbius7EXDQ0wx0bBqrUtojpaw40A1l4cu4xjk3PVHkAI4C56n8b0Evjcl1CBSeomBzkEn+6Tb/oRXvg4jcwyVcLuFpXs0FcGutJIlZauK8XCfowZyqIUeeYikol3VvhOxbwLjSy0j+N6jogxsLNY3U8Cs8eCZYCzBofCZndsUC704+nsdwqGsni50oeQG0uTXdjBvYvc9u1assGGw4Y9OwTA5esoGFDQ2rgq8vDlmgVp6Gl3pNA0Uh12c9ZvfGm3ShHjM3QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 SA1PR11MB5778.namprd11.prod.outlook.com (2603:10b6:806:23f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Thu, 11 Jan
 2024 09:06:44 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::89c2:9523:99e2:176a]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::89c2:9523:99e2:176a%6]) with mapi id 15.20.7181.019; Thu, 11 Jan 2024
 09:06:44 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "Olech, Milena"
	<milena.olech@intel.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "Glaza, Jan" <jan.glaza@intel.com>
Subject: RE: [PATCH net v2 1/4] dpll: fix pin dump crash after module unbind
Thread-Topic: [PATCH net v2 1/4] dpll: fix pin dump crash after module unbind
Thread-Index: AQHaPv9HLGbDEz91QEqRLws3P6oY0rDJwcQAgAqZk/A=
Date: Thu, 11 Jan 2024 09:06:44 +0000
Message-ID: <DM6PR11MB465716178DF6F16D4F1DFFE59B682@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20240104111132.42730-1-arkadiusz.kubalewski@intel.com>
 <20240104111132.42730-2-arkadiusz.kubalewski@intel.com>
 <ZZbJ8I99ia4kbBL3@nanopsycho>
In-Reply-To: <ZZbJ8I99ia4kbBL3@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|SA1PR11MB5778:EE_
x-ms-office365-filtering-correlation-id: 68e1e74c-d3bb-40c0-f96d-08dc1284a232
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9pZkSsJQJYn14UDyVOhIvzUrL2TBQdQEgcTMhWSjKxMYuqem69UmjLwRmlY1Lfp8l7f0nXEQdngzjQ2coYgdIJvlzD+/L/ZQGsuazbSAYJIB4lGCBUAH859Z035XlAgj65+oNymK16c8m10VbUB1WAw8E0IAUsf26h94UTm14qrjATr/1hUx+CML/Tizk5p8AXlvm78bw1nKymxNStGj8cjHopNA0ry0NbAfj6C07RC9z5WTP8Yi69nFeTHHlpIXmC6VgI64XiHncZ9FYSpMyOSDS17xCUQAzNIlFP+NDQg/t6A817cxTIHQJpH2CUPSV0YpbbCFkpwNcQbSEuQzg+LdDMQVVK3ZKdDVD+nobFOv+MthGYmoY0ie7s0tYc9Hjp8rLCTGyGsT4RCJNl+LemUOvet4tFwhX5wIhQp9thcOdvRE2Tm6DxJtv/s0H7HvKOGhuU+gUqSKU3EXlTSTBspx+gylfO/ujiv6Ibsw5mBODH51zk5epVegiWVkBFpW9qkwxFlOvkJQUKRXkCUcB51QjupxoPMlx7rmMTrqM2UgbsYas/PsdZhed4xpLuysHDf/qABySraNQ/I1P+YscyAXGcmj71YtiPZ6BSYDSXpnZSe7aXdbd4X4FJw+e/NP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(366004)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(8676002)(33656002)(5660300002)(52536014)(2906002)(122000001)(8936002)(38100700002)(4326008)(41300700001)(82960400001)(86362001)(83380400001)(6506007)(7696005)(478600001)(66946007)(9686003)(26005)(66476007)(54906003)(66446008)(107886003)(6916009)(64756008)(316002)(76116006)(66556008)(38070700009)(71200400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?alvYzeKWcSjsUo5UP+7h6AbilDmVqzHmQ6a3yNIHVZMNNWNBm0FfVROgW7y3?=
 =?us-ascii?Q?7N8KT6Jleb95DUFi0Bk1llBuF8HwZCijInrhAHbvAN/Qo8YlEDeLvwQxcF/m?=
 =?us-ascii?Q?+O9jWj25+3z5EPu4NRuXFbaeeu64STvzLgoVFhtWJMPUDGE7FBiOLMa6ITAO?=
 =?us-ascii?Q?CaBmyM5dQJq1hpMDGzLgIPCnWudX+yhexaSD9www88xV8kbncvlRVbuFyUgR?=
 =?us-ascii?Q?ks3Hbc46PZJu43P8e0MpDQ7hHmNs7du0uGK6jDPkvYxwMjZGL1n0lP+m8YeP?=
 =?us-ascii?Q?JPTVIK8qUF5DARs/L8D/FtTer5cdGq0U4VxhC3Wkoz8PW7slwQog72R1+0Az?=
 =?us-ascii?Q?Guk9sHjKKi305yYly9Ft5yO3LQq9GPbm3TNKTDXuFVRJn/f0w8wUubugXQI4?=
 =?us-ascii?Q?BebmYEAlehitrhgluy+b/BQHPO3Wfb4uz71KmxKj2cwMR3hZYVtO9FlgcivE?=
 =?us-ascii?Q?dbo1Wx24CW2XKdc9ngh31JMfE5FPZv5hSAVqFyLx0b5Mykl8g6pAKBBACeRs?=
 =?us-ascii?Q?ADGVgxQc3NZ7S3HKV5n13aYKGk2T0B8GpE0nMIn0Tt22ku65xKvtb0vEDIzD?=
 =?us-ascii?Q?hhwipZZGrV/NtiXN8yE/FRsgmrZbt0HJWR04zejBsTzQ0zf1X0TEDz4haPxl?=
 =?us-ascii?Q?GUuxOTciVzm+ffYxJDccyEiMlJq1Ph47k5crhF5WZG3MAN+cRd02HmeMG8qc?=
 =?us-ascii?Q?hShmNWByfItH5cTk4L1qL8L9og3E3hr+ibvq8K7MMd2YOOFD2vhDTpRgmKnB?=
 =?us-ascii?Q?P50wMedHpAXVv1rkgrzphJ7i4zuvrjqV4a0LJ29NPbWAjJWGhCzczja7upUv?=
 =?us-ascii?Q?BW6gFLfpz9TaeablcTf0z9Blozu+WIWMJChIHnSW8zaOoyHq61xYzZpqop57?=
 =?us-ascii?Q?fr4D/hLbqbJi3tOMKJwR8vHae8swcNoB79zNhZk4QS5kRZ+8o6Tig2VrKeN1?=
 =?us-ascii?Q?50ncV57gW4ogsuRHKa9HLxcxjwe4tc3VqsKqJtv3YyaDnaYyMXJcWRIKq33S?=
 =?us-ascii?Q?XvuH+TLsnVjcFGSBBeE3GDZK7qEfYoI/YK4qT00izIBDK2m5hq/F1tAKIws9?=
 =?us-ascii?Q?GA1L4vOM51pRnpzwLRv/h06qJ5+PlQC5fElbpCiC/lRqDFcROhT4/lwflA5V?=
 =?us-ascii?Q?zj/zGJ2cDVrqzysjWLM8WPtbJ+wk3Ipa4qMJMkJhSTh8DNjIhYojoiD6lVPM?=
 =?us-ascii?Q?qGPHlzSbsfcNTuKf7V97gF5kOksVAUQm1aAsKny3ZyqE2yaEaOaXSuhjMHm8?=
 =?us-ascii?Q?VxZVSJvgY0pkUNYeg0q1X6EsqmtzAhKBN+LGa1iyUv6gxY2dAuSwDBGEbnsD?=
 =?us-ascii?Q?HOopJYwRRgdpnqltCZloR6b8Pensr+zqNwMcUdqSd60V3Tu0JnJg84e0Pj0o?=
 =?us-ascii?Q?b2Tt8PUVCt21CaREES9E+gXLnEPaJbazZLjcYZ2hHDpgdTw33KVDsUtQDmg/?=
 =?us-ascii?Q?MiPguyn98QIYMuQ5TK0rjC6/SkfpFa89FBjIavJ5B/DmjcySbh3C/igHFbBz?=
 =?us-ascii?Q?Ow+FYrZWNQWaKOoxy89OnKN6v86w9ukjL3G7Pw8FKx16fJFapiLLE8DslUPO?=
 =?us-ascii?Q?G3736t6qBVtucldO0OzuvvmW7hQyX7f8BXV50faD2q8CVu8+czzccsI0DvJP?=
 =?us-ascii?Q?4g=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e1e74c-d3bb-40c0-f96d-08dc1284a232
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 09:06:44.5505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VoeeHaVFAuMIt4d9W+4THrEyki9JvG+LV1d3NDp3y5t11QrVdszlVw/giRm56TU8pYXr4E1Ftv44SL85YOmNkXogQrRnjN91nXFvRZybNLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5778
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Thursday, January 4, 2024 4:09 PM
>
>Thu, Jan 04, 2024 at 12:11:29PM CET, arkadiusz.kubalewski@intel.com wrote:
>>Disallow dump of unregistered parent pins, it is possible when parent
>>pin and dpll device registerer kernel module instance unbinds, and
>>other kernel module instances of the same dpll device have pins
>>registered with the parent pin. The user can invoke a pin-dump but as
>>the parent was unregistered, those shall not be accessed by the
>>userspace, prevent that by checking if parent pin is still registered.
>>
>>Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
>>Reviewed-by: Jan Glaza <jan.glaza@intel.com>
>>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>---
>> drivers/dpll/dpll_netlink.c | 2 ++
>> 1 file changed, 2 insertions(+)
>>
>>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>>index ce7cf736f020..b53478374a38 100644
>>--- a/drivers/dpll/dpll_netlink.c
>>+++ b/drivers/dpll/dpll_netlink.c
>>@@ -328,6 +328,8 @@ dpll_msg_add_pin_parents(struct sk_buff *msg, struct
>>dpll_pin *pin,
>> 		void *parent_priv;
>>
>> 		ppin =3D ref->pin;
>>+		if (!xa_get_mark(&dpll_pin_xa, ppin->id, DPLL_REGISTERED))
>>+			continue;
>
>If you make sure to hide the pin properly with the last patch, you don't
>need this one. Drop it.
>

Makes sense, will do.

Thank you!
Arkadiusz

>
>> 		parent_priv =3D dpll_pin_on_dpll_priv(dpll_ref->dpll, ppin);
>> 		ret =3D ops->state_on_pin_get(pin,
>> 					    dpll_pin_on_pin_priv(ppin, pin),
>>--
>>2.38.1
>>


