Return-Path: <netdev+bounces-270037-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OqoGwqbvWmR/QIAu9opvQ
	(envelope-from <netdev+bounces-270037-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:07:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C632DFB8E
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11E1D30A0A45
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26ED31B80E;
	Fri, 20 Mar 2026 19:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXqNhnCT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71FF2D97AA
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 19:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774033438; cv=none; b=rEhUov8m2uM9Clg4ZpcbKlY839gSLywRLqsq2EKpYAXOzLAunSAkygnnyjd4fxfcL9h42fFTAUGX3kisdVj/Qj9qGtb+LFimMn9G3IC/HqILZWbC/xGj2LEma5U7MpK2Y2YFlibCxzjiHzBfwIpM5MmNnVH7LqKlpeNnAgf2hbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774033438; c=relaxed/simple;
	bh=rJR0eGVXLHHlIB0mcMRrxDSWvo+PnIs8hoGXimQPSQ0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=t1jLfIzNupfdpFTriRdRTdvySu+ZzDao16aWz5q2lkSg63t2PrW/zFUVzRvAdi9vkX27Cm2uolWCjxD6qtjdwlx38RCmj0fmmtNatBh0iIVaxZwZopB+BttEAXHaHBcnXv8xWEEESlprqZZV1NAIt3mKtJfXKmONwvepUrfoqsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXqNhnCT; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79a3ba1653fso17399927b3.3
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 12:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774033436; x=1774638236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzlLW12e2j9OmMVit0uj6jjY5bJwA7ISfiriyyeyqa0=;
        b=OXqNhnCT/msVZ+Dzp2xbZkuRW/7CtYDsAiCA4UkhKakMWCkveFXHvUV42gAgx60GiQ
         sSXT4QsrWwj8wvHYdj99RURYHw+4b6mX4rxjSKmFkAqpK12/caSF8EHrl+Pzm+BEINvu
         bwfK3hbLsMlRZc0SZOySV/tEj5+v8b4HBiFyQcVPboj8oORnrYzilr6NFUUYKva4KzI3
         VbqJl/aVj4NeElQasOyoSbyQOkKtU88dVdt5cvVlVVHxsOPlnElLLFgR18l2ZUKeia1r
         9D35yklne8bvOtoQSJeRahjie+Mb/OWS+zyXSyeLODicCb+q2tx35IgYq/i/x68gF8gg
         PsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774033436; x=1774638236;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FzlLW12e2j9OmMVit0uj6jjY5bJwA7ISfiriyyeyqa0=;
        b=ro3R0lsBnbww+yVbKdiaO/56RjHXcc1h4nvVt6HFFFnHD/Za7/cEpBVQFyYW16ssHF
         UrJbaQhpUHIZ95NlNs/3uRRTL9ngR60Q8HKrJdh/lmbysoBdJtYW7n9o4mlaCC9hcEMc
         hQE24qEf2c7tLOpbfQqX4Ym9UX5xCXKhHq9KmwuG3t3EmYG1PsZaGVKOcwsDCdIh5Og9
         q5WyASaD/iB5Z9kw8e2A2tj+iHPUvpMieqK8h6L5KbdRqA8vRogvZUH86Z3kHQ8Seyir
         vtHpAkBLdgxwNV9mu+b00m/+2D2BLQKDUSOMcKevvSyOkTzIpvvqot0YSV3Dvdadr7Tt
         ZyjA==
X-Forwarded-Encrypted: i=1; AJvYcCWi+x57S80WkC53sBFdApFKk+BAniFkwbRPlA+FtPpekBK/TgxTNTvMXnZlW7S+UywrGVjdhRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm/kB4qygIuhA7EIJEIKNeFL7NlmnhpHE9VZFdh9e4igznyV1l
	I7x9/BodCAXsw/yUxszQqqH47OreZ6EdKn7N2L8SXqsrD0FgOymNjTKL
X-Gm-Gg: ATEYQzzPiZZQZJsvEwXhRqDdUuOV2XePQ9HR+hgLGuDd2HJlDptK7788WHsi4GI6+h1
	WUethQixLk7vgrIU4Ckv9ylV+C+FNW62PLuPDPMzkhWHI/Mgplw5Kj962vXXILiOlnDgEKcgsOS
	/bEzgcgjsSZsg/Jso2nKFm2EX7RBsztn4TjVozd1p+3Vw8AA1c8xZqWk9VvgKKa5Eb1guEX6fXx
	yw2iFUp7wKmAHA0rBIei6XpCgvBJBCJ7D7EFqyv+xRVe72BLbg0PFTLYkDC0icp18/3TXpFj+bH
	MUXKqm6bOQCLyrABjLBC3KOvh9pPToftZF6YFgIS+c+25Kz+2VlDGXxqnVS07/K1bm5d1lewxau
	3/UmPhwwpCkX1rsmv5VeBkYz2liS5riVvJDlpv9Q7NXRu1JTsqsMt5UPrhetafcwh0yTv/uG5Ih
	XbEO10XcpxNRcXWDBf+V/ukkcS6gJLu4JWc8pnIbyJ5o2zNrlL/wWbTiPLrPdXvmEYxlXI60LSg
	I8s
X-Received: by 2002:a05:690c:e050:b0:798:58be:3242 with SMTP id 00721157ae682-79a90c51f88mr38227127b3.57.1774033435683;
        Fri, 20 Mar 2026 12:03:55 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79a90580d7csm19966087b3.37.2026.03.20.12.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 12:03:53 -0700 (PDT)
Date: Fri, 20 Mar 2026 15:03:53 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: xietangxin <xietangxin@yeah.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Jakub Ramaseuski <jramaseu@redhat.com>, 
 netdev@vger.kernel.org
Cc: kuba@kernel.org, 
 horms@kernel.org, 
 edumazet@google.com, 
 sdf@fomichev.me, 
 ahmed.zaki@intel.com, 
 aleksander.lobakin@intel.com, 
 benoit.monin@gmx.fr, 
 willemb@google.com, 
 Tianhao Zhao <tizhao@redhat.com>, 
 Michal Schmidt <mschmidt@redhat.com>
Message-ID: <willemdebruijn.kernel.1f887430ab7b4@gmail.com>
In-Reply-To: <c0779757-8318-4ecb-93ee-284b325c11d2@yeah.net>
References: <20250814105119.1525687-1-jramaseu@redhat.com>
 <0414e7e2-9a1c-4d7c-a99d-b9039cf68f40@yeah.net>
 <willemdebruijn.kernel.d12bc5fb9c16@gmail.com>
 <49dac359-326a-4f3a-8c18-9897ea7be498@redhat.com>
 <d6b8909d-705e-498d-ad9a-e61fa24c9d88@yeah.net>
 <9186ce75-4038-4467-b492-7a7821659842@redhat.com>
 <willemdebruijn.kernel.2e5ca236c023e@gmail.com>
 <c0779757-8318-4ecb-93ee-284b325c11d2@yeah.net>
Subject: Re: [PATCH net v3] net: gso: Forbid IPv6 TSO with extensions on
 devices with only IPV6_CSUM
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
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270037-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,fomichev.me,intel.com,gmx.fr,redhat.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[yeah.net,gmail.com,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.073];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E5C632DFB8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

xietangxin wrote:
> =

> =

> On 3/15/2026 12:19 AM, Willem de Bruijn wrote:
> > Paolo Abeni wrote:
> >> On 3/6/26 7:32 AM, xietangxin wrote:
> >>> On 3/5/2026 11:21 PM, Paolo Abeni wrote:
> >>>> On 3/5/26 3:57 PM, Willem de Bruijn wrote:
> >>>>> xietangxin wrote:
> >>>>>> =E5=9C=A8 2025/8/14 18:51, Jakub Ramaseuski =E5=86=99=E9=81=93:
> >>>>>>> When performing Generic Segmentation Offload (GSO) on an IPv6 p=
acket that
> >>>>>>> contains extension headers, the kernel incorrectly requests che=
cksum offload
> >>>>>>> if the egress device only advertises NETIF_F_IPV6_CSUM feature,=
 which has =

> >>>>>>> a strict contract: it supports checksum offload only for plain =
TCP or UDP =

> >>>>>>> over IPv6 and explicitly does not support packets with extensio=
n headers.
> >>>>>>> The current GSO logic violates this contract by failing to disa=
ble the feature
> >>>>>>> for packets with extension headers, such as those used in GREoI=
Pv6 tunnels.
> >>>>>>>
> >>>>>>> This violation results in the device being asked to perform an =
operation
> >>>>>>> it cannot support, leading to a `skb_warn_bad_offload` warning =
and a collapse
> >>>>>>> of network throughput. While device TSO/USO is correctly bypass=
ed in favor
> >>>>>>> of software GSO for these packets, the GSO stack must be explic=
itly told not =

> >>>>>>> to request checksum offload.
> >>>>>>>
> >>>>>>> Mask NETIF_F_IPV6_CSUM, NETIF_F_TSO6 and NETIF_F_GSO_UDP_L4
> >>>>>>> in gso_features_check if the IPv6 header contains extension hea=
ders to compute
> >>>>>>> checksum in software.
> >>>>>>>
> >>>>>>> The exception is a BIG TCP extension, which, as stated in commi=
t
> >>>>>>> 68e068cabd2c6c53 ("net: reenable NETIF_F_IPV6_CSUM offload for =
BIG TCP packets"):
> >>>>>>> "The feature is only enabled on devices that support BIG TCP TS=
O.
> >>>>>>> The header is only present for PF_PACKET taps like tcpdump,
> >>>>>>> and not transmitted by physical devices."
> >>>>>>>
> >>>>>>> kernel log output (truncated):
> >>>>>>> WARNING: CPU: 1 PID: 5273 at net/core/dev.c:3535 skb_warn_bad_o=
ffload+0x81/0x140
> >>>>>>> ...
> >>>>>>> Call Trace:
> >>>>>>>  <TASK>
> >>>>>>>  skb_checksum_help+0x12a/0x1f0
> >>>>>>>  validate_xmit_skb+0x1a3/0x2d0
> >>>>>>>  validate_xmit_skb_list+0x4f/0x80
> >>>>>>>  sch_direct_xmit+0x1a2/0x380
> >>>>>>>  __dev_xmit_skb+0x242/0x670
> >>>>>>>  __dev_queue_xmit+0x3fc/0x7f0
> >>>>>>>  ip6_finish_output2+0x25e/0x5d0
> >>>>>>>  ip6_finish_output+0x1fc/0x3f0
> >>>>>>>  ip6_tnl_xmit+0x608/0xc00 [ip6_tunnel]
> >>>>>>>  ip6gre_tunnel_xmit+0x1c0/0x390 [ip6_gre]
> >>>>>>>  dev_hard_start_xmit+0x63/0x1c0
> >>>>>>>  __dev_queue_xmit+0x6d0/0x7f0
> >>>>>>>  ip6_finish_output2+0x214/0x5d0
> >>>>>>>  ip6_finish_output+0x1fc/0x3f0
> >>>>>>>  ip6_xmit+0x2ca/0x6f0
> >>>>>>>  ip6_finish_output+0x1fc/0x3f0
> >>>>>>>  ip6_xmit+0x2ca/0x6f0
> >>>>>>>  inet6_csk_xmit+0xeb/0x150
> >>>>>>>  __tcp_transmit_skb+0x555/0xa80
> >>>>>>>  tcp_write_xmit+0x32a/0xe90
> >>>>>>>  tcp_sendmsg_locked+0x437/0x1110
> >>>>>>>  tcp_sendmsg+0x2f/0x50
> >>>>>>> ...
> >>>>>>> skb linear:   00000000: e4 3d 1a 7d ec 30 e4 3d 1a 7e 5d 90 86 =
dd 60 0e
> >>>>>>> skb linear:   00000010: 00 0a 1b 34 3c 40 20 11 00 00 00 00 00 =
00 00 00
> >>>>>>> skb linear:   00000020: 00 00 00 00 00 12 20 11 00 00 00 00 00 =
00 00 00
> >>>>>>> skb linear:   00000030: 00 00 00 00 00 11 2f 00 04 01 04 01 01 =
00 00 00
> >>>>>>> skb linear:   00000040: 86 dd 60 0e 00 0a 1b 00 06 40 20 23 00 =
00 00 00
> >>>>>>> skb linear:   00000050: 00 00 00 00 00 00 00 00 00 12 20 23 00 =
00 00 00
> >>>>>>> skb linear:   00000060: 00 00 00 00 00 00 00 00 00 11 bf 96 14 =
51 13 f9
> >>>>>>> skb linear:   00000070: ae 27 a0 a8 2b e3 80 18 00 40 5b 6f 00 =
00 01 01
> >>>>>>> skb linear:   00000080: 08 0a 42 d4 50 d5 4b 70 f8 1a
> >>>>>>>
> >>>>>>> Fixes: 04c20a9356f283da ("net: skip offload for NETIF_F_IPV6_CS=
UM if ipv6 header contains extension")
> >>>>>>> Reported-by: Tianhao Zhao <tizhao@redhat.com>
> >>>>>>> Suggested-by: Michal Schmidt <mschmidt@redhat.com>
> >>>>>>> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com=
>
> >>>>>>> Signed-off-by: Jakub Ramaseuski <jramaseu@redhat.com>
> >>>>>>> ---
> >>>>>>> ---
> >>>>>>>  net/core/dev.c | 12 ++++++++++++
> >>>>>>>  1 file changed, 12 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/net/core/dev.c b/net/core/dev.c
> >>>>>>> index b28ce68830b2b..1d8a4d1da911e 100644
> >>>>>>> --- a/net/core/dev.c
> >>>>>>> +++ b/net/core/dev.c
> >>>>>>> @@ -3778,6 +3778,18 @@ static netdev_features_t gso_features_ch=
eck(const struct sk_buff *skb,
> >>>>>>>  		if (!(iph->frag_off & htons(IP_DF)))
> >>>>>>>  			features &=3D ~NETIF_F_TSO_MANGLEID;
> >>>>>>>  	}
> >>>>>>> +
> >>>>>>> +	/* NETIF_F_IPV6_CSUM does not support IPv6 extension headers,=

> >>>>>>> +	 * so neither does TSO that depends on it.
> >>>>>>> +	 */
> >>>>>>> +	if (features & NETIF_F_IPV6_CSUM &&
> >>>>>>> +	    (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
> >>>>>>> +	     (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
> >>>>>>> +	      vlan_get_protocol(skb) =3D=3D htons(ETH_P_IPV6))) &&
> >>>>>>> +	    skb_transport_header_was_set(skb) &&
> >>>>>>> +	    skb_network_header_len(skb) !=3D sizeof(struct ipv6hdr) &=
&
> >>>>>>> +	    !ipv6_has_hopopt_jumbo(skb))
> >>>>>>> +		features &=3D ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_G=
SO_UDP_L4);
> >>>>>>>  =

> >>>>>>>  	return features;
> >>>>>>>  }
> >>>>>> question about this patch affecting tunneled IPv6-in-IPv4 packet=
s
> >>>>>>
> >>>>>> In our environment with a hinic NIC, we use VXLAN tunnels where
> >>>>>> the outer header is IPv4 and the inner is IPv6. After this commi=
t,
> >>>>>> large packets no longer use hardware TSO and fall back to softwa=
re segmentation.
> >>>>>>
> >>>>>> In the VXLAN IPv6-in-IPv4 case, `skb_shinfo(skb)->gso_type` incl=
udes
> >>>>>> `SKB_GSO_TCPV6` (inner is IPv6 TCP), but the network header poin=
ts to the outer
> >>>>>> IPv4 header. Thus `skb_network_header_len(skb)` returns the IPv4=
 header length
> >>>>>> (usually 20), which is not equal to `sizeof(struct ipv6hdr)` (40=
). This causes
> >>>>>> the condition to trigger and clears `NETIF_F_TSO6`, even though =
the inner IPv6
> >>>>>> packet has no extension headers and the device is capable of han=
dling TSO for
> >>>>>> such packets.
> >>>>>>
> >>>>>> Is it the intended behavior to disable TSO for all tunneled IPv6=
-in-IPv4 packets
> >>>>>> when the NIC lacks NETIF_F_HW_CSUM, even if the inner IPv6 heade=
r has no extensions?
> >>>>>>
> >>>>>> Any feedback or guidance would be greatly appreciated.
> >>>>>
> >>>>> That is definitely unintended.
> >>>>>
> >>>>> Thanks for the clear analysis.
> >>>>>
> >>>>> I was about to write a refinement that might catch this case,
> >>>>> something like
> >>>>>
> >>>>> @@ -3819,8 +3819,10 @@ static netdev_features_t gso_features_chec=
k(const struct sk_buff *skb,
> >>>>>             (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
> >>>>>              (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
> >>>>>               vlan_get_protocol(skb) =3D=3D htons(ETH_P_IPV6))) &=
&
> >>>>> -           skb_transport_header_was_set(skb) &&
> >>>>> -           skb_network_header_len(skb) !=3D sizeof(struct ipv6hd=
r))
> >>>>> +             ((!skb->encapsulation &&
> >>>>> +               skb_transport_header_was_set(skb) &&
> >>>>> +               skb_network_header_len(skb) !=3D sizeof(struct ip=
v6hdr)) ||
> >>>>> +              (skb_inner_network_header_len(skb) !=3D sizeof(str=
uct ipv6hdr))))
> >>>>>                 features &=3D ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 =
| NETIF_F_GSO_UDP_L4);
> >>>>>
> >>>>> But, how are these VXLAN IPv6-in-IPv4 packets having
> >>>>> vlan_get_protocol(skb) =3D=3D htons(ETH_P_IPV6)?
> >>>>>
> >>>>> Shouldn't that be the protocol of the outer headr, so ETH_P_IP, a=
nd
> >>>>> thus this branch not reached at all? (Which itself would leave a =
false
> >>>>> positive as now an inner network header with extensions would not=
 be
> >>>>> caught..)
> >>>>
> >>>> Also the tunnel could have ENCAP_TYPE_IPPROTO, and likely we need =
to
> >>>> disable csum even in that case? Possibly something alike the follo=
wing
> >>>> could work?
> >>>>
> >>>> Side note, I *think* that replacing SKB_GSO_UDP_L4 with separate
> >>>> SKB_GSO_UDPV4_L4 SKB_GSO_UDPV6_L4 would remove a bit of complexity=
 in
