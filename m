Return-Path: <netdev+bounces-132069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 336549904C6
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120C41C21192
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348EC2139A1;
	Fri,  4 Oct 2024 13:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4CY/7vRB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A698212EF1
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 13:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728049649; cv=none; b=LTro3DzTNBSuwSlZ5OlFQ6HdHVL4D6aoLOQ+ig54zXlFWQPwSQHUoivS5H4VcJ0fwa2cIhmK2Jc5wDK7C+GuiY5TdzvZhYCFRtOP6pZVqG6KHShgpLs9BxQXQzfgNzMdhsnuQBlhcTnNntiC9N7j6EmCryKPZyPn8B5hwpOVEQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728049649; c=relaxed/simple;
	bh=FdPCmnOZd/iEpeME2+r5ld8cauR1LfAxYemibWg3fok=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mTXuR1tyjcXskERE6VG5E1RwYh1zXhTTiFmM8YC/or9qqtjxceNCVmiID6hFn6schAdnbzJGTGFoeVeHBFVdV84eGEHLr+ug5C7d8Ku2/z3Nnlb6UtRzfMLxVcvS63qz6rXthZr4xnIiNffCxlp/3WJ6MOi8TPy1lprLm7CV+mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4CY/7vRB; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e0082c1dd0so44807137b3.3
        for <netdev@vger.kernel.org>; Fri, 04 Oct 2024 06:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728049646; x=1728654446; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GkcdOzyp0Sswgvcw/W6M2O1tJ+cYqAFTbyGLaQgssj4=;
        b=4CY/7vRBSa1b41et7WXXAT/5ABslFDU/5DGCo4rWnU7onRVnjPqxckeDlWfhBTrmf8
         IB7n4TtFUlcK2G8IqCAe4U/9m+BaTmnRbA4qu2GuxJgzR6hwpqf18igBLWX77mYA3y7H
         Ui17fKTX00GBVBSY+zhjGJUtysB9vRnfTD8nxoWD57HVxBXKNv5bSqFuhiu2sNMr6BIb
         JK9DGj6z46Ss6CiRn8bJeHeJQt5YXQml5S+o96VnX9kw6XTKtVFvnUSSHOZvUVlDrESD
         4PrWUiFfPM3/xsc35DViNDEM9H/pegZLpRmmczErqMC+NQ8z1nrCcFpnAuOGI+PptqIp
         FyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728049646; x=1728654446;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GkcdOzyp0Sswgvcw/W6M2O1tJ+cYqAFTbyGLaQgssj4=;
        b=TkQ1uWBk/Ucyf/w6vBOcCHEM0VN6lbmWzY5JZWR2Mi13bMZmh6N5PAjvoteICWsCpY
         f6k0Xu12buic8+Z92tYWoVN4j6iCXxgVF5jsyncvQAz4RxAbiK4OmB2/DCa/P3JySquj
         +wQtyUQtaOkVRniR6beeJ14zPIUPtumh+x9AAnDzvpJ+TDT+vw+OnfCp90vl5drvFpVH
         lM+fjx4qEIMeMTbXPkwOsddRF2m6m2/bIqEQh7qYgdoYJDkIYaetHeX6anHwIlvu5v8J
         gPMykZXpIbaMQkE03gu1cPF1yddPo5h+/cdPPP8yutRpcJqxEQ383Rj8xKGkD6NMTqKz
         QUag==
X-Forwarded-Encrypted: i=1; AJvYcCWl6J9ahr+QU+nRXCB00ykucqQb6R9jO9GybJidvtoC3wRskSZYfcpF05dqYog2OBqoJOuIIlc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0GZbYkF7I0nK4FtGUHfO3kMg87yaeNB/CNwB51kJLFAFFyksH
	4kuiR4dD/f5D0ErkqChubkIt4Vg9uHe4kWE5rRkLTpKys19ory4rYEZXIlXRrz3S2DerYI2w/IX
	MItL5z1GTKw==
X-Google-Smtp-Source: AGHT+IEpr8cXEWbGKzVB+mIvO1lJMHJ3m7V1DK1EyTo1tpdhw2B2lZCrpU6V+18LK7adxFBTRJsv26mhnA3fGw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:d804:0:b0:e28:8f00:896a with SMTP id
 3f1490d57ef6-e289393a895mr1633276.8.1728049646391; Fri, 04 Oct 2024 06:47:26
 -0700 (PDT)
