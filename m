Return-Path: <netdev+bounces-205184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7100AAFDBB8
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 01:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1A307B0B4E
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 23:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C694233707;
	Tue,  8 Jul 2025 23:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jRpzCkak"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE94235C01
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 23:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752016356; cv=fail; b=DLI6hZv9HWhXb7y+PXKgtqvwZHZdepYiiodXCgaA4M85Oh05Q8MAB9gpS2KIuIN8PQ5M5UIW7KkwoUOhcY6ptDkp23Y09PKzWvcb5UprIfPiBLgmLo78z+ubq4rLIYvLbnz9vTXoUYLnhy8NGXrGL83+xplMTk2J+Wa8JvqowSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752016356; c=relaxed/simple;
	bh=dDF8YzjIq/VnTG9qQKEZdEYAPlOUA/pO8iL/aHWqiEc=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=NfgYBRVO91SWPfQTONUi/atI98PwQ0KMycDT/HtEguXQN34NNxBm0eyqAp/BBurcn0+SlgSyyz2jfS+Udx+zDoUxuZSgSoflYca5hspBeXIyxIMdfhy1PlEFTsprQ915GCHTdHEfIRPk1421DtQHsE+K0uiLqdYMZ0hpjB/i/ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=pass smtp.mailfrom=us.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jRpzCkak; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=us.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568Fwo9H019358;
	Tue, 8 Jul 2025 23:12:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PA4a2P
	ADmzmnjVY2/N45mOf54I5BbBu2wKPYJr3nmWQ=; b=jRpzCkakoOOmbmNXLhjogx
	NItXB0bLLjlZX3k0CTLAJXe7ip510saGxLXubvaIRELjvb8gL8gd771+bRYjA+3f
	6PZ+gX990f3olUeI/CnbvLCf6ffo2YIL/chC7Yw/9sVWo76M+0g6zrZh4BhUN2Im
	Up7SZ49POnm6U1FVTtNmZKQiSMoLfKsdQWiEHowc1LCGTy+06F3wcZrb8bsfiDtt
	S6jAUalAVnlB8zAkRBabot0VZFJIPf0WklHiexJyLRJ36njyBA6M2dgtmP8qV30/
	Z9FtW0+8ZOcFvTjM/jluf4p/gkzx+BVb7vdFn+jBIINnZgNYfVkdDL2BIWqV4f5Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puk42y1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 23:12:24 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 568NCOG0031369;
	Tue, 8 Jul 2025 23:12:24 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puk42y1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 23:12:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E42Ql7zqWCDHkkJPo4ddaQmgZm6q5HDoY5m4+pq/9kP4hbf8E0WYXevOvxuKS0OKdyjdAjpEqkj8cqO83G7mxSnGSsTJCngG/T2MkQcvwRmVa1NNAJNVMZmch167rAgOdSVKLvZAAWG4PvQLfP96MYO9qbDMtu2gf4zpAkn+Bn30iERtw8zYWDj0N37TmN8ZQrW98Bp5jutcSW2KD1YemRoFssFV55oGFg1oG3vRPgU1TDV59OskAxF0nvjDUhm5oQ8RbIH7B+xgTh6IPmJaLG/eUUcSvop3ecg1POINTXaujBUL8uXvAYnsQTKoVjj6/2DhRCxy89g8HR8aleUjkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PA4a2PADmzmnjVY2/N45mOf54I5BbBu2wKPYJr3nmWQ=;
 b=gb1j0NwREPQdPr+GHaBmgzYYg+buDGZsYu6Iy3CsWXAlHGCaVB9SS/Cz0P5FQnINXTuhfVqPkDdkFi0e+ZK+/4x8oYsgLg84fG83rhhejd0hJZdnyLz2AdFsfHJKMkuYJQ/92cTRPqCgaHzJZ3e0rhCkq1MqxtWQ5eoAELY49A6bxQUQgvJu8hQIJtxa4gVXXJK+5EuE9/a24qJeuhx0YNI2K4wbQVrXjPdWniQwM3cYATey3tVuF68DJWaJeeoFmJmR1eMFrfLG+RPx2xLCfsnzYJJDfzUrGxmf01gBEd9oQZ/7FhXvM8asCcYT2Ed+vGEAihJbeFfaXMTy4GvuDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from MW3PR15MB3913.namprd15.prod.outlook.com (2603:10b6:303:42::22)
 by SN7PR15MB5955.namprd15.prod.outlook.com (2603:10b6:806:2e4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 23:12:21 +0000
Received: from MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490]) by MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 23:12:21 +0000
From: David Wilder <wilder@us.ibm.com>
To: Jay Vosburgh <jv@jvosburgh.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "pradeeps@linux.vnet.ibm.com" <pradeeps@linux.vnet.ibm.com>,
        Pradeep
 Satyanarayana <pradeep@us.ibm.com>,
        "i.maximets@ovn.org"
	<i.maximets@ovn.org>,
        Adrian Moreno Zapata <amorenoz@redhat.com>,
        Hangbin Liu
	<haliu@redhat.com>,
        "stephen@networkplumber.org"
	<stephen@networkplumber.org>,
        "dsahern@gmail.com" <dsahern@gmail.com>
