Return-Path: <netdev+bounces-151017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 843899EC5E8
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 08:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C2601881E96
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 07:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC701C5F3A;
	Wed, 11 Dec 2024 07:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="DH2Qoqug"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3FF1BD9DE
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 07:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733903276; cv=none; b=RQnmUvIEutvjyUjTJllw80DhrUv055ZCbjnRrlfVJseuFY6YgE8CqC8AH8GA4jcbrUiyRPVQONNnFtSq+Jwsln8doRjhsiGsmTRSMYpA85Bhp+tDOFyfnYCCp7Xm/m8GcPw1yyXAEcFKP7BIZJpa49H+cNFgwLMZl/yT6qKKKMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733903276; c=relaxed/simple;
	bh=TUVGTdzfcQP43eRAMRjYFmi1MnK/rZDxy5/4b8C8Hdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MdScSrrUDihTWLJ+pZSBUmhEMTV+RoWeZppBRM3fGTLiblSO24pkC1KaDqzC4D4XDtTAUAbJ3KQEJTyAzFeoNGV53M0XNImShLE/VkfWQAqwrhXjfmq5xuV7sAnxyKYCmpEi3vtFQXHr+dTxcQuBNr7CEiLxWdfebCoqBUPRYHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=DH2Qoqug; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8dd1so10423062a12.2
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 23:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1733903273; x=1734508073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C9avSO34dj2cbK4oT3GkDrDvFb5SBzVZgXvDYfCmnG0=;
        b=DH2QoqugnssSYahAnVgFMVATuo6hRXTAVBYxqS4srDTKcel6+dOoFU4bkAq6ky5fMd
         i70oTXJaAH73UB1j+gXa+1FrMwvNCNBZjsFRA7Uw35WrUV+Yere/5rxV7TAKlQitu7Mn
         cESFSEP/IuaxFI+owBHEvDQnQcHRK1ioftYNxL369bw51+AoYSYvt/hKALZpzSsq+JzC
         9Wc13OT6825GkNZqTvMK3bYiVWzOY0vCjLLr55579fBJ4A0PtHJF8Uhxs8BnWIJ7oYY7
         99ZFiChJGbtcGbd8vb29sL9R+gLP8/EZjDERpeNtuU/Oq4Yk93i8ksX4gr53gp0fwtnM
         qmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733903273; x=1734508073;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C9avSO34dj2cbK4oT3GkDrDvFb5SBzVZgXvDYfCmnG0=;
        b=EYcRp2PVcduN9slmrXibNjGA+nCwBg4CzHY9KzvysXsGeVKWgXQ+tk4fFF+7knClTO
         sUcgeGI2vt0lNWBayic+6cRN1d5WpUGUzfS2JrPLZ84wD53s8cVaEUsuyRfQcYbUbdwi
         R4bCN1soVhanlfpJY0UXGfcgZNKG6SiiGo61JB7un2IokK5plUyA/RtQoTCDXHXyrhdW
         R7JJpOCLeGhqdS+nbKvMd6UpJJOQxdh/O3il0if1S8vcOAR/vrFjl0yPbYxDS9bFys8g
         I1Oh2S8wqw3FVQkaf9XmmI1A64XRlfAbFED3AaFlqjnsW7tHh0SxqzHgdiDkHev2Srk5
         IMnw==
X-Forwarded-Encrypted: i=1; AJvYcCUuSWH0F1vNPlweUXWIXO0Iii1Uuv+liJCSaSxqDVvzNihmzOu7kh5edOhfFhiVyf7/WhQ6pA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQmJcwT0THErTkVSKZAQxIaf175ZqguVJIgqBWalvHsTbfbWaQ
	k2nbZxLnhiQDDQmC66Dop1m7lqkC7Z3H+Va81JWX5MYKvDeFcz5ZtkOsOUt01to=
X-Gm-Gg: ASbGncsKnZSQwSu6kjCFpPY3TrcEMPXYRHTI9pYDC8pICKAZ+uiO9O7vit24/AaqB5P
	wRwdaCCOSz088BfykfXsor/zgLNgEP74QaDZhKGP4nQ05/LA/UNIu6TUvwARL2qVHNVj8EzCzXT
	tvuWp+aoK5EdjTIdpx7WHJPz4UiAnV/mHPkJGb3Ws+NgeYbnYcDhHppoNZTMnszjop9rQRgtoq2
	xsZ1/GB78898F2hNPn2tL+ZDARDZtE+iZmAAKsfcsGbfOEVKTCVL9pQ
X-Google-Smtp-Source: AGHT+IHaFCpxYn1qWnjVigLj6jX1jU0ewLVQF5KgPoDKZ0fPJqOBncskDQmBZX1lbuSMbjqhPVLTyg==
X-Received: by 2002:a17:906:2192:b0:aa6:6a52:962 with SMTP id a640c23a62f3a-aa6b11a05b6mr141367666b.18.1733903272842;
        Tue, 10 Dec 2024 23:47:52 -0800 (PST)
Received: from [192.168.0.123] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa673474d96sm540475266b.96.2024.12.10.23.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 23:47:52 -0800 (PST)
Message-ID: <9c4f8153-7eb9-47a4-89a8-dd0f875b8b1a@blackwall.org>
Date: Wed, 11 Dec 2024 09:47:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 5/5] team: Fix feature propagation of
 NETIF_F_GSO_ENCAP_ALL
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, mkubecek@suse.cz, Ido Schimmel <idosch@idosch.org>,
 Jiri Pirko <jiri@nvidia.com>
References: <20241210141245.327886-1-daniel@iogearbox.net>
 <20241210141245.327886-5-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241210141245.327886-5-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/24 16:12, Daniel Borkmann wrote:
> Similar to bonding driver, add NETIF_F_GSO_ENCAP_ALL to TEAM_VLAN_FEATURES
> in order to support slave devices which propagate NETIF_F_GSO_UDP_TUNNEL &
> NETIF_F_GSO_UDP_TUNNEL_CSUM as vlan_features.
> 
> Fixes: 3625920b62c3 ("teaming: fix vlan_features computing")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Ido Schimmel <idosch@idosch.org>
> Cc: Jiri Pirko <jiri@nvidia.com>
> ---
>  drivers/net/team/team_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> index 306416fc1db0..69ea2c3c76bf 100644
> --- a/drivers/net/team/team_core.c
> +++ b/drivers/net/team/team_core.c
> @@ -983,7 +983,8 @@ static void team_port_disable(struct team *team,
>  
>  #define TEAM_VLAN_FEATURES (NETIF_F_HW_CSUM | NETIF_F_SG | \
>  			    NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
> -			    NETIF_F_HIGHDMA | NETIF_F_LRO)
> +			    NETIF_F_HIGHDMA | NETIF_F_LRO | \
> +			    NETIF_F_GSO_ENCAP_ALL)
>  
>  #define TEAM_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
>  				 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE)

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


