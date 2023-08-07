Return-Path: <netdev+bounces-25183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECD277341F
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 01:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 964671C20DD4
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 23:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBBB17FF3;
	Mon,  7 Aug 2023 23:08:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC4317AA9
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 23:08:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BBD3C00;
	Mon,  7 Aug 2023 16:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691449658; x=1722985658;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZgU0Mu33BbVDjG1QCFvfkoNZ2WATwhZQKqf1S5dgwYo=;
  b=jYFyXQY36B+yWuYo1bg88i0gJBUrDCfJr7uBoQUif6ktyqA4Moq3R700
   DWXDjoPXAIRkSomw8Fy435nKJmkYDfq2Kfpn2io0lyW7gxquwPipiFtj3
   HBDfppo8jnv0e7R7+292V4xgV4K7tU+WzrKauTE1OFwc3Jt2wwgKYPuko
   hdWPpAtIwb7Lqjf/OyQzjxipvYZL/lJ6iRTYwWoqfcmtnAthaAAImjNax
   e4WRAzWTweI/BtudZERfdToG5kPay+X13R7HkmPLtzijxu20PtXyme7sX
   oIkaY73BDkO7nQF9+kSouQNQMrdoXOUGXum1qHpMTq4YbLJu0fTjAcOeA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="369568285"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="369568285"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 16:06:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="796500313"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="796500313"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 07 Aug 2023 16:06:21 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 16:06:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 16:06:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 7 Aug 2023 16:06:15 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 7 Aug 2023 16:06:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJT3meaTbB0nTiGPPEO3pwObXBDiGc8p98xrWXdFuZ8MxceSy8514hAzkkViHHcuqyEzvT/g0mpRVj14JPGdJdbkOye8TfJgjJQHIrVuhAE145bLC1D/SwxF8cJ/ZSAYQoM2cIEPL050XBLfFXXtLi82+lrtCkmieTchQ0hCfedzjJQlOCiyY6kmnxHdqaESbMUEWWXo0wF+uRXtwNCWTju53WKhwFfU9H6wSPjztY2jYGkf8vAobBa9LKVnIfmLU71ZrjyhOUo8KiKWSWazRg/5qHfDJD4pvsLNgwce5nZb3gpVTRhdV+OE6Gd1jMBeSYWDjS0pMTF0r2CijcJRMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4vU+VK5xZeZWkTz+FvTHoB9jY9zXZaoV2JMi+dAhuA=;
 b=VXMAHAdpqMQJs0dc/O9RfBPnpz7BdD4nKsJoL72RwS//4MvTKT0EfWeRu//zxcNfs+/GKpU2Q69eWC0r1MTEmIU6wXkwPYpCCiu8BWJkBsSF0bTuCede3hq/e3+29uOJcQ4TiP1/cGQ/oYE7fjl0T20mB2YmsBTLfaQIBh0WIZt0OyhEKZM0Q0+pTUj3ZmppGciGnHbE4Itc4/vXNjlFU+eOGKimhG+bvcZy59n3XT988Dd3oBFDmIFKrffytLRgq6RGFIlQhdk+35RO+grPtu4HNeCrxy2dyGCzEtV5aDObsonDQqOG+XETCZWDNcaduHhLaPO2u3ktIwNNT0rvJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 CY8PR11MB7685.namprd11.prod.outlook.com (2603:10b6:930:73::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.21; Mon, 7 Aug 2023 23:06:11 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8%5]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 23:06:11 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>, Vadim Fedorenko <vadim.fedorenko@linux.dev>
CC: Jakub Kicinski <kuba@kernel.org>, Jonathan Lemon
	<jonathan.lemon@gmail.com>, Paolo Abeni <pabeni@redhat.com>, "Olech, Milena"
	<milena.olech@intel.com>, "Michalik, Michal" <michal.michalik@intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, poros <poros@redhat.com>, mschmidt
	<mschmidt@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Bart Van Assche
	<bvanassche@acm.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
Subject: RE: [PATCH net-next v2 7/9] ice: implement dpll interface to control
 cgu
Thread-Topic: [PATCH net-next v2 7/9] ice: implement dpll interface to control
 cgu
