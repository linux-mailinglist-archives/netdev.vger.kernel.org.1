Return-Path: <netdev+bounces-173404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 835F2A58AE9
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 04:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1A43188AAC6
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 03:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05813136349;
	Mon, 10 Mar 2025 03:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ef7evt1R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B6F28F5
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 03:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741578679; cv=none; b=JlaeTLF7e7WLojp5YA4F76XBHg9KFalTeKUuYIFP7GRhLsF2jhVZamiLr4zbF+MO1eMZVcReI1r+utRBFP/zlIg4n7BTHCFT9EM9Wgn7B+DmeDPH6GE6YPP5V4Dz3qH7mhLwx36Cct7cPU38OY7Zq5iCh+K5UTO+xui7x5v5akA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741578679; c=relaxed/simple;
	bh=x6yPFZvNuzS5ehIu1X+NB/Ob6BQ9WyBMSYFd0vrgxCY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VUdEC7+SC9MCAZnN6r+Xt1olW8npY204JZnpCVyMcePLG/+mxlSTiGpo7goneyvt9b74qPgic0C1jjZ9QPLkO9b62dTU6c7rz9sm8Oyym6z2G5a2+nb9tZYS8bV+Rdw/C7YS/jt/n3/SZdYMmOoU3tiwgNADuk8mglXna2SDh1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ef7evt1R; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-475162ce281so35714741cf.1
        for <netdev@vger.kernel.org>; Sun, 09 Mar 2025 20:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741578677; x=1742183477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gu0jo7vHC7xfv/PwBul1Z4v0HDRC0GMy2jKfbTLLUxc=;
        b=ef7evt1RiEDA0lr+kuWHVhSZPDyQ++c4AphGPT9y5DY/SyCs8KBb859+0h/AED+w0o
         FbyLzc2f3g2FMYv0O5eI45K/wesGu6ke5xeEeCULIIAORVQ4QEtWZh7bze2VbcOd8mdu
         IQ/0mKFiJLEHzApJSlUTjg4bZIiz5+5tA3wIJbNBrUuqbokCqVk2vXI64HnH6KYJd1fA
         xQybwS1q5QgK5KBtbsBcpbYydNE61wXq3NJtVlWgHuKY5UxE/l68P9SDhAfIV5uqMELS
         2uOZnLayEMpjPi8Jr8aaM4W30qAgCPFbhU2KfMbawXIF1nEsM337GFBjca1pxR4C7+I8
         EOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741578677; x=1742183477;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gu0jo7vHC7xfv/PwBul1Z4v0HDRC0GMy2jKfbTLLUxc=;
        b=i0RqPucTOLkm95R4n9ldCvqCclZib4gqcJINxSMgw6HI7aUUsR1Uv3NVFN4+ereMlf
         /XyKUOZt5n2CWPDTHslZuCsOuhXml6elbF6ZsvR6PBh2m/wEBscAKs4EjHae6r8qAmYm
         MV8Xm1Bsa4Zm4zi0UGFWTqGWDNcMYftotpKrJ7eA2bhUER57O0vgryGj0kOPh4qHQ/GE
         KTw+bPIVTrFAyF9lRf2U+O7fEcuTM1eisZQNJYSqy/pShRIVQ3s177B02V02O8EWNyJH
         WOsGApYFLikzcibWKdMMnSqbwP3fg2uIS4x/xIb1QNzLxypLXc55XQ0pKZXmTWxrhNgS
         SK2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWNrhNSiy7+/A5PhREoZ2JUTM0zcYE6sX0aS35WMTyKpImix/LIzqpcKgeowLnHAKPlXUFrVlk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww56EuB8oGVQxKqQYouqsfwrD+Nn/G8qplOE7oBqkHi1/4e/3A
	OFV5GHDZa0v37yc2RTSAPupzYUjAoLGopVnqn7PweuOEDGP8sT2E
X-Gm-Gg: ASbGncv7I3IOI0KlwIBJEeGiDNHlx1Jp2u0Jk1OlZPXzjCea4/yo6XAEtZnJ/0yh7j7
	w/EZr4wG6b1tWBcliFt90PrMqS/L2ptw6FD61rt0T+uD+5IakPR/yeQPv9CXLaaXealv7IzoKA7
	r1gKAmv5xI8oyFqO18EpJtWxnmyteF5gYNFMekVu4MzqxEnsPL8HcfPpy/jTJkvquEwsdxE9mCX
	oCcf5rylj3+JHmkNXzM2kG91zccUnUzdpbPX1xCsBL9GgM9YMNYKP5QQLoRcNeLSJmDVW1DP0R7
	gbtrn398PlnTf9gHMz96HY0B9rpqoByDeK6xeg/HYGSfxFhM7vh5p3GSUhlI0Eoz6GXM/D6xlE3
	+mf4Z33IFFNCkAJvwUCjSXZLT4jBNrOlv
