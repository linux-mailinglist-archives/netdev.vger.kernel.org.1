Return-Path: <netdev+bounces-258013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBkJOwORimkQMAAAu9opvQ
	(envelope-from <netdev+bounces-258013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 02:59:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 504E61161AB
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 02:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 124E43010BB8
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 01:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584EE287268;
	Tue, 10 Feb 2026 01:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfJ+dJQb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DD32868B5
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 01:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770688769; cv=none; b=DIxY9GjyB10hJNu4i4ePAbAuvpExcizHXh04VrQUOqOKn2NQwnIFNf24YQQFGpyVj505jfX61gWF0VzfQO9/QdRKN7kiDpKP73u+SU1oYSXyODwPiocTyDMqW4rmfVGv+bZpqp0wSC9JB/Z70jG7yLGrz3+fgdW0lNBSn3KKdvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770688769; c=relaxed/simple;
	bh=S3vagD1JOscOG2BcqSDKH/Qv/Q1vybKhxHOSgCGjEWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trRGD3rl93KvsDyALDxerXyxjdTfDY1ccy9pqflorZc4BtHBpCTK36fYgbOqKJEkhp3wYKoo2ulbCE8Q42CIx2mhhN18yk8ytbb5hYD9DxUyvElAQBvmXbD1BX+t+xg9AADV9Yh6V/0w8iU/fhU4/Nq62DYrpjYE8eKoJbMwUFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfJ+dJQb; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8230c839409so273582b3a.3
        for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 17:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770688767; x=1771293567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yJeXiplSxyKqxN84bqYmhFFSRg728Hdbv8soCFI7W5w=;
        b=AfJ+dJQbwYqdBFQh2O0dAU+VVr0W5pPCeAiTB5lOi1cf1FWEqm7w+WiKFDwBdOQiaZ
         oJxiolnYUCXt2lebeQeyWfSYo/8rvlgbtvrkqibUyui/d8OdFpGmTyGaLpaOZLBmryWx
         0rJA4qDHBUGIdKP/KleU/9PxIPt4SgA3CMPaTNjpncZC7FXpbPH4BgHoQ6UYn3xC0oHW
         PewESplxpJWVsMXdsAwtKEVrnVQR+02aGqp9p9b7j9MRgYmffb74Ri5sQd5pzapEBMOS
         H9PaCwjEa4K0LrreQq4Ua7Qmwcwa2+v58oWthOs/trhWXUYeAcxBgVdoDIUT3QKjcqcW
         jcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770688767; x=1771293567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJeXiplSxyKqxN84bqYmhFFSRg728Hdbv8soCFI7W5w=;
        b=bdN37cjbE7TLH035pGqErsF7Dgf6bEgTAlZCXv01ukumjkqksCLtNgOOIlGCREHkrL
         OjMZ0GTWL+1SyXy9BJ/YjZbCylREvs3sDyyeLUwwA81ecHSmy2E/BUwasITanHn+G2ng
         E5pgpr4jmyLzhW2qAd+Y9WQo1Q/u6x4VvgaSON/jsiB9zfgpHCCb3jjN60sL2sokuGXK
         /Xv/YHU1IKyTDyg0L3vwec+IXbboXGeZYit8SWlXVJrwwKQRG3Kdf8kRVaouYlOkhTcT
         xwgbExJCGfD1mF7PjwZIbZ/Kp0hV5KFmmqLZZDAVWVLuApq3fpA0MG3q2iFVqMlz0EcS
         +WhA==
X-Forwarded-Encrypted: i=1; AJvYcCUYqtBWdlEJ5cm6w1l4sjr3AJTtU7XJEyMNzG1c+MsDX7SK/GQebNLl6z5jrvoTDghGvOilgds=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGsl+7HNxEf23TYT1aoJJtV9vJr4f5a5+VyqumPF6dHvrNX1El
	6Xc+dSyPuh6Fr4DbtqE/XVj7MkPdlxXj/AI7G4UIwQriJYwniEmTAQJI
X-Gm-Gg: AZuq6aKET7VLS9wtJo21GFhH7yCI9T64RiURZ5zyWOK8h60ED3JEC6vfdZAvZXtIECc
	iSvxGsCB9l5xhS3qrlTkCVeC1litqs4vSjOLJ44G16wU1gANBVVi4/zxrVPaFzlWboqYp+Ox30l
	YaHL0Y3/jO8YFwDk9+xHrnlmclC9gLAXm6aYIPQksGZNADIe7zFCBukkBWHb4TZXYeptPVGzUNX
	UTDuJzGYUN3iog/DzBzRxq9xgB2XnesRCmgYMAz8DpWzhO7WV03Bk8bW0x4ENcQRLscEfdNKY+b
	q8VLWpu0Wt+z/bJwBQC1xIM51gK81v4xG+wbmNyCExDOH8/gWhVqcCbyPncWMoaryECjlmE81i1
	/2mj+6IRkEZbQjVml/uxBEl4xqUIQgJCIbmOk3zg5D1v2D8Vc9X1LfTDRhs1ibHmfp2QlI8O0pL
	nqJugR5r4Y7P+Z5D1rGianGBKlkAA=
X-Received: by 2002:a05:6a00:1785:b0:81e:2bca:d133 with SMTP id d2e1a72fcca58-82441634f9cmr11903742b3a.24.1770688767391;
        Mon, 09 Feb 2026 17:59:27 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8244166f3edsm12442752b3a.3.2026.02.09.17.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 17:59:26 -0800 (PST)
Date: Tue, 10 Feb 2026 01:59:19 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Linus Heckemann <git@sphalerite.org>
Cc: edumazet@google.com, davem@davemloft.net, eric.dumazet@gmail.com,
	horms@kernel.org, kuba@kernel.org, morikw2@gmail.com,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzbot+d4dda070f833dc5dc89a@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] selftests/net: add test for IPv4-in-IPv6 tunneling
