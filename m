Return-Path: <netdev+bounces-101256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2F18FDDCE
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 06:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AA8A1C22E13
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 04:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE06D219FF;
	Thu,  6 Jun 2024 04:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ihXGGR4a"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4138821
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 04:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717648848; cv=fail; b=Bt8t/2mOopoOwaPujSx9YlqWT4aQdvikcAwqGCG/c+D6WpiacMEnqP94yIwDVO0gTBtK94aonZ2ag+ThHBuQEH99ud7jaJsyzJEUVvoGmzTxD8i9iH+eM1vb4QJfhsaMp+xk+ERjPtuqFt9CyKa+o5oKzsvv3DupthG2ev/ZDkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717648848; c=relaxed/simple;
	bh=Gx98kuqdltn1rP8LWL88Z4sRZmCruhtw3jzEQ88Eox8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iFGQHTVarH/MdRRat6Wg5g2oyXdZTj1P1H8CpRSdyEuMPOTbBgIrxHbkPqRKCkJ1AIzvY+P8+iD6fHrJvb1wZxRSLJ6YauAv0/W0vSz4lRHe7+hNbV4kcvd31sgLbPi91hgg89oFADO5UmNNdLdycD+5Qfs4niRlbcWcsZqUpOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ihXGGR4a; arc=fail smtp.client-ip=40.107.93.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mamqqCN/7seb5uT1F7BfO6ai6KI8s1WX6FT8fuHW8fObfw5xESTV2C0xD/yMhjq97OSw8mQllJk2Jdvdr9L9ohvu6eW9hvP1mqp281fT913Nnpnilhs57GyJkHpQcJe+cvCFo4wDqdxnXBOY3Uka/SRWpwy48sUdzZ1fD7OK6y7fUC2YP8RWyoO8ATZzRETDEgbsP1l8wiwUb9gQ3BlyAUyFCAYUwa3OGLGnhhiSm47pYFbIcNM1XZmZZBHojMZsGhal3qVWdUz4pAScv6XkOBn7noYHjOkXZ0HVtT00ewl7yx3mRsDj9/DOntTV9UuMBmBDYz6ee5KvdlHxxdmQ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJihzRvsg0bWrSv1jPsGRaUZwrzl8rLyvV38wP/+kBg=;
 b=XjnfASwVzPuZuYwBBNe4aar+Qh/AfCIQMaiVyzjjFnAZojmuILGrMehtOG0dNkI1SCA4enr9QKmji3b6EPOWVKJMJC11QczeVf4vdURgh2m6L94pgu8vuiXl/VTKmA/G7XWOvvwpw09fwzi08CUm4fFX5FYZgBxkRrGeVX2D4pm28a8Jxer/kvcJ1TVIgvvoaxs8QnBpq4/aKveEbgo62ecKQY5xEaMjs2tzqECvC1fNOX2CRxuslTE/p8t+SRwoyAuqQBrUpHoCYikoN2/n7yuUhopvERAQYOKMBw4Hkfr0xZyqkThBsRhG1tUTEogzvp5h0F3J3d5465z2gr8v4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJihzRvsg0bWrSv1jPsGRaUZwrzl8rLyvV38wP/+kBg=;
 b=ihXGGR4aftzA252SnxqYLwuJ52b8SNkLsafoJqQ4d7aMgMGjpqUSiDNp6xNTZ6oGKTRAwPlD3Mj9H/vkj/E2bQSWPfV07fSTsexD0oMFYjZIcaXMsA7n1JjsvK1VFAPQxeJ/HPh07jcTquyy2i8BtAKUSWrmfCxgyevoZqDkZBBl10GIvvSa2yPOw9IfwnRHmAZaI9w4SKes/zrbDNDLG5kGVqZ9aS6rOncotTXbioNaArdXuMdoVBCIjc/T6IpspxHbBM7VPlb14kFAZkXhbXBpAY5QC4rrf3Nq80xgh1jPEQ/Vt3Y9zx1xYqsE01CxmylRvcN5rS9v0fXh6lEZEA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Thu, 6 Jun
 2024 04:40:44 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::361d:c9dd:4cf:7ffd]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::361d:c9dd:4cf:7ffd%3]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 04:40:43 +0000
