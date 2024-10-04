Return-Path: <netdev+bounces-132023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6F5990273
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09FD61F23E58
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 11:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C67172BAE;
	Fri,  4 Oct 2024 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UvMtY0W1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332B6172BA8
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 11:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728042451; cv=none; b=Ms5GozOEfReeJHWzdWm0wNJaXuIm/uoGBM1U2ZDxAQ7M7NXkvsE3OGgJ2JwjlYT8hhJzZowGQJV7oLq1bxTgljpOBwEK3DWpgfG/cY6+AGtA/B4aMXtTfcPVobt/g4iHzoS/rnog7SPT0BxiYsp1CuVvkwQjhu6QljQgkZQjBYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728042451; c=relaxed/simple;
	bh=9Bftv/ViHvya+hAel1EI0cggVPhQ0jLcj2WxYo+AdIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDwWRuN2oz5bpH9VbYEl+kba6WHTjngyr3ISOsfGFCR19Tx8DSf6UxhtBs5ARDpTH9HlkFNZOJuJU/GYLfoZF7BY57gPXLhIJcP1K6A80PKxKemo/bXWUfobh1rwWySoKHRy4eigrUxCz5rSTkhc5ZT+K1g7+K8j6gNbGI1m+As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UvMtY0W1; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37cce5b140bso1383733f8f.3
        for <netdev@vger.kernel.org>; Fri, 04 Oct 2024 04:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728042448; x=1728647248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DeDKJXnQ2GOHAMqg9c7Xaq3R7hTT7ZgpuGbhp8lo2vI=;
        b=UvMtY0W1J6LuUmC8RuOFydnLjFTvgs/6Bc3+PG3csmCRyN+TMQIVSFyhoWR12vTnus
         izKjiWFtN0niuCU0h4E4H1yD+zb61jEpJ6BXqcrI1zQ+RRjayza/GCnyghXxJXwFt4p8
         4rQ2DTM/J9oRuiumKiZN05OPCFGiuMredcmrQrsulcQ8qvVmq8FEkpf0/tp178Xm1KVc
         +eQC4iqZfRjQ8wk89GkNMDt8s6dLBTwZ9m0K5nmogysGlEvVmFhCHw4WhryKXUBf27iD
         mf0P6SiZu4AFcaN9sTiW6BZISWpwyteJ+uQ2kGB5hfsN/J1TN8UiLQz+YQrgfQ4yt3PX
         8m6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728042448; x=1728647248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DeDKJXnQ2GOHAMqg9c7Xaq3R7hTT7ZgpuGbhp8lo2vI=;
        b=qC1eJmUjMGYHqwzvOZ1+jRrQAYqC18JwYR+vbKdRrjgWPjI97LzXaKgJd+kKQWM9QL
         PuY1vmCRlFphxxGOVmsmXjDAAxVpu0s8tqBq+G7RJL0+y7BNDRdmLTJbMK79KXpS7NYU
         OiSRBeXR8I5JvHXkSw/ip59hd6PJF582HmAmGevqEL7v7r2YGWEk10yoJa+tj9cZtM9k
         yU6L4cy9XuFm9v1sUmm5cAFM7gIQKsWsuXaGSbMKSdGTaGrvmt+hevScxZYlGmDzUnmN
         YBRXUIaToccrc3NtdGVhuUhNquqOY1Ok8UQtvYQLPk8y/0xJ0tKKmEtWt+DThf7PAbeG
         nVxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVx7VDUswYo7vf5GMEha6huZXMW59wjBf9H7m3MBVC/X0cHrwhcSwquAXTDEVYpo++oXOV68U8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZYvVU+XiFyFh4xS7KQY5rMwXVWVRozuIqEqxyEwaazfudBkSO
	/EYQnVVipgAJUR+yCBiVMO1BjyAmf9yVqaiJAJbwPPz5WBeGfYqIcpIZPZblJMo=
X-Google-Smtp-Source: AGHT+IG2dPHDnsTK9NmP0VSAoPEMolEgwVq80QcHsxaDBbtih2FVohfyldaIM7Y5wPIrqGUshgyIbQ==
X-Received: by 2002:a5d:59a1:0:b0:367:9d05:cf1f with SMTP id ffacd0b85a97d-37d0e7374acmr2312722f8f.14.1728042448380;
        Fri, 04 Oct 2024 04:47:28 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f869a39adsm13960695e9.0.2024.10.04.04.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 04:47:26 -0700 (PDT)
Date: Fri, 4 Oct 2024 14:47:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lennart Franzen <lennart@lfdomain.com>,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: adi: adin1110: Fix some error
 handling path in adin1110_read_fifo()
Message-ID: <63dbd539-2f94-4b68-ab4e-c49e7b9d2ddd@stanley.mountain>
References: <8ff73b40f50d8fa994a454911b66adebce8da266.1727981562.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ff73b40f50d8fa994a454911b66adebce8da266.1727981562.git.christophe.jaillet@wanadoo.fr>

On Thu, Oct 03, 2024 at 08:53:15PM +0200, Christophe JAILLET wrote:
> If 'frame_size' is too small or if 'round_len' is an error code, it is
> likely that an error code should be returned to the caller.
> 
> Actually, 'ret' is likely to be 0, so if one of these sanity checks fails,
> 'success' is returned.
> 
> Return -EINVAL instead.
> 
> Fixes: bc93e19d088b ("net: ethernet: adi: Add ADIN1110 support")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is speculative.
> If returning 0 is what was intended, then an explicit 0 would be better.

I have an unpublished Smatch warning for these:

drivers/net/ethernet/adi/adin1110.c:321 adin1110_read_fifo() info: returning a literal zero is cleaner
drivers/net/ethernet/adi/adin1110.c:325 adin1110_read_fifo() info: returning a literal zero is cleaner

It's a pity that deliberately doing a "return ret;" when ret is zero is so
common.  Someone explained to me that it was "done deliberately to express that
we were propagating the success from frob_whatever()".  No no no!

I don't review these warnings unless I'm fixing a bug in the driver because
they're too common.  The only ones I review are:

	ret = frob();
	if (!ret)
		return ret;

Maybe 20% of the time those warnings indicate a reversed if statement.

Your heuristic here is very clever and I'll try steal it to create a new more
specific warning.

regards,
dan carpenter


