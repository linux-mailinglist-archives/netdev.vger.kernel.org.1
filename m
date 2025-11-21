Return-Path: <netdev+bounces-240883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0A6C7BBD0
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 22:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA27F3A76DF
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 21:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97EE30277A;
	Fri, 21 Nov 2025 21:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="LwUtlOGd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827B42FF151
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 21:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763760218; cv=none; b=H8CAVbjAQgB7NT986RCOyraSHWfuyDm7HYlpQD4GLhFbkNfqytCwsy/bz4H0eCFo27nUCc3bSmgDIUGgOorGD3OR3U8EBNbci7JZo/O4a+jc+2UKZR+XOIOuEULsCf4+BzIaDZ5gV24w+5BaIqKkm+VGM6vrS4O6Gw+PGcCwhfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763760218; c=relaxed/simple;
	bh=xMUpQ3Aw4BBK/qeNACqH9b+F5CMVk33Wq67LHjLGe2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MCbyGxMWillp4/mpANST40PTtg1musXDCOzPlIxccy7vHGosShuV/CH+BtNXQ8Cm/9cpRR/9x98hG6aIV065MSZogJASOJTRTfmGTlIZ2xaPphU0WXPExyInF7vpdsGQ7xIzzAE6u3N4rAtlQfel5ooZGYII9X8PzKWgFL3piwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=LwUtlOGd; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-37a3d86b773so22365501fa.0
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 13:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1763760214; x=1764365014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48tek5CqEpMx+bhQeM0VIFWcE720FK+PBjJPi/kkwc0=;
        b=LwUtlOGdWqnqkvx7/vANVuAneAW8VA+XYsOhlzjUAbeo6SYGP62sdQNGXP7yNHWsa6
         WV2s2vK5x9lG9FV6rXqZkfevXPA5PDlzUEPZ7Q//SUJM2StVSoCgddn3jQ1Hejsr4+pu
         hrVJq4ZS4AnWetE8CbHEdNNAo8TjFbiJcl0bwrSRcowyp/kYYbsLU+1GAUAwLxmjsFw5
         BCMZFb1NuMdSyZATEmtY/0fyS1kBr/M9AqHrQ1/ezAO0LYWscp5jcSB93J6ifqgqqwbZ
         daKHLYg/0ycN63KNfBwFF1xhqmrmRkda3Dj3tEKaFEaGQ75fQVoskCCQmi/upAFSbVrV
         k2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763760214; x=1764365014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=48tek5CqEpMx+bhQeM0VIFWcE720FK+PBjJPi/kkwc0=;
        b=G7NbH0/ftBjYlLeoRdObFDOhsgULXQa02OY4L9ikhKjFVrVxqoVylxZAzZnc4vAv3E
         bq6onyfuoy1kK8qlmW5WXy3BktFjOP+5Qvri0MN89GFoXuLxT+Q+LOhbJwF3mioVAUxY
         agLuaj9lekCl3ULepwYV+hsb3w5UidN4g2ij53ezaAH44lLI0DlQgKtPk83pTNytkMJ7
         63eBSwbQJPlpqQIeFdI58xJrkhZgBTKgrYn3B3HVTPm7Q6O1kcd0MK+ZPizpWibyhAL8
         gXrSfzvWB0sVZvNq9lJzpoW1It+s0QziTEqop4mVcFMgcw6bvf39eSulVS5a/k6Cb5CC
         Vi7A==
X-Forwarded-Encrypted: i=1; AJvYcCXdXRSPD+Uq8tsP39dKDAe6B/wHiZjSx5gJBTZaOj6wBrVAUI/7YgytB0wdBNMOZSxX+9R/SVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF2IKB32fOr+BlQzlHh1QkJ0sC6zmMErD3+QI2lp64inzZYQau
	zzYl8LLtIbDgpWQ7mfgyQ0nKBD1ljqiqBdA9aJad9Oq0xjyFHGnb6T+0/YyUlqnUTRSR/4qPW9+
	mSi39G3eFzhX5FftGY1HxLYnoSE7FrwmBTAJoItid
