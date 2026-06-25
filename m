Return-Path: <netdev+bounces-301896-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ga0PAMjoPGonuQgAu9opvQ
	(envelope-from <netdev+bounces-301896-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 10:37:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 771946C3E41
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 10:37:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ubondpu6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301896-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301896-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF1FF301CC25
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 08:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0640F3812C8;
	Thu, 25 Jun 2026 08:36:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE27337DE83
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 08:36:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782376563; cv=none; b=kZeArg0iTuQdJfQ6VYrJYIlOj+swyt51BRBqLCb6Ghp89DZZGOK1zl3pPoFjZJXmcLhUlNYooxMr2VprHDvMm8HnOn+q9kh+LlPIT/Dex+s4P9PPen/xD+OZhRs1+uImx/KyQg7XDACAJuvsKkhUctkzNYxrt3p4xmOH7s2K9Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782376563; c=relaxed/simple;
	bh=cFehA3I9prjpPS9MpvxHw5vuJaTELUrjhx5IPWyT2q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgzPnKCRdWtpKBE7zoz85x8+TB/hIKRHFESO3BTD7agHjRT22nbDZsdwelAmVb8KdfPBAxbg4wgMobk/fp5ZudXU2clDERIKX9chelBPC2YMjQBvemae9CPXLJfOQx8U2OmDKf8A28qGXdOj/zlA8VEkLaCsVt/ntudxtgl1bKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ubondpu6; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4922244f7c7so17509405e9.0
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 01:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782376561; x=1782981361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybLyqkJC8PpxOPGtytqXN1jytQgb2AKCO5QalzHljcA=;
        b=Ubondpu6xJgw/p84wAy8wNH/JR5wUCsCd/5xeQSpoNrfjzYHLUwW8PBbPetdv0J4jl
         O94zcjadi65puUvpau74wT5BgSn//VHTqqIGGsONw3MI/n/FrxOrqCrhL7VyTXvLWGnE
         HPDOMUBZB9AYgKkkkyyVAxnQTkdR/cRFmGfInKWLNmBYNAThciWyKzYzkDFCSrEg4WzM
         WZavq5gQo95nHZcd7d8LuTkVUcPnP9kN0A7XjFPa2MgBiW2JiQ9CZBp+Jxw54vN4GFV7
         IG/oHhjwJVK88hdwkyQdESlXyM1I/7dDyaEQ0s6mkM9fLog6IlI//dvhOP/fAoQLTnJt
         3+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782376561; x=1782981361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ybLyqkJC8PpxOPGtytqXN1jytQgb2AKCO5QalzHljcA=;
        b=d3ZB9i9rGhK/3tNMrWBO9rI1Du/TfOnaUwwXfvezSW9B0SzBreKOWuHKgNYT3JEbyZ
         xC2yRLxEtu3v0VYTEVeli3QJn/TbNp9O8SpU0dcq65BgJpWBqVifjoUzBq+966OslXu4
         X6s559l2Mxf911rzVzas6Nqr6KrizyobTVuz//XxOusCA8eLwqbaodymc0tWx5+oG4Dy
         Lnd7xLtZSwGiRy+gihVlpbzU41PPzcnZVzcdf/g7+oOB8VZJUp9FyRWT7ZfC7oY7gNP+
         sOPQN2OQIyrHCEImcS3dZHNnZQFMaz7AGM+j5tPRZDncM81SIOIBZEfGqxrD7O4dPfsT
         dlTQ==
X-Forwarded-Encrypted: i=1; AFNElJ9SwSN8QPa5AGT7u9jQDNGNh79IFMf/P15X+mopdQHVfXxd9ZiUx6eKDew/u7VZpwpKVmcmDxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxeUyIpG7Uu66OIoivpXuY84CVVe40geYhwSiC0CToIuSbTNWl
	9PC2cf7zTwxv2GGymDFve9BFl8q2Vust3pr5HsVAGIfE8EeFprFUxoBdH57Jio4Udw0=
X-Gm-Gg: AfdE7ckbu8V5/dG22iqyoO3O7iG/tpr/6v70nddcDgDV9KDiuv9/DTSVYZJKDszu97E
	33cyl5sp2NQeZ7eJn6rR0mBgTWXcgRyVi14hLNsf/ElKCPMtt6iSLKoBP6syZMKHUJVrxjJtgqt
	jh2l30Qcs2XfXypzJl1LTL/HzROYRvfYomU/0Gv/VJQkr7czXKP12KQ0SX3blbj4vAUMeRDdlzx
	6Ft5qHu8w9SKDt8FoI7MUqqWqqJLRTFyZy9VrRq3LKqMEJejKXFkgIlVI7e/MuXaBVBVXfjy8Ha
	c4xOKoLk8WOZ8Uo+ung1PUxu62phwAjNqL4pSpcmuDtUcJLWYa29pU/b4GoGo74NPmtKnHq1KyR
	P/GBtWtB/EIaLZTcEfqpa5sWZzkfP9kkt7mQat7EjSXippq+uWhtckEJKCau0CeZhZB4CJAQqF5
	0RDE/0lGV7
X-Received: by 2002:a05:600c:c0d2:20b0:492:41c9:886b with SMTP id 5b1f17b1804b1-4926684c948mr14881805e9.14.1782376560755;
        Thu, 25 Jun 2026 01:36:00 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4926401a2e7sm80070205e9.3.2026.06.25.01.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 01:36:00 -0700 (PDT)
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
Subject: [PATCH v2 3/7] splice: turn wait_for_space flags argument into bool
Date: Thu, 25 Jun 2026 08:34:05 +0000
Message-ID: <20260625083409.3769242-4-safinaskar@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-301896-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 771946C3E41

I want to do this, because I will move this function to fs/pipe.c.

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 fs/splice.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 6ddf7dd72..707db2c2c 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1239,7 +1239,7 @@ ssize_t splice_file_range(struct file *in, loff_t *ppos, struct file *out,
 }
 EXPORT_SYMBOL(splice_file_range);
 
-static int wait_for_space(struct pipe_inode_info *pipe, unsigned flags)
+static int wait_for_space(struct pipe_inode_info *pipe, bool non_block)
 {
 	for (;;) {
 		if (unlikely(!pipe->readers)) {
@@ -1248,7 +1248,7 @@ static int wait_for_space(struct pipe_inode_info *pipe, unsigned flags)
 		}
 		if (!pipe_is_full(pipe))
 			return 0;
-		if (flags & SPLICE_F_NONBLOCK)
+		if (non_block)
 			return -EAGAIN;
 		if (signal_pending(current))
 			return -ERESTARTSYS;
@@ -1268,7 +1268,7 @@ ssize_t splice_file_to_pipe(struct file *in,
 	ssize_t ret;
 
 	pipe_lock(opipe);
-	ret = wait_for_space(opipe, flags);
+	ret = wait_for_space(opipe, flags & SPLICE_F_NONBLOCK);
 	if (!ret)
 		ret = do_splice_read(in, offset, opipe, len, flags);
 	pipe_unlock(opipe);
-- 
2.47.3


