Return-Path: <netdev+bounces-24340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9325876FD54
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 11:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2622C28247A
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 09:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB63A946;
	Fri,  4 Aug 2023 09:32:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF9BA939
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 09:32:18 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EA24236
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 02:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691141537; x=1722677537;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jPz2z/sMWQD+vYgOJZUQprNgkiKV6Xfe3NP0CIeH/PA=;
  b=WDDh6nFR+Qvwe/RZRw8G7P8M2tapBdt13aZ7fp7EhwgrMXolnfrkHyjJ
   t88J3MTOhf6gGL4yGunpUigUnRM12Y4hCD5xwRcae1pJXvJf7U4in0usR
   RrLjEH7Wtd3neldiIxPMIOdp8bP8UG8n+oynn7f2qQXBi+If7EWWcrmxe
   BKCHdq40pKtPZY4gue/aSEh7OalPElF3Jgksjokk39jkhZs33c8HIjUS/
   hjPkNDHNiZKLRZgdd+cbj5OqE/TcC6xYZ8yZnhOat8uUM8gJYBiCXB7+e
   snNus3y28ZyMrWqLlVsYnTK2NY7J+g+1CSotu7fibHQ0ZMzc+bEsIS2ji
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="369012509"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="369012509"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 02:32:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="733191024"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="733191024"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 04 Aug 2023 02:32:14 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 02:32:13 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 02:32:13 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 4 Aug 2023 02:32:13 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 4 Aug 2023 02:32:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jY5mcZDvGVeyypgTbvNQaPqkomMxQJ3HDjBjak2PA4c+ZibYiJYjeX9WQJa0SXTZ4LzNTbw4Sv+YaWLxcQwZgK8v82k+RQRICktwh7h07hD2pxEOjIR6DXd+h9H9mzOdy2RmwjmwliX49Rr+CDZ8zBmjCob4mZwWPezLXWbg38Ki0Xdz7/3TVy/iogoIQsZWV0ZtutWniDP1/toW6Zds760ZUUgyOXygCu3TwLwY3LUxpxSFvA+RLPlWK/QzoW/Oe4Ue93lgokGBFzMgKBRUieivJEZEgMoljJ+puOL73w+WaUFw39aG+1D38Yz8X0NaNXhgtXwyxq2izxx+VUK/Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4qriy6/eNqodO512uZlaLOKrDtuVE4wM9V5PUWChbs=;
 b=BEtS1X00Wsrh4MHJ17iAYTLAI8EXHa4vqe/ov9DTu+Czr9j/2cNwF7qv+TCPpwLOwBW+YnhWK7+fiNfI7VbqAGuavqNFl4iIheoRdp6jCJea49jKYISMzYHgdJQYBPzXqPBctoHai0XR8G/BOb55A0EkxhEjmfR12GF8HmeBgHkAksg2S5e6wmbjVJocgiJN0IypYVImh+aQShh/JZF84Kr6nKvqhzKjeKE4KdggPldE2B4NMsBocgiwTxn1TSoT6IjqLLB/c0Etsw1v2On8sFe2btqUi9odl4aR+mXT19s1DiiD9qDaO8blnjtfQhRZ/p2TKawO5OqmGSutFecoyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by LV8PR11MB8678.namprd11.prod.outlook.com (2603:10b6:408:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.39; Fri, 4 Aug
 2023 09:32:11 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::5842:74bc:4aaf:a4fb]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::5842:74bc:4aaf:a4fb%7]) with mapi id 15.20.6652.021; Fri, 4 Aug 2023
 09:32:11 +0000
From: "Drewek, Wojciech" <wojciech.drewek@intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, Jakub Kicinski
	<kuba@kernel.org>
CC: Jiri Pirko <jiri@resnulli.us>, Ido Schimmel <idosch@idosch.org>, "Vlad
 Buslov" <vladbu@nvidia.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>, "Buvaneswaran,
 Sujai" <sujai.buvaneswaran@intel.com>
Subject: RE: [PATCH net-next 2/7] ice: Support untagged VLAN traffic in br
 offload
Thread-Topic: [PATCH net-next 2/7] ice: Support untagged VLAN traffic in br
 offload
Thread-Index: AQHZxJ7hxBbCVR+hHEi3sJ9oWRxU2q/X3AgAgADhhgCAASP8EA==
Date: Fri, 4 Aug 2023 09:32:10 +0000
Message-ID: <MW4PR11MB577606B881AAF52B44B76839FD09A@MW4PR11MB5776.namprd11.prod.outlook.com>
References: <20230801173112.3625977-1-anthony.l.nguyen@intel.com>
 <20230801173112.3625977-3-anthony.l.nguyen@intel.com>
 <20230802193142.59fe5bf3@kernel.org> <20230803155852.glz4rqvrhx55ke3m@skbuf>
