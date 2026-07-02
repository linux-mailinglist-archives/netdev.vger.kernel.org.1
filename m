Return-Path: <netdev+bounces-304084-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xbT2BPE4RmpaMAsAu9opvQ
	(envelope-from <netdev+bounces-304084-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:09:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7268C6F5A85
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:09:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=o+dPzhaf;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=OqaZ13T1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304084-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304084-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3540D31A1FA7
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 09:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E415D4BC037;
	Thu,  2 Jul 2026 09:49:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784ED4BC025
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:49:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985765; cv=none; b=l0MafJCw72Ay7oxcj9HoCPgdDRf+0F3rsNETJAUf0EP7L0VGdTaf4a5ZQt40R5Z/LdK4f2krJfRFVjnBBIQ804Kge8P8UTnKfQNN/ZPNBbLq4BCy4Kp01JvuxpkdmdM9tmR9CMmV340a6nNwgqfi14KcKakPJDlWT7NEHtN4gcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985765; c=relaxed/simple;
	bh=Iwv0pgz/gHsFS74/QZLp4LCreAVIrDJzQUkQ70bSTjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JexjqLs4djfg+W8Eo10XSMXdlDiq0RGdayuCvL1Z3DJPklHVWKYiw/YgaCWH9aMQMgrdtWGpJ2qwuVu5Gicf7FdPu4Un879rGQmxS4fRIRLD23PISVIHHRX5hpmbZ6nTkYU8xW2uBdERQwwNGuHfEKQI0W1I4+jlZKD1n7D6hrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o+dPzhaf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OqaZ13T1; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6629nNJ84139435
	for <netdev@vger.kernel.org>; Thu, 2 Jul 2026 09:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=kO8Qq8EkKg4
	I3n0FHg5nZBCqnV7KSsBDcuJqZZjWTPA=; b=o+dPzhafQqAQv7++z2rl/rcVZvB
	7+QwSXBryG3M9n7l1Ty0IP1iSywpYWkl6P4DhRwBxJ/B9YWG4eFcyWGSCFr2d68A
	oagOUGG1eygWiZpF888vhJLCdOGpIQJec8HkPuMJ3dCsqCdkqBfYL8elrHcyO7TG
	vQ/trQhYGTW5atHJg7lA18g5RJbP8U2oFKePQ3Ydn/LQUJC7jY2/V7/NLZoRNAPl
	X1T8T1t3hsjpz7lh4ilvVbSqBeTvk5QdQ76mURFEwyE7KM4ugrWL7yb1V6tr18wx
	zerMngvE/OK4d0l0eyK+aJ68N472VyuycDrP8PfNnvReDnqBaXtQEzcuNHg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5npr8005-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 09:49:23 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-91931144870so185733385a.1
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 02:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782985761; x=1783590561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kO8Qq8EkKg4I3n0FHg5nZBCqnV7KSsBDcuJqZZjWTPA=;
        b=OqaZ13T1l8HpoKi2I89XwEh3ffOkANZ3DPHkDymWUccDblaWEo7j/bAvFyEhmFLQoc
         T4+EieS3VMYjVKVwsvvRVEjH50iECtRjFS7nn/4HQ0JrwhM5Ql/0YGwvUdHIMWhuRLCj
         W62yCHKmpZXxKFdOvkmgv+HRxG+KFIcQHHhqhW8x7k5mZATJVxusyYWbp4o1wvDv3ust
         HP6bqnuhZJ1taLVBAvU9zz62wiL4qihmSR5FSVHPmJMpFHXPchd+dsWlDEIQnX7mCFmR
         HEfKFNLwo4qdIcOmYLXeYxs/aIa4M0hm5X8XNT/aw4MPChAEAmSeF2hJpEGyQEY107+1
         AB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985761; x=1783590561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kO8Qq8EkKg4I3n0FHg5nZBCqnV7KSsBDcuJqZZjWTPA=;
        b=Pgx0wzrjPl1AhyDHy7557fkbsc+qlwVrG8GlNXt3b3kx3eUEGKrUktOZTJWiVq6JV/
         8mtOdsLdYmN1dr+xHFv8rqlUMv2QJwyERRYFV+zYBFRNxMkEZuhPb9O4TfulbAGg6CZC
         VVzwWyFPHdOtarBw9volQEWgXMJUdg+bGbyTBWugrCnMKbbOCHOcjxapuFIy5HxW0o6d
         UhqsLyvl4P4xbyMzQ/bRvKPJs1nqR1mT8RKsZUvWqF4JN/zY5TS7A/pzR+9CSmzeTySD
         d0UZLPM3S4SLNNjBWoVr9+xcMoSu92O1jpTpcJfcoc/k3mpNJXyvLsHeYzPUyf/KUEJF
         9ZoA==
X-Forwarded-Encrypted: i=1; AFNElJ9N7vBoOpUvnRjx/dUq/yLrV5943/+FhkVRTg2WE0j0VROKy4ZqpzFBrZq7s4mq4DGDpOFFhqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCX+8WwbueABJ3u6kiczoQNhJVf1Dv9CQIat9e28R7T8wFPrkx
	Ffa2hry+FKgeRg4t2nnhZLonG5aSjabslwGUC8+tl1bLQTJkyzuP8RtjQ3JcPQrMJvgc1o6Illn
	iW4+yQuFosinLfi4HFDsaH9Ojsv+FrinLNvrtA6gKLkPrumo1UitTiSVR7jU=
X-Gm-Gg: AfdE7cnAnms1BT2FiAmRJLCzPdNRFTZ89FRk3eaf6kS+BFOVjD9DpTQ4qnpOWrMiCB0
	h3YAF8eKcvolFSD/MOh91wLw73hWYImGY3k2qyDHFUed4YdIQMdwBEZUI42nNhx1GahzkhO9uej
	vWAWD881beu75qYz09Mz3Qy2Re1u68zWF6wnEBLiVbn+tPPGTWh4j4QnbJ4e0eBXUsEfRWnK/H6
	Drb/T4P3OXmGSpiRHw/S0vrL1goRBPv/AS5z82erKjrDE3Cx4L1FcMCGX+HFTBbN1vny86iJZLN
	cjtBOsU3HDu6MoMMOC1Jtw7aFhUbBaJkcvvjPCSNP/h3Fkpx+9b/YLZpOl84EUA4tCVuz30baZB
	lRhbXhnbuEJyDjNHdZCYyexgdNR4=
X-Received: by 2002:a05:620a:6013:b0:92b:1233:99e with SMTP id af79cd13be357-92e784d1404mr717900985a.35.1782985761160;
        Thu, 02 Jul 2026 02:49:21 -0700 (PDT)
X-Received: by 2002:a05:620a:6013:b0:92b:1233:99e with SMTP id af79cd13be357-92e784d1404mr717898085a.35.1782985760693;
        Thu, 02 Jul 2026 02:49:20 -0700 (PDT)
Received: from quoll ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c631557dsm35070955e9.0.2026.07.02.02.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 02:49:19 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Luo Jie <jie.luo@oss.qualcomm.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH net-next 2/2] net: ethernet: qualcomm: Constify "queue_map" in ppe_ring_queue_map_set()
Date: Thu,  2 Jul 2026 11:49:10 +0200
Message-ID: <20260702094908.79859-4-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702094908.79859-3-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260702094908.79859-3-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1739; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=Iwv0pgz/gHsFS74/QZLp4LCreAVIrDJzQUkQ70bSTjo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqRjQVCFUA3UA87Wp9ZLVVMDGLqxydptRjwu+j1
 f9v/183T7CJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCakY0FQAKCRDBN2bmhouD
 1/GLD/95Uoou8ivEBj1hXZbFWkp/Ea+tDy//L4CO+5XaJVWWXWR1Ljt0Qe8v7Zr80M/pcw1C957
 SxZVh/At5NSxpj2h4lTTE3t00sCzg0FmpRlXBBUrdHWQrrB5YOhU8KM92SbMUChOhb3ycasGeUt
 xqOxcYWWR9BSrYDncXozCj7xx3coCqtNuK7KJCgS9EWVKoEemGrEre3un8Soc8CAcYgl95LavBI
 ok9SSbO5qLZagpR9Gi99MMXSQ1oOUNm/a0Guu2Uc6RLVUCl7EYH/wVYBzCrtcDWen9fDEfyJOdJ
 axOMr0u7BmpuaLV/BzYqL5yWmn40sEcv/VHvVPB3B5yXJ4P3YD8cDRnWPdg5s0TO5I35gIgUgF3
 EyWCDPYzgK9SVMMWIaaUU+GM6xZzQYZKI5VmzSGxSgq2eGeC9/sFtXLJKKg0Y5qOvT5K/21uEm6
 +afkUs9T8ScA4a7r3GD8irwFUO0fNReluDYeoG6FtEEnnPyGGpn5e5NYVcTCIdSCzDVAyQRjXuY
 U2kWa+E0en4YsYv3vbSxeusQ+ak8pp+u48urkhLRo342Pt1TmYeiASPgPk7s+U4yW7/psl0VJ7N
 GyhDtN8Vht6Y6IvcThBBRLTmiFPl+1b6uePXCOnLz96rpFbg4hSfMQPG4OgFT0Jl/5VVuADs85m H6z1A9Flms65ukQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rTPBeSccfzdHa4KwBMWqWo4-aU8whECQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfX3np3WNGH8YOC
 VEdMkjfl1bm7pYkg3uGwD5NPjVAXcSTD3fE3YPK6EgzWjMmFwmKuazqI6STAL9QHlNEcIqH37BO
 /0uHQVqC65QxWDFAQEIeBWzqkHlTFbE=
