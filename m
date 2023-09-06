Return-Path: <netdev+bounces-32172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 897CF7933E3
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 04:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BFA22810D6
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 02:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4832D654;
	Wed,  6 Sep 2023 02:52:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A567E
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 02:52:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5B8E9
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 19:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693968753; x=1725504753;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/wdxZa/L1R8pKnajrZ6e9EXv6lwCuUZizlHg2aPPuVE=;
  b=dER5kZVnQsn7wvWpzbLR5yOIA4VNUUVqWxkq2vTJTP/tV6yoP6vUJR7q
   +70kLcoGVt2PgbnNn4+znnnKmjEte4h6igWSSk+dzeu8+b0LRmQLeE6fS
   9H/EwIZaO8o2AnpAW+lkPa7gb4Ta2jUsnXwCJGRJJYgdQE/30MT/kXe+x
   hoX9lOtdTs2aM9axXGMzm5sWzEris6/WZ5sbiQivs4cqCa3Xb5GWowy3K
   Xbkw/N5Z+NEgfPwmaFGE5XT8DBPHgZ9rMg9WIzZ04H/SxQoDU/dpjCT7O
   hurt7Xa2ViUhTUC3X8MWaF1DcR1ui2y6cG72xvGPf9hlGiX0B823DMo7W
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="357262486"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="357262486"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 19:52:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="915094950"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="915094950"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 19:52:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 19:52:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 19:52:31 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 19:52:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSP9V8FtKeP024ARK9csaieXKIu+Z19dBLlw1TCVjuPJBN5MIZuwwyUT/rvAxn6yLt/wknhTm3e+2R+BPmQmmTkWVa+i0UHtkXh3tfi9fQWlnDjWY8Gfuxmm4sNtqLg+59GFswXf8lzlpqDD8Lq0H586tLUs58s4Ef6ky3yEYcGV2mGdtv8kxKgTu7X6Xqctn/N+rZ/e8bxQWTeveSE3lSkUVq3B6eqrme5HMQCzIGrkYgMrUDZmBEHMrweTq30R90YgjdP3X715p6DEr+0MNlkkG/AldcUYi4OCOpvga6hBH940p+WLQ+8goclIotZ8mRr3nrCCd36HqyAZnvUaRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wdxZa/L1R8pKnajrZ6e9EXv6lwCuUZizlHg2aPPuVE=;
 b=P6BogFAZEWOknKi70WZ06FQyQcG3Znu1qLD2RhLu/JlhIqX022Pe31g4hjjUEObbVsxFKodLjzu18uxYmSMbMlnbJ142bNt9S5WpKyxdgpFiK1kTe6hd+RnWOVqupDZ/torJYVHaaj5cInjK2hlEQUxC52BZYdHTeQvfllyaRSRGBg9e7VmKu3Sz5lG8yFYRma25Bep5DDC6EygqiLR4/KDWBsEWq/lcMrwNURG9vAhmCRXjuCmHp70GVxiPsnYdBJtDyc4yxQd0O6U/Ovj3WZkQE4vH97tWVdPjdBZdAEscnyEGxuLxNT/pv4kwhFM12+9P2miil15gGvQIDxU81w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6180.namprd11.prod.outlook.com (2603:10b6:a03:459::14)
 by CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 02:52:30 +0000
