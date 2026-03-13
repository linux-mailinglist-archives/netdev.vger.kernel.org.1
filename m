Return-Path: <netdev+bounces-267528-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIrtMT45tGl3jAAAu9opvQ
	(envelope-from <netdev+bounces-267528-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 17:20:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0329286E0A
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 17:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17A193011347
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465CF3C3C02;
	Fri, 13 Mar 2026 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CF9qfFnT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AMC1TfLu"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A3B35F618
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 16:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773418778; cv=none; b=c0c/TV/XJ6IRrsBcfl8wQHhA8jt9Dzypb4qDdfyQ5lC99s9npnRkoaFfszx2CFrJzZYT64qoLE0fFYPtRFwGovqSquul3RutNTaLpHwvuzgVhGt7ysnaF4qXsYSWmQt0dZUiyiwy7uXK+zJV/kCjSZCbb2pp18zd1njMi7vaM/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773418778; c=relaxed/simple;
	bh=CUk+1Eqx8Eg7Gj79EP3JwQm6CTzkmToq1Tzgpw8RQIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMrSy8mkO8hlcy6N70Yvv56axyXATfAdt6UHPRGzthrU+SKj0J+R8iA6+rZSnCCbf6F1Ip396o0xoXTq67071IpQnJ2vmr0MT+UlY2o1gL6udUCsoPZGDLRh709i1gXfBN8Svrojl/HJupfq999KKbdksibeLpku0rfFkXLwWFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CF9qfFnT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AMC1TfLu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62DAsqFD532963
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 16:19:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=jH5WdttmdPjFQXmMJeR4b+YI
	SdBHMwDeAfB+CsyH+/M=; b=CF9qfFnT4OKerIc5lhJhz6zRjl2pL2cU5hzd3TRi
	Q5Bp+Kr4V/rb4rXgxvUet78rIkYKhjPan4cBb8WL2OhEyBeMtXiCiGH77Wq+4cuR
	FtjaGS8P60Xl8o/R7k/+kk64hEKXHapUevjcoxZtxc+e5uykVKLkKC8U97YjPObz
	nj2+yTERYImClxRfk+QhMjouJWhgxSaUUgMQyNwZW/Sw38E2aCYEgdpex4A9pkyQ
	rDn6foGLfExZHrmJzv94ppC7f5bRl9IchYTbX0LmfL/P/fF/y8+WbPMl4mjgK2L8
	JQMJ57WEGIWKpwpe3RZ648kAyvBkc9SFvTVV6m2+Kj/Zpw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvh84s2sh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 16:19:32 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-948476b92e8so4174067241.3
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 09:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773418772; x=1774023572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jH5WdttmdPjFQXmMJeR4b+YISdBHMwDeAfB+CsyH+/M=;
        b=AMC1TfLuUMPFTnKMiSPH8Ihw7GodfI/pKgD0ifL9NvHKmeuYfrQoO4x3dG4sYrXUXW
         6P3T6VKojwnmD2r0YWp8dJ/mEwOK6p2uQBNRw14McTZfXKqkDeCXOEJwsFfyMMSlCPq0
         K1Fnds7okyC0HD7lo9kgSWfn0hvDM4p44SRP8eLffq2nEN7YEPb6RZU9NLvQTWSkzM0Q
         zeOtBW2ZqD2uxpy3ePh3pSE+pEF2kh0z5/oU4vXDK2fohjkJ6XoReA/l3Fxd3nqY8TQ5
         rOXJvD8rr6KhQ4LJUjEa+OMZ1YXkNVao8a4yIpuqQARN2htHYkcL7btC5xJeXSlQzNOb
         iDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773418772; x=1774023572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jH5WdttmdPjFQXmMJeR4b+YISdBHMwDeAfB+CsyH+/M=;
        b=lfuE8jTjbJlr1K27CCfs0A3xtHP8ToQoxUyaID29YhyRG9mprEZgSl2ZXeQZJ7zG9T
         azhSqs1Vwyc+YE5Vu80szg0C1c3mMzjuUc8UEnFn0YOCjWrVvkGjXlAcgvBhEPVat7w5
         JvESsZzU840+DXy+KfrTWull4bn74FpniEmrRJhbDg5tID/tKFBEHA8sSIRh648S7RKB
         tKso7GwXead64EGSRFXxUocxnycE8YMdN8w7i1m0BG2e2dkBXKa8B5NPO6oAvUKpR5As
         hkGyLE0PceJAlA7GJEr/iM3wTpciZkgpGiu+tMzguqyjVuhOFJUhdF9U9647dA3IUcdJ
         TIug==
X-Forwarded-Encrypted: i=1; AJvYcCWTW4i9JsaSY+fMx6HMddgRz52B2+vTh+EuoY5wovwqWdO+Nims7WPjldFQbuCRROPIPmDtyic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL1+uQWxOr/b8vj4269uvE1Ziy04YIkz/APZE424EJk9XMuuHo
	lSz5BnrBZ33F1PrHOoU6ltivzqOQ5zm8wBKzEyMU/ONKE17tnU2gIh8K4lsdQ+zw8kkobREjwXm
	9feT02i/B+7GS/Hk1wRgWdHEI4DlmjlVJYGotyF3XxKM570WrwWjmJn6ieYI=
X-Gm-Gg: ATEYQzyP+BlgkFGgmacSuRePuJLRfWboPrsMcm/irsHLWzKpNtk/661LoVEMEvfngd0
	yAzeFBL1juOiMNN0Su244A0u0WadMWvPPLUxdNFmWGTlTE8B8PgAM93M4MDbZaKVe7apWxh88W7
	It75f0dEYnpjnwzOIMFNa3LdGawJs24s5a6eJwnTMbxM6LTGuSiCm0bKlK4HYDKoAO5wtVbnv68
	VCV9/TSJ9P/y+bYoK6g4BKfNhF4DWmAYjqLL+VRwRkiaSqgP8+WAcxVPsLYHOhQtSgf7Bq+XuPG
	wYKqtRdJ1NggoEfXdGYwTsDMgaZSUSrC2ldRD+EIFiEpyKPRnXkBEU34maN55dmLTDk0WUOu/W8
	GeMKVKzAvj1XGl1uNRX/JWwbKhvddyUoTS8EDAnpB7XRheo98xzLFUOWqe89fVenq9kIzh96S/W
	YavV/fRZlOpX7+DW6DVONQwmMBxEE20G8H3I4=
X-Received: by 2002:a05:6102:160b:b0:5ff:c5c8:2734 with SMTP id ada2fe7eead31-6020e528099mr1558485137.25.1773418771891;
        Fri, 13 Mar 2026 09:19:31 -0700 (PDT)
X-Received: by 2002:a05:6102:160b:b0:5ff:c5c8:2734 with SMTP id ada2fe7eead31-6020e528099mr1558462137.25.1773418771385;
        Fri, 13 Mar 2026 09:19:31 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a67e7c014sm15622661fa.44.2026.03.13.09.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 09:19:30 -0700 (PDT)
Date: Fri, 13 Mar 2026 18:19:28 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com,
        r.mereu@arduino.cc, m.facchin@arduino.cc, geert+renesas@glider.be,
        arnd@arndb.de, ebiggers@kernel.org, michal.simek@amd.com,
        luca.weiss@fairphone.com, sven@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        kuninori.morimoto.gx@renesas.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v2 2/7] arm64: dts: qcom: monaco: Add missing
 usb-role-switch property
