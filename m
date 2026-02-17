Return-Path: <netdev+bounces-259124-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GzhLMK0lGlbGgIAu9opvQ
	(envelope-from <netdev+bounces-259124-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 19:34:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCF714F304
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 19:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3233C3004CA6
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 18:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12A136D518;
	Tue, 17 Feb 2026 18:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LHxKULUR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UEhlb/TO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798F51C69D
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 18:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771353277; cv=none; b=KfCXWlmcpGA1J7nL5mibmgneA0ixz729tIRLoW+lKmKZ/DecDuVlBErLIbL5Ma7w8nML7htbMB9q+KdHuufxwMC1ind7e8k/D7TO1w3fokKn/gfvg6EDPqPUa5VSLLue1FSkTgawDpL4uSHUrkBY1PuKEd0Tes5EZrUm1ZuYUck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771353277; c=relaxed/simple;
	bh=9D8P1j5eIMJ5b8STGnBJ7d6OsDNVGkrvoRzQ4uX0QdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8TC3WWuTGtAf6kAfSWkhXjhjNeIwc9nzQvRKJhDl0Gz7O321hQ4jndPZBogyG0A52I5afDc8D5VoAkYwhU1W1DKhqT+u7NLef/kZvK35V6998yx2wCRRBMGsYvy7iRYkhNWb5FRT+Z2nHO4nIu7G47jqA2PFSP2mXEvQGtH4cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LHxKULUR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UEhlb/TO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HIYQDB1943465
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 18:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HZElJviG4NF1mW6UtvdcdLWT
	vHSgF6zYjPqp+73i8VE=; b=LHxKULUR8AdJLUA+Vd99o1XvUr9hZBufaxlm8UJC
	zwiHJ26uBNAatSzFqPVa68DvlOHxOMy7OGM6H3Gg1z+NHxOLoMqS+ojcaEKd04AY
	xU+US4BBAKk6ZlehHl/K5KjN+7mZ8Z7j5DuXlzvhn3R6ewBFuJHpLGc1NNkM3KIg
	SR4ei5eYh+RERmNU9lawcDgWB/r5sl0OnOGZ70+RnB2baaY27+txWqjrp22gIkzZ
	e9t/Jzjo+PQ7L4v9SL9BWjJt0xJSaTMlq9pOZtJmhw3ptQPoS4mGW0TwR0nkfrVK
	yDDS5+SIa+0zUht+7RmLCxLpOGhRk9N9APyuiNYz7nRWag==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ccq4g1et7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 18:34:35 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35845fcf0f5so111176a91.0
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 10:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771353274; x=1771958074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HZElJviG4NF1mW6UtvdcdLWTvHSgF6zYjPqp+73i8VE=;
        b=UEhlb/TOFgEMcXQfjJdmC0n4TLUTj5pAwvbSMw/kC713V4EcfV9AyKZ7YIkJcVyhcQ
         sSBhw/K3C8/oi/udvHKJ9yUPYCleJcUKzxEWAAXPuPuFQqYqyZWXeqnqjOhI6W1DRBwB
         JdLQ4tZ/cblRRv9TiBvZsMWIG9jlbGWs1V/v3hGVy5iSEBHFc6dlDyexUt0Esx3wo+me
         UIfWLe2BlYKg91kd8CcYIVDRx5WE2g18wP7cFk6eCdthku+cuPOQWH1UYPDJ/wf6678k
         KpDPLiIN/nuURSuYBsUz3oR9TkrypfDvD9aT1LmmIPR4Rqx7zvZP3qpbtw9rP0i1Vlch
         aiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771353274; x=1771958074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZElJviG4NF1mW6UtvdcdLWTvHSgF6zYjPqp+73i8VE=;
        b=vqVLQfRcDHUnFQ8JPq+rUNbzqMxFRidrSLdADXRQ4Of9n7wig1O/qj+I+iE3DyzzCq
         +7qj6/DNvA88zMgXS3h4eU70Smq5ANwygcGjm6s4WKrHBUUZDf3ypqbuAc5OnZn92fpM
         nqfzAyQqjnakf0YD9FmyKdMq+6/CyevhFIyiYlo3EUoi/NzYG+IG7JbJk2cgYEVvoDcD
         5g0arGp13MnpR7wyIklyXcX/pTOMESvFjIsAUNQMjDuqzJHmknrcfs6nS2HVPbCEUHVB
         UrwH9RDZ1o7eBLSAbExHC8EOm6IKxdci5XGlYXvAUGwNmRn2QYQGNwW4Ugy25ZLE4K2E
         pdxg==
X-Forwarded-Encrypted: i=1; AJvYcCXoYTowchLUsRh/pYfwobSAcoq6FyQ3P8o2INUnKIp8/HsqUWdh+FoWED0q+r+YiT9H2Tg7gdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPwg4cQHaNczg2+9yIYjndyiDxJpwtKN6F5Zg38ligHNA734XF
	Z7/2NnkQS0NJ1lFSwpsuYruXiO23x7ldgjQ9P2rFNZ7PsR2gSr7ViGFDykjl/6p5krorxF0Xp7+
	cqDaE3c6uietjGiMdBMyMatjB4KTiSnYm3FfVenaIgX7dlE691XcSO8VatR8=
X-Gm-Gg: AZuq6aIwUjLPr4AISVJurR8ovTboo6FV00IMMBsORwrtrEvtui1nCr5jcOtmRziQ6f+
	w9dicWPolU+csmSbIhBRGcjZyJAuuA6ihY8L87ccrUVObISsegqwKStXxlpV4iv6rqziT9qBlhO
	K6P1jDuVFyq+Y2ES1VrS374J+d35InmsSzfEb6EP3qtFVMc8LVd5yg7xNVGBk9rzM+jWtON/MWf
	Efnjp1CIy6StTcwhd2G1S2iRsYPCM/dbWERA05A/eWyv1y/4Zni5Memj8CjsUhvjeuIvbDNsCJu
	Y5uYz5vwxF6oSs7KCdRpt5HE9FgPAadgqaKhWXIMZYCeMF8zMuWK5EIrPg3yfAozE0EDAew+gqZ
	88aG/qkpI2UK2eR4geCASOWz3O0v1XhCoFRA=
X-Received: by 2002:a17:90b:2b8f:b0:343:3898:e7c7 with SMTP id 98e67ed59e1d1-357b518ea91mr10071988a91.12.1771353274192;
        Tue, 17 Feb 2026 10:34:34 -0800 (PST)
X-Received: by 2002:a17:90b:2b8f:b0:343:3898:e7c7 with SMTP id 98e67ed59e1d1-357b518ea91mr10071965a91.12.1771353273637;
        Tue, 17 Feb 2026 10:34:33 -0800 (PST)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662f8cc57sm23799159a91.13.2026.02.17.10.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 10:34:33 -0800 (PST)
Date: Wed, 18 Feb 2026 00:04:26 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Frank Li <Frank.Li@nxp.com>,
        imx@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH RFC net-next 1/9] net: stmmac: qcom-ethqos: rename "por"
 memebers to "rgmii_por"
