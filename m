Return-Path: <netdev+bounces-292035-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AmMAgBHFmofkQcAu9opvQ
	(envelope-from <netdev+bounces-292035-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:21:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 928E65DE33E
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B8D33015726
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 01:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C253C27F017;
	Wed, 27 May 2026 01:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="OlW3wD6G";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="sp077lBi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C635523E358;
	Wed, 27 May 2026 01:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779844859; cv=none; b=JsTgFPvJylvWMeQYEr4h3w48HP6K0rqvhoC9BxkFOFs6GzufgAZPkyml6Awj2tWvqOOpD9TEMQMjClFFJh6Q4QGVrB3LPpLKpUpwSLxQzWEqDoXWS1wsdHK1AXZi/ewOjAdecuzwmlBntIpqf1w9qC9JlHvGqh2E2wrPQNLDO3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779844859; c=relaxed/simple;
	bh=rmzxCV1fQMUM8RaM/au7nAiaC53VZ1bvR0miMdjNZqc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CxT1AVzgv7j4OZkGWkFeU8P6iQSWafA7hVqxNvy2iPUkyMuOR9Mg01bmVPwQ78fDO8CCmwwEU05cwL+hjdc+ERCIYcrpi1MP0TQNh9hPeBLULGMV9JSthvnYupDN/7ZBNsDAMhvQrzQiGS7AvNBkWS2cqH6xOPwkpA9JrRBxEOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=OlW3wD6G; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=sp077lBi; arc=none smtp.client-ip=160.80.4.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 64R19CTX031323;
	Wed, 27 May 2026 03:09:17 +0200
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id D8CBA1212D0;
	Wed, 27 May 2026 03:09:07 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1779844148; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qdBgm1t+fmIb3wnNhdeSM4eLTgwLbMEgW/7ozpcDR7o=;
	b=OlW3wD6GU/WGHfk+q+gTSu8GlsZNQ+9kEm59jHv0SPpsAeYwc3aQvhuQBA47jNhWQh9GSX
	z7TqqnUgy+YP1PBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1779844148; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qdBgm1t+fmIb3wnNhdeSM4eLTgwLbMEgW/7ozpcDR7o=;
	b=sp077lBiXsbD3h+LclJ/uETlyQd1IYSKCWb4Bdm24/ae+b22XgxFmn+McorwyTbT+7WIFo
	Dn+J7dFPIzTLtZ7ALI/9hXEc6ek2VZJZmKCMo8lReFXL1QGRLWBfzEpnpCAj3pSwhKTwzE
	BxCgzDZ3V+7NSQCmGA7gGILOZjHqPyUWurfDEa2dW42qCRqmpZxWpBAuZKECBQnYdiAZ0F
	wn/hNiIvV9kuz0qfiTZCeg6fxQuS8wKypeFu7UHuq131JDuAyNxSrjC8FQwTnkb/Z4Z1xx
	3cT18xm9CGRspsumV/3vkJMR83wuc0PEWLtAo/MtZBDiZ5b2yf2Ho1DAA5wUrA==
Date: Wed, 27 May 2026 03:09:07 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, David Ahern <dsahern@kernel.org>,
        Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman
 <horms@kernel.org>,
        Justin Iurman <justin.iurman@gmail.com>,
        Shuah Khan
 <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan
 <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, stefano.salsano@uniroma2.it,
        ahabdels@cisco.com, Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH v2 2/7] seg6: add End.M.GTP4.E behavior
Message-Id: <20260527030907.52bc613c27be26d6c1d59e36@uniroma2.it>
In-Reply-To: <20260505-seg6-mobile-v2-2-9e8022bdfdb6@gmail.com>
References: <20260505-seg6-mobile-v2-0-9e8022bdfdb6@gmail.com>
	<20260505-seg6-mobile-v2-2-9e8022bdfdb6@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniroma2.it,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[uniroma2.it:s=ed201904,uniroma2.it:s=rsa201904];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292035-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lwn.net,linuxfoundation.org,vger.kernel.org,uniroma2.it,cisco.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.mayer@uniroma2.it,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[uniroma2.it:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.897];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,uniroma2.it:mid,uniroma2.it:dkim,rfc-editor.org:url]
X-Rspamd-Queue-Id: 928E65DE33E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 05 May 2026 01:30:12 +0900
Yuya Kusakabe <yuya.kusakabe@gmail.com> wrote:

