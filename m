Return-Path: <netdev+bounces-18954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC5375936C
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 12:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00A7928174F
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 10:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E389C111AA;
	Wed, 19 Jul 2023 10:52:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6462107B6
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 10:52:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2121.outbound.protection.outlook.com [40.107.220.121])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9B0E5
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 03:52:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTGeKZq221k45BTPSCP8l0aU/78zCxVb4uVBALURVFsoKIkdlk6kPpn8BTGViXj3mLJCjw1DcXQn0gyxsatG3/XXMHtk2clgPGkj0uWr/sdPwY6h1hLmn6ItaWLPyDYya2/vDbAToUkCHW44+dtAuXd6AGVzQIgiJvcHoFs41rS1P6LXA4GxF3RUf9bBhwce1vfq7G0pPGrG21toJEd5+WrjRrlnWuRkfLTF5okC7MEiGPJ/zIXfBBqlNBQcnB9Q6SMhnaG5ZlIoY+kViEMdgdyLVP08jIG/xnuFNROyIyBUdvrK40MGjd2b31rV+KYwo9CNBtvvVsJTG88O8oQaYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBVWhiwbCzy9PrZmo84+LAnRPFhp4cR889RnSE2Pxh0=;
 b=laqWo5JkmVLnmVBMjvUSmBBOYUBUjRCFiGtSnMe0yHzcLmncERDZADJ2U+9ST0dhWS1iI4ZTrELU9xlxGaizQJQezLIs5qcASEVr/3MV8LGLjQ/FrNteY6I672FgoN963grG3oaooHVw+PBZtZuwo4Maq3kSg5CYUjcQuMo+UHb1w8emD41izec9eNAHkY4DgUfgCCJXMw8ZAjR6gnETeXYrvLwFZ2094s4S8NZwGe4xo7LFBdtKqfdqK7N3D5ncwWreXENLw2/MaYHh2RqVCseA7KHPyFTg5vreeTw3yIi1THnyJTGBLnkts+D5WVQAI4ZRJfkj1K2EtwUEZEcRRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBVWhiwbCzy9PrZmo84+LAnRPFhp4cR889RnSE2Pxh0=;
 b=de3qXVEGkcP/iECjpbE+/38cVhiMFJrXy28xyICjzjpN9rSq6GbdNAyjzbmP8oGSO/+82Wklu1p+hDCKJwus2Fx/0uB4uTZw8X5Hs/ZuifSnwPJGJEQxrBkeiUjb9SKKa3o8wFfugc52uYaC6iMzlyVgEYTA/T6Mp4fy2glG5QQ=
