Return-Path: <netdev+bounces-203808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E12FBAF743C
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 14:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7015C163BC1
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 12:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0D629B792;
	Thu,  3 Jul 2025 12:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZddOiBiZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70D421D3F8
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 12:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751546011; cv=none; b=E8aELIkuB0fLvEth5qCDMEPmfUYujNBl6C8uV1g+TU81DZe6XU44WlfXBJ2KO94Rz3+oy4vMY382SUgrFZA4SRnOG3rBOML9y7ed6Hec33sWcXRlqzfHEhomgMrive/8u3wrkZeFsPaAfisi19B1+7CMFqrn6naH5D01xsIVLs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751546011; c=relaxed/simple;
	bh=Ptsjzf8+zecQzbj9dMtjUikfyamkQ+9Ox2BXpSwfkxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uuq3RY9u04U6TY7v2yNy7CCQPU5ElFfjO/sD95tV0J6yNMAbnkxSjcojDKOjThXWhNdsf73xkgD5Mwb1bXd99h9CXS46Dy7bDEV+oGND49ZR42BUIQhQxKxWp3qFHGP4OdxDVRfT+93PlCWKlJYXuJModTQlijwNVNCfUnKGJAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZddOiBiZ; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a752944794so89262081cf.3
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 05:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751546008; x=1752150808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ptsjzf8+zecQzbj9dMtjUikfyamkQ+9Ox2BXpSwfkxI=;
        b=ZddOiBiZLmtx4grLzKnfksSKl/aKFRgU/C4WULR8znD2CEboCyw96JbpljLltTqCzh
         2jipic95mUhjIvoHFIQ+uNqG2LOqPQ7i3ISnO2hv33/aifbsfXUevL7MeM8ofAt6ap2Z
         8P6rUFNzgofOc0PbyeV/rHHIjF83PN+H62uiUCFhMYf0wsby0351UzN21j7cgeXGJ6kZ
         tssgeem65u2jusBL7RWPrS35+ZmAMCKlG+rZTiJuvHENiTjQm5AzjA7rKyi1GxnvImFW
         iLHBiRqXuaj/Vd3qxX4YLOHt1/5Ub7lDm/vd9dtMobgfrANklja7C2nyigIe9yemRwT9
         ddnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751546008; x=1752150808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ptsjzf8+zecQzbj9dMtjUikfyamkQ+9Ox2BXpSwfkxI=;
        b=khRcKMov63rhNLj0vIVyQ6y5m2zUUdGhgpSPv7B4C8tSm7MiEQ2c0Z9yO9NrES6PBi
         Pf+NUJjHv4sopoZvP6Wq1J2QclJa80+lDF3JjScSwsAHsSQWhWzho3QSGnLaFOc71MBC
         e5ZjsNUML/ivqaLCIPMgcTMO52rxQYBrrDsouV7hK5hff80vuXIu2hMQTjPm1MwTgDP+
         KThn9cXcHDGsgcYfRHLAelZV9AktSj8KZd/M8B1GVd/V+jGdECAwt2nZaa0zzVI6CizH
         iO2nF/ZjLx/t06Dg0+g0SkG962gnfYh9StOj1LnLrPiCinORdCBv/8Jdy2qvi+Zu9D38
         D/zg==
X-Gm-Message-State: AOJu0Yx9KvTWTps8epM+2tG5Rsonk8fE3FOzBqAVkM1AKelTu6PewSpM
	anDLit8eQvs0VrV/lNe2m922lVLykHiIsSkfI68j3ii3pg86lpcTKTZRygDhkVWlC1++5OURFC8
	EEcZLeWiPEDzrfvmclaoctVKF6FIkLL+aw78B9+5N
X-Gm-Gg: ASbGncuVNNg8XL56Z+wpiSoxy7o9uDvIbhZ8BcMbfyda+hrYVpX6Nel43SA8QoAObvM
	hHeeSbtFdgZQNb8FuvYVvyZ2cKJQ1GOH2FoEdkH2KcPytIsVmxeCJMD5pcnuqRnZS9Z2EGs1Vao
	a8bLcCdACtsxh6wtjRIdnWxMSC+kLVHhOjPXCV+5TeAHE=
X-Google-Smtp-Source: AGHT+IHxCWPBsSRbtYOVftLPJkM3kyPLupAKcQLcv+QF0+EbxfFG7g/xCWEfeXsj+2gKQRieuEutHEvyqdr+9YatpbI=
X-Received: by 2002:ac8:59c3:0:b0:4a7:9d00:770 with SMTP id
 d75a77b69052e-4a97695c4ccmr122755671cf.18.1751546007977; Thu, 03 Jul 2025
 05:33:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702110039.15038-1-jiayuan.chen@linux.dev>
 <c9c5d36bc516e70171d1bb1974806e16020fbff1@linux.dev> <CANn89iJdGZq0HW3+uGLCMtekC7G5cPnHChCJFCUhvzuzPuhsrA@mail.gmail.com>
 <CANn89iJD6ZYCBBT_qsgm_HJ5Xrups1evzp9ej=UYGP5sv6oG_A@mail.gmail.com>
 <c910cfc4b58e9e2e1ceaca9d4dc7d68b679caa48@linux.dev> <CANn89iL=GR5iHXUQ6Jor_rjkn91vuL5w8DCrxwJRQGSO7zmQ-w@mail.gmail.com>
 <6724e69057445ab66d70f0b28c115e2d8fb5543b@linux.dev>
In-Reply-To: <6724e69057445ab66d70f0b28c115e2d8fb5543b@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 3 Jul 2025 05:33:16 -0700
X-Gm-Features: Ac12FXyLpTLWTKVyDtut9uoSQuD_gpE99ErR38nFK0rRJuJ6pTn1bXL_9TRwT8g
Message-ID: <CANn89iKxTj29DG-44d7SbhEh3_h4PG8009RK9+sAZJx_pg04kw@mail.gmail.com>
Subject: Re: [PATCH net-next v1] tcp: Correct signedness in skb remaining
 space calculation
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, mrpre@163.com, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 5:03=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:

> Hi Eric,
>
> I'm working with a reproducer generated by syzkaller [1], and its core
> logic is roughly as follows:
>
> '''
> setsockopt(fd, TCP_REPAIR, 1)
> connect(fd);
> setsockopt(fd, TCP_REPAIR, -1)
>
> send(fd, small);
> sendmmsg(fd, buffer_2G);
> '''
>
> First, because TCP_REPAIR is enabled, the send() operation leaves the skb
> at the tail of the write_queue. Subsequently, sendmmsg is called to send
> 2GB of data.
>
> Due to TCP_REPAIR, the size_goal is reduced, which can cause the copy
> variable to become negative. However, because of integer promotion bug
> mentioned in the previous email, this negative value is misinterpreted as
> a large positive number. Ultimately, copy becomes a huge value, approachi=
ng
> the int32 limit. This, in turn, causes sk->sk_forward_alloc to overflow,
> which is the exact issue reported by syzkaller.
>
> On a related note, even without using TCP_REPAIR, the tcp_bound_to_half_w=
nd()
> function can also reduce size_goal on its own. Therefore, my understandin=
g is
> that under extreme conditions, we might still encounter an overflow in
> sk->sk_forward_alloc.
>
> So, I think we have good reason to change copy to an int.

Ok, I wish you had stated you were working on a syzbot report from the
very beginning.

Why hiding ?

Please send a V2 of the patch.

