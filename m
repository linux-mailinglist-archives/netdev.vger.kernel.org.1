Return-Path: <netdev+bounces-138035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3589ABA32
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 01:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3908B23383
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 23:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EF01CDA31;
	Tue, 22 Oct 2024 23:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StHULVOk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD67126C05
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 23:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729640924; cv=none; b=AOfn73yD3mYCqxbwEehJG8Hsp7cV1EIv73d2U5wFfTAmC+N+Cd3ENFJBL+UA5Fg/mjkvvpxtOIZMu/zltK1q3cuLspDjXD7S5HLmccvIiHKLulJN04P4vsaoAeVoZBXAbXQKxxrM/v6I4fq6fXlqnr9A2/9Y3PabmsejpSX334c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729640924; c=relaxed/simple;
	bh=O/C2tt/vbPg/7Zdt2deB3DXLacJ5kmLrp1m6GlDIwBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtvvolYZq7Jby2lsRL+/VjFpmW4mamWAOMt7YW5kBbF7CCoYc97Mpw1U7YvxwBCou3xtrXaxwPTDsyvk3NNFMAfsCmlKdKaeKVQ9i91O2LQG3bpOSY1dZUQJibcVOjmBgkiCjeP9R5vNeveNUW1z0/XJpbDGAp5xWzyBUX0VPsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StHULVOk; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cdb889222so60169865ad.3
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 16:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729640922; x=1730245722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FpjvS1cvlxUM8Y6aXSC1BUNUoWyBAZWfWnPntWmHohE=;
        b=StHULVOks+IhQAfpcTj8sVwdJaxI085AERfFo3/5iHxSjBLGhGX61a2nZgTAdUlAnv
         7hb6hhVjqw7QY9ozGczlyEFuXUCSGMZP2zk3VjN8o+z2kC4vOjxUnow7GM1d1iiaC6PN
         ryf3RDqJGAmbenjCHobUERDfrxjWBELqL4Qkfk8gqnR7o7v6CWFCrEMZDSOw/AM6AzjA
         TMAdnmdFUKzUYcMKCbWsmeAMmUQGNYWtzD/YKUbhojguO/dDK8cEAg96MBHgzJTzQ5sx
         pOPLYWY3H+0tG+S6JkDjNAOH95wQHqTN4khjqrhWdj9kBrnAyLMlbiIYh5hQcQvrPIhp
         YD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729640922; x=1730245722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpjvS1cvlxUM8Y6aXSC1BUNUoWyBAZWfWnPntWmHohE=;
        b=vVxATQs49Umr/xTOG9K0UDZAz6Mm4YYlBkgvlFAuCVyxwmWbUfgQFb4bxFHpsdezql
         v2WP509ysEPK7etviZQalIK3IbjNd5SAmLCYTbqGH3Fz3cETjL15Zts+TD9zGXwOBiCx
         D8HM9uQozqORjjBDbZ3+ZSSh+VI96szCkPmDfH9mKYZHkD/NgIAPQilW5xKxasEhzoTJ
         qffzU8DkVccbQLtEtXYO8Ao1LwIKY0bYiQvJVhxZ3CSx3vD/QpfttKTub7Jm8PSVB7MA
         ArAI9lZgEKEGEpLsNSga85gZ8YLA3EtkMi6O2eSlBxFTVrUaJqy7nWvAqXsFVldBB2X/
         f5mQ==
X-Gm-Message-State: AOJu0YxuKBAO3dZUeSw2UonyOHH88J3pV7qqRzBVj00tLmY3QF7wFp4K
	PaY7JoGdq7SsRntwuH86Y91qUalLyVqAatDeHsEAbIrkBjwtGpc=
