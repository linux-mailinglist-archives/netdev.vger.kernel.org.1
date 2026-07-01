Return-Path: <netdev+bounces-303750-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pTSDHzg8RWon9AoAu9opvQ
	(envelope-from <netdev+bounces-303750-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:11:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5C36EF8FC
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:11:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="RYgaxU/5";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=ZJvtjfFF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303750-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303750-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D898310F8AE
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 16:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1BC4BC01A;
	Wed,  1 Jul 2026 16:00:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5515F4ADDA8
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 16:00:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921655; cv=none; b=LjYzrGqEV2DwmcxpUJpU0zplJ3ucFnRIWWiEU3zfAX+ESQC3+AWXJk+xdRikHlQPYVFKWEvuJmhJKe37ttFEDCWXdj1fv6XvYml16O84kPqQxMCyECOkwsKoBMk6VsmddOp6QsTKfSJL6Wds3g/YtK0/YA8abQ5q+Zym67hpT7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921655; c=relaxed/simple;
	bh=g/kZEO26OX4smC+wgpc8bkbcZi84SL0SycYp6R1V6Wc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZZPebKbjuDdRyA5Ixjy9zkgyjJogmxV8dKJcdAWNtGJ7qwSDXMPv27Vx78aVnS/RofIxndwpvSXIByQ2ceKMMFiwznvg3V+cvrKsNat3TaL2V3KfovnlAr+nPORmaUWA2DsfSW4puk1W7MsQT8QE3frpLhc1aqyoCwcGDJy8I2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RYgaxU/5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZJvtjfFF; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661FoAn91469917
	for <netdev@vger.kernel.org>; Wed, 1 Jul 2026 16:00:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1aaxhulcUS260xJYhdZ1yKDQBOfTkI9rxmodcghc7/I=; b=RYgaxU/5XUemkleJ
	+rGnL5+wvDRn3jX+6HhlJkaAfVY+AZvzcQXBWB4qc1A05Oz36348cY8xMTbV4J6n
	JLqnk+nD1Q34IFDibZp0WwG5205v1LtKlJtv/2Fk8XjVYR7e9Acw7hFPrSFGxPT8
	rjfGdLGJMMhP9QFUdk/CIxmQuESLSAwZhrETYVqDodpraqRtS12dzEEvLh00MwUG
	4nEj88OiIxNp4nt9yl0YqBzukogbPHUP9ZdfWnv2wzhc4wA5GsgwqtKGg5/0Ah6k
	SlnJUuDDe0qqPs5NziuQNYsdKov2JzdJLN+0gIrDakdbISMtCviZ233f9L39FB4Q
	I3KTCA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jtqn3j7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 16:00:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e695a3b28so251552885a.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 09:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782921636; x=1783526436; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1aaxhulcUS260xJYhdZ1yKDQBOfTkI9rxmodcghc7/I=;
        b=ZJvtjfFFce9KbkQ9KHi8RxSpUhje27VdjU4yIhiNpmNv0BzGyQ24P+HloP4KbRpHCd
         rDvRZyFibrSzx6NXomDwBobTS1zA/4J4OFr4kM7MDrVTdi7VMdEhn1w0uLPFfnpAYdN9
         twcGVnh/VFUAHHSjGtYOXJVVZ6EuZTBJqQWbskzySHHO6Kj2Dexfgjzdz9EjnYIPXbpj
         3/NI2z/umA8Pn0TjNsje/HRYezEA2Y0jiB0En9lTVwr3/65oFpGp4eC4vOtUFY//nL67
         GgWSIAR2aQwQmH+UIMygyoOsVhxYVydceaJmCGTTAKAhWu46skE8bipjkZL6tAr4XP67
         KIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921636; x=1783526436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1aaxhulcUS260xJYhdZ1yKDQBOfTkI9rxmodcghc7/I=;
        b=pNybEjzRdJB6BbLM/yblLDYtRe9uP6A4Fi1MzQmARzL7oAONfSCNBthrybtIbbkZmm
         MDscfHQ74+cCh6Dp25gPafyoilk5paHy/eQLyYpQrshdDtvGOfV0YmMtceoz1d50Gq6g
         fAevl9Fcwhkl0iMf8K3RCZ0ymdc8lcRHa5cxngU24Xv234E6oBN7A9gbPUUz8XVbLAhm
         EOxhocosFbf/2/db6DNU29E887fL3cjh8YGFXn7dtWHJb7L/vyV0aYEUFtpJwXQcFxU4
         lKOVkyRpnYTOP8KvFHpye7rrt9/gVM9MGRU35eVwGwlwB7a2IPbRv1DF4pyH8eHw+nCH
         9xSA==
X-Forwarded-Encrypted: i=1; AFNElJ9qt3EIsR6ItaOn5aslzaR9/uF+W6QMZJYHZEsA5tUxKBUlmgHIJMp2Rzn61BdrGMRo4W0z1rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIuWt6SctnL8bWJv0515ADM4jSlYxs4taWfSuqcLg0FntUBZuP
	355wCsgJhAzL3XmJz/9I4+9tK8z9aiGXW/YOT8LlyH5XiTpblnb1qzmOUXdY5hGcfUNhe7vK1If
	r+Vhp5eIF7ankCs2X0htIFfBAyPbMByJ2N72hYXHug8DaaW5DQ+I3DBQ8iyQ=
X-Gm-Gg: AfdE7clSE9g3KtMs44lLqfyz1XFisgkgAAWFN7jAR8Tx/02jpc3VR3ol4aCOeF6bhjN
	QtGIlU7pXF9Ww6i92A+Y66SHUC3xLW98yk83tYHrRylLz9pu704Qu45TzSAbwRUjfUQyizGPWhc
	ASqKpyx+Qwo6ej0CF8fLpOdIKQ0L1zSO80qVLmqzP8vg5EbC1Nm149GHyNge/j6dPRXTw0d/mDI
	kT6bCAxDn4An6W4XJ5KX9FC36OqFtPpRMchjxbq7P1bBmU74G5M3a6i2YSpA1crzsMR8TwVEbNI
	qGQjUqjjpZGuAXTvt+liN/GknzhhWFXXdwSm7wCCSxtakSR/2tTw8qxCYte2LYqoiMPWapM/i1P
	Nn4qiaAIjEmL/aMl15OgwwHiDbToe7GnGYS0l0Pu9jk5sjP2DN0Wngzx6ZAaw0o+CTxT8jx6DOR
	yBwuwz8W9MX9E8sMzqvlaS+ITE2/eiRUldnzXDLTOuGXYlm/VmlMaEa6eFCFszYgM=
X-Received: by 2002:a05:620a:4381:b0:915:29cd:306c with SMTP id af79cd13be357-92e696ad1f6mr886598485a.9.1782921636003;
        Wed, 01 Jul 2026 09:00:36 -0700 (PDT)
X-Received: by 2002:a05:620a:4381:b0:915:29cd:306c with SMTP id af79cd13be357-92e696ad1f6mr886542085a.9.1782921633251;
        Wed, 01 Jul 2026 09:00:33 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d19e03sm296613066b.4.2026.07.01.09.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:00:32 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 18:00:25 +0200
Subject: [PATCH v7 1/9] dt-bindings: mmc: Document fixed-layout NVMEM
 provider support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-block-as-nvmem-v7-1-3fe8205ef0a8@oss.qualcomm.com>
References: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
In-Reply-To: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: YeSkLQMfNrkG3HoUK8XmsVe2U1dGIx6Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX/HoNlFUzmiO4
 WjR971VMcYVDRy1IDMWl6igfVUjW4BPk6OJ1frO5lbuHrmY/7vBRhq4gZhunoplUBxioBV8klXr
 ACuZrOckqo7cRb5VN+WLs3Hi/JCk4ekCct1BKd/J0/3QNfzJfDbj4187w4oGka7rz7qIU+QlNdo
 3cPMN7zTQz9UVUn3JWGh9OFL/kJ0oPR97fg0hrziyDjR6Mdde+9wlp0MnrwmUyUd3ntt8/bqCth
 NMmBLvMtdv6XP8rB7wu3hagoW58aNII04jdPzBt0QpVqFy4ZyfQOofFuIviH9k3/worbWOb5NN3
 OirHplnhiyLMT33cq6NnqEVlr1ehetGw+6errIfb/rDWnLdbyW2mXMl2mdfYizxpp4rXO9hTJ4P
 ykInHWTC/CoSLvhR0EM6wcOaZSNSkk+onWD3/RiOz5UGUo9nowyPJWR7V7XpWi/w3tkyQUiyQ07
 aY1aysf5C3YfMuhBnWA==
X-Proofpoint-GUID: YeSkLQMfNrkG3HoUK8XmsVe2U1dGIx6Q
X-Authority-Analysis: v=2.4 cv=LIZWhpW9 c=1 sm=1 tr=0 ts=6a4539a5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX8xApwnERya1R
 KkK2E2WdL/nHq9toK0GJu3pnIp/11I9TnVL9WjeaNbFIvsKU9IuVXT4FRi8wntpwR4qF6ZC0kvc
 cdMLYzt+KqjrJ7eX27xCC1WwfUp7H6M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010169
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303750-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:ansuelsmth@gmail.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 1F5C36EF8FC

Allow an eMMC hardware partition node to describe an NVMEM layout so the
partition can be exposed as an NVMEM provider. This lets a partition
(e.g. an eMMC boot partition) store device-specific information such as a
WiFi MAC address or a Bluetooth BD address and reference it through NVMEM
cells.

Accept "fixed-layout" as the partition node compatible, in addition to
"fixed-partitions", so the layout can be described directly on the
partition node.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/mmc/mmc-card.yaml          | 23 +++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
index a61d6c96df759102f9c1fbfd548b026a77921cae..0422894508478c8d0ca68292b58a5fdbee218358 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-card.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
@@ -38,7 +38,9 @@ patternProperties:
     properties:
       compatible:
         contains:
-          const: fixed-partitions
+          enum:
+            - fixed-partitions
+            - fixed-layout
 
 required:
   - compatible
@@ -86,6 +88,25 @@ examples:
                     read-only;
                 };
             };
+
+            partitions-boot2 {
+                compatible = "fixed-layout";
+
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                mac-addr@4400 {
+                    compatible = "mac-base";
+                    reg = <0x4400 0x6>;
+                    #nvmem-cell-cells = <1>;
+                };
+
+                bd-addr@5400 {
+                    compatible = "mac-base";
+                    reg = <0x5400 0x6>;
+                    #nvmem-cell-cells = <1>;
+                };
+            };
         };
     };
 

-- 
2.34.1


