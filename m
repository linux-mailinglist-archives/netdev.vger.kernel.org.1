Return-Path: <netdev+bounces-191551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAFBABC11F
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 16:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4C59188C633
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 14:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A626927FD71;
	Mon, 19 May 2025 14:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KuXirE3t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238512797B0
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 14:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747665762; cv=none; b=oQhm1Ks7KvLOWRfW+8Tt6UUqp+SK3w6GczTDa60ICc5up3ezREW7dhkytLmxaInnnq1p3wqv4lhV/JnXfBKQzFM4qhT0o2G8/53MB3KMzOdCGRbII3JJ1LcMYETYOFqkqRbq4Pf3P5u4/1WSKcQn5ryCE2yyWqk8ajZp49rjW4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747665762; c=relaxed/simple;
	bh=WimnWdvpT8uyHGBWMM4RfnRiNuVFbHk3iZJ90sTawMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OMgvYXqTRLPkrbvHH31s78JhulTvylca9XhoCWB3atzp5t19ghqhN3cx7tLkjxjS5Jys4SAGRoWrwi1Zf2vTeTQJPA0howPhGwHjHWAUPiefPNwRgaOO6SzHY51Lcvhtl1LyknI3ZY8XNtm3acn1WjWMwOD8/p18SOvKuQ+ZN08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KuXirE3t; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3dc77edaa4aso70325ab.1
        for <netdev@vger.kernel.org>; Mon, 19 May 2025 07:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747665760; x=1748270560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmYRnRdmFmJki7g87U395m8T1NZ/Fl4k2+oynLtdog4=;
        b=KuXirE3tTQJeyO4AnfHJJ6tabf2kYdc+pg7izm2Wq+7atLbq1HZr1ssmE4yp8d/1NC
         tQNNNxypETLSPewx9gJDI870pk0Z/E/rHaRNJAIqopsUtX7rqEZknkRICNh5i50xA3+1
         SrmhLeS8h4Qv2TnqlEif5dwKx5A4JDKKTVZ34RbbA8l97dUoPUrOTkQvjJffgVGlxtCN
         4Q0H3WKUibJtE6Xm60Tqd6xRbX2brmzHViyWXCkNY/P8iIJYSUM6TsiwBEFIW6C2BduH
         W7u8mDgAclupqNQ6Aqs08LTy84r7JywZo6z9Cww8BWjuOpwCQnzn0Ir02xP2R/wQLJVr
         rYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747665760; x=1748270560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nmYRnRdmFmJki7g87U395m8T1NZ/Fl4k2+oynLtdog4=;
        b=syB0WxQv8B6TM5ZnPFOmhjgZB6bmZiZYZQLcrIKj24MUSJ+N8s0FstSu/OWNFQML4e
         WYGGki64rU7TiyAbqK377rbSOeIxMjhhzbpWZswKUk5AWZSdgE2Sx8gtwi0Ew0TLUZ7y
         If+rpfk4DabE96SiG2ykAn/r8q6zPpmiyZXS60ABSpKSwU6mqKIzLo/99yrFywHezeyv
         nmVP1VMd6n/Fm/mqKPGPhgxOWivCQG0vdDYyCZsMEcJ5YHP/zn573fNWDh9GqFoqNarO
         Z7PobK1dr7gKoWPAI5eFPL3Cr5XlLEYf3c3N2wTyyCVl62rVBjaScr5JzXJbsCjT8Ndm
         9AqA==
X-Gm-Message-State: AOJu0Yx5JO5d0Nn6wgqvqiRM40wb0jly/CcYpPbpXHwLTDrrYsgBJvp6
	55bMONujHlJZzB4AexXcMvMbXuD7AOn/djpFTZuhSjlJCL5FH2H4ZkY7qFY0piMhEu5zxsVxm7x
	ci5VZ45KWjRlJWZiwvP9rqDh/+M5OeJgEiHcHJCSUbuiSRx3yBuBh+/fedqY=
X-Gm-Gg: ASbGncvZnci/t++LQBhQ/+Pt6F4nvmJfCEj9lL/fU0oOC6VoWuREwj4KNg4nE+28vSd
	AZfUzmqmkoq5QpGRVKHxAM8d/k9ppTCObo1eAaHRhkZLBDMHZn4ilccGeWquBnO+/6LoRJYLTxs
	T+SrmIo+iV9hME/om1p2bBNDd+U7HPM4LPjw1Oc5R4JvJ/GTtTOrP49eoqXQl1jQr0GQPgZfG4b
	m1L
X-Google-Smtp-Source: AGHT+IEE7ggtSshKtQJiHnrAQKrOhJQthk3yv4LhwRx/Yn0eHMx8HUalTBz7vA2IErIxqGcyLXZjS/y7Z3GRBdYJDpg=
X-Received: by 2002:ac8:5f83:0:b0:476:f4e9:3152 with SMTP id
 d75a77b69052e-49601369b34mr6860671cf.25.1747665747668; Mon, 19 May 2025
 07:42:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAHxn9-ctPXJh1jeZc3bYeNod6pdfd6qgYWuXMb9uN_12McPAQ@mail.gmail.com>
In-Reply-To: <CAAHxn9-ctPXJh1jeZc3bYeNod6pdfd6qgYWuXMb9uN_12McPAQ@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 19 May 2025 10:42:11 -0400
X-Gm-Features: AX0GCFsi_tK_K8KDkFMzUtKwu0QFEf4-oIvOWiHm5Mj1xqVLcCa7QIx7DfGXzo0
Message-ID: <CADVnQy=RRLaTG4t5BqQ1XJskb+oxWe=M_qY0u9rzmXGS1+b7nQ@mail.gmail.com>
Subject: Re: tcp: socket stuck with zero receive window after SACK
To: Simon Campion <simon.campion@deepl.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Yuchung Cheng <ycheng@google.com>, Kevin Yang <yyd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 9:31=E2=80=AFAM Simon Campion <simon.campion@deepl.=
com> wrote:
>
> Hi all,
>
> We have a TCP socket that's stuck in the following state:
>
> * it SACKed ~40KB of data, but misses 602 bytes at the beginning
> * it has a zero receive window
> * the Recv-Q as reported by ss is 0
>
> Due to the zero window, the kernel drops the missing 602 bytes when
> the peer sends them. So, the socket is stuck indefinitely waiting for
> data it drops when it receives it. Since the Recv-Q as reported by ss
> is 0, we suspect the receive window is not 0 because the owner of the
> socket isn't reading data. Rather, we wonder whether the kernel SACKed
> too much data than it should have, given the receive buffer size, not
> leaving enough space to store the missing bytes when they arrive.
> Could this happen?
>
> We don't have a reproducer for this issue. The socket is still in this
> state, so we're happy to provide more debugging information while we
> have it. This is the first time we've seen this problem.
>
> Here are more details:
>
> # uname -r
> 6.6.83-flatcar

Thanks for the detailed report!

Can you please attach the output of the following command, run on the
same machine (and in the same network namespace) as the socket with
the receive buffer that is almost full:

  nstat -az > /tmp/nstat.txt

This should help us get a better idea about which "prune" methods are
being tried, and which of them are failing to free up enough memory.

Thanks!
neal

