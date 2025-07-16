Return-Path: <netdev+bounces-207507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06161B078F3
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 17:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A9516B98F
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 15:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FAF1CAA7B;
	Wed, 16 Jul 2025 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8OyjWnS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34101A262D;
	Wed, 16 Jul 2025 15:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678104; cv=none; b=bNAXuKK64yZ3LEqioiX9x6hkuO4OxT4f2d2TlYtf2tlSMEj7x8qQNqrnGJ+HGcoMW0BSADRZWMaj9seuL+O7a5rvV1Gk0E/Klm1NPSh+CsrBYUoZaAdCcvooijRDgvDqyY3WhuJfmR/GCjcST8lUjsRxkcVVbeChOPhP3ZXoPQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678104; c=relaxed/simple;
	bh=m08LelpiD7qCsZ8agtHnu+CRQsWa05JZJpY5kvyJtqA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VAPtr9aoWf7uoTsPzDQrTD6x42rJ1k9mPMi10NTX1cjP6pLvk3txCQhi/Xf0iH0bG0gN9rOrgRJLlxtXstoSAIh4lV59n2ZGYcV5HZR3b+C136L314uxVr/Y2yp+mz+6rm87UCVA/cdS0EW2dzFZ5YpeHrUyWkoM1rFPWP7J09g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8OyjWnS; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7183dae66b0so5799167b3.3;
        Wed, 16 Jul 2025 08:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752678102; x=1753282902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEd+x+bDp5sBny4LSdoGr3AA4SuCj6wfSFdgKw9fbdY=;
        b=I8OyjWnSsBUEg3QNrhFmltqfX63EzDL0+Fu1fYZJGxJGo36W7enUCSGtmU5MpOSvgC
         otzLix8MXz/8O6zIELdLD5wsgjf91hlFG9QOJ2dllrPe6yGYi66HOnCiwQOa/0JPG6WX
         L0guYyzLUz8DxbazSVnJbRD91uP6JTGH2B+XhRoh+Ys4KcBnkvrSvBLQqrDSNE39DqX8
         8HTHD8+rb6aU/yGI6153vbb6SVg6r8Hvfw2Lu0yTYAMzzoQnOlsKQ7r2OtArZlmeT7Rb
         CaefVqOWCGVuHdHAq5lT1HOXb09o34KkmRWvAE3UuufG+dqvI/M+v17rB2l6pJ57srk6
         tgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752678102; x=1753282902;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hEd+x+bDp5sBny4LSdoGr3AA4SuCj6wfSFdgKw9fbdY=;
        b=RXezsUCdeL1ozE8XP69Kgwja4cnzMdZ6K3n+vjPDHLbaPd6IPnWgo3s4MAa2rnQgU7
         F7kLQ0575t9r21asPgqqbjfRJgc5iciE+dvVvw5nHcF8NFpWJxDorqJWoeTf8xa4R/n/
         34cMDBQkgVDyv91ZHbX/UQ08ZoxiEATQOSTvjh8O4T6seR7P5G6IDL/qsEcePu6PmjNG
         +MVFO99CfOXvRkqMDF2Yi92bFvXzCPY37lLCHCfVtrdecUUcbliE54DGH+k634iEa5Yd
         ITmGSRj5ptEbmK39Uh/e0TPNUdFc0lLCyVH2HWheIxwAOZxt88UH5UajULlqdzEispFy
         r9AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcAl4sxWlGL26x4+IlCnrQOMFCiVqyk8uuCkzwACAqqIDFmaYaAmYazgYBqZruEzzTbokHtWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx++duqUHvk4RY4wgcGAi2+GJcYPy6vf0TC76fOyQZS9J7+gr0O
	dwDLX1rfjnc7O36UNAbYEA8SRv3n0/mJknjYGzRkdHIZRB+4P/T1KH0R
X-Gm-Gg: ASbGnctWKBWdzLgdwJk7wHPcULPAZQfQOYBItO8kXrCAGvawfJ3QC8fFG2lFUtbRrPT
	6bmriqR7XrEK/QBv00BqzQYVyXFdWtoqzhhZBzlwE9Yw0RB7Lrdna9sOnMfBVvDONGwYCdg5lvo
	X59Z6MP+DU8ZZlrTFhfpJuYLkZizi4GxOMOqIOtHGbIssa0FrsCElOlsg984hQwttQFVYLRlIu9
	bTCnyT7BBduFIZihHIMme7qRpCiU2JObZAfF7buiR9xYmBTTHPdB/Awaf1ect1cBxpRdTCM+z09
	i6XqVJq2ZgTpQesVvFkPZp0VAYEUCKVV1r9dwDYkzAN9CyykvbiilBVeNvSpOokK5l2G4+/3Frx
	x7KJ3e69RbrUIxs/ULfphcLb0IZlHFwxe0ekwPQaK9NA97yqH/Us4XxwIeaivHuZM91Qhiw==
