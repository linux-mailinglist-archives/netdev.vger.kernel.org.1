Return-Path: <netdev+bounces-267768-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAM7I6GKtWmO1gAAu9opvQ
	(envelope-from <netdev+bounces-267768-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:19:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E552C28DD91
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3BEE301E95C
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC10199E89;
	Sat, 14 Mar 2026 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfzoqaCy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582B91FB1
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773505183; cv=none; b=B0v81/Z0FNdjQ9eGuTHImH6Xseot2iZdof3easta1f1WluadabEuRZdSnEcbLQG7LR72i4IrsQVAe/adsCJxV0hPcrRjRAQYV8fYzoChSCCqyZjOev+NL8elCEqYUH8KNYIR1x2+pSmXSRFyj4vrcmC/VWFbhK/fc0Sv6RCH6uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773505183; c=relaxed/simple;
	bh=wclvMr2TO+xQeF8FAi9ZPUZT02O+Gt6q3sXTFyG2FRs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ixhxfrCj0zysxTsYCVOzn041qUoLshRAr2QFQXJdFGQCAN3ezYD3gowoEoMwBq2doCLn69dGcYU/v2USLufGTOyXZ6VbkM5R0/9yQW0dpWUI1qGDFrlKRj6z76068GWuLXz4jlWm5fGtygAv/MtfWigJHIu0C3RYYCgsTNIWUqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfzoqaCy; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7927261a3acso27205897b3.0
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 09:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773505180; x=1774109980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDr8/eZ8WmFHEBoDdoIbLmzqRXdoWaH0335vpKqPN90=;
        b=kfzoqaCyk++y0YZV+g4GRXQFMZsSN/oi4BSrZqnT0Mryo0TSn6bBRluOqx/SjiOZaa
         f/9mo86jF1wQ7cihZMlxXZN6EHPknq96tOkh83/9NiSBK8Y8VpnaqtcNphrLtDd9r4y0
         Pwx5e+wqoHg2oFdDuqc03poteO0U+mvJrJs9X/A4LfSkLaIXDkRZfS20+Dr/LK/e5Rz4
         7bQmqHGVM2djcZ3yGJiBWIaUxMiqtIsDB710tcXEbQbXzOb+Gdkf3YecfXbozr4iMRwp
         gqpsgYc4Kzc0XHns0/sJUYfgj8BybvWLZVPbRdRcQJclDbqfKfXyVXrbUIZMkYvK8Zmu
         JusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773505180; x=1774109980;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GDr8/eZ8WmFHEBoDdoIbLmzqRXdoWaH0335vpKqPN90=;
        b=BFGLxM98KEXMuXrTAA2aVl0l/ni5kp/i6y83F6mh2B7M+Anrzu/OgW9Q7pTt6waiKJ
         ILzJHZ/DWzjB+JahGYJb922dKBdLFfuiRh2dVuT5TszYO7SLDqZ0UnryuxDRTGHDfx3g
         9RWD7Typft6w90XnxcOMsuzoVmb46Xwa9WobFkNanP9Es1YV8Jif6uki/qK7uOr8zw0p
         bbYNyIsqV7HUJGpeuU1v04f6DbLLYARVq3hAO057QCsRIpqBkoiXh3/69XAP6hadPhZV
         Tm+JW8Pjs5lvrwT1Skf7tk6Yaz1EigzNLPuV2JPHD05yBLUz+YJl/cS0WwPvZAX5PMuG
         s6/A==
X-Forwarded-Encrypted: i=1; AJvYcCXZAKt02HstxUNXyJRucrjoMILtj5FLogZk0wEjYI+vQI/JEEAmIq57cmQ8XUoKXSU7czsPT8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/E7mfVSzM638QIKg6TBX5hA1INgDtX7Gf/YYvEBxxA0QosVjk
	Tdi97bu9nJnFer1nyYUGlSD2uZ16U44axdnhnwr+avX/GfPlE+J/FrQQ
X-Gm-Gg: ATEYQzyWrxNPMZkvHf0PUBgV6WZRcav8YOetCxAkQtL+cfBBFDD26Q/cVcTdjPFcbeh
	lBYdIQhANffi6VPP9ZHlg2fCwXTuqzNx85XwbfwsiyjMfhwiQhvo3kZky1vJ62cT9tFfvDFv+W3
	4IDcCgjRhEM/m2CXqtk7B+L/Y5BNqh+8B+4cKjZHhM+assrR993ZtU3DTPYG0hvaLUklywEaVBa
	XICG14e5X4FuCX8+lFCvu5CZP51VNWP53MMo4O9fGbuHSrlyREa+oxQsaCPKpCYHC5KumrHFzzR
	TryyK/Gmp1ezjBn7yiLSxotRpu766+W6a5N4udR8ozzC2UbGiN1tgKKqjCIWtnAP9xwCXdyOoFm
	Do/fjmSiSPKChSgSwuvQMdxxJecrSdqx/hyg/Nnb8iIg6h5wo1fKSiTa+EKA3b+XN1l5XXmimIj
	NVo9C2IjSu/ABkWcg8vmHJy8GfiMuG7+v8bf8DMECaZI/SA6S1gIdAAvTsra2qCLpmAjwCwkoMV
	B2gnWIEDx4VLd4=
X-Received: by 2002:a05:690c:dd4:b0:798:cdce:f358 with SMTP id 00721157ae682-79a1c187c9emr76163057b3.35.1773505180329;
        Sat, 14 Mar 2026 09:19:40 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64e65b628d1sm2879459d50.16.2026.03.14.09.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 09:19:38 -0700 (PDT)
Date: Sat, 14 Mar 2026 12:19:37 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 xietangxin <xietangxin@yeah.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
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
Message-ID: <willemdebruijn.kernel.2e5ca236c023e@gmail.com>
In-Reply-To: <9186ce75-4038-4467-b492-7a7821659842@redhat.com>
References: <20250814105119.1525687-1-jramaseu@redhat.com>
 <0414e7e2-9a1c-4d7c-a99d-b9039cf68f40@yeah.net>
 <willemdebruijn.kernel.d12bc5fb9c16@gmail.com>
 <49dac359-326a-4f3a-8c18-9897ea7be498@redhat.com>
 <d6b8909d-705e-498d-ad9a-e61fa24c9d88@yeah.net>
 <9186ce75-4038-4467-b492-7a7821659842@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267768-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,fomichev.me,intel.com,gmx.fr,redhat.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[redhat.com,yeah.net,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E552C28DD91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Paolo Abeni wrote:
> On 3/6/26 7:32 AM, xietangxin wrote:
> > On 3/5/2026 11:21 PM, Paolo Abeni wrote:
> >> On 3/5/26 3:57 PM, Willem de Bruijn wrote:
> >>> xietangxin wrote:
> >>>> =E5=9C=A8 2025/8/14 18:51, Jakub Ramaseuski =E5=86=99=E9=81=93:
> >>>>> When performing Generic Segmentation Offload (GSO) on an IPv6 pac=
ket that
> >>>>> contains extension headers, the kernel incorrectly requests check=
sum offload
> >>>>> if the egress device only advertises NETIF_F_IPV6_CSUM feature, w=
hich has =

> >>>>> a strict contract: it supports checksum offload only for plain TC=
P or UDP =

> >>>>> over IPv6 and explicitly does not support packets with extension =
headers.
> >>>>> The current GSO logic violates this contract by failing to disabl=
e the feature
> >>>>> for packets with extension headers, such as those used in GREoIPv=
6 tunnels.
> >>>>>
> >>>>> This violation results in the device being asked to perform an op=
eration
> >>>>> it cannot support, leading to a `skb_warn_bad_offload` warning an=
d a collapse
> >>>>> of network throughput. While device TSO/USO is correctly bypassed=
 in favor
> >>>>> of software GSO for these packets, the GSO stack must be explicit=
ly told not =

> >>>>> to request checksum offload.
> >>>>>
> >>>>> Mask NETIF_F_IPV6_CSUM, NETIF_F_TSO6 and NETIF_F_GSO_UDP_L4
> >>>>> in gso_features_check if the IPv6 header contains extension heade=
rs to compute
> >>>>> checksum in software.
> >>>>>
> >>>>> The exception is a BIG TCP extension, which, as stated in commit
> >>>>> 68e068cabd2c6c53 ("net: reenable NETIF_F_IPV6_CSUM offload for BI=
G TCP packets"):
> >>>>> "The feature is only enabled on devices that support BIG TCP TSO.=

> >>>>> The header is only present for PF_PACKET taps like tcpdump,
> >>>>> and not transmitted by physical devices."
> >>>>>
> >>>>> kernel log output (truncated):
> >>>>> WARNING: CPU: 1 PID: 5273 at net/core/dev.c:3535 skb_warn_bad_off=
load+0x81/0x140
> >>>>> ...
> >>>>> Call Trace:
> >>>>>  <TASK>
> >>>>>  skb_checksum_help+0x12a/0x1f0
> >>>>>  validate_xmit_skb+0x1a3/0x2d0
> >>>>>  validate_xmit_skb_list+0x4f/0x80
> >>>>>  sch_direct_xmit+0x1a2/0x380
> >>>>>  __dev_xmit_skb+0x242/0x670
> >>>>>  __dev_queue_xmit+0x3fc/0x7f0
> >>>>>  ip6_finish_output2+0x25e/0x5d0
> >>>>>  ip6_finish_output+0x1fc/0x3f0
> >>>>>  ip6_tnl_xmit+0x608/0xc00 [ip6_tunnel]
> >>>>>  ip6gre_tunnel_xmit+0x1c0/0x390 [ip6_gre]
> >>>>>  dev_hard_start_xmit+0x63/0x1c0
> >>>>>  __dev_queue_xmit+0x6d0/0x7f0
> >>>>>  ip6_finish_output2+0x214/0x5d0
> >>>>>  ip6_finish_output+0x1fc/0x3f0
> >>>>>  ip6_xmit+0x2ca/0x6f0
> >>>>>  ip6_finish_output+0x1fc/0x3f0
> >>>>>  ip6_xmit+0x2ca/0x6f0
> >>>>>  inet6_csk_xmit+0xeb/0x150
> >>>>>  __tcp_transmit_skb+0x555/0xa80
> >>>>>  tcp_write_xmit+0x32a/0xe90
> >>>>>  tcp_sendmsg_locked+0x437/0x1110
> >>>>>  tcp_sendmsg+0x2f/0x50
> >>>>> ...
> >>>>> skb linear:   00000000: e4 3d 1a 7d ec 30 e4 3d 1a 7e 5d 90 86 dd=
 60 0e
> >>>>> skb linear:   00000010: 00 0a 1b 34 3c 40 20 11 00 00 00 00 00 00=
 00 00
> >>>>> skb linear:   00000020: 00 00 00 00 00 12 20 11 00 00 00 00 00 00=
 00 00
> >>>>> skb linear:   00000030: 00 00 00 00 00 11 2f 00 04 01 04 01 01 00=
 00 00
> >>>>> skb linear:   00000040: 86 dd 60 0e 00 0a 1b 00 06 40 20 23 00 00=
 00 00
> >>>>> skb linear:   00000050: 00 00 00 00 00 00 00 00 00 12 20 23 00 00=
 00 00
> >>>>> skb linear:   00000060: 00 00 00 00 00 00 00 00 00 11 bf 96 14 51=
 13 f9
> >>>>> skb linear:   00000070: ae 27 a0 a8 2b e3 80 18 00 40 5b 6f 00 00=
 01 01
> >>>>> skb linear:   00000080: 08 0a 42 d4 50 d5 4b 70 f8 1a
> >>>>>
> >>>>> Fixes: 04c20a9356f283da ("net: skip offload for NETIF_F_IPV6_CSUM=
 if ipv6 header contains extension")
> >>>>> Reported-by: Tianhao Zhao <tizhao@redhat.com>
> >>>>> Suggested-by: Michal Schmidt <mschmidt@redhat.com>
> >>>>> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> >>>>> Signed-off-by: Jakub Ramaseuski <jramaseu@redhat.com>
> >>>>> ---
> >>>>> ---
> >>>>>  net/core/dev.c | 12 ++++++++++++
> >>>>>  1 file changed, 12 insertions(+)
> >>>>>
> >>>>> diff --git a/net/core/dev.c b/net/core/dev.c
> >>>>> index b28ce68830b2b..1d8a4d1da911e 100644
> >>>>> --- a/net/core/dev.c
> >>>>> +++ b/net/core/dev.c
> >>>>> @@ -3778,6 +3778,18 @@ static netdev_features_t gso_features_chec=
k(const struct sk_buff *skb,
> >>>>>  		if (!(iph->frag_off & htons(IP_DF)))
> >>>>>  			features &=3D ~NETIF_F_TSO_MANGLEID;
> >>>>>  	}
> >>>>> +
> >>>>> +	/* NETIF_F_IPV6_CSUM does not support IPv6 extension headers,
> >>>>> +	 * so neither does TSO that depends on it.
> >>>>> +	 */
> >>>>> +	if (features & NETIF_F_IPV6_CSUM &&
> >>>>> +	    (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
> >>>>> +	     (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
> >>>>> +	      vlan_get_protocol(skb) =3D=3D htons(ETH_P_IPV6))) &&
> >>>>> +	    skb_transport_header_was_set(skb) &&
> >>>>> +	    skb_network_header_len(skb) !=3D sizeof(struct ipv6hdr) &&
> >>>>> +	    !ipv6_has_hopopt_jumbo(skb))
> >>>>> +		features &=3D ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_GSO=
_UDP_L4);
> >>>>>  =

> >>>>>  	return features;
> >>>>>  }
> >>>> question about this patch affecting tunneled IPv6-in-IPv4 packets
> >>>>
> >>>> In our environment with a hinic NIC, we use VXLAN tunnels where
> >>>> the outer header is IPv4 and the inner is IPv6. After this commit,=

> >>>> large packets no longer use hardware TSO and fall back to software=
 segmentation.
> >>>>
> >>>> In the VXLAN IPv6-in-IPv4 case, `skb_shinfo(skb)->gso_type` includ=
es
> >>>> `SKB_GSO_TCPV6` (inner is IPv6 TCP), but the network header points=
 to the outer
> >>>> IPv4 header. Thus `skb_network_header_len(skb)` returns the IPv4 h=
eader length
> >>>> (usually 20), which is not equal to `sizeof(struct ipv6hdr)` (40).=
 This causes
> >>>> the condition to trigger and clears `NETIF_F_TSO6`, even though th=
e inner IPv6
> >>>> packet has no extension headers and the device is capable of handl=
ing TSO for
> >>>> such packets.
> >>>>
> >>>> Is it the intended behavior to disable TSO for all tunneled IPv6-i=
n-IPv4 packets
> >>>> when the NIC lacks NETIF_F_HW_CSUM, even if the inner IPv6 header =
has no extensions?
> >>>>
> >>>> Any feedback or guidance would be greatly appreciated.
> >>>
> >>> That is definitely unintended.
> >>>
> >>> Thanks for the clear analysis.
> >>>
> >>> I was about to write a refinement that might catch this case,
> >>> something like
> >>>
> >>> @@ -3819,8 +3819,10 @@ static netdev_features_t gso_features_check(=
const struct sk_buff *skb,
> >>>             (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
> >>>              (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
> >>>               vlan_get_protocol(skb) =3D=3D htons(ETH_P_IPV6))) &&
> >>> -           skb_transport_header_was_set(skb) &&
> >>> -           skb_network_header_len(skb) !=3D sizeof(struct ipv6hdr)=
)
> >>> +             ((!skb->encapsulation &&
> >>> +               skb_transport_header_was_set(skb) &&
> >>> +               skb_network_header_len(skb) !=3D sizeof(struct ipv6=
hdr)) ||
> >>> +              (skb_inner_network_header_len(skb) !=3D sizeof(struc=
t ipv6hdr))))
> >>>                 features &=3D ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | =
NETIF_F_GSO_UDP_L4);
> >>>
> >>> But, how are these VXLAN IPv6-in-IPv4 packets having
> >>> vlan_get_protocol(skb) =3D=3D htons(ETH_P_IPV6)?
> >>>
> >>> Shouldn't that be the protocol of the outer headr, so ETH_P_IP, and=

