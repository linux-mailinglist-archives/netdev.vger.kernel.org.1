Return-Path: <netdev+bounces-49171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142287F101E
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 11:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B70CA2820EC
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 10:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBA112B93;
	Mon, 20 Nov 2023 10:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="nqDhIJxG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2119.outbound.protection.outlook.com [40.107.243.119])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609E0CD
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 02:18:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwjYpvw9TE1olEhYI1mQG+MLd98ZLX1G9W3jkc9qnzj4bMfkvw9zaT/Cx5QV0Haj4ehM7K2LtOHiNZJVahVTDATyzbjDG5OmjQWtFWmQiMDjW51lUxc2HjoLr5b/eiiG7iXGWAA2DUycurF1QcYHUU3uFFtzYSotQVNa9HG3s7K28LPxEkdF+qYdUlKb7g8Ce6mljmO2ON/IKf32MIlYLbsGT+kpjsHxHwun+/BHRnhl+Af+kt2WF544fRtGqrgnbEeazyt+clNZqbQHvix6IrvDomX8bxhqXIXLLHWFMWqx3IQ4XRtP33FXqeHgXef3UHOlGq7S+OhPNTRI4I1/Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beBf92xLiI9J7qhkMzsCihuNk/3E3GRYWUaBOVvdh7k=;
 b=mNmjC56zWzjCWywYxLkDFAvtWraqUgSPO1D5CCvD8NF5fQBBo1yPlPqqjSaqIbCb/09FpBIB5OXkrDw3f0kftIoFN3Z6h+DqKY/GgYY/OAsJNZy9GxwHu7wZu25E3RVEs5dXzO/IiUeF09OYJhzuwxZiAr3Fhjq/LAwb7gRtwwf9DMst2Hrlom9siBLirbkboc8PCujT7TYiWVF3ENgHHVOVMNHARsCVoOM+do6ogXunnFlT2tOm8LFkMGkS1Rl3KPpJY2qBEDUdOhp4p2We2VgSluXdCbd/YhT+V4Vq4xf5YWAuhRVFa53kkv+ZtXdsh+NOXssFpZx5jo6AUraHzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beBf92xLiI9J7qhkMzsCihuNk/3E3GRYWUaBOVvdh7k=;
 b=nqDhIJxG8BvnITpMuETSkPpRDUg/HTspPozyn0+YozSKLGycX9qu9Zx2vaUbd92PQ1UZj5BSPA0J6IrF8MSGtFZ87bw4wkjVpYGy9K9HmoEsmHDsPf/vhFTFjVuy6nGDxQi/rWfaKpN7F5q/infZEYh9+irS8lx+Hpq0OW7ST1s=
