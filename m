Return-Path: <netdev+bounces-169778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C4AA45AE5
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 10:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E0CC3A40B1
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 09:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5944824E01A;
	Wed, 26 Feb 2025 09:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAI6nKc1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD7F24DFF2
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 09:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563722; cv=none; b=NsZqZ89vf4bTc0sJ56NlDhEcyxlRTYQNQC2HOrGmIWX+fQcFpdCywYW4zU8d24Qqvt/J67IyQPlGpj7ObCN9qz8TPbWqnHBKDAIdNx8WseL4FPoThLk9TTMDEb1nlwKgl/D3mLxEppMiV0GgjENn3GlTkB+d8TlSMDxgJVjqRf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563722; c=relaxed/simple;
	bh=HUmhfof7CFNKUEfgc4wqdwOSAaIFQEgJSYQ3FEevBT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1naUdUGw0lRNmjbR2ZF+iIhvOKC6oKgV6/KBwYc7Hw54St7qVbB1WFLWo3bVO7jcEF4XTwNC7+DnwlvAt/i0lnHfUNHs7J1OH0nV2hXaq9+supDTBQcQYovGgmPf+PXX4AZm9cvigFJleEdXxAgLrxti8sjmOLnRt2fuNPTWhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAI6nKc1; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-520aede8ae3so1729431e0c.0
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 01:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740563719; x=1741168519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUmhfof7CFNKUEfgc4wqdwOSAaIFQEgJSYQ3FEevBT0=;
        b=NAI6nKc1pfEI1R8NIG1pr96TuvMnv4h8dDHstXkb1PXqasGKic2JXoTCwv7HxTavUu
         /Ppf2S5aLTBEihMlUJ4OmG8ppyhCZr3kRhFFC6crV0+CGCCVZpQrvMcb23deDjCLCUe7
         mKhqvCoTqnlaF6BdM05Rj+AtNgd/uWxHN1+/s8GgVf2XKp0p4j/JCPIkAsQG2tIxmB4A
         yL9TeITb6N3XmSJKH+UYY9cmHu9H1M4N1pust7bat0k6q/FkXENZbVvCPNJLPTG7Uz6N
         V2KD+8AgTvo+2wgcuG0Mr8c5/KWR82C9AGI7/8sLK962LREFG6KzicaLmoZW2Jf5zBCC
         8Jdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740563719; x=1741168519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUmhfof7CFNKUEfgc4wqdwOSAaIFQEgJSYQ3FEevBT0=;
        b=W1qAkptzantffz94BFuKOUSx+jJDGVFFDt9Ny/UTWhz05M7LGhkOfDEIxRrObonRnj
         0uxNaIoOzVXg2Ih8NMqWWvM3Y2MwYY91jb2HJvn6MWi8HqWS6+oET6bf/k/1nIW4zDdX
         6E4uW7zDoaW9kGtEfCm5SKUdiXkYHSNJk6w+M1k9j2SulF6TRjnLhS6SmtwurErgnIHL
         QSqXnKOCsoKLXl9N0JpyZnxgFV2m3PcB6kFDkAt787T2AJigPt6FvUeE4A6v6qFBj9Zy
         /Fc6ySmfygKHZmkZgUxoXiMAksh+P1exHJW66B19f0CEWNKBIjrNPATyKzx+2AlqGdrD
         00ZQ==
X-Gm-Message-State: AOJu0YwD5eoegX4wePkCJhPn/wKM3oAd++wOOrUbl1VvhzT9Gaa5Z6hD
	RNelY+VuCVLiLDnN3cwHHuBFjAi/Z1cwBhW8dgnidhp2coQ3UVendXny1Moi92tD6LfWOsk7+1j
	Dr6jMdvG9wo/ZCkqKhAlC5oCvuzfZwQ3m
X-Gm-Gg: ASbGncvqmaxnjjeobUlUZRIBi1iXQCulVQHYfPuDMHpIDe3w2+IOKVfjjH1vvnsLpX5
	vi5J64BaCirMXE2X9B/ELjEfSwnTB4KeZP9JMY/mweo7YeiXJHEzwOvuWC9S7gu2qioCcalq6Z9
	dbe6/AXw==
X-Google-Smtp-Source: AGHT+IE8mQvgjLCVTbfJz3Mxrp1w/ZcuJh1+eaGdwZ1VE5yyX8tzJQOO9wTWlnBMJqsKFWwAEAKrj0Y4vqaY6O8ok3c=
X-Received: by 2002:a05:6122:1820:b0:520:42d3:91aa with SMTP id
 71dfb90a1353d-5224cb9297amr1459819e0c.2.1740563719442; Wed, 26 Feb 2025
 01:55:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA85sZveppNgEVa_FD+qhOMtG_AavK9_mFiU+jWrMtXmwqefGA@mail.gmail.com>
 <CAA85sZuv3kqb1B-=UP0m2i-a0kfebNZy-994Dw_v5hd-PrxEGw@mail.gmail.com>
 <20250225170545.315d896c@kernel.org> <CAA85sZuYbXDKAEHpXxcDvntSjtkDEBGxU-FbXevZ+YH+eL6bEQ@mail.gmail.com>
In-Reply-To: <CAA85sZuYbXDKAEHpXxcDvntSjtkDEBGxU-FbXevZ+YH+eL6bEQ@mail.gmail.com>
From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Wed, 26 Feb 2025 10:55:08 +0100
X-Gm-Features: AQ5f1JrXUVafKBDWcfwCTsrXgm-WdGpicrJImlqrtgkuC7i7XXpfX371nlhL-rg
Message-ID: <CAA85sZswKt7cvogeze4FQH_h5EuibF0Zc7=OAS18FxXCiEki-g@mail.gmail.com>
Subject: Re: [6.12.15][be2net?] Voluntary context switch within RCU read-side
 critical section!
To: Jakub Kicinski <kuba@kernel.org>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 10:24=E2=80=AFAM Ian Kumlien <ian.kumlien@gmail.com=
> wrote:
>
> On Wed, Feb 26, 2025 at 2:05=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Tue, 25 Feb 2025 11:13:47 +0100 Ian Kumlien wrote:
> > > Same thing happens in 6.13.4, FYI
> >
> > Could you do a minor bisection? Does it not happen with 6.11?
> > Nothing jumps out at quick look.
>
> I have to admint that i haven't been tracking it too closely until it
> turned out to be an issue
> (makes network traffic over wireguard, through that node very slow)
>
> But i'm pretty sure it was ok in early 6.12.x - I'll try to do a bisect t=
hough
> (it's a gw to reach a internal server network in the basement, so not
> the best setup for this)

Since i'm at work i decided to check if i could find all the boot
logs, which is actually done nicely by systemd
first known bad: 6.11.7-300.fc41.x86_64
last known ok: 6.11.6-200.fc40.x86_64

Narrows the field for a bisect at least, =3D)

