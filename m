Return-Path: <netdev+bounces-171403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8B7A4CDBD
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 22:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC2C93A7A2B
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 21:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BFF1F09B6;
	Mon,  3 Mar 2025 21:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gGJjuC1r"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8711E5213
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 21:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741039002; cv=none; b=TpAW4tv6WGnIuRfIbXMIu4L9HymdjTmwFpoUo4kVC/y1NLZeY9AAGiAIIDQDWUeMUv6+TprOO0BAfboP22IQQk4VsBV2wIokZqblqlXwjHvpjiNbCDJZaYfaTCatN3Lfd7cGmzLty2ieCs5fyGVJeoV6lPnIgyzC5cbuy1Q7BR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741039002; c=relaxed/simple;
	bh=hQRHnDkkYYJm1kGP411WuGPS6pRSmfEvNG8A2sv/jFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LOOIW0cLqRAbqwnRcO9fj7pd/6C4tnXXfcF4Eo9LjhZUo2xC6Uvgr5foA3meqf97apsdsAkKZrKOf1DQJMZsyh+hdn6iJ5rm99y1oKibH8+Z7n8wl44pCH4xsVHXseEPHOXlfzivQ93Z4eZRlBgxk+H/nvf8SSMsyezkmvJAVAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gGJjuC1r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523AgQXF018910
	for <netdev@vger.kernel.org>; Mon, 3 Mar 2025 21:56:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Kdn0EPWjFWi47gSGgVfPoqhV4FTHW45fU21tUvu6lFM=; b=gGJjuC1rR3uk/jKs
	PyqX6LaRjzfVdTM8o2IIHA8+VSQvpd8NxuRZ8q+SvGrQ7pZEkc9wx0OPfJizgP9U
	hIprJcrb6w8Nj2Ys3RqKH6hoNmJ+CWOwsyik6zgpcLSvttHnpysQzm41xkZJIGES
	ewnI2VPLLs5OZrLoXgbKMju6I77fnWApKh2ZdLhy5mLcOC+svC79AA2uICJ4oZuK
	E0879FZOme7PtrDO94DZBgi+KEQpGpfyaMBjA4VLqqQ7kQfbsBHE8Xh7uGOUzzl/
	OLpATw3+Zv+2GmFbFfuGd0F+O/SAB+NN+NsSfVcdWQ+mnKbKk5fgLiy0kApUk4is
	OJQxzw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t6k6171-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 21:56:38 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c3c5833b58so21506085a.3
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 13:56:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741038997; x=1741643797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kdn0EPWjFWi47gSGgVfPoqhV4FTHW45fU21tUvu6lFM=;
        b=sPZo5uzUPETbx8TN1phbyBwiQRbbctPkX5Y1W4vm6UB0/i7UaCAzLJwHFzK5KEEeKo
         g1ZwutpcvSKX/aREBpS1wiqkZf7Cnt1vEo9Mi9OWg2rzBx8qdXpjEOPD3Haux5EAgTZj
         /CPLm3CiETvfw4E9h0ZBoNePMai+ITRPzMx9Y6HG8JhYP2DaK9C8i4I7E773fuigvslv
         93uCDIqEUMlqGhetaHZDfqxy1J0d9OIOFUNfemGQ8Rt8y7n3WZBJNg19B1GsFRbgpvNK
         Y48G3IxiSFWMC2nV8iKUuefUcT0R3yhqlpOOIz0mckqUQlnoRwUtJQ/jpCxr222kkh/J
         TtKw==
X-Forwarded-Encrypted: i=1; AJvYcCUh1pI2jEGTbF/BzqDgN35owutUWtNT9a1YXDyJNCfDe3KGj0LHLLZFB2RNNnZUOQO65rEmAiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKlKFroMCAdyFWbiI+PI5d/dNTLlxRJ6gq9CfUx1z0rxFQIxbn
	908jHt+kd74Kk7100iUtujvO/TYn6VO48dKbfcjWYVRSgZW2MDpHTsCyyMr0dygLZBaL5H8/sns
	3BAAjff27gZz7CBRfpUtsoXdLQM0f9ckPvO/aoJxJ7RGKga6+f4yU0Ms=
X-Gm-Gg: ASbGncvAWTHmsokburHVwmk4jC81w6VO+PdAAJUSagItas4UJKWpucCu2x4lnUHYwg3
	Fy3weBbPOTNdSUJJ9H6q2WI+kk2Sep53/wv6j0MNu3NcswbswFnMMi8ycGdZxeOEKaeRvo+XIow
	CQJtdhwT6J4HPHxjdCYoRyJdWa6lQqm2sQeL52udjJ4rjQ3d6fV5H5V7LThB1kWDa4ujWIwj/+1
	KFEq7mQCL925I5leEAl0UtJ7dd/NYMmg+nAPic+HE20+F5HIVJyrQR77CZn9U/AD7EJWHSKxL0T
	tqgEcS7hpcq/rtqgq0kiSmOo47DgsdkxDj/nkGOq8ClA7v9nbsSGvc7i0mo0MmuwPlNRMg==
X-Received: by 2002:a05:6214:2aad:b0:6e8:9ed4:140c with SMTP id 6a1803df08f44-6e8a0d6de81mr72805996d6.7.1741038997594;
        Mon, 03 Mar 2025 13:56:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrJuoSvkjwi3RX1KRgiUtMf0XgXWhFFVFKUGmACEcoXKDG2ph4RBblLXA+X1oIIsGokl70Sg==
X-Received: by 2002:a05:6214:2aad:b0:6e8:9ed4:140c with SMTP id 6a1803df08f44-6e8a0d6de81mr72805786d6.7.1741038997268;
        Mon, 03 Mar 2025 13:56:37 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1d860c279sm172592866b.27.2025.03.03.13.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 13:56:36 -0800 (PST)
Message-ID: <33bf565a-82af-46d3-920a-ed664aaef183@oss.qualcomm.com>
Date: Mon, 3 Mar 2025 22:56:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 4/6] clk: qcom: Add NSS clock Controller driver for
 IPQ9574
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, andersson@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        richardcochran@gmail.com, geert+renesas@glider.be,
        dmitry.baryshkov@linaro.org, arnd@arndb.de, nfraprado@collabora.com,
        quic_tdas@quicinc.com, biju.das.jz@bp.renesas.com, ebiggers@google.com,
        ross.burton@arm.com, elinor.montmasson@savoirfairelinux.com,
        quic_anusha@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20250226075449.136544-1-quic_mmanikan@quicinc.com>
 <20250226075449.136544-5-quic_mmanikan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250226075449.136544-5-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: abLN7pc3uw-h1CEsuZA9Fi7L6vNETdNK
X-Proofpoint-ORIG-GUID: abLN7pc3uw-h1CEsuZA9Fi7L6vNETdNK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_11,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=637 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030170

On 26.02.2025 8:54 AM, Manikanta Mylavarapu wrote:
> From: Devi Priya <quic_devipriy@quicinc.com>
> 
> Add Networking Sub System Clock Controller (NSSCC) driver for ipq9574 based
> devices.
> 
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


