Return-Path: <netdev+bounces-305318-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JogVN+a0TGrqoQEAu9opvQ
	(envelope-from <netdev+bounces-305318-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:12:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F3A718F37
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:12:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=YctvVaHA;
	dkim=pass header.d=redhat.com header.s=google header.b=D+s4MvGU;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305318-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305318-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13583307E6A3
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 08:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145472F7EF1;
	Tue,  7 Jul 2026 08:06:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2BD2D6409
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 08:06:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783411595; cv=none; b=pF1hy3ClU3HTLRrDklB/0xm9fFY6mSm+HPWg2KAKSA0mxtQOsmR0xC6g85laDJVfI2CxuLqbdjUwHCP/U20MB0YBnQlvaNsckuLRVLzyz8jKYXLGfOsgDK+A4aJ6gGhLBu7JMZpaYT97U07G0JY4x8ZJkyYiV1fjR82caUPQ4Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783411595; c=relaxed/simple;
	bh=8ppzBJwjfdUXv0dRKpLgl5v1Ki2yjSGcqFRDrP++iBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HqU2q76UR7PD9/5DOAlMdDINKM83V2gRjdCK14xZJulwUVPRKMYMAAUVO447ZAGvBf8pa+ruwA8PGXycesmQFscesoIl6uAhdNFwAB19ldxC1EgnlcbmXGTKjxMJFHtGPiXnQ5oGxXFieQp4vLqQ7wmV1wPZ9U2cXuhTa6KEIro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YctvVaHA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=D+s4MvGU; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783411593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PTPQmcJqIl+y+IOReiZffAKREQqqviuvmuYkaJIn+vI=;
	b=YctvVaHAK8QBJwSL33mlfyCjqRbL7GGfixffsNvWpguuTNNdpeT9v4TRpmig0mQul/O7uk
	A86eagCeY+hTE/irWtGrh9qRISxQkSkqwqFCTs6lMl5CIlx1GsGe1nvJI0L3Y149WPKkhz
	K5g2KW0yg5ao82j7ztzkjtAegAnnTlg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-dPM_7NJUMtueibubTiU3qg-1; Tue, 07 Jul 2026 04:06:31 -0400
X-MC-Unique: dPM_7NJUMtueibubTiU3qg-1
X-Mimecast-MFC-AGG-ID: dPM_7NJUMtueibubTiU3qg_1783411590
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493ba771d1bso36145165e9.2
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 01:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783411590; x=1784016390; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PTPQmcJqIl+y+IOReiZffAKREQqqviuvmuYkaJIn+vI=;
        b=D+s4MvGU3SzO4tIdTfBQvYqTdnT2fsic2ARQtlqAf0rLtuZqC4NBy1LfFsSRE4mkqo
         R5sUScueakHhhC1dGtEFsG5Zs8ngMTF+k6tZsHaup0jOB4/VoaLinlKwQsBcWLhwJh9Z
         Diq3Q35XSoiiq7YqldMGDstBz59bzsFwLsKj3/1OF0AvQti0bPyMK6mabOO2WhiCxMK3
         3HJ6s88a9YhpT6WDNvEe4FSeHHB4Qi63WCakjFiXrdKDNuQNPZmB+x2LWvsf0b+juxw0
         PpeHGm+i+XF5iZaQFEu3TxkPEaZzgT5OQP/jJHmvf7FQ04PCJqiGRKZxqveXW3nnbRSF
         3thg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783411590; x=1784016390;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PTPQmcJqIl+y+IOReiZffAKREQqqviuvmuYkaJIn+vI=;
        b=OvU3QSePz4eohdJtmI4z5M28Y8EiqZWl+US6nM2FZXHx3zhcNhFg2f9JdX2yWQm4kz
         Vfn2+Qlyrd0W8pGXBun2+UO9/G80QbizsXQXd+9Wz0/uCizS2FrBtmPpdnovd0l9pJap
         wxcMnHCMny5Aq/iJ389X6lVyQ8/LzbBy8W/Nov7Mjsr9F6yL2vDPDg1+H0Byw8Vyn5hv
         qJ4tU10VljEfiolSu3teQ+SPAKqqdUiOO23A5MrrwD9m/mTnMgtYk4DPoO2jj5x1VeIA
         37CYXIwDRCP1m+4nyamOORZYzROJKQniCry9Z+xYKESTXlCLDOiCd/HGPVe6aaTL8ogT
         hGtA==
X-Forwarded-Encrypted: i=1; AHgh+RrNCK3nGap/TmoBcg1uVTvtZ3EM4yxAC75U2gilhocCRKPWqDHNFlyfF7LHJGVjIRUHpyyIp0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDSOYNs3UuSENW1dwoemPTZbWNvrA3RO8MkC2hbXNd61HAqc1m
	4BlKClKlSkFnRAnDPlXfJLYzQN/5A+jiAYKGhLu2vDtd028zr/5aijFyYy2DnLz4TyMfjd0IXfz
	O0V8LOvTZeQn+/SFOYbXnqbdrLxwBJnW0rnHdAurJO4buuhhiIEJfVt3uUQ==
X-Gm-Gg: AfdE7cnniMtI3ZaTPyNmvKh5oxTANNsbRa/6GscWUbGIX0rGuL7G62lU/Bb11yoFdw2
	aUV2L6CH9TZeABVQoj3bLd+RY+Q4AE7IimNVFVjItP1/muyGTC6AHM8nYkU9MxE/v9RILRpzt7t
	5P5p7z/BLgU2YaxWWJ4iRzGdyI7odtWiMvr4klctJesjfBqNGn3F1GfHiIiR2QqgI0oZhxLOSa0
	T0ljEHEzAgZ2SQfT+m/O4VeSrZxbUP2MHgOBYHqFgdgc03LvCktSRypO9XRD+NVvlfr5e8Sx3xl
	T+xqifNeFVtQ4lAA1R9X/rLwmJHAUHn82m/gZnf8870wD2l7BwxUi2ooQ5xgI3JQzh7kDXxzO2g
	iA0AC6NxdI+6gHJHq0/z/6D+v/cw3AQY0OsFQyUWmxbP7YBYQq67cjpyOe7ZPpHQvdCLCpsW2BW
	SJUjeaR/kFJpbf
X-Received: by 2002:a05:600c:4e8b:b0:493:b877:fbc with SMTP id 5b1f17b1804b1-493df080c50mr42015305e9.21.1783411590344;
        Tue, 07 Jul 2026 01:06:30 -0700 (PDT)
X-Received: by 2002:a05:600c:4e8b:b0:493:b877:fbc with SMTP id 5b1f17b1804b1-493df080c50mr42014795e9.21.1783411589816;
        Tue, 07 Jul 2026 01:06:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f50418sm33378285e9.11.2026.07.07.01.06.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 01:06:29 -0700 (PDT)
Message-ID: <80222d3f-e6cf-408b-b42f-0a2a6afce297@redhat.com>
Date: Tue, 7 Jul 2026 10:06:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 9/9] selftests: net: Add a test for BIG TCP in
 UDP tunnels
