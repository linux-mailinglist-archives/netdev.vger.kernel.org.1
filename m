Return-Path: <netdev+bounces-236704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A80E2C3F17B
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 10:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D58444EC52A
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 09:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6DA316910;
	Fri,  7 Nov 2025 09:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kiQRk5pp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559C2316907
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 09:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762506681; cv=none; b=VC/voYujuMHyVXI8uMhBSSFbEmRasRZBRr403ST0hQ4/MaYxb5pliwqowgscVa8PHQDKz0m9X/pyvDOjlwhjRs4K6OeA/ju6/g78mQQueZQPjaX5GsETq2VAcTpQaVDcF/llXpbl+jWucM3nushmi/eToo9pRC6fPldYFd0Wu7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762506681; c=relaxed/simple;
	bh=qluEfAx4P4Op0mddGosmUCloxMSkTeHiqo66DREW0sE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g8Idy4iZwubztrNHw6Rti7CTPFjJnhNDn2P2jb7BUPS/WvOKanT8JQ26AaHGuPDIy540KxdyrCqBfW044f7sNLZFG2j+200n064HYCKz9fS7mCUcw2zGO/FGOaHfaXALyxD6kgcgQkUzHBcVKWCweFZ68IbMvbOzQrHJIdkGvxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kiQRk5pp; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-87fc4d29301so7497006d6.2
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 01:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762506679; x=1763111479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a204aqYcOBM466MbvDOjrJwmwekmEMTkCpPH2NQmT9Y=;
        b=kiQRk5pp+FodqzXU1/HQOhgPC53/U2xkCd0LjbMhNERKN4RrZuvusS/T56uZ6Ipccz
         RXx3z+T6eog8IfyINW44xEPfdiylGvEmsQHD3yqCSIjYBEYpBbkwIghfagbUa3S8PAh/
         sU73I23EAncUoC/tbFkZrdqWdTcDwHTvBwJYTI1KQ03nukhJPrNct39jwpti9689y8K7
         JWK65IRDaZPpOqitl9M66gghMoXJz80E1kxX806HO/nMa/bZsazwTtWCXaY2zOeqMXbE
         IzxnXrPN8A8Jvp0PVhchq9yw/tiputg27cCEHvVU8w2rTdr+ymsTkhFdr2Za0lXKThE6
         Ir6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762506679; x=1763111479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a204aqYcOBM466MbvDOjrJwmwekmEMTkCpPH2NQmT9Y=;
        b=qZOHSoHSezod6DHr6TfNP0Gccy5h/0lZ7XSiVHCz5FZds0wf6GsRKvcWVO2xXwVhbN
         XgMqFruL09Pku8V5ubCm1qyOn72So25j+yD1Cv9EvVks/bQ7e/BFj9OYG4bFTuHf8CzP
         qAKaK+Dy+jkhKP0aJK4oYTDzIef8TPuYbABn31QwVwTPnquWPYVXhn/UZiTPejSs2KZa
         ru5jJWwwdM7eypSq8wW/dk1tiYhPuewyEcngyn9xQeLVZ+khgGVjVr7bI52czHO4sfUA
         8aEx4DXqQ52ArGccYPBMIS149RgK9quv+cgo41FEDkXUDo4l+6QgBAzyn00eJh8287dk
         n6TA==
X-Forwarded-Encrypted: i=1; AJvYcCWhFGEiNK2fpJf5kXEoMdO4I8TF9SZqNnEQ3YNlAfJkuywxVbUtyw6LLlWYyKc0zrfelx5IZGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDvu60Y92H/BVU05RyYN3PHUfqN1ieEIfx6jK+sj31jMdvUrdG
	NX6AF566zaXjZUBBMntXPY13WC1RO+x+jsfTVizTrWk5UiTpXGcX25C0jtdn414csP6+hMa4wxg
	IO4Oa5mi7e223ARUliaotcsI81T2IqgOp5SBxva5y
X-Gm-Gg: ASbGncu/xvQYniIVgGvKOMOyo1xHp4keny/aOGO4bgFbemi7fWP+l5zTieVjIAuNaAS
	R5y9mM9VcbrnDNLQLyVo6d9+DUhmuEINs5irVvck/9dtvIo+BJqPwSY/nZmGlQ/TB8dVMEp9K2g
	jvY3IKSdH8h2h/xg0keBVKvjtwfL+p0D40vgVADbRWICZcmkoWuUX0BYId26na/ttuR9Bot4NoH
	lbLUBMjVNPWOq+LL4kjN+6nbNcJD7dUVMSzonXkcIye4PVZKX4QFOj+BqIqeObjwAkqYfuz
X-Google-Smtp-Source: AGHT+IGz94Dkv0/5825Az75dzLFdActH8LiDPhq7l0p5slfzfa32FfVXlcHJGdXp+viXXrhF3O7l7xGV9cp8BtfgVWI=
X-Received: by 2002:ad4:5f49:0:b0:880:531a:e656 with SMTP id
 6a1803df08f44-88176706ed4mr32555936d6.29.1762506678823; Fri, 07 Nov 2025
 01:11:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106155008.879042-1-nhudson@akamai.com> <CACGkMEt1xybppvu2W42qWfabbsvRdH=1iycoQBOxJ3-+frFW6Q@mail.gmail.com>
 <5DBF230C-4383-4066-A4FB-56B80B42954E@akamai.com>
