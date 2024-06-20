Return-Path: <netdev+bounces-105465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FBF91140A
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 23:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A82E3B2123B
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 21:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F54577116;
	Thu, 20 Jun 2024 21:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IOll1FDb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA24757F6
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 21:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718917531; cv=none; b=tAI5H0LL+TxkbIj19hF0d4BSI1qrwoAlSYZMYiC67oP+65DoHapw394m8yeZr6nyIu0MvQtRN3cLgnYfxMPPsRjRMNDZWaW4aqsrtCI8loMAI+J/4+clc/U5hWp6lcwVEuMZvZeCAa6YH2PyqxxLCZnAU8AtM8zZ5xQlC3svEC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718917531; c=relaxed/simple;
	bh=mg+X7y4AeKUnrgakVmUQbP1hixJ/v7TNpOM2HJ3IhXg=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Subject:References:In-Reply-To; b=POxpvW3oAGjqZxdonBupKmL+8MuOdjAmXrLoj/VVcOhUEj4bVh4eFVRn1ua5qCyiNlV4tn/ut3ECvvn3c3GJI3d6/PkfScqYPOJhWnTZuBZrj9IGzl8kG+MB/LrEwToGr6A08PGZ5v0tPjCYja57IswjUSufNvv3e17C8HCYmsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IOll1FDb; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-44490c66b0eso6054961cf.2
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 14:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718917528; x=1719522328; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nsfCpB+dAhdiD/N3v6ggI+eNymd+g4KZSDaOf75av9o=;
        b=IOll1FDbw7zhvPiy3k1IL6zDcVI9INl844dOa/XeeuD/xRRZ1V52i1fSo5KtqsO5RQ
         kcf9tYTc1dpmp6OyCpPcv01UQZVVLEBfL+Pk5BzQoa9fYMfcV0jhjQGvUGwMXkkiBvEX
         lINxdgAqMyGG52lIQ5joKUbGbcMO5PKgMHLQ0vkAzCjIej0Q1bRwoQ9KHJwuR7aklSrK
         R5yBSecN8kKpY2zIcO2TC8rzo3806a0K8Am4QkbkTovRm96PRzeH9BR5F7xqS2BLbD1K
         5C5nbmIUOnO7DW3BjW2yu76hsn/gtvXDd+xIFpohScasZ4Gk7u7G9rTfl4GHknMt7Qhv
         MExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718917528; x=1719522328;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nsfCpB+dAhdiD/N3v6ggI+eNymd+g4KZSDaOf75av9o=;
        b=Et+Ac9SNhZBtw6fK8KTExda0FaAFKluHQzPm2MsE+0RHBnXjLNGyD4SB6zHGLFc7ZV
         KdHQtT+tlypBwTCYS0LLJwAzbcOnQjXklti//NWJH4hId/d1NyVx3l4+g/Ly4cKdGHJb
         vbt/17YPHPJWE1xJcqhHaxBZvigTZAA9+6/7+JghH3m1Rk+tySt/VSFtwofG33bB2dE+
         bNsGcpEXeBvRB+4uO2RiSC076kwBd110f1nDd+CDjjQ9dlRbsXJ5r190Cr57twNDH1XM
         IJZKMVVhVdQQuRPmC5+qIo4jHlNRBVFy7X3KnqLvN25Hy5J5HGlsnxYBcV4Skui3tgHK
         accQ==
X-Forwarded-Encrypted: i=1; AJvYcCX22ta5JYdAlyKef70ZbZ0nLxMqXE8EWrS5alk1Fvm/nJ02tjDWf9jyx6D55MmNTyj5evbsP7Acd8utBCmqaipNl27kA/jS
X-Gm-Message-State: AOJu0YyJqJoYufO6iZdx56RqDqxZrATfF928KlqO51QTWqpVl32WX1lb
	V6wGmH/klvvmwthao5XZv0T9G8hnV5qmZ9mi4QptkG8xTHStWy8++JrRdSd4Iw==
