Return-Path: <netdev+bounces-223708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFA5B5A1AD
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E034580593
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 19:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149972DD60F;
	Tue, 16 Sep 2025 19:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0+eeMU/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F97119F40A
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 19:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758052413; cv=none; b=ruP4FxTWWc6sqfFUK77v4TorTOUvSdxS2U/tFd2utTFxPeMtwr3+WF56lMUrwnAA7yREe3G0p4r9uHAq/KtFXWe/EfdBwtPCc+MBPVLsZx1+sMzuVGdsyvVjbNyHuY1EqyGOdH4Tae7QqswO3y9LFt3SzBB8JVUlxigBZB5j6vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758052413; c=relaxed/simple;
	bh=3T9D2t1qq69LqhN17EDkyhBUgxegMxL2fRfUXiYb7qE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWeu28hwe/Ff4I1kW/WPBoL45TjGiHfGZUL7CDnzbROJ0EcISr2N07pn+i27W7+GxpAAQq3FFo6vNI0F1bpYoO/BYPcmfFowHgSoROH9QBrY8vQVHAg/LNzWRdBEWgpTams4Z5OY9RljQztN554oxIXxUPZ/zU8tYHs2vddd9/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0+eeMU/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45dec026c78so59634145e9.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 12:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758052409; x=1758657209; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Op/mfZsVaCIiTyvcgrObOgRcD7fjVHYfzWijrbsL1E4=;
        b=H0+eeMU/odAE2HFN91lkgYZbFr9UjZqmOnfFf1IUkva9P3H28pTiKdQtVAqPj5WVrf
         l5MeqimiUyvt4jF2MrhF4c93jfb9qR4389blVOPwnwfmJMzk5rP7/n3Cltm8Wc4+SSSn
         0RtocYq7A1NFedPaBxaJkSY7z5JNygUT3mxrNcIcH5IloDpHkpM25HfGjaKXQ/0cq3UV
         lBdJiw2CSD9uDUl13xuDfX1hBKanbprTPyqZTblbBVSpPqnj/uOJX7rCOTlmDU48gVGw
         JpJ6iTNqnmC9GChTpxSpBkhoYzw9Gws+LKhje2y+e6xLEkl8VNeK0qi0PJWqbQeESI+6
         3sCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758052409; x=1758657209;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Op/mfZsVaCIiTyvcgrObOgRcD7fjVHYfzWijrbsL1E4=;
        b=Z4XsiyRD+6HYWVbyQomjFy5OIJG3TD7YU42x0EzArWQTWXnadScIm3imaNZaKYODlZ
         GF4/SDmqXKG7PuZk9o/nIyLvS4TYASZGOhxmJhZInshE/kfHbuce6RGv0ZQpUhTpPkec
         I0xQoRfItnqNsWKDWKmN22ogeBBD5rVLbemadX7Tx+LiFlQqyW9zZuyYpouPc3ENCQZl
         fYzsCL2kVm5LZYgfSsJrcPKzPwivSY33FS1EMiG45PkiELPvAqPFT+4k1IFFuvX/5oaR
         bTEnBLjr2Z57vbhfR2U0vd1KllkdyUeTSEPFTkkH8MVakEtdcIVvRklP0UA1/g/GvCDA
         v3Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUVHe4iPdqIpKnGhSM+cfaQI0yRcsj2lA0Y4dRLDwohIkwS6CZmT4E9Cvlsc3/Pk6iYIgNTUfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1vLS7tIVI9jzmhgxByMESCDdjAiaxNzX84EqgKtvaQ6bClHXD
	z49Xaty9ez01o8ETIEeFhHEfN5ohMz5ydgFjHlf+YqnQ3Y7thkn7QwUy
X-Gm-Gg: ASbGnctsr3HdpR2dUOFkeRQZ4FVfZUJ+IxnlDmS5RxlzMU4vfNw1uRs8PBnn4K17Dkx
	TZpUvAIPb2J7tK00njfGnhZdFV5Qd4syvNhj3a34WikDuVe49t9LeseMiNXkfEmEt9Mu0LkGlGJ
	II8RHL834drws383Oxy96L9jvXiD6MdyNOBip8Tsf/raPXR0VFgj3OytqLp5Lp6B0IT4W7fJk09
	sNi505A9fF8EgZDr2e6qNq402iPr+HFVz7Zxeb7WdQMOk/ttCsrqKHz1pO5GgyKBmUG7QbbrT7H
	XoLjQoumw1JwZXY9Vfwecanaw6sMedq2Iuj+h0e/nNyAFmtwdFOxnMYFGmi50FYSa9xVCdgD5n/
	HoaiYLF0NZ4AARSN0ym7+GCDFsPlmN0UFn/EibodbNOkPYpfzuw==
X-Google-Smtp-Source: AGHT+IFsJDK9nhbWZy8UpoS+giPB9I8eqLFrqS1+V+EAPmi5yJXPv9nuFGXnTz8G4O98qeZZKmgX/w==
X-Received: by 2002:a05:600c:3505:b0:45f:2843:e76b with SMTP id 5b1f17b1804b1-45f2843e99cmr107649975e9.2.1758052409285;
        Tue, 16 Sep 2025 12:53:29 -0700 (PDT)
Received: from [10.221.203.56] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46138694957sm7592775e9.4.2025.09.16.12.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 12:53:28 -0700 (PDT)
Message-ID: <c9533a24-a02a-4601-9b4d-197b03634c4f@gmail.com>
Date: Tue, 16 Sep 2025 22:53:26 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net/mlx5: Clean up only new IRQ glue on
 request_irq() failure
To: Shay Drori <shayd@nvidia.com>,
 Mohith Kumar Thummaluru <mohith.k.kumar.thummaluru@oracle.com>,
 "saeedm@nvidia.com" <saeedm@nvidia.com>, "leon@kernel.org"
 <leon@kernel.org>, "tariqt@nvidia.com" <tariqt@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "jacob.e.keller@intel.com" <jacob.e.keller@intel.com>,
 "elic@nvidia.com" <elic@nvidia.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Anand Khoje <anand.a.khoje@oracle.com>,
 Manjunath Patil <manjunath.b.patil@oracle.com>,
 Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
 Rajesh Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
 Rohit Sajan Kumar <rohit.sajan.kumar@oracle.com>,
 Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Qing Huang <qing.huang@oracle.com>
References: <1eda4785-6e3e-4660-ac04-62e474133d71@oracle.com>
 <d9bea817-279c-4024-9bff-c258371b3de7@nvidia.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <d9bea817-279c-4024-9bff-c258371b3de7@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/09/2025 8:24, Shay Drori wrote:
> Hi, sorry for the late response :(
> 
> On 27/06/2025 9:50, Mohith Kumar Thummaluru wrote:
>> External email: Use caution opening links or attachments
>>
>>
..

> 
> now that the condition is only one line, you need to remove the
> parenthesis.
> 
> other than that.
> Reviewed-by: Shay Drory <shayd@nvidia.com>
> 

LGTM.

Acked-by: Tariq Toukan <tariqt@nvidia.com>


