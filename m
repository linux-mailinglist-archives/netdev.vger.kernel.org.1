Return-Path: <netdev+bounces-100626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E30998FB621
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95F0F1F27741
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 14:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF9313D514;
	Tue,  4 Jun 2024 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="1wDv1eu6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3FBC13B
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 14:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717512222; cv=none; b=jxVRwlMa1czWEs2JI1xOVWhI/3m/VnnB3ZJ/uE9rQlTqsoxF+XrOTbT+8PHo9WYtsYh560F4l6p2M4OmF5gNx/70klV48DKgcHn9AehujMI9LM4MprcTy5JX16xBIw14H8og1D8oJ3MIAmxz5F/uzalKJSpBkWOFA/aATaWQkWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717512222; c=relaxed/simple;
	bh=ctL3vOIMlqdpL6CapPC1i2IXAG8LcWYLTNh2SbfxJmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cHbr9YTPWAU3NHV0ypzBQib7s+RIHZAZ5oYYpQvpZRlGielmq8k38Bg2WqQxRqLRK1omhMpSIdeOg26l3LqHpxYb2fsUuPt8WG/yfzYdZu0rekUJGXjvgA1c7dC86A8tnAxHi0DR47MoAm9NgoexMXDpYz8WAlY7qTZGCWicV3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=1wDv1eu6; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52b9af7a01bso2823391e87.0
        for <netdev@vger.kernel.org>; Tue, 04 Jun 2024 07:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1717512218; x=1718117018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZCEn26vgqSLqQ0Kbr2xP1FXMBBWSrXPv0PAuT8e/Jrs=;
        b=1wDv1eu6oWQwOgVoxRmo6/jVdW76i+Rv7vHzZR3oochQDxCFUrsKeAeDWAVR33in34
         JARx+1OWL95eZDw6y8yTGXcpuVnreGTvDCXMXW0lqSsTq0/UcruHNGzOFy2MS1cwVMbN
         KJEWSw6dmB/57HAUDd0Gh3faRLuMdlLtLjJSrgdOy9EXFkkyWQ9K9dojckCID7QV8+pz
         UMAqIVP35kFTK15dTCN6GTg7eU0ycjn4zod2ty0+EoHDqZhI/yZe58skmzTLPSz9myys
         RYR8z4oU8HgODH7cjFD72QFzHrzspbSPS7zhNj9VHHMA1VUskDAReSkBqGVnbNDvOvPS
         ddmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717512218; x=1718117018;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCEn26vgqSLqQ0Kbr2xP1FXMBBWSrXPv0PAuT8e/Jrs=;
        b=ZFPO4ACNWTzZdBxPdhb8hCufIS9ti5UvNRdMaw3k+nJc2Gx0fZDqY+LIXALexQvAYj
         LGAyCg74cteS6wBS3Mj2OefzybJtpgkGc1qxXGSxkErAIQD9PXFpyJqP79Mj/LmKoa1U
         U2I4OjZ8QZOCWdcTKC5hEr1GO6MYlQQLdycVmu1LMnJ+ADCnLxOjIFd+xIyJ/pw8Wc9n
         laJFnm0qfSUOC06CcDSvq/lfvs/6FA4jP2v7YbaOE7nyeAIz3EhOv3tQET+TnMTt4AhJ
         4rc6rSKnJyKDfTPuX7S730Ag11KtM3qEo8CGGMmSb26cYpjVVFsPN7qruINaX5yrqC5a
         TSyg==
X-Forwarded-Encrypted: i=1; AJvYcCW7YpQ0QlD0EaLoQH2TqRjJ/PFAN5VKBWUQieJHwYXOXCuybV+Izel/CFxPIdVUyCWQvHxrrMHsy7o3swao7Hs8FghA5BnE
X-Gm-Message-State: AOJu0YyxD7dGdPK9OsIBE9z/aPOlxM6WJcdLHo7sX93QWT5nX/98Glbv
	gtBdxIc6wF95ZnPS1++Nk2osceHOMWyhNdyb6eZUJM8dfupcs0JYZT1nvKXWjSc=
X-Google-Smtp-Source: AGHT+IE7Xgjew2+pYIorgscT+zEtC6CiHfD7k5h5SBbUKiV5TVIkUTo4RiJEiP56EYmy6Bj8NTlM6Q==
X-Received: by 2002:a05:6512:1152:b0:52b:9c8a:735a with SMTP id 2adb3069b0e04-52b9c8a74fcmr3991508e87.40.1717512218053;
        Tue, 04 Jun 2024 07:43:38 -0700 (PDT)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a6522d405sm3599992a12.1.2024.06.04.07.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 07:43:37 -0700 (PDT)
Message-ID: <c117893f-865a-4fdf-a480-705c31a72ee3@linbit.com>
Date: Tue, 4 Jun 2024 16:43:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] drbd: use sendpages_ok() instead of sendpage_ok()
To: Ofir Gal <ofir.gal@volumez.com>, davem@davemloft.net,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, ceph-devel@vger.kernel.org
Cc: dhowells@redhat.com, edumazet@google.com, pabeni@redhat.com,
 philipp.reisner@linbit.com, lars.ellenberg@linbit.com
References: <20240530142417.146696-1-ofir.gal@volumez.com>
 <20240530142417.146696-4-ofir.gal@volumez.com>
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Content-Language: en-US
In-Reply-To: <20240530142417.146696-4-ofir.gal@volumez.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 30.05.24 um 16:24 schrieb Ofir Gal:
> Currently _drbd_send_page() use sendpage_ok() in order to enable
> MSG_SPLICE_PAGES, it check the first page of the iterator, the iterator
> may represent contiguous pages.
> 
> MSG_SPLICE_PAGES enables skb_splice_from_iter() which checks all the
> pages it sends with sendpage_ok().
> 
> When _drbd_send_page() sends an iterator that the first page is
> sendable, but one of the other pages isn't skb_splice_from_iter() warns
> and aborts the data transfer.
> 
> Using the new helper sendpages_ok() in order to enable MSG_SPLICE_PAGES
> solves the issue.
> 
> Signed-off-by: Ofir Gal <ofir.gal@volumez.com>
> ---
>  drivers/block/drbd/drbd_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> index 113b441d4d36..a5dbbf6cce23 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -1550,7 +1550,7 @@ static int _drbd_send_page(struct drbd_peer_device *peer_device, struct page *pa
>  	 * put_page(); and would cause either a VM_BUG directly, or
>  	 * __page_cache_release a page that would actually still be referenced
>  	 * by someone, leading to some obscure delayed Oops somewhere else. */
> -	if (!drbd_disable_sendpage && sendpage_ok(page))
> +	if (!drbd_disable_sendpage && sendpages_ok(page, len, offset))
>  		msg.msg_flags |= MSG_NOSIGNAL | MSG_SPLICE_PAGES;
>  
>  	drbd_update_congested(peer_device->connection);

Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage

