Return-Path: <netdev+bounces-218032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1041B3AE50
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 01:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADAAE465433
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 23:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF63262FD3;
	Thu, 28 Aug 2025 23:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkTDJlRn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA6A7261C;
	Thu, 28 Aug 2025 23:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756423005; cv=none; b=p+sGKITGUo0p9kcRb5gi5XsSaMFP7M5sGRQFzLNNbYWertqyvUXf2cLlpHWmmXlfoHPJ2wNp3AC+5dYBVnuJofvemcWH5eqd37mf/GFpfhBAHfRv9EKBxj7vRatJ0RkkoQjtR932RX+lWJJFJHH6UkE+CA8wW1mv+fczh3FRc5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756423005; c=relaxed/simple;
	bh=Vd8OhhGLdE5H/a6lPR672JFiGLvenKd3IkybwtCPxQs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=eCbKQsIR6ksZJP34bRgFhxIRDyzIF31VgO918M2V2+SUg/T4PFmNyvhdcrEB65SDhdGejkQK+A53DiSWAxHfF1R38adEc8mu4QO8jDQhIWFyJbsKzXm/B9a4QttspKlUHfmUW0D859Tui3C0DtlfrAIfJcUfz18m9YUSudvSqpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkTDJlRn; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-892196f0471so517366241.1;
        Thu, 28 Aug 2025 16:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756423003; x=1757027803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlpmZHSZax1exvsNWnWOiFeuEYwXeFAvLTHhNFCwbVI=;
        b=kkTDJlRnddjpFRjZgalbuBLgdXscYgKxXmoAjWytv/4+I3r1pRoYGoycaiCjhIAy13
         JWKAbrGxblXl57Hr6ilUrDcTx5W+CkgaJ9sd+x4PzqxD3zrAB3p9+d2cxmihfJ46gtMe
         ZZcmLrChfkkOE7H4zaxLf3n0hZOLVZ78RVLTYalFj+GJkkuc+SHbAz/bhqq8bOddR/hI
         9VhMsZYDhmcGd2h3pOYhcpIYDtbOpC965OBkctuOkcBuRaqKN2WW6E6uClbGz2OHUeQ4
         zYzKMZ3sI+i4ydEix+WTHgEFqM5lelgNqiueHaRbo8V/wyAA/iciJY7dFAVuQM0DcLGF
         RCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756423003; x=1757027803;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZlpmZHSZax1exvsNWnWOiFeuEYwXeFAvLTHhNFCwbVI=;
        b=b8KukQ47mdBkGKSDBUdrkc2bU+Oxi/AZ8lRezayvRvXognzMsslzqIDk+Lkes/aqV9
         gIUn/CH1SNH18OUieF052uZH2S9Z+UU8q0jjSTTH6lUh9O/cE56aTajLc4QSSpxnFC5V
         lnftqIVBN81OX/ftsygRtuOCxLY0SAeSvJj3CEjeQqEk4mYmzgqv4bJbAN1GST1tyWCm
         dVTpmXcyU1qeoMH/l5SESGkb0eMz4GMey53+IW+Iwo7i9A9a9b4KwkH9QLK1VU9htXLC
         1cJDq4rDT6XGlIYUDUawvrdRmQVxp4dNgXLXCMqxoDEM5zM2zpMMHMlWvpEkE1P9F9eR
         b91Q==
X-Forwarded-Encrypted: i=1; AJvYcCW84HEQQW7WqKMWHfDeiiWgolaPzJykcrMCjf7D+GnKwg7mufSmsHW1SkqSTcgolrLtGolmECcvdzZAH4A=@vger.kernel.org, AJvYcCW9mvtfq7lpwgWy4YeBrN/T+lNpYE2WFWihDuUYCGcBlwTijrt6g8zLpFWME1lJU38oJYOcPEua@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx00HPvME4jWuh4VOWJwxIM3F0N1+VTG0WoWheVnuX6cFCzVVM
	rILPtSSWhWAXpf0ih+lU18cHkvWHd76QHOvv7VxhbYh00amRI/2CXUaC
X-Gm-Gg: ASbGncufikzVvUQHv0dui6cfUk4YSdyI6V/8ZWcVzpU38CQMYBUjcy+PXbDtmRTQmwH
	RVkaj9fIHoD9tsiXG0V9OB9eNLjsWkUyLjAsO3/egFHtpmT42igJRzHkpLgpO24NIigvEDnjJWz
	1ZcY+uk90j3GJi5ecgwLlLrq3PD/cxI5uvBNykU76AheSlXdmhZotYAdXKOmAoGfPLWpnypDlJt
	WzQDRao69yywYZbBqNZ/ImngiQYuZ2BSl4/sN5kwbuOg/Caj8qfedqHN3i805m6I/aHSvsb1lY1
	TKhmuES4LGD7oNZCpJTFMi2qBZ+2mweenao9/KOU+lcUBrZSIIat0KrmA+vKW/9tA+FDfm6pLqZ
	/MnW8aD0TNsACPATkkLjiAXZPfQ20Rzw3nLnCRqFy/lVKTgBPt7fLrld8pmSMUPYewkmvnt9Ym5
	QRhn4tjRRCIcobMKbpqkLWXq0=
X-Google-Smtp-Source: AGHT+IFpsVFIsNUV8H30KjMejEpHOIoG3D/KSdI/bsqbZGIa8pQIS3voetsKUb1fgitUCL0WzPfEAw==
X-Received: by 2002:a05:6102:14a3:b0:523:863d:ece1 with SMTP id ada2fe7eead31-523863df466mr6096235137.17.1756423002650;
        Thu, 28 Aug 2025 16:16:42 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id ada2fe7eead31-529b1b4252asm193521137.17.2025.08.28.16.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 16:16:41 -0700 (PDT)
Date: Thu, 28 Aug 2025 19:16:41 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Xin Zhao <jackzxcui1989@163.com>, 
 willemdebruijn.kernel@gmail.com, 
 edumazet@google.com, 
 ferenc@fejes.dev
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Xin Zhao <jackzxcui1989@163.com>
Message-ID: <willemdebruijn.kernel.801a3a33fec@gmail.com>
In-Reply-To: <20250828155127.3076551-1-jackzxcui1989@163.com>
References: <20250828155127.3076551-1-jackzxcui1989@163.com>
Subject: Re: [PATCH net-next v9] net: af_packet: Use hrtimer to do the retire
 operation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Xin Zhao wrote:
> In a system with high real-time requirements, the timeout mechanism of
> ordinary timers with jiffies granularity is insufficient to meet the
> demands for real-time performance. Meanwhile, the optimization of CPU
> usage with af_packet is quite significant. Use hrtimer instead of timer
> to help compensate for the shortcomings in real-time performance.
> In HZ=100 or HZ=250 system, the update of TP_STATUS_USER is not real-time
> enough, with fluctuations reaching over 8ms (on a system with HZ=250).
> This is unacceptable in some high real-time systems that require timely
> processing of network packets. By replacing it with hrtimer, if a timeout
> of 2ms is set, the update of TP_STATUS_USER can be stabilized to within
> 3 ms.
> 
> Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
> 
> ---
> Changes in v9:
> - Remove the function prb_setup_retire_blk_timer and move hrtimer setup and start
>   logic into function init_prb_bdqc
>   as suggested by Willem de Bruijn;
> - Always update last_kactive_blk_num before hrtimer callback return as the origin
>   logic does, as suggested by Willem de Bruijn.
>   In tpacket_rcv, it may call prb_close_block but do not call prb_open_block in
>   prb_dispatch_next_block, leading to inconsistency between last_kactive_blk_num
>   and kactive_blk_num. In hrtimer callback, we should update last_kactive_blk_num
>   in this case.

Overall I'm on-board with this version.


One remaining question is the intended behavior of kactive_blk_num (K)
and last_kactive_blk_num (L).

K is incremented on block close. L is set to match K on block open and
each timer. So the only time that they differ is if a block is closed
in tpacket_rcv and no new block could be opened.

The only use of L is that the core of the timer callback is skipped if
L != K. Based on the above that can only happen if a block was closed
in tpacket_rcv and no new block could be opened (because the ring is
full), so the ring is frozen. So it only skips the frozen part of the
timer callback. Until the next timeout. But why? If the queue is
frozen and the next block is no longer in use, just call
prb_open_block right away?

Unless I'm missing something, I think we can make that simplification.
Then we won't have to worry that the behavior changes after this
patch. It should be a separate precursor patch though.

