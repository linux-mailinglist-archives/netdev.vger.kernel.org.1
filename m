Return-Path: <netdev+bounces-257602-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MAWDasVhmk1JgQAu9opvQ
	(envelope-from <netdev+bounces-257602-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 17:24:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65954100348
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 17:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A40EB300F5E9
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 16:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46965326D79;
	Fri,  6 Feb 2026 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FShOCqs3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bxqy0iJL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08F332573E
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770395045; cv=none; b=n/932Wo6Fogr9rHKKYtFLi1H3GEQpP0pL0mieUVr01cla6mQ4bzW+8EHCsmzEVVsqkElPAk0uWQT/l74X5xSha0LU7WsRHGLQ+EMaY+jvOFucjD+qIu4XdWsJg4zSrhxDw1jrsh36hUHb8F0YRfQX2RmO3f6lkI96mnkbmGSxCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770395045; c=relaxed/simple;
	bh=eoZQP6Pw5nf5m7F2meipgxmbmle6wXNPF6+XfM6ec8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J20E2oKNErEddC13id+ikTm/juQdsZ7W06TsRN8SUqt3vE4jCH0N8U1GnyKWa6Gh5jQrZckpxMzBtbSyGIoiapcD4tJQpCtMSkHKqb0hjr5QjJtM61cOE9ct9GnA4hGt0DVinjW96ooNsPES2Sh5eVnwIQSqJqkyZ4T3rrUWgms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FShOCqs3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bxqy0iJL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770395044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3SixDUkQfbGW/CySUSPTvhYKmVPlXZV2VssvRFKjxUY=;
	b=FShOCqs3cXLpKwqzeSPKOaeFNzrNAwYxEj2w58h2TkoQ8yKsS8rXRy5wQdLZZWAl93hmLl
	Vn9PZpV46wLKi0AbXmm4dne/1f/hHC4DMZjLR4lUf0igDaCOF0lOQSXVwPsLKR7Ka9gSLF
	MbJzQEV2LspS8xNBp7t/16Y4bgyCqb4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-QFXXXcvZPpOu6PqZeAG0iQ-1; Fri, 06 Feb 2026 11:24:02 -0500
X-MC-Unique: QFXXXcvZPpOu6PqZeAG0iQ-1
X-Mimecast-MFC-AGG-ID: QFXXXcvZPpOu6PqZeAG0iQ_1770395042
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4802bb29400so23104735e9.0
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 08:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770395041; x=1770999841; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3SixDUkQfbGW/CySUSPTvhYKmVPlXZV2VssvRFKjxUY=;
        b=Bxqy0iJLRffiqfRub2XDqT0fGS03Dnw6HdfouMC31Jp1QiGW9Z7KH/25Lfe84il73t
         AFyMiO7gbWsobMeYife5wFCWB6V9DDsXm69g9JYxVj0gYqxoOaiUyx1ewM+LefXFZyZf
         A6OEQXJb/RqTqPYzQMUD30QSIzvg5T9G0Px4h8mjoOn1zt5Ql8lXJSrUoqu3uf3v0Mis
         XVfniKJs+PJ6Kzks+rN+e3LBuC1MOYFz2548ITdcsuhurjKsvqU6ii+6d6z3g1YrEdVJ
         VnI70GIgvCuK6IEsZ2wKMTI1cuTQkYrm2YRdMmeNIOz68foaOklpMKaj3y3wYbG+EmtF
         bonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770395041; x=1770999841;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3SixDUkQfbGW/CySUSPTvhYKmVPlXZV2VssvRFKjxUY=;
        b=F8+kfU0jjv0O2mFEH21t8Y49YnsCHkR1oQASeh5OrK5fX0hYz9HPCj6e0UqRAoVGyF
         e+KEZFAj4CHvugVdHTsTdfFmUpmXkzcgKnTJKM+TUK3SbGRP/NliT+8ovgHL6Q6zGAs+
         vbZS4vKt6Uc4P5fRQUULVjLfPOGshMjkxHp0Wg50zHcWqC1AjBs1SovCFqvc78LJdpGC
         WAvhDPk8zbIZU7NmsUjXU8Lz8uQdPvUCIF5AZhETLCrEKqoJMWNGL8K/dip93CA/MCo0
         wG/sN0F1ZjS7s6A38HFOcQDR/Q2PjhbO3eKjcYWM1cBaWcpFKFjdBZNq1QAR0SyyPerw
         yXtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT/q+1ihCftaJ9ZqbN2p3eAK+nXLb9UKe1FwLNQEJaq0S0jQGBXn0+wAOymymIW58EN4s8sTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJHFJ5yZNi46qM8trniY29VnHtoIe636y6LLCyLJmHeE+Ye6be
	5e31mtQeQfUcYfoAY1+5jSf/28paqi7vhT7cio8ZoQn4OvUAmxA/eauy6aNScFocHUPp2m603Co
	D1bO7chHL773d0MkcWgvXeIDyzNK0Uy9nus/Fua0d595bxe9uqUnHdaniQJC2VU78uw==
X-Gm-Gg: AZuq6aL00+XxLwtXq+mGY77HfXeknDzZlm3q2K5UAc8ANx3JIjjl/W5hcvOk3gHWJll
	BsTIGUMdYYplmtYYBG21KpbvJr2u5JO0bjr3dJ5bj85jg3TkXdy9pNARQRjj0YmsQMFGOQqM5S8
	V3oUdJZpK2HCAaAZKc65OC/0L2CHFMMagZ7yRZ+xQWRFFbqd0/+bo3xGy4ly3Lcawy61j6ruMlQ
	QjiYVcCe4LJ7vF9IeZxeSiZkisJXtdGhvq38nH06uRF8u8pVm1//1m74gzCwEVUcpnVkU9Uw1eB
	2sXucRJ4mktE90xw7guGV6ix2jCqvIWEcZVgA0eQ8lERq+xhjCZvJfaRYPVLr0OC4A+akgmKyDO
	pvXpwNz2kU9AkEyp4mUuo020IGDbvGnliMz33irN8TNawCTV4u/zRE7LRY0I=
X-Received: by 2002:a05:600c:34c7:b0:477:b0b9:3129 with SMTP id 5b1f17b1804b1-483201dc3ebmr47795785e9.3.1770395040983;
        Fri, 06 Feb 2026 08:24:00 -0800 (PST)
X-Received: by 2002:a05:600c:34c7:b0:477:b0b9:3129 with SMTP id 5b1f17b1804b1-483201dc3ebmr47795425e9.3.1770395040442;
        Fri, 06 Feb 2026 08:24:00 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48320728774sm57584915e9.14.2026.02.06.08.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 08:23:59 -0800 (PST)
Date: Fri, 6 Feb 2026 17:23:52 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: agpn1b92@anonaddy.me
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [BUG] vsock: poll() not waking on data arrival, causing
 multi-second SSH delays
Message-ID: <aYYTder4-zvgOfV7@sgarzare-redhat>
References: <f3a801a1a32670294d5d703cad8ab609@anonaddy.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3a801a1a32670294d5d703cad8ab609@anonaddy.me>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257602-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anonaddy.me:email]
X-Rspamd-Queue-Id: 65954100348
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 07:53:33AM +0000, agpn1b92@anonaddy.me wrote:
>Hi,

