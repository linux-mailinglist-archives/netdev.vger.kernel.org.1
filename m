Return-Path: <netdev+bounces-81265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 431CA886C42
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 13:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66BE71C22196
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 12:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2223FB85;
	Fri, 22 Mar 2024 12:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="kbZQg2Mj"
X-Original-To: netdev@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2064.outbound.protection.outlook.com [40.92.103.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C55F4176D
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 12:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711111187; cv=fail; b=BN5DCRarBOrIGSoGa6ficjBgu2xLr+QzIp45Yn0sZm7+QvGPE3bK2aQvRQ0VVaSR5z4FBlHCaSL3/BPb29/shDzllHbtPH5tPl5CZPqaJfSaiKGClygc4Ecg1w6og+dT1ydiDZmS/qIfHOtofKLgShjZFrHp4owtMYNc4mHE3ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711111187; c=relaxed/simple;
	bh=rqVDVeVXwnt4m3SKsUtkQKCcSoTMJmjF523xVt4yRgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XgujJrhzQxRByKYBGKbv+T0ldRni3spEgSncYe91jzgIyTu2mJ/7LEKLD+dP+QWB0But2CVN3Sl9cQZccLtsHOWBrDCnxWvC+E5M02PdUtn1pjxKBdami/+oIDwPHUB8OpcD+rv1aiqTP7UZyjsuqOOJ2aVX/AkJsdx7ti1lH/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=kbZQg2Mj; arc=fail smtp.client-ip=40.92.103.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Svybse9Kq5taOK8J9c1PTjN8uVrPGDz3c8wZF2x5Fb9LxD50m8Ji0quuTyvIbQxPJQX9JTGBuyYw7VfhnjCetaVWH4Q0bRsQeJV3KkfgrjRWVXkUCmMtZpUv1UVXQMAo0Abu0sKHPdKr7KSudV/N4twpK+UXlD7onP2WAG/1A8PeuUDsO047hwoGP8eonuvd3shzf4KGNtzDqbZKIESYsXLvN6sAuoAFuBojszPtKFWfe0+5PGHEtrHhD+H3s2OthCQCEZ2gmlkFmwCdt+OGchmXn6edQsVcbwJHSnkckAocAJ7k5EoSVT6l7YWVcL6Tyxq8NGXhlMnm4JbonG1HIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qD4wfgvCq6QhPkiX0yJxaYFYOKl1N2n5Qr3l9JsldPI=;
 b=YIorM2ectt1z4z1L+n4PuwMmTM0ambOqoAZlwz01waIngceUIBaz5q9u1r29UorNZwjemSf4xRJb1RlZV58sfDoVuTPuVDzdqZb21vZPR+VXh0PMjo1tlLfd0crk3aMxTSI7WOrY10sqYTdCTnp/OKi+pAZtizorhjFWbxL4cOTqDxOM95WD3pJ9QcncrDiX5zBYuYjrpeWZraidMndEcxg70ywV1Eq9zUVxsI5uLTRYk05kmuv0fOLK+7Xe4DHk9iW0EiBz9bcAtyMQVd3fnikr/OcVYrisdEZPOQelr9E4TKnnyVj1wQhySaCZH117Njf4XM71cOjcQyHLidyo2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qD4wfgvCq6QhPkiX0yJxaYFYOKl1N2n5Qr3l9JsldPI=;
 b=kbZQg2MjhnBi+grTbNZRCBSiaaLxBRuQgW2FUT9tO4X7sydrHnul2yesWCs4hcZCbmPX/gAZfXTPiH8YYH7um66+udn3rbSuZi4AevbfdT+jqulyZNC/ev1vZ5ukDrjehmvKVUdWizWNBc/w6Z/tVA2hpoqbHyzHQlGviaEb1+0cGjCDzGFTMU4DXGBCnzZJkyizffwGd/uWxKp1jl/Kzp4ttwdQs4HCFRqu/Cl98ywmIAXEUq+VDBx75WF9rHlCOATaZ8TaT0xmXXlvJLs5JaJHpQyrQr+qs6882EJCio54b4T0eBMDiNl36wPOWP7/tBMdXsWlKA0hF4jUYG5crg==
Received: from MAZP287MB0503.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:d3::8) by
 MA0P287MB0832.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:e0::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.35; Fri, 22 Mar 2024 12:39:38 +0000
