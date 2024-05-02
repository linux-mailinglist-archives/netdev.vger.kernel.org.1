Return-Path: <netdev+bounces-93011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 996FF8B9A22
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 13:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E973EB21D9A
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 11:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7872E65BB7;
	Thu,  2 May 2024 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WtWLQ1Lp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0E16311D
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 11:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714649874; cv=none; b=ITbxtqu0eWyiBtCYLj9pEDajI8GNTgZngAO/IGQ0SXU6dAgwaWBmnd2tnWzBlxw8LVlAIv3qO0uNfBylhvERI1AtEoLchCS25lkzq1LY4Al0efK802WofwRi86A943+zcuy3UQUo3e/eT4rEQTfikHBaaIdnMtLt4bKllkSLoqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714649874; c=relaxed/simple;
	bh=xIHjocbgszmfyDtuurzXnAmYJn6QWsMg9/abCf2zLvg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bs2XygbqN83nEgZ1gSrRIU0/fdeXA3sfP2uVSijurz1auqrnNrBq/I/JJRjsi+0HbQDCNIyeagVx3Px1kB+Tb90qCKm/14CuUDvWeIBNo6/D6UoZZwVw/8C4Pw4+viPvQFAWWWE6ihdbZ7Koz6FiSNwGd65yTNsPFZOEgbBmlaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WtWLQ1Lp; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de5a378a948so11173318276.2
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 04:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714649872; x=1715254672; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r8Dlb+nHCm5N75ex/YXHeeowj6Ag/bumdSsAcL2Icvc=;
        b=WtWLQ1LpImwKPHdc6cPqlHw4stVKffkAbeIaEkr+eovZZ/SU9eNqBuzyc1KRm+Liqy
         UE+u5HNDzZvI38ZXFzNIYwukVKyzMVPwdNvYZnx/wJBXX8mW4CIWLt/QIgs9aWqgPmnm
         WznODlWX3wka9Llong+Cy/fVAtmLkzWxCXaqK6gxwZYeQ2TPxHo0VYDZRz44hh5QShkV
         Vy7Z7ks1XURH4EYXaXmPEoM3bPTteZIf2DFoEQ63dWDw6LyzxQUwnSEEOfcFlxyxmdf4
         Pu5QTZS5r/n9o15J8z01n5uc0NHrbAnXGMV8w2u2WBcgAsyERKCR3s8a3Kug17+0cgEM
         vZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714649872; x=1715254672;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r8Dlb+nHCm5N75ex/YXHeeowj6Ag/bumdSsAcL2Icvc=;
        b=MtLytctCT5YH9GOZ2p1ZVW1tyO7C+GK9sHpe/hZkHiqHkSUWub5A4P8L60UrIkclsd
         UKzoq3s78xV0hcKMLTeMIX0nhLXcICfwctcAkMX+OobU6LLI9rUyCsi1Mn5k9doZV7Da
         Btr8lkF+F/lYql8A4mjCcIzvZAL5JqFWT2L+qJ5jmj4INgikh8A5T1JuQlh6YcANNkpL
         9yc50tfVhKCS4ovKgfU3dxcnimxvvDqqwBNVTyrFtTVf+OAlZKz0hLLC2OAAXzpANgZ7
         Y8kxZWVKMkgfll9w1TIiuDoa9KsocxD1gfZVKGrUE5e4vHIkZwa++WX3eN7x1FJJonib
         fwZg==
X-Gm-Message-State: AOJu0YyWLX7t/EDgrnvg3e5hKRLUD1bkLD3gUegTTsXyuQfJJXD0wRC2
	3ME2AkPRx65PiYkqVkQHHT6zjOSpED/ItiSgLlp2i6+C6TRnLVJ1G2fgw6RUtFRIxiaAai29E20
	pSXFQMNk8iA==
X-Google-Smtp-Source: AGHT+IGossF5WzSymkRtVotSGLHzM5DzszNARnJ87o9rioyWIBAM6Usi2HCq3Bsec+RC5f4HXFrXkubI9HLlIw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:100d:b0:dce:30f5:6bc5 with SMTP
 id w13-20020a056902100d00b00dce30f56bc5mr611001ybt.4.1714649872115; Thu, 02
 May 2024 04:37:52 -0700 (PDT)
Date: Thu,  2 May 2024 11:37:47 +0000
In-Reply-To: <20240502113748.1622637-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240502113748.1622637-1-edumazet@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240502113748.1622637-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] rtnetlink: change rtnl_stats_dump() return value
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

By returning 0 (or an error) instead of skb->len,
we allow NLMSG_DONE to be appended to the current
skb at the end of a dump, saving a couple of recvmsg()
system calls.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 283e42f48af68504af193ed5763d4e0fcd667d99..88980c8bcf334079e2d19cbcfb3f10fc05e3c19b 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -6024,7 +6024,7 @@ static int rtnl_stats_dump(struct sk_buff *skb, struct netlink_callback *cb)
 	cb->args[1] = idx;
 	cb->args[0] = h;
 
-	return skb->len;
+	return err;
 }
 
 void rtnl_offload_xstats_notify(struct net_device *dev)
-- 
2.45.0.rc0.197.gbae5840b3b-goog


