Return-Path: <netdev+bounces-203554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91264AF65C3
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3E981C40881
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 23:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C3F2D6414;
	Wed,  2 Jul 2025 23:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fP5+cv3R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3E02BE656
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 23:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497342; cv=none; b=UBBxE/ddaRRxUb3mvS8TuBGlPNyYFZTihm3Kdv3KdUCtvZjDO9uJ6/f/Vvw8Zleglq/n7fU+nCxEKGjjidF/19Bl7rfgwV8WIPtMwR5fraN5LA/LnD/Tr6NxI624e0fp6j8Vniuup+m+inkkqiqDeffEcm0dyScp8+/HHFEt7eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497342; c=relaxed/simple;
	bh=LiD7aXjnkBJAExgg1Wau3HU6LfoGi3RPQxVvgNlaAHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XdSOLSEU9uaDpc8QRVR4D2fp+8MQ6MLQc72j2g4bWZk8OzqVcDuetWJVPHsA7+SBycKPtSefgeOFY5P79ECPn/UE25gkINAjNyFJM78JYSf8vETizFx4LjaQ6FbprEhzIMNykJXJ6U6YEnPq/Fm1yvi5ygdNrRbZIQU9rWX366Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fP5+cv3R; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-312e747d2d8so350671a91.0
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 16:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497340; x=1752102140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8B22ju4vP+AtGT9vjIP7FdBq99ScMCYlMLUPIkccwro=;
        b=fP5+cv3RAXyZmad9oARn0Bc8Vsn09W9h6PTW0oalYH/oCaOF47TfMKjLcrY41Q/kiK
         DH/7/o9BdgPLCk6o05jcz2NvaQBCBobcTAA5cJFQA5uE32b11H5Nt4T8nSndiQT7x7nW
         +JIAwprk/lVtu70nj9Ytvm8SRrJgu+mi5kYt21TbmTqxkYU9rx5LByvRuZAvo2NK4pHC
         Ll2W75QB5yfpiPJ/iw16ZWJbHUfpbcmMt8N9Ah4QQIrzl4XAULlb1KQM2Ocby0c9afBY
         qDPEPBUpObKjhS54sHrQ+aParGBzlhcLKjfjUDtaZxYVxXaD0jCRTMwSLGPp14mnZCNc
         4pcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497340; x=1752102140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8B22ju4vP+AtGT9vjIP7FdBq99ScMCYlMLUPIkccwro=;
        b=Hw2Xldlm5ac+B7FJzUpII5IU0UvPzGidD7RCam0En05VShWMvscMyiOcHgmQNaRCcV
         3nO6my47J7YnYt7U/wuNEXA33D1ipJhz9whh2GP1xmYfmQF5SlBdGCj8Q7niD2crGX4H
         Co3dudZNd0Tx9NFzS1ZLLX0mG/wV3PTzlbd2pb2tWML2/fmS49YONs9banVYFpU5YC+Y
         MfFFT4YJ1Uec2UrkKvOkE7a91vpNHcREnDZmK/RFv86IMJRGGOVhTKdMwqbfkPE/Qahl
         PglqE5DClEaXxlNKD7zM9BJoUTE1yTvHPF4y39dA2qSelk3ia86OvZNtr4nMer+ZDnJ7
         8QSw==
X-Forwarded-Encrypted: i=1; AJvYcCWoplAXj/62NrCVp+GfP9Ksdk3xgQhRR/QVzYJNZVIZftSFbHzovEQXrYwHmiScXJMTxUhPB3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsiIoLKYssYuZpIUn0S5aJNfP4TntcTL4gl9kxgjN/HrNaCnQX
	ylV4mWlbNaYml4B0qMHA6jSAk8hITKp/9zCn59o8vZ0FBeF6Lhp1XnVq3onyUzPto3Sk
X-Gm-Gg: ASbGncvxka/Aplw9zpUIjQRiM/WwZqsTOwziEUR6BXmYOOkMiRVEEkqu/aVKTlDWBpq
	Lq1eqrUDCqYP4RbcFvtFE7o5/KR8pAVQOCKu68ODAyD/yi8k2TuG1O9AIr4h4fJtOXzs5qGql1k
	op4HxU8smdT8JbFCvC0Kkvp5WsBcwrAbP3uKz1rELw4Sq9WO8GQfLotlccYvoNv846XFnGot7fZ
	KY8bDL2SWLddUY+nb87ILsTw1LRMkpiqLoFUT2KVyzSkgrmJkYBVeFQ427y8c76o+/FXJ5u4vbo
	zTF0D5JvkTnO4ejA73O+DFMUtg/CB87YVrdbS1s=
X-Google-Smtp-Source: AGHT+IF4FpoNC5yEDJHZAD+ygrlYxe1rTfFz2y4XNRiXpgdf6HPv9Z4VwlPPEmXEE3QHRXKXaM8Vgg==
X-Received: by 2002:a17:90b:2252:b0:313:d7ec:b7b7 with SMTP id 98e67ed59e1d1-31a9f5b04ccmr15452a91.13.1751497339584;
        Wed, 02 Jul 2025 16:02:19 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::a408])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9cc70a17sm727071a91.26.2025.07.02.16.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:02:19 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v3 net-next 04/15] ipv6: mcast: Remove mca_get().
Date: Wed,  2 Jul 2025 16:01:21 -0700
Message-ID: <20250702230210.3115355-5-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702230210.3115355-1-kuni1840@gmail.com>
References: <20250702230210.3115355-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

Since commit 63ed8de4be81 ("mld: add mc_lock for protecting per-interface
mld data"), the newly allocated struct ifmcaddr6 cannot be removed until
inet6_dev->mc_lock is released, so mca_get() and mc_put() are unnecessary.

Let's remove the extra refcounting.

Note that mca_get() was only used in __ipv6_dev_mc_inc().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/mcast.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 15a37352124d..aa1280df4c1f 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -867,11 +867,6 @@ static void mld_clear_report(struct inet6_dev *idev)
 	spin_unlock_bh(&idev->mc_report_lock);
 }
 
-static void mca_get(struct ifmcaddr6 *mc)
-{
-	refcount_inc(&mc->mca_refcnt);
-}
-
 static void ma_put(struct ifmcaddr6 *mc)
 {
 	if (refcount_dec_and_test(&mc->mca_refcnt)) {
@@ -988,13 +983,11 @@ static int __ipv6_dev_mc_inc(struct net_device *dev,
 	rcu_assign_pointer(mc->next, idev->mc_list);
 	rcu_assign_pointer(idev->mc_list, mc);
 
-	mca_get(mc);
-
 	mld_del_delrec(idev, mc);
 	igmp6_group_added(mc);
 	inet6_ifmcaddr_notify(dev, mc, RTM_NEWMULTICAST);
 	mutex_unlock(&idev->mc_lock);
-	ma_put(mc);
+
 	return 0;
 }
 
-- 
2.49.0


