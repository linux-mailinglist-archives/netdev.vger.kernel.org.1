Return-Path: <netdev+bounces-265792-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMU8C99Sr2m/UAIAu9opvQ
	(envelope-from <netdev+bounces-265792-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 00:08:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A40BA24289C
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 00:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2D413033899
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 23:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F4742885A;
	Mon,  9 Mar 2026 23:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cR9bULr3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g8XOX31C"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330204279E0
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 23:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773097568; cv=none; b=VkgBD+NP22oj8qYKBeEuQfKIbe96kL6D5nTcHwDGWT6TUJTemSgAAxypRxO7KdPrUfOBv2KPE7fLjzETVBGU/nr/KE3p6Jl1Md0B24paVSCKEqab9wWcZJN8IvMWJxVKWAtqWhD8j3Xf18OBme10AbyTvpuFhaebfzvxC0Xucic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773097568; c=relaxed/simple;
	bh=JA1Emk2GOGrNm0wBvip1tqJqrJtVwNB/O0vGeFWX/84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/GteZOjSVNZLfRlXSsRFvysg0MMrIMuSaRTsiv6bykglJmSQLKyqBCBpCpisoBFHdvgj1ngC1mjdIeY8gTs7FA6k4gz1XlV78ISI0Zw8d8u7ABZhoCtgRMHvV74PRYcoNvP1JC+8xic8i7MY2zpjnH59h3AmRChPGtjAFu3CA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cR9bULr3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g8XOX31C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629HBqZS1297863
	for <netdev@vger.kernel.org>; Mon, 9 Mar 2026 23:06:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=v2mAeI36jMe
	fxLTQ32eNJQTAV5FQOsM8JFUnk8b12HY=; b=cR9bULr3HuHIdluNoBJGFv+4inn
	oEkch/dAK8iHZXChBmP5YbxIOSs9RppPQ3TOJwqxNc6KjUG44l0NGpnP6kv+bW+n
	93OhKIOseaCH6RpcaT4bQYVVTt2zIv9g1XXzGixEOaqkG8xPAETVQCoustms+8/l
	1XL6XKajpsOZ7fXoIessDCYomEMqLT1Sx6X3lbhM3jZxWSOKB3YGmGnJ74qcBg4q
	AsE7BsGsPW2E1XJkUAqbhWuTQ8OdZtuPblMct+hrtcMMvkjsLExjzi9rEA4GjGOg
	PXDfBsHsJPiT4nYN8l0FHvpiUBgWVuZ9EIQhJ32d6/k+OSx5hXtL/yADkxQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csyv19p0a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 23:06:05 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cd7774be64so1410029185a.0
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 16:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773097565; x=1773702365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2mAeI36jMefxLTQ32eNJQTAV5FQOsM8JFUnk8b12HY=;
        b=g8XOX31CxcmXx766z2IReF1IJvIswtIf5plLemO9Y8QXZHkKlFmlhiDNpl3v5o3+zZ
         SC6yDf7u8KyhpmeWRkL8KN4vIbavmu8TGnR/wapjh5/wN8uzqXrkiSfAypXpIjl2LpMH
         NhsYyx9v41ITpBZ9SLwd+I17SaxI1b8VPt1/JaSsnbFLGbE8Mmiacpd/ru8KB0+GiOyG
         6yQtx+vxXwnTukAkBwhS/jqXA+tCa0MTrStzdmLlXk2bZxumm07HAYvqA/NTEo2tv1H4
         gS78ZaphzaKzKMKq6AYNYL4ZJRp4iFJFFoWeO27TWz58d4JoCaJxtoaQHqJiZXruBvL5
         vsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773097565; x=1773702365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v2mAeI36jMefxLTQ32eNJQTAV5FQOsM8JFUnk8b12HY=;
        b=PHIQIXRiT7YOIDxcN3U8/iN65ER252o0WjVGoakf83GkeTkjpSZzerAg6gF3C8WhhR
         2yXTehbVofPjsPbYIAzusuLqZ7HwrbJh5jBYMusi+CM+Zsr6mPZERnqcX3T7z0WtnkpJ
         h9pMRH+DC161EPs5hoRGxRWW/z6UeDW/NwgGa5H7tkpAW6/fIo8H5fm5z3w/ltbyKaoQ
         /yLJxEGMgvckwLwalZMAXBptK9n6mvMH92qsyy3KFgiAf5SOYM/5tiNuYnHOVg7nS+DM
         TCYSwTHPjFKyUr0FTLcf68tj1Wa6zyVE4zg7sMtjR8EzRzUK843cHy+Nsp/UqaJ7AC+3
         c7KQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqq/KRanqAzfJuXFaKTHj2MrjdkHOzuGapJsoQP0aPW2qy/eU8ZN120wQn+HrET0YCXFms2bY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnp78jL/fbRwxVmlWeE4zB0Aww7fEIRsT0SGdIwyG+8HycCAL9
	QHZQMn8ILUFSdv7AIolHm4KsU+kGBsEWYwkm8fZnUaVwWnUj2WExlCYEvOZGzvGiFsi/S4Zoz2T
	KMfhRgPQX3oINF1t8gJc7apZxgQDtqlQpOTnVGGn5i+gop4uFFneCMNhIl9w=
X-Gm-Gg: ATEYQzwLUDn/e7U92t7NaXhEwzZcWt9VgpOnVs3TLdGNAFeAlKEM1JvcVqsh6XJhqZV
	WvI/UvMDrwe9W9feLWrmq5Pd4OtoddaAsxArK5dHs6omHQvR9bQd1DC8KctWd1nuKpeS6EJDvug
	xIxyoXThvexrr8hzg8RVwnl/nK0xn6QNP7cvXhEk8XMLNMhKg0kPA2wZAPuCeSUdtkIdo2LFyGt
	vfNaezTO1vV5FZP8P726z1uTzCJ2VlIvgqdmA2HYN3naqAyVmW7XxMUYetQ0buWcNFhgVFuwfzZ
	n+IYd5w/cGQK3kGdsWi5AqtyTXqRgys3FMNptc3PZmZLPxCMN6RnrXNtdl33D88PQzmHo8PsPVi
	Gey9c3ZntQTu/R63MGQFzXqRNcyfOosP1GDd4eM2h01i7KGPMHw==
X-Received: by 2002:a05:620a:571:b0:8cd:7cea:aead with SMTP id af79cd13be357-8cd7ceac62fmr770643985a.2.1773097564718;
        Mon, 09 Mar 2026 16:06:04 -0700 (PDT)
X-Received: by 2002:a05:620a:571:b0:8cd:7cea:aead with SMTP id af79cd13be357-8cd7ceac62fmr770640485a.2.1773097564261;
        Mon, 09 Mar 2026 16:06:04 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae3d98asm33898478f8f.30.2026.03.09.16.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 16:06:03 -0700 (PDT)
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
        linux-sound@vger.kernel.org
Subject: [PATCH v1 8/8] samples: qmi: Use the unified QMI service ID instead of defining it locally
Date: Tue, 10 Mar 2026 00:03:37 +0100
Message-ID: <20260309230346.3584252-9-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309230346.3584252-1-daniel.lezcano@oss.qualcomm.com>
References: <20260309230346.3584252-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LD5WLG12QkVr6Ew2FcaVGVenlLrhlHgn
X-Proofpoint-ORIG-GUID: LD5WLG12QkVr6Ew2FcaVGVenlLrhlHgn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDIwNCBTYWx0ZWRfXz/uq4F7HSf7G
 +XRqQ0yD7RVYYNvFYNEYXIP8c4UEbCGqot92Pa/wha+TogIgh120/0SkfiGF8xtg/lJUUDuz1QG
 vi0tuUMqozDjezg6kqjN4+MBSzoHh877x5ivRe91DYxAx67zWAloSaCbkV1L2PgWOp6RXYnL2S0
 sgZfEzF/7BAbt+CHHMQl/Izg6ZiQag4KQ4XWhqMZ2y4cRSLN3EHLc9JGd1KzmgZKEJGWnjjlBCf
 nX5jBOEWhscTk16VQ78qzBMorcrnch5Kp7tFrxWGXvbk8xaOlEZWcDi0psbAZM9PO/get955qYk
 HTuAWPC79aLlKcDH+JgnTnKzQfOepXfOUZuO7YJ1XRsdRdApPnA9EUZm/VjStfHMaayNvcbFSuN
 /NE4g3kdMScnTU8s0VGrCImZ8h0k6ntJDxVxxSj8RLrTWT8SpvIv0+5qvw/Yj0E5IfaMq8aan7M
 9jWlE1Uew+3gFDgj8Xw==
X-Authority-Analysis: v=2.4 cv=Cuays34D c=1 sm=1 tr=0 ts=69af525d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=RE031ben1CQMdFOqpmIA:9
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 spamscore=0 adultscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090204
X-Rspamd-Queue-Id: A40BA24289C
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265792-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.lezcano@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Instead of defining a local macro with a custom name for the QMI
service identifier, use the one provided in qmi.h and remove the
locally defined macro.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 samples/qmi/qmi_sample_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/qmi/qmi_sample_client.c b/samples/qmi/qmi_sample_client.c
index d1814582319b..247ec5e54c4f 100644
--- a/samples/qmi/qmi_sample_client.c
+++ b/samples/qmi/qmi_sample_client.c
@@ -592,7 +592,7 @@ static int qmi_sample_init(void)
 	if (ret < 0)
 		goto err_unregister_driver;
 
-	qmi_add_lookup(&lookup_client, 15, 0, 0);
+	qmi_add_lookup(&lookup_client, QMI_SERVICE_ID_TEST, 0, 0);
 
 	return 0;
 
-- 
2.43.0


