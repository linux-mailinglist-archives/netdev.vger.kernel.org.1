Return-Path: <netdev+bounces-208511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51971B0BE77
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 10:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09253B8E83
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 08:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937F927FB35;
	Mon, 21 Jul 2025 08:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3l54kKyn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADB06AA7
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 08:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753085675; cv=none; b=ltxU33XlUYl3OrDydk901YhegbsSpWZmnbiZQmizNZ5wXVEO3eU3UFSXuhIZFWca7W806Of7f8RVMzf4I7cmdwVk7pFCsOXEld+URY+rEQPk05zZXqbcMaCj6+oKFDK/CTMdGcXaRGm+CmqBSx4/TcaMSRjMvd16sua6u7pC6NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753085675; c=relaxed/simple;
	bh=pW0qETiIQw1D5muDfP7bwS8CLenuuizEEZwsPbZ503U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ppQXYLngZ+wWD/8cymfAf3jwUaE+HLd7Rb6WI/18jLtBnJD/75ZsYQbvhWVqubhIc/XlQ7F73zIBwx+TwNkKgF9oSoXOKUsudvM+XA9kQ7kggOFY40pdkguJ2O1SUHi7dI5RfSKEvWQPI3i5iiBMFjJculRoXWMzXeH96WA243A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3l54kKyn; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ab3802455eso54125261cf.2
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 01:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753085672; x=1753690472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNUPEajHVMRiIbWzvjkM4WeBR9QPlI6IXPQ2yZG2izY=;
        b=3l54kKynXoZJOmcZnkC0mmoYomjVKMJO47fn4fUfTgRVAAzvIfhHF1KLTgwRkEu2Cs
         w7Bb2EVLmkXDmAa5Q+rrBQVMUlh+YkK81cRbq+56nsbjPamJICn1lhgaASqx8QGcWtg9
         cGjLamcxyWKfrOLDRBSicdf9DsP9tIUvagdH8iiPEsrwS7P6mNYMxZ/QTHnPhzhNhZmC
         GoP6oPg00j1hFCpixjQtNizleEQaqop/3Fepn4jz2xp1hNk6Ac4D31sqx8IjsVTS7HUu
         c1zomlDtEK1WyOwt8Cm9WW9lws68smP3dKLpk0ZYUqxPMLU7TqTnBMJGaYB8+chAAxJd
         7rbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753085672; x=1753690472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PNUPEajHVMRiIbWzvjkM4WeBR9QPlI6IXPQ2yZG2izY=;
        b=pz4nVtpngND0ds65X8Gi3PBJoCmtceB9S67PVa8YYtirFgRB/pmOfO8oOQubIZOhut
         +/qi/UI2OdDZ5jmOLcburJZgBqx/AP+QETfSvYr/wivPaYMvIJSTOxAKhxQy3FEXqYja
         BukBs7lNVq3U4WWkV5qlxr1aa1eT1huDI85wn88fxRD+7SPL1vsiAHEdoz9SgLVc63GP
         JSTV0H68g5a+6UoRVPlpT9lPPZOF9iuIZszvNKRRvpSgAbfybkn8DnLCOvwoUoPZrZxQ
         MgMkA/AZJu792/nITxXySoR0A8gQi19o9E3IcQcJAszR10i2aVkyZdA6M+hjtZpfivG2
         rJYQ==
X-Gm-Message-State: AOJu0YxPXF/u64ucSKSHRsRVIZDVrG4IrpsXdEtTiryhqNsIpyuzQJBF
	L09FuZCWYhbwYUAFSVjGfCB1qu+yS78dF+D5ttj3dA0UJ9DBMZbwY1yR7xM4371OMfj+kdZNIQA
	bQ+2iMIhVm8dl68xEDGpg3u1UXPat0b+QSTt1vTbT
X-Gm-Gg: ASbGnctiodM/3JFuRVVU5asxlzEVu/YBjHZoDj5cNu5hpRFZQjYAM9noKKBru6Uc0jB
	rFCY/ebQE7xmaLoNTderhw8c8sLrHiDfneM8JMFK8slfD/gGlecVRmFQ9Y4bUdOAFF5Q1euzgQj
	6xb+P+esJW2791IBqfYzh1L1VgSd3i4AYjKHFt/E1IJTg8Oox8I4pVAvCfte5EY6Tg+WbSIzwyA
	U+qQX6x/Go57CfSzQ==
