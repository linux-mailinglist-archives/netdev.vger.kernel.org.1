Return-Path: <netdev+bounces-61938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 525A082547C
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 14:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F14622842BC
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 13:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C722D609;
	Fri,  5 Jan 2024 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l1nC3yQA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D63A2D61B
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704461481; x=1735997481;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gFHEWWH9Mv66qYWY21bCUJ5xWG2OUm5ER6YaqcdtVes=;
  b=l1nC3yQAITQqEy2iu2yeO/e2rp0HLvTsBYYczTcsRoZhSJpocd+VY/qn
   3pbLtEq+4n/sT8CnbsDxSHuSQ8HsejadVYzSJMTjLquEPso8IzGKSxTAR
   7qZPoCtq0g/OAIa1J1D9Th3bsvOB8IhpxKVj7451F5qs5ipDKrjGQij0D
   lTtZ6x3BmJjumQAAZqzLhuZxOM+iukKYZTNhlBe45By8azhrEU6jm5ngn
   BZuEG6Qr8tWTftN5JEUaWLWvMP9GG4EeN8WqrrkKyI/hON4MMQEIqxHKz
   JuyBqWf2RYd1FwWrLj+JA2RTA08BFQDiq8FQ6sR+t+UTIk9bAWkTod+rY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="461809173"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="461809173"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 05:31:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="924224929"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="924224929"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jan 2024 05:31:06 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 05:31:06 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 05:31:05 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Jan 2024 05:31:05 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Jan 2024 05:31:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdNj3uUA1CZpSOymuvAcQSgf1QSJKVuSKrQSKeepCvGXlJKPy/EJet6LeQoDKJHeSMPSRB4DEE2rxaZ5tX9/KBcCm4RZ33w2RUdQ2JBdTqn6+qNoWoGoT0qk48m5Ea+vnZfmRSP1qpSgIq7Z+zDVzGmhj9obgqu2I5Xu1dacLBnOg+1Oc/CrNmoLVZrt2gDgAG0Edb+PjmXR1MjZenONL2Xq1sNO6X5OgsLsSkoeNHIU3BdD6JpCTYqRztgMAlquJnjXVDhNL0fELUmQBl/RHED4t4LUB/giaKslT+QDwbTMgjoiEqZRVIRhhiwL+t0WGUccCrRvM8MM1o9n1dTl+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATeLMX3dxRVUKof2BymbZoJQsrFredaNT088wsPOhwE=;
 b=SssOUMWZmF8al1UV5Rs4lj17/UDpkEM8BmlUlvkL3V8Xa4nr3LZdruf2od/64eQmWFL/zbzofiO7UHlfoA6MZour/3pvX29tjb0RVGKN/4mwJcQeRcAEm7yBv/74TJKdKYJFzyoLBrRlcqZ1u9fCbKGFDlDz0JxOfcGAU68it4IELmhf44oWYieY9ygDO2RtYwXrztHQTNtbxTmofcpca9DClfwJVDk+QR1qmexdloqEtV/8qTXzORHHncjgmLUAvFM0D+O4zY3ybnjVVPbkjJAfeuE7l8qbbVV9fnn59fvTrGVmxktBVROBBysE7SGQK6wuGfMeZQ2k/65bV5C5Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 PH0PR11MB5593.namprd11.prod.outlook.com (2603:10b6:510:e0::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.16; Fri, 5 Jan 2024 13:31:02 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::89c2:9523:99e2:176a]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::89c2:9523:99e2:176a%6]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 13:31:02 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "M, Saeed" <saeedm@nvidia.com>,
	"leon@kernel.org" <leon@kernel.org>, "Michalik, Michal"
	<michal.michalik@intel.com>, "rrameshbabu@nvidia.com"
	<rrameshbabu@nvidia.com>
Subject: RE: [patch net-next 2/3] net/mlx5: DPLL, Use struct to get values
 from mlx5_dpll_synce_status_get()
Thread-Topic: [patch net-next 2/3] net/mlx5: DPLL, Use struct to get values
 from mlx5_dpll_synce_status_get()
