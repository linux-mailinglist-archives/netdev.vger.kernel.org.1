Return-Path: <netdev+bounces-273712-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aET+IsUDzGljNQYAu9opvQ
	(envelope-from <netdev+bounces-273712-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 19:26:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D57C36EB4C
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 19:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 38944308785E
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 17:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6CC3624D4;
	Tue, 31 Mar 2026 17:17:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB91346FA6
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774977450; cv=none; b=UmM6GK2aTPU9YNHCCks+Q6v9+teKKlCV+4+fNqMg42we7yOjx5r8dYuncd3uL5AAJOFvSylzIizrFjfXOA6WNatNKE9NQvBCci9OX7Witi4lzB3R2wwBF4huVAA8jdXuxxdQGheSD7WyU9gShlugCis2sVNZV8jOtKl0vAGHjDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774977450; c=relaxed/simple;
	bh=Ij4NctXkH98k4D6pU+jIv/fxlb6S2F9PSm7irxHMGPo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=U1C3jLeSmTtx3xlry8GdTobTg0wGXhQWx8nfX7uPUzhu/ccsVtQmyNlWKTAiHOEHqfHOd7wxJMJxKMopnABEW7dHZhkr0QnKC0FzelD+CuKLy+W2dQREbgSrhP6vDKlDruKmB44/za3X/y4n0ncJTFw0xl/XrX/lH/HK3vRMuOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-7d7eb8cf3d6so21908733a34.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 10:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774977448; x=1775582248;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hteMWmC5zuwxY1wca9+Xqy4IWjKYX39OfCnF/7yj5mU=;
        b=c0tXvAmtPVs3b4HBOJ+E8ecKFoloWNSVHaq1TXeary6rtZa+C63pyaXrIAh2B6sSb1
         pYTbKFCKdy1XN1fffYFculW3F/99H4ka+L3QXUHLHIJ9Q2CadOzSMzWz9qJcnDrZJrCb
         9587IsZuKSqJoK5K+9wmU4Q7UzhAufPmsbRWhko8y2QfmOMC3c7EbUcAaSxtzYATrzze
         BYnXvi/zwQIAtIlO228rRBeFcwYi7MCyTlVKXyt9EdCZahfE/ze1YY2QDJxXf/d6B2Na
         IZ2dmBV+mXHpXp2gQtAFIAbk2kMSGc1KEyKnke5J6CSJ4mC2FG2tm66ghDa9/AA/aHE3
         lTPA==
X-Forwarded-Encrypted: i=1; AJvYcCVeXVdhbQpKr2f9Jth2CZM8M4IRe7zt5kYvb1URpv1jSWM06H3tyuGuV0Ct7hRko6CeL0a0nsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYAmwhOghyVk3MDJBgZodA5GSz9Ye/pPPxMtpbvtIeAuIOwJVN
	UIxMI6h8ik37PDm6nBvM36ofI0d0PkGHjgiIJUtgyT0WKQoBARN0UaNiWuQsSahKaWU1lfI36Vf
	jAg6myojCtqA2dkVWySmm3kwELyYNiWPDI0gGjW+i6n6r9T+7d3+jsQAanKY=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2d03:b0:67b:c122:d2c8 with SMTP id
 006d021491bc7-67fabc982c6mr14767eaf.39.1774977447940; Tue, 31 Mar 2026
 10:17:27 -0700 (PDT)
Date: Tue, 31 Mar 2026 10:17:27 -0700
In-Reply-To: <000000000000bd671b06222de427@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69cc01a7.050a0220.183828.002d.GAE@google.com>
Subject: Re: [syzbot] [net] INFO: task hung in tun_chr_close (5)
From: syzbot <syzbot+b0ae8f1abf7d891e0426@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, andrew@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, jason@zx2c4.com, jasowang@redhat.com, jhs@mojatatu.com, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	mail@country-targeted-traffic.com, netdev@vger.kernel.org, 
	newsletter@monkeydigitaldeals.com, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, vinicius.gomes@intel.com, 
	willemdebruijn.kernel@gmail.com, wireguard@lists.zx2c4.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=6754c86e8d9e4c91];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273712-lists,netdev=lfdr.de,b0ae8f1abf7d891e0426];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,zx2c4.com,redhat.com,mojatatu.com,resnulli.us,kernel.org,vger.kernel.org,country-targeted-traffic.com,monkeydigitaldeals.com,googlegroups.com,intel.com,gmail.com,lists.zx2c4.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.932];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,syzkaller.appspot.com:url,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,storage.googleapis.com:url]
X-Rspamd-Queue-Id: 4D57C36EB4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

syzbot has found a reproducer for the following issue on:

HEAD commit:    47ab2c12c87a Merge branch 'correct-bd-length-masks-and-bql..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=153aed02580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6754c86e8d9e4c91
dashboard link: https://syzkaller.appspot.com/bug?extid=b0ae8f1abf7d891e0426
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1286e8d2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=106df5da580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/289234295ce6/disk-47ab2c12.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b3f30eb7dc01/vmlinux-47ab2c12.xz
kernel image: https://storage.googleapis.com/syzbot-assets/62a0f5642c08/bzImage-47ab2c12.xz

The issue was bisected to:

commit 5a781ccbd19e4664babcbe4b4ead7aa2b9283d22
Author: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date:   Sat Sep 29 00:59:43 2018 +0000

    tc: Add support for configuring the taprio scheduler

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11535418580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13535418580000
console output: https://syzkaller.appspot.com/x/log.txt?x=15535418580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b0ae8f1abf7d891e0426@syzkaller.appspotmail.com
Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")

INFO: task syz-executor:5978 blocked for more than 143 seconds.
      Not tainted syzkaller #0
      Blocked by coredump.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:22400 pid:5978  tgid:5978  ppid:1      task_flags:0x40054c flags:0x00080003
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5298 [inline]
 __schedule+0x15dd/0x52d0 kernel/sched/core.c:6911
 __schedule_loop kernel/sched/core.c:6993 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7008
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7065
 __mutex_lock_common kernel/locking/mutex.c:692 [inline]
 __mutex_lock+0x7fe/0x1300 kernel/locking/mutex.c:776
 tun_detach drivers/net/tun.c:634 [inline]
 tun_chr_close+0x3e/0x1c0 drivers/net/tun.c:3436


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

