Return-Path: <netdev+bounces-198334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1036ADBDB6
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750E0175B49
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1760D238141;
	Mon, 16 Jun 2025 23:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIqgGlkV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9251C236A99
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 23:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750116891; cv=none; b=hqRT4HIbusxPaKI+K/8tltJTcN/e3fgzm8TnGmux8Ukls8RkJ3eSq+e7FHyPK0TXGVTwmi1VaG8WlCBZLPg8rUi1n+ldzSHhSFEiYemdt7EEueoocV7Bs5TZt4VdipbVbgDzD5Lohg7hOm15B0jxq06M47FHLCAu6URjgSHDX9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750116891; c=relaxed/simple;
	bh=73RQQ5oP/GqNYiYEi1HgMi8XfEuN5+7/pXDZQzTcoW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EAg1anPqKvqigOs+oHnqUZQOpoqabbu2W919/pDUVnADLrI9sq32YbH+KeJae0drTIuwR0xJaI9WhqRCLDxU1WwrqIAPCYs5DIHxXP9cvAsqBXrd4EaKfMmKZZDUzA4WjA+YJNsF2jSLGEiNQpXNjhhptl2w1kZahQMZGMiY74E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIqgGlkV; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b0db0b6a677so4662498a12.2
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 16:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750116889; x=1750721689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LeJ/bQD1SKK0ZUyr7whBXpuGqKXK0hEDM2lwzaMdhUY=;
        b=AIqgGlkV98WIekQGvWpMIEgJWlbEnOwst4UcewQ7IbbAzQo3LlEZWKpaFYsVeval8I
         40uXQ9wgcbaELhc2TU8Nj6224sxXEMt0tAWL5ltFsoP5jH2Pvo9bU85nXxd25Ky2rP9q
         QOhr6rkYWNjbl7CRAMmmvkmyveiIlVw3uBknU2ESumNmI560JygHFqw/a4orJvEU5WZc
         pxx/rq4fJd8z9npN+cDsWATpXJ0G6JK8aanSHgo0S8KcRD2SaEBbJiCyNLYheB+tm8Vw
         h/C26A342Z8JLPeDLIoXtPFukx3KkTMWpIaHgvfddUBcJWI0ofxFK9C0bro/tb3McrpY
         i/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750116889; x=1750721689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LeJ/bQD1SKK0ZUyr7whBXpuGqKXK0hEDM2lwzaMdhUY=;
        b=AfCBgdsxKU59tBHRkC59WNsKSzucyN2dyUZLHKFsn5DltEb0B8l3EZne84ogVSd7/O
         pjd482bMDMYKDTFJfeMwu1eiDqlfXccnplpZkksR6d0AOsz8s3oJKKu5p9c4sdYdnpVb
         gm6LE+vCPfR4qEAj5uT3tzBGiBGarFWF90AkEy/JfwSgwVBddwSnebzMDwnCBFjxGZqx
         7nhCFy9w8F5kH9efQT3YOgijIZdBoDCnKqpswenRP2iDorBRZMHdMq+dgshKoBK4wf+8
         47D/o4UA9r3XXCYGvGDLQosUty4KNVW7zX6Is5z84l5lUKyJ37jGiR1eCq350ElDvx2/
         L/cg==
X-Forwarded-Encrypted: i=1; AJvYcCX0nAS5aetu3dEAnvM3PmjgSlRCYiOonRTcfHZCxmiGLmms06eA41TsCawzBIr7w9d5JOx1Hp0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl3zSAkjfRyRNjeak61PRThmzFI1g1O/SDjUFV50XW4k/kxjYy
	9G8eMwUZblHnPumjAPmUirRfV//uQvcQgv+HJX/xzboluVtNjNZZOBI=
X-Gm-Gg: ASbGnct5if2GqP5UOG5rBF8AN1ZhCcJo4/IUSvo4gaoW4inAW04zrcg21IsPnxD5UOI
	BadnEDhAdJpXO39lodEKpZ6BlzJR9xt4hj7cD3HqlMEiiKvioKm3ysskZiBVHWpZYtBVbDlqiJ+
	0L8ggkiahjYAEyh50C7QYcSpK1xNUw77utqd+ctjM25bOUdx2DnqwBSfGEkMu4W4Em3lfl3abP6
	kwPt10QDkVLyxgGbXUh2AnpRrvKNag87iqDoZTW0whEE5vQRaKzfXSujbpdehWos5hokOWaEACC
	psz9J83yIF5ezxACEqlRDnMqriwyeXmuo1q6hPDcLIWigiO0Qw==
X-Google-Smtp-Source: AGHT+IEP6I1Hht9LOHQUSNxyXFnJdW8En9+DW38FtWRvvnFm5l9eVD3hsFTVsVMa4PmK6FrBtnmBeg==
X-Received: by 2002:a17:90b:2d48:b0:312:db8:dbdc with SMTP id 98e67ed59e1d1-313f1ce6893mr18006660a91.20.1750116888699;
        Mon, 16 Jun 2025 16:34:48 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de89393sm67220485ad.114.2025.06.16.16.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 16:34:48 -0700 (PDT)
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
Subject: [PATCH v1 net-next 08/15] ipv6: mcast: Don't hold RTNL in ipv6_sock_mc_close().
Date: Mon, 16 Jun 2025 16:28:37 -0700
Message-ID: <20250616233417.1153427-9-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616233417.1153427-1-kuni1840@gmail.com>
References: <20250616233417.1153427-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

In __ipv6_sock_mc_close(), per-socket mld data is protected by lock_sock(),
and only __dev_get_by_index() and __in6_dev_get() require RTNL.

Let's call __ipv6_sock_mc_drop() and drop RTNL in ipv6_sock_mc_close().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/mcast.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 7324e9bc2163..84c7ed23bc2d 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -332,28 +332,10 @@ void __ipv6_sock_mc_close(struct sock *sk)
 {
 	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct ipv6_mc_socklist *mc_lst;
-	struct net *net = sock_net(sk);
-
-	ASSERT_RTNL();
 
 	while ((mc_lst = sock_dereference(np->ipv6_mc_list, sk)) != NULL) {
-		struct net_device *dev;
-
 		np->ipv6_mc_list = mc_lst->next;
-
-		dev = __dev_get_by_index(net, mc_lst->ifindex);
-		if (dev) {
-			struct inet6_dev *idev = __in6_dev_get(dev);
-
-			ip6_mc_leave_src(sk, mc_lst, idev);
-			if (idev)
-				__ipv6_dev_mc_dec(idev, &mc_lst->addr);
-		} else {
-			ip6_mc_leave_src(sk, mc_lst, NULL);
-		}
-
-		atomic_sub(sizeof(*mc_lst), &sk->sk_omem_alloc);
-		kfree_rcu(mc_lst, rcu);
+		__ipv6_sock_mc_drop(sk, mc_lst);
 	}
 }
 
@@ -364,11 +346,9 @@ void ipv6_sock_mc_close(struct sock *sk)
 	if (!rcu_access_pointer(np->ipv6_mc_list))
 		return;
 
-	rtnl_lock();
 	lock_sock(sk);
 	__ipv6_sock_mc_close(sk);
 	release_sock(sk);
-	rtnl_unlock();
 }
 
 int ip6_mc_source(int add, int omode, struct sock *sk,
-- 
2.49.0


