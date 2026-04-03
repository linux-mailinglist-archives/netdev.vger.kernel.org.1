Return-Path: <netdev+bounces-275171-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEjZOJwU0GmV3AYAu9opvQ
	(envelope-from <netdev+bounces-275171-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 21:27:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4709C3979D1
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 21:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05A253024943
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 19:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757593CEB84;
	Fri,  3 Apr 2026 19:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EXSIPFJy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zunm/znt"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1846134B19F
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775244436; cv=none; b=fVgs0kkiSSFBfD9PHBzdOw9NKPHq4N7SI23dPRD6CudojdNch075WB8ZRvje75mDP9l6rZn+QmMulQeuX/Q0FRcXYijgWI0eXHCpg5kEbpg+O/NNKlhzGRGvkLWr1INYieTT2V0UttAtIu4xVNiJuLTUaOIb/j+MRUXu/kgE0bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775244436; c=relaxed/simple;
	bh=OU3SFsCVwVCAtNYnROQaThuCZy/FsLCS9vTE9MUGr8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZu1Txx9mk6nsGvgol5ADYG8HVGvIZ2VxN9HOdIkBtLKXDuOPXelBWnd+6AZxlJigNVHD7qxiSOTxZvXEQOywk4aCvSCXxIFBwOogGipvOIlUCmF7xJOAgEt4eKWHQANDiKgkueGXu23ERglWij62nxpYOLTGk3rfQoZKlyIgr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EXSIPFJy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zunm/znt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 633DVrOr2359658
	for <netdev@vger.kernel.org>; Fri, 3 Apr 2026 19:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EeCH9MesYleZ440DjmzWy+Bf
	mTOxuDkYk/i+DHg42j8=; b=EXSIPFJyEMHuMoNIEscCihVLG+TT6JAnC8buXY/v
	mFHjcdfXBtXC+y6UqoCtQWrFAwwZxHygD+o+LQektSBsm37VZ6EgK+jV3WXP4QMQ
	WyYU4QgIJsNE+hPKZWEqf2bS/xVEcDltVpHk2wGGpgZgkvFf5zzmqHyoyePOXVpi
	6AU72sYWx2mNOOL8ki9EMdXYyj2CycU71pM/gmniluOAZXlLWbnqjnNlKuTeSVx4
	QIGDCgUHcGRQUv4mtLnnBUFNzrXXOcVkrlrXX1lDxS03eUyz9i0UzQGOu5aPlCC8
	BayyaSui3vxSjTn5S5cAETdIb4WtGCutIuU8rWpU7cgvqQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4daeh1gxk5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 19:27:14 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5093025ffecso38794411cf.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 12:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775244433; x=1775849233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EeCH9MesYleZ440DjmzWy+BfmTOxuDkYk/i+DHg42j8=;
        b=Zunm/zntueM8AV7lkTvD3jJpxhUDIQOBVV1yLBz2qPFPRgQ+u9cMBMyVM2s2RZ+e1L
         nSpIju/KUighKNP7q7Xk8yguGzPyBWofHCSgamm8qJZuVo4gd5UkSla3EciXvvLasJK9
         O5hR3Pg/dgyEQsUmoPN7Xk4Mwquw7gUdUwfel3hZ2O6j/0oooXhb2ZnUov1HcAZd91mQ
         qjTTcFR8bgzB3+1YKV3iFp6ZIJvZd4DCUrNNADqMXXvh1APuLsdB/28i4K88Y19cbXaN
         YZJdruF3dFvL3h7A8az2YnVB6W+CnoIjPJp6wXJfcQ/vUQHZW8UokUwSHIstVY/hb18K
         SlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775244433; x=1775849233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EeCH9MesYleZ440DjmzWy+BfmTOxuDkYk/i+DHg42j8=;
        b=i3esw1V3GyMGp6oNit1KUDUNC6OJCUgLjg7vfKz10cf74uIMwxsUqvvDicWP9MlXb3
         OFi9Tnr3oO+V1RslvoQAynwJh+eA+aJ6Z7B0VMDfs+hfsaSj79vnW9fOyQ64ZiDJrdr4
         oQA3AZ1ciT4KoKzEr0IJtuLY0TmfBYTrK2NvRuNwaNv00Kw37Ov1nmK5yboNwh/aKsjb
         XDlTY9lHo7x51/QZVYEbzYZkqZqF/Wlw43envn0cPMdyVUbkg8fLTaikeK956Yz9Fo+B
         X0uCK2N/rW17keY6qhg0KAyZZYTCyArMKbMcCWiLlLiwfy+7QX/8s+h4o+P7lyNNngFF
         cA2g==
X-Forwarded-Encrypted: i=1; AJvYcCW6ZZRVDBohRC8n7gMl0dBopZiPPrjWyh10NYWPvIz1ac10rRwLdm4x2PYcpxXoxs4mfS69I5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YywIy96eMUyYGI7vWbNXbQjPpABlWZ9c8ML9tOWm33Xtyz2xlVa
	hPM+CeLAGDWYA1TxmrWOqm6BrPHOuqC3nYMs8+1gBH/eI0B5Tsd6Ns2cYWcaSeVrxFVZXE7kX5E
	7j45/z3lZ51RJ4EnViMFQxaBRo0aXyhOIe+LrrrwNjlCllHOFHOcdwlMwPNg=
X-Gm-Gg: ATEYQzwZlZCmviHzr6WnumV7K1dG3i6C59/15MkkzlpLKh1K97BMGPccTGiDQVgWs7M
	eTqHoXhTho8PfH7GJOjwnBudbR0MOWWVFV4Irj9e3VB6Jl91XTGO9zAVsK+9zyu3y2wUj2zW79E
	iLlglHRojRompm9HJcI4bCjIxjKOrRAI6DYF69L4LgJS7F3LuWk7kghkqQfrlwm62Dxt/y+tBmx
	AAc3nn2Y+FdkXR+LjWOufFlBy/5sGo/SYThml5G+8NR1vM2sS0nL/d0an4F7X6JmNbwkwTFTPwt
	KZ/8KE0mx+rgxwL8njqQfz3gnljpYUlfy69WjKYHeo8U7FFblZ/vF2nt05N0hI3AjvcAPR/2I+j
	rerBrs6QhsC6UmQ70IQE3v2uFARCeE6hSmrdUqBA/rGH1G+z6auQouxTjZXcemHxpA9rm+pwwDX
	5JO83uQ6U6W9SdyWFKd02KjboOiQT5pPTcXYE=
X-Received: by 2002:a05:622a:5598:b0:509:3cd:b243 with SMTP id d75a77b69052e-50d62773eb1mr67413211cf.21.1775244433479;
        Fri, 03 Apr 2026 12:27:13 -0700 (PDT)
X-Received: by 2002:a05:622a:5598:b0:509:3cd:b243 with SMTP id d75a77b69052e-50d62773eb1mr67412801cf.21.1775244433039;
        Fri, 03 Apr 2026 12:27:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6cc6089sm1638171e87.50.2026.04.03.12.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 12:27:11 -0700 (PDT)
Date: Fri, 3 Apr 2026 22:27:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Koskovich <akoskovich@pm.me>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 5/6] arm64: dts: qcom: milos: Add IPA node
Message-ID: <qt4hktac7i2nwuoenlbu4mujmlp3v54ak7glbzu2roxvz5otr4@ehkqawyhiqu2>
References: <20260403-milos-ipa-v1-0-01e9e4e03d3e@fairphone.com>
 <20260403-milos-ipa-v1-5-01e9e4e03d3e@fairphone.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-milos-ipa-v1-5-01e9e4e03d3e@fairphone.com>