> >>>> serveral places, but I'm not sure how much invasive would be such =
a change.
> >>>>
> >>>> ---
> >>>> diff --git a/net/core/dev.c b/net/core/dev.c
> >>>> index 4af4cf2d63a4..f9824dfef376 100644
> >>>> --- a/net/core/dev.c
> >>>> +++ b/net/core/dev.c
> >>>> @@ -3769,6 +3769,22 @@ static netdev_features_t
> >>>> dflt_features_check(struct sk_buff *skb,
> >>>>  	return vlan_features_check(skb, features);
> >>>>  }
> >>>>
> >>>> +static bool skb_gso_has_extension_hdr(const struct sk_buff *skb)
> >>>> +{
> >>>> +	if (!skb->encapsulation)
> >>>> +		return ((skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
> >>>> +			(skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
> >>>> +			 vlan_get_protocol(skb) =3D=3D htons(ETH_P_IPV6))) &&
> >>>> +			skb_transport_header_was_set(skb) &&
> >>>> +			skb_network_header_len(skb) !=3D sizeof(struct ipv6hdr));
> >>>> +
> >>>> +	return (skb->inner_protocol_type =3D=3D ENCAP_TYPE_IPPROTO ||
> >>>> +		((skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
> >>>> +		  (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
> >>>> +		   inner_ip_hdr(skb)->version =3D=3D 6)) &&
> >>>> +		 skb_inner_network_header_len(skb) !=3D sizeof(struct ipv6hdr))=
);
> >>>> +}
> >>>> +
> >>>>  static netdev_features_t gso_features_check(const struct sk_buff =
*skb,
> >>>>  					    struct net_device *dev,
> >>>>  					    netdev_features_t features)
> >>>> @@ -3815,12 +3831,7 @@ static netdev_features_t gso_features_check=
(const
> >>>> struct sk_buff *skb,
> >>>>  	/* NETIF_F_IPV6_CSUM does not support IPv6 extension headers,
> >>>>  	 * so neither does TSO that depends on it.
> >>>>  	 */
> >>>> -	if (features & NETIF_F_IPV6_CSUM &&
> >>>> -	    (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
> >>>> -	     (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
> >>>> -	      vlan_get_protocol(skb) =3D=3D htons(ETH_P_IPV6))) &&
> >>>> -	    skb_transport_header_was_set(skb) &&
> >>>> -	    skb_network_header_len(skb) !=3D sizeof(struct ipv6hdr))
> >>>> +	if (features & NETIF_F_IPV6_CSUM && skb_gso_has_extension_hdr(sk=
b))
> >>>>  		features &=3D ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_GSO_=
UDP_L4);
> >>>>
> >>>>  	return features;
> >>>>
> >>> Hi Paolo, Willem,
> >>>
> >>> Thank you both for the insightful analysis and the proposed fix.
> >>>
> >>> I have backported and tested Paolo's patch in our environment with =
hinic NIC.
> >>> We focused on the VXLAN (IPv6-in-IPv4) scenario and the Native IPv6=
 scenario :
