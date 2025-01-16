Return-Path: <netdev+bounces-158923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1F8A13CF9
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 15:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C515616ADA4
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 14:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1715522A81F;
	Thu, 16 Jan 2025 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gkjvuX7G"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03olkn2017.outbound.protection.outlook.com [40.92.57.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F1519ABD1;
	Thu, 16 Jan 2025 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.57.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737039353; cv=fail; b=iFFW9TxcQrcYQzSwWeUGP+PcyKRG+rrtOVvx1diT2wIt6Hz+9NRFu1G1kRnp9yGAWMq9nCTZmItQb4lXJJA4cYoPesAMJjjY/NzMALwxd4BkMpBDMsQaIjdBPJWZkLK0FUdDFPaXbpKAnQWIQixfZ4g57D2iMSkgzxajBzG+BIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737039353; c=relaxed/simple;
	bh=4eUiS8209xQ1LSdr0vlryWNKLq+L/Fqgj8rG4MbldWk=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=iRmO1AZcO+MO/X7o3SNVurCVs26ehNgXdqHs6eCls6USwqROhy4rh/ZrAfMzQNaQIISmKpvGp4tZhYGnKu35IFCTUBDkE6er+SwR9wOdRC7U3FGYN5FSOzYYOXVZjmxLfgcJlPtgLQ9+mSBWQS2GoMIFaR7D1kSrUrEauYfs3+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gkjvuX7G; arc=fail smtp.client-ip=40.92.57.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pn1tJOTVnTOLDAEkWk/JrQOiQvVhTJzzlH+w/+Tf39YewOfMuKWarqXN01qjMmE8c2EI5HoHbH7oMBZr4XOZ1GY59YpMOiuJE1kXd4kp0ScnhOpQAFcdTsHxdb046FpktBNPDHAZoPVocU71C9iOJMTgqriEM3y2TrRFVnaqja76RFgEqr3TQw7KnqUdEAweQ2u8LKGLOc3Tio6WqFYEuTqrMEPz6qSLN8iEZYWAY280g/XMBS17yP6CzsPKUbn4XnVKXjGUZAOmZTPbRoEZubvYx6gxflu+/ccofhcDst5e5OAG6wwYdh/iAfmRNCsSzi2NfElaNd0fnkzqrwNUyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/nfktBrK4RvVuyLW/0eHE1/Dwig3IdaBKynOHyIwPU=;
 b=qZMf0Y7kfOthpIFjDrd014tCcEnmpizEQyFsMYFy8XosxbfGEHaoZ5LooUXLxCDARwH8Br/zdmY+nj2a3NWJIyLcbj10rYp+ZkBhkHWkM6cBJJVsfAQSdnXS26GS6O8qS9YMp2z/LHGTSa37kzIKmsjsCzxARLxzZZL5PL8W6q8Z9zPulZkJxmf96s2qek1xnlqFfL7clQCBW7q+EkzEBpD5h4B4Y9yP+1T65GbO0OaW0gaaIeFoy6idqmJEI7v6BU7bc3pjdGEBsZLo6zAF/5Y28d4pTVDzAw3NJZ3KufW8ohNgTz9tc1OI22zN06wD6CCU1dbsyUpDXxywGyes2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/nfktBrK4RvVuyLW/0eHE1/Dwig3IdaBKynOHyIwPU=;
 b=gkjvuX7GOy1fe/B3Oh4W8j9JrHtf96U4ou0gO3SaUbx2218PZuz8byR2Q748qWqmh8xhYNN6H2LfDpMwQnQv1eGInjCYbdiN7LYO7p8GT9JBBdPtQG1iL5TJJ9xX8Ov02I3ByOmXv9SPAeEWlvrtu0EX38ASa7g7BO9SW/bE+WxBLaP20hk/ysR2NB6SQ6GHK0egieQ4A3IirX/P09zQsPSeJwhGhBBw0/hg6Y6OdxFalmqz8rs3A44WamExTH7Sgcx4NRDgjfZHQz/g0MP5X4DKIi2ACvO5EcZjB8oDhcK41ErvM9pM8CvqD5DJJtLX2Lq6+zKZeqNVegmGFduElA==
Received: from AM8P250MB0124.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:36f::20)
 by AS8P250MB1011.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Thu, 16 Jan
 2025 14:55:48 +0000
