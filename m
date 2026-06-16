Return-Path: <netdev+bounces-299686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O8+ZNt2bMGqqVAUAu9opvQ
	(envelope-from <netdev+bounces-299686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 02:42:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3696D68AFE5
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 02:42:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cXKx2If0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299686-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299686-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2EAF301544D
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 00:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEC32571D7;
	Tue, 16 Jun 2026 00:37:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3D0C2EA
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 00:37:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570256; cv=none; b=RH+FSoYmtU0IVZEBjsnqqsKBihJdbw/GuF33W8Ie6qsR6/O1V0r+K/QwPzlhrVMlqrB/Xsw4udynzvbwWadiD3aIC8rpPTI1CxTZalapAqkpm9eV+Lrsw83kKOdTJildDLKJAkhvA9iARJBsqjrlgFLnK8Z5JJ70UtBgvrIINkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570256; c=relaxed/simple;
	bh=p91yC0380ci6RVyhXJ1kuAXKj9VL+EWnmfNds5Mm5/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRgmpETIOqu2jQX6vKjF9Ttx/OEAXQcFTzTj/KtI+imZ1wA3Nano1TOfFJgT1P/AU7cDcLcHK+S+5xY1JB37GyprN+VN7+gD6vcXdQ4ueev1TLArNsxDCjUDKMPcV8Z/aEn0hPaGYlXUW3LO3t/kGTcuM5byQpVC5uzglsM5nW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXKx2If0; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490bb83a3f6so30863645e9.0
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 17:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781570253; x=1782175053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFPF4sC2peklNMGORgGTd/4IxXXegAkw7S2lBmPrG1Y=;
        b=cXKx2If0O5uoxGazgOHP2e49iqcvTwTtqYvtYQ9fxEj297PwBpNzV1VGOo+P1bkdGZ
         pL8m/dAJG5/eXlbYJAe4BGkMPFSh7fZJz4GaymjDJVG2iiqVkXPONzbNYNblUaCt9IcO
         3ZPVUlbW/pCjck7mIZNaubCIpo/sWpoKe5YBxE7W+GmPlVgY5Yq4pZuUqcRCHJsZgFfh
         FQuLtOkUOb+zRGi5yMdTORX5WquRPRlKfP9mJi4fBnyLdTpx8lV+dSfDbhxM1yVUJ56d
         yXkQuOJaIe+9pzY1LpC+7WX2iP94q9CkdvyMuevov+StNCINA/hSlxgm0j7bZV/ge2pe
         upqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781570253; x=1782175053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iFPF4sC2peklNMGORgGTd/4IxXXegAkw7S2lBmPrG1Y=;
        b=ju47QNHvk/T5AEKpmGjf0OSsWm1aaIm1fnoqOJykxQxQU8fdj9NefYaz7HAUHa0ekT
         tnb4VRKg3ma9fVTzAIDmlMWCJHPhQBk3lxy5Y/CJ2O393y4zIFCBUGAX8MCB50Ttgp47
         cmw1zXl1b6/Qzr4IY88ky1pX+2VfAtABlcA3Og9rFJkfuJ3A9nQxCXtXYnFAeiX+kJmQ
         xKXr0zfk1TLEDCoIo17aCMslzB0i8/bvCy2PAjsOGQWZ9q9YKaWCa/r4EmKJKNkT5tfu
         3QcpUuo42l1RreH2O4S9KVEpLdS0sOC5/V/GOOaioZZ+/IyOoxXGVWh6mPEF06wqi1px
         y4lg==
X-Forwarded-Encrypted: i=1; AFNElJ++I66klOzToTgdNxPsTFLFD6Sl52mTR5rpZd7bMEnVHldim+3U+GDUj1MUshyQRI167w+JpI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn226OaJ9eFDYjocnNNQlWvD0Req7B0LckQf+wgbeQIZX71EHz
	q8UqnGm1IL5C4btlEoHMVQvB9H3cExtqP2ec2GrcLR8Lnl5mHohwNFYj
X-Gm-Gg: Acq92OG2GHYLdvBamBaqSR2R434K+mVU2MMKUMJbx1G5f4Dv+uFDOGZ9LfZ5rFdwZ0W
	+c6cM7nU3KjnfrA1FXeK6kt0J4wxU5OIf3Z95zhvXs4bZLe6fqm60EYEiD28XjRcm1A4NsgQcRN
	laLrx5cDQEDrb67Yi7NzvyuvkGU+vpCmFQyL8/Ivlu1rL7mQDgWjNyY21qcP7F6xMWyo/FZqGD4
	dEqQK68uP1tpjaCXffupI0ZvEAdGZ+nZKwcaujqaGlk8ItF3TAn+bZvtNUx6n4G+0ovI3X+547J
	DPfNbBBxLdxs/ahmg0gDbvNQ3qWGMGleRWtq/3gfX7PMqsgYwtGdfUj+Q3JZBhLEZbjr33NB5n4
	m7PxnKZbBZGd0kyrgqtRzdI79tFUfN/d++ujAvqJfmcKVM/1nFS5c9mOMyHXrUJXcyhx7aj1BN7
	uQ/+JhbbTm6TzGCaEotr0=
X-Received: by 2002:a05:600c:698c:b0:490:b025:f324 with SMTP id 5b1f17b1804b1-4922ffbdad4mr19600415e9.32.1781570253120;
        Mon, 15 Jun 2026 17:37:33 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490ea4b39e9sm238270495e9.0.2026.06.15.17.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 17:37:32 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: agordeev@linux.ibm.com
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
	linux-next@vger.kernel.org,
	linux-s390@vger.kernel.org,
	miklos@szeredi.hu,
	netdev@vger.kernel.org,
	patches@lists.linux.dev,
	pfalcato@suse.de,
	safinaskar@gmail.com,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Tue, 16 Jun 2026 03:36:59 +0300
Message-ID: <20260616003659.4002764-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260608171917.3195488Afc-agordeev@linux.ibm.com>
References: <20260608171917.3195488Afc-agordeev@linux.ibm.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299686-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,gmail.com,zeniv.linux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[safinaskar@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:agordeev@linux.ibm.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-next@vger.kernel.org,m:linux-s390@vger.kernel.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:safinaskar@gmail.com,m:torvalds@linux-foundation.org,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3696D68AFE5

Alexander Gordeev <agordeev@linux.ibm.com>:
> Hi All,
> 
> This patch as commit e2c0b2368081b ("vmsplice: make vmsplice a trivial
> wrapper for preadv2/pwritev2") in linux-next on s390 causes the selftest
> tools/testing/selftests/mm/cow.c to hang:
> 
> # [RUN] vmsplice() + unmap in child ... with PTE-mapped THP (128 kB)
> 
> Recently there has been changes in THP area, so the problem is not
> necessary linked to this patch per se.
> 
> Please, let me know if you need any additional information.
> 
> Thanks!

As well as I understand, this test uses vmsplice to pin pages.
I. e. if my patch lands, then this test should be rewriten to use
some other mechanism.

-- 
Askar Safin

