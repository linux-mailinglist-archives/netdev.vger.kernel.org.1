Return-Path: <netdev+bounces-211820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02509B1BCBA
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 00:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACCC3625C4C
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 22:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F3326CE06;
	Tue,  5 Aug 2025 22:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MBsLs35b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1601925B693
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 22:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754433659; cv=none; b=c9S9URkztjukLhwF1QVwiO7DsPA6x7W0dkVJDlLjjV0/kE7o8+bBLEfdLQU2iVkhxEu4yyuFl7jqhkGDmTIV56Z4vsL8P0HlLqNk2VrzEW/0zDanAdOVZfraaU1YolVeR9WllJZ9ZRi6OhZRwwuS6lnJ/H05+lKXZQfhCsGXGFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754433659; c=relaxed/simple;
	bh=zS1zWvhTT+IcSshTBcgi0LvYfFbo8Wss63zrFGwEmv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u1s3/X+TfX8WcVEFo/iCEzCqMbyb/af1Kzk6hDe0emsqNzn2T9JwAQ43PvsIkIbl4Rbp7+PDLr03/Uq9utQeAd1aQAWrN/P2Q3c5rnRZyjrfUdFMwxBjNueevYkxteyQOGLQNCO0adWneKTjWOfk8ROC7gqyMTWzLBez4bqhVM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MBsLs35b; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-af9611d8ff7so66270066b.1
        for <netdev@vger.kernel.org>; Tue, 05 Aug 2025 15:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754433655; x=1755038455; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X3m+xXB2nDYY2FTeCIps+Dx8G8ytYsYqX18zczPNIoE=;
        b=MBsLs35bqACeSKK91IC+0gMlre/rcy5m80+cOlXs+F/xIo0hHhAuTNmcpjWfwL4rkp
         Dpr/cKht4/giV33kEEzCUsizwY6Sj4D0bNb+zyQJVoHYjko1/GxRAIY68BTe0poDZqnS
         7OHKDGSIcDlb1eHgHWwIl6azEyR7aTYt5J7sQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754433655; x=1755038455;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3m+xXB2nDYY2FTeCIps+Dx8G8ytYsYqX18zczPNIoE=;
        b=oSjB22FU3/JfoqcTEo+fFXCefbadcSYAQRrwXmRGKUtQa5tcWu+EA5TxgyvLtjn7ZA
         C9/HICOLYTgtVD4g8EZf0HKdaCJwfUhovFZFGJsFNq4cDsCeM1jroUc4D0L8YtePpm6L
         /K5s47vFmEzEbTQ1JX7iQyphApAxyWrMCjXmLOu0eGMBEcD0KuEqg/rRcSv7sYJdOCnY
         euXo9K+yHgxH06rI+5Ir3ToMW1alDlifKbbCshxP0GS35pfxSdtVvCyxVTX1y/jW3sgV
         T413gvQWrk2etPjvX5/sC6UInK0MxFm1YstnXR2QKrd2ze3FcnOcALLAbsad3NpUT3nZ
         fsxw==
X-Forwarded-Encrypted: i=1; AJvYcCX/AmLRZvjAn4N7tzPvuv/Shcjz18t2uifb/TCXwjNEF7k19pOtxpIzx9rXn0MmUPxDRMFm2E0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwnJng4drbSPBZcBz8ceGBNe7ekuX2vIM1HYcvrxw3ZDUbAdzW
	mpPIexPcGHvMQBvNqD0FbTfUlAEwnNdR4A7bTRzdffyAGQuAMeCK/ZpRXzJ2u5bsH090rpuMAQN
	jAiGR6/BJUg==
X-Gm-Gg: ASbGncv5dmP59q87wdoD/ZWS3Yp1Vf2Ih4zGYQiSfF44HnUQRBJtXBnjgmeRFJYBJzh
	zjKi5NWLX+MZHfdqhQYquxBDAkuaR98AhEaM0jIna84wB+X6toCgfT7eY3wIXwCfwGpTdv5RmwC
	hd5N9sLIy+aAM1xoXQa86j7g+nouh/cxQ7YDrJzkjE/T2zgToRh1hs+kCaXiZdVQdByvkFuot8a
	wFOIRm5uhe7ZgJWeBKLXUh8lYD83FSPK4s01OypJPbNgeCL00hnJA14yLKwV9/26P0mjZoObN/j
	kaUQZeFqPK9gYMxfR1dU7jGt+hfYnYiK8iUI1zLckPv4A3s2EKRm8Kz4grjR7fejwJkSQFhl25l
	V6lRQup50zfSOFYqZdPlxTmqGg1/qhafSosKNwmeameOKcd2lsgJOOSakbpkkedwOdinwj5c+Ef
	966JRYv/I=
