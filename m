Return-Path: <netdev+bounces-96387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DE98C58FA
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 17:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B92A1F22F75
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 15:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238B217EB87;
	Tue, 14 May 2024 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="nhWOf3hZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FF41E480
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715701420; cv=none; b=a9s5X1Zd4tiqbppAtBRS0pGwdK/81De5iSTNuUGVUh0KGSmR6ZRZdrCFj89DsUPKMBeiKO1pFxBimD+acOFVFzfbNhpE6flSSstdIdKjuvRWIzgbJgg4ywPeg1pH1e8lwh2H3bqMAFfmSBXR3i84Do22eO/uEibujk0lWQj3f1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715701420; c=relaxed/simple;
	bh=bqZtTfqPK7ohbPAafUNheKg9VbnYE8/HuBdNNZX68Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CVT2NTTdQhNfEnmJw7KiCzwmrHhWxA4CUcp8LlOfNviI78SMp+lY4Tuhiyq7zbEvGP3P3hTA50HW608h/hN3Aja+CxJ/e06JU8RIzBKMVuKO2SFMsPDLLGad6JF3iHXbtWDEBwPvMYMpqFtB8DyFycpd8tRddYyjLV6XUB7aLcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=nhWOf3hZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1edf506b216so39421165ad.2
        for <netdev@vger.kernel.org>; Tue, 14 May 2024 08:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1715701418; x=1716306218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/Fq7MH/4tj4k5lG6x4wK3Bqj5WyXiB5FuHbHgeQfs4=;
        b=nhWOf3hZ50K9lj/al5ZRgGN1qU59cN9k/sK5agh+I3aFHeX6jrtLBpwNTSKGzctrR+
         XZr0P2XeTlrt3NGloYHRXyXQPxExsjUHHE9tH3xcIjeoLdQ4GS8JUobym2pYJbYP6Wg3
         F64NnIasrWzFbJFvJb5r0OHZvDJsrC95fywNTMIF0zOCUqLMJWNDynDzsOSe9/NZBw+z
         X+E/nTWD2ZzA+klULuwyz5e+qBVR503JVPXBh3B8LrvcYf9vxeLnxzTeTUni8F/QdHpR
         A/yBJnorZH1vyniz8NZi+b39NzYAzKh6BHDwFtUg3NJQo94Nsxehv6uMK6ocbH+5Yf6l
         Nh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715701418; x=1716306218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/Fq7MH/4tj4k5lG6x4wK3Bqj5WyXiB5FuHbHgeQfs4=;
        b=ptKNJovFJpxK4aDXjnVTpHcuPW6zSXdKtbpqjF3uAG8ILBlv49Ofm1h4tqiLhbyPQC
         OEjU+ITMmh90CKUVeEx1L9XQzjYF8GSg/ri1bMTlyjc9tNPelKV2xZKiYP964eFjBTFQ
         bKmxS7I9b7c8vmz1S3eZ9/3XfI/r3uXUsIBjroaa4+L+EIkDsVAGGhxM3xZPk62ywxJQ
         bZLWN/qtMcmaeh3+YpV0AEb6FWSQpAZQjN4Ch9Rsi1XKGPY9n7WdNotbkgvIAkk6h30M
         ypW3y1/MQ9m290/MClIPf30ZAf7vNw4k0EG8MOI8FtQJxCunN7htmIQ4dtUHlqIG9wHb
         eXvg==
X-Gm-Message-State: AOJu0Yz1Z68+0We5MX1Y9fB2y8BNVZSIbfRbKd/52fAtZGUfyxh5298F
	0QRs3nU1nFBqmDwpwViuAdIi7fMbNQ+XDlGWZOVCL9GlUtT46q9khGFsVBrUEA0=
X-Google-Smtp-Source: AGHT+IFvFBCCBOQRz8GgLKHeIaRkciQM6C/qF86j9Oi7JZw0TfVMmYbaL4rp0bNgLxhucSyQmqf0kQ==
X-Received: by 2002:a17:903:245:b0:1e4:4ade:f504 with SMTP id d9443c01a7336-1ef44161e45mr144760295ad.46.1715701417699;
        Tue, 14 May 2024 08:43:37 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c1394b8sm99590645ad.271.2024.05.14.08.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 08:43:37 -0700 (PDT)
Date: Tue, 14 May 2024 08:43:35 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Brahmajit Das <brahmajit.xyz@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] Fix implicit declaration of function 'htobe64' in
 gcc 14 on musl systems
Message-ID: <20240514084335.19f5b280@hermes.local>
In-Reply-To: <20240514063811.383371-1-brahmajit.xyz@gmail.com>
References: <20240514063811.383371-1-brahmajit.xyz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 May 2024 06:35:37 +0000
Brahmajit Das <brahmajit.xyz@gmail.com> wrote:

> On musl systems with GCC 14 and above, the htobe64 function cannot be
> found by default. From the man page[0], the function is from endian.h
> header file. If the file is not included in, then we get the following
> error message. The issue however cannot be reproduced on glibc systems.
> 
> In file included from ../include/libgenl.h:5,
>                  from libgenl.c:12:
> ../include/libnetlink.h: In function 'rta_getattr_be64':
> ../include/libnetlink.h:281:16: error: implicit declaration of function 'htobe64' [-Wimplicit-function-declaration]
>   281 |         return htobe64(rta_getattr_u64(rta));
>       |                ^~~~~~~
> make[1]: *** [../config.include:24: libgenl.o] Error 1
> 
> [0]: https://linux.die.net/man/3/htobe64
> 
> Signed-off-by: Brahmajit Das <brahmajit.xyz@gmail.com>


Fixes: 976dca372e4c ("f_flower: implement pfcp opts")

