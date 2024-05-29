Return-Path: <netdev+bounces-99092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 077768D3B74
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 17:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 691C6B23E03
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 15:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927F015B115;
	Wed, 29 May 2024 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYwVYtGD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2D514291E
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716997985; cv=none; b=XYvwUYbCrJlmIZEwKotc//+LAfou6PacH5598Wj5pJISMZDLb8M/QmHvT/Y/zswRZHEMgCu4/UFSaPASYaVig90fdV+KzLgwDl+5UWlNfbPl0/Ev4cKTMhkp8GUudos+U6bYTlEYAgbrBXEhW41os6ZKqSiv25SdRqgl9LfIyfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716997985; c=relaxed/simple;
	bh=pTXzUY+x5540F/EM1XdqGEAzJ0Mo0QFOIk8WHESo8Go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AKkfo0s18b+aWDWnTJXfI6kZQwgQOE8jnm93koH8ZQROZLvOIJfjwrrfaoKkbhGLFMuJMqbycDuBS4bascWEKRmYKw3h5Co7rH3wwtQcGPQlZgvGTIdDwAi/LrD7t48ODD2WJVkI8Dlz3ogYqhwxLI6Y/CmXEaWnfs+BWRM4r0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYwVYtGD; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52ab11ecdbaso1252762e87.3
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 08:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716997982; x=1717602782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5xYzN9ZtCnOygYwo3Tn5BQN4a3URtOTpcLJi5hO3zs=;
        b=EYwVYtGDIF14xM6t5pNTrXFPEQQMJZ7mHwUtYYF9JeUhNOHDCs2roIZV2wmnEgA/87
         ZUbwTDKcDTxhiknbqeSVgvDd1CvsKGshy8sdj/pD3NtHd3b/7p5MahRd0n/0Wo/ZiWk5
         mNxWGTBKL6fayELCpK/+c/cwSUEuKYkObZwKFvDCKX16mnt7hOTlAxiWZbBoMuAVCE4H
         N5/21UhAO8xj/fvA+9JONrWLd7Bx3/a1xUZhZG4n7O8wfT2onfLaoQ18+Hsp5F8zfxdJ
         GWD0CwffhuCGMyUlXNzcG7EpVeMBGFPn8h2SD6q0TpHxOWDxSnvTCZFr+eo9NSV+/eRi
         F1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716997982; x=1717602782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5xYzN9ZtCnOygYwo3Tn5BQN4a3URtOTpcLJi5hO3zs=;
        b=f7n4YAAVqMdhSYt6ZU8ICodnHwoQo+VXlBqFACmOeOnrdQDyN78/KUakj5BAH6pED5
         Gwewbr0h2IIQDH+gvvLgUvcy5O0rPw+Ql+q2noNWNSUDhfLyrS2MPs9vy2ex/etGPV9/
         YWB236lIbj0RvpryPOf5QzPC6qwPQnH8STGNMhYJDol+JEbTwSKhE8flF9GnNqmMPqRR
         GNH3srS624Epj5W2yGMPcahsWZS0Aa8b9eYZXCezVNxPG9PDBk3+z0p1WeklSAsB/z0+
         vQCq0e/9/Wpu1X4iS85CrQ8d3Y2NIlhw528k9Dnjmok814kb5eogNMdXuO2hNPA25IL1
         xSFA==
X-Forwarded-Encrypted: i=1; AJvYcCU1eSpf+6ykqZ3hweQMF8t33WK3BKgDYz6FAVECRwQe5a7b3y5zEjWoaoCDxC9agXFpF2549gMMjvsG0SkWjznNijwLBfPh
X-Gm-Message-State: AOJu0YxRBFriGZgbwrRLOi6nxUEI/nRiCK+58ziL3rMTt3rfOk3Bgkxp
	AO7IgZzRlpnY2aYg6Qi+U8ETNhKA1JK3hTiRPKR5MrdeKVXq6ffR9egCNeU6Ysz2YECOE/8YoDg
	XQqMZ5hklB+anEs76h5CHxYE9ZoE=
X-Google-Smtp-Source: AGHT+IHocWeGcVW4GkZh74yu2gXlhWNsA7NeFKQNt/c2hFTNYOM6VyJbCm1xlaykIIS+Pd+VpkOzFXpQEPL+KrHNpno=
X-Received: by 2002:ac2:4db6:0:b0:529:ac38:a160 with SMTP id
 2adb3069b0e04-529ac38a434mr6222738e87.34.1716997981813; Wed, 29 May 2024
 08:53:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529033104.33882-1-kerneljasonxing@gmail.com> <CANn89iJ93U8mxLXXuk=nT83mox1FHue+OPCkqBJ1FnHM5N9DHQ@mail.gmail.com>
In-Reply-To: <CANn89iJ93U8mxLXXuk=nT83mox1FHue+OPCkqBJ1FnHM5N9DHQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 29 May 2024 23:52:25 +0800
Message-ID: <CAL+tcoCcNGVkxVapYTVy1yx3OJep5uZaD+yqJGdVoriutUmLqQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] tcp: introduce a new MIB for CLOSE-WAIT sockets
To: Eric Dumazet <edumazet@google.com>
Cc: dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yongming Liu <yomiliu@tencent.com>, 
	Wangzi Yong <curuwang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Eric=EF=BC=8C

On Wed, May 29, 2024 at 11:42=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, May 29, 2024 at 5:31=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > CLOSE-WAIT is a relatively special state which "represents waiting for
> > a connection termination request from the local user" (RFC 793). Some
> > issues may happen because of unexpected/too many CLOSE-WAIT sockets,
> > like user application mistakenly handling close() syscall. It's a very
> > common issue in the real world.
> >
> > We want to trace this total number of CLOSE-WAIT sockets fastly and
> > frequently instead of resorting to displaying them altogether by using:
> >
> >   ss -s state close-wait
> >
> > or something like this. They need to loop and collect required socket
> > information in kernel and then get back to the userside for print, whic=
h
> > does harm to the performance especially in heavy load for frequent
> > sampling.
> >
> > That's the reason why I chose to introduce this new MIB counter like
> > CurrEstab does. With this counter implemented, we can record/observe th=
e
> > normal changes of this counter all the time. It can help us:
> > 1) We are able to be alerted in advance if the counter changes drastica=
lly.
> > 2) If some users report some issues happening, we will particularly
> > pay more attention to it.
> >
> > Besides, in the group of TCP_MIB_* defined by RFC 1213, TCP_MIB_CURREST=
AB
> > should include both ESTABLISHED and CLOSE-WAIT sockets in theory:
> >
>
> We (Neal and myself) prefer to fix TCP_MIB_CURRESTAB to include
> CLOSE_WAIT sockets.
> We do not think it will annoy anyone, please change tcp_set_state() accor=
dingly.

Thanks for your reply. Honestly, I was worried about what you said.
Now, I'm relieved.

It seems that I should add a Fixes: tag...

>
> Rationale is that adoption of a new MIB in documentations and various
> products will take years.
>
> Also make a similar change for mptcp.

I will check that part tomorrow morning, too.

Thank you :)

Jason

