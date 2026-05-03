Return-Path: <netdev+bounces-283605-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFDRJ0RH92k+eAIAu9opvQ
	(envelope-from <netdev+bounces-283605-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 15:01:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 316FD4B5D99
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 15:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 523CD300C01F
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 13:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAA93C063B;
	Sun,  3 May 2026 13:01:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B916214813
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 13:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777813302; cv=none; b=EZYWN7VxbxQECk6xOGmN54kq+B6WXyRJinmxrc/dSFIzjmjR4zmpsQBWbvrscu7hZDip9vHQIk6tWy0c+0fAfWrCsqb3JtMUwKQvq+SdBvlwUCX+ECO/533LT5ezqSP2SGCRi7D5reN2REjsNrwcSDfV5JYaBoxqCs7Lw51Wslg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777813302; c=relaxed/simple;
	bh=4MyYuVobEooc7FlZ5RoUcpNWyRLHs4oRHgebplPcyR8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=N8EipmBpI4KfzImMsWoigF9Ond21me+/gOxXaEVaLGiXXGzVVBK7GBaqG0UQLmsRdEs3k8xWaU0uV22XGU2SZw6hRgv8qMzX1aaAaOvJUFcMMEJncQmAh7M96dAGSdkj03Es3y/kBRnVTRIqfJA3KK9gftAiDQz3rna6zCLaI/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-6947f168159so7527909eaf.2
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 06:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777813300; x=1778418100;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yA1yMAU0O+AvA9ZFzwU3JwYNJuEbLK2TSEVxoN0Rp2Y=;
        b=k1LpF6REUd5lrj9f+ogNTeXWN/tCwPf2BL2mP5V17hb0s8oTBw+GBLyDcR83tjQk7/
         1WhNqChOT/BwFSLCQpXFT6l10HaC0+vYrXJigedfSnz+THVMnXlKDlJo4dwWM5BGBY+G
         sDVLQLOn5EdXYR6UXA8U/HRApZrddNhcaj9LwkGkrxDhCIuw9tmbDQnXlHEfD4IsGzAv
         y3/jkEpjmT3p7P3gZ30RXcBUyRjXJaqduXJ+T4EMeZLNal2Vu0IO+GPVkbcI6UmOeTQz
         owIMp33T4/qO6qVdDQABfZ7mpKatmoUbVIc3JoGjHnEtYtPSzrI6XTZ1CiBSs0Wt2Oyl
         qPxw==
X-Forwarded-Encrypted: i=1; AFNElJ+NInqx/sqmYe/Pcg7IaqecDc4sanzYnht6eLs1ylC5zJOSoD52xjAeUZvw/AcgTIarCuLyOjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR3PSt9vezISzYfkTtbpFbcu7QTujXRUZavL4A1qX/ldGF7KZi
	VLpXFF/iyzKkC3Zhv/TW4Ub3q2F7moFcZaY6YkZu7KBTN0BiROKJ7VNX2yt+EcSHb4FlH3O2Vhl
	MACorAO3hedRk/0Q8T9mZMkzsPoMMIgSytZuIEwRiV4XML3wzzv4acLxenmM=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:211:b0:696:8278:c619 with SMTP id
 006d021491bc7-696979ad7d2mr2963413eaf.6.1777813300089; Sun, 03 May 2026
 06:01:40 -0700 (PDT)
Date: Sun, 03 May 2026 06:01:40 -0700
In-Reply-To: <69f44505.050a0220.3cbe47.0008.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69f74734.050a0220.312cd3.0033.GAE@google.com>
Subject: Re: [syzbot] [mptcp?] KMSAN: uninit-value in mptcp_established_options
From: syzbot <syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	horms@kernel.org, kmta1236@gmail.com, kuba@kernel.org, kuni1840@gmail.com, 
	kuniyu@google.com, linux-kernel@vger.kernel.org, martineau@kernel.org, 
	matttbe@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 316FD4B5D99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=1c3f61154f3bb7e5];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283605-lists,netdev=lfdr.de,ff020673c5e3d94d9478];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,gmail.com,vger.kernel.org,lists.linux.dev,redhat.com,googlegroups.com];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url,storage.googleapis.com:url]

syzbot has found a reproducer for the following issue on:

HEAD commit:    66edb901bf87 Merge tag 'v7.1-p3' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1086da36580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c3f61154f3bb7e5
dashboard link: https://syzkaller.appspot.com/bug?extid=ff020673c5e3d94d9478
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1260fece580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9014c04fc561/disk-66edb901.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a96b1e11a924/vmlinux-66edb901.xz
kernel image: https://storage.googleapis.com/syzbot-assets/680236de6331/bzImage-66edb901.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in mptcp_write_data_fin net/mptcp/options.c:542 [inline]
BUG: KMSAN: uninit-value in mptcp_established_options_dss net/mptcp/options.c:590 [inline]
BUG: KMSAN: uninit-value in mptcp_established_options+0x112f/0x3530 net/mptcp/options.c:874
 mptcp_write_data_fin net/mptcp/options.c:542 [inline]
 mptcp_established_options_dss net/mptcp/options.c:590 [inline]
 mptcp_established_options+0x112f/0x3530 net/mptcp/options.c:874
 tcp_established_options+0x312/0xcc0 net/ipv4/tcp_output.c:1192
 __tcp_transmit_skb+0x5dc/0x5fe0 net/ipv4/tcp_output.c:1575
 __tcp_send_ack+0x967/0xad0 net/ipv4/tcp_output.c:4499
 tcp_send_ack+0x3d/0x60 net/ipv4/tcp_output.c:4505
 mptcp_subflow_shutdown+0x164/0x690 net/mptcp/protocol.c:3137
 mptcp_check_send_data_fin+0x31b/0x3d0 net/mptcp/protocol.c:3218
 __mptcp_wr_shutdown net/mptcp/protocol.c:3234 [inline]
 __mptcp_close+0x860/0x1360 net/mptcp/protocol.c:3313
 mptcp_close+0x42/0x260 net/mptcp/protocol.c:3367
 inet_release+0x1ee/0x2a0 net/ipv4/af_inet.c:442
 __sock_release net/socket.c:722 [inline]
 sock_close+0xd6/0x2f0 net/socket.c:1514
 __fput+0x60e/0x1010 fs/file_table.c:510
 ____fput+0x25/0x30 fs/file_table.c:538
 task_work_run+0x208/0x2b0 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0x306/0x1b60 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:238 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 do_syscall_64+0x236/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable opts created at:
 __tcp_transmit_skb+0x4d/0x5fe0 net/ipv4/tcp_output.c:1536
 __tcp_send_ack+0x967/0xad0 net/ipv4/tcp_output.c:4499

CPU: 0 UID: 0 PID: 5905 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

