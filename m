Return-Path: <netdev+bounces-248362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4041DD074CD
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 07:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1E78304D0A8
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 06:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56181DDC1D;
	Fri,  9 Jan 2026 06:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OO18LVmI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="j8XOHxdo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2824A23ABB9
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 06:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767938533; cv=none; b=b20QppQXBe3VzgRl8VM/DeOrPnyEXjaQCGwwkVR7kLWwtYg2rbYhbcMrN6ID7b/VCcrbuC18SamGb+2Za6dBhsuo0vNa8uIH7UQIPEeh17lNg15/CaWD0ce0vFIQi0HMaMHgO9bXWVB/DTMAtDFTHJClKjaZ+mcab/zPDwo3A4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767938533; c=relaxed/simple;
	bh=LfbV3bIWDp4J9DPIWnoVpSzQ2fMzemhZ73PGMmrMWEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHRmCUSxZm70iTBnycRcHpAnzN2tjnRbQ/Mua07bixRyyYrXwep1XjTtC8kxJwxurdrQkgOl3vXaHeHZr0DhyRCEvLTyOLyZeFcEQCNH7gyH/P6iX/3990F0P8aeQzhKBoPtkOUPcQJv+RksSGhBKD/T6XQ+4D3bwAfiDhynoII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OO18LVmI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=j8XOHxdo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767938531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=62L7uKK76qUdf8AcX+V8O9A8VaWvwOnCNJYaGsTTDE0=;
	b=OO18LVmIPJX1fM/IqvUR+msnhxzFkTDP+oGY3ZuXOLw4O8YZvRtwHW2I2FiTHHOKeaZRLc
	YXxMtcFil2TV2NjxSgmIGfGQo75ViFmoZki1tYGYFk1+4elcruThLbY4JISnejtyhjyu8R
	1Qq2N4LREhMS62qeJWSKEKZiSK7BXNQ=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-4I7dlKm1Ozu-Hkk540OONQ-1; Fri, 09 Jan 2026 01:02:08 -0500
X-MC-Unique: 4I7dlKm1Ozu-Hkk540OONQ-1
X-Mimecast-MFC-AGG-ID: 4I7dlKm1Ozu-Hkk540OONQ_1767938527
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c52d37d346dso1119853a12.3
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 22:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767938527; x=1768543327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62L7uKK76qUdf8AcX+V8O9A8VaWvwOnCNJYaGsTTDE0=;
        b=j8XOHxdo5gGBxLHaChQ6shDF6LTPqvvWqbLzf8XgdgAOjxWw1fdOd2O7TndGlHtqEK
         XbF8hr1zmTTN/D6iEX2nEieRZtdysjVPQtAzwcEclLh2jcjkxC+kljVF2nP9o0m2vyFr
         Ei6OazK3DnpfRWAgUZGGzrw6Hlmor+pUAaAb+4oPfM2eQzW+W/lIJChMhwo1140fsXwE
         226jH060612FGSCAhHf/Gtx7CiFxVGjBzvIRR7kW/wS8QTnzOGG+/xRMfKv5lkopuG9G
         lWAKx9ThrGRGKl2UJZclXGj3kMQjEunnfewRWY5dSboRrwbRakjI8zrfoLoQuy7u6ArD
         hD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767938527; x=1768543327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=62L7uKK76qUdf8AcX+V8O9A8VaWvwOnCNJYaGsTTDE0=;
        b=CTWFvbA0fefj5cbkCApYz+GgBRC8lsPSrH+ibZ6GLfRoYFAHjeSwmun22ZSLvUbC8S
         OYZdeJzyAaVMdbbBHbabIcWYtCABX3IpMQvlg4R6IJxC/DhTy1pV3ENV3VkPFmg+gKiX
         qflkT7DBGnUqojLTgOfq1wlLnQB4N9lMeEodc//7ukeNg2NecwmBMVtJcHArGdXEUgkn
         UDW5yJNsQ9m6VYUMQ1+N91eBz5FZobAcvTQha+Ae/KXNQ/wS/Tz+KIvvFfDaUm5gTVML
         3paT+2ZDyAsS1sl0EmyRiwFk7kOzVqSvXHj/8PyPXm0DuiygN5UTzDnBdG8Nz6VO04sO
         vhFw==
