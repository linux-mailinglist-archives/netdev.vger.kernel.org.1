Return-Path: <netdev+bounces-37130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3387A7B3BB0
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 23:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id BEC2F283078
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 20:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8706669B;
	Fri, 29 Sep 2023 20:59:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AAE17F6
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 20:59:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465521A7
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 13:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696021195; x=1727557195;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZslGlfV61oSNrGAcbaPHFxdH6Jc8qt3JbP+vOTopaeA=;
  b=gAZnPAfmhLyt4NdKqTXWss1ShHop5QDwCdDxYNoSIc1dIBnp2wDbhsQe
   IV7r3QZAfWMcTLLpo2Vi0UMBHYNn1I19bTSTAITwS0+75jYHvywBWGWaU
   UxO5Y63/3UnhleR2fbFhI9gTnO/D4h5J87Z3J76sbd+lPAoPcaovNJsuq
   c1H7i2okNi4+FVUTq72+CM3H5K1mpm8l/YQwcaGY2N1ekQ9Owg9XlAIWk
   iK4ZQOLK3qSXsKIR8J0WyQlEd6qNhJcM/jOTpsw4ih582zo6lZfoOl7j9
   NkjljjdJF/VWEVHdj40v9vlnRShaXnmEqwOr3usWuiY7ajCdFzsD08z/3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="446537182"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="446537182"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 13:59:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="753493532"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="753493532"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2023 13:59:50 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 13:59:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 29 Sep 2023 13:59:50 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 29 Sep 2023 13:59:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXq6ZC6xKZ/5e/W0MVOnmqKiJMr5sZlKdHEysTfVP1ZB2nV8QtVeFZWt2QKIW1yTMcncIMuy2NJi3zeFEFo3avBnfr1WZ66dHe7w6/fLykVllCW0MylaDOQrF1UFGeIy1VUzkpXrOi1nEpbC8QQdyfGJF0ryES/b0bmFgB3EAY+BzAKaa9jHkVsh0xFrS1wG5oy0SxwrsWiqNe/32rR8hoC/DKAP7AZSsPkYWbYcqv6B8HnlIW422IC2fENaPSlac2c+ZeM9tXPHk8e4s/WVQseCQ4/Cvo63FpkOs8yT+mnh57O/HCBhteC9RZWn5w5R+n2IquC4MHC0wT0K8d9Eyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCt97JD4uNOfm3ObIA1GMAGgbERzboC223lPHP5d9AI=;
 b=DSLN86Ohhe42SEfopedda7qxDm7ZMPl3rxNhaKIETkoitVFp0+X4nskeV+V5f95mMTCDZ5YPq54ksuQuh+Mrdo/0DNyIDZuwf78fI5ILnd9IK/+g3m7/LqGd2dhJzBIq5kfFoGZVACoTYktBXp2xGEk/gJAnbwbmtXrExJl6/w8lTOlxZ4aQ37jEk2+vqwBTNcH5c4pTHShKFAuCHHR8EKmdN9J6SOmMThfUUdVZiAByvxzCszEhBYEVjkpA0KS/WuGVZE/wT2uV4+q8SEeAXTodLJr2MkiPhAyY2saCBGDmFAE8YYxdXSf2C7OoF1GxjzNMzxDAmEbJgAULhMEsKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6266.namprd11.prod.outlook.com (2603:10b6:208:3e6::12)
 by MN2PR11MB4645.namprd11.prod.outlook.com (2603:10b6:208:269::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 20:59:48 +0000
Received: from IA1PR11MB6266.namprd11.prod.outlook.com
 ([fe80::76da:8cbb:1772:f822]) by IA1PR11MB6266.namprd11.prod.outlook.com
 ([fe80::76da:8cbb:1772:f822%6]) with mapi id 15.20.6792.026; Fri, 29 Sep 2023
 20:59:47 +0000
From: "Mogilappagari, Sudheer" <sudheer.mogilappagari@intel.com>
To: "edward.cree@amd.com" <edward.cree@amd.com>, "linux-net-drivers@amd.com"
	<linux-net-drivers@amd.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "habetsm.xilinx@gmail.com"
	<habetsm.xilinx@gmail.com>, "Damato, Joe" <jdamato@fastly.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>, "mw@semihalf.com" <mw@semihalf.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "sgoutham@marvell.com"
	<sgoutham@marvell.com>, "gakula@marvell.com" <gakula@marvell.com>,
	"sbhatta@marvell.com" <sbhatta@marvell.com>, "hkelam@marvell.com"
	<hkelam@marvell.com>, "M, Saeed" <saeedm@nvidia.com>, "leon@kernel.org"
	<leon@kernel.org>
Subject: RE: [PATCH v4 net-next 2/7] net: ethtool: attach an XArray of custom
 RSS contexts to a netdevice
Thread-Topic: [PATCH v4 net-next 2/7] net: ethtool: attach an XArray of custom
 RSS contexts to a netdevice
Thread-Index: AQHZ8W6G94wBXuLeB0CfPf+kWy0B3bAySomg
Date: Fri, 29 Sep 2023 20:59:47 +0000
Message-ID: <IA1PR11MB6266FCE957F98C0E8EE7BEEBE4C0A@IA1PR11MB6266.namprd11.prod.outlook.com>
References: <cover.1695838185.git.ecree.xilinx@gmail.com>
 <4a41069859105d8c669fe26171248aad7f88d1e9.1695838185.git.ecree.xilinx@gmail.com>
In-Reply-To: <4a41069859105d8c669fe26171248aad7f88d1e9.1695838185.git.ecree.xilinx@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6266:EE_|MN2PR11MB4645:EE_
x-ms-office365-filtering-correlation-id: a2fa2b37-ba76-43d2-3122-08dbc12f041b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v+W3SVEQbxvxaTDD9aWJW6xAlAZJNbHCe4+wWBx4SWqKPnsfNNyLxWgoqSKxTVVPnTdgAJ6KcFBuN49zGthnRYFJduQ6zLqqpcbX7wlrt+ajWu8IuZg+KNNNxTpTiSlVUMOx7LL6A7dBhrcxBovePkqGFDfW6mvzmizLF2Tv7S8AVx396KRiqmeuMz5aWWQuiXnwEThnZEM0X5BJ653A//FWETQBmo3pvR6dpY9bcnQsmoNoJ7MN4VPbngbib+h2cJsQkQElhPZvCpVQ7BJoZuSTWJ4w4ZMYpEvKkcybQo9xF77GavdsXotGCv70ymYCPY5ji3QvYy4ZdcLTF9zEcS1FSjVu/EyYo8TRgbVHV7G325MBXBAmn2XSVRHjUIKqkALQwHpHIB094pkNq1FL2IX5IL8fkfeTfWFzIO6wKB+zAHDqiCWcnhjjNUYvZsf2Rx3BLKNAKY4KaImVj+4KJxdlCVnNkLnaVh1Cymi/qW2YZL4bxUHYX1zBqVwuTWscOX/x+0pMZWEKyE0ZHQ3tDtSC8pmCjjz929tCwS6n/JpTCGoTTFY0RfQk86UNb+LtYPxOTzN7gTF9AH8l9b5QPXjt8TXtyXJ1O/bQHDT1fnZMJpucslsRccEVmbhkcYRB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6266.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(366004)(346002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(7416002)(71200400001)(6506007)(7696005)(9686003)(86362001)(82960400001)(38100700002)(38070700005)(33656002)(55016003)(2906002)(66446008)(76116006)(478600001)(26005)(83380400001)(66946007)(52536014)(54906003)(122000001)(8936002)(8676002)(4326008)(5660300002)(66556008)(66476007)(41300700001)(64756008)(316002)(4744005)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SPqeyRpZBYz1rnI9Q2Cw0HrXPhe59aOANo7Q5Y9z+iLSPYBKSRwf/jeTO85T?=
 =?us-ascii?Q?dr6Ok5xGxNdyMOkBadlJXp3y2+MkudmwU/mWOetdiSM/JUiEG7D2ei8GIUI9?=
 =?us-ascii?Q?IOP6WcKbOWqaBWpwphEG7k1vAJD/1sxuzbG1MOZuXYOtwSGikT3fNWHDcIk6?=
 =?us-ascii?Q?blgStFApBhn/EJWP10G4H5kSE0iCrKKAWHM8yjls9MlrdWk4LYmORDaYvieo?=
 =?us-ascii?Q?kq6Y5iS3q+8GRWEyqwMQNc8c9JiHEJ/zAqItGAOu0xHjTGp/BI1xrFtypWTr?=
 =?us-ascii?Q?7XZzEYfIFgPe3huUNwITqzesHAWpRci9i0UX+435J5C81NA7lc2vVCvc7duE?=
 =?us-ascii?Q?ySuBj7hvuPEJhWzhv6BHdr7MB2hXOVM+WjaVzASO8p0GM396B2hzPLuq21nB?=
 =?us-ascii?Q?zGK+2AKAY2sPQgbthWY6G3gJ0aLljC9+78X/xZMNqsMP2Q+IMqfhomNIKHUc?=
 =?us-ascii?Q?uRXvRfSR9aO6b/T06nVIuxLk3ShJLusZ8ptKDvSguoELp2k8KGW6mn9M4j7o?=
 =?us-ascii?Q?IvHi6Kl6cAO8AYzvLHesAKfakR7t5WoEdjnv9Rw1kEJsiHVrYFvpQWx3wh5O?=
 =?us-ascii?Q?AEAXTyEd6eucqlz71kYSp50MtHh6XemAS3UeqCanYE7HuFuPvgRVpdM4OnBY?=
 =?us-ascii?Q?xwGXi6yQ7uyI2rE1bTbexYSyEhjx1LvGKV5e8zV5vqOX6gaVN5rqpOinCx5E?=
 =?us-ascii?Q?x4k2eR81ZR8z5ec1GANDq3xPG60AqhMKwNqpqGhAfvazq2KI7oqryughtzMd?=
 =?us-ascii?Q?3kd9nXgu6UHdfHNrzAeL2Nu+feTPqK+nKySlaGi5A8HIRp5bjXhdzxuFl2eu?=
 =?us-ascii?Q?BIxxWq8/z7FMZic47jEr9EfKLMZ2+5WjzkAcgrnYtZm1WY18UIgos1fRIvMn?=
 =?us-ascii?Q?zH6yYMUH9FiIyeLN1AqzpWciqYo2aSjGd6KBoOwV+Up+bekJkLHM9IAKHWV0?=
 =?us-ascii?Q?eivzU0rRmii0Ry4KWuzk7+iun0BtXztkbNm3sgHagciF6hXUbnoJXXLGLp3Q?=
 =?us-ascii?Q?GBEj544n9+224U459kDSv1sj/gBcYYJ3bn3eNEs5+rnlhHQMs/IAWawBAbL7?=
 =?us-ascii?Q?avHFPEy6kmoR1Fa3Er2a8fU92izeF6uG25frcdgf9NB1uJEVkGpk5Z54nPhI?=
 =?us-ascii?Q?/AQ45J1F0lRYtFnZIUmSuDehYk9S4y0swqHnIgEfnSQzunyWRA/1JsTbRgGM?=
 =?us-ascii?Q?ZxYab4sZy5cokLIubK5oa0B5Ytnz3Ht/1cZA8uUvmlhKvlHzqyH2uMdBKBEI?=
 =?us-ascii?Q?inhwk6EFuuclmYUVCpVkdqp0sKF2YFCPN6DJL3+WVn2yCJY1LQU9G7iFyco/?=
 =?us-ascii?Q?fTTurt/9dvTHWNOcy+1+0Id8LpMJbdlOYVbx+kR8GnB9/e11wrwfJ6YSgcLo?=
 =?us-ascii?Q?gjUQqz0P+NEAeDB1ET3wSgd1mNdnLE+pRGJHboppyGCNGqxs4+fp2cAqj7uM?=
 =?us-ascii?Q?qpZOOVE8DiDX5lKLape8PfhQmsdAKP9no04S01GxkRT91Fk0vt/W1MP7UYCP?=
 =?us-ascii?Q?h5XDb5n1o5MH2So3J5glE0bZjNfb8kLTfpfQI/2KWZIJHgmyf1KTzOTgDqBI?=
 =?us-ascii?Q?XLo96mCdT4P7oe8Y3G63DrKzU+oMmrxLdsp45k+t7OZBlRozgB4qQyvUXsON?=
 =?us-ascii?Q?2w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6266.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2fa2b37-ba76-43d2-3122-08dbc12f041b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2023 20:59:47.9190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fhzJTtf3fA4t0OOhiuv4VDrpEAKCGMT5YPp9Vhc1R5qJ8OUqgRzKZturV4q63bBJoN+D3q+86RDV9y5Jebo6RC5w2+ZtzFvglVuKSk83gOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4645
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: edward.cree@amd.com <edward.cree@amd.com>
> Sent: Wednesday, September 27, 2023 11:14 AM
>=20
> +/**
> + * struct ethtool_rxfh_context - a custom RSS context configuration
> + * @indir_size: Number of u32 entries in indirection table
> + * @key_size: Size of hash key, in bytes
> + * @hfunc: RSS hash function identifier.  One of the %ETH_RSS_HASH_*
> + * @priv_size: Size of driver private data, in bytes
> + * @indir_no_change: indir was not specified at create time
> + * @key_no_change: hkey was not specified at create time  */ struct
> +ethtool_rxfh_context {

nit: */ and struct definition alignment. =20