> >>> thus this branch not reached at all? (Which itself would leave a fa=
lse
> >>> positive as now an inner network header with extensions would not b=
e
> >>> caught..)
> >>
> >> Also the tunnel could have ENCAP_TYPE_IPPROTO, and likely we need to=

> >> disable csum even in that case? Possibly something alike the followi=
ng
> >> could work?
> >>
> >> Side note, I *think* that replacing SKB_GSO_UDP_L4 with separate
> >> SKB_GSO_UDPV4_L4 SKB_GSO_UDPV6_L4 would remove a bit of complexity i=
n
> >> serveral places, but I'm not sure how much invasive would be such a =
change.
> >>
> >> ---
> >> diff --git a/net/core/dev.c b/net/core/dev.c
> >> index 4af4cf2d63a4..f9824dfef376 100644
> >> --- a/net/core/dev.c
> >> +++ b/net/core/dev.c
> >> @@ -3769,6 +3769,22 @@ static netdev_features_t
> >> dflt_features_check(struct sk_buff *skb,
> >>  	return vlan_features_check(skb, features);
> >>  }
> >>
> >> +static bool skb_gso_has_extension_hdr(const struct sk_buff *skb)
> >> +{
> >> +	if (!skb->encapsulation)
> >> +		return ((skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
> >> +			(skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
> >> +			 vlan_get_protocol(skb) =3D=3D htons(ETH_P_IPV6))) &&
> >> +			skb_transport_header_was_set(skb) &&
> >> +			skb_network_header_len(skb) !=3D sizeof(struct ipv6hdr));
> >> +
> >> +	return (skb->inner_protocol_type =3D=3D ENCAP_TYPE_IPPROTO ||
> >> +		((skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
> >> +		  (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
> >> +		   inner_ip_hdr(skb)->version =3D=3D 6)) &&
> >> +		 skb_inner_network_header_len(skb) !=3D sizeof(struct ipv6hdr)));=

> >> +}
> >> +
> >>  static netdev_features_t gso_features_check(const struct sk_buff *s=
kb,
> >>  					    struct net_device *dev,
> >>  					    netdev_features_t features)
> >> @@ -3815,12 +3831,7 @@ static netdev_features_t gso_features_check(c=
onst
> >> struct sk_buff *skb,
> >>  	/* NETIF_F_IPV6_CSUM does not support IPv6 extension headers,
> >>  	 * so neither does TSO that depends on it.
> >>  	 */
> >> -	if (features & NETIF_F_IPV6_CSUM &&
> >> -	    (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
> >> -	     (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
> >> -	      vlan_get_protocol(skb) =3D=3D htons(ETH_P_IPV6))) &&
> >> -	    skb_transport_header_was_set(skb) &&
> >> -	    skb_network_header_len(skb) !=3D sizeof(struct ipv6hdr))
> >> +	if (features & NETIF_F_IPV6_CSUM && skb_gso_has_extension_hdr(skb)=
)
> >>  		features &=3D ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_GSO_UD=
P_L4);
> >>
> >>  	return features;
> >>
> > Hi Paolo, Willem,
> > =

