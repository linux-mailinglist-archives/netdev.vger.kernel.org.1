Return-Path: <netdev+bounces-206265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC48B02602
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 22:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF7CC565F09
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 20:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17952288E3;
	Fri, 11 Jul 2025 20:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k58LvMWC"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414821E1A3F
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 20:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752267338; cv=none; b=DGmk+4aExCO3CzoNT0xbyjehuO4LAK+DvYzHS5j3fGBgAB3vLifLiazRZz0rT1Du+SQIkFyE2SWXL3r8eT+GKrd1w1FSY99u6wmnR1wIoAFbty3Bl9UvMSXUS7KJhB79Af7HftCTEwvuoOFenm5qx1bbdd1XpL5tNigSybtj1sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752267338; c=relaxed/simple;
	bh=g8xumnlJKhg8TvzfYUZcKaeMMbkMPqFgS9w1YvjfoZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X9heg8PTHFVwCGHLUuC+8bdZSEApBZcWEUISY2geCrol+AXzZ6Ctt0ZkaMev+0q9sJI+fUc68HaPBuac2PCwuOXRUuGQqhnTsT9weYtAtkPPqKSRAM0Qq8PXa/6HVKwTCC01+7Fa6cV3YrI2B6iAp0AJObcG80RWJJAWsPLch+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k58LvMWC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BB49Yp012865
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 20:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g8xumnlJKhg8TvzfYUZcKaeMMbkMPqFgS9w1YvjfoZg=; b=k58LvMWCjdxDKPNi
	MYhffkoFEEl8XWUvGQXBs1emGPakKiA5d5gFbSCM6pLgrWeYa9iL3iihCfiGugiv
	4hmLKtZ/sS0k/7Xe8Jkaig19zWGBv7etDQEs/yvFVQJHEhFpCQQ8ctjiJ/j2spCk
	JexEF+MyKLut1st2nDtjDzqWXHqu7nBGgNRWesdKIbBCwoVnpqG4C6Nx7CKVT4VT
	YuuwygMcWRTB7jZz9FEDRBjs3ubBgJHMU0NGuXLa+XkiMQQykZ09jlWBdoKHgcxD
	t/8Fiz6jOMjkyHGKbLDhaPLg5Z4DmMoXcW/pPrlW91BuY76BViiHAI6ES4ka/vG4
	9WKPwA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47sm9e1u1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 20:55:35 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-748f13ef248so2329637b3a.3
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 13:55:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752267334; x=1752872134;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g8xumnlJKhg8TvzfYUZcKaeMMbkMPqFgS9w1YvjfoZg=;
        b=UxnOFcCSdQt9cGesgQjePwVUEH0DwDDM4rQIXTZxUntVATfnXRuCv3c0iWAAj5NMBB
         kuH7YJba2Uzx0bKhH8Yr8hnEkMt/5eqcHN8qjz6Q/QuCa/Jjz/M4wX8H54OJPwkMEvCg
         4IbBa18zWVYwdnJyS9p40+rLxVcoDM8vlvIrneRC867w2hyGGcA6WHtNqCU6vz9sCgMD
         gEpCuv8vsey6aaEtVktiDCpIjJZ+K98VdpcNKX0IB+RaqPAGLV5/OeTemEW8J1maLmvX
         WXKlRmcyXMIYffdhxM2wlkgU2hEgqpuyomLwrz+XeuBB7JUvF2bNncFlTpXtGB7Th6tN
         veMw==
X-Gm-Message-State: AOJu0YzTmpXfL5wVgO/MRrSzKOEL8mLtLOT91w3Q025oXUqCT9kulLT1
	4b9CflBefyYVxmeWIYdF6bAHDP2i0m1nX3zjoYCXYCqJDKoxk+y2FAv3ydiDYDvko/ClppwNIeo
	bYBzJsLjIDb6LkS1On4kOu54ckxjeQiNz2WaxSPZJd8ikdIR6J04Lzk98yYk=
