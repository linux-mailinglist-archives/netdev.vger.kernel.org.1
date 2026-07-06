Return-Path: <netdev+bounces-304935-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id deEhOHOXS2qWWAEAu9opvQ
	(envelope-from <netdev+bounces-304935-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:54:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDA9710207
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:54:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Pbj490pZ;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=MZC+0Wsv;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304935-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304935-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85B1235529CE
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 09:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99D843030C;
	Mon,  6 Jul 2026 09:35:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25414E3773
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 09:35:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330539; cv=none; b=sOAWOcyCzBJvpRLtFEPJrmRLGQO0CLD32hLYLi4EcofZKcGaUnj6jUyGjohiOLtoaXJbCE/Ts9MN/rYDjSQ74trPO8zvONL2TQrARfiRO7BJeL43CYHl7h2FbJDepfRzT0k5HAaT9kRX0JapHS/9lEVv7ch2SNADjyB9QDyTzH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330539; c=relaxed/simple;
	bh=eIEOzhD//NGAkff8ufm0J15xyTStaX5cCnX7vkBYkyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LksG1tPWnSrwVvelm+8mOtPyubrBchQbxMvKzQ3cf1Ewi+pabxoDstNcAtqt9bVktTwJfuwdAOSTjXWh+eahWhWzdQac1UG8l5hivXxV5jd+442qpZWSWIJfRzg+9z5LfLKPN7VOHXIRIWI1u6zyFIzEemTA1FrkpdObyjZ5DMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pbj490pZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MZC+0Wsv; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66693rZW107420
	for <netdev@vger.kernel.org>; Mon, 6 Jul 2026 09:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=6+5lE7ilLsL
	woQEluALM/vn0y9JfV02RJOJEvWyumEc=; b=Pbj490pZ7DPdHxlQjFBc60XFk7L
	8ajFrmPHjjtBsh0obbvlbqL8CtoEtBN/EqmJEgGxgVBtvkq9YNXMGdDpmWzWJ24u
	oPF40HtfewilHOjF/Ex2IW0TvJ4SBD5eibuPInfYrZHXES7Zq9Z9E5SA6oPy79HM
	lQo52C5miEe9pMptLXYKKi81CbDUYFql9+EahE0GJvqqIFhkzh6Hp2F8afKXu9Fv
	nHhLEY3nDh5Edtgf/coavUE4YkVxb8krWli75h8x6K7+n9ijd8UPKpCeRayzm+hN
	SwgYqdIOC7BTR6GhJUe7Dp+C/IUFol68TnNd7UII/j/uOy1K5DWKtDF+PIg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f891ur6xa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 09:35:33 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e820609d9so198622585a.2
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 02:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783330533; x=1783935333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+5lE7ilLsLwoQEluALM/vn0y9JfV02RJOJEvWyumEc=;
        b=MZC+0WsvLZ2NsO1JmJaEzY9sGsZYXl9162Xl+yiB4z4f+SniBzZpZMN7v132eyaD4s
         oUrPDH1WWZ2wq0rFqxZi0XaDwR7j/XwqcNk6Od1NTt9lC05s8R8gl9cmg2OXoRhpzTWk
         wk/PgRglMQlChxfHybsS906MFLPxc2kVn/wAowgZ2Un6un2Of1ylCOSfazERI4KXW49b
         dH3LlvD6jJ9eoMBBo3c5XZsHNUgEfSYkdG1kb7O7+l0X8VoOwxtwgZVRgd1fh2V9CGDC
         zHCj38iWPXJwMJwXapVapBGwXezLR6VjqSPOAQ6Z9RqPBw8QtXlTfVFPaudGkJA6JQi6
         t61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783330533; x=1783935333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6+5lE7ilLsLwoQEluALM/vn0y9JfV02RJOJEvWyumEc=;
        b=gf0VAKPUbYJNrhqBuwL/DEWoEsTXB9AZVVaxwQFx8JiitLkpN0pDnxkN7OBegCKr+2
         7i6zXKB/F4Iy+mDYKnRzHP/vEgo49m2YLF1NbeBTORLlskEzlrDaghQildhJKHeHSRiV
         ajUUUgT45hKBbtg0nwey4NsvGEyFmdA/TXTNj5qTOgeotxpoP3N7+xd1cOP/gtGlTxDQ
         aK1Bm6Cikch/qg7Q+Rw/AzYsKc9I4dKH8VQ8ySTVRfj+r5/V8aVm05Locq1uYuAxxTj3
         WRild7ikVWdFf/U9uRBZsEh4Sdbw3Hgja10surEgQDwrD5jv4fmi+bX9elGuzJAgdYjs
         fDUA==
X-Forwarded-Encrypted: i=1; AHgh+RrD8cVSNUpGeRrjWjEVRjNsNrX7ZnnYJWtR7mY89YfUeoZEEW9oTHHiOaZcvzSuht3kMU4lKEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrzUvqDj1Iyb5t4hBqXupyYjIDfDu+Vfj3OaPOaCkDBP+Z8n7p
	PB314Jfr1QwBELD1z1vthA6DNWoNbYJuccQPxTDI4jP64OMbzt8pgjictn6HNMXc7GqMlO5BYiE
	GYMqyrLR54COQPI0S+na5iiAfhHKLrW6c4Hdw9FGyuAcSvmvHZjiR2N+E1Rw=
X-Gm-Gg: AfdE7cknQPFYYk5XfXdbbtFhl7kiXBbw3ar7RfvQrfbyzdMII/EZT6A07UFytiyLC4h
	8WF9q2i8zG6hNb59KASXLLopePxFbq5ceZ9ure6gGSirB3G8hXmmgCSqVsRJ+eT/parjf8CdnNj
	1YhM0FlszAWQ0mUiY3/ZiMcpThsUwXqUVQYZr6Xthqy9O1WruBlV57YwHnjIIBx2iq6Q1pW7bH1
	xFUWa+WoymTz7L922ewNLml1MyKvfcLfAEwxLZO9b7uSuoXax772MeXMXnnBssnFy4tdhM7Qn31
	+BhLs1K193WbX6rXp5THl3/jCEQ+VrZCB7n+73At+f8gj7GQek7dLtwdiauBeWciJn6VSudYutm
	kxmjWRmZ39iI4HFCWGcJTtp9Pedc=
X-Received: by 2002:a05:620a:4096:b0:92e:7d53:8e83 with SMTP id af79cd13be357-92e9a4f2cd4mr1240861485a.56.1783330532653;
        Mon, 06 Jul 2026 02:35:32 -0700 (PDT)
X-Received: by 2002:a05:620a:4096:b0:92e:7d53:8e83 with SMTP id af79cd13be357-92e9a4f2cd4mr1240858985a.56.1783330532161;
        Mon, 06 Jul 2026 02:35:32 -0700 (PDT)
Received: from quoll ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493cce11497sm290925905e9.12.2026.07.06.02.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 02:35:31 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Raju Rangoju <Raju.Rangoju@amd.com>,
        Prashanth Kumar K R <PrashanthKumar.K.R@amd.com>,
        Richard Cochran <richardcochran@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 2/2] arm64: dts: amd: seattle: Remove useless xgbe DTSI include