Thread-Index: AQHaPkjbbPhnE8dblk64ivLpGMZURLDLNzjw
Date: Fri, 5 Jan 2024 13:31:02 +0000
Message-ID: <DM6PR11MB46578FE668325CDECCCCD3899B662@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20240103132838.1501801-1-jiri@resnulli.us>
 <20240103132838.1501801-3-jiri@resnulli.us>
In-Reply-To: <20240103132838.1501801-3-jiri@resnulli.us>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|PH0PR11MB5593:EE_
x-ms-office365-filtering-correlation-id: 78ab2a0c-1971-430d-9ee6-08dc0df28f9b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7+3m+pIMPFosm5mryOUoe5DBdq2vmqKD0xoxDBCnQlk7P3j4a9+RmofjVjFo+UfYIyK3PT8sGP3DIIrVCxoDmdOYqMzax44EtvD5TVru0fkR6sEjlM8P1qgYgeYcUubBoiwGYQ5dUcFFcrXntX4zBAuyq+uu6S8nq+KYkpMO2mJZ5kcOjBHCcyE0+tNiJzTcHEP+2ldFlMQ4fHEya2uaoW+rqxpBpvwI7YwKeOwwWL1HV5tQBwHnwOcaBrlEw2J8u6yslNnOD4w/nywKmV2h2bvxCwtKZbe6n0nHCP24kbAoENpz7ZbLHqYeVyHm7X/NmJKNM1sKjW4NmvQQ8fThmSw9fsKjvXvPywyvxnRxpn4TeUHGfAbMmSPjU7RBKcRqs/b9fYnWlKOOyAJ3wI7WyU/G6/uZ30yTEe2vcr+tYJAfUv1IOk846fynajKr4MDXQ83slfFZA8NZmSyrwvql3g3Uwz3QdA1uhIEIrtUkIeF4g+X0loYMZNm4VLic3/gvX7kENmHr+6FjgnxBQ9np3883zE8XZ+qSvPad+CK/x52hGAiuo23I3ohctXizegVNBdU3ExI1IZIDws/0i25LCJGqNYMZWlG8XPSJu+ZPlPcULgL3BHNFypwSycgr+M1K
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(376002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(66446008)(66946007)(66556008)(8676002)(66476007)(82960400001)(8936002)(64756008)(76116006)(316002)(110136005)(54906003)(5660300002)(7416002)(86362001)(2906002)(41300700001)(33656002)(38070700009)(4326008)(52536014)(6506007)(7696005)(55016003)(83380400001)(71200400001)(9686003)(26005)(122000001)(38100700002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MqAIseO093Jgkc6y/1S0tmHOvP7K6YYVlR4fscYl4KtPmntR2JCuSzinuj92?=
 =?us-ascii?Q?5igBRjelLfSykBKoUZ2Rn5QpcWYP3okweSyL7ERksZb+3kSCKh0N27BwA6km?=
 =?us-ascii?Q?SYINoLdbMcxJLoALipY819z2L5GibCuozzbRmkYVkAXOtOFvNsGWkuZpgW5Y?=
 =?us-ascii?Q?9B/M+RK2CYgLVoq6NzkjjJKfgtw/3wzweNwwk7P+aoiEHBfX1PHv54qY6M2o?=
 =?us-ascii?Q?1nSiHQCgCOa9qodKfW1bBtyoPZM2p/WZ/W3XB78I+1T2OHaFcfrECHUP9byL?=
 =?us-ascii?Q?GfqfugGHHKX3nyoBuv/6RUS720ySmzUAxbnzwgD9rppp4n61AJwBzrqUFgW4?=
 =?us-ascii?Q?AQmVmioP9swRAatTOnItYhtgOsxLjwzqJyDAnez32tut4ip59d74oc00WH2A?=
 =?us-ascii?Q?e+MAJZsMzZeUtYQef5OATao7ZTx0rimcEIjb1XjCNDyQ2ZHA4LXjOmTcYOao?=
 =?us-ascii?Q?T9FG5Xlh15uRfak7979rndhBu/0F70Xlzk3FY9GbNKT22mwhXXxUKB9eSFAd?=
 =?us-ascii?Q?V45v7aQne0BuDNWBQfXleAlfjDFrYLQA6GFY2/O2iCIFb0N4OeF9DBQgQBhn?=
 =?us-ascii?Q?fUFg8w4AK7drosqNGFTlBiUnUC6cosfWPg2SVUFP4KcKB7wkE10Jps83NciL?=
 =?us-ascii?Q?RA/xeIxWCyfrKYHlGMLG+ImyhJJmaKf53WgoWIDw9hliyJ5P1M1+iXAszEst?=
 =?us-ascii?Q?5SI69MQ1eZJV+zSEVHM7lY3UpHLBFmvihMvk6ccf1u6I5IVIqrDqbQAsZdwM?=
 =?us-ascii?Q?8VJS0oc2E21QHbk+dSSFG2PL2HzJFAY97aSwLb6ozYEkK5bqFynFfqp7djr7?=
 =?us-ascii?Q?BmvEhjvl6NiRE80bhvtLUdk8vMqnHoNdpEetJPlHnnfr11SnIXbxgSBt5zrN?=
 =?us-ascii?Q?poqB2UOmIzRpx+iSOE1Q6oA/dOnZ8LqG9HNePIQc5Ka0Iznwb+N2KPaexnYV?=
 =?us-ascii?Q?bR7Ji9CfsYX22n6VdsA3JmLPDSuLgPVXH6TmNS1+OK7ndWRhdAj1kHLzaU8C?=
 =?us-ascii?Q?x32/PqcQIlIdF4NXugCGhxPCfOpBjw4tjrbhic1OixkU4dLMu4XYCfzUYzvr?=
 =?us-ascii?Q?hECtRCD0JpjfIgFc8oLFJcVgKmLOpZ4L2mnmOonLqN7W5hko7d9yp6GRtS4t?=
 =?us-ascii?Q?oEkMQ5SC8PAqr5g3Tk4yyOJ8r7LrAeSt3fNCa/7OT6WKOr4n8/Z3KfLwSwLd?=
 =?us-ascii?Q?aSjkoTOGsAjqe2B98NV1Ct30AoOyLfFmGnDaN+cAfaQwW24xrCVhp+2afCrd?=
 =?us-ascii?Q?7k9OIsz9LwGRUK4KrDY0K3zcCqFbpn+3uCvByXYELtCjYSI0omHONKXo6lMJ?=
 =?us-ascii?Q?4/tD7TDi7I/v9XNJBH1FjAqPL6Tvt5rakfTcB6L1R2sM5PzxnGZWCMMSKaHV?=
 =?us-ascii?Q?uQ9gpYY308bOnC4ZfJr/bdSbYawKwmC7uUu0+dKQcYjQQ4vbYDGGKVIxmjfk?=
 =?us-ascii?Q?z5HVUn7p5vnuUHj6ivRBj16h1wGi27m0KiTPjIjBUfCdIvSbZ1p/1jnM4E0c?=
 =?us-ascii?Q?O+AqYDyyarYjOP+I+bHcadQSStizF157F11YSBP0Y0TtSH+ssgQhzdGzjuAv?=
 =?us-ascii?Q?Rxd261ZG86d+0D6c+mkv/dLnplyDPhik+uX5gVSgwO0BvvMu8T9/jZYhTG+N?=
 =?us-ascii?Q?0Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ab2a0c-1971-430d-9ee6-08dc0df28f9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2024 13:31:02.2286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RS3eOkbH4q/AubYgJXjEdbrVNSoZANfFdgQ0AeTNRfneBkiZCYj2joWSyn3mimSBHsRzkF+yZrP++njdys3dafI3Jyw3Ok+c+PvMBRUj59o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5593
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Wednesday, January 3, 2024 2:29 PM
>
>From: Jiri Pirko <jiri@nvidia.com>
>
>Instead of passing separate args, introduce
>struct mlx5_dpll_synce_status to hold the values obtained by
>mlx5_dpll_synce_status_get().
>
>Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>---
> .../net/ethernet/mellanox/mlx5/core/dpll.c    | 63 +++++++++----------
> 1 file changed, 28 insertions(+), 35 deletions(-)
>
>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>index a7ffd61fe248..dbe09d2f2069 100644
>--- a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>@@ -36,11 +36,15 @@ static int mlx5_dpll_clock_id_get(struct mlx5_core_dev
>*mdev, u64 *clock_id)
> 	return 0;
> }
>
>+struct mlx5_dpll_synce_status {
>+	enum mlx5_msees_admin_status admin_status;
>+	enum mlx5_msees_oper_status oper_status;
>+	bool ho_acq;
>+};
>+
> static int
> mlx5_dpll_synce_status_get(struct mlx5_core_dev *mdev,
>-			   enum mlx5_msees_admin_status *admin_status,
>-			   enum mlx5_msees_oper_status *oper_status,
>-			   bool *ho_acq)
>+			   struct mlx5_dpll_synce_status *synce_status)
> {
> 	u32 out[MLX5_ST_SZ_DW(msees_reg)] =3D {};
> 	u32 in[MLX5_ST_SZ_DW(msees_reg)] =3D {};
>@@ -50,11 +54,9 @@ mlx5_dpll_synce_status_get(struct mlx5_core_dev *mdev,
> 				   MLX5_REG_MSEES, 0, 0);
> 	if (err)
> 		return err;
>-	if (admin_status)
>-		*admin_status =3D MLX5_GET(msees_reg, out, admin_status);
>-	*oper_status =3D MLX5_GET(msees_reg, out, oper_status);
>-	if (ho_acq)
>-		*ho_acq =3D MLX5_GET(msees_reg, out, ho_acq);
>+	synce_status->admin_status =3D MLX5_GET(msees_reg, out, admin_status);
>+	synce_status->oper_status =3D MLX5_GET(msees_reg, out, oper_status);
>+	synce_status->ho_acq =3D MLX5_GET(msees_reg, out, ho_acq);
> 	return 0;
> }
>
>@@ -74,14 +76,14 @@ mlx5_dpll_synce_status_set(struct mlx5_core_dev *mdev,
> }
>
> static enum dpll_lock_status
>-mlx5_dpll_lock_status_get(enum mlx5_msees_oper_status oper_status, bool
>ho_acq)
>+mlx5_dpll_lock_status_get(struct mlx5_dpll_synce_status *synce_status)
> {
>-	switch (oper_status) {
>+	switch (synce_status->oper_status) {
> 	case MLX5_MSEES_OPER_STATUS_SELF_TRACK:
> 		fallthrough;
> 	case MLX5_MSEES_OPER_STATUS_OTHER_TRACK:
>-		return ho_acq ? DPLL_LOCK_STATUS_LOCKED_HO_ACQ :
>-				DPLL_LOCK_STATUS_LOCKED;
>+		return synce_status->ho_acq ? DPLL_LOCK_STATUS_LOCKED_HO_ACQ :
>+					      DPLL_LOCK_STATUS_LOCKED;
> 	case MLX5_MSEES_OPER_STATUS_HOLDOVER:
> 		fallthrough;
> 	case MLX5_MSEES_OPER_STATUS_FAIL_HOLDOVER:
>@@ -92,12 +94,11 @@ mlx5_dpll_lock_status_get(enum mlx5_msees_oper_status
>oper_status, bool ho_acq)
> }
>
> static enum dpll_pin_state
>-mlx5_dpll_pin_state_get(enum mlx5_msees_admin_status admin_status,
>-			enum mlx5_msees_oper_status oper_status)
>+mlx5_dpll_pin_state_get(struct mlx5_dpll_synce_status *synce_status)
> {
>-	return (admin_status =3D=3D MLX5_MSEES_ADMIN_STATUS_TRACK &&
>-		(oper_status =3D=3D MLX5_MSEES_OPER_STATUS_SELF_TRACK ||
>-		 oper_status =3D=3D MLX5_MSEES_OPER_STATUS_OTHER_TRACK)) ?
>+	return (synce_status->admin_status =3D=3D MLX5_MSEES_ADMIN_STATUS_TRACK
>&&
>+		(synce_status->oper_status =3D=3D MLX5_MSEES_OPER_STATUS_SELF_TRACK
>||
>+		 synce_status->oper_status =3D=3D
>MLX5_MSEES_OPER_STATUS_OTHER_TRACK)) ?
> 	       DPLL_PIN_STATE_CONNECTED : DPLL_PIN_STATE_DISCONNECTED;
> }
>
>@@ -106,17 +107,14 @@ static int mlx5_dpll_device_lock_status_get(const
>struct dpll_device *dpll,
> 					    enum dpll_lock_status *status,
> 					    struct netlink_ext_ack *extack)
> {
>-	enum mlx5_msees_oper_status oper_status;
>+	struct mlx5_dpll_synce_status synce_status;
> 	struct mlx5_dpll *mdpll =3D priv;
>-	bool ho_acq;
> 	int err;
>
>-	err =3D mlx5_dpll_synce_status_get(mdpll->mdev, NULL,
>-					 &oper_status, &ho_acq);
>+	err =3D mlx5_dpll_synce_status_get(mdpll->mdev, &synce_status);
> 	if (err)
> 		return err;
>-
>-	*status =3D mlx5_dpll_lock_status_get(oper_status, ho_acq);
>+	*status =3D mlx5_dpll_lock_status_get(&synce_status);
> 	return 0;
> }
>
>@@ -151,16 +149,14 @@ static int mlx5_dpll_state_on_dpll_get(const struct
>dpll_pin *pin,
> 				       enum dpll_pin_state *state,
> 				       struct netlink_ext_ack *extack)
> {
>-	enum mlx5_msees_admin_status admin_status;
>-	enum mlx5_msees_oper_status oper_status;
>+	struct mlx5_dpll_synce_status synce_status;
> 	struct mlx5_dpll *mdpll =3D pin_priv;
> 	int err;
>
>-	err =3D mlx5_dpll_synce_status_get(mdpll->mdev, &admin_status,
>-					 &oper_status, NULL);
>+	err =3D mlx5_dpll_synce_status_get(mdpll->mdev, &synce_status);
> 	if (err)
> 		return err;
>-	*state =3D mlx5_dpll_pin_state_get(admin_status, oper_status);
>+	*state =3D mlx5_dpll_pin_state_get(&synce_status);
> 	return 0;
> }
>
>@@ -202,19 +198,16 @@ static void mlx5_dpll_periodic_work(struct
>work_struct *work)
> {
> 	struct mlx5_dpll *mdpll =3D container_of(work, struct mlx5_dpll,
> 					       work.work);
>-	enum mlx5_msees_admin_status admin_status;
>-	enum mlx5_msees_oper_status oper_status;
>+	struct mlx5_dpll_synce_status synce_status;
> 	enum dpll_lock_status lock_status;
> 	enum dpll_pin_state pin_state;
>-	bool ho_acq;
> 	int err;
>
>-	err =3D mlx5_dpll_synce_status_get(mdpll->mdev, &admin_status,
>-					 &oper_status, &ho_acq);
>+	err =3D mlx5_dpll_synce_status_get(mdpll->mdev, &synce_status);
> 	if (err)
> 		goto err_out;
>-	lock_status =3D mlx5_dpll_lock_status_get(oper_status, ho_acq);
>-	pin_state =3D mlx5_dpll_pin_state_get(admin_status, oper_status);
>+	lock_status =3D mlx5_dpll_lock_status_get(&synce_status);
>+	pin_state =3D mlx5_dpll_pin_state_get(&synce_status);
>
> 	if (!mdpll->last.valid)
> 		goto invalid_out;
>--
>2.43.0

Hi Jiri,

Looks good to me.

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

