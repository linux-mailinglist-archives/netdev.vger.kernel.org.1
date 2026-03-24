Return-Path: <netdev+bounces-271136-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHEwOZmywmmRkwQAu9opvQ
	(envelope-from <netdev+bounces-271136-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:49:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 520753185F1
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AB5E30AFA0C
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6F7392C50;
	Tue, 24 Mar 2026 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="FNcUUBwn"
X-Original-To: netdev@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010005.outbound.protection.outlook.com [52.101.229.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27754390CAA;
	Tue, 24 Mar 2026 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366651; cv=fail; b=TMsVT3/jd5sTMHAkLpUx38teiI1Bw/fmWcy9j1gFpDzByVMjZlXstBnYBBidVO3MBdSkoOnx+bbSpIt/RRyarJ25uhBWi/aySQt2Q8Z5Huj2HBEy0X5RZVyXZv5vyyYfgF5Qvj+LgH5WfwXucb26jj+ppJ46TJa0UA/5wAk9x8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366651; c=relaxed/simple;
	bh=tRxnJ3uYjPd3qDbAYhx/N9xChmTAntWx4Vyw/N7yMLc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JRvnLvbupVSgtvXZRqm4Ys7qHH4Fb2EDlvugmKbH4qB9HZFny8bojRvBd544cMQ4udyQCWg4Zo5LSsViAvQcAmL8cUZVluvTZBOxR+0nt1nxztDBleZssqQcMjtUM7Rho7TgSuCHsbc8k9a44gJk+pn7FuzT1z+S+ref3xM+w+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=FNcUUBwn; arc=fail smtp.client-ip=52.101.229.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bt+AT2aVVwGdjxgBq3AnvzFbQ/9DKsQdkUGDJyZQ0nk9cdg/qiPCYSKNNwQdmYLLWIFuzD2lpFa587MrNAM8+u4zAFxdT+ffGako8esZATR75zIxexdv3yyVouHKnurUOLJQ6CD4ZVTXMtFX28dqq9iqUNImP0NscP2uhQSO71ovh4n2GzEmm/MgNm2LhEIkgbmTcUKPKmLvwtgvRtPgmFY+DElOfXFL1JIvPV6/c/cR1oeujH8YVp7elWxMiM4mfr7SoK5gJ5niYcvAd/QO6conTstLHNwEB9Hf4qyWo6bnaOALbPBWHt77obO1tmek9nm2Lt4ThrTUj9bF1YHs/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IE/43wvjROKpR7dCPxq4lvV9BLEuBBXfM1lIv2EJ9oA=;
 b=b+sEro6Q6tWkRnGnojsA3EgkE83O201f72TMTo0mJGfZP7WKLKUaXKFkqiLBh4tcGPZE33LT160Yw0W6hAYmv2VhCnYy4LiboQZxCmcDwOelcDpUhQRNqnhjYOtgpa3ohJL66VKdzs6af3DoAovbEkpZiFPEvsEVWHNrbkg4G/8AMmg63t1O4L+UpqFtCb1KKg+NSZl7D47pGQW5LFetkJpFGW/yqZVk7ymgD0UnzH+1rcv5hLxVMQYCZXAHZjy7c7DDwD5mxqsy85uf2v3EETZTCReQZj/4m1jDUvz9oEMcgGwOxdYSn9/CmMSgcnxhp00U/9/Hv7ejjSm7FAfdiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IE/43wvjROKpR7dCPxq4lvV9BLEuBBXfM1lIv2EJ9oA=;
 b=FNcUUBwnyNvGlGWEMok2Kse/blva8gX50ZeS3P9/QX0BMnBhe8IWUgWFqnklAUinChCrmiyxL+p3B93+hiAQNpkHwszPFaotmoiPs8zD/CkJCGLvMjbp0z+EeWCtA+UxcDWBrYyk75/5Uwyedrx07e8+flVTZSCSiRUthsf6h04=
Received: from TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:38d::6)
 by OSOP301MB1886.JPNP301.PROD.OUTLOOK.COM (2603:1096:604:468::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 15:37:26 +0000
Received: from TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM
 ([fe80::5b4b:dd0c:b302:7911]) by TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM
 ([fe80::5b4b:dd0c:b302:7911%5]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 15:37:24 +0000
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: Russell King <linux@armlinux.org.uk>, Paolo Abeni <pabeni@redhat.com>
CC: Michal Piekos <michal.piekos@mmpsystems.pl>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] net: stmmac: skip VLAN restore when VLAN hash ops are
 missing
Thread-Topic: [PATCH v2] net: stmmac: skip VLAN restore when VLAN hash ops are
 missing
Thread-Index: AQHcuPUBPuJr+fwUwEyxnX/LFVXhRLW9nZ2AgAAN/YCAAAQiQA==
Date: Tue, 24 Mar 2026 15:37:24 +0000
Message-ID:
 <TY7P301MB1984855F48CACF4FE1B502A4D348A@TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM>
References: <20260321-vlan-restore-error-v2-1-45cf56a5223d@mmpsystems.pl>
 <5e5706bb-0f04-4bb1-94f4-45083a3c76fd@redhat.com>
 <acKL4RoM-zdwj1Ib@shell.armlinux.org.uk>
In-Reply-To: <acKL4RoM-zdwj1Ib@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7P301MB1984:EE_|OSOP301MB1886:EE_
x-ms-office365-filtering-correlation-id: 7267aa6f-602d-46cf-319b-08de89bb3f00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 CZKifFqEdz7CCRmlBrGd41bwGpjbe0r0pCFhHgr6VxYacRvDi3cvfNn8JNVIwZOq0IW6tLoNcLCz7rXTU5uS/KqxLZuJZf/OydG3OXvUC/IgGTuamKVekJdCMImh9gNEZJgKlx97owA3cl4Koajn8GbSL40+G8JoBHHYO8Zwdk96+LubocFDZwkllq9X6eFNOwW+JPoBZskCNXhz3b6Qx+a5t0ZxxAsUMixifROEVNh6EU5V5nMgNff77A/zinJx72O7gB008xgXVrLR/fOVH0RbpWmeQEetC6XtbTPgsE/8i2PhDpbzvuIAfU7TexNpguvmoZMgg0ea6DNPKP9eGtolEa8OwhtR0fPpbXMGXZ5fGCgHl96dshxFlkU7mP+i97YYC6MuQLfnsHgidTnV+dbpr6Lqryyr6XZ15cfz8cA1/6yUZ/2+95Tp+RKcYSDhtbC8FzRQZ6ahtHKizigXMd2M9k/ubLYMPfqDjxKXEp+YleLXMN9cpLyvbv0HCIKAwAbGPVR0Xc+ITOZViQI0pXupMC9KueZ9rXNxxMNfDU6CzL/yQ1YUcLNchPWx8zQTDrSEfRsqiCBd4SyfyRmlBkxuv04P665XsTDInSH6JO+5cmclBiZzcmgAbaGSaG5832XHzsM0navI2EyynyRyfRi6aT444dmSWbG2zb73KMwJrwjnSUZoyCesps+LznUD+POkr6TYQAgPkmSsdFtxmNxc8QbxyRghcBv7UnrSkqxSERSAs/HYGNEGzwdOk69t
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IGErk0fIsepOQsBgc5F3p/+Crrq3ObbQtMZbxVBV4H3rPVS/ymwvw+rDT5FO?=
 =?us-ascii?Q?bGVFajgQLRaWDxO11y5Yv0m598EHlrO8EYGPhwbXA335ffuI5PgnyVU1mxt+?=
 =?us-ascii?Q?p3nP6PRWQ0E9T3P10pJm+9rbFTJyHSvnVDGAd0GsLssa2RbbMh9Ief3wS11C?=
 =?us-ascii?Q?ffE4H1TaluoB0bym7rjNHT7Lnc7DhYSoBhGg5icTIi0pa38hu31cPlPVpUZA?=
 =?us-ascii?Q?QeHGen7aWIcmQkTi88Nwcwcb8MURpWkdwg+kEJMyxL1utljgH9RLc1+XgXLS?=
 =?us-ascii?Q?gqKWsCPlDTZsBfUcVVfFsiPDUziKnolUrFofSk76cnU/UfDgZJ/1YnVbJ25C?=
 =?us-ascii?Q?o/hUqvUxNvCWZhQ6VnAaDtCSvkfMLTaGB40ZIg5dlvnLmKwwnr7mvGmbCWAe?=
 =?us-ascii?Q?po1m79E/d8YbZaZ6MX7VMCHcXexVs0J+AgPg7xni9lIbLkLGP+2mOVxo5TDD?=
 =?us-ascii?Q?p2DCr7tTpx8Y1geaUbPtn2B0+ZBp97QVunSjVGgYoghsTbU2kKQcFbMBWs9k?=
 =?us-ascii?Q?OnJuRl6Aa9EBftIbrGZQ3Jy97TIo0oztkVns8jY1ZZAIHBTXbW5oPkXfWPAC?=
 =?us-ascii?Q?wWGthz+9MnVzCXOAcff5uTKMqHVp4ow0MMNnazyAxU7ooJaU1B1bU2HpX5L0?=
 =?us-ascii?Q?xM95LqslGwYf8HIXgvyM9zN/yoivejM3ScIHqNkEKC7lkrS1GrZLZJ2spex6?=
 =?us-ascii?Q?RuJmZHawy0T6y6V8eHhKljBComHE4YQNIAg4/FL0d+ahImfvIKg0y283kUm1?=
 =?us-ascii?Q?Ctf3JjHd4AymOwrd+uMXm3LIojt3eHe8efI+SDk6y1rkYxSz2Wufe2fYoZmy?=
 =?us-ascii?Q?dYNTOb/LJr3Ae4zr7v2hcJ15LsFahNY+gt5Q4RsYphETTonyf3UeVGeAAcQx?=
 =?us-ascii?Q?xAKQ1iK4v3gfWToEpKEKUVdZ+g5xaqJkG76/pokhkCBOBOSay0t8sn9zOtfA?=
 =?us-ascii?Q?IpN9sbJNOLMda/r++DXEbk95JIIXVRiKrzvZEjQU9K6TV285jh6WVbvRTbfN?=
 =?us-ascii?Q?aRiEkP1QnduJtcoufA9VrbIEBuJcojZ6xIIub2IBhbT3U1mnv21RkbirPCon?=
 =?us-ascii?Q?Z6wappM+Dnw7Dr8vxTRY4lM6BONuMg2boBO6rEqsVBinK2QpmIrCBQMvky5L?=
 =?us-ascii?Q?v4xqtT2OvROYjUBJpbcyXTcefQWvW8UIykApUsUnVJkRr9KqmNKilr6NtomT?=
 =?us-ascii?Q?Ifw09IrmylfhIHy6RY4e2UPxbYFjg1SczmKp8LHngMwrbQvGH1fIJjuR9f21?=
 =?us-ascii?Q?B+YclucmfPU6wE6WvwORXpVBoY++GxrCTvZa0AUhpbuBZaqg7Ahjd3jbXD6X?=
 =?us-ascii?Q?Hu0xjFY9U2I9wZEcoTklQK5r+v/yCCTkDdh/7Vva6LlxhFYbOn/KI6GSbJqj?=
 =?us-ascii?Q?nE5MufPkQ756cqHtbWw+uI0UGBDySv7UqtYn4V5q6OnLkHE8gPZ9zpFndiIg?=
 =?us-ascii?Q?CnLt/Ol8nbRGNQNGOHFitibtKdgUE+i7hd2wDWjbg68zrIr8HA1vMyBQ8M4Q?=
 =?us-ascii?Q?jhG4fuQGkW8XGYTaL673++vN1vSr1uP1mH1gecgSPFQuA8FPToTQVUTpUbau?=
 =?us-ascii?Q?mj1h/LyRW4aT00z8VBS8S3Mc7wNWrcKNd1IpvaqAUfW2tlP2o5Zgu0rG7ZUy?=
 =?us-ascii?Q?quHR3JkP5R39L50HuYkDXVyN7vz+Pi8AnaY4p7vAjp8aGEUXlaisER/cW7TC?=
 =?us-ascii?Q?TY2qxuLh6+G46IWGzHqdmE/2+UEOL2GQ5dOBACvuW6qtnBK/EPnK4ryQHQSR?=
 =?us-ascii?Q?jk5B0swc4WUTv8eBBsZWPjuzr9WRDs8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7267aa6f-602d-46cf-319b-08de89bb3f00
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 15:37:24.1440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v7mP+qo5AAtfJMfQxjVKR8MS+hzdReSJ/q5JHfZgjDRMmSfqDUeiTEy+LVshY+n8ewUaYQiy1RME9NDLN5fBiJ8AIveTNm+79oAGsl6s694=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOP301MB1886
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271136-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[mmpsystems.pl,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ovidiu.panait.rb@renesas.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[renesas.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:url,renesas.com:dkim,renesas.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mmpsystems.pl:email]
X-Rspamd-Queue-Id: 520753185F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

>=20
> On Tue, Mar 24, 2026 at 01:14:29PM +0100, Paolo Abeni wrote:
> > On 3/21/26 6:38 AM, Michal Piekos wrote:
> > > stmmac_vlan_restore() unconditionally calls stmmac_vlan_update() when
> > > NETIF_F_VLAN_FEATURES is set. On platforms where priv->hw->vlan (or
> > > ->update_vlan_hash) is not provided, stmmac_update_vlan_hash() return=
s
> > > -EINVAL via stmmac_do_void_callback(), resulting in a spurious
> > > "Failed to restore VLANs" error even when no VLAN filtering is in use=
.
> > >
> > > Check presence of VLAN HW FILTER flags before stmmac_vlan_update().
> > >
> > > Tested on Orange Pi Zero 3.
> > >
> > > Fixes: bd7ad51253a7 ("net: stmmac: Fix VLAN HW state restore")
> > > Signed-off-by: Michal Piekos <michal.piekos@mmpsystems.pl>
> > > ---
> > > This patch fixes a noisy "Failed to restore VLANs" message on
> platforms
> > > where stmmac VLAN hash ops are not implemented.
> > > stmmac_vlan_restore() calls stmmac_vlan_update() without checking for
> > > VLAN hash ops presence which results in -EINVAL.
> > > ---
> > > Changes in v2:
> > > - Replace check for hash ops with check for HW FILTER flags
> > > - Link to v1: https://lore.kernel.org/r/20260314-vlan-restore-error-
> v1-1-4fc6c3e2115f@mmpsystems.pl
> > > ---
> > >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > index 6827c99bde8c..cfc0ce9cec9c 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > @@ -6863,7 +6863,8 @@ static int stmmac_vlan_restore(struct
> stmmac_priv *priv)
> > >  {
> > >  	int ret;
> > >
> > > -	if (!(priv->dev->features & NETIF_F_VLAN_FEATURES))
> > > +	if (!(priv->dev->features &
> > > +	      (NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_VLAN_STAG_FILTER)))
> > >  		return 0;
> > >
> > >  	if (priv->hw->num_vlan)
> > Adding Russell.
> >
> > It's not obvious to me that with this change the
> > restore_hw_vlan_rx_fltr() and vlan_update() callback are still invoked
> > in all the relevant driver/features permutation.
>=20
> I think there's a few questions here.
>=20
> When CONFIG_VLAN_8021Q is enabled, then we set the filter features
> if the vlhash dma capability is set:
>=20
>         if (priv->dma_cap.vlhash) {
>                 ndev->features |=3D NETIF_F_HW_VLAN_CTAG_FILTER;
>                 ndev->features |=3D NETIF_F_HW_VLAN_STAG_FILTER;
>         }
>=20

The VLAN core will call into the ndo_vlan_rx_add_vid and ndo_vlan_rx_kill_v=
id
callbacks in the driver only if NETIF_F_HW_VLAN_CTAG_FILTER or
NETIF_F_HW_VLAN_STAG_FILTER features are advertised. For stmmac, the HW
filtering features are currently advertised only if priv->dma_cap.vlhash is
set.

stmmac_vlan_update() is only called from ndo_vlan_rx_add_vid and
ndo_vlan_rx_kill_vid callbacks to set up hash filtering, so on the
restore path it should also be called only if HW filtering is enabled.
Otherwise there is nothing to restore.

> Only dwmac4 and dwxgmac2 have the ability to set this feature (and
> thus be synthesised with the feature enabled.) From what I understand,
> when present, these features are permanently enabled (as they're not
> set in hw_Features).
>=20
> However, in stmmac_vlan_update() there is:
>=20
>         if (!priv->dma_cap.vlhash) {
>                 if (count > 2) /* VID =3D 0 always passes filter */
>                         return -EOPNOTSUPP;
>=20
>                 pmatch =3D vid;
>                 hash =3D 0;
>         }
>=20
> So, it is clear that the intention is that stmmac_vlan_update() will
> be called even when the NETIF_F_HW_VLAN_*TAG_FILTER features are not
> present - consider a core that implements the VLAN ops, but has
> priv->dma_cap.vlhash false.
>=20

My understanding is that the code in stmmac_vlan_update() that checks for
!priv->dma_cap.vlhash is dead code, this condition cannot be true inside
the ndo_vlan_rx_add_vid and ndo_vlan_rx_kill_vid callbacks because the
callbacks are only called when priv->dma_cap.vlhash is true.

This seems to be a long-standing issue in the VLAN code.

> It looks like vlan support was added in dwmac v4.0 and later cores
> (from the hwif table.) As the vlan ops are NULL before that, the
> horrid stmmac_do_void_callback() crud will return -EINVAL (yuck). The
> method it calls is a void function, so the only possible return values
> are zero if implemented, or -EINVAL if not.
>=20
> stmmac_vlan_update() itself only ever returns zero if the netif
> isn't running, or the above return value. So, an error returned from
> stmmac_vlan_update() just means that the driver has no support for
> programming the vlan configuration.
>=20
> Looking at the implementations for the case where vlhash is false,
> (where stmmac_update_vlan_hash() will be called with hash=3D0 and
> perfect_match with a vid, vlan_update_hash() still write
> to the VLAN_TAG register to configure vlan handling. I haven't
> looked up exactly what it does.
>=20
> The other possibility is dwxgmac2_update_vlan_hash(). This looks
> similar.
>=20
> So, I don't think that the correct solution is to only call this
> function when one or more of NETIF_F_HW_VLAN_*TAG_FILTER feature flags
> are set - clearly the code is written to handle the case where the
> update_vlan_hash method is populated but vlhash is false and these
> feature flags are clear.
>=20

Even though the original intent seems to have been to allow for
stmmac_vlan_update() to work with priv->dma_cap.vlhash =3D false, in practi=
ce
it doesn't work because stmmac_vlan_update() is only called when
priv->dma_cap.vlhash =3D true.

> Now I'm wondering whether the code in the STMMAC_VLAN_TAG_USED block
> is correct:
>=20
>         /* Both mac100 and gmac support receive VLAN tag detection */
>         ndev->features |=3D NETIF_F_HW_VLAN_CTAG_RX |
> NETIF_F_HW_VLAN_STAG_RX;
>         if (dwmac_is_xmac(priv->plat->core_type)) {
>                 ndev->hw_features |=3D NETIF_F_HW_VLAN_CTAG_RX;
>                 priv->hw->hw_vlan_en =3D true;
>         }
>         if (priv->dma_cap.vlhash) {
>                 ndev->features |=3D NETIF_F_HW_VLAN_CTAG_FILTER;
>                 ndev->features |=3D NETIF_F_HW_VLAN_STAG_FILTER;
>         }
>         if (priv->dma_cap.vlins)
>                 ndev->features |=3D NETIF_F_HW_VLAN_CTAG_TX;
>=20
> The test for dwmac_is_xmac() matches for dwmac4 and dwxgmac cores. If
> this is true, then we will have the vlan ops populated, and it means
> that NETIF_F_HW_VLAN_CTAG_RX can be configured by the user rather than
> being always-enabled. Is this correct? I'm not sure - I haven't dug
> into enough of the documentation for this yet. However, I suggest
> that we need to always call stmmac_update_vlan_hash() for these cores.
>=20
> So, I'm coming to the conclusion that we either need a test for
> dwmac_is_xmac() and not the feature flags, or maybe we just get rid
> of the "Failed to restore VLANs" error print and make
> stmmac_vlan_restore() return void (nothing uses the return value.)
>=20
> In summary, I'm not sure what the correct approach is - please reach
> out to Ovidiu Panait <ovidiu.panait.rb@renesas.com> who recently added
> this code, but I'm fairly sure that this solution is incorrect.
>=20
> Really, Ovidiu Panait should be reviewing this patch as his recent
> change introduced the problematical error print.
>=20

I reviewed the v1 for this patch ([1]), and given the existing VLAN
implementation and for a targeted fix, I think checking HW filtering
features is correct. The restore only takes care of restoring the HW
filters, so it should run only when we have HW filters support.

When the HW filters should be enabled, though, I think is a separate
issue that requires some refactoring of the VLAN implementation, to
make it more precise, as Russell pointed out.

I only have access to a board that uses the DWMAC4 IP, but I'll have
a look in the documentation I have to check how to improve VLAN
features handling.=20

[1] https://lore.kernel.org/all/20260314-vlan-restore-error-v1-1-4fc6c3e211=
5f@mmpsystems.pl/

Ovidiu

> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