X-Forwarded-Encrypted: i=1; AJvYcCWpckJxOVBeiqDmQn38x5N3+h83Pz8KbAYe9rsF8b3IGTRiYnDyGFnWfYQbgMyy5cqqAu47h68=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAzjywcIhYo+/VehMyKinb0KJEvu+T8lIluk0Yho+R30OqrCG7
	RG9W7cPDt98OHMUebVYIUdYNVhtLQeThfKsZwzytT253Pu3u51txPvas9A8k0cIRh+01aEWDlbA
	olTsec5sTHYt+51FRsBGdRbsXATEZzvCSKqFMyqWlI+KsYdeEo0kw+xMJEQr3EUtHpk4haTQCPX
	4N2pHwXT0TvTn8UpDWhWuoOdlto/a72aEx
X-Gm-Gg: AY/fxX7hEVwLq3n+udrB5dTt3Geo1epR6OlIahqWTU2Ohh71AXQeGCkOaRIACQ5B2v+
	qw+5bp01qY5JVxWMfXr45MRxaMi9l2dO31peiKdeuyI1VXr94JxJTWjC6lCCqWVqeJyJQsGU7e/
	2/lo0QDfTYcmUCBY3ATSBB5q5FpXWfOtgMCFjiZLyvU3QjGMuJ5O9YMJJ33i3w0H8=
X-Received: by 2002:a05:6a20:6a11:b0:371:53a7:a48a with SMTP id adf61e73a8af0-3898f8f5552mr8820776637.1.1767938527032;
        Thu, 08 Jan 2026 22:02:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7U5gpSDRrYYCGHdnAQ2bq5uAgkTGfK+sH12YYJ68NVxDB/cGt7yVMQVT5cwc8QARma7YH0oByMp3T1kPE0Jw=
X-Received: by 2002:a05:6a20:6a11:b0:371:53a7:a48a with SMTP id
 adf61e73a8af0-3898f8f5552mr8820736637.1.1767938526583; Thu, 08 Jan 2026
 22:02:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de>
 <20260107210448.37851-3-simon.schippers@tu-dortmund.de> <CACGkMEsHxu_iyL+MjJG834hBGNy9tY9f3mAEeZfDn5MMwtuz8Q@mail.gmail.com>
 <ba3cffe3-b514-435d-88a8-f20c91be722a@tu-dortmund.de>
In-Reply-To: <ba3cffe3-b514-435d-88a8-f20c91be722a@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 9 Jan 2026 14:01:54 +0800
X-Gm-Features: AQt7F2qhunhdhWvtDP-HjKQwCMpNXEKD9HAqlgqUpB6kCWfjauzXhQR7-f4zQJk
Message-ID: <CACGkMEv2m5q-4kuT5iyu_Z=5h0SMz0YYeKRBu8EtrxC_E-2zWw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 2/9] ptr_ring: add helper to detect newly
 freed space on consume
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mst@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 3:21=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> On 1/8/26 04:23, Jason Wang wrote:
> > On Thu, Jan 8, 2026 at 5:06=E2=80=AFAM Simon Schippers
> > <simon.schippers@tu-dortmund.de> wrote:
> >>
> >> This proposed function checks whether __ptr_ring_zero_tail() was invok=
ed
> >> within the last n calls to __ptr_ring_consume(), which indicates that =
new
> >> free space was created. Since __ptr_ring_zero_tail() moves the tail to
> >> the head - and no other function modifies either the head or the tail,
> >> aside from the wrap-around case described below - detecting such a
> >> movement is sufficient to detect the invocation of
> >> __ptr_ring_zero_tail().
> >>
> >> The implementation detects this movement by checking whether the tail =
is
> >> at most n positions behind the head. If this condition holds, the shif=
t
> >> of the tail to its current position must have occurred within the last=
 n
