Return-Path: <netdev+bounces-140188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739E29B5726
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 00:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50DF1C22630
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 23:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614F920C00B;
	Tue, 29 Oct 2024 23:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFT/fWjp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E26D20B1EE;
	Tue, 29 Oct 2024 23:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730245409; cv=none; b=ZZ+6r+DO3zPUQurk7y6QolhIGDnKmAs0YMmQCXp4uzw8Alf8HZG5uA/4yAfqUNP8dcitnrTvzMVMmvOAWVzoERs891ZpDE/qu0FYCrFnM3NgwQTtX0tIFh/mxapEQBWANJrcofh0bsltoiiS4noK6beqSm9/Oz1tLdvc17L6hlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730245409; c=relaxed/simple;
	bh=UmBG5G5U5O/XC7rj2evLQqYASV+llb8bdP99+596aPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tFrs85fi0287tM8H28mri/WmsHcmERo9rPmNDyypaeUD6d0nfix1gRj3SciULVzomWj19LhqUYTP3c6/F+LlwG8TwcAZ+7uT1FVqmjfEH7af6PlAttqzCOPcVFNEimGxNaVeLftHUxX5+YLNbxdcqXgRNg4snb5Z1/WxWfimWWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFT/fWjp; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e9ed5e57a7so26612187b3.1;
        Tue, 29 Oct 2024 16:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730245406; x=1730850206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzzp97jsIGOvrmOEGqCcONJDJRB+MoET/8BHyWpF7Kg=;
        b=GFT/fWjpN/sP+ZXnbYQHbCMg87hrmS3iJ/PsTwNvo5mG57RUxLsWO9aUOktVFp9GFV
         SeIAV07t79CUiqjqjkkPjPWm2ZU3PU2fAnfbn+ErNSaX3D7wav9lYyJvpwXgmfVe6nUT
         QxS088F6iRUe2bQG3a9zOP3ofausl71YNxh1JvjXC5a5UC6be1jGNu1ZXw3bsiJDLQ5a
         JPXLccPgQAMulvJCu4DaheEcktZgHRHuphDySHbM/63cLHk33z2uHASwuPK8CEEKhrlb
         FZOr4qqC4ANiH8siLPYz/4k89tFP/ndCsT/OdmkuW7w9KrNqev1PFHg8TTxjk8uo99rA
         lv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730245406; x=1730850206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzzp97jsIGOvrmOEGqCcONJDJRB+MoET/8BHyWpF7Kg=;
        b=A6N0ZXYXUAJu6SeNZyV+/tqob9ePRxyD9sjOvik4mRGgXhg562la5D9ZHnZ/+ytFvh
         tK2xJfzSznywxw/3TerRYrqE0pXSEkdMVlqngELdPtmHRIyA6Gwi9T9n4YBfKSwOduBC
         Si8b1iyrwValubT1ui12h82RvDxWmD4pPEiks4dg0LmoYm8NuBLugzQPLJLdFr8h/7Id
         5PB9lV3vtmXJyDjfJIbYMvKTBDLyHXMAr0uL74eGc2jFa5M7WtoV7T7VYadhxsuKmHz6
         1XZ6CePW1YQXHHbvAB75q0ZZRQviqMIOEh9iE36OjXNGWLFmE0yqG7C23TPRgaKNZOMk
         YlMw==
X-Forwarded-Encrypted: i=1; AJvYcCVnmA10DLNmzrq8E4VOc1n7KkhI1f71RV/RhXuDjMq/pZD+U1h5RUv6oeFHbwDoDreirCYBHs/xe9ub1q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYq8LGXdZFh6vuAK9FrNcamsBX0c67BA/R8hd30Sg0X3yx/LDk
	7GSfjh8INTXkJSeMOcLJbMLbdvzxlLNo/Cx18DpClCi3E0Q0RFOeiNszjZDrGiXmj0FCC28M3Ze
	H0CV5MW0iTLih0NJARxCmZGTSSIc=
X-Google-Smtp-Source: AGHT+IHkSdCJ/rSCFkbWQkyCT6YVbmIX6SqdIvVpccjkWyeR7IyD9RtxAyYt1Bj1DJ6ECedUsWm6k8vpRahDfeaMooU=
X-Received: by 2002:a05:690c:18:b0:6e3:d4e3:b9ad with SMTP id
 00721157ae682-6e9d8ab2300mr141088257b3.33.1730245406470; Tue, 29 Oct 2024
 16:43:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023012734.766789-1-rosenp@gmail.com> <20241029160323.532e573c@kernel.org>
In-Reply-To: <20241029160323.532e573c@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 29 Oct 2024 16:43:15 -0700
Message-ID: <CAKxU2N-5rZ3vi-bgkWA5CMorKEOv6+_a0sVDUz15o8Z7+GFLvQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: broadcom: use ethtool string helpers
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Justin Chen <justin.chen@broadcom.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Sudarsana Kalluru <skalluru@marvell.com>, Manish Chopra <manishc@marvell.com>, 
	Doug Berger <opendmb@gmail.com>, Jacob Keller <jacob.e.keller@intel.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 4:03=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 22 Oct 2024 18:27:34 -0700 Rosen Penev wrote:
> > @@ -3220,13 +3212,13 @@ static void bnx2x_get_strings(struct net_device=
 *dev, u32 stringset, u8 *buf)
> >                       start =3D 0;
> >               else
> >                       start =3D 4;
> > -             memcpy(buf, bnx2x_tests_str_arr + start,
> > -                    ETH_GSTRING_LEN * BNX2X_NUM_TESTS(bp));
> > +             for (i =3D start; i < BNX2X_NUM_TESTS(bp); i++)
> > +                     ethtool_puts(&buf, bnx2x_tests_str_arr[i]);
>
> I don't think this is equivalent.
What's wrong here?
>
> Also, please split bnx2x to a separate patch, the other drivers in this
> patch IIUC are small embedded ones, the bnx2x is an "enterprise
> product".
> --
> pw-bot: cr

