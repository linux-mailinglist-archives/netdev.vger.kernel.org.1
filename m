Return-Path: <netdev+bounces-169775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A9AA45A91
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 10:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECC141894C52
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 09:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39766238157;
	Wed, 26 Feb 2025 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="yo4EE5bm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806232459CC
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 09:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563338; cv=none; b=chodfZx/kwvPgCfiMg0/8DYPH3LJt1Pkoz7eLnZBy4de6DFPjLXeSaZy6whfzvS/9EZ2M4gKMx5c+962R/nUOsrhMhpBPs7B+9Pbjdr3+t84EoJcdpocqadloySnb0yhSAl0oICtu2zz85A2+miDKA5oz0Bw/6ZmRQ60LBpHVCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563338; c=relaxed/simple;
	bh=1HPPBHHSUY3PRvmuiiP90sap6MSAtYnXYhmsU0XUNLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H++o4O8aLiT/VSq8dP3IhPniu4h66lfGTBRQBjagrfWL8lmfbWgg/fB26XzGCdlrnALHr5m/qrf/tgksdU8+++rxmX2HxQlcWrPj+vUkSH5v8nuEDnxh5uo/zBWH7EBstObNMF9uOHQuqg8DOQ17wU1NZJjB/iyFH1p2Jw7e63g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=yo4EE5bm; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e0b70fb1daso8924045a12.1
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 01:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1740563335; x=1741168135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CEZzW4mm0bZ6YAjD2BUJKfvoKsnMPQlH9S2idWWcyCw=;
        b=yo4EE5bmdsx9h5+yfNJ1TwPfQNIxLnpPJ0fmjacDfFr5LL0F6yALSJp0oi8SaR0Hkd
         BAj4xU6SDyTfq9Ec7p+xlGjS/YM/iPScLYvR9aqLj8YAQu67pzTuPCjY4rlLosNlkxMK
         h/CHrRZ68kPK3dA/lstN/GA4VCUFrwbU4qD23vyAB8e7EHe2kRmv/wxuJvLyl2BZbikV
         v2LYth3VoURH1d6MCFeu1DJUI+xoQm80BzX3B56Ku9RdKs9rzsNJUMcc9giT1YLpW+VH
         8I0Nd1zf54Em81lpmnVtPtsGiC3NwszHBahrr6k/8ccdfqjUPJdVAD6QA2oj/g4tO2s5
         Z8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740563335; x=1741168135;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CEZzW4mm0bZ6YAjD2BUJKfvoKsnMPQlH9S2idWWcyCw=;
        b=g/7ZjvmGKK2qiDA+EICbBXjSo2ndA98JGG77/BVYuZrE7Ab6JvhXstrLX0kYskfSeV
         D5P1Nf82jaM4ueVitVc4DAENzkNN0+6i+E9pPH+gZeXkJbyK721ihoDdqU9t1AJVCYRn
         gJWAbyvekrsK2l4EbIzNIwcNGw3EpCzgSA0z/oKGoweO6TdaKBfVRXSye3gP5znp6ojg
         /OHbIZrRMf9ZCPTWzTlQY88Ccr+5b066JU1uPGhAvjokhRXaFyByoEn+At9qVFB9+KiT
         Rix2+lCHfsjrcjaJy44jxqKMnPELO2QE74TwDhMIwpZ9vfv9oIRS4+GgQdBH41FIDj1i
         f6JA==
X-Gm-Message-State: AOJu0YyaLVcBVE89RLkoyHRkfv7T1yjwQZRIq+N6CPtHG/ZT5e0vE9lr
	CHS0uPdb+E6ceEBrlz41EnGpJlI1IOAaj1FNlBb/YPx261DtdAZyVSJjw/OBnb4=
X-Gm-Gg: ASbGncs0EFAu+YE2aK8KXuJY0i5nBNMF5cFqh4FphQ9Rvym7x55uW7h49HWjCAD5ie3
	Um9yLeYGh6v1wYFpuP4J4c8Cewzbireqzs7/mWJzUwNOGu2rJ9Am7fBoNQ/4saqOq7xSVI7xpeL
	cQQUjD7IXMNste3LF/dT76H2rYQnkxkAumZ24/WrAFDw/1cWTqfQk3kPtrgN7CoOJEkKOlguu26
	4NT5HTXEbJT7k9pV+agNMIK8H59tmkdwHQT3x88fW0tsBWWI+GHpRSI+2Yq+ASEABoh653jwcIo
	IvlGAYEurD3XDgjiRS17H0QiQIZomybo6tqq9ujY7Clipa9/1mfvWhtg1g==
X-Google-Smtp-Source: AGHT+IEl5djX8JiFRmc0bLyTiN+Op/kyQSTScGVDsJHx7aTXaZ3/WEl7mETyPPGA+Rk2eAsmYwBy9w==
X-Received: by 2002:a17:906:18b1:b0:ab6:ed8a:601f with SMTP id a640c23a62f3a-abeeed1123amr258466766b.12.1740563334449;
        Wed, 26 Feb 2025 01:48:54 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1d54a0dsm299856266b.50.2025.02.26.01.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 01:48:53 -0800 (PST)
Message-ID: <df2b1a91-89a4-40e8-b0d6-b666b17efb5a@blackwall.org>
Date: Wed, 26 Feb 2025 11:48:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] netkit: Remove double invocation to clear ipvs
 property flag
To: Daniel Borkmann <daniel@iogearbox.net>, kuba@kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 Philo Lu <lulie@linux.alibaba.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250225212927.69271-1-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250225212927.69271-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/25/25 23:29, Daniel Borkmann wrote:
> With ipvs_reset() now done unconditionally in skb_scrub_packet()
> we would then call the former twice netkit_prep_forward(). Thus
> remove the now unnecessary explicit call.
> 
> Fixes: de2c211868b9 ("ipvs: Always clear ipvs_property flag in skb_scrub_packet()")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Philo Lu <lulie@linux.alibaba.com>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Martin KaFai Lau <martin.lau@kernel.org>
> ---
>  [ Sending to net since de2c211868b9 is in net ]
> 
>  drivers/net/netkit.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> index 1e1b00756be7..20088f781376 100644
> --- a/drivers/net/netkit.c
> +++ b/drivers/net/netkit.c
> @@ -65,7 +65,6 @@ static void netkit_prep_forward(struct sk_buff *skb,
>  	skb_reset_mac_header(skb);
>  	if (!xnet)
>  		return;
> -	ipvs_reset(skb);
>  	skb_clear_tstamp(skb);
>  	if (xnet_scrub)
>  		netkit_xnet(skb);

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


