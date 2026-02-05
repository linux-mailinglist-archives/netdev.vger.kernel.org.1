Return-Path: <netdev+bounces-257006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGz4C/JAhGng1wMAu9opvQ
	(envelope-from <netdev+bounces-257006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:04:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D80EF3DF
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 473F83006446
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 07:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC89B35E556;
	Thu,  5 Feb 2026 07:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IB5yJ9D8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F19D35E554
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 07:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274949; cv=none; b=Oq5WL6UpwnHA5m/HWWqzW72554QAZ0tTSH+9no12572/qezaPzay+KZ0FjI582BMfApx1xDFAvwoyTCMB2g4aKTsEO6dIgF1RaGkNT8NPNpk39hjqL2Rt2t09/ts1kqhKBio0yBdDsynvuje9kqlj9bM4aMvySTD0NLEaDtL7no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274949; c=relaxed/simple;
	bh=CVxHcuu4T8HZtXjKX+jdBS7ybmzluxXd8M00RABLQKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6FpLbkmCIp27LM4uMA6+urshgUh3ch2mJHeisJbgwBBccVXrux176a+X9dvmGvnxL0SieYjG0FYciSNANCpdTXvaVwLZLD3CZELn/V0EWv4KOB6pkCjNINqPzb2USRO1jqjKL5GgrdD6T/VHoae3rBlrMfkNjPXHpWZFbbFMb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IB5yJ9D8; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-81f4ba336b4so521844b3a.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 23:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770274949; x=1770879749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ID1Rr5u4A781GTWL8cwP+lTOIhWrnwgmB+FcQHGuf5U=;
        b=IB5yJ9D8cjwJuzWup4Fc7c79KFe3PAfG+p3U3wGBOYfCHqTEQhMjb9W4BX3ZHUbaRk
         y2VEChUnoJgbkeDJqCrkMFbxEm6utAVEnRx7dSaC2J7QDi/qMBUWN3rL60ypC3Q625aU
         KMH2hRUHJcFK8iiyy4mKVbWgGRpVoZ/FPrD/iWHcjT0bS+CPegX4x7RERa3vaY/uSZLN
         Wz6cNH2cqwoU3EcHspEq50NQOwb65Ot1aCrj8/ZTnF3UXZQrMUsonETQ7cYTfi8GMS+a
         RsHdGMYSzG8exoac9jVPTBZlTmXqYD9W5WE00sd8CcLlVDoKlI6H4dqmuD0q4uBzU+RU
         kEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770274949; x=1770879749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ID1Rr5u4A781GTWL8cwP+lTOIhWrnwgmB+FcQHGuf5U=;
        b=CAz+H+TYrWot3aQuJGzjPgu23/MJi7qvSVuGgT1r7fc6nW7GDyGaKN++14WYqHbsp+
         tJmUeIu9zGPbkdjEtKvvB3W2pyUhrAJNnvuncewyQgc/Mg9SEoM2jSRCcQklflt9ArDN
         TC06lp59+AWcd4woYyjq54+XeyOhzAu/xMci8q3EwGsGtjmnB5Xb6Dbb2Pl6zcLUSzYh
         FQVs1UCQEp21D0lIVUP8wKqoMvLbHu0bmL3vTSy+y2J2wabrIScbpkGGAI8+EmqKwbHJ
         csV5ljFKZmlS/cDYbTL9IhWXOkPGTuYQPkAivMBlF/veklUa80QTBPQjDjHrtue5l4vv
         OUiQ==
X-Gm-Message-State: AOJu0YwcpLHPSIqh+bxKacEZgeM/WzEXtkDZr5X/7XuUE2ipWbAh6WA5
	1jwX01MfG2EVVfPkQQ6aNQ3DJORcfUD3zb/PYeLIU8DUbOC3ojL9EC8T
X-Gm-Gg: AZuq6aJtnqqhOHY1wcEKiO/X1Ca7JNVfg87ggaOSd9Vd0uC2OyMSdVkil13tDOe0R1P
	1SjjYmjenbfxWyglkoKXcQVgLs5hzMZxaW5uP7991468xOSL+LPW1d51g39mH9bOFyFmGPcVskC
	sMGazjJjlfApi/Q9sA4J6OK6p6OFOLp55CQQdJI3gUjXVNLHWXm2RrTYohtYbSLSvI6r4ag5V3l
	sZEPWNnrAhdBY0wXuzBT+Dsfw5FvZ5oDQbWdd2g7Mllcv2c/bb74lkxGsZDVIBzirW3Mi3cc7mY
	IglMd9Le2pAokosmGYKqR7luvaet28/TPL5qiaW81KQ1LW+SLS1VHfsilFMddg84G5gGf0r7+CO
	Ksjkt6mpAw4Ge9IkgJB1qAk7uCmc1mBxCMIKS/EFOkbwK89jyXKAtkqp1NIvAVh1Hb5XXJQxzao
	sp
X-Received: by 2002:a05:6a00:4104:b0:823:998:95b0 with SMTP id d2e1a72fcca58-8241c5f5db9mr4906578b3a.35.1770274949074;
        Wed, 04 Feb 2026 23:02:29 -0800 (PST)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d1c08e8sm4834802b3a.22.2026.02.04.23.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:02:28 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 17/17] selftests/bpf: Fix outdated test on storage->smap
