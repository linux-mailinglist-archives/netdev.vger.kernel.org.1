Return-Path: <netdev+bounces-171575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CC1A4DA97
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 11:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F20A63B0A5E
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 10:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B601FDE15;
	Tue,  4 Mar 2025 10:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TGkA/2Rc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC061FCCF5
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 10:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084093; cv=none; b=a6F/cIK4VAO117U8w2ioL6UFmETcj2IdivYD1no6iGliNSe3Qi/5PcwlEF2zyF/7WzSEptDgSB/kld2TM8+zbqRg4+vOh6wf8Ml3Fzn02GP4NsCbKHWmdgwGko2flitVwohN26MRUJ10MIurkXBpXzUmvoWPo5arIeEUAZp8tos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084093; c=relaxed/simple;
	bh=97uODZjD3A4OsiJzEIFrZUGbVGhrTGa2NEDYSngpTrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DrVmKUFYEEdf5Dm2ARC6vy9vyZT2OH0/PQUMT1Kvr3MFd4zVOV8EFI30opTULH1VA90/hg89YORpNusYX46cNKvprardoyLghCTeBJgI589tUmg2W2keUJL9Crix+ohiJNyoEvWboKbEynCopzEN239XkNBU5ZG+m+rdMQuSWus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TGkA/2Rc; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso35297475e9.0
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 02:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741084089; x=1741688889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gQ7CoGFD2iFvRPr/ZFej0po5vNDT++pElWgS74U9fxk=;
        b=TGkA/2RcZuY/xiqsUtEwCplm6Xwlg3cEixIg3UvMu+aRoI/lee0iNSmBgxKS7IZOYa
         T88WAUlqxhZBleWeThncDQtl0+b2VYe6RglJae63rRkkAIAXm8TuG1OxTUWXm31nQlTL
         k8UWanSdVDSzLcnlBF132uwat4zhlJv5LLONTlhpACvkyZZrKaDTuJnoDAQsTwM3W8KG
         OBxc9aazoEfgBY9WFJ9J+YcJf2ONVIgZ+Xk6Msib/KsDLUpO4v+D3fYYFb0R5EN63d67
         mIc/UcBwgdQFrvLd8tqN2UnIk8CEvtnTsl3H84qjym07vEGHmMKwqYqGGuGvEM993EHG
         gJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741084089; x=1741688889;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQ7CoGFD2iFvRPr/ZFej0po5vNDT++pElWgS74U9fxk=;
        b=U3s+S0V60eMtsRRSXnoOTntYUFNs4Q2UI07R4WVUf1GAZA7wP14kZUK035JPnjgDuB
         1vH0HF7NXLN37qRXd8ggyd4agUwsCc8i/fH0z6V4iVqs80qE8IGfh/mncU4Rq0KcyJVV
         ZshWDkqnJeO7YJz7k45NZU63XcgVKbXBIZa0tGm/jd2qmp2rPO1ebL+hmb9vwFlG6U3H
         J1eMtlGkj45oPB2hZDL3ihCNZRHHVOkcFOSzhqowTHa7ytpXcfQl/wd8yy1oAQLEBSJQ
         CjniuFDsr2w7BWtYe9YrLbnWSyoYEk0xTirqNcxAvbi2ydK9D4V3XnL4AwkCstNTti7a
         eMkg==
X-Forwarded-Encrypted: i=1; AJvYcCU0VVnPfDDhi5ToaMbl58xoWpKdF0nIZ6MXBYV3Oq8Bh2iaEfz8p+tSmhEJl6T5inKHIk3YSbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YykI3VRmQ7RvyXRbfAK5wfGt+CL7K9OXRPNTYUrqc8ouSnqZhFY
	cA18zESKtlff15E8TQMZlaRKpys6DASwk1v/Gf6Rch3t2yzSx8Gq5NAbdfztYbk=
