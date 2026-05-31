Return-Path: <netdev+bounces-293368-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBreD7GIG2rMDwkAu9opvQ
	(envelope-from <netdev+bounces-293368-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 03:02:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4FE614139
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 03:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 431783014143
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 01:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760A028150F;
	Sun, 31 May 2026 01:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONPBy+wq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9901427A
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 01:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780189313; cv=none; b=CwLE4khmkdz+SNyMJEYcc0IqjSHiFkKtMCQRwmA9Axoqfinf4zAFC8vUQYbdpsOq3fSuQnEaFJqwWWx7JYBiy6bOtK+8pNRj34VVSjzrnbu2C5fdhqzyTYiDM62cZYRQ0O8sNKd2jTwiGnn8n/AKapuiDdH9cL2fE9vUoqzyoYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780189313; c=relaxed/simple;
	bh=zDp1XhZh+e1pWOK/DsDnXaGWcjK6DLDDhCVbs2gw3ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IewFvYiqDPWoapKGcuFvrZt/xDwtjDWJdQ9wQlyKyIqbilkc/OQpsmUeub77YLILAdnDcJwlOhNIbGYge2mEvzQ8WlnDpJLvDFk8J+KmCIyBU+Th6UDawwalTEd7abHRQdc/eCmPJbJdzSIOT6R2rw3yYjswynLEdQWZd0d0d7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONPBy+wq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490686877a1so49172285e9.0
        for <netdev@vger.kernel.org>; Sat, 30 May 2026 18:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780189309; x=1780794109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zPl6w3uFFVNTR71LIvI6Hm9g27LWiqb2gsEEN2QBH30=;
        b=ONPBy+wq4TbJvSn3LFGXIzPYyx8ZL8H0HYU72wPZVRyrKbZ3ulzc+EdYpWvPewy5+E
         HceHotkVzpTfwy5ttrDEQripSfGnKvGRaFhDHsXtc4xPtvryIUsW/n8cMtnKWqhWjVLr
         5PfktqQ0ALXzQVgwDDPr+8rAkWm76N+8vqNhRBIwZuny+k5LKYT/URzgaeAt9ij4cqwR
         5H33MKZqNPe3/+Dxieo1Mgg7UT2ujBWMZpgVi2MeIgWNbiM6X0ITgl05Jg7oUoq1J4lO
         3h3UAOnRQ3GVFDTMv+9NbMUeYedFTVX0GHUKUuxma6BOnmivDMq7ziff3UXnxYXACATl
         unmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780189309; x=1780794109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPl6w3uFFVNTR71LIvI6Hm9g27LWiqb2gsEEN2QBH30=;
        b=RY25OTkvDXgxfIWBtX1a38CrZvls7NAcZd9VeR7Ej7DgLWWOmridwS289ptUjdz3Mr
         jTqhS5QJC0OY91y7n0qsq8ssanpOgQ2rIZNuoFCLtHSrsciYvHVSX3WNEesIpBzTUGFO
         Nv4afDJayF69U5kzboLYq7bGbWVrBaqFurjneEdF9NIBrsIZ5dUu33NZIU1e6KEc77+A
         hSynHJkHC7I3NsvrP3FUQhHlRyiT+r54/4rOn/S2dRt8EwpKFmEZbdT28JPF93MLM7r9
         ZeoVudS1CCMmABnT+KZ1vrhM7WP6hYbt2/f61cejmLiriq1nHH4KWVG8Ly2oVYRYoI/E
         lX4w==
X-Forwarded-Encrypted: i=1; AFNElJ9gYgj7gQjo4AAm9EZnMDMadFP0w6UHUvqAlk4CsnPOdNN/82Lis3V1yWdUrWZxmMNkmOYcZlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxirDwLGfVHnNw+6bvVkiwOOFQ23zcWuh2PZvGGW95Kg1xUeAIb
	xwji0miGyHIhjR09NZiL0vio+yNTqE2HxZv+DKoisVoLANCN79vn72EY
X-Gm-Gg: Acq92OFgbGOfmoK3hWMS8stT5JSMW472jr/T8ZU4uQCqXpRtsmgGoN50PMAj82FmrmZ
	jEfORtkgznhm/02We35EuvmQGwJEAjOgSdtbl56azaEXMU5s0VT93UcMawa4AndX/rH+tQTzG0X
	3T1YBL0rWLKpAgZZ3DA2tv72v9GWelnZI1UyNW7xTYNO/0HFiRAPME1XDfH+j9wrsN4QEN/Bqah
	ufUBfEt5Nj0blvNhsxgzHqXO3Jb+ucpAaH1i7rutImY04CAWv34Ch+bSXVd5VuRcTCUGkYLH5yg
	gn8yUEvoXP9k4UN7IesABLvLqXMdr5zBq+iZC6LVR4hRWgCwJuF6nMvMB9bkIAUfONARXrgp8p+
	2E8Jw1WAdkTkFP3eNQdam30SsDIKAgQJvgYjmLB91JIFSkyZSi2pwux5B8aJklyeCNuEAXK2SVl
	DJn+AlLJDLo2gE/xY6Vh80SnjkNpIn3DOf2TcxUq5g
X-Received: by 2002:a05:600c:c168:b0:490:5000:917 with SMTP id 5b1f17b1804b1-490a2a02ad9mr75824695e9.1.1780189308943;
        Sat, 30 May 2026 18:01:48 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4909cab0e79sm261799535e9.13.2026.05.30.18.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2026 18:01:48 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-api@vger.kernel.org,
	netdev@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	patches@lists.linux.dev
Subject: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Sun, 31 May 2026 01:01:04 +0000
Message-ID: <20260531010107.1953702-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293368-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1C4FE614139
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patchset is for VFS.

Recently we got a lot of vulnerabilities in splice/vmsplice.

Also vmsplice already was source of vulnerabilities in the past:
CVE-2020-29374 (see https://lwn.net/Articles/849638/ ).

Also vmsplice is problematic for other reasons. Here is what other
developers say:

Linus Torvalds in 2023:
> So I'd personally be perfectly ok with just making vmsplice() be
> exactly the same as write, and turn all of vmsplice() into just "it's
> a read() if the pipe is open for read, and a write if it's open for
> writing".
https://lore.kernel.org/all/CAHk-=wgG_2cmHgZwKjydi7=iimyHyN8aessnbM9XQ9ufbaUz9g@mail.gmail.com/

Christoph Hellwig in May 2026:
> vmsplice is the worst, as it is one of the few remaining places that
> can incorrectly dirty file backed pages without telling the file system
> and cause the other problems fixed by a FOLL_PIN conversion, but it is
> the only one where we do not have any idea yet how we could convert it
> to FOLL_PIN due to the unbounded pin time.
https://lore.kernel.org/all/agwFlBKvKytjURDO@infradead.org/

See recent discussion here:
https://lore.kernel.org/all/20260516182126.530498-1-pfalcato@suse.de/T/#u

For all these reasons I propose to make vmsplice a simple wrapper for
preadv2/pwritev2.

vmsplice(fd, vec, vlen, vmsplice_flags) will
be equivalent to preadv2(fd, vec, vlen, -1, rw_flags) if you have
readable pipe and to pwritev2(fd, vec, vlen, -1, rw_flags) if you have
writable pipe.

SPLICE_F_NONBLOCK is translated to RWF_NOWAIT, all other SPLICE_F_*
flags are ignored.

There is a small change to handling of NONBLOCK-related flags,
see commit messages for details.

I tested this patch in Qemu.

This patchset was written by me, not by LLMs.

Askar Safin (3):
  tee: fs/splice.c: remove unused parameter "flags" from "link_pipe"
  vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
  splice: remove PIPE_BUF_FLAG_GIFT

 fs/fuse/dev.c             |   1 -
 fs/read_write.c           |  23 +++++
 fs/splice.c               | 202 +-------------------------------------
 include/linux/pipe_fs_i.h |   1 -
 include/linux/skbuff.h    |   4 +-
 include/linux/splice.h    |   2 +-
 include/linux/syscalls.h  |   4 +-
 7 files changed, 33 insertions(+), 204 deletions(-)


base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d (7.1-rc5)
-- 
2.47.3


