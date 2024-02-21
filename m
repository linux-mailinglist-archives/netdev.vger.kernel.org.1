Return-Path: <netdev+bounces-73586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3456285D3AC
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 10:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640241C22112
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 09:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B7E3D39A;
	Wed, 21 Feb 2024 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kj/HoL57"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A45F3D38E
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507750; cv=none; b=REcMBQ24q0ELKmpmclWvWVjGLDvIgSi+tXrRWdDV+euKLQRb7oaNNCtf2wKYpGG8jvEtfDAjIj0xF8UKko31mHkVSGfIEJHU3zA/zS7/gd7fvoyU8/a1axSnNcOK0Jcfpj59GLJoCV//F2Zz40ACWK5CNr102NV0/ntrlvYkVhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507750; c=relaxed/simple;
	bh=8+2DFd8fj6iiV8SYABTIvs3JhMvYN4bJm3FMRlQSXMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hN/UdSn0yPtFs+zZa6CHZHZSpnaKLQfACvZqugSV9DQcgKOVdE9DnSnSqkNENVVBBj+USb8YTJabNqrbIknWj4sK2clokATT4maDVnHaR7vA+HUOsKhkfi+QN812Xokzgk5GyrEQZNGxkikR7fBjlfF+T3L0fHQgYnYWqyK0b6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kj/HoL57; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-564e4477b7cso7225a12.1
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 01:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708507747; x=1709112547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+2DFd8fj6iiV8SYABTIvs3JhMvYN4bJm3FMRlQSXMc=;
        b=kj/HoL57ajjOmhyKTGUMMtXAMacdx9WBc10VZIqOgvroT+sSMc74Lr1lbx/rJKHlYK
         hyvLmaFvX9rQq7cmyvpX8DS+GJAE6Ws5aWM27ouJ3LbzSVVX5O1SUl8o/5cGm2B9193J
         JIXAP3VthwQ/Xr54fCM2VG0CP7mCw0WTKC2OgXCP2LGjiFE3QlpvviToNftC4GEyGI1h
         Uk2gsoxXdYJoh99QDHJvhY2OwvAS2SzGgBNVwxfbK/gVDSCMHj977aHO7nH8cZr11e0b
         4wQYP1vae3aN3oOZzVoaWr7JsJ4kSkd0erESr5kquTL7AyHJYXsWFliij4R9xKeoHRYr
         sqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708507747; x=1709112547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+2DFd8fj6iiV8SYABTIvs3JhMvYN4bJm3FMRlQSXMc=;
        b=eJupFsFfzVqiCqwXXsAGAc3FFDU6DGXj4dCxp7YfgHHv7AYTwn1bkXbwbw3fHiDCiJ
         8Z1weXdTbbti9xFLlJr+BzoEWEEKHZLVVCdZX3PZrA3lk29RJmY6+fWFxc+wghprZuVj
         Y0Q1yHQvysvD326nD+aJcOgp1ah4Tgg2Og1pAghfttWbroSiZxWY9lvIt2A/8wiYhPol
         xlJ1FnHu9z7Y1bWSbcTcpIHPG5Fh4A/SzYhpThGmQQzfDrJLlLdjnWYruIUI6eRnENTP
         +nXqxbshPvnLqD3dKypPb2CBHrMO3Q8nGG922dyx+LeOy3nUo32xIvBgs/asfh4y8hg/
         x8tA==
X-Forwarded-Encrypted: i=1; AJvYcCUi4XZbIWaT4FwdiBQBjF6vafvtyqjGuKUYbo9U8qsS4vBE1OJ+GksP2Glu6QHcXa1Jb1133vsPe5smQOOw699rnNTogkDH
X-Gm-Message-State: AOJu0YxCckEClGhstcmsnEy0og6xPCyoOsbuMVDJrrcu6TF7HMshElFw
	6NIaNxF6stefzG4i6uNqun6jAY+pEMGa6bN8fDHSO6kvkW76nGagkTcHDYu/rKfQjobhdC2bVWv
	rHLVAhzVISvvOzWPKDdHKVMlKIBKW9IUFYdDE
X-Google-Smtp-Source: AGHT+IEUmM7JE2pNIlsJtflSIDEpKxRDtAejP7DMB9AaGzjwQ+Jd+MG7/AH1/5ZopRNmERINa9u/a0tQsb1VINVC7PI=
X-Received: by 2002:a50:9f04:0:b0:562:9d2:8857 with SMTP id
 b4-20020a509f04000000b0056209d28857mr132454edf.6.1708507746538; Wed, 21 Feb
 2024 01:29:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221025732.68157-1-kerneljasonxing@gmail.com> <20240221025732.68157-3-kerneljasonxing@gmail.com>
In-Reply-To: <20240221025732.68157-3-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Feb 2024 10:28:52 +0100
Message-ID: <CANn89i+foA-AW3KCNw232eCC5GDi_3O0JG-mpvyiQJYuxKxnRA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 02/11] tcp: directly drop skb in cookie check
 for ipv4
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 3:57=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Only move the skb drop from tcp_v4_do_rcv() to cookie_v4_check() itself,
> no other changes made. It can help us refine the specific drop reasons
> later.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> --

Reviewed-by: Eric Dumazet <edumazet@google.com>

