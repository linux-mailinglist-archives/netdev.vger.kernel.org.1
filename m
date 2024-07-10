Return-Path: <netdev+bounces-110553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B5892D0BF
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 13:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6745B216A9
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 11:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E050C190473;
	Wed, 10 Jul 2024 11:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IDFCzzwd"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2045.outbound.protection.outlook.com [40.107.103.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A507D412;
	Wed, 10 Jul 2024 11:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720611251; cv=fail; b=gAxBoadpFWkPfwWhe8/2qkI+Uw06bnCAEqMOmIA+S4eNo89gm6iu1rUdr1f+L4PwF4lbPi4gWX5AYMHQ3zDtQAowgVjNyREb6skCBn4haQa3KwYWY6CyrJonFk2QRgo7w4pu4Vh++HEi4N2E6d0X/MLW5+A/Wrh9/gSgahO/8mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720611251; c=relaxed/simple;
	bh=cw9qcLJzPqlECRGiBT8wBOjJdozv+Ew5w1FaYYf/MGw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gr5lAh4+tNAR8TX/oE4z/E2dSg492rGqR6utZvmYZtJrMJAhjd13Y/Bc8M4qoFjvIVxdYtY/YtUvTyZZirkDoOqxWLQh/FImG51x3tWn1cYQr3VOFC2ecS2Qm/rw+mqIXBQgBLCgF2ixfKM0tGxT+d5QvcNXUQwUlLnfjletFDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IDFCzzwd; arc=fail smtp.client-ip=40.107.103.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDQ9x1W2yFeEJ3iQGqJIy/iUYDwGBCGdWDcoMhoIOBwWUinFJ4vHI2EXqrMdy69++bepJQyCTbS/Ld1I6BMPyXf/BBDnVmbXRLN58k/at9E9D41MdJUH6lixq3S3e3FAsNkSu5AITKxlKUCtKQ25GQB81OLe8c6235D/B5i6Y5UhlO2HtrqGpUhNUESE8F7X5ymzoT1ZvAg4OdZ5K5k0jotxkEsLmNn93pxKPRAPOVsP5mKAlAQfbwiCoAslZn15YXVxu3f/TC1hf239RhVGgkfkb5/mVSgXZcB5fbwGXVDC8kT6vKShpFAzz7QC7p5K7GGXRafttKX3EU84GVVX1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAgjF1+cjjBXJQfPo31OI4wDoKDNFbU5Izw3Y0T1Aag=;
 b=UMwvbL8NssrJzK8biEaeX4JXatio9TcrTQv89wS84a39KBBs8Lw8tXKWJ/lyE2cz/ZNzKC8T/+dLhCxtz+EsxkL5q6IyEsueE7C8bE/hfVnnkJJZ/glM9o+nKajPQ3DqNv0c60kn25/06ZeZ9z8GiXukewiMeS/x8PabsYg9+GR0D33I8OAtxi6cAmNQoXyS/7WYrdKfdEOJnqdQ3e4bNRqM9+c546D9DRzRYgdnz8Sj3j9pngHgQrp/LVHJnYCSLlqfDQeasrJYS+bcYSTgXCKM+0ObLo3sU0Xzg0NL8gpJniMQ8Vcq66lU26bTO+hiuyfwKr+nVAzLpq1p1hvqTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAgjF1+cjjBXJQfPo31OI4wDoKDNFbU5Izw3Y0T1Aag=;
 b=IDFCzzwdf4d82HwMpkDpGjtfrEiq7VpKnxJGNJ/Wx+rRzZEKFWxEBsd5yKWZszcQqyoxfj3/EMSA++Wfgz9vRiZpS7PV/+5CCaY0cxNZjYWlE6qpZOvz3AQzoZrqq9eSNAocSXcWr7ouJ9SXRyx7KfXw4WWE8uXipeXtwFIWM+4=
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB9077.eurprd04.prod.outlook.com (2603:10a6:20b:444::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Wed, 10 Jul
 2024 11:34:05 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 11:34:05 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Stefano Garzarella <sgarzare@redhat.com>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] test/vsock: add install target
Thread-Topic: [PATCH] test/vsock: add install target
Thread-Index: AQHa0gXDNBM9iTbnZU+dNaZg6A0BnrHvkzMAgAACM/CAABi7gIAAJ5Cg
Date: Wed, 10 Jul 2024 11:34:05 +0000
Message-ID:
 <PAXPR04MB845955C754284163737BECE788A42@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240709135051.3152502-1-peng.fan@oss.nxp.com>
 <twxr5pyfntg6igr4mznbljf6kmukxeqwsd222rhiisxonjst2p@suum7sgl5tss>
 <PAXPR04MB845959D5F558BCC2AB46575788A42@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <pugaghoxmegwtlzcmdaqhi5j77dvqpwg4qiu46knvdfu3bx7vt@cnqycuxo5pjb>
