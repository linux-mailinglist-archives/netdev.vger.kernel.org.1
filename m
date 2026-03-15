Return-Path: <netdev+bounces-267898-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IQuFOeMtmn6DAEAu9opvQ
	(envelope-from <netdev+bounces-267898-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 11:41:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB5E2906C2
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 11:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A236E301A3A5
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 10:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17762335543;
	Sun, 15 Mar 2026 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hOMYHhtx"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8FB27702D
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 10:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773571280; cv=none; b=OZuSCbBhAZ50Gmdt/el/+pvozF4eRyvb1q/uuHOk4hi76dG7D4SSNooBTW9v9ag7QxYSsWJQjgxPBCyaqHWhpQRNrU8DCtO11+rh1HmGvHiyL0c+rjzV0Q6RLInX7pnfk0xhw9EgQ1gWG/5xutrpz2/zEWRyC2Z9XqT+7njInfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773571280; c=relaxed/simple;
	bh=W3TpesNUzk4PoVFebg08Gv3V5Volkw6OQHS4++M+YUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pCPsgitqwmnZpMd3bE/Sm5uKZmVZP7yJMIoiYVN44AxTpdTgfPoRCuuNb9AkSWXZ6hvAh6Gvm4N0hMKnS5Ue9b1FnquJoeKvr8EN3WF1s5OFwDUuRUQJMArzdQ24l69clyYIN1zHBYCcDZV6BMWNvURaYdhV24VkONUlYOfsTsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hOMYHhtx; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8f118476-ca9b-45f3-b59e-e4cff341ef0f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773571266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KXJauw0u7U+303cKTYIvtRsw7zrCRqeUHKpiha7GoqM=;
	b=hOMYHhtxKU3tLZYIADlYPMRZtWbPE2vX8yQgRwcXF8Y+i0ulLZrI02BF+7BHukYlhOE5nD
	bmRd/H3buAlYOUMhsfghUbaxME6vjkOu+anfg84ZH+zfR91iDr6/3T5C/r2RbQqiPJ7ha2
	kgWubIEyPZjApDNGFfxD1dfRF+rakJU=
Date: Sun, 15 Mar 2026 18:40:51 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v1] selftests: bonding: add test for stacked bond
 header_parse recursion
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com,
 Jiayuan Chen <jiayuan.chen@shopee.com>, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260314134211.33405-1-jiayuan.chen@linux.dev>
 <20260314103833.36698c29@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260314103833.36698c29@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267898-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shopee.com:email]
