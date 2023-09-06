Return-Path: <netdev+bounces-32296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 567E8793FD1
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 17:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF34281648
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 15:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2416210798;
	Wed,  6 Sep 2023 15:02:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B5510795
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 15:02:52 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA0394
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 08:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694012571; x=1725548571;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wLvEFTvDMCqMYchS1ti1Gi1ggEgVqkiNwKD6y5nPzZQ=;
  b=ZZ7TUO7NDx3rK8LrVyYM3067F/dJ4hubUpuS5C89KkX72se/Kk0M9Lo5
   sSuLOz8Q+JFftGS5Wud23+4jP1TU58594HVLcK5ZDK/FZnjDnl4L3td7a
   KliecWhx1ydZlxoxfVT0fjdgOcYlH070xhvQZbrpK90ln+YkJe9DW8Dw+
   ZXqLJST+m8GxhRfpulLeUi+EtkkcUo7cI0QB47OsCF672uhtQcnM3oh6B
   CyfjQ2W5CZsn/4up617cewF3K7n7Ky52FkCGMw2/nyvBz/yuN6X2qYaDl
   maOfVJsrovLXyxIsYycHR7kflMOh3FlNzKjk3JaqVZT7KiwchWp+Vc74B
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="463465602"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="463465602"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 08:02:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="776645752"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="776645752"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Sep 2023 08:02:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 6 Sep 2023 08:02:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 6 Sep 2023 08:02:33 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 6 Sep 2023 08:02:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyeGhdgMNtTi6nBghxGBEkZrDk/RPmW95E5WRS9gOPXNwYtW70jvZFCzRmRjg4ta+qOLP+VkM28BydYgtpCXzRl3R8Ok8cj5nn/rYIuR4siujEu+M72OEbNAwu3i/8jNd50XAHc02+NSofF6qb73ICXdf5gEYde2e9lhc3Xx5VHr2PHENscU54WMlh7I3RCG/yUrC1bAwu2SKgC5O91TWQZKscbeU8ui6tJ9xxZpJTGjs3BtLAI9QIRW8Sk1pemr631KUa3XIlDxcZpq2H7VtDG86KyeayylMrBst2F9HOJ3C3JmaNssXEWpSvdK7urYU1GaxoAHErMH6zLVzd2fqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLvEFTvDMCqMYchS1ti1Gi1ggEgVqkiNwKD6y5nPzZQ=;
 b=MkrrtXDXsnzq/e3sinXEm5GQy/INBonQyWLp1s7IjVEab52EBZvgnSCtPbwC9lR62YGEujvC3lFt8FSXqEC4GtYHa+UEzXdVcXf68lj/TH6HHxjy1pR4pAfYGubs8KcWkVownM/TYqtmeQl5GqVJ1uNsj8pteG61/OOpVoL/352lU0Qa/9lC8Jy1uCKMBIlDRlXPDeEpndGxSMIX4POaDavx+VVyv4n4jwHgxcI6u7Br+cWKiMLnDJF+Yi5p9fwt6KSSJam3LPloQgCsJxWT9tqLSbsy4EfNkxta8iu0z7ahGF0YzdjVTscr5fJHTC89sa2GUfuOuLMPdUSuqiQIfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6180.namprd11.prod.outlook.com (2603:10b6:a03:459::14)
 by DM6PR11MB4642.namprd11.prod.outlook.com (2603:10b6:5:2a2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 15:02:31 +0000
Received: from SJ1PR11MB6180.namprd11.prod.outlook.com
 ([fe80::5c05:24f1:bd1b:88f8]) by SJ1PR11MB6180.namprd11.prod.outlook.com
 ([fe80::5c05:24f1:bd1b:88f8%4]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 15:02:31 +0000
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
Thread-Index: AQHZ1UdLBr55a0cOOkC26dNjnXpg9K/4uEIAgAFVHMCAABZcAIAAPQoQgAFe04CADiGKkIACrVUAgACeCJCAAMrNAIAAAZNg
Date: Wed, 6 Sep 2023 15:02:30 +0000
Message-ID: <SJ1PR11MB6180AA0A71479F82C152CF03B8EFA@SJ1PR11MB6180.namprd11.prod.outlook.com>
References: <20230822221620.2988753-1-anthony.l.nguyen@intel.com>
	<20230822221620.2988753-3-anthony.l.nguyen@intel.com>
	<20230823191928.1a32aed7@kernel.org>
	<SJ1PR11MB6180CA2B18577F8D10E8490DB81DA@SJ1PR11MB6180.namprd11.prod.outlook.com>
	<20230824170022.5a055c55@kernel.org>
	<SJ1PR11MB6180835AA3B1C2CC9611B44AB8E3A@SJ1PR11MB6180.namprd11.prod.outlook.com>
	<20230825173429.2a2d0d9f@kernel.org>
	<SJ1PR11MB6180F2DBE9F6296E35451B3CB8E9A@SJ1PR11MB6180.namprd11.prod.outlook.com>
	<20230905101504.4a9da6b8@kernel.org>
	<SJ1PR11MB6180C190E2ADF4FB2B17A430B8EFA@SJ1PR11MB6180.namprd11.prod.outlook.com>
 <20230906074632.0fc246e9@kernel.org>
In-Reply-To: <20230906074632.0fc246e9@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6180:EE_|DM6PR11MB4642:EE_
x-ms-office365-filtering-correlation-id: 3d1902eb-e92b-47d6-a281-08dbaeea4b2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iLs9EwBx4UlnAXzyPm0EjPIal6i2LCBaLs/CMbSwGBDSqR6h3A7/td3IZKr7TwzbgtLD75oJe13CsfU9vMcSz11Kt9bEB11sUrNUDLkLSzNmso2LyYafHVXacDILuPc57TErbCBRoa4X3ogNOKrXVGxy+WMOHK6JaKagfjUWxfYx1R28zf/CeHu46if4Cw1w/bPGelST0pdGPvLQvAxUmG0pxMwPeiFFT4u/mbeAhQVT/Ei9kZtVphr8uc8ZHVJtYylVaj451VCFU+Cee4f8vtTLB0wMV3N3dypgBDfKMXeuOc8Mtk4pj0Vs0vckzyX5ovt437YHPDXueN4M91mrav9gkVOngWT+HnDm+8oamfV+Rn8pSHZS4cUJHYe0VfShBZlSdzzxy2uWJLGBkUbPSFEsRExtHF21R/PbtQoPAPmPVgbEQzPKy9iE+tPce2a8Zyz+tQE8dTyqfLiVaoCIgP/a8B5fwNZ00Xk5GdvPTPuCU8EJ1EhnyZabmGXVeRNjS5csgMAvQ5zh7RtCUsnBX8b5/aQMccM73vg/cHCPfxAWrhitxSv93PcaXjffKC+MjGx/ZlmcAtm1Pk0mtQLKoDFR9JxnnGanLMIlCqI2JKN/JTi3ESOw+Q/ib6S+Xs+Ls6yxrXzxKMV/81RMNm8S4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6180.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(136003)(366004)(346002)(1800799009)(186009)(451199024)(2906002)(83380400001)(9686003)(26005)(66946007)(54906003)(64756008)(66556008)(66476007)(6916009)(66446008)(316002)(53546011)(76116006)(52536014)(4326008)(41300700001)(966005)(5660300002)(8936002)(8676002)(71200400001)(478600001)(6506007)(7696005)(38070700005)(82960400001)(38100700002)(122000001)(86362001)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J5NlH76VeTZMGbnF76NUyNY8yx3XOEGJl5ldNU/9CLrcvJOSrFcMAQi/+V06?=
 =?us-ascii?Q?B59OBrz9GizrcZqQALVNxoXVJ5G074j6ipKaVIvKRRuxHXqn26w/jgeW61bx?=
 =?us-ascii?Q?cQ5JWcLHwO0gpZeTlb9L+6NFehi0/hmvcQcPQpzNGppaCZ1xyjqk1Y2xZ5zv?=
 =?us-ascii?Q?RXNnXVuYApl6eC0wSC5c/3blm/TPJhDxBLhZDv8XX5S9Zv79tOiqctdp/+LK?=
 =?us-ascii?Q?owBJX6MWpZQDWpu/di1QYzlBunkzesFsLk8qCLl3wEX+b2LeIHskUtIoC484?=
 =?us-ascii?Q?Cj6o6p2xWPYjuCzkAa+qn2xV6w1sa118BV2dPqhmNP8AcltpbXJO6YOXL7Yk?=
 =?us-ascii?Q?8g+ZE1wEkjoh4wREG74eUkPB5kKMKDRTQOh56DBMPC3KVqXKN9suH4U9xQb+?=
 =?us-ascii?Q?A/p/wG1L/+0odMDF4JK/oNdfLZEBIgv9HvQAhSuG+a1JBOCuZ8ogyNBHBkwd?=
 =?us-ascii?Q?5taw1KrTo5hevQ4co1qmiK7yShORsNBzJq4cUvnIL8zcQU4TG/T8+zDjUH1I?=
 =?us-ascii?Q?1c9aRfvjB6sxel9tY4JbOdxx9CvjWnl5k+4usvojg4bx+AbZ+mJXGS9V/3Jv?=
 =?us-ascii?Q?gmbWj2lFWoxo3vHq747+gLMkg5MBRdQ1Itd1k6CtOfOQ5j6oDPaRY7xqsSU0?=
 =?us-ascii?Q?kqcGuJP34IGfQd1DH44fT8L1jHSijadbTPegJTX6fioRW8UE1nrUJvyuy2PE?=
 =?us-ascii?Q?vIWdtURQtmOKuXYBNpGtMYwDLjUYyhbKn8BDSck4y8lj+yhD/g953akVN++J?=
 =?us-ascii?Q?pM19cCv5N2VBptDkbTRVVMKraaActguL6LkRlFmtHSjX05Qwv0krHuluVsIB?=
 =?us-ascii?Q?XqXWEdXlkx2dRcIG2X2u4ubTHSWi6f/L+3ATHpAWAcE5fk0XxMqMCgYXIu2U?=
 =?us-ascii?Q?CGAAdFh4wRuxsZXjKqQV+u9+aZsxO41dn3y3gT0XyV/R6+XJ382ZRhkwLkmI?=
 =?us-ascii?Q?ASM/59B20xXt2Ze9gYafd6abJHXu/ok+eGSGA9//3Mz4cOSEh/K729+7jQwx?=
 =?us-ascii?Q?hqsv5IhGjqG8xcD7INUm69THxeGJR9g8MW3ZmUT8T1wirDgM2wtY7JUFLNMx?=
 =?us-ascii?Q?6Zso2kLGqQe4jkQUiWZh0BNWSX8ogbutT+ht3/gT9o2+g2o5SnUxYUT5Rnxo?=
 =?us-ascii?Q?OLWzZ7XWv3c6hZo4MsYBxjBkN07lIy9ePXFDuu/TnQdwGIlMVkqPTXOxnX2A?=
 =?us-ascii?Q?5BYdTPuXrrmvcvMwgwfJ3EtFxtDAc2GhQYjW0UkttcXfDzrhs4dgS8pPUPnW?=
 =?us-ascii?Q?ccomtltYfXiE+JGJjz+64m8txf3Rxp0+kUkU6hxXXKYdxnVgeTmFCFdcwHLd?=
 =?us-ascii?Q?HRzCGX3VrlVrx3cIMYRih8PndcB4Rf1qWXMg2oPAd8MzcP6wnRfxnV/GwjHR?=
 =?us-ascii?Q?jgyJox01SrNsM1XdxIMIh1lRRYGoj56FXS8iY28iSPpqcOIk9Tfzc+Pnac9q?=
 =?us-ascii?Q?hwp9znf3q6pKuvByqXfXzxYgDix5445RLz3yqYpic9E+CnGvrYHHMfqyhyYd?=
 =?us-ascii?Q?ut52mLo4OC/IFTpruttAWp1CS4ZkIPb8qutb2/sXwJMr1GMI0ry4ka4ptpQD?=
 =?us-ascii?Q?1i3sr+VdjjUWxDTY0fDHprfmnws8/zc43ZOyqcmt2n5fC4juCc+LJoRKGnaH?=
 =?us-ascii?Q?hOrHjElJoQuExolrXRcujbA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1902eb-e92b-47d6-a281-08dbaeea4b2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 15:02:30.9946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z03HsAoH5h21uG934DUZLriOWIOuky8ktd2W5QgyzXy5SPWiKfS8pBvV/c/Avkf4JBeJEDkchoYLnW+lWVUEPuUwlK0sGoVaRWL8bNApJIsMK2ZCPNrrF5PFeAztvZcm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4642
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Wednesday, 6 September, 2023 10:47 PM
> To: Zulkifli, Muhammad Husaini <muhammad.husaini.zulkifli@intel.com>
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; davem@davemloft.net;
> pabeni@redhat.com; edumazet@google.com; netdev@vger.kernel.org; Neftin,
> Sasha <sasha.neftin@intel.com>; horms@kernel.org; bcreeley@amd.com;
> Naama Meir <naamax.meir@linux.intel.com>
> Subject: Re: [PATCH net v3 2/2] igc: Modify the tx-usecs coalesce setting
>=20
> On Wed, 6 Sep 2023 02:52:30 +0000 Zulkifli, Muhammad Husaini wrote:
> > > In the ioctl uAPI we can't differentiate between params which were
> > > echoed back to us vs those user set via CLI to what they already were=
.
> > >
> > > Maybe we should extend the uAPI and add a "queue pair" IRQ moderation=
?
> >
> > Good advice. BTW, if queue pair setting is enabled in the driver, could=
 we
> change the existing ".supported_coalesce_params" for driver specific?
> >
> > From:
> > ETHTOOL_COALESCE_USECS which support (ETHTOOL_COALESCE_RX_USECS
> |
> > ETHTOOL_COALESCE_TX_USECS)
> >
> > To (new define):
> > ETHTOOL_QUEUE_PAIR_COALESCE_USECS (ETHTOOL_COALESCE_RX_USECS)
> >
> > With this, I believe user cannot set tx-usecs and will return error of
> unsupported parameters.
>=20
> Do you mean change the .supported_coalesce_params at runtime?
> I think so far we were expecting drivers to set flags for all types they =
may
> support and then reject the settings incompatible with current operation =
mode
> at the driver level.

It doesn't seem like a runtime.=20
The queue pair parameters that I stated previously can be set as soon as we=
 want to register the ethtool operations.=20
Currently it was set to ETHTOOL_COALESCE_USECS which supporting both tx-use=
cs and rx-usecs.
Thus, by restricting to only supporting rx-usecs with the new define of ETH=
TOOL_QUEUE_PAIR_COALESCE_USECS
would be useful in this situation IMHO.

https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/intel/i=
gc/igc_ethtool.c#L1980
https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/intel/i=
gc/igc_ethtool.c#L1939


