Return-Path: <netdev+bounces-258442-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJvXBeKyjWll6AAAu9opvQ
	(envelope-from <netdev+bounces-258442-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 12:00:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E8612CC85
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 12:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5ED18306DF14
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 11:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1451E32C92A;
	Thu, 12 Feb 2026 11:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E0AmMNPR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K3GXAtNR"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CE432AAAE
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 11:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770894038; cv=none; b=vBr6KFznv/GPcoJIUEWIjIydRcTpqOWE0MNZezYFNzLX1m5RTDUTnD7rRMViz9P+VvfXEAoHVhWhAy+LVz1wIk2wIFuXbrk8E9f0W5D87exYPGmlmBQ1Yur1MqiUVHXYyMzGSTf5BYwFO52tNc905BujToJfhOWzPuEC1VfcUNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770894038; c=relaxed/simple;
	bh=fR/bL8DW8w7719SXkjd06zJ2rT/UFwnxQu3aQzrS/E4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GVqb3A1Uyq6Q77hh0SAvQjE5EwgvCFGUQV0KawEVs8MMV4tsyjLQKmq90rtfE8rV1yw+FE8Whk2bZ85w//ToYcm5sBJDRklENYbf+ZcaI8Gdr6N9VG9aFtD2hH72DxmA99C1zfEd+R9cvVjLFJWzpi8Rt9ZCVAOVhcHvQN+Ukbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E0AmMNPR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K3GXAtNR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CAFmfp008904
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 11:00:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=IT0E+i/X/7kLm33FOBTs5Y
	3poQRTNZiMl1emlGeTKc0=; b=E0AmMNPRPUXpFgNh+qjrCYF+mXyipcE5A3vIuU
	Rg/cr9y/nnzle7sI2vOdpBq8Nm7Qm6A5ucLV/BW70OtK3EX4ORP2DBvpLBIO+UYO
	WHN5x+teVDPCreEWl5MzehE0pOTDAmV4QIQ//kVsfKMYdqLMRmQqCqOj3gZUFP51
	1vr+tcaXBpFh2ZisLdp3KsrcsrsmY6DPJXr9p5JjuKZbqTSxUAHH9ugN/GMPflzh
	nHqUMEHPkaegMxaDUf6zscwJs+sY6a6XOOgYxlUfly0zoWQyYymn0vD/ZgCjwhg3
	2TeDnMLoZVzDWCYTuvWdPOT1p4fbQvvYWaNr0iEN1wd+h2lQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9cy4842b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 11:00:34 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35301003062so17721701a91.2
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 03:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770894034; x=1771498834; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IT0E+i/X/7kLm33FOBTs5Y3poQRTNZiMl1emlGeTKc0=;
        b=K3GXAtNRGir3h3i3/lTIR2o+E0LCeAs3bPJrMFv375gdLmngfmRcsj1b9IJBuP8Cxv
         CZwZca4YDFqO6DwCr/U6Fbyk1+xQbm4TTPa2QN6gZiIN03redanD0QuOn3JD0VPV8d/Y
         IQMsDXpIHHkZ6gN9+BqoFMioeddIfS0rfOWOynzdTaE6DKmN0F3i0YYiQBfXFFqK7boU
         8I60AmZw9AkKxzW0/Jek5WJFOUJkDveOYnuYZSjZnENQ317xFOEcDuuW+PR01u2Ba6e+
         gBpwl3ozb9hfpiwhDk8nkCZW5ldRjcNwVpdfg6AZ12p+JF0ufVZ+S0x4GKSp0JVTOiYw
         Hlmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770894034; x=1771498834;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IT0E+i/X/7kLm33FOBTs5Y3poQRTNZiMl1emlGeTKc0=;
        b=Z0RiIHSciuTcI9FLT3ygRWwegQP20U++qIy4N5w4ehbS4x4GIShvqQYnJq75qI6b7S
         bdoCbu6HT14RMs1Uw++FnVT2eRvHOyVD2kZdilBT+p9wIqeUDzTfjhWoOoIhV6xmXBkB
         Oykryngv8LINnEzcPQvg/zlUIOQ6ASI2kFvwplSzEIuSaS5OYYI3VxAPf1HOJxD6phPm
         PlafcJBsCQ1f4qtosL9hD5ZnaUf57dnPek552bjYsO5imN1yi4HUiAHJDiYb+keb87mr
         bV+rKe6QmLUcwBPuX/yGX97aDotp+7dB4B7L9fTQhUHn1UWRHgP8b8Erb5Z57S/Gc518
         VHnw==
X-Gm-Message-State: AOJu0Yzz/aLM8i3fxsKtvea+vKDg/DcXk3ErNB2fZqeuB14SDYC9j3wO
	fvzGR52IrhK9SJrKSp/sJ7s6JujOyX1USU8I75ArycUQAWiOwI7InvxMbi4Olvsf+uEIqB5Ie7g
	IouG2dl8JU9e5NG3wtVdoSlpajKtlo4Vrp8PSnHX/fGdVV2wrqcCJ3Y2R0P4=
X-Gm-Gg: AZuq6aKYFrvpD41nQsQMlYMRLZtgNsJ3ZCG4BzBdAFdnANAhdT9Ex31eOK98KaTirsM
	rKxsaxquSsITrZh0B6fMswG+Tdvezye//KlFedcZbyApAaUo/KkOfi6t+7GH0K2rs9v98NHjVgY
	nxeYms2cO6yRB5XXa7nnJjfpJKK+cmT77dFJbaeR2mkegcmaxoJzo5gZ2Xv0gyFHwe2I/J3/3k0
	AN07n70Q9zL3niJ6U3rshNKXDdJvP+od2Z5TZdcvhVS3j8zu8Smym5oAUKBGRShShmc3a+rjeUI
	D7QDTI9ZJknOhKHuwJZ8+kzO65FG5GS8gg0fDMG4eyK6/Fn1E0UyKCysXAYKlvQYFTPbE4HOZFl
	JKErnlzxyM7jcRGjFdeZzs58W2QRJkHZVXOvlZMpBOsHwBSAZ
X-Received: by 2002:a17:90b:3b46:b0:356:41c2:896f with SMTP id 98e67ed59e1d1-3568f2cc5e5mr2206352a91.7.1770894033344;
        Thu, 12 Feb 2026 03:00:33 -0800 (PST)
X-Received: by 2002:a17:90b:3b46:b0:356:41c2:896f with SMTP id 98e67ed59e1d1-3568f2cc5e5mr2206090a91.7.1770894028604;
        Thu, 12 Feb 2026 03:00:28 -0800 (PST)
Received: from hu-vpernami-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8249e3bd8e6sm4708348b3a.14.2026.02.12.03.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 03:00:27 -0800 (PST)
From: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
X-Google-Original-From: Vivek Pernamitta <vpernami@qti.qualcomm.com>
Subject: [PATCH v8 0/2] net: mhi: Add support to enable ethernet interface
Date: Thu, 12 Feb 2026 16:30:21 +0530
Message-Id: <20260212-eth_vdev_next-20260211-v8-0-0974b3a8d61b@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMWyjWkC/y2MXQqAIBAGrxL7nJAbhXSViOjnq/bFQkUC6e5J9
 DgDM4k8nMBTVyRyiOLltBlMWdByTHaHkjUzccVtxZoVwjHGFXG0uIP6tVbzYmqwabe5Ycrx5bD
 J/Y374Xlew3fcWWgAAAA=
X-Change-ID: 20260212-eth_vdev_next-20260211-bc83e286fb52
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770894024; l=5705;
 i=vpernami@qti.qualcomm.com; s=20241114; h=from:subject:message-id;
 bh=fR/bL8DW8w7719SXkjd06zJ2rT/UFwnxQu3aQzrS/E4=;
 b=gURkiOMf8DdO4v1fPTIncFv1RdaIC9dwnnrfu+Vf5zRIDNfL0aVdToooSu5BOM+4Ssc5tw36r
 eK34ORtv7jXAAPeHp3GuKaHWzmFERoHJytT6uoLc8uXZ0QGv4t3H6a4
X-Developer-Key: i=vpernami@qti.qualcomm.com; a=ed25519;
 pk=HDwn8xReb8K52LA6/CJc6S9Zik8gDCZ5LO4Cypff71Y=
X-Proofpoint-ORIG-GUID: pUrb_SpfqOEU6NK_qqaK4B7ElA88K-Ck
X-Proofpoint-GUID: pUrb_SpfqOEU6NK_qqaK4B7ElA88K-Ck
X-Authority-Analysis: v=2.4 cv=XvX3+FF9 c=1 sm=1 tr=0 ts=698db2d2 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=8SqqAd8AVnWKc5cE22EA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDA4MSBTYWx0ZWRfX0HUr9rFH/3my
 J0NRGIz0olwoEuBS7CwABLcDwG/3eG0FmL5+QiB+xYoqWQb180NcMQc4YwdfczEMU6QlIQ0kGtz
 uBsJszfB7Uy3Vda4p3WZMcDhUs8Q4/Glkxn7ZUfN22shHktIL2+POsZldV4KdrB7BF+i/8xOTvH
 gD4/IMF8+EVuGwl/NeDJoqxU0GyzwiRBbKcZHJH71A7dPTZcG7vb3XLxctrwTvJO+kMxu7AfKtT
 X+UnASDWn0KMlQTRo2xUWeGUnl4YiBpB2/Sp0G+P9orgy6RbfIE41FyHQajS0pTO+tzQnxM8jpC
 ni65Je7LZf25PEV+84cKuBqtSBZYoeth7y8R7/nh7NOJMSArLHdcCwqv+snoxtIud3STkAVDkdl
 BxUqaMtIjh2c9npyOjG6HoB3VPIdWmRgP7Q/zHPmZ+CKCD31KFDfE17gn8bo80+pn32T1AX3RQI
 cWGYa1aJbDBoGES18XA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_03,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602120081
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258442-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,quicinc.com:email,qti.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vivek.pernamitta@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A1E8612CC85
X-Rspamd-Action: no action

Add support to configure a new client as Ethernet type over MHI
by setting "mhi_device_info.ethernet_if = true". Create a new
Ethernet interface named eth%d. This complements existing NET
driver support.

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

The actual link between the device (QDU100) and the host is
PCIe/MHI. The device has the Ethernet interface and is exposed
as the MHI channel to the host. So this patch creates the
Ethernet interface on the host based on the 'IP_ETH' channel
so that the host can use this interface for exchanging the
NETCONF packets.

The patch primarily addresses host-to-DU(QDU100) communication.
However, the NETCONF/M-Plane packets originating from the host
will eventually be transmitted from the DU to the RU over the
fronthaul, which uses Ethernet. For additional details on this
architecture and data flow, refer to the O-RAN Management
Plane Specification:

O-RAN.WG4.MP.0-v07.00
O-RAN Alliance Working Group 4 – Management Plane
Specification
Chapter 4: O-RU to O-DU Interface Management

MHI_CHANNEL_CONFIG defines channel attributes for the host
controller to set up channel rings. These entries are part of
the MHI controller’s configuration so that client drivers, such
as the MHI network driver, can attach to them. Each interface is
mapped to an MHI channel (for example, eth0 → IP_ETH0 channels
50/51), which is why this configuration resides in the bus code.

Allocate MHI netdev's using NET_NAME_ENUM to reflect kernel-enumerated
naming. This updates the reported name_assign_type for MHI net
interfaces created by this driver, aligning naming semantics across
existing and new devices. No functional or interface naming changes
are introduced.

Signed-off-by: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
---
patchset link for V7 : https://lore.kernel.org/all/20260205-eth_vdev_next-20260204_eth-v7-0-f85645210f81@qti.qualcomm.com/
patchset link for V6 : https://lore.kernel.org/all/20251209-vdev_next-20251208_eth_v6-v6-0-80898204f5d8@quicinc.com/
patchset link for V1 (first post) : https://lore.kernel.org/all/20250724-b4-eth_us-v1-0-4dff04a9a128@quicinc.com/

changes to v8:
- Removed skb_copy_to_linear_data call as it is not needed, updated
  as per Loic Poulain and Paolo Abeni.
- Removed ethernet_if member in struct mhi_net_dev instead used
  !!ndev->header_ops check for ethernet protocol as per paolo Abeni.
- Updated more infromation in commit text for change from
  NET_NAME_PREDICTABLE to NET_NAME_ENUM.

changes to v7:
- Updated to NET_NAME_ENUM while allocating netdev as per Andrew
- Updated more information as per comments from Jakub and Mani

changes to v6:
- Removed interm variable useage as per comments from Simon and Dmirty.
- Squashed gerrits 1 and 2 in single gerrit.
- Added more description for M-plane, Netconf and S-plane.

changes to v5:
- change in email ID from "quic_vpernami@quicinc.com" to "vivek.pernamitta@oss.qualcomm.com"
- Renamed to patch v5 as per comments from Manivannan
- Restored to original name as per comments from Jakub
- Renamed the ethernet interfce to eth%d as per Jakub
---

---
Vivek Pernamitta (2):
      net: mhi: Enable Ethernet interface support
      bus: mhi: host: pci: Enable IP_SW1, IP_ETH0 and IP_ETH1 channels for QDU100

 drivers/bus/mhi/host/pci_generic.c |  8 +++++
 drivers/net/mhi_net.c              | 67 +++++++++++++++++++++++++++++++-------
 2 files changed, 64 insertions(+), 11 deletions(-)
---
base-commit: 9152bc8cebcb14dc16b03ec81f2377ee8ce12268
change-id: 20260212-eth_vdev_next-20260211-bc83e286fb52

Best regards,
-- 
Vivek Pernamitta <vpernami@qti.qualcomm.com>


