Return-Path: <netdev+bounces-171146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF491A4BB39
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EC35188A14B
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9F31F1313;
	Mon,  3 Mar 2025 09:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="keDWlX1P"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2052.outbound.protection.outlook.com [40.107.212.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0137A1F0E3E
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995616; cv=fail; b=DmFI1eTPpPZDl7XWjHxv7j1cJvMmeTDqTi6j89R/BYTQXGY/OL8UsatLL82rmz/Fb0F111mFJkIAjOR6A00Da3iE1qw8s1ZUin8IPvl+34JYDpPWPe9twEgD5+GpgJgl6ECAVQsJplhGlc68uJTzAoh4IakKHXSaE+hCydhH6fU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995616; c=relaxed/simple;
	bh=a6D7k1zJATV/QfGGiBBL61iRAo0l9DhNMmHRNMzjO+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OoVB3CD6c+7mI665rHbjdgumZAboAH69/O6I+HDEv9n1wYMN7bJ983VFf+GugC3N/3gNzjmOnTnl95YppX+yg3m8mxXMe968AU5k7xverHSvKfepHOg84XdOQSdLZArdG12Iy4jf8bQZnkYbKVcOZAtDro35n6m+Ma1wK6L0KtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=keDWlX1P; arc=fail smtp.client-ip=40.107.212.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SR+l8Rdy200Skh34ELTKkZzBXrrpg7IUfa6UCEn5kegDHaNKYZ4ct+xmmBg8ys/wfJSZk3TDbTqfJ0XWXI8mAQntp8ErJiO8QAMfeGtTaosXfMsoRNzGSwVpZB2LgRO7eFnWOGj9gz6DI9l9swdY5cHNblYv++PmOKJ/UlgRwM2rLiKkmx2E+z2VQucz8vAvcfLZw1NcyrbKcwGPrPs+XmuIxdNmO9E8lB1SQIOWOoW0XSCaGMEx1rWPw0Bsup/VEWdDju5nfl9yACUre2qiJzmRWIgZfvcFcm/0JDyiK7gGFl6Su+aD2XIMK+7V4xCEy6GRJA0zXT8PFbnsd/ZHzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mB4ZqVADYwmoooI46OVXo5ISIlo6f2T7ljtMKnXChpk=;
 b=NkS4AGTOtjOpcbv1fNhuVk3snQIed1qpXZ9bWn0lZIqpHZS+SWFW+060l7UGamGODRRzhkNGT1RaKs3/SVrgU7VPASknaRaULokCnC2AbsxoCqYELeWdDK6CSZEtKKxY6k+rvFt0QN2rQwRQRVit3NULn5EM2em4m+PSHphw7ZXpIDRG4DzfrIotOJjjHIBNYEWXxevw7tnvWEqTOmIAZzd+V6JsWM2dDJmpAxJAXh/K4QiFsPe5XsaEABAgUK+eEgOuMZx4lgujmJGS3kxSxEYZ51UndxyaGD3BFN4H5YbUEjmrXuL9ZTGs0sXcWj7qOpBdwakWQtUWy8EW0Q23CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mB4ZqVADYwmoooI46OVXo5ISIlo6f2T7ljtMKnXChpk=;
 b=keDWlX1PT/3Gaw0+VoyMygckICuynOh4dRjImOa19IMLHQeuFJFUe13N2cTMpE5bJmezNEQMcfHcZcXebqm5i6nczjX4eQZtInN7lUETrIMdyxI5riA7c59FlnK+ZMpUsnVmu43402XfpN33/hQmEjXXg8GtMQ5N8PmlsxMvRpcUZFacgl8PTJcF6PIMXdVI+8faPWWQG5I6BPLu8TVuXcDGVF84ymN72H4LuVjZ7xFMRzu67JcS6mTW9jkK6gPDn/6PC3qA8kDEOCTCKpEheknMza932dLkVD2DwG4MPqOcX2dHZS1Da6H0ZGeHmsjn6p/2LbBQYW05y0QeJiqrVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.25; Mon, 3 Mar
 2025 09:53:31 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 09:53:31 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com,
	viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org
Subject: [PATCH v27 03/20] iov_iter: skip copy if src == dst for direct data placement
Date: Mon,  3 Mar 2025 09:52:47 +0000
Message-Id: <20250303095304.1534-4-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303095304.1534-1-aaptel@nvidia.com>
References: <20250303095304.1534-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0533.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::18) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: acbefb5c-737b-4f29-9940-08dd5a394171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NjmP2N+JMhSe0Zc1seNIUJobjHpmO8SwT2SsI69qF/0Cif2nTHtYgROB08ub?=
 =?us-ascii?Q?J9PODpodb6UKdHewOKgguFtJijhYMolqyYdsA8tLsJ6s+VZkfO60+5FcmCQn?=
 =?us-ascii?Q?fF71XoATQEGOwJ1zl8yMOzgNJefq+H9voJXW12fpgXzpaq3NSJqRUrgCw4oh?=
 =?us-ascii?Q?oqnlo34D6gpGt2bTp9waVwRsRhWviKVakqGSd/RLYzdTfHLRoUTa0Oi4NI9Q?=
 =?us-ascii?Q?ytaRCSNMP3KHnQSrw5qzWS14YWhjrGqbvJ3lkfMJeWMugRQWao50i7GSTgpj?=
 =?us-ascii?Q?m/bjymdkZ/CAzG4uGszEKOv0TDx5NPPJhGhLDeT1v7LmCBeU2OvSzg7fGX3u?=
 =?us-ascii?Q?iWt7aZhJ371Q3eLbVSmVMk7ui79kI7OJ2DCGWEeoCmjxxRYyeIY7w1hpePDk?=
 =?us-ascii?Q?J4UxhBblVydE0CVtg3X5PRviIpnhEdnYmgezlp0k1/McXjFaFl3ba6WR/aoq?=
 =?us-ascii?Q?ov+GNBssyZciDV6hI1SHQgqs28A+zoQLTTohdXk5DffEEiArlDbbCF4A9rSw?=
 =?us-ascii?Q?TxkImaz5BNK6oBUzeHjvSe8PvJg8jK829OY+RWnMfrk9i2nBCfp3B5XDj6nz?=
 =?us-ascii?Q?a4vDRT+lGGv+tzeGQLUcLu8KZKl10lM2IzUX+hBncxT7FANTToR0BM77hHoz?=
 =?us-ascii?Q?B2RYGw3FS9El1tP6HZKBIYPGy3KNNg1hk42tIwnhl/XhwmDLBXicyMl0+I0k?=
 =?us-ascii?Q?AIooqtl+0diYhE/H/zMehiuMlOs/oqDuTRzcHHzvlQVOwDnKFQ5YfNLasR5i?=
 =?us-ascii?Q?xuwLuM54/7ebCwVlLj3w9tjZNX6+lV1tj4FH1Qn09GOd1l7Hm+iElkHQxE+k?=
 =?us-ascii?Q?/cvJG/D0SvqrzsNbHVKqHnp3LTm0fCNALyrY+uecbAC20J8BLmJOffnVIAg2?=
 =?us-ascii?Q?EC38K2Ve8nzrCpKIDXuLlDf1VD5No0VUlTM8+U6U4zwltnvx/U6hN+sMvnMG?=
 =?us-ascii?Q?ZtjSArgvhuUg1tQkfPea6hgozwKhABehVhYyGLoKamxkujlwfMRo1rPnFlI0?=
 =?us-ascii?Q?dkL74VWdOsSbep82Rwgh2NHwtjJ0MXg8u2uXjn33BcDmPV8k7XhzF5xcO3XW?=
 =?us-ascii?Q?iKavS9pdu0Fc7nMbNpwHbFByStpNuokGS4yd8OkSgAUdDmfYtzFOdS+3w0Zw?=
 =?us-ascii?Q?1tuwgR/bHUgNn6KZQ3jgLkXCCp1dFC0dtw5pQgsn8zQ6WxU+sbFkjDwQzJ/E?=
 =?us-ascii?Q?MWZVN1GNF2FRQXaihzml5qCg5pEghYEi5jyi4E7ZoRZOVbO6HLzOVoKzOnll?=
 =?us-ascii?Q?Aw/R40T73YHUrqMgwvBTxWRpzFupIiUNFDv1xUAsKahLF4dR291UOP14HDtL?=
 =?us-ascii?Q?bl3kZU6VPqKf7YFJ+HxFnB3Gqj1AqEuBON6/YIiBeh89OQ7GxwaCfY44p9Yp?=
 =?us-ascii?Q?zbAqa1pxA/Rb8tCZEZAuOU9sKbbu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NKmZ4VXiAAzlspGp2UjElydF4CstPos/gvysKYweQQL6J2C4jpxo+5HA/qi9?=
 =?us-ascii?Q?2vraV/W2Oa7306OOuLYmGbR6/H8RMbfSlDWsYrYCybG5wKqIBYdCZXmPhS+F?=
 =?us-ascii?Q?G2qH3xwpUwrvdiWES6PYE+lVV9BxQduDHlroVXFaAQ8Ju5ZcGlnk+dFjP2wR?=
 =?us-ascii?Q?DBHYPpu3NDYO6xNiR9jtlqFD2K8DaLX9emHDgYKlSYZW7mh8LSbRGiDu7e3L?=
 =?us-ascii?Q?mtNR0IvvYJCzXP82w+LzyRzvuiLpaLdyZ2dzp5AVyQTQIOluiODxlurHl82b?=
 =?us-ascii?Q?Gew57R4okmGZ/grv6VJINrhspXIq2IYg8unpK1S+Wto+aMuEiym4o/8NetAg?=
 =?us-ascii?Q?qY8Ip0bLf8JxDXkhXA25C+keDd27nhCkLvaGfODlTTOGxY6gmDbAHD7xri6z?=
 =?us-ascii?Q?vUO74hutkpOUHJNRf9Jt4Zpa7AS3OVnt4f8g4lF4C2L9egqI6hi/0Vr10YbP?=
 =?us-ascii?Q?EHlyfTenW8R760s/odLQnLT55czDQIpP3drV2RRY+rCPcgywUxl5mHNW76Wi?=
 =?us-ascii?Q?7NsHGAVF53f5/j3/cdr1ped3gl6zn52pOKb5ZpmyR8t6gVpASrYGA8R2W7rI?=
 =?us-ascii?Q?BSXw3MbsoG9Zn86Jk2tn0weewbGVw2tBKDa5VeDGR0R32v2tcm7yYFUaRslu?=
 =?us-ascii?Q?19jgTqv82ss6QWIW9PB+svZNiUshbYWL2gwTBk6rZWE+vjZ5FGisq36Ezx6/?=
 =?us-ascii?Q?Wc4YCbI1hl86TgIhs7x6unuwWILD1xiaqo5ytkuGDKaA7QOOhSSmKlLyL13r?=
 =?us-ascii?Q?yV6UTwm9Kpv7Ee3DSwX1O1SnCUKi5AtM72cOLWv0Z9G1Z+IA3/LZrQ0Ye2hr?=
 =?us-ascii?Q?MHXW8QsbQ5ngqJ1GGKzY64y1POFldGpUCER2QUTJEPO8yGa6t4I98A03RW+8?=
 =?us-ascii?Q?l/e/w1Y48EUkcSgjBtVKQuFbr1XArgLs65TcbRs7rlHacQPA/zzepP8fb7NK?=
 =?us-ascii?Q?JHE+/NrXNvsG88q7/58v2x6h+tPlQ97iDML+IOCF4Fi0TxU2r4k03d5PoPNA?=
 =?us-ascii?Q?FEwViibxRtTcDQ5P0i79Hjy5ZOsdu4bd5cRksMx2xIa0ckCMOYOa38svaPC2?=
 =?us-ascii?Q?kIUob6nu8PxpsCgp9rhxAao6GwmOhrZ/noDKVQv6IQkFBJWx06zY0OQ2FIJ0?=
 =?us-ascii?Q?eBKDYkbjb1wmwX4Dn+LnibqDz5WKvB/uvgzawVo+v+xniOrcYPDrMo/EogMU?=
 =?us-ascii?Q?n6TzYHcz/EL7X5djnYCKRiM6unAaTlxRrXl/jUNbZNK/jP2prrs3ZysV/gz0?=
 =?us-ascii?Q?V/Cw/SWhy9NU7BJr6/Uo7xa5bLJO0dtnAYOdMuLnzQbgdSWiyusvAXUkDp9K?=
 =?us-ascii?Q?5rGuD5qOFO0s7EXRvUmIZtqjMX3ydM93rwmPmQ7a/4M3y97NfVNUaKdBTjRU?=
 =?us-ascii?Q?AV4qsSkiISapajuU6mzumjAL4P9cmoqO/HJNpZyLdsCOyKBIF5SiTgnTvoKW?=
 =?us-ascii?Q?RfijgZ9G76xm2mK17qCwt7qktc1iaXHAk4VBt1tTTHQS+xaIhHe8rSmsmLNh?=
 =?us-ascii?Q?D8puMjCwLqcC8NigyA+R5zeznswulADfVBEzj3ATii0rgTlVBVOGKWgwcAIP?=
 =?us-ascii?Q?phgeY7VuE1t9vrvJKCcL3ZR7hH9PrOfOPP7h1jtT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acbefb5c-737b-4f29-9940-08dd5a394171
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 09:53:31.5756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gj89Y91cRo36PRkOZFbyDTq6sGVVLQK6U4KSUvSBtOXrMscHu1+o1Y1n9D8awLj5pIzLbyeKoBEstvXpjWdDug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994

From: Ben Ben-Ishay <benishay@nvidia.com>

When using direct data placement (DDP) the NIC could write the payload
directly into the destination buffer and constructs SKBs such that
they point to this data. To skip copies when SKB data already resides
in the destination buffer we check if (src == dst), and skip the copy
when it's true.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 lib/iov_iter.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 65f550cb5081..94caddc02515 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -62,7 +62,14 @@ static __always_inline
 size_t memcpy_to_iter(void *iter_to, size_t progress,
 		      size_t len, void *from, void *priv2)
 {
-	memcpy(iter_to, from + progress, len);
+	/*
+	 * When using direct data placement (DDP) the hardware writes
+	 * data directly to the destination buffer, and constructs
+	 * IOVs such that they point to this data.
+	 * Thus, when the src == dst we skip the memcpy.
+	 */
+	if (!(IS_ENABLED(CONFIG_ULP_DDP) && iter_to == from + progress))
+		memcpy(iter_to, from + progress, len);
 	return 0;
 }
 
-- 
2.34.1


