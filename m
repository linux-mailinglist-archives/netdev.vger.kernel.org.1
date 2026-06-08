Return-Path: <netdev+bounces-296362-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bXTcHwtGJmrWUAIAu9opvQ
	(envelope-from <netdev+bounces-296362-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 06:33:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE1965299C
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 06:33:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=ZzDDMjgz;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="jxIlsR/2";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296362-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296362-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B2753002B3C
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 04:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA4C34A79D;
	Mon,  8 Jun 2026 04:33:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326212BE63F
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 04:33:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780893192; cv=none; b=b5CsBpI5TARWFamIJ9nRrein3ZKk1fH0GgmBNdJ1xU/TFdkzJfQrZg36gPCHotYCYdDWolf4WgU+/CAv2riHKhsAeufle8RJ2jTKV4jwRnfjYi92umjQWGBdFBOu5azsmAq+jqWk/FCuQHB31pqA10h4yM/td5kEm32rcHFS2vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780893192; c=relaxed/simple;
	bh=Qg987VOi0figFES5kOeFOQWN8LtqPBmVnc6ae66gcZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sGaUYUjB/e1ENNOVqR3CwO/jzOwTjBTWh95TrgCpGII8bxBsI0p66RmPQ4GC1LlA+Fe3pTsmsRaZdnxdktkqdq6GUg77Ahrp11O3VMpakJrDE7+di344bLX3Hnss1k26giiP2Us2juCdm3jy8VqDsoYKZ5syZuf+4xrMj4fXObA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZzDDMjgz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jxIlsR/2; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6580EVNG1575805
	for <netdev@vger.kernel.org>; Mon, 8 Jun 2026 04:33:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NaJITyHv9S/d+drDLgvU4Z+GSyOoUsVk5p/NMfCm5YE=; b=ZzDDMjgzI/oBj4+u
	vn5igPSFmnLIOBt//k110hYmNhb0prPuqOnKcTyB2wj+Mb91bJfCIjcqv6Zlao9V
	tG7lN6uQQMW+kS4TWe3L5jRUzNTJc8ZZ0E9JIkFiyTGJTK36yEi8pL99gm+nx8hT
	f3xpDyiT5Mqahyrb59n6zE1OeiMaNrH7Ehuit5c5jJA3Z3weZI0S9Q49iww0eGSM
	CETX/zsaSUiGD7eE10ONpHBKi2GUXtJC3WINu8ui/gOl6zZ4kQuIGNFIcYK8n6R2
	YiqR13R2VxGPkqhV4pdEV5J66vEICNG5p3CEbsfBX/XHLIBbhyi7Do52gQhKgB+a
	/dK6Qw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embs1dnx6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 04:33:10 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-842b0dd8107so2013160b3a.0
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 21:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780893190; x=1781497990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NaJITyHv9S/d+drDLgvU4Z+GSyOoUsVk5p/NMfCm5YE=;
        b=jxIlsR/2SLeiSG1L5foT5nnKH3sT8zcuFQ5EurO2b15zUXcN+8agc68rbyV7E+aePg
         sG33KSIWpPQ9pFG/deb9ARtNW0eJtC++SD+nnsZWkslx7eXcEYDVtcBVtZg0iB1UCvJ+
         pBVaxIIgUsm/ggvgbuCKIABNfWMwhMR+nUq7+9XyKlcuslyz1TECmO0fhF6DbrDzGnVu
         ystqQ9mQJQyFB80R6B/fkaMQzd+NGK4YPiawZPWW/lCVhCr3n8cWNdYRSCcU8aAMk6rG
         eikMKqnNY3ZeJeRBMlVtoQL2+3xSiNzEtkYfMBUH6TwOGim2qfwrLBKBK9O0Dpy/RSHg
         zXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780893190; x=1781497990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NaJITyHv9S/d+drDLgvU4Z+GSyOoUsVk5p/NMfCm5YE=;
        b=MVIvHSxXV4HgUBVKMXTDZlczTP3ZiHRJuK/LIMKK+j+ScZ+3jUnxXxUT84S6m4dVJf
         mGmC6fohNT3Ru5rjOwQQCho4EAqUUS0+OWYLwl7wXVlbQu/OYud+gQcGfV5ygRl66scU
         PWBmUd7R7rxmks5zZpN1Oe1cUZGnmv/YwtDGSZk+BfGZk2FUZcXXoQX9wWAsRj7y2NCT
         yVtwL7RubDxX2VSsm0hT1M6p/y/pYpSLKT1up0fDrPUpNeQXZZoTGdVuIt896FK0QAGv
         SRVyYAE9vt2D7iCivvybbW1te2XF3ocg87dvqIAKo5PtZI5djW2mDy8pJyh5b/g1dqH4
         OA1Q==
X-Forwarded-Encrypted: i=1; AFNElJ/BRM6PWLCHY9Ez+Gd0TVxLdUUiDZMN3GXaAJC36bL4etK9vJW451Wm4wKlTnurwBA+pvCGEOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLZ3gR92gYCqnRuHgZUWSNHFh92xpt0UncWr6pABtDuk0aEzun
	FIZnczB7sSZCaR6i0JREfEMqr0nz3dYRjzoVuGNLr9NOo5BZBC8d895TkpY95h0OTk+GKa/+QSf
	nqtnzrA+0/YMYNXMtOHUk34ynhAaNWVScD9c+mon/e0KUcrD+UBx2vJ27SIE=
X-Gm-Gg: Acq92OEjYMyMov8D7RY4Quyed8PvSLDY4nR/i2jqG8xfW98+OB9RUE1y7N1YbE7RGcx
	7X+KgSfHWeUCIHRC/O1EkSG3lxMMpSPmzigBrHr8BmwcyK+iB/D7TrxGovEmtdHfMtPjtqxzwF9
	q45KotwpaQG6P7Y2KNLa8/4F/CQRkIj1v6+4ySVTt2Fv/o0wn96hCo/Y2q6E0SIgqKOZO8pYBk5
	QXEErniGwTttzPp8IDQJQ0dGSyFnZT41RImG1Jz8euY6tUgGWw3q/iHDkFX4HIQu2Xzjwmt1oGc
	1QUXwYg+EsK6/kF6XSwuyWVPuTaGslcu0ipbRpBivJj7vF2hCObWvEVkv1RCBj3PTDMOvJiIg6Q
	bvnwNbsBw7mXqSUI+HPMLBxThRTMdCM/6OvrizRxsT6g6hOU7a+iuqbk8qVg=
X-Received: by 2002:a05:6a00:2351:b0:835:3949:3c22 with SMTP id d2e1a72fcca58-842b0f52eefmr15287528b3a.27.1780893189747;
        Sun, 07 Jun 2026 21:33:09 -0700 (PDT)
X-Received: by 2002:a05:6a00:2351:b0:835:3949:3c22 with SMTP id d2e1a72fcca58-842b0f52eefmr15287493b3a.27.1780893189303;
        Sun, 07 Jun 2026 21:33:09 -0700 (PDT)
Received: from [10.218.5.114] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428221a7e9sm20631405b3a.11.2026.06.07.21.33.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2026 21:33:08 -0700 (PDT)
Message-ID: <a3d34087-528f-4543-81ba-8e7ee5d85aa3@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 10:02:59 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] clk: qcom: smd-rpm: Add support for RPM clocks on
 Qualcomm Shikra SoC
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Brian Masney <bmasney@redhat.com>,
        Ajit Pandey
 <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260605-shikra-gcc-rpmcc-clks-v4-0-a0a7bfb44455@oss.qualcomm.com>
 <20260605-shikra-gcc-rpmcc-clks-v4-3-a0a7bfb44455@oss.qualcomm.com>
 <2c4insgmqmpk6zothe54ktcdrzkjbbaiql5m3csagq74znnprj@4p4liju4xcii>
