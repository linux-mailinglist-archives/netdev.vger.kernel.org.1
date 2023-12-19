Return-Path: <netdev+bounces-58964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24798818B45
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 16:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92371F22461
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 15:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F8E1C6B3;
	Tue, 19 Dec 2023 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2NPW/Oh/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F021CAA3
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 15:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso13124a12.1
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 07:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702999934; x=1703604734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHcGLTb7HoeHTmUASmtFZftDJToYaX4EH6cS/pr9TRw=;
        b=2NPW/Oh/C4EzGlccXKCPGbuHgOiQ6V1H6GrDu0Wq2v6DqsVVPqvNvet+OrLhfklvbq
         UjuuRfSvoiy809TyvNojnB6gLA96YQ938vplds8gKCVA+kcAp3J6PKZg73mJhsFV3sCV
         UWrSYicXyARQh+rlTNwO7P3DD5PKXa2UTedpBpmVAl9cpPCHnCM5DS4txHFMSypb13jU
         7vAG0Sh08Ip4bD4eVE181kFN7WkZ6/SxD1HEhhiWaiQoCsidogv0lj6qhxd08vfeuh1E
         00Oz7XvDsnjDj7/36uuyTK2qWIhgT8ERxeLJV5bgRSVxte9fQVnWpfnr0L/9HdvoSdkN
         krHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702999934; x=1703604734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jHcGLTb7HoeHTmUASmtFZftDJToYaX4EH6cS/pr9TRw=;
        b=L2kOOz51wH4zpduBm+AZLRZ9B6dPnjvWGcLaqZ4OLVvniJKunQrmRNsBTRUx8krBzE
         4kgXvF1gCQwDTChCUFSpak0iEpJqBV+RyxDyTYDQ6i2QzZhmBxuVnLx3LLZMnn15CbmN
         FmhC3OP9z47aos8z5WSQJSnCkFMG+cdxvSYzl0DCojuQAvT+tsNcu61u+7VK4cSP+TZL
         spOqeujMw60gCwOnqcoG6dCC3ZqItoqfRlptHHw7wZzQ8A2/SXgwxAd75ycSFILq/5Z3
         Zdq9Qblne1R1mOsX1nYk/ENZzxv2vLBVgei6iye+tdUovk6LMKfKxJQp+6dbadc5RD76
         JOew==
X-Gm-Message-State: AOJu0YytgY58uEY7/XdupraHoK6khNjL/W5tTKKKpuRVEeoqWYF3eHV9
	MasW6KjJzqHaClURqQ6N+VQ5XjoilEu8KWB4rHNwDPjJj1bn
X-Google-Smtp-Source: AGHT+IHhJhJKBjACyU8mD/M2popm2wYlZFsGtgFLMT5HrW4QiljDNKWAF+MHtHximBBlnXzNeKXWPROEzuuvXhK/KU8=
X-Received: by 2002:a50:8acf:0:b0:553:3864:53 with SMTP id k15-20020a508acf000000b0055338640053mr186822edk.0.1702999934354;
 Tue, 19 Dec 2023 07:32:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219001833.10122-1-kuniyu@amazon.com> <20231219001833.10122-10-kuniyu@amazon.com>
In-Reply-To: <20231219001833.10122-10-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 19 Dec 2023 16:32:03 +0100
Message-ID: <CANn89iJF14hHuhgfCqe+CkRZfdRSmaAa-_04eYdamBh59Eye1A@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 net-next 09/12] tcp: Check hlist_empty(&tb->bhash2)
 instead of hlist_empty(&tb->owners).
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 1:22=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> We use hlist_empty(&tb->owners) to check if the bhash bucket has a socket=
.
> We can check the child bhash2 buckets instead.
>
> For this to work, the bhash2 bucket must be freed before the bhash bucket=
.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

