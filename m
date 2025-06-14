Return-Path: <netdev+bounces-197761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2546AD9CEF
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 15:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DE37189AB8D
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 13:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177C72D12F0;
	Sat, 14 Jun 2025 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWnTPdx5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CAC1E47B4;
	Sat, 14 Jun 2025 13:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749908055; cv=none; b=KSKbXdMrwgZYOiZO/B5wWay+Fwah4Xz9U0rPviTNtKSigxXf/huwX+MW7/V5Nqhc1GZdv8VOcCKXp7hznq/xZdQqjN/OpEBkeM6kCCe/+4Oj8NLsAEWG8xE7BuRWhL1aR8NCAfxj5wm0O6KG6vd1OzFYlW99DtgFMvjxEw/dmBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749908055; c=relaxed/simple;
	bh=GghmQMVIpd5ow4BvOSK9cdhAIcjwLkKs50ouTbuGm3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3lND8lYxzw26Ge7PsB9bwzpcznDo2xe2ubPn6Pqu3f7vcVclC6+oOBBzrZk+4g/R6fmyKfBWgt/zYuoq+40kyuJcA/t2ML7vTKInB4EM0ZhtgN2UamsV/HvxBl8JfpEWQFAwFLzcP9DhizP7wG8hKvlX6GWL4D66tGiw29C7CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWnTPdx5; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2ea83f382c3so1913042fac.0;
        Sat, 14 Jun 2025 06:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749908052; x=1750512852; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sgT5nC6oJGH1H0WGlHKUUzo9qfMn4+AtCYRD/Jrz6L4=;
        b=jWnTPdx5vnhhzhMe52jRG+aBrcovMxt4mWaG3flfdXQSjfUnAF3ZF6l3fgyI+JdnCv
         fzZ6GIy9DwmbVI/HTqHHldkVY2KOe8rTDYB+8BcN6l4lFVlhzmt+OCLDmCLMd4kpxuFi
         BzmP0BNsh6On95xXf3Sf8ZkO6FCPcazmOGjnPVWJ7ZcJ92I6cj07yOFhAo6PgJ2zqhSR
         UA5mCCZPWGZ+dtdg4hhCvGP1xge/PouEiAQ0jd4KnZWwImnF44lqsvOHszTL/GW0p6Px
         1GQT9Qd5D0VQGH59BQQKIzvGWH4XXluuP+UBzDQxyZz/Y0RqS460QJA+DyTtydTUMHP6
         C6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749908052; x=1750512852;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sgT5nC6oJGH1H0WGlHKUUzo9qfMn4+AtCYRD/Jrz6L4=;
        b=Dq7CEKrxM0YPLaq0ENLRn5JWGADLDHWncv+OO8EzTYzBebM4QeTQA5cimiotK3bKo+
         XJitLrzG117fs7BKvKaXPyoKo5VaSZThLLWSQYhVVArKb9bkQae7fRNJ8H66NNyXyHvt
         IZH2uaHeljbUcqtBUffjyE2zPkpHLVNOK74rO/4u4D5G6ZM0qYifgR3kso5HIB45zRe7
         nCM5S/ICxa+p/Dkylfh2vj2VQWoHoHvgY4n/NJ9xtRC5+voq3fZ5PjsmjoH91iuTOncY
         U3a6pgqMBqBKtu0mBzajcejWIUHNCCOjMEVNWFKTnhDRsQtLHLgWpF62AWrztiGTHYHz
         bOLg==
X-Forwarded-Encrypted: i=1; AJvYcCUZIichaRS61QOlSR20fKT9TtNsLAJXkpKMqjaerKTQ5P94BddA7jVONd6TVfcP1rLbi4pVuE1dvvNxpIA0@vger.kernel.org, AJvYcCUut41Z6bAItPb9A6ZMkTtnwWr0sVgHcmctsQubf4gCZaOSd/BNxLYpJPQwprLs/st/Hqgj+Cn+@vger.kernel.org, AJvYcCVy2EnBnh+IBwUme7Y/bLTbBwTiNwGHe7FTADfILPfQxbzk3fxUKgsnooGZBsV5VVXzUw04SvcRh4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU2yBYrOe1NRyssLMPF038K/l2PYMguOQOyUa4ss2oRPMqRPXD
	hhh8TFMJ9HyfzLrZU2AMju1UoGlwk34lO96u8xWfNhtpr8RADEHEC5ml2Rae86xQ7mSVgFfh5tx
	MG55425CSltfrYFhC2Jp3YDBec8P9I8w=
