Return-Path: <netdev+bounces-249601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 544F7D1B665
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 22:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FB113012754
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 21:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1768E32BF25;
	Tue, 13 Jan 2026 21:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="KzjkkSvO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A1F31ED95
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 21:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768339715; cv=none; b=BxCDRa+IbxJ6BNrd2Y2DB69hTBHOQ1Yi+WABA6i/BeqD3W2rxJ87IZvZtaiEabExOp7r1Nd+0B7fQX5sr4/BgM+agxTnNuBkKoWGYOravbSxPQ1rav93bIeKrlSsfHfYcG04g2Fp0/PCwc2AfKNiwXpvQumZuFlCzcm610OdWaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768339715; c=relaxed/simple;
	bh=/sjXZqJqPC7crHm9RyJs5cBFt5BsXo1n8SIelhpIFpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=COO26WSD+2/gN+uewdTBAIp6LsVCtkUKtUEHxLi4DNJTxzvXCiC50TbTVp0M1n9fea5LQGLHaoKSiTiEK2N1k9qGI1VowMT9kFt/BwntLSSfZ3OJJkLWwfA5E0iFOFIajd8fKHH5lpOwriflmk2XV9jLQnpQWY+yZJljO5UdId4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=KzjkkSvO; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12336f33098so59438c88.0
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 13:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1768339713; x=1768944513; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UBRC+Rpbdm2zKDeU90T2kAoRrIazNYEJECuptdIqsQY=;
        b=KzjkkSvOfjlruLadAlnu0egm9cnWbOBFFjfBcw3A2thjdww4PkAtQrsv9bj3iHWomc
         TrP+2PAuFXINs2hMHyyzYcJ6WgDcQFOoFUJ1mkThSu/JLAQ+yAei1SYhYTkeS0636Zyf
         7pl/QMqcaVOl729egHNzPSwbGipwlX5wXEgMIcibxuta0dHSxcxCJIU2A9c1fjF+YIk6
         X0pry+Az80VhH7pfngOY4nM6IT+crU8i2pDVxuJdGIHyVHIe4Uff9nsRO6upu86nVT0+
         RlPcoxhOFEm8dEle8BI4ry4Ma20RVDaDO/oco36mxmPMs29SzAQox1HtowriQ/JRDd+U
         tvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768339713; x=1768944513;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBRC+Rpbdm2zKDeU90T2kAoRrIazNYEJECuptdIqsQY=;
        b=g5OAXnpE6vGoGFBuenradYTGVYSu1gGsBssgMlz02X48lDBOpuNeDD3C82HWrHUr05
         JH+hrYXq2BWEwKNXc8PMse/ZntJ+nCbENLpvDws2HxaWn7mbxpcLZ0gEVmSRt3hpTF5H
         MOGFsok7kMUsTFtY+LphV4DltBeFn7B/n7VnfPU6/hQu3u1BYgKPgqEIZ3pr+rQJEcXg
         MuNgwe+uxbxYO3o/fNRkwWZ3tkmIm0pVKVqY6/sVElolzW50IaiHO8xhRAtCHJRB00u1
         mK3RcI8NNBo6MYkwXqNa0sUOoboLf9x0ObBjgtY8eBKipCpfv0f5GnZ27TZKPuuzgpGC
         O05g==
X-Forwarded-Encrypted: i=1; AJvYcCWAis3rDyYzoVPRkoFM/B+J6al9T6aAVpaJgzLtjuH6KDuENtTbWli5YGVh3Nr1R48VlryuEME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx31TCxUS/RRKBU1/p6dKDQth/gYDdF1krpjumzPepY+ZVxwi+
	peadeJos+EIqTWc/hN2nNrRuPHxSjjPoONbQ3PHQ8QF6kTwN2zYgsO2X1JOEetUgzbqKwd89HTp
	Ayk4/OtOoaxXuRt0H8Yx66a5oaHkFlvq/XtJqOo2Owg==
X-Gm-Gg: AY/fxX6nU0SpFoL7fk/7byjv48q+SSy/CktG0d78D54CYvhhYIn1j6TUPL9RAlbStz4
	Ffe08pPZqA8lKiNSKGpDDLbiv/fUcn1auX1YHZZU+72+PMggGgbf9YEkUjE8SCPTl5nrPQ1gfYg
	NgbwXRYzYIADQRs0N+RiHeMSCLGT7P+Rjp8FdiZ/Mr5U07Eu5rLNRmGauKgqsUdZiY1y1NS9CCX
	5jw58pp87+5DCku6od7ABcIBgHB6wrvUS3FCUkAaeh3zPGs/tRXvIvMA2RGIdnsWVl+MHtdcDqY
	J5ynK1W4sHJ0zdX4364CxcoDIWsw0mtDrjg9
