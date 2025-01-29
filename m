Return-Path: <netdev+bounces-161536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03518A2221A
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 17:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 586473A2E77
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 16:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831411DF75C;
	Wed, 29 Jan 2025 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AQgD/HDb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21A01DF255
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 16:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738169410; cv=none; b=oxbC5acxvnl4kU2tNEA6+/i+uPMVEgYl92zxxVb30yH/1XYtPtSK12MCIdl4+AFasGEOYC/9ShEIg+4wpOGxJusSf4w6f57UNpBf7iJrDJ/UoIcPgvdqqXZvevnYzSsT2sjcJpGyss/C0Qs1IDOjhGl9/gojDQu9umoRBgcWqoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738169410; c=relaxed/simple;
	bh=icky5A8lxT+Wd2DlxTPeXZcrZfgs8ZiQeIrXrrowRc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1BgQNh81hvadSM3rlparGDOqPXbB0a+0p2/Lrhv+bb8Fe2FejvAVudnm64NCOPBhKM3bwGHLRzAoyVa9AMhMkZMwSDOSCI8l21fLwz8wMYLv1qICxead0/Hm4CLVzsm0cdrj9xigjuOUPd08n/MBGOef3hlVDSL458Zgt2eQEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AQgD/HDb; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3d143376dso9819342a12.3
        for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 08:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738169406; x=1738774206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icky5A8lxT+Wd2DlxTPeXZcrZfgs8ZiQeIrXrrowRc8=;
        b=AQgD/HDbixKO3I/MNUi2Ukp0QMaigLRqqnYkHdOD+2YrWRgo2uoQc9Tme7vw3mrCFh
         ijzLBcZQe7yrsBEvaVlUohfDFHiPMJTIoz80nCTCDwiv5xRAdLHOcGVI1E4XiVnvd+zZ
         ZiNqDiTtxeAOBTYeb46Q4hamqmmFB97TRRTxqu7Yd53wfwi6Jtq8HbaENxnPjU+A5/F6
         dynPNjMk0oBk/iENvp+W5mG10IhQ1cNgbEGJTMn7HitM9cH6FfqVcoovrvu0LYaeFVG0
         AtActnjNKQhO+6Weg1hP3ECRAB+wDJpMtDf/dmpvm+8xEWAPGp7wc4zIj25xbYQvROiT
         OwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738169406; x=1738774206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icky5A8lxT+Wd2DlxTPeXZcrZfgs8ZiQeIrXrrowRc8=;
        b=pDRYEiMOkbwNNhcZhoE6UI1BEiVg9AV/PVolQHbPbZDfoKGLGXa8De2tPj5lDWwTJS
         lw+R3KC6TIVzXxCfG5v1OkBPafjjgeHdV81pvtPkUBjLC92mKB8riaRCXmWQkiv2X4d0
         7fnnvmspPx0nXgJ+/V9kC5XfbJeGNHAukRHR26UwhHet0mezDKgzajMSe42y6/t8jVDU
         kzJ94iy0/HYtDOlcxl0Cb1fUgb0jgPMPGbGFLJEx+lTfK6w5Z0rRCh54wE4O0HxpXETl
         DwtcwzVCAqRdINNnoiIh9yU6CAVia61KFO4TSgQePfyBSFgEW/qUJIBjDcAWlW1a29wl
         dnFA==
X-Forwarded-Encrypted: i=1; AJvYcCWI0xISkDm35uXjZU/oY8Sg1J/9TmBYogICkszeZTG88yrYpSpX5GM5QQMH3yvyoNCno5n5FnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Cxm0DGVA/M5KH4qxmKh8V0ZoSnLx9PJcDCx1mj8jAj8leW1I
	Gk7jnKxVfAlwD+fgbtNnrgsp5E9DavVmzaYob00EwdRDMhu6STfIN12fHP3UkG2flqg8ubS/SKC
	ufpN2ngXZdbdauZ9Spq9ysavUb8AT8crpOPkE
X-Gm-Gg: ASbGnctYU1T3z1ELZ/1ViDNzpbpQywmkKrGFhsl7Xb0whxoIGuMfMtYrF7JuzJVPBVQ
	NVmWdYZ6T9qNLQkKhgjgjpXBeUvi/jREOHzqwwYg07GqF2Gtt22KdSLITHJgg2A7bvIo/aALYTw
	==
X-Google-Smtp-Source: AGHT+IFGd6wu4wlEBzchtfM0LWUPMt8300mB6lrGxWEG6Na5G/QuwpEBTEqS572WSGPsz1dPpEVyUwA+lV3iuN9RTn8=
X-Received: by 2002:a05:6402:1ec9:b0:5d0:e410:468b with SMTP id
 4fb4d7f45d1cf-5dc5efa8adamr3525986a12.2.1738169406103; Wed, 29 Jan 2025
 08:50:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115185937.1324-1-ouster@cs.stanford.edu> <20250115185937.1324-6-ouster@cs.stanford.edu>
 <1c82f56c-4353-407b-8897-b8a485606a5f@redhat.com> <CAGXJAmwyp6tSO4KT_NSHKHSnUn-GSzSN=ucfjnBuXbg8uiw2pg@mail.gmail.com>
 <2ace650b-5697-4fc4-91f9-4857fa64feea@redhat.com> <CAGXJAmxHDVhxKb3M0--rySAgewmLpmfJkAeRSBNRgZ=cQonDtg@mail.gmail.com>
 <9209dfbb-ca3a-4fb7-a2fb-0567394f8cda@redhat.com> <CAGXJAmyb8s5xu9W1dXxhwnQfeY4=P21FquBymonUseM_OpaU2w@mail.gmail.com>
 <13345e2a-849d-4bd8-a95e-9cd7f287c7df@redhat.com> <CAGXJAmweUSP8-eG--nOrcst4tv-qq9RKuE0arme4FJzXW67x3Q@mail.gmail.com>
In-Reply-To: <CAGXJAmweUSP8-eG--nOrcst4tv-qq9RKuE0arme4FJzXW67x3Q@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 Jan 2025 17:49:55 +0100
X-Gm-Features: AWEUYZmLbfhfMKwdgjYo-t6NbBabYcSwHp6t2GlLNZ8HoaUcNrwS7OfIOqaYpQI
Message-ID: <CANn89iL2yRLEZsfuHOtZ8bgWiZVwy-=R5UVNFkc1QdYrSxF5Qg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 05/12] net: homa: create homa_rpc.h and homa_rpc.c
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: Paolo Abeni <pabeni@redhat.com>, Netdev <netdev@vger.kernel.org>, 
	Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 5:44=E2=80=AFPM John Ousterhout <ouster@cs.stanford=
.edu> wrote:
>
> GRO is implemented in the "full" Homa (and essential for decent
> performance); I left it out of this initial patch series to reduce the
> size of the patch. But that doesn't affect the cost of freeing skbs.
> GRO aggregates skb's into batches for more efficient processing, but
> the same number of skb's ends up being freed in the end.

Not at all, unless GRO is forced to use shinfo->frag_list.

GRO fast path cooks a single skb for a large payload, usually adding
as many page fragments as possible.