Hi Yuya,

I do not repeat below the points already addressed in the cover letter
thread (drop reason granularity/prep series, SEG6_LOCAL_OIF/VRF removal,
selftest C helper) and in my reply to patch 1 (SRH validation semantics,
HMAC handling).

> Add the End.M.GTP4.E behavior (RFC 9433 Section 6.6), which
> decapsulates an inbound SRv6 packet and re-encapsulates the inner
> T-PDU in IPv4/UDP/GTP-U toward a legacy IPv4 receiver, including an
> optional PDU Session extension header.
>
> The SID layout per RFC 9433 Section 6.6 Figure 9 is:
>
>   |<-- locator -->|<-- IPv4 DA -->|<-- Args.Mob.Session -->|<-pad->|
>
> The IPv4 destination is recovered from the SID; the IPv4 source is
> recovered from the inbound IPv6 source by overlaying the configured
> src_addr template with the v4_mask_len bits at bit offset
> v6_src_prefix_len (default 64) of the IPv6 SA, per RFC 9433
> Section 6.6 Figure 10.  Args.Mob.Session is the 40-bit
> field defined in RFC 9433 Section 6.1: QFI(6) | R(1) | U(1) | PDU
> Session ID(32).
>
> DSCP / ECN / Hop Limit -> TTL are propagated from the inbound IPv6
> outer to the new IPv4 outer per RFC 6040.  GSO packets that would
> not fit the egress route MTU after adding the outer headers are
> rejected explicitly because the GSO segmenter cannot fix this up
> after the network protocol has changed from IPv6 to IPv4.
>
> When net.netfilter.nf_hooks_lwtunnel=1, the inner T-PDU traverses
> NF_INET_PRE_ROUTING between the SRv6 strip and the GTP-U push,
> mirroring End.DX4 / End.DX6.
>
> Add four drop reasons used here to dropreason-core.h:
> SEG6_MOBILE_BAD_SID, SEG6_MOBILE_BAD_GTPU, SEG6_MOBILE_BAD_INNER,
> and SEG6_MOBILE_MTU_EXCEEDED.
>
> Configuration:
>
>   ip -6 route add 2001:db8::/32 \
>       encap seg6local action End.M.GTP4.E \
>           src 2001:db8:2::1 v4_mask_len 32 \
>       dev <dev>

There are three issues with the End.M.GTP4.E UAPI behavior:

(1) In the example, v4_mask_len = 32 and the src value is required but not
used.

seg6_mobile_v4_sa() builds the output IPv4 SA from two parts:

  sa_bits = min(v4_mask_len, 32)
  top sa_bits        from the inbound IPv6 SA
  low (32 - sa_bits) from src

With sa_bits = 32, all 32 bits of the IPv4 SA come from the inbound IPv6 SA
at bit offset v6_src_prefix_len, and no bit of src is part of the IPv4 SA.
The src "2001:db8:2::1" in the example is read and never used.

A required UAPI attribute that has no effect on the output cannot be
relaxed after merge, so this needs to be revised. Either v4_mask_len = 32
should not require src, or src should not be a required attribute.

(2) With v4_mask_len < 32, the low bits of the IPv4 SA that the inbound
packet does not carry come from src.

Configuration:

  src 2001:db8::a00:05cd:0:0   v4_mask_len 24
  v6_src_prefix_len 64        (default, as this attr is optional)

seg6_mobile_v4_sa() reads a 32-bit window from src at bit offset 64
(= v6_src_prefix_len), then replaces the top 24 bits with bits read from
the inbound IPv6 SA at the same offset.

  src bytes:    20 01 0d b8 00 00 00 00 0a 00 05 cd 00 00 00 00
                                        ^^^^^^^^^^^
                                        offset 64..95: 0a 00 05 cd

  Inbound 2001:db8:1::0a00:05ff:0:0 bytes:
                20 01 0d b8 00 01 00 00 0a 00 05 ff 00 00 00 00
                                        ^^^^^^^^
                                        offset 64..87: 0a 00 05

  IPv4 SA out = (top 24 bits from inbound) | (low 8 bits from src)
              = 0a 00 05                   | cd
              = 10.0.5.205

