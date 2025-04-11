Return-Path: <netdev+bounces-181632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D00A85DFA
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 15:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEE4E7AE449
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 12:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EA82367D8;
	Fri, 11 Apr 2025 12:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CncDUBw/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C402367C9
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 12:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744376352; cv=none; b=ZrQJe5pu2Osf8qLP85I/uwBA8wNvPCRLKyHUCPinAN78n7vD7yrL0Ym4DAfOdDtrQHiRES8UOmfN58S8qDL4x8UqC1RJczUQrPDhweQgcohESNdOqsLP8ph9ia+yT2m7iKCygmzsyEUlHi4q/oSrkxaISY5fkKfvAcGKKRZX0Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744376352; c=relaxed/simple;
	bh=rY1UFxG66AZgsLjOZDqEKWwTBbAxmKs5ER3eJZuwnGA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZXWhBIZCRlh6HHr7vEIRDLxxjrWJYdW29IsNTY21f41tDx8oZfE73TvN1/DVJ6GUVCnWgqslFqZqMFZ2F+10+JOePzu6sJuND+w9SNXyTcwtD04jRbPqsyDGg1xxedYc1Sypw/2XbMn26tbc1ZnFeWVeE8QFQa9eG/qclzqbsEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=CncDUBw/; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac25d2b2354so318445266b.1
        for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 05:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1744376348; x=1744981148; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YSGIw4q8pstTZ6OBCwLFEQhJ8StUrT9v8m/BBXZBL8A=;
        b=CncDUBw/A4Kg04P7zM39ZFW7gZyxvSPni3Wfl/W9tfJkc4igXvyX+mJnbAR0NfLl4C
         DLdG2/XXKSRBLj7GQzSJBmnh1xwWcPvxfsqRUqsGb4ALr2AGUWg6r80JQMOFPNtJx8Wt
         2DErJAvjyP8BID0t/qKxVpjXVCt8z34FH1SN8s8IwHsUTPZ60Z+fHd6DrvoXjP0UI7qy
         RvKWR95JImXsWkPdf2bs+yHu8+fKgHjnF78g46ZSZcjR0ABT5uAfGoLb9tJxGolnGw88
         fT5z9wzH/XEM+ie9E2xSKZHiDddXMetEhfT3rF3vcT2XFXZWk0JoiPt2gcXmZHbKpF1E
         Z4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744376348; x=1744981148;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YSGIw4q8pstTZ6OBCwLFEQhJ8StUrT9v8m/BBXZBL8A=;
        b=asXqxr+tbMusyUChZLPORnt1TEOSYPBbVtkMGGJrXRoo6dr605la+Ob3R770c4/LUx
         UYlasv7FLkHFoyYAapzDvH64t+0ezApRP5JFzqI+SzXwpG1KY2Zzi7QeU58DRodi3roz
         4foig7Z3FnZNGAZb3iPcDSkJnFAPWziINfgzDN5z2WD29dbkYlYSKb8XGM95/A+kW5Kd
         Rn6UDhrxGlVk4QvY5rZT8ZFje4pFJU4kGRc9CzaK8kgidaGoRW+feKaQ24JaP1UZ7FXv
         phzvPs0RpEuQhZvCkz1CNdCgPzquS6+lzxGVn91cMNFmCAU16Qv/RTmgS4uFEvGenZKi
         SXTQ==
X-Gm-Message-State: AOJu0YyXnqpwQspM9wvolSybOQw2QMjz5kG0JzebRzsB9AfvCMgg5Dga
	X5K+yGen8PaNFVkyUJdLaqKV+P0w5AbQMlX9KJZuYf/McrB0WqWCUZ6SkWIY4EPpTRY4EY8cemQ
	i
