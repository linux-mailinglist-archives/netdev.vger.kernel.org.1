Return-Path: <netdev+bounces-294068-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HsRCiqJHmr0kgkAu9opvQ
	(envelope-from <netdev+bounces-294068-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 09:41:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E97629D2D
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 09:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B7F83103C00
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 07:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2C03A0EB3;
	Tue,  2 Jun 2026 07:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mCCwsyJC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YpaWI8l5"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B833A6B6F
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780385670; cv=none; b=Ssd9KifhdX9wYq/bbgwfe1Mhf/WV/bmozU/FJblMGbBflrZIEtIse8GmnYg1raNwsI+xXku6NHQuEnUigiweLCALb9EBvEL+Wkat3ocTgD3crl33Hlj0dVLFmJOqS3xNTrUVPtxZafnHTwNQKd/XFhK4apZI0qHTVPHK1XtyPRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780385670; c=relaxed/simple;
	bh=YVirmTDYaEkiYsJPJUV6u+ccJQzQNksQiW7zP4Dw14U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P6ZZsDpn79dT3NVFa3XSe4/YW4hDMN27KuvGm3uf3k4zjGocBn54JC2uVaXOe9MDy1X9UzM2AAmJome5jRQDfDzf17sn2sH+UQJiunQ+zMmfFCOMDiZzjBZ4mUkwZNTBFdVYj3aQoZq0n6KlcPuHaDN3NpgYg7N4eoNNFhQkDVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mCCwsyJC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YpaWI8l5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65230c9A3128015
	for <netdev@vger.kernel.org>; Tue, 2 Jun 2026 07:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=JjC88RteyMdNmZiiaQdoQEc/10QE+WI+V+C
	6wyLn56Q=; b=mCCwsyJCStiVArdcAakihN+lVucb+RmIJ+esFp/Lm/ZZaBRBOu6
	qOY/JkoG/OmdTPNQ4MSjGpspHTeLEPUhXfbVMS6F+5oWpFjEsZbrdURfzp1otOI/
	3T9pauBZz29MgxxlljYGnvdbLUUUIqG6sjn/tJj6TlPGfhiNZZhvWZqLCqY26h/y
	w0YSTceUkmpxzikPzKCrNV2WCvvzIjDV3PHvu/AbAUeLSECsrVg4aEtpYkvV5JlF
	cU593s5cNY9XexgMRLTxTbl2REErDsLlp3flxOTFC30m+o8sN8P0y0cQvMk8OzR/
	bJ1iHW8enyFyn/9yW+eg+0+0GS777U6Ne7w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh9014n5h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 07:34:22 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51739cdd8a4so47960961cf.2
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 00:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780385662; x=1780990462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JjC88RteyMdNmZiiaQdoQEc/10QE+WI+V+C6wyLn56Q=;
        b=YpaWI8l5bYG5dP+5ojcB1/pgG8oUv235TSCdMTe2F3xV+T2zJm7GWFpry6XbvTnsmK
         54ukSrzDVya1+mrRZgQTjaLbPg/8Tbf/THnyLqeacdYPTuLHOPhKzUfPEvunMV0K4UMg
         8YktDv0kOFu7uIh+uD9uUY/1TP7ydcZx7QqiexaD4YUmMUEyg9HzJDeTqqYBV7h/niIP
         96vFY22INf3o/kZ9mBQXJSl9uHaTHP0x4MMEM3wO6KnyIgz3i0DFoOkfNeI24TNNb5US
         V0R675aTvOwSASn+fSDYdkKKZNzNGSDSfx8EOT8uGyYcosFVhBvQ/dnc/cQhl/LRNbmF
         Dq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780385662; x=1780990462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjC88RteyMdNmZiiaQdoQEc/10QE+WI+V+C6wyLn56Q=;
        b=U3nO8MniM3tZqSKr5bQ96mGuksA+BoxxsACqln2maZlWanK5K2c6NsfuHEBnWCnseJ
         Ur1nzujwYHltSW0aWhPfxKvwMjzWRLf88ejc0hGQcOwbci+5yHHPIxSQNdPAFMXDFXFr
         K06FW0KJWRyiz9LadxNfwrHAla1DsnTQABTx8Rbfxiarn1sQbyzqyzS9ZxqmOaX3TLVr
         XN5pTK6W3uAOEpuvM9qob1EgDgwvjmzrS3HyHqqamMFsRsv9IeEA4gkpR5J4vdbV9RT4
         2nK4nOMTsffu9agg2K18Wq8Tnw1KDn9x5FpgjG17ZdAP/lbSOhnj+y234lY5wJ8vKxCH
         wR/w==
X-Gm-Message-State: AOJu0YwEwTdNAP4CWwzdE30HYCp7bcnAeKbY2HT5MMxm8z1ejoXqF+Ob
	YXDfRA8Wk+KNdAmORJHs+BB1fxkAXNlgiHI9maMEdPtcCfYVtGwSFLNxatuBSbXiPamETxedETM
	3ZLSi1xpggWeTFA3mUpSppCic6pv+SZ8Fy6bjTHquFPDFEwEfRfouggsVihY=
X-Gm-Gg: Acq92OGuzrpcCQY3InmvTJZ1dFi/VoRqCAHxcUOBkAGRb5IlEWV6zU5iT29vow62MXb
	XBVPUMBnpzRRh19LonHxWdMEXmGpBiUaY0hDoc7y1N7jX6ey0n8/pDxm5yqcuMONHM04FyM13Dd
	X78gMKxxHpKE2fBEuZhbKDbPhWLHVv/fyxb/JtAuVsYwYcz0eveMtMSilmdpusAr59OvQ1LiDXY
	KeBnIfJrX4+IKEDnP+8yQK13DE7d22bAWud4QqeVCSEDTQYlrObglRLLfOl/w/BPnvSrdAOBnLK
	bj6kch2/C226gyH4+juSSaQN5mG2jVYQlmLIpp1gjZELcsj7qo9zP1N1PBZ0ozOQs7wsz1M5Txf
	e5JL1mgUqxqnJ268Gvdd/jYyDNH/z9odRKAiYU1cCld9TpqOsMAjSLCpKjmjMl4gjN3KPZHs1hY
	aLCxqfNdLIePCTEQ==
X-Received: by 2002:ac8:5fd4:0:b0:516:daff:7f7e with SMTP id d75a77b69052e-5173a80ffb6mr203814351cf.48.1780385661970;
        Tue, 02 Jun 2026 00:34:21 -0700 (PDT)
X-Received: by 2002:ac8:5fd4:0:b0:516:daff:7f7e with SMTP id d75a77b69052e-5173a80ffb6mr203814161cf.48.1780385661519;
        Tue, 02 Jun 2026 00:34:21 -0700 (PDT)
Received: from brgl-qcom.local (2-228-54-83.ip190.fastwebnet.it. [2.228.54.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34a0403sm32453424f8f.6.2026.06.02.00.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 00:34:20 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH RESEND net] net: mv643xx: fix OF node refcount
Date: Tue,  2 Jun 2026 09:34:14 +0200
Message-ID: <20260602073414.22500-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H6nrBeYi c=1 sm=1 tr=0 ts=6a1e877e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=F4J0OHcPalsv3C1teIDEwQ==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=2glh-Q7MoEu8omcI7JcA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: _eOWaVFY7duM24UdrlXagjVtDbCKTZj9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA2OSBTYWx0ZWRfX/2peR7MDcOve
 Dt1RoXU894Pi6tXA3zjo/qJVjgr8hF3euJcLs3m6R2JYt/ha2e46qYgNTE+ekm1xJYn13JULhbg
 Rg4UcD/vRxK+anhLY+W9sJNQRe7mCyK59lFATSCQPELOKBFyr02qLumpWLTMhr8GIOF66THTj9l
 iQogBLgN4ahO/mxJ4RxAdfseWQAu91B7pwoboVc4zHpq6hPRfm+G2ntPmLBGYvedT/6TQATLtpW
 yK4vJshARkdu/EWxlSK6xzIzwrwit4WRD6LhnTmtLuIJufl0tytBl6Xpp608/DpwhLV0HY0WAEc
 UViuOB7UY+6cbalb3Mdcw8WMN/3QThsbTiCijf80ammxxXPNTAhOF5TWfXSEMZThc2Am5ouUugt
 kI4xowRS/bCwpdqb8iZdeGUBdX4l94DXQqjffVOU99zWsJe581mPJ9FuI/sCG2d8qnkcRPlyhU2
 B4tgoMQ2HuaG7NGut3g==
X-Proofpoint-GUID: _eOWaVFY7duM24UdrlXagjVtDbCKTZj9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020069
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-294068-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 78E97629D2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Platform devices created with platform_device_alloc() call
platform_device_release() when the last reference to the device's
kobject is dropped. This function calls of_node_put() unconditionally.
This works fine for devices created with platform_device_register_full()
but users of the split approach (platform_device_alloc() +
platform_device_add()) must bump the reference of the of_node they
assign manually. Add the missing call to of_node_get().

Cc: stable@vger.kernel.org
Fixes: 76723bca2802 ("net: mv643xx_eth: add DT parsing support")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Resending separately as requested by Jakub

 drivers/net/ethernet/marvell/mv643xx_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index f9055b3d6fb10..1881583be5ce2 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2780,7 +2780,7 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
 		goto put_err;
 	}
 	ppdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
-	ppdev->dev.of_node = pnp;
+	ppdev->dev.of_node = of_node_get(pnp);
 
 	ret = platform_device_add_resources(ppdev, &res, 1);
 	if (ret)
-- 
2.47.3