The code only checks src is a 16-byte IPv6 address. For the same inbound
and v4_mask_len = 24, all of the following src values produce IPv4 SA out
10.0.5.205:

  src 2001:db8::a00:05cd:0:0          (offset 64..95: 10.0.5.205)
  src 2001:db8::110e:0bcd:0:0         (offset 64..95: 17.14.11.205)
  src dead:beef::ffff:eecd:1234:5678  (offset 64..95: 255.255.238.205)

The 32-bit windows encode three different IPv4 prefixes (10.0.5, 17.14.11,
255.255.238). Only the shared last byte (.205, "cd") reaches the IPv4 SA
out. The prefix bits are overwritten by the inbound. The other 12 bytes of
src outside the 32-bit window are accepted but discarded.

A required UAPI attribute that consumes so few bits and accepts arbitrary
values for the rest cannot be tightened after merge, so this needs to be
revised.

(3) With v4_mask_len < 32, the low bits of the IPv4 DA that the SID does
not carry are set to zero.

seg6_mobile_parse_gtp4_sid() takes v4_mask_len bits from the IPv6 DA at
offset locator_bits:

  IPv4 DA out = top v4_mask_len bits from IPv6 DA, low bits zero

With v4_mask_len = 24 the IPv4 DA out has the form X.Y.Z.0 and with
v4_mask_len = 16 it has the form X.Y.0.0. These look like network
addresses, not host addresses. RFC 9433 Section 6.6 does not specify how
the IPv4 DA is recovered when v4_mask_len < 32.
Together with the IPv4 SA behavior in (2), does it make sense to support
v4_mask_len values other than 32?

All three above are design issues in the End.M.GTP4.E UAPI.
They have to be addressed before this can land.

>
> Link: https://www.rfc-editor.org/rfc/rfc9433.html#section-6.6
> Link: https://www.rfc-editor.org/rfc/rfc6040
> Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
> ---
>  include/net/dropreason-core.h                      |  28 +
>  include/uapi/linux/seg6_local.h                    |   6 +
>  net/ipv6/seg6_local.c                              | 711 +++++++++++++++++++++
>  tools/testing/selftests/net/Makefile               |   1 +
>  .../selftests/net/srv6_end_m_gtp4_e_test.sh        | 486 ++++++++++++++
>  5 files changed, 1232 insertions(+)
>

> + [snip]

