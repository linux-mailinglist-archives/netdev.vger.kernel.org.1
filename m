Return-Path: <netdev+bounces-286993-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gECZHujeAmoMyQEAu9opvQ
	(envelope-from <netdev+bounces-286993-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:03:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D69A551C5D3
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68FB53079177
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C1047DFAA;
	Tue, 12 May 2026 08:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f/uTiwk0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="W2dxQ00x"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E88158535
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 08:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778572812; cv=none; b=B3AlM0gSiwuHmc0aGh11EO93Lt8i7Z8aiyS3jTP4+YCp2Y2W4j/vnjA0aNJenNemF6dKCmpWHNa+JPmxKJmIesa89QX0vN3vq+AilekygZBNxNWjvPh+mxvuABn+x9pI9FNvQ2nurejz/Chc/mRZtLX5bbTYRcGnNjYeLSyUkdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778572812; c=relaxed/simple;
	bh=GJ/y7fGortN5jBu8cvpMLctnF416622K/5UMEtlQUdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QXElieNHVFd3HfyLlRjGcSD33PbmVYwXLhUjA7dADRyMzFFVZO6zaB1MToMa3iKIRtYpZOfm9sMMsY7TFuXXN42cBCccgPmVVtw2hqcC9Hsjsp14BV/rEIX5HPfSKl9QAJDXUuTKkE99GVQyokpu+8elU/G0hzXQfyWZoJYth/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f/uTiwk0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=W2dxQ00x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778572809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyFGEYlHjHtjEOVbVD/w/qb9ux9FYhsyRj3ILgwVqco=;
	b=f/uTiwk0Tvci25ABes5UEsfuFKcwC0pNFN+WYHkz46MlH+pf8piNllvvqj1GzI9Lbupa+v
	Xf/0YHWMUP47JDjgO7X38gVlWu0fv1Cxs8p93k2pG5M6+6O8dRNIvADN8WIV1k78GBRl5n
	Zr/1zPmz7xZX5qwjYmp5oQcASyaUm34=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-C13j4D0COXiJteh71D-AaQ-1; Tue, 12 May 2026 04:00:07 -0400
X-MC-Unique: C13j4D0COXiJteh71D-AaQ-1
X-Mimecast-MFC-AGG-ID: C13j4D0COXiJteh71D-AaQ_1778572807
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488d8deb75fso37951195e9.3
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 01:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778572806; x=1779177606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cyFGEYlHjHtjEOVbVD/w/qb9ux9FYhsyRj3ILgwVqco=;
        b=W2dxQ00xOxlFoiuhJngMUCv2QsqqzILKS9ZGsaADjuy2nWcmBPN73O4D8Nmf2kJC5p
         IY9AqI7ZTMz0Aeevyf3x82Qcb9Wl6hB59mH/9zR2Vyue8MwehGBBQlEvt1yMW87VV1wi
         +NtC190237J5L3gRFfOqady7tOKDsESevMoaQPopAQ8nCFBelVO9rHiHxiTLqcJjylnF
         4bVttSEHb7wtoe/6dx9Vse3lxNh3/Xc1EsXXnc9RLB5augyAvts1Yd8cnSnJAkQEPM/U
         FQmQRFH2dHmf8HROEYAijPA7f28dkHWiF7agkRtO73XeJKEwe7TDyP6SLJCY5ZuxfJYl
         9Izg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778572806; x=1779177606;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cyFGEYlHjHtjEOVbVD/w/qb9ux9FYhsyRj3ILgwVqco=;
        b=pnp7E7DtFDYc1rz0hMNlYU8FU/J0/yiwoLGg5UGk0ug+TD97Cj/lduWGYHW+3Glg5r
         z6X7WWdeOsakwiLQW8JKyzDqtwVWilBL4mpwv0EG2cyOnfAf7E3sYuHHGNxEJI7AV+1C
         JeH/e+9yrj0+0O1tYiQuKJmq4QV0lDy9wdtuFaSzWQEINp8cCTMO2ND7G3quUL5VHKMs
         iJ4u1gLRIzl4FxNKwu66ZttlCypldNrsP+OqLonxCvRemQT5KYLr5aG0933HysoJvn/A
         7yQgH55RTdvvGy34NWg5v3e5PvfaWQVX3fgbANw8gWJTNl7dx3Ij02hOacV4YIVdu6aU
         j4FA==
X-Forwarded-Encrypted: i=1; AFNElJ9ho2NCWzmik3aDRRNAu4Q0e0CHTu/5l+4DUR2QDOt0evpC3HRdMVFM31DJuQGxAbR3+iYKbJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTaMk7aMjY1mQurh7HYbyLWSSDXbPg++tikaqmNhxU+G+Nh1nw
	dR4jqU5aHdopYgsQd6xccqwwobD+omrWKir3MqF/j7aDC+1DtksXm1WOm2jVzvSTo37hSchJ/tL
	rJkTdwKnrQTU+Qnne5345Pl2794EvynzfKIn1s6EH8myGL6SPS6ZGCWXpNQ==
X-Gm-Gg: Acq92OFZxUVj3mpHIMKwg3HQ0B9mrIVpLJ9d/xQBgDay7gk82aWYGNOYWKgOFjoGV1Q
	uQ+usaYncJdg5vhupdLA4ndu8t+x6x1cqZ6fzpdudju5MEymxtg9VsMiJlL56DBRpbLxhjNM1jA
	hYIDzpKnSlZ2PXS4pbvDZw08cnjr6IVGjAyDJBNgeLaM0J2gDFrNIT09VfKrs6mP3dzOYvJNWe6
	Kq4mDQS+RtDcK/YhnTuBsn1h+hGQxloA/029IxBfndOU7sroy9aNJxyqWgCW/D6nE9OCdh31o7k
	Iv2taxDkkYCgi93807UG6iA9BoN16z9S8n45s7dyi/Wh1qQ0XmC8whHfp2VbwP6UU55F9vexQ7z
	mf47I+PoXCaATo2RkRrLVuQK+vm8SvTy71Xo0m1Y7Rbxvt9ZSrOLZo8o=
X-Received: by 2002:a05:600c:46d2:b0:485:364e:9328 with SMTP id 5b1f17b1804b1-48e51f32aebmr396266585e9.16.1778572806224;
        Tue, 12 May 2026 01:00:06 -0700 (PDT)
X-Received: by 2002:a05:600c:46d2:b0:485:364e:9328 with SMTP id 5b1f17b1804b1-48e51f32aebmr396265385e9.16.1778572805618;
        Tue, 12 May 2026 01:00:05 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e906a0debsm41474895e9.3.2026.05.12.01.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 01:00:05 -0700 (PDT)
Message-ID: <05927f32-8df5-4a78-a188-5a4c2b82a85a@redhat.com>
Date: Tue, 12 May 2026 10:00:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: net: add tests for PPPoL2TP
To: Qingfang Deng <qingfang.deng@linux.dev>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Felix Maurer <fmaurer@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Petr Machata <petrm@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260508032158.67887-1-qingfang.deng@linux.dev>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260508032158.67887-1-qingfang.deng@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D69A551C5D3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-286993-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ppp_common.sh:url]
X-Rspamd-Action: no action

