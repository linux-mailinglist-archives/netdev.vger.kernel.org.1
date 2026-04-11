Return-Path: <netdev+bounces-277675-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKm6AJcC2mlJxwgAu9opvQ
	(envelope-from <netdev+bounces-277675-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 10:13:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE413DEE96
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 10:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 095F13041A4D
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 08:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1C0332917;
	Sat, 11 Apr 2026 08:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A8MA1lbQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bstDFHAt"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C96311592
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 08:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775895138; cv=none; b=sJpZ4VaEd/Ke3pNRDn9pMxfHFrd6loXiV7aMboIUMeONoR4p3jitl0QXowSH9DQwm26jEJVauL3QODZcTfXtT5EqC92AcuhD71eW6gOg/mBg0cEJYLU3j34DxcATz+oOENs3sPMJDVDlsUe6Hguh+D3XgJLe6ppvUkKgQnAQ/LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775895138; c=relaxed/simple;
	bh=3a8TUl1dQ0S0h3oatpyxG08CdJQRPxzQh5LyNap7d2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qwEqU+NXj4ihSlMdSOLazbm1IF5OO1R1sbW+mrNU/Pw1oLstqhHF/6jJb6P2H76djS3K6pKPLRX2RqVkTMwxuyILsZQS2HTuSyc4dc/6yj5nquL5HVevPQ6FHAGtJts+Catwj1TLc+osz2CTuR9vPr3jvhBLAywlo1siLuMZNTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A8MA1lbQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bstDFHAt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63B41T493377210
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 08:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MlsORWSzS43C2/u9+s1RQMidjzjxy+7KRr8E80PaZNs=; b=A8MA1lbQZjJU5VwA
	B/Pp8H9YrVbQ5fp0jtEoYgsJZrqu01HhEGSN5A34cda0s6+kwvEY5vzvl6U0I4Tn
	S4H+9Nj0QZ3485Em9X54FazmM8rX2ESeNJZFkDEu0Wo5LJdbvLActL5LL8WG7JXz
	J0Wky4fGJBdD1BXrVOwQydF5IgqAxYljQOur0YtSoNhWbkTt0WCOzNt32RTV1FoX
	Xgw+SW7O1lbJwuuq6Su85QKkOzhUrU7+vHVGyd3ieqYqdYsSsDNkaw2YIRjZ9fhT
	cI/joAIK0cNC3uwDy720kEpODvO7dl4mpQRf5+ckWuMBJOIQOkGuRBFZhQqiFtun
	UKngPg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfewkrbxn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 08:12:15 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b6097ca315bso3947045a12.3
        for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 01:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775895135; x=1776499935; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MlsORWSzS43C2/u9+s1RQMidjzjxy+7KRr8E80PaZNs=;
        b=bstDFHAtdgWfH/SJAb9q8L4J22YgkNysjK0PYDBO8C39tEyEsYp95qlQxL8NuCVsGi
         kekT//ATF/7kGTqjlqjO/wCwpMDrlRWSmsI59ZLeQsE3TkjuNzu1r65DciSuK4k8A5Yo
         XfyDEWJv2WBF2cDwFgsGgfi7m2rKh8X72WMXrZjNMID8HHcGuQyjzayYVjeJJ9VN39a2
         DchSs4vKhM+1QKded5LARR/51oMFnOwYvd3TveF2RR9DuRuoNSwUzv5g20qRJ8Og90rB
         Gk/L+kQnoSeYMZ0xtI2T5Omgn39X0MFnALcqQKidJOb9+WodV8juabOg/F2NY2E8823f
         Tvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775895135; x=1776499935;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MlsORWSzS43C2/u9+s1RQMidjzjxy+7KRr8E80PaZNs=;
        b=UwTTe/cGmZN4cUX5iFlRc0qaOekQw2FRjd6O4crjR3S3yHA4DgU8rAwifp5fY3kPXj
         kGyTFg8gG2dA+xEKx6ti5aZQnYek/owC3mS1Ql9VrNVM/HvQZ6BNlTj8HvGhlpudHq3Q
         l2ZMQFGcslRZb5+z7MZH2Xvx31yacRfK89LBmMHVckPmQN0pc1pXOLwQg6IY3RWIqM/r
         JLGVn1zzqfT54Gg4e1F9a6gKzemWlW8pHzji6gRFL5ZPqWOaq5RcXxnEmTt+XR5NCkgU
         6mw7DsF0TJVjY7IO1HXvTdxyrAQJR0smeSF+bFKPVdOrkCFgFgNA1kNddojNPd55MjRr
         ynDg==
X-Forwarded-Encrypted: i=1; AJvYcCUC4dsbqAC2i/oktPGXIE0n2/ecoobaHf1FgEEQRRJsDW/To07ePqQyqMaZcqOYRXxZpuEGcM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOb8TnlSzQNeZOm1yNJ5apz+iQ009RJWX8Nm9FUc6S0Or3tHuT
	gBvxXkFsIq8HwmLmQge1KtnmmH6fA74EgRbL7ygO7Ct/3FifSaILH78jH5mMOpJ25LxcBC0LQtO
	DrXi66M7Xydz6ADUHQz/MtKbAUFiL9zrZ/Z6vi9G13C5iEU04DmtSjFmq0zg=
X-Gm-Gg: AeBDies9e1WTcYUQHrLyncCIhnlRel20rJBcAael7burLADaekMtrU9rTq9Gnmyf7sC
	4uv4MIGgeR4Uw8frKth3Zv+frQInn6VMCl7pGnKdT52w5pPU/deas8rk/n0cqccQ4ObHcIQDvdH
	bZqiiB6kgrU9m2e3Zpq8I1mlQHp7EXo141uEg0lJ63wnA+eDj5z/OzjbXtVs55ik+oHa9xL0XqH
	XPMnldQYZbtvvdbHX3KTNSApJDdVGcgDkmn+gsGjhNsY9pAm5ZCrfUrDow69jxiEu5NLr7NSij3
	bbfqCDhzsolm9h+LDngOJhQoKRz3SCM9SneYGCZ+a2XTjk3uP6Z26+6Xd9WslQKRH+0ChaXQklE
	lt0+8CTG7cRTT27pcSEVq8EPkBayrRUOfRGZLUnErt783M2+5Wh5eX673
X-Received: by 2002:a05:6a00:1c97:b0:81f:3f03:6846 with SMTP id d2e1a72fcca58-82f0c2e66cdmr6952766b3a.47.1775895134769;
        Sat, 11 Apr 2026 01:12:14 -0700 (PDT)
X-Received: by 2002:a05:6a00:1c97:b0:81f:3f03:6846 with SMTP id d2e1a72fcca58-82f0c2e66cdmr6952749b3a.47.1775895134250;
        Sat, 11 Apr 2026 01:12:14 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c30ee4bsm5410996b3a.2.2026.04.11.01.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 01:12:13 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 11 Apr 2026 13:42:01 +0530
Subject: [PATCH v2 1/6] bus: mhi: host: Add support to read MHI
 capabilities
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260411-tsc_timesync-v2-1-6f25f72987b3@oss.qualcomm.com>
References: <20260411-tsc_timesync-v2-0-6f25f72987b3@oss.qualcomm.com>
In-Reply-To: <20260411-tsc_timesync-v2-0-6f25f72987b3@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>,
        Sivareddy Surasani <sivareddy.surasani@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775895126; l=3194;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=gnNbZhbZEhvqLJecAEOrjJ12J5oG7SczP2aDECvLgc0=;
 b=Qgo7AFj5IL2iftDW+lMYx6bXx1SomzUp+kkF5WTuOS4YTqFAtWOWrcD0ZbkbfUrloFSLJ7vcm
 c6ogPo5KK35BK7qKQ+z0u+25rGN01ZMHvY+2fu/ZrPSP33UzOb8NBFp
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=bcFbluPB c=1 sm=1 tr=0 ts=69da025f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=CnzCB1l8zP_khqs2e6IA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDA2MiBTYWx0ZWRfX+vPZpUq+qtGL
 Mc3XMMAbEnk9vZ7GatM7h1eq4fZpPd7H9Qr9vsj/yTyQP+I3QLaVTjI3DHyx0V441wUjSZ0xMAq
 z+Jswr4MoOAuc0oCB27NxwPZZZ3T6YlGdtOy3vob06I6ALdld+QLUlRJsgVGtXXp+Et4hX3ikfv
 6Z+qQjiTEbkkrbOfiLbn/DaI022gEUXexAvL9SlDm9KJEBs/ova2gPRpePKIdzSJYIvE8vP7c9M
 8BIojyEVJPVXFw6zNkCoQjSaaRqPt+Lo3Vlb7NQJjfQcoo+Xh+jaSkhdOtVHpYRDnYekmOHgzNB
 RXuuSStZeCeIZMGD8FHtJNtKD8kwF7iNsT1k69M5VDiRVTkRqePJtsKPKw60WfixMF0wDOfWXpb
 Pqy57XDStO1r+AgyX3IlbR/Jiu9a7CVNSkzvyTRRetwtOihLgTF/ayz5O4sqyDqfDwJTgLA4P5E
 au8BCyp85AjGBp6YlKw==
X-Proofpoint-ORIG-GUID: kQfatcWZDEogruSym2OSy2cWGXpGsO26
X-Proofpoint-GUID: kQfatcWZDEogruSym2OSy2cWGXpGsO26
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
	TAGGED_FROM(0.00)[bounces-277675-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7AE413DEE96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>

As per MHI spec v1.2,sec 6.6, MHI has capability registers which are
located after the ERDB array. The location of this group of registers is
indicated by the MISCOFF register. Each capability has a capability ID to
determine which functionality is supported and each capability will point
to the next capability supported.

Add a basic function to read those capabilities offsets.

Signed-off-by: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
Signed-off-by: Sivareddy Surasani <sivareddy.surasani@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/bus/mhi/common.h    | 11 +++++++++++
 drivers/bus/mhi/host/init.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
index dda340aaed95a5573a2ec776ca712e11a1ed0b52..4c316f3d5a68beb01f15cf575b03747096fdcf2c 100644
--- a/drivers/bus/mhi/common.h
+++ b/drivers/bus/mhi/common.h
@@ -16,6 +16,7 @@
 #define MHICFG				0x10
 #define CHDBOFF				0x18
 #define ERDBOFF				0x20
+#define MISCOFF				0x24
 #define BHIOFF				0x28
 #define BHIEOFF				0x2c
 #define DEBUGOFF			0x30
@@ -113,6 +114,9 @@
 #define MHISTATUS_MHISTATE_MASK		GENMASK(15, 8)
 #define MHISTATUS_SYSERR_MASK		BIT(2)
 #define MHISTATUS_READY_MASK		BIT(0)
+#define MISC_CAP_MASK			GENMASK(31, 0)
+#define CAP_CAPID_MASK			GENMASK(31, 24)
+#define CAP_NEXT_CAP_MASK		GENMASK(23, 12)
 
 /* Command Ring Element macros */
 /* No operation command */
@@ -204,6 +208,13 @@
 #define MHI_RSCTRE_DATA_DWORD1		cpu_to_le32(FIELD_PREP(GENMASK(23, 16), \
 							       MHI_PKT_TYPE_COALESCING))
 
