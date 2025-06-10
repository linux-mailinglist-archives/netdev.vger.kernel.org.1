Return-Path: <netdev+bounces-196147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47151AD3B9F
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 16:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795DE16BFBD
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 14:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7F81AD3E0;
	Tue, 10 Jun 2025 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4nqarmpq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49E878F39
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749566836; cv=none; b=Y395TR1wK8mete9pW+lNFdAtWhFvNOoFLqr8grva8SqCYDKkijRs6FSrNA9TWkiUH0UKbkIwSw+pxOQqCKjc8l+chHHLVwvwZ5HtBij2g2Ga1Ez0mPpPUxaeHY0shVIMa34UAA3aKH7z/en2rAbz6AXd38NH1TkplDOuuglx9fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749566836; c=relaxed/simple;
	bh=FZPSJSobV+2clQAW57HhDQJrYIdKkViaMqsz2twW9aI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tNaZ4by19X2/edcEVkpNBNi7YtWiVs06tFiZ0uDsZMJXnX7C3vUiZdQ0tcg7YawNCshi6q5IqCfACcWNU1X6kOmZx3g8JolwjYsf45kefnqB9VPKzf8wOqdaThvX5b/O+GkFdxd4fVVZ7t6CClLyoYTMACvwBNfRJ6mQ2ldeM04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4nqarmpq; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a442a3a2bfso98922451cf.1
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 07:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749566833; x=1750171633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZPSJSobV+2clQAW57HhDQJrYIdKkViaMqsz2twW9aI=;
        b=4nqarmpqlfmEFcgvVlKfyJBwAvhS1jQOf0ADiF8hdvhuUXw1zuC0do2is2lxemU4C5
         7zxtavahwOXXcUAQexwSnw0GOri3DAKvEO11KxKuSkpF6/LexULqTaJYMyfAbbo7VNVl
         D3BJGRXhaYIi08YJ2ltxIaHGnFFXuqBbY8hxQZZfqlkoGyXaaAgotVxUR4i42Fvfj/LB
         mW2oFKem7+tUnh53PAsLWPEgsstQom4Z8KSD90hHADRUD8DrPo5sLBjY1AEK3J5UcNB1
         3X07sQks/Q4UdaDUktlwJC4wvWshRU1C7xV6Y3BjBguVhK4S1Uq+eTQC1B8hzAdyROTS
         /t6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749566833; x=1750171633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZPSJSobV+2clQAW57HhDQJrYIdKkViaMqsz2twW9aI=;
        b=UZed0Zs2AnJKh3q7p0LxF1IP0To0OFFijqETMWKSo/iMVbwjSyNyGamIbgXYAQ0tMe
         k3UGrCXLlSRWD6SYUgs4ooYDHLnaay3YVI/KS5U8C43VAxsnluBkjU/jnJ2hNLwRKb3u
         AszDIKeTUpiVFgbC3nISRMRBrChSVEzNZag0WXbnmycOtl8DJRrt1hy1c3yL2E+sN5nD
         BBp6m+QB8QqoNcQF9pCstmeDLI6A6Fz0TQl3e4MivVZ2x8006THB3KMt7+If0kq6rFrw
         lU5OKZQO1qrl3zUNrPKR1r6d4MGLxGit8mk2IBwbaQ7FPUS/pbzXbC2BkenYHwfkwg3d
         UShA==
X-Forwarded-Encrypted: i=1; AJvYcCXvDhTwbM9DEgRUrHoE4T2Y2aqY4wm1XEQT8p8mXc2DQQzPL610jiJNBXEpjFpefl5kf/Qejak=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqwbzdV2Uu49hheRjurVf5G+xZEb0ciW96sSJiki1tAYWajBqh
	Ty0+4PQoG8AN5spSaQkTx3p4G06h322EnrzYuKogWOZux+c4Q3lABDZNMlbD4754AGlw+7Zx1+B
	xoZZatSlcF7gdw2PQeJoj6sRh6L6KbEoz6xrbU2LK
X-Gm-Gg: ASbGnct/5BK8F00MrJJdCuDXvShrsX5mAZtu+CIeYIbKgWT8ugu99whv4sp1grS6Uk/
	5X4t080SsHkEdBat1boM8L+1pjxea9cXjV0+s8x+Td4omLWm9ers1pV4Juhecj/2+q6cLZfBRve
	OgL2r7lhjryJ9QJoKR75HdMFbkqCqM8zbvJJFAsC8duN4=
X-Google-Smtp-Source: AGHT+IHXh/T7TQqCEkwyyhG2DFteUT8YXPJnsgh6HCzHALaXsQIqBwNAJeluGWjNRQa7dqIuBvp0KPGecicwp689F7M=
X-Received: by 2002:a05:622a:114d:b0:4a2:719b:1238 with SMTP id
 d75a77b69052e-4a5b9a268f6mr308357231cf.12.1749566833287; Tue, 10 Jun 2025
 07:47:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aEdIXQkxiORwc5v4@slm.duckdns.org>
In-Reply-To: <aEdIXQkxiORwc5v4@slm.duckdns.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Jun 2025 07:47:02 -0700
X-Gm-Features: AX0GCFssQls_Gaij5ZeXP9fy9SKSORmaR_2shcb4agLN0_oDN8ItFdCW3VPHcfA
Message-ID: <CANn89iLan0LsN2X9RA-PkaQk+6EQJiFL0eCqQ5VsCCyU2r5gFg@mail.gmail.com>
Subject: Re: [PATCH RESEND net-next] net: tcp: tsq: Convert from tasklet to BH workqueue
To: Tejun Heo <tj@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jason Xing <kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 1:47=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> The only generic interface to execute asynchronously in the BH context is
> tasklet; however, it's marked deprecated and has some design flaws. To
> replace tasklets, BH workqueue support was recently added. A BH workqueue
> behaves similarly to regular workqueues except that the queued work items
> are executed in the BH context.
>
> This patch converts TCP Small Queues implementation from tasklet to BH
> workqueue.
>
> Semantically, this is an equivalent conversion and there shouldn't be any
> user-visible behavior changes. While workqueue's queueing and execution
> paths are a bit heavier than tasklet's, unless the work item is being que=
ued
> every packet, the difference hopefully shouldn't matter.

On a 100Gbit NIC and 32 TX queues, I see about 170,000 calls to
tcp_tsq_workfn() when the link is saturated.

Note that a tasklet could only be raised on the local cpu.
Switching to a work queue allows us to start the work on the cpu who
did the last xmit, thus reducing the load on the cpu servicing the NIC
irqs,
a bit like RFS does on the receive path.

I am tempted to say yes to your patch, hopefully we will not regress
if highprio user threads are competing with this work queue.

Reviewed-by: Eric Dumazet <edumazet@google.com>

