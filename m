Return-Path: <netdev+bounces-245555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F103CD18B2
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 20:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3925D3025A64
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 19:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9420227F754;
	Fri, 19 Dec 2025 19:06:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0032A78F3A
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 19:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766171185; cv=none; b=LusdlbyE4lSqnfzx/dV/KBSNBCnURkUQqGn/QVghDoCHCg3VJ/VRGAuoJsj7eBU5OY1sxlFhlG6Xt1671J5fh5cngdHakVLMlFVYUPvSQYyBhTSvh7pGSk7Qy7UytUmYk2K2KRYPCQ4o0sE3NmiXELhPUphVQWml5AtlmSX1yPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766171185; c=relaxed/simple;
	bh=ZXBYuFjKOlnbNNzA5W+Wu/Px5Y7AiOMjVXAj5q9Mppc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KLmnd7UScAsxe2vxdXPc9ZXXCQQmo00fXFJqkvBWpSjYmYK7nHnC71Y8vDHA4g0nbv0ogdzh3vDuPKRBpn04hrKkNqaYVwZFN7un0qKOnmWZBzg0aP03PHUXEBDQw/mU9/PqZPPbDbvWpix11ZIrZkhSgXiXFz+PID122HQVFps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6597c6a8be9so3694271eaf.0
        for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 11:06:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766171183; x=1766775983;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e/Oq5crcH8JUHCaRDZiBV0HlLww21wu+/yplBm+zYxc=;
        b=eb5rQBoalU+nPkvqvKHTaJmZe87okdjf8nfsykro/ST6HxI0pFquAJhjE9zbIZQEbz
         5FWf7axoXbbu04ORZobBffvbYbR9yGCtY6M8k13XwyxDg07IQoi5lb6r/UhNS8fmQm22
         yROoGbze9rHz/7cjQWCloNBo8Y1dBKO0Q5ccDzuDlIPM+WD2No8mMrvHfYYjoryTrSRL
         oNk5pC9V8KwB7wZaTnKk/80+lZTPlJqVv/c4ia+01f1FLHcS5x2bQ90A1Kp1prT84y95
         HM4Nv9IrkzLoggCdRhbF7zedU48c9Ca+0Tv2LOohAoCzaGlXOy6zDo2VDlvT82fmvVbr
         YjmA==
X-Forwarded-Encrypted: i=1; AJvYcCWVnRyaWjNLBTX8EWOoS6GoK4HAZpG/Fj90jHs6/y7gxA2ZB7HdV4UiDE6zGDXCe2ZQKkS4vLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPUX7EeFYyr7QlQSr8fhiMm2y4zI+WIjSxH/Ky7MSWitGCZMsh
	3J78IUMIdJ1TuUla/6Fo/NVEvyriwOQ5Bh+GsSxAj7gXpTvz8YSp3zxXajEKej9cZ5KlvLTSXAq
	nbM1VHVUxfpWbd5eREmvbQi2jkcAXRu1RMS8OA0P9BMNA/P9vf332DX62QPU=
X-Google-Smtp-Source: AGHT+IFQzF7y4Et5r2AuQMnixLQkGFj7bjNy/5ynkz3924NMJawGqNwpKsLEsmB8nRcxREtBEl0B79inoXZr53u3rGzFL9qKhQ8Q
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:d744:0:b0:65c:f062:bdde with SMTP id
 006d021491bc7-65cfe799322mr2375186eaf.36.1766171183065; Fri, 19 Dec 2025
 11:06:23 -0800 (PST)
Date: Fri, 19 Dec 2025 11:06:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6945a22f.a70a0220.207337.011a.GAE@google.com>
Subject: [syzbot] bpf build error (5)
From: syzbot <syzbot+876eead1deeef9d14785@syzkaller.appspotmail.com>
To: ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ba34388912b5 bpf: Disable false positive -Wsuggest-attribu..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=111cb11a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9e5198eaf003f1d1
dashboard link: https://syzkaller.appspot.com/bug?extid=876eead1deeef9d14785
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+876eead1deeef9d14785@syzkaller.appspotmail.com

failed to run ["make" "KERNELVERSION=syzkaller" "KERNELRELEASE=syzkaller" "LOCALVERSION=-syzkaller" "-j" "64" "ARCH=x86_64" "LLVM=1" "bzImage"]: exit status 2

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

