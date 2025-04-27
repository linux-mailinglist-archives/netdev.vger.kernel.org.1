Return-Path: <netdev+bounces-186309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5FDA9E250
	for <lists+netdev@lfdr.de>; Sun, 27 Apr 2025 11:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4170D7ABCD0
	for <lists+netdev@lfdr.de>; Sun, 27 Apr 2025 09:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B1B2512E2;
	Sun, 27 Apr 2025 09:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bo6VpUfT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE297204090;
	Sun, 27 Apr 2025 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745747879; cv=none; b=FOcmWhOuW3QhtK4ZIPMYIqhT07+Ke+B+/gJ7bmuf4Qdu8JyohtzeIWsI+MDRBB9PvsIGFSBVn0CV5ErzTiZ4yv8XLtgrZGaJbqklO1X2It8xH3/fuRZlxRp4kDWVNh8rGxkV+aR8xH2H5P49AoTMN4CNyQe00QKc2en/zzTiIBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745747879; c=relaxed/simple;
	bh=l5Tb27Y5vyg3wY4lvkOBbo+U4H8Yv7JXSiafDA/SyBg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NrMMo9DmHw7YvhCH19LgYm18vDoivkFDI58UDmCO0DLyZQmGaOMbkr0yNQg3HO/ok7qf0cd8XyfY/phwuvLnEd01Rn23H9muj24iNE4AxdMhsB8lqkwL7aqVi50ERlAcjrzzrVRWvO11mkodLQvvOChJZp0ukpKOjGj+Ipu8esQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bo6VpUfT; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3995ff6b066so1873409f8f.3;
        Sun, 27 Apr 2025 02:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745747876; x=1746352676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zi8y+KhY8MsuzyCXspyB4bbIiSJsbGXeifwHJP4F24E=;
        b=bo6VpUfT4yINkNVRQ9l+Bl7T3ImZtre+HLFMMvtNzcojeokOtGmBFxOlPPUEhFrhT6
         MIhu2KP6G5IrHFBKx/C9WUCXw82B2fCRax1g3YJJ5EOHVxq6bdJY1Nwvv1LabAr8JaoF
         8IhI4qpE7vNw4GRmFEYOSQY+ZB8bWATqKYqi7YUO1QJvTXNstEKYkR93BdXr2Ctig4wM
         ja2RlzXiH1mB5FT87FPnbqlMwAjJmE10w7YXo+1tpiaTYRCXbxU6Jj3xQJQqFBNHgWsF
         BYffI+kYsPe4Sgte25VUEFsWosALwAxu0E+hHiunqP4EU5ThlIqdQHx3A4CszeE5JU01
         Xv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745747876; x=1746352676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zi8y+KhY8MsuzyCXspyB4bbIiSJsbGXeifwHJP4F24E=;
        b=RcrforHJksy3f7CsdABkmuZdjT49fMU1/z6yCOcVPUCn4DbF4twUmx9BwDlxdhTqlA
         Y2MQBbb9YfPYzVYQT3JpJfjhvZ7j8ispZ6v8L2wjPCOW6fXKUHUvFPKpMYlPf3R37P9H
         nYx13BhxcC3Bnz+YoJDiREEQ941NPe/vtlik0kNotlHZ9kMCK1EsiZP8UdhRZwyUSGyU
         3iFVse68DxZYXaTRVVd40VV+dtBlY9Snu/NjFaHNkhTJsF4NB4oo3/bvx+of+dRAqGT4
         XinT0kjPWosEkuT+ECSC63hodOx8kxy6ycJi/TFFdJ6XR2+60WCkP5gKaXTLM92Of6Nr
         w9HQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCIcqYIE+2Kl8Kt0ZRLwy6wHwUyrAZl9LcZqvBRUtxN+zopwL9UQYxhRDFjNoJW6+mBK1X3fP9PufDZSs=@vger.kernel.org, AJvYcCWNSJhTNQ2B+FREo8hnEkPFUGyjvMIeIfnCcGN/bUVekxbu5u7FP+KcVnAOU/YcIR7VoiPjFf1z@vger.kernel.org
X-Gm-Message-State: AOJu0YyS7MKEkI6aCgmYL+5u/nKGrWZFFC9Ebjw1+9GhSVhUzXpZ67Ml
	Ui9+/wsdBaN4GxS518XwczwtDvL9/2Sm+fv73oK7GZParTZgMx8c
X-Gm-Gg: ASbGnctOkIKDe3uyeqwgm5Q2jPUfTOxXpfRxsuBHZdqKyg4HXWMifTH6JOrI3OAgty2
	yZk2MQVfkVgcjyoyibBHNm3mOmYw7m1lGPm6doHzt+FWLXyayfTKZk7KTtzvRZSlbiIxJb7oI7y
	cqfJmRZlsaEipGnLai0lBsy0kPKDl3mVWIqfpDRyxSx2PlBTHLDBlXggpTYBe+M/H2MiUrnW1/m
	5Q5m5cX+6ZV2djlZiFJG01i73xo/dWGTehOXHhIuRH2JGkKvcreaH4RnhVquaMKRdeS7xYMzTPK
	l9qKOFnYDTkDs1JFKcZao+LblIOBUGYdkKO2J7oMHvL54ovQjzxwW7LzXTozPbZqqPlytRJEFfB
	5AZW02j0U7fPTPg==
