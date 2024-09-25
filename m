Return-Path: <netdev+bounces-129813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9088198660F
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 20:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36D451F256A4
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 18:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA1984A31;
	Wed, 25 Sep 2024 18:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CDBo+/6N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDEAD520
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 18:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727287226; cv=none; b=kDmGyZkAPRJBP5sEw2d8FcDN7oQBU7/blJHzvMBwXke2hpg2jJOQKSZAkXPiviJ2Rvh5VwglHyb1JpjZ7yYEatpxcpwuCFPmdAtTXCBTWIzyvvKXnwlia0P6zofuxVgm0lwvstCjjoNOuzWF/ov7xNtgezx4TmZbWN3ZdTqPKEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727287226; c=relaxed/simple;
	bh=v3FGxLuzTHzQv8alNgzW+UaBYHHybhyS7oNk+efmsmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=hnT6hzOVnGQeEOb2fzS8sgxVJLBuos5w28wfb9xLaYi/rc/a5ob6cLDGtf6X4adNAxFeifaWyeCnv5/jXt1gQfb+xObZXqNTW+imOQfbdxVq3JkeOONDYIhhGpl0NWXCjAvKYBCqjOPSX6OShzSqGJ7oCNF+ZZIBl8GhVhfV1eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CDBo+/6N; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c275491c61so51575a12.0
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 11:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727287223; x=1727892023; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3FGxLuzTHzQv8alNgzW+UaBYHHybhyS7oNk+efmsmQ=;
        b=CDBo+/6NyJqAty8xy7flNgqaWlK7gEW1EPNKZMPzCEKq0a5VeivMCOZPIbfXjs0ni0
         qSfyT7XIp8lDnuBstnAYPSxu1SY4XHzbDysrVQRYlkf7AxAYoum6HXa77liKus7MBLMf
         hSwqAQTgOi4QD2yW5Dni90vufNhiCbeUXc+ZSRpMdpru8CAxSDqoeJAoiDgRK0HoKu7Q
         zFKdUQRrtYYS81KlBCYcICK5OqizdulrL2p7FTxbuwGZu7v01AkMs4XJs775hKmKOWtb
         /O24HHL99XgZ5/dp7c7pIfInMynyR0uuNf3CbXysxl7BSYLqnf4SB8xbA+cm1JY5g9JE
         06yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727287223; x=1727892023;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v3FGxLuzTHzQv8alNgzW+UaBYHHybhyS7oNk+efmsmQ=;
        b=TvNHN7JBk3qDU57NSYR8ExblAg68CIl4yIf2SJ4wYVd5wzL/SjMmvDVyWdXZ81p1zD
         Gokk3LGDbVvLJ4GT1on+2lyr6fa+hk1WJwkoSUTD/OGih+sr7Rj2ak+X5VC7OROK2n66
         x5czvp0ffMMUbTcvVKs1gk5LHaF1BC5JR6CPL01KkqGHtInmvbPuUJ8tF9fU/mkQVVor
         OmJaJqW8GSJD70hbOL/Je28QxLYXYu3lrwWSmgWfabzFlLv+7nugSaiR+SE1Y6aqS7yf
         WC/E60uXoQ3yPyN0/lvLmKQD0qMOagBaoqjRWiDs+CCYgksdBCV6VQ08h36q+dXcrYx4
         SzLw==
X-Forwarded-Encrypted: i=1; AJvYcCUyiEI25z8/DJKg/Zw3dQkRRSL8EUmm1IVHrci5D/FDhLM2Ur2xuI4xaikQumKyCwvjkYafN44=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoRhWA0JtWGbx6EzQEbgpxLjdy6qit09BBY7B3NwueE5SdpBk3
	Grs1QiBn4vMsaabqQLNYFUT88hLg4tl8b0FHWLrAnnJf4ZHN9EQm2uAiXnaPQzjGR+ANaBTj1xN
	U2rcyi/scK3TzIHjLPCyfnk9KIyZCQMl5TVzW
X-Google-Smtp-Source: AGHT+IHM2DIk6oL+al1xfH47FAGny4q63Pfz3shBWwj95WHyjVnFBY39G2TSIOC2uMoLCp8I7WI0/B6pPsLMw/HNfFQ=
X-Received: by 2002:a05:6402:254a:b0:5c5:c0ef:282c with SMTP id
 4fb4d7f45d1cf-5c72061a2bamr3260506a12.11.1727287222539; Wed, 25 Sep 2024
 11:00:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924150257.1059524-1-edumazet@google.com> <20240924150257.1059524-3-edumazet@google.com>
 <ZvRNvTdnCxzeXmse@LQ3V64L9R2>
In-Reply-To: <ZvRNvTdnCxzeXmse@LQ3V64L9R2>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 25 Sep 2024 20:00:08 +0200
Message-ID: <CANn89iKnOEoH8hUd==FVi=P58q=Y6PG1Busc1E=GPiBTyZg1Jw@mail.gmail.com>
Subject: Re: [PATCH net 2/2] net: add more sanity checks to qdisc_pkt_len_init()
To: Joe Damato <jdamato@fastly.com>, Eric Dumazet <edumazet@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>, Jonathan Davies <jonathan.davies@nutanix.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 7:52=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> On Tue, Sep 24, 2024 at 03:02:57PM +0000, Eric Dumazet wrote:
> > One path takes care of SKB_GSO_DODGY, assuming
> > skb->len is bigger than hdr_len.
>
> My only comment, which you may feel free to ignore, is that we've
> recently merged a change to replace the term 'sanity check' in the
> code [1].
>
> Given that work is being done to replace terminology in the source
> code, I am wondering if that same ruling applies to commit messages.
>
> If so, perhaps the title of this commit can be adjusted?
>
> [1]: https://lore.kernel.org/netdev/20240912171446.12854-1-stephen@networ=
kplumber.org/

I guess I could write the changelog in French, to make sure it is all good.

git log --oneline --grep "sanity check" | wc -l
3397

I dunno...

