Return-Path: <netdev+bounces-298090-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HKCuMuCYKmoMtQMAu9opvQ
	(envelope-from <netdev+bounces-298090-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 13:15:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 698D267135B
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 13:15:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=jnFP6fbn;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="PlAZi2z/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298090-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298090-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD6103010647
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E313DEFE7;
	Thu, 11 Jun 2026 11:15:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6440F3DD530
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 11:15:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781176540; cv=none; b=ufgZW2yPBPdx/wV9Yuc2Am3/XpMAtEOH30MdSF0n3lPGeCUZIkCYiHyBtiPcAlDt64RpdWg9wp5GLt6pxm6KESyRmzuLLpv+D1JQYjhH5Jg26YoYPfEG8rxeVkb/jRoIvLzscfbckpORB8oGGpwNQPokkLzU41HEThMpVSccCAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781176540; c=relaxed/simple;
	bh=laIREpsEBUXAPtTWdF7hMAJjEruMpnAQd2quvID9OoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CtTTjG1dbpNG1G819Qtdp5CVBiyYE9W4T4be91RZ1m8UWVyctikbxXv+FBofDV1nbeG0KAjhw5ZyrspRZpUTnS6V86FJv1A9pK/Cs1QsBluETI/V4ylNhRpLPlmSI1Uq8D3mJfbMaDOFNVOWEoA334VIUa1mVsRLDGw3rpYC/mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jnFP6fbn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PlAZi2z/; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BA0qAR303982
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 11:15:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5OCxphMzkt3Qxu9Ul81ai1QpDJoc03uf0INUKFrkEXs=; b=jnFP6fbnq/DOZqoj
	hUHohOcZ4dh/W1azTTALWMCBmmtIm15E6O0qiF3BkbIuIfCXnZ1v8tvW9qRvNx91
	QxNNbJXUVNXWO8BaK+c9chhUNgHoN9nD47B9eTr61hR4KztwO+spLVo6j0w5AqiZ
	lNwZnGHYhs7RTHfoL8IDzSm7pFUhEABw8ISIwOfJ7tw/k3wFLIdmD6C72vEOICVj
	aVikPQW07lZx9uT9CwA8U9QKUNPQSwat54GUtupfY65fbCVUqNfg28owqS9y6M80
	HS2eVrffVyH23w1wnxjdq2qD1l7nWRCXXyd8UVSts6Uvl3JNLLDWCg1qHBgB5GhO
	IK30eQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqtb5gdcv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 11:15:38 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51768e1d798so19973151cf.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 04:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781176538; x=1781781338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5OCxphMzkt3Qxu9Ul81ai1QpDJoc03uf0INUKFrkEXs=;
        b=PlAZi2z/vBySGa3SKTc/2W1m324XhnyRboPDrrIucGPQFOGKJxFrlrvfKRsRYoHtN8
         3UQuHYGdUm8vMPDtb3J+gYTJIrBwTd4XLMkFmNQwuZcbUZTiCz+E9Clw17Vg3JuEXDCX
         H1BAiOhcdnEkDYljSZHtwtdBQbtiY6OQ5j/pghGPgUfahql4vW3thZc180a/IMM1igPu
         osrdceUoPtYAot9jZ8hN1d2Ut30lb8p9yvCVOzWk8QzBqyFzyW84BeNdQmHmvXQCoydC
         VdJOBuXvPHUgEHT2j8B3UUf292Gq4Hly2zmpRv73JLoY/+U+L3xwvD0R83cqdivOW4LL
         Kkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781176538; x=1781781338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5OCxphMzkt3Qxu9Ul81ai1QpDJoc03uf0INUKFrkEXs=;
        b=MagUIvjKAMgtHGtvKHg+UwFmhjMLPmgNVVsjay3lx6zJ0QO/yGIPGfrzH1X8cCWPyQ
         aNg0YNS+5iAiVLV/SNQ/1F1hI0/NWqeRCALQ2y3JtibuUDPKMYZoM0U5ZVikQcTUyNSf
         sfwPlss9R/eibPw5GunqdkeYu2iDUO3qT6cCU4Tkwf6nBdb6noLV9h8pZ1svc0IZ9cSM
         riKkoL7qmPLWlfMFTppWO30K1NYl5XPWJrVu2XnXowDlOapL760VMgkzLZPPQWdnczTp
         0oL/G3GlBiIXg4tt3tBCtm5ScGxwOiqj5PBPseA7OOkwWe5BCwlC/PcFPtb6711XTi5W
         wvIg==
X-Forwarded-Encrypted: i=1; AFNElJ9ZMjjioOE4mPt7WjBoKPMFzEFoT66vp+ygR/h5SKNPEOC0BrOzRW+n5V4yJXo2DVZMadwHN6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEb8RwgVyQzKg+1xwljSjG+F0G8J6/mXMFpbFtHeJq9fuiJyPO
	oLse7W3Io1W1Na8vdZDvWz9E+3DkiIepOdv03BVCe60ogBIXP9pf57FqmOKFM7XNSL/0an71auv
	OFpDgwAtswRUC0VxbxTP3m2lKphyDyZoAMqGACAEJ91qwte/h3Lok9nAwZgqM0LXY6mU=
X-Gm-Gg: Acq92OEQ2eJJTkIldx+PUx2gS5PlILKVsn4CDHPYdTRecJ0lD49c3+xg7Y+im9IUpWM
	iMzrB2a8ZxlofXtr2fft6lOI77d3y4LR+fvnqX7VZzbtC2aEEy4Zi2PudjvpsvlBKmzY409uFPg
	Cp19VdQDXiRn8JUKSFa1iliAXUmM3PGptV0rQw5W06KwyD8BUD8QJLltwOi//ikJbTLZ3Q8yLna
	y9ELxhp7bpb3TYp9dwOt0jiMTbPwlU1vRFOnvW5GHGTSIc4ysE94Ck3VbsvYPke2RmtL+TOStY5
	w9PQAtq0AAIgaiItNWJojMLg6iXu2CUB1R/1gvmuB3Kv79Qf6mHv0kBHhpDZkdG+enSbhBcZIgb
	nFauBxpbniea6WvTb9NgZ3AfyNkN9x6rqa/P6BTDm4k8tZ+Z5yVm+TkbM
X-Received: by 2002:a05:622a:c2:b0:517:5e32:f3ac with SMTP id d75a77b69052e-517ed683227mr22907181cf.0.1781176537525;
        Thu, 11 Jun 2026 04:15:37 -0700 (PDT)
X-Received: by 2002:a05:622a:c2:b0:517:5e32:f3ac with SMTP id d75a77b69052e-517ed683227mr22906851cf.0.1781176536808;
        Thu, 11 Jun 2026 04:15:36 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6912faea64dsm6985810a12.19.2026.06.11.04.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 04:15:35 -0700 (PDT)
Message-ID: <72dc1255-a1cb-476a-bff9-a49d960e0277@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 13:15:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] clk: qcom: Add Global clock controller support on
 Qualcomm Shikra SoC
