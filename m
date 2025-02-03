Return-Path: <netdev+bounces-162303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43ED5A2672D
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 23:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9D331633A6
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 22:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFF42101B3;
	Mon,  3 Feb 2025 22:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtfvdOxC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97791D5CD4
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 22:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738623270; cv=none; b=XdBqDFbIjffowzUGD5+Qyuenh0cQj02sIdpUJ+KnP1wpY0MNpNZPZXaNKAUGhf/xTwkSZRJ5DDLZGyLOArhfB1z2k6zpUKO+D8WiC7Zgr+QYMZAAULpSjpSA4Yq/Q/hwSaM0GkLBecw3C69nagCPSBRVdO8oOx7X8ieeQqyZ5BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738623270; c=relaxed/simple;
	bh=87Q5QWo5S6M1JMUSX97FyemoyI3irvNhF8Gua0Eh3z4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=HbYUE0SIGup7naL6Wb6yyXiUTcoJ5rxe8REnAvR8++FLanZ/I6+uFTCTxuLQpSbn26iVlQByyLx/jaPiW/bcHNSltt24/MGWLbiebE0p/bMxt6U1sf1NFtZrJPEglanusaY0Kmqwm+KjlANK2j9hmP1umklFJ1ZOk7k/PRxmGxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtfvdOxC; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b6e5ee6ac7so447997785a.0
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 14:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738623267; x=1739228067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87Q5QWo5S6M1JMUSX97FyemoyI3irvNhF8Gua0Eh3z4=;
        b=GtfvdOxC5ndRe8fVSxXkrsAbdRM1XZV+l22imvHVENHenZQ3CNYVGFcPsIoHzK2Lsu
         Fk6BTXWmzWB6Mc9TYeHm5ZdfDxQKkmUKATUW/CHeDRnU3pfPkwqqDnsgij+kB/DDp9WN
         jwozIAHep+JW65jG3mUW5kUD4b5028uTSBbl/vtcGfAZIaZgsugGABb4/r4+vcnDkR5Z
         18CiSVYRmyeMCnoNvOYp8NagjRXPPbdrt9KrJJHn8/5+GpCfogVsnoGOc/K/e2KVfN9D
         VWcmTh0WbNDXEI6FhVyJ7hfdE5F+ZGqWKA1h0JrVk0wcgRQjrUUv5JwYQCsz1T2Ybsq+
         ev6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738623267; x=1739228067;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=87Q5QWo5S6M1JMUSX97FyemoyI3irvNhF8Gua0Eh3z4=;
        b=vU9IvbWq5z/FWclW+Ofar+sMPeWeMhbBB0hRcwI3GDBluaBN7mfyDrw0J8nOh2Rhhk
         9owdttrDlwgQlq9AaevlJI9r9pfnfvaFR4Yzg5Dyu1TSjgEAQbZsIn+1AhFHt/0xHdh3
         vuI4rAoa12CLWzczZF9/wgY+Ys3UY664CUhbXmeLF4tejqcdzsGwSWRntUAIjuKlxNEA
         wRMyOL+LHo+WvGDaRVeUYuUXuQT2cw3RRFvwevx+SM7qF9UqAZfeICGkoFr9d5qu+dlZ
         Tl6c3CCebYimlc1TD0t0ZROglEeOtgf+LN3816SmaHdS9X7P1Bs68wbCMsz7lHRsP/WG
         rdNA==
X-Forwarded-Encrypted: i=1; AJvYcCWmbNcm/DRgyzvJNkZKx+d3FHvcFcPed9hKhtBIJlmjg0KYPWwvTUJ/+9a5jH8rwcCjwzIZBjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YytoIFEyi24PasvMF+xWWF/FgJm5MxEgNwueZVqYEF9oKf8S/ir
	WT/ncPpPQfvnjsgL8wY7p9yb6vEZVCtyvBW6pZ5elVcNVngVm91FmOBBDA==
X-Gm-Gg: ASbGncv6yePLONoDC1ARxzvj+UMbTD30etDcyG7Is4prD2l8T9QiA9FHjqLALeZNbb7
	BBwS/+ahjQFwrwawHGhDhIxro/KKh6yhz7J35KfzgbD6ZLQfvaCvLgCseTtfvootLdfyTlIbCh7
	/cfW+bPRJ/r/kqxgIAkyos/0jfkPMeQ3oi3mDNuj0AKtVcd7m9AOvznS09LQbql2o/sMhmYbn8C
	6pJh5/yzkW+vCGaz7Yd/g4D+UdeNCLxxaFmNx1G15ukWpQmcv1PpdeQx1543o1ShVumWLBOTO3N
	TI6G5h4Mv+7jlzvIGwHFHQF5xlrbhg7WN3xiOC0HLwfX51w6XJY3LD5EkcoTHMI=
