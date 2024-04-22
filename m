Return-Path: <netdev+bounces-90038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D68168AC907
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 11:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 132911C20CAA
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 09:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9604C622;
	Mon, 22 Apr 2024 09:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="DJyNjGSp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3354F29CE7
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 09:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713778643; cv=none; b=Xm0e59VdE7sM5OoOES0gWm29TqajzfbefwgDDvoTjEZ5UV3CxG0bwbnDVlmUrclQsVAJazPrqZGhdLRVUECxfnOtJQh7z28YKwMeVOl7yqbJyUuNjASoS8QCJi2MpGgDwwKAi8/fkSCmGJOupwbn1htXUatfjwGS6Cl10Ul/VBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713778643; c=relaxed/simple;
	bh=DxlTkaz8sp3TVVz5MBKlIQ+P6FsqqhL9GuSnolcDuvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YDjaul85/aiS0NbFMCPfSDEOY6bS0zeB6t7PtTWMshFW4f5/GUr4Dga821E/BY5GFQFSTRXy0FEBacICLkk6zNFvaCcuJSAm56+5UxYGQqcWrivEiR9P24ii7wEmYaBeXqgvhIOmxgLsWLPV3TH+FD3sgl3OJxSw/lktC3EFMU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=DJyNjGSp; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e651a9f3ffso22343625ad.1
        for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 02:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1713778641; x=1714383441; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xVc9ziVVrQQEC8MMAsCaJo6IQinUNjauwxyLE0SAmMQ=;
        b=DJyNjGSpKE6xcEJY1Z9Y/M64FuRGftIvyIDEHYhrrczn6Z9ReN8uMWuNSD9L4KCnZp
         tw7CG4UHKT5rtRmH3+Kznu+N8csZrq6iSU19jQ6zVo+en0cgPAeQcYp1k7gzreRpMFDd
         lMmBpSXFcFAM0ZU3gQ6wkjfGkANiXHxVHVlqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713778641; x=1714383441;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xVc9ziVVrQQEC8MMAsCaJo6IQinUNjauwxyLE0SAmMQ=;
        b=Gk84PvAEb0glQiDK1hOrKsz1Eb5z1BM+M2/LHVQ2MNizi9g1hCFQ1fK+qdAEirkUoL
         szYI/HqhwN4ut2fnqDSonETJKYTX+RhdsueeJDQWDCrW7T/ms/nvVjggtlhbO7FZTQMU
         DECSqGq4iD46Q8MCDovYFODEz69+jTjHgCxoHhG9SBQ0RaQgik/qhZPuKkaIm320p3Ov
         +0YB7k/i6d4V2gq4EIuBEOrmKv1NUHmemGkUEsdHPE5lomD5HU+40DT33a6QTwpTVFnl
         qNXYBZc5rUQAGYv47BGdewGZUUqsSEKbfCq2SPuwKINJeh45vhQqiV5P6uux9pSQarYG
         ggnA==
X-Forwarded-Encrypted: i=1; AJvYcCWmFTZFHL2EXPIBXVdpOnN1m0Rt5+6T5XLZxGZgOpN9O8rVDrT/wThv36bbJwpmZ7oMsThL9qcBOlZkXHf3AVW45aTVD3sq
X-Gm-Message-State: AOJu0YyN924bB0RIx33mjc6p+oE6wEn3NLl7W8CSKzZFgakptkobnUJ1
	S4aP1aYS2CUki/rFbO61nK50N/alWgn+9NLwdJwGiOZkm+RDqeC6mRXLtgSyLhA=
X-Google-Smtp-Source: AGHT+IGtLByhRLcStDL0jeWoKJ7hUT1SIF+9YxinRlgL42b8DaHopQw9VTT1MqmQuNYmOo0viA47Uw==
X-Received: by 2002:a17:903:50c:b0:1e6:34f9:f737 with SMTP id jn12-20020a170903050c00b001e634f9f737mr7471460plb.69.1713778641510;
        Mon, 22 Apr 2024 02:37:21 -0700 (PDT)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id s2-20020a170902ea0200b001e43cf17fe5sm7716142plg.6.2024.04.22.02.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 02:37:21 -0700 (PDT)
Date: Mon, 22 Apr 2024 05:37:17 -0400
From: Hyunwoo Kim <v4bel@theori.io>
To: pshelar@ovn.org, edumazet@google.com
Cc: v4bel@theori.io, imv4bel@gmail.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	dev@openvswitch.org
Subject: [PATCH] net: openvswitch: Fix Use-After-Free in ovs_ct_exit
Message-ID: <ZiYvzQN/Ry5oeFQW@v4bel-B760M-AORUS-ELITE-AX>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Since kfree_rcu, which is called in the hlist_for_each_entry_rcu traversal
of ovs_ct_limit_exit, is not part of the RCU read critical section, it
is possible that the RCU grace period will pass during the traversal and
the key will be free.

To prevent this, it should be changed to hlist_for_each_entry_safe.

Fixes: 11efd5cb04a1 ("openvswitch: Support conntrack zone limit")
Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
---
 net/openvswitch/conntrack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 74b63cdb5992..2928c142a2dd 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -1593,9 +1593,9 @@ static void ovs_ct_limit_exit(struct net *net, struct ovs_net *ovs_net)
 	for (i = 0; i < CT_LIMIT_HASH_BUCKETS; ++i) {
 		struct hlist_head *head = &info->limits[i];
 		struct ovs_ct_limit *ct_limit;
+		struct hlist_node *next;
 
-		hlist_for_each_entry_rcu(ct_limit, head, hlist_node,
-					 lockdep_ovsl_is_held())
+		hlist_for_each_entry_safe(ct_limit, next, head, hlist_node)
 			kfree_rcu(ct_limit, rcu);
 	}
 	kfree(info->limits);
-- 
2.34.1


