Return-Path: <netdev+bounces-19242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA43775A05B
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 23:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09B381C211D9
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6DA1FB46;
	Wed, 19 Jul 2023 21:10:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB8B1FB25
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 21:10:01 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8561BF0
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689801000; x=1721337000;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hAtURum0MQcNb0jtwpOqmhRMxfk3nniXoi6OX53VGzM=;
  b=Zk/sws8lNoxVcW/qoGcgQMO+5PBKvAyIiiU1WLmJojbB23ewgSecIQ0P
   k+YEcI+ngpCq7AFOhz3HsRA4f/HaH/2Rh0IEUIWkWYJAM4rm6OdMCCgGa
   f/akPSM4AqldV5xIk8auUlEECe1t4nHRXAzkfShDxV/jUuojWGG+BB4uN
   cIE3064aj5M6TCTPF8NWaSwohouoNdkv/Qi1ykiPnjMAqQURmZScYj99N
   8rOaCmC5yMRWYuLz+4r2aPc5n185NjMgGDSlj5WQTMIRu6qw7P9OgAh8d
   sYt7QSEsbby+Shta7kDgt7BDvS8uxfWchoaslR4WRH0lBOCSk5WESpGJu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="397435032"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="397435032"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 14:10:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="759314231"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="759314231"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 19 Jul 2023 14:09:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 14:09:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 19 Jul 2023 14:09:59 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 19 Jul 2023 14:09:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzNRWc/v0F2usOgniIAwgHyx2lVj2Lu6sFYvTmK0h9+GGycO3vlPsntEDFS4rqbqg+Py/V7YRUTCD2lb6Z2sjLGHW9WWXons7BQPSra7RnKdU8nwJpMEq/lnbWxlSBu39qajRGFMvOu6Fe+jSIUPLh4cC7c+Tv82+3rlG5MAPa1sGUrKNFge+yOIlvYJdYybTpSgeAsepcNntMChsxqynfvNs+l6y9ECtOxVzIUA0bBYMLFK/VW6iqsr+3JIWTSbtQ1n1MxxWGp7gFKPyj1ewugkea0d373cSyKWsO0CpY1jI9V4QlXqarL5WOrji/8g3GZFDbFSPU2s9EM7bxYVDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1WWziTqLlZLPCInSsMGdqnwEOuRmqrLBtHzFtbH+zg=;
 b=EwBb/+abnzlmFf2I9Db1pB57Gwa8ugl6Uci8mwUYxSs50xDCISZngCggDFGOWQUj5jlGNkAzXJ3P9btihOGIunNUX6yhyHHczxV5lW8fVJhWpV/PJ6wAfjEXYHredAksaF/GSp+QjqRVHo4K4Fu1IjReM+ebX9M1eMgvYbwWWGJi+Xxf+Va+Mcd1Rj5pnJ9Gx0pLSawxDClgklP3vcmuwrlBzeqt4mByaCHAOUAo8MK5ScHC2TvNLwXl+2Wyve8/N6PrU9JgXALNoRW2faLVw8tD16n87t9DEq6K9bchqyEk+sHkiioY8uZXggRbanvidVDxgCWvij1O/hdtjAPV1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 IA1PR11MB6324.namprd11.prod.outlook.com (2603:10b6:208:388::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 21:09:54 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8%5]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 21:09:54 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>
Subject: RE: [PATCH net-next v3 1/2] tools: ynl-gen: fix enum index in
 _decode_enum(..)
Thread-Topic: [PATCH net-next v3 1/2] tools: ynl-gen: fix enum index in
 _decode_enum(..)
Thread-Index: AQHZuZRcbwObcTNgM0ytXyhb7VyubK/Aa9OAgAEroBA=
Date: Wed, 19 Jul 2023 21:09:54 +0000
Message-ID: <DM6PR11MB46571F6F912B6B8B894CEB9C9B39A@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230718162225.231775-1-arkadiusz.kubalewski@intel.com>
	<20230718162225.231775-2-arkadiusz.kubalewski@intel.com>
 <20230718201705.06fadcc0@kernel.org>
