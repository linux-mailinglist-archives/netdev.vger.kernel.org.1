Return-Path: <netdev+bounces-151508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F7D9EFD13
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 21:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44491188EE3A
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 20:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3221B21B4;
	Thu, 12 Dec 2024 20:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="euQmEP8S"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6091AF4C1
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 20:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734034330; cv=none; b=tY8B1HllB44y2rs8ngu6znbeE5qh49s7znUobBGI2g1/SBQqGecZH+iVk96izv7Do5PUfbLFEHS53DI2rzF2enS93xe+QSVhmRfvYg7y9lNTKysl8tvdaM1RSvfrUSfDCvBMn1jJFJR89nnhdLLbvgVTI7JRDQ2kwMziJ0Yv4uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734034330; c=relaxed/simple;
	bh=Gn8LXgpHJ7J4ykqP4qWw1kr83wxu++0ImTRJMyjaBXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJiWviWCZSuhqXE80uqIDptgkC7FqxWwcaOiMNQgUOnEYMcwEebPenJYWkpZCDX1rVLODDQNeyh3PSVbX0rVHs8ALT+zrZfZH6T72lgHE8CDt99A1sxrXGzxSFzKDr1EEmysexR+r6qwR8VEahKKkYxVLu+2sH+zl9quxyRM6CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=euQmEP8S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCBM0wb028137
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 20:12:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Cn60/1VALbVSHyxZswztHQTAh6tMGf69Zd26GEOzv2Y=; b=euQmEP8SgwLi6gXb
	7ah+4x7z6Yof1gNodNdEdPHtXTfHRlT8ksysw1bBm9TIG8NuycmufO9uU7anuPhX
	RYTKUFc9ssxPsi2yP5lgX/b6ju8xEJ54PybTohuOpJ7+/LSzm7ONIOz18O9QXMcG
	JT2MyhRVM0DsidpC5qG+F/9pIGO84RPCb87LDPrt0DY3hy4PuecVCP7VMc66tsDp
	GdD9+bDqHJD3TbUOR9F3hhte4ZtFvcauNcmtMUDCuGYUihk0ykL+aRo/tsAVavT6
	YSuxc1MzHosZ0XFNcwiwwjWDm6Ik2dhTngov/mTU6vewIlGEe7HWqk3twGZyfIZs
	iRV1nw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fxw4se1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 20:12:07 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-801c27e67a6so410296a12.2
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 12:12:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734034327; x=1734639127;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cn60/1VALbVSHyxZswztHQTAh6tMGf69Zd26GEOzv2Y=;
        b=YBU/OYNxQUBL/VuyzL7XWHeiU4sHwdUOMOTkmXNvY8/WAb719QX1FL0VhqqHlfOxdm
         +5dL0mrgWqGh6CKRKOWPdDKSL8a6Zc2TN8brfVXOWa/0I7I874Q/uYjmWxnHpmTAzV2J
         KfE3DY9YZTBh91Flel7URITjmYhR4dHZWcM0kXyad17cG8ZytiXwNzDg+dKZ5mISici8
         HTVlw3nGXbxLw8A0aH7pB7QqxeWtdEnZqU08DpKkUN3OFShpAzOpOfBrZy7BL+wmt5IK
         0lkjqV5N/FP5qjG7/EbZmsUmb6H5OVduFG3ZqCuM2mYO0vgC3boRa/N+3bSkDT8DV4xD
         n1iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoA52G7NvO3ONRaZCri81asG7VOKxWNt8rdS5wHztUpbApxy81+U/hgabgfvinXJHPI8U8hDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPW95BRcPBWkR5/Naz6jNI/Xs+JilxigOjx6N9RbF93B4dzfiH
	x9UEW42UKBpDHHTRnNSphYUHj0L76T+ch9oVp9qwVwAIgsnIYwwRytiX0RMnGGPNuSsJXhIY9km
	bwIB3srynVKIj0I2L64FzpHoaXazVZA191kOwPtKVt2OU20Ml9ZNXQxQ=
X-Gm-Gg: ASbGncthajUwoTvj4eITr7thj1YYHpyFy7GZpDa8tV6vtgie9B+P1gxflgVfXMHFx0D
	bv4tu93nYejch7jwWGVD4/ZCfWjlcNdNCb2Cxmh+lQpNhTTs5Zhl1nYZBXIqSFH3R+uSZkPc7yQ
	kdBIZSz5JkBSXR11UDqOvOhUw5F5jn4HGjW5BEknI5zUtc9bNU7VnveLsJ8DGfI6gQcAd7EkXo0
	7BOTIiUkLfNSj/DFgy4qsKYu0TgapE/SkBiWtUZr1jKCEeWWAWFoWNIRnqd2KTte5uqN7PFt+LH
	6sO9NWFpY3rLqYqIIgPMJCUSvqGhAJ+27SWLf+Y+SbYZL5m8/g==
X-Received: by 2002:a17:902:cf0a:b0:216:56c7:98a7 with SMTP id d9443c01a7336-21892a53c03mr320005ad.53.1734034327000;
        Thu, 12 Dec 2024 12:12:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQnkV60nuXYwfd4uSDUWCeLS7eRkdx9f0zXNnaVtas+WKnSX7+ic35la0rrPuCP3CL3PVXbQ==
X-Received: by 2002:a17:902:cf0a:b0:216:56c7:98a7 with SMTP id d9443c01a7336-21892a53c03mr319665ad.53.1734034326636;
        Thu, 12 Dec 2024 12:12:06 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142fc305dsm1696109a91.52.2024.12.12.12.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 12:12:06 -0800 (PST)
Message-ID: <e9552968-64c2-4e98-bbcd-37a7498422ab@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 12:12:04 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/2] wifi: ath11k: Convert timeouts to
 secs_to_jiffies()
To: Easwar Hariharan <eahariha@linux.microsoft.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Shailend Chand <shailend@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
References: <20241212-netdev-converge-secs-to-jiffies-v4-0-6dac97a6d6ab@linux.microsoft.com>
 <20241212-netdev-converge-secs-to-jiffies-v4-2-6dac97a6d6ab@linux.microsoft.com>
 <27cc63e7-1a63-4ba5-8c7a-12a78ad6d9fa@oss.qualcomm.com>
 <cc1d5e08-92e0-46d8-badb-2a61482200cf@linux.microsoft.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <cc1d5e08-92e0-46d8-badb-2a61482200cf@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: rgm2hSvCRj8VDNGnfzdURgZ4LzbMnzug
X-Proofpoint-GUID: rgm2hSvCRj8VDNGnfzdURgZ4LzbMnzug
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=890
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120146

On 12/12/2024 11:17 AM, Easwar Hariharan wrote:
> This is some sort of weird interaction between b4 and git send-email. I
> used git send-email to send the patches after writing them out with b4
> send so as to edit "net-next" into the subject line. It's good to know
> to not mix the tools in the future.
> 
> I can resend from the branch with git send-email directly to avoid this
> if preferred.
Note that if you have a recent version, b4 prep --set-prefixes can add the
tags to the subject (and keep track of them in the cover letter metadata)


