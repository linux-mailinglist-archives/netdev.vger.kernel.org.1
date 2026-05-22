Return-Path: <netdev+bounces-290758-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JeuG/cqEGofUgYAu9opvQ
	(envelope-from <netdev+bounces-290758-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 12:07:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF26E5B1B32
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 12:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3413301911D
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 10:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973E13C65E0;
	Fri, 22 May 2026 10:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RlcEFI4D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S6rRghFB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F8B32AAC6
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779444103; cv=none; b=Z9H7vLX/qHyR5kW/QymoZ4MgdVCLm7HXhi8RmSDXu/lI2PEF5XRNxVysjc67wff+u+W6/g0xTenqUIiT5+rJUfyMU6QNFpelkU/6JFCqcGDM7ygrGYyAzadl9SOLutJ4yiROwXoV8SVgEGQMtRFO8hh9h7FW5cbpvX/hP66l0FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779444103; c=relaxed/simple;
	bh=iFHxbTO6wE35Tl3kqwnkO8A1IQ+NptFsGOPDlaw/GEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c03T68UtDJMEdoJtWZqrKLGKtybwKwQWRhBXZJsWG5AvfoNGbuIPGWTpsYlsoVyVt7+fXRdAeJpThBTCFUZDoPKQedtA8weh1JZT+jka9fmRrw+Rgj5DqLo7gADkNsZj2nTxqsbtAPkQec4mpSvxDNAVfCOnVisIrVxc6+0QMtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RlcEFI4D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S6rRghFB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M8d9KF3673893
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 10:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5DXeyrdoWr0DcgBTdRbVLV0jwA0imqVGVhlRKg6Geqg=; b=RlcEFI4DbYPXiWK4
	QIlBKbaRJedey4Bt6BSXn+z+qgw4dOjuyVZIn6+f4an/HrlkBJNeKn0426wyIWID
	DWGe0brdpGtxASKeEc9MAkgbfRunDdZwezz8A0DGQgex6gFV8Z2extNKtZ/1dmYL
	ZZOtc7ZT1PobKIdaS79++SrbhMjyh+cve2dXWjCyGPU5OGYMvMqND7Lxoke7LbzA
	cT5AtlMq/0QACA3d8DTQ/PMFAU489910ptdIyDy99iyevn9v2c1GnzjVbNN+aOaR
	h5D9tH3ylLKZkfS5CetSbU3z4mGceFP11qQRbDBZT81idOZgoyyuY7BTPDWutLQo
	FHdDAA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea4dc4739-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 10:01:41 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c8514f8ed5dso1211203a12.3
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 03:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779444101; x=1780048901; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5DXeyrdoWr0DcgBTdRbVLV0jwA0imqVGVhlRKg6Geqg=;
        b=S6rRghFBbJItgBcWY5uWIWg/CD9m8wnT5tqMvDLhIxxrRiHNlCkthyqVCkKSy5s0Rv
         R7hfCktXTZEIZsFIExPv29G3YN5PgPH2SaHQVfKmux9x7z9ttoxMlpc8Prry7/MwPB8D
         t4+pt1AfVkOa0sNIGhEgek70Z9WZHuj9e/wIxj3QioVkCn4kNoVYPHEPDvzMvHZj5WLS
         AOT+wlT1lxgOjwyA7yx739eUIp/QUmcH6p30v+EN+PKkNU8mLzdSjZ9Yc52nySm+llMO
         W8nDlaAoxsPFFDNjLyZrM0uh+n5Bld/91Dy/naTLDs+4F8TNwvgIQ6pRHDbhvkdl0TEC
         OYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779444101; x=1780048901;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5DXeyrdoWr0DcgBTdRbVLV0jwA0imqVGVhlRKg6Geqg=;
        b=bpKw627+rKi+DR8mShUvxajcresE0MwjVM3wIBqZ+GaX/t+wvywEQ774Zz+m0bP+ee
         PEsSYa3gjH8jA63SmiwFRn5QsyHM5t6wVck2F7uaynURg6UOmPPCYgovyq1aYUvyClWl
         9E/FLgY7i11PKNqaehdMNOIQsayire88jSwEQ5m/FUtzhjug4iVoI5DIlMY+DerpwHQO
         yPr3mZne2LC/z6szqYLNgUCefpH/dUvLoEPWSUjADDrDB/Vayg3Per28XnrUuzBXPsH5
         SciVmpc/Q1hgeKTTys8qMniPluyOYQeUuJTzEOW8GJM84tv7niiVhm5taA80ermsZyXD
         /kWg==
X-Forwarded-Encrypted: i=1; AFNElJ+OunJBX3ITDgCWnB/amPzj9okkwd4IRqFP7hlo6aGEmqH5QIyV/vZTrOxDKCAS517ztB2um7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWlHAemZMgV80+AgN+lEn4wtLF1yiA06zP2QOsiZlz2L/B7nZr
	TQILaWRg7iwRtACJNYiGh22Cco6Betz7n2uW4rgJGbtfondXWLltXAAqo6RqfK3JWzDrGAqq5MC
	GzidoLfiC0zyiQ2SPCODU8oe1eMnvUup/chO0z/7Xm7nX4UGZGryGwhrQA1A=
X-Gm-Gg: Acq92OHEyZjAETXQhknRWKOdUJHP8ZDfwroJaYP0BfVzTxpNjiVZqXe5M/lTQa49SvQ
	iB4yRYgEPV96/xfM6OmBL4omQJ5U+x2nZP/uMSH4dTgQJYO0q3GYITyJMc4V84V65+itlnRk2mn
	zM17p3sKMluJ4HoTLwNBiHnGQGot410QHPsHcP1ZGl0h7t3lPWvK5rnCM5Q0EvwRcX9Hk4RQQCX
	8Wnig+lIT51uphoQiu9ER5TB7MWq8x4g0SmXy+lJIo0Rfn1mRdBlgw5llGIHouh8V3rncxbPUNc
	56gCfF4fzlmOG5L55tuABM6Sm4p8usvo8Sqn53MaQGzwsoKX9oaNbj/8edKa/hzW3Yqyv4AGoEN
	zL4gaM4/WmssgYy5GaFGJJQ61xfOXGIQK/U77h8xR747tfcOTYTbL69j+K/Ik97KefXw=
X-Received: by 2002:a05:6a00:bd11:b0:82f:24e:6a48 with SMTP id d2e1a72fcca58-8415f2e0caamr3187452b3a.5.1779444100462;
        Fri, 22 May 2026 03:01:40 -0700 (PDT)
X-Received: by 2002:a05:6a00:bd11:b0:82f:24e:6a48 with SMTP id d2e1a72fcca58-8415f2e0caamr3187406b3a.5.1779444099822;
        Fri, 22 May 2026 03:01:39 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ac9b74sm1516641b3a.3.2026.05.22.03.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 03:01:39 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:30:37 +0530
Subject: [PATCH v2 6/6] bus: mhi: host: Fix runtime PM ownership between
 clients and controller
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-mhi_runtimepm-v2-6-fbebf41a82bb@oss.qualcomm.com>
References: <20260522-mhi_runtimepm-v2-0-fbebf41a82bb@oss.qualcomm.com>
In-Reply-To: <20260522-mhi_runtimepm-v2-0-fbebf41a82bb@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, netdev@vger.kernel.org,
        mayank.rana@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        vivek.pernamitta@oss.qualcomm.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779444039; l=7532;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=iFHxbTO6wE35Tl3kqwnkO8A1IQ+NptFsGOPDlaw/GEs=;
 b=Leraca11cxKZ9kv0wOGI3YHGBWBAYMU7jDrEbEBi0YqgqfKAQk5bm2D7Lfh9uEh0W7ZzT5vKK
 DtD9ugdBFwRClFNTiqzjFY0NRel2cgOG3a2qFCZJSiB8OgzBE27Wzzh
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=VefH+lp9 c=1 sm=1 tr=0 ts=6a102985 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=A8rfxp3GyOsx1I41rDQA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: tByciXYqjp-5iCBBw9QvAW7Z4JSEzNiA
X-Proofpoint-ORIG-GUID: tByciXYqjp-5iCBBw9QvAW7Z4JSEzNiA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5OSBTYWx0ZWRfX2XWbCHI4wIaJ
 G/uRJJHQK9BAlV2GNC0OF6L5smgGmqDzOI+42enLYQc5Tnf/zoZF2IGhDNrTU/o1ppQB4swizvd
 gI9d26QrI0Wj8TBNNSPkckxg4yxYVqFg2aztY9K04kjt2X8RRMpZAmR13qhki3LaATaOwuWKX6x
 5p5hE9fgaUJ+ywuoDkgDplv5uZdSY2lcXj7Qa+PujZJnADdLsDcbJL6nE2pr7+RRs54lKHZKjl4
 nxnDmvZ5xiIHjQ9qnX9D6x7289yJ2d9spGPAAgfESA6IcO//MPju+bUC9BKEggCutYkA6USVnkK
 5RnN1ZzSlYC4nvyNrUCWqexmK4VZbSTdUaVevpj5C/sbT7Q282ZbMG2uOWd2VileLbopOyIsFT8
 kcOUkqfnU/upT51gAio9Wg+4nfkfPKUpa/A5b8JeFalcgwVHJU0clf9VI8By8ifad9EHfKkMjsz
 ncziEkcgEq7UZOwXIwQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220099
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290758-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,oss.qualcomm.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,sipsolutions.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krishna.chundru@oss.qualcomm.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DF26E5B1B32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The current MHI runtime PM model allows the core to take power references
directly on the controller device without visibility into client driver
activity. As a result, a controller driver may runtime-suspend the
hardware while one or more MHI client devices are still actively in use.

This happens because the MHI core historically managed runtime PM
internally, rather than relying on standard parent-child PM dependency
tracking. The controller driver therefore has no way to infer whether MHI
clients still require the controller to remain active.

Fix this by enabling runtime PM on the MHI bus device (mhi_dev) and routing
runtime PM references through it. Client drivers now hold runtime PM
references on their own mhi_dev, allowing the PM framework to naturally
propagate activity to the controller via the device hierarchy.

The existing mhi_device_get_sync() and mhi_device_put() helpers are
retained, as they serve as the synchronization point between the MHI power
state machine and runtime PM, combining runtime PM reference management
with MHI wake handling.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/bus/mhi/host/init.c     |  3 +++
 drivers/bus/mhi/host/internal.h |  6 +++---
 drivers/bus/mhi/host/main.c     | 26 ++------------------------
 drivers/bus/mhi/host/pm.c       | 18 ++++++++----------
 4 files changed, 16 insertions(+), 37 deletions(-)

diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index 9f3ee4a14418..002f3abb8103 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -1034,6 +1034,9 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
 
 	mhi_cntrl->mhi_dev = mhi_dev;
 
+	pm_runtime_no_callbacks(&mhi_cntrl->mhi_dev->dev);
+	devm_pm_runtime_set_active_enabled(&mhi_cntrl->mhi_dev->dev);
+
 	mhi_create_debugfs(mhi_cntrl);
 
 	return 0;
diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
index a7493aabc6fa..434ed4705d25 100644
--- a/drivers/bus/mhi/host/internal.h
+++ b/drivers/bus/mhi/host/internal.h
@@ -354,9 +354,9 @@ static inline bool mhi_is_active(struct mhi_controller *mhi_cntrl)
 static inline void mhi_trigger_resume(struct mhi_controller *mhi_cntrl)
 {
 	pm_wakeup_event(&mhi_cntrl->mhi_dev->dev, 0);
-	pm_runtime_get(mhi_cntrl->cntrl_dev);
-	pm_runtime_mark_last_busy(mhi_cntrl->cntrl_dev);
-	pm_runtime_put(mhi_cntrl->cntrl_dev);
+	pm_runtime_get(&mhi_cntrl->mhi_dev->dev);
+	pm_runtime_mark_last_busy(&mhi_cntrl->mhi_dev->dev);
+	pm_runtime_put(&mhi_cntrl->mhi_dev->dev);
 }
 
 /* Register access methods */
diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index 71919c2e9462..f0b09657de29 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -658,12 +658,8 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
 			/* notify client */
 			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
 
-			if (mhi_chan->dir == DMA_TO_DEVICE) {
+			if (mhi_chan->dir == DMA_TO_DEVICE)
 				atomic_dec(&mhi_cntrl->pending_pkts);
-				/* Release the reference got from mhi_queue() */
-				pm_runtime_mark_last_busy(mhi_cntrl->cntrl_dev);
-				pm_runtime_put(mhi_cntrl->cntrl_dev);
-			}
 
 			read_lock_bh(&mhi_chan->lock);
 		}