Message-ID: <aZS0skzczDS9g2Xj@oss.qualcomm.com>
References: <aY0aJppQWUC52OUq@shell.armlinux.org.uk>
 <E1vqKOv-000000093mB-48ei@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vqKOv-000000093mB-48ei@rmk-PC.armlinux.org.uk>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE1MSBTYWx0ZWRfX9t+I5P4n6TU2
 qTPkmjQPwu8eFKUyfjRs/k0+g40ayxFuPjCrkN8hjZ2PgoumVCEx69686+SkYNcaGtyV/I7vXia
 h12s0F2QKk6nUpiiGVfKOFoGK/x4cA9XmXt5FluCQT3LMZ5AM6apxkRL/+4dNqO7FNZenMEuC82
 o5Plqkj3HcbgC14wxMVAgReS2mEdCQ+pco8JUMW92xV6tUFMP2YvZNiRtris0gW1/jLnjs9CfOC
 VvlYd7DvcI0RCoFCh8qLxGD5srdYEx/+Wd8ippt6WvCXrLLxF1RwdvvqZxiau9cELZFW+GnipxC
 9aPyGuJH/GHlb5Bap6+BcxA4TGc0+KB5nsv4NGNSLyZ1/NtbYaif1PbF8feumEFPr57VETSt0Lc
 FmQ7lzOed6QPh0pelknqJBBBbbshE5+dN1FD6GrQUqy6gFCROwSYWr4d5XiHv2o+M/VRtqB+mrQ
 D4gnTSt2TLZzX4/HNKg==
X-Proofpoint-ORIG-GUID: ZBdY2AV9xsVECm0pGjyxJUqicbGIRBHA
X-Proofpoint-GUID: ZBdY2AV9xsVECm0pGjyxJUqicbGIRBHA
X-Authority-Analysis: v=2.4 cv=YdiwJgRf c=1 sm=1 tr=0 ts=6994b4bb cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=PHq6YzTAAAAA:8 a=EUspDBNiAAAA:8 a=AnVTdvRHBf_CuTIAticA:9 a=CjuIK1q_8ugA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=ZKzU8r6zoKMcqsNulkmm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170151
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259124-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DFCF714F304
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 12:17:45AM +0000, Russell King (Oracle) wrote:
> Rename the "por" and "num_por" members to indicate that they are for
> RGMII mode only as ethqos_configure_rgmii() is the only place that the
> values are programmed into the registers.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>

	Ayaan

