Return-Path: <netdev+bounces-140552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB679B6E22
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 21:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9127A2808FB
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 20:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BC21E131A;
	Wed, 30 Oct 2024 20:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elv/TeYx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723542141B4;
	Wed, 30 Oct 2024 20:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730321437; cv=none; b=d+CdsPK9qe7bNtuB/weoS1+Gi0qz9Ku3FPoJWVrzMBGHKc2Np9IiKpg5GN6+pIyjfFhF1QoTbiubvdwkQJG1YbGHqUuhQ3u5U/31eU6eDM8ljIYgoFMZNFhv+pvdJ4owK7lqy4+dIvchxXn6I92y2MhJfT9ZPmNKIr3fatwkVMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730321437; c=relaxed/simple;
	bh=WjSQd/rxAqSHuJW8HdEhPB9iHTOYu6zY1kCyYakZ+lM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oT7hQrFD6SUxk3ImWanUWa541jRquwVpCjSWDRU5j+4AUDIa36S9yb2jekN3rpWoMfIDe9YKgMMzPZmABkzV6W7c1sgCWw5PTYqaMpHH8v0Hrpn0o/yiNX0TGj0HoxEZhd8a9ZSNG2TwmalHU+qwjYYfddenFjbKrN8vko8sbmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elv/TeYx; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e30e5b1dbb4so243040276.2;
        Wed, 30 Oct 2024 13:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730321434; x=1730926234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xOw1HOOn6G0iO4613p+4xk6aJf5f5iMpqNMkj1owSE=;
        b=elv/TeYxMcRiR/d20Bbm2jprkfHDdlw72W9WlF+wJWbTxohf+GhRjC9BkotYBRmaZ8
         ucsnkZB+wfWRso3Tw066belacINLQ9BjUO21YoE4Cxqi2NmbU20hc9Pgo18TgTT8zty/
         ek9OtXNksgIbagMn546saxoGBRCTdrkf5lO5oCuF7BG17SHhBFFyjlWSuFxyAAqzScjL
         Vkelce+oUDzycJLV8s+IcKhgWzNMmbLuunRfIY4eH3QrYwNyzqFygagNMn76umPF35pz
         BpmzjjWT1NSO7fb86OBEm4vpR8qFXVgf+nKzna1IOzSxGlVXJlIOlaa8jYKwCKORvUGm
         Fj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730321434; x=1730926234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xOw1HOOn6G0iO4613p+4xk6aJf5f5iMpqNMkj1owSE=;
        b=mjhrLk2vT6EiyvA/U+YWZTLqGJbm88uVPbl26aKXP/bgHt7tQ89WG99UtViZMCVfCl
         aKrbYJ+Nu48D5rIix1Wz01T5ORUbqRF9v2Gmfn16SUovKcI/+iqG4FOMvsfgxUJg+isB
         gyXyZECXMKqc8lx+ojMUaWdgccW6lXtJHMrjIXlBG2NY6QPZaFQk7uFV3LfrgS/mG2c1
         lZGtaID5NImb1SWqTnWlncPc1AsDSvfwgge7QO+0u//0bMW1Q+7EAXRKXKRI0O1kb96r
         aNGyZM2K7aPRZggzXza5jI7Fl1zTWuABxphHuRG+/+mytn7jMR1CpM/4hJQ9n17ilhWE
         xRlw==
X-Forwarded-Encrypted: i=1; AJvYcCUOjZqoMh3KcXaBSsU/KNZMtd2PEcguG8e06dwVVmyEf65AS099miCNMZ7qpvCi3WyPwetbzq84StvjMD4=@vger.kernel.org, AJvYcCWRIyRmfIAZj/L4upl9S7oDWT93RRTe7/FEeSl/ciZ3+fGyBIM/3Y4AULagCUngWdxhQOL7CXpA@vger.kernel.org
X-Gm-Message-State: AOJu0YzzZIKs47MuO6wH4JJtGpAuUiR65HkpSnPW8WT9cRz9AK456zgq
	Nqt8ief6cF9gwimx3PYRrYA0V3yFcUSBzB0smAoyEn2IsTCHOE0opakHWNcwMiLFdJ9HQvADcNC
	KLWdgBNNITEhgjLZp3g723aCswz0=
X-Google-Smtp-Source: AGHT+IFJq4WPjboBZIdrNA2eXE7bG3TpSYjHnfOdZgm/XaIm0sEeQvDdjsmSLeSWf3j5fxU6X9eURcqMl09QaYkl5Tk=
X-Received: by 2002:a05:6902:2483:b0:e30:d34d:a2ac with SMTP id
 3f1490d57ef6-e30d34da3b3mr4011271276.2.1730321434358; Wed, 30 Oct 2024
 13:50:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023012734.766789-1-rosenp@gmail.com> <20241029160323.532e573c@kernel.org>
 <CAKxU2N-5rZ3vi-bgkWA5CMorKEOv6+_a0sVDUz15o8Z7+GFLvQ@mail.gmail.com>
 <20241029173747.74596c8c@kernel.org> <7d2fdd24-6e45-4007-a0f7-cafa44c0ac4f@intel.com>
In-Reply-To: <7d2fdd24-6e45-4007-a0f7-cafa44c0ac4f@intel.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 30 Oct 2024 13:50:22 -0700
Message-ID: <CAKxU2N8EL+ezO1gtLJCU8NDN81eKbpO1gv5DFkSRDSnVtos0-Q@mail.gmail.com>
Subject: Re: [PATCH net-next] net: broadcom: use ethtool string helpers
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Justin Chen <justin.chen@broadcom.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Sudarsana Kalluru <skalluru@marvell.com>, Manish Chopra <manishc@marvell.com>, 
	Doug Berger <opendmb@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 1:31=E2=80=AFPM Jacob Keller <jacob.e.keller@intel.=
com> wrote:
>
>
>
> On 10/29/2024 5:37 PM, Jakub Kicinski wrote:
> > On Tue, 29 Oct 2024 16:43:15 -0700 Rosen Penev wrote:
> >>>> -             memcpy(buf, bnx2x_tests_str_arr + start,
> >>>> -                    ETH_GSTRING_LEN * BNX2X_NUM_TESTS(bp));
> >>>> +             for (i =3D start; i < BNX2X_NUM_TESTS(bp); i++)
> >>>> +                     ethtool_puts(&buf, bnx2x_tests_str_arr[i]);
> >>>
> >>> I don't think this is equivalent.
> >> What's wrong here?
> >
> > We used to copy ETH_GSTRING_LEN * BNX2X_NUM_TESTS(bp)
> > but i will no only go from start to BNX2X_NUM_TESTS(bp)
> > IOW the copied length is ETH_GSTRING_LEN * (BNX2X_NUM_TESTS(bp) - start=
)
> > No?
>
> Hmm. Yea that's right. I'm guessing BNX2X_NUM_TESTS(bp) changes the
> number of tests based on what start would be...
makes sense now.

Loop iteration variable should be ARRAY_SIZE(bnx2x_tests_str_arr),
which is BNX2X_NUM_TESTS_SF.
>
> Probably we could use a static size of the string array instead of
> BNX2X_NUM_TESTS(bp), and that would fix things, but this specific change
> needs more careful review of the surrounding code.