X-Google-Smtp-Source: AGHT+IEg/efvOeBU00ll/tsNr2NMecKZloltnZsQEGNrcMSYAsM9HZzR1J3C3pxMop0HsequrRDhrA==
X-Received: by 2002:a0c:f7c2:0:b0:6b4:f7bc:6e3 with SMTP id 6a1803df08f44-6b501e20b8bmr66532976d6.23.1718917527920;
        Thu, 20 Jun 2024 14:05:27 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef67c12sm111026d6.126.2024.06.20.14.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 14:05:27 -0700 (PDT)
Date: Thu, 20 Jun 2024 17:05:27 -0400
Message-ID: <83ef6981a29c441b58b525e9292c866a@paul-moore.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, LSM List <linux-security-module@vger.kernel.org>, netdev@vger.kernel.org, linux-api@vger.kernel.org, Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] LSM, net: Add SO_PEERCONTEXT for peer LSM data
References: <763db426-6f60-4d36-b3f9-b316008889f7@schaufler-ca.com>
In-Reply-To: <763db426-6f60-4d36-b3f9-b316008889f7@schaufler-ca.com>

On May 13, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> We recently introduced system calls to access process attributes that
> are used by Linux Security Modules (LSM). An important aspect of these
> system calls is that they provide the LSM attribute data in a format
> that identifies the LSM to which the data applies. Another aspect is that
> it can be used to provide multiple instances of the attribute for the
> case where more than one LSM supplies the attribute.
> 
> We wish to take advantage of this format for data about network peers.
> The existing mechanism, SO_PEERSEC, provides peer security data as a
> text string. This is sufficient when the LSM providing the information
> is known by the user of SO_PEERSEC, and there is only one LSM providing
> the information. It fails, however, if the user does not know which
> LSM is providing the information.
> 
> Discussions about extending SO_PEERSEC to accomodate either the new

Spelling nitpick -> "accommodate" :)

> format or some other encoding scheme invariably lead to the conclusion
> that doing so would lead to tears. Hence, we introduce SO_PEERCONTEXT
> which uses the same API data as the LSM system calls.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  arch/alpha/include/uapi/asm/socket.h  |  1 +
>  arch/mips/include/uapi/asm/socket.h   |  1 +
>  arch/parisc/include/uapi/asm/socket.h |  1 +
>  arch/sparc/include/uapi/asm/socket.h  |  1 +
>  include/linux/lsm_hook_defs.h         |  2 +
>  include/linux/security.h              | 18 ++++++++
>  include/uapi/asm-generic/socket.h     |  1 +
>  net/core/sock.c                       |  4 ++
>  security/apparmor/lsm.c               | 39 ++++++++++++++++
>  security/security.c                   | 86 +++++++++++++++++++++++++++++++++++
>  security/selinux/hooks.c              | 35 ++++++++++++++
>  security/smack/smack_lsm.c            | 25 ++++++++++
>  12 files changed, 214 insertions(+)

...

> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
> index 8ce8a39a1e5f..e0166ff53670 100644
> --- a/include/uapi/asm-generic/socket.h
> +++ b/include/uapi/asm-generic/socket.h
> @@ -134,6 +134,7 @@
>  
>  #define SO_PASSPIDFD		76
>  #define SO_PEERPIDFD		77
> +#define SO_PEERCONTEXT		78

Bikeshed time ... how about SO_PEERLSMCTX since we are returning a
lsm_ctx struct?

