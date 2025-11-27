Return-Path: <netdev+bounces-242304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B5EC8EA76
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 14:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A1C4E4E8B5B
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 13:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9155933291F;
	Thu, 27 Nov 2025 13:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHweq9Mq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0176678F59
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764251778; cv=none; b=EW1clBpansiCfC4YqKVO/OpKlAg+iwAmOT2yxmLpmRBSbD6QkVn5wT7FGWrD6+vE/99KrQgaoSwK/fQSFg1KG1lvlT8UzM4oPn+s8cUFcm5yedsyU+JLJbuwLc0cmVVDIwxP5qd55l/GBmHJS4PSnFuc4DOzPjNwfdrv/k9ZwOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764251778; c=relaxed/simple;
	bh=hnD+okc/dnbWm+YOzZT3YKxq6VrhdgCMi3kX7TlHNjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HSO0ANpJbrq/yj774cP6FVZK+oKsP8+ZvNfaRAUQ1WRhX4dXy7b7idIFHXcTlBFGq8sPC8zVAaK9INZiJU3XGGUVVhIw1OW1ca2/KRbiVzA8bTNTJSg3h72Swz+hOsM4jdCl8GoQtoQVV++tTN2Zc7gulh7ADg6zI8cIsEwe5Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHweq9Mq; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-4335726d0f2so3848605ab.1
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 05:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764251776; x=1764856576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMN44H9vJU4PnVLtLMGIhE1MUks8enlBayyg5KktVek=;
        b=fHweq9MqSFHCDP0M746h6Ut6oBkSGzlcRGi2ZGXWUtZ9VIvMxlfGqXFvaGKGJ6ymSM
         PuuCmwIZ/ifXrFUImIDIuFmbIw3fwnZpMuCN1t+WLnUgX0r9OHLVvlv+XCXKGF+17af5
         CkqxedH5ewkwBQWbbmpFu4bH1H/1eJl5JbXC8+0z8GAowrye8/x/92gFbHKjRRWaml/5
         RS+0Wvayi7Z1Ok2BLQhOGxdY4YchDqWUdhCWcGukazqprFdNjrMFu0R0xtITZIcmwUtu
         KhXMH0uMohHROMGOnPE5K+LCZdUGnWlcPJeMMLWXIlaG8lMarVfoG3ksKFzsHhUP+zWo
         yiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764251776; x=1764856576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gMN44H9vJU4PnVLtLMGIhE1MUks8enlBayyg5KktVek=;
        b=d8g64WVYCU+FpDLy0RoBC7GnnxhB/NQP6QzaaRjyNPNqJkhdfRnSZl7pYBk2D6H9na
         6oiWc7WWUSbD9M01Nei1ZMg0Wgsz3SqqaNHRejVUTZSnE3s9vYDNPgiz+MKjNSgA7t+p
         8Fik1aJ5IbifXO2ZPCLvy24P1vf4BuOx+dv0gRoon8NDe5s346WmdIuMZnB2wYPcE0wm
         bbie2HeDF4dDtkn6znd8dXqdn0IJm8rxTzFu/yjOO91my2NYbZHtio9aESCsNwNWlrUc
         PpKipeUS/sJufhv9RNISJkbt6+nLTtxCr+UwRqs5Snmyp80IgwIS/7fKpUI9wMx0HEUn
         3Zeg==
X-Forwarded-Encrypted: i=1; AJvYcCXM3hLcklUfE3RhiFFqvCv+ep8qTTXzPdEWCthkLogYwQRhk8gDGEFF0FGtFtiwf79i09txN0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz22i56VwWZb43WuJnqgdsRgnGFt0a7Fjmji3ahYTY1Deoe21rg
	IcTHjiq9HAPgI3bD/d5lo6M4P79zahEYR99xkgoF7f6bovT9yc3TLDM29Wo8+pD0bADS5NOtM9g
	QdiKdkEznL6YDEbcNGbDTuU8iSpH+RR8=