Received: from DM6PR13MB3705.namprd13.prod.outlook.com (2603:10b6:5:24c::16)
 by PH7PR13MB5430.namprd13.prod.outlook.com (2603:10b6:510:130::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Mon, 20 Nov
 2023 10:18:13 +0000
Received: from DM6PR13MB3705.namprd13.prod.outlook.com
 ([fe80::91e8:b139:26e3:f374]) by DM6PR13MB3705.namprd13.prod.outlook.com
 ([fe80::91e8:b139:26e3:f374%3]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 10:18:13 +0000
From: Yinjun Zhang <yinjun.zhang@corigine.com>
To: Simon Horman <horms@kernel.org>, Louis Peens <louis.peens@corigine.com>
CC: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, oss-drivers <oss-drivers@corigine.com>
Subject: RE: [PATCH net-next 1/2] nfp: add ethtool flow steering callbacks
Thread-Topic: [PATCH net-next 1/2] nfp: add ethtool flow steering callbacks
Thread-Index: AQHaGSVSgoIuFgLVz06Ga+NwrxlccLCC+bSAgAAHo8A=
Date: Mon, 20 Nov 2023 10:18:13 +0000
Message-ID:
 <DM6PR13MB3705D3EAE5FEF8D3B6902146FCB4A@DM6PR13MB3705.namprd13.prod.outlook.com>
References: <20231117071114.10667-1-louis.peens@corigine.com>
 <20231117071114.10667-2-louis.peens@corigine.com>
 <20231120094321.GK186930@vergenet.net>
In-Reply-To: <20231120094321.GK186930@vergenet.net>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR13MB3705:EE_|PH7PR13MB5430:EE_
x-ms-office365-filtering-correlation-id: e6550237-6169-4a60-c5bd-08dbe9b20105
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 2rY9c9mOM0vGLnpJvCdRqqqkhwFfU4IAXJ59fKpoK1uk+lkxNAXVsWZo2OSBrs+oCr88E351seuhmUYNF3seviKGXzMB6BQx0xmHLzFQ5zkbKKO/hFXzqp7FI0Ay8tOdsC20BoTGgq9Wc98KZUTJfCOltPWdrL31voowwXX5lX8paOZYNm/vrEZ4YIZdgGGcZn/20/n3uNW2cjp+tSKbUTgHH2qODRAKRWNhA72d587e0jy51obVdzffm5UWZQWrXWsq1zy2lzVgPE0ZdhUsQhcyyCd11k9JnCrwbMWU0mmCMbvKIDwftr3vO8a21w5/4AoqBBFL/cQYmghd9YoVAy+armHZOGjQBzGvYZGBppuMq27102IvUhFyFJAxn3oSgMKO8hdmBL2AXIQl0KolquKGkeqs/Zj5pD96i8ZbPQYo5vEP6tK3dYnmeRdWhsZDV+bE5QgJEhcphGoLkTX6LjaA/wuZnpjWZZvfeKqesoatuCLm+Dk9YSWxY8fLai7vuSZHDwL3fHrtmcVkXBeCZoFayu25XBFkWSvLzFOJ4m/GaE6WeXfWZZ5n9u0U/huGk+9mpYs9VycISRfubHWe/m154FK4uuRH4UO3WpQrHDHxe7DAxY7926R+K1VKrkXmSTXdAU5BrHBDNJh5NuLLaSq+wp5rpxbG79wzoRt/HO8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3705.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39830400003)(346002)(396003)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(38070700009)(86362001)(55016003)(71200400001)(110136005)(7696005)(6506007)(76116006)(66446008)(64756008)(66476007)(6636002)(66556008)(54906003)(66946007)(33656002)(122000001)(107886003)(53546011)(9686003)(26005)(2906002)(41300700001)(478600001)(316002)(44832011)(5660300002)(38100700002)(8936002)(52536014)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?L7K6sGo16odhyi7zlw+iqLsBZ/1JhOUaR0BVmMtgYluuL8pZwYxOThBwy60P?=
 =?us-ascii?Q?vo3kdtDysECJ5xMHm2PMlmqSBzWbyjMu6KBk6dJFP7ftCo6xeapjrIc6b+oC?=
 =?us-ascii?Q?ZGaUzQS3kv1k4QFB52pqcBR0m96SH3x7m3ZzEwcSEpG3IsxHfgC6EOaMsXjo?=
 =?us-ascii?Q?VKO4CPItuo7ZBG59JpJWdy1Uok2z6X2MFUy9VJ4KZEUrqNIq8s7QTSS4rxtb?=
 =?us-ascii?Q?woV6GEh2eVe9uP8GOg70LnVJDou1Xk6J47RTEG3UM6W1fUnkgrXrmvsMEbT4?=
 =?us-ascii?Q?0TDKW+o7BxWP4d9JkNawqGuEROOIe1cn4E9fWvt520pQ+xWeqKL9BD9Tp5dA?=
 =?us-ascii?Q?X3eI4U8DYar8elFvewVDo9jI3WPQkadgt97dtqW2eIBoyz+hBfw9+zUOocsz?=
 =?us-ascii?Q?gWTKaBusqFoWPb4eGrSZdGt8o2wT6YbIEOEThTPnHBHAG+Nk99v4N5KdMOMf?=
 =?us-ascii?Q?HsBDAJsfZYEQlHDA/pIAttX4yvOdJ1uVhnkHxczAV/x7P16FKR44S1CZmAIm?=
 =?us-ascii?Q?J9dflfH+2ilAls+Tud1mOHLFL9h4uQlkaodSbzM4snRno2QLFRgEA3yRx20q?=
 =?us-ascii?Q?Bipo1YPJPmrNFzG18o4Rso+ANmo6azd6nioWDIUpqJYwyiPyd1RNBl+WklPB?=
 =?us-ascii?Q?gIg87fkEWCY37gd7YOD+GpnDDaayWZ+qjgcj+E8EpNdnMXlaFiQCw4OMkILL?=
 =?us-ascii?Q?n5i7b4ObxqXxCrZ2uHGYDOHhSicHE+kiOJwuFCdDiy/eJKhLxJzwIp9SaYex?=
 =?us-ascii?Q?wAY0sHSgp45W2LnCo2K/wUR3jKKAIYTxQgQDqOLYbhlYU2uYm3ltwHLFXZkc?=
 =?us-ascii?Q?lnuueqUrmxU7DORj6+c5F+kPiP9dO7xXMjF7mTToe2M9zDUUJ2u7BQpzAti4?=
 =?us-ascii?Q?ITCmzIuPv9AbsEjxvDudr82vMMW89kBgcbUpvgrJxkGXKx2Hd4Ns8iVMApk6?=
 =?us-ascii?Q?kIB0Y2D7ql6YcyS5p1x7d4cidtJJz8Vf3JBbg2iZsf+u+aY4HSP1Uj++a+Ls?=
 =?us-ascii?Q?gXIPpEvMc7Cno/2ZJRDruixmIVQk1BDfsxMEwKidc1/9unGrwuTbthsFAfLS?=
 =?us-ascii?Q?/5UiV5tpUjxCjjRpLY5SrrdBLwEac4AdgmvfV3z/jgDms4daXJzjajzli7Xf?=
 =?us-ascii?Q?uSii/X4kux5iV+/Y1ePcPcuQzqQf70tdpPe/Up0UHz+PzDWF6yNhbHEDFNZu?=
 =?us-ascii?Q?kf4E3JLgxTeWC3aeSx3eXpsDyl/Mfq+VF05+Dx73/iiuTjVTTROy9P9odV7a?=
 =?us-ascii?Q?dSJ3Mrnn4kxofHJGmhzpzmajVv5jARA8oxsZ801g2zcz4XHwYILUfmEw9oT3?=
 =?us-ascii?Q?qf7ma5EibrubE1eR2rEfqIm8EdHXeE81DWiPCZFR9kZfE6mOpPRf5KHeivA0?=
 =?us-ascii?Q?Fm1CkBgw9ONWuFjiXpCKiTM4dxwZPYUbZDwK/jq83IX9LskKH/m2G3LCoFz8?=
 =?us-ascii?Q?WxMDFIg6RQ/ZFch48mMOytcC+7FoqraSDfCS8jPTxOe8eQ95cBv/NyYkacGn?=
 =?us-ascii?Q?OpftoW+RhSguTI8pOPHefEFLY4xFg++esObzDJ5hcsFXUNOO4cSKxSuN7eu1?=
 =?us-ascii?Q?YjHKbOdjRs2Uzw1t1acMaz1rIknYQ4gmpV+V44h5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3705.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6550237-6169-4a60-c5bd-08dbe9b20105
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 10:18:13.3085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OZbrWzJdoRBeZIor9Xti/PESVoBF7yW/Q1z9h/4LirjTbRCU60SdTPETSWokidH0d4MYrymR7WcFqppd2Hzvwix2WJNvk138XblZXNGb2us=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB5430

On Monday, November 20, 2023 5:43 PM, Simon Horman wrote:
<...>
> > +     case TCP_V6_FLOW:
> > +     case UDP_V6_FLOW:
> > +     case SCTP_V6_FLOW:
> > +             for (i =3D 0; i < 4; i++) {
> > +                     fs->h_u.tcp_ip6_spec.ip6src[i] =3D entry->key.sip=
6[i];
> > +                     fs->h_u.tcp_ip6_spec.ip6dst[i] =3D entry->key.dip=
6[i];
> > +                     fs->m_u.tcp_ip6_spec.ip6src[i] =3D entry->msk.sip=
6[i];
> > +                     fs->m_u.tcp_ip6_spec.ip6dst[i] =3D entry->msk.dip=
6[i];
> > +             }
>=20
> I think the above loop can be more succinctly be expressed using a single
> memcpy(). For which I do see precedence in Intel drivers. Likewise
> elsewhere in this patch-set.
>=20
> I don't feel strongly about this, so feel free to take this suggestion,
> defer it to later, or dismiss it entirely.

Thanks Simon. Louis did have same suggestion about this part. But
since we have similar code below:
```
for (i =3D 0; i < 4; i++) {
	entry->msk.sip6[i] =3D fs->m_u.tcp_ip6_spec.ip6src[i];
	entry->msk.dip6[i] =3D fs->m_u.tcp_ip6_spec.ip6dst[i];
	entry->key.sip6[i] =3D fs->h_u.tcp_ip6_spec.ip6src[i] & entry->msk.sip6[i]=
;
	entry->key.dip6[i] =3D fs->h_u.tcp_ip6_spec.ip6dst[i] & entry->msk.dip6[i]=
;
}
```
which can not be replaced by `memcpy`, so I decided to leave them as
they are to keep consistency.
So if you don't feel strongly and nobody else objects it, I'll leave it.

>=20
> > +             fs->h_u.tcp_ip6_spec.psrc =3D entry->key.sport;
> > +             fs->h_u.tcp_ip6_spec.pdst =3D entry->key.dport;
> > +             fs->m_u.tcp_ip6_spec.psrc =3D entry->msk.sport;
> > +             fs->m_u.tcp_ip6_spec.pdst =3D entry->msk.dport;
> > +             break;
>=20
> ...

