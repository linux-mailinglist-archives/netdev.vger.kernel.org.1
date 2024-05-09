Return-Path: <netdev+bounces-95045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D22CB8C14F9
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 20:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60127282130
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 18:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C437F7EEF2;
	Thu,  9 May 2024 18:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WsqfFNJD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CA67CF3E
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 18:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715280160; cv=none; b=pJmNy9nC3xrDxARTShJoxZROgdhAXVicFRCP6nPZqHV/QUNll2BkioWzyLrVjAsgxDi0ZnF5hBevZB+gH/6rikW8srdroTLDlcKj0UHx90MSPXhog32vYtcGolBWBT7dlJcE7MGf2KRaielsFEtOUt72RBvPOf/g/4KkK8OlYc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715280160; c=relaxed/simple;
	bh=3ndaJASgzHn4G3ckMjyOhyQuArGaXPwtj0dYJYISKb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aVKDGn6faj1LvIqvtzCCc1/1uNG2VdMkA7A7Z/dldv9LZk1f3n7jR6FlqwE5RaP2ZqVzr2LanOYw4rZEjIvsMToc+FpoMbGqMCSxrFruhc1yfMHUtvVWzboyQB1vo3BgCQbGMrXKsO/YSRG7JF6muGg43WCqc9CAYOXe7nqWtX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WsqfFNJD; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d9ef422859so10732039f.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 11:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715280157; x=1715884957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bb/hMrXR7iTuHRfsjZ3bhhr22tRj7HOFnte2NJWfYLc=;
        b=WsqfFNJDd26+NYj76KQARRE06ZV1QawB4xOu3Da6LbDom1EuRodw498RSbpVdG1qgp
         LRbCYdwlmVuv00xNWtOLn9cJ9qEtcV23yJaEa5ytrnYMM0fnMPqi2JjtQPP7NoW35SMw
         pXXopkl5FisIk/7Qs2WPe6lXyPTHU98HbupkpMPbri0KRc6b9VeNtAVhZZMnq56mGJfQ
         fPHkpyO7nwZo5JFrbo0E6PfrQez5UNqgeLUF5aY+pgk6v9euPh0TF0yNUcS92TSIxGhH
         HS8QSdUEQIrYM0v4PRVwS6rxU4BTj8qqd69oN55ATS/HmobwQeUnmMA1n7KZq4pSIFUI
         mtmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715280157; x=1715884957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bb/hMrXR7iTuHRfsjZ3bhhr22tRj7HOFnte2NJWfYLc=;
        b=LDrrTSnls+jtlIvW7ihYyN+Dz23ekXQCgy26SAEvCNkX8X/fqZ9zJ5I/qefgx8lFMy
         b9AD/Lb+gGCuAu9EJWwIzk0jHAw8BbmXVPDiJWoz7Ond0/7GkoXJYj0TjkXYdKBtf/ha
         jS1RWnQBE3+0mOKFLIz+NSp9BWAO4ImYNjdzlCsQqx74HUu/XWMnnM0DDaBJVYnuYXX5
         d3wi5K/IlxROe5P9nrhW7nrVh3SzqPyP3ydyqS22+Tvv1xgJlkmGCb2JsVZLrVu9zZq0
         sDUHTiwHpJwKH5VjC/VG3NjzjgiYxhd+hzzfokdVpJpyaZ4pYgENULa1JUuJCEoe8m5z
         XuwA==
X-Forwarded-Encrypted: i=1; AJvYcCUGFNkcRIGcVDtcKAAlXNb/hodOW7QLFc+Kx2FADIMH/1nVDKxYcDaumBz7SUFRecujO2cHMYled/8WHh1eIlcAruESKeGr
X-Gm-Message-State: AOJu0YzgXSdehV4a9AiaNaedjtEqGn32+KlnyOBGY8DRY9Ivt0zLFok6
	ttBphSPn6wh3vJ2H3ajF4uk7itko4oPI7tXlgSfx7DQ0znc1J1SvM3xuQf4J0Y0=
X-Google-Smtp-Source: AGHT+IHV1XMYkIb7S1TRyZqI608+jxhYsfIgUvPyWV4bIxpRx0wtJEwv4Lfl0RUasfhcfdAlKxNOYw==
X-Received: by 2002:a6b:d101:0:b0:7e1:86e1:cd46 with SMTP id ca18e2360f4ac-7e1b520b2f8mr64956039f.2.1715280157494;
        Thu, 09 May 2024 11:42:37 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-489375c1b48sm501321173.110.2024.05.09.11.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 11:42:37 -0700 (PDT)
Message-ID: <8fea3ee7-345c-4391-b8a9-a68eb90b9a3f@kernel.dk>
Date: Thu, 9 May 2024 12:42:35 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_net: Fix memory leak in virtnet_rx_mod_work
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 virtualization@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jiri@nvidia.com
References: <20240509183634.143273-1-danielj@nvidia.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240509183634.143273-1-danielj@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/24 12:36 PM, Daniel Jurgens wrote:
> The pointer delcaration was missing the __free(kfree).

Works for me:

Tested-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe



