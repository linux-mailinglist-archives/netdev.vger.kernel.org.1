Return-Path: <netdev+bounces-305934-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oVewONSNTmpIPQIAu9opvQ
	(envelope-from <netdev+bounces-305934-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:50:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E14729540
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:50:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=mCMPP877;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="gusWzy/r";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305934-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305934-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0E163014BD3
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 17:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384FE3B992A;
	Wed,  8 Jul 2026 17:49:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F4E3B95F8
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 17:49:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783532985; cv=none; b=ckDjdd8pXdTK7ed2txWyK2UsM3fh5dg2WYLZ5/7Vc1PM9XaBdt7yBnEJjXc4agLLxgtrHeMDhfRo7oJ4fkff8AacATnnoRraMfGvOI1aknWbTspbG+ja2F+b8oUyoksLRe7sbtVwutB7B8UpV8g+uUxnjUDOz5GnSzZAJlB2ur4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783532985; c=relaxed/simple;
	bh=LvxCHrdM6ZOJ/J3A7orQz/W8gmnF4rhcghvrTkQNOts=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Wo1MwjJYDoCRMN8hn2cBIfLuW6KdlYWIQJWFtAzQnfwkdae08/L6CPuALtUUGJAeo7SL1e3HWbGhW+3IDJWgeh34Yl97c7/RPHyVL3lHRQe2DNV5QVu1u8yxjCguQOYYhU57lLrfO/9SxiA99xpvCjCGf4E7MbXwOmuv6HJ0/3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mCMPP877; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gusWzy/r; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668GL0nN3125604
	for <netdev@vger.kernel.org>; Wed, 8 Jul 2026 17:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6RZBHsUYn+gNl91h+2+3Z/xDo4fDHSJPAjCPO8O7F80=; b=mCMPP877x0Bol91s
	Jmsy1krXdXHP7nY8Jv+E0deztqPdfrX1okfouEc0C2nZBoCOGMh+z3oPcgXzzhvD
	/wPeTR/KU1m6AKZN1HTPDNfZx1f8KDLAQjlFIi/PmJQBoEAN0Z53BPeJnRZJ2pdt
	MkWvxNUNjoIjDp6d4dJOAEDytmcfgtkwei7BLxfaFghtSq3AmOClVnpWLG7qThkL
	0cy8ZXXPky1NEsG++gDZhJ7p3PKHkTGpjxBm83P41w+O5sjVEXnKfHYLD/5VVrGj
	fLWLsh8+95S0kkvSzbP3aMWF+vMjtn9UpHTvfPglA/A03wcikzfKwX0nVJcBKY4M
	qmczXA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9q5s9c9x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 17:49:43 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c110a3b6aso13591941cf.1
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 10:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783532982; x=1784137782; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6RZBHsUYn+gNl91h+2+3Z/xDo4fDHSJPAjCPO8O7F80=;
        b=gusWzy/rJ8lJ7jXr9qWTXHOTLBE/8n0643mRrRMJMUFQlMfI0Eg2+lugOT544pRy42
         0YtWYL8/VzZxrxJh7/YRa5WTy/LhpzeDz4r/XfHTHLpLPBdvwpClGrrm8fVAdXPq3XpO
         m6Al3rXp+pukBQ+AXQBlA8WQZycHXL/dWGwMRP3iaBLNLAfzv5DndgE4QEUqC0d5YzeJ
         P/pwDrNum/2mDAHNrvhFClTjmSDhQTAjC7KSJ0/GtJrvIFSMFN8Lr0XC4/5kcIiXfKSH
         o6Am/ujEsV9h8Lvdmz4YwANonfWaiTAwVDIxa1AorY6SmrTsMfllADfGvDs0sM+4VTL0
         DJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783532982; x=1784137782;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6RZBHsUYn+gNl91h+2+3Z/xDo4fDHSJPAjCPO8O7F80=;
        b=SUAFVxlkitDlUDPDJ+fPyowWzOAdEwihQRAFTudmOKcW+i1cBATTgQVcI2nEtPiMpH
         hQ5m8/DnoTeUvWhKUgh1E705mAcrYwgg/ToIUGe7vQDQnuH2qO52wfzPouOA4mJ7BWBk
         WVdk0PcHGRNnEyWgbiIP4yynxZSgRM0ABy7A4Nw/nDBXk6tWwYWkhpBqR+eUxKW6JWVW
         22J/hBc0eblMRnoETs3bsumLmyFZmEzPiejxvic+fa2Rw1EKs+eJwE5cUG+POH93S+IX
         E48/8Xb6mbSiyrEXBlz9FvjOTKpYZS298HrZUXT3E3k0j6v87usLZ3Pm8dKcdftyEgxU
         J1iw==
X-Forwarded-Encrypted: i=1; AHgh+RqeqRMKBOJ60l6tFW+P2Rt2zoAQgjL9v1no643TEm1LfBcYwPjClbHiPaEE0iiyr012ypZ5Qfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsPv68Nh+dEuHc0NasiRdH4XYUUB4P7giMCNVljW/ZLW1Dm+lK
	VYFQ9Z+eYU1hDKhczkJjDpBUtD965hTpif3ENvvczvBSY6ruppY1K38Stk2Kji6fWSx4K34CscP
	qCrLJph/8oSy3FwCz8Z4ri5hk0Sxe5oRNPR38vpWpuTb7KkUjG1yZKv0eob0=
X-Gm-Gg: AfdE7cmQD67JTje9cjLvhBiczR7lk9hglILDsFD0rcLm1wfmH/d/SsATjn+89OVviG7
	xcHQ7rS5qtOp/YaALXDaUaEE9zFnjo35kKyg/m4kkjr1jWI3a8vBUeIYZqI1fxbmXjdmNbKc3iq
	V4VIFCXFLX4ubNTf+IOokWKLltqyXcQ85klnGtFSXFX6WZd0jtuWWJP9SPMjamMSbJlzDsJzwwn
	qlDp2/9zsbwpK6V0ilj2c0zw2ZFbBuL7fQ3a24sLoCelrHQ2wE87LhLMmm4/s9XWFkv9hg3+aJy
	zc6Ro15PJagrsToJopklb39TFCMm0muPh0QmxCGrZ2Rv9ycKWwJwoI/6aKVXGg9LsMDfoHc5i9i
	2mu4iZjeaJwduMHNUChvm6Kp9L8rM2DB7/h9VJR55Lf88AmaAng==
X-Received: by 2002:a05:622a:5592:b0:51b:ef2c:7bf0 with SMTP id d75a77b69052e-51c8b4095fdmr37755691cf.35.1783532982067;
        Wed, 08 Jul 2026 10:49:42 -0700 (PDT)
X-Received: by 2002:a05:622a:5592:b0:51b:ef2c:7bf0 with SMTP id d75a77b69052e-51c8b4095fdmr37755241cf.35.1783532981529;
        Wed, 08 Jul 2026 10:49:41 -0700 (PDT)
Received: from [10.243.141.238] ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15ada04d04sm359763166b.47.2026.07.08.10.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 10:49:40 -0700 (PDT)
Message-ID: <c4cb79ac-1f90-499d-98ed-94ec431d9368@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 18:49:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
Subject: Re: [PATCH v3 4/5] net: qrtr: ns: Limit the total number of nodes
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        jeff.hugo@oss.qualcomm.com
References: <20260409-qrtr-fix-v3-0-00a8a5ff2b51@oss.qualcomm.com>
 <20260409-qrtr-fix-v3-4-00a8a5ff2b51@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260409-qrtr-fix-v3-4-00a8a5ff2b51@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE3NCBTYWx0ZWRfXxG52VCVjk9yv
 qswcDjZ/6EB41hp05UAeM7CxAR7kgeMh06er7tD8lUUBSQn5W3oKRcNcoYz8KSL5VgbwmyrhLlE
 6QjmaBh0H+uj3NwuMhF4boWI2pw/OIfJ+y0cNtVp0A0JooNQntzg34DKT+4k3WqCKzLKz+2ngT4
 4+L58iM0zT51sw3s67mMPWkU/dtTPJa6u7LqlzbNzrCvXiVXK91Pby0Vo7TO2uUFvcrT72wYjFi
 3SzlrmjuYypLQt73qDMtHiz7JW16CokeSv9fEhEt3nxIUSSPIikLdOD+2ACSVo6rJ4jhQF+OJlO
 OK+emlDJP/P7J6/MZJV2tW65sZRRmD3k7Qy5K/kBhcm2WxyHVNDYLm2EkYMvomgjylkPSdAwjIZ
 Dtx1WFHY+3XmXWERs5QFVSrSRbZrCRudwpBF7a6g0Yy7kGi17THLrpMxKLG7mIAgjMo10nuVLjY
 8f4wnXcd10InMDhKwug==
X-Proofpoint-ORIG-GUID: wC_dKxQI6gL2x8jo_Vf5-mb-fvAw-r_t
X-Authority-Analysis: v=2.4 cv=NfTWEWD4 c=1 sm=1 tr=0 ts=6a4e8db7 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=iDFCKaCMZfxtLc4CjNwA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE3NCBTYWx0ZWRfX1Bdv5bpYeved
 5Nm5YKR0rXtr/SrcgCNt8iyYksyIc4auGdo8fe8y0HQ3CQHwn4DrwNR1DdFsVXemsiwlRu+t1lw
 JCVNlpJcK9mfj7Gxb+F2SoeWozIrojw=
X-Proofpoint-GUID: wC_dKxQI6gL2x8jo_Vf5-mb-fvAw-r_t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_03,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080174
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305934-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:manivannan.sadhasivam@oss.qualcomm.com,m:mani@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-arm-msm@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:jeff.hugo@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[youssef.abdulrahman@oss.qualcomm.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[youssef.abdulrahman@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 68E14729540



On 4/9/2026 6:34 PM, Manivannan Sadhasivam wrote:
> Currently, the nameserver doesn't limit the number of nodes it handles.
> This can be an attack vector if a malicious client starts registering
> random nodes, leading to memory exhaustion.
> 
> Hence, limit the maximum number of nodes to 64. Note that, limit of 64 is
> chosen based on the current platform requirements. If requirement changes
> in the future, this limit can be increased.

Hi Mani,

There are AI200 setups that can reach 384 nodes (192 * (AI200PF + AI200VF)).
I'm not sure about limiting the number of nodes, but if there's a use-case
that led to enforcing that limit, could we increase it to something like 512?

Thanks,
Youssef

