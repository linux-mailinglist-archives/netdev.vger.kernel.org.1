Return-Path: <netdev+bounces-176568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3D6A6AD2D
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 19:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0037B4614F5
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 18:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513BC2066DC;
	Thu, 20 Mar 2025 18:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtxWr9a7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12CE1C69D
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 18:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742495835; cv=none; b=RD+Abs8fSdIwnYtJSZp68TyhKjmLNz1MVyqnq/TTC2jvp3gBLDtY+ljoZaHkNkS4R/AyHqvpMPDfWG9LXyXX6IgysxbHxNBSBm1RKALkMdaMcQBeCsbP+WuADQYnGTem876QLpx3QEfFVX20TMo9jhZ/tP0Zlate3zFReEeMwLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742495835; c=relaxed/simple;
	bh=TmBV50KkxQtVcRvyH7IjkJggwz3UO5OOKF4h1zj5wzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mtMC2gahVhPp8+UTpt2PYOGwKq6gncfSI6cM5ZZhrhvyrMw7E0MkluVUxUG5+Gf1Kq0SkCeiJrAVF1WdsamxF+sC5oJFl1dLTCc38wUUKjiCfTXWot6O60wCeeqKPcScLBh9+Om71OB3RU6faZLG3OrZxjkpsrrRpkirZeLxTJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtxWr9a7; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d3db3b68a7so12103625ab.0
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 11:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742495832; x=1743100632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxBm6xRTf2k7aP/WF+TbgkK/L1fEW0JfxJ3WXvzjDpc=;
        b=ZtxWr9a7wG+OEpXKs0vW2u5Vvj6QD17u6NtaKzmtTD+Dk8FBpniAZC/tDGlX6iGXyw
         kjHa5t8V2vDx/hQbXpv96/SNCBZ46tPNPw7clo4ToRMhiIXrBHlQMzgELAde4czvTOXd
         a4NCg3hrWrxKA8yB1xtjq0MJGo0BPKpqblYm5CueYS8p+P3eBvZESegMpb0Di27S2Zz2
         UdhupUNL6iEmdVmcLWzc2WwQPcbX+ioAAs7HfE03GsnkEMYc7Kypwu+jMNpb14xP6Brm
         LXZmBaWgfe3VsIAwIfpLzOpJxSQbRdfOsdMGBjcMZeKG2SVYshVi1bgF1NDlDHcTZf6L
         riJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742495832; x=1743100632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxBm6xRTf2k7aP/WF+TbgkK/L1fEW0JfxJ3WXvzjDpc=;
        b=CYfZXB/q3+bTJsY4jsYnrSgQ2b3SEDdb1z0lZ+/x/xHzr/nwsocBq9GtfpDHlYfWwo
         n8DNUbwpDW+0xSdnOT38f9SISd9ErG33DJWnIFdqcU1S3qg5FQKGyeCRNcezyzVTTDc4
         U00FX6veLtTjjnXKOtI2Ascv68PWPbNXz7guL3uuf5YS3qGzo4BCP6RPTjq2jKEyFAzD
         kO/6hXT3Q/FL8JQHt7807unw3Vq0sTBcio7LzdNrEOiuNunbA47440yRIAd0D9WMjTTH
         GOrKrMJ9Sw7ca6jxsyqLh3TazxCfCI28+yjOMLof4PjZJ9JHz8KKGrpmhkCw+xCti6RB
         5EcA==
X-Forwarded-Encrypted: i=1; AJvYcCXqLD4zZz6iozTlElwGS4t3QSDKOQkB2kH4d9HOr07KjMjoCyzuPWn+1PYKdZQezrzFf5cOq3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgaYJbkDgfK4AuNs+HmvNDuabUeljCf8xxWtMVBXjsHRNWoU+a
	dEQHdw0mNVf+bPj3OYTV6HHjf0iTdFJO9STWjiB0jUaOfayMD3P9E3eagxvszxrVuyDt0JWMzZp
	LE18fHOd8oAMtkk3jN0zu8LxwXarFsmDN
X-Gm-Gg: ASbGncvW1EgrN/550XSGdpcZX0aTw6DQw4k0awFxfwCv9HtEROFXZNaa7U2MbzPkNg3
	WRzVFwLNUHAnY2/3oynaJyo/qZzNeupTOAJc0Zmmy00SQGeq5rNa/U/OzOVy2tvh9FmjrWTgtuG
	4hAXv3Me/9wgQ4zJOn55yAybploiDn
