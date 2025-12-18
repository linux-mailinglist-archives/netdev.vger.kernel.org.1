Return-Path: <netdev+bounces-245413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFD3CCD107
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 19:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8ACC03067D3E
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 17:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DAD2FF164;
	Thu, 18 Dec 2025 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+ShnqwQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB5C301011
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 17:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080595; cv=none; b=pNFu0UliQqLaFGm7iDYGP3Rr+yMeQfYjklRfVVF/nflvsBPSlVjWuk0nYqQSg82l3V4ae+Go/u/7qE9+Zmp7u8/Ux0OOfFKtVWccGjO5YMpkxP6yHzF4svcKB4b6mJNIWZO8dDDvvRONQ1V0+JMJF0gOVjIhcIXd1sreZhSLPBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080595; c=relaxed/simple;
	bh=h9DfwG/63JxcaH+e0eUKG0/wct/a2rvgZAx62U5rOtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvelZMU95Hcx2FMzewpw6eLH9r332xObu7OwBvhpNBDpzp8nyo9FeLPDJm6/KiujCuzcvUAKVuY7JwBKTi+OFKf9spvVdS2H5ZB404Z03Q5J84Wh3sDrMde3tpiwnOnf/tXdjT7HVpUmjUwaXVZ/QQ8pIK0y2I5kNsd+EnENNHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+ShnqwQ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso1561605b3a.1
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 09:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766080593; x=1766685393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcBjByjYDttls2P/aFa6gPA8XQJ1gVwh6lBupJQx9xI=;
        b=L+ShnqwQvR5tyJ4N5mArCX3WM3MnmSMgunV8wwURZfXiXXiqS+6dvvofXptd9fDfu+
         hm9eH/qK+nI31xPgq+bjHnwahAxCL96icbqWXdUyknkqMn5pPOqYHRpT/dW3otK2jKuc
         CUE00Ab+01A9ejsEUkxpCf28WlCcUObyXr0Q43AdhJCcaIc9AfHa99d2oP7G+PDeijm/
         Bk1PMRtRcws14AjPMiag+X2MDQimgabeyH4750qJU8EhHcti+VB9uxxVaeF3u+MT60wD
         km6V9wB1FQ6+TP03UjWyV4Nr7/UCmZkrLV7/AnUU/6Lmk5si3fyoiek2q5eRXJS+rBzs
         6C9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766080593; x=1766685393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UcBjByjYDttls2P/aFa6gPA8XQJ1gVwh6lBupJQx9xI=;
        b=kqXSw+Hj9c77l1wTS5zu7HbtbwLqYrIrMNHpYPLcgnWwETj8H71wqPG4KuevFEz40g
         qpzeUojCPJh9B0WSxS9FuWThq2ZlS8K3iWhEur/mMRH6bPVB4V/mhqzOt7Vc11BRj6Nm
         /mW0ONam2OzvDGqim6pMkNLLNnVRawadShnH7vVr4Vckolaw8OBCSyp2w2ppdCcbjnw9
         VQBsoI1Z9FYhO1ENhGWMetu4K/u92+JvzEUhzyTi3mJYXQgquTi5TU255yk35uSH+IiO
         62kxBhdjfrzdwnR1oxX4+NJD3x0qEIJyximqKU25gb8UaK9mmYdC2xteDAti9E1sxBLC
         WBpQ==
X-Gm-Message-State: AOJu0YxvHuO2gjf6vq0vt2FG0AxKkUkm3b9Lp1ZofoXWLfhIPCZDNmn+
	nJnD+bTWo0DLNWxYAewgITnaZHx3l3cdh3ahAjpwzRh/w4E4NH4cSrsX
