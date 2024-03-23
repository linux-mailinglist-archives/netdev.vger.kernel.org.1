Return-Path: <netdev+bounces-81366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 956C4887715
	for <lists+netdev@lfdr.de>; Sat, 23 Mar 2024 05:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC94F1C21807
	for <lists+netdev@lfdr.de>; Sat, 23 Mar 2024 04:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05332107;
	Sat, 23 Mar 2024 04:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YxA6g43G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B111113
	for <netdev@vger.kernel.org>; Sat, 23 Mar 2024 04:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711169143; cv=none; b=a+M+Oe6q2GfbI03Xq1kLj5GL8Z4L7Wi3EY9mR2LIqcFYAEjL2JFuVi/KzckF/YhgDonRsh7eKVYDn7+G+aDwfjfoiVSTeIGPYSGfwGCj1CkC1gl28PerygWrm7YV+d2IVTOPDuidcZiL/K8JRwxOQZqOvIG89W+zEgsf8FSUijw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711169143; c=relaxed/simple;
	bh=ygla7RDG4OzFqofa8WdpTFk+hRpkoGTX79C28ayCJAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mplEn+CwPl4ghkoERbqxKqyOj7zD1PNIw5G+2DWRe8gk3oF9LMGVzJuQflSgdVM96I9uzH83bm3CmmbOm8r4ei2Zljm0x+gz5/YxiapY0w0zx7f0t0vIiQLc+p8XLAMnnr6RkLsAiPNfU//136R005pmj+DzJtZiQd40k8sQgKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YxA6g43G; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-513ec6e8735so792e87.0
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 21:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711169140; x=1711773940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7ry6KT7H3eW4zkc1wMJOwDc0OhAHbEW7jY2Gek06S4=;
        b=YxA6g43GRY53W+6lOvP9WWMvJt1Ddn/+/QE5HS+zPLjfoxctUBcJo8vr5UpHb6m9Gq
         elRudgx3Vb3qDG2r4rbzAg8lbvBcRl24B3wdN3WBfXOX+cZj0crcJ718HcrNQJL+ytWp
         p8wIRUDDs0MiBWUPA7MfxCTZ3zthdJHCjA83Ybapxh2/kG0U28Zbqq4ob+BPYd951NPl
         IxPSMpreZtRtC4WweUp1QNsPr2lWY41lBFTapAEueKSV8nAtgav2xTYK9CrZnaeoSbxD
         uFudzDa6zbsilnGRwkuGCj3plGboiNG8MMaU3V1NA7zmd8j8V/9UBsHuY+5QkRBTBVpx
         M9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711169140; x=1711773940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7ry6KT7H3eW4zkc1wMJOwDc0OhAHbEW7jY2Gek06S4=;
        b=PZ61H47aeIfwYJCCHT5L1c1+IfM8GE53SdENtKgF/ptMGWEBDf7HyYsmSdKEJ1CEs6
         fL7py87a7Ac0qsSaenEtGnXIAdhu9nt/B+hYYRPMeVP/rxHZFzZWTpaOM/QcnUeUE9iX
         23+lqlnXNbYi0fLCRwynaKhA6VyAGxxxpcyuvSRuHsdhrJPUGOJGAqk+btrmG7DrSSMl
         Ix4XyL+NbFUAs0JTtAwqrJdidX69mGmkMO2QWQmsCgjFlnVRS0YBjCapwFZ/K6Xy7xef
         p5IwbmzL5B9CwbvabvP/Go75yeHGrSR1RayhQRJa58WNtAJldsNx3fZh2H7nALxxZClv
         Xj+g==
X-Forwarded-Encrypted: i=1; AJvYcCUGd3/2QQCDTijQVTAGCWsIAvgBR4dtXejspNV0unRZvMJp4qlzsSzCUd4jTl1aBXCZ8Ri4uHbW1CubmEq2Gfqc0Tu+72z8
X-Gm-Message-State: AOJu0Yzrr6jO32JPbP4bOUlXYERUUiD8Jqm8khnwi79hxpDBFh7mdOcW
	+KHA9USNbjnpCCNwXNTkbcjnRBN2YsCdtBEbyJosVKOFfuQnhBNj8Hc5QBGe3IRNoSlWlf8YZFW
	qdDbrAM94O6Cbc8PnhcCuclRzkdV8pyzG+GLI
X-Google-Smtp-Source: AGHT+IFA6ndyS5/NoOM3pw04V2aksZi52jp6QKbeH2VD3u4PnHbmQpboBVXlb2qJgwSGn2I5yMb5wjK1TBL+JYp3FTE=
X-Received: by 2002:a05:6512:34d4:b0:515:9109:6bfb with SMTP id
 w20-20020a05651234d400b0051591096bfbmr328355lfr.7.1711169139689; Fri, 22 Mar
 2024 21:45:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322135732.1535772-1-edumazet@google.com> <20240322154704.7ed4d55f@kernel.org>
In-Reply-To: <20240322154704.7ed4d55f@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 23 Mar 2024 05:45:26 +0100
Message-ID: <CANn89iJ-TJY8Bf_6W2yh1F4V0qBNNUKk0NGNT2XJN9Or0oRgdg@mail.gmail.com>
Subject: Re: [PATCH net] tcp: properly terminate timers for kernel sockets
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Josef Bacik <josef@toxicpanda.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 11:47=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Fri, 22 Mar 2024 13:57:32 +0000 Eric Dumazet wrote:
> > +     if (!sk->sk_net_refcnt)
> > +             inet_csk_clear_xmit_timers_sync(sk);
>
> The thought that we should clear or poison sk_net at this point
> (whether sk->sk_net_refcnt or not) keeps coming back to me.
> If we don't guarantee the pointer is valid - to make it easier
> for syzbot to catch invalid accesses?

I do not think we should do this here.

Note that KASAN has quarantine, and can catch invalid UAF accesses anyway.

We could clear the base socket in sk_prot_free() but this will not
make KASAN better.

diff --git a/net/core/sock.c b/net/core/sock.c
index 43bf3818c19e829b47d3989d36e2e1b3bf985438..7a3ed6262a7a3c603e3964e7c1b=
40c82ad9c8bff
100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2110,6 +2110,7 @@ static void sk_prot_free(struct proto *prot,
struct sock *sk)
        cgroup_sk_free(&sk->sk_cgrp_data);
        mem_cgroup_sk_free(sk);
        security_sk_free(sk);
+       memset(sk, 0, sizeof(*sk));
        if (slab !=3D NULL)
                kmem_cache_free(slab, sk);
        else