X-Google-Smtp-Source: AGHT+IFXQQI4Vq1zIhWb8y5to6QIAYFd0jKPwR9uPsDpGtbv7V4q6YKciuu3gML7moWRlew9YL/2Gw==
X-Received: by 2002:a17:902:ce8a:b0:20b:b5d5:8072 with SMTP id d9443c01a7336-20fa9deb317mr12063295ad.2.1729640921883;
        Tue, 22 Oct 2024 16:48:41 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7ef0e74asm47955645ad.77.2024.10.22.16.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 16:48:41 -0700 (PDT)
Date: Tue, 22 Oct 2024 16:48:40 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Gilad Naaman <gnaaman@drivenets.com>
Cc: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH net-next v7 0/6] neighbour: Improve neigh_flush_dev
 performance
Message-ID: <Zxg52Ccb8FF8MCt0@mini-arch>
References: <20241022134343.3354111-1-gnaaman@drivenets.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241022134343.3354111-1-gnaaman@drivenets.com>

On 10/22, Gilad Naaman wrote:
> This patchsets improves the performance of neigh_flush_dev.
> 
> Currently, the only way to implement it requires traversing
> all neighbours known to the kernel, across all network-namespaces.
> 
> This means that some flows are slowed down as a function of neighbour-scale,
> even if the specific link they're handling has little to no neighbours.
> 
> In order to solve this, this patchset adds a netdev->neighbours list,
> as well as making the original linked-list doubly-, so that it is
> possible to unlink neighbours without traversing the hash-bucket to
> obtain the previous neighbour.
> 
> The original use-case we encountered was mass-deletion of links (12K
> VLANs) while there are 50K ARPs and 50K NDPs in the system; though the
> slowdowns would also appear when the links are set down.
> 
> Changes in v7:
> 
>  - Fix crash due to use of poisoned hlist_node
>  - Apply samx-tree formatting
> 
> Gilad Naaman (6):
>   neighbour: Add hlist_node to struct neighbour
>   neighbour: Define neigh_for_each_in_bucket
>   neighbour: Convert seq_file functions to use hlist
>   neighbour: Convert iteration to use hlist+macro
>   neighbour: Remove bare neighbour::next pointer
>   neighbour: Create netdev->neighbour association
> 
>  .../networking/net_cachelines/net_device.rst  |   1 +
>  include/linux/netdevice.h                     |   7 +
>  include/net/neighbour.h                       |  24 +-
>  include/net/neighbour_tables.h                |  12 +
>  net/core/neighbour.c                          | 337 ++++++++----------
>  net/ipv4/arp.c                                |   2 +-
>  6 files changed, 174 insertions(+), 209 deletions(-)
>  create mode 100644 include/net/neighbour_tables.h

Looks like the test is still unhappy. Can you try to run it on your side
before reposting? Or does it look good?