+#define MHI_CAP_ID_INTX			0x1
+#define MHI_CAP_ID_TIME_SYNC		0x2
+#define MHI_CAP_ID_BW_SCALE		0x3
+#define MHI_CAP_ID_TSC_TIME_SYNC	0x4
+#define MHI_CAP_ID_MAX_TRB_LEN		0x5
+#define MHI_CAP_ID_MAX			0x6
+
 enum mhi_pkt_type {
 	MHI_PKT_TYPE_INVALID = 0x0,
 	MHI_PKT_TYPE_NOOP_CMD = 0x1,
diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index 0a728ca2c494836b0e0ce4c3f4aea41794c0868b..c2162aa04e810e45ccfbedd20aaa62f892420d31 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -466,6 +466,38 @@ static int mhi_init_dev_ctxt(struct mhi_controller *mhi_cntrl)
 	return ret;
 }
 
+static int mhi_find_capability(struct mhi_controller *mhi_cntrl, u32 capability)
+{
+	u32 val, cur_cap, next_offset, cur_offset;
+	int ret;
+
+	/* Get the first supported capability offset */
+	ret = mhi_read_reg_field(mhi_cntrl, mhi_cntrl->regs, MISCOFF, MISC_CAP_MASK, &cur_offset);
+	if (ret)
+		return 0;
+
+	do {
+		if (cur_offset >= mhi_cntrl->reg_len)
+			return 0;
+
+		ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, cur_offset, &val);
+		if (ret)
+			return 0;
+
+		cur_cap = FIELD_GET(CAP_CAPID_MASK, val);
+		next_offset = FIELD_GET(CAP_NEXT_CAP_MASK, val);
+		if (cur_cap >= MHI_CAP_ID_MAX)
+			return 0;
+
+		if (cur_cap == capability)
+			return cur_offset;
+
+		cur_offset = next_offset;
+	} while (next_offset);
+
+	return 0;
+}
+
 int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
 {
 	u32 val;

-- 
2.34.1


