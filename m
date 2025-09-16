Return-Path: <netdev+bounces-223616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19277B59B3A
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 17:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 114A846079B
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 15:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FC434F492;
	Tue, 16 Sep 2025 15:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BP6c457A"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6400235084A
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034803; cv=none; b=PqVb2uZTr3d/jHgeyFjEbyVV9M2IfIQaZviSo8KvekObj37oLuo4XqnbcG7CTnoKBBYsOBKSCN1AQn/sVVFSsn6ZYOwLtu9+d4zE2I7KartfuqIM3DF2bZSOTIAME6sPOTqOHuip2oQpY+DLpPaDtzbso2J/ErnxMDwVpdzGLK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034803; c=relaxed/simple;
	bh=oJ1RvJCommkmu9uglugPl/o5TOg6XYqZSj96bt3gm08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LxT8Yxa/3V2f5FDu0bePPiDGOZM+Ldp6CvJ3BOfRQdRXDA1jJZbh2CZEGDUfOY1Gwsz80QPLx4X0t56b3BslsBu6jnhlmm1a9Rnh7w0S9w3RpO+p7u2VYLBBFPoaOnyLSGuVYWWLJI3P+aIpjRya/uMvZI8ep9cb51QBGNQsbGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BP6c457A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GAVfw0020449
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 15:00:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3y9/lW+dUggFVSzfvHXuYGDXV3KHAmr21I+oLDCe+i8=; b=BP6c457AMgOmA8Qq
	+9foDnaL89aXYEN3YU9efDfS0GLXitIv5xyZsL8+/p4zs3APfoupCb/yJzTxSrwm
	PdXMVv8ynjhRswXsZmn2uSB6rM+Ju0owI+02lVyWdgo5TM2Y9ejhcvUcdLIL5OT7
	a0Jp66kaOHKLcAK4NaDThWY1TkPS4R26p8K7KG7uMbLZJlD7ujkbVE/lrxAr72LJ
	dlk/YFEckPxRevarwvWsJnyGDs4uawz67QR1U/B+k5pWJmg7EtDC02z7oF6ln6W/
	mSsaIrR7FoYQ318TvOTc/P2eb7nHgeEwzYBkZogI9fMfx17cYoQLOY4NhJfsKmID
	ABzaCA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4951chh6cs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 15:00:00 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2445805d386so65383335ad.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 08:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034800; x=1758639600;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3y9/lW+dUggFVSzfvHXuYGDXV3KHAmr21I+oLDCe+i8=;
        b=hQyLFnXYHiEceQvi2QXOOmQdHmImjyJXOaVmvTm6xC28Q2zxjgn46JX27B4AukIx+0
         4futx45e051IfiRDFtIDPFsatathbPbOBd/QaVO7YO+5am20Bjb38zopLdvf45lc4Sh6
         umYYh+3sadTKTq7H8iEiU2/v3nI06IcVPKchYx/lBYslPzXf9A5jxHqO7jm/8madPEuE
         1Gt8y9cB+rjPrO7nwmnua280+jwngWFI7myGu7qxJvYH/eOzzPYW02R5T601+lsdPKQ3
         1lsAWmB08b8A18Cvf3yTxtfkYYJDQ5MPi6TItyW+F01o+zcM+akfv9dxigomQn8dstQ6
         gexg==
X-Forwarded-Encrypted: i=1; AJvYcCWxR8XpACt3OtZkkEJ8dVJW4zuoRAxUu6whZMBJ1IzEPWSjYH0xtzmwdFKxmlVqN5l6SH7Y040=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHpWzIcJX7THOH4mv/aRO941+uXviY4AYYoz3V4VpM50nBGSq4
	ghH+toSrHR5iweLB9/eluojOKNjcrbHjXMyjUG4B8uogyNqD8iX62WIGBD/I2PaPAkCHEV93sEu
	p1F2VkJr8lDjNH9KvXlgzd1HKBW3K9jMz7IWFYiKNMKk0fh8GrCAur62ZA0Q=
