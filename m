Return-Path: <netdev+bounces-296101-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JjrwK5wHJGrz1wEAu9opvQ
	(envelope-from <netdev+bounces-296101-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 13:42:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B5B64D42B
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 13:42:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=NscwdcSG;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=PLsByZ09;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296101-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296101-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 088723017074
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 11:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAAD39734D;
	Sat,  6 Jun 2026 11:42:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CD439184E
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 11:42:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780746136; cv=none; b=iC6AKIaMw2OxUcTgYJuQXyYhlj53Y49wwJft/vmYIq639OkSfFvxPfF6r7trPIFQ1HRXb4PArlKyQMh/2q1XIdO50c2i770tYNc3akT6UvQLY0okBkFnhL4CpKxjmyJV1JLuZkmWvGf8SvigVgyilh5as4Dk9exP+KVMEcUyxT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780746136; c=relaxed/simple;
	bh=+6QUERHgEfhXYcAYNZDxqv4pAxoO5U7KVL8vYrGMq4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYGf4ZyNykJWjMo3f1R4vhdU56sdqVWYeh2PL4oDJG/W2pgP0FKPBIDiFjuXQ9xqhrN8aV/66vA0Pk7Y2ETnYpDW+DabDy4c3nP4IPvcKIGL1CjfDs4hxREV7NkG8XICMZ16iRNxxl5I4WKW9OucJd1Dq7yNXvjvdvoGT7cck5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NscwdcSG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PLsByZ09; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 656BIeXv1325849
	for <netdev@vger.kernel.org>; Sat, 6 Jun 2026 11:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=jThlbYq9gcNtv4SDC2gxLb3F
	Rc4MdnuJPfMHyFkkw34=; b=NscwdcSGNie0XO42RiR0owSD+O88UwbWxa7bkdPK
	zR61tcy3fxxN6FveCCJaouZWxMhLTI+cVotWnkwiH39kX6U3Cb+ihu2OJuXnkh2O
	xOhm9og/T6bnKh3GnKq6lG0sbirf6vMDmrx8ZrjwEuOrrumiMg5CTP9z76Q0xf6A
	e4oEoR6NjiZMR4ERcAOZZDBDzo+IM/PhbynO76fG1WzDhzxOzLEHtLGvhWuIk9H6
	rCx0c9b/EFaqVEbOw0isNaxpx9Bs253dvOO9IHlwgpZzXKDacWdrehGJSQYReIZV
	/GAeqggm5Rl6EcYQ7Q6/Zyhk+ol41xCIMYHpSKyB9q9HFQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emaj4s7fc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 11:42:14 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6cfd2a26ab0so1292772137.2
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 04:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780746133; x=1781350933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jThlbYq9gcNtv4SDC2gxLb3FRc4MdnuJPfMHyFkkw34=;
        b=PLsByZ096ZZTDMpkhC4Qiu0oAHNOsE+SwvP+zIOX/NH9dDLsKIhKox++Tgca/1x7PP
         R2DL+Yvgbjcv0WmIYYFf1/voS6tRn77ur03U2Y2MXvHpWs0TW7wqbNDrOT7r0LvMBipk
         OC1KFPi+RmReF1JyB86PaGQT7Yp9cWFZRRN6wIlgEwgXGRVP+4V3c0jOcYiiWQUJ+huB
         ALIa7BvFg93K/v0ReEJBBD+lVQn4EPF5/TRfclfhriC+PM8ZGHghWtWWBmqGmzfm72ha
         8pOqIsPXHP8PMH68HTcWxvhE/bsifTZHZYf7vkFfbQCQZxSPb2ugBLPA4xw5KY45O6G7
         3kEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780746133; x=1781350933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jThlbYq9gcNtv4SDC2gxLb3FRc4MdnuJPfMHyFkkw34=;
        b=LwjdSz/kYYF/l6chPfdj983THPDQz8VNOqibAxbUdSALX0hQMhr1LlDmMKOifwpnO6
         CoobzEnEYEUawEgKmkt69pmdxBvfOkza+isHXAxeQ1fIL9LaRslOnMXukwHbY0aH9tOK
         FD6bt6x7o2g9+mdQuJazzJup4nmmeQqvmUW7MGyeAA3iUVPpJRKFo1Ji2m7BXS1PcXtS
         9EspyXXHc+kWpELr2A8nxr54Q8xoU8WkJUU4Si4vB0SenJX6y6VF5j4IoJrcWVYjBnTM
         OIiDusibfziQtrKUYhCquzN3Tg6tLVeYOgSjOLc+SJ2Ud+y8o0tN1yP2I+8U7nHpHhu/
         FEPQ==
X-Forwarded-Encrypted: i=1; AFNElJ+KtbnZq4LRvC/6cOKcXI43paKnmr9qDLOQiu0/r+NP3yIdWFFu5yd9XRoKlVXnqo5NwSCRmyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA1zgU12NdOi9nmQWUBA2kP/Ke9fCjc2HM+hHeAHx7rBna1yrs
	np7TeEZQAVhyhUmD+fGMYKqoSBDtYIdORMhkLI78s9aS3NW1zNDN9PRsQlXg9Xc6vLr1qdDKf3O
	BDSFVV63PD3AH7yAaVaXMIW+qOWWYsvdlP6kbHDdPNJebpJGXSo58XbXfrGA=
X-Gm-Gg: Acq92OF0kMjlUtDyfcqvZPWCf5meBW28wnIvfAKPGHBtWC5qsSgQ3ld2Yh6rhXeQwuh
	03rqUBEqGfF8QGZPBSyHCiESL+mNOezT3zTbdAsx9CTftwQ1+HWfpGOnJrV8xlHMJlPypyv0onR
	mqfkM0NFTC34J8Vzo5RIk2U2zVdL8D9+1VBk9kgtUif46Vh5ZDVXVErVUJemEb8ynG4Mx3NOJNU
	cw5HvZBbk57+TxMgKVS8gXfqZv1nQ4F0r6V7GQzBe6RENXI3HoIUeWHkJ1cTciO0tj9s98+3CwT
	Izp6B29/QXXpFcBTSl5M+EOG6PAyz82wfrOijxHza/4rvhIy84yVJEJqcBDTz4bEdhv34NlhGSV
	Ah9/fQ7LFcUTBe7llX0bbIq9fisFDez6jp25GHzi1ZTkq4M7pyk3b/tdufQEknEFnZXG88JWdkn
	/RuY48vjwXBZbfO6ox0tREVLHlCECo4G6aQ5jhPVssaKeFSQ==
X-Received: by 2002:a05:6102:f98:b0:6a2:cf9a:9221 with SMTP id ada2fe7eead31-6ff04530fdfmr4223234137.20.1780746133430;
        Sat, 06 Jun 2026 04:42:13 -0700 (PDT)
X-Received: by 2002:a05:6102:f98:b0:6a2:cf9a:9221 with SMTP id ada2fe7eead31-6ff04530fdfmr4223214137.20.1780746133041;
        Sat, 06 Jun 2026 04:42:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b990d37sm2436994e87.70.2026.06.06.04.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 04:42:11 -0700 (PDT)
Date: Sat, 6 Jun 2026 14:42:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Imran Shaik <imran.shaik@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Brian Masney <bmasney@redhat.com>,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 4/4] clk: qcom: Add Global clock controller support on
 Qualcomm Shikra SoC
