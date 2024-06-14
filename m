Return-Path: <netdev+bounces-103674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72323909024
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 18:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8FC51F2399D
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 16:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891AD19ADBF;
	Fri, 14 Jun 2024 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IwwZ+OdE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2193180A76
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382268; cv=none; b=Obt+Vo4wXDtF9VCdrxfn+SM7C1KHS3I3t8vdWrsuEDjX3VVuY/hWoyRTygD3Ix2BdVP3+1f4+XgkfwuGqRH9g06pe6BqG+nAAzELwKr1fqCGMgXofjNh7vJ8NnI8KCw+mDRz7X/OfAaBRLpJZfWCfninva57qdpjo795LY9Q6sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382268; c=relaxed/simple;
	bh=cQSp+fkPHuoyFitFK5v6KH2/c6Brp/tb9tLssrJZegg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VvpSQZWguIQ8f/RG/fnlJBQzJNXqGuZaAPiYpLGGMT/n/+hvpUPLK9Yf/a1xJlLrz0DTcuu4zyFBUluWTEUehYv6YG8aX8QPn/eO2ysXbgnSND43xkH9pd5T/lOh077IPyV+PqF0aV0crOyfWNYNbcQJXRNDg/9kPZT+rwg6Mwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IwwZ+OdE; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-48c54370c56so753465137.3
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 09:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718382266; x=1718987066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SC/3dirzkaQgWznOywfkBIDu13/rJnMU+JBRcph5Jw=;
        b=IwwZ+OdE8Z8z44hXhhl+rtcEIcmL9ELMEVtLTiq2X5pdM1Fn4m+D+27XADW7MeDrWw
         Ij1h5B5bvShNaRM1iiGcDza81BPvJP03i7b73ynxv/ULrhyrAfyZ0aEoEStvvH/D5AQy
         YceRmFlJibvEMNL+kJiP36BI8eJOVfIlyETYUSGioqfuCyRSqOSmXCKkV7wR0r3TabGt
         sLEd0SZunO7tpZLYjNnRkgnno+ZurSc1oLEzLk0yUkRmtx4W6S046uQs9kNWhG0ReVgj
         G9jntNk12tDxWh1judqsdfGoegLSrjh1axK5BGiUXqryHNrQIGfzGKWlP0SuvjvSqunu
         GqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718382266; x=1718987066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6SC/3dirzkaQgWznOywfkBIDu13/rJnMU+JBRcph5Jw=;
        b=iZxNA91bh8vYdarM2V7aSfyf605TX+atNdGf39GR/FTYs8c3a26nRMuymrzkowwttl
         Dw/sht7NmcfN9P4maEh6c5e1P5KnUaqJk7aagKU2KBe9eKyE25fyolJd7ZjiTUto13EO
         U5h0y6j5geKcBb/Ty8F4b3S9Z24HtOBQ7AeOINm85w6YlS0lMHH6NeuiwXGxsiGXAIDP
         K3J3g7hZii2CQkcuwdWgqSFYvGaPAjQGR0C9RVv2PZ9PixpmM9psAmaXjLy/39k25wwD
         v+Oqg1G1x5xBZa4KY5I4qwdRvTAYYZ3mXjgONE8RLPr9gpp++0SsysjoIhZV21PLB5hf
         StDA==
X-Gm-Message-State: AOJu0YwpoNzuPQWQ/nIrWWWHli7U9qyspKdzcv011Wp+Axnc9lPQyJuw
	hmfmlBu0JOJw8dD5ZXVdD4g5/tuoHkqOfXjBwM3fYxasH4NzSSiVR95NzsomAhXImtYDO2tcXEf
	NCA+phu21uWxxaquoWm0xzARyVwse0vX8hr4T
X-Google-Smtp-Source: AGHT+IFVzeMPelbnZcFUemX40ZmzVxWBLlfW9KwyF6MBzIAYYYxOg9Q+SHYsFxCEogGfK0Sn8bgcNen3xYiwbT+nwJ8=
X-Received: by 2002:a05:6102:815:b0:48d:94ed:fd8c with SMTP id
 ada2fe7eead31-48dae3cc3f6mr3246943137.25.1718382265433; Fri, 14 Jun 2024
 09:24:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d653597e-9b1f-4eb7-af36-8d79cc5146b7@esteem.com>