In-Reply-To: <20230803155852.glz4rqvrhx55ke3m@skbuf>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5776:EE_|LV8PR11MB8678:EE_
x-ms-office365-filtering-correlation-id: a893f27d-c518-49cc-3842-08db94cdadf2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pCUz+PdcMUOgUyCJAQ1ILP8BI0QocGz8HQf7f5gQO2f+ilRy/wyWYEzROcuQmES3zaSsNAfaPFW7QhVWF+c0DYE7iZmGyx2rLPIlOctP34uBg2WjAlGG6Acpwbg0B9ZpTSTuq22r1OE7G2kgFk3I0UrTczzyQhOL7fUKSLuJYh8kAugCpByiC4IMBOZ1WzXOfzgDHKY8/2NExGap97XgoCNZ39hXJnx1qDO0epmkZx2LbiMYnohR9/+3OxmJcuJ7oiMHqcKbOncuhxEmYM7js4JZo1GEDxEi7L5FMqy5z0UJXhhZpAEakDtz75n+msenstwxuSaYHj65ueLczbOKEc3FiAXnqi0m0yWqj2huboxJVL5+GqwzPZyxxqMvzgSobvosqXCiztcyqsxw4SAHV17lHb/xZQup3tlhG9DWyLHTvEKHcGYVAsF+gr/EooqrpvQd/o4bO7XZW2H59Dsd20RoH4FvDbvotrG5qRTxbDDR7y9rMd7Ky4DZ/z5Rnw5t1A1TDqh/op6aRX+JJpF8n9a+QYq7rAcd6tTO3rkTL2uTyInfYPMXBYqFF/pxy/eaJo1zQZtOYOAwFQRusu4QwgVEmlprOkG95e0/otXcv0QLPLkpv/f6Hci4pz6rRp95
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(136003)(39860400002)(346002)(186006)(1800799003)(451199021)(71200400001)(38100700002)(7696005)(9686003)(33656002)(86362001)(83380400001)(122000001)(38070700005)(82960400001)(6506007)(53546011)(55016003)(66476007)(52536014)(5660300002)(41300700001)(66556008)(8936002)(4326008)(8676002)(76116006)(66946007)(66446008)(2906002)(316002)(110136005)(54906003)(64756008)(478600001)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4MMDaaTrG7ddl4MltOVbAJi+sLYBirQ9WFOdiygEXR1/dOe61+fv9q47+gw1?=
 =?us-ascii?Q?YwMzmvcCszODLXJszqTy7DoCOAjRC2/yBxKBHNX0ZnyW6zy5fGbHYVI8N45P?=
 =?us-ascii?Q?CyL2szQfu9C+lHSepuJeqHI9CMZwqDbUgYebBDqJ+HCxHx7uvaNmdFqqIhCc?=
 =?us-ascii?Q?L+SFopvtNeM9TOL7Uxu+yvYVhCJKLyS5pjN0GFd7+7GOZ6VsIsDLwYKfsU49?=
 =?us-ascii?Q?/UEIE9gbXuKDhjf3Xjulpss5FW+eopMtm9UCFc+PKZbmXNM5Txkf1rI4Q4cz?=
 =?us-ascii?Q?eadfimB+LN7oRDu9uJnZMgixHEuNcwKp6RHsBv+EN/LIReNftYLekfHxKFqh?=
 =?us-ascii?Q?2ycMoeQi/BIRjoBg4ffdNk8ahn7GrJKGKg5c3R92fB6pqzLkRhSltrM9wwYt?=
 =?us-ascii?Q?pnzfh4CKOxopapoX0SRPCnqOzx3mQ+goiObLrTdFSFEDvT+HC+dn5zYh1RrM?=
 =?us-ascii?Q?VmZZvaIBWEX9Q7suBY5QVtsvHhxnRxeKRkkO+N62NLejIoGco/DBbQigucO7?=
 =?us-ascii?Q?MFes3B9yQWtNgT5REccuwinivd5Wt4+S/1juJy2z/FMbmvz7faldAGaWXgVW?=
 =?us-ascii?Q?aiCiMtx/H62XZ48fvCXcrNvQSfjJeOMapSwHr1ef+ZwfmvpvM+i5Fxbdt3bA?=
 =?us-ascii?Q?tLx0GTLdcGYfmNTv5rXfBdF85e6F1WzWMFbCVV/mkl7gP+1sNRNa3Vab0+4N?=
 =?us-ascii?Q?PTICQj0P+oU86KfBiR1qdEiuMI0z7Ey8MG4hxCo5XUpH/fmGDku50szj3tVt?=
 =?us-ascii?Q?pMRMKhVj+q+C3dQCUGQYKtiQJ/4m0AnAaRR+6gDVhEjTpX0hPRzh4vA2qj45?=
 =?us-ascii?Q?alx4WKFMGd8JcW16yWlqUF2JeJRqfO9aiSvAoOkkXbIW/kDXcfrmp+431DqF?=
 =?us-ascii?Q?6PVxJbkFDS6aQ4TUZQaXjFqb3K4uV95oSHLrSA/WYH5Gg0rWO3r65GI65uic?=
 =?us-ascii?Q?hmXEWpTJgql+3n1FK1C2GyddowZYGvA36xAozZEwyHrUS4MZD1J1xRXHONHY?=
 =?us-ascii?Q?RVzz+PpUD2OtrkjqssNkh03wJiaLhiej8inKb4yIlx/cvEVnoBCnY6vDtC1g?=
 =?us-ascii?Q?kZwWaRZJeEEUuZg9NM6ZP7LPjDgmmtC8daGINdofh4E0wNJ2yN8OOLVHhnPV?=
 =?us-ascii?Q?NtBAzOxR4hOBEpL6QfsXE4MC94Ep5fiM60/xA8JcX/W/xSpSgHIVujG2AOG/?=
 =?us-ascii?Q?I64xr4m6qI6jd5gx7BPDp54D+kZCFw6qYAT4616ucmGvhm9oGpVmozVqpR1H?=
 =?us-ascii?Q?mne7GBaJYTpdTawjtdRNNxjxFnGzoB9ufyKKargtsTKTjdd+RBpBMGeIlvO7?=
 =?us-ascii?Q?2bZ4kwWUSmFVxhUo4QiSS4V+Rxc0ItoxTdpS2gHL97JwzMebFlw2OYPuQ1Kg?=
 =?us-ascii?Q?KtppA33iBW6iRNQJE+4MuKIqxDESABkM38Q7M5fkCd4otquviezTvlHQRUzC?=
 =?us-ascii?Q?uuSMdq+TKdNwWyAPky6mmHFVk1zwxH+QbYB3hrLz5frIPJJON+2ruev9BCv1?=
 =?us-ascii?Q?MV2mvNM0iHAiv6jZ/ByBbqbGJaFDUcJMwhwQzCEyv4uYUua6EjCQP2RUJF7s?=
 =?us-ascii?Q?Jl2A1pETOhUCNH9gY9k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a893f27d-c518-49cc-3842-08db94cdadf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 09:32:11.0049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7cPJbq1A6OnFavoRa4lp34gE3UdrDbmpRCZcmHNzGCgIN1RslrJ0cOF5fPKBFrfuwjdT6MwQ/+VPpOaGA6WDpCxcYkkqtg9xuSzIFwvS3cw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8678
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> Sent: czwartek, 3 sierpnia 2023 17:59
> To: Jakub Kicinski <kuba@kernel.org>
> Cc: Jiri Pirko <jiri@resnulli.us>; Ido Schimmel <idosch@idosch.org>; Vlad=
 Buslov <vladbu@nvidia.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; netdev@vger.kernel.org; Drewek, Wojciech <w=
