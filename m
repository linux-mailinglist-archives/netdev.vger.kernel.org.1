Return-Path: <netdev+bounces-235825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A02C4C362E0
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 15:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E34567DA5
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 14:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C8832E74C;
	Wed,  5 Nov 2025 14:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MuzSLMAo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402C332E759
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353717; cv=none; b=VFD5jE/19Igh9OG7t6/xPzyK7nnHZStdbdkNFdz91Nm6XDlLREI1KMJ2Wp5OZkXpjcdskAdEdR++8Y3kzxIjTdHJYWSe7hCnMEvdHArTW7BpmVZLhQAm5Fx07+1yaUzy1j8JR20BQwhvuJrBl2+lmwafFsDEhm7pmICDHb8T9ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353717; c=relaxed/simple;
	bh=GeOcSvZVDH6px8ESZjNx84EIkhmR1UMjbzBDBnxQtGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=El5AY4bb8kNUnP6DOWQ9WAI5vi/+QyabGdr0ji8ZJFJhwC9tc3VFmZHjt/m0Swcf2Ss2mtcESDxKMZA24bQy95vBfErOH+iKpQ0+h+K7qvapEVrfNIuYHMT2aZdC88TI6EsDw0/D4y8RDbDM+SF8KBjQnzKW0mygOf+SWnEUP34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MuzSLMAo; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ed67a143c5so109731cf.0
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 06:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762353714; x=1762958514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQM6yr0bwy6LdwN3i0gEVsyJpTtkKwVfGgpAssodrPk=;
        b=MuzSLMAo2/mbutllMQdrt56VuxUpURX0uJ5Qk+YuXTLx0liZuUCEolZGAoliLsXYmd
         yN7+E8LEQKx6jMQJ7bAGTHJoRBPUDRun4//tmG2dW+NvZidUveOzF652Fu2N8Gxpn4Pg
         G/8Bv9tuj/FYMBl/RzzUtHI/OB1IMjH8PsENgFrGrglH9mjiAa95N6aF13EDfR3Cvkr7
         ysLSsZToswMttVdbg2V+cacLSjwGAbAIds6hAn4AAR9nNJx5W9c5Y4b+b++LKyS9OQYf
         BuH4lGz3/hsOINd6+khsWwp41OorVYSaGsHzWcxcVYZz2tCtEjs6YiYsWdTtGCApBQ+r
         2ZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762353714; x=1762958514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cQM6yr0bwy6LdwN3i0gEVsyJpTtkKwVfGgpAssodrPk=;
        b=qcLdAVcxCyxP/tKwMi2Q0CVy5ovos4dp2J5FlcxZFJBcv3OOQ5JHtq9NrAcGUO030b
         TvU8k44mCr+mPhQrqWN2DRgMshn9oEL7qAl6tMkuiPuLperaOhuNC4OqO7P8fcWdJGy+
         YEr+iRnoPGNKR1xeZC90rLgnC9RFVhvu4TKnbXtnLf9tyvJuZY2bmLhJF62kIskHvE6z
         XTzvafWuMXfBWWR5sA+Soh6wTY8oJ2MzURWYLG0UDOB497CboSclDOUYYZKk55hd9Ye3
         51uNg+ksnUCAg5glzCYU4ulLU0w2G+Biwpj7Kzk44E4SJXr5R1O+hMHJc+JlhC0jNdld
         NroQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6/F+99+xOD27lNPJHb+PoKzQ7Gkc3WMzCPwMjENhxpZiLF0Dv8oPnd1irYhssd6bCZd9oGdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKAlhx3MUJ6YsHbRyCwMa14uwIcoAlZXIeYwcUIxfQdcx6EMcF
	/wnDi0ZoLrpRxxIymMvImqivf/Rdd8puFJBCz1Oi5kkXXxGzybSEKexaoKEcKb6KHwb55859l9w
	+32ikmg/EwsSxhZAEizSqN0u28pJu17TXOCaQmnYi
X-Gm-Gg: ASbGncsiLcPYrfSap6FVBFobUJYYahEA8pAo15FGKTwZQddj9C6ZAXmHzA3LLRA0eTh
	ygnbf/rIpDpqL7KcORiVq7ru+WUGa49a1vPe2gQ0RLEBvzCLGVTyLfUlgQ+BIxzUB5LXGrNz7Pd
	KbOLZyX/s0/OJN+QVx67krUIBdY0rEOVU7GGrdWzqc36bSQIfgWsJfi4OiaiU/B7S8cCYDhcRmD
	LSrj54u3ExuRAO6iGusTsvkcDweuiWrHI10u2LiV8vyNLAP0x69JWDGcAQArBHDoo80U1uP7cxf
	rK61pD5NMw+z++HRVu6X2Q9u4dVAplThIps6Wwl2hac/hZTHzAmIrbmk2Exv
