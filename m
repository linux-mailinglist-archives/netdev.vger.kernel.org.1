Return-Path: <netdev+bounces-105217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8584491026F
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863941C21B62
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 11:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403C41AB8F0;
	Thu, 20 Jun 2024 11:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="2BH8tX6W"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066871AB531
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 11:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718882575; cv=none; b=dIpHIcBM+OkmUseYOBGrIfBA6yJ7POftFAKl7Q8qWBGFibmZvxF1ZYjjj9LlCKtjDfbqn8XnjMq84H49xvO3PnBc8pxDuiG9vXCeCEpW2G0z/bzNceGq/xslo8ruKu0NHhwaF7kXT7YWoxP71YNnF/bpA63QXQK8GhCaEXMP3Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718882575; c=relaxed/simple;
	bh=vymUQD5uVYHSm4kmV2hNmAE9IuhZpY8cl8tKtirvvkI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i4XAus3z7Un4feASAanQD7K+wuNeMrJQAa/tZMxTmIwwBcP4PLGdAeOyeEEBhzJxlbBkWYLT//HzG3OSVIOs+ky4BsJ7WxozURWiJ/5CfQkYL4uTX7vXLF/D/D0v6AqpUlSTQgalavFixH31Qu6gvGnQ/OreBnBvWPkG5I2eaAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=2BH8tX6W; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:530f:c40e:e1d0:8f13])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 629987DCC9;
	Thu, 20 Jun 2024 12:22:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1718882566; bh=vymUQD5uVYHSm4kmV2hNmAE9IuhZpY8cl8tKtirvvkI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20gnault@redhat.com,=0D=0A=09samuel.thibault@ens-
	 lyon.org,=0D=0A=09ridge.kennedy@alliedtelesis.co.nz|Subject:=20[PA
	 TCH=20net-next=207/8]=20l2tp:=20drop=20the=20now=20unused=20l2tp_t
	 unnel_get_session|Date:=20Thu,=2020=20Jun=202024=2012:22:43=20+010
	 0|Message-Id:=20<919aa49e7b273d73a358e554e3a96e61e5f3e1dc.17188773
	 98.git.jchapman@katalix.com>|In-Reply-To:=20<cover.1718877398.git.
	 jchapman@katalix.com>|References:=20<cover.1718877398.git.jchapman
	 @katalix.com>|MIME-Version:=201.0;
	b=2BH8tX6WB0kTcfL7ebTPW1t2hXrulx6nwJEg7Jt+aC8TRuoTybkZAhUemMgZfCCnv
	 RFwcUBCSGjkleqcASVsgMtmBe0XYi1oCit2sYoPitT/0SHYmjTzx2UW7ZXycn8ffNw
	 YB5qjlrZASrZQSUnFDWfVwzcJVCSQuz2A3gxCnrsD8kCAY+Ko4D2uekPr0p07KvufQ
	 fb0dHfZcog5RAb02d0zJJWobNkaW7irNazMHt1AjFuQp9QW7BKa1dZz70IgkEh2CLc
	 LyfliHD16YQ59qdFPr5+oRl+g7jGkYHX2ih8Ta2x9Xm2h92MfAhslJ5yzZ05S8zTuw
	 fXvDQw9Nq2pFA==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: gnault@redhat.com,
	samuel.thibault@ens-lyon.org,
	ridge.kennedy@alliedtelesis.co.nz
Subject: [PATCH net-next 7/8] l2tp: drop the now unused l2tp_tunnel_get_session
Date: Thu, 20 Jun 2024 12:22:43 +0100
Message-Id: <919aa49e7b273d73a358e554e3a96e61e5f3e1dc.1718877398.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718877398.git.jchapman@katalix.com>
References: <cover.1718877398.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All users of l2tp_tunnel_get_session are now gone so it can be
removed.

Signed-off-by: James Chapman <jchapman@katalix.com>
Reviewed-by: Tom Parkin <tparkin@katalix.com>
---
 net/l2tp/l2tp_core.c | 22 ----------------------
 net/l2tp/l2tp_core.h |  2 --
 2 files changed, 24 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 0e826a0260fe..3ce689331542 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -241,28 +241,6 @@ struct l2tp_tunnel *l2tp_tunnel_get_nth(const struct net *net, int nth)
 }
 EXPORT_SYMBOL_GPL(l2tp_tunnel_get_nth);
 
-struct l2tp_session *l2tp_tunnel_get_session(struct l2tp_tunnel *tunnel,
-					     u32 session_id)
-{
-	struct hlist_head *session_list;
-	struct l2tp_session *session;
-
-	session_list = l2tp_session_id_hash(tunnel, session_id);
-
-	rcu_read_lock_bh();
-	hlist_for_each_entry_rcu(session, session_list, hlist)
-		if (session->session_id == session_id) {
-			l2tp_session_inc_refcount(session);
-			rcu_read_unlock_bh();
-
-			return session;
-		}
-	rcu_read_unlock_bh();
-
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(l2tp_tunnel_get_session);
-
 struct l2tp_session *l2tp_v3_session_get(const struct net *net, struct sock *sk, u32 session_id)
 {
 	const struct l2tp_net *pn = l2tp_pernet(net);
diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
index 0e7c9b0bcc1e..bfff69f2e0a2 100644
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -227,8 +227,6 @@ void l2tp_session_dec_refcount(struct l2tp_session *session);
  */
 struct l2tp_tunnel *l2tp_tunnel_get(const struct net *net, u32 tunnel_id);
 struct l2tp_tunnel *l2tp_tunnel_get_nth(const struct net *net, int nth);
-struct l2tp_session *l2tp_tunnel_get_session(struct l2tp_tunnel *tunnel,
-					     u32 session_id);
 
 struct l2tp_session *l2tp_v3_session_get(const struct net *net, struct sock *sk, u32 session_id);
 struct l2tp_session *l2tp_v2_session_get(const struct net *net, u16 tunnel_id, u16 session_id);
-- 
2.34.1


