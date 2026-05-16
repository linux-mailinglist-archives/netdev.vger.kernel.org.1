Return-Path: <netdev+bounces-288594-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QC+vE24WCGorYwMAu9opvQ
	(envelope-from <netdev+bounces-288594-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 09:02:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9FD55A8AF
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 09:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0BCC3013D55
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 07:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902D2305674;
	Sat, 16 May 2026 07:02:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB6B28469A
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 07:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778914923; cv=none; b=hYBKT5ZtDxO3TQXrWZQsg+YUiSi1dBHLNnfgLOS1t8BXsrfB5+E5/oeEcl7GP81wDImCy4j/q7PMGvt9Y7ArSKdnBmBpTu5Goojcs8sJF8PnZQ8xJe418z9V1BM/56+IMDzkX3P43Rc6NwNqACIBGBfgx4KECtTYLgrVOEZk9yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778914923; c=relaxed/simple;
	bh=Ho6piJ/gm3gK9gM2XT0JsD8hlZ2ZA+Gfocwk5xOK9Qc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HroHg3eC0YIRsXPu0Hn5JcWWbdUBKRW1aGSqLXSN5w1tp+j6abVcJZBGdyCHOaTf4r0T2zJSM7wSo+bkAB1n7GH4roVAiCuiUSQubhWENcuE0/PKiBUVDwTrG2SNOs6fj6QS58BvCRZNC691RcsjrHeqTTBiFmjwEnLd5ubeJK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-6853c2438b9so738487eaf.3
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 00:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778914921; x=1779519721;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iGYAY586adhJBQi99xwORuBeXunQTFFsqPhqsTYWim8=;
        b=F6nNdpr77l+mfjDB5NSRCJhJWQPqiKJPOGic4zE0JgnSjdtUJ/JgZ7YGyLLL8FaRNE
         LrR7/8fuYEMBif8OJKxifNEqQYeL+mqfJNzumqqI90Hp6BnK3sX4XklpPOoCGAMryulb
         AHzs/hcSOP93JN5YliETtY4IWm9dhNIJFU0H01VdidKOQEkPv/4OpuQFSS3oFGFVCrwO
         C1axA16kD/cVnZBfpvmIuC3pGAsb+GcJasLHHvAaUZlTsqn0p+YZldv9NuD6NuSHTEiN
         97doJgITLRAUJ67vjYV/1ZqK21lLSs/CVQ32bfol+nOWhoh41V+7ZOsOOyDBDX11KQbD
         PSEw==
X-Forwarded-Encrypted: i=1; AFNElJ8KLZjG5B6ANP8+x5metyJfx2yFM95eR2fl/WFVXRClZRqkuVOAaFcavJ5A08wJzEqPW0lgk0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMrgbrZUV0RTy59/EwnJ/ohdXHl/tZGT9/U7QJJYXRkQQxw0hC
	jQv3E1ijIkG2bkRxoYrx9JuL603abEn0MHry9rlTSv9j5Acc2J/vpr2YhzDMvFlMKcK7OWtBFzC
	8HbBO0fDHkipsVcUmZqsad9a8TWl7Z/5GEAfBqdwnEFVsX1qhEm97X+qJdS4=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:190a:b0:696:6f1f:3ee6 with SMTP id
 006d021491bc7-69c9bfe8963mr4626966eaf.53.1778914921213; Sat, 16 May 2026
 00:02:01 -0700 (PDT)
Date: Sat, 16 May 2026 00:02:01 -0700
In-Reply-To: <529b2910-24cd-45e0-9e98-0eb3085a6bc1@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a081669.050a0220.f80e4.0002.GAE@google.com>
Subject: Re: [syzbot] [rdma] general protection fault in kernel_sock_shutdown (4)
From: syzbot <syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, arjan@linux.intel.com, davem@davemloft.net, 
	dsahern@kernel.org, edumazet@google.com, hdanton@sina.com, horms@kernel.org, 
	jgg@ziepe.ca, kuba@kernel.org, kuni1840@gmail.com, kuniyu@google.com, 
	leon@kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	yanjun.zhu@linux.dev, zyjzyj2000@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 9B9FD55A8AF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=eeba87c808be946b];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-288594-lists,netdev=lfdr.de,d8f76778263ab65c2b21];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,linux.intel.com,davemloft.net,kernel.org,google.com,sina.com,ziepe.ca,gmail.com,vger.kernel.org,redhat.com,googlegroups.com,linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
lost connection to test machine



Tested on:

commit:         bb9ed28b RDMA/rxe: Fix null-ptr-deref in kernel_sock_s..
git tree:       https://github.com/zhuyj/linux null-ptr-deref_kernel_sock_shutdown
console output: https://syzkaller.appspot.com/x/log.txt?x=16617cc8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eeba87c808be946b
dashboard link: https://syzkaller.appspot.com/bug?extid=d8f76778263ab65c2b21
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Note: no patches were applied.

