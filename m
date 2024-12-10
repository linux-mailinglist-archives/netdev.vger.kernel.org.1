Return-Path: <netdev+bounces-150559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC959EAA7A
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 09:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 424AB1888C78
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 08:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7783122F3A1;
	Tue, 10 Dec 2024 08:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wH1t2PfG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8E322CBD0
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 08:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733818898; cv=none; b=bJggwvOnN5bd4qr6GVzH4nyz9OltapklYA+VODaf44xu8LL5lh1RRJZMYfYDCBUr91c8YxNVfKF+9rGWDJVqMO2wFE46Bs4fIfLRSjl7sPKn5dkF+pOqdcGe+v7fE80b/lKhsDjCnVu+34gYfp5CNXIJcjmxWERUWzHMIFxTMCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733818898; c=relaxed/simple;
	bh=2xLj5AqCTE5/ZWkK4RfTOBQ2dvNALAvlMD3MNIKBsz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l3OwQDpU0p+YROgO318kVv0m/ocyuFy9VdjMfgd3csX54wzv6yibd9skCDqX7gVoOCp1GCy2J9+2ytBiv29sd1JWrylsOAN0Ky3xZfsCHEmz234jLtMqDnZNNvjzDFgU8CB5I7ts5d/ZujPTHH0YakGGkIv9sjRwuT/g8HWcPGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wH1t2PfG; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d41848901bso1995156a12.0
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 00:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733818895; x=1734423695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xLj5AqCTE5/ZWkK4RfTOBQ2dvNALAvlMD3MNIKBsz4=;
        b=wH1t2PfGCQNhYNkeoBaDo/+RjNyQGJPzAf6LDJtDCRterPxZb87kLJAmFlxWp5XN4a
         FQAPHRrYz6y2N0AXPttus8+HunTkBEaqEDzAa+2vEuqdJdyb7p+Pmv5XmBiOy3h6oVkI
         gekCaU7+bp7P76qLKwUXyWjn4Fg8pNqFnj3bOOA2G0n4cWcLOym+F+8pGzwZeaG9azFS
         pD1xHVhWW5ubXk50DryvuP+fvqCKTleoVV9k1BIjnmXlAHXIIMyD3MPxiJ7m+K8jV3MS
         PfFknOE8CBvirAKKNeMewmB70zoMq2y1D4M3dxqwilRSCx+CmoK8BSlBY9zsal36mAJv
         C4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733818895; x=1734423695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xLj5AqCTE5/ZWkK4RfTOBQ2dvNALAvlMD3MNIKBsz4=;
        b=IYJsHTgkAEanqiN9QvHs3egE2+7796bFfuw5ht33ahi5Vdh+Np+1miO21Qr4kFA1d0
         kx+oYvfoL4jpjaakMYtTB8vx+aEm1JiTQRaQtoE/n05DhI3AZxqc0SkkaB1024jKonIj
         sobj6BFXAwHr1XGnScmfPoaFFFsIWIxJ7f9fMODHvdSlLnJEZJ5xr41jAfl0dYFhw7kM
         8BmbLaIPcID6dHp4eiDOyjWq+a8EVnFa3ZJ/YKvvAkctGmQzHNaBAouKU0u0WYl0Qy8/
         SD1NShnglxvHyVlWpamQ9NI6j+uQ8Y54805GH1OkLp86m7OQgn6YQlMnpExXJVmwIyfp
         Rixw==
X-Gm-Message-State: AOJu0YzZvZ/61YK851YI39trBXTGid1980xsU26D3SM9vqI8yhlvIqst
	NuX4KaHbeRj638v8lNQdXbBli3mNqkomLOaE6Q+1pFZyvzC6Rt8qUcI6GZ/jIBjxl+27isUfYqb
	5QX1j4gICncnB2mHekMIX/iGT3Su1LLd/xnD9
X-Gm-Gg: ASbGncuX4VkNK+uGU3xHsJR7HvXQuEtHtVnJsqZuBvDKvt7hd1Hc4qWdXM95f0EWShM
	cHHWHBoD4/QWRcLZmuJ9GZ4GiYhrvGToGzQ==
X-Google-Smtp-Source: AGHT+IGl5zgCNyScZ2BTbGLKbQd65egk9PIPSccxoWeW78vkdZVwybnW6uN990vpllfQH8UFTKUGuD9Otbibqta4dg8=
X-Received: by 2002:a05:6402:26d6:b0:5d4:1d34:99cf with SMTP id
 4fb4d7f45d1cf-5d41e315b4amr2557123a12.16.1733818894751; Tue, 10 Dec 2024
 00:21:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-jakub-krn-909-poc-msec-tw-tstamp-v2-0-66aca0eed03e@cloudflare.com>
 <20241209-jakub-krn-909-poc-msec-tw-tstamp-v2-2-66aca0eed03e@cloudflare.com>
In-Reply-To: <20241209-jakub-krn-909-poc-msec-tw-tstamp-v2-2-66aca0eed03e@cloudflare.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Dec 2024 09:21:23 +0100
Message-ID: <CANn89iLTfnFeqhpkC87pLg-u1Yqnao6NyidezZA0gYZCONnoMw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] tcp: Add sysctl to configure TIME-WAIT
 reuse delay
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Adrien Vasseur <avasseur@cloudflare.com>, 
	Lee Valentine <lvalentine@cloudflare.com>, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 8:38=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.com=
> wrote:
>
> Today we have a hardcoded delay of 1 sec before a TIME-WAIT socket can be
> reused by reopening a connection. This is a safe choice based on an
> assumption that the other TCP timestamp clock frequency, which is unknown
> to us, may be as low as 1 Hz (RFC 7323, section 5.4).
>
> However, this means that in the presence of short lived connections with =
an
> RTT of couple of milliseconds, the time during which a 4-tuple is blocked
> from reuse can be orders of magnitude longer that the connection lifetime=
.
> Combined with a reduced pool of ephemeral ports, when using
> IP_LOCAL_PORT_RANGE to share an egress IP address between hosts [1], the
> long TIME-WAIT reuse delay can lead to port exhaustion, where all availab=
le
> 4-tuples are tied up in TIME-WAIT state.
>
> Turn the reuse delay into a per-netns setting so that sysadmins can make
> more aggressive assumptions about remote TCP timestamp clock frequency an=
d
> shorten the delay in order to allow connections to reincarnate faster.
>
> Note that applications can completely bypass the TIME-WAIT delay protecti=
on
> already today by locking the local port with bind() before connecting. Su=
ch
> immediate connection reuse may result in PAWS failing to detect old
> duplicate segments, leaving us with just the sequence number check as a
> safety net.
>
> This new configurable offers a trade off where the sysadmin can balance
> between the risk of PAWS detection failing to act versus exhausting ports
> by having sockets tied up in TIME-WAIT state for too long.
>
> [1] https://lpc.events/event/16/contributions/1349/
>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