X-Received: by 2002:a05:7022:1709:b0:11b:d6f2:a6d6 with SMTP id
 a92af1059eb24-12336a81135mr297133c88.34.1768339712508; Tue, 13 Jan 2026
 13:28:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923134742.1399800-1-maxtram95@gmail.com> <20250923134742.1399800-2-maxtram95@gmail.com>
 <aNWIi0Ni-kwUmYul@mini-arch>
In-Reply-To: <aNWIi0Ni-kwUmYul@mini-arch>
From: Alice Mikityanska <alice@isovalent.com>
Date: Tue, 13 Jan 2026 23:28:16 +0200
X-Gm-Features: AZwV_QjhSUd5CXclGB56T4LMVGk3qAsJcZaPa1XUyr_KMTrbqFSQ7G3ginp8umk
Message-ID: <CAD0BsJXNcZ0w7BViTz4t07pY7ViSNbNJx_XR4LVRtdjC-x9vCA@mail.gmail.com>
Subject: Re: [PATCH net-next 01/17] net/ipv6: Introduce payload_len helpers
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Maxim Mikityanskiy <maxtram95@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org, 
	tcpdump-workers@lists.tcpdump.org, Guy Harris <gharris@sonic.net>, 
	Michael Richardson <mcr@sandelman.ca>, Denis Ovsienko <denis@ovsienko.info>, Xin Long <lucien.xin@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Sept 2025 at 21:23, Stanislav Fomichev <stfomichev@gmail.com> wrote:
>
> On 09/23, Maxim Mikityanskiy wrote:
> > From: Maxim Mikityanskiy <maxim@isovalent.com>
> >
> > From: Maxim Mikityanskiy <maxim@isovalent.com>
> >
> > The next commits will transition away from using the hop-by-hop
> > extension header to encode packet length for BIG TCP. Add wrappers
> > around ip6->payload_len that return the actual value if it's non-zero,
> > and calculate it from skb->len if payload_len is set to zero (and a
> > symmetrical setter).
> >
> > The new helpers are used wherever the surrounding code supports the
> > hop-by-hop jumbo header for BIG TCP IPv6, or the corresponding IPv4 code
> > uses skb_ip_totlen (e.g., in include/net/netfilter/nf_tables_ipv6.h).
> >
> > No behavioral change in this commit.
> >
> > Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
> > ---
> >  include/linux/ipv6.h                       | 20 ++++++++++++++++++++
> >  include/net/ipv6.h                         |  2 --
> >  include/net/netfilter/nf_tables_ipv6.h     |  4 ++--
> >  net/bridge/br_netfilter_ipv6.c             |  2 +-
> >  net/bridge/netfilter/nf_conntrack_bridge.c |  4 ++--
> >  net/ipv6/ip6_input.c                       |  2 +-
> >  net/ipv6/ip6_offload.c                     |  7 +++----
> >  net/ipv6/output_core.c                     |  7 +------
> >  net/netfilter/ipvs/ip_vs_xmit.c            |  2 +-
> >  net/netfilter/nf_conntrack_ovs.c           |  2 +-
> >  net/netfilter/nf_log_syslog.c              |  2 +-
> >  net/sched/sch_cake.c                       |  2 +-
> >  12 files changed, 34 insertions(+), 22 deletions(-)
> >
> > diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
> > index 43b7bb828738..44c4b791eceb 100644
> > --- a/include/linux/ipv6.h
> > +++ b/include/linux/ipv6.h
> > @@ -126,6 +126,26 @@ static inline unsigned int ipv6_transport_len(const struct sk_buff *skb)
> >              skb_network_header_len(skb);
> >  }
> >
> > +static inline unsigned int ipv6_payload_len(const struct sk_buff *skb, const struct ipv6hdr *ip6)
> > +{
> > +     u32 len = ntohs(ip6->payload_len);
> > +
> > +     return (len || !skb_is_gso(skb) || !skb_is_gso_tcp(skb)) ?
> > +            len : skb->len - skb_network_offset(skb) - sizeof(struct ipv6hdr);
>
> Any reason not to return skb->len - skb_network_offset(skb) - sizeof(struct ipv6hdr)
> here unconditionally? Will it not work in some cases?

Just submitted a v2. Yes, it's intentional:

Many callers do extra checks that the payload length is valid, i.e.
not bigger than the SKB length. If we just use the calculation
unconditionally, those checks will always pass, even for invalid
packets that have payload_len bigger than the actual packet size.

For example, bridge and netfilter validate that an IPv6 packet either
has a non-zero payload_len that fits into the SKB, or it has a zero
payload_len and an HBH Jumbo header with a length that fits into the
SKB, or it's a new-style BIG TCP packet with a zero payload_len, hence
the checks for GRO/GSO in ipv6_payload_len(): we make sure that it
didn't come with payload_len = 0 from the wire (ipv6_gro_receive also
checks payload_len before aggregating packets).

Note that this commit aims to reflect the same behavior that we have
with IPv4 and iph_totlen.

