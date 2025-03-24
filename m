Return-Path: <netdev+bounces-177203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 823BEA6E43C
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 21:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0FD53B4479
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 20:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8851C862E;
	Mon, 24 Mar 2025 20:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hOuCnQFs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173EE2E3367
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 20:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742847729; cv=none; b=mGAhR88aXr7hl7OdRH/wX3Pw3+z3agZpNjH7TM483apYll3PpKAkvXVnRgfdBNoK7qOYsiZve3baTX8P9ZvbsYN27WUxyhP08/IZkEErBrXQzNyvvfGo6uJ5ZroGZ2FWlsI+Vzs93U5LlaulloaO5fwerqctOzJWjnuYhN5qs6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742847729; c=relaxed/simple;
	bh=FztcM5JzPEKSfZfhduO7XfHyNElQhOvgkbtRXZ7IDQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nqJeL9dbUbvYowG9hXxrO/b+3OweWtVHWi+oq3qNFmzgMtZmKem6YV1jp9Nsu962OuiP9hmL3bJyFddzPFhJkAQjppTXjJB6cOtd0MuuOt0a9XVCaSLsMn8q9z3m/t2K/s0tCpv4avFQY3wpc4cEvxhroDEXcC4PiwPJsrOxT8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hOuCnQFs; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2264c9d0295so59335ad.0
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 13:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742847727; x=1743452527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgVH1mDvEmNxyAJr/MBXbYbtV3ceuotfIxoUXuGJIzw=;
        b=hOuCnQFsd7Y/3w9j5F6O0zU8E45BrGrkt9jG+RHfPcoDQHEWALxVnJvp5MG/M+rTn4
         fId5nMBvGf81Fca3X+I5MBD+DXxr9aQ+Vc0aP1vPVIuTwi+IgNccscpFdr0v0IBF5B6W
         JagSxwgZ0ISF99YhLls3LEL+gDfGUH0qlPekuahCm6iPTeyHEBHVOH/xPs7PZAj6s+Th
         lQfDhZyCGV77OKsxFKfAb2lkOLbbzSNEkMlGVW1Wpfp/BhYPljzAfIQrrUjQCdMRGybb
         1842DCXwaqpSr8lYqooEwjS23NW1i0Aufic3VbxYq4XgxgBgLhk/o8Dj4OZ3q0MSS5Rv
         I8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742847727; x=1743452527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgVH1mDvEmNxyAJr/MBXbYbtV3ceuotfIxoUXuGJIzw=;
        b=AU08B7oa2hpa5HM4ePpBfc7kNukhZ75eyIAc/HMVCZZeP5e2ojp4zf2Wyp+6a4Q+iy
         emN2dLnjPg4NXzvRG1i/qwpgw44ghoGjbDPd2jF+ff8l0pJxIIKRkwnbUWM4ILQfBBpU
         aiGBL7PIrzHjeOXC+UI7JXfH815pU7QXTQ0r4Rs+9QW0YtfZc8xvPCfrspCcXQVhXK8o
         v612Q5VIFnWT0WYN9tHh+eaeZu35n4QmerAo0VxHG7ruCCQQeU3JiDzBPkyH4PPfLWRI
         epZiJhg1TCzEkDE7+eZBRcnSBY4U3BNUj3Q5PguUgM8lez5Sa3Xwb6lFjydeUDvHIFoY
         xwZw==
X-Gm-Message-State: AOJu0YxPcQ6+iP0QU1vRRlFopLT+NhMhyfTZAzWm9JsMA2nMXEKK3MbZ
	p/IpMYv5GRnZ/2D9FtZkhx9Fjy70DA55cffVkWa5+2dp42MkWoZo5j3oyYH+SRMwZ/iPDjy8oK0
	rp/3i81dAo3X2UjLCvG66rFg+HNWmtC1Il98R
X-Gm-Gg: ASbGncvWq4ToZoYYITb3IFFYaMJxqIJNJYLxc4Q96BlHHnoDxScA8VYban5C1m3vBjb
	1LoxgQ0af6kqnmUq1QT14i3HfZCNgWZWmO9KrHwe8MTee77OnIGV2X4/7wz3jyjqPKDdQMKd3vE
	lxf/fbtPXr0bC8InB2duLh4borReVPR8G9+JLFkv5JF6+wWJkpMftrTHIr
X-Google-Smtp-Source: AGHT+IE4W70sX1ZkRQ/GL3sVoP5yTJpDgVL6YqdtpN5lSDwuzj4TMC8cSgGv0xiX+YNWSSPMj8XtcM3NbtNq1FWi1P4=
X-Received: by 2002:a17:902:f647:b0:215:8723:42d1 with SMTP id
 d9443c01a7336-227982aac1bmr6151675ad.10.1742847726910; Mon, 24 Mar 2025
 13:22:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309084118.3080950-1-almasrymina@google.com> <20250324065558.6b8854f1@kernel.org>
In-Reply-To: <20250324065558.6b8854f1@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 24 Mar 2025 13:21:53 -0700
X-Gm-Features: AQ5f1JoDwr-hcxtVGUvUER9Yz8iKDA7P1EW26_KEBix0QH-PaONcGrT5CHee4uE
Message-ID: <CAHS8izPTxxcQog3yA=wSyTn-B6jT2U3KsQDzYb4LDW546=uoDg@mail.gmail.com>
Subject: Re: [PATCH RFC net-next v1] page_pool: import Jesper's page_pool benchmark
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 6:56=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun,  9 Mar 2025 08:41:18 +0000 Mina Almasry wrote:
> >  lib/Kconfig                        |   2 +
> >  lib/Makefile                       |   2 +
> >  lib/bench/Kconfig                  |   4 +
> >  lib/bench/Makefile                 |   3 +
> >  lib/bench/bench_page_pool_simple.c | 328 ++++++++++++++++++++++
> >  lib/bench/time_bench.c             | 426 +++++++++++++++++++++++++++++
> >  lib/bench/time_bench.h             | 259 ++++++++++++++++++
>
> Why not in tools/testing? I thought selftest infra supported modules.

You must be referring to TEST_GEN_MODS_DIR? Yes, that seems better. We
don't use it in tools/testing/selftests/net but it is used in
tool/testing/selftests/mm and page_frag_test.ko is a very similar
example. I can put it in tools/testing/selftests/net/page_pool_bench
or something like that.

Also I guess you're alluding that this benchmark should be a selftest
as well, right? I can make it a selftest but probably for starters the
test will run and output the perf data but will exit code 4 to skip,
right? I'm not sure it is consistent enough to get pass/fail data from
it. When I run it in my env it's mostly consistent but i'm not sure
across evironments.

--=20
Thanks,
Mina

