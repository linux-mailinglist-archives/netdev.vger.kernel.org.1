Return-Path: <netdev+bounces-129910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BF2986F98
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 11:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAAD51C211FF
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 09:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C2F1A7254;
	Thu, 26 Sep 2024 09:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CMSv9JmQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB32189539
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 09:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727341671; cv=none; b=kXNRBenGjA2E6XXYi9oZdt6v2o/dyeKeQpi37Wn95iY3Lflxro35SHbfw+lNe+a1hELEtVJWfTTu5Hh3E56aVDx96Dl1oG83ew93vM70eGwPPnVR44iMbom/TX1Sfnw81dOD31ZVg/tMtlVLfOUkdY3p47BeXkqLyedBjrs05oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727341671; c=relaxed/simple;
	bh=D57Sm7PKwxmUZvTSzFhz7oTQjI0KVzM6SWF/LKVZl8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F9hZo1Al7UmR3JKBpNc3R2yTJ6mLncsRlDhY8J6Lw6yG1ZcAK7NbWcig7tBSMQppy+Vr6fT3znol8eqObUkGvGhf4Zdh72Q9Lm5waSR7izJHvVBfj5VGooKY4ZxR5oXxruvmu55hZtD5eKTvWdtz3z+WhhA0+0zvCWb+lG/COSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CMSv9JmQ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c5bca59416so652141a12.1
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 02:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727341668; x=1727946468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oa1E/mb0JNZX7EmVDqAFqz8FvCRelrN1GPTakICMvq0=;
        b=CMSv9JmQSaTn4OTIvixNuMhUkBvrokbIstKj5yDJXvGjYRyjc2jFMG3TLJirDNWKa8
         xk78f27Dlgj9oj3me9lcriCeLrwtCVdKFYZb1I3aA61gi/rpcFUhZrp6HoqX8Ik2YJmo
         2GXFlwxzdMPxLwWQ1ByaUiaD/IwJReBP4o9YJUhz9BYZBoK9MHpa9O2JBfK9++F0oOQV
         ocYBqZPGgNypOJWecfYCHa1nbDopLXQO1udWX9VguMRMisNizwZBxfUptR+I+mMGwyH6
         RwYJpGtEAv3ki1CTbpZaNZ35raZvL/G1/yQZl3hObdpyezPGWtt/j5ScoErzW4OLD5xu
         8GoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727341668; x=1727946468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oa1E/mb0JNZX7EmVDqAFqz8FvCRelrN1GPTakICMvq0=;
        b=PqwN9JGFADs67TDik4a8Ay9qghubmcavD+qEUOtBICb0EmACka39SIaREX8azLxqA+
         SMwyml8cT57SLMsTzrKSJIArE15uJDmdu6zptsOS1CQaqOYtQ/WEW8WU4LVfYl8abBDu
         j3JD3k0KnggwoITRIDltO4Fntoh1731tn4sG7wjnxrAVq/4i+eGQSEBEaqi2xvyvtQwk
         ohJub0w/Zg3PNKgyuqjDZvv0MD469adQuYnjHi/4TScw1nDEqeb6gx35LlkBZY215EKX
         SWg9VTRvEKOjnQhDFJV+fAqzcFBfQho18dl/CXJQC3jSp1ov4ZmEINW6SZOhKbEfgLXJ
         EbUw==
X-Forwarded-Encrypted: i=1; AJvYcCWXbcmHWmJzvNnTsqZsNlUjPU8qDOqmRnXNK3p/OyFPVhjFJsbUmqs15FVxTQFrdeX79xetUUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlFVXx/V9XKBlBNN89eKwhEybA/V9JKJSMtzygLSPV9GgeIwc2
	cYJwUK43Zfv2gVvyVTDX/shvXoMskhAJURgqthHMYAvHaYh9spzdAHHsn7kFNcgfQ9LbDeoBZrl
	mOCRX3nbSHHmK9Ln2GukpEDzaQTBE+Fiiylsv
X-Google-Smtp-Source: AGHT+IFAYJpOBh2T4EI5tKNJrnMXubMaS0UgoFRhHjG4p9skjnKOspQRa61qoZvUezoBUn0vjxDptnHGf4I75bV8A1c=
X-Received: by 2002:a05:6402:1e93:b0:5c7:2279:bccf with SMTP id
 4fb4d7f45d1cf-5c72279beb2mr2672284a12.13.1727341667534; Thu, 26 Sep 2024
 02:07:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926075646.15592-1-lena.wang@mediatek.com>
In-Reply-To: <20240926075646.15592-1-lena.wang@mediatek.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Sep 2024 11:07:34 +0200
Message-ID: <CANn89iKt-0LCJaJS8udObGOKz530seK67ieUgvmxr5woos+hyQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: check if skb is true to avoid crash
To: Lena Wang <lena.wang@mediatek.com>
Cc: davem@davemloft.net, dsahern@kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 9:55=E2=80=AFAM Lena Wang <lena.wang@mediatek.com> =
wrote:
>
> A kernel NULL pointer dereference reported.
> Backtrace:
> vmlinux tcp_can_coalesce_send_queue_head(sk=3D0xFFFFFF80316D9400, len=3D7=
55)
> + 28 </alps/OfficialRelease/Of/alps/kernel-6.6/net/ipv4/tcp_output.c:2315=
>
> vmlinux  tcp_mtu_probe(sk=3D0xFFFFFF80316D9400) + 3196
> </alps/OfficialRelease/Of/alps/kernel-6.6/net/ipv4/tcp_output.c:2452>
> vmlinux  tcp_write_xmit(sk=3D0xFFFFFF80316D9400, mss_now=3D128,
> nonagle=3D-2145862684, push_one=3D0, gfp=3D2080) + 3296
> </alps/OfficialRelease/Of/alps/kernel-6.6/net/ipv4/tcp_output.c:2689>
> vmlinux  tcp_tsq_write() + 172
> </alps/OfficialRelease/Of/alps/kernel-6.6/net/ipv4/tcp_output.c:1033>
> vmlinux  tcp_tsq_handler() + 104
> </alps/OfficialRelease/Of/alps/kernel-6.6/net/ipv4/tcp_output.c:1042>
> vmlinux  tcp_tasklet_func() + 208
>
> When there is no pending skb in sk->sk_write_queue, tcp_send_head
> returns NULL. Directly dereference of skb->len will result crash.
> So it is necessary to evaluate the skb to be true here.
>
> Fixes: 808cf9e38cd7 ("tcp: Honor the eor bit in tcp_mtu_probe")
> Signed-off-by: Lena Wang <lena.wang@mediatek.com>
> ---

I am not sure why tcp_send_head() can return NULL.

Before tcp_can_coalesce_send_queue_head() is called, we have this code :

size_needed =3D probe_size + (tp->reordering + 1) * tp->mss_cache;

/* Have enough data in the send queue to probe? */
if (tp->write_seq - tp->snd_nxt < size_needed)
    return -1;



Do you have a repro ?

