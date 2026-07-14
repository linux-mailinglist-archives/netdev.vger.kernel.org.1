Return-Path: <netdev+bounces-307356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LuNHBn7KVWpKtQAAu9opvQ
	(envelope-from <netdev+bounces-307356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 07:34:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A60B7512D0
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 07:34:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=PS0M+lfB;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=HOfD3W+K;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307356-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307356-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1D0C308460A
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 05:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4045B33D6F7;
	Tue, 14 Jul 2026 05:34:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982F133D6EE
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 05:34:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784007251; cv=none; b=WnueeNqyN6b1Gyeub9JnyD92eYcqGyGorT942e5e0U7FrdGgzWVNsO1RWfqQe5CWX2EElYWvhmyiBN/CZe0nLLcxYoX+rW4FhpXTHXV2kcpviO4c0fIfR0eIBKVLHHwQ5V9ozKBNosnrpPHh2NPun5Cs8hgNnaZtCmjrwhMWHuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784007251; c=relaxed/simple;
	bh=7FMZOy98v+vdLFCT3/0VGFUv24YLEv8tA8oNos6MiCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P68aPOQZN5G1wQqEVZI9yCmX52vhZSZMbOznjJTf6pUTlvLjNHYr+U4PgjYb9w7vy+dfFI9vv44yCWypYqE0o04GOLHxwFW8i2pSyXiDhAkg+uTbZMPts/PwXav6zKfyR+PgqLc5ZUnMrGo1cjKGhBUdWGviolkabEJmQdb53rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PS0M+lfB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HOfD3W+K; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E38SH03506834
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 05:34:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zDR26r7yjwJawRn/G8rFuIZ7JcOVUBQDcaIis7n20aY=; b=PS0M+lfBPuD9X94P
	KTGi+SdWEJVddX1j2400skEP2TRzeZtCRa6MW7fl1bEQryWrXv4KgyEj0Vqk/a5s
	Ij3c6pRFHTmBiwd1GiaQjckZFd3FsoJrWWS04UwpiQd4FHyflFK/5ZPZFfzhwUr7
	iqrWHLqu/4KGGccNjrbgsxCWvaticOW0T4no6Z6yBcmZpZlxwaDf3a9XaApZ9D/d
	nxScEczcTKUwTN7lighNH4mZfHFRG52EACTLrlPBxPZQLDl+F0T6JEu4U3MrZRxx
	RACqtKMVy+E3wl5YWERkCWvItPOXnZyccQ/uI9+4llsqczlNGoNCemTGA2Aw6RMW
	sHvYFQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44jt5j8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 05:34:08 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84a3514f912so3427794b3a.3
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 22:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784007247; x=1784612047; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zDR26r7yjwJawRn/G8rFuIZ7JcOVUBQDcaIis7n20aY=;
        b=HOfD3W+KcQ9cTX34Z3Mh42NeQO0Eh7DrdZ4HwoNiA+PKez4XZ5YnsZl33Zbh2n+7Y0
         AWTvJ3WHPDsl352TaZZ6rf1aFpWTJSDAwGcuPFhyaPoc0wiWbSZLOESAFjldAzMlCLlM
         Y4SFReE+48ND8HlTr7CQVL9xbGUeGQbr/AUmTSY5zOM0Rk/gjh2Z/XHjGDjL1h+6Q6oH
         dKw1Mxv+A+wA5zep3GCG7pEoN+nykBLdkx3unfRduEF3yErVe8J9py4WB7QlwE0+NaCh
         r1F7SsL3pkEpZnxvJHJDQP7NIOuuBJSPwtx77OSelGOA355j1IngEILVc4I4T6VM6tKR
         tI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784007247; x=1784612047;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zDR26r7yjwJawRn/G8rFuIZ7JcOVUBQDcaIis7n20aY=;
        b=mdmyRqGF8ail2Y+yXAt1+KvdKLFeOOv15uTHcRvG7dQ90Noi1VSTYt3N4M5w0sV5jZ
         TKUkPolGFKY9fO8RD0e3Dl6UC43dVFhUh4j6Z/AlC2DBqdyBPvi5W/Dd0XMVHs5nyARt
         DnAtDY7BV7oIvbiiYJNHvsdq0FotFyHKYH6NjmfCgLJlQ+eLl6tYH9Ua4ZNS+Z9nJVJy
         /rdlSz7glhOFEC76rEmkuhZ2krquZNq9a5Nt2uk3G6LyRGvgZwOGChRwAcNYBgWkt0ZW
         gg1MS7Ie8y38t2DkO+UZxlWDSxbFbYJzDg2H328DPiVwy42MFNnsAjsAB4UU9+EgM/yx
         dJuA==
X-Forwarded-Encrypted: i=1; AHgh+RpHTKeTKnYfrgesQ8xHLBjXMdSPLCJ1368vOz6r6pErA5dSonjkLypWrNtvWdQ8iW97AN4GGAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YztJ2GN4weSC6avGzj1+l9iBqVi1AvlI8KhAkIOx2QADsb2kj/D
	+4dmuVAZMeEkoNAbrgXPjRw3WHx04/EADAwc7lQkeyf1/VaRZ0aRXOT8/nj9OKeZgLTUzF58A2I
	/Kj9+iZByl8gwsN5b1qTHQwZsqP0BzzNigw7D7f4SFXG5t+OuadFQHnxkAxY=
X-Gm-Gg: AfdE7cmD6SDx7IpKPoT9LwKNdheHupM9nttlQkAYFtZEgm+lJTooaqiHgusyFTaGYlX
	HDoA0V97QzLdhHeLbRZQIlFAaNlsmvLuE6zxNUwvxU/os5a93T0O7S8ZhwGSCcQ0Ek9tVxKp3j5
	LLdKAKzALFOKCLY3egvksVdWsP7hWwOh91Z67/av5E0lxtIY5f2bbKjQPmofIdo3mTgUdPUiFyy
	fdyJjtNDwSHkCfG5ejq6tUHFupYmdxYhIEvWeGn0WY7e11Zo5fan3aYQc/MUVicNsuuYQkj9N3N
	b5mgwxaf1AWHiNHr8myw4lmRwa9ZMgUdeHN9Ocj9+gpu4X8xPKRA+rqIbqBvbNNYJeXOSy6GsGL
	bPr40NKCzwFyjiRgj5zmMEfjMyhPrxZhGz7CwNHbnFFydK4M=
X-Received: by 2002:a05:6a00:2d1b:b0:848:599f:26b with SMTP id d2e1a72fcca58-84a5140f5b2mr2104222b3a.14.1784007247443;
        Mon, 13 Jul 2026 22:34:07 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d1b:b0:848:599f:26b with SMTP id d2e1a72fcca58-84a5140f5b2mr2104205b3a.14.1784007246998;
        Mon, 13 Jul 2026 22:34:06 -0700 (PDT)
Received: from hu-vishsant-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f6bebcesm846227b3a.32.2026.07.13.22.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 22:34:06 -0700 (PDT)
From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 11:02:31 +0530
Subject: [PATCH 1/2] dt-bindings: net: qcom,bam-dmux: Add
 qcom,shikra-bam-dmux compatible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-qcom-bam-dmux-vmid-ext-v1-1-3f29da7cca76@oss.qualcomm.com>
References: <20260714-qcom-bam-dmux-vmid-ext-v1-0-3f29da7cca76@oss.qualcomm.com>
In-Reply-To: <20260714-qcom-bam-dmux-vmid-ext-v1-0-3f29da7cca76@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784007235; l=1495;
 i=vishnu.santhosh@oss.qualcomm.com; s=20251203; h=from:subject:message-id;
 bh=7FMZOy98v+vdLFCT3/0VGFUv24YLEv8tA8oNos6MiCk=;
 b=7ugYefRAQ74PZRiJjRR3AS/FyaCU+wCZLNUGkeOYD3eBpBzFdVUt9318rSpKPxm/zrPWchgOx
 w+3ujQUYdETCH8cpup9UIur/FtrtkpBxGpQ3bcgiNFYAt5RQ2bd44SI
X-Developer-Key: i=vishnu.santhosh@oss.qualcomm.com; a=ed25519;
 pk=G8/AJPecB1feGI7wxArGWGN0PPGQS0GUaD4THQCbdis=
X-Proofpoint-GUID: f2vt43QMIyQqYfonA232HENUy2wMZHx9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA1NSBTYWx0ZWRfX9TvAUty6xE15
 FgjNA1y84ePhngXreByHQWaVmSpA7siG3YfLv/IVZaXVX4mRyYiEamHCg+6Skm1SMZHgOEy23Vp
 qdNOeyNKGKISfowiUzm7Rgtmu+/UOC5kRBED9QZpMQPUCEPBO14HPK/0KiQ3ebRGXPuCd5P4sm8
 1ZeM/yXOPCSQTVb7RSbHAfBU5fecQtwUeW/T00N5hNsFA0jA1VXF10bwsxatNEG3wp1OOlYLoGa
 iA8fyc1AbF9QjyzpVuIGoKjKqV+MPRFFxXKCRbg0g4kIL02AOxN4N2MR8XfPeWYeQ1eeN4aF+uA
 cH7A2+a7Wl/4xXxIPylfDdkdnntJW1hOFJtYWZak9SPkGIqpL/3xc15TcVv1wnpM4QelUYr457i
 qiUQjX2sAYU32fWxWc6iwKEn1bHnA9EFLP1IitkshyNtsTooFTBF7Nzj9euO18PntFvH6Chz/sc
 O24m+M7M7GZwoIfK1vg==
X-Authority-Analysis: v=2.4 cv=XonK/1F9 c=1 sm=1 tr=0 ts=6a55ca50 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=uOAgoggzd781rp7tEncA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: f2vt43QMIyQqYfonA232HENUy2wMZHx9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA1NSBTYWx0ZWRfX56XIvka/7PnU
 0HwXWueMnixcq8fF4swB/bNGSZcROE4RU/Ql/gx+8DOR83WUSOZQ+iiAENnN5640I8OFeW70bmy
 aQhIe8MBdMOzvigIfSVMYMBPEWsQZyM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 impostorscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
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
	TAGGED_FROM(0.00)[bounces-307356-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gerhold.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,oss.qualcomm.com,gmail.com,sipsolutions.net];
	FORGED_RECIPIENTS(0.00)[m:stephan@gerhold.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:linux-arm-msm@vger.kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vishnu.santhosh@oss.qualcomm.com,m:chris.lew@oss.qualcomm.com,m:deepak.singh@oss.qualcomm.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:ryazanovsa@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[vishnu.santhosh@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp];
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
X-Rspamd-Queue-Id: 9A60B7512D0

On platforms where the modem DMAs into the BAM-DMUX RX data buffers and
the XPU enforces per-region access control, each individually
DMA-mapped RX buffer consumes an XPU resource group. With only ~16
groups available, the per-buffer mappings exhaust the table and inbound
transfers fault.

Add qcom,shikra-bam-dmux as an additional compatible for the Shikra SoC,
paired with the generic qcom,bam-dmux fallback, so the driver can match
on it via its of_device_id table.

Co-developed-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Signed-off-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml b/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
index 33746c238513d72366bc52359fb10f275475b331..27f0fdf285c17d6bfdecd5e59cad09912a5e821b 100644
--- a/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
@@ -22,7 +22,13 @@ description: |
 
 properties:
   compatible:
-    const: qcom,bam-dmux
+    oneOf:
+      - const: qcom,bam-dmux
+      - items:
+          - enum:
+              # Shikra
+              - qcom,shikra-bam-dmux
+          - const: qcom,bam-dmux
 
   interrupts:
     description:

-- 
2.34.1


