Return-Path: <netdev+bounces-167088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B34E4A38C5A
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 20:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EB0A1892D4A
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 19:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320C6236445;
	Mon, 17 Feb 2025 19:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnXfAEOf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB333158545;
	Mon, 17 Feb 2025 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739820486; cv=none; b=pm7adSuoxrzZ2AwkNey10RgEn4IDgkJGeFC5tm6yh9wsTamQMD3VAVplEF6Yx+ohHl7B58sGWB+5RCuqh3hgmtkLFJeKZM4Ryyec7lcOZE6Fxopips1/kS3k1bhcrmCsPQsPq0qnYsU5x2o2MPfxh514vn6m469sI+DPef/qRtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739820486; c=relaxed/simple;
	bh=LyT3d6pl8dOc75wJyXTBCKMnpWMCbXDQzq4dj6p5KzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O9l49PIzsawZLsL2jrlyb2ELC4klYPjlV+IWE3Y18+UrHmqqzwqX4zXvmgLidLlHSHczExlKbGYf0mDPCHUGtF7ge77VpWnuuYv6gJoarnf0AUCAh5TBIEXBS7gEXte2k7zZFXolbIbgG4wuUAYWZPnW1UzQEfgtgVvUnpmiPlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnXfAEOf; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3f3eafbbfefso1155386b6e.1;
        Mon, 17 Feb 2025 11:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739820483; x=1740425283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSJoXMSD/BhPuUY7LHZWqmM96m17Q8MN8Qrypab4Q8g=;
        b=FnXfAEOfaxqpgfWnoBgV/icWCacp0fmSxCt+gJPHNmWVEVeXEnyXKGkpFwNmtBZVK2
         5KgwEz74zJrPAC5VSag3VR/0qvExDU11ZBWbvw95RuN/qRoskeTvAO93frLn+FUhBjJi
         6e7fZ7OPQA9yGIlpfZYbKYF+4lsLD7sNrw0G1+CGjKG/KFKKg7sxxx2vrIs8PHHcfBme
         YULSmKvJJ4iZ1q5RZoA5+OaijqZCgTzmEwoanKEPrZ2jNvxmA3kux/OZ3kk5o+0Zvag/
         bChKYKZDKlySbZgW4jM3YuCkmcCxi8nSxs191aGA4v8WgNK9nWj/elf1MmsVY/SZyVIS
         Tt4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739820483; x=1740425283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSJoXMSD/BhPuUY7LHZWqmM96m17Q8MN8Qrypab4Q8g=;
        b=vmgy56Y7HCHrvb53MM0/LWQpa2G01l6enN040FI8vnU3/BfI6Eg85dARmeyCoX4hmv
         bHbVwvaq0wlmnnr39gwOP7MWtoU1pKjkxSK6pVOpPbB6J5oWqR/Hcmg1O0Yk3jBoqSi9
         +1Fz0O44EwcNEkTKoXqjVIx7tBmbW+2r/fNXi/FqiSbu9W5lTttCTQEljI6vTz6+xpEu
         nXCfUlBgvKB+Z/5E3WlDpM1ycyND9ej/EqOgL9L8kDGeeJg29H/3sjUs8X0hVXehDen+
         FKnegvfvih8VBnMVzZ8O+ZfSihcCWKFDrY41KARe95o7ltM6cVyf/RqG05hb7jD/5xtu
         0Ycg==
X-Forwarded-Encrypted: i=1; AJvYcCUc59WlhgB6x8MOL+Sr0H3ejjUFgzodtgw0fRw5wUtM+lffpaQtHrYQ7Br/iis4l266L66/KwPWSoLYZxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgx+mhOcm4a+CwhDXd6WAZ6DiOewKbaM333CCVqKRkXoF+we8p
	46eUAlXYLHnLcZLsAbe5wqo8pQ8XOW8UDa/LX8YyyJRCP3eUfijXht4+UxVo36S75KZnzcSrGh/
	Yl+GWeCa9YR8omlUr2ry5SiKQ6dk=
X-Gm-Gg: ASbGnctLhgq/um1sWagXT/qZiQsdPrDMYX125OGiMsnsPQ4aqFBucLf4uXHwoeDvQl1
	08UpQVI6Y24PRS8gHeZDVmeLyTdIEGXALZoYXKHiZ272mI/p+98x6lDYm7fDN9zaUn6toZCoDE9
	Lq9HOT/uv/DwdiQA==
X-Google-Smtp-Source: AGHT+IGm9ugh/+vpeMXgXD2bHB5XzwZQCk7bMHiXA+RGS1g0x8Sg2j2oG3t6qoSbMODV4oAyTqQJtgMhF+ZMFpErejM=
X-Received: by 2002:a05:6808:38cd:b0:3ea:6533:f19d with SMTP id
 5614622812f47-3f3eb14109fmr6828138b6e.30.1739820482207; Mon, 17 Feb 2025
 11:28:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO9wTFgtDGMxgE0QFu7CjhsMzqOm0ydV548j4ZjYz+SCgcRY3Q@mail.gmail.com>
 <CANn89iLjxy3+mTvZpS2ZU4Y_NnPHoQizz=PRXbmj7vO7_OGffQ@mail.gmail.com>
 <CAO9wTFjaLBbrT7JKBBN=2NMhSRmxzPk_jLSuG=i6Y5anZJnvEA@mail.gmail.com> <CANn89iJmOKiALL9r_9+nyy5bdYwMUEX+LAkmswMyWwNC53yEew@mail.gmail.com>
In-Reply-To: <CANn89iJmOKiALL9r_9+nyy5bdYwMUEX+LAkmswMyWwNC53yEew@mail.gmail.com>
From: Suchit K <suchitkarunakaran@gmail.com>
Date: Tue, 18 Feb 2025 00:57:51 +0530
X-Gm-Features: AWEUYZk6r48x4i6IsxlCjOkM41q_b0hCqVHzJlcqW8Q7g_cEV57CFYtfCJPJNiU
Message-ID: <CAO9wTFhbK-Ckc3bq9X0qdKiyHVqsQgtzSu4RGzkd1d1aAK0vwg@mail.gmail.com>
Subject: Re: [PATCH] net: dev_addr_list: add address length validation in
 __hw_addr_insert function
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, horms@kernel.org, 
	skhan@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you so much for the feedback. I appreciate your time and effort
in reviewing and providing feedback.

On Tue, 18 Feb 2025 at 00:51, Eric Dumazet <edumazet@google.com> wrote:
>
> On Mon, Feb 17, 2025 at 8:05=E2=80=AFPM Suchit K <suchitkarunakaran@gmail=
.com> wrote:
> >
> > Hi Eric,
> > Thanks for the feedback! I'm new to kernel development and still
> > finding my way around.
> > I wasn't working from a syzbot report on this one; I was just
> > exploring the code and felt there is no parameter validation. I went
> > ahead and made this change based on that impression. I realized my
> > changelog should have been more generic. Sorry about that. Also since
> > it's not based on a syzbot report, is it good to have this change?
> > Your insights and suggestions would be most welcome. I will make the
> > required changes accordingly.
> > Thanks.
>
> I think these checks are not necessary.
>
> 1) The caller (dev_addr_mod) provides non NULL pointers,
>     there is no point adding tests, because if one of them was NULL,
>     a crash would occur before hitting this function.
>
> 2) Your patch would silently hide a real issue if for some reason
> dev->addr_len was too big.

