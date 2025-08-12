Return-Path: <netdev+bounces-213056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE951B230F3
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 19:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D7831896CD4
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CC12FE56A;
	Tue, 12 Aug 2025 17:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="uDK9qv6e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDED02FAC14
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021481; cv=none; b=XYlf+7wd8QhJaV766NADk41SbdxHHyNhmoKVjaL+t5FRoJVAEyyAOzBNdzS96GPm5P8praD61QMXeOXtqQGhGrWsX4H2eXg4IOg6g0BlErtNHt5NgqfGz8jF69CJt8eE+NRvZ6bqquLw3THsHsRCoUuSmVVEQbTPGQQEEYUKb2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021481; c=relaxed/simple;
	bh=hPrGuxrOLQ9ipBeDFWhoJK1vM+KGW1+i9S6rdpPe8xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhvF3Qz+uRcyd6g8OB6ygJTMS59as94pxLILIHOnjAbLC0UwFakpNYeteRyvWyTXBizF4GIwp1T3biGg524syRmPNfbmsAQJ4ue08To+gnge8rWrN1aysnRsxMvBro5SuZobKVTdt/OXBKBMu8IapJNpMHzovIwChI/ZbZyPnRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=uDK9qv6e; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76a3818eb9bso5403311b3a.3
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 10:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1755021478; x=1755626278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qc+A4jnBK4EPdKh66angrNfmE3qm0EXV6FaKJ1CugA4=;
        b=uDK9qv6eTp2PMd3L4a8hShsQcjDB5jf48FIhmNfWH2VcfmiteLxvDDlGaLdwujL5D9
         lHNURWLvSFtiaBpw/FL2Js9X7ifwtQQeSvS+DyF63YdqEH7EcBZmOIGjh1WXRsqfubqJ
         g/L1LzJ0Ub5shHfn8f1IlHGjlE+ja+bc++unIogu9YN9F+4Ig9vrIOX9pN+ofxd+f3Gw
         QIHvTWG25ZxIDouRkxvn+6YYlmhBVXT2XrQthUuT8JUhKS/oDbtCM3e0lxa2gKEoKq/7
         SOAwT9+yY57Jqg0t3NMnCMJJn60oqoppI4DjRVwiLT62c8lhBA1A6+2Ebh3n8jvZDRXE
         zm7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021478; x=1755626278;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qc+A4jnBK4EPdKh66angrNfmE3qm0EXV6FaKJ1CugA4=;
        b=Fd6j7dKbcNATPJxJ83Rb2BiHecRQSCDF9Xt6LhYngz3Zi22Ga+hhXXxNkFlWqg/RMe
         7ieEiB8KTwxPcgxk6T0hbJqFzPHzdnFAXW6OZJ8Va4Bn4FeYHkGa5NhNL7GXhHHrs+oQ
         oJxgr+aIPK/zWflvOXRXsulxlWQL6dOyKXkjPuCytT/Ie5/pluxWxKjZ6Q2SkOxKmSWO
         LplDDwxMv2q4/dYlnBVg3TrMAjnTH7mL55ExGnPPvSbtuGcG7CAUWkvNqrxARfmupvDC
         xcZs7TvModM9Sdg+cfP45cU7y0N3vJUljteMqIU/wuxnWDGXM48HJMngUBs3MNT7aaPs
         7hLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbpVxApiZyGuddZ9ALwhAhlIJEbRq+07mKuJC56yupMV7BP1zG7eIiNYrQKnI3fa2tlC7qP4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv8rO5IxrbPkEUdhkDy9CePubl5PDqEqT5LvJ334Bp/IQJ+wE5
	ggaOIi5y/KdHB3FbcqpZQPZvwzsvRhv0ZUDRtF4ApkBf7XxQ8aYS7hUz9jaHQlLJy+A=
X-Gm-Gg: ASbGnct3tXAm/iLgQPkzvZz+0b/d6J0NwfVZJ25XfoM1UEQMGSzZ9QWNHJFAuGPLTwY
	qW+qGYcrjNx8zvsJG+QmHlAuaUaIwoVK3YM6SrDLV9Bv8XwZDt6ZSBwCD9g8RBM+2+erxVnQiyp
	UlffX9p8LaUfOBKMtq4CQ+dV62rCZRC6h2S13KOc84ZaV5TbYL6rvO8Wlf8C3Y0jjByzoKgCbzy
	13Vq7KhIJqhrlYZv8/5ufhvHhb2QhG9gjT9CFSs/IMCK2c2x50LgiXMOHJA125ndx7brZDmAycu
	e8T/Xq0cvwBNgjdpkqchtaP4uMWNuL6AEEo2CElbTWeEP7lmvhJ0sU7ZuDhVzKQ4/kUkx8XR9Wb
	07gAU6Q6I40qZDzH75erNdL6pKpQXNiNkWYwWmRgqsFeBjZdOgtJkKzQbm/F71l0s99ea8XS2PI
	FjSBTqJic=
X-Google-Smtp-Source: AGHT+IHxi2HOW8bSGkAzQGQAd8ZqXnSd+5ht/WWbBZm7UBPBn7pRtc+d0H/ulq4tQ+TrYx/lPWqfGA==
X-Received: by 2002:a05:6a00:b55:b0:748:fe3a:49f2 with SMTP id d2e1a72fcca58-76e20f900d8mr126425b3a.21.1755021478408;
        Tue, 12 Aug 2025 10:57:58 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfcf523sm29950265b3a.90.2025.08.12.10.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 10:57:58 -0700 (PDT)
Date: Tue, 12 Aug 2025 10:57:55 -0700
From: Joe Damato <joe@dama.to>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: trondmy@kernel.org, anna@kernel.org, chuck.lever@oracle.com,
	jlayton@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, neil@brown.name,
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
	horms@kernel.org, linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sunrpc: fix "occurence"->"occurrence"
Message-ID: <aJuAo3lfY9lRB-Oo@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Xichao Zhao <zhao.xichao@vivo.com>, trondmy@kernel.org,
	anna@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, neil@brown.name, okorniev@redhat.com,
	Dai.Ngo@oracle.com, tom@talpey.com, horms@kernel.org,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20250812113359.178412-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812113359.178412-1-zhao.xichao@vivo.com>

On Tue, Aug 12, 2025 at 07:33:59PM +0800, Xichao Zhao wrote:
> Trivial fix to spelling mistake in comment text.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  net/sunrpc/sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
> index 09434e1143c5..8b01b7ae2690 100644
> --- a/net/sunrpc/sysfs.c
> +++ b/net/sunrpc/sysfs.c
> @@ -389,7 +389,7 @@ static ssize_t rpc_sysfs_xprt_dstaddr_store(struct kobject *kobj,
>  	saddr = (struct sockaddr *)&xprt->addr;
>  	port = rpc_get_port(saddr);
>  
> -	/* buf_len is the len until the first occurence of either
> +	/* buf_len is the len until the first occurrence of either
>  	 * '\n' or '\0'
>  	 */
>  	buf_len = strcspn(buf, "\n");

In the future probably a good idea to add net-next to the subject line so it
is clear which tree you are targeting (e.g. [PATCH net-next]).

Reviewed-by: Joe Damato <joe@dama.to>

