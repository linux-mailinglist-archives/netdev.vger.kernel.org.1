Return-Path: <netdev+bounces-75458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CB0869FD3
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 20:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D565E1F2F505
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 19:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92673149E1D;
	Tue, 27 Feb 2024 19:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="c6AEBXaP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22A3149E0E
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 19:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060570; cv=none; b=OsHs53pMR7O0xxJspvMazIO8hVoDHvIU3b4DLP5PrAZy3iuNZi004QXNKSp28IurSNVLRdjoO+vKHL9znxrCM9OhIzErtU24ItnQbQwssgg7rUq2QyZ0WtuzpPvfMY25sdZwgkU5XcEpHENdkac3wBARRG5//R6tJPbWWFvTQzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060570; c=relaxed/simple;
	bh=62mCy06yom5/3xe32ZTRaQKwjk4T0LRNc3FRQaih5po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nuVAE9TvqJbo6Ew2vIt1r2pZRTiA5cu5F5B58Hp+1/oQ7qf4+ENxAlqbp3oNTGUnLH9QeSejYASdGSilVHqdeWEA+0UHPQfBBzE9iwyASFl/FC/s4ZppMHaz7od0GYblivz5jSZz0Q/aXT7dimZyd5tnH0YCGw9xI0DvoSXfaUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=c6AEBXaP; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3e7ce7dac9so527852566b.1
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 11:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1709060567; x=1709665367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=945rBYNcoUgKGmowyvDPIGUfUkamx1ovsI5O4nwuIRI=;
        b=c6AEBXaPEAx3oIdQRARt3PqijwVptPEpJw823O9AmYhc+2OZ1tNjZIufNVHyz3aAdb
         ia9kunaxxGSDTVaQJA8FFWBXHyX0RTQY1X/UulbGtEKc24LgW0Jh8cFkwQFMlA3aWvbr
         GZUlQ/6yiYmBY+9zPgOFehc4OC6sfqaG00NGVNj6vMtafLAJ4w0/2xLDE28CB6xLOcmv
         dbh5Bq2slgR3B+oja8CslcB9G9pjD8GeLZCZJ/zr+AfRegQyvRcA8Za+5ag5htI7itTR
         Zi58gz1os8lXC0WoMs1w9Tyx1ySZI0H1OvB5fSRlppdH2Gy/sf0W5vgcwyYO17iWIblj
         dI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709060567; x=1709665367;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=945rBYNcoUgKGmowyvDPIGUfUkamx1ovsI5O4nwuIRI=;
        b=qjPmpiHEkg+UippxPTQGmHnMeNm/ra+f/IHeG9g/g4Pe8PFsARHL/NHcH5S/rEmUUx
         2UyTEDQrzNoWxLS/nD2SxeLi6Gpt45IT4+9Is9MwhZVfJv+RSxTu0Y2cxj61IHlZr1wO
         v/2xgcbVr7djnmWCY1RhIPF7iwSP28BebByIxlUKffF/0cE6A0ckAhV7wKKhIWGj8/XE
         fyXOCUig22obegblXxJ0FTmqeC1qri6KpMCOgR/luMfOGaM20unZjFPGASOWB3h4J5t8
         PzblP+kobGqO8vlzuBaP6cxq8VJHQ6UPM0MrzVi2053f74xdlIxxuxRAPGnA+ZepP1ny
         G6Rw==
X-Gm-Message-State: AOJu0YzQQ0cZW5Nv+sYNZ/5/Za72oGsrSXUmkbdM1s40OwI6stIJsugm
	r7lobOHHJ7OGlgNb2dCIUK/UrYw1wB7BmJbe8Hj+FIBKV9twkNsDwfxOjhodvos=
X-Google-Smtp-Source: AGHT+IHwlaf1WNIWALYUt7NSPAriGIGVbEfipxAgr6lBGWMwiTlps9KdmMszSlFOlV6rNFwC7vlCdg==
X-Received: by 2002:a17:906:3488:b0:a43:ccd:a816 with SMTP id g8-20020a170906348800b00a430ccda816mr6234481ejb.31.1709060567415;
        Tue, 27 Feb 2024 11:02:47 -0800 (PST)
Received: from [192.168.0.106] (176.111.183.96.kyiv.volia.net. [176.111.183.96])
        by smtp.gmail.com with ESMTPSA id rf20-20020a1709076a1400b00a43e6c2e107sm91703ejc.189.2024.02.27.11.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 11:02:47 -0800 (PST)
Message-ID: <f8a78ffd-3504-4cad-bbcf-553186f228f0@blackwall.org>
Date: Tue, 27 Feb 2024 21:02:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: bridge: Exit if multicast_init_stats
 fails
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, Roopa Prabhu <roopa@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 "open list:ETHERNET BRIDGE" <bridge@lists.linux.dev>
References: <20240227182338.2739884-1-leitao@debian.org>
 <20240227182338.2739884-2-leitao@debian.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240227182338.2739884-2-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 20:23, Breno Leitao wrote:
> If br_multicast_init_stats() fails, there is no need to set lockdep
> classes. Just return from the error path.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   net/bridge/br_device.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
> index 4f636f7b0555..c366ccc8b3db 100644
> --- a/net/bridge/br_device.c
> +++ b/net/bridge/br_device.c
> @@ -135,10 +135,11 @@ static int br_dev_init(struct net_device *dev)
>   		br_vlan_flush(br);
>   		br_mdb_hash_fini(br);
>   		br_fdb_hash_fini(br);
> +		return err;
>   	}
>   
>   	netdev_lockdep_set_classes(dev);
> -	return err;
> +	return 0;
>   }
>   
>   static void br_dev_uninit(struct net_device *dev)

Please send them as separate patches next time. These are not related 
and shouldn't be a part of a set.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

