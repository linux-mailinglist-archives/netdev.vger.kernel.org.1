Return-Path: <netdev+bounces-68041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83377845B0A
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 16:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398D428FAFD
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 15:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E5A6214C;
	Thu,  1 Feb 2024 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="sKJXDq10"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2154.outbound.protection.outlook.com [40.92.63.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC1A62141
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800471; cv=fail; b=ppCa0hOXmYh8qnBHXQ8XdJUogqPxIHQgaDKDIJqiGdujKO20I4oqhD3Hl2ozS3Nd3KS+6EhI5V3fGDNA2Ys5gAcgxkE6xS6XJHZRkto6rD8bsoNiEIIwPjM5dU0BcQ7FCq3kM1sOpdNlApVrUWaasqOJt+b0iX37Z0iiDPS+O9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800471; c=relaxed/simple;
	bh=tSTVT5JifVBrYIYpdQDhEIto5sAGhU3PSPIfxLwlK4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r4bLzQOx2TZxfwXz3DPwTrNxar0qu64LbdiA1fJPpQzPjYXrPTPMsO+IIApC5DoBnzS5hz1k7QujWc0atguwUN5oyPcY5aJwxyoQ1rFv+3gMs29XM0QS+zMEfZ0Z0cvWqE9pGmPmh39Heb39K7dFnydGVVTY5k0dplNDiwooGN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=sKJXDq10; arc=fail smtp.client-ip=40.92.63.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAj+Us8XRYXBpYGbij1LwKy514D15iC2pB5Zn/dQtq6nvLyM6OOdbsK4AoF8IMHbEAf1Ik+TJONLWJq9DsltDuemzoQuqflHQx0JIRxouo4XlBHXNVn+GwrA0Idfgzig+LUg0ICEQBI70mmtIL2JDbbuDfve8WXofbSv4RBh3g0hV+b/6qkR60HESBPQ0SkzstP1bzaFqgjww5S2sTc8ZulO7QGgQ/FrGymXOy/fJkLfCUXIndCFwyurrtNG6ptITUJJz6xr8bbQSaYLNm1kNUzO6fFfYDd78iXpN4PonU0nDgDYbpukf7MT9VY5GXdnPDQLBS6kb7xRYIPqbUHsBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaYveMkzatic5z7fVTtAMe7sAZamFbpD5ScLU6zNXro=;
 b=ApVR3UJ+4wKQtKTkwyIZaqUQsAlb3zm316HDFHfaGik1YWyW5885beqD8WS/3+4KsvfubRf9rN/+6J/LNAsaNTiOzvGHU2FMoOqdmW1HNk2vt1bura6lSOoTcuh04OJyBC2KIiSQUd4KzlFsZtkbw7Tr5p7HAcWdrHkNXe3YOV1jxggwVMT9zJ5Stg5e/eYSeuTp+/jfTauTtV368xt0aqC4uLlM12/ADOtAHwpAby2O8ATRHz40huSgnx8w6LQ9l94PnSzdBRyc/ikedGh4sXStewLxbcv1sm4ssaPBPoQNcI10W7r2mP6+YgcDhjNWKHuj5DrYWjemlfLvcEHRAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaYveMkzatic5z7fVTtAMe7sAZamFbpD5ScLU6zNXro=;
 b=sKJXDq10vagg9XnaKq9Ze2hj+zGwQHljVQtX5fB/DPbRIoFy9agUkHix3I+En+YioJz5MtEEY/gZkVJni0JbJekeeAu41oRMkQlBrF9mFgTUvueJsd5JeU5OIrUDQFRhx7BI0D9gHmnBrkN+ZBCW/pGX5hIRVM6/ssxiw1+vmbg+QMW/sMwJ4MbwKrnXWV6RBIZtHn/OyYvrsZ5kxo7HqI60f3QszIDYc5i/HW/lK4wVCX1zsDaVMX0sKMfUWimv/WypAAhpkY61b9fYN08yUlKzm7Zw0MFZvneAjz5XGozlGw/ThdWvFnQEOAZcA81guVhWnIjTlXl8u8i1ZTRwgg==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by ME4P282MB1224.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:9a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Thu, 1 Feb
 2024 15:14:21 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f%4]) with mapi id 15.20.7249.025; Thu, 1 Feb 2024
 15:14:21 +0000
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
Subject: [net-next v7 1/4] wwan: core: Add WWAN fastboot port type
Date: Thu,  1 Feb 2024 23:13:37 +0800
Message-ID:
 <MEYP282MB26974E5246FC234A77EC63A6BB432@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201151340.4963-1-songjinjian@hotmail.com>