X-Gm-Gg: ASbGnctMvflJfJJas+5B7Hrw5Yi3OVCi0cSR+xIaF9OjmKchoREIYUhG8DmEBKnYSiR
	8yeUTGVWI+O9j2smpsTjQ5ftTYyeBaBQbE+JLlsulhLj3aUfjhJlhfQ1f1cJSMIYGdu8paUWCW7
	oxqCzlaNXgYPGZwrrwuw4SbMUAgx1l6V1lxmTIzKGXiNlTiuzSWxwl65nCsRHVSvjdSVpONXeYu
	V5v5UfxQPpTrDw19n5tQEWpSYmfW+o8wjoE0HftvQxbM0kKtGFOJtAVO8lYFaxdVOsgNfgl9Ih/
	NQAN99xxbG2Er235yPG5tUVEO8v+/L00l71iamD63ruhPW3ZubBXIO9jeZc=
X-Google-Smtp-Source: AGHT+IFNumhZkJtiiV684KoljHE987t1WgBddobfBJBkkl6ZSy2Y0FbIzmH7e0krhG00U2cphIRFXkSfETq7Zuppzro=
X-Received: by 2002:a05:651c:11:b0:36d:114b:52e2 with SMTP id
 38308e7fff4ca-37cd92a194dmr8912631fa.34.1763760214151; Fri, 21 Nov 2025
 13:23:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112001744.24479-1-tom@herbertland.com> <20251112001744.24479-3-tom@herbertland.com>
 <d7793ec7-7d34-4a46-8f17-c4ff1152e232@uliege.be>
In-Reply-To: <d7793ec7-7d34-4a46-8f17-c4ff1152e232@uliege.be>
From: Tom Herbert <tom@herbertland.com>
Date: Fri, 21 Nov 2025 13:23:22 -0800
X-Gm-Features: AWmQ_bn44qrJR3JFlyge-iRieoEN0n3W616Nth_qBrpy5Llzfs5YvZjrrh71Bso
Message-ID: <CALx6S369Cb-9mtD3hSS0udTHZ_4r5d+2UD8zfsonjfM7QrHhAA@mail.gmail.com>
Subject: Re: [RFC net-next 2/3] ipv6: Disable IPv6 Destination Options RX
 processing by default
To: Justin Iurman <justin.iurman@uliege.be>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 5:17=E2=80=AFAM Justin Iurman <justin.iurman@uliege=
.be> wrote:
>
> On 11/12/25 01:16, Tom Herbert wrote:
> > Set IP6_DEFAULT_MAX_HBH_OPTS_CNT to zero. This disables
>
> s/IP6_DEFAULT_MAX_HBH_OPTS_CNT/IP6_DEFAULT_MAX_DST_OPTS_CNT
>
> > processing of Destinations Options extension headers by default.
> > Processing can be enabled by setting the net.ipv6.max_dst_opts_number
> > to a non-zero value.
> >
> > The rationale for this is that Destination Options pose a serious risk
> > of Denial off Service attack. The problem is that even if the
> > default limit is set to a small number (previously it was eight) there
> > is still the possibility of a DoS attack. All an attacker needs to do
> > is create and MTU size packet filled  with 8 bytes Destination Options
> > Extension Headers. Each Destination EH simply contains a single
> > padding option with six bytes of zeroes.
> >
> > In a 1500 byte MTU size packet, 182 of these dummy Destination
> > Options headers can be placed in a packet. Per RFC8200, a host must
> > accept and process a packet with any number of Destination Options
> > extension headers. So when the stack processes such a packet it is
> > a lot of work and CPU cycles that provide zero benefit. The packet
> > can be designed such that every byte after the IP header requires
> > a conditional check and branch prediction can be rendered useless
> > for that. This also may mean over twenty cache misses per packet.
> > In other words, these packets filled with dummy Destination Options
> > extension headers are the basis for what would be an effective DoS
> > attack.
>
> How about a new document to update RFC8200 Sec. 4.1.? Maybe we can get
> 6man consensus to enforce only one occurrence (vs. 2 for the Dest) for
> each extension header. Let alone the recommended order (without
> normative language), we could...

Hi Justin,

It's a nice idea, but given the turnaround times for the IETF process
it would take years. Also to implement that in the stack isn't
particularly trivial. Avoiding the potential DoS attack is the higher
priority problem IMO, and disabling DestOpts by default will have
little impact since almost no one is using them..