Received: from AM8P250MB0124.EURP250.PROD.OUTLOOK.COM
 ([fe80::7f66:337:66ca:6046]) by AM8P250MB0124.EURP250.PROD.OUTLOOK.COM
 ([fe80::7f66:337:66ca:6046%5]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 14:55:48 +0000
Date: Thu, 16 Jan 2025 14:55:39 +0000
From: Milos Reljin <milos_reljin@outlook.com>
To: andrei.botila@oss.nxp.com, andrew@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: milos.reljin@rt-rk.com
Subject: [PATCH] net: phy: c45-tjaxx: add delay between MDIO write and read
 in soft_reset
Message-ID:
 <AM8P250MB0124A0783965B48A29EFAE6AE11A2@AM8P250MB0124.EURP250.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: VI1P190CA0039.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::20) To AM8P250MB0124.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:36f::20)
X-Microsoft-Original-Message-ID: <Z4kd6zUR11eBH95L@e9415978754d>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8P250MB0124:EE_|AS8P250MB1011:EE_
X-MS-Office365-Filtering-Correlation-Id: 1144b905-327d-440f-74c2-08dd363ddcae
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|37102599003|8060799006|19110799003|5072599009|461199028|6090799003|5062599005|15080799006|440099028|3412199025|3430499032;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cuafbx9SGxxpPHfoMb2I+wPaS0Ky2sCnpcpiUqjOtrPkvtPIZpaBCn4w1uVe?=
 =?us-ascii?Q?paykP8MVpzGpqDFqDtQYZfc0TqiEzEGYqE0reVlvlBS39MXSysjsl6rYdvhw?=
 =?us-ascii?Q?abMzKmyC9sNgoWuyCgZL91mXu86PAFq2MZgMHxpm1Tu6Gr7w18U+SJ2U/BTg?=
 =?us-ascii?Q?IKAd9TwOEo3QTGVDMCH5Dh6BoJUI+3OkJnClFCVYt00MlXcyHbl9KDb1AqKB?=
 =?us-ascii?Q?2Zgazndo8zBpXnVeVLkqEWqHt2bSYYr0J6dRjS2RNwzGMDCZf43ZAKw1XTlp?=
 =?us-ascii?Q?7fBuAUSjxMwYnktxm0to8k7S/gPJ/ZoRnMTMNY8ISHXe3Y/JpHCJahJtcSsH?=
 =?us-ascii?Q?v5qBW/n8fIRR74iVPn/L6DpQEyDXBsYGjI2H7AQn0Jl43Nb/nlXh6LV+n6c0?=
 =?us-ascii?Q?GV49AiM0Q6Qz+VXchS2ukd8fMYKgMoT1FEVXdnNW3l0G7k/LSXmqJP3rRP7u?=
 =?us-ascii?Q?QRvTRaneN3z01iUCRC5exAziTkkY/n8DsIN8Sp7W9h9z9Wm0ryhNHpLyudpV?=
 =?us-ascii?Q?yTjcHrmVMxRF+A8GyJv8h007YaaKv2HNIZ+NrV7EjI8kMz0YjMq+odLau16H?=
 =?us-ascii?Q?Y0h2ToGBnOkO4mydEXsAZvCCxBki9ZIgBR8EmfMj5uZuBpuvQiF1NUL/idNY?=
 =?us-ascii?Q?s/xmlnRRgT/zpsgGjhu7+nulvDoU/JxXMoLstp1fS1n3YXs+TwObAqI3zgo4?=
 =?us-ascii?Q?Ob/kauuqEuSlx47diK44G8OT25o8vGrOsfOLc8TzwPG+KDEzWWMu+Xt08O32?=
 =?us-ascii?Q?tRZL2P+U7WFWwzusrhW7uHb6lN7pecydQSIfiVkj7iR1Nzyq6wpLT4UWi+kt?=
 =?us-ascii?Q?KaAwHSr4j3Mp2Hv/coug5OwezyfGvrokHr8hL1NQVCL6mDrcmCRQsww0gfbS?=
 =?us-ascii?Q?9idAJxWETENbhZMFWB94io7gJJMjLUvImjg8jYxxV0sC4tEeY1qLKIzX/+To?=
 =?us-ascii?Q?ManANpjY5es8JQXR24mtslye9NfObC/wg/Clef2RGilEWuzXt3lhPuLd2KP3?=
 =?us-ascii?Q?SQZ18O5n1W5VHDybwI0QpCtL9TM04rFzsTAZBMh9MHWDbXlSAvRPWVLCNYA6?=
 =?us-ascii?Q?/fQVV0lmj103EglUS9Lnnkhob7Vb3Hz443/c5oOYXBnJlz184ykGgVriV/K5?=
 =?us-ascii?Q?wCHoiuSl4GBHDQHeqPTWoZrwnusgims+zQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oo4boLPrnW5bWewrGV0cxQyD11WHVq2FA0QMzUkSklFFo+Ny4tHhqGM0u7UZ?=
 =?us-ascii?Q?pMZqmd7Eq7so33JizmIrpR5QAs5tFnlj/k4QWsQwpuxC/EgNj1sNBiwPw3ZW?=
 =?us-ascii?Q?aDCPFHhXLeKyWjDapkDe0TbdFaEFwpV+c8aoaRTEOu9k9AqGry72E10XIYva?=
 =?us-ascii?Q?AY3bV3Fjkibss0/FLGMnzYqiVhm4sf3FykixfH6nWCah+y4gl1H8iPNJKBgO?=
 =?us-ascii?Q?0go4Goa4H+dXpSxl/Me8afu77xvCZRM7VIZFRVHPnR+VN7gsQa8yPHBkwrDP?=
 =?us-ascii?Q?lUi1ncc8VnivH1JYYNJIn/692QAqSlyLw+srY/DyB9bC0oZUK+lB1CVs4bYP?=
 =?us-ascii?Q?9Q4orYwqzKb0rlJV8iBbNKrN3oO+qPqq8zu9bjns7d0MubHZ8XEs7AwsxBZw?=
 =?us-ascii?Q?YXsP7CWUUAw7Lw6rsEPt9U+J3bRM2b0PDLqYQSTu1ABHvfLT7qXkV0FSYxa1?=
 =?us-ascii?Q?ZvFI4a2wxSs+x2O+27dWNuBmVYh5phn3dGXZfp6sqGrQZQUAHC5vY/j6UDm+?=
 =?us-ascii?Q?gC0OD4RgKaXfC0T7w6MjrSbt2+Dk/f7DZ4RwGB5R/yGpw1BLNXY5wU3iw069?=
 =?us-ascii?Q?+E35k/0WR7WHH5zNJp8fMA03fnQfoi2Uv9IrZ0vY81vKGYIW86exEcfvOqKZ?=
 =?us-ascii?Q?7TMPaKtTlrAO+ovL5/+ehDxP2Fw+uANqkizunjUDRLSi6isGMZi7Pdw1bXa1?=
 =?us-ascii?Q?nB0H6bGPAu30KphLrAVWKFDfaenrCID4XhJ3WmkXB8lR6/S8I6uUhFjUi6mq?=
 =?us-ascii?Q?FCzaoQ/ZM2zTBH7P0FexfGbSMPLoc6BmxBwwZm01+D/uoxMbHWv7luBIK1Bw?=
 =?us-ascii?Q?e1H/WDn6Vyq4B/zUKdtQlhu2/oRCflAJ/oXmuEcrSwieex025xbiFZASu3HD?=
 =?us-ascii?Q?I9OIQc4dDz2aWtRus7Ar4YHLt/ABJnzSTwcpJ1b8aO9yUNWX7PQ/4Ayf+fUZ?=
 =?us-ascii?Q?QNotzPMAB2MsqCVxrSqPedzSoIQXteLNgf8kYCQ297xw5+vDoKXh5IrkZ1En?=
 =?us-ascii?Q?NhjM+pH6WBOt7Afooz+/pRCzqmbosv/dWxxFqFMXwUz/dWtDfQ1Rzj5JgGdm?=
 =?us-ascii?Q?aQZaqJX89Wgxb6uXXCJbINpOhnbojKCbN/QH1gFO+xPHxMEBaL7dK4FMBan5?=
 =?us-ascii?Q?/92qfkeYNNmsiGCcgOKnXapnmI4gXWqCNq7AK77yhBZeVVJLuuwSJP7j4+aw?=
 =?us-ascii?Q?vaHiVcMKP2GLU2s6qHnMAySM9GNUNIdRmgW+ngQnp2/2kY4uWWROxY05dQZA?=
 =?us-ascii?Q?sqBaJVivrDHvqoy2snyu?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1144b905-327d-440f-74c2-08dd363ddcae
X-MS-Exchange-CrossTenant-AuthSource: AM8P250MB0124.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 14:55:48.1417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P250MB1011

Add delay before first MDIO read following MDIO write in soft_reset
function. Without this, soft_reset fails and PHY init cannot complete.

Signed-off-by: Milos Reljin <milos_reljin@outlook.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index ade544bc007d..be0ca7b12dc3 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -1300,7 +1300,7 @@ static int nxp_c45_soft_reset(struct phy_device *phydev)
 	return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
 					 VEND1_DEVICE_CONTROL, ret,
 					 !(ret & DEVICE_CONTROL_RESET), 20000,
-					 240000, false);
+					 240000, true);
 }
 
 static int nxp_c45_cable_test_start(struct phy_device *phydev)
-- 
2.34.1


