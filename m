Return-Path: <netdev+bounces-95288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A05C8C1D1A
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 05:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EE30283FE5
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 03:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AAE149C43;
	Fri, 10 May 2024 03:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oYESQRw1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC851494C6
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 03:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715312262; cv=fail; b=LJlWmDItWbYyKuK9aU6HGvCFOAGrSszOal2REwIcidAFsunxiqEzeEb8tN9OiUaoEI49J9lXrmQ6uSjEjiBxy84A/zT1Xc6RwQuGmFcZYDKW8agkTwonwOXga+Ry/5lNeb8Tk5Jl/2RmUflIUOr64+r0dULE71rYtPIZclQNEVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715312262; c=relaxed/simple;
	bh=0NjWo6pKI9rTDgCIYpuf8djRja7ZV/4i0ZN6FWV2VtI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RChNJMIRgsXgr2kXe8FX6eLq9bLi0jHbJOFbqAoPbutk6IWvZchabmOO7qe+/aeScS7rezqBoiMcXYZKZuVDBJWI8bS/EsDAaG/TnlLFehgWNPGfQBZtk4W0StKx3CDYIA8Xgmy43RovYVYQ20H560NrSf1gCDrsoja+yWF7pkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oYESQRw1; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTpANrLweXZjw9PgwqLsnR5xJ2Bcqw9tX7ZPh+yzTCa4El5JGyPN6YKJ3dC/uAzDY+ao/+1exm4t/87FJXiIBgGJvl0S6vre9+36kPIy6M2MvcLsbPA6/IkbFALUlV0dHyOxExxHi3vf0QKvNlcrRzIU1OIT3eVEyn9bgoBZx+jlyzBXJgAziyab4/5KutCUieatg0awvPNPABd+WO5Vhc/0sG4hT94cgABmNqiTkcBvZCPkrf64mWCUqzQFDRDjMLg0zc6lb110hVRa5Mbp4z4HqYRZANlBZi2tHaEKjPDT2Zi5bbRRj+/P/LbPMFBN9CdDl2pktyGa0fxiRET6Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJWRVeba7lMuSGrAn7z1WqbWWvaIbOpIHp7683xKuQY=;
 b=Jm75m2tC03RLTz0Vo6DSccBXRU9kbk01rMolBCzWeIl0p8NQnNYGlzbT5cUOHmBbkZeYEzM5tJOYE32nV70ATg5oJSHHOjOz3mokhz0dznBTnB7YDpsmW7lAIY341EcbE0lDpjh/ITq/hSDdLvWqYawscCtC9cpRDAUHdEx3YtXWlcQ6bc23FifMUkRUyiV5i6OnFQJ9s3GJWlkCUpfeedfLLFkHZt/GTtq1J0VRg0hJITkquBbfIBLTxVU5vhh1oTfWCcrillCR5jVtk1AQo3SAcCgyg65DNwuKRPKGl/FY6aBPmHSihOtE0HDMMoGKPGjeG1YcHZM1vQZUIH8naw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJWRVeba7lMuSGrAn7z1WqbWWvaIbOpIHp7683xKuQY=;
 b=oYESQRw1l1KRPscTveGvEOwx2rXJ6mucgwgFzzeblGdmDEyoGDfQobTVR2/oaElcFJrbffW0YD4qpLulbP6gWlXwoIG2DRkN84w9hS+yHJUo+7XEkn8n8PKF/xGrKNqQe87cItVgC1YN7CVls01UWwUYugOScTI7FEHHypgpgjsWFUP3tlH948a1n9DVhnbbEOFiDvAPaDZicB9rgmGcFmAhcC7ATbk+RuN1DMpVRVyTNMUC6I2VpznrChZ7f0tPLbrdCNLu/knZWDnPFUyouNq+GnastPCXCzGihe66zDlgnukpoJhMy5vriSe9+RQd8bhtw4pM8fjw6EyAB+2VMQ==
Received: from CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6)
 by DS0PR12MB7803.namprd12.prod.outlook.com (2603:10b6:8:144::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Fri, 10 May
 2024 03:37:36 +0000
Received: from CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::ff67:b47c:7721:3cd4]) by CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::ff67:b47c:7721:3cd4%4]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 03:37:36 +0000
From: Dan Jurgens <danielj@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mst@redhat.com"
	<mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>, Jiri Pirko
	<jiri@nvidia.com>
