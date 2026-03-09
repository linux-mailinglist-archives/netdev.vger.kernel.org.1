Return-Path: <netdev+bounces-265592-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 05AyNTTprmnIKAIAu9opvQ
	(envelope-from <netdev+bounces-265592-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 16:37:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1B123BD1C
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 16:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 727DD3076785
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 15:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D567D3D6CB0;
	Mon,  9 Mar 2026 15:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ezxlHF0h";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aZUm2jtW"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6A338BF8B
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 15:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069870; cv=none; b=gbzqr6xDgOylcVmD9oyeQLwFljBUWsspAQ24ymzsEJYvNdfRJgB3li3QwzQWEqv6xE/tzE49CxYGFJui55PMKVWgODe9ZT4VOnpkNhdzhwLxV19YRbBUHJsN2O6mSSIV0tI2ozn2D9rYtZewpMhm9bWtbcDIcxBZGeZHWIOFDQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069870; c=relaxed/simple;
	bh=i24TgRrLoGVPLjM+/eKgUisXgQ4vL+kM6dE3Nj1V3G4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TLujQchZr40frId8/ERulUx0cILBzTmT1qklRKQcqKSdZpOeEEPYxWxnzwcHnDMcLbJFe/OHos0PtSV3RhyeCY+k/us+a6KClChAC3FXj1yEDzoa717SR9Y4PWcGWMvQNLARC89Zqdvcq4BgGe8aDpTk3H0TB6xG2FFfE1tJwEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ezxlHF0h; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aZUm2jtW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629DuKDQ413142
	for <netdev@vger.kernel.org>; Mon, 9 Mar 2026 15:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=yga3XbiT8rvRu5nMdqM4/M
	FVlYqHPYbfjWpnYtaYAOw=; b=ezxlHF0hR5ibnUmPjHNsH86x148fYh/ke8b6Qk
	Ur3tQcRVAnIt6cM9XG4yZfxit7Sv+N9Atet7J4DwCgNpG84l6omh51jyI54dUIA3
	8JCSrBpgEzOZiQSKrCvLqCYJO4aPoKmHzsTDR0tmDiMdF7kCTzZmFNacVmRyhd4D
	sc1DbV/IQskTu6KFA9EBC/Fm2EUGMB3HEEp7CcPUHq0eh689hVVkP/0aLGOXECrf
	Hvsnnk/oZAxD/W7VplJ9QsaWWVrjmO4an60s5FyGy7na7iL9T9xdHtv79GhYMToG
	hoWPIJqIt8/xGBw1HZBDBwS0VA+cWWqMAi32HGQ/3j9Ggtaw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csyhbr9ac-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 15:24:28 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cd7fec8d44so790957485a.2
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 08:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773069868; x=1773674668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yga3XbiT8rvRu5nMdqM4/MFVlYqHPYbfjWpnYtaYAOw=;
        b=aZUm2jtWYOhlVzOFay8zKFb5ZXYCZ7TUn/rz7wsbqKTBpYCcFdX1QC4AVsPhTVyaeC
         9TYdkWVwDiLrMy6lnd/huOhOFIfAlv+jrOL1ueiUW34mB4EIFCTUOuBaUr0mKn9yanJb
         a8yHfqCD3QvnBbUrSYDcbu8dxb0MBhcKVtfU3z/B7eg+vahftxsPvqxiKuSZRJzXWOT5
         ZLEx72suFIL+JFMtzJQw6vgonWGdSqed4/BlOoiD/zQGP1Ab58Y+/FoHuI9D4RUgouVU
         G3DJK1BWHGmydW4V+NpqMHgMWmFtH5BrsK7jiqoib1S+HIfMXKozgRX90UMUPX4nb02f
         aKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773069868; x=1773674668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yga3XbiT8rvRu5nMdqM4/MFVlYqHPYbfjWpnYtaYAOw=;
        b=gaPdzYsKWrNDQ9UV0rMT+AzmwB/bWankmq6Fl3MsBqvDBr5EkWmPNf09CAlFB6w8bc
         J8h09Gt25GezGDI4EzDmCay3WitgLF0ZoG1LFOc+LUZI949RERhb3Fj6VDwgV/CoThvI
         a6GT/HzNoZIhOWUFcIOM40KXHVbCzhbQBmJvUd8CRnMcYcka7fgC8hIikndOJPweh5H+
         HdjF8Gb3X6n6SVLWuBy294CqM7ry2dzsdbpSE39qulOOodDVm+N36R0gH1HgbdQjA+iy
         xZFrHyTuF6XaxQivmo3aOQpB15toqmQdTxmAyPgvBDcH3HixWU0EyFJmM0rX8eNj73/a
         CKYg==
X-Forwarded-Encrypted: i=1; AJvYcCWisBKvK7JCXFyaq+c6/F7KIiKQNg31a1B96Qe8vynZ0lx/OKYEF3QHzQ4MvrnUhibRNfqmf0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya+R1ok7ZKcmmfBW8OGXrTLT4Kcpz2UquUKp5p3gR/AuctZxvV
	dlllpPhsFYhpJ9HRqDDIYzgK9XfZkRl9xLz9+wJI3+fZI/GWuQH6aTnYSR4IVIShWfCZRKI7VMl
	IU8LBHgQDwmugu890fzAoUZzjXw/D9BX585TDUDhbRT9zHaByr04k+wvWAxA=
X-Gm-Gg: ATEYQzxxD2u0tw7wsJo1dABok1Qvei5n1vigYbeNWaubODEYUnJfvExZWarLPgVGpXR
	FehRf7t+5MfJ+E5toGqEd6fKp/wdl8wvq0OXHr03awAV39THkgB4NJRPTpJd3IvS4qfkEACMUro
	p7YtHLZbWAO0MigIvd+9v9kScn3RICvVuXKe2XQKI3KEH79RGHXFOU45OY0kg0NAObAZDbbMhpn
	YAXXQJyypn/kRrZMmAJXzHsxaBVFlxRpl7D5QblhSGsS8IUQZE1ToTMUWiAuvIxiyWKd2fk9HLd
	d4MFMze14d9esA4D6p5qe8dzrTTd+mSGOKqA4TFAcMsD2LBUkTblqSyY1zVvIlI8YuM8JIv1sCa
	COBiOT1NHNmQO6NG4t8fYaSzEpNCCQ3tWK5DezabuQHUhjXk0faM+ftY=
X-Received: by 2002:a05:620a:290e:b0:8ca:2baa:6656 with SMTP id af79cd13be357-8cd6d461f63mr1458820485a.55.1773069867913;
        Mon, 09 Mar 2026 08:24:27 -0700 (PDT)
X-Received: by 2002:a05:620a:290e:b0:8ca:2baa:6656 with SMTP id af79cd13be357-8cd6d461f63mr1458815085a.55.1773069867392;
        Mon, 09 Mar 2026 08:24:27 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4853a59fc36sm192812515e9.9.2026.03.09.08.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 08:24:26 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: richardcochran@gmail.com, geert+renesas@glider.be, arnd@arndb.de,
        dmitry.baryshkov@oss.qualcomm.com, ebiggers@kernel.org,
        michal.simek@amd.com, luca.weiss@fairphone.com, sven@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        kuninori.morimoto.gx@renesas.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, m.facchin@arduino.cc, r.mereu@arduino.cc,
        loic.poulain@oss.qualcomm.com,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 0/7] arm64: dts: qcom: Add support for Arduino VENTUNOQ