Received: from CH2PR13MB3702.namprd13.prod.outlook.com (2603:10b6:610:a1::20)
 by MN2PR13MB3629.namprd13.prod.outlook.com (2603:10b6:208:1e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Wed, 19 Jul
 2023 10:52:03 +0000
Received: from CH2PR13MB3702.namprd13.prod.outlook.com
 ([fe80::b55e:a0e2:c14f:55ad]) by CH2PR13MB3702.namprd13.prod.outlook.com
 ([fe80::b55e:a0e2:c14f:55ad%5]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 10:52:03 +0000
From: Yinjun Zhang <yinjun.zhang@corigine.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Louis Peens
	<louis.peens@corigine.com>
CC: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	Leon Romanovsky <leon@kernel.org>, Simon Horman <simon.horman@corigine.com>,
	Shihong Wang <shihong.wang@nephogine.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, oss-drivers <oss-drivers@corigine.com>
Subject: RE: [PATCH net-next 1/2] xfrm: add the description of
 CHACHA20-POLY1305 for xfrm algorithm description
Thread-Topic: [PATCH net-next 1/2] xfrm: add the description of
 CHACHA20-POLY1305 for xfrm algorithm description
Thread-Index: AQHZuiIRyWPmL3HInkuuo8eNQem9Ya/A0jKAgAAW3AA=
Date: Wed, 19 Jul 2023 10:52:03 +0000
Message-ID:
 <CH2PR13MB37022A82BF61E33B537F99D0FC39A@CH2PR13MB3702.namprd13.prod.outlook.com>
References: <20230719091830.50866-1-louis.peens@corigine.com>
 <20230719091830.50866-2-louis.peens@corigine.com>
 <ZLesfwnwXZ22A0fA@gauss3.secunet.de>
In-Reply-To: <ZLesfwnwXZ22A0fA@gauss3.secunet.de>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR13MB3702:EE_|MN2PR13MB3629:EE_
x-ms-office365-filtering-correlation-id: d8d89e94-e4be-47ab-285d-08db88462fb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 BjvBVOrjlkfgIr+isYQgqP+VJ5yqTPlBNd+LDhd7BlN6zIXM6eGH40TypfJDdoypaVl/GPVSAMhlxc/TM0wTQCvT08wLzBkjhzzuFXxYrHCgI6OUXRC3FTqqhtZzAWv+oyBMuDeCfsW6rFUoY4BNxE9CNAkH/EyZHq99dGwaUFngbwrRae/c3VwqzmtjpnSYgZKdTb7+nLZZOoxDIlVsKBVcJV9MWonPnv3bpkO03vQ4sFIHEfaeDzZRm89EoAbbSJG9xn6fCUPGqFpGICvqtAw0hLEZxzlgtwy5kTWdkC6QBr2JrMmBRSJhhWU8/DXliLwLTmjoHNWZ3v+QKOjn+pRjc/tiBM7e7Btf7ql25/VMOoJhu7HByhmKufEpyaW3sQCYyL7ibvba6Jy5WxjIRmYW1B431THD+16qcxGzP/gv1WPgbyI+zRCAYHLAQ/uorlO35/lKxzgDt3JlPNlrdY66BSsjtFJz0SpiykErRlmUKnysMbR1kn8ZnXbx7bDVyC8RhrjDsvwxTDd5kJ0b+uLiSCfjHCB56+UqJqz0IBfmsIDOFYc5BLcca6v/GkA+zNR+C7OdutMwc3+il56Fhlx49ufu2NKkW2oiZWcKHh89yzO0oTD1VtcbFqaHZ07QclItc4JH1FCWwf9QrMLpUJVgTI39EgK1iRra/13mNHg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3702.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39840400004)(376002)(366004)(451199021)(71200400001)(478600001)(7696005)(54906003)(110136005)(64756008)(33656002)(83380400001)(86362001)(38070700005)(55016003)(2906002)(44832011)(186003)(26005)(53546011)(6506007)(9686003)(107886003)(122000001)(38100700002)(41300700001)(66476007)(76116006)(66446008)(66556008)(8936002)(8676002)(4326008)(5660300002)(52536014)(316002)(66946007)(6636002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?X9iGEdklpAUiRqlAgoWhTZGfP1Ve0P2RU5quWFLjEMY0FdEHgEYfkPyAMfkF?=
 =?us-ascii?Q?Chbmj+hv2ozatr1D6Yvpaz4zP7MLVfQbvs7gb0SCubexiJj705x8h/9RZk7+?=
 =?us-ascii?Q?GMaXv01XzST0VngSzowG7AA5pX1ckfcI8Yr1j+FGs8rWBR65ZfqpjTVB1alr?=
 =?us-ascii?Q?1NCJlhyCJp9PRgC/pJR6iDelhxfUh2vHhpSLyDJsjlqiAfWBfB6Fd6mAIGeV?=
 =?us-ascii?Q?6Tgn/3fkiuXhdYsmrX8nev+oSkTKMmxgeAQX3yXAvLj44lDoZpXTbKB4750m?=
 =?us-ascii?Q?O9ifE/OdBebH1mfX2/xkoK5EJ5j9gcx0C7Hg6qGa122D46tDCSX/gEBuHNDK?=
 =?us-ascii?Q?rGF9h0ib4ywY2oiL7f+NzBiYYywTU2EGpki2XEAnMW0CCPDUmUnOKrZatbaU?=
 =?us-ascii?Q?+/c+zxdXK/viCFrwAApwko1aop5FgoCCEFzHXoJXi05eNRk/J5sHwPBcPP30?=
 =?us-ascii?Q?oAqVA7VfQ1S8i8gsbaIkX3nGJYMYAy0qWGNWTKDCQdiggkRAvSKyv4YrFDy/?=
 =?us-ascii?Q?RVd0ZEyv+boUZON6pJEX8b+Kxm9muxmhDhzY/LHC2aCnusULzohbqM0ed+Kl?=
 =?us-ascii?Q?vSaXKKUY/vZVWJkBdIiV+H937BmEEjM/LZAzdRykzCaeRwex+ACO52qYTODM?=
 =?us-ascii?Q?TfNyCvDlAbzHlI5VIoUs1yY9iR9Ji8GIAVAMLenzga/pNB6w4Ci/plQ0NqOu?=
 =?us-ascii?Q?YWq4qzLqBC4Y2HLfN3hdXiRWsRKHqk+szWr5jWo+0SCsE3DgqjwE3xql1Wlg?=
 =?us-ascii?Q?wDJCYGTF51IuiFbt5PsodMZ2jPnEvrcaaNr/03vqNAP4b586X9Ki66RHPxbn?=
 =?us-ascii?Q?tUeoawjMgpHi7JovKf6whIFzR0hc5GtbOq5A8B9FmAseX++OrVvZaE4pzUlY?=
 =?us-ascii?Q?CMVUsCwSb/qziEwBsr8WbUoBOjHxaZcemoUL1wAMe3A5CNxMD4MP/VCredJK?=
 =?us-ascii?Q?o1EzGNcwu3UOgOVrW32yoosHt4wn0kHFXxqPr64xTiz6muLQS0YAhuiC9pBU?=
 =?us-ascii?Q?EG1XCig7ovdeCLp22PHumVMdJMjMflB3b3V1oFrt/zQ0jdjHSZ0spyG01uX+?=
 =?us-ascii?Q?R/JZPW65ngHV3oWEQV9YYiN4eB2abFd9nKfFHaHvv4T8JDFKTaQio7pRAav7?=
 =?us-ascii?Q?3viwm7hyPMqfBrBWmWpVWqZh10weKfl6UGoR1/ub03G0YoGRogp5SrJKCpth?=
 =?us-ascii?Q?QUHErOKuoORqUG31k1FNpQzTSKqaKq4TokSagv6oLbx897cjSwplh47/aLzV?=
 =?us-ascii?Q?y2cqbNQAo/NDv9F90VCOJsK/o2CGWB6O2eiq0XtmtGeArZQHTHI0Ybrzg15X?=
 =?us-ascii?Q?XXrW1NRWmIN0f/FpNiK/GDpxKKthxLIgPLVVrnRXbevKOxfr25ZlxaTlNLKB?=
 =?us-ascii?Q?foDuVIfV1PWY3soijGcCfnR2mwMi0g5cRukS/He3PoO5JvssNpOcYDDGuVsL?=
 =?us-ascii?Q?Q94uohVjJpmgKMSnyHFIoeixezyQJASMXb31+7iGXROYN0KFy4rgFbK2Fvvg?=
 =?us-ascii?Q?q5lZa50dCQTHgzFx4S5OBonDQt4WwEOGXliMJ0jV1X1CtWQSdR6qhCG8jjWu?=
 =?us-ascii?Q?wSTNBWQQYf8qiYx3sfveE8wbxVDugjweC1fvP1eF?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3702.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d89e94-e4be-47ab-285d-08db88462fb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 10:52:03.2306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BW0R2qEZ8yG9Asj+MdnApqp4WUXbCjM7eHejj51CppvywK/64s5tfOD1zlc+epCY0WH8CycluhNPOEBChXFocxcvI5tms15ybtv/GJCdxhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3629
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wednesday, July 19, 2023 5:27 PM, Steffen Klassert wrote:
> On Wed, Jul 19, 2023 at 11:18:29AM +0200, Louis Peens wrote:
> > From: Shihong Wang <shihong.wang@corigine.com>
> >
> > Add the description of CHACHA20-POLY1305 for xfrm algorithm description
> > and set pfkey_supported to 1 so that xfrm supports that the algorithm
> > can be offloaded to the NIC.
> >
> > Signed-off-by: Shihong Wang <shihong.wang@corigine.com>
> > Acked-by: Simon Horman <simon.horman@corigine.com>
> > Signed-off-by: Louis Peens <louis.peens@corigine.com>
> > ---
> >  include/uapi/linux/pfkeyv2.h | 1 +
> >  net/xfrm/xfrm_algo.c         | 9 ++++++++-
> >  2 files changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/pfkeyv2.h b/include/uapi/linux/pfkeyv2.=
h
> > index 8abae1f6749c..d0ab530e1069 100644
> > --- a/include/uapi/linux/pfkeyv2.h
> > +++ b/include/uapi/linux/pfkeyv2.h
> > @@ -331,6 +331,7 @@ struct sadb_x_filter {
> >  #define SADB_X_EALG_CAMELLIACBC              22
> >  #define SADB_X_EALG_NULL_AES_GMAC    23
> >  #define SADB_X_EALG_SM4CBC           24
> > +#define SADB_X_EALG_CHACHA20_POLY1305        25
>=20
> Please don't add new stuff to pfkey, use netlink instead. This interface
> is deprecated and will go away someday.

Sorry, we don't get it. How does driver know which algo it is without these
definitions? Is there any document guide that we can refer to?


