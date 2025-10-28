Return-Path: <netdev+bounces-233619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B04D4C16686
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 19:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C3B91355D59
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 18:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F28734DCF2;
	Tue, 28 Oct 2025 18:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D28n7aGc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC6F26F463
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 18:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761675078; cv=none; b=Vz0zIwtt5GHpUEKp6nol0e8UgN+7M2aS3Qc6QZc6Sn4XfVJumLvYWH7FkszCnYbXqDslS+VTPATAdDb2nRTdWOR55MSo0+zoFX8TNdG2nXtnwCliRL2mJ6zITESiAEduWslk9ARhjahuCONHhdcLhhyNbqSEO9Ob0emMg5gtYlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761675078; c=relaxed/simple;
	bh=7ouSrBbsVR6wmYoCYKp8aKe/DXCP/3NzOs3APys0qIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMHpZzhqWvypRVBFbv3LzM+gw3u7M7OLCQpRzj8i5rHUsYIZfdeTpX245vHEIKMzWBN2aah6Kpexuru0hyLlD43hhnBTjgktbJCDgIyz4GxbRoaCSttM5rDhDrrYUYd6+YOgIy4tZkt0HOgTCvAkwEsHFZT+bdrRRydp/l1/nik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D28n7aGc; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-785bf425f96so2493957b3.1
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 11:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761675075; x=1762279875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wCiNsir32PW/HIp2NEQNkgXf2Mm/YDag+GvhIjU+Dfk=;
        b=D28n7aGc5XPqqCZSMjFmiTkoa6GUksL6zzlo2L0xVccZtvi9QvJuc2a/hyWx3N4vvR
         KGwuTssX6/pVK/phVJZc6kxmFKT6lspuCE31w9rNpCYuYZ1AZ798sZECBHZRMuz2VrEb
         i9fz1npr+v83dIjgrYpwZI4E/1MHEe3IRdJVtXKkbWrHz/8ygtodXjgYLbzIe2xV3WLn
         sAdsh2gi+/i4c7TfqVT5GNWTSJW5s1BFEhRWxpk3DABrmQ6CrucO5kxC2HDopI4ZBWFV
         ZWiEw7Vwg/dflKmP2ig/A28jfTxe2rqYcTRwTXpQRJECJVnPAFCbQ+m0eAHj1A5VF3Kz
         D7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761675075; x=1762279875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCiNsir32PW/HIp2NEQNkgXf2Mm/YDag+GvhIjU+Dfk=;
        b=uFfTFB6HajxXABS4RV2NnxQfhDFdHSh5Y+rJkNMRASpfTrjmrywarvYzrIGrUFvBEn
         GdgozLgbCW9x27j1zQYD0VOj4smLSgRRnTo8hN3FQVq9+2dxSs2lIgcU6Uf7JbrXcmZw
         pycneLDedyXNU61Dq0Zi1wQMQOanGZ5lHzpuWki0ZpO5MITC2NRztg3e+Y7cn5xTtRZG
         ZUa9SCFilPb3max4AySw2FjKy4zuNGxU+tgOK+ldUvLQnvg1pYoKkRNY6wOZTT34KSoP
         V2QrkTVEtj46cO0K3B4+5KdgnjJO8pt4sMPI+4hW+m5hOo3FyRBV55qgisLgdPMCqoxK
         eTZA==
X-Gm-Message-State: AOJu0Yy8EHhj5OyG+YuvrJH2e4VdsL9yTfq4gl4sUV1VQQcvW2fHrWl3
	K6sWuvZXDsMaYIhjhU9vyQ7Co4an5Qb64qMhkzctDRF2O7NEPJzXHbVq
X-Gm-Gg: ASbGncvvlaKwOIk65nY+cJzWrK6Laj6r7fN6n7kKxIHTmjbZh7y9De2LUDVsmRdFGWI
	m4f1isJj0pGmuOGzUAprUlivyhWX7NcJk4/lgEGLWnKFnG8st0KzdW/IuYBHiouyjRp1OeKk8ct
	RcqZ3h2sJadqKzAyKOtAIpTGSv1kbKxVcvQHyJQJIOFFWtTT/W5RIJBMYsB5kxeD0M2/RNzjhVr
	HRqV6XQSkpac8oGnkzSXYQtZDQ503rZydiXEoeKgcBUGsEjCpOwVbxn6EGPm1VOiQCHDN2kKPSI
	jSk/ucXxCNdnbh3/vDteBTJlW3dhMzppOPLfYcISLVmvrqNiij5QqIAzemmqNHoMx9AYOo07JcR
	GKB2UTKBj1eAtJ/OYvJ8vHhjYYVq6nkU/r1mgst9m9xsJPguZvlFZ2BlPCBW/K0qQD4QRmIMH2r
	MDeEBVDENedkV2Nc+Hhd2GqjquI9GnbUJYEtN6
