Return-Path: <netdev+bounces-173244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5C0A582C5
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 10:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19F521885B4A
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 09:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742D0199239;
	Sun,  9 Mar 2025 09:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VZIv+Jg0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3915187553
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 09:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741513367; cv=none; b=p8zW/uxx+dQBKFjWFqXrmRCAHE4FE6eN9ueE8VIX7U8elt8ndbvKENc0A+A9Q3w5a68FOSiDaZnnG7+0V+TMWWyy4tLSAYT6CXmwPcU0I4d3yo7nakhMOYkW0uadTnRvww3qUwN0Jk033rDre2+iy/g91QTrKFzDswTLcsMZ9wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741513367; c=relaxed/simple;
	bh=MlMy5zT6A5ubH/tW4tbKzbhK+2IqUIPwv9NLGev7gW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YQ/oADpGFr14wghBvq8HGIQUnpiFLo/zflzjywRvCInXAC8vZMimAbDugNToe8Vvd7qBX/3IMoK/iGZRqQyS2qL9g32Vp/FSiFkYBkET3airDJwR7YY/N5whCPoN6HhcPZVugEz+UwIF5bHx27TUMTWnu4eMo31/oAZbnweIwIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VZIv+Jg0; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-475076bf02eso42873301cf.3
        for <netdev@vger.kernel.org>; Sun, 09 Mar 2025 01:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741513365; x=1742118165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlMy5zT6A5ubH/tW4tbKzbhK+2IqUIPwv9NLGev7gW0=;
        b=VZIv+Jg0pJNxboRp4+F8HFjcuxCSJrGFGIIu5JaiaHoIlyNN6Lixur6OHtnX9FlRv8
         DN2cqtMvbREKBdVB9lS/NJqMAxeVANT53GWJbAfRigPEfH74ojRJfPKRNDy0q+7iLD7f
         FpVkAePzMtxZvlPY692SfEDjdTqGEcrx/vP/HyAxuxrTkKo7F/lCYVWEaoRJkUYUkEO4
         X2jOASXzRpfCIsOCPqPZt/DIINcV2khhOSBGyxKkUUsCiOKxYY8mvsIGwe/9pFS8GiOl
         hzfZTykAlG1zSdC+dhpJ4OelpNpyXYSHC9y8eW3RgyDyQbj7VnP5DJomlmRvoCaWYQjM
         QaOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741513365; x=1742118165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MlMy5zT6A5ubH/tW4tbKzbhK+2IqUIPwv9NLGev7gW0=;
        b=ZBbUEP6TpLDH9l6Q9lCAsRZYJ6Lwx4zve1+MCuYeeGFcQMgccdQuFRJ1AAdCIaPrTO
         K9wbTPi2ldcUCqH4e3XSIqMmCP3mIgyq0LgM4Zt+7Jn+3HkhmUdF5aMXR4vfM+n3A6Tk
         fGTFijERrqhVLHTjQOMr4Las8WS8ESLIIgznHbp8OM+RwTQXKSlR3ifngb4aZEuy1UPz
         womlTf3gzqMcHj2oYFWMOXXyTx/nA9YziBqq1jZkHdAbUCJ/y4DFf9Ad6QPGBBGYOPOK
         cA+j1yKuyNkZwuIpqxDbaBGgQsolWQUEddul9Z4DGRux+X3/LRhuZOrvGMbR9kKY4nDU
         u6Ww==
X-Forwarded-Encrypted: i=1; AJvYcCWflrbtOFQHbMIEqyo5D9vxpx6EHRdYVz8Nt3PCgquGXSwpDifwE/tUmaTEOdlNTm8seZPqrTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOULuUqGIS4qkV9UcIfCvWP7hW/pBsZKdw45atyaAF+Ozut98H
	dU6iLJZFvK6216d2UQUT7mhw4Wx/ekuqtAu37AXskOZjri+Cc0OltsOb+C5PJRF3ep1XZh/Cx7+
	/wDhLWjTMvUBHkucidvCeT83p3/p/IUqpIFmF
X-Gm-Gg: ASbGncvIGdZhjHFaN9Z/w5vtiGBw++smVbWzr2ZgXnpeKcQFpikQ31h39PBTt8gaUAj
	uz6BXkHPsDSqX4QFnYSfvtEE1trxUkK6e/Nu81yYUIDhW2rKCiQcfA6fKVtWNb90tTRDzJRjHrP
	K9r0YyAM/yOwqKf8FajClpK8qb
X-Google-Smtp-Source: AGHT+IHpGR/zHtFQRnFWd/DcCOHvf51yHPJJqCl+FyofiK1rgWSSglXNzodvh3RGFgURbAdmP60vnb6tkiThr+biOjs=
X-Received: by 2002:a05:622a:41ca:b0:476:6b20:2cef with SMTP id
 d75a77b69052e-4766b2040d0mr48556841cf.41.1741513364409; Sun, 09 Mar 2025
 01:42:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309093930.1359048-1-edumazet@google.com>
In-Reply-To: <20250309093930.1359048-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 9 Mar 2025 10:42:33 +0100
X-Gm-Features: AQ5f1JqKD_4eXx5q73juIao1dn-J4wPZWA9L4dHoxAeoMetz5ourfFEzH3XxiCM
Message-ID: <CANn89iJEYkroSipgVERCS575m17qEYGbpFgHw4OSinyc-8znUg@mail.gmail.com>
Subject: Re: [PATCH net] net: lapbether: use netdev_lockdep_set_classes() helper
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+377b71db585c9c705f8e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 10:39=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> drivers/net/wan/lapbether.c uses stacked devices.
> Like similar drivers, it must use netdev_lockdep_set_classes()
> to avoid LOCKDEP splats.
>
> This is similar to commit 9bfc9d65a1dc ("hamradio:
> use netdev_lockdep_set_classes() helper")
>
> Fixes: 7e4d784f5810 ("net: hold netdev instance lock during rtnetlink ope=
rations")
> Reported-by: syzbot+377b71db585c9c705f8e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/67cd611c.050a0220.14db68.0073.GAE@=
google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

This targets net-next tree.