> diff --git a/security/security.c b/security/security.c
> index e387614cb054..fd4919c28e8f 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -874,6 +874,64 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u32 *uctx_len,
>  	return rc;
>  }
>  
> +/**
> + * lsm_fill_socket_ctx - Fill a socket lsm_ctx structure
> + * @optval: a socket LSM context to be filled
> + * @optlen: uctx size

"@optlen: @optval size"

> + * @val: the new LSM context value
> + * @val_len: the size of the new LSM context value
> + * @id: LSM id
> + * @flags: LSM defined flags
> + *
> + * Fill all of the fields in a lsm_ctx structure.  If @optval is NULL
> + * simply calculate the required size to output via @optlen and return
> + * success.
> + *
> + * Returns 0 on success, -E2BIG if userspace buffer is not large enough,
> + * -EFAULT on a copyout error, -ENOMEM if memory can't be allocated.
> + */
> +int lsm_fill_socket_ctx(sockptr_t optval, sockptr_t optlen, void *val,
> +			size_t val_len, u64 id, u64 flags)
> +{
> +	struct lsm_ctx *nctx = NULL;
> +	unsigned int nctx_len;
> +	int loptlen;

u32?

> +	int rc = 0;
> +
> +	if (copy_from_sockptr(&loptlen, optlen, sizeof(int)))
> +		return -EFAULT;

It seems the current guidance prefers copy_safe_from_sockptr(), see
the note in include/linux/sockptr.h. 

> +	nctx_len = ALIGN(struct_size(nctx, ctx, val_len), sizeof(void *));
> +	if (nctx_len > loptlen && !sockptr_is_null(optval))
> +		rc = -E2BIG;

Why do we care if @optval is NULL or not?  We are in a -E2BIG state,
we're not copying anything into @optval anyway.  In fact, why are we
doing the @rc check below?  Do it here like we do in lsm_fill_user_ctx().

  if (nctx_len > loptlen) {
    rc = -E2BIG;
    goto out;
  }

> +	/* no buffer - return success/0 and set @uctx_len to the req size */

"... set @opt_len ... "

> +	if (sockptr_is_null(optval) || rc)
> +		goto out;

Do the @rc check above, not here.

> +	nctx = kzalloc(nctx_len, GFP_KERNEL);
> +	if (!nctx) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}
> +	nctx->id = id;
> +	nctx->flags = flags;
> +	nctx->len = nctx_len;
> +	nctx->ctx_len = val_len;
> +	memcpy(nctx->ctx, val, val_len);
> +
> +	if (copy_to_sockptr(optval, nctx, nctx_len))
> +		rc = -EFAULT;

This is always going to copy to the start of @optval which means we
are going to keep overwriting previous values in the multi-LSM case.
I think we likely want copy_to_sockptr_offset(), or similar.  See my
comment in security_socket_getpeerctx_stream().

> +	kfree(nctx);
> +out:
> +	if (copy_to_sockptr(optlen, &nctx_len, sizeof(int)))
> +		rc = -EFAULT;
> +
> +	return rc;
> +}
> +
> +
>  /*
>   * The default value of the LSM hook is defined in linux/lsm_hook_defs.h and
>   * can be accessed with:
> @@ -4743,6 +4801,34 @@ int security_socket_getpeersec_stream(struct socket *sock, sockptr_t optval,
>  	return LSM_RET_DEFAULT(socket_getpeersec_stream);
>  }
>  
> +/**
> + * security_socket_getpeerctx_stream() - Get the remote peer label
> + * @sock: socket
> + * @optval: destination buffer
> + * @optlen: size of peer label copied into the buffer
> + * @len: maximum size of the destination buffer
> + *
> + * This hook allows the security module to provide peer socket security state
> + * for unix or connected tcp sockets to userspace via getsockopt
> + * SO_GETPEERCONTEXT.  For tcp sockets this can be meaningful if the socket
> + * is associated with an ipsec SA.
> + *
> + * Return: Returns 0 if all is well, otherwise, typical getsockopt return
> + *         values.
> + */
> +int security_socket_getpeerctx_stream(struct socket *sock, sockptr_t optval,
> +				      sockptr_t optlen, unsigned int len)
> +{
> +	struct security_hook_list *hp;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeerctx_stream,
> +			     list)
> +		return hp->hook.socket_getpeerctx_stream(sock, optval, optlen,
> +							 len);
> +
> +	return LSM_RET_DEFAULT(socket_getpeerctx_stream);
> +}

Don't we need the same magic that we have in security_getselfattr() to
handle the multi-LSM case?

--
paul-moore.com