> >>>
> >>> Scenario               | IPv6 Ext-Headers | Result | Behavior
> >>> -----------------------|------------------|--------|---------------=

> >>> VXLAN (IPv6-in-IPv4)   | No               | PASS   | HW TSO enabled=

> >>> VXLAN (IPv6-in-IPv4)   | Yes              | PASS   | SW GSO fallbac=
k
> >>> Native IPv6            | No               | PASS   | HW TSO enabled=

> >>> Native IPv6            | Yes              | PASS   | SW GSO fallbac=
k
> >>>
> >>> Thanks again for the help!
> >> Please, if you will and can, take it over to cook it in a formal pat=
ch.
> > =

> > Otherwise I can.
> > =

> > The check is also needed for tunnels that set ENCAP_TYPE_IPPROTO, suc=
h
> > as sit. That condition can be removed as far as I can tell?
> > =

> > Only, I still do not see how this condition can have triggered, as
> > vlan_get_protocol(skb) should be htons(ETH_P_IP).
> > =

> > I built a simple reproducer using vxlan over veth in virtme-ng, while=

> > changing veth's NETIF_F_.._CSUM to reach this code. That indeed shows=

> > correct ETH_P_IP.
> > =

> > Tangxin, can you show a stack trace when this condition hits? For
> > instance by adding a WARN_ON_ONCE(1) inside that branch, or by using
> > bpftrace:
> > =

