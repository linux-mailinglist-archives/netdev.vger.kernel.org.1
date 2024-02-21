Return-Path: <netdev+bounces-73564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D15085D1E7
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 08:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7972869B8
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 07:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3143BB4C;
	Wed, 21 Feb 2024 07:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MG2SETAs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7683C3BB46
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708502166; cv=none; b=jXPgfkKavvVUfv7JJNApi3srwl03W7UvFiUX7djTtjOFv4h24eqAkB/VqUEPz5U+/AgnA+MwBcDdTBclvELjyS/lQGA3f4veRMQgc4XLJAuMWqWESlibfLNv3lBmashetH3f861J5tTZoaUtQ2cHBFWD1vYSeQOaOWg2D+VFXL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708502166; c=relaxed/simple;
	bh=YzYwl8YMGXua6CQa68UF9a5u/8CEn2EQrELUkuKJmDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/5YuOz1P9O0WA76tocsICIzZRK5K99dRz/ipVCRZBYZmvvtG+kvjnWleMjwovcwXB6RnLVKPoZdfPKfjDBFWzwCDBpj4nZGMPpvTZQwKxJutN+XyODezSESIpAXn38Y+nwXRfzjyRJRksBdKRUYgEwRlDAXiRSr2idZJHBiiuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MG2SETAs; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5650c27e352so810a12.0
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 23:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708502163; x=1709106963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzYwl8YMGXua6CQa68UF9a5u/8CEn2EQrELUkuKJmDc=;
        b=MG2SETAs4BBZ/vg0sU+V7wWQHJf8Sq5XoC2Fb4KlPVmHSMl75MFrISKn3dCOHcbalu
         V0IG1A/BX50YtyjG7TfS6jxh5bHJZnip4qsBHh2D5QdZiYbsqK9SMJ1M7242DOEdHDCD
         S9wuuzhmoxkJqkFJHIyVHL2Lp+H65SOym96dxqzq7vM1mVyBMJWHSS4W2do1Gu6+GTBR
         KHKneh9kcnc/6WbB5ZRz0nRNsbs7CywHgfNojnGQBisKMuaZobTlsLQAlUoGvlSYVIgm
         6rLs8FTSIkQeioGS67bC8uoxRUBb5dgmqsdeB36lhcB96NWZIbA4ExPm5ORzEb/Dttmc
         0slA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708502163; x=1709106963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzYwl8YMGXua6CQa68UF9a5u/8CEn2EQrELUkuKJmDc=;
        b=JUEpQB06ILMUv+AinpfS4b31TWxxCEqfQ0/DaUJKguyVUobmVYQfibks9+1rEzMyY3
         FojYi3URm9simHkZP/mqlKwDb1h0BHww+AzPtEjkPsIPLyycH1ZW+uENuzfa+wCxd+BA
         8qsGxliud9Kn/u8ZysMpeK0eAUeDLRKM26NrOgyOXzr3MJPuFBbptWHFf5on5nv/iAwJ
         ModECxlvq+xWQa1YmRkYidR2zvhokw+SeFs39PN3Z54/mLkO+IRR1IX44aqSRZafyUHR
         8BXpZFdhb7if3j6w7t1dGKxQD+zNECc2lJ8MY3luGH2MXjkYMapVtGQ96xQ9x6yJgQ5Y
         +9iw==
X-Forwarded-Encrypted: i=1; AJvYcCWD8DoFB8nRKwq4tq69msdWQYqOX5PcqkQRtU6Q68z6fjLQGcwA+32Y9bUMggMr1CrK3DjGLM+dftxT6lWRkQFNxjHMzfjK
X-Gm-Message-State: AOJu0Yyf8ApUGZuPjWSCuL/s8f2C1FIqRDfFkFzJeFNeiESWjVUqcoNP
	BZb8vFLcS9Z1as5LSqkvVxmV1fcYxcsIf3lfQhIvdGraDynt/BRUNO1chPDq46cl+1ucURAJ9Z+
	9QO3JKwLFzXixXBqUtjNYHsUemHhf5BvFy9V5
X-Google-Smtp-Source: AGHT+IEZyK1I0Los2sCbs/M/7PLIrS5TIHZ/Hh2HuGzFydwv3VjJ5hM9ffQop/gnv7WwXjQ4ZoWbFXnKzj0WIMAjUSA=
X-Received: by 2002:a50:cdcc:0:b0:560:1a1:eb8d with SMTP id
 h12-20020a50cdcc000000b0056001a1eb8dmr65434edj.7.1708502162160; Tue, 20 Feb
 2024 23:56:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221074053.1794118-1-ryasuoka@redhat.com>
In-Reply-To: <20240221074053.1794118-1-ryasuoka@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Feb 2024 08:55:48 +0100
Message-ID: <CANn89iK0j6j+dvp0EnEzPi32-6nLaR2qJ1sHjPg9865TigzENA@mail.gmail.com>
Subject: Re: [PATCH net] netlink: Fix kernel-infoleak-after-free in __skb_datagram_iter
To: Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	anjali.k.kulkarni@oracle.com, lirongqing@baidu.com, dhowells@redhat.com, 
	pctammela@mojatatu.com, kuniyu@amazon.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+34ad5fab48f7bf510349@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 8:42=E2=80=AFAM Ryosuke Yasuoka <ryasuoka@redhat.co=
m> wrote:
>
> syzbot reported the following uninit-value access issue [1]:
>
> netlink_to_full_skb() creates a new `skb` and puts the `skb->data`
> passed as a 1st arg of netlink_to_full_skb() onto new `skb`. The data
> size is specified as `len` and passed to skb_put_data(). This `len`
> is based on `skb->end` that is not data offset but buffer offset. The
> `skb->end` contains data and tailroom. Since the tailroom is not
> initialized when the new `skb` created, KMSAN detects uninitialized
> memory area when copying the data.
>
> This patch resolved this issue by correct the len from `skb->end` to
> `skb->len`, which is the actual data offset.
>
>
> Bytes 3852-3903 of 3904 are uninitialized
> Memory access of size 3904 starts at ffff88812ea1e000
> Data copied to user address 0000000020003280
>
> CPU: 1 PID: 5043 Comm: syz-executor297 Not tainted 6.7.0-rc5-syzkaller-00=
047-g5bd7ef53ffe5 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 11/10/2023
>
> Fixes: 1853c9496460 ("netlink, mmap: transform mmap skb into full skb on =
taps")
> Reported-and-tested-by: syzbot+34ad5fab48f7bf510349@syzkaller.appspotmail=
.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D34ad5fab48f7bf510349 [1=
]
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>

These vmalloc() skbs have caused so many issues, thanks for this fix.

Reviewed-by: Eric Dumazet <edumazet@google.com>