@@ -1135,12 +1131,6 @@ static int mhi_queue(struct mhi_device *mhi_dev, struct mhi_buf_info *buf_info,
 
 	read_lock_irqsave(&mhi_cntrl->pm_lock, flags);
 
-	/* Packet is queued, take a usage ref to exit M3 if necessary
-	 * for host->device buffer, balanced put is done on buffer completion
-	 * for device->host buffer, balanced put is after ringing the DB
-	 */
-	pm_runtime_get(mhi_cntrl->cntrl_dev);
-
 	/* Assert dev_wake (to exit/prevent M1/M2)*/
 	mhi_cntrl->wake_toggle(mhi_cntrl);
 
@@ -1150,11 +1140,6 @@ static int mhi_queue(struct mhi_device *mhi_dev, struct mhi_buf_info *buf_info,
 	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl)))
 		mhi_ring_chan_db(mhi_cntrl, mhi_chan);
 
-	if (dir == DMA_FROM_DEVICE) {
-		pm_runtime_mark_last_busy(mhi_cntrl->cntrl_dev);
-		pm_runtime_put(mhi_cntrl->cntrl_dev);
-	}
-
 	read_unlock_irqrestore(&mhi_cntrl->pm_lock, flags);
 
 	return ret;
@@ -1355,7 +1340,6 @@ static int mhi_update_channel_state(struct mhi_controller *mhi_cntrl,
 	ret = mhi_device_get_sync(mhi_cntrl->mhi_dev);
 	if (ret)
 		return ret;
-	pm_runtime_get(mhi_cntrl->cntrl_dev);
 
 	reinit_completion(&mhi_chan->completion);
 	ret = mhi_send_cmd(mhi_cntrl, mhi_chan, cmd);
@@ -1386,8 +1370,6 @@ static int mhi_update_channel_state(struct mhi_controller *mhi_cntrl,
 
 	trace_mhi_channel_command_end(mhi_cntrl, mhi_chan, to_state, TPS("Updated"));
 exit_channel_update:
-	pm_runtime_mark_last_busy(mhi_cntrl->cntrl_dev);
-	pm_runtime_put(mhi_cntrl->cntrl_dev);
 	mhi_device_put(mhi_cntrl->mhi_dev);
 
 	return ret;
@@ -1525,12 +1507,8 @@ static void mhi_reset_data_chan(struct mhi_controller *mhi_cntrl,
 	while (tre_ring->rp != tre_ring->wp) {
 		struct mhi_buf_info *buf_info = buf_ring->rp;
 
-		if (mhi_chan->dir == DMA_TO_DEVICE) {
+		if (mhi_chan->dir == DMA_TO_DEVICE)
 			atomic_dec(&mhi_cntrl->pending_pkts);
-			/* Release the reference got from mhi_queue() */
-			pm_runtime_mark_last_busy(mhi_cntrl->cntrl_dev);
-			pm_runtime_put(mhi_cntrl->cntrl_dev);
-		}
 
 		if (!buf_info->pre_mapped)
 			mhi_cntrl->unmap_single(mhi_cntrl, buf_info);
diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
index f799503c8f36..278fc2ffb820 100644
--- a/drivers/bus/mhi/host/pm.c
+++ b/drivers/bus/mhi/host/pm.c
@@ -429,6 +429,7 @@ static int mhi_pm_mission_mode_transition(struct mhi_controller *mhi_cntrl)
 
 	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
 		ret = -EIO;
+		read_unlock_bh(&mhi_cntrl->pm_lock);
 		goto error_mission_mode;
 	}
 
@@ -459,11 +460,9 @@ static int mhi_pm_mission_mode_transition(struct mhi_controller *mhi_cntrl)
 	 */
 	mhi_create_devices(mhi_cntrl);
 
-	read_lock_bh(&mhi_cntrl->pm_lock);
 
 error_mission_mode:
-	mhi_cntrl->wake_put(mhi_cntrl, false);
-	read_unlock_bh(&mhi_cntrl->pm_lock);
+	mhi_device_put(mhi_cntrl->mhi_dev);
 
 	return ret;
 }
@@ -1038,9 +1037,11 @@ int __mhi_device_get_sync(struct mhi_controller *mhi_cntrl)
 		read_unlock_bh(&mhi_cntrl->pm_lock);
 		return -EIO;
 	}
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	pm_runtime_get_sync(&mhi_cntrl->mhi_dev->dev);
+	read_lock_bh(&mhi_cntrl->pm_lock);
 	mhi_cntrl->wake_get(mhi_cntrl, true);
-	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
-		mhi_trigger_resume(mhi_cntrl);
 	read_unlock_bh(&mhi_cntrl->pm_lock);
 
 	ret = wait_event_timeout(mhi_cntrl->state_event,
@@ -1049,9 +1050,7 @@ int __mhi_device_get_sync(struct mhi_controller *mhi_cntrl)
 				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
 
 	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
-		read_lock_bh(&mhi_cntrl->pm_lock);
-		mhi_cntrl->wake_put(mhi_cntrl, false);
-		read_unlock_bh(&mhi_cntrl->pm_lock);
+		mhi_device_put(mhi_cntrl->mhi_dev);
 		return -EIO;
 	}
 
@@ -1339,11 +1338,10 @@ void mhi_device_put(struct mhi_device *mhi_dev)
 
 	mhi_dev->dev_wake--;
 	read_lock_bh(&mhi_cntrl->pm_lock);
-	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
-		mhi_trigger_resume(mhi_cntrl);
 
 	mhi_cntrl->wake_put(mhi_cntrl, false);
 	read_unlock_bh(&mhi_cntrl->pm_lock);
+	pm_runtime_put(&mhi_cntrl->mhi_dev->dev);
 }
 EXPORT_SYMBOL_GPL(mhi_device_put);
 

-- 
2.34.1


