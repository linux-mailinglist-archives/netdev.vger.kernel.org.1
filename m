Return-Path: <netdev+bounces-79924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A7E87C0E1
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 17:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 570AD1F21088
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 16:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9539273523;
	Thu, 14 Mar 2024 16:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgoyzyB0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A97B7350B
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710432126; cv=none; b=FuWRC14wKGUmKWsQ3XI2JK3fOl2PiMf8CB3wSrGrX8RQ4qQvL/JojGx43thiU/eGOfaHEnLKWgP53CyEhiP4fk1Ki1+Q19n1RVZkGGP02DgBsqoHvvRHm09eVXil2kHWi0jhXj0VNv+qS0LfFhl5qmjFE4R3AUJDYuAjCco9mLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710432126; c=relaxed/simple;
	bh=c/ipFzJhg0c/eeNB+U2doseto/l0abYFAE14DqjI7CE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=PS4bnku2nThCN+Dtgr0ncqfVpiAvsNprGvXWDBbRHEbrzYtUVAIE+6gzwpMjJU7QBi1Bf1eMe78rSjGbkU5bStxMgth5mQuZSLLdG9K20ZflOYpIIqruT916IXxSmAvnaIjUByeSwlH3zR6RrAKmYK0jG4LWcAkeuAORVjYpNsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgoyzyB0; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-690ae5ce241so5296996d6.2
        for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 09:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710432124; x=1711036924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/YV+zEm7yc5le5uyqHIlCJh3ru4lQDiP33odZXAs8Q=;
        b=TgoyzyB0XtRcA6sxfWKnoJ8NXxUzViQHVW0FZ2jvA1xPlMF/e01zh4rjIv7yNMcoV0
         8EZh/tT5EAxV8o5QFWsJhNwEaW7nC4LS/qmcbBX5Qspbwj0L94KOAQQw6xl6rLgIdsST
         uYqG75z76PaKiQbQ1yrkpjLW0c5jm7rz88soTGOmzpzeDD0CEWMj5q24c4MU3JhPGjyA
         48SOQHM3RoeyhgKh3VmX8v7LkvlizkUxT3C5pfFKwF9O5vdX8gPpK1mD6ZVKrdkUvtjZ
         roji6LGVgpqN8QIEUZIPqFcy/fIbm64J3GWcaqsZQemklDv0HDRx3pyT+9RRersEYA6N
         YKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710432124; x=1711036924;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L/YV+zEm7yc5le5uyqHIlCJh3ru4lQDiP33odZXAs8Q=;
        b=K7NcDmpzJAqyPOTPf9vTCOFUojmvxgVWtsXyyrP+poUqPVtiiC2a7Qd9bM/TCUvEto
         OIHtf1hoo52llHVS9DavNucKiwQaav9ff62+yqDvq4PhNQf9Gh+9QvEBjcHm3eKQbEoG
         J5OyW3vO8mdWqjUnVTQerECVzUc+ZdV178dD2ilCG7nXeQExcDvaH58SbHp8DhJ4RXtx
         Du4rJNemQe8bgwj4ZTbYmT6m/SGvsZSc3Ko/cz6dhFp6z3N1i2qoZwUkNHwM9x6s3j6M
         CBuVH2BwcSJcaM1vwTh8Xy1E49lALm3bQSxhtCsae9IKSbEXwsP0nWx7ObgZ3nGbLki3
         8ZRw==
X-Forwarded-Encrypted: i=1; AJvYcCVot37HMloj7eaSAZ9l3AQ778AcckC48awwy64736UWzasQiC5qiqrpBmch91DaHOoW0c2u0h8TlLaRZKw5gjvLhIXMA2mT
X-Gm-Message-State: AOJu0YwsdOe7bBwzZXbOJEMhTjJvkT1c4gInfYEyrAiqNJ03rCshVMee
	H2sgzpZARqtzyqYMVI1fihGABO7YzyMf+4Kz0LogtCd6ppqUIJbj
X-Google-Smtp-Source: AGHT+IHZYqkjmbUYsbWDkdxGDdsze69xgVIbfzZnGa8SC+S6pGTf882FbbOsyQGYohjWl5dtBturmA==
X-Received: by 2002:a05:6214:5154:b0:690:d5d3:c48a with SMTP id kh20-20020a056214515400b00690d5d3c48amr1189043qvb.13.1710432123746;
        Thu, 14 Mar 2024 09:02:03 -0700 (PDT)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id dm16-20020ad44e30000000b006915ee02a0fsm478405qvb.0.2024.03.14.09.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 09:02:03 -0700 (PDT)
Date: Thu, 14 Mar 2024 12:02:02 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 syzbot+c669c1136495a2e7c31f@syzkaller.appspotmail.com
Message-ID: <65f31f7ae1138_3f9d242945b@willemb.c.googlers.com.notmuch>
In-Reply-To: <CANn89iJVrZ0bT2V0VkmhNnfe=uOruOMWvaya_WcNe-JmtAJSgw@mail.gmail.com>
References: <20240314141816.2640229-1-edumazet@google.com>
 <65f318db70f3f_3f8f5b2945b@willemb.c.googlers.com.notmuch>
 <CANn89iJVrZ0bT2V0VkmhNnfe=uOruOMWvaya_WcNe-JmtAJSgw@mail.gmail.com>
Subject: Re: [PATCH net] packet: annotate data-races around ignore_outgoing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet wrote:
> On Thu, Mar 14, 2024 at 4:33=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Should we also include a WRITE_ONCE on the fanout prot_hook:
> >
> >         match->prot_hook.ignore_outgoing =3D type_flags & PACKET_FANO=
UT_FLAG_IGNORE_OUTGOING;
> =

> This is not needed, the variable is not yet visible by other cpus.

Oh of course. Thanks.

Reviewed-by: Willem de Bruijn <willemb@google.com>

