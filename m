Return-Path: <netdev+bounces-133084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83419994792
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 13:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1061C22954
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 11:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1294F1C32EB;
	Tue,  8 Oct 2024 11:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xR4kWAEy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF0C17E46E
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728388026; cv=none; b=upGkz3zY3XgJfeJUYs8B/RIVz59Ox3wWQoNuZpiIjoMSAjaadON8hJNEjk0lkNqspGP9P41IXkGSVqa19ByNChZSXjOGzEEQI3r0/kOq47iUJWq6mKEtueJOPMfQgeK8Tv2nXxufOBwUjL7qbwIU0suDnCto00TI8z929ZtfceU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728388026; c=relaxed/simple;
	bh=8eBLVsF7+Qd4Em+92lzMOio71Jz+DnLv/+w9kHCnyMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=um0HWgQHS/Ur7Jqs/z4SrUB+FAkfYFWZ1cFp2vVvawJPRGM8hd5lzKWWMvYOquX05zlRFMetf6FVVhh0WqgVKD4L+Smdo3EzsMmLIRS/QiJRrgUXLQBArwwMZzvWmhybYjn9AH5QuGFumMUQ2b+FForNvIzUj+RQGtovINLT7Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xR4kWAEy; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c8967dd2c7so6882922a12.1
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 04:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728388022; x=1728992822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yn5bvQYXbahh0w5GMTaNY7/TGpX6grGsSZGo3CNlfBE=;
        b=xR4kWAEyEyy2+XImiT6EEaMtQwNTOoXtvx/0QREJ0pXtIF7fBJwIRU1NyScRY9dkpa
         jVIaFJJ7hPdud9ab65jBW/6Ir+y6NQ456k4q564yzn/zryWssFomF2DZVi26BB38zePR
         gqZP1QQlePsAbMGZBCfDcP+YXxKGr0jDi+Gg6V3UA6qwx5K5hVoMBjOUvd4h7GOP5Wxy
         4Cc6jWqv+7O9Fu4YR2lqsV+eyhNPq2WsXRFvXId5pf4cFQJHuxO1xv9P01iPKHXaWwOQ
         Ba8rrp15P+GxPf5KnP6pFXxJ2rRb4C86D1gHSwDEE0bK1StDbRQxVjZMmQQOhuVsClBM
         rgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728388022; x=1728992822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yn5bvQYXbahh0w5GMTaNY7/TGpX6grGsSZGo3CNlfBE=;
        b=cIQCzhIiXiUu8FQXecPqd4QefWiB36oE070E/srognxSWpnodV7VfyQBaQWjtZNkAr
         0rvL2dTYcGiC16A/NIqhs+baCb+seuK1yGs1yf67aVolCK4oAzmrL2ODqFnil17emR+g
         wGCJURC1my6HXeoUeHmp3x8CaoHtRgOjGIedV5GeH5e9KDkwpk2HuJGvMPlIIsJMCQnl
         Zm+RXlMM/AKbIsrmDDAnv/mrD8jmXq72MXOtZLB0Tm2+vYp84QrNOA2Au3JY3u9yJ2Vj
         gnZ3dcV/uALMp7k9RPyQxrp+4IRuFqypRQM5moxxGUXLf4uSA3ugNd5sqyipSJww4KbH
         3wbA==
X-Forwarded-Encrypted: i=1; AJvYcCWwQESV48SiCtXtRy97SxTGP8/CQNACx8TR3QH8g46XuOYN76T/ICPsz6uqtUHuOrvD0z4ALG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsvJPC9GtlkJhVqXrblqW+9HrMDEqA/OEWdw4cksiCZS2vrAfs
	PuIeGYuLCPAi5/LIOWq3WRMGd1P+NLdUuGJzKh33Wx0BccDjhKEbCSDIva71Zyel97CcDfSgZid
	4prc9Kosc6t/kqbyAYBMc46eThCHd4xG1TA5w
X-Google-Smtp-Source: AGHT+IFPp3s0/AADwLxt68BA1G/oYZCKr4rkZahFkqxz9X+HDwtkqKMUMFkKgtxKQnuP/Wij6rxItL3AwQoy/VRGPw8=
X-Received: by 2002:a17:907:94d2:b0:a99:76bc:db6c with SMTP id
 a640c23a62f3a-a9976bcddd2mr148398166b.52.1728388022306; Tue, 08 Oct 2024
 04:47:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004221031.77743-1-kuniyu@amazon.com> <20241004221031.77743-4-kuniyu@amazon.com>
 <9bb97d2c-878f-479a-b092-8e74893ebb2d@redhat.com>
In-Reply-To: <9bb97d2c-878f-479a-b092-8e74893ebb2d@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 8 Oct 2024 13:46:50 +0200
Message-ID: <CANn89iKcbZQhmTV2tbv-7u9WSg2rFkiMRWLieBz-a7c6xT1o5A@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 3/4] rtnetlink: Add assertion helpers for
 per-netns RTNL.
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 1:39=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> Hi,
>
> On 10/5/24 00:10, Kuniyuki Iwashima wrote:
> > Once an RTNL scope is converted with rtnl_net_lock(), we will replace
> > RTNL helper functions inside the scope with the following per-netns
> > alternatives:
> >
> >    ASSERT_RTNL()           -> ASSERT_RTNL_NET(net)
> >    rcu_dereference_rtnl(p) -> rcu_dereference_rtnl_net(net, p)
> >
> > Note that the per-netns helpers are equivalent to the conventional
> > helpers unless CONFIG_DEBUG_NET_SMALL_RTNL is enabled.
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>
> I guess Kuniyuki stripped the ack received on v2 due to the edit here.
>
> @Kuniyuki: in the next iterations, please include a per patch changelog
> to simplify the review.
>
> @Eric: would you mind acking it again? Thanks!

Let me check this new version :)

