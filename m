Return-Path: <netdev+bounces-171072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F22A4B59E
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 01:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328FA16C108
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 00:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D2329CE5;
	Mon,  3 Mar 2025 00:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuT/FqIV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330AB18EAD
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 00:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740961522; cv=none; b=n6YXpv+CV4RtLlaFfFrsT8oJd3J0fiGq2obYouxerNW6mcKbE+TEb6cEYcTwbMiItTynQili+6ZAxyPw6PCeYemfmYEaSQruDqXOaYBRgE0mfG/eOrF76MpOmj+Ec7cIqhJWzAHjp8RozqaPNbd5hqEQ9U75DAUvUYSUojLZ7ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740961522; c=relaxed/simple;
	bh=58TJ8EoxadAkcTsTyigvQTG/MAvoWBug6FaBFudwPnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mGhCy41n3lvaBT0aHW3++e+w2tOKz8LNm0lqCmrtGHqK8bA6PRWbY/fLJzBGYYCIWiquwaV3h/9v3PpO0raEFSQ9liFvyQJ+xJZxrZzZ7JLjgMXcOg+0DdaDbRNgFj/z/SAnur5jKByliUSFG7zerQrHFkc+ehCXalqHL/Dtdgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RuT/FqIV; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d3e00676fdso13043605ab.0
        for <netdev@vger.kernel.org>; Sun, 02 Mar 2025 16:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740961520; x=1741566320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58TJ8EoxadAkcTsTyigvQTG/MAvoWBug6FaBFudwPnc=;
        b=RuT/FqIVEZphmucpD5M3LRm3cbEf+u0rtS/hik6r6GHGwVA5akTX2rKJRzK8CN+YE6
         yb3qPh7lPDBdIN1zARh79K5Br2OlUnMbfSB7Z419Vrn/7MSm7McjtS9ClBuMj3fFF1NB
         DJUVOYnidP89NJgtTz25KcKlB81pP8RaXmPnEeWjoF4BtN6Wr6lT+GUcZN/A9ddtp+3W
         8AK/2X/b+syt6d5CPH4FtmVOBx6tgsqpk/o1i0kTl6qOBtX0vH5DmdHoWaA7IbIJHM7w
         3/UHQvxbu9tWbB0JDUCTggZ7UzuU/Ypkj4eUdNwH7WBmb9PNsaz1nL4vNtrTHsx7X4gi
         7hug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740961520; x=1741566320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58TJ8EoxadAkcTsTyigvQTG/MAvoWBug6FaBFudwPnc=;
        b=cQgKolWclN1w2gSEGjyn6XE805JWnDx23KDgEVH7Y8jN2G47Qw31FJx6YUxaKs4Jve
         SdrNo+DgNkadg7ZTln21r1uE8+zhJ3eiz/USkjbB2McyjRZMxC2lTgh5AItEwis5z9bQ
         XUVHQl04ef/MM7Gpw0BdQagyP5unZUiLADtdnhONUyUfNXMD0GtkAQ5JQXovpqmCU4sw
         i8p7W0BH8t0fvid/3ZO1QDjX+r6en1RxEwZ231U1+9xubKUMjBX9UJwYWgNU8piRhxtq
         vNqFVvchitlGhy09QkH16vuP36r9T2hCXojgwKweTiiaT/S+oP3YK/+4kPnV4l99GnYo
         Zyxg==
X-Forwarded-Encrypted: i=1; AJvYcCUxgKJeNfeLf7qR0XURfI8KBJUxFEEtbiu9Dsom522sOT0Fj8oCtmmvxL48Xw+0HrT4suM/LhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFiz8QVKGdY4Xj1Uii45cWcbpunVwmzVRWCKeF9nJNLDfkLK9n
	HalKvAwZg9KPn0HHwy1izTEtlTFqFeV0VgoHDz6zGYpDsHdI/+MpI567Q+sENRV+AatWIUZoN++
	z9poGgaYpYXWxSiS+agXJqYZsNQg=
X-Gm-Gg: ASbGncu4vdD2GLI/sQu6cXwMAU+rI+K5ZDS4mPW0tNJnfQMlTIHcvkpsUoLKugDXPYP
	JlDIbjxIsJQbR6nYagesYoV9EqWPik3allc/QpD+5aEAqGisKzHTJjswKGFj2Ea5PjaFuGAH2J1
	q8b/Yh8QjS/hYnpBLvXZSKMhTqqQ==
X-Google-Smtp-Source: AGHT+IGtKYvwtSURMHFHhNR60ZiVlNB264Z0NjL9Bg3oQGmkz+vy0Ihw7HcIc3eu5hzpPnHy0iZMoAjOyLLJq2YsMA4=
X-Received: by 2002:a05:6e02:1382:b0:3d0:1db8:e824 with SMTP id
 e9e14a558f8ab-3d3e6e435bdmr98487325ab.10.1740961520252; Sun, 02 Mar 2025
 16:25:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302124237.3913746-1-edumazet@google.com> <20250302124237.3913746-3-edumazet@google.com>
In-Reply-To: <20250302124237.3913746-3-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 3 Mar 2025 08:24:44 +0800
X-Gm-Features: AQ5f1JoP0703VXMPLzCQQeDY7RAAJjZHxDhvE-ehSu6lGCg4JgZA0u4ot0tCRp8
Message-ID: <CAL+tcoDR=RoZnsZ+e=fOi7VqVNGMHoqAYst+Gqca19esXw7gbw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/4] tcp: optimize inet_use_bhash2_on_bind()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 2, 2025 at 8:42=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> There is no reason to call ipv6_addr_type().
>
> Instead, use highly optimized ipv6_addr_any() and ipv6_addr_v4mapped().
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

