Return-Path: <netdev+bounces-33716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8D279F63E
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 03:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB981C20C62
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 01:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF470381;
	Thu, 14 Sep 2023 01:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02D6369
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 01:20:23 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2109.outbound.protection.outlook.com [40.107.96.109])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4971713
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 18:20:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zm+42v+fotBA+ceF2P21DjAv1NFHMV96UzpzL/WYmPg8Vg5b69QomCJc+fp5ltRub/2bGF10HQqfUG3tgc97h7OotX/2ezWTuGAjauiXEqgpSI0IsMaoRm9bGEXuQfu1rwDzRSk8/qDPJglTIkWvqTzL5xurhouty2Ua35wzPSFW6eC9ByjEvZWVpKwXe5x96QknxIdSjSxfPKhBxJr8d8xgjuENekntqztieaAhSjdAHR6T3GT3rwQlMkSqatB5wngrzag7b+wcjIhfrR2cLr/Ku7ZAfRfFwatW5zcm9qF96Kj46eriv8LT7z0kKsRyvxhu6F0+WsfkmjheECnWGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OvCrPMOi0igI56lr7655XAqPElIQRlhtCLZhMJdIGk=;
 b=eum0HdUbQA/P7pSDP+QKe+aqt263XJhPe65yJx/dkFNjpAqV4m+pstW7P5+s7TvZ+Um03MQ5u9xUuf8ysOQ/bMMk6XM8LM4tAp4ZwIFZmeL6u3f5XUKoagIa2P1TqN3dQLyxLEnCSj2LDYnDSFLtZR2nuC8WU7U33YoN6LYpoz4C8X7jKIehcV2EkwGPvBYjuYWvJyw4uFUn6pcw5Wx21TOeX7H/W8UsNrDUHIIUaHEcwTL3F6Co1Hhf5rDxvgthbP8CVAvrX+5B0IAO/ZDr90fY/kuqRzYHKSejcEMjOTfxOQQsJG78KNoUvN0WPGNZ9K0xObsuK/nxY4U2rxYbXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=alexbal.com; dmarc=pass action=none header.from=alexbal.com;
 dkim=pass header.d=alexbal.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alexbal.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OvCrPMOi0igI56lr7655XAqPElIQRlhtCLZhMJdIGk=;
 b=UttbHbTlCLe8p3u+oN9fUuiqGLBkRrfbllDUi9VWvQnHlbpRMYsblCO9kMGWCW9PbQEzbeCBL1vpIWw/nEPV23hiIpCyXpEr0GvBbpu1Zq03ugn0uASP8NraQIrzs2U9LfCr78I5D2VsCFUcUOi0QhoMgwO9sphu/F7BR8/b2cg=
Received: from MN2PR18MB2574.namprd18.prod.outlook.com (2603:10b6:208:a9::23)
 by SN7PR18MB5387.namprd18.prod.outlook.com (2603:10b6:806:2ea::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 01:20:20 +0000
Received: from MN2PR18MB2574.namprd18.prod.outlook.com
 ([fe80::ea10:7d82:526:13c]) by MN2PR18MB2574.namprd18.prod.outlook.com
 ([fe80::ea10:7d82:526:13c%5]) with mapi id 15.20.6768.036; Thu, 14 Sep 2023
 01:20:20 +0000
From: Alex Balcanquall <alex@alexbal.com>
To: Jiri Pirko <jiri@resnulli.us>, Mika Westerberg
	<mika.westerberg@linux.intel.com>
CC: Michael Jamet <michael.jamet@intel.com>, Yehezkel Bernat
	<YehezkelShB@gmail.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v2] net: thunderbolt: Fix TCPv6 GSO checksum calculation
Thread-Topic: [PATCH v2] net: thunderbolt: Fix TCPv6 GSO checksum calculation
Thread-Index: AQHZ5gLomj8+92Y3+UuCabgCtdFTRrAYYicAgAEk3PM=
Date: Thu, 14 Sep 2023 01:20:20 +0000
Message-ID:
 <MN2PR18MB2574E41CCCBA6CD612D8AFE6DAF7A@MN2PR18MB2574.namprd18.prod.outlook.com>
References: <20230913052647.407420-1-mika.westerberg@linux.intel.com>
 <ZQFp+vdoedzshCpZ@nanopsycho>
