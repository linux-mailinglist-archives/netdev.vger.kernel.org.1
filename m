Return-Path: <netdev+bounces-159471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 696CFA15948
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 23:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A1A162019
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 22:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4D81A9B5C;
	Fri, 17 Jan 2025 22:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vbOqhKq6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC8D1B0411
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 22:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737151231; cv=none; b=nkrhX7g3D+AHRClk/VTf/PupHOQmFXm86cZUQZQc6xgJvtma851m/NprlKZIs5xuJfukgGGDOlqullj2wdi7JmZJLUYHB/JiEisrSUhFHkYXSW4CcxuFoLUj0JKvLTXt6eQAvIkBTKBdJaupdCooHsyuGqPJZU8Bsd7BsnNsbFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737151231; c=relaxed/simple;
	bh=gYAGZJe6bbnJl0ybvGTABdO37eWoc9hFHmHQo46yUzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DghD2Yp9nsdLZPQpy3q4GODfNJO3aNEhBzF1kxsCcSwP4TvEHJK70JIe2LxkvU1g84zuCrq+Jg2L2TdZ5utwmJEIQhIKaujbLV2GVic5PvF5yyweWy9r28GIa+pW71k1f5/ysrr3q0SonfOWIDMRnrXtwJAOcZ+4EAorg+y2Du0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vbOqhKq6; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d96944401dso4602702a12.0
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 14:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737151228; x=1737756028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYAGZJe6bbnJl0ybvGTABdO37eWoc9hFHmHQo46yUzo=;
        b=vbOqhKq6fjLfvAHDOz22wijy9OYOggAj6rpEJqRq8Z9AffohZAKhPwB3I5ZSQZT8Ii
         I0SsWEZaPvaJTntdCSBmaSSZwVDQnnDOUTCZOWPMi8qNyOYONZN8kgh5ASrQaORzkx1D
         BfC8Spu27Gfv1njzvOXq9jT2Bl9T5E8KW+R+g8EBlXZiZFLsy3y1cwhpIpMI73cMDfkn
         u6t0JYEE1wiWtXPtALzn+pvEqXl9Ln2Sf8jG/KiEWyOHEMZ/wP5ZSVA3ntgOTY0/bGV5
         eEsBPMrMikCOMr4KQCCbXDgAIXo5mrYM457z8SwaphShccHgD6rqjDYhwXpPXlOhghj5
         VIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737151228; x=1737756028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYAGZJe6bbnJl0ybvGTABdO37eWoc9hFHmHQo46yUzo=;
        b=pgpl+tAg3RvdZcQSt4AnhLPxbwJGJAS4v3z6cYSEHWfF65mnEQ06hbXcXsjh5iZrG/
         r+2DiVy6AKJqD4okO+PNDTAAoRRg9di0ADp9zkP4YlVWJ8FkkUC0jXoEfZO6x+yIlXhf
         w7rsTLHAWq3SDCCo85SKheV8I5Ouu8til+ISsB0pC41hkgfk7es2TNkLflFuI/Zw57j5
         oEhwbgCQRkFZhZ95JNqEcJtU0Mp9POkM5uIJUhmo+UVeFZzGVIDy2drAW2db5kkVMcgJ
         pfjGlDGtywiQ0SOJi++syKSiK3EOC3CaQjqGKQxDHxMqd9UM8X/aEb1Wkcz8IE8owkM9
         lwEw==
X-Gm-Message-State: AOJu0YzOH0jdoRVuZ/CJt4vbNB6AYevbhJB3Ff6wqdXzY2PFG7COtA8w
	IAhluugrgddTJHBqhzVQwGBrfmE8fR+L7qkvOoNaY2TB4VhNWrNBhZoQK2hZjg0Q5rIKiDXbqFd
	61ngeoUaB9Ep1WqDOto9B53UknBBCcGb422Za
X-Gm-Gg: ASbGncv4SFICnUi6qypgI7cJ3P2IQtwOoCslSVllG8nlzmuGroe5FIQ3vHb9Xp7wsKf
	5xG20cFQezaRS4AnhaF9WV60Fsl5vqG0kc9KC0/4=
