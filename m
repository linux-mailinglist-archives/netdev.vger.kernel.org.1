Return-Path: <netdev+bounces-68271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B3D8465B6
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 03:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFFF7B23529
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 02:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BC08814;
	Fri,  2 Feb 2024 02:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="m59Zcnmr"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2179.outbound.protection.outlook.com [40.92.63.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CA3AD47
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 02:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706840266; cv=fail; b=tHwuBUmZI4PngrwCmNSybWusYvNcNvDRny4coR/FLe2JZ1XcNmNv8XEs2GW6IC7nNwl9XuSJ5vR7ab3vQgz2zb7IFlcgJQ+M9fSt4eqTYNJFeJKcmD2sB+s/RnDuOI7ceKB1JQutOZ4rh0sigsee81mP4IFTNPJzklBStdMv9nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706840266; c=relaxed/simple;
	bh=cGk0f0UCiil/MBeWHTaHEEpBilp9I6rm4qWdP6PJ4hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Disposition:MIME-Version; b=tzE0z4AE9Q+E2+Q8txXViSxotX1+RgplzNtv2+i+lwvYnbqpSd5WOfXfucwHBvhmmUoE6UDR0Icq7myPuvcT+cIqcYFbw3x60vTSXozJaL6/RZiU1wWqEqLEOwndbeUJi0BpzB/r939VZvilMbWL8bjeBiBdUVjRHrN9F0BROGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=m59Zcnmr; arc=fail smtp.client-ip=40.92.63.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5LoqNhvCRCqC+v7A2hCmoqdt53r7zud2iRXMM3wZklSwVEi6l5ygzqMJMRSmdlV1ITa31TpaANFhdam8RnztH2Z75VI3+q25XA7CT8GVL/W+005hxPHddXcg136oRY2A0j8fUChH8oQboZ8zYPCtx1ycFcuK+1TPNTrPZ4WqArw+1DSXuDFaGXo+r4A+tHDwXDPAR2lJzZKjPpNzC+CtnhifpPZtbQBbzB6l8YHpeXXRazcKyu/N4aF66IWXJb5p92F/jljQ4Q5U8U+kAP750kQCbJ3EcbQvieHvnK/v7o9UN/NWqG+AHLa/69BN1vX6jSsrCBDNVALOwIe7w9T+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i691AZxmbSGoqzweucfhWFsak+VlbI22K7EEszxHzo0=;
 b=MdHhhCaFjgQWItxPWdnFHsgr5twNeaSTAXg4idbx372oCTNZs9BX8DqzKkhudS4GS9NejeQ/qYNm5CB/D8Vs65XmbV4NS89mNmKGWyckQcoR14/FPP3sQcijnS2XcroICZqGULL7WHBYcAwHYENKBS7Q39OJgxbpKb7hjTO2MO4AeAp7y1bN/xSTbNynERArQY7Cqz4jbyd8yvuAr35MYGOTuzeEYhcO3v6C3feJD4QOnNqOuPASbYv40slDUB4LbzREUZFW53c3GxrkrbZc/iZe/7D7x762SxffSsIUu6SeAZMqugr9OR2f8x4DIqQeXq38e88ucyXqn8hbJC7NCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i691AZxmbSGoqzweucfhWFsak+VlbI22K7EEszxHzo0=;
 b=m59ZcnmrQ0WilnHlI7NppAm9QKs85iNiEiFy/LI/5BFaxhyRou3QSN51Pc3UI+Q87r8j0G19hhjQTEuIjh/Na21MpFyDIal6u177Osh52jxHW1eVj8Vqtf1uBqSQGicWqEqVZXoNTzqFnBun8I1sXsQa5LuwsfPeCrql4/PMyJvcG21x8LTRltLQotAWtEDI1k8gBb82VCJ7/8Auza5xLsCW015nJv8oy08uANNq0zfI6YV6waBpdIb3DDyZfOj59L5MOaWKjMFklC+Y7/PJG8sRraPNTNMcEJO9jKr+/IKn0THw/Puo3Gq4e5EQSQ9sSNVx+VcfBXINwy8HEF+1ag==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by ME3P282MB1681.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:a6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Fri, 2 Feb
 2024 02:17:36 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f%4]) with mapi id 15.20.7249.025; Fri, 2 Feb 2024
 02:17:36 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: jiri@resnulli.us
Cc: alan.zhang1@fibocom.com,
	angel.huang@fibocom.com,
	chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	danielwinkler@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	felix.yan@fibocom.com,
	freddy.lin@fibocom.com,
	haijun.liu@mediatek.com,
	jinjian.song@fibocom.com,
	joey.zhao@fibocom.com,
	johannes@sipsolutions.net,
	kuba@kernel.org,
	letitia.tsai@hp.com,
	linux-kernel@vger.kernel.com,
	liuqf@fibocom.com,
	loic.poulain@linaro.org,
	m.chetan.kumar@linux.intel.com,
	netdev@vger.kernel.org,
	nmarupaka@google.com,
	pabeni@redhat.com,
	pin-hao.huang@hp.com,
	ricardo.martinez@linux.intel.com,
	ryazanov.s.a@gmail.com,
	songjinjian@hotmail.com,
	vsankar@lenovo.com,
	zhangrc@fibocom.com
