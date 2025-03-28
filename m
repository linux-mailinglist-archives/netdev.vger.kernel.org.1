Return-Path: <netdev+bounces-178040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC56A741CA
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 01:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291B8188DE8F
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 00:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDD5195FE8;
	Fri, 28 Mar 2025 00:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4vtLEHC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A1419B5B8
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 00:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743122435; cv=none; b=myK8Ut4mNSLX+q7UCj+4r9ajlvPUKr5WIll1O00332uaXGLgBiCXb8y6sA1YSRleNGywCxj9F5eLVK1vA7+LpNYhGRKKvsPopsVEiinrSmR4bZbrbJq0uoK5Be5tA4hBqPXiWVbBO56vxEjJGFRTUy9yg9iyiVs6jRU22xT1Y88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743122435; c=relaxed/simple;
	bh=g/ygJa+RZ8XNRbgEYDXmnjTw/baxuHEc1+D+TSHFEeI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=BWzshCwO3s1rrOc1dFYrwXMpfkpQz9CufJ5OssN6jxP4t4Cio0dyJ8X4yOS7AgF/4UsIgc7wQgpNfD8oyPbtuULYBp9sybzqDymUgkOM2EChUArpInNIFpiLOeXVV6mK3unxd3mcqUXwEVyt7Pq9L30bOENf5dcwfZtvJFgln3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4vtLEHC; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e8f254b875so13794156d6.1
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 17:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743122433; x=1743727233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8mA34LYhW+QoMFnfu2dYsGKV+/P3qeNjF/Imx8Axn0=;
        b=l4vtLEHChV3agFDuUW2I53lUGuI/ie+lEx6kR479+ejMMt/vhixmE0VKRd3qaYPtaI
         n7YP4FxvuiNaYyZLCOYeuFL7cRbcCNQzPaZ7YraH6m8Mcknous37Qi72QAq7jGfJ91xs
         voyPtzymj2o8MpDqocdZCJ6MLK9k6VKiUgie+6FYwnKeLDipxUt2vk/Qx+SJEvY7C99Y
         YRw/KJ4krHHLh9x7p7HvdffM7QlscELMXg2LtMLyMGOHbeusFiAYpp2klkvXPIR/fLwT
         xKYJPAHoh7c1WgMRxWRDp9YJ80uyKhZfp/7GR1j3MODtmiVxrtTWMrfxMjviF/N9NOeB
         pG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743122433; x=1743727233;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/8mA34LYhW+QoMFnfu2dYsGKV+/P3qeNjF/Imx8Axn0=;
        b=PWnyZXwJfjiEmH1f2qEeBnMgjtCD/tk+ZuLJj6S/ExUr1zX1v0NvrohkrtPnbC+fiE
         3FS4IgUgvhZreeMGvnK5tFVnhtVnI7n8oE01U1r9HYP9CyS7zK7ngJ7L28wHuKhBKAJ+
         84pIvEK3xUZEIDyWNxyT/DRxUXNPli6MfrNSYanKEm2fr0AMjSUGqpOkxTa+qfwYCUgI
         EgdnCRVtHJ+D+NfimgGpA1fcU1wKTKsDuHGY1ITgOR1TEQupzZ6if+JjGPEpexxk4SuP
         pLuH95Q2r7jTbNFWKiOJTkZ4Yg2EFmYxUzF7vwIk/3tPu999wox8rAXwEOv0YB4rMa7+
         7u/g==
X-Gm-Message-State: AOJu0Yz1Xz1PSrk4OP58tMITQAFLkzThMg+4yirdnBt8KBOPBXl1Ek7D
	GHNvPF+10aUGok6+nthSLjeFzf+v0WNeBKueEWeM27UU990NF0nO
X-Gm-Gg: ASbGnctWN+iss16ikZpV5VBcPehJ19NDePm8boBYZiM0RXIx1mM1LPiZvHgI03RQxoo
	837Z+oLIlkZozXFdmxHXZ2JmOj8YJTiABUQVSmtrxlxCC7y228FfJ/WdAoNHJyrWauS2OWtsGr6
	z5SCR33R04kHP6HVOGj6lNbxzTOWG1LH9dJNjwzPPrmMP7SpU9ZccCaijGVgofTtR2om1l8Q/27
	KemUlE1phWYBJpm1DAe1t/IKN6CfXJqNUcLM6MTgRM1YzcW1vwVPIci+ITkybTUNe+kJ9IYkLF7
	FNYr9KAxitmKs3Yemvh9LmAHmJxAzta8V0a0yMf2tISz32xJ85knCT2rfUNJy1MBEfA2WOg3Tud
	u5ypXY6HoYKofB+ufoEN4LQ==
X-Google-Smtp-Source: AGHT+IELlAn4VdBD7tmzM8t3Pbr29VI/rLtt0D8yZ8Lk1gs1L21z45N2pUyYzARr7T8JGCTPF3HCxg==
X-Received: by 2002:a05:6214:f2b:b0:6e8:f65a:67bd with SMTP id 6a1803df08f44-6ed238a562amr64175326d6.11.1743122432751;
        Thu, 27 Mar 2025 17:40:32 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eec9627d88sm4805586d6.8.2025.03.27.17.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 17:40:32 -0700 (PDT)
Date: Thu, 27 Mar 2025 20:40:31 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 sdf@fomichev.me, 
 willemdebruijn.kernel@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <67e5efffb2b39_11b3cc2949e@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250327222315.1098596-2-kuba@kernel.org>
References: <20250327222315.1098596-1-kuba@kernel.org>
 <20250327222315.1098596-2-kuba@kernel.org>
Subject: Re: [PATCH net v3 1/3] selftests: drv-net: replace the rpath helper
 with Path objects
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> The single letter + "path" helpers do not have many fans (see Link).
> Use a Path object with a better name. test_dir is the replacement
> for rpath(), net_lib_dir is a new path of the $ksft/net/lib directory.
> 
> The Path() class overloads the "/" operator and can be cast to string
> automatically, so to get a path to a file tests can do:
> 
>     path = env.test_dir / "binary"
> 
> Link: https://lore.kernel.org/CA+FuTSemTNVZ5MxXkq8T9P=DYm=nSXcJnL7CJBPZNAT_9UFisQ@mail.gmail.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

