Return-Path: <netdev+bounces-299788-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oxjZDYwYMWo+bgUAu9opvQ
	(envelope-from <netdev+bounces-299788-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 11:34:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE4B68D95E
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 11:34:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=TNKz2Ni1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299788-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299788-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E17230398B0
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 09:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2950442314A;
	Tue, 16 Jun 2026 09:31:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB164218A3
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 09:31:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781602297; cv=none; b=ZXC7B4eAi9XMamB4RRVWiMM3TPqs0UFybDG7TSgLit6SMf5+UDK/xDekPvuMuYwrvy5zJXHTaQJSD3B76XZeZWpNkKCtrjb+jy1E5h7h4j8vZnD0xw0XSR/9/ZV+0HxTTLvuw8xNDL2YKxSGGLXSSmAlWDsf3Cu1CuuiLVlyvOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781602297; c=relaxed/simple;
	bh=BIygEW99km40DQ4U36jHMgpKSlVhAexmh7XqJfveh7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UlR7HnwfIUvb9FVWwCqXOmQJqFKWdbABhkba7Laj/q2X4rYAalajmyc5KOqrXcCFnfs8CBzaJ7M5zUeuW3cUPdlAjSIZN/9snc5q8jP6/g5PR/nRxRsFPkwKnQ0NGgnWGe9rlSz1L54gr0GzUgvpeRHVWTd9SFEQbbMblj+YZcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNKz2Ni1; arc=none smtp.client-ip=209.85.214.181
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c0aa420401so31712085ad.3
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 02:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781602295; x=1782207095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgtSCkqGvjyXkueHDMEHTv56UIjlIzxynvR+gbghz2U=;
        b=TNKz2Ni1jUU9ZBPds65++RIucziSCMXPF7RhWF/8MkFpI4JMY6fUb4s3CRgqJJbkYf
         TND+HPEgQAvT2r3f/JTbxzdhmUhHmKTAi9CoYyxJ9O6+1jgtKaIM2PEXwh8Crov54WUg
         6B5/pk6FERxR3EEqnUpGWeGMQefcFzslwwQZpZ6427/Djl0l8Z6Fv0OJlQ8Ze/PCuJ4O
         3yOPw60oLrlAEgzl2/RXWkGMd4uj3+j73vceSeIzZaUDauWs8jXAxgzvQWQrcjOCHUsf
         7zCV6Ek9X25MvYOCXJ3WS/lCMOyfjpY0g55cdwt6QeCG3vViiuTlvzEYfh00ameymu3i
         cSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781602295; x=1782207095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OgtSCkqGvjyXkueHDMEHTv56UIjlIzxynvR+gbghz2U=;
        b=Fe6d8hFtKtEiYqhBLsigGrFqDCTeBaRC+mCjusShnX9LX0XYKH2g9krOnauJU7G+Oo
         vp41joiaErQPqdYX2GcsIT4HkmrnDMRjktDKaq42M9fVkAt3J7tdmWKeUrdbJRDU10X/
         ZvfB4KJS+8K38dJE06af6NdqfTlTfuhUN85HWa5VfFfuPxg0RK04ZaXNCR/0/1QY0bWX
         tq6Qvlte01PHCqmbPRSm2KRYRE7viyYQ4h2O+2KIOUcF4y49luo32Uickh5bWy/oSzvu
         YPjbZehZr3z+PbxY1m4aaSy8UtYtBx5o+8Lxfvl5ic3oXFaGgG4iQni1/wJFDxtz4PRw
         cEfA==
X-Gm-Message-State: AOJu0Yxay1R4ycHuo+vgfeJGTeMoX/j/dTlLdHWmadifXKaAtulxzBfL
	vAYvO8neBExzyEGRN6RM9f6/RK2rKiaLcsCZOML5WSS3TKl302K5kpQp
X-Gm-Gg: Acq92OG/S6GQmFEAdU5Gk0CXJUSHTN5iXUO5Z8+Q5n0kkOLtcirnGtcUkDKc1GZ2DvT
	xg7Pt0N4aZdvULZYBw1au7fZHAlAy5YVfVNbcKcj0k+0TXkkGkqsC3g16y+RiN3pd7livunqhWL
	6Qd6z6CCFFSeUUkCvDKmWJOEKzbDrqmxVbaRCprSA3GUUMFyu3/JBXU40ofyqwgWakAeN8jYAAp
	O7wQmLgyGBnQUgu5ausGrL31VdMSpCLs3wINzib2qoQkAcoZ0GjWeIJ0BOMvzxTxYBu8vWeW3w1
	HlG/o9a7KGUr7b092RSEECpmpxmaLxxIG0sN71RuyJzHqtF6Lggp7CtG91F/v2p09HB8ryzRjg3
	AFB+Xh8l3EwNT7r44MWsdYoKiDnkXBl72oPQCJ8i4lJE5z14c/xs+o64eoUVX3hjhyA3lAPawMh
	MGTbXgnIcfJMaad+rvSdVrYU/erMj4ukRETWchPJZmWtYh253QOa5q50/N5Tw7TiI=
X-Received: by 2002:a17:903:1ac5:b0:2c1:20fe:9d5a with SMTP id d9443c01a7336-2c4135e86ccmr181937835ad.35.1781602295359;
        Tue, 16 Jun 2026 02:31:35 -0700 (PDT)
Received: from localhost.localdomain ([2a12:a304:100::209f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f7c6c52sm127329545ad.22.2026.06.16.02.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 02:31:35 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	toke@redhat.com,
	lorenzo@kernel.org,
	paul.chaignon@gmail.com
Subject: [PATCH bpf v2 1/2] bpf: Fix partial copy of non-linear test_run output
Date: Tue, 16 Jun 2026 17:31:02 +0800
Message-ID: <20260616093103.471444-2-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616093103.471444-1-sun.jian.kdev@gmail.com>
References: <20260616093103.471444-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-299788-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:toke@redhat.com,m:lorenzo@kernel.org,m:paul.chaignon@gmail.com,m:johnfastabend@gmail.com,m:paulchaignon@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,gmail.com,davemloft.net,google.com,redhat.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FE4B68D95E

For non-linear test_run output, bpf_test_finish() derives the linear
data copy length from copy_size - frag_size. This only matches the
linear data length when copy_size is the full packet size.

When userspace provides a short data_out buffer, copy_size is clamped to
that buffer size. If copy_size is smaller than frag_size, the computed
length becomes negative and bpf_test_finish() returns -ENOSPC before
copying the packet prefix or updating data_size_out.

Compute the linear data length from the packet layout instead, and clamp
the linear copy length to copy_size. This preserves the expected
partial-copy semantics: return -ENOSPC, copy the packet prefix that fits
in data_out, and report the full packet length through data_size_out.

Fixes: 7855e0db150ad ("bpf: test_run: add xdp_shared_info pointer in bpf_test_finish signature")
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 net/bpf/test_run.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 2bc04feadfab..976e8fa31bc9 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -453,19 +453,16 @@ static int bpf_test_finish(const union bpf_attr *kattr,
 	}
 
 	if (data_out) {
-		int len = sinfo ? copy_size - frag_size : copy_size;
-
-		if (len < 0) {
-			err = -ENOSPC;
-			goto out;
-		}
+		u32 head_len = size - frag_size;
+		u32 len = min(copy_size, head_len);
 
 		if (copy_to_user(data_out, data, len))
 			goto out;
 
 		if (sinfo) {
-			int i, offset = len;
+			u32 offset = len;
 			u32 data_len;
+			int i;
 
 			for (i = 0; i < sinfo->nr_frags; i++) {
 				skb_frag_t *frag = &sinfo->frags[i];
-- 
2.43.0


