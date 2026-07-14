Return-Path: <netdev+bounces-307355-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xSv3GFnKVWoytQAAu9opvQ
	(envelope-from <netdev+bounces-307355-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 07:34:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D31267512B0
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 07:34:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="OdTDPyS/";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Bts2Altn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307355-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307355-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B085B305128A
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 05:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E0C33DED1;
	Tue, 14 Jul 2026 05:34:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38D533D506
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 05:34:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784007245; cv=none; b=lZ5OA5xPtoQh52NGS3xfGviaWSiuzjeVuK69IZyF3oJ+9Jc6laFMGuOs9yPNBj1DJM7lBTdvegWI+BoppyOKDwgLF+ySdTQjYLAeU2E2UWAwBHpToBw705OSvvWFDIiWA1MRXxOX8SH7qoZp+Ht2Wr819fyi1zTaTLMuWP06J1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784007245; c=relaxed/simple;
	bh=5dbkXu45HFOosDTiM2+ssNvYenj08n9zSxrcchmpq8M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BICa5BZk8huaGnRQFDCwYJ7OJIhaDpmy1Vl/zYnkTrP1Yh/Z7V1t1NZ09WVewkOP7DseyEOz1yPMbDcUu6g10wyBRiDYGDG+tdI1inUZTazrTjgi/6s2i15/W9+GUA3fnoBcg5LJ0Ty8+fhSvUkVhIiq3XT4f59gtlYVGhwUb0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OdTDPyS/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bts2Altn; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E38UvF3499149
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 05:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ZmX0wPL5IDlQiB7+koGxyF
	G+YiOFbTzb7mQPIUkyql4=; b=OdTDPyS/NRLLsjxXIKx8tSAL4CoLO1rzH9bxNB
	wh5MjUH1UXL+S9j15t1bJenTdvmlRiXsMhe1+yM3Conbw77Zcq5OiId5z/IDksby
	/wyQA2n6WqXAqiCpkstjsJsdJ4gOU5HGv8CQqILiOCgmJfEiACkqwevw8qC2MGEl
	BSoGcw3GjSnhDzdRT7XXKJ7806Tc+SnKdeCh63zi5AQKZRttFGfQVkpE8XvZk7g7
	bQPmUjtGZ0COSqc4kJRiZWRjQYG3jHOVKC9LBHvCfuyj8km8xmxbTzbPb/j/qOnd
	E7IcgioRy7qGEPy0lASkh3glY/lophhRnXXqnbW5gxibbWKQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwda402p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 05:34:02 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84865f326efso4382579b3a.0
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 22:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784007242; x=1784612042; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZmX0wPL5IDlQiB7+koGxyFG+YiOFbTzb7mQPIUkyql4=;
        b=Bts2AltnfOgA9IaAjuJ/SPhSPb2cuRGV7dRUkgIxOJd5Nt4p1qjWic2VEWL06sel0P
         g3vxel29W6q6df4Q7ay8/I3lciu0OztxjwGkqKTpsgH84cb0GjMXKtTIQFJXgin1Zhct
         UILhINS4HiMMlX5LqEVUgU/W1H3Ohbn5UDprYRq7gDuXcdkSPaF+6Qoc7SsuDe4u21fn
         AdTNohYYSwfcEvMdHncUwQTC/VlwjoSN0ox2SH9CsT7OlEPlycNHkAiUbNTJm6sriyh6
         mk0rBrK6xbrx+MVNkRKchMCuQfaEVXNr3boVxoNT821xCqI5NtNWb5Jo8QlcV5UQsl4P
         z5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784007242; x=1784612042;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZmX0wPL5IDlQiB7+koGxyFG+YiOFbTzb7mQPIUkyql4=;
        b=cxJnM+ESst9ednzAmF3k6zN0EXygpKT+LRxrFFOpIa6/hNqQW5JBzHo/15hh2JpB77
         nfjyf1JwCDSNG9C9j8IMBbv9NVwXmTnTST3rcoQC9xBPzq0G5CNQXspEr3zCSpO1+rAN
         GFRZNncysp1EG/Xv4hEgABl18vWGDBWEsOc7ALGz/fFyoESc4/0z8dYyUfomaLPJ6q9W
         5V9p5D1c6P9foFM08lCTiCfM2BG2BOoIonbFLvnQ5tWgWhfrFyjLmNwxwixAtjNB6ilW
         nJR6JT0x0rUC8lQKXPBnK7q3opVIOAi4C/eXgiFPNx4ol1+E8Prm5IQ7bi8ktoZUTLSi
         Z4Gg==
X-Forwarded-Encrypted: i=1; AHgh+Ror4SjVD1UiYp9a9pJqHCRGlAxBNPlwV3jbKqQRA0NYxGYfdBUYb/7OktOEwdcUTzceIeldALs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO7zkkWVZW7me1TusAON3CFC9X7TaOgIWdyzmojsB0ft7xF2pI
	7+ppK7km+XeGOvbL6mExxtvbo5F7D1B/7VViWN+cTz1vGQu2jUrD61G4MjjmYbPNS9OyGiL9SjV
	bBVnldDB5xP3jlyNwAc+yO9XLQDT0FPLq1y8iqoT09NcBjjf14zoCA/k80nU=
X-Gm-Gg: AfdE7cmiXjFsBnvVkZWt5DsPbYoNKzVvuAsdz596yeJXKxd03NfCes+5rRE88ZhHZTm
	OmzKKhPWbA2ON3klbvgjRSsoFfGtEwfbWdCilCYoKRCpwH+vsu1Q6nNikV9LCmngdOf1HthaBVn
	BMw3qL6SK+pchsJwg11m8rhzB+j3ue6rdA9BL9Cz9JKqQHjWYFbUscarEDHm6QoP21Qallcbd8z
	bwU+gXTMNbhogPjoEEnp9WVWmCeTKbDMI8bPmlVMt0AOf00hgeFAItjmCaacqYzeJEZvUzHg5jR
	YJcTVpRE9jp2srs9H9lCsGlYAeX7jFg3VFlkUl52Y6ITjZOXpS821+PuG34xrmDrfvNnOOKUJhj
	U807V8YW09pz4QXBxDIJ6elt3K07u87GRulxxE52bKX4E6Q0=
X-Received: by 2002:a05:6a00:1ca3:b0:845:d286:1fbe with SMTP id d2e1a72fcca58-848897aa414mr9625267b3a.60.1784007241583;
        Mon, 13 Jul 2026 22:34:01 -0700 (PDT)
X-Received: by 2002:a05:6a00:1ca3:b0:845:d286:1fbe with SMTP id d2e1a72fcca58-848897aa414mr9625243b3a.60.1784007241156;
        Mon, 13 Jul 2026 22:34:01 -0700 (PDT)
Received: from hu-vishsant-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f6bebcesm846227b3a.32.2026.07.13.22.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 22:34:00 -0700 (PDT)
From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Subject: [PATCH 0/2] net: wwan: qcom_bam_dmux: Alloc RX buffers as a single
 coherent block
Date: Tue, 14 Jul 2026 11:02:30 +0530
Message-Id: <20260714-qcom-bam-dmux-vmid-ext-v1-0-3f29da7cca76@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO7JVWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc0MT3cLk/FzdpMRc3ZTc0grdstzMFN3UihLdFEsjC8uUJGNDg2RDJaD
 mgqLUtMwKsMHRsbW1ABRA82loAAAA
X-Change-ID: 20260714-qcom-bam-dmux-vmid-ext-d9289db310c1
To: Stephan Gerhold <stephan@gerhold.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
        chris.lew@oss.qualcomm.com,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784007235; l=1539;
 i=vishnu.santhosh@oss.qualcomm.com; s=20251203; h=from:subject:message-id;
 bh=5dbkXu45HFOosDTiM2+ssNvYenj08n9zSxrcchmpq8M=;
 b=RhV4Zoi98yplbi+t1A2tNsWzjPpf7bfkl3oqD8x2pcfeF87vrmtyI7bliNxAwO12o9ap8GCZd
 n91wu0dpSt9Cj3acCZjnjnJTdsjF1SJ2iMgj7SVLu0+/DJeb3meFh6P
X-Developer-Key: i=vishnu.santhosh@oss.qualcomm.com; a=ed25519;
 pk=G8/AJPecB1feGI7wxArGWGN0PPGQS0GUaD4THQCbdis=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA1NSBTYWx0ZWRfX5+nDbOEuek/N
 J4FoI1wwecMsQHPFJLQoN0St7wuA9crIcMDeJaQxKgs/cOFwC70tjZixmwyP907mB0uX6kWtIS5
 cojYz5cyvoaZhOOXFdTYHW9SPdS5MpA=
X-Authority-Analysis: v=2.4 cv=cNbQdFeN c=1 sm=1 tr=0 ts=6a55ca4a cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=ByYuNnzN2TCMuokQ2IwA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: KeBbu-0khz07jhejSWc4SaZLKP-mbKvq
X-Proofpoint-ORIG-GUID: KeBbu-0khz07jhejSWc4SaZLKP-mbKvq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA1NSBTYWx0ZWRfX0oADbIJzsR9r
 rp5RFBOjs5U8jI+us648C0/kRVt98m7uPBsifpCz7EqYwEzQ9S86m1G2BOIPcfBJZS19kdGEGL8
 Z4/EvshupsVFMQa5k6LDOb+yJe+OqzAL97PjdJGxQbSdZKOHRrpLlnjMfiZX+IkqgCYxWm8z3op
 tVv1IdYOohGKxOmDisPfjJ+T9OX7gi5BMy0qQpE/jSd65OjZcxgwTVgIwaek+0mzizMaFK0qtKR
 GVCQqInsfHLjgici25THv8TXBlNTRZW7keVjVDnNXdH4rg6h2QJR2BSUZ0nlJKGSznrIgrFVpSY
 QdOYY8T/60u00ouy2LWMnyJ1nLHta2rYkYfZyE7MOY2DH5hkXBgzUxMm4kFcduauToqkHAyiuha
 8D3NW31yhB064vO9cRaVMsTCLoV9ydRTIBuDfXSC52wGY6/9hfJ0xpJNsRRAw875XnKKH+rmWhe
 ZF12wI7MAI3NR82T/Hw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0
 phishscore=0 clxscore=1011 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140055
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-307355-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gerhold.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,oss.qualcomm.com,gmail.com,sipsolutions.net];
	FORGED_RECIPIENTS(0.00)[m:stephan@gerhold.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:linux-arm-msm@vger.kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vishnu.santhosh@oss.qualcomm.com,m:chris.lew@oss.qualcomm.com,m:deepak.singh@oss.qualcomm.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:ryazanovsa@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[vishnu.santhosh@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishnu.santhosh@oss.qualcomm.com,netdev@vger.kernel.org];
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
X-Rspamd-Queue-Id: D31267512B0

On platforms where the modem DMAs into the BAM-DMUX RX data buffers and
the XPU (eXternal Protection Unit) enforces per-region access control,
each individually DMA-mapped RX buffer consumes an XPU resource group.
With only ~16 groups available on Shikra (mDSP, VMID 43 / NAV), the
per-buffer mappings exhaust the table and inbound transfers fault.

This series adds a qcom,shikra-bam-dmux compatible and have the driver
select QCOM_SCM_VMID_NAV internally via that compatible's match data.
When matched, the driver allocates all RX buffers as a single
contiguous coherent block and SCM-assigns it to HLOS plus the VMID
once at probe, consuming one XPU resource group instead of many.

Platforms that do not use the qcom,shikra-bam-dmux compatible are
unaffected: the existing per-buffer dma_map_single() path is
unchanged.

Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
---
Vishnu Santhosh (2):
      dt-bindings: net: qcom,bam-dmux: Add qcom,shikra-bam-dmux compatible
      net: wwan: qcom_bam_dmux: Alloc RX buffers as a single coherent block

 .../devicetree/bindings/net/qcom,bam-dmux.yaml     |   8 +-
 drivers/net/wwan/Kconfig                           |   1 +
 drivers/net/wwan/qcom_bam_dmux.c                   | 134 +++++++++++++++++++--
 3 files changed, 132 insertions(+), 11 deletions(-)
---
base-commit: 3b029c035b34bbc693405ddf759f0e9b920c27f1
change-id: 20260714-qcom-bam-dmux-vmid-ext-d9289db310c1

Best regards,
-- 
Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>


