Return-Path: <netdev+bounces-87190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D048A20E9
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 23:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D68AC1C225DB
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 21:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619202E3EF;
	Thu, 11 Apr 2024 21:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5D7OUtY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B9912E6C
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 21:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712871020; cv=none; b=iUdv7GYip8bHQmE2pvhjapTOzK3NLp161L9ifocQaofMv8QSzWhazv9pVb0w9UHY0mZD9YCcMxS7bb8xb7Yy2ZPzZvOdJCGt28kRM4Xdl1gyS3xSOo4NAAn7cWlndevdqDPe/TmTJIla7zCBVh+qZTPCDwWykHFYe92wnOagufo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712871020; c=relaxed/simple;
	bh=ndlAgvmem4zGbFUfhs1e2gsuCEptdIYg3zmk7IP/ZD8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=IH0MdctbAXFqDwKJqCFOJwHBmypdKhJ3kj8AlCGv7w4tBgEPrgGFNY6V3M3fPnJmn0H/yyAs2543iPn1jY2Ms82i0c4f0HoDUFunBqAbbwh314D59m+PdXBs7FPyCMePYuCr3CELHAr6m9s1pFFWY56YLUOxJQXjRiByxDAbQTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5D7OUtY; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4347e55066cso1191771cf.2
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 14:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712871018; x=1713475818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiAwncWX+6xv+H7hh8BdlwmqVEZC5NryJm8AhUBVlXs=;
        b=N5D7OUtYjsXff1f/f18QthVueMvLDrXGn012sXPEhV/Pws+SQJup8Jv91gmZypZN3t
         dzmikno3lvil0xuKVJhYCtZiZdpo2xckHWFsP6phX5BohRz0+6oqiZIjyShsz3mdEQNk
         zpIQDT3vPa8WhQgxtjehEUuzlECmSfioiyjxeemGmbiY9QfDAcSQo0oEgG4RQRFKAnTn
         coABDZOpT/cTctf5CGiQEu0QqWCA7t0VYS/rFZcKEAx7zVyNi802mw/Lw2dCLawT+r4r
         aqKeqdvYuvY64UthM50TV+tP4w34FzuooZ52hA3kmaheS0UtpVq32oh39ammYsrgIK0S
         UDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712871018; x=1713475818;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oiAwncWX+6xv+H7hh8BdlwmqVEZC5NryJm8AhUBVlXs=;
        b=wxUDrcWtoij1OeTCWw5/A4nI3Ucp6m/lw4uQSyZtC1ls++TcNRtDO93kjvLztqHVJI
         Dk80Ng9QLWmfFRvg/LMRVkGtX6g8NopCT44mYioYbN9Otg1aa8vyylvSOS26xc9/n3fy
         gpgqnA41S+gX0bMXHPxeBbwJC62NuQNoGYSnu+7SIGd9A+MO/b0sxU6ezGyNv9Av71Uw
         EspANiX4ACrChTxeqcIin7f28QGWvIUX4663RrIH0VJpNJIW9wKiAFVMS0tOEGtQhbn/
         ZcHj2F/Oxp23kDTug49Q71MgIxalDwvt8f8h6jQJ6/FBk0KlQatBXFTTwTL+7tPl9rKF
         fffA==
X-Gm-Message-State: AOJu0Yxbl1Wi8dDnQH0rPoCtEJ3NrCqvheLwynmyCcZxoloUczQ0B/3u
	bO59Q8ikUqII8NZrQbzL5nOklidFfIKJAM7h6UFIwnjz6gSdoFKt
X-Google-Smtp-Source: AGHT+IFZYejN8sKbbAAGbr9mwTzqlNM0ZonfTNa7ZwE5cwMLySwbS8scb324Sc4VuJqEcHLQKm477Q==
X-Received: by 2002:ac8:590b:0:b0:434:cfe4:90fe with SMTP id 11-20020ac8590b000000b00434cfe490femr1220230qty.38.1712871017697;
        Thu, 11 Apr 2024 14:30:17 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id kc5-20020a05622a44c500b004365ab2894asm1391665qtb.51.2024.04.11.14.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 14:30:17 -0700 (PDT)
Date: Thu, 11 Apr 2024 17:30:17 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Yick Xie <yick.xie@gmail.com>, 
 willemb@google.com, 
 davem@davemloft.net, 
 willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org
Message-ID: <661856692c8af_36e52529467@willemb.c.googlers.com.notmuch>
In-Reply-To: <CADaRJKtHCvBH_GJkqF2+NjaLg6uzo4-8s6YDuzT=HzJdDM4hHg@mail.gmail.com>
References: <CADaRJKtHCvBH_GJkqF2+NjaLg6uzo4-8s6YDuzT=HzJdDM4hHg@mail.gmail.com>
Subject: Re: [BUG report] GSO cmsg always turns UDP into unconnected
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Yick Xie wrote:
> Greetings,
> 
> If "udp_cmsg_send()" returned 0 (i.e. only SOL_UDP cmsg),  "connected"
> would still be set to 0, later inevitably "ip_route_output_flow()".
> In other words, a connected UDP works as unconnected.
> 
> A potential fix like this:
> 
> ```
> https://github.com/torvalds/linux/blob/20cb38a7af88dc40095da7c2c9094da3873fea23/net/ipv4/udp.c#L1043
> @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>         if (msg->msg_controllen) {
>                 err = udp_cmsg_send(sk, msg, &ipc.gso_size);
> -               if (err > 0)
> +               if (err > 0) {
>                         err = ip_cmsg_send(sk, msg, &ipc,
>                                         sk->sk_family == AF_INET6);
> +                       connected = 0;
> +               }
> 
>                 if (unlikely(err < 0)) {
>                         kfree(ipc.opt);
>                         return err;
>                 }
>                 if (ipc.opt)
>                         free = 1;
> -
> -               connected = 0;
>         }
> ```

This is not actually a bug, is it?

It is not necessary to a do a route lookup if only udp_cmsg_send is
called. But neither is it for some cases of ip_cmsg_send and
__sock_cmsg_send (which it calls in turn), say SO_TXTIME.

The suggested patch is a nice optimization to use the cached route.
Do send it.