Received: from MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
 ([fe80::be9c:e08:2db4:9a60]) by MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
 ([fe80::be9c:e08:2db4:9a60%3]) with mapi id 15.20.7409.010; Fri, 22 Mar 2024
 12:39:37 +0000
From: Date Huang <tjjh89017@hotmail.com>
To: roopa@nvidia.com,
	razor@blackwall.org,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	bridge@lists.linux-foundation.org,
	tjjh89017@hotmail.com
Subject: [PATCH iproute2-next v2 1/2] bridge: vlan: fix compressvlans usage
Date: Fri, 22 Mar 2024 20:39:22 +0800
Message-ID:
 <MAZP287MB05030EB14BE2BDAC9E1DB01EE4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322123923.16346-1-tjjh89017@hotmail.com>
References: <20240322123923.16346-1-tjjh89017@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [aMccO9pTiwhr1wJPmjlhbYrpr0xWtvZFHN9S4nvtsAlIME41gyv99fCLxJjOkDfz]
X-ClientProxiedBy: TYCPR01CA0054.jpnprd01.prod.outlook.com
 (2603:1096:405:2::18) To MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d3::8)
X-Microsoft-Original-Message-ID:
 <20240322123923.16346-2-tjjh89017@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAZP287MB0503:EE_|MA0P287MB0832:EE_
