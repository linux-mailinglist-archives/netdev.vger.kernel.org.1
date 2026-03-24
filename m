Return-Path: <netdev+bounces-270937-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ci7FA1TwmnNbgQAu9opvQ
	(envelope-from <netdev+bounces-270937-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:02:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D62230535F
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 874A030160ED
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 08:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D62B3D8112;
	Tue, 24 Mar 2026 08:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G56peE6L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T6Ds4OKS"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC7B36E46C
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342260; cv=none; b=uGU1ebfwQ/pAyYy30e4bx+zSC8qV5uTU8oNcMyROXIQ7FBamJHzy5+uoodt3PZpdBYF9NAw69/y2JgXt7idV1gOf1b9lG6gehWUKrt9lRI0CaQ5I7YTpwYrHx7WxZ+1yx3pHNVFq8Ch4dkPabRGuntiiFt6eHfX8rZmnz44n4MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342260; c=relaxed/simple;
	bh=IlszfQZzCRvNsvTO1OkusnhnoBzFmnsl/FgN1a7N2yQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PJbCf1qG0Q9DGIZzy7+WAHdhOpJtl/aP8CyYpPKlKLvGv/p9zO9AZihAw3PDvS5xIeek23UBTT4h6rIDbMX0xQ9GxAVaHcPuoOyv5aeQ3cZsQRHFQV4xwregB4dvhonTRpWHG5RzBmLk8Eub9f2vqShgEi1COPNAVM1QEDCuLgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G56peE6L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T6Ds4OKS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O7RCkG2371366
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 08:50:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=S94ffhFC3aRVULJSKVPQbc
	o2ZINqmw4aom4ninAXgAE=; b=G56peE6LX+d/cVYUZ8qAIKItVvMdZPcFWxCMsb
	Fh3JbjqqieIX4xWPj8lyFC8vFcHLSU++EJ6vjnK0k1SOv0Vgol2Vn3bjqSJ93zAB
	/f2JA9mZ0bqYyLipWpTjWcAJe/55jcB+wXo9H12IhCoTAZZtbtiM2kuxOQW4WkBQ
	tj7Y4NeXwJPBg9ENQ7ySvF9hlwoWH7IvqN4RK1dJdAcW2CN3JzLyKRvjz7eGW9Xf
	eENyTIPkZluB4JmO4gma0mnmehlRQ16M1cdaSWC644XtgkCQZqaMsAQAPREPwKby
	PhkBwUfU2xw6Qw50gA1S09oy4pq3LfCYhc0OYxUxoZH7d5IA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3p8308s3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 08:50:56 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b06395b8deso16305565ad.1
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 01:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774342255; x=1774947055; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S94ffhFC3aRVULJSKVPQbco2ZINqmw4aom4ninAXgAE=;
        b=T6Ds4OKS7eOF5u21M3uxSsjIfrm+AZZMUHYQy+h3sVXSM2FgFYACowgE9gofYBT3nN
         MqDRZfAaPPO7NpYBq9E2jetK60Dd0pZ9LGwvEcCpYXoeqiEBwEb4JeWq5V/17sy+C5UC
         6iZ5VeMgiwBHegOG+NqwBFjMI6xSExQcF2tf7cxAe5Wwm+NGyOmmvmerThpLCWlwqNhi
         CHbANdF4lB9ndZOKHleRRc/v98evQqn11i5mrWh1QD+LxiszN/RcTGIQHBaV3XBxSOCM
         SN0XNSSlPsFIRTJcycJ6XxiDehPZvjKvD19HPyiwybK00H3s456YbqRjGj5wmJo5xyUN
         TqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774342255; x=1774947055;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S94ffhFC3aRVULJSKVPQbco2ZINqmw4aom4ninAXgAE=;
        b=J++hiZ8MJbf0sy1YcfpOi3HZI7QUhjkfwfyllKrLS0NUrQxjMXn/Smmkjdpke8u7IG
         M0s/wUlvWYLeHDCtsFRyHNS62JH6O8ujKC8xoiCrlrVq9AEmSQY1pdoJkYKyunKRvYTa
         xDX+5fCASlNMifxNyrKD8Fj9ddwPWav0VUsdIux9bSXPdyoeCGxlhZ+IDxNPDiChwOgf
         RJG2NMlMAUhpibUD9S1egEUD97Mfu2ylSArUBUFl7qbwrDjOB7F+JfOjqFt722wtvPk3
         zgAa4HbUAyQy3rH8Ag5EfZhWCbT7Lm8YoQvcXTh+rV1je97n30/ekJTVAr7q40ed9CfI
         EF5A==
X-Gm-Message-State: AOJu0YwIT5Pb/UIMc3lopnBCGJWG/Dn79+uFECeYGXwyb8JxgYKJWK1M
	Fw5L5mfC+3cHnh0MhgC+98ADGtaj6FrTF49CzodAXCdveePxUFNm4mycHuOBFwe+p4NU5nFvFwJ
	GI4woNto03myXwCSOcwBRaB6Mo4rR2oDDPbTBiyDfbu1gfpUHGubELwT3x+k=
X-Gm-Gg: ATEYQzyuiwuYMW2YOQLXHRHigVzPQnQFb1GXtnVeNvVaFWzbV/d3ZYy30fG+pjkbRNV
	c/tltxaM4TdkU36Zv0zYH0a8HyQ8OblnpMPK4rEMfFfYwPunYyKjPUSbSJXxzReZ2JT4CmhMSYw
	uAOoW99Xr1XMwR/tz6Y9tfFCLn/wpHuPnZEJILW3D1+QP3pBEZjLtA3256H/eoXm0QOaB3XJU/t
	+Keeg9VaEPrkrU4uTz2MBC7ZDzID4rGJqxZRJ3TtWi6L3TrleWg6M31+4r5ixT/1xERQpessO3P
	FhpNAyiXLkhyWG9OKeK7Q5zd50ng/0TZrk2s8sW5EhBuC75/uc2D0rOY0i6VAAztxcT4V7kGK88
	r+1u7OPpcelThpscAjRZ7a2FKmb7DppAzD3UfLusTifAsZwki6R0B6L4C6/s=
X-Received: by 2002:a17:903:4b47:b0:2b0:66bc:22a3 with SMTP id d9443c01a7336-2b0826b8854mr133559115ad.10.1774342255186;
        Tue, 24 Mar 2026 01:50:55 -0700 (PDT)
X-Received: by 2002:a17:903:4b47:b0:2b0:66bc:22a3 with SMTP id d9443c01a7336-2b0826b8854mr133558745ad.10.1774342254632;
        Tue, 24 Mar 2026 01:50:54 -0700 (PDT)
Received: from hu-vpernami-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08366c4f1sm135752265ad.59.2026.03.24.01.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 01:50:53 -0700 (PDT)
From: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
Subject: [PATCH v9 0/2] net: mhi: Add support to enable ethernet interface
Date: Tue, 24 Mar 2026 14:20:47 +0530
Message-Id: <20260324-vdev_eth_next-20260323-v9-0-da6e4e486437@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGdQwmkC/y2MQQqAIBQFrxJ/nWAqkV0lQqJe9TcWGiJEd0+i5
 QzM3BQRGJH66qaAxJEPX8DWFc375DcIXgqTkqqVWhmRFiSHa3ce+RK/1kLbTjYSyjZGU4nPgJX
 zNx7G53kB949DPWgAAAA=
X-Change-ID: 20260324-vdev_eth_next-20260323-398010e29143
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774342251; l=6409;
 i=vivek.pernamitta@oss.qualcomm.com; s=20241114; h=from:subject:message-id;
 bh=IlszfQZzCRvNsvTO1OkusnhnoBzFmnsl/FgN1a7N2yQ=;
 b=HlDi4OnUaS2jbikmThFvkY0z/ArpF4pQn9oc5u7pH3iTBrINTtFPtjF9ZLjgYx2eQDmDyH5fc
 fAXsLFaibwyCRkTG3wkHQgpKzjGYXvpt4/IEabJtNX6XiJUUEhg/bbn
X-Developer-Key: i=vivek.pernamitta@oss.qualcomm.com; a=ed25519;
 pk=HDwn8xReb8K52LA6/CJc6S9Zik8gDCZ5LO4Cypff71Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA3MCBTYWx0ZWRfXzIsL0vl0C/sl
 YbGy6kc0rUA6dkucID1qAvmt6dFW9LDWQ3eiRXkQH/OGrPmTXbLRGDAXcZIkEeUPg88kVunfATx
 7KzFBSh00GHBqzAA9fEvTC+/6cEbq1mAjIeLje/hmW2tCaQo2pdoxJ2CPn/H4Zqy3vBayvqLAs0
 ltWln54IIZ8N5pneX6S3bLUapwRrysPCFn5kZMhoBo6hZ6ynCTCANRKleHTxJzjvl4lPnkTxcd/
 TsOi0F9+hikrMYDPOfm9XcAQPjzNYhx/jm2xRjPrQpbSj44UA0uRrIh3B6QlnjbfC3vSm4MJMJi
 U0dVECxFDWlfLIF/0LhHCLQFwzoqxk5xp1l3goh7VXFfGhWk6gJ+PMTKSnT53S6Rri9m9UNdqLT
 vzgC3OGV78dETl3gXfJ0OgAIPRqQJvGQlI/LlX5zmt1NeA6fq1QfNpDbYEXPhWYv+hUBNUkkIvc
 tTZ/k+Clrth0og2o8hw==
X-Proofpoint-ORIG-GUID: BA6edne3XwB5VhVwaMZFvKH5bvNbky1A
X-Authority-Analysis: v=2.4 cv=F6hat6hN c=1 sm=1 tr=0 ts=69c25070 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=A2YzKnAdJIP43pHWjKUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: BA6edne3XwB5VhVwaMZFvKH5bvNbky1A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240070
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270937-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[quic_vpernami.quicinc.com:query timed out];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c04:e001:36c::12fc:5321:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vivek.pernamitta@oss.qualcomm.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2D62230535F
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
patchset link for V8 : https://lore.kernel.org/all/872d3520-f749-4d4d-a8c3-25dba30e947c@oss.qualcomm.com/#r
patchset link for V7 : https://lore.kernel.org/all/20260205-eth_vdev_next-20260204_eth-v7-0-f85645210f81@qti.qualcomm.com/
patchset link for V6 : https://lore.kernel.org/all/20251209-vdev_next-20251208_eth_v6-v6-0-80898204f5d8@quicinc.com/
patchset link for V1 (first post) : https://lore.kernel.org/all/20250724-b4-eth_us-v1-0-4dff04a9a128@quicinc.com/

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

Signed-off-by: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>

---
Vivek Pernamitta (2):
      net: mhi: Enable Ethernet interface support
      net: mhi: Add IP_SW1 interface for M-plane support over MHI

 drivers/net/mhi_net.c | 66 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 54 insertions(+), 12 deletions(-)
---
base-commit: 09c0f7f1bcdbc3c37a5a760cbec76bf18f278406
change-id: 20260324-vdev_eth_next-20260323-398010e29143

Best regards,
-- 
Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>