X-Google-Smtp-Source: AGHT+IHgdbxzTfleyk0150BJ7tIz64bMl6yT3h8oSO3ttcQ3J/+GPcjbwt7x+h1XzUWf95zbh8S55g==
X-Received: by 2002:a05:6214:76c:b0:6d4:1bad:740c with SMTP id 6a1803df08f44-6e9005bc684mr162320486d6.4.1741578677045;
        Sun, 09 Mar 2025 20:51:17 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f715b781sm51200836d6.82.2025.03.09.20.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 20:51:16 -0700 (PDT)
Date: Sun, 09 Mar 2025 23:51:15 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>
Message-ID: <67ce61b338efd_20941f2949f@willemb.c.googlers.com.notmuch>
In-Reply-To: <4bc191e2-b4f3-4e6b-8c9f-eaa67853aaae@redhat.com>
References: <cover.1741338765.git.pabeni@redhat.com>
 <800d15eb0bd55fd2863120147e497af36e61e3ca.1741338765.git.pabeni@redhat.com>
 <67cc8e796ee81_14b9f929496@willemb.c.googlers.com.notmuch>
 <4bc191e2-b4f3-4e6b-8c9f-eaa67853aaae@redhat.com>
Subject: Re: [PATCH v2 net-next 1/2] udp_tunnel: create a fastpath GRO lookup.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> On 3/8/25 7:37 PM, Willem de Bruijn wrote:
> > Paolo Abeni wrote:
> >> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> >> index 2c0725583be39..054d4d4a8927f 100644
> >> --- a/net/ipv4/udp_offload.c
> >> +++ b/net/ipv4/udp_offload.c
> >> @@ -12,6 +12,38 @@
> >>  #include <net/udp.h>
> >>  #include <net/protocol.h>
> >>  #include <net/inet_common.h>
> >> +#include <net/udp_tunnel.h>
> >> +
> >> +#if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
> >> +static DEFINE_SPINLOCK(udp_tunnel_gro_lock);
> >> +
> >> +void udp_tunnel_update_gro_lookup(struct net *net, struct sock *sk, bool add)
> >> +{
> >> +	bool is_ipv6 = sk->sk_family == AF_INET6;
> >> +	struct udp_sock *tup, *up = udp_sk(sk);
> >> +	struct udp_tunnel_gro *udp_tunnel_gro;
> >> +
> >> +	spin_lock(&udp_tunnel_gro_lock);
> >> +	udp_tunnel_gro = &net->ipv4.udp_tunnel_gro[is_ipv6];
> >> +	if (add)
> >> +		hlist_add_head(&up->tunnel_list, &udp_tunnel_gro->list);
> >> +	else
> >> +		hlist_del_init(&up->tunnel_list);
> >> +
> >> +	if (udp_tunnel_gro->list.first &&
> >> +	    !udp_tunnel_gro->list.first->next) {
> >> +		tup = hlist_entry(udp_tunnel_gro->list.first, struct udp_sock,
> >> +				  tunnel_list);
> >> +
> >> +		rcu_assign_pointer(udp_tunnel_gro->sk, (struct sock *)tup);
> > 
> > If the targeted case is a single tunnel, is it worth maintaining the list?
> > 
> > If I understand correctly, it is only there to choose a fall-back when the
> > current tup is removed. But complicates the code quite a bit.
> 
> I'll try to answer the questions on both patches here.
> 
> I guess in the end there is a relevant amount of personal preferences.
> Overall accounting is ~20 lines, IMHO it's not much.

In the next patch almost the entire body of udp_tunnel_update_gro_rcv
is there to maintain the refcount and list of tunnels.

Agreed that in the end it is subjective. Just that both patches
mention optimizing for the common case of a single tunnel type.
If you feel strongly, keep the list, of course.

Specific to the implementation

+	if (enabled && !old_enabled) {

Does enabled imply !old_enabled, once we get here? All paths
that do not modify udp_tunnel_gro_type_nr goto out.

+		for (i = 0; i < UDP_MAX_TUNNEL_TYPES; i++) {
+			cur = &udp_tunnel_gro_types[i];
+			if (refcount_read(&cur->count)) {
+				static_call_update(udp_tunnel_gro_rcv,
+						   cur->gro_receive);
+				static_branch_enable(&udp_tunnel_static_call);
+			}
+		}

Can you use avail, rather than walk the list again?
 
> I think we should at least preserve the optimization when the relevant
> tunnel is deleted and re-created, and the minimal accounting required
> for that will drop just a bunch of lines from
> udp_tunnel_update_gro_lookup(), while keeping all the hooking.
> 
> Additionally I think it would be surprising transiently applying some
> unusual configuration and as a side effect get lower performances up to
> the next reboot (lacking complete accounting).
> 
> > Just curious: what does tup stand for?
> 
> Tunnel Udp Pointer. Suggestion for better name welcome!
> 
> Thanks,
> 
> Paolo
> 