X-Gm-Gg: ASbGnctVrovNC99I8CCAFooMQGRBXLpmKbG59o/oyEQXig+M2kBE1XCoiOqG6wx8Oz2
	ggwKhJ8djddhIERTLm/PNl4YdvO3RUXFRg5/eskiNeR5lMO7GjkUpjwyycp3dlIvcINBNQ+IX+8
	It58TLVx9h/+zs/4jypI1SyWacGGMb32fSOg4bYKZnQbRppjsoCPMrePHActM1R4E24BjBTPqic
	7pzpGRVb3EviGbHisTm3DL0Yyn3cNfMk7CwlfpxHoK8k/hGOzMoHmjv4LDpRC1qPBYNndyfV6ZH
	RfvSmu/ODat4rXMdfgIBOF24aGl5gIFFZdtQXc2GceJIExC/FXNxYHFMlHDVK9U9OhxQ
X-Received: by 2002:a17:902:f710:b0:248:79d4:93c0 with SMTP id d9443c01a7336-25d2772a576mr218397425ad.56.1758034799731;
        Tue, 16 Sep 2025 07:59:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgdnskq0Voz046OasrfzjlM6hwmSgiF3CO6/6o5Fk0bXBl5RNE84UvyOoH1QdPzdI+OiGUVg==
X-Received: by 2002:a17:902:f710:b0:248:79d4:93c0 with SMTP id d9443c01a7336-25d2772a576mr218396995ad.56.1758034799251;
        Tue, 16 Sep 2025 07:59:59 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2651d2df15esm74232615ad.45.2025.09.16.07.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:59:59 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 20:29:26 +0530
Subject: [PATCH v6 04/10] arm64: dts: qcom: lemans-evk: Add EEPROM and
 nvmem layout
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-lemans-evk-bu-v6-4-62e6a9018df4@oss.qualcomm.com>
References: <20250916-lemans-evk-bu-v6-0-62e6a9018df4@oss.qualcomm.com>
In-Reply-To: <20250916-lemans-evk-bu-v6-0-62e6a9018df4@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758034770; l=1222;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=hgxN5DeUETfnMsGGyj/LuHtMQXwKu4mfjF7UJJuk/14=;
 b=LEpO2J4N7yRYl84DXGhLb5ki4A5dZHAD9vW3o9gIHCKV3twzH6dP42sHCkuiv/eNjpy0LHsm0
 rqWmySvX4aWAvQkFOZFh+Luis42szVd2XzBZPJZgduZjDCSH0bKIFHB
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Authority-Analysis: v=2.4 cv=eeo9f6EH c=1 sm=1 tr=0 ts=68c97b70 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=cq19zQBcvAJi0RM8MkQA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: v2r4hsJJ2WsOSUlVQog5rtX9ryh9JOZM
X-Proofpoint-GUID: v2r4hsJJ2WsOSUlVQog5rtX9ryh9JOZM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAzNiBTYWx0ZWRfX5q2pZPY/HTF/
 sz4Niao4FL2VYM/GAPudDoNMygSnWFP85Vy7e7j1kOdW99g7KANdkZvCthxAu+xVRzW13ldaddx
 jA++CQw1kjlsrtuD5m9jwml3R81ZAfv9+PnuCBCw3PAasRQPfGP/Q9t4g+9/jBRDUwXoQZevBF9
 7km019PUM2tpH7IJ1+y6kEGoXkCGu0PHGjheYrCdxn4mS9ffOanrXxOE/BIodNqmFSEJ4fgLKRD
 KqH0FohQXmd1r3wxi0Zf39Q3/bTKQGQEvCVl7kLxxaqfwIssSZU9Wi1l33ds7cnMZmttg9X5boo
 GpkQgxek4N5yARl/vJu/2Xi4PavoDO2/mg/l+gBypv4dgKlwo1eHyrllwL+TvQQy78IZyQ+uEqp
 Zzb9JZzq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130036

From: Monish Chunara <quic_mchunara@quicinc.com>

Integrate the GT24C256C EEPROM via I2C to enable access to
board-specific non-volatile data.

Also, define an nvmem-layout to expose structured regions within the
EEPROM, allowing consumers to retrieve configuration data such as
Ethernet MAC addresses via the nvmem subsystem.

Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index d1118818e2fd..97428d9e3e41 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -371,6 +371,18 @@ expander3: gpio@3b {
 		#gpio-cells = <2>;
 		gpio-controller;
 	};
+
+	eeprom@50 {
+		compatible = "giantec,gt24c256c", "atmel,24c256";
+		reg = <0x50>;
+		pagesize = <64>;
+
+		nvmem-layout {
+			compatible = "fixed-layout";
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+	};
 };
 
 &mdss0 {

-- 
2.51.0


