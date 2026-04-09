Return-Path: <netdev+bounces-276844-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qM4wMG5C12ksMAgAu9opvQ
	(envelope-from <netdev+bounces-276844-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 08:08:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6163C6728
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 08:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08EE630160C6
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 06:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CC3223339;
	Thu,  9 Apr 2026 06:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jYu1HFmQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KHXynxE1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AB4C2FF
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 06:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775714922; cv=none; b=ogojc8tXRaElbtCoV40CoEulGZrrqt0VEaCIkHxqYD34iyuKJuvVBWitadlzU02QmWid4Y9aZoIc1umisjGUoimhIeCPGhxxvP68eJdN4Zw8ajp4D3VayNwclKm6GHg3JgvDjAmjIcspb4+ASEbZ+1Cd3R3UdXn25C1b/ikqXu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775714922; c=relaxed/simple;
	bh=NYX7M/uQ3sBszUjg86ie6HMMki4Tj3B+mfpP+Ow3E74=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FZ0flcgPKKg9Vllu8+oztjNzmpSOX8trQSXLyxOGqS+bCqjC1J8/6RKUZXAFpo3VFD9ZhiTVdZ+Mjyurbr69go1We0+lVnMdKpQ6lp53lzJSKHkfJ8WSqhiEnIFXJ2BTa35/XOdCmyOwwKZVQRmjalH281cNOc9nweDAySoqjv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jYu1HFmQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KHXynxE1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6395IeXt2618154
	for <netdev@vger.kernel.org>; Thu, 9 Apr 2026 06:08:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=x82AaAX2carpdkuCWADuJ6
	Bm/wwhskHIAVPBAPD9F9I=; b=jYu1HFmQC+QicwiqzUBfZ07+zWpnFQy/8Fr3Vx
	MFr8FcAkS/vJLcQ4NySn7N4JN+GecHiEXK8ZgYDm+dIZDh8Ibc7ZQv8vZafIqZuH
	dnLEqbq+DR8g5Xdsgs9s1MLOCLWg8GP0V3ehb2OyPipXGUrDZzSaKg0dK2SY+Jss
	RHCzI5VsuEfbCDEApaUDJUpKzwBbK483mBCeVlZ7WYsvPowsG0Tb5O0Id/WKsyH3
	W+ynQoUTrCoFJjCZ4VVZG06KiMDwK4ia2eHJOT8UNtT1RuGBKB2p/Af4A4IAytVe
	Jb9oSjGGj0wJQgnRmaWc/MnPHe/TEnQt6ttPGPdkZv8lzoeA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddt28tqd4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 06:08:40 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82cf0130d17so486573b3a.3
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 23:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775714920; x=1776319720; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x82AaAX2carpdkuCWADuJ6Bm/wwhskHIAVPBAPD9F9I=;
        b=KHXynxE1igV9JJy5i7JWJzSex1zTd6m1YcZ3U1iD4qoVUcofXXV1eS9zWWQd7yMsJD
         +kMV9189AVDgPpAa6XrbHgny9lntX2gstUju1BvQ+CrI/fThCtg5j4/jjZrNK3KiFDSl
         GbGBujQXp6N1TyztE5s+ANfnA44o3uTCv6vFMcQpkeL0l1ChmhudXmV6NoECwP9Fdamg
         3heJO5nQU0NwvBb4LsvTLUbUivJE7RINrwcLoBI4JobNejl5MgaTakGqSj32ccfyxakJ
         pAoAC5Ygb8tHCtHnaWIcPUlLJJY6aG8Vm+7Mz5fGjN1adKTBMsM7/xL399KDqH4hiO0N
         lyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775714920; x=1776319720;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x82AaAX2carpdkuCWADuJ6Bm/wwhskHIAVPBAPD9F9I=;
        b=SThgqeC5FnezEMdV4/hDQRrPN8RSihuSKDGupU+ERVVifJe7kXiWzJpz6kMDr9VF4F
         6bQtbt5zdgjlcrO4pINnnjCtCnFcPvGJvsSw0LLGDen30VoTid95UXr9m2ofg1RkHTFl
         Pumda5lBxPQMilDht3qZScGiPBZaenuq6spxmHm7KbZtOi9Qyhm2gfJ+dUzh/s3izKso
         Zv2qwnfdITmolVnARDeODKKEPCqFusMI0i6uCMDrdYVYVRHte9jQ4uGoOe1vxiYs/PYR
         8e4kB/EXOfFFQiefCgAw20eDXRiK6m0oza25bb9GyHqyBHU5y0uPyH1ZClawEjgIA8XK
         CgSA==
X-Gm-Message-State: AOJu0YwsI0ceLqOLIAX7kSfGNmRPKX7zJWMhnUGobZG419DLfwEBE1jy
	9+Seo+XN2cideQBj0iWRqkmPXf1AYEZUQALzXlsYoTgpFPh6gOPj2vEidrut0LmITTGPFMB1uf/
	6S08Ou70Vg8OVgIgcfwwIeFsYMMmAjy4q12R4cJEaN0p7RRb0cHsvegNnwY0=
X-Gm-Gg: AeBDiesgfdYWRx+Ykr1bJOa6H1wgigZyBFHP7MTr2PqSRBvFm09wddrJFyikJodW8jz
	//WHOX3qsGmy5hirCUWwDOMbvRj9kxMqp1nMulDTWjGvzFxJaFBO9V3NZ1a7053LRfnoxESb4Lk
	m7KTtyab4ZHIdG61B9og+Y1kWZXp9boUlw/SQ+NxNL6NCkQ3eyUIKE63jRStBGEUq5CPUSGDZ9Z
	ZHJPRq55ZBgByXufkhHSjnzh1yE5MDKi8Vx/pT/tjSUUaNSPzZIkXOyM2yuK4Nsr0Zr3ooc9M+I
	139QF31Wy4bfUDD+UrWSN6KuS+CROUMHtpjPI7OupTKNqXS095tX2C73fvfFDFXfNyls94RiRTk
	7qdev0xYjuB3jN4q11WpWILWH0ajZkypUkVNDWjhZ4YDpYFbfNAjK7fIxE4A=
X-Received: by 2002:a05:6a00:b88:b0:82c:7356:f45e with SMTP id d2e1a72fcca58-82dd8a99bcemr2438170b3a.31.1775714919452;
        Wed, 08 Apr 2026 23:08:39 -0700 (PDT)
X-Received: by 2002:a05:6a00:b88:b0:82c:7356:f45e with SMTP id d2e1a72fcca58-82dd8a99bcemr2438138b3a.31.1775714918940;
        Wed, 08 Apr 2026 23:08:38 -0700 (PDT)
Received: from hu-vpernami-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3baffsm23163534b3a.14.2026.04.08.23.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 23:08:38 -0700 (PDT)
From: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
Subject: [PATCH v10 0/2] net: mhi: Add support to enable ethernet interface
Date: Thu, 09 Apr 2026 11:38:32 +0530
Message-Id: <20260409-vdev_b1_eth_b1_next-20260408-v10-0-6d44ca48f189@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGBC12kC/y2M0QpAMBhGX0X/tdWGFl5FWtiH/2a0aSl5dyNXp
 +98dS4K8IxAbXaRR+TAm0tDyTyjaR3cAsE2CSpkoWUlGxEtohmVwbG+cDgP8Z+1sGoetW7qaUB
 JKbF7zHx+/a6/7wcKlGKBbwAAAA==
X-Change-ID: 20260409-vdev_b1_eth_b1_next-20260408-d1fb6698cae3
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775714915; l=6680;
 i=vivek.pernamitta@oss.qualcomm.com; s=20241114; h=from:subject:message-id;
 bh=NYX7M/uQ3sBszUjg86ie6HMMki4Tj3B+mfpP+Ow3E74=;
 b=5ggKJ+uQnknbJdkM0ZVNqge+PVc06G40gkyQCEC7QX9dxEyT9DE8Rt/A2dHMDsDCAZlNfv6LQ
 9Mp5EHcqfRQChMF6JN2T50UJDOL8Y3JzeSefVES7AALBIhSmC8N9EYB
X-Developer-Key: i=vivek.pernamitta@oss.qualcomm.com; a=ed25519;
 pk=HDwn8xReb8K52LA6/CJc6S9Zik8gDCZ5LO4Cypff71Y=
X-Proofpoint-ORIG-GUID: BgkWrsaJZ6Za8vu_YgBiLBQqDTGnsePh
X-Authority-Analysis: v=2.4 cv=fIIJG5ae c=1 sm=1 tr=0 ts=69d74268 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=A2YzKnAdJIP43pHWjKUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDA1MiBTYWx0ZWRfX276DI/y5Vc5N
 zSljI69zvTKhsb7Ge3JfJWGBbwSfdS2n1rpElOSxu8Fue5a0bag3anRT6gdG/lNXbgf4Aa3OYcw
 WvXvuGCbcLj0yH9hDx9cbU30rttqBJVhahQhAWHjMT4UjG5NmU4AvAoLscimeRXaN1TnU9qEPQi
 1Dy8kfAh0JsyyM1SR9/VHpS2kCciNBHDpZeU8RmLfgUqg4fPVexzLdMNp7aiXl7zyF3LVbDZVQp
 la5Pd00b4L5xlX24k2WAvjEsG9PGW9Vs4CzNUeiZasvbmHY2sQeluxg2EAQ7uX/FMQI8TGOAdPT
 YCUDdqiLCqr29k2lYiBAhQ5jOv9KYc6D557HMe2TjvE2KfYFGwpq4Lyw6UKVuE2vd3jUuowALlo
 1gk6z3NGWaF0Wh068qpOtsBNk9hZvqH7cEfRDE3hPLPpIre7uyaQsKrmJ3qlLWE+F17HtHsagre
 Y8Ho4JM9NqDXIZ9rdIQ==
X-Proofpoint-GUID: BgkWrsaJZ6Za8vu_YgBiLBQqDTGnsePh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_01,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090052
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,quicinc.com:email,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276844-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vivek.pernamitta@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3B6163C6728
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support to configure a new client as Ethernet type over MHI
by setting "mhi_device_info.ethernet_if = true". Create a new
Ethernet interface named eth%d. This complements existing NET
driver support.

Enable IP_SW1 (ch:48/49), IP_ETH0 (ch:50,51) and IP_ETH1 (ch:52,
53) channels over MHI for M-plane, NETCONF and S-plane interface
for QDU100.

IP_ETH channels as representing the Ethernet interface of the MHI
device, and create a corresponding netdev instance to expose this
interface to the host networking stack.

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
patchset link for V9 : https://lore.kernel.org/all/20260324-vdev_eth_next-20260323-v9-0-da6e4e486437@oss.qualcomm.com/
patchset link for V8 : https://lore.kernel.org/all/872d3520-f749-4d4d-a8c3-25dba30e947c@oss.qualcomm.com/#r
patchset link for V7 : https://lore.kernel.org/all/20260205-eth_vdev_next-20260204_eth-v7-0-f85645210f81@qti.qualcomm.com/
patchset link for V6 : https://lore.kernel.org/all/20251209-vdev_next-20251208_eth_v6-v6-0-80898204f5d8@quicinc.com/
patchset link for V1 (first post) : https://lore.kernel.org/all/20250724-b4-eth_us-v1-0-4dff04a9a128@quicinc.com/

changes to v10:
- Updated patchset as per comments provided by Loic Poulain
  Return -EOPNOTSUPP for non-ethernet device type which changing MAC address.
  Removed double negation in mhi_net_link for if check.

changes to v9:
- Updated patchset as per comments provided by Mani to  check
  for ARPHRD_ETHER type while assigining ethernet protocol and also
  removed explictly setting ethernet_if to false for IP_SW/IP_HW
  interfaces.
- Moved adding IP_SW1 channel to different patch in same series.
- Added more description in comments.
- As MHI(pci_generic) got merged, dropping the patch from series.
 
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
      net: mhi: Add IP_SW1 interface for M-plane support over MHI

 drivers/net/mhi_net.c | 66 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 54 insertions(+), 12 deletions(-)
---
base-commit: db7efce4ae23ad5e42f5f55428f529ff62b86fab
change-id: 20260409-vdev_b1_eth_b1_next-20260408-d1fb6698cae3

Best regards,
-- 
Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>


