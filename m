Return-Path: <netdev+bounces-299693-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tipuItWjMGowVwUAu9opvQ
	(envelope-from <netdev+bounces-299693-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 03:16:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7DC68B340
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 03:16:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=gY4GfdU+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299693-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299693-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A10630B50BC
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC18367B69;
	Tue, 16 Jun 2026 01:15:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0EF348477
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 01:15:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781572528; cv=none; b=n+oL/OSgPEkUfHQDvVIxCZIR31jS5zoTONBJxw8CMQBFjtIsEXXEMMaG4KRZpQrny1eXj56vdSkav3u1BnMkaZ/KyfAwX/JotfURD+sZl5vQLlRx+/3Pe7OyVdJfewY2ZYUa0PHxuyZ3EdIivXxiDu7jNotuv5Xp1RJ9+39w2EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781572528; c=relaxed/simple;
	bh=qSWoZgNw3PpVwHOk9/H/f2RnG3uRakwqaf1M/1PGtU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jixU3q8eNIr0Vr0ltBhi4w+5oN0k1SH1b5xImfEGt92WJ0OVeqfxqF2xHCwbVQTurxdTnLZ0JjUHK7ACVQISoIdijDczE+RfPYtJl8YhlWerQIiUyZ3jGKL9HJ2+tDME6OTR5NKsAhxeYvzpdqQFcOIl116l5X1mmKiJLfLAOIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gY4GfdU+; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b3637b90so30177105e9.3
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 18:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781572524; x=1782177324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53973eSawR2ZjjRuPt5kDFsVlZ1YHqdNePsF+6+pfeM=;
        b=gY4GfdU+fnf2fpkgHqn+YKSNu2S3tZpA4UYKriInFnsJ2ouxdKifTLZo+v2WRUVzVv
         l6ChYa8hy8b32sF5eihbKfCnq9ej6soPiI1VfrgCx+wpMYPIBffRw/IkkVHkATe3HfsF
         7biBiYvPB+QDdCV8fAVbNNMOmm/duLs125U/h8rlc6UfLQgKO7ZT2w/t3oj7W9TyGV8V
         vugqEIAZUEiatJwF+z+uscmYoEMGGTOvmbPQql1VT3ooCsni4RN3lUOxSjoOF1G0uWrJ
         44gD0UQ2SK5QUqE/od+j4iKtbzcAsww1GLqoTJT63nhUr97UfLH7pq8pzb8H0U3ls0bJ
         Cg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781572524; x=1782177324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=53973eSawR2ZjjRuPt5kDFsVlZ1YHqdNePsF+6+pfeM=;
        b=oU5ugvQC2AocPudGw1gGABme2GFMKf1T/Xrt7Slfn2/eklLwE0t4qR8QPGFZfJYfgM
         JOKfDt6M3DrS5R4OSMPYT+pf0PoMXtMEb+pkPUHCIi4zfyOGMY+U5qdH7Xnln+uW8ekJ
         bzJCeDgQI12HOVsqjiD5DHm1uElaR33s7VC0u3tTmYy1NWu8DHQW12fu1ULe+YQfJzkF
         2Ci0T1iRbgTFrXk4YZQCaxNHjV8Xvh78RYMe3JjGHYZPFyF94NmRbAAv5lAjiuTFh1yY
         nJuHJl/1ACyZtAUrFmorG34UZ0mhfTnWP9DfMn9fNw8ZZfGnweFNEdHLVbCCkjVh5DR/
         kq3A==
X-Forwarded-Encrypted: i=1; AFNElJ8pWdr2dyEDrRaFUc96e6bk/kQ6mJTid250tC/X518yQaDyZTaag0fANVHF/L4Z9/bhzYyj48Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLD6U+p6blGDKPmrdgTziCXt72PxhYam09vVA5SuKZRa9c7o9U
	4fh+XQKdO7geuHMMjIrpiA6HtGR+oonwpd6qkfaZiAwC5QKXOlJgxZHc
X-Gm-Gg: Acq92OFO+kXe5jt484yrS3vkoG+rscfG1b87wBivP6Xn25TRuyFVUYEcQVKEbr82khw
	P17CuyWlCJlNNV7zFqoxOVERla+XD2TGfFHrRG8kQqNo++EmPnFRiAJHTnVgstDWURLRC3V+NT4
	gF/8ICPDHRrEXe/YJ04nn/15jJPIXyqlC4Bv3LjfY48zZYMIpT1Yrl2BNFgZ/OJx1tcvHPhmIiH
	jRFrL+XftPxnQImuHpcToWk0fROFqoSmTiO6TGUoviWaGbLHpQfXpa3Hyo1rTD+mnOraHUoFMhj
	TITaDEysuCFFwGT/IGyKCNMNxN8MwR63FDb/ORXd2mUT+v8UtqAn21yRa04l0wrHf4QfNdm9sTG
	3cXKgDrQhEPS+23+ibkR4etJa0wOdEEvS/u+H+tv51bhc6F781d6BU5AHrqz6jKvkuuScV6rvZG
	TP+qMoBnHU8HgI7ijqd2Y=
X-Received: by 2002:a7b:cd0b:0:b0:490:b2c9:e284 with SMTP id 5b1f17b1804b1-49220143bc6mr120782165e9.30.1781572523711;
        Mon, 15 Jun 2026 18:15:23 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4922fa47da9sm43123095e9.5.2026.06.15.18.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 18:15:21 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: joannelkoong@gmail.com
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	bernd@bsbernd.com,
	brauner@kernel.org,
	david@kernel.org,
	dhowells@redhat.com,
	fuse-devel@lists.linux.dev,
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
	rostedt@goodmis.org,
	safinaskar@gmail.com,
	torvalds@linux-foundation.org,
	val@packett.cool,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Tue, 16 Jun 2026 04:15:09 +0300
Message-ID: <20260616011516.4039110-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAJnrk1Y9egYizkx1H9K0cqxSYuB+7vLvQbV7Tf4C5eHFqnnC-A@mail.gmail.com>
References: <CAJnrk1Y9egYizkx1H9K0cqxSYuB+7vLvQbV7Tf4C5eHFqnnC-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299693-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_RECIPIENTS(0.00)[m:joannelkoong@gmail.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:bernd@bsbernd.com,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:fuse-devel@lists.linux.dev,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:rostedt@goodmis.org,m:safinaskar@gmail.com,m:torvalds@linux-foundation.org,m:val@packett.cool,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[safinaskar@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.dk,bsbernd.com,kernel.org,redhat.com,lists.linux.dev,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,suse.de,goodmis.org,gmail.com,packett.cool,zeniv.linux.org.uk];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB7DC68B340

Joanne Koong <joannelkoong@gmail.com>:
> > speaking of fuse_dev_splice……_write actually, this series has broken
> > xdg-document-portal!
> >
> > https://github.com/flatpak/xdg-desktop-portal/issues/2026
> >
> > Specifically what happens is that the EINVAL is returned due to oh.len
> > != nbytes:
> >
> > fuse_dev_do_write: oh.len 16400 != nbytes 15526
> >
> > (where 16400 == 16384 (read len) + 16, 15526 == 15510 (file len) + 16)
> >
> > After reverting the series, there is no error because oh.len
> > becomes 15526 too.
> 
> I think this is because of how libfuse handles eof / short reads. When
> it detects a short read, it fixes up the header length after the
> header was already vmspliced to the pipe because it assumes vmsplice
> mapped the header's page into the pipe by reference. It assumes that
> modifying the header length in place gets then reflected in what the
> pipe later splices out.
> 
> The logic for this happens in fuse_send_data_iov() [1]:
> a) sets out->len = headerlen (16) + len (16384) = 16400 in the
> stack-allocated fuse_out_header
> b) vmsplices the header to the pipe
> c) splices the backing file to the pipe. if this hits EOF, it'll get
> back 15510 instead of 16384
> d) detects the short read [2], fixes up the stack out->len = 16 + 15510 = 15526
> e) splices the pipe to /dev/fuse
> 
> After this patch, step b) is a straight copy which means step d)'s
> fixup doesn't modify what's in the pipe. This could be fixed up in
> libfuse to not depend on modify-after-vmsplice, but I don't think this
> helps for applications using already-released libfuse versions. I
> think this patch needs to be reverted.
> 
> Thanks,
> Joanne
> 
> [1] https://github.com/libfuse/libfuse/blob/master/lib/fuse_lowlevel.c#L846
> [2] https://github.com/libfuse/libfuse/blob/master/lib/fuse_lowlevel.c#L956

Uh, this is very unfortunate. But I still want to remove vmsplice.
Maybe we can somehow save my patchsets? For example, let's return EINVAL
for this particular combination (writable pipe + SPLICE_F_NONBLOCK).

-- 
Askar Safin