[  110.442590][    C2] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x5191
[  110.443219][    C2] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[  110.443498][    C2] flags: 0x80000000000040(head|node=0|zone=1)
[  110.443752][    C2] page_type: f5(slab)
[  110.443897][    C2] raw: 0080000000000003 ffffea0000146401 ffffffffffffffff 0000000000000000
[  110.444236][    C2] raw: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
[  110.444546][    C2] head: 0080000000000040 ffff8880010433c0 ffffea0000256410 ffff8880010410e8
[  110.444862][    C2] head: 0000000000000000 0000000000020002 00000001f5000000 0000000000000000
[  110.445175][    C2] head: 0080000000000003 ffffea0000146401 ffffffffffffffff 0000000000000000
[  110.445890][    C2] head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
[  110.446197][    C2] page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
[  110.446558][    C2] ------------[ cut here ]------------
[  110.446754][    C2] kernel BUG at include/linux/mm.h:1140!
[  110.446972][    C2] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
[  110.447210][    C2] CPU: 2 UID: 0 PID: 29 Comm: ksoftirqd/2 Not tainted 6.12.0-rc3-virtme #1
[  110.447528][    C2] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[  110.447928][    C2] RIP: 0010:__free_pages+0x1e4/0x220
[  110.448128][    C2] Code: 0f 94 c3 e9 ba fe ff ff 48 c7 c6 a0 18 58 92 4c 89 e7 e8 df bf f4 ff 90 0f 0b 48 c7 c6 40 29 58 92 4c 89 e7 e8 cd bf f4 ff 90 <0f> 0b 48 89 ef e8 72 03 09 00 e9 c5 fe ff ff e8 98 03 09 00 e9 35
[  110.448803][    C2] RSP: 0018:ffffc90000217cb0 EFLAGS: 00010246
[  110.449040][    C2] RAX: 000000000000003e RBX: 0000000000000000 RCX: 1ffffffff263b43c
[  110.449304][    C2] RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
[  110.449565][    C2] RBP: ffffea0000146474 R08: 0000000000000000 R09: fffffbfff263b43c
[  110.449840][    C2] R10: 0000000000000003 R11: 205d324320202020 R12: ffffea0000146440
[  110.450101][    C2] R13: ffffc90000217d78 R14: 0000000000000000 R15: 0000000000000008
[  110.450399][    C2] FS:  0000000000000000(0000) GS:ffff888036100000(0000) knlGS:0000000000000000
[  110.450787][    C2] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  110.451008][    C2] CR2: 00007f9289e72270 CR3: 000000000a73a005 CR4: 0000000000772ef0
[  110.451274][    C2] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  110.451564][    C2] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  110.451860][    C2] PKRU: 55555554
[  110.452015][    C2] Call Trace:
[  110.452167][    C2]  <TASK>
[  110.452282][    C2]  ? die+0x37/0x90
[  110.452440][    C2]  ? do_trap+0x1a3/0x260
[  110.452589][    C2]  ? __free_pages+0x1e4/0x220
[  110.452786][    C2]  ? do_error_trap+0xbe/0x180
[  110.452970][    C2]  ? __free_pages+0x1e4/0x220
[  110.453152][    C2]  ? __free_pages+0x1e4/0x220
[  110.453342][    C2]  ? handle_invalid_op+0x2c/0x40
[  110.453527][    C2]  ? __free_pages+0x1e4/0x220
[  110.453709][    C2]  ? exc_invalid_op+0x30/0x50
[  110.453934][    C2]  ? asm_exc_invalid_op+0x1a/0x20
[  110.454126][    C2]  ? __free_pages+0x1e4/0x220
[  110.454321][    C2]  ? rcu_do_batch+0x34d/0xf20
[  110.454528][    C2]  neigh_hash_free_rcu+0xb7/0xe0
[  110.454728][    C2]  rcu_do_batch+0x34f/0xf20
[  110.454913][    C2]  ? __pfx___lock_release+0x10/0x10
[  110.455108][    C2]  ? __pfx_rcu_do_batch+0x10/0x10
[  110.455350][    C2]  ? lockdep_hardirqs_on_prepare+0x12b/0x410
[  110.455604][    C2]  rcu_core+0x2bd/0x4f0
[  110.455773][    C2]  handle_softirqs+0x1f6/0x5c0
[  110.455965][    C2]  ? __pfx_run_ksoftirqd+0x10/0x10
[  110.456152][    C2]  run_ksoftirqd+0x33/0x60
[  110.456342][    C2]  smpboot_thread_fn+0x306/0x850
[  110.456533][    C2]  ? __pfx_smpboot_thread_fn+0x10/0x10
[  110.456719][    C2]  ? __pfx_smpboot_thread_fn+0x10/0x10
[  110.456903][    C2]  kthread+0x28a/0x350
[  110.457041][    C2]  ? __pfx_kthread+0x10/0x10
[  110.457369][    C2]  ret_from_fork+0x31/0x70
[  110.457566][    C2]  ? __pfx_kthread+0x10/0x10
[  110.457748][    C2]  ret_from_fork_asm+0x1a/0x30
[  110.457944][    C2]  </TASK>

---
pw-bot: cr