In-Reply-To: <20230718201705.06fadcc0@kernel.org>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|IA1PR11MB6324:EE_
x-ms-office365-filtering-correlation-id: 5928d16b-eeaf-4669-2017-08db889c8005
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1VsQi/VCNkZ2XcjgXnDywqyXoBBmbjBKNMhKbftpOgh2HNkbAWSN4Lz6E+uGXUCM8qBhT0Fm+kAfl2SwnCLSslE/fwZYdUwN8+J4ztcOoDUWZBeDCMLca8ZL/MG2mjYoeCi2iXxgvh6th/z4/zL9TWjD6+0EjTwdmYopCcjxn4Fy0bPk+RBpfrKAEMvjiYKFVhcz2ul+Wyz/Msp9wMqqrIdG7BtO1FFr5S7X3k2luX/k5pOEtX8Ck1eEt/5X9lnCbyDnoftuMJlfTEA8dqZsSMaco0FIhYEUnFvdpY0Ep2KaUNLd4iB+mbqJWgUVyZMMUtgNBWucUlP+iqek0l+yJDt4V9WTsNgFmKPdQMgntaFiu1wmkdUeSQQRVSjbco6YUfbPzpJxq8W2DB1Hu0UdyPfW69L8AydUM+UjxRfvgYB93SqewjHb134qhWxLJ0HDbyUD8k6xIJIOHdc8k0wX8QhFlvIBX7X/cGBeoYzjxfTT02knr1gxcKenxtNA2UrOFAoQvVOx0h6VOVpKHr/UuHtB20sVZAs9dF1KMxn7HFqKyGAVnBkIKfwW5Cad2EfS7b7da7Bm4oqntiYIkxmzjGM7CxxbWpBlHHKGNOhIqtKrm8k//J6dOMGENhsoMMK7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199021)(7696005)(9686003)(33656002)(26005)(6506007)(186003)(71200400001)(55016003)(66446008)(76116006)(66946007)(64756008)(82960400001)(6916009)(4326008)(4744005)(316002)(2906002)(86362001)(8936002)(8676002)(38070700005)(52536014)(5660300002)(41300700001)(66476007)(66556008)(478600001)(122000001)(38100700002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fB3Vr+xPGec14VjdIcYaS2B+peyijcaTGXdqAJtcEXqh41wJGv4kp603BNRb?=
 =?us-ascii?Q?D7YfjY4E94kVpDB7MZKephp0MbYuVtZI7QHTy+Dnu1zxxPktkbrb0xRt3YsE?=
 =?us-ascii?Q?PRYMxfoH5518nIvn9M0EZkgDcIuKevD0h4H365nVk4QYvBeytEI04oCgpXtI?=
 =?us-ascii?Q?jIA9elIrTvH1vzE3ZmouBs+81fi6RlZKT681qTiY1R2yBzadvsIjjDrccJer?=
 =?us-ascii?Q?8JQU48mEvFO8rR1Zq/Fqc3X1SqvBxXjgZu0BIbSTc9CcAKs6MHUZ8gaRS4yj?=
 =?us-ascii?Q?YRLDXQkbnR+tbqh2Ph5NEST2ui58h3uhv6HyWpeMImfC+l8xNkt6UxdWyQWJ?=
 =?us-ascii?Q?060sTRfRJa+3evwXs5jufKtsp9bjTrtwj5C1pxU9XhGPPi+ii1wGRQzSvzrN?=
 =?us-ascii?Q?tQ5lGvY+3Nye+N7ZZDsYUukafs2AhjGHUcJPRfYCuZNxZdSBS/C9pt435qcq?=
 =?us-ascii?Q?sswqiBVcapqJkg4UfDTU/IVPJyE5TZf0zLJWNhC5LjejJw+mgA/TUGx8/2MQ?=
 =?us-ascii?Q?NaXwjYlnxZg3SRPWQ2alXrFHtP6/EDpj6kKYLjvNgyWF12UpqRWFjo0LhdZx?=
 =?us-ascii?Q?oJoRBDmmsvbcf/9se64ty7QKVp/H1BCkBcreklxjvLKKx+oS2iLXFDGpV7l9?=
 =?us-ascii?Q?niAXhKKfEIB4w3zHp4Osy2F1WoFS9ABSdIFTaUgkx7SeJ7KxkAL+19rWb0fM?=
 =?us-ascii?Q?hVrJH8Ogzn22q3zDtY2BAcjPdUuDsFkh4AiTLn0FCXx3EeL9z5rq5V3rhJjc?=
 =?us-ascii?Q?lyZ2p/PK7CFtZxNVQxA5IU+SzvJGXyFaDu+I2OdvZdaksCzx/Pe+Xu48P/Ll?=
 =?us-ascii?Q?c9QtcYArcc8TgPcE3BrbqN1qyWBolL9UHCKt2qcrA9PH7Lur4/HkKmQR7SZW?=
 =?us-ascii?Q?t7JTHwKHycKYyqEmnE/BpSsFhDt/JEbN41tOtEphpf0PnQN5AqXih5M3cQT/?=
 =?us-ascii?Q?MvfuXqirx04qxio5tD4nktuJ3tIWrRYQT2hoHvsQ4wUwXJn5uisZsI5DdWLO?=
 =?us-ascii?Q?tkpDjCtQOJ6lf2yF4k+kkFgXZjWKM1C3UMPTXr1BKd23U8/YoCfr3F57n7qw?=
 =?us-ascii?Q?dKseEwl2Id6Uo5XvT+OxWjn+a89CrQtVbvp4ayW/x3xbVUPuezGFbsiCGm07?=
 =?us-ascii?Q?YrjUT3qg9W7jIFQDb8xgJk/yeP8mnIYoQlYsDye5zokcm/L7L9kfMiCEvVPj?=
 =?us-ascii?Q?wvM8YaHCYQ3BuZ/cusxaQin0xgtbCJFUVAF1IpJrz47DskD9L3dfczQ/JUI5?=
 =?us-ascii?Q?8/d3xipxl51mWMuFSb7cUTv1fJOEYaMp4HCdpZZ2XQkqE7KcU/sTr575jDZf?=
 =?us-ascii?Q?AdCFcmEvz1yNF0m/UTaOvsX62WVVSPJsnxhplg09XNTJZ+wWJjCaKLD/aSIV?=
 =?us-ascii?Q?tfD8EVt2gq5b3X8uugLl53kh2XcB7jSE3hue7ft4mXQitpfPmJMejXAVcEcl?=
 =?us-ascii?Q?thLGaBuoNqsWJjuQgUZzQdQEsOxlXiMBvBVu/l98BvM7Ku+1PxWWwL9wjkuz?=
 =?us-ascii?Q?aPrwoTwUuQvjgTUJWw73g53I7GMeT0T9AHsN9OUhv+JBY3HmNbhPUgDJzFoi?=
 =?us-ascii?Q?scyZOs3BonVYx0nj0E4HcERn/OMIGMJOLLbral8waFTugdd2JvZqKDaeVDp6?=
 =?us-ascii?Q?EQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5928d16b-eeaf-4669-2017-08db889c8005
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 21:09:54.6709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p8vVDA1suDcWdKivYfAKwwCtg33ixRd47yx49i8++ekkNuGde0+LEUxNtTpMfPqbj6S85AUWIpTEkRQrC5bJAt2HN9G224MLfXCuHixg8V4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6324
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>From: Jakub Kicinski <kuba@kernel.org>
>Sent: Wednesday, July 19, 2023 5:17 AM
>
>On Tue, 18 Jul 2023 18:22:24 +0200 Arkadiusz Kubalewski wrote:
>> -        i =3D attr_spec.get('value-start', 0)
>>          if 'enum-as-flags' in attr_spec and attr_spec['enum-as-flags']:
>> +            i =3D attr_spec.get('value-start', 0)
>
>Just:
>		i =3D 0

Sure, will do.

Thank you!
Arkadiusz

>--
>pw-bot: cr

