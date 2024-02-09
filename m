Return-Path: <netdev+bounces-70502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B4184F4F6
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 13:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E0328AE7E
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 12:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C072D60A;
	Fri,  9 Feb 2024 12:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5PJSvLv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059863172D
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 12:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707480180; cv=none; b=pC8+Qq8Y9bLX4Cg5HPV68hkAKH3Bj3oRiqqHByNT7uMrCA9pVR9Jo7jFBB0+bt4N/5/Pbuo946aqg3V2TyVbd1dNP4kko0iNZiOvdxiCFtKdbTATeVB7u+e5wPHRd4RylNwxk8acZH8GkybdHxFqpssRME042iUcDFklNKb5TZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707480180; c=relaxed/simple;
	bh=1kbvjdOYixwkCjRJyf6X+v8tYL+XChUciWfcfN7hGIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdQg9Gb4xGUEc/xrFRjNWDIUII9rA5GnbRZ12+rfvB2D3691VWEn6EOqe5QnNmmWMYxEmFw/qGyYFkjgxcN7G/bwiYIjIx7iGZjs8noAvi3GE5h1pCIREYNCMGf1/nltlNSM40mhhLUaUxuPQdrW6K2amMlxNorxIBR3EMuX+dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h5PJSvLv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707480173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XjI39o/lRnBGO0+9xV+jFFlXMNGaX99Ut42wx/63C10=;
	b=h5PJSvLvNLBwkQmrTEmmeWySZPPKaCQsckAqtwu5R6/qzezUYzY/rDMF7qN53sPOGSGYWh
	wo8Vrl0S6rkyrg0xWsP+ALSGYrV9WTmGszQVGu8Qd5KZLiSgvJEohjw+9qmSswIITG7TM1
	p62NwteAlVwzy+jMlIBKZwJMy6jzluU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-SU_xomgxPECIKKGWgMFyhA-1; Fri, 09 Feb 2024 07:02:52 -0500
X-MC-Unique: SU_xomgxPECIKKGWgMFyhA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-68c4e69e121so11872486d6.2
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 04:02:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707480171; x=1708084971;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XjI39o/lRnBGO0+9xV+jFFlXMNGaX99Ut42wx/63C10=;
        b=bVybUo3D9xOShG4hJMkpxQyPn8N280WlY+tG+YJlTlVgtV/+0OsYTt12qepIecmcOu
         trypxvCKXePQO518zAuk+Th8bOeyvNPF5NKIVCIf+Px37kC5aSoarv6wTBEBQPxMcU1D
         9wKoW6ai/5YN7AVoBkWlHbEE4BxKLNXwyfHmrBo82x20XfJtuto6SnkJOuhKnVERPJyB
         pSbrDRU8O7cw33C8dUj4s/dFjmZEvS5I2RMt7ZrItwZZ/y8DQowiDvnaDqfVfyd3y1pB
         23QcXZogqvxjIIYP0gwYHsc/VbOr8mUopnE+11oyhYcm1YnPVZpOAxqPxiR0OMaxCnSk
         AWkg==
X-Gm-Message-State: AOJu0Yzs5wR6edUgs1zj1PT4jk+dXuZ1ee8bDRNGvIatT8vrPVNpW4pn
	FZstZcplQp11inHAOpMjvKRGGRgI9fwNafXqqmkX8YVtK6Q6BF60EsGVjDXPGudMyXhExv/LRyo
	nm4iVYjBakav9EnEqRwLolB6q1xYm6hGhT2Z7ghgcV5RlNJ2a4SwJ0k5R7oxtRvS7hP8fMRjXdd
	eDP1GJfOscmI0nk+09HH64RJYdCggZ9IJDFogI
X-Received: by 2002:ad4:5d6b:0:b0:68c:d9bf:1ebf with SMTP id fn11-20020ad45d6b000000b0068cd9bf1ebfmr482287qvb.6.1707480171195;
        Fri, 09 Feb 2024 04:02:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsd+kv/7TdHxvrTqBiJVXTDKVcXm2gg21TAPVIxpZV+qb7g1z8hin7mXDBLTkbNtrpxhxoQQ==
