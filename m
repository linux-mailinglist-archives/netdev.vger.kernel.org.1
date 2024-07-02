Return-Path: <netdev+bounces-108551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 287F39242EB
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 17:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A4728B993
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 15:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8938C1BD036;
	Tue,  2 Jul 2024 15:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5Lmh2Hr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE791BD02F;
	Tue,  2 Jul 2024 15:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719935525; cv=none; b=XxhXwPbTqJummSbgNeqmJFylw43QZpcEXMRzqb3b78eTxr29PpYP4YTyDCo17sizG/VfxsTo58/8lTWAFM/p9bWOmX3yvXmg4AWmYtncqSWEhhc5BYQaE448vUBLfczML6XPmhouhQX4tf+nd9zseDspytia00y6Cfx6y/A2VIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719935525; c=relaxed/simple;
	bh=vULl7+VDZTZWO0p+Y1boRLwPrR9jVgPMSSnIuOzTPB4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WqxH1olueEZwn+WAWFKm7TDun/XEAzF7hIayRmqT/eepo2Svga3HBT08GxeQtAJRVWhrh2kehnbvW4Tilw1050fM5KRbi3u7KQ9DLAhxLAdbkSQv5EZfKb3sYKsCLdmh/UKu88P9TXkTOWWgCF68tqewJ2pR5WSppxr7k0WKT94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5Lmh2Hr; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-706b14044cbso3239416b3a.2;
        Tue, 02 Jul 2024 08:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719935523; x=1720540323; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xILFTgKGL//TlB4amQJt93ujxH7DLueHW296/2BvKz8=;
        b=A5Lmh2Hr3RViNSbfSZWmVaUvdjuUq3/LQ81CrBKdqUPAUZOefgL4jXSa47rLg+KcnL
         FE/QAQUOsH89XT54jIfwfR6dTEfOkO+oQWV5BqHIo4po+tzD02sXcHjmxVvyZVaa57Hf
         iDpdJNE9tBpVhx7eMrnrP5mu3fYi4u5pwDctH+lBf+aIvfscLDV54Q71Gj+oYpTf9bVd
         nAhKgos64x2M4kqb5KbkKO/Eo86ibt6l78G7FT8kBJHQJPb8y+3/SBG5VZEPB9fPblCE
         4eOStfp/C3ojAmUiQadKv4igLZZeh+r2cuH8Kq9O+cnPv5c7mWlPURfD7R0pfDyqDOA2
         Hd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719935523; x=1720540323;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xILFTgKGL//TlB4amQJt93ujxH7DLueHW296/2BvKz8=;
        b=Yva9a+4Bqh/2mENEy4etZ7YfUfZXYIEQ2XbrHeH4DplZR3glLDlWlxUTZ7r4tWKooi
         3y83HkJ8JDW095vozaTkMpMCIbXCuB3LiocX9otRTCTJ053Yk/bBUl/xS/rG5uI2hVV+
         HL0JiPAHrDalhsaPM8UvC3C0rkXAGefVaCa4SH4sgeffXXcs6BNdQdPeBzumoQj9Z1f/
         nmNo/gx+2KRl2J1/tACOxaIKM8+ctrUa2XosFpoaOUSMsOOEmTDRvCAMOeb8fdiR47yI
         76Igri6650lqJUVIJIbHwgyeFRHc9bHb2tb4+PiR2hewcDks6G+CJTQ/IbVqOgB0W3uM
         J45A==
X-Forwarded-Encrypted: i=1; AJvYcCXst92Pq2H7iVd8iO4Dh68qtTTePoFxNotYb7lxnEc+CsD9mUIkuYCVnYvNXBul8kD5vwpV8YqOWgaNienCR2deppSYG1FoLHGZeMHv
X-Gm-Message-State: AOJu0YyUIjjEvoF6BsJ96ktYM1O8o6sCtpl4qzSzmiDpRKJMRMMJ7gEF
	Nffmqs157dHw0VVPvOmTbKY1WbOAP63NN61SrvMVvbDAqY8ipVBs
X-Google-Smtp-Source: AGHT+IEomOF4JO97SvzdbYgAQYUWY+XqWoXXx/toNzx+tjD+VWggrPgp87K4ZyTjleam9otAPNdCTQ==
X-Received: by 2002:a05:6a00:b56:b0:705:9992:e7f2 with SMTP id d2e1a72fcca58-70aaad3bff4mr7473560b3a.12.1719935523304;
        Tue, 02 Jul 2024 08:52:03 -0700 (PDT)
Received: from [192.168.0.128] ([98.97.103.43])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-708045a69a6sm8668970b3a.165.2024.07.02.08.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 08:52:02 -0700 (PDT)
Message-ID: <16f0d900bff994c1e23fe3862c3953819bf6a63a.camel@gmail.com>
Subject: Re: [PATCH net-next v9 09/13] net: introduce the
 skb_copy_to_va_nocache() helper
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org,  pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Eric Dumazet
	 <edumazet@google.com>
Date: Tue, 02 Jul 2024 08:52:01 -0700
In-Reply-To: <20240625135216.47007-10-linyunsheng@huawei.com>
References: <20240625135216.47007-1-linyunsheng@huawei.com>
	 <20240625135216.47007-10-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-25 at 21:52 +0800, Yunsheng Lin wrote:
> introduce the skb_copy_to_va_nocache() helper to avoid
> calling virt_to_page() and skb_copy_to_page_nocache().
>=20
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  include/net/sock.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/include/net/sock.h b/include/net/sock.h
> index cce23ac4d514..7ad235465485 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2201,6 +2201,21 @@ static inline int skb_copy_to_page_nocache(struct =
sock *sk, struct iov_iter *fro
>  	return 0;
>  }
> =20
> +static inline int skb_copy_to_va_nocache(struct sock *sk, struct iov_ite=
r *from,
> +					 struct sk_buff *skb, char *va, int copy)
> +{
> +	int err;
> +
> +	err =3D skb_do_copy_data_nocache(sk, skb, from, va, copy, skb->len);
> +	if (err)
> +		return err;
> +
> +	skb_len_add(skb, copy);
> +	sk_wmem_queued_add(sk, copy);
> +	sk_mem_charge(sk, copy);
> +	return 0;
> +}
> +
>  /**
>   * sk_wmem_alloc_get - returns write allocations
>   * @sk: socket

One minor nit. Rather than duplicate skb_copy_to_page_nocache you would
be better served to implement this one before it, and then just update
skb_copy_to_page_nocache to be:
	return skb_copy_to_va_nocache(sk, from, skb,
				      page_address(page) + off, copy);

We can save ourselves at least a few lines of code that way and it
creates one spot to do any changes.
			=09