X-Google-Smtp-Source: AGHT+IE+PKJirgFeUYa/Zzq7UAtvcsk3ntCOQq8NQdr4a17q3EX6fnYqFG9l5Tvs+yaQG8KNQ4pzKQ==
X-Received: by 2002:a17:906:c102:b0:af8:fded:6b7a with SMTP id a640c23a62f3a-af990903c90mr51849066b.17.1754433655174;
        Tue, 05 Aug 2025 15:40:55 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e82fbsm976558866b.88.2025.08.05.15.40.53
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 15:40:54 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61580eb7995so795395a12.0
        for <netdev@vger.kernel.org>; Tue, 05 Aug 2025 15:40:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUzkH4+VCMciXUZfcoDr81mxtqMd+gb5fnOgpZFpD5S8YHfBCil1WFAvEdv92wm5MVeajKSTIs=@vger.kernel.org
X-Received: by 2002:a50:d6da:0:b0:615:1ffe:7e13 with SMTP id
 4fb4d7f45d1cf-61796e84ddamr347112a12.16.1754433653535; Tue, 05 Aug 2025
 15:40:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801190310.58443-1-ammarfaizi2@gnuweeb.org>
 <20250804100050.GQ8494@horms.kernel.org> <20250805202848.GC61519@horms.kernel.org>
In-Reply-To: <20250805202848.GC61519@horms.kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 6 Aug 2025 01:40:37 +0300
X-Gmail-Original-Message-ID: <CAHk-=wjqL4uF0MG_c8+xHX1Vv8==sPYQrtzbdA3kzi96284nuQ@mail.gmail.com>
X-Gm-Features: Ac12FXzn6xC3GEWZwV8GpsWb-o1g1X9WA5sVZ0frXqURB1sH9fEGM06GbVjXWic
Message-ID: <CAHk-=wjqL4uF0MG_c8+xHX1Vv8==sPYQrtzbdA3kzi96284nuQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: usbnet: Fix the wrong netif_carrier_on() call placement
To: Simon Horman <horms@kernel.org>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>, Oliver Neukum <oneukum@suse.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Linux Netdev Mailing List <netdev@vger.kernel.org>, Linux USB Mailing List <linux-usb@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Armando Budianto <sprite@gnuweeb.org>, gwml@vger.gnuweeb.org, 
	stable@vger.kernel.org, John Ernberg <john.ernberg@actia.se>
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Aug 2025 at 23:28, Simon Horman <horms@kernel.org> wrote:
>
> I have looked over the patch and it appears to me that it addresses a
> straightforward logic error: a check was added to turn the carrier on only
> if it is already on. Which seems a bit nonsensical. And presumably the
> intention was to add the check for the opposite case.
>
> This patch addresses that problem.

So I agree that there was a logic error.

I'm not 100% sure about the "straightforward" part.

In particular, the whole *rest* of the code in that

        if (!netif_carrier_ok(dev->net)) {

no longer makes sense after we've turned the link on with that

                if (test_and_clear_bit(EVENT_LINK_CARRIER_ON, &dev->flags))
                        netif_carrier_on(dev->net);

sequence.

Put another way - once we've turned the carrier on, now that whole

                /* kill URBs for reading packets to save bus bandwidth */
                unlink_urbs(dev, &dev->rxq);

                /*
                 * tx_timeout will unlink URBs for sending packets and
                 * tx queue is stopped by netcore after link becomes off
                 */

thing makes no sense.

So my gut feel is that the

                if (test_and_clear_bit(EVENT_LINK_CARRIER_ON, &dev->flags))
                        netif_carrier_on(dev->net);

should actually be done outside that if-statement entirely, because it
literally ends up changing the thing that if-statement is testing.

And no, I didn't actually test that version, because I was hoping that
somebody who actually knows this code better would pipe up.

                Linus

