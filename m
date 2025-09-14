Return-Path: <netdev+bounces-222850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB10B56A05
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 17:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBC25175108
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 15:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4C02C327D;
	Sun, 14 Sep 2025 15:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n1faTB5N"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CF026E6FE
	for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757862447; cv=none; b=NtQ4zouib+tM+HnAhUpqNqwhv1s4mZAKYY8UrzfMFPAtfEAyVIgSKDKQKBGyAA7xTfVz6pwBdcMjaaMiGt/hlJzG4jyQm/Uim7dNSkVJHSSdhwEzUnbcZlzb73urI5wDQIUlbqDJsW8J16P9838W0da2AdTAQkofcKFtJJDtZFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757862447; c=relaxed/simple;
	bh=Xm04sNqg6M8XDtv4CgRhGuHsDDCT4cUD0lbe9sIdlTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z/seYpNYavZahinJl37N8VwONvXnOQvVmP7UpnZIj0uGgpcXnKqLpmT2gXw/9V0esm1HirQulvw5ziveEXyRMzv7ybHQaesWdRnLLftrXMb+p8o7psbR+VnexNfzXuH6WpBWvwjGakB6rWv2YzwWCQq1nZrp+t1O81SD2dl1svE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n1faTB5N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58E9vvnC030065
	for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 15:07:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=mpnZTgEP6/zsg99dZFw1ct
	tV1r11s4EWbty3YUt72oc=; b=n1faTB5NTnl6tRExu54P9tzy9KvFhYyMvlEfrF
	wnxZlqO9dAUICiL1731xglQpvu0vM41eTbQ90ifE1kzFxPMxKRFp7XbClvWaVYoa
	9HnI63WW4IvKMKZNmROy/chuEbaYv6OJDIh4J66A017hCexjDtbkBAmEjTuZCEPu
	1e2elaXGixg7S65lunzMmumzkmAExdK1hfTOB4HAggCpSyfp3RmpaOJoad80AUC2
	ykQ1DngyA8soEYp81sXbpszozrM0HAbWaj/PHkDliI7NyriMmy2DthidHaBeeL5j
	PvgtaxQnlq2GOBDimDoCkpCJjwUFjfJdoulY3WWDv/+FuLow==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4951wba9ag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 15:07:23 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4c72281674so2377583a12.3
        for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 08:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757862442; x=1758467242;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mpnZTgEP6/zsg99dZFw1cttV1r11s4EWbty3YUt72oc=;
        b=oT2TuyiuM6R3Z7lCiqLuxiHkC/PMJYn5xZ4zUIXD9iOoYVh1wp9Hx1fnaFbRFhVVJ1
         ihBWb0eXuic3zHQpy/QuYHZchH6yzb5Bid9KWL8SJLSc2haYFmcWuBP9ejncaK7bGz0q
         bDmpLSDsQwkykKpjnMUxdX6Sel9JXv8PlC7bFbWfTUFA46VJtiLMEGdMPcEKBbk5iGdR
         KJCFWw5yDSHNqxo1VsxJsFpGvRGKLK+b9zZ4bt0MXxclCsjF5xXQfaf7lOSt7UQvYy/J
         FvmNFg3bQj+bLZhn3d1TUZ/Y3onAG1vSerAGWYKI1wZEkQ3lb1iklJwnJzTvWv4cpdI0
         arIQ==
X-Gm-Message-State: AOJu0Yxvr945n0fIsEyDPEWwocZaqIKWk/4zqFryc8dEZl219RuTd7hn
	iey7Z2r7EBYnf9hqqbiFph5qDvBkh7a1is8Y1/njPbFH4STi3uHkmciw7oobloi4iH0wjLV6ml1
	y+7cbL/EGuM8ZaPYLP4VkJqkVpeUaHkBB85f4H49KxdtP4wY34LH3H4oh6GE=
X-Gm-Gg: ASbGnctSsT32VEhsERSpKTR7DmrMsAIn9Lxz3rAE/Mv+T5p39jr0WlvHhLkztN71Ddg
	jRI52PNRX7GPX21COcV0FjyB5bkxg9obHlq3ReIY+kEVJe87vppckpmD/tRyHJcCWeJ7iYlqh/J
	biPkvkX3O+OZWchsGC/wUWDRHDqLELTtgVaSB7JjRHbxrBxpBNBKHuXNzQVqOlfYqPmJr2QIEUh
	rrdHlF/XfBVnJszomRfWwcLTOnoMphRnAM6mb2XLYx9PzTX0k2vddiBc7yCxmcZKiSTHAoGih0u
	9PgCFoSU6gaePnsAIYeSMcfhChGBRUEG7uJfwnd0aBP5DQx2JmtUC7CVQMfrP4z6WrhX+Q==
X-Received: by 2002:a17:903:1acf:b0:25f:9682:74ae with SMTP id d9443c01a7336-25f9682760bmr74240975ad.29.1757862442275;
        Sun, 14 Sep 2025 08:07:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFM2SEI/4RHZARg2DjwJIXHfkwPqpsE8n4zdcMsj54ea6iU2s7Mz+jWRjVuhZf130ZMHHhOOQ==
X-Received: by 2002:a17:903:1acf:b0:25f:9682:74ae with SMTP id d9443c01a7336-25f9682760bmr74240645ad.29.1757862441744;
        Sun, 14 Sep 2025 08:07:21 -0700 (PDT)