In-Reply-To: <pugaghoxmegwtlzcmdaqhi5j77dvqpwg4qiu46knvdfu3bx7vt@cnqycuxo5pjb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB9077:EE_
x-ms-office365-filtering-correlation-id: e7ec62b9-7a72-4d47-b5f8-08dca0d43459
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?wJW5fkts55WVPWhLaKmZq6Ej4hDFVotG/iF204rXRQIvkli9tHxIvMtQ64U+?=
 =?us-ascii?Q?tEeHe435IbcV/XcRZeUFmM5N0fgJvPCio3+Wbs8DkiCzDcBEyLJ88nlDye1N?=
 =?us-ascii?Q?01K815fn8+JShcwe773RPbD1bmr5YpztceIwmJ0kaUYcLukFRW67rXbUVb8B?=
 =?us-ascii?Q?eiu2XdgFtQuQM08w3U7m7DtuUw3bxOxbZnnX4pWiouu3GHFzEAJRzMCZmyNq?=
 =?us-ascii?Q?9nKRnoMuQ/IBXvQh0ei3K7oEL5xSsiOcpP7D/7UFMATUa7sawNOFgD8R0oGB?=
 =?us-ascii?Q?VYdcPyoWxzU+C9zYHL1HJg4MzcNx3+Ba4T0s4b+/Ux018siHBlCMi8sT/mCA?=
 =?us-ascii?Q?JzrYCkflSDeKYJ7Ol7XPRjanrJcJYXnF0QzHOmmtpvnQjNeVTlLvXSAc4DCk?=
 =?us-ascii?Q?KxYj3cYj5SeECbdJMNKjZexZo+e1dbRsZ/8Uq4ZKLKg8m7z+dgoo8k3o9A7c?=
 =?us-ascii?Q?3M2LCWL0O2HxbSGyx54dskVMGD6OIjxS1MXb1+8pAM2VTnx2BxbAPiGh7Epu?=
 =?us-ascii?Q?5QeZMSw+R5cUiKM8ALd040HXA46/x7WE3JMoMSQRNjbcW3H/c+TBeTM1v9XX?=
 =?us-ascii?Q?aS9Vtj8gPmUSOM1g/elcEiaQXO8FwQGvaMP+lwvpBeev/zc16i0jbU3KBpZf?=
 =?us-ascii?Q?D329lZsMVvrzV9+ymU/OOqki0prMCA8gB7cNJy3TdEkxloqYKOWAYfF7XVur?=
 =?us-ascii?Q?NxXwZtBYe0bvRJeL4MHJyBXvuWPwFpvMcwll2oiGIIGCVVJk+uWzYCCjgDtF?=
 =?us-ascii?Q?UDT61kogdRUNDypI9+7NS4g6bWg24Vn8YfBWMHtHkoLcZdf/mtghkd0JS8Wq?=
 =?us-ascii?Q?s+PV/9T/ogeo2YsHIXszEvfaYNVdttO7kt1QNU5LVRJ3NzUfXxTCcU5nUvVj?=
 =?us-ascii?Q?W3OfuYYWFLQPK89j0GE5+Nn0TJjiF4Sj9ALOmGuwYB4ntpAKIMhmATrFAwm6?=
 =?us-ascii?Q?Rn8gspIAJaoXCV/MZbr99ILu5bR1v5IUWfgDXGBhBUIY+XiW5kkL0BnbJ4qC?=
 =?us-ascii?Q?qlAGa10Vnqdp6/SxbryUMr9mPNR9+0IggJxOWUVZWYrkvumTLLVEzzn/M40N?=
 =?us-ascii?Q?MSpJY2wTMpZYbyToEMz5cEqsII7XssAW4VC31l8FUNEITPwF743TmTTXhsFa?=
 =?us-ascii?Q?D0ouDDidJknz+zNXn37AzkFIjJpxEhp58CFdysgAtQy0DF4Xl5qKLlW6eFAf?=
 =?us-ascii?Q?lVmKFb61oARoDpYDGXkXuQNlBkFS57BUoLcwwf1MbQFIgjQVQrIWA85I28sj?=
 =?us-ascii?Q?lt4sq5gyTb/2RC9sMYUtUXUgb1gJy8/A83YohHJmyo2Del+yJO68lKQWkslL?=
 =?us-ascii?Q?goaVxgwAa6SnoQyWEoOhnWx5N/pcnXV3o3LDdQLNh5XFtgpU6NmGt4Aijaux?=
 =?us-ascii?Q?h1d2un6dDl/TDyiCRvEBi6r5RVNGkAHXKUQcAyVG4Y4mWEm2Jg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SZwCiPQH/y/GjoQKhERC7o4TdhgwEloeAb5h30HixxhBOiJVOhNgNyMUfg/i?=
 =?us-ascii?Q?89rUAkf0cD8OTnr03mwCkNvvPdia2/S902mCIRovQkTXM6udKx3q0y3dZUUg?=
 =?us-ascii?Q?OipKdBCghWAareXjW7H7qhzZqVZSQ5PPyQn36abVpPRFT3rE/AlBXg+h132V?=
 =?us-ascii?Q?vgpOmP+tzoqxCjxTqa3CBvlvoZ7MAqU4T0P45MeDl8Fv40T05PGgohFO+j1i?=
 =?us-ascii?Q?onWRYzaopCFvnyL0ueddT6u9yfqNUWl8fzUZ/RSvIyVP8ZvV8b2YP/SnN6xT?=
 =?us-ascii?Q?MswFXjtLJtVoUU0suKXN9UTH7o+UjpvlIs6trS2KcHVfsjcmNxNFJfjg4p0m?=
 =?us-ascii?Q?GC7MlvailpTLMqlls02JjI7K4Uizf1QVp4M2pyMAwMxNSMeatDYJi6iJa5cJ?=
 =?us-ascii?Q?mUuK68aCxDtWiXcP6OtHjSyHdq9WpQXIpZh8m6SrGb9u1JoZc1hP63RvF28B?=
 =?us-ascii?Q?4ViXR6dn94xpKXK5J96OGpDMT01PEU4Gp6ZSVmMK7il4b9TZZjlGnywO2dkE?=
 =?us-ascii?Q?qq9Ynj4leK2frgXpuWUGgHso+xZtii341Z4AJg5ZsOYk4Rji0893KUGarE5j?=
 =?us-ascii?Q?11lqBXanB/FUQ0XFGQk8oqkz1/poYp98Ntm3F24dbD4RRj069q6ng/u/9uKO?=
 =?us-ascii?Q?5Mwrx8d8tq8bSd+zPXMItkWNwV1L6sXljfAnO6ezL8qOlE1OJCWklHPONM4x?=
 =?us-ascii?Q?6FwwDKtzK8rrj0L5eIYf1gFLxeMXhlxOdT02mB03bsw3O7eBhCFowscxoHoE?=
 =?us-ascii?Q?ILkwd4XEeJyF/4jNpdzxKPFHyPSkYMslwEie9MT3wE0lbrOuW2YpJaDihzV+?=
 =?us-ascii?Q?SSMvtxZ4GPAXeIUAIkWTktvTSxqrK8aRhZzcuJ/V4NvhrMThgZX/W0zepBDW?=
 =?us-ascii?Q?ZvWEp37r20hhh9acfbdcF7m5tSUcW8wfJ4XWybGlPBkqTLBF2NnUAeSqkyRS?=
 =?us-ascii?Q?0qpFknRSoYenoZ8F0mJcoZXFxtEiYQ9zb/BinIKu0tsNPt1giFin7/wAFYW7?=
 =?us-ascii?Q?sENDps56aaj3XUC89lcyncaD2KVquLHIIeyRa6Z6ofkDvs1zdFLOmy5GJek9?=
 =?us-ascii?Q?Prc7WI+vc7Q6dsnsFbGjhtfJ6WjxNWJIRPFxS1gUxbVHP8QTsdVZwyVZ0Ze2?=
 =?us-ascii?Q?x4PEvj+fXfMJyEhq5QUtPOb2Jx9q0xKaBN653kCIELS8csfnPjo0kVEDiW5p?=
 =?us-ascii?Q?aNCy7WqOvPATxHCVJohf9yuPNx9CB2zuYLiBnxxh3Prql45mi2eWBtD0hXBC?=
 =?us-ascii?Q?PnuyZijM7IkkQQWWNQeBnnN7KL97ojgVVgfQI6rH7NY6DhrL+KDpwdlzLRgz?=
 =?us-ascii?Q?QEQA03Ys8VSc0PgureH4xI4rclGZQrfu1odJTZr3qZ1qUhbRED/Ui9zKo18T?=
 =?us-ascii?Q?ULyhIbj8OtjKqSdbe8vohRmRIRq4vZY3JFPssxNu/OTq7s9fZu8ngTfiz8wi?=
 =?us-ascii?Q?2dyVCfReLZfYQHKSNA1TWw8rBPd4FMEi4pJTsBsSa8sMYsjeo0Y6RDTHBc6f?=
 =?us-ascii?Q?niFAQ0Y7GYSdTrZqSZxUFZwKWQRyJsVE/1DjeB2ey2Atvn2/zWb42KfJkmjh?=
 =?us-ascii?Q?KTo13LFwReh9XJKD3zg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ec62b9-7a72-4d47-b5f8-08dca0d43459
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 11:34:05.1437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MKKl98fqrVKDIpla1C3wq9XOPWyUY8GVgRe1tProGSkJeV5t/PyIB05veb6DSZTn7yH9OyCmgrFuRJT8zNQ0rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9077