X-Gm-Gg: AY/fxX7dZFxXlpZdWxhpLVvTiZOgHz7E1SvGdlXy7DmB9KPtn+oXOJ2K3yU9/1/FxO/
	+aFD5c9UUnFdO2APQVgvxj5cMyTwsXs7I2u2Y4kic5Zxu307kY+8LLbYLfjFcAPpeDCE5ywRjHk
	Qjp7QvRWuYMbXybVpetQmI55cMJLpf6m4raX8MKQhP6BOGxtVFJi8aaLZ+eg3Np8R3J8RlkLtLM
	ZkyYrMaRKxUJDxJ3iwHrEFyTsPRqllyoun74YhMlPjdg6hJl5i5XlPe6xMKuGpjA3fjxpYoTsnq
	3GUFg8DeL6mtUSRUYoDPzN9JMd+znoL7Char/RoIiewitKC6L38VYcM9+d/myke2/X8hjpMYwMw
	kRPvZd/CW2WLF69pDOoNAIjIl0j2kwSb7BtqszFDpUYIwGOpU6bttdpJ5QAXBynUfxOmnxG27zD
	ctmXO9zkcq8NzTGw==
X-Google-Smtp-Source: AGHT+IHjhy1IBj3LdU3lFouP2c7L1dTK3jCbWFRP71T199W+a9QO/RRDcvgQHtwzJ2z1FxgK2swegg==
X-Received: by 2002:a05:6a20:7d9f:b0:359:c3:c2ec with SMTP id adf61e73a8af0-376a92c71d6mr303327637.35.1766080592865;
        Thu, 18 Dec 2025 09:56:32 -0800 (PST)
Received: from localhost ([2a03:2880:ff:17::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe1212551asm3235309b3a.22.2025.12.18.09.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 09:56:32 -0800 (PST)
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
Subject: [PATCH bpf-next v3 02/16] bpf: Convert bpf_selem_link_map to failable
Date: Thu, 18 Dec 2025 09:56:12 -0800
Message-ID: <20251218175628.1460321-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218175628.1460321-1-ameryhung@gmail.com>
References: <20251218175628.1460321-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for changing bpf_local_storage_map_bucket::lock to rqspinlock,
convert bpf_selem_link_map() to failable. It still always succeeds and
returns 0 until the change happens. No functional change.

__must_check is added to the function declaration locally to make sure
all the callers are accounted for during the conversion.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h | 4 ++--
 kernel/bpf/bpf_local_storage.c    | 6 ++++--
 net/core/bpf_sk_storage.c         | 4 +++-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 66432248cd81..6cabf5154cf6 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -178,8 +178,8 @@ void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 
 void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now);
 
-void bpf_selem_link_map(struct bpf_local_storage_map *smap,
-			struct bpf_local_storage_elem *selem);
+int bpf_selem_link_map(struct bpf_local_storage_map *smap,
+		       struct bpf_local_storage_elem *selem);
 
 struct bpf_local_storage_elem *
 bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner, void *value,
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 4e3f227fd634..94a20c147bc7 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -373,8 +373,8 @@ static void bpf_selem_unlink_map_nolock(struct bpf_local_storage_elem *selem)
 		hlist_del_init_rcu(&selem->map_node);
 }
 
-void bpf_selem_link_map(struct bpf_local_storage_map *smap,
-			struct bpf_local_storage_elem *selem)
+int bpf_selem_link_map(struct bpf_local_storage_map *smap,
+		       struct bpf_local_storage_elem *selem)
 {
 	struct bpf_local_storage_map_bucket *b = select_bucket(smap, selem);
 	unsigned long flags;
@@ -382,6 +382,8 @@ void bpf_selem_link_map(struct bpf_local_storage_map *smap,
 	raw_spin_lock_irqsave(&b->lock, flags);
 	hlist_add_head_rcu(&selem->map_node, &b->list);
 	raw_spin_unlock_irqrestore(&b->lock, flags);
+
+	return 0;
 }
 
 static void bpf_selem_link_map_nolock(struct bpf_local_storage_map *smap,
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 850dd736ccd1..4f8e917f49d9 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -191,7 +191,9 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 		}
 
 		if (new_sk_storage) {
-			bpf_selem_link_map(smap, copy_selem);
+			ret = bpf_selem_link_map(smap, copy_selem);
+			if (ret)
+				goto out;
 			bpf_selem_link_storage_nolock(new_sk_storage, copy_selem);
 		} else {
 			ret = bpf_local_storage_alloc(newsk, smap, copy_selem, GFP_ATOMIC);
-- 
2.47.3


