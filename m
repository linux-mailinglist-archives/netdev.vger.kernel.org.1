Return-Path: <netdev+bounces-276846-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLURHpJC12ksMAgAu9opvQ
	(envelope-from <netdev+bounces-276846-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 08:09:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 393CD3C674D
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 08:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA1BA301D308
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 06:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E9730DD11;
	Thu,  9 Apr 2026 06:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LR0c+rcq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ne4g6pcx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01BF30CD81
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 06:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775714929; cv=none; b=T45Tml5y4dy1ta6ag0BhqZnOXW0HmuNKY0F3IXRnuCExooLZOirnx0QnSlFrleVeaLqAz2ggKkrxB0cjHEdH724q5eBzV0UJzLp9nO9jFYeORBPzCF/b+Tdpepm7yIs7c/3/H8lAibJxN8spwLTne2bySFRyRkT1N+4tCvj7YMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775714929; c=relaxed/simple;
	bh=TjpR/7t75mVY5PfEW56qfDWOaej9QEis2BpOJlQ6Pvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mN5AUxWj0Z7f8lwma0mmJ0vO6H2W6hYJm802hor2eesL2iz0uRQiG3Ad8+Q3PQ1FTD4+9GfkD+T8vbBM/F+obcfSLd8BpES8U2OXQnyf0nAnEUi+5qxZRmaRj9tnnJhdL1oEz0w5CiSBAixI8h4cqt6MVFj3mxB5P8cfeCpEpqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LR0c+rcq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ne4g6pcx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6392o1mY3325993
	for <netdev@vger.kernel.org>; Thu, 9 Apr 2026 06:08:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WU8Q/t2g6mHZzyGBbfJqORAVKmqDregSMry+V6hZzr8=; b=LR0c+rcqNbVy6Sj3
	yZJhaT070xQfJruKDtzjWf5GcEkp2qoois53WMImDuo3PG1ngFIzoZolr8EVRCFs
	L5J8SInOjHpsBCue8F8ayhFfL+Fp7xs+J4BYb+fKJD53JIFHSOK6F/jc+hr0nVex
	73B2R/x3pL6eEzqJgux44vmIcrhEkZRbGq4HKvpXj3lNY/W6Jy60oGboeaLPHI7B
	XUzpJ7Z794hgF1HlV3rwSoZB1c1eSACAMsW+fu+kUXh1pm848J1cSx2wWV8pu+MG
	EjAAHpzKRFIJgDzID9Ft5GqqMNg3nFM1jdOvQP1JR1ruSdUL6gHzvp8qCtMNALEf
	onM7tg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddw9msskn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 06:08:47 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c76fede6ccdso361261a12.1
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 23:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775714926; x=1776319726; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WU8Q/t2g6mHZzyGBbfJqORAVKmqDregSMry+V6hZzr8=;
        b=Ne4g6pcxoinDdVp/DJhKIWOXZmmwUr/DzOLSrJB47rbxtI38dhw2LuJnRJmMWkuE2/
         PschlJuhPonHtNeUuyLsctS2knZ9vtyHm337/gJhaDecHBr7i+2mMB+HKKWdAr6hEIDy
         178zKJ2eGQmioKbZodT5l9NjcLQqk5JYz0/cVgbcFlvSL9GPzkrOSmnFqgXcySCax7xS
         e0auiw1cyYdIiEUKY6fqfkZ8sGvSHCJFpVlbiqCiZLAyiFMXstKtFIBJF/TpGAt1fEok
         mZu4uSnU3hOMY7OnUEzP9sFqRku7ddU8U5y5L/glDduP5hMqF1BQ5UoEaXySQ5T/Mghn
         l45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775714926; x=1776319726;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WU8Q/t2g6mHZzyGBbfJqORAVKmqDregSMry+V6hZzr8=;
        b=mblmlKfb0fX+5eceEPxu4YMcGPDNNyfErVjzxadxhbxg43gSEHbecyBxMympTUP5+8
         Vy1iv+CxIgfsYsXwy5UuMB1aiPzCmrLjRUYQxspFmrBXRMcpc+zrS96nEMd89qpeOjoq
         cQPAeNTR6/UebCSrG4hvMt813BDxIj6iwwUU0hE1poyh1t/BvBnl64Bms22u/8XW7Bq8
         1070sXZRbxWAr2wd0jTecJ0J/8WamBnvh5ddw6orTlqSg5lvSm3k4oguLXNqAO0ezCdV
         BdqUYXryW2E6wPyl+vqW5qP3ngbjOfpIR4YXPiI7F3LeXvEa3xaOgEuCGLh1xFkbH9pa
         eAvA==
X-Gm-Message-State: AOJu0Yx5NoAePeMMGgmVOeppDiS7vmR72PvJplNxhQkZ16wG1qcgftkG
	RzL/qXK5e093BnwYcMZU8J+WYUX22OuvPSdkm0grOUjBJIQq17DdpaDSpHHwSF+ZzOMMovXg78+
	hvDKfQYvtnk00hvO2QzAFRuEjnQ5PS5Y62cyNEyuml/YOumN1zEyTloG8l7c=
X-Gm-Gg: AeBDievIZbuxIpLHiPE1v7FtFV4KnPjnO937ciokWF9Y/XHm4yYhz8uab5IgJbDaAMF
	ln0BCLmKV4aAuE+ujfwSB0E7X2n+EO9e4pLuIHV5ocq/ugW0DlKCBHxFw9krxlYInKeOAJfGx97
	OiOLdr2fc86GEGWxSKB1yEY1z3dkk2Z6vNfB7dYbtySWfrudvp7zoRrgMnJT2qLH6kJ9ZTsqHUw
	8JGlp5CCdmyHgojCHlGvYdXOmP4qjBnjVNuhYa1fMVJSDGiMwz5SMNSJeEpX/BY4lvNURK4S3+g
	h4AMs1SvPMVsft2PO32OoxZf+5yklNy/rhsRR+jJuOeFasETi69RGP10ct9WZgPyP23nMe4IVzL
	SCjK76+y8YJrN9U1zZpTNRpl13bs9J0AZgekQm9GHcK9PUL6MTy0r6ZafDk0=
X-Received: by 2002:a05:6a20:7346:b0:39b:b35f:2eb5 with SMTP id adf61e73a8af0-39f2f0b40e9mr25734837637.41.1775714926422;
        Wed, 08 Apr 2026 23:08:46 -0700 (PDT)
X-Received: by 2002:a05:6a20:7346:b0:39b:b35f:2eb5 with SMTP id adf61e73a8af0-39f2f0b40e9mr25734800637.41.1775714925952;
        Wed, 08 Apr 2026 23:08:45 -0700 (PDT)
Received: from hu-vpernami-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3baffsm23163534b3a.14.2026.04.08.23.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 23:08:45 -0700 (PDT)
From: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
Date: Thu, 09 Apr 2026 11:38:34 +0530
Subject: [PATCH v10 2/2] net: mhi: Add IP_SW1 interface for M-plane support
 over MHI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-vdev_b1_eth_b1_next-20260408-v10-2-6d44ca48f189@oss.qualcomm.com>
References: <20260409-vdev_b1_eth_b1_next-20260408-v10-0-6d44ca48f189@oss.qualcomm.com>
In-Reply-To: <20260409-vdev_b1_eth_b1_next-20260408-v10-0-6d44ca48f189@oss.qualcomm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775714915; l=1328;
 i=vivek.pernamitta@oss.qualcomm.com; s=20241114; h=from:subject:message-id;
 bh=TjpR/7t75mVY5PfEW56qfDWOaej9QEis2BpOJlQ6Pvg=;
 b=hiD7DThkr0tevzAGvl1emWFwT40BVN2dhtbky9mC72hPXQNiugA3+kL852DPgnGMI0t3jjfGA
 dKdkFmAh1a7CVGK1ekjFCXegV0gE18aj/HRDkeVDXtJk5Rn+71tHl6U
X-Developer-Key: i=vivek.pernamitta@oss.qualcomm.com; a=ed25519;
 pk=HDwn8xReb8K52LA6/CJc6S9Zik8gDCZ5LO4Cypff71Y=
X-Authority-Analysis: v=2.4 cv=cfPiaHDM c=1 sm=1 tr=0 ts=69d7426f cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=OG-9iNp7kfFuVu1VvswA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: ItWmlcHpw4YKHbjk64bvDUYmNJvsu2vB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDA1MiBTYWx0ZWRfX/IMs13ngQtWh
 BewrmXKQQYAX3PM4P2nJ2OqoNz445RAh1AuNv5LGxlvNDblIDgzI5ZztZS9DaG0dMyJKPftdC/U
 t3lSncmVzua5WonmIIGRXbU7ZXrgoUpL9w/XIjr/MIdbinpqRzLLGSMsLn2/e7MsrLiKMttvCNU
 tZSgVAFzalG7kvbypKHlueBiy3hfyOsrH0RoO6ZLV3zJvGcPZuEisUw25AxzFSJuqDxSq45o8Dg
 X24psgEW1LOdk3C+B3DuZGo7+wvg16IfvSkRewwoivQc/r/QqDb99xqZttmSrHue+JQSPo3YRl+
 /ZfDsXdyfHROA5ch4hF1wjINO+CjfmMwBDCALAiHUxYX9EKh63y9fn+UBjxvz+5IG49FgYQo7Zm
 5J/LzGSzUKiqZDFUqlxu4O2I7EUlMDNmV6mn+XQcncmaq9/tSsVdFI5fGCRVhlEwTEkaMlRn8n0
 6q42VoDyX4fUs/C2CEg==
X-Proofpoint-GUID: ItWmlcHpw4YKHbjk64bvDUYmNJvsu2vB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_01,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090052
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276846-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vivek.pernamitta@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 393CD3C674D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce the IP_SW1 channel to represent the network interface
exposed by the MHI device for M-plane communication. The driver
creates a corresponding netdev, allowing the host to access the
device network interface over MHI.

This interface enables support for O-RAN M-plane management
between O-DU and O-RU, including capability exchange, configuration
management, performance monitoring, and fault management using
NETCONF/YANG, as defined by O-RAN WG4 M-plane specifications.

Signed-off-by: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
---
 drivers/net/mhi_net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
index 47b8617de027980a69c57261a9b4bcefc828dc96..e285aa289cb945cd1afd2f3d581214f2f2f15145 100644
--- a/drivers/net/mhi_net.c
+++ b/drivers/net/mhi_net.c
@@ -430,6 +430,7 @@ static const struct mhi_device_id mhi_net_id_table[] = {
 	{ .chan = "IP_HW0", .driver_data = (kernel_ulong_t)&mhi_hwip0 },
 	/* Software data PATH (to modem CPU) */
 	{ .chan = "IP_SW0", .driver_data = (kernel_ulong_t)&mhi_swip0 },
+	{ .chan = "IP_SW1", .driver_data = (kernel_ulong_t)&mhi_swip0 },
 	{ .chan = "IP_ETH0", .driver_data = (kernel_ulong_t)&mhi_eth0 },
 	{ .chan = "IP_ETH1", .driver_data = (kernel_ulong_t)&mhi_eth0 },
 	{}

-- 
2.34.1


