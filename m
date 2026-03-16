Return-Path: <netdev+bounces-268221-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAdcO9k6uGmpagEAu9opvQ
	(envelope-from <netdev+bounces-268221-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:16:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC71929DF6B
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6770C30398FB
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 17:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5563D3329;
	Mon, 16 Mar 2026 17:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P3DU6dl3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NrqvfI+8"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA393D1CB6
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681286; cv=none; b=GzmYRgUhjTY9/NEM+5Ab3QQjX/fx6+q4WKHV2xz1sAeV17IkOu5uSBwKPf8DcrVc8YzqkG6hZba2vpQwZXD9kr/c0TUkLzW9yFNbDS2NkXU3oCfTiyTLBC9OuQm0pCB6Mp/mMAq3spcvKIjP01eaBeUeyxqXFr7ILop75GAbd2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681286; c=relaxed/simple;
	bh=UocqjRyfFzM84DjFYioQo6kEjdPifFN5KCFxnX+Mtbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zu0KrSet16gHXlBsg4b+u32cZbsVrdWrt4TSirLfyG1HxUMvBeMVV4lxS382ziacnYcXnq9z9C0Hil7bxszYTUpWj4G6O3WNR9Ju1GkNkjIuO2fuAfi7qxber1/QxYkxdmWVKmf2NJaQdRwANsjZcWIsmlW6ZKwgvyYdykMsGPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P3DU6dl3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NrqvfI+8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GG6OMq4022237
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 17:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=WFXy8rqV6ZJ
	yXTmDCC1XrXB5vrLD+ozr+xme7NcdKiQ=; b=P3DU6dl3c9C+mKOoFj8fLnflTRc
	E4S7OufGIBneH7YqP+NWIVKQr0JamAB0ccP/h1Fu1YGnyp4csg0npjgoFeixW8JR
	Vxl/OXVJfgmTwzF4Vn7J2fQ1stksLuZyNanswJjCeX+tEvcw4wn+3J9ef+QTeG1n
	nsaaszMiZ/kCXgERsFktG+NFb0XemxxH757PA/JfVm3NnNUUQzrGnDx49KGDygK7
	pFlzs5B2WwtrEU11sYGr3Wy7XXdUOW1/NAVcRbrPi0lKxckc1uUQdMkQ34QJ+ljV
	4HrjH64gyE1cItzRHI72edpT4EBGjx60xlN9Izp4/hJP4ItIfIEv51VQ86g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxn3fg8t3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 17:14:44 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd820c6a4fso4310832685a.2
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773681283; x=1774286083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFXy8rqV6ZJyXTmDCC1XrXB5vrLD+ozr+xme7NcdKiQ=;
        b=NrqvfI+8EHRd+MVD032RWKR2d12VgpuKL0Oqd8RkWQ1N3C9JTANmVroK70M8+0/5Oj
         UdT6yk8N+cfZUkfq6S6R63zOLGOe+1THxBqMTKkmmHhx8Vt9jpMOR7KrW6Zy8mj28nNj
         Qffy16hAr4shMxnIXDgrvmOU1QXptyiaCfAZPP+GsXMc7CN4OfufezD+8WrkeYNLBesK
         oLv7RxmZLhX1y2B+9whenBjnhkoS7n8WQlTsq/3KlN0likuiOvykEDn4sWBRIpzcebsf
         E+XXGp3hKBfavX5GT7pPjfe2iRXfrFTuSLnzaaKLiMqIoD3k1Xk1B5PuExL2W47Bap6j
         +/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773681283; x=1774286083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WFXy8rqV6ZJyXTmDCC1XrXB5vrLD+ozr+xme7NcdKiQ=;
        b=Q4t35XMq+nlg3X1iyM3Wsy5CBIt3bKIr+8Y5G6WveUdbTnPoRytAhp99pcHZjkPkfF
         hd5HPOezM5fddf2/mA02n5OFrn9tJcIByp+8NDXFDazo9TTyoYdScYmF8IIC8UxiBsJM
         Yz/YaW9ka6oNscd02xiSq2lULmHY4vtAYiOOBdot31xlykQZ76ChdnL+/xpYBPF1phYQ
         KABhigZ2fdBGqSF63U61Vlt/NqexwGsiaCnxRIHDUdkqeOeZKY96hg4ykmnbhHKJ0dex
         4Zo88lDN3p0a+gJq2Ew4W8YxYq6jgeFgEZwr3tWGN7/fQoP5h0svasjuLQxc0GObMkhW
         uY3g==
X-Forwarded-Encrypted: i=1; AJvYcCVnKohuSuVMExNqws9W7r5JfYdD4CG96c/SZnFeegBJ6TuYJFHZwt/va5RdmwIa27PJ4JN8XgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhq5PAc2VJT8OBemxlSmSDJmoyebS0iqQ/2NFSntRh72DCP0Vn
	9NE+VuUXFvtquMqgkVKVND/5VHFR99BtQgIqiABSgcdXMVjDQQaAi2DEs6HUq3aMnlomi2sKZwt
	Wn48IHj4a4kGRGIAmKam0d6U1hRUd0OWRbFB3/UqRjPFbXEQIQzaGJA1EAes=
X-Gm-Gg: ATEYQzzAsIk6Pv9wg4cOBYmXMvLr5/qm/ICOpI9fotgGzHn81HQd+3qzROdXIeOT1+z
	WxSvOH72lYGGV0sMqGHJGXkrxBxPe+wPKcUVO5Q6Ub3oIInqp2OfZR+QRptXVdv131t7Us9U4+t
	ZbMo5GGrsUKLHR+ncj+LQxGUdz/RWORO2c7IYhUKkD2aJnzHcSfvsFmtaIMG2R0XUAgSxTPCd/p
	0tPzPBVgHXWBdE3fESTa66V4iZFTHMRDHJfrjvEL2BS+C0aH1H749z7vjnG9HJnj2YJsvNudXnT
	G7hxswJ1z32Cs61bd7cLg3Gkm11DePJICXRpNRA48Bydf3fbwOOjrnw4id1qTFPvrjsrs/fEeZO
	eUrnMyb5w2d49sYQHH9thp+NtgA3NJ/y4j9zii/q61bbvsbU/+g==
X-Received: by 2002:a05:620a:711a:b0:8cd:b3da:5b5b with SMTP id af79cd13be357-8cdb5a4b098mr1839477485a.10.1773681283353;
        Mon, 16 Mar 2026 10:14:43 -0700 (PDT)
X-Received: by 2002:a05:620a:711a:b0:8cd:b3da:5b5b with SMTP id af79cd13be357-8cdb5a4b098mr1839472185a.10.1773681282736;
        Mon, 16 Mar 2026 10:14:42 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:5dfc:3995:22ce:d286])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20b544sm43860993f8f.20.2026.03.16.10.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:14:41 -0700 (PDT)
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
Subject: [PATCH v2 3/4] slimbus: qcom-ngd-ctrl: Use the unified QMI service ID instead of defining it locally
Date: Mon, 16 Mar 2026 18:14:13 +0100
Message-ID: <20260316171419.2619620-4-daniel.lezcano@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=C5bkCAP+ c=1 sm=1 tr=0 ts=69b83a84 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=PhtMypRRY1SmXJO8NnMA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: _f76nZoUT7lN-1AZ8h5DGDHYj01TWXb9
X-Proofpoint-ORIG-GUID: _f76nZoUT7lN-1AZ8h5DGDHYj01TWXb9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEzMyBTYWx0ZWRfX1vlfYtv928/G
 ipOHsCdqMyfrzO3YH7jLQvXCLDpkYMjbbYExz9+q20U+xAQ0WSr5IQCCmS9lxx83hbE3QW3VrjQ
 /TXco5lGexF9gI5J5ep/K1s7uJYy+G+ZdkicMHKI7CMl/z5ON5ywV7Z5+sq467qUE0syH/wBhi8
 QTLeTwI2MKksZfwN36AZku1WZezJSIdgiJfg70Bx2v0HJH/OMWm67chtJzgbLdof3iQ4OyYYjQD
 fKJjaS/Eee64YUp2SWK7mkb76g4WZkNZKCvvZ8V5n8ZFIfCDwSqSrmiRcHUNkuIMtFe2fcekG2S
 fQj15OMrptJe0uRgGfbwknyot65c2/x+dXJp4jBIKykCKP1t16uuxK7ArCiw5DUa4YtNqhqdhI0
 5Sp0uhjDP9x0pRMsxCJ/lLUjxD7NMm2tGKa0FP/3nslHCmOeipV7AgoNJ0N30foFz7QIQ2t3zLw
 XNMImpEIbR9X9I4IVPw==
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268221-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.lezcano@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DC71929DF6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Instead of defining a local macro with a custom name for the QMI
service identifier, use the one provided in qmi.h and remove the
locally defined macro.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 9aa7218b4e8d..0b88b8577bdb 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -48,7 +48,6 @@
 				NGD_INT_RX_MSG_RCVD)
 
 /* Slimbus QMI service */
-#define SLIMBUS_QMI_SVC_ID	0x0301
 #define SLIMBUS_QMI_SVC_V1	1
 #define SLIMBUS_QMI_INS_ID	0
 #define SLIMBUS_QMI_SELECT_INSTANCE_REQ_V01	0x0020
@@ -1408,8 +1407,8 @@ static int qcom_slim_ngd_qmi_svc_event_init(struct qcom_slim_ngd_ctrl *ctrl)
 		return ret;
 	}
 
-	ret = qmi_add_lookup(&qmi->svc_event_hdl, SLIMBUS_QMI_SVC_ID,
-			SLIMBUS_QMI_SVC_V1, SLIMBUS_QMI_INS_ID);
+	ret = qmi_add_lookup(&qmi->svc_event_hdl, QMI_SERVICE_ID_SLIMBUS,
+			     SLIMBUS_QMI_SVC_V1, SLIMBUS_QMI_INS_ID);
 	if (ret < 0) {
 		dev_err(ctrl->dev, "qmi_add_lookup failed: %d\n", ret);
 		qmi_handle_release(&qmi->svc_event_hdl);
-- 
2.43.0


