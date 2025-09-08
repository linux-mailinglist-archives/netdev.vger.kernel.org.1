Return-Path: <netdev+bounces-220822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA578B48E23
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 14:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B24E1888374
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 12:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140052FE058;
	Mon,  8 Sep 2025 12:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4MO8Hlw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB42E2F3C28
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 12:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757335925; cv=none; b=HQp+sLSdl9PB8dCGlRY5bM0cHCZvyIW7UPNl/1EUr3Zs3Ze790O8kdojma1Xk/b/oBa+lt6eKMBtF+mT6VjA7G/bp6dCy+JOoOB93EIDAr3B2zyteMIX0VYDVnJ5EDvIQXdrCwPMYUI/Md+0WReJL5WkPiIIvn3C2kE3TO3Bmt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757335925; c=relaxed/simple;
	bh=Rns1DRgNJrz1u3lVy5O5+sVN52/5SC91U9MHA+A24dI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RkMf0GHp+nHPvJ6nsEc8X4i5FeSj3v9qHgdBIbMeX1no5EP8cKMdrEopkEFN/k05vkn1qGoZdDS0OI4DqWw7pqFURBrro7Ijsvr8ONirU7m242sp/XQoMyh4jKR06Abq6Zmx5RQasFARFtoKC7kfaN3jy6lZnOW4opdxQh8iCT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4MO8Hlw; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3e5190bca95so1336375f8f.0
        for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 05:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757335918; x=1757940718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nS93qwRJza9c2RnAOF7E+UUjAo67ExvPQwScKuQUMbA=;
        b=A4MO8HlwUj1iJD6Dpv03z7NorZ/vZCjZ/Kldkmi2+zzJVuxWnGCKS2j14EUvk+G9Ds
         Fddg3AzH0GnGXIOi864WYai6KduJFAFU0NA3GW9qsHn10RvtpTG7t8hG3or7bN1ebU+V
         IFoSfnkmtVspbcuAYyu4V8ESRGb4OjyMNcwCuqCyPq46ZrYLl3SLvPbGT74xSj2VkPff
         6XR1scYJxUKda2JPNux505OreKxV2fkg0YbgMP9yEph74c32wHvp49I++xcwXiSHMpJK
         CecSbs5hfRtRcZJP8Hb66YSqSGYMjO7gGhVVQq/08Hb/V1RhUkfplEBA54h3QwgJbeAO
         u+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757335918; x=1757940718;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nS93qwRJza9c2RnAOF7E+UUjAo67ExvPQwScKuQUMbA=;
        b=SsGrD8RpA0JG3RaxBjkC5NHzPRR1gyGrvsjMdPqIqsLPyObBGx0Ag7ZJK/0dkRvG6e
         C/mdgRCezd0YDOoIkzwOCR+TrrdFsODnE3j2eDRGHN4IhXEKZq6+ldXr8+zEovQCA/fV
         h9QMhHrXNaG1/pAqc14P4oQG+JWGEe3RwUtrbJm8HTmNgH5i+1W9KgH99FGMr6ItSJu/
         WoZcE4+X9NfaAys43H2RGhySAZEO4+uNr9E3kyk206lIdqf2EwlGwA3VaIepbxGcfZ9s
         q6twttYjna85CL3tv/lP5jb7FtIQDmCpZ6rMD+baeJHkwElVTi+4PpIWRWmfb1He6+V9
         P8ew==
X-Forwarded-Encrypted: i=1; AJvYcCUCkWVrQ71g9KDKFqfOk9Ex53vrpwe+Iqv1aLISrVU5T7teq8FvM29clerFqI8caryxIIxfEOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXk63MmLW1NPDuzt+RTH9+lNfOOKCNRr3ekJ9XmnIo1RExMTao
	vnfQODZ9Zgj2CkdQArxS8F+e8tuM4vgXcgXWfNPwOuIMhmUIgqPjYxdJozYXVw==
