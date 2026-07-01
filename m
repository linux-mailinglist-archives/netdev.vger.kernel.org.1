Return-Path: <netdev+bounces-303757-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WVs1Hq08RWpX9AoAu9opvQ
	(envelope-from <netdev+bounces-303757-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:13:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB08C6EF97E
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:13:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=RmfiO339;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=bqhZ4hbR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303757-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303757-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46869314A4B0
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 16:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FADE4C9552;
	Wed,  1 Jul 2026 16:01:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4AD4C77AF
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 16:01:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921676; cv=none; b=gd7jkMkLsrtscXrkdGeQRGsvpaRhYxcgSCJVOHS62EjhUCgFlY/pApixtkNniP+Cpi5wcElhZ5wDNJ9UITOK9/Nud2MPPCbYk+Jz98truLvcQj5ioex0/qojb7JNKrAUHqzJF7Gl60nFGTFGWOF/pcx6A4s4SPgGOXL8H04kNMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921676; c=relaxed/simple;
	bh=xfmoy+hPtoC5+UqYOV7i9p3VVCicrM1Q946rAFKBtYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W/YPvMF+0W/Pl+TZZhL6GKjVvWG+Z+jraG46KPOTncn312Dbb/HroPflWK8fUTL3U9WRgKtLKLL9dKOytNgwqcH0I68g2AiQEpNcit00QUIoS+1Dq2ULDC4YiGeB6i/wTjuTvrQXoNHoM2JNCEVx2vHOXX3nT/sgjj9fl9NGVSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RmfiO339; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bqhZ4hbR; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661Fo8dr1428887
	for <netdev@vger.kernel.org>; Wed, 1 Jul 2026 16:01:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9YSak8Ew9R23ftO3G6++eI4jZmwu0q3/SECsCEcQvU4=; b=RmfiO339KZkoqVcU
	OC2aMvDyZNB1SRsiSe4KdSthLLl9QAzoJPKGzYyRnpg+aN5IiJU5YtT6TW5gvXJH
	H7LOBPJqGiKZY3M2Oqmi7yzZwf3Lt7dHrTaVzqDINMl0dJ2BeXptzOxdZAwmp2TB
	A8SW5c2astmVOiHFj04qj2M7OF4XzpBGjCtjeyFJ24BfVr/cXFzWgF/s+p4Nm1he
	c6x7fU4Y1Kt2nF0VU9RjcdQjSAfVGVIQCvsnw7gdktfZYCscoWmcGCC8ytFkKTT2
	6AbgaHDSjlcmls9cLaGTFaDvh1ZLNr+7c1FvyGFbMYtlkfPplUxv1Stal1HPSdHy
	FIhzbg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f53q08n94-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 16:01:05 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e66f9e2baso83643385a.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 09:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782921664; x=1783526464; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9YSak8Ew9R23ftO3G6++eI4jZmwu0q3/SECsCEcQvU4=;
        b=bqhZ4hbRggb/j4RDTyFBqrnwv4UID+wEcs/hc49OIJIpx4qxrGnBHvw3bG6/zfFvuX
         iqEKzB6p7UoG5O11BDmBOKAsdJwxcE0HAVn30Jvvv3kY16P+GHS+4K1GyTCwxFswHyqb
         /1NZkbGaxO3QaA5UADod0oKtXmcLc5e/sG6Zk146yXbAzXU0P3B2Rf0tY8RrVT1uKg4l
         o7fTzf42q1P6H1TlgVeGx+KuBoLilSnrZD0Ox1jHPWVeVR3YJHh8ffLCu1ZO3vMxqHMO
         vHusIDNumnOA0/X2GcB9De8qjVBZnTlQWD5D9mZZsnWPEZ8wDnvM9QruLdB6DgJe94ax
         ItQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921664; x=1783526464;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9YSak8Ew9R23ftO3G6++eI4jZmwu0q3/SECsCEcQvU4=;
        b=m9/9ocfxAtv432oau5ZK0OThfmqj4SSeTyMM99M+rfzKtPDHWUdKU1fLdiLOUiykwQ
         2eXqS9Ozykb7GU9o7QL/VHGE8OvFfa/pjFR8GT7dF6QH3Tes2kgcQmi7lAM1Ycth2Jh+
         zPconHK4UP5MNcpvDhxQocMRgbz2irbkJXbHN9L7nfAwF+s3u35gAAdwbLdyKBfaEHTp
         xyePLCf0gOmpm8NL2NcIdSjubzP57S28efI3JP78on7xLoXqrtVVNfH9Rv1bjDUlzD7B
         HIIm7r7XC8QsSlGQSbI1SJThX9TUmrp7kPiS5lLmwPtwnvviqgOlf/jh2vNIf6yxH6cI
         18TA==
X-Forwarded-Encrypted: i=1; AFNElJ/ifwrXh3/Smvd2PI7nvQgW8+oliG19pcg9owu1kURwzd20/Vu1YwJiRRoNIcZSxFyPeiYanuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YySNvx01xHyrEAY5dX7jT9lolygdLbfCENuNnJ6JhFmTgoqV1eK
	PuatB/qUrukl5u10dqV804+Bmpedw3Qscd1CRXnXevBbYQ2WSVYMiQkW2G1wGE8/RexT/VMDfHG
	pVtYrjfuSGIISbwWrAqvhUy2kmOKEz9Jz4oa5ywkIyTeBd1O9mJ1ng+oJubQ=
X-Gm-Gg: AfdE7cnZVDl2KESxlEVgKPpNLcTuKlN6Z6MiL98SoCv7IZhhtaprVLUd8zkArpvM4Zm
	MngsiBf4DpHUQloe7jyImBhWgCgs/tvzekSibHIh0+S5z08P2PCeNt24LBK+vXjJPKd+wr8xJyp
	oAc5OI02zurx06UX/XND0yp1z/li0Ry7Rh8PCB/3nOz3064ft3bnY/k68o3uoYbJmKVskdswLk6
	eWQqyf6tlFn1QFn/Q57k+J2MLK8zzkAKp1n5pV5y3hBgkeqVMhMs/4WZEWxo75tXbAVIQNJ3Wfq
	S/UaHfcLzIXwSoCEYVC/NGAfiiKPemcYR6USW8eFSSpgcZbfVGjQBhGkd6K3Peam54QYMhdguoI
	GEpbb7n4zo/ojPIS1wMPjeB0bEt7XhCw/LNFZR8FWyDGQfJN8eOtLHGr2ngfrwU7uB3BmWDZDqL
	eI7i1Wx6pNSgrDYSx2gQTEef7ZVAMGOViQ9HVGyKtbPDuGS86aPtAMkXB/PmCZfv0=
X-Received: by 2002:a05:620a:2987:b0:92b:6805:919d with SMTP id af79cd13be357-92e7b473836mr228637785a.69.1782921663940;
        Wed, 01 Jul 2026 09:01:03 -0700 (PDT)
X-Received: by 2002:a05:620a:2987:b0:92b:6805:919d with SMTP id af79cd13be357-92e7b473836mr228543885a.69.1782921657091;
        Wed, 01 Jul 2026 09:00:57 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d19e03sm296613066b.4.2026.07.01.09.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:00:53 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 18:00:31 +0200
Subject: [PATCH v7 7/9] Bluetooth: hci_sync: Add NVMEM-backed BD address
 retrieval
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-block-as-nvmem-v7-7-3fe8205ef0a8@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Piotr Kwapulinski <piotr.kwapulinski@intel.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=dtnrzVg4 c=1 sm=1 tr=0 ts=6a4539c1 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=QyXUC8HyAAAA:8 a=UCHyucM7ZhvORosJgB0A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 16eQ_BOen5x1NLwvlGRSp0zI4uSTVO8C
X-Proofpoint-GUID: 16eQ_BOen5x1NLwvlGRSp0zI4uSTVO8C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX5nUdW5DcAsaA
 psR3N9hSKuHY9W+cQ8iixVTMgIEhW5zlnQApspAHAATJJOZ26qk+50cf8ZtKu4xcO8LTUDYGsyI
 BFnIXYitRUSGTriHhtrTAf0S/9Wpqe7lsHx+Q5NuDsMTE3x2vrCjfB/ULXB5Nsqb1CFUSWecn87
 a8gZ/NkPfG0GSwsT4u4YDt/JYnMeWk2UAB7c42WylUzxMLbVOZs1MeJXX1fUuEVnG6NIUugzj6q
 klcMSvwasmw1ff5ZFhMtyEm1OnflJVR6l58cJeXt2BedYuJ/hB1N2utKKSWsa8Qlj0ivjXeqhin
 noHQBR0isYoK797JjNlCYBE0+C7cl/r5+OJkDVKSVQgg/w2cjr64P4E1x+sbsORxD12dl31t1Lk
 5BavRZYrf/5h5j6jvACsd06X7L9ZNc04IjUbs4jIO/ZFMVZfZctg7QtbYDELM/+IJCTZF256tng
 P3fuCJS9xSm3kOwfLZA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX6OJlng4Gj6Rv
 hM1SGe+1rBer8JLfyJdm73+qqPcWU86hvGA/NAPbFGvCmbwk0Pekc21qFm5FDdjiSbm96qn230c
 GDSLTkrGVxGcmw/C6GcJX7SmrNYiFhY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010169
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
	TAGGED_FROM(0.00)[bounces-303757-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:ansuelsmth@gmail.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:piotr.kwapulinski@intel.com,m:krzk@kernel.org,m:conor@kernel.or
 g,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,intel.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
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
X-Rspamd-Queue-Id: DB08C6EF97E

Some devices store the Bluetooth BD address in non-volatile
memory, which can be accessed through the NVMEM framework.
Similar to Ethernet or WiFi MAC addresses, add support for
reading the BD address from a 'local-bd-address' NVMEM cell.

As with the device-tree provided BD address, add a quirk to
indicate whether a device or platform should attempt to read
the address from NVMEM when no valid in-chip address is present.
Also add a quirk to indicate if the address is stored in
big-endian byte order.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 include/net/bluetooth/hci.h | 18 ++++++++++++++++++
 net/bluetooth/hci_sync.c    | 41 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 572b1c620c5d653a1fe10b26c1b0ba33e8f4968f..7686466d1109253b0d75edeb5f6a99fb98ce4cc6 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -164,6 +164,24 @@ enum {
 	 */
 	HCI_QUIRK_BDADDR_PROPERTY_BROKEN,
 
+	/* When this quirk is set, the public Bluetooth address
+	 * initially reported by HCI Read BD Address command
+	 * is considered invalid. The public BD Address can be
+	 * retrieved via a 'local-bd-address' NVMEM cell.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_USE_BDADDR_NVMEM,
+
+	/* When this quirk is set, the Bluetooth Device Address provided by
+	 * the 'local-bd-address' NVMEM is stored in big-endian order.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_BDADDR_NVMEM_BE,
+
 	/* When this quirk is set, the duplicate filtering during
 	 * scanning is based on Bluetooth devices addresses. To allow
 	 * RSSI based updates, restart scanning if needed.
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index fd3aacdea512a37c22b9a2be90c89ddca4b4d99f..56248d4abcb5b1d9993962a9f6bf60bf865b8d7b 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/property.h>
+#include <linux/of_net.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -3588,6 +3589,39 @@ int hci_powered_update_sync(struct hci_dev *hdev)
 	return 0;
 }
 
+/**
+ * hci_dev_get_bd_addr_from_nvmem - Get the Bluetooth Device Address
+ *				    (BD_ADDR) for a HCI device from
+ *				    an NVMEM cell.
+ * @hdev:	The HCI device
+ *
+ * Search for 'local-bd-address' NVMEM cell in the device firmware node.
+ *
+ * All-zero BD addresses are rejected (unprovisioned).
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+static int hci_dev_get_bd_addr_from_nvmem(struct hci_dev *hdev)
+{
+	struct device_node *np = dev_of_node(hdev->dev.parent);
+	u8 ba[sizeof(bdaddr_t)];
+	int err;
+
+	if (!np)
+		return -ENODEV;
+
+	err = of_get_nvmem_eui48(np, "local-bd-address", ba);
+	if (err)
+		return err;
+
+	if (hci_test_quirk(hdev, HCI_QUIRK_BDADDR_NVMEM_BE))
+		baswap(&hdev->public_addr, (bdaddr_t *)ba);
+	else
+		bacpy(&hdev->public_addr, (bdaddr_t *)ba);
+
+	return 0;
+}
+
 /**
  * hci_dev_get_bd_addr_from_property - Get the Bluetooth Device Address
  *				       (BD_ADDR) for a HCI device from
@@ -5042,12 +5076,17 @@ static int hci_dev_setup_sync(struct hci_dev *hdev)
 	 * its setup callback.
 	 */
 	invalid_bdaddr = hci_test_quirk(hdev, HCI_QUIRK_INVALID_BDADDR) ||
-			 hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY);
+			 hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY) ||
+			 hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM);
 	if (!ret) {
 		if (hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY) &&
 		    !bacmp(&hdev->public_addr, BDADDR_ANY))
 			hci_dev_get_bd_addr_from_property(hdev);
 
+		if (hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM) &&
+		    !bacmp(&hdev->public_addr, BDADDR_ANY))
+			hci_dev_get_bd_addr_from_nvmem(hdev);
+
 		if (invalid_bdaddr && bacmp(&hdev->public_addr, BDADDR_ANY) &&
 		    hdev->set_bdaddr) {
 			ret = hdev->set_bdaddr(hdev, &hdev->public_addr);

-- 
2.34.1


