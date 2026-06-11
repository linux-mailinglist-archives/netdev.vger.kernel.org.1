Return-Path: <netdev+bounces-298289-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1dafFbQAK2pC1AMAu9opvQ
	(envelope-from <netdev+bounces-298289-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:38:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B0C674814
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:38:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=LBISvqjr;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=RQ9XhPck;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298289-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298289-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B74A631152DF
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA98F4C77D7;
	Thu, 11 Jun 2026 18:38:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2224D2ECD
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 18:37:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781203082; cv=none; b=QiIqIQAzy9RyvxJ5fQfQVA8NR7c2PR/qEoQn0+y5bCtZ04CHZzvmB3W0RyLd8xTtOzWTRRqbS/o8yiItaIHSWNTlGuTd8TEx7n9iKnAPCYp/yjQ+/VMfPC5VGsdySqQ4v9dGWIaRGnOkdKR+NFDR2C52c97k/IquttrAs7S8vPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781203082; c=relaxed/simple;
	bh=oMO8EvsYcPF9+TMaWUdj9tkVVxeogwjZP8T4RkGhCRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j/oY3Us+X9TMlMRDRxHOzlnm6owGKvgCXTT3QOjiYDVpaJHtaLF6slTMxkVZYCdljcA7CHa62hRHYHcPrB9VdR6PCOHdk/8vKTkswah1yVsmC3JgMlL696J0p6T0RxNS/uoDCNguRPzrlp/il0+osIZ79Mwuzurb8BQBU7P2Ozo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LBISvqjr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RQ9XhPck; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BIRou61433771
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 18:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6iIX6YyczVTNZnfKhOGek1sSjpYCGtZFfO3vE1d1fHE=; b=LBISvqjrAxNErqiw
	sm9BUhuYLMngvTPRfyRU3n2KbBXwgMlTFAqKvBku17LdMduU/zaqD0iPkDqAIblq
	+IgyYa9PqOyEvUt0A1ByezDcHv9WCIqY2VGjLkFVm7df9ZdA/IXuY1+fiWGSb/sP
	YfJXZBRP2bBeL1qAFFE9Z4/ewiNsKdt/hvPWCumJGsasvJbs+m9PjH+yEp4k9VC7
	RFuoOlWsQZ6JOuVR41KyATDGuB87t5Jy/6FR6NAn3wGFvuUt3q/kdeKdvwGNwsgF
	lQiUE/Tq0pvVkHYq/qV9ryyJgMxWZBJCyqTE/mi0h6+hMPMF39a5pEOCTn1Lb0hm
	4ac+Bg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqtb5jddc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 18:37:54 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8422a0eee68so247248b3a.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 11:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781203073; x=1781807873; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6iIX6YyczVTNZnfKhOGek1sSjpYCGtZFfO3vE1d1fHE=;
        b=RQ9XhPckiCLXr+HIr1iFTkhknPRZMYcM2a2sAl7V98dcPkVQFHsDxpcYYaVAEiNe6A
         LCk0XJxL2kzDtcSkbQngv5YNvlibKoLvrwIGoTY4N1FJVJ6BTk2B5Xp/yXEjq7jHDcKu
         4ip7498at7YSwsKMB1NJUc/gjxzlePR6WIH7JAGMhrYjlh1CcVpaQdyd++9KtlQbuJa2
         3TeXdxS+rXSkFje8BbJas6ndtWMfHFtPhpqApyT6ZztNNv46qkpBITRuCZPLp+Zc0MNP
         D5WUaX0+Kt37HdFM7F2QDPZ5OSoZndp/BYCxC0Kz/kz/8kjZdEu6VgdmaSTAeYS7EUB0
         jsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781203073; x=1781807873;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6iIX6YyczVTNZnfKhOGek1sSjpYCGtZFfO3vE1d1fHE=;
        b=fgkTmxWSwYZT3eqXkbBct5QeFxmnpWrhsB4BkagmnqJjHJHNXLRPvxM2mgom7z7jXZ
         u8MWtUqBz1zSpd7M2BlonPkNaxkOoyaF/3jXheo32zWkiX8HUvup/Y2T9537xdl3N6lx
         kwI7veJ/LOJrpxrqSb5cW9X0YFNgYLXpCK/d4vd84B++h31ESNuu0UocO7JAQ7wCm33u
         tWbo622unKxPBX+2EVTqMHjIKeU35aViP3XsHw2XnjQfw//ugaRcKjLRYsMR/G6DbB5n
         EeWaC8AuPX+leqLDENv4c2mXmsvFO10bf8nHCO9YpkjW5nP7NoKXpI1l0XMVSnoScr7k
         148A==
X-Forwarded-Encrypted: i=1; AFNElJ8h1JaN9FlRJXfKFjRVkat+M4Y93+5VZKRquWUbkmKwpjfl7k30rZU0iMY4wY7ETtshxXppao0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ4w4y2V13MM+1yp1c5pi3/4r8NCdPmXm1NoYs+4ymqni9/bBg
	RD3VXuLgH8tPUgHl3IvxqydMWJ9InLa8ufRNpWk3RLkqpFH7wUX4tG2V3KSNrQFAN7q6bDdzLaU
	ssOpwULjgE9WKWSjnL9HG5/zfno+a7q2ik5sPOREyeW6Rq47tw+tWODRKFqI=
X-Gm-Gg: Acq92OFiVmQXkj06AqJohkamDv69xyApjp6BX28ePRLnT6BoyyWPlxFm24Yblo46UB9
	BNwtSHdJE2+C+OCOdLbf04qHAbYK/6yhRMQTLeMuoXmgSt32021KQnvd6qjmKPUpNkOevpht0P2
	i4qdkStVWbZSKYx3I9iT5T2ZsW/46wUE4dUbVi0436oBumcxSPwwcAHbVQjEwIt1LNyJ2699j5C
	8MqA2OjKVZxBaatSUnCKgJbcmUlFePG4zGxGTTlL3UmxxciocC4OVKjh9nV20NEwFaRjWZEOFWK
	tjITfwQnjFNDMK737L3QdTo/REjByt4nwIvr+lTxK5/x8vm0BOMA69IYpHR2jAFIqUvT0I29zq9
	tcmSKDt5/7mYYEMfycuiL84NJS1FtV2931ObgcuKBaaMP1cVbU7g=
X-Received: by 2002:aa7:888f:0:b0:82a:17b6:53ca with SMTP id d2e1a72fcca58-84336bb0236mr4556619b3a.38.1781203072955;
        Thu, 11 Jun 2026 11:37:52 -0700 (PDT)
X-Received: by 2002:aa7:888f:0:b0:82a:17b6:53ca with SMTP id d2e1a72fcca58-84336bb0236mr4556584b3a.38.1781203072506;
        Thu, 11 Jun 2026 11:37:52 -0700 (PDT)
Received: from hu-mohdayaa-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84337bbbfacsm2555666b3a.20.2026.06.11.11.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 11:37:52 -0700 (PDT)
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 00:07:02 +0530
Subject: [PATCH RFC 6/9] arm64: dts: qcom: shikra: Add ethernet nodes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-shikra_ethernet-v1-6-f0f4a1d19929@oss.qualcomm.com>
References: <20260612-shikra_ethernet-v1-0-f0f4a1d19929@oss.qualcomm.com>
In-Reply-To: <20260612-shikra_ethernet-v1-0-f0f4a1d19929@oss.qualcomm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781203027; l=3434;
 i=mohd.anwar@oss.qualcomm.com; s=20250907; h=from:subject:message-id;
 bh=oMO8EvsYcPF9+TMaWUdj9tkVVxeogwjZP8T4RkGhCRQ=;
 b=KroYwCn/3i+MFwy5h43g8syHSEKzKdoXtCPwEvaDoiOtf4wd25RpWtOWNNMR919JjBGGbXbma
 HmGbKLG9YAdASCvawXcOKjCh37wDC4o4t2BxpzwI7B08uNFv+rgwL5A
X-Developer-Key: i=mohd.anwar@oss.qualcomm.com; a=ed25519;
 pk=7JNY72mz7r6hQstsamPYlUbLhQ5+W64pY4LgfSh9DJU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE4NSBTYWx0ZWRfXxztXZR4th0+A
 XBe3LROl3/Q8RkEmuZaw0JZ993MrMxekMWi2GVojAo/DYh8NPIodTijg43GSxNii7k8Q4sub2n4
 T9/UDvha5NBf3c9KjGQLThkQ9DJHCdGJLHr6S9JDH6Gd+F34X32iTkr99jMgsoXjHWfxBOXqoID
 ZAnvuDmqnPkJKyx61JRsJNVIj6uHUMELJ/XCjsyie5aadkEPKNboFTWmtVmrgdIuIFDK9phqZ2g
 2gPiZQESSk54+8cJqiO5e2nV1U+uI8I/tuNk105Gg18mUfnf4C9ovltxsIV28/HbdzQRkn6LAaH
 TFtAaC87ygpSu36tw0IxORAG3yNnm3RFYD4NyLN5Xo2AVmOM/a9ulU+x5pe4n/kNYA2hQb8YSr7
 9eJeuqhDFf5Qr+hBGOnbtFGoWqpyZvawFvkoN8h1cGpmJyJK68eC3JR//tryBpthvB3JLdTLx4T
 NCZaFub3EvXRB5gjpwg==
X-Proofpoint-ORIG-GUID: jXM_Z6E1PhHe5A_YUXFPhaV1wHruD_zE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE4NSBTYWx0ZWRfX4NWhwGy8+jrs
 PuiFvUQ6BD/BPCENd1IwJ+z3ulp6aSERp1qf5hIWCv7oNdrqycOImnf8A/pAO0HHHfFPhfLt9kW
 4uWwyaMuOfDiKBCp2we74Tl21iatqTs=
X-Authority-Analysis: v=2.4 cv=e6g2j6p/ c=1 sm=1 tr=0 ts=6a2b0082 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=z42-wsbaeSSsZQV_GzIA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: jXM_Z6E1PhHe5A_YUXFPhaV1wHruD_zE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_04,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110185
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298289-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:richardcochran@gmail.com,m:andersson@kernel.org,m:konradybcio@kernel.org,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:linux@armlinux.org.uk,m:linux-arm-msm@vger.kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:mohd.anwar@oss.qualcomm.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A3B0C674814

Add the two Gigabit Ethernet controllers present on Shikra (ethernet0
at 0x5d00000, ethernet1 at 0x5d20000).  Both nodes are left disabled;
board files supply the PHY, pin-control, and queue configuration.

Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 78 ++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index e67fe047a683aa566b444a847b57b4b47a25aa8a..cac1573e3eec9e52b62f4b4cd7c564c70d0d8f78 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -1990,6 +1990,84 @@ gpucc: clock-controller@5990000 {
 			#power-domain-cells = <1>;
 		};
 
+		ethernet0: ethernet@5d00000 {
+			compatible = "qcom,shikra-ethqos";
+			reg = <0x0 0x05d00000 0x0 0x10000>,
+			      <0x0 0x05d16000 0x0 0x100>;
+			reg-names = "stmmaceth", "rgmii";
+
+			interrupts = <GIC_SPI 478 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+
+			clocks = <&gcc GCC_EMAC0_AXI_CLK>,
+				 <&gcc GCC_EMAC0_AHB_CLK>,
+				 <&gcc GCC_EMAC0_PTP_CLK>,
+				 <&gcc GCC_EMAC0_RGMII_CLK>,
+				 <&gcc GCC_EMAC0_AXI_CLK>,
+				 <&gcc GCC_EMAC0_AXI_SYS_NOC_CLK>,
+				 <&gcc GCC_PCIE_TILE_AXI_SYS_NOC_CLK>;
+			clock-names = "stmmaceth", "pclk", "ptp_ref", "rgmii",
+				      "axi", "axi-noc", "pcie-tile-axi-noc";
+
+			power-domains = <&gcc GCC_EMAC0_GDSC>;
+			resets = <&gcc GCC_EMAC0_BCR>;
+			iommus = <&apps_smmu 0x0380 0x0007>;
+
+			interconnects = <&mem_noc MASTER_AMPSS_M0 QCOM_ICC_TAG_ALWAYS
+					 &config_noc SLAVE_EMAC0_CFG QCOM_ICC_TAG_ALWAYS>,
+					<&system_noc MASTER_EMAC_0 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "cpu-mac", "mac-mem";
+
+			snps,tso;
+			snps,pbl = <32>;
+			rx-fifo-depth = <8192>;
+			tx-fifo-depth = <8192>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		ethernet1: ethernet@5d20000 {
+			compatible = "qcom,shikra-ethqos";
+			reg = <0x0 0x05d20000 0x0 0x10000>,
+			      <0x0 0x05d36000 0x0 0x100>;
+			reg-names = "stmmaceth", "rgmii";
+
+			interrupts = <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+
+			clocks = <&gcc GCC_EMAC1_AXI_CLK>,
+				 <&gcc GCC_EMAC1_AHB_CLK>,
+				 <&gcc GCC_EMAC1_PTP_CLK>,
+				 <&gcc GCC_EMAC1_RGMII_CLK>,
+				 <&gcc GCC_EMAC1_AXI_CLK>,
+				 <&gcc GCC_EMAC1_AXI_SYS_NOC_CLK>,
+				 <&gcc GCC_PCIE_TILE_AXI_SYS_NOC_CLK>;
+			clock-names = "stmmaceth", "pclk", "ptp_ref", "rgmii",
+				      "axi", "axi-noc", "pcie-tile-axi-noc";
+
+			power-domains = <&gcc GCC_EMAC1_GDSC>;
+			resets = <&gcc GCC_EMAC1_BCR>;
+			iommus = <&apps_smmu 0x03a0 0x0007>;
+
+			interconnects = <&mem_noc MASTER_AMPSS_M0 QCOM_ICC_TAG_ALWAYS
+					 &config_noc SLAVE_EMAC1_CFG QCOM_ICC_TAG_ALWAYS>,
+					<&system_noc MASTER_EMAC_1 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "cpu-mac", "mac-mem";
+
+			snps,tso;
+			snps,pbl = <32>;
+			rx-fifo-depth = <8192>;
+			tx-fifo-depth = <8192>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		dispcc: clock-controller@5f00000 {
 			compatible = "qcom,shikra-dispcc", "qcom,qcm2290-dispcc";
 			reg = <0x0 0x05f00000 0x0 0x20000>;

-- 
2.34.1


