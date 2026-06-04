Return-Path: <netdev+bounces-295146-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1HRmCKNLIWroCgEAu9opvQ
	(envelope-from <netdev+bounces-295146-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 11:55:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6908863EB8B
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 11:55:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=UwD6ivhh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295146-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295146-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53793307EDBC
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 09:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2843BF696;
	Thu,  4 Jun 2026 09:45:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013071.outbound.protection.outlook.com [40.93.196.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007253AFAE6;
	Thu,  4 Jun 2026 09:45:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780566318; cv=fail; b=IZeyaSPyvySQKohb3uo3tD0HAWwXOsWV355qaf5SwUubWoinT02pXGd+KWkbJLNKqicHs6yaBcbSe3I6dcm6hwzIfcgJ3DVMKsrt9/nT+D0AqE5MLfRHvDsnzkkRN93Y1qk5jNjWFJioqUQ5kRmPsE/e3QPRTFGmh8h+MOt20qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780566318; c=relaxed/simple;
	bh=pBjUYAx9xD8B6IGEtLeDilatLeyzdL3HfwdvcgWIjqA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=APKXSwlwd0Hx+K7yVW6BzVJ+2YNz8OKIQByIp/FakuE9OyK4reiN/CoH+YCFQHEUjiyACT5k8MSiPaA0Bifa37YAuiFj+uRhjmZYKN0ClaLaonvt+h8VePjHnRDI6SZz+YvvTBMYvbOIwlb5kLIYTOewbuBZhaYEECEIW+uZP5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=UwD6ivhh; arc=fail smtp.client-ip=40.93.196.71
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgN1Zwie9vRkVURnuY76fV3L3TEzM5889X2oyLu6T7SWVoDqCc+NzrA2deX8RBqj4rLgHBBAE2mb3BZJqxfv5UgUOW27Qp4mtJkxpKDY/BzPq+RUmICjHrDPf78wTSlaS1ohV7GFTKk8mBMCvBmhGpx9CicDesQvZ09+mUulxLPHd0BxNlOmnhlAxf5gWxOeNm10m8Ot5QT/b/I4pK0X0tCg+WHOqzOH3IHasM1dFiPwKFmc3I73BdOaXihnQIi3n5z/FGUHgf/68iQ/4bc3MuNyrCwmOcJ/1/tKeZH+SmmYKsrzvvPUrf8LflQC8cwEKkVGrQRhb0JeYTIkc37YKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T21AqeF+8GxJDEustTv5L8tusbPvb8tf4ry/tclAoxg=;
 b=az8eVj/uqMMPaPvJo2vwiZPM4W8ywSj1+BJNCIDrE/4dSe667BtzUErBjJyTSJggW0ZsV4s+KL39WW3Mebb9Id558HVEK9Jg8IYZYBP8Dj0GJ1xFL3O8tK10aa6VxJUFx2+BzHc0oK1gCu7eDLrBKUy/KmKYVA1DqOaPl/XkzO7wMKYOVqte+p842xs42+IBFwRzF+qxGv8BZyRL3NYlKdRBNaiYzPvNgejRoeKo0d98lTFTjMYzvPUm+OEby9EykxwGMagka8cmUBd+dKLw43YZ3aS60sWVHs3/BY582+m6kyCa6s8ByAAY2VvrgNNo3KF3eDsR/D2b95Yzz9CzoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T21AqeF+8GxJDEustTv5L8tusbPvb8tf4ry/tclAoxg=;
 b=UwD6ivhhHwEHAWy13/txN4LvVGOvxVPWDdH0gekFqpgq3bqW20OKWNMxcoRimdOKA1kKvATpRqJwQchdDfCpaUjOucOmksjlU/pmNeNQ6TnDHmOQLXoWCdNXgeAqdeKeOk9wQUJIFIdRddnMFro66ENnl7cYiPbA4N+chHOATdIBAllrFLG8eARhKLyxK8jDs7IBM5BOBXEitQcXJqoy7lkiNBWlMmECn/ghY8BTIGZcA2ViXIbdL6LBPATfNrldvodj/6QH54MCyqlDd3SoQij9GXB/mvChTtU56IraToH4VEiIouBCh7JUuXWq9eUMFdtbiaxu0Z+zzESN+1hGpA==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by BL1PR03MB5990.namprd03.prod.outlook.com (2603:10b6:208:313::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Thu, 4 Jun 2026
 09:45:14 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 09:45:14 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	Jose.Abreu@synopsys.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: stmmac: xgmac2: disable RBUE in default RX interrupt mask
Date: Thu,  4 Jun 2026 02:45:12 -0700
Message-ID: <20260604094512.21243-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::7) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|BL1PR03MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe1db00-82e9-4283-5008-08dec21df9ee
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|55112099003|6133799003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	m3bk/LY6XdBuWtbyxrmCDKAaq5ZGgKijBeLL57wxAjUQjvZrvEzi9Q5JD+i6sZvuy8grulZf+DLYvXLHoAddhTTMdnvLfepYKqcfFpo/jI9yVf4XBBup0lOSPThwOEaSZhMkt6xbyVdqBFbAF8+pxdKalMDROKMzKHJPOf0xFcgTNghef9MS9NLaugpHH5QZNwYxLQ+xuQnGfZyy8ipdXaP9+4FpLc5gbAT1seGwjjyo42SCVjL7yKFEoThexAm+oBQr/TBm39If/LpLhHaMGjl+gtPnRNftiAcT5Zpv+YY61Rbj9/9UvXM8qtNGBtmLeXAPyGJVmvigacvJERjmaqwfwu7feAa1iutgJZ8D+HuqJ1GNEEibQlIEGJ3fc6V+G4Ex/93cul6ozN29vYB43E9HIlcdaBeZvBlQxua42Fq5ACjk133vVt7T6xWm8GgiW9XgoH2qp0didEazygm7otGEpx0VzOfh/WYr9BNeW6CC+t6MyhWPcJwUHANik5GnWLDbz7SB+zyMnKvvOJG1TqAgf1reAP0tJ8QQ0nSndChpKrd4p6cD2qQz/V2Mn0Q5VOwSiN5ZUgrzHaKYuovx64r5EN3mir6L36OYtycAPhlEkqJm9It9fX9fJoa17oygCzbwPwUTrQJzGrzybvZhy+zkWW8SwJpzx5XnVez4WLV4/9Pya0i1WC/ZXJ7zek8q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(55112099003)(6133799003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aft3eTPzBfiMtKkoDF5eKLhDlFmbz9wmD3E5qFgBc1AEDrqnXJvV/yo1Zh8D?=
 =?us-ascii?Q?zr8ZMp6vLPr4hhTRtk36QlAlr8vpXO3RzujNQ53TWNAmRHtiK82lyWarRI4x?=
 =?us-ascii?Q?Evsnp09HIbsHriKv5OABQVFOS+aWBurkheSt+W6dOv+jVobc51isl/EYdZM2?=
 =?us-ascii?Q?Zr6Z8G0oIx68R4slPxeL947thJ7XYSEeGcsZ672mUpz3KdwDVtZ+ERc412Zn?=
 =?us-ascii?Q?aav20yhkFm+OEekSIjY+lPY0cVwZE1rhl6/3slPKN01UkTnullYs4DaPR8jq?=
 =?us-ascii?Q?WpAfPu35a6mpuF72bqSB/SvtHDY91cRfkRzIAd2dQjbbZHaFrvuDV7qx73eN?=
 =?us-ascii?Q?jOt8Mn4pHB154qvhi4JBO0abJ/cg9vH9blB6iWPHb35AN1n/JRDKalkJeyUX?=
 =?us-ascii?Q?vbeE28TFsWtdgmyoHH7U4Wy6IuUdoZg3cvTiIxzwoq53GA98zSEanjjXckIq?=
 =?us-ascii?Q?qwpUGiLqPuUnN3B/R4aR0F8xkCm+t1V/68RXdjZVrfIO91dkAMOdlB9lB8F0?=
 =?us-ascii?Q?+UOK+3wk6mvmxpSH79blFb0QZamtdq4orL9PeEhiz+oHR2Fv/BhIVcpiORBu?=
 =?us-ascii?Q?Py9JW92YYV1xSMFfFsGsYJ0Debe+SQ6KoO1uLwI11e/R+ZTttWVAUlfNh0Lk?=
 =?us-ascii?Q?OEx/4wSnV6HlwRlTpa16nIWXFhFuzaCzlqcZkrXrPgCb8MyOIsEd9cM/Mrst?=
 =?us-ascii?Q?yjbWXJjjszz2q1f37QusYDfdCJZQeJCMwrVpQhxuVsCO7pLfsWgqjrpetZyd?=
 =?us-ascii?Q?Dvba3yQO0ZLIpVrLyy8wPkZjx1m3Tnux0QNmWC/Bc98iaOAfq1TDE4+PRxui?=
 =?us-ascii?Q?0SJlXIxtH3e1Msy84TMCwVwDmrJyS4HFJDdREjo9duC8NvQVKLLdCP+t26jj?=
 =?us-ascii?Q?TxEd++NCqokDrNkRC2RNEKIXuOG4/dbFNE4yuRvq0cds9AIMiKBa/tpCYrIn?=
 =?us-ascii?Q?H7f/lgvsuqLS8K7Zt6p7KVTnftKHcJzHkqmMw7Oksw0DTxjbcWmDnyFmj6O1?=
 =?us-ascii?Q?kQzPm5rWosULUd/SD5ABh7lBdDwYjywAhaikaDyef/Ddi6VQw9AJx7erjofF?=
 =?us-ascii?Q?svwhB28nmjCGNonCvCRPwsBz1AoIl53XJLiIY81A6vxAQXGjUwTb356wrPIF?=
 =?us-ascii?Q?9xmfOPsdSAoFx/H5D/LiqOa8HtzZVU6S9Lp/PJKkiXf5qDcsQ3sBvu1Rl56X?=
 =?us-ascii?Q?dERZ7k+vayG0FokhlQPBfg3RYPqOMSqREqUUftpkRDN/+9iaQwQpSq2aoUzN?=
 =?us-ascii?Q?RAPjS1YQJcQb03vLpE8HKcfJka42jXqE/vhaa1V8xUOTebLWFEtD+bN5OLBR?=
 =?us-ascii?Q?Cb5QUUS41KRLEfcpcnDG+KCDHzpf1NW3IjBY79hFyrWi0aT/d+hRdgnJEJ2h?=
 =?us-ascii?Q?a/CxsIJz4ogONtOwq2hZxdiopfjqvARZob28LYGkvX1bmEAqVt4mUdxMg1Eg?=
 =?us-ascii?Q?c9pV772f8ZIFOQ4IFMCz8jkvhBtugwovmyIAqhoqH2H8IRPbs1DDRgxSujnj?=
 =?us-ascii?Q?1xCRdts9PDKsP6ztQau0+U380Eu2/Ee7xQ00PsIEVQSUjFpXu4XRYTv6QopF?=
 =?us-ascii?Q?t+rfgQWJA38Ua3F5F8J9bSbQyPZ6AGm85MJVsc5M6CL7z/FG+Or/b10a3dzF?=
 =?us-ascii?Q?ZHUNKFp6UHLixCA84gNZl9BipFeO06f7uBIGzXloV/2FZuQE8be3IZWx+73n?=
 =?us-ascii?Q?mxcOQCvljZJ1lKp7nEFfh8rApIoRumLmP0tVg9Om5V3qDIUum6YGTW6oeIX2?=
 =?us-ascii?Q?s6viSM+udnLUakGOuGf5l0tzacgcIEDM2VZC0ZxvwhVMO0LW8yId7isbMDVM?=
X-MS-Exchange-AntiSpam-MessageData-1: yGEuqixl5Ryf4Q==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe1db00-82e9-4283-5008-08dec21df9ee
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 09:45:13.8718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vCkoap32qegOyCDt81NJBzRUTh/y5g0+SuHLhdlCpaw4/pPmKGWRAwlnHfU07he5yNl5JZM2UGJRlv8D5OkuuognGLojUJWZLrq3Rxo96OuTmyhMoOcSnVp170ZWDMc9838BHLaMEgNyw1LadUHKNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB5990
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,synopsys.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-295146-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[altera.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,altera.com:mid,altera.com:dkim,altera.com:from_mime,altera.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6908863EB8B

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Enabling the RX Buffer Unavailable (RBUE) interrupt is counterproductive
and can trigger a MAC interrupt storm under heavy RX pressure. When the
DMA runs out of RX descriptors it fires RBUE continuously until software
refills the ring.

However, RBUE is redundant: the normal RX completion interrupt (RIE)
already triggers NAPI, which processes completed descriptors and refills
the ring, causing the DMA to resume. The RBUE handler itself only sets
handle_rx - the same outcome as RIE.

On Agilex5 under heavy RX pressure, the MAC interrupt (which includes
RBUE) was observed firing 1,821,811,555 times against only 2,618,627
actual RX completions - a ~695x ratio - confirming the severity of the
storm.

Note: as a consequence of disabling RBUE, the rx_buf_unav_irq ethtool
counter will always read 0 on XGMAC2 devices. This behaviour is already
inconsistent across DWMAC core versions.

Remove RBUE from XGMAC_DMA_INT_DEFAULT_EN and XGMAC_DMA_INT_DEFAULT_RX
to prevent the interrupt storm while keeping normal RX handling intact.

Fixes: d6ddfacd95c7 ("net: stmmac: Add DMA related callbacks for XGMAC2")
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
Changes in v2:
- Added performance measurements to commit message (Maxime Chevallier)
- Noted that rx_buf_unav_irq will always read 0 on XGMAC2 devices
  after this change (Maxime Chevallier)
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 51943705a2b0..b5fdc253a2f2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -379,9 +379,9 @@
 #define XGMAC_RIE			BIT(6)
 #define XGMAC_TBUE			BIT(2)
 #define XGMAC_TIE			BIT(0)
-#define XGMAC_DMA_INT_DEFAULT_EN	(XGMAC_NIE | XGMAC_AIE | XGMAC_RBUE | \
+#define XGMAC_DMA_INT_DEFAULT_EN	(XGMAC_NIE | XGMAC_AIE | \
 					XGMAC_RIE | XGMAC_TIE)
-#define XGMAC_DMA_INT_DEFAULT_RX	(XGMAC_RBUE | XGMAC_RIE)
+#define XGMAC_DMA_INT_DEFAULT_RX	(XGMAC_RIE)
 #define XGMAC_DMA_INT_DEFAULT_TX	(XGMAC_TIE)
 #define XGMAC_DMA_CH_Rx_WATCHDOG(x)	(0x0000313c + (0x80 * (x)))
 #define XGMAC_RWT			GENMASK(7, 0)
-- 
2.43.7