In-Reply-To: <5DBF230C-4383-4066-A4FB-56B80B42954E@akamai.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Nov 2025 01:11:07 -0800
X-Gm-Features: AWmQ_bkTKwQCIhZ27LiJ3ImW1YxzMLolDk179Mujr0_sUk4RhhQgRP2z94LyF3c
Message-ID: <CANn89iK_v3CWvf7=QakbB3dwvJEOxuVjEn14rjmONaa1rKVWKw@mail.gmail.com>
Subject: Re: [PATCH] tun: use skb_attempt_defer_free in tun_do_read
To: "Hudson, Nick" <nhudson@akamai.com>
Cc: Jason Wang <jasowang@redhat.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 12:41=E2=80=AFAM Hudson, Nick <nhudson@akamai.com> w=
rote:
>
>
>
> > On 7 Nov 2025, at 02:21, Jason Wang <jasowang@redhat.com> wrote:
> >
> > !-------------------------------------------------------------------|
> >  This Message Is From an External Sender
> >  This message came from outside your organization.
> > |-------------------------------------------------------------------!
> >
> > On Thu, Nov 6, 2025 at 11:51=E2=80=AFPM Nick Hudson <nhudson@akamai.com=
> wrote:
> >>
> >> On a 640 CPU system running virtio-net VMs with the vhost-net driver, =
and
> >> multiqueue (64) tap devices testing has shown contention on the zone l=
ock
> >> of the page allocator.
> >>
> >> A 'perf record -F99 -g sleep 5' of the CPUs where the vhost worker thr=
eads run shows
> >>
> >>    # perf report -i perf.data.vhost --stdio --sort overhead  --no-chil=
dren | head -22
> >>    ...
> >>    #
> >>       100.00%
> >>                |
> >>                |--9.47%--queued_spin_lock_slowpath
> >>                |          |
> >>                |           --9.37%--_raw_spin_lock_irqsave
> >>                |                     |
> >>                |                     |--5.00%--__rmqueue_pcplist
> >>                |                     |          get_page_from_freelist
> >>                |                     |          __alloc_pages_noprof
> >>                |                     |          |
> >>                |                     |          |--3.34%--napi_alloc_s=
kb
> >>    #
> >>
> >> That is, for Rx packets
> >> - ksoftirqd threads pinned 1:1 to CPUs do SKB allocation.
> >> - vhost-net threads float across CPUs do SKB free.
> >>
> >> One method to avoid this contention is to free SKB allocations on the =
same
> >> CPU as they were allocated on. This allows freed pages to be placed on=
 the
> >> per-cpu page (PCP) lists so that any new allocations can be taken dire=
ctly
> >> from the PCP list rather than having to request new pages from the pag=
e
> >> allocator (and taking the zone lock).
> >>
> >> Fortunately, previous work has provided all the infrastructure to do t=
his
> >> via the skb_attempt_defer_free call which this change uses instead of
> >> consume_skb in tun_do_read.
> >>
> >> Testing done with a 6.12 based kernel and the patch ported forward.
> >>
> >> Server is Dual Socket AMD SP5 - 2x AMD SP5 9845 (Turin) with 2 VMs
> >> Load generator: iPerf2 x 1200 clients MSS=3D400
> >>
> >> Before:
> >> Maximum traffic rate: 55Gbps
> >>
> >> After:
> >> Maximum traffic rate 110Gbps
> >> ---
> >> drivers/net/tun.c | 2 +-
> >> net/core/skbuff.c | 2 ++
> >> 2 files changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >> index 8192740357a0..388f3ffc6657 100644
> >> --- a/drivers/net/tun.c
> >> +++ b/drivers/net/tun.c
> >> @@ -2185,7 +2185,7 @@ static ssize_t tun_do_read(struct tun_struct *tu=
n, struct tun_file *tfile,
> >>                if (unlikely(ret < 0))
> >>                        kfree_skb(skb);
> >>                else
> >> -                       consume_skb(skb);
> >> +                       skb_attempt_defer_free(skb);
> >>        }
> >>
> >>        return ret;
> >> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> >> index 6be01454f262..89217c43c639 100644
> >> --- a/net/core/skbuff.c
> >> +++ b/net/core/skbuff.c
> >> @@ -7201,6 +7201,7 @@ nodefer:  kfree_skb_napi_cache(skb);
> >>        DEBUG_NET_WARN_ON_ONCE(skb_dst(skb));
> >>        DEBUG_NET_WARN_ON_ONCE(skb->destructor);
> >>        DEBUG_NET_WARN_ON_ONCE(skb_nfct(skb));
> >> +       DEBUG_NET_WARN_ON_ONCE(skb_shared(skb));
> >
> > I may miss something but it looks there's no guarantee that the packet
> > sent to TAP is not shared.
>
> Yes, I did wonder.
>
> How about something like
>
> /**
> * consume_skb_attempt_defer - free an skbuff
> * @skb: buffer to free
> *
> * Drop a ref to the buffer and attempt to defer free it if the usage coun=
t
> * has hit zero.
> */
> void consume_skb_attempt_defer(struct sk_buff *skb)
> {
> if (!skb_unref(skb))
> return;
>
> trace_consume_skb(skb, __builtin_return_address(0));
>
> skb_attempt_defer_free(skb);
> }
> EXPORT_SYMBOL(consume_skb_attempt_defer);
>
> and an inline version for the !CONFIG_TRACEPOINTS case

I will take care of the changes, have you seen my recent series ?

https://lore.kernel.org/netdev/20251106202935.1776179-1-edumazet@google.com=
/T/#m94e853a732f3cf1bb6a8f613f7d9d6f150f87f6f

I think you are missing a few points....

