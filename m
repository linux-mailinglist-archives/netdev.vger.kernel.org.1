Return-Path: <netdev+bounces-260074-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNGhOANrnGmcGAQAu9opvQ
	(envelope-from <netdev+bounces-260074-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 15:58:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D016178535
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 15:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C5803029A43
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2A0266B67;
	Mon, 23 Feb 2026 14:56:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021112.outbound.protection.outlook.com [52.101.100.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AF5263F34;
	Mon, 23 Feb 2026 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771858578; cv=fail; b=XXUKYREMH6d6fhuK1/A/nXLv1CuqnlpWIuAVvu5QKDUo9rNYTbqJxmVk0bhMnEZBDlSJkplkQo3eWu6rj/vhx9Yx3YVTB5v2qzF66axMS16BWFCI+Z4Bn8I10ao+f28PXeHieZmTfbDElo/Iy6aS++BTupLPTmAGHNKMe3cQy6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771858578; c=relaxed/simple;
	bh=4sHxhdFyoSf0wEGV2V2m12h2X0EGlIN8T7DZqMegcIA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=szVY4spyYtV2nUNPDbr+DKginpDTrQ2bMjLN4FUBntz9IpmOddaJE5lhi19xwHtuez2xueUJPZ9vNIHde/pdZFCElRbGprzt70w/wpzQkj6vpqW54ZdCSIEcGpJiljn+OpOADjHpWmPeTm4Ho3OVxJ79ZCfZmO+yhJ5qOhHYnbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTGWXcfFT5VELVe3wNnc26IuMYkoPwhdugMAd2cqS98yZi0IhzaZg/3T/amh34Uu8A7Wcr0EGfTSg5+RkpnhtUWIMr8pYWkNTJDaeTVtQi39RMkIurqnuyVw5IJh7j2+sn0/umUGtXJP3Amnp+tN/CUpI1yh0Auy/BosqN7hqzUP9voNlCarbwiCtZuk9N/rc9XCpeHouJuCJBXUM5zbRYm+1Pz3KsbmQxwXqeh5PzW2t6P8WxQuH54Qqop6eJ9xUEN+X4sWev/NmY+kJBRQ4RzMotUQm+6nklFH/Kf503yOZCZEYNCmcWrCrNJC+skIj1z2o3Nsc3udjqGLy1Lrwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNMf+Mvixryafk0oYTo4sAXsRzQX0r77pVH1TaL0ZVs=;
 b=IFhULNeIb4/ImT2qIJXMyFruKSS3H7sFmuftkUO68k+XUKExpgv2FVaRZqzWbFu9HNOqJxkBh8BpTmipfMhMqXQaDeRjJX3iY3ZghE4mAZxzkCuBJ9K8DEOM0d4Jf6v6rM/yGRcJmzdsTtYlu88k9opj9g9OsFo+mHly/KzWCAn+axL3yl04JTe8bGNydjotwHugHMtIfVgA/tWDyiSlx6WBh8gLpRYNg8mxXZUHM6vA5YgxzoYNq7WCCY8mb4UGvBkMrBkL2lLiqBVN79DtoMvB3cGMFUD/eN+bfHPuHD34A0s7/CF5Sivo6cjOqvv8pVsHrxZAhHhUR9OOpGNWSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO6P123MB6708.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 14:56:09 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9632.015; Mon, 23 Feb 2026
 14:56:09 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: ronak.doshi@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	atomlin@atomlin.com,
	da.anzani@gmail.com,
	sean@ashe.io,
	mproche@gmail.com
Subject: [PATCH] vmxnet3: Suppress page allocation warning for massive Rx Data ring
Date: Mon, 23 Feb 2026 09:56:04 -0500
Message-ID: <20260223145604.4042568-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0149.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::34) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO6P123MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: a86e2926-241f-4806-8277-08de72ebad9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AdBZq1a1ff/VmcQzSNyjAB/SDWW2efyfhE1yhG77ZKDQDfZyOXgWwPEhdxOU?=
 =?us-ascii?Q?IdjGtJqRJ/HB1Ldm0rILRo6YLOGYZsygWiEqK4G+UNd5PPGJ0EGXUhp1Ev1K?=
 =?us-ascii?Q?zETA1SicMw6jXzW4DjYQPcP7STpIfcMr/wpyS6U7p50Da+MteA7Weq8mc/ZN?=
 =?us-ascii?Q?Ci3AciDyDIVw7vMaTACtuh5Mn4CElCUAvEP44N3bXmC9OKaMUgAw8FIFpcAS?=
 =?us-ascii?Q?SlQ/Q9h8bfWRop29/TIyOD1h/emisrVnqwv7bB9kFMP28pz0mSa/KO2s/FHx?=
 =?us-ascii?Q?oIIeuocDXy2/OhMbgTgUpZjs9dgIH44Tj34iSbEwKWUV76cT34jAN5DRQxOW?=
 =?us-ascii?Q?JB0fAOaUVBZlct5a6Y2l3KjELvEMwRAlhB9gZaRapaaq9X7gAlfAErE899Ns?=
 =?us-ascii?Q?oQFpIUIRrsBlAtP5pCkDTS3i1FKONUE47AryJqO7q/XRRRXZmiIiDXMhfoHt?=
 =?us-ascii?Q?Qr+078f+WpFa+7c+XzWxn4HV1yImCX6hRDU0sejxMF85b1XHzc2ZvUv7/y4E?=
 =?us-ascii?Q?JF1W084i79UgOcPCrLcBz75hoomLSiW042ZtF8O98fGiVD5SoOBvkLay5XkR?=
 =?us-ascii?Q?/LN6U+3904DPmdcg4DQcsLptjSk3KNr1v6+2kUcX+v1s9+hUiEm+D6IcLohv?=
 =?us-ascii?Q?XmiGF2JJquuK6I2UM4vKQtANZdlIsbeq7NMeyXLGf0yTEGbylbofrr2S2SwS?=
 =?us-ascii?Q?lMnPAdStvFZ3SJ6UBuxIWGdF5iJsx1Z9dzAykY8g/oRVENMYiT/YA+BPnsqh?=
 =?us-ascii?Q?jT1aqmKrV2ZcYUDsPTS4fcDdd74OliqigsWMo8TUn/MblfL57L7WIBlQ19yr?=
 =?us-ascii?Q?TQj3nAwRjM5KRhRKFsVEcFxXKJNeopwGVab8Oagfn+NLq4RPJrr0l+5vf+6d?=
 =?us-ascii?Q?5RTkXj+ZS4g0HykYhk8yUkzTYjbQ6iblbpLvq1zteM90RhIA8dgusmfA0l2A?=
 =?us-ascii?Q?rYrgicxUb+Z5BohfuS5LD1gwZ/SOgAj5GWVGNVyEd+JqaBKwFwdCG/ekVfao?=
 =?us-ascii?Q?MUgpM5F4Kz7Ngom5FjwZ1PTCsCJb9jgkl0cq88SpswEZmT9khTVSPodzF2hQ?=
 =?us-ascii?Q?6Pthj1T11LhdIJrS8Wf7LwsyZW/Wf6L27OL+aXhlkrO/DA2RJq5MpI09J5n7?=
 =?us-ascii?Q?MU2axAtxUUEwZ+DbUjTM94IHyGtwzzxkWR4qoy3fr8qAhvshei3IBDEI+2nY?=
 =?us-ascii?Q?k/98gViZ8+zc++6ULMA3O35/QdvovUBJt5tcu+pcRqxSdaVyWL/jkrojf3/y?=
 =?us-ascii?Q?WHq+aWNajksMLV49gDekLHP1FyY5yabRa79JZpUAg4bPCSvUcWJUMVGj6/YW?=
 =?us-ascii?Q?x8IYcdhUZQ2VBjc+lBBXa3HvjABm34kGqRZkNwEx1zuKbf2xwXvBf80QNfvB?=
 =?us-ascii?Q?jRLmNASA0ntLSa5+3oCArLjfJLkP9R1ccv5Rg1QK/+kPExy2K6m2Jvksa7JN?=
 =?us-ascii?Q?+iB/fXIO7Pit/Oz7CKoT0nN8GrhhZBRQNLPTWncoknY3/4F8+kF55suXAb0e?=
 =?us-ascii?Q?OU8Nw6vlfUuPzo8bmkMDkHNXyRanH2Ss/XZT7yDF8UB6n8ENS/2qJ3IUZkxI?=
 =?us-ascii?Q?Ydoj9TcVhTP+iZSLCZ4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HT07/yHaYQ5CGO63ha5TV4r3Vj/8D08+Vo9wQpm1SHbQSCxr5JPrKsKXmxz2?=
 =?us-ascii?Q?AyJW7GraEVqIjO+keTnCAhXFpBKB9c9EQhhSmy/LWs0bq8BfwhLRsne+nw4e?=
 =?us-ascii?Q?RIIVtKSJ086vPHCsZIxTRnFr7wOQ9GsV/M2rWunP3VS5FbFsLTMTUlTv7Mna?=
 =?us-ascii?Q?uECC1hvhsMGQrdsBFUhHTjcfYnirQjOJbaVbnkzvy/lIBgBYIdkX/xDpU0QQ?=
 =?us-ascii?Q?Hg09V2lznHWjAI2IThF2B45W9lg3gF+sF33kY33hRGqRFLW/CEB+hnyPsns4?=
 =?us-ascii?Q?5ih1CNL6LozeB4asVHhtLWxPv/ZKgIWDJq0ncc+/FJ88I7JTumHuT/iG9EcJ?=
 =?us-ascii?Q?PHh142DtimQYU7NjcftP7ZhP6y1NlYBr0YplOd2Zj0lgHdQsuPcDNqnfi8JT?=
 =?us-ascii?Q?WvWRkfOhuS3OZjsM94qzVpzWUeGk/lhBaLeuptYG/qrMUVkWxL1pTnPxBrkB?=
 =?us-ascii?Q?/sRT3Z9TSckUWc8/QOibmzCjO+vZ0oA9VzwqUdA2+MgsH+07lgT8b2merc5B?=
 =?us-ascii?Q?Ie1+933N6NUwj3j030lGE/4uLNFzmebmYCGgXyalsycwmA+MnyG7uS21sdvF?=
 =?us-ascii?Q?31JU6hSYa3PUTCU9iDJH629KgmUMfDlTIkwaGB7h8OB718I/JtZcwU4fa96J?=
 =?us-ascii?Q?bwpXzEz1RBbcEqbMkJJ+942p4Oy3VmdxrtOUffCWUVgVRZVtnjTaemCx7CsZ?=
 =?us-ascii?Q?K74DXRya0bIfL0tXJ5PoKJ9kEEhCctDN13KmO4CUm3LEuf9ddYDUjtPdf+F2?=
 =?us-ascii?Q?u7Zsv2uonr9fPhYWBFvrAlQvMJkLWTSSyRmmig21BDzEKUZjux2ON+jhmJXZ?=
 =?us-ascii?Q?zBasjXD3/afQkJr73ovmR5i8K95XZ91Qc9nD5olTJceggJyFlcNTUaTgRaU7?=
 =?us-ascii?Q?3reIdCz39q8OIEtW6+7w8ihbTKh+1B81cqOqILF0JZFoIYCT9D8mw6O11CPu?=
 =?us-ascii?Q?zfUmlr1fgAWPDTVbgT2Z9Vo4NX6MihWVjRVdhFWrHJtnco1IDV9EJ0oquEha?=
 =?us-ascii?Q?o3CJqlmwmSYplvWjxcnlBUwN2g7ijB9gbpwv3j00xAjBynSPTv6bx7AqXP45?=
 =?us-ascii?Q?IpRY9LFg0Ozrb+QHdg+7ayTvjLwcRmEH6DclRvwYxz7kmS74FrIqI4m2OAJN?=
 =?us-ascii?Q?sM2Dbxp/WybbAp3e5+JFtp3WEAwQ/jxJk05pFNDjMwNIG29xp4ts+/VEFB5t?=
 =?us-ascii?Q?8s17irhiBWqApbBZFDwGS+ygmWGX7B2cdQLgcDNHM2N6ksOQ+5lUYiCd7Cnr?=
 =?us-ascii?Q?Qg40vu0aWjWccnAE0i+l+fEk71714l+6Zz9hNFEy+pA8RmsXX6RzZfgZRAXt?=
 =?us-ascii?Q?qMR0nQbcMrgdTb1OE4jvg8WeSP0sXNITTAVgyIwlh6A6vgs7HT6jDHaOmXtx?=
 =?us-ascii?Q?kQEhmMbqUYt4hJEFA//OMnPH9TATLVN/0IHBivgDRLTx5oz8wWnB8TF+DdZ4?=
 =?us-ascii?Q?r5HLnGhMLVx9vJ3OyC6O+Zn9BHpOD/bs7cpO3vqo+A8xEIqk9PfSRvbh16oN?=
 =?us-ascii?Q?mWZMm76DL4bERl5EZGEy+l6UPCa/BQTA2UJDH6iXe4n19RSoKdrVWJhMQ+fA?=
 =?us-ascii?Q?yyfXuJ4buMW9RaEOr1S+4l6WyS3X8q7xkdVE8nU2BkLx6HHMsqw7CY1r7i2s?=
 =?us-ascii?Q?71GoDc1F67tnJ2mfXEHQGsof2kV9G9O1SCX3ReV0CrrUfkgmizfyXRbUCcyU?=
 =?us-ascii?Q?nVksMZAe65EBeAIZFl+FWrPLGlYlJyRGaBkefTMVpwGP2MVki1xIsfwjNJlL?=
 =?us-ascii?Q?txa9VAuVtQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a86e2926-241f-4806-8277-08de72ebad9a
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 14:56:09.1177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSuAD3H+NZfjuAIuEnYgBVgmnwG+IKkAy4jzJSotIIbett2Fqp16w5gpUMHtd4ykCOHlYZvblOrFWMo0nOqv7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB6708
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-260074-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[atomlin.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[broadcom.com,vger.kernel.org,atomlin.com,gmail.com,ashe.io];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.975];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D016178535
X-Rspamd-Action: no action

The vmxnet3 driver supports an Rx Data ring (rx-mini) to optimise the
processing of small packets. The size of this ring's DMA-coherent memory
allocation is determined by the product of the primary Rx ring size and
the data ring descriptor size:

    sz = rq->rx_ring[0].size * rq->data_ring.desc_size;

When a user configures the maximum supported parameters via ethtool
(rx_ring[0].size = 4096, data_ring.desc_size = 2048), the required
contiguous memory allocation reaches 8 MB (8,388,608 bytes).

In environments lacking Contiguous Memory Allocator (CMA),
dma_alloc_coherent() falls back to the standard zone buddy allocator. An
8 MB allocation translates to a page order of 11, which strictly exceeds
the default MAX_PAGE_ORDER (10) on most architectures.

Consequently, __alloc_pages_noprof() catches the oversize request and
triggers a loud kernel warning stack trace:

    WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp)

