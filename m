Return-Path: <netdev+bounces-301895-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aa8KGovoPGoAuQgAu9opvQ
	(envelope-from <netdev+bounces-301895-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 10:36:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D59926C3DF9
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 10:36:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=KYbfVK4G;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301895-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301895-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 829B430316C7
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 08:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7AE380FFA;
	Thu, 25 Jun 2026 08:35:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DC437DE83
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 08:35:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782376540; cv=none; b=OmaMaaOdXHjOjIdq0qXb0qppU+d3mF9ScADQZLcM61OHoDKwrbpLhKEZR86ucRrxCiFfyZ0Y859ItqG+USTm81tgG0dshygewgYU9I9x92C2n5ZigRpX1w59DQSk/5cKNGZRY4tvY7NrGIQUCIjcU78ivfRWL4Q3zx3ec/Q3S6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782376540; c=relaxed/simple;
	bh=x+w9SGxZBWO4hPXg8E+A/q/4ScS0BqeDSCrwJNo6iBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JxEuAvoWRQ/ah924hOfCLEWy9XJEUe6IuYs5K63LKQ8E43i7bmEek95sDXJh4WPl/h8HTbog115nsCYSAbNYZtjiH2ULtsrMXhWcw4ASQZS7ywle1AK91c69dNHlr350luiIhl4ZDjlho62wusm4ZSSZDyUv1UvwHvF0IlrFyQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYbfVK4G; arc=none smtp.client-ip=209.85.221.51
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-46cbe01d4b6so966608f8f.2
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 01:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782376537; x=1782981337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+ggg4zFesK0IrYb2saIE8cPaSi4XEf6KWehvtWp5AY=;
        b=KYbfVK4GpuwSiN5c3R2ornN6UuY9+Rb7Ddw36+XX0K4/PfGZJDPrDvwYN1ut2x+M6j
         oolzOP8CQt0yFF4dGEUsMvdlLh13OMvAXZXCqKj8PX7SudG+aC6WYqzN45Np4gXZmhmF
         Wo70q/X6K/PPukycdtCTRXjbkwzONwXI057xLHhncpSU7FdvJpra4Z54dwZe6jg7bNS7
         lBCI3sBejIu4W+gNsIMuLtcdLxIRkKAZYQlgj33/hHE/nDZQzZPz3+jeGBLIqIlkZKqa
         E7s1wsGqGBeUnwfLRmftLjpSGS2sgl8PFrEAZjEj6AzHi70tTIcJaA2b6ySiNLt/x5ht
         9Xxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782376537; x=1782981337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0+ggg4zFesK0IrYb2saIE8cPaSi4XEf6KWehvtWp5AY=;
        b=hdxYvTxjdbK+BsawZqoy1Eo1wEmxJoD3Hcd2wfd+bne7dmgRg2JR+tXts4iWeuij72
         83OfSP/qMhuEhXuwGXGSLulVtIC9wojHl48w5fs/Qrw6kjGcAuTBSZbI7EOfoUzG4Lo2
         nC748SHnJ/g5v4ooXsB5dmTmwyKunRlcYAdMb4fx2rhFUAM3Je4gFVM9yYayCz72dvrj
         S7ALyYBcuiESnxV+inEdMcvEPe3wFwei/87EMXKCqr1kxSwybRCMp948jxksen7L04jj
         1iIN5BxHgUkzJVWd5ZKcjo8h+Y1JXmGZXk9A9uAF0HshUP/q+UvTPQeG8mIJ+aWJj/Iu
         aY3w==
X-Forwarded-Encrypted: i=1; AHgh+RpUotTuxkytZnKr+W4+6s7xWLK4KvX7hRjUJCV6dBk6wL7lUBYV2zdoodHF0w1Z/n6ff/6/BeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw98sdGx1OdSzrrl/9M++ghe3qI7iz2lTyZs7eevBjBKGJICSed
	jeL3l23xELEAwZwuNfpmZdp7ufKgnoHJeAFNvLze0787I3mYvJYXMscm
X-Gm-Gg: AfdE7cmLBYeUKHpeEjRAAuUx/T9mmAPjgpKfsG6k9LAspOKPDLfILBkMC4XUWoYDLVm
	SbF/TqrQcuSfyyRKokjtzssreLvUrcSGFnGG+QICHN6uoCovHXcl3gEmN69HiCS52Nn4QjZkdKl
	QQa3ewKr7F2DdRZ/uZscLeQFWeuquQv1YGVwOTpMeQJEiuuh97H+YFC1mZFOGd5ZUJdSoWn845A
	19E2JjKn3aTOGhCPnIZV5jhJ6riwb5mrXXuvWjAC7qTuFkG6snOi9fEyjbxjic5zrywDyPjCppk
	QXKoBda8jN8v7Lnw6WwvixvtRKsYO4sGlNbVIr79SEOpNr/cHBGdOUcvgbFTe3pOcoqjnTYcE3U
	YOxgg42w6c+pUtXskeFwvoH21uxa442RNak8KbPEtCrIQHWcYDO3Ti5dZDIY9wy4F4jUNt7uH9K
	PptrtjrJQY
X-Received: by 2002:a05:6000:1841:b0:451:3b12:9bca with SMTP id ffacd0b85a97d-46dc20763ecmr2315779f8f.25.1782376537012;
        Thu, 25 Jun 2026 01:35:37 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-46c2279b85csm13357402f8f.28.2026.06.25.01.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 01:35:36 -0700 (PDT)
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
Subject: [PATCH v2 2/7] vmsplice: change argument type back to "int"
Date: Thu, 25 Jun 2026 08:34:04 +0000
Message-ID: <20260625083409.3769242-3-safinaskar@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301895-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D59926C3DF9

My previous vmsplice patchset changed vmsplice argument from
"int" to "unsigned long". This may cause problems, so let's
change it back.

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 fs/read_write.c          | 2 +-
 include/linux/syscalls.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index e224e7cb8..77487b307 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1218,7 +1218,7 @@ SYSCALL_DEFINE6(pwritev2, unsigned long, fd, const struct iovec __user *, vec,
 /*
  * Legacy preadv2/pwritev2 wrapper.
  */
-SYSCALL_DEFINE4(vmsplice, unsigned long, fd, const struct iovec __user *, vec,
+SYSCALL_DEFINE4(vmsplice, int, fd, const struct iovec __user *, vec,
 		unsigned long, vlen, unsigned int, flags)
 {
 	if (unlikely(flags & ~SPLICE_F_ALL))
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a86a88207..46a3ec954 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -514,7 +514,7 @@ asmlinkage long sys_ppoll_time32(struct pollfd __user *, unsigned int,
 			  struct old_timespec32 __user *, const sigset_t __user *,
 			  size_t);
 asmlinkage long sys_signalfd4(int ufd, sigset_t __user *user_mask, size_t sizemask, int flags);
-asmlinkage long sys_vmsplice(unsigned long fd, const struct iovec __user *vec,
+asmlinkage long sys_vmsplice(int fd, const struct iovec __user *vec,
 			     unsigned long vlen, unsigned int flags);
 asmlinkage long sys_splice(int fd_in, loff_t __user *off_in,
 			   int fd_out, loff_t __user *off_out,
-- 
2.47.3