In-Reply-To: <d653597e-9b1f-4eb7-af36-8d79cc5146b7@esteem.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 14 Jun 2024 12:24:09 -0400
Message-ID: <CADVnQymVYUS-YTcXmMKUPnS4-BnkhQhmMtuzWgX2S1dA5Drg0w@mail.gmail.com>
Subject: Re: Throughtput regression due to [v2,net,2/2] tcp: fix delayed ACKs
 for MSS boundary condition
To: Neil Hellfeldt <hellfeldt@esteem.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 9:50=E2=80=AFAM Neil Hellfeldt <hellfeldt@esteem.co=
m> wrote:
>
> Hi,
>
> So I believe I found a regression due to:
> patch: [v2,net,2/2] tcp: fix delayed ACKs for MSS boundary condition
> commit: 4720852ed9afb1c5ab84e96135cb5b73d5afde6f
>
> I recently upgraded our production machines from Ubuntu 16.04 all the
> way up to 24.04.
>
> In the process I noticed that iperf3 was no longer able to get the
> throughput that it was able to on 16.04
> I found that Ubuntu 22.04 is when it broke. Then I found that Ubuntu's
> kernel version 5.15.0-92 worked
> fine and version 5.15.0-93 did not. After that I narrowed it down to the
> patch:
>
> patch: [v2,net,2/2] tcp: fix delayed ACKs for MSS boundary condition
> commit: 4720852ed9afb1c5ab84e96135cb5b73d5afde6f
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 06fe1cf645d5a..8afb0950a6979 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -253,6 +253,19 @@  static void tcp_measure_rcv_mss(struct sock *sk, co=
nst struct sk_buff *skb)
>                 if (unlikely(len > icsk->icsk_ack.rcv_mss +
>                                    MAX_TCP_OPTION_SPACE))
>                         tcp_gro_dev_warn(sk, skb, len);
> + /* If the skb has a len of exactly 1*MSS and has the PSH bit
> + * set then it is likely the end of an application write. So
> + * more data may not be arriving soon, and yet the data sender
> + * may be waiting for an ACK if cwnd-bound or using TX zero
> + * copy. So we set ICSK_ACK_PUSHED here so that
> + * tcp_cleanup_rbuf() will send an ACK immediately if the app
> + * reads all of the data and is not ping-pong. If len > MSS
> + * then this logic does not matter (and does not hurt) because
> + * tcp_cleanup_rbuf() will always ACK immediately if the app
> + * reads data and there is more than an MSS of unACKed data.
> + */
> + if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_PSH)
> + icsk->icsk_ack.pending |=3D ICSK_ACK_PUSHED;
>         } else {
>                 /* Otherwise, we make more careful check taking into acco=
unt,
>                  * that SACKs block is variable.
>
>
> After I removed the patches I was able to get the expected speeds. I then=
 reverted the patched on most current
> version of the kernel for Ubuntu which is 6.8.0-35 and I was able to get =
the expected speeds again.
>
> The device unit under test is a embedded device with lwip and built in ip=
erf3 server. It has 100mbit network port.
> It is also a low data rate wireless radio. The expected rate for the Ethe=
rnet is ~52000Kbps avg with the patch applied
> it was getting ~38000Kbps. The expected throughput for wireless is ~328kb=
ps with the patch applied were are getting ~292Kbps.
> That a ~27% throughput regression for Ethernet and a ~11% for the wireles=
s.
>
> command used iperf3 -c 172.18.8.134 -P 1 -i 1 -f m -t 10 -4 -w 64K -R
> Iperf version is 3.0.11 from Ubuntu. The newer version of iperf3 3.16 sho=
w the correct speeds but shows a saw tooth plot for the wireless.

Thanks for the report!

AFAICT your email did not specify the direction of data transfer, but
I gather that you are talking about a throughput regression when the
embedded device is the TCP sender and the Ubuntu machine is the
receiver?

Can you please gather some traces on the receiver Ubuntu machine, as
root, and share the results?

Something like:

tcpdump -w /root/tcpdump.pcap -n -s 116 -c 1000000 -i $eth_device &
nstat -n; (while true; do date; nstat; sleep 0.5; done)  > /root/nstat.txt =
&
# run test ...
kill %1
kill %2

Ideally it would be great if you could provide those traces for (a)
the fast case, and then also (b) the slow case, so we can compare.

Thanks!
neal

