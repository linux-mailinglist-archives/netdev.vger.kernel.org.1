Return-Path: <netdev+bounces-257994-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMbIF8pdimkWJwAAu9opvQ
	(envelope-from <netdev+bounces-257994-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 23:20:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B74E211507F
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 23:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED73A30086CA
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 22:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEC430F535;
	Mon,  9 Feb 2026 22:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E5ec6OyH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAF630FC1C
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 22:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770675599; cv=none; b=e1bSH81uwhPaXxQHX6ZCR5vJ0miI4IS+dn5Xz6QqyWSIk64kxijztRBnrgV7riXmDY0WtoQqkRU67DGrd8iropn91vw/HjXRWRQVWYHlEYWT0muYJTv4qy3uJs5mt1LMjW1fad6eZqwyz6gzjLDlEBxBIOXWWjuR10p1zwdjhHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770675599; c=relaxed/simple;
	bh=qGk3AVq0RPSJvUpq9uM9CNE8h4KVJqZk6VJjvPfUcX0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=n8hFe+6SiOmwdzGJgiO39tPf7Ch+cm67qfvzqv5AFXafW9eCxB4lEoiqwZESzWMalA6Z8L2BLwcgetHrGC83kc40+XMq3GzO3jNWjsrR5H4WLa9ROA4DSMh4DN+SzCFGgi1JuuUDDqs9p6l0ROezrTux9O54r+SHcRSlofYu1eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E5ec6OyH; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so2088115e9.1
        for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 14:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770675596; x=1771280396; darn=vger.kernel.org;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sxz5c9FvUvbBTQDP7ypLXaYCH9urfXVqj7hb945KDLo=;
        b=E5ec6OyH/HeY3xWtGNqSd9fOK7HGnAxEiXGavYBkyDqqOEdthWMutHRk7B0C/Ia3xm
         E9n2Cm6UG6N6JbQSYCCHFLVP93m8t+1Ih0C0Eh1iZnWPTW24q3bLyIOYR3deGyw89nK1
         kTtihrvcV+VXJUWDgaXJqAGdC5l6osY+znofcIzosRQI8Rp1mjIrvkdWjqL2pI1+5fEt
         Wrsl3WolW/lTTUhA1JwwYtbjRCPPS/qz/kbmK14P2TS47kge82dr+esMxrlaG1Ab/rYN
         w/fmSJWWHjzmXe+iJMa98UBIjPweuQO2TsbaYNqizdaOxxZvCu8b9Dzi3lkBgCH4+Hp7
         p78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770675596; x=1771280396;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sxz5c9FvUvbBTQDP7ypLXaYCH9urfXVqj7hb945KDLo=;
        b=oJ1sPJ6i5ae8iH2MypfIzB9XBoDhWtinMaIEwPKQBlrpnxHpKIq7dWL2L9nwHba0Uq
         KA/p0gjh41BXYu7JhlwUF8ZqIbBPxkWm7u+2YbTmkr+wfmjL0VnkIIUhzpS22w/t0kBu
         Y31kvusgaXYD4jpkq+XPvrPaeEOZ0FgfXIaqjot6EQrmil9Ofd0iYhRerkFBQ8/yViJL
         8ivjiZaigVJ0OyZe2Xnw4En+r7wDFqun0WhwZ3D6ejGWqBAXQ85+0NYN0Ql0hm2Vp1d/
         sYmJlfyvPKpRF6wJ/mdaXLfkjtmbb9JdsmNWl94zdUQZZ1Kxko5d1jNgtfC0qXhO0E4N
         T/2A==
X-Forwarded-Encrypted: i=1; AJvYcCUwIv9xnhDlsoMqMyHrji6XpA10svvUbFvcurYfmKlKonxdKviauJjcg2id/ICD+2QfIbDjkZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSreUBhVtp9nmGCGb7xqX5k6yfgZbVYFApRiwYwGUCuIut8jLj
	VDr/MHPehUdYfc5R+cKdIdy3+yuAkWov1VVljMJbq3wc2XGjVIP77PprdOHta/UBei4Hd8TA/1a
	gjGoJ
X-Gm-Gg: AZuq6aLGNW4EIeNd/2YF313rpAPdeZKN5f35wKm2fhCv/ohURbnMDF3mB+62MkbK0H3
	S9erhoAbr67mdMcV+BqFMhTVKsegPmOn9eQbIgJXok2x9fdh8uPvzXsJx0yTjjzHjjpWiTbeq3u
	8RTaChqviqVA5N58SocQBz2p/k7SVNE0iAb3178tn48RhrylFJn/5aqr/7ibknYTh59sRuCETP1
	LCBsbBmNGJztWFrzjy5y3wFKK6R2IA6NWfz9kaTbnDmeQzE4xN2WSOUqr5zLkzycYmV5sjndGRy
	cSGBdzA1ehvQHPaoB2L7Y9N7zRyoAONzcOo/O1gB5zHnszC56hLXGJWVWS+cMfj1ggGTzMRPzR4
	cu8k+bzWPHCcSJcQv7HImOvuICPNpk+PgJZiQ6x+AEbQE5pORZ6oXbl96s0hp7k6yryjWQY3Msg
	M=
X-Received: by 2002:a05:600c:a111:b0:483:3380:ca12 with SMTP id 5b1f17b1804b1-4833380cb1amr90023115e9.29.1770675595922;
        Mon, 09 Feb 2026 14:19:55 -0800 (PST)
Received: from localhost ([179.228.217.110])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79529e45621sm105482997b3.0.2026.02.09.14.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 14:19:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Feb 2026 19:19:53 -0300
Message-Id: <DGAS4219YAVM.1FO5C2440EBYZ@suse.com>
Cc: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
 <kuba@kernel.org>, <morikw2@gmail.com>, <netdev@vger.kernel.org>,
 <pabeni@redhat.com>,
 <syzbot+d4dda070f833dc5dc89a@syzkaller.appspotmail.com>
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>, "Linus
 Heckemann" <git@sphalerite.org>, <edumazet@google.com>
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Subject: Re: [PATCH] selftests/net: add test for IPv4-in-IPv6 tunneling
X-Mailer: aerc 0.21.0
References: <20260208144604.1550582-1-git@sphalerite.org>
 <DGAR3PO1D33S.1TI7W7U4SPTOG@suse.com>
In-Reply-To: <DGAR3PO1D33S.1TI7W7U4SPTOG@suse.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,gmail.com,kernel.org,vger.kernel.org,redhat.com,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257994-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rbm@suse.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,d4dda070f833dc5dc89a];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ip6_gre_headroom.sh:url,ip_local_port_range.sh:url]
X-Rspamd-Queue-Id: B74E211507F
X-Rspamd-Action: no action

