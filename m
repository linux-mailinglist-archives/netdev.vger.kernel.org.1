Return-Path: <netdev+bounces-277677-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLRGOdoC2mlJxwgAu9opvQ
	(envelope-from <netdev+bounces-277677-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 10:14:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E703DEEBB
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 10:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47E0E302DA1E
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 08:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EFB311592;
	Sat, 11 Apr 2026 08:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z60BCNC1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dW7Rxj1C"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF64430B509
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 08:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775895144; cv=none; b=gJuuuzRl94eW/z8CDsF2HIvioPdYtLGT2hM5ewfnhKEucAbxAY6/8U1T60/Nxodrdov69G+8jJLHlX8+I7uGAmVoat8MI3dfso6xfrlOSl+ZElqasuxFH54HfQuJQRVrIfvzB+cxy+e+h8zYMI9VechdMOkzCy7mw5UxHrouVi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775895144; c=relaxed/simple;
	bh=NyETwHthdW5B4gJ3ye9zxcWBwoooBXNdw7NK9RAuONA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aNsu3GPht4pdhcFuRmcfIe/rb94TpovVykWtgYWftq0yDiR1F8ehQrIT9bTt+ECZKI2MlqvT7oPO7Ik4g2x+nJvt854oUhAByCgY8alevhO2zViVcbmhbPt+0d0itnfsbcc1QweFc0AA1/6sOAbQ3pA6oQGI6EfQb1OKr9IPEBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z60BCNC1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dW7Rxj1C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63B41U9O3377228
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 08:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XSARH394vdmTGRvfEuayVkMEZyjI7Kf27FX8nEqxTwo=; b=Z60BCNC1Q3u77yho
	9crAJKE1Q69MsvNOEZChw76YTv8tyWmXKvUWdgObyYyBUclPnwkezIqOqN8bRo01
	jXMA5/kBcw3F+nKgFbPzyyoVy9XSrGNW+gOlpUEBZnzFeoLByPGhyvV3+DXfPSgV
	RfE70zLWS5Vx8Vmokaye85onJ90tiyLcCVF/+hT66nktAaT2BMtzPiP0dgY039e+
	5uusJGTxZTT3AMC1vefgvqswu4HcT0r/SV1EfYdcuC+JO+n3eUX/lZTvVHr3KwYK
	+Z6tsOGQV79hrWb0aHgG5zPVdOMOE/hFdSjM37INtGp7BFEmmIFA9Cfhf6jXw4O1
	+D0j7g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfewkrby8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 08:12:21 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c741f038f7cso1722472a12.2
        for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 01:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775895141; x=1776499941; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XSARH394vdmTGRvfEuayVkMEZyjI7Kf27FX8nEqxTwo=;
        b=dW7Rxj1C0ociDFettCNnril2LQRlTw6sJ3T8hZAs2O//1rdMufgHoBGj3HXau+sAZ+
         D4SS0pu9BvQam/k8co4MtpCIbh8KZeY7Umq3B9foNKQEBn4X4o8FK0N/IZxVfnlEZRcT
         YOjCyJYt4yyU6BUFckAvThRvKa07NdBFGU8Ej1nn6MjtCcyVQSpKRf8ldNMDT5mIdj+x
         zkTzl8U+/ejdwvLDFnc+UYPkYzZ9h3UGW7E1RVfhh/U8bdLmZ/aAMdh0EjwcAtZHwDsv
         53Ewq9k/4+45GEftby78PgMnpPz73PChOijd3LYK2E6GrQxcDD63rEeJCURFuxfwCwka
         hZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775895141; x=1776499941;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XSARH394vdmTGRvfEuayVkMEZyjI7Kf27FX8nEqxTwo=;
        b=PrEj1xFHTqJpO9lepMGaQV+oovrj2Ct7r6kLuKegkf9p/AGFGNpXUAb2zmzZA3J9Us
         MULc7+kmJfhqtO3DvL06strHn56TbginIrEAAh0faUPLG0g90TDCl/A3GRW0CxVVU4p9
         dZtt4KTNoy9KvXz6jeRe675mCRqB1751PjTRK4MIUw0Ifu/UQL7x7gw55oyD02nhnc2g
         fvu14eGYlLc12L6j8LrvnQMkgUwQXN//ffZiIai5r63XMFdoaEeWFzGGgKWEb5MuMgdz
         dxYZ+uZj+tpjgqUYl3PZbwqzdBWZMvnb4SluJvoo+DjDA1cM//ZhLLDHRcdkRtlAttxz
         lKIw==
X-Forwarded-Encrypted: i=1; AJvYcCWk6mAxVBO3IEiWBVSyNhaW4Hu1i6/OnEfhKsl1l3tWdt1vEH+lacPJV54E4Nq5OTHJdF6a1Lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIRSxZUskYQ7qh41Fdg/ECxP4BD7iMYiPYVxWyusAKE2A5iVKJ
	v2Qu/Q0NiwbWNSnSyR0WV0QqkgYX7Nk7RT+p85Gna8boBWzlboZ4T6k7fQk2a/hRHCsoUyqbmpe
	l67IKaHR+v9pX5eFEAtSx5KluTtWVrBaVOY+HjO4KhdWzWGKpYPXaK4PevAc=
X-Gm-Gg: AeBDievvYdV8/6sotKZ1YpigIqyGJ2BE/21iXTlwRpMwO+F5xuCTQyS6+PVcEW4o8m1
	Kvtpc/dam19LncvsGxUTm3J9Pa99O6DtwfDUt1b1HIFA47kyk69ft8UV6C0+cz1EKXThePJ5cUL
	13cgh1cvIv0UCzM141i6029qbp4Lb7GRXCrDAg5yLxEbgvEfJfHKQM3ZEYR8NoogOJF0Au21yS8
	Pl7eBNLB4idbFMAvjSouV4EhdreXHKSHaoBtWyXP8aDt0LFlAk3bot7D8FRP2ebhBj+cCeLfmaw
	98qMkm1DjQE10fk4iKYoeQfF0EKY4TxrBAJSuJ7z13De+rRi9494S4oeD+8TfRU2AJw3P2UMSt9
	TzojRRed4x6Dwoa6sscGl/AhoID+Tn8fZuPKb6/f6jo4TfsRlIYvNeWOS
X-Received: by 2002:a05:6a00:bc0b:b0:82c:e1a0:3447 with SMTP id d2e1a72fcca58-82f0c1880b9mr6659875b3a.23.1775895140739;
        Sat, 11 Apr 2026 01:12:20 -0700 (PDT)
X-Received: by 2002:a05:6a00:bc0b:b0:82c:e1a0:3447 with SMTP id d2e1a72fcca58-82f0c1880b9mr6659854b3a.23.1775895140289;
        Sat, 11 Apr 2026 01:12:20 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c30ee4bsm5410996b3a.2.2026.04.11.01.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 01:12:20 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 11 Apr 2026 13:42:03 +0530
Subject: [PATCH v2 3/6] bus: mhi: host: Add support for 64bit register
 reads and writes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260411-tsc_timesync-v2-3-6f25f72987b3@oss.qualcomm.com>
References: <20260411-tsc_timesync-v2-0-6f25f72987b3@oss.qualcomm.com>
In-Reply-To: <20260411-tsc_timesync-v2-0-6f25f72987b3@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775895126; l=2553;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=NyETwHthdW5B4gJ3ye9zxcWBwoooBXNdw7NK9RAuONA=;
 b=fzBR2FV+F3XnecGKYRPZlKo0IWNSLXZs/Cz9LeprB0uOkdNN4mKqj1lNnk5QyDox4nicuKvMv
 8g1HHNhdsNABQD8a1WisyzGiEY040BMRRNjF92CJ4fv6nhTORsow/mr
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=bcFbluPB c=1 sm=1 tr=0 ts=69da0265 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=8tVK0NU1EB3xojDYR3gA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDA2MiBTYWx0ZWRfX27Sp3R/x3TJw
 4LfvVR38MaKa0RUYsolOaYXbsFaoxfgTjMPKbaZ/zmWf3tIpAbmyww5lsNiMtqED4k7DVUK6GFX
 Btwgsu28wJJFwoJXhqlIs2E+8e+agnHllGqATk7i5a+DE+iOOC0S9asNqxveOAyM62F9snFaOWW
 BASbUE2zMQL1W3sausY8gdeXxaFc1y9ep4mzFaaeoSKyFt5PjIZjF1V+/wqLh5zVsImaMz9KRE4
 7xKK4tvznJAYlDhH8qrGlVajV/Qo0U5i9dBpil/kPEan888C7i0ruRy4glqvp889PShhJbdbswF
 YY4OuY7L7/LEth5xlDScqEMnloKqQDtdbpFTS6U0V0eeL9cDob+3iqLAqftV2EZQy3w6n3oFYFK
 FPrVZfhfLoJjT+VCzRN69QmYEENFsPa6gLLXL0S0yJNTb47YelbYxUvFy0X11z9hDOLbaE7oHKL
 HO4Ivy40cdcjS/UbXbQ==
X-Proofpoint-ORIG-GUID: DmXMV1ZswHyw1S0os3Qbs6q4A601k6lH
X-Proofpoint-GUID: DmXMV1ZswHyw1S0os3Qbs6q4A601k6lH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604110062
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-277677-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krishna.chundru@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 88E703DEEBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some mhi registers are of 64 bit size, instead of reading high value
and low value separately provide a new function op to read & write to
64 bit register.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/bus/mhi/host/main.c | 12 ++++++++++++
 include/linux/mhi.h         |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index b7a727b1a5d1f20b570c62707a991ec5b85bfec7..99917593e1da06f1dece7b5b0037c2485953410f 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -67,6 +67,18 @@ void mhi_write_reg(struct mhi_controller *mhi_cntrl, void __iomem *base,
 	mhi_cntrl->write_reg(mhi_cntrl, base + offset, val);
 }
 
+static int __must_check mhi_read_reg64(struct mhi_controller *mhi_cntrl,
+				       void __iomem *base, u32 offset, u64 *out)
+{
+	return mhi_cntrl->read_reg64(mhi_cntrl, base + offset, out);
+}
+
+static void __maybe_unused mhi_write_reg64(struct mhi_controller *mhi_cntrl, void __iomem *base,
+					   u32 offset, u64 val)
+{
+	mhi_cntrl->write_reg64(mhi_cntrl, base + offset, val);
+}
+
 int __must_check mhi_write_reg_field(struct mhi_controller *mhi_cntrl,
 				     void __iomem *base, u32 offset, u32 mask,
 				     u32 val)
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index f39c8ca7c251954f2d83c1227d206b600b88c75f..8e7257a9c907fb03571a86e29db5534f492678c7 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -376,6 +376,8 @@ struct mhi_timesync_info {
  * @unmap_single: CB function to destroy TRE buffer
  * @read_reg: Read a MHI register via the physical link (required)
  * @write_reg: Write a MHI register via the physical link (required)
+ * @read_reg64: Read a 64 bit MHI register via the physical link (optional)
+ * @write_reg64: Write a 64 bit MHI register via the physical link (optional)
  * @reset: Controller specific reset function (optional)
  * @edl_trigger: CB function to trigger EDL mode (optional)
  * @buffer_len: Bounce buffer length
@@ -462,6 +464,10 @@ struct mhi_controller {
 			u32 *out);
 	void (*write_reg)(struct mhi_controller *mhi_cntrl, void __iomem *addr,
 			  u32 val);
+	int (*read_reg64)(struct mhi_controller *mhi_cntrl, void __iomem *addr,
+			  u64 *out);
+	void (*write_reg64)(struct mhi_controller *mhi_cntrl, void __iomem *addr,
+			    u64 val);
 	void (*reset)(struct mhi_controller *mhi_cntrl);
 	int (*edl_trigger)(struct mhi_controller *mhi_cntrl);
 

-- 
2.34.1