X-Proofpoint-GUID: WMATfdhIMrassxojzpGO8RoD4DfKxXhG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDE3MyBTYWx0ZWRfX7quz8AK9NoE/
 VPcQFA8CgKblrZ7Kh476DF5B054D+q2QsYFKtKZvrS7bl38dYw+2PtFUyXlKNxc+iScGRUTCYLp
 Vk3LuyjTs/n5lYAW9/3iF48bdEyAeoRjWh+cZX4H/FjSIBsQ6/pY3U/mKD4nsc7l61+unFdxKJV
 YhfpEKyjAo3P+wqLM2FZPLxqCm6t2RtABSv+nZysnlrA2pL5yclG9A/aek9++S8ffz+Ly48fUNK
 Z61InxnRU8vntTWH149RNGaTfYN9AQJGLZ7oRua3rcMzJax/7E77SPRkrqwoODLhnKFaD+rn6pg
 EIQdUvS2acqtEsvdU/bVUHQHh9ooCpeUQpVAoIoFCPEV+Jsxhf3AKzK93euyjUMCHjnkTf1DkL7
 PzCuPBMCMnIcS5W76NbDJWnmAD8Ue5C47S0U38BOPR+2ShYQAVwLTIPpsXXCF/JsnijncOzp+3E
 gtLZE14kJWjt9IXP7wQ==
X-Proofpoint-ORIG-GUID: WMATfdhIMrassxojzpGO8RoD4DfKxXhG
X-Authority-Analysis: v=2.4 cv=JoT8bc4C c=1 sm=1 tr=0 ts=69d01492 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=6H0WHjuAAAAA:8
 a=EUspDBNiAAAA:8 a=Z1Ti3UXaT223yONGORYA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604030173
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
	TAGGED_FROM(0.00)[bounces-275171-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,fairphone.com:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4709C3979D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 06:43:51PM +0200, Luca Weiss wrote:
> Add the description of the IPA block in the Milos SoC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/milos.dtsi | 44 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