X-Google-Smtp-Source: AGHT+IGEqfrWSmCPYbBS9A8DJKYb73+8Tdg6N1+UfshIY4kL5pXhCzN/lD30SYRwq+428qUOWxJLUw==
X-Received: by 2002:a05:690c:968c:b0:70a:192d:103 with SMTP id 00721157ae682-71835189457mr50908777b3.28.1752678101714;
        Wed, 16 Jul 2025 08:01:41 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-71845120353sm756587b3.65.2025.07.16.08.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:01:40 -0700 (PDT)
Date: Wed, 16 Jul 2025 11:01:40 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Felix Fietkau <nbd@nbd.name>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Richard Gobert <richardbgobert@gmail.com>
Cc: linux-kernel@vger.kernel.org
Message-ID: <6877bed46f3a4_6ce6d29469@willemb.c.googlers.com.notmuch>
In-Reply-To: <ba71e590-6751-49c1-85c9-97e5dc34ee3c@nbd.name>
References: <20250705150622.10699-1-nbd@nbd.name>
 <686a7e07728fc_3aa654294f9@willemb.c.googlers.com.notmuch>
 <ba71e590-6751-49c1-85c9-97e5dc34ee3c@nbd.name>
Subject: Re: [PATCH net] net: fix segmentation after TCP/UDP fraglist GRO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Felix Fietkau wrote:
> On 06.07.25 15:45, Willem de Bruijn wrote:
> > Felix Fietkau wrote:
> >> Since "net: gro: use cb instead of skb->network_header", the skb network
> >> header is no longer set in the GRO path.
> >> This breaks fraglist segmentation, which relies on ip_hdr()/tcp_hdr()
> > 
> > Only ip_hdr is in scope.
> > 
> > Reviewing TCP and UDP GSO, tcp_hdr/transport header is used also
> > outside segment list. Non segment list GSO also uses ip_hdr in case
> > pseudo checksum needs to be set.
> > 
> > The GSO code is called with skb->data at the relevant header, so L4
> > helpers are not strictly needed. The main issue is that data will be
> > at the L4 header, and some GSO code also needs to see the IP header
> > (e.g., for aforementioned pseudo checksum calculation).
> 
> I just spent some time reviewing the code in order to understand how to 
> fix it properly, and I still don't fully understand what you wrote 
> above, especially the part related to "Non segment list GSO".
> 
> The issue that I'm trying to fix is that the skb network header is wrong 
> for all skbs stored in the frag_list of the first skb.
> The main skb is fine, since the offsets are handled by the network 
> stack. For all the extra fragment skbs, the offsets are unset because we 
> bypassed the part of the stack that sets them.
> 
> Since non-segment-list GSO skbs don't carry extra frag_list skbs, I 
> don't see how they can share the same issue.

Reviewed-by: Willem de Bruijn <willemb@google.com>


Good point.

This patch's approach of setting the field in the gro_receive call of
the inner L4 header (and not the UDP GRO code for the outer encap UDP
header) is definitely preferable over having to iterate over the list
of frag_list skbs again later.

The only issue is whether the setting is correct and safe in case of
tunnels.

On rereading, I think it is. Hence the Reviewed-by tag.



That case is complex enough that ideally we would have a testcase to
cover it. To be clear, I definitely don't mean to ask you to write
that. Just a note to self for the future and/or for anyone whose
workload actually depends on tunneled packets with fraglist GSO (which
is not me, actually).

The main fix in Richard's series was to have the GRO complete code no
longer depend on skb_network_header. Whether or not skb_network_header
is also still set is immaterial to the fix. We just assumed that
nothing besides that GRO complete code even referenced it.


Setting skb_network_offset unconditionally would not be correct for
the head_skb in the presence of tunneling. Because GSO handling of
tunneling requires this to be correctly set in the inner fields:

In __skb_udp_tunnel_segment:

        /* setup inner skb. */
        skb->encapsulation = 0;
        SKB_GSO_CB(skb)->encap_level = 0;
        __skb_pull(skb, tnl_hlen);
        skb_reset_mac_header(skb);
        skb_set_network_header(skb, skb_inner_network_offset(skb));
        skb_set_transport_header(skb, skb_inner_transport_offset(skb));

After this tunnel GSO handler, the rest of the GSO stack no longer
sees the tunnel header and treats the packet as unencapsulated.

The fraglist code is only relevant for the innermost L4 transport
header. Since nothing touches the frag_list skb headers between GRO
receive, and L4 GSO fraglist segment handlers __tcp?_gso_segment_list
and __udpv?_gso_segment_list_csum, it is fine to have network offset
set, without having to handle encapsulation explicitly.


> If I misread what you wrote, please point me at the relevant code 
> context that I'm missing.
> 
> Thanks,
> 
> - Felix



