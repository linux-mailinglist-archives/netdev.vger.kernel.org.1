Return-Path: <netdev+bounces-305405-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 04eoEi7XTGq0qgEAu9opvQ
	(envelope-from <netdev+bounces-305405-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 12:38:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B53C871A7CC
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 12:38:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=E7+je8WR;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=B0dWwVew;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305405-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305405-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FE6A30B61F0
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 10:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AA83ED3BF;
	Tue,  7 Jul 2026 10:35:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66D33ED3CD
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 10:35:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783420540; cv=none; b=LsanRoTczmFZe4TazizURPJ4LQZB5wZrDrbk39WD74cHZprYIEV+ex2eNJY7o3LOFp/RPBw2K/1ivLt/SdQOFIaTfcLTrVpnLuEjSWnnUEjk2Sv7u/yCvDgWm7mdOSc9xvnkLYixR4F6S6FsgJZwFQK7iBWwx23+rg3Nybezq+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783420540; c=relaxed/simple;
	bh=e+jx1Olfb73OVRo/4OTCtq8bSlJfSrGtv8Y7yUC7jgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GpQG0DeiPfk+V2+Vq7ZmZ1rhIeC+g+5/kh19EVtdDU9J5KIcl9W69+B5Vf2hzjdOtwEIryOk/PkTNRVaUDuc5TmGN/z/5AppPBwqgj0hpepEpi0yF3p8nf/6MGEzalEDErFH6hF1duaqyZHLhUhN1TbNlUc4Cdup54LHaO8Fl8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E7+je8WR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B0dWwVew; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6678E8A13209957
	for <netdev@vger.kernel.org>; Tue, 7 Jul 2026 10:35:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0ZZXOlcWQScQLLTqcRXN9MyJOLc7Vq6eYSI7gxmCWkk=; b=E7+je8WRR7JqTH/b
	o6QnzVPjEmM+cgpfCOXGu49SxxN7222NGTrjLIaFxUXVAJZoNaWf4qpb8+AGGTiP
	hD81CsO+PGMilx2cdu7vG3fK6/G45mdmjEyMqeCYuzMaVk4T08j1cMyEWTHV3OMs
	ecaLqDiqvioircj+ElLrGum36CzWvInjT92pCcS5KdlKm03zq4cOhHsnb9xTX2k/
	p0yLkJLPRO1h4aQ8TwpVgiHlFu+wGhNfbqR+F+SpEwHVN5AVFRrw4c3G1zd3Ml4l
	IuR9352/OvmjG3yY9s5Qd4iMCwmF/NOipmYGV8fotkrzGmn1ll2/KhtQnGhCVdBr
	ODNrHA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8vdj8xc4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 10:35:37 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c08e9c344so15881381cf.3
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 03:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783420537; x=1784025337; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0ZZXOlcWQScQLLTqcRXN9MyJOLc7Vq6eYSI7gxmCWkk=;
        b=B0dWwVewebmwm2kmyiMjiutc3gVnW7IXVTqw9zDDRytp3QErX0e0doALhZc8c+uy3o
         6qdORJL8J5N20/kR/alZRMjHU9j8nOTs8lZeAcrKeU/wxdZrZOcO6bO0sKEP4GNgpX+t
         +FlaXY2vkx1MQKteGSguLfnHG8BpF6dYhSybQAxX8fH44crsZxODj88ru7jVDlyb7vy8
         Srob/tRrxjZOI+PDCgo3fM/lsK4Dp+mhj0GvmCum3KGJrQW/Adb+Yg7OwWo3pp4Kgsre
         h9QIaZvUsLT06eJeW1nhTlfLIQoEBnTomxp0cZ+jRlnppu+A77w+2D4/qJb5HDsBNBsf
         UK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783420537; x=1784025337;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ZZXOlcWQScQLLTqcRXN9MyJOLc7Vq6eYSI7gxmCWkk=;
        b=l0Z+QJBF6Z00UXx6bXbuQGKu4B0f5ydgqwGyGXOZQAdvFt9gWPLPaU7vSuWALE7yrL
         MjnXTbn5/UJ2qMXnv5AXbyCXrPiSqKxkcH5x8Jfy2KX/6Kljd+Z2lzwcSjlYIqgOP7gg
         GgxzLs1do9T1JOc/0+tS2nInUO9WKiTI0OWEus9j6pAWViKTuZv6+SrG+JBM++pN2Kki
         WlHKo9IlcOpD4BJl4floFO5PtO38tUWslXQclVTu4C9bXWOe46EkpWordtLVg7iz2PG9
         4eRXAe6rDDMBfv8IJj6Sgb9CiHKKVTBl1PUUrSdHiTNybADCyvyi6LHeD9H9QNYf91DM
         ukKA==
X-Forwarded-Encrypted: i=1; AHgh+RoDvSVSdCcqXUIfg1ZMGRA/pnKUgrutO1GH3ewhIJzgcLmSy+3bU+F6yVqPspW3s2c1hM9CWl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YygJ+UqsC0HBKKWsYFvtVtRhSsi1L/unr1MIZ/p/Kdx67X12EJ/
	D0cQWPeWabfEUrocQvsj2igahyMv7r48+iRvHd42tMvr2EgTW3zQGM4H92rrOuP2ASLkr4pgUoM
	CGHfKQ/QgnzTLiJUPh3WaHBMrxStSzkyLrlV8xIs9oQrH+iHj297oSrWVxVM=
X-Gm-Gg: AfdE7ck2U/C6hgMhCfaGxpVQENrVY0jFkggS6cVeqGbw95bBBxYyR5JKRfBUApr7Ltk
	J7ETTf+AK7dkKL6OHllQZiVhx5QZffw4Jp0+HlN0IIgJfQt58U2bXWh2j6abZRpCsDqYcC2Y/xz
	p1J/LcKVGfK+ZBS/6LgfdFSiscNrD4W26Zpjap4yx6BX4Jul+7mFFZbgBXxzNEPDg6YjI9aO/cS
	cGuZRETU7cxMUx1dRTazrXUquiqVV3lldgkBmyP1lpkoUl0nmrGQeNBUZx4hHv1IF9SCpwgNbDw
	hQ5/NZvOoWXyO8cFTzvVLdYTvXNSdNtur8rxrU57pqHCbXTN3FYARu0andB/zPCJfk5SRF16ajI
	VabPgnxGrDNjogofU6MwEnXEql8WoGJpczL8=
X-Received: by 2002:a05:622a:40d:b0:51c:9fa:bc2e with SMTP id d75a77b69052e-51c4bed6c6bmr126558911cf.10.1783420535136;
        Tue, 07 Jul 2026 03:35:35 -0700 (PDT)
X-Received: by 2002:a05:622a:40d:b0:51c:9fa:bc2e with SMTP id d75a77b69052e-51c4bed6c6bmr126558601cf.10.1783420534637;
        Tue, 07 Jul 2026 03:35:34 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15ada04d04sm102848566b.47.2026.07.07.03.35.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 03:35:33 -0700 (PDT)
Message-ID: <4afa8797-1cb1-4cf1-bdbd-9cb5725377b8@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 12:35:31 +0200
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
 <66330ed6-826a-431e-9e8e-f2998af55168@oss.qualcomm.com>
 <1e151b08-5d3b-4b75-8d71-635617868285@proton.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <1e151b08-5d3b-4b75-8d71-635617868285@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=R7cz39RX c=1 sm=1 tr=0 ts=6a4cd679 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=l5FYNS5t4BCBesUsx-IA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: V5qIuhiO-sZ6jnx_WeJLZKOe64DRUpo6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEwMiBTYWx0ZWRfXzIOKWfXBB7P5
 46cQk2EL1SbVZAZp9OCxYaQz+GQB4gAroq6hH8K+3oLqyb7DYaKGwflV/Co91rxL7eHglZ8Oz3Q
 tR0uW8KoOpjhTRrw3lKU9MANm2ZLKMTpKL749ij0Cx+4nyclDpzjfBQnR4Q8P0tuGyNP1C1WY5I
 S6bscJEMNn1OMwJOHh4iOOqfKKlQVKyJNrzHpDgc5cZpwMZ2yjFwLfTCkdSQhbmCOMlKRhyb3AZ
 +7/pQ26ZV75EsVwsPQhhb19v8SFGvtAnrQdeqWkm9c7LpGOF17a0dtVKJpUW/aw7XHBFohtIsJL
 IyISrCbBxBmOwAQX/LDF1HpnfoT2LUpzE9qxvNjavxtzxel9JyiSlBjCOD4rCu4W4+wIJlIFXUU
 R4BQjwfJwytFKKJTmulSjhdmQQNJVuX/kPDk6eLrmzPP+Qa4bcwnQF2D4gsm6gU0jzJgjYtHyIM
 1GIso99C0qKvsUrDMmA==
X-Proofpoint-ORIG-GUID: V5qIuhiO-sZ6jnx_WeJLZKOe64DRUpo6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEwMiBTYWx0ZWRfXydu73w24zBZb
 YedMoo/xItn2oDRcDA91rjW97UshRSBpCvlMxRw0sD/Cc1k4o7OsPvza9XKE70xenAYFqklhHB0
 ccIH5MtCXNIRKsAvXIMX3aQyKH5odR8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070102
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
	TAGGED_FROM(0.00)[bounces-305405-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:esteuwu@proton.me,m:andersson@kernel.org,m:konradybcio@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:elder@kernel.org,m:linux-arm-msm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: B53C871A7CC

On 6/30/26 3:57 AM, Esteban Urrutia wrote:
> On 6/29/26 10:18 AM, Konrad Dybcio wrote:
>> Please alter the size of the register range that I mentioned this under,
>> as the range is wider than what you specified - the driver takes a big
>> offset from this base and accesses far outside the bounds of that range
> Just to make sure:
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index dd151a2c48ec..100daf8120ce 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -2643,7 +2643,7 @@ ipa: ipa@3f40000 {
>                         compatible = "qcom,sm8450-ipa";
>  
>                         reg = <0 0x3f40000 0 0x10000>,
> -                             <0 0x3f50000 0 0x5000>,
> +                             <0 0x3f50000 0 0xb0000>,
>                               <0 0x3e04000 0 0xfc000>;
>                         reg-names = "ipa-reg",
>                                     "ipa-shared",
> 
> Is this what you're referring to?

Yes

Konrad

