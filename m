Return-Path: <netdev+bounces-72494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 757778585A6
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 19:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8CE81C23300
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 18:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020731353EF;
	Fri, 16 Feb 2024 18:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yZlxN9LA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D101353F5
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 18:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708109155; cv=none; b=XPClzkPue2P6XPTFE3IIctoeK9v0xQ8fQG3wXFY+G8ZE1vVJmESr1k3Zw+u5RjYXiBZZqFJsLwYte16usM9+HxOEuMUhv+I+zfhXeTl8XyHOgcX7JvCZSzqA+ALRFGclB48P4CbudMeUVgmDpR0DW01bT5nksOuJveIy9i2DIh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708109155; c=relaxed/simple;
	bh=xL5njaKZTLPLQp18TE8okk0OD0L3Unq9XV1SmRPOGWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ICqLl6puv5km8XXqtKs7XGzGgdQtfiNIQlJACl16lG6HFYLJejrN81CQFasOR0cEK61FhGEwU4Mn96lGhW7RZ0PzibhdcaXLtphwFEczUPOZrS7I7u2kq69C0lS6tILKtrYcCOt8wYiFeOFQoGxFY8hmgEkNd0cmFihIF/X558I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yZlxN9LA; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-363c3f7dc20so5845ab.0
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 10:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708109153; x=1708713953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLDTPlS4ViQ1CSZl9D6URfWqsRaq0fnTo/1FRytbftA=;
        b=yZlxN9LAVy0DOQE8c9TGurn/q0IFkt64vtFB8UpE9sqn+I65BhICr1wI0IUrpRh+6l
         kzhOOrlX2zVrHMlLLRv0M3slb9IhW+GAcdrgBpWgdtGLXzNOSql15JqmqcujDl0O2Vg/
         cLLqCVRgpplqN3EXCa4uqsyQRf8c906LWTEodeMbuNYe3OJK6faSXI8tNyC06wbCR6QK
         MgHXo0yE85CMTDocEE0Z2nlZgY6/2erDGFKWT+BLuG2eWHWZ1cvGQ8NpzyJWDwuQW8+N
         JpaHs/M0dNPhu3Ft0+UdrlE4n7ja3Rg3+/yU1KJJILCu47HmbL9THfA4xudOPgkMOOsu
         5xsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708109153; x=1708713953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LLDTPlS4ViQ1CSZl9D6URfWqsRaq0fnTo/1FRytbftA=;
        b=GQ0GwQiGgnIfPmfynL/vyqNavaTSAyqgvUt2pBpYYo3W3bO88odH8aSF3C2s5/RgK2
         Lwn1j2EWU0JuOE8+L7VSZfVxd+ZZRmBe6RFo47JTFYeY8Mq1mfhwrqm9leoqFcdi+lMX
         pKY3kmMyObd4CCN/KXZkHycETwlLGs0xjxK6l6+Jfnd0U4pqoRHDWdvjQMMG2KC923Gi
         pxDFHXAd/xHkOeB6RoKUXO/jb875oxDCYgcvX3sjQ7d6M81ZNzJzsubcBdNvxHPfrW9V
         UT2Yqn8VatnOuKBGZ3ov5ZktFULIz2KYy5T32BEmHYC2REduGa9D5I0bUEDnn2JHlZS8
         c9TQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjfbx9nIv7dN4iC+G3JGgu//zFVK76HPCPO2kB0O6Yl/kqmqc2cO8wcGTTHLsXr2mFxvoeZCmJzf/Zf/kN4IT24ckUxXy8
X-Gm-Message-State: AOJu0YwWfMK7JoH9w5VOUu3PxWypt9MO335dgSKS1NEZlt+1adV2X4NN
	TOuy8kExYAKNGOEgk64Y8rtN3rj9BAB0y93hLiroLCGms4oojxdpWJumMfCSAXTyni+9d5pmmzG
	JXe06RFV1AbdZmLl/oHYi6QiQYyE78CLycH6i
X-Google-Smtp-Source: AGHT+IFu/Tl10B4BCgdhkVBwE/NPQCGO31aX0SPuQ2bAZb33WxC1H+Rj8Z3BWlqowPH14vGrzjQappquaWk/lBx21jU=
X-Received: by 2002:a05:6e02:304a:b0:363:bad1:b8d6 with SMTP id
 be10-20020a056e02304a00b00363bad1b8d6mr21553ilb.1.1708109153177; Fri, 16 Feb
 2024 10:45:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216094154.3263843-1-leitao@debian.org> <20240216092905.4e2d3c7c@hermes.local>
 <0e0ba573-1ae0-4a4b-8286-fdbc8dbe7639@gmail.com>
In-Reply-To: <0e0ba573-1ae0-4a4b-8286-fdbc8dbe7639@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 16 Feb 2024 19:45:37 +0100
Message-ID: <CANn89i+5F7d4i7Ds4V6TtkzzAjQjNQ8xOeoYqZr8tY6tWWmMEg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: sysfs: Do not create sysfs for non BQL device
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Breno Leitao <leitao@debian.org>, kuba@kernel.org, 
	davem@davemloft.net, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, horms@kernel.org, 
	Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 7:41=E2=80=AFPM Florian Fainelli <f.fainelli@gmail.=
com> wrote:
>
> On 2/16/24 09:29, Stephen Hemminger wrote:
> > On Fri, 16 Feb 2024 01:41:52 -0800
> > Breno Leitao <leitao@debian.org> wrote:
> >
> >> +static bool netdev_uses_bql(const struct net_device *dev)
> >> +{
> >> +    if (dev->features & NETIF_F_LLTX ||
> >> +        dev->priv_flags & IFF_NO_QUEUE)
> >> +            return false;
> >> +
> >> +    return IS_ENABLED(CONFIG_BQL);
> >> +}
> >
> > Various compilers will warn about missing parens in that expression.
> > It is valid but mixing & and || can be bug trap.
> >
> >       if ((dev->features & NETIF_F_LLTX) || (dev->priv_flags & IFF_NO_Q=
UEUE))
> >               return false;
> >
> > Not all drivers will be using bql, it requires driver to have that code=
.
> > So really it means driver could be using BQL.
> > Not sure if there is a way to find out if driver has the required BQL b=
its.
>
> There is not a feature flag to be keying off if that is what you are
> after, you would need to audit the drivers and see whether they make
> calls to netdev_tx_sent_queue(), netdev_tx_reset_queue(),
> netdev_tx_completed_queue().
>
> I suppose you might be able to programmatically extract that information
> by looking at whether a given driver object file has a reference to
> dql_{reset,avail,completed} or do that at the source level, whichever is
> easier.

Note that the suggested patch does not change current functionality.

Traditionally, we had sysfs entries fpr BQL for all netdev, regardless of t=
hem
using BQL or not.

The patch seems to be a good first step.

If anyone wants to refine it further, this is great, but I suspect
very few users will benefit from
having less sysfs entries for real/physical devices....