In-Reply-To: <ZQFp+vdoedzshCpZ@nanopsycho>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=alexbal.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR18MB2574:EE_|SN7PR18MB5387:EE_
x-ms-office365-filtering-correlation-id: 63de2077-2355-4a17-832d-08dbb4c0c313
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 FgF3L2OyzhnIhhgvKkB/afx6Es+aDgd6wu+uzRujKma7uB/AW0Vs6PtXTkHRk6SqGaZR3MyYVNzUm9AEcdwzuDX2WVexTbWR2lLK+RgO/QuhAoUZ+HsavhrKFYBwmYKaPq7dkFlufe9Rd4DWEMJVdFUdp8DbzCtAXvn8mB2/vpUng9A+xAos5mauqQ7k/yfh53JnYRprwX9/t1mwrpUrF+I/u7svd2EXXctr8MK2SxjFvT0h775r4/mwM5fGVY28Cxv4AcodAG8nBzXnhF70fT2MbXUDHsH9FkHIAdlUknqyHwsfn/KC0vf4tAAtt0cwPRwyliM97SYYS3lbk8ik0Z41cfAVV2W9runcneLPIe8Z3C1/Kl1FRzcg78s5SsQKEfut2g7ORBvwMUccOFW+6RZzPHJ7OClp1wj2eLvi7M1KMckNTQqbPs6rgXH+Kvy4j0yKrrxiaUIPyDawAwk0s5WjWMf1gqCFd0SAmvhtBoabj2ORfGbLiRe3jNyoO234FGY/+miaA3SUUhOYkFUpfurzfmKVvkczCkmawaE2anAhDCwtKK8PL+nJRRvcV9un4mRVtngYg/ftuioNz8Vjm/G4aDHPQRtx7JGzPFJiHWc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR18MB2574.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(39830400003)(366004)(1800799009)(186009)(451199024)(64756008)(66946007)(54906003)(52536014)(76116006)(4326008)(5660300002)(41300700001)(38100700002)(38070700005)(66556008)(66446008)(316002)(91956017)(110136005)(66476007)(6506007)(7696005)(53546011)(2906002)(8936002)(8676002)(9686003)(478600001)(122000001)(71200400001)(86362001)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?psGLnk58yhoZ69HgLtCAUa4w4bUUK7py4SnXtUXslWLvsRxkjzv8dRwGi3?=
 =?iso-8859-1?Q?KjSKNx5bBnColGmt6S8xphHYAojHoN6RumbVU5zUOIepPFvewHVhfUu43I?=
 =?iso-8859-1?Q?Da45XLNtSggIm2dfJqJHe/tMveiklqZXRoRYng6BaHXIoXUSZLLbZnjhBe?=
 =?iso-8859-1?Q?OvWmmewY1HmcQZIEKedK6P03FI/f51OWltAIc/+1dnkChA6iB86Xyl9Wua?=
 =?iso-8859-1?Q?WmGYv5+22B5muDXWrwSt2kj5RhAKXdjXJVZj87/YVhSixE0o4pi8IcxK26?=
 =?iso-8859-1?Q?V6CMmoBD7knlPfoOTiGbaD+diy8ptzrQUt7MFJEJtZBbb8Ar8Kt/ofW/YC?=
 =?iso-8859-1?Q?Tl/qP+0ivp0uTGKdVKOroWpbi0vXfNnQdvFnayNHNBxRT8FOUEzY02rka1?=
 =?iso-8859-1?Q?PhM00effkiqquDl8BHljSbnHL0MkWUVZ1qyJcrHukS6EmbnxPCWbxVQRY/?=
 =?iso-8859-1?Q?lsy5YIS6wwsJZqqgCnan1MB26ho+02dc7vsYkuv+RxeSiNQ9m4kacVwQq6?=
 =?iso-8859-1?Q?VllAlr8As5r+EXibo4bN7+ZblQaIg+4pJgPqF0IQRa6SY2u7xOAN24+6RH?=
 =?iso-8859-1?Q?SBOP2XhdP0odN1BSXJN8rtLi8266CWRZJ93/8ZbWfM4kdtMtwS/6vfOVz9?=
 =?iso-8859-1?Q?Qdt7TSg/Ftq3D5yfYvfqwIBfjXDMRikR8lh9DorsAk+/1MXTAiYnofk5lG?=
 =?iso-8859-1?Q?bi5nrohhsN5J7ECu061Uaje81JUDI5aqGuyLbbWAvvRZiGJfu7Wnqy7r/N?=
 =?iso-8859-1?Q?LsbP84zbh1Vm7CujHhrqCN6ej6Jja/4Z9Dsn5sReKwcIi8BjJ7CWz6m+53?=
 =?iso-8859-1?Q?oJ1xy6Y6wuNl3nd9M/pZd4YYchuGiqZDhYzoX/kD2JuWfhTfxuQ0HVSQhq?=
 =?iso-8859-1?Q?PEEQ1zUJKF33Su6Sz8xeGCet0ihNTaODGmUd5oLLEWVDJWEt7pRkDfu+/l?=
 =?iso-8859-1?Q?Kd/rr9NzDneYJmEHCRsoGnhZjU3K/b30xRYrGBjGmLQwfIFJabI5QWOQQK?=
 =?iso-8859-1?Q?1c0/J1lVaB3B0XzHT+gXJk6iNrQFYrjyBoB3K7hbcsItdQVMlPevlS/rxU?=
 =?iso-8859-1?Q?8w91161YnAwIIrmX2kEOXM0L171O5dN06uojnOeOBz531gXiJ/1QkljlfK?=
 =?iso-8859-1?Q?V/+cCD0CpLTV/omQVklxoQxsHvA0l0B0ibzWFUVg4Sid8dDqkIqZbay/YZ?=
 =?iso-8859-1?Q?dfAr3emQcF4zb2FI0cJ8b0BnyaEk33st1gYeR5cYQpsWWh56bSYvqxW2os?=
 =?iso-8859-1?Q?immmZsM4UGN4dhbKmsBHYEA7xc3GBqZdTLAhArfEJEOjFQg4r9tjY+wzrM?=
 =?iso-8859-1?Q?bjI/0QQ0bMB6TlqnT8mgoqHeEaO94l0SBn4MyEQq97ktxnMFP+UywuuSXR?=
 =?iso-8859-1?Q?Uqty0ydMqaTFz9enfzk9Y1eohmO5J6JIHBxHHrQdwO4RiUB5sQfxhg3yMe?=
 =?iso-8859-1?Q?Rb2RMY23jWJGX3mcLGIMPOfCJj6Hgaohhc8z5fdAIl9eyPyAbLsMPgkSiA?=
 =?iso-8859-1?Q?A4Ikagh7WlEkkzAlV8Tep7ENSmzWTq56OMKEskOywgQELSpFVPwJf1MLE7?=
 =?iso-8859-1?Q?hNqo2dgH7ZawqaDnEw/LV4DgFyttYA4NqCcocL1/vUIDq5dAfF8qTx2ToH?=
 =?iso-8859-1?Q?MurIpaZFYKwu+TCSWcxyRTwE5L/9SydTMRLIUdenxVXMyPX57t6JmDL+WX?=
 =?iso-8859-1?Q?fp1dlWub4g4RK6xz+mU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: alexbal.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR18MB2574.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63de2077-2355-4a17-832d-08dbb4c0c313
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 01:20:20.2073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2147ca43-2fb1-4d60-b704-b17158b27b0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NONzDM+Q/Q7w0EGbacrFWDj+LjIgibaoGvkJcVrxlfX0C7PjVyQUxMCeu8L23QDlWZ1/dyQPZ1MxCmqbaaCafg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB5387