Received: from SJ1PR11MB6180.namprd11.prod.outlook.com
 ([fe80::5c05:24f1:bd1b:88f8]) by SJ1PR11MB6180.namprd11.prod.outlook.com
 ([fe80::5c05:24f1:bd1b:88f8%4]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 02:52:30 +0000
From: "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Neftin, Sasha" <sasha.neftin@intel.com>,
	"horms@kernel.org" <horms@kernel.org>, "bcreeley@amd.com" <bcreeley@amd.com>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: RE: [PATCH net v3 2/2] igc: Modify the tx-usecs coalesce setting
Thread-Topic: [PATCH net v3 2/2] igc: Modify the tx-usecs coalesce setting
Thread-Index: AQHZ1UdLBr55a0cOOkC26dNjnXpg9K/4uEIAgAFVHMCAABZcAIAAPQoQgAFe04CADiGKkIACrVUAgACeCJA=
Date: Wed, 6 Sep 2023 02:52:30 +0000
Message-ID: <SJ1PR11MB6180C190E2ADF4FB2B17A430B8EFA@SJ1PR11MB6180.namprd11.prod.outlook.com>
References: <20230822221620.2988753-1-anthony.l.nguyen@intel.com>
	<20230822221620.2988753-3-anthony.l.nguyen@intel.com>
	<20230823191928.1a32aed7@kernel.org>
	<SJ1PR11MB6180CA2B18577F8D10E8490DB81DA@SJ1PR11MB6180.namprd11.prod.outlook.com>
	<20230824170022.5a055c55@kernel.org>
	<SJ1PR11MB6180835AA3B1C2CC9611B44AB8E3A@SJ1PR11MB6180.namprd11.prod.outlook.com>
	<20230825173429.2a2d0d9f@kernel.org>
	<SJ1PR11MB6180F2DBE9F6296E35451B3CB8E9A@SJ1PR11MB6180.namprd11.prod.outlook.com>
 <20230905101504.4a9da6b8@kernel.org>
In-Reply-To: <20230905101504.4a9da6b8@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6180:EE_|CY8PR11MB7364:EE_
x-ms-office365-filtering-correlation-id: d3950ce8-c3f9-49a9-623e-08dbae844fe7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j+0CCj5tPBTnlhgd+9gRUfMMQkWzQ9CF3mwiCrPm9Tz0qHqovyWgdE4gZUlFi+PF2zUndJM7HnFYADuK9nGLdqqasa/FO+CaUuoKazttke0W1LxUn9ggqqx3tgarlKleezR4ysYyNTMESiRbZBZeBnu/luG7imuRUy3qizzRYhtiZS5xe6je5c3bWs9K7vY8bXpcCTrtVKzNLM4g8k5i6z3RJj9ICzZqvygaSyiSoe1dKeJEhZcArseyBz0JwEUyaMT5Fqj8Zf7o0NR/SL0aUAATrkBBl2eVhn0Nfcw+oO/B7FPp2H6J64VgDYlCCQYXsDh5Rf4dL+KCR21rJZHIQZGZm8j2jFSlQiRXVEEfqNONv0BYh19uzz3pB9NyelOuZftEiUEAYIbWtrfhyXz48zmdTvpFpz6IqAYXIhrbLXreWUt0WbCAyWBMG+lw2cZX75MIcfdLusXOmhm7S7tbYSF/M61qaXWD9WVceDmlAJn+Ky6/2NeWxDJg8wv1ZNzzl5OgIOWemotHcpQLHDRAQFrVunQpAFbU6Qk/hE93gHARASxRqEnNSSAi9S5nQNpkznXpa+QzFHT6P7SFkhTVmIBnIFpVcUaKBf91V8Sb2rMaUzDjWMV+XIJpsC659OVT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6180.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(396003)(366004)(1800799009)(186009)(451199024)(9686003)(26005)(4744005)(41300700001)(76116006)(66476007)(6916009)(66556008)(316002)(54906003)(64756008)(66446008)(52536014)(5660300002)(4326008)(8676002)(8936002)(2906002)(6506007)(7696005)(71200400001)(478600001)(66946007)(55016003)(33656002)(86362001)(82960400001)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F15FtZnhZ48vmjqBhtgRcwf3c56WKHlfxNdgGKRjnMVFz7iUfJx+RStZbA1e?=
 =?us-ascii?Q?Y5T3KxVQ/dPG6JqZf1oHTsikDiJmzOVOf8iKVy5s1v1en1936uXnHgT6Bayi?=
 =?us-ascii?Q?nEzfcXrTpvqpMyd015BhN5d+qHE5y6Y9CdJCVLfEaLt4ov6M/DoosgR9ssmL?=
 =?us-ascii?Q?Mam4NUI9NefeBzUoSDreyNRVeRe/mND8DzD4IRhCx8VTnUV0OP6BXpSPMbGO?=
 =?us-ascii?Q?0dkbTAIrzhPmmWBA+PkpU8o81aGT8WywcVvPGIpELMszNGrkNWOcZLyrMTRp?=
 =?us-ascii?Q?yvyOw0vtji0c/+VCTlrmDcE2cJgh+rQ0+ONzvskTVSHYoVLmfCDL/lK/wXL6?=
 =?us-ascii?Q?QyfQsPW9FsIno3+tkG9eesCWADR7IeEG1iuZcAT0L/Hv+rq67rE4ZiOgvcRz?=
 =?us-ascii?Q?5qjHWpiik8KsVWr8t7pzlYTWiF5XM3X5hrFdUjrL1erZB3eqbuS2yIcy2Ykn?=
 =?us-ascii?Q?agP/2naPZbiGN/pKAxgkbu8lmXp7P1MKe9kKyWEuXt1NLj68lWh9pMf2zVzp?=
 =?us-ascii?Q?zdVoKm2wNY14BZzQIKpKSZayRIRwZTFQcFy5mxXd7FSQ0brNYx5SM/CWlkTP?=
 =?us-ascii?Q?3+JL2kwWcTh3eCJMlZUdeotfduePt4eUxXOchCrzDv0kxg583q2F5jxGx38u?=
 =?us-ascii?Q?1JygwgK0megLXYpiftVLGir2xsrYhKiABS99QQnukP3ji4w+BzbKRXLRBnOe?=
 =?us-ascii?Q?hfO7XsJy9BnAh4aNVnOhtTtGi/g7gTvarGmv6GHHeg3SqAc0875km5G6Pd1F?=
 =?us-ascii?Q?Z3Nava8vUOLHv83wiICkJRStKvlUfMqSEQZcM0s1d1otUoCOi+IhhfAZuk1W?=
 =?us-ascii?Q?n/SsyUENvt3kypYARD6lIdf6fgMf0MyYrCYCbmOLI+Su/DWhhcMhh5oGjRV4?=
 =?us-ascii?Q?+GsbQFC6K2pNhrqNp/nwc3Xa+c7ZOxpxXYmtsxA/ljTwNZK292uuHgblhXhj?=
 =?us-ascii?Q?c0+QG1vV+Fcd0QWo2aRDlFL60pBZ8DqcTPyLTFlVzYEq9c4Y/4qV7jNb1B2y?=
 =?us-ascii?Q?2lNNpVHwcwlvQs+wvyEXG1HCGscpwmKKzGfgVtrXWM9FEJhr44v2naJXc3fm?=
 =?us-ascii?Q?CCM+3UHqMy9c8/pGuX7h+3SEdlqXHFbQeHjXw0t4lvK0fqUOg9Xrrtqa3kaq?=
 =?us-ascii?Q?ZglHXmmADeB2SpTYJxJvbv7HuhL79JzG7egXzGH+Jrz7QtqE7cudtvEFP3HE?=
 =?us-ascii?Q?MwzxLpbpIusf7q5p3LmGDuAvRIaUT7NJw69suq9B4xkZ8b/pD1hyEEAeT9+I?=
 =?us-ascii?Q?Zhy2JnNMEHLEpThrM2l/QWnQTjGIUyJcqMu9eMOr5a4+oRsE4qCGDqiJ1GYv?=
 =?us-ascii?Q?GMhUzNCnhcHL3TWS3TlPikbok7CArczA7nePIwtOBoA+9XpioCsUXEKclAps?=
 =?us-ascii?Q?w3+cOJnPnWaNoIBydfOiEJ8I5Rd4by8usOEDClrbGTC5WNvUORntdA3by7gS?=
 =?us-ascii?Q?gJvMl5N7bUhwgT/sck3ZHn+iva2DYZA5itE7G9F1wwCe2pAUs3Q8aoijDlup?=
 =?us-ascii?Q?5yffPPcTnxPGCfM5FctNkPd79wEW8eSZxj/UMAr8IFcdAeI95pfSfOIqgax1?=
 =?us-ascii?Q?ktWkLXm3VV7DxPu6qxbtiKq0BiNAweXmhOyDt4Sz8gKN2YmRtsmbjNATqiW6?=
 =?us-ascii?Q?+S6gnkwLG0SGAsXA0MrSpS4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6180.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3950ce8-c3f9-49a9-623e-08dbae844fe7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 02:52:30.2322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zg1dJa/yIWw4OOV3pxpiw71488DlZI4HphvPKQ8197Qj512IGzgNqeZfHDY/S8XpyxhEkSO4XK7wIlz/AU2Q21RM5TTcGblTPsmdc1eqW9MiMxzjiMtCksPvKXDgpfNN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7364
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> On Mon, 4 Sep 2023 00:59:40 +0000 Zulkifli, Muhammad Husaini wrote:
> > However, if the user enters the same value for the tx-usecs and a
> > different value for the rx-usecs, the command will succeed. .
> > Are you ok with it?
>=20
> It's unfortunate, but strictly better than the alternative, AFACT.

Agree.

> In the ioctl uAPI we can't differentiate between params which were echoed=
 back
> to us vs those user set via CLI to what they already were.
>=20
> Maybe we should extend the uAPI and add a "queue pair" IRQ moderation?

Good advice. BTW, if queue pair setting is enabled in the driver, could we =
change the existing ".supported_coalesce_params" for driver specific?

From:
ETHTOOL_COALESCE_USECS which support (ETHTOOL_COALESCE_RX_USECS | ETHTOOL_C=
OALESCE_TX_USECS)

To (new define):
ETHTOOL_QUEUE_PAIR_COALESCE_USECS (ETHTOOL_COALESCE_RX_USECS)

With this, I believe user cannot set tx-usecs and will return error of unsu=
pported parameters.

Thanks,
Husaini

