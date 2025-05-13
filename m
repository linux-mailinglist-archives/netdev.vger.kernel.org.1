Return-Path: <netdev+bounces-189969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7A9AB4A1B
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 05:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D90FA463FDA
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 03:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844511AB6D4;
	Tue, 13 May 2025 03:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFZxbPIc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C560F44C63
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 03:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747106707; cv=none; b=QqhzOF49M/BTwTkK1tqx6NGILl1QwUOshjelnUwEVTjhMuwx+qW2UWNIEa/ySPSbGD5EY52F5NW4I+kJGdty9mUlPlmLhKO5fJBr+XVSgq3JHxZU/Ugc7TZx08L+GQRq7eMdWnQPxui/6xgpchEP/kX+Uhx3/oW4uz1zL+cPV1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747106707; c=relaxed/simple;
	bh=DmoxqvxgoecErG1YUzFn+KEzYa61G9VBt3UHUK8AavY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NU/oYKKjqzd4fzfi6jO+ODFVHXYusTqGKNoJ9GFINsposiwHgyF77tYKTD8z5rAmcDL8so4liMBfentJLDEyN71j7sHfVOcSNRHMSOdICcxyRzb0FYrkPnVdZuvhbDhB59EIkhxiMl5syMNHJuN7jG3/o+0ZF0xks/9Pj6h3c3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFZxbPIc; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad21a5466f6so721328966b.1
        for <netdev@vger.kernel.org>; Mon, 12 May 2025 20:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747106704; x=1747711504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfesM74XxRY6OOy7SC9TyQ+kyNdpcMYMFbA9gW8j8BM=;
        b=LFZxbPIcq8XESzAwklwtHYG486r4jsxY9wTmU8A8zAlqvAeMJkLoOUdwG3InRdOALR
         SS8tQDiyBtDIBBkLlzS8tcdsqwQpWjACVR9sy3PC5rhXvtVI33taz7y9HT2nX0gcqIJg
         UJNSkaNJ2z8HsYkCSI44CMnJggLzNwnvenOCt4t66bLLt/zfB+bu25/+bFXCf6mDiUKR
         /GcyrpHftL00dgKMQTYBuPrAC/oAheamHtIfNn4iUUx28jIlhC6YzWD2OyqbeJfxOitv
         iSyd62+e6jx6vmI3LAtyS1QSDVJYZ+WHEWHr5EwHEDn+La0TmMEwrxcBHmguL4s0So51
         U5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747106704; x=1747711504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfesM74XxRY6OOy7SC9TyQ+kyNdpcMYMFbA9gW8j8BM=;
        b=WdHlhpDkuJ7k9IZfYyVjT3E9I7Hu1Xf+mB6RQh+HfCesPaNI0unC7sOzm9OlSrJsMv
         CDupG0euefIYjjc6Nw3/v5xKxXGr3XTJ5wGbzjR8V9hDbeH+3RQ9oOrUVx0mxs1JfmS0
         p2AFYhXgSWZnOnkBeygOS4YeJVzFfF/zimGMbdzWUcqHDP1JzW3fJMMYenG8/3h/xP3r
         8MxxHKIVj3jfbYLKiHWcxy3dt1rVte0QD9Gl0SCWruKnb40NO8EfzS+KVkAswzOCE1w7
         BmdUkB3kgoKCt++3/fbBgmRrOXdpY53WYF3lntLR+Bx2FE35LwqG3J00UHq9JhLak6oc
         dypA==
X-Forwarded-Encrypted: i=1; AJvYcCUfWCdJU6sBax2xwFZ2KSmnOErJf+mXG98sUWTg/iCSJedJQKM1Yk6FRe/cTSDYqKIVpHrArms=@vger.kernel.org
X-Gm-Message-State: AOJu0YxogAO9hgTziAyWIMp2Zr/mTvGCFrbUguu4FLWjszMyK24APwd1
	4APmQ0QKVhfgwjaEHswAdtTSBEmFxn+R8xjypq9OGMvzSXQLLGuCho1HOhsJjG6Hb7jm5Gz8wFo
	TAnFdCqAj1CaUD4rtnNnurO3nFwU=
X-Gm-Gg: ASbGncuKaGzHOgtK7MYXTirmP+TRByaLaua7jxrZ4iN9mnRV7IpGouFBmBJpiBfcdsx
	4O+89RXFgAW8ewTFLj/FE9RJaQoY3zl5Hq0mO1oADZ8wji1phXqpnYMKQDVd1k/aPNT5YZHAFiQ
	ba3cL6aRrxXMUQh92/3JGzzw91BZ26rrZ+L70=
X-Google-Smtp-Source: AGHT+IGEAI/0PVrQaF2NbVg/Jjqb4Eq4mUGI9gKi62F39tW2HdHTWwn6PeBLDNtsFXLo8AEIcis72qvWni/GEwlJ9Dg=
X-Received: by 2002:a17:907:da15:b0:abf:48df:bf07 with SMTP id
 a640c23a62f3a-ad4d4e212f9mr182076866b.15.1747106703426; Mon, 12 May 2025
 20:25:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512084059.711037-1-ap420073@gmail.com> <20250512174442.28e6f7f6@kernel.org>
In-Reply-To: <20250512174442.28e6f7f6@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Tue, 13 May 2025 12:24:52 +0900
X-Gm-Features: AX0GCFvcbci7GDRz_QA20uk95NOxCasA-jYl6NQmiv2HVSrJabmEYVSLR40aS5Y
Message-ID: <CAMArcTXOS4z6v5c2JCdAVg0RKjnoovrftx=cjt-09RXp29NW3Q@mail.gmail.com>
Subject: Re: [PATCH net v4] net: devmem: fix kernel panic when netlink socket
 close after module unload
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	horms@kernel.org, almasrymina@google.com, sdf@fomichev.me, 
	netdev@vger.kernel.org, asml.silence@gmail.com, dw@davidwei.uk, 
	skhawaja@google.com, kaiyuanz@google.com, jdamato@fastly.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 9:44=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>

Hi Jakub,
Thanks a lot for the review :)

> On Mon, 12 May 2025 08:40:59 +0000 Taehee Yoo wrote:
> > @@ -943,8 +943,6 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, str=
uct genl_info *info)
> >                       goto err_unbind;
> >       }
> >
> > -     list_add(&binding->list, &priv->bindings);
>
> Please leave this list_add() where it was.

list_add() is moved to net_devmem_bind_dmabuf() by this patch.
So, you mean that let's make net_devmem_{bind | unbind}_dmabuf()
don't handle list themself like the v3 patch, right?
There is no problem, I will change it!

Thanks a lot!
Taehee Yoo

> --
> pw-bot: cr

