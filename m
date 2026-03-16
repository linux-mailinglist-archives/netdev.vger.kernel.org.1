Return-Path: <netdev+bounces-268107-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LrWNdbft2mcWAEAu9opvQ
	(envelope-from <netdev+bounces-268107-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:47:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D9F29832F
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A768D305DD66
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 10:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE3838F94B;
	Mon, 16 Mar 2026 10:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IJs9mvC5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RNpz1DTW"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5550E38E5DE
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773657750; cv=none; b=T81ediFrkI+yWLgTJjhLJ4jum7d+s9UYNzMWxp8XvcCkKyaOifV3nXbtECSyZv2vfhr8ND4WUg0eq3OBk4OgtOKsTVuxzLfxs04+4nphAoqO8qnvFjp79DbpNWHsP6d+vaQRIMtN9/UtZUy7XPmB57f0VdHJp2SSm7L6y50x5PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773657750; c=relaxed/simple;
	bh=+VX6yr36XSuJ+T2uuAMUjlzRmJztzlSf9KUHwc32IDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aRLCKjP51PqYhu1KOLhw57mmvdkV/Vg19GlY6VHw6bk8Kn+uT2hPTtZn1x0ka8l124AkXMD1OzTQw4NsemuruPEtYa5/V5h5XA7SpZqsdZQgKaXGd3j0ySokye74Y/yAnBtN3HIekIySg94b9rceL7vey9sikq6uNqaYfi09pi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IJs9mvC5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RNpz1DTW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G64g2G663079
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:42:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tXFgbdW5bN3sPwSAvwEroYOSWs95yTwVoniyi5meEto=; b=IJs9mvC5Td2n6iaN
	1d7+4tHZ6jRZtzDU+iO8UwsAvJPNeUPpLQwS5ykMos9ko/B/m1GMC8oTPEPZA3zX
	URsFeXqCJM8LL3edvRq5AeRR4VPeS2ILkvQRrDRWkr2nGUXhsHGoClKjgGTsBcl2
	sgTAwZTAglNju95kME2c2zjewjNJDEVoNrJl6nvr5sRzTuM/dfx/+SYqCVXQOHOq
	6vPZXgrK+B0Au2//VcGO6QPuCNWTZxUou9Kjwy32YmvvGBdd4AgnFWyxK88CI8XS
	JJ8YDyoZXRs9QkHOz5aYSjYLKD7aRAs3GaFRO7b1R1wNNMfZkGkS9gPLyZq+tUZ/
	XQ347Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw043n8p6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:42:27 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5073ed1ec6fso35193721cf.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 03:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773657746; x=1774262546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tXFgbdW5bN3sPwSAvwEroYOSWs95yTwVoniyi5meEto=;
        b=RNpz1DTW0rqlY7o59UxG6N4nh7KuUFTOCpethK3q916KaCkhPeiET0QFEBX88GOBpe
         uXi4DFmo7HDcRiOiPr7KHsUETKcYcaQkYxrfjtsHymm0oA9RcCrrhVCdHyzG5+19QSqS
         anKsljYEzGf35zbpyeF+xqtg3UQwF+ji+nVTcDmt+/JaOLihc98N/jfB6zMBrPKhddTA
         Zyayk9A27Tbq5PjZgu14FKQK9j1b04Yck+1lISIXI1/J7QAuAl+ZbWKOASGq+ERNowfC
         Jik7TQ2y4KhZBVVIbFz5eHi4BffYtF25CpVPaJYG2hhcX8t4E71ycHgDovysAYFFAkXH
         TjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773657746; x=1774262546;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tXFgbdW5bN3sPwSAvwEroYOSWs95yTwVoniyi5meEto=;
        b=sB+D67BMCvXIdZnvgEMhyFikeOi62z5HkQ1TTEOdiW8DBpcT1dc9dhXquE3joa3Znc
         g2jFtF9jvMm85IjtCda/n05SGwWiF6N9dS9Q0cR+MwSZRYzab/KJdUeJ3u/ehWGPTFF1
         XFs2C5Bqc/uXsH7jmUg3YvZPTEwfejkfCOoad4KkHtrOr7Z9K6BTiJcasX+L1O3zD1eG
         4mWhlDn4ASrkhu6llDzs1BT1WD3qvGs03OIdiQf6lV0kGeY7pFe7QsMdaP3dVz9vXSOQ
         0uFqKhTLCbCZsHUEabVThB7mlcgq2o533txCgvQpEyGHVNHkGR6Q/TkhoQLQNIM5xYVS
         bP6g==
X-Forwarded-Encrypted: i=1; AJvYcCX3c0orWs2ly1LVYEct4FD4x1v+hUpCTvLPIK8xwjsItopD0nD+D4UfCvtCHLUiFX8aBdsjhO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjvSB5z6+exs9/gW1RjxRE2lG662dTvD8Pn640he4rNP3sLrA0
	n8clTpRk+QfgsnpwG+/75PtZKsGdLmyF767KQy9EFKCRbpwlNpt4HwnL39yFKZEHsVURu9ULKG/
	Dn6IA+L+Ele7MdSk53a08EoMaCO8/SB1d3Bi9xKUsg4Co64ImmRCnxwXilsA=
X-Gm-Gg: ATEYQzwTPTODtYB2ZOIk3lPqOrh9tXWXrFxQ/tJktCCMD10v/GuCXbDO5m0Bd5nl3QR
	YNy/B15lo8Bh6CHfIDAFJq+gNxeitPI0pwv+bQdXfIhmGtFEaJr2NmQEcgvPMuZ3GRXJCkULwEj
	15Q+hkuUh6vUxxQtyBDo7WN3MdlFuUwNM3f4qPWqL4ZPjLmfiabYyrmb3N6cyxSBTarVfmdSV49
	lWBHXCVwobpc1A52bEZMPq7F3TiVTwhVe+P6Ivmd1ewA4SCmPa1gFm2EPjGqSyAs+R5jSg5v6I/
	ZOF2MfUQw6ildlocOPdUEw3nVdPzOaJLWEvEWxVzJhWbmpxa9Ox0Qohpg2IXlfxzBpHSHE1NhDu
	vYbQQ+U0EnpeG+2RMFLjK/T0EPn+5DMhFqrmrwXoIW538nOqkvUTuRpjKV5ky6yFJr8+y1KZzzJ
	BQ2gk=
X-Received: by 2002:ac8:7dd0:0:b0:509:9d9:e19c with SMTP id d75a77b69052e-50957b90577mr132596961cf.1.1773657746673;
        Mon, 16 Mar 2026 03:42:26 -0700 (PDT)
X-Received: by 2002:ac8:7dd0:0:b0:509:9d9:e19c with SMTP id d75a77b69052e-50957b90577mr132596711cf.1.1773657746247;
        Mon, 16 Mar 2026 03:42:26 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9791c113d4sm429381966b.6.2026.03.16.03.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 03:42:25 -0700 (PDT)
Message-ID: <5a3e70ee-abf2-4ce1-9607-877da7fa45d9@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 11:42:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] arm64: dts: qcom: Add Monaco Monza SoM
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: richardcochran@gmail.com, r.mereu@arduino.cc, m.facchin@arduino.cc,
        geert+renesas@glider.be, arnd@arndb.de,
        dmitry.baryshkov@oss.qualcomm.com, ebiggers@kernel.org,
        michal.simek@amd.com, luca.weiss@fairphone.com, sven@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        kuninori.morimoto.gx@renesas.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Loic Poulain <loic.poulain@oss.qualcomm.com>
