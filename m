Return-Path: <netdev+bounces-156215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD285A0591B
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 12:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656511883F3F
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 11:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990561EE031;
	Wed,  8 Jan 2025 11:05:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail115-69.sinamail.sina.com.cn (mail115-69.sinamail.sina.com.cn [218.30.115.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D6619D090
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 11:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736334324; cv=none; b=t377AP3TCW/wvZ3xVQUK+Ador9ool1B+M9x1XtbUGOMOyG7Ad1ZF7LLKBeBR+gBR+N95xsMuIobdigmPScm8qkFEAp3OVpGJLlBZ96ExAmfCPMJzf8ai3+qvPBjJW4fJ22GtYcE3ENm+p1tdmh1+xOyQGaAmW6a7xvldLwGRBiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736334324; c=relaxed/simple;
	bh=BTmaqis0AAQL+QAPr45aWmFM1OLEeuJUBjhBnvT0/WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBBU2I/KYMbOFcMAKIaF83Br07TBLw1ouThVC2fuS7k1MTILNyjeW30h7+8HSm7WxmkLO3LlxrextHy6tLFD1Es4/j9juHekEmEgm89COA0CwSTL7ANISTcROzFqQcJiwMDHv+A/VIWxwo5BXQJwD8HIvaCaon1KKEi+rsczXbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.70.48])
	by sina.com (10.185.250.22) with ESMTP
	id 677E5BE100001EB6; Wed, 8 Jan 2025 19:05:08 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3941497602914
X-SMAIL-UIID: BCF01AC532A84B4CB8E1134503F03AD9-20250108-190508-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+6ac73b3abf1b598863fa@syzkaller.appspotmail.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	borisp@nvidia.com,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] INFO: task hung in lock_sock_nested (5)
Date: Wed,  8 Jan 2025 19:04:56 +0800
Message-ID: <20250108110457.1514-1-hdanton@sina.com>
In-Reply-To: <676d231b.050a0220.2f3838.0461.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2024-12-26, 01:34:19 -0800, syzbot wrote:
> syzbot found the following issue on:
> 
> HEAD commit:    9268abe611b0 Merge branch 'net-lan969x-add-rgmii-support'
> git tree:       net-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155c0018580000

Test Sabrina's patch.

#syz test

--- x/net/tls/tls_main.c
+++ y/net/tls/tls_main.c
@@ -737,6 +737,8 @@ static int do_tls_setsockopt_conf(struct
 	else
 		ctx->rx_conf = conf;
 	update_sk_prot(sk, ctx);
+	if (update)
+		return 0;
 	if (tx) {
 		ctx->sk_write_space = sk->sk_write_space;
 		sk->sk_write_space = tls_write_space;
--

