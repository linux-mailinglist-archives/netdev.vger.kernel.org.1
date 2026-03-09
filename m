Return-Path: <netdev+bounces-265790-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJa/BVlTr2m/UAIAu9opvQ
	(envelope-from <netdev+bounces-265790-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 00:10:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A05D024294B
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 00:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0842B3192A4B
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 23:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB572428829;
	Mon,  9 Mar 2026 23:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ifd7yez9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y1jsX6D6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D3B426D07
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 23:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773097559; cv=none; b=X3Gx10WJZYuLgBwJqe7l61u0f1w28URXDfI3l5hbHcSdpnmpLVQ9oFU2ttiR8ogrKFyl/4je/QEmo/ffinvaaRyEw+MprSrVPmlBWk21PH9P8LnQWtIbLWEdrLmhpGeINn8KcMj3NhbRLcsIyblOTpak2ROUoUE3pptMgCLfJC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773097559; c=relaxed/simple;
	bh=gSGrdfWBD1PJQNA8FSE3vNlGaG4+Xx3EyKe0Xq77gxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HaTzfQoCGJJpin0HFlumh6zzXtMBvzX+QPJxX2Rn7VP5Bx6h+S7GekwTFPYrJKQXslzQAOUt2fPx+ejvtu4zCyNs90P13fBxPmCZ8fXahQA4GPKi9oGKwxvP0ZJG+D/o9V17MFyrGyGsxF2O15O4DxCY+3XOlPb5OyI+oIeNSK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ifd7yez9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y1jsX6D6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629HCAXb3280753
	for <netdev@vger.kernel.org>; Mon, 9 Mar 2026 23:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=xPJuWGqmD+8
	ZGPeNWjPXHXFYrZ4UhGUHfAbfp5Y2vtI=; b=ifd7yez9Im1NWd4QlgNWMkyW57W
	tVINyWDwUayU0ofvyVrNXpJlPZbi5BzPstvukcndCx8+sBUFqHybdIZIswuEEhzK
	zmFpSttCgyQIzDo0Uwgdl/0FaMmmN1EjgnaCA4AQmAxAFh50YkxYu49Gn997mxRc
	S575adbLb8WMzcm90Y2nFu6XMVgbx1fF0IPOGRUXNpT3vplyiumkPNTVWF65gXp6
	n/mkmfTxImEfRtoCU5AyWCa8kx51DE8gFX6qwq2zP0hpXCvTgGH+HKqnmqVBKNzL
	PXY/qaHQigjhC7ZOOOfC0z4CflOArbZEHdbza4Mjlv/EpfwKbVd4mpZCysA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csqcybgnj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 23:05:57 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd81506677so1046169285a.1
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 16:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773097557; x=1773702357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPJuWGqmD+8ZGPeNWjPXHXFYrZ4UhGUHfAbfp5Y2vtI=;
        b=Y1jsX6D6D+gLOgPuFxjayg+3QDScUD1CtS26lwPEkmuoDWRju3/eG+yepQujaaYkbA
         SKahGwmiLonxF2bQ7PATwaJK19e3T+fazzoiRPThmJ0Y+f4cBgSjiTDp1mntehlQskZg
         i06XNupQTr5Jva01NbnYXbkNU1h+tebSH1FAgnf6hB9CdHzgIrz+gBAbE0bpDbcUrhlf
         xcwIblwVrRA6uFthIKoEsI5+NYTpoQ+hZlNliKiPqD2UuADgTRFXFXnAu+vfAjL5Velw
         nFa+bGAHZfybtW20rQbA3b5TKcCe2qzOWsupZ+PS6oHabzqZtPpo+KUZG5yNcxWKH7w5
         iY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773097557; x=1773702357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xPJuWGqmD+8ZGPeNWjPXHXFYrZ4UhGUHfAbfp5Y2vtI=;
        b=Mrv/SMnu1H/bLp4WIXDM64FJcJ0upgNlRXqSZjaoP+ABJJ4fkGWMJn9XClZJMgVvEc
         LdUvUQO0WKLgcB8NqmyMauUfg4FN1P5njNePtFrZZd1hCHGk0Lewob5fePZu+RGGb4CI
         bSUyA1iPYnsbd/Q3EDpw1kEmika9BdnOiLiTmJWcoZIMArIlRXRQIExlyw/90dWRQkiF
         zRGXNj53Qv+hiQpVrx73ioK807AQpR6UOSX0P2HO8EUb0EsjjFoxnl5ZsdIAKjvxW4XJ
         8kpzsWNCr/Xwq4Q1kzda3PLUJ3jUKjsLMWJmd6fJt9TbDnle4iPE75L0nqgxdgstJlSZ
         O5fA==
X-Forwarded-Encrypted: i=1; AJvYcCXSvOui1dec3sdycPPk45K0jlHcdW5iWUe9VqFip4JkeSmf12vbeW5QS/AIXaq2RuQQ957aoHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyI4w/JnucHDrK883h2A3DBRYRWqND9cZKWW7J/HNnMxz3cfLz
	ndYVzD9q80vz4wMPId7MpfzxvUlpmJOqilOtCFuk78mF6FSs5FNa6f1CjV01TpjYKPAOCTqLjEw
	WfWAfADeVktUKHRWYQA+vUudVbH9HgEcGglF27buPnGaeCdx1lt5aJTtNoDE=
X-Gm-Gg: ATEYQzxLJpbD92j49WBaf4u0U3ARxvc7rTYGXsSfQIk0ZapRID6zmYjnO8PNZDVNXOr
	AgjoHtDC5crLQh0NCMRBYDCGfazVVIGs+8OYyEKrjB6GFmvHphyV1Av+Ov+0JvmmX+zZTnPiOeO
	fvMxjiBCCkUAW3UpiV0G9MkaY8TKNCbpY7tnAx5Net+Msx9Vqpgp5cG8Kodhl3f1a8jzKj05/G2
	GzRFTwLLrQodPwUCRBizc0DNndxjy9JGqx8Mxhh+O042kJt6njglKWab7Wzzzvx19xcBzER6GXk
	N/Kajkfa8UPF43C57P31czywDAuUYSwb78+rRpGLc7AVKEU+gdENwOe7bUDgwOyQvysRBSFlKQz
	vcprf9dHpezpE73aLwPXXlO4APYUBMruBZ2w3nPG9e4yqDAjSww==
X-Received: by 2002:a05:620a:444d:b0:8cd:8751:2b26 with SMTP id af79cd13be357-8cd87512fcfmr673414385a.58.1773097556809;
        Mon, 09 Mar 2026 16:05:56 -0700 (PDT)
X-Received: by 2002:a05:620a:444d:b0:8cd:8751:2b26 with SMTP id af79cd13be357-8cd87512fcfmr673408485a.58.1773097555998;
        Mon, 09 Mar 2026 16:05:55 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae3d98asm33898478f8f.30.2026.03.09.16.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 16:05:55 -0700 (PDT)
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
Subject: [PATCH v1 6/8] soc: qcom: pdr: Use the unified QMI service ID instead of defining it locally
Date: Tue, 10 Mar 2026 00:03:35 +0100
Message-ID: <20260309230346.3584252-7-daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDIwNCBTYWx0ZWRfX43bdQtSA/4ZL
 QwRML795W3Uv2yIhYKBB5yhbH6Mz7OTQ6irrvDSSYckSjR2BmuGD4vTWYqgEBtWEgGAw700IxbX
 RphwMImspticc42R92v+RSTYUZev7Lx3rIeeUXdCtscTNbbC4j8gBadSWcJj6uIozIrwV1VLHFj
 /lcygjIU55xRgjpu+yvaJ56XkMuQZGpfJXHrf4Mw41AuGEFbBHI227jQlbp2ClvKmWxzc/t2mmm
 ayrGZp4lTzmbcoCAQYjZHN7iu5LhT6aRm4FSnYGWgR5mJ1CzGk9Z5ZklVa+DQHE4FICX1RaVV0Q
 Cz2KohMdUGZTf86xyLaIl9IlpiN/M/HjLrKGuXWUDZAUjNQZoTOh2F0vABoKS7HWs7I1jzXfdRO
 fcu0FsUHq+51BCD6dYhnJQaU7f2XIV3Zw63dXXZWsaLMw6ziW9LZArV/tl62LQSr1jqlw3T0xtf
 yKUXML12cF5TSnd0uxA==
X-Authority-Analysis: v=2.4 cv=QJtlhwLL c=1 sm=1 tr=0 ts=69af5255 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=P-X4VuwvMnWJEdMca_IA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 3xp6KKQyEzhlvJsuXj33h9xLWjpJtrqi
X-Proofpoint-GUID: 3xp6KKQyEzhlvJsuXj33h9xLWjpJtrqi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603090204
X-Rspamd-Queue-Id: A05D024294B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265790-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.lezcano@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
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
 drivers/soc/qcom/pdr_interface.c  | 4 ++--
 drivers/soc/qcom/pdr_internal.h   | 3 ---
 drivers/soc/qcom/qcom_pd_mapper.c | 2 +-
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/qcom/pdr_interface.c b/drivers/soc/qcom/pdr_interface.c
index 72259f489075..6d879e1540b0 100644
--- a/drivers/soc/qcom/pdr_interface.c
+++ b/drivers/soc/qcom/pdr_interface.c
@@ -523,7 +523,7 @@ struct pdr_service *pdr_add_lookup(struct pdr_handle *pdr,
 	if (!pds)
 		return ERR_PTR(-ENOMEM);
 
-	pds->service = SERVREG_NOTIFIER_SERVICE;
+	pds->service = QMI_SERVICE_ID_SERVREG_NOTIF;
 	strscpy(pds->service_name, service_name, sizeof(pds->service_name));
 	strscpy(pds->service_path, service_path, sizeof(pds->service_path));
 	pds->need_locator_lookup = true;
@@ -678,7 +678,7 @@ struct pdr_handle *pdr_handle_alloc(void (*status)(int state,
 	if (ret < 0)
 		goto destroy_indack;
 
-	ret = qmi_add_lookup(&pdr->locator_hdl, SERVREG_LOCATOR_SERVICE, 1, 1);
+	ret = qmi_add_lookup(&pdr->locator_hdl, QMI_SERVICE_ID_SERVREG_LOC, 1, 1);
 	if (ret < 0)
 		goto release_qmi_handle;
 
diff --git a/drivers/soc/qcom/pdr_internal.h b/drivers/soc/qcom/pdr_internal.h
index 039508c1bbf7..6cd8cbe26822 100644
--- a/drivers/soc/qcom/pdr_internal.h
+++ b/drivers/soc/qcom/pdr_internal.h
@@ -4,9 +4,6 @@
 
 #include <linux/soc/qcom/pdr.h>
 
-#define SERVREG_LOCATOR_SERVICE				0x40
-#define SERVREG_NOTIFIER_SERVICE			0x42
-
 #define SERVREG_REGISTER_LISTENER_REQ			0x20
 #define SERVREG_GET_DOMAIN_LIST_REQ			0x21
 #define SERVREG_STATE_UPDATED_IND_ID			0x22
diff --git a/drivers/soc/qcom/qcom_pd_mapper.c b/drivers/soc/qcom/qcom_pd_mapper.c
index dc10bc859ff4..bb60b5c40554 100644
--- a/drivers/soc/qcom/qcom_pd_mapper.c
+++ b/drivers/soc/qcom/qcom_pd_mapper.c
@@ -656,7 +656,7 @@ static struct qcom_pdm_data *qcom_pdm_start(void)
 			goto err_stop;
 	}
 
-	ret = qmi_add_server(&data->handle, SERVREG_LOCATOR_SERVICE,
+	ret = qmi_add_server(&data->handle, QMI_SERVICE_ID_SERVREG_LOC,
 			     SERVREG_QMI_VERSION, SERVREG_QMI_INSTANCE);
 	if (ret) {
 		pr_err("PDM: error adding server %d\n", ret);
-- 
2.43.0


