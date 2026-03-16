Return-Path: <netdev+bounces-268220-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AE7EsQ7uGmpagEAu9opvQ
	(envelope-from <netdev+bounces-268220-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:20:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C294329E05E
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9083E306B597
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 17:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A943D16F9;
	Mon, 16 Mar 2026 17:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fJ6kkfYD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KFJqYXWm"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0772C375A
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 17:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681284; cv=none; b=I7slZU7kIKZC8mJSZ0jZNTFyAImG/VeoixssseMjgNMTNSVVWR+eL+zKvMqj35NIXtNo9QWX8o3ZwqJyEqXawYrCVNpUOuPWx5rzE2O3Mgbb13ZYVYEThlGuarnTSVUr+Fb/s0RqQZeiuSYcyhKr0j7fx+N+3ddvyWTQ2CV8oTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681284; c=relaxed/simple;
	bh=RitF4X0ydyAtTX/CCYADqtg2SWdZZo+quUkjHBSz16s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNZ0U2ACUmMDwkFhABkPLHHbF0CmNTS7TimtX400rRXtvq9GqZaoFIvp7zXb0IDXk/6+Feo8aqoFy1+moQfQ4UMGFXRn5gQ6C8Xxu4ZFGbBom/RXCmhqNAbf0E3oBACgonwuqV5SV6tLIudeYlfN+ANKpBVqskjZOjdU13MeIUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fJ6kkfYD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KFJqYXWm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GG6ORv4022233
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 17:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=sttkd7eb2H2
	60gtaHPbEBYrM3UtDNGNgOFfj96PH8fA=; b=fJ6kkfYDn3KQ6shXEvD5Q3uqQR4
	8GNTg+aD9oSpshc1SUYkQ1DdIXsR0N/fcaeGfyoHV4xKEVFI7iiZXrR4hAPMskMz
	7tHgnRvZ9XXREaK5hpUww3cvqQYCIHWXt1CwDZ9F49eR7RMMwg9rYH2lvcW97zcL
	8HLQOmz75+EwnlkddogWCLGESPZIg8LjcTytuh8Wx0G1rQXbfdw8GAlCP7ZMCGjc
	1huqPLODNZdQdl4PMl8XW1afJqXFOVxIaFnaWoVN/4CJTqLXEQJS0ZYSYX6nBx5a
	6gqVa41jBh2roHre2gqdPlwNyqjeSYWQGddaUwADGLQfVlL2GccNKfDqzCw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxn3fg8su-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 17:14:42 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd8b37d4b2so186739785a.3
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773681281; x=1774286081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sttkd7eb2H260gtaHPbEBYrM3UtDNGNgOFfj96PH8fA=;
        b=KFJqYXWmT7GClAyqEnN1E2+zu7F/rC+Wi7R45zJvxkNTuTZ1rcQWfLcNkn5JJ8xhX+
         R/d8fKupRStwKcEehEMct4d9Gp3PFoh9ly9Rl9Yfr8e6q76xqXYvGvrRyNUS/tnpudSg
         rI6yLmdN1w0pJ2NNAhUtGKpOPtrtzo86K3EBeYJABrRF+IvboPz6KIBj5Fwl8TrQ3bfa
         Q3FzFaJtDFP6Kq841s0JZetTM9vJkQZ2VeVv+pIv3YIjXwMiHhQivUdmUFS9+/PQGeVT
         9D73mza6OoLYllRPK4H4pK+TwdTCAp62vaAJGOLWk1lYe3i3e7lBv4RpIQgCmO5NeErb
         kt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773681281; x=1774286081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sttkd7eb2H260gtaHPbEBYrM3UtDNGNgOFfj96PH8fA=;
        b=K1x/I1qyx2b5stRZaKVnQOnTPKXMCHV9ytcMK5blto65wZit9mLrueF5mBsVb1LD57
         63JsFtGDCg+hpB1WQdR5Mx6HQBR6A77fN4g/d5mMsYeIyNVdnW4UKUgdTPJB4kA4rkue
         UljCjx3UVN9a5isbAMC7LqLMfrAqA7SLKTbCDfTaAndmWt7fHMD1IzUZ9uKiJwpkqYGK
         kHwbThJU7Jq63zmUwnT8XROzAYqm6aTfbMY6kCknMOM+sBGA0PMb7Di0JURbj1e26f2v
         F0Gzh+JDo3ttcJL0Ze5xsVCbM5gNPF6xehDa6hCb6KJNhg/nxuCVrLkD30JfMMXU1V9x
         hH8w==
X-Forwarded-Encrypted: i=1; AJvYcCUZKL2HvuYiGA2cm4RO1EXQJ2parOLndfNQ90TCT4edYn5/mrrZLVqsKr5w/EhIBUE+SDPVdHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTOcgI20JMKXWc5dxwbv79+ErO1DnKjVB+XxGyC+w9ck3Jg/N2
	SCUMbiFJUPmC8dsqgG0HDN0LNvCQZolDba5L6HNBZviK3uuspV0V/wVRScJs3BBXl+oM8pyFuIn
	fdWCE5tpv+d8R3aSSsSBlNq/X7iJbwSI64+LdANsAUSbBLzGxsbjbPM4V1xU=
X-Gm-Gg: ATEYQzwCmHb5BmaQtZBh6ydaFJr+wHz3YYoTwLhZLjIK6K162Ud9diOTY9MAbHaN2oU
	HErD17tdYl4itn0ueWzj0zef6yGGy8htRz/+WPSLx8qqfhNfE6dnCKIU+9+/5oSwy/LxnnW9vEz
	X2x20zkl4jNH/mGSzVXxKPRvvRkMwyjxYMLL27pJBauD5wJxKA6rGpFHPP5c4jhZVGuKL7C/oZM
	OzPB6b0Im15AA1++2i7L6pNBAWlmrG28lK61alABeowmYWfd/q0gGAoyTPG7CapdR3Gns/b+12+
	QJM1o9lH406a89sluG8t8qmspRI838c1uPIaxVT542VX55C3nRDdkJKM9R81n7QbQ1FgVSErrAN
	sBOaFGL1AV8xc/Btp0L7vxWhTGgNkV7kOHd+gj1of8cMtqfsdmw==
X-Received: by 2002:a05:620a:1707:b0:8cd:b2e9:b964 with SMTP id af79cd13be357-8cdb5a0c51bmr1603120285a.10.1773681281485;
        Mon, 16 Mar 2026 10:14:41 -0700 (PDT)
X-Received: by 2002:a05:620a:1707:b0:8cd:b2e9:b964 with SMTP id af79cd13be357-8cdb5a0c51bmr1603116085a.10.1773681280946;
        Mon, 16 Mar 2026 10:14:40 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:5dfc:3995:22ce:d286])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20b544sm43860993f8f.20.2026.03.16.10.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:14:40 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: konradybcio@kernel.org, andersson@kernel.org