Date: Mon,  9 Mar 2026 15:24:11 +0000
Message-ID: <20260309152420.1404349-1-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Rcmdyltv c=1 sm=1 tr=0 ts=69aee62c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=NEAV23lmAAAA:8 a=Ar_5JxPjAAAA:8 a=6arpMgwqxbr1QNdnrLkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzOSBTYWx0ZWRfXwJ+yjeAmPNuM
 Ohv7oAIRI1qWt5vd5J8VgdiOUEtBqJMAEoV50lUqafSBGbSP6vcwQLudF1/qqbXkPFj7Dh65KdC
 b51XmAxmhXMO6tA0ZS8XhGDrOSc/MpNLqHs4F0/3+MVZCbzAWU1semXlCP0SxT8cMslNbVSn4xv
 IPsyuAgDME3EXhPtc/Dj2nNErpTzyJmgDbRpAzSohoeizErRrkt4jp9MZTWIrd0O5BOplzuoAPg
 72h2PreuWYrO2VDRppIp4OSPV0Y1C4PG/RcRJlwfTMXtDxGgAdIb5BeNjg4JQI/ZI3b3H8r6E8J
 p9jMrBOzxN+sRJLA2a+CyIdfHE4pFrOlljmttU5CUWA5O5sSaDaD9r9hxAlR6QKG2vTHFLId4pE
 woLPrJn2+/K/pjeStcKT9vn5KEK1WxRjUTCKPBl/MOk58nu8H74U2gr/6KwpS77Og5Bk/C8FWMy
 3o/s59fuLDtAzu53HEQ==
