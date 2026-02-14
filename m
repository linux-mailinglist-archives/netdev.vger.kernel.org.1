Return-Path: <netdev+bounces-258713-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WTBTOU17kGksaQEAu9opvQ
	(envelope-from <netdev+bounces-258713-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 14:40:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5271813C227
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 14:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC3883014C6B
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 13:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB242288D5;
	Sat, 14 Feb 2026 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T4ZMe73m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C684B21638D
	for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771076425; cv=none; b=dO9UxgWAwATlohULqsTsxHzAEIYGPGwO81UdID+bgx+8p+m4yWA/rxolJG4RxYDvVfk9uYeE3SjT71mDAG49W/Omdmg+0CJ7/qQ9MNn+2JyomVTQ7eV9YntFQIpYiUeFb4PYceaM+KyHba6EbOWYlnZmKMRmXOxF9rZrd2d1e9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771076425; c=relaxed/simple;
	bh=crWYUcKvFkZtl+SX+5HyGwiQqk3Lrzb1f22pK4kSJBY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=PcI9tAuLb1Da5owKsgs2KdJaWLOPJ98lVwCLVQ6hyNeyOtGHQHrcQCTB4i1Y/18ZW02js2eAcvAW93kAe7AwGfYTrg8JYcidZP8t6008BKPyhphtiRjjT73YDOq4RbxochnAlnXIBc5rOkBPk64e8nWfRX9pkNHe1ICQ3+xX2aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T4ZMe73m; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4806e0f6b69so14085605e9.3
        for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 05:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771076422; x=1771681222; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/AkKbzGATqyqAlMcPziI9iAWGRtwx+JdsQjjVkJ7ls=;
        b=T4ZMe73mmkSMIgPEQKQS7HzLCIlvcOeOWfMjYa8Uu4ZaviszlseNOoxNHdChAi9Nuq
         51NZwxJ5QObNecdrtbz2MCsXQk8pQvZ+mTP5iDLOeDymz+siV5+XfmFjpE4ZriFOsJtc
         rL5IwY0SuxU1cpsWLqMNmIhemVlKlVsizrA2OOjTcdDkax7Zcr0A74lRHWs/OCibpeHJ
         bPbYctkKZI+sW5C2C9e8WDblNF+zDg3i46cXK3KJ6FHS5QG9RVomPcHxjHtjhvLE/stS
         lNvRyq3CCjcph7cmiQnx++dvg/gVIePRssKs9sT6p8J8uwq7oUKRjypAjULFMf9BkBIq
         QfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771076422; x=1771681222;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q/AkKbzGATqyqAlMcPziI9iAWGRtwx+JdsQjjVkJ7ls=;
        b=ETjhl1tUGZkDBimGT3lbhOROAy5MMQzyx/Hl3d7biRiww2u5Z3SeV3ySF3E/9M5G1r
         InkueC6yVOKOE+zpdOmwEcLXxADgZZldsO608gr8X/uCNoVEBktPStkoOVpgkJkRc9+z
         6Q04BSbVE7lcpPsfHpjj0VmkiwFGTQ4oPO3ezYeLJ6QkT63TeduM2YHTvYhmic3n9ek2
         AXpNj8GHXsQrw+dEOxIlvyGQ1c7Xq697sECbHMUj8+89tJb0m7k78J1Yn0N18dT2UGWt
         3DIzNUPBTe0QdkZ6oGy7mvX+2M2zIt+afbB99VvHh5sB/IXy9GCVIxTLbv0V4nCabee8
         VIuA==
X-Forwarded-Encrypted: i=1; AJvYcCUbxAy4f471vNoha0MG5V0xpiMvwWYTIrruwSZ4pQp9oBerBtAgYiaPrl10WeKeQhyXwjnMRs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMu6i+J6Z0jxH27TVnkjSsUG779deDyJSA1YokssdZczTJBZpV
	uwHJbCPWAQeZO6RozCXEZEnNqWkHVeEMiNHE4EVvAdCqP3+vlKJZw9jlvTlxvPHI217aq6FBrnA
	jnBdc
X-Gm-Gg: AZuq6aKIwQOPqq79aPiZM57G6gI1U+z/2Vm4wnunWSMz90eV5XIY8zQLT8evAASrdVo
	MIP+D0w2QQOhqlvUCNTRALkiMwhonKdJQSfq23+4HsK54kvINiTAlEOniMm/q9/IeUOsOMpN472
	GMiyU5Nks0ybw0iIMSDLE7Rs1jdi4ub09/tIsvRRRo/AoUIH+gF0qJjgdXnL4gzJZy0waDZBhAP
	xk5IX0OqvDrh6a0fu8iECae7IXWUdfRtjAYf3SbJvGe0f44EDy2gfQ4fEilJ+FoyglvQajdedxq
	cRxgnmFLieRVmHqbpqiKo2GAYOwuPtwwIP8UkHlyLAG+g8uGwADeX3z2+gQtJh9i1Cs9l27EIT2
	0bu+w8spB9TaFesvOYFA34ovec4G3C2RxOpHKgsUjZx09CqmGrqkel0oFdaE8jXNKoqlIrX4cov
	sAbliJA0LNKPE=
X-Received: by 2002:a05:600c:3f1b:b0:480:68ed:1e70 with SMTP id 5b1f17b1804b1-48371096d3amr89444775e9.35.1771076421950;
        Sat, 14 Feb 2026 05:40:21 -0800 (PST)
Received: from localhost ([179.228.217.180])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb658509sm2123090eec.19.2026.02.14.05.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 05:40:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Feb 2026 10:40:18 -0300
Message-Id: <DGEQ6YFLVQ8D.289T5CFU5523R@suse.com>
Subject: Re: [PATCH v3] selftests/net: add test for IP-in-IPv6 tunneling
Cc: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
 <morikw2@gmail.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
 <syzbot+d4dda070f833dc5dc89a@syzkaller.appspotmail.com>, <rbm@suse.com>
To: "Linus Heckemann" <git@sphalerite.org>, <edumazet@google.com>,
 <liuhangbin@gmail.com>, <kuba@kernel.org>
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
X-Mailer: aerc 0.21.0
References: <20260214080553.1317672-2-git@sphalerite.org>
In-Reply-To: <20260214080553.1317672-2-git@sphalerite.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258713-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[sphalerite.org,google.com,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,gmail.com,kernel.org,vger.kernel.org,redhat.com,syzkaller.appspotmail.com,suse.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rbm@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,d4dda070f833dc5dc89a];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sphalerite.org:email,ip6_tunnel.sh:url,ip6_gre_headroom.sh:url,lib.sh:url]
X-Rspamd-Queue-Id: 5271813C227
X-Rspamd-Action: no action