>
> OLD:
>     Each extension header should occur at most once, except for the
>     Destination Options header, which should occur at most twice (once
>     before a Routing header and once before the upper-layer header).
>
> NEW:
>     Each extension header MUST occur at most once, except for the
>     Destination Options header, which MUST occur at most twice (once
>     before a Routing header and once before the upper-layer header).
>
> ...and...
>
> OLD:
>     IPv6 nodes must accept and attempt to process extension headers in
>     any order and occurring any number of times in the same packet,
>     except for the Hop-by-Hop Options header, which is restricted to
>     appear immediately after an IPv6 header only.  Nonetheless, it is
>     strongly advised that sources of IPv6 packets adhere to the above
>     recommended order until and unless subsequent specifications revise
>     that recommendation.
>
> NEW:
>     IPv6 nodes must accept and attempt to process extension headers in
>     any order in the same packet,
>     except for the Hop-by-Hop Options header, which is restricted to
>     appear immediately after an IPv6 header only.  Nonetheless, it is
>     strongly advised that sources of IPv6 packets adhere to the above
>     recommended order until and unless subsequent specifications revise
>     that recommendation.
>
> > Disabling Destination Options is not a major issue for the following
> > reasons:
> >
> > * Linux kernel only supports one Destination Option (Home Address
> >    Option). There is no evidence this has seen any real world use
>
> IMO, this is precisely the one designed for such real world end-to-end
> use cases (e.g., PDM [RFC8250] and PDMv2 [draft-ietf-ippm-encrypted-pdmv2=
]).

Sure, but  where is the Linux implementation? Deployment?
>
> > * On the Internet packets with Destination Options are dropped with
> >    a high enough rate such that use of Destination Options is not
> >    feasible
>
> I wouldn't say that a 10-20% drop is *that* bad (i.e., "not feasible")
> for sizes < 64 bytes. But anyway...

The drop rates for Destination Options vary by size of the extension
header. AP NIC data shows that 32 bytes options have about a 30% drop
rate, 64 byte options have about a 40% drop rate, but 128 byte options
have over 80% drop rate. The drops are coming from routers and not
hosts, Linux has no problem with different sizes. As you know from the
6man list discussions, I proposed a minimum level of support that
routers must forward packets with up to 64 bytes of extension headers,
but that draft was rejected because of concerns that it would ossify
an already ossified protocol :-(. Even if a 40% drop rate isn't "that
bad" the 80% drop rate of 128 bytes EH would seem to qualify as "bad".
In any case, no one in IETF has offered an alternative plan to address
the high loss rates and without a solution I believe it's fair to say
that use of Destination Options is not feasible.

>
> > * It is unknown however quite possible that no one anywhere is using
> >    Destination Options for anything but experiments, class projects,
> >    or DoS. If someone is using them in their private network thenthatit
> >    it's easy enough to configure a non-zero limit for their use case
> > ---
> >   include/net/ipv6.h | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/net/ipv6.h b/include/net/ipv6.h
> > index 74fbf1ad8065..723a254c0b90 100644
> > --- a/include/net/ipv6.h
> > +++ b/include/net/ipv6.h
> > @@ -86,8 +86,11 @@ struct ip_tunnel_info;
> >    * silently discarded.
> >    */
> >
> > -/* Default limits for Hop-by-Hop and Destination options */
> > -#define IP6_DEFAULT_MAX_DST_OPTS_CNT  8
> > +/* Default limits for Hop-by-Hop and Destination options. By default
> > + * packets received with Destination Options headers are dropped to th=
wart
> > + * Denial of Service attacks (see sysctl documention)
> > + */
> > +#define IP6_DEFAULT_MAX_DST_OPTS_CNT  0
> >   #define IP6_DEFAULT_MAX_HBH_OPTS_CNT         8
> >   #define IP6_DEFAULT_MAX_DST_OPTS_LEN         INT_MAX /* No limit */
> >   #define IP6_DEFAULT_MAX_HBH_OPTS_LEN         INT_MAX /* No limit */
>
> I'd rather prefer to update RFC8200 and enforce a maximum of 2
> occurrences for the Dest, and keep the default limit of 8 options.
>
> Also, regardless of what we do here (and this remark also applies to the
> Hop-by-Hop), I think it's reasonable for a *host* to drop packets with a
> number of Hbh or Dest options that exceeds the configured limit.
> However, for a router (i.e., forwarding mode), I'd prefer to skip the EH
> chain rather than drop packets (for obvious reasons).

I considered that, but there is a problem in that when we process HBH
options we don't know if we're a host (i.e. the final destination) or
a router (i.e. the packet will be forwarded). I would prefer to keep
it simple and drop whenever a limit is exceeded. RFC9673 does allow a
host to skip over HBH options, but IMO it's too risky to blindly
accept a packet without verifying all the headers.

Tom

