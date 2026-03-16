Return-Path: <netdev+bounces-268215-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLThOaE3uGkDagEAu9opvQ
	(envelope-from <netdev+bounces-268215-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:02:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C03B29DC90
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F915300463B
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B06301004;
	Mon, 16 Mar 2026 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cj1CvGqa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F179A1D514E
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773680150; cv=none; b=pQ6m0/Zk07xoVaqaLhx7HDyiE/TYNKz+DLUZLiurNoUfvJM0+yYpzU3NGWfh9IN21hjV2pjFSwm6RgLJH9wuGmW3vY07/vryD1lCTweTxBSjP3VhFxDCizTS7bPmJ80Jkmhaaobko/Kv4PvLC6EUQmzHz04Uzwk6A72KHhr1sQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773680150; c=relaxed/simple;
	bh=9FUVRfv9jp3i8A4zAT1Jgn9wzyoaHr/Z5ObrWLSnu7M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Zbh04B+bqQjntx1sbI6BQ4Ug2J1W+HvkGwIaW6THUlM8MOF5okqh4V4YJFc10d8qc2zudCkRSprSpuPRdpyFYty9kLG11WgCEV1UmK4iWltVKWumadtkAdOSW/08gwYTcqEAo1L79daPgsUck7AArYZBbQagHKTNqABHGe7rmWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cj1CvGqa; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79885f4a8ffso39576737b3.3
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 09:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773680148; x=1774284948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEQk6TShGfgUniH5e7A2QjrTMt8OtZfAyJLSs4yaYmU=;
        b=cj1CvGqaa5TH0nL/TgnSvi79MVJMT5aKklU50VHMKlGA9+WFi/iiy7VYjFVGlJ97ND
         idnNAVoiti0Hf+IsATFwOVFgCu33955Dsf/i3tAZtf99sAT+i2DxAjAhyqeh1uGSeOfi
         OmK6hfEA8HOocxOJsA1HhTTvB/mj16MotBHhvrK+JQ35Q4kDp7id9WKbR5FgZ/kpl/pp
         Od7OFHr1xAWb9o4VBXQBLV3IJ8hGdFzeJ4cO0tJ6gnhABph0A1BieZv2OCwA9Rso7SG1
         6und1KXWQ5F3QTSQ8amWv1FBmKjCovtjAdSqG+e/zxnpyklVy0ehxKwqk0GBPSYn5yMq
         dfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773680148; x=1774284948;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BEQk6TShGfgUniH5e7A2QjrTMt8OtZfAyJLSs4yaYmU=;
        b=Yly0yiLottB9r2iGLACQg0Gw68cWtRajLXqvB3E4iRixEXDlrlpNfdv+NNuu6xMEZa
         CWymYGWde2qCDPuTcmVwpGCiehqXGq+JYgD+d6QV/46wbbjT6zJnO9SOnwcXugSnDUEO
         5nPdKVSdSHqLEJaqzSR20EIj6FEISQRQs74Ux4xlz90ccnucK8pozURwfO3e4+EbQjYZ
         sgf+bKHO82tTJhF5+5IJZ58dLOCZKjK5v7k4h3kQiOb51zcYiO2GvBsD387f4P6DQ8Z/
         LHVtxvWCD7DeMm3zI82fzfpy9JqNcx+INQvkO/hatK26Bj0qzF8IU9jFzPIDgDBBYlGV
         GGkA==
X-Forwarded-Encrypted: i=1; AJvYcCVuOeUOXrQZ18ffNC4INKgYXK/KcNuraDOL3palv7/KlkfCyvBBuPe9iUgiMAF7EQTyqG9IBqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+zhl4dj3J0p1ba+I6BKkbyOoeVY8zOOcAGSk8eAaHPkE7hSDQ
	+q8got1nr4GgsRqqwDzhmcRzZuHwDtsMZfoSs6zQ9x4DegX366e/OrNE
X-Gm-Gg: ATEYQzzdRVIM8E4OH4f5PwPn/RAMZu1YnS650T9iRNOvpRB5ab2uj6EJruULJnWr5Xw
	gOG+b3ZBq/KSc7DhgSz0aSamw3mD0RFt6MZ188ZtFHwLVYogq65mgQlfED3ACG/Rs85sX5BQtEL
	xfUsrcT28/k7lu/yEnivIq3xaLpL1Y792c2JwarqseJTYQb30qpFDDVMl5Oqsp7B+tB2eAD1stu
	h4e1WXb99BRYuLvtaykBgbaZc7JrT+TKhGWvpJ7XeFt5xcxJB7gBOiw3G2TUz1MUuB1JeTvh6+N
	+BYf0AL4xvmcR435aO5ipr1PnmqK6iUc1gdLITgfR7zL/E5dOEHgHtwMHMrrfTnWW+nxsIwo/RA
	+e+a8GECCDHYR80B3ymxTHqkItT72iiAbpy6yZyuWaWmxfVHDJEYmwGZKfEEcKgbhepSzXJ3Vjs
	Zi2ZS8FCuKv6SGQIdfUjQfj6q6TovUK/BBc/mpqkFIP1lcEQM9tM1BMK3fRKoKhxrTY03zdacNH
	Xt1
X-Received: by 2002:a05:690c:298:b0:79a:2ef2:7f7 with SMTP id 00721157ae682-79a2ef20c4fmr93273177b3.23.1773680147650;
        Mon, 16 Mar 2026 09:55:47 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79a55cced89sm10809717b3.5.2026.03.16.09.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 09:55:46 -0700 (PDT)
Date: Mon, 16 Mar 2026 12:55:46 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 xietangxin <xietangxin@yeah.net>, 
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
Message-ID: <willemdebruijn.kernel.54bd6f56da38@gmail.com>
In-Reply-To: <efd6d059-a6e5-4fe4-bec4-84c74fb0b871@redhat.com>
References: <20250814105119.1525687-1-jramaseu@redhat.com>
 <0414e7e2-9a1c-4d7c-a99d-b9039cf68f40@yeah.net>
 <willemdebruijn.kernel.d12bc5fb9c16@gmail.com>
 <49dac359-326a-4f3a-8c18-9897ea7be498@redhat.com>
 <d6b8909d-705e-498d-ad9a-e61fa24c9d88@yeah.net>
 <9186ce75-4038-4467-b492-7a7821659842@redhat.com>
 <willemdebruijn.kernel.2e5ca236c023e@gmail.com>
 <efd6d059-a6e5-4fe4-bec4-84c74fb0b871@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268215-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com,yeah.net,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,fomichev.me,intel.com,gmx.fr,redhat.com];
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
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3C03B29DC90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Paolo Abeni wrote:
> On 3/14/26 5:19 PM, Willem de Bruijn wrote:
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
> =

> I was thinking about i.e. sctp over UDP tunnel where we have:
> =

> <outer IP{v6}><outer transport (UDP><SCTP>
> =

> and no inner IP{v6} header. Possibly it's better to replace:
> =

> 	skb->inner_protocol_type =3D=3D ENCAP_TYPE_IPPROTO
> =

> with:
> =

> 	!skb_inner_network_header_was_set()
> =

> (forcing segmentation if the the inner network header was not set).

Thanks. I was not aware of RFC 6951 UDP encap of SCTP w/o inner L3.
That check looks great to me too based on sctp_v4_xmit.

