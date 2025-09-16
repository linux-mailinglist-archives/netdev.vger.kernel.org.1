Return-Path: <netdev+bounces-223423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F87B591B0
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 11:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12804323783
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 09:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7834E2BE033;
	Tue, 16 Sep 2025 09:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WiJiJ8ez"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AD52BE647
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 09:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758013370; cv=none; b=RH6F2d8cGFpmhNu3UbUPjplSCTRjJafyhSOCU9x5ZIOEVmrBbkBv3EHuQHDXp99bXOon8+lKZByxy9/jxasRpuV7+frZB1UhAhntiZD74SCjVJpHTUn+AXSYxBcO2nzNHW9TiNOmbi6HDt6GN9UG9OJm9WqKmoJyx1GowjsBiVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758013370; c=relaxed/simple;
	bh=td7bYrtv6Rwn2GRtyxdIXwTd2pmiU7NhvMWF7RjoEDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p1lW21dbJuMF2c+w9l5krUNqbn6P4Xkwca2lKJyfMwqOoGCdnL7LC7H/zUaq46UbGGRubvFteAqBbA6M5Ok7YkiguP58TrYT9aUXgXrVNq6i4bQqT2nV6toBMDyvDc2CcvyOYu6vVmB1ht5SOVLMYixya5OCQNw2TiQcuaTkaLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WiJiJ8ez; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b7a8c428c3so16227421cf.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 02:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758013366; x=1758618166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wi/d98DHMG6wh7bRs4e5xNC/g18rTej0hv0JpTAydJo=;
        b=WiJiJ8ezH+UdhR8Oo4ieYaj1hMSjGVEU/CMqtXlaP7P04hKnvk/5Sd5dHMfqmsNeMX
         ysTcL5ddub5MtaW3pAAJz1e3v4s1kjahECHlIH7/PVY6ENgfuqZCyszjn+v7YfTr3ajD
         l2IKVCGQ9tCKbk5Ss7j+GN8nppMduq4/+3QZ1hrpUpKkxTcW27XrhdIXpJ80nZ0yXmJV
         4ww3JUdH3WOrfAFTHI/nOwYyfphr1quyIW22CsLbuaftt2uoQYsjoHT+AB25c6yoLQhf
         oD9NZcyN42W3+LMTXvtzRn2SVYxvcs9Br4dqgMMBRGxwhOaZCso5DrEaypVO5qfaFv9K
         YvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758013366; x=1758618166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wi/d98DHMG6wh7bRs4e5xNC/g18rTej0hv0JpTAydJo=;
        b=dfd7HtJwbWlUKALwdFy0I8yxrTahtnkpiMG22MGemcNNhW1t6OveMQjaW/vPnlZtHU
         6NcoC24NmhB3bXWR1/zdUqEVWIXjNupD5PBqlCjeKjDTYoHTDSzoa3kHlWj86YPPsb+e
         AsR3vO+n+8KG404HwnbkEiC9fZtpUHh1EXx8TspBrDCtc/HYbEoJfVxH8z97WtjlWx8a
         juRHbC1EiynKda7s+1BdZA5dN47Z/+lwuSWqdwTJG/jPGyyhQACXC4NYbwYbxIwHbsvA
         VO3QiBClvU3lxLfPLZDJxwGTOpRAWLCNIYlavVL2OnDH91rorZj11IbMOD3T6kUBFrIs
         X8Lw==
X-Forwarded-Encrypted: i=1; AJvYcCXi2wDaKTbyYgFqhSRJ0Wq91d0guaZYDfzy2a8S0tLGW5OesaEeMy9Gz0Nye+jcX+zv9iwpz7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQWK2tmdZX3k1moIKpvjfJ1qSEShiZ+apQ3hr0k4ioUBmURqGi
	as/j6AxRhxf6zXdVHVcSQKKf2U6kWnpIwL0/338+Q5JBT49IQNaMHIl98l0Zq2dfTUTmERDpCLw
	Tu5XqeGAIx6wtxztmJKap2FV/q43npm8N/dUHTvdwr85VJr4jHyo5YSr6
