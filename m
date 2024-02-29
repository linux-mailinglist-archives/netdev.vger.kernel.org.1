Return-Path: <netdev+bounces-76218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4A786CD52
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 16:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AD1C1C211FE
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 15:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E78514601F;
	Thu, 29 Feb 2024 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RZWJzkTQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACA314A0B8
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221529; cv=none; b=BB5JEy1aFs6MAOUolUESSlWUK03Vt/R+c6FucDsMKRRGeVTUmvOx2k6i1z6VL5vIwuW44zYE2qwCipw5VjN8QKpO7y+bhitNYMIGloSzm8wUh4B+oW3tsLQtSY7cfUV6AcKZP4TAyYnczpcWagVGCfRhGKWR5uJoFAJ8DZwA41k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221529; c=relaxed/simple;
	bh=408xhp6x5W6lqvMRZBq0xehtCKKUdRkhkZMTBco/QSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C6WfmIBMz/KAOXR5/sdbIKFf8ZNGVW24ZBWrGP+AIESOcBWrF6S6u7/eBCWghedMNIm6TMaYj/gxdq/spLN9gGMxEuisEBvyWysAUrPGik39XpAcN9UcEJgoS+LXJBBkvFanhWTEKDxI13hrts5MR4Qgq9VTku8knLDbEg4059A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RZWJzkTQ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56693f0d235so10825a12.0
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 07:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709221526; x=1709826326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vPNfZ7Z/mZ9jl0PBVDTzdWI7DpwijzBcm2qmHdT3Ns=;
        b=RZWJzkTQBQuAdcTh33367OeO2RMGdps8vzni/TQHU8IpBAqJMhIoPUQcqv4OYHbxj2
         8hqW/d+iEwd8g/LPZGoNMpTwY7g9c5VTCD/PuAU8C0rrfc8AlwkqAT4figsGfAoN6/9w
         mD6eFsqH+cCll3dDAz7g5hmkxsAUWudFbe/xp7dKO72vFf2ZVGUossI6J/smYj6ynY3A
         qp6efu5sBk/DJSJZ5500404gZaLtLIx4fmLWiFVmyLl/W97+5T1jLknv7PRi3hAfDmAZ
         qwmlMWatl1k4mri36zPkmDHOhOkrfXR2L+NYKwoGBAcW5ZHfcjtNB58lwxI9Os+m4r2Y
         Zp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709221526; x=1709826326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0vPNfZ7Z/mZ9jl0PBVDTzdWI7DpwijzBcm2qmHdT3Ns=;
        b=abJwzThdkRFCPnSliA3QFo1VUQM+Jnwihs2Gs+HoSlrpHT4Wvi5B9vo0OvKwMNNi6A
         cRhuCB4wc/p46Bc/FRE6QZde0xO5bFmBCAK4/5mVYfwdhJc+CgGmX7UmcAGyc5SlTgqe
         3tpu9KwdN+3wlf8FiY3dVRBHzHN6mfYU4MmBjYKvX7r0fyWC9wyQU2iiIHZ57Qpr/7sY
         RdBa2jOHU3syumJPHxxOiIcp5o6QTgvr/uWZTOcejuNlDGo1cYwVXw6V4MY2m9XTfoeX
         W9Ko5yKpP/Zx9nheRRfA3/FBhQnJmxN88ZZxDDJSEK3pjNX6Bh3IHtr3mjY1vnn9fYI4
         cfdA==
X-Forwarded-Encrypted: i=1; AJvYcCWMp174xTD/Sg/GmtPTKxzfA9NJkQq2RmRfghD/zYND7rZKfvNlbm2rsw4ClsgIvSNCItUyZgTnErfQ5lr/7qeGOGAFAlSa
X-Gm-Message-State: AOJu0Yy73foAYXohbiXWCSqdN0quQjPXb05+B24TBV9DbQxSfwSxpRzM
	WDxYhNn6f4WgrBsWf5u8a9eBH91yJ8qyVpINajgeXw5v5ynKmeyZCQwB3xncHg0N4W5qNPaGEH5
	5GHguOh4p/30BN8z4SLIkDbnEgraJG+EHmvIr
X-Google-Smtp-Source: AGHT+IHa+mNdfrGkE1VBPevQT9Ps/5jmmPKNhvmb21ouHYsJ/l4B4r7Sp67h+6qhyj+sq6SBixXcB5GP+ZfM6uacZ+c=
X-Received: by 2002:a05:6402:452:b0:562:9d2:8857 with SMTP id
 p18-20020a056402045200b0056209d28857mr143973edw.6.1709221525842; Thu, 29 Feb
 2024 07:45:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229114016.2995906-1-edumazet@google.com> <20240229114016.2995906-7-edumazet@google.com>
 <20240229073750.6e59155e@kernel.org>
In-Reply-To: <20240229073750.6e59155e@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 29 Feb 2024 16:45:12 +0100
Message-ID: <CANn89iLMZ2NT=DSdvGG9GpOnrfbvHo7bCk3Cj-v9cPgK-4N-oA@mail.gmail.com>
Subject: Re: [PATCH net-next 6/6] inet: use xa_array iterator to implement inet_dump_ifaddr()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	Florian Westphal <fw@strlen.de>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 4:37=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 29 Feb 2024 11:40:16 +0000 Eric Dumazet wrote:
> > +     if (err < 0 && likely(skb->len))
> > +             err =3D skb->len;
>
> I think Ido may have commented on one of your early series, but if we
> set err to skb->len we'll have to do an extra empty message to terminate
> the dump.
>
> You basically only want to return skb->len when message has
> overflown, so the somewhat idiomatic way to do this is:
>
>         err =3D (err =3D=3D -EMSGSIZE) ? skb->len : err;
>
> Assuming err can't be set to some weird positive value.
>
> IDK if you want to do this in future patches or it's risky, but I have
> the itch to tell you every time I see a conversion which doesn't follow
> this pattern :)

This totally makes sense.

I will send a followup patch to fix all these in one go, if this is ok
with you ?

Thanks.

