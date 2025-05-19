Return-Path: <netdev+bounces-191532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E725ABBD85
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 14:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBF5417CCA0
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 12:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BB5277020;
	Mon, 19 May 2025 12:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbHZvRqk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6363327586A
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 12:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747656985; cv=none; b=dlNZt5Rpb4122SRqvQmV1RNnZ0p4F6V1V7PIlioalsjAU9+Sz2qsZHt38t6ZpI19iben1EwH3g9XM171xxNDdA6y64qeY/bKu7n1lwadSYixq16cBNwYosoL/47QsA2VZw4HJJt9n7aVu68ahb+4tynE8JAZGZ08Ms9mB1oLa1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747656985; c=relaxed/simple;
	bh=7eUJohFFvqHtfU/AfP0tICu5jfKyeqW4hI32DddBi1s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e6P6P+mEBETHy0JgSKSGSNKvw4XYPWbZPyqHd1cWfpgNQ7ra8SP+t1YrvffxEnntWYAPt5jp0cqejJdEMFRiZz3D46Z3I4o33csRAopKUPiviZ+uxhQiyOZWNhSy5FK+TqdN7AKC6Blr3EmV8R3PRcphUkMCOVZqYQPFyTqH8uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbHZvRqk; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a375888197so302428f8f.0
        for <netdev@vger.kernel.org>; Mon, 19 May 2025 05:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747656981; x=1748261781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yDGdk1zkwqP6IwW8Nf3Pt3SzAgs9ntBQkrlnzgO9sI=;
        b=DbHZvRqkDLMc3vT0S1/B2hlbo0sZ7QMIsHXL391vIxzz/uC6yTDguo72xIyeUTmRwh
         042l+3IldqmQHlSXq3AqCPPeLNSY5pzGgpPRic1aZcdyImbf/LeNXkdiVcd8m+yBauc3
         4YkN3OAJt5lbzn+oOL5pzp6T9l5rYpzgQ8mESI9/EtqSzqlwyspYxifChcg5JYih95gF
         663uQq5M+GhO3YCmY+kpbZlAOxn/KpDvvNhBZmML4W44smvGbi75z129x7Pwwpxuqu3n
         bRiYWcVd/bg1BtEd4lqpbwawn3LG4fGNVd1lylqtEkLeicwq9PCfqBHALUVKtfhyoPwC
         F/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747656981; x=1748261781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yDGdk1zkwqP6IwW8Nf3Pt3SzAgs9ntBQkrlnzgO9sI=;
        b=qWHrRzrmtEvXduP6YMySLgtTOc584O7fKNEuzWZJLi+jqMFWgByfEI29v1oRwOm3Ve
         wd2Uf/ypC0D716yY4L/BnVJJ4RceroyWRqLJEDbfy26VwoIlvw/BolPVKSb8xYP9tvqc
         Y5jeolguqoFWhevhfXQhrGeq2rbQN/z4jdRlYp9l17GiSqTaq5ltobJDZK9SuCXfEajw
         GFOqGBmrIEVKpTcAJ1veMt5j90ymWG254z3K6dgVYM30W076NLzZRjjTMNKN8C3zvdP+
         58gsw4YDPuKK8H/nIWJrJ6LFG5kBwTGDestd6dYkAFwl7+z1hRREuzvfPb9Cifad4kjz
         jTsg==
X-Forwarded-Encrypted: i=1; AJvYcCUH72XeImA87ui7ioAX1me2MyqxKg22aPIqz1+wYUsmbwYUzQ+1l3/P6xjAuyqB/AiP+GvSwzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEkGnrf1jRtM/jorGQMwL6M4xC+u8TzmkLaNhfQhSzZnXOzlKF
	rLQwfgY9eyLJ6Vd7HdzLfxTeuNOoQtzU8o0jZZt/tPPcQCiuG25G7J9i
X-Gm-Gg: ASbGnctHlP/Xygt0ucj6s7jT8l3T5VQHOh5sD3D3R0gnSbkwVOzVRZmlo0OVK1F8c/s
	0juoIFb4f55ThMQBIzpo2r82G+LSPKYNJLq2ilx8Qin9gWFlmsIqek9wWMTJZoalA0KmjpyZ6YX
	gOzxLAPu8HgImAFs8SRjlXG91jQqGsa6WMXmlflz+LV5R//O/ym2zcSnuv9p/LP+QrZCtk7/Fff
	9ocoM5azKLQ0Qcmf3Rvn2SfddUdZRwq/XZTIwc8Npk2ULWhMuuRGrP03Tu/LQkrzcy30spq3ojQ
	O0FR7EIuX3/0SuQdOdfqac+DGDYhd4/9WC1oxa574OhOXjBBREwsEW3ECAINghNHjaseUzeu4YP
	k3IrfU5OdihXUQw==