> > sudo bpftrace -e 'kfunc:netif_skb_features { if (args->skb->encapsula=
tion && args->skb->protocol =3D=3D 0xDD86) { @[kstack] =3D count(); } }'
> Hi Willem,
> =

> Sorry for the late reply.
> =

> I have tested this on Linux 7.0-rc4
> (commit f338e77383789c0cae23ca3d48adcc5e9e137e3c).
> =

> In my VXLAN (IPv6-in-IPv4) environment,
> vlan_get_protocol(skb) indeed returns htons(ETH_P_IP) as you expected.
> However, the condition is still triggered because skb_shinfo(skb)->gso_=
type
> contains SKB_GSO_TCPV6 (since the inner packet is IPv6 TCP).
>
> Below is the call trace captured via WARN_ON_ONCE when the condition is=
 hit:
> =

> WARNING: net/core/dev.c:3824 at gso_features_check+0xbc/0x158, CPU#10: =
python3/16193
> CPU: 10 UID: 0 PID: 16193 Comm: python3 Kdump: loaded Not tainted 7.0.0=
-rc4+ #12 PREEMPT
> Hardware name: Huawei TaiShan 200 (Model 2280)/BC82AMDD, BIOS 1.86 01/1=
0/2022
> pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : gso_features_check (net/core/dev.c:3824 (discriminator 1))
> lr : netif_skb_features (net/core/dev.c:3837)
> ...
> Call trace:
>  gso_features_check (net/core/dev.c:3824 (discriminator 1))
>  netif_skb_features (net/core/dev.c:3837)
>  validate_xmit_skb (net/core/dev.c:4012)
>  validate_xmit_skb_list (net/core/dev.c:4075)
>  sch_direct_xmit (net/sched/sch_generic.c:335)
>  __dev_xmit_skb (net/core/dev.c:4255 (discriminator 4))
>  __dev_queue_xmit (net/core/dev.c:4804)
>  neigh_hh_output (./include/net/neighbour.h:541)
>  ip_finish_output2 (./include/net/neighbour.h:554 net/ipv4/ip_output.c:=
237)
>  __ip_finish_output (net/ipv4/ip_output.c:315 net/ipv4/ip_output.c:297)=

>  ip_finish_output (net/ipv4/ip_output.c:325)
>  ip_output (./include/linux/netfilter.h:307 net/ipv4/ip_output.c:438)
>  ip_local_out (net/ipv4/ip_output.c:134)
>  iptunnel_xmit (net/ipv4/ip_tunnel_core.c:99 (discriminator 4))
>  udp_tunnel_xmit_skb (net/ipv4/udp_tunnel_core.c:195) [udp_tunnel]
>  vxlan_xmit_one (drivers/net/vxlan/vxlan_core.c:2544) [vxlan]
>  vxlan_xmit (drivers/net/vxlan/vxlan_core.c:2832) [vxlan]
>  dev_hard_start_xmit (net/core/dev.c:3889)
>  __dev_queue_xmit (net/core/dev.c:4836)
>  ... (TCP/IPv6 stack)
>  tcp_sendmsg (net/ipv4/tcp.c:1465)
>  inet6_sendmsg (net/ipv6/af_inet6.c:653 (discriminator 2))
> =

> look forward to your patch.

Thanks for the extra info and testing. Sent:

https://lore.kernel.org/netdev/20260320190148.2409107-1-willemdebruijn.ke=
rnel@gmail.com/T/#u


