Return-Path: <netdev+bounces-68536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 276BA84723B
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 15:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901F31F28559
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 14:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDA97F7D3;
	Fri,  2 Feb 2024 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="YZUVJvZ9"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2170.outbound.protection.outlook.com [40.92.62.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4C32B9A1
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 14:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706885615; cv=fail; b=L2qzHwjiYg+CVyWdpvaAVX15Mt/Krgsn77r8q3xPJo5+JxfDWLgJaNZHqnXdDFfwiJdj1NZiNHcz4L/GshHGKOz2ETNqtdvXM8dCP3FOCy+M7ooWkBqqUhUp4KtkwdRHVgHwA83fXK4ZLpTwHTfJ7t6qqDxlusx15hgUcUtCteo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706885615; c=relaxed/simple;
	bh=VKVmpAdjf6CV+EgO5zfwpRIWbaxWFT9Fah+mEa+p1xA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fEFuAt1dQty9Tz7PnIXi1+TiuJHdP8QIcPbG3sbpHvQk07ULgSMgJKx7g6HIBAiv+gNSlnZkoxkeaYFOp8BogEA27SMkXNcbi7UPNE+wbWZbHzLiBVxxithSSehI5YqJ8y0x7oEwtLSdejj+OLbFcEcHN7CGJ0KndhCmDGWAup4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=YZUVJvZ9; arc=fail smtp.client-ip=40.92.62.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRWRpvuWbuZ9+Rbyjv6rnYyuVFf4vM8uLIDzb7mLe5uuO7DbCcJFg6iCA4CeWf1R/eR934yg7fl37Bt043QERR8+fL3lyXn8ypbI8/GFEkHX/AIY+yEe8RZIAaHDq1d4UjhopXUJvLWZBC1/av1CIIjwN8hHiQKA8H1GKBDKovKNuYLucbs1Qn3payI/oz+8UEAmqXuGLM9y1YD1ZSVXju2vNasxx3w8Lwp7fBkLH1ymK4DXLWGSXm/QalrfMjUnwf3oupdRqdqG7/iGWlZow7uw6AGi+ZWKIgA3ImG00LB1w4VAqjBpHD2xA2hcQGvfD0VxN4xFXGby1lkxz/na8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2h9kB2mGLjgTKKEFrINos0u0tE4/q+umYsKxWUGTd1c=;
 b=DcJb6Ge0wrPSCbc3WxGCEkk+A8dMkZHTh37gk+iwtX8VWDO5xwdfVvO5RAzQxIKfVfJQ6tba5dadIoLdoLlTAVbZUBqBlANGRJAz/vvKdOouZbVLfQwnkFmLvXoJLtPyQbXN1nLyqVaTdxeEMzCLrTxiudwOWofwOMC+7zVP2UhVL8awLkXIF4YvUWjn+iCYa6KNu/VMJLAhyNthGhbBHuvMJK8K6byuIevLWgsHgm1GgMoFaer2pV4bfClptfsCLwFtAbMA7wrn1poepfsF+CujbJM15NaelkRkDSdf2EdrP4OKMLMa03+yvgv/GAUJg7hLQyoWySLz/1NdW1t84w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2h9kB2mGLjgTKKEFrINos0u0tE4/q+umYsKxWUGTd1c=;
 b=YZUVJvZ9fqTpso52tzH1lfldUyeLm4WvXeMQGCFbL06c5EsaAJlhjtAsijHX+KlAYmXWd4RyJmKvyT1/HQDLibQFiBcMmTtlYqaJos9TnE+aXxMiUJYy3tPMftL6vGD1PZHa36XLUi/0ccGHPu0o/bcCPWV+I0V6hyYDzIxxq171VvE19WQAWIQnAn89r/F4tO/roGUaqK9D2Fq86JpMMrLajNRoqMpSBRsYH9Nm2Ne/wrWBlmi//oaH1+KBFs5THtQC7sB8x3gy6HS/4RTDreLvxGkFDMkvwnULBdB/4EWZGykAFOb2iOPDj42Ygeh9FdUIa2pjLVa2yPk+ZfiGMA==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by ME3P282MB3821.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:1bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 14:53:26 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f%4]) with mapi id 15.20.7249.025; Fri, 2 Feb 2024
 14:53:25 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: netdev@vger.kernel.org
Cc: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.com,
	vsankar@lenovo.com,
	letitia.tsai@hp.com,
	pin-hao.huang@hp.com,
	danielwinkler@google.com,
	nmarupaka@google.com,
	joey.zhao@fibocom.com,
	liuqf@fibocom.com,
	felix.yan@fibocom.com,
	angel.huang@fibocom.com,
	freddy.lin@fibocom.com,
	alan.zhang1@fibocom.com,
	zhangrc@fibocom.com,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v8 1/4] wwan: core: Add WWAN fastboot port type
