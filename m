Return-Path: <netdev+bounces-147083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD8D9D76DF
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 18:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5664E162F9C
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 17:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFD3136341;
	Sun, 24 Nov 2024 17:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F/YNqgmp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F057283A18
	for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 17:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732470513; cv=none; b=bB+mFe0M6NiB/Y3uK4Nxm8rv8iTp4sgQ9Ws066I6QTwtFVFeWsIi2RRFIHnswa1X/AkKEkARbxAWi2L/7kd9aFb77x/01UoT0LdlizpM5JMITvBWONWIRUfZvB4hcFPKaZWUF3zVyf1UvWbXY1jrEs55JePwLEILedpsZ3NNR9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732470513; c=relaxed/simple;
	bh=KAc+dxrgpbfHlVdExuNbNzAS8bmSU5jj7rjkS12Fa48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CA5LfXZilMgjTEJ4UBWg3U32KAzijuwhst8pX+LjZBM1EonKLkTVttCH3gGkXi/NLkcS5KRMFlKjBkLhq//KrhW4fp/0n+skxEO2v3WvfFL5sr2N6v2RHazdK2uIxlsbwhEzRxgl4Y6CWSYzjfqjSHD55mIMO13hYsu5mwHlozI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F/YNqgmp; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa5366d3b47so149866866b.0
        for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 09:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732470510; x=1733075310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGO/u8jkL1cPeJfFI/uj7V1Q/Nu6nCu/n1Un400nmR4=;
        b=F/YNqgmp7+DNPp11b2tiDm7D8Mn9hCMEonDz1RR9IDB3RiYcre1Ehh/2C51d6DVwpe
         3LKort7VMiynZ8ILSAMuWr2otwcAmn+X1GKSb0dOqnVgO/9c4xDiZML4iSNnSigRuiO+
         EEFNoorruDGZYGDQ/wmmyFAv3iGMkH8VZ5xNYTftjxKT6Mxyc0TzMA7pGj54DbnWGHPo
         fyX+v0QG8vBi1OMXxLTwo6BMAc11MhupzV+688t/rN93zIaWgNfsTjhMOd9kfbn7XMNV
         y+8TX2MnHWwnDIZ9ofS/fUOcQvRofpJGhJNpdGGBWLgQaEhii88BtpcUssArOdekrJ+H
         AsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732470510; x=1733075310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGO/u8jkL1cPeJfFI/uj7V1Q/Nu6nCu/n1Un400nmR4=;
        b=EgJVT9cu3DN3L+ChsH87x+G494RfkxqC9ro5w9CIipc39Y7Lwxw/uQ7V20vTMw41vc
         Y9yZ8L78OhmBymlzlt3jayp/mJWiA+ksSQsTuNvc2+0EKEP/iQYWlLEnQd7VG8KevZtx
         xScn7Mb1BF9M2s+ZNO5NDkw8eJd9L0j0wwEJRIw6kJGtlZvD85P6eEYKG5sTqhGqR/ym
         1PPDnGCHqfgqSTZR/aZpLZbLcvmf/ZASo8v2DlcWeWErOh0LXd6a6CclwknKX9OeKH0v
         ksP1Q/k5181GAJ2CtPSYSgysMghMp2ThPkvFG9ZKVFHmTUY7VxK3GEDqcI5nlqkDseIX
         P9bA==
X-Gm-Message-State: AOJu0YzvR14F/7M/wohzYKYgbsDFrSkvdtfrGjT6z6E+sJ5Oq9HNO9G7
	iPLl30T+JfXrGpmVR9c7djNoKCm8XfPem4jD9iyNdVp8nGgkXSrU0eHDgCE1a4L4yH+yePcJl5u
	VDAOlwHtzrhQmZJKcFlcEIcwW1NXHejgnk1Be
X-Gm-Gg: ASbGnctMztlnh41osYl8qC/DsNY65akqRmgvQKU/F4pFB5XoXdXEfoNtXefsGakiSeQ
	7j4GeHrTtFquIU1ozPmdp8GD0beKctg==
X-Google-Smtp-Source: AGHT+IGR78Yp3E74KyUdMeZXImBCNnCQHFfKf3xLMrONhL4PNULfNvPd5JfgYvuW5T+rOTZfTB9T/fjwf64Ysz6MR8M=
X-Received: by 2002:a17:906:3101:b0:a9a:dc3:c86e with SMTP id
 a640c23a62f3a-aa50990b1aamr890279866b.11.1732470510131; Sun, 24 Nov 2024
 09:48:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241124022148.3126719-1-kuba@kernel.org>
In-Reply-To: <20241124022148.3126719-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 24 Nov 2024 18:48:18 +0100
Message-ID: <CANn89iKCzrZgW1jKLDmkRKpMnK3upw0whRAcqdtF5f07D2i7HQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net_sched: sch_fq: don't follow the fast path if
 Tx is behind now
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	stable@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 24, 2024 at 3:21=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Recent kernels cause a lot of TCP retransmissions
>
> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> [  5]   0.00-1.00   sec  2.24 GBytes  19.2 Gbits/sec  2767    442 KBytes
> [  5]   1.00-2.00   sec  2.23 GBytes  19.1 Gbits/sec  2312    350 KBytes
>                                                       ^^^^
>
> Replacing the qdisc with pfifo makes retransmissions go away.
>
> It appears that a flow may have a delayed packet with a very near
> Tx time. Later, we may get busy processing Rx and the target Tx time
> will pass, but we won't service Tx since the CPU is busy with Rx.
> If Rx sees an ACK and we try to push more data for the delayed flow
> we may fastpath the skb, not realizing that there are already "ready
> to send" packets for this flow sitting in the qdisc.
>
> Don't trust the fastpath if we are "behind" according to the projected
> Tx time for next flow waiting in the Qdisc. Because we consider anything
> within the offload window to be okay for fastpath we must consider
> the entire offload window as "now".
>
> Qdisc config:
>
> qdisc fq 8001: dev eth0 parent 1234:1 limit 10000p flow_limit 100p \
>   buckets 32768 orphan_mask 1023 bands 3 \
>   priomap 1 2 2 2 1 2 0 0 1 1 1 1 1 1 1 1 \
>   weights 589824 196608 65536 quantum 3028b initial_quantum 15140b \
>   low_rate_threshold 550Kbit \
>   refill_delay 40ms timer_slack 10us horizon 10s horizon_drop
>
> For iperf this change seems to do fine, the reordering is gone.
> The fastpath still gets used most of the time:
>
>   gc 0 highprio 0 fastpath 142614 throttled 418309 latency 19.1us
>    xx_behind 2731
>
> where "xx_behind" counts how many times we hit the new "return false".
>
> CC: stable@vger.kernel.org
> Fixes: 076433bd78d7 ("net_sched: sch_fq: add fast path for mostly idle qd=
isc")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