X-Google-Smtp-Source: AGHT+IEaQ00ag4hDZOTXBik8cV3xI0g+Q6PHAdF1IdKxcUh2OoptST8kJIH1e1fuh7gvw3Opk1b5QEprIU/HaNvi1OY=
X-Received: by 2002:a05:6402:5106:b0:5d4:4143:c06c with SMTP id
 4fb4d7f45d1cf-5db7db086c2mr4008520a12.23.1737151228084; Fri, 17 Jan 2025
 14:00:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117213751.2404-1-ma.arghavani.ref@yahoo.com> <20250117213751.2404-1-ma.arghavani@yahoo.com>
In-Reply-To: <20250117213751.2404-1-ma.arghavani@yahoo.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 17 Jan 2025 23:00:17 +0100
X-Gm-Features: AbW1kvZNIZJA_m4OhQ4QpU8qP49I6efOYlEuMrCctuGYAeBL8QOxGqqOU0d_9_Y
Message-ID: <CANn89i+g380KQq7C8GEJVxwNNZJE6gwq3JCCyGsn6M09+y8N7Q@mail.gmail.com>
Subject: Re: [PATCH net v3] tcp_cubic: fix incorrect HyStart round start detection
To: Mahdi Arghavani <ma.arghavani@yahoo.com>
Cc: netdev@vger.kernel.org, ncardwell@google.com, haibo.zhang@otago.ac.nz, 
	david.eyers@otago.ac.nz, abbas.arghavani@mdu.se, 
	Jason Xing <kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 10:38=E2=80=AFPM Mahdi Arghavani <ma.arghavani@yaho=
o.com> wrote:
>
> I noticed that HyStart incorrectly marks the start of rounds,
> leading to inaccurate measurements of ACK train lengths and
> resetting the `ca->sample_cnt` variable. This inaccuracy can impact
> HyStart's functionality in terminating exponential cwnd growth during
> Slow-Start, potentially degrading TCP performance.
>
> The issue arises because the changes introduced in commit 4e1fddc98d25
> ("tcp_cubic: fix spurious Hystart ACK train detections for not-cwnd-limit=
ed flows")
> moved the caller of the `bictcp_hystart_reset` function inside the `hysta=
rt_update` function.
> This modification added an additional condition for triggering the caller=
,
> requiring that (tcp_snd_cwnd(tp) >=3D hystart_low_window) must also
> be satisfied before invoking `bictcp_hystart_reset`.
>
> This fix ensures that `bictcp_hystart_reset` is correctly called
> at the start of a new round, regardless of the congestion window size.
> This is achieved by moving the condition
> (tcp_snd_cwnd(tp) >=3D hystart_low_window)
> from before calling `bictcp_hystart_reset` to after it.
>
> I tested with a client and a server connected through two Linux software =
routers.
> In this setup, the minimum RTT was 150 ms, the bottleneck bandwidth was 5=
0 Mbps,
> and the bottleneck buffer size was 1 BDP, calculated as (50M / 1514 / 8) =
* 0.150 =3D 619 packets.
> I conducted the test twice, transferring data from the server to the clie=
nt for 1.5 seconds.
> Before the patch was applied, HYSTART-DELAY stopped the exponential growt=
h of cwnd when
> cwnd =3D 516, and the bottleneck link was not yet saturated (516 < 619).
> After the patch was applied, HYSTART-ACK-TRAIN stopped the exponential gr=
owth of cwnd when
> cwnd =3D 632, and the bottleneck link was saturated (632 > 619).
> In this test, applying the patch resulted in 300 KB more data delivered.
>
> Fixes: 4e1fddc98d25 ("tcp_cubic: fix spurious Hystart ACK train detection=
s for not-cwnd-limited flows")
> Signed-off-by: Mahdi Arghavani <ma.arghavani@yahoo.com>
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> Cc: Neal Cardwell <ncardwell@google.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Haibo Zhang <haibo.zhang@otago.ac.nz>
> Cc: David Eyers <david.eyers@otago.ac.nz>
> Cc: Abbas Arghavani <abbas.arghavani@mdu.se>
> ---

SGTM thanks.

Reviewed-by: Eric Dumazet <edumazet@google.com>