On 5/8/26 5:21 AM, Qingfang Deng wrote:
> diff --git a/tools/testing/selftests/net/ppp/pppol2tp.sh b/tools/testing/selftests/net/ppp/pppol2tp.sh
> new file mode 100755
> index 000000000000..5ddcc6c41c33
> --- /dev/null
> +++ b/tools/testing/selftests/net/ppp/pppol2tp.sh
> @@ -0,0 +1,93 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +source ppp_common.sh
> +
> +NK_SERVER="nk0"
> +NK_CLIENT="nk1"
> +OUTER_IP_SERVER="172.16.1.1"
> +OUTER_IP_CLIENT="172.16.1.2"
> +
> +PPPOL2TP_DIR=$(mktemp -d /tmp/pppol2tp.XXXXXX)

Sashiko (gemini) reports an unhandled error condition here. AFAICS that
is irrelevant as it could happen only on a broken system.

> +
> +# shellcheck disable=SC2329
> +cleanup() {
> +	cleanup_all_ns
> +	rm -rf "$PPPOL2TP_DIR"
> +}
> +
> +trap cleanup EXIT
> +
> +require_command xl2tpd
> +ppp_common_init
> +modprobe -q l2tp_ppp
> +
> +# Create the netkit pair
> +ip -netns "$NS_CLIENT" link add "$NK_CLIENT" type netkit
> +ip -netns "$NS_CLIENT" link set "$NK_SERVER" netns "$NS_SERVER"
> +ip -netns "$NS_SERVER" link set "$NK_SERVER" up
> +ip -netns "$NS_CLIENT" link set "$NK_CLIENT" up
> +ip -netns "$NS_SERVER" address add dev "$NK_SERVER" "$OUTER_IP_SERVER" peer "$OUTER_IP_CLIENT"
> +ip -netns "$NS_CLIENT" address add dev "$NK_CLIENT" "$OUTER_IP_CLIENT" peer "$OUTER_IP_SERVER"
> +
> +# Generate configuration files
> +cat > "$PPPOL2TP_DIR/l2tp-server.conf" <<EOF
> +[global]
> +listen-addr = $OUTER_IP_SERVER
> +access control = no
> +
> +[lns default]
> +ip range = $IP_CLIENT
> +local ip = $IP_SERVER
> +require authentication = no
> +require chap = no
> +require pap = no
> +ppp debug = yes
> +pppoptfile = $(pwd)/pppoe-server-options
> +EOF
> +
> +cat > "$PPPOL2TP_DIR/l2tp-client.conf" <<EOF
> +[global]
> +listen-addr = $OUTER_IP_CLIENT
> +access control = no
> +
> +[lac server]
> +lns = $OUTER_IP_SERVER
> +require authentication = no
> +require chap = no
> +require pap = no
> +ppp debug = yes
> +pppoptfile = $(pwd)/pppoe-server-options
> +EOF
> +
> +# Start the L2TP Server
> +ip netns exec "$NS_SERVER" xl2tpd -D -c "$PPPOL2TP_DIR/l2tp-server.conf" \
> +	-p "$PPPOL2TP_DIR/l2tp-server.pid" -C "$PPPOL2TP_DIR/l2tp-server.control" &
> +
> +# Start the L2TP Client
> +ip netns exec "$NS_CLIENT" xl2tpd -D -c "$PPPOL2TP_DIR/l2tp-client.conf" \
> +	-p "$PPPOL2TP_DIR/l2tp-client.pid" -C "$PPPOL2TP_DIR/l2tp-client.control" &
> +
> +# Wait for xl2tpd to start and open their control pipes
> +slowwait 2 [ -p "$PPPOL2TP_DIR/l2tp-server.control" ]
> +slowwait 2 [ -p "$PPPOL2TP_DIR/l2tp-client.control" ]
> +
> +# Connect LAC to LNS
> +echo "c server" > "$PPPOL2TP_DIR/l2tp-client.control"
> +
> +ppp_test_connectivity
> +
> +log_test "PPPoL2TP"
> +
> +# Recursion test
> +# Delete route to LNS IP
> +ip -netns "$NS_CLIENT" route del "$OUTER_IP_SERVER"
> +# Add default route through ppp0
> +ip -netns "$NS_CLIENT" route add default dev ppp0
> +# ping (we expect the ping to fail but not deadlock the system)
> +ip netns exec "$NS_CLIENT" ping -c 1 "$IP_SERVER" -w 1
> +check_fail $?

Sashiko notes you should clear the RET global variable before any direct
or indirect invocation of check_err

/P


