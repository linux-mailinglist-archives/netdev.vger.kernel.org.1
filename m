Return-Path: <netdev+bounces-259078-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Dgk0M1+PlGk9FgIAu9opvQ
	(envelope-from <netdev+bounces-259078-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 16:55:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2390314DBCB
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 16:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A892301BF48
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B5336C596;
	Tue, 17 Feb 2026 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=luminex.be header.i=@luminex.be header.b="M6xAH4P8"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020140.outbound.protection.outlook.com [52.101.84.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3191286417;
	Tue, 17 Feb 2026 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771343708; cv=fail; b=ZRwoDaajd/2svwG+677yNmTRvMZ622xvg+tybM+BbLeRfOYKXyrV9vI1u4krD3t62mmUKVVnRQmLPJrZh0Bx+kCgDzSHo/7ng7wHFjRorLQKEKmoPhPOglkrcBcU/IO9n8gsRHVSJQNpDwCfLe4qiUUTZZsIGmdme5KHxpM8BXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771343708; c=relaxed/simple;
	bh=jYkkv0CUXwpYvCEW1SGiSjiTqmwoSD1ZTfXIRqAw4bA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PBox5+jkTorwFm3WnVLAiZLzHL567gJx4g4oigCnbGYkgnNWGsxPTgDdX4UYYxDSKZfPr6FBAZK6FPZhOkSgWPkdUA7E+P1eUlEEzlZ8nMjkiLOHoeDNRfnLPZEuo2SLqzjIPPfN0rqMJpMJ2f4k77Z7Jd6iw5nSH87AXRVagPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luminex.be; spf=pass smtp.mailfrom=luminex.be; dkim=pass (1024-bit key) header.d=luminex.be header.i=@luminex.be header.b=M6xAH4P8; arc=fail smtp.client-ip=52.101.84.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luminex.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luminex.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jWaT9+nkGSV3rxGc8Vq+D8kyuLe++VbEWqaVCupdA11XDGY2FMatSjXjCdTRxR4UePp0faUOrjrXJW83Q14xPb0B7ZBsFlraOBiOzemJb1H9o4prwfeb0gqicGQ4THMArySp9jX0jKfBcOcpbuB2tj9ehUOyRLyNarr2Ofj1i6sVtj65KDTOLNIxEUGha9AjUNxWScm3et0v83QOyIKkCYJE/1JEPYkmo0FUfNntuuWkN1MoNIiFfNUyRESj1fc6yfbenZvqCo8nfgbnGZCOp+m+a5aE2fd9dfF47jeQ5I0Lqp2tgtxKEjhQ7CfuanRnWXDzXUMmYQlo+2ODsqKT8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzvyI7+Rq3gpZJAakSq4180ycubABwE+ujH62UDsulU=;
 b=HCD4q9WOiq7G6CtcRKleaKoQ8LGUYPqa+yC2n3+x3iw9kds2LsIuxAYx63t5C2tbjPhMnbJPyaMKxTCYlv+SkoB6HBAbFPZNEEbLIRGahtULT6fQdqk8eJmB0VRo2vENCQsPD9t7xVgX7RpUJ5NzmJ72DBjHvyYN3LkshUyVPkQaG/7oLDSmqzoiJM6ZJsSJnw2709JQGhcp7dNM4GBnR7eP8YUlm7R4rnT8VLY+fylqU6Ep3wkYO9hJrzj8uNZ/ng0dpKOLTzmKSAQEnLv1/qLG0YDImLvM0iZXIRQmItflXIpjP9IuM7slBZlRm0d5cNepAJ4Q9xYyFpfJr9cucg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=luminex.be; dmarc=pass action=none header.from=luminex.be;
 dkim=pass header.d=luminex.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=luminex.be;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzvyI7+Rq3gpZJAakSq4180ycubABwE+ujH62UDsulU=;
 b=M6xAH4P8WY8uP7JVqd2Us+cpXE3DXAi1PZaaOlyxdITbY3Zjz9lSPGeGrfn3fxMN6TLrFmYK0HihyngRNT0d/bKeccVN5DwKcRnTLPapjubgYix0l2NzG7hypeP15bklveC7A5bOd1Vwsl5UhMTYhpy5Pd45sNW5SqtSPgzEJOY=
Received: from PR3P194MB1505.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:14c::14)
 by DU2P194MB1566.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:2b7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.12; Tue, 17 Feb
 2026 15:55:02 +0000
Received: from PR3P194MB1505.EURP194.PROD.OUTLOOK.COM
 ([fe80::b6ba:9288:de68:5c5]) by PR3P194MB1505.EURP194.PROD.OUTLOOK.COM
 ([fe80::b6ba:9288:de68:5c5%5]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 15:55:02 +0000
From: Cedric Jehasse <cedric.jehasse@luminex.be>
To: Andrew Lunn <andrew@lunn.ch>
CC: Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Russell King
	<linux@armlinux.org.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH RFC net-next v2] net: dsa: mv88e6xxx: Add partial support
 for TCAM entries
Thread-Topic: [PATCH RFC net-next v2] net: dsa: mv88e6xxx: Add partial support
 for TCAM entries
Thread-Index: AQHcoA1JaWiw6cLPwEyA+Zvxygan+rWG8piAgAAS9EA=
Date: Tue, 17 Feb 2026 15:55:02 +0000
Message-ID:
 <PR3P194MB1505A036B48F93F124CE241AEA6DA@PR3P194MB1505.EURP194.PROD.OUTLOOK.COM>
References: <20260217-net-next-mv88e6xxx-tcam-v2-1-d84cf420da46@luminex.be>
 <ab9b4278-2c0a-4ed5-9da0-2a7a3f928ed7@lunn.ch>
In-Reply-To: <ab9b4278-2c0a-4ed5-9da0-2a7a3f928ed7@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-codetwoprocessed: true
x-codetwo-clientsignature-inserted: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=luminex.be;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3P194MB1505:EE_|DU2P194MB1566:EE_
x-ms-office365-filtering-correlation-id: b4eadd42-af81-4db8-159c-08de6e3ce97f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?d4dMVCXNJKJiTJoC7SZDIM/T+GDHFTkrHX0Ns8O10CXB4Mg1zjDhhaecsU?=
 =?iso-8859-1?Q?FQ1YvzxvmtTi6shlkmolJSsI9LnzYOpCECY0MLFXwHwh/SZES9Zk2fEfbK?=
 =?iso-8859-1?Q?u4/BFS8T+MRSl9vwLkq/8Jk59VgXzYZ84X/FBTpm9tBhrh+hpBBWLt8HWR?=
 =?iso-8859-1?Q?WUGa3tsDv+Wn5Sxs5pCaDsOtji69hqcmoSl86ofoLJUUjE7kH/agOaMWT9?=
 =?iso-8859-1?Q?xOuo2gLU5oYYHtM1hhRYpDCij2PmqMqF+cJDcsU6dMz0YXpqM4DTNAJBvp?=
 =?iso-8859-1?Q?30GZtNCkdqohwn5tAg+1nQn/lwTwT+b1qv7ACXXeKvICf4qDRScUF9ezpi?=
 =?iso-8859-1?Q?ReSU8fF4dNo6rGZubyuBKg2o4FzmH6hG1CSJSl9w6giAb71WS01ZvPSUlL?=
 =?iso-8859-1?Q?zGEANRfbrKh8EsSp4xcP78GuSQzgG2WmkjDIMvjHyD4qpeq9R3fxCTsiEi?=
 =?iso-8859-1?Q?YBqNjDc4wRDDImTXqv/C1f1S5BKeVUvLmC5PVZZoTcGy6I+ZuEAh87HMBb?=
 =?iso-8859-1?Q?7sI0IzggZ7rYc+ztqCfmKHaRCuAXWKXfjZy1Enfob7suUbGGD4xUKSmuIS?=
 =?iso-8859-1?Q?VKibSuWn6XVFevHPCOAdB4Qvjy/dwpu3ixFOegDSGLIRnNze/OvCkvYPwH?=
 =?iso-8859-1?Q?ruVws2phMRk13rYjwcVPxtVOHRwjP1QrFbR9RfliFe99FKs8+Q037kN5hN?=
 =?iso-8859-1?Q?07jjVUk2iq4kc/nBZrjJbzEF5ehcff9ulxu/V6vZyCRQ7gOx5ubEmrl26e?=
 =?iso-8859-1?Q?PA49w9gkX/DTrUQNdtR9fyRWIQ2nAHN+lnQvdCRUI2sEBu8ISyafLeXu0A?=
 =?iso-8859-1?Q?HDLIlzoFKtynl9X99+81gXIsmPktHDijxzt0uwE9u6Dx7M1ab8IBgqhO+y?=
 =?iso-8859-1?Q?NIc+5/BL/P4pjl42/qkh55aYgy83/2jsKl3N6h8mL1EEKRBS+vStaA3Ssg?=
 =?iso-8859-1?Q?2uPengzQj0CTH5I+tNCh/vq+DMapyeiWdS77iIUr9ky7jRRos/YaLE2+pd?=
 =?iso-8859-1?Q?QtDOm4IZ57ytzJV/PQnrnTGS7zz3szTyvza0Pku/lrqbSqLrWp8azy2t9M?=
 =?iso-8859-1?Q?1eXO8Tt9UDnKhg9PNBrDPzkdkOUwlaoJu378K/D/KWmvHP9WZZHVRjSrBj?=
 =?iso-8859-1?Q?MgqiCKlpeqGd0hzRprrexCOuxph2vXfzWYjW7WraiIIsdfhzJOq2r40eq0?=
 =?iso-8859-1?Q?LjZ01pXvvCNsy76g5FGoVTD8rJsS7h4Ljkl8wovdEFVG3HhfnrmI6ah9jx?=
 =?iso-8859-1?Q?NXNl1kRB5vkiFpH7/cwcSzAxcRWRZl/jAFGLFyqjx4ZmEvxh1zqs6vn9Rq?=
 =?iso-8859-1?Q?qRHUzy0H8Um59XeEuNEgVSe7QgxBLt/aJ1xFYvbJ9djO++u3x8zkHT/3xv?=
 =?iso-8859-1?Q?xdfCvk8wQii6RcYlkKsSLKewFG1if+ZaFqyDGwByIlwbf7AeyMjasFfg4V?=
 =?iso-8859-1?Q?xHPGKvhuf9kYCGo/kilGSUQGa7U3pUq6BrkxUfLFP9XSIeUCegqPxRk/ud?=
 =?iso-8859-1?Q?nI0XGjMDdn9X/Go8YufjexHKM1z9zjiVnih85pSVkbJAoCMV0eNWmZrqHk?=
 =?iso-8859-1?Q?cAkj6jsDGX1cHHQRdR0WEGeR5BAE3/3UksArLLdgFM8dWSv1GAaZCUQld5?=
 =?iso-8859-1?Q?OnCcpRJjYIFEqv95zykuTnmeZgYPx5SdS553TiIDdFD7P7lWUSNbHjQ0W1?=
 =?iso-8859-1?Q?cTI+/nVPF//ZRG0fgs4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P194MB1505.EURP194.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?UcRslobOwNsuxOIncbSpcTdP2eX5XnKh//sfVgpnI+Xa5I41aRodW9LRT7?=
 =?iso-8859-1?Q?ZycgFoikf5/zHmkMNHJUyTh/xB7Aqwon/76RJFHhc/eTVR3JgUkO/FS/y3?=
 =?iso-8859-1?Q?uL46XI1pcAOo8pogOQL4MKu/Ifox9+RR9F+j53TPGEh6tqbrXkhWJ527wd?=
 =?iso-8859-1?Q?mar+W3Ko0lDkkwqZUBEUvZeVH0zlXCWkI8NOlXeseg0FRkWf0JKce/klmq?=
 =?iso-8859-1?Q?vZw5t5kYh+mxqkPqlaQdjIFYWaP1dUskToF4SP6LLsmPpikL9Xy5W7Y7bs?=
 =?iso-8859-1?Q?TSRUDs4OymV39pfBCfdalFKQdWUzzZ+2bFJf2kMHa2wjL+M2uWBM56e1Zs?=
 =?iso-8859-1?Q?QJfyEdTZ6S4DXucFgOqrCEKHnncUvYX0SCmUsygcXKE0lFZfiBBWA3wbdl?=
 =?iso-8859-1?Q?+d/2GefEDR8y7zfO82kfcxGjir8s1n+UzKaFp1hkYQwxgkvB5HzzaSI5sW?=
 =?iso-8859-1?Q?i4MvULynnjJcadSKIGIrojPSSDG3el+YH02TPl3ppfRui4jiW1ar9WimSS?=
 =?iso-8859-1?Q?x1L0QyRtEfTRQLhcazrz+BqhtcM4unEq1ogbQxj9lLqLsiQ7ZGYgFHvulY?=
 =?iso-8859-1?Q?fwKX8e4Pg6JB00IpjLU/S29RM5WSyZZVLUQ/HteLy6WaOp2R2+uPM8iGGH?=
 =?iso-8859-1?Q?TJ5fxlzifSDajVV6iHZqEDF79KtF2M9JIht68ZkZ15lZ8nkyVV6FzqfuNH?=
 =?iso-8859-1?Q?zmC+FQ26U5uyKupY5hh96gbet8lDBIDkexN+7N0J9N5uZCAS5kfqObeCvd?=
 =?iso-8859-1?Q?MuvjEIM0Yz7TtLMYBEK7umYY1zeoIdkoSh9mBUHHFy7MaDYWVT9f/Zkmx6?=
 =?iso-8859-1?Q?sIwylf0LFP+z4irwrCH2x+o0PFjPZgd9Yikk3nVMZtnpHqg/zp18ZC6nff?=
 =?iso-8859-1?Q?wQpbU2QiedtwU1NU/TQcQG9Vj3H60BoSxtPcLPAK1CYy8mMlTZEfxlHA3J?=
 =?iso-8859-1?Q?o23bN5aAHE7HKCui/DAqICsD7yvQdJB3fUnwoyksTigTmiJfMn+PcDaDBY?=
 =?iso-8859-1?Q?tloS5XTOQa1lkVbZFS3tvRSmpycVlqU2j1U/ESzwNVSe1X6v05bFSOztPX?=
 =?iso-8859-1?Q?pxG+4nRopiRaScihKgmzf7/fHgzhbPqAFz/t3ocCoQD8+BG4ZTTD2zB3FQ?=
 =?iso-8859-1?Q?v7z1xwjb1kzQTbRYbAFu4KuT6MsZ/TRHHTBlR+sJLttQ/oNSgrQBxXSRCh?=
 =?iso-8859-1?Q?50rEjvua8hKF6DJwImGeaS4qoeuptOusE8Rwg9caGOiXz83sdR8Zytd+FD?=
 =?iso-8859-1?Q?QNrcbWJogyyu8f4PLpcP9wTb8m8CqdAi6chmK3NIHi2rbHpnV3vQhAFnCa?=
 =?iso-8859-1?Q?KWlJrC63gFWF37mZw0as/gaJYDjhNa8u6/N5yppx9KdbvPEyNkhMAIlios?=
 =?iso-8859-1?Q?omC157W6LAX9WZtM/Jky/6UGOWq+sO0JHVjmBNSVM/lZfHP3yfCGD8nO05?=
 =?iso-8859-1?Q?wnsrEyN37Zgr6WbKcddvmBc43tc9gyR8euJxGmC3MQRZouA8BotIp5mZZP?=
 =?iso-8859-1?Q?b0LrDaHGNJ+Itx5Etu+xWxKiaon1EozFHSzf78VJeK6Pxz7WU5QeKgVrEC?=
 =?iso-8859-1?Q?Y+k6f+54tZXN4c00+eFsZNSBliUbEdXfIzUASQ9ODjUiik7BrW1o8sp6WM?=
 =?iso-8859-1?Q?5LchKpJPbGskhmGDFxpR2f1OVMbVDYQyWRHlkWucd6eYl3FWYZBnnvNhPu?=
 =?iso-8859-1?Q?ao0Gf7Try+mRm53XEGEffXkMP5aGtrkM99OKzg43cD2fd6V1AX7ykNvgS2?=
 =?iso-8859-1?Q?hAFEEzm/3v5IOilEK0PvU9boRAUL6YPLKHmgCjg7alLrMxZ4UZzZM72IXe?=
 =?iso-8859-1?Q?C8eq5DcUWMRevpmVpWbSazGq2bHZSpNN7X1SSjvS80t+lBM58O2NqR4uZk?=
 =?iso-8859-1?Q?j0?=
x-ms-exchange-antispam-messagedata-1: boABOOBoncJlQQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: luminex.be
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3P194MB1505.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b4eadd42-af81-4db8-159c-08de6e3ce97f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2026 15:55:02.7110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ca3018c-58f1-4333-afa9-a8744cbe7fc2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xYdRaQ338gz5PFeIkRxN6t6s8BJoVozX3WfLsw9djUoKL6cE3fVsJzC88Mk0jPdum4o2fB+n7Yl0ELSBmqryf0y/0Y07HoikR9RG2olA/u0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P194MB1566
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[luminex.be,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[luminex.be:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259078-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cedric.jehasse@luminex.be,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[luminex.be:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,luminex.be:dkim]
X-Rspamd-Queue-Id: 2390314DBCB
X-Rspamd-Action: no action

Hi,=0A=
=0A=
>> +#define mv88e6xxx_tcam_match_set(key, _offset, data, mask) \=0A=
>> +     do { \=0A=
>> +             typeof(_offset) (offset) =3D (_offset); \=0A=
>> +             BUILD_BUG_ON((offset) + sizeof((data)) > TCAM_MATCH_SIZE);=
 \=0A=
>> +             __mv88e6xxx_tcam_match_set(key, offset, sizeof(data), \=0A=
>> +                                        (u8 *)&(data), (u8 *)&(mask)); =
\=0A=
>> +     } while (0)=0A=
>> +=0A=
>> +static inline void __mv88e6xxx_tcam_match_set(struct mv88e6xxx_tcam_key=
 *key, unsigned int offset,=0A=
>> +                                           size_t size, u8 *data, u8 *m=
ask)=0A=
>> +{=0A=
>> +     memcpy(&key->frame_data[offset], data, size);=0A=
>> +     memcpy(&key->frame_mask[offset], mask, size);=0A=
>> +}=0A=
>=0A=
>I want to look at these two in more detail, i don't like macros like=0A=
>this, nor inline functions in header files. But maybe they are needed.=0A=
=0A=
The macro is used as a compile time buffer overflow protection.=0A=
=0A=
>=0A=
>> +             struct flow_match_basic match;=0A=
>> +=0A=
>> +             flow_rule_match_basic(rule, &match);=0A=
>> +             // ethertype=0A=
>> +             mv88e6xxx_tcam_match_set(key, 16, match.key->n_proto, matc=
h.mask->n_proto);=0A=
>> +             mv88e6xxx_tcam_match_set(key, 27, match.key->ip_proto, mat=
ch.mask->ip_proto);=0A=
>=0A=
>What are these magic numbers?=0A=
=0A=
The offset in the frame used for matching. The Ethertype is at offset 16, t=
he ip protocol at offset 27.=0A=
=0A=
I'm processing your other comments.=0A=
=0A=
Cedric=0A=
=0A=
=0A=