On Sat Feb 14, 2026 at 5:05 AM -03, Linus Heckemann wrote:
> commit 81c734dae203 ("ip6_tunnel: use skb_vlan_inet_prepare() in
> __ip6_tnl_rcv()") was fine in and of itself, but its backport to 6.12
> (and 6.6) broke IPv4-in-IPv6 tunneling, see [1]. This adds a self-test
> for basic IPv4-in-IPv6 and IPv6-in-IPv6 functionality.
>
> [1]: https://lore.kernel.org/all/CAA2RiuSnH_2xc+-W6EnFEG00XjS-dszMq61JEvR=
jcGS31CBw=3Dg@mail.gmail.com/
>
> Signed-off-by: Linus Heckemann <git@sphalerite.org>
> --

^ need to be "---" if you don't want it to leak into the commit log.

> Compared to previous version:
> * Added DCO as requested by Jakub
> * Suppressed output of ping and the expected-to-fail `ip link delete` cle=
anup invocation as suggested by Jakub
> * Added `set -e` as suggested by Hangbin
>
> Not sure about the etiquette regarding the Tested-by line: Ricardo
> tested v1 of the patch, I guess I shouldn't add it to a respin?
> ---
>  tools/testing/selftests/net/Makefile      |  1 +
>  tools/testing/selftests/net/ip6_tunnel.sh | 44 +++++++++++++++++++++++

It's missing `chmod +x tools/testing/selftests/net/ip6_tunnel.sh`.

Reviewed-by: Ricardo B. Marli=C3=A8re <rbm@suse.com>
Tested-by: Ricardo B. Marli=C3=A8re <rbm@suse.com>

Tested with v6.19 with commit 9990ddf47d41 ("net: tunnel: make
skb_vlan_inet_prepare() return drop reasons") reverted. Test correctly
exits with 1.

>  2 files changed, 45 insertions(+)
>  create mode 100644 tools/testing/selftests/net/ip6_tunnel.sh
>
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftes=
ts/net/Makefile
> index 45c4ea381bc36..5037a344ad826 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -43,6 +43,7 @@ TEST_PROGS :=3D \
>  	io_uring_zerocopy_tx.sh \
>  	ioam6.sh \
>  	ip6_gre_headroom.sh \
> +	ip6_tunnel.sh \
>  	ip_defrag.sh \
>  	ip_local_port_range.sh \
>  	ipv6_flowlabel.sh \
> diff --git a/tools/testing/selftests/net/ip6_tunnel.sh b/tools/testing/se=
lftests/net/ip6_tunnel.sh
> new file mode 100644
> index 0000000000000..fe081a5218199
> --- /dev/null
> +++ b/tools/testing/selftests/net/ip6_tunnel.sh
> @@ -0,0 +1,44 @@
> +#!/bin/bash
> +# Test that IPv4-over-IPv6 tunneling works.
> +
> +source lib.sh
> +set -e
> +
> +setup_prepare() {
> +  ip link add transport1 type veth peer name transport2
> +
> +  setup_ns ns1
> +  ip link set transport1 netns $ns1
> +  ip -n $ns1 address add 2001:db8::1/64 dev transport1 nodad
> +  ip -n $ns1 address add 2001:db8::3/64 dev transport1 nodad
> +  ip -n $ns1 link set transport1 up
> +  ip -n $ns1 link add link transport1 name tunnel4 type ip6tnl mode ipip=
6 local 2001:db8::1 remote 2001:db8::2
> +  ip -n $ns1 address add 172.0.0.1/32 peer 172.0.0.2/32 dev tunnel4
> +  ip -n $ns1 link set tunnel4 up
> +  ip -n $ns1 link add link transport1 name tunnel6 type ip6tnl mode ip6i=
p6 local 2001:db8::3 remote 2001:db8::4
> +  ip -n $ns1 address add 2001:db8:6::1/64 dev tunnel6
> +  ip -n $ns1 link set tunnel6 up
> +
> +  setup_ns ns2
> +  ip link set transport2 netns $ns2
> +  ip -n $ns2 address add 2001:db8::2/64 dev transport2 nodad
> +  ip -n $ns2 address add 2001:db8::4/64 dev transport2 nodad
> +  ip -n $ns2 link set transport2 up
> +  ip -n $ns2 link add link transport2 name tunnel4 type ip6tnl mode ipip=
6 local 2001:db8::2 remote 2001:db8::1
> +  ip -n $ns2 address add 172.0.0.2/32 peer 172.0.0.1/32 dev tunnel4
> +  ip -n $ns2 link set tunnel4 up
> +  ip -n $ns2 link add link transport2 name tunnel6 type ip6tnl mode ip6i=
p6 local 2001:db8::4 remote 2001:db8::3
> +  ip -n $ns2 address add 2001:db8:6::2/64 dev tunnel6
> +  ip -n $ns2 link set tunnel6 up
> +}
> +
> +cleanup() {
> +  cleanup_all_ns
> +  # in case the namespaces haven't been set up yet
> +  ip link delete transport1 &>/dev/null || true
> +}
> +
> +trap cleanup EXIT
> +setup_prepare
> +ip netns exec $ns1 ping -q -W1 -c1 172.0.0.2 >/dev/null
> +ip netns exec $ns1 ping -q -W1 -c1 2001:db8:6::2 >/dev/null


