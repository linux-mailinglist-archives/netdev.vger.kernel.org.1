Return-Path: <netdev+bounces-226909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAD0BA610C
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 17:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0768189B11D
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 15:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D993B2E62A1;
	Sat, 27 Sep 2025 15:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdhSCfgB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0C92E5438
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758987680; cv=none; b=YhRW8oroS5twG0jGniD5tGpF2wRLUi6ua+GeHLtFXlRkcZgTBtOkb0Dxg7w2QE2/gXfiCH6JlpI/86pG0GvI1skm3WHgcUpam9/s37WWZnsFS7IpN+wjBE1iDQmYPymCEuE2HEgh9FbaMaTIU76XSCK4xTXbFB2q+XZ9qSjBsj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758987680; c=relaxed/simple;
	bh=MwQPpbtxqllDzMqIeGMKecP8ZVSyGm3WvIWyUvzamJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4aq0PhuMx3ri3k84t8ezau5N5Q0mm8Uxz0Z0BkqwecD0GVAPG4haztPW7Ri4DPHHIS1AROYgqESKswIzC+Yp2I4Bj+40mcJdNVeSREYkjnsY6Yf3xiQmBRIYaZiEUh48fyoMXvNIEu30B3ND0mcjmEaW9+BIjKDhX+sSXO5lf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdhSCfgB; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57a604fecb4so3858663e87.1
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 08:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758987677; x=1759592477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwQPpbtxqllDzMqIeGMKecP8ZVSyGm3WvIWyUvzamJQ=;
        b=JdhSCfgBcA5uHWzjfh2C7zprZF84eVPI6T2L6vW0PU89suHTD+Hd5FbSD3hddg9hWS
         R7FMq6KsfDs9woLgD/AebzXCqByomjNzC0ak1Ga93NshHaqZrK/TPYDfCq/6I/R7IQWR
         aCROIveYRaKbTRzY3ospA9fkcYLVrmKmOGsNPuz7VdTogBpg166E6ReiK+afjLnLTwCJ
         lBnhPtlta9N9xi+Da3tGSutFPd9tc6jq1KFImY5sra7el9PnrsuKbGwS4NQVceVT7O2d
         5p7a4UyH7o4K/RjqorbnqfX5/GMSsAiF4Gf4ZHOw4Gx0bbCP4MIn/nnjnRZDansrLzrX
         tGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758987677; x=1759592477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MwQPpbtxqllDzMqIeGMKecP8ZVSyGm3WvIWyUvzamJQ=;
        b=pWI3M4A53qaB6wM5ebqc/W4+/9atFbJZdMRj5Zr5H5SyOFc34vq3qudAL/4v1bnF48
         TSp3oRjUMOSD7uMW9M/XmXz/lBL+rIBpGyOaZ94BPnfQMeILUkP1z/Yb/mDZF4R3aP3c
         FBzvC/RcNUft1DUpWxKzQ9d3L9pqh67BusVRlh0gUVHgOTNLAsuTzCnHgK8Yo9hbY5dz
         9EBaNvBQjSRqKSeOuQjzuTEwEa5UvX1orPxROKdR4Wb0BCHq5U2F3hZX7wARl4XQ+BNJ
         o1iD3HHOFM98HlWOhzUWwpOiP5ZUbsQWHvaM9dtR+Jka3Uu38z/fVDPPfvJfOr6YOHd6
         +NbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnzvtbkNFoIIHUQ7bqMBl/8kJ9m+hkA8+F9uJ3NkXmj03807og9Dh77bJV87mLMirUboUz3x0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLWSxDoYOFrcoxUr5sGT4D/W3DQ0BGZXBwsywEdM49VJlGUIOV
	RfdZKodSyR3yjd1K1zb01n3BBomNEGOcW7V2i8cmxeUiWl6FS8iH7yjGafyjBhPrYeHJzpstj0H
	9WqmS2lKYbuCY0UhwBQUlw622H6g+w/zD5XMy
X-Gm-Gg: ASbGnct5YaaoDmDkkRie51iXYfSl4BuEtmi4w2ZMtmNX1UfBCIIZvVBv2N1geIu+wC6
	DcIZPkRX1OGGBtrF+arZwZpIHmG/lRCfHz8XTGh3bD1dgazQ9FTcnj7/x5DRT+/CWDLiQb6zGja
	YA3jNAxR2PhrP5iIe7VTFA/JzaGvAOfTnLuuI/Wd3JQUVBTa3hhag8wciOw5FJOMy+f+tbWGMII
	GFzDgyGRv8PcBVQ
X-Google-Smtp-Source: AGHT+IGtbZ5a8e5PgEqpqmMCaNPGGJ1+l/uefZZJgo1GQDrYlHTthpkcQ/n4MVkDVeyHEa5MWB7xaoth40jIpHEceHE=
X-Received: by 2002:a05:6512:3a94:b0:576:dc1e:d6c9 with SMTP id
 2adb3069b0e04-582d092da35mr3581845e87.11.1758987677053; Sat, 27 Sep 2025
 08:41:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925145124.500357-1-luiz.dentz@gmail.com> <20250926144343.5b2624f6@kernel.org>
 <CABBYNZJEJ2U_w8CN5h65nvRMvm2wWHHRng2J8x1Cpwd8YL4f-w@mail.gmail.com>
In-Reply-To: <CABBYNZJEJ2U_w8CN5h65nvRMvm2wWHHRng2J8x1Cpwd8YL4f-w@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Sat, 27 Sep 2025 11:41:03 -0400
X-Gm-Features: AS18NWAlJuFqdeE2bGHSCzr2ghWJrQYAqHie5EJjH4eKDz1IuDZXR6u7HaRl8Sk
Message-ID: <CABBYNZ+98fYzySag=wQgHDnH=ZFZ8Rk+vvbozn=ZCr+QicrSxw@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth-next 2025-09-25
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Sat, Sep 27, 2025 at 11:34=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Jakub,
>
> On Fri, Sep 26, 2025 at 5:43=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Thu, 25 Sep 2025 10:51:24 -0400 Luiz Augusto von Dentz wrote:
> > > bluetooth-next pull request for net-next:
> >
> > I'm getting a conflict when pulling this. Looks like it's based on
> > the v1 of the recent net PR rather than the reworked version?
> >
> > Sorry for the delay
>
> Should I rebase it again?

Oh, looks like it is 302a1f674c00 ("Bluetooth: MGMT: Fix possible
UAFs") that we reworked during the last pull request, we can just skip
the changes in bluetooth-next, I will send a new pull-request without
it.

>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