X-Gm-Gg: ASbGncumry3suktX6AaSqVPg7Ip2QnZ6fr8WlcfEwK49B7vyqMN27XeGQvjUsCoDHeu
	XWjBjnhzP8jz/EjMSD3fJBAA+ItAgzxW7rwWlBIpdO4DsnGa5+4Li8XHoDTDB/wqzlQE+mKAqnx
	+98m/XiRCHV10Ut4uDWAKPCy34RPXnillD7NptEBJQifTDrt6NAlaYytWFHEtpZZXdFoghN58zw
	HnXTABZ/34Yn+AsHfDYBWETMEApPV3oAsRTtjvaQKqBkXFrwCsy3B3DGvhupq+OUe8Jp319JIMS
	+50ydl80ZMiW/a6qEIbwZXYM6mv+UMv3
X-Google-Smtp-Source: AGHT+IFUOH4el20wLJrnf4kez8QMAu2dwjSG3e+nwIJ6hcuc3ODkPFTqhx4cYs897gW+Rvgo+MBUiw==
X-Received: by 2002:a17:907:3cd4:b0:aca:d1db:9c63 with SMTP id a640c23a62f3a-acad3445ef8mr221448266b.5.1744376348155;
        Fri, 11 Apr 2025 05:59:08 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:506a:2387::38a:3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ccad01sm438171566b.125.2025.04.11.05.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 05:59:07 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org,  Jakub Kicinski <kuba@kernel.org>,
  bpf@vger.kernel.org,  tom@herbertland.com,  Eric Dumazet
 <eric.dumazet@gmail.com>,  "David S. Miller" <davem@davemloft.net>,  Paolo
 Abeni <pabeni@redhat.com>,  Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?=
 <toke@toke.dk>,
  dsahern@kernel.org,  makita.toshiaki@lab.ntt.co.jp,
  kernel-team@cloudflare.com
Subject: Re: [PATCH net-next V2 0/2] veth: qdisc backpressure and qdisc
 check refactor
In-Reply-To: <174412623473.3702169.4235683143719614624.stgit@firesoul> (Jesper
	Dangaard Brouer's message of "Tue, 08 Apr 2025 17:31:13 +0200")
References: <174412623473.3702169.4235683143719614624.stgit@firesoul>
Date: Fri, 11 Apr 2025 14:59:06 +0200
Message-ID: <87ecxyhn1h.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Apr 08, 2025 at 05:31 PM +02, Jesper Dangaard Brouer wrote:
> This series addresses TX drops observed in production when using veth
> devices with threaded NAPI, and refactors a common qdisc check into a
> shared helper.
>
> In threaded NAPI mode, packet drops can occur when the ptr_ring backing
> the veth peer fills up. This is typically due to a combination of
> scheduling delays and the consumer (NAPI thread) being slower than the
> producer. When the ring overflows, packets are dropped in veth_xmit().
>
> Patch 1 introduces a backpressure mechanism: when the ring is full, the
> driver returns NETDEV_TX_BUSY, signaling the qdisc layer to requeue the
> packet. This allows Active Queue Management (AQM) - such as fq or sfq -
> to spread traffic more fairly across flows and reduce damage from
> elephant flows.
>
> To minimize invasiveness, this backpressure behavior is only enabled when
> a qdisc is attached. If no qdisc is present, the driver retains its
> original behavior (dropping packets on a full ring), avoiding behavior
> changes for configurations without a qdisc.
>
> Detecting the presence of a "real" qdisc relies on a check that is
> already duplicated across multiple drivers (e.g., veth, vrf). Patch-2
> consolidates this logic into a new helper, qdisc_txq_is_noop(), to avoid
> duplication and clarify intent.
>
> ---
>
> Jesper Dangaard Brouer (2):
>       veth: apply qdisc backpressure on full ptr_ring to reduce TX drops
>       net: sched: generalize check for no-op qdisc
>
>
>  drivers/net/veth.c        | 49 ++++++++++++++++++++++++++++++++-------
>  drivers/net/vrf.c         |  3 +--
>  include/net/sch_generic.h |  7 +++++-
>  3 files changed, 48 insertions(+), 11 deletions(-)

This setup scenario is currently not covered by the veth selftest [1].
Would be great to extend it so the code gets exercised by the CI.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/tools/testing/selftests/net/veth.sh

