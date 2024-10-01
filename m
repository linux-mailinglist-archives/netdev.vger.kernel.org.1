Return-Path: <netdev+bounces-130862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0FF98BC64
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F055B2151E
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D891C2454;
	Tue,  1 Oct 2024 12:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cKoeCvqs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABBC1C2453
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 12:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727786495; cv=none; b=Uj+XP/J3keZGz3suGVtHtqrA/4GuAqeXBTU/D2j8sS2UIXlwbzR+F+ZQo49cNcNzHK6hxzzqP9dR7aaAy04GjCPTm4HKL/rDD7gz67zrSAf6VRJI2OZGTAaPdRUs+fxI9Ocwx9RGunzuvL9dKyrZAcVU9UqKvZxo4neq34+oA84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727786495; c=relaxed/simple;
	bh=WAb9aqnmhrA4/KNrSEsEH8Q2Z5OlZ+zr+HdOgOj74wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aF/V1pSalUe3FaWDuZB6jt40tHHyJivmIexzdgiDj5jIa8Bc0e2AgOGpdbo9BZQe0SkuR3eW6yB3SUTu+Od4YvUWcHX8asG4dmVCSUoDm4/p2p61s5fR6xb7nGkXsYChEAENcz21ehNAAYMc7tfkn9//fADxjLDnHS7IY186pJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cKoeCvqs; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c89f3f28b6so1954507a12.2
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 05:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727786492; x=1728391292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAb9aqnmhrA4/KNrSEsEH8Q2Z5OlZ+zr+HdOgOj74wo=;
        b=cKoeCvqsxCXgb/CidPtYLF61h+IS1pVspShAqIe13dnmq6bWcIIxcZ3yVYJTADAGWP
         YcIAQ4O4OqSJPefMEsxZdtFvLpS2O4TX2TEY7Z1UZdSih7rBBOVpskJsOZ6nHssqIoMw
         bkt/V8H10XTBRUxc9Fl/P7Gmjuatw5hlxl/fep13sN5E/EoL9UxJrlzo15pROUN+DgLd
         Ua7Cy1noUcTn4Es3SS7HDSIJQmonUHpLG5LKaO9onvNyov5CtYndJsSmxKe/sIUz2H+q
         uJslvLOQEQHpV1XXwya1D+7piOsGqCjfPLWfNp+qosmarYpMIFCjEJVJJ3R2lVWaMGuX
         l8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727786492; x=1728391292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAb9aqnmhrA4/KNrSEsEH8Q2Z5OlZ+zr+HdOgOj74wo=;
        b=T8xKhvFnR2LerfXb77dorckqHWh9dUmXQW3jta3Z1lFS8liR4J4csfa+3/B1lJ5QIH
         VB0/EUJ58gMTiN0K1Bd0eqyiFsOhBF0BOusE4TlVA+Dw7qHeZr6ur0DiCEr6t0YsW54t
         LlH/aw0CzHGPuYtGb8XyLrrhcYhiYocECn4+Yfw6ciZdjKhBQaCzRz34tzn/Labxkz+u
         dPtcI86dQA7SOjBfHOoo18l1T0mbiX480rPdubtFla/RykZK+ZgSJ5P8KpgyRRIknGxw
         /tfaEvGxuKGbll6lnBVyNIUQy4xrwzxw8fne5768ObQjv3X0G9gjPtc++GWYInfm4uD8
         W2zg==
X-Forwarded-Encrypted: i=1; AJvYcCXuTI55Uw7GekYz8kttsN1gbYL4RYkiV0Aow5pKxhgJ7uDlZlo16vSSot4cdAHR/AbZSmzFsaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuMscITDTETuwnZpJgpwDKZadlrXrhqPg8rU/Uc0I4XWF3OPWe
	DeRe2hTdy9Dx1wwqvxw6gn4OvDnthSGR4d76/jJKy3S7V0kkNxTKtTVr3LoL3FRcMIwsgzaeIOg
	7e6QHsGHZzC1rta8C64xoCUeaIxgTz7W5UrzW
X-Google-Smtp-Source: AGHT+IGaDvYAada1tvnJc9KjZhF/3Rl6AXeE4DNUTdX/GqG8TPilbMfvDE23CDIxBmWrX5ZNzGygBh6QX0+6zkiWoNM=
X-Received: by 2002:a05:6402:5186:b0:5c8:845b:c4a4 with SMTP id
 4fb4d7f45d1cf-5c8845bc500mr11775929a12.31.1727786492174; Tue, 01 Oct 2024
 05:41:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001024837.96425-1-kuniyu@amazon.com> <20241001024837.96425-5-kuniyu@amazon.com>
In-Reply-To: <20241001024837.96425-5-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 1 Oct 2024 14:41:21 +0200
Message-ID: <CANn89iKpf6nD849XJFTrCNMbRKKbn+1hZYOVCTEROUZOw_kSmg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 4/5] ipv4: Retire global IPv4 hash table inet_addr_lst.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 4:51=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> No one uses inet_addr_lst anymore, so let's remove it.
>
> While at it, we can remove net_hash_mix() from the hash calculation.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

