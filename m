Return-Path: <netdev+bounces-179719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 641D2A7E5C1
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB87442A4A
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A464209F30;
	Mon,  7 Apr 2025 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LhrKWVdB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B74205AD8
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 16:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744041783; cv=none; b=O5c8ibwrOr23yBRu8JIGiHgd/ksE+1Eb6DmlJb+d3v31P6cOMMyImQVD4JD543U9vE/AgFh0UGo6LazQxY5leWPKFTeD+IaIBDl8lSMZSNViaAbBSGypxPAPKsHdxOQ3Sdt5xLyIma0qkVKAaF70mG1Kk6cNxnBJA7z5zRBcLNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744041783; c=relaxed/simple;
	bh=qnQ15yrqgtf8+nUymYIJht5OkQzulisk9s00Sw4mRMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qVM03G6i2zaIhTjwbRur2tSJB3PFB+lzFCVk3Rh4zPHu+98WEdpWxvaXiXXAdrlt3Ff8BLlKHLd/zubMRJI0FfFZ/URy05Hd1EySB00yQ0MNBD7io7rnNF2KOa+wFilO6FcDVOPGCCYTxGl4rAiyXRfcSUGDmWvakRjVl5XPZHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LhrKWVdB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5378dnaA003198
	for <netdev@vger.kernel.org>; Mon, 7 Apr 2025 16:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fc3XwojJ5GFfdF94r7F5k7ZenDcWsyFJvzqBaDf4v4E=; b=LhrKWVdB0XApgiSi
	353Kx+c8j0G1MEQPLZS1YUKrFV/20lOlvVl+YLT7USlQXdf8LLogfhBC23nD1Ch4
	yE4zq3OMN6Hmy6UX1oWEBMkk8uQDaXiRe//l6AewLCu27L2z6+tZxByzRYalFM1q
	cj434Xz8yPb/C2ZV41WC7+73j6iqFrLlzbnRPi9DNjcstlwgOzsXWEcCCFGzrFYD
	PjFZPFWjLJi7H76w2fytPAYkrCrh7koGIfqc7vrYHY5pznJFi5IAtg8uamO+n+X0
	cD6jxRUCopbEC5Yap3+i3I15uJlUi63JIjhqmQMg2h4cLzPHob9twNKVgEjY+27B
	Nn0gOQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twftcqhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 16:03:00 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-223fd6e9408so41228445ad.1
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 09:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744041780; x=1744646580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fc3XwojJ5GFfdF94r7F5k7ZenDcWsyFJvzqBaDf4v4E=;
        b=UVjuOeJfQKvHdmSCUWQx2gksb0Z49Y/gbxD3svL/mnR1o1Z+8+gQj2x23/qs2NmciI
         f0FaJtyd+vdQSCBbD5Pf9ZqSpjXRj+v7LZKQERrxUvURvYmVOvzL3JphbToaj0sy2fkV
         vtYhJ7YblX9zX9KassZgnpt/fgRMiJqX5mnrHYKHuDoOtNm0OFC5d4XSlxfwbEeFzjkq
         KAE38vfYjHfZnSxsCDY6yVlAqy6kCu/o127IB/kxVuZ1uqX2RMB2FPvkBEcswDH+7bze
         BauUlWa+z2XgaiPXW7gVB4Vgrh05Cnx8AwrLF/qkyi5whwUB1/pM0XPaqI9jXnrVpRhL
         ujag==
X-Forwarded-Encrypted: i=1; AJvYcCXOFtBZ/oB5OIeFyx6VMr1xjh5bLeDjwRWY/+pTI8HZg3ahx3jpWERjpOsoDoCiKenjQODNVLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpsX2evb9FBs+4FLtrTMI3SyhgOZ3Esp7D/OCVlnNfv5KjKKkh
	toIu7vzeZV8ohHsBSDk1VwaWfexfBsvw+9Dh1dD8KgpUrArAD5G6+iyqZbAa9BRkgaPfdjDQmxQ
	IPKfCyB0koZfUxH6pAoXjZY+w9+cJUmb188hiTKo5P59gvP5Gsqmnys0=
