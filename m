Return-Path: <netdev+bounces-149137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7128C9E474D
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 22:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DBAF284894
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 21:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7910118FC83;
	Wed,  4 Dec 2024 21:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YM/fuyd/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983B91925B4
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 21:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733349502; cv=none; b=b7Ckh5+qy9m/E8dIQW3Nv+yIspFHZv2CB0U9LJdksp8BLUmAzg+pGMH4gXh10QiQ/TPKDuRMlG4FrT5pYDPmv6PKA+Fac10V2pGoD22gWyIVL9D8RgmfGoHX5pbXMKjWA+ntIdn0qWB+yy5bHKAL8SgrC0bSxtBB4ycwFzdLco4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733349502; c=relaxed/simple;
	bh=YNU8dUInl9AZqwZ37UDnNRSpRh7LTzNeuRcGGlg7F/E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YuknCgCtS/IWBhQ1HMYSqZqW/y1eG/8lvJH3NUJgKkbUTkYBEySVdxagSnQvslqmXRz8iwQtquzDDBcIkHfcPs5JYSdQyGEPB9FHHbX52vgF4uSy54AjruLfGfagOUYr6ht+ObOwEJu+6iB0039NPumkRSsVj9gzJssiSw3llqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=YM/fuyd/; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa543c4db92so41688066b.0
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 13:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1733349499; x=1733954299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Co7uzDnHgh2YDKoN9WoWe1UJ0uiY9Mm/vQX5j9kVtAY=;
        b=YM/fuyd/z8SPlphL+Hy7U4wPvzAZIRkSPOpZbT5JaOyrJrzknuZlcyyLU9/fQB4iGm
         Oq0muDH3Im+/ZHpD5dcbLbPG1buqNjeOjfhQzmbICQSJBEirRuX4VFR/sqwVjg4kcWdj
         smYgRez0LzEnEyTalO9Cxn4J18rQ66Ushyz7mYlEcQSLKOU4FRYF9IEIHMB2YNTGqVc1
         5DCh3slnUM9O8twZUnQ/9q1k9m6GK0I7SikfIsB/B0rOuuw9xx9KQ1Pi8CSmYl5DMujz
         J/GaCpQAZJXVxpm+ImvmVD+UJw2fMlbsp5kqFk+8x6YcEi+wOrSGMbF9D1QZHdrLcd9I
         uY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733349499; x=1733954299;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Co7uzDnHgh2YDKoN9WoWe1UJ0uiY9Mm/vQX5j9kVtAY=;
        b=VoY+TdX1fMp7Cbjrrde+xOrYt56fJUcQea36NoT32VbDnI2xzMx7FcHzBMogSK7wuF
         NnGO08XpZiAg77qFbhYNarMdQRBfvWWUUwVWJ1hIQ7wWCqVkirWpRHRJPTMZQ8tslnzE
         7Yxf9fMYTmsl94DDQAKSLEMsGsMqKXcrQY04VZ/4NfmUGVTYXMbt6L0yCFQtWYl7lOoj
         hbwYh5YdxhMavtPHQsXKIY26vr223Pohc2yM2uSiN+QNB3SDbIqEhWnjjZ+POUeMCndJ
         514GJAxaaNUeZ06z6DXN/JRuxHYcCJqA5okLjzV1a+gDJx+o/KZSRsxXTy7GTnv5XJZ7
         /kvQ==
X-Gm-Message-State: AOJu0YxddiJClEFW8oeFgPLN8AZgEEu3Ks3WE3YCT7/JLkIggY4pKrla
	x0xNfK9+FE2J3f8eXbzxGBLCDGTIBNSX3PX+ogSSI7nQ2a31kZ7Lt5PEfL4U5WA=
X-Gm-Gg: ASbGncuz9Ll6hralw5fN6wk2T47UF8yObVxx7iuymSwzfOp/1NB6joIQGkyCP3olxIT
	W2dN9uYBbCOr3JoFqoWECJqRGKZdaaslxmMxrASHeF9TXN5zIezCXt9gtKF1Fh8f1z/T9t/9Qnx
	S/SA/Mf6dZMz7IGu5dvhV/tbUTr+wMAJB2vbtEget95tTREnQwKnvh30DrOoFF8S/5Qb9DWQMAR
	GqWyOfu5b5MhiW6U8PDiPEQaBwWB2n15jsWbFL7sQ==
X-Google-Smtp-Source: AGHT+IGYSf4AzfGABf0jNyjn5A6fYtPEq4D39rnv6Co6YgRHOLftKPwlP8kur3B/zexT8mKyKO6vlw==
X-Received: by 2002:a17:906:3103:b0:aa6:18b6:310e with SMTP id a640c23a62f3a-aa618b63362mr198410766b.38.1733349498779;
        Wed, 04 Dec 2024 13:58:18 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506b:2dc::49:15e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e58e0asm6653666b.5.2024.12.04.13.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 13:58:18 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,  Jason Xing <kerneljasonxing@gmail.com>,  Adrien
 Vasseur <avasseur@cloudflare.com>,  Lee Valentine
 <lvalentine@cloudflare.com>,  kernel-team@cloudflare.com
Subject: Re: [PATCH net-next 1/2] tcp: Measure TIME-WAIT reuse delay with
 millisecond precision
In-Reply-To: <CANn89iL5oE79_qtNUFFsyxLXoJALJCZgawsubuvn1XOcOuOzFw@mail.gmail.com>
	(Eric Dumazet's message of "Wed, 4 Dec 2024 20:22:36 +0100")
References: <20241204-jakub-krn-909-poc-msec-tw-tstamp-v1-0-8b54467a0f34@cloudflare.com>
	<20241204-jakub-krn-909-poc-msec-tw-tstamp-v1-1-8b54467a0f34@cloudflare.com>
	<CANn89iL5oE79_qtNUFFsyxLXoJALJCZgawsubuvn1XOcOuOzFw@mail.gmail.com>
Date: Wed, 04 Dec 2024 22:58:16 +0100
Message-ID: <87ed2naz5z.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 04, 2024 at 08:22 PM +01, Eric Dumazet wrote:
> On Wed, Dec 4, 2024 at 7:53=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.c=
om> wrote:
>
>> A low effort alternative would be to introduce a new field to hold a
>> millisecond timestamp for measuring the TW reuse delay. However, this wo=
uld
>> cause the struct tcp_timewait_socket size to go over 256 bytes and overf=
low
>> into another cache line.
>
> s/tcp_timewait_socket/tcp_timewait_sock/
>
> Can you elaborate on this ?
>
> Due to SLUB management, note that timewait_sockets are not cache
> aligned, and use 264 bytes already:
>
> # grep tw_sock_TCP /proc/slabinfo
> tw_sock_TCPv6       3596   3596    264   62    4 : tunables    0    0
>   0 : slabdata     58     58      0
> tw_sock_TCP            0      0    264   62    4 : tunables    0    0
>   0 : slabdata      0      0      0
>
> In any case, there is one 4 byte hole in struct inet_timewait_sock
> after tw_priority

You're right. <facepalm> Thanks for keeping me honest here.

I must have checked pahole on the host (Ubuntu LTS kernel) instead of
inside the dev VM, which shows:

# grep tw_sock_TCP /proc/slabinfo
tw_sock_TCPv6          0      0    288   28    2 : tunables    0    0    0 =
: slabdata      0      0      0
tw_sock_TCP            0      0    288   28    2 : tunables    0    0    0 =
: slabdata      0      0      0
# pahole -C tcp_timewait_sock
struct tcp_timewait_sock {
        struct inet_timewait_sock  tw_sk;                /*     0   256 */
        /* --- cacheline 4 boundary (256 bytes) --- */
        u32                        tw_rcv_wnd;           /*   256     4 */
        u32                        tw_ts_offset;         /*   260     4 */
        u32                        tw_ts_recent;         /*   264     4 */
        u32                        tw_last_oow_ack_time; /*   268     4 */
        u32                        tw_ts_recent_stamp;   /*   272     4 */
        u32                        tw_tx_delay;          /*   276     4 */

        /* size: 280, cachelines: 5, members: 7 */
        /* last cacheline: 24 bytes */
};

#

Let me pivot to the simplest approach then and make use of that 4-byte
hole in inet_timewait_sock. (Which I didn't consider either, so thank
you for the idea.) This would save me from having to touch the PAWS
code.