X-Google-Smtp-Source: AGHT+IGrBiTyR9VLKPh1FzwaLF7uo3RkkRfTTZsULUuGEWbfQqczpcMSW7lGIGfNJsRJ85Gn+1EddA==
X-Received: by 2002:a05:6000:400f:b0:3a2:ffbe:3676 with SMTP id ffacd0b85a97d-3a35c8570fbmr11008224f8f.49.1747656981036;
        Mon, 19 May 2025 05:16:21 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a369140048sm7997721f8f.57.2025.05.19.05.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 05:16:20 -0700 (PDT)
Date: Mon, 19 May 2025 13:16:19 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net-next 1/6] socket: Un-export __sock_create().
Message-ID: <20250519131619.21132b21@pumpkin>
In-Reply-To: <20250517035120.55560-2-kuniyu@amazon.com>
References: <20250517035120.55560-1-kuniyu@amazon.com>
	<20250517035120.55560-2-kuniyu@amazon.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 May 2025 20:50:22 -0700
Kuniyuki Iwashima <kuniyu@amazon.com> wrote:

> Since commit eeb1bd5c40ed ("net: Add a struct net parameter to
> sock_create_kern"), we no longer need to export __sock_create()
> and can replace all non-core users with sock_create_kern().
> 
> Let's convert them and un-export __sock_create().

Don't you need to worry about whether 'net' should be held before doing
this change?
Then you can unexport __sock_create() at the end when there are no callers.

I'm surprised you haven't found any __sock_create(..., 0) calls that are
used 'hold' 'net'.
(I've got some 'out of tree'.)

	David

> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  fs/smb/client/connect.c        |  4 ++--
>  include/linux/net.h            |  2 --
>  net/9p/trans_fd.c              |  9 +++++----
>  net/handshake/handshake-test.c | 32 ++++++++++++++------------------
>  net/socket.c                   |  3 +--
>  net/sunrpc/clnt.c              |  4 ++--
>  net/sunrpc/svcsock.c           |  2 +-
>  net/sunrpc/xprtsock.c          |  6 +++---
>  net/wireless/nl80211.c         |  4 ++--
>  9 files changed, 30 insertions(+), 36 deletions(-)
> 
> diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
> index 6bf04d9a5491..c251a23a6447 100644
> --- a/fs/smb/client/connect.c
> +++ b/fs/smb/client/connect.c
> @@ -3350,8 +3350,8 @@ generic_ip_connect(struct TCP_Server_Info *server)
>  		struct net *net = cifs_net_ns(server);
>  		struct sock *sk;
>  
> -		rc = __sock_create(net, sfamily, SOCK_STREAM,
> -				   IPPROTO_TCP, &server->ssocket, 1);
> +		rc = sock_create_kern(net, sfamily, SOCK_STREAM,
> +				      IPPROTO_TCP, &server->ssocket);
>  		if (rc < 0) {
>  			cifs_server_dbg(VFS, "Error %d creating socket\n", rc);
>  			return rc;
> diff --git a/include/linux/net.h b/include/linux/net.h
> index 0ff950eecc6b..26aaaa841f48 100644
> --- a/include/linux/net.h
> +++ b/include/linux/net.h
> @@ -251,8 +251,6 @@ int sock_wake_async(struct socket_wq *sk_wq, int how, int band);
>  int sock_register(const struct net_proto_family *fam);
>  void sock_unregister(int family);
>  bool sock_is_registered(int family);
> -int __sock_create(struct net *net, int family, int type, int proto,
> -		  struct socket **res, int kern);
>  int sock_create(int family, int type, int proto, struct socket **res);
>  int sock_create_kern(struct net *net, int family, int type, int proto, struct socket **res);
>  int sock_create_lite(int family, int type, int proto, struct socket **res);
> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
> index 339ec4e54778..842977f309b3 100644
> --- a/net/9p/trans_fd.c
> +++ b/net/9p/trans_fd.c
> @@ -1006,8 +1006,9 @@ p9_fd_create_tcp(struct p9_client *client, const char *addr, char *args)
>  
>  	client->trans_opts.tcp.port = opts.port;
>  	client->trans_opts.tcp.privport = opts.privport;
> -	err = __sock_create(current->nsproxy->net_ns, stor.ss_family,
> -			    SOCK_STREAM, IPPROTO_TCP, &csocket, 1);
> +
> +	err = sock_create_kern(current->nsproxy->net_ns, stor.ss_family,
> +			       SOCK_STREAM, IPPROTO_TCP, &csocket);
>  	if (err) {
>  		pr_err("%s (%d): problem creating socket\n",
>  		       __func__, task_pid_nr(current));
> @@ -1057,8 +1058,8 @@ p9_fd_create_unix(struct p9_client *client, const char *addr, char *args)
>  
>  	sun_server.sun_family = PF_UNIX;
>  	strcpy(sun_server.sun_path, addr);
> -	err = __sock_create(current->nsproxy->net_ns, PF_UNIX,
> -			    SOCK_STREAM, 0, &csocket, 1);
> +	err = sock_create_kern(current->nsproxy->net_ns, PF_UNIX,
> +			       SOCK_STREAM, 0, &csocket);
>  	if (err < 0) {
>  		pr_err("%s (%d): problem creating socket\n",
>  		       __func__, task_pid_nr(current));
> diff --git a/net/handshake/handshake-test.c b/net/handshake/handshake-test.c
> index 55442b2f518a..4f300504f3e5 100644
> --- a/net/handshake/handshake-test.c
> +++ b/net/handshake/handshake-test.c
> @@ -143,14 +143,18 @@ static void handshake_req_alloc_case(struct kunit *test)
>  	kfree(result);
>  }
>  
> +static int handshake_sock_create(struct socket **sock)
> +{
> +	return sock_create_kern(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP, sock);
> +}
> +
>  static void handshake_req_submit_test1(struct kunit *test)
>  {
>  	struct socket *sock;
>  	int err, result;
>  
>  	/* Arrange */
> -	err = __sock_create(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP,
> -			    &sock, 1);
> +	err = handshake_sock_create(&sock);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  
>  	/* Act */
> @@ -190,8 +194,7 @@ static void handshake_req_submit_test3(struct kunit *test)
>  	req = handshake_req_alloc(&handshake_req_alloc_proto_good, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_NULL(test, req);
>  
> -	err = __sock_create(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP,
> -			    &sock, 1);
> +	err = handshake_sock_create(&sock);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  	sock->file = NULL;
>  
> @@ -216,8 +219,7 @@ static void handshake_req_submit_test4(struct kunit *test)
>  	req = handshake_req_alloc(&handshake_req_alloc_proto_good, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_NULL(test, req);
>  
> -	err = __sock_create(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP,
> -			    &sock, 1);
> +	err = handshake_sock_create(&sock);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  	filp = sock_alloc_file(sock, O_NONBLOCK, NULL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filp);
> @@ -251,8 +253,7 @@ static void handshake_req_submit_test5(struct kunit *test)
>  	req = handshake_req_alloc(&handshake_req_alloc_proto_good, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_NULL(test, req);
>  
> -	err = __sock_create(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP,
> -			    &sock, 1);
> +	err = handshake_sock_create(&sock);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  	filp = sock_alloc_file(sock, O_NONBLOCK, NULL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filp);
> @@ -289,8 +290,7 @@ static void handshake_req_submit_test6(struct kunit *test)
>  	req2 = handshake_req_alloc(&handshake_req_alloc_proto_good, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_NULL(test, req2);
>  
> -	err = __sock_create(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP,
> -			    &sock, 1);
> +	err = handshake_sock_create(&sock);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  	filp = sock_alloc_file(sock, O_NONBLOCK, NULL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filp);
> @@ -321,8 +321,7 @@ static void handshake_req_cancel_test1(struct kunit *test)
>  	req = handshake_req_alloc(&handshake_req_alloc_proto_good, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_NULL(test, req);
>  
> -	err = __sock_create(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP,
> -			    &sock, 1);
> +	err = handshake_sock_create(&sock);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  
>  	filp = sock_alloc_file(sock, O_NONBLOCK, NULL);
> @@ -357,8 +356,7 @@ static void handshake_req_cancel_test2(struct kunit *test)
>  	req = handshake_req_alloc(&handshake_req_alloc_proto_good, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_NULL(test, req);
>  
> -	err = __sock_create(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP,
> -			    &sock, 1);
> +	err = handshake_sock_create(&sock);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  
>  	filp = sock_alloc_file(sock, O_NONBLOCK, NULL);
> @@ -399,8 +397,7 @@ static void handshake_req_cancel_test3(struct kunit *test)
>  	req = handshake_req_alloc(&handshake_req_alloc_proto_good, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_NULL(test, req);
>  
> -	err = __sock_create(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP,
> -			    &sock, 1);
> +	err = handshake_sock_create(&sock);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  
>  	filp = sock_alloc_file(sock, O_NONBLOCK, NULL);
> @@ -457,8 +454,7 @@ static void handshake_req_destroy_test1(struct kunit *test)
>  	req = handshake_req_alloc(&handshake_req_alloc_proto_destroy, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_NULL(test, req);
>  
> -	err = __sock_create(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP,
> -			    &sock, 1);
> +	err = handshake_sock_create(&sock);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  
>  	filp = sock_alloc_file(sock, O_NONBLOCK, NULL);
> diff --git a/net/socket.c b/net/socket.c
> index 9a0e720f0859..241d9767ae69 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -1467,7 +1467,7 @@ EXPORT_SYMBOL(sock_wake_async);
>   *	This function internally uses GFP_KERNEL.
>   */
>  
> -int __sock_create(struct net *net, int family, int type, int protocol,
> +static int __sock_create(struct net *net, int family, int type, int protocol,
>  			 struct socket **res, int kern)
>  {
>  	int err;
> @@ -1581,7 +1581,6 @@ int __sock_create(struct net *net, int family, int type, int protocol,
>  	rcu_read_unlock();
>  	goto out_sock_release;
>  }
> -EXPORT_SYMBOL(__sock_create);
>  
>  /**
>   *	sock_create - creates a socket
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index 6f75862d9782..f9f340171530 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -1455,8 +1455,8 @@ static int rpc_sockname(struct net *net, struct sockaddr *sap, size_t salen,
>  	struct socket *sock;
>  	int err;
>  
> -	err = __sock_create(net, sap->sa_family,
> -				SOCK_DGRAM, IPPROTO_UDP, &sock, 1);
> +	err = sock_create_kern(net, sap->sa_family,
> +			       SOCK_DGRAM, IPPROTO_UDP, &sock);
>  	if (err < 0) {
>  		dprintk("RPC:       can't create UDP socket (%d)\n", err);
>  		goto out;
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index 72e5a01df3d3..e2c69ab17ac5 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -1516,7 +1516,7 @@ static struct svc_xprt *svc_create_socket(struct svc_serv *serv,
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> -	error = __sock_create(net, family, type, protocol, &sock, 1);
> +	error = sock_create_kern(net, family, type, protocol, &sock);
>  	if (error < 0)
>  		return ERR_PTR(error);
>  
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index 83cc095846d3..5ffe88145193 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -1924,7 +1924,7 @@ static struct socket *xs_create_sock(struct rpc_xprt *xprt,
>  	struct socket *sock;
>  	int err;
>  
> -	err = __sock_create(xprt->xprt_net, family, type, protocol, &sock, 1);
> +	err = sock_create_kern(xprt->xprt_net, family, type, protocol, &sock);
>  	if (err < 0) {
>  		dprintk("RPC:       can't create %d transport socket (%d).\n",
>  				protocol, -err);
> @@ -1999,8 +1999,8 @@ static int xs_local_setup_socket(struct sock_xprt *transport)
>  	struct socket *sock;
>  	int status;
>  
> -	status = __sock_create(xprt->xprt_net, AF_LOCAL,
> -					SOCK_STREAM, 0, &sock, 1);
> +	status = sock_create_kern(xprt->xprt_net, AF_LOCAL,
> +				  SOCK_STREAM, 0, &sock);
>  	if (status < 0) {
>  		dprintk("RPC:       can't create AF_LOCAL "
>  			"transport socket (%d).\n", -status);
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index fd5f79266471..98a7298e427d 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -13750,8 +13750,8 @@ static int nl80211_parse_wowlan_tcp(struct cfg80211_registered_device *rdev,
>  	port = nla_get_u16_default(tb[NL80211_WOWLAN_TCP_SRC_PORT], 0);
>  #ifdef CONFIG_INET
>  	/* allocate a socket and port for it and use it */
> -	err = __sock_create(wiphy_net(&rdev->wiphy), PF_INET, SOCK_STREAM,
> -			    IPPROTO_TCP, &cfg->sock, 1);
> +	err = sock_create_kern(wiphy_net(&rdev->wiphy), PF_INET, SOCK_STREAM,
> +			       IPPROTO_TCP, &cfg->sock);
>  	if (err) {
>  		kfree(cfg);
>  		return err;


