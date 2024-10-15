Return-Path: <netdev+bounces-135745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C863B99F0D0
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EADF41C2164F
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 15:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C6B1AF0D9;
	Tue, 15 Oct 2024 15:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="WiUGrOxG"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2053.outbound.protection.outlook.com [40.107.104.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131161CBA0E
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729005294; cv=fail; b=duB/P91xeCD/ikMKSogQwX5XlLrs8mq38HXrjWCbAZgds/N/Z4HohOfQ7ibmGkNNie2OFT/sWautR7flIVpjrRBv6oGZ3askyLxJ05x/+O2ti2FHRrjxEV6bIMHL2Mp61VmTpvleWMw3K1HJumIAzivbEaQmw2WnV1T/Y46Ir4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729005294; c=relaxed/simple;
	bh=U2PWtu8RPA4wtPVAERfJ3qgyH5PuaGtA7Ddd7n6zglk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bW7SS3i3J7OjDg0+MkyUQ0ml2Xm/LUWy/zkTDpKLszy+uqcHrU5GvrEcvj63x1TxER1BIeFeJwQe28zPVzz7gUkc9WJVG8vLTgA4tsE1rWULDdqqkPImBTRvCC49D45ht2JeezMxk03j4EWJw2e9rQPXL3cY/sw6s4v4hkZCCbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=WiUGrOxG; arc=fail smtp.client-ip=40.107.104.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ess1lz/vX5rmJmu/uYHLIef/v4x878ZH2Ydy6drwD0RTrURlGC373PPwQjfz+deWyZP9T8ppcX+6EAbmKqm2LBkEC3JZ7MdNEPx/cymuQUTHFdhtHTzrJG8hc+XBoRiumA01a7tYdtofcPODk/XihygPH4D8rLvR0WiQwNkr1eO0HKS0cO1sT4op1NWPDrSNiJCDn8DeGwFzlgWdmFMSrG8Q7wzcU/ld6+/t1kqUYMd3uWYY06B+X6oONqzOynVpmB3hWmO6uIAIGgW5/pX7I9GBmAs223rKeQKgGutc57nThvbY7uokYT7NaCPz6J75rsHoPZg2mvJqQxwEo+5tow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcYgSOMQs9AdMsrZKRt2GHukkXBATTy1rdWhz67+XqA=;
 b=QEp7IzfkssZDuzTc0xMKuwOsaZfqyDE/+Mkh9tuBZTPZwRlNiRzDk6F8cY6rWZxsYn5JjT5g9yHxpSFHCiWp1MHrLYUO1lAnSHz3K0L4AmiUImDAavBtumC+1HdKz4ozJsX+xS+6NWKy/38vW/lc/xG7lR8FdksF8dWzzn72+qZe3AY+amxBB3JGHWxpSY47mgi+hVjWYfGDWgC5vu4N4nORZUwiHU8adWXjdnm4gL4i6zsGoTWXopbR8QDmY1cjCqDeAVvUpQIPHZ/D+lk/N6AvuitgMsVjJjDhXNI09qq/pIhluxj3lUHgtdkjn7ftuhXhI0GCLxUSEyQxDL0/Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcYgSOMQs9AdMsrZKRt2GHukkXBATTy1rdWhz67+XqA=;
 b=WiUGrOxGOeZepJEy4684AHRSLSPOhgUyqrzY0wizsr+PL/MTb+tWDhEqqUbuAfBtlq9GZvKBeTgLdK9AAFB7yh0DbebKjH1zDciCszV0tURWAZ+4cfybhiQ4OEvskP1NNq4h/z5fj2mgH8HMWC50ZqI7ZU8mQqHZdU40uRgAgytGsNb2+8If7j9sZlGQktYyKC4fTdB+5AhVyfD4ADS8JSncRk3wkPb3qK2NtkhYqNufdL2L6HC3vaZGj2Ay9oM7kysAhv7FwLaZ5/W2I4+FDDN+wboP0edQuaCI6KbrzS8L+VUk60A9hGR0Ah7d72/DE4T5q2IYww5Qh9xH8HKihA==
Received: from AM6PR07MB4456.eurprd07.prod.outlook.com (2603:10a6:20b:17::31)
 by AS8PR07MB9067.eurprd07.prod.outlook.com (2603:10a6:20b:56a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 15:14:48 +0000
Received: from AM6PR07MB4456.eurprd07.prod.outlook.com
 ([fe80::9dad:9692:c2c3:1598]) by AM6PR07MB4456.eurprd07.prod.outlook.com
 ([fe80::9dad:9692:c2c3:1598%3]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 15:14:47 +0000
From: "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>
To: Paolo Abeni <pabeni@redhat.com>, "Chia-Yu Chang (Nokia)"
	<chia-yu.chang@nokia-bell-labs.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>, "g.white@CableLabs.com"
	<g.white@CableLabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: RE: [PATCH net-next 00/44] DualPI2, Accurate ECN, TCP Prague patch
 series
Thread-Topic: [PATCH net-next 00/44] DualPI2, Accurate ECN, TCP Prague patch
 series
Thread-Index: AQHbHu00ySsDutkGnkCwKJY/4IVq1bKHonIAgAAt3wA=
Date: Tue, 15 Oct 2024 15:14:47 +0000
Message-ID:
 <AM6PR07MB4456BDCF0928403D0E598F9BB9452@AM6PR07MB4456.eurprd07.prod.outlook.com>
References: <20241015102940.26157-1-chia-yu.chang@nokia-bell-labs.com>
 <dc3db616-1f97-4599-8a77-7c9022b7133c@redhat.com>
In-Reply-To: <dc3db616-1f97-4599-8a77-7c9022b7133c@redhat.com>
Accept-Language: nl-BE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR07MB4456:EE_|AS8PR07MB9067:EE_
x-ms-office365-filtering-correlation-id: 2fc94c36-2744-4c9c-6c26-08dced2c1b68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|10070799003|366016|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?oZSvkJgwOLjLGQioFk36TLVoENG+JwNQFdoSn/HnOBvSM4VAh+Az/gwMbg+3?=
 =?us-ascii?Q?o0bQLHHWIAjKzn/j6W43R3cPbQNB5SbzAofRW2o2xwS8hm8Gye9G2euG97kh?=
 =?us-ascii?Q?HPhq/8tBrDX/kCEfYPHCQCC3wm/4Als3c3EHIrcc1obh8tL6PkENbpAYoCyT?=
 =?us-ascii?Q?FSldgo//YhBw1We30ZpaMtS3jh3qfTiBx+mm/enAdccYY4HsnxixFeXl1hIO?=
 =?us-ascii?Q?Bo2pOs9IuUA0kYigyrwisPcjjBhWypvYBabWgPh1W3g9IyimwJpJ9Ud5Rhdv?=
 =?us-ascii?Q?lD2/QoU7r3QYO82TV+CWDKLmygMQR2dUzzfQVNXGBvASgofwvmnupoMa8ej2?=
 =?us-ascii?Q?704YcVlcPz4DiQI9a6SIT+czWDCDSB1AAWEZvdUNLOcwalwKyabLHfmda7Up?=
 =?us-ascii?Q?EHL+AU0oCLwCq2PxEtfKGAh87z1TQhAuhxnM4DXfwyadl6glI+JFQM3Kr8j5?=
 =?us-ascii?Q?3nQNDIcJrOFTWev43mDUgjT2hY4/qYL09Q9k5O5RYgkG3ZWvJD8ay19rjJib?=
 =?us-ascii?Q?26I7TFm+xkIscSfN8aBkbRUb4dtXkqYhJENHLK2wf0UPEZ8wOwcvYnGhYRzS?=
 =?us-ascii?Q?tST06LaV0D2eLtRm4CMPh+VUpsRyiFhsm1iOuknq4tzZ4wU2HzMMH+WDXKqn?=
 =?us-ascii?Q?6VmRR62dN/tHVkjfpk3l9xaK9fkcTvBLlUP6OqWdCR63zmWpCJKWPiOyiqJz?=
 =?us-ascii?Q?UoRpYrehTGHI75b6BVsoyTkY1h68qyQtfl4r0zfBV5XwjLnQutOCuPsxSyWf?=
 =?us-ascii?Q?R2tJH4nebpSlrluV1VWUmWpn35DE1ZfQHrpXJmrnWozd4XnJytIbjgeXn7wq?=
 =?us-ascii?Q?Tjr4Z0YXrHhMGwW3teSPNhshw1MhaX799cTvOA6VkPiWYq7f8LN9qG3U4DkI?=
 =?us-ascii?Q?UDCxfGG5pBMu1hhMBmA0YJOSn/yQu+WjBjY1CIVYJqUteUVFNWkbS0Q+4FxA?=
 =?us-ascii?Q?6pjQhuKjZjdBHEMlUUjiqVDIm3iWPGn+d5Pa2C16vZRO8lwDvFcVuReEskkK?=
 =?us-ascii?Q?2G91IlpqCJZEbbKqOGPAJl3sPSVocwsnZtl/CqAs0jmCkUX5YuWM0U2vgyPR?=
 =?us-ascii?Q?oVf0rWW08cEmESornHSvAcO+yQ5+Q+QoIwMRId3bjtsiLOUAcB/bm2s7wfet?=
 =?us-ascii?Q?4Gp/Eg8tmIZeBW4ams1bMzVJU8ezOc/2UAB7TrGtffANIb6V3FsZffv9csfl?=
 =?us-ascii?Q?R97BtG4BXBANLGlcR0RAcGJBZrc1RWfty35wzMep4ftHuh2652zo2PtnADt2?=
 =?us-ascii?Q?8yO5Gh8rCsWq4XO1ZTmiicwITR12m4llDDPLS8xOshoUaPBGxQvnzPwaBtlT?=
 =?us-ascii?Q?n7g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR07MB4456.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vTvDl8J2xP3UjhA0emfZArTV3aLyZj/qZyk/+CpCn7M01rpYFf3EEttgYBqG?=
 =?us-ascii?Q?7Oll12/fckQEODwq6w/5G84x/EAcZo7Wv8vwCP+l6CFj+MCmgzKUu4OJwnuU?=
 =?us-ascii?Q?bs3ECNoz4kVejLyL7l183lpaspb/JX0RYZMhwt4e4JhXoRNn/xh9OYCnG9UE?=
 =?us-ascii?Q?Poy8grpYN06ldMjn+AO6UhOZqhamZQHFxgRbXZ+VBu/oXj6YA/PxyAewqqBN?=
 =?us-ascii?Q?OkajVjBKegyl9+RpfXZz4wpzQtq+KUzteP1ZXcbU7SHR/jOaOA7BnztvnJ0/?=
 =?us-ascii?Q?2fTHcU3CsTRx0N6AdPGZTnySmVS1aVEFMHxigW58mnjzlyJ2Koq4H1nX5KdK?=
 =?us-ascii?Q?B54hm/Cv1u7Keh68PnMSRiyI2cRENw021aZoxwZzr1Tb3APuTAEpogkCIxME?=
 =?us-ascii?Q?0G1baps7A2/QMDMiVhPjc3yQHoFXT+D2BdUWBNfhud36aX004rQyQKdhZo5l?=
 =?us-ascii?Q?mTAliWSu4tG0FaLDUoQ5wYs6WLHmWUONdV1l72pOjrAUg2puwLJ/4lUAQMYy?=
 =?us-ascii?Q?miwcABKG1BjZlliEp1uZRoqTZfo0WSXoDz2ELKZ2j67zTJRhBzi61alYpQcw?=
 =?us-ascii?Q?Iln0QdNseKBFBr0uphorIabJup21M2+BjMpagqjblN2kVELx9/hqTffDl1sW?=
 =?us-ascii?Q?iZP9hJ+nNJqX6xwPzrwe+gWSogijeWgItEgQGxzAqIkYJtnKJj+iCx22yawl?=
 =?us-ascii?Q?BbCs0qrTA/kzC+VFdGrojURVrwZ+eKjd+WGYucbKLeks8z4ICXT85NHdySsS?=
 =?us-ascii?Q?lp/ciFZXBJZ3aiCrtc1Sf6ikbJERfUIZBkUdz4Apwi8VYGPdp7YEJYLsBV9u?=
 =?us-ascii?Q?nh2ct3BIXLw41a2GMKFJLLTOaHn5FHjNy83WPhmRtjFaEanTvGPL7NqlRajq?=
 =?us-ascii?Q?MDmG0POFknGnHfuWfcHzHfLtnDZrVpb73MxpCeE07JkdI2osNKIpbs5mPq4h?=
 =?us-ascii?Q?vryCDu3ahtCmwm9kUzyOkTky8TUNqvOaVuzKRFVBJUgVjUMJ8CMeoA9pJOSJ?=
 =?us-ascii?Q?cVGYYWJ21XoyGL3+Y0FIQ2urM0QQs2B4gYNPrcBBBPNk1nBI3jeczlMVWS4E?=
 =?us-ascii?Q?yG5Hqh7tMPt5sV0fiV6ly6HvXB7GwBNrXx7u7USQ3B+UrPEqEQWveVDpnnOy?=
 =?us-ascii?Q?QFzoXRZ/oAq8CSkwGnmgR8O2gic3Y4k8XeWHMGbuvjvMlDd3oXZiT6D4qvH9?=
 =?us-ascii?Q?JovREVzNbbmjABtOUvvPPfyZWcLjpOcZwIpkessX/o/li3NMWUDbL0YvTINt?=
 =?us-ascii?Q?GKByNJxfzL5E7M636VyK5+ATziNlC3p4K7+Zbj+aMQJeLdxJNlu0S2Qj2+Ts?=
 =?us-ascii?Q?PuLvt8x1Jx8SH3M0I/xlr+K/twbuIzThRlUj3KioTjSfbiORWkq0CWre2ZkI?=
 =?us-ascii?Q?5dk+0Q6oU4uBccXhto90XuwbwSttwK4pyG3YALcUvuLmBXQx5huMjYVt1577?=
 =?us-ascii?Q?Bz2trINhF1FzlmZoxDHsWY/OKL0glAPogX6YHNICFeERpFReiyT31gsE5G+t?=
 =?us-ascii?Q?MreEbFRVuY9gANlD+qj8WK5XnYghA4lYv80PffW+KgPUtj//OaHRSFQRAHAt?=
 =?us-ascii?Q?MorWFvoHEh7ArokEME2qSgizlJvt5uDe/g2JoJXhGF7HIMGJZAIfn+uUYrPE?=
 =?us-ascii?Q?9qdl9pG8N4S9IbvD3Eh1r1JGeOmB4vgcXczowi7IUsAJTR6hTXS/nxXowyvV?=
 =?us-ascii?Q?6Mtf1DyTYapo6RqbvuAMNC30X0I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR07MB4456.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc94c36-2744-4c9c-6c26-08dced2c1b68
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 15:14:47.3398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1D1bIwgNtF12uggN3hb5mSDGepifB8VcAYNfXja4S9AW/oFCeW/OKGmdq0RwcAZUlw8JcLy/N7inn/Rvzt6J+zNDo28a55whSkl2OtFPvkiaYoyLybG66R7uJTF/GQtl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9067

We had several internal review rounds, that were specifically making sure i=
t is in line with the processes/guidelines you are referring to.

DualPI2 and TCP-Prague are new modules mostly in a separate file. ACC_ECN u=
nfortunately involves quite some changes in different files with different =
functionalities and were split into manageable smaller incremental chunks a=
ccording to the guidelines, ending up in 40 patches. Good thing is that the=
y are small and should be easily processable. It could be split in these 3 =
features, but would still involve all the ACC_ECN as preferably one patch s=
et. On top of that the 3 TCP-Prague patches rely on the 40 ACC_ECN, so pref=
erably we keep them together too...

The 3 functions are used and tested in many kernels. Initial development st=
arted from 3.16 to 4.x, 5.x and recently also in the 6.x kernels. So, the c=
ode should be pretty mature (at least from a functionality and stability po=
int of view).

Koen.

-----Original Message-----
From: Paolo Abeni <pabeni@redhat.com>
Sent: Tuesday, October 15, 2024 12:51 PM
To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; netdev@vger.=
kernel.org; ij@kernel.org; ncardwell@google.com; Koen De Schepper (Nokia) <=
koen.de_schepper@nokia-bell-labs.com>; g.white@CableLabs.com; ingemar.s.joh=
ansson@ericsson.com; mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs.=
ietf@gmx.at; Jason_Livingood@comcast.com; vidhi_goel@apple.com
Subject: Re: [PATCH net-next 00/44] DualPI2, Accurate ECN, TCP Prague patch=
 series


CAUTION: This is an external email. Please be very careful when clicking li=
nks or opening attachments. See the URL nok.it/ext for additional informati=
on.



On 10/15/24 12:28, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Hello,
>
> Please find the enclosed patch series covering the L4S (Low Latency,
> Low Loss, and Scalable Throughput) as outlined in IETF RFC9330:
> https://datatracker.ietf.org/doc/html/rfc9330
>
> * 1 patch for DualPI2 (cf. IETF RFC9332
>    https://datatracker.ietf.org/doc/html/rfc9332)
> * 40 pataches for Accurate ECN (It implements the AccECN protocol
>    in terms of negotiation, feedback, and compliance requirements:
>
> https://datatracker.ietf.org/doc/html/draft-ietf-tcpm-accurate-ecn-28)
> * 3 patches for TCP Prague (It implements the performance and safety
>    requirements listed in Appendix A of IETF RFC9331:
>    https://datatracker.ietf.org/doc/html/rfc9331)
>
> Best regagrds,
> Chia-Yu

I haven't looked into the series yet, and I doubt I'll be able to do that a=
nytime soon, but you must have a good read of the netdev process before any=
 other action, specifically:

https://elixir.bootlin.com/linux/v6.11.3/source/Documentation/process/maint=
ainer-netdev.rst#L351

and

https://elixir.bootlin.com/linux/v6.11.3/source/Documentation/process/maint=
ainer-netdev.rst#L15

Just to be clear: splitting the series into 3 and posting all of them toget=
her will not be good either.

Thanks,

Paolo