X-Google-Smtp-Source: AGHT+IE7Dpx53kWnxwpoF0nTbmlUJ7yi1+PNjMO1y1Okj+sbU+yBkzDzTC2VDr3Kw5zMaWIpalgNVg==
X-Received: by 2002:a05:690e:d0f:b0:63c:f5a6:f2d3 with SMTP id 956f58d0204a3-63f7737c399mr150070d50.34.1761675075435;
        Tue, 28 Oct 2025 11:11:15 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:52::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed1b24e7sm29095397b3.35.2025.10.28.11.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 11:11:14 -0700 (PDT)
Date: Tue, 28 Oct 2025 11:11:13 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Shivaji Kant <shivajikant@google.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Pranjal Shrivastava <praan@google.com>,
	Vedant Mathur <vedantmathur@google.com>
Subject: Re: [PATCH] net: devmem: Remove dst (ENODEV) check in
 net_devmem_get_binding
Message-ID: <aQEHQReSmbXeIw15@devvm11784.nha0.facebook.com>
References: <20251028060714.2970818-1-shivajikant@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028060714.2970818-1-shivajikant@google.com>

On Tue, Oct 28, 2025 at 06:07:14AM +0000, Shivaji Kant wrote:
> The Devmem TX binding lookup function, performs a strict
> check against the socket's destination cache (`dst`) to
> ensure the bound `dmabuf_id` corresponds to the correct
> network device (`dst->dev->ifindex == binding->dev->ifindex`).
> 
> However, this check incorrectly fails and returns `-ENODEV`
> if the socket's route cache entry (`dst`) is merely missing
> or expired (`dst == NULL`). This scenario is observed during
> network events, such as when flow steering rules are deleted,
> leading to a temporary route cache invalidation.
> 
> The parent caller, `tcp_sendmsg_locked()`, is already
> responsible for acquiring or validating the route (`dst_entry`).
> If `dst` is `NULL`, `tcp_sendmsg_locked()` will correctly
> derive the route before transmission.
> 
> This patch removes the `dst` validation from
> `net_devmem_get_binding()`. The function now only validates
> the existence of the binding and its TX vector, relying on the
> calling context for device/route correctness. This allows
> temporary route cache misses to be handled gracefully by the
> TCP/IP stack without ENODEV error on the Devmem TX path.
> 
> Reported-by: Eric Dumazet <edumazet@google.com>
> Reported-by: Vedant Mathur <vedantmathur@google.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Fixes: bd61848900bf ("net: devmem: Implement TX path")
> Signed-off-by: Shivaji Kant <shivajikant@google.com>
> ---
>  net/core/devmem.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index d9de31a6cc7f..1d04754bc756 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -17,6 +17,7 @@
>  #include <net/page_pool/helpers.h>
>  #include <net/page_pool/memory_provider.h>
>  #include <net/sock.h>
> +#include <net/tcp.h>
>  #include <trace/events/page_pool.h>
>  
>  #include "devmem.h"
> @@ -357,7 +358,8 @@ struct net_devmem_dmabuf_binding *net_devmem_get_binding(struct sock *sk,
>  							 unsigned int dmabuf_id)
>  {
>  	struct net_devmem_dmabuf_binding *binding;
> -	struct dst_entry *dst = __sk_dst_get(sk);
> +	struct net_device *dst_dev;
> +	struct dst_entry *dst;
>  	int err = 0;
>  
>  	binding = net_devmem_lookup_dmabuf(dmabuf_id);
> @@ -366,16 +368,35 @@ struct net_devmem_dmabuf_binding *net_devmem_get_binding(struct sock *sk,
>  		goto out_err;
>  	}
>  
> +	rcu_read_lock();
> +	dst = __sk_dst_get(sk);
> +	/* If dst is NULL (route expired), attempt to rebuild it. */
> +	if (unlikely(!dst)) {
> +		if (inet_csk(sk)->icsk_af_ops->rebuild_header(sk)) {
> +			err = -EHOSTUNREACH;
> +			goto out_unlock;
> +		}

Echoing your discussion with Eric, I think the message might want to
call out this part. Besides that, all looks good!

Pending that nit:

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

Best,
Bobby