Thread-Index: AQHZxwa2tpV0bJfdtEKQtg9oKdvEq6/ebaiAgAELAZA=
Date: Mon, 7 Aug 2023 23:06:11 +0000
Message-ID: <DM6PR11MB4657B0935B869AFCB3A87BBB9B0CA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230804190454.394062-1-vadim.fedorenko@linux.dev>
 <20230804190454.394062-8-vadim.fedorenko@linux.dev>
 <ZNCYPVX7p9Fe/lPY@nanopsycho>
In-Reply-To: <ZNCYPVX7p9Fe/lPY@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|CY8PR11MB7685:EE_
x-ms-office365-filtering-correlation-id: 4b5b5469-7cd4-415b-9ef4-08db979ae475
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CjoTEa0P5AkhzpMBm7aGIuCNhQ3UG0BOJpTa2n1qOF75Me8YO+DuQI06bxZA0wHqPRP/9k4ABSMwsyX0DjczQ9VTPjg5LQqTc4F/YzkRCh+DP897m5ZVK2/tuqtj6Y4I3y7kp57+1e+NFWECvtDufSrxx8oyOr5s/efn3+VeNdcxf0Vo+su8a64lYoMjNR40zQ/0BPUfbrd0WkZdXDb1gobgm67Y+KYrRBKnih+sE4bFe3fbyyGMQQneXuvrrQksOJj9dF+c7F0p10lbEK2DDwoAxSDS13rod9vOn2KIWR0qvyhsbNWI6JK836E1gkfw8I6owPCQrx28l2KiEJYJjsjcXLw76v38PHaNfFxCy/QvNtXMrco4Aye8BjsYGiKx5itgnKxo6FyFwjEEEz3K18jhf2tgTTsG9C43Z6vEXc1CPVTpu2CafaWF+f83Bq6Ydsu/WD7En8YDgGgeiSf+132VKbQXtshYLXog0MNM+YA6tGoyhOMLprZ9dGc1hJAi2iYsbMBOBKD2889iZeKQRHrLeFjexQGNmx2knPFiWJ7RlUGdqDmrUiGzMIgXZMkF2wWenrskrwZtmsvN7g0aRM40wT5suAQuqdcV7BCvQyprcFjpskEKqFvY7U6EBmDNXCFHqQhtNM0lRhJkqH6bgi3su0JOojHyADXVgD0IV1u6txhfhXiTTRt9Iyc7qydP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199021)(90011799007)(90021799007)(186006)(1800799003)(55016003)(9686003)(4326008)(316002)(86362001)(478600001)(122000001)(54906003)(110136005)(38100700002)(71200400001)(76116006)(66946007)(6506007)(82960400001)(66446008)(66476007)(64756008)(66556008)(33656002)(7696005)(41300700001)(26005)(52536014)(38070700005)(8936002)(8676002)(2906002)(83380400001)(7416002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B0rD0Sca+MBmC7ibjPI6vGRf2Wm8XTN8tgYWRG/phwg6rOpy/7libuwgByqm?=
 =?us-ascii?Q?HvJ2VN65WvPEFKlBiUAOdPkWjzhnE9N7kBhuOYzOX4F1r+CuEpu02ACyME/A?=
 =?us-ascii?Q?vd8Uyj3HvX5kYdoMN/m119VezNFgwY+8F3OfD2EmdpI+wiMYcwMNG9t6lQg4?=
 =?us-ascii?Q?sUiNwxfv54kLjAVjvONgOZOmXKtshz/NqY0kS/amp1vC0EtZbw70hX0DfB1w?=
 =?us-ascii?Q?2NLW6FnvubRutrnC+hPTmGU/T1QME+lz64snV86IpFb7+hdU0YgsJQvWOtT6?=
 =?us-ascii?Q?uY4N/Z8NwzOcR5Ph0Q4lUA1OgmULSSntpNCoYHQ00U3YcyFfLYB0ze0YVMyH?=
 =?us-ascii?Q?pzRi6HQsojSbNxOsttDHoBzoYYRerRwwPnxmsvJsjh2mmROrlyrkLOX0tQ+b?=
 =?us-ascii?Q?45uSyLaHopb7vuFpdeWr4Hh+czZV1625pVk6zP11i7j2AhcMq1tivTFloVs+?=
 =?us-ascii?Q?cRS6QxgQD9PmmKEHUfqASJdFBw7eupVkL/MU/Kc2BdtbKq5rTsINFYPmqtMT?=
 =?us-ascii?Q?qMgDSvu/VX4NJZpQIVdTNoCHradStfLEgghYq+rgafghNs7sEijhOaobTdEe?=
 =?us-ascii?Q?YLU3J5IS0JS/3lrlH1cMXb7pzmbCeQPfJ9TipLOwkchhFieMZI30w0sYglEd?=
 =?us-ascii?Q?LY2fhZMlkUjNQaarsrPDoGbodDoKgLA7yLvNaRPiqnoLF+CIU7sHvGVfYEal?=
 =?us-ascii?Q?SP5T2MvqYBR4P1NonsGOB9reBfta4eGgB3yaliZwdfLkMxagZswSOi/Bb7vj?=
 =?us-ascii?Q?Iggtgx7QYRU21IGuG5IFjkMtwNx7DSIquzlqGQ3V3c+HO1PTQTtcbYmGio/+?=
 =?us-ascii?Q?LmYNbvs28KaNtbLZDrabXr7Vb0phSnW8tnkxAW7eSawrmDhvSLBjM2pys56A?=
 =?us-ascii?Q?fwtN4EvzsepxrGZKZUHdJSoUso13VUw8PDDVF4RzzO43F3sELqpKct+TSd71?=
 =?us-ascii?Q?5xjJyllWbsQublaSdVgXaVIPt/c7wWVX12V0U6fqngBEViphrRjHLFtOBdSZ?=
 =?us-ascii?Q?nMGq9AN4UaCF0R8a5gLTU+tAe/MilY2qMXmZukSupjifoRlQK7I7OvZt+/v/?=
 =?us-ascii?Q?jRwqp6rO+yw2m+EPsKgd+KXSW7NX8LKW3ptQVBBhkBU/tfO9hYW/puW0zF70?=
 =?us-ascii?Q?nK5OJ5fttPKeuIujxsKfQkrTPBK3irr6sNnxiAtXMk3a9RvGJsHk1qOVzMOk?=
 =?us-ascii?Q?I8I+6o4dr7r+QPGPaVf4r0mXBckCCJ/x0fiNvgIelQ+ZWnobrcfz5vTKwM03?=
 =?us-ascii?Q?QoFMHP+wSLZ+R8rQyc18Bz4sa11M91Sw8GBj29ATMLVUaVhlrTuX8zTAhPwm?=
 =?us-ascii?Q?9hVZnvJsOqzrdLv8IbRcYtgDLl5MV8Ffbp/g+zgKqbNezciC8/OAKlwJQzio?=
 =?us-ascii?Q?Z3n1ms6a+hoPhcp5Ota1eDSjHtJItnNMuAvmFA0H9209X7F0fQiALB4yzrW0?=
 =?us-ascii?Q?5mcgNRaA+3LlM8AZHV/MeTrXz/xKzJoBdRhmrBg4a39sUMK6fY/VnjILPu1+?=
 =?us-ascii?Q?TWMIJu3qq/U0ugid/apWQCwiclVuxDUZm+Y3142K/XsenuCqKbubiHXWWs8S?=
 =?us-ascii?Q?gabR7tyRrwRyn/31y5nVpZLO71imuP7CZl+qOMoYG5X1WKI2u8Q92J4I+VJE?=
 =?us-ascii?Q?VA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b5b5469-7cd4-415b-9ef4-08db979ae475
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 23:06:11.6112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5K1VEXa8vLz5SpsRumTuJxtpZ1Ss6HkdpkN/iImhW4YWvCQc++qwgBiOKpYkMLD0w30ItugEYqaeQ3Wb85BlykiVfUWZIGoZqAU0z40yXsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7685
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Monday, August 7, 2023 9:08 AM
>
>Fri, Aug 04, 2023 at 09:04:52PM CEST, vadim.fedorenko@linux.dev wrote:
>>From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>
>[...]
>
>
>>+/**
>>+ * ice_dpll_deinit_worker - deinitialize dpll kworker
>>+ * @pf: board private structure
>>+ *
>>+ * Stop dpll's kworker, release it's resources.
>>+ */
>>+static void ice_dpll_deinit_worker(struct ice_pf *pf)
>>+{
>>+	struct ice_dplls *d =3D &pf->dplls;
>>+
>>+	kthread_cancel_delayed_work_sync(&d->work);
>>+	kthread_destroy_worker(d->kworker);
>>+}
>>+
>>+/**
>>+ * ice_dpll_init_worker - Initialize DPLLs periodic worker
>>+ * @pf: board private structure
>>+ *
>>+ * Create and start DPLLs periodic worker.
>>+ *
>>+ * Context: Shall be called after pf->dplls.lock is initialized and
>>+ * ICE_FLAG_DPLL flag is set.
>>+ * Return:
>>+ * * 0 - success
>>+ * * negative - create worker failure
>>+ */
>>+static int ice_dpll_init_worker(struct ice_pf *pf)
>>+{
>>+	struct ice_dplls *d =3D &pf->dplls;
>>+	struct kthread_worker *kworker;
>>+
>>+	ice_dpll_update_state(pf, &d->eec, true);
>>+	ice_dpll_update_state(pf, &d->pps, true);
>>+	kthread_init_delayed_work(&d->work, ice_dpll_periodic_work);
>>+	kworker =3D kthread_create_worker(0, "ice-dplls-%s",
>>+					dev_name(ice_pf_to_dev(pf)));
>>+	if (IS_ERR(kworker))
>>+		return PTR_ERR(kworker);
>>+	d->kworker =3D kworker;
>>+	d->cgu_state_acq_err_num =3D 0;
>>+	kthread_queue_delayed_work(d->kworker, &d->work, 0);
>>+
>>+	return 0;
>>+}
>>+
>
>[...]
>
>
>>+/**
>>+ * ice_dpll_deinit - Disable the driver/HW support for dpll subsystem
>>+ * the dpll device.
>>+ * @pf: board private structure
>>+ *
>>+ * Handles the cleanup work required after dpll initialization, freeing
>>+ * resources and unregistering the dpll, pin and all resources used for
>>+ * handling them.
>>+ *
>>+ * Context: Destroys pf->dplls.lock mutex.
>>+ */
>>+void ice_dpll_deinit(struct ice_pf *pf)
>>+{
>>+	bool cgu =3D ice_is_feature_supported(pf, ICE_F_CGU);
>>+
>>+	if (!test_bit(ICE_FLAG_DPLL, pf->flags))
>>+		return;
>>+	clear_bit(ICE_FLAG_DPLL, pf->flags);
>>+
>
>Please be symmetric with the init path and move ice_dpll_deinit_worker()
>call here.
>
>That would not only lead to nicer code, also, that will assure that the
>worker thread can only access initialized object.
>
>And as:
>1) worked thread can only access initialized objects
>2) dpll callbacks can only be called on initialized and registered objects
>
>You can remove the check for ICE_FLAG_DPLL flag from ice_dpll_cb_lock()
>as there would be no longer any possibility when this check could be
>evaluated as "true".
>
>Then, as an unexpected side effect (:O), ice_dpll_cb_lock() basically
>reduces to just calling mutex_lock(&pf->dplls.lock). So you can remove
>the thin wrappers of ice_dpll_cb_lock() and ice_dpll_cb_unlock() and
>instead of doing this obfuscation, you can call
>mutex_lock(&pf->dplls.lock) and mutex_unlock(&pf->dplls.lock) directly.
>
>That is what I'm trying to explain from the beginning. Is it clear now
>or do we need another iteration?
>
>Thanks!

Yeah, actually I removed ice_dpll_cb_lock() already, but this patch
was somehow lost when we were merging :s
Anyway, true will be fixed for v3.

>
>
>>+	ice_dpll_deinit_pins(pf, cgu);
>>+	ice_dpll_deinit_dpll(pf, &pf->dplls.pps, cgu);
>>+	ice_dpll_deinit_dpll(pf, &pf->dplls.eec, cgu);
>>+	ice_dpll_deinit_info(pf);
>>+	if (cgu)
>>+		ice_dpll_deinit_worker(pf);
>>+	mutex_destroy(&pf->dplls.lock);
>>+}
>>+
>>+/**
>>+ * ice_dpll_init - initialize support for dpll subsystem
>>+ * @pf: board private structure
>>+ *
>>+ * Set up the device dplls, register them and pins connected within Linu=
x
>>dpll
>>+ * subsystem. Allow userspace to obtain state of DPLL and handling of
>>DPLL
>>+ * configuration requests.
>>+ *
>>+ * Context: Initializes pf->dplls.lock mutex.
>>+ */
>>+void ice_dpll_init(struct ice_pf *pf)
>>+{
>>+	bool cgu =3D ice_is_feature_supported(pf, ICE_F_CGU);
>>+	struct ice_dplls *d =3D &pf->dplls;
>>+	int err =3D 0;
>>+
>>+	err =3D ice_dpll_init_info(pf, cgu);
>>+	if (err)
>>+		goto err_exit;
>>+	err =3D ice_dpll_init_dpll(pf, &pf->dplls.eec, cgu, DPLL_TYPE_EEC);
>>+	if (err)
>>+		goto deinit_info;
>>+	err =3D ice_dpll_init_dpll(pf, &pf->dplls.pps, cgu, DPLL_TYPE_PPS);
>>+	if (err)
>>+		goto deinit_eec;
>>+	err =3D ice_dpll_init_pins(pf, cgu);
>>+	if (err)
>>+		goto deinit_pps;
>>+	mutex_init(&d->lock);
>>+	set_bit(ICE_FLAG_DPLL, pf->flags);
>
>Why can't you move the flag set to the end of this function and avoid
>calling clear_bi on the error path?
>
>If you can't, please fix the clear_bit() position (should be at the
>beginning of deinit_pins label section).
>

