Return-Path: <netdev+bounces-257041-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DBHJ3xShGkx2gMAu9opvQ
	(envelope-from <netdev+bounces-257041-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 09:19:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F18F7EFCEA
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 09:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 291A1302592E
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 08:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077CC35CB76;
	Thu,  5 Feb 2026 08:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anonaddy.me header.i=@anonaddy.me header.b="TKB834v+"
X-Original-To: netdev@vger.kernel.org
Received: from mail2.anonaddy.me (mail2.anonaddy.me [185.70.196.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C75B35C182
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 08:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.196.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770279505; cv=none; b=SRSHFDR1iYGeOFzodpf3bp7r6l4hVw3/G8qKIJ1chzxkvAI4dZPS0xELc1+XNDpcChjh2npkAw32jKfRiETDk5w8AkDGI8G+pZt2iI7/DtXQSRwU31m027q2EbNKUqxAYPNCcqwX75sNXz7WwTTzUQZaD7F9PyhJXjpM48O6s7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770279505; c=relaxed/simple;
	bh=voxuiANRapyhEKlWRapxmS3AbzE9OhdbsL3mO57YfYc=;
	h=From:To:Subject:Message-ID:MIME-Version:Date:Content-Type; b=NjhVz7gJL1vJZ2BQQ8EEBg0mDb1tihSlBNjdTE1WqRCE0fjGaxQoppNemXFJZnBElaauwZnGcist9oFRfoweBa2nhqmWv8Bp1dL1HdzgpqRppn8/MOmnBJcUxa5qDsf2LoBYrT1IowVQ2cK5mbhY5KrwPuCtrGkKqseR6I7cunQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=anonaddy.me; spf=pass smtp.mailfrom=anonaddy.me; dkim=pass (2048-bit key) header.d=anonaddy.me header.i=@anonaddy.me header.b=TKB834v+; arc=none smtp.client-ip=185.70.196.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=anonaddy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anonaddy.me
Received: from mail2.anonaddy.me (mail2.anonaddy.me [127.0.0.1])
	by mail2.anonaddy.me (Postfix) with ESMTPS id A8FF91001F1
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 08:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anonaddy.me; s=default2;
	t=1770279503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=voxuiANRapyhEKlWRapxmS3AbzE9OhdbsL3mO57YfYc=;
	b=TKB834v+vCfdIoQw8nWiAqMSBduLxN1BY/0GS2XkHj+15zKWcs9RVg4AoGoVnqMeJ8bUIO
	OrXe4dWLHwFuZEGpY/wEbXo+mfspjadRtWmZPaftlwC9QSFO45Se0q5owgWDqa69mo7Mnk
	YY5P65G6j2n5mSIUq85C0RB+IM3fxShP7BOAb31EIrkWjUznXKMHIApLCM/aGcFHHqj6LE
	9ed4zgSCpiNl6y2onYak2pnuUKby6GJmOqilPCl4vCKPepx4hDZOc35OQvtzZCokoo2tYy
	bI5NxYhe6dUqONu7d/XZ57wMMYEF50RIKCaUsA8IRJ/7rtFF7w0N2JADkMLhSw==
From: agpn1b92@anonaddy.me
To: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 sgarzare@redhat.com
Subject: [BUG] vsock: poll() not waking on data arrival, causing
 multi-second SSH delays
Feedback-ID: S:d17f588e-5717-4190-ab1e-7db474f4dce6:anonaddy
Message-ID: <69215650a498621d099254e359e0b464@anonaddy.me>
X-Complaints-To: abuse@help.addy.io
X-Report-Abuse: abuse@help.addy.io
X-Report-Abuse-To: abuse@help.addy.io
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 05 Feb 2026 08:18:23 +0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[anonaddy.me,reject];
	R_DKIM_ALLOW(-0.20)[anonaddy.me:s=default2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[anonaddy.me:+];
	FROM_NEQ_ENVFROM(0.00)[agpn1b92@anonaddy.me,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-257041-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anonaddy.me:mid,anonaddy.me:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vsock:email]
X-Rspamd-Queue-Id: F18F7EFCEA
X-Rspamd-Action: no action

Hi,

I'm experiencing a bug where SSH sessions over vsock take 2-20+ se=
conds
to establish due to poll() not signaling POLLIN when data is availa=
ble.
The bug does NOT occur on the first connection after VM boot, but af=
fects
all subsequent connections.

* Summary

- vsock poll() fail=
s to return POLLIN when data is in the receive buffer
- sshd-session's pp=
oll() times out every ~20ms instead of waking on data
- First SSH connect=
ion after guest boot works instantly
- All subsequent connections experie=
nce 2-20+ second delays
- Non-PTY commands (ssh -T ... 'echo test') work =
instantly
- TCP connections to the same VM work instantly

* Environm=
ent

Host:
- OS: Arch Linux
- Kernel: 6.18.2-arch2-1
- QEMU: syst=
em package (latest)

Guest:
- OS: Debian trixie
- Kernel: 6.17.13+d=
eb13-amd64 (also tested on 6.12.57, same issue)
- OpenSSH: 10.0p2

QE=
MU command (relevant parts):
 =C2=A0 qemu-system-x86_64 -enable-kvm -smp =
8 \
 =C2=A0 =C2=A0 -object memory-backend-memfd,id=3Dmem,size=3D20G,share=
=3Don \
 =C2=A0 =C2=A0 -machine memory-backend=3Dmem \
 =C2=A0 =C2=
=A0 -device vhost-vsock-pci,guest-cid=3D5 \
 =C2=A0 =C2=A0 ...

Conne=
ction method: ssh user@vsock/5 (via systemd-ssh-proxy)

* Symptoms
=

Interactive SSH (PTY) - SLOW:
 =C2=A0 $ time ssh user@vsock/5
 =
=C2=A0 # Takes 2-20+ seconds before shell prompt appears

Non-interacti=
ve SSH - FAST:
 =C2=A0 $ time ssh user@vsock/5 'echo test'
 =C2=A0 test=

 =C2=A0 real=C2=A0 =C2=A0 0m0.156s

TCP to same VM - FAST:
 =C2=
=A0 $ time ssh -p 33594 user@127.0.0.1
 =C2=A0 # Instant

* Key obser=
vation: First connection after boot is fast

After guest reboot:
 =
=C2=A0 $ ssh user@vsock/5=C2=A0 =C2=A0 =C2=A0 # INSTANT (< 1 second)
 =
=C2=A0 $ exit
 =C2=A0 $ ssh user@vsock/5=C2=A0 =C2=A0 =C2=A0 # SLOW (2-20=
 seconds)
 =C2=A0 $ ssh user@vsock/5=C2=A0 =C2=A0 =C2=A0 # SLOW
 =C2=
=A0 ...

This suggests the bug involves state that accumulates or isn't=
 properly
cleaned up between connections.

** bpftrace evidence

=
Using syscall tracepoints on guest during slow connection:

 =C2=A0 =3D=
=3D=3D MINIMAL VSOCK DIAGNOSTIC =3D=3D=3D
 =C2=A0 [=C2=A0 =C2=A029 ms] ss=
hd-session: ppoll() duration=3D19 ms ret=3D1
 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0^^^ 20ms TIMEOUT pattern detected!
 =C2=A0 [=
=C2=A0 =C2=A050 ms] sshd-session: ppoll() duration=3D20 ms ret=3D1
 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^^^ 20ms TIMEOUT pattern de=
tected!
 =C2=A0 [=C2=A0 =C2=A070 ms] sshd-session: ppoll() duration=3D18 =
ms ret=3D1
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^^^ 20ms TIME=
OUT pattern detected!
 =C2=A0 ... (continues for ~2 seconds) ...

 =
=C2=A0 [ 5000 ms] --- 5s stats: ppoll=3D455, timeouts=3D103, recv=3D0 (0 by=
tes) ---

 =C2=A0 [19432 ms] sshd: recvmsg() =3D 308 bytes [4 =C2=B5s]=

 =C2=A0 [19442 ms] sshd-session: recvmsg() =3D 308 bytes [4 =C2=B5s]
=

Pattern analysis:
- ppoll() returns ret=3D1 (1 fd ready) but takes exa=
ctly ~20ms (timeout)
- The ready fd is the PTY, NOT the vsock socket
- =
recv=3D0 during the timeout phase: vsock data not being read
- recvmsg() =
finally succeeds after ~19 seconds
- When recvmsg() runs, it completes in=
 4 microseconds (data WAS there)

This proves: data is sitting in the v=
sock receive buffer, but poll()
is not returning POLLIN, so sshd doesn't =
know to read it.

* 30-second summary from bpftrace

 =C2=A0 Total =
ppoll calls: 488
 =C2=A0 Timeouts (20ms pattern): 103
 =C2=A0 Successfu=
l recvmsg: 6 (984 bytes)
 =C2=A0 Timeout rate: 21%

* Why PTY-specifi=
c?

PTY sessions require bidirectional traffic:
1. Server sends shell=
 prompt =E2=86=92 client must receive it
2. Client sends keypress =
=E2=86=92 server must receive it
3. Server sends echo =E2=86=92 client mu=
st receive it

Each exchange relies on poll() waking on POLLIN. The bug=
 causes poll()
to miss the wakeup, forcing sshd to wait for its 20ms time=
out fallback.

Non-PTY commands do request-response-exit quickly before=
 the bug
manifests significantly.

## Additional context

I previ=
ously encountered the identical issue on WSL2's Hyper-V vsock
implementat=
ion, suggesting this may be a fundamental issue with how
vsock transports=
 handle poll/wakeup semantics, not specific to virtio.

## Hypothesis=


Based on the evidence, this appears to be a lost wakeup race conditio=
n:
1. Host sends packet to guest
2. Packet is enqueued to socket's rx_q=
ueue
3. sk_data_ready() is called but poll waiters aren't properly woken=

4. vsock_poll() returns 0 (no POLLIN) despite data being available
5. =
ppoll() times out after 20ms, sshd retries
6. Eventually succeeds through=
 timeout-based retry

The "first connection works" pattern suggests the=
 race involves
existing state from previous connections - possibly worker=
 threads,
interrupt handlers, or virtqueue state that isn't properly rese=
t.

## Reproducer

1. Start QEMU VM with vhost-vsock-pci device
2=
. Boot guest, ensure sshd is running
3. From host: ssh user@vsock/<CID>=
=C2=A0 # First connection is fast
4. Exit and reconnect: ssh user@vsock/<=
CID>=C2=A0 # Now slow

## Request

Could someone familiar with the =
vsock/virtio poll implementation
review the wakeup path? Specifically:
=
- virtio_transport_recv_pkt() -> sk_data_ready() path
- vsock_poll() -> p=
oll_wait() registration timing
- Any state that persists between connecti=
ons

Happy to provide additional traces or test patches.

Thanks,=

[Your Name]

---
bpftrace script used (runs on guest):

#!/usr=
/bin/env bpftrace
BEGIN {
 =C2=A0 =C2=A0 @start =3D nsecs;
 =C2=A0 =
=C2=A0 printf("=3D=3D=3D MINIMAL VSOCK DIAGNOSTIC =3D=3D=3D\n");
}
trac=
epoint:syscalls:sys_enter_ppoll {
 =C2=A0 =C2=A0 if (comm =3D=3D "sshd-se=
ssion" || comm =3D=3D "sshd") {
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 @ppoll_enter=
[tid] =3D nsecs;
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 @ppoll_count++;
 =C2=
=A0 =C2=A0 }
}
tracepoint:syscalls:sys_exit_ppoll {
 =C2=A0 =C2=A0 if=
 (@ppoll_enter[tid]) {
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $ms =3D (nsecs - @sta=
rt) / 1000000;
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $dur =3D (nsecs - @ppoll_ente=
r[tid]) / 1000000;
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ($dur > 10) {
 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf("[%5lld ms] %s: ppoll() du=
ration=3D%lld ms ret=3D%d\n",
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$ms, comm, $dur, args->ret);
 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ($dur >=3D 18 && $dur <=3D 25) {
 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf("=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^^^ 20ms TIMEOUT pattern detected!\n");=

 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 @timeout_count+=
+;
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 delete(@ppoll_enter[tid]);
 =
=C2=A0 =C2=A0 }
}
tracepoint:syscalls:sys_exit_recvmsg {
 =C2=A0 =
=C2=A0 if (comm =3D=3D "sshd-session" || comm =3D=3D "sshd") {
 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 if (args->ret > 0) {
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 $ms =3D (nsecs - @start) / 1000000;
 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 printf("[%5lld ms] %s: recvmsg() =3D %lld bytes\n"=
, $ms,=20
comm, args->ret);
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 @r=
ecv_count++;
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 @recv_bytes +=3D =
args->ret;
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
 =C2=A0 =C2=A0 }
}
interv=
al:s:5 {
 =C2=A0 =C2=A0 printf("\n[%5lld ms] --- 5s stats: ppoll=3D%d, ti=
meouts=3D%d, recv=3D%d=20
(%d bytes) ---\n\n",
 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0(nsecs - @start) / 1000000, @ppoll_count, @timeout_coun=
t,=20
@recv_count, @recv_bytes);
}