X-Gm-Gg: ASbGncviRFAb/mdMPgOY5aMYqMiYK+8ZhAtwHJOTeMxZsxDeM0XwFI7ssgEVabvJYAF
	tXafZR8XzuPdMvbU94F/j6DoLleLE40zuaM24Ni2ZSBluuNIRUSRdtpGofs4Pc3KTykE3XBKCGZ
	w7rCGbRJsWRIQ99Y6QIZyVQkW1x0d3UWdWAbbTG0vjQlHY6PNaVx2nmkJQECVwjaiJzE0Bm0jT4
	4vhU4qsoio7kCZUuLRHaG2ZqZUNLFUTbTqZ69EHL+NsiCd2QjuDmGw4+ZGi5WNLZsWApPs/60V4
	vpNs
X-Google-Smtp-Source: AGHT+IEFaVpZ/l+CoWAjUjB7qsQUi6A/gKO84ugvtGgoRQqsX2rXrUPU24Nq2EwBVP+BW/w1sYpZZbEMXouVjX31CO0=
X-Received: by 2002:a05:6e02:2684:b0:433:2660:6856 with SMTP id
 e9e14a558f8ab-435dd10563amr100541955ab.31.1764251776014; Thu, 27 Nov 2025
 05:56:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125085431.4039-1-kerneljasonxing@gmail.com>
 <20251125085431.4039-3-kerneljasonxing@gmail.com> <0bcdd667-1811-4bde-8313-1a7e3abe55ad@redhat.com>
In-Reply-To: <0bcdd667-1811-4bde-8313-1a7e3abe55ad@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 27 Nov 2025 21:55:39 +0800
X-Gm-Features: AWmQ_bk-e4XV73BBupIWtDbnB3n4WQ7ZK9wfDUEj6aRiS-6SmI1BAexPUsgrbW8
Message-ID: <CAL+tcoCy9vkAmreAvtm2FhgL0bfjZ_kJm2p9JxyaCd1aTSiHew@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] xsk: use atomic operations around
 cached_prod for copy mode
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 7:35=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 11/25/25 9:54 AM, Jason Xing wrote:
> > diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> > index 44cc01555c0b..3a023791b273 100644
> > --- a/net/xdp/xsk_queue.h
> > +++ b/net/xdp/xsk_queue.h
> > @@ -402,13 +402,28 @@ static inline void xskq_prod_cancel_n(struct xsk_=
queue *q, u32 cnt)
> >       q->cached_prod -=3D cnt;
> >  }
> >
> > -static inline int xskq_prod_reserve(struct xsk_queue *q)
> > +static inline bool xsk_cq_cached_prod_nb_free(struct xsk_queue *q)
> >  {
> > -     if (xskq_prod_is_full(q))
> > +     u32 cached_prod =3D atomic_read(&q->cached_prod_atomic);
> > +     u32 free_entries =3D q->nentries - (cached_prod - q->cached_cons)=
;
> > +
> > +     if (free_entries)
> > +             return true;
> > +
> > +     /* Refresh the local tail pointer */
> > +     q->cached_cons =3D READ_ONCE(q->ring->consumer);
> > +     free_entries =3D q->nentries - (cached_prod - q->cached_cons);
> > +
> > +     return free_entries ? true : false;
> > +}
> _If_ different CPUs can call xsk_cq_cached_prod_reserve() simultaneously
> (as the spinlock existence suggests) the above change introduce a race:
>
> xsk_cq_cached_prod_nb_free() can return true when num_free =3D=3D 1  on
> CPU1, and xsk_cq_cached_prod_reserve increment cached_prod_atomic on
> CPU2 before CPU1 completed xsk_cq_cached_prod_reserve().

I think you're right... I will give it more thought tomorrow morning.

I presume using try_cmpxchg() should work as it can detect if another
process changes @cached_prod simultaneously. They both work similarly.
But does it make any difference compared to spin lock? I don't have
any handy benchmark to stably measure two xsk sharing the same umem,
probably going to implement one.

Or like what you suggested in another thread, move that lock to struct
xsk_queue?

Thanks,
Jason

