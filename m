Return-Path: <netdev+bounces-126303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4546970938
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 20:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625D5281C8F
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 18:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F344916D332;
	Sun,  8 Sep 2024 18:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVf9M5B0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F93F26281
	for <netdev@vger.kernel.org>; Sun,  8 Sep 2024 18:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725820586; cv=none; b=uUSJy3lxQQEM0dwMAleRQPa0AdGjAoM3F+I+XGyfaLyQvqp/dsldWPw8D5stWOUfY5z0pGyOUvv+yek89Tc5Hb7GZQIbw93UmcvOBKyQePhkWv1CAGTlfkR6UFNNS9F4UGn2ZIl914BCM/3rtFdtHIu2BIvCPlWoEu7MjOx7jOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725820586; c=relaxed/simple;
	bh=eERNCsREQgK0GZ6ycgemDK29lrpf7PMtl0is3WX1RTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3/9KKE8F6zjZE/YfbifLHhnp4Kc7JHKcowLD4nkw8tGGc8EK/Z7UCA6wnxx9Br3dNQDu41w6iQQ3yNIb3CnpVk7ZP/pubnhfOW75e9xdhm61TaFHNPIbio7DTzR4GZPD4eTo2SFoYiGvjzCC/SOID2YIQAhbwiHFBO4vMGijLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVf9M5B0; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2057c6c57b5so19257035ad.1
        for <netdev@vger.kernel.org>; Sun, 08 Sep 2024 11:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725820585; x=1726425385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z2DVWv3yluWRsd6jNRr0BJIPwVpgo1u2tqMtNigqFi4=;
        b=nVf9M5B0lzYmSi+FgpFL1sryaddG8F1mFmTM7SINX0pSQXdoPFu0JL61n6RKDO9M+y
         xoMYTORY8ZcvenS1jjbAWT8nUdBnEy+UJfB74M2NQHctFW46SO+UIInjOVr5CXoFyOG8
         8Tzr7B0wEmSvy1HmRjJ19ajIWHou3+UAgg3iMLhYMYGB2yZoW6g7+3ii5gxAQS9eywc7
         4KQcT35UOnfSSMPaxCVX/bvJeDLS0KItf6R+FBbvtDaFIQR0G/AfkXFXg6tUnewmwf8N
         KsWgN8uZD+3nUrsy6te6E2Va7UNDx4yadWq5eic6vtB/rSbGI+awicMM4la8qX85DZQg
         KsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725820585; x=1726425385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2DVWv3yluWRsd6jNRr0BJIPwVpgo1u2tqMtNigqFi4=;
        b=BrlVCe5c5JeHTDqVg8c4go/wRkKMpj7D6Cp/dpWWMcymnWGwU9Di10pqdHV5VAZbY9
         RMq50P5gB2HiIiok9UFi58ZhEaz40fgWOy7HOPw7Qd088Cqs9AkHvbE0YhtSOGGV/FJE
         N61Re/mpAyS+b7YMFSRS4res22quOlKPCU5QfKSzUuc7uzWgos8AJc8Ec4yzOpe4clkn
         frstEAmUCVWXjWlclCu3LLhiG3q85S1q7ZycTErAjJ/hZwO2luaO9NA/N07bN6jCGU73
         f6sereqYODop5bxUwS2HTYbCoud/R/7HzuCVjvToSkRJoYOhLu3bfGZqlR4oI6+DRcws
         xyOw==
X-Forwarded-Encrypted: i=1; AJvYcCX8qSskSgerOJ/Q8N/BG26BjQlWX38FJ8Xi8xyiZTJHb8FCpruFi+SxF+DMV+bsICw5JfJPD6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWILzjW07W4HIcu13hZ8H4fjoy6QCe7Ocv8b0S/CWBZmtvoM2d
	UrB4s/A3OahWbxxomZs8Ce7LCCzqi6g3JbNaMw/E+4cg7t/0XeGk
X-Google-Smtp-Source: AGHT+IFLPbhYx1ec+fAA6mvnDRKPqO3Y9GWWTfWWEuqgKW0131S3ar4VrdLFm01sL5KvH9x4HRK3rA==
X-Received: by 2002:a17:903:2350:b0:202:3617:d52a with SMTP id d9443c01a7336-206ee9256f1mr131298255ad.6.1725820584616;
        Sun, 08 Sep 2024 11:36:24 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:4334:4d08:284:9405])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e0ed43sm22252805ad.50.2024.09.08.11.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 11:36:24 -0700 (PDT)
Date: Sun, 8 Sep 2024 11:36:23 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH RFC net] net: sockmap: avoid race between
 sock_map_destroy() and sk_psock_put()
Message-ID: <Zt3up5aOcu5icAUr@pop-os.localdomain>
References: <20240905064257.3870271-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905064257.3870271-1-dmantipov@yandex.ru>

On Thu, Sep 05, 2024 at 09:42:57AM +0300, Dmitry Antipov wrote:
> At https://syzkaller.appspot.com/bug?extid=f363afac6b0ace576f45, syzbot
> has triggered the following race condition:

Are you sure it is due to sockmap code?

I see rds_tcp_accept_one() in the stack trace. This is why I highly
suspect that it is due to RDS code instead of sockmap code.

I have the following patch ready for testing, in case you are
interested.

Thanks.

--------------->

commit 4068420e2c82137ab95d387346c0776a36c69e5d
Author: Cong Wang <cong.wang@bytedance.com>
Date:   Sun Sep 1 17:01:49 2024 -0700

    rds: check sock->sk->sk_user_data conflicts
    
    Signed-off-by: Cong Wang <cong.wang@bytedance.com>

diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 351ac1747224..54ee7f6b8f34 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -134,11 +134,12 @@ void rds_tcp_restore_callbacks(struct socket *sock,
  * it is set.  The absence of RDS_CONN_UP bit protects those paths
  * from being called while it isn't set.
  */
-void rds_tcp_reset_callbacks(struct socket *sock,
-			     struct rds_conn_path *cp)
+int rds_tcp_reset_callbacks(struct socket *sock,
+			    struct rds_conn_path *cp)
 {
 	struct rds_tcp_connection *tc = cp->cp_transport_data;
 	struct socket *osock = tc->t_sock;
+	int ret = 0;
 
 	if (!osock)
 		goto newsock;
@@ -181,21 +182,25 @@ void rds_tcp_reset_callbacks(struct socket *sock,
 newsock:
 	rds_send_path_reset(cp);
 	lock_sock(sock->sk);
-	rds_tcp_set_callbacks(sock, cp);
+	ret = rds_tcp_set_callbacks(sock, cp);
 	release_sock(sock->sk);
+	return ret;
 }
 
 /* Add tc to rds_tcp_tc_list and set tc->t_sock. See comments
  * above rds_tcp_reset_callbacks for notes about synchronization
  * with data path
  */
-void rds_tcp_set_callbacks(struct socket *sock, struct rds_conn_path *cp)
+int rds_tcp_set_callbacks(struct socket *sock, struct rds_conn_path *cp)
 {
 	struct rds_tcp_connection *tc = cp->cp_transport_data;
 
-	rdsdebug("setting sock %p callbacks to tc %p\n", sock, tc);
 	write_lock_bh(&sock->sk->sk_callback_lock);
-
+	if (sock->sk->sk_user_data) {
+		write_unlock_bh(&sock->sk->sk_callback_lock);
+		return -EBUSY;
+	}
+	rdsdebug("setting sock %p callbacks to tc %p\n", sock, tc);
 	/* done under the callback_lock to serialize with write_space */
 	spin_lock(&rds_tcp_tc_list_lock);
 	list_add_tail(&tc->t_list_item, &rds_tcp_tc_list);
@@ -222,6 +227,7 @@ void rds_tcp_set_callbacks(struct socket *sock, struct rds_conn_path *cp)
 	sock->sk->sk_state_change = rds_tcp_state_change;
 
 	write_unlock_bh(&sock->sk->sk_callback_lock);
+	return 0;
 }
 
 /* Handle RDS_INFO_TCP_SOCKETS socket option.  It only returns IPv4
diff --git a/net/rds/tcp.h b/net/rds/tcp.h
index 053aa7da87ef..710cc7fa41af 100644
--- a/net/rds/tcp.h
+++ b/net/rds/tcp.h
@@ -50,8 +50,8 @@ struct rds_tcp_statistics {
 
 /* tcp.c */
 bool rds_tcp_tune(struct socket *sock);
-void rds_tcp_set_callbacks(struct socket *sock, struct rds_conn_path *cp);
-void rds_tcp_reset_callbacks(struct socket *sock, struct rds_conn_path *cp);
+int rds_tcp_set_callbacks(struct socket *sock, struct rds_conn_path *cp);
+int rds_tcp_reset_callbacks(struct socket *sock, struct rds_conn_path *cp);
 void rds_tcp_restore_callbacks(struct socket *sock,
 			       struct rds_tcp_connection *tc);
 u32 rds_tcp_write_seq(struct rds_tcp_connection *tc);
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index d89bd8d0c354..695456455aee 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -205,11 +205,15 @@ int rds_tcp_accept_one(struct socket *sock)
 		goto rst_nsk;
 	if (rs_tcp->t_sock) {
 		/* Duelling SYN has been handled in rds_tcp_accept_one() */
-		rds_tcp_reset_callbacks(new_sock, cp);
+		ret = rds_tcp_reset_callbacks(new_sock, cp);
+		if (ret)
+			goto rst_nsk;
 		/* rds_connect_path_complete() marks RDS_CONN_UP */
 		rds_connect_path_complete(cp, RDS_CONN_RESETTING);
 	} else {
-		rds_tcp_set_callbacks(new_sock, cp);
+		ret = rds_tcp_set_callbacks(new_sock, cp);
+		if (ret)
+			goto rst_nsk;
 		rds_connect_path_complete(cp, RDS_CONN_CONNECTING);
 	}
 	new_sock = NULL;

