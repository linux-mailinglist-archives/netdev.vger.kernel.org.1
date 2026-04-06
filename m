Return-Path: <netdev+bounces-275615-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IeeLPvF02mqlgcAu9opvQ
	(envelope-from <netdev+bounces-275615-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 16:40:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC793A4461
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 16:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1649F30036C7
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 14:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45325384238;
	Mon,  6 Apr 2026 14:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JILDSpyg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19C8382F07
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775486282; cv=none; b=XfzjkaAij9y2XTTgAvf9VUU9C1XMiYStydziqRRJ3GIwAhW8e6hE94OnTTMCHPgmZhKOKCo9r+AbZaApatXfgPZEnGf8jEoWJYBUunBTJius6pFrCoIQ4/WnwTl5a4JIZ9T0LtURKDf0eOzOtICXITc7ojR2NaR5t/G3zxvW/mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775486282; c=relaxed/simple;
	bh=GJ0RW2irJ6kcELwmCqa4ZzK3ti6Qayrvc3Dfceb+uO0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=tG7aoT3etTrgvHA3xNZN28aCY1qst/+gWc/89fqsIADHlDoYp/Rp2q91hYh0kc7wffZ3nfbB3Kj/gDhJQcDCejLtWuSEhnuZAThHX2EWfgGjs4PrRVuHi60UHpv0od7IzaecB6EpB0vYY4/GvEUEjAW5BUZDqtTD0lqT8tSEA7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JILDSpyg; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79c20063a32so39907467b3.1
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 07:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775486279; x=1776091079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFDVgCinty+f10gqXM3FVX6dOkEjy/NrsNcBhghN+XE=;
        b=JILDSpygQxmw1lDrjKhQE2L7MmMjSyiVnH7Sfta0FX8+ZN12GKuku9qS6bSca8PYWG
         E4ArerLFGy638ZNqL5oBRmmTq6F8ki2sGU4j+dwg8iTWIu8o+rQMM9nsZOFeRh3vh9Cn
         HzuhVORghtaUsuxqxA0zzX4NStf0+lusB5kXe5kEA+/r1K19/G5BFoK2Z54K1kO6k4uV
         ArzvmTJgylNpLEWDA8aukhgzi1uRaxvpvyqn+r1mRJuQsq13fQtE/m2e3ImKOh8yrPDu
         ZihUGisdsOMDyFeRC7e4sqffHm3gAEUVKEdSvtYH6bCEsDbJzECJxWoc05QwBqVYTlS4
         sN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775486279; x=1776091079;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fFDVgCinty+f10gqXM3FVX6dOkEjy/NrsNcBhghN+XE=;
        b=idkMZwHDmCmny/iW/4RNhVewUoBrOkkrRUv+VSjvGyA7JUtyISmtVHD9+SKm0E0s4t
         /8LKLfpeV4LIOlzb72/ynrwUaEF+rjS7ppS92v812A7EqMnZOFq+jprals+ADNdXC61r
         cGhFpNuNkI5PizJqqIKfQPBUeF4knCIK1f+SBG3t74WuCFcA62UN0ei3ZusSnW3s0wbU
         i3H3CjjSjJXva3VZDdJ1z5sUIX+nLO76gUys+YhBbH79XdXXIQoaH8KwDgSz5viKNgZ9
         Xw2zz6qM4oq6IcSelN0exbmzvJoFX91RrOKFAxBzvwYoQ4GPdX0zrpG8zLy5BrpwFXKe
         6InQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQNfP7wLkyPUC/UgCUMIqoMJeuJ/ehYTnuU7ja/3iX4CC3ld0CVn5W3UmTKtpk7OxC+BA5DK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YykX5gouDlB4TjuTBavqeZU9DRns4650Icu1JSzYe0pJFDZ3hkX
	WXiYWr43M/O6uNVryI9RRg7xc/DNCE9qeU3+hwaUUrpDHQ+nXN8Skqo/
X-Gm-Gg: AeBDieuXtE9a5h8F+wQxx17Tg+3YnmSJi4hOu+Uip1bzHiLMeboV6KZg62ZddKm6WOn
	kUkh3oGWhcEqkNyY6WigzIPuNI9Nxbx5x0j5ich8KhykHRRE89Ujjij32g1yICg4rIZmnrzIEAm
	Ry1KfUXptMUwaLvXfJ4ZtDA+myGr9Tg5kmVu6g3LbY2WudHQD9XX2HI191npo24JOn5Gqclbc1d
	1wrmjS+2vMtCHePb03lqtTsDUD7x8zptG0UHYfNpRUptJJUlcPYIsrl0KIkZtPJlJjzHqC2yIaq
	RIkaNRIzR9tlcxeLXZwMRa6PEtWpqiaCFFNYilS30t/E6vJbUn34nm4veBx7CblEGFlnKTtNdho
	1yWTrHMUclU6oppnnW6KiIkeQJ2NUaDMct2i4BpZA5wMr6XEI4hfbtRn/Y4xH6X920vQIl0jt4w
	XrhnFFh00Ctv94oj/9LWGWpiD7PJQD/PEFO10AL2d8XF++VrYwnHt0yQ86UhlbKOpLh5ZU/yYrb
	VU/
X-Received: by 2002:a05:690c:3481:b0:79b:e24e:e308 with SMTP id 00721157ae682-7a3bc106b46mr129094537b3.8.1775486278637;
        Mon, 06 Apr 2026 07:37:58 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a83adc3sm6144992d50.5.2026.04.06.07.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 07:37:58 -0700 (PDT)
Date: Mon, 06 Apr 2026 10:37:57 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 willemb@google.com, 
 martin.lau@kernel.org, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>, 
 Yushan Zhou <katrinzhou@tencent.com>
Message-ID: <willemdebruijn.kernel.27ec47b22b23c@gmail.com>
In-Reply-To: <CAL+tcoB94=ptFB-acU3nAK_MqW74DV0MQUVvvV3nbQ7Zc6zSZw@mail.gmail.com>
References: <20260404150452.83904-1-kerneljasonxing@gmail.com>
 <20260404150452.83904-4-kerneljasonxing@gmail.com>
 <willemdebruijn.kernel.2ff565d2f9e7f@gmail.com>
 <CAL+tcoB94=ptFB-acU3nAK_MqW74DV0MQUVvvV3nbQ7Zc6zSZw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/4] bpf-timestamp: keep track of the skb when
 wait_for_space occurs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275615-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2CC793A4461
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jason Xing wrote:
> On Mon, Apr 6, 2026 at 10:28=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > The patch is the 1/2 part of push-level granularity feature.
> > >
> > > Tag the skb in tcp_sendmsg_locked() when wait_for_space occurs even=