Date: Mon,  6 Jul 2026 11:35:25 +0200
Message-ID: <20260706093523.274093-4-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706093523.274093-3-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260706093523.274093-3-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6482; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=eIEOzhD//NGAkff8ufm0J15xyTStaX5cCnX7vkBYkyM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqS3bcvp65RtPTDKzIG6Air43gF1sJufaUcjkMr
 zSyhPmkL+2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCakt23AAKCRDBN2bmhouD
 1/+6D/wN7RfYnANjffxf/4w0QcMEmdt5CPHK2d/uWJChjvj5SeyxFt5svLboWJf1pBMesC4fXw5
 DoTa4412flPJavW12LCKzCjbch/h6b/lNod7x2I9tSk9sDZ/F24n03J0/ZUEts/pmTmyjeBANRf
 aoFdesoboBQShvAwQT4NNZn7ytV3/rGHDm0q7nIT0TS1iMMcV4/3ZqByewUR0u8Drg+ERTYkE2+
 uoHHD7wJ+MHfR5w2vurMGZEWUcNIrbL+94N7RKxe1kYxgks/ZDbr2hN73sNmHvmG8qyRxZhcQ53
 uufAaAB0J3DdvdTRPoS7B0mi5Jz1FY1pKPVp49A3F/Kzc1yf3lObuSO3hVvX/jIqtHZQ7d+Cxo1
 jUhK+UZPdJ/XmXK/z2tNiC+cSwpVGNSVqR0UTDxubrmy5wYkSSbNI2YxJOCn8ZCpkYsjcSqEj3a
 ZBU6Lx9r4lNXEiAldP/J8USy9Pb6BlDAWklEm9XsF0rZhTq295ds9zydlQ94g8JGWb34wW94hR2
 jBG488QGCkl3Qf7DdO1C0SA74Pk3o9Se0+UN6yUlewe2IUsC0IfB8GI8LmehI+HvI0VkixFU9Et
 yMnn9MbPybroOwRArxdcH1pNjmyiXF39vMq8mRohnQT0Ws5YTSqsPlQ1FleQSAwmG/k47aaPdOP DgUc790dC2p1adw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BhF-DjZCuvDyCB-ZRdM6W5cXyYvguHZk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5NiBTYWx0ZWRfX+qwFepD7bF66
 +vUMwFOns0spYbOpLYwhLRc+TVnbBeLtgtB8Ln0JXa/A3Aq6PVu+ZYKoVdvaSBjAJvvdDVzyCS/
 CKKctLZ6fbfftuV13h6DoRYVWPGSHNw=
