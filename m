Return-Path: <netdev+bounces-155390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F967A021FE
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 10:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A79047A1326
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 09:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B071D958E;
	Mon,  6 Jan 2025 09:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x+MYYSFH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893AA1D63D6
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 09:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736156210; cv=none; b=DaNCq++hJNpmDINxz1abHfBWhGXb1aCO97upOFA890Bu2t1eeQvE1W4H3yTt2Kx19cMc1gQJEmtHVMx10f5d9DiNq+N8wQkPzc8r7tvF11oSFdZVd5Fwtp2K4hkV0gNOYlcN7Vx7/VCCK0RFapt6+XZzPQei6pffWnKcMyyXc50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736156210; c=relaxed/simple;
	bh=w4YRZvIoZl/v7b08dalXZxwuULTA4DzPXb8EuO4iM0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eeAVEL2OTC+ta+yW7mV7xIu3nsjH67rlBg2BHRiOgTVOTVDADwZIwLwRmyYukio54e2tnxDrlhkrfNZg1gMoTUxrxdW4wrpENntSQ3V6IPWxDdenadnS/UwJ0ai9VCEQH2evFv9yMSAnLwpvjacLVgVtWg5v8a5u+Fk9EvVz5Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x+MYYSFH; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fc01so684588a12.2
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 01:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736156207; x=1736761007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4YRZvIoZl/v7b08dalXZxwuULTA4DzPXb8EuO4iM0c=;
        b=x+MYYSFHqCdHZwu+6GHq5kR/jlfojOGD7WQlXbFwt2O6D0E3xc9oo5O/QLFC90r/lx
         WqmzCz/LjBHiFQqoMTmqXuRovLRpzhlQPfOpvveVCsZM3PAZU4sopFhC1/UvhZkozrM2
         VzdByU7ydB3J8YtRHinhreNpx+N0yoR6MJ+PKCSpz615kPbXfEMZoXEgdF7yX3KeN53F
         Dc0C8AM/H89RSE+xlmZ/FFScAKtrTziulBZyHimB0IVPilprZ2VU05q2T63uZ5y++bSE
         fop8GSc7lPQmbeCuFdwPyLAu7rvLjyZHi6o8YMQDHlc8S3ehK4ihCLKp4i1mM5isBopX
         Aljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736156207; x=1736761007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4YRZvIoZl/v7b08dalXZxwuULTA4DzPXb8EuO4iM0c=;
        b=E5l+b2YL6BVppp9+HZS15JKGPXYwtQHO6za0DHw/mgdZjFrG3KnZAbEgI8K738uP2Z
         tktpGaxWdOIv9VbBOMPbgqaCDNZozmnymgEckorYWa6AZJ8mDb66YE9PtfQYhrgMV0GS
         mUL4R1fA5XS82ZBnP6IrZ3YKMFVABDM6kXL4N5HxSE2hviIpeUBQxQnJEcOAZvNrhekl
         t+2KgdkHY56Tm5Igh7fM9eGGBLZz5W/tE644R7pgTE+cloDqpA53+JaEoq+H1Hesbsgk
         TVbu/PwxNhrdelkah29qaZPqQTyWzOsihMbHjJ420mUI2KabXziFUhjp6JiU8nHDtg9z
         ypCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaNZmftqm0N0J9pSWoDfmZ/QyJIhUcI8RQenOdHPnzKUuM+1EJWpE9bteLMQdAqQMBjnTi/7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjQz0t8v8yQBaj3iNj1pHhxUFgh+krVL9JIj7+kyptb5K4dAdy
	AdrlOZYoaFhNLv5NK67Hhsbhm7KzVkJ6uzAZlmobXLDvbe0e2ANgx86GXUWDLX80u+wl1K6ThzW
	BbCXwdvUgG5+AMczmMKIL+7S8xlS+XszU8mzilVOPadydi5ev0g==
X-Gm-Gg: ASbGnctgpoVhP4PRteO31Nw0NCjJu9dSWSs4C6GIxJ0T/69opDw6bTt0e3BAl8AmwUR
	IdGBmIvpEEj813j6K+5k2LRyrrG62dSwASfgdUQ==
X-Google-Smtp-Source: AGHT+IHf6MH22bZKBaRHdoscrI9+sa+4vRAxOwd5mBiVSkoIj4FKkke0Ih6+dNPwCCaURzsZeqJt0jPyKFS5IiKNXYo=
X-Received: by 2002:a17:907:1c10:b0:aab:eefd:4ceb with SMTP id
 a640c23a62f3a-aac27025de5mr5335368766b.10.1736156206648; Mon, 06 Jan 2025
 01:36:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103185954.1236510-1-kuba@kernel.org> <20250103185954.1236510-3-kuba@kernel.org>
In-Reply-To: <20250103185954.1236510-3-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 6 Jan 2025 10:36:35 +0100
Message-ID: <CANn89i+4rbirjiACASWGSJtL9oyu2FRBneNOFfcKXc7UX+e=HA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/8] netdev: define NETDEV_INTERNAL
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	dw@davidwei.uk, almasrymina@google.com, jdamato@fastly.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 8:00=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Linus suggested during one of past maintainer summits (in context of
> a DMA_BUF discussion) that symbol namespaces can be used to prevent
> unwelcome but in-tree code from using all exported functions.
> Create a namespace for netdev.
>
> Export netdev_rx_queue_restart(), drivers may want to use it since
> it gives them a simple and safe way to restart a queue to apply
> config changes. But it's both too low level and too actively developed
> to be used outside netdev.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

