Return-Path: <netdev+bounces-209075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C99DB0E2A1
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 19:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8ED567C37
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 17:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1CA27D780;
	Tue, 22 Jul 2025 17:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Fx9kkWq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168055234
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753205568; cv=none; b=bwQvf4LpbhfmbCuuMasICeLMB1FMT37VVs7SZLiqtcgYKROPUg8vqkhFFO6C9sKj7T7OvP/f7x4+2MwoTVmQQMWB4pBNE5VrH80xb1UrlKSLfQ5dWlwU4WiOO9T3zQmFiwC+PJ2uEQ0oqehCHHjF0OEFeiE2nRZbJqKCuLrz4cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753205568; c=relaxed/simple;
	bh=skEIStYLex0IwNhjVxYvbiFwZQTi/ZIk9jt1jDlyWBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/dXUx0Ay6mjgkYqLe3ytsDrCrk2c0jkqy6YaNnzDPyxDFU1qNE7NctZU+tLrGZJ2UyaHvj2MnwDyodf0NEGYmIlohpsHAhZqB+/phjyyY+aYFjLzSJAKgFiyvwlBs0Ehn9d9cd9OImI9CeP1PXjgoqZfZO97lfkqyxfhW3Twi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Fx9kkWq; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-237f18108d2so17155ad.0
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 10:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753205566; x=1753810366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDbGckRNTh0QXSl5QzqdDA70mHJnKu7+uiyGYXkKED4=;
        b=1Fx9kkWqg7sgrD+0GZ3VIN1lV82XUF8wcSHQvIY2xcBgT6BW9pkJGkLJ/YfcQ4rOgy
         1GIlpjEXcURWV0zNyGZMtFaWkmEwsQAHpdb2MDRs1DVVhEKT+EWoHoBuUPYUqpdfO02K
         ObxFiaVojKj3aVr61nhTEEytL1oOlgcZpRnhI+D3nMP1syaGTTb5w3jIqia7f/m17Ub8
         cQy8cNghN4N4u5EmijwNRtQAjgqU+F1Jz4sndQ2NF92HVmX7VoFVjn2HECKD+LeQ7VQq
         keqcQgKbBzwK5KCXOdwV0ZsdxV31mjW02DHsbx8xPaKgZ4Hk/GJHdjgAMrXprvZLr5b/
         JRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753205566; x=1753810366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDbGckRNTh0QXSl5QzqdDA70mHJnKu7+uiyGYXkKED4=;
        b=r+OZ+AbYDND4KLRsRgxRfv5uiDm8hqz63twNo9lcV7nsGJN9PppgFiJ2jH2GsRL3+D
         4L9CQuBwNruI9xOjyDDuAiQ4LDceXitMo7jmxLmbHE7pVeIzaV/9yj5cJs6G7DM2fIdl
         VTNG8PyEmTiZaxkqyaqa0IIyVDBqr9UHvWLdcDx9bWYnFJS4XehniSf65Vo36x2uLd9R
         qWnF2rVvIE5vE7KwVuxlV1aISo3QsvkJH9EwwulRXQXQeB/XGQpTkFf12h7xu9pm/NpZ
         vjBlxMhZPfC5cwx3gVDP0lFhk+Zyj3wyybjlNyD9jytfv7MKmAsl0r/Bls+INMzTSe9O
         2H0A==
X-Forwarded-Encrypted: i=1; AJvYcCWkiPHgE6XzdCOR9W1CvihCci2EyQAnDBP/+Fym2DCa+ih5FVtSWHKb50wPpUewY73VqZ2Z3nU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9S7yA1XqcTWtcnQO9DKt0HYCUK+FqlWRRZdrquIlB7oADPzVx
	Uz7fzc4jiXE3Qw1aoS98fynnGSVdJlKQhZai27kSeOYikzdlSCP9xZX/u0W+/EXz9ElwC/BzA1G
	QXVhU3bogWvW9m8rXdSzFr94QsPCQ6ND/Mul5R1VB
X-Gm-Gg: ASbGncsh/OCR3kGnHh1NHc2VQmqFz7N6UTuM11+JLc0qR6D5mrvOJ45wXp+TkF/6wmX
	47pqjFoBjVcw8N0p8GTdqCDlVqYw+GQE4wnSS1AMW1+NSAaZuu1chM7/rDPyd8CBHpfVZ4n7R3W
	zKUYLrI8AeBdK6AZahvUduewwv4HUyMmvol6UeGeLw9b+ko8lSFAh2reSYqEVE+ZdgHIoT8SIlx
	Bzy+p1CqZ4x6zi3sRBNKUJOLrwU9gvNnS6iyls=
X-Google-Smtp-Source: AGHT+IF1JA2yCcl12vlpGwwWEZGA7Y9a1TPAogTq0q+/p5UgxdK4OFqYBGkvUNOK64f+17OZUjfeux/KSzhO876kqaE=
X-Received: by 2002:a17:902:f745:b0:234:b2bf:e67f with SMTP id
 d9443c01a7336-23f8cf8598cmr3467295ad.9.1753205566005; Tue, 22 Jul 2025
 10:32:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717152839.973004-1-jeroendb@google.com> <20250717152839.973004-5-jeroendb@google.com>
 <CAL+tcoBu0ZQzLA0MvwAzsYYpz=Z=xR7LiLmFwJUXcHFDvFZVPg@mail.gmail.com> <534146d9-53b1-4b4a-8978-206f6ad4f77e@redhat.com>
In-Reply-To: <534146d9-53b1-4b4a-8978-206f6ad4f77e@redhat.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Tue, 22 Jul 2025 10:32:35 -0700
X-Gm-Features: Ac12FXzQVZxOFJVBW-sncCa5oU29UZ6LwRW91wRIab6ANgcCaA5eRGVKvbkpjxs
Message-ID: <CAEAWyHcLHfyvnLogdqWZR_am9ed+SSOfTp7GfOXBB89Duv_N4Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/5] gve: implement DQO TX datapath for AF_XDP zero-copy
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, Jeroen de Borst <jeroendb@google.com>, 
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, willemb@google.com, Joshua Washington <joshwash@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 2:32=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 7/22/25 1:37 AM, Jason Xing wrote:
> > On Thu, Jul 17, 2025 at 11:29=E2=80=AFPM Jeroen de Borst <jeroendb@goog=
le.com> wrote:
> >> +
> >> +               pkt =3D gve_alloc_pending_packet(tx);
> >
> > I checked gve_alloc_pending_packet() and noticed there is one slight
> > chance to return NULL? If so, it will trigger a NULL dereference
> > issue.
>
> IIRC, a similar thing was already mentioned on an older patch. Still
> IIRC, the trick is that there is a previous, successful call to
> gve_has_avail_slots_tx_dqo() that ensures there are free TX packets
> avail and operations racing in between on other CPUs could only add more
> free pkts.
>
> So the above looks safe to me.
>
> Side note: since this looks like a recurrining topic, I guess it would
> be nice a follow-up adding some comments above the relevant functions.

Sounds good, will do in a follow up patch.

Thanks for the discussion and feedback.
>
> Thanks,
>
> Paolo
>

