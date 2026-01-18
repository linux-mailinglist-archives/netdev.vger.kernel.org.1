Return-Path: <netdev+bounces-250839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E039DD394E0
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 13:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EB7C30056D9
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 12:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9725322C73;
	Sun, 18 Jan 2026 12:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HicVBiYe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6563A2EDD69
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 12:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768738514; cv=none; b=qPhX1MMJLIqnXwJpxZGaTPtBzCvoavyRjUVhshprjOjQnKCzARdXR/5+IaoTt6rgLEmBEojNCwRztQp55UPQ0Onie9NyOS5bVO3v87mzo5e4CLh5qLXColBHI1aC/6qnpY9h+dcxf3MqdWTGY+SacatXLkkQrsFFB7C7Qg/eq9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768738514; c=relaxed/simple;
	bh=QhL7WC1Zv7OucwsyKUjh2GJfaJlGqkEggth7ZsN+e2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mlrMroYUo12/0HyfcxNWbgLcdNRcq/NWVSypLZcQlgPGj2Z6WjEVwVdoLoi/1orId2CvxAlMXbHTllwdhYzi1tSMQThjWP5DDy3NjXaqcNLbmOHhNOj2Xql0yLIhFpaGp4omq05Tqg0AkJr/Z6Ib+e2u7lCQ1nQtPE3rCKLFsWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HicVBiYe; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-88a35a00502so34890626d6.0
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 04:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768738512; x=1769343312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhL7WC1Zv7OucwsyKUjh2GJfaJlGqkEggth7ZsN+e2E=;
        b=HicVBiYeQo4simt0Tcu7tvdAUq8/wG1ATuWF28CHtJOXFbQc8gOyBQOw/SZtxHM9/T
         DpZsOKXvVdGTxVU6zjMWqMVgKj6KHegFXTwc2dJUA/QTm/aq/Eed3wJiZxdUCGGdpli8
         ZCfxWC8kWxUVSeV8jLK8megx3XB1XocuETlfAbqFdIAwBlugdCBh6qbsUHHce+t5+sZF
         1E8lmsGAkX/n5jdlyrDr6oVuRhIR69oyn8doJTlCWNGuLlkNg1RAWQ6snquQA+l4Ejdj
         3VeVC4m+F9j2Znm/H5E5TALuhx8C3TRs/p+k+ViQ+/vFtGFSW1d9sAR6wjVl6Z+qfb8U
         dhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768738512; x=1769343312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QhL7WC1Zv7OucwsyKUjh2GJfaJlGqkEggth7ZsN+e2E=;
        b=fWAMKSr1ko4222JHqZsmTuBA+eT27bV/ydLgkCiwhgLR4eK9SOznMZBScyZJ2ccZ/r
         gEGr90s17sk/DcllelD81T1lAKdTTQl4xeoUyP+N5dY+7GzxCkUfMWNAAJ37YVevlg0O
         5LD3LlfrvZ2378rs/zukOkY5J501vykidQ22uhavKk1p2GU+ZliyYdCbUhZgERQvDKI4
         9OnOht/i/F+XCPiHQQt0+vhPeaGZkOuJAacilEpT9udVwbB0y4mIAhN6o3aGNRha+xWc
         dRC59LX8t+odSUXya8pX0WxUALBv987vzOGqR4ELT3RwsCZEgvB/vA75fzq5oCDWewTA
         0SLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWm86bB5V33geJTIE0gN3GeM6LohOmDhx56snrfi7e6Qx19HrnEoh5EVHhyHY20MpO3hVnNgyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFdzx+Tbcfl8EYGTfeAUORbnFr0RyczWz3gQO+ccpjrIgV63j4
	f8mTF4pF60+ztxqJhh/drzuf8++pKpvh5AuwPTEQtlMq2CuMsCIm1hZKkKElHIqoKNIj/HcriZw
	ZOnwlcwpzM8mI27+t0KxyD20rjI+lluzVTtbWUkjU
