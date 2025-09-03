Return-Path: <netdev+bounces-219662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A2FB428A8
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 20:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B10177AD7
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 18:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BDD2F3619;
	Wed,  3 Sep 2025 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MsQCF7J6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF657080D
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 18:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756924110; cv=none; b=Vb82tfaNatQOG5QCSMUiB2ACeLC67XItqyZUCyd13a7mbePuJfkhZINI3/bRW1eZjHkSSCn98b+LCL4KGpuBJZsH6EDcXzKwqgRjfOSsPoKaJY94aBZyBkcmWxrzzqI9teloODuW8xav4wp3n+AtD4iO1ESCyzRTA6crN9d5XzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756924110; c=relaxed/simple;
	bh=Wo3XnVcy4QUNUU12VskKQY/46lTDB1b0h5MjRpeDXyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IrHBZfJeeE44E81DAoHjZTlnkBpnaCY2SGbRjITKLproR8Eq4PIELdL9KuIPKCzkzS7nhT/1le1bUmU3JoQu5GnpQwdI0CT9rdMeL4mq1mbZSrduT86LCT8lxR+BJx+HLriEb0Fe5sOor1LeVpr+JomR22FzOyAoMRM6lfxvYXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MsQCF7J6; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24879ed7c17so2015825ad.1
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 11:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756924107; x=1757528907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wo3XnVcy4QUNUU12VskKQY/46lTDB1b0h5MjRpeDXyg=;
        b=MsQCF7J69qS4aChVVjR9w9wpQaiEkZ1tfXfuVt2ArmCFzyYSRzzYS9wVJd6ApsZgYi
         zseTVAr/l8fShBBwLh/eok0r7LNfF120uMWZbtEUjtNTS0zcZTKY6aERGUpYwOAATVfU
         2Pcn6WdJH0789HSjvCf91lolMUHRTWU5b6rbBMeV5NjnA+Nce8ouJgjfTCkKpQwXyUVD
         NOkTSIlQsKH28wtuzKwp1/au4XZsDwEGH2ooVk2qyVufRO6c4l1ufucjTKYbRSWRqAwC
         6ii0gMvguQCJa4ofcfCuSADFFizFFDen4T+1HVxDGIgplmk1tFZ1iNqtQ/J07LBL44/2
         esvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756924107; x=1757528907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wo3XnVcy4QUNUU12VskKQY/46lTDB1b0h5MjRpeDXyg=;
        b=oTFHAEbiUX9FpK9fHxFmBLJ5ATTgHjxBORPLGRs9p11LoZpR0n1tugk+AysZNdu7DH
         g781sORVFL4fxksf0Uo7Rf3CvIvA0r0DPSInfMY3quKwTkOjP5Hfx1+5BeQWMzNWtRsy
         Oez3h4l9389Tikr/N0jKPO5emqbLaP3uTe8BTEC7wRz89KEF9Y4s70d4cME/zqYvV5ex
         Hd1jPv/LqD1qHkZTxoG/ZzmgUJ+02m0py3geXwAu5YO9Z+6MZDgiNGfKgHj1GL5uKOSu
         4OnRr5u9lgUMga/gQMxtLBpItu5KSpX6F5MAtU+4sUdGtZ/XZz/I3hAwc3o7UScmu8pz
         AA3w==
X-Forwarded-Encrypted: i=1; AJvYcCWTP/2ZCvsqQoLCInkNFqhvXp2Zb0WGBbT9lR6j6bCv7Ybo0q8E+9yHlBVRww7AcF3CU5oSwpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHraMey9W7AcxBN0UDCs4Kqg84Y9V7CUcTvAsDkjw9n4XmlAj5
	WbdNerJqZUOKZoPF1mU5DDlveQDHkb01guD9zoPpbQXvE0rLUHjSQL7qKqe3rye1meNC0JWcc6U
	E119C6Uxk9xXF/x7bFyhe+OIBcsP1N44JY4MW6MuG
X-Gm-Gg: ASbGncsPewY+lkJPfUjMUHRZfAmlltTCcivWvQv2ILbRgh7PEu7fJ0EVZ/yHmNStNl/
	GM8A377klcKpmXu5ECR7Ya+ZOUdLqnWm395+OD+LjPKBbwHZ3BqQ9wUB/0k2O14/tQ5e/ONOISw
	ZO1m0poY/MFhz/A3z1e+PX9qqRiFaEaJ/y6Pxwn2NSrBiBnRSbCi2UtF2+0PHsqXhrvCZ+d7+K0
	4dm1tpuErRDXX1E6YsXQ9QD9FJIqW+XZqSi9QtOJQwWwN3M9+IW8fFlPoPzhVOXbiw05YmDhgVL
	9MoKqHX5Sxo=
X-Google-Smtp-Source: AGHT+IE64xDc9Rv9+w2VVQT2Q6tqPac14JUCLERGYbX3X0VlG+88S8aAuOtNWEO9FCaR8DEawtu4o3XwVG5tzPZ/CG0=
X-Received: by 2002:a17:902:ce03:b0:248:cd0b:3454 with SMTP id
 d9443c01a7336-24944873445mr183019545ad.9.1756924106787; Wed, 03 Sep 2025
 11:28:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903084720.1168904-1-edumazet@google.com> <20250903084720.1168904-2-edumazet@google.com>
 <CADVnQykr+OfAHHV_qdPwhYM2psAtRpdKn8cD6=aR1Pz+rZuyhQ@mail.gmail.com>
In-Reply-To: <CADVnQykr+OfAHHV_qdPwhYM2psAtRpdKn8cD6=aR1Pz+rZuyhQ@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 3 Sep 2025 11:28:15 -0700
X-Gm-Features: Ac12FXzJqPX1oV93ZNoIgDlDTNB5-twKP2BYQNLYdKLLXST8hegwfY7zHeJLWIE
Message-ID: <CAAVpQUDM_PQcjtcVKJdb_JbXdaxpCgH=JUWES9k_J9tA07td5w@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] tcp: fix __tcp_close() to only send RST when required
To: Neal Cardwell <ncardwell@google.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 8:07=E2=80=AFAM Neal Cardwell <ncardwell@google.com>=
 wrote:
>
> On Wed, Sep 3, 2025 at 4:47=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > If the receive queue contains payload that was already
> > received, __tcp_close() can send an unexpected RST.
> >
> > Refine the code to take tp->copied_seq into account,
> > as we already do in tcp recvmsg().
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
>
> Reviewed-by: Neal Cardwell <ncardwell@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