X-Gm-Gg: ASbGncvTVRadxFVRHvCDiQE4+J6oo7t55eVNODPsYC9bf607j4SuFXmBEItcRlK+zOj
	yvGuaLHbRUqbomgGR5/hl+42bzOEbNpaiymT8JE4s47N4kaXYN5/YB8JsBTlwEMZTKVcffA0W+E
	M/dzq2q6YU3XVmPVx2Cgp/Ko2cL7RVzb21MiklcIHLlmSfZOYaQ9WGD5SrtxsCHgogKx3HD7v8p
	docbtX8iWzN13ZmC2VNCiaUNRBmwiSLFvZirhjAQOz/JOrj5HML3rydQg9HViutiQz67+0+OGkB
	s2rPCK9xSoL+Wg7OY7QUWBnJplLTwv1FpiW3x017Qx1jzgwZ1Q==
X-Google-Smtp-Source: AGHT+IFJChvuv0JduXGK3MAJXNy1R0ZTDMnT9SqUSVvqelpPlcJ7SMiCGA2ATJvXIXXWQ8WjZgBb/A==
X-Received: by 2002:a05:600c:1c1a:b0:43b:ce3d:1278 with SMTP id 5b1f17b1804b1-43bce3d1343mr7037665e9.31.1741084089273;
        Tue, 04 Mar 2025 02:28:09 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43aba5710f6sm229777655e9.29.2025.03.04.02.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 02:28:08 -0800 (PST)
Date: Tue, 4 Mar 2025 13:28:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, allison.henderson@oracle.com,
	netdev@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 5/6] net/rds: rds_tcp_accept_one ought to not discard
 messages
Message-ID: <bcd9af0a-daf1-455c-a9b0-cbd1c2e65e4f@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227042638.82553-6-allison.henderson@oracle.com>