Message-ID: <aYqQ9zPAisaNLpMX@fedora>
References: <20260209190008.139099-2-git@sphalerite.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209190008.139099-2-git@sphalerite.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258013-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,gmail.com,kernel.org,vger.kernel.org,redhat.com,syzkaller.appspotmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,d4dda070f833dc5dc89a];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,io_uring_zerocopy_tx.sh:url,ip6_gre_headroom.sh:url]
X-Rspamd-Queue-Id: 504E61161AB
X-Rspamd-Action: no action

Hi Linus,

For the subject, please also provide the target repo. e.g. [PATCH v2 net-next]

On Mon, Feb 09, 2026 at 08:00:09PM +0100, Linus Heckemann wrote:
> commit 81c734dae203 ("ip6_tunnel: use skb_vlan_inet_prepare() in
> __ip6_tnl_rcv()") was fine in and of itself, but its backport to 6.12
> (and 6.6) broke IPv4-in-IPv6 tunneling, see [1]. This adds a self-test
> for basic IPv4-in-IPv6 and IPv6-in-IPv6 functionality.
> 
> [1]: https://lore.kernel.org/all/CAA2RiuSnH_2xc+-W6EnFEG00XjS-dszMq61JEvRjcGS31CBw=g@mail.gmail.com/
> 
> --
> Thanks for the review, Hangbin!
> ---
>  tools/testing/selftests/net/Makefile      |  1 +
>  tools/testing/selftests/net/ip6_tunnel.sh | 43 +++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
>  create mode 100644 tools/testing/selftests/net/ip6_tunnel.sh
> 
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index 45c4ea381bc36..5037a344ad826 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -43,6 +43,7 @@ TEST_PROGS := \
>  	io_uring_zerocopy_tx.sh \
>  	ioam6.sh \
>  	ip6_gre_headroom.sh \
> +	ip6_tunnel.sh \
>  	ip_defrag.sh \
>  	ip_local_port_range.sh \
>  	ipv6_flowlabel.sh \
> diff --git a/tools/testing/selftests/net/ip6_tunnel.sh b/tools/testing/selftests/net/ip6_tunnel.sh
> new file mode 100644
> index 0000000000000..4886618fd2689
> --- /dev/null
> +++ b/tools/testing/selftests/net/ip6_tunnel.sh
> @@ -0,0 +1,43 @@
> +#!/bin/bash
> +# Test that IPv4-over-IPv6 tunneling works.
> +
> +source lib.sh
> +
> +setup_prepare() {
> +  ip link add transport1 type veth peer name transport2
> +
> +  setup_ns ns1
> +  ip link set transport1 netns $ns1
> +  ip -n $ns1 address add 2001:db8::1/64 dev transport1 nodad
> +  ip -n $ns1 address add 2001:db8::3/64 dev transport1 nodad
> +  ip -n $ns1 link set transport1 up
> +  ip -n $ns1 link add link transport1 name tunnel4 type ip6tnl mode ipip6 local 2001:db8::1 remote 2001:db8::2
> +  ip -n $ns1 address add 172.0.0.1/32 peer 172.0.0.2/32 dev tunnel4
> +  ip -n $ns1 link set tunnel4 up
> +  ip -n $ns1 link add link transport1 name tunnel6 type ip6tnl mode ip6ip6 local 2001:db8::3 remote 2001:db8::4
> +  ip -n $ns1 address add 2001:db8:6::1/64 dev tunnel6
> +  ip -n $ns1 link set tunnel6 up
> +
> +  setup_ns ns2
> +  ip link set transport2 netns $ns2
> +  ip -n $ns2 address add 2001:db8::2/64 dev transport2 nodad
> +  ip -n $ns2 address add 2001:db8::4/64 dev transport2 nodad
> +  ip -n $ns2 link set transport2 up
> +  ip -n $ns2 link add link transport2 name tunnel4 type ip6tnl mode ipip6 local 2001:db8::2 remote 2001:db8::1
> +  ip -n $ns2 address add 172.0.0.2/32 peer 172.0.0.1/32 dev tunnel4
> +  ip -n $ns2 link set tunnel4 up
> +  ip -n $ns2 link add link transport2 name tunnel6 type ip6tnl mode ip6ip6 local 2001:db8::4 remote 2001:db8::3
> +  ip -n $ns2 address add 2001:db8:6::2/64 dev tunnel6
> +  ip -n $ns2 link set tunnel6 up
> +}
> +
> +cleanup() {
> +  cleanup_all_ns
> +  # in case the namespaces haven't been set up yet
> +  ip link delete transport1 || true

Maybe
  ip link delete transport1 &> /dev/null || true

since this cmd usually would fail and report
  Cannot find device "transport1"
> +}

You forgot to add `set -e`,
> +
> +trap cleanup EXIT
> +setup_prepare
> +ip netns exec $ns1 ping -W1 -c1 172.0.0.2
> +ip netns exec $ns1 ping -W1 -c1 2001:db8:6::2

So if the first ping failed, and the second ping pass, the total test will
still return 0.

Thanks
Hangbin

