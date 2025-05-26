Return-Path: <netdev+bounces-193295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBBDAC3783
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 03:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF413A5406
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 01:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C191ABE67;
	Mon, 26 May 2025 01:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=uni-paderborn.de header.i=@uni-paderborn.de header.b="SzF+5mCn"
X-Original-To: netdev@vger.kernel.org
Received: from nylar.uni-paderborn.de (nylar.uni-paderborn.de [131.234.189.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5462DCBF0;
	Mon, 26 May 2025 01:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.234.189.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748221295; cv=none; b=YwEtcrHzZSeIA4HjmjMKlp/IgkYMIV+5YmHmceLDUEg6G4aSShcN8h1S+9TOp9dpomaXkdfw6czjDmMO129WqCA+jkrluqp7BtOgudUek5p5uCOOXf4a6avpMpL6NrMMYE78MXXS9raoUbl13sSEGMIXVGBO6oNOqTR3ahlwP5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748221295; c=relaxed/simple;
	bh=LRM7BnJhSjj/CeR9D5WBTiFvdWmDy4pJ2oIQNJPU+HQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=Bd0bxXa7GwqzclYZkNnzRbdHHWy0lf4KST0yowaUBfzj1TAmEbAskDWiDkQNDD30BjSM15Tbc287vcPTkyWqntwyg65rb1fATxdNFka2WsdnZeT5oFcwLEx+WUfUnR1cwc5nboVboqRkpy4CsBoIzi5ABzzObbFFEGUp0ag3iDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.uni-paderborn.de; spf=pass smtp.mailfrom=mail.uni-paderborn.de; dkim=pass (1024-bit key) header.d=uni-paderborn.de header.i=@uni-paderborn.de header.b=SzF+5mCn; arc=none smtp.client-ip=131.234.189.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.uni-paderborn.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:Content-Type:To:
	Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nupreO2nEhnaPNp/sEl4UWJ1Rv6ILga1aeXZ27Lpev4=; b=SzF+5mCn0cMJUWA7AFZfr/aWHO
	yFFD8Hjw68vYFm3hW67nixC65FIL21hJHRIUbeSPXzrzaaUz1u1efLPe9oh1fjClhFPtgnoCDtoUD
	LPJD0bUw8Z44M4Y2ka0Vc5isTR3QljWCD6iOqs1SwCPpAZEkhRHi6i6qJU8aSLEAfG7I=;
Message-ID: <1dbe0f24-1076-4e91-b2c2-765a0e28b017@mail.uni-paderborn.de>
Date: Mon, 26 May 2025 02:44:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: de-DE, en-GB-large
From: Dennis Baurichter <dennisba@mail.uni-paderborn.de>
Subject: Issue with delayed segments despite TCP_NODELAY
To: netdev@vger.kernel.org, netfilter@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IMT-Source: Extern
X-IMT-rspamd-score: -5
X-UPB-Report: Action: no action, RCVD_TLS_ALL(0.00), FROM_HAS_DN(0.00), FROM_EQ_ENVFROM(0.00), BAYES_HAM(-0.42), TO_DN_NONE(0.00), TO_MATCH_ENVRCPT_ALL(0.00), MIME_GOOD(-0.10), NEURAL_HAM(0.00), RCPT_COUNT_TWO(0.00), MID_RHS_MATCH_FROM(0.00), RCVD_VIA_SMTP_AUTH(0.00), ARC_NA(0.00), ASN(0.00), RCVD_COUNT_ONE(0.00), MIME_TRACE(0.00), Message-ID: 1dbe0f24-1076-4e91-b2c2-765a0e28b017@mail.uni-paderborn.de
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=dennisba,ou=People,o=upb,c=de

Hi,

I have a question on why the kernel stops sending further TCP segments 
after the handshake and first 2 (or 3) payload segments have been sent. 
This seems to happen if the round trip time is "too high" (e.g., over 
9ms or 15ms, depending on system). Remaining segments are (apparently) 
only sent after an ACK has been received, even though TCP_NODELAY is set 
on the socket.

This is happening on a range of different kernels, from Arch Linux' 
6.14.7 (which should be rather close to mainline) down to Ubuntu 22.04's 
5.15.0-134-generic (admittedly somewhat "farther away" from mainline). I 
can test on an actual mainline kernel, too, if that helps.
I will describe our (probably somewhat uncommon) setup below. If you 
need any further information, I'll be happy to provide it.

My colleague and I have the following setup:
- Userland application connects to a server via TCP/IPv4 (complete TCP 
handshake is performed).
- A nftables rule is added to intercept packets of this connection and 
put them into a netfilter queue.
- Userland application writes data into this TCP socket.
   - The data is written in up to 4 chunks, which are intended to end up 
in individual TCP segments.
   - The socket has TCP_NODELAY set.
   - sysctl net.ipv4.tcp_autocorking=0
- The above nftables rule is removed.
- Userland application (a different part of it) retrieves all packets 
from the netfilter queue.
   - Here it may occur that e.g. only 2 out of 4 segments can be retrieved.
   - Reading from the netfilter queue is attempted until 5 timeouts of 
20ms each occured. Even much higher timeout values don't change the 
results, so it's not a race condition.
- Userland application performs some modifications on the intercepted 
segments and eventually issues verdict NF_ACCEPT.

We checked (via strace) that all payload chunks are successfully written 
to the socket, (via nlmon kernel module) that there are no errors in the 
netlink communication, and (via nft monitor) that indeed no further 
segments traverse the netfilter pipeline before the first two payload 
segments are actually sent on the wire.
We dug through the entire list of TCP and IPv4 sysctls (testing several 
of them), tried loading and using different congestion algorithm 
modules, toggling TCP_NODELAY off and on between each write to the 
socket (to trigger an explicit flush), and other things, but to no avail.

Modifying our code, we can see that after NF_ACCEPT'ing the first 
segments, we can retrieve the remaining segments from netfilter queue.
In Wireshark we see that this seems to be triggered by the incoming ACK 
segment from the server.

Notably, we can intercept all segments at once when testing this on 
localhost or in a LAN network. However, on long-distance / 
higher-latency connections, we can only intercept 2 (sometimes 3) segments.

Testing on a LAN connection from an old laptop to a fast PC, we delayed 
packets on the latter one with variants of:
tc qdisc add dev eth0 root netem delay 15ms
We got the following mappings of delay / rtt to number of segments 
intercepted:
below 15ms -> all (up to 4) segments intercepted
15-16ms -> 2-3 segments
16-17ms -> 2 (sometimes 3) segments
over 20ms -> 2 segments (tested 20ms, 200ms, 500ms)
Testing in the other direction, from fast PC to old laptop (which now 
has the qdisc delay), we get similar results, just with lower round trip 
times (15ms becomes more like 8-9ms).

We would very much appreciate it if someone could help us on the 
following questions:
- Why are the remaining segments not send out immediately, despite 
TCP_NODELAY?
- Is there a way to change this?
- If not, do you have better workarounds than injecting a fake ACK 
pretending to come "from the server" via a raw socket?
   Actually, we haven't tried this yet, but probably will soon.

Regards,
Dennis

