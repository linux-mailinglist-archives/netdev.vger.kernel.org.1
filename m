Return-Path: <netdev+bounces-300892-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8nfkGlkgOGrVYQcAu9opvQ
	(envelope-from <netdev+bounces-300892-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 19:33:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B96086AB5C1
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 19:33:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Bb45bJJO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300892-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300892-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5069301326A
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 17:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A162F6931;
	Sun, 21 Jun 2026 17:33:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC85B244665
	for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 17:33:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782063187; cv=none; b=sbXoJThJvlAE84zbqmO0p5dU1tGkDdBxE2UuMeJlLKg3Jp+T6JSMZ6riDeviriy6RnLCl35ZgjLuJKuBUfqp/YDTnXDkSD9IpgEauKWYZZdwgsP+RCVTU24OkfS1hkGaNxzGFRUm0fn1tR/34roDUmSbVFIx2hnAFsGlT/AF1/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782063187; c=relaxed/simple;
	bh=gzrrEiwtcJ9ivwLoJnL+m8n0FS7ubVze2VOLPpakTLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cNtRJowedFa5jgV+tEGxdvuh7s+OFsdpRbm5mlqNjtdzzOK8/CNdRUCm/Du0Uy6FZ4RqDMqisP+iue9qfsAZD2vWh6oZ8ZAixjMY4LUhRxS87hwp8AFqsd1M8jAVyvCVLy0LCZctYiqsEyWPxWQbEO3TIu4yTYJCwT51/A528i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bb45bJJO; arc=none smtp.client-ip=74.125.82.54
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-139a5f4ca15so2066894c88.1
        for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 10:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782063185; x=1782667985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/VThkN0DzvQ1cJGYXECCnKHRSweermGUmHPNf82Maw=;
        b=Bb45bJJOnW2gZI/MoOH2aN6SFbgp+FgFBKX92TLNsDLD2NeNUy9T0FpU5kbAQvQJQa
         d6JZWpJD+IOGQzvaifzCalDgOanoH5IUXpHBVd4EMz69EadslkOwg0oDNW9CG2RQc5WK
         2+2O2w23mC2EtLJ2ui5ryuk+HfgWhIKdLN/+ME1PB2FWgDCZXf+k+W93ESqUMtE9CPh2
         SykioqLqsTdTx+6ezE5CcXiUlSPzjmOZcwRd9hOnI3pAxQbRqmD+VcnbxUKJVVcLBI3q
         hXhBWBybOGdFIw67KHUco4InnoG2xox5HiKx3v9ZeGrNkilFYCLGKanzvmF19RWZksSP
         fkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782063185; x=1782667985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8/VThkN0DzvQ1cJGYXECCnKHRSweermGUmHPNf82Maw=;
        b=U28IYzeeXzSMqnwXss8UJxGvekB8b0HJQPhpPf654w+fo79ZU42kJYEynwKRf3X+sF
         Ea8ZBtX+DBf8OjIVmiWq+yqZMOtz7s5aULm1jzC3V6qf20uJqbR/rVfsFyPa7/PgB5gQ
         /iiMrT/JFo56hSNS2iRt/HdBtV0MBoNSlDbnKD4h/f6nloP9DTMvwljfe7yqGmHP1dLr
         YFaxqSInQQuytixVfTnVOODxWuFNzIrFZKfSPhjfR7IrhTKE9O1Fp2GtJIiplefAt3SL
         NLpAlQ8lZ6yOhrWYnJwSx1lxM6dX0l+mo7XQlMPj2m9eLcnN0tzXl/V1Vod0xz+qf79l
         FF4w==
X-Gm-Message-State: AOJu0YxZR/FSApbkmG+9f5ZkZxIfwfbrJ76dd+9bDQJyf9/cZmXOE3w6
	CvdUGzPbs/CWOuITGPnMrfGwrFYiu7vQLn/ca+OF26g1pt/AEAMkwZgJ
X-Gm-Gg: AfdE7cmSowDvJN/rUaal8bU55ymqDuS4N8Q05olEqutGZ/BMZ3q3WlTZIwfYms2x7ao
	xH/D7+auMEKUPEDBAHZ74/m8/4p1QwWv6HUqIsxdyhzFxfW/vRxKrrpNpE7cN/r1ja+eAewst4J
	8o5r1t0/8/oJZ1wGQIPmKV6EEgIH6/6fOFMT4eQtC8UEzjRHJQn53fEQ9pzm38cUvdUlN51jfGB
	cw1jQAglESQXu/bG5saIyz6IyvuHWGjj7cuvvtMtvF3VfDGy8O8AlPbQnmyOZT9eqbBZeg0RjDs
	NJLVzi3+89JnFReJVvb7YtF6mYTGz6Gc3rlAl1zElwOSGVyak5AIKqjAxpyXf8v75tJdy+Jt9PA
	bWBwUci0nAZTmkY8y5rn5Lm24RPyjl6ylpKGQm5HW2Vn4Er+37yetYsATJ1xUR4C74bJrabHDNV
	CsiJXix9Au5lfWODsJ3lT0FIBOk+Asr6REmg==
X-Received: by 2002:a05:7022:608:b0:137:fad9:3a30 with SMTP id a92af1059eb24-139a365c5a0mr5970356c88.19.1782063184980;
        Sun, 21 Jun 2026 10:33:04 -0700 (PDT)
Received: from localhost.localdomain ([188.253.121.152])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139add6d76dsm5495591c88.12.2026.06.21.10.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 10:33:02 -0700 (PDT)
From: Zhenzhong Wu <jt26wzz@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	haoluo@google.com,
	jolsa@kernel.org,
	menglong8.dong@gmail.com,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	stable@vger.kernel.org,
	mykolal@fb.com,
	tamird@kernel.org
Subject: [PATCH stable 6.6.y v4 4/4] selftests/bpf: Update comments find_equal_scalars->sync_linked_regs
Date: Mon, 22 Jun 2026 01:27:35 +0800
Message-ID: <20260621172735.409355-5-jt26wzz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260621172735.409355-1-jt26wzz@gmail.com>
References: <20260621172735.409355-1-jt26wzz@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,google.com,suse.com,fb.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300892-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:kpsingh@kernel.org,m:haoluo@google.com,m:jolsa@kernel.org,m:menglong8.dong@gmail.com,m:eddyz87@gmail.com,m:shung-hsi.yu@suse.com,m:stable@vger.kernel.org,m:mykolal@fb.com,m:tamird@kernel.org,m:johnfastabend@gmail.com,m:menglong8dong@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jt26wzz@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jt26wzz@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B96086AB5C1

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit cfbf25481d6dec0089c99c9d33a2ea634fe8f008 ]

