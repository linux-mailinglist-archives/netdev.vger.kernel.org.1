Return-Path: <netdev+bounces-241787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0878C883B5
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 07:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 54EA2351571
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 06:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD842673B7;
	Wed, 26 Nov 2025 06:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K7zr8a4Z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hxu7N0Ok"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4958E1EDA2C
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 06:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764137765; cv=none; b=rNf8sS/hcnhOcPKmFUBgE38D54arOL0C4m6bsBmr0NcHtJ6rPrO/geDUlvNvfjXn3TedaWtI5l+22JP4ZZAFwqlLrv12vwEAUQhue6nynX2DOr1MOk8n3H54U6+/nW14y+DDwEFKpx0z8uWZqsRmFkSwDYR93LFjJhokubh/LPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764137765; c=relaxed/simple;
	bh=Hhkb/uQKRbBMevmupgfqk1Z+Assp9GjwVgOnkjW+mvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VCjkgWoAeSF4BDzScW0yppO5Wd2qN3ibHm3QNBnhCQRlFuwR2CP5MUJsUwY1HIZIVtgw3Nd4mbrRjaf2RdXJuPZsfJCtCITBTiHhsscrzwnqrYp2H65MvhuY/A5XiSITB5wVDA19FAooODQCw4LR+wRG2K/MGLi1H/ft9lfuCHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K7zr8a4Z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hxu7N0Ok; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764137763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0dJimzQGQg955aU+NR/OTglx/NF3Eo4HFgMmqUmEC2k=;
	b=K7zr8a4ZMXHlUQFQLbdEIoZMw/zUgV+yO+ujMXGLgZiRggRLSLbHKeIdQbWtojZNyht3s8
	TmlvuaK9GvBG3nHOXVQrm9f537waUojX40oXjPlM0Ep4yy4Bii5gd3FkKEYNRzHPeROx3W
	8bWXfEqKW7BxCs2il/3O8AaRWYqdT90=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-PNa7HuaENiSpjRgAzb0QEw-1; Wed, 26 Nov 2025 01:16:01 -0500
X-MC-Unique: PNa7HuaENiSpjRgAzb0QEw-1
X-Mimecast-MFC-AGG-ID: PNa7HuaENiSpjRgAzb0QEw_1764137761
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-297dabf9fd0so83857205ad.0
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 22:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764137760; x=1764742560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dJimzQGQg955aU+NR/OTglx/NF3Eo4HFgMmqUmEC2k=;
        b=hxu7N0OkOLOLLEqUIuHZ6gn11h9PpZ6ykpbCjql2pfTsOvknElykfYc/Z4dwwcrKKP
         /ZDAQBfnOZg8KmQGm+q3v41MY6oEiuQ6qtMNfS+DaA1w3ESGFrFWjVwADutMeW0wg4Os
         VjHLAuxf59pFQ1LDe9fO0Tj6ffHepYPwKez1AB+8eDNSP8IvKAxBWkbEhwAUZiU4Gye2
         BAUvDWtHXTx4OyOobVx4o4ElsYvPs/lkhBoTmYevBnKRqJSXckyzgT/gslRZG61VjmKx
         znJT+Tg7gnpxTuCzMudMa1Vrb+6fpiPvNQ62BPkRsMqktLS1swnNyTlBjyzqsbqT8bUB
         HBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764137760; x=1764742560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0dJimzQGQg955aU+NR/OTglx/NF3Eo4HFgMmqUmEC2k=;
        b=Es3pdQuOvSwZxocm23WxlYztQnQF95zY+AUgVtxqo9N2/tw6GFdH8kH9cCvCwkZ1u7
         zrOIg+wjym2RBrAcK4LNrax+jVUCdQFRvyco/qv76ptpk0WKICQbH59NmcsLLNRfiwAd
         i4rRjyErwHPy8ax8humKSCti3kYG9Tu3henmY2N0NHbfISgYKeCNAKSQkNB4QGjnhmKU
         5tepzaOo6umfI1IqHAg6sL6JvOF2KmYWw1Iul9uw5Y/Bv5THtbVamIQqupnxt4xq+H7R
         /57xLrK4WndmRnccrJu4Z4JVUhO2tGXdA16XbirL5/LtCy6C76arOcXL37Nqg5AeJs06
         Gh0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbpozzhTbYUf1XA3uiPd9nVGXhaWNnhRKCjZ3WdVtY1iPDms/10XpCQVw31Q/mfJU8RuqLrKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbHrYBTOZGc8UY91Na9Kpl9vvPQ7VpGxcIMuaXUHxMmKti3tiw
	qXSNYSPO8iJnLzIRidikBlBhgV8qPzjazwfgs4J64ki4w5qMxxxswhMJcwNbhuMXSwOOFZvd8Ww
	WvLiFOPF609Kvwk5+8Q8jeAXhMsXfsyyJVMV5dhDMsJ0c8csY4MsVAiaCf3jeWN9KDCCXP9XUm5
	uSLc6KnbdBmb1iF8KvP0qohZAAhu9PvEi5
