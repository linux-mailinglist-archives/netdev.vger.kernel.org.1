Return-Path: <netdev+bounces-82117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB4E88C58C
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 15:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9B76B251CA
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 14:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078CC13C674;
	Tue, 26 Mar 2024 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SqquaAIH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B480213C664
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 14:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464413; cv=none; b=UvOQnMfHwzYuB740xBisYzf157RPeEpKzdu5DvNgeRO0K6ouh8OivIxMtJDatfIHsQH0In3mKfW+6Ma5w8XcXLkyw11AmO3W5We7wN28aI/eL4zSb2IBF/YNIr+rTLxQ9HEy8n7n6z3rUJp6nhyMLgcc/nAZdrjHo8FTqVPiU1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464413; c=relaxed/simple;
	bh=dVw2sCCZsjOclcEyJtFzLmGPKBY9n3k3XeHTRvzsKws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YANL3EKjnjkvjkW+20NBYr+dgGwwIUFn3qRe8XzqaigvV4ptPhPih+GLIX4UXL8riUXebQVWm2pF0okoI9fsCV84MghxpsRcg7uGGmVaErWrSh4XUiE1BJEVlqD570WojXkfCD1IMDbWzkcv95bdE8Fsh1iycXiUYVWZAIi3YfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SqquaAIH; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56bde8ea904so14109a12.0
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 07:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711464410; x=1712069210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVw2sCCZsjOclcEyJtFzLmGPKBY9n3k3XeHTRvzsKws=;
        b=SqquaAIHb4Yw0ver83CxpNmIiJbclD87OH/QF3hJGrsmwxOgo/Y+mbANkxY4BaPodx
         QC+4pcPW/4yXo8vc2uLyjF3EYuc7nsHRfyW/DESdmnrLy7lLs0ZgEeB/oK/4ycbXXAYb
         40rahRzYpuT1EtuwIAFr3q2Dl1pmXqO5/8douSnwAR0916Bqk8HxEpreKjHi2/qKj8M7
         AYBfM0m7CVcoM/FbyjZDXd4AwHo+xdYgFTOQ4M+Q4XYghIA3ZT3zHDHA25UivMeKHWAX
         UzDc+o1NvQ28V/OPDZexXg1+BSRef2+YIKmeviB4iTMBm/pVM9G+SYSwRQ336aesRCyr
         agxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711464410; x=1712069210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVw2sCCZsjOclcEyJtFzLmGPKBY9n3k3XeHTRvzsKws=;
        b=cC2XK/Vq/TNzIxbH3B1IiZjjuZr3fYjcryRDYilLgsfIniS5LiyUuyfFc/Hjb4WNHC
         dz327U4gLBCLq1dW4ahA18CBTNB4a8hPCfD1NWRly+U++7GfYgxsW+e466pnPmpiiwtL
         rbtV2/PuTwk7JmwoX8bh2GCSFikZ9u5Rba+b3v0a3JlBVkenmLpy8vbriKR8zOZRlfS7
         GydYMt6JbZzdmIFUnlYkK7RhzisYUDGwBNuOyxPgpkoDs4T2DbTljdRcH11Ai8R4jIlZ
         MNoHbdTGG6S9TRkhJASDqla7Hty+E+NQxivMmyOTW/sikTVjOoa/VO8tBGGbEdTEAu73
         Qvtw==
X-Forwarded-Encrypted: i=1; AJvYcCXc4kH0gVXcbEXMhdqzc5XCcT/xdsiVwHvNU0sfK7ciSRRytY2n7mq3RfuhxWB9dbw8fVLvCvEV3+DiLHGI28AitCq2dxxv
X-Gm-Message-State: AOJu0YzD7yBEIC4ep2sHO39vpkj1024JUliFS91V6KogBIM5WAeLHGHh
	o/nm/DQRibR6Ap22hkkGhowe0iCyysTHmlrpKd3xxltS28OnMApKKewLtcYgHu9kD6OYC3z+VLK
	u5CuE1ZxBAO5yaCq3WtCVvpvVYFQJzTcopS5/
X-Google-Smtp-Source: AGHT+IG9LbpsClHFRdFkwkVL7pLUpmQRG00kiEIP3HmNZZDos4Tq2PhwBiVFXB28ezLKitT3SO1TZnjwEjpGhUtA9hs=
X-Received: by 2002:a05:6402:7c2:b0:56c:9ae:274a with SMTP id
 u2-20020a05640207c200b0056c09ae274amr120016edy.7.1711464409816; Tue, 26 Mar
 2024 07:46:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325182543.87683-1-richardbgobert@gmail.com>
 <20240325182543.87683-5-richardbgobert@gmail.com> <CANn89iKzeTKuBA3NL0DQUmUHmmc0QzZ0X62DUarZ2Q7cKRZvSA@mail.gmail.com>
 <46e0c775-91e7-4bf6-88f3-53ab5e00414f@gmail.com>
In-Reply-To: <46e0c775-91e7-4bf6-88f3-53ab5e00414f@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 26 Mar 2024 15:46:35 +0100
Message-ID: <CANn89iJkDbzLKmUGRHNFpfiaO8z19i44qgqkBA9Updt4QsRkyg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 4/4] net: gro: move L3 flush checks to tcp_gro_receive
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 3:43=E2=80=AFPM Richard Gobert <richardbgobert@gmai=
l.com> wrote:
>
> Eric Dumazet wrote:
> > On Mon, Mar 25, 2024 at 7:27=E2=80=AFPM Richard Gobert <richardbgobert@=
gmail.com> wrote:
> >>
> >> {inet,ipv6}_gro_receive functions perform flush checks (ttl, flags,
> >> iph->id, ...) against all packets in a loop. These flush checks are us=
ed
> >> currently only in tcp flows in GRO.
> >
> > I think this is a bug.
> >
> > GRO should not aggregate packets if their ttl/tos fields do not match.
>
> AFAIU, the only UDP flow where ttl/flush_id need to be checked is when
> udp_gro_receive_segment calls skb_gro_receive - could you confirm / point
> out if there are any other flows to which these flush checks may be
> relevant?
>
> As I've discussed with Willem in v3 I prefer to fix this bug in a separat=
e
> series.

I do not understand this patch 4/4 then.

Why bother moving stuff in net/ipv4/tcp_offload.c if we plan to move
it back to where it belongs ?

