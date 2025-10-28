Return-Path: <netdev+bounces-233656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9FFC16E58
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 22:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A11E4E8473
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 21:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DB42DC772;
	Tue, 28 Oct 2025 21:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XX/GUnf2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBCA2DC76F
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 21:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686085; cv=none; b=XZv9q63iPxkQ+fYo0vuYgi6/8qdRTCFkGDQa1pYI66q0cXAJKYiP1eRJ1g6+4/zhxw5GcqkGTYEbh36RLQgKDmcauVqnC5AXoveBSzCvGq6QusetKql3h1Djj5nGrXUZBmy4HgLHPjpWS2FesbY7161hQ26g/yvVcImNzXGjxPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686085; c=relaxed/simple;
	bh=DH/vjr1xJnlnDcFd7bDABFJGNE8f4srzny3zaaOtqPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6zrDW6R+1wtxoCQLQWbXrlVPEhKB3uboli03FpOT8eTMPpe5/qD2Gt062PyfRreuf5pxaPcWBy4X6/sofAzthTMjnfaG8Q745wPmDrUVtXz3ikUGJbaWbLTPnoyvP+kPhQuT0OFguKgGgKWpGuq6C0NrfUt+BWf3im8CA5Q+T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XX/GUnf2; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-783fa3aa122so5107607b3.0
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 14:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761686083; x=1762290883; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z/gHqxUO2WlS5D6RSGbV1tmzbakm4fCZt0obMcOQyEQ=;
        b=XX/GUnf2odQ6UmbazRq4Uk4ojI2N6Q+SdrbRSG/N1jIuRuDiHaCpaopZ6oVTOzhgTX
         W3mN2oDXAsoh1LkXu6cj+EYcTwJqdl+jiD9H2tvhKVBzq920gNjpjy0nqG4WFFgr4k/J
         wbff3mSk5qZ9JvyvsSUQxjLg+mDsoXpSGKzO9YAGhRS5twj3OIXbVE0ttwmNVjOeJvyY
         QViu2xSfdJQBZpjasEAUpRA9mo5/Cj6asYjM45tWCNO65RN9lG7Ka2myz0tfiAAomRzV
         XrRSEKyZqXeqlR6ryRYY4NmoqCTbnacpyId13H5FDv0aF7FFAVinGUY0MI6FkanHWBU1
         Zb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686083; x=1762290883;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z/gHqxUO2WlS5D6RSGbV1tmzbakm4fCZt0obMcOQyEQ=;
        b=TIlvfQn91rSc1Uwb7ELwn2TPzZnKlm3zqSaMV6zJnboKxt85K6QL4rYqiKqTvAmQ6I
         7KIeVZItLlemfKJTcdxEMifnuxLV+8EeKWXf9qqT4v/QQrFX9TZe1lGELuaaTVgBOhRP
         GHxxaFVuzfzu+Me03rGPYqf9Amxuo5GlC+Xz9lrIfUt3rKgqkkGN4u8ENoWZeSJFKQ4u
         m0047jL8vDEFaXszW/xVId0VaI+3HhFWwhWIgHmuO0knTAV+G1S8oKlco9+oo1NIsMi7
         GDgJ2MbBe0ZdugAwnBSz/1pRpvMKjSn2Lt5vfulEWglBKwfkIGcj81I0FExpHy4QrNaM
         xDpQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3GVZy4icW9GHyzI4mwmPhjmtli9SMWVWsrJaooW00FyhR3a+Ghk6E9EyQJqUnvzsp63qO6uI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG/XgGrRr23qhlJxFl/+gwO0yCrIPZaEICvajRQc8wbxwvbLlV
	4S1vEww6jjmg4PyfAuHGW1hVhs4VlDW/4dB2n4gyEQOtDq2QL01uNJrP
X-Gm-Gg: ASbGnctmFDq6b7TdoTn52GIyuJ9T9vedkU6daJtGrTMbAMqJC6/JmN8m+Ua0U9ZuSgY
	d6ZOOEhuKtsIU6Sxn/FTWsXeBWPctQd/zeMW/snX/kaiM7gOtaB2vALhcwUcJDokBXUE7M5nK0N
	sguiNUz63UP7xjKWNq3rjjD7SNhetruc5uRV/j8oTy0lbJ1xEJ9/R5qWQnKVgmQw4HpoPdD9Zzu
	NXT/SwJk402ScjO6M3K+zdmGqIeAccA9DJYCl803twgbrwUtqAbtZRy9l9xu9w8ymfWF8uCrA/W
	uBQpI47FpBPmBKVKwKK16/NfVTKhR+/ImOiu+3Z/8j9sjdFj11ycEWo7XwD36zCTvHLHlGQ6906
	r45Vp0+WBNgrBUSyyIaLYkQ3aZtnaDO12MutgjCfe5ZiCzQ3rIa0qKnhjHK65LZzqa7fZCgw8f2
	xIsF8v5U2fzsb3rvNMyt18I8I55zX2psy6sVrn
X-Google-Smtp-Source: AGHT+IEKHk9Tj7gTL2kHv59PTJwI76uKFohRHRAHgq2x+6XnRzw5DJhCwK1ZxK0k8M71IYtw6Ct0pQ==
X-Received: by 2002:a05:690c:3604:b0:780:ff22:5b1e with SMTP id 00721157ae682-7861904ca66mr49752757b3.14.1761686083091;
        Tue, 28 Oct 2025 14:14:43 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:5d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed17a1e7sm31020997b3.12.2025.10.28.14.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 14:14:42 -0700 (PDT)
Date: Tue, 28 Oct 2025 14:14:41 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v5 4/4] net: add per-netns sysctl for devmem
 autorelease
Message-ID: <aQEyQVyRIchjkfFd@devvm11784.nha0.facebook.com>
References: <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-0-47cb85f5259e@meta.com>
 <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-4-47cb85f5259e@meta.com>
 <CAHS8izP2KbEABi4P=1cTr+DGktfPWHTWhhxJ2ErOrRW_CATzEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izP2KbEABi4P=1cTr+DGktfPWHTWhhxJ2ErOrRW_CATzEA@mail.gmail.com>

On Mon, Oct 27, 2025 at 06:22:16PM -0700, Mina Almasry wrote:
> On Thu, Oct 23, 2025 at 2:00 PM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:

[...]

> > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > index 8f3199fe0f7b..9cd6d93676f9 100644
> > --- a/net/core/devmem.c
> > +++ b/net/core/devmem.c
> > @@ -331,7 +331,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
> >                 goto err_free_chunks;
> >
> >         list_add(&binding->list, &priv->bindings);
> > -       binding->autorelease = true;
> > +       binding->autorelease = dev_net(dev)->core.sysctl_devmem_autorelease;
> >
> 
> Do you need to READ_ONCE this and WRITE_ONCE the write site? Or is
> that silly for a u8? Maybe better be safe.

Probably worth it to be safe.
> 
> Could we not make this an optional netlink argument? I thought that
> was a bit nicer than a sysctl.
> 
> Needs a doc update.
> 
> 
> -- Thanks, Mina

Sounds good, I'll change to nl for the next rev. Thanks for the review!

Best,
Bobby

