Return-Path: <netdev+bounces-101916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9775900977
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 17:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B812817C1
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 15:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A105015D5C5;
	Fri,  7 Jun 2024 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dGcO8Fsg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199AB10958
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717775075; cv=none; b=kWQ07AwyGh4JmMMnlhHjSC/LQ9wpXolNN62O4jnycNy4+RdSVW6GLZr5FAYbyeIziKbeBrjlhtBz6nLLtACxfSbe59VrR8292os60Yp8UeoQGiMAW3KdQ478O/+ZLy1HnL8IUJrpUdboGD6yKZFdWCbBaZ+IhDj5zx1JvrbQJ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717775075; c=relaxed/simple;
	bh=yMGAp0Kygg8CTOoseU3Y/4DD11PAamFw3zE7emtyky0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPl4/klYygohLAFfPfnZyDSo17/Hy8crlUlVx/njuClWH4J5rTOv2PDFByedA/nYlq1QG/OUkStsaU3GYnAX4OE+ZHiyGN2DCsgCVOUssquQeUdpYI34DMi0TZ9n4z20bxLkDKIVehcmW5gGORqc3hh9IJWm3GXTsEnmneWf9ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dGcO8Fsg; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-80aca0fbcffso601739241.1
        for <netdev@vger.kernel.org>; Fri, 07 Jun 2024 08:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717775073; x=1718379873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMGAp0Kygg8CTOoseU3Y/4DD11PAamFw3zE7emtyky0=;
        b=dGcO8Fsg1c70gbOl+SLFnIAcc921HZmZnECYK0ZjXq1wWVRR20m9i3ZGvO4o2HpXs9
         QBZUG3VZRDNhHaP74BMafOO1c8inGDe1zBU052d2ZzK5kNw6u5PNYJ6Yzgnhx9fivgdG
         6cFH6iR0Jm1+R8I7BUlpL08YmX2i0CVLcJWGn3J3UWU6zNMORTlxc29s2nW9nAOCSDBZ
         lPlpicGyb8c2/E91ZPppniPFweRNnc0LcKY2YVcW9yvXW5Ak+IDXJS1XyVsT/pvLOtkg
         zJ8UqDabK7s3NNv+CPaTUuKz3L7r8W9Y1oM/bR5dEJEwQNQEXeN9/y2+U2c2CKRd1jo4
         iC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717775073; x=1718379873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMGAp0Kygg8CTOoseU3Y/4DD11PAamFw3zE7emtyky0=;
        b=umcNfEHOYim19UNiYGllwwG7d34hbrH7u2tmTksvd2hHu4MwtitpHDQsTiKajZBpJG
         lfbAPTgFjCID+Vz3q8BrjI3zKWAEz+KiWciq4GyroMVgNtQkCkjxt4K9U0uI+phg6h7Z
         cOJo9wP9JdL+9r9b63GbSnC4uf7j/LbG/jgw2IVehm+r210qO5lg/0sffhgISE55PYX1
         FdFGEadCQZh3suTDryqdTQXQIz/ungs9i1cBVTMv3X7fm8p8ofIaJBAVDgV74zJDsCpA
         0ds86KkO+JateeQmwDuWctMBaJe//OJAzW6Tk29R6rwyqkgflbqG6SGrexHYRwkGLMek
         Kj2w==
X-Forwarded-Encrypted: i=1; AJvYcCVZVktpesHvvgKGIb+8cqOlPpnJMarjdbPx/sZERpqnyii276MbU+crOrpWj5WVGn3VAw8jUAAphQwAQH0N1AgJTxQjRZpw
X-Gm-Message-State: AOJu0YxWJkG5Jr+NnLVPPwox7KqvqSU9PS7g8a5DFJnLWMoxY7ZRP7Tr
	l6zsOlYRPWESi/H0WUHjw1F5l9/yGHZPbBR+BBpzgG3Do6p+pFWOGwOOj+GvTr+BvSdiMekx51T
	2lOXYmYV92g/eWbEngKXmAU25YbJJ64N0ljHh
X-Google-Smtp-Source: AGHT+IEJYddlANsTQAROvEGF9TbsWVI/ZkjDkocdc49XqEGzYJaXxGpc1EnoQBSo3iitp+4LIMHiPE6Aeg9DCwU0bA4=
X-Received: by 2002:a05:6122:12ec:b0:4bd:32c9:acb with SMTP id
 71dfb90a1353d-4eb56255baemr2927586e0c.7.1717775072655; Fri, 07 Jun 2024
 08:44:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607125652.1472540-1-edumazet@google.com>
In-Reply-To: <20240607125652.1472540-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 7 Jun 2024 11:44:13 -0400
Message-ID: <CADVnQy=nfRoHMG63sU5OdtiZk4ZgUh8Jk_3ngOTe9hz7bX5MHQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: use signed arithmetic in tcp_rtx_probe0_timed_out()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 8:56=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Due to timer wheel implementation, a timer will usually fire
> after its schedule.
>
> For instance, for HZ=3D1000, a timeout between 512ms and 4s
> has a granularity of 64ms.
> For this range of values, the extra delay could be up to 63ms.
>
> For TCP, this means that tp->rcv_tstamp may be after
> inet_csk(sk)->icsk_timeout whenever the timer interrupt
> finally triggers, if one packet came during the extra delay.
>
> We need to make sure tcp_rtx_probe0_timed_out() handles this case.
>
> Fixes: e89688e3e978 ("net: tcp: fix unexcepted socket die when snd_wnd is=
 0")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Menglong Dong <imagedong@tencent.com>
> ---

OK, makes sense. Thanks, Eric!

Acked-by: Neal Cardwell <ncardwell@google.com>

neal

