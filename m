Return-Path: <netdev+bounces-163494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB989A2A6B8
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 12:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E865168F40
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 11:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF2C22654E;
	Thu,  6 Feb 2025 11:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sKectqnN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCD021773D
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 11:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839820; cv=fail; b=L87vyACc9LA3Us9x3bMkDavKblCBj9SVW+z3ual2V9oizMvJrYouR+8jf5qERpof84VeE1xot710uHSa5g9SRybfqg3pJk8NdKaejkAhfF9DzAZUsxJ3BqBSIOpl0qpE2XrkMkIR/VyTLBILoLr8lNttdGdMgtXfeLlGJUm+U2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839820; c=relaxed/simple;
	bh=sDwJmRkFviHS/trHLBi3npt3Ax+/HWmh/xMLOSjqZTE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IpNZ5RPvWhvOaVHAOGha4FGKNQjMKt+wgmRUaN5FmwD01xEisuICQitB2zZVreIFkWUGLTdoSvHhAaRCJOIuvT49/AP5F7Z4U+a9gXYBIWNcv0XjXMxUfsYmq3w+gimfNSlhQQn0t7av3UIX0pRY88Vxc8lzKIwDVTPWFGTC9gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sKectqnN; arc=fail smtp.client-ip=40.107.92.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0iFORhicAHvp2OWRm3fAFH1g9DH5TWqmuxQR8F0mhaf2r2qtkoWXSxtETGp0M8phcryYgKbiRw+ME5ykoUPtmbH8lz5B7GqPicybcG4Z8xk0MkCQvfvbn/za2i4KWFh2R9W+Da61ZWXjDGnZzQa72MNS7bhCfWsnfq5HcAW8h4cmCJanuMdykvx72BnMjhnaSmAphv1jFZODHpJKGYjOroOFeuQLlTRYssZ6LJCr3I/GZB3dYivRLF8mKV3YwvRXYjeirki5Y2bAitRcRTZpmSj8sFijNd79uHADnKmUes+ceHpwoLaAGAduo5X106geECvHFGSStRVB6GGTvPW3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dqdl9WUxORpm21oFSBM3x4EYyTckWhFKZPimLKh/Xe8=;
 b=OFXAoAaxkyS0iwnlfAhIu4PeD0qfVD/vaUdJeyVxZwFYUjyfXcaCsjNI16p9b9QONbgMnINHICrUmk3oSA+WE4lW1p9Tfr/NyCCLgCenXdH5RvZjYEAOQsiBRRrCswEwQGkVjU2oLwnlWxe3IAjlgeeSUbZGGQbjdreqPvaRvtSo8V/O23aseM9qncI4wIsV3PrnoRLoTGPADwWED8JtHYoO0Ln1JO3nYFu/3MzXdtFQv4Y7Ba4w1nlc266yoVIS7zc6KgotjlihlnMWWyy9SZz5wn+sSSeGNLgC2HX3oxT26aq7x0/TlFzd8nO+qgYTOfEhJZB8WbIyeXWGZmIccA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dqdl9WUxORpm21oFSBM3x4EYyTckWhFKZPimLKh/Xe8=;
 b=sKectqnNWrjbcqNN55vsaNiJ3WtOBcSxrr94zklMXRjhTjS2WMOldzqEiLmsLtJg77DhYE5+QU3eqeRpi2DNBq6Mr4i0OqlKeT+cON33LlDzeX6SnHfAIBqnOAcjNMopBg4D0/bkDiEPXoasM3TrDDyB9tmPOyTFUGv2w2eQRRxUu3U/9hU19GLi/YpfuzG0X75e1Cx9A3qvjsZeFWp30baW3H497gLJQvPEUGYX26vB8UqJegN4CsqJtu116oBlSCFKWNU+l5T9ebFjE7YkVoJpM+sOiC/1VeCfcOKwXTNKDFCmSxjZqDva5//60JgGB0coiXTzbkOg+uhnh7ilBg==
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by MN2PR12MB4143.namprd12.prod.outlook.com (2603:10b6:208:1d0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Thu, 6 Feb
 2025 11:03:35 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703%6]) with mapi id 15.20.8398.025; Thu, 6 Feb 2025
 11:03:35 +0000
