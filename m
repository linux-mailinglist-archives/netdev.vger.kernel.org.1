Return-Path: <netdev+bounces-257110-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AolC35yhGnh2wMAu9opvQ
	(envelope-from <netdev+bounces-257110-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 11:35:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEB7F1613
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 11:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3F17302D0F9
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 10:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62213A7F7E;
	Thu,  5 Feb 2026 10:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GCOgMNh7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JtTEqW0u"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43093A7F45
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 10:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770287695; cv=none; b=tEcFWQfkGgJSi1C4ChbSbzk1Osguu1mYjOZDrsRkV1HmC1k0yNpUo7tjzkgZrQigLiAMb53ddswlD5Ohj9YeUlJA+Ut9rWff+8B4NB3tjz/68hMcDPM8eptGC1RRKkp+N1XtmR+a5h2NEwOAcXQkuUuLEBzcv9nuwstIml69Tto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770287695; c=relaxed/simple;
	bh=Pp2grdy0HGvxTDX/hIeiquPXDauTvrRjkXfG0y5tgGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ALM8q8xlSySXOuakCo7djubi1QHGFKtktg3ih/yqzzvyHS+QWeHyz1QGnb3VXULOTgem+TNg+6deJvBiDZvfrWNvtH2Bk+Nb5SjDco0K89QhJ4iK+w8b+tDiGZ/S/7Vpz618TI+p0CgZRxruwMCJh/7znpbhLsRQksav5hTW5A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GCOgMNh7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JtTEqW0u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6157Mi36890365
	for <netdev@vger.kernel.org>; Thu, 5 Feb 2026 10:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0pDwIFMOmIHXKjSM/iN19GndmiqDGOze1XVUOoV9B2w=; b=GCOgMNh7efuVs+98
	9moa17eJiYyL83XDjUq4BOAOWrwj5RtstAHVeo1sX4gvODJczrWzafi/TeP3fMMA
	hTCKtajZRr/cN7RPT6Q0aNI7GYE6w4ID1SCHnY9/1HLwoWoDSZl3mEi+e3qadoZg
	wsYv+8Z7YcrsZqr+XK5IPZwvX6I+IlnFZexCc1ukK7QgApqylxo4PfFcthI95N7F
	8gfTEgt/Xwt51+iYqvisEWzDcKy/v9eFQ8u+9loz9Qf+h3Sdh+UrcVaGTuVViOmu
	alhXWIKnIt1LrqdGSRg/IAqrUcgws0AfLqE952YDwJv9REmh+rslVPazsMLWpnxD
	hBuHBA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c4prx8m4h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 10:34:55 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a76f2d7744so9104865ad.3
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 02:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770287694; x=1770892494; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0pDwIFMOmIHXKjSM/iN19GndmiqDGOze1XVUOoV9B2w=;
        b=JtTEqW0uLTY8Ywu5Sv+4h4Cun81xfmIESBt70Dt1cQOvBye6xXbxKj94N/2wKfd7ZR
         wAZbvjMuShDOEApguc7l1GpGPlOw0zGXrkhHaBbKrjQLlzAaHW/Le2TZ0LvpP3b2TOGC
         Bjtr7Y7FhjyvZgHTlwayR12rvLDXDXZ6M/907L4YphZPDpOoyg8RElsVXYqCXsTPdxi/
         gyMBE9iiWdotqetkVTeGmNwTuv/pKypZrhFj02F+xmeFyZI+Guiw7msf8dugjd6vvcPM
         AN/pEyJzPUi++LzwbkBTvN1C9gzGVIzESZaT8uF38M75QLr9lcLgbvKnlBhHVlPXdQm/
         mZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770287694; x=1770892494;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0pDwIFMOmIHXKjSM/iN19GndmiqDGOze1XVUOoV9B2w=;
        b=NNblgkCJWf36VFaFC9S4AKA9eN5sVOgJA97JdsrAnGDjPmCEo7kp2aQzBiguf4HKd7
         iEJ1qEH0OgVx0MNkd8ot9gsYnJjYFl/h2bkf1Ef+7KvFmR+kd23ZsGsBx6idJEuOm8Z2
         o6dzZqNMXOlMk6R3bOGZQGGP8pEgwV5GYxQpqO51rHsjncqvcHnPaCSe+1TFo5vGKM3o
         lP7tJJOlwzhWZDZq5tbWHGewvw2V8IsfCngqJW3Li8uNCHs4/h+UWGgGNyoezPxKl7cS
         E9H90Rsl+TmOPC7OOowjZw/XQBwGvqvQmRVpmtnpOMUIA74INOwXDCxwxAhZL4zev6LF
         TJYQ==
X-Gm-Message-State: AOJu0Yw0aJ1QSzoesXWj1P1zE9IsNEKDTk7XOzrUHXV5VtCIBh0BikXz
	pGbfaGX4EkOFTSVhwCaw7EMIHRucQKwLruiYvWwgk4ZOTHNaTvPo2F0ThkLqV54a68BPmRiKxl7
	eOTMe9vyvhVDdQPvyA9y9f/R2ZMEkP+KovJXNcqjrgNGHqJ9RFrYgyxlucxQ=
X-Gm-Gg: AZuq6aLxd/4sUezTmsoXbtI1Dl3g3YUmJqe6zBZks6KgQHFxgi8sfv4WOKKVmY0gN+G
	6Su0YA6/16sk29HfqB9yDQuB5zDmjSCYHVk1wnzreYG99rydbO1jLIJAqBBpCA7t3fYr0Fpd08A
	+kbZC1VQnv8I3i6gXLH7ryq9HjsykKxgs0NsYYaYGjjaIYpA8V75rV6en3SUsD6vDcNT2lYj138
	paa4LDZSE2bNyQgwtwrFU0ycTuCdRtVAKkcSDMd30MEVO5/F2dEXuaPPn3qI4+QcgfXcz1hW2WR
	YuCyZHFievl6doGfQZwr8JTvhlKdIgn402GA0Uj1WeyRotpdT6eXkPt8AOweMwAKdG5gho0q4US
	0Zr220E1cHWnt/zkEzR3tfvyf/dnMkd0wmjR/
X-Received: by 2002:a17:902:e742:b0:2a9:33ab:e46a with SMTP id d9443c01a7336-2a933fbac63mr72094395ad.36.1770287694354;
        Thu, 05 Feb 2026 02:34:54 -0800 (PST)
X-Received: by 2002:a17:902:e742:b0:2a9:33ab:e46a with SMTP id d9443c01a7336-2a933fbac63mr72094125ad.36.1770287693886;
        Thu, 05 Feb 2026 02:34:53 -0800 (PST)
Received: from hu-vpernami-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a933851341sm50539255ad.4.2026.02.05.02.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 02:34:53 -0800 (PST)
From: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
X-Google-Original-From: Vivek Pernamitta <vpernami@qti.qualcomm.com>
Date: Thu, 05 Feb 2026 16:04:41 +0530
Subject: [PATCH v7 2/2] bus: mhi: host: pci: Enable IP_SW1, IP_ETH0 and
 IP_ETH1 channels for QDU100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-eth_vdev_next-20260204_eth-v7-2-f85645210f81@qti.qualcomm.com>
References: <20260205-eth_vdev_next-20260204_eth-v7-0-f85645210f81@qti.qualcomm.com>
In-Reply-To: <20260205-eth_vdev_next-20260204_eth-v7-0-f85645210f81@qti.qualcomm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        Vivek Pernamitta <vpernami@qti.qualcomm.com>,
        Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770287681; l=1454;
 i=vpernami@qti.qualcomm.com; s=20241114; h=from:subject:message-id;
 bh=fXCaUq7DjiO3Pq6d/1jvpSm3bp5ZFTxYXJXZa9U8DDM=;
 b=1xn9CEuu91jQ6i4jgrM4k/C0PILnlK7O23NbhkkI5mW0xlMRgcokLmovr3vM/HZ80L2D+EFF5
 5uVz4XjYlYeAAg59ASEGAIKpRXTXKLROzoKsj84yUIYlBLgTJYMwe3j
X-Developer-Key: i=vpernami@qti.qualcomm.com; a=ed25519;
 pk=HDwn8xReb8K52LA6/CJc6S9Zik8gDCZ5LO4Cypff71Y=
X-Proofpoint-GUID: FvvahO3lQMgFHJqv3XOcWDc7QhNHkvd3
X-Proofpoint-ORIG-GUID: FvvahO3lQMgFHJqv3XOcWDc7QhNHkvd3
X-Authority-Analysis: v=2.4 cv=eLkeTXp1 c=1 sm=1 tr=0 ts=6984724f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Vo5YzJSDI_NEo2NC7oIA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA3NyBTYWx0ZWRfX7SxWpx/Ulamv
 eeSZtsyHVFrWA1uxlP5L8zjoPalubzJDH2rwKkVIrUqRIE6uOIftX6mNpXG3QWFImmVaxx8boU/
 fED3AL+KpOIyZm8d+9HeQ72RricNATLjh6T5082fIvcmbCho2ez7G+IEqJlaMh5yac21RkrmtcB
 Okjt6qJLiWJcIPM/KJZOixK+u64DXfs4JWCcrXoS1sTsdAQC5onz+Mlrtjx/szY6/pr1eNl09iQ
 0uPtu6oLXmt531dwB1NWSCwRnz2aXlMe60c/pigK8+sxr2RPHcmvodaPuzTtVbNM9EbD4UnbCpO
 EMAfW1fly687kAe3uii6wgdZazCFGKxNFkMtzKS3AVB+QU+9ZYrOGJ9ETMb5YhS63QLrouPLc6v
 M//wXP/qlSgHneud4zNI4LhzZylnOA8dacQ5cbmAdu82q0u8adj/RnXObBDjY9aXTHlCL8h4osr
 1109USWneD0pUtA5C5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050077
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257110-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,qti.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vivek.pernamitta@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9AEB7F1613
X-Rspamd-Action: no action

From: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>

Enable IP_SW1, IP_ETH0 and IP_ETH1 channels for M-plane, NETCONF and
S-plane interface for QDU100.

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