Message-ID: <pkst2oth6sq3humlpebtjufchffln3cdvkt7bhtenry3g6js3n@pd54pwuzmvro>
References: <20260313103824.2634519-1-srinivas.kandagatla@oss.qualcomm.com>
 <20260313103824.2634519-3-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313103824.2634519-3-srinivas.kandagatla@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=OMoqHCaB c=1 sm=1 tr=0 ts=69b43914 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=nhzPNyzC8DtltQpxoCwA:9 a=CjuIK1q_8ugA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEzMCBTYWx0ZWRfXw6makVuw563a
 JsQIcslffGk/mYtwZV+HLBASm+7md28gHpVo3+NrnG8UH74T5U+58BLOGTUy+eB2raX9r2qIrz9
 6Ce2H529TbVvd2Ypy5iRcB8RwM2UMlGc/JwpHiYkwENUhJO4hPcsiOOBV/np3kIBTHjw6yIaY7V
 4yj9qQBSFWFnIu0YE3EzQrL5Qdt2RlDs1u9pq6IjgkfzJ3UklergG2P0otGco0kEtKMbWswvH3n
 Mowk1DUSuPcOw1En4SzRodWzZUUnTvDHsu/d0Iujx2rHgVWo7CmJsatbAYWwLG0ExhjS+3+qm9p
 +rSzR/mhbhiDDwwBFHiBb0TiD1yzhQ+GaIzz7V1IO/wb9yJTQwTviNNTCgS/wqJQtbto5YSrOEc
 lHSN366Wa5svUbnlH6EiHlxK08x/jEcTQLs1KF72sfhsDhui4lQ5x7/RL9BS4kpa4J8KM/lalD3
 uJFbGT9IoDgZ3vNJj0Q==
X-Proofpoint-ORIG-GUID: q4TsrfndHjY2j7Ysh-q1zxw73FWAHgv-
X-Proofpoint-GUID: q4TsrfndHjY2j7Ysh-q1zxw73FWAHgv-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130130
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267528-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,arduino.cc,glider.be,arndb.de,amd.com,fairphone.com,bp.renesas.com,renesas.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:dkim,qualcomm.com:dkim,qualcomm.com:email];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B0329286E0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 10:38:17AM +0000, Srinivas Kandagatla wrote:
> Add missing usb-role-switch property to usb controller node.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/monaco.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