X-Google-Smtp-Source: AGHT+IG39Yzaa9qnsDfoJKWi6OY/kn4aWl3eE48CKFRY462nZQvEneubzPW7iWjfQEiese4XCREWi2SSwQEl+1kwZTQ=
X-Received: by 2002:a05:6e02:260b:b0:3d0:10a6:99aa with SMTP id
 e9e14a558f8ab-3d5960d256cmr8337045ab.4.1742495832542; Thu, 20 Mar 2025
 11:37:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317103205.573927-1-mbloch@nvidia.com> <CADvbK_ftLCTfmj=Z5yhuatt5eOvxuf=sxbduwdjK4mfuw=4wVw@mail.gmail.com>
 <305606b805fa2bb4725bcbd8c5ee88b88dfff7c5.camel@nvidia.com>
In-Reply-To: <305606b805fa2bb4725bcbd8c5ee88b88dfff7c5.camel@nvidia.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 20 Mar 2025 14:37:01 -0400
X-Gm-Features: AQ5f1JrHRdpAdcg9QnOHmsA-vP9kCanxJvVa72taMlGfJz63e-b-POeobPzzTko
Message-ID: <CADvbK_dQ6kUamSW8zxKgydYpZxesHPcqKo+2eV7DZiGU4Vazng@mail.gmail.com>
Subject: Re: [PATCH net] xfrm: Force software GSO only in tunnel mode
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: Mark Bloch <mbloch@nvidia.com>, "chopps@labn.net" <chopps@labn.net>, 
	"davem@davemloft.net" <davem@davemloft.net>, 
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>, Dragos Tatulea <dtatulea@nvidia.com>, 
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"horms@kernel.org" <horms@kernel.org>, "edumazet@google.com" <edumazet@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, Yael Chemla <ychemla@nvidia.com>, 
	"wangfe@google.com" <wangfe@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 11:24=E2=80=AFAM Cosmin Ratiu <cratiu@nvidia.com> w=
rote:
>
> On Mon, 2025-03-17 at 15:30 -0400, Xin Long wrote:
> > For UDP tunnels, there are two types:
> >
> > - ENCAP_TYPE_ETHER encaps an ether packet (e.g., VXLAN, Geneve).
> > - ENCAP_TYPE_IPPROTO encaps an ipproto packet (e.g., SCTP over UDP).
> >
> > When performing GSO via skb_udp_tunnel_segment():
> >
> > - ENCAP_TYPE_ETHER relies on inner_network_header to locate the
> >   network header.
> > - ENCAP_TYPE_IPPROTO relies on inner_transport_header to locate
> >   the transport header.
> >
> > However, both IPsec transport and tunnel modes modify
> > inner_transport_header. This patch raises a concern that GSO may
> > not work correctly for ENCAP_TYPE_IPPROTO UDP tunnels over IPsec
> > in transport mode.
>
> skb_udp_tunnel_segment -> __skb_udp_tunnel_segment does:
>
> tnl_hlen =3D skb_inner_mac_header(skb) - skb_transport_header(skb);
> __skb_pull(skb, tnl_hlen);
> skb_reset_mac_header(skb);
> skb_set_network_header(skb, skb_inner_network_offset(skb));
> skb_set_transport_header(skb, skb_inner_transport_offset(skb));
>
> As a concrete example, in case of TCP over Geneve over IPsec in
> transport mode, this is the sequence of header manipulations done:
> geneve_build_skb: mh 190 nh 204 th 224 imh 190 inh 204 ith 224 data 182
> iptunnel_xmit: mh 190 nh 154 th 174 imh 190 inh 204 ith 224 data 154
> xfrm4_transport_output: mh 147 nh 138 th 158 imh 190 inh 204 ith 174
> data 174
> skb_mac_gso_segment: mh 124 nh 138 th 158 imh 190 inh 204 ith 174 data
> 124
> inet_gso_segment: mh 124 nh 138 th 158 imh 190 inh 204 ith 174 data 138
> esp4_gso_segment: mh 124 nh 138 th 158 imh 190 inh 204 ith 174 data 158
> __skb_udp_tunnel_segment: mh 124 nh 138 th 174 imh 190 inh 204 ith 174
> data 174
> __skb_udp_tunnel_segment: tnl_hlen 16
> __skb_udp_tunnel_segment: inner skb mh 190 nh 204 th 174 imh 190 inh
> 204 ith 174 data 190
> skb_mac_gso_segment: mh 190 nh 204 th 174 imh 190 inh 204 ith 174 data
> 190
> inet_gso_segment: mh 190 nh 204 th 174 imh 190 inh 204 ith 174 data 204
> tcp_gso_segment: mh 190 nh 204 th 224 imh 190 inh 204 ith 174 data 224
>
> All numbers are offsets from skb->head printed at function start
> (except for '__skb_udp_tunnel_segment: inner', printed after the code
> block mentioned above).
> I see that xfrm4_transport_output moves the inner transport header
> forward (to 174) and that __skb_udp_tunnel_segment incorrectly sets
> transport header to it, but fortunately inet_gso_segment resets it to
> the correct value after pulling the ip header.
>