X-Gm-Gg: ASbGncv/JPZLwP/IYge2uNP9qzD8hLj4AceCUgDPg73ofaWwLtZqerPE9jeCkHazKpg
	vb/mOwDtlxnGsjgYVPqB6Qrk1WeP82sK78K7KyysGWLleqPpxi8HTrdgFYrjPKk6gPZ4z9fVIjP
	MiB/B+ddUv5TZ2+b6wQyT0BaYyAE5ycVYsRC2FgBTwN2Y8YTWoZPwPd93Wj/+4pacy4z84MgcmR
	+SEn8HAFRJ6M81NAXlsd2uNNQaUAa5yoITZfN0eJtQr7Nw4+Y1lS/pBPyt3B9Q1wHt83TxzVBAL
	Rau/JVSZBf9rkrOTgRZFI6FiC/bMcXWp+BCgbCF+4jCDo1R9MmgNYHjkgsIOwpxZhrRZms+hTKC
	xFX5bvfodveOAVzbxa6FArzjiVatF9MUc
X-Received: by 2002:a05:6a00:4f8e:b0:740:afda:a742 with SMTP id d2e1a72fcca58-74edd64c6bcmr6178032b3a.0.1752267334488;
        Fri, 11 Jul 2025 13:55:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ+7Q4jYJh5aHc1D1Mi2+k4SzD1hY5UuKAGZpXpIPCcTz1Wm5TRFPEpAjDLHuHOTCW2uOJaQ==
X-Received: by 2002:a05:6a00:4f8e:b0:740:afda:a742 with SMTP id d2e1a72fcca58-74edd64c6bcmr6178007b3a.0.1752267333998;
        Fri, 11 Jul 2025 13:55:33 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e06890sm6204889b3a.48.2025.07.11.13.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 13:55:33 -0700 (PDT)
Message-ID: <b4217107-f81c-4004-8683-2f9b37af9f31@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 13:55:32 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] wireless-2025-07-10
To: Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
References: <20250710122212.24272-3-johannes@sipsolutions.net>
 <20250710172352.3ccd34ec@kernel.org>
 <934e5e1e253ee3025f617cc38ce6fc15e0619d6c.camel@sipsolutions.net>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <934e5e1e253ee3025f617cc38ce6fc15e0619d6c.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 3x4w7QhYahc0ZREZNcsEZCDJ0N_SQ5aF
X-Authority-Analysis: v=2.4 cv=W7k4VQWk c=1 sm=1 tr=0 ts=68717a47 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=udskd3E0VjEkj09em8MA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: 3x4w7QhYahc0ZREZNcsEZCDJ0N_SQ5aF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDE1NyBTYWx0ZWRfX5hNf2qhM7+Ww
 yO59pGXxaoLp3zdwfUeP4reTVp3cgGvZ6Mxe2GzuXiUP0+p9VrKB9TjDau/Anqw7yLcFLdFmFXI
 41g9qQFHabks5fmyhhyDWcJL9w4rZzyQ/TRH3QjY+nMeqvCOeyxHfxGHyN/HvZ/O13Cqjf+uDYl
 Sh1dQ36wNtZY3rWU5JaEcGekXL2VSg5+npTMKieoWprt9JKlPrJsg3M8v0Qq2PVaYWMZJgtFILZ
 bi4AhpYpeZoqcQN+WwSVGU1KpAiIIKFUDMIwr3/LQMZ66lPMxKiksMtnzxg+XsJ2gkTi7Yud8p4
 BKqbg9ztrxVrETDgXO0PISMif8yg5s4+/bvQVPACVyVL49m9z0JMBDXhQmONlqesXpz6bF9NWXa
 +1i025g1mxesr7p6AyKkDvbUlQSA5oLfMIWpv+LywnwMC/o8HJZt8gwPhjLEwJ0+/ricNi/X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_06,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110157

On 7/10/2025 11:41 PM, Johannes Berg wrote:
> No worries, and thanks for the heads-up, I can wait. I actually really
> hope this was the last pull request for the current -rc cycle anyway,
> but of course now that I said it someone's going to come out of the
> woodwork with a fix ;)

<sticks out head>
I have one small patch for -rc7.
I'm holding off a PR until Monday to make sure there aren't any more

/jeff

