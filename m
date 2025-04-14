Return-Path: <netdev+bounces-182280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24550A88688
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 722E8162437
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EA527A907;
	Mon, 14 Apr 2025 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kFYSey27"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16B4274FD5
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744642967; cv=none; b=CT1n96eRs+seFUMj7iSUToui8Ahjr+c1tqG7zaHPmkSfqmaJYiRYKZOHaDOmeXruU7DvpKwyvNbxb5jnqN6Ni3LC1Jcr2icWADLUHohLJ7FqdgDkPtKb8Bo8bAvEuD88KLp03QKoZyxggI/aGwNHsM9eU7DXgLp72LB/fHHkRBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744642967; c=relaxed/simple;
	bh=RaBjxibi9OpSLsL0pgUQXBGLegZ2HPMaVA4aQ8D2I9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n1UcRKo3vB2dKtegM+LtgVgzXW/TCR9NZcTMWIoYZPkNt1Ijtcro+6euz9s13NLonJOjils0V1knoXv4atPFsD41s4vmqlI2BkqTxhYFcD1uPuU6dOMfY+Wns92fQJIDKl6IZDCKWPGh+krZ6a9ckRbOWMG0krJG50+CAGywxiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kFYSey27; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E99mns012973
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 15:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Fx9CLNx6B9Vh7w2Q67gBVSliKW/Q6vuPCUUdblElgFI=; b=kFYSey27HL8ztTDg
	RdpAvxgZ9m4z4naV34qjlKe322EcwPVu0dTVnfPZZoyOdXUJ5E7wux2TeOqRJ4cg
	2I23PD7rdAlxiI0HYOEieepyI1mShxQcF8F6Y1o6s3QYkTAyNatHpR3StJnJHmOe
	n0lIZfIVSP02j0rp4r8uiD7Tk5zoWDd1em3eS3Q37qd5aF+3T6OY9AqQFyTVpJ4B
	TrXR/Rrm3wfGoSnWErszLRs4u1X6Tb16EmX8Q9/jInhOi4z5JarRPgcVFD6QRjsM
	cI/1f4oldAetzdjVh8rgjuL2xxugaN6sKplOEl3/wFEr8GZggBwlvk6fkfz+6Ou/
	0XmDpg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygj94x0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 15:02:44 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-af54a9109f4so1818526a12.2
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 08:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744642963; x=1745247763;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fx9CLNx6B9Vh7w2Q67gBVSliKW/Q6vuPCUUdblElgFI=;
        b=u239u+F3hvXP0ERGw88vt/ErsHomY9sF/ruG5/mdel1hjssxA2+UBs4+Q+o75apIdC
         MjqTWUM8xJvEwo+aZ5tCax727Q6c0NhkTJmrptFMaJRUcrYBbvyJuRtFNP48QTT7ApfB
         jS3iXyqYL+yxue7vnAOXBzsp49LrvEhIpBZWh0gBxSoRz9s1OCf9io9so26t8+aF6ZZL
         7KaWBZU4f1oqG2ANEoTZ5RVbm9GJeJthFw7W/iaOhJq8y9FvN1RuCBnAdeBRYoYVcJks
         g65zugUKuhkA0vdwpupjB31v2L+4c+ublShp4qHmIj1FUMDlzisrFRX1neY8seTM7D5P
         SdpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUigrlNkpXIjIiUzWxL+fqCTZPm2nlBruENLpOo3q7hjP43KQO8P976WF2Jk7himvqJRixzMNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj+LmLmA6usFiCNZBK4k5LxEVMk30Uw1ZQOqvkjhE/IitNlQqj
	d2jyqBFeswWv66Hosl7uQ+ihc54ViPW+L1Uck4Lio0s/j3v3t04AXzb0rxl5nqR0aqGDFQAKKYB
	sp42q0hXM8QpZUs2rodhM3JJO44Xe7C4thz8PcOx8Pq+aHt/4RIpshgY=
X-Gm-Gg: ASbGnctaS7ADGdLglLD534dL1X50CwV2cQh97AAD1UiFn+HE2FXoYemL31bRFoITIHi
	jfq121Q/9td4S+hgBIb2Wj/SzIs8zVhHK/+eTyT1PhoZCSYbQmmkAagHvE7fs3z4d5fNIP5zTFU
	h6O/zivmlQr8JAxn5yLLi0lyjdTf3CGzDe/VoUmucuH7Lp4YHNc16WeD7cTIqz/kcfGdJoFSlU0
	FYzBCDvd/j1P1G3kRBi07fnR1d8c0Uc2W3VQs1bIpdb18MgO7RknRt4WVeWY4r6Cs73GiluZng3
	6H3BqfgKamzIsmfVVilL5hyc3BebHNhGioBKnPngFBxv4Ez/3NaCVUN0eHMUfiUU15AkJ/49iHb
	e/qIx
X-Received: by 2002:a05:6a20:94c9:b0:1f5:9024:3246 with SMTP id adf61e73a8af0-201797a39c1mr17925511637.17.1744642962973;
        Mon, 14 Apr 2025 08:02:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1bvcHXdGUC9wzx8xCOFjLvQn3x2hUBSOQvCCcOvrLi0D37ffqN0AxJ/2rFL/I3g9ErbikTQ==
X-Received: by 2002:a05:6a20:94c9:b0:1f5:9024:3246 with SMTP id adf61e73a8af0-201797a39c1mr17925443637.17.1744642962376;
        Mon, 14 Apr 2025 08:02:42 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a0de8926sm7855972a12.30.2025.04.14.08.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 08:02:41 -0700 (PDT)
Message-ID: <9c53011a-0e00-49f8-bf7e-b04ddc8c575b@oss.qualcomm.com>
Date: Mon, 14 Apr 2025 08:02:39 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/7] net: Don't use %pK through printk
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
        Jeff Johnson <jjohnson@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Francesco Dolcini <francesco@dolcini.it>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: ath10k@lists.infradead.org, linux-kernel@vger.kernel.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
References: <20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: frC-JYWkJG7fnq4hdXEXk9Wa_Y7LJQYV
X-Authority-Analysis: v=2.4 cv=PruTbxM3 c=1 sm=1 tr=0 ts=67fd2394 cx=c_pps a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=2xVh5uQ6XZRltrFgOl4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: frC-JYWkJG7fnq4hdXEXk9Wa_Y7LJQYV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 mlxscore=0 mlxlogscore=556
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140109

On 4/14/2025 1:26 AM, Thomas Weißschuh wrote:
>       wifi: ath10k: Don't use %pK through printk
>       wifi: ath11k: Don't use %pK through printk
>       wifi: ath12k: Don't use %pK through printk
>       wifi: wcn36xx: Don't use %pK through printk

the first four should go through ath-next and not net-next

>       wifi: mwifiex: Don't use %pK through printk

this should go through wireless-next

/jeff

