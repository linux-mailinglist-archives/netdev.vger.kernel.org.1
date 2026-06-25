Return-Path: <netdev+bounces-301898-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iFh0F6boPGoYuQgAu9opvQ
	(envelope-from <netdev+bounces-301898-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 10:36:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A8A6C3E23
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 10:36:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=IEyFdrkY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301898-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301898-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6AE313001441
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 08:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F4F3812C8;
	Thu, 25 Jun 2026 08:36:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF830374170
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 08:36:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782376611; cv=none; b=RbKGkM3UfxO6z0+r03bAuGMrtQqRACjTJe5RBK1DFMjIFdgHumCJC0z2pY/mig6KBm1kyGZWsou+8G4qq2iFC+qwMDKlmZm2LCbJz2sKb44WNJTiCKzFKGiP/9dNQVAF+eERBA7lWP+0KyNniHUEkTxt+98usmd+hNjGRqZ8NI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782376611; c=relaxed/simple;
	bh=YVkMCLt5FJ+bDbSrJETzwIU6LK60EPUbwXQNXghAHuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZX8+IeNml0x3lmttrySvBeyV9egrEWPofOH/uqYhBi3MN2arsj6mD7vIv2urolAirqx91sBzU5cQvc7kiRSUDvXpTUtoY0X63ZnVg/3izqsY4pA9WgDe7p9obfmt80vjUkGhX+NbN/n0o9DvL3t0561T0reBYHsyUBhgaudjJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEyFdrkY; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49263703c6eso10469445e9.0
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 01:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782376608; x=1782981408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y22J8nzR3UW0cMYCUVJWDcFSFo/6kHGVqnn/SzRaSz8=;
        b=IEyFdrkY6ibOQ5SLodmI3KTVvtOX2lj01KUp1Css+wNtwgr7qysOfxlxKzWbfM/jYa
         uM4YaF6lbNSJDkV4jcTXrLJrWTa5q0hcoaYDgYHAYPUfCw42pN2U8FHvp2/NlD+3pDr9
         FYux8tfvG3jfuNHzKEyNpZnxJ89CrdPvj1c798+iSCw25OYjhURbBs9vRVJx+bfHrQ6q
         P8yZxlupCaIUxECLNrwDhhT5SiXuPFRWuCJRjjCy54fM6W1oeQCqOeO0/Ju9GoxN9ip/
         iYKZ1LrewZzIhH6CfiNhya8s8AIpmvJL7uDvjMHp7W7ezOsVOfinw8rm4lsisT0+lhcZ
         EpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782376608; x=1782981408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y22J8nzR3UW0cMYCUVJWDcFSFo/6kHGVqnn/SzRaSz8=;
        b=cqJVg39sVE8OO9yGU6UQ4PiACxGscNZJXnyS9ezE93E63H35CrCr1Ub2P9u22MKbP2
         JKN8AdFIsWJCqo+5KquXm5HCR3GHLqhtPMEeJEKTI0X26nTVhQ9MGEZy3MdlpfBJ9EBl
         aJar34oPl6a67xsZ0TGB6C+FTQQr6F53qg4KezGn4mFZWbJo3dajtTZ7mw4b68wrtOnn
         5HLbt/JDHgwW12Ua22ruenBVqVEgqJwJHcx5zZwbHttVtaw+RM37LvrJX+jvBhNoomZ0
         86UsYUF/I0iTglL3lU4fmtS08sDETYV8W+FLQcmksxAi5P7z+8BJXZ5gRKeJceEMJKDt
         qOWg==
X-Forwarded-Encrypted: i=1; AFNElJ8eR0UcSLQKypiMkiOhRnmOB2S5Aado6iQGLpkRoSEpF6vtMhjwgDU+KN+kdtfMdbEzDHm0cCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvSsO+Y0AQsuNfaNF6ibGFmPFi0JEH31RuYTgVetg1oXKTSEZd
	oKBcYrqCPJ5aGFYX0w4m9uePXfNVJGxumwRJ6+JiwHDSJQPIEqiPzDhU
X-Gm-Gg: AfdE7clFHYlRfxlNE84pMun9eFLRTcalJEDyzdtJdeU3x+OPCZbYwPWDNHh8jCOcCFn
	2b2FkcCdfTMSyaVB0QS3aDn+bzAVsbogwWX2Q4l+mSVse24n/3KMEBTv2pXVbv40yCHAeZbia+0
	UAdco1A+MTQGhEfsF9ZVWkdraWYnf3XWfYJkTLsx8yJUsTa2QjNMWxjOHUiL1hliCt73VUOlLL7
	Kd9qJ23NbJ6Kaid5ZOzxT7FXCF1gY1bcEWkerXvfIipICxOe8lSG4bazYuGT5SO80rNWdd9LeDG
	QKDx/ETHg30juH9DLWRhpUpS6lhaWTkEHrBI+N3c84KNAgSdMcZcleWY61OVzBpGlW3xbG2qoZf
	NxpJOhdnHcVjyJ4SJs5Gv1jt20xeYGgjKpm8bWc9S4wL1vPmhQIIsIL5in6pZOdiI8mwFMMs8eu
	5T+3kWzmu7
X-Received: by 2002:a05:600d:8489:10b0:490:a298:3859 with SMTP id 5b1f17b1804b1-49266892151mr13952905e9.24.1782376608352;
        Thu, 25 Jun 2026 01:36:48 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-492640362bcsm70832535e9.8.2026.06.25.01.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 01:36:47 -0700 (PDT)
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
	The 8472 <kernel@infinite-source.de>,
	Willy Tarreau <w@1wt.eu>,
	Joanne Koong <joannelkoong@gmail.com>,
	Val Packett <val@packett.cool>,
	Andrei Vagin <avagin@gmail.com>,
	patches@lists.linux.dev
Subject: [PATCH v2 5/7] vmsplice: make sure we don't wait after writing some data
Date: Thu, 25 Jun 2026 08:34:07 +0000
Message-ID: <20260625083409.3769242-6-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625083409.3769242-1-safinaskar@gmail.com>
References: <20260625083409.3769242-1-safinaskar@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301898-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[safinaskar@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-fsdevel@vger.kernel.org,m:brauner@kernel.org,m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-api@vger.kernel.org,m:netdev@vger.kernel.org,m:fuse-devel@lists.linux.dev,m:torvalds@linux-foundation.org,m:willy@infradead.org,m:axboe@kernel.dk,m:hch@infradead.org,m:dhowells@redhat.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:pfalcato@suse.de,m:miklos@szeredi.hu,m:luto@amacapital.net,m:collin.funk1@gmail.com,m:david.laight.linux@gmail.com,m:metze@samba.org,m:kernel@infinite-source.de,m:w@1wt.eu,m:joannelkoong@gmail.com,m:val@packett.cool,m:avagin@gmail.com,m:patches@lists.linux.dev,m:collinfunk1@gmail.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.linux.dev,linux-foundation.org,infradead.org,kernel.dk,redhat.com,kernel.org,suse.de,szeredi.hu,amacapital.net,gmail.com,samba.org,infinite-source.de,1wt.eu,packett.cool];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0A8A6C3E23

Make sure we don't wait for space in pipe after writing some data.
This is needed for compatibility with previous version of vmsplice.
Found by LTP vmsplice01.
See comments in the code and links below for details.

Link: https://lore.kernel.org/all/20260603-raumfahrt-unmerklich-ertrugen-c4ecae70d5f9@brauner/
Link: https://lore.kernel.org/all/CAHk-=wgV-j-G3d+899Zm1pQ=NaJrddPz=GKcL5Yw5DTUM=GaUw@mail.gmail.com/
Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 fs/read_write.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 77487b307..dbd0debc2 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1221,6 +1221,8 @@ SYSCALL_DEFINE6(pwritev2, unsigned long, fd, const struct iovec __user *, vec,
 SYSCALL_DEFINE4(vmsplice, int, fd, const struct iovec __user *, vec,
 		unsigned long, vlen, unsigned int, flags)
 {
+	struct pipe_inode_info *pipe;
+
 	if (unlikely(flags & ~SPLICE_F_ALL))
 		return -EINVAL;
 
@@ -1229,11 +1231,44 @@ SYSCALL_DEFINE4(vmsplice, int, fd, const struct iovec __user *, vec,
 		return -EBADF;
 
 	/* We do vfs_writev/vfs_readv, so it is okay to pass "false" here */
-	if (!get_pipe_info(fd_file(f), /* for_splice = */ false))
+	pipe = get_pipe_info(fd_file(f), /* for_splice = */ false);
+
+	if (!pipe)
 		return -EBADF;
 
 	if (fd_file(f)->f_mode & FMODE_WRITE) {
-		ssize_t ret = vfs_writev(fd_file(f), vec, vlen, NULL, (flags & SPLICE_F_NONBLOCK) ? RWF_NOWAIT : 0);
+		/*
+		 * When writing to the pipe, previous implementation of vmsplice
+		 * first waited for space in the pipe to appear
+		 * (depending on whether SPLICE_F_NONBLOCK was passed),
+		 * then did unconditional non-blocking write to the pipe.
+		 *
+		 * This differs from what pwritev2 does.
+		 *
+		 * For compatibility we do the same thing previous
+		 * implementation did.
+		 *
+		 * We lock the pipe, do pipe_wait_for_space, then unlock
+		 * the pipe, and then do vfs_writev. vfs_writev internally
+		 * locks the pipe again. This may cause TOCTOU: when we
+		 * do vfs_writev, the pipe may become full again. So we
+		 * do a loop.
+		 */
+
+		bool non_block = (flags & SPLICE_F_NONBLOCK) || (fd_file(f)->f_flags & O_NONBLOCK);
+		ssize_t ret;
+
+		do {
+			pipe_lock(pipe);
+			ret = pipe_wait_for_space(pipe, non_block);
+			pipe_unlock(pipe);
+
+			if (ret < 0)
+				break;
+
+			ret = vfs_writev(fd_file(f), vec, vlen, NULL, RWF_NOWAIT);
+		} while (!non_block && ret == -EAGAIN);
+
 		if (ret > 0)
 			add_wchar(current, ret);
 		inc_syscw(current);
-- 
2.47.3


