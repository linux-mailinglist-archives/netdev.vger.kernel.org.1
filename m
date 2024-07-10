Return-Path: <netdev+bounces-110499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2B692CA1C
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 07:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E02AA1C2134E
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 05:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B38D482ED;
	Wed, 10 Jul 2024 05:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endava.com header.i=@endava.com header.b="wArE2Ahy"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2117.outbound.protection.outlook.com [40.107.104.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6409F17FD;
	Wed, 10 Jul 2024 05:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720588686; cv=fail; b=Y+cN3gzM6/QVNcTFZpiZvTVKU4EvlKoQtRcXYCkE7jqDIxgRmypgQZYa0Mqlia0Fw2OZk3Px3DhXVfoNiYCdo5+Fm47+98tOnDiAr4Ln9ajO7lfCGsaJT3ANwFdMUXabEOaIY8gotHoAE8oTVDoXu2uJt0FWDuhT6SDDCaZ4jDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720588686; c=relaxed/simple;
	bh=28UOaI5+utANsdEojiEL2G53RdP/dUxpVvYEiBbVFUU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=stNZNinvxk73jcATrSRjduZI3r3A+g2NrKEXNzVZ3KE6jxaNAMhFRO3DuSp1cRC/RIaprE6/HXvVwzUY/vXl01K2En889M4RhkQwvKUToos99W1afl3Q2du11I8LAvEmkp4VeYAfTrRU2sfgVb/udN9zRqV7ppNQDXqivME2M2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=endava.com; spf=pass smtp.mailfrom=endava.com; dkim=pass (2048-bit key) header.d=endava.com header.i=@endava.com header.b=wArE2Ahy; arc=fail smtp.client-ip=40.107.104.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=endava.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endava.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nV6tSLgP0VEd3gUa4UIUsnSXzlMtb0fmlWHSwOP8+MIURKwAhv0xZxbX4qEQzbDdoWg8SrxeEZnlv5aqZMog4YMl+EESucVSw1sfv+Tyi60CXVQIQrgqIQKXLSoCOU4PxNPKIfZo0YxGx+t50H2DJ546rMEgPE0S6L2VHjbJsTx1opITyVbWzXmriu2WpxCsz7rq4e4j9lJ2lh+332xfXlc7v8mZYwJVadQKrbHKA7xBoNhjhHxIjXZFD98HuPw8Yjuoo6913GwQyQBCx5hA/HOw1l3VSgvu7MBqLdMwjCIdMn16MONWkz/GQgvbSX8e1f13l4aFaD/s1vcegZe6VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28UOaI5+utANsdEojiEL2G53RdP/dUxpVvYEiBbVFUU=;
 b=eN9ooW2QmbQ4xAUFJjWmjcZRXXE4WY4ohZNHRmpio2+7c+lXt85OZfpNmuOqWwH36vmWStjkvFY9eKgXjj4XSuMUZNTAhiA9UCTqPmPl41CtBHrK918Lb0eGPF+G2Y2SB3PlWQeOH707cvgBHqlUp5IJHi8GLhHKoD2E8C2Lo8cgOLVNw9a/+cRUW3ZQQzzFg0f3LOyiiGFWFvw3++Tdc/jKVfA7IQTjR2DUoWbykfduHZyFYlqyBbx41tICMHP2bn19ici7+vOzbGqlK/swgIKr1jWtuDwJyh5MehwgCB8Z4z+JyswPSlnd7IYmBm1ccE28epGcWorOSSvQt8ULEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=endava.com; dmarc=pass action=none header.from=endava.com;
 dkim=pass header.d=endava.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=endava.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28UOaI5+utANsdEojiEL2G53RdP/dUxpVvYEiBbVFUU=;
 b=wArE2Ahy4a28vel2sk3KlsHvSiJum/cL4ySwVIdE153iDJuGYPAlsQRB40K/+cdw3iVBsriQ70RZ0BEt6MHHeQFsFJX+Acu3IYjknYOmFQLpJ5aP8l4hk8TYJMoBQVoHeUWWVoa5YdvAyb3uLyqjo3Ibob5EQeFtyx25YoLOc4HvZJmi1udcCxcIJU5zhUemWz2t7dy2Z+J4hMBWKT6GJYhphsRZUb/Xf1pN7gfmzSrP91ThLQYLW51x1xpBXLUirNgr2YQUPPUOeeUhPvK8eoH7sDtVavjhD79xgDp5i3DjbVWixVJxVyKpkVBlRZpAfleetHQ1GS74qHOu08cEjw==
Received: from AS5PR06MB8752.eurprd06.prod.outlook.com (2603:10a6:20b:67d::20)
 by AS8PR06MB7685.eurprd06.prod.outlook.com (2603:10a6:20b:318::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 05:18:02 +0000
Received: from AS5PR06MB8752.eurprd06.prod.outlook.com
 ([fe80::72f2:c654:1827:9c41]) by AS5PR06MB8752.eurprd06.prod.outlook.com
 ([fe80::72f2:c654:1827:9c41%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 05:18:01 +0000
From: Tung Nguyen <tung.q.nguyen@endava.com>
To: Shigeru Yoshida <syoshida@redhat.com>, "jmaloy@redhat.com"
	<jmaloy@redhat.com>, "ying.xue@windriver.com" <ying.xue@windriver.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] tipc: Consolidate redundant functions
Thread-Topic: [PATCH net-next] tipc: Consolidate redundant functions
Thread-Index: AQHa0g3JG17RS1Bp/kCgIVTZN2hae7HvbEUw
Date: Wed, 10 Jul 2024 05:18:01 +0000
Message-ID:
 <AS5PR06MB87528FD333E3D56A4DCEDB67DBA42@AS5PR06MB8752.eurprd06.prod.outlook.com>
References: <20240709143632.352656-1-syoshida@redhat.com>
In-Reply-To: <20240709143632.352656-1-syoshida@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=endava.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR06MB8752:EE_|AS8PR06MB7685:EE_
x-ms-office365-filtering-correlation-id: ed329fb8-5d66-41a1-34c5-08dca09faba1
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/9LrUGJhtltxP327G2So6UXHiKFpaGFUgFCIf4mG75Em0j+1l8vf7+BkNgKL?=
 =?us-ascii?Q?PFXJsui3xj4plJgqtzwvKQujyQTWkbKUpT4LltxsX915Cqw07RTvNxBc4zbz?=
 =?us-ascii?Q?ZWSXIKYYogxsLYi6HdPz6HXO6/MrAFeQNfyvmViqcAKo28l7Y+/J78hJyLyY?=
 =?us-ascii?Q?FmHDkneMTSX3hpDuHdrTcanUNYrUSwS1yxq0+aDnUYeEb3UzgNJOJyKsKTp0?=
 =?us-ascii?Q?5pwbGypndoxk+dfa4DqemeQKUZSLOT2qvoYgnTPw4VBNIxGvT1lB7jPp6JKU?=
 =?us-ascii?Q?cuaxqkEP11Sl3F5myuW4H5GWZqXtSrWIlGaYsKOWvnfQNeY8nDChCBLF5BR3?=
 =?us-ascii?Q?t1/ss/B1UHHLNlBAgZBRwXMyIOeX6oLnHV/vE2TWDoW2LD+IirMAGCclVxwB?=
 =?us-ascii?Q?Sda3roqYNH8IF1kwKL1xnJ04F+SjAvtoPRqgluryYnbVTK9vbktq5S+txI2r?=
 =?us-ascii?Q?B8FIy5i8Z39Q7Pi5HBbLSwTqpW8A7QLXa4Ts02Zdp5dU+JaqmYUOCuD8pQcO?=
 =?us-ascii?Q?5EBd0GAREOBDKUinUi3k6SXSwklvm8NVFWG/CWWLpaOagy1Dj4XUZFVXq9rX?=
 =?us-ascii?Q?MBUO25Oh5ihv0oLYMq4EJUmWPDCtW6sv0ppI6q7HLw01m4NhaiKPaVW8Ok4p?=
 =?us-ascii?Q?tFCkYXgkgyTaAQZ45F05Eq5EliphkBlkxva8xG3S7VnIzLJ9+xwsJAjLBRPK?=
 =?us-ascii?Q?c2Rgf5+CLpIVwVM+4kbr/Mn/5dtaFaUR1onBwM8soqWbdFLXGrl1kQCKZSS4?=
 =?us-ascii?Q?85Pyxckd8/IwA+j5RazRg8EXBfjCDCEt8K77CpKEB1Wp2N2JVFul4Z57LZb3?=
 =?us-ascii?Q?mjDvi7xwDWoK2o4EZ6EvSIErZUQ3jeZvH+ctJaKwfqGWqpKXi0vdQogFive+?=
 =?us-ascii?Q?T0vUrPO9nFQu7XoJaSMrGjwRnFpjDSBdv1f1AZnk0iSBEiwB5o5ONH+EZdFC?=
 =?us-ascii?Q?jYXSETVkiVNob0qySs6pntRo6FWAbxfKIsEXVXpRBfcSrlCK4ELe5KbkLELu?=
 =?us-ascii?Q?joDq9qKSVg4ep6E8BEDC8dCVPiTfAGeVdQAlJYzd6jkdw2QHWfSbeWLC6ICK?=
 =?us-ascii?Q?HMOWQG1aF5KaLLD/cYza1Al6nlR/P7GIVIao/qm15AcmZ6S45m9g799tRbtL?=
 =?us-ascii?Q?CQ/Yzxh2nCMKlgqmtaXThVgCvwoJo3UNJKUW0xetAU8bgEqtajQVvlG/Z8YE?=
 =?us-ascii?Q?G/sqfvQtXbeQrtvn5q7WwUd6qBtbUiZeh8MXq8v5G2daXaVXHEeaWXTzGNWe?=
 =?us-ascii?Q?wFG62U5131obEilAigg5EhsE+xj9bHcitqQn7KXRT+j25wckl/booBCaSfri?=
 =?us-ascii?Q?vaSgxaVNTgjhBrtjhjtryoe/B6BK1BPDPRFFKriTMCwlFEUObGx0mAoYwK2m?=
 =?us-ascii?Q?tSselSydVMXG6kgPuQ8IEozqYqmv1ITU37pG1uJNZZiV4U4Zbg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB8752.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?i5ydp+aomwJ3D8d80zE+a40+Pe9f4V/7Ltbk1WPMGNsc7qt+roMzvcNDEyxQ?=
 =?us-ascii?Q?agLj+rdQZk5NAsV9KJnQT0S8oY2qy990hToeOHq4XXh2wvynCOnTkMKn+wLM?=
 =?us-ascii?Q?tEExFq0m0XV1sACyugBI1eyXwWEX/PWIPQO4mOno5EPjFZkf4wywl9Jll1Ga?=
 =?us-ascii?Q?KCwfyfwNrR1E1DEvy5cp5CHxLaSICEK4YOU2BSNAdupLnxjzGyICamD8171s?=
 =?us-ascii?Q?LykSbwW/zuP6OA/LhlovLlTB++vVqPwQgX1rzxNDaiQbZOza7oYbUKw5NEV+?=
 =?us-ascii?Q?HEo8BQQNzQCQ85H6NiNw1Q3ACknjK+Cc6ZrDx+6oR1vVwQObZG3/UtICpFNi?=
 =?us-ascii?Q?kusQutsibuuaDzUHuvuDUYVm9ySBDxlGt19jVzrUW1Vv1GqNHFxaR3lEYYjV?=
 =?us-ascii?Q?wywg0qvi46Zzy9JPOol46T9nmdZish1IfDMh/2ZKwlcSSwI1yiyAuBAzKgtT?=
 =?us-ascii?Q?LaJcafA80quQYQkgSLV4hIXZxJwcpOE1EyjNobUExTA+wkCZ+DcxAd9Wd1Yb?=
 =?us-ascii?Q?HeF0BZE8y/0da7ODtkKJ1U1qmV75dkhHv7EkW5b7RuhTYPhazx0e8LGD354Z?=
 =?us-ascii?Q?l7p/Vl4uGQ9nXQD6CmrCNU5RtIgu5QgpcUl5rtgP1J9HnbqJtgR6Ma4j8qi0?=
 =?us-ascii?Q?IqzJY//LZFso2+LKvzwzEeokq1Me1VvL10W7ZsySvLYxgfTpdUTU+syufBBD?=
 =?us-ascii?Q?LleV4zbEfvHYTY7lp55Lapv5gqLFmYJ/V7GrxKq9TzYIFtqnxKG74ulNZ82m?=
 =?us-ascii?Q?UEE+uXns9NPDv0HVo0P2rdh9FlQM2khi4k6k3d08VZZ427eLmKesvXoKBSxj?=
 =?us-ascii?Q?x2+YWDeFrxm2+6LXhJqhEYLO1G1+1rcaIw3xH3BqgPm65A89lumSXoABFhUA?=
 =?us-ascii?Q?bk/zGjvEU4hTcZACpSyAfF/Y0fGcEXLa73rqrBS91xXkrv3a1taGwSCjWQLn?=
 =?us-ascii?Q?DCYODyAqu7CaFnUbg1JlH6QNl77W6s7Aq80o332ya/QxN9q0/cgL9Xm48znB?=
 =?us-ascii?Q?DpXKCheMS4EgEQ2ucEjkp358TjM9TrN6Y5QTFKwac0lEh0N4yw5oaRwkUONZ?=
 =?us-ascii?Q?Cwl6EBibwPkLaScLEu7Izu5nOMcuCoyw2AWWO/ShF60mXG3+fKKn/6Xq8D6a?=
 =?us-ascii?Q?XJAZD3mdALEu00a/W9UPTuxoEMA5E0SsDqfb9+1FJoJU85HH5v70xgJlPmoC?=
 =?us-ascii?Q?n5TnV3JEImkgll//t+HR5wtn9KWURZ0LyboycHu3VsmzzpuB8SJK6lHhpXrW?=
 =?us-ascii?Q?AhMsQRvi3weJt5p4m/da9nqwV7We5s6qt5vmBRiswakJAv/ixSYCQ7UgakPC?=
 =?us-ascii?Q?zNVVueAaNCgnxYxSpVEEBybwBMiccsKBEa6+QkvceAnUG+iwYri7qKU9NtYl?=
 =?us-ascii?Q?21OTqUqOmyewQ0GTZAlzc3kEPuxcHn0vrcBvo7oWwwiDQ/1+UPNlbP/dnnAr?=
 =?us-ascii?Q?wVK9jq3p3R69pVl/yLqsCesOdultwVxWS7XRPtxRPqGL63WEh1zwIgH+FAlm?=
 =?us-ascii?Q?xnkzgFH09kyoLTC6ULrY9fOEy3eeE3n32HcICqNbdJ2Ia2T9Ju96F0eu/GAl?=
 =?us-ascii?Q?LY48LxQiCp2vIHXQ+xknlGVrb5VKMSg7J/2hL8It?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: endava.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB8752.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed329fb8-5d66-41a1-34c5-08dca09faba1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 05:18:01.8875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0b3fc178-b730-4e8b-9843-e81259237b77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hXYpnHqtMtSK9pgPYrpa+xdc5xQ4w8KVfHPAF72d8X3sp7QCBBgIF1muLNKg5Ewmgd8EugJQ8EjvYMWEU4hUpUSJWnju0eKmutm24Y67SKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7685

>link_is_up() and tipc_link_is_up() have the same functionality.
>Consolidate these functions.
>
>Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
>---
Reviewed-by: Tung Nguyen <tung.q.nguyen@endava.com>

The information in this email is confidential and may be legally privileged=
. It is intended solely for the addressee. Any opinions expressed are mine =
and do not necessarily represent the opinions of the Company. Emails are su=
sceptible to interference. If you are not the intended recipient, any discl=
osure, copying, distribution or any action taken or omitted to be taken in =
reliance on it, is strictly prohibited and may be unlawful. If you have rec=
eived this message in error, do not open any attachments but please notify =
the Endava Service Desk on (+44 (0)870 423 0187), and delete this message f=
rom your system. The sender accepts no responsibility for information, erro=
rs or omissions in this email, or for its use or misuse, or for any act com=
mitted or omitted in connection with this communication. If in doubt, pleas=
e verify the authenticity of the contents with the sender. Please rely on y=
our own virus checkers as no responsibility is taken by the sender for any =
damage rising out of any bug or virus infection.

Endava plc is a company registered in England under company number 5722669 =
whose registered office is at 125 Old Broad Street, London, EC2N 1AR, Unite=
d Kingdom. Endava plc is the Endava group holding company and does not prov=
ide any services to clients. Each of Endava plc and its subsidiaries is a s=
eparate legal entity and has no liability for another such entity's acts or=
 omissions.

