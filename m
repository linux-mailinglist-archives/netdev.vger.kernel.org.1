Return-Path: <netdev+bounces-69815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC70C84CB53
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 14:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8741D2909D0
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 13:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACC676904;
	Wed,  7 Feb 2024 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBoiA7dt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4752C5A0F1
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707311885; cv=none; b=UsmjZ511ilXJNZO7smKkw/FVClJ0HRfLybmp5WGWeXGK6uL4herrwNmHc9Epf6I1ZJBzwY+iZ2rbqBLmB4ktZydlg1MHnYUdQUB/mmtEb2nc+25BskGeu3RPJZU7NsCBrmA45WNEhMsdKR4IjekPeDxb92SiC+AdVmGTzD1Zjos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707311885; c=relaxed/simple;
	bh=6tfNveP/lHOlB3K0BDX9kHuQz+CVmci8vLBgvcOUIiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cFv3wn8fl4iJPN8Nj4Jw8Gxx6jKVuFqqO13UI6k4BNZM4bQLvFvV/FGK+ImVaKaxHBhoCRrWpW3D6vzmhHG7loCO2FwlCurYBDrHp3v9fOw2mJmu63octH/TLsdP39I4PFGUr6z3vPTLVaMD1EdQAMd5sdZBd9sQ2qqX6L47TmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBoiA7dt; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-560037b6975so621500a12.2
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 05:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707311882; x=1707916682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PkyJZkGVzoay4UsXVSMwoyOOjzChVdc0g9uUv++pWc=;
        b=XBoiA7dt4/i3ey+3GnvyCxzCYhDWwcJFBBPZMi9qGaGWV9ea1X238gfccpNdWPRDT5
         GTbz/LC4GAtBqtG/BvBYQOLGt3otCYPGH5ptl5p6shGAwrmIRYnxVmHTY+WUqwXW18BM
         V8GVJC8qItV4nQAzo9cJkrR/qpyOKtXCYy7dNrptle2f/QLzUm2lXmin0sdE+OVNYR8S
         UppxD0EKoF5QxZM1C4Uzc+QFIADAJAuYHl39AVlBM09kqvXKireh9x7ZAwEjKix7BCKG
         N6+opZs+lnKz5WBGmBAtZqzyMnCkFQ14bNWfUcbMQfnHW3fKrrdrqKAzJ2H9KzXsI1sw
         VtZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707311882; x=1707916682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/PkyJZkGVzoay4UsXVSMwoyOOjzChVdc0g9uUv++pWc=;
        b=CT0Xjdm4wWdABKKjTlbsT4NCoNYXyJGe8+hl9pgcSQtZeCR3KKZR1dQqosp343rhDa
         5BrznD14LSVeFRQSDkoabcdaDayD6D0AznfHaQXVBTzgMKlnYO9zPvMtgy7pG+3Y9fMP
         ZmzbGCu2ZF6WnFkkcWwkuDdW3JPkpeJpCj7ysFeruSEU7wdMB0YTS6qQF61pag1+DSPZ
         h0x9k7hH1wCnVe2TLcL6cBY8wDPAjPfFTcjY312P+yW+XSaSUjgdCXif/aO2mZxwEBRl
         OWD7T9IFApYtxNh7HzR7HeolaeiZisUJc1gNIMCuaBF3FaXJq5YK/aTXCrRFJwu0fM8Z
         Zxbw==
X-Gm-Message-State: AOJu0YzObg1hboKFsPcD09teIyGzs0pFHzJshEPCrP9B9Qg0fii2EAFi
	SQsatyuu9qFSk9VgmWDHe9VgMF615rJN2pmGhoo35Yy6SK03P9JowqrflOLmcx7AKpCLvUQDWOR
	dJUdF0TQ3h3wj+y5CZ0/9w1g1anw=
X-Google-Smtp-Source: AGHT+IFket36WWiYaNBi2T2Z8ciH3yHRZPyJPlgYf3yejb2FI6+2AFjBpLGhQ1RCVyvLQQQf3W9tUGLVAZCuviG8r2k=
X-Received: by 2002:aa7:c458:0:b0:560:11f8:5468 with SMTP id
 n24-20020aa7c458000000b0056011f85468mr4173457edr.32.1707311882369; Wed, 07
 Feb 2024 05:18:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204104601.55760-1-kerneljasonxing@gmail.com> <20240206190344.508f278f@kernel.org>
In-Reply-To: <20240206190344.508f278f@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 7 Feb 2024 21:17:24 +0800
Message-ID: <CAL+tcoBe370hmKJGdBDni0x7DBdxKKWZmQuCuQfgW9Pw5XMSzw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] add more drop reasons in tcp receive path
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	dsahern@kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 11:03=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun,  4 Feb 2024 18:45:58 +0800 Jason Xing wrote:
> > When I was debugging the reason about why the skb should be dropped in
> > syn cookie mode, I found out that this NOT_SPECIFIED reason is too
> > general. Thus I decided to refine it.
>
> Please run checkpatch --strict on the patches, post v2 with warnings
> fixed.

Thanks, I'll do that.

