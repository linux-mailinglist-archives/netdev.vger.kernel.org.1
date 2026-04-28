Return-Path: <netdev+bounces-281927-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCIXDdzI8GmfYgEAu9opvQ
	(envelope-from <netdev+bounces-281927-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:49:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AD648752A
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A44DD32A9186
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7EA466B64;
	Tue, 28 Apr 2026 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DtAn6knq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BhiMwWGK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DD144D00E
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386212; cv=none; b=hP+7JQjXpIBK58vTRQX/Rogetx4Y62JQ5yYyUOJyzawUTiHRWYJsuixKh5+Ww54xNy6/+o9uhK0msw2wnBVZdmBXTH4X0tBRGgOcybb3L01eIz4uM6hUCpyCN66IQkI3GjMa5HgpcgNJBVEfTHqTsoeperXPpxZknZEEYeZRXqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386212; c=relaxed/simple;
	bh=8aNLvyuCs0cA/dQVyyMYQTpbdYd3gLaJzFwxfD7t/3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UbNg1yWbzkLBVP37KVrmvpiSqA0dAUAOqPalBvJHO+aTAfpQtl7YsKv82HgAFTRZerH9ke5Hs8yaY94NTTOCFD/EonLWHOXivQ2fYF2OR2Od/ld7TCF2IjXGaqkshlH1S0+XDZcnBGPAJaFdLkSMk+YbDLxD9CUnnKDG/pnP94g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DtAn6knq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BhiMwWGK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S8qXkY662982
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 14:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Jm6l6UTLyr0NGskSQ/0c9LsflcrnDGa1NCLAOOsHjZM=; b=DtAn6knqeUmwx9Kt
	yl5DkawW+RQTgBprHQ4phVtcWPE7jBsnsjJgw/ee0YFczkz+EmS6GxaLa9qefrjy
	285x9ymwBvfViyaLyksWqIX8SLt243kvbWvUMVwKepOIXt/q/qaJ9msPNOIZ6r1v
	tUjKo1nOMMERMOKRjwq7/qWcfvsbLG4Upaacz7THphct2lW2FasJqtwVaLUNj3v6
	7k127p/VB1RiM0iltEkZUuyAKIAExZi2r7wUx48Nbv2PHdyeRxglifKabRP+lQif
	bnhT4R13shiAIqp2BYCpbPUNEvt7SFXSCSwyE7K2rxi3OJcPKm3bv/v3T13HXrIt
	JkSH4Q==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtc5n4bpy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 14:23:27 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7de44ba64e7so7409500a34.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 07:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777386207; x=1777991007; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jm6l6UTLyr0NGskSQ/0c9LsflcrnDGa1NCLAOOsHjZM=;
        b=BhiMwWGKSC1alLhVU2T2QFBceIihX5bW/wNaAehaBlGFj5wqyA0+Ik3C5lSW/KkdJH
         5M9EWVj5RjWkbe9+ijA1Y2li3E0sRERTWb0WNVf4EChKXLqoqoykaWqoOeObs/w5DJ/C
         evI66CNGwDhewDv78D8ZG+Yt6HhnYyVL/K3kMXpLFLqeFaRNkSk9v+7FZfTBRnLJOabn
         uGgcXVDTnuevrsv2LwhyhVqAMHBuqbqED7ocUIt397U+tFIWrlgch/2sYY+iIZuCsCCE
         mGSudBuRVPhFtkLLVk10nkr7yk/Waekd3Cuu74V6JcWALp6K16TprLLAWaGiQXTsxOTJ
         wOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777386207; x=1777991007;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jm6l6UTLyr0NGskSQ/0c9LsflcrnDGa1NCLAOOsHjZM=;
        b=DXupTUm347G7z1OfOZnbcmWAYqYaSlioAp9BIs3ZPKVZJRQEPtPg9hUcZ6CMrRiRWd
         rt6bm9bYXfO+BpEFDMe6fs4EKRNBE5Ais3k7Fb+YktgussfxBEG8pt74ujShUNwy90Fd
         WrdhVCl6pKl9nmaV3m7LTJSJAxMtuNbqNHMqPJZs/ah+/UEwX4vCm3kNGpv769Hp+teX
         bryMLOp7dxNoAZrlFpgDg+hx9/mnyUs2lsinjeSAHIfdZXOFjZeizoaxEk4+dnlSUuLg
         peZeB5YJbDDpsVws0etmPbFKj/v0162cEBqJhwZ6EvHLWkZpdD0TWNa40vHQAm+WSsTo
         k3uQ==
X-Forwarded-Encrypted: i=1; AFNElJ/l3ZBNJATcIL97IUxRrasiRntBsaRk98TeDED6Y1NnPyYmRTOXB5N5PI/hfdLGqJMTt3IVK7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxojbbDUwkL0tEmVl9z9zNDzhmTpTGbkFcLrKsnfGpnJ7hLPGTw
	mAxl0YlAsHtmdioY58wnnHuq5OXywR/XEq/sejK1Od6ZFWJ2QTGuiPJhjfpkkIDBSF7+6r8D8jj
	V3Q0+zfla5qicrySXMva1KLGcQypXRhcSBvWt671oau6xOvoc+3k8b6NC5zI=
X-Gm-Gg: AeBDieuSlA4SBpijkH4VBrj7W4ndpfd9CjhqI8M/PJza/u17wUGGImrnyc0pBIevuJ3
	QqcbnLrLL5fBnOFlE8LtGbjlUjEzcvlBOIQNLwqb0r0cIH2Oc9Wt4vOaoaPhCbf0pm4Y4Vgw510
	xRWs17gj4aleiEg62wBSskmPnAm1zblQ+/p03q14S0q5tp3gyuTnXPmHWQye5PMG6GH6Pm57dbC
	Ki07/+5xs6yP9J4achkxIfx/yI5IuSll+0FsY5ux7q6Lt/+8ebZP+lRrvoOiKaxBvrvesl2sH5C
	KN9YegAwnXHa/HY52WUM94aVxdrz6ZCfD8MULvNBHDektKHaU6y5wnd+ymydoFm1Hz4Dn+yxj5I
	80KsPODNZ/KIcV1LTY2GEZCh9KacfWA0BpGUUR96/eYZh42X2B+VWQoE/sb3tvoVzziO87zfyzk
	Ckt3uf7IFVFRl3tdebXeaSVuvkGfg=
X-Received: by 2002:a05:6820:2d0c:b0:694:a362:e3ba with SMTP id 006d021491bc7-6965cb93af6mr1550282eaf.48.1777386207314;
        Tue, 28 Apr 2026 07:23:27 -0700 (PDT)
X-Received: by 2002:a05:6820:2d0c:b0:694:a362:e3ba with SMTP id 006d021491bc7-6965cb93af6mr1550261eaf.48.1777386206866;
        Tue, 28 Apr 2026 07:23:26 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:653f:4d28:6a78:a6ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80ba9b8c8sm107072666b.48.2026.04.28.07.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:23:26 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 16:23:11 +0200
Subject: [PATCH 6/9] dt-bindings: bluetooth: qcom: Add NVMEM BD address
 cell
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-block-as-nvmem-v1-6-6ad23e75190a@oss.qualcomm.com>
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
In-Reply-To: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEzNiBTYWx0ZWRfX+QUmTTi2n5Hy
 AtQfieZrWienpWHM+oCUB4cbChk2JC8q7Fs1eaqntXdWvKAyI8vAXJBZ+YJaXU3D4OJZ7bN+tnJ
 xOHXaucInpUb97WaKJThpv5y3KspxmITaEsoIrClEDgkRcwam1qXJqXToIL9u9dIYIT7Dt9+1H0
 xX+XIgu7TuYebGrox6FtqIpPnuw15D+aZ2K659O0pUIuuHeGkCj8lHHUdalu+am0FpVjeK3eB/4
 9149reGZElDps94hwiEjNcalzmIfVLpKDFlKUswdXrorLiUX6gf0w7PIGNei0S22ayUrKz7R0bd
 eoa5Pzta8fshbii4cG03uTCQqh6YB0/6Ao5ypxHiZUWMdZSSYH/jaZzZ9zRP4hHarW2Vix0ysWB
 aPxNoyoNGS9u11r651A0cOLKnDAh1RhdqWOK1mCXEP2ACOhxfQ5zyT93K68ZP2sGqueqiyaCSEE
 nPHkP0VvICW1W+2PbXA==
X-Proofpoint-GUID: UHQwQurgWbfY-8aIulo_rt2hXS-aRkFm
X-Proofpoint-ORIG-GUID: UHQwQurgWbfY-8aIulo_rt2hXS-aRkFm
X-Authority-Analysis: v=2.4 cv=ZMfnX37b c=1 sm=1 tr=0 ts=69f0c2e0 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=jFERsaRKWwo8c2z-USAA:9 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280136
X-Rspamd-Queue-Id: B0AD648752A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281927-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Add support for an NVMEM cell provider for "local-bd-address",
allowing the Bluetooth stack to retrieve controller's BD address
from non-volatile storage such as an EEPROM or an eMMC partition.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../bindings/net/bluetooth/qcom,bluetooth-common.yaml          | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
index c8e9c55c1afb4c8e05ba2dae41ce2db4194b4a0f..ecb3de65506f7f0f1fc1d0b9bbd316163b7c26e8 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
@@ -22,4 +22,14 @@ properties:
     description:
       boot firmware is incorrectly passing the address in big-endian order
 
+  nvmem-cells:
+    maxItems: 1
+    description:
+      Nvmem data cell that contains a 6 byte BD address with the most
+      significant byte first (big-endian).
+
+  nvmem-cell-names:
+    items:
+      - const: local-bd-address
+
 additionalProperties: true

-- 
2.34.1


