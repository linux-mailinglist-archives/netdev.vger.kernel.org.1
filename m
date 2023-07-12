Return-Path: <netdev+bounces-17145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B9B75093E
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 15:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6207B1C20D9E
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 13:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCEC2AB2C;
	Wed, 12 Jul 2023 13:08:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B7C3FFE
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 13:08:31 +0000 (UTC)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344D21981
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 06:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689167310; x=1720703310;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VTYwuEL3z5/mQc/Kn2HsFMvbWpO8mH3xITleI7QjQJE=;
  b=G7a0kEExrzCDg47acSTLmQgHb1yP3T7Z/zsROiFXP9+PJeE5q1Zw67E2
   7j+VUe9SPpsidmeadggg5deMQEHksrKAQLdsIgbJYE/v/bRMmdNPhTyk2
   TjQKP9GbaCa3o1fngEgWsXLL8iNJnqFduLgsf/phhFYQSEZqjNrTZHgUu
   Cu4RBLztcyDe5HZuWupWSCURCDXpdAItn1Y5eNsB8c2DQSndv0EYIB8WO
   5h41gO8y0EBDa2rvHVeOWfHmYYGv/XpijnbZEdt3FAZUTaKNhHHl4bPra
   QZ3r3wDclQqinTSY82Kudu1DA3lFP0HqWzDF+Lo+bw4lxGSpdifg8CY+5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="349737758"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="349737758"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 06:08:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="756752275"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="756752275"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 12 Jul 2023 06:08:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 06:08:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 06:08:24 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 12 Jul 2023 06:08:24 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 06:08:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXUNpuxeom7R1mIrV3x5OHojpIa3tvyvXAW7vxjIIpy2kisqr6APUkkPNV5FtDmBM/emW0ER3I6R4Q9cqITLncICUYMw5zT0RssJnazMwSUJyLd7r/U+CPxQBMCcckH9sXJs1eZAkGqVGNst5y1jo1mG2YXhl2l8hL0/vkEpJicrgznLbU610r5TndydV6XIWAdvgzIo4LrsXOX98JVIL72ADNJy0TJlQP0+tNzFTI7AOBi7eEW178fEzY3Iis/gQJsIbPg90KeOJhyykVWtDWHpF7vmPKVoA4SZdj8z7Pzfvfxd/9zVDgsjkMTthi66kR2UtZtAnTne3iBGXoE/kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXWP/rKcvCeuYYjG8zO2lmNroIeW4i2t3cGd0+jPR80=;
 b=ZTXJpGuDd+y/3Y5FIisAzZH+B2AJ9BD88bLfGA5FCEAAoUivaSiFYn+xNYd3wcpburmcZ9qgMW/VjwrdF2zhKWHwhD805fVyFblCyEQfQBeq54rJxXpmLyUtolb5zJ/8A8vBtlm+20WHRyCRgpnN0xD1iqYAbS2pRgMX5yg1BrmeN6V6i4MmpjRsF0VjiAEniZWMNgICI+t2IT3338RdtnU5zIPxVnG1oIaFrviIVroKF48oR3P5hpxieuCav9LLyBEKkN8DyXGQsRQP1Av0Zc9Q2fbwFcPPAigDSEqMHifYPxEyp7hVoHaSPdVJZIhucFLXfMQAIg6e8VxzcOIHiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2731.namprd11.prod.outlook.com (2603:10b6:5:c3::25) by
 CH0PR11MB5233.namprd11.prod.outlook.com (2603:10b6:610:e0::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20; Wed, 12 Jul 2023 13:08:21 +0000
Received: from DM6PR11MB2731.namprd11.prod.outlook.com
 ([fe80::43c6:1db:cf90:a994]) by DM6PR11MB2731.namprd11.prod.outlook.com
 ([fe80::43c6:1db:cf90:a994%4]) with mapi id 15.20.6588.022; Wed, 12 Jul 2023
 13:08:21 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Leon Romanovsky <leon@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, mschmidt <mschmidt@redhat.com>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: RE: [PATCH iwl-net v4] ice: Fix memory management in
 ice_ethtool_fdir.c
Thread-Topic: [PATCH iwl-net v4] ice: Fix memory management in
 ice_ethtool_fdir.c
Thread-Index: AQHZs+Ag8Yx1sL6j80+X4iUPshkbda+1rM4AgABt80A=
Date: Wed, 12 Jul 2023 13:08:20 +0000
Message-ID: <DM6PR11MB273160DECA7B68AD61B2F18DF036A@DM6PR11MB2731.namprd11.prod.outlook.com>
References: <20230711100450.30492-1-jedrzej.jagielski@intel.com>
 <20230712062958.GX41919@unreal>
In-Reply-To: <20230712062958.GX41919@unreal>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2731:EE_|CH0PR11MB5233:EE_
x-ms-office365-filtering-correlation-id: b6a8ff79-ce20-4de9-e133-08db82d91119
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qihi+OfGiNC6GRTLpJ99AYJHOMVnE9Aji9qruWdJstMyje6VdAmy32VVusg3VtPJ1MPw4SELJ06mJAx28Gz8XqecSkk5Ue3+D+Y9cSbQx6jiG34jIvtPC3HHVMZUoUBWtgTgQewvozi5oZKqBG6X9PslrIrFT+iqlv/slFAX3+t+hOzkbwiKm+W3pElIxMkeDWKLLs+B+YrIp9a3hNhSuqLsn2n5hSNdv4c1wZp1lXJVRZbIBbb5n+dyYOS1QQPnEkSA54HJ/R4Z/F33I2CmJuBbQTl2wCOPLFRpKs0EKqUmM83+WH5MQiZ3CH49JNXqW9DBsfEhBDPBnzsNXjSxwn4JBP4Svfj28MUhIxlAUiRYCRl7kNK3TniQRUrkzy5fMedV0qle1ETEftNxlwiuQB4rTointwCPH5l4MG2nusiLxR8D0SgC7pEWoDh+mxiQu5qVBJedNB+LUdYb+RAOih2o1FEcxfS04wKQdBIpiq2WDVF1N0HsKDtyjmplM9L7QUymOa911OmEPHZ9tkdPcR/ffNeM4ys5iKDNlVZ7I7y9pnmTg9LOWJSymOQB7rzsVVmf9sUHsvMUyTGyJRQaG0kI7IGmr06ihnRFQGX6UqY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2731.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199021)(2906002)(83380400001)(38070700005)(54906003)(38100700002)(7696005)(122000001)(82960400001)(71200400001)(4326008)(66946007)(66556008)(76116006)(6916009)(66446008)(64756008)(66476007)(33656002)(316002)(966005)(186003)(41300700001)(6506007)(86362001)(478600001)(55016003)(8676002)(8936002)(9686003)(107886003)(26005)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VacrvfMjw52GuAQIWeebqbogusYJhbvzVrOM1ESsF7Bq6zB8d5DVZYj7QsAg?=
 =?us-ascii?Q?hRH8SesNRk1/WhD9RCoW12wm0VLqgS28ygwGvZvGP/jvBH5KHUIRvbOhV+hG?=
 =?us-ascii?Q?be3MltJLD7dz0/iaX3bUYLrZ5AxSQWCAcaZQj+0Kvr2+V8vj9AA8kZt15K55?=
 =?us-ascii?Q?pmPpZ2nefBhp9f3tKfAPvgZFgK2ngM9CnvkL7ayxSKcMBb3klJucbu7NWhAc?=
 =?us-ascii?Q?FKW/tX4kXvrKEtI3DZnhsc9tjybX3S7NpukQ+iB26fanKXamJf5gp/CoJtmH?=
 =?us-ascii?Q?sF8fUaBiY5WhGmjlrPSjvnR9Qgo6oYsG8usnCE2+WfL8hhwLdp2y5E+vAgOW?=
 =?us-ascii?Q?K6YaMZg9XDby+vcm+9qbjxAlr0+4zMp+e8muo02rzxqmL7ggO9mOCinjOaXn?=
 =?us-ascii?Q?z4AAcb35M+n4gbDV7eaq/4WBY/9LnxE61x8IeYtqEGtU6I1NTigIlwi+M8dL?=
 =?us-ascii?Q?iB7SV/B++tpBQrqcA/1l8OxdI835iCEtQS5qL30kLXMRytBsE6NaaGhuotHA?=
 =?us-ascii?Q?68JUKZHAlAJYIxpNyGQ346qJCgZxqsegn56dUXAFgltypwKaqQbDYAFa96yW?=
 =?us-ascii?Q?C0vFP28yXpfvPpDKE4V52lFEv11JHwRzLcWt0BERsnbeXFYCoQuoW+h/gQ6F?=
 =?us-ascii?Q?tvY97o5mIMc3em9cLZt4L0afdrFBq1tGhzPrAvSgE/q4ySv9hwxO8Mf9LbL+?=
 =?us-ascii?Q?haHd3xSnCMphLF0l8uSwDbiqt7333o0vx5OPWuHopE6JMuZLpo0FcnEEozbK?=
 =?us-ascii?Q?tjoLGAsF2kvengK20eKmm2gC2qB7hyUENPhNK4qnUV071h/0VDeDxOBZenRV?=
 =?us-ascii?Q?+DpQXMqg3VQg24L+qtw7gb6isAqVP666Pk1VfwzOhz9xmAGom/CV1N1nkKY7?=
 =?us-ascii?Q?RuQmISLu7BuAFI14z3MMBidpr7SlsrCU8jDTJl6BnSNfawkYc5jMyoft/KrP?=
 =?us-ascii?Q?rbkIj/N/PA/UmWQNOIif1A+6Fdh9eGHZRkidWPFrQ44mmjnB5kXY32XxoAc8?=
 =?us-ascii?Q?sLLzvopCzFF36HZ4vejVH9o2xQQbD4F2owj1hmzReZ1GKakbTvd0SkH+YWIn?=
 =?us-ascii?Q?Cssdo+/N3VMEE5QugPSrR3ZuIoWVHSldMzbpfWcd5N24NIVbU+skYbtimsNP?=
 =?us-ascii?Q?kcaHgc3tRNdrKrbdv85hzC+kgfQ5P5T7HcNhMkM3cMgJM8vw1GGOmu2DdGlq?=
 =?us-ascii?Q?r7DFzM+LJr82/SD84neRSuSA2rxsZaefSOsNhGxJY1YRZ1cdyb84Xg84KYMC?=
 =?us-ascii?Q?K+kItT9+W+M3H5Ralfzsh37tHtR9dPWaFTYIWITMfKiETSs4xIZqN/1c+y3/?=
 =?us-ascii?Q?7nWLDvYGfjFRvvFBLep8s2gptG3ioCXEcwxl0ZZ8L9IljxnnQANeb6yX4JiS?=
 =?us-ascii?Q?H6el6TcRz2/n+l402bvnZ82PvcjlhwGSJ0LcYo9c9toszE8XBaiAQiOCfDsL?=
 =?us-ascii?Q?odoViZRzCIur2o2oCoIP86hgKkKnbYuWKaIEpiW1L936P1qeFOjz5vL1/EKy?=
 =?us-ascii?Q?pYlWVOzajSBVmTOi7iP5b+gOYs5w3+Yi+pt0Bv+nD/4Sep23TX/BTTgovH1p?=
 =?us-ascii?Q?2uxytBQJM0liY+FaL3mK7jZzdpcnJUrnK1Nr71l9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2731.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a8ff79-ce20-4de9-e133-08db82d91119
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 13:08:20.9153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c5caIDfOtnXzmH6BcM73KBb7g88cl+qLleTqRoWgU1pUwl1Fx7TtpTjPWIJfRcXcZsFq0ki1Rr8P+gffzjqxG96hke2/PBRTFDLtzjbYaE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5233
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Leon Romanovsky <leon@kernel.org>=20
Sent: Wed, 12 July 2023 08:30
>On Tue, Jul 11, 2023 at 12:04:50PM +0200, Jedrzej Jagielski wrote:
>> Fix ethtool FDIR logic to not use memory after its release.
>> In the ice_ethtool_fdir.c file there are 2 spots where code can
>> refer to pointers which may be missing.
>>=20
>> In the ice_cfg_fdir_xtrct_seq() function seg may be freed but
>> even then may be still used by memcpy(&tun_seg[1], seg, sizeof(*seg)).
>>=20
>> In the ice_add_fdir_ethtool() function struct ice_fdir_fltr *input
>> may first fail to be added via ice_fdir_update_list_entry() but then
>> may be deleted by ice_fdir_update_list_entry.
>>=20
>> Terminate in both cases when the returned value of the previous
>> operation is other than 0, free memory and don't use it anymore.
>>=20
>> Reported-by: Michal Schmidt <mschmidt@redhat.com>
>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2208423
>> Fixes: cac2a27cd9ab ("ice: Support IPv4 Flow Director filters")
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
>> ---
>> v2: extend CC list, fix freeing memory before return
>> v3: correct typos in the commit msg
>> v4: restore devm() approach
>> ---
>>  .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 30 +++++++++++--------
>>  1 file changed, 18 insertions(+), 12 deletions(-)
>>=20
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c b/drivers=
/net/ethernet/intel/ice/ice_ethtool_fdir.c
>> index ead6d50fc0ad..b6308780362b 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
>> @@ -1281,16 +1281,25 @@ ice_cfg_fdir_xtrct_seq(struct ice_pf *pf, struct=
 ethtool_rx_flow_spec *fsp,
>>  				     ICE_FLOW_FLD_OFF_INVAL);
>>  	}
>> =20
>> -	/* add filter for outer headers */
>>  	fltr_idx =3D ice_ethtool_flow_to_fltr(fsp->flow_type & ~FLOW_EXT);
>> +
>> +	if (perfect_filter)
>> +		set_bit(fltr_idx, hw->fdir_perfect_fltr);
>> +	else
>> +		clear_bit(fltr_idx, hw->fdir_perfect_fltr);
>> +
>
>The code above is assign_bit(fltr_idx, hw->fdir_perfect_fltr, perfect_filt=
er);
>
>> +	/* add filter for outer headers */
>>  	ret =3D ice_fdir_set_hw_fltr_rule(pf, seg, fltr_idx,
>>  					ICE_FD_HW_SEG_NON_TUN);
>> -	if (ret =3D=3D -EEXIST)
>> -		/* Rule already exists, free memory and continue */
>> -		devm_kfree(dev, seg);
>> -	else if (ret)
>> +	if (ret =3D=3D -EEXIST) {
>> +		/* Rule already exists, free memory and count as success */
>> +		ret =3D 0;
>> +		goto err_exit;
>> +	} else if (ret) {
>>  		/* could not write filter, free memory */
>> +		ret =3D -EOPNOTSUPP;
>
>I see that original code returned -EOPNOTSUPP, but why?
>Why do you rewrite return value? Why can't you return "ret" as is?
>
>Thanks

My intention was just to not interfere with returned value.
However i see no reason why an unchanged value shouldn't be returned

Thanks

>
>>  		goto err_exit;
>> +	}
>> =20
>>  	/* make tunneled filter HW entries if possible */
>>  	memcpy(&tun_seg[1], seg, sizeof(*seg));
>> @@ -1305,18 +1314,13 @@ ice_cfg_fdir_xtrct_seq(struct ice_pf *pf, struct=
 ethtool_rx_flow_spec *fsp,
>>  		devm_kfree(dev, tun_seg);
>>  	}
>> =20
>> -	if (perfect_filter)
>> -		set_bit(fltr_idx, hw->fdir_perfect_fltr);
>> -	else
>> -		clear_bit(fltr_idx, hw->fdir_perfect_fltr);
>> -
>>  	return ret;
>> =20
>>  err_exit:
>>  	devm_kfree(dev, tun_seg);
>>  	devm_kfree(dev, seg);
>> =20
>> -	return -EOPNOTSUPP;
>> +	return ret;
>>  }
>> =20
>>  /**
>> @@ -1914,7 +1918,9 @@ int ice_add_fdir_ethtool(struct ice_vsi *vsi, stru=
ct ethtool_rxnfc *cmd)
>>  	input->comp_report =3D ICE_FXD_FLTR_QW0_COMP_REPORT_SW_FAIL;
>> =20
>>  	/* input struct is added to the HW filter list */
>> -	ice_fdir_update_list_entry(pf, input, fsp->location);
>> +	ret =3D ice_fdir_update_list_entry(pf, input, fsp->location);
>> +	if (ret)
>> +		goto release_lock;
>> =20
>>  	ret =3D ice_fdir_write_all_fltr(pf, input, true);
>>  	if (ret)
>> --=20
>> 2.31.1
>>=20
>> =20

