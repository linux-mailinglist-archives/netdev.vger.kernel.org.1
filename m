Return-Path: <netdev+bounces-236669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AFCC3ECE3
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 08:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2323A52E8
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 07:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C2A2571C5;
	Fri,  7 Nov 2025 07:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jcitbyxT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K+cgER4F"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56781309EE3
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 07:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762501544; cv=none; b=QIT2/YZqarnyjbdRlA+uNyf/zBKPUXgEtpWKwXFmfzC3hvpBgEiY3EhnkBXOsyr20BEJ3o6D+1OUxtv1aLEKcFgIytNvKtKXm24CZLUbWHlLcQsSFQrrjqWGzS0b5bOQZZY4K568nkt3KI9Ile8K2ir108Wp8Uyvr7V0B1uY3w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762501544; c=relaxed/simple;
	bh=iL9jg8JielYKJvltCPaRLVi9XYRF3/bpxORT8vDhO0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=chHmsOXXtc+P7rrn4uDzzT/NKg7wR6VrXQBFbmn4/QZ/WCeVfjesGuYDlfwmYDZCHaVBf86ltm0iq4h/AU8ZDip//ekyCYpQV8hA7HrJtdHQjXDNi4nqtQF3rz7zsqy7uy9J+VBuL4VdkizMwG3uiJqWAock/bY5mvssE4vLrog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jcitbyxT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K+cgER4F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A744mn22085471
	for <netdev@vger.kernel.org>; Fri, 7 Nov 2025 07:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=JAQSrdQnU5b+xEfyyzGPcAxz+3ZD1vRWfFZ
	NNoPawVE=; b=jcitbyxTeiUIeD4Zd7brr/eGbSa921wc1LegkI2wONEEFmA9ISH
	Gz5EVMyOKMv87BjUyspDbipAiLED0M0nTbkeWGmUWrGrut5QvP/0VssQqdlpqWtb
	2aAtigd2fZgrg8jtrQjfX6lOw+5PKTXiljmK4WkmjLpQiA+yMcqhR/9gdBZTejCB
	M9mEpWy6g+I4A9yvR5avp5w7DEKcjldzwwbQNCcKMsW6PdlMPSznp2S6/S/1+hmA
	83wB3jF/MynjmLgvonuk/cdJTvaVjTFDXyxERmaFSq/dddsIC2dYCSVHsLJfZb6E
	NUylz13x0fBu6vj1iRNWPleY1a56v4T/Orw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a99e78hmp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 07:45:41 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-29085106b99so10096705ad.1
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 23:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762501540; x=1763106340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JAQSrdQnU5b+xEfyyzGPcAxz+3ZD1vRWfFZNNoPawVE=;
        b=K+cgER4FmPPG+Xxd3QbDJ4se9xpzCQ+ZCyNEROtmdd2ymK1KcPxV4OAVL6djWGumNw
         6gOGufFE5FbguioYoMk8ZZOlntdE6D6Y2s69z4ORmUxaUnTjlDLCVTvuIE/fAe7Yg6a3
         D7839kvP98Apwf+unYSCtagnJQiD0oW4VdN2Hpp5hbEd1kIAdvQ1R3WRP7smDZ/1lv/W
         PgaCTvrWecWLNDUtyw4SU9h7N3wlq1N6WjgZCHgDK0Xxr1xcQbSPuVAIH2tyLWs07FFn
         kiP2hUMdlw0zKRw57DMSwW6zdNsvgcqcUnje/jL+1+XZSAo5+IypOKOrHz/XmS4HHraj
         wjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762501540; x=1763106340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAQSrdQnU5b+xEfyyzGPcAxz+3ZD1vRWfFZNNoPawVE=;
        b=ecRfcdfhqmiCIwS6CSnye+B3+tMJldZ1dIDMjcWX6mHQ0FFDKd3OrID3z+HkxbbQPx
         pfATO7j/fTqEbCo1l8L8Vy91Tu3Wa9AgWY2NxzGuvcYVhfMuCFqYHGmjIQBuTovKGoHJ
         +xg9PZCoWHoh8ElLHgV4h0Vpudam101Do2t4S3dQQlzX+a6KTNSILeKmutMIuh2dhybB
         D5CxA00dPQw24lZTBuyxsdyXeRu/jDk6dtZCHxXh96M/etlIKPjMl8sSMiKLywd8VeAD
         POWLaC/DXChPp3J9JHpHDOzhyk28hDcwlX8PhLmqO6n7dofcoA6lnRFbRLJITiOx9XMg
         rnVw==
X-Gm-Message-State: AOJu0Yx4XSgw/Xv+WmzI2gM7Y2wiTfRsEZIyWRkYv8OLIpD955aO7spp
	gjwkmGQF5qcWwQASbYUF8KT4KqSUKypZYTGRb4vvCHmUfk9zavTyHl4PmTmK0tzCSt+++SnrFEf
	ZsbUAQITrP3LoQrTJMNfCzo6An27/SllvJewi7dy6jCxqgWsm46EzlULYTkM=
