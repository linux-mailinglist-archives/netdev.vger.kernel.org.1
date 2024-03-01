Return-Path: <netdev+bounces-76463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C47386DD2E
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 09:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 086312827E5
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 08:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4426997D;
	Fri,  1 Mar 2024 08:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gfhVj8wM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C142A405C6
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 08:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709282170; cv=none; b=cSyt/hzcp0aRbBZkxJtWR2PS6AVHqwnXl2UTyYrhKT3yUr4n6CJccZrnu2b+8DDaXG7+cKVwRW6oOrih3IQn86AMaFz/CZt+f1xEUkghAtCLc4mU5coMKnYY38YSJJThIx2aOlcCCYx8mRJz7+NZysfA3BGkAdvQnRZ+9b8ZMow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709282170; c=relaxed/simple;
	bh=qQVshxg5x3bcG8coBOhguU/koKxhWB7RQKHSNBk0nMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VBL7WxMN38woX+61I24sLW0TQLdrYVTKWO4GpTFxLW1yUDKh2lblxYajt3v+6dmrGayejfUo+BOz/rDk2WfZ0y7EBfxN8i2vxIZ88UUkb39dVQjIEHyz0eu18iPlPnQMoc9MkSoXZw3O3kaNuxbuEAa70V5+C53zuAC9vQWYtyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gfhVj8wM; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-566b160f6eeso4796a12.1
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 00:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709282167; x=1709886967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQVshxg5x3bcG8coBOhguU/koKxhWB7RQKHSNBk0nMA=;
        b=gfhVj8wMvSxJfpvX+jb4ZrPGc/yxHWp/mrTIyq+tqIayiHWyb3Ec2y8BKRE5mJjyUy
         Zt0LUXDWR4H7Zs8V2M9SyNX/jgleXLioryGmrYPD9tFRdaRUxjuldIWG+EZKz1YK0vE7
         beH6QLagLAvukXzN1Nqj6iQqTNLzgc/nTF18eyba9RMOGMAKWSg49P0/W4H/zCm/He/4
         6yixRXCG235NaZ1fPOJCMLPdd6WAC2H80tUB+CljNdqWz4OpAophEh7iNBtqUIXK5UQL
         k6jBAlDdPH+y6sAuk/ANH31FsknpCKsm8URey0ngHp5jtWQ5IJD3yiJo4sMIP37XHtIf
         lp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709282167; x=1709886967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQVshxg5x3bcG8coBOhguU/koKxhWB7RQKHSNBk0nMA=;
        b=WGOmJHuHReuFr6YHglbFoZcOqngVTpliFAnBqh2YmEfy9Aiwyl3ly8ujTh9zzSxyqm
         bqOPUjAVtzOXf5wjTSstG/ySEi5E1D4jvdnaxmRylPygZMztOQbM3d4QuuG1FfdehGz7
         ToUneDS+e1IF/mfq73EYN9NpGojJtcy3f60Hp4YJRgAjvYV0JHGM8b/lqsHeEEQs6583
         N1B0PvBGepTKTPLBpsFHbeRAQQ8/sr1Qq4wy/q2H9L/Cnt1swoWOXZ0iw/WS1rAi6ifI
         rfTzPAs1jP1bQJeH/WHNVCxbYps+Ytq46v00RoGd6sGcO+Imw4n9pIQjBeoVV1HUE4D0
         JZXg==
X-Forwarded-Encrypted: i=1; AJvYcCVYdRa2Y/wYp/Wy6B3EcMM/oLr4FF83l5CYoaWFixYDt/ubewblsXgZyrpPoAuA5ixntupv0DF+x2f8dUMw8lMc8moWocUF
X-Gm-Message-State: AOJu0Yzma/ndy21lsTDrsv+yLEzQMx0Q2GuIHA2/7ZjopyNnEpuKirmA
	AGhFZne6Ra0jj0LF40Gqp08eki7dWPHhnnV4tp7D73diW7oIGAyLjSxcmZJ2FxBpqFBR9719DJw
	gn6GhLhgKxyiwHPIxLam/ltQfP4mZhNFMC18J
X-Google-Smtp-Source: AGHT+IFRAALkWy//qBAgBDMkisTS+xrphXhRA71nEzaStdhA+g/zub4B6y4BUXiv6mFn84SHQW5qRNofsWxqJ8Ercq4=
X-Received: by 2002:a05:6402:291:b0:566:b5f5:48cc with SMTP id
 l17-20020a056402029100b00566b5f548ccmr55860edv.5.1709282166942; Fri, 01 Mar
 2024 00:36:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301012845.2951053-1-kuba@kernel.org> <20240301012845.2951053-2-kuba@kernel.org>
In-Reply-To: <20240301012845.2951053-2-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 1 Mar 2024 09:35:52 +0100
Message-ID: <CANn89iKYHMpeWh7+rf-UcJeMRcRvOMSc_SnHaqa0Yhkh=OZexw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] netlink: handle EMSGSIZE errors in the core
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	johannes@sipsolutions.net, fw@strlen.de, pablo@netfilter.org, 
	idosch@nvidia.com, jiri@resnulli.us, kuniyu@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 2:31=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Eric points out that our current suggested way of handling
> EMSGSIZE errors ((err =3D=3D -EMSGSIZE) ? skb->len : err) will
> break if we didn't fit even a single object into the buffer
> provided by the user. This should not happen for well behaved
> applications, but we can fix that, and free netlink families
> from dealing with that completely by moving error handling
> into the core.
>
> Let's assume from now on that all EMSGSIZE errors in dumps are
> because we run out of skb space. Families can now propagate
> the error nla_put_*() etc generated and not worry about any
> return value magic. If some family really wants to send EMSGSIZE
> to user space, assuming it generates the same error on the next
> dump iteration the skb->len should be 0, and user space should
> still see the EMSGSIZE.
>
> This should simplify families and prevent mistakes in return
> values which lead to DONE being forced into a separate recv()
> call as discovered by Ido some time ago.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

