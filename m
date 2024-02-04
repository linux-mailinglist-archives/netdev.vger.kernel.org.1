Return-Path: <netdev+bounces-68948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EC4848EF2
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 16:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 493D6B20992
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 15:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E13822EF4;
	Sun,  4 Feb 2024 15:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dektech.com.au header.i=@dektech.com.au header.b="ZHdqtsan"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2114.outbound.protection.outlook.com [40.107.22.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AB5225CE
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707060859; cv=fail; b=mTdvc2KyT7gU32+X2kL9qCD8Nhn3EogjQPWSxkAg+gnXTXUISHoT+vvR+rsL7xgIKbV42vbjldHnTjA0XfoI+8Tj5VFCz5QlTMtVcocywuC4si13gsvVajR0X7MELg5bT6At5pP0oIkZQjW3gUyT7/UxS/uLL82nP52u1/LpfgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707060859; c=relaxed/simple;
	bh=w/t5Dh0JJR4xFhNidGip8lH5m7h6e7lnet7kSuKrJeM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hygmiS5XXZAk31S+Kofyt1XIWUqfLN2oPlhq1GQsUD+kHwcF8OEWdiRpTm7NNwlPRP4eCvnyT2FN7hljhpmR84w8t+gfdHNM93Thh4lNkpVEUeYAjaocpmmz6ZSYo5qOrx2ABWaHQW0BjoEYjrrbEuB82NnK4fmLyD1E+7zFp0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dektech.com.au; spf=pass smtp.mailfrom=dektech.com.au; dkim=pass (2048-bit key) header.d=dektech.com.au header.i=@dektech.com.au header.b=ZHdqtsan; arc=fail smtp.client-ip=40.107.22.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dektech.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dektech.com.au
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yw1omgf4rdMo4iFgO4MIdvRDJqf2+dTBYtwTZUiIdw8Yri8wLOeHnb1zyA1ctMpo30zMa16LRHacavyliQBZqkNt8snKLpZrzprd2vP0Xa1lQmp4bK/ASipKSZfZwgt2UC+zfW4TUCku66Wg4q3GS1s6GJRhBkufRB+R8z1mS/lowNniap+ez3xsBLWSTmbcAVOEaKpDdzh2JdtXrDO4o1AOuE7HljlTNbSDj2MfBT4pvpbUYsTulTxzPaDuaUvAqG8Zwga7oGbzfylVJdKwIMw8huJ/LGsdImhm5PbM+v/9AYIXXjzvxCogjky1hPyoq56ME4YWCAhp8hFxDIn2QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvX8DN7tcaCBOCNn0ibZk5XBDBHUTMyl4clCVcWJZJc=;
 b=O5ZbSPs8yaX05BsRPrlxuyABGMi7Tl49iMxsry4oYqijU6Gi93BSfoZpmC6y/YPsNV+gpBAcHJSSEeC8F5insBzMs+m7nl3YT0d09dc/aicvEJ0BqYZx7UvhTVO+ZLE3RuZ6puWduRHCld6N7HCibdw4xfxBn4sCPGGi4ZnGUTJXcCF/oYQC959GYTGbmW9Q6xjZ6lBCZnaYrmJNonTdccs4IyKXj7q0h5ujdd8aH6qnJ/uBgSTxhAIxf4BruiaVCQFqkLuilNe6M7k15wTNGB6qZc0hwDHMM3vdRbI6H54qfnbm30igmEcKjpEEwczrSxLZxokPFY5Z5Li6i8fHsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dektech.com.au; dmarc=pass action=none
 header.from=dektech.com.au; dkim=pass header.d=dektech.com.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dektech.com.au;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvX8DN7tcaCBOCNn0ibZk5XBDBHUTMyl4clCVcWJZJc=;
 b=ZHdqtsanbdDdEpDHGaEt+/YIMk5UPoMTTIY3EMwkCSadJkonI7j9qMK24Dbfr/F4HBps/yDh5GNbrKWzsqyM7KqGLuvdeatgcBO3+l7ZP9ZcX+yJyqhtIu44IJ80QRKGQMstRLyeVHNqhsjb02axqtC7g+4cmCAkLoN4noVLUSnFlX9Ysdw592xvC9TIMU1Ef+AIaZZzJ/VWJKQ+Bh5ed9cLwvx7lIIn3m3fUdtPmjADfgdG2xabV78HpCgGKs4OJZNdWdZjaZPztBfeCOXKJHT6z5va25HooIpOecEx8h5JKBq5+6p/oe7X7Vh4l04NSC4ULvW7zhq3fN7dAp+j2Q==
Received: from AS4PR05MB9647.eurprd05.prod.outlook.com (2603:10a6:20b:4ce::15)
 by PR3PR05MB7420.eurprd05.prod.outlook.com (2603:10a6:102:86::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.33; Sun, 4 Feb
 2024 15:34:14 +0000
Received: from AS4PR05MB9647.eurprd05.prod.outlook.com
 ([fe80::209f:43fa:8733:2ca1]) by AS4PR05MB9647.eurprd05.prod.outlook.com
 ([fe80::209f:43fa:8733:2ca1%3]) with mapi id 15.20.7249.032; Sun, 4 Feb 2024
 15:34:14 +0000
From: Tung Quang Nguyen <tung.q.nguyen@dektech.com.au>
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Jon Maloy <jmaloy@redhat.com>
Subject: RE: [PATCH net-next] tipc: rename the module name diag to tipc_diag
Thread-Topic: [PATCH net-next] tipc: rename the module name diag to tipc_diag
Thread-Index: AQHaVhP/UZDclp7FbECwbfoBOtGNPrD6Ut6Q
Date: Sun, 4 Feb 2024 15:34:14 +0000
Message-ID:
 <AS4PR05MB9647DD6EA378CFA630CB44E888402@AS4PR05MB9647.eurprd05.prod.outlook.com>
References:
 <d909edeef072da1810bd5869fdbbfe84411efdb2.1706904669.git.lucien.xin@gmail.com>
In-Reply-To:
 <d909edeef072da1810bd5869fdbbfe84411efdb2.1706904669.git.lucien.xin@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dektech.com.au;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR05MB9647:EE_|PR3PR05MB7420:EE_
x-ms-office365-filtering-correlation-id: d0ef36ca-291b-4047-8d79-08dc2596bdff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 R/i/TcSibNqaW4tIomC/jyaTazIN+EcQJeBZpzktfHb7ysP8VdL1sz+H4jgn4sQQEXislgEo5KZEdDZSG78AfoHM1f84zpTAa+bzSV1bLxNU1pXN7Q0MhCG3nJuP6EzZBwKSVB6fThfWQlsnxI1ckoXifcOVOzvolIfjmKplwltm/8y1r1MhCgpLQVFksk3aquof50CKAe4PkG+4y0y7XoftFIQhvSUnQE6c1e+eMZwlWKdampVh0GqePx7qZMrzm7hAGlSwGFqPCcYcUfM6yiAw9gbIUFotVzxWWiZSNht4mURYie5uoT0d1HfUYM7RFQQXGJEwRDNNuLjDeRVh6IXzT4Hvp81jguWkS1PbjjzsuHR6jWTxCIdkPQrvbvei888kv9crtyNkBtJ+O1Y6XVoqJ83s/7BzgF5lvo4BC45K2yow+b1AWTxDqE4UpulgV0NO+zofzdQ47kGRhV2H3gbPPXQQEsx+PmeK1JdaI5N/PdYPjlREwZcJi5nF7VopdnC46OoX//lioeIOFnqCtdN4c5n+BaJDf1pdtXBqi/f6tFtnhYYZdhWJyoal4g7APQGtMG8zweBGHyx+AVhKBkAIPuR1Pbgar9g04FaWpTy7dG2XeqpoJIEOTXKzKT6G
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR05MB9647.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(396003)(136003)(366004)(376002)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(26005)(83380400001)(41300700001)(38100700002)(5660300002)(110136005)(8936002)(54906003)(64756008)(8676002)(2906002)(66476007)(66946007)(316002)(4326008)(7696005)(4744005)(66446008)(52536014)(122000001)(76116006)(66556008)(71200400001)(6506007)(86362001)(478600001)(9686003)(38070700009)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mnAccCAWIGwWGzCH5MhI528MhBUUDR9VLJB227r2P6PTJtYXL1CKwUWZnoLG?=
 =?us-ascii?Q?ypqo8tOBM9tAy4x0F6j6s1H0z+fJb8NRu0G+URyL6aAT96z/SE7KOaqG39fK?=
 =?us-ascii?Q?+MF4XWW3Dr5q5oZP0xo5aLf3Rx2uXhkAyTMCGnttRbChd/nwiVmrvLziNQn1?=
 =?us-ascii?Q?SN2TX+tXvPR+bpoA1OfzqhzIzcdmB7wri+rj30MrOhRGY6rJoqGDL9ILGqHG?=
 =?us-ascii?Q?NsGQWorADInFJFPjKC4CGmLQuBrXh/IavHDwf2uHI/A/6Mi3H0hV1uubGyUc?=
 =?us-ascii?Q?YmvS1AMThudHMNL4rsyBuoM381V7l53deOLfb4hwTGozoQEWfQBjlquB0AmZ?=
 =?us-ascii?Q?iDiS5VQqn+/o/f5vzPYR+KvQtSoCvsHxa/ag3BzEf6H7IO/78sp2z5kccqUG?=
 =?us-ascii?Q?j3khYJk+G2ItYnwtGudNv3fO3Pm0TWhMBOcB6KGHIVrttEC44Oqfa3aTSIKd?=
 =?us-ascii?Q?K9ojQKiaZSlpQVwkTTMCDIdRpixm1A8gAra7+YXaMee8HRXlioU9pMMh/7Fs?=
 =?us-ascii?Q?4k63qFilEhirfYRDtdFqNU0b58n9yKfaE5pN1oTZ0Ei8PtYpsgXIjyQqtEVB?=
 =?us-ascii?Q?+/2qXytvDPtQ44OFo9WaNYu2Myaa23X2HDUqeIp96w2nnBqp7i7GxCiWH44E?=
 =?us-ascii?Q?g6X4KF5aZsyOOFzvWTs/GSp1auF/++SSxF9mqjT/DAA7wb+KReDc7PwaaNox?=
 =?us-ascii?Q?pPndPLEWB4lyOXXiVvTvYRciUk6D5xb0UkXPzFBbO/6ejrmSflKjpq1tEzky?=
 =?us-ascii?Q?spl1pHtelgweX2jLZqIJjC9fuoMW5k7J571uG5J3lm0uydwEi53XcUF2qbvE?=
 =?us-ascii?Q?H/25jkVGuo6Cr7tQYw2v1pijb88pDpwjPt0gI1UXRPLLIzc0UGlKYXiMS6FU?=
 =?us-ascii?Q?OJJOvaI7Cgy/QOAiCKNUFkLWEN8WLc+8wlh3nvCTyOWnQ2qvKnwwfBZdIaCX?=
 =?us-ascii?Q?QWuvhW8tvLnzNi2wwsR8tK57o2MSQz2Pr0vqZiRiq22wnrjF92dMg6hAb77o?=
 =?us-ascii?Q?rAzTzr3FvOrzxfIEC0jNkZHfq9j1JeJbH4vSKKUB4P88Q3UaQzFbADYVlcmy?=
 =?us-ascii?Q?DAAzIoOEqP5DAaNAfKpvRRO9yVMGVnBkJl4WkQphm+4S89i4wcXkVHYV9MwC?=
 =?us-ascii?Q?YUdl0FbFFQFNrXwSgTg+tWH/4Pphq/ltj2Z1b9p4mMSSJRqU0ihYK8ww2Vd2?=
 =?us-ascii?Q?e3MLqt7Lg0bm1EnFp9Ebc1vVwjSwglTmKhIItSDwz7ISw2eHcS0imvvzeYTt?=
 =?us-ascii?Q?LoGMoeEkdNGcnriGuUxBg2dsZstV2zReR+mp8UYVk51Cv/j4hzW6JJ/aVVpy?=
 =?us-ascii?Q?JT7T7lB7c3H504maKJ0DxU+f3jWbqj9DwunFydhIdokaZh+MUwlBE+aS4krl?=
 =?us-ascii?Q?6zeFk9t0wnGzB2s4dbSily1eUF//tqcMPS4ftYw/LQA2NUE/RfRnuXuJnOLs?=
 =?us-ascii?Q?0HXEq4R6fuqsiCjsEUG2FuZdkqzdOaUynBmw+IkIGie5H2h9cXCg4IalBsPN?=
 =?us-ascii?Q?wfLnGUlMpF1oVpfhMiR0yQKijGRooWdrHk/tfO4P3u7roZ1twJrm6shSNeAV?=
 =?us-ascii?Q?M4UWVIFDast8tPaAR85OfivwwmP32BavZyaV87Ej?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: dektech.com.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR05MB9647.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ef36ca-291b-4047-8d79-08dc2596bdff
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2024 15:34:14.2231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1957ea50-0dd8-4360-8db0-c9530df996b2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5KLeWfvfmJLGBNjIKaHyl3DOF/IjlIM5GmPUWIFeMmIgJgP+6yJKbM1C4vK/HU1rTxzOehqxb8d7ZDhnMlRvLa5H40sNjWJoSnu7Q1CBQfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR05MB7420

> net/tipc/Makefile | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/net/tipc/Makefile b/net/tipc/Makefile index ee49a9f1dd4f..18e=
1636aa036 100644
>--- a/net/tipc/Makefile
>+++ b/net/tipc/Makefile
>@@ -18,5 +18,5 @@ tipc-$(CONFIG_TIPC_MEDIA_IB)	+=3D ib_media.o
> tipc-$(CONFIG_SYSCTL)		+=3D sysctl.o
> tipc-$(CONFIG_TIPC_CRYPTO)	+=3D crypto.o
>
>-
>-obj-$(CONFIG_TIPC_DIAG)	+=3D diag.o
>+obj-$(CONFIG_TIPC_DIAG)	+=3D tipc_diag.o
>+tipc_diag-y	+=3D diag.o
>--
>2.39.1
>
Reviewed-by: Tung Nguyen <tung.q.nguyen@dektech.com.au>