ojciech.drewek@intel.com>; Simon Horman
> <horms@kernel.org>; Buvaneswaran, Sujai <sujai.buvaneswaran@intel.com>
> Subject: Re: [PATCH net-next 2/7] ice: Support untagged VLAN traffic in b=
r offload
>=20
> On Wed, Aug 02, 2023 at 07:31:42PM -0700, Jakub Kicinski wrote:
> > On Tue,  1 Aug 2023 10:31:07 -0700 Tony Nguyen wrote:
> > > From: Wojciech Drewek <wojciech.drewek@intel.com>
> > >
> > > When driver receives SWITCHDEV_FDB_ADD_TO_DEVICE notification
> > > with vid =3D 1, it means that we have to offload untagged traffic.
> > > This is achieved by adding vlan metadata lookup.
> >
> > Paul already asked about this behavior but it's unclear to me from the
> > answer whether this is a local custom or legit switchdev behavior.
> > Could someone with switchdev knowledge glance over this?
>=20
> The only special vid is vid=3D0 (and that implies a VLAN-unaware FDB entr=
y).
> vid=3D1 is not special. Packets match on an FDB entry with vid=3D1 if the=
y
> are classified to VID 1 (obviously). That can happen if the bridge port
> is VLAN-aware (bridge vlan_filtering=3D1) and:
> - packet was untagged and pvid of the ingress port was 1, or
> - packet was VLAN-tagged and the VID in the packet was 1
> If the bridge has vlan_filtering=3D0, the rules are different, and packet=
s
> should only match FDB entries with vid=3D0. Both the (bridge) pvid of the
> port and the VLAN header from the packet are to be ignored.

Thanks for clarification Vladimir, we will change our implementation.
Tony, you can drop this patch from the pull request.