This warning is unnecessary and alarming to system administrators because
the vmxnet3 driver already handles this allocation failure gracefully.
If dma_alloc_coherent() returns NULL, the driver safely disables the
Rx Data ring (adapter->rxdataring_enabled = false) and falls back to
standard, streaming DMA packet processing.

To resolve this, append the __GFP_NOWARN flag to the dma_alloc_coherent()
gfp_mask. This instructs the page allocator to silently fail the
allocation if it exceeds order limits or memory is too fragmented,
preventing the spurious warning stack trace.

Furthermore, enhance the subsequent netdev_err() fallback message to
include the requested allocation size. This provides critical debugging
context to the administrator (e.g., revealing that an 8 MB allocation
was attempted and failed) without making hardcoded assumptions about
the state of the system's configurations.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 0572f6a9bdb6..0d43210de625 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -2268,10 +2268,10 @@ vmxnet3_rq_create(struct vmxnet3_rx_queue *rq, struct vmxnet3_adapter *adapter)
 		rq->data_ring.base =
 			dma_alloc_coherent(&adapter->pdev->dev, sz,
 					   &rq->data_ring.basePA,
-					   GFP_KERNEL);
+					   GFP_KERNEL | __GFP_NOWARN);
 		if (!rq->data_ring.base) {
 			netdev_err(adapter->netdev,
-				   "rx data ring will be disabled\n");
+				   "Failed to allocate %zu bytes, rx data ring will be disabled\n", sz);
 			adapter->rxdataring_enabled = false;
 		}
 	} else {
-- 
2.51.0


