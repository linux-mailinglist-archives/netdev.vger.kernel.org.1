Return-Path: <netdev+bounces-214461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33446B29ABB
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 09:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBA5C188AC50
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 07:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DF12797BA;
	Mon, 18 Aug 2025 07:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxsXIkMB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621D1277003;
	Mon, 18 Aug 2025 07:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755501713; cv=none; b=HqMbufL8jQJ0QIBPjqru6QUvYJNbbHpa2PvNFGIEv+qaeONrycOdF2BTcQ8UxrA7xeWvymv9P8JEh5TD72XmfOj11e22T9a5Mkt7kboQZurOhfV9T6DOWq5dsDD2TJwe8STe8E8MpGmiNAqERG9B6peJxoGV1YT+LqNr7tnKvD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755501713; c=relaxed/simple;
	bh=/BtiaWufGv745HxKQFDqsb8jsnG81e9Ce+10BvTaGuM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ozfndvEVRO5YGIoERSewMKQI4zokqfuYB6RdAL6OdElgOqFNSEfVxNcvqjMc+dA5HE+uGf9X6F6Py/yfEMZbuTGKjSCaEiMTU2QABcShFCo6wL6ydD7dysBi/3C6jAUk5d2ykbfAXjgMI+txKl9ozXX1XARTLCRk6MGH1bLGwAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxsXIkMB; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-89019119eeeso2446828241.3;
        Mon, 18 Aug 2025 00:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755501711; x=1756106511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHFXyUt3leg1BGZ0tamXMaIXMoDBzTv4rnSqhAAmL4g=;
        b=MxsXIkMBus6xkepwdt8pn74o9RRhPsb7owdNTQeuCyEQcaj1ZmCfMogwdUX9l3YMA2
         HOFNr4hEiozhYP5vL99Oa4DSA9XdW3HErd6g8wN8liwQWiwol8BMIWrb0zMPN0xGhLcq
         c7LSxS+t2U+G/nOdsqYYDuu8NLgttrOyCfdORX/CyIOd34NWArAexJjORM2algy6Q2JE
         wzu/wSjHdFe5m1os7MQiDTQsiBWUrhF6/ZD3nFk9uvxjvlHaM2LzScrU44k48GxCzZ/y
         pkz3y2m2kI1MwWj7z1O7a3SVyhc7p19BxVGJNmfxatQdqyW3JtoUQopy9WDNYrvHVQ+Y
         yY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755501711; x=1756106511;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KHFXyUt3leg1BGZ0tamXMaIXMoDBzTv4rnSqhAAmL4g=;
        b=BfrYIBJcuKdFWFBjMq/AbzF/dOm0XhlutcjwTIxGiUgxTcEWqCJXs1SYmCchtwd6za
         0pjPrVibWPVJ9GDm1rBUD0iuajhB49PpQ6ckBqMjt8kXlIvv1hSX0GN1+F18QEPM3v/8
         vmiqKvwcdLjfPJEp5hDI4fcQnr1ZPEGO6cRWzp0JyHntyVNJT5VpnNVx6V8Ov9mcmR4r
         x73pahb+2lTfGZUmmF0bkNUYqEgMR0RkDosHmZud7dm3XIGqxwbT6JfUKi1ffwcvFAaF
         cmPEbEZ3VQNUsWzheHHIfaYDCwRbweAst7Va0s3mrEJOdGLLqb96p3ZrJ6WCBUNZj/hk
         UDaA==
X-Forwarded-Encrypted: i=1; AJvYcCXB7FdKEo33CxrzDzgzzu5yEu0QadIFLKw0z63GDqIo4/orVb5VqeTsHGLR8/9knfTGtpPpReU7@vger.kernel.org, AJvYcCXKp8UUhaTeRTGdr+E9ZfYOxtwDtrq/gppOjCLU10UzQ/yiM2UK6b3PvjP22zX1nilrS9IKoZ2uyyUHMCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9gDP16a71qORKIuR0X04rnHPaNgB4RTQkHnggq+7nhCwt14hN
	KV134em/3Q/4iojr8rqDeJa4XtpxQu9R7oyf3TYaZ1wNnjagKBhdczkt
X-Gm-Gg: ASbGncui/ADBUtjUER+wbGhCkH5fyUy+YqSNErLixqOThOGRmduWeBtzA9pkV4vrjBO
	H8102XTxFCQwaje73djimj5cZWOst9L25Tpa7M0wA3U4AaHw1U53ZxSMjhn7/mBHJ2QYCF07Pmz
	AFmU54NJnWacNz8FJer2cFyIxBP3c3f5YxLp+rGNa/YWI3GqxtgiTyU2ub7NTVdlbeIh0Gg/LIw
	4BMX6/V97UqWwGO1u6hurXm7cM+3AwgZL4MjefsCsqTIUBxKrVAt62J/UXxkYAhBcIidi0XVVs9
	WAup9Vk7gElGFu93gPwTWfJE+7TE5K40YppHq3SO0kyv5Ta3rHtXPrGVb0KrA1OZ1hANEeNbf22
	Q2W515OpuqrDySOz1Poy+U/KUUyT/6u1HS3yL3bFkB23ow6G5OgUsKNoX0X9jTCEc1cZofw==
X-Google-Smtp-Source: AGHT+IEQUdL5Q0g5+fMjAjQicVoHeASR8xzT5+O53vNCH3QG35YM12I5rAPbqzXVsxcubKmGqkXVOw==
X-Received: by 2002:a05:6102:2b82:b0:4fb:dcde:3f9e with SMTP id ada2fe7eead31-514c8b65e84mr2592576137.4.1755501711162;
        Mon, 18 Aug 2025 00:21:51 -0700 (PDT)
Received: from gmail.com (128.5.86.34.bc.googleusercontent.com. [34.86.5.128])
        by smtp.gmail.com with UTF8SMTPSA id a1e0cc1a2514c-890278d40e0sm1587912241.12.2025.08.18.00.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 00:21:50 -0700 (PDT)
Date: Mon, 18 Aug 2025 03:21:49 -0400
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
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.2db2cab231dcd@gmail.com>
In-Reply-To: <20250818053811.181754-1-jackzxcui1989@163.com>
References: <20250818053811.181754-1-jackzxcui1989@163.com>
Subject: Re: [PATCH net-next v3] net: af_packet: Use hrtimer to do the retire
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
> On Sun, 2025-08-17 at 21:28 +0800, Willem wrote:
> 
> > Here we cannot use hrtimer_add_expires for the same reason you gave in
> > the second version of the patch:
> > 
> > > Additionally, I think we cannot avoid using ktime_get, as the retire
> > > timeout for each block is not fixed. When there are a lot of network packets,
> > > a block can retire quickly, and if we do not re-fetch the time, the timeout
> > > duration may be set incorrectly.
> > 
> > Is that right?
> > 
> > Otherwise patch LGTM.
> 
> 
> Dear Willem,
> 
> I have adjusted the logic in the recently sent v4 version by adding a boolean variable start
> to distinguish whether it is the case of prb_open_block. If it is prb_open_block, I use
> hrtimer_start to (re)start the timer; otherwise, I use hrtimer_set_expires to update the
> expiration time. Additionally, I have added comments explaining this branch selection before
> the _prb_refresh_rx_retire_blk_timer function.
> 
> I apologize for sending three PATCH v4 emails in a row. In the first email, I forgot to include
> the link to v3. In the second email, there were no blank lines between v4 and v3.
> Therefore, you can just refer to the latest v4 version in the third PATCH v4 email.

For the future: do not resend a patch within 24 hours.

And do not resend a patch with the same number. Again, follow the
documentation I pointed to before.




