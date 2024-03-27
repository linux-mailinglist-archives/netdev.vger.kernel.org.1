Return-Path: <netdev+bounces-82662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D50288EFE4
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 21:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F32B1C35264
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 20:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5193615217D;
	Wed, 27 Mar 2024 20:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="RphAf+5/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C95B14F9CB
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 20:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569934; cv=none; b=fEc4AcvJUq00mjrGNcCKASWDZS4PXQIZKKtfIQwk1r9bRZpq+pQG+7su8JaCqALWOm+uGi/iz5g2Oo9rSY+aKxd22vRbyv9GRtf+ppFuO1AglcOzcVhf6a+j7Ypg6HCa0fYCpi8BlRaD8qW7v7Z6TDKlIRkhqiWCUCWDCtptOAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569934; c=relaxed/simple;
	bh=vEqW1DgEW62eOOy14MyVRf55lhpBDCMsX9Ci6MBuZh0=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=eiKoxCaVEhnTbHawzn5+kPuggmMUpyJ+hxVvkJ1TQSAX2MHWUJvDQU17wpr3N1UPXRbuLsqHEDTmdMHCaPFVPHuOrlkJm3M9ij28t9ho0DwXDWZlz+55IVJkn6VlWJISOKu1HsXHEBKh/XRF5kB+4r8BuJO62/l2Iuti829g2yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=RphAf+5/; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513e89d0816so172259e87.0
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 13:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1711569931; x=1712174731; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=b2UM2vsGB2GKXA0Y54jKwuEcNzrtJZ7/0VEz1DmAe7I=;
        b=RphAf+5/lB1G6vMvCsx1B8vPCs9oU5BEy5y4VLcvYP62BaDJyKweVKsAjuhpbrFo6g
         Bf/co8jrPLd9w8Re4+F6jDrQ34UuXX8RUrU/NIXFakh4k8e0YWXm2jBlPT6vCLW+Ituf
         QZ26VYrypgtS/5d0nuNsJrZ/6xl0r+EczBaXztKamED6ZS4iD9Hq0mx9EZoe/KiP0CWm
         p7hlNih+RY7b4DBLIhr+J3Xw+XmJOzy6adiqJYZ6oxe9daxRRYg81S4nCzXolkmJHTEG
         WDs3/SlpIPFTyeOiHXmWrTivVHHOJtvEfB30/6/TkBDi8JzBKqW5Gs+QyoBSAKpAA78P
         tJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711569931; x=1712174731;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2UM2vsGB2GKXA0Y54jKwuEcNzrtJZ7/0VEz1DmAe7I=;
        b=qXfr09kPlVPQh9E1DRSbAotMKqClCofFtpKn5JJJ5oRc7LZfoGhCM5PFz++z7HP/45
         Ej0o3TCSYBoLPnHFrR1JlDglvEqZ9KKze7xTHWd7Ijkp4MmoBERwG3qZAgAgCQBHEmtK
         /v8/u4tGFqe1QRIldJwKNVeq6Q8iIOSLf6JXjRjS0xEro6R4II1QGr3qn0/IEzwZCsZ0
         Y57VLRaq/RVfLKSVhOJz+pmEsuNqQj9lCf9lzbBd168qk+7r44cs4U0sghVB6+d4CGaj
         pYdKtTeSsaXuX8lv8GCkJDbhob3GnA4eCZC+xnkaoK8vIRFu96T4NoQH1JzCkMAl/aTv
         WUzw==
X-Forwarded-Encrypted: i=1; AJvYcCXVMmYdLpL14HrR58S88D/rVGJ1BKOLpW1fdAFhQ+xmYSEauSrwwx9YlDIfErMx+8UJt8cA6nd/KDYjMH8AlT3Xlob/NJUr
X-Gm-Message-State: AOJu0Yz+SGixg/evFEbP8j3E+b++5k0VxuDfLJU8rT/rb0MYIAh6Lk7Y
	Za46tO5j3AgFewXQO/VznpkgzYUxKs3MLOzEcHb/hTXKxEdBHQURdwe/5xHRBBQ=
X-Google-Smtp-Source: AGHT+IHrkNFl1ffopNxKTETahIleS+aShL7P58PRcF7paaJk0m/WuLamCzDi5i0y3x8TPSw6eSx/Fg==
X-Received: by 2002:ac2:4c34:0:b0:515:a670:3a6c with SMTP id u20-20020ac24c34000000b00515a6703a6cmr369582lfq.23.1711569930579;
        Wed, 27 Mar 2024 13:05:30 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:159])
        by smtp.gmail.com with ESMTPSA id x20-20020a170906b09400b00a469e55767dsm5797266ejy.214.2024.03.27.13.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 13:05:29 -0700 (PDT)
References: <00000000000090fe770614a1ab17@google.com>
 <0000000000007a208d0614a9a9e0@google.com>
User-agent: mu4e 1.6.10; emacs 29.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: syzbot <syzbot+d4066896495db380182e@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
 john.fastabend@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in
 ahci_single_level_irq_intr
Date: Wed, 27 Mar 2024 21:04:14 +0100
In-reply-to: <0000000000007a208d0614a9a9e0@google.com>
Message-ID: <87le63bfuf.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 27d733c0f65e..3692f7256dd6 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -907,6 +907,7 @@ static void sock_hash_delete_from_link(struct bpf_map *map, struct sock *sk,
 	struct bpf_shtab_elem *elem_probe, *elem = link_raw;
 	struct bpf_shtab_bucket *bucket;
 
+	WARN_ON_ONCE(irqs_disabled());
 	WARN_ON_ONCE(!rcu_read_lock_held());
 	bucket = sock_hash_select_bucket(htab, elem->hash);
 
@@ -933,6 +934,10 @@ static long sock_hash_delete_elem(struct bpf_map *map, void *key)
 	struct bpf_shtab_elem *elem;
 	int ret = -ENOENT;
 
+	/* Can't run. We don't to play nice with hardirq-safe locks. */
+	if (irqs_disabled())
+		return -EOPNOTSUPP;
+
 	hash = sock_hash_bucket_hash(key, key_size);
 	bucket = sock_hash_select_bucket(htab, hash);
 
@@ -986,6 +991,7 @@ static int sock_hash_update_common(struct bpf_map *map, void *key,
 	struct sk_psock *psock;
 	int ret;
 
+	WARN_ON_ONCE(irqs_disabled());
 	WARN_ON_ONCE(!rcu_read_lock_held());
 	if (unlikely(flags > BPF_EXIST))
 		return -EINVAL;

