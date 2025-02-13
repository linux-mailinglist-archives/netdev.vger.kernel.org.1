Return-Path: <netdev+bounces-166065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B60A3445C
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 16:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F347188DD16
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 14:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038F02222DE;
	Thu, 13 Feb 2025 14:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uxJw4bYX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FD1203719
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458281; cv=none; b=d0fM7MbyZJ/fiBelhzsFiPi8cuhRjAuJJJXwtwvxC2THhjQhwHfjshpd4WR6j8eG2ElQMAzYQ7Io/JbUgJP+1Y3BBXQAYHeHCD3hajqwRtILjm2/ha9qHK6x0qH2sA7/VFGNg9UC46fsDjm99XyfjAiCHIGkv1rS3EYk7g6Gd8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458281; c=relaxed/simple;
	bh=IX7hT5vICXvZk49lsZIjs7uZN6mDjQcWWxYVm2fpRoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRWXmnIVw75K26WBiaXUEw0mESr27BFgcbXNNgXYM45patPIdbdIscjz1oN8bhQChhdxEo70AwOAAGPkPAB1UJhG61hWZmE97cIONMF3aEvibhKwGNnyta4Mpqw1OTTx0fm54UUj3AFTdQmo65ba7q+DsmATiwwZTEke/KZcxTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uxJw4bYX; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so1810527a12.0
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 06:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739458278; x=1740063078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IX7hT5vICXvZk49lsZIjs7uZN6mDjQcWWxYVm2fpRoA=;
        b=uxJw4bYXO2frlzX/7884dn1Qj9H7aAEBw9QmN1jlduJlFcB6KOlJAJEWk6vXPN8ddR
         1ytupXOndCrAAsY9R9AGrMGzktgtgplMDzgQReuIjD8DfWkAfJ3S/A/wHyFTk96Vsij7
         rEHBN3DCMWB6kAU+HCsEG1EP5h93Wt1nv3eubjUire9pZrUf9poSAiMbzPsOAgzrmqol
         pNv3Q8qPvtGyVpeqf/u6ExrmK26RuTGw2Eu1OIUVqC6Z27T1RUVqf/VTrs7QoCLu79WS
         Tk67zNf9PLld4jrpq5DgEBHsQFCesvZSsO8YrmyKGQTJpk/dZspHjLqS6hQW6SxTX3Xl
         PE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739458278; x=1740063078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IX7hT5vICXvZk49lsZIjs7uZN6mDjQcWWxYVm2fpRoA=;
        b=sAEPAgO7EYMSkrvQ/KmcQZj1bQdIVhNMKNYhqAkGiPmLzFsWl0DUjzrnW+sL+9tbHD
         1V2+0sPJAdbOztMCEnQKlKos+Ru1w4wyG1cOjCxdf0ybPAEUQRc6Wkeb9DjR6/7tAZzo
         rSC2iJqt2ZM6LrraQqFlg5XkmOktzaaQFU7RDvZk/LOP3a2bSkK1ZZU5i4TAjPLsAF51
         e4skXrGu0Jjg2tJg8zsbslQMlu3uEIsFXbEj+DgYpEf5Dz5Wi6hphQZzy4p3gSLnrCmQ
         QKHc4rB2WMdNIRtJX1ymlEW/gomvPNwkI0nQEJx9fD3Kbs7LfIDVvMzrXxP49nAAjr+X
         e5AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeS8A5JKpXCvWMJZdvYtqPeRZyqmXyn7+oASpK+YW/y5JtC0UrEK3J/5JH/grvZFlS8uCtMrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPf4G1ey1E5CO4rZlHh2K1VWeI0V8YQf9Qc9ezqExeMFFaYZu5
	gqmeuSt1l/RLIYDgICOw5IIvjSv5nhrebkYrnhGbSAIuzvQxwQfFcmV2VpR7xWptYBCNehzBpto
	EYxRqx0Fczk1E+21QyOdT7LNT2lsZunof4H/i
X-Gm-Gg: ASbGnctaMxzu0VJe/eV6vKjG6a09tFdSS38Qj51xeX+J0RieS5Yd/yL9yo1LxYVJ8EI
	VSPV0bwN41MCEg+hkbl4E6ObX6B5R+VHsU6peJYqC6Qb6eMB3EOoFFbtthscXGjo/iVIRc1WVgg
	==
X-Google-Smtp-Source: AGHT+IGljZIx59Lr/CsMxumNYH1DZpomwfHKaYTtp3F1dmerNQOInlVtw83o2w9bD73l/9uJVXjvILoj8jzs5JQrX0M=
X-Received: by 2002:a05:6402:13cf:b0:5de:8457:a71d with SMTP id
 4fb4d7f45d1cf-5decb6884c4mr3089059a12.9.1739458278063; Thu, 13 Feb 2025
 06:51:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418214600.1291486-1-edumazet@google.com> <20240418214600.1291486-4-edumazet@google.com>
 <83806014-4e57-4974-b188-14c87a4cef8f@nvidia.com>