Date: Fri,  2 Feb 2024 22:52:46 +0800
Message-ID:
 <MEYP282MB26970C71671B6059AA09CFCDBB422@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202145249.5238-1-songjinjian@hotmail.com>
References: <20240202145249.5238-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [0j1rqK/dlkAkqRYV5tagVONX8jGr53cy]
X-ClientProxiedBy: SG2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:3:18::14) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20240202145249.5238-2-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|ME3P282MB3821:EE_
X-MS-Office365-Filtering-Correlation-Id: ce7d0e6a-a3c0-4d44-cfce-08dc23feb584
X-MS-Exchange-SLBlob-MailProps:
	dx7TrgQSB6fTa61voF783eI3ZA+3oOgpK2prsoeECSDw87WLOwlpGSTyUj2efvc+Lc36Y1CWl12wdekHqM5zAFq2pVp8QfmfIJfdpAgbF7E8oGlPABcK7Da/YwLYUTEZjsEvJ6GFzNWXmb+VM/B5wB726jKtg7HeuTcUXuYDotb/h17hbPu/txz58MJUpfDvozuCzXpBKkuccCamjMTbWvj8xMVVDWv9OuZ3vzcx3EleRXTIAU6mpS28OhcmmC9n2xPFFrMAgmOH6ckVew+XEKVzVpGGn6Vr3GNssfKR+xh9WfqM0gd6t7iPKyvEj71oRVzhOXuuTrt5IctQARPizhKl2nzdeMhSwYX2JYKV0Yh22zavOLLmb9QWOd738+HDXQQiWU7CNRPENUtPNFsZ48fp7rqVAcPF//JOarnqJuEg0LZzHbZqBZya9tefzFmqUaySiigxd7husN7MWj6kZiGxvau53IGMwfsx5WuFcqJBewmkOE7+9DXLKCQgRr6K2QmCO/nLDYrkQJYVjBARTY5TfVpqoJKj87lY2QMDxhebnP/OQ9wERfGCABRWzLNDkjHQ18F++vZr1fR/LBTsbIfCzOapC35d0rAxKuwamU1JLlgMtvZ1UjBnxliQtp/7RjZub0C6MEv3jdB3HPZ6q0eAm3rlU7QFVVrsx7gYTAvHrMEVIlI5kysQGi8UMiK1BS0S9xZwBA98Ccp+LyQ/7QW79pYa8B+hSGADBRa907vr8WtbWEjvhuKr4jH4ePH+77jRiMQb9yw=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bbQzJyXV8bhOnzZ2unlaN+cFO3TbXs1WnfMIVd7zYkUVNQ9Alzm5bPUYRfl1n/K1X4T+z+9se9+TjbfXK+qYQ4XTYiuMiiBAQEYCAEXLdGy6A7CncV+sKa613lLqMRy57NmmjE3zwrSJTYlUA75en5718ireJDg/O0TQbI7DUWnuLcpJO+XBSoFYwxlp+qoY1/1QwVHAAbC6RFPL30jJPkM15DgPODNtSu3kya834Nop6S9BWMtOoZtKrKbcR21ic5dW7jMDCa+R3Nip+tPDJ0sdzyJOYzBGmO2+KwgQf9aYv410a2VmDHOCNjNhD56dw2UV2XoudSCcknD/17TS9/W1KD4y1AEh43+OXC5Y4SreLUl1eHT0z9caHu9uutdSesgbT3KI24XFbnoMqJTERMt2n+auGF/hpBcNwwPaRuZK/2yfZOtou/98g7Q666TcTUPRbr8sX7JKNS2oMvMywrOVGAR3os6eeb+DEqnVFXfy4q2vT2+dfjTEaiCUGTJL5hoaVhtGCKXAtuepi9W3FIHKy5xx8GQvnl6Dp+eUqf7FkkO3joyhSin6BPgvvDnK
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9DJQS65BeaEj+WkOMTcwBFxKGCQnbky43N8wS3sYTua6BdBXxlH9TDRembw/?=
 =?us-ascii?Q?6ZSPVXo3e1a7gaC1775DthBaxbjvANLkp7qVh8Oeo+BUPeKc7kRtT9bKkVuL?=
 =?us-ascii?Q?ykoQJrhUsPoLB9X4RxeVElqAOjRm0IqFJo/Pj1EdbWLqCnhrkHdH7iXLiiL6?=
 =?us-ascii?Q?GzYiGr4js3bcp5dFvtGl3da5wu0VmyuAXPUUPMiQ3yvyzLBIszSEDEDXtJmj?=
 =?us-ascii?Q?AZUqkcktPSLeqD2DYOvWGREYX9hjchxMCb2bPDZi8VtB71eP+O+XXPXWTY+r?=
 =?us-ascii?Q?bV/IpkyUDndDkTWKJTYN4Mm4IpS44L40tgpyG8FGMlZ5Kj4fkHzMvkP43gR9?=
 =?us-ascii?Q?1WizyK1mcdkbF8MX7Moz3Cl2eq64ES3TYqnmQYT5p22DhXTO4qYo+F5Os2K8?=
 =?us-ascii?Q?vKTgvon/5GcNn2iwe299NUA0HEPBYwdcTia7g1IykCUWYx3MAyQbZlotPIh8?=
 =?us-ascii?Q?Zh8A6bmSum41WGDL+qJbJ1pd9iCikotcuD4ZgD1YLTfW3MfCZCaoGMqK/vWg?=
 =?us-ascii?Q?I0rLqXjDPpqyiER7Dy6NVYAaOZWMV4fy3KfFHpfRUC7/R8diUJdtZGncLk35?=
 =?us-ascii?Q?Eu8XNJ5xF0ua39i/LPNAIhMCHShWU2VzTkVRyS1//BMHMRokxdTpJLGr1ZKA?=
 =?us-ascii?Q?EuqlDwStMBqC67k9HfIeuwOlbWPNASxKv+1IlNJc6YMmrV92/mYUIslT5NYy?=
 =?us-ascii?Q?wsc8ba6Q7h9qdJ0k6Ndre8otkgUgtIRg6r1lFCbY+wqraRx/ZnVIU1kYrMdk?=
 =?us-ascii?Q?OgTQo/HLYN5d2ZeURBHY8+ILEVfxHAwgJqmbLAeWNsBgDZVqj/UiSxNu4KZu?=
 =?us-ascii?Q?/NRvJEM3COuIdHkQif3v58P1QaeDouBYHqI/NpPFD1uoIHXftHiOdEq3oViQ?=
 =?us-ascii?Q?2pOii+5IhhCjswl7O5lchZ24DtNLingj6JhbORntezQjaHvbfTT/eUf5zK6d?=
 =?us-ascii?Q?ffHHd3ShbjyjHThE6JrqEty4LI5POPtD6cQzuVdiZjuyWfCcBeVZljmDHE9l?=
 =?us-ascii?Q?0ZkrWC+ItfdfQO87DCDvmb9y6+mQu6KehUlZrb1ak9Iog/nlJfEITzk/Q5jr?=
 =?us-ascii?Q?//cvc218CPYsDlmzYp6hcI2dorhu57UysLKk6+p0oDReKdbYGW47+SOTt0sl?=
 =?us-ascii?Q?JD4syXusZtoxKFRr39uYcYTKKmMcaz2A5g2ZnEVr2se/9yvk+P2BXIJhz7FM?=
 =?us-ascii?Q?li3Av0q0qTaowpNCRvrJb6K/K+tLYbHNdvENaKsTWvZhaK0HYAriEVsWqZI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7d0e6a-a3c0-4d44-cfce-08dc23feb584
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 14:53:25.9097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB3821

