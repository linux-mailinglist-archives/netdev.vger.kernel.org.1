Return-Path: <netdev+bounces-298033-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NFaLMPCCKmrmrQMAu9opvQ
	(envelope-from <netdev+bounces-298033-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:42:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCAC670822
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:42:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=BGMq06E3;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=HqORIbJc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298033-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298033-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACE8F3052FD7
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF713BCD0D;
	Thu, 11 Jun 2026 09:40:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE513451D6
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:40:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781170852; cv=none; b=WIkbC50wYcV0p66jp1egmSRHvzfZfuk6IJHztmef8V0wZUL90UP1OALHjqam+gUmM2aaBk0wHtXM0b4N6W0AbKpzguyjas34g71eQ9gEzU9ROSQzqwi59EzbxnINKRNK7zGQQ9yljWSDVpD/0AtP2dPkDPs1NWKCRWNbV8YrVYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781170852; c=relaxed/simple;
	bh=/tPLp0YnAEbzNEjlPFUBlDrqdFYNHeb+WcToziZLGSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GNS3GL2BGVrU1PlAgGs2pR03gUNj2nEXA3zoXgRAEUc7eswDfe9JKYAePpTKA1hS94LZWp24xxnmm8jT9EXJBtTmvgFc0JL0lSROFeIPgcVcZDG4A7wY/T9wK7UkpNO3FzRdgPj9UBLg10BS5U+8oCKdoxhuV2jKok93QCkBIRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BGMq06E3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HqORIbJc; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B9Mbe4215608
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nKcvGnq/VpeslsAPlHl1255rnIM6NR1gO7P4RmE+qE4=; b=BGMq06E3/iit69Oc
	hkkdp21erXxDRMwzvyQJ0zUx60JcLRhrbh+Rch81CF/m+0Nu6/YVhp0RyrWF6ntZ
	lT+nSbCMrPurgIrKgfoSkNBLhXZad/QcYGp5C1lpCVZrpSBGupvOJsIeXibGGlAP
	OP2vKfLkkf/3MiZl/RKZTuFrET/EUYUANxn2FhRkYpnM4lk9eOOv07mELtLoErHm
	So1E/2tkPeP5y+fmNxbaJy+h9cMA6IWAaI5gZyrxBs2gTbHiilt/hHkyZZurzSXW
	2nYjgwzPVotWRwW5SIpzgTthMDQnl4Fw6UMuvW8e365KnDhwinsQg98QKoh2QWVa
	WXFLhA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqtb5g2fa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:40:50 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51768e1d798so19772761cf.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 02:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781170849; x=1781775649; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nKcvGnq/VpeslsAPlHl1255rnIM6NR1gO7P4RmE+qE4=;
        b=HqORIbJcn0cEwmHlh3fSD7V8tqwKCLjVmk/XdORU/uuh5Gm0y+Khk3/EuzLqLfTTSp
         Alo+aDB3copLMBIP/KxiCdx5IaugUzLAV1izrGu2NlZZdPohKjCH5tegmc0nxWkeAkxe
         XKY+2Sgo+o45z4SQXdDr0SatrPFle8Y2qzThM+c3PWT3QXmfG+2rmj3QW2ifFtY4tGi7
         DV2eXe0TwSPetj/9FxW56BJs07Rj6jwCOTcaFvcqW2TKx8IOpkHrilcddBoRuIDYiYav
         WgTpcwdfmyYO0VcO2GvKkDhu0Prb5qx+oIZlrv0/rhPwCk4b8NiQAGOedbKpmCejZ8hN
         4qUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781170849; x=1781775649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nKcvGnq/VpeslsAPlHl1255rnIM6NR1gO7P4RmE+qE4=;
        b=l0LPrDLufIlBQLAhVU28PKyIN4Svt8ZXk8Km6xQDkYlqwqU6I1nXAKgwUTPOUKbCQQ
         FY5gaVJri8ZZqL3zyoUmVVtiR3mqgBbdLpEQ4AePzuCbRMZRa9PXr8Av8Hmr9dEFbxkX
         PINjwT2oaA5TYiL8aC48YpPvERP7L8I1wdAqh4mxiPX4pcgETFM0SCPlfRyx+k3QiUKY
         DAdXPG9pm5JolNcRVRK6q5kzKPaiTRsRWoR4gH5NfPyw2XVjDllvar32usIK4LnUMtDf
         17C/Az7OuJyImwDxvK4KV2FTpbKJ5EDSp/TfyCyWHZwNTfjEzL7i5WXlRnnfAAH5JJ5E
         a4MQ==
X-Forwarded-Encrypted: i=1; AFNElJ8uhRwA8C+HYeddW85IaAa6Ds9CzZ2qxj1FbVyCwcQsZu50gBleQpcc7naIoBrz1Kzr2oqp8Qk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyos0sVJ7HgLfibQ15OpAL2QgouAxETbYtEGto/OHQHqtwRrJuq
	BVIpI43CDxi/N0/7JYj8+RfnFGXKmIqFgPisLocX49Ym54EkhapkppXLkhWmX2kjmB+yJ1ODlJ3
	bZFnGUJPOX2cZIJGx6YBiu2LOFqL4c613piU1JN7gvSUt4XEZgK23wc/Q33g=
X-Gm-Gg: Acq92OEu3HcqOV41LjyVRbt04EFBNg0bnMlSXQnBak7Cx1VnqTG0eoi6piVnV1HVzMZ
	8kJPZHvVAmSIaDo0aFBb2pJ/OQpZBIYzadu1hvG3L8jlAAIJfvL0SxZ04KHtw+g/wESi2XD5Gf0
	4JkhpdUy3L1DlUpmT8ezwinhqfI8dwF8vEWUVe7/1N0roQ/hRNoClkad0RM8QhHVU4Fz2ZUg/qZ
	dgxAOIdQMWX9ItSPE3Qn6aNULRiBR0ygzPtXqX3fGQze4eiwUJCEtsm3dETcq0KTGcSEiz2nsdt
	NKjQUYIG96Zatdn9AM6Uv9ZZul9PHrzeJEhCW9K4YDifSmJpDJ3NJiDlljhoR0SsrRgOsILSfqN
	g2/McDPxhrg62trQysrFZx8gdWHKWEZUHEMQoT5CB4aTvj7HUJoSkTeK9
X-Received: by 2002:a05:622a:4d86:b0:509:39b5:a977 with SMTP id d75a77b69052e-517ee225ff3mr19651171cf.5.1781170849385;
        Thu, 11 Jun 2026 02:40:49 -0700 (PDT)
X-Received: by 2002:a05:622a:4d86:b0:509:39b5:a977 with SMTP id d75a77b69052e-517ee225ff3mr19650901cf.5.1781170848859;
        Thu, 11 Jun 2026 02:40:48 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfcb0f1478csm41082666b.8.2026.06.11.02.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 02:40:47 -0700 (PDT)
Message-ID: <b86e9f5f-a7ec-489e-829e-6e07c62841a3@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 11:40:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] clk: qcom: smd-rpm: Add missing RF_CLK1/RF_CLK2
 clocks support on Agatti
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
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260608-shikra-gcc-rpmcc-clks-v5-0-94cefe092ee3@oss.qualcomm.com>
 <20260608-shikra-gcc-rpmcc-clks-v5-3-94cefe092ee3@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260608-shikra-gcc-rpmcc-clks-v5-3-94cefe092ee3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA5NiBTYWx0ZWRfX9fcvJbmlBYc+
 wITV5deXGHx+eQBXy+eXNuCKtO1Nwa/RkKBltE8/91RTnhRvJBREB/YV9AyiMH9w/vXOcflE6l6
 hMaZFkFWVBS0ER+GbjZ43JA3wm9P5AIgJZ/xFgIXN0ElCFPmJi/TI1g81HGm3HicBRPONHEIaKt
 4Da3GabfEoJSHsda3VZyzonFhcBeFovxlp7Yo5Ulh2mduX1UxfO42XZU2cM5z8apKz7v2WmLrwu
 LnCvuFwMp9Nu7duAUqT9nEPeZTuU7iCUf0oprzpusvaCgl/Gasi05nZVYmHM7niIowSGuW9blau
 XM3Ozdt9yeNKCU5U3ycZC2N8S4PiYXWDXLUv2tYhMLT9sD/9852Zj3nf0pv7KjkPKlAW0bhCWvo
 OD2hstRiEkAuwX+5KccoJY8Z8vvUdQ6sIlXojoahbOT9HuKxpIUwl4Tcjqgk4rmhMRWo0WKsiON
 hhUMwDcDFi1mvdaO0pw==
