Return-Path: <netdev+bounces-289241-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id k79nKr29C2olMAUAu9opvQ
	(envelope-from <netdev+bounces-289241-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 03:32:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FBB576187
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 03:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F31693017ECB
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 01:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE5A2DA75A;
	Tue, 19 May 2026 01:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="xyrOEBRk";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="E+obnzLO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD68A2745E;
	Tue, 19 May 2026 01:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779154363; cv=none; b=FLB7sotUHhoAF6qVFnCCra9oZMkUttKAy14cWZb7vTvVxOdxd1FLZwkCJlhcS89H8NvvM+1wp41YUcWI2JQX05fNTjdioii4Zeia9SD2UCwI1OrYums1FXl4ORIeID2ry/qzYSr9paHIgJErphvcAQxARvmVOl2+GeNBRHGEwMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779154363; c=relaxed/simple;
	bh=19AS5m6DpWZUofHaWHAFmpxkQ8nP3eMiVfmqSuQijEk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=i3CfpYHye/Pxz8b90fjRcBP0acMwdnzNmeKIS16qPat+zr/hCkZvWkpdTJGfH3YCcohuQXoIZuCqCc2/9bWuQGWjEQJ+CcdUo8Bundm6Fo9p7TTOiZlTASoxdgJeWWcx887fSYEaPuSffRTXx/sBU6tZ2Ezyw6g1qAO0D5YOeRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=xyrOEBRk; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=E+obnzLO; arc=none smtp.client-ip=160.80.4.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 64J1VuIH028920;
	Tue, 19 May 2026 03:32:01 +0200
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 56F7D12287D;
	Tue, 19 May 2026 03:31:51 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1779154311; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mCYhMids7R2HSFnbeiCSYYddMvIksaDpTjVyh3nQZfk=;
	b=xyrOEBRkvR6M5VEAzqU6S8uqGrXzLn9heHo/+SvmHjEzfZ5kq4863UJFZf6ZAXSMd0eIUK
	H0SKK9oPIY0u53BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1779154311; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mCYhMids7R2HSFnbeiCSYYddMvIksaDpTjVyh3nQZfk=;
	b=E+obnzLOWLZhtPujpaX+YW3ahX/BTbUYDYOYpwwIMB8s+TOlwT7cXTP0nCMXV6V9z58kgP
	2XiFA+exJRk2qoCJE1gkk0oxRhqPASDg6533NGI92SYRyWOxZgGDD6+NcE571kAWrErszF
	OAc+ORSAh+ywYT5QbouKeHtJ7bJ7iD/+9N6e8rAv/rI95y2EafKymjR1jKO2Qcr7+URpEU
	kYVFatPsnsXqi5yqmyqdBDtkGmD6YRHUltILT6PJaaVwz01gslQpCVRB/JAftTJD8LeT8p
	s4tF4EGOrV8KpbjDeI7VXxc6oFbW8VkDfntEtdelEJEdhnJzw+ZzdmqxbPEMJQ==
Date: Tue, 19 May 2026 03:31:51 +0200
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
Subject: Re: [PATCH v2 1/7] seg6: add End.MAP behavior
Message-Id: <20260519033151.b01e47a877b01d3b68931abc@uniroma2.it>
In-Reply-To: <20260505-seg6-mobile-v2-1-9e8022bdfdb6@gmail.com>
References: <20260505-seg6-mobile-v2-0-9e8022bdfdb6@gmail.com>
	<20260505-seg6-mobile-v2-1-9e8022bdfdb6@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[uniroma2.it:s=ed201904,uniroma2.it:s=rsa201904];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289241-lists,netdev=lfdr.de];
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[end.map:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,srv6_end_next_csid_l3vpn_test.sh:url]
X-Rspamd-Queue-Id: 83FBB576187
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 05 May 2026 01:30:11 +0900
Yuya Kusakabe <yuya.kusakabe@gmail.com> wrote:

> Add the End.MAP behavior (RFC 9433 Section 6.2): an endpoint that
> replaces the IPv6 destination address with a configured next SID
> and forwards via IPv6 routing without consuming the SRH.  The new
> nh6 attribute selects the replacement SID.
>
> Add three drop reasons that End.MAP emits to dropreason-core.h, so
> dropped packets show up in the standard skb:kfree_skb tracepoint:
>
>   SEG6_MOBILE_INVALID_SRH_SL
>   SEG6_MOBILE_HOP_LIMIT_EXCEEDED
>   SEG6_MOBILE_NOMEM

The commit message lists three drop reasons including
SEG6_MOBILE_HOP_LIMIT_EXCEEDED, but the code does not add that one.
The likely third reason (SEG6_MOBILE_MTU_EXCEEDED) appears in
patch 2. (Flagged by Sashiko, the Patchwork AI reviewer.)

>
> Configuration:
>
>   ip -6 route add 2001:db8:f::/64 \
>       encap seg6local action End.MAP nh6 2001:db8:1::e \
>       dev <dev>
>
> Link: https://www.rfc-editor.org/rfc/rfc9433.html#section-6.2

Nit: As far as I can see, Link: tags in this tree usually point to mailing
list messages (patch.msgid.link, lore.kernel.org). Other commits that
reference RFCs typically cite them in the commit body instead. Same for
patches 2-7.

> Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
> ---
>  include/net/dropreason-core.h                    |  12 +++
>  include/uapi/linux/seg6_local.h                  |   2 +
>  net/ipv6/seg6_local.c                            |  73 ++++++++++++++++
>  tools/testing/selftests/net/Makefile             |   1 +
>  tools/testing/selftests/net/srv6_end_map_test.sh | 103 +++++++++++++++++++++++
>  5 files changed, 191 insertions(+)
>
> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
> index e0ca3904ff8e..1be5c54d7605 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -127,6 +127,8 @@
>  	FN(PSP_INPUT)			\
>  	FN(PSP_OUTPUT)			\
>  	FN(RECURSION_LIMIT)		\
> +	FN(SEG6_MOBILE_INVALID_SRH_SL)	\
> +	FN(SEG6_MOBILE_NOMEM)		\
>  	FNe(MAX)
>
>  /**
> @@ -600,6 +602,16 @@ enum skb_drop_reason {
>  	SKB_DROP_REASON_PSP_OUTPUT,
>  	/** @SKB_DROP_REASON_RECURSION_LIMIT: Dead loop on virtual device. */
>  	SKB_DROP_REASON_RECURSION_LIMIT,
> +	/**
> +	 * @SKB_DROP_REASON_SEG6_MOBILE_INVALID_SRH_SL: invalid Segments Left
> +	 * value or SRH validation failure on an SRv6 Mobile path.
> +	 */
> +	SKB_DROP_REASON_SEG6_MOBILE_INVALID_SRH_SL,

This single reason covers several distinct failure modes across the
patchset: wrong Segments Left, SRH absent, SRH structurally malformed, and
HMAC validation failure. An operator seeing this drop cannot tell which
check failed. Using separate SRv6-level drop reasons seems reasonable. See
my cover letter reply for the broader discussion on drop reasons.

> +	/**
> +	 * @SKB_DROP_REASON_SEG6_MOBILE_NOMEM: skb head/tail expansion or
> +	 * helper allocation failed on an SRv6 Mobile path.
> +	 */
> +	SKB_DROP_REASON_SEG6_MOBILE_NOMEM,

This overlaps with the existing generic SKB_DROP_REASON_NOMEM in
dropreason-core.h. Why not use the generic one?