> > Thank you both for the insightful analysis and the proposed fix.
> > =

> > I have backported and tested Paolo's patch in our environment with hi=
nic NIC.
> > We focused on the VXLAN (IPv6-in-IPv4) scenario and the Native IPv6 s=
cenario :
> > =

> > Scenario               | IPv6 Ext-Headers | Result | Behavior
> > -----------------------|------------------|--------|---------------
> > VXLAN (IPv6-in-IPv4)   | No               | PASS   | HW TSO enabled
> > VXLAN (IPv6-in-IPv4)   | Yes              | PASS   | SW GSO fallback
> > Native IPv6            | No               | PASS   | HW TSO enabled
> > Native IPv6            | Yes              | PASS   | SW GSO fallback
> > =

> > Thanks again for the help!
> Please, if you will and can, take it over to cook it in a formal patch.=


Otherwise I can.

The check is also needed for tunnels that set ENCAP_TYPE_IPPROTO, such
as sit. That condition can be removed as far as I can tell?

Only, I still do not see how this condition can have triggered, as
vlan_get_protocol(skb) should be htons(ETH_P_IP).

I built a simple reproducer using vxlan over veth in virtme-ng, while
changing veth's NETIF_F_.._CSUM to reach this code. That indeed shows
correct ETH_P_IP.

Tangxin, can you show a stack trace when this condition hits? For
instance by adding a WARN_ON_ONCE(1) inside that branch, or by using
bpftrace:

sudo bpftrace -e 'kfunc:netif_skb_features { if (args->skb->encapsulation=
 && args->skb->protocol =3D=3D 0xDD86) { @[kstack] =3D count(); } }'=

