Return-Path: <netdev+bounces-193297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A3DAC3785
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 03:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB6813A7073
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 01:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F06654654;
	Mon, 26 May 2025 01:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="MynP2SvO"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4A1134A8;
	Mon, 26 May 2025 01:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748221374; cv=fail; b=h0BZFmeodCRasy79aLAbZesJb2LmD8UQna3T6aN0yCjfjxpxQemeqPIubEO1KJ0JBD3SCHxrOCN7IOv0ILAwsH8cyTtw3igAq6kAhYixcK9WrVv1/L9oKTzD8p9/vLezhziuhzq0Y0V9dMcTuntVdjLxiOT4VL2E0OswY6xeUus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748221374; c=relaxed/simple;
	bh=OkJ0NPMgiBs6a5Pif9iXXmmSyy7kQMXDE2NR1nSXDR0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=paiG8JXnvDqoKUXsX1F4EbJnQMhjvscBUlBRwwCvjCgg7BVp6115po1+whpRGV65yq9lfpy+Ap+KDtT27uvSpgNPwrRNk7fJKjoF53OhXYmLh6k4jcNV4v+/E9KxKz1oucuJtkDUcmlw5N/9Z4DDuLPhQH+3aNX1z16XYTL6OMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=MynP2SvO; arc=fail smtp.client-ip=40.107.20.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzTIjv8jTGiC79DlBPoIrNxcmGp56WM6IDrHWgYJtyVw/+nBO+kih9YH84Ue3Me2gFoQz8Fd3WkYzLwttWRYUpZrfzVGC1iTtqfWMMzWP6Yey9yiF7Tjk3DGvYdTUF+Wx0yEh4olflfOlvhzg8Fr9k7Lmi/vXU4JmSqdPPOsH/ffj28WtTIYYRCPuLY9UcBeiDyxScVJuvXn+g2oVItDymnCkMv6pU2EVAyQ7hBWAHTrt6l9IJzwmBZvf8rdPgOFRTAfAamu3bzgI4aqfstTSsjSjRNUe1RpYgGvRMSci01o72mt7bW5jFMpust5h7UjOz4hI7EqJilOKIUqrBPihw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76bL5ryw5Moc5lkjChCREYrpXhV3Pkh2oVT2+Xnq+u0=;
 b=Irrg8UwO5XvBftl5ZU/4XiY/NeChwS/CahGdDrWrcvO65F2QML0YcJAQ6mh2vIo+qdhEPlwkBsys+zAIvs9eJdek1ol21QmlgCgL1Pt5Th5mEa3fkcT18YKyePyFyJ+6iNSkV7LAoGXQL0O+i9If/w+AgCLpVli/v/5ECK/zhjmfFNtFDLJMdiNsCIXYFgfN6QTKIJmZRZwall9RXZUsi/CxXrC8ha2LEvK/Cke7GWsGdBTKRNHfr9+VoqMuKxGbd3JLaAbrWK5yGr2HVRaY5gQm8qrhOlHfE82Sx400D9jq/UrXFVcMKgVM/htzoVvM2Rq3xsv524Ej1L8RHDaHoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76bL5ryw5Moc5lkjChCREYrpXhV3Pkh2oVT2+Xnq+u0=;
 b=MynP2SvO9t006zvZdmiReWga9erL0uiYBVHE5ZjJZLXYqVc82PnIx3582YpA4CZN9emaNj7iIxpQ2dbvApW/GDgL4wJKEG5MP4ymnjU+IR41ZyJzfzDGbo3pXx4v7QZMiYJWOV7ZQMjHj7tKlotCeHEB81QJaUOznUpRGib/zOIhTjPUnvxLv1u5T1IUXGhEhX5gFsZW7gANz2YPVWdy2w4Olehesc4039KFLkUbOtemtk0CckNPjVD3UNU75eGlv0ntOCxSfqxjcGReyEM+454sjCjKWLEdFDuzp5Ih75aruBxrGWELuPs66GW/SCvyQrbal+eQi8jLPxO7OM1g5A==
Received: from AM8P189MB1314.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:249::7)
 by DU4P189MB2717.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:56a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Mon, 26 May
 2025 01:02:48 +0000
