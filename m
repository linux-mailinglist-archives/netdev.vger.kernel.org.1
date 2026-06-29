Return-Path: <netdev+bounces-302680-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rxVEE8yBQmok8wkAu9opvQ
	(envelope-from <netdev+bounces-302680-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 16:31:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 083506DC12D
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 16:31:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=E0UPDdIA;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Irf00Ot2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302680-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302680-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6456C3178764
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 14:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582F240E8F3;
	Mon, 29 Jun 2026 14:18:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBA21A6838
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 14:18:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782742720; cv=none; b=fuflS157cLUuCvtNVWDatEbhGP1gUG370+BBn5hTArK1073MJJQDzsxjFPbgiYlXbFNWxi7gz0m3JV004Vog3QCOkiDIkhA/xnSBuxLgfppiGrWu+0TcUFz4/ISUj5RhrikYKkMBSLaV5iapgV25EhPaGhXgrGSv+EtCuaZ/BPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782742720; c=relaxed/simple;
	bh=0bnGvHO0rg4OMO85F9ZInJ9e5FeYAfeKZbeYpeWqk+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gGVy75J6FFRp0ma6tObfATJ/gYdyyiC4vd7CX3UZIXv0CMaMvpeKPDQvX1i2R7P9cEKNQCbUoFtSXo0CyZSRVhBC151ix3IYRrSb904a9Ii2x5mDm+9061l+leDOlFqwoNS6UEtNAE4neCvpI8eQtYPMjqCTLFWY3Mcb8s5GGHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E0UPDdIA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Irf00Ot2; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TATRwu2592811
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 14:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HtzV28mhl3/Uuzr/u/bbslNE/8t349o7WhdF8PQcBC8=; b=E0UPDdIAO5w4lV+w
	BhzfHarJ3Q7jTpWQF+9GNtQnrUPzztxeJmMgvK6QRNb1yRvOw0MlXQfgCtKHgoSC
	ivK/6TONPp7mFqp8peTKqyTtY+TZPiB0Ykkp8Su3VeehkphlyolXhoLBkfdG+437
	qMoXnw8GrAbvVXvvOAH65e3LRnrGNS6EYxjPpcJGlEAfJPzmkiTTV+QFe30fFJ65
	OuzPZym4bhSzJWVG+CjtycRw7+vY6siYBvTy48F9GdSVe5o/1Mlw1MhMnXtM9ZIf
	3mP1GlkwqcpW9PNqQOc9PgF39c3l0HA/aDEOtvLh8/eS0gx/eTpXrJrBaLX9UJuf
	B+KD1g==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3k7vj20b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 14:18:38 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-73966c839bfso39985137.0
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 07:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782742717; x=1783347517; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HtzV28mhl3/Uuzr/u/bbslNE/8t349o7WhdF8PQcBC8=;
        b=Irf00Ot2RxCFbU6TVCA9sp6WncGznh1dUglCJ4lnPReV5ip+tnJ6NcmK2T0+jSWybb
         raKLF+d5+RWonzCDDcyRr3nbGMu9dfrw7tATlsMuM5q6UIIlbuq/MhcF9C/co+kjOUbf
         S/V12pCWFpftViuVYZsAY2NqZE/hWoefsOJggiEzGOwA/od6havGs3hO9WESuysvO2ue
         EliVjUdiqbvujJ+3j+EWjo1N39ykm6ttpNo80diHToUI17bbGAp5VcB6Oj6EGASTXhxB
         9PVG+kGvg9c1hreCs6QpQ34bJi0ALHqOtYfpCIlGJD0N+USMAxLvDl4rm3puzwVCdxLg
         KTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782742717; x=1783347517;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HtzV28mhl3/Uuzr/u/bbslNE/8t349o7WhdF8PQcBC8=;
        b=jXqqBk7Qg8Dn63MlHt1o183s9raGLP3ir7LldtPpEqKHNrOGgj1HG7+wdJxUROsb9i
         W9ZFfkQoWQ+oFRd+9snytBBgj1itYNuRMd1qGBjavF7XeQ39DMprqUgP3j01G3KoyJ4p
         /ed7Zq+8DnUbktKRnJKzp6ie4Y8qBoROxx7gccD/umyuKPm9JtSi8psvvL8RmWTwKO7y
         +kZ3ruHGinmyXI9QNuCZeH0EFyBVFfwTbVqrV2ry2r/ko81bgaYep4NUw5H5DbYiX6nT
         Tm0AaXWVaEkkjDfeOtkvb1mfTt6HvVI1wfpl1BAMesSyTKm4/1yiso+uCN4hi5fRIgUR
         i82w==
X-Forwarded-Encrypted: i=1; AHgh+RopXa6bzBueqRiBabJSqe9qWXvqX3jfZ9o9BKsRJQmvhcjKP7ajIYShOCq+bH63t4RVg5z2E54=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS+WmMqL+M6zUUGE99Aov9gpAwYse/7xYv94z06CsQwPCqWlcI
	NPEmWeKcsaSM7v1pCZamD9qYyCXi0s15anmbECi5CoQYHeNowsnwgdp9v2SZasS/Ljw5YmpaQgO
	Yaa+2zpK5z1nFGnglTOd52DpBmU4quW67qgh2TeLGwSFl7w5pxs3KUkXPyew=
X-Gm-Gg: AfdE7cmZQqaZWcUs9bt3lGdLfeZMh1c2O7grovvJ8WEkVe2CtttOKETKeX0JQrPWQYt
	EtFGur/l8PvYIKr5aSSZp6wQquckftOrB5AVQ0l1tvJu6F6fQOEMVQFDfUTRujx+X3P6skpweSg
	1vqvUushs6IohfcJHFQTGqY+93PXakyQ5SEhzanhLgmw7VpQH254Mn2RKSvcjFA3wl36GMY7vU6
	FEPKoT4OKO4FYOWQN5bLpBTXEvSj1n4EDHpPRx+h8xH5vDCXLVXq0yKOZXfXz2FE204C2632APO
	1/HFbptIdxEsvLamXrpCNLFF7+JaHOsZdeKXqlF1s3BFNkaq14Vgz33GUavfg/oR82WZ/M6B2Hy
	JXt2ZLtqkFfRcpbnomahU59XplfykInX2tE4=
X-Received: by 2002:a05:6102:440f:b0:633:3bf6:977c with SMTP id ada2fe7eead31-73433e2e7a8mr2478743137.1.1782742717526;
        Mon, 29 Jun 2026 07:18:37 -0700 (PDT)
X-Received: by 2002:a05:6102:440f:b0:633:3bf6:977c with SMTP id ada2fe7eead31-73433e2e7a8mr2478702137.1.1782742714984;
        Mon, 29 Jun 2026 07:18:34 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6986625efc1sm1884211a12.19.2026.06.29.07.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 07:18:34 -0700 (PDT)
Message-ID: <66330ed6-826a-431e-9e8e-f2998af55168@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 16:18:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sm8450: Add IPA support
To: Esteban Urrutia <esteuwu@proton.me>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alex Elder <elder@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260622-sm8450-ipa-v1-0-532f0299f96e@proton.me>
 <20260622-sm8450-ipa-v1-1-532f0299f96e@proton.me>
 <806046b2-20ed-437e-a7e6-b3c0699f5a2d@oss.qualcomm.com>
 <b1f872f5-66cc-45fc-ad42-c308f8970691@proton.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <b1f872f5-66cc-45fc-ad42-c308f8970691@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: xwHLlwrTMvbo_jC3_6WIaVUBQGuMeFre
X-Authority-Analysis: v=2.4 cv=CqCPtH4D c=1 sm=1 tr=0 ts=6a427ebe cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=0dHVmNKhjX53LK_pQYIA:9 a=QEXdDO2ut3YA:10 a=QYH75iMubAgA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExOSBTYWx0ZWRfX7/He60g41/X6
 UGEmTE52YYzx1buSXRzrc0GkKIsP0wOz+a6SOibOtMrVCzJOMHcNq/v18v0WNS0lTWwGbY2XJA4
 YEPQM/TGSKU+0sKOdW902qXvGFz/Zhs=
X-Proofpoint-ORIG-GUID: xwHLlwrTMvbo_jC3_6WIaVUBQGuMeFre
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExOSBTYWx0ZWRfX21Yjp0VL/m0c
 ihC01uYknamWF9t7wZDpp7oDJMlHqM0UikWBNwJvIOfQbahKgZL+HBHEAiTxCkkUxW4MsNsuSTN
 Bb+xjRWCDDm/shLZ3vD6mcM9Wk8lI73CxIzKdDVfqYop3tl7EFcC9Hxe1ZQMJYA3clUTX/T3CLF
 hblSDbv27ds5+cGyIiD1ReTLUcSelNjyUB/WX9j2eHp6mJ11b3Ts/5scbvG3W3ZOUROV3q5G/Bv
 vu8lB7kQw1rbPiTL+RcwMclVG57yRJtUf6qGTMCn4b/QGltBrt7gCCsQKIz+s1TGoVkrvntrMYq
 WrJgyV8kchrYwdPXcZUsgY9VTN9sbfptxaJh1zXVoW/PaljeFDR/mj7vg9Lr9R6God6SqmxKDgy
 qeClsm2Q06i7LaQeXCr0zd0OKLeh1Hjnc92dBSSQBtd78oV40GTjU1y0Wm8rtuBPtt9RpfjUjZF
 nPPKk7iKbbRDTbOHk7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290119
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
	TAGGED_FROM(0.00)[bounces-302680-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:esteuwu@proton.me,m:andersson@kernel.org,m:konradybcio@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:elder@kernel.org,m:linux-arm-msm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 083506DC12D

On 6/24/26 3:52 AM, Esteban Urrutia wrote:
> On 6/23/26 5:37 AM, Konrad Dybcio wrote:
>> size = 0xb0000 for the RAM and uC regions that the driver seems
>> to poke at (at a glance anyway..)
> 
> Sorry, I don't quite understand. Could you please clarify?

Please alter the size of the register range that I mentioned this under,
as the range is wider than what you specified - the driver takes a big
offset from this base and accesses far outside the bounds of that range

Konrad