Thread-Topic: [EXTERNAL] Re: [PATCH iproute2-next v1 1/1] iproute: Extend
 bonding's "arp_ip_target" parameter to add vlan tags.
Thread-Index: AQHb56GBNutcjQylmkWposPblhytX7QogeCAgABLCHE=
Date: Tue, 8 Jul 2025 23:12:21 +0000
Message-ID:
 <MW3PR15MB3913AD3F5DCEB5D95C52DB85FA4EA@MW3PR15MB3913.namprd15.prod.outlook.com>
References: <20250627202430.1791970-1-wilder@us.ibm.com>
 <20250627202430.1791970-2-wilder@us.ibm.com> <163667.1751993497@famine>
In-Reply-To: <163667.1751993497@famine>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR15MB3913:EE_|SN7PR15MB5955:EE_
x-ms-office365-filtering-correlation-id: 4bf34176-301f-4661-9462-08ddbe74e47e
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?TYytoDSvxjZS/WE3NFkASPLAKRXr5+IRqKfChxo2+qVwHDBtFQfcCBiZYb?=
 =?iso-8859-1?Q?C8f+c1woRus6tD2RxEJU9UgHkZyPr+Rhq+snD7kRi8kDggiGvaz2yHPf8J?=
 =?iso-8859-1?Q?KB5dSDWz6mQcwfnzj249Lc8QikLps0QiCYzvKA+0/pBBRuxEQvrDvC9kHE?=
 =?iso-8859-1?Q?9doq+YJO3SnVDOtbWCtV5HUlswc4bR67eji5wJNkqM+QpQa0qucQ1ldmqf?=
 =?iso-8859-1?Q?5re0ikj1SAQIa2G9WPjHcDLR+lBp6NL3PJodfgy0YDszJCfXMkrV62SoGk?=
 =?iso-8859-1?Q?RgbtGE2Qi1XWgLwnM2h9zZPPTnX7D5RpaNcD436z2SGEIbegzI1jF2KnT5?=
 =?iso-8859-1?Q?yN7f2B83qZBlnXWTMw3/AOINVlHL7bFQReaSgSava3lmMJrR58JbkgVtfU?=
 =?iso-8859-1?Q?nCOb23qxMAD64fbg/FP4RtrCG3O6daE2Y4A1zH5sWs6NcyIkcPxFXioV3k?=
 =?iso-8859-1?Q?ZB8pU4UJ2PL4gx8zQZG1aYaNNBTFYCivzg1hMi26wkqtop3yER+7wmHlFs?=
 =?iso-8859-1?Q?g/Ao3tKrLQgN5W7Cgu0P0OUexGlBy1sca08H+7Stw86awwTRuGdDQ+7hyh?=
 =?iso-8859-1?Q?uXfQWMXs/R9w6lkU3FvXUmsN5MWW6Uk7r+PIZX3Ev8TNuEnSV4JREvJjfz?=
 =?iso-8859-1?Q?5nbCflSqpoHtKn2jB2Bd5MvlWBr8YqZ4Imcy3f4vRl+fX1f8vhpAwlO1AP?=
 =?iso-8859-1?Q?D/AxQ0F8bhPBP8H1wK37i3bwcaFmw9Qvstdk0xwnYIr1SAiG/lYfsagIs2?=
 =?iso-8859-1?Q?yLgf5OVb34b+YOlPG7X+4eGJLvJViUvyzDQ9WBSliSrhdwC0JIn1avTCmQ?=
 =?iso-8859-1?Q?wEEMqNo2ZnclT7rpffd3s4lBXErD4r2IPH95Ky0GklxAMBDdni87m2EpOY?=
 =?iso-8859-1?Q?RogPmg7nrY2U2ZBN/6c+y3v0/prbu2ve8bB+6EpmMoCygmqzwOCJxaTSaw?=
 =?iso-8859-1?Q?rjeTcl9s6wdKFZl8ojEZAAtyM/OMvnRmhm/apAxqFsMicISbS8Sacn1bNo?=
 =?iso-8859-1?Q?PSZ5zFYrqaHKK+5e/GyohFVKGVUH0CyGq36CLs11QB8NUK9zydAefkFFGO?=
 =?iso-8859-1?Q?VhrNkz2oEtFO7WgxAq4Zw6hrFRFJfmAjVqwFfzq5IGKVpSVyL9Y4bhTqwf?=
 =?iso-8859-1?Q?cg6eegNmcnYUDVl+9bHCRDmi7AuOnNjJOHj9LKRfoHMqMIa6GCZh54Fvje?=
 =?iso-8859-1?Q?PHLsNfxlla2qbMniqi8yn3868sfHOrKk4VJDNCj3SuAxX3ajPNo7DyJId8?=
 =?iso-8859-1?Q?oAT3fQpwYAG1wUxo6LnJ6c7fxchzqr/LciRSyqB4iRMirVPXIfbSY+W46F?=
 =?iso-8859-1?Q?Tw+n8sNmhN7ER6B6x+V9xBtEwQItKyzU3tsWmG8oEi0Cxp3fWwv9P/MGwQ?=
 =?iso-8859-1?Q?s0oiF8uuNDqhRqpu9F1N5UXTuABPa+dJgLITCpYr6l8XrDOZIkaVIC3xRv?=
 =?iso-8859-1?Q?v4VGbr0F941b2xF9k9XSEpg/25POy14axb2CO+JoW96zn/lktgQIGgCfgS?=
 =?iso-8859-1?Q?/aBVYPCqfNUYfTiT8d3DEDYbTJeXJNOY/C859W4OFegA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3913.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?AcI7/Jzh8wqX/FaSrl4Doknnf0pY4dsdggUBmIiCOQ7KePF4pmPVpxq2Dc?=
 =?iso-8859-1?Q?TvyHGDgBOHn3G03Hfq6A0bT8oECgFFY4XmOkYQyj+x5tQLi8jDZgKSr2Lw?=
 =?iso-8859-1?Q?LKr/C0VIwB0odgIHCVfHPJp5BMw7W2W4qj7l/1Al+6/7ebIL0qnOouYJpd?=
 =?iso-8859-1?Q?hWpCYkTXf9VVDlFnCNkEee1f+mfem6CCbTEmFdJGi4OLBW8A5kQgG4O6X+?=
 =?iso-8859-1?Q?H3uqfc1ZwZzI9Bs6Y/GfT3aHXKwdCRAaX6zkBE4AR1y/4iiDBCki+XxNaV?=
 =?iso-8859-1?Q?kk5pYdJ7CvEcSm6jN7N9OiyxVGgCHKvq5oheh5KnusuDPBBGIbPlKxwnP2?=
 =?iso-8859-1?Q?rjk/B++lmnrxCSD8RnJ+jGfMdeQdTSvcrkkzIlDqRwg72fDUavKXlhiHo6?=
 =?iso-8859-1?Q?oPbTVFvJs2+N0pqY/mNTKoyVTAm9GR8iBRFptSvmtOXPGa6nKYZ1O+2J36?=
 =?iso-8859-1?Q?56hpaAHDXV/Da+VDrIwJJruvtkP2TjpPVkINm64ebjwTTv1EaYQd0/s6FO?=
 =?iso-8859-1?Q?NSNsRQRxMxbdJqJ0XC21SLBmtpEAFvd0vaZL3RfGaAS9StVnSthOltoSA3?=
 =?iso-8859-1?Q?5umz/0glIyG4e3bddgKnbDuqgk+iem1gimPyRiOHFV4Dv+XjfVmYXgXOCv?=
 =?iso-8859-1?Q?xcyTWszCbwFhHyDGDbAvnIoaBnM8zlo6vVrx9V+pKngjhQ3UiLdx+dqgw8?=
 =?iso-8859-1?Q?hsmWXcUqADoVk0Mojkp8IXUjGxF0zvq2l1b43ZNMDlFj3jMOJ0RGWswaK9?=
 =?iso-8859-1?Q?FD43owcWCZD081w7ttx7EEya6hcV9h52V2mTlUb43nVpJW4hn5zNdGW8dG?=
 =?iso-8859-1?Q?taFFGIYmix6Y+Gj1tHZqmxjt0dT96QCFIrcgOh/FaFelk/3IHctPdmIqhG?=
 =?iso-8859-1?Q?VzJaHzr50Y0fPPB7U8ceJkCjoTHuI+vbFqMLsPulytbvZkcHyfCcwGeEMc?=
 =?iso-8859-1?Q?sriVPi9tyKkRF7YubkapsxR2Enk5j/Y6hRezlZTq8reUGxUDpGCyj4AMVx?=
 =?iso-8859-1?Q?k9lzuQV2gagykY1FEXgUXdZBMmJIhpuHVuuEHjo1s62TvCajHfyBQXByXP?=
 =?iso-8859-1?Q?uF//phrLRZrXii622fDfEW9/VW9O4Gm8miiLUmDa7eLsURO2LPKh3Xc3z8?=
 =?iso-8859-1?Q?7+TbBANH1Z+pz3PueV2FV5VSsSH4pzmLZKj2QQc2/men6E4qMWm1Q+HZzV?=
 =?iso-8859-1?Q?bgO7OGLca/Hg7pq1F68TUZsPhz/nXs4ZtEwi8xX9nANM6HOAhfgLbLGUR2?=
 =?iso-8859-1?Q?SRvv13s1DODlYraPc3pkSU13YnjiRxgF8RGyBZwDfYQSNSfPqViAO5tQ7k?=
 =?iso-8859-1?Q?E2xWi3ay1H0DN08SKDbWKs9qCKnJp9wKW1zBDkRVVNaOBupdGqUDE0QY6S?=
 =?iso-8859-1?Q?Mo4fxY5lEySvMScOEardFfJj3elEtVGDHUaYw1J34Q8BXgbRKF2Je5HIhW?=
 =?iso-8859-1?Q?f51Kn6v4GUYYGowz74tRjVvz/Qo9phBfIYyAeuBSdXdeiSVPHE8su5lwmU?=
 =?iso-8859-1?Q?Dno78Qxh5dRTvb/xNUWLMy3sB9Eif+k/MjD0lPfnNRLHf4qJL9/S0tl5Bz?=
 =?iso-8859-1?Q?oq6/e+eGE0+LxqkF28CUnNld5JnUO1HsluNDPdbdeD3jRCfQXiBuwYxKF0?=
 =?iso-8859-1?Q?+ily3DcNPau2A=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: us.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR15MB3913.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf34176-301f-4661-9462-08ddbe74e47e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 23:12:21.5091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vfC9ifdbToh9s5z41uDq0/2G97VWx+BxpRRUxf13vaSmbCSBU4d3gYb3KsgE+gINEtkJxmfnDj8b2twmsmrFcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB5955
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE5NCBTYWx0ZWRfXxFxKklf085Yf Tl8nE9mFliI2SYN99ZGvQvF48rus3Qe5GMpnAGr4NxSbRge85grNWcJwxbvptkg0KHqVCOilL+X 22jiPPlxON3R6yiZ6FoU/+589Uwb849PaQ6lCYwdnT3Y3OOCsFivLolchn3l+eO5wD/rOUMG23t
 4tO5bQugEk7Ec9Gxl7IaIOXleliKho8jNJOy5JZEYtZ77bsD7ZK4kA4JeLeOd3uZh+BmX4ZpO5p aY6vEWOoh0/DnjYDFXTYx3NMJi22yMnnROk7Y9qyiisimRmNJiFByee5ymWDOMqb7jZPbGNjXdy 4YlTi3/NIos5sr1xSm9i7rKnN/g1X3LUeCD5x552Lc2XAh6oF1qaMGvDzeFnCubngXimawobyvb
 qI3WaP6s6kbwukYy0MMt/zEw93YuRbJttV9PP70aAp4CcUrNyrNu5a9p75+cAHEB4gQ/sXoB