X-Authority-Analysis: v=2.4 cv=Mo1iLWae c=1 sm=1 tr=0 ts=6a4b76e5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=EJugBUHlmtfpvM5MZ8AA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5NiBTYWx0ZWRfXzgrX8hGntRoq
 /B5AcEbgpFznuhblYt6bYkWEO+f/2yi8KcPrnVUFkSBXNP+HbXylOgVXQlTPscnq/2zoODVs5rJ
 KjM6OKSHwqhcii9WQKleSMWr6n8lIsTfkx2ieXqE81UO1YlPCvqRJpsNX8R4f6ILTrZekj+Puq2
 69qFvRYFRd07lNCr+7WEMOTGDjFq19PQepKRBcDMkl/JUSu+6WPtordcbG+Gi2IO1RZLrUjsiR8
 O5uBb1NczOMioViOTd0wy45fV4GaiQ1sGS1AA3FUlKyugBX/N9vSdhhRLfa93FEyBB0u7k5ike8
 qCRmLJFQpy6jJlcnR4o4Fz4KcoQ5ZoY5QcsLyZaUdjOBF3dggjk+MFOTEl1tp2d93OmM1aCvZXL
 WaQ7hj+2Nxid5uWTwzXQcLkS4NIZyU7FJMOgry5alTBPLjuFjep8Pb+t9Pr0v4nIWpI4CDCYinj
 p+RpIIgKOciJOtnSdlg==
