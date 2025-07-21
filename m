Return-Path: <netdev+bounces-208669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059E8B0CA66
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 20:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 473867AA1E7
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 18:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7866A285075;
	Mon, 21 Jul 2025 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ugK4KeMG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0FB1917F1
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 18:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753122096; cv=none; b=hHfunohS/Skg6c1NbqF9ax/2ZkSrXqseIFGxh382qXVXa1CH4K/RFep3wiXsLyIUElYHQZYnBoe5Pd4r1DU016CjbbEXuBXRjukkqNHZXanz/I9V66CGWP2jN/ZnkxM8qhIUFMS/8z+mDxEuO5aBm7/TlTJp49R+4opKoOK/zc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753122096; c=relaxed/simple;
	bh=vzTvFaZ503sgItEqV+25lUo5Qsn0f9gI7I+ozEo6v/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udlbOHa0IGJt8A9SyhKH0NeSes7gny2Gh0kUa5TkBDLQmOif2cCLvogNewfBh9vW+IfEib1P9lj3cpLU6J5HjaOnKMjnSPIpNFE+PCr2kS2XyrpXHgOdqctJcpay9drmwOu2hm36upcCZVEchJfTnrjGR+0/mM1laGCXdeNyy3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ugK4KeMG; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4abc0a296f5so37051481cf.0
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 11:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753122094; x=1753726894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzTvFaZ503sgItEqV+25lUo5Qsn0f9gI7I+ozEo6v/w=;
        b=ugK4KeMGSNQiaR7LFmhkF0hQTBrln2hGWnjRVM/yM+qTdEujmlq+/LWY1gUpy8z2f+
         CgCc1AcDcErop6coaCrqivyHmNNM+MHIpbhpIw/35gI4H0KsOnmGYrbmWQ3D0QQ3YDdw
         ag0oPotHub00fPFg7mecycyR2OYImIVcdjVq5+hQcsfhfZbLWI9/hdb/ukaEliDT4/cQ
         IzjMPglzNCedhuABS86yy32nnF92zaT6nvpVPek0K1B+A/6fVs2hgQN8R8X/Hnnemn7t
         jsJ1oOswMmrf9YXWy95kRsz3YLWZvow2nL4uI1I5KtpVa0FuLvsnRFM1AiB8JdzguMY7
         jxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753122094; x=1753726894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzTvFaZ503sgItEqV+25lUo5Qsn0f9gI7I+ozEo6v/w=;
        b=BXZtbFU9+1pGXr8+C3QLYoH0VopKLCNMuAWMh400HX9riNIU9d8gd+6V2bbUvCiXZi
         ekrvVvvZV0ASssdC9OaQL25v9E/sL8+osWBVQy/9+KwYxsE+DugLILmvY/KNlEBtD3NX
         SynEmqCM4WzTWMj1jtg8j79MKFji0B5OijHP7OSI6HnWz8qXAo5VCR3W6Ohn8HJ52Oby
         axx++p6o+swathTrv5o/Zx09JELD+QjLwpLC+tvGwzO5gOkMHdOeVcxizKvtAjg75F3o
         lCiqQZArQBL25Wpw33svl81H8WyJt0NZVoRMyr0auhO0QZ3PmRMOyIVlAiZa3Ckn30W4
         AKFw==
X-Gm-Message-State: AOJu0YwCoqGcrNxUCfhJbcZ9uc8IbtqnUiizShz9tLtF0iVF4U1ZRTN9
	I3JAZ8bh7hjG+i+s6E25k54KOrit3Kfb5PsEXXliHqog3fei5b5dYM4Xj0v34+Z9GhUI0yA5vf5
	1C4kCRGNl7VqyLWJn/srmGFGmma+Es4WMY17grI2A
X-Gm-Gg: ASbGncsV+lnVIoxidihF5vNvZXGsR4TFBy26ISVIZAptNgbTqhxhmWig71iK8fzHDjD
	9vDwTLNdSPN54unYUwd0R0QYRUoSc9gXEYNuqz+IfILuoRlRF4ER/erVJOjvSug7KS8r9AXoab4
	1T4uh+jqmg7tvirLrbAh+OZIfsPpP0v7CiwXbiNvg4XYU92mdsoo+QWk4h0tyl0mybDsNoI1EKh
	iBtqFg=
X-Google-Smtp-Source: AGHT+IHxj46WRpBSf6NBiC+32C+kAGQD12md5Vjt9uD3xlKl2yHvvgsLj0Gh7algUx6TpoBt3B9qijydH84etTH9Ta0=
X-Received: by 2002:ac8:6291:0:b0:4ab:cf30:187d with SMTP id
 d75a77b69052e-4abcf301b78mr79106291cf.19.1753122093388; Mon, 21 Jul 2025
 11:21:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753118029.git.pabeni@redhat.com> <20c18165d3f848e1c5c1b782d88c1a5ab38b3f70.1753118029.git.pabeni@redhat.com>
In-Reply-To: <20c18165d3f848e1c5c1b782d88c1a5ab38b3f70.1753118029.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 21 Jul 2025 11:21:22 -0700
X-Gm-Features: Ac12FXwDEF9X3UXrXWrudNV408Tz6zgvqR9-tTDd8vaSkAVO_MjH1FIavQgaERc
Message-ID: <CANn89i+pNkbsF-1jHZzCg7bebAABTAtMOWgyCyf5erOszb3dBA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 1/2] tcp: do not set a zero size receive buffer
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Matthieu Baerts <matttbe@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 10:21=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> The nipa CI is reporting frequent failures in the mptcp_connect
> self-tests.
>
> In the failing scenarios (TCP -> MPTCP) the involved sockets are
> actually plain TCP ones, as fallback for passive socket at 2whs
> time cause the MPTCP listener to actually create a TCP socket.
>
> The transfer is stuck due to the receiver buffer being zero.
> With the stronger check in place, tcp_clamp_window() can be invoked
> while the TCP socket has sk_rmem_alloc =3D=3D 0, and the receive buffer
> will be zeroed, too.
>
> Check for the critical condition in tcp_prune_queue() and just
> drop the packet without shrinking the receiver buffer.
>
> Fixes: 1d2fbaad7cd8 ("tcp: stronger sk_rcvbuf checks")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks a lot !

