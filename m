Return-Path: <netdev+bounces-200243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B54AE3D18
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 12:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 068DC3BAD30
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 10:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDD823C4FD;
	Mon, 23 Jun 2025 10:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtM+ykPv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C5C1519BC
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 10:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750675273; cv=none; b=MV0obQvVKbvQiGkAmPZoyD0/X1mPEvhDEDXaCeXRYQOvyUZpe3FZNAJJnIXqDJpNCxQWgYr00xFp1QfEegtqSew5/Kzir4NYOWS221/hFahqb2cVyv1H29WKEZ/TGodLYwaEQAzgU7dVV8DmY29ELfd2kcu4VUVHWODdSexqDGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750675273; c=relaxed/simple;
	bh=pXkQXqQf/MCeHB7cX4khXkkljSpSZuJSiq3Xst9484o=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=USwvBdAAm/6F3aYp7pmOUHZ+cqIhwkWS6M0onVLVbpoyWDA2gtF7mD3YcGx8XIJKvefcqiVEv1STdtaJFhf5ivy9hj126SXOCBtyqgcNdruIyJG5XWH7lyqJfsjxRhjfXHH5LE967vxh8LwmbvTWmYHN53+QwWgVTGelVyohv4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtM+ykPv; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ade58ef47c0so823228866b.1
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 03:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750675270; x=1751280070; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfWO6S5DXmSHsiQ67nYNa8LgltjfPDkbJ9Mrozj1Dhk=;
        b=mtM+ykPvTvv5AMq10qwdE4dMZTEf+bLA0HkJvZnmjnobtN+YqvsJ8JoMTGc9cfOep8
         df621PGXdoo6xLYtN6I1n8TAn3jdJ5R00zFCcPzg1JU/n02eEpRzggr0cfJwGUm6pVoH
         gTcGXiGN0jzz8ZARav162c0ui3n2MudqXTaqVS85CqssVzK+1lqL5f06UBPQENCRxYm1
         hqLiFveOBDHjJcRrKZJw2l+UDyebXlZiSGWL1ojMSo6Fb6XKoOKn2zxAvUkuaSjxfLfe
         ExMHZof+CLEXISPfcwD83QvdRT7vadIOdfg20ip4A6n3o+IqEmhihhFPebdoBi8n3qS+
         P53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750675270; x=1751280070;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GfWO6S5DXmSHsiQ67nYNa8LgltjfPDkbJ9Mrozj1Dhk=;
        b=t16rruXv0XoJi5nJg0S3vWCurqgSZAiMhnPJcV7Ql53Q/ZlpCmtPjWqYr+J3pAoACF
         9OeN7iUo0vP1b8QSAvybUNfn7sHz9xVnfTLMaSIeVWSTl1NomFVmjNm1IqXOf17Q5//H
         zTrwQlwHwLmokCgluTGoPqQzZbSXL4za4A6Vj2yl5X/lEmuP2VfC073DlenvwRqUvHt1
         ExtN040HlqKR7/eC0Ue4JzpjLkJTs6NPYdjEHvSO4rshnKCLUQRMSewzmQhYqpuAMh4T
         nBhfdDl+i/wzUqUv5l2WIDTGf7AZhBDtG/wPlRq1nZdjin20Q8fUm8yOVb9szBdi96K4
         yIiQ==
X-Gm-Message-State: AOJu0YwBIVYhLBfyC//Yv2A3wKbWAzOpA0T7H9YZB8mV6vLMAvAx/OEe
	7kuemCdxAgc6vQWWTVNEqRP2Kb6WqTgPz2zjaPa2DsdEX9Hohe3RbkDp/iO+4iYA7+Y=
X-Gm-Gg: ASbGncvJyghsVUA0cKgUfrDga5qfFw7FKnunBXYSYFjYr9DYCQVYLivWd3HEY2VE60Q
	FRI5F6+AnvtbrSQOm8dfaS3ppCsL1QreNFcoX1yilwhwOF3IuBgblNRfPP21DPdHEFc/R1X0Sp2
	X4IyERyBRd118GhTOEgn6+bKEyN1Ne5AYwjJ/DR9FEyYLcX3XNfr/trQMWxnrTvEs7J6hfJck0W
	7lng4wO+ttej5q8+75hjmbcYvT28cMo6/FqLueW1F0ithCM+nFsDpS72p89En6E7Tnfb0NZVW3U
	1bGiWSmnmKO8A0HztkJk8ltxReqL2sJr0pEpVkv9ROKDIANvIKvKJ0DmYVCjH5dGNMEV4EJhidT
	TJH3cATkeE6ZQWIT5y9hE/ntTnCadeVe6rttjC4l+trUPWgo6/Kq3EYllWKaeLWwNnIxAcGKjCx
	FesBYaCVXN0TIqRHg=
X-Google-Smtp-Source: AGHT+IHNuyVht3gwZ+3EAcj1cR0bqN95K+nbjpFgv050B34QO+5F4jqz2PUueSN2Pz1mmBjIGl5dDQ==
X-Received: by 2002:a17:907:6091:b0:ae0:533b:3048 with SMTP id a640c23a62f3a-ae05adfbe49mr1097963666b.3.1750675269810;
        Mon, 23 Jun 2025 03:41:09 -0700 (PDT)
