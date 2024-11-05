Return-Path: <netdev+bounces-141925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B7E9BCAA2
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 11:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2CCDB227A9
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF20B1D3590;
	Tue,  5 Nov 2024 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mb2ztlcD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEBB1D2F5F
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 10:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730803174; cv=none; b=i1On5HjAdA+NaVBm7CpO9GG3E3AtuHhOo5WIKIxlBqCa7tqxITvMjDuSxI4EuA5FJr/S6bpWHBIRLYpf7PsrhtT6TBjTjCCcBVCUuzMmSK7y64th3wdHLUk6aprIL0qVXHWcp4TWsvZIKd5gMmTwNKstM9xQm46jMl0Z1HumO8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730803174; c=relaxed/simple;
	bh=KU+uMhIs5+aXwiR+8gG4Ri3H9V0BNXCiQCPucnKHRWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TVJd+5VWEU+UZ/TUywVVNKMA3Pw085SdAbKoy05lBZ9j35M2ZoBzuX5dOJ/NzLWbTFHXG7noye8bwqKgC7y71kaVM6TzhRYxCQDE99j9YjsoH0Hpz9PpUJs9eGJVKrvEro4w5SzXNHr3EW74UnVpVDjDuW3ethcejVuybaZOOCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mb2ztlcD; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5ced377447bso2994622a12.1
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 02:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730803172; x=1731407972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KU+uMhIs5+aXwiR+8gG4Ri3H9V0BNXCiQCPucnKHRWM=;
        b=Mb2ztlcDZ2fHzTWxDan0/DD3eJvA8FEWviGoG2IGebeaEak5bjdMJFHaazLAVxAnIc
         BOCiu7SKUGljmtMJNUQPhVeMWHL4pr129olfMXwcSfVBhVE0zS9Gomitb5WTbmVkZdEd
         nBYU7uMkuT/206ccwNDimPq+H7Izty39uvsBjxgtwBSZFxWgyMtZNjQt8vq8rJsy6WoU
         L7IU3K8kxvBQXP+q5611KeUGf++tJQallN+c5VCPzYZVnRHld+Epamh/Zj5UZoXy9akH
         9JrSPl2oSK11GhU/5hUQkAjNSMyN2QWqfRAY8tk2iU/siDF1SXNDZmwDlHojaMwd4nQF
         tO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730803172; x=1731407972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KU+uMhIs5+aXwiR+8gG4Ri3H9V0BNXCiQCPucnKHRWM=;
        b=K/f4ExmoFAJi0XPOByRftFSSwjEJ9rzRB8E0z3+uzu4vVoJ4tr1RBR7aTQvgKgq9wh
         ERQxhfwwkZpbT8D7Fk8fl9zJ3+B9LO1l2VqsD9dKhp7HdJk68vBlaKcVvkwmnBkbPyxA
         SIHQC6W+fhl+jb1LoQUQuAM0R7lRRjPCTkROnbBuHHlialJnXrFsII91fvnM9nAFja2T
         9E8QfkJQmxvs+lbTPxHW2qSDo1tQ648pcDOQrV9195260vi5tSXZSJMEhs8lFSEgO97O
         uXCyKtIsdjCWcjiWelVHA8sRlox/jRcwZ2eFcXNpyrY+4N2uy/Mqe9pteutNMBfRjzoC
         PjdA==
X-Forwarded-Encrypted: i=1; AJvYcCUY7mbvhf5RxKUSZrg2mkjoowdreppgx0fp3CkieSjpl9LH0G4kKNCe2Xg4cXwMUbKFeOCFi+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg5Owt1ZC3cr2GOgeDWKONi18kxLxNnhSrVHXJtGpFr+0V7AYA
	LJUgo07l/I7EJF/2ARZMmvnZ4pdH4qhDLd+80GcutcxkDYWO1rgaLzaKsWmbz3waIriujRz5ETo
	kN0lbudxi8dkO4Vs/k2jypzKVlWTBcOeJGErP
X-Google-Smtp-Source: AGHT+IGZnKI5+Lvku26G92TrE6D0i3XW1EEPSm3WU5PBbm+xjbwSTv4Hor+W0gSiR2PVCRrFXx5M6sItBcjgN4oiKjQ=
X-Received: by 2002:a05:6402:13c8:b0:5ce:d277:a5bf with SMTP id
 4fb4d7f45d1cf-5ced277a5ebmr7634941a12.16.1730803171521; Tue, 05 Nov 2024
 02:39:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105020514.41963-1-kuniyu@amazon.com> <20241105020514.41963-7-kuniyu@amazon.com>
In-Reply-To: <20241105020514.41963-7-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 5 Nov 2024 11:39:20 +0100
Message-ID: <CANn89iK8wJegAHmECLUZ2Nq4FHmWC0a4EJ8=88LjKu=Gu5Hqhw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 6/8] netkit: Set IFLA_NETKIT_PEER_INFO to netkit_link_ops.peer_type.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Daniel Borkmann <daniel@iogearbox.net>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 3:07=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> For per-netns RTNL, we need to prefetch the peer device's netns.
>
> Let's set rtnl_link_ops.peer_type and accordingly remove duplicated
> validation in ->newlink().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

 Reviewed-by: Eric Dumazet <edumazet@google.com>

