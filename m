Return-Path: <netdev+bounces-130159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8241C988BAF
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 23:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2D02B20DB6
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 21:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4001C1AD0;
	Fri, 27 Sep 2024 21:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="CYM7AtdE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12011136352
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 21:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727471209; cv=none; b=jMSntR4eY36Bp8JG2oz1jlZCJjABeuDFZ3XOSIwmt77n/AEeCyMuVvPfN+tn5DAehiEabAKZU/p1R8IAucb/0fexJ8S4WtmzDN7/FJi/8QZy62L2eVphplkpZYUgKJLpo3EnkugBfyV3cJ3jpvgWFpXwBrw63/jFcGzO6jdnroc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727471209; c=relaxed/simple;
	bh=qFBPT+JC9nMJbYwTHpgqTGaysu9OqB2fDJvG3gVv9wA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lzbg8qyBL31BbEMCiWhTexpQ/sk6kHtrREpF42A0utJOWpUIJIkfmpu6veoZx87tN/ercwkPw/YH+kP01xdfMyWONQ54EBobuUoDgsHJBAZe/u7zLrFaSd9IGQSVTz0yKHw7PDpQxljsFXrAJGYl8u1PoxmdOdqg3VyVzBGQcXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=CYM7AtdE; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so2587692b3a.1
        for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 14:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1727471207; x=1728076007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYnj7iWUEQsN/wM2kjgJEE3hbSQOTy8VYanYfpbweAU=;
        b=CYM7AtdEhOazs+yRpJfpg0ipmRKre+2iMlfWDcScUUW3e/yjwplBMqihz5P71vUoOn
         9Rav0ljGOTRbaHBlwbFQ4VFyviy75MUhX+j/YKaLcnpWIPo6mthK/vNX2izOxEy0oeSA
         kj1c7nMw8B22DDihPY6UY8CoGXQpemh9IWFRS4bqFPpez6H78yeIjGkAenJ0UkGi7jET
         xhVATOTTx73Fd5ttGB+5jRp8PACUjreoCcVyfmj6vjuKGkVkj0BOVkhFr11HxvugYiIT
         pFcwImRZUC7Om1OnlJCXroFMsnSQz6xO/3Sq40ofQMy+VpTb9JH51OCnc0I81hLbVESh
         eA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727471207; x=1728076007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYnj7iWUEQsN/wM2kjgJEE3hbSQOTy8VYanYfpbweAU=;
        b=CfUEAYtsuI8sBMErdORcOdR1DMuyKs8ef7IAOEEAy6UB7ymjD/1F/2ajWFADDVSRnG
         /G19Hs6trnorsW7L4DuLe1a4p3UyU8wiEOQLMyHdZ+bWRO8TzOYWJEj+UO56DJ1Ss2ab
         dQSMfg5JyCO9vx+VJkfv1jsHEGBzc9tlCO1BcziqLPDv6Rc/yYMl45YSyoDNTujcAlKR
         lI802Wibbu/k6PKDUlMVuF9oBVkrffdWYjEgQGV9/n5zP4EOEGO3ffOLsxxa0LGgM1r7
         eSVRnR6Vi1mLYvsDH+izZlT/4lhi8BBs/Ok/iSlfb/+yh/3MLf+LqOb1K29ugcqGyqBW
         vH9w==
X-Gm-Message-State: AOJu0YyBaLUX/jshT6rIVWR8yjikIcsLZN77WWF4MyR2Mup9Xut8DFdo
	ciSWB+XYKiyodljerHuuNOD7c6s5i4zu0XRIaFAsmTuXt89egrqXHYNwYWF56zI=
X-Google-Smtp-Source: AGHT+IHqCax/TffHsTsuymwJ2qbQAkfgLWhJvo/8ieILIbUxKENeH2NiCyqg6Eszhr9jD8EHr3fWyA==
X-Received: by 2002:a05:6a20:d70a:b0:1d2:fad2:a537 with SMTP id adf61e73a8af0-1d4fa3c0a5cmr7852468637.18.1727471207155;
        Fri, 27 Sep 2024 14:06:47 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264bc3f7sm2042916b3a.77.2024.09.27.14.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 14:06:47 -0700 (PDT)
Date: Fri, 27 Sep 2024 14:06:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: netdev@vger.kernel.org, linux-amarula@amarulasolutions.com
Subject: Re: [iproute2, RESEND PATCH 1/2] arpd: use designated initializers
 for msghdr structure
Message-ID: <20240927140645.02515695@hermes.local>
In-Reply-To: <20240922144613.2103760-1-dario.binacchi@amarulasolutions.com>
References: <20240922144613.2103760-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Sep 2024 16:46:12 +0200
Dario Binacchi <dario.binacchi@amarulasolutions.com> wrote:

> This patch fixes the following error:
> 
> arpd.c:442:17: error: initialization of 'int' from 'void *' makes integer from pointer without a cast [-Wint-conversion]
>   442 |                 NULL,   0,
> 
> raised by Buildroot autobuilder [1].
> 
> In the case in question, the analysis of socket.h [2] containing the
> msghdr structure shows that it has been modified with the addition of
> padding fields, which cause the compilation error. The use of designated
> initializers allows the issue to be fixed.
> 
> struct msghdr {
> 	void *msg_name;
> 	socklen_t msg_namelen;
> 	struct iovec *msg_iov;
> #if __LONG_MAX > 0x7fffffff && __BYTE_ORDER == __BIG_ENDIAN
> 	int __pad1;
> #endif
> 	int msg_iovlen;
> #if __LONG_MAX > 0x7fffffff && __BYTE_ORDER == __LITTLE_ENDIAN
> 	int __pad1;
> #endif
> 	void *msg_control;
> #if __LONG_MAX > 0x7fffffff && __BYTE_ORDER == __BIG_ENDIAN
> 	int __pad2;
> #endif
> 	socklen_t msg_controllen;
> #if __LONG_MAX > 0x7fffffff && __BYTE_ORDER == __LITTLE_ENDIAN
> 	int __pad2;
> #endif
> 	int msg_flags;
> };

That is a really bad idea to put extra padding in there.

> 
> [1] http://autobuild.buildroot.org/results/e4cdfa38ae9578992f1c0ff5c4edae3cc0836e3c/
> [2] iproute2/host/mips64-buildroot-linux-musl/sysroot/usr/include/sys/socket.h
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
>  misc/arpd.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/misc/arpd.c b/misc/arpd.c
> index e77ef53928a2..b4935c23eebb 100644
> --- a/misc/arpd.c
> +++ b/misc/arpd.c
> @@ -437,10 +437,10 @@ static void get_kern_msg(void)
>  	struct iovec iov;
>  	char   buf[8192];
>  	struct msghdr msg = {
> -		(void *)&nladdr, sizeof(nladdr),
> -		&iov,	1,
> -		NULL,	0,
> -		0
> +		.msg_name = &nladdr, .msg_namelen = sizeof(nladdr),

When converting, to named initializer, please put one per line
like other code does in iproute.

> +		.msg_iov = &iov, .msg_iovlen = 1,
> +		.msg_control = (void *)NULL, .msg_controllen = 0,

The C standard says that NULL can be used for void *, cast there 
is unnecessary.

> +		.msg_flags = 0
>  	};
>  
>  	iov.iov_base = buf;


