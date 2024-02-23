Return-Path: <netdev+bounces-74252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2978609B0
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 04:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F81CB26D29
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 03:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0557D2E6;
	Fri, 23 Feb 2024 03:58:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522EB8BF3
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 03:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708660684; cv=none; b=tBVg6BeNLWg7ILAB7dyZhk3eDNlaNjxXPijbMMU1Yfgp5Xq6GS3ob86x8O9ZuxQWuUI2VYOf4JUIw/vfh6j9ZOLRDE5VtQqBEuadR0hFZeFMGH+sqj2fyIleLPgdXzQucOfdsR7WdiO1XbLeJsAUMvU8xxbSj54YYcXsGDPpPII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708660684; c=relaxed/simple;
	bh=s+Yr8P+VZymK9qUi2vr1SoV91WEqxauNSC7lkuGa/xg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dUdNwvcZhb3JyK609oUyMcX2ljI8fZIRNedC6CzzA7RM4Kv1s9pUdcU9sQzAipXw8xSZH6QTjvIXRkdOko2RqNA3wHhTnPj/F2UxmBy81kSMHg+0/fC3/SbD6wJaYF+2OUKgZNUNnl/aweK33VlJH6yMsfWG4eztZ62bbw9TPMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363c88eff5aso3997345ab.1
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 19:58:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708660682; x=1709265482;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CVs5Oi5l1ePOylG0jUHhDMQMafgobc0WLkQhm+3MvSM=;
        b=wrfSFDivh3r75lFeW2EKFdW6oYBm5ejnCsAjH7nyXcyOW5DGNNrSqTZE0W1qOc06fh
         Hiiih7Q9criyWNJb7kR+n/zT7dEIpxnmZvnlmHa9kXI+jrCKFj1GTb/frt8U0kq6Tk93
         GNafug0nHJeB0oj6GqRbz94ld+VZb/Cn/K0SgKursmiznag5sIEFPyGnPHN+3ne6qbkj
         TQIZ2Zd4Vowhz2nG88XpN7KUmdKNmS5INgUjofcytQ9YzStHH9DHuiR9mypWfK0VhOj2
         p1RAPCu9i6K6SqWv6lPgVdneogddw9Gfli26ueuA4+l3C0Sqy7ySRlaeakl9JROCmlyk
         wS2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzZNvtfhW/JWV9U5e4+qIwQfDT5w/Jw/OfVjJchWbhoTxYr+f0XmXBRO3jYpyRWK0OBwKCPqBFbLurRJEfoqL4xrtiPtl0
X-Gm-Message-State: AOJu0Yw+Da/EC62NaxT356WlRWhuJ4IU8carA+uxtWhszCJhq0Pad5Vz
	N0YLXaCEx57gJYuJXMWdgtAhCMFDJQ906kLhoabD/Wh7yK/oRhD8sDQwl/GkcSxbXPBnMUkct+y
	o8O8q1/O3DeXt3BeQnkxi/GcHEgkMftu65E7Rd7IkWoyK99Fat1Lny5w=
X-Google-Smtp-Source: AGHT+IGlcRizHCRgaUTzalw5tG83myQ4oP0d1O6esy9NhIaiXm4C4MgMAuZpmVfWtX9Mughu91Y1G2V3x1iThJZHqYRsQqJAXxDN
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ee:b0:365:1611:5d5b with SMTP id
 q14-20020a056e0220ee00b0036516115d5bmr49958ilv.2.1708660682602; Thu, 22 Feb
 2024 19:58:02 -0800 (PST)
Date: Thu, 22 Feb 2024 19:58:02 -0800
In-Reply-To: <000000000000e8099a060cee1003@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000007401c061204919d@google.com>
Subject: Re: [syzbot] [perf?] WARNING in perf_event_open
From: syzbot <syzbot+07144c543a5c002c7305@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, eadavis@qq.com, irogers@google.com, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	namhyung@kernel.org, netdev@vger.kernel.org, olsajiri@gmail.com, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 7e2c1e4b34f07d9aa8937fab88359d4a0fce468e
Author: Mark Rutland <mark.rutland@arm.com>
Date:   Fri Dec 15 11:24:50 2023 +0000

    perf: Fix perf_event_validate_size() lockdep splat

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=157c509c180000
start commit:   5abde6246522 bpf: Avoid unnecessary use of comma operator ..
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f565e10f0b1e1fc
dashboard link: https://syzkaller.appspot.com/bug?extid=07144c543a5c002c7305
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ba8929e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17be7265e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: perf: Fix perf_event_validate_size() lockdep splat

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

