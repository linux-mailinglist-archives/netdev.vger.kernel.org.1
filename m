Return-Path: <netdev+bounces-106919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE79E918172
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 14:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB8E1C22FAA
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 12:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53726180A61;
	Wed, 26 Jun 2024 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7Cdk4B3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D110916CD35
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 12:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719406478; cv=none; b=pJLGGVw/kTJvwYuBd5KYliRPSnWrUfxurowfIwxe8qItEXbadl6q27yoObT22VFg9VplcgJiIK+YK061oswBWsST4sAD45SkmjKU41H5mPvSId9t6adidjYOmkBpnt8FehxXNaxXxqwdIuRUEki/ZDKEDDaMC+I/+1TH4gXeLU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719406478; c=relaxed/simple;
	bh=m5sBYB3LehhgAj0AoT7awV45VRjYTbpWE4VxN/R7Tjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NrR1DzqzUQVzCmafiybeu5kkui10MG7fhgBydFTVp9WehGxFrAqFSIjtxQThL2PptpGrmvjAcL2h4leA0PN16HGpZ6jLLwBG9NkO/7NrAcVBy6a62O4hyK75d9neiU2uOgyfeHIBAaEXKyYLqlrCpWgvQIn47NfdR+Bo1TOrTAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7Cdk4B3; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-366edce6493so2505297f8f.3
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 05:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719406475; x=1720011275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XVZa8s7TfW9M4YMz2W8iw4oXxkdoC8VEOuz1elTAeOA=;
        b=l7Cdk4B3OURL8rqiV3RaEeqHxXROvbVQH4w9/H+J3ekX1yLBk0hBtYuBRKOyDji64K
         JsrpXEW7idV5UjkXZPO+V1SGnIwu1K/Ebm5295CZx5zig+NgrcofbOUb2fd6D+78p/ur
         8N4cPlahGz1uCR81jlomaOeomNDQioACaJE5CDUZjPb5bAyuqCc7mPhFl1dyZQADHhUi
         +xu9gwYOuGRoQQAUhOdG9GovaHwZKnYBL/KjAClglPZOYOPcbR/izoi435e9DpZ38r3P
         PAo55Nxr9iGJn+y4Oo2irw4CtCsDeMeIoW9fa2BGSL/XRbqdaBrJZ7ixZupWoacoRjhg
         cuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719406475; x=1720011275;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XVZa8s7TfW9M4YMz2W8iw4oXxkdoC8VEOuz1elTAeOA=;
        b=rmmUffIIFw/wPefVNkCP3GOWKrFYr6AF9tXizVylJP2G5KD3mfYJlWhJFi1cZOFlbG
         BDHGd7vuehDMtOEo1dHDYzBnCH1mrt9ry8RXOsCFexRQj8CKRQtRwuWmeCQayGaiCUlp
         pNEo9loq/pqyoNn87rPfv4eFB34DG413H1FxfVL5fTFo5XV55U4BwP3WS8aMECYOg/SP
         ckvmhM/9WssXhPhH8yKf6K733rhtTDciGfCxdhNhAMNBT4vmof1ssDkjb9I25pWiI9EC
         RP9W2qG/htT5fEYIOWoaQ4ckWpDB2MvpfPd+uQJ9gmFgEfMhvnGlaG2TapGimJFvV1vp
         jcuA==
X-Forwarded-Encrypted: i=1; AJvYcCUMWGENau3lGz+W3wdUTU2/ey6Q8s5FYeZ54y4OvRInRiPzRZMlUWv1gvc2GPNg4U1HkYiyb99HfCImrPRqMzD+GTwBGF4K
X-Gm-Message-State: AOJu0Ywec7Ped7e0Hh5YRr2+HhJPELBUZcSWhSMufRlBIjPhry7vaD4v
	AXnwIOQ14ye7EC1UkOz+ql8OLLfUbeu4r1jbl6cymSoWkIlec+Bw
X-Google-Smtp-Source: AGHT+IHhghrgXVGwLJscxl8VPw3qIl2CQ5VS6xPflbXzLdPIN0RbFlSoW3He5PbytvA9MSrKjcPeSg==
X-Received: by 2002:a5d:538f:0:b0:365:ebb6:35df with SMTP id ffacd0b85a97d-366e962df3bmr6164255f8f.58.1719406474686;
        Wed, 26 Jun 2024 05:54:34 -0700 (PDT)
Received: from [10.158.37.53] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366ed18dfeesm9668547f8f.93.2024.06.26.05.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 05:54:34 -0700 (PDT)
Message-ID: <25bae4ee-f333-45ea-8c61-d9d520df08ae@gmail.com>
Date: Wed, 26 Jun 2024 15:54:32 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 6/7] net/mlx5e: Present succeeded IPsec SA bytes and
 packet
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>
References: <20240624073001.1204974-1-tariqt@nvidia.com>
 <20240624073001.1204974-7-tariqt@nvidia.com>
 <20240625172141.51d5af12@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20240625172141.51d5af12@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/06/2024 3:21, Jakub Kicinski wrote:
> On Mon, 24 Jun 2024 10:30:00 +0300 Tariq Toukan wrote:
>> From: Leon Romanovsky <leonro@nvidia.com>
>>
>> IPsec SA statistics presents successfully decrypted and encrypted
>> packet and bytes, and not total handled by this SA. So update the
>> calculation logic to take into account failures.
>>
>> Fixes: c8dbbb89bfc0 ("net/mlx5e: Connect mlx5 IPsec statistics with XFRM core")
> 
> wrong commit ID, I think that it should be:
> 
> Fixes: 6fb7f9408779 ("net/mlx5e: Connect mlx5 IPsec statistics with XFRM core")

Right!
Should I respin? Or can be fixed while being merged?

