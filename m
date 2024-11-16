Return-Path: <netdev+bounces-145525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8D39CFBAA
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 01:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75C6DB220E7
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 00:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DBA184E;
	Sat, 16 Nov 2024 00:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDqPuwr8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAFB2107
	for <netdev@vger.kernel.org>; Sat, 16 Nov 2024 00:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731716878; cv=none; b=Ra2zby2dB8vQPqOBajxAfsuDTBtMrDjvfxRUwBnAFcB4J/O/NpoLMoOwVlVtf+tHvY/0yBmMGaFkA9/RRt04l7FaO7nM3kArFY7qU5Ueav+l/3fz20vp4gxvBDVrzy/xOJY5s0VUBxA0Dd/LpoRon+c/j5yYleic36Wes9nw3TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731716878; c=relaxed/simple;
	bh=TEfpsCgWAPqhTXcm9+LAHXSp/9pAygH7JTOrsaeHOHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLJ2crOqily68aFfCRGbUIiVINViY5RrMPEa8bdGHYN3jP34KQfn4POhhTC47OuDngacXynOTDXzNct1/uj2toTV2uAb8Tne1e9fsz/9hs5mNxleK/vnaZ+r6M24TJToe9uyNych2bk+f2oTVZoCzKhgU49zoLlgANd6iDRG8lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDqPuwr8; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-210e5369b7dso1020795ad.3
        for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 16:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731716877; x=1732321677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cfz1PP4vvhwJrftqDgrvZgICg6QnbAezPbNn0NHib+k=;
        b=EDqPuwr8LI1cOjwXdPIxnN5V8jHSQGPxEv2PnjGOMk7ROLTQKop3Jl8SO4bcGLUF3a
         GSW8vDdtOs7Mg3jfiDSJky/c3yW4cdGNiakMdtoLfUCW2KPGev2/uodYaURl9jNAuy1L
         SeYhFChzCuSP2KkOggDM3YcTMVbBNyThTflZO6K8mv08FBB9rJFz7WwUJ7BQoOH6+70p
         ecDPVpk8xwLT1oXDOwl6I+wb/KZcCihWj+2r3q+09p/9X2XBbflxeas6q65TThpM1YJK
         /dc4mDv4nC8SAco+PZLKN+nbCVVWyoUwI8JNYOmL2M42e+I6bdoIMPGf2oM60kYLx/KG
         XFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731716877; x=1732321677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfz1PP4vvhwJrftqDgrvZgICg6QnbAezPbNn0NHib+k=;
        b=oodGlgwdb8HiZxmqh8IqaIVTwvYVs4xduPkrchkI8R9ZJ7W4Qs9Q/gjCIdII3z6ga9
         lixLv2aT1hzfAkWBwamyYdNONcAQB0aWCaOstdpTdH97URIiU/M4tR9krxVjMf/OgFKH
         MdazfQpUMnWqysxPjzXTV5PhuNQjB5nEoZt1QjxjvhtO+hfLyN4JKdI1pNocbcabh2vU
         4lKinVypczZhmeKKKxByLUA12nBp8hUFWuHwPKk8eTJSjrbDDp7y8PRGNNE6Lb4xWDRO
         vZ9vxTAyxB0pdcUoEA1FrZ0G6es1bhjtuyFyLI7Qpiu8BnoIMTLKGOP4yIByaHs4gEAN
         Oxvg==
X-Forwarded-Encrypted: i=1; AJvYcCUhjiFL45NFnn7S1auCU8dqKgMRnbb+XbAC3vpAQQOZnxYru5P4pZGlqWUdpz7oG6rQZvTa5cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFVrm7S6u0Xvnjz9auNo8de1fC4K8cqmONyExY4EFrGCdsLQHU
	G+0F+n5P+xQgJHtKb94TkiOFeQPdFNuKbIqnRE4ePqSGKUWTzso=
X-Google-Smtp-Source: AGHT+IHNmgU3aEjgaWpV22IFo/npAW2aMavaq/2Xdw1Q4JyDQI/aKWzOcrsS3wGNliKpV17R07sfHQ==
X-Received: by 2002:a17:902:ce8e:b0:20c:8763:b3f7 with SMTP id d9443c01a7336-211d0d721aamr44826255ad.17.1731716876744;
        Fri, 15 Nov 2024 16:27:56 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f55553sm18194745ad.261.2024.11.15.16.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 16:27:56 -0800 (PST)
Date: Fri, 15 Nov 2024 16:27:55 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net-next] selftests: net: add more info to error in
 bpf_offload
Message-ID: <ZzfnCwZ5GeTdOnt0@mini-arch>
References: <20241115201236.1011137-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241115201236.1011137-1-kuba@kernel.org>

On 11/15, Jakub Kicinski wrote:
> bpf_offload caught a spurious warning in TC recently, but the error
> message did not provide enough information to know what the problem
> is:
> 
>   FAIL: Found 'netdevsim' in command output, leaky extack?
> 
> Add the extack to the output:
> 
>   FAIL: Unexpected command output, leaky extack? ('netdevsim', 'Warning: Filter with specified priority/protocol not found.')
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