Received: from ?IPV6:2003:ed:774b:fc62:b2f7:7717:f675:c1e1? (p200300ed774bfc62b2f77717f675c1e1.dip0.t-ipconnect.de. [2003:ed:774b:fc62:b2f7:7717:f675:c1e1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0541b7258sm686088766b.119.2025.06.23.03.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 03:41:09 -0700 (PDT)
Message-ID: <45876f14-cf28-4177-8ead-bb769fd9e57a@gmail.com>
Date: Mon, 23 Jun 2025 12:41:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
From: Lion Ackermann <nnamrec@gmail.com>
Subject: Incomplete fix for recent bug in tc / hfsc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

I noticed the fix for a recent bug in sch_hfsc in the tc subsystem is
incomplete:
    sch_hfsc: Fix qlen accounting bug when using peek in hfsc_enqueue()
    https://lore.kernel.org/all/20250518222038.58538-2-xiyou.wangcong@gmail.com/

This patch also included a test which landed:
    selftests/tc-testing: Add an HFSC qlen accounting test

Basically running the included test case on a sanitizer kernel or with
slub_debug=P will directly reveal the UAF:

    # this is from the test case:
    ip link set dev lo up
    tc qdisc add dev lo root handle 1: drr
    tc filter add dev lo parent 1: basic classid 1:1
    tc class add dev lo parent 1: classid 1:1 drr
    tc qdisc add dev lo parent 1:1 handle 2: hfsc def 1
    tc class add dev lo parent 2: classid 2:1 hfsc rt m1 8 d 1 m2 0
    tc qdisc add dev lo parent 2:1 handle 3: netem
    tc qdisc add dev lo parent 3:1 handle 4: blackhole

    # .. and slightly modified to show UAF:
    echo 1 | socat -u STDIN UDP4-DATAGRAM:127.0.0.1:8888
    tc class delete dev lo classid 1:1
    echo 1 | socat -u STDIN UDP4-DATAGRAM:127.0.0.1:8888


[ ... ]
[   11.405423] general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6b83: 0000 [#1] PREEMPT SMP NOPTI
[   11.407511] CPU: 5 PID: 456 Comm: socat Not tainted 6.6.93 #1
[   11.408496] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-4.fc42 04/01/2014
[   11.410008] RIP: 0010:drr_dequeue+0x30/0x230
[   11.410690] Code: 55 41 54 4c 8d a7 80 01 00 00 55 48 89 fd 53 48 8b 87 80 01 00 00 49 39 c4 0f 84 84 00 00 00 48 8b 9d 80 01 00 00 48 8b 7b 10 <48> 8b 47 18 48 8b 40 38 ff d0 0f 1f 00 48 85 c0 74 57 8b 50 28 8b
[   11.414042] RSP: 0018:ffffc90000dff920 EFLAGS: 00010287
[   11.415081] RAX: ffff888104097950 RBX: ffff888104097950 RCX: ffff888106af3300
[   11.416878] RDX: 0000000000000001 RSI: ffff888103adb200 RDI: 6b6b6b6b6b6b6b6b
[   11.418429] RBP: ffff888103bbb000 R08: 0000000000000000 R09: ffffc90000dff9b8
[   11.419933] R10: ffffc90000dffaa0 R11: ffffc90000dffa30 R12: ffff888103bbb180
[   11.421333] R13: 0000000000000000 R14: ffff888103bbb0ac R15: ffff888103bbb000
[   11.422698] FS:  000078f12f836740(0000) GS:ffff88813bd40000(0000) knlGS:0000000000000000
[   11.424250] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.425292] CR2: 00005a9725d64000 CR3: 000000010418c004 CR4: 0000000000770ee0
[   11.426584] PKRU: 55555554
[   11.427056] Call Trace:
[   11.427506]  <TASK>
[   11.427901]  __qdisc_run+0x85/0x610
[   11.428497]  __dev_queue_xmit+0x5f9/0xde0
[   11.429195]  ? nf_hook_slow+0x3e/0xc0
[   11.429873]  ip_finish_output2+0x2b7/0x550
[   11.430560]  ip_send_skb+0x82/0x90
[   11.431195]  udp_send_skb+0x15c/0x380
[   11.431880]  udp_sendmsg+0xb91/0xfa0
[   11.432524]  ? __pfx_ip_generic_getfrag+0x10/0x10
[   11.433434]  ? __sys_sendto+0x1e0/0x210
[   11.434216]  __sys_sendto+0x1e0/0x210
[   11.434984]  __x64_sys_sendto+0x20/0x30
[   11.435868]  do_syscall_64+0x5e/0x90
[   11.436631]  ? apparmor_file_permission+0x82/0x180
[   11.437637]  ? vfs_read+0x2fc/0x340
[   11.438520]  ? exit_to_user_mode_prepare+0x1a/0x150
[   11.440008]  ? syscall_exit_to_user_mode+0x27/0x40
[   11.440917]  ? do_syscall_64+0x6a/0x90
[   11.441617]  ? do_user_addr_fault+0x319/0x650
[   11.442524]  ? exit_to_user_mode_prepare+0x1a/0x150
[   11.443499]  entry_SYSCALL_64_after_hwframe+0x78/0xe2


To be completely honest I do not quite understand the rationale behind the
original patch. The problem is that the backlog corruption propagates to
the parent _before_ parent is even expecting any backlog updates.
Looking at f.e. DRR: Child is only made active _after_ the enqueue completes.
Because HFSC is messing with the backlog before the enqueue completed, 
DRR will simply make the class active even though it should have already
removed the class from the active list due to qdisc_tree_backlog_flush.
This leaves the stale class in the active list and causes the UAF.

Looking at other qdiscs the way DRR handles child enqueues seems to resemble
the common case. HFSC calling dequeue in the enqueue handler violates
expectations. In order to fix this either HFSC has to stop using dequeue or
all classful qdiscs have to be updated to catch this corner case where
child qlen was zero even though the enqueue succeeded. Alternatively HFSC
could signal enqueue failure if it sees child dequeue dropping packets to
zero? I am not sure how this all plays out with the re-entrant case of
netem though.

If I can provide more help, please let me know.

Thanks,
Lion