From: Jinjian Song <jinjian.song@fibocom.com>

Add a new WWAN port that connects to the device fastboot protocol
interface.

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
v2-v8:
 * no change
---
 drivers/net/wwan/wwan_core.c | 4 ++++
 include/linux/wwan.h         | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index 72e01e550a16..2ed20b20e7fc 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -328,6 +328,10 @@ static const struct {
 		.name = "XMMRPC",
 		.devsuf = "xmmrpc",
 	},
+	[WWAN_PORT_FASTBOOT] = {
+		.name = "FASTBOOT",
+		.devsuf = "fastboot",
+	},
 };
 
 static ssize_t type_show(struct device *dev, struct device_attribute *attr,
diff --git a/include/linux/wwan.h b/include/linux/wwan.h
index 01fa15506286..170fdee6339c 100644
--- a/include/linux/wwan.h
+++ b/include/linux/wwan.h
@@ -16,6 +16,7 @@
  * @WWAN_PORT_QCDM: Qcom Modem diagnostic interface
  * @WWAN_PORT_FIREHOSE: XML based command protocol
  * @WWAN_PORT_XMMRPC: Control protocol for Intel XMM modems
+ * @WWAN_PORT_FASTBOOT: Fastboot protocol control
  *
  * @WWAN_PORT_MAX: Highest supported port types
  * @WWAN_PORT_UNKNOWN: Special value to indicate an unknown port type
@@ -28,6 +29,7 @@ enum wwan_port_type {
 	WWAN_PORT_QCDM,
 	WWAN_PORT_FIREHOSE,
 	WWAN_PORT_XMMRPC,
+	WWAN_PORT_FASTBOOT,
 
 	/* Add new port types above this line */
 
-- 
2.34.1