> > > though it might not carry the last byte of the sendmsg.
> > >
> > > Prior to the patch, BPF timestamping cannot cover this case:
> > > The following steps reproduce this:
> > > 1) skb A is the current last skb before entering wait_for_space pro=
cess
> > > 2) tcp_push() pushes A without any tag
> > > 3) A is transmitted from TCP to driver without putting any skb carr=
ying
> > >    timestamps in the error queue, like SCHED, DRV/HARDWARE.
> > > 4) sk_stream_wait_memory() sleeps for a while and then returns with=
 an
> > >    error code. Note that the socket lock is released.
> > > 5) skb A finally gets acked and removed from the rtx queue.
> > > 6) continue with the rest of tcp_sendmsg_locked(): it will jump to(=
goto)
> > >    'do_error' label and then 'out' label.
> > > 7) at this moment, skb A turns out to be the last one in this send
> > >    syscall, and miss the following tcp_bpf_tx_timestamp() opportuni=
ty
> > >    before the final tcp_push()
> > > 8) BPF script fails to see any timestamps this time
> > >
> > > Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  net/ipv4/tcp.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > index c603b90057f6..7d030a11d004 100644
> > > --- a/net/ipv4/tcp.c
> > > +++ b/net/ipv4/tcp.c
> > > @@ -1400,9 +1400,11 @@ int tcp_sendmsg_locked(struct sock *sk, stru=
ct msghdr *msg, size_t size)
> > >  wait_for_space:
> > >               set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> > >               tcp_remove_empty_skb(sk);
> > > -             if (copied)
> > > +             if (copied) {
> > > +                     tcp_bpf_tx_timestamp(sk);
> > >                       tcp_push(sk, flags & ~MSG_MORE, mss_now,
> > >                                TCP_NAGLE_PUSH, size_goal);
> >
> > Now the number of skbs that will be tracked will be unpredictable,
> > varying based on memory pressure.
> =

> Right, I put some effort into writing a selftests to check how many
> push functions get called at one time and failed to do so.
> =

> >
> > That sounds hard to use to me. Especially if these extra pushes
> > cannot be identified as such.
> >
> > Perhaps if all skbs from the same sendmsg call can be identified,
> > that would help explain pattern in data resulting from these
> > uncommon extra data points.
> =

> You meant move tcp_bpf_tx_timestamp before tcp_skb_entail()? That is
> close to packet basis without considering fragmentation of skb :)

No, I meant somehow in the notification having a way to identify all
the skbs belonging to the same sendmsg call, to allow filtering on
that. But I also don't immediately see how to do that (without adding
yet another counter say).

Right now, push-based seems rather arbitrary to me, informed more by
technical limitations than a clear design. Perhaps per-packet makes
more sense, esp. since BPF calls are cheap (compared to the other
errqueue mechanism).