To: Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Brian Masney <bmasney@redhat.com>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260608-shikra-gcc-rpmcc-clks-v5-0-94cefe092ee3@oss.qualcomm.com>
 <20260608-shikra-gcc-rpmcc-clks-v5-4-94cefe092ee3@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260608-shikra-gcc-rpmcc-clks-v5-4-94cefe092ee3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDExMyBTYWx0ZWRfX54WX3pLTbw4R
 60mzGWwXEpDpomNJdlyI+ESo07mB4OBTAP/BUX/dfJUvRnS2HLHdDy3MQ+G3nB8/RuGRIbKTH3y
 v2VwowHGHMnu/aZxloWDAKsmHUY204KWZsmg917DYwsmldaqRvcalwCsxcGtXrSUjiAWeFR2nCY
 3WiE6raJBm6N/1f2vq6V5DEFt7oOmp9SCI3bB7XtHnuUnMoTuuxBj/dobJuVAfn4ZacIKIEal50
 I48uZwtzoA0CwEDAX/J8xl+DnkE4j103C8gjxnYsuZYDacWq5qC8n9wRC1vo0JpXKfsm3ii9Z7u
 Y96gcNiD/F+o6CMROgb5xaJEPh8w7qT4gPwBZifif5HZt0fE7zl3R0QGhsQHweCb1zz+U264Xrp
 6jCFSpzPYSYbKut3GCl0i+OgVd7JzGhd4ueYsHkzVt5XJ7/dx0YuLkYtE4fFR7St+91Vj4mC/+S
 AXwzh1RLlxkDkNCcnhA==
X-Proofpoint-ORIG-GUID: 9iKkMTdTS-12efvEwrFCjIe8P5goh2Ih
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDExMyBTYWx0ZWRfX7txA5K+84oFL
 SLF4XpLwUauEgYSIX72RND0eWGXH+mYR8NuEPeLJ5re+4N8jCEFWIz/UCABTxp0dicBz5EmhanO
 pecicTeJ9mkM3fqmoifCzyft7s8jt7o=
X-Authority-Analysis: v=2.4 cv=e6g2j6p/ c=1 sm=1 tr=0 ts=6a2a98da cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=IyfWUWnWmjsiacPjz4MA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 9iKkMTdTS-12efvEwrFCjIe8P5goh2Ih
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110113
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298090-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,baylibre.com,gmail.com,redhat.com];
	FORGED_RECIPIENTS(0.00)[m:imran.shaik@oss.qualcomm.com,m:andersson@kernel.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:richardcochran@gmail.com,m:bmasney@redhat.com,m:ajit.pandey@oss.qualcomm.com,m:taniya.das@oss.qualcomm.com,m:jagadeesh.kona@oss.qualcomm.com,m:krzk@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:dmitry.baryshkov@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
X-Rspamd-Queue-Id: 698D267135B

On 6/8/26 2:21 PM, Imran Shaik wrote:
> Add support for Global clock controller (GCC) on Qualcomm Shikra SoC.
> 
> Reviewed-by: Taniya Das <taniya.das@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