>  	/**
>  	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
>  	 * shouldn't be used as a real 'reason' - only for tracing code gen
> diff --git a/include/uapi/linux/seg6_local.h b/include/uapi/linux/seg6_local.h
> index 4fdc424c9cb3..45386fdfa821 100644
> --- a/include/uapi/linux/seg6_local.h
> +++ b/include/uapi/linux/seg6_local.h
> @@ -67,6 +67,8 @@ enum {
>  	SEG6_LOCAL_ACTION_END_BPF	= 15,
>  	/* decap and lookup of DA in v4 or v6 table */
>  	SEG6_LOCAL_ACTION_END_DT46	= 16,
> +	/* swap DA with new SID, leave SRH untouched (RFC 9433 Section 6.2) */
> +	SEG6_LOCAL_ACTION_END_MAP	= 17,
>
>  	__SEG6_LOCAL_ACTION_MAX,
>  };
> diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
> index 2b41e4c0dddd..bd8e3312973f 100644
> --- a/net/ipv6/seg6_local.c
> +++ b/net/ipv6/seg6_local.c
> @@ -1468,6 +1468,73 @@ static int input_action_end_bpf(struct sk_buff *skb,
>  	return -EINVAL;
>  }
>
> +/* SRH validation helper for SRv6 Mobile (RFC 9433) behaviors that may
> + * receive an SRv6 encapsulated packet.  Returns the SRH on success or
> + * NULL on validation failure / when the SRH is absent.  The caller
> + * uses @missing to distinguish the two NULL cases: an SRH-less packet
> + * may be acceptable depending on the behavior.
> + */
> +static struct ipv6_sr_hdr *seg6_mobile_get_validated_srh(struct sk_buff *skb,
> +							 bool *missing)
> +{
> +	struct ipv6_sr_hdr *srh = seg6_get_srh(skb, 0);
> +
> +	if (!srh) {
> +		if (missing)
> +			*missing = true;
> +		return NULL;
> +	}
> +	if (missing)
> +		*missing = false;
> +
> +#ifdef CONFIG_IPV6_SEG6_HMAC
> +	if (!seg6_hmac_validate_skb(skb))
> +		return NULL;
> +#endif
> +	return srh;
> +}

seg6_get_srh() returns NULL both when the SRH is absent and when it is
malformed (seg6_validate_srh fails, e.g. type != 4) or truncated.
seg6_mobile_get_validated_srh() sets *missing = true in all these cases,
so input_action_end_map() treats a malformed SRH the same as an absent
one and continues processing. HMAC validation is also bypassed because
seg6_get_srh() returns NULL before HMAC is reached.

seg6_mobile_get_validated_srh() needs to distinguish "absent" from
"malformed/truncated" so callers can drop on malformed instead of silently
accepting the packet.

> +
> +/* RFC 9433 Section 6.2 -- End.MAP
> + * Replace the outer IPv6 destination address with the configured next
> + * SID, decrement the Hop Limit, and forward via IPv6 routing.  The
> + * SRH is left untouched, so any subsequent End* behavior continues to
> + * see the original Segment List unchanged.
> + */

Nit: the function comment says "decrement the Hop Limit" but the code does not
do it explicitly. The forwarding path handles it (ip6_forward). Maybe
remove that part from the comment or add a note that the forwarding path
handles it?

