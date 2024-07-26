Return-Path: <netdev+bounces-113185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DFB93D235
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 13:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 170461C20E74
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 11:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941AD179204;
	Fri, 26 Jul 2024 11:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WsbqXiDd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724301B27D
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 11:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721992999; cv=none; b=F0BDnjADUgZrtOA90/xZv7ygWr7ddL7SB2tdZQttSiaDiHv+4E7M83E16EIbk/5t9fr7DyFeKJZxZA2Y9n3b1pW2HIPgatPDoNiNdYlwErsh2rcOelo3tFDCV8KxOo8S+7jy0vlQAeJZqRXSU/GUTO4BWPR3Y3vX9XPz/k8MVKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721992999; c=relaxed/simple;
	bh=g3iYoJ/xOC5CXkzy85OGGPvaJijHXAGfBV9Ykxb/4/I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ieKFRM+p6SRQ+rA8O5lu13IhA2wOYRkl0+wfWhC/oak55PcfwRaBTLEX3ZOTwBzXgooFqPWrcYTHWrK8Cbua56sHPEgIhWbvzzcWALGGqhJcR0VHylU/IdorOosXB/Kls3qmy/QbeQninqsZVdOLQd7G+zyZ9HOiQW2yMC9epmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=WsbqXiDd; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ef1c12ae23so13444711fa.0
        for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 04:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1721992995; x=1722597795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Zs5/9dh9kzNZF0soHgfl7sH+psZq9eVrKa0HlKF7us=;
        b=WsbqXiDdHxxUWzU3frAt5E0cT9uPYkRVSmRjfJ9gJTr+S+CAaSqFJ2giUEtdIkwz16
         iaFuDS6ykq6UzLXOTyjwnEzAbKXE6QVn2q2JxR5E0q7htB5llGZ+rbRxuuVRIPnYNrCl
         Nghn0MHtPXLou1GJSyVjo2efDN6AZqav8G8bf5KgeLF8koEa4soPgzJrLpezEBouOy7a
         2p4+eXjsw82SNKAn5s0PMeLHwFTIWEm0W4YL9amZ0UqwAeFoiuv1RomkLK5WhTrQ9ARj
         87jPF+qkOrpQKGRW7fZ9Ewtm4IzDD2hNLB6qwpwhmDMVGOjkNmCCsn5aoJVNXYK9RiY/
         kEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721992995; x=1722597795;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Zs5/9dh9kzNZF0soHgfl7sH+psZq9eVrKa0HlKF7us=;
        b=Cg6lZRNugRXUSSiiM+n5ORdRvyvLI/SDvrfAwaIkzUfYo1+EAZ7P+sCB/44GNQk2xo
         6Ae8o2yp2qJjJ04h1Oh/d7RS6OHM404jSl578NwH7CsO1h0lNTLNCI16HcoLbkIAy1x4
         0z8t7KWfkCpSg4F1+O2dpqzeltEzkExzAQQ5JbeLBXJXgN421gxVw2pP61snkZweoP2E
         iRs66txkgSY8d5xG6PN/eJsUdtcJU5aNp4XQt9pyYASVLzCKFliofN1D2LKsxXWRMo5s
         2TmfOOeR+4ADN1B8NfTifohy23577gsIkhUZqsEBv5D1GbB7nx8eX9ICItmc4Lua+qBq
         dSGQ==
X-Gm-Message-State: AOJu0Yxqae35NHpv/cFJzfJnbTf78cDe2lr4TBZHiBeJKhqICIwUnjNr
	XdAHgezabuzQiEU1cSZfaws9qLuxC1TyNMMc4A8rkFWfOs/y0H+vJ+SaVTQ8+SY=
X-Google-Smtp-Source: AGHT+IEes6Dgxn/QOeEAPPRRjxbv/ux9ajPyEOzR9oCgq7dxIkgd125b3gXuNn63KnWaFlM+9+dT/w==
X-Received: by 2002:a2e:a9a0:0:b0:2ef:2c20:e064 with SMTP id 38308e7fff4ca-2f039cac142mr50798011fa.12.1721992995390;
        Fri, 26 Jul 2024 04:23:15 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:4c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63590d1esm1807685a12.27.2024.07.26.04.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 04:23:14 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Willem de Bruijn <willemb@google.com>,
  kernel-team@cloudflare.com,
  syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com
Subject: Re: [PATCH net 1/2] udp: Mark GSO packets as CHECKSUM_UNNECESSARY
 early on on output