X-Gm-Gg: ASbGncvXuVf/aOgKAkW+efaPpGXyP5cvqqliX5svN4oqFUsmvXHndzifEnIKKJOGTP1
	2UWzfxyubyM4ZobC1sxEaf3OhYgkMcLd8ZAsizCsfe9bpoU9yZkamITqI5XcL+YmlT8sqfgwD70
	ZBp8yeA6l6UZzjYDN+wvhouUuLiW9vavCvuGQnR1TzxcPi/hP6HWLw2bMPmg0XXch/dNnEL6s/Q
	EM+88hRf/5HGoB9F03EyIRobM5T+lQcuH/5NyIbm2/8ujG31XkvmXhK6g3HE9EN0DNPG6j/ugf8
	W8qivMRW5IacvUVYzeCMnigwSn9oXj3gGrLsrFJb+EBTXIoPfEel82kw9n81L8/SPw==
X-Received: by 2002:a17:903:2a8f:b0:225:abd2:5e5a with SMTP id d9443c01a7336-22ab5df1b0dmr455435ad.4.1744041779603;
        Mon, 07 Apr 2025 09:02:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQkBFjjP+ONLlvzzb1gd0pTO1LSFOf1s2n0EEL7fUMEzu7Ove5cxahF9Lf52ILh1wQo+2pDg==
X-Received: by 2002:a17:903:2a8f:b0:225:abd2:5e5a with SMTP id d9443c01a7336-22ab5df1b0dmr454955ad.4.1744041779170;
        Mon, 07 Apr 2025 09:02:59 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97f2fd3sm8971891b3a.69.2025.04.07.09.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 09:02:58 -0700 (PDT)
Message-ID: <cd94dff9-d28d-42f5-a071-26e9dd0c3490@oss.qualcomm.com>
Date: Mon, 7 Apr 2025 10:02:52 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] PCI: add CONFIG_MMU dependency
To: Arnd Bergmann <arnd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Carl Vanderlip <quic_carlv@quicinc.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Takashi Sakamoto
 <o-takashi@sakamocchi.jp>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        Jocelyn Falempe <jfalempe@redhat.com>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Tian Tao <tiantao6@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Yongqin Liu
 <yongqin.liu@linaro.org>,
        John Stultz <jstultz@google.com>,
        Sui Jingfeng <suijingfeng@loongson.cn>, Lyude Paul <lyude@redhat.com>,
        Danilo Krummrich <dakr@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
        Zack Rusin <zack.rusin@broadcom.com>,
        Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Saurav Kashyap <skashyap@marvell.com>,
        Javed Hasan <jhasan@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Dmitry Baryshkov <lumag@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, virtualization@lists.linux.dev,
        spice-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        netdev@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-scsi@vger.kernel.org, kvm@vger.kernel.org
References: <20250407104025.3421624-1-arnd@kernel.org>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20250407104025.3421624-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=B5+50PtM c=1 sm=1 tr=0 ts=67f3f734 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=ZLGELXoPAAAA:8 a=EUspDBNiAAAA:8 a=mM23EaL7GqIQzlWAp5AA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=CFiPc5v16LZhaT-MVE1c:22
X-Proofpoint-GUID: 3jmfwZOBgkNCTz8PC4rRwT8lVGM-vblk
X-Proofpoint-ORIG-GUID: 3jmfwZOBgkNCTz8PC4rRwT8lVGM-vblk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=661
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070112

On 4/7/2025 4:38 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> It turns out that there are no platforms that have PCI but don't have an MMU,
> so adding a Kconfig dependency on CONFIG_PCI simplifies build testing kernels
> for those platforms a lot, and avoids a lot of inadvertent build regressions.
> 
> Add a dependency for CONFIG_PCI and remove all the ones for PCI specific
> device drivers that are currently marked not having it.
> 
> Link: https://lore.kernel.org/lkml/a41f1b20-a76c-43d8-8c36-f12744327a54@app.fastmail.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/accel/qaic/Kconfig              | 1 -

For qaic:
Acked-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>

