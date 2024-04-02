Return-Path: <netdev+bounces-83900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D466F894B86
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 08:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 617D5B21515
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 06:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266A42556F;
	Tue,  2 Apr 2024 06:36:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EB4249E4
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 06:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712039788; cv=none; b=lo/lx0WMc58XpKkL+Nw+WR1mQTttzLjA9iXNkb8eaaHhKXTX8qYrnyTF4epctFpF6dMo3ZuxrHtMR+rJwISxtrvcPiaDkGinqW/g+p10LvVR2DI0r5drgrG+ELnCT/wAHIV2eSJvt0Ut7PHXtveBFxJKOi42Bydz3dcDQA+dcic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712039788; c=relaxed/simple;
	bh=UpNhgPX5pJk/ucZAJ9d2nkFuwOYtfcnkbRYGSoOgZQw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Mwj4yJDUcodzZafmyzHP2qQeJ67Vefq0X+jtVysZLidBaaLGQ5RW+ZcGQMA2AuTZ1ZxClT/E/9jAH695MCzIIZLQ2epXda52fOVe9PHs4MYq4D01ZgnlNKwXP5sycTRIq2IDfGi7ykLmm3YPRpDz9lbq47f7ZV2N89wqxngXeOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cbf1d5d35bso516607539f.0
        for <netdev@vger.kernel.org>; Mon, 01 Apr 2024 23:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712039786; x=1712644586;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lGgcl9N6u4wFnOxqWzVNRb0CjVaO5JkGiuxXchA0GQk=;
        b=HrgioRsBUk+Qk4I32Dg5fdtUfwZ4c/r9OjP17oX836wxF4d7nuqjRN/JBy7lJbKYUc
         3VCa8BhpMEjurZN5Jgd2ZHhTiKkqH2tLDHsQMJElZYSXbqJqq9aRHAskfVNEgSzwNWp3
         QlGBiCQ7a5Rgq9ofR0zTxisa5lho05lzIkAneqJdCENmNQLUPeO+eCJVQvgJanyViiZP
         9N3u2x8edzbjLNC7KAfGCaOcL9G92xlmCWdFjYNNO4Z9dr5z+NFmjzxvLdRpkfMPXU9z
         qPUEigduz7Z9TczjrlM8iHpZRXsfYjNNS84HuvChWh9H6ym4NALLW8ZNE/62MYSx3UCb
         DmvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJIMPNEMa8OKO/nhWAkAfjSaLt6uDq1RudQp8667bhb7oMOYQxmIbTK3+h+1XM/1yXd19SrQzl+BcipwIB+fDq5H7Gi1yo
X-Gm-Message-State: AOJu0Ywt1xEqpDBDLty5i7qIvPRI9iYT/FSMXx8KZxnXRHHV3PwSOMwB
	t4tJjCwcSAn6ehhX/pkBq6fmC6IX7i0SwQ/uogkuyIEuZx20T3up6TLrDEhK3CtuyZjdb6ThkYB
	n4uKQMVK5h5Y9Z7lvzegtSi/suisEGxQcgrXhKXAQRsDGw5AmDcp/pmA=
X-Google-Smtp-Source: AGHT+IEYEj6d0xT19iBjCW1jFVxSMYZmKm6iRawu+ptTIk8DytC+tb2aDqS3iXamWTGcIVzecHQ6ajlR7ZhU3e8ZqeewW08gnmN3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2b07:b0:47e:c09b:69e with SMTP id
 fm7-20020a0566382b0700b0047ec09b069emr472329jab.0.1712039785822; Mon, 01 Apr
 2024 23:36:25 -0700 (PDT)
Date: Mon, 01 Apr 2024 23:36:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000468fff06151753a0@google.com>
Subject: [syzbot] bpf-next build error (6)
From: syzbot <syzbot+1f0620b0141e43a84282@syzkaller.appspotmail.com>
To: ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e478cf26c556 Merge branch 'bpf-fix-a-couple-of-test-failur..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=168bc92d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7b667bc37450fdcd
dashboard link: https://syzkaller.appspot.com/bug?extid=1f0620b0141e43a84282
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1f0620b0141e43a84282@syzkaller.appspotmail.com

failed to run ["make" "-j" "64" "ARCH=x86_64" "CC=clang" "bzImage"]: exit status 2

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

