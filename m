Return-Path: <netdev+bounces-282407-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJZnJhwQ8mkwngEAu9opvQ
	(envelope-from <netdev+bounces-282407-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 16:05:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EF84954FE
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 16:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C45603007677
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1833FD147;
	Wed, 29 Apr 2026 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UzklY3pE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Oqvqhyyz"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371CE3BA243
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471500; cv=none; b=pFN7f+6TmlP/D1Z5Jlg/ObUo6vQAMzJGPQY3xMoIe3IaEARlg2lSiiyYzXQHOoNYXmxS7F/UkY8TQNhdSdSDPwxFHuxWeo5t+RbDX3Dj+d+e0pf/JVF6YEP5FM9ESmXoRmltxgC8Ik+VVc0RHW1CK+CG1heEJVrYytCBCYhstDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471500; c=relaxed/simple;
	bh=S6wX+gTzPAvcCMKGMzHVKpxGRSVZp3HgiObGvUJwvgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4Y0jw+B/PS/OBwe/CQr/M9N3lTtVH1Kho/KcVjSrZgAC+KoXTFaueFjih9OUnsJ0xoz5FyUxvJClXkR/TejgHar7j92kzCqANBSkGclE1nC+/nbAEBthF8lK56d3695UeLwjHWqLQ/9jSXGmFlr9+rQlBSo65KrxZ0P7q5k40I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UzklY3pE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Oqvqhyyz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8q42V1729375
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 14:04:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=5geFPuppNEw0Na2cpguNPJGL
	4nGh1NRsp1YB6ryaOE8=; b=UzklY3pEYefS+bOkeBxtQUZQD+IPj7gXWaOzbRS4
	WSH7uI1wuHaUtu4VHRYIMvEaC8Ce0Evo+1qCEfaXCuS5ZjOepwbErwHPT64k34un
	SbcLc4hz3Yyoroyb3gjlgim9TtWDtoikFNBW9OgPOx+e2y7su/Kq1/tXmPTWiAYZ
	LKsObFeI2pSfqRgSI6in7sI2towKK+tr48YfWNyZERAuT1Y+/k7VL9nPYI2Rm+MG
	rnEcZGfao2k8+8039tDSPeRRbTv/tEPjbLqp4NrDRL4nlwgeOh464GwL7tyN7NnV
	qY55lUizS1cK2Jl9wXKawsarLCHU2ioQmRBhk/Lcn91pGA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4due5ksb8q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 14:04:58 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c7ada7b25f0so3965378a12.2
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 07:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777471497; x=1778076297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5geFPuppNEw0Na2cpguNPJGL4nGh1NRsp1YB6ryaOE8=;
        b=OqvqhyyzhU04Ko9ryYHrEnQ8Z7+0PUmnKAj2kURoZH33eCbYTmiWvchFka77Wgrilb
         UIouHcS6aEM/PC/PXWLZnvRJWy2rBjumtOVmY671+wVsy1lZ5a9IPhFxCVJOdV9eqJ/M
         XNOebnfjcjDOk1kztfoz8FK1iWHlkCnFc9g+iVR7Q0JJeJkB8F+524rIE//JVRFk91Na
         VZR2mMbrc4KjSQZ600GIKcO6TS3vVDZ0CBp6oK+4jbJlXTRE7kVhdIyMtLngExXbkDTS
         uCI1rx6RZ5EGbSFNi3mh2STu0Cj+dWH7TA1u5JKEbmNvjGy+0UtEe4petkLFQDaleIqF
         S/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777471497; x=1778076297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5geFPuppNEw0Na2cpguNPJGL4nGh1NRsp1YB6ryaOE8=;
        b=kwi2Vsh3OrCukk/mJoiy1Hfb0/GkvBpsjIsSQTFbY08nM1w4+qs/xpt2KyZLGX7UnY
         hdX2UMp+G8iVjtn8WmGZau5GBvSu2MDwfQPS9fY0t3JiS22lNFiErb7fgTir1nSp50yc
         OJlabP2uByeNeH1VXpjV2LBGxaShQND+yktaONI+eTTEuNZO7VT4FynRYOSwtAx8Ukri
         cma32/ycqJxXWbbkeSfSoXOyHMNCWao1bUS6MA1v/kSq7JDCfjSFVE/wJetY37an60Nz
         7nFmivzYDgLrHYRlQyx/0Bqq5pucyiG7/KGv2ZWkUEcXqq564RL+4HD30y+JeP2i7LJC
         5FjQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Vkw0FmVgWF7qRVpR65phFO5Qyl1TM+F7Kq6/1rEo05pjJMSVyT+1nE0EtQPYFwJVI2AFv0q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMzMjNBntviLt//WIDURhfQ7NQwkGy8u7E7arN/1feDX0EZBmh
	dSqfjhD26/amsRTdsMUOwoDbn9V1gCdDYjdRCDslD4LYVi14NVKsbT6CqPk9MdWVzvoFpeTZAW+
	aULq4B7c+7NphRbU1xE/fk3e+/NQ1jwkxWFku75F0YZLYu2uA8oe9+owjY8c=
X-Gm-Gg: AeBDiespPgEaYnusdD/1ExJdRxAFYfLadqNiw4GoULlnimzo8gkejA78ECRMwwdvB8u
	u0fX9McQv/9bpJLeepwCqCzN3RfLCSASR10p3wRIzJR/BTHp66a+AbAxjfLDsp5PUaqQ5tTu/n7
	pW01k8m+4o/5qSn5cJ66xMl157DfqPM9vB6sVBjoufrcSSO3jz2NoC+EZzQUMOcatJr6kpuTm4Q
	K/uvYox17ybKBkRVjc/PskQ2kcBKOnnLIcsYnl5JhpIESyXcjojjSmp+Bg6ioC6ug3BFGFUT23g
	DR76Y3PvYaVssq8bv6a/Aree+cIVNtNHFxgv6XnBQNUldvRnbiJYa7KMwJSi0TfUxsQb68Ol+XF
	7zMVs53ZmP+U1xxBqizCsejkfZ+RAXdUWuPcn/LvNQzVcvX+q+Razna7i5vA=
X-Received: by 2002:a05:6a21:33a1:b0:3a0:cc67:396 with SMTP id adf61e73a8af0-3a39c2722a6mr9041404637.28.1777471496935;
        Wed, 29 Apr 2026 07:04:56 -0700 (PDT)
X-Received: by 2002:a05:6a21:33a1:b0:3a0:cc67:396 with SMTP id adf61e73a8af0-3a39c2722a6mr9041274637.28.1777471496127;
        Wed, 29 Apr 2026 07:04:56 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fd6506af1sm2270618a12.25.2026.04.29.07.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 07:04:55 -0700 (PDT)
Date: Wed, 29 Apr 2026 19:34:40 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: andersson@kernel.org, konradybcio@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
        akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jesszhan0024@gmail.com, marijn.suijten@somainline.org,
        airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
        dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
        elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jjohnson@kernel.org, mathieu.poirier@linaro.org,
        trilokkumar.soni@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
        jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
        vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v4 14/15] firmware: qcom_scm: Remove SCM PAS wrappers
