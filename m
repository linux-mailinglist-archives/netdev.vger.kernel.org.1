Return-Path: <netdev+bounces-225953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBB3B99D37
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 14:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B03F07AF01E
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 12:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113482FFDF1;
	Wed, 24 Sep 2025 12:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="q6ZXuLK/"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010035.outbound.protection.outlook.com [52.101.84.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66902FF178
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 12:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758716722; cv=fail; b=CmuAZTtQ18ivwo6KFdsae5TjX0l6TvgI54Al5WBUzXpY3HJdnigi9b8xRjaY7fGT/IM3pxtcOujnrZYcAraz7Xjn6rSrRoatv9EggE741RbItJXTBnXXBZi8AKzh1svREnbjcTcoPpQh7T3QSzgHIHDqIC9Tymf8ouy3xgze34Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758716722; c=relaxed/simple;
	bh=hjo1GDr9VcUDocHeEfFTGw0/hjnNuPJyRG3AOUuESs8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BdEZASXGEIadvMKFwmZqXJHb5Pe46Q9qKI41vyRbYo06rs0e/oFC/0lzk2sbrKBgZu55g7OGd+wm4O7oYnOGO+AbGtCfyuIpjsjGSjLRjNbgylOu0u9V7GhVn+OOA1TGAGbKPeRpDjql2Uj8LKrtOvvn0lEdej50Oa+XRHHG+Jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=q6ZXuLK/; arc=fail smtp.client-ip=52.101.84.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SiPjLZvaXsL+dGwp3opzaGLm/XN2TLexaQvivzgxme+lCwFitiFfkOHc70VwkS7jJYG8J3+QrQ7d0wgjXTVQD6UGmniYIVZndyEMeWIyBUEfZtB64ljQhHMvjzApm7cQmTtGepLLn8ERwQLp6arFxKGFeZo7WAbEefsog7erwl1oTDdClm50DYzxqEcy11mI/ocZJX+Uab2dEl40IPe8i8Jyq6cTgIkqUfK2Vp12vX98OlQKhjeYq2jHbRLSaNBMsNKkb3U5OXkmzVjiyxP5Ts4vZWrYTjgwX96jUr3CqRQdr3FLvDyOe5CX8qHExKJ9Jvfm97rUTw28OmdIq87nRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/a7Z4fld5d2BitYTmKSfZBKfZ6/aQUtT1PIDctxrepc=;
 b=p1J25Ne4zwhgONEtFRuGLnxUrizDa2lCbaIjUj2FdIazXw/Ue98hj4ep7UaKdVS+Wtz0TgtYt2Z4Lo/84IIFpxmWceIMq6CxzRmVoM4UrqXgtEOt3rMLgMc81t6j0GHlaijplhvpS/CGKz7ZAX9Eg1DzBoe98Hd+opVf8iLAR5aeJ4uaHqOv8slak0pUtQAC+8Rxm2EEmqzC6eUovkGia45FGPS4eRs213e9/vBaay+wsI7KJdMRyDyiuNUBg7y/74E0WicOdTS6P9jC6cnYGpr3EPdAB+9kuIIcJ/b3aneZBRyL9n9gg8F2TpyeAOXgZ+RUjGhm+le5UdIbd/PG4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/a7Z4fld5d2BitYTmKSfZBKfZ6/aQUtT1PIDctxrepc=;
 b=q6ZXuLK/mmN4McjUsEEWyhJZOiSAjaBJAytE+2StX6Ih996p0e8AAX+eV97X0e4tRPQntWV9ynNZZz2kaHqTJniJMA7VVv2HgWRkJuFiziEtquNEVjeMyB31OlunNeK0fdBI44BTpTt8so4uZkZjgW6zkIpyg05mi2Hg8RekHgqgFna5CL9ur9bGKUOuXAiW1B/zKijpJhM88cHPR8CuhOpt6Rj9s3cWpkcyQFsEC5ktgwlqQOAJP+Oy7LH3l50ArQ35vQI4wutXVT/Gv1TJUPNrCrYMw5RHyjRJBg52RfLRn/7uleibTshZBDOmSvod4HWcLerrZhXPU+sq5mMR2A==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by AM4PR07MB11087.eurprd07.prod.outlook.com (2603:10a6:20b:6e6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 12:25:16 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 12:25:16 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ij@kernel.org>, Dan Carpenter
	<dan.carpenter@linaro.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [bug report] tcp: accecn: AccECN option
Thread-Topic: [bug report] tcp: accecn: AccECN option
Thread-Index: AQHcLLcjp8VA804s40ebGcdaOoZp6bSiP9xA
Date: Wed, 24 Sep 2025 12:25:16 +0000
Message-ID:
 <PAXPR07MB7984BA679B7782C6365E44F3A31CA@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <aNKEGWyWV9LWW3i5@stanley.mountain>
 <da87ed1c-165d-fd21-7292-19468d1c8a8c@kernel.org>
In-Reply-To: <da87ed1c-165d-fd21-7292-19468d1c8a8c@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|AM4PR07MB11087:EE_
x-ms-office365-filtering-correlation-id: 9101a98b-f344-461f-d0b8-08ddfb656b03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?7BFlyOZed4DwfSC6zM9wR9Ym0tADFJS1KAoNNwLBbK+XxZfvOsn545fd7U?=
 =?iso-8859-1?Q?5dKGIWgE7waneJVrnP5hwcohRv18JWmmKI8zt+w8tX9eBxCNXJ6jqxVmvO?=
 =?iso-8859-1?Q?sKloe0pdnb9uzrR8TmIV5SiRG1syOLifbx3SL13XN+309KyWu7DXBiEHPp?=
 =?iso-8859-1?Q?FE6QQUSfG1LXXl/nwpRiAMMac10atPxmUgjm8GCB6R3T9WpLBzUMAyDcRJ?=
 =?iso-8859-1?Q?LSzfcU0NxC8NR/Nf+VMbnTUXQuOAyEUtg3uBGJg+q+S9uBUMCvLg2qiAO2?=
 =?iso-8859-1?Q?1YGAnlNsrQW+SKGzLudNBCdj5g7rKYTWHQx+h3NSL9FS3DQ1Ix3QuJmEgX?=
 =?iso-8859-1?Q?1LIG/dHPNPbUiwqcB88ra7LqCvPMh/H6P7QK+rCU0MpMeoVe4pK5bSaZtM?=
 =?iso-8859-1?Q?MDT1D84/9ty2jsKi7NsKbwHR+eLXSlbnKdCbY+ijNhzQnYGwNOEL+nfmRt?=
 =?iso-8859-1?Q?jJBST8LMG1zqlx/k1w7TrCZGU9n/RW31YqpPM3siVaCvVWl5yLJiOWP03H?=
 =?iso-8859-1?Q?soNVbwHF7l8o6l3pa+HJ1wwqM749YbXNcQ56qCZ2j79YAIuUUP5/Fj7o+I?=
 =?iso-8859-1?Q?50zIWe8wbg4CH0wjySxYAHby7e0Y2sRGN6dRO58Hw+KJeJpWLDwLE/FHD2?=
 =?iso-8859-1?Q?zwDBKOt0ba3BsTdJJegYCiii4srdXFDdfu/9ekJrZufxD85PzWtw36D+rO?=
 =?iso-8859-1?Q?Q9gBQJwdn8yyNcDCSXKi24ChQSPHlw9U1JPnZoBQ47ryW3k1DbXAH9IeD1?=
 =?iso-8859-1?Q?PMgT3W0JhqtQBTlp3kRFFaN6ce2vEHUXZJ37fjNN7F2asV7SrgN8sf6RgC?=
 =?iso-8859-1?Q?1lJ7Qak6sruC72wbkbNKwpp9lowP+kkHWPaq9tLvu23XIszBGzZbecIVms?=
 =?iso-8859-1?Q?ZPjXBxJ2B7LDHWoUJM/ZQMY7mIQMb2nwr91guNStqa65D6PudZryGdSr/5?=
 =?iso-8859-1?Q?Gt0STO+ZMW4Zv5GhBPvZsmsVH22uBcocflPrs02nv+I/e7c/880u0qZADy?=
 =?iso-8859-1?Q?A/dl4KhOt+1HGL47ktTFoB1O8BGLt+pK+0fXuFt6Hclj71xWueoXKuAxbt?=
 =?iso-8859-1?Q?8/rL9LPd8G7Tl7sHKjanmBTwbNhcoZv2ii+T/zd4x4p046oZ5BaobOykc5?=
 =?iso-8859-1?Q?66QFXwaViZOBjFibFPwwvDk4TfWy9RlE8B99rrt19Y3F/roqGePTBXxSiA?=
 =?iso-8859-1?Q?AKBEUP3zSrj2PyzzWMDvO30QQ2u9nWfk+cT1GBOy9GPzZ3obavCT/neYvV?=
 =?iso-8859-1?Q?e17Eb6YxgdevCisn6l7sYYyYSGqplOlFN4fXkMCWEgtJJtco5QyWavepSO?=
 =?iso-8859-1?Q?eMP6pRP2gBO7iuGdpeLXXMhX+qNLD3SqkOPVXThXqfogiSdcIEGEak29a/?=
 =?iso-8859-1?Q?GVyYKoLqBR7jde94YrPcw3NeNM5hvyDeixj418yLexQfq/FOGnGrRSaOo5?=
 =?iso-8859-1?Q?0MeTE8dX9bJ7rGslxmkbnKKdnW7AqHFalStiUEkn6pzrJTG91QrnB/aaBD?=
 =?iso-8859-1?Q?I=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?r6+Ac9lA1IFijvD2LekDVcBxzEO3IxCiok25Sf0ROnqNaQmizwGbPcDzmF?=
 =?iso-8859-1?Q?qV7zTSc2oRrPtjI05RtfB7LmN6KTG/YnoaaDMTfFcFNjwkoLVez714AGaO?=
 =?iso-8859-1?Q?CAqLgIq8zaMoCO2vrK7dkPuz5owytH8Fh9evY9pXBQqgcSNuFC1DzIZVo1?=
 =?iso-8859-1?Q?5QJC4g8/XblX8/Ox1Y9nEmJX+CFIUAHqJsSSfDr8dQV7BUYDFhO3qZ809d?=
 =?iso-8859-1?Q?xaKJypus5APa2q/qOB3JEm6bCV1jNt9zInqI7r7/Vvr+FrmVrAm3IVveLV?=
 =?iso-8859-1?Q?N8/Fi0nVWUJ5ZJCO5mbVX4SWA+NFNDruXRVVikkvOnxUKoDIn7KW6RDrdY?=
 =?iso-8859-1?Q?SVE1NoDO3iwOfSf8tWwDczB/NH1WCJ3i3XSjP7VRCxSJ51nHSsyMOUI5zG?=
 =?iso-8859-1?Q?ZpU7oFCg5MiqDRXEruL/3VxlLXg1PSbu1DUUDt2TICQ4zD/PLDKTIs47ZG?=
 =?iso-8859-1?Q?MG8LTA5yVfHjiiZvLyZ2hFqpObrdEKiAaSbFNvwOMjiHy6h1eqC78bByy2?=
 =?iso-8859-1?Q?YqrLxlgmMI+sVTbzM1L6iezXRz/Wr/xckWXhyWPSZxjeSLezqSyHPWFyH1?=
 =?iso-8859-1?Q?KLWZckaaAvYkq3cAPZ55YE1PardkIcA215bA3v9XkmVnLIJ3mred0cyPGt?=
 =?iso-8859-1?Q?S+VmmAjwBP/Gv5zNG6dQDUClU5qMYCUqa0o/oW1Xpv4tAyfyAw67US3+IY?=
 =?iso-8859-1?Q?vE4l8WGFAOvQ68L+WYDUO65lsZWiMfkE8n7ofhifczW3mBBjOOOLfvTHhn?=
 =?iso-8859-1?Q?iK9JvQTy5lvSCTaDR9bJRujQmAEDpOK7G4LTFDo0bFBxq9SF4jv5SbSKLH?=
 =?iso-8859-1?Q?/9QZM/s2pj0yebWOZ7XYTHk2VUWjy3HsAUM/eomNVzpFj+Dinkel03eD4Q?=
 =?iso-8859-1?Q?xcPUcNRRoMWtv80Vmq6nj+mMGovq25Y/Q6Xgv/HyJdAMPh0XidR1YHymMA?=
 =?iso-8859-1?Q?jN4TMapg7Ap0TAafQ2XiryQU5xM2rGX0Z9+9LIx2+rAQcMvqTNyj5kOS88?=
 =?iso-8859-1?Q?17QQpzfRElFzzfBiUB/ql693zPihuiwqPmUUi6PT3DYeO4jwed0/CO4uvw?=
 =?iso-8859-1?Q?MQVI7h2Nm9pb5NIzKOyzqwJALqu2uXsaO5W0jKw5nghl6k5B4PeZPChVMa?=
 =?iso-8859-1?Q?MJVi4ymQIUwUK42VaKRb+iTioMSDXh5TP06cgWnlrxjQaOkdvKU26NH0MC?=
 =?iso-8859-1?Q?vvNJthX31PStjVaPncXEgYvsPr1P5bSL+MMN77+5rUvZWhM63B23v7tb5I?=
 =?iso-8859-1?Q?1qDu4nuH9u8Pz3cZNGGav+iJvafsEpB94pRNajYHGKNCQz0Wk4vcahwk8g?=
 =?iso-8859-1?Q?niAp2DuhanM8rIFmXaV6DxMCFBVVa3EIY6hfubLjZ02Bcbs/GUUIsYsRpK?=
 =?iso-8859-1?Q?pxrgwgAMyVZJXy1aOtnnu6ghhBuJViwTwVyuaIVGOYoSbXT61BJ5fshqw3?=
 =?iso-8859-1?Q?SBHOhXC82wmlvnqa1IWsB676dY748K/beeYlhPzPmfyN4844Hq+Qvsl9/I?=
 =?iso-8859-1?Q?5RUc74LxJCBPuQDmcXwx+C9RANL2XszcL3pz+FJdVOWPWoy9dbmZpWrPCu?=
 =?iso-8859-1?Q?KjKndrnJaRzhqV2rYBhr8k+ZQYQtz6AfBOyZODywS3WfOEcN3jgBJfvMMn?=
 =?iso-8859-1?Q?vteFPJ3NDkrADPXT0rmSwmJsozfdwWJ/Mt+ShehAHo8O+h5APaPs5yvQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB7984.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9101a98b-f344-461f-d0b8-08ddfb656b03
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 12:25:16.1808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8sf6oT6Tnwp9a3jNT6g3iIjfz3sxHNZVoBK5FuTl6RDvMbV+OW+qyf9IvCuCbwk9Y+7w7ef1cg076iJY/4Ei84IvfULCfoudWWCmMieb6Y79rbYhVo28Oj+n20Tvly98
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR07MB11087

> -----Original Message-----
> From: Ilpo J=E4rvinen <ij@kernel.org>=20
> Sent: Tuesday, September 23, 2025 8:23 PM
> To: Dan Carpenter <dan.carpenter@linaro.org>; Chia-Yu Chang (Nokia) <chia=
-yu.chang@nokia-bell-labs.com>
> Cc: netdev@vger.kernel.org
> Subject: Re: [bug report] tcp: accecn: AccECN option
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> On Tue, 23 Sep 2025, Dan Carpenter wrote:
>=20
> > Hello Ilpo J=E4rvinen,
> >
> > Commit b5e74132dfbe ("tcp: accecn: AccECN option") from Sep 16, 2025=20
> > (linux-next), leads to the following Smatch static checker warning:
> >
> >       net/ipv4/tcp_output.c:747 tcp_options_write()
> >       error: we previously assumed 'tp' could be null (see line 711)
> >
> > net/ipv4/tcp_output.c
> >     630 static void tcp_options_write(struct tcphdr *th, struct tcp_soc=
k *tp,
> >     631                               const struct tcp_request_sock *tc=
prsk,
> >     632                               struct tcp_out_options *opts,
> >     633                               struct tcp_key *key)
> >     634 {
> >     635         u8 leftover_highbyte =3D TCPOPT_NOP; /* replace 1st NOP=
 if avail */
> >     636         u8 leftover_lowbyte =3D TCPOPT_NOP;  /* replace 2nd NOP=
 in succession */
> >     637         __be32 *ptr =3D (__be32 *)(th + 1);
> >     638         u16 options =3D opts->options;        /* mungable copy =
*/
> >     639
> >     640         if (tcp_key_is_md5(key)) {
> >     641                 *ptr++ =3D htonl((TCPOPT_NOP << 24) | (TCPOPT_N=
OP << 16) |
> >     642                                (TCPOPT_MD5SIG << 8) | TCPOLEN_M=
D5SIG);
> >     643                 /* overload cookie hash location */
> >     644                 opts->hash_location =3D (__u8 *)ptr;
> >     645                 ptr +=3D 4;
> >     646         } else if (tcp_key_is_ao(key)) {
> >     647                 ptr =3D process_tcp_ao_options(tp, tcprsk, opts=
, key, ptr);
> >                                                      ^^ Sometimes=20
> > dereferenced here.
> >
> >     648         }
> >     649         if (unlikely(opts->mss)) {
> >     650                 *ptr++ =3D htonl((TCPOPT_MSS << 24) |
> >     651                                (TCPOLEN_MSS << 16) |
> >     652                                opts->mss);
> >     653         }
> >     654
> >     655         if (likely(OPTION_TS & options)) {
> >     656                 if (unlikely(OPTION_SACK_ADVERTISE & options)) =
{
> >     657                         *ptr++ =3D htonl((TCPOPT_SACK_PERM << 2=
4) |
> >     658                                        (TCPOLEN_SACK_PERM << 16=
) |
> >     659                                        (TCPOPT_TIMESTAMP << 8) =
|
> >     660                                        TCPOLEN_TIMESTAMP);
> >     661                         options &=3D ~OPTION_SACK_ADVERTISE;
> >     662                 } else {
> >     663                         *ptr++ =3D htonl((TCPOPT_NOP << 24) |
> >     664                                        (TCPOPT_NOP << 16) |
> >     665                                        (TCPOPT_TIMESTAMP << 8) =
|
> >     666                                        TCPOLEN_TIMESTAMP);
> >     667                 }
> >     668                 *ptr++ =3D htonl(opts->tsval);
> >     669                 *ptr++ =3D htonl(opts->tsecr);
> >     670         }
> >     671
> >     672         if (OPTION_ACCECN & options) {
> >     673                 const u32 *ecn_bytes =3D opts->use_synack_ecn_b=
ytes ?
> >     674                                        synack_ecn_bytes :
> >     675                                        tp->received_ecn_bytes;
> >                                                ^^^^ Dereference
>=20
> Hi Dan,
>=20
> While it is long ago I made these changes (they might have changed a litt=
le from that), I can say this part is going to be extremely tricky for stat=
ic checkers because TCP state machine(s) are quite complex.
>=20
> TCP options can be written to a packet when tp has not yet been created (=
during handshake) as well as after creation of tp using this same function.=
 Not all combinations are possible because handshake has to complete before=
 some things are enabled.
>=20
> Without checking this myself, my assumption is that ->use_synack_ecn_byte=
s is set when we don't have tp available yet as SYNACKs relate to handshake=
.
> So the tp check is likely there even if not literally written.
>=20
> Chia-Yu, could you please check these cases for the parts that new code w=
as introduced whether tp can be NULL? I think this particular line is the m=
ost likely one to be wrong if something is, that is, can OPTION_ACCECN be s=
et while use_synack_ecn_bytes is not when tp is not yet there.

Hi Ilpo and Dan,

I've checked that OPTION_ACCECN and use_synack_ecn_bytes will always be set=
 at the same time.
The case you said (OPTION_ACCECN is 1, but use_synack_ecn_bytes is 0) can o=
nly happen when tp is set, because this is already ESTABLISHED state (see t=
cp_established_options in tcp_output.c).

So, I would say this is ok.
But if this is indeed a concern for the checker, just add another "if (tp)"=
.=20


Chia-Yu
>=20
> >     676                 const u8 ect0_idx =3D INET_ECN_ECT_0 - 1;
> >     677                 const u8 ect1_idx =3D INET_ECN_ECT_1 - 1;
> >     678                 const u8 ce_idx =3D INET_ECN_CE - 1;
> >     679                 u32 e0b;
> >     680                 u32 e1b;
> >     681                 u32 ceb;
> >     682                 u8 len;
> >     683
> >     684                 e0b =3D ecn_bytes[ect0_idx] + TCP_ACCECN_E0B_IN=
IT_OFFSET;
> >     685                 e1b =3D ecn_bytes[ect1_idx] + TCP_ACCECN_E1B_IN=
IT_OFFSET;
> >     686                 ceb =3D ecn_bytes[ce_idx] + TCP_ACCECN_CEB_INIT=
_OFFSET;
> >     687                 len =3D TCPOLEN_ACCECN_BASE +
> >     688                       opts->num_accecn_fields * TCPOLEN_ACCECN_=
PERFIELD;
> >     689
> >     690                 if (opts->num_accecn_fields =3D=3D 2) {
> >     691                         *ptr++ =3D htonl((TCPOPT_ACCECN1 << 24)=
 | (len << 16) |
> >     692                                        ((e1b >> 8) & 0xffff));
> >     693                         *ptr++ =3D htonl(((e1b & 0xff) << 24) |
> >     694                                        (ceb & 0xffffff));
> >     695                 } else if (opts->num_accecn_fields =3D=3D 1) {
> >     696                         *ptr++ =3D htonl((TCPOPT_ACCECN1 << 24)=
 | (len << 16) |
> >     697                                        ((e1b >> 8) & 0xffff));
> >     698                         leftover_highbyte =3D e1b & 0xff;
> >     699                         leftover_lowbyte =3D TCPOPT_NOP;
> >     700                 } else if (opts->num_accecn_fields =3D=3D 0) {
> >     701                         leftover_highbyte =3D TCPOPT_ACCECN1;
> >     702                         leftover_lowbyte =3D len;
> >     703                 } else if (opts->num_accecn_fields =3D=3D 3) {
> >     704                         *ptr++ =3D htonl((TCPOPT_ACCECN1 << 24)=
 | (len << 16) |
> >     705                                        ((e1b >> 8) & 0xffff));
> >     706                         *ptr++ =3D htonl(((e1b & 0xff) << 24) |
> >     707                                        (ceb & 0xffffff));
> >     708                         *ptr++ =3D htonl(((e0b & 0xffffff) << 8=
) |
> >     709                                        TCPOPT_NOP);
> >     710                 }
> >     711                 if (tp) {
> >                             ^^
> > Here we assume tp can be NULL
> >
> >     712                         tp->accecn_minlen =3D 0;
> >     713                         tp->accecn_opt_tstamp =3D tp->tcp_mstam=
p;
> >     714                         if (tp->accecn_opt_demand)
> >     715                                 tp->accecn_opt_demand--;
> >     716                 }
> >     717         }
> >     718
> >     719         if (unlikely(OPTION_SACK_ADVERTISE & options)) {
> >     720                 *ptr++ =3D htonl((leftover_highbyte << 24) |
> >     721                                (leftover_lowbyte << 16) |
> >     722                                (TCPOPT_SACK_PERM << 8) |
> >     723                                TCPOLEN_SACK_PERM);
> >     724                 leftover_highbyte =3D TCPOPT_NOP;
> >     725                 leftover_lowbyte =3D TCPOPT_NOP;
> >     726         }
> >     727
> >     728         if (unlikely(OPTION_WSCALE & options)) {
> >     729                 u8 highbyte =3D TCPOPT_NOP;
> >     730
> >     731                 /* Do not split the leftover 2-byte to fit into=
 a single
> >     732                  * NOP, i.e., replace this NOP only when 1 byte=
 is leftover
> >     733                  * within leftover_highbyte.
> >     734                  */
> >     735                 if (unlikely(leftover_highbyte !=3D TCPOPT_NOP =
&&
> >     736                              leftover_lowbyte =3D=3D TCPOPT_NOP=
)) {
> >     737                         highbyte =3D leftover_highbyte;
> >     738                         leftover_highbyte =3D TCPOPT_NOP;
> >     739                 }
> >     740                 *ptr++ =3D htonl((highbyte << 24) |
> >     741                                (TCPOPT_WINDOW << 16) |
> >     742                                (TCPOLEN_WINDOW << 8) |
> >     743                                opts->ws);
> >     744         }
> >     745
> >     746         if (unlikely(opts->num_sack_blocks)) {
> > --> 747                 struct tcp_sack_block *sp =3D tp->rx_opt.dsack =
?
> >                                                     ^^^^^^^^^^^^^^^^=20
> > Unchecked dereference here.
> >
> >     748                         tp->duplicate_sack : tp->selective_acks=
;
> >     749                 int this_sack;
> >     750
> >     751                 *ptr++ =3D htonl((leftover_highbyte << 24) |
> >     752                                (leftover_lowbyte << 16) |
> >     753                                (TCPOPT_SACK <<  8) |
> >     754                                (TCPOLEN_SACK_BASE + (opts->num_=
sack_blocks *
> >     755                                                      TCPOLEN_SA=
CK_PERBLOCK)));
> >     756                 leftover_highbyte =3D TCPOPT_NOP;
> >     757                 leftover_lowbyte =3D TCPOPT_NOP;
> >     758
> >     759                 for (this_sack =3D 0; this_sack < opts->num_sac=
k_blocks;
> >     760                      ++this_sack) {
> >     761                         *ptr++ =3D htonl(sp[this_sack].start_se=
q);
> >     762                         *ptr++ =3D htonl(sp[this_sack].end_seq)=
;
> >     763                 }
> >     764
> >     765                 tp->rx_opt.dsack =3D 0;
> >     766         } else if (unlikely(leftover_highbyte !=3D TCPOPT_NOP |=
|
> >     767                             leftover_lowbyte !=3D TCPOPT_NOP)) =
{
> >     768                 *ptr++ =3D htonl((leftover_highbyte << 24) |
> >     769                                (leftover_lowbyte << 16) |
> >     770                                (TCPOPT_NOP << 8) |
> >     771                                TCPOPT_NOP);
> >     772                 leftover_highbyte =3D TCPOPT_NOP;
> >     773                 leftover_lowbyte =3D TCPOPT_NOP;
> >     774         }
> >     775
> >     776         if (unlikely(OPTION_FAST_OPEN_COOKIE & options)) {
> >     777                 struct tcp_fastopen_cookie *foc =3D opts->fasto=
pen_cookie;
> >     778                 u8 *p =3D (u8 *)ptr;
> >     779                 u32 len; /* Fast Open option length */
> >     780
> >     781                 if (foc->exp) {
> >     782                         len =3D TCPOLEN_EXP_FASTOPEN_BASE + foc=
->len;
> >     783                         *ptr =3D htonl((TCPOPT_EXP << 24) | (le=
n << 16) |
> >     784                                      TCPOPT_FASTOPEN_MAGIC);
> >     785                         p +=3D TCPOLEN_EXP_FASTOPEN_BASE;
> >     786                 } else {
> >     787                         len =3D TCPOLEN_FASTOPEN_BASE + foc->le=
n;
> >     788                         *p++ =3D TCPOPT_FASTOPEN;
> >     789                         *p++ =3D len;
> >     790                 }
> >     791
> >     792                 memcpy(p, foc->val, foc->len);
> >     793                 if ((len & 3) =3D=3D 2) {
> >     794                         p[foc->len] =3D TCPOPT_NOP;
> >     795                         p[foc->len + 1] =3D TCPOPT_NOP;
> >     796                 }
> >     797                 ptr +=3D (len + 3) >> 2;
> >     798         }
> >     799
> >     800         smc_options_write(ptr, &options);
> >     801
> >     802         mptcp_options_write(th, ptr, tp, opts);
> >                                              ^^ The last dereference=20
> > is checked for NULL but the others aren't.

