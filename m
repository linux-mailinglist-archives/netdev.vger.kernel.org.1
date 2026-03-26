Return-Path: <netdev+bounces-271909-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBxNAqHmxGkz5AQAu9opvQ
	(envelope-from <netdev+bounces-271909-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:56:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 831F3330B8B
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E320301B93F
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 07:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEC62FF17A;
	Thu, 26 Mar 2026 07:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hk6K+NaF"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011064.outbound.protection.outlook.com [52.101.70.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C081DE3B7;
	Thu, 26 Mar 2026 07:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774511435; cv=fail; b=mSNNskbtjhPadyUoiDOhS3XiN32Tk7GWSWz99LzpXhC9zoLNkycbK5RT1AD9KCchi/IRPng1ZLXZobZyKL3uH87SjXJDsrA130S7lfyb3iXpWH9Vxs7ITJICAmrhGifF9xEVGk5BkyGcac1vDHfh0ifL1hpWeZfJdcb1aUss7XE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774511435; c=relaxed/simple;
	bh=+0VpZnLtxr0xQCealwSV7VWQuHSTmGH53ZKLyU8ESJI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VXurGN9r8SEiC/e+HchYJ5QxnaVvmyndQ06QpRi05zRk2V4O9ufalppOOqRgLRd8HldZmUfsccay7ogz8yE03Z5LKgMKUO11z2fKEWcLUdAWsbBXY5pggKvhSAufrHqCafQhOZHgLjWYdnXyRKT5MISEWx2DDGKUwtvYf/aiLS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Hk6K+NaF; arc=fail smtp.client-ip=52.101.70.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GxqQXmzFJEZBjMXVJPtKFB3m7ry9LnkvI/SPTge5yIFS8c5MJUlEpVlZvBYtauEqeoeDk3GJfQUNXclljFsMr8hAa5gQMJ6Sd1ctFdLzw1yyGjsw0KYV2lZUw8TqyFRw+eTd23xf+5/x32EHUxhQqFBcQ/KcNj8y8MHg51ohbFBcvuGjPf/n1GSRLMUB4FIVj7JXXsx5YvO1bKgkiH5SOxN8ocQM5QzHdfNBPgdhfb/QhsSAZZ1shpUOgR/le47wCFSV4oZ1OGhGyS/xJJlAo73TzRRO8SVO1huEW8FfEYUbcsRye+LbS5vo+G0vmqDTawHb4cFkFmGc42nQiYQW6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSOwxtd3Plpg7aD3exwgrD2YuU8ARRyWWMcoYgtFWTE=;
 b=Xoogedz0iAIatmhgIJLhS1J/kclAmEFk4ZSbyDLSnF3eVFz56/e0qzzzfxFdPnYgQsron+OU3wgp2huRSXyDRVziOTveSCeulF8nIzTSn6bWNhgtBz6WHhBA+uqf5xJPauUO0ysyjBlCjALFoXt5LlaG/7D01JqwkZFbIhwqGu/e7ykje9cBesbSa9l85p0KTDz/uAu6JoEXk0kal/N5GNkRhCdmAyojl1zTjgr70nmm2Adam07jfmA2yt1872c/2ICdJrtVzUaM9XfC1xwXW9qrk2fbvugGsExwYwDXbwHsZPUlUaxcG58JwWFOARW+iGsXix3HLPZ8ifg8ha7BCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSOwxtd3Plpg7aD3exwgrD2YuU8ARRyWWMcoYgtFWTE=;
 b=Hk6K+NaFaKPIb5A8jqLyMHTPt/XknTtlxJoC5TMRHxdRotQj+iOGvqLSwOcQWZf1wmo4D0IabbbkoLDnaRC01vUMzaOWjh9oDGSTjyq9cXT9TtVsZiTzd43Fj+ybqFG2aXrqkxBiIF3jH4Kn2ME+2ssOLtHhzfWn6BHo1z7nh5XMbKSAxqRsAZxs2p+U/UZ6h0VG/ocwSCuivo6VkVrtVcpV9EgOMuNC+DmwCxEwPwn7iSro45yMGOU1IR9S8+/4iFGZ/YsknwA1+3itKeB+XEP4FCn1g42ugNCHFdSWiZ8oNSFPKhyc4jrLe/1SABtdR+X9thqGq1WlTGC6NH6ygg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AMBPR04MB12282.eurprd04.prod.outlook.com (2603:10a6:20b:720::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Thu, 26 Mar
 2026 07:50:21 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 07:50:31 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	alexandru.marginean@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 net 0/2] net: enetc: add more checks to enetc_set_rxfh()
Date: Thu, 26 Mar 2026 15:52:31 +0800
Message-Id: <20260326075233.3628047-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:4:186::16) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AMBPR04MB12282:EE_
X-MS-Office365-Filtering-Correlation-Id: b044faf4-c098-4f3c-f20b-08de8b0c5a92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|19092799006|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	c+uTZESWMpsSRDPawFIyNJ+5nMtAZBbFUI74B0CEf59r/xGXRa8UFx01W/vmyvSGKmDDJy225/Qh5vhpVxS/BQll7UuMXF/LDZVMa20Xz3X3PsbHmG6Y0tf2+wH+sV/j1mYTXgHsd2cMIoaecqGrjDYj1sppYRpFPZNXnEFRL2AS/jHXagDz64p7faxkTaY8lhv+9glGthl1uN1ZLbt9WD55JucsM/ncCpKvLBBWPRDeAfWZn6R0KIXMP/RKPkd9cvZDevs/D24xacNHiMq8+zVevgorCkKspTBNqi9rNcWQ1a/pnLDIyhgnNBHa+vgOXqAwf2Jj9CAwmNzX2fhKPcHDDeHbaxPHqdOd34uW4M4IEBvaAffIx8oG8zo/r+08LUjPb3s4N28FsIEK9WjRyHroR0iySYq5OWfwnwy1cJj7W7iXctZjR4mc4Tfy7DAeWDtjV01avSKUQUlE9UCLMAL5GEBocYpLid656yD1Qo9uAu+yzZ9HIolVOEShX1++0WWCGsblOGaigH10a3b/HhzBKP4aplflDtxcibS+x8QNdqeRy0OE3RaU5pU9ZNTObSKtroLT2DvOdJsYaS7chX8hsc3iY8HwvToK6etyEPNnJkh1SxjbDSBFYzVtWFrDDQaj6+zgRwSDUSCXuWRjzqIji+jxSQZCUdrST7OHBUJ1wpvQOI8sLX2J1kfXTq6SO9CDO5wbqxZwyhHAUfDhbzgqs3gCZ4nsyYRSsYkwQvukLTx2BcYO3hm4R8ykbNog4DNr34QNTe57+YOehQ/m4JjmABvBEMVYUvkbpIgKS/4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(19092799006)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+ErObyF4TLy9lslSAqsv1fd/hMGMUDtlwJkeb6rKgRjb71qx9t3BYRRViDDX?=
 =?us-ascii?Q?6vjKei/ekrjj8ONhzPMzCxemLaXW5rMf2/msLzvudzS+aOSChurR0uYfmjAv?=
 =?us-ascii?Q?HECHHMh7zmiv8uaHaxq4xDnDNFSN7cxqsOVAvOB3K4MLVLntCHfZ264pJVzl?=
 =?us-ascii?Q?h9/sO31nxxUUk6TPt5/6txMTZFpgB8wOI2RWjndFjWTtWKx47qH75Z6mOXGA?=
 =?us-ascii?Q?Ah8mkeuuxt5+tKG9JcBsq+oyVuNZihzqtFOxEAxcqeeB8CBstx1xvPhwjhRe?=
 =?us-ascii?Q?ixAc7BSONfzhXuZlmExxiZBAYlMgHdbjARYcUrCqQe34fOYIBL8EcvzC0Nkk?=
 =?us-ascii?Q?GdE4P03KlbO4uLvg2Hb6PB3+04DYG54/yNckQ12xYO/Pgi9VrJAUXAyaKw/S?=
 =?us-ascii?Q?GDP6LYF4Ye9C2A5/MPft9kyLvNQMG6zxiYPkUgt0wW4GH7q50Oa98vhWiwaF?=
 =?us-ascii?Q?W7sSZYFMk6sG4QtXxUz3FYJSRn8KlgBcld5EsQmuQIJzDOQjvZl7LWpQlPtG?=
 =?us-ascii?Q?nB9OfBvb7mQe50s8qaXgnTeXEp2SBJhUtMzHyvVRhjDpu0tgdwnLLiQBYsNy?=
 =?us-ascii?Q?ZwADnK+7ya4fMgKSX2nAz9EYy381Z9BqN2tPdmNjlhXndpUYW7bI9X0MIjYW?=
 =?us-ascii?Q?SCKHsV0pJPA/xAp49OA4r4ObxD0Pwo3pEZ6DZkZq0S4CB6wkPiAjRj0b1Zij?=
 =?us-ascii?Q?orhzLVUIMU9fCc4DfIvPj0X6WQWMM82CAC2GJgnHhwvO17aM6zb2+XQjZhUV?=
 =?us-ascii?Q?RLWr9klqLi7qfImjCwPCCEJP/r8jJeMkePNALVtelgOU7vbslAVNCvWh5pQl?=
 =?us-ascii?Q?O5sxUAxRQ7BZ7mvcGxUYyHi2K8RJxozdJBrUevvUihCWudjkXwh5dibM1f+c?=
 =?us-ascii?Q?W1f+/jQ93xze+KNefO9kICTqg7pdsKIPKxbQNAOZ/I7o5rSpKdpvIbyXaWf2?=
 =?us-ascii?Q?yZEMkgWYvvttS9DXfsB+5FMZK+rHAgsWq7kIOq5l9K+h0ZfsDHwiGTnzjziu?=
 =?us-ascii?Q?PaxKXZ0T3TaOldq+qK26BWmptQdl6GI5l0PTPj0OMHZ61zIsuFMVBtqZSQ/C?=
 =?us-ascii?Q?sLTa9pY/XN80Cd9hkUcHdOGejKwy/R1rE8yv8OWRxRrCmBrvoHWdKa6o4Zpn?=
 =?us-ascii?Q?nG/mDrY2rhYX45JJBWAPfEM08aXVyjxryUphYy4BnNfVWde1ODkvdUt8LUVE?=
 =?us-ascii?Q?2HmUfEUSkAX/lmkhpTlOBmYDnjjYNETmZAoWdRvmZhTyoamEWmG5D350XvoV?=
 =?us-ascii?Q?DDFq1OXPppfpUJCdhCrT7KmrsFb44gEpE+jkTGREUjnsd8u6pqCCUUmsqQa6?=
 =?us-ascii?Q?IhWvsbqZQ6U4pWMuawEPhppVzXhK4cN3XxERj6ypBXkP875mDSG2rYW6xm6I?=
 =?us-ascii?Q?IJnTF9mBqR8nx5/vkXxp6vQFs+3eFq6CXCHcJqqsCmVsyGGWZHR1mQ5KIIr2?=
 =?us-ascii?Q?zYE7pV0RxKlD8pwXsMdyvYTKkerZMoFC210S0M5H4qcuMuSJZV0ZWueVJYUo?=
 =?us-ascii?Q?5Um+UEF68/+vGh2VITWNhAqptubjFHoGtL9MjN2sQENGaExKCJDdX+urJHmx?=
 =?us-ascii?Q?vCu7Wqm8ZIBljO6vfFPJ7MHTgoZGzjaxrWUYfrAreCqOwgU1NcD5++flF5fx?=
 =?us-ascii?Q?sG06G6xncZn2q72Lse8hb5wIbQxGvB7NXbbbndZXbOyyunY5aMd/gMDub0uL?=
 =?us-ascii?Q?RjvtW/xPsNlincnh4JxJqd1DuSb4JMana1Pq7ZuRcfGhltMavtjjBP//B77x?=
 =?us-ascii?Q?3b2jT9cZ/g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b044faf4-c098-4f3c-f20b-08de8b0c5a92
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 07:50:31.1627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/trXBaHGw6Jfgv6LDlLDidCqAUQwyedVEPD2Q+cYMP82Xli8UyoQ5ge410erVW2+RxCYeUYhYEs9WW5XDlgDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12282
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271909-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 831F3330B8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ENETC only supports Toeplitz algorithm, and VFs do not support setting
the RSS key, but enetc_set_rxfh() does not check these constraints and
silently accepts unsupported configurations. This may mislead users or
tools into believing that the requested RSS settings have been
successfully applied. So add checks to reject unsupported hash functions
and RSS key updates on VFs, and return "-EOPNOTSUPP" to user space.

---
v2:
1. Fix a typo in the commit message of patch 2.
2. Collect Reviewed-by tag.
---

Wei Fang (2):
  net: enetc: check whether the RSS algorithm is Toeplitz
  net: enetc: do not allow VF to configure the RSS key

 drivers/net/ethernet/freescale/enetc/enetc_ethtool.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
2.34.1