Content-Language: en-US
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
In-Reply-To: <2c4insgmqmpk6zothe54ktcdrzkjbbaiql5m3csagq74znnprj@4p4liju4xcii>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDAzOCBTYWx0ZWRfX1MD/lNV2VG3+
 9QKSHm9w27EFoCyiuvTO9kbb93HICpn0YI8lewL6ZD/gGIEsr3ez6G54xVWojTTvQ5vAxeOvyZ7
 JzBOxgdAm7rgO7sE7j6w9fcejF2KPbyxtAg5hDfPpXVdYYRCyNxJhyKCZS4I1HCkAsx4V6Dt6nn
 lfmLx+FsrfB/cpZSkLmYi54S7lTfVGWwZF1+Q1I5EL77vE7OY4hcybuLlfuzL/ICHirLhNggNFg
 gtF+SUGRgCqRvCXm6wVsYh/7sFtdFy988PP9E0uQvlVQ8wIILVvhEuzbnihopgzi58f5yLncEI9
 DEyB0UkipVCQa1WBagDp0LScM2JjmuIfOSUeBfct8fnfqUIr4w3FRwq97YDPTnYI+1IW45x4xlA
 2b8f9h2ExcEKwxhJ/1Wx/tv1iMd9/bbT7X+VNlYyJkaN9RhGg8RGJM0Hoa9X56w57cp9S/hCZOJ
 nZFElABReP2TIKrMAFg==
