Return-Path: <netdev+bounces-90035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DD58AC8F3
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 11:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9B3C1C20C1F
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 09:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537BB56751;
	Mon, 22 Apr 2024 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="OQN/l7Or"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ABF54FB8
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713778427; cv=none; b=XjnsE6UYkaLEgrV1KfyvPrDHLyqHwyhOWGx3rD/bFIsSfRZUR9rbodB5XCys6U4L8cklghyemLR8uEpM0Rmc54up777ztnWrA7milVpRxYkqW0kZnghkYsx1RIljZYPPG6B/KeOoXcnhZh4VBMZMwmXej1HphMw4Hw7YrveZUXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713778427; c=relaxed/simple;
	bh=t3/t0wm7fmT1kM6Nxj8vTfTec/8qRBOWb/nJ6SFlnfA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nCwJVAYYhoz/E6EV0AQHJzdjQSkjadzZRbt1QKCzWfpkhoMQ20swxbaEg+mOjKmlCRswvmjBOy1/o4vNMaOF4qQoopuNAijguzNWgvDOnJPeq5+NqTMU1809y25nIwbWXDCQbDXP3FRWlMAETCd67vzBmIJY+sO0suGU/ZT1Zxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=OQN/l7Or; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e9320c2ef6so9383045ad.2
        for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 02:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1713778425; x=1714383225; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HxiiN0v6DMTQKHEPpP/Njrk1hTWMElIDIn7RKeIVVdQ=;
        b=OQN/l7OrBcIxbCnkOirT+jIl7p/lJS3c3wXGEXdShHkDN0zFl3SE8jff2b70wdRbOS
         zr1OxIhjkEUiO5T3uCwxHmeHXhFVTMHfTlVAOt+TB1QZ+uZGPwac8+avV12LehIarMI7
         L0an0p8dRFHgS+tgB2pvU+8QC1uAQM9O3ue/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713778425; x=1714383225;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HxiiN0v6DMTQKHEPpP/Njrk1hTWMElIDIn7RKeIVVdQ=;
        b=X7WsQhSvnOiAvTc/QbuLcsFkFwRUDBo2I7TMJsDETDdIHGuoG3fhGjEtjGOI4SZzoT
         zIDT8+yMK+a5WP1gJo2mlLjhhhEgGevPRjGKBuRR04M5iBIUdHO0xynmv75xn4138TVn
         tOYaIVqOxA8uQ8ZWM8coYTr1H6lDqzNrzno/O+gzt5WL+HP8LcRA+JmCz9STKFoI2h2P
         4xnbeNi6TglI5+zXWaA6LLPswABZ83ysSImRI9aBJ0VYXAxKH7cu7vd1lcBWtR30O7Nb
         jl1IdI1HOieLVKwnRitG/6f+DpS45ygnUpITIysT2nn8Y84Bn8JqwFd/vXtQZmgoyIZ5
         NcnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqUmloJbMj0x/ddPlLAj1bvzb68zeh6/g9GDEbo+fsSvUQ1pOk+WqX/Ety+GtfK1By3/SRRLWDrwMhRt/yINRhKedqHIKN
X-Gm-Message-State: AOJu0YyGQ5LFyL+lQCwO8xqFUHGyT40zGJGIE5hlyGI1RKXwPDvNrgkd
	6xZg/qNzzNC24WdWo2T0gS/dZW0mN1TuMj0l4UQAHNNzTUVAWNfrulzkbqkN64M=
X-Google-Smtp-Source: AGHT+IEonrCpIwDXPFIx20Qg53GPEx7CG1yfIbvY7lIuM3HB2eM36a1SwGMmdGGTSgpw7Y5fipGJpQ==
X-Received: by 2002:a17:902:d581:b0:1e9:9ffb:85b1 with SMTP id k1-20020a170902d58100b001e99ffb85b1mr3346310plh.41.1713778425060;
        Mon, 22 Apr 2024 02:33:45 -0700 (PDT)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id l3-20020a170902f68300b001e5d8433b5bsm7667170plg.117.2024.04.22.02.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 02:33:44 -0700 (PDT)
Date: Mon, 22 Apr 2024 05:33:40 -0400
From: Hyunwoo Kim <v4bel@theori.io>
To: edumazet@google.com, 0x7f454c46@gmail.com
Cc: v4bel@theori.io, imv4bel@gmail.com, davem@davemloft.net,
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH] tcp: Fix Use-After-Free in tcp_ao_connect_init
Message-ID: <ZiYu9NJ/ClR8uSkH@v4bel-B760M-AORUS-ELITE-AX>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Since call_rcu, which is called in the hlist_for_each_entry_rcu traversal
of tcp_ao_connect_init, is not part of the RCU read critical section, it
is possible that the RCU grace period will pass during the traversal and
the key will be free.

To prevent this, it should be changed to hlist_for_each_entry_safe.

Fixes: 7c2ffaf21bd6 ("net/tcp: Calculate TCP-AO traffic keys")
Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
---
 net/ipv4/tcp_ao.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 3afeeb68e8a7..781b67a52571 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -1068,6 +1068,7 @@ void tcp_ao_connect_init(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct tcp_ao_info *ao_info;
+	struct hlist_node *next;
 	union tcp_ao_addr *addr;
 	struct tcp_ao_key *key;
 	int family, l3index;
@@ -1090,7 +1091,7 @@ void tcp_ao_connect_init(struct sock *sk)
 	l3index = l3mdev_master_ifindex_by_index(sock_net(sk),
 						 sk->sk_bound_dev_if);
 
-	hlist_for_each_entry_rcu(key, &ao_info->head, node) {
+	hlist_for_each_entry_safe(key, next, &ao_info->head, node) {
 		if (!tcp_ao_key_cmp(key, l3index, addr, key->prefixlen, family, -1, -1))
 			continue;
 
-- 
2.34.1


