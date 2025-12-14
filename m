Return-Path: <netdev+bounces-244630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A20ACBBB45
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 14:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5319630010DF
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 13:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043392528FD;
	Sun, 14 Dec 2025 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeU8RZ4j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0A11EA65
	for <netdev@vger.kernel.org>; Sun, 14 Dec 2025 13:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765720485; cv=none; b=f3iXkq4N1+GFaPnP5e+RVVcr3k9JNoh3SWM1bkG3sIzgwe8vN62g3BBAKFmo3ip+wuVLAe1dN5XuRD8kxVOOrH/yVQBNC0RUJc8wy3VyFllkf801ZftOFu6z3V1fJtshwdhYASQawkJxwSYipXlRwEi38n2AUle0BqLusqtsNRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765720485; c=relaxed/simple;
	bh=PjGrwWZV81DPFzMQNA4x3xriIjb0S8YAsDZbn2pcA6U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R4HAQFQaD8LiZZr2UlkMwduWQ8oWtn8XeTpL8zPGpzoMp1Ceh20o0SPbx8xTnf3zBK831ZjUEN3hIJsOARL6u8iUHakaPHyvN5DuELL/iasTWxQHDSjH9pDZQazarx2YeoVz0KVqmazXVreGaQ3b4WZ7xcT45dABH2O2mFno0Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeU8RZ4j; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso20254005e9.2
        for <netdev@vger.kernel.org>; Sun, 14 Dec 2025 05:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765720482; x=1766325282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A27ILOHpvAtHnE+6lvnDEAst4fggOFaoxUBA4wWZFjE=;
        b=IeU8RZ4jvC+WmapLF9dlbFIqlZbg18sWO66y0ieYZj/Ak4RFOZjMZhWNhuRjUdEBE0
         SUBI6M+r1oB70c0wiptn2g9iiEW/9PZBIRigRaWesnU/cYAkj6nG4wnXj7H419j69u1+
         6FRtAeP+wJl8hOWkUVACQmSTdZDOSUdgkKUAZmkQBRFkzrZznwp5sIUTzchbqcn/mu5X
         AaeCFBMXGB081ZlOL9cvin/GH683T0R1WuGSTLvpysl4HzHj0566Do0aGkoz+r2xon1V
         Y1zvl+Z7vbjYpAYVvYYubyiX5SEoYYaP/B69bPN43l6bkZ4yuVAoiKR4GSjZbCGeXQgQ
         Bpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765720482; x=1766325282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A27ILOHpvAtHnE+6lvnDEAst4fggOFaoxUBA4wWZFjE=;
        b=sPamqoj1X++WcIGU4JFt+2udv8wFQ+RnWYd6Dj4g8kABR8V8NL4v/5a8/dL8uDd0BQ
         dEDaCQ4JkwC6QjK30cUAQ2AEfyxkIqsS8nBdcIVr9cY5c89oxIj0p8mopH0eoHtewkkc
         9+O95LIj9mtYY9VywUlfFDskkbDfsEczy2T/uDXjDvxjy4DrVYdVaKxWy2UAKFg/YmHr
         Xzrg8J1XVCl+P+Swl9t0Cw179hPk5FFO5vGNpbevp/Z9Visl1dsaiw0ZxUPv4r6kPmRs
         XMiqklUrBPPKtTG0eu9DRAn8xkQcZ/F3h66ScHabN36U8DSV6dHpUFmURnsSd18p1WCJ
         IIVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUtwKGUBkGblC6cpLUgSH4R/iUSO12msKnXIHfxjBAurUVKI3d15dbynWZOFjNu4UA7JREFyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjbcXcvFFpfHDs1Uv2rIaZHqU22K1H+rrn5TN6kz0aADfzLjGe
	9gt+l1/1b7M8sc1n3eG2W6dTc7pp/7ypuz484FLQHEt/KMu9/TgqR/nG