X-Google-Smtp-Source: AGHT+IEphNaDaWqtgCaRtVSzRKWszRBlb0n7aM9bKG74/kCcR6CVZmQoTd0G476qAbdiLnA0dCS7+Q==
X-Received: by 2002:a05:620a:2991:b0:7b6:5f2f:526b with SMTP id af79cd13be357-7bffcce85b5mr3236344985a.15.1738623267562;
        Mon, 03 Feb 2025 14:54:27 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a8bba69sm580190185a.8.2025.02.03.14.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 14:54:26 -0800 (PST)
Date: Mon, 03 Feb 2025 17:54:26 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: stsp <stsp2@yandex.ru>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 jasowang@redhat.com, 
 Willem de Bruijn <willemb@google.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>
Message-ID: <67a149227c100_46ecd29438@willemb.c.googlers.com.notmuch>
In-Reply-To: <efceaa29-93d0-482a-95d9-28b176c1ffbc@yandex.ru>
References: <20250203150615.96810-1-willemdebruijn.kernel@gmail.com>
 <48edf7d4-0c1f-4980-b22f-967d203a403d@yandex.ru>
 <67a114574eee7_2f0e52948e@willemb.c.googlers.com.notmuch>
 <efceaa29-93d0-482a-95d9-28b176c1ffbc@yandex.ru>
Subject: Re: [PATCH net] tun: revert fix group permission check
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

stsp wrote:
> 03.02.2025 22:09, Willem de Bruijn =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > stsp wrote:
> >> 03.02.2025 18:05, Willem de Bruijn =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> From: Willem de Bruijn <willemb@google.com>
> >>>
> >>> This reverts commit 3ca459eaba1bf96a8c7878de84fa8872259a01e3.
> >>>
> >>> The blamed commit caused a regression when neither tun->owner nor
> >>> tun->group is set. This is intended to be allowed, but now requires=

> >>> CAP_NET_ADMIN.
> >>>
> >>> Discussion in the referenced thread pointed out that the original
> >>> issue that prompted this patch can be resolved in userspace.
> >> The point of the patch was
> >> not to fix userspace, but this
> >> bug: when you have owner set,
> >> then adding group either changes
> >> nothing at all, or removes all
> >> access. I.e. there is no valid case
> >> for adding group when owner
> >> already set.
> > As long as no existing users are affected, no need to relax this afte=
r
> > all these years.
> =

> I only mean the wording.
> My patch initially says what
> exactly does it fix, so the fact
> that the problem can be fixed
> in user-space, was likely obvious
> from the very beginning.
> =

> >> During the discussion it became
> >> obvious that simpler fixes may
> >> exist (like eg either-or semantic),
> >> so why not to revert based on
> >> that?
> > We did not define either-or in detail. Do you mean failing the
> > TUNSETOWNER or TUNSETGROUP ioctl if the other is already set?
> =

> I mean, auto-removing group when
> the owner is being set, for example.
> Its not a functionality change: the
> behaviour is essentially as before,
> except no such case when no one
> can access the device.
> =

> >>> The relaxed access control may now make a device accessible when it=

> >>> previously wasn't, while existing users may depend on it to not be.=

> >>>
> >>> Since the fix is not critical and introduces security risk, revert,=

> >> Well, I don't agree with that justification.
> >> My patch introduced the usability
> >> problem, but not a security risk.
> >> I don't want to be attributed with
> >> the security risk when this wasn't
> >> the case (to the very least, you
> >> still need the perms to open /dev/net/tun),
> >> so could you please remove that part?
> >> I don't think you need to exaggerate
> >> anything: it introduces the usability
> >> regression, which should be enough
> >> for any instant revert.
> > This is not intended to cast blame, of course.
> >
> > That said, I can adjust the wording.
> =

> Would be good.

Will do.
 =

> > The access control that we relaxed is when a process is not allowed
> > to access a device until the administrator adds it to the right group=
.
> =

> No-no, adding doesn't help.
> The process have to die and
> re-login. Besides, not only the
> "process" can't access the device,
> no. Everyone can't. And by the
> mere fact of adding a group...

A device can be created with owner/group constraints before the
intended process (and session) exists.=