On Mon Feb 9, 2026 at 6:32 PM -03, Ricardo B. Marli=C3=A8re wrote:
> On Sun Feb 8, 2026 at 11:46 AM -03, Linus Heckemann wrote:
>> 81c734dae203757fb3c9eee6f9896386940776bd was fine in and of itself, but
>> its backport to 6.12 (and 6.6) broke IPv4-in-IPv6 tunneling, see [1].
>> This adds a self-test for basic IPv4-in-IPv6 functionality.
>>
>> [1]: https://lore.kernel.org/all/CAA2RiuSnH_2xc+-W6EnFEG00XjS-dszMq61JEv=
RjcGS31CBw=3Dg@mail.gmail.com/
>
> I used this script to test the regression in a clean v6.12 tree with
> commit 81c734dae203 ("ip6_tunnel: use skb_vlan_inet_prepare() in
> __ip6_tnl_rcv()") applied on top:
>
>
> # ../ip6_tunnel.sh
> PING 172.0.0.2 (172.0.0.2) 56(84) bytes of data.
>
> --- 172.0.0.2 ping statistics ---
> 1 packets transmitted, 0 received, 100% packet loss, time 0ms
>
>
> dropwatch shows:
>
> 1 drops at __ip6_tnl_rcv+74 (0xffffffffc05c7064) [software]
>
>
> Now, when also applying commit 4b406f814817 ("net: tunnel: make
> skb_vlan_inet_prepare() return drop reasons") on top of that, the issue

oops, that would be 9990ddf47d41 ("net: tunnel: make skb_vlan_inet_prepare(=
) return drop reasons")

> goes away. Is there a way to trigger stable to pick this up?
>
>> ---
>>  tools/testing/selftests/net/Makefile      |  1 +
>>  tools/testing/selftests/net/ip6_tunnel.sh | 41 +++++++++++++++++++++++
>>  2 files changed, 42 insertions(+)
>>  create mode 100644 tools/testing/selftests/net/ip6_tunnel.sh
>>
>> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selfte=
sts/net/Makefile
>> index 45c4ea381bc36..5037a344ad826 100644
>> --- a/tools/testing/selftests/net/Makefile
>> +++ b/tools/testing/selftests/net/Makefile
>> @@ -43,6 +43,7 @@ TEST_PROGS :=3D \
>>  	io_uring_zerocopy_tx.sh \
>>  	ioam6.sh \
>>  	ip6_gre_headroom.sh \
>> +	ip6_tunnel.sh \
>>  	ip_defrag.sh \
>>  	ip_local_port_range.sh \
>>  	ipv6_flowlabel.sh \
>> diff --git a/tools/testing/selftests/net/ip6_tunnel.sh b/tools/testing/s=
elftests/net/ip6_tunnel.sh
>> new file mode 100644
>> index 0000000000000..366f4c06cd6a3
>> --- /dev/null
>> +++ b/tools/testing/selftests/net/ip6_tunnel.sh
>> @@ -0,0 +1,41 @@
>> +#!/bin/bash
>> +# Test that IPv4-over-IPv6 tunneling works.
>> +
>> +set -e
>> +
>> +setup_prepare() {
>> +  ip link add transport1 type veth peer name transport2
>> +
>> +  ip netns add ns1
>> +  ip link set transport1 netns ns1
>> +  ip netns exec ns1 bash <<EOF
>> +  set -e
>> +  ip address add 2001:db8::1/64 dev transport1 nodad
>> +  ip link set transport1 up
>> +  ip link add link transport1 name tunnel1 type ip6tnl mode ipip6 local=
 2001:db8::1 remote 2001:db8::2
>> +  ip address add 172.0.0.1/32 peer 172.0.0.2/32 dev tunnel1
>> +  ip link set tunnel1 up
>> +EOF
>> +
>> +  ip netns add ns2
>> +  ip link set transport2 netns ns2
>> +  ip netns exec ns2 bash <<EOF
>> +  set -e
>> +  ip address add 2001:db8::2/64 dev transport2 nodad
>> +  ip link set transport2 up
>> +  ip link add link transport2 name tunnel2 type ip6tnl mode ipip6 local=
 2001:db8::2 remote 2001:db8::1
>> +  ip address add 172.0.0.2/32 peer 172.0.0.1/32 dev tunnel2
>> +  ip link set tunnel2 up
>> +EOF
>> +}
>> +
>> +cleanup() {
>> +  ip netns delete ns1
>> +  ip netns delete ns2
>> +  # in case the namespaces haven't been set up yet
>> +  ip link delete transport1
>> +}
>> +
>> +trap cleanup EXIT
>> +setup_prepare
>> +ip netns exec ns1 ping -W1 -c1 172.0.0.2


