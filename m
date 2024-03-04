Return-Path: <netdev+bounces-77066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82207870089
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 12:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33DFB284305
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 11:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E361D3A1AF;
	Mon,  4 Mar 2024 11:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsBl8bo+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C883A292
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709552484; cv=none; b=U+tSq3CrsES+5wP+hMSoBTbq2IE/DOPQfIo5pfr+bares6aRH5BNQGwcEDPwkzK3Jj+zlanbNqS8LjoHTrGcTC6hd7ExA2oBVJ2opq86tYmjbR9gr2yUsvGglC5062/zZjLi/M0WHMZ4B9Qv4wmnvxbOMvvYyKOjBC3L1uxJBWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709552484; c=relaxed/simple;
	bh=eSwo+WSvjurdTQvMvk/vGxWZ23q2Yl2mwMU+LElNZIE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=ERqACcaXjRHUrETkJZbgMHiGvyVG9WBTzjMpmZCXbQpXqybFMS4su/0MiskIvkQezHoRbzbUYx4S+TI/d7viAtRYBKNLpGANE+FIpxK2R6jp2gh+YJqlgLmp0xadm5pVHVnEsMHX5J9TM00Zf/iQtRYEJATgvZqBk75rTKEgH0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsBl8bo+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-412e72b0d96so2490145e9.0
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 03:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709552481; x=1710157281; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8jolCdczIwqR03bBgr/yG98ha/g9dY8VhHvXkj8JGMI=;
        b=KsBl8bo+wuZH78vZP523hmq5/j2Dq6ZxnO+rSYnPCGwl+XGsTSUEkyu2kGVkObU7mp
         cS/6kfAEbmS6ieKbv76an5i3fVAWExHLGHhIDrAGE2GXIxdbBImFKcA1LhDcOjc57Zp5
         cC9INKPe03TnUigfhjVVH5BcLzV4JZ5pqsxLIx5TQPju2d0v/uJ4yUqKbQxnEiyX0v7+
         gNsRkUaJLJcSS0ufI5K5qHMNLqx7upHrejD4Aq5nSY0ydevQwgen02HTRKx/lVBvT1F4
         Y6yQq66sUi0lkJEbP/G4+7vNPCb3OwqucWOLjWSZZOcdqsgB/ysfVvfzVjSgMuKyOmKP
         +QqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709552481; x=1710157281;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jolCdczIwqR03bBgr/yG98ha/g9dY8VhHvXkj8JGMI=;
        b=Vmz9Y4PCeIDF72jp7x7KrP323AQZsPJXcySQR9PaQq9K5J9xZ1Eolyx5KAk2m7w6KJ
         krY7tl8AnaZr3itkSFtJ97nUWOcZdf9hkg5KXeoFCv5OCCzaogBLrdwGNYYUAJLauKi2
         Q0yo6ta6nC5p3ffJ2a0K9ca94bedYrsucKRBPrHzDdkK7RLZkg3yGYj77vx1Z9Ni0fre
         Kk7eAllkT8xgxcxoRjWejurIwoECZwsYki1aPmRFLFf1516ZJtj9+c+5RJHb732UubGy
         Ctxw2xhincMchdAtbkkJc4/EqAARoF7f6aajPAAyEI/2GUz12J7CvHL2jeFVBBbnVITc
         zK3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhr3rdifuwqEpMjbmggPzEXdeFnxk9DfLA2dZ7fSGbUw4mY/bjTUMfHq3dOZHk+vgwg8mSurWlT1Khz9awBwXpNqG679OF
X-Gm-Message-State: AOJu0YxEGvtmgfmCbcfGVLpbGcdb4iwr2/kQziw3CVm0dvIG0hIigHOP
	G2hCc3YDD4uuFtEgHJ+nXBx8GGwGrCVQkTrz/ZC5s6JszZtOPCPa8/Xcfhyb