X-Google-Smtp-Source: AGHT+IGIt+5SfkBnwLgrlBp9JhHLD19PCy815ifKK8/b5FnvkZmMKW6mQFNjAlrKvHPtzIl0F4blb9dNu3TgThgDq1w=
X-Received: by 2002:a05:622a:1903:b0:4ab:644b:885c with SMTP id
 d75a77b69052e-4aba3c8e398mr184000851cf.12.1753085672147; Mon, 21 Jul 2025
 01:14:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721031609.132217-1-krikku@gmail.com> <20250721031609.132217-2-krikku@gmail.com>
In-Reply-To: <20250721031609.132217-2-krikku@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 21 Jul 2025 01:14:20 -0700
X-Gm-Features: Ac12FXyZJrZGaumCP9z5fr5wrg0JKjrf7416cz9mK6MYHJ3qW-0feJva5cQC_WY
Message-ID: <CANn89i+vhTeqgTPr+suupJNLMHp-RAX89aBrFhiQnu58233bAw@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 1/2] net: Prevent RPS table overwrite for
 active flows
To: Krishna Kumar <krikku@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, tom@herbertland.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, 
	kuniyu@google.com, ahmed.zaki@intel.com, aleksander.lobakin@intel.com, 
	atenart@kernel.org, jdamato@fastly.com, krishna.ku@flipkart.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2025 at 8:16=E2=80=AFPM Krishna Kumar <krikku@gmail.com> wr=