Date: Wed,  4 Feb 2026 23:02:06 -0800
Message-ID: <20260205070208.186382-18-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205070208.186382-1-ameryhung@gmail.com>
References: <20260205070208.186382-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257006-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A8D80EF3DF
X-Rspamd-Action: no action

bpf_local_storage_free() already does not rely on local_storage->smap
since switching to kmalloc_nolock(). As local_storage->smap is removed,
fix the outdated test by dropping the local_storage->smap check. Keep
the second map in task local storage map test to test that multiple
elements can be added to the storage similar to sk storage test.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/progs/local_storage.c       | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/local_storage.c b/tools/testing/selftests/bpf/progs/local_storage.c
index 637e75df2e14..d0be77011a84 100644
--- a/tools/testing/selftests/bpf/progs/local_storage.c
+++ b/tools/testing/selftests/bpf/progs/local_storage.c
@@ -62,7 +62,6 @@ SEC("lsm/inode_unlink")
 int BPF_PROG(unlink_hook, struct inode *dir, struct dentry *victim)
 {
 	__u32 pid = bpf_get_current_pid_tgid() >> 32;
-	struct bpf_local_storage *local_storage;
 	struct local_storage *storage;
 	struct task_struct *task;
 	bool is_self_unlink;
@@ -88,15 +87,10 @@ int BPF_PROG(unlink_hook, struct inode *dir, struct dentry *victim)
 	if (!storage || storage->value)
 		return 0;
 
-	if (bpf_task_storage_delete(&task_storage_map, task))
+	if (bpf_task_storage_delete(&task_storage_map2, task))
 		return 0;
 
-	/* Ensure that the task_storage_map is disconnected from the storage.
-	 * The storage memory should not be freed back to the
-	 * bpf_mem_alloc.
-	 */
-	local_storage = task->bpf_storage;
-	if (!local_storage || local_storage->smap)
+	if (bpf_task_storage_delete(&task_storage_map, task))
 		return 0;
 
 	task_storage_result = 0;
@@ -164,18 +158,9 @@ int BPF_PROG(socket_bind, struct socket *sock, struct sockaddr *address,
 	if (bpf_sk_storage_delete(&sk_storage_map2, sk))
 		return 0;
 
-	storage = bpf_sk_storage_get(&sk_storage_map2, sk, 0,
-				     BPF_LOCAL_STORAGE_GET_F_CREATE);
-	if (!storage)
-		return 0;
-
 	if (bpf_sk_storage_delete(&sk_storage_map, sk))
 		return 0;
 
-	/* Ensure that the sk_storage_map is disconnected from the storage. */
-	if (!sk->sk_bpf_storage || sk->sk_bpf_storage->smap)
-		return 0;
-
 	sk_storage_result = 0;
 	return 0;
 }
-- 
2.47.3