X-MS-Office365-Filtering-Correlation-Id: dc5e4bc9-d0f7-448a-4870-08dc4a6d225d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HewO6QtttOcZ0Qnau1TMQdep1xAHll4PAuj9U/MNVNIS5D4lgIi1wXbKG/dMvjjLK4QtmZV8c9oEmoE241lh+klPq9/xvaFKE3feWKTlcv8FNhIFiG+LKzUwNLLHxHDimiPQ+85OB4cHPOB/dRXsVJXt8PCk2omcZblhX6U/TGqCChWRYnnfh+6hFxFkdg9/1ZUrKtrJ4bBtIVPySjID9vXnZ9U5pJ/bJ6FzUdH6nz/msWB1og1eBZK8iW3GKIflOY0Ywy33btLMdl5E+f0gws3kbO6FpT8+vTXwY4CyA/9SCZ0LUya+Ho10awJwOxOFX2a7aDXXY0M1Ke0mbVOkijS3L9KjiQx7M+FgB0QRzoo3WrlhpI5z3OZlbYPa7a+3xz+KWRkTHZFT4rLknlloBb4t+AbAYCqUAvrnS7+aRviK6Y3A05ueduFrVFBl55ITMqrHC3TUaDu/WyI8NUvfXdqVV+JUv+8zNUd0whRBMXZBV8HN6heDmEGnTdz5QzIvUNWyZF/aWyxoMBerWLwDpb5Fh3kaVo6Jn3A++9EvxL1X8d9IrRGnReuxP39HIcQ84UFyVdOq7aKjEeDtYSy4tRcFWl/sZBBjrtTeyUbM057LoxxQOlWM0diJpsGalivT
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e2FXGVE4oNnzZg8oAqQjiaCI+Ria21GRAISByYEiYQ5JdeZCA7oTUDkmgaRq?=
 =?us-ascii?Q?PYAWH6yCkxBhCFMeOACzrXImNCnLGZy16UppX9nO8e2g4DJ61KT8Yq2A12bB?=
 =?us-ascii?Q?uwQ25LkI+wBUZK6y7jsuTuEsmaJkbXG6cVtg0dKCTpnpy57YEzRJcnG0QV22?=
 =?us-ascii?Q?SnyS+tCnpxuOi1R4AKdehEoZ1dX+8NMUlU1j+rxR+VwD4aWCFIMLCL7GUOcc?=
 =?us-ascii?Q?tsMNvC9uEf/LRT1uImdEWdyfSEIhPORIs4wv2a2XkctLjFpeoHlGUNNuEU3q?=
 =?us-ascii?Q?3eoHe/jfLtPdwztE0kVpw+kScGWSo2bToPP12FFBYCpVM03MkaoxNxA9cvJv?=
 =?us-ascii?Q?wzrIUFKARosMmSp3wU7CXlUxl7sXyYMnFLGgOwWGopEb3paBbzRJa5ASSaTn?=
 =?us-ascii?Q?sRChBHcPRAcyLaS3//4YgTm6Id1zdIdtt5bFWLODy3rMOtznV4YV7odtjt1F?=
 =?us-ascii?Q?+BlrLMRwqT0AjsN1eIEvnN/mCA1h5gP4TLbkvOn97WCoJ66o47U1Rr5VDjq1?=
 =?us-ascii?Q?lqXGzVMs6Q7IBv1ZpEqRd5D68IZ+IX59pPGIDN7WeHzPmapuXc9vq++L7L8p?=
 =?us-ascii?Q?YJijexxjXssln8yxd511DDaHFfKiOAQStN40A+9AD8hNBpoX+CeeAeEVCaaH?=
 =?us-ascii?Q?tqCV5j+fDYp67BgvLh6iy6Yb17pOvH+T0UXnTJvmsu046UZgVasifx+uW7OX?=
 =?us-ascii?Q?BLxIKiWYA2vUx6eDlh1Z3RU4tke/H2CQhq+BgGKPMdSW9zf+qagCXtDRhaZh?=
 =?us-ascii?Q?DB/c/v/ckV5Y2FLsCnKaD9OSe3Lb8Pis9en/V25qxVTEMSAHykrYrqJwRlHs?=
 =?us-ascii?Q?nC44YO80UW0CpD5WG01DPzUGNl47q5OcroM9bIjLfgWVVPaKLNhmBFQ0qed2?=
 =?us-ascii?Q?v2mtDP1AqqILexl4xIS13DxUYd7o+PK+pP7HtZHBvoHc1xEZIQSMFZqb35z+?=
 =?us-ascii?Q?ZAYJRwLxjzEghp5+yEMuLQx/UJ0vBi1AC0MdTNswGSYA+WAYc6nv2povYpMO?=
 =?us-ascii?Q?+CilRhu5aV+ajzSXoc9VM7OupBUikkK33E5lRx7sqq3fER/UMA5GNqOOIo1e?=
 =?us-ascii?Q?eDeKtjjSD7aLf1rJNYplxDX/I+8wVK3js0wB5FbCogQ8c7jlz7NEn1SDgxVv?=
 =?us-ascii?Q?DjMPtfdNlAPXoFhTW8v52Xyzbwp5+An8U3qRmZx1yJLnQX4rr3J2FTMjhimH?=
 =?us-ascii?Q?URdWVUfgMvkAo5XJ9V/JBaq/2dXbjlo6HajS9BBESYoUefPNn9v4Pu0JxCxe?=
 =?us-ascii?Q?l1RMvUg6HDUyQJ0NoNVHFjAzp0izXxRHd9M9e6vNogfY7f9YiUxSuRThLWKL?=
 =?us-ascii?Q?uOY=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bafef.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5e4bc9-d0f7-448a-4870-08dc4a6d225d
X-MS-Exchange-CrossTenant-AuthSource: MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 12:39:37.1997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0832

Fix the incorrect short opt for compressvlans and color
in usage

Signed-off-by: Date Huang <tjjh89017@hotmail.com>
---
 bridge/bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bridge/bridge.c b/bridge/bridge.c
index f4805092..ef592815 100644
--- a/bridge/bridge.c
+++ b/bridge/bridge.c
@@ -39,7 +39,7 @@ static void usage(void)
 "where  OBJECT := { link | fdb | mdb | vlan | vni | monitor }\n"
 "       OPTIONS := { -V[ersion] | -s[tatistics] | -d[etails] |\n"
 "                    -o[neline] | -t[imestamp] | -n[etns] name |\n"
-"                    -c[ompressvlans] -color -p[retty] -j[son] }\n");
+"                    -com[pressvlans] -c[olor] -p[retty] -j[son] }\n");
 	exit(-1);
 }
 
-- 
2.34.1