From: Parav Pandit <parav@nvidia.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>
CC: Jiri Pirko <jiri@nvidia.com>, Shay Drori <shayd@nvidia.com>
Subject: RE: [PATCH net] devlink: Fix setting max_io_eqs as the sole attribute
Thread-Topic: [PATCH net] devlink: Fix setting max_io_eqs as the sole
 attribute
Thread-Index: AQHat8tp2h1Ir0TnWkOtjj9czWcfK7G6J2gQ
Date: Thu, 6 Jun 2024 04:40:43 +0000
Message-ID:
 <PH0PR12MB5481531408354079CC5C96B0DCFA2@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20240606043808.1330909-1-parav@nvidia.com>
In-Reply-To: <20240606043808.1330909-1-parav@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CYYPR12MB8750:EE_
x-ms-office365-filtering-correlation-id: b146aa6b-4c7f-4cc5-a1b8-08dc85e2d377
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ji740+XKz4IJuLjpozNaOLYEHAEQluvhtLI2GwcGKqfcbXw5+dQs9GfkCPO0?=
 =?us-ascii?Q?VRKqk0+ttlEhe7CrCJbrlR298PqLBVRt2L8AjKuu++b29BDMmyR/XOXTB7c0?=
 =?us-ascii?Q?jhfqVfdSYhrIx4bCr6v1/dyFPGqahcs/YZ1opNz7m6j3UqyRBebc5cYsoJjU?=
 =?us-ascii?Q?ii9yrcbHhI/b5c2Jlt+rWstULydtbTQVbjt+f8Fs52jFBGFzEvjJ2KHEHL6s?=
 =?us-ascii?Q?Ah86imBAdaKai7p6ydslAqN6hqfhJW0EThx7MouwBKUuGZEeX6/lYCY+7wo1?=
 =?us-ascii?Q?J1/3lsStpw/P1gp0mbLjwdDSo3a6TPkPRsm3hXgXZc/8kujE+RTpR5gZpl24?=
 =?us-ascii?Q?LL+SzM6n8/MUMbLvEwm/OI6Wb1iO0zb9Wtm5dh0FycFZxIO0a5fRcngeG92b?=
 =?us-ascii?Q?hfrd4W/0gfJt2YezaRxwaSFYP8vvUjL17rhc3++66w2EfLd2oXtC4yiM7FaK?=
 =?us-ascii?Q?/Zo1naXSYLfkyGB2jcPjMeHthE3sd3G9SHz1f5ufsfn/Vu7o5xP4XFPGpccj?=
 =?us-ascii?Q?zxhnvGhH2l09OKlxSPCh/ybtThJNXm5tcgaW9Zd1SalhySpCHLJOW4tpk/rK?=
 =?us-ascii?Q?Xh5PfTPXLyApg7uvDZIjsaeufgrFXOf46ICnvw/9WqJz+Whu3xBGGsUKF8h3?=
 =?us-ascii?Q?lXH9snkOw5nK0Fiqtgv+rzUgj8qJFKFr7lrDHBuBfUWmfETxT7iLEVxz9nqw?=
 =?us-ascii?Q?WF3LIcY2j+sN8dedPVWOrXu0J9BrWzfIqg9zbWsfBfYw1Q8jVxIn0wQt2YAZ?=
 =?us-ascii?Q?3dfOOKbFN9wobcPBHAlEF64/2s8c29FnmylC7pTxN+3gkEdDQ/rLqJIRlMSr?=
 =?us-ascii?Q?WPVqFtaHmmwPpoBemokCOfdLK7yGh5pbuaM63eHgXq+ujy6dQH6aDgGUURfU?=
 =?us-ascii?Q?l4FOPgJRs7KaamLBN9qK+tCh3h6IR0nI8rQSM1eLj8HzzW/Q77HjUkpBCPmM?=
 =?us-ascii?Q?XWA11LYJBQPItZDOjnITXenJT7VNobrrLnPDpez4AyjyhvtHJd07yD5oeS9O?=
 =?us-ascii?Q?NQ5fE+QsTgPQDmBUz+GepVrIxSVMb7dGfNDO7amt4M7P4Ag8N003WqxSeGv2?=
 =?us-ascii?Q?SL5Sc55WbVKY3r5ZPZdqaNzuNwAC2p6hVSxfOOIxxJPzlw4WA0kLauZrW+9a?=
 =?us-ascii?Q?xyoEaV6orjDcg4uPiu42zTQ1vpX1J0zZ8uF9abjQG2AH5aJ6fQTFKP3pbazh?=
 =?us-ascii?Q?97+zQVRXG3ngEHsw0c3/b5LX7QXDdg6FR+TqI/EZbFhXs5qF1MXDrv8FuZQt?=
 =?us-ascii?Q?p7JIZvlu9y+udG5WQnLvtP5X3ZQ6HeDLoMCuvS9PuPwGLY3CYC5dCamMh/og?=
 =?us-ascii?Q?CKUCy3c6akSWukqt6fqygWxV7N1M6PiQw9GRjcmAnX+0IosGxN3x1VI6VcS9?=
 =?us-ascii?Q?RdifRh4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nXJtypeebOHtN9pD6HgUVKWsV42wb1f+kLK78cwc+fh22LOrvTNdDepPKkEl?=
 =?us-ascii?Q?1LIdN1LlCCiaG1m9zRr1V9Qn9QC4UUWn2UfjigUm3rfkDGhaWEsDYFZiiQBg?=
 =?us-ascii?Q?JYuahFGq8bsKCcniHVkx8m6aWNv4HZufuiYg+VMh6XrVXgpMe0fW/ZPcqIQt?=
 =?us-ascii?Q?hOXQdaHGKa1VLL0AJlnZ6u4SrDmrH3ZsICzCztjYtHtC7fzQo7E4QE7z3L6q?=
 =?us-ascii?Q?TZnQsgj7TSZinmm1zXDL28WQUgioufjqtdL1F2ezAoJNvQM4IQW0t6XF68+h?=
 =?us-ascii?Q?BFXw8bhx4DtufRBd0KIdAAHQg3I7TRPhq4Z9SH4OCxTMpthPZpw4i8/oLGlx?=
 =?us-ascii?Q?1RGfAlRksvGMBv+H2/JqdlWd7K/2p3j6IxymrcfSLrzfLftIyZbbKMEl7wMu?=
 =?us-ascii?Q?iZCEZ9jsG6yXQQc9ucUy6d4je4KpBmZ/g0m2Kw5BLy+g/7Lf24ee+DNSIRiZ?=
 =?us-ascii?Q?3FhxV/v87uKVzTqfhA3XGY8eGuzDQQ1UC0dX/APjgWOansv/MXpM/U++PID1?=
 =?us-ascii?Q?tPgK0U1O1cK7Xe2aA9zRkkDTdrPvsm4ZWLYLjxJAgoGjr/23Ax4Wp4gtBnqh?=
 =?us-ascii?Q?USqwitLo3VdC3a0OLQvj0XDwfIhneD3LSAZScSN5JiKM7m3ahH8Iti290bN5?=
 =?us-ascii?Q?pdFmVS6wUt7SWwPSxluO/gg//dmmRwLxcblsGTt91kSdlVpl6QbiIs/MBPp0?=
 =?us-ascii?Q?G49cu/iy5WKJA88UpOArAj9UhsGTBxuv66Z1TMy5rPeCpdfFAPosFi7Oa3GL?=
 =?us-ascii?Q?yM16upz5m831QSPuu0ArUbDDgPJ1fPJPIZJsvehe3R/FW9BbaY4hgNEPY4OH?=
 =?us-ascii?Q?JarrsHbPyMJc3t3oOhZzvG/0AAVj/u5J/Zp/DhFWpEpmw0G29VvKT++dl/Tp?=
 =?us-ascii?Q?bjwyhtCM7dyINDZEK6W1A5RdN9kHXX4gdYJjfrknzFUgULUJDzUfKdDD9dC+?=
 =?us-ascii?Q?6RmlQEj2YlsFq/FvPLdPZVySZbSXCKvqmqzPRrZVEMWCBDNOfmhODBrvXwRf?=
 =?us-ascii?Q?s/jykgZoA9BpiTSdPptHBy0RedpTE2kWwt9NJkMMNCY4dfw7efTXowLyF7U5?=
 =?us-ascii?Q?enAyXD9xMmSWYhXzORHy0SeUCrWLUeHQBQ7yhHeXeElXCFGsEC3tNiB61ulp?=
 =?us-ascii?Q?loqI8mxLbHFRv7L9tOdA3uvzzYfPNp7kNSHAyHK2dkcE/fR3OrnItERy3Uph?=
 =?us-ascii?Q?RqpS/K2dJteiqjl9LcBqX44rsj2GCeIoFR1DUZVeSbnyH0tuFNhAjPmf1HU1?=
 =?us-ascii?Q?eOArvzYZ7YXb9C1wl01f4xmJZal1z1EXGvrTNc4wI/J+xgFv/bfGtgJ7JCaQ?=
 =?us-ascii?Q?5jwvqJhKjGAME7Qjtjn5+jAr3qbWK3vFQBLJZbWfYf4Td7DGzoOxcC2f8MSk?=
 =?us-ascii?Q?BpgLeYQ2zIupNejbGZJf4mY/afSCgIPlQteECofVtrirROi8R9zAdrjCq6pY?=
 =?us-ascii?Q?0zBSf7cqEbkAvAQGocxCzd4KguEBaJXPmZz7tMA4n7cYyKJobbJYoh1/raWo?=
 =?us-ascii?Q?5aHs8xdMMCD4KJxIW8j9yXUipRulbJE9KTHeHENEG9LoT2XwKJDad0jim4lF?=
 =?us-ascii?Q?D0GI+BcbfFJjDjV1Mj0=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b146aa6b-4c7f-4cc5-a1b8-08dc85e2d377
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 04:40:43.6336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dW1Ig8I/870o4CTJqDtgbxeonbYWjUFcF0AhjI9Dbcvj/6JjEkemobYYeUgsatDypj8yLS8dW4jzM/17sk7qfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8750