> +static int input_action_end_map(struct sk_buff *skb,
> +				struct seg6_local_lwt *slwt)
> +{
> +	enum skb_drop_reason reason;
> +	struct ipv6_sr_hdr *srh;
> +	struct ipv6hdr *ip6h;
> +	bool no_srh = false;
> +
> +	reason = SKB_DROP_REASON_SEG6_MOBILE_INVALID_SRH_SL;

Because of the bug described above, the only path that reaches the
drop label with this reason is HMAC validation failure (when HMAC is
enabled). Same drop reason granularity point as above.

> +
> +	/* When an SRH is present it must HMAC-validate before we touch
> +	 * the destination; an SRH-less packet is also accepted because
> +	 * End.MAP does not consume the SRH.
> +	 */
> +	srh = seg6_mobile_get_validated_srh(skb, &no_srh);
> +	if (!srh && !no_srh)
> +		goto drop;

See above: this only catches HMAC failure. A malformed SRH falls through as
if the SRH were absent.

> +
> +	if (skb_ensure_writable(skb, sizeof(*ip6h))) {
> +		reason = SKB_DROP_REASON_SEG6_MOBILE_NOMEM;
> +		goto drop;
> +	}
> +
> +	ip6h = ipv6_hdr(skb);
> +	ip6h->daddr = slwt->nh6;

Sashiko flagged that for SRH-less packets this breaks the ICMPv6 checksum,
because the pseudo-header includes the DA. The AI bot was right, but when I
ran the selftest it passed. Digging a bit further, I noticed why:
2001:db8:f::1 and 2001:db8:2::e have the same 16-bit word sum
(0x000f+0x0001 = 0x0002+0x000e), so the checksum stays valid by
coincidence. Changing nh6 to 2001:db8:2::2 makes the ping fail with
Icmp6InCsumErrors.

> +
> +	skb_dst_drop(skb);
> +	seg6_lookup_nexthop(skb, NULL, 0);
> +	return dst_input(skb);

seg6_lookup_nexthop() calls seg6_lookup_any_nexthop() which already calls
skb_dst_drop() internally. The explicit skb_dst_drop(skb) above is
redundant.

> +
> +drop:
> +	kfree_skb_reason(skb, reason);
> +	return -EINVAL;
> +}
> +
>  static struct seg6_action_desc seg6_action_table[] = {
>  	{
>  		.action		= SEG6_LOCAL_ACTION_END,
> @@ -1565,6 +1632,12 @@ static struct seg6_action_desc seg6_action_table[] = {
>  		.optattrs	= SEG6_F_LOCAL_COUNTERS,
>  		.input		= input_action_end_bpf,
>  	},
> +	{
> +		.action		= SEG6_LOCAL_ACTION_END_MAP,
> +		.attrs		= SEG6_F_ATTR(SEG6_LOCAL_NH6),
> +		.optattrs	= SEG6_F_LOCAL_COUNTERS,
> +		.input		= input_action_end_map,
> +	},

End.MAP reuses SEG6_LOCAL_NH6 to mean "replacement SID", not "next-hop"
as in End.X/End.DX6. This overloads the existing UAPI semantics of
the attribute. The cover letter reply discusses this attribute-semantics
question across the patchset.

>
>  };
>
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index a275ed584026..4fbb1eff79f8 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -90,6 +90,7 @@ TEST_PROGS := \
>  	srv6_end_dx4_netfilter_test.sh \
>  	srv6_end_dx6_netfilter_test.sh \
>  	srv6_end_flavors_test.sh \
> +	srv6_end_map_test.sh \
>  	srv6_end_next_csid_l3vpn_test.sh \
>  	srv6_end_x_next_csid_l3vpn_test.sh \
>  	srv6_hencap_red_l3vpn_test.sh \
> diff --git a/tools/testing/selftests/net/srv6_end_map_test.sh b/tools/testing/selftests/net/srv6_end_map_test.sh
> new file mode 100755
> index 000000000000..7ee54b4cc97f
> --- /dev/null
> +++ b/tools/testing/selftests/net/srv6_end_map_test.sh
> @@ -0,0 +1,103 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# shellcheck disable=SC2034,SC2154
> +#
> +# Selftest for the SRv6 End.MAP behavior (RFC 9433 Section 6.2).
> +#
> +#   +--------+   2001:db8:1::/64   +--------+   2001:db8:2::/64   +--------+
> +#   | srupf1 | ------------------- | srupf2 | ------------------- | srupf3 |
> +#   +--------+       veth-1        +--------+       veth-2        +--------+
> +#                                (intermediate
> +#                                 SRv6-aware UPF,
> +#                                 End.MAP)
> +#
> +# All three netns are SRv6-aware UPFs in the RFC 9433 sense (not
> +# 3GPP UPFs).  Per RFC 9433 Section 6.2 End.MAP is used by the
> +# intermediate UPF (here srupf2): srupf2 has an End.MAP SID for
> +# locator 2001:db8:f::/64 mapping to the new SID 2001:db8:2::e.
> +# srupf1 sends an IPv6 packet to 2001:db8:f::1; on srupf3 the
> +# destination address is expected to have been replaced by
> +# 2001:db8:2::e.

The selftest only covers the SRH-less path. End.MAP also accepts packets
with an SRH, and that case should be covered as well.

To expose the ICMPv6 checksum issue noted above, the address pair should be
chosen so that the daddr rewrite changes the checksum.

> [snip]

Thanks,

Ciao,
Andrea