find_equal_scalars() is renamed to sync_linked_regs(),
this commit updates existing references in the selftests comments.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20240718202357.1746514-5-eddyz87@gmail.com
[ zhenzhong: only two pre-existing comments still needed updating in 6.6.y. ]
Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_spill_fill.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 1f71f596d33f..07a2527a8f47 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -392,7 +392,7 @@ __naked void spill_32bit_of_64bit_fail(void)
 	*(u32*)(r10 - 8) = r1;				\
 	/* 32-bit fill r2 from stack. */		\
 	r2 = *(u32*)(r10 - 8);				\
-	/* Compare r2 with another register to trigger find_equal_scalars.\
+	/* Compare r2 with another register to trigger sync_linked_regs.\
 	 * Having one random bit is important here, otherwise the verifier cuts\
 	 * the corners. If the ID was mistakenly preserved on spill, this would\
 	 * cause the verifier to think that r1 is also equal to zero in one of\
@@ -431,7 +431,7 @@ __naked void spill_16bit_of_32bit_fail(void)
 	*(u16*)(r10 - 8) = r1;				\
 	/* 16-bit fill r2 from stack. */		\
 	r2 = *(u16*)(r10 - 8);				\
-	/* Compare r2 with another register to trigger find_equal_scalars.\
+	/* Compare r2 with another register to trigger sync_linked_regs.\
 	 * Having one random bit is important here, otherwise the verifier cuts\
 	 * the corners. If the ID was mistakenly preserved on spill, this would\
 	 * cause the verifier to think that r1 is also equal to zero in one of\
-- 
2.43.0


