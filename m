Return-Path: <netdev+bounces-295038-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id flOgMartIGp89gAAu9opvQ
	(envelope-from <netdev+bounces-295038-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 05:14:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 541FB63CAAD
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 05:14:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=qlMRhIgS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295038-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295038-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21FB93004C7B
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 03:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D6037F001;
	Thu,  4 Jun 2026 03:12:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049C433F5A7
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 03:12:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780542767; cv=none; b=iXdjcA5DhgMgkv6WxXevxtN1Csrzq1cg9xl+S1wsKq/Z8FPOHWD0ebzafxvsPA4QJyrcl3Eiz2Fun/hMHGskFjFay1kiS4acPn+JwEL8KBsoc+J5PWmwm/VdOetojU8zFw1kakxjvV7LKcYIznXhIA3h1JywmL/dZ4eEJ7qLeTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780542767; c=relaxed/simple;
	bh=DlfDwq7/6VDpQjufWIM7cSm5vVt4VNrY3a/zA5y/Q4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t6xix/RMc+q/ZIRw3InCDIq2TIcOmlQleS02g3ytJKTlA9KzbunHha/0OT+ZOrz4IZ5OypG6Wcds/f/0eNcWUP37BHtnR6zN9t501d5BG4g5y4HxA294Z58b+X7RKvrMzJOk6/GhwkCkL61yXz3lFtb5BuJm4bTgnUPlY9ABS2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qlMRhIgS; arc=none smtp.client-ip=91.218.175.184
Message-ID: <345af51b-9135-4ca0-816b-781a61fdbcbe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780542764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lOGYlrozBf4t97jXZhgsusCZMhce7jGlmSymXrVd1EQ=;
	b=qlMRhIgSgDKeoqs23aIpwFYqgW9UMP/hlz2XjY94XzO0rrQkIfKJe73oYdIWaKhi2sjITz
	xIpn+rG5EE+/+xDmJRBxbesR9HuzSBgNaiCnFRv7aj780Fvgb6pcEx5gbF8+1pcHG8Up9U
	+L9stlYIFkEJ4LMbxhyaQVv4LcXq+s0=
Date: Thu, 4 Jun 2026 11:12:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC net] tls: TLS_SW sendfile() stalls at large MSS
To: Mike Fara <admin@windowsforum.com>, netdev@vger.kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>,
 John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>, David Howells <dhowells@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Mike Fara <mjfara@gmail.com>, linux-kernel@vger.kernel.org
References: <20260603171922.4A1512AA9D4@windowsforum.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260603171922.4A1512AA9D4@windowsforum.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295038-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:admin@windowsforum.com,m:netdev@vger.kernel.org,m:borisp@nvidia.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:sd@queasysnail.net,m:dhowells@redhat.com,m:edumazet@google.com,m:pabeni@redhat.com,m:mjfara@gmail.com,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,redhat.com,google.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:from_mime,linux.dev:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 541FB63CAAD


On 6/4/26 1:19 AM, Mike Fara wrote:
> Hi,
>
> Software-kTLS (TLS_SW) TX over sendfile()/splice() drops to the TCP
> persist-timer cadence (tens of KB/s, with individual sendfile() calls blocking
> for tens of seconds) when the path MSS is large -- e.g. loopback (MSS 65483) or
> jumbo frames. At a typical 1448-byte MSS it does not occur. Plain TCP
> sendfile() on the same path is unaffected, and kTLS write() (no splice) is
> unaffected, so it is specific to TLS_SW + the splice/sendfile path.
>
> It triggers only on large-MSS paths with software kTLS (no NIC TLS offload), so
> it is a niche path -- but it is a clean, reproducible multi-order-of-magnitude
> cliff, so it seems worth a look. Reproduces on current mainline. CCing David
> Howells as the author of the 2023 sendpage->MSG_SPLICE_PAGES splice_to_socket()
> rework referenced below, and Eric/Paolo as this is as much a TCP-corking
> interaction as a TLS one.
>
> Environment
> -----------
> - net/tls TLS_SW (no NIC offload; ethtool tls-hw-tx-offload: off [fixed]).
> - AES-GCM; gcm(aes) resolves to generic-gcm-vaes-avx512.
>
> Reproducer (no OpenSSL/handshake; TLS_TX programmed with a fixed key, the
> receiver discards ciphertext, like tools/testing/selftests/net/tls.c):
>
>      cc -O2 -Wall -o ktls_sendfile_stall ktls_sendfile_stall.c
>      ./ktls_sendfile_stall          # default loopback MSS (65483)
>      ./ktls_sendfile_stall 1448     # clamp sender MSS via TCP_MAXSEG
>
> Observed (loopback, single box):
>
>      MSS=default    sent=     4.0 MiB in  52.08s  =>  0.0001 GiB/s   (stalled)
>      MSS=1448       sent=  2048.0 MiB in   1.65s  =>  1.2106 GiB/s
>
> i.e. ~four orders of magnitude; at the default MSS a single sendfile() blocks
> for tens of seconds. For contrast, on the same loopback path:
>
>      plain TCP sendfile() (no TLS ULP):           7.87  GiB/s
>      kTLS write() (TLS_SW, no splice, 2 GiB):      1.99  GiB/s


I tested your ktls_sendfile_stall.c under stable 6.6 and upstream, but 
both of them works correctly.

~/code/tmp$ ./ktls_sendfile_stall 1448 MSS=1448 sent= 2048.0 MiB in 
2.32s => 0.8603 GiB/s ~/code/tmp$ ./ktls_sendfile_stall 1448 MSS=1448 
sent= 2048.0 MiB in 2.37s => 0.8439 GiB/s ~/code/tmp$ 
./ktls_sendfile_stall MSS=default sent= 2048.0 MiB in 1.64s => 1.2204 
GiB/s :~/code/tmp$ ./ktls_sendfile_stall MSS=default sent= 2048.0 MiB in 
1.70s => 1.1737 GiB/s ~/code/tmp$ ./ktls_sendfile_stall 1448 MSS=1448 
sent= 2048.0 MiB in 2.33s => 0.8570 GiB/s

~/code/tmp$ ethtool -k lo | grep "tls-hw-tx-offload" tls-hw-tx-offload: 
off [fixed]