X-Gm-Gg: ASbGncsRNBHZrW9xGnZW3ADE8PdqP0DGQzmhcFrPrFAXLpE7LVpU2tWBVlsFMouPTCg
	lABq4SVg0DMUEHI3InBkbMWcBeRRhZzlI7aUYmoZd5AjFD9EcDoddNcJLm32UZ4LrBTe7yyMc8Z
	vpUBDEe6ID2DqgsCqCtkpm1E0wENHz69b82l0u+BcFiA4Om6Mds32FCSWmTAzFYxs2suq3zrtS0
	ygZERUApQDepA==
X-Google-Smtp-Source: AGHT+IFIovBX782Z5yBcyo8CtjgTXkFmq5zeDrPbKqmkxhQ7ncp06FEyeAQNgtIkFlWoLQmvW0gxLKQfKWLfHqOgMZo=
X-Received: by 2002:a05:622a:1985:b0:4b5:781c:8841 with SMTP id
 d75a77b69052e-4b77d044711mr208451301cf.42.1758013365551; Tue, 16 Sep 2025
 02:02:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916064614.605075-1-xuanqiang.luo@linux.dev>
 <CANn89iLC6F3P6PcP4cKG9=f7+ymW1By1EyhFH+Q0V6V-xXn7jA@mail.gmail.com> <09d9a014-5687-4b60-9646-95c3644efe19@linux.dev>
In-Reply-To: <09d9a014-5687-4b60-9646-95c3644efe19@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 16 Sep 2025 02:02:34 -0700
X-Gm-Features: AS18NWDjHt3GtOSKE3gkuM542GV43he6o7sYGtn_lSeECB9bFOB0FpWsmgI1Wnw
Message-ID: <CANn89iKHr_cxcsPG0Oy7SJ9jyZS5zRAgPZL_wy8PSighy+Cy6A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/3] net: Avoid ehash lookup races
To: luoxuanqiang <xuanqiang.luo@linux.dev>
Cc: kuniyu@google.com, kerneljasonxing@gmail.com, davem@davemloft.net, 
	kuba@kernel.org, netdev@vger.kernel.org, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 1:12=E2=80=AFAM luoxuanqiang <xuanqiang.luo@linux.d=
ev> wrote:
>
>
> =E5=9C=A8 2025/9/16 15:30, Eric Dumazet =E5=86=99=E9=81=93:
> > On Mon, Sep 15, 2025 at 11:47=E2=80=AFPM <xuanqiang.luo@linux.dev> wrot=
e:
> >> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> >>
> >> After replacing R/W locks with RCU in commit 3ab5aee7fe84 ("net: Conve=
rt
> >> TCP & DCCP hash tables to use RCU / hlist_nulls"), a race window emerg=
ed
> >> during the switch from reqsk/sk to sk/tw.
> >>
> >> Now that both timewait sock (tw) and full sock (sk) reside on the same
> >> ehash chain, it is appropriate to introduce hlist_nulls replace
> >> operations, to eliminate the race conditions caused by this window.
> >>
> >> ---
> >> Changes:
> >>    v2:
> >>      * Patch 1
> >>          * Use WRITE_ONCE() to initialize old->pprev.
> >>      * Patch 2&3
> >>          * Optimize sk hashed check. Thanks Kuni for pointing it out!
> >>
> >>    v1: https://lore.kernel.org/all/20250915070308.111816-1-xuanqiang.l=
uo@linux.dev/
> > Note : I think you sent an earlier version, you should have added a
> > link to the discussion,
> > and past feedback/suggestions.
> >
> > Lack of credit is a bit annoying frankly.
> >
> > I will take a look at your series, thanks.
>
> This patch's solution isn't very related to previous ones, so I didn't
> include prior discussions.

This is completely related, aiming to fix the same issue, do not try
to pretend otherwise.

Really, adding more context and acknowledging that reviewers
made suggestions would be quite fair.

This is a difficult series, with a lot of potential bugs, you need to bring
us on board.

