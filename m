Return-Path: <netdev+bounces-292732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNBkFxhVGGoQjQgAu9opvQ
	(envelope-from <netdev+bounces-292732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:45:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E73835F3E6C
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E32F3019C82
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4083E5EE1;
	Thu, 28 May 2026 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZFdR/6Lg"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACB82D8795;
	Thu, 28 May 2026 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978979; cv=fail; b=FBw0tmODyhyrUw70I31GYV4u3n9uP+0FZ6bRE61SOpsvBRA28kBbPPWD1h99yWh9/LBAUdN0ELZpuqohuWrOaW7T4vQ11Zyqk2t3ZhNiuLt4hVKkeAPCWpd8uabSL6yxAxvKoT7o2wygCShxpzqxzDxb0JpwngwQup6Y6wnxd/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978979; c=relaxed/simple;
	bh=7uFhF70/juSPdPXnIU9LfaRIC2kFwJOHYuhXShXRnzE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A2b3haRcUbOJsYk71Nmn+YXVEcoijL8AqbcSIO746sxS+OWsJCKrC6to7SFdGpQAvRJxBC5tWIqzQNqOLcTlEkusvX2SeuuM3NKTqSEEECGb65aEQ49ZYWqzMruweU7OzqY+KfAxt9UzwuDPjmxCKozSz7fznUKtQvtkMteWvkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZFdR/6Lg; arc=fail smtp.client-ip=40.107.208.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d71MjRAUEkeopNB9CTIJeHFcb24tycRV3e9b1Y8TGxR+2bzE3ztNbOufakQGljJG4xKAjjcw1ZxAmMz80uZo4q2bLEPSV79PcPOnQeTeApW2On1f++lTJrdUz6+H17y9nbIDQZ9X97PDUSjzOVUAAuT8ZwWT6e05/zAhYf4qd8QAYEWPLOmVCipOhOgUOXCMP9MwPcZrBg8W0VHdg6m3z7zjTSYHBL4aTgKSeKFNByX7tc86ndQgU7INWKKc/4bD8WGM84H4rp60AwChaLRgDTgfoSN1dUsRkcJjur2hsw52/kXBEB9kHnO6L8CLWgG3pAmzWt9nFv0Hiz1PtpotYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uFhF70/juSPdPXnIU9LfaRIC2kFwJOHYuhXShXRnzE=;
 b=cFPBZK5V1KVFb0EKlivmduHhp4Cfk9KHe8mYIs70dEodK80EoCb244ZmYyG+xoH5qw5TyqQk0sQJvapbS6VHBvZdEGwUmZ9GKMELPW/wPnDExXGE7nolwqa9llbQ9AKmS071GDLCg5Qi1uFyFJ0lNJURB/eImV1Q5hqsVt6dtj7UKH/MHhW/VokxaTtTavdTMJnFcYP2+78tNvSIo7JUhPZ4KZqLWbs6lOLCXnMGy6xxweFfdi2xVSM3vbJV1Acq3NoUfjL8cOZw29WLBf9XFH/+6WHAUhrXJ72ityQRdqv/j1I7/ZgAfmsVx9a5rJKI9vQmcQeq26SxRTw+oNhsqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uFhF70/juSPdPXnIU9LfaRIC2kFwJOHYuhXShXRnzE=;
 b=ZFdR/6LgJz+y6Mn8dczM7yx5jzbUO5rUork8jT9EgoHzzybtkzw2IkVQUbFV87ssp/V4h1zKUhJnQZFo4SOiZ2v7ZSgF6bCyp7WYtmp/DqgF3puUkKD9d8cxRl+PUAJYPW0zX5FzitIWPIUsAxhLLrgLrH0i1Zqxc9gWHdtLvh6CEDXsaPznGi7Ml8RrNCFbehZivRZ7/h826a2VvnvBop2D+5kvWyXh7Pz9YRmziuyXhLIJP1LRAmPnVr/Fmpsl8Gngawbre2Nmnrlo4oQHRpvRnEdy7+vY/duGOm8F3oxIPW/g00Fh3Q8Z7bWMmuGETzK+1p7SqG518xHAtwAhOw==
Received: from SJ0PR12MB8113.namprd12.prod.outlook.com (2603:10b6:a03:4e0::20)
 by IA1PR12MB7544.namprd12.prod.outlook.com (2603:10b6:208:42c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 14:36:12 +0000
Received: from SJ0PR12MB8113.namprd12.prod.outlook.com
 ([fe80::fe5b:a71d:fca1:fadb]) by SJ0PR12MB8113.namprd12.prod.outlook.com
 ([fe80::fe5b:a71d:fca1:fadb%4]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 14:36:11 +0000
From: David Thompson <davthompson@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "bryan.whitehead@microchip.com" <bryan.whitehead@microchip.com>,
	"UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] net: lan743x: avoid netdev-based logging before
 netdev registration
Thread-Topic: [PATCH net] net: lan743x: avoid netdev-based logging before
 netdev registration
Thread-Index: AQHc5LUscPiHBMwY0kOblphmtVQSXLYWKhOAgAEuk7CACtlMoIAAS9qAgAEW6HA=
Date: Thu, 28 May 2026 14:36:11 +0000
Message-ID:
 <SJ0PR12MB8113B4665034597ABDA5CCCFC7092@SJ0PR12MB8113.namprd12.prod.outlook.com>
References: <20260515215229.3881949-1-davthompson@nvidia.com>
	<20260519184115.3c70f2ac@kernel.org>
	<SJ0PR12MB8113A2493154C98E13D246F8C7012@SJ0PR12MB8113.namprd12.prod.outlook.com>
	<SJ0PR12MB8113B58970F2E9B7A6EA5B75C7082@SJ0PR12MB8113.namprd12.prod.outlook.com>
 <20260527145601.512dbce9@kernel.org>
In-Reply-To: <20260527145601.512dbce9@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8113:EE_|IA1PR12MB7544:EE_
x-ms-office365-filtering-correlation-id: 547d39eb-e020-4c79-6dfa-08debcc676fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|38070700021|18002099003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info:
 2M1yLNhhU03fGsQekVYxAWw6hltxC+NSDACYeO6my5NhLjW48Wf0YKItk6OddH1TxxfP9PO03ipsQjVs81JNexaA30xsI5pbXzLixQNyeHRI82wAN5VHWWT+pYy5vn5ko9tb06dugPs0iwE5Hjan0SvA/H4q8HMRZFIK9v/H2cvdaH6FPUXg0rq/X3DD3LquX72x6V8v7o2CBn5Pcm9JQNkXkJBQjNiSIsaRaF0pkRtvtqhtFx6Wz01CwFjAm8pCoJ7z3dOk3rIUenopO0rBRAdb9+0dslqmRI0O4mWyoGOKwy9x5SDoHZohkTbPXNqxtpEPgN2lSi0DZJ45pANUzO37KYylkNMzVwlYf/cjtUnE1xzwvsehxKv85AK1lfV+9FxsnNwib8sQmX5/SDMwnjAb70JjdssvnoWpDVfN6riClidCpg77sYFdyPY56IH5ci1G93qXIPL9pQ4VykQfEe64kGO9lhVn7cehDUa4KXPxh6bti8mesxTn2rvUTnyH8AITuqKp9iDxgCdo04/4iotzbJqoK7ir0Qv5xuhlX7yGDosEn3VTEQOFizbLvLHRdxig4ehL1AhxlBDNwIKWehvzZjVgssExIHTrkLKvEwqgjGTdYVviNsR99lfd30YogupafDAzOlmZZ1Oi/jSFyNEuiHRk9TVdU+3SJW4KCsRs3JFH6hfeKOOfv+mHfj+R4ieKkAmYUu948m4Xx6LgpUPK7lLoq1S4GbE7mC/cnRSCWAbOLgHOJaQRZo73O2dI
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB8113.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(38070700021)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GnZF/5lrhdCFcvp4IG276KIsCpYDC3R9NJR3OsnNube+kC+iThcltMOIXLIO?=
 =?us-ascii?Q?W5AVzEElUAUimGsDwjY3nj5ivYlguEwNloiJeKCWQFF2uyCL4+EvkFwQop9D?=
 =?us-ascii?Q?8n289jNwDt9YtU2JRYV7O1TxevjiUwsbSCTtiTvQFakIBd9mg8Qho+d+Z5SJ?=
 =?us-ascii?Q?dOAVs2zXNe2Rd+i18sAlXUkL501i3ljz53xrKsnXo5zouPtkW4ecW5Y8HEWr?=
 =?us-ascii?Q?wd6rUHolvmcf6yxzh+aCvvNVKKXyF/LhQIm+ob469/Tw3omDBHcUsw+jQREf?=
 =?us-ascii?Q?OhNCXp5+pngQixmP3wX7Mk/5kd3Wb3IztdgLu1CYgujZ2szqfD3+6+L69pGY?=
 =?us-ascii?Q?Xir5Y4qx6BzG5dg3uMR1ZCl3icM8uEdQCb3zZxk9JoqQF/wA7QLG9xDs1Gl2?=
 =?us-ascii?Q?VS5geHRFKIp+Ret08jKOibbxkrjE2aLRTNygRsdRyExk3frsujSHIlWndDG8?=
 =?us-ascii?Q?4d9bjZ3QHdt9DcfKKqh3ZIYubLcjcs6+0NKXrJFEVmQ31so+1nrcHeql+Gwp?=
 =?us-ascii?Q?nBgobITdjAD7P6ehgusz7EWTitTRAXXNM3yH4POqDH+/xpQXSz8Hr0LQzdfX?=
 =?us-ascii?Q?qqjzTNj2K0l0aypoFFfGrw89evNe/9+OakWujmAzHrHhiEAjLs+Dy4eZzetV?=
 =?us-ascii?Q?I0x58dxgjs+nrP3SmhTWz9evKsy/JUD//TH7h6aoYf4sQ32S+kcMTj+trbXG?=
 =?us-ascii?Q?cwlAjgz002AW87DjMBYx/bQZgGmzEyXgLO9RbZesUFwDcwkV+jZyF2o3aDp3?=
 =?us-ascii?Q?ujWQxyvoIoDTERJ4GsH4XMsA7LJxaH3TlBaTUGP6inZsR4uwuTAeUyde4pPm?=
 =?us-ascii?Q?r6D1lk464bf/9YSJJktVnyK1Oa5jgicEj8rEH+Ag8er4lkgeM/tkz9LKYp5X?=
 =?us-ascii?Q?kRDkc8IrsgwBXQtnKp813OcG3J47lEpj4l/8bXhv7T+NeO7mcCZvBFVsYE7M?=
 =?us-ascii?Q?neYEaM0RV7iSB4wp5/GQk42+D2pDWOHWPu5EaNvllFzNsOJY1XKX7V7Nl52A?=
 =?us-ascii?Q?u8yZY+GYGMBRxw6txjH0pgO28qA6ShTjxUQ1Bv4PqPcU2ynsqbRmJjcIeCoA?=
 =?us-ascii?Q?Qg322RymKFk2CnLIoBIELT/bML7dlra/0nLry+DYY0cVqT6800dDwp0as/RE?=
 =?us-ascii?Q?f7SrFJGZNRb6W+n0Ih1GaM2asObYbFimJy/LLLIDA/ckxFFxnJgOsUP3ManY?=
 =?us-ascii?Q?hA/chwb/2uKm7sgryLrgH8jVPyCNL2gwNWyFK5VDc8alLRMn4DLORcP1oU+B?=
 =?us-ascii?Q?+1T8QtVvWSqG3NOJrtBdgjNP5UXN8KUEqMrVfTVeO7JvTqfduCIekNmgBUYP?=
 =?us-ascii?Q?q0JeXlEnY00DxzopTOw6D4dQheRxFYbPg8rxWFcE5wS0oC4ds/P6vCGG3kKs?=
 =?us-ascii?Q?G4Lj3IafPVoRrBm0uZMh0FLWA7GcNThLfjBni781C1+aoaGlg1qQBz6aWZWH?=
 =?us-ascii?Q?tfQMvxM2a/w2V9wjLVlu+z5bcOQlDwnXqMuKRmZeDO+V6WIa8hxoK6rRDbxY?=
 =?us-ascii?Q?Lm3bwdd03V6WWaRq625a/nJGSgBZ+5koxzznLvjLx1AQoL3Jczd7ATmGRLKv?=
 =?us-ascii?Q?yKe6sM+EF0cPv910SWU9H3bbDz1QNnflL9icK8VdGuY6iyYC1Vh8i8oMujH7?=
 =?us-ascii?Q?cIwMHQP6a7ezaKbcPdZE1D3wye03JU9mGPOugjsEtKDLZaQOQISUUEKbkRED?=
 =?us-ascii?Q?q5e5pKTstvArGTI+SWN9cxArWu1433FvZDAckS5rNF08VDRSlgWwNc7gFn6n?=
 =?us-ascii?Q?41ez0/LsPQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8113.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 547d39eb-e020-4c79-6dfa-08debcc676fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 14:36:11.8378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZaTSjNN5Fa87ORSchLo3U8m8rxSmF/sjyqrgjedC8XCMKW/AB40JYSA7W+xuL4TTB16WkJF2NCX48fr+VwJz3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7544
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292732-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davthompson@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: E73835F3E6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Wednesday, May 27, 2026 5:56 PM
> To: David Thompson <davthompson@nvidia.com>
> Cc: bryan.whitehead@microchip.com; UNGLinuxDriver@microchip.com;
> andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> pabeni@redhat.com; netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH net] net: lan743x: avoid netdev-based logging before
> netdev registration
>=20
> On Wed, 27 May 2026 17:27:13 +0000 David Thompson wrote:
> > While preparing v2, I realized it makes more sense to add a module
> > parameter to control the initial value of msg_enable, instead of
> > hardcoding it during probe. I'll update v2 to include this change,
> > which means I'll also need to keep the checks that were previously
> > always true.
>=20
> Sigh, no. Please don't perpetuate this stupid log categorization.
> The module param is not present, that means nobody needs it.
>=20
> Also when you repost please target net-next and drop the Fixes tag.
> I don't think it will make the cut as a fix given Linus's message from -r=
c5
> announcement.

Thanks for the reply Jakub.

I will remove patch #1 (which adds the module parameter) from the patch ser=
ies,
update logic in patch #2 accordingly and create a v3 for net-next. =20

- Dave

