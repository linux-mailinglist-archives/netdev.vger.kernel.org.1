Return-Path: <netdev+bounces-60595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D93820133
	for <lists+netdev@lfdr.de>; Fri, 29 Dec 2023 20:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 724C6283715
	for <lists+netdev@lfdr.de>; Fri, 29 Dec 2023 19:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B554A12B6B;
	Fri, 29 Dec 2023 19:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Y31anWSQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B383134A0
	for <netdev@vger.kernel.org>; Fri, 29 Dec 2023 19:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6dbca115636so4271753a34.2
        for <netdev@vger.kernel.org>; Fri, 29 Dec 2023 11:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1703878594; x=1704483394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOa0KZTkFN6UH7WU72Y2lMkvi0VinggiqwwLcCgErS0=;
        b=Y31anWSQl/d9IaG28QZKe0gKQll2ekpQlz36mBUiVR8j0lXE4HfK1+CUNum79MtWnX
         KGYFHid5lRtJimXnbJ25pjsDGm061/d8hE9UpzbLHpuToSyBIsjeYaNnGsde7JTf9Dyz
         AzdJb1dHvW+/nr/qyGdt7ffk/CXNwPF/N5yywKRfvYf5778kO4kQQuRsPhmb5F2fgEnZ
         jaTNol2sgR+OdOUIaXE2aiydTuvsIEe6nr3AmA8R7uynpzp9gkFZDp6tyUeXm39DhhJT
         ABwCO4qqupR/KDBmB5G9NRFrzTRg1+KvVDtqBja6oq9uVADlF0sMlRBUQ7sQYMumH5bg
         A+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703878594; x=1704483394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOa0KZTkFN6UH7WU72Y2lMkvi0VinggiqwwLcCgErS0=;
        b=cPAuaqjcwHgIZfAdfrscZaQH4TWSsADFetcIpMkMmNGeoMbwFSNbhfhMbSS0E24CeA
         tXU5c4j3f8uyE7vA4EsoZyiLvk6/hc+yrYA7E9JR9vifOJEfXqKyafR5H7fHyvGNXppU
         nEVi88rNUlSWmXsvksdg37m37QUMieGtN1VE7idzF4rlH3XbWDYxWtzv4TnkcLBf0nBI
         3ieympD0eszlZhFOs+8SZEgK90wtELm7VzDdNZs+cc+zF+pG9xQzGHkKXajq0pddMOo4
         Zr1WRGggaZxRusQFMzZ/OiYGxVv04cmYPKNvbOB6fMJ6XChTJRbYn8hl7RK3Rz5B8gK0
         UWbQ==
X-Gm-Message-State: AOJu0Yyamv7E60+KGphc1t292v7Ui3W7b6xfRxqdP9GHfCO8Hev5cJzQ
	Cd1XcVrGf5XV3MsIcWxNmJO8wLOGRNq8ybI0Vx9co3vs4FE=
X-Google-Smtp-Source: AGHT+IFBJhHQnmbIeZs1XdMOHwRoYn0Cb43AFoElHIP0/WdhzHGJcX8cQyNivuCpzKiN58LmNJwUuA==
X-Received: by 2002:a9d:74c4:0:b0:6dc:2a0:26a2 with SMTP id a4-20020a9d74c4000000b006dc02a026a2mr4384073otl.56.1703878594470;
        Fri, 29 Dec 2023 11:36:34 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id p184-20020a625bc1000000b006d8610fcb63sm16252783pfb.87.2023.12.29.11.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 11:36:34 -0800 (PST)
Date: Fri, 29 Dec 2023 11:36:32 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Eli Schwartz <eschwartz93@gmail.com>, David Ahern <dsahern@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2 1/2] configure: avoid un-recommended command
 substitution form
Message-ID: <20231229113632.45c70893@hermes.local>
In-Reply-To: <ac91d9f3-0651-4c66-9d38-c40281150ac5@gmail.com>
References: <20231218033056.629260-1-eschwartz93@gmail.com>
	<20231227164610.7cbc38fe@hermes.local>
	<ac91d9f3-0651-4c66-9d38-c40281150ac5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Dec 2023 22:57:10 -0500
Eli Schwartz <eschwartz93@gmail.com> wrote:

> On 12/27/23 7:46 PM, Stephen Hemminger wrote:
> > On Sun, 17 Dec 2023 22:30:52 -0500
> > Eli Schwartz <eschwartz93@gmail.com> wrote:
> >   
> >> The use of backticks to surround commands instead of "$(cmd)" is a
> >> legacy of the oldest pre-POSIX shells. It is confusing, unreliable, and
> >> hard to read. Its use is not recommended in new programs.
> >>
> >> See: http://mywiki.wooledge.org/BashFAQ/082
> >> ---  
> > 
> > This is needless churn, it works now, and bash is never going
> > to drop the syntax.  
> 
> 
> Per the patch message, the reason to avoid the syntax is because it is
> confusing, unreliable, and hard to read.
> 
> It was deprecated for good reason, and those reasons are relevant to
> people writing shell scripts! Regardless of whether it is removed, it
> has several very sharp edges and the modern alternative was designed
> specifically because the legacy syntax is bad to use *even in bash*.
> 
> (bash has nothing to do with it. But also, again, this is not about bash
> because the configure script shebang is *not* /bin/bash.)

The existing configuration was built incrementally over time.
Mostly as a reaction to the issues with autoconf.

Perhaps it is time to consider updating iproute2 to a modern build
environment like meson that has better config support.