In-Reply-To: <CAF=yD-LLPPg77MUhdXrHUVJj4o2+rnOC_qsHc_8tKurTsAGkYw@mail.gmail.com>
	(Willem de Bruijn's message of "Thu, 25 Jul 2024 10:21:50 -0400")
References: <20240725-udp-gso-egress-from-tunnel-v1-0-5e5530ead524@cloudflare.com>
	<20240725-udp-gso-egress-from-tunnel-v1-1-5e5530ead524@cloudflare.com>
	<CAF=yD-LLPPg77MUhdXrHUVJj4o2+rnOC_qsHc_8tKurTsAGkYw@mail.gmail.com>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Fri, 26 Jul 2024 13:23:13 +0200
Message-ID: <87h6ccl7mm.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 10:21 AM -04, Willem de Bruijn wrote:
> On Thu, Jul 25, 2024 at 5:56=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.=
com> wrote:
>>
>> In commit 10154dbded6d ("udp: Allow GSO transmit from devices with no
>> checksum offload") we have added a tweak in the UDP GSO code to mark GSO
>> packets being sent out as CHECKSUM_UNNECESSARY when the egress device
>> doesn't support checksum offload. This was done to satisfy the offload
>> checks in the gso stack.
>>
>> However, when sending a UDP GSO packet from a tunnel device, we will go
>> through the TX path and the GSO offload twice. Once for the tunnel devic=
e,
>> which acts as a passthru for GSO packets, and once for the underlying
>> egress device.
>>
>> Even though a tunnel device acts as a passthru for a UDP GSO packet, GSO
>> offload checks still happen on transmit from a tunnel device. So if the =
skb
>> is not marked as CHECKSUM_UNNECESSARY or CHECKSUM_PARTIAL, we will get a
>> warning from the gso stack.
>
> I don't entirely understand. The check should not hit on pass through,
> where segs =3D=3D skb:
>
>         if (segs !=3D skb && unlikely(skb_needs_check(skb, tx_path) &&
> !IS_ERR(segs)))
>                 skb_warn_bad_offload(skb);
>

That's something I should have explained better. Let me try to shed some
light on it now. We're hitting the skb_warn_bad_offload warning because
skb_mac_gso_segment doesn't return any segments (segs =3D=3D NULL).

And that's because we bail out early out of __udp_gso_segment when we
detect that the tunnel device is capable of tx-udp-segmentation
(GSO_UDP_L4):

	if (skb_gso_ok(gso_skb, features | NETIF_F_GSO_ROBUST)) {
		/* Packet is from an untrusted source, reset gso_segs. */
		skb_shinfo(gso_skb)->gso_segs =3D DIV_ROUND_UP(gso_skb->len - sizeof(*uh),
							     mss);
		return NULL;
	}

It has not occurred to me before, but in the spirit of commit
8d74e9f88d65 "net: avoid skb_warn_bad_offload on IS_ERR" [1], we could
tighten the check to exclude cases when segs =3D=3D NULL. I'm thinking of:

	if (segs !=3D skb && !IS_ERR_OR_NULL(segs) && unlikely(skb_needs_check(skb=
, tx_path)))
		skb_warn_bad_offload(skb);

That would be an alternative. Though I'm not sure I understand the
consequences of such change fully yet. Namely if we're wouldn't be
losing some diagnostics from the bad offload warning.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D8d74e9f88d65af8bb2e095aff506aa6eac755ada

>> Today this can occur in two situations, which we check for in
>> __ip_append_data() and __ip6_append_data():
>>
>> 1) when the tunnel device does not advertise checksum offload, or
>> 2) when there are IPv6 extension headers present.
>>
>> To fix it mark UDP_GSO packets as CHECKSUM_UNNECESSARY early on the TX
>> path, when still in the udp layer, since we need to have ip_summed set up
>> correctly for GSO processing by tunnel devices.
>
> The previous patch converted segments post segmentation to
> CHECKSUM_UNNECESSARY, which is fine as they had
> already been checksummed in software, and CHECKSUM_NONE
> packets on egress are common.
>
> This creates GSO packets without CHECKSUM_PARTIAL.
> Segmentation offload always requires checksum offload. So these
> would be weird new packets. And having CHECKSUM_NONE (or
> equivalent), but entering software checksumming is also confusing.

I agree this is confusing to reason about. That is a GSO packet with
CHECKSUM_UNNECESSARY which has not undergone segmentation and csum
offload in software.

Kind of related, I noticed that turning off tx-checksum-ip-generic with
ethtool doesn't disable tx-udp-segmentation. That looks like a bug.

> The crux is that I don't understand why the warning fires on tunnel
> exit when no segmentation takes place there. Hopefully we can fix
> in a way that does not introduce these weird GSO packets (but if
> not, so be it).

Attaching a self contained repro which I've been using to trace and
understand the GSO code:

---8<---

sh# cat repro-full.py
#!/bin/env python
#
# `modprobe ip6_tunnel` might be needed.
#

import os
import subprocess
import shutil
from socket import *

UDP_SEGMENT =3D 103

cmd =3D [shutil.which("ip"), "-batch", "/dev/stdin"]
script =3D b"""
link set dev lo up

link add name sink mtu 1540 type dummy
addr add dev sink fd11::2/48 nodad
link set dev sink up

tunnel add iptnl mode ip6ip6 remote fd11::1 local fd11::2 dev sink
link set dev iptnl mtu 1500
addr add dev iptnl fd00::2/48 nodad
link set dev iptnl up
"""
proc =3D subprocess.Popen(cmd, stdin=3Dsubprocess.PIPE)
proc.communicate(input=3Dscript)

