Return-Path: <netdev+bounces-167086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2ACA38C3F
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 20:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A70188D566
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 19:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3291E237168;
	Mon, 17 Feb 2025 19:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LEUWTai8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEE0235BF4
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 19:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739820090; cv=none; b=jQS53My0JCX6kH5ro70qLKeJnU8sMsxoUXoBO2CpowOlhTdJdKM+rPcUTb8HEQJ7mmgaCOK7EbsfY5pGd64XHQbQylea0zLkyS5ZxiVNgLqvMv21S1Whhtc1sdzGxh4BWQEjuLlgj7jkyzgjVpMRhXFQSbY4O9K23nWTvZr38To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739820090; c=relaxed/simple;
	bh=sF4dNgTXt9P2MfDrCOM2x387UotJwcbVDhqQcOqS8qM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WeGH2r5iNiLGQp0tu8maaiYo6lu+wVMTbScUfcNN2Kgc8OPKh78BSY8zeYiXJpctLO3LMk5JH2Hw7x9RoYeGlqKHg9EDRn5lZSCuPqNTXoNXwWtZuBUcNGR3xojw4FAWKbyasfY5D5AgBRrwkKy3SBRMZFaBAfU+odDxfo4biqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LEUWTai8; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abb999658fbso156480266b.3
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 11:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739820086; x=1740424886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKWt+CGIeGqmvl6o4duXuS4HEdgdnEPBpkkM9quSgZM=;
        b=LEUWTai8Udvd2WrNJJdiWgmkSZ29O1jrDaGNmecDH4Mp8eTlfEGosra8Esv5mCuw5m
         T9Me4dUURnCS4Q1AvBLazwVJWfgrzR5vjDv3vqvtbXp85LDMlTLVAayc6nea/z2L1Si6
         MGQcIyRe+1HNACMvQWLNExrbFi1uSDOwkYF9grupsFH7SNIWCpUizowy9rKipHfUs9SZ
         3a/Ew7EaFmJ7jzIWopksR9sKhylJZQrp5Axg35LncuRLLTyYOrVVngK3xwAzo+Rn1qR/
         OFLiX7nVKqOeElHZuelI6KDLK2yb7oyIl2hAjgrrr5jjnnLSAR/nco4GLbVaJp7Dd1lr
         cXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739820086; x=1740424886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKWt+CGIeGqmvl6o4duXuS4HEdgdnEPBpkkM9quSgZM=;
        b=dbIDYriomxtFV0ZbhuSvCwdSpZkj03ICF+tlEfc1hfuj8en/2F9nf18t5uoCCgKkQ3
         6KQ7Hw2EmNpTZfGX4J6tQ5OnlOki1o6PRFo0MufrJ07JtymZYXdSWkfW0NG767OqtUNX
         qhNAbie0VY2nGRIODwlhywMENf6fTEEsu8cuay99gA/zy7WGLovh6Mg+8CMzhW+k3LNh
         XAY8u//GRSy1A5bBfNtA1GYV20xgJF4skVFs+FBPkEmgpoQfKx+y/NP1IhhUQGm3iM2a
         P8ArG1+xTFOa7kY6n4ee0mB3FzBHJH/TzR5s/leFaI81ePvuKgWEpRwsE7fnCOUwKBAA
         SF9g==
X-Gm-Message-State: AOJu0YwBHQWdWHVrl85y8zBjFVJV5svZVrFnHR/BhXWWshNbRAfduCsm
	9eDTu1mTy9ZOCSafPr7Ky/Gs5qvmCFmyWUxsWUZ5c6gW2W1nGE3ue46kOu/H5reTDoeHd14B5C9
	9QvCkbio65CtfWIUsWZlobIKkiGYFevdvpKm4
X-Gm-Gg: ASbGncsrDJhWUw4E/UocTocbmFS+fzas6N/DPuots7IjRT7+y/SaO24tnyyutJkvnpX
	YfNpajIpYKZt0l6o/an9iWQoFRoJARYF2Mumow4SMGQnc6tELjCoBb9Kz8hDZ0BYx9gbV7NxJl3
	Qd7K80eCAAHI/2sUol9zs4ZJ1Wuvm0LA==
X-Google-Smtp-Source: AGHT+IEap8PYC/gcmteZ5/Wv1Z18lYQy4FdMXowXmrhdhBEF8xkPaOCqgelb/BmzAGvTlxW6HATJTR3fKO7HM9UtNHA=
X-Received: by 2002:a05:6402:268a:b0:5de:594d:e9aa with SMTP id
 4fb4d7f45d1cf-5e03602e4a5mr29725670a12.8.1739820085654; Mon, 17 Feb 2025
 11:21:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO9wTFgtDGMxgE0QFu7CjhsMzqOm0ydV548j4ZjYz+SCgcRY3Q@mail.gmail.com>
 <CANn89iLjxy3+mTvZpS2ZU4Y_NnPHoQizz=PRXbmj7vO7_OGffQ@mail.gmail.com> <CAO9wTFjaLBbrT7JKBBN=2NMhSRmxzPk_jLSuG=i6Y5anZJnvEA@mail.gmail.com>
In-Reply-To: <CAO9wTFjaLBbrT7JKBBN=2NMhSRmxzPk_jLSuG=i6Y5anZJnvEA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 17 Feb 2025 20:21:14 +0100
X-Gm-Features: AWEUYZl_PHuXaZdgyEUWM3QOrrhFjFhmZ0Rtac0XSGxtCN7MSzV1nZp0v_yrI1I
Message-ID: <CANn89iJmOKiALL9r_9+nyy5bdYwMUEX+LAkmswMyWwNC53yEew@mail.gmail.com>
Subject: Re: [PATCH] net: dev_addr_list: add address length validation in
 __hw_addr_insert function
To: Suchit K <suchitkarunakaran@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, horms@kernel.org, 
	skhan@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 8:05=E2=80=AFPM Suchit K <suchitkarunakaran@gmail.c=
om> wrote:
>
> Hi Eric,
> Thanks for the feedback! I'm new to kernel development and still
> finding my way around.
> I wasn't working from a syzbot report on this one; I was just
> exploring the code and felt there is no parameter validation. I went
> ahead and made this change based on that impression. I realized my
> changelog should have been more generic. Sorry about that. Also since
> it's not based on a syzbot report, is it good to have this change?
> Your insights and suggestions would be most welcome. I will make the
> required changes accordingly.
> Thanks.

I think these checks are not necessary.

1) The caller (dev_addr_mod) provides non NULL pointers,
    there is no point adding tests, because if one of them was NULL,
    a crash would occur before hitting this function.

2) Your patch would silently hide a real issue if for some reason
dev->addr_len was too big.