Cc: linux-kernel@vger.kernel.org, Alex Elder <elder@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jeff Johnson <jjohnson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kees Cook <kees@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-sound@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 2/4] wifi: ath: Use the unified QMI service ID instead of defining it locally
Date: Mon, 16 Mar 2026 18:14:12 +0100
Message-ID: <20260316171419.2619620-3-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316171419.2619620-1-daniel.lezcano@oss.qualcomm.com>
References: <20260316171419.2619620-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=C5bkCAP+ c=1 sm=1 tr=0 ts=69b83a82 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=DFXFU3FfpSgEbJi8yTMA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: s5voKNLbq7ZPd-sczLgqMiN6jNrQb7Ee
X-Proofpoint-ORIG-GUID: s5voKNLbq7ZPd-sczLgqMiN6jNrQb7Ee
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEzMyBTYWx0ZWRfX7i9Z92hfixh9
 G5l3wxfznR8Nc0X2J7ju5d0daNN7UwH/rQPlUiBw6rtUZaVFImSEr3t6dM3oyqQs2P6qzwwivuh
 +wZwB8zjm9Pb2hXF5Sro52KLv6UQwH9gJQtd2H0cet/SyYRH9So9Jyb6S02G8bB3q4zbrmjojVH
 COfMfY3kShbK5J03JbghA4pyLfZnOwm2jFV4+d1x0503nqbe4G8NHEvzrEZ38K2yGTCIFb6bsr0
 +ra6MlxrqKxicSclVG/vfIfSjXiW6lIRGsefXi0PqNtQCfCgx+p26tZnonSqWNxMSPiyu0aOBJS
 NBKVDpMTqXTFa7fjWFEo57tYUiz9UhizzxuRjNQ6FDp1K55Gx2cYJtqKd0dxLVC5ln7kkMueHYR
 YdIx0aMNrhQvoXN3y6eYEa5RJvoulyTWBFQaUqgdl4tKlqkRCuqekebz6o3062CSHZlcXZzq9hA
 lK8+PucTlHe1dhAIw/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160133
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268220-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.lezcano@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C294329E05E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Instead of defining a local macro with a custom name for the QMI
service identifier, use the one provided in qmi.h and remove the
locally defined macro.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath10k/qmi.c          | 2 +-
 drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.h | 1 -
 drivers/net/wireless/ath/ath11k/qmi.c          | 2 +-
 drivers/net/wireless/ath/ath11k/qmi.h          | 1 -
 drivers/net/wireless/ath/ath12k/qmi.c          | 2 +-
 drivers/net/wireless/ath/ath12k/qmi.h          | 1 -
 6 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
