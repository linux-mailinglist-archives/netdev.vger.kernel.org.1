Return-Path: <netdev+bounces-90024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D5B8AC8AD
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 11:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7516A1C20AA6
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 09:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41F2537F5;
	Mon, 22 Apr 2024 09:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjUhWVop"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE355644F;
	Mon, 22 Apr 2024 09:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713777498; cv=none; b=tGBXS6INWEZQ2H9//jtMWNB8LA61HDuVhy3Oe5N7UCm0GwoaGtmKsoP4/txRnJtrh6y2A2OkVAHrnTZbVYV1O6x7QZpvQlsYKL6jBq4n3YJ9Rx1NwkAFBPD+aoAcqjBWwv6yYIoKQ3m26I/E4BvKpnX87EwofbXyUG4RwrUwPrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713777498; c=relaxed/simple;
	bh=lxEcktRM3o1u22clJI+gdENckYYwX0xCiMNHeF4WEiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tnwKpX87PHI8vthmQwoeghqh9j1n4gdaqyM9GLwqmp3LOP5ilA9E721PWPq7I894ueQbmCrUEnzK0DTWtCB84aXgE8t5+MCDlN/qzP1ForaGKj4K05Ol+kzZzKS+8qgWfHS1ULjkBUq9zEY0M+A/rZVi4nt5Jt2VFrB/Ewy0+xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjUhWVop; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a55b481cf0fso95922366b.3;
        Mon, 22 Apr 2024 02:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713777495; x=1714382295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVwqwhtjvlZszt9bRT54ZI824MgakHvK+s8hVXWfzLQ=;
        b=VjUhWVopj4sdyFa6PZR5vjvsJ5e4v4RsA2owidq6q6qTLRtzmZji4Op9f2hWmG7agg
         4ykeYVw1P8WsZKyXpypVTz4OyGGJnWn/h2/jm11QyI6L2lsZlP0nAGqGPZEaEm9w+mNl
         s2/9kgA4sDDhe1zvPlhpxKfExTrMiNmkPxdm26Xp0eDaWIfuUfAUnaXsxyfbOH4RR+ad
         LjwKQJbkpEruZfr275E/fLBzTXhvEOzY4xGw6uGOaMInITnUwNoiZGB/KAJ5julED9GR
         TyUsiytazKujkMfABjuqV2+KS9rH42se3t/HhDE7QhkZFZ/a1le9dvWrx+sNyXRzVybb
         MoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713777495; x=1714382295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVwqwhtjvlZszt9bRT54ZI824MgakHvK+s8hVXWfzLQ=;
        b=a7D/8S48vMkbBmTYWtrh3Vz3D33eS0YsHbnWunvF2LdW0aLEbiqxJrUKJDASj3Mvm1
         yvzo2cxu84DhJ1a2x/Iu24Q4/eKUOgY2Q9KyPpNSpoBnHgeYx5V8355rYXPw1arCvi5u
         IVDkLHBxE0F8jejJbZC/MvAJhRlC6Fo78srvQ2evxsV+gY5NVf4mTP3yIjQiG0lsW53R
         j7svB05HiqNX0bjrSRv/fBfhpG8U6OaJP+GVW/9ob/tS7xmusWxBWjkcDnckKQ9L87rL
         QnS8aHAGzIsToOLqxHLGIulE/9sjmHq7I7yvhVqHeGGHy/hLK8AFQXr6jyMBm63yM9Ja
         bdvA==
X-Forwarded-Encrypted: i=1; AJvYcCUYnl4OFo9wVAnQZsKnyhfR9lKv3jVyMk4FgezNDPlCef+E6cklmdJYId+cvy5neCn5iwbOw7lUH3ci/SSfMspv3Di0SyVVrUMi3FsZxUf7jtPtYOOaHnDcP1O1FDz5vtZYsO7S7QJV23ZH
X-Gm-Message-State: AOJu0Yxf+DGddyz4P9BFPorAmJ8QgpnQZjPCdkfkbXaQnYIt4J/zI92Y
	Ge6jUt+vOWtBnxkguMJ0f4mKPx+zjNUyNoIPDix1rCOx+nc4hBngzCIJ6oB1mGbrSJo4+BI23/C
	d/9JJRjPaBvaVrK3hU9QxWA3xxa0=
X-Google-Smtp-Source: AGHT+IHv6eCluYziBGpcYsO49wKQF/pXyNdctQ3vZj8mdPKj4PxQNwwBYVRfwy5VlGKSnU5FVg6/hvwrwSLU6IGhtY0=
X-Received: by 2002:a17:906:649:b0:a46:cef3:4aba with SMTP id
 t9-20020a170906064900b00a46cef34abamr7016502ejb.75.1713777495027; Mon, 22 Apr
 2024 02:18:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422030109.12891-1-kerneljasonxing@gmail.com>
 <20240422030109.12891-2-kerneljasonxing@gmail.com> <4f492445-1fe3-44af-bbaa-bb1fe281964e@kernel.org>
In-Reply-To: <4f492445-1fe3-44af-bbaa-bb1fe281964e@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 22 Apr 2024 17:17:37 +0800
Message-ID: <CAL+tcoBRtE0ikv9xiUoWq66_WcysF7QwGggTMwiw793qXxKH8g@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/7] net: introduce rstreason to detect why
 the RST is sent
To: Matthieu Baerts <matttbe@kernel.org>
Cc: edumazet@google.com, dsahern@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	atenart@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Matthieu,

On Mon, Apr 22, 2024 at 4:47=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Jason,
>
> On 22/04/2024 05:01, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Add a new standalone file for the easy future extension to support
> > both active reset and passive reset in the TCP/DCCP/MPTCP protocols.
>
> Thank you for looking at that!

Thanks for the review!

>
> (...)
>
> > diff --git a/include/net/rstreason.h b/include/net/rstreason.h
> > new file mode 100644
> > index 000000000000..c57bc5413c17
> > --- /dev/null
> > +++ b/include/net/rstreason.h
> > @@ -0,0 +1,144 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +
> > +#ifndef _LINUX_RSTREASON_H
> > +#define _LINUX_RSTREASON_H
> > +#include <net/dropreason-core.h>
> > +#include <uapi/linux/mptcp.h>
> > +
> > +#define DEFINE_RST_REASON(FN, FNe)   \
> > +     FN(MPTCP_RST_EUNSPEC)           \
> > +     FN(MPTCP_RST_EMPTCP)            \
> > +     FN(MPTCP_RST_ERESOURCE)         \
> > +     FN(MPTCP_RST_EPROHIBIT)         \
> > +     FN(MPTCP_RST_EWQ2BIG)           \
> > +     FN(MPTCP_RST_EBADPERF)          \
> > +     FN(MPTCP_RST_EMIDDLEBOX)        \
>
> Small detail: should it not make more sense to put the ones linked to
> MPTCP at the end? I mean I guess MPTCP should be treated in second
> priority: CONFIG_MPTCP could not be set, and the ones linked to TCP
> should be more frequent, etc.

Do you mean that I need to adjust the order: 1) tcp reasons first, 2)
independent reasons, 3) mptcp reasons ?

Reasonable. I will do it :)

>
> > +     FN(NOT_SPECIFIED)               \
> > +     FN(NO_SOCKET)                   \
> > +     FNe(MAX)
>
> (...)
>
> > +/* Convert reset reasons in MPTCP to our own enum type */
> > +static inline enum sk_rst_reason convert_mptcpreason(u32 reason)
> > +{
> > +     switch (reason) {
> > +     case MPTCP_RST_EUNSPEC:
> > +             return SK_RST_REASON_MPTCP_RST_EUNSPEC;
> > +     case MPTCP_RST_EMPTCP:
> > +             return SK_RST_REASON_MPTCP_RST_EMPTCP;
> > +     case MPTCP_RST_ERESOURCE:
> > +             return SK_RST_REASON_MPTCP_RST_ERESOURCE;
> > +     case MPTCP_RST_EPROHIBIT:
> > +             return SK_RST_REASON_MPTCP_RST_EPROHIBIT;
> > +     case MPTCP_RST_EWQ2BIG:
> > +             return SK_RST_REASON_MPTCP_RST_EWQ2BIG;
> > +     case MPTCP_RST_EBADPERF:
> > +             return SK_RST_REASON_MPTCP_RST_EBADPERF;
> > +     case MPTCP_RST_EMIDDLEBOX:
> > +             return SK_RST_REASON_MPTCP_RST_EMIDDLEBOX;
> > +     default:
> > +             /**
> > +              * It should not happen, or else errors may occur
> > +              * in MPTCP layer
> > +              */
> > +             return SK_RST_REASON_ERROR;
> > +     }
> > +}
>
> If this helper is only used on MPTCP, maybe better to move it to
> net/mptcp/protocol.h (and to patch 5/7?)? We tried to isolate MPTCP code.

Roger that. I will move the helper into protocol.h as well as the patch its=
elf.

>
> Also, maybe it is just me, but I'm not a big fan of the helper name:
> convert_mptcpreason() (same for the "drop" one). I think it should at
> least mention its "origin" (rst reason): e.g. something like
> (sk_)rst_reason_convert_mptcp or (sk_)rst_convert_mptcp_reason() (or
> mptcp_to_rst_reason())?
>
> And (sk_)rst_reason_convert_(skb_)drop() (or skb_drop_to_rst_reason())?

I agree with you. Actually I had a local patch where I used
sk_rst_reason_skbdrop() and sk_rst_reason_mptcpreason().
Interestingly, I changed them in this patch series due to the function
name being too long (which is my initial thought).

I will use sk_rst_convert_xxx_reason() as you suggested.

>
> > +/* Convert reset reasons in MPTCP to our own enum type */
>
> I don't think this part is linked to MPTCP, right?

Ah, copy-paste syndrome... Sorry, I will correct it.

>
> > +static inline enum sk_rst_reason convert_dropreason(enum skb_drop_reas=
on reason)
> > +{
> > +     switch (reason) {
> > +     case SKB_DROP_REASON_NOT_SPECIFIED:
> > +             return SK_RST_REASON_NOT_SPECIFIED;
> > +     case SKB_DROP_REASON_NO_SOCKET:
> > +             return SK_RST_REASON_NO_SOCKET;
> > +     default:
> > +             /* If we don't have our own corresponding reason */
> > +             return SK_RST_REASON_NOT_SPECIFIED;
> > +     }
> > +}
>
> (This helper could be introduced in patch 4/7 because it is not used
> before, but I'm fine either ways.)

Good. It makes more sense.

Thanks,
Jason

