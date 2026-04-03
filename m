Return-Path: <netdev+bounces-274972-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPOYGLGLz2mmxAYAu9opvQ
	(envelope-from <netdev+bounces-274972-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 11:43:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EECCB392EE8
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 11:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2298F30B650B
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 09:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084013612EE;
	Fri,  3 Apr 2026 09:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="isxJvM2K";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ts6zm3i5"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EFF35F8C9
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 09:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775209039; cv=none; b=RU0k7fdXiawnrbNQXECf1PCyDf5GiSrSFLM7F5Q+JGXbFIU9lPSyoTFRi9WfpBbZDcBnxUoD2Vn+T/HIIM0SPummDha7VUjyn6Loy8WxpaceUo/5lvHECPxCrJCwpMUOQc0pdisFqtLeYmrz2eGQByNv9AME3+RK/raEY2lH61Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775209039; c=relaxed/simple;
	bh=SocuiM4ILZ9cYRA8mSWtuuuo4+IGmqWsxZXNi9/pB0E=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGLfoOwCJ2KlUKsEL5Fp90FgyLN24EfT/VY2nWwq7y0T+tVp0BK4O0xvDywll/vWIIta1pQVRiqSkFKIHIRnk1rc0ZLHteH4bo/VN+hXhAZm1rSvxlw3HE7Jt+qE035rwzHQxKC/2DXkHhl/FhxxDSFZ5euW8tZmVnQaa2TirDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=isxJvM2K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ts6zm3i5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6337OCgi226807
	for <netdev@vger.kernel.org>; Fri, 3 Apr 2026 09:37:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=H0MsR4PHC7LRNEDJ02SXHtGh
	86o8LwWKhT/z44z5dSo=; b=isxJvM2K/Cv3Pm0NShfaaEwkY51/yH2P37+roCBv
	lYrCcgbdhQHUYJxt9ZaYRXWC20+urqqeQP2i3fq42SxtBdpAbOyHaIPnzRWp93qp
	QhAms5skdcgdocGbuW8EEkhEUxZ3sTcKnETvEuiyk1+Pm3OocQu1n8HzYcRw66t4
	536ts+kxzBAJIVeVFBFgH3T8x2hYC18mMhBZriiWcTHzQDNU9C8b+kQqmV4xadiD
	mTBOHSS2dOrTwiGXGNamY2DF5T1mQ/6TJ4GlxtarDcpWup0gReaWKh75SsJBMArq
	yJ0mRgfT8xA5wWGvPp4wQ33YQwu38eZi/2RiBGwkpqwHTg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9r0u3wms-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 09:37:17 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50b4fe4ff7bso36709811cf.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 02:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775209036; x=1775813836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H0MsR4PHC7LRNEDJ02SXHtGh86o8LwWKhT/z44z5dSo=;
        b=Ts6zm3i5LV2Cj3ZCIDP5zmEHhU2cXXBxGlKB8zByjE4Sh2KHe0nhc7I+KJmtFXeWqE
         EL1+WxQqj7Hn3MH2Hyqt3uKTyRLa8ABdBu4x6qmQzC2E+v4mHrqCtH3gb4rID1AFjZXt
         /89RgMclwFajbfRO0pq3av88ZkdawVmQlG/NwSBELCIxxIsvM66VB9FoTDlfLpcIzNRQ
         /4BNj6t/RnTn/5r39bLw6HQJ2IJ7phm7qxyvcrnHp0EXTDSuKT8q11tOYBY2EpRLwP/l
         ByxCJWDeOyzL0TBOYj5B6y4qSFVDE4w+/zhywavwDZUs3sEMCY11HaYyljshng9QZjtM
         C76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775209036; x=1775813836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0MsR4PHC7LRNEDJ02SXHtGh86o8LwWKhT/z44z5dSo=;
        b=NCxH9TVIQScAbmuJnOVtxgH98kuyjmd0w2oJuDvMULtPRaiT9M73l3bk9/T1mgsbve
         6WGIsfsNtHRl6qjyOyAaQEU9aUU7xtIDiXFR9HpRErXbGM/kty1s+RQdjBi2tplSsYe6
         EYENzcRClpZXWEMLhNuVWn9IfmfE5CBD8rAzFfXhCcb4ob/1KnlcuZGE2XZdNAaZbWNE
         VZvtpIivMLHjIqEKiYMjKenDAFaVt+6cU8KMsCaZylhQZcKGEQjzfy11sBB6pT1uro5e
         hO9jz6go5JE+uhiRXwAEMM89IYt2MmN6zdjmmJ6VMTNkEFg+Gzffwhgf65+EINytk8sk
         zoTg==
X-Forwarded-Encrypted: i=1; AJvYcCV0NOmAa3Th1UJOM84J7ajZaCFT5CFiN3af2f/2wPOgoNGrY5R9hNsntpP72inzDnw0RJ1nLCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ck0bUIBbHLz/PV7g5ZzAM1+OMcvrQrtI5JwvuZKvNTBH8EU+
	WW404xWRyLD8nbtRZF4FAM2A9P17GP55bxGFjd93NLNV6yQDOdPwHK1Bra0thbPo/IEuucwgXGE
	ZmJR5VLom1QW66t7kieYGgnOrbznmvOlO4dgUzpqfjyHxufBp5Px8+4QJSGs=
X-Gm-Gg: ATEYQzzChcxLjCKfr8z+J0DPRL3eSOOB9kGDPNg3N5MuPt6jmPHZ7Ac4LYeiPXfMFBE
	G6vozeiDgizATCWeudjgIXCnFs8ywlAzljxdXkt6A1cSzcJVF+J3DgM6FyGd95ATPamo8XSVT+a
	kaTxBf2PDXZhZx3P9swVTAdsZaMmXtoGOGbzfT/PecGvTjMW6IOBhI6h8ds34YIn/HlYFAJfYvE
	7dyV0ZdFRkcGdRxzAwnb7cPfDXpc1rZyNKpwnilzK6NKWzj47YFUjDXyIaWrigp938mBTM6bvOH
	7LqXiQ4mCjAx/lq0aD7mX5hioqFbas7zOQkQYewXBMOog+Ginem5qgncvSjOWTZ6aHgj5ar1+3V
	FSd3trd0HvNpy9sSfcBcgmQc6xEWTTNspJHqe7FIk4lu64qp8lG7N0RDp
X-Received: by 2002:ac8:7dc5:0:b0:509:202f:f03 with SMTP id d75a77b69052e-50d4fd24b4dmr66236561cf.38.1775209036472;
        Fri, 03 Apr 2026 02:37:16 -0700 (PDT)
X-Received: by 2002:ac8:7dc5:0:b0:509:202f:f03 with SMTP id d75a77b69052e-50d4fd24b4dmr66234201cf.38.1775209031263;
        Fri, 03 Apr 2026 02:37:11 -0700 (PDT)
Received: from trex (187.red-79-144-197.dynamicip.rima-tde.net. [79.144.197.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f13sm15010561f8f.3.2026.04.03.02.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 02:37:10 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Fri, 3 Apr 2026 11:37:07 +0200
To: Sumit Garg <sumit.garg@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
        akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jesszhan0024@gmail.com, marijn.suijten@somainline.org,
        airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
        dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
        elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jjohnson@kernel.org, mathieu.poirier@linaro.org,
        trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
        pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
        tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, harshal.dev@oss.qualcomm.com,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v3 11/15] media: qcom: Switch to generic PAS TZ APIs
Message-ID: <ac-KQ7e8-syph1Zl@trex>
References: <20260327131043.627120-1-sumit.garg@kernel.org>
 <20260327131043.627120-12-sumit.garg@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327131043.627120-12-sumit.garg@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDA4NSBTYWx0ZWRfXyORigOgEu/DQ
 wERT0e0j2VgRZ7nanX6teYZLog63P4aPmkkKKjPRfZVSafo4cnX+kYO/HnnMLYI5Lqvxb7oYa4P
 Sk9srpPGciMYoDUNJCLlSPhWyLBOXh0RF8xB3p7wp8MCGmZR5aOm5ZriOjdO6VTVwAyw8u6yrpi
 IwGxaLsYY1K7wI1vsCW4fo3BcMfCGOo/pAHOfSkS/1WxP1Y/wCY3uXsMgRx5hpheqlCNnfa8tow
 w05uMrfcBQVIJtq/XNZiFfALf12ux1z5YmF1+ocHya0l1b28Q4pOYvq+ZO2Q8KR9BVqT+B2PKfM
 3prTRjGps7joI0C2EPN6LqfKsU0prUbc8h+fsLCmKaby95zF/MK6BUdPcJLmE+0Ri81voHxssLT
 zk9Awv4R/dKa8d7lkyu5RIGuAUWFTR5CzHcaVdLY/GKZjKF0DembKtQ9g8AHlD1xm9ZoDVvs02G
 k34RXbvQyg/aFUOdiuQ==
X-Authority-Analysis: v=2.4 cv=D5xK6/Rj c=1 sm=1 tr=0 ts=69cf8a4d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=VPdg2FrOqWfiVCzsz0q0YA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=vWT0tKtjkO2eN-vK3vkA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: pK1Id987qOxz2Xftt2OcRg_SoEUN9t6h
X-Proofpoint-ORIG-GUID: pK1Id987qOxz2Xftt2OcRg_SoEUN9t6h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030085
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,qualcomm.com:dkim,qualcomm.com:email];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274972-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jorge.ramirez@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[51];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EECCB392EE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 27/03/26 18:40:39, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch qcom media client drivers over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.

OP-TEE based PAS service relies on the linux driver to configure the
iommu (just as it is done on the no_tz case). This generic patch does
not cover that requirement.

Because of that, it is probably better if the commit message doesnt
mention OP-TEE and instead maybe indicate that PAS wll support TEEs that
implement the same restrictions that QTEE (ie, iommu configuration).

I can send an RFC for OP-TEE support based on the integration work being
carried out here [1]

[1] https://github.com/OP-TEE/optee_os/pull/7721#discussion_r3016923507

> 
> Along with that pass proper PAS ID to set_remote_state API. As per testing
> the SCM backend just ignores it while OP-TEE makes use of it to for proper
> book keeping purpose.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/Kconfig      | 25 ++++++++++---------
>  .../media/platform/qcom/iris/iris_firmware.c  |  9 ++++---
>  drivers/media/platform/qcom/venus/Kconfig     |  1 +
>  drivers/media/platform/qcom/venus/firmware.c  | 11 ++++----
>  4 files changed, 25 insertions(+), 21 deletions(-)
> 