index eebd78e7ff6b..4fdd0af415d5 100644
--- a/drivers/net/wireless/ath/ath10k/qmi.c
+++ b/drivers/net/wireless/ath/ath10k/qmi.c
@@ -1105,7 +1105,7 @@ int ath10k_qmi_init(struct ath10k *ar, u32 msa_size)
 	spin_lock_init(&qmi->event_lock);
 	INIT_WORK(&qmi->event_work, ath10k_qmi_driver_event_work);
 
-	ret = qmi_add_lookup(&qmi->qmi_hdl, WLFW_SERVICE_ID_V01,
+	ret = qmi_add_lookup(&qmi->qmi_hdl, QMI_SERVICE_ID_WLFW,
 			     WLFW_SERVICE_VERS_V01, 0);
 	if (ret)
 		goto err_qmi_lookup;
diff --git a/drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.h b/drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.h
index 9f311f3bc9e7..88d58f78989d 100644
--- a/drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.h
+++ b/drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.h
@@ -7,7 +7,6 @@
 #ifndef WCN3990_QMI_SVC_V01_H
 #define WCN3990_QMI_SVC_V01_H
 
-#define WLFW_SERVICE_ID_V01 0x45
 #define WLFW_SERVICE_VERS_V01 0x01
 
 #define QMI_WLFW_BDF_DOWNLOAD_REQ_V01 0x0025
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index feebbc30f3df..1397756d6251 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -3337,7 +3337,7 @@ int ath11k_qmi_init_service(struct ath11k_base *ab)
 	spin_lock_init(&ab->qmi.event_lock);
 	INIT_WORK(&ab->qmi.event_work, ath11k_qmi_driver_event_work);
 
-	ret = qmi_add_lookup(&ab->qmi.handle, ATH11K_QMI_WLFW_SERVICE_ID_V01,
+	ret = qmi_add_lookup(&ab->qmi.handle, QMI_SERVICE_ID_WLFW,
 			     ATH11K_QMI_WLFW_SERVICE_VERS_V01,
 			     ab->qmi.service_ins_id);
 	if (ret < 0) {
diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
index 7968ab122b65..eae416db8b52 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.h
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -15,7 +15,6 @@
 #define ATH11K_QMI_MAX_BDF_FILE_NAME_SIZE	64
 #define ATH11K_QMI_CALDB_ADDRESS		0x4BA00000
 #define ATH11K_QMI_WLANFW_MAX_BUILD_ID_LEN_V01	128
-#define ATH11K_QMI_WLFW_SERVICE_ID_V01		0x45
 #define ATH11K_QMI_WLFW_SERVICE_VERS_V01	0x01
 #define ATH11K_QMI_WLFW_SERVICE_INS_ID_V01	0x02
 #define ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_QCA6390	0x01
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index c11b84b56f8f..f31cba7af722 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -4061,7 +4061,7 @@ int ath12k_qmi_init_service(struct ath12k_base *ab)
 	spin_lock_init(&ab->qmi.event_lock);
 	INIT_WORK(&ab->qmi.event_work, ath12k_qmi_driver_event_work);
 
-	ret = qmi_add_lookup(&ab->qmi.handle, ATH12K_QMI_WLFW_SERVICE_ID_V01,
+	ret = qmi_add_lookup(&ab->qmi.handle, QMI_SERVICE_ID_WLFW,
 			     ATH12K_QMI_WLFW_SERVICE_VERS_V01,
 			     ab->qmi.service_ins_id);
 	if (ret < 0) {
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index b5a4a01391cb..2a63e214eb42 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -15,7 +15,6 @@
 #define ATH12K_QMI_MAX_BDF_FILE_NAME_SIZE	64
 #define ATH12K_QMI_CALDB_ADDRESS		0x4BA00000
 #define ATH12K_QMI_WLANFW_MAX_BUILD_ID_LEN_V01	128
-#define ATH12K_QMI_WLFW_SERVICE_ID_V01		0x45
 #define ATH12K_QMI_WLFW_SERVICE_VERS_V01	0x01
 #define ATH12K_QMI_WLFW_SERVICE_INS_ID_V01	0x02
 #define ATH12K_QMI_WLFW_SERVICE_INS_ID_V01_WCN7850 0x1
-- 
2.43.0


