Return-Path: <netdev+bounces-246422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C53DBCEBD2A
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 11:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2DAAF300F60D
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 10:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5B93203B0;
	Wed, 31 Dec 2025 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l9LalVlH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HfFUiTcz"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9864315D27
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767178557; cv=none; b=pksga6AJCZOrM0BFwE4tlgcJkBn3J/P0Lh3d8FD7pWV0yisB1gmCudtng6QZWTbDRjOytOXp8Unp9YLvrv4ULOnSN75N0In4e404biGKn1C691PwGwHExAEfJmhZo9XyurSvZ9z8pZafXtIzcsBAnS+v8fOmBC5MOWVOYDNEjaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767178557; c=relaxed/simple;
	bh=HaoGokyMCKS6sYN1xubOMqBe4hgsaEX+B8nRrEYfBZI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Zc21teILPiPWUNRFsGU5UR7nzz86qaR/czRzyaEowagxo4Znzmhj4mcX2bokF/rHRWooc7gMSTHizQqljJBhqkXKZOvAvWeoMJZqGZPdmolPiP4aXN9Lx1/h3mu8bDI8d6S0j7ZQFg2gOW8vtRTpKMZ/bzSoCGa80xfGC6/zB4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l9LalVlH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HfFUiTcz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BV78f3S2733573
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 10:55:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O+f7Mi5vx+QI3KHSGUaTpC6QdSIVzAVg+5x+XC0DFt4=; b=l9LalVlHnMCVESuA
	ktNoLFmYgR+yMVeRPmZ1JFaUS088FgaON98gaUXZiHac/q7y5EeYEAVhiSnb1ZAs
	bYT+nenGTAW/98+5957nIK3Pr9Yc487SIjLLFsPE3gnkNCbWbIo3ZBBxFrTCoTdK
	khuLOhMy8IAWzxCWzztVs4hz4Kcl5cvgc8fD+mE0Mfp4uZWixQ1IaVnRZ1KWAq41
	edQTCHKA1PUAvPJLc6h0JiA83UANl8JKbLs7O3Uf0ZpoojkDqxfTTdBzgaYir3SN
	77Kp5o6ebyhoMAclhFdxW9LbhvNNHHTcT7l7pkeRIVAhRR6276p8C4+OyjObaxgD
	SQHIsA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bcy6agcnm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 10:55:54 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7c240728e2aso22644470b3a.3
        for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 02:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767178554; x=1767783354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+f7Mi5vx+QI3KHSGUaTpC6QdSIVzAVg+5x+XC0DFt4=;
        b=HfFUiTczOU7GZCcdWbWDLmb/x3DuX+wplIuleNmadADf2e84kdJGpRPnO7XShR1VKS
         pXqlsl2eQVjE4f6YPvIdDJvARxY/1S6cWQa3aau+XLDKEnxxw0vj9zOtajM4GrONdiJQ
         Pr0/YkSJvEtRbVXkcI6z5twBe04IDjuxeHtBrSz9i4JP1ZY2SITJrI8nWf4MZ3hBUJYg
         Y1bzY6Mm0b35QQWoON7aYQdwrxDZ1FjOPss/l8eUR2edwFAuU5Esuv6LzXOeQGasm7Nv
         zd2eHs+IBzk2pVXziuulWxqUAMSxZFq1ydz20ym+Rs78Zr6yv5Wq7IjLaBc1iEmH034P
         5Mtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767178554; x=1767783354;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O+f7Mi5vx+QI3KHSGUaTpC6QdSIVzAVg+5x+XC0DFt4=;
        b=AmtnV3mgGHGnJefBpCCFBDaulwiodrd59GHxhpGzQpxOhKGUvPkLAV7QJ+tRdnVcoy
         KvQv58h9olUl/I6KGJZCaLKoN9jOWYwDxWjQ42KKyXSwRCVp9vVMHAHk8lpuzXSgaSEn
         JAskTRX4Ny7yO75YP3l5CEdq4LY/Mj3ZzUueyxi0hf/RlQ640vqsLSzb+gJOG70EjbP3
         8XoI21YRQEKF5gxsPfy7RGG2sF8s4ARCATKMWxTqCjkNich8H60K5xtN61cNHgs7By28
         pjpk2bwvgJ5qG9v6NNZCKiK+f9mO2uXcD7XvhH5R27pxTIOVANPzqmxqPigIkmVSRt54
         udQA==
X-Forwarded-Encrypted: i=1; AJvYcCUvZT6LjGhJSZ4I8C0cOgU9wczN6f65R3Fqb9DxYJA/aH7ASbvfdM4RO5oGeVXoNKSsYANDTzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv/UPUkfN2gwJKMiyWckygBj49e9LE2wr7ICMyb0eBPjQPmubT
	0O+rWf+PMfaRBCAvzYh/UdprsSyQ5m+U/V32xrtAZl91Smx7rceluLlL4AVZfGSbL5wEtCgURKU
	LuPkbufZb216rVl3R1bfc41gygplUNQDRi5zjU4yppRxUvBFeslgMEIPDtIU=