X-Gm-Gg: ASbGncvqnwco0EOPpj5sELt10uA7NwsFH4Yr5DOjU9ki2l7ksKMVylwDrEuKxPV1tO1
	jiVudC2Zpb6C2Hi4a6FWR7qBmcJDnzNpaf6Hxxot2oGiVE2bZE8kwXSGET4LP5ZfECu71Ob00BZ
	av7jZtCTF0x09fXbaYoGY5P88HuVKm7AlbAsj39Ql1FX52kjj1R02A2TeSZ+QRAsAQkwx2BRXIp
	4nWPpjbigCkSD9z2xEWU6H07kMp2XnXbmNwVFzm2A/a+R9ImZ26VOeFRteClGhP6885SoKsQPPS
	t6DNEnJQKd/g5aczivBT4Tpb5TRLclABDSGeOte7ZIA0cAslup6ROd0AxMbbpDD7UHCBt8NZEmK
	ws7UhHC5fTxBFVL5ScDyHk/rkgekcFEORkB+mHPcf1rVhsCCXsq4pb7jemF5llbXI8g==
X-Received: by 2002:a17:903:b43:b0:271:479d:3dcb with SMTP id d9443c01a7336-297c0395192mr28621805ad.6.1762501540135;
        Thu, 06 Nov 2025 23:45:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKeLzOMREliBO3SqmoQQ2j3ltfEsJ0J2WpMRv3VjriUjF30BWJ92SOqCEY+shDXYfmeUtCwA==
X-Received: by 2002:a17:903:b43:b0:271:479d:3dcb with SMTP id d9443c01a7336-297c0395192mr28621335ad.6.1762501539539;
        Thu, 06 Nov 2025 23:45:39 -0800 (PST)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651cd2418sm50884275ad.109.2025.11.06.23.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 23:45:39 -0800 (PST)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev,
        richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
Subject: [PATCH] ptp: ocp: Document sysfs output format for backward compatibility
Date: Fri,  7 Nov 2025 15:45:33 +0800
Message-ID: <20251107074533.416048-1-zhongqiu.han@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA2MCBTYWx0ZWRfX1aoM/o9iZmh2
 1ggE8QZoK5lIZMiQvvlE4jInBzOW5nHO88eojGVNIuAvcV/4Od6F0I9/Le3bz8LE94bxdg3XPwt
 +fekDA/FgqLg/xGR8nNjdOReLpAKdt9Hpb6KnC+2onCL69TkcxIYuOYp5qIDxjXQfGOwWI0XbA0
 agaI9ptuMJbK/LSA+tQIm7Iv9Va9N6bmM5r1DdXPaESpefI0MJSzQpeVAJPm4YH6jQRYOT3v1e5
 JvnlzDAvNLKijjjF4M/djclBTLiUWt+CFQrsDFcLbyy5s4yOspKvAWUYKfFjF3dHfRbp6X2agAl
 N2ZJzbHhXiitaZsCUytMElLlhMxK/ppZomwpgZKqtg80kf+X4PUAwBMsnxovw2JpoQD9AwktgVY
 9ov46FTUT5BQrY6/0NXqiEfhLA5MPQ==
X-Proofpoint-ORIG-GUID: XAHSsvcBNJpWZqdvXEZ2BpsONvZWOOJp
X-Authority-Analysis: v=2.4 cv=A+hh/qWG c=1 sm=1 tr=0 ts=690da3a5 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=P3xlrWuPvaME_hMzoIMA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: XAHSsvcBNJpWZqdvXEZ2BpsONvZWOOJp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_01,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070060

Add a comment to ptp_ocp_tty_show() explaining that the sysfs output
intentionally does not include a trailing newline. This is required for
backward compatibility with existing userspace software that reads the
sysfs attribute and uses the value directly as a device path.

A previous attempt to add a newline to align with common kernel
conventions broke userspace applications that were opening device paths
like "/dev/ttyS4\n" instead of "/dev/ttyS4", resulting in ENOENT errors.

This comment prevents future attempts to "fix" this behavior, which would
break existing userspace applications.

Link: https://lore.kernel.org/netdev/20251030124519.1828058-1-zhongqiu.han@oss.qualcomm.com/
Link: https://lore.kernel.org/netdev/aef3b850-5f38-4c28-a018-3b0006dc2f08@linux.dev/
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
 drivers/ptp/ptp_ocp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index a5c363252986..eeebe4d149f7 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -3430,6 +3430,12 @@ ptp_ocp_tty_show(struct device *dev, struct device_attribute *attr, char *buf)
 	struct dev_ext_attribute *ea = to_ext_attr(attr);
 	struct ptp_ocp *bp = dev_get_drvdata(dev);
 
+	/*
+	 * NOTE: This output does not include a trailing newline for backward
+	 * compatibility. Existing userspace software uses this value directly
+	 * as a device path (e.g., "/dev/ttyS4"), and adding a newline would
+	 * break those applications. Do not add a newline to this output.
+	 */
 	return sysfs_emit(buf, "ttyS%d", bp->port[(uintptr_t)ea->var].line);
 }
 
-- 
2.43.0