X-Gm-Gg: ASbGncsfscf5UlDALZ11Ex2OP8r3Q1dIDhFDdInvOShBZeY1ChBmXD59APYZ8Xr+dD1
	QNSRB1eFMfg31zXK2Oa/4IURiWsjO3YwKfXsg2hh/rm7XMzkZ/PgySaaJPJdBmetOLaE4KJTmMR
	FJqZ3J2nCjoV80yXoSHgDpnPur5oYSxdjH6UiYeaeA4fuW/sx8afrYE8iy3+mrIzWCLu3P7/QBc
	MuoDtLh54ExVzOmLgRuYpV/1GqDO30Ll07ekM8roN+Ezz+rg5MN6dEwVkQ4/u9s2mEtR1hSCa7r
	MInj18DMY9InRLk3qsp+slq9UKxlR1EF1uZpXCXyFypEo8K278KIzvZSohA0kO8IjG5pYLzAh19
	fCGQvXevibTwjb9R2fozLPkTzeKJCRYfHWZjhPMwnoxANG/Ry19sFRxJE2CVbjlXGZoWw3yA0w5
	7EpS5qSzwDHw==
X-Google-Smtp-Source: AGHT+IHLrsfgZpVgX9u9XISEUVfOIMEtAjNXS7N5HozR2p3QkJu7xlTLVkb+CKKTa9+OdRQm4CjIJQ==
X-Received: by 2002:a5d:5d05:0:b0:3ce:f0a5:d594 with SMTP id ffacd0b85a97d-3e641e3cba1mr7220074f8f.13.1757335917979;
        Mon, 08 Sep 2025 05:51:57 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e748171834sm4465263f8f.5.2025.09.08.05.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 05:51:57 -0700 (PDT)
Message-ID: <609b35a8-ebb1-44dd-9a33-0eb1257021cf@gmail.com>
Date: Mon, 8 Sep 2025 13:51:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sfc: farch: Potential Null Pointer Dereference in
 ef4_farch_handle_tx_event()
To: Chen Yufeng <chenyufeng@iie.ac.cn>
Cc: kuba@kernel.org, linux@treblig.org, netdev@vger.kernel.org
References: <20250905030737.220-1-chenyufeng@iie.ac.cn>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20250905030737.220-1-chenyufeng@iie.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/09/2025 04:07, Chen Yufeng wrote:
> A patch similar to 83b09a180741("sfc: farch: fix TX queue lookup in TX 
>  event handling").
> 
> The code was using ef4_channel_get_tx_queue() function with a TXQ label 
> parameter, when it should have been using direct queue access via 
> channel->tx_queue. This mismatch could result in NULL pointer returns, 
> leading to system crashes.
> 
> Signed-off-by: Chen Yufeng <chenyufeng@iie.ac.cn>

This patch doesn't make sense; ef4_channel_get_tx_queue expands to
 &channel->tx_queue[type], which is an equivalent expression to the
 channel->tx_queue + type you're replacing it with.
Where do you think a NULL comes from, and why do you think this fixes it?
-Ed

> ---
>  drivers/net/ethernet/sfc/falcon/farch.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/falcon/farch.c b/drivers/net/ethernet/sfc/falcon/farch.c
> index 01017c41338e..29b34fb9fb24 100644
> --- a/drivers/net/ethernet/sfc/falcon/farch.c
> +++ b/drivers/net/ethernet/sfc/falcon/farch.c
> @@ -838,16 +838,16 @@ ef4_farch_handle_tx_event(struct ef4_channel *channel, ef4_qword_t *event)
>  		/* Transmit completion */
>  		tx_ev_desc_ptr = EF4_QWORD_FIELD(*event, FSF_AZ_TX_EV_DESC_PTR);
>  		tx_ev_q_label = EF4_QWORD_FIELD(*event, FSF_AZ_TX_EV_Q_LABEL);
> -		tx_queue = ef4_channel_get_tx_queue(
> -			channel, tx_ev_q_label % EF4_TXQ_TYPES);
> +		tx_queue = channel->tx_queue +
> +			(tx_ev_q_label % EF4_TXQ_TYPES);
>  		tx_packets = ((tx_ev_desc_ptr - tx_queue->read_count) &
>  			      tx_queue->ptr_mask);
>  		ef4_xmit_done(tx_queue, tx_ev_desc_ptr);
>  	} else if (EF4_QWORD_FIELD(*event, FSF_AZ_TX_EV_WQ_FF_FULL)) {
>  		/* Rewrite the FIFO write pointer */
>  		tx_ev_q_label = EF4_QWORD_FIELD(*event, FSF_AZ_TX_EV_Q_LABEL);
> -		tx_queue = ef4_channel_get_tx_queue(
> -			channel, tx_ev_q_label % EF4_TXQ_TYPES);
> +		tx_queue = channel->tx_queue +
> +			(tx_ev_q_label % EF4_TXQ_TYPES);
>  
>  		netif_tx_lock(efx->net_dev);
>  		ef4_farch_notify_tx_desc(tx_queue);


