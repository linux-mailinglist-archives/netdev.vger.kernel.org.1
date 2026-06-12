Return-Path: <netdev+bounces-298661-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +0dTLUYILGr+JwQAu9opvQ
	(envelope-from <netdev+bounces-298661-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 15:23:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF87679BFF
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 15:23:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Ih25a15f;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=D+y7On5S;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298661-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298661-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6923431E14B1
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 13:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086F13F1AD3;
	Fri, 12 Jun 2026 13:21:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DBD3EEAF2
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 13:21:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270465; cv=none; b=Tn6Mv9olb5VDgCvwFzpHrPGI6tiTNhsavNKVDPYxQQH3i5TF6j5Y5ETS6qbOwXaVghd0/EHqTqFj3VSuWie9zIMj57t5OYpjaNi62/82XGkBi0LWdYdNZItU2TJFb3srTSbsLZU5Es/Qg41WXTTYnSSZtwIHr1ToB0q2mYTkYY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270465; c=relaxed/simple;
	bh=ND8QCWihnx/5SzmAjMX21FeKkkTEai7fgVEY9yu2Gdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XkFr8+Wp4x67F/UalYoKnwLoI8rDxSA7HH1pG7M6ThtJVEGJKpV7h/nALWQqEtkZpUl0gjBrZTmX9X9cS6utEYmt9jF5BzcfPj0knafqWf08NJuBT+mk1nhuV/cwnXpcmOZnHdrsgBS0jbc1u0S4/yqUpY5bWF3m0Ta1+GvRTPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ih25a15f; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D+y7On5S; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CCim1Q3692484
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 13:21:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	leied0AaOznatkz/yNwlsN4mHUViLaKycB742NpUAE8=; b=Ih25a15f7iXbpzty
	m5yjqdwpdGC0IJlGeKlWrAQFy2yLuxPcCWLUN8imPBgtPjAN2FeWU+7FvlYmF7Aw
	WDhZ/Fh5xxkRuZ2G47GesuXjMjrqPzEO5eLNJlUJ+6d4EQRonYXjTUutDr23Ilkx
	knHZSte48LpRQMBNP8oukwa0eyryq3WWcYPVFsJwTXnnLFOljrMZ/kLSuSDH7Jfy
	Ap3/z4CFWrtBu6m+1szEDiF81RrHgu8D+65N+qeR9NQ3LtBmF0876KMYSU9+7elW
	ET9ZNqVwygbI9ivhL5dBV63/0R2CpY6zAWMJcecJ2+Mjwd3wLtxpZN6ZoqtoT+/C
	BpPZ9g==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er2r5txg5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 13:21:02 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-963a95e1250so129965241.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 06:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781270461; x=1781875261; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=leied0AaOznatkz/yNwlsN4mHUViLaKycB742NpUAE8=;
        b=D+y7On5S4Nd3LyiHl3/maoqli1GLJc9ThwAccgTjV/KmliIy3NLBAmI053ixl7qKH/
         2nGKAz1+r48Ry5zKlf/jrqpIo70G8IqvapLgzjM+m38BzVV50QDjAdtX9Shv25AbWfrg
         LerPPdQk88gCezMxOgAk4ULfEh4OLVZzDZE0isjnAmZXQSW9EqKbaMOBN0O+HMY532Gj
         WYLpo3XisfkThqqj55k17mc7q+yqPQWLhwLoWT+FrwplbTn83Vsf21RE5DVEZk5xMch6
         aXLBFVeCRY63wosn2GZ1Ex3mIk+EXTihRgS/TU7VO5l76EKdz0kQU1E2E4SeqYrzrdmz
         5QnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270461; x=1781875261;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=leied0AaOznatkz/yNwlsN4mHUViLaKycB742NpUAE8=;
        b=Jr6EdQ8L0QyF/hBSNaFoOPMO7Lgg9FbWVOXQ66UbDbupJ5aIvrJ4of3PX0J774Er1d
         P3OcmJoNopjSsbpgWsd+FCngs3nwdzseBxFp6ZMb0Vup5B1Fg//umSe1LLJEKTepUmeu
         dTmBB+6epUBGennNnJJrY1kH0TZbhEuWi1U6tGfLzbq/StYO0C1OXdv1E8fXbwe56Gjk
         VVstGACjr+w+mtVYD1RXrOucJcqtDQkjUuZoxlhOM/Wguq40Je5XA9ClarlzJd2p62k/
         VaEEZedR2frR/dONgiRsPhhT9XLBOEXfdCf3Y+d2VQrdGtfIVp3Kl6RBpr/uzphAfN0I
         cTYA==
X-Forwarded-Encrypted: i=1; AFNElJ84FrnzxJAtO2JvRD3/GHI8HiJ4G1vRQfAxi6eh2de9Yu/tW17BP80QqLfSnB+u/Ze3I6Bu70U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvmtf8sTROFv5qhFQ1V7MC4cKLW/wqHZTpWpnLff54dEMBCqz0
	ZcvDitP0jRogJ8gUja88hIwyWQVdWm34ghrt9sQAuEFwfydXjVU4Uh1om5sEE8x3TsUO50cn7BL
	0UTgS0DHnxWCokF0sAeTPiuVsV8NdfEUHY7HGUs5PHQvO0Oaf9XQhDMRDO3k=
X-Gm-Gg: Acq92OGetsHhD1Vc7uNnZmuZZylVh3vSMaEwG5DiBpolsyjdqKoj5RNLus16/L+0cck
	sn2GODZjyJN32XDXVqmWbhOXnyud2GNxqtxWx0ujYUoYTdfZBDlqN0bcoughQrULwNpNZX5tJZW
	usEIcz2ZLUVacZ2h6202b2Newu17nyxcf97EOR2+cQQ9TEz0M6Y1/PKfX2vPHYhKB6zwp1IfQiB
	dcc3INfFj3X86n4LhDbndA4c9DJaFnEDsw9Aj8DfG3XdIe+mfTNZdL7JMRFFAj+j1J+n6FjnGIx
	aRk8SF1+i0ahZszIdxqfo5ormJctbrX0/Wpiyk1VXWpE/+Fv+Az68ffT0sBh4BEbqESLsqsDq28
	V5veIVMNd8+lKPOOdcEwZtNlQ1PNTinHFJvD+vQlbSNEbdLesJLlfxoSU3FveNDEkgfINz5Ssms
	+aa99kz3px9wr1nDsHQYRwzn2EHJL9pYYI5haztO3zQvSV1n/pGJD0LvZ20/7AsqfiEHz74nhP
X-Received: by 2002:a05:6102:2b89:b0:611:61d3:819c with SMTP id ada2fe7eead31-71e88b2a46bmr1202685137.10.1781270461460;
        Fri, 12 Jun 2026 06:21:01 -0700 (PDT)
X-Received: by 2002:a05:6102:2b89:b0:611:61d3:819c with SMTP id ada2fe7eead31-71e88b2a46bmr1202596137.10.1781270460929;
        Fri, 12 Jun 2026 06:21:00 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:3510:32cf:db6:13c6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfe6f9c46f0sm59986866b.1.2026.06.12.06.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:21:00 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 15:20:53 +0200
Subject: [PATCH v5 1/9] block: partitions: of: Skip child nodes without reg
 property
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-block-as-nvmem-v5-1-95e0b30fff90@oss.qualcomm.com>
References: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com>
In-Reply-To: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com>
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
        Saravana Kannan <saravanak@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: 2Abrk3yGrVhscgCKWl9j4UQhh-SiGahl
X-Proofpoint-GUID: 2Abrk3yGrVhscgCKWl9j4UQhh-SiGahl
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfX6jhkPBApaUir
 eDnyjALs7w0vM3/O2DUuCuRSjBcGuSzLzrku70QDgPrdRiQwjARH8IyDSD4S1WlHAwUNCveW9sb
 fTU8lN5v4bDn3gGJf3FKvq1drswcOtQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfXxgenXuRCkwr+
 sNu++r6aWzEuoR1CryJVhpSJZTTNLu2rv0053LqQlBEBqT3satT++koq+dcPVltpLFSQz6zxWD9
 efj6lTgJSNArXribGD4Km0Yl6wyncASxN3rDGmvm0bN84ZjfNmln/BcmESHfoTfKR1RCIhnbYq5
 29L+iBKs5quGsNR0H9sHgKRdl6j6t0R2sXg6XBiK/kXOaQ6bf+xg7lCCefgob5PeHOXapGq2v+0
 7HG+dQJBzGXPObjQoot8aL4Ugo0Nv78gq6IsYlMOp2vtZelxQta5dmvzJ5Rz6PX15rjJVjfVgT0
 yKIFbsyFPv3yyHGN5FBtlXRmxcDu8FQLbAz3iIIMpfD63ojG9VpTjKCZmm8USystQIUSS1ClgL9
 lOLi0T4SLOOk42KpwV1FbkXTQDx8myWP+gmFxurbzWSjD0sgVNLVSj9kpaRfVL5PynJaZ+wUIHv
 C14X2WshT9JvqAMGlzA==
X-Authority-Analysis: v=2.4 cv=M6p97Sws c=1 sm=1 tr=0 ts=6a2c07be cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=e4y8cmn4OwqddjlM7QMA:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120122
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298661-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 5EF87679BFF

Child nodes of a fixed-partitions node are not necessarily partition
entries, for example an nvmem-layout node has no reg property. The
current code passes a NULL reg pointer and uninitialized len to the
length check, which can result in a kernel panic or silent failure to
register any partitions.

Fix validate_of_partition() to return a skip indicator when no reg
property is present. Guard add_of_partition() with a reg property
check for the same reason.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 block/partitions/of.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/block/partitions/of.c b/block/partitions/of.c
index c22b6066109819c71568f73e8db8833d196b1cf6..534e02a9d85f62611d880af9b302d9fd49aa4d46 100644
--- a/block/partitions/of.c
+++ b/block/partitions/of.c
@@ -15,6 +15,10 @@ static int validate_of_partition(struct device_node *np, int slot)
 	int a_cells = of_n_addr_cells(np);
 	int s_cells = of_n_size_cells(np);
 
+	/* Skip nodes without a reg property (e.g. nvmem-layout) */
+	if (!reg)
+		return 1;
+
 	/* Make sure reg len match the expected addr and size cells */
 	if (len / sizeof(*reg) != a_cells + s_cells)
 		return -EINVAL;
@@ -80,14 +84,15 @@ int of_partition(struct parsed_partitions *state)
 	slot = 1;
 	/* Validate parition offset and size */
 	for_each_child_of_node(partitions_np, np) {
-		if (validate_of_partition(np, slot)) {
+		int err = validate_of_partition(np, slot);
+
+		if (err < 0) {
 			of_node_put(np);
 			of_node_put(partitions_np);
-
 			return -1;
 		}
-
-		slot++;
+		if (!err)
+			slot++;
 	}
 
 	slot = 1;
@@ -97,9 +102,10 @@ int of_partition(struct parsed_partitions *state)
 			break;
 		}
 
-		add_of_partition(state, slot, np);
-
-		slot++;
+		if (of_property_present(np, "reg")) {
+			add_of_partition(state, slot, np);
+			slot++;
+		}
 	}
 
 	seq_buf_puts(&state->pp_buf, "\n");

-- 
2.34.1


