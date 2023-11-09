Return-Path: <netdev+bounces-46794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C83147E671A
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 10:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C105280DDF
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 09:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CCB134B5;
	Thu,  9 Nov 2023 09:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nprqer52"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F06D134B3
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 09:50:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89802702
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 01:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699523405; x=1731059405;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v62NHzMeRZKngOrWt+YZkWKq3jb1Q+ifxiMHi0+slHs=;
  b=nprqer52QdfHYhQC5qxQgl/21/gqh29rlK8y5sKMA9mllZnSWW9XAMIg
   WdgAhCPJM2LpRYNitO1G/ZRkZ9qI3WriS6+gea0zFJzuWi9RXYJrm+p18
   SP7+PUePno8ph4IIa/a9S+DLHoqU2xyf+S0MhtOjswdRAwJrC7b+WJJSF
   78ItwJZTlRdehVUhHbMvjdvecX/e+8OgqhUGUFHzyt1cO+jFk1Ku/6s4d
   T/i5Ldbh4cmdMkYaFgrDY9q51nOwlCC1butWuknXgYE+xW+sALjriO4W/
   gXs6hZTdXVCkSEyOW3bsZFq6utj0dK94t5u5pdudjO9zEbPVPwZStHeMN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="8600820"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="8600820"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 01:50:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="936799928"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="936799928"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 01:50:04 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 01:50:03 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 01:49:57 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 01:49:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2CEM44qnAFTuH0GOPZl7/CWvwfNNT1Xxne/fwxl03BTaLSAtVkp1Ew81SmOSmMNixZ4eDQS7OlAbWVp+PRuWaXNCyudT6e0a93JJgI2mpC/6NB47XLYATX/aZTOPOb90KaN9VYQH8tmAeP7XAQCllZLCghDgYmQjbQuV+lzinYWb3U4UNxuLbN8SuicAubz4VhEtwJBFcgvEQgA63rdPvJCFyQRL4VtQOrYGwEUmDfpmIFYf0Aw4H1/3aXXCIxU6lPzyoeuUVuC2fGoFSCm/0pGNI3SsdknIKcXxV6KBhmSywuEdeilg47vMGjD84Z1LoW7jBo0kIgdC8WI5WwaJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNUoc6uvufbIWBe+oyDlx2ILd89z01Frrg8CLMADBII=;
 b=CQsr0MpfkZwDcVLt51Mo8UKpAm8ml68BVRKfxV5EitY5YgcQKHtn+bj9Tbsom6ysJIHvGanFKJgIEl+n7KHa7HJVncl3ILmJd8HxLt5fZw1CVx73d2e37KhoZznK90Lj/qi/1vtV5PLvqb+mQiaswXQwZDvt0+D2nPzyQ+nbJYGge8Dnvx//yy5DaVCJmROCK3Il58T2HpAXFzaroRHHXQuF/bXmQzeiYjkY4qdHsE9zpGRIcMFNzCOy2VrNorq0LtSBwzg8p8CBvQLA0GY1N64LBiLeYkHns7yZNM7NaHv5rddn46ncDoyM6S9oyaQ9bLY6f+2jEdB2JZfRIsqFxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 BL1PR11MB6025.namprd11.prod.outlook.com (2603:10b6:208:390::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 09:49:49 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab%4]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 09:49:49 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "Michalik, Michal"
	<michal.michalik@intel.com>, "Olech, Milena" <milena.olech@intel.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>
Subject: RE: [PATCH net 1/3] dpll: fix pin dump crash after module unbind
Thread-Topic: [PATCH net 1/3] dpll: fix pin dump crash after module unbind
Thread-Index: AQHaEi9O+MhpyYqtOE+7KgFNzKw5JbBwho0AgAE4RKA=
Date: Thu, 9 Nov 2023 09:49:49 +0000
Message-ID: <DM6PR11MB46576110B45D806064F437C49BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20231108103226.1168500-1-arkadiusz.kubalewski@intel.com>
 <20231108103226.1168500-2-arkadiusz.kubalewski@intel.com>
 <ZUukeokxH2NVvmpe@nanopsycho>
