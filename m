Return-Path: <netdev+bounces-257345-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAVaGQQahWmx8QMAu9opvQ
	(envelope-from <netdev+bounces-257345-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:30:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C22FF814D
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8B423015DA1
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 22:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB3C33B6DF;
	Thu,  5 Feb 2026 22:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfLW2C+t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA66339871
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 22:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770330577; cv=none; b=grkd8vYGkRdt7BRYT2PzExDQ6Or2T5IFEhqsxnV6GTB/y9oYc2w2em6REf9D92+DBFYS6CjpDp2eov2mWxNvoiqanfo3LLSCKll4jEjWq+vZZghhpsGtaDVLizu4ktKR9uEaaMac37/Rdp7daa4hS6IVZkSV/2CytWTSSNBXXzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770330577; c=relaxed/simple;
	bh=CVxHcuu4T8HZtXjKX+jdBS7ybmzluxXd8M00RABLQKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1El5Vj9f6Z9K1VNvooCtQArtpzIRbiyedv0VMnf+YL2kUL8CcMAFU2HRRBLJOXiaSoQmBIcy90gZNU0iJbL2QNy8cK3+D8XCDHqvAkVpv1tulsBbRcYIfNyDFnonW4M9kSCWoFmhluldaufu7gycRXq1W/jYLR4N0fqwfgT1VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfLW2C+t; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a7a23f5915so10839335ad.2
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 14:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770330576; x=1770935376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ID1Rr5u4A781GTWL8cwP+lTOIhWrnwgmB+FcQHGuf5U=;
        b=SfLW2C+tkuHqxK2wHBRYmt/ArfcuBysmH2H5oNfBSy55O9CaP+SoLdLjgQQFrzpcxE
         SyL3hZt0O1YmNkiU6K0Eq1aVu9CQCHYCBGrp4DgOnwfjk9wLDAgpY5oRTlXqiys9wnr5
         Yt0lUenZALxSRErQwLpLms38sXvGWhS6R+WW71x5C88IUL4ZWjqPxVe4Dq9fJMr36RUq
         IXsVrrqTsgwpAoVNuDFOTTqxwZpKWe9OL6Zo9mHU0vNO99gZZPO4aLKk2UWYYdE8qNot
         NalGZn6j11e+0t+tTfIg/szf+oP3WWElBZNw/kzBMRwfZ8WyWJeaS2iwhSHGKozye0hK
         MdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770330576; x=1770935376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ID1Rr5u4A781GTWL8cwP+lTOIhWrnwgmB+FcQHGuf5U=;
        b=bax0lWAj3Ssbh/xI81eExPBhf4JstHxI/Mp+0VrJnb7m2mEQIoRtxuB+LitmSujglY
         UfzxXsFh3k7Xl5A8W7YXgENtong0OP77euhG4cJH2IlL0WrHnHMcOF+8vwx4HeuvIwue
         +DuaDjav1/e6oyFWJN4FRRj9w2h+UNukFJh4FMgZfe0RQbAlXma4bZcO8U+++0GvOdtz
         hfuz3Skm+GGD45gadU5Gv4maWv7SDvApTwhRX2vEZxitOQAnuv/9SQZZZZWiyh99Vm3P
         nBXvOdrzsg8riIpX47hf/DkrVJMuUcW0ynXBmZGVvJYNFE0eQF6GbCMm8UGlVDDCyt+e
         KuPw==
X-Gm-Message-State: AOJu0YwhV3yF1bC8hI/DUKW4VRffRvoEPt7Xr9QzJMDtu66YvS0QGXQl
	V45dEl0q4us5RbsCgFy+ip4s7gq5Zmqfr5kTbEc7YvPkyCxInTUyZYyv
X-Gm-Gg: AZuq6aK8jIfsR4VQOsDrB5mR3n2g/wZpZkfmo2H2J2RaGxAzVFG7VVsGIIu3JQR2uKO
	iSV5pi3u8xLIMC2z0jSK/V1/+NSGBdUDbIx+Lt6Su9bLiR1nYPdnZyc0JL6oDwlbwcW33EWZ6M4
	UgtPcaguecUocsHmEh8z/0SbWiTxgLZOT49R4N3jTGbfuiV3npsRDN4Yb1Yu5AMODP0v41BBRDN
	6PTkuyMgwFB3rYyJT8hjIIUqXPeVGOYLnKWcv4irwne7YfByqYEiiKgd+fFZQCZxLCDtXikBNSM
	HnF1ashxGp+S838Ue/7HaeYc7DXdO6Hq92j2TMQ2R0EAa/f9VibVIaljpiiQZSMMjwK96s4g2Gc
	2vDdIt0drQERPZuV2u0A73nkuL808eqRqCWp+t6tbQiNUK9Neh4YY9rd/99izofx04Gso2NDqqw
	6g+w==
X-Received: by 2002:a17:903:22d1:b0:2a7:63e4:b1aa with SMTP id d9443c01a7336-2a9521f3ed1mr7143355ad.35.1770330576200;
        Thu, 05 Feb 2026 14:29:36 -0800 (PST)
Received: from localhost ([2a03:2880:ff:23::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9521f8a50sm3811145ad.80.2026.02.05.14.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 14:29:35 -0800 (PST)
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
Subject: [PATCH bpf-next v7 17/17] selftests/bpf: Fix outdated test on storage->smap
Date: Thu,  5 Feb 2026 14:29:15 -0800
Message-ID: <20260205222916.1788211-18-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205222916.1788211-1-ameryhung@gmail.com>
References: <20260205222916.1788211-1-ameryhung@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257345-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
X-Rspamd-Queue-Id: 1C22FF814D
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


