Return-Path: <netdev+bounces-280043-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLuNNWU552no5QEAu9opvQ
	(envelope-from <netdev+bounces-280043-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 10:46:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5822243855A
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 10:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47F42302FA35
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 08:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ADF39FCAB;
	Tue, 21 Apr 2026 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHj0wQQ9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A36D39FCA6
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 08:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761118; cv=none; b=fniEAS9lqe6WQhZqrb7nbqk4jb9l8o2k/TRdCTxJL6z2GuBQNdvuEabg0sLWgqR7DFkweKOiXp5RitcEpK9M5eHM5KgyqCEmfqNqEwcA+M4uZ8aJrQQSKi1NNO+P+4n5+9VhTIfUr8PdRgqwkLZs1CebjRa9wQqRJVo3OL/85Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761118; c=relaxed/simple;
	bh=jY2oAnibC/hnxXMwRfhye0JZWn0j5hS9eu/mxZ4RZxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OImbtMz6N9GmEGOfSa6U4/rjtQ8utKBRVvWX2PtvAZHFLBJ2Klde4lJ9XJPS55oGm2d99F3+gFaZ3e20myQ7Izm0FrVeYPqPKMNaigTfob9W5w9e9gTeqBG5RcCqjLkoxCMaH/p42YW/jxt+lPGS5UiFyLZRVWP77YHDO3v51Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHj0wQQ9; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so22649575e9.0
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 01:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776761116; x=1777365916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rsev4JhWJNqcO+Dsxr7am7zy6PUf5mFhTqsSumq1mwM=;
        b=kHj0wQQ9QyersBZlIaq/w8u8lnKPT2W3adEvZAmT6dfish6cWTXTVIKoSLtRxxpRvI
         6+br3FXZCCRNEtDax9c4q94vvKhr3g0wwFu3qnDFaccjR9Y5RcpLrGnrEAW6hjAcoxaU
         heyeHETgTQYd7lNZRYKQrXysK7WXkQMNF2CaPVKf5+r8Q0d/+vPTwYPY5FImbrvWbri8
         3SDAO5ZRsDzNH41+VFBn0NQ9F2/9ufnQxCQ5OI85xbUAlSthcKAFezrqF3KV5X1St277
         u2ktIVzfzRcGNOi0AZx3DNu+X3+rRBfVbCZIBwI44IMVwIiIBWH1dnnNU8cwk3+iq/T6
         JlnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776761116; x=1777365916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsev4JhWJNqcO+Dsxr7am7zy6PUf5mFhTqsSumq1mwM=;
        b=HmCT7Ze0qVu4BkgB+PCdz7etPiLB0s0VtEpBwNnUoFHro/tL5R8WBik79av2E8h0DG
         gkN3Z2As0uOur/Z+N4Z9NT/h81j4gzeHyTQqE04JGhHEIub0w1DctnNG1PmhLch/9bdV
         gxx3i05nLp8+rbZR6jTm3srD0MIgiGdlNc4AhMa2LdOcvWPhtHZXg2FFrXx2WQ2T85Z/
         jFjpnq9MZZ63e5C2As5YW/NRf8pL1gTdpzcwyd0ULnoobX40xE4dLFuguGz+0rCQrvjS
         xPsC33zkZF/nhpXp98B7LSwT38sh6ZWzOi0+UO1cN6inrNW3TOYULzBqcIsvm9qjfGD/
         rENw==
X-Forwarded-Encrypted: i=1; AFNElJ+WPdHJ4z/IXdIuPa1QW2ePGBHWbjdzBCtUVNqfRNfXPCOn/f4smwhWdLBcVlG81Gf8Ty7085E=@vger.kernel.org
X-Gm-Message-State: AOJu0YweTMLfGCreKeF54rUPhLJCDEP8/WNSR9Mm8YkLPUa+t4+iXdAO
	KrvdGygYS+02J7/oisJlxnPaIV/jGvUTpxbgR8Yhk4TZnJEVRAk64ekf
X-Gm-Gg: AeBDies8o6nga2gvb8UEeE/qnSQ5SUyBOX3DPh3PiSP9Rryb053NyXC4HJ8QNoL/jHI
	nldFBdAuFw8ZbupVLVORgyOkW4bB8swdlzO5yx1K3IrxR5l4dZ3Sis1MYoBup0R4o9gMzLMeQio
	pV4zO1l/cFujjNYTyMgoNsTt1E+cCvfsUKXjbgn5QwaxEAnMA5LOxCg0oYI0D0g7WvLhS6U92Xr
	eiv0PGIV5feEd/3DF0GXRclts2jql9okhY6qw2x8W06uCEKnKYpNYUaM2FRqXW9D/nrBRx1GCR4
	H2PZ58+wapVr1ie0yb/5HxIPUkdNonKsVoFH2CcGi/mPHH/yCvQnyZ+L2Jvb7EzEqUe/jQliJWn
	4gqIkmo02ZS0kJ1R4h4vQnSHDnWJDJlDN66zTCWxEGdZioY61ZNd7KmLrR45HVPkWufm/GScvh7
	xuZRuXII7iFrH8qpI78I7DrpZPlR6HD8E1IsurnSxyz/I0JkpNcD6MvvFd4j8mpqJeFGJyzoeuZ
	oXeJcXRZfBzu2H13diJ
X-Received: by 2002:a05:600c:5295:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-488fb77facemr250012955e9.21.1776761115626;
        Tue, 21 Apr 2026 01:45:15 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:e3a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891df9e50asm114549945e9.0.2026.04.21.01.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 01:45:15 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH 1/1] io_uring/zcrx: warn on freelist violations
Date: Tue, 21 Apr 2026 09:45:29 +0100
Message-ID: <2f3cea363b04649755e3b6bb9ab66485a95936d5.1776760901.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-280043-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,snailsploit.com:email]
X-Rspamd-Queue-Id: 5822243855A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The freelist is appropriately sized to always be able to take a free
niov, but let's be more defensive and check the invariant with a
warning. That should help to catch any double-free issues.

Suggested-by: Kai Aizen <kai@snailsploit.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 2eb09219f0a0..7b93c87b8371 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -602,6 +602,8 @@ static void io_zcrx_return_niov_freelist(struct net_iov *niov)
 	struct io_zcrx_area *area = io_zcrx_iov_to_area(niov);
 
 	guard(spinlock_bh)(&area->freelist_lock);
+	if (WARN_ON_ONCE(area->free_count >= area->nia.num_niovs))
+		return;
 	area->freelist[area->free_count++] = net_iov_idx(niov);
 }
 
-- 
2.53.0