In-Reply-To: <ZUukeokxH2NVvmpe@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|BL1PR11MB6025:EE_
x-ms-office365-filtering-correlation-id: c98b191d-a42c-429e-7941-08dbe10936ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /5Gws5/nYkSXzQVOLO7ELXr04Ouxhe3ZjtntSwMkY8k0iyrRdAT+m6MY/Vjd+nZVaUJe+m52hoYC0XtFL7BfXD2hKizU1a4x6JFjcoNU8Earcyw7bvewC0qgZAVqGUw2hvKAl9AScIW5SqSm7kldovXk1qflRyLwNRZ8rn2R/fg8KXMy3wLEH0BLW4lb5YwFoiHifVkxalqmsP26tMyNAENmfnA5mgZ33mCCKthII5PSGsCXc4FnxqjpgGl8487thFFNA5kS7xsWGVuzeybg1knP3bnKThT3sOiTEXo8Cb7kWUVwgmGPM5scO2ehUWsFXtygX+VLupoL5SRZKYJR7Os6NOnBNjfgY0t5J3DFTZIlOQ8AO0SAiRB6xJYaktHelc5RfxceFHS2nId16OxjZ48fhq7mxJwYAO7TGZNCJses+08fLg6ws0XlAnFl61CdtJtoe4Nr+TXyHG6cLUBtU/Hg0g0lXprwmeBGxuuMdeSBmCkW0yq74hYLS+roZfEgMMaMcuvZcK8xNl4lb+xelbAhMlGukVnU69U22V5rtSh1jlZF9GccGmwwozEtlH6ItOysJV+JnOD7keFqx6EOl/R5Oq0mjrCH96GlsOOJWk4dU4pNkiCJ37mAKhqOF+fY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(366004)(396003)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(55016003)(2906002)(5660300002)(8676002)(4326008)(86362001)(38100700002)(83380400001)(33656002)(41300700001)(76116006)(82960400001)(316002)(122000001)(9686003)(8936002)(52536014)(64756008)(66946007)(66556008)(66476007)(6916009)(66446008)(7696005)(71200400001)(38070700009)(54906003)(6506007)(26005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4KH97szk5E8hb0Qq2s6GqA0dBQ0sQqqJ/JMbTJXUt3u6H3CoXhsXOacVeYME?=
 =?us-ascii?Q?EU3aN2rGhArb8AwhVLmDizJPVUuwCuHZmPJA6UrU2q36yRj70phuGKduT3Gi?=
 =?us-ascii?Q?j/FZk9WiQoJTm+hoPjFZdQbwWs5lqQfOvPGsPdKdjqvG+JHBOFopyJGnix/s?=
 =?us-ascii?Q?Wy5o+6paeMEiaKRjCruufdla4MiDO65PdpX65FeWtZ/UHwMDRiBMZkq0mlCv?=
 =?us-ascii?Q?QFdNHtzy5yWU0Z2aipS8L1dslth/CLG3P/jSFI9fbh7od4gLPOuVlTuVpr4B?=
 =?us-ascii?Q?SJ7VUvuOoQRHNaYnGlB8WkAB7EHe1X4iVwF3THOcJkE5K+MRlcCHseq36gwj?=
 =?us-ascii?Q?wPbBDvOrRztJS6qzjWKk5+pk+SfZWYT63GF7QP2DRqRCEuTMfx+tCZFbB5u/?=
 =?us-ascii?Q?nGQnhUc0rvqOY38lIAK6O2breaMWHh2mpNhObMKP+gAkVAeNpzMRzNip1U+N?=
 =?us-ascii?Q?i0kxWgb0NJsjXFNUG+RmURZP/PpsdMOk9bh8Lc20gNbuUzRmMMzFzHt58XRf?=
 =?us-ascii?Q?TmwzCfq5lM/qgutOykwJk9uT76qFgGu5uu/ILyTi0B18Tg7DFdez9ZvRfbyo?=
 =?us-ascii?Q?2OyNNEYnN7MwEoHENgxFEEFr/2Pm5h7a5achjZhm7zYnz3uW665mm9S4ZFWP?=
 =?us-ascii?Q?L6QH0aUVhp9Epbe8L/vJaTvFulqZCEWk2A8/GYP41yinmLbYSjoyZzZ2NRGb?=
 =?us-ascii?Q?wMnMvik+X9xgOZanzs/W4kb/kwBJKNdOeIuScJWQoz1knvSN1h6/OKO5VIG0?=
 =?us-ascii?Q?+cpjSBhroceEzyni40JD256faDr0NtX6Ssh1bX253vKAjVvuZIWSZYUZM/3Z?=
 =?us-ascii?Q?p2BTxpV+dPjVlaFCKyvkNz3cLoHBEZ5zu0bxt45q1GU7WmPAf9Sn1ndDLSNk?=
 =?us-ascii?Q?DF0flKFJrxc56z/5rw53DguyukgHR/2Yu+0u4MALwYGrKVk7VmdZvjMD0ix9?=
 =?us-ascii?Q?Knq88LJiWRfIuSDVMdw/jnWJdGvCoicJUgDw9v/jDxai45B5O3qs8mqa904J?=
 =?us-ascii?Q?em2dwD4m9MBSvFMN9ZnlE2p7Z1oFgGHVOsaxC6aHJV+ZNLrqifFF50cgEGcD?=
 =?us-ascii?Q?iTNBMlIAwkk9J2Idk3PGjJddzQMzaoheayVIdrG0zDpVhq/YheYPe+ZKmZHj?=
 =?us-ascii?Q?2H6xpBunJk/nSK3WpWaX/82CHejdZi4ThXOtI6Gh367UgCieGxLnqQ0NFY5R?=
 =?us-ascii?Q?kJyknXWlgnKsQHzrhkryWH5xbM/7qedbdrIIhUpuPu/6doK6o01kyXVVY3Mv?=
 =?us-ascii?Q?wTYrZL5AmkmhqVqQOSLq6fPhh/jI5S7OEqJhbhVAqlHRCTKJQuTtDDBvn0vA?=
 =?us-ascii?Q?MULKE8LgzcZfPR51leZ6BrgGOft1SaPjEDlyb4bQ0atzJ5vk35YzOZKk7Jxe?=
 =?us-ascii?Q?gSoDfGHiBCBwtfGmPcKpvCL9M7vB77zUinsWssJ3f93Goo2fehz8FeYDQs85?=
 =?us-ascii?Q?U/MmItnOFU4X11gIcRa5ByPiUGXktVFAfvFErisF8MtQyAOx0ojQ+xBmUk9d?=
 =?us-ascii?Q?4cmHgAV2PtDsOK2pq0Zyj//CtdkiVkbUIcOtbvR/ZECfsJht0JmG48FzWees?=
 =?us-ascii?Q?3R15G56oC+5ZK3xhEmUDclwJBbGHhDjvrJhRA6QKewK/of9B0J3E568LyEEu?=
 =?us-ascii?Q?bw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c98b191d-a42c-429e-7941-08dbe10936ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 09:49:49.1230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fv202AHymFOZBzB09g7ZnvVo8M+V1zmjf/3Hu1gigUTjaJn15yaDWddir8dhMLvauxG8HHDdJsvGqjDXXjOdoS3Kx/IIYkMJt5QVfj1Epoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6025
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Wednesday, November 8, 2023 4:09 PM
>
>Wed, Nov 08, 2023 at 11:32:24AM CET, arkadiusz.kubalewski@intel.com wrote:
>>Disallow dump of unregistered parent pins, it is possible when parent
>>pin and dpll device registerer kernel module instance unbinds, and
>>other kernel module instances of the same dpll device have pins
>>registered with the parent pin. The user can invoke a pin-dump but as
>>the parent was unregistered, thus shall not be accessed by the
>>userspace, prevent that by checking if parent pin is still registered.
>>
>>Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
>>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>---
>> drivers/dpll/dpll_netlink.c | 7 +++++++
>> 1 file changed, 7 insertions(+)
>>
>>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>>index a6dc3997bf5c..93fc6c4b8a78 100644
>>--- a/drivers/dpll/dpll_netlink.c
>>+++ b/drivers/dpll/dpll_netlink.c
>>@@ -328,6 +328,13 @@ dpll_msg_add_pin_parents(struct sk_buff *msg, struct
>dpll_pin *pin,
>> 		void *parent_priv;
>>
>> 		ppin =3D ref->pin;
>>+		/*
>>+		 * dump parent only if it is registered, thus prevent crash on
>>+		 * pin dump called when driver which registered the pin unbinds
>>+		 * and different instance registered pin on that parent pin
>
>Read this sentence like 10 times, still don't get what you mean.
>Shouldn't comments be easy to understand?
>

Hi,

Hmm, wondering isn't it better to remove this comment at all?
If you think it is needed I will rephrase it somehow..

Thank you!
Arkadiusz

>
>>+		 */
>>+		if (!xa_get_mark(&dpll_pin_xa, ppin->id, DPLL_REGISTERED))
>>+			continue;
>> 		parent_priv =3D dpll_pin_on_dpll_priv(dpll_ref->dpll, ppin);
>> 		ret =3D ops->state_on_pin_get(pin,
>> 					    dpll_pin_on_pin_priv(ppin, pin),
>>--
>>2.38.1
>>


