Return-Path: <netdev+bounces-64185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30189831A92
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 14:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 634E01C21572
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 13:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8851625546;
	Thu, 18 Jan 2024 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SH3OaEhn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2509241E2
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 13:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705584518; cv=none; b=adUMQ1QycC3ZCX2efDu736GfJOFI/Xp5Vs5QJKaHYywyoJyT66P6ubxyKHIVuRLrKjVlBWDfzk6qapHfuMRQqMXPpQn66kznggYTAJ1Z4AFum/HkwDBUcPQctqML3rW+/Iwp++I04UBQYKLq6SZErUlHjnI8hyrScqb2uLNQ/NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705584518; c=relaxed/simple;
	bh=PSZfDQy+rxsoZQwcLAXYzVgScCvbozQaEUpVH3JDy/c=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=ZFWv5z1tNCs7h78BVWY7QFyLKHOxGiZavNL+BpGqQNnOsNde+cugjKHE4MJpvS/a9gqthPey2LhRbMIIVEPhglmnk1oTtcjjXJbJFNXRKop7r73MccNaZGXavpL4ELR6+kBtGca4AwNl2wHj+LAzqlE8qrRJgSDlMLf3a4GwFBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SH3OaEhn; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-559f5db8f58so5957a12.1
        for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 05:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705584515; x=1706189315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PSZfDQy+rxsoZQwcLAXYzVgScCvbozQaEUpVH3JDy/c=;
        b=SH3OaEhnX6BOf5u0M0xjK94iok2Ss87wJLJko/ZZSWyB/XsJU8ZQYFDWd6eZXMI30D
         jtQ5GurKWIKF1ednFyUu4y8xErdAR1uf0kAmFRZlVW1CJK4sO/1krmqbdWvzh1tLXcTU
         Zj0h6TiEpnp3ON1ORkoIvU5k6zGyXVJgzoV9VtP0H4LRW+S+BU0WJAZ1FkvhtAmGlnWG
         eXcDEfqSokkupHPxhP028jwyYp1vee16XZsTA6YYV5w1s6wTnaNDINW1hayyrOMk52qf
         8u9PYgoViFH8MQODZxHJ4/OtAuALVj7vyZ0ISqDI0D+5T/0mzZwhnMe/dlJp7pkKRzio
         f1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705584515; x=1706189315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PSZfDQy+rxsoZQwcLAXYzVgScCvbozQaEUpVH3JDy/c=;
        b=C/d+TsGZnMa4751MscE1rLDDfcA4jqI0EwVzfdI1leU9FyoiZHcJLPTjflBr1rpSB0
         B5JR0dK82rBTJ9FIfqgddusvxLSyxJ3ajGn79Ld6ZDL7yDni2gAPwEAc4QEdHUkFMmWc
         vDZrsC0mL5tg1S1MiCN6p8E+lN2id7qRgO/Xu0OxPeCcK4wJstrj4rBXYrqkOkNIkMiP
         B+LA6mPGLv+pnjpD5hZB6nXNJ9J6pHVLA8hQfam82MUZ3dydv11fJqAtXOxi6GZnUUvd
         y18ahWx1ighLiyGyIhOk9gF1p7nHlnwIqYGU/IOD4IZUz7TuR5PcHoCSGPdq+WXADMpK
         N23A==
X-Gm-Message-State: AOJu0Yzp6/P9dWRDlGM8yh4K6MD5cuR19zg4SZCLV4d3c7L9ZnlGLw0O
	0eAWcUrc33iI9u5Ya6+N0yZO4WyB9LYazKsE6hvhVS4DmloClHaEqzFTDbBrvmeMje8HQqhh07G
	8EOKA9aZTIVEwvjU7ky/79lgr9FgCzUDetZ7dhwXM3shvaAeUgA==
X-Google-Smtp-Source: AGHT+IHqePTvtGNp07JBxb7FAfRP01FQOVDqhd+sI8ncp9unArToQRLQH0XZBGBRgpedxsTiYylm2a4/ftrApPRGB+M=
X-Received: by 2002:a05:6402:b4c:b0:55a:47a0:d8ad with SMTP id
 bx12-20020a0564020b4c00b0055a47a0d8admr1367edb.3.1705584514725; Thu, 18 Jan
 2024 05:28:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117172102.12001-1-n.zhandarovich@fintech.ru>
 <CANn89iLUxP_YGLD1mrCmAr9qSg7wPWDjWPhJHNa_X4QVyNWqBQ@mail.gmail.com> <549c658e-28a0-4e6c-be09-95ba748410b7@fintech.ru>
In-Reply-To: <549c658e-28a0-4e6c-be09-95ba748410b7@fintech.ru>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Jan 2024 14:28:23 +0100
Message-ID: <CANn89iL7W_uMuDWpPSZ9_a4hVQE=qF3ES+R0jCOdWkj=M03CMA@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: mcast: fix data-race in ipv6_mc_down / mld_ifc_work
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Taehee Yoo <ap420073@gmail.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+a9400cabb1d784e49abf@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 2:04=E2=80=AFPM Nikita Zhandarovich
<n.zhandarovich@fintech.ru> wrote:

> Just to clarify: should I incorporate your change into v2 version of my
> original one and attach 'Reviewed-by' tags or should I send a different
> patch with your suggestion?
>
> Apologies for the possibly silly question, got a little confused by
> signals from multiple maintainers.
>

No worries, we can wait for net-next being open (next week) for adding
these lockdep annotations.