X-Authority-Analysis: v=2.4 cv=XYeJzJ55 c=1 sm=1 tr=0 ts=686da5d9 cx=c_pps a=p9nDpOBbYeOQlBo6D++p1g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Wb1JkmetP80A:10 a=2OjVGFKQAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=P8mRVJMrAAAA:8 a=jZVsG21pAAAA:8 a=pGLkceISAAAA:8 a=HIkRHv22IzgQaDaoNNEA:9 a=wPNLvfGTeEIA:10 a=IYbNqeBGBecwsX3Swn6O:22 a=Vc1QvrjMcIoGonisw6Ob:22 a=3Sh2lD0sZASs_lUdrUhf:22
X-Proofpoint-ORIG-GUID: Gl6CTqEUQujzWP_6cjM5L2k-gn_Kumq1
X-Proofpoint-GUID: -K5Ng_CxkSKaDw5g1FrUoFFRPkzvs8nm
Subject: RE: [PATCH iproute2-next v1 1/1] iproute: Extend bonding's "arp_ip_target"
 parameter to add vlan tags.
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_06,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080194

=0A=
=0A=
=0A=
________________________________________=0A=
From: Jay Vosburgh <jv@jvosburgh.net>=0A=
Sent: Tuesday, July 8, 2025 9:51 AM=0A=
To: David Wilder=0A=
Cc: netdev@vger.kernel.org; pradeeps@linux.vnet.ibm.com; Pradeep Satyanaray=
ana; i.maximets@ovn.org; Adrian Moreno Zapata; Hangbin Liu; stephen@network=
plumber.org; dsahern@gmail.com=0A=
Subject: [EXTERNAL] Re: [PATCH iproute2-next v1 1/1] iproute: Extend bondin=
g's "arp_ip_target" parameter to add vlan tags.=0A=
=0A=
=0A=
>>This change extends the "arp_ip_target" parameter format to allow for=0A=
>>a list of vlan tags to be included for each arp target.=0A=
>>=0A=
>>The new format for arp_ip_target is:=0A=
>>arp_ip_target=3Dipv4-address[vlan-tag\...],...=0A=
>>=0A=
>>Examples:=0A=
>>arp_ip_target=3D10.0.0.1[10]=0A=
>>arp_ip_target=3D10.0.0.1[100/200]=0A=
>>=0A=
>>Signed-off-by: David Wilder <wilder@us.ibm.com>=0A=
>>---=0A=
>> ip/iplink_bond.c | 62 +++++++++++++++++++++++++++++++++++++++++++++---=
=0A=
>> 1 file changed, 59 insertions(+), 3 deletions(-)=0A=
>>=0A=
>>diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c=0A=
>>index 19af67d0..bb0b6e84 100644=0A=
>>--- a/ip/iplink_bond.c=0A=
>>+++ b/ip/iplink_bond.c=0A=
>>@@ -173,6 +173,45 @@ static void explain(void)=0A=
>>       print_explain(stderr);=0A=
>> }=0A=
>>=0A=
>>+#define BOND_VLAN_PROTO_NONE htons(0xffff)=0A=
>>+=0A=
>>+struct bond_vlan_tag {=0A=
>>+      __be16  vlan_proto;=0A=
>>+      __be16  vlan_id;=0A=
>>+};=0A=
>>+=0A=
>>+static inline struct bond_vlan_tag *bond_vlan_tags_parse(char *vlan_list=
, int level, int *size)=0A=
>>+{=0A=
>>+      struct bond_vlan_tag *tags =3D NULL;=0A=
>>+      char *vlan;=0A=
>>+      int n;=0A=
>>+=0A=
>>+      if (!vlan_list || strlen(vlan_list) =3D=3D 0) {=0A=
>>+              tags =3D calloc(level + 1, sizeof(*tags));=0A=
>>+              *size =3D (level + 1) * (sizeof(*tags));=0A=
>>+              if (tags)=0A=
>>+                      tags[level].vlan_proto =3D BOND_VLAN_PROTO_NONE;=
=0A=
>>+              return tags;=0A=
>>+      }=0A=
>>+=0A=
>>+      for (vlan =3D strsep(&vlan_list, "/"); (vlan !=3D 0); level++) {=
=0A=
>>+              tags =3D bond_vlan_tags_parse(vlan_list, level + 1, size);=
=0A=
>>+              if (!tags)=0A=
>>+                      continue;=0A=
>>+=0A=
>>+              tags[level].vlan_proto =3D htons(ETH_P_8021Q);=0A=
>>+              n =3D sscanf(vlan, "%hu", &(tags[level].vlan_id));=0A=
>>+=0A=
>>+              if (n !=3D 1 || tags[level].vlan_id < 1 ||=0A=
>>+                  tags[level].vlan_id > 4094)=0A=
>>+                      return NULL;=0A=
>>+=0A=
>>+              return tags;=0A=
>>+      }=0A=
>>+=0A=
>>+      return NULL;=0A=
>>+}=0A=
>>+=0A=
>> static int bond_parse_opt(struct link_util *lu, int argc, char **argv,=
=0A=
>>                         struct nlmsghdr *n)=0A=
>> {=0A=
>>@@ -239,12 +278,29 @@ static int bond_parse_opt(struct link_util *lu, int=
 argc, char **argv,=0A=
>>                               NEXT_ARG();=0A=
>>                               char *targets =3D strdupa(*argv);=0A=
>>                               char *target =3D strtok(targets, ",");=0A=
>>-                              int i;=0A=
>>+                              struct bond_vlan_tag *tags;=0A=
>>+                              int size, i;=0A=
>>=0A=
>>                               for (i =3D 0; target && i < BOND_MAX_ARP_T=
ARGETS; i++) {=0A=
>>-                                      __u32 addr =3D get_addr32(target);=
=0A=
>>+                                      struct Data {=0A=
>>+                                              __u32 addr;=0A=
>>+                                              struct bond_vlan_tag vlans=
[];=0A=
>>+                                      } data;=0A=
>>+                                      char *vlan_list, *dup;=0A=
>>+=0A=
>>+                                      dup =3D strdupa(target);=0A=
>>+                                      data.addr =3D get_addr32(strsep(&d=
up, "["));=0A=
>>+                                      vlan_list =3D strsep(&dup, "]");=
=0A=
>>+=0A=
>>+                                      if (vlan_list) {=0A=
>>+                                              tags =3D bond_vlan_tags_pa=
rse(vlan_list, 0, &size);=0A=
>>+                                              memcpy(&data.vlans, tags, =
size);=0A=
>>+                                              addattr_l(n, 1024, i, &dat=
a,=0A=
>>+                                                        sizeof(data.addr=
)+size);=0A=
>>+                                      } else {=0A=
>>+                                              addattr32(n, 1024, i, data=
.addr);=0A=
>>+                                      }=0A=
>>=0A=
>>-                                      addattr32(n, 1024, i, addr);=0A=
=0A=
Answering your last question first,  IFLA_BOND_ARP_IP_TARGET was=0A=
already NLA_NESTED (see: bond_netlink.c).=0A=
=0A=
>=0A=
>        Another question occurred to me: is this method for sending the=0A=
>VLAN tags going to break compatibility?  New versions of iproute2 need=0A=
>to work on older kernels, so we can't simply change existing APIs in=0A=
>ways that require a lockstep change of iproute versions (going either=0A=
>forwards or backwards).=0A=
=0A=
I manage to preserve compatibility forward and backward.  Both a new=0A=
kernel and old kernel will work with both an new and old iproute2.=0A=
=0A=
>        The above looks like it changes the structure being conveyed=0A=
>into the kernel, which I don't think we can do.  In the kernel, the old=0A=
>API will need to continue to function, and therefore the new "with VLAN=0A=
>tag" case will need to use a new API.=0A=
=0A=
I thought adding a new API was what we wanted to avoid. But a new API=0A=
is unnecessary as I am extending the existing one in such a way to not=0A=
break the original api.=0A=
=0A=
The original code sent 4 bytes of data (the 32bit ip address) in each neste=
d=0A=
entry.  The new code sends the same 4 bytes containing the ip address.=0A=
If a list of tags has been included the data is appended to the 4byte addre=
ss.=0A=
Type NLA_NESTED has no fixed data size.  If no vlans are supplied then the=
=0A=
data sent to the kernel looks exactly the same as with the old iproute2.=0A=
Therefor a new kernel will continue to work with the old iproute2 command,=
=0A=
you just cant add vlan tags until you upgrade iproute2.=0A=
=0A=
An old kernel will continue to work with a new iproute2. The kernel will be=
=0A=
sent the same 4Byte address in each nested entry.  If you try to add a list=
=0A=
of vlan tags the kernel ignores the extra data.=0A=
=0A=
I tested the various combinations.=0A=
=0A=
>=0A=
>        The existing IFLA_BOND_ARP_IP_TARGET type doesn't use nested=0A=
>netlink types, it just sends binary data, so I'm thinking we can't just=0A=
>change that binary data, and would need a new IFLA_BOND_ type.=0A=
>=0A=
>        -J=0A=
>=0A=
>>                                       target =3D strtok(NULL, ",");=0A=
>>                               }=0A=
>>                               addattr_nest_end(n, nest);=0A=
>>--=0A=
>>2.43.5=0A=
>>=0A=
>=0A=
>---=0A=
>        -Jay Vosburgh, jv@jvosburgh.net=0A=
=0A=
David Wilder  wilder@us.ibm.com=

