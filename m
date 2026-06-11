Return-Path: <netdev+bounces-298284-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u7euMrAAK2pA1AMAu9opvQ
	(envelope-from <netdev+bounces-298284-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:38:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6F567480C
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:38:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Y7RcbeXr;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=eJXIMIyL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298284-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298284-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0909B3267C0F
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744A04968F5;
	Thu, 11 Jun 2026 18:37:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BF7409100
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 18:37:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781203045; cv=none; b=TkN6kJGMMXFihe1iYawOT9qvcaof9kXskRTg484IKYbTnUBP9Ek6JUuPEQOkrR7ALrPnTS9TFjqwg7OBQ+hpYCFyaCqIzOUP8avfnXgRUageLnnYS09KeA8PbhHK0+Oiiw6dX5HRNo5pbGNQo7VhS/t2N6gdw2C1wYvPQ0n/V6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781203045; c=relaxed/simple;
	bh=5T444QwrYmsTwO3v1gCqDgxdhU4Jck3L9IB07WNXPS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iLg8OmeBqpMS0W6UpDai17bXxwwaBnGCah+kqgsuQ/jQJzgZ6yreumxnWLmIMngPq2r5RoVzdhy/0q3lDQdCQ/LQ9aGZOkGvcXRsBrRvMdtJcvYvVVh/N7Y4TjBZZo08k03eKK/Fn9vQQtD5w3p5G8wAFfWRcHhDlFtDaMrV8Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y7RcbeXr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eJXIMIyL; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BIS6Kw1449518
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 18:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AyxmGXU7tCETamEQ37pkjmBcE0pG+FwQBF/uCJxPNaQ=; b=Y7RcbeXrUvc6Z1/b
	nZ4FOXt/Ipi+MICJydJ5E7HgxkF/zc0pd36ESrMyQty/5HKx8rB8q90epNh9ZSTY
	s4IRDgyOn/teB7YqIPL/M//AxaBn7tfmitVTFt6o6wx11Ppq6KMvwa50tc7kdHEA
	PzCzNUlz5hvFg9OUNq7uk53/2GlIPXUNIhRdO8s2JhsN1z//Uz74bi+bIVgxfdPC
	kYqX2AtCmhkc4mPU+zdTDmf5Zq+Pmm+ahs2XZP2NMgzf/uCGh1BD9NIF66np6GWJ
	nrqB6KGLHPt54PAJGeLQidsD+ixDwDVOv+DQqKs97+feaM0mBX9DW6MEOrNOjfL6
	YT82+w==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er29ur1mg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 18:37:22 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c8584e3fc96so61342a12.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 11:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781203041; x=1781807841; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AyxmGXU7tCETamEQ37pkjmBcE0pG+FwQBF/uCJxPNaQ=;
        b=eJXIMIyLiZGVDS+i2IvKh8DWWRg27/1m4j0vJmuv5+ppQBRQCytpZwdARK35U9l3ut
         DP8uPUYjcJxeX36FbRImrc9329QsTyZ3SkocLrO6oLZGKo3qu0R5K8hKURznwj9hJ9WE
         v6fC9iGY7rH/J0EpJz6eM5Xi5ACbevZgUqV8FvmCRN+t0mjoavvVck9bztEJCkUMNXZZ
         qJpBtfqBLNSoyahrL7voX1c4h2wb99jOiCaFyQ/0gR3uvIodawFsYXtNRyWSd44UWnko
         Q/xY4bzVENjVhBcuTFvjq6dDAky04AqQtZyPFzqIZw9UKGKr1ukmKPJK4/H76n3aXnGa
         /iag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781203041; x=1781807841;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AyxmGXU7tCETamEQ37pkjmBcE0pG+FwQBF/uCJxPNaQ=;
        b=XMD01ZLFtJb8VLtEU764xzyqB9Y24eM+Fnl8dR6cbgxa7OBUxzC8KRQM2ddmOm0r3b
         h9/PFFCbtgnIeGxvYQ1kw9lKag/cUKlLgObjIDACjSj/pm7kj50IFz3J6G8xWOzPbAcE
         kyp2RzRBLZqfbY7UU17CtVF2QXU+Y1eauYNO+DAMaRhCzZ4J72KImKtVOHGvwPoqm9tX
         i/GGdYFfvHJzGlF9ljlNF8CCjzxMhixU5+AMurgeA6oAo3UnHq9nrjOfdJTB9zwh3AjL
         2RelWRfedT9FrzBurNjigyz2fqmdB243glHNeu15tz8FOAGhx6ZzqZPW89H+ZIZ/rpNR
         P+ZA==
X-Forwarded-Encrypted: i=1; AFNElJ/eNBCrNMBt0IENhXveBwCD84IhInx1g9Q1Vl32ADHc6PvFdzWt0f2ZiOGxUQ0OybxTg3DeynI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqQzApJbdpIbIUmta6KJfJI8drDterX3q4J94TgC6mZEbLwCd5
	bxGI9GEQhysDvcRBCY+263a6Bhxdq95O1IDV7NzzwqtVXgRw9FL44g+v85CwpwWs+pHkLSnkxSl
	0F0sKeoOCxooByvErgIxyioS+tS1aFl1VqOC8pR2C8ZYu3FfyydI3QpWvl6k=
X-Gm-Gg: Acq92OHKQVdG6UAiD+xxe2INoBJcXmlbpLhR0E96IUaKpDRFqvd4P5/6cJUjoCK3XhA
	bg8YUaM6I2b2hK7224c7H8nxhkbZsA1zvZrvyRC/2S8yg3mTdFvwMH+SEbPMiV2Kmrqm1x7y2h+
	mb2ANnH2mJFKkEn3KjoS9WiyMeOFHNyxw4v6xxmha3KuDgPFvScvdjlirg70KI23ZZNUBszPCn3
	sepvA4jpQ/KvFreE966171I74jj7iUUkKi3pZqFyKkmfkBC0G21YIAddJF4W2Gq8NQbtvHWE2DU
	uF+C/xkqekaCgdHNPnq7h2/RSRYBgB2HBM2bYj6a31dm+39pEqZ/tXsWjnvcutTJO9VLfrRhVFQ
	3Sa4fMoWzVINiXqxwajvpmPtLqcf77dSO0JM57a7DsSzOzWLahuU=
X-Received: by 2002:a05:6a00:414d:b0:842:732c:568b with SMTP id d2e1a72fcca58-84336bc69f3mr4345817b3a.22.1781203040949;
        Thu, 11 Jun 2026 11:37:20 -0700 (PDT)
X-Received: by 2002:a05:6a00:414d:b0:842:732c:568b with SMTP id d2e1a72fcca58-84336bc69f3mr4345780b3a.22.1781203040445;
        Thu, 11 Jun 2026 11:37:20 -0700 (PDT)
Received: from hu-mohdayaa-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84337bbbfacsm2555666b3a.20.2026.06.11.11.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 11:37:20 -0700 (PDT)
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 00:06:57 +0530
Subject: [PATCH RFC 1/9] dt-bindings: net: qcom,ethqos: add
 qcom,shikra-ethqos compatible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-shikra_ethernet-v1-1-f0f4a1d19929@oss.qualcomm.com>
References: <20260612-shikra_ethernet-v1-0-f0f4a1d19929@oss.qualcomm.com>
In-Reply-To: <20260612-shikra_ethernet-v1-0-f0f4a1d19929@oss.qualcomm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781203027; l=2195;
 i=mohd.anwar@oss.qualcomm.com; s=20250907; h=from:subject:message-id;
 bh=5T444QwrYmsTwO3v1gCqDgxdhU4Jck3L9IB07WNXPS8=;
 b=Y8TuyI8PC+fi6lUIQ3mPFu/M5131hg3c7XDWYgoxoDB1Fd/WfaGv9PKijnwpIL8ceTzv9YHRr
 3aHjmo3PKU6CzJz8jJBD+WK6JDJtkQlULNu5b5xAVGiJM0RbhvweZN9
X-Developer-Key: i=mohd.anwar@oss.qualcomm.com; a=ed25519;
 pk=7JNY72mz7r6hQstsamPYlUbLhQ5+W64pY4LgfSh9DJU=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE4NSBTYWx0ZWRfXyJN5GECdypi9
 4gJiNe+0MFJW05sRqvRrEsP/OnPdjbvlAKpyDrdDqr/pGSeNDZmdoXw3hbWbg2lxoztOTZTxW3w
 qeTv13OMonF8RG3rz9hrSKjYlyRztFE=
X-Proofpoint-GUID: b0721GhiZn5QxknbNocQNKyMR_4-DN7C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE4NSBTYWx0ZWRfX9vDpu/0t0R09
 kc7Bq6Mm48wAmCAEmHLptTVZwfTBb4E3ZLPL4YHl40sbmaySXAMhxE15ChYCOiBSXIq8t56qmMT
 YthoQ2p6mTBGVIjNHCm3l8cwAHMX1XapmUFRHbZ/StQXzIY7KDT8Ubvg5Yz55Xh/qGovJyVW5Wz
 af1VXwgjSAzTYsJ2/YJQ/hfS7XLMo94965Zzc2GDfLH0aVOd6auGQd2o7VhfPGTTcd6Pp50Q4Ns
 9YQIrO5Wzw7BYygpXZUurFplpeA+EcZ8CweuPCHqZaRcq5ObpIm++2MxZJdf05Ygb0CjF7F0OkC
 asFek0SVNUOvPrxPuH7tdDTf2GMOK5pLxalYv1ahNdzBg6T5P9A+YVJzb+5Po/PZKZEVMBmOWPI
 WuqrCGMYpQ1Gt9JBVtiKXbagcJ93gConfVSOvsAn0YG1KFHqdQbszNQ0fdhqoXsubJpllxpThnF
 lMCKgeG5lRFnHCmVtfg==
X-Authority-Analysis: v=2.4 cv=DppmPm/+ c=1 sm=1 tr=0 ts=6a2b0062 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=w-NwtAtCphaO0WLdcGwA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: b0721GhiZn5QxknbNocQNKyMR_4-DN7C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_04,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110185
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298284-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:richardcochran@gmail.com,m:andersson@kernel.org,m:konradybcio@kernel.org,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:linux@armlinux.org.uk,m:linux-arm-msm@vger.kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:mohd.anwar@oss.qualcomm.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
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
X-Rspamd-Queue-Id: 6E6F567480C

Shikra's EMAC requires three additional clocks beyond the standard four
(axi, axi-noc, pcie-tile-axi-noc) for NOC interconnect voting.  Add the
compatible string and extend clock-names with a oneOf variant for this
seven-clock configuration.

The AXI clock appears twice (as "stmmaceth" and "axi") because the
stmmac core and the driver's NOC bulk-clock array each consume one
reference; CCF refcounting makes this safe.

Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
---
 .../devicetree/bindings/net/qcom,ethqos.yaml       | 31 ++++++++++++++++------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/qcom,ethqos.yaml b/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
index 423959cb928d945aa3e758a3c803d12bd61ec42b..4528946856c8c6e33bc6ad4159ed111f35ec37d9 100644
--- a/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
@@ -32,6 +32,7 @@ properties:
           - qcom,qcs404-ethqos
           - qcom,sa8775p-ethqos
           - qcom,sc8280xp-ethqos
+          - qcom,shikra-ethqos
           - qcom,sm8150-ethqos
 
   reg:
@@ -57,16 +58,30 @@ properties:
       - const: sfty
 
   clocks:
-    maxItems: 4
+    minItems: 4
+    maxItems: 7
 
   clock-names:
-    items:
-      - const: stmmaceth
-      - const: pclk
-      - const: ptp_ref
-      - enum:
-          - rgmii
-          - phyaux
+    oneOf:
+      - items:
+          - const: stmmaceth
+          - const: pclk
+          - const: ptp_ref
+          - enum:
+              - rgmii
+              - phyaux
+      - description: |
+          Extended clock list for platforms with AXI NOC clocks that require
+          explicit driver management (e.g. Shikra). GCC_EMAC0_AXI_CLK appears
+          as both "stmmaceth" and "axi"; CCF refcounting makes this safe.
+        items:
+          - const: stmmaceth
+          - const: pclk
+          - const: ptp_ref
+          - const: rgmii
+          - const: axi
+          - const: axi-noc
+          - const: pcie-tile-axi-noc
 
   iommus:
     maxItems: 1

-- 
2.34.1


