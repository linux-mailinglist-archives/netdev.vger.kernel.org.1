Return-Path: <netdev+bounces-299418-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VgSeOrbsL2qHJAUAu9opvQ
	(envelope-from <netdev+bounces-299418-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:14:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6333A686107
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:14:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=YlKeDzal;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=GoxgShiZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299418-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299418-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79768302F4D2
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 12:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AE13E5EF1;
	Mon, 15 Jun 2026 12:13:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02963E5A04
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 12:13:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781525592; cv=none; b=UIztZb3BJ0Gws2jPeCNOX9wtuoZw0e3afC8v9LQ8q7G7Nxs1rUIVTr6jW1pBhtPh7OYVr0BYNhOEHY8bD7ihEQc42ZA+qKxy2+chh5fdNf6Ak/jjFnBafmNdNCrKzYpIrNnG6CkiEMm0rKuwuGUiNsqKtI3ta6y4nZzXsQZ8wUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781525592; c=relaxed/simple;
	bh=7Ys8Ti9grjinNverZO6LyDQbqQUeDGQ2rk/mpwJcIlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eH4890WnOCdSK5MKisuPwzdYWZLz/hTSd4jXbKrJDh67OzdsS2n0ANdzPD+2Z+1m2ZwaBRGQr3kWC7IjuRm3Y7dk29kK/3IUNbzzgeDkJTSsZEwwJt1MO48njONujqYvJKNXwWlxSKReYm3afmfWmr3jOOoGTi9bSJy0JWA+wrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YlKeDzal; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GoxgShiZ; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FAoKRW3983250
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 12:13:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6pmdA4NzH1jhT7/XCJQKYN+fSOrkQss8V4mYUPNsLc8=; b=YlKeDzalYkJqdoSe
	fGINnHiA8B1eAOMBeKM0mFKgS8Ze8pG9f4SrSLvvrdp3K57AXT/9H9fzje7Sglbu
	U33VTKhIujWwAUM6irCLHZhmnQQC7zusCQRDI63d2nlmn2j5TgguG5Lkw5Uok/Cm
	fgbvo8GZljUdavF2/2wbYpytbjei+Noe2L52oHgRaYABN0S6sL1LsyaqmGReCEo/
	GboBI9PwPM4kI+IkVMt/zH3ExF2EhfKNc3e1HnYAq3AFg2aJqs+r4jRQZ1H4e6y0
	sV+orMcgtuQwF1gec3r1yOnPJ3UDig5Ezp5+okw0S2cmOSx09wjGvXshWJqwYoXt
	Pak2fQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etfa70f5k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 12:13:11 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51759082206so9157421cf.3
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 05:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781525590; x=1782130390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6pmdA4NzH1jhT7/XCJQKYN+fSOrkQss8V4mYUPNsLc8=;
        b=GoxgShiZkOlXcEiHCZo1EewZd+iSJZQ9GW6Iiq8iRJwIVmXtv1sqEs9jxzvcl4gQzM
         J0uwcX5vJMjEyBNY7R7hS7Yn2kOSI6EtU42P25YU6rKUHCJEp0OpsmUuzHWTmg8gqHdN
         3RcFZP/QyvWK2Edywh7MfzVex2akjj8a4cSRXFUYn6QiwUzw3gRUm98Kn8SCCiWJEDbX
         qQt5eziSHlbp7D3S5YN8uKtb7csTHiWoBz71HxQ50ihSNR8V9rHv0R07jTcJ4SdTOMeu
         Twayu8ZASZdITBmFJOocbOoKrQWpC91La0givcn/JqJ8ELKN+nMW/yPAvcckvozSkLdu
         FNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781525590; x=1782130390;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6pmdA4NzH1jhT7/XCJQKYN+fSOrkQss8V4mYUPNsLc8=;
        b=UEvBYGKON/Vd1sy/O4zrrZtLC7No9LB6MJS1KFuviZc46o1GEUzRTbysb9J88yPWdh
         7xdWvIk1PvDQdO3V9kM3HGelAcXDX3E4fbJ5nrgMnrs1LHxpGJX4tIm2qyNfZSOjU3Mw
         mZQxgVk5e4O1PEOq9HCzmoekm8Z1rq9mV97EmVlvNYgRGf3q9YY0ZP5xCp9W4VReOM8K
         HAOMMxST6T1lylOTwIpBkv2y1tW176iYMp/5Ea9NQsx0/IGa+ELCRGdgegEK+ICwKXU1
         MjbME/B2i9VvGa8ipV4CXizePIFRPd57pFijNIgyVDnS7QI0Hok2mP3JDs/AZQ1GgadA
         SOSw==
X-Forwarded-Encrypted: i=1; AFNElJ94u7MwmoDs4wOuUNjcAdp9Z8KUFEMgshDFaKP859j6+xgMQY732lYxQg/3TZmtyxrH7j6JVUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmLh55PwV+crX/OXnm1Fp8voE+6qb084ut9Mrz7Bp/6rASaRd8
	4LzvC6kJte3rJ64KqUUQEipfDFUQsYwi6NajQHJkqHom85X4Q1uuWff/VjSXmc0y7U2umS8XgTk
	t1pALSDMx5zeRabGiDw4F/FYpBZVFm4Xw+7xnD17Rdxr+feyv/AQnMBbWvGs=
X-Gm-Gg: Acq92OHlrCV0/gG5oMDBFzWhjqp84mbxi02rtOp3keU9sQyENT7RvqaS5aCNc752fRQ
	PHV1xSwF9NHRm8nK6pj0aH1YxPwpPJ8xLPrYBUxu6jldEPr21tf2cyXT3wOSuDtlFV0OWfbpFI3
	iyOtpw1sGv9AivmS8re1fvh9KVj39nwyYM5meNrLn7sRFFEJ2VFi0jcOv32pW0CzNCXJX0Qk2Kl
	lAj5vdR3Skxxo1YUtKLqWEH8b0ZnBcfZU+2SrWwtPyfPs/6uSF4mPk0Qqmra3WpDJ9cJDB5lvGx
	uYydNvbGVXzqkuO9UykIR5GoJqqoj4BEj/XFxoH577arK63VvcPqRfwrAApVE3cNyoUAs69lfbk
	WubNz679cEfgARFEBPYlXhcgORqouYm/lV0Z2mWtV9pZxHg==
X-Received: by 2002:ac8:598e:0:b0:517:62f4:e3d1 with SMTP id d75a77b69052e-517fde8985amr129458381cf.2.1781525590130;
        Mon, 15 Jun 2026 05:13:10 -0700 (PDT)
X-Received: by 2002:ac8:598e:0:b0:517:62f4:e3d1 with SMTP id d75a77b69052e-517fde8985amr129458051cf.2.1781525589661;
        Mon, 15 Jun 2026 05:13:09 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb4423439sm459791666b.2.2026.06.15.05.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 05:13:08 -0700 (PDT)
Message-ID: <45d7faac-7c0f-4f89-808e-06129e8420e4@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 14:13:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/9] net: stmmac: qcom-ethqos: add per-platform NOC
 clock voting
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
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
        linux-arm-kernel@lists.infradead.org