To: Alice Mikityanska <alice.kernel@fastmail.im>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Xin Long <lucien.xin@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <stfomichev@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
 Alice Mikityanska <alice@isovalent.com>
References: <20260706181941.385672-1-alice.kernel@fastmail.im>
 <20260706181941.385672-10-alice.kernel@fastmail.im>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260706181941.385672-10-alice.kernel@fastmail.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305318-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alice.kernel@fastmail.im,m:daniel@iogearbox.net,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:lucien.xin@gmail.com,m:willemdebruijn.kernel@gmail.com,m:willemb@google.com,m:dsahern@kernel.org,m:razor@blackwall.org,m:shuah@kernel.org,m:stfomichev@gmail.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:fw@strlen.de,m:netdev@vger.kernel.org,m:alice@isovalent.com,m:lucienxin@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[fastmail.im,iogearbox.net,davemloft.net,google.com,kernel.org,gmail.com,blackwall.org];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 48F3A718F37

On 7/6/26 8:19 PM, Alice Mikityanska wrote:
> From: Alice Mikityanska <alice@isovalent.com>
> 
> The test sets up VXLAN and GENEVE tunnels over IPv4 and IPv6 and runs
> IPv4 and IPv6 traffic through them with BIG TCP enabled. It checks that
> a non-negligible amount of big aggregated packets are seen in tcpdump.
> 
> Check the number of packets on both TX and RX sides to verify that GSO
> packets are valid and not dropped. Capture on the lower netdev (veth),
> when checksum offload is on, to verify that encapsulated BIG TCP packets
> can get to their destination. In the test with TX checksum offload off,
> software GSO splits aggregated VXLAN packets before passing them to
> veth, so capture inside the tunnel instead to check that the big packets
> are not dropped.
> 
> Check that the amount of SACKs is negligible. On unsupported kernels,
> some amount of broken GSO packets bigger than 65536 bytes can be
> produced in VXLAN tunnels, but they don't reach the destination. Seeing
> TCP SACKs is a sign that such packets could have been dropped (in such
> cases, the amount of SACKs is a few times bigger than the number of
> attempts to send BIG TCP packets).
> 
> Signed-off-by: Alice Mikityanska <alice@isovalent.com>
> ---
>  tools/testing/selftests/net/Makefile          |   1 +
>  .../testing/selftests/net/big_tcp_tunnels.sh  | 183 ++++++++++++++++++
>  2 files changed, 184 insertions(+)
>  create mode 100755 tools/testing/selftests/net/big_tcp_tunnels.sh
> 
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index 708d960ae07d..4cb0a0bc1eea 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -13,6 +13,7 @@ TEST_PROGS := \
>  	arp_ndisc_untracked_subnets.sh \
>  	bareudp.sh \
>  	big_tcp.sh \
> +	big_tcp_tunnels.sh \
>  	bind_bhash.sh \
>  	bpf_offload.py \
>  	bridge_stp_mode.sh \
> diff --git a/tools/testing/selftests/net/big_tcp_tunnels.sh b/tools/testing/selftests/net/big_tcp_tunnels.sh
> new file mode 100755
> index 000000000000..128a710e74ad
> --- /dev/null
> +++ b/tools/testing/selftests/net/big_tcp_tunnels.sh
> @@ -0,0 +1,183 @@
> +#!/usr/bin/env bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Testing for IPv4 and IPv6 BIG TCP over VXLAN and GENEVE tunnels.
> +
> +SERVER_NS=$(mktemp -u server-XXXXXXXX)
> +SERVER_IP4="192.168.1.1"
> +SERVER_IP6="2001:db8::1:1"
> +SERVER_IP4_TUN="192.168.2.1"
> +SERVER_IP6_TUN="2001:db8::2:1"
> +
> +CLIENT_NS=$(mktemp -u client-XXXXXXXX)
> +CLIENT_IP4="192.168.1.2"
> +CLIENT_IP6="2001:db8::1:2"
> +CLIENT_IP4_TUN="192.168.2.2"
> +CLIENT_IP6_TUN="2001:db8::2:2"
> +
> +: "${PACKETS_THRESHOLD:=1000}"
> +
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
> +
> +setup() {
> +	ip netns add "$SERVER_NS"
> +	ip netns add "$CLIENT_NS"
> +	ip -netns "$SERVER_NS" link add link1 type veth peer name link0 netns "$CLIENT_NS"
> +
> +	ip -netns "$CLIENT_NS" link set link0 up
> +	ip -netns "$CLIENT_NS" addr replace "$CLIENT_IP4/24" dev link0
> +	ip -netns "$CLIENT_NS" addr replace "$CLIENT_IP6/112" dev link0 nodad
> +	ip -netns "$CLIENT_NS" link set link0 \
> +		gso_max_size 196608 gso_ipv4_max_size 196608 \
> +		gro_max_size 196608 gro_ipv4_max_size 196608
> +	ip -netns "$SERVER_NS" link set link1 up
> +	ip -netns "$SERVER_NS" addr replace "$SERVER_IP4/24" dev link1
> +	ip -netns "$SERVER_NS" addr replace "$SERVER_IP6/112" dev link1 nodad
> +	ip -netns "$SERVER_NS" link set link1 \
> +		gso_max_size 196608 gso_ipv4_max_size 196608 \
> +		gro_max_size 196608 gro_ipv4_max_size 196608
> +
> +	ip netns exec "$SERVER_NS" netserver >/dev/null
> +}
> +
> +setup_tunnel() {
> +	if [ "$2" = 4 ]; then
> +		SERVER_IP="$SERVER_IP4"
> +		CLIENT_IP="$CLIENT_IP4"
> +		echo "Setting up ${1^^} over IPv4, veth tx csum offload $3"
> +	else
> +		SERVER_IP="$SERVER_IP6"
> +		CLIENT_IP="$CLIENT_IP6"
> +		echo "Setting up ${1^^} over IPv6, veth tx csum offload $3"
> +	fi
> +
> +	if [ "$1" = vxlan ]; then
> +		ip -netns "$CLIENT_NS" link add tun0 type vxlan \
> +			id 5001 remote "$SERVER_IP" local "$CLIENT_IP" dev link0 dstport 4789
> +	else
> +		ip -netns "$CLIENT_NS" link add tun0 type geneve \
> +			id 5001 remote "$SERVER_IP"
> +	fi
> +	ip -netns "$CLIENT_NS" link set tun0 up
> +	ip -netns "$CLIENT_NS" addr replace "$CLIENT_IP4_TUN/24" dev tun0
> +	ip -netns "$CLIENT_NS" addr replace "$CLIENT_IP6_TUN/112" dev tun0 nodad
> +	ip -netns "$CLIENT_NS" link set tun0 \
> +		gso_max_size 196608 gso_ipv4_max_size 196608 \
> +		gro_max_size 196608 gro_ipv4_max_size 196608
> +	if [ "$1" = vxlan ]; then
> +		ip -netns "$SERVER_NS" link add tun1 type vxlan \
> +			id 5001 remote "$CLIENT_IP" local "$SERVER_IP" dev link1 dstport 4789
> +	else
> +		ip -netns "$SERVER_NS" link add tun1 type geneve \
> +			id 5001 remote "$CLIENT_IP"
> +	fi
> +	ip -netns "$SERVER_NS" link set tun1 up
> +	ip -netns "$SERVER_NS" addr replace "$SERVER_IP4_TUN/24" dev tun1
> +	ip -netns "$SERVER_NS" addr replace "$SERVER_IP6_TUN/112" dev tun1 nodad
> +	ip -netns "$SERVER_NS" link set tun1 \
> +		gso_max_size 196608 gso_ipv4_max_size 196608 \
> +		gro_max_size 196608 gro_ipv4_max_size 196608
> +
> +	ip netns exec "$CLIENT_NS" ethtool -K link0 tx-checksumming "$3" > /dev/null
> +	ip netns exec "$SERVER_NS" ethtool -K link1 tx-checksumming "$3" > /dev/null
> +}
> +
> +cleanup_tunnel() {
> +	ip -netns "$CLIENT_NS" link del tun0
> +	ip -netns "$SERVER_NS" link del tun1
> +}
> +
> +cleanup() {
> +	ip netns pids "$SERVER_NS" | xargs -r kill
> +	ip netns pids "$CLIENT_NS" | xargs -r kill
> +	ip netns del "$SERVER_NS"
> +	ip netns del "$CLIENT_NS"
> +	rm -rf "$WORKDIR"
> +}
> +
> +do_test() {
> +	# When tx csum offload is off, software GSO is performed before passing the
> +	# packet to veth. Check BIG TCP packets inside the VXLAN tunnel to verify
> +	# the software checksum path: if the checksum code is broken, these packets
> +	# will be dropped.
> +	if [ "$2" = on ]; then
> +		CAPTURE_IFACE='link'
> +	else
> +		CAPTURE_IFACE='tun'
> +	fi
> +
> +	ip netns exec "$SERVER_NS" tcpdump -nn -s 256 -i "${CAPTURE_IFACE}1" greater 65536 -w "$WORKDIR/server.pcap" 2> /dev/null &
> +	TCPDUMP_SERVER_PID="$!"
> +	ip netns exec "$CLIENT_NS" tcpdump -nn -s 256 -i "${CAPTURE_IFACE}0" greater 65536 -w "$WORKDIR/client.pcap" 2> /dev/null &
> +	TCPDUMP_CLIENT_PID="$!"
> +
> +	# This filter doesn't capture all possible variants of SACK, but it's aimed
> +	# at the typical one where SACK follows after [nop, nop, timestamp, nop,
> +	# nop] (14 bytes after the 20-byte TCP header). IPv6 needs a separate match,
> +	# because man tcpdump says:
> +	# > Arithmetic expression against transport layer headers, like tcp[0], does
> +	# > not work against IPv6 packets.  It only looks at IPv4 packets.
> +	ip netns exec "$SERVER_NS" tcpdump -nn -s 256 -i "tun1" '(tcp[tcpflags] & (tcp-syn|tcp-ack) = tcp-ack and tcp[34:2] & 0xffc3 = 0x0502) or (ip6[6] = 0x06 and ip6[53] & 0x12 = 0x10 and ip6[74:2] & 0xffc3 = 0x0502)' -w "$WORKDIR/sack.pcap" 2> /dev/null &
> +	TCPDUMP_SACK_PID="$!"
> +
> +	if [ "$1" = 4 ]; then
> +		SERVER_IP="$SERVER_IP4_TUN"
> +		echo "Running IPv4 traffic in the tunnel"
> +	else
> +		SERVER_IP="$SERVER_IP6_TUN"
> +		echo "Running IPv6 traffic in the tunnel"
> +	fi
> +
> +	sleep 1 # Give tcpdump a second to spin up.
> +	ip netns exec "$CLIENT_NS" netperf -t TCP_STREAM -l 5 -H "$SERVER_IP" -- \
> +		-m 80000 > /dev/null
> +	sleep 1 # Give tcpdump a second to process buffered packets.
> +	kill "$TCPDUMP_SERVER_PID" "$TCPDUMP_CLIENT_PID" "$TCPDUMP_SACK_PID"
> +	wait "$TCPDUMP_SERVER_PID" "$TCPDUMP_CLIENT_PID" "$TCPDUMP_SACK_PID"
> +	PACKETS_SERVER=$(tcpdump --count -r "$WORKDIR/server.pcap" 2> /dev/null | cut -d ' ' -f 1)
> +	PACKETS_CLIENT=$(tcpdump --count -r "$WORKDIR/client.pcap" 2> /dev/null | cut -d ' ' -f 1)
> +	PACKETS_SACK=$(tcpdump --count -r "$WORKDIR/sack.pcap" 2> /dev/null | cut -d ' ' -f 1)
> +
> +	echo "Captured BIG TCP RX packets: $PACKETS_SERVER"
> +	echo "Captured BIG TCP TX packets: $PACKETS_CLIENT"
> +	echo "Captured TCP SACK packets: $PACKETS_SACK"
> +	[ "$PACKETS_SERVER" -gt "$PACKETS_THRESHOLD" ] || return 1
> +	[ "$PACKETS_CLIENT" -gt "$PACKETS_THRESHOLD" ] || return 1
> +	[ "$PACKETS_SACK" -lt "$(( PACKETS_CLIENT / 2 ))" ] || return 1

KCI fails here, see:

https://netdev-ctrl.bots.linux.dev/logs/vmksft/net/results/722863/156-big-tcp-tunnels-sh/stdout

possibly the above parsing is a bit fragile/tcpdump version's dependent?!?

Note that KCI automatically drops from PW series with failing test.

/P