In-Reply-To: <83806014-4e57-4974-b188-14c87a4cef8f@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 13 Feb 2025 15:51:07 +0100
X-Gm-Features: AWEUYZkbcCeaoHpXRAYDDUfg0rwN5tPxpPDX54cbjJnqUcyzmklANhrRsOJiX-o
Message-ID: <CANn89iKQ4ga-CGOQOrSY+eZeSH-CggOFD8QkdDqOUZ6ovdxxdw@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] tcp: try to send bigger TSO packets
To: Shahar Shitrit <shshitrit@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Kevin Yang <yyd@google.com>, eric.dumazet@gmail.com, 
	Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please do not top post on netdev mailing list.

On Thu, Feb 13, 2025 at 3:45=E2=80=AFPM Shahar Shitrit <shshitrit@nvidia.co=
m> wrote:
>
> Hello,
>
> I'm troubleshooting an issue and would appreciate your input.
>
> The problem occurs when the SYNPROXY extension is configured with
> iptables on the server side, and the rmem_max value is set to 512MB on
> the same server. The combination of these two settings results in a
> significant performance drop - specifically, it reduces the iperf3
> bitrate from approximately 30 Gbps to a few Gbps (around 5).
>
> Here are some key points from my investigation:
> =E2=80=A2 When either of these configurations is applied independently, t=
here is
> no noticeable impact on performance. The issue only arises when they are
> used together.
> =E2=80=A2 The issue persists even when TSO, GSO, and GRO are disabled on =
both sides.
> =E2=80=A2 The issue persists also with different congestion control algor=
ithms.
> =E2=80=A2 In the pcap, I observe that the server's window size remains sm=
all (it
> only increases up to 9728 bytes, compared to around 64KB in normal traffi=
c).
> =E2=80=A2 In the tcp_select_window() function, I noticed that increasing =
the
> rmem_max value causes tp->rx_opt.rcv_wscale to become larger (14 instead
> of the default value of 7). This, in turn, reduces the window size
> returned from the function because it gets shifted by
> tp->rx_opt.rcv_wscale. Additionally, sk->sk_rcvbuf stays stuck at its
> initial value (tcp_rmem[1]), whereas with normal traffic, it grows
> throughout the test. Similarly, sk->sk_backlog.len and sk->sk_rmem_alloc
> do not increase and remain at 0 for most of the traffic.
> =E2=80=A2 It appears that there may be an issue with the server=E2=80=99s=
 ability to
> receive the skbs, which could explain why sk->sk_rmem_alloc doesn=E2=80=
=99t grow.
> =E2=80=A2 Based on the iptables counters, there doesn=E2=80=99t seem to b=
e an issue with
> the SYNPROXY processing more packets than expected.
>
> Additionally, with a kernel version containing the commit below, the
> traffic performance worsens even further, dropping to 95 Kbps. As
> observed in the pcap, the server's window size remains at 512 bytes
> until it sends a RST. Moreover, from a certain point there's a 4-ms
> delay in the server ACK that persists until the RST. No retransmission
> is observed.
> One indicator of the issue is that the TSO counters don't increment and
> remain at 0, which is how we initially identified the problem.
> I'm still not sure what might be the connection between the described
> issue to this commit.
>
>
> I would appreciate any insights you might have on this issue, as well as
> suggestions for further investigation.
>
> Steps to reproduce:
>
> # server:
> ifconfig eth2 1.1.1.1
>
> sysctl -w net.netfilter.nf_conntrack_tcp_loose=3D0
> iptables -t raw -I PREROUTING -i eth2 -w 2 -p tcp -m tcp --syn -j CT
> --notrack
> iptables -A INPUT -i eth2 -w 2 -p tcp -m tcp -m state --state
> INVALID,UNTRACKED -j SYNPROXY --sack-perm --timestamp --wscale 7 --mss 14=
60
>
> echo '536870912' > /proc/sys/net/core/rmem_max

What happens if you set a more reasonable value ?

Note that TCP really uses /proc/sys/net/ipv4/tcp_rmem for its limits.

Setting a big /proc/sys/net/core/rmem_max value might have adverse effects.


>
> iperf3 -B 1.1.1.1 -s
>
> # client:
> ifconfig eth2 1.1.1.2
>
> iperf3 -B 1.1.1.2 -c 1.1.1.1
>
>
> If needed, I will send the pcaps.
>
> Thank you,
> Shahar Shitrit

Seeing that you force a small mss value, my guess is the (skb->len /
skb->truesize) ratio is small on your driver RX packets.

On receiver :

ss -temoi dst other_host

might help.