X-Gm-Gg: AY/fxX6NmoGqkYY0iIpgnJd1hjUjDt1xdPNltewsgsHi7OBi8n6z8rwzM02hWgddoCd
	oB0PZkiri3EXN2hbJ68vzFNYelfADMDHKdnmuZ5hNvU/KLSOysY+B84P5YV/JgX+eYVRsGOL2ce
	cUnGLVHSvG8DBJYLCBFiPCVts0+REyp9KxJClpY3EIpQPcGQFuR3oCJ1pk2R7+/TeZZ0Y0N4XBj
	x23KB8OD2I/0j5lCSsub0gz0+1fzqtGDvy5OJaiqIrnpw2jHbSbf4CqzkTpkusIeMfztftFbi5Q
	6PnJJeOH8x1+Kh8h1gOA9//kLjdfDKnFBo/TOZbeEtrfL17wyGb7kioThKEBfl10dqsBdE6bRPV
	gx2ak94zBSy8XjzZz9eHlxDGpcC9AofTGnszSNXmqHV1iQhtN1nUnbQgFgN8Ln7LjDPTb05e/Ds
	/+6WlJVVgBPisG3nes85iZcU7JHDkAC7Ko1+LYifWgR2VBOMOMWeUb
X-Google-Smtp-Source: AGHT+IHTxNR+ZUDxw8OLVbLKKhDwZuONnZ52bWZfD6ui4ltu6ALafY6AXlfWh7ujj0ZxW5VYZ5/Z9Q==
X-Received: by 2002:a05:600c:3ace:b0:46f:b32e:5094 with SMTP id 5b1f17b1804b1-47a8f915c57mr66690115e9.32.1765720482446;
        Sun, 14 Dec 2025 05:54:42 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a957de489sm114389375e9.5.2025.12.14.05.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 05:54:42 -0800 (PST)
Date: Sun, 14 Dec 2025 13:54:40 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Ma Ke <make24@iscas.ac.cn>
Cc: krzk@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 aloisio.almeida@openbossa.org, lauro.venancio@openbossa.org,
 sameo@linux.intel.com, linville@tuxdriver.com, johannes@sipsolutions.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, stable@vger.kernel.org
Subject: Re: [PATCH] NFC: Fix error handling in nfc_genl_dump_targets
Message-ID: <20251214135440.51409316@pumpkin>
In-Reply-To: <20251214131726.5353-1-make24@iscas.ac.cn>
References: <20251214131726.5353-1-make24@iscas.ac.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Dec 2025 21:17:26 +0800
Ma Ke <make24@iscas.ac.cn> wrote:

> nfc_genl_dump_targets() increments the device reference count via
> nfc_get_device() but fails to decrement it properly. nfc_get_device()
> calls class_find_device() which internally calls get_device() to
> increment the reference count. No corresponding put_device() is made
> to decrement the reference count.
> 
> Add proper reference count decrementing using nfc_put_device() when
> the dump operation completes or encounters an error, ensuring balanced
> reference counting.
> 
> Found by code review.

Is that some half-hearted AI code review?

Isn't the 'put' done by nfc_genl_dump_targets_done() which it looks
like the outer code calls sometime later on.

	David

> 
> Cc: stable@vger.kernel.org
> Fixes: 4d12b8b129f1 ("NFC: add nfc generic netlink interface")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  net/nfc/netlink.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/nfc/netlink.c b/net/nfc/netlink.c
> index a18e2c503da6..9ae138ee91dd 100644
> --- a/net/nfc/netlink.c
> +++ b/net/nfc/netlink.c
> @@ -159,6 +159,11 @@ static int nfc_genl_dump_targets(struct sk_buff *skb,
>  
>  	cb->args[0] = i;
>  
> +	if (rc < 0 || i >= dev->n_targets) {
> +		nfc_put_device(dev);
> +		cb->args[1] = 0;
> +	}
> +
>  	return skb->len;
>  }
>  


