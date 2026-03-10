Return-Path: <netdev+bounces-265920-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAw3NfjSr2kccwIAu9opvQ
	(envelope-from <netdev+bounces-265920-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:14:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 766232471ED
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 213C23109C53
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F963ED111;
	Tue, 10 Mar 2026 08:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPcgR2N3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7598429DB6A;
	Tue, 10 Mar 2026 08:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773130171; cv=none; b=PbRHtEGfJ2myOKvbTUMg88V3fjDVV5JfsjT87/bJFvZbHph0SJGH/clfTz/uu0DBzkEGgY/7j3bdfCBipZc6V0aIsSloNyWtLLwkJlaRIhB3kCbr2EggaOHqQCb9p0VucF5Kk+E+R+Lyvr4PR6ocfoT9XM+TDypcXrjekwEx/AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773130171; c=relaxed/simple;
	bh=fyxdW4yZLM/QBT6DaWDRFhNx2Iad5yVhiTbU7gZmarY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hKPPGuOkwl5sbBYAJj9pyL3IZvGdP78cZOuc7k9Y2fVJzhat2m+1r8s1HyDoRBxp19VM3UaQBAYj4EGpksgfLVEeC9ZEAs/uDZkQCFdeBH99xCHnpfrHfb1SLRGj2KEP+3G+KrI5QEOIMWP/M0qpm0QeOGl9rK5FRExGNKTJnFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPcgR2N3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C851C19423;
	Tue, 10 Mar 2026 08:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773130171;
	bh=fyxdW4yZLM/QBT6DaWDRFhNx2Iad5yVhiTbU7gZmarY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DPcgR2N3EvgQXwzVDlz+dYXRb6mNgvI1kcNVEMg3KV2JK5PRyKpKjep+FrbCzCGkw
	 tBE6iwa3A1diNd8s0ZynTe2bTIX+8EoQaAOXv06f6S2Ts2F0q0G3E2I3G0A9qeOCqW
	 emhs9Je2mce98Pt6Mm2qK9yt7ZtyykdOAfUxWDbcthoHCjflfMblBjmN6l76XhWHce
	 oSmHNtnVBOsPt/EJ0ZlBXXIVei4xdrawuEUgqBuBGBLlvW8oHexHRgtLhynKhOxfvY
	 RoWxe42pFKDJpnZDNsEZiIpM64az4odfksXIRfSUeL5HVYcNm6CzZAhO0n2KKyo4Ps
	 EAk+LR5Gb5baw==
From: Thomas Gleixner <tglx@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Jiri Slaby
 <jirislaby@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano
 Garzarella <sgarzare@redhat.com>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, Netdev <netdev@vger.kernel.org>,
 rcu@vger.kernel.org, MPTCP Linux <mptcp@lists.linux.dev>, Linux Kernel
 <linux-kernel@vger.kernel.org>, Shinichiro Kawasaki
 <shinichiro.kawasaki@wdc.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, luto@kernel.org, Michal
 =?utf-8?Q?Koutn=C3=BD?=
 <MKoutny@suse.com>, Waiman Long <longman@redhat.com>, Marco Elver
 <elver@google.com>
Subject: Re: Stalls when starting a VSOCK listening socket: soft lockups,
 RCU stalls, timeout
In-Reply-To: <0ae4d678-5676-4523-bae3-5ad73b526e27@kernel.org>
References: <863a5291-a636-47d0-891c-bb0524d2e134@kernel.org>
 <20260302114636.GL606826@noisy.programming.kicks-ass.net>
 <717310d8-6274-4b7f-8a19-561c45f5f565@kernel.org>
 <a2b573b4-af61-4b84-a7d1-012ed6bb23c9@kernel.org>
 <ba067933-bf3b-476d-a0bb-53eda56996ca@kernel.org> <87zf4m2qvo.ffs@tglx>
 <47cba228-bba7-4e58-a69d-ea41f8de6602@kernel.org> <87tsuu2i59.ffs@tglx>
 <7efde2b5-3b72-4858-9db0-22493d446301@kernel.org> <87qzpx2sck.ffs@tglx>
 <20260306152458.GT606826@noisy.programming.kicks-ass.net>
 <87ldg42eu7.ffs@tglx> <87h5qr2rzi.ffs@tglx> <87eclu3coa.ffs@tglx>
 <87v7f61cnl.ffs@tglx> <57c1e171-9520-4288-9e2d-10a72a499968@kernel.org>
 <87pl5ds88r.ffs@tglx> <0ae4d678-5676-4523-bae3-5ad73b526e27@kernel.org>
Date: Tue, 10 Mar 2026 09:09:27 +0100
Message-ID: <87eclsrtqg.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 766232471ED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265920-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Matthieu!

On Mon, Mar 09 2026 at 13:23, Matthieu Baerts wrote:
> On 09/03/2026 09:43, Thomas Gleixner wrote:
>> That should provide enough information to decode this mystery.

That was wishful thinking, but at least it narrows down the search space.

> Thank you for the debug patch and the clear instructions. I managed to
> reproduce the issue with the extra debug. The ouput is available here:
>
>   https://github.com/user-attachments/files/25841808/issue-617-debug.txt.gz

Thank you for testing. So what I can see from the trace is:

[    2.101917] virtme-n-68        3d..1. 703536us : mmcid_user_add: t=00000000e4425b1d mm=00000000a22be644 users=3
[    2.102057] virtme-n-68        3d..1. 703537us : mmcid_getcid: mm=00000000a22be644 cid=00000002
[    2.102195] virtme-n-68        3d..2. 703548us : sched_switch: prev_comm=virtme-ng-init prev_pid=68 prev_prio=120 prev_state=D ==> next_comm=swapper/3 next_pid=0 next_prio=120

This one creates the third thread related to the mm and schedules
out. The new thread schedules in a moment later:

[    2.102828]   <idle>-0         2d..2. 703565us : sched_switch: prev_comm=swapper/2 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=virtme-ng-init next_pid=69 next_prio=120
[    2.103039]   <idle>-0         2d..2. 703567us : mmcid_cpu_update: cpu=2 mm=00000000a22be644 cid=00000002

[    2.104283]   <idle>-0         0d..2. 703642us : sched_switch: prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=virtme-ng-init next_pid=1 next_prio=120
[    2.104493]   <idle>-0         0d..2. 703643us : mmcid_cpu_update: cpu=0 mm=00000000a22be644 cid=00000000

virtme-n-1 owns CID 0 and after scheduled in it creates the 4th thread,
which is still in the CID space (0..3)

[    2.104616] virtme-n-1         0d..1. 703690us : mmcid_user_add: t=0000000031a5ee91 mm=00000000a22be644 users=4

Unsurprisingly this assignes CID 3:

[    2.104757] virtme-n-1         0d..1. 703691us : mmcid_getcid: mm=00000000a22be644 cid=00000003

And the newly created task schedules in on CPU3:

[    2.104880]   <idle>-0         3d..2. 703708us : sched_switch: prev_comm=swapper/3 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=virtme-ng-init next_pid=70 next_prio=120
[    2.105091]   <idle>-0         3d..2. 703708us : mmcid_cpu_update: cpu=3 mm=00000000a22be644 cid=00000003

Now n-1 continues and creates the 5th thread:

[    2.105227] virtme-n-1         0d..1. 703730us : mmcid_user_add: t=00000000f2e4a8c8 mm=00000000a22be644 users=5

which makes it switch to per CPU ownership mode. Then it continues to go
through the tasks in mm_cid_do_fixup_tasks_to_cpus() and fixes up:

[    2.105368] virtme-n-1         0d..1. 703730us : mmcid_task_update: t=00000000c923c125 mm=00000000a22be644 cid=20000000
[    2.105509] virtme-n-1         0d..1. 703731us : mmcid_cpu_update: cpu=0 mm=00000000a22be644 cid=20000000

Itself to be in TRANSIT mode

[    2.105632] virtme-n-1         0d..2. 703731us : mmcid_task_update: t=00000000478c5e8d mm=00000000a22be644 cid=80000000
[    2.105773] virtme-n-1         0d..2. 703731us : mmcid_putcid: mm=00000000a22be644 cid=00000001

Drops the CID of one task which is not on a CPU

[    2.105896] virtme-n-1         0d..2. 703731us : mmcid_task_update: t=0000000031a5ee91 mm=00000000a22be644 cid=20000003
[    2.106037] virtme-n-1         0d..2. 703731us : mmcid_cpu_update: cpu=3 mm=00000000a22be644 cid=20000003

and puts the third one correctly into TRANSIT mode

[    2.106174] virtme-n-69        2d..2. 703736us : sched_switch: prev_comm=virtme-ng-init prev_pid=69 prev_prio=120 prev_state=S ==> next_comm=swapper/2 next_pid=0 next_prio=120

Here the one which owns CID 2 schedules out without notice, which is
just wrong as the above should have already moved it over to TRANSIT
mode. Why didn't that happen?

So the only circumstances where mm_cid_do_fixup_tasks_to_cpus() fails to
do that are:

   1) task->mm != mm.

or

   2) task is not longer in the task list w/o going through do_exit()

How the heck is either one of them possible?

Just for the record. The picture Jiri decoded from the VM crash dump is
exactly the same. One task is not listed.

Confused

        tglx