Yes, will be fixed in v3.

>
>>+	if (cgu) {
>>+		err =3D ice_dpll_init_worker(pf);
>>+		if (err)
>>+			goto deinit_pins;
>>+	}
>>+
>>+	return;
>>+
>>+deinit_pins:
>>+	ice_dpll_deinit_pins(pf, cgu);
>>+deinit_pps:
>>+	ice_dpll_deinit_dpll(pf, &pf->dplls.pps, cgu);
>>+deinit_eec:
>>+	ice_dpll_deinit_dpll(pf, &pf->dplls.eec, cgu);
>>+deinit_info:
>>+	ice_dpll_deinit_info(pf);
>>+err_exit:
>>+	clear_bit(ICE_FLAG_DPLL, pf->flags);
>>+	mutex_destroy(&d->lock);
>>+	dev_warn(ice_pf_to_dev(pf), "DPLLs init failure err:%d\n", err);
>>+}
>
>[...]
>
>
>>diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
>b/drivers/net/ethernet/intel/ice/ice_main.c
>>index 2e80d5cd9f56..4adc74f1cb1f 100644
>>--- a/drivers/net/ethernet/intel/ice/ice_main.c
>>+++ b/drivers/net/ethernet/intel/ice/ice_main.c
>>@@ -4627,6 +4627,10 @@ static void ice_init_features(struct ice_pf *pf)
>> 	if (ice_is_feature_supported(pf, ICE_F_GNSS))
>> 		ice_gnss_init(pf);
>>
>>+	if (ice_is_feature_supported(pf, ICE_F_CGU) ||
>>+	    ice_is_feature_supported(pf, ICE_F_PHY_RCLK))
>>+		ice_dpll_init(pf);
>>+
>> 	/* Note: Flow director init failure is non-fatal to load */
>> 	if (ice_init_fdir(pf))
>> 		dev_err(dev, "could not initialize flow director\n");
>>@@ -4653,6 +4657,9 @@ static void ice_deinit_features(struct ice_pf *pf)
>> 		ice_gnss_exit(pf);
>> 	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags))
>> 		ice_ptp_release(pf);
>>+	if (ice_is_feature_supported(pf, ICE_F_PHY_RCLK) ||
>>+	    ice_is_feature_supported(pf, ICE_F_CGU))
>
>As you internally depend on ICE_FLAG_DPLL flag, this check is redundant.
>

Sure, will fix.

Thanks!
Arkadiusz

>
>>+		ice_dpll_deinit(pf);
>> }
>>
>> static void ice_init_wakeup(struct ice_pf *pf)
>>--
>>2.27.0
>>

