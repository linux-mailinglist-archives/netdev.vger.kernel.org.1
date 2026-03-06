Return-Path: <netdev+bounces-264864-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEcoD9f5qmmcZAEAu9opvQ
	(envelope-from <netdev+bounces-264864-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:59:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7DE22469A
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E5BA308E7EB
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 15:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D0E3B7B8B;
	Fri,  6 Mar 2026 15:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cEnu/OnA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kSKvvwhe"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A5933F581
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812153; cv=none; b=ML+n0gAIqly6Lw04pvwTGFmcPUq6pScSFrDIonDPFEjxy6Pi5XqF+FekOhA4NWt/Ck/pMWSabPVIHHKORtFng/4/+/XolnTfbDrEAGHkdr3jnhLcsbMhqjIG0H3PXwSRSXcTFiVhBSOGAI6ewMB1oW81fvzOuJMmlk05LYlRSho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812153; c=relaxed/simple;
	bh=HltvsgB/V32MMRgrH+wmQKGVLrI+i/tqgjQTY4Hm9Xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eLaFKMT1AOMqmzvFR0I250451KO4auf10ePqcQPb0cP0JeF8fJOJs9Jt5UVcI6YH38dp5Z/BHVw7mgk3ozg2P2v9sPhRDM56V8tqFZkZTbTDYn82wRWBxK0IUsuRFQotx3HuqX4kPRYa+/jA8404IaOFicTCGdmG8vdI/ZKUZDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cEnu/OnA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kSKvvwhe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626FT69J2522599
	for <netdev@vger.kernel.org>; Fri, 6 Mar 2026 15:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0/756cthtUIgOJKo1UJZNjKGTLA8f8YYmW1bpSBDIWY=; b=cEnu/OnAC1cBRLNl
	4oQ9YSwsZrvBAX9vdKjIs9IzdOxhYHFFQ0EAkTpagLjsb1DfxR5yMosUQ3mz5pDo
	S0lStsQEKOV0jFVu6gcYfnTboyaow+s2cJOaGYaQfpvaYF+RmDLZPh/Ec3Q4HHzL
	Z4ms2RHS4O9mHg1ZDJsSdiKGKAVEjPMiGp0rVjpjmHAvTmzI7XmKLHrZcEGy0R4O
	1Pn0H6H086qujpi/XmdmZdKzDTWEaQZJn0ctv0+8fOqWxpWuTHXaPT4sSIpbZi5c
	jEt096fLWsPp3uPV3vFuKCWSlMp0pyiUXcI3mQVepsO1b163WXom9joVA8/cXTl/
	cA1vHw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqfg6brt0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 15:49:11 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2be21146933so6740586eec.1
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 07:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772812151; x=1773416951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0/756cthtUIgOJKo1UJZNjKGTLA8f8YYmW1bpSBDIWY=;
        b=kSKvvwheaYCL5qs3+i5/BvfecewIjzCRavjPYMdGGQmXchcsbabCeuCIug4SFzfhPb
         Aud6seKfQKmfhB9N4mNo6/1aq3P+hcCJVOhXi9TROOZ1IWGxBL3c+bqzJwSajPlakodt
         qV5sQ1377h7TDQx8cAQrYQBLXnDPTM5D9Q5ObtQWH/XDgEmwz3xi7jjs+Q3p3pgf6xEF
         pQXAtlCgRc1fdac43qr1VFguXWsisLs7sw/XwowqDeXu3/i0O9ZQwgFNmCl8jEeqCdOr
         IETAKnCN19M6ZypPuQvOS9BI6laD1a52vU+VTcL2QPgZqd5yl8/vC5b1VMdPwe8Ev59/
         bU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772812151; x=1773416951;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/756cthtUIgOJKo1UJZNjKGTLA8f8YYmW1bpSBDIWY=;
        b=c+VYCzXRHd6r6ve0UawqZHE9MGrinoPvqn1h2Ti619eVo7hqTXHRZAaaeWtEIIZJAl
         2ycl1mngnJaKQJ7ZmiM58lqjaXloSnBlCUqvWGmpM2R4Wv94+7MmPw4vbYcphM8kiUr+
         lff9LkOnx/tAiFa10yuwLmmALDM+O8RQD7dOErIrF3w6rE19VK/H3FckNaSjHbJLSfdt
         bQZq+wh6YgHCwXq5ljymMsPwaWUexuZc1iuSUrCi9eIop3kDb7wrL1TtYzXgC0s4/l5r
         w5bFxbr2Z+BHtJbLLzthKOYmi8AhC6GvN+n8H62qlrO7L6hblXyntPiyvvBbcDcw9knz
         MRuA==
X-Forwarded-Encrypted: i=1; AJvYcCVT3q4LJGnDxad4LsxB0Kb3+457E2PqLQ6bClcUfYLjISvlyxQmMfzsou5/1fn5JW4YYofIB4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZw0sGYwH/8URjfyUnoL6u2HBQX+7o6xRsvElfoMbHEixE3mpI
	PA7N5zQetFzPrRS/zLdQo5bVLxhbOwZLdw3I5AZOzj+6w1A+2BebRYDB1+cCbZfhRSOJsN5mqLw
	cIejoyI1RNBf9/uF13QCZuqVxPMr2YwLE2uZgcqhneIrmgyfJHWl4+j2AF6A=
X-Gm-Gg: ATEYQzzP5lExfE88vtDxSr+X4cS1mssWERCnyHEfF5iURcuhF1Hda0e8VI7mRmUX+Yr
	XJydaF3yO8IRYX+yP2RWsTCJU9d81y94B1BfnYjIV7xCKl7onDxxn3bJ/PVA7AqGjwjn/VL/XTl
	e3zR9o8UJafAO0Npze+koR8npIUPYkqAglyMd0ETKtabk855uyGHtQ0QeF1ASdpn5gxpkXWXlZm
	FLV0/Q8f7wRWd2JBAr5BkQUMNH29x8+ofwPPPw7+wXGyIYRu2E2COZoigPrvsliwF+YMYPmMByp
	rHhH20acEY+zXGBCfWJ26UyFmhcFLUXH5lPgGvmPA2hnJPZh3DSNVpALc51kNkBXoVlvjXRneEV
	oFHCNPV6mx8cPPA5dQ8mr3V105hEm2HQbNskybaMSKFtkSXfCZb1JTLeBhFpdzJm1h9OS7RahRK
	irIqDW9AhAhT1o5A==
X-Received: by 2002:a05:7022:6898:b0:11b:e21e:5653 with SMTP id a92af1059eb24-128c2e0c967mr1056251c88.19.1772812150814;
        Fri, 06 Mar 2026 07:49:10 -0800 (PST)
X-Received: by 2002:a05:7022:6898:b0:11b:e21e:5653 with SMTP id a92af1059eb24-128c2e0c967mr1056220c88.19.1772812150163;
        Fri, 06 Mar 2026 07:49:10 -0800 (PST)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128c3f58d24sm1497977c88.12.2026.03.06.07.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 07:49:09 -0800 (PST)
Message-ID: <00a7e65d-aad3-4029-af51-ff0870e65595@oss.qualcomm.com>
Date: Fri, 6 Mar 2026 07:49:07 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] firmware: qcom: Add a generic PAS service
To: Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com,
        sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org,
        abhinav.kumar@linux.dev, jesszhan0024@gmail.com,
        marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
        vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com,
        bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
        mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com,
        mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
        jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
        vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260306105027.290375-1-sumit.garg@kernel.org>
 <20260306105027.290375-3-sumit.garg@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260306105027.290375-3-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: hhPtFDM7y4ujTZmguH1wfRV0-ZF9eBe_