X-Authority-Analysis: v=2.4 cv=CeY4Irrl c=1 sm=1 tr=0 ts=6a264606 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=XXr5AoNkCxhS8z1Gjs4A:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: RNrSDd2YcFPJz2pRbubl7zW0D5dDN96G
X-Proofpoint-GUID: RNrSDd2YcFPJz2pRbubl7zW0D5dDN96G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080038
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-296362-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dmitry.baryshkov@oss.qualcomm.com,m:andersson@kernel.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:richardcochran@gmail.com,m:bmasney@redhat.com,m:ajit.pandey@oss.qualcomm.com,m:taniya.das@oss.qualcomm.com,m:jagadeesh.kona@oss.qualcomm.com,m:krzk@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:konrad.dybcio@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[imran.shaik@oss.qualcomm.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,baylibre.com,gmail.com,redhat.com,oss.qualcomm.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imran.shaik@oss.qualcomm.com,netdev@vger.kernel.org];
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
X-Rspamd-Queue-Id: 1BE1965299C



On 06-06-2026 05:05 pm, Dmitry Baryshkov wrote:
> On Fri, Jun 05, 2026 at 04:49:13PM +0530, Imran Shaik wrote:
>> Add support for RPM-managed clocks on Qualcomm Shikra SoC. The icc_clks
>> list is same as QCM2290, hence reuse the same for Shikra.
>>
>> Reviewed-by: Taniya Das <taniya.das@oss.qualcomm.com>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
>> ---
>>   drivers/clk/qcom/clk-smd-rpm.c | 39 +++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 39 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
>> index 103db984a40b950bd33fba668a292be46af6326e..d0d19bf0616efd5f1bc2caa037ff36d830a3495c 100644
>> --- a/drivers/clk/qcom/clk-smd-rpm.c
>> +++ b/drivers/clk/qcom/clk-smd-rpm.c
>> @@ -1289,6 +1289,44 @@ static const struct rpm_smd_clk_desc rpm_clk_qcm2290 = {
>>   	.num_icc_clks = ARRAY_SIZE(qcm2290_icc_clks)
>>   };
>>   
>> +static struct clk_smd_rpm *shikra_clks[] = {
>> +	[RPM_SMD_XO_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo,
>> +	[RPM_SMD_XO_A_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo_a,
>> +	[RPM_SMD_QDSS_CLK] = &clk_smd_rpm_branch_qdss_clk,
>> +	[RPM_SMD_QDSS_A_CLK] = &clk_smd_rpm_branch_qdss_a_clk,
>> +	[RPM_SMD_LN_BB_CLK2] = &clk_smd_rpm_ln_bb_clk2,
>> +	[RPM_SMD_LN_BB_CLK2_A] = &clk_smd_rpm_ln_bb_clk2_a,
>> +	[RPM_SMD_RF_CLK1] = &clk_smd_rpm_rf_clk1,
>> +	[RPM_SMD_RF_CLK1_A] = &clk_smd_rpm_rf_clk1_a,
>> +	[RPM_SMD_RF_CLK2] = &clk_smd_rpm_rf_clk2,
>> +	[RPM_SMD_RF_CLK2_A] = &clk_smd_rpm_rf_clk2_a,
> 
> Are there no RF_CLK1 / RF_CLK2 on Agatti? Or is that another omission
> during porting?
> 

The RF_CLK1 / RF_CLK2 are there on Agatti as well. I can add those 
clocks to Agatti clocks list, and update the rpmcc bindings for Shikra 
to use the Agatti compatible as fallback.

Thanks
Imran

>> +	[RPM_SMD_RF_CLK3] = &clk_smd_rpm_38m4_rf_clk3,
>> +	[RPM_SMD_RF_CLK3_A] = &clk_smd_rpm_38m4_rf_clk3_a,
> 


