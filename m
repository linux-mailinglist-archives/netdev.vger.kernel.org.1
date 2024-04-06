Return-Path: <netdev+bounces-85399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A4F89A94D
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 08:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7469B22287
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 06:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023C3200DE;
	Sat,  6 Apr 2024 06:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rG0mg3H6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD791BF31
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 06:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712383906; cv=none; b=mVRtzXI03xgC2dFBcCkj5jarSh8g1KQIZSBseLZwHxaw7M/Fo/QZLL0BHd/9ADqzlFLwuUlJsLVbd+mw8V6CRg8vHvQ11jl6uQuY2uEl9oE9yZd67tufsNkCz9gTBhkIu7dL2hZAuZC4mwFneq1NyfyDcBBQT6ylW4JPnaia3mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712383906; c=relaxed/simple;
	bh=IWSnD6PNypWn6IohyVGE2EGVDQTaNfNBpyqRt8wNRI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLw6u3MZ992XQCbisqjA+1oT7+s+NO3ltcGwfx566eQEQsrHJbTQYmYQ94fBFAYG+y5dAaHRGKMXk3OTrWXXlhgwZ5ANCirQauc/8LeWTxjoobfrrpH1kqTkIQuB2mHsitbLvd2l36qv/cThpIS0cEIX8Ti78XquYw7+ocyhYUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rG0mg3H6; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e2e94095cso6250a12.0
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 23:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712383903; x=1712988703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/a55cJ8hJ13XS9lWC5NZ953qNqlE7BYmLL1+UBMNMPs=;
        b=rG0mg3H62BVXYpitBMDw4oMv/6ELmzpyYfNfW7pGkG5VnIpxamKg0gHeZhFQ3thnLb
         EI8LAhz0TEjeJaC58VCyQj5cJhSxHirtqdmIb5rhvtQ06UhgRZV+axrJhucOe3z0d6vG
         dUMoVVojSMTm84xbHrtUXvf8qhiPTKMrq6cAMAu/fb2kpiuk8Z9V2Tw4bFrUd7XfBZWX
         FfiKOO8WKfM1fX/ykL+8ZDk1CS+KheP1QAa9PHz3HbviebGYriez3jlaKTwq9B68I6VS
         39nMQ31yjyy5aXd2pHWCghoADPxf10w087ilCZIwM9qnZOZsDQ4ZtLdcF8XltxCcljbl
         KM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712383903; x=1712988703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/a55cJ8hJ13XS9lWC5NZ953qNqlE7BYmLL1+UBMNMPs=;
        b=N+5iU9TgOGIqWgnyM/Bc53XDqlcOhWB7+rodjeZiJz46XtEEIgIlZUwBPyHC1QLRmu
         4lknQgNQQsVL9/ybQLvlPE9HcfBBnIBSKuBClaRQ7PA2bR+HD+anFbthI3IjDfczQ384
         qFDuqM/V47C/QIzij/R8obttj4xafn9wlfoFbBxnJ5NZ3znkykgwObQ1/PQJzXhyq/0p
         yjIjdaBUwxQgoGTla20jYgAimxRrjL92cy2wsZ0bphi5CWTrHHBI808B2dWEjFbzr2NV
         kAjQS7/vZCrF/J5LdAEeCFIpiXTpJ5ZABLqeLOQRJfNHtCBpCycPdI2yBSI91QFMiKs3
         /fQg==
X-Forwarded-Encrypted: i=1; AJvYcCXgfCDomhplicFf5ChjSl/nXCNSqn/fCAOAarppHl9Z39uIZdr1QdeG489MI0/N0ZeE7PAREc7mzkzAdgpzmW9Aw/wLDlLb
X-Gm-Message-State: AOJu0YxMIOB+h0++6jrvjOHYSGpfAPUbOSfRj1+/NFf5WydvYlxY9/oA
	a0ri0d//FotAL2MB3enP91JlRB9+jGHYCRuJ3TkHKOg+jk7QgH23nc5NrB6/V0BV1e/WPYEa83b
	jF02q2NBDGU6O2A/T4mRldzPFW94Wt7aj/5ww
X-Google-Smtp-Source: AGHT+IFvVsqGcO0ikx4EQjxh5xb7x+TtjmKB73J3SnP9xQrnE1EyZ2Og7hNRUpLWPnlolHE/jkXa5BcEbo6xRrHDpzw=
X-Received: by 2002:aa7:d417:0:b0:56e:34de:69c1 with SMTP id
 z23-20020aa7d417000000b0056e34de69c1mr79202edq.4.1712383903267; Fri, 05 Apr
 2024 23:11:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230717152917.751987-1-edumazet@google.com> <c110f41a0d2776b525930f213ca9715c@tesaguri.club>
 <CANn89iKMS2cvgca7qOrVMhWQOoJMuZ-tJ99WTtkXng1O69rOdQ@mail.gmail.com>
 <CANn89iKm5X8V7fMD=oLwBBdX2=JuBv3VNQ5_7-G7yFaENYJrjg@mail.gmail.com>
 <f6a198ec2d3c4bb5dc16ebd6c073588b@tesaguri.club> <e463df8c95bfce3807459e271e161221@tesaguri.club>
In-Reply-To: <e463df8c95bfce3807459e271e161221@tesaguri.club>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 6 Apr 2024 08:11:32 +0200
Message-ID: <CANn89iKoaTjaK7s_66EOHAYw+drT3XTEhT5xBcFU1iHTYr_aug@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: get rid of sysctl_tcp_adv_win_scale
To: shironeko@tesaguri.club
Cc: Jose Alonso <joalonsof@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 2:22=E2=80=AFAM <shironeko@tesaguri.club> wrote:
>
> The patch seems to be working, no more dmesg errors or network cut-outs. =
Thank you!
>
> There is however this line printed yesterday afternoon, so seem there's s=
till some weirdness.
> > TCP: eth0: Driver has suspect GRO implementation, TCP performance may b=
e compromised.

This is great, could you add the following to get some details from the skb=
 ?

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 1b6cd384001202df5f8e8e8c73adff0db89ece63..e30895a9cc8627cf423c3c5a783=
d525db0b2db8e
100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -209,9 +209,11 @@ static __cold void tcp_gro_dev_warn(const struct
sock *sk, const struct sk_buff

        rcu_read_lock();
        dev =3D dev_get_by_index_rcu(sock_net(sk), skb->skb_iif);
-       if (!dev || len >=3D READ_ONCE(dev->mtu))
+       if (!dev || len >=3D READ_ONCE(dev->mtu)) {
+               skb_dump(KERN_ERR, skb, false);
                pr_warn("%s: Driver has suspect GRO implementation,
TCP performance may be compromised.\n",
                        dev ? dev->name : "Unknown driver");
+       }
        rcu_read_unlock();
 }

