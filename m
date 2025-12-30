Return-Path: <netdev+bounces-246295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 063A0CE8EB8
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 08:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CA3AD3002058
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 07:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED8824EF8C;
	Tue, 30 Dec 2025 07:49:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73791BF33
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 07:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767080958; cv=none; b=Th+P1DCkfqEzIDcA2AGZ/cEIM3uYvmkIick5XzlfsOdSyxvCmQEBwcLxqqYDX6F2s2ugfV4jcZy4NWGcqD7Y7ePQ0mEFWydB3qPSbz7WdUQ1cEDNBhaVCOCOmS36xogLGkKxo4CrIRu6WvM29jemy51Kxw8VrG8ysWmEcLFdXis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767080958; c=relaxed/simple;
	bh=vtNnPNhHcVUR7xr+bGQgPTq1AHS2tAMOUxRppIVNRAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Soapi/OcCWkitXBtF5XAIK13HmWzbSIKeHL53wWc8BWvGYjLJklthDmjuYopVNY9uGr2mEHOYuGFiI0Do1+R0ez9hbKy1NjAjr8bciUHCIEW8EsVdudp4b78eLzRvZzVl/LuJ7volsg4+/A8OuStanSKqgbhXCp7TuPGxXuE8PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5BU7mOGx091407;
	Tue, 30 Dec 2025 16:48:24 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5BU7mOw5091400
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 30 Dec 2025 16:48:24 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a127c251-5d62-47c5-8ac0-37a490ed0c37@I-love.SAKURA.ne.jp>
Date: Tue, 30 Dec 2025 16:48:23 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] INFO: task hung in new_device_store (5)
To: syzbot <syzbot+05f9cecd28e356241aba@syzkaller.appspotmail.com>,
        andrew+netdev@lunn.ch, boqun.feng@gmail.com, davem@davemloft.net,
        edumazet@google.com, hdanton@sina.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org
References: <694d6533.050a0220.35954c.0047.GAE@google.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <694d6533.050a0220.35954c.0047.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav202.rs.sakura.ne.jp

If we ratelimit

  "received packet on %s with own address as source address (addr:%pM, vlan:%u)\n",

message with up to once per 2 second [1], this problem is shown as "task hung in rtnl_lock".
If we ratelimit this message with up to 10 times per 5 second [2], this problem is shown as
"INFO: task hung in del_device_store".

This difference suggests that this task hung is caused by out of CPU time for making
forward progress due to spending too much CPU time for printk() operation from interrupt
context. We might want to ratelimit more aggressively.

Link: https://lkml.kernel.org/r/69533402.050a0220.329c0f.0428.GAE@google.com [1]
Link: https://lkml.kernel.org/r/695347ee.050a0220.329c0f.042b.GAE@google.com [2]