X-Gm-Gg: ASbGncu+XhrGM2L3wwSRpVauQVduXRWzQsnIR2z7etxldFlYm8QXLpudxZTZ0rwe8lk
	+vnO7IXOx1OWNYB16TAtBTgGuykeG9ACjFs1jdXvj9qbCsMzVC0xYAZlw+ixVejJfpV+mvC55gI
	8b+ypHxYgspAZeMOWokWqLNZXpTSkkjzk7kuhq86n6MVtnxbcW7i/RsXIWLN22OqNhGII=
X-Received: by 2002:a17:903:2c0d:b0:29b:5c65:4521 with SMTP id d9443c01a7336-29b6c6cf2f4mr185578245ad.60.1764137760468;
        Tue, 25 Nov 2025 22:16:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHp5XvNsnFpgsWRW2tQ1zh6WcpwYde25ZVuL9wuN9oXE1mfzdcNCQGyR/EOxkG1uaOEL4o3pHnX4XP18UW3zR0=
X-Received: by 2002:a17:903:2c0d:b0:29b:5c65:4521 with SMTP id
 d9443c01a7336-29b6c6cf2f4mr185578095ad.60.1764137760068; Tue, 25 Nov 2025
 22:16:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125180034.1167847-1-jon@nutanix.com>
In-Reply-To: <20251125180034.1167847-1-jon@nutanix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Nov 2025 14:15:45 +0800
X-Gm-Features: AWmQ_bnZI9fzMXfYky4r-2TXzDDyUyIJGaC0lgl7E9RYBzJFA-iONio19mXg7uE
Message-ID: <CACGkMEv22mEkVoEdN0iPdgeycOEn8TaXcg-y5PGHTjw9YvTKpw@mail.gmail.com>
Subject: Re: [PATCH net-next] vhost/net: check peek_head_len after signal to
 guest to avoid delays
To: Jon Kohler <jon@nutanix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 1:18=E2=80=AFAM Jon Kohler <jon@nutanix.com> wrote:
>
> In non-busypoll handle_rx paths, if peek_head_len returns 0, the RX
> loop breaks, the RX wait queue is re-enabled, and vhost_net_signal_used
> is called to flush done_idx and notify the guest if needed.
>
> However, signaling the guest can take non-trivial time. During this
> window, additional RX payloads may arrive on rx_ring without further
> kicks. These new payloads will sit unprocessed until another kick
> arrives, increasing latency. In high-rate UDP RX workloads, this was
> observed to occur over 20k times per second.
>
> To minimize this window and improve opportunities to process packets
> promptly, immediately call peek_head_len after signaling. If new packets
> are found, treat it as a busy poll interrupt and requeue handle_rx,
> improving fairness to TX handlers and other pending CPU work. This also
> helps suppress unnecessary thread wakeups, reducing waker CPU demand.
>
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> ---
>  drivers/vhost/net.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 35ded4330431..04cb5f1dc6e4 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1015,6 +1015,27 @@ static int vhost_net_rx_peek_head_len(struct vhost=
_net *net, struct sock *sk,
>         struct vhost_virtqueue *tvq =3D &tnvq->vq;
>         int len =3D peek_head_len(rnvq, sk);
>
> +       if (!len && rnvq->done_idx) {
> +               /* When idle, flush signal first, which can take some
> +                * time for ring management and guest notification.
> +                * Afterwards, check one last time for work, as the ring
> +                * may have received new work during the notification
> +                * window.
> +                */
> +               vhost_net_signal_used(rnvq, *count);
> +               *count =3D 0;
> +               if (peek_head_len(rnvq, sk)) {
> +                       /* More work came in during the notification
> +                        * window. To be fair to the TX handler and other
> +                        * potentially pending work items, pretend like
> +                        * this was a busy poll interruption so that
> +                        * the RX handler will be rescheduled and try
> +                        * again.
> +                        */
> +                       *busyloop_intr =3D true;
> +               }
> +       }

I'm not sure I will get here.

Once vhost_net_rx_peek_head_len() returns 0, we exit the loop to:

if (unlikely(busyloop_intr))
                vhost_poll_queue(&vq->poll);
        else if (!sock_len)
                vhost_net_enable_vq(net, vq);
out:
        vhost_net_signal_used(nvq, count);

Are you suggesting signalling before enabling vq actually?

Thanks

> +
>         if (!len && rvq->busyloop_timeout) {
>                 /* Flush batched heads first */
>                 vhost_net_signal_used(rnvq, *count);
> --
> 2.43.0
>