X-Received: by 2002:ad4:5d6b:0:b0:68c:d9bf:1ebf with SMTP id fn11-20020ad45d6b000000b0068cd9bf1ebfmr482261qvb.6.1707480170909;
        Fri, 09 Feb 2024 04:02:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWjEAZuRIVzw4kQXUHPoFv1I/LaKVJQxrZUP488xhMWo0tM4sl1HUF3uba0jlTKcE06OUvAWRsaFBNq5BuO4juYcrfWMcJXaSSai/64dsuJMs+TfphvgUzV0cZpTfnPPd0QxQ4xP1/kKIpm0Q==
Received: from localhost ([37.163.216.131])
        by smtp.gmail.com with ESMTPSA id lq3-20020a0562145b8300b0068cc0eba833sm758647qvb.22.2024.02.09.04.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 04:02:50 -0800 (PST)
Date: Fri, 9 Feb 2024 13:02:43 +0100
From: Andrea Claudi <aclaudi@redhat.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org, dsahern@gmail.com, sgallagh@redhat.com,
	Nogah Frankel <nogahf@mellanox.com>
Subject: Re: [PATCH] iproute2: fix build failure on ppc64le
Message-ID: <ZcYUY9ZFYE7FQTnH@renaissance-vector>
References: <d13ef7c00b60a50a5e8ddbb7ff138399689d3483.1707474099.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d13ef7c00b60a50a5e8ddbb7ff138399689d3483.1707474099.git.aclaudi@redhat.com>

On Fri, Feb 09, 2024 at 11:24:47AM +0100, Andrea Claudi wrote:
> ppc64le build fails with error on ifstat.c when
> -Wincompatible-pointer-types is enabled:
> 
> ifstat.c: In function ‘dump_raw_db’:
> ifstat.c:323:44: error: initialization of ‘long long unsigned int *’ from incompatible pointer type ‘__u64 *’ {aka ‘long unsigned int *’} [-Wincompatible-pointer-types]
>   323 |                 unsigned long long *vals = n->val;
> 
> Several other warnings are produced when -Wformat= is set, for example:
> 
> ss.c:3244:34: warning: format ‘%llu’ expects argument of type ‘long long unsigned int’, but argument 2 has type ‘__u64’ {aka ‘long unsigned int’} [-Wformat=]
>  3244 |                 out(" rcv_nxt:%llu", s->mptcpi_rcv_nxt);
>       |                               ~~~^   ~~~~~~~~~~~~~~~~~
>       |                                  |    |
>       |                                  |    __u64 {aka long unsigned int}
>       |                                  long long unsigned int
>       |                               %lu
> 
> This happens because __u64 is defined as long unsigned on ppc64le.  As
> pointed out by Florian Weimar, we should use -D__SANE_USERSPACE_TYPES__
> if we really want to use long long unsigned in iproute2.
> 
> This fix the build failure and all the warnings without any change on
> the code itself.
> 
> Suggested-by: Florian Weimer <fweimer@redhat.com>
> Signed-off-by: Andrea Claudi <aclaudi@redhat.com>

Sorry, I forgot to add:
Fixes: 5a52102b7c8f ("ifstat: Add extended statistics to ifstat")

even after I recommended it to Stephen G... Seems I need more coffee
today :)

> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 8024d45e..3b9daede 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -60,7 +60,7 @@ CC := gcc
>  HOSTCC ?= $(CC)
>  DEFINES += -D_GNU_SOURCE
>  # Turn on transparent support for LFS
> -DEFINES += -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE
> +DEFINES += -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D__SANE_USERSPACE_TYPES__
>  CCOPTS = -O2 -pipe
>  WFLAGS := -Wall -Wstrict-prototypes  -Wmissing-prototypes
>  WFLAGS += -Wmissing-declarations -Wold-style-definition -Wformat=2
> -- 
> 2.43.0
> 