Received: from hu-mohdayaa-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-261d3dd029bsm41290835ad.25.2025.09.14.08.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 08:07:21 -0700 (PDT)
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Date: Sun, 14 Sep 2025 20:36:48 +0530
Subject: [PATCH net-next] net: phy: qcom: qca808x: Add .get_rate_matching
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250914-qca808x_rate_match-v1-1-0f9e6a331c3b@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAfaxmgC/x3MTQqAIBBA4avErBNGSfq5SkSYTTWLrFRCiO6et
 PwW7z0QyDMF6IoHPN0c+HAZsizAbsatJHjOBoVKYyuVuKxpsEmjN5HG3US7CV3jXFWLljgpyOH
 paeH0T3twFIWjFGF43w+AXFmxbgAAAA==
X-Change-ID: 20250912-qca808x_rate_match-570d44f510b2
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757862438; l=2388;
 i=mohd.anwar@oss.qualcomm.com; s=20250907; h=from:subject:message-id;
 bh=Xm04sNqg6M8XDtv4CgRhGuHsDDCT4cUD0lbe9sIdlTY=;
 b=yxKm8rrtwIeIwjA72uec0u0qsefs0G7ye/yy0CscNZpqsuIxMj3rdWgjPilCqrX59l/JKDvQQ
 qvP/8f6UxZQCD/nSWnt5401kDVSBftS5L4uMGuX6zwt7uB7F2SIcqMr
X-Developer-Key: i=mohd.anwar@oss.qualcomm.com; a=ed25519;
 pk=7JNY72mz7r6hQstsamPYlUbLhQ5+W64pY4LgfSh9DJU=
X-Authority-Analysis: v=2.4 cv=XYKJzJ55 c=1 sm=1 tr=0 ts=68c6da2b cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=QNaXVSbgLMPUDDG8BmgA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: qV0gZS51xa7Zqg6MHPNtQkSbqRMSV6mn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDA0MiBTYWx0ZWRfX8FCC3Nz9C/nv
 WTmlnTbnbuZ/C+QszTmeRH6MfCsQlrYi9kYNTMyNvqfPaHwiOi6E5yGvVU6pSRVnHa4LJ0xu+3n
 5hrMIxjYUqxL3SkrLZJAupI/PZ3/DYPUDMzX1DpGd+aJ1dH6yZXEBak4Nv8pBOCuHADuqRHt/oD
 Nome57RGOPzjGYbbN0PoyVOwEcOqFFUffvcaKoPjIjxytQiVssQKoc59qOIgqArfLn4Y29tqt8T
 Uo8kiAs2xpbUwpsLjaQccTyyqfmrxCQiQoYrzGOn6SncJfSMec/RMVDTuT97XRfvCCfORQJ4uYh
 /4AC/NobsOgssK2jtkeSVC4wzbe+SsY1fQiFcnHM9HUzmmYPnCwaDZxMgVbdZG44MZavOh4A1q7
 A1f7Mbku
X-Proofpoint-GUID: qV0gZS51xa7Zqg6MHPNtQkSbqRMSV6mn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-14_06,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130042

Add support for rate matching to the QCA8081 PHY driver to correctly
report its capabilities. Some boards[0][1] with this PHY currently
report support only for 2.5G.

Implement the .get_rate_matching callback to allow phylink to determine
the actual PHY capabilities and report them accurately.

Before:
 # ethtool eth0
  Settings for eth0:
         Supported ports: [  ]
         Supported link modes:   2500baseT/Full
         Supported pause frame use: Symmetric Receive-only
         ...

After:
 # ethtool eth0
  Settings for eth0:
         Supported ports: [  ]
         Supported link modes:   10baseT/Half 10baseT/Full
                                 100baseT/Half 100baseT/Full
                                 1000baseT/Full
                                 2500baseT/Full
         Supported pause frame use: Symmetric Receive-only
         ...

[0] https://lore.kernel.org/all/20250905192350.1223812-3-umang.chheda@oss.qualcomm.com/
[1] https://lore.kernel.org/all/20250908-lemans-evk-bu-v4-12-5c319c696a7d@oss.qualcomm.com/

Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
---
 drivers/net/phy/qcom/qca808x.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/phy/qcom/qca808x.c b/drivers/net/phy/qcom/qca808x.c
index 8eb51b1a006c4c68ddce26c97d7d4f87a68158b0..9d9e93d2fa8f57b1535bc83e169eb011ae549040 100644
--- a/drivers/net/phy/qcom/qca808x.c
+++ b/drivers/net/phy/qcom/qca808x.c
@@ -643,6 +643,15 @@ static void qca808x_get_phy_stats(struct phy_device *phydev,
 	qcom_phy_get_stats(stats, priv->hw_stats);
 }
 
+static int qca808x_get_rate_matching(struct phy_device *phydev,
+				     phy_interface_t iface)
+{
+	if (iface == PHY_INTERFACE_MODE_2500BASEX)
+		return RATE_MATCH_PAUSE;
+
+	return RATE_MATCH_NONE;
+}
+
 static struct phy_driver qca808x_driver[] = {
 {
 	/* Qualcomm QCA8081 */
@@ -674,6 +683,7 @@ static struct phy_driver qca808x_driver[] = {
 	.led_polarity_set	= qca808x_led_polarity_set,
 	.update_stats		= qca808x_update_stats,
 	.get_phy_stats		= qca808x_get_phy_stats,
+	.get_rate_matching	= qca808x_get_rate_matching,
 }, };
 
 module_phy_driver(qca808x_driver);

---
base-commit: 5adf6f2b9972dbb69f4dd11bae52ba251c64ecb7
change-id: 20250912-qca808x_rate_match-570d44f510b2

Best regards,
-- 
Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>