X-Gm-Gg: ASbGncuS8UjwWnv63H6U5rUIGq0RpaAF/g8brWhuMKDi86YOia9gL0YsTtn5B5IbipM
	N8kVAejfrn/B7c37xvsT1C419/T9Qs7EzHWXtS7EtuatEeul3t2N22kuoMzXUzwHkFV0xL/BAAK
	rwbLSycfKVzQBzwN2I/XGeLToXTl7RufsDe/RRBuPHrIfpMyKEuW7Y4EFuWSHvBdgQ4rjWKuf6Z
	Q==
X-Google-Smtp-Source: AGHT+IH+YQDn5vJWfQK7J2yXhyuCeLrw9tQMapi0P+p2812s3nfq0JAxLR7ypcmPStR4URHIU5eHzQjr8qvlX60VZB8=
X-Received: by 2002:a05:6870:2249:b0:2a3:832e:5492 with SMTP id
 586e51a60fabf-2eaf0b860abmr1914642fac.25.1749908052339; Sat, 14 Jun 2025
 06:34:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749723671.git.mchehab+huawei@kernel.org>
 <440956b08faee14ed22575bea6c7b022666e5402.1749723671.git.mchehab+huawei@kernel.org>
 <m234c3opwn.fsf@gmail.com> <20250613141753.565276eb@foz.lan>
In-Reply-To: <20250613141753.565276eb@foz.lan>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Sat, 14 Jun 2025 14:34:01 +0100
X-Gm-Features: AX0GCFtPzI3njkXsRRl6HopHPGjjoi0wzH_2Cw73cHghqFsHQjZh1J4BTEKxRQI
Message-ID: <CAD4GDZwJtrL3uRCXNJ9vdfXAnjL4H5nhSqn3GDSW90Ee22qgGA@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] tools: ynl_gen_rst.py: Split library from
 command line tool
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, 
	Akira Yokosawa <akiyks@gmail.com>, Breno Leitao <leitao@debian.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Ignacio Encinas Rubio <ignacio@iencinas.com>, Jan Stancek <jstancek@redhat.com>, 
	Marco Elver <elver@google.com>, Paolo Abeni <pabeni@redhat.com>, Ruben Wauters <rubenru09@aol.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, joel@joelfernandes.org, 
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org, 
	lkmm@lists.linux.dev, netdev@vger.kernel.org, peterz@infradead.org, 
	stern@rowland.harvard.edu
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Jun 2025 at 13:18, Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Em Fri, 13 Jun 2025 12:13:28 +0100
> Donald Hunter <donald.hunter@gmail.com> escreveu:
>
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> >
> > > As we'll be using the Netlink specs parser inside a Sphinx
> > > extension, move the library part from the command line parser.
> > >
> > > No functional changes.
> > >
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > >  scripts/lib/netlink_yml_parser.py  | 391 +++++++++++++++++++++++++++++
> > >  tools/net/ynl/pyynl/ynl_gen_rst.py | 374 +--------------------------
> >
> > I think the library code should be put in tools/net/ynl/pyynl/lib
> > because it is YNL specific code. Maybe call it rst_generator.py
>
> We had a similar discussion before when we switched get_abi and
> kernel-doc to Python. On that time, we opted to place all shared
> Python libraries under scripts/lib.
>
> From my side, I don't mind having them on a different place,
> but I prefer to see all Sphinx extensions getting libraries from
> the same base directory.

It's YNL specific code and I want to refactor it to make use of
tools/net/ynl/pyynl/lib/nlspec.py so it definitely belongs in
tools/net/ynl/pyynl/lib.

> Jon,
>
> What do you think?
>
> Thanks,
> Mauro