Subject: Re: [net-next v7 4/4] net: wwan: t7xx: Add fastboot WWAN port
Date: Fri,  2 Feb 2024 10:17:08 +0800
Message-ID:
 <MEYP282MB2697010046A8F59CACA08E20BB422@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <MEYP282MB269704BFB8AC4893C300EDBCBB432@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
References: <20240201151340.4963-1-songjinjian@hotmail.com> <MEYP282MB269704BFB8AC4893C300EDBCBB432@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-TMN: [7tdnE/MmoZofDnRfkpbKX0ct4nR/CG/Q]
X-ClientProxiedBy: TY2PR0101CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::31) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID: <ZbvC7E_J7U6zBwJD@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|ME3P282MB1681:EE_
X-MS-Office365-Filtering-Correlation-Id: decc244c-419c-4667-349f-08dc23951f02
X-MS-Exchange-SLBlob-MailProps:
	dx7TrgQSB6freGFPHZ3GjNuqOE2HYSoacIlkP77+zW5GYTfXMYFriE7aKls/sse9QhGsItlsXdd/SINTBHhfwfxWnLBGUBDbDOFiFYrbOg3ZAmvsq2RDV5+MjKCp+a/tjZeyDNiLaaMrSLJyPwB98qH3MR7ZDgBYT5P1CtaUhfyb/MzU+yIMw52oAPkRkRH1P3gtZlq2fPYYbfYOsTFLenMAjAQ5lBTcNpKTjL1VJoTjE0GNMuPwE/uKyBbvGOL4T+QlhLK2Ez+PtY55VZ6u2/nmcTuPDFsbBnBb0vEO8NoOfAwCd1lpYDPKZnOS1cgqXcFn+uwkz/JgJuGfbyiiu22gTx+nC1nftJrZT1Er7mOlJjJ0QfDoTygkxg/jUN2q+YjQobFSA2u2pcMfmtoxOulbe2aOmXgo2HCD1JcmBHhdUkr+xINrdMHMEnnf2tlpQ4aaw6T7JxnGzmVbou6YyCqDeiKAJUGiFxBXA7dnT8qca0BYhqDP3qWoWV86UUlb7hpSouE7l0PfpGkppIV93oad0zj03u/6UE7ztHU7ACZV+IPzqEbDtpa+mqsCnIpupucfXeofuvwKBYgbIQAI0OviyrNuHOwOntkqiHINCrH2zunufirI8W9Iigxkz6OyHyVP1y4Wbm7wojNmEMBAiKpaWa7wqzkS36vABwYJGLesnaSbYP/5Kv4QJ2m+VPBG/rtZqJWZxI/vOFHA25mJodV3HWE1CRSbZNWNw0DcvgqZFOaIFJ4Zh1KsO4M2V3udgkZb5jGEMN0=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yJhnhh9n7ZJnhjTZ+iDYM9u7x2zgURYQx++gDUK7SgK8d9CNSo5uNhqxsjI3ISRrjVkBm8EQ2DJsnWKKocyUBnpoFBDJ+sgK5scnOjB0z5ak7CHrQm10QhcTlhrpqvo32pJh8uDYV2BXudmwJKrHx3E+h743xACZiQVmO1W0fTP9pxGaDksT5AICw9SSMelt2lIKppq8R5c6tFdS+SRY3qKM8bIizOuT8YdvqTFusq95VhXseOmHS1zizvEzszNl+IBrKsYc9IDu/cnjnvedko5nZ/O7vCxj0mM137l94wb+T4ak3C/t2bs5ywqYTLfgz8xke1aX7vKpVN8ql4W7JkoUbB1DxHd1YUJNikJe2laXTOhBmE9ff2iT179zB/ALGcYP3s8/ihtEiNRfLJTjMnxqggCCYpI4dMPNptbjWwJE8nYMKT9+zjK7LUqYdzrbTm9J2KxtColDXUgTMRE5aGXnGrRP8RufWRRCK9HxkAtsZx0b9QDRjsYaBdzWw3cOKUBfdAeTlBx2lVFgajBXdnivjnFkJ8rBChdDwsPqd7D5APTPXSL4mx+aUx0dQtbYqqb3sjDxqBOb4w+OR57sOMGwbwK/XH2L8cHleeF0iHU=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0lIcEWU0mqSQkbtGzkQLqHvCvTc9Rrow6U6tLahV6fhZO6hxQMedYNjwhQBU?=
 =?us-ascii?Q?f2RIb9FHPGepJXWGJB6C5vseM7bkEYUVjZxJbKp8F70znWOoWa/hkzfv2rSt?=
 =?us-ascii?Q?Je6FUXMxs2oo0Otr/hr6RcI6bINOLPYnVPxm9ifbq6idz4OryHvafAGVa1Eg?=
 =?us-ascii?Q?/8yUsTf4BQp3bJcN6Tof9wUXw2wckr4guydlK+nQOWexzevmgaOKDfnGtZl+?=
 =?us-ascii?Q?h1OE+2+4kVjaSJyW+WSpNmQRVqzam3ZckIq33ESqs7FxGdP08UV6LsSAMOQe?=
 =?us-ascii?Q?m2iiRqlIeenULWZkOph6gQfxlNzQ6MozcO5zcFQnlG0bIP/hP9JZoyDBGmGE?=
 =?us-ascii?Q?9LBtDONInLz0kRhGnNe7SFaKc6AogQ+43+QkvXkWiUPNH2s2TJQi/mNGTjhc?=
 =?us-ascii?Q?p6d/0PndoGXigtUMxG/qP19tiUp2yP7cSlut8feMk1Z5HCqdp8gHgmZY7dun?=
 =?us-ascii?Q?dC91kAxhbaKJqA8vo4vyWwUg0t0l5fztgJJ0s1n2v+ak65xpA4IR/lLGHC0V?=
 =?us-ascii?Q?DA7Sa7S9ROJh0aUE01qJPrywJuUW2SNQANoNrefqlS9n0Aw3g9IrAZ7b6vXV?=
 =?us-ascii?Q?fLHHmzI5t2kErfOMmo30ApzMHu5VeNb6P6If49GhXW1JvAI3sfQGJI1ZmvSn?=
 =?us-ascii?Q?DGl04S2kVAk5dQUAfhEvAPoUmDiOB+o9nIq/yQrJu7KTQX1EnjBcQj97Jggg?=
 =?us-ascii?Q?dkRPMOxYm/qstEtWBiO4Kav6FvBxJJQpvc75buDd9ID0lcST3Wa2h5AtknBg?=
 =?us-ascii?Q?IOTlQZuiWFmVJkeSCex2R2aGM/Qyi/VLtGZ78xLWQ/bzqJlmsSaux3/gTE1x?=
 =?us-ascii?Q?Jsl92xaBwgWUzS7/Y44wABRkhAy/DgRVEDyaigovUDnoexDVoza8uxPf0lnZ?=
 =?us-ascii?Q?EFWWypMLqoJ8YgSXiQ6WKFNKHt2brgRsIQxTRrh8js7tbFj3yol/GD+aPdke?=
 =?us-ascii?Q?3GY0vw8fjCiWaNfRwA9a9szpyy1nZPsMzmIdyMF2VRZKqdievjufmB2uSZSj?=
 =?us-ascii?Q?p79FtVtV6rSWZbX69LW+xr4vBjw0VELLTIbJh1a4DFalGGTyoZDgkt4YgxrD?=
 =?us-ascii?Q?9dFScImzmj25EGnH8b+uVFzcXy3hkKA+/YKxao/PqwuYedJw1xMoC1kazU+/?=
 =?us-ascii?Q?jrBTdoLz9buYcLGXY6w1K4HJxipXjStLCBy7TLCIT1vh6PUT5aFZEv5ajg7E?=
 =?us-ascii?Q?FhEd6xXEs5le7Obkp2pOBHMX0uBXlnTHqgzGCDeCzyb2MKT3XYF6nEOiAVM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: decc244c-419c-4667-349f-08dc23951f02
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 02:17:36.0424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB1681

>Thu, Feb 01, 2024 at 04:13:40PM CET, songjinjian@hotmail.com wrote:
>>From: Jinjian Song <jinjian.song@fibocom.com>
>
>[...]
>
>>+static void t7xx_port_wwan_create(struct t7xx_port *port)
>>+{
>>+	const struct t7xx_port_conf *port_conf = port->port_conf;
>>+	unsigned int header_len = sizeof(struct ccci_header), mtu;
>>+	struct wwan_port_caps caps;
>>+
>>+	if (!port->wwan.wwan_port) {
>>+		mtu = t7xx_get_port_mtu(port);
>>+		caps.frag_len = mtu - header_len;
>>+		caps.headroom_len = header_len;
>>+		port->wwan.wwan_port = wwan_create_port(port->dev, port_conf->port_type,
>>+							&wwan_ops, &caps, port);
>>+		if (IS_ERR(port->wwan.wwan_port))
>>+			dev_err(port->dev, "Unable to create WWWAN port %s", port_conf->name);
>
>To many "W"s.

Thanks, let me change that.

>>+	}
>>+}
>
>[...]
>
>

Best Regards,
Jinjian

