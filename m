Return-Path: <netdev+bounces-175339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C72A1A6548A
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 15:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19B631712FD
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 14:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8468024502C;
	Mon, 17 Mar 2025 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iu84BG++"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4348245029
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742223350; cv=none; b=FXTHpMQw123IRQyBb9bhIoOXeYNfY39deWQv+5oXL1ZefePeusIIU33vo0fT5Qeq610TVXEdE1QyavBUNPasCyD1+1Ngsh7Ea8qnNn59jgT/YdgxBSutS0aWjvLQRXc5ax4DhZXsaWx+KsnSSc9Ph9mPEGqOnhiEvttLpEYchzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742223350; c=relaxed/simple;
	bh=FZTkgf1c+uN0fgRXo40MjJgs89CMBtqYq/rqAicbmUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T6vxemMTOgtUMa4L4EpySMOXEHCrvMWMMYqFwYanGBpi+wkNE5HKOmgPSWsQEhsaXUinVPIWZJVNNj/uCq2mcvl8xkKLpi/489B9VsftguGI2ZKi+O4ATfGvm8ofBsHvc5HzBIL3fjN6Cd+Hn7thCzyKh+IwqUKDhxOOy2uf1Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iu84BG++; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4769e30af66so37431cf.1
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 07:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742223347; x=1742828147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZTkgf1c+uN0fgRXo40MjJgs89CMBtqYq/rqAicbmUs=;
        b=iu84BG++43/1pJTjvCWomdRS1gpPIuUAaTPJ1WnR1wiS7+c3raOwV/GI5xGXxhW6yV
         IHVvcvE+AWN2jXOFVk6tvJxKw/jPEDq7LeAXhr8kFhhCXcXx9gpJuA8boQQgPJ4acZic
         o4+go/9WzN6VVH8g4U74x/ggiezX/XWzih+/4b++QASQ7XZe5zpO/2CkQIBokSl3YGIZ
         JmGoyeNY4OoKFw7C0uMGuiNA25kotChHuLKQ74E3pIFjfSVT2mwfHGg1dNn+sc/kdE+m
         osbC85HXRwQOZ8P+T95r4Q/T4TXfzwQL39mMjWMFNS41iC73EeJWpRujf19Gg0gvH7c3
         KTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742223348; x=1742828148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZTkgf1c+uN0fgRXo40MjJgs89CMBtqYq/rqAicbmUs=;
        b=puEx9JcU6hhGTVuC1UfTRV8IiLvhLdOktXaD3CoF0K/wDeUn/pkF2kMXHnhdqyPatg
         EN4zF5drohy9yA3ak1EIWsZC+rEqmEhxztSJgrYskNX56TFHIXZKWTWce0CzA7rwueEC
         XpHzpklHydu0t61Nzfam/O0lbFpsQaIeeoZw3KkEMHJqioLB4k0Wfnp4CF1wSg3ckgpC
         PCuO22nIGLDfuQ6wwsfqCtsyO7xAHGHBoK53S4WWqpcg4XVQUsituPaTkPdzrGBBfCaS
         dUznMSAI44tdJMdEhAzcmCRLjKiX8V2TP7YxMk2brcMx90esFnYVVsfG4ZOjgSpgAiL9
         VaZA==
X-Forwarded-Encrypted: i=1; AJvYcCUpXAfjyC0a5pKp7D9dhLJgStMf/1DBnrnn0gfjR74TKobCkxuagitMrkQKKFg5MS3bPgnqNhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSaQn9yc7+17Vd/CdYpXOAIWlUKzZEtwHAVpfElIS+NPLcOqmE
	ncdd4gRo+H7H6XVQVEBhvLdygq3Ga8kvb5iB7dwG/S/peppZchNnE/kd1sBKheD+PwudijwghhB
	duU2H5Az/1yGqY2n4K8SuNwMBHzHe26EXiZZ1
X-Gm-Gg: ASbGncuCRahiJua1Kr4xKOohKOgFdRLFaPlAWkemvIsNGdaqGS2/PR2D4rTB8IEt6qR
	QHPfGkyYt5FSwXLFp4FT5FrkYocGsv6PRh87lkO1xEPhSzWgaeZ8JhGG/BRp5hP3cKPwzIiGzuC
	/lCymQjyjFIoyf1N7Dcm5e57PJhcCGY1DM1XCgrJ+5srtt7eJN6B1pedBIz9w=
X-Google-Smtp-Source: AGHT+IH1Ts8KEZdDe9owqylclQ5KXinKsdNQ0MYCDl85GwqzsRm9f9g2dMnEzjS+vyrr+RSbIsI4+j0U6hi3xf7wVHs=
X-Received: by 2002:a05:622a:8c8:b0:476:f4e9:314e with SMTP id
 d75a77b69052e-476f4e9343fmr2248741cf.25.1742223347459; Mon, 17 Mar 2025
 07:55:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317085313.2023214-1-edumazet@google.com>
In-Reply-To: <20250317085313.2023214-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 17 Mar 2025 10:55:31 -0400
X-Gm-Features: AQ5f1JqYn9r0dbQvJ7Qxx4ZGYuhSFkXe9jx_OlnQN8TRq10yBTJqAJ5HWpBrF1s
Message-ID: <CADVnQynTumXjmCWyHY25+WF=B+-qwMH_TS_MSJOrD=txE5OdzQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: move icsk_clean_acked to a better location
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 4:53=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> As a followup of my presentation in Zagreb for netdev 0x19:
>
> icsk_clean_acked is only used by TCP when/if CONFIG_TLS_DEVICE
> is enabled from tcp_ack().
>
> Rename it to tcp_clean_acked, move it to tcp_sock structure
> in the tcp_sock_read_rx for better cache locality in TCP
> fast path.
>
> Define this field only when CONFIG_TLS_DEVICE is enabled
> saving 8 bytes on configs not using it.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

Very nice! Thanks, Eric!

For clarity for readers, at some point I wonder if we might want to
rename clean_acked_data_enable() and clean_acked_data_disable() to
have a tcp_ prefix in their names, since those functions are only
used/declared/defined in a TCP context.

Reviewed-by: Neal Cardwell <ncardwell@google.com>

neal