Subject: RE: [PATCH net-next 1/2] netdev: Add queue stats for TX stop and wake
Thread-Topic: [PATCH net-next 1/2] netdev: Add queue stats for TX stop and
 wake
Thread-Index: AQHaoi6KsnE7s0ArT0mYwn0pQXyMcLGPrxIAgAAjGwA=
Date: Fri, 10 May 2024 03:37:36 +0000
Message-ID:
 <CH0PR12MB85804814960D30BAD5FE5EF5C9E72@CH0PR12MB8580.namprd12.prod.outlook.com>
References: <20240509163216.108665-1-danielj@nvidia.com>
	<20240509163216.108665-2-danielj@nvidia.com>
 <20240509183102.7c337c2c@kernel.org>
In-Reply-To: <20240509183102.7c337c2c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB8580:EE_|DS0PR12MB7803:EE_
x-ms-office365-filtering-correlation-id: be1f69cf-de27-4ae6-ea15-08dc70a28901
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?MH/4JmXfLo6Hi5SJeSzepeW7ziWs/Vb6gB1EhhVj4IdMNa/yuG4/2fIhZhVA?=
 =?us-ascii?Q?1+ncDJys1uYfVu5H3JngqVmpVPZG/D+EJwIq3w2HKRRy+yQm3ozneW5pkb65?=
 =?us-ascii?Q?0dAnh7O1kVRIGLnx44EY+4KbL/bvgx/echQLB0gHc+PmCyC13dtln8hBOHqM?=
 =?us-ascii?Q?IrYeFWICzftzRwkWPSTUIlVJbwkzSJprdCQUjRjiTJdk8j+z24WhdJ8HZUxA?=
 =?us-ascii?Q?urgciSdYSGgZ0s+1qeiS3nf4XUGt9z8E82/JRE/q0TAe6aa9AVdm3Pews6vu?=
 =?us-ascii?Q?FF06cT/FF7LnTbN4UAzPA7NN1wGTe4PhBww2i0PtxzhwQg+7jsjbeQtxs3kP?=
 =?us-ascii?Q?zbq1vKpNPqkeUIsmTfoyocz+MhsUCdcDItOgU2XbHjgQBDz2t++WDk3+w41u?=
 =?us-ascii?Q?h7OiRoJaAQAcfi/2IHsc3k3zIpow1Cw0P2PgzCVEIhmVKYT3vwcGvcfVp77E?=
 =?us-ascii?Q?8jMs/YnRimJrXTbg7TV9wVGnvynsl4bXQyMKRFEvKNF+eZ5B7brzXeqy7WLF?=
 =?us-ascii?Q?6tL5Tg4SYRaQmdTgTtrxzLfIsM8eVfQh2HdfVneYGprwoJcaPBLYg8241SsK?=
 =?us-ascii?Q?8brQ4PP/6MFkNFLV5jF3NqJ583C7CXlvQZ5PeGhb8ofHrcH7hF0gKjhSZrZ3?=
 =?us-ascii?Q?sQU+rn+phPkKlNW7BNdWASeqVKwH0asKJVWqCD5dlF7D+cmFuPlZWbqjiKJV?=
 =?us-ascii?Q?vrPdngK4vwYeJ01fK2nSNUbME2qPuKBIepZIAEhOv7EQyINN9/1nTvr8KGvo?=
 =?us-ascii?Q?cOCXdO/N3KaumZi1Bkx5Ff/XS42l41xEy1VWvJIsdv/jfkRVGTKw9ceuYiMc?=
 =?us-ascii?Q?LRl36jMvCnwpDLKNQhVgfhj6M3Kxu7VYt3gy7LHwCs4nv0BTSgIo3d+Pko1c?=
 =?us-ascii?Q?b9W37Pksk3z3TPTFT1DRUbyBuRtY0XWBlsaCjOktzXsGVVshGc5+BstAugtn?=
 =?us-ascii?Q?JlpFs3zTsMSL3C1p+Z+L6yNir9SRSZJwaWYTdHzB8eoEQ8D55gNBs3qNGJT7?=
 =?us-ascii?Q?5BxrdcBxQ/5DmBxpIsFfXLGuP7XB/vKKk8vpNwZyaP37pyfZxSO9/Sh9tJIv?=
 =?us-ascii?Q?uAvs4scLx2ZbsBwdJKVPkrdom1KTKn15+U8o00NHE5OxM1ivd51K0MQhw5Fu?=
 =?us-ascii?Q?N0DJGu7nDBU+8HX0QZFAaLAUiaq1aJXN7qCPKPnKnUEnrFspav3O4Vm54N7s?=
 =?us-ascii?Q?WihUW2DjH0WFPr6GOmXEYlHjrIB0hvPWTVLj8ds00m5jy+KOslPQ/b/6Ph/2?=
 =?us-ascii?Q?lBu9i1taAnjPs9vHApz2jvpoJhhJ5Ig3qzxB8IKAvjiZE/nUzDTAusUWffx6?=
 =?us-ascii?Q?hqtBPfIBDZpBDh9kDFo7pOQSe/7mbFrLB4EY6xrc1zN1Vg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB8580.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Gi+uOdJgZPQww2wzVyOiY6+jt+ZaVz99DMigSCCg7rwI0c9XAy3EZx71fodV?=
 =?us-ascii?Q?hkbqyY9IXtXfIKj2li4BdBO4etfCCO5ziL7SYFJIKgoRGWMknsqZyga3I2pE?=
 =?us-ascii?Q?OcexjDDCAIzN0MbKWB1fRBncHGxBE5zm7uo9GMaqd11qrV5681sMmrSrREyc?=
 =?us-ascii?Q?1drik8KdOsBixgtIK/+F1iaBzkbpgxdldFHTWkE1Q1S6Rs7dZVA+AztDxMf8?=
 =?us-ascii?Q?qE3+4Kivwtku9gteMkppAe27mZ1sv5ZMgZZtY4TGCbukshbmGYvvCyts1nHm?=
 =?us-ascii?Q?glSqFJ0jZToj3Lopi/HDy1/ti+gzqr3r6ljwHwnIYmw5gSnvsEsSIgkj5J0q?=
 =?us-ascii?Q?CB28c4NQxrT48iJTt7oVyX9JEsG0+5MY/+EHjAgmYjoWF8w5ftNbN2MuAMOz?=
 =?us-ascii?Q?suS/ZymMfoSeI6EB0v0ywp+SC6ArHjKcZ4WQx4/wlZInMbsA7bA4+jtbk7MP?=
 =?us-ascii?Q?dQLQkKA/1HovZ5t/Pxy9HrKYM9r5tKWvKSsemwLq9I5ixe9M63w92cLpLTV5?=
 =?us-ascii?Q?OVACz3iaaf2vb7uimIrvWZPgf1PPIbFRexEYkdj8+4I1bR1PoS47aWg5SddP?=
 =?us-ascii?Q?HZbJDvzcFS1PUr+1KLbA0XVchy2L26WuaSyj3fr3ZWT2L+TTnEsqNKyziMP5?=
 =?us-ascii?Q?OcPI4jt0wnd+EwBM1Dvb3ydGSlX4j41PW1LUpTWiM0LbeWcT0oDZ+UYOJ8Os?=
 =?us-ascii?Q?7/UN2q4AYUixABfPmS/qahPmBKgFnqdNHSp8r8oOEmWviCxsGilCY2bcg6Ks?=
 =?us-ascii?Q?WwTREJpnsInpQeBmrSoC/UAnz6mF1DGqXEvqYIUyRee5p60j5eWzU4el7V3V?=
 =?us-ascii?Q?8aAoziecDyXtLpek1c63dCepqkMyxtctfYhcDQXYMDxcNFmmYNipmAHbMOpK?=
 =?us-ascii?Q?RCMCPc2EFOb5InFMBgHB5lxZNK+A+N2/RBYl6iey+GlIgq9zKQkQNOwNAsQD?=
 =?us-ascii?Q?w/YKB1CyFhBNFjueJGKSxZvuueXP21iXujQamibBHn+kLLbMVdhAU2xBVXtT?=
 =?us-ascii?Q?nj+NmbBU710+ikwNR0AUZBZ9MJQSZ/779Rtf/8+6NCK53z+1PxEPqfxkfkt7?=
 =?us-ascii?Q?pCUASiCsiAAYyy9+Z/slg45QWoTyte2v8cQUh0kx71EGKnTzrmG7IoepXF3j?=
 =?us-ascii?Q?qZOvKkzVZoCSNAW0J2ZemYk4YI3HucoboUdgPP4CGoJhYa11VU5GKP6C7yuT?=
 =?us-ascii?Q?8hfPev7FN+ADR5WStKfb+Wbfe+7Lq6DW8cmOKNDwk/Ft/RnwukE2PSyIRRkF?=
 =?us-ascii?Q?T0GS0GwokS5WQaXJcIVlY556HSJT3/eiBINItFTM30UgAtrxkxsNjfHWjc88?=
 =?us-ascii?Q?/ZqMF3dfE3AuGzaMx9YDOgbxn4EgTS7ccftdATA3m8yF185+nnrbn1fI2EzM?=
 =?us-ascii?Q?ugFtc++sL/igtDy7OtjLgJUmbZP3JJOYiUcIfIMcK0FL2Pi/668Bz/kZJlX8?=
 =?us-ascii?Q?8wQt1C75fO63BVG9quEtDfYwgiOfuH5RgqaxLqKNFkgvSFWSl53W1vpaZ99j?=
 =?us-ascii?Q?K8x0JWoudkKnU5OUgChwD2Q1dlpUqB0vLifufSNY7U9tIx43J+QsQnmi+XDx?=
 =?us-ascii?Q?M6vQ16cRqj8I8BuPW2o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8580.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be1f69cf-de27-4ae6-ea15-08dc70a28901
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 03:37:36.4866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ExnQ8paOLVTLxG1mSXo4nXfQ8jFFsIbjJQSsGZIlblMCm/HXr+zf1KcUFq+TFUq/bwAMT1TDshE/POqAG1+EWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7803

> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Thursday, May 9, 2024 8:31 PM
> To: Dan Jurgens <danielj@nvidia.com>
> Cc: netdev@vger.kernel.org; mst@redhat.com; jasowang@redhat.com;
> xuanzhuo@linux.alibaba.com; virtualization@lists.linux.dev;
> davem@davemloft.net; edumazet@google.com; pabeni@redhat.com; Jiri
> Pirko <jiri@nvidia.com>
> Subject: Re: [PATCH net-next 1/2] netdev: Add queue stats for TX stop and
> wake
>=20
> On Thu, 9 May 2024 11:32:15 -0500 Daniel Jurgens wrote:
> > diff --git a/tools/include/uapi/linux/netdev.h
> > b/tools/include/uapi/linux/netdev.h
> > index cf24f1d9adf8..ccf6976b1693 100644
> > --- a/tools/include/uapi/linux/netdev.h
> > +++ b/tools/include/uapi/linux/netdev.h
> > @@ -164,7 +164,8 @@ enum {
> >  	NETDEV_A_QSTATS_TX_HW_GSO_BYTES,
> >  	NETDEV_A_QSTATS_TX_HW_GSO_WIRE_PACKETS,
> >  	NETDEV_A_QSTATS_TX_HW_GSO_WIRE_BYTES,
> > -	NETDEV_A_QSTATS_TX_HW_DROP_RATELIMITS,
>=20
> Looks like an accidental removal?

Yes, thanks.

>=20
> > +	NETDEV_A_QSTATS_TX_STOP,
> > +	NETDEV_A_QSTATS_TX_WAKE,
>=20
> Since you'll have to respin let me nit pick on the docs, as I'm hoping th=
at
> those will be comprehensible to users not only devs.
>=20
> > +        name: tx-stop
> > +        doc: |
> > +          Number of times the tx queue was stopped.
>=20
> How about:
>=20
> 	Number of times driver paused accepting new tx packets
> 	from the stack to this queue, because the queue was full.
> 	Note that if BQL is supported and enabled on the device
> 	the networking stack will avoid queuing a lot of data at once.
>=20
> > +        name: tx-wake
> > +        doc: |
> > +          Number of times the tx queue was restarted.
>=20
> 	Number of times driver re-started accepting send
> 	requests to this queue from the stack.

Will update it. Thanks for the text!