I agree that it works for ENCAP_TYPE_ETHER tunnels in transport mode
since they do not rely on the incorrect transport header set in
__skb_udp_tunnel_segment().

> In case of ENCAP_TYPE_IPPROTO, inet_gso_segment/ipv6_gso_segment would
> be invoked directly by __skb_udp_tunnel_segment and it would see the
> network header set correctly. But both compute nhoff like this:
> nhoff =3D skb_network_header(skb) - skb_mac_header(skb);
> Which would be 0 given mac_header is set to the same offset as the ip
> header.
> But that only makes the pskb_may_pull check & the skb_pull not do
> anything. The functions then proceed to set up the transport header
> correctly
> I think the code might still work but I haven't verified with a
> ENCAP_TYPE_IPPROTO protocol.

For ENCAP_TYPE_IPPROTO, I believe it does not invoke inet_gso_segment()
or ipv6_gso_segment(). Instead, it directly calls the transport layer's
.gso_segment function, such as sctp_gso_segment() for SCTP over a UDP
tunnel. This behavior can be seen in skb_udp_tunnel_segment():

  case ENCAP_TYPE_IPPROTO:
      offloads =3D is_ipv6 ? inet6_offloads : inet_offloads;
      ops =3D rcu_dereference(offloads[skb->inner_ipproto]);

skb->inner_ipproto =3D=3D IPPROTO_SCTP and
inet(6)_offloads[IPPROTO_SCTP] =3D=3D sctp_gso_segment

sctp_gso_segment() assumes the transport header is correctly set and
retrieves the SCTP header using skb_transport_header(skb). However,
the transport header is incorrectly set earlier in the code:

  skb_set_network_header(skb, skb_inner_network_offset(skb));
  skb_set_transport_header(skb, skb_inner_transport_offset(skb));  <---
  ...
  segs =3D gso_inner_segment(skb, features);

With an incorrect sctphdr, this could lead to unexpected behavior or
even a crash.

I haven't had time to verify it either, but there are perhaps other
ENCAP_TYPE_IPPROTO tunnels easier to set up for testing.

>
> In general, while staring at this code, I got the impression that these
> functions are brittle, relying on assumptions made in completely
> different areas that might easily be broken given a different
> combination of protocols.
>
> I think that the code block in __skb_udp_tunnel_segment could be made
> less brittle if it stops relying on the saved inner headers (which
> might not be set to the actual inner protocols about to be handled),
> and instead parse the mac or network headers and set the next headers
> accordingly. This might even allow back HW GSO for XFRM in tunnel mode
> with crypto offload, like before your original 2020 patch. WDYT?
>

The inner_network_header and inner_transport_header were introduced
to support hardware-offloaded encapsulation. skb_udp_tunnel_segment()
may be just simply mimicking the hardware behavior and wasn=E2=80=99t
designed to handle nested encapsulation.

From what I can see:

For ENCAP_TYPE_ETHER, these headers help avoid extra CPU work by
skipping link-layer parsing to locate the network header, making
the link layer transparent to tunnel segmentation.

For ENCAP_TYPE_IPPROTO, without inner_transport_header, identifying
the transport header solely by parsing the inner packet may not be
possible. For example, distinguishing between these two UDP tunnels
in tunnel segmentation:

  FOU: ETH | IP | UDP | IPPROTO_XXX
  GUE: ETH | IP | UDP | GUE HDR | IPPROTO_XXX