References: <20240201151340.4963-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [/XwZLXV6YlwgrSkTbGI7T/Tf2APbo5iV]
X-ClientProxiedBy: TY2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:404:f6::16) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20240201151340.4963-2-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|ME4P282MB1224:EE_
X-MS-Office365-Filtering-Correlation-Id: 82051ce1-93e2-455b-0585-08dc2338774f
X-MS-Exchange-SLBlob-MailProps:
	dx7TrgQSB6freGFPHZ3GjGHLcCLCqTPftMoxoG8hQ4WW6PnidUL+inuVI/aZjcql/5PM9L1xiv5AbOrP2o+0dVRHSiurh50f0VftOY9VHPx8ahsuT6BPDLlMgfgt6JyDOo3hvylp4VeJ9pphROD93fd23SagKWWIQVgpGzg39KAA3iqtfc5Rs8qdM4voQWwhE7vSBjnlORCDKQCKdPh1BOcNHGEUk8J29NPP1ynEMOFK4fThMZyXSrhgSglGBuS22N1fvc53Jy1qvR+BSV1w3VBpPTai7SfNPhnYWdv/nt/Cask/dnuiGPjbgOQnSY9syCCeGvnhfb/1UBB2sRfFbtVj3SDSNpw/EiJi7ZWJvpIzhx9Om3M2gA0z5NshncI3n/VOGt4wLCK9ITEClmAWgtiK4C2h9DpqEVJNsbxKiS2ekjGztDIZUEw3WeKqb+EBgrQnGzO540I4Uzg715OFegGuO9fyZgFclKEzS2FWHC828Df4n9JsC/X8TbdDuiSa3z2QAAWMzBYqSiDxWKsuYYT4m0/Welr4dVJAlBJb1MbPhVG7gGvNlA3A0bZvgeAndcZfxThU+V/JwyClBnQ/ceBtPkM9cXk4pd9sWZp52rgZuzqBnPA7o6VzkwXfXoiufo/HmPU+Uz4prFU04oYnWA9iK0DFjtgHnqhYzQ2Y/zd0La8q/bPWNoktsT9ap5FT1wYotmoSDYQ1D/q7BxRuN+yRzTtEwDPeK4FZ1STrmQkWNjnqNZ6ocXifOlcFrwvAHC9PdUubANw=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ArvNYIL/+4IWhK8x9uWHFm31wOeMz13Tni3tMRlHLIHZ9cX/enm3H2+qiNzuO0k5hPqPWbAm4U8msIYcOt9aVUwKX0aewL02A5EnNz2KhVE4gG4MJrZmvaawx0mH1cPEZFDhXn6jPzP0fTDq5MnD+u1xhXjeMvpddnz6eeehoTFn68zXfNYg7kUFRXQJFHhJot98kSwUc5+owdExmXd/JiWLKf9iAxzCV2UPev5Jli+wDjhadLFPzIcXtL93y7eUL1smvfIvpIjZ/sheD+Q66+U3oxh8OHDMW9lKyx/i1ZbSnc2vU5SQ7DdWztzlaxfumztIJx/rNT7FSJ331n+h4RBopP3vh/mbcCeeuCzGTY+CZ8hzw8oLWqi/TDEC6YltH51f9aJk2Fv9ibmKHWVdY5FIgHORykO19vMtpmUf6SH+oCxGUZVUIi7C+/vg/9g9SEjqWGdTjKv1tD/nosefwa6/gLgjFdkNv/T+fmu6MdHFHPOrr4McvcfDdo4J9y1mq6mVmTM24gSyPqVRpusAPRJxolo/VE/EOriqbD9fnq3jBGYHq0WUh4SemdhRRdeO
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4JHlZ7h9Ib1ETFmaZ8ZOtz58kz5JOjyr8EXDw9RbKN/veXFECFfcezWidg7q?=
 =?us-ascii?Q?oKCJSBahE7AYgi20n1y4PR0rBaLR1rs9yTX4yxd/I6BOmuKn5XlkoYEEG5mP?=
 =?us-ascii?Q?Wt37/8HsqWgmeWYqTnyCcAFXPK5duhP2o6BXNLTFe67weybwI1B+MxUdJiE4?=
 =?us-ascii?Q?Z4DTGdBBqLZ0trZ19B7jkS8n+raTcqhniFtxx1AvornTmtDDvKrU5rM4sqaZ?=
 =?us-ascii?Q?eYXRkXaqBtd1sEQJd2o71weeo1xFAzFPeS2Q2bqiIsAsQ7qeUPJ8qxGqVoJF?=
 =?us-ascii?Q?09aVGpoWZRIboRz7I5qFQLpiC8UmyKkaV8sJA2uJy3BunRvLFS43k2BK3jz+?=
 =?us-ascii?Q?nJo+fG0M6ZhIiTyS7ktBbJ0+bLPabf0ArAOOAlSEE3xvJjzj9dk0syDx3l3f?=
 =?us-ascii?Q?dPEq/ThDwPsSHkxrD4jHEEV+4X3oRbkxAtAwmgIaLjvYNWVpkXJbDZiYrs21?=
 =?us-ascii?Q?YZfbCmeW3eAjmpz1YETGvj3SDmpq7xZyuQiBB+AFUENVWR59sHZna9x4sUim?=
 =?us-ascii?Q?VACr1WxJQ9+Jeqv37z4BFq6G38A4B/ChTRNCu1XGRUkArdB6uMcDo3IHR2la?=
 =?us-ascii?Q?9ek2oIu6Ma/4IwVsp0iiYNlEIrFUeuTBznCvpzkKp0al2zxsoD8BPx/i9Tqs?=
 =?us-ascii?Q?XAsFI1R5SiqmaVt58zl/OMJeboM/g0vKZFdJ60aP8xnd+nv6Q3X25mYqJvL3?=
 =?us-ascii?Q?erU9+yKQXJ1Duf3d3i2R1HU37C+AjyyTukxRXnEPD+9idW18XDgui6OWQMUc?=
 =?us-ascii?Q?MfIZ2FBfReWpX5qlp1P1hOPLcfoMtldMFbLEAM509XAQM59mfGIOzXmLjX5/?=
 =?us-ascii?Q?JK9fQ9cZn9HxzgepjyLQ7qDSlSogvYuCun2kvXl3lTq5/cP8gsqZBiKq6wlJ?=
 =?us-ascii?Q?LIHDPbVhZO7qP+8Pl5YtBgdskJXM8xrmY0TZsO5LpUtBmzKMwxhGGYHZ6a0Y?=
 =?us-ascii?Q?3biXadJdib9D6+e/kJ+8L9H2YI/hf5rPycw3mD0KciVkjh8XeoUGp34x+Efp?=
 =?us-ascii?Q?o+qSlP67iMf+woal3L7aOWDeypP1ENFizC2MBy/iSY1DYrS3gkqqJsDom/NU?=
 =?us-ascii?Q?j1KWilJ+tD/wtYVErS3DLSSupwS9tUiM+CL9sptEYZmFtc7SSVpGbdkDjQlJ?=
 =?us-ascii?Q?D9jwWouG9JazuV2uN4RWhgCP4noZOoY3RfZvFiAOzS/0db0OU960ImMgS9IT?=
 =?us-ascii?Q?kgdeYzUkxm9U13Ouhw/WA4zF1fWFWNg1wtc2YP5gfhlw89/V8N0p04NJFsg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 82051ce1-93e2-455b-0585-08dc2338774f
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 15:14:21.1912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME4P282MB1224

From: Jinjian Song <jinjian.song@fibocom.com>

Add a new WWAN port that connects to the device fastboot protocol
interface.

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
v2-v7:
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


