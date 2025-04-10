Return-Path: <netdev+bounces-181360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D431A84A8E
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 18:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC009A28F4
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 16:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940A91EE7B9;
	Thu, 10 Apr 2025 16:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L5BHU7Bs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0256D1EE035
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744304303; cv=none; b=g72kBhxlhzvBpca1Zk0VE7iwelYyyedpZ3wnBQNOcanHI5sweVo8v1iCpU8yUEFe2fOP6gqM0/I6HSIRN78dpyle9gpuYcB5nD/D0kiIwyULMiEyzJNc9pKBsB3PdwZJlueaA59yp2mx5IV9iJ7+zus30y5KgzTEHcy12D+Wqqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744304303; c=relaxed/simple;
	bh=2NYoTnSK20dkPwMiH+PmrMXMd7m9Agd+Fq+KD2i9skM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uFENg15DfpI3bhoed+d22PIncX/W+K9vCq8AB7pxTVO5twsLe9k0hGh7f2GOwrMTSpVwg2bMJVeZQ3yq7LxNp/4bOZkknkJ/PuOzVxll4O4ZTM0WUYfe6aHIbSLiRenoRkcvSAfGqBRggc7ME5RMaZjkulOcsKmNArcS05apaV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L5BHU7Bs; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-47688ae873fso10335731cf.0
        for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 09:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744304300; x=1744909100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NYoTnSK20dkPwMiH+PmrMXMd7m9Agd+Fq+KD2i9skM=;
        b=L5BHU7BsymNPGHmaeAX3U88/kGmZkAHXpZUQlTzwT0fyuY4gnQZ5VoMcmbDDclZPFS
         tctraX2kjsGkDd/LTx1iVH/tj++s3m6vxizBLDrse0P9wPoh2UUK1O5Ray2sxoqsA/X9
         Ew8rp1onIReFSLdcOaq6GT4Iug2LP17nR2oWHEylRVJXWY3Tidsxld314Cb3GREeyNfi
         3Xcr4WCe9fqMPgxRF3E4KKsLdR7/9C2Njc62uato3uSEafSBHJOn317vKMB5Jo6aaIPt
         lfjnezdW43tVLac0c+WlTUZpBU6fX71Elt3P3peodhlbm8JCyADrTlqjO7Ekrk5QCD+N
         y+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744304300; x=1744909100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NYoTnSK20dkPwMiH+PmrMXMd7m9Agd+Fq+KD2i9skM=;
        b=G7KMUDxPG1VS/ldhn5/mitHx/pGSYP72z3ZieuejWP8LUKrPwGxYmi3H7XBcvuhVqk
         3woPd3ar+1s6yYaiR7c0DPHxQrT7QJtAzc3n16EMinQQ/7Zbns5obmfi7ks0O1LrrC1o
         GQ8XUoS6m4N1nvxANERsIgnoHHnN9RoawW2GoUxaGZlxoi/NRarfe1ermAMRf2zmwF4W
         Cm2IG/vmoDNlPY4xyNaxvJgAHVk3l7b+nZH+ot6DZpq6Pgn5O1DS7NgdP2Z1+N42EfVi
         8DHaGq9bt4mVGUatjBaMX439jo62JFGPyA5YlwPn7J7/Rg1mKJ3yNYX2b8u376i1BUrd
         N+8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzwbCq4z0xTS84okE3c8SCGbtUgToXmbNaj2ez9RraGtRqrGri/Tbzwtw1TlM3zMzqXdsp8Jc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwgc6eLffPeOp3tpdjReDBl28W8VOYxnnKvIrBBi8v0hGwGeSR
	zpnR+C3P88+6YVjOqhVHYX9iysNzQQjc2Oa6TsnNAA9f26rAhnjQyMQV0Yx83uvRgHjG+eRk7t1
	8DFb4rZIenhUQjcZAfpfHGfffvLvL8V7tD0Gf
X-Gm-Gg: ASbGnctR9NRL0pOwZQMZYYYypRgJDVEy4gkkQtx/4aQtBS0nzXajzNwG4rSeunRahU0
	PerITGxtJhCb4y1La2o2GImsJzur6EH5L4aPWHR+y9YKtTiG+klttgA2QRa1XkhCgTEqt6LNHMm
	+F4kipUvn0hQFStMzcqlV9BG8=
X-Google-Smtp-Source: AGHT+IEOVT1Z8/NH1HG6VUHZxnDjeDB3SasAhCAR0fy4recc1QZ/FY0FSGcXw5gByOay7lO/Vo/lgAvjLAswmr7qoDk=
X-Received: by 2002:ac8:5acd:0:b0:476:884e:52f4 with SMTP id
 d75a77b69052e-4796cbb21acmr50525311cf.12.1744304299429; Thu, 10 Apr 2025
 09:58:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410161619.3581785-1-sdf@fomichev.me> <CANn89iJ_CYgP2YQVtL6iQ845GUTkt9Sc6CWgjPB=bJwDPOZr1g@mail.gmail.com>
 <Z_f1juV_86Yv9n21@mini-arch>
In-Reply-To: <Z_f1juV_86Yv9n21@mini-arch>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Apr 2025 18:58:08 +0200
X-Gm-Features: ATxdqUEbY-LQ2bL4TLdX6U0Pv1AjS-BCyjWXBjqYDybauiCAjzcRxD1hKqLzAi8
Message-ID: <CANn89iJ69ffEZcF0VhSwqFSToK9a+O8-DupZkkvHnX6Y7M2aqg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: drop tcp_v{4,6}_restore_cb
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, ncardwell@google.com, kuniyu@amazon.com, 
	horms@kernel.org, dsahern@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 6:45=E2=80=AFPM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 04/10, Eric Dumazet wrote:
> > On Thu, Apr 10, 2025 at 6:16=E2=80=AFPM Stanislav Fomichev <sdf@fomiche=
v.me> wrote:
> > >
> > > Instead of moving and restoring IP[6]CB, reorder tcp_skb_cb
> > > to alias with inet[6]_skb_parm. Add static asserts to make
> > > sure tcp_skb_cb fits into skb.cb and that inet[6]_skb_parm is
> > > at the proper offset.
> >
> > May I ask : why ?
> >
> > I think you are simply reverting 971f10eca18 ("tcp: better TCP_SKB_CB
> > layout to reduce cache line misses")
> > without any performance measurements.
>
> Oh, wow, I did not go that far back into the history, thanks for the
> pointer! Let me see if there is any perf impact form this...

To be fair, we now have RB-tree for the out of order queue, we no
longer of O(N) costs
when trying to insert an skb in this queue. Also we try to coalesce
skbs together.

Tests would require thousands of skbs in the out-of-order queue.

Think of long-distance flows (rtt > 100ms), and big tcp_rmem[] and
tcp_wmem[] limits for the sender/receiver.