Message-ID: <gvqubjzscwvq4nmerwptrnojrui26ymigzs3mo5yqordyfsnx5@zxtjhsntbrcw>
References: <20260605-shikra-gcc-rpmcc-clks-v4-0-a0a7bfb44455@oss.qualcomm.com>
 <20260605-shikra-gcc-rpmcc-clks-v4-4-a0a7bfb44455@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605-shikra-gcc-rpmcc-clks-v4-4-a0a7bfb44455@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: _Q4PfL9MonxDbuXU33cD9M8b4JL8s7Q7
X-Proofpoint-GUID: _Q4PfL9MonxDbuXU33cD9M8b4JL8s7Q7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDExNiBTYWx0ZWRfX2eDa0A+xRIf6
 ztUrKHxqAm260XjnxFag8N2eE4wprS3OCU4JAAW4oq0dP4IxekpgQzMTEag0qtX1/SMfJubvoKm
 +XI+IaaT7JERI9m6VUv+ue9NQypQXeUnTyWkSduuS0T5XJ65zhdifBDRJ4A2W4I2fOVU/HjFxCG
 lOfnGzDwH6bJCDaVqAvvdsymI4WouLml29YC0nfPq9xmbN3UGuQ/g+BXRQs7lMxSa8YMQMtvThC
 cYtABRI2jm40RMNv569vj12bI9vHJe6fRTDTx3qeV8/bAPkmd8o+0AoT7h/YalfImT8sATr6B6u
 r5Jb6y7MleG9wTzzm3Dv4RKqtWI8aVarLyoLVlsq0SSaVWzPO4Xrf0PMU72cYnAR2cczZi9JKCK
 aQ8225TZT8SbgPcv2Zmwveq299cO4NCtlHQinR9/sqsoVbmuq1RU0+A/M82f6ITx46u1yQ6SUjE
 aMQI08VD6A7+PQHcdiA==
X-Authority-Analysis: v=2.4 cv=TLh1jVla c=1 sm=1 tr=0 ts=6a240796 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=qXpo7wsCot1G_wR8kq4A:9 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060116
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296101-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:imran.shaik@oss.qualcomm.com,m:andersson@kernel.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:richardcochran@gmail.com,m:bmasney@redhat.com,m:ajit.pandey@oss.qualcomm.com,m:taniya.das@oss.qualcomm.com,m:jagadeesh.kona@oss.qualcomm.com,m:krzk@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dmitry.baryshkov@oss.qualcomm.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[kernel.org,baylibre.com,gmail.com,redhat.com,oss.qualcomm.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 24B5B64D42B

On Fri, Jun 05, 2026 at 04:49:14PM +0530, Imran Shaik wrote:
> Add support for Global clock controller (GCC) on Qualcomm Shikra SoC.
> 
> Reviewed-by: Taniya Das <taniya.das@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

I know that I've r-b'd the patch. But then I also compared GCC on Shikra
and Agatti. Is there a chance we can merge those?

> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/Kconfig      |   10 +
>  drivers/clk/qcom/Makefile     |    1 +
>  drivers/clk/qcom/gcc-shikra.c | 4431 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 4442 insertions(+)
> 

-- 
With best wishes
Dmitry

