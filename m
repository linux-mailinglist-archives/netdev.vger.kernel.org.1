Return-Path: <netdev+bounces-305334-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K6ZJNHy8TGrGowEAu9opvQ
	(envelope-from <netdev+bounces-305334-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:44:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE52071948E
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:44:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.im header.s=fm2 header.b=X1kXzO8U;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="n ky4sdW";
	dmarc=pass (policy=none) header.from=fastmail.im;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305334-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305334-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE66A303B4EC
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 08:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8019D3382F9;
	Tue,  7 Jul 2026 08:40:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F88623D283
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 08:40:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783413628; cv=none; b=U9KqXkpSr7A7lXYpCC0c7sKnTsL1FhW2Eh1UwODHqTkMWgKs/gOd2o5T1nVDASazpt9mjan7FDwJmsMeROzG+5Jb7c028ovWppaWN28Bqbh59LCa5s9nzeX/5UvQrWqV7J0Zg0jPXi9BwHxnk4HzzX9MViwTT0hyj60xrlu5aAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783413628; c=relaxed/simple;
	bh=86vpXdxznYjfDsTHql9lzneqRJTBAmPckYWSPmRzHxQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BR0hcw4+SmlJvqeLhSmZMI1DL/o561EkfdqKyKndJaNgWukbqZuhF1WHXbGfN5Y3q0dhh8q5D7yQxAzcktGbQLxow4SbvkmVMZAfsvKhkk6TnJ64N3VHmsgGe2TcAtxZq17MCD67qGrnY/X5e9ZBQRdnWsFJUyV574M7csr36Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=X1kXzO8U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nky4sdWj; arc=none smtp.client-ip=202.12.124.154
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 015947A01C0;
	Tue,  7 Jul 2026 04:40:23 -0400 (EDT)
Received: from phl-imap-03 ([10.202.2.93])
  by phl-compute-10.internal (MEProxy); Tue, 07 Jul 2026 04:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783413623;
	 x=1783500023; bh=rg6cpnY+iUByQKP6g6ELKDuzd8Mzh6QRqpDUyCW0BNY=; b=
	X1kXzO8U34k/TCCMq0bLNFD2C21vqmCJYgxaE5jRJndMU9RZYX5vJNPY2u1NHoap
	ob0DDNGyjpyT+h9S8jPNCW/hfgKTkkTYo4vj6WxEITbjzYMcyjJPhQ6eFn4qZHJY
	a1A9c4wVWV6Hs4sIortUHCWvVzbwZ3DdVvMtrDbu/ndaBddkjkeFQbS9DGBe0Whz
	ZnrLMKyMqF1dGXBsS20cdzAJZ99zTrypfD9uVvdOQ+BuduEZPvrSembuf54ds+XT
	75n7undH3XkpQ991B1xt/sMiVG1mSPPG7nAef6+fS+FlWRnQClyshf82TL7BsjNf
	ATlaUOaWrPrjIH/jCMegTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783413623; x=
	1783500023; bh=rg6cpnY+iUByQKP6g6ELKDuzd8Mzh6QRqpDUyCW0BNY=; b=n
	ky4sdWju/lz/O1Syq2I9WsCyOxTU+FAzh5ZPrTsbAM8WvYBvoXyBRI7X8e/Edmk2
	Oc/qGY1QnkaztfATvayVtOl9DQ4ya0KcvndHprDKG5szVzHg5uhNG/KNZjFCW6p+
	8TuTPYTfOzL0IVRx/q8XKiJgG4rZciPqN9DDWciaiNMWknGvIg5xeJAvFDFu3Mkt
	4FIC6sh6kTytG3827XJdCkh8PceUeWTOFykn+yLTJllTgRij1GNRDcsSWNRhkv/6
	DC+H0yc9J56nBEQfzB1mYO22xWSvIhEeaN58SWF4Ve9FudYCWrj/S8GP2TDEFy0r
	Jw0hvQ0v9B6DxPJGNWnBA==
X-ME-Sender: <xms:drtMamXwu8-xd33Qd9R58omDF2A0WoypxmqRQt04mZStZ93I8zG0oA>
    <xme:drtMatbsqlsyQIWDiVCgE9Cz14vaXyjEFEkZEn-R2zUmT4IOm_78dy0u9D5aC0UzW
    F9d1ucCxEKxBFzXhrDkyxH2ELO97BGDznypVkrYyLC0Gyzb_aC2yGLk>
X-ME-Proxy-Cause: dmFkZTEIpu81W02IfGioN3vlq4s0+KL9ok4qBYueUoqt7yIBoOmlmvy8sZpSCO0gT95fNO
    cxUvN9U3pc7pOuOw4EDjcC9huqotBvMLO484hKdRLAouwOKj4Eu1x2PZ+Y0jjIV36xhhzt
    fdCTVxiRkssqiLMQYUgMGKOcxB5S3Q3+6YQIFa7Kf5vmAR4HEu3WTz2qQcEGOUc/OseoRT
    4/SF0WwTvrphtSKKRZ+44L+yZtvB3zqc/yl9djP4aVzaOn+OdXjItROEZn1XB1w5K86PdF
    TnV6E30LT75qvlAX17J96QM2DInY0LGPNIRb0XGhCo2fwY1lpND2JcwJrlH0D6+2L6YmZB
    mUTTj8Kb6uF1xG2tErluAsWcVxl6Lw/G+AVDI5JCEBI14QFLnGVFt0WzgbL3HPTWT8Nm7p
    tU1Jj/pHSUso0QSWUb8YbhT8ZjoIp1cvbN+SHqwj51pciYrgfTBKrx+K+uXjkB/3QFFVYb
    nl6TUxAfbGBm34XdSqXfpyrPi6FDBkbLZs0xgF6/+lH6TWDErblhTDLe8+LFruGewlWq9/
    mYwDMcA3GL9shZpq6Rjo8wQ1pRHJdmCItdBQJfKq3FrnvJpjhHrGZKTQZuUPEJIjTgKrYp
    4WjnQYw15EIL/9pHyaNaiJEwPhASsDMLYMbHrPR/MtPYA5iFRaWj3xBRXh2A
X-ME-Proxy: <xmx:drtMagbLdAPlNYdLKbZ_m60POtkDQMfGc9XhzJxaseztbLzgMapYdQ>
    <xmx:drtMakwhEJaoVPIjy_riV9uul44UbGSUUtwiU7TvW9YzOx23fDDhdQ>
    <xmx:drtMajez18wzz--0OnosWFOHH8x9SVO0AO56klnc8G4GIFDErhoBeA>
    <xmx:drtMaqI2xyfSmGx6t8jvKNrZFjc55ytWaKezw_YQaM2Dl063nz6dLQ>
    <xmx:d7tMal_-v3-QvoLJXNA4xv9AkiimZYA5ZCgomMIVmHMWSvla2TSCVuCz>
Feedback-ID: i559e4809:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8EB2318E0071; Tue,  7 Jul 2026 04:40:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 07 Jul 2026 11:40:02 +0300
From: "Alice Mikityanska" <alice.kernel@fastmail.im>
To: "Paolo Abeni" <pabeni@redhat.com>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Xin Long" <lucien.xin@gmail.com>,
 "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
 "Willem de Bruijn" <willemb@google.com>, "David Ahern" <dsahern@kernel.org>,
 "Nikolay Aleksandrov" <razor@blackwall.org>
Cc: "Shuah Khan" <shuah@kernel.org>,
 "Stanislav Fomichev" <stfomichev@gmail.com>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>, "Simon Horman" <horms@kernel.org>,
 "Florian Westphal" <fw@strlen.de>, netdev@vger.kernel.org,
 "Alice Mikityanska" <alice@isovalent.com>
Message-Id: <48f70526-e4f1-472c-86f6-72c105853a21@app.fastmail.com>
In-Reply-To: <80222d3f-e6cf-408b-b42f-0a2a6afce297@redhat.com>
References: <20260706181941.385672-1-alice.kernel@fastmail.im>
 <20260706181941.385672-10-alice.kernel@fastmail.im>
 <80222d3f-e6cf-408b-b42f-0a2a6afce297@redhat.com>
Subject: Re: [PATCH net-next v8 9/9] selftests: net: Add a test for BIG TCP in UDP
 tunnels
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:daniel@iogearbox.net,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:lucien.xin@gmail.com,m:willemdebruijn.kernel@gmail.com,m:willemb@google.com,m:dsahern@kernel.org,m:razor@blackwall.org,m:shuah@kernel.org,m:stfomichev@gmail.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:fw@strlen.de,m:netdev@vger.kernel.org,m:alice@isovalent.com,m:lucienxin@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[fastmail.im];
	FREEMAIL_TO(0.00)[redhat.com,iogearbox.net,davemloft.net,google.com,kernel.org,gmail.com,blackwall.org];
	TAGGED_FROM(0.00)[bounces-305334-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CE52071948E

On Tue, Jul 7, 2026, at 11:06, Paolo Abeni wrote:
> On 7/6/26 8:19 PM, Alice Mikityanska wrote:
>> From: Alice Mikityanska <alice@isovalent.com>
>> 
>> The test sets up VXLAN and GENEVE tunnels over IPv4 and IPv6 and runs
>> IPv4 and IPv6 traffic through them with BIG TCP enabled. It checks that
>> a non-negligible amount of big aggregated packets are seen in tcpdump.
>> 
>> Check the number of packets on both TX and RX sides to verify that GSO
>> packets are valid and not dropped. Capture on the lower netdev (veth),
>> when checksum offload is on, to verify that encapsulated BIG TCP packets
>> can get to their destination. In the test with TX checksum offload off,
>> software GSO splits aggregated VXLAN packets before passing them to
>> veth, so capture inside the tunnel instead to check that the big packets
>> are not dropped.
>> 
>> Check that the amount of SACKs is negligible. On unsupported kernels,
>> some amount of broken GSO packets bigger than 65536 bytes can be
>> produced in VXLAN tunnels, but they don't reach the destination. Seeing
>> TCP SACKs is a sign that such packets could have been dropped (in such
>> cases, the amount of SACKs is a few times bigger than the number of
>> attempts to send BIG TCP packets).
>> 
>> Signed-off-by: Alice Mikityanska <alice@isovalent.com>
>> ---
>>  tools/testing/selftests/net/Makefile          |   1 +
>>  .../testing/selftests/net/big_tcp_tunnels.sh  | 183 ++++++++++++++++++
>>  2 files changed, 184 insertions(+)
>>  create mode 100755 tools/testing/selftests/net/big_tcp_tunnels.sh
>> 
>> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
>> index 708d960ae07d..4cb0a0bc1eea 100644
>> --- a/tools/testing/selftests/net/Makefile
>> +++ b/tools/testing/selftests/net/Makefile
>> @@ -13,6 +13,7 @@ TEST_PROGS := \
>>  	arp_ndisc_untracked_subnets.sh \
>>  	bareudp.sh \
>>  	big_tcp.sh \
>> +	big_tcp_tunnels.sh \
>>  	bind_bhash.sh \
>>  	bpf_offload.py \
>>  	bridge_stp_mode.sh \
>> diff --git a/tools/testing/selftests/net/big_tcp_tunnels.sh b/tools/testing/selftests/net/big_tcp_tunnels.sh
>> new file mode 100755
>> index 000000000000..128a710e74ad
>> --- /dev/null
>> +++ b/tools/testing/selftests/net/big_tcp_tunnels.sh
>> @@ -0,0 +1,183 @@
>> +#!/usr/bin/env bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# Testing for IPv4 and IPv6 BIG TCP over VXLAN and GENEVE tunnels.
>> +
>> +SERVER_NS=$(mktemp -u server-XXXXXXXX)
>> +SERVER_IP4="192.168.1.1"
>> +SERVER_IP6="2001:db8::1:1"
>> +SERVER_IP4_TUN="192.168.2.1"
>> +SERVER_IP6_TUN="2001:db8::2:1"
>> +
>> +CLIENT_NS=$(mktemp -u client-XXXXXXXX)
>> +CLIENT_IP4="192.168.1.2"
>> +CLIENT_IP6="2001:db8::1:2"
>> +CLIENT_IP4_TUN="192.168.2.2"
>> +CLIENT_IP6_TUN="2001:db8::2:2"
>> +
>> +: "${PACKETS_THRESHOLD:=1000}"
>> +
>> +# Kselftest framework requirement - SKIP code is 4.
>> +ksft_skip=4
>> +
>> +setup() {
>> +	ip netns add "$SERVER_NS"
>> +	ip netns add "$CLIENT_NS"
>> +	ip -netns "$SERVER_NS" link add link1 type veth peer name link0 netns "$CLIENT_NS"
>> +
>> +	ip -netns "$CLIENT_NS" link set link0 up
>> +	ip -netns "$CLIENT_NS" addr replace "$CLIENT_IP4/24" dev link0
>> +	ip -netns "$CLIENT_NS" addr replace "$CLIENT_IP6/112" dev link0 nodad
>> +	ip -netns "$CLIENT_NS" link set link0 \
>> +		gso_max_size 196608 gso_ipv4_max_size 196608 \
>> +		gro_max_size 196608 gro_ipv4_max_size 196608
>> +	ip -netns "$SERVER_NS" link set link1 up
>> +	ip -netns "$SERVER_NS" addr replace "$SERVER_IP4/24" dev link1
>> +	ip -netns "$SERVER_NS" addr replace "$SERVER_IP6/112" dev link1 nodad
>> +	ip -netns "$SERVER_NS" link set link1 \
>> +		gso_max_size 196608 gso_ipv4_max_size 196608 \
>> +		gro_max_size 196608 gro_ipv4_max_size 196608
>> +
>> +	ip netns exec "$SERVER_NS" netserver >/dev/null
>> +}
>> +
>> +setup_tunnel() {
>> +	if [ "$2" = 4 ]; then
>> +		SERVER_IP="$SERVER_IP4"
>> +		CLIENT_IP="$CLIENT_IP4"
>> +		echo "Setting up ${1^^} over IPv4, veth tx csum offload $3"
>> +	else
>> +		SERVER_IP="$SERVER_IP6"
>> +		CLIENT_IP="$CLIENT_IP6"
>> +		echo "Setting up ${1^^} over IPv6, veth tx csum offload $3"
>> +	fi
>> +
>> +	if [ "$1" = vxlan ]; then
>> +		ip -netns "$CLIENT_NS" link add tun0 type vxlan \
>> +			id 5001 remote "$SERVER_IP" local "$CLIENT_IP" dev link0 dstport 4789
>> +	else
>> +		ip -netns "$CLIENT_NS" link add tun0 type geneve \
>> +			id 5001 remote "$SERVER_IP"
>> +	fi
>> +	ip -netns "$CLIENT_NS" link set tun0 up
>> +	ip -netns "$CLIENT_NS" addr replace "$CLIENT_IP4_TUN/24" dev tun0
>> +	ip -netns "$CLIENT_NS" addr replace "$CLIENT_IP6_TUN/112" dev tun0 nodad
>> +	ip -netns "$CLIENT_NS" link set tun0 \
>> +		gso_max_size 196608 gso_ipv4_max_size 196608 \
>> +		gro_max_size 196608 gro_ipv4_max_size 196608
>> +	if [ "$1" = vxlan ]; then
>> +		ip -netns "$SERVER_NS" link add tun1 type vxlan \
>> +			id 5001 remote "$CLIENT_IP" local "$SERVER_IP" dev link1 dstport 4789
>> +	else
>> +		ip -netns "$SERVER_NS" link add tun1 type geneve \
>> +			id 5001 remote "$CLIENT_IP"
>> +	fi
>> +	ip -netns "$SERVER_NS" link set tun1 up
>> +	ip -netns "$SERVER_NS" addr replace "$SERVER_IP4_TUN/24" dev tun1
>> +	ip -netns "$SERVER_NS" addr replace "$SERVER_IP6_TUN/112" dev tun1 nodad
>> +	ip -netns "$SERVER_NS" link set tun1 \
>> +		gso_max_size 196608 gso_ipv4_max_size 196608 \
>> +		gro_max_size 196608 gro_ipv4_max_size 196608
>> +
>> +	ip netns exec "$CLIENT_NS" ethtool -K link0 tx-checksumming "$3" > /dev/null
>> +	ip netns exec "$SERVER_NS" ethtool -K link1 tx-checksumming "$3" > /dev/null
>> +}
>> +
>> +cleanup_tunnel() {
>> +	ip -netns "$CLIENT_NS" link del tun0
>> +	ip -netns "$SERVER_NS" link del tun1
>> +}
>> +
>> +cleanup() {
>> +	ip netns pids "$SERVER_NS" | xargs -r kill
>> +	ip netns pids "$CLIENT_NS" | xargs -r kill
>> +	ip netns del "$SERVER_NS"
>> +	ip netns del "$CLIENT_NS"
>> +	rm -rf "$WORKDIR"
>> +}
>> +
>> +do_test() {
>> +	# When tx csum offload is off, software GSO is performed before passing the
>> +	# packet to veth. Check BIG TCP packets inside the VXLAN tunnel to verify
>> +	# the software checksum path: if the checksum code is broken, these packets
>> +	# will be dropped.
>> +	if [ "$2" = on ]; then
>> +		CAPTURE_IFACE='link'
>> +	else
>> +		CAPTURE_IFACE='tun'
>> +	fi
>> +
>> +	ip netns exec "$SERVER_NS" tcpdump -nn -s 256 -i "${CAPTURE_IFACE}1" greater 65536 -w "$WORKDIR/server.pcap" 2> /dev/null &
>> +	TCPDUMP_SERVER_PID="$!"
>> +	ip netns exec "$CLIENT_NS" tcpdump -nn -s 256 -i "${CAPTURE_IFACE}0" greater 65536 -w "$WORKDIR/client.pcap" 2> /dev/null &
>> +	TCPDUMP_CLIENT_PID="$!"
>> +
>> +	# This filter doesn't capture all possible variants of SACK, but it's aimed
>> +	# at the typical one where SACK follows after [nop, nop, timestamp, nop,
>> +	# nop] (14 bytes after the 20-byte TCP header). IPv6 needs a separate match,
>> +	# because man tcpdump says:
>> +	# > Arithmetic expression against transport layer headers, like tcp[0], does
>> +	# > not work against IPv6 packets.  It only looks at IPv4 packets.
>> +	ip netns exec "$SERVER_NS" tcpdump -nn -s 256 -i "tun1" '(tcp[tcpflags] & (tcp-syn|tcp-ack) = tcp-ack and tcp[34:2] & 0xffc3 = 0x0502) or (ip6[6] = 0x06 and ip6[53] & 0x12 = 0x10 and ip6[74:2] & 0xffc3 = 0x0502)' -w "$WORKDIR/sack.pcap" 2> /dev/null &
>> +	TCPDUMP_SACK_PID="$!"
>> +
>> +	if [ "$1" = 4 ]; then
>> +		SERVER_IP="$SERVER_IP4_TUN"
>> +		echo "Running IPv4 traffic in the tunnel"
>> +	else
>> +		SERVER_IP="$SERVER_IP6_TUN"
>> +		echo "Running IPv6 traffic in the tunnel"
>> +	fi
>> +
>> +	sleep 1 # Give tcpdump a second to spin up.
>> +	ip netns exec "$CLIENT_NS" netperf -t TCP_STREAM -l 5 -H "$SERVER_IP" -- \
>> +		-m 80000 > /dev/null
>> +	sleep 1 # Give tcpdump a second to process buffered packets.
>> +	kill "$TCPDUMP_SERVER_PID" "$TCPDUMP_CLIENT_PID" "$TCPDUMP_SACK_PID"
>> +	wait "$TCPDUMP_SERVER_PID" "$TCPDUMP_CLIENT_PID" "$TCPDUMP_SACK_PID"
>> +	PACKETS_SERVER=$(tcpdump --count -r "$WORKDIR/server.pcap" 2> /dev/null | cut -d ' ' -f 1)
>> +	PACKETS_CLIENT=$(tcpdump --count -r "$WORKDIR/client.pcap" 2> /dev/null | cut -d ' ' -f 1)
>> +	PACKETS_SACK=$(tcpdump --count -r "$WORKDIR/sack.pcap" 2> /dev/null | cut -d ' ' -f 1)
>> +
>> +	echo "Captured BIG TCP RX packets: $PACKETS_SERVER"
>> +	echo "Captured BIG TCP TX packets: $PACKETS_CLIENT"
>> +	echo "Captured TCP SACK packets: $PACKETS_SACK"
>> +	[ "$PACKETS_SERVER" -gt "$PACKETS_THRESHOLD" ] || return 1
>> +	[ "$PACKETS_CLIENT" -gt "$PACKETS_THRESHOLD" ] || return 1
>> +	[ "$PACKETS_SACK" -lt "$(( PACKETS_CLIENT / 2 ))" ] || return 1
>
> KCI fails here, see:
>
> https://netdev-ctrl.bots.linux.dev/logs/vmksft/net/results/722863/156-big-tcp-tunnels-sh/stdout
>
> possibly the above parsing is a bit fragile/tcpdump version's dependent?!?

TL/DR: I've seen this when I ran out of space in /tmp before adding -s 256.

Hmm, the changes I made in this iteration were aimed at addressing version-
dependent behavior of tcpdump... I used to count the lines of its
output. Newer tcpdump prints two lines per encapsulated packet. Older
tcpdump can't parse BIG TCP in this test and prints one line per packet.
To make it more robust, I decided to store the pcap and count the
packets there (--count doesn't work with live capture when tcpdump is
interrupted). The pitfall is that now it takes a few hundred megabytes
in /tmp to store those pcaps.

Now, seeing empty stdout from tcpdump could be if the pcap file is empty
(doesn't contain the pcap header), because we ran out of space in /tmp
(first two tcpdumps took all space, the third didn't write the header -
I observed this behavior before I added -s 256). We don't see the
corresponding error messages, because tcpdump starts with 2> /dev/null
(otherwise it floods the screen with statistics). Could this be the
reason? How much space is allocated for /tmp in the CI runners?

I can probably address it by limiting the overall number of captured
packets with -c, but then I won't be able to compare $PACKETS_SACK
relative to $PACKETS_CLIENT.

> Note that KCI automatically drops from PW series with failing test.
>
> /P