X-Proofpoint-ORIG-GUID: Y1rjA6nmsUTGPk0Psw-517mxDNyOlPud
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA5NiBTYWx0ZWRfX/59A71qnYUpN
 n1kKpDoCZb/R23+/AkZ+mjygasxwnV17uovNN/pgPy2NN1GA+ccyDfhTjjphbbm1HdD/CAwyuiJ
 SXqj5Nfnb5VL3fjXzTJ+muL2HOSeXgM=
X-Authority-Analysis: v=2.4 cv=e6g2j6p/ c=1 sm=1 tr=0 ts=6a2a82a2 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=NxhCX_73iKeGXg_BdwEA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: Y1rjA6nmsUTGPk0Psw-517mxDNyOlPud
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110096
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
	TAGGED_FROM(0.00)[bounces-298033-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,baylibre.com,gmail.com,redhat.com];
	FORGED_RECIPIENTS(0.00)[m:imran.shaik@oss.qualcomm.com,m:andersson@kernel.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:richardcochran@gmail.com,m:bmasney@redhat.com,m:ajit.pandey@oss.qualcomm.com,m:taniya.das@oss.qualcomm.com,m:jagadeesh.kona@oss.qualcomm.com,m:krzk@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 1DCAC670822

On 6/8/26 2:21 PM, Imran Shaik wrote:
> Add support for missing RF_CLK1/RF_CLK2 clocks on Qualcomm Agatti (QCM2290)
> SoC.
> 
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/clk-smd-rpm.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
> index 103db984a40b950bd33fba668a292be46af6326e..0b624ed4715c75042b92ec49c073b281533cace4 100644
> --- a/drivers/clk/qcom/clk-smd-rpm.c
> +++ b/drivers/clk/qcom/clk-smd-rpm.c
> @@ -495,6 +495,7 @@ DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(rf_clk2, 5, 19200000);
>  DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(rf_clk3, 6, 19200000);
>  DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(ln_bb_clk, 8, 19200000);
>  
> +DEFINE_CLK_SMD_RPM_XO_BUFFER_PREFIX(38m4_, rf_clk2, 5, 38400000);
>  DEFINE_CLK_SMD_RPM_XO_BUFFER_PREFIX(38m4_, rf_clk3, 6, 38400000);
>  
>  DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(cxo_d0, 1, 19200000);
> @@ -1262,6 +1263,10 @@ static struct clk_smd_rpm *qcm2290_clks[] = {
>  	[RPM_SMD_QDSS_A_CLK] = &clk_smd_rpm_branch_qdss_a_clk,
>  	[RPM_SMD_LN_BB_CLK2] = &clk_smd_rpm_ln_bb_clk2,
>  	[RPM_SMD_LN_BB_CLK2_A] = &clk_smd_rpm_ln_bb_clk2_a,
> +	[RPM_SMD_RF_CLK1] = &clk_smd_rpm_rf_clk1,
> +	[RPM_SMD_RF_CLK1_A] = &clk_smd_rpm_rf_clk1_a,

Is RF_CLK1 19.2 MHz (with the other RFCLKs being 38.4) on purpose?

Konrad

