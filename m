Return-Path: <netdev+bounces-266027-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGFAJNv/r2moeQIAu9opvQ
	(envelope-from <netdev+bounces-266027-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 12:26:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3473524AAF8
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 12:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4092C303DA2C
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1565C38A299;
	Tue, 10 Mar 2026 11:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zf8QWLRV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A859387361
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 11:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141851; cv=none; b=IAwXMZkSqZiWIheAGxWsd6NsGc+n1RvYfBNxox/uGbeesTAeGNvWhqBw1wV1sOX5hc1ERClbBZnu5drck/PMuo1l4d8YOHGued55CcVjfElkDSt1H/M33t4NEihuWRF7p0ccAjvs4KjazPU1Lkr5GifHef9f4T9G2yfXIU3dXpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141851; c=relaxed/simple;
	bh=o/uqIjeuUzOOdf1q1N1+cQPwX7j5NTyoms2N9zoaY98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iE+W1XF6uq+XX4MNNy2wZb+x0Bm17VUaqJan7qBMNNARvqeCq3MY1X3tgcls90QQDlkZf5dKS4VDo4+Ww0SeWCyyFv2tKJzb1FTq5jnVp5t5b5F9dNZY7nMdxoYWZNoM8pd/Yyi/rDXZ5Z+NnUHqmm3VJd8c2vLSdr5VDva1Xz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zf8QWLRV; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48534e9076fso17389635e9.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 04:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773141848; x=1773746648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwm5kS48yTdTQ1D8tWJC+uRL7HDVBPU6IqwJ3u69y1E=;
        b=Zf8QWLRVNTuEIVpyaW080ywpJGB+2vtg+MVVrT413Bea3LfydSSQ1m9D4Xf2HmDbov
         q47DIX8xXrj098qMSN6FRNAN7D/wyEx87Mum3LK8JCIBsaDIaPUvTll5OfDm8pgMk0BI
         9IpnHLAzDawuOduKXgfFWaexDlIj6yvV7QpabpDq8vfcDfMWLrJfFeif4xrj6oYKN9m+
         m4u7V+qRPZTNPzFFMPzIYWYq2UEm4TOg+a1sTm7JupRvYH1dR2GpusvPeKmPX/vm4T5h
         G4fdH/qsdeRr7zQFPDwLBhSw8ejoej2n2C8BC55DWmfdNpeMk47EPBo+iMgPv06e7o0/
         kCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773141848; x=1773746648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zwm5kS48yTdTQ1D8tWJC+uRL7HDVBPU6IqwJ3u69y1E=;
        b=Bzduw4YYQ4Ej6VmUtSBAgOVI56h0ZxSnIHGtCPwHVpVRYkWUcqU3FdS40wkd9V4pMP
         CkmYN9BQ8Vf9xI6tUVbzNGUoTr4Z8fv301e3ki9czYSF8BR8EvDKXB8TDdSOWW082JWQ
         0bi0rACmZW1T4OuEw9ZijgVZd1Sv9oiSt9MPgfm2xvQM8TyIzIBg3m3kTy52eeBqmJEZ
         gh2fJmJEJr/kne2QxOlzolHRhvZafxViWOpVSFgPS4ikDg/EaAJ/rwSUF+L31SV1zEJr
         2q2MjATc+G/bimlTW8jNN3egsOSrKgIflyg5XinJphz01penReTshv+6RycJ88Wxu+aG
         4XGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZk2Krzr0jTbXZkFq0T2lBSCi2OHo3ElX+bsRGZXgwDG4jr1oQBP34RUv4OWQUX+nHu4HSTIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlW0YhIV4T4TJcvLHHwPAnoeTgeBM96TbHveDfnpiyeCBfSA0A
	rz+74ilSrATGDhwrQJ6KaxOIDztNRBdP+RIbQeYJamS8HO6jqcBV9RD6
X-Gm-Gg: ATEYQzzjINE5Ws3mnIjCLnXpI+wJ5ll9S4iwHvoymyDlpnhyOlbafMYC6sRy8u5Ppgo
	VKpJh+0b/PAk1uut2AypvoKd8IfKZOKPsZcsGOZavw9JjplrGWw6Lvl5vm3Ic4oB8SxiQpqhe17
	cTZLDUzk+LSBiTYCGrdzUI1gSyZqC/hczR4S97VBnS0T9GS9n3YDPd6yH/Yzu1MY7Lum9JtTZqG
	txTLyoN3kquvoR2+6DSzpS6DtX0hMqNXRGoW3ws0d5BD7a5k5ROOWWUg+Wl7CDYJ/MZwd6HHET5
	XilCWMtPnEDFXTbpYHidnnmV4oboKr36dfUsj0qgdTMR2wk88zpY20kF6yVp2njcuDMc/+Fb8MA
	+Y0+nrL8aQRvGDKXLHJbV/0f+eh+2dcUMRp6Z6kltemCBaJjU6yQP7lkqKShVDnhFLnGydAWPQm
	34T0YZJ+H8VW7ul40GWJcqLAHQusOZmDA1MA==
X-Received: by 2002:a05:600c:4445:b0:483:a27e:6706 with SMTP id 5b1f17b1804b1-48526922533mr263095895e9.9.1773141847742;
        Tue, 10 Mar 2026 04:24:07 -0700 (PDT)
Received: from T15.. ([46.175.113.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad97abasm32238560f8f.10.2026.03.10.04.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 04:24:07 -0700 (PDT)
From: Wojciech Slenska <wojciech.slenska@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Wojciech Slenska <wojciech.slenska@gmail.com>
Subject: [PATCH v2 2/2] arm64: dts: qcom: agatti: Add IPA nodes
Date: Tue, 10 Mar 2026 12:22:31 +0100
Message-ID: <20260310112309.79261-3-wojciech.slenska@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310112309.79261-1-wojciech.slenska@gmail.com>
References: <20260310112309.79261-1-wojciech.slenska@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3473524AAF8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-266027-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wojciechslenska@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Added IPA nodes and definitions.

Signed-off-by: Wojciech Slenska <wojciech.slenska@gmail.com>
---
 arch/arm64/boot/dts/qcom/agatti.dtsi | 53 ++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/agatti.dtsi b/arch/arm64/boot/dts/qcom/agatti.dtsi
index 76b93b7bd50f..dbaae258f3e7 100644
--- a/arch/arm64/boot/dts/qcom/agatti.dtsi
+++ b/arch/arm64/boot/dts/qcom/agatti.dtsi
@@ -433,6 +433,18 @@ wlan_smp2p_in: wlan-wpss-to-ap {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
+
+		ipa_smp2p_out: ipa-ap-to-modem {
+			qcom,entry-name = "ipa";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		ipa_smp2p_in: ipa-modem-to-ap {
+			qcom,entry-name = "ipa";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
 	};
 
 	soc: soc@0 {
@@ -1641,6 +1653,47 @@ usb_dwc3_ss: endpoint {
 			};
 		};
 
+		ipa: ipa@5840000 {
+			compatible = "qcom,qcm2290-ipa", "qcom,sc7180-ipa";
+
+			iommus = <&apps_smmu 0x140 0x0>;
+			reg = <0x0 0x05840000 0x0 0x7000>,
+			      <0x0 0x05847000 0x0 0x2000>,
+			      <0x0 0x05804000 0x0 0x2c000>;
+			reg-names = "ipa-reg",
+				    "ipa-shared",
+				    "gsi";
+
+			interrupts-extended = <&intc GIC_SPI 257 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>,
+					      <&ipa_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&ipa_smp2p_in 1 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "ipa",
+					  "gsi",
+					  "ipa-clock-query",
+					  "ipa-setup-ready";
+
+			clocks = <&rpmcc RPM_SMD_IPA_CLK>;
+			clock-names = "core";
+
+			interconnects = <&system_noc MASTER_IPA RPM_ALWAYS_TAG
+					 &bimc SLAVE_EBI1 RPM_ALWAYS_TAG>,
+					<&system_noc MASTER_IPA RPM_ALWAYS_TAG
+					 &system_noc SLAVE_IMEM RPM_ALWAYS_TAG>,
+					<&bimc MASTER_APPSS_PROC RPM_ACTIVE_TAG
+					 &config_noc SLAVE_IPA_CFG RPM_ACTIVE_TAG>;
+			interconnect-names = "memory",
+					     "imem",
+					     "config";
+
+			qcom,smem-states = <&ipa_smp2p_out 0>,
+					   <&ipa_smp2p_out 1>;
+			qcom,smem-state-names = "ipa-clock-enabled-valid",
+						"ipa-clock-enabled";
+
+			status = "disabled";
+		};
+
 		gpu: gpu@5900000 {
 			compatible = "qcom,adreno-07000200", "qcom,adreno";
 			reg = <0x0 0x05900000 0x0 0x40000>,
-- 
2.43.0


