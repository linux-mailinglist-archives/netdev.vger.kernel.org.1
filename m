Return-Path: <netdev+bounces-88450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BDE8A749F
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 21:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BBEF1F2151F
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 19:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A647B137C25;
	Tue, 16 Apr 2024 19:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mIxrHwKo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BCB132C23
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 19:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713295494; cv=fail; b=u19sv0c1u3CHy5s/eYJowlOKRywMTL/lAtLG2a4U6YDAKmbc7FIUfDuS55zvOFFVnU+6zVFXbp8zbRe7/ez5D1eW7tKe0/XIMDWx0YYEZtAs0Rob9mBEytK/0QBnaS28Swpunf34nZoJx6aLvzaII58+mv3d6dScfJbFOdSSQgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713295494; c=relaxed/simple;
	bh=LxPUUM+NFXvsoTx8x9+o51qfekoI0M/qXzFwnhjoyeU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GcIL7qY/qoxCdD4s+aQ5Ftu5qkkoaBUz8Xu11BQSOlzp8Rkal8B9UAJqk5A65CDn8FA3ugP60xjSs7sNDzRbuiIvzCIxjFbgZZbXEoSeeS9TlAYh44KXDtmbaanjBlSEmc7QD3+Lri7URi0LkLvoS0b1U3mVHBlA+zrFO5Z763g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mIxrHwKo; arc=fail smtp.client-ip=40.107.93.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmIvzcPjXUoh9t8bPpEXGFRt2nVRZCoqAUWDEQua1ydPKJV5Dq61V/5hoxhYVky8KSnAaEC5davoIAmsnPdLY1q8SSQq0YWvFh6bmRAZvy+A3XrjoSY4RUvYE0IjTpEuMLYk4LrAiWJpLyXJAFnBIhyytrWKEdfE/ka7zdHpwWyuMSAbJPa2RyA9u04X7SSqvbVUPjPcJ5Jr59QHEuh2x+oTV+p9BvX4ya+0DPs+wYvzCZrKDzMh58TgPDnDDfSLO5XDQDda4ZNg8rshtNodcJu4O1DD9sl+g0qvjrPk5lyY+7KT2T5uXl58iS0CBq5+CKNG0srlLaTtIK2n2Hv6+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQK+fIjueO1ZgiQFUM1wY01cMxF/xdGcdOlUTHYA7z0=;
 b=LWo6C+7FVzIJjkio891e9TKuP0YVYe+NXKtNByzJ5b1cEkuXP2jDzo+LKg81ATCyna/m7go6HZPsXcBlbzZrUMAmwqZRDtgN4lIyRMOxVAR4IQ3gC7jEH2DEA+DMEZldiggmF0ykCJQVDfW0F152AjT1iuQR/t5C1t0sPwd3YkoqcVY2mewZJDDwXEbyiAFYpPWymijrkxoJ3HVheAosaeG/zxfhcMC4V/krSzGpUU4YnxcKtG9XVgHiisqg+93x4ZxbTf1OOR3DpQLaPZrTM0dnidRQV40mmpLVPVBR3+bY2+Aco7LY5xFF4OhqtMet9cnrE4jTAOsXTtk3ahjJpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQK+fIjueO1ZgiQFUM1wY01cMxF/xdGcdOlUTHYA7z0=;
 b=mIxrHwKoGOyAw/PDFIlz21/zspgBklQah7OysmFBkS7p9BGQbuDz88QvCpqPyYC5OJjVbrO1aQmVGerIjo69yKC6sGpDDHjjG4o0lFtE3LD4d+Z9a/NJ7HxXqhcAOgGgRUBpce4wRMLQ+8hxsK7ZSOiv9Kb6ReiWx9oVzF329qAd70JdyAUBThgf+k0rvBqpbUja4d83itaXSF54PYOsQrdZ3qmH4eUNdmEk3EKLw2lC1VhRBSjEwKTu8oUTW4u8+1v8ChvexQQAScnud2pG6pHhn92d59O2/ncJkv1F3u8lT6h4ENv8hxVU9ruPD2fmRBa/ToBovfCnpZxr3HiqQw==
Received: from CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6)
 by PH0PR12MB7886.namprd12.prod.outlook.com (2603:10b6:510:26e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 19:24:48 +0000
Received: from CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::ff67:b47c:7721:3cd4]) by CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::ff67:b47c:7721:3cd4%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 19:24:48 +0000
From: Dan Jurgens <danielj@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mst@redhat.com"
	<mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>, Jiri Pirko
	<jiri@nvidia.com>
Subject: RE: [PATCH net-next v3 5/6] virtio_net: Add a lock for per queue RX
 coalesce
Thread-Topic: [PATCH net-next v3 5/6] virtio_net: Add a lock for per queue RX
 coalesce