References: <20260313103824.2634519-1-srinivas.kandagatla@oss.qualcomm.com>
 <20260313103824.2634519-5-srinivas.kandagatla@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260313103824.2634519-5-srinivas.kandagatla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA4MiBTYWx0ZWRfX6130dxTxdEBQ
 ed/zO7lUy65TxgMYpBE/WTEeTcGggkuAk5q9zXKbBnWqyFV+Otv8VVIP2Z5Z1pKDzqx+ZUfKhh7
 cPhJgwZICnOC2wyysdKDeuS4VCRzPbo7hTByukSONmsKrkblGTsdbmk2jFwHKOJcO0Y1wJPdgxR
 FgotCtxbKENW+8o4nezXrhOss2g6NBfpLuAzTl+erk9A7ZKTCqb5kOXC3S8/PMHGgFjfiPPQkzu
 n4VLBvOGEo4+7Elqgcl9Wfd1KDFssIzdChmG4kv9LTru+3YL6wuV/X9fujs6Jt4LyEobXt1KCGg
 C9l8LmO64BtsOHUEXhSODY7F7d68Vf1rS5Ac7Iiy+dHEcejfkR/Gk7hVPhFlyGPncn0HjkBl4G7
 NyvntFOM8GwCDd5MDRVFm0qTvRFXOKCtInj3Lhr8q9hvrjnbOmHsq+QRNPaoQFXMotzDvJj79TE
 FtoE2IoYFYvjt6lM7Iw==
X-Proofpoint-GUID: B7bqlI3ahnYBPhkLK2-7ImSHf1hRSriL
X-Authority-Analysis: v=2.4 cv=fLs0HJae c=1 sm=1 tr=0 ts=69b7de93 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=PhgHo22kut4TJJxNvVMA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: B7bqlI3ahnYBPhkLK2-7ImSHf1hRSriL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160082
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,arduino.cc,glider.be,arndb.de,oss.qualcomm.com,kernel.org,amd.com,fairphone.com,bp.renesas.com,renesas.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268107-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 38D9F29832F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/13/26 11:38 AM, Srinivas Kandagatla wrote:
> From: Loic Poulain <loic.poulain@oss.qualcomm.com>
> 
> The Monaco Monza SoM is a compact computing module that integrates a
> Monaco/QCS8300 System on Chip (SoC), along with essential components
> optimized for IoT applications. It is designed to be mounted on
> carrier boards, enabling the development of complete embedded systems.
> 
> The following components are described:
> - Fixed S2S 1.8V rail
> - PMM8654AU RPMh regulators (PMIC A and PMIC C)
> - Display subsystem/phy supplies (DSI, DP)
> - Enable GPU, GPI DMA, IRIS
> - PCIe Gen4 for both controllers and PHY supply hookups
> - QUPv3 firmware declarations
> - REFGEN always-on workaround for USB2 HS PHY
> - Remoteproc firmware names for ADSP, CDSP and GPDSP
> - Ethernet SERDES supplies
> - USB HS/SS PHY regulators
> - On-SoM eMMC
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---


Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