Hi [Your Name],

>
>I'm experiencing a bug where SSH sessions over vsock take 2-20+ seconds
>to establish due to poll() not signaling POLLIN when data is available.
>The bug does NOT occur on the first connection after VM boot, but affects
>all subsequent connections.
>
>* Summary
>
>- vsock poll() fails to return POLLIN when data is in the receive buffer
>- sshd-session's ppoll() times out every ~20ms instead of waking on data
>- First SSH connection after guest boot works instantly
>- All subsequent connections experience 2-20+ second delays
>- Non-PTY commands (ssh -T ... 'echo test') work instantly

mm, so not sure if it's related to the kernel or the user space proxy, 
etc. Would be nice to replicate without ssh.

I tried with 6.18 on both guest and host and I'm not able to reproduce 
it.

Can you try to write a simple reproducer without ssh involved?

Thanks,
Stefano

>- TCP connections to the same VM work instantly
>
>* Environment
>
>Host:
>- OS: Arch Linux
>- Kernel: 6.18.2-arch2-1
>- QEMU: system package (latest)
>
>Guest:
>- OS: Debian trixie
>- Kernel: 6.17.13+deb13-amd64 (also tested on 6.12.57, same issue)
>- OpenSSH: 10.0p2
>
>QEMU command (relevant parts):
>  qemu-system-x86_64 -enable-kvm -smp 8 \
>    -object memory-backend-memfd,id=mem,size=20G,share=on \
>    -machine memory-backend=mem \
>    -device vhost-vsock-pci,guest-cid=5 \
>    ...
>
>Connection method: ssh user@vsock/5 (via systemd-ssh-proxy)
>
>* Symptoms
>
>Interactive SSH (PTY) - SLOW:
>  $ time ssh user@vsock/5
>  # Takes 2-20+ seconds before shell prompt appears
>
>Non-interactive SSH - FAST:
>  $ time ssh user@vsock/5 'echo test'
>  test
>  real    0m0.156s
>
>TCP to same VM - FAST:
>  $ time ssh -p 33594 user@127.0.0.1
>  # Instant
>
>* Key observation: First connection after boot is fast
>
>After guest reboot:
>  $ ssh user@vsock/5      # INSTANT (< 1 second)
>  $ exit
>  $ ssh user@vsock/5      # SLOW (2-20 seconds)
>  $ ssh user@vsock/5      # SLOW
>  ...
>
>This suggests the bug involves state that accumulates or isn't properly
>cleaned up between connections.
>
>** bpftrace evidence
>
>Using syscall tracepoints on guest during slow connection:
>
>  === MINIMAL VSOCK DIAGNOSTIC ===
>  [   29 ms] sshd-session: ppoll() duration=19 ms ret=1
>             ^^^ 20ms TIMEOUT pattern detected!
>  [   50 ms] sshd-session: ppoll() duration=20 ms ret=1
>             ^^^ 20ms TIMEOUT pattern detected!
>  [   70 ms] sshd-session: ppoll() duration=18 ms ret=1
>             ^^^ 20ms TIMEOUT pattern detected!
>  ... (continues for ~2 seconds) ...
>
>  [ 5000 ms] --- 5s stats: ppoll=455, timeouts=103, recv=0 (0 bytes) ---
>
>  [19432 ms] sshd: recvmsg() = 308 bytes [4 µs]
>  [19442 ms] sshd-session: recvmsg() = 308 bytes [4 µs]
>
>Pattern analysis:
>- ppoll() returns ret=1 (1 fd ready) but takes exactly ~20ms (timeout)
>- The ready fd is the PTY, NOT the vsock socket
>- recv=0 during the timeout phase: vsock data not being read
>- recvmsg() finally succeeds after ~19 seconds
>- When recvmsg() runs, it completes in 4 microseconds (data WAS there)
>
>This proves: data is sitting in the vsock receive buffer, but poll()
>is not returning POLLIN, so sshd doesn't know to read it.
>
>* 30-second summary from bpftrace
>
>  Total ppoll calls: 488
>  Timeouts (20ms pattern): 103
>  Successful recvmsg: 6 (984 bytes)
>  Timeout rate: 21%
>
>* Why PTY-specific?
>
>PTY sessions require bidirectional traffic:
>1. Server sends shell prompt → client must receive it
>2. Client sends keypress → server must receive it
>3. Server sends echo → client must receive it
>
>Each exchange relies on poll() waking on POLLIN. The bug causes poll()
>to miss the wakeup, forcing sshd to wait for its 20ms timeout fallback.
>
>Non-PTY commands do request-response-exit quickly before the bug
>manifests significantly.
>
>## Additional context
>
>I previously encountered the identical issue on WSL2's Hyper-V vsock
>implementation, suggesting this may be a fundamental issue with how
>vsock transports handle poll/wakeup semantics, not specific to virtio.
>
>## Hypothesis
>
>Based on the evidence, this appears to be a lost wakeup race condition:
>1. Host sends packet to guest
>2. Packet is enqueued to socket's rx_queue
>3. sk_data_ready() is called but poll waiters aren't properly woken
>4. vsock_poll() returns 0 (no POLLIN) despite data being available
>5. ppoll() times out after 20ms, sshd retries
>6. Eventually succeeds through timeout-based retry
>
>The "first connection works" pattern suggests the race involves
>existing state from previous connections - possibly worker threads,
>interrupt handlers, or virtqueue state that isn't properly reset.
>
>## Reproducer
>
>1. Start QEMU VM with vhost-vsock-pci device
>2. Boot guest, ensure sshd is running
>3. From host: ssh user@vsock/<CID>  # First connection is fast
>4. Exit and reconnect: ssh user@vsock/<CID>  # Now slow
>
>## Request
>
>Could someone familiar with the vsock/virtio poll implementation
>review the wakeup path? Specifically:
>- virtio_transport_recv_pkt() -> sk_data_ready() path
>- vsock_poll() -> poll_wait() registration timing
>- Any state that persists between connections
>
>Happy to provide additional traces or test patches.
>
>Thanks,
>[Your Name]
>
>---
>bpftrace script used (runs on guest):
>
>#!/usr/bin/env bpftrace
>BEGIN {
>    @start = nsecs;
>    printf("=== MINIMAL VSOCK DIAGNOSTIC ===\n");
>}
>tracepoint:syscalls:sys_enter_ppoll {
>    if (comm == "sshd-session" || comm == "sshd") {
>        @ppoll_enter[tid] = nsecs;
>        @ppoll_count++;
>    }
>}
>tracepoint:syscalls:sys_exit_ppoll {
>    if (@ppoll_enter[tid]) {
>        $ms = (nsecs - @start) / 1000000;
>        $dur = (nsecs - @ppoll_enter[tid]) / 1000000;
>        if ($dur > 10) {
>            printf("[%5lld ms] %s: ppoll() duration=%lld ms ret=%d\n",
>                   $ms, comm, $dur, args->ret);
>            if ($dur >= 18 && $dur <= 25) {
>                printf("           ^^^ 20ms TIMEOUT pattern detected!\n");
>                @timeout_count++;
>            }
>        }
>        delete(@ppoll_enter[tid]);
>    }
>}
>tracepoint:syscalls:sys_exit_recvmsg {
>    if (comm == "sshd-session" || comm == "sshd") {
>        if (args->ret > 0) {
>            $ms = (nsecs - @start) / 1000000;
>            printf("[%5lld ms] %s: recvmsg() = %lld bytes\n", $ms, comm, args-
>>ret);
>            @recv_count++;
>            @recv_bytes += args->ret;
>        }
>    }
>}
>interval:s:5 {
>    printf("\n[%5lld ms] --- 5s stats: ppoll=%d, timeouts=%d, recv=%d (%d bytes)
>---\n\n",
>           (nsecs - @start) / 1000000, @ppoll_count, @timeout_count,
>@recv_count, @recv_bytes);
>}
>
>
>
>