From: Wojtek Wasko <wwasko@nvidia.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "kuba@kernel.org" <kuba@kernel.org>,
	"horms@kernel.org" <horms@kernel.org>
Subject: [PATCH net-next] ptp: Add file permission checks on PHC
Thread-Topic: [PATCH net-next] ptp: Add file permission checks on PHC
Thread-Index: AQHbeIN4Z0q1N33xHUWcCAbVpwD6fQ==
Date: Thu, 6 Feb 2025 11:03:35 +0000
Message-ID:
 <DM4PR12MB8558CE01707ED1DD3305A9FCBEF62@DM4PR12MB8558.namprd12.prod.outlook.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB8558:EE_|MN2PR12MB4143:EE_
x-ms-office365-filtering-correlation-id: 6212b77c-6601-4b25-1fd9-08dd469de6e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?HaqbPg3qA4M7VL8lw07vWM+nP+LIiOJBFIcbPj+nsYtNpVQR5d9NMPFZ?=
 =?Windows-1252?Q?1hTl8QF4smw99CP2VVdKW8WAfNFFia/DSMBRvm0SMuTHQF0qE9z1s3qY?=
 =?Windows-1252?Q?EfBTAELM5g/CywNjL4rsfVTQPgy5Ut6oLa2veZLCo7NyK8O1x2f13XTi?=
 =?Windows-1252?Q?5SN2zkT3885WXezu68bhfmOG0fAh6ptknwkP/NwDI3SM7fJHTvoxgmLF?=
 =?Windows-1252?Q?xvwmQ+iBh7jb3DdabY9v22cULxDd5UvFAnVC7OMLa4HTM8L0L5AkYXes?=
 =?Windows-1252?Q?H6BXfeLL+95YdFlpKXwDMJhcuJRdPT1Mhlkoh/71vhE7M4/xMpmSb/Gg?=
 =?Windows-1252?Q?c8ZG2hcIj5BaZyRnHUFUve2Xbmg+XxGwYIR86c7adrzv0WUEbu/drnya?=
 =?Windows-1252?Q?30rgxsM6i3YAVmiFYCKDpcFB+ToGUKkP0ma5WjrHzqrYSZqzT3auoM2j?=
 =?Windows-1252?Q?n/lguszhw8VbrAwKn8u+CLNzK4CLOG9Qv3mWJSu03Tq3k3lvU+Gmr5F+?=
 =?Windows-1252?Q?yqU0g1Wze/LGj4phLAVx3g4JoNNYCbokmg8bIIEu9W3fYlR3Ue4N3H6d?=
 =?Windows-1252?Q?XoOWkeWy569GP5WpVkr4I/6vla7dXTcH7718ydKaBEjQYSLDnubdNITT?=
 =?Windows-1252?Q?55M9WiXu6vplBg6sNaRg6uMW1RBrh58iICvWDf67vqAdHX/2pjDtU2sw?=
 =?Windows-1252?Q?mCaBa95WW9z053nAmzJj9NSv4MufqrjsMtjp0P7TJZwUKSYX8hbX0dHx?=
 =?Windows-1252?Q?Q0dq1CVT67aQGVI+EZvD+m4wjqN3rNjvnzlHZvFyjRs77Yfzy1Bx0tHE?=
 =?Windows-1252?Q?P0i3e3HvItjHBjFZObir1upknHpQWbiHndwTMPm0k1bJQAaYdyNp982J?=
 =?Windows-1252?Q?vUywK/jXah3EMJy/EkXifdpYM+0FLwLVg1EVasgkhN4tCsOt0iRtEVn5?=
 =?Windows-1252?Q?OOKeR7/+DHTDHqAkMC/FSjp7Ks28wYIf2JSdQSHapL50lnUa6alnhyto?=
 =?Windows-1252?Q?6b8xeM3BzpzREwLH8AgDrqcHykfvXoKmfs0QmEdDBHW4vV5VtG6sVYU8?=
 =?Windows-1252?Q?qVwLvmjDHjkWBQsgEDiKsujqJ/r/Yio4LpHO5WSjqz6khidPYdCLF0/m?=
 =?Windows-1252?Q?AWvnQgOhWpPJhxyX1CB9OTJihUMaBKOx3WaQPvUrspcdVnDw0b+6OXdO?=
 =?Windows-1252?Q?sdHA1P6Mc8KlyQaso+uQb3KAJUimhUbxYu92pW5qzFdy/R4EikiJfrU7?=
 =?Windows-1252?Q?jqPPfnYS1zbiTAHT0/M3idlZUK3ebBDNBGFFjMn2hFgPrwiom/U6h3tu?=
 =?Windows-1252?Q?/pMVwgoZsROISrk7N0oPGv8GeMwchzasnFVBpJCsU96ooM5aRQA7FkAr?=
 =?Windows-1252?Q?YhpQf7lro+YDYK1x5y79XxuEytk9bEA3Po/j6dEznqZSspP9EQb8J5Ys?=
 =?Windows-1252?Q?VSNL7DEawpscUq64VVEuHNVKhxEPoJByFSj9ddYA3I4JR+xEwHiDw+RV?=
 =?Windows-1252?Q?54xFhBPwKZQZ+597JNqB/9mZL3TpL6hRtQM4zXBCp8Ot7ephDxSnxLPC?=
 =?Windows-1252?Q?7oHIdIJJg0fxmc1l?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?2Hb8Vh1LdXUjCWqDdn3V6vpL8/kZK5cif5LyjjLjGsIJyY94x6wfh96m?=
 =?Windows-1252?Q?3xXyVn9XXq8cv/utFMaBj6vlLuRcgQRORD6ALKOWJfkRkPRaW9kcFTzs?=
 =?Windows-1252?Q?rlhETFkA/dKAe0OyklWv1vtgTQYfnd0nob7HDYnLQiHT6aF3v9xQwafN?=
 =?Windows-1252?Q?eYIPUkVoHmrzR/NYR+OyC47dezJmDaW92GBrZPqc1Bs3HFTVUdqUO9Zw?=
 =?Windows-1252?Q?UUuSRHwoww6eaJd77cTt+bkOmi7BBhHRPUtgU+FAgql9+nt0I00MYG6I?=
 =?Windows-1252?Q?heRXKinyqxPSxTgCr88xyY4iaeRt/j0W2xxtINUKZAP7S1oBkvOa/ybW?=
 =?Windows-1252?Q?ccBXxef0aLFJZkpf9ekj5lwM2YcMxNNo4YwiLSaQEoRJZ/IkdD0PFlrz?=
 =?Windows-1252?Q?VPJHBKYSlBXXbFkEFmMHKv60W1Jduzk1futkFPyisbOYgAB+10E7Bzk9?=
 =?Windows-1252?Q?J74JUW1YT/dHZVjleUv2EQyI+S7Wee069pYwi0tdKmdoydhSSRDzydjA?=
 =?Windows-1252?Q?Z7co+2ijcaw8YTxGaPkOfZRGhgq01NoUm1pu5wbmrN2/hgR9DduZVeZO?=
 =?Windows-1252?Q?flXxfxHx2o7r8x7JNMOJTP0tzOjHG539t+Tz8OMZySAemtgghMvBaE8v?=
 =?Windows-1252?Q?+xW6uSWSlgIP0I51PwYbuzg0Bcgi40NjZRoRkWbL9bWAYTKnlZAd5SoB?=
 =?Windows-1252?Q?2beuSEavE2Gt7iIBJ88jTdux/bTkB1zCTetstGp1CJvSvk/YeYtQzFHv?=
 =?Windows-1252?Q?NPKwHUiAJCNFZIiaBe5NX2eQtOYnEUcqvTQjACx+RvgbUlXti1/rExs8?=
 =?Windows-1252?Q?lHV3zhkexSPFdhIN2pRIuTdcwQ3/q7aBpyjzARpduY5pqQMyLspJeym1?=
 =?Windows-1252?Q?xsAfiLFvrn+bkOfu1odDxS/02sM5cGBgqKsiCWWazO8i+UQdR/UUwbLR?=
 =?Windows-1252?Q?zcZgh4EK7SZnDiIUIGN+ELvYEVgxCL9+MUaJ6ttkG7GMgMxEOtc2WcnT?=
 =?Windows-1252?Q?7sCa1zNg2vU0F0togiVTeqQUeocYZ6z3b5lyJ+0xbk3yPhJQpm8Z9fKZ?=
 =?Windows-1252?Q?vfYcRtLVV8ZcelY9ZyZCd8PDm2LUBrPSSlJUbx+F0KyKtQ8mm/3Y8isW?=
 =?Windows-1252?Q?nZhgWzoV3zN0MLVka/kbIvQaaGxY2Q634cXJNRkhrw0rhzvqUGhw+bHz?=
 =?Windows-1252?Q?+b4O8If9upgGqWpLaEasu9U1JOsrbMiJgWXGhV1+kkdd0RCPwZX2KHK+?=
 =?Windows-1252?Q?Y1k2F0v4K5TvRll+mI/04GA2u1L9qADWxUi2VjJw6U4sXVHqj90HnqGz?=
 =?Windows-1252?Q?FTw0GeTiTPsIR0UamKMjtKNdJ1FHv4klwW+CG3p/ERp1nsYNpXgCNUFD?=
 =?Windows-1252?Q?xAqBNCHYKerNGtkPu78WIe2rzgzc2DEsSA/gV1SvsMLnzbhJv7vsPfX1?=
 =?Windows-1252?Q?uQSvmXY86xN5PThAZD+hotB/z/MyMyXHC2dMMIfD1rATOyHamY4wxfVl?=
 =?Windows-1252?Q?VWzQxBTmjpcq3XSY0Ryq19cy0FV9YjsP4WbwlcyqsIxm2XXV+U963Mva?=
 =?Windows-1252?Q?ElbrJ2CL02Ey7y+0DTEf2ijpIV7yCaZZ/zuuR23MPGyZR2CyAvdwfYLi?=
 =?Windows-1252?Q?I2y9WBNoDlrYMRuwzwEBKMgjn8TFN0aLzNfXi9lZar2b8vWpKZej+vjs?=
 =?Windows-1252?Q?DMR0zyaHizw=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6212b77c-6601-4b25-1fd9-08dd469de6e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 11:03:35.3589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xv0/tVPTff+qji2mb/Ct/AO18ry2JMwwguZvCQ6yfVejWoronF3ulxUYUNQ0oDY6E4MHUWD/xwC0DRroKSae3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4143

Many devices implement highly accurate clocks, which the kernel manages=0A=
as PTP Hardware Clocks (PHCs). Userspace applications rely on these=0A=
clocks to timestamp events, trace workload execution, correlate=0A=
timescales across devices, and keep various clocks in sync.=0A=
=0A=
The kernel=92s current implementation of PTP clocks does not enforce file=
=0A=
permissions checks for most device operations except for POSIX clock=0A=
operations, where file mode is verified in the POSIX layer before forwardin=
g=0A=
the call to the PTP subsystem. Consequently, it is common practice to not g=
ive=0A=
unprivileged userspace applications any access to PTP clocks whatsoever by=
=0A=
giving the PTP chardevs 600 permissions. An example of users running into t=
his=0A=
limitation is documented in [1].=0A=
=0A=
This patch adds permission checks for functions that modify the state of=0A=
a PTP device. POSIX clock operations (settime, adjtime) continue to be=0A=
checked in the POSIX layer. One limitation remains: querying the=0A=
adjusted frequency of a PTP device (using adjtime() with an empty modes=0A=
field) is not supported for chardevs opened without WRITE permissions,=0A=
as the POSIX layer mandates WRITE access for any adjtime operation.=0A=
=0A=
[1] https://lists.nwtime.org/sympa/arc/linuxptp-users/2024-01/msg00036.html=
=0A=
=0A=
Signed-off-by: Wojtek Wasko <wwasko@nvidia.com>=0A=
---=0A=
 drivers/ptp/ptp_chardev.c             | 52 ++++++++++++++++++++-------=0A=
 drivers/ptp/ptp_private.h             |  5 +++=0A=
 tools/testing/selftests/ptp/testptp.c | 37 +++++++++++--------=0A=
 3 files changed, 67 insertions(+), 27 deletions(-)=0A=