os.system("ethtool -K sink tx-udp-segmentation off > /dev/null")
os.system("ethtool -K sink tx-checksum-ip-generic off > /dev/null")

# Alternatively to hopopts:
# os.system("ethtool -K iptnl tx-checksum-ip-generic off")

hopopts =3D b"\x00" * 8
s =3D socket(AF_INET6, SOCK_DGRAM)
s.setsockopt(IPPROTO_IPV6, IPV6_HOPOPTS, hopopts)
s.setsockopt(SOL_UDP, UDP_SEGMENT, 145)
s.sendto(b"x" * 3000, ("fd00::1", 9))
sh# perf ftrace -G __skb_gso_segment --graph-opts noirqs,depth=3D5 -- unsha=
re -n python repro-full.py
# tracer: function_graph
#
# CPU  DURATION                  FUNCTION CALLS
# |     |   |                     |   |   |   |
 16)               |  __skb_gso_segment() {
 16)   0.288 us    |    irq_enter_rcu(); /* =3D 0xffffa00c03d89ac0 */
 16)   0.172 us    |    idle_cpu(); /* =3D 0x0 */
 16)               |    skb_mac_gso_segment() {
 16)   0.184 us    |      skb_network_protocol(); /* =3D 0xdd86 */
 16)   0.161 us    |      __rcu_read_lock(); /* =3D 0x2 */
 16)               |      ipv6_gso_segment() {
 16)               |        rcu_read_lock_held() {
 16)   0.151 us    |          rcu_lockdep_current_cpu_online(); /* =3D 0x1 =
*/
 16)   0.514 us    |        } /* rcu_read_lock_held =3D 0x1 */
 16)               |        rcu_read_lock_held() {
 16)   0.152 us    |          rcu_lockdep_current_cpu_online(); /* =3D 0x1 =
*/
 16)   0.459 us    |        } /* rcu_read_lock_held =3D 0x1 */
 16)               |        rcu_read_lock_held() {
 16)   0.151 us    |          rcu_lockdep_current_cpu_online(); /* =3D 0x1 =
*/
 16)   0.459 us    |        } /* rcu_read_lock_held =3D 0x1 */
 16)               |        udp6_ufo_fragment() {
 16)   0.237 us    |          __udp_gso_segment(); /* =3D 0x0 */
 16)   0.727 us    |        } /* udp6_ufo_fragment =3D 0x0 */
 16)   3.049 us    |      } /* ipv6_gso_segment =3D 0x0 */
 16)   0.171 us    |      __rcu_read_unlock(); /* =3D 0x1 */
 16)   4.748 us    |    } /* skb_mac_gso_segment =3D 0x0 */
 16)               |    skb_warn_bad_offload() {
 [...]
 16) ! 785.215 us  |    } /* skb_warn_bad_offload =3D 0x0 */
 16) ! 800.986 us  |  } /* __skb_gso_segment =3D 0x0 */
 16)               |  __skb_gso_segment() {
 16)   0.394 us    |    irq_enter_rcu(); /* =3D 0xffffa00c03d89ac0 */
 16)   0.181 us    |    idle_cpu(); /* =3D 0x0 */
 16)               |    skb_mac_gso_segment() {
 16)   0.182 us    |      skb_network_protocol(); /* =3D 0xdd86 */
 16)   0.178 us    |      __rcu_read_lock(); /* =3D 0x3 */
 16)               |      ipv6_gso_segment() {
 16)               |        rcu_read_lock_held() {
 16)   0.155 us    |          rcu_lockdep_current_cpu_online(); /* =3D 0x1 =
*/
 16)   0.556 us    |        } /* rcu_read_lock_held =3D 0x1 */
 16)               |        rcu_read_lock_held() {
 16)   0.159 us    |          rcu_lockdep_current_cpu_online(); /* =3D 0x1 =
*/
 16)   0.480 us    |        } /* rcu_read_lock_held =3D 0x1 */
 16)               |        rcu_read_lock_held() {
 16)   0.159 us    |          rcu_lockdep_current_cpu_online(); /* =3D 0x1 =
*/
 16)   0.480 us    |        } /* rcu_read_lock_held =3D 0x1 */
 16)               |        ip6ip6_gso_segment() {
 16) + 22.176 us   |          ipv6_gso_segment(); /* =3D 0xffffa00c03018c00=
 */
 16) + 24.875 us   |        } /* ip6ip6_gso_segment =3D 0xffffa00c03018c00 =
*/
 16) + 27.416 us   |      } /* ipv6_gso_segment =3D 0xffffa00c03018c00 */
 16)   0.230 us    |      __rcu_read_unlock(); /* =3D 0x2 */
 16) + 29.065 us   |    } /* skb_mac_gso_segment =3D 0xffffa00c03018c00 */
 16) + 32.828 us   |  } /* __skb_gso_segment =3D 0xffffa00c03018c00 */
sh#