Thread-Index: AQHajRMmdbHwvvoxokersDJY/cIzq7FleFqAgATEznCAAL0JAIAAUtig
Date: Tue, 16 Apr 2024 19:24:48 +0000
Message-ID:
 <CH0PR12MB8580D594577B515A12E0B134C9082@CH0PR12MB8580.namprd12.prod.outlook.com>
References: <20240412195309.737781-1-danielj@nvidia.com>
	<20240412195309.737781-6-danielj@nvidia.com>
	<20240412192111.7e0e1117@kernel.org>
	<CH0PR12MB85808460795C1BC5FE4EF6A7C9082@CH0PR12MB8580.namprd12.prod.outlook.com>
 <20240416072712.757d7baf@kernel.org>
In-Reply-To: <20240416072712.757d7baf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB8580:EE_|PH0PR12MB7886:EE_
x-ms-office365-filtering-correlation-id: cc6fc45e-2281-461e-3cf9-08dc5e4ae16f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 XBnt32aQxD7YuqFCgST5p4IZBdV8mGdbnnILweqknm9NfrLl43fkbed5MUxM46/91D8v0m9oe63t++IY3TJZGf0Jwd4ndyNx6fhH9+hLg1ypZ6unRRKAD2h7a0nRxLOA9eY2C7NjbnTubDcac8Tvk2vOkDMvHqaBlB3ttmTom/rDfbw0qE9We0gVx8h/lggqbetXW/dRf9ApFO1ElfAwRylXVe7Lfpt7Ga7OfSLGPpQ2WejdbKUdLX3d2TB/ftifEKroxSBxUjxSwkVQxLS8Ug77wIxbyshUqB2D04stkgmxBdmeyxJwaD+DBeSWBIzFGywgVInphblvss59A/LPOnjxk8EqJyyvUHlQIszJdrKvRTDlpkPPWpGvWOwjZn4OE31YJiBsgTA5s3bHXz2QOxZAmLl/2KX8ONW96oGkmEes9c92Vn4+I4x0S9+YR0LdcnXj1oVdc8LcoY82Qu7HbsgAWeQCRCpvuJxMQbtHypUIFL6Kd5ZoJmCdSj2omoJtFbdegxrKi3BTm+CmHZXMP7UkzJvudK9yWUcbQUETpbEs7hVvR7mZHcRL82ekeeybdDAZtqh+NCxzmIRQuj7DLPXgxbGpl5lU+bL9RvyqYYeYvNsNDXT/KrX/usZhSfdnY5gmZMpZKzznkIdzJH4dAAB/WzzZ5aYSM+MhYuA4y5af1OYKzVlLZIMqtm45N8tyO4vREeO7YOnWMc6C3Q4/Og==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB8580.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fFkO+ju1WaOopHK+Y7U7GQeaIsEDdwic2f4w712Wam2EQOb5b5nW9aFNRCDK?=
 =?us-ascii?Q?9ZVTa3FphYdDQSg/ZX305uCOkCn0AQ1YzGv86X7l2mG3ow52BKL3ERdPnj4M?=
 =?us-ascii?Q?YacKvxKR51vJ5TzLVM4YlEPvmVdAWVTjCPCZHJ2XAH9B3H/g9d4Ikz5HWQCV?=
 =?us-ascii?Q?RivobsueXuH0vUKFeHMl21Kk4YPUXuVFd9SebEmmAy5BVhR42Vc6lMtpbUHK?=
 =?us-ascii?Q?FHI/XPZ+UPChglCpg/PdsLmRKRJmoUKJP/OSipSV1bgw2rpdSvrWwF7TejfA?=
 =?us-ascii?Q?3L6oJloJ/D7eHP4VboflKwuTcdhEtNEVqrwP6DCUStx2tF+2QaxocBZrzcHe?=
 =?us-ascii?Q?Bj4RTShy4DH5woInmBQtOQPolbCmckpR0nkFeqCMgzQrqbbUxrTi+Wjb7Bce?=
 =?us-ascii?Q?jzAN8mpLV78bF2sXNzfWcRlSEFr0RGIFnvQokKAHZjAsPoR/6xpSryyV5Y3l?=
 =?us-ascii?Q?o9kFblQgbO8cwsJaAWw9ApZqPcU7MwJK+vCuxhBJTAzp+YcltFkgtyJV4o+t?=
 =?us-ascii?Q?ul1I5VtANvd59MER2sUwPad71nfjHlLUmd5AG7mj9zoPzeLRvwd5hs0/My0J?=
 =?us-ascii?Q?OhBnPuTRRuiT1nbx08Ahto3WwlrNMruML0YzUnWrbMtbHvz5yJyDGyxXmrKi?=
 =?us-ascii?Q?5aeHSdP+8pm3ScdMit2DjT5ubysAu8vynV+tR8jb9YGp5lp31jAhltkdMjDz?=
 =?us-ascii?Q?4TSX6ePwiHJbiIq5ZVdQXV/ky4QmAbB40FmO4CKBjDnB2AVTIcD6uS/v3aUc?=
 =?us-ascii?Q?4xsrlvDVrsdLQV8JuR4Y5/vPTya72VtOHE7vonUugF8++yk0Hd2BzJiePJxX?=
 =?us-ascii?Q?Idb3c5PCOL34bMzyCd69d6ZJQ+MCK3c+qq5dN88VVqvkBfV0iI6sTyvtLh4v?=
 =?us-ascii?Q?Jc2mnY9tWaykQw5qnDeO9V+zJnl0bURJe3JoChqxIBBAUyo+4IBi/4z52bnt?=
 =?us-ascii?Q?QZ9oHw7tQKIShFKRc8v4AUpAei5jsMcNRN3P+0B+1ITGSE8MegpFivYDCnOD?=
 =?us-ascii?Q?2Ol+UW7yuQQaoOA1bYo6kMk0IB6SWOuHVniU6fkYNLOjcXc+afOS8mYzL6Aq?=
 =?us-ascii?Q?zMAr/G45OmIcUaeO9DhX55PAYrckhKNVOYx4/RtDUTVPtXqFu5owUaTYviTQ?=
 =?us-ascii?Q?9+WvGZeCluXp7DAyOHpG8FXgmqa4QDJ67LvDfcoZk2HREhwyJrLGDl6qooqs?=
 =?us-ascii?Q?UG2vQHojzBSDek1u1eChyor/UsHP+9h7DkvRWIJQPSxJX9YsQq+VjVjJR6iW?=
 =?us-ascii?Q?OfwAv2DOfP3vmAyoux2q6B/hDhHLQUUq5DDNhVTzg7mlTzf5SNyKig7CAa3k?=
 =?us-ascii?Q?qrBn73UGNj7mX5UbBOQx8ovdp6IGedsKfxhEzzEMMYJJFhlJ6HXpWTr1dZ+i?=
 =?us-ascii?Q?OItz/ZBIm8O/KNOU0hmGKipsN4oOt0cDty6viyOBcfVgwdFRrbqlTi+iUODB?=
 =?us-ascii?Q?bheCXoDeRBE0U+Zk9JXufpmWcjkEBKJ4d3MSRhmU9UafWTja+LMfhODBvBXR?=
 =?us-ascii?Q?BPwgjZ7pokDfanaSUFkGHotH+kTcvAvCWwMlZLmtvczTnxtCehAG7QdykCs+?=
 =?us-ascii?Q?85XU2ai0SD7uypYMXWI=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8580.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6fc45e-2281-461e-3cf9-08dc5e4ae16f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 19:24:48.2328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cvheQuuvTx9QIIvezwRZhlmLf9sw5VdqBnB7ideyapsDKi4/Hnf5kxlI6X/rWTmD82JN7hedbcP7+xEVDkKJsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7886

> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Tuesday, April 16, 2024 9:27 AM
> To: Dan Jurgens <danielj@nvidia.com>
> On Tue, 16 Apr 2024 03:15:34 +0000 Dan Jurgens wrote:
> > Which version? It compiles for me with:
> > $ clang -v
> > clang version 15.0.7 (Fedora 15.0.7-2.fc37)
>=20
> clang version 17.0.6 (Fedora 17.0.6-2.fc39)
>=20

Thanks, I was able to see this with the newer version. The changes to addre=
ss Heng's comment resolves it as well.

> allmodconfig
>=20
> The combination of UNIQUE() goto and guard seems to make it unhappy:
>=20
> ../drivers/net/virtio_net.c:3613:3: error: cannot jump from this goto
> statement to its label 3613 |                 goto out; |                =
 ^
> ../drivers/net/virtio_net.c:3615:2: note: jump bypasses initialization of
> variable with __attribute__((cleanup))
>  3615 |         guard(spinlock)(&rq->intr_coal_lock);
>       |         ^
> ../include/linux/cleanup.h:164:15: note: expanded from macro 'guard'
>   164 |         CLASS(_name, __UNIQUE_ID(guard))
>       |                      ^
> ../include/linux/compiler.h:189:29: note: expanded from macro
> '__UNIQUE_ID'
>   189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_,
> prefix), __COUNTER__)
>       |                             ^
> ./../include/linux/compiler_types.h:84:22: note: expanded from macro
> '__PASTE'
>    84 | #define __PASTE(a,b) ___PASTE(a,b)
>       |                      ^
> ./../include/linux/compiler_types.h:83:23: note: expanded from macro
> '___PASTE'
>    83 | #define ___PASTE(a,b) a##b
>       |                       ^
> <scratch space>:18:1: note: expanded from here
>    18 | __UNIQUE_ID_guard2044
>       | ^
> 1 error generated.