Message-ID: <20260429140440.ov7x75bikyvs7w5y@hu-mojha-hyd.qualcomm.com>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-15-sumit.garg@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427095603.1157963-15-sumit.garg@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE0MiBTYWx0ZWRfX6hIwVuv/5TpP
 y47iflUSvL098Zpv5ZYlom7NwVOL2pwEwUn38yYkOic39INjEcnq6R8bbKi8Z/MIW1rpkyCuYih
 K38wcq/0JZIjm8h3Yjel5L0aUsHMmzIQ9EBzGKoANspbJFR3nUc2qV3wJFPIWiExO5lN+mzqg9k
 Y5+SHQgiqcZlvXe3277yPKYtCIwC72Zibeod4ceWpcggBwBgbMs+45yG9CRdSFCzt9wdah4nYIp
 aZA462b2gez787OL6Ril6KU4fZELLQEjMhWxDMYg8BVQI5011imGbDlCt1EhRlxjcS5ucHvJhAw
 yQveUEONyyzBscZghdao8XNz07GBL6OlcWBQaLa7865nI2bBLSb9GqKY3cwRs6/GWDXzoLb8XB9
 kaPWjmMBqKsced81M3U6LEAORQG4Uid/4LTKuef5F7guwjbA+zNWYHXSToUpn7OBOtDPxDvm+Gr
 uTjyVLRTuSQAgYD8muw==
X-Proofpoint-GUID: ZkWzcxRsH4xNNwH75c_FQXhhyzSlOfXX
X-Proofpoint-ORIG-GUID: ZkWzcxRsH4xNNwH75c_FQXhhyzSlOfXX
X-Authority-Analysis: v=2.4 cv=CL4amxrD c=1 sm=1 tr=0 ts=69f2100a cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=n1VOVlC_Xzu4QXtT9DgA:9 a=CjuIK1q_8ugA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290142
X-Rspamd-Queue-Id: 30EF84954FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282407-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.ojha@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

On Mon, Apr 27, 2026 at 03:26:02PM +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Now since all the Qcom SCM client drivers have been migrated over to
> generic PAS TZ service, let's drop the exported SCM PAS wrappers.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>


-- 
-Mukesh Ojha

