Return-Path: <netdev+bounces-132525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D6F99203C
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 20:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E747B21CD6
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 18:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CFA189BAE;
	Sun,  6 Oct 2024 18:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXwQZbdl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0E8189B81;
	Sun,  6 Oct 2024 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728237959; cv=none; b=eQeL1GamotNr9AQvhj9TQyEpsEXNgCMIcrwnm+ajt9QqJsTngpeggdfZBpgsKiUaqy5+mGzhy2x1zMnh7Kc5h/37qOxGgr8GCOrpoG10fV1WYotTEFmgLG3cyq+kdNej3koIYPBhKs+2rtMhRsy3c5KKQzQyDofxT86K36itjxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728237959; c=relaxed/simple;
	bh=6p2LRnMWFe1XfxiXX1tv/Sl112LsjWo3/AeotHxu/q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YjoumdXksvzOAJHgXVmaRLoKOGPDfeBzxnjScOZYUhxIoBchbcgk2+swgxkxH6+DPTQ0I4BxjyoSY2HTaG/zIeaDFKzneAc+PSLY4QZ/TcdgTc1ImLiHE3Y0IhbwYIdwz/41eDLYM6vAF/SZA6UBrFLVI5ys5b48iLWT+5N/eSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXwQZbdl; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5398939d29eso4467847e87.0;
        Sun, 06 Oct 2024 11:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728237956; x=1728842756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e2zEsNtZMNIDEGihRj7PBI2aICQCPZPWqZX5v0Y1Sj8=;
        b=OXwQZbdlfds3WRocxjtmNkUAljUcWC5aEkMpWg/rZ8Lc34dv+nWCujEs+TgT1kjrbs
         1t88ZiNf6XXVkx7hx75EIqYNLvL2Zk6EbZGd8OKCra7ztS9UWgBhjQ64ZYlz3OXlyTo8
         a3r7PLuLSbHGqWtex2rr3B5tqc/EhrYQ759MAzaOw+a7iSmuqn6ZbUkNNF8MCWPTahUH
         B7ewIxbeRrpX4BgrxKmfnhU49OjG8gntGt5EGJyDV0pkpOWhD5+clykWMp3CvflpDsi9
         9+V6Kbxvm5cSH+wq2pCz67Fso/0jUbtdLccoy+NcxMNK14bK12FjE9rqs5kboTcFQ+fL
         63Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728237956; x=1728842756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e2zEsNtZMNIDEGihRj7PBI2aICQCPZPWqZX5v0Y1Sj8=;
        b=jb0NFCkRKJua4iyTWs5kWn6worbyEQ43bIHn9ABT75pThwj0xl/iHKKCT3Tlz/p0Sw
         yD0Y/UnzP5qqrUIN/wpkw+JqNEar9kULew10rBCAoVsdq3Uy6KnZAbzvFaJIQ31O6Hht
         2rH3S8bcBgKykPRV/9k5fsVX6buXerEAasYXWFj6lrLAdtzS+G6mRkCvPwY9SiHuN8U/
         ZRx5mBghY337YBCC9JcPBA7RAqfcfbBBfg1fkare+TGNwb/oInmU7BafGoKWuMRYFF4L
         dgFvXheOr0s6lZ3krE6N8Vw8OwLAHSIvRSmKD4Nb304ZrbEEtzHbzWtX0X2WdyPNH0CY
         h93g==
X-Forwarded-Encrypted: i=1; AJvYcCU5mJwd9GSVuPLI0NdcbhBwlX7kWI2t91H2Excl+c/c5vxi3kgHVGHuXwj1sjw2GddTkZ2SXzZKLuYRS/o=@vger.kernel.org, AJvYcCWLxYVIi0yVvF58O7CsjlvFtC7Ik2N0emZfy7l2fh46Adku9UaJbJ+nnVu1C1Ej8px2YsihTnnl@vger.kernel.org
X-Gm-Message-State: AOJu0YwEavBgAoNqbGtBIfNnscCLxJALWx79Odg7YqWnubWnXmOKR4Bz
	PD3KdtUTMUl7ZHdJImjPQYLA6cXBp1m8uhQnGsJ/gS0jrz4UZkTg
X-Google-Smtp-Source: AGHT+IFiSe7nJ717OSqEnP5OD4CDbP14/mLVlLX05Gsl4CNHfbQof2xmBWl9KyQar9O4VwiV+D9Rsw==
X-Received: by 2002:a05:6512:3e17:b0:52f:c27b:d572 with SMTP id 2adb3069b0e04-539ab9c7e88mr4334458e87.59.1728237955421;
        Sun, 06 Oct 2024 11:05:55 -0700 (PDT)
Received: from [192.168.0.138] ([31.134.187.205])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff23307sm574162e87.197.2024.10.06.11.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2024 11:05:55 -0700 (PDT)
Message-ID: <34f7eda9-e4e2-49e7-af88-82c377c8c7f7@gmail.com>
Date: Sun, 6 Oct 2024 21:05:52 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: fix register_netdev description
To: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241006165712.15619-1-insafonov@gmail.com>
Content-Language: en-US
From: Ivan Safonov <insafonov@gmail.com>
In-Reply-To: <20241006165712.15619-1-insafonov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Please do not apply this.

On 10/6/24 19:57, Ivan Safonov wrote:
> register_netdev() does not expands the device name.
> 
> Signed-off-by: Ivan Safonov <insafonov@gmail.com>
> ---
>   net/core/dev.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index cd479f5f22f6..06b13eef3628 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10611,10 +10611,10 @@ EXPORT_SYMBOL_GPL(init_dummy_netdev);
>    *	chain. 0 is returned on success. A negative errno code is returned
>    *	on a failure to set up the device, or if the name is a duplicate.
>    *
> - *	This is a wrapper around register_netdevice that takes the rtnl semaphore
> - *	and expands the device name if you passed a format string to
> - *	alloc_netdev.
> + *	This is a wrapper around register_netdevice that takes
> + *	the rtnl semaphore.
>    */
> +
>   int register_netdev(struct net_device *dev)
>   {
>   	int err;