=0A=
diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c=0A=
index bf6468c56419..c86a31395cdf 100644=0A=
--- a/drivers/ptp/ptp_chardev.c=0A=
+++ b/drivers/ptp/ptp_chardev.c=0A=
@@ -108,16 +108,20 @@ int ptp_open(struct posix_clock_context *pccontext, f=
mode_t fmode)=0A=
 {=0A=
 	struct ptp_clock *ptp =3D=0A=
 		container_of(pccontext->clk, struct ptp_clock, clock);=0A=
+	struct ptp_private_ctxdata *ctxdata;=0A=
 	struct timestamp_event_queue *queue;=0A=
 	char debugfsname[32];=0A=
 	unsigned long flags;=0A=
 =0A=
-	queue =3D kzalloc(sizeof(*queue), GFP_KERNEL);=0A=
-	if (!queue)=0A=
+	ctxdata =3D kzalloc(sizeof(*ctxdata), GFP_KERNEL);=0A=
+	if (!ctxdata)=0A=
 		return -EINVAL;=0A=
+	ctxdata->fmode =3D fmode;=0A=
+=0A=
+	queue =3D &ctxdata->queue;=0A=
 	queue->mask =3D bitmap_alloc(PTP_MAX_CHANNELS, GFP_KERNEL);=0A=
 	if (!queue->mask) {=0A=
-		kfree(queue);=0A=
+		kfree(ctxdata);=0A=
 		return -EINVAL;=0A=
 	}=0A=
 	bitmap_set(queue->mask, 0, PTP_MAX_CHANNELS);=0A=
@@ -125,7 +129,7 @@ int ptp_open(struct posix_clock_context *pccontext, fmo=
de_t fmode)=0A=
 	spin_lock_irqsave(&ptp->tsevqs_lock, flags);=0A=
 	list_add_tail(&queue->qlist, &ptp->tsevqs);=0A=
 	spin_unlock_irqrestore(&ptp->tsevqs_lock, flags);=0A=
-	pccontext->private_clkdata =3D queue;=0A=
+	pccontext->private_clkdata =3D ctxdata;=0A=
 =0A=
 	/* Debugfs contents */=0A=
 	sprintf(debugfsname, "0x%p", queue);=0A=
@@ -142,7 +146,8 @@ int ptp_open(struct posix_clock_context *pccontext, fmo=
de_t fmode)=0A=
 =0A=
 int ptp_release(struct posix_clock_context *pccontext)=0A=
 {=0A=
-	struct timestamp_event_queue *queue =3D pccontext->private_clkdata;=0A=
+	struct ptp_private_ctxdata *ctxdata =3D pccontext->private_clkdata;=0A=
+	struct timestamp_event_queue *queue =3D &ctxdata->queue;=0A=
 	unsigned long flags;=0A=
 	struct ptp_clock *ptp =3D=0A=
 		container_of(pccontext->clk, struct ptp_clock, clock);=0A=
@@ -153,7 +158,7 @@ int ptp_release(struct posix_clock_context *pccontext)=
=0A=
 	list_del(&queue->qlist);=0A=
 	spin_unlock_irqrestore(&ptp->tsevqs_lock, flags);=0A=
 	bitmap_free(queue->mask);=0A=
-	kfree(queue);=0A=
+	kfree(ctxdata);=0A=
 	return 0;=0A=
 }=0A=
 =0A=
@@ -167,6 +172,7 @@ long ptp_ioctl(struct posix_clock_context *pccontext, u=
nsigned int cmd,=0A=
 	struct system_device_crosststamp xtstamp;=0A=
 	struct ptp_clock_info *ops =3D ptp->info;=0A=
 	struct ptp_sys_offset *sysoff =3D NULL;=0A=
+	struct ptp_private_ctxdata *ctxdata;=0A=
 	struct timestamp_event_queue *tsevq;=0A=
 	struct ptp_system_timestamp sts;=0A=
 	struct ptp_clock_request req;=0A=
@@ -180,7 +186,8 @@ long ptp_ioctl(struct posix_clock_context *pccontext, u=
nsigned int cmd,=0A=
 	if (in_compat_syscall() && cmd !=3D PTP_ENABLE_PPS && cmd !=3D PTP_ENABLE=
_PPS2)=0A=
 		arg =3D (unsigned long)compat_ptr(arg);=0A=
 =0A=
-	tsevq =3D pccontext->private_clkdata;=0A=
+	ctxdata =3D pccontext->private_clkdata;=0A=
+	tsevq =3D &ctxdata->queue;=0A=
 =0A=
 	switch (cmd) {=0A=
 =0A=
@@ -205,6 +212,11 @@ long ptp_ioctl(struct posix_clock_context *pccontext, =
unsigned int cmd,=0A=
 =0A=
 	case PTP_EXTTS_REQUEST:=0A=
 	case PTP_EXTTS_REQUEST2:=0A=
+		if ((ctxdata->fmode & FMODE_WRITE) =3D=3D 0) {=0A=
+			err =3D -EACCES;=0A=
+			break;=0A=
+		}=0A=
+=0A=
 		memset(&req, 0, sizeof(req));=0A=
 =0A=
 		if (copy_from_user(&req.extts, (void __user *)arg,=0A=
@@ -246,6 +258,10 @@ long ptp_ioctl(struct posix_clock_context *pccontext, =
unsigned int cmd,=0A=
 =0A=
 	case PTP_PEROUT_REQUEST:=0A=
 	case PTP_PEROUT_REQUEST2:=0A=
+		if ((ctxdata->fmode & FMODE_WRITE) =3D=3D 0) {=0A=
+			err =3D -EACCES;=0A=
+			break;=0A=
+		}=0A=
 		memset(&req, 0, sizeof(req));=0A=
 =0A=
 		if (copy_from_user(&req.perout, (void __user *)arg,=0A=
@@ -314,6 +330,10 @@ long ptp_ioctl(struct posix_clock_context *pccontext, =
unsigned int cmd,=0A=
 =0A=
 	case PTP_ENABLE_PPS:=0A=
 	case PTP_ENABLE_PPS2:=0A=
+		if ((ctxdata->fmode & FMODE_WRITE) =3D=3D 0) {=0A=
+			err =3D -EACCES;=0A=
+			break;=0A=
+		}=0A=
 		memset(&req, 0, sizeof(req));=0A=
 =0A=
 		if (!capable(CAP_SYS_TIME))=0A=
@@ -456,6 +476,10 @@ long ptp_ioctl(struct posix_clock_context *pccontext, =
unsigned int cmd,=0A=
 =0A=
 	case PTP_PIN_SETFUNC:=0A=
 	case PTP_PIN_SETFUNC2:=0A=
+		if ((ctxdata->fmode & FMODE_WRITE) =3D=3D 0) {=0A=
+			err =3D -EACCES;=0A=
+			break;=0A=
+		}=0A=
 		if (copy_from_user(&pd, (void __user *)arg, sizeof(pd))) {=0A=
 			err =3D -EFAULT;=0A=
 			break;=0A=
@@ -516,15 +540,15 @@ __poll_t ptp_poll(struct posix_clock_context *pcconte=
xt, struct file *fp,=0A=
 {=0A=
 	struct ptp_clock *ptp =3D=0A=
 		container_of(pccontext->clk, struct ptp_clock, clock);=0A=
-	struct timestamp_event_queue *queue;=0A=
+	struct ptp_private_ctxdata *ctxdata;=0A=
 =0A=
-	queue =3D pccontext->private_clkdata;=0A=
-	if (!queue)=0A=
+	ctxdata =3D pccontext->private_clkdata;=0A=
+	if (!ctxdata)=0A=
 		return EPOLLERR;=0A=
 =0A=
 	poll_wait(fp, &ptp->tsev_wq, wait);=0A=
 =0A=
-	return queue_cnt(queue) ? EPOLLIN : 0;=0A=
+	return queue_cnt(&ctxdata->queue) ? EPOLLIN : 0;=0A=
 }=0A=
 =0A=
 #define EXTTS_BUFSIZE (PTP_BUF_TIMESTAMPS * sizeof(struct ptp_extts_event)=
)=0A=
@@ -534,17 +558,19 @@ ssize_t ptp_read(struct posix_clock_context *pccontex=
t, uint rdflags,=0A=
 {=0A=
 	struct ptp_clock *ptp =3D=0A=
 		container_of(pccontext->clk, struct ptp_clock, clock);=0A=
+	struct ptp_private_ctxdata *ctxdata;=0A=
 	struct timestamp_event_queue *queue;=0A=
 	struct ptp_extts_event *event;=0A=
 	unsigned long flags;=0A=
 	size_t qcnt, i;=0A=
 	int result;=0A=
 =0A=
-	queue =3D pccontext->private_clkdata;=0A=
-	if (!queue) {=0A=
+	ctxdata =3D pccontext->private_clkdata;=0A=
+	if (!ctxdata) {=0A=
 		result =3D -EINVAL;=0A=
 		goto exit;=0A=
 	}=0A=
+	queue =3D &ctxdata->queue;=0A=
 =0A=
 	if (cnt % sizeof(struct ptp_extts_event) !=3D 0) {=0A=
 		result =3D -EINVAL;=0A=
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h=0A=
index 18934e28469e..b14e7d26a11c 100644=0A=
--- a/drivers/ptp/ptp_private.h=0A=
+++ b/drivers/ptp/ptp_private.h=0A=
@@ -35,6 +35,11 @@ struct timestamp_event_queue {=0A=
 	struct debugfs_u32_array dfs_bitmap;=0A=
 };=0A=
 =0A=
+struct ptp_private_ctxdata {=0A=
+	struct timestamp_event_queue queue;=0A=
+	fmode_t fmode;=0A=
+};=0A=
+=0A=
 struct ptp_clock {=0A=
 	struct posix_clock clock;=0A=
 	struct device dev;=0A=
diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftest=
s/ptp/testptp.c=0A=
index 58064151f2c8..edc08a4433fd 100644=0A=
--- a/tools/testing/selftests/ptp/testptp.c=0A=
+++ b/tools/testing/selftests/ptp/testptp.c=0A=
@@ -140,6 +140,7 @@ static void usage(char *progname)=0A=
 		" -H val     set output phase to 'val' nanoseconds (requires -p)\n"=0A=
 		" -w val     set output pulse width to 'val' nanoseconds (requires -p)\n=
"=0A=
 		" -P val     enable or disable (val=3D1|0) the system clock PPS\n"=0A=
+		" -r         open the ptp clock in readonly mode\n"=0A=
 		" -s         set the ptp clock time from the system time\n"=0A=
 		" -S         set the system time from the ptp clock time\n"=0A=
 		" -t val     shift the ptp clock time by 'val' seconds\n"=0A=
@@ -188,6 +189,7 @@ int main(int argc, char *argv[])=0A=
 	int pin_index =3D -1, pin_func;=0A=
 	int pps =3D -1;=0A=
 	int seconds =3D 0;=0A=
+	int readonly =3D 0;=0A=
 	int settime =3D 0;=0A=
 	int channel =3D -1;=0A=
 	clockid_t ext_clockid =3D CLOCK_REALTIME;=0A=
@@ -200,7 +202,7 @@ int main(int argc, char *argv[])=0A=
 =0A=
 	progname =3D strrchr(argv[0], '/');=0A=
 	progname =3D progname ? 1+progname : argv[0];=0A=
-	while (EOF !=3D (c =3D getopt(argc, argv, "cd:e:f:F:ghH:i:k:lL:n:o:p:P:sS=
t:T:w:x:Xy:z"))) {=0A=
+	while (EOF !=3D (c =3D getopt(argc, argv, "cd:e:f:F:ghH:i:k:lL:n:o:p:P:rs=
St:T:w:x:Xy:z"))) {=0A=
 		switch (c) {=0A=
 		case 'c':=0A=
 			capabilities =3D 1;=0A=
@@ -252,6 +254,9 @@ int main(int argc, char *argv[])=0A=
 		case 'P':=0A=
 			pps =3D atoi(optarg);=0A=
 			break;=0A=
+		case 'r':=0A=
+			readonly =3D 1;=0A=
+			break;=0A=
 		case 's':=0A=
 			settime =3D 1;=0A=
 			break;=0A=
@@ -308,7 +313,7 @@ int main(int argc, char *argv[])=0A=
 		}=0A=
 	}=0A=
 =0A=
-	fd =3D open(device, O_RDWR);=0A=
+	fd =3D open(device, readonly ? O_RDONLY : O_RDWR);=0A=
 	if (fd < 0) {=0A=
 		fprintf(stderr, "opening %s: %s\n", device, strerror(errno));=0A=
 		return -1;=0A=
@@ -436,14 +441,16 @@ int main(int argc, char *argv[])=0A=
 	}=0A=
 =0A=
 	if (extts) {=0A=
-		memset(&extts_request, 0, sizeof(extts_request));=0A=
-		extts_request.index =3D index;=0A=
-		extts_request.flags =3D PTP_ENABLE_FEATURE;=0A=
-		if (ioctl(fd, PTP_EXTTS_REQUEST, &extts_request)) {=0A=
-			perror("PTP_EXTTS_REQUEST");=0A=
-			extts =3D 0;=0A=
-		} else {=0A=
-			puts("external time stamp request okay");=0A=
+		if (!readonly) {=0A=
+			memset(&extts_request, 0, sizeof(extts_request));=0A=
+			extts_request.index =3D index;=0A=
+			extts_request.flags =3D PTP_ENABLE_FEATURE;=0A=
+			if (ioctl(fd, PTP_EXTTS_REQUEST, &extts_request)) {=0A=
+				perror("PTP_EXTTS_REQUEST");=0A=
+				extts =3D 0;=0A=
+			} else {=0A=
+				puts("external time stamp request okay");=0A=
+			}=0A=
 		}=0A=
 		for (; extts; extts--) {=0A=
 			cnt =3D read(fd, &event, sizeof(event));=0A=
@@ -455,10 +462,12 @@ int main(int argc, char *argv[])=0A=
 			       event.t.sec, event.t.nsec);=0A=
 			fflush(stdout);=0A=
 		}=0A=
-		/* Disable the feature again. */=0A=
-		extts_request.flags =3D 0;=0A=
-		if (ioctl(fd, PTP_EXTTS_REQUEST, &extts_request)) {=0A=
-			perror("PTP_EXTTS_REQUEST");=0A=
+		if (!readonly) {=0A=
+			/* Disable the feature again. */=0A=
+			extts_request.flags =3D 0;=0A=
+			if (ioctl(fd, PTP_EXTTS_REQUEST, &extts_request)) {=0A=
+				perror("PTP_EXTTS_REQUEST");=0A=
+			}=0A=
 		}=0A=
 	}=0A=
 =0A=
-- =0A=
2.27.0=0A=
=0A=

