Return-Path: <netdev+bounces-216562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AE5B34878
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 19:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FEC81A80D7A
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 17:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F24257842;
	Mon, 25 Aug 2025 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cyu8u3/0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A684A08
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 17:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756142458; cv=none; b=mATqI4znsr+YcEIFLl6+M1IFzSjtzIBA6aCoHjUAC5FQ+0EJa8Fu/mwzjMoqsoAX/itUGRhvbbHqEI5Hs8prJ0yh5M45WLtcwuyymvxfEjMS+qrWABANIsA42nWaYItx7U5URIzvMZh/OerafaN8YsosbfQO7rRPgWyHBIX2IuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756142458; c=relaxed/simple;
	bh=+YLuARRxJ0sICjzV/Stw27iqnBZ/3jD73/+MLpd7dfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cb9HhIiWbUqH7KZjULVgQT9vzMt/OcJKgQwBaMVBjUgJYy98fqGDL2q+q2iK8+JTvtdM89FMRKt7SA0HXfW6fPoeEr54LtSFLVm5iKTUxOCWRpjCUi/8stwOFH5JEVDUUtByAw3XW0c+A9DVteciptGkOt4z1zRE3w6wITUBhCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cyu8u3/0; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24611734e18so10535ad.1
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 10:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756142456; x=1756747256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YLuARRxJ0sICjzV/Stw27iqnBZ/3jD73/+MLpd7dfM=;
        b=Cyu8u3/0bgDh4R3OwdxVsNU+SbAYTa71xa87J1VgfLUwAZARgPrz+F/r7T+0eOHwYY
         qZevB5Ju7+uIW5eta0vbyAt2iWkNWuDjRyjXQbJvN7hNvLEiqe+lwnWGXacqR8+oe3Ex
         xpBzCHdJFgYAhtZmERFvtwbsWb2r+X43JJQEFLjpKilHRbsYWN2ZMMIIRtZCBWZ0tliP
         8R/3Twa6UnAii6Hrsnw4l2UQQZKxmr51w3l68ou+Jb52Z2EpwViTah96diRnH1DMOKfK
         lJadPRxR/2XgaosLGGsocCO5liMCehZfRK3QV/FU5/oUBlOmA4K88sbvTAeAUZsaD8+U
         HMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756142456; x=1756747256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+YLuARRxJ0sICjzV/Stw27iqnBZ/3jD73/+MLpd7dfM=;
        b=K6BUiXC62OC0/4kTXFZqIJIoXpFfJBzwt8mVIwdDn1ZI832vaFvipRSYrpy9leD5/c
         0w88D+nru5VBPGU6kGldwf46I/HgubAiQ7Yw4teadL6HpBpS0W0IIv9oHJmle2HXNYbm
         BBekIDmrwXnK/OIxJ4zT+O5tY629EBd9g/j06MBmnmXTL/oGldJxfXKihNlxETI+26G4
         +uS+ULXAcsWYh1CMFrfqMjnjhF9nBVFahR9PGbF7DZPJZzCpfjUKn5f0O9uWrzyXd1LG
         0mwbxYIlx2D/jFUBaYA4dw7DPIQn2zM0GEjo2eVrXtjyhV/2UjsJbML81BESB/JIxQvo
         e9nw==
X-Forwarded-Encrypted: i=1; AJvYcCVVR4Pho5a7gXEiOx9mByAc75HnL1bu7yBLMV9JbqCCHNbszm+nHTx6I/JHhz/wnVio0rVn2xY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU0npzJkQ+KEq4ubQhMRyBWGD3L5PebD5EIFkG6t/z34ualWwV
	SDCmVTZd5uymIfUhvkSP2PTZ8MzA9F8Aw/XB91jnpsVqqEx/fnz8bSrKyhFrwVVVJKXsvefnI/w
	YXUF8zVyhQf2UEixyPoorTC4gVmllxto7KHxev4Q6
X-Gm-Gg: ASbGncsvubVCCwCsFyGR8Q5vLatATsfzX5vh5QxLXkGeH0WNCS6PXGSCYg6HGZUmVtn
	kk+6sjTF3VDd+zLw1KG7sGh6MlLjFYdLzeJ4A3lqMO1+7u2zXXADtlKOZDORH1vZc+oEwjOWavo
	FRTCjWhsEEVT+Eg2/ng9PwL2dYLVZyW2jNX1wq3Sp9YjAeiU9kQp80XqJcaOkYbmtu/pbhl693Q
	VAr4W8kg0SvZZ1mEZfsKV/HuO1QVcPp5FD11N/6b9gV
X-Google-Smtp-Source: AGHT+IGxkubtxWwYr3Qb13ue2wJfdgQOjrj7USvzs84L4ZSAzN1ND9/mpeoWYST9ZBgr0olwe9Bc5QQgVe6t1Ablr1k=
X-Received: by 2002:a17:902:e810:b0:234:bfa1:da3e with SMTP id
 d9443c01a7336-2467a3a8ee7mr6338755ad.5.1756142455581; Mon, 25 Aug 2025
 10:20:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824215418.257588-1-skhawaja@google.com> <20250824215418.257588-3-skhawaja@google.com>
 <20250825093031.67adf328@kernel.org>
In-Reply-To: <20250825093031.67adf328@kernel.org>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Mon, 25 Aug 2025 10:20:43 -0700
X-Gm-Features: Ac12FXyXP_49N_y9l7cu55vdaRKe90qUasBRbZb9LSHcLleq2tXizADigd-7MX8
Message-ID: <CAAywjhTeODwaTG1TOqiw9q-SoN9JzxMxqvGmmpjkxyTR0BOJYQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 2/2] selftests: Add napi threaded busy poll
 test in `busy_poller`
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, willemb@google.com, 
	mkarsten@uwaterloo.ca, Joe Damato <joe@dama.to>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 9:30=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun, 24 Aug 2025 21:54:18 +0000 Samiullah Khawaja wrote:
> > +static enum netdev_napi_threaded cfg_napi_threaded_poll =3D NETDEV_NAP=
I_THREADED_DISABLE;
>
> This doesn't build:
>
> DISABLE*D*
Yikes. Sorry let me fix that.

