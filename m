Return-Path: <netdev+bounces-301318-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id etfCAZZVOmps6QcAu9opvQ
	(envelope-from <netdev+bounces-301318-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 11:44:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A25B6B5E54
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 11:44:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=YGHMw40j;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301318-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301318-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D08C30864F9
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 09:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11323CF675;
	Tue, 23 Jun 2026 09:42:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F3A3CE083
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 09:42:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782207766; cv=none; b=Pksm1Q9vV0/ra1aHIWges2m+dH8Uy2RnFWvo+JoZlHNr1drOTdrtfKM0pGc4ujzNFwFZqbPWYAyLO07xWgbiPTUbSA+heg866OqGF659jRQe0pgP7orzHu07btPZzftLKFWWU4QsWNJrsbZyvyQNGY32JTcndon5x4Re/eA7c8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782207766; c=relaxed/simple;
	bh=B8aiSRXgNzNgIcTsqvlM+jiX5YYMrahhBOPApOswCwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUdWYfNaGBLL0/SIr0DOlh40/GrGbCD60d3PSmAS61DdzyJRPqkwf0kUWlI0Q3M8g3Ts32vZfSLuttuLu3Q4gUehugpuTZCp7cKmAP5OsfkDTtMsMv9g3+ncI2uJtNZ7Jws/rlJ7EApC5ptK3gWzvLj9D2qtVH+DM5eMfu5D7T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGHMw40j; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490b3637b90so42096425e9.3
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 02:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782207763; x=1782812563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SJWx7Zgz0Pyhs4JZwrYmJyYWWMlxydwzpM41quzKVA=;
        b=YGHMw40j4hj6TfkUnHCRzMeFQvWey1PFjYwC9WxoimkjXSyYUToNiCRRG3XizMJyVX
         R4ai/ZAAtQDz4f0JWVvcuKQwNrd5Txlkb06UI4Ip+E8l4eB26vkuxuFn6OwMwOYXB61O
         kCwX0AeABcbrjheN/oka2jvup/pAupU+T8RVm3c6KdjPN3Cw8ivsZFWQa+3luBAcmyHJ
         J/ccU6I5B7wsmabeYLLM2iBu+F6a7H0unq3OEVcxPr0XIQHv8J7AknumxKhEAFyiYQs6
         +mqpx2Bs3bCk6AORQ3O0om6vm75JrMhz6Uyb5FEYTnIsi88xM/cBebtwCOEISqrxBiUn
         GWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782207763; x=1782812563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3SJWx7Zgz0Pyhs4JZwrYmJyYWWMlxydwzpM41quzKVA=;
        b=Klr5E8jLOJQXOy1dfk7zWa5iK5uW+kSWj2DEl1kx9RN+8LXUotxxJYafxGWbPAa4SF
         tXLC+Ij2FWn42/cEL8XLVF0ILkv1RvUXEA6bRdnFDG1cTvrFJ48R93PmYAD6Dr8XDxiS
         geJUfa5xc5Awj0gjQSVF7hw8TwNEpz8fjAaYwEFJt+a00TDQScEscveysv6dzMrkyQ9s
         O/DjHS9z+efoZT4W1tY22Df5rapTBibKUEAG0Ymr0T/mvkgPoVnmms8M/I4ec9TwvgJh
         6rXWzdrcbBX/Rvf8h5lXs2+L/+Dc1PA7+GPR0gyZMQ0TuI5OScYkQDBlkNf+MGBHk8Yt
         tMrA==
X-Forwarded-Encrypted: i=1; AFNElJ90FPi10EF1i4VNiiRKzubj7GDd/Mk76e7N+VppRwDBAEkzmrTmm6gRsrSpHjYZQ74XyWmO80o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhlPZb2fvPpI4nwl+S6Yzq2VD2RRkmpBgcWO1c8XpIGlK83TPz
	js0xaV9eSNvoOzcSzLJi8HTj8N06Ifsq1eAYnfkLoi3RpEYr38cB/hTE
X-Gm-Gg: AfdE7claq3NHArWZkQxuV0iSHx3jPtfDxj1yE1+25I+cWYjHusqHoYRpQV6RtIBn0JJ
	zKnhGSCpTfMsa4taMruLDx7HF1zo/BE+Oph7zf0m5vld4tUTBvQPpmEoKGJSV59RSUg/I7E9apE
	c4jMaYw5jfak9qUpZjQmvGAjnKjQXCutiSoog7ugaLOEud1UyO/X6aLj8UpE6otFChYPWDEMhq5
	UEFz/gva0Hcyiar91mB/gamcnECnwmIK2omWI797308Pr6sW/jM07+P41D461HdllYNvtL4UYDQ
	3Gq6Ig+K1KUHXFuaM73lFj5bVmrfIv8uYNe5pcBHa7KuRhyArBfQZKCKMtMH0BloTqPp5jhWnSx
	OMLOsHxy/XZnQeP4xxiJiVFwl6awllLJn7ickCIXq2vSYJaKkNxvvcZt1BIyEpG6MNBuOTRfJSX
	1+cQwwaJfn
X-Received: by 2002:a05:600c:8b8a:b0:492:2e48:81e6 with SMTP id 5b1f17b1804b1-4925b389b83mr30093645e9.4.1782207762970;
        Tue, 23 Jun 2026 02:42:42 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49249455302sm280248525e9.15.2026.06.23.02.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 02:42:42 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: avagin@gmail.com
Cc: akpm@linux-foundation.org,
	alexander@mihalicyn.com,
	axboe@kernel.dk,
	bernd@bsbernd.com,
	brauner@kernel.org,
	criu@lists.linux.dev,
	david@kernel.org,
	dhowells@redhat.com,
	fuse-devel@lists.linux.dev,
	hch@infradead.org,
	jack@suse.cz,
	joannelkoong@gmail.com,
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
Date: Tue, 23 Jun 2026 12:42:11 +0300
Message-ID: <20260623094211.1080873-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CANaxB-xVCP5HSUNwphFrKPdW0Qh1pA33A6npac60WArkZMFt7w@mail.gmail.com>
References: <CANaxB-xVCP5HSUNwphFrKPdW0Qh1pA33A6npac60WArkZMFt7w@mail.gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	TAGGED_FROM(0.00)[bounces-301318-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,mihalicyn.com,kernel.dk,bsbernd.com,kernel.org,lists.linux.dev,redhat.com,infradead.org,suse.cz,gmail.com,vger.kernel.org,kvack.org,szeredi.hu,suse.de,goodmis.org,packett.cool,zeniv.linux.org.uk];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[safinaskar@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:avagin@gmail.com,m:akpm@linux-foundation.org,m:alexander@mihalicyn.com,m:axboe@kernel.dk,m:bernd@bsbernd.com,m:brauner@kernel.org,m:criu@lists.linux.dev,m:david@kernel.org,m:dhowells@redhat.com,m:fuse-devel@lists.linux.dev,m:hch@infradead.org,m:jack@suse.cz,m:joannelkoong@gmail.com,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:rostedt@goodmis.org,m:safinaskar@gmail.com,m:torvalds@linux-foundation.org,m:val@packett.cool,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A25B6B5E54

Andrei Vagin <avagin@gmail.com>:
> Actually, this change introduces a performance and functional
> regression for CRIU.
> 
> Here is a brief overview of how CRIU currently dumps memory pages:
> 
> CRIU injects a parasite code blob into the target process's address
> space. The parasite invokes vmsplice() with the SPLICE_F_GIFT flag to
> pin physical pages directly inside a pipe without copying them. The main
> CRIU process then takes over from outside the target context, calling
> splice() on the other end of the pipe to stream the data directly into
> checkpoint image files or a remote network socket.
> 
> I ran a simple test that creates an anonymous mapping and touches every
> page within it:
> Without this patch, CRIU takes 9 seconds to dump the test process.
> With this patch, It takes 18 seconds...
> 
> Plus, it obviously introduces some memory overhead.
> 
> If these changes are merged, we will need to completely rework the
> memory dumping mechanism in CRIU. Using vmsplice() in this proposed form
> no longer makes any sense for our architecture...

I just have read some docs for CRIU. I found this statement:

> #### Why `splice` is Better:
> *   **Consistency via COW**: The `SPLICE_F_GIFT` flag ensures that if the process modifies a "gifted" page after resuming, the kernel performs a **Copy-on-Write (COW)**. The pipe buffer > continues to hold the *original* version of the page as it existed at the moment of the `vmsplice()` call, ensuring a perfectly consistent snapshot of that page.

This is wrong (with released kernels). I confirmed this by testing this on my current kernel (6.12.90).

See the code in the end of this message.

If you actually rely on mentioned consistency, then, it seems, CRIU is broken.

So, in fact, my patch actually brings consistency to CRIU. :)

-- 
Askar Safin




#define _GNU_SOURCE

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/uio.h>
#include <sys/wait.h>
#include <errno.h>

int
main (void)
{
    int p[2];
    if (pipe (p) != 0)
        abort ();
    char buf[1] = {'a'};
    struct iovec iov[] = {
        {
            .iov_base = buf,
            .iov_len = 1,
        }
    };
    // I pass "SPLICE_F_NONBLOCK | SPLICE_F_GIFT" here, because this is what criu passes
    if (vmsplice (p[1], iov, 1, SPLICE_F_NONBLOCK | SPLICE_F_GIFT) != 1)
        abort ();
    if (close (p[1]) != 0)
        abort ();
    buf[0] = 'b';
    char buf2[1];
    if (read (p[0], buf2, 1) != 1)
        abort ();
    printf ("[%c]\n", buf2[0]); // Prints "b" as opposed to "a" on Linux 6.12.90
    return 0;
}

