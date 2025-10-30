Return-Path: <netdev+bounces-234398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DD3C20125
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 13:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C474434E41B
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 12:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAFC33F384;
	Thu, 30 Oct 2025 12:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="REI4QB/c";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jq25XWxH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CD31D5CD1
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 12:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828329; cv=none; b=caRgem1BhrprTFmbyg+gNJ4E1z/mnSqeNi4Kpi2nFnOMaYAOewc04EKJAfeEl/GO9LCh/r8QLXbtTYXQBEDLEmM6MY/ib0M0q6KaQzEzd/VpLgqTr6JjyoJAiYil6/DMr40YyJC2b9DCTg1aCXHufFbZXJWJvFhGo/9fbDRF2nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828329; c=relaxed/simple;
	bh=w7qKQ14XIDlgfkufZlQ+5WqdgI5PlsVE6i0dIrmSX8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LCEtV5Zy7jaX7JvRNHFBW0g77yvajwnEhhuBwkss60UR74Cercka2IhnQJHj41f1VJwqFkeSmVG5aj0f4gg54iZsSYW8jqY80AxwI+wxO5cnXSLH7D30ZVfEX/AemXajmp8CbiqgNiFCGOOL5iNcKI5OsMw4vtw354ZDW65Eg2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=REI4QB/c; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jq25XWxH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UAPUjw3281609
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 12:45:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=GJ959Ncxv+x72xmSF8Acf2uWX5yesA01ocJ
	f7G1bCUM=; b=REI4QB/csRNEPJG3bLIlQDDPA7ZNTkMI90PV8ueGTjGDmtJ3K0F
	Y4cwJFoZf8pqDyFbx1rtQUji2k8nVDEhh9Gr4LGEnlezh6f6p1bCZy0zr4ZLPpOH
	y9Q92fqAKl3bVKjkj2a2PxP1GozhHqCA1WSnwdUoLEumX8TuxMG8B3QOmCMOIZ7q
	kc9GkhHj9oIMMhCM/POv2kUQp32O2J/E65u8fj49kgFHLAVjn9tp6m111JcFJpmJ
	fxg+/aY2zrCn6ynRUVeDKZhSAmDWSeXAg4Y4nfP8uTtdHyuGQUEXUsPtfGnIGvWL
	/p2GrmelJIbeMmyqHDDj5AVE/3fOJnsYy8w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a468kgb4r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 12:45:26 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7a26485fc5dso999856b3a.1
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 05:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761828326; x=1762433126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GJ959Ncxv+x72xmSF8Acf2uWX5yesA01ocJf7G1bCUM=;
        b=jq25XWxHE9B3DWLksRt76jhC6VCT4MelbHWIrq5arrMt5QKvqk6i/nuD5sI1pbxfRm
         Y/wXmmWVVrUsXOXopJr665jncJVyxNPbqfxJxbVajp4aV0kR4LCgngU3FRVL1DdxWQHu
         alkQqghzxg3RQ6L7av4XZVkmUAVmwrZDJplbixIq5PUfB5JfHXCjQ5k7QcKR2XoEsaNu
         UJNvWJC3GqBmpbmberRO1XWCk1/D7xuozsfucL/5ZU9c3U/jVKWpIqLVvP680tKduMuD
         R8rQKeeucdv/zMqdcIhJ+yFBH80Ion9dp37A44P1+vgHDmGllDHg6G7zg9ySljmt5bc+
         DvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761828326; x=1762433126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJ959Ncxv+x72xmSF8Acf2uWX5yesA01ocJf7G1bCUM=;
        b=KpVzknYoTzP2FkKbm/CuzFZ22ZJH3ovEeHjjgGoTtX0ocDLY2mfoTS27R4c9ERWwaL
         KN5plptxve4EdhszHo727sbe38oibjcZ5gpXzMaJRhwGybF/dU3tgI2FZTXAJpURpheU
         wAy2INxI05mah48+T3qkrG8hYgdetaa4g5WtL+4WZEupTatfkkdsIAYViMKBgejY/XNK
         XaM3IbQfUV4lW7y6icAcKR/yfmmMsVbgeEc+S3FfFL6LSzKqT6qMUD13IA3vCzuIAeuo
         sbFeH94X5VUTn58KlLxc3nHcVGn/6AF68Kv/DJ2MPqJFayM62mwcMqUd3RNjlzVvSADS
         O3WA==
X-Gm-Message-State: AOJu0Yy9dY9kb5oueSazqjx3JpCb/MxtHhQU4DWicrX7xnCP4KNaXP8T
	k1i3arVrLSfVmPBVpvUYophWx7baS+Pmbyorsq6jwZjQCZhZ+2aACAtIDrLrNzQ0ztDRPlQbbSw
	6ZU/iM+L2KCQTlOKzHnkFjD91PR9WEDP0lDeqsVxpmUAxUxP2Puf74Hg9Y/g=
