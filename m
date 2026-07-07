Return-Path: <netdev+bounces-305532-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id drkrLxQsTWp4wAEAu9opvQ
	(envelope-from <netdev+bounces-305532-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 18:40:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAF571DF14
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 18:40:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.im header.s=fm2 header.b=pDPAqwtD;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="C bnGgVj";
	dmarc=pass (policy=none) header.from=fastmail.im;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305532-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305532-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 660FE300186C
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 16:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D333E51D7;
	Tue,  7 Jul 2026 16:40:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1373D31F9B4
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 16:40:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783442445; cv=none; b=QBlliLy/WueZcUNzoni99OKNQ1olyGJa9cgcdlCjaFGcJHR0IQkvpa3Rt30HBmDOCEKc3rdbXanB+gsiblA5zJoCfyt6IKoz2XXBTnY8fGWKjmqacYavcKYAKwDmhv7LABz47GMwboC2sSZ/Wa+mDmXvpkM2fg2HKcZ9ozYql+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783442445; c=relaxed/simple;
	bh=qSoRgQctDx4m8RUSOLYWn50gMY4mRXOgtSDylPAWWPw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=A0sOsDabvlGPW04eSCRqZ9jl6RaKbAv+j9k4uwrrI6m4DazZCjSCVl78BPZQ5mi/xFBobmQbRstMAkNWJQ3ZerrgyPIleBLvBzyp+TCO3oqui7EHxIv18Oy5arqHSFJPBBvSFbJ5ZeQggKf3MhvjjwnYd7CcDBwUqXXpFfU7dig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=pDPAqwtD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CbnGgVjJ; arc=none smtp.client-ip=202.12.124.155
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DB7357A0148;
	Tue,  7 Jul 2026 12:40:41 -0400 (EDT)
Received: from phl-imap-03 ([10.202.2.93])
  by phl-compute-10.internal (MEProxy); Tue, 07 Jul 2026 12:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783442441;
	 x=1783528841; bh=OX7He/pSjbq6EMQH1nIkHCLFKykU3KHafzjh7jPyBzI=; b=
	pDPAqwtDMi73+tJ19NH3BnBSHEwR5OB3s4JAg35pmWfVBcJxxfZopNwfyl9iaWbm
	7Lcn/lzRAxYPHOFTPJNrs8JWBdRyF8y2s77NWo1jUoZ8rVrNtD/h7c7pW6IyHvZN
	hXgYoacXlr5FGvN8qbvM45e/qsNrn7F+vA5p4yZ/HEMUN64+AOru4ZB4rynupSUs
	yeI0icT4pNOIhb8PIYQzjiSaVOw2lor/buSLTStw2AA4F4cSSoWM5KAiNvHwfKRD
	oX7w0EPXWcMW7QxSy6gbKGClxCH8rgUEPy3W3L29wGFpUjQNTmRVrqsWJ8sJbNM6
	N57448vpbMwGxh7ThKNTzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783442441; x=
	1783528841; bh=OX7He/pSjbq6EMQH1nIkHCLFKykU3KHafzjh7jPyBzI=; b=C
	bnGgVjJvf5+4ViMOIPGHVWkILENHPjvwlXVD6AGWrTL9qFKsfmAz1tYvYKHuXVUB
	7lB+k0/ZVvSZH5r1lyEMasyzgZaaeTTQXblJs5Yzy5XNQ1L7RQkO5xD5k0V49PYI
	m6loDbZ5NTX4D5UF5Lk2zf8Glw8RxY6+Rx4H42G7VGQ7QivMyrj2MgwEvaHfVwB1
	6jc5n6QWJiI+H72yzqA1RbrpkMmgrvAAnrhgo2g1WKH7OILhOETJa4yXEeMghCrZ
	WcCiM/YM1c8EO/hnrih7le+phzvQRTjm7UTd2z5hhLojQC37YbqhFIxtYOoFR9SM
	qLZh5NMDGledsAF7jDN2A==
X-ME-Sender: <xms:CCxNaimT2EsgfQIExlSUIw4XcAm-_GDOFQ-g0YQvvM0gIwtM4Chzgg>
    <xme:CCxNakpSyPLOEv9w-NZjkbBxju7pQChnZFFTBgAmgMHSVW602hQXungWKhT0hsGvE
    YpdqcMN4H7KUkzVuTbnMAlEXCsrYci-RV2fV-E7f66zf8PdTEBvH9M>
X-ME-Proxy-Cause: dmFkZTEwTShYCJN1jHlqDKOqEueJrF47203KXZqPgGZtcXHJU4inJPzfAmj75n8X2dfOBb
    Ks00We8j/XwJyChmwbDkYBrFW1gzhN2aebCG3SQbSoQ0V9H2Lyqquyk47KmpS8GUFz67gF
    Mogp1dnAjzUMEj6tVOKUj1V35x4dJ4SP6KoSYZXoEe0YlZoqmplRx6yPLqd/8duMckp2K2
    qvpJ+UjKnFObqmWVqUIbkp3V49R8DPbJ/g035GuhZbm5xG0QK91+QDB/rk6m+uo8rlsrhi
    hebuokTC7ACSUgcIYG0G2sTAO/eY6XoSJPfddcM62u9xGFXCQJJxWLGf7aH4uh7eRz8Hrr
    0RmMBcxF9Q8YMPdHfPCHu94AMDW67Uv23mn4svZFt/FUeY/3GKX24ObS8lxCVL0nuAxrsA
    WCUKm+YnRPvKZoE7Wsf6BvTjzDxRI0Kkr1A4INCIGUOYibw6Jum5MvyXa0gLYBZ1Uv1Jbl
    Jap2HilN24tvS03UOSV1QP6/gdU++cs/0mfBiF+F9Ld+S2a6ialf0S+IGHHZdgtgFKeWdv
    8f2MfLVwoMFzC4+Mf1nQNTu3ReLeByVmxwO+Dfx+8R0nCISlYBDdGqoWThyNbYV4xcbS5d
    wlfb5rrz8Uok+vMVHvf7zjrL5nt7EDByzy8JtUCjLvkWYh/37D956buEpGFw
X-ME-Proxy: <xmx:CCxNaixG-GqdyPFBkJ-P-IU8e1q63LdKbvnSATwFLj8KhMoQXyna4Q>
    <xmx:CCxNaqMnlrwnEWUT6e21ZJGpA6esCzAgiYb-A7MTw9SOTlacjyiKtg>
    <xmx:CCxNaqfusNo4iMNSTh1s7krX1VOe51C83OG86yjvTwLqzxMeexov2w>
    <xmx:CCxNau5_WQpcIAAFSVBGi7dDMP7gocDWBoYfXXXONnkVM6PWlOZoaw>
    <xmx:CSxNao-N_yEYt7r8o9cNQvHexvuRQh9n790pP54SBQQfsLDMPI6ByYs5>
Feedback-ID: i559e4809:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6B55218E0071; Tue,  7 Jul 2026 12:40:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AN1US38Z7o3V
Date: Tue, 07 Jul 2026 19:40:19 +0300
From: "Alice Mikityanska" <alice.kernel@fastmail.im>
To: "Matthieu Baerts" <matttbe@kernel.org>
Cc: "Shuah Khan" <shuah@kernel.org>,
 "Stanislav Fomichev" <stfomichev@gmail.com>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>, "Simon Horman" <horms@kernel.org>,
 "Florian Westphal" <fw@strlen.de>, netdev@vger.kernel.org,
 "Alice Mikityanska" <alice@isovalent.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Xin Long" <lucien.xin@gmail.com>,
 "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
 "Willem de Bruijn" <willemb@google.com>, "David Ahern" <dsahern@kernel.org>,
 "Nikolay Aleksandrov" <razor@blackwall.org>
Message-Id: <de439dc5-460b-4e0c-b242-7c31a24bd84a@app.fastmail.com>
In-Reply-To: <f9aac06f-25ca-40fb-9e47-d12398262c61@kernel.org>
References: <20260706181941.385672-1-alice.kernel@fastmail.im>
 <20260706181941.385672-10-alice.kernel@fastmail.im>
 <80222d3f-e6cf-408b-b42f-0a2a6afce297@redhat.com>
 <48f70526-e4f1-472c-86f6-72c105853a21@app.fastmail.com>
 <f9aac06f-25ca-40fb-9e47-d12398262c61@kernel.org>
Subject: Re: [PATCH net-next v8 9/9] selftests: net: Add a test for BIG TCP in UDP
 tunnels
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:matttbe@kernel.org,m:shuah@kernel.org,m:stfomichev@gmail.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:fw@strlen.de,m:netdev@vger.kernel.org,m:alice@isovalent.com,m:pabeni@redhat.com,m:daniel@iogearbox.net,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:lucien.xin@gmail.com,m:willemdebruijn.kernel@gmail.com,m:willemb@google.com,m:dsahern@kernel.org,m:razor@blackwall.org,m:andrew@lunn.ch,m:lucienxin@gmail.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-305532-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com,redhat.com,iogearbox.net,davemloft.net,google.com,blackwall.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:url,messagingengine.com:dkim,fastmail.im:from_mime,fastmail.im:dkim,big_tcp.sh:url,mankier.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5BAF571DF14

On Tue, Jul 7, 2026, at 17:12, Matthieu Baerts wrote:
> Hi Alice,
>
> On 07/07/2026 10:40, Alice Mikityanska wrote:
>> On Tue, Jul 7, 2026, at 11:06, Paolo Abeni wrote:
>>> On 7/6/26 8:19 PM, Alice Mikityanska wrote:
>
> (...)
>
>>>> +
>>>> +cleanup_tunnel() {
>>>> +	ip -netns "$CLIENT_NS" link del tun0
>>>> +	ip -netns "$SERVER_NS" link del tun1
>>>> +}
>>>> +
>>>> +cleanup() {
>>>> +	ip netns pids "$SERVER_NS" | xargs -r kill
>>>> +	ip netns pids "$CLIENT_NS" | xargs -r kill
>>>> +	ip netns del "$SERVER_NS"
>>>> +	ip netns del "$CLIENT_NS"
>>>> +	rm -rf "$WORKDIR"
>>>> +}
>>>> +
>>>> +do_test() {
>>>> +	# When tx csum offload is off, software GSO is performed before passing the
>>>> +	# packet to veth. Check BIG TCP packets inside the VXLAN tunnel to verify
>>>> +	# the software checksum path: if the checksum code is broken, these packets
>>>> +	# will be dropped.
>>>> +	if [ "$2" = on ]; then
>>>> +		CAPTURE_IFACE='link'
>>>> +	else
>>>> +		CAPTURE_IFACE='tun'
>>>> +	fi
>>>> +
>>>> +	ip netns exec "$SERVER_NS" tcpdump -nn -s 256 -i "${CAPTURE_IFACE}1" greater 65536 -w "$WORKDIR/server.pcap" 2> /dev/null &
>>>> +	TCPDUMP_SERVER_PID="$!"
>>>> +	ip netns exec "$CLIENT_NS" tcpdump -nn -s 256 -i "${CAPTURE_IFACE}0" greater 65536 -w "$WORKDIR/client.pcap" 2> /dev/null &
>>>> +	TCPDUMP_CLIENT_PID="$!"
>>>> +
>>>> +	# This filter doesn't capture all possible variants of SACK, but it's aimed
>>>> +	# at the typical one where SACK follows after [nop, nop, timestamp, nop,
>>>> +	# nop] (14 bytes after the 20-byte TCP header). IPv6 needs a separate match,
>>>> +	# because man tcpdump says:
>>>> +	# > Arithmetic expression against transport layer headers, like tcp[0], does
>>>> +	# > not work against IPv6 packets.  It only looks at IPv4 packets.
>>>> +	ip netns exec "$SERVER_NS" tcpdump -nn -s 256 -i "tun1" '(tcp[tcpflags] & (tcp-syn|tcp-ack) = tcp-ack and tcp[34:2] & 0xffc3 = 0x0502) or (ip6[6] = 0x06 and ip6[53] & 0x12 = 0x10 and ip6[74:2] & 0xffc3 = 0x0502)' -w "$WORKDIR/sack.pcap" 2> /dev/null &
>
> The tcpdump commands might need to be used with ...
>
>   --immediate-mode --packet-buffered
>
> ... but that's maybe not needed, see below.

Thanks! I was aware of these options, but I was afraid they'd slow down
tcpdump and let it drop some packets. Well, now that I actually tested
them, it seems that my concern was not valid. I'll add these and drop
the second sleep (if I stay with tcpdump).

>>>> +	TCPDUMP_SACK_PID="$!"
>>>> +
>>>> +	if [ "$1" = 4 ]; then
>>>> +		SERVER_IP="$SERVER_IP4_TUN"
>>>> +		echo "Running IPv4 traffic in the tunnel"
>>>> +	else
>>>> +		SERVER_IP="$SERVER_IP6_TUN"
>>>> +		echo "Running IPv6 traffic in the tunnel"
>>>> +	fi
>>>> +
>>>> +	sleep 1 # Give tcpdump a second to spin up.
>
> This is possibly not needed, see below.
>
>>>> +	ip netns exec "$CLIENT_NS" netperf -t TCP_STREAM -l 5 -H "$SERVER_IP" -- \
>>>> +		-m 80000 > /dev/null
>>>> +	sleep 1 # Give tcpdump a second to process buffered packets.
>>>> +	kill "$TCPDUMP_SERVER_PID" "$TCPDUMP_CLIENT_PID" "$TCPDUMP_SACK_PID"
>>>> +	wait "$TCPDUMP_SERVER_PID" "$TCPDUMP_CLIENT_PID" "$TCPDUMP_SACK_PID"
>>>> +	PACKETS_SERVER=$(tcpdump --count -r "$WORKDIR/server.pcap" 2> /dev/null | cut -d ' ' -f 1)
>>>> +	PACKETS_CLIENT=$(tcpdump --count -r "$WORKDIR/client.pcap" 2> /dev/null | cut -d ' ' -f 1)
>>>> +	PACKETS_SACK=$(tcpdump --count -r "$WORKDIR/sack.pcap" 2> /dev/null | cut -d ' ' -f 1)
>>>> +
>>>> +	echo "Captured BIG TCP RX packets: $PACKETS_SERVER"
>>>> +	echo "Captured BIG TCP TX packets: $PACKETS_CLIENT"
>>>> +	echo "Captured TCP SACK packets: $PACKETS_SACK"
>>>> +	[ "$PACKETS_SERVER" -gt "$PACKETS_THRESHOLD" ] || return 1
>>>> +	[ "$PACKETS_CLIENT" -gt "$PACKETS_THRESHOLD" ] || return 1
>>>> +	[ "$PACKETS_SACK" -lt "$(( PACKETS_CLIENT / 2 ))" ] || return 1
>>>
>>> KCI fails here, see:
>>>
>>> https://netdev-ctrl.bots.linux.dev/logs/vmksft/net/results/722863/156-big-tcp-tunnels-sh/stdout
>>>
>>> possibly the above parsing is a bit fragile/tcpdump version's dependent?!?
>> 
>> TL/DR: I've seen this when I ran out of space in /tmp before adding -s 256.
>> 
>> Hmm, the changes I made in this iteration were aimed at addressing version-
>> dependent behavior of tcpdump... I used to count the lines of its
>> output. Newer tcpdump prints two lines per encapsulated packet. Older
>> tcpdump can't parse BIG TCP in this test and prints one line per packet.
>> To make it more robust, I decided to store the pcap and count the
>> packets there (--count doesn't work with live capture when tcpdump is
>> interrupted). The pitfall is that now it takes a few hundred megabytes
>> in /tmp to store those pcaps.
>
> Wow :)
>
> If you need to keep tcpdump -- see below -- you can probably reduce even
> more the packet size (-s 256), I don't know what's the minimum. And
> purge the workdir in cleanup_tunnel().

Apparently, the overflow in /tmp happens during one single test, because
the files are not accumulated: the next test overwrites the same files.

>> Now, seeing empty stdout from tcpdump could be if the pcap file is empty
>> (doesn't contain the pcap header), because we ran out of space in /tmp
>> (first two tcpdumps took all space, the third didn't write the header -
>> I observed this behavior before I added -s 256). We don't see the
>> corresponding error messages, because tcpdump starts with 2> /dev/null
>> (otherwise it floods the screen with statistics). Could this be the
>> reason? How much space is allocated for /tmp in the CI runners?
>> 
>> I can probably address it by limiting the overall number of captured
>> packets with -c, but then I won't be able to compare $PACKETS_SACK
>> relative to $PACKETS_CLIENT.
>
> If you only need to count some packets matching a filter, what about
> using Netfilter rules with a counter, instead of using pcap files?
>
> You can have counters not attached to rules altering packets:
>
>   https://wiki.nftables.org/wiki-nftables/index.php/Counters

Thanks for the suggestion! Yes, I agree, I think, at this point it will
be cleaner to use netfilter counters. By the way, the other test
big_tcp.sh uses an iptables rule, that comes with a counter by default,
to count BIG TCP packets.

> It might even be easier to match the SACK packets, with the 'tcp option
> sack' filter from nft [1].

Great, it will match all sorts of SACK packets, not only the specific
one that my filter does.

Thank you, I'll explore this direction, it looks more promising.

> And for the size, I guess you can use "meta
> length > 65536" [2], or checking other fields from IP/TCP headers.
>
> If you want to keep your cBPF filter, you can also use nfbpf_compile for
> the translation, and use that with 'iptables -m bpf --bytecode <...>',
> but it might not be needed.
>
> [1] 
> https://www.mankier.com/8/nft#Payload_Expressions-Extension_Header_Expressions
> [2] https://www.mankier.com/8/nft#Primary_Expressions-Meta_Expressions
>
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.

