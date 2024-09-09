Return-Path: <netdev+bounces-126343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E58D970C2A
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 05:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 218281F224B0
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 03:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C01F18A6D0;
	Mon,  9 Sep 2024 03:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2XOKttn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7347E4C81;
	Mon,  9 Sep 2024 03:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725851570; cv=none; b=agHAJCvBfO1bPPw7TlVWK4jn1f/x0O+PYrwb5SKWmxm1VgDNZoLCFYsEbFud048aSxI7xBYyaO5D253n89qegmqUipy6y0LrKGebxpiNRhrwazs7rBoyAkkGTNmbMhOEtsQOFIxlzMImFy2ruEwuJRIPlgKnJ3IErvuJZJWif4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725851570; c=relaxed/simple;
	bh=Ay8A8mw3nqArbPOXPMNbBvXUESIKmaUesI3RUQVsT6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKIFRnUER0mKw2k3yj4rfrtNe7DU1GVTGdbz7R6Qa/dJstXzFPc7GUa4l4991ZG22X4VYtFfHeuLFotvLxBgkrFioj8QHo90UTW1flwiLxBmTDMV0ZdYlOEKct36jGezJ5yMu5cdGtc1obMJm13eraaQKCS1HEz9gonCquQXyzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2XOKttn; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-39d30f0f831so13494655ab.0;
        Sun, 08 Sep 2024 20:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725851568; x=1726456368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7H5SMCxq/Hcnc2y22bH+y+krbwBtXB/4pIwtkw3dNlY=;
        b=l2XOKttnw+OqKxXwQp32SBTGM3XpW7QlOjxfY79OyKuka+V8oB0lSX1oarNBNhYoow
         it7A+bq5gUbl+p5A8BWUix6IAhvquBcst3MEi8j+nVdjMmCxaRT0xoyXyRpHvTkVleWF
         0qsFLs8YneNFpCbf6p2ltwEbVHZdxzABaYzsn7xEOg+EgaZUTr6Y+qvTKFRzKN17+hDr
         AV1N6JwGnTDcfoZO0zObKtrVGtFJVlDWcvCu9ng69qqYbRFsWyy8AWSxJI81ORPC9cDj
         EM6fE+s5NuwhmoMazeJLrJwQ6VSqMZE8tWw8/wki7Tb8gbNPBUYH3MfboRog4zRRpMXn
         wrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725851568; x=1726456368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7H5SMCxq/Hcnc2y22bH+y+krbwBtXB/4pIwtkw3dNlY=;
        b=nuqxUO6eeCJ+3biHPv3YQA2f+HTE+garbUcWHzrZPMMcSatme0LqgNzSw3W7ZL3rd3
         eZNeJ4y3JUloxVfRY0BSHpEWBC4GUKhX+WEn60T4sNu0AbyEKODmnMH0/k18Cwm6DKD8
         NJeNeCO5wDWAQCFuf593TZQYA4S12/NYd+pOe5uVzqBLOTslHv8/y0yq+ZvPSXY4yZWG
         RVJTZjJJ5eCxKLr61o4hAoJszIwkeT234UYQQ0SPlVZ2wtUs8W1tbnCrl6HSEF/bDtOC
         leBTkQiK2WEUBWNO5OHvkHR1RgUyHARoT+6UhAywWEpzhEGN+juHKL7M2p3grmhpdjyP
         lmyw==
X-Forwarded-Encrypted: i=1; AJvYcCVH2OCeV8nYiG6VplLF2MNwkffdCfgPTf9l4rEO4B9SBsGdbrJqOnPBUEWInbSD/W2Wes+Wqklf@vger.kernel.org, AJvYcCVXgKV/mj77U72goOWVYba42eyjufutHGKmw5/VvNHFJ/ugG4W+JeujUZLsSpfV9cijN/X6/jVtxq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhDlE773Cc+1JroOY5wZ3DHWH+4o5ScQfHlyKDsXdu+FryH8og
	Gu2G5dsI6z6oOydmuCsM1HEacJ3NhrD2Sg4A350XB/HV6DvJXg+K2r9HXUr5hPT5RDgcCnYqlWQ
	AdFnr7X/G4IYsBvkRvcuW4o+PKK0=
X-Google-Smtp-Source: AGHT+IE65/jzw1nDJ6lz9qG3PI9iVMv0N7DwN3Z65uqEHGRsPK2BWK/hCvLDbgXA3z5Md53bJolJWojIjyUZeJqaBEY=
X-Received: by 2002:a05:6e02:1386:b0:381:40be:4ce6 with SMTP id
 e9e14a558f8ab-3a04f09be4cmr127247945ab.11.1725851568412; Sun, 08 Sep 2024
 20:12:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909015612.3856-1-kerneljasonxing@gmail.com>
 <20240909015612.3856-2-kerneljasonxing@gmail.com> <66de637f78072_bb412948d@willemb.c.googlers.com.notmuch>
In-Reply-To: <66de637f78072_bb412948d@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 9 Sep 2024 11:12:12 +0800
Message-ID: <CAL+tcoAkPQzFmbDRD=LjB9-nQTYX-bHekzpAUYq8bGsUbmF8Ow@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/2] net-timestamp: introduce
 SOF_TIMESTAMPING_OPT_RX_FILTER flag
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, corbet@lwn.net, 
	linux-doc@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 10:54=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > introduce a new flag SOF_TIMESTAMPING_OPT_RX_FILTER in the receive
> > path. User can set it with SOF_TIMESTAMPING_SOFTWARE to filter
> > out rx software timestamp report, especially after a process turns on
> > netstamp_needed_key which can time stamp every incoming skb.
> >
> > Previously, we found out if an application starts first which turns on
> > netstamp_needed_key, then another one only passing SOF_TIMESTAMPING_SOF=
TWARE
> > could also get rx timestamp. Now we handle this case by introducing thi=
s
> > new flag without breaking users.
> >
> > Quoting Willem to explain why we need the flag:
> > "why a process would want to request software timestamp reporting, but
> > not receive software timestamp generation. The only use I see is when
> > the application does request
> > SOF_TIMESTAMPING_SOFTWARE | SOF_TIMESTAMPING_TX_SOFTWARE."
> >
> > Similarly, this new flag could also be used for hardware case where we
> > can set it with SOF_TIMESTAMPING_RAW_HARDWARE, then we won't receive
> > hardware receive timestamp.
> >
> > Another thing about errqueue in this patch I have a few words to say:
> > In this case, we need to handle the egress path carefully, or else
> > reporting the tx timestamp will fail. Egress path and ingress path will
> > finally call sock_recv_timestamp(). We have to distinguish them.
> > Errqueue is a good indicator to reflect the flow direction.
> >
> > Suggested-by: Willem de Bruijn <willemb@google.com>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
>
> I really only suggested making this a new flag, not the main idea of
> filtering.

You provided a good alternative solution, so I was trying to give
enough credit for your help and guidance :)

> > +SOF_TIMESTAMPING_OPT_RX_FILTER:
> > +  Filter out spurious receive timestamps: report a receive timestamp
> > +  only if the matching timestamp generation flag is enabled.
> > +
> > +  Receive timestamps are generated early in the ingress path, before a
> > +  packet's destination socket is known. If any socket enables receive
> > +  timestamps, packets for all socket will receive timestamped packets.
>
> nit: s/packets for all socket/all sockets/
>
> My error in my suggestion.
>
> Not important enough to respin.

Got it.

Thanks,
Jason

