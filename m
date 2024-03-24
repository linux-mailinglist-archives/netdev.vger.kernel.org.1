Return-Path: <netdev+bounces-81398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F247887C05
	for <lists+netdev@lfdr.de>; Sun, 24 Mar 2024 09:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EF441C20EBB
	for <lists+netdev@lfdr.de>; Sun, 24 Mar 2024 08:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833AC15491;
	Sun, 24 Mar 2024 08:37:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0875B14A9F
	for <netdev@vger.kernel.org>; Sun, 24 Mar 2024 08:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711269424; cv=none; b=HP/NxiMS/E83zcKpg4/BGf/dgBFh2h24NzVo369HxEWnBwYz60u8Z4lUZbK2hDWLu6QHZKptP3pzId9MMW9SNypY/RlqxAJxYe4ert8XhqCOyxovBPJWXpFfoIKLx854kIHXRH+1BVXQxmmmf1pLrTjTmqfaqarXR2NR2mWeyxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711269424; c=relaxed/simple;
	bh=14tYmPQEs3CyHiGchvoFwUfgmSdjXsja0blVcdmRCBw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QWkW4w2u6Gw0wVKKCR2zTeipWldsm6utIkM5bYzyfAyO+DNZLwcy7KRmRReGEuEGVhN/v9Fr5w7UVNjVyLxKYqDW0+l57iGPR97u2IJFI8ms6Izb/SkGkPtT0l17C2ia0VKgvDCghSlOzusjmZSnhAzbzWftFtXFo6SiRZ0HozI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d0330ce3d4so194401439f.1
        for <netdev@vger.kernel.org>; Sun, 24 Mar 2024 01:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711269422; x=1711874222;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vHc+uNAqG9Tf2XkO9MeTOtdp6u8g7/un/HgEhAdVl8E=;
        b=WonAR317hBhOqBDsUCkWGYbc/1MT1OtpAXyB5RVLYYsAebCdpvRzKi/CiP9ISJgWZp
         lTLiGH5mVwAYx2/6FZBNQhupIfMr8ncbQvTBSAlLUfKFaLRLOnSswccpjBi9yQwiHO3g
         JLTq6sMAm82f5sm1UURrXYkjhHq0aZZ2bsR8fPP0UJWPsVIC9HIEqPWqOugg0CKJjp7K
         jAB2ykvslE/nRPEIVIlQxz0nOnRp+qxsbk1sioTtijzOw8h85E1fTB/uyQnZ5RvvfLZl
         kdKRllAn0F/ZOpG1VGQC557YU7d0oyNwO8o2XwXNqYS4v3vW2GPT/CU8bSIxTpF7pnaQ
         AZcA==
X-Forwarded-Encrypted: i=1; AJvYcCVu41DTENSkNAO4+/5h2u74F5OLuNEz9HYDpEiYQkOgW21Y8wO69vscRaZf7cATDeujTnVILLs/oaHX/iRiXs8MjnyMKaKw
X-Gm-Message-State: AOJu0Yxrl7PNUb5dgqPRKJsI9OoFH+ush0BfQZWOE1UOtqY/taXw/bQX
	KxAEZyANFo+CRoyP6Ri5yHB8ka32oYQMLC7ObD/L9qNliQymz6a8jNS7kQhIE3k37dKOMzyOpiD
	1pbgBhKGAVElV5m1xU65L9R96Er+q0nwC/mnW4YI4v+kEegONRbNi/Rs=
X-Google-Smtp-Source: AGHT+IFS5mwHGgQBIEGBw1W4MY+ckTv6PfgXdkx4mzY4libLgoQiChHN4YGf1+hVLBjB3Jvx9K+U+q4SkRzhqg6qe1socyn3uzBq
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:348b:b0:47b:fd8e:c03 with SMTP id
 t11-20020a056638348b00b0047bfd8e0c03mr206118jal.1.1711269422262; Sun, 24 Mar
 2024 01:37:02 -0700 (PDT)
Date: Sun, 24 Mar 2024 01:37:02 -0700
In-Reply-To: <0000000000007628d60614449e5d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000077c22061463f6f5@google.com>
Subject: Re: [syzbot] [bpf?] general protection fault in bpf_check (2)
From: syzbot <syzbot+ba82760c63ba37799f70@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	olsajiri@gmail.com, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 6082b6c328b5486da2b356eae94b8b83c98b5565
Author: Alexei Starovoitov <ast@kernel.org>
Date:   Fri Mar 8 01:08:03 2024 +0000

    bpf: Recognize addr_space_cast instruction in the verifier.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=101f5ac9180000
start commit:   ddb2ffdc474a libbpf: Define MFD_CLOEXEC if not available
git tree:       bpf
final oops:     https://syzkaller.appspot.com/x/report.txt?x=121f5ac9180000
console output: https://syzkaller.appspot.com/x/log.txt?x=141f5ac9180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=ba82760c63ba37799f70
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115671f1180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f14e31180000

Reported-by: syzbot+ba82760c63ba37799f70@syzkaller.appspotmail.com
Fixes: 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the verifier.")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

