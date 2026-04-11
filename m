Return-Path: <netdev+bounces-277679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IO91KkQD2mlJxwgAu9opvQ
	(envelope-from <netdev+bounces-277679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 10:16:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0C03DEEE1
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 10:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8DDA307E065
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 08:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8243264CD;
	Sat, 11 Apr 2026 08:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HCzFYd9I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ix489YhI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5304337BAC
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775895150; cv=none; b=mRym6EvbrKNkQ134bmDihbm0+mLonLyUHedfTDIaDuy//HBhWXu9MXRLCZYY//dh+FVHeklxtOXKZt6Wa8ObScIVViPbSjRP/gX8sAY2miAmzN0Xi6SAaUaAxoZvL8CzSlUnktfmVWnL97OKXPQr64bn7Nfh7El6SyZy2V5y5zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775895150; c=relaxed/simple;
	bh=MA03LnHAjOcvrM5mKxM9VHVgHQ54gpGwmJ8aVHg0TVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KGNFKlV6ntwB2/bbFrI1sgqHpv1Ug2gvDWOfwYlMP2MH6iP23q322S88cnf1aC35fyqV0qIAzDaf3wt6IpoA9SW70IP+yvUrPx/MlOqv5knP//Wjbr+uAeK0475+ooYJ3e4o0jQ0+yEIVZ1mVtSsuVA2KNTBbK8OmbXr7HYoHHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HCzFYd9I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ix489YhI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63B41T4G3377210
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 08:12:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XQs3/vhNVlE1qEYG7AJugEMA0XRV65iB16Q7DxAeW+c=; b=HCzFYd9IdjJUvnub
	/l4LSzoGQC94OgVWsKijUENulihc/wYEv317r9t9OCjc4r/1p+mlI+Xb7QBwSMBs
	aAuPgs1vNcjtqpoqmBrp87WdNMpMgI9L0tgZIeRL+tokyT0FTKwuoXjXjHLBmWw4
	6eyc28zMijgGPVUpFKsr4C2wlCanAyn1kOLyevKrXCmxiTT6Kj6m20kV9z4HPFnn
	dP3xUZkfIHK611kffqMLjTa8gMZA/QK3b7NyDZps22NhA9v1RTkZVB1SFGcqRcDK
	wuuDtWEWX2ofV6eNrrAjp4M3OgkskeDMR/9a6N1TCVyd26DPcuzVhMFbRPyXqwaI
	c5Eiew==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfewkrbym-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 08:12:27 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82f07078ff0so1336273b3a.1
        for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 01:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775895146; x=1776499946; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XQs3/vhNVlE1qEYG7AJugEMA0XRV65iB16Q7DxAeW+c=;
        b=Ix489YhIiMmF0GTbjMeTRWVogXXORqnYoECEa00ZiqJ3wBYujwwVetRw/6m+T6CFeL
         NZKv2N7sm4QdE1eYtFDto7UnXx/2tGZ4ZQiLKjLFaEP+KvTQtHTmUzXDSXWrHAlJ5F80
         xE0kHlF4JYF5tqE884BWQlxYWVddjqrphRNbqRBhgIzYh7DRPMOc7agRxa5nmwyisroF
         O4sFxf6BaK7Vo72tjLVif/mOlQ9AR0mxj36oCAdBe15MNRScOEfqm/9fMEo8b/EUwz0w
         q9ACtfzIRBnS/cYYVM6GfSJUAWeSHs/6vLRR6zsL6UqchYgX0+Bdu0yIJ1YDVZNuo0cd
         qGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775895146; x=1776499946;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XQs3/vhNVlE1qEYG7AJugEMA0XRV65iB16Q7DxAeW+c=;
        b=dsZ5v9aoC9vKS+7YopDEmdp2Tc0HDbUTM2iMWIXrJfZ00ux2EVIDUWFqNnLFeEJL/G
         Q4YESURBvatM7pMBCWF5SVD9s3QDLO6E/En9PnF9at3muHJ2emQx9GiqO2ADZcuGln1G
         rZWh+qP/8UwB43+AAqZmUFVrkeUKr6gwsGFq8HvqWBBVo10b7iPqcF3uKZf20h4TALRI
         pPJIrp7QZNqvqkZzEP1I9CI8IU5XepngaalJL5bMHMAQD9zqldQeCSUifMVrbcyHc9bo
         YHTv1FvepTvqzh5mO4187luehb5HSGaiaSuXiJNG1seSMdDPIOw4488j3xjHCXmscWZu
         kO7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUswo+suWf3az8xdvV8FpqXuBvxrZW8SZdpFnLg5Nmq+lQKUeDZN0FNMCNmrKSvrXKnxcJ4ki8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Iw6CnQ6fGml91nSEAcxcpfTwB5uOpVKQS0TOkAXgKNPiu9AE
	DY9bNJ15CsWFn91xCDeRc23lGOTOH8p3s02WyHfd056Lr7no+SYiZh70ZgjQVLVgG0HjVtexgFo
	2h3NtgBI5yoaj4R8r1fwMKcKAA/jbD101pQ5eJBQbK8sMj/GvTVRXyd5kWaY=
X-Gm-Gg: AeBDies/aD7hYHMDCqkUzlpr544x0nPXwl3jS5Fw8hul5VGdDIyMuvPKyDh86nmpZsM
	Lt1Diqsi5e44J90RUUalc53CvMYrpTNFTrlSvS8yh5ArmTV0Zuf0HjHI3gnd7SBne7dvPpdaN6a
	eo2lIg2hFgXtEQQ5cmadNj1O4mNmbTc0DzPXLlPpAuflz80TF5XESanSOlkQfdazv3mDHEu6tY4
	JWNbo1z8wfKMp2J5QLiLAZ2VzfQM8RJ42biwYRNuCOQGdFz5NrkkqPHeLKiIoxRf2OcQNSOJX6o
	oMij+lKZX5ctzCshZNQCnalR5XXC7JokdZnttg9h60TYZ7Myq48ME7d+Obc2sNbrh8Ml46pNhTj
	BNGdp0fB9tLQNgXTJR5V/9ePJaJrAT9/Hfwf2R/6h9SIhDY29M+orbmcM
X-Received: by 2002:a05:6a00:140e:b0:82c:6f07:2d8e with SMTP id d2e1a72fcca58-82f0c411dfdmr6928550b3a.54.1775895146566;
        Sat, 11 Apr 2026 01:12:26 -0700 (PDT)
X-Received: by 2002:a05:6a00:140e:b0:82c:6f07:2d8e with SMTP id d2e1a72fcca58-82f0c411dfdmr6928529b3a.54.1775895146067;
        Sat, 11 Apr 2026 01:12:26 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c30ee4bsm5410996b3a.2.2026.04.11.01.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 01:12:25 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 11 Apr 2026 13:42:05 +0530
Subject: [PATCH v2 5/6] bus: mhi: host: Update the Time sync logic to read
 64 bit register value
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260411-tsc_timesync-v2-5-6f25f72987b3@oss.qualcomm.com>
References: <20260411-tsc_timesync-v2-0-6f25f72987b3@oss.qualcomm.com>
In-Reply-To: <20260411-tsc_timesync-v2-0-6f25f72987b3@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775895126; l=1869;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=MA03LnHAjOcvrM5mKxM9VHVgHQ54gpGwmJ8aVHg0TVc=;
 b=jRgjuD5LRCxWLZfAioVQJ+gfVkC0jXv7TrTMQtg8I15aCDEKaPfgMlt6HH8QUZOHDugyF2Quw
 UTTkzywMCFoD76x0XNp5OUWSL/sdKmQAZJK/Q/XW7dcwm+ohDWcxI1/
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=bcFbluPB c=1 sm=1 tr=0 ts=69da026b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=51wy-JC9mB198bzmU4IA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDA2MiBTYWx0ZWRfX2tUbjgEbFkpO
 thpAr0uwJVL4QEvQPqeRxXRXyT+SXLx6aGcE9STeBvQRKLIWdi5Sk4mz+vm3NTgZRNglJepQdNg
 PxVaFu6J9nIO6maAeTNKS4rnp+6r1SNn2vQN44wyzlscDqau9FUN1DCiyuxVKahgAY+sS0snZgM
 5fh2vttlq7f3vcCy2yqL/YDmH3Ss2Qxjbavhldz/l7IwF+E2Rpp+oggLthVw9aXEYKvGZ4BkHqp
 HG4VoywbmH+3OwjMv7521Ez+kW8CsrfhWjZB6Hqi/gkxIe7ads+unZD+/JtyBOszv62jFRam0f4
 Hq0FhWONtJ64vrAmaZqc1IbeUPynP6Jtn6ZN9QdS0iLGrSffpIzPFkiwDT5hFpcF8jTPscnIm+u
 SFiFLjiXXWXQ/AHfo3/wyEiSGSESKmIgrmYrsEYgKnVu5T5CuzlV7WYNSp9nsvtDo626XzAF8od
 333UjJ2lEI78HVxU7Ww==
X-Proofpoint-ORIG-GUID: -CiGO6-Gh5zzxkqeY8VhjRmd9uequnzW
X-Proofpoint-GUID: -CiGO6-Gh5zzxkqeY8VhjRmd9uequnzW
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
	TAGGED_FROM(0.00)[bounces-277679-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: 1A0C03DEEE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Instead of reading low and high of the mhi registers twice use 64 bit
register value to avoid any time penality.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/bus/mhi/host/main.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index 99917593e1da06f1dece7b5b0037c2485953410f..e853419a0195dff4a18123631cb1f74242ab4428 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -1643,6 +1643,7 @@ static int mhi_get_remote_time(struct mhi_controller *mhi_cntrl, struct mhi_time
 			       struct mhi_timesync_info *time)
 {
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	u64 val = U64_MAX;
 	int ret, i;
 
 	if (!mhi_tsync && !mhi_tsync->time_reg) {
@@ -1680,15 +1681,25 @@ static int mhi_get_remote_time(struct mhi_controller *mhi_cntrl, struct mhi_time
 	 * transition to L0.
 	 */
 	for (i = 0; i < MHI_NUM_BACK_TO_BACK_READS; i++) {
-		ret = mhi_read_reg(mhi_cntrl, mhi_tsync->time_reg,
-				   TSC_TIMESYNC_TIME_LOW_OFFSET, &time->t_dev_lo);
-
-		ret = mhi_read_reg(mhi_cntrl, mhi_tsync->time_reg,
-				   TSC_TIMESYNC_TIME_HIGH_OFFSET, &time->t_dev_hi);
+		if (mhi_cntrl->read_reg64) {
+			ret = mhi_read_reg64(mhi_cntrl, mhi_tsync->time_reg,
+					     TSC_TIMESYNC_TIME_LOW_OFFSET, &val);
+		} else {
+			ret = mhi_read_reg(mhi_cntrl, mhi_tsync->time_reg,
+					   TSC_TIMESYNC_TIME_LOW_OFFSET, &time->t_dev_lo);
+
+			ret = mhi_read_reg(mhi_cntrl, mhi_tsync->time_reg,
+					   TSC_TIMESYNC_TIME_HIGH_OFFSET, &time->t_dev_hi);
+		}
 	}
 
 	time->t_host_post = ktime_get_real();
 
+	if (mhi_cntrl->read_reg64) {
+		time->t_dev_lo = (u32)val;
+		time->t_dev_hi = (u32)(val >> 32);
+	}
+
 	local_irq_enable();
 	preempt_enable();
 

-- 
2.34.1