X-Gm-Gg: ASbGncsqW3+63I5ThDKuPd3Vn8dhWs+qp3/y/0Var0HPgJ9Dcy2cD+1qT5N+EqmLi8Y
	cJgAIJi4fVb25ysxReRqmoZ8nmzKB2UlDkaSI/Mj3RGTabXuAUwWFsNPC9ZuwZm4Abez1qsqS22
	UsFhE0auDywwWHcVi/LAQZIkM8uEkePzvMvrrcoXyRhm0U1zurudnKjwNKBqrZLjMBJdipyop+7
	vqf4poQ1HEXO3prtj6pYCwT1yAMv04t8F3WZDc+nF+PfWC0Ro7aYDw2/VIjw86d7zEsVVMS1bIM
	lgAKYCdIiB2L0bXyjOFbtlKJMwE+uOBoEB5NK/Uc/ZXqiVCLvRkAHYEI1RNCjpNnFaZLpBo1oDe
	yMylfytEphya9yML8r6LmEUQajbtC+a3VzWJVlbcXn4rdBrMgN13D38StZxrANwS8og==
X-Received: by 2002:a05:6a00:84f:b0:77f:2b7d:edf1 with SMTP id d2e1a72fcca58-7a4e4e12a29mr7632475b3a.16.1761828325923;
        Thu, 30 Oct 2025 05:45:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX+ja8XWkdnMYtwbaI1c6ZXK1XK3OVcW0z/iXNFr5CNSDYSTtFNfIX89htBV5jVHLtckp2iA==
X-Received: by 2002:a05:6a00:84f:b0:77f:2b7d:edf1 with SMTP id d2e1a72fcca58-7a4e4e12a29mr7632435b3a.16.1761828325408;
        Thu, 30 Oct 2025 05:45:25 -0700 (PDT)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414065418sm18931035b3a.41.2025.10.30.05.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 05:45:25 -0700 (PDT)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: richardcochran@gmail.com, jonathan.lemon@gmail.com,
        vadim.fedorenko@linux.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
Subject: [PATCH] ptp: ocp: Add newline to sysfs attribute output
Date: Thu, 30 Oct 2025 20:45:19 +0800
Message-ID: <20251030124519.1828058-1-zhongqiu.han@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDEwMiBTYWx0ZWRfX56viu1OdeSnO
 nkQMyEhqzczGzo/lDi38LBsZLsGUshRs/V3sgp6EkhSIEzFeGt7TmQGEJ1gkFrJnIJLCtw247xR
 VY7s1NMnDcAGpBXJB/kIh+/SPTIkEEEuYHIy0Zr5ptT/BlojQDY9J7Qq9y8iCHee39xdrjN1Yjp
 jXGcdT9FVx7TZTsOT4xbfB7ZhlBDqen4fiB8cqOwRwW8HBkdVMhPIIuTneEsVtbidRdnsRGCcRS
 6BzrkStF1m0eeoc1izG+xatchAJPvNsLjsUqjEAoU36kqt7JnY41ZsbKUipAm6PIbB34blz/uHI
 kAI0Fq2mCzUhXd+5QmANStKuEJLizKh/Cx/Rbh+qV/j1cz5pGpUml55oOwdLL4l/9NeD9Qm030W
 z3csljTa0TxZq645vFvu467Tu0B6lg==
X-Proofpoint-ORIG-GUID: g-DdWMy7YI915-Yyv1GSsQRDSlpjcfnS
X-Authority-Analysis: v=2.4 cv=LoWfC3dc c=1 sm=1 tr=0 ts=69035de7 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=ge1YUZ9DX2Ns1i_QU5kA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: g-DdWMy7YI915-Yyv1GSsQRDSlpjcfnS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300102

Append a newline character to the sysfs_emit() output in ptp_ocp_tty_show.
This aligns with common kernel conventions and improves readability for
userspace tools that expect newline-terminated values.

Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
 drivers/ptp/ptp_ocp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index a5c363252986..cdff357456aa 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -3430,7 +3430,7 @@ ptp_ocp_tty_show(struct device *dev, struct device_attribute *attr, char *buf)
 	struct dev_ext_attribute *ea = to_ext_attr(attr);
 	struct ptp_ocp *bp = dev_get_drvdata(dev);
 
-	return sysfs_emit(buf, "ttyS%d", bp->port[(uintptr_t)ea->var].line);
+	return sysfs_emit(buf, "ttyS%d\n", bp->port[(uintptr_t)ea->var].line);
 }
 
 static umode_t
-- 
2.43.0