> From: Parav Pandit <parav@nvidia.com>
> Sent: Thursday, June 6, 2024 10:08 AM
> To: netdev@vger.kernel.org; dsahern@kernel.org;
> stephen@networkplumber.org
> Cc: Jiri Pirko <jiri@nvidia.com>; Shay Drori <shayd@nvidia.com>; Parav
> Pandit <parav@nvidia.com>
> Subject: [PATCH net] devlink: Fix setting max_io_eqs as the sole attribut=
e
>
I missed to include iproute2 in the subject prefix. :(
Will avoid this mistake next time.
=20
> dl_opts_put() function missed to consider IO eqs option flag.
> Due to this, when max_io_eqs setting is applied only when it is combined
> with other attributes such as roce/hw_addr.
> When max_io_eqs is the only attribute set, it missed to apply the attribu=
te.
>=20
> Fix it by adding the missing flag.
>=20
> Fixes: e8add23c59b7 ("devlink: Support setting max_io_eqs")
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
>  devlink/devlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/devlink/devlink.c b/devlink/devlink.c index 03d27202..3ab5a8=
5d
> 100644
> --- a/devlink/devlink.c
> +++ b/devlink/devlink.c
> @@ -2637,7 +2637,7 @@ static void dl_opts_put(struct nlmsghdr *nlh,
> struct dl *dl)
>  		mnl_attr_put_u64(nlh,
> DEVLINK_ATTR_TRAP_POLICER_BURST,
>  				 opts->trap_policer_burst);
>  	if (opts->present & (DL_OPT_PORT_FUNCTION_HW_ADDR |
> DL_OPT_PORT_FUNCTION_STATE |
> -			     DL_OPT_PORT_FN_CAPS))
> +			     DL_OPT_PORT_FN_CAPS |
> DL_OPT_PORT_FN_MAX_IO_EQS))
>  		dl_function_attr_put(nlh, opts);
>  	if (opts->present & DL_OPT_PORT_FLAVOUR)
>  		mnl_attr_put_u16(nlh, DEVLINK_ATTR_PORT_FLAVOUR,
> opts->port_flavour);
> --
> 2.26.2