X-Rspamd-Queue-Id: ABB5E2906C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/15/26 1:38 AM, Jakub Kicinski wrote:
> On Sat, 14 Mar 2026 21:42:05 +0800 Jiayuan Chen wrote:
>> From: Jiayuan Chen <jiayuan.chen@shopee.com>
>>
>> Add a selftest to reproduce the infinite recursion in bond_header_parse()
>> when bonds are stacked (bond1 -> bond0 -> gre). When a packet is received
>> via AF_PACKET SOCK_DGRAM on the topmost bond, dev_parse_header() calls
>> bond_header_parse() which used skb->dev (always the topmost bond) to get
>> the bonding struct. This caused it to recurse back into itself
>> indefinitely, leading to stack overflow.
>>
>> Before Eric's fix [2], the test triggers:
>>
>>    ./bond-stacked-header-parse.sh
>>
>>    [  71.999481] BUG: MAX_LOCK_DEPTH too low!
>>   
[...]
>> +	ip link add name "$devbond0" type bond mode active-backup
>> +	check_err $? "could not create bond0"
>> +	ip link add name "$devbond1" type bond mode active-backup
>> +	check_err $? "could not create bond1"
>> +
>> +	ip link set "$devgre" master "$devbond0"
>> +	check_err $? "could not enslave $devgre to $devbond0"
>> +	ip link set "$devbond0" master "$devbond1"
>> +	check_err $? "could not enslave $devbond0 to $devbond1"
>> +
>> +	ip link set "$devgre" up
>> +	ip link set "$devbond0" up
>> +	ip link set "$devbond1" up
>> +
>> +	# Send a GRE-encapsulated packet to 10.0.0.1 while an AF_PACKET
>> +	# SOCK_DGRAM socket is listening on bond1. The receive path calls
>> +	# dev_parse_header() which invokes bond_header_parse(). With the
>> +	# bug, this recurses infinitely and causes a stack overflow.
>> +	#
>> +	# Use Python to:
>> +	# 1. Open AF_PACKET SOCK_DGRAM on bond1
>> +	# 2. Send a GRE packet to 10.0.0.1 via raw socket
>> +	# 3. Try to receive (triggers parse path)
>> +	python3 -c "
>> +import socket, struct, time
> is this AI-generated?
>
> You can add an extra script in TEST_FILES and just call it.
> No need for inline scripts..
>
>> +# AF_PACKET SOCK_DGRAM on bond1
>> +ETH_P_ALL = 0x0003
>> +pkt_fd = socket.socket(socket.AF_PACKET, socket.SOCK_DGRAM,
>> +                       socket.htons(ETH_P_ALL))
>> +pkt_fd.settimeout(2)
>> +pkt_fd.bind(('$devbond1', ETH_P_ALL))
>> +
>> +# Build GRE-encapsulated IP packet
>> +def build_ip_hdr(proto, saddr, daddr, payload_len):
>> +    ihl_ver = 0x45
>> +    total_len = 20 + payload_len
>> +    hdr = struct.pack('!BBHHHBBH4s4s',
>> +        ihl_ver, 0, total_len, 0, 0, 64, proto, 0,
>> +        socket.inet_aton(saddr), socket.inet_aton(daddr))
>> +    # compute checksum
>> +    words = struct.unpack('!10H', hdr)
>> +    s = sum(words)
>> +    while s >> 16:
>> +        s = (s & 0xffff) + (s >> 16)
>> +    chksum = ~s & 0xffff
>> +    hdr = hdr[:10] + struct.pack('!H', chksum) + hdr[12:]
>> +    return hdr
>> +
>> +inner = build_ip_hdr(17, '192.168.1.1', '192.168.1.2', 8) + b'\x00' * 8
>> +gre_hdr = struct.pack('!HH', 0, 0x0800)  # flags=0, proto=IP
>> +outer = build_ip_hdr(47, '10.0.0.2', '10.0.0.1', len(gre_hdr) + len(inner))
>> +pkt = outer + gre_hdr + inner
>> +
>> +raw_fd = socket.socket(socket.AF_INET, socket.SOCK_RAW, socket.IPPROTO_RAW)
>> +raw_fd.setsockopt(socket.IPPROTO_IP, socket.IP_HDRINCL, 1)
>> +raw_fd.sendto(pkt, ('10.0.0.1', 0))
>> +raw_fd.close()
>> +
>> +try:
>> +    pkt_fd.recv(2048)
>> +except socket.timeout:
>> +    pass
>> +pkt_fd.close()
>> +" 2>/dev/null
>> +
>> +	# If we get here without a kernel crash/hang, the test passed.
>> +	# Also check dmesg for signs of the recursion bug.
>> +	if dmesg | tail -20 | grep -q "BUG: MAX_LOCK_DEPTH\|stack-overflow\|stack overflow"; then
>> +		check_err 1 "kernel detected recursion in bond_header_parse"
>> +	fi
>> +
>> +	# Cleanup
>> +	ip link del "$devbond1" 2>/dev/null
>> +	ip link del "$devbond0" 2>/dev/null
>> +	ip link del "$devgre" 2>/dev/null
>> +	ip link del "$devdummy" 2>/dev/null
>> +
>> +	log_test "Stacked bond header_parse does not recurse"
>> +}
>> +
>> +require_command python3
> No need, we have pure python tests
>
>> +tests_run
>> +
>> +exit "$EXIT_STATUS"
Thanks Jakub,

All the feedback makes sense, will address them in v2.

Regarding the Python script, I originally had something simpler like:

# AF_PACKET SOCK_DGRAM on non-Ethernet device triggers dev_parse_header()
timeout 5 tcpdump -c 1 -i "$devbond1" >/dev/null 2>&1 &
sleep 1

# Send a GRE packet so it arrives via gre -> bond0 -> bond1
python3 -c "
from scapy.all import *
send(IP(src='10.0.0.2', dst='10.0.0.1')/GRE()/IP()/UDP(), verbose=0)
"

But I wasn't sure if scapy is an acceptable dependency for selftests,
and I also wasn't confident that tcpdump will always use AF_PACKET
SOCK_DGRAM internally. So I ended up writing the Python script to
handle both the SOCK_DGRAM listener and packet construction myself.

Is it fine to just inline a few lines like the scapy approach above,

or would you prefer keeping it as a separate script?