> diff --git a/include/uapi/linux/seg6_local.h b/include/uapi/linux/seg6_local.h
> index 45386fdfa821..b42cb526bb81 100644
> --- a/include/uapi/linux/seg6_local.h
> +++ b/include/uapi/linux/seg6_local.h
> @@ -29,6 +29,10 @@ enum {
>  	SEG6_LOCAL_VRFTABLE,
>  	SEG6_LOCAL_COUNTERS,
>  	SEG6_LOCAL_FLAVORS,
> +	SEG6_LOCAL_MOBILE_SRC_ADDR,

> + [snip]

> +/* Compose the IPv4 source address per RFC 9433 Section 6.6 Figure 10:
> + * the @v4_mask_len high bits are recovered from the inbound IPv6 SA at
> + * bit offset @v6_src_prefix_len (or /64 when 0); the remaining low bits
> + * come from @src_template at the same offset.
> + */
> +static __be32 seg6_mobile_v4_sa(const struct in6_addr *ip6_sa,
> +				const struct in6_addr *src_template,
> +				u8 v4_mask_len, u8 v6_src_prefix_len)
> +{
> +	u8 p_bits = v6_src_prefix_len ? : SEG6_MOBILE_V6_SRC_PREFIX_LEN_DEFAULT;
> +	u8 sa_bits = min_t(u8, v4_mask_len, 32);
> +	u64 template_field, sa_field, mask;
> +
> +	if ((unsigned int)p_bits + 32 > 128)
> +		return 0;

This check cannot trigger at runtime.
seg6_mobile_v4_validate() already rejects v6_src_prefix_len > 96 at install
time, and the default (64) leaves p_bits at most 96.
If kept for defense in depth, or if you plan to reuse this helper
elsewhere, the silent return of 0 produces an outgoing IPv4 packet with SA
= 0.0.0.0 without any error.
Nit: the (unsigned int) cast on p_bits can be removed.

> + [snip]

> +/* Return the bit length of the routing prefix that delivered @skb to
> + * the current End.* handler (i.e. the prefix length of the matched FIB
> + * entry).  This is the locator length used to position v4DA /
> + * Args.Mob.Session inside the SID per RFC 9433 Section 6.6.
> + */
> +static unsigned int seg6_mobile_skb_prefix_bits(const struct sk_buff *skb)
> +{
> +	struct dst_entry *dst = skb_dst(skb);
> +	struct rt6_info *rt;
> +	struct fib6_info *fib6;
> +	u8 plen = 128;
> +
> +	/* container_of() below requires an IPv6 dst. */
> +	if (!dst || dst->ops->family != AF_INET6)
> +		return 128;
> +
> +	rt = container_of(dst, struct rt6_info, dst);
> +	rcu_read_lock();
> +	fib6 = rcu_dereference(rt->from);
> +	if (fib6)
> +		plen = fib6->fib6_dst.plen;
> +	rcu_read_unlock();
> +
> +	return plen;
> +}

seg6_mobile_skb_prefix_bits() reads the matched route prefix length from
the FIB on every packet. The same value is fc_dst_len in struct
fib6_config, accessible from the cfg argument of the build_state callback.

Caching it in slwt->mobile_info at validate would let the data path read
minfo->locator_bits directly.
That avoids the rcu_read_lock/rcu_dereference per packet, the
container_of(dst, struct rt6_info, dst) cast, and the 128 fallback. It also
removes one dependency on skb_dst at runtime.

The operator cannot configure the IPv4 DA to start at a position different
from where the route prefix ends. Is this intentional?

> + [snip]

> +
> +/* Push a GTP-U header on top of @skb.  When @pdu_type_set is true the
> + * GTPv1 long header (with the EH bit set) is followed by a 4-byte
> + * PDU Session extension header (3GPP TS 38.415); @pdu_type selects
> + * the PDU Type field (0 for downlink, 1 for uplink, 2..15 reserved).
> + * When @pdu_type_set is false the GTPv1 short header is emitted with
> + * no PDU Session Container, regardless of @qfi.
> + */
> +static int seg6_mobile_push_gtpu(struct sk_buff *skb, u32 teid, u8 qfi,
> +				 u8 pdu_type, bool pdu_type_set)
> +{
> +	struct gtp1_header_long *gtphl;
> +	struct gtp1_header *gtph;
> +	struct seg6_mobile_pdu_session_ext *pdu_session;
> +
> +	if (!pdu_type_set) {
> +		if (skb_cow_head(skb, sizeof(*gtph)))
> +			return -ENOMEM;
> +
> +		gtph = (struct gtp1_header *)skb_push(skb, sizeof(*gtph));
> +		gtph->flags = SEG6_MOBILE_GTP1U_FLAGS_BASE;
> +		gtph->type = GTP_TPDU;
> +		gtph->length = htons(skb->len - sizeof(*gtph));
> +		gtph->tid = htonl(teid);
> +		return 0;
> +	}
> +
> +	if (skb_cow_head(skb, sizeof(*gtphl) + sizeof(*pdu_session)))
> +		return -ENOMEM;
> +
> +	pdu_session = skb_push(skb, sizeof(*pdu_session));
> +	pdu_session->ext_len = 1;
> +	pdu_session->pdu_type_spare = (pdu_type & 0xf) << 4;
> +	pdu_session->spare_qfi = qfi & SEG6_MOBILE_PDU_SESSION_QFI_MASK;
> +	pdu_session->next_ext = 0;
> +
> +	gtphl = (struct gtp1_header_long *)skb_push(skb, sizeof(*gtphl));
> +	gtphl->flags = SEG6_MOBILE_GTP1U_FLAGS_BASE | GTP1_F_EXTHDR;
> +	gtphl->type = GTP_TPDU;
> +	gtphl->length = htons(skb->len - sizeof(struct gtp1_header));
> +	gtphl->tid = htonl(teid);
> +	gtphl->seq = 0;
> +	gtphl->npdu = 0;
> +	gtphl->next = SEG6_MOBILE_PDU_SESSION_NH;
> +
> +	return 0;
> +}

Nit: skb_push() returns void * so the explicit casts on two of the three
calls are unnecessary.

> +
> +/* Per-skb context preserved across the NF_INET_PRE_ROUTING hook on
> + * the inner T-PDU exposed by End.M.GTP4.E.  After the outer SRv6 has
> + * been popped the inner IP is briefly visible to netfilter; the
> + * finish half then needs the synthesised IPv4 outer fields and the
> + * GTP-U identifiers to rebuild the packet.
> + */
> +struct seg6_mobile_gtp4_e_cb {
> +	__be32	v4_da;
> +	__be32	v4_sa;
> +	u32	teid;
> +	u8	qfi;
> +	u8	outer_tclass;
> +	u8	outer_hoplimit;
> +	u8	pdu_type;
> +	bool	pdu_type_set;
> +};
> +
> +#define SEG6_MOBILE_GTP4_E_CB(skb)	\
> +	((struct seg6_mobile_gtp4_e_cb *)((skb)->cb))
> +
> +static int input_action_end_m_gtp4_e_finish(struct net *net,
> +					    struct sock *sk,
> +					    struct sk_buff *skb)
> +{
> +	struct seg6_mobile_gtp4_e_cb cb = *SEG6_MOBILE_GTP4_E_CB(skb);
> +	struct dst_entry *orig_dst = skb_dst(skb);
> +	enum skb_drop_reason reason = SKB_DROP_REASON_SEG6_MOBILE_NOMEM;
> +	struct seg6_local_lwt *slwt;
> +	struct iphdr *iph;
> +	struct udphdr *uh;
> +
> +	slwt = seg6_local_lwtunnel(orig_dst->lwtstate);

orig_dst may be NULL or stale. This is an NF_HOOK finish callback, and
Netfilter processing during NF_INET_PRE_ROUTING can drop or replace the
skb dst. skb->cb is not guaranteed to be untouched (IPCB/IP6CB aliases it).

Noting this here only to track the issue we already discussed in the cover
letter thread. It is pre-existing, not introduced by your patchset.

> +
> +	/* Reject GSO packets that would not fit the egress IPv4 path after
> +	 * adding our outer headers; the GSO segmenter cannot fix this up
> +	 * once we have changed the network protocol from IPv6 to IPv4.
> +	 * The MTU check uses the inbound IPv6 dst as a conservative bound
> +	 * (the outbound IPv4 route is not known until ip_route_output_key()
> +	 * below); skip the check entirely when no MTU is known on the
> +	 * current dst.
> +	 */
> +	if (skb_is_gso(skb)) {
> +		unsigned int ovhd = sizeof(*iph) + sizeof(*uh) +
> +				    sizeof(struct gtp1_header_long) +
> +				    sizeof(struct seg6_mobile_pdu_session_ext);
> +		unsigned int mtu = dst_mtu(skb_dst(skb));
> +
> +		if (mtu && (mtu <= ovhd ||
> +			    !skb_gso_validate_network_len(skb, mtu - ovhd))) {
> +			reason = SKB_DROP_REASON_SEG6_MOBILE_MTU_EXCEEDED;
> +			goto drop;
> +		}
> +	}
> +
> +	/* Reserve worst-case headroom for the entire outer chain we are about
> +	 * to push: IPv4 + UDP + GTP-U long header + PDU Session extension.
> +	 * Subsequent skb_cow_head() calls inside seg6_mobile_push_gtpu() then
> +	 * become no-ops.
> +	 */
> +	if (skb_cow_head(skb,
> +			 sizeof(*iph) + sizeof(*uh) +
> +			 sizeof(struct gtp1_header_long) +
> +			 sizeof(struct seg6_mobile_pdu_session_ext)))

Same four-sizeof sum as ovhd above. Move ovhd to function scope to avoid
the repetition.

> +		goto drop;

input_action_end_m_gtp4_e_finish() never calls iptunnel_handle_offloads(),
so GSO of the outer UDP tunnel cannot operate correctly. The call should
go between skb_cow_head() and seg6_mobile_push_gtpu().

iptunnel_handle_offloads() snapshots network_header, transport_header,
and mac_header into the inner_* fields via skb_reset_inner_headers(),
and marks the skb as encapsulated. For the snapshot to capture the
inner correctly:

 i) transport_header has to be advanced past the inner IP header (the
    outer pull left it at the same position as network_header);

ii) mac_header has to be reset to the inner via skb_reset_mac_header()
    (the outer pull did not touch it, so it still points at the
    original outer link-layer position).

The inner protocol is not snapshotted by skb_reset_inner_headers() and
needs to be recorded separately, e.g. via skb_set_inner_protocol(skb,
htons(ETH_P_IP/IPV6)) after iptunnel_handle_offloads().

The fix needs end-to-end testing to confirm it works correctly.

> +
> +	if (seg6_mobile_push_gtpu(skb, cb.teid, cb.qfi, cb.pdu_type,
> +				  cb.pdu_type_set))
> +		goto drop;

The caller already reserves worst-case headroom, so the skb_cow_head()
calls inside seg6_mobile_push_gtpu() are always no-ops. Could they be
removed?

> +
> +	uh = skb_push(skb, sizeof(*uh));
> +	skb_reset_transport_header(skb);
> +	uh->source = htons(GTP1U_PORT);
> +	uh->dest = htons(GTP1U_PORT);

Does this mirror the drivers/net/gtp.c data-path convention
(src == dst == 2152)?

> +	uh->len = htons(skb->len);
> +	uh->check = 0; /* IPv4 UDP checksum optional; offload may set later */
> +
> +	iph = skb_push(skb, sizeof(*iph));
> +	skb_reset_network_header(skb);
> +	iph->version = 4;
> +	iph->ihl = sizeof(*iph) >> 2;
> +	iph->tos = cb.outer_tclass;
> +	iph->tot_len = htons(skb->len);
> +	iph->frag_off = htons(IP_DF);
> +	iph->ttl = cb.outer_hoplimit;
> +	iph->protocol = IPPROTO_UDP;
> +	iph->saddr = cb.v4_sa;
> +	iph->daddr = cb.v4_da;
> +	__ip_select_ident(net, iph, 1);
> +	iph->check = 0;
> +	iph->check = ip_fast_csum((unsigned char *)iph, iph->ihl);
> +
> +	skb->protocol = htons(ETH_P_IP);
> +	nf_reset_ct(skb);
> +	skb_dst_drop(skb);
> +
> +	/* The IPv4 outer is constructed locally from the SRv6 SID and the
> +	 * inbound IPv6 outer (RFC 9433 Section 6.6 Figure 9 / 10).  The
> +	 * IPv4 source address is synthesised, so it is not guaranteed to
> +	 * have a reverse route; ip_route_input() + dst_input() with
> +	 * rp_filter enabled would drop the packet.  Use an output route
> +	 * lookup with FLOWI_FLAG_ANYSRC and emit via dst_output(): the
> +	 * packet is locally originated from the IPv4 stack's perspective
> +	 * and traverses NF_INET_LOCAL_OUT.
> +	 */

The comment says the packet "traverses NF_INET_LOCAL_OUT", but dst_output()
goes through NF_INET_POST_ROUTING only. ip_local_out() is the one that
traverses LOCAL_OUT first.

This is also the only behavior in seg6_local.c that uses the output path,
bypassing NF_INET_FORWARD entirely. All the other behaviors use
ip_route_input() or seg6_lookup_any_nexthop() with dst_input(), including
the four other MUP behaviors in this patchset (End.M.GTP6.E, End.M.GTP6.D,
End.M.GTP6.D.Di, H.M.GTP4.D), so iptables/nftables FORWARD rules see the
traffic.

IMHO, gateways that do protocol transformation can set rp_filter=0. Using
ip_route_input() + dst_input() and documenting the rp_filter requirement is
preferable to silently bypassing the FORWARD chain.

> +	{

The anonymous { } scope block should be avoided. rt and fl4 should be
declared at the function top. The same pattern appears in other patches
of this series.

> +		struct rtable *rt;
> +		struct flowi4 fl4 = {
> +			.daddr = cb.v4_da,
> +			.saddr = cb.v4_sa,
> +			.flowi4_proto = IPPROTO_UDP,
> +			.flowi4_flags = FLOWI_FLAG_ANYSRC,
> +			.flowi4_oif = slwt->oif,
> +		};
> +
> +		rt = ip_route_output_key(net, &fl4);
> +		if (IS_ERR(rt)) {
> +			reason = SKB_DROP_REASON_IP_OUTNOROUTES;
> +			goto drop;
> +		}
> +		skb_dst_set(skb, &rt->dst);
> +		return dst_output(net, NULL, skb);
> +	}
> +
> +drop:
> +	kfree_skb_reason(skb, reason);
> +	return -EINVAL;
> +}
> +
> +/* RFC 9433 Section 6.6 -- End.M.GTP4.E
> + * Receives an SRv6 packet and re-encapsulates the inner payload in
> + * IPv4/UDP/GTP-U (with an optional PDU Session extension header)
> + * toward a legacy IPv4 gNB.
> + *
> + * When net.netfilter.nf_hooks_lwtunnel=1 the inner T-PDU is exposed
> + * to NF_INET_PRE_ROUTING after the outer IPv6/SRH is popped and
> + * before the GTP-U header is pushed.  This lets nftables / conntrack
> + * apply policy on the inner 5-tuple at the SR Gateway.
> + */
> +static int input_action_end_m_gtp4_e(struct sk_buff *skb,
> +				     struct seg6_local_lwt *slwt)
> +{
> +	u8 qfi, outer_tclass, outer_hoplimit;
> +	unsigned int outer_len;
> +	struct ipv6_sr_hdr *srh;
> +	struct in6_addr ip6_sa;
> +	struct seg6_mobile_gtp4_e_cb *cb;
> +	bool no_srh = false;
> +	int inner_nfproto;
> +	__be16 frag_off;
> +	__be32 v4_da, v4_sa;
> +	struct ipv6hdr *ip6h;
> +	u64 args_mob;
> +	u32 teid;
> +	u8 nh;
> +	int off;
> +	const struct seg6_mobile_info *minfo = &slwt->mobile_info;
> +	enum skb_drop_reason reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_SID;

Variable declarations are not in reverse Christmas tree order. Same issue
in the other functions introduced by this patch.

> +
> +	BUILD_BUG_ON(sizeof(struct seg6_mobile_gtp4_e_cb) >
> +		     sizeof_field(struct sk_buff, cb));
> +
> +	if (!pskb_may_pull(skb, sizeof(*ip6h))) {
> +		reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_INNER;
> +		goto drop;
> +	}

This pskb_may_pull pulls the OUTER IPv6 header, not the inner T-PDU.
BAD_INNER is the wrong drop reason here. BAD_SID or a general "packet too
short" would be more accurate.

> +
> +	ip6h = ipv6_hdr(skb);
> +	ip6_sa = ip6h->saddr;
> +
> +	/* Snapshot fields read from the IPv6 outer before any pskb_may_pull()
> +	 * call below: seg6_mobile_get_validated_srh() invokes pskb_may_pull()
> +	 * internally and may reallocate skb->head, invalidating @ip6h.  RFC
> +	 * 6040 outer-to-outer propagation: DSCP+ECN to TOS, HopLimit to TTL.
> +	 */
> +	outer_tclass = ipv6_get_dsfield(ip6h);
> +	outer_hoplimit = ip6h->hop_limit;

RFC 6040 Section 1.1 scopes the document to ECN field processing in
IP-in-IP tunnels. The patch cites it for DSCP and Hop Limit/TTL on a
protocol conversion (the IPv6 outer is popped, not encapsulated). Could
you clarify the RFC 6040 reference?

> +
> +	if (!seg6_mobile_parse_gtp4_sid(&ip6h->daddr,
> +					seg6_mobile_skb_prefix_bits(skb),
> +					minfo->v4_mask_len,
> +					&v4_da, &args_mob))
> +		goto drop;

See issue (3) above on the IPv4 DA zero-fill behavior of
seg6_mobile_parse_gtp4_sid() when v4_mask_len < 32.

> +
> +	/* Validate SRH (if present) per RFC 9433 Section 6.6 S01-S04: SL
> +	 * must be 0.  HMAC is enforced when the SRH is present and the
> +	 * kernel was built with CONFIG_IPV6_SEG6_HMAC.
> +	 */
> +	srh = seg6_mobile_get_validated_srh(skb, &no_srh);
> +	if (!srh && !no_srh) {
> +		reason = SKB_DROP_REASON_SEG6_MOBILE_INVALID_SRH_SL;
> +		goto drop;
> +	}

Same seg6_mobile_get_validated_srh() bug described in my reply to patch 1.

> +	if (srh && srh->segments_left != 0) {
> +		reason = SKB_DROP_REASON_SEG6_MOBILE_INVALID_SRH_SL;
> +		goto drop;
> +	}
> +
> +	/* @ip6h may have been invalidated by pskb_may_pull() inside
> +	 * seg6_mobile_get_validated_srh(); re-evaluate before any further
> +	 * dereference.
> +	 */
> +	ip6h = ipv6_hdr(skb);
> +
> +	teid = seg6_mobile_teid_from_args(args_mob);
> +	qfi = seg6_mobile_qfi_from_args(args_mob);
> +
> +	v4_sa = seg6_mobile_v4_sa(&ip6_sa, &minfo->src_addr, minfo->v4_mask_len,
> +				  minfo->v6_src_prefix_len);
> +
> +	/* RFC 9433 Section 6.6 upper-layer S02 mandates "Pop the IPv6
> +	 * header and all its extension headers".  Use ipv6_skip_exthdr()
> +	 * so HBH / Routing / Dest-Opts / Fragment headers are accounted
> +	 * for in addition to the SRH.  The terminal next-header value
> +	 * also selects NFPROTO_IPV4 / NFPROTO_IPV6 for the
> +	 * NF_INET_PRE_ROUTING hook below.
> +	 */
> +	nh = ip6h->nexthdr;
> +	off = ipv6_skip_exthdr(skb, sizeof(*ip6h), &nh, &frag_off);
> +	if (off < 0) {
> +		reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_INNER;
> +		goto drop;
> +	}
> +	outer_len = off;

Same BAD_INNER misuse: ipv6_skip_exthdr() is parsing the OUTER IPv6
extension headers to find where the inner T-PDU starts. If it fails, the
outer extension header chain is malformed or truncated, not the inner
payload.

frag_off is not checked after ipv6_skip_exthdr(). If the outer IPv6 packet
carries a Fragment header, the code continues to parse what follows as a
complete inner T-PDU, but the payload may be truncated or absent. Adding
"if (frag_off) goto drop;" after the ipv6_skip_exthdr() call would handle
this.

> +
> +	switch (nh) {
> +	case IPPROTO_IPIP:
> +		inner_nfproto = NFPROTO_IPV4;
> +		break;
> +	case IPPROTO_IPV6:
> +		inner_nfproto = NFPROTO_IPV6;
> +		break;
> +	default:
> +		inner_nfproto = -1;
> +		break;
> +	}
> +
> +	/* For inner IP traffic that may traverse NF_INET_PRE_ROUTING below,
> +	 * pull the full inner IP header into the linear area so a netfilter
> +	 * hook reading skb_transport_header() does not access stale data.
> +	 * Non-IP inner is forwarded as-is via the GTP-U T-PDU payload.
> +	 */
> +	if (!pskb_may_pull(skb, outer_len + ((inner_nfproto == NFPROTO_IPV4) ?
> +					     sizeof(struct iphdr) :
> +					     (inner_nfproto == NFPROTO_IPV6) ?
> +					     sizeof(struct ipv6hdr) : 0))) {
> +		reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_INNER;
> +		goto drop;
> +	}

The inner_nfproto-based size selection appears several times:
pskb_may_pull, skb->protocol, and skb_set_transport_header. Computing a
local inner_hdr_len once inside the switch would replace all three. Same
pattern in every other behavior.

> + [snip]

> +static int parse_nla_mobile_pdu_type(struct nlattr **attrs,
> +				     struct seg6_local_lwt *slwt,
> +				     struct netlink_ext_ack *extack)
> +{
> +	u8 t = nla_get_u8(attrs[SEG6_LOCAL_MOBILE_PDU_TYPE]);
> +
> +	/* 3GPP TS 38.415: PDU Type is a 4-bit field. */
> +	if (t > 0xf) {
> + [snip]

parse_nla_mobile_pdu_type() accepts the full 4-bit range 0..15, but the
function comment in seg6_mobile_push_gtpu() notes that only 0 (downlink)
and 1 (uplink) have a defined meaning.
RFC 9433 describes the E behaviors in the downlink packet flows (Section
5.3.1.2 and 5.3.2.2). How are PDU Type 1 (uplink) and the reserved values
supposed to be used with the GTP*.E behaviors?
UAPI cannot be tightened after merge. IMHO, if a type is not supported
yet, the parser should reject it and notify userspace.

> + [snip]

Thanks,

Ciao,
Andrea

