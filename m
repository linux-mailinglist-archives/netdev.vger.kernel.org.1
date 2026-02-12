Return-Path: <netdev+bounces-258444-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJZqCDazjWll6AAAu9opvQ
	(envelope-from <netdev+bounces-258444-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 12:02:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A89D12CCD8
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 12:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A2233068268
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 11:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB9D3321AC;
	Thu, 12 Feb 2026 11:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VcqdXQZW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gCGLRqXS"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10A0330657
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 11:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770894046; cv=none; b=oDXjsrTCDrihllcrPoeUBvZ4BDQ/MTifDC60+YeAngf3EtHtbpu/SW85NUHioW98Bg0r4crTN3bb10qyxmvgRSemr7xvvMY/3Dyio/V2knfOH7K80gCksAKZItW4a+xVgonJ67Y7Dp4/cJ0GLAkq2GVRqv/I4LjeGvzzXvcShgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770894046; c=relaxed/simple;
	bh=eACwLgZU/45Ro8VV6lj6dgyhmfOfokPMofw8tiCCjfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DixYOXcEO/tC5Pv9eulW4RplFHJnCCL3SSfMAXNeHc8B2FdrA/qFIqnf4xZ9UzLaoGpUM3ykKkvzQuudkOmpXQiENLmo8QbTgoiOtWuUAGWU7NAfaHjppM1Cj4wblXnZlaHFo2YJIVmJ/98+0dQWgOdhaRZay0O7XDXZPcxiyGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VcqdXQZW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gCGLRqXS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CA0NN2272166
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 11:00:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ro8YjALXjohtXLdnP5ERURaj6OCE7e54yvF9GGG0bLM=; b=VcqdXQZWKQVy7i6M
	XSBeKtHNnhs3SYmnF+IHxURS6TpT5+CLifoUXUDPlEWDs4GwPBCmWtaeYL2kqhxS
	UH5Tw8gT+Ix65wxAD+OCtsi1hczOOpGf/WE9SoEKunnLO0rWwfkEXEcZech9e5B6
	z6aRnLUVTOZjAiAqRdW3tOPLNLbbTbZx0mhulLZjD3VUr62EjrEoNPGAiW6chHVI
	DS8EQeYmI82/8YKhR5Hon5Oo6vadeEiTpqTViEhzaj747m+Os7JWJ5bX+skZLVpC
	8u5fnIXdZBuZW73AuqNJFyS47F5s5CfZNQw6WZWQh3obIXnJ73aQO6Ui2UEEIhxA
	JGJcNA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c8y9btnqv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 11:00:39 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b630753cc38so15975251a12.1
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 03:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770894038; x=1771498838; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ro8YjALXjohtXLdnP5ERURaj6OCE7e54yvF9GGG0bLM=;
        b=gCGLRqXSIxshmTo1UGAM9UX5zoaaXBqBCoDPKWAAD7/BZAUz1+fST2yhE12SiN03NF
         8lSO3IewrT94v0TzNpFryd67oo6irZ2+nmmHcmrP/FtR7vvf3bv18s2XYyFMyDL8tdpI
         X0/g/mR/Sf1BIk4WMsVUFd86No9IPt5AZqEw89hhMC08PM+J54hNsJt2Il3gF7PIYtEp
         kCMzfIhP3UPbgLO9YD5MaJtC/fu/SI/HLU/T1W0mWD0ije+YpLR0zWOFlvaEFgGTQE4h
         B05yuPBCXDbGrM1r7HDoQdXen/z7TFygKmvOrH6CsSIhgyHKZl2Qr2DHgRFgOzyadupK
         a5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770894038; x=1771498838;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ro8YjALXjohtXLdnP5ERURaj6OCE7e54yvF9GGG0bLM=;
        b=bJPq16ONS4Jf5Zc23QLThc5ObyO/KZJl3qFy/19wYd3IV65XF93HEjITeQozmfoRiC
         U8nB6ISbbMGbGFjYYkXcpp94RvyXzY3v9pBPUYO2lo8g9UCQWFPhqlILUDu2w4BLViLY
         IW5IYYBC5o/bA+dqChS8qDwyItWEczylNEgN2xggNDY3YnkD1cTi3mw/2FFtdMKYX4/z
         PmqSzhzPVdLiSq6jk7l+mgBs3WxH0dSe3sGr1teoccqvVRs2upX0yU2d9K60655GJQno
         aU7auRyd2SnvkCvJCRwckZv8gdqtzA6i/J1sQfFoMusaqbHbC5hXxV2iHns0HMtVQdCY
         9Vjw==
X-Gm-Message-State: AOJu0YzexSp6FF3S4rZW77covRW5LFtu2n0nqRC0g7PwvTM24vZUhtiy
	vfwG6dMZLDV94ogxvJHVs6Xr7U9RZBAoOz0+cj+PfEWHqZg0KTsXe3P4dQ1cx3G3dQhOKVTt74m
	DA1IT210ZASYSbOMcJYuaKe98/Yw/2YjL30jXRDocmAvkSw38ry5RIPmMBIg=
X-Gm-Gg: AZuq6aKgsBAXqJPZB7839aCqhcxxGP3sUnooYJb6DpvrBhIulWbZe/x/HtBI20Xo3iP
	nP/uLMkFit+gxvebC0Oo4L4ktRsfqNszAa09oXyvCVhKcVDjmBkCLXEeidjVF3zxGBDdCqYykRb
	iPqS8BWG8YJlgbyyqcEmWBQU0+Lgz012wNbuxsxK5C7J5cIX9QgMtUyBFkT5hvx1ziSqGbHMRNA
	D6EyorJChBNbP9hrrHVfR6b/W8u3tX5MAfQG9uM/VhbDAXKyAZ5E1U6FpRc8pWfh+z0JwTMo9ww
	YjO6BifQVtKE3fS4c3qJ0BgS32ritKaz7xAvPPylMrIqjwIVkrCucShnpRdSYaeOSNKI8qCb5ea
	zevaEUp+0k8G3XbMYAmyeABo5KsJfCRWUyIAwwS8xZISsP9uJ
X-Received: by 2002:a05:6a00:1953:b0:7e8:4433:8fb0 with SMTP id d2e1a72fcca58-824b05bac04mr2268983b3a.56.1770894038044;
        Thu, 12 Feb 2026 03:00:38 -0800 (PST)
X-Received: by 2002:a05:6a00:1953:b0:7e8:4433:8fb0 with SMTP id d2e1a72fcca58-824b05bac04mr2268913b3a.56.1770894037395;
        Thu, 12 Feb 2026 03:00:37 -0800 (PST)
Received: from hu-vpernami-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8249e3bd8e6sm4708348b3a.14.2026.02.12.03.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 03:00:36 -0800 (PST)
From: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
X-Google-Original-From: Vivek Pernamitta <vpernami@qti.qualcomm.com>
Date: Thu, 12 Feb 2026 16:30:23 +0530
Subject: [PATCH v8 2/2] bus: mhi: host: pci: Enable IP_SW1, IP_ETH0 and
 IP_ETH1 channels for QDU100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260212-eth_vdev_next-20260211-v8-2-0974b3a8d61b@qti.qualcomm.com>
References: <20260212-eth_vdev_next-20260211-v8-0-0974b3a8d61b@qti.qualcomm.com>
In-Reply-To: <20260212-eth_vdev_next-20260211-v8-0-0974b3a8d61b@qti.qualcomm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770894024; l=3410;
 i=vpernami@qti.qualcomm.com; s=20241114; h=from:subject:message-id;
 bh=RfZXzbxcqD/G6MBoueTXjrm+odDm6AQXFopMTMpU5do=;
 b=JL96HZf6eAxjtGzP/vcTV6UiUggL3lK3qDD5FRMI2M1KUfSJtyyOxY8xaHT4xPUBvsJYQCd6n
 knbJmNRUuhOAYei7gne8PIvw9Nx4mbbbe037XIHfd16ZXNyTBqjuAWM
X-Developer-Key: i=vpernami@qti.qualcomm.com; a=ed25519;
 pk=HDwn8xReb8K52LA6/CJc6S9Zik8gDCZ5LO4Cypff71Y=
X-Authority-Analysis: v=2.4 cv=BbPVE7t2 c=1 sm=1 tr=0 ts=698db2d7 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=S1B1NPdMiRUp1hSzhhcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: W4Sn22XWAhzHne6k-AXdOg7rP8dVcvJt
X-Proofpoint-ORIG-GUID: W4Sn22XWAhzHne6k-AXdOg7rP8dVcvJt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDA4MSBTYWx0ZWRfX9UcClasf4yoX
 +NVtawoK5xxTh2agjET2JJn5hquhXjaNQLWNAHmW4z3EYRlAsaCZ45YyH5tYYCnJxGkK7p5oy7K
 o57vb74zmX9OuvkzRkAUPrTSKjVFMLKrJMuA0rg0xTgVEYHMqm0auK/F3bVSihve0tR6v3BJGKA
 FRt74UFh/NLj1SVOnLRvP4MJJIcTN3qG9w0eTgEBEJTGbjGEyp37EAUxQ5tAgp0443SklgzuYUW
 z+sQYZf8AaXnQ/NEGbxOZtbwKGrneVgHyHZ3+7pzca4vnLwQwA9ZSun60xoyO3H+ocS7LCBiq0G
 1kKHJUcZ67euKj+P5WiVqR9+sbsfYJFSHX9skseHDkqqq3C0VUNlUKJU5NimbqSqbiyPXdegyaI
 cjzMqP7uupibOKGjXU2G5u9TNPpS080Jd0P52l+Mx1iACRGtzsVqC6d3Cz1vHAGLt4YgRKiPLeW
 C2FwbTwtPvsHdEjWC4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_03,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602120081
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258444-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,qti.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vivek.pernamitta@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7A89D12CCD8
X-Rspamd-Action: no action

From: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>

Enable IP_SW1 (ch:48/49), IP_ETH0 (ch:50,51) and IP_ETH1 (ch:52,
53) channels over MHI for M-plane, NETCONF and S-plane interface
for QDU100.

M-plane:
Implement DU M-Plane software for non-real-time O-RAN
management between O-DU and O-RU using NETCONF/YANG and
O-RAN WG4 M-Plane YANG models. Provide capability exchange,
configuration management, performance monitoring, and fault
management per O-RAN.WG4.TS.MP.0-R004-v18.00.

YANG model based interface aligned with O-RAN WG4 M-Plane
specifications over TCP between the OAM application on the
host and the DU M-Plane software running on the X100 platform.

Netconf:
Use NETCONF protocol for configuration operations such as
fetching, modifying, and deleting network device
configurations.

This interface is used for IETF Netconf communication,
enabling a Netconf server on the ORU to interact with a
Netconf client running on the host.

S-plane:
Support frequency and time synchronization between O-DUs and
O-RUs using Synchronous Ethernet and IEEE 1588. Assume PTP
transport over L2 Ethernet (ITU-T G.8275.1) for full timing
support; allow PTP over UDP/IP (ITU-T G.8275.2) with reduced
reliability, as per ORAN spec O-RAN.WG4.CUS.0-R003-v12.00.

To support accurate phase and time synchronization between
the host (L2) and device (L1-High), the system must exchange
PTP messages as raw Layer-2 Ethernet frames, because the
ITU-T G.8275.1 profile operates strictly over Ethernet
multicast and not over IP networks. This means the device’s
PTP stack can only send and receive PTP Announce, Sync,
Follow-Up, and Delay messages in native Ethernet format, not
as IPv4/IPv6 packets. However, the host and device communicate
only through MHI/PCIe, which provides no native Ethernet
interface. Therefore, the system must implement a virtual
Ethernet interface over MHI on both sides. This virtual
Layer-2 link enables true Ethernet-frame transport, ensuring
the device’s PTP implementation remains fully compliant with
the G.8275.1 Ethernet-based timing model.

Signed-off-by: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
---
 drivers/bus/mhi/host/pci_generic.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 0884a384b77fc3f56fa62a12351933132ffc9293..6affef34ffc449eb48cd254bf3d8d69a49aeafdb 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -253,6 +253,13 @@ static const struct mhi_channel_config mhi_qcom_qdu100_channels[] = {
 	MHI_CHANNEL_CONFIG_DL(41, "MHI_PHC", 32, 4),
 	MHI_CHANNEL_CONFIG_UL(46, "IP_SW0", 256, 5),
 	MHI_CHANNEL_CONFIG_DL(47, "IP_SW0", 256, 5),
+	MHI_CHANNEL_CONFIG_UL(48, "IP_SW1", 256, 6),
+	MHI_CHANNEL_CONFIG_DL(49, "IP_SW1", 256, 6),
+	MHI_CHANNEL_CONFIG_UL(50, "IP_ETH0", 256, 7),
+	MHI_CHANNEL_CONFIG_DL(51, "IP_ETH0", 256, 7),
+	MHI_CHANNEL_CONFIG_UL(52, "IP_ETH1", 256, 8),
+	MHI_CHANNEL_CONFIG_DL(53, "IP_ETH1", 256, 8),
+
 };
 
 static struct mhi_event_config mhi_qcom_qdu100_events[] = {
@@ -268,6 +275,7 @@ static struct mhi_event_config mhi_qcom_qdu100_events[] = {
 	MHI_EVENT_CONFIG_SW_DATA(5, 512),
 	MHI_EVENT_CONFIG_SW_DATA(6, 512),
 	MHI_EVENT_CONFIG_SW_DATA(7, 512),
+	MHI_EVENT_CONFIG_SW_DATA(8, 512),
 };
 
 static const struct mhi_controller_config mhi_qcom_qdu100_config = {

-- 
2.34.1


