Return-Path: <netdev+bounces-235923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28845C37291
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 18:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7EE9188D0A8
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 17:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D67338939;
	Wed,  5 Nov 2025 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J40xNsLy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3423009DD
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762364684; cv=none; b=FLDXPWsVwS1N33XPuFvaIkJKf4eyDmGNZIPpMC9VZwZb+bRLOeFWTsndJQSeSI9OlPIiJMq4KEyn1Viv0ozEaTRSG3ZLZiGcEn3kZ3PjEJXTfhCjXZAtE4l5ifTqG2NtEzuVWXd31gzE+Gp7WZdkxpjeIdYvU1hERjsBUy3mHxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762364684; c=relaxed/simple;
	bh=HUkuOvaJBgzglKmoQ0+qkvFukOe5dDQ3E3jps5qH8yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rigGZSWFAu3ME93+fv+gBXr9eTpTh4btqKlAYT5oQMRzrtQZ0ercVeAHXvX5DXAjMNfgafzAGlMtJnM7nKOmyYoYeILcpQx7r8vkDZi2KIUHUF80EaFr+CDUyVpvDsNrnXSqucgoagMzBUII3ctmzoFhkacHWBo+veqrDmJtxM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J40xNsLy; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-58b027beea6so22e87.1
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 09:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762364681; x=1762969481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUkuOvaJBgzglKmoQ0+qkvFukOe5dDQ3E3jps5qH8yg=;
        b=J40xNsLy/P3FH9ngX86nNzMKjkxfEccbIIBTI/ybiGLyBW/jbl4CuEQp0x2CEK7Anh
         3uaBzM2wz+AgVij7CWDHh4YOyKQj02OPu4ge/KnsIJPWcnoTxMjei28fxOFOVrPxjWvd
         1tsO0kv+ctxdr6SunZ/lhvTbcURPGC788zVeRY4lQsSuYXHJ9iUN6opOL5ICAYUO/u0/
         1drGwyuHnmJ3a9TiajQU/83cLDH1sNIfLkvKbDD9p1RNkj+GzEetgot9O2J6sntLO1Qw
         FmC6b/idfm9ycZYIVoxDBi6DuCBOaSEYienFsiRgDFUNAS/7FgzWc/eO5VyazcBTXkFL
         5yyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762364681; x=1762969481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HUkuOvaJBgzglKmoQ0+qkvFukOe5dDQ3E3jps5qH8yg=;
        b=c2VU3cSERBgQNCoW/9Mm55Fuq9h/IR7fRb8/JEbgzuzlHEsOHtVrAR6oy3jnH7ik4e
         DJof8idEwK2Ebe25WEBtYlwFS29vQXQaBE3RkeMS5cd5v7ypK6TL28b68XZRpEzYT1jZ
         JmVMPo1z3deii/dqBFkL/9D4FsB5+9H44GoveIwvGUM5yADX8TlZiqftUxDk53Rt0R6k
         E+FLQWPXyrdpQFU5xHGyxL/swttNpEFD9aFt/4qFyzaYKTrS7CiuvpZi0Nh6OVQnE0n9
         Qkj7VX7H9ZhO0qC5mbxmBO/hI/1aFBPTupC/K30obXAoOgUCS6CYGcpHkBWvhI4RebQU
         HTIA==
X-Forwarded-Encrypted: i=1; AJvYcCX+5R2JP2nTMZtnKQcOX7yzdYZcbqE6Sa43gL+Uyi3SVfBHn9jkar1nQ6di3/erzfAB+ZYqKew=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsgM/7V0gPD+e11jlOScl58szA4YWNW7qApbu064Iauw1puL3Y
	/Pu1YhnuH0nVz3dxEprfY0lP5I/MBDfk+cYAFaEl9DuaSOtAdFcM1995h41yddP7Gm1ozuN58Uz
	tvhgS9bI8jjn2TVAEz1MwqXzriVVnrni7UOVfJvGl
X-Gm-Gg: ASbGnctInntqughSKW6mbEUQDUTw0UwYzcFoKcLtNeZR4dGrgXpCeK+uBcBiksBqvN3
	aII8AlELh/hwfKp9uSye4hqOik5HWVVQFseXoc7gyCGBJ6UH4EkTXdf6ZE3NVHgmJU7BPeKCi1a
	sKnnaoq9S1/lhPCkta16t1GaA5UW5TsMThwzgNNJpOvE8hKDGxbhjFonRlPLpx8w6jONLAcHeTC
	tsAmP45jM12KdhREa801gKw6sYEy87I3xOce3J5uqE0D0GAJ5pm6l2UGemoCv7ul6iA0FJ7N+cU
	sCYsbFXROE5qbqU=
X-Google-Smtp-Source: AGHT+IH/OofWVZO6t+ABXcpC0vTR/s1RGUpbRd9qbTsriVnGknn3XRKBHSzmxdu2/OyTuJYhBxIZQv2+pBEj17RuTlQ=
X-Received: by 2002:a05:6512:5ce:b0:594:2644:95c6 with SMTP id
 2adb3069b0e04-5943fd37dd8mr299460e87.7.1762364680964; Wed, 05 Nov 2025
 09:44:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com>
 <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-5-ea98cf4d40b3@meta.com>
 <aQuKi535hyWMLBX4@mini-arch>
In-Reply-To: <aQuKi535hyWMLBX4@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 5 Nov 2025 09:44:28 -0800
X-Gm-Features: AWmQ_bmalEOFVEMViz4jCYnQSNwi-DTRPOf8GHyJIDjQOr0wbo_hnqMUoM5NhB8
Message-ID: <CAHS8izNv89OicB7Nv5s-JbZ8nnMEE5R0-B54UiVQPXOQBx9PbQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 5/6] net: devmem: document SO_DEVMEM_AUTORELEASE
 socket option
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Stanislav Fomichev <sdf@fomichev.me>, Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 9:34=E2=80=AFAM Stanislav Fomichev <stfomichev@gmail=
.com> wrote:
>
> On 11/04, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> >
>
> [..]
>
> > +Autorelease Control
> > +~~~~~~~~~~~~~~~~~~~
>
> Have you considered an option to have this flag on the dmabuf binding
> itself? This will let us keep everything in ynl and not add a new socket
> option. I think also semantically, this is a property of the binding
> and not the socket? (not sure what's gonna happen if we have
> autorelease=3Don and autorelease=3Doff sockets receiving to the same
> dmabuf)

I think this thread (and maybe other comments on that patch) is the
context that missed your inbox:

https://lore.kernel.org/netdev/aQIoxVO3oICd8U8Q@devvm11784.nha0.facebook.co=
m/

Let us know if you disagree.

--=20
Thanks,
Mina

