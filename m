Return-Path: <netdev+bounces-66484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F0683F6FC
	for <lists+netdev@lfdr.de>; Sun, 28 Jan 2024 17:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B4461C20BD9
	for <lists+netdev@lfdr.de>; Sun, 28 Jan 2024 16:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA6D28DD7;
	Sun, 28 Jan 2024 16:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNZbx0yk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469BB5A795
	for <netdev@vger.kernel.org>; Sun, 28 Jan 2024 16:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458388; cv=none; b=mZsMhkQ7D7STGLLuLlNnYczGpLS1KVojKQkFeXzCoyZrqtaP/MPNKoRml4EhROsMmzk6yjmCPgh4P8QUE5o98XZdp1tXic8SJ0dmAnjW/oieiQrDcXTb9dHZd43Wh4jVrv9Wh42Jyb7uKzjv6s6KsImwQwNjIN0cqTZqf5ZIg1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458388; c=relaxed/simple;
	bh=Smqo+EHF0lEdyV0zeSEmvOP0S/l9vDnzcFtmwrTLtVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wn9OOeA7lzDUTxgWtU/Z92wzqSfMQtA4PivL71l1CvS+cB3AF/pEbebFtljQaZM300qE3ZwX+yHeur+LZUYJxw6cX9xxN0kPLEUmCaaeEuxpImHaHEU6nmqWz4iPhstNkWIJRXXgy+qJeD6mGBdZHov+oW0mNmCQvAZEdty7yDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNZbx0yk; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a2f79e79f0cso208097066b.2
        for <netdev@vger.kernel.org>; Sun, 28 Jan 2024 08:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706458385; x=1707063185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Smqo+EHF0lEdyV0zeSEmvOP0S/l9vDnzcFtmwrTLtVs=;
        b=eNZbx0ykcMruqPUBEhBf4H1BLPKfME1b5ttWUM+4dHArK2IKB+l/EP00VQ+Y22Q/ar
         QzySVwHpW0f8ILXcVexl5MjySz7UBQxQ096Z9zvxMr9C4KL5+XkPHePGvsUkBP1vPU5O
         /CAe07IrrNBBh4d8wXYwLLiKb0MrK3CCeMzGl+jYeVvWpXNAyOLs92DWpF/RIO9p610x
         P4SMh7Zpir9TkZXiY+VeXozVVfLTs0Hh2hJTqyuzzdDnN+IisUSwHgZ6E+cyErkUKEbd
         +fwsPlPYWOUvpbVlpckRDZcLvWfPxf1M71v5sE5ApeYgz5VoBZ76PaQGdZFQJ6kMI8hB
         8nbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706458385; x=1707063185;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Smqo+EHF0lEdyV0zeSEmvOP0S/l9vDnzcFtmwrTLtVs=;
        b=BQn+10fptW//s/mDIkVEA6Gu4hSY+h0RizdaQhYnPBLxd3/Nv5ZDBeZAh0jBX8umfG
         dXoqHl1FUwxlIYHcz02jrSCkbCF3nBYUyzc5IagDIaktnP74vl8fHnhqATISLO0LGSCD
         u2/tyRFvpY5FXwyu1KSJh+sjqnTaazak6Gg6OeFmY6FdIffDRRnd3IJLPHmGtb2hQuom
         o/Vr17uHOm4JR+zj4kz77w6WsKy4NUByg1E4N8/Qjl2t56sD/D5cB+CkcUJHHQBphD/D
         BQKHKsaZdR7rjun/kXfcPZYTWX5OTa2Pog7epipzT6gQJJHSXNgBiTlk08SZWZA3WmfK
         BGKw==
X-Gm-Message-State: AOJu0YzuX8mgdyI0asyG8rC5XaD45VF9gmPlrMp8ItSiRDjZ+2cM8hed
	VH4v84aeUjpP9RkCYwZj5HrCVAqO7He4odBMnCHtu2gsTGZRdbqD
X-Google-Smtp-Source: AGHT+IF8JzUCxFVABHiB2F5NtP1A/goC6qLdMp32fml10XY+bQAgX3aYztcjiVKtQhz1YqYGQq7+Jg==
X-Received: by 2002:a17:906:ad98:b0:a2f:7201:8608 with SMTP id la24-20020a170906ad9800b00a2f72018608mr2871359ejb.16.1706458385214;
        Sun, 28 Jan 2024 08:13:05 -0800 (PST)
Received: from ?IPV6:2001:b07:646f:4a4d:e17a:bd08:d035:d8c2? ([2001:b07:646f:4a4d:e17a:bd08:d035:d8c2])
        by smtp.gmail.com with ESMTPSA id i9-20020a170906264900b00a34a0163ee7sm2946889ejc.205.2024.01.28.08.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 08:13:04 -0800 (PST)
Message-ID: <cacb4e78-9ec1-437a-9017-9101a3014b8d@gmail.com>
Date: Sun, 28 Jan 2024 17:13:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next] taprio: validate TCA_TAPRIO_ATTR_FLAGS
 through policy instead of open-coding
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org
References: <20240125165942.37920-1-alessandromarcolini99@gmail.com>
 <20240126211441.GF401354@kernel.org>
From: Alessandro Marcolini <alessandromarcolini99@gmail.com>
In-Reply-To: <20240126211441.GF401354@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/26/24 22:14, Simon Horman wrote:
> For reference, and I don't think it's probably not
> necessary to repost because of this, these days
> it is normal to put the Changes below the scissors (---).
> This means they don't end up in the git history.
> But now we have lore that seems to be less of an issue.
Thank you very much! I'll keep this in mind for future patches :)

