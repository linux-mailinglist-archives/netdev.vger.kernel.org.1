Return-Path: <netdev+bounces-20101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC1B75DA65
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 08:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8621C21680
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 06:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330E611C9B;
	Sat, 22 Jul 2023 06:45:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F82A8BF0
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 06:45:37 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3516270B
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 23:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690008335; x=1721544335;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZfEoCSl8KjsYqOlT/24MADLsarraY84+gpOB+B5jxWc=;
  b=iokKlNAn1qYlX45aTnGjolbhr307F3o63qsBg74h2+JVbgS3CO8zRd0q
   OnyDLNQ3t/DMDS7ppfIC+AHMTeOna/1ggzDWX24v2TfhEhTEaB4ADwJnD
   t2OnoXuHyU8oEfgmybDcy4YE2hMo4DycRyLztoIXKTdzIBd/J+D/uJm0b
   QjpIIowI3AVSxfo6URTS2ft63xoT5UjbggdoDDThvIQs4m9NfhfaZ67YG
   rOzGlbXH5jXghonQnxqCc+bWG5Ceg1zRpJkGjGWUP+CWqkzxb1wPAimzn
   crJTU+KqzTg3lG7aRzmNYCcAWNXxWR8lfOnrJdB8ICp84EnXcwxc+omkX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="453547167"
X-IronPort-AV: E=Sophos;i="6.01,223,1684825200"; 
   d="scan'208";a="453547167"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 23:45:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="795210821"
X-IronPort-AV: E=Sophos;i="6.01,223,1684825200"; 
   d="scan'208";a="795210821"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 21 Jul 2023 23:45:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 23:45:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 23:45:35 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 23:45:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fg9dWAJ8FEYiZBqQDJQVAjlPhUdQEZ2ccl0uMWmp/W96hHP1p59AHmV/ConBXM1zm0/MepHjHJ2mxDLPSm5B31pFLmYhEszNauYfsBJe9xjT8fQgFBKeRSvah9ST0qkR9L+eOXIpsEafLnCgPf5eqj0N/esSY/4Eijuz0rIJC7XkP27qzdJtI/c9aOWWdFlcCajCVjWshu0DVoDGdQcHaq1ZipdH+MoPVVBp16ib2bzhhNw1DGLkwLN50FzWug+UK5rq+dJH1ivWYL6BtfdBt7/vbR1u+OH6zPaQ6buJXlnuyOatjRZF5FUzEbpFd6OnUODCdAuLgLOU0xxra3Hhxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtLIE/YaRzqG74YpimoslmHLaItZ5IS01nR/TVRdKgA=;
 b=PJofIcA4ZIFse9GhaCfttEUwAbhg23Zg60Mctu6VG60eMl103Cambw+shDSrSK14IRJy/MvH7gn4MVmXiD/NBHu42tr0vLvdDQ3AqaEI72OYZF+3y3W/ITjdSq5ltqmlzIaaon/JbItIGZmntRsJRNdV7WwQy35fftdWx+a9GkGR5+j89Rh077j8YlW3CbYe+xXrJOXKq+x85kybzrvI2Qram6em66QlAbHrPhh0sP+S17Rqs2iItcCY8V6IszDgCfMAZh6V891J4Wdb/clbtWznJbuGaxJ5radN7wwUwyIY9//KvFchEcD6CJ+TXIKDY8wI4IzBnscyYByzVTNRxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by SA2PR11MB4828.namprd11.prod.outlook.com (2603:10b6:806:110::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Sat, 22 Jul
 2023 06:45:28 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66f1:bfcc:6d66:1c6d]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66f1:bfcc:6d66:1c6d%4]) with mapi id 15.20.6609.026; Sat, 22 Jul 2023
 06:45:28 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: "Drewek, Wojciech" <wojciech.drewek@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "vladbu@nvidia.com" <vladbu@nvidia.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "simon.horman@corigine.com"
	<simon.horman@corigine.com>, "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v6 04/12] ice: Disable vlan
 pruning for uplink VSI
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v6 04/12] ice: Disable vlan
 pruning for uplink VSI
Thread-Index: AQHZtLDT40iRTKdkFEu8zoiAwmitaK/FZsDg
Date: Sat, 22 Jul 2023 06:45:27 +0000
Message-ID: <PH0PR11MB5013DB3480489CA9E9353743963CA@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20230712110337.8030-1-wojciech.drewek@intel.com>
 <20230712110337.8030-5-wojciech.drewek@intel.com>
In-Reply-To: <20230712110337.8030-5-wojciech.drewek@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|SA2PR11MB4828:EE_
x-ms-office365-filtering-correlation-id: edebfb17-3c58-4e8e-4d76-08db8a7f3c49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FyP9LhdWJ4Jy7cKhSgLoh/5qZtyWGwU+8TAfF1PEnC8rZStWCf5Qy4xecfzfbuEjGdDJz7d5hcM15RHIu+30u2NJqsRlvkSxXW01JAEoOSZBB9H8BmH2WFQatVzLGRi+kBJv9VjEPW0sXEg6xla0h3HPeEFKfwwM+d+4z/lob8D4uTZU8hMSvDgScEcjYgtK6KE42T/6AgQnmppOEpf3uEvQ3bAakWVGJmZ++EU4hIAr3VpGHfavpFtd1qJuQr0uRZc0vDj+SsJS/pRSZCvFsEYV3v5LVzfkks+yrPSDNlfxmYQ5XLZeHNS+AYmdWm5O+rKRlqbuvj0BkRxIF7M6iL4lJNIm1RVEBSPhCg1/vdtlDD6GQapBomzwG5He5a7qtdnMMNmbGLjJz0AbmF//WyoH9xxkjoVV3amVzMzTZkr8L1LF41QDF6FFchZ6M7+KfM5uCt26aEZ0O9FjlQ3uuWzwDRyT/2eL4iWj/pB0W2F6INlbRAihBDmoZB9oy1aBpJo6cC1pjrCvlu7YyM00l6PpXc2oLifLB+5N0RDHLlidJ05RtlsphrpA4h9nDs3KQdSBNo4QHPzBXX340THTO1TyZZRXIqXHMQKkYx0+Hps=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199021)(2906002)(4744005)(83380400001)(38070700005)(86362001)(33656002)(82960400001)(122000001)(38100700002)(55016003)(4326008)(64756008)(71200400001)(66476007)(66946007)(66446008)(66556008)(186003)(76116006)(478600001)(26005)(53546011)(41300700001)(316002)(110136005)(6506007)(7696005)(54906003)(9686003)(52536014)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D9JUOBg3K1hUlWcR3ezItpukFE6ZMpPtaQYiJYNJRpr1qi5Ew18c8JCNqumj?=
 =?us-ascii?Q?C81kVCWwDkDv9u8tb3l+hyLZweTAPNYZgqVOnmRKHVkn+ayPmMOrCW1Q0VU5?=
 =?us-ascii?Q?0tISIIdXWbalhzPHaYnUKu6JGrNlnroUsg03INKaN80+pAvTctkb7mLfwpF1?=
 =?us-ascii?Q?NhS0wtbft4GJ04jtdg7hHuMIpU37mxJ7SPjpQ4VAmYbabf55+qxyGIm75b5u?=
 =?us-ascii?Q?SDTZGxay99lcVG0WAa7FPIRTtpubJCAPx5IXn2+lFUre9Y056x6xN4tIt20U?=
 =?us-ascii?Q?e60+VnL/PDMqIpdem8C7TPszLpFAFJst8Ql0V3FszlKwe7ZsF3RtpJRWLiY4?=
 =?us-ascii?Q?YW4uyr5+udBne1Xk1n7YXkRvPBUwKK/niYN4uz0s6PDxKpetGTBXkN+/Ga+M?=
 =?us-ascii?Q?4ZaUKnpMIM3DPR4BLdsmWqdTgEGj/VKLB505McuJL0fipZY9s6gocytlz0c+?=
 =?us-ascii?Q?Q3NnNNLp854gQ6NvgwwQDXMsz+0X6b7Pwabk7WU0ikliUungL5+KYF72+6Rq?=
 =?us-ascii?Q?oCqSySh/AXpm7IGAeT8iTKXyksS+p+SG638g7znDZ52L9dm3dy//5Bs0ASLh?=
 =?us-ascii?Q?h+RaMt+y8VNnILDW2sPAoMzsj4VrzkVfvs+KFoN2kfIPjiOIcAPz4vlOM8JB?=
 =?us-ascii?Q?+byE91Ki4W4HDcpU1Be2T8AnWx6Rv/S6Q0SsvBxsyrUnzrgUHt9Wurdre+F4?=
 =?us-ascii?Q?MyCWOeZzLUtgYfe3mWbt9323DO8ZjjwnwnefXP8caOIMWW01Lci6+db3Llf3?=
 =?us-ascii?Q?N+gL8dwFBjQVGC0m4pdTycbjQBqC2ndImo/BdyIGAM0aer84cqE8j2VywNmy?=
 =?us-ascii?Q?ezH3KIM53371CVv1mKPJqyWGWMumdZXTeoKVhxjyBo03d7E+wLWqxBBRE1HB?=
 =?us-ascii?Q?qvQ3Sug3ua7tLqTzm5AOgnEGXYFFFarvIWp4MKzStZYHkAj2bmcy0foakIcX?=
 =?us-ascii?Q?b7rG2UWOCkPEooyf6kMOva2iJGmJfxvm0EsiTcCBI2n/p9owy6DuYprD1no2?=
 =?us-ascii?Q?e3+8w8UzMiWWyTte8MdWpMw6Z7Wm9TQmev+YhWPHanQ5/jxCDyac29BnKIj1?=
 =?us-ascii?Q?NDySiwtpBAvdNXHBCDP1jCZYvWrtg9rgtOhUR8yFxWx4S6y9n/YVwROEL2qM?=
 =?us-ascii?Q?gVDdcCciCW7cx3nSJHmnmdiLy0hcDZtb+gW5xy0iYInPMS5w5jqMqqLr5dFE?=
 =?us-ascii?Q?iFBWSGm4B8wpiR9t/jLfXYUmqMmGlqFajF0yLytFL5rGYMi3BKOlJolYdUrO?=
 =?us-ascii?Q?k+MmBT6dKdsy345jcxd57QKs0Y+OD6G5j6CJysW7LO+YNqrDP1FZxCY4zcXa?=
 =?us-ascii?Q?tPJBzklohOPP+j8EqfowwnUYoNAkT2GbzI8kfKjv89w3Y4N1ld3YcNJHErLg?=
 =?us-ascii?Q?Ype40YqBXXwBtH4ilEn7rzKmon6YpVWY2i+sHVvO9Kkh98tZwZfmaP7UuOO4?=
 =?us-ascii?Q?5d3n8YqqBeUJZBoxVvA+He1gJKqTISZPIu4kHkTLrMzCc2hDET9C3qr9eop5?=
 =?us-ascii?Q?URnkXc3J0V1MwAGQ2uAh1a3OzZfPqKGSSGC/bntVXeKu8/OPdPXAGe8eTU6x?=
 =?us-ascii?Q?K5F3C6WfHRhCcLhptxI8J88QH3npDl8dS6p2C3oh+JhnUXOGopEDuWK0Jue0?=
 =?us-ascii?Q?+A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edebfb17-3c58-4e8e-4d76-08db8a7f3c49
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2023 06:45:27.9724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1GlmXpDkPSvqQrJweR5e2x+bd7JLY7nIGlzpBW9TM24myqMAVzKngzuaOpMoKW5edfc1XFEOfNAxQMDbfsm8jfU8zP4EbE3EDkGm4GbxbDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4828
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Wojciech Drewek
> Sent: Wednesday, July 12, 2023 4:33 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: pmenzel@molgen.mpg.de; netdev@vger.kernel.org; vladbu@nvidia.com;
> kuba@kernel.org; simon.horman@corigine.com; dan.carpenter@linaro.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v6 04/12] ice: Disable vlan pr=
uning
> for uplink VSI
>=20
> In switchdev mode, uplink VSI is configured to be default VSI which means=
 it
> will receive all unmatched packets.
> In order to receive vlan packets we need to disable vlan pruning as well.=
 This
> is done by dis_rx_filtering vlan op.
>=20
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_eswitch.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>

