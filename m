Return-Path: <netdev+bounces-133085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A669947A0
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 13:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 763081C24801
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 11:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAB618DF88;
	Tue,  8 Oct 2024 11:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Yh0L+Tk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADC1481D4
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 11:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728388153; cv=none; b=SrY6K+mtO+8mwJhilllsBgS5H1gQQTTT0p0Nrn7V7/a06Pt7jOH5SODwk4DbhwKj1hEiuuiX5I1qfEKuJv7JM14cvQfyf0FICgHoHrrjimQipLknJRLU1mPfpPP8nqpGfKYnH+9mJtx0vaW235Thtb+SLaIUqD6lB3nh8zcpMhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728388153; c=relaxed/simple;
	bh=usCXEZEPzcDkNbd5r3vqccKXjm6lP3PAyze66h/T0l8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HIgP1Xxb5RtJQ8LEzECFJcs8+TNRJ+NLyqAnnQvFXjmPM5mxcH+evkYIVnKCel7TehO3l7wwJi/GDcPWwl+VcE+cjS2wHiShIy6oG+FAih+asiYSf1wF+/EXD3PbqVxKFGXR0vpY3QAK5kfxvS6Fp9hRIhpQDppsc6FPu41jsmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Yh0L+Tk; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5398df2c871so5866203e87.1
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 04:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728388150; x=1728992950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjY0EPfOqFgPVafww3/rHxcJG5jVTBjj43SUV6ZL/CA=;
        b=1Yh0L+TkyXnJDvaCWYQvps1F61S+X30+7RzUlGHHPeLcf0TRv1WZAeKk+KlHk7hzAo
         yl8fh3FyXfLYVuv63iIaDYVkeM15l8hOMuZd3ADGcvi3vPtQO67AYuZR1LLG1dVuOl2s
         VbGu6Bt2DXXeH/ewzzIH9p89k3X4yseVo4X0SB3r3o+8zNXGpMnv3DVLT3wbVQZbW6+t
         euISrRIQo2R0sceGQ5YTD8oeROMeggbpyKfnnQaUxr20Qhg0Ivcg1zmE9w9d6VdOWGJO
         uy280KU5PA9Yo0snkvzJ0LoDF3sTA85nkIytYKklyH0xDwWrQtN32vP4UzHc4D87j7hP
         3jPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728388150; x=1728992950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RjY0EPfOqFgPVafww3/rHxcJG5jVTBjj43SUV6ZL/CA=;
        b=UqJE0inzIGIEbRNvPLwHIg0rsgpoDHSSedg/J0FBX4EuuJMYxUgCxZuDBAOm/3BNZa
         SpSwzZt+tpDUHTFIZJfXLoKsy2tmiek93ElqWTBNEfDadTWpQMnSr0AnBHehg2CHVsyo
         Q1fyhON+5s2wVE0yXXHbNzgyUL9M8LY4WZYfms+soKPBT6ZfYT6O0E1+pszmeqJTh2ja
         iH/WbHUx9gBPOb8K4Vm4VzLXO/PdEeSW+QtzFVTjoY3grGy813g1rdCBw3dLQF8Uk5yS
         e2Gp1HQBru6ahrfo7ygqzSWXBAwlostWWZOSSdxrghiLfMMsK9T9CP8NBR6DW2f5fTTp
         T7EA==
X-Forwarded-Encrypted: i=1; AJvYcCX3SC+DSb24+d+tN/8DZ9MHgJ0lfDe6M6GWNcqR6xOFYIcly0UgMPYxTqQuNygduoQzqnRzq0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoxO6R/ZvP9sDMdJ6gfRZqbP74H8eJOeiP49bdQgtPWvKM3zyK
	2ZowBRxeMfcvh4ghojjbvXFMi9GcZFyUfsiqi4yMWD5yOylMiH1Q89T4PTjbdq1dhjwvYJl4BAz
	T5UPuY5V0VfymPn+qDxE90P+lXjFliMx895JQ
X-Google-Smtp-Source: AGHT+IGfr/U4EoULFKXAa8Cg+mzw2d99bHYgvfTWzAWQytfxVix0MJZmm695PgIJmzZW+esrz3RPF9rBql4nmU+ewyw=
X-Received: by 2002:a05:6512:e91:b0:535:6ad6:2d40 with SMTP id
 2adb3069b0e04-539ab84a6d3mr7229050e87.11.1728388150091; Tue, 08 Oct 2024
 04:49:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004221031.77743-1-kuniyu@amazon.com> <20241004221031.77743-4-kuniyu@amazon.com>
In-Reply-To: <20241004221031.77743-4-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 8 Oct 2024 13:48:58 +0200
Message-ID: <CANn89iKbH6w-6XEyr1BAcnBVohFzB+n=de8v42NDFkut59wHHg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 3/4] rtnetlink: Add assertion helpers for
 per-netns RTNL.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 12:12=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Once an RTNL scope is converted with rtnl_net_lock(), we will replace
> RTNL helper functions inside the scope with the following per-netns
> alternatives:
>
>   ASSERT_RTNL()           -> ASSERT_RTNL_NET(net)
>   rcu_dereference_rtnl(p) -> rcu_dereference_rtnl_net(net, p)
>
> Note that the per-netns helpers are equivalent to the conventional
> helpers unless CONFIG_DEBUG_NET_SMALL_RTNL is enabled.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