> >> calls to __ptr_ring_consume(), indicating that __ptr_ring_zero_tail() =
was
> >> invoked and that new free space was created.
> >>
> >> This logic also correctly handles the wrap-around case in which
> >> __ptr_ring_zero_tail() is invoked and the head and the tail are reset
> >> to 0. Since this reset likewise moves the tail to the head, the same
> >> detection logic applies.
> >>
> >> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >> ---
> >>  include/linux/ptr_ring.h | 13 +++++++++++++
> >>  1 file changed, 13 insertions(+)
> >>
> >> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> >> index a5a3fa4916d3..7cdae6d1d400 100644
> >> --- a/include/linux/ptr_ring.h
> >> +++ b/include/linux/ptr_ring.h
> >> @@ -438,6 +438,19 @@ static inline int ptr_ring_consume_batched_bh(str=
uct ptr_ring *r,
> >>         return ret;
> >>  }
> >>
> >> +/* Returns true if the consume of the last n elements has created spa=
ce
> >> + * in the ring buffer (i.e., a new element can be produced).
> >> + *
> >> + * Note: Because of batching, a successful call to __ptr_ring_consume=
() /
> >> + * __ptr_ring_consume_batched() does not guarantee that the next call=
 to
> >> + * __ptr_ring_produce() will succeed.
> >
> > This sounds like a bug that needs to be fixed, as it requires the user
> > to know the implementation details. For example, even if
> > __ptr_ring_consume_created_space() returns true, __ptr_ring_produce()
> > may still fail?
>
> No, it should not fail in that case.
> If you only call consume and after that try to produce, *then* it is
> likely to fail because __ptr_ring_zero_tail() is only invoked once per
> batch.

Well, this makes the helper very hard for users.

So I think at least the documentation should specify the meaning of
'n' here. For example, is it the value returned by
ptr_ring_consume_batched()(), and is it required to be called
immediately after ptr_ring_consume_batched()? If it is, the API is
kind of tricky to be used, we should consider to merge two helpers
into a new single helper to ease the user.

What's more, there would be false positives. Considering there's not
many entries in the ring, just after the first zeroing,
__ptr_ring_consume_created_space() will return true, this will lead to
unnecessary wakeups.

And last, the function will always succeed if n is greater than the batch.

>
> >
> > Maybe revert fb9de9704775d?
>
> I disagree, as I consider this to be one of the key features of ptr_ring.

Nope, it's just an optimization and actually it changes the behaviour
that might be noticed by the user.

Before the patch, ptr_ring_produce() is guaranteed to succeed after a
ptr_ring_consume(). After that patch, it's not. We don't see complaint
because the implication is not obvious (e.g more packet dropping).

>
> That said, there are several other implementation details that users need
> to be aware of.
>
> For example, __ptr_ring_empty() must only be called by the consumer. This
> was for example the issue in dc82a33297fc ("veth: apply qdisc
> backpressure on full ptr_ring to reduce TX drops") and the reason why
> 5442a9da6978 ("veth: more robust handing of race to avoid txq getting
> stuck") exists.

At least the behaviour is documented. This is not the case for the
implications of fb9de9704775d.

Thanks


>
> >
> >> + */
> >> +static inline bool __ptr_ring_consume_created_space(struct ptr_ring *=
r,
> >> +                                                   int n)
> >> +{
> >> +       return r->consumer_head - r->consumer_tail < n;
> >> +}
> >> +
> >>  /* Cast to structure type and call a function without discarding from=
 FIFO.
> >>   * Function must return a value.
> >>   * Callers must take consumer_lock.
> >> --
> >> 2.43.0
> >>
> >
> > Thanks
> >
>


