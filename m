Return-Path: <netdev+bounces-236700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA2CC3EFCC
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 09:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3797188C6FF
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 08:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862FE310768;
	Fri,  7 Nov 2025 08:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4OF3KzRg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAAB2C1580
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 08:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762504780; cv=none; b=G6XuksCEvJpEGOBn+KbjEFUxtQii1I5rx/0EwrXizrEaZWwolyOkQcOCY/E5W7dk+hYTfWhlqlVEjXB+GeftsjJnTj6628vca0QsjY7xQgTaFIFdvqbp7kGrIoFLY1Iyhm+iTC+0JWWVMmb7cV4QD7e+H4euYPrBhiq5jF5HoK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762504780; c=relaxed/simple;
	bh=kYVE45xpcC90+XTYvaEHaf0WQiEfCqI7QosfDY/Pvfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5cAGZ2BaR9fATz8XpXbho2kYAtMEIi2KlNWWufey5wSV6I8CjWncise7q1zPTg2y0OLfhR8/tcUcOxZA8+M0QfUhPyjsmVSl4fxFiCYKu+QrqFUtXJ6+kdiEdx9cRFDxHWXfwBJdkMYdh6DFRoubGHedvaraS9bvJv3LoUZQQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4OF3KzRg; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4e4d9fc4316so4399051cf.2
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 00:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762504778; x=1763109578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYVE45xpcC90+XTYvaEHaf0WQiEfCqI7QosfDY/Pvfk=;
        b=4OF3KzRgkOvYfrSC6Pl/EhBdDcFubURBmY1n9Zqgj9taBwzkepLLpwmS4mKfXh29rG
         ngb96Is3bacRymizEWLTpkkA/ZzfZ8zXJj/WIbH4ZF763cIjSiTaQeqwkoAklrz2Cq7u
         TBhFksxt87k7D8D3k0SRin83ZQXwgRehYjtMGDuId56i7KNJJz2GY0Ki0g5qegavVWhY
         FaTZNbxkcNSgT6ljOr1ZoDUBURv2gwD3+si1lkRV/Bv3ZAmJx86AO0GiYe/hpzYc4SCk
         0mHuJJ774/wux9iR7bpTJsh2vmtBEObnUrlaqoQek4T9203uFDqGlcNrzKMr9BkQy1zI
         PRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762504778; x=1763109578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kYVE45xpcC90+XTYvaEHaf0WQiEfCqI7QosfDY/Pvfk=;
        b=E/j0zSQlO5IvaSeRco7lS0O5tBEUDCRfssK2SEZ56psZiNE3hEWMWf4QbB+mhEe2QQ
         GRx2/SbY+w4730HgCSTN6f+puHVuAs+Q0TJgV/5SHSzmiT0Ca6MpDRv8g3U15RAAI6hC
         JsOQ98sIFQYRurp4j5BQzuPQ4p9o4djo3rgjWCe0LsOrD7IgRCOYKdRpy9PnlsjzBWhV
         MMlIKznRw8NjVvlR/jAwyoDzmesAG28cFcLE7/ONcC2BLTtPBZk+zUvcfoG9r8Gzgq4e
         z49JSpQ5R7REJ1jKLjTMimSJ1jyxI5BIC+fCe83uPRcxWUxyeHXC+P/lVJiZdAhK20m5
         //rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd8HivdDlyS332Cq1qUDMUPrhC1YnQ1yp8yLJBwPRz8CMtdreKTPPNyTAbV+RbBkNyRw+AnrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhAR/NRlrIfUKUc1ooee3d9JchCnSLCjWYiIKHAzTTPSi8MvNF
	2nzKb0drpBJzMt8UnqHSe417VH0AIDl+S8713P7nR62oVZDz7dHWqVy/WJSRUyQdMLJyzKf+UUS
	Hj7L/8na8yd4tj34+4zoumViazHSEXb6t4uN9GTEz
X-Gm-Gg: ASbGncusRMctfGD+Fl3B/llfdUBIzPcKw4uIkSmB0uM9miupdC4TfIB5zq6gy0Tx6tx
	gySIk4MvC2rcMI4ROwxg8CRQkQgDdadMFO9BYliZwtmqm4w25e5SD5bJJnyPPJ1WQG/C1xVscHy
	zwKJKewk8CZ92sGLUXNfqN+WHO0dYr5MSoBa7+fPU1Akdk5wl5wxKwWY4rPqT7YAFbCc5cBUDP6
	J7k9eziX/2Q0z7bSvIRIXgl1fLNCqEW9HohHBhJf1XM9k4Qs9QjC6y46PzwwA==
X-Google-Smtp-Source: AGHT+IHbrojSXnBJKENzwsj6FeMBGmlNP99VjtuqLu8+oamkq1eYMf4xpuaFFcIUv90NoMBnb1S4el847tZOPRDfjlI=
X-Received: by 2002:a05:622a:19a8:b0:4b5:ea1f:77ec with SMTP id
 d75a77b69052e-4ed94805f1amr27532541cf.0.1762504777577; Fri, 07 Nov 2025
 00:39:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106003357.273403-1-kuniyu@google.com> <20251106003357.273403-5-kuniyu@google.com>
In-Reply-To: <20251106003357.273403-5-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Nov 2025 00:39:26 -0800
X-Gm-Features: AWmQ_blSmLIAN8RykrYkSdNmh5bJb7yb7W8mJWUASSFcivvY__oEfqpUWdvevvM
Message-ID: <CANn89iJUpAELx3ej0RyNH6XXGE_QDnY_QHiHe6ZXA36usLxgPQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 4/6] tcp: Remove timeout arg from reqsk_timeout().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Yuchung Cheng <ycheng@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 4:34=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> reqsk_timeout() is always called with @timeout being TCP_RTO_MAX.
>
> Let's remove the arg.
>
> As a prep for the next patch, reqsk_timeout() is moved to tcp.h
> and renamed to tcp_reqsk_timeout().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