X-Proofpoint-ORIG-GUID: hhPtFDM7y4ujTZmguH1wfRV0-ZF9eBe_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE0NiBTYWx0ZWRfX7eL58HZ3Q8dg
 sPee8lspbODPC9oO3Z4ql/J5rzi1JgokxWeSMoHuYRZKCfhOmtwdgaqZcEcWyY07axge/92f4iY
 wOK9mH6ZpKLrb3LoVcYO94xpFL8JCgOOS5R2QJyXck74CswocwAclqLjS4Rvp34TgXu0ywqhTET
 IwZZ06/n1L2v+HuqlDgiLiTversyRP6qLn0ONrjn9nqIHBnYzQ7w3iUMN2V9v+2hWMT8Zf7M6V7
 pnzxg/KTmZX6xh4FiLJP96Ugzqgctb+Lly2/Amc7CS80ahYO437ErnL1rYURB9jmU/ikacCt0d2
 fVsBZVK/1RH8erxpIAgnb0ZDY8t4OSFhSmQFyhxspIB0qzwvsSW0spzpGENBp/v0LkJ1yqevfHY
 i/vZhpo7P2DzlPrac1qyftI/sbqy4mv5dStN1wLAwWCeo3q2Tw5dzqmjh5f2tPL+yaJEqFSQ16W
 qC9sa1+DpMbc7wzHnWA==
X-Authority-Analysis: v=2.4 cv=XKg9iAhE c=1 sm=1 tr=0 ts=69aaf777 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=PJDN-9afRshu8rMoDvAA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060146
X-Rspamd-Queue-Id: 3F7DE22469A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	TAGGED_FROM(0.00)[bounces-264864-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/6/2026 2:50 AM, Sumit Garg wrote:

I missed one k-doc warning...

> +/**
> + * qcom_scm_pas_auth_and_reset() - Authenticate the given peripheral firmware

s/scm_//

Warning: drivers/firmware/qcom/qcom_pas.c:173 expecting prototype for
qcom_scm_pas_auth_and_reset(). Prototype was for qcom_pas_auth_and_reset() instead

> + *				   and reset the remote processor
> + * @pas_id:	peripheral authentication service id
> + *
> + * Return 0 on success.
> + */
> +int qcom_pas_auth_and_reset(u32 pas_id)
> +{
> +	if (ops_ptr)
> +		return ops_ptr->auth_and_reset(ops_ptr->dev, pas_id);
> +
> +	return -ENODEV;
> +}