Received: from AM8P189MB1314.EURP189.PROD.OUTLOOK.COM
 ([fe80::4123:5ff7:5d38:8900]) by AM8P189MB1314.EURP189.PROD.OUTLOOK.COM
 ([fe80::4123:5ff7:5d38:8900%3]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 01:02:48 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Zilin Guan <zilin@seu.edu.cn>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jianhao.xu@seu.edu.cn"
	<jianhao.xu@seu.edu.cn>, "jmaloy@redhat.com" <jmaloy@redhat.com>
Subject: RE: [PATCH] tipc: use kfree_sensitive() for aead cleanup
Thread-Topic: [PATCH] tipc: use kfree_sensitive() for aead cleanup
Thread-Index: AQHby9iD/KkjLtBMq0yEMiLhz0+ATbPkG1Ww
Date: Mon, 26 May 2025 01:02:48 +0000
Message-ID:
 <AM8P189MB13141C14A4AC551B718CB285C665A@AM8P189MB1314.EURP189.PROD.OUTLOOK.COM>
References: <20250523114717.4021518-1-zilin@seu.edu.cn>
In-Reply-To: <20250523114717.4021518-1-zilin@seu.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8P189MB1314:EE_|DU4P189MB2717:EE_
x-ms-office365-filtering-correlation-id: cc0767c2-7dd2-4970-d7e4-08dd9bf1084c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?F+O86v6vSEiecs/eHKEbBU5La9qVWt/ETeZmhEYNNQ9P+Z+cA6DgkTcqjb72?=
 =?us-ascii?Q?aD1y1hxV5ZK76IGUZ4ulfB2PZ4iZK9KZ973ZLnmBRRxqS/CIztfQKAgvZNtN?=
 =?us-ascii?Q?6qwufQ1epWDzUJV32a637hbuMSI2khPLJZvAtv3aYvctBLsP33BtjXQOpEdA?=
 =?us-ascii?Q?5XRXIPQWiUJ0y4O8a/Y7+g24gLOJFVm8JNzH9j/ZcOfh7YfkkxcDbbkFaPr5?=
 =?us-ascii?Q?VuruV+ak5EuLVlKFROyAIRX8/R1i+z8b9nJnx9wCugelkzvjUC7Czu99vA/Q?=
 =?us-ascii?Q?Qn8lkrq0Sbonu+ofCz0yAKjB9j6Tk5Z2IitRblY4Noy1pQT12l+2uTtkQ4iW?=
 =?us-ascii?Q?6h1J3g8btLjXYb1xpKHowPgu5/aOIsqEWtBHsoJhxbZVBaVzjvxxCaP3VkEh?=
 =?us-ascii?Q?udcNggrT089JQ5WrpxkIPVErjpfsI8scuinWL4qB57m1IPBbcu6UBeRmPu3n?=
 =?us-ascii?Q?AoeH6UQMFxjC9wEnGB0APqNgKtWD1fvTLXqCOdrmNMhX2RHEVaQ5h0BjHR9k?=
 =?us-ascii?Q?SpZtQBFvlWNQ0f9Z7PD0GzFapSuSq6rKwzQ4dZAmfQjOrHahseTSJ6QFZpJ3?=
 =?us-ascii?Q?Enf38lrUN1Og7AfUi0jArFo+uwhOCK+7bKHNCM7r/0XRyTEEUYMq4B17hnCk?=
 =?us-ascii?Q?PL5m5NmVm2V/mKRTAdn3G1DNNOxG/Wm8Z5eIiV0x6ncvQO8pCGz4GRKxmzVf?=
 =?us-ascii?Q?mt9/G2PlwNwLctRSJWTO+bLBk/vC5Nv7c0ClLlr151eMIOdhOuLPp0/SWtok?=
 =?us-ascii?Q?iNUJn9aHVUYwS2dCZlVbezUOqP9KncOIG2HMAPGdeopeyfJKx2Xo0GWrfS+Z?=
 =?us-ascii?Q?6pNHKut7KZqKf15fGlZzI3GyizVTe4F1G2zaF2o3hsyh4vQxIHWVgx3dGPvy?=
 =?us-ascii?Q?QZjgTZHbThQiPwUEzALZTpqMPXPSPWRf3JoE0fhwR2l+HcirJ1ZQ4Q9LHCC7?=
 =?us-ascii?Q?EaqsEqBQE7UDUx8JjrYbMqPqvrzEqYoQSkRxjBG6f/1GomvotNRvjHG+HKx3?=
 =?us-ascii?Q?3AYc/9N+l9FJLX4T8x2xGhrulvvHzd6KtxueAQCrprBIkDDclvDzCLxO0XlR?=
 =?us-ascii?Q?/HOKGDuxGexWA4A6Hcx1GVaWPfOfZTKgxhBM0L9QEpVewThedF6DMIsMFKYY?=
 =?us-ascii?Q?dL10cvDcaB/8bD92OzdTXu+l9uHaw3MN/0AMm42j6Imj4yfzfszOtqIyZE8I?=
 =?us-ascii?Q?kl2138CTAZW2/MYwa+mKS7ibzF7LwDnRLRntHSaSgfCmwVsEQwneihUpsoRF?=
 =?us-ascii?Q?LaCX9jupf6qHTNrRYjVdAYTtUQmbFpp96tG5knI3tDWCxnEOZEiaKo/9/Iib?=
 =?us-ascii?Q?UR5Namp8a2t6LlksDhLBQWUtqD1suWqh+1Ts8O85dN9+F46FEN96UqF9tGUM?=
 =?us-ascii?Q?18kev899QDcv7/eEe5u2mDBoFwTi5oDJvTrd8YoPUK/n21KWrPwWJ2sK9Y6/?=
 =?us-ascii?Q?Z9NF4uKylYwrotA7PENzH+gLcp6uJLmbgZYI38JeDNZsWQ35eYtRIA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8P189MB1314.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Q821lv60EX1KOu03C3ToHrdJ9RQch3ZS7TcDOtx7jQPTbg1bwIiSzoMkfx8W?=
 =?us-ascii?Q?bK/BEESexzisGCaZ/XOCNbGxSsJszM0k5PqV7VZJw6nApHbVifz1jesNCX6t?=
 =?us-ascii?Q?Cnip5avu6MOMzODCsBLPL98e3cU2xrl/BVd3mEL6yORcXTYWiJLu5yhAJO1m?=
 =?us-ascii?Q?hH2/nCTlS8CyY+knnGfTp+z6eBVx9Fg4hJx1fj9SS9XSLiGqPJeZaw2UDDer?=
 =?us-ascii?Q?+f2qdmXDx6+OmSd8bQMstwIWXUKF1yXnvocgkg5Jm9OSZLQZFssdH4EHgucA?=
 =?us-ascii?Q?wZ9KB60pnAkdpD9dXUiFx+MqIp4YAZKIW0NJ1uq28r9vzuDwTQu/3gup30v9?=
 =?us-ascii?Q?d41Y6eCxCo8i9CKlvwtF0bvh1CPKcTRwsKSsNXeHx/tuvxtD3OOmQMoEfp+o?=
 =?us-ascii?Q?hYaROHDWz4HSc6OVls1yTQa/WdiG/ENmEwFgPTSICCmrpJnGWkOHU2qPVX+R?=
 =?us-ascii?Q?WlrsEiS2dcur3TIBIH0DcpCEFASybgq5EimMaKfAF5TO/nloc08E2uen34j+?=
 =?us-ascii?Q?ylIAAOly9msgcL5UNIPY8j/PR0L26fzWOvVhwsyuuNgmzRTfehQRW+B153Tw?=
 =?us-ascii?Q?A+iAdCT+pfzImrBhMvBCXrlUpWxHhwV0jvm0NI3D04WOrXWbML0GhS1e0+r8?=
 =?us-ascii?Q?OLG/V4u/dlmEnXh2Hss1A55JAxi/+05I9uRZsSHuiNnXixXTcq9Z/PE2HEXa?=
 =?us-ascii?Q?HOa4NbzIQZc2QtzfzvIK5P4xrEI0fQKnIPEL6+nyRg8FMOnH8SY/Rwsn7KwE?=
 =?us-ascii?Q?7KaJ/a2F2V8xUlaIwZR6/wvNf9oHVbPuofBOWzvJGLd4HRazLLnKKpzAsdAA?=
 =?us-ascii?Q?pdvUFcyUH3MLjf65B/Y+Nmj7aYjNtZ2vRbszEYk0/DwWneXrhGdo2iR5QGcq?=
 =?us-ascii?Q?u+ZNsK6psbfPRWAkmnzm2zyvfsU6SmsmPdC1oVVYSWGPtoZ6f+Tx2zGE7I+4?=
 =?us-ascii?Q?UypG3IoxWalzdz7lD5Wc/P4hgqtNnqYHAAsOMRFez3Mwg/CEuARtcmXmAHvx?=
 =?us-ascii?Q?nhdxZAHWoArU9yQKIHiKGxlODfL0vcWHFIQjyvp46DuH7qjL2K2kVV+S6E0A?=
 =?us-ascii?Q?rIVPRoryTx1Dqgvw/sfpoE1vA0WCwhtg3TIVY0m4x/A7KCsTMWRQFbcM7YBZ?=
 =?us-ascii?Q?vxpb8DfzJ3txrLqsPQLK7oiqmWxsW/KLIBSt4W6HmVd7eRfpj5jjWmu624gO?=
 =?us-ascii?Q?VYt7+kLqlEVXQ9fq5Ttc+Gm8ymUx9XRXDVS0wzUPWGNjLFjf+KDs6n3BV0lN?=
 =?us-ascii?Q?T1uCU0IQVEZH3xDiswlZ2W5Rf2oqe0oP2uAzKtqyX2J8OOWyxuOqiIgfV55D?=
 =?us-ascii?Q?ys9Ne8o6qg+kXAe7kZR+oBPvZalV2sOt/2MWB32A17gtE7iutCatH0C7uDu2?=
 =?us-ascii?Q?c0T4zw7zSePwjo4vixvOLaMZ7gWg6xFkKcKiWhdQFxND69xvHrJJ4B/o9VLs?=
 =?us-ascii?Q?YznXr9cskFs0UZiAB/VXpzlvI1ksB4XhWcorz9ZGnR0orNxXLM5MT14ycrHJ?=
 =?us-ascii?Q?ro5D/n5SF+eTpvjCwbAAsO4wymXCrqKB2Qr9SUM2XKKvOAyH9WUqSw/Wvdjq?=
 =?us-ascii?Q?9ZI8gKev9ch80OG9f9nAthFCtJDZjVMbg8p084fE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8P189MB1314.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cc0767c2-7dd2-4970-d7e4-08dd9bf1084c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2025 01:02:48.4748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DZ8+SssvOT1bS0Dh/XhjDxnK8NmLS81v0jjx3h2+F8zkcP3jnRqQC3Y1zuweCCklk/DwPeKR0JUMveFvlDA5qkStpgu1p0+R72v5ItIFsT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4P189MB2717

>Subject: [PATCH] tipc: use kfree_sensitive() for aead cleanup
>
>The tipc_aead_free() function currently uses kfree() to release the aead
>structure. However, this structure contains sensitive information, such as=
 key's
>SALT value, which should be securely erased from memory to prevent potenti=
al
>leakage.
>
>To enhance security, replace kfree() with kfree_sensitive() when freeing t=
he
>aead structure. This change ensures that sensitive data is explicitly clea=
red
>before memory deallocation, aligning with the approach used in
>tipc_aead_init() and adhering to best practices for handling confidential
>information.
>
>Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
>---
> net/tipc/crypto.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c index
>8584893b4785..f4cfe88670f5 100644
>--- a/net/tipc/crypto.c
>+++ b/net/tipc/crypto.c
>@@ -425,7 +425,7 @@ static void tipc_aead_free(struct rcu_head *rp)
> 	}
> 	free_percpu(aead->tfm_entry);
> 	kfree_sensitive(aead->key);
>-	kfree(aead);
>+	kfree_sensitive(aead);
> }
>
> static int tipc_aead_users(struct tipc_aead __rcu *aead)
>--
>2.34.1
>
Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>

