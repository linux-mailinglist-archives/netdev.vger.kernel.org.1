Return-Path: <netdev+bounces-182430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE435A88B7A
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE4B5188248C
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61022820AF;
	Mon, 14 Apr 2025 18:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="niJ9a4qZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7A4192D6B
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 18:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655896; cv=none; b=pnBB4bRuMTJ1FwCtJJZKdKxYlAMeT4XWPTTwJSzRJ2pt/JpFBuKJjS2kzpZsgTDqZ5NsWlkWlTA9RHCgkoCTZUdNTLE+Q2ev3nvas1bMYxMAbSEFUyXpaSHZOgej8DN2lR/QjfMiSK8S8SPYWy3KAWGIE1v+0cG8RvcOtV0O8oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655896; c=relaxed/simple;
	bh=kVuTySIzGwZ0NsBWBZfQiNPB6+9LtFwOJxGANJZuFFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ai4GMAhu340oHTn+d9kj4Jxz5olMGP8WRGAWGUhkvv7h0WsT+1f3QkKuOZPwbDBNxvNVqwoTfIc6JvSgUC6OPulLlacscnOXuJQYdWU2VGyFaDX/r5gGGpAQNKyZy7rtqqm4IBsegQ2rqsqZjXoZpBDpDaewqHwLkHoD6Q33hqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=niJ9a4qZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E99mlf012976
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 18:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kVuTySIzGwZ0NsBWBZfQiNPB6+9LtFwOJxGANJZuFFY=; b=niJ9a4qZ4Bj8yt4w
	RiLzG5l4enDSFO2UW6QyITz5s9SJIdOobOPGWi750JBf6s6No/8KECGsl1g58BzH
	CuzNbOe8paxomXUhIMHW+LpMB55Phv/hNg//m3YZTcgEy2sl1PWKqh2GPXIS7Bnv
	CyOfNKUatZyScMJKre2Io9pjojtu1o1rXwj6hhf5Nhgy1KxS11CY1137cnHaUYQA
	9ENoshBLfrbGMBgLWtbM/eUASxoFhqmqt7uPrqohgYKJvZ09DHZvHp0EbKpxUX5a
	AlasQz3VDaKEF1b1UTp4C11QhWXBh8tMmqsRNt7yJA3dc1ahAsLKEmP4JX3Tw7il
	M+Firw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygj95fve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 18:38:12 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e8feffbe08so113720906d6.0
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 11:38:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744655892; x=1745260692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVuTySIzGwZ0NsBWBZfQiNPB6+9LtFwOJxGANJZuFFY=;
        b=AighVLivjZUVIV7uXoOnf/es48mStJbsVmpM5nJBV5s6TOWKKKiQDD8f1/EISCNgsa
         xbii8LGnQw4USGPSd9trOVoVSWjPKU0oQfL5+76Ld4kqt3FW/tqC5a2VaPqPXtGFgV5R
         s5NRDxPGgixxLM5T4vysbMS54n4d6yutYn6PpzqV/6ooFmIV2/wcVBcEkVQz8ZZZO/Mn
         gyMYPoMAPOv+JQ+JJpOgGTSX2sWpOTVu8aMrlzkEpBMlb3jDVtGkCNk6cwCDk6lO2iU6
         m5g6BN+9fQ9wT1uVayOQWrwqKJYdT03LOTClns08EcO37/RbnS7Fg5+lxKtXImigQN6/
         HMWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUanQREkYgyLMHNF39kk8sfIZNcyT/b0wULXToWvSNPDcGQKpWRNu0Tgd8144EcBBXz85/p/HY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDfbLOaj8URQb18MAicDj+cxHk0o/Abx9ffoqBcau99HmS+eYD
	Nns298xQiSzAn2TebYVyQz3IN7XUunUJ7SYV1lxDTiqDFJXdsugQ97T89UOu/3zFhyCUWB8pVaZ
	/bG81KU9sWOTe8CCG6fVfHC/t606er8vaw30HfhcPBbLd4QIGI+RLzcBPV5zeoH+czYOTckS9YY
	vdFqx5mN3bpcnpVFHP6aocvU3fYYDBqaAYNoCB5MUE
X-Gm-Gg: ASbGncvw5Qjl8JQDlCtgoYLd4JVNUqfjyFyRhL3tXkwW/tK19IN0G+WbNGXSBUg8jKF
	r8Aj1RloeNlsGgfZxVcl2DBOb18rMlbh4kKnfwerP5V3ksX+41ui+AP8hkBRJ3p4wJVkgF2E=
X-Received: by 2002:ad4:5742:0:b0:6eb:28e4:8519 with SMTP id 6a1803df08f44-6f230d52924mr221239726d6.21.1744655891906;
        Mon, 14 Apr 2025 11:38:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6AhTnIkqPOvUucOSgYp1R5nhvfa7WTIcoQfUItzoTzZmDa9zsjVEF60Xh5J0/TFMeoBYXOiYRjSmqqk+YtIU=
X-Received: by 2002:ad4:5742:0:b0:6eb:28e4:8519 with SMTP id
 6a1803df08f44-6f230d52924mr221239326d6.21.1744655891383; Mon, 14 Apr 2025
 11:38:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408233118.21452-1-ryazanov.s.a@gmail.com> <20250408233118.21452-2-ryazanov.s.a@gmail.com>
In-Reply-To: <20250408233118.21452-2-ryazanov.s.a@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 14 Apr 2025 20:38:00 +0200
X-Gm-Features: ATxdqUFuHOimNHN_cfgMEQF-1vCmIOAy604IslgDpmjO1QC11tdJfK_wuf3ntPE
Message-ID: <CAFEp6-2A5VkYP1HjywXChoAhFmRnUi=EgBrXatwiwKJfQJ6GTg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] net: wwan: core: remove unused port_id field
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 5crBkrX9rz4JzZzIN1RDZ4z6YzJ9kx1s
X-Authority-Analysis: v=2.4 cv=PruTbxM3 c=1 sm=1 tr=0 ts=67fd5614 cx=c_pps a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=XIB30I8Fq4NfyXnsoAUA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: 5crBkrX9rz4JzZzIN1RDZ4z6YzJ9kx1s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 mlxscore=0 mlxlogscore=703
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140135

On Wed, Apr 9, 2025 at 1:31=E2=80=AFAM Sergey Ryazanov <ryazanov.s.a@gmail.=
com> wrote:
>
> It was used initially for a port id allocation, then removed, and then
> accidently introduced again, but it is still unused. Drop it again to
> keep code clean.
>
> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

