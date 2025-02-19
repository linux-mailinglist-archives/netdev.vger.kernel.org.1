Return-Path: <netdev+bounces-167904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BC1A3CC7E
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 23:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361B416EC1C
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 22:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7182425A322;
	Wed, 19 Feb 2025 22:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FxFzkK8T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E982825A2D4
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 22:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740004676; cv=none; b=qN/8JuRNt33lo8xfFN0pWdrUeEGW1q+fx1xg1z7XhYpO88MwGshkYuRPwuVJlyXquJFTeWkTdBKIkAF5Ki1Xow44zaDoemWYSGSH1Lw034oaQCMxJBQPr0rFn7be1qjjhHG9PqLeJ8fW6qHb02TDU6uwW4JUZjzlUVsor6y74zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740004676; c=relaxed/simple;
	bh=hhC3wygLORR7zsQGDIm40sQTPhR9KgGwxGKhnkJUH2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVZg+DIv0Qbokse0ktYlqHDUQ0KhzGSjyON72OxMQOrd6JvEBmjQHli/zkiCIZNGJlJBhDOyUliF9zXdmrfwb34rYTIRrXkTBqZIFsUwFFO6IJWHOpAGbDhDXLdasNRvIMHMFEmYrm8szVlhRYStAo/q0mubh1dFRVzsv3/T6R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FxFzkK8T; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-219f6ca9a81so21765ad.1
        for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 14:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740004674; x=1740609474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhC3wygLORR7zsQGDIm40sQTPhR9KgGwxGKhnkJUH2c=;
        b=FxFzkK8TDjMNIhLyHbRwJrY1oyAwbBO8K3biZQlohguwAfElOrr20O1bh70oFEtOkP
         6E4m14vtwU9lnRhh4B21zyb65wvybOnUZSQt1RXr/jAUXqfpMm9BNMjCQyV+pFa90RUB
         l9X/84Iy1tgBhDNrCYqAfWgKEaiJuV75gYwuO91tfpOWbbLbiPKkb4VO33o3kmZKNk8y
         0MA24y15gfRHwadSztUXjDL0zCbTgtr4mNZVnT3iJchkYwVsx2eyw3BnhJ9ABSbKkUth
         RhQXsnxmqCzmCR+btGg4O7/9JeVquLWz1SKNUHCHNOYXesQNEcMJcnmwe/JpI5xLd6Yz
         ip6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740004674; x=1740609474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhC3wygLORR7zsQGDIm40sQTPhR9KgGwxGKhnkJUH2c=;
        b=HBkDTEffskXFcvgIOsWgX9CxkfRhdFqzUX+zOp+dl8xxJILLaYjaBKWxd2SgwVN7Lo
         xm8gnLWWMqyYOyf+0JybJloBHEcD+m5U0qf+aIhsSV9d78MBVvL6KaNAsmaJ4bLuV/Ww
         UxPt5n8JiHxf/rYcsPI7wJ1vXNzq2W9DMkqnzdCVGvCxiT6BdyjlU1w8lu7lPdRYtYwT
         it9KGvGOFBZRlgcam7g+c12+L5mF+rxPdH6HgUyVxvDjNPn+KOCsSFZBmT+3zf1mONuo
         q4tx+vjG7p56NHxQmHKPapBdS5CwsbVEjcPgDqm3Gv45B4mLWddky47K+Xn5W4SG+e+N
         PzeQ==
X-Gm-Message-State: AOJu0Yyu9H5VyOF9KGkqbYhQOi4P26XjtWqWHYrPW06/+dAVGsYF0+lj
	wr2902pd1zwtIEOaGadODdOhu3xDiWemS5lnW+PBDb209ot0tGoMQ4fXrDY+vY9gYsnIhn3NT3s
	5SCl9X+BQ7GIMMR5/oI+/+KYggkdGE8S9ul2c
X-Gm-Gg: ASbGncuvEjB7F/dnQBEzvu8VHCt4E/Sc2JIPfrA7SIG4BcP1wpGENgtXNyB2bP53aZo
	NHJTCanBDDrHesATmr5sLUDTHiEGzLkCyPdbokFBCD+TODPSopfyX82zLSo8gBa1NuDZtIty8
X-Google-Smtp-Source: AGHT+IF0adqp6BJMWWYjgKq0IW4QVon9hnaPRO4nKLT+UDkOqC0hTXFQIJZpY/Iok7FAftfcxyKvXkHOsRQJ1NFPF64=
X-Received: by 2002:a17:903:2289:b0:21d:dca4:21ac with SMTP id
 d9443c01a7336-2218db4dd79mr890985ad.6.1740004673917; Wed, 19 Feb 2025
 14:37:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219203102.1053122-1-sdf@fomichev.me>
In-Reply-To: <20250219203102.1053122-1-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 19 Feb 2025 14:37:41 -0800
X-Gm-Features: AWEUYZlrz6Rk78gsxnJsp41gH0btlBHazQiyiMfwOnDCCxkT-y3JHO_r-_Y-uqA
Message-ID: <CAHS8izNWx39025Hm=cY6JDDL-VY1ggKWsx0+RvD-NCHULTT7sQ@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: devmem: don't write truncated dmabuf CMSGs to userspace
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	ncardwell@google.com, kuniyu@amazon.com, dsahern@kernel.org, horms@kernel.org, 
	kaiyuanz@google.com, asml.silence@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 12:31=E2=80=AFPM Stanislav Fomichev <sdf@fomichev.m=
e> wrote:
>
> Currently, we report -ETOOSMALL (err) only on the first iteration
> (!sent). When we get put_cmsg error after a bunch of successful
> put_cmsg calls, we don't signal the error at all. This might be
> confusing on the userspace side which will see truncated CMSGs
> but no MSG_CTRUNC signal.
>
> Consider the following case:
> - sizeof(struct cmsghdr) =3D 16
> - sizeof(struct dmabuf_cmsg) =3D 24
> - total cmsg size (CMSG_LEN) =3D 40 (16+24)
>
> When calling recvmsg with msg_controllen=3D60, the userspace
> will receive two(!) dmabuf_cmsg(s), the first one will
> be a valid one and the second one will be silently truncated. There is no
> easy way to discover the truncation besides doing something like
> "cm->cmsg_len !=3D CMSG_LEN(sizeof(dmabuf_cmsg))".
>
> Introduce new put_devmem_cmsg wrapper that reports an error instead
> of doing the truncation. Mina suggests that it's the intended way
> this API should work.
>
> Note that we might now report MSG_CTRUNC when the users (incorrectly)
> call us with msg_control =3D=3D NULL.
>

Hmm, this happens when the user essentially lies about the actual size
of the buffer I guess? So the userspace does:

msg.msg_control =3D NULL;
msg.msg_controllen =3D 100;

If so, I think the user is giving obviously invalid input to the
kernel. I think the user getting MSG_CTRUNC here is fine.

I prefer if we handle this edge case. We could have put_devmem_cmsg()
check for non-null msg->msg_control so we're absolutely sure the
resulting put_cmsg() doesn't fail to find space. But I don't think
it's very critical to handle this very invalid input from the user.
MSG_CTRUNC in this scenario seems fine. So, FWIW,

Reviewed-by: Mina Almasry <almasrymina@google.com>

--
Thanks,
Mina

