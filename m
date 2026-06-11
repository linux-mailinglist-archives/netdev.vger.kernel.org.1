Return-Path: <netdev+bounces-297907-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o8DdAbMkKmr6jAMAu9opvQ
	(envelope-from <netdev+bounces-297907-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 05:00:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5240866DE99
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 05:00:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=m0rFJIjS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297907-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297907-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25F8C30701D1
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 03:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F71288C08;
	Thu, 11 Jun 2026 03:00:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37130311C2A
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 02:59:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781146800; cv=none; b=SY70d4SLstZ+uUm8zUke1NSIKNDYtk0z4Ywqq0dK4qAxKt4XOGM8k0yYIf7qMkrBAHXJyeJtGC5ETMlYsxq0tRZxQdcBdIdAe5mZBlpq2jBoNoaIdquJEFsAMLqLJruwCHLJsQbxg2wqOKn+8zx4r/NPgeTfXVzczi/rIXTARDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781146800; c=relaxed/simple;
	bh=VXQtPS98erG3uINeejISc2Pvz0T6AF9YAdqN+flVs5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vBfJ+OYrIm+iknorXGUWcaHHxKPiwoVOPuIqb2dHL1Bjq9luqJHvDTgkl52EGneayzVLdzzy1NCqmQu3fQSBj0ZAwQ0Ri/gV82n4XVxh8DQTS08Z8S28XCodXe4BNhnas21Tn+IlxHVOk64l9fxh3dFOGHegLFKn6EQbh2JVdeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0rFJIjS; arc=none smtp.client-ip=209.85.210.177
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8423efad617so4273458b3a.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 19:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781146798; x=1781751598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXQtPS98erG3uINeejISc2Pvz0T6AF9YAdqN+flVs5c=;
        b=m0rFJIjSMq5RE6Yz9DcsY+d6M1PU0s/39VNmzoSadCt59dLViccucbLslFDhvR1gLW
         sSh8hne7QACc+/r+2xoe4e/nwpKEDmupcIwNf+L1C77taf6uX+lKsqgNS1u0yTmntv1g
         Gcf+nH+Qaub0ObVSNBFt4dfbwXSh4HPU34ZxpTCrCe0Va2f2PRr2omjc6ghpof4VIoTb
         iYM38z1KRnJfK4mgmSGYt9pjb/NuAGSn63ogBcviLRnZAArnqfUyoxeHIzX4/HUF/QlY
         Iy9oP04AW/uaQawgzcFGvpDQ5Asmam891apIOAVaRzSyETGFyB9fpEX7sbw+je7H1/yc
         ugOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781146798; x=1781751598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VXQtPS98erG3uINeejISc2Pvz0T6AF9YAdqN+flVs5c=;
        b=WpEf1sU7stmbmDf2XjspRy4qkhdVsXnU0gLe6YJzaODc77phU4L4znNaPzJlCjRPEA
         DD3qlzNE+EjZGZ3uv0ZtJww2JZwD6IIJ089E2SZ+xtGvZkKUr+FukR0SaqP3nS6YIWho
         PgXZYefzwuPEOW+lSRPWY8SptWWoUddGzjRLWfhWhxqxP1zIFUSe4OPXzkgtoIpwFyWB
         sl9FAAjqq8nOgmbjagQQdNjwkG1ReSzS+siqinZPv5WAlbiAPgFKs5l3TyGP3epUpRep
         q/PDkbzYf7M5hITT7QRsG+ajpHhUVgqRbDmdB8c987cg8F3O8bsT0/+y0sdRLnxBKH/g
         Vusg==
X-Forwarded-Encrypted: i=1; AFNElJ80dJUfwWLpUgAEOP/tR3+KReJFh3UdOb5T3x43Etqn8S8/8PQq49c7A47WiLWjkPtJSwXDWd4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw7lWgbrmfhFwLdIoiidcq5kDyvpw9fcpO0diYkIxuWPWlmJPo
	gJ3gOi5oPs+9NKsdK04tM6ZdMdcyA9vv+PTsQqhc5/WKRBv0OIVtFTMf
X-Gm-Gg: Acq92OGJsQHK97i69H4anVQ455vGaHdikOpNUy/3EEJeyLzfGpg50jBBuvW8jHlov85
	ekeFzHE6LO3kezIJnA+s/bXNWEUJwtK/cbDshscd6mCB8p/VB8VEFMNQ+tMVGCZEPhOBVJnCK2U
	5KoJthiANdjL50b3TtnVDIeqYhczcGRgxOJg+u711+0yWRObQ66GCtOfrrKVhdFUqPE++FtMs4J
	2zOVNMBS2tygMVO6hH/5C6BxQQR1ifLCgaXYrheo95JI9mtmW0V6Vsg0tXbtmriasIevFNWO9IM
	n6PPv5L4IVA35AeKn+k8PKqTQe10+JR24rPIN5unhp314n1dRa0nRU8nWdzoI4lQU0sN1KPjgaq
	LNNYaTYPXLvVi8iQ3lNOZG6Jd/eP079cZVqqR0PE72SR2CHmolqbnMrn6A8WZo5wAX3dOUJTvoj
	QZyUB8FfR8XyRV8+u1dcm8D7iuLC9ob80ILm2Dfw==
X-Received: by 2002:a05:6a00:3988:b0:82c:ebae:3cb with SMTP id d2e1a72fcca58-84336df67c2mr793546b3a.43.1781146798371;
        Wed, 10 Jun 2026 19:59:58 -0700 (PDT)
Received: from dev ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84337beaab7sm264039b3a.25.2026.06.10.19.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 19:59:57 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
To: andrea.mayer@uniroma2.it
Cc: Yuya Kusakabe <yuya.kusakabe@gmail.com>,
	davem@davemloft.net,
	edumazet@google.com,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@gmail.com,
	shuah@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	stefano.salsano@uniroma2.it,
	ahabdels@cisco.com
Subject: Re: [PATCH v2 2/7] seg6: add End.M.GTP4.E behavior
Date: Thu, 11 Jun 2026 11:59:46 +0900
Message-ID: <20260611025946.1065565-1-yuya.kusakabe@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260527030907.52bc613c27be26d6c1d59e36@uniroma2.it>
References: <20260527030907.52bc613c27be26d6c1d59e36@uniroma2.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-297907-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrea.mayer@uniroma2.it,m:yuya.kusakabe@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:dsahern@kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:justin.iurman@gmail.com,m:shuah@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-doc@vger.kernel.org,m:stefano.salsano@uniroma2.it,m:ahabdels@cisco.com,m:yuyakusakabe@gmail.com,m:justiniurman@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,vger.kernel.org,uniroma2.it,cisco.com];
	FORGED_SENDER(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5240866DE99

Hi Andrea,

Thank you for the detailed review. I intend to address every point
below in the rework agreed in the cover letter thread (one RFC series
per behavior, on a new lwtunnel encap type with its own SEG6_MOBILE_*
attribute namespace); answers to your questions inline.

> There are three issues with the End.M.GTP4.E UAPI behavior:
>
> (1) In the example, v4_mask_len = 32 and the src value is required but not
> used.
[...]
> (2) With v4_mask_len < 32, the low bits of the IPv4 SA that the inbound
> packet does not carry come from src.
[...]
> (3) With v4_mask_len < 32, the low bits of the IPv4 DA that the SID does
> not carry are set to zero.
[...]
> Together with the IPv4 SA behavior in (2), does it make sense to support
> v4_mask_len values other than 32?

Agreed on all three, and no, I see no practical use for v4_mask_len
values other than 32. I will drop both v4_mask_len and the src
template from End.M.GTP4.E: the next version will recover the full
32-bit IPv4 DA from the SID right after the locator, and the full
32-bit IPv4 SA from the inbound IPv6 SA at bit offset
v6_src_prefix_len (default 64), per RFC 9433 Figures 9 and 10. That
leaves no required attribute whose value can be unused or partially
discarded.

> This check cannot trigger at runtime.
> seg6_mobile_v4_validate() already rejects v6_src_prefix_len > 96 at install
> time, and the default (64) leaves p_bits at most 96.
> If kept for defense in depth, or if you plan to reuse this helper
> elsewhere, the silent return of 0 produces an outgoing IPv4 packet with SA
> = 0.0.0.0 without any error.
> Nit: the (unsigned int) cast on p_bits can be removed.

Will fix: the range will be enforced only at build_state time with an
extack message, so the data path helper cannot fail silently, and the
cast will go away.

> seg6_mobile_skb_prefix_bits() reads the matched route prefix length from
> the FIB on every packet. [...]
> Caching it in slwt->mobile_info at validate would let the data path read
> minfo->locator_bits directly.
[...]
> The operator cannot configure the IPv4 DA to start at a position different
> from where the route prefix ends. Is this intentional?

It was, but it does not survive your first point: deriving the
locator length from the matched route prefix couples the SID layout
to the routing table and costs a per-packet FIB read. I will replace
it with an explicit locator-length attribute (sr_prefix_len, validated
at build_state time), which removes the per-packet rcu/container_of
walk and the 128 fallback, and also decouples the IPv4 DA position
from the route prefix, so one route can cover SIDs whose locator is
longer than the route prefix.

> Nit: skb_push() returns void * so the explicit casts on two of the three
> calls are unnecessary.

Will fix.

> orig_dst may be NULL or stale. This is an NF_HOOK finish callback, and
> Netfilter processing during NF_INET_PRE_ROUTING can drop or replace the
> skb dst. skb->cb is not guaranteed to be untouched (IPCB/IP6CB aliases it).

As agreed in the cover letter thread, the initial per-behavior series
will drop the NF_HOOK split entirely: each behavior becomes a single
input function with no skb->cb context and no finish callback. To be
revisited on top of your seg6 netfilter fix.

> Same four-sizeof sum as ovhd above. Move ovhd to function scope to avoid
> the repetition.

Will fix; with iptunnel_handle_offloads() below, the GSO-vs-MTU check
itself goes away, leaving a single worst-case skb_cow_head().

> input_action_end_m_gtp4_e_finish() never calls iptunnel_handle_offloads(),
> so GSO of the outer UDP tunnel cannot operate correctly. The call should
> go between skb_cow_head() and seg6_mobile_push_gtpu().
[...]
> The fix needs end-to-end testing to confirm it works correctly.

Will do exactly as you describe. I will also add a GSO case to the
per-behavior selftest so the fix gets end-to-end coverage.

> The caller already reserves worst-case headroom, so the skb_cow_head()
> calls inside seg6_mobile_push_gtpu() are always no-ops. Could they be
> removed?

Yes, will remove them and make the helper non-failing; the caller
reserves the worst case once.

> Does this mirror the drivers/net/gtp.c data-path convention
> (src == dst == 2152)?

Yes -- drivers/net/gtp.c transmits from its bound socket port, so its
packets also leave with src == dst == 2152.

> The comment says the packet "traverses NF_INET_LOCAL_OUT", but dst_output()
> goes through NF_INET_POST_ROUTING only. [...]
> IMHO, gateways that do protocol transformation can set rp_filter=0. Using
> ip_route_input() + dst_input() and documenting the rp_filter requirement is
> preferable to silently bypassing the FORWARD chain.

Agreed; will switch to ip_route_input() + dst_input() so the rebuilt
IPv4 packet traverses NF_INET_PRE_ROUTING and NF_INET_FORWARD like
the other behaviors, and will document the rp_filter=0 requirement on
the ingress device (code comment and the iproute2 man page).

> The anonymous { } scope block should be avoided. rt and fl4 should be
> declared at the function top. The same pattern appears in other patches
> of this series.
[...]
> Variable declarations are not in reverse Christmas tree order. Same issue
> in the other functions introduced by this patch.

Will fix both across the series, splitting the egress half into its
own helper with all declarations at function top.

> This pskb_may_pull pulls the OUTER IPv6 header, not the inner T-PDU.
> BAD_INNER is the wrong drop reason here. [...]
> Same BAD_INNER misuse: ipv6_skip_exthdr() is parsing the OUTER IPv6
> extension headers [...]

Right. Per the cover letter thread the MUP-specific drop reasons will
be left out of the initial per-behavior series; the behaviors will
adopt the SRv6-level reasons from your prep series once it lands, and
BAD_SID / BAD_GTPU will return with correct scoping at that point.

> frag_off is not checked after ipv6_skip_exthdr(). [...] Adding
> "if (frag_off) goto drop;" after the ipv6_skip_exthdr() call would handle
> this.

Will add the check, plus a fragmented-input case to the selftests as
discussed in the cover letter thread.

> Same seg6_mobile_get_validated_srh() bug described in my reply to patch 1.

Will fix as discussed there: the helper will return a three-state
result (absent / present / malformed) so an absent SRH is
distinguishable from a malformed one, with HMAC validated whenever an
SRH is present.

> RFC 6040 Section 1.1 scopes the document to ECN field processing in
> IP-in-IP tunnels. The patch cites it for DSCP and Hop Limit/TTL on a
> protocol conversion (the IPv6 outer is popped, not encapsulated). Could
> you clarify the RFC 6040 reference?

You are right, the citation was over-scoped. I will drop the
reference and describe the DSCP/ECN and Hop Limit to TTL propagation
in plain words.

> The inner_nfproto-based size selection appears several times:
> pskb_may_pull, skb->protocol, and skb_set_transport_header. Computing a
> local inner_hdr_len once inside the switch would replace all three. Same
> pattern in every other behavior.

Will fix in every behavior.

> parse_nla_mobile_pdu_type() accepts the full 4-bit range 0..15, but the
> function comment in seg6_mobile_push_gtpu() notes that only 0 (downlink)
> and 1 (uplink) have a defined meaning.
> RFC 9433 describes the E behaviors in the downlink packet flows (Section
> 5.3.1.2 and 5.3.2.2). How are PDU Type 1 (uplink) and the reserved values
> supposed to be used with the GTP*.E behaviors?
> UAPI cannot be tightened after merge. IMHO, if a type is not supported
> yet, the parser should reject it and notify userspace.

Agreed. RFC 9433 describes End.M.GTP4.E only in the downlink toward
the gNB (Sections 6.6 and 5.3.2.2), so the End.M.GTP4.E series will
accept only PDU Type 0 (DL) and reject everything else with an
extack message. PDU Type 1 (UL) belongs to End.M.GTP6.E, which
regenerates uplink GTP-U in the drop-in mode (Section 5.4: "There is
one instance of the End.M.GTP6.E SID per PDU type"), so it will be
enabled by that series; the reserved values 2..15 stay rejected
there too.

Thanks,
Yuya

