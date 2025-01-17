Return-Path: <netdev+bounces-159303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4599A1506A
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 14:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C83687A186C
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 13:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030A81FF1D4;
	Fri, 17 Jan 2025 13:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fjUYIRpZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255BE1FDE23
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 13:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737120136; cv=none; b=ISyIVvx4DSOnvDM+EDicKUr+p2vCdBwgktB8mes9MvxIz3+94+Tv0gs7FJCl2kzKuITvYuIFvVEwizTbw5RgWrbcM1HpNu+JfWhur5/aJBh5fzRSWkK4+wK3KypslpGIOY1Za1MBWLkQJB/fW23SNKNL7zc/ouuu+nXfRmtaHj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737120136; c=relaxed/simple;
	bh=39BsaknFgOiEdbF3Yb4xSEmqTiHR56YMJ9X8Ygv2jJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ppm4NzdKMjBSTdsnxqQFN55BLeevh7Bf6spIV/aiqqH2O7YTt9qaTtbwxCy74lKFuAKbBaQgJIYqBhbYW+t32rsTvYiWwAnGKF8WXE37TIftHtT/tQKlDCyFlKYcBAEmr3Tv+cjUQ0KWSAaC4qYZEJjYzurHaPOMg+nKGEGw0Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fjUYIRpZ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d9837f201aso5792425a12.0
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 05:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737120133; x=1737724933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hDVkXTaBafrac7UfqDYs+w32ZWiDV01O/viLpwKSwk=;
        b=fjUYIRpZ5OZuMTgssWwd6bIABx8eYC+Nq9ppP1R86oFgtrOtAKgxYfof/Moeyp73OE
         wDFFhEKDcyQq9n3kSWWpH3PAgJ/zdZsY2DLvCkX9yejxMGtVFpwV3R4W8ra829Ze2YEB
         GXKIoIJqnwvvnqEoLCo4uu+wuuy1gfivHtGhBbNYUNCG0vcXAu53FL+0PqmWc/9yFkcu
         6t97akINPifHvzvvlQJC+K4F8dZLnkEbCtKwAfK1JzoXo5UcPLzJ9o/zOx5ip+6LzhZ9
         bNcC4L9Wj725haAvKo2drtNxUnmxojpv/w8myEFsUAydZ2pADowKNj2MOQfiU/D+FSVS
         P8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737120133; x=1737724933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hDVkXTaBafrac7UfqDYs+w32ZWiDV01O/viLpwKSwk=;
        b=MTGbI2VsqS1SwZK0e0oyyi2jzfGrwQoj9jUVqS5fuVjBv6wEryTHHBn6y6LWhgl6D7
         R/ZGhJ6BKc4OwDyBtIRJaRsDS3yqTqUJM+cne1WeohzXQQHpZoKWyP2xBDFUoIg9CpQG
         sM6kNbJ1ohQTyQqyaT/2wU4+9h4Kae70RSnQXXklFnLyXpzL8Lo1WwRwwyhOF0c7GOYw
         vRWiX+hY4FRv1f8+2ejG63rJ07iomwUhMm81hUH56usOIav4rTUSxA6MzuhrqMzqsVOL
         DC/ybW2ldpYIcPeULnJbfBrZyIzwDenKhGVeVGXggukrEeW5bTlQGHQuwqfZQZhWWHon
         kQEA==
X-Forwarded-Encrypted: i=1; AJvYcCUk+K0qv5Js30Z63A2cIELOenYlF+khQe1hlPF2o7WXZDfFjIa2hXMPNQ3FVk+trIbOxbXpSIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6cPB0h6NnUHd4G2BJ6CiXuKxv2k0HsAERBlHcdoPy3YOK7Kqi
	Qzj6sVhrXd5xaaxR02kmu3v8jYOhDj1pWfX3XBtL2CPAqqILPazk2vIPlaaOpnQTOAKYHjhMK3L
	Nyioi/inM/E2MUE9RisRG7SPNhYFCRPnz/CIt
X-Gm-Gg: ASbGncsQE6miM3DX9ksZBpUT4EUGaJQY4tx9qbDScckIC7MNkjcbKwWl5EiOnyJ121T
	RcmkQ5aTSOXLEDqTIkUjB6m/0cdx+DkGcz/zvig==