X-Gm-Gg: AY/fxX7t/EA7PwK5ItNBpECEc9g3D6BUcTD6R23JUqy1jxgoyfXM8YOOb7pH4+lsgjb
	U2xdYXvnt3widQ83fWji234oz7qyjazsELpBmhIPJvlX/w4TXOnGAv8l6OEBu9PtDy1iGcbo6dr
	twoHkn4RFvWl7U/eBBTsI6hhdPw5cpsh+ulTQEHYmxHJbpmqszmlOO+/oH8rcdfeM6B4CKYty/A
	bzGWQXMA5jbkvjdgrvWrhZM50eOGEkMR6B7noUXft2jGj1hLHDQt5+FtaAHpD3BWx/mel1ukBFA
	758HMeI=
X-Received: by 2002:ac8:5a48:0:b0:501:4d61:f02b with SMTP id
 d75a77b69052e-502a1f33411mr97121201cf.59.1768738511937; Sun, 18 Jan 2026
 04:15:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260117164255.785751-1-kuba@kernel.org> <CANn89iKmuoXJtw4WZ0MRZE3WE-a-VtfTiWamSzXX0dx8pUcRqg@mail.gmail.com>
 <20260117150346.72265ac3@kernel.org>
In-Reply-To: <20260117150346.72265ac3@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 18 Jan 2026 13:15:00 +0100
X-Gm-Features: AZwV_QhZi1p9UddCn9gEVMrkyuqRiqYsBc8xqoQcVQ8Mmpm30vdSNKtzbqzwEJU
Message-ID: <CANn89iJ8+5OaWS2VzJqo4QVN6VY9zJvrJfP0TGRGv85mj09kjA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: try to defer / return acked skbs to
 originating CPU
To: Jakub Kicinski <kuba@kernel.org>
Cc: kuniyu@google.com, ncardwell@google.com, netdev@vger.kernel.org, 
	davem@davemloft.net, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 18, 2026 at 12:03=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Sat, 17 Jan 2026 19:16:57 +0100 Eric Dumazet wrote:
> > On Sat, Jan 17, 2026 at 5:43=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > > Running a memcache-like workload under production(ish) load
> > > on a 300 thread AMD machine we see ~3% of CPU time spent
> > > in kmem_cache_free() via tcp_ack(), freeing skbs from rtx queue.
> > > This workloads pins workers away from softirq CPU so
> > > the Tx skbs are pretty much always allocated on a different
> > > CPU than where the ACKs arrive. Try to use the defer skb free
> > > queue to return the skbs back to where they came from.
> > > This results in a ~4% performance improvement for the workload.
> >
> > This probably makes sense when RFS is not used.
> > Here, RFS gives us ~40% performance improvement for typical RPC workloa=
ds,
> > so I never took a look at this side :)
>
> This workload doesn't like RFS. Maybe because it has 1M sockets..
> I'll need to look closer, the patchwork queue first tho.. :)
>
> > Have you tested what happens for bulk sends ?
> > sendmsg() allocates skbs and push them to transmit queue,
> > but ACK can decide to split TSO packets, and the new allocation is done
> > on the softirq CPU (assuming RFS is not used)
> >
> > Perhaps tso_fragment()/tcp_fragment() could copy the source
> > skb->alloc_cpu to (new)buff->alloc_cpu.
>
> I'll do some synthetic testing and get back.
>
> > Also, if workers are away from softirq, they will only process the
> > defer queue in large patches, after receiving an trigger_rx_softirq()
> > IPI.
> > Any idea of skb_defer_free_flush() latency when dealing with batches
> > of ~64 big TSO packets ?
>
> Not sure if there's much we can do about that.. Perhaps we should have
> a shrinker that flushes the defer queues? I chatted with Shakeel briefly
> and it sounded fairly straightforward.

I was mostly concerned about latency spikes, I did some tests here and
this seems fine.
(I assume you asked Shakeel about the extra memory being held in the
per-cpu queue, and pcp implications ?)

Reviewed-by: Eric Dumazet <edumazet@google.com>

