Return-Path: <netdev+bounces-247885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC89BD00226
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 22:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7AD453019946
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 21:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47626329E4F;
	Wed,  7 Jan 2026 21:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MnvFhJvk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C45309EE2
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 21:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767820690; cv=none; b=ACh/IKpaB0cSuKFS5/ze9Kh+ePwO9ZwPLFzs55tQo+q+i+C4mhBNiqnorKie3n3UjW22e0J4b+tdVR5+kJAW6G4DQahvOX8VB4y4tXlXwkTILzG1NVos2PSU48SJUvH1m9ZSJxeCVSSufewa+a4prQe1YeCKfg0Lh9u3m5FSRhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767820690; c=relaxed/simple;
	bh=isghw6tWOIwy9EmbJUueO0rSHft6YoATGgfHtZrSVwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=diQ1TVj5Ik5SFKqn9oKAP5fkvTfP9zAB8nMb8QugBpJ3+c7gm4Rr05AHRWC0/GNSwNpjb9UQ8K3nO+/vdWUICArftrH/cY126WxhTXIw+GLVuKbLZmM/lDl0mT8vBicGmo8AGlAbtecP9mW8nF1B/gSN5ED+P1GUfigaqO8qdrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MnvFhJvk; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4f1aecac2c9so15430231cf.1
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 13:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767820684; x=1768425484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uv+dQygpIoW9gC+CANr1vFOTsFNI/SVTiF6HAIy0DV8=;
        b=MnvFhJvk3ugZjskDTPUtWtJHgz+icDV54x7dQObkiamNLpVrGJQVu6KSm0uPIEyPSb
         ZUZJGEwVDpcO8UZMQdYIudtP70YYwRhR+d0PsmeRKPPDLL0lz8lleLduP1+wUIRsPJll
         1RFzBz3S7+3ZVbpJToYImHtiXPTlSpdHA5P0MJp8Nir2Byx+Iyl+c1EAMW3c+pkZxxVE
         E59kzX2KwYr0+HnlmXztjvWf3xbELYs4CWNgwEnklmeHWvRB7LQJnctH1sIBvG0eiyPW
         udcaTlwf9URfIO293OWP1YyubJcLvIzpErYXxKCSJiNZs0r5eTIqlqtG5/IjjTCMokMu
         QdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767820684; x=1768425484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uv+dQygpIoW9gC+CANr1vFOTsFNI/SVTiF6HAIy0DV8=;
        b=lfGBgBDnuVbvQdKbt3PkOgrmiUQmqDQG0wO+cQMhlypQ3fAJ2r094dqYicRs8k2Lwk
         4pq5fDpMA5N7AsSpKq5d7dWU4ganqYbXZTGRiE1sGOO2xq7nliDeP3PHPJiTX7kGoSE/
         bJ+bE3ZtftYmA6H2IuJopoci/PmFYTss/Ca6tAdsgvT1dtN8dWd9t5Q6ZS3hXIq7nNUs
         zqd2l4yCodiHPOZdEDJd7I40ssxcNGkcHOTo+QQobF3U3vZrNCKDuODgYTlGTpahMwcN
         nEgL17povL5h38tvsCCCskRS8cQxuK03U+WF5xieO31KTrV1FR7LM/zzVXgH6WySph6K
         dqeg==
X-Forwarded-Encrypted: i=1; AJvYcCXssjhw8ipZsL3RiMj0DYHyR2UmIevg2RaHFwchdHb5kliNrpo2H4haCZDvz6Gv+p18imFpc9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZECMu3gpdnBEinDd6AV87zXfbtomB8Ftb7qvGz8j+/ikn2aZ7
	EsbDFEIfO4P5Fqr6EotoB/i+YlzWHPHz8EPhQ3Au03oXfnw8WqHGu7CFHLo7Qy9s5bE1xra4r8h
	qET7th39qiDldEWg9/N7i6yCRy3gLaNRMx7ItJKpu
X-Gm-Gg: AY/fxX7zTfaQb8JY+jf5RZMPVUX//e/40OFdyiBs/JzVlVnPdUy8qTLvD+9ksOZOQ0B
	+Oo03A1+TV60bUfoZPx72uhfLFCHgsBYx5awOC1ZzKjxW9J3ZCJ2PDi7Vp9c34lB+vjLeL6/Mv7
	kNe5aqYf3qn+YGx2Um8eBkHAs4LlyAxkSOwnkRzkfNxlPFDbQ6d4rcH2cMb/1xW/uNd9XqBf0SG
	pS6V3s4Pq65iOWasXjXR9Qr98xaEFnDbAmwJ6NexdhEbwrDJArZtC0UTVYJcdQ8GD7GBKI=
X-Google-Smtp-Source: AGHT+IF3wEaeGE4ndjbJ+O4SOvj0PM9+HCX6aEOlKK/tBHIhKbAL9jp957sWJAltcb+ZHo9ODcN5M9j8UP20NbMjeDk=
X-Received: by 2002:ac8:5a4c:0:b0:4ed:9264:30fa with SMTP id
 d75a77b69052e-4ffa8516733mr105933171cf.31.1767820684046; Wed, 07 Jan 2026
 13:18:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20221001205102.2319658-1-eric.dumazet@gmail.com> <aV7JKsNpsmnf5oQL@agluck-desk3>
In-Reply-To: <aV7JKsNpsmnf5oQL@agluck-desk3>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 7 Jan 2026 22:17:52 +0100
X-Gm-Features: AQt7F2oKpqsotfbNM_rJPhGb8GTiP1o-eC9nXnBjmqg8EN53gzT3PsKCdpDAVDY
Message-ID: <CANn89iK72b5bSjq0MeedXJ5Onk22Pnw6cjNr0cAYP_-hv8RhAQ@mail.gmail.com>
Subject: Re: [PATCH net-next] once: add DO_ONCE_SLOW() for sleepable contexts
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev <netdev@vger.kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Willy Tarreau <w@1wt.eu>, 
	Reinette Chatre <reinette.chatre@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 9:59=E2=80=AFPM Luck, Tony <tony.luck@intel.com> wro=
te:
>
> On Sat, Oct 01, 2022 at 01:51:02PM -0700, Eric Dumazet wrote:
> > +void __do_once_slow_done(bool *done, struct static_key_true *once_key,
> > +                      struct module *mod)
> > +     __releases(once_mutex)
> > +{
> > +     *done =3D true;
> > +     mutex_unlock(&once_mutex);
> > +     once_disable_jump(once_key, mod);
>
> This seems to have been cut & pasted from __do_once_done(). But is there
> a reason for the "sleepable" version to defer resetting the static key
> in a work queue? Can't we just inline do:
>
>         BUG_ON(!static_key_enabled(once_key));
>         static_branch_disable(once_key);
>
> > +}
>
> -Tony
>
> Credit to Reinette for raising this question. Blame me if I didn't spot
> why a work queue is needed.

Note this is used from one single place, one time...

Why would you care ?