X-Google-Smtp-Source: AGHT+IGdhx5hFw8yec055zt5pI4h5UzC6qNg50FdBfrB4GXg1GggdKB0ldyCqngLOQ9Gwf+a8mpe1Q==
X-Received: by 2002:a05:6000:dc8:b0:33e:363b:a7dd with SMTP id dw8-20020a0560000dc800b0033e363ba7ddmr2283110wrb.20.1709552481245;
        Mon, 04 Mar 2024 03:41:21 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:29eb:67db:e43b:26b1])
        by smtp.gmail.com with ESMTPSA id e18-20020adfef12000000b0033cf5094fcesm11987639wro.36.2024.03.04.03.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 03:41:20 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com
Subject: Re: [PATCH net-next 1/2] tools: ynl: rename make hardclean ->
 distclean
In-Reply-To: <20240301235609.147572-2-kuba@kernel.org> (Jakub Kicinski's
	message of "Fri, 1 Mar 2024 15:56:08 -0800")
Date: Mon, 04 Mar 2024 10:18:20 +0000
Message-ID: <m2edcql2qb.fsf@gmail.com>
References: <20240301235609.147572-1-kuba@kernel.org>
	<20240301235609.147572-2-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> The make target to remove all generated files used to be called
> "hardclean" because it deleted files which were tracked by git.
> We no longer track generated user space files, so use the more
> common "distclean" name.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Nit: distclean should probably be added to the .PHONY target in all the
makefiles.

> ---
>  tools/net/ynl/Makefile           | 2 +-
>  tools/net/ynl/generated/Makefile | 4 ++--
>  tools/net/ynl/lib/Makefile       | 2 +-
>  tools/net/ynl/samples/Makefile   | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/net/ynl/Makefile b/tools/net/ynl/Makefile
> index da1aa10bbcc3..1874296665e1 100644
> --- a/tools/net/ynl/Makefile
> +++ b/tools/net/ynl/Makefile
> @@ -11,7 +11,7 @@ samples: | lib generated
>  		$(MAKE) -C $@ ; \
>  	fi
>  
> -clean hardclean:
> +clean distclean:
>  	@for dir in $(SUBDIRS) ; do \
>  		if [ -f "$$dir/Makefile" ] ; then \
>  			$(MAKE) -C $$dir $@; \
> diff --git a/tools/net/ynl/generated/Makefile b/tools/net/ynl/generated/Makefile
> index 7135028cb449..713f5fb9cc2d 100644
> --- a/tools/net/ynl/generated/Makefile
> +++ b/tools/net/ynl/generated/Makefile
> @@ -43,11 +43,11 @@ protos.a: $(OBJS)
>  clean:
>  	rm -f *.o
>  
> -hardclean: clean
> +distclean: clean
>  	rm -f *.c *.h *.a
>  
>  regen:
>  	@../ynl-regen.sh
>  
> -.PHONY: all clean hardclean regen
> +.PHONY: all clean distclean regen
>  .DEFAULT_GOAL: all
> diff --git a/tools/net/ynl/lib/Makefile b/tools/net/ynl/lib/Makefile
> index d2e50fd0a52d..2201dafc62b3 100644
> --- a/tools/net/ynl/lib/Makefile
> +++ b/tools/net/ynl/lib/Makefile
> @@ -18,7 +18,7 @@ ynl.a: $(OBJS)
>  clean:
>  	rm -f *.o *.d *~
>  
> -hardclean: clean
> +distclean: clean
>  	rm -f *.a
>  
>  %.o: %.c
> diff --git a/tools/net/ynl/samples/Makefile b/tools/net/ynl/samples/Makefile
> index 1d33e98e3ffe..3e81432f7b27 100644
> --- a/tools/net/ynl/samples/Makefile
> +++ b/tools/net/ynl/samples/Makefile
> @@ -28,7 +28,7 @@ $(BINS): ../lib/ynl.a ../generated/protos.a $(SRCS)
>  clean:
>  	rm -f *.o *.d *~
>  
> -hardclean: clean
> +distclean: clean
>  	rm -f $(BINS)
>  
>  .PHONY: all clean