X-Proofpoint-GUID: ix223CvoNnX4xhL3rkLIiuhMffGXrcrb
X-Proofpoint-ORIG-GUID: ix223CvoNnX4xhL3rkLIiuhMffGXrcrb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 clxscore=1011 bulkscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090139
X-Rspamd-Queue-Id: 4C1B123BD1C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[gmail.com,glider.be,arndb.de,oss.qualcomm.com,kernel.org,amd.com,fairphone.com,bp.renesas.com,renesas.com,vger.kernel.org,arduino.cc];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265592-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,arduino.cc:url,qualcomm.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.kandagatla@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

This patchset adds support for Arduino VENTUNO Q board, which is
announced recently [1]

VENTUNO Q board is based on Qualcomm Dragonwing™ IQ8 Series processor
along with a dedicated STM32H5 microcontroller.
This patchset adds support for below peripherals
    - USB Type‑C connector with dual‑role support
    - ADV7535 DSI‑to‑HDMI bridge
    - MAX98091 audio codec
    - 2.5G Ethernet PHY (HSGMII)
    - PCIe0 (to onboard WiFi chipset and USB bridge)
    - PCIe1 (to M2/nvme)

To make dependencies easy for new audio dai ids, I have used numbers
instead of defines.

Audio tplg is available at: https://github.com/linux-msm/audioreach-topology/pull/55
Branch based on linux-next kernel: https://github.com/Srinivas-Kandagatla/linux/tree/arduino-VENTUNOQ 

Thanks,
Srini

[1]: https://blog.arduino.cc/2026/03/09/introducing-arduino-ventuno-q-your-new-ai-robotics-and-actuation-platform/


Loic Poulain (4):
  arm64: dts: qcom: monaco: Add HS/SS endpoints for USB1 controller
  arm64: dts: qcom: Add Monaco Monza SoM
  dt-bindings: arm: qcom: add Arduino Monza, VENTUNOQ
  arm64: dts: qcom: Add Arduino Monza (VENTUNOQ) board support

Srinivas Kandagatla (3):
  arm64: dts: qcom: monaco: add dt entry for lpass lpi pinctrl
  arm64: dts: qcom: monaco-arduino-monza: Add sound node
  arm64: defconfig: Enable configs for Arduino VENTUNOQ

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/monaco-arduino-monza.dts    | 512 ++++++++++++++++++
 .../arm64/boot/dts/qcom/monaco-monza-som.dtsi | 325 +++++++++++
 arch/arm64/boot/dts/qcom/monaco.dtsi          |  89 +++
 arch/arm64/configs/defconfig                  |   2 +
 6 files changed, 930 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
 create mode 100644 arch/arm64/boot/dts/qcom/monaco-monza-som.dtsi

-- 
2.47.3


