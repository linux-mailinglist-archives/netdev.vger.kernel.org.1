Return-Path: <netdev+bounces-130858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9177C98BC5A
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D09E8B23120
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C2E1C2DD2;
	Tue,  1 Oct 2024 12:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eDwhb0jz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27721C2451
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 12:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727786327; cv=none; b=r0yyRpAvgCujtFs/NFkocR/DGhT4iqSOBCkzn/sIl44id0KPw3tJQ33QZjNXvkeesmKqi3AgBhoUbundVPBvn/2jPIfbrH3lgnuVYUIouS/sJSr5ZmcKGogpjeYnM21+Xx4/j0+H2Mo8xisYY0pLg9S3bZemfMZj5Mb0ye+sSGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727786327; c=relaxed/simple;
	bh=Rg7m5ufkjDby3GR+KLhCQi4CYQINo92tb4mBRflAEfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oEskC4K8bEQ3+0sHoWsht1eH4Fw3txpyqItzqlILjXWXMND4bhRaJe6Biy6eSC6987pbRkVPdANbdCenOtjBlN8QV56Zzf2ShC1/2yIhTPbHkwlZjBr2bJfdoVvuwh79HlZ6IMFHeRdbDBman4bU2BJwnOEcJJFImUVzgYDOB30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eDwhb0jz; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c896b9b4e0so3458582a12.3
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 05:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727786324; x=1728391124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rg7m5ufkjDby3GR+KLhCQi4CYQINo92tb4mBRflAEfY=;
        b=eDwhb0jzT52JUfC7huKrBmb5GNNZNdvFSvt5sAYG3+i2scCRpcKT9g+YkCSTETdZQR
         yor04CV2ySd77KkpwStqlr8LWIIaOA9+8lqWvU0/KdOlPkrrodjXvUaX6/Tsi7pWV83B
         i/zkgviuT57qyZMBpDKx7QsLH9nfulxwamtoMVyfA4Ety5oHMzCf8U0r2JvMBhykZ+Ni
         mQAZEKBnsz5eG0dmlQu08L/4vwLT2VGewSkMqiSEOt0066MODEo6M08BIjtbE3PKlICC
         ceEaqVFAOamojHB/17SSupcK6NgXZ3dCg1snsTXdobhOL4xcUe+MND79XZZ4SAj2Mol2
         QEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727786324; x=1728391124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rg7m5ufkjDby3GR+KLhCQi4CYQINo92tb4mBRflAEfY=;
        b=h+58Ac32JeY+xr3aknxqFEU1IWBaTcURsmoaUMBPOe3y+tNaQUKCvvovjcOJcKR7YO
         D9XsQRFgBRTGV7EMMZnB35x+LQR31f5Z3ufNy/EIbkDqHWyKoGpusbZpW5c1yZchnjDo
         K8qbaJsxkeqC2DUUHB6bcTWbef++Rigu6ewVp644gCInZ3Igf7Mwf4gscNjqMOsbkbzM
         Voc5EzkSmFUze9k4frQJrFJGnEDq3EtQnriDDKSxkxspolQwhkHq6ucnT497Fg+kVDPB
         sNA4ZQzXQFUAvauTYMLwtnddS4CyQbICfacjmsr6tMkMzTPlv7ohE1ZMd3ikRiyZiRMn
         70iw==
X-Forwarded-Encrypted: i=1; AJvYcCUUt8OCdeYtl2o+YYkjByLHaC4FCdc14bGijNB4YZ3NndTTp+mQEhf1ShFoMPf06w4ZMa9hgvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF+PkJhY2gRE2MH66Qxwfjz+9pEuDRgOoMAQd+l2spb2ik9DcO
	1zqqPMdhBUMfGlz9uPxnRs4WV64QIUlN89OtawH/Rrux4zhNFYJyGmTp6mLj2KHxIe0C5LVqJOF
	8DTK884c5SHcR2rUfn/WSZaHlTr4P+5bQEKQ/
X-Google-Smtp-Source: AGHT+IG74CYgxnxnJk3y/UmG24QszUXlR8tuHkTMO15Jhnud8DGnGozkyEHUUHW1R48cnghVeOlbJ1YULuweTXZeZKw=
X-Received: by 2002:a05:6402:e9e:b0:5c0:c10c:7c1d with SMTP id
 4fb4d7f45d1cf-5c88260359fmr13409081a12.23.1727786323594; Tue, 01 Oct 2024
 05:38:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001024837.96425-1-kuniyu@amazon.com> <20241001024837.96425-2-kuniyu@amazon.com>
In-Reply-To: <20241001024837.96425-2-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 1 Oct 2024 14:38:32 +0200
Message-ID: <CANn89i+WTzL=H44WCHtF5Xe2v842nigU3GKQYBUpdqppKuUc-w@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 1/5] ipv4: Link IPv4 address to per-net hash table.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 4:49=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> As a prep for per-net RTNL conversion, we want to namespacify
> the IPv4 address hash table and the GC work.
>
> Let's allocate the per-net IPv4 address hash table to
> net->ipv4.inet_addr_lst and link IPv4 addresses into it.
>
> The actual users will be converted later.
>
> Note that the IPv6 address hash table is already namespacified.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

