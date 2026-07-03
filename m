Return-Path: <netdev+bounces-304564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hbXfD+e+R2pbegAAu9opvQ
	(envelope-from <netdev+bounces-304564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 15:53:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D9B70317C
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 15:53:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Z3c7nV1P;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Bu7T+vPd;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304564-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304564-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C104F307F62A
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 13:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04E63D890B;
	Fri,  3 Jul 2026 13:45:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6113D3498
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 13:45:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086333; cv=none; b=RUD8a5I762o/PvmkbiUmdmhinmABFcXP8Vhe+XOC43i2/rfFz+OjEAXdfTuIC70cEFcuz8mqFiru7fhChcn5+GRb+VXDWuGBXpnDnRwuhgfb//b5Qo0VNhVOg0CTscLNJ2l+lSyH8NwsPwUav7zwRiRWyrzvFULfAKos+QlD+KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086333; c=relaxed/simple;
	bh=zkO7UGTBhc0abSbmAA7xbPJx3KQa3FMC3+fWJRmAgxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W0tv+Eqcw7r+2nRfA2cSNS76FlZdteTOSAOJt/bfRRktYFYNCfnRrfUEFA2BJ7XBZbP1Rvog46jpO0Vzh70Jm6SkFxaWv9yQekTOiBQBqBlY6/RLQNpofXvdED2BG1FemYqd6gkG+99E7qpLECvooqwSG/1jAOKLFmn+ql7NFRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z3c7nV1P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bu7T+vPd; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663BRV4h3108952
	for <netdev@vger.kernel.org>; Fri, 3 Jul 2026 13:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AwhIzMOLwD/T1MG78AEfie5XOqWGm9fdRJaKy1+95/o=; b=Z3c7nV1PTRoHjP9Y
	N8NDqCV0gtQJFr0W6O1wUDef4OW1eTa7rUWJcI+L3YuZPAYrKIcWudhVKzTJqrJZ
	eb8HX8BJlDfPhqHG2jSC/hXQilE0PXXKmZ/EXQukwgOqzO7ShYU5tnZ9sGpb5/lD
	7nQTCQR4TcNLAguTL9DWCbTEh0LP/73+RhvONYTPVoYavquvmBeDzrHwrI6hcJqC
	GmOV22R4aAteWaxzLt8ZOebOd031WA5/81BkzbBNFt/yQnXsvV37lXp+vd7Dc9me
	M/Bixtazx6p0hww+H1DWI4pq7M76d95uIY0eGBfVH2w/mfeJPD8nzdIBx4LRNVld
	RJCFBQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f60eyba9b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 13:45:31 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e82060977so66127185a.1
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 06:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783086330; x=1783691130; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AwhIzMOLwD/T1MG78AEfie5XOqWGm9fdRJaKy1+95/o=;
        b=Bu7T+vPdt0W5/qE7eb59YhefA22Hvl/P0YMJCgnxH0q+gWbiW5yV+BQ5BGWlID4B1y
         /ejcaKK/GQjEgABa4huwcOtTGMMZ0nwr3BoybZKD81TCItclI2XxOccMAtAEUghdaibu
         uEKRZLqsl4gkBD+oLscnE6RQdPeXY0xztUgsCb6C8uaDB3ijGUWKZLLQj3yg4K8FLA2d
         zy3k+26RFVZRS0x0qtvv1uWxlyhXV8GHNanO+xg6T3RPLos3Ow+05tKAuwugYhzbkPVg
         UjoRB8SdGRWuKD6FM8x6n8B79kdEYkF1ibqWBk7vCDWIwRSfR9PWA+b54o0sqPmFcP1m
         d4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783086330; x=1783691130;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AwhIzMOLwD/T1MG78AEfie5XOqWGm9fdRJaKy1+95/o=;
        b=hPFDu3dWHgYd6ohO5zqd3cL1/4Oey3XyhN6coHr/3ejoA5Q0zwNGrG40ciG9vLfZEa
         Ia8YwHiPRKGnbB7yMOiFbgST6Ljsp1wFGVBhEjXpK4vFhd+mzGrF17T/fffxtCZb7dHB
         jUaWBSR37SmvKDvlJexT1MPQwDNXq0HTgHpZ1d60DAVH3tASXw3FLIQsgKK7ynieRmFh
         mzDLtZljgjKI/GiCsUyh1qm9vxiyqqfl6bmi7OtXm0D4XyBDrpqcxVLq/oV09OX1Ait3
         7TepoCZTKhgKsBUs9wtZSzymBvPnCwhx4qROA3gLwzmWTw7u3KF4AjIzqZhF1TQ7ty4w
         b6pg==
X-Forwarded-Encrypted: i=1; AFNElJ/RSYj74ZLm1t3jenFdlddOIb+uOJzWPCR9gYydWFvkM5k9R+f4aomGqaBasrSguNFvw30lW3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+PWGmQdXZBXONMjzRUoVsu2hyXvQ7pkFJwdkE2uFflDY1EPnt
	KNY+/ZG5c+fP6hDSqSGJWGLigu7kbGy/fOrTZJ5OylbuvNjsPP5C4YHONBixBNpu3yDMeXPp6En
	TSaifssdFNUWOa0QEklAJX2/AW+brWttHXCzKpjDM6gObztcPq4I/TRLcXTc=
X-Gm-Gg: AfdE7cnw2lkp8FH9u7j/fAFFTgn0wTk4TXDROxrEe7MXrCLTFL/Ei2QcXTjSN/RUzyk
	ViKWRSJobcVEhV+AFDpcC6OIEHG0am5fesfqRRztqZaJHZiJf4ySxVU3+BWoPqNYDL5zn1pDhtD
	8ZP6n35S7Vrsa1pVdEf3iuuvXcfxkwoALOgoiaggaWB1ZDU/2BHy2NllI/dfn8wzEzlzZiFBfaj
	IPBU/yt/03LyaLnqK4yRsi75QtjEnAGL3Nx32qmYi4S/jItDH/doSqkwIVxzrpRDlQ1w2Hzpwem
	jClepsmIhucxpNHriMDoVSxggf/t7t002VrrsNjE2If8Gq8fO3RouEP74hzRqRVzNfAdYjTFO92
	8OcxQzx1kLRnGG/Ky5ba1nAwnwKdbLzt3KxD5IE6yPHT4Fkukj414/cZ4zAxC6nMnb+3+4B4wfX
	To8QeY7rG1CXdWGMaVSLHoTusRBeRsUIT1QLNZiKlkPjuuhFlQmx+rgMBxTb6weGM=
X-Received: by 2002:a05:620a:7007:b0:916:5f5:de22 with SMTP id af79cd13be357-92e8b29ea54mr485345185a.12.1783086330457;
        Fri, 03 Jul 2026 06:45:30 -0700 (PDT)
X-Received: by 2002:a05:620a:7007:b0:916:5f5:de22 with SMTP id af79cd13be357-92e8b29ea54mr485340685a.12.1783086329977;
        Fri, 03 Jul 2026 06:45:29 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6059e4csm286135466b.1.2026.07.03.06.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 06:45:29 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 15:45:17 +0200
Subject: [PATCH v8 4/9] nvmem: layouts: Support fixed-layout as the nvmem
 device node itself
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-block-as-nvmem-v8-4-98ae32bfc49a@oss.qualcomm.com>
References: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com>
In-Reply-To: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX3Cygl/OEs8EN
 xYfmp/UzysVOvDkfwthWcvMdBZfMwR7LBZ/BwOawAGJaQOm+29mODTKJyf2/284tCoh4cIuPsHU
 Jux6kgWNnyg1FoTxw5Mylfqhdga28xpP6N95CaIPMdhXSRIMZbO2c77X4kj6vZvP0sD4Wt5Wk4T
 9Xw4PhYHSiGInK+QF3bFYBW43XgSodzmzudDTA5Q/MJu4hGa4BcBfRicTA9t3ELtIrr/JZzA4o+
 i4+M/98JQpZfHGN1vdTlaOcQMoWm2A/9DE4KpD7xZzw+2YRidoOOkSWj4QfvWyolsVP1AM78gGs
 QjRdgJcg8Ft4O2nCIDof6AIqN+5qinU3Rm5KUvfaHN3lgK01MvWe46C+0ngpgXghho+LQSoZOzQ
 dUwwJJb3ZAxAM/SF7PFUEDL+c0n3bJH4NXLfyzoJJIb33GuU/Hb6rJJjVD5EsOgiDZvtaZgqCqb
 TRycu8YRgN/AJK0juug==
X-Proofpoint-GUID: YnzHk5VDX2afiOcv5S362o0dW6QCRHto
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfXxWiJEC2QJCin
 6kN7i2Zg1xssYZ+KeVr1u2G3sUYvbcKkDBfq43U5ERQJfgf0A/1OuhVnk3uXsT0F9Nu2/OZMhIk
 3q17R3+1k0KGJjgg7BpTHuwF+zVQ3Pk=
X-Authority-Analysis: v=2.4 cv=SPRykuvH c=1 sm=1 tr=0 ts=6a47bcfb cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=4SYEPDBQci7QR0ImIkAA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: YnzHk5VDX2afiOcv5S362o0dW6QCRHto
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030135
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304564-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:ansuelsmth@gmail.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D7D9B70317C

of_nvmem_layout_get_container() only looks for a child node named
"nvmem-layout" to locate the cell definitions. This does not cover
providers whose device tree node is itself the fixed-layout container,
such as an eMMC boot partition block device whose fwnode points directly
at a "fixed-layout" compatible partitions node.

When no "nvmem-layout" child is present, fall back to returning the nvmem
device node itself if it is compatible with "fixed-layout", so that its
cells are parsed by nvmem_add_cells_from_fixed_layout().

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/nvmem/layouts.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/layouts.c b/drivers/nvmem/layouts.c
index b90584e1b99eab4217cbe7ec48373e18a7caf0dc..efa631ce7283bdd6c8ecda75915911b5e3a33c99 100644
--- a/drivers/nvmem/layouts.c
+++ b/drivers/nvmem/layouts.c
@@ -167,7 +167,18 @@ static int nvmem_layout_bus_populate(struct nvmem_device *nvmem,
 
 struct device_node *of_nvmem_layout_get_container(struct nvmem_device *nvmem)
 {
-	return of_get_child_by_name(nvmem->dev.of_node, "nvmem-layout");
+	struct device_node *np;
+
+	/* Search for nvmem-layout child */
+	np = of_get_child_by_name(nvmem->dev.of_node, "nvmem-layout");
+	if (np)
+		return np;
+
+	/* The nvmem of_node is itself a fixed-layout node */
+	if (of_device_is_compatible(nvmem->dev.of_node, "fixed-layout"))
+		return of_node_get(nvmem->dev.of_node);
+
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(of_nvmem_layout_get_container);
 

-- 
2.34.1


