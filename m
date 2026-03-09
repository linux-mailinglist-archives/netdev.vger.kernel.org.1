Return-Path: <netdev+bounces-265791-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIFmAX9Sr2m/UAIAu9opvQ
	(envelope-from <netdev+bounces-265791-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 00:06:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFFE242832
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 00:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 97C4030236A0
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 23:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D32427A05;
	Mon,  9 Mar 2026 23:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EnmPJzaX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HjDTeJsz"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F8238F650
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 23:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773097566; cv=none; b=Ny2uwp1IXHRSOlFw/M1I5wuyNnNyjkbJ3EpasCExl8cbujjZlPBQCq6WMLdCjkmYpApm4EaN8MqJlLP/YW1RfVd/24RzgKBsKlFujs+acFPBylCgbr9nOOEDTu7i87iCLSqRBjqxDbZ1bcsBuAgXmiozlvi/wEUIEqCFDvh6jLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773097566; c=relaxed/simple;
	bh=Y5kmOc/Td+3kz/MbZfYNPyjwrYkMruVLbGOtRAiAKz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t66S0QPcXiQGZRjv4aE5vjJPobt3Kx1tYdGVkvSasQVWMkWN0+F/g3yCT3GkycZ0gI3DBfkyHnV+q4e5LANUtAtrdRFa3yXeyBAdKkGWNu/W55QrwUIG5g0rRQ4ZKGiNe/mWNHnZlbCdRJXTL3I5ktk+XmDDxem3fvp/Exr7RV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EnmPJzaX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HjDTeJsz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629HBoET1920929
	for <netdev@vger.kernel.org>; Mon, 9 Mar 2026 23:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=o+8grnDyx3a
	Y04II25yHs+DhlQHwGyE329UXeTulGfo=; b=EnmPJzaXDKfHbBKit2i6OzOm42b
	lS7sFWuQdyT6nOJsixiASHIu6RV+GBs7xstRQSxbPvjcChqJJ9XpdtxtEefvRUJ0
	/vzUYoWy6seDLrKnbfnBzBZ7VHyqTEwYNlJxSa42KZQ35lhO+qqrwgr0MhgF2v2u
	XIUOlYcxN0l/SiTaVR+/4vyGrXSRUNY4xGr02/UBTsA/bgKRuSiv0R0QaNzhBiq4
	c9maWi3bGH5wkaI4/sbRIvQcfqVK9l5BSHbTV8yOOhJoz5OsXsJifEfv9WwX4F3p
	jdImAMabQQwyG3m/dV4KrPkxvDG2ukxU3wSswURC0mqLM6NZKINavIDuW5A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csxy81uxj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 23:06:03 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cd900cd3a7so454498485a.0
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 16:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773097563; x=1773702363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+8grnDyx3aY04II25yHs+DhlQHwGyE329UXeTulGfo=;
        b=HjDTeJszeb9Q3Zwb8jX/rHo/6iVYdGgz+RFLTkKOiy9ET/j6T4mtZ3sJjfgYExcHPM
         S0XbQmXwK5M4LXvWbjKxqA2hqVWat/67xWaVKTOBTyLS0jQWg8TAAOTF5v5x+2ZBt73R
         9CCKauRusnnGy5Z1w07WkGCB3G8fnQTlWKO9Jb4Cs2b9/Mii6N3BaDeBCz6MxDz9PknP
         6/BCgC5yEYaht2N+ILHB9Zx14lhnGp+sT5uPNWtqhv/C53/BFgAXKUKp5dJhiMw+vzbV
         XkE0B9dWYgWMIQSf94mvtlHDav+x3sRAoJBiCjlpAMZjjOqHbG64m7naa7GojNECgjs8
         xF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773097563; x=1773702363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o+8grnDyx3aY04II25yHs+DhlQHwGyE329UXeTulGfo=;
        b=Us8N6BqNqsDjX0gEGymc+wsrxEwaHPfsjgKnAYL10KrMR4nrXLENHd1wEFSkVXqRjI
         dQMqNd9bEaZ3cTzfVuwcI4wGQ2DyOXjYpW1xYEOAkNh+hxvDrm2FWVp9v0lIi/P5GvBS
         AgZD9WpnCoxbpqBa/2EAMN+EGziI4mUuvUvyPyMNqRDinX3UnSoisl3xV8t2zGRu1aPx
         dzpGfJISzgjJkVmSqftolxWqsHQYhrFV7/FrYJa/sCJnFKFQL+D5AEy1MPuqKjggIdjh
         zWkVuqMMCxCzrRkAc+Go8CVhftH0NqQZQ+UGEDqCU9TYg3ddelF5XCTowWKq0NR8VT1p
         Kc/A==
X-Forwarded-Encrypted: i=1; AJvYcCX+c44zQdSUQi3p2OSd+hiqjcvS+vqJXlBY389FCGB0n/iXUvVRER+sarsewSjqyP/VfzTggSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnwayOPLkx9OI0qTa1xi43cj4h0KdMf/EpW6Gp+NNH8NaH863R
	JhMVacLOoXn4FYCSmWEEaVy0bAgVBknIElwyGoVtyD/BpwiYRe9O/3TWtAt1NQWyAUmVYuN2hhn
	dwEDgqMg1xNY597a3U+2abh+EmgUcOaI2OTSciriY8YDENxih13V7WXrg1Jk=
X-Gm-Gg: ATEYQzylvWbykwuluPeSg2CEnn/4527xaqabtYS0qXWCaTEVGiRX4D2tyWeAkGKJyFf
	Cgg/5HuVWP6GdQNwZOOpFkqkrk5vT0cEFU3LgltvzEaKDK7hcWkT6pdpz8Hx3+LKjUUm1CPoqTQ
	WWYy5U67IlHWuOx/KCvEVO3eEaAWUNynydPKmIAIT5Fap2dCzCU6C+GmwkKhQGoY+h/moo16HWS
	uOy4+OxnOuCV9+pLPyBihEA9cXcdJ99utYwJi3Fz8yynX2MyfhiuhedHXwz1lDrvN4BDI74wSMd
	ZNjIcAIQJTH7CPjpMAWZSdAceuVViCGJ5qeMGkJKwDdveU7/lfDQZXyj2HbvBPSORT/02BrhrmX
	KLIuEAYCYT6bltobgbLrEu+iTw4l+br72dXnAhlBkLEgWBwm8VA==
X-Received: by 2002:a05:620a:4044:b0:8c0:d16b:b0a7 with SMTP id af79cd13be357-8cd6d340439mr1568427585a.2.1773097562696;
        Mon, 09 Mar 2026 16:06:02 -0700 (PDT)
X-Received: by 2002:a05:620a:4044:b0:8c0:d16b:b0a7 with SMTP id af79cd13be357-8cd6d340439mr1568423485a.2.1773097562240;
        Mon, 09 Mar 2026 16:06:02 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae3d98asm33898478f8f.30.2026.03.09.16.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 16:06:01 -0700 (PDT)
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
        linux-sound@vger.kernel.org, Erick Karanja <karanja99erick@gmail.com>
Subject: [PATCH v1 7/8] ALSA: usb-audio: qcom: Use the unified QMI service ID instead of defining it locally
Date: Tue, 10 Mar 2026 00:03:36 +0100
Message-ID: <20260309230346.3584252-8-daniel.lezcano@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=SvmdKfO0 c=1 sm=1 tr=0 ts=69af525b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=GLuZV9TbpKr0kWuSc8UA:9
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: XDODFyYhzCgamzYZMKYQwloLr-hkxGOj
X-Proofpoint-ORIG-GUID: XDODFyYhzCgamzYZMKYQwloLr-hkxGOj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDIwNCBTYWx0ZWRfXw1cAde9tEU5L
 Gi20M/caYSttkVMHC6WAzcwiUPUGps4kuT6v1TpyOAzs1n+Z0vrejiqHSAh5E5IrhafcLKQpst2
 liC4sSzMic0SWJom3t7pnyWtlcxT6Oe/IcLdiRmAUijhl0XfeoFC8uk4J+uE4n4XBT1H2IIL3I+
 ReZkK1c14BSFrypNEzmdjkePiNc+RPwGaBmWRuj2NIF9u7VspxF9gzn3LXUkeG9dNUYffsFdK98
 y+82e56s0AkiTe+0FlO+BIKsygcYyQCIRu1rZ8MVl1r9b7dd0ED5FSm7KMMaR+DRjLzDQrvYW7Q
 w1xlK5j6nH78NxzPCOpwHzec4r8W6AALK9eHMacPH7wMwe4t/QEDZ42Psnn6/AdNKcXVegkByN4
 CFvDsJ/qqy/Hv/rNR9dBAKhFof9UjXwJC2Zqsq/0JD17Ok6Q3xmNQBZQd56hh2YJtul1b8Gw+O5
 W7DqqF3Kcaoib8ovWZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090204
X-Rspamd-Queue-Id: DCFFE242832
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,perex.cz,suse.com,linuxfoundation.org,arndb.de,quicinc.com,lists.infradead.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265791-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.lezcano@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Instead of defining a local macro with a custom name for the QMI
service identifier, use the one provided in qmi.h and remove the
locally defined macro.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 sound/usb/qcom/qc_audio_offload.c  | 2 +-
 sound/usb/qcom/usb_audio_qmi_v01.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/usb/qcom/qc_audio_offload.c b/sound/usb/qcom/qc_audio_offload.c
index 510b68cced33..bc4e1bdacaa8 100644
--- a/sound/usb/qcom/qc_audio_offload.c
+++ b/sound/usb/qcom/qc_audio_offload.c
@@ -1927,7 +1927,7 @@ static int qc_usb_audio_probe(struct auxiliary_device *auxdev,
 			      QMI_UAUDIO_STREAM_REQ_MSG_V01_MAX_MSG_LEN,
 			      &uaudio_svc_ops_options,
 			      &uaudio_stream_req_handlers);
-	ret = qmi_add_server(svc->uaudio_svc_hdl, UAUDIO_STREAM_SERVICE_ID_V01,
+	ret = qmi_add_server(svc->uaudio_svc_hdl, QMI_SERVICE_ID_USB_AUDIO_STREAM,
 			     UAUDIO_STREAM_SERVICE_VERS_V01, 0);
 
 	uaudio_svc = svc;
diff --git a/sound/usb/qcom/usb_audio_qmi_v01.h b/sound/usb/qcom/usb_audio_qmi_v01.h
index a1298d75d9f8..c7eee03225ec 100644
--- a/sound/usb/qcom/usb_audio_qmi_v01.h
+++ b/sound/usb/qcom/usb_audio_qmi_v01.h
@@ -6,7 +6,6 @@
 #ifndef USB_QMI_V01_H
 #define USB_QMI_V01_H
 
-#define UAUDIO_STREAM_SERVICE_ID_V01 0x41D
 #define UAUDIO_STREAM_SERVICE_VERS_V01 0x01
 
 #define QMI_UAUDIO_STREAM_RESP_V01 0x0001
-- 
2.43.0