ote:
>
> This patch fixes an issue where two different flows on the same RXq
> produce the same hash resulting in continuous flow overwrites.
>
> Flow #1: A packet for Flow #1 comes in, kernel calls the steering
>          function. The driver gives back a filter id. The kernel saves
>          this filter id in the selected slot. Later, the driver's
>          service task checks if any filters have expired and then
>          installs the rule for Flow #1.
> Flow #2: A packet for Flow #2 comes in. It goes through the same steps.
>          But this time, the chosen slot is being used by Flow #1. The
>          driver gives a new filter id and the kernel saves it in the
>          same slot. When the driver's service task runs, it runs through
>          all the flows, checks if Flow #1 should be expired, the kernel
>          returns True as the slot has a different filter id, and then
>          the driver installs the rule for Flow #2.
> Flow #1: Another packet for Flow #1 comes in. The same thing repeats.
>          The slot is overwritten with a new filter id for Flow #1.
>
> This causes a repeated cycle of flow programming for missed packets,
> wasting CPU cycles while not improving performance. This problem happens
> at higher rates when the RPS table is small, but tests show it still
> happens even with 12,000 connections and an RPS size of 16K per queue
> (global table size =3D 144x16K =3D 64K).
>
> This patch prevents overwriting an rps_dev_flow entry if it is active.
> The intention is that it is better to do aRFS for the first flow instead
> of hurting all flows on the same hash. Without this, two (or more) flows
> on one RX queue with the same hash can keep overwriting each other. This
> causes the driver to reprogram the flow repeatedly.
>
> Changes:
>   1. Add a new 'hash' field to struct rps_dev_flow.
>   2. Add rps_flow_is_active(): a helper function to check if a flow is
>      active or not, extracted from rps_may_expire_flow().
>   3. In set_rps_cpu():
>      - Avoid overwriting by programming a new filter if:
>         - The slot is not in use, or
>         - The slot is in use but the flow is not active, or
>         - The slot has an active flow with the same hash, but target CPU
>           differs.
>      - Save the hash in the rps_dev_flow entry.
>   4. rps_may_expire_flow(): Use earlier extracted rps_flow_is_active().
>
> Testing & results:
>   - Driver: ice (E810 NIC), Kernel: net-next
>   - #CPUs =3D #RXq =3D 144 (1:1)
>   - Number of flows: 12K
>   - Eight RPS settings from 256 to 32768. Though RPS=3D256 is not ideal,
>     it is still sufficient to cover 12K flows (256*144 rx-queues =3D 64K
>     global table slots)
>   - Global Table Size =3D 144 * RPS (effectively equal to 256 * RPS)
>   - Each RPS test duration =3D 8 mins (org code) + 8 mins (new code).
>   - Metrics captured on client
>
> Legend for following tables:
> Steer-C: #times ndo_rx_flow_steer() was Called by set_rps_cpu()
> Steer-L: #times ice_arfs_flow_steer() Looped over aRFS entries
> Add:     #times driver actually programmed aRFS (ice_arfs_build_entry())
> Del:     #times driver deleted the flow (ice_arfs_del_flow_rules())
> Units:   K =3D 1,000 times, M =3D 1 million times
>
>   |-------|---------|------|     Org Code    |---------|---------|
>   | RPS   | Latency | CPU  | Add    |  Del   | Steer-C | Steer-L |
>   |-------|---------|------|--------|--------|---------|---------|
>   | 256   | 227.0   | 93.2 | 1.6M   | 1.6M   | 121.7M  | 267.6M  |
>   | 512   | 225.9   | 94.1 | 11.5M  | 11.2M  | 65.7M   | 199.6M  |
>   | 1024  | 223.5   | 95.6 | 16.5M  | 16.5M  | 27.1M   | 187.3M  |
>   | 2048  | 222.2   | 96.3 | 10.5M  | 10.5M  | 12.5M   | 115.2M  |
>   | 4096  | 223.9   | 94.1 | 5.5M   | 5.5M   | 7.2M    | 65.9M   |
>   | 8192  | 224.7   | 92.5 | 2.7M   | 2.7M   | 3.0M    | 29.9M   |
>   | 16384 | 223.5   | 92.5 | 1.3M   | 1.3M   | 1.4M    | 13.9M   |
>   | 32768 | 219.6   | 93.2 | 838.1K | 838.1K | 965.1K  | 8.9M    |
>   |-------|---------|------|   New Code      |---------|---------|
>   | 256   | 201.5   | 99.1 | 13.4K  | 5.0K   | 13.7K   | 75.2K   |
>   | 512   | 202.5   | 98.2 | 11.2K  | 5.9K   | 11.2K   | 55.5K   |
>   | 1024  | 207.3   | 93.9 | 11.5K  | 9.7K   | 11.5K   | 59.6K   |
>   | 2048  | 207.5   | 96.7 | 11.8K  | 11.1K  | 15.5K   | 79.3K   |
>   | 4096  | 206.9   | 96.6 | 11.8K  | 11.7K  | 11.8K   | 63.2K   |
>   | 8192  | 205.8   | 96.7 | 11.9K  | 11.8K  | 11.9K   | 63.9K   |
>   | 16384 | 200.9   | 98.2 | 11.9K  | 11.9K  | 11.9K   | 64.2K   |
>   | 32768 | 202.5   | 98.0 | 11.9K  | 11.9K  | 11.9K   | 64.2K   |
>   |-------|---------|------|--------|--------|---------|---------|
>
> Some observations:
>   1. Overall Latency improved: (1790.19-1634.94)/1790.19*100 =3D 8.67%
>   2. Overall CPU increased:    (777.32-751.49)/751.45*100    =3D 3.44%
>   3. Flow Management (add/delete) remained almost constant at ~11K
>      compared to values in millions.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507161125.rUCoz9ov-lkp@i=
ntel.com/
> Signed-off-by: Krishna Kumar <krikku@gmail.com>
> ---
>  include/net/rps.h    |  5 +--
>  net/core/dev.c       | 82 ++++++++++++++++++++++++++++++++++++++++----
>  net/core/net-sysfs.c |  4 ++-
>  3 files changed, 81 insertions(+), 10 deletions(-)
>
> diff --git a/include/net/rps.h b/include/net/rps.h
> index d8ab3a08bcc4..8e33dbea9327 100644
> --- a/include/net/rps.h
> +++ b/include/net/rps.h
> @@ -25,13 +25,14 @@ struct rps_map {
>
>  /*
>   * The rps_dev_flow structure contains the mapping of a flow to a CPU, t=
he
> - * tail pointer for that CPU's input queue at the time of last enqueue, =
and
> - * a hardware filter index.
> + * tail pointer for that CPU's input queue at the time of last enqueue, =
a
> + * hardware filter index, and the hash of the flow.
>   */
>  struct rps_dev_flow {
>         u16             cpu;
>         u16             filter;
>         unsigned int    last_qtail;
> +       u32             hash;

This is problematic, because adds an extra potential cache line miss in RPS=
.

Some of us do not use CONFIG_RFS_ACCEL, make sure to not add extra
costs for this configuration ?