Date: Fri,  4 Oct 2024 13:47:19 +0000
In-Reply-To: <20241004134720.579244-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241004134720.579244-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241004134720.579244-4-edumazet@google.com>
Subject: [PATCH net-next 3/4] ipv4: remove fib_info_lock
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Alexandre Ferrieux <alexandre.ferrieux@orange.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

After the prior patch, fib_info_lock became redundant
because all of its users are holding RTNL.

BH protection is not needed.

Remove the READ_ONCE()/WRITE_ONCE() annotations around fib_info_cnt,
since it is protected by RTNL.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/fib_semantics.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index e0ffb4ffd95d0f9ebc796c3129bc2f494fb478dd..ece779bfb8f6bec67eb7751761df9a4f158020a8 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -50,7 +50,6 @@
 
 #include "fib_lookup.h"
 
-static DEFINE_SPINLOCK(fib_info_lock);
 static struct hlist_head *fib_info_hash;
 static struct hlist_head *fib_info_laddrhash;
 static unsigned int fib_info_hash_size;
@@ -260,12 +259,11 @@ EXPORT_SYMBOL_GPL(free_fib_info);
 
 void fib_release_info(struct fib_info *fi)
 {
-	spin_lock_bh(&fib_info_lock);
+	ASSERT_RTNL();
 	if (fi && refcount_dec_and_test(&fi->fib_treeref)) {
 		hlist_del(&fi->fib_hash);
 
-		/* Paired with READ_ONCE() in fib_create_info(). */
-		WRITE_ONCE(fib_info_cnt, fib_info_cnt - 1);
+		fib_info_cnt--;
 
 		if (fi->fib_prefsrc)
 			hlist_del(&fi->fib_lhash);
@@ -282,7 +280,6 @@ void fib_release_info(struct fib_info *fi)
 		WRITE_ONCE(fi->fib_dead, 1);
 		fib_info_put(fi);
 	}
-	spin_unlock_bh(&fib_info_lock);
 }
 
 static inline int nh_comp(struct fib_info *fi, struct fib_info *ofi)
@@ -1266,7 +1263,7 @@ static void fib_info_hash_move(struct hlist_head *new_info_hash,
 	unsigned int old_size = fib_info_hash_size;
 	unsigned int i;
 
-	spin_lock_bh(&fib_info_lock);
+	ASSERT_RTNL();
 	old_info_hash = fib_info_hash;
 	old_laddrhash = fib_info_laddrhash;
 	fib_info_hash_size = new_size;
@@ -1303,8 +1300,6 @@ static void fib_info_hash_move(struct hlist_head *new_info_hash,
 		}
 	}
 
-	spin_unlock_bh(&fib_info_lock);
-
 	kvfree(old_info_hash);
 	kvfree(old_laddrhash);
 }
@@ -1380,6 +1375,7 @@ struct fib_info *fib_create_info(struct fib_config *cfg,
 	int nhs = 1;
 	struct net *net = cfg->fc_nlinfo.nl_net;
 
+	ASSERT_RTNL();
 	if (cfg->fc_type > RTN_MAX)
 		goto err_inval;
 
@@ -1422,8 +1418,7 @@ struct fib_info *fib_create_info(struct fib_config *cfg,
 
 	err = -ENOBUFS;
 
-	/* Paired with WRITE_ONCE() in fib_release_info() */
-	if (READ_ONCE(fib_info_cnt) >= fib_info_hash_size) {
+	if (fib_info_cnt >= fib_info_hash_size) {
 		unsigned int new_size = fib_info_hash_size << 1;
 		struct hlist_head *new_info_hash;
 		struct hlist_head *new_laddrhash;
@@ -1582,7 +1577,7 @@ struct fib_info *fib_create_info(struct fib_config *cfg,
 
 	refcount_set(&fi->fib_treeref, 1);
 	refcount_set(&fi->fib_clntref, 1);
-	spin_lock_bh(&fib_info_lock);
+
 	fib_info_cnt++;
 	hlist_add_head(&fi->fib_hash,
 		       &fib_info_hash[fib_info_hashfn(fi)]);
@@ -1604,7 +1599,6 @@ struct fib_info *fib_create_info(struct fib_config *cfg,
 			hlist_add_head_rcu(&nexthop_nh->nh_hash, head);
 		} endfor_nexthops(fi)
 	}
-	spin_unlock_bh(&fib_info_lock);
 	return fi;
 
 err_inval:
-- 
2.47.0.rc0.187.ge670bccf7e-goog