X-Gm-Gg: AY/fxX5nWsZzWDlzJCi6iqS7zPtLQOzhYgdFYfXdHAcHlX+54pFBd4lFJcafIdfoEuP
	i1yEEoU9a2kmTDu4o2+LE0lvaqFI/MJANok6lGqw/qSAuxqAh+i//mmiMVlfykiJwgpOZpfT0/s
	7Gucu+3OSy8mLzVHusQ3kHVBwUO9UYedLSv+EiiNlCGtS+p1osF4IMmUtbJaBcVI0SdL4FbG6uD
	a7iCJWU74Ba7zm5aHdj3Zfzis4oL07ZZrbJg69BXtYpRRM7tA9KG07A6WWc0gZ4LvR+gz35q/uE
	Hc5BwJyb9ju9zRgiIAxHoOwD0D8Vl/ZffZjXI4+s9r5o4A+ekftZjJrW33r1/kSA0v6yRBiczxK
	Dq5TrZjId7HypSyj49ylgQ5rdLbwHPiCSti2GiA==
X-Received: by 2002:a05:6a00:348a:b0:7e1:730a:613b with SMTP id d2e1a72fcca58-7ff64ec6724mr32190518b3a.31.1767178553537;
        Wed, 31 Dec 2025 02:55:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGioiLvW2U0joeR5pbtZjSEPSozpQwlq9uIpJCK2UPjGGzU6NNfRTPRLdM9fVlDl9M9HcekTA==
X-Received: by 2002:a05:6a00:348a:b0:7e1:730a:613b with SMTP id d2e1a72fcca58-7ff64ec6724mr32190489b3a.31.1767178553048;
        Wed, 31 Dec 2025 02:55:53 -0800 (PST)
Received: from [192.168.1.102] ([120.60.65.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48cea1sm35616794b3a.45.2025.12.31.02.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 02:55:52 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, netdev@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Johan Hovold <johan@kernel.org>, Chris Lew <quic_clew@quicinc.com>,
        stable@vger.kernel.org
In-Reply-To: <20251218-qrtr-fix-v2-0-c7499bfcfbe0@oss.qualcomm.com>
References: <20251218-qrtr-fix-v2-0-c7499bfcfbe0@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/2] net: qrtr: Drop the MHI 'auto_queue' feature
Message-Id: <176717854647.8976.2100798756796791971.b4-ty@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 16:25:46 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: M4kjluSYBMeSYX3NjaA9sVv2Zo5b6y8g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDA5NiBTYWx0ZWRfXwuzchpTiACk1
 w6dLJb2z6mRhNY1/VM3YV0Ijl6q8PG+z48bZs5EajLF+xCcWkpOxoZ6s8Bmex7j+Q6qh7GERA+j
 DqFldfdvR0+p/4q/wl8E2qaDv7UD9Jhc+4WMpHjdXS5vfCGky7FsFYL3kC7PE38Bssrk1GvueWh
 dLnqoGJ5wrfnmfacKA19g4IU4Cy3C6BrhxKkrMVWuoeAlhUxYHwxfGEQCHlFNgUjE0SXyOLOTHR
 Lxo8hp1rTJ6XxevJ5e5XPSIjsxY/kjhm9QfyWRODWZILgsCzpVef2pzzyCxU4r/BwmBxldQciy6
 32bmtfqYGoTy9HadFgEnjxTaCbY1ajeKaiytD8h18IeP52H7yMjWV/+TxLxYPj75P087LuXaBlM
 E90WpzxxFapJbtdtyLuom3jpjXxRP1+exhTlPoG2B13V9op9PEjxKUr3JLuRK+LS8jIZW1ocZ+/
 77PwStF0KcLo59sBafw==
X-Proofpoint-GUID: M4kjluSYBMeSYX3NjaA9sVv2Zo5b6y8g
X-Authority-Analysis: v=2.4 cv=J9GnLQnS c=1 sm=1 tr=0 ts=6955013a cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=+SK5D59PVgoENw9OlSzWFQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=d1LwL24QG6zMnwvM45oA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512310096


On Thu, 18 Dec 2025 22:21:43 +0530, Manivannan Sadhasivam wrote:
> This series intends to fix the race between the MHI stack and the MHI client
> drivers due to the MHI 'auto_queue' feature. As it turns out often, the best
> way to fix an issue in a feature is to drop the feature itself and this series
> does exactly that.
> 
> There is no real benefit in having the 'auto_queue' feature in the MHI stack,
> other than saving a few lines of code in the client drivers. Since the QRTR is
> the only client driver which makes use of this feature, this series reworks the
> QRTR driver to manage the buffer on its own.
> 
> [...]

Applied, thanks!

[1/2] net: qrtr: Drop the MHI auto_queue feature for IPCR DL channels
      commit: 51731792a25cb312ca94cdccfa139eb46de1b2ef
[2/2] bus: mhi: host: Drop the auto_queue support
      commit: 4a9ba211d0264131dcfca0cbc10bff5ff277ff0a

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>