X-Proofpoint-ORIG-GUID: BhF-DjZCuvDyCB-ZRdM6W5cXyYvguHZk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060096
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304935-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[amd.com,kernel.org,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:suravee.suthikulpanit@amd.com,m:thomas.lendacky@amd.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Raju.Rangoju@amd.com,m:PrashanthKumar.K.R@amd.com,m:richardcochran@gmail.com,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:krzysztof.kozlowski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[krzysztof.kozlowski@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7BDA9710207

The "amd-seattle-xgbe-b.dtsi" file is included exactly once, so paste the
contents directly in proper DTSI.  No functional impact.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../boot/dts/amd/amd-overdrive-rev-b0.dts     | 78 ++++++++++++++++-
 .../boot/dts/amd/amd-seattle-xgbe-b.dtsi      | 84 -------------------
 2 files changed, 77 insertions(+), 85 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/amd/amd-seattle-xgbe-b.dtsi

diff --git a/arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts b/arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts
index 8862adae44e9..0860fc7a6927 100644
--- a/arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts
+++ b/arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts
@@ -71,5 +71,81 @@ sdcard0: mmc@0 {
 };
 
 &smb0 {
-	/include/ "amd-seattle-xgbe-b.dtsi"
+	xgmac0: ethernet@e0700000 {
+		compatible = "amd,xgbe-seattle-v1a";
+		reg = <0 0xe0700000 0 0x80000>,
+		      <0 0xe0780000 0 0x80000>,
+		      <0 0xe1240800 0 0x00400>, /* SERDES RX/TX0 */
+		      <0 0xe1250000 0 0x00060>, /* SERDES IR 1/2 */
+		      <0 0xe12500f8 0 0x00004>; /* SERDES IR 2/2 */
+		interrupts = <0 325 4>,
+			     <0 346 1>, <0 347 1>, <0 348 1>, <0 349 1>,
+			     <0 323 4>;
+		amd,per-channel-interrupt;
+		amd,speed-set = <0>;
+		amd,serdes-blwc = <1>, <1>, <0>;
+		amd,serdes-cdr-rate = <2>, <2>, <7>;
+		amd,serdes-pq-skew = <10>, <10>, <18>;
+		amd,serdes-tx-amp = <0>, <0>, <0>;
+		amd,serdes-dfe-tap-config = <3>, <3>, <3>;
+		amd,serdes-dfe-tap-enable = <0>, <0>, <7>;
+		mac-address = [ 02 A1 A2 A3 A4 A5 ];
+		clocks = <&xgmacclk0_dma_250mhz>, <&xgmacclk0_ptp_250mhz>;
+		clock-names = "dma_clk", "ptp_clk";
+		phy-mode = "xgmii";
+		iommus = <&xgmac0_smmu 0x00 0x17>; /* 0-7, 16-23 */
+		dma-coherent;
+	};
+
+	xgmac1: ethernet@e0900000 {
+		compatible = "amd,xgbe-seattle-v1a";
+		reg = <0 0xe0900000 0 0x80000>,
+		      <0 0xe0980000 0 0x80000>,
+		      <0 0xe1240c00 0 0x00400>, /* SERDES RX/TX1 */
+		      <0 0xe1250080 0 0x00060>, /* SERDES IR 1/2 */
+		      <0 0xe12500fc 0 0x00004>; /* SERDES IR 2/2 */
+		interrupts = <0 324 4>,
+			     <0 341 1>, <0 342 1>, <0 343 1>, <0 344 1>,
+			     <0 322 4>;
+		amd,per-channel-interrupt;
+		amd,speed-set = <0>;
+		amd,serdes-blwc = <1>, <1>, <0>;
+		amd,serdes-cdr-rate = <2>, <2>, <7>;
+		amd,serdes-pq-skew = <10>, <10>, <18>;
+		amd,serdes-tx-amp = <0>, <0>, <0>;
+		amd,serdes-dfe-tap-config = <3>, <3>, <3>;
+		amd,serdes-dfe-tap-enable = <0>, <0>, <7>;
+		mac-address = [ 02 B1 B2 B3 B4 B5 ];
+		clocks = <&xgmacclk1_dma_250mhz>, <&xgmacclk1_ptp_250mhz>;
+		clock-names = "dma_clk", "ptp_clk";
+		phy-mode = "xgmii";
+		iommus = <&xgmac1_smmu 0x00 0x17>; /* 0-7, 16-23 */
+		dma-coherent;
+	};
+
+	xgmac0_smmu: iommu@e0600000 {
+		 compatible = "arm,mmu-401";
+		 reg = <0 0xe0600000 0 0x10000>;
+		 #global-interrupts = <1>;
+		 interrupts = /* Uses combined intr for both
+			       * global and context
+			       */
+			      <0 336 4>,
+			      <0 336 4>;
+		#iommu-cells = <2>;
+		dma-coherent;
+	 };
+
+	 xgmac1_smmu: iommu@e0800000 {
+		 compatible = "arm,mmu-401";
+		 reg = <0 0xe0800000 0 0x10000>;
+		 #global-interrupts = <1>;
+		 interrupts = /* Uses combined intr for both
+			       * global and context
+			       */
+			      <0 335 4>,
+			      <0 335 4>;
+		#iommu-cells = <2>;
+		dma-coherent;
+	 };
 };
diff --git a/arch/arm64/boot/dts/amd/amd-seattle-xgbe-b.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-xgbe-b.dtsi
deleted file mode 100644
index 18b0c2dd1b2d..000000000000
--- a/arch/arm64/boot/dts/amd/amd-seattle-xgbe-b.dtsi
+++ /dev/null
@@ -1,84 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * DTS file for AMD Seattle XGBE (RevB)
- *
- * Copyright (C) 2015 Advanced Micro Devices, Inc.
- */
-
-	xgmac0: ethernet@e0700000 {
-		compatible = "amd,xgbe-seattle-v1a";
-		reg = <0 0xe0700000 0 0x80000>,
-		      <0 0xe0780000 0 0x80000>,
-		      <0 0xe1240800 0 0x00400>, /* SERDES RX/TX0 */
-		      <0 0xe1250000 0 0x00060>, /* SERDES IR 1/2 */
-		      <0 0xe12500f8 0 0x00004>; /* SERDES IR 2/2 */
-		interrupts = <0 325 4>,
-			     <0 346 1>, <0 347 1>, <0 348 1>, <0 349 1>,
-			     <0 323 4>;
-		amd,per-channel-interrupt;
-		amd,speed-set = <0>;
-		amd,serdes-blwc = <1>, <1>, <0>;
-		amd,serdes-cdr-rate = <2>, <2>, <7>;
-		amd,serdes-pq-skew = <10>, <10>, <18>;
-		amd,serdes-tx-amp = <0>, <0>, <0>;
-		amd,serdes-dfe-tap-config = <3>, <3>, <3>;
-		amd,serdes-dfe-tap-enable = <0>, <0>, <7>;
-		mac-address = [ 02 A1 A2 A3 A4 A5 ];
-		clocks = <&xgmacclk0_dma_250mhz>, <&xgmacclk0_ptp_250mhz>;
-		clock-names = "dma_clk", "ptp_clk";
-		phy-mode = "xgmii";
-		iommus = <&xgmac0_smmu 0x00 0x17>; /* 0-7, 16-23 */
-		dma-coherent;
-	};
-
-	xgmac1: ethernet@e0900000 {
-		compatible = "amd,xgbe-seattle-v1a";
-		reg = <0 0xe0900000 0 0x80000>,
-		      <0 0xe0980000 0 0x80000>,
-		      <0 0xe1240c00 0 0x00400>, /* SERDES RX/TX1 */
-		      <0 0xe1250080 0 0x00060>, /* SERDES IR 1/2 */
-		      <0 0xe12500fc 0 0x00004>; /* SERDES IR 2/2 */
-		interrupts = <0 324 4>,
-			     <0 341 1>, <0 342 1>, <0 343 1>, <0 344 1>,
-			     <0 322 4>;
-		amd,per-channel-interrupt;
-		amd,speed-set = <0>;
-		amd,serdes-blwc = <1>, <1>, <0>;
-		amd,serdes-cdr-rate = <2>, <2>, <7>;
-		amd,serdes-pq-skew = <10>, <10>, <18>;
-		amd,serdes-tx-amp = <0>, <0>, <0>;
-		amd,serdes-dfe-tap-config = <3>, <3>, <3>;
-		amd,serdes-dfe-tap-enable = <0>, <0>, <7>;
-		mac-address = [ 02 B1 B2 B3 B4 B5 ];
-		clocks = <&xgmacclk1_dma_250mhz>, <&xgmacclk1_ptp_250mhz>;
-		clock-names = "dma_clk", "ptp_clk";
-		phy-mode = "xgmii";
-		iommus = <&xgmac1_smmu 0x00 0x17>; /* 0-7, 16-23 */
-		dma-coherent;
-	};
-
-	xgmac0_smmu: iommu@e0600000 {
-		 compatible = "arm,mmu-401";
-		 reg = <0 0xe0600000 0 0x10000>;
-		 #global-interrupts = <1>;
-		 interrupts = /* Uses combined intr for both
-			       * global and context
-			       */
-			      <0 336 4>,
-			      <0 336 4>;
-		#iommu-cells = <2>;
-		dma-coherent;
-	 };
-
-	 xgmac1_smmu: iommu@e0800000 {
-		 compatible = "arm,mmu-401";
-		 reg = <0 0xe0800000 0 0x10000>;
-		 #global-interrupts = <1>;
-		 interrupts = /* Uses combined intr for both
-			       * global and context
-			       */
-			      <0 335 4>,
-			      <0 335 4>;
-		#iommu-cells = <2>;
-		dma-coherent;
-	 };
-- 
2.53.0


