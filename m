Return-Path: <netdev+bounces-249666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDB2D1BFFD
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 02:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C924E300CA3C
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 01:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A50F2EBDE9;
	Wed, 14 Jan 2026 01:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ILmxRUS9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC8120DD72
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 01:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768355664; cv=none; b=Ewf7+9nwWHz1qKQ+F7WSbCMgtJCmrp/utEuRriXWD99ZCLXn2uwYXbSZkiLln6ZUm6LqDbIsY+IhaBIQgz4OXYpFVo2g6yrEO89q/VO+vzxfQgmQvVOcY9StyMuzA61Pxfr/JHafD98PG923BVoyGxXEReVSXxQVWng5n6DfEhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768355664; c=relaxed/simple;
	bh=/6aqy76u2W9VKAySido3V9a5UUY51nL1QvLE6DSpitk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0TnXO4NLXLz+p2Z0zYXYSYqcvR/S6Ml2xUrxhC97h9ebwhiqMLoWoF5xQjN37wjf8d+coJQ7zTqa6y0VnNmlBmiWz2pR+snMqnRfJhvv+qxNbxmvyvE8TYSsvN0cW17Ayq746Ctey4X6TvCYZdH7u/4GBRMnC22w2YykYTp7JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ILmxRUS9; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-88a3bba9fd4so83680926d6.2
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 17:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768355662; x=1768960462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1JMzsd+AaLKlWRubKvOFKNrRDPCucP7s/Qk6uX8gUU=;
        b=ILmxRUS9F4We+in8kdsbwjb+mmcYiWvuUUBb1wyLI/Qj1E7vsrpdQOJy3wMCjGN92o
         Yz9uw79SyojpDg86Zv57pibbM6kMfngipJVt0iObmYumgLD56tl3rA0WZTF7W1UrIIAG
         mReXSUSizuzdPDnjFxvvkmL12aElMsAkTEFI/UP0iX8OFEYe2GalZpfd8iyOVAbKKdWE
         X05i0ANbHvpHesLBBBJcF+4rPbH4V/Hzet441+SM/YdMy+uo6j/4S5DpyWBLtmwEnG2C
         iOlHn4gl7ioUg1xW/gW+fXjqOE2D5U605EO26iH8JiQ22/zEg6o71fMMrFDo/NmMpgI5
         qXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768355662; x=1768960462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X1JMzsd+AaLKlWRubKvOFKNrRDPCucP7s/Qk6uX8gUU=;
        b=Cn4bhnhI2FKhz3AHlEWbnJP05VzWRN7XMYpk3E7Q0N2/uFc8nFjheF7yp22vbMO5Je
         3siMzhGtzkkfU5qEvGc6dSfgXnQrpc/cAi2jCE/5+jFpM4Ktmb+jF0oNDo4k6C9dyYZU
         jo2J/L+GODV0Kdv2P9b+W3qcby4l5Lp5zAgBEt70mo9K8Z+Nq/o7goAHMQiDOULQYLLM
         JEx16N7gX99MSqGJLZx6dJ+gkFvmt6PuSaNfTzuE86xIPUGGB5iI0MFNQNI+uASWcliX
         rOP0N/omz1KVreLVjU3t8dJI4sFiHpMF6LX8ZtMaRCpVSEM+YtCBqkwy4bSYpWnu3ayi
         YM9g==
X-Forwarded-Encrypted: i=1; AJvYcCXVATXyenpEtlcYnn4aKJf0bl8IDxrIOuF3iSMy7ec0qXqbc+ob04lQNeG3NeYwdJL6K4Ngb4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHZkIwa968x2joO4QGFTlP9ZAILHwGEoenF8/gwAe9gVV/RFv3
	dBNibpMJvvyK1D9un+dYynNRYmQ0Wnb+RaIfPI8nX/AGZcd1bJ7dJqiCE1dT73F2jb6nMpo+XtS
	ivPEHj9XStsJq/UkppGg//QWchip8F02EDlK4ge2C
X-Gm-Gg: AY/fxX5DpRyqfD6g+v8wsCz4qCq4GYCYcpiHTPcZF76O9JJt4geQ4HYlD6Xc8wD2/7g
	Y9jPL1X7qxKy3cG+djCWqswz+zlI3Iy5H4N1E+L/ACZNi7Ld3boR8EFHtOMU0MLetRvcEm6xWaJ
	G5VHuXKjUcjsWzotq31QSDHDJy4npS0HK7OT048EEkKrjzm1hl1C76euR9fqvzhoqCdfd4GPXjU
	sD2S3IAw1Hy3O4MMRmlia8t+S0OMr2AG2KI1FkLEoCqgpwlu1crtku0GqMPpzVCXXySKqd5
X-Received: by 2002:a05:622a:8c6:b0:4e7:2210:295f with SMTP id
 d75a77b69052e-501481e483dmr16431961cf.13.1768355661444; Tue, 13 Jan 2026
 17:54:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113131017.2310584-1-edumazet@google.com> <20260113174417.32b13cc1@kernel.org>
In-Reply-To: <20260113174417.32b13cc1@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 14 Jan 2026 02:54:10 +0100
X-Gm-Features: AZwV_Qh9QDRQQdEfFkFpY_oUWCCqKvjQoducQ3rofdkF2r6eeFvLILO6teMJJRU
Message-ID: <CANn89iKDrx0DP56AynzMuKv4so7DFEFpFE2yHg6gCGugzd4ivQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: minor __alloc_skb() optimization
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 2:44=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 13 Jan 2026 13:10:17 +0000 Eric Dumazet wrote:
> > We can directly call __finalize_skb_around()
> > instead of __build_skb_around() because @size is not zero.
>
> FWIW I've been tempted to delete the zero check from
> __build_skb_around() completely recently..
> It's been a few years since we added slab_build_skb()
> surely any buggy driver that's actually used would have
> already hit that WARN_ONCE() and gotten reported?

We could keep it for a while, WDYT of

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 77508cf7c41e829a11a988d8de3d2673ff1ff121..ccd287ff46e91c2548483c51fa3=
2fc6167867940
100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -458,7 +458,8 @@ static void __build_skb_around(struct sk_buff
*skb, void *data,
        /* frag_size =3D=3D 0 is considered deprecated now. Callers
         * using slab buffer should use slab_build_skb() instead.
         */
-       if (WARN_ONCE(size =3D=3D 0, "Use slab_build_skb() instead"))
+       if (IS_ENABLED(CONFIG_DEBUG_NET) &&
+           WARN_ONCE(size =3D=3D 0, "Use slab_build_skb() instead"))
                data =3D __slab_build_skb(data, &size);

        __finalize_skb_around(skb, data, size);