X-Google-Smtp-Source: AGHT+IEtfZs96nhUo3VM9nB4pB8VPQzoVioe6/EOtRmUuKMZyzN+iL70qi9mMkIkcXaWZ3IRrtbw4+eBZBs6oruCKc0=
X-Received: by 2002:a05:6402:35d6:b0:5d9:f1fd:c1a2 with SMTP id
 4fb4d7f45d1cf-5db7dcec1afmr2368595a12.12.1737120133338; Fri, 17 Jan 2025
 05:22:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126144344.4177332-1-edumazet@google.com> <Z4o_UC0HweBHJ_cw@PC-LX-SteWu>
In-Reply-To: <Z4o_UC0HweBHJ_cw@PC-LX-SteWu>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 17 Jan 2025 14:22:02 +0100
X-Gm-Features: AbW1kvYbXmVLkChYAQLGYOgwujlsH5OyEW1V3lt_X178uQjL8yZb4aPZX9qWJcc
Message-ID: <CANn89iLSPdPvotnGhPb3Rq2gkmpn3kLGJO8=3PDFrhSjUQSAkg@mail.gmail.com>
Subject: Re: [PATCH net] net: hsr: avoid potential out-of-bound access in fill_frame_info()
To: Stephan Wurm <stephan.wurm@a-eberle.de>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+671e2853f9851d039551@syzkaller.appspotmail.com, 
	WingMan Kwok <w-kwok2@ti.com>, Murali Karicheri <m-karicheri2@ti.com>, 
	MD Danish Anwar <danishanwar@ti.com>, Jiri Pirko <jiri@nvidia.com>, 
	George McCollister <george.mccollister@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 12:30=E2=80=AFPM Stephan Wurm <stephan.wurm@a-eberl=
e.de> wrote:
>
> Hello Eric,
>
> Am 26. Nov 14:43 hat Eric Dumazet geschrieben:
> > syzbot is able to feed a packet with 14 bytes, pretending
> > it is a vlan one.
> >
> > Since fill_frame_info() is relying on skb->mac_len already,
> > extend the check to cover this case.
> thanks for addressing this szybot finding.
>
> Unfortunately, this seems to cause issues with VLAN tagged frames being
> dropped from a PRP interface.
>
> My setup consists of a custom embedded system equipped with v6.6 kernel,
> recently updated from v6.6.62 to v6.6.69. In order to gain support for
> VLAN tagged messages on top of PRP, I have applied first patch of the
> series (see msgid 20241106091710.3308519-2-danishanwar@ti.com) that is
> currently integrated with v6.13.
>
> Now I want to send GOOSE messages (L2 broadcast messages with VLAN
> header, including id=3D0 and QoS information) via the PRP interface.
> With v6.6.62 this works as expected, with v6.6.69 the functionality
> stopped again, with all VLAN-tagged frames being dropped from the PRP
> interface.
>
> By reverting this fix locally, I was able to restore the desired
> functionality. But I do not iyet understand, why this fix breaks
> sending of VLAN tagged frames in general.
>
> Do you already know about this side effect?
> Can you guide me to narrow down this issue?
>

Thanks for the report !

You could add instrumentation there so that we see packet content.

I suspect mac_len was not properly set somewhere.

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 87bb3a91598ee96b825f7aaff53aafb32ffe4f95..b0068e23083416ba13794e3b152=
517afbe5125b7
100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -700,8 +700,10 @@ static int fill_frame_info(struct hsr_frame_info *fram=
e,
                frame->is_vlan =3D true;

        if (frame->is_vlan) {
-               if (skb->mac_len < offsetofend(struct hsr_vlan_ethhdr, vlan=
hdr))
+               if (skb->mac_len < offsetofend(struct hsr_vlan_ethhdr,
vlanhdr)) {
+                       DO_ONCE_LITE(skb_dump, KERN_ERR, skb, true);
                        return -EINVAL;
+               }
                vlan_hdr =3D (struct hsr_vlan_ethhdr *)ethhdr;
                proto =3D vlan_hdr->vlanhdr.h_vlan_encapsulated_proto;
        }

