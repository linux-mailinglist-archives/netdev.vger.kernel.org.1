Return-Path: <netdev+bounces-166711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C84A37022
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 19:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A1FE16DF27
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 18:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2701EA7CB;
	Sat, 15 Feb 2025 18:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S91pJtSJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4631DE8A5
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 18:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739643828; cv=none; b=FL+Z4iRmMQBoXtTUCIRZsquDv+SELd7DWmhIIz3BSf5tE1zGxXN5RASZBI5IMn1izz6i7ZYdmJz/oLsNN+ip4+0IovYqyGQ05jdO7VPw/15+0HQHKME+Xmtn8Bez0E5MTD/Kda4PVNKuck5uCYzr70Pu3hApr/y1PfUiF0SbDRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739643828; c=relaxed/simple;
	bh=yXz9BMtnIeh2cYnnafIof4ENCXpFDWb399mH0nb+ve4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s08Em9lFaZrCu41BAudcWkXI6EHxizoqGWbH3O14+tk+Jt56y7vzgaB4B8orFhgTrjSCs+OZxX8rE/6C1RuPvjlkLQ/nAEU5TlmfEbAGRcGklZEYefF6j17LD6O3wXDRxwc3W5YyYaJQjqh8nJqw755IYhBXne5HPx1wSHyZaHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S91pJtSJ; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3091fecb637so15253771fa.1
        for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 10:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739643825; x=1740248625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXz9BMtnIeh2cYnnafIof4ENCXpFDWb399mH0nb+ve4=;
        b=S91pJtSJeKSeLbFWe/3OhZ3SXNf3ExfaqqBJe/2HAbBbpKlFklJYQik+SuH1Mdej1b
         XsrYNaPOmIqOaG1pbM+dBLKAIlfeS79vFpJ2IIGpRnazJyYxFKnlM+UkVrx6MipKa9YW
         MLkhexxiVHh03tuT5BcNCRVMBubJwuhhdzEMZMUX00tjgBx/QcpsI/Qx+0yK4OqyUYfV
         trSAXjV7yDWH6TVVS6t+n8v+jDHix3uFzrFOEH1RRrL11Ip/Yrt+KbkvHdXQoOAKhXmd
         FrnqhtRRAK93xmBz7h+De6npfM5xUOdQN95u8qo7VXia1Wzr5DUUHBNKfjDHFrxBakQj
         Ghmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739643825; x=1740248625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXz9BMtnIeh2cYnnafIof4ENCXpFDWb399mH0nb+ve4=;
        b=HGa3hB8tBmypW3yhsReV1yI3o5tc6bJehaKIkKJV/0dbaAYKGh2iOb+fE9TcP7S1ll
         +wDO005Fok0l1Wwh5BauT8WDegFnf0PyeYxQcXn1FrV/FNGXzbzHQcCgtQZ2l8ihKoTr
         A+uIXRQ6cZWRUw+8BBucoujQcRh8NzlaHsRDHxXkM0toah+DF53JgLteopjRFJCnvWwj
         6AkEfvleeetLJ1EjCBR5quHulBIj2jHkayzZf7IosJiGisT1t4nJ1eyrwh3coR6trZ8d
         o1FBeNA2aSMVkJ2X1DIT42qBMMCSmq0A8e3uc+K0IgesT7kjXUi+MZw3o3x00b5LF7Nu
         v2RQ==
X-Gm-Message-State: AOJu0YwmwdX38KGvK72o1IbP9aBwsP7QWRAa735XCkjtfWgm+LEd9+zh
	kB/aSm0u8CVp/ZfYAdOR99o0p55qin3Ltm6ywA41OyZw0piPL4YHHDCCBKLyHkERjcpPhAiq2fq
	7O36F9PzShw9xvLvCTuHZzRFbLBRjh1Q9
X-Gm-Gg: ASbGncvIyBfsLrs5EF34hG84FO3DdpPmQgeDtYaw0GSAqLWnjWhijkarxMs/i7MO7fE
	bFkBp1Xfvao0K9Jrwu7qzTH423LgYkC8+OyhMEFnmcPAYsRost3LNsj6kTwpEjTqy0c1bG6+sy9
	JNkAf5V83T5FYjeswFouRSXIWY4OIDOg==
X-Google-Smtp-Source: AGHT+IGkPLpkbOWRdDXK2Jc8vrk6HB4rsWHM0rSzO2KCPDOZUKvFUG/3dyylZ0wfBoySThdEnpWvvDFrHZb8rQ19vG0=
X-Received: by 2002:a05:6512:398a:b0:545:a2f:22ba with SMTP id
 2adb3069b0e04-5452fe86880mr1086451e87.37.1739643824301; Sat, 15 Feb 2025
 10:23:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213152612.4434-1-pranav.tyagi03@gmail.com> <20250215134548.GN1615191@kernel.org>
In-Reply-To: <20250215134548.GN1615191@kernel.org>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Sat, 15 Feb 2025 23:53:33 +0530
X-Gm-Features: AWEUYZkqEglGxnuD4hfoZlo6EhAXR8mvgF2jK9fhAUgseVm5WteQe88BQw2Y01s
Message-ID: <CAH4c4j+9aXmFTym_uU-RtQtNhPBMeWnEE-mZaAceQTmuL3QCTg@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: net: fix grammar in
 reuseaddr_ports_exhausted.c log message
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
	skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

Thank you for reviewing my patch and for the guidance on the submission pro=
cess.

I sincerely apologize for the duplicate posting=E2=80=94I=E2=80=99ll make s=
ure to
follow the correct versioning and reposting guidelines moving forward.
I=E2=80=99m still new to the community and getting familiar with the workfl=
ow,
so I really appreciate your feedback. I=E2=80=99ll keep these best practice=
s
in mind for future submissions.

Regards,
Pranav Tyagi

On Sat, Feb 15, 2025 at 7:15=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Thu, Feb 13, 2025 at 08:56:11PM +0530, Pranav Tyagi wrote:
> > This patch fixes a grammatical error in a test log message in
> > reuseaddr_ports_exhausted.c for better clarity as a part of lfx
> > application tasks
> >
> > Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
>
> Thanks Pranav,
>
> This change looks good to me.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
>
>
> A note on process to keep in mind for next time:
>
> This patch seems to have been posted to netdev twice, about 20 hours apar=
t.
> Please don't do that as it can be quite confusing to reviewers.
>
> If you need to update a patch, please version it (e.g. [PATCH v2 net-next=
).
> If you need to repost a patch, say because there has been no response for=
 a
> long time, please label it accordingly (e.g. [PATCH REPOST net-next]) and
> include some explanation of why it is being reposted, e.g. below the
> scissors ("---").
>
> And regardless, when posting a patch to netdev, please don't post it more
> than once every 24h.

