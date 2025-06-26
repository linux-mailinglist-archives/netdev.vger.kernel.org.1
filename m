Return-Path: <netdev+bounces-201596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D3DAEA08B
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 16:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D274E358B
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 14:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7BC2E9720;
	Thu, 26 Jun 2025 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="alpl+jqp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45B52E92D0
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 14:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750948139; cv=none; b=MpOgPmyQd2VyNB712al0R9JLzNGD4fbbsPGo8DOog6auMT5JLDFwGC7N37xy4up0a7DSLTZzPC8cPTTRyLUaoKq+3Bwd8dL/kiVlbuB687An2MWhkU8H3X4dRltY5TRxrrHaRhBsfy8GNtLda76H9n3zFb0O0dUHSv0Zwy6dH1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750948139; c=relaxed/simple;
	bh=uRF120viZgAnv6HlRs+2IJ/iwPg8jCF5krylTcC4q20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msBMhbYNQcTj+iLoAcmvAicigzdorrdtPdFRxDFER6KcJZI6b9LEVOl3l3MUhgjr5UZ4cH1cB0xi0nQUqng4Y908XTrpXPM06JEuq/mo+M//rsvlQ4E5uIfwVndU7L8ntkck4GfE8yB7dD+WscbvQTGmir88naKOrZJoflxBFmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=alpl+jqp; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a7a8c2b7b9so17348741cf.1
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 07:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750948137; x=1751552937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRF120viZgAnv6HlRs+2IJ/iwPg8jCF5krylTcC4q20=;
        b=alpl+jqpvGMWvjN4P6skvLJ0XvVAokqkrwp6auVrNR133A1lYlhdaQcP8RqZViuYDu
         X/Nbeb25YGni+YgeVSebYfUbdktL27SctUZ8UbbY+bz4Q0+AzdrtmwDoqMgTPs/RAyb3
         2LYjJ8Q/UXyoV6WZzLvlP83LJG0yz0PhipkHdnVl2lZQXyF2pUHQqU10YqU51RUg6KO7
         HzzQ8wuo8YSI8QNGC6DAvh4jqSb1lf+p13KI50yptviGES3kMm0fOX9hz28Z9GA6vbrA
         +K9HyGLhatuDssKwtmvLDoF6cISLBr2yOtD5/v394AglcYwYuB4W8krk7lVhKBL8olem
         yj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750948137; x=1751552937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRF120viZgAnv6HlRs+2IJ/iwPg8jCF5krylTcC4q20=;
        b=rrzelRRS+c/4FQ1vv/jT6Yoc27FRUDEWuJRRdRsDHRMfS5ALeq1GOQDu6nfX7dTSKH
         uLSrgPulP0Xbz4tKghEDswtx35KjMJFYoU3z4hzqy8qjtY5szd6LLvLkUsVLUeg/LEj6
         mNH4TBfpbfLyYFlbznZpRFbJa9z0YZLQfIRnRATXN89wlJ9zrwCoaDMCJUZVvdm53JUR
         Kgd9uuWjQ22l803LC63rgog5B7lOgQEVpAro5Pm+SwQnFJ3bjyqZrqdQgrJtcd0uB9+H
         pK/atBJk8cI/O/ZY8twby6i+zTlks/aGvQerAmoj+fDrRmjW6ZNwL3w6ZiJbN6s3rN4I
         5c4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBih1oIv/ShwKfEdPhwyDAsdnFCyIc5Dyx88IiljQJuXrAkKYY4oXQ4C7sjeQ6V76qICUItvA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh73nW9ErHgucesHsC6R+o3IhjPlRZRP7sp7EWZ6aQNDYU2qtW
	JS3YdIaZqhLcs7p5gfyjGkl6gYpRSObVYkX+9tqat7fM2rgsK2Sn2ZwChWj75XrpvHjxQlaSSDH
	Ar57KKrtejagVnqAJeF+gM8g2vZ8J+FDwrb5Igzhq
X-Gm-Gg: ASbGncubSVqrPdH88ENF2PRef8Wbhl/mSuuC7BANhH+bI/lLymPfq+2mZ+AeX8bV0uI
	HsqK6hANpELydCDGsGelYxp6ldC3fjtXJ93swLO1Exb0vj9tYA/kTwDe2Q1hLcJP7IxvbKRp86a
	5mWXXiAIvX/XSJuisncEAJ0Ud9680scoZXvBIdNCYdBkM=
X-Google-Smtp-Source: AGHT+IGkgE8O6T5XUQ81AFBYyM9KSj7iEsBWDWQOgMLXY/DCtihb2N2D2qwIgsoPNCl4jcNjbp2+//KPUOhmpQelbBc=
X-Received: by 2002:ac8:5d04:0:b0:4a4:3be3:6d65 with SMTP id
 d75a77b69052e-4a7c07cf200mr115329311cf.33.1750948136447; Thu, 26 Jun 2025
 07:28:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624202616.526600-1-kuni1840@gmail.com> <20250624202616.526600-3-kuni1840@gmail.com>
In-Reply-To: <20250624202616.526600-3-kuni1840@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Jun 2025 07:28:45 -0700
X-Gm-Features: Ac12FXyR9lHkRQAZfS_Jl19AQ4GhHq6RC4VZP4PTX2g8oUH7OzZICKeK9RL1Mms
Message-ID: <CANn89iKHeB2_+oBD0evw-xPXbQtdGtUiUmTQFsMPnFk9WQAAnQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 02/15] ipv6: mcast: Replace locking comments
 with lockdep annotations.
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 1:26=E2=80=AFPM Kuniyuki Iwashima <kuni1840@gmail.c=
om> wrote:
>
> From: Kuniyuki Iwashima <kuniyu@google.com>
>
> Commit 63ed8de4be81 ("mld: add mc_lock for protecting per-interface
> mld data") added the same comments regarding locking to many functions.
>
> Let's replace the comments with lockdep annotation, which is more helpful=
.
>
> Note that we just remove the comment for mld_clear_zeros() and
> mld_send_cr(), where mc_dereference() is used in the entry of the
> function.
>
> While at it, a comment for __ipv6_sock_mc_join() is moved back to the
> correct place.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

