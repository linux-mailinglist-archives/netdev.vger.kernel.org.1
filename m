Return-Path: <netdev+bounces-175023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F12A6274C
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 07:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE193BB5E5
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 06:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E3319F416;
	Sat, 15 Mar 2025 06:27:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F7C19F121
	for <netdev@vger.kernel.org>; Sat, 15 Mar 2025 06:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742020025; cv=none; b=WjOqEQj8CU6m9NyAGDbi0GBVMU2LKZLmSyXGOTqr8zrcW78Iipjo60IU5QDil+fiSfDm15BUMzcn7MFrcrN7QBovUSO/UajYWPOQkIgknAk9TUOdQ4bo9a4hMtD3I5UkPGaqJZG/Lg79bmfLoXKnRKTTBlnoYrSkpTmgA42RYiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742020025; c=relaxed/simple;
	bh=8c8BP0ZMGpck2i/dkvXUZ8GUM3AehfiBO2W2XuuOlrs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=obZCGXP7vnO4vtYwF4J4MRdGqpIZ4Gw6+nbkAfkrm56JtdjwNHU+C4287SLhkmnjeYWynbRufEBriRfMLgxmH1Wri9Co91tKV6aTMLwtwVqqjAYOOh3r6Oufhv3PxOug1LL7qUvlrmy94B0G886aiheKA/XPEpKKZikCXtUvDTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d44dc8a9b4so33188365ab.3
        for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 23:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742020023; x=1742624823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iVtpvCBBSFNWY2hi10N0rrWtsxl0Zv5MnCY1nXMRHOg=;
        b=YOZqStvHYCu0XxjZFyNEp2aFfnX2+9/pT6V4c9N6biju631mpyeynviqEgIONElvgq
         YqVF1bxictWooLZrJDzPnKueLl4kMCRSQ6Fh1HsngcWNy37mxNv2igTZn9DKU+ZPGRMn
         wHiByOtoYPqCx4OcI6lGysePoeCIjfBBcQnwWI4gaXag/XIL0iG1aSvRknCC8+sczEcO
         XtcE/Aa43srUPcCXehmbNbQyuJxvAiY4r8+OhAnSnC15F241sF4x7RWfOy9Q7CnX5v0R
         AZESsdpZEtcXU6+X346QPCG3tO0L91EzuuqewzVLaU7GwF8OSRL69Pt7Ky7IhD8bHtgE
         cBbA==
X-Forwarded-Encrypted: i=1; AJvYcCVIUD4SDkc8TwUgTiB7KNc+g/p1tD3OJYssyh8a/NARAR+xleCgu5XezR9i0kf/KyP1RCdbkzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuYLyh0V2xQjp48cpkxdFHtmXjmqrN0Ot8X33SMPCX8cND0Gep
	R/OGUH3VaPM/RHsCqc10cE82GsKwsEjlx0/Ng+PObX8oWTLEWRVDV4ztTiaZ3MZmQ5cIdGCQ9gm
	ebW70QuqQoTs5RVrmQq7nzh1R16u+WCQGTVu9N9aKWtM+QvWes0YM/XE=
X-Google-Smtp-Source: AGHT+IHc/Hlt9d/2Xcr2kHdqr9oeeMai8KZOoyvDaGLKjBOLJUUUPVjAKnMWCJKX9sd5n0l/KK74b5/g18o59nKXQM7eSaHz3zM5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d06:b0:3d3:fcff:edae with SMTP id
 e9e14a558f8ab-3d4839f5d33mr41770635ab.3.1742020023054; Fri, 14 Mar 2025
 23:27:03 -0700 (PDT)
Date: Fri, 14 Mar 2025 23:27:03 -0700
In-Reply-To: <20250315055941.10487-2-enjuk@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d51db7.050a0220.1dc86f.0002.GAE@google.com>
Subject: Re: [syzbot] [bpf?] KASAN: slab-out-of-bounds Read in atomic_ptr_type_ok
From: syzbot <syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, enjuk@amazon.com, haoluo@google.com, 
	iii@linux.ibm.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yepeilin@google.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com
Tested-by: syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com

Tested on:

commit:         2d7597d6 selftests/bpf: Fix sockopt selftest failure o..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1397704c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7bde34acd8f53b1
dashboard link: https://syzkaller.appspot.com/bug?extid=a5964227adc0f904549c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1188ae54580000

Note: testing is done by a robot and is best-effort only.