X-Authority-Analysis: v=2.4 cv=NsvhtcdJ c=1 sm=1 tr=0 ts=6a463423 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=F6-nNH4H0A5tK8XurqgA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: rTPBeSccfzdHa4KwBMWqWo4-aU8whECQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfX2wfShJ5A5OZz
 ShKJ3+CMk6iGXvLzJs2CH7m1gZa4APp0/w3MduW7C3d4booEa8Sc0C/tRtDJhxu9r4yWbrYSvx8
 ABwWkWhvsRPt5rvWZv09C+QIy5s7TlnX018unIkQbBFCpDL+aKguEODaviCQVvqLUAtxgslnSf+
 x+SCokXaxXvc//MW8MV6mnmwRpMaAOJyO6xEGuyufvVC6aVkcs1tqW8kgTdFkxQJdC7YM2MflV/
 rcJj1hl4Cj71mVVR4ludg4H6aDYQbqxVEWYZ635/Z4OuY9FNmHpEBhysgz71cUVRoySiKznqhdZ
 fYgW4RNIlnxnxhz4ELigKqiyif4bdMH4xSf2q0N48Ml68JdhBkh28Nu0Q6IQeQfJvfQ0pHqnop3
 AeoewJQNtWeaqcad8bpG0J0aJXLQOMmfMgaj8qXntnySkisjZupTr9xzyT29lPP6VWex/dlnmum
 ZgL14xMbCl/Uu+Tld7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020101
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[krzysztof.kozlowski@oss.qualcomm.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-304084-lists,netdev=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[qualcomm.com:server fail,vger.kernel.org:server fail,oss.qualcomm.com:server fail,sea.lore.kernel.org:server fail];
	FORGED_RECIPIENTS(0.00)[m:jie.luo@oss.qualcomm.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:krzysztof.kozlowski@oss.qualcomm.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7268C6F5A85

"queue_map" is a pointer to "u32" and is not modified by the
ppe_ring_queue_map_set() function, thus can be made a pointer to const to
indicate that function is treating the pointed value read-only.  This in
general makes the code easier to follow and a bit safer.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/net/ethernet/qualcomm/ppe/ppe_config.c | 3 ++-
 drivers/net/ethernet/qualcomm/ppe/ppe_config.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
index 94f69c077949..125b73be92b1 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
@@ -1367,7 +1367,8 @@ int ppe_rss_hash_config_set(struct ppe_device *ppe_dev, int mode,
  *
  * Return: 0 on success, negative error code on failure.
  */
-int ppe_ring_queue_map_set(struct ppe_device *ppe_dev, int ring_id, u32 *queue_map)
+int ppe_ring_queue_map_set(struct ppe_device *ppe_dev, int ring_id,
+			   const u32 *queue_map)
 {
 	u32 reg, queue_bitmap_val[PPE_RING_TO_QUEUE_BITMAP_WORD_CNT];
 
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_config.h b/drivers/net/ethernet/qualcomm/ppe/ppe_config.h
index 4bb45ca40144..60493e51e0a4 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_config.h
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_config.h
@@ -313,5 +313,5 @@ int ppe_rss_hash_config_set(struct ppe_device *ppe_dev, int mode,
 			    struct ppe_rss_hash_cfg hash_cfg);
 int ppe_ring_queue_map_set(struct ppe_device *ppe_dev,
 			   int ring_id,
-			   u32 *queue_map);
+			   const u32 *queue_map);
 #endif
-- 
2.53.0


