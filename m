Return-Path: <netdev+bounces-303485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +bgLJBy2RGpkzQoAu9opvQ
	(envelope-from <netdev+bounces-303485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 08:39:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2866EA478
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 08:39:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=EuxziFIJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303485-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303485-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 001A73004C3D
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 06:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED073939C2;
	Wed,  1 Jul 2026 06:39:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2727137646B
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 06:39:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782887960; cv=none; b=t9llEdg1QV3mCKBzHcPe/d/YWzNO3guZvHl4KcmYw9XS49OWLcI/AwRBpMbNX85m4tkz99jRz2DsMA+wKY+CLVamzmbAkT5jcKFBGuquOMivphzfcVhDfMy9+pvK0lyw4k7HO7wSSA+C6N764nd9iC3Jrf1dpMenIcw7Ul8C8kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782887960; c=relaxed/simple;
	bh=c3UXkmSf/U+KQu2LbfQINtMaYbmZc76jB9bbaDgnsC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GsOjdQvNqPYfGgqqhsJe8rPWBPq0GeNayDbaIHAzn3ynUybiQu+tBnAaD2QdQYpDQmqrAB1SJnxE9hM7VZkFCxQ9nAKfqxCbjxW4jRLFtOSP77jalcb4elaNfpfJ/t8BR39EZAu9OpJRnnGX33aCPGAX0+TcrFh5Gm3dxJuO63M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EuxziFIJ; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493b1710405so1279545e9.2
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 23:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782887957; x=1783492757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9lS47Kg6rDUlabcBxfm0AD8NjNyWC3LZqIIiOY+ZJo=;
        b=EuxziFIJv5R/EkQllUWaovqol6oj4qfkobLr0ujMtxhcZF93swOGZeEokU3Dp8qJLI
         d5Q4D/eJB5LD1rVz89LiJBY6DwE9lDPCqwqYUyhmt7BkTml4dWx9yz/kKzC2MxLrPfUE
         1LvsjFIRjVWKbbhgR89YeHPlgSuZiKy4XVbMsiq5pzOOC609AnUYqstX68IqQz/MRqCn
         m3bCVawOXu0QJ78R32CehmIoZ8lvjALxT7p22s0srun1AttdQQIjV0N/aV377ekTyjyw
         QGsPFA46IezdtmW1JeSLkAaUD0Sl+jRQ3a7qWove72lDwf+sIQFQep/X9Koodio/f/rN
         P79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782887957; x=1783492757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L9lS47Kg6rDUlabcBxfm0AD8NjNyWC3LZqIIiOY+ZJo=;
        b=iFjA6nTQXTuA0doKI4RFIu/W9PcxfLTrruqoLxyGf1GLpO/GEc9PkSQ527sNMxZ2l/
         zL5oC3sPukZV0JvVh4T2nUqNuVF/X8M/nuyu88ZW/58YkMwYxSfxcaCC+gByNZoEtfbi
         m6kfSKQLm6NAGl2i1eKAmlV+S/UaCeC/9B2Etds4axrNyvUGh7fVKuig16IHuLZmCSao
         xYWUiMrjRNWTuKPKOonukx1HqTwtyefsPzoftJaGMO4SKDKFUTZTF5R8Gld3cTbVbymk
         +w49nPJ+2eQwxqRr5rGb3P0pYuwXPYKzgFLujHS5g0rvtte5JN3qaptEiRL02/ylZ8qu
         MIDg==
X-Forwarded-Encrypted: i=1; AFNElJ/ViHSx7kroaOBHZKfLyAu0MSbxg2Odkh5ULqDavOYevXyh7aC1tSrkiwMARKcgprMljKu2BVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo9yA1FI4AHtMszYaqDErwViZSiNxLyxbuwk5de7/QKtg3ozSr
	8wTuBaxzfBGD2xP0CQzhaSQnk0HGo9+EYuCEn2zo5Rfgt5LqYK7gLTOyuc2hWMPyD0M=
X-Gm-Gg: AfdE7ckwr/Gnklcueyznmq2q+TXEoQrm1tgNFkX7V/g6EKy/gd7XOT1ngInHuqEEGf/
	iXg8rOQHn2pY6Chb/qeegE0FrFIRo/92HbhyNeIC9q/WQuNx2UdyYmPOQxVQNtSlqyp+6DLBfCD
	jOLTKRwL68Y32jH4STWXJh5AYmm3j/DYXXtRdfk0+Ib1IBNwTr6dBkkObI1rtRcQdGuWE2lMKQa
	mI22bXt7mkJtWmDh16D0oiifRsxC21qYrdyIw0hswANJ6utdyEn/atyR5QaAQ6aejN6+a36qJfR
	zuEUn/BMyTaIvB7a3pEXxpVD3+CY7CJ6Sd2ttUqGryyUtmrAwn5/R2CfoLATGDDc7Grm+Jl6HJ2
	N/0zGpqeIoVGEPc8TyJOnj4mjZzACrnfan8QyBj1ay6R8aYLNO/9u7hp0wc7w+P+IN+eODVkgua
	DYROjeTLt3x7kw2KDauubZusGYTZbpDEktrgYLBQhXL/CpUM8I6G6ZjHjsWLbY1qICLb39bqSq
X-Received: by 2002:a05:600d:6409:20b0:493:c21a:11f9 with SMTP id 5b1f17b1804b1-493c2b38eddmr3043765e9.6.1782887957236;
        Tue, 30 Jun 2026 23:39:17 -0700 (PDT)
Received: from localhost.localdomain (94-43-5-44.dsl.utg.ge. [94.43.5.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4bfd47sm70551775e9.2.2026.06.30.23.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 23:39:16 -0700 (PDT)
From: Igor Ushakov <sysroot314@gmail.com>
To: sashal@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	kuniyu@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	sysroot314@gmail.com
Subject: [PATCH v2 6.6.y/6.12.y/6.18.y] af_unix: Set gc_in_progress to true in unix_gc().
Date: Wed,  1 Jul 2026 09:39:00 +0300
Message-ID: <20260701063900.280980-1-sysroot314@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <stable-reply-item009-af-unix-gc-20260630181642@kernel.org>
References: <stable-reply-item009-af-unix-gc-20260630181642@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303485-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,vger.kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[sysroot314@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:stable@vger.kernel.org,m:sysroot314@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sysroot314@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE2866EA478

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit d82ba05263c69fa2437fe93e4e561cc40f4c03af ]

Igor Ushakov reported that unix_gc() could run with gc_in_progress
being false if the work is scheduled while running:

  Thread 1         Thread 2                     Thread 3
  --------         --------                     --------
                   unix_schedule_gc()           unix_schedule_gc()
                   `- if (!gc_in_progress)      `- if (!gc_in_progress)
                      |- gc_in_progress = true     |
                      `- queue_work()              |
  unix_gc() <----------------/                     |
  |                                                |- gc_in_progress = true
  ...                                              `- queue_work()
  |                                                       |
  `- gc_in_progress = false                               |
                                                          |
  unix_gc() <---------------------------------------------'
  |
  ... /* gc_in_progress == false */
  |
  `- gc_in_progress = false

unix_peek_fpl() relies on gc_in_progress not to confuse GC
by MSG_PEEK.

Let's set gc_in_progress to true in unix_gc().

Fixes: 8b90a9f819dc ("af_unix: Run GC on only one CPU.")
Reported-by: Igor Ushakov <sysroot314@gmail.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260501073945.1884564-1-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Add setting gc_in_progress in __unix_gc(). Keep the existing
  set in unix_gc() for wait_for_unix_gc() over-limit throttling. ]
Signed-off-by: Igor Ushakov <sysroot314@gmail.com>
---
 net/unix/garbage.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 1cdb54c616..fa6983dc31 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -583,6 +583,8 @@ static void __unix_gc(struct work_struct *work)
 	struct sk_buff_head hitlist;
 	struct sk_buff *skb;
 
+	WRITE_ONCE(gc_in_progress, true);
+
 	spin_lock(&unix_gc_lock);
 
 	if (!unix_graph_maybe_cyclic) {
-- 
2.47.3


