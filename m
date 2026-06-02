Return-Path: <netdev+bounces-294448-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YiVEJ2lgH2qIlQAAu9opvQ
	(envelope-from <netdev+bounces-294448-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 00:59:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CB9632BB1
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 00:59:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=J5lBxgVZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294448-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294448-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B272A302D956
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 22:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3173C8724;
	Tue,  2 Jun 2026 22:54:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27693BC69D
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 22:54:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440876; cv=none; b=IpriBC7ehHUSNndFmZe9DRjwYrV6554W7GSk7uB9E/ut6ya8GoIV/C0hy5Id4ulB+IajCikYJN7PMrQWu/PjTfBZs4C+4teUqL2r9R3eo6jxVP/9STXX8On/RwGKlowGhdVf9gWBul959VvoaFW2lVdhKMDq0WLDpkKhtqquwfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440876; c=relaxed/simple;
	bh=X+6iZWTfWXpo410W4glUkXVe/Shkkk6QObVykw+rX6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q8n32Ckb7i5mo12aGq7QMkGFRsnWZ/Et4EkE+ieHfS8olW5UcCjhT+5FF00uDSzlo2I+n17TVl+PbDD3f4Rm15IqoloSqanC9cYFbqsSRPMkmsJnxqelmGAjU3OJcQI7eRDOYii4DssFLChb+9Uequ5mAFCORvegAqWUL6kLJXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5lBxgVZ; arc=none smtp.client-ip=209.85.221.44
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45efb698ef2so1971352f8f.3
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 15:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780440873; x=1781045673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Jl73xD6zIPi47mu1jowzc4phm5baQXMI7icQsNN3pI=;
        b=J5lBxgVZtN2FI/ioqwhDNCosN/jZxozQdxLdEv8Lsv6+u08aS7OxTXrQzGg72R791Y
         z32rVB76ykLqfRKHMQDiGLQGAmHWCKGHI7AiNnVW1XWIXiMnT2eX5t7ZtVn5WJ9pzdxr
         bfL67m+3y26zQeyeaJEk577celexSXvREDjuhI0lTlSDWcyIshaKWjaTihfPmJhfCIwd
         MH7OAX39QaAQh41d1ecKqz0qNgVt+7a3qN85DYTIMQaZ2dwdMsWfE0NHmsWsCaSLpamn
         zO79gWY9UqRLT9WZWT2xXwMwr6B588h+pNV2K+1vQX1dtxuAKvd+s0Ou1C9kqMvX0vVP
         NH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780440873; x=1781045673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Jl73xD6zIPi47mu1jowzc4phm5baQXMI7icQsNN3pI=;
        b=c9rdiC0752P2TpVJ94MD/88a+61b3jESk381t56G3El0vVjHWQBzQw7hUWR8HThd8P
         9RJMkDcEVhwQZZWd9z0sSBsUvkNdNfk8RZVtDhDng//MHATD3IYgBnCtuO+VlqWeYYEu
         bBx4N97CQ1+GjsDqrcyHGw9dd9wNc7cOHjnauHg907ngvAkT96Z7HX5xH8oNHn3LK71w
         qj8crbNqsqnRpHlRJj+d1L0jqHrYQ/zavzDUDlWEQ33+smmZsL6VKpsyGYpZyloGEopf
         UUuFKORytcPu7Wyxc9LczxvP2fGUf423k/9wEH4aYs/wvtKMrax4lIn5VAmiOw81xJfb
         SeNw==
X-Forwarded-Encrypted: i=1; AFNElJ/P4WE9HIdLtLNVTa1mnjLF3COsb6/8pUHpjok7ZE05RsQHYtR3b3npvHAEo46vkOTlqrwpXGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDpGLJufSQs90e96GIK498h0r0oSkmEbMZdI0ycMHpIUro2HIo
	807x7jkkBp3CsYw+dXoTuJhfe/pjcE9o+zLECPpIYdv6Hoxmu4rz+PDd
X-Gm-Gg: Acq92OFO8Cm0YMiUYQDKSmxdzDa2JdU64akqM2LC92pcrkvYSDg0ianXLbb+5aSRB5o
	iK7EXV/EZwF2u/Ghqbowx4tPRgnHaHjth1XOQQOrzT3HXmQOGxPbT8/D3UqK1lM7K8ASSMa24TB
	fUZu6WWqvVY695JjgDTvasBwdrMnJQEfOv5M/ldTyAx1rZivpuMYwlpnyfchMhZHdoXUTtRci7i
	A75+RPoLAVsvfTCAZdqdbrotJQT/3w56gXqyObPHJmYobc8xuDBnGvfsz3VOzxtrBKdVYEgMe/t
	iNC2KlQGAJTJzQsQTl8I14CvF2P9AhPmcDuYJnQJTX2PRY0Rl+s10iMZPlohYPlydgYaZh2EOYk
	Na/Rw6f6PPX65vB3D23AzWj4V8cXN5Lv6//Ofte7wpaTMZt8pX7o8N4Axa0MbOGwit+C4Ir2xrA
	sUrDqu5D86Z1AZX8A4UC4y2M49aMM6KcjWtdfkwVZW
X-Received: by 2002:adf:f58f:0:b0:45d:3cb0:5ab1 with SMTP id ffacd0b85a97d-46021873b26mr407422f8f.38.1780440873290;
        Tue, 02 Jun 2026 15:54:33 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4601f2dc577sm2550100f8f.3.2026.06.02.15.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 15:54:32 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	brauner@kernel.org,
	david@kernel.org,
	dhowells@redhat.com,
	hch@infradead.org,
	jack@suse.cz,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	miklos@szeredi.hu,
	netdev@vger.kernel.org,
	patches@lists.linux.dev,
	pfalcato@suse.de,
	safinaskar@gmail.com,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Wed,  3 Jun 2026 01:54:26 +0300
Message-ID: <20260602225426.122258-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
References: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294448-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,gmail.com,zeniv.linux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[safinaskar@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:safinaskar@gmail.com,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17CB9632BB1

Linus Torvalds <torvalds@linux-foundation.org>:
> That isn't what Askar's patch ever did.
> 
> You apparently didn't even read it.
> 
> Honestly, I think you are the one out of line here.
> 
> Askar did something I suggested years ago, and didn't remove any functionality.
> 
> It just changes vmsplice to be a copying model (one of the directions
> already was). It doesn't change regular splice at all.

Pedro is talking here not about this vmsplice patch, but about
my future hypothetical patch, which will remove splice-pagecache-to-pipe.

Let me clarify, what I want to send: I will make splice-pagecache-to-pipe
be a copy. I. e. this splice direction will continue to work, but will be
possibly slower. I. e. I will do something like this (see end of this email)
(absolutely not tested), and the same thing for other filesystems,
and also I will remove resulting dead code and remove
pipe_buf_operations::confirm (it will likely become unneeded).

If Pedro sends this instead, this will be okay.

diff --git i/fs/ext2/file.c w/fs/ext2/file.c
index d9b1eb34694a..8edcc3769793 100644
--- i/fs/ext2/file.c
+++ w/fs/ext2/file.c
@@ -326,7 +326,7 @@ const struct file_operations ext2_file_operations = {
        .release        = ext2_release_file,
        .fsync          = ext2_fsync,
        .get_unmapped_area = thp_get_unmapped_area,
-       .splice_read    = filemap_splice_read,
+       .splice_read    = copy_splice_read,
        .splice_write   = iter_file_splice_write,
        .setlease       = generic_setlease,
 };

-- 
Askar Safin