> Subject: Re: [PATCH] test/vsock: add install target
>=20
> On Wed, Jul 10, 2024 at 08:11:32AM GMT, Peng Fan wrote:
> >> Subject: Re: [PATCH] test/vsock: add install target
> >>
> >> On Tue, Jul 09, 2024 at 09:50:51PM GMT, Peng Fan (OSS) wrote:
> >> >From: Peng Fan <peng.fan@nxp.com>
> >> >
> >> >Add install target for vsock to make Yocto easy to install the
> images.
> >> >
> >> >Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >> >---
> >> > tools/testing/vsock/Makefile | 12 ++++++++++++
> >> > 1 file changed, 12 insertions(+)
> >> >
> >> >diff --git a/tools/testing/vsock/Makefile
> >> >b/tools/testing/vsock/Makefile index a7f56a09ca9f..5c8442fa9460
> >> 100644
> >> >--- a/tools/testing/vsock/Makefile
> >> >+++ b/tools/testing/vsock/Makefile
> >> >@@ -8,8 +8,20 @@ vsock_perf: vsock_perf.o
> >> msg_zerocopy_common.o
> >> > vsock_uring_test: LDLIBS =3D -luring
> >> > vsock_uring_test: control.o util.o vsock_uring_test.o timeout.o
> >> >msg_zerocopy_common.o
> >> >
> >> >+VSOCK_INSTALL_PATH ?=3D $(abspath .)
> >> >+# Avoid changing the rest of the logic here and lib.mk.
> >> >+INSTALL_PATH :=3D $(VSOCK_INSTALL_PATH)
> >> >+
> >> > CFLAGS +=3D -g -O2 -Werror -Wall -I. -I../../include
> >> > -I../../../usr/include -Wno-pointer-sign -fno-strict-overflow
> >> > -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -
> >> D_GNU_SOURCE
> >> > .PHONY: all test clean
> >> > clean:
> >> > 	${RM} *.o *.d vsock_test vsock_diag_test vsock_perf
> >> vsock_uring_test
> >> > -include *.d
> >> >+
> >> >+install: all
> >> >+	@# Ask all targets to install their files
> >> >+	mkdir -p $(INSTALL_PATH)/vsock
> >>
> >> why using the "vsock" subdir?
> >>
> >> IIUC you were inspired by selftests/Makefile, but it installs under
> >> $(INSTALL_PATH)/kselftest/ the scripts used by the main one
> >> `run_kselftest.sh`, which is installed in $(INSTALL_PATH instead.
> >> So in this case I would install everything in $(INSTALL_PATH).
> >>
> >> WDYT?
> >
> >I agree.
> >
> >>
> >> >+	install -m 744 vsock_test $(INSTALL_PATH)/vsock/
> >> >+	install -m 744 vsock_perf $(INSTALL_PATH)/vsock/
> >> >+	install -m 744 vsock_diag_test $(INSTALL_PATH)/vsock/
> >> >+	install -m 744 vsock_uring_test $(INSTALL_PATH)/vsock/
> >>
> >> Also from selftests/Makefile, what about using the ifdef instead of
> >> using $(abspath .) as default place?
> >>
> >> I mean this:
> >>
> >> install: all
> >> ifdef INSTALL_PATH
> >>    ...
> >> else
> >> 	$(error Error: set INSTALL_PATH to use install) endif
> >
> >Is the following looks good to you?
> >
> ># Avoid conflict with INSTALL_PATH set by the main Makefile
> >VSOCK_INSTALL_PATH ?=3D INSTALL_PATH :=3D $(VSOCK_INSTALL_PATH)
>=20
> I'm not a super Makefile expert, but why do we need both
> VSOCK_INSTALL_PATH and INSTALL_PATH?

INSTALL_PATH is exported by kernel root directory makefile.
So to user, we need to avoid export INSTALL_PATH here.
So I just follow selftests/Makefile using KSFT_INSTALL_PATH

Regards,
Peng.

>=20
> Stefano
>=20
> >
> >install: all
> >ifdef INSTALL_PATH
> >        mkdir -p $(INSTALL_PATH)
> >        install -m 744 vsock_test $(INSTALL_PATH)
> >        install -m 744 vsock_perf $(INSTALL_PATH)
> >        install -m 744 vsock_diag_test $(INSTALL_PATH)
> >        install -m 744 vsock_uring_test $(INSTALL_PATH) else
> >        $(error Error: set INSTALL_PATH to use install) Endif
> >
> >Thanks,
> >Peng.
> >>
> >> Thanks,
> >> Stefano
> >


