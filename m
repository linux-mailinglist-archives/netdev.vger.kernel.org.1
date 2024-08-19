Return-Path: <netdev+bounces-119557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03007956313
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 07:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F0231F226EF
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 05:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D74149C57;
	Mon, 19 Aug 2024 05:16:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D66C4594D;
	Mon, 19 Aug 2024 05:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724044600; cv=none; b=FEOf/DS7JR/EagzGO9EBpeO4I/KQexczrWuiLzhBo7jyoheu4SeoE9pK42fgf+LJ/rS5qyIRBlKArTNvtCfh6tgZ1+/Ar2dSFmR3zHzE8vYTgcK6+IHvvEFujLA0+kkPA4PEbCFW/2RQs/C76Z0MavGLBqyRt3ZftliW5POTok8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724044600; c=relaxed/simple;
	bh=gq0cFjStxzBeQsciDl3jHF5hObqdTt/pX6H5YAdqG+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SZ1ABclEJdVe0N+/Mvju0hjaQSz/16RM//S+L8KvOPFBJ6noYtGlOpEbHMWo42n/9lO3CxopbSsPQyr85n6N/BdcxgpaeATSLlYu9RA5FnAkdLivDIMc4biSlu0I0DgjKJifY6bw9k1C8RJaco1lB+4yiMCJnG/FnzOjkXns5MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-428085a3ad1so34176995e9.1;
        Sun, 18 Aug 2024 22:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724044597; x=1724649397;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HprnbFTayqz+uqlg8mSPJykFJTiRSC/Vz3kgO0IGUVQ=;
        b=IGizhJeNBN2OqWHdlbB1/Bo26PODO976xAvdduamyYmP3xuzwLuoRbemtphx4Ilr2h
         0vvzU0e+htGU9dei9+RUdUzYsaxu0/OijsjlFzB9XQdPi+8i9ZL0FwoijIj9ivuNKvqT
         qJcjqr4NsPzZobM8AGx2B+h/vom9qdNTDH79+BvecIkmWilzX2Lo0EoDu6lWnU8hJwhk
         OW/DpdHGzIeOJjZQNFSht8AVNFP1zSZCpVIJ9GqYPU2Y2Zbp9egqr6Z4UuvogQHMeuMy
         t9Fa8sjkUimEChUV5h+9azVsBiBCu3uOEGU2OZSEIaUXro9QJAEVkpfZKhBMCTzLz6CQ
         78cA==
X-Forwarded-Encrypted: i=1; AJvYcCXOYYS4CFjZgAvzRQ/HC8rb6Z1INjjvRPGEKqTxoyRcxP7SRcQY38/A2GXUppwZBs2GZPIoR2ivhFPp7Fr2UBWogfBgzRKtAn+V/R/MkTq8H/lZDT1oNypBzWB/MGi5Ue9XH6jFV4oL82jDaqG2QNvOFPSCiVhCRQyIyS/QVW3N8mU9jDik
X-Gm-Message-State: AOJu0Yy8gtfZ8v55WAexMi5bzEAwxAaxq1ViOdWF05aqxMWG/hfKUH3p
	EPyLTNshMAkBL4iKMK8tW51KesSAfqakPN91hodGMbMAhl5K2Xwe
X-Google-Smtp-Source: AGHT+IEQGXh2paPMFKyW5G+hNAjxADeCnZiExVjQPiP6lFdfiHLIqw4du2ehIwlhYf2Au1SY3h6IFQ==
X-Received: by 2002:a05:600c:3b27:b0:426:59fe:ac2e with SMTP id 5b1f17b1804b1-429ed7cee39mr78279765e9.29.1724044596475;
        Sun, 18 Aug 2024 22:16:36 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded180e7sm149187485e9.3.2024.08.18.22.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Aug 2024 22:16:35 -0700 (PDT)
Message-ID: <9f0e05fd-1e6b-4474-95e9-64af6ffa030d@kernel.org>
Date: Mon, 19 Aug 2024 07:16:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] tty: Add N_TASHTALK line discipline for
 TashTalk Localtalk serial driver
To: Rodolfo Zitellini <rwz@xhero.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Doug Brown <doug@schmorgal.com>
References: <20240817093258.9220-1-rwz@xhero.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240817093258.9220-1-rwz@xhero.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Where is 2/2?

It cannot be seen:
https://lore.kernel.org/all/20240817093258.9220-1-rwz@xhero.org/#r

On 17. 08. 24, 11:32, Rodolfo Zitellini wrote:
> This is the patch for the line discipline
> 
> Signed-off-by: Rodolfo Zitellini <rwz@xhero.org>
> 
> ---
>   include/uapi/linux/tty.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/tty.h b/include/uapi/linux/tty.h
> index 68aeae2addec..bac4c0af67e6 100644
> --- a/include/uapi/linux/tty.h
> +++ b/include/uapi/linux/tty.h
> @@ -39,8 +39,9 @@
>   #define N_MCTP		28	/* MCTP-over-serial */
>   #define N_DEVELOPMENT	29	/* Manual out-of-tree testing */
>   #define N_CAN327	30	/* ELM327 based OBD-II interfaces */
> +#define N_TASHTALK	31	/* TashTalk LocalTalk driver */
>   
>   /* Always the newest line discipline + 1 */
> -#define NR_LDISCS	31
> +#define NR_LDISCS	32
>   
>   #endif /* _UAPI_LINUX_TTY_H */

-- 
js