X-Google-Smtp-Source: AGHT+IEdOXz5bK/DbSyefQ9zVm+KOiRxE8yw2YuRDLD1o6I8LPUejMZEir/2h5gIF4kHe5hp3tQYddKsf08lHTKyQ00=
X-Received: by 2002:ac8:5887:0:b0:4e8:b4dc:4c58 with SMTP id
 d75a77b69052e-4ed735b51bbmr7621971cf.12.1762353713731; Wed, 05 Nov 2025
 06:41:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105093837.711053-1-edumazet@google.com>
In-Reply-To: <20251105093837.711053-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 5 Nov 2025 09:41:35 -0500
X-Gm-Features: AWmQ_bleUJcxDwK-xJkto37-G1M81SkefImVwpbTwfLQ1zB8EdHmG01dbI0zoJg
Message-ID: <CADVnQymZ1tFnEA1Q=vtECs0=Db7zHQ8=+WCQtnhHFVbEOzjVnQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: add net.ipv4.tcp_comp_sack_rtt_percent
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 4:38=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> TCP SACK compression has been added in 2018 in commit
> 5d9f4262b7ea ("tcp: add SACK compression").
>
> It is working great for WAN flows (with large RTT).
> Wifi in particular gets a significant boost _when_ ACK are suppressed.
>
> Add a new sysctl so that we can tune the very conservative 5 % value
> that has been used so far in this formula, so that small RTT flows
> can benefit from this feature.
>
> delay =3D min ( 5 % of RTT, 1 ms)
>
> This patch adds new tcp_comp_sack_rtt_percent sysctl
> to ease experiments and tuning.
>
> Given that we cap the delay to 1ms (tcp_comp_sack_delay_ns sysctl),
> set the default value to 100.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  Documentation/networking/ip-sysctl.rst | 13 +++++++++++--
>  include/net/netns/ipv4.h               |  1 +
>  net/ipv4/sysctl_net_ipv4.c             |  9 +++++++++
>  net/ipv4/tcp_input.c                   | 26 ++++++++++++++++++--------
>  net/ipv4/tcp_ipv4.c                    |  1 +
>  5 files changed, 40 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/netwo=
rking/ip-sysctl.rst
> index 7cd35bfd39e68c5b2650eb9d0fbb76e34aed3f2b..ebc11f593305bf87e7d4ad4d5=
0ef085b22aef7da 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -854,9 +854,18 @@ tcp_sack - BOOLEAN
>
>         Default: 1 (enabled)
>
> +tcp_comp_sack_rtt_percent - INTEGER
> +       Percentage of SRTT used for the compressed SACK feature.
> +       See tcp_comp_sack_nr, tcp_comp_sack_delay_ns, tcp_comp_sack_slack=
_ns.
> +
> +       Possible values : 1 - 1000
> +
> +       Default : 100 %

Overall the patch looks great to me, but for the default value I would
suggest 33% rather than 100%.

AFAICT, basically, in data center environments with RTT < 1ms, if
tcp_comp_sack_rtt_percent  is 100% and we allow the data receiver to
wait a whole SRTT before it sends an ACK, then the data sender is
likely to have fully used up its cwnd at the point that the receiver
finally sends the ACK at the end of the SRTT. That means that for the
entire time that the ACK is traveling from the data receiver to the
data sender, the data sender has no permission (from congestion
control) to send. So the "pipe" (data sender -> data receiver network
path) will have an idle bubble for a long time while the data sender
is waiting for the ACK. In these cases, the system would lose
pipelining and would end up in a "stop and wait" mode.

The rationale for 33% is basically to try to facilitate pipelining,
where there are always at least 3 ACKs and 3 GSO/TSO skbs per SRTT, so
that the path can maintain a budget for 3 full-sized GSO/TSO skbs "in
flight" at all times:

+ 1 skb in the qdisc waiting to be sent by the NIC next
+ 1 skb being sent by the NIC (being serialized by the NIC out onto the wir=
e)
+ 1 skb being received and aggregated by the receiver machine's
aggregation mechanism (some combination of LRO, GRO, and sack
compression)

Note that this is basically the same magic number (3) and the same
rationales as:

(a) tcp_tso_should_defer() ensuring that we defer sending data for no
longer than cwnd/tcp_tso_win_divisor (where tcp_tso_win_divisor =3D 3),
and
(b) bbr_quantization_budget() ensuring that cwnd is at least 3 GSO/TSO
skbs to maintain pipelining and full throughput at low RTTs

It is also similar in spirit to your 2014 patch that limits GSO skbs
to half the cwnd, again to help maintain pipelining:

tcp: limit GSO packets to half cwnd
d649a7a81f3b5bacb1d60abd7529894d8234a666
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dd649a7a81f3b5bacb1d60abd7529894d8234a666

WDYT?

neal