Thanks, the v2 patch worked perfectly on my 3 test machines.=0A=
=0A=
=0A=
=0A=
=0A=
From: Jiri Pirko <jiri@resnulli.us>=0A=
Sent: Wednesday, September 13, 2023 12:51 AM=0A=
To: Mika Westerberg <mika.westerberg@linux.intel.com>=0A=
Cc: Michael Jamet <michael.jamet@intel.com>; Yehezkel Bernat <YehezkelShB@g=
mail.com>; David S . Miller <davem@davemloft.net>; Eric Dumazet <edumazet@g=
oogle.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.co=
m>; Alex Balcanquall <alex@alexbal.com>; netdev@vger.kernel.org <netdev@vge=
r.kernel.org>=0A=
Subject: Re: [PATCH v2] net: thunderbolt: Fix TCPv6 GSO checksum calculatio=
n =0A=
=A0=0A=
Wed, Sep 13, 2023 at 07:26:47AM CEST, mika.westerberg@linux.intel.com wrote=
:=0A=
>Alex reported that running ssh over IPv6 does not work with=0A=
>Thunderbolt/USB4 networking driver. The reason for that is that driver=0A=
>should call skb_is_gso() before calling skb_is_gso_v6(), and it should=0A=
>not return false after calculates the checksum successfully. This probably=
=0A=
>was a copy paste error from the original driver where it was done properly=
.=0A=
>=0A=
>Reported-by: Alex Balcanquall <alex@alexbal.com>=0A=
>Fixes: e69b6c02b4c3 ("net: Add support for networking over Thunderbolt cab=
le")=0A=
>Cc: stable@vger.kernel.org=0A=
=0A=
Interesting, it is not actually cced. No need to do it anyway.=0A=
=0A=
=0A=
>Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>=0A=
=0A=
Reviewed-by: Jiri Pirko <jiri@nvidia.com>=