Hi,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/allison-henderson-oracle-com/net-rds-Avoid-queuing-superfluous-send-and-recv-work/20250227-123038
base:   net/main
patch link:    https://lore.kernel.org/r/20250227042638.82553-6-allison.henderson%40oracle.com
patch subject: [PATCH 5/6] net/rds: rds_tcp_accept_one ought to not discard messages
config: x86_64-randconfig-161-20250304 (https://download.01.org/0day-ci/archive/20250304/202503041749.YwkRic8W-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202503041749.YwkRic8W-lkp@intel.com/

smatch warnings:
net/rds/tcp_listen.c:295 rds_tcp_accept_one() warn: inconsistent returns '&rtn->rds_tcp_accept_lock'.

vim +/new_sock +156 net/rds/tcp_listen.c

112b9a7a012048 Gerd Rausch       2025-02-26  109  int rds_tcp_accept_one(struct rds_tcp_net *rtn)
70041088e3b976 Andy Grover       2009-08-21  110  {
112b9a7a012048 Gerd Rausch       2025-02-26  111  	struct socket *listen_sock = rtn->rds_tcp_listen_sock;
70041088e3b976 Andy Grover       2009-08-21  112  	struct socket *new_sock = NULL;
70041088e3b976 Andy Grover       2009-08-21  113  	struct rds_connection *conn;
70041088e3b976 Andy Grover       2009-08-21  114  	int ret;
70041088e3b976 Andy Grover       2009-08-21  115  	struct inet_sock *inet;
bd7c5f983f3185 Sowmini Varadhan  2016-05-02  116  	struct rds_tcp_connection *rs_tcp = NULL;
bd7c5f983f3185 Sowmini Varadhan  2016-05-02  117  	int conn_state;
ea3b1ea5393087 Sowmini Varadhan  2016-06-30  118  	struct rds_conn_path *cp;
1e2b44e78eead7 Ka-Cheong Poon    2018-07-23  119  	struct in6_addr *my_addr, *peer_addr;
92ef0fd55ac80d Jens Axboe        2024-05-09  120  	struct proto_accept_arg arg = {
92ef0fd55ac80d Jens Axboe        2024-05-09  121  		.flags = O_NONBLOCK,
92ef0fd55ac80d Jens Axboe        2024-05-09  122  		.kern = true,
92ef0fd55ac80d Jens Axboe        2024-05-09  123  	};
e65d4d96334e3f Ka-Cheong Poon    2018-07-30  124  #if !IS_ENABLED(CONFIG_IPV6)
e65d4d96334e3f Ka-Cheong Poon    2018-07-30  125  	struct in6_addr saddr, daddr;
e65d4d96334e3f Ka-Cheong Poon    2018-07-30  126  #endif
e65d4d96334e3f Ka-Cheong Poon    2018-07-30  127  	int dev_if = 0;
70041088e3b976 Andy Grover       2009-08-21  128  
112b9a7a012048 Gerd Rausch       2025-02-26  129  	mutex_lock(&rtn->rds_tcp_accept_lock);
                                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

112b9a7a012048 Gerd Rausch       2025-02-26  130  
112b9a7a012048 Gerd Rausch       2025-02-26  131  	if (!listen_sock)
37e14f4fe2991f Sowmini Varadhan  2016-05-18  132  		return -ENETUNREACH;
                                                                ^^^^^^^^^^^^^^^^^^^^
Do this before taking the lock?

37e14f4fe2991f Sowmini Varadhan  2016-05-18  133  
112b9a7a012048 Gerd Rausch       2025-02-26  134  	new_sock = rtn->rds_tcp_accepted_sock;
112b9a7a012048 Gerd Rausch       2025-02-26  135  	rtn->rds_tcp_accepted_sock = NULL;
112b9a7a012048 Gerd Rausch       2025-02-26  136  
112b9a7a012048 Gerd Rausch       2025-02-26 @137  	if (!new_sock) {
112b9a7a012048 Gerd Rausch       2025-02-26  138  		ret = sock_create_lite(listen_sock->sk->sk_family,
112b9a7a012048 Gerd Rausch       2025-02-26  139  				       listen_sock->sk->sk_type,
112b9a7a012048 Gerd Rausch       2025-02-26  140  				       listen_sock->sk->sk_protocol,
d5a8ac28a7ff2f Sowmini Varadhan  2015-08-05  141  				       &new_sock);
70041088e3b976 Andy Grover       2009-08-21  142  		if (ret)
70041088e3b976 Andy Grover       2009-08-21  143  			goto out;
70041088e3b976 Andy Grover       2009-08-21  144  
112b9a7a012048 Gerd Rausch       2025-02-26  145  		ret = listen_sock->ops->accept(listen_sock, new_sock, &arg);
70041088e3b976 Andy Grover       2009-08-21  146  		if (ret < 0)
70041088e3b976 Andy Grover       2009-08-21  147  			goto out;
70041088e3b976 Andy Grover       2009-08-21  148  
84eef2b2187ed7 Ka-Cheong Poon    2018-03-01  149  		/* sock_create_lite() does not get a hold on the owner module so we
84eef2b2187ed7 Ka-Cheong Poon    2018-03-01  150  		 * need to do it here.  Note that sock_release() uses sock->ops to
84eef2b2187ed7 Ka-Cheong Poon    2018-03-01  151  		 * determine if it needs to decrement the reference count.  So set
84eef2b2187ed7 Ka-Cheong Poon    2018-03-01  152  		 * sock->ops after calling accept() in case that fails.  And there's
84eef2b2187ed7 Ka-Cheong Poon    2018-03-01  153  		 * no need to do try_module_get() as the listener should have a hold
84eef2b2187ed7 Ka-Cheong Poon    2018-03-01  154  		 * already.
84eef2b2187ed7 Ka-Cheong Poon    2018-03-01  155  		 */
112b9a7a012048 Gerd Rausch       2025-02-26 @156  		new_sock->ops = listen_sock->ops;
84eef2b2187ed7 Ka-Cheong Poon    2018-03-01  157  		__module_get(new_sock->ops->owner);
84eef2b2187ed7 Ka-Cheong Poon    2018-03-01  158  
480aeb9639d6a0 Christoph Hellwig 2020-05-28  159  		rds_tcp_keepalive(new_sock);
6997fbd7a3dafa Tetsuo Handa      2022-05-05  160  		if (!rds_tcp_tune(new_sock)) {
6997fbd7a3dafa Tetsuo Handa      2022-05-05  161  			ret = -EINVAL;
6997fbd7a3dafa Tetsuo Handa      2022-05-05  162  			goto out;
6997fbd7a3dafa Tetsuo Handa      2022-05-05  163  		}
70041088e3b976 Andy Grover       2009-08-21  164  
70041088e3b976 Andy Grover       2009-08-21  165  		inet = inet_sk(new_sock->sk);
112b9a7a012048 Gerd Rausch       2025-02-26  166  	}
70041088e3b976 Andy Grover       2009-08-21  167  
e65d4d96334e3f Ka-Cheong Poon    2018-07-30  168  #if IS_ENABLED(CONFIG_IPV6)
1e2b44e78eead7 Ka-Cheong Poon    2018-07-23  169  	my_addr = &new_sock->sk->sk_v6_rcv_saddr;
1e2b44e78eead7 Ka-Cheong Poon    2018-07-23  170  	peer_addr = &new_sock->sk->sk_v6_daddr;
e65d4d96334e3f Ka-Cheong Poon    2018-07-30  171  #else
e65d4d96334e3f Ka-Cheong Poon    2018-07-30  172  	ipv6_addr_set_v4mapped(inet->inet_saddr, &saddr);
e65d4d96334e3f Ka-Cheong Poon    2018-07-30  173  	ipv6_addr_set_v4mapped(inet->inet_daddr, &daddr);
e65d4d96334e3f Ka-Cheong Poon    2018-07-30  174  	my_addr = &saddr;
e65d4d96334e3f Ka-Cheong Poon    2018-07-30  175  	peer_addr = &daddr;
e65d4d96334e3f Ka-Cheong Poon    2018-07-30  176  #endif
e65d4d96334e3f Ka-Cheong Poon    2018-07-30  177  	rdsdebug("accepted family %d tcp %pI6c:%u -> %pI6c:%u\n",
112b9a7a012048 Gerd Rausch       2025-02-26  178  		 listen_sock->sk->sk_family,
1e2b44e78eead7 Ka-Cheong Poon    2018-07-23  179  		 my_addr, ntohs(inet->inet_sport),
1e2b44e78eead7 Ka-Cheong Poon    2018-07-23  180  		 peer_addr, ntohs(inet->inet_dport));
70041088e3b976 Andy Grover       2009-08-21  181  
e65d4d96334e3f Ka-Cheong Poon    2018-07-30  182  #if IS_ENABLED(CONFIG_IPV6)
1e2b44e78eead7 Ka-Cheong Poon    2018-07-23  183  	/* sk_bound_dev_if is not set if the peer address is not link local
1e2b44e78eead7 Ka-Cheong Poon    2018-07-23  184  	 * address.  In this case, it happens that mcast_oif is set.  So
1e2b44e78eead7 Ka-Cheong Poon    2018-07-23  185  	 * just use it.
1e2b44e78eead7 Ka-Cheong Poon    2018-07-23  186  	 */
1e2b44e78eead7 Ka-Cheong Poon    2018-07-23  187  	if ((ipv6_addr_type(my_addr) & IPV6_ADDR_LINKLOCAL) &&
1e2b44e78eead7 Ka-Cheong Poon    2018-07-23  188  	    !(ipv6_addr_type(peer_addr) & IPV6_ADDR_LINKLOCAL)) {
1e2b44e78eead7 Ka-Cheong Poon    2018-07-23  189  		struct ipv6_pinfo *inet6;
1e2b44e78eead7 Ka-Cheong Poon    2018-07-23  190  
1e2b44e78eead7 Ka-Cheong Poon    2018-07-23  191  		inet6 = inet6_sk(new_sock->sk);
d2f011a0bf28c0 Eric Dumazet      2023-12-08  192  		dev_if = READ_ONCE(inet6->mcast_oif);
1e2b44e78eead7 Ka-Cheong Poon    2018-07-23  193  	} else {
1e2b44e78eead7 Ka-Cheong Poon    2018-07-23  194  		dev_if = new_sock->sk->sk_bound_dev_if;
1e2b44e78eead7 Ka-Cheong Poon    2018-07-23  195  	}
e65d4d96334e3f Ka-Cheong Poon    2018-07-30  196  #endif
e65d4d96334e3f Ka-Cheong Poon    2018-07-30  197  
112b9a7a012048 Gerd Rausch       2025-02-26  198  	if (!rds_tcp_laddr_check(sock_net(listen_sock->sk), peer_addr, dev_if)) {
aced3ce57cd37b Rao Shoaib        2021-05-21  199  		/* local address connection is only allowed via loopback */
aced3ce57cd37b Rao Shoaib        2021-05-21  200  		ret = -EOPNOTSUPP;
aced3ce57cd37b Rao Shoaib        2021-05-21  201  		goto out;
aced3ce57cd37b Rao Shoaib        2021-05-21  202  	}
aced3ce57cd37b Rao Shoaib        2021-05-21  203  
112b9a7a012048 Gerd Rausch       2025-02-26  204  	conn = rds_conn_create(sock_net(listen_sock->sk),
e65d4d96334e3f Ka-Cheong Poon    2018-07-30  205  			       my_addr, peer_addr,
3eb450367d0823 Santosh Shilimkar 2018-10-23  206  			       &rds_tcp_transport, 0, GFP_KERNEL, dev_if);
eee2fa6ab32251 Ka-Cheong Poon    2018-07-23  207  
70041088e3b976 Andy Grover       2009-08-21  208  	if (IS_ERR(conn)) {
70041088e3b976 Andy Grover       2009-08-21  209  		ret = PTR_ERR(conn);
70041088e3b976 Andy Grover       2009-08-21  210  		goto out;
70041088e3b976 Andy Grover       2009-08-21  211  	}
f711a6ae062cae Sowmini Varadhan  2015-05-05  212  	/* An incoming SYN request came in, and TCP just accepted it.
f711a6ae062cae Sowmini Varadhan  2015-05-05  213  	 *
f711a6ae062cae Sowmini Varadhan  2015-05-05  214  	 * If the client reboots, this conn will need to be cleaned up.
f711a6ae062cae Sowmini Varadhan  2015-05-05  215  	 * rds_tcp_state_change() will do that cleanup
f711a6ae062cae Sowmini Varadhan  2015-05-05  216  	 */
112b9a7a012048 Gerd Rausch       2025-02-26  217  	if (rds_addr_cmp(&conn->c_faddr, &conn->c_laddr) < 0) {
112b9a7a012048 Gerd Rausch       2025-02-26  218  		/* Try to obtain a free connection slot.
112b9a7a012048 Gerd Rausch       2025-02-26  219  		 * If unsuccessful, we need to preserve "new_sock"
112b9a7a012048 Gerd Rausch       2025-02-26  220  		 * that we just accepted, since its "sk_receive_queue"
112b9a7a012048 Gerd Rausch       2025-02-26  221  		 * may contain messages already that have been acknowledged
112b9a7a012048 Gerd Rausch       2025-02-26  222  		 * to and discarded by the sender.
112b9a7a012048 Gerd Rausch       2025-02-26  223  		 * We must not throw those away!
112b9a7a012048 Gerd Rausch       2025-02-26  224  		 */
5916e2c1554f3e Sowmini Varadhan  2016-07-14  225  		rs_tcp = rds_tcp_accept_one_path(conn);
112b9a7a012048 Gerd Rausch       2025-02-26  226  		if (!rs_tcp) {
112b9a7a012048 Gerd Rausch       2025-02-26  227  			/* It's okay to stash "new_sock", since
112b9a7a012048 Gerd Rausch       2025-02-26  228  			 * "rds_tcp_conn_slots_available" triggers "rds_tcp_accept_one"
112b9a7a012048 Gerd Rausch       2025-02-26  229  			 * again as soon as one of the connection slots
112b9a7a012048 Gerd Rausch       2025-02-26  230  			 * becomes available again
112b9a7a012048 Gerd Rausch       2025-02-26  231  			 */
112b9a7a012048 Gerd Rausch       2025-02-26  232  			rtn->rds_tcp_accepted_sock = new_sock;
112b9a7a012048 Gerd Rausch       2025-02-26  233  			new_sock = NULL;
112b9a7a012048 Gerd Rausch       2025-02-26  234  			ret = -ENOBUFS;
112b9a7a012048 Gerd Rausch       2025-02-26  235  			goto out;
112b9a7a012048 Gerd Rausch       2025-02-26  236  		}
112b9a7a012048 Gerd Rausch       2025-02-26  237  	} else {
112b9a7a012048 Gerd Rausch       2025-02-26  238  		/* This connection request came from a peer with
112b9a7a012048 Gerd Rausch       2025-02-26  239  		 * a larger address.
112b9a7a012048 Gerd Rausch       2025-02-26  240  		 * Function "rds_tcp_state_change" makes sure
112b9a7a012048 Gerd Rausch       2025-02-26  241  		 * that the connection doesn't transition
112b9a7a012048 Gerd Rausch       2025-02-26  242  		 * to state "RDS_CONN_UP", and therefore
112b9a7a012048 Gerd Rausch       2025-02-26  243  		 * we should not have received any messages
112b9a7a012048 Gerd Rausch       2025-02-26  244  		 * on this socket yet.
112b9a7a012048 Gerd Rausch       2025-02-26  245  		 * This is the only case where it's okay to
112b9a7a012048 Gerd Rausch       2025-02-26  246  		 * not dequeue messages from "sk_receive_queue".
112b9a7a012048 Gerd Rausch       2025-02-26  247  		 */
112b9a7a012048 Gerd Rausch       2025-02-26  248  		if (conn->c_npaths <= 1)
112b9a7a012048 Gerd Rausch       2025-02-26  249  			rds_conn_path_connect_if_down(&conn->c_path[0]);
112b9a7a012048 Gerd Rausch       2025-02-26  250  		rs_tcp = NULL;
5916e2c1554f3e Sowmini Varadhan  2016-07-14  251  		goto rst_nsk;
112b9a7a012048 Gerd Rausch       2025-02-26  252  	}
112b9a7a012048 Gerd Rausch       2025-02-26  253  
02105b2ccdd634 Sowmini Varadhan  2016-06-30  254  	mutex_lock(&rs_tcp->t_conn_path_lock);
5916e2c1554f3e Sowmini Varadhan  2016-07-14  255  	cp = rs_tcp->t_cpath;
5916e2c1554f3e Sowmini Varadhan  2016-07-14  256  	conn_state = rds_conn_path_state(cp);
1a0e100fb2c966 Sowmini Varadhan  2016-11-16  257  	WARN_ON(conn_state == RDS_CONN_UP);
112b9a7a012048 Gerd Rausch       2025-02-26  258  	if (conn_state != RDS_CONN_CONNECTING && conn_state != RDS_CONN_ERROR) {
112b9a7a012048 Gerd Rausch       2025-02-26  259  		rds_conn_path_drop(cp, 0);
bd7c5f983f3185 Sowmini Varadhan  2016-05-02  260  		goto rst_nsk;
112b9a7a012048 Gerd Rausch       2025-02-26  261  	}
eb192840266fab Sowmini Varadhan  2016-05-02  262  	if (rs_tcp->t_sock) {
41500c3e2a19ff Sowmini Varadhan  2017-06-15  263  		/* Duelling SYN has been handled in rds_tcp_accept_one() */
ea3b1ea5393087 Sowmini Varadhan  2016-06-30  264  		rds_tcp_reset_callbacks(new_sock, cp);
9c79440e2c5e25 Sowmini Varadhan  2016-06-04  265  		/* rds_connect_path_complete() marks RDS_CONN_UP */
ea3b1ea5393087 Sowmini Varadhan  2016-06-30  266  		rds_connect_path_complete(cp, RDS_CONN_RESETTING);
335b48d980f631 Sowmini Varadhan  2016-06-04  267  	} else {
ea3b1ea5393087 Sowmini Varadhan  2016-06-30  268  		rds_tcp_set_callbacks(new_sock, cp);
ea3b1ea5393087 Sowmini Varadhan  2016-06-30  269  		rds_connect_path_complete(cp, RDS_CONN_CONNECTING);
e70845e6ecd132 Ka-Cheong Poon    2025-02-26  270  		wake_up(&cp->cp_up_waitq);
335b48d980f631 Sowmini Varadhan  2016-06-04  271  	}
70041088e3b976 Andy Grover       2009-08-21  272  	new_sock = NULL;
70041088e3b976 Andy Grover       2009-08-21  273  	ret = 0;
69b92b5b741984 Sowmini Varadhan  2017-06-21  274  	if (conn->c_npaths == 0)
69b92b5b741984 Sowmini Varadhan  2017-06-21  275  		rds_send_ping(cp->cp_conn, cp->cp_index);
bd7c5f983f3185 Sowmini Varadhan  2016-05-02  276  	goto out;
bd7c5f983f3185 Sowmini Varadhan  2016-05-02  277  rst_nsk:
10beea7d7408d0 Sowmini Varadhan  2017-06-15  278  	/* reset the newly returned accept sock and bail.
10beea7d7408d0 Sowmini Varadhan  2017-06-15  279  	 * It is safe to set linger on new_sock because the RDS connection
10beea7d7408d0 Sowmini Varadhan  2017-06-15  280  	 * has not been brought up on new_sock, so no RDS-level data could
10beea7d7408d0 Sowmini Varadhan  2017-06-15  281  	 * be pending on it. By setting linger, we achieve the side-effect
10beea7d7408d0 Sowmini Varadhan  2017-06-15  282  	 * of avoiding TIME_WAIT state on new_sock.
10beea7d7408d0 Sowmini Varadhan  2017-06-15  283  	 */
c433594c07457d Christoph Hellwig 2020-05-28  284  	sock_no_linger(new_sock->sk);
335b48d980f631 Sowmini Varadhan  2016-06-04  285  	kernel_sock_shutdown(new_sock, SHUT_RDWR);
bd7c5f983f3185 Sowmini Varadhan  2016-05-02  286  	ret = 0;
70041088e3b976 Andy Grover       2009-08-21  287  out:
bd7c5f983f3185 Sowmini Varadhan  2016-05-02  288  	if (rs_tcp)
02105b2ccdd634 Sowmini Varadhan  2016-06-30  289  		mutex_unlock(&rs_tcp->t_conn_path_lock);
70041088e3b976 Andy Grover       2009-08-21  290  	if (new_sock)
70041088e3b976 Andy Grover       2009-08-21  291  		sock_release(new_sock);
112b9a7a012048 Gerd Rausch       2025-02-26  292  
112b9a7a012048 Gerd Rausch       2025-02-26  293  	mutex_unlock(&rtn->rds_tcp_accept_lock);
112b9a7a012048 Gerd Rausch       2025-02-26  294  
70041088e3b976 Andy Grover       2009-08-21 @295  	return ret;
70041088e3b976 Andy Grover       2009-08-21  296  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