References: <20260612-shikra_ethernet-v1-0-f0f4a1d19929@oss.qualcomm.com>
 <20260612-shikra_ethernet-v1-4-f0f4a1d19929@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260612-shikra_ethernet-v1-4-f0f4a1d19929@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: _qCnLHcolcu4RvAW7pXNFvXGQASlLQ_t
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEyOSBTYWx0ZWRfX7gsrzUymB8kj
 p+6pnEY9rDHD3GljiXGpYBKIa92UblX8wRbUXKlxHQ+HIburUabFgBNn2GvGBVPxIq1r3xEZz9L
 Gl4wozdvJKE204k9sFzQybseFjwqntU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEyOSBTYWx0ZWRfX3nL/95xVd/V3
 OAdyIy6T4Kdd7u8kFk6ZHyjUHFH08gasdOvxaVlo+zWY88GhbkAkCJjdaRhQ4gd3iX0hCTNngfD
 1Is1TeKAdu7V2nnhqtebhxzaz5/CM3h5nsMECq8qnhHy2s3GvxhkYCXW5UwXjIEF6JPyrI0mQqn
 6oytMzYAq6gEQ+TGHIVby3yFL42YQu0W1Qn39iMWMu+SHF6eUo0ZhdpXRHkA3rWzz01upCY+7bR
 CUflKU+fh7Pn+AQ34EfSEqgYlWyP8ug4ZHWDzV2RcjDiI+FZOipUwiS7MgSWTWLXvAL+QKuMpcE
 3VkAOzzbfyGaI5hQGTbaJqYOnbGEmwWLTRWc1OZw+7fLwRB9Q5uyY+Ac/v0Lk2ezQfhE4oe7kKa
 0paG4kocjd+8P0D8BbM2IFl4cj1dXKuFIG9bNeDiqDiTj5MWkCkLfLc42rV3C3m7cZR3kRF1Twr
 QGvHwlnH8nQMUidlThw==
X-Proofpoint-GUID: _qCnLHcolcu4RvAW7pXNFvXGQASlLQ_t
X-Authority-Analysis: v=2.4 cv=AN2yTM5Z c=1 sm=1 tr=0 ts=6a2fec57 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=dCDc4JseV86iyfNbYEQA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150129
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
	TAGGED_FROM(0.00)[bounces-299418-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:mohd.anwar@oss.qualcomm.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:richardcochran@gmail.com,m:andersson@kernel.org,m:konradybcio@kernel.org,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:linux@armlinux.org.uk,m:linux-arm-msm@vger.kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
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
X-Rspamd-Queue-Id: 6333A686107

On 6/11/26 8:37 PM, Mohd Ayaan Anwar wrote:
> Some SoCs gate the EMAC's path to the System NOC behind dedicated clocks
> that must be enabled before the DMA can reach memory.  Add
> ethqos_noc_clk_cfg and the corresponding fields in the driver-data and
> runtime structs so each compatible can declare its own set with per-clock
> rates.  The clocks are acquired during probe and enabled/disabled
> alongside the existing link clock in ethqos_clks_config().

Sounds like we should use an OPP table instead, we can't just do 
set_rate() on qcom, as that will not propagate the required perf
state to the clock controller's supplier power domain (i.e. VDDCX)

Konrad

