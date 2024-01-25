Return-Path: <netdev+bounces-65776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B70D83BAB5
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 08:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148C7283871
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 07:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924241119E;
	Thu, 25 Jan 2024 07:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McELA28U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F27125B2
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 07:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706168071; cv=none; b=ourcSl4F0IXLHeAIfBMgTlQPmJ6xeIspNsc7pnRza3ZyCYdlPk88IQh5IlJtQ8qttgmfXB/Y8Fxf0wHIOYEAq0AfPnEswtGSR+0IKpcdlJG+N00gmkpMHy3crS8cHRKwMgTi/sHyUsLLtDduGrKxXq7xgAYueVBMPODTiVvYfq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706168071; c=relaxed/simple;
	bh=fWPPff3x6KIoZ1erNpspgPxt62yiuscHVugNt/bTDAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eEzoFfpF/6o7jbS1jlkfphmyRojl/gD68v/R4KDRR77qwndOmKFBl8TXWIajXnMa5a0XFrfjEbVAt6MCAFJXw13B1WkNGRfj8bqzgryx1a0VgOEyb7AzTZJS32p1gBDk5I5iI55G3xQNOE+YG2wS8wWLgXf2I8RcnL4xDc6gZKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McELA28U; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e9ef9853bso2149345e9.1
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 23:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706168068; x=1706772868; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W93ake2KxtQJZ258fjaEH+7vaNRoc5pPyXkTTGd9hmk=;
        b=McELA28UusumxZhJlvPFqV3kpH454O6MLHrE3dZ0E4HVJTRPpOhEgcW6KX/2VAwcV5
         tSs88MegkpWJGxENkI1iQ865MrdkV28penbvvIhXNXHI6S5uRmeG/aBnGXYRKWZMP/eV
         g6v53oVfbiWbBUyMBKn0JoJDtgNACBkbfGARuOZdkokpq3jI6rPY1puZDjO4uWK+jvNv
         ZN2z4wgQXGmm5Dq6NchcC4zaABaYBuIn3nOYfhitmSy5/9GfRQNLZNnldK8vHe12K9Z1
         glrFAlyzba8xlPw2a6zH2epZD2tGz2loQSpUlsAD3PhDSSoXEtlyvgrYKSG6n8E6SBr4
         u5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706168068; x=1706772868;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W93ake2KxtQJZ258fjaEH+7vaNRoc5pPyXkTTGd9hmk=;
        b=IBtZrItCcmcsxcrYYLxzueOG5HUUJ8hizL4BclDSptvtUIZxGQFNbzPS1+/ky77p+L
         Q5yISSrgztT+jVU9zEoBxsl6SU9bphcEyjr4nHRYyYq3ZkxCWF0Yg7t5nKSagROGXnCv
         iLfIRNjV2VGK1pNnX5wX2xOjNgdZnqDh8C1uzOBHTVuT/9J10GhZQuw7lFpcUxEMpejr
         zDEp2XQ+jemqZcic+4rI9CarrWkdWuB077hgumd+Qgmx5Fsf9H90ooTzJXKr25mxtW47
         6PGITML8RoWxwYSz027http1mlBEKtsYTPEoQNBeqfWCB+8dlHb3V5oGHjjJhsWuf7Yn
         g6gA==
X-Gm-Message-State: AOJu0YwW/7Gn7i3PUSaXrTFrHiHtSQmzVmAkY1iaDnWH/I8VPhgQhwQU
	JEPedyZHtcVjjGPRlTjAiUvHyU84S1K2RlePSK0EOt34Qb6Js1cZgCbi/kxh
X-Google-Smtp-Source: AGHT+IGhr0G/sgP7EHTwnTUqLvxzlAuotweuf/McOQwGawZEP10oplVN1+YdnnjzViGNzuKUcEmR6A==
X-Received: by 2002:a05:600c:1e24:b0:40e:c047:9336 with SMTP id ay36-20020a05600c1e2400b0040ec0479336mr262443wmb.100.1706168067974;
        Wed, 24 Jan 2024 23:34:27 -0800 (PST)
Received: from [172.27.57.151] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id o40-20020a05600c512800b0040eccfa8a36sm1522679wms.27.2024.01.24.23.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 23:34:27 -0800 (PST)
Message-ID: <0a4ebbe2-93d5-490f-ae97-9b64bdfeeb45@gmail.com>
Date: Thu, 25 Jan 2024 09:34:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 04/15] net/mlx5: SD, Implement basic query and
 instantiation
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>, Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>
References: <20231221005721.186607-1-saeed@kernel.org>
 <20231221005721.186607-5-saeed@kernel.org> <ZZfyx2ZFEjELQ7ZD@nanopsycho>
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <ZZfyx2ZFEjELQ7ZD@nanopsycho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/01/2024 14:15, Jiri Pirko wrote:
> Thu, Dec 21, 2023 at 01:57:10AM CET, saeed@kernel.org wrote:
>> From: Tariq Toukan <tariqt@nvidia.com>
> 
> [...]
> 
>> +static int sd_init(struct mlx5_core_dev *dev)
> 
> Could you maintain "mlx5_" prefix here and in the rest of the patches?
> 
> 

Hi Jiri,

We do not necessarily maintain this prefix for non-exposed static functions.

>> +{
> 
> [...]