X-Google-Smtp-Source: AGHT+IHuYyVGFk9WjYZYs2dMxl6iVkS/EC6ijwaWExOoiJPt+HXv1feQNnbFXAK9zx4qKDIFzeetVQ==
X-Received: by 2002:a05:6000:2283:b0:39f:6e9:8701 with SMTP id ffacd0b85a97d-3a07aa5ad4dmr3931241f8f.7.1745747875550;
        Sun, 27 Apr 2025 02:57:55 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e46454sm7987033f8f.78.2025.04.27.02.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 02:57:55 -0700 (PDT)
Date: Sun, 27 Apr 2025 10:57:50 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Justin Lai <justinlai0215@realtek.com>, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pkshih@realtek.com, larry.chiu@realtek.com, Andrew
 Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net v3 3/3] rtase: Fix a type error in min_t
Message-ID: <20250427105750.2f8efb02@pumpkin>
In-Reply-To: <20250422132831.GH2843373@horms.kernel.org>
References: <20250417085659.5740-1-justinlai0215@realtek.com>
	<20250417085659.5740-4-justinlai0215@realtek.com>
	<20250422132831.GH2843373@horms.kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Apr 2025 14:28:31 +0100
Simon Horman <horms@kernel.org> wrote:

> + David Laight
> 
> On Thu, Apr 17, 2025 at 04:56:59PM +0800, Justin Lai wrote:
> > Fix a type error in min_t.
> > 
> > Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this module")
> > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  drivers/net/ethernet/realtek/rtase/rtase_main.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > index 55b8d3666153..bc856fb3d6f3 100644
> > --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > @@ -1923,7 +1923,7 @@ static u16 rtase_calc_time_mitigation(u32 time_us)
> >  	u8 msb, time_count, time_unit;
> >  	u16 int_miti;
> >  
> > -	time_us = min_t(int, time_us, RTASE_MITI_MAX_TIME);
> > +	time_us = min_t(u32, time_us, RTASE_MITI_MAX_TIME);  
> 
> Hi Justin, Andrew, David, all,
> 
> I may be on the wrong track here, but near the top of minmax.h I see:
> 
> /*
>  * min()/max()/clamp() macros must accomplish several things:
>  *
>  * - Avoid multiple evaluations of the arguments (so side-effects like
>  *   "x++" happen only once) when non-constant.
>  * - Perform signed v unsigned type-checking (to generate compile
>  *   errors instead of nasty runtime surprises).
>  * - Unsigned char/short are always promoted to signed int and can be
>  *   compared against signed or unsigned arguments.
>  * - Unsigned arguments can be compared against non-negative signed constants.
>  * - Comparison of a signed argument against an unsigned constant fails
>  *   even if the constant is below __INT_MAX__ and could be cast to int.
>  */
> 
> So, considering the 2nd last point, I think we can simply use min()
> both above and below. Which would avoid the possibility of
> casting to the wrong type again in future.
> 
> Also, aside from which call is correct. Please add some colour
> to the commit message describing why this is a bug if it is
> to be treated as a fix for net rather than a clean-up for net-next.

Indeed.
Using min_t(u16,...) is entirely an 'accident waiting to happen'.
If you are going to cast all the arguments to a function you really
better ensure the type is big enough for all the arguments.
The fact that one is 'u16' in no way indicates that casting the
other(s) won't discard high significant bits.
(and if you want a u16 result it is entirely wrong.)

In this case i don't understand the code at all.
The function is static and is only called once with a compile-time
constant value.
So, AFIACT, should reduce to a compile time constant.

There is also the entire 'issue' of using u16 variables at all.
You might want u16 structure members (to save space or map hardware)
but for local variables they are only likely to increase code size.

	David


> 
> >  
> >  	if (time_us > RTASE_MITI_TIME_COUNT_MASK) {
> >  		msb = fls(time_us);
> > @@ -1945,7 +1945,7 @@ static u16 rtase_calc_packet_num_mitigation(u16 pkt_num)
> >  	u8 msb, pkt_num_count, pkt_num_unit;
> >  	u16 int_miti;
> >  
> > -	pkt_num = min_t(int, pkt_num, RTASE_MITI_MAX_PKT_NUM);
> > +	pkt_num = min_t(u16, pkt_num, RTASE_MITI_MAX_PKT_NUM);

So a definite NAK on that change.

> >  
> >  	if (pkt_num > 60) {
> >  		pkt_num_unit = RTASE_MITI_MAX_PKT_NUM_IDX;
> > -- 
> > 2.34.1
> >   


