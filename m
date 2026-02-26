Return-Path: <netdev+bounces-261635-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMyIKdHaoGk+ngQAu9opvQ
	(envelope-from <netdev+bounces-261635-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 00:44:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE9F1B0FE2
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 00:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 803803018BE9
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 23:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA90F2857EA;
	Thu, 26 Feb 2026 23:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iFLFnVcD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xAosWn59";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iFLFnVcD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xAosWn59"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B59042049
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 23:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772149454; cv=none; b=NAwConIEOsP0AfwQgxzMzGF4CVuzS8Ww5kI6awanBv5l9REmOFWgvtQgUfbBvUMgT9Zs24gdD7qW16A769MvqfrrvmjVFqxSjtAFn6/j5I4n/FVAtEj8252xcw1fgIITUMYdDMaK+H0y3FIJ3M4A4IZTM74dLUca09lsDfjDg94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772149454; c=relaxed/simple;
	bh=F8SpSW34g5JZ9gdBa1sckX6sCHIYekbZVWNhZMg3fuQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=lkpNArPxXrrLUK93CWTvwEkheeuyXlyiv/I1auvrOaAM6Vm/54nirsDQyVDAoUSHHBkUv96DYSK3Ap162OyEnXvE5b/rSGlwmpuS3vSU8o5b8/ClqwPQ1X9ceC+ThfWafq2iGzHhcIh2ysFdtNu57P/iL4pN+ICwTnCrslnlxQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iFLFnVcD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xAosWn59; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iFLFnVcD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xAosWn59; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 924641FA93;
	Thu, 26 Feb 2026 23:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772149451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bcrN25Y9CwSe/yO1wkn2rEigBYx6oeIn4+9ZILF5RP4=;
	b=iFLFnVcDZYjfnxPLsS7gQ4Dhlqq4KNU84GmxB8GiKvD8KAFIIb6L8hr4oNsQrJ6dqcWuml
	wobyNRKr5euFhE5YzMTz8PRCyl4X+TpK55hH4xJBGhabQnzH02oNvBlDu+5X7NWamMszwc
	/97MbggrAnFlSFMtJG5GemsGzjccDYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772149451;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bcrN25Y9CwSe/yO1wkn2rEigBYx6oeIn4+9ZILF5RP4=;
	b=xAosWn59+wNVSROp72SUdNpL2E3L+uznSh/4BLXpAYUGrhjcy/GykWMYRhX4kjR2heTDFu
	vIA9RQtRmmktHXBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iFLFnVcD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xAosWn59
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772149451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bcrN25Y9CwSe/yO1wkn2rEigBYx6oeIn4+9ZILF5RP4=;
	b=iFLFnVcDZYjfnxPLsS7gQ4Dhlqq4KNU84GmxB8GiKvD8KAFIIb6L8hr4oNsQrJ6dqcWuml
	wobyNRKr5euFhE5YzMTz8PRCyl4X+TpK55hH4xJBGhabQnzH02oNvBlDu+5X7NWamMszwc
	/97MbggrAnFlSFMtJG5GemsGzjccDYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772149451;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bcrN25Y9CwSe/yO1wkn2rEigBYx6oeIn4+9ZILF5RP4=;
	b=xAosWn59+wNVSROp72SUdNpL2E3L+uznSh/4BLXpAYUGrhjcy/GykWMYRhX4kjR2heTDFu
	vIA9RQtRmmktHXBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 650553EA62;
	Thu, 26 Feb 2026 23:44:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UgtlFcvaoGliUAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 26 Feb 2026 23:44:11 +0000
Message-ID: <ee078ea8-dba3-4494-91ff-bcc5907ef689@suse.de>
Date: Fri, 27 Feb 2026 00:44:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Kernel Panic in br_do_suppress_nd when ipv6.disable=1 (NULL
 pointer dereference)
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: Guruprasad C P <gurucp2005@gmail.com>, netdev@vger.kernel.org
References: <CAHXs0ORzd62QOG-Fttqa2Cx_A_VFp=utE2H2VTX5nqfgs7LDxQ@mail.gmail.com>
 <d71fbf78-4950-42c1-b941-b6356f42c74e@suse.de>
Content-Language: en-US
In-Reply-To: <d71fbf78-4950-42c1-b941-b6356f42c74e@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261635-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:mid,suse.de:dkim,nd_crash.sh:url]
X-Rspamd-Queue-Id: 0AE9F1B0FE2
X-Rspamd-Action: no action

On 2/26/26 4:11 PM, Fernando Fernandez Mancera wrote:
> On 2/26/26 12:14 AM, Guruprasad C P wrote:
>> We have identified a 100% reproducible kernel panic in the bridge 
>> driver (|net/bridge/br_arp_nd_proxy.c|) on kernels up to at least 5.15 
>> and 6.x.
>>
>> *Description:* The crash occurs when the kernel is booted with | 
>> ipv6.disable=1| and a bridge port has |neigh_suppress| enabled. When 
>> the bridge receives an ICMPv6 Neighbor Solicitation, it attempts to 
>> perform a lookup in the neighbor table via |ipv6_stub->nd_tbl|. 
>> Because IPv6 was disabled at boot, |nd_tbl| is NULL, leading to an 
>> immediate dereference panic.
>>
> 
> This is a nice catch. The key here is that inet6_init() is exiting 
> before ndisc_init() is called.
> 
> Hm I wonder if there are more parts of the kernel where this might be a 
> problem. I noticed several uses of ipv6_stub->nd_tbl that relies on 
> IS_ENABLED(CONFIG_IPV6) check..
> 
> I am writing a patch for this.
> 
> Thank you!


Hi,

I have sent a patch fixing this [1].

FWIW, I have created a much simpler reproducer that triggers this 
immediately. Check it out below.

[1] https://lore.kernel.org/netdev/20260226234059.19402-1-fmancera@suse.de/


$ cat nd_crash.sh
#!/bin/bash

if [ "$EUID" -ne 0 ]; then
   echo "Root is required"
   exit 1
fi

ip link add name br-crash type bridge
ip link set dev br-crash up

ip link add name dummy-supp type dummy
ip link set dev dummy-supp master br-crash
ip link set dev dummy-supp up

if ! ip link set dev dummy-supp type bridge_slave neigh_suppress 1 
2>/dev/null; then
     bridge link set dev dummy-supp neigh_suppress on
fi

ip link add veth-in type veth peer name veth-out
ip link set dev veth-in master br-crash
ip link set dev veth-in up
ip link set dev veth-out up

python3 - <<EOF
from scapy.all import Ether, IPv6, ICMPv6ND_NS, sendp
import time

time.sleep(1)

eth = Ether(dst="33:33:ff:00:00:01", src="00:11:22:33:44:55", type=0x86dd)
ip6 = IPv6(src="fe80::1", dst="ff02::1:ff00:1")
nd = ICMPv6ND_NS(tgt="fe80::2")

packet = eth / ip6 / nd

sendp(packet, iface="veth-out", verbose=False)
EOF

ip link del dev br-crash 2>/dev/null
ip link del dev veth-in 2>/dev/null
ip link del dev dummy-supp 2>/dev/null

