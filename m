Return-Path: <netdev+bounces-304719-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kwG+IyJaSWqH0gAAu9opvQ
	(envelope-from <netdev+bounces-304719-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 21:08:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 120FF708384
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 21:08:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=SRFolpZQ;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304719-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304719-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B6D03008C02
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 19:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0896835BDA8;
	Sat,  4 Jul 2026 19:08:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8057C277029
	for <netdev@vger.kernel.org>; Sat,  4 Jul 2026 19:08:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783192093; cv=none; b=bVeM1BYbkA1YrkVO46tP1//9dSgtERa5kBG+w/0+mimWt+daiywlaSWrYnvrkPLsQ+qs4rpd5sxupA4rYjbHeKr1L0GNWNIhPVMO8gtLK1OK38SjBFNwqcIuLHDP5AM7sBxquelBYfYShfV4nEqIIJDSfh2euaACWlxXupT5s6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783192093; c=relaxed/simple;
	bh=YNzXT3aqH9Fv7w8avj+C4EBMB5oQXh9FSLCur/rtAMk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Ql1Bb7/qkr6wTU+p3/XDu3mSz39cVq6Cf4YgMhUTSQ7Ah2rmOo9t7KpOGs3DKCHuHocWvm9D2JojYvhZh+U3jxzvIfxb4YofpgwAKwppE5BvS2S87YmnJ0RsY85XQVX8D8w0zD2ULSDuFznoahYCXjHcgfNORa5tAelsChtZXyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRFolpZQ; arc=none smtp.client-ip=209.85.128.178
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-81086f7abaaso19147497b3.0
        for <netdev@vger.kernel.org>; Sat, 04 Jul 2026 12:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783192091; x=1783796891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gm/Rge7I0kflCRggw6lmJbxqV6a3OPZp5P4k8oCntmo=;
        b=SRFolpZQoqwIBPxqTJkNbLRhXfv8jn8fmRsIYzTxQKruvuCMl61MK7iwggYjk1CbDi
         B0gos9yQniqU4CSN/AqS6vI50ge+FJNuOFGJBvmkfCj+DIQ9WbHlL8+8VFBuUk+IFwx5
         +7dutaWCgewmXen3U+wNfnBggayI9+kJPhOn/TKjHVsXV+D276pqJFwIKhD0rUmoS/Im
         Aud18RIrunwAG7Sgc9tgevEQ/cEpsLRDCHqOkMczau8B9jQK8THnKKeK+X2VOgNx7yNB
         Q9LvAlQRLJZnk2cU+VqkM8Hv2BbSBAk0nK4aPo/o34IyyA7ukw/u90DKN0yfBFpcdPX7
         QbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783192091; x=1783796891;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gm/Rge7I0kflCRggw6lmJbxqV6a3OPZp5P4k8oCntmo=;
        b=BxECEK8Z3LneYmHWflGKCOeKD/Rh3CD4LXbN17TfWrypP/qciC9kB1zeo/e8SlzIqI
         pGJI0ucpc0BDo3inVn1jWuiJyty+nM7FK0ZPJa8V8eRUWZy71n0xJiUd2YIPXmGK8Nfl
         VDXmnZjrAMrNq/wnHFWPKqdhT4I+UjJ16QO3RCk4RgyEXNe9Wfm9sQz/p1iPWjnOc+eu
         Ea7F4/F2GXXetZbrgX+esJjE5uzZYHqZm4SChs6X0wvUldUDrkQ1nmhfQMJ6JUlDN+pq
         sCEM/5lpjCLapySzMaiz6vEObhullJcjT/z/MP1OWH5vDxDpTFDqDgtIvuzOhCKsay/8
         qS0g==
X-Forwarded-Encrypted: i=1; AHgh+RrQJreB5YetJGJuz3zMSMAJHOnTC7MEG+pAyLPdDaFqCt/337F+USMTMGV2dQxguL7dN7T7t6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLRPjxBIYMLWPaPSCHfaTKXaCLlQa0sKABKwsz550rv2i2b+0U
	nb9/RcgWgKNwdiISU24HhnO8/nfsJ1Ugei78MH7OFzqY+LqBVG4VEpze
X-Gm-Gg: AfdE7cnSXLavG8muiVxotU8hGgCVgQzwjIy7rMtCGvOXtkEExQZeKnbMCgzQEOpn+20
	si9ebWLslPQlvu+YtMOGpVFxCdbQlVTmfXTnbGv263uXPYAQv0slAEnmwTYmxkShqN/2iCXl5fZ
	kqeBxDsGs0+uoIOPcznKGKaC/PF3S3d2wTxAN63E/gIlO/AqzNhb6BLfSXQbBaTC6MqKUp8I+yB
	MtgPJh9K1bWSXgC+k0udqzLfCMKs4/ZcoMLLq8Qi9941BjIym4loyJBrs5TBf05HC2BFdqqzhu5
	mDlTJ/BM5zLVGOIujepl/gVpTo0JC70CBy8pqbyXqqJWGQRWnb17v4pKXc1+bM5hySPR+D6wHs0
	I59NhhHVwgU0UN4BiaxfghOLJ4Z0Bp9zAgEd9D58IdqJVF+aaHovWQUT53/kBZhXJe3f+BOLOeY
	twTPgFmuj/5m6yYQMzjIBsILXbA+xUB6/FsMFuQGit/8xZpxZYuoVK3A6wTTxzgqDVJA==
X-Received: by 2002:a05:690c:2789:b0:7f5:ec53:b4ce with SMTP id 00721157ae682-81737544143mr49405597b3.16.1783192091451;
        Sat, 04 Jul 2026 12:08:11 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81448dd0217sm37817917b3.22.2026.07.04.12.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 12:08:10 -0700 (PDT)
Date: Sat, 04 Jul 2026 15:08:09 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Anton Danilov <littlesmilingcloud@gmail.com>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1f71507524703@gmail.com>
In-Reply-To: <a196b53a2829da66c982f88e82805afc498ea13b.1782945956.git.littlesmilingcloud@gmail.com>
References: <cover.1782945956.git.littlesmilingcloud@gmail.com>
 <a196b53a2829da66c982f88e82805afc498ea13b.1782945956.git.littlesmilingcloud@gmail.com>
Subject: Re: [PATCH net-next v4 2/2] selftests: net: add FOU multicast
 encapsulation resubmit test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:littlesmilingcloud@gmail.com,m:netdev@vger.kernel.org,m:willemb@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuniyu@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-304719-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gre_ipv6_lladdr.sh:url,fou_mcast_encap.sh:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 120FF708384

Anton Danilov wrote:
> Add a selftest to verify that FOU-encapsulated packets addressed to a
> multicast destination are correctly resubmitted to the inner protocol
> handler (GRE) via the UDP multicast delivery path.
> 
> The test creates two network namespaces connected by a veth pair with
> a FOU/GRETAP tunnel using a multicast remote address (239.0.0.1).
> Ping is sent through the tunnel and received packets are counted on
> the receiver's tunnel interface.
> 
> A static neighbor entry is configured on the sender because ARP
> replies from the receiver cannot traverse the unidirectional multicast
> tunnel back to the sender.
> 
> The early demux optimization (net.ipv4.ip_early_demux) is disabled on
> the receiver to force packets through __udp4_lib_mcast_deliver(),
> which is the code path being tested.
> 
> Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
> Assisted-by: Claude:claude-opus-4-6
> ---
>  tools/testing/selftests/net/Makefile          |   1 +
>  .../testing/selftests/net/fou_mcast_encap.sh  | 112 ++++++++++++++++++
>  2 files changed, 113 insertions(+)
>  create mode 100755 tools/testing/selftests/net/fou_mcast_encap.sh
> 
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index 708d960ae07d..7e9ae937cffa 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -39,6 +39,7 @@ TEST_PROGS := \
>  	fib_rule_tests.sh \
>  	fib_tests.sh \
>  	fin_ack_lat.sh \
> +	fou_mcast_encap.sh \
>  	fq_band_pktlimit.sh \
>  	gre_gso.sh \
>  	gre_ipv6_lladdr.sh \
> diff --git a/tools/testing/selftests/net/fou_mcast_encap.sh b/tools/testing/selftests/net/fou_mcast_encap.sh
> new file mode 100755
> index 000000000000..8db9633f4c28
> --- /dev/null
> +++ b/tools/testing/selftests/net/fou_mcast_encap.sh
> @@ -0,0 +1,112 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Test that UDP encapsulation (FOU) correctly handles packet resubmit
> +# when packets are delivered via the multicast UDP delivery path.
> +#
> +# When a FOU-encapsulated packet arrives with a multicast destination IP,
> +# __udp4_lib_mcast_deliver() must resubmit it to the inner protocol
> +# handler (e.g., GRE) rather than consuming it. This test verifies that
> +# by creating a FOU/GRETAP tunnel with a multicast remote address and
> +# sending ping through it.
> +#
> +# The early demux optimization can mask this issue by routing packets via
> +# the unicast path (udp_unicast_rcv_skb), so we disable it to force
> +# packets through __udp4_lib_mcast_deliver().
> +
> +source lib.sh
> +
> +NSENDER=""
> +NRECV=""
> +
> +cleanup() {
> +	cleanup_all_ns
> +}
> +
> +trap cleanup EXIT
> +
> +setup() {
> +	setup_ns NSENDER NRECV
> +
> +	ip link add veth_s type veth peer name veth_r
> +	ip link set veth_s netns "$NSENDER"
> +	ip link set veth_r netns "$NRECV"

Sashiko points out that names in the root namespace may collide with
other devices. Unexpected here, but it's just as easy to immediately
assign the new veth nodes to the netns. See for instance sctp_vrf.sh.

> +
> +	ip -n "$NSENDER" addr add 10.0.0.1/24 dev veth_s

More importantly, have you also tested IPv6? Can you expand the
test with IPv6.

Again, sashiko points to an important issue: ip_protocol_deliver_rcu
and ip6_protocol_deliver_rcu are not equivalent. From a quick scan it
appears that the latter does not resubmit on negative return code.

