Return-Path: <netdev+bounces-296058-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q98oIQG6I2rlxQEAu9opvQ
	(envelope-from <netdev+bounces-296058-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 08:11:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DB164CABF
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 08:11:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lZLnIKMI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296058-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296058-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B76D302974D
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 06:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D1A3090CC;
	Sat,  6 Jun 2026 06:11:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F360824E4C6
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 06:11:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780726264; cv=none; b=BQnR6MLyHGjbsLad5o8lDyPNwZoNl+4WyfomLPEhUm9OqkbUB8gfCy2Tq3bBDJGQEVt8dXC5BKpZeD/Q/b9NpWqnydzxjaWGeKyHk6iVaq4r2fpe8mjEKideWQYvaLACGik4YpvUi1j5RWPA+HMzFI/CP/R/c50lg8fcJoX4VqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780726264; c=relaxed/simple;
	bh=ve8FNUDJ+bfAlTYt1tyGpBHY0ZFpeP48sjRpO5hIorA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KXD9Gd7tPpJEDZ9kn8ljAx6ALAEZVlSiKTM+Qp6nl1B911Z4Fre4oZQOAsJCu0eY6b7/cVJHMN6nd3iocsQ72ntMbbPevXQ/2WaAIwBSqVshnyo2IgNT2K3w5qjgWVRopfxCp5QgMZmeHWKDxD96xeD0ZZvKmrS9RAEi+Sv761Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZLnIKMI; arc=none smtp.client-ip=209.85.221.48
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45ef5146b56so2342345f8f.0
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 23:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780726261; x=1781331061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8r8X8oylGshLaIHIAK1kgCpu4mjI5I9eQ7pptBpGukw=;
        b=lZLnIKMIF3d3ixq8CA9qHpI6c4K1GVAPpUE7R5cbmfuod843qux2ApzyxWcN9P1y0i
         oMecdiFiZIMP/MgPqXZhVctyIRv7uFpA4tSLsF3uUJZwyQ4hA5iuZwQl9QFwGcd3gvGC
         Hcdw9UucXPzWiaheQKM/ZZ/cvZbpBP7P1jAehUaNMz2+Lff0BSjM41b4lfirrrSchqdp
         iipJrLwv6jAPAnpwodIcFsI9u55Gs6HqDYvjkk8XKoNqROoyb8jh13EJ828FZ0KvWiVZ
         v7PCF9Eqn8mX4bx+AOr4+fAN6ce4raMku673pCYv0adx8D6N/lH1pEiyXmvfHU9o9LQR
         FfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780726261; x=1781331061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8r8X8oylGshLaIHIAK1kgCpu4mjI5I9eQ7pptBpGukw=;
        b=e4ygqE+ARLHrIINr23Ejga33RJtZv6AiIcn20MD8x5G2CCCOX7mlJ8mbGRI2FB6Joy
         3OKCTQ+SJB1menbsxpvPPa2zj06NfvDpWmHPLzetrAFG6TXHYMGGjpxCwpsTZKyGovyJ
         7O5r927B82CdgfzlFpvqX7wUi+/64W3DLN6h5WhsAPSLAR6iLtKzyrT/UNM2BnALngpE
         vx9MbNHY31SofpvbPTAridEB5YcUTVIH69rCwHeOyQazrE5LYRmicyCqd+F4I6QRX3ao
         Ryy1fASYgBOrzcssH6YFE6nFWdmhIToIzKNnWGLV3eKFf7n19VeA3RSphHxxGN7uCz7y
         uSAw==
X-Forwarded-Encrypted: i=1; AFNElJ8DMXvS3d19drv9uYDB9RYzeZi/sr5HdBJUcZPTJf3Um9+xOLaL7irqwu/YlogNQej73xhmkcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEFDfiKzU6zZlTJpT3g62ch5USM3eRJ75jAdWaBE0gRKTInqP8
	LUT+vq1fTT2Go8Wg8aaQQOLTzCQQPHQ37dgBU8Tpab7t59lUETWvaP7o
X-Gm-Gg: Acq92OHr0vGCQqASkvsI5cpAQ0yTlzCoXBHlCFBgCKuff+sbALko+qwL+gC+WCFVgy/
	jWryXx6BTy/wKc97EVaRkx0T7hvrfQfd23Lv1IPkHNBB4lm76Ajy4IZ5523In11peeJUGVy/dCG
	ZTsX/jR3PvAnwIFXjgSmaxVceDLItSXKjN3fFG0rZrmrzZlpfn9boPOWl4zB0tB1o+HvpWMU2GK
	zns84d41TWm1jCS9YHxvtPr+yoQgP6wkvVi+QnXFGXPCdqUQMBPKJh+AUv7jHEcOW6faqFmRezX
	GtLdjV+VzNAeFMKI6tklWr7J8ohSt8BNebCTdzqjTn0cq8iqyE3tYazaVGj3mNW60+XUFKkrDXk
	iHbs+n1I7DW8Y6zeq3T+bXLg4a79JuWXAp/S86mP+70mKQAKjhGn5GeeWZiN32yZzobNBth0MCV
	FbMPGabvwOVh+JoTquHDJlYtUsZokcFA==
X-Received: by 2002:a05:6000:41c4:b0:45e:f5b5:885 with SMTP id ffacd0b85a97d-46032b610d1mr8361361f8f.2.1780726261254;
        Fri, 05 Jun 2026 23:11:01 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4601f360bd6sm34254711f8f.36.2026.06.05.23.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 23:11:00 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-api@vger.kernel.org,
	netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	ltp@lists.linux.it,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andy Lutomirski <luto@amacapital.net>,
	Collin Funk <collin.funk1@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	Stefan Metzmacher <metze@samba.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	The 8472 <kernel@infinite-source.de>,
	Willy Tarreau <w@1wt.eu>,
	Joanne Koong <joannelkoong@gmail.com>,
	patches@lists.linux.dev
Subject: [PATCH 0/5] vmsplice: fix some problems in my previous vmsplice patchset
Date: Sat,  6 Jun 2026 06:10:26 +0000
Message-ID: <20260606061031.3744880-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296058-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[safinaskar@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-fsdevel@vger.kernel.org,m:brauner@kernel.org,m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-api@vger.kernel.org,m:netdev@vger.kernel.org,m:fuse-devel@lists.linux.dev,m:ltp@lists.linux.it,m:torvalds@linux-foundation.org,m:willy@infradead.org,m:axboe@kernel.dk,m:hch@infradead.org,m:dhowells@redhat.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:pfalcato@suse.de,m:miklos@szeredi.hu,m:luto@amacapital.net,m:collin.funk1@gmail.com,m:david.laight.linux@gmail.com,m:metze@samba.org,m:rostedt@goodmis.org,m:kernel@infinite-source.de,m:w@1wt.eu,m:joannelkoong@gmail.com,m:patches@lists.linux.dev,m:collinfunk1@gmail.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.linux.dev,lists.linux.it,linux-foundation.org,infradead.org,kernel.dk,redhat.com,kernel.org,suse.de,szeredi.hu,amacapital.net,gmail.com,samba.org,goodmis.org,infinite-source.de,1wt.eu];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D9DB164CABF

This patchset is for VFS. Of course, it depends on my previous vmsplice
patchset.

I fix some problems in my previous patchset.

1. Fix problem with CLASS(fd, f)(fd). See first patch for details.
This is probably not so important, but I fix it anyway.

2. Change "unsigned long" back to "int". See second patch for details.
Again, this is probably not important, but I want to fix this anyway.

3. Fix that LTP vmsplice01 bug.

See patches for details.

Please, run that LTP vmsplice01 test again.

Notes:

- I want to repeat: I change behavior around SPLICE_F_NONBLOCK.
Previously, vmsplice ignored whether pipe itself was opened as
non-blocking file. Now it is not ignored. And in my opinion
new behavior is better.
- vmsplice(2) now is in fs/read_write.c . It is very similar to
preadv2 and pwritev2 now, so I think it belongs to fs/read_write.c now.

Please, review this patchset carefully. I'm still new contributor.
In particular, please, review that do-while loop, I'm not sure I did
everything right.

Tested in Qemu.

Askar Safin (5):
  vmsplice: open-code do_writev and do_readv
  vmsplice: change argument type back to "int"
  splice: turn wait_for_space flags argument into bool
  pipe: move wait_for_space to fs/pipe.c and rename it
  vmsplice: make sure we don't wait after writing some data

 fs/pipe.c                 | 17 +++++++++++
 fs/read_write.c           | 61 ++++++++++++++++++++++++++++++++++-----
 fs/splice.c               | 19 +-----------
 include/linux/pipe_fs_i.h |  2 ++
 include/linux/syscalls.h  |  2 +-
 5 files changed, 75 insertions(+), 26 deletions(-)


base-commit: 8d86fcfc2857d64af85f5c87c193c25655c970af (vfs-7.2.vmsplice)
-- 
2.47.3


