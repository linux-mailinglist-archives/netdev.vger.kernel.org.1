Return-Path: <netdev+bounces-265786-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDj8LJxSr2lMUAIAu9opvQ
	(envelope-from <netdev+bounces-265786-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 00:07:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E86E242857
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 00:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 955CA30FCF47
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 23:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B373B9605;
	Mon,  9 Mar 2026 23:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lBfD8/ns";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LRXwQU+a"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378B238F95C
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 23:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773097552; cv=none; b=l6H7RjOAvy+mFSfiZvdf7soecv8QDNZ8GhSLXZ35uDY3D3hj+VqOsE/rPKqps4aViu2j8qEK/7vHju7yQHslvORPQlFf2DESaFkusimNOUSBZp9J9ezgKthhzs2mD3PuOgEdzrnigdLeKxnXOj87FrA6NkQZi2Hx/fmvCRtCBac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773097552; c=relaxed/simple;
	bh=zL69uAdweI4X0y0Z+IAisT4rMg++38nfIAzKDgVfeho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqoJH//ta7nmqj48118Rwd2PHf8Lq0PHGoHlBx0FAdy2axyaP3YAo1eI6HxRGzCv6k1Qo+hW3+BPq/iom7fRooq1Zq4CidVbTYQaAvUfweZsTKCyCI81duza+HbK/FI/mKazGiEEIDY40hDWfuk3dCok5DZNM8md5qLVy6lj2is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lBfD8/ns; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LRXwQU+a; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629HBlbF296190
	for <netdev@vger.kernel.org>; Mon, 9 Mar 2026 23:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=PTfKdHxXDsD
	Bf9qbtcJy20RFKCKAaUi+C0QbWC3j2OY=; b=lBfD8/nsjfep7uWpNTtXTTH97LP
	adqHrnvrTVmVgz0lWbAL5VcrdHrI4FRTSXkiz+u1QcKmurgn/d88hHz/4iBBAoj+
	SgF0dP66UX7GP3KqmHq4FBR51A54fIi9wNxDZIo/awWFssBbLgEaNe0j8xL0eSu4
	6ohLKXiqBj9NRM3ztv9YLcdyDch7tWK3LyfdOBKXfoqDRIixooDyqouwjHgLJuOl
	Z4pMUTPjrfg3DUOyVZm3GPKNXh9IR5fH1JW8M+0dXX3xAhqbHxUTvP+UD3hMdiGU
	wmJYD7HdlW4rfeiSqQS1ja79m2ZdhWjJOgTQi0iWoF0sex2KenSTQG+ihSQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csyfy1ruq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 23:05:50 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd77e5e187so1438770885a.1
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 16:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773097550; x=1773702350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTfKdHxXDsDBf9qbtcJy20RFKCKAaUi+C0QbWC3j2OY=;
        b=LRXwQU+ahVItUcd7XgXpLBKk5T4a+a5v6R6I4NCx63YBkMPsfSObF81oTrOp9iicyx
         EX5IYkV1xt3/rq6xrlSZKL1xf8Wt/x+iM+Aj2DALp1I0Dj+s1gTq0P9teJ6Qv6BiPEjt
         dgDHeQOLJnZIhSpmp2laI7BsJNlEW1f59plbJiL5roVffGTQvRPrb8vo1wkmrVzk2z8v
         RVE1UHlvuz73x7lVpOHZKmMQHJMZ8b/HuoKyWLA0poACviJINMqGokaD9KgCDuhdoQx8
         LFQFG4C9GJTMj1yek+rSh1WcZrZSg/GSn5mqePkPpMAH228P8j4IdekoA1JA4qaNeaPi
         iQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773097550; x=1773702350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PTfKdHxXDsDBf9qbtcJy20RFKCKAaUi+C0QbWC3j2OY=;
        b=Ek8psE0tiySaI4mbKenLSIeWOeNZpOcq8snGRFpyUW9QmdpMYAZKG1VjAsMMvpsevA
         IH0VnkLvyUmCsFl6rwbygJap4JLp7bViKe980aeuwW6iVFR6j4+tqnN0LCNpmggTi7R8
         aIMgveeU9Vjdr3/sbm4bl4DDsR1NeI/VRAxbiz3uUpOfM+fn0yGHE6N6miOgmkaKUpxA
         9zX1SZD1KkBjFoaARgzj/V1n8dofgB6JFL8zGKumhg5bhyrI6bmHsIcER333LAkvBCXc
         b8DcCZsVqUzDW3J2vczyEtzn6gQVmKoQbXfxRVR5d6DBm/aBitbtXyT6LuuHM7nq7A96
         LSHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEtHy+25r/LzzXl5hUaxGlCV3SN2QgpxaXGdNkLj2FFu4rYJQScOxYSPO7vorlOIUGhjKQ8YM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKe9+5Kjl9aVd8A5onESWTx94YiMW525/wEj3DV37qiCPyLX7N
	89zppQupa9V90zY/6ySvZEfs4Ior2bGwh3sa6tHbbzHNU1jZXQ9Wi1jOwz7xa5IdBbvCE2JR+r/
	Dblr/Xd4Hewq73R0ooppAkiqtMvhva5myVRtcOrX/NKjw+dhhEaRi9lZUyiQ=
X-Gm-Gg: ATEYQzyzAQ6A+MuqDXC+0sgCdGnZ8WEk3o4H1d/sVoySogtzf6SNWKChwPLCOh4/Scm
	H2z4KISP02zEmG8naChKumwo9Sn8twXzPGezdynwNGxQmpnRdFgouYZ/0fduNTRaxxLLm8PnHPu
	D/D+B+QxlFiFhajKU6aqkG0f85l+0iWHBBZI/sHI24xhNk3E2GbkzLHrGM2SqJOUaNQan5rhIMN
	c4jS9nXM1UVNIygmMBpqKEKdvA9ltxKhsBe1c1gL8bogXSwPTypuYoRbdkydrHzqeOdMi11w2sH
	fNtUVtRLjTGFRDR71NFHLFi8PLizGIF+AkmIX4BxbeJKY5714nnhq6bCNxx+SK0yE+/wmtAgwxT
	RarenMymIp/7467rSi0bzKhrlO7eQC4k91mDEozqdEkWeF/MNxA==
X-Received: by 2002:a05:620a:4002:b0:8ca:2a02:dfd5 with SMTP id af79cd13be357-8cd6d38f9bemr1747206985a.30.1773097549768;
        Mon, 09 Mar 2026 16:05:49 -0700 (PDT)
X-Received: by 2002:a05:620a:4002:b0:8ca:2a02:dfd5 with SMTP id af79cd13be357-8cd6d38f9bemr1747199885a.30.1773097549238;
        Mon, 09 Mar 2026 16:05:49 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae3d98asm33898478f8f.30.2026.03.09.16.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 16:05:48 -0700 (PDT)
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
Subject: [PATCH v1 2/8] net: ipa: Use the unified QMI service ID instead of defining it locally
Date: Tue, 10 Mar 2026 00:03:31 +0100
Message-ID: <20260309230346.3584252-3-daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDIwNCBTYWx0ZWRfXxIBVrc/ys+u7
 UQIXnSJ9zIlUDxsImxNEqh74VourmBL3Act1rJYXZqx0VGnOBHiy4rFApZsfLlFqOW+k386hPib
 mulbLByeyiIaIhsU3m9MBkWcci+Es72x/z+ZfokJzfDh0UK/z8BoRY2fjzaFX9+sTcubh+TcIW4
 T7gLYVoBVWSUFAgZcIKISx0rh4fnW83jXMafDh/lq81Ranxy2uY17PFG0F6Jl82yc7Z0FT76cjE
 rO7fneZ9qgvFwXV+GL0vp3YuknZM3Jtb+PFHRxp2EFQMhlV3dIciGQr9FmfmzYPRhjiR9fN/rVM
 Kz2Gt3zd1jFoGrMU5YlX38ylnIeIINDehfbMDU9s7dwRx12Vdnfk4pazGtpFFGt9qlPAL2Wopn1
 x5171aWR1GcXkqyJJsCYKkrBoDknycZ1s9hfr3gp8lD1ZvACxjyb8yZRTm0e9SclSMTaFTJ1bwc
 fAmVoWsdNBnax+XM3zg==
X-Authority-Analysis: v=2.4 cv=OcmVzxTY c=1 sm=1 tr=0 ts=69af524e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=shTvKy1OFHrmHVGPjj8A:9
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: x6f9YF4ZO4uwQLxvgYGpbqNpc1otoojC
X-Proofpoint-ORIG-GUID: x6f9YF4ZO4uwQLxvgYGpbqNpc1otoojC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1011 adultscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090204
X-Rspamd-Queue-Id: 1E86E242857
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
	TAGGED_FROM(0.00)[bounces-265786-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.lezcano@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
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
 drivers/net/ipa/ipa_qmi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ipa/ipa_qmi.c b/drivers/net/ipa/ipa_qmi.c
index d771f3a71f94..37936ad132a2 100644
--- a/drivers/net/ipa/ipa_qmi.c
+++ b/drivers/net/ipa/ipa_qmi.c
@@ -66,11 +66,9 @@
  *   determination of when things are "ready"
  */
 
-#define IPA_HOST_SERVICE_SVC_ID		0x31
 #define IPA_HOST_SVC_VERS		1
 #define IPA_HOST_SERVICE_INS_ID		1
 
-#define IPA_MODEM_SERVICE_SVC_ID	0x31
 #define IPA_MODEM_SERVICE_INS_ID	2
 #define IPA_MODEM_SVC_VERS		1
 
@@ -484,7 +482,7 @@ int ipa_qmi_setup(struct ipa *ipa)
 	if (ret)
 		return ret;
 
-	ret = qmi_add_server(&ipa_qmi->server_handle, IPA_HOST_SERVICE_SVC_ID,
+	ret = qmi_add_server(&ipa_qmi->server_handle, QMI_SERVICE_ID_IPA,
 			     IPA_HOST_SVC_VERS, IPA_HOST_SERVICE_INS_ID);
 	if (ret)
 		goto err_server_handle_release;
@@ -501,7 +499,7 @@ int ipa_qmi_setup(struct ipa *ipa)
 	/* We need this ready before the service lookup is added */
 	INIT_WORK(&ipa_qmi->init_driver_work, ipa_client_init_driver_work);
 
-	ret = qmi_add_lookup(&ipa_qmi->client_handle, IPA_MODEM_SERVICE_SVC_ID,
+	ret = qmi_add_lookup(&ipa_qmi->client_handle, QMI_SERVICE_ID_IPA,
 			     IPA_MODEM_SVC_VERS, IPA_MODEM_SERVICE_INS_ID);
 	if (ret)
 		goto err_client_handle_release;
-- 
2.43.0


