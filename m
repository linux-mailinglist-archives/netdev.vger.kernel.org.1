Return-Path: <netdev+bounces-169650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E773EA45164
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 01:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A463AA51B
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 00:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB679219FF;
	Wed, 26 Feb 2025 00:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6gQE5ID"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9691233F7
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 00:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740529489; cv=none; b=u7RAQMMUe4wA5EkQtu5OoTyf3MoU/PBRK7JKtmFLkFWCLW8jPoJAAwuhCYkTVgdyczYC46/dkkbwBxpgcP/v2QqLjG82j1qaHm7dnZUEv1mNajNJqFT/eltxxeTCwB1p5g4BK6u3Sp9XRu3MOC9vTO3B3XTtkFjJ0tJZ/stTBTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740529489; c=relaxed/simple;
	bh=sWRBHgzxDwxS8pOGqudGrkN0S/M5frf+7sgw+EapEPk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S4hNDTQV0vuNC+H1GN+p3I9fV/UTK9cbOjh1byfoVxhvASMuSOTyOoBSwNyjjzTdhM5dM1l3QInDPf4DsThk72LjoB6yw1bav5Gzg6L15cIDwmu2dRTA3vusYIS1Epd3tb/7kDVWdxgrxAUGUmdTPdYxuWC8K19z/CpYJT2TWJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6gQE5ID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C97C4CEDD;
	Wed, 26 Feb 2025 00:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740529489;
	bh=sWRBHgzxDwxS8pOGqudGrkN0S/M5frf+7sgw+EapEPk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R6gQE5IDEPoe0TEm6JXTw4gFWbR05yRuNsH28SnFK/GP1t1GQThwgWNn/jdR/h4Jc
	 AM3IpsRX6B581In3xfyq8R8OWVRPmcNrXqi61ScMWXZwe36miiw/c4L4qeDrJe3+fY
	 UZ1JpmhNBeEjxpadfuPuoVFukQ8oikQnalWnAdhqCpne/GYZwpQPV9FUuuT3GHlbgN
	 DTc9aXeLHsq6ffkJ65V1xLMdz1QsQWF2cpQQpLQD7ENZ8S49jYgknl77OfISwK/rhb
	 5xsxXuDducNcwou+VGZ1k2tuPvQU8ga5SaLwe7+vDiGs9WTSEkRuUuQ1PwKcTN4pqD
	 YBpms5ZJQUIpg==
Date: Tue, 25 Feb 2025 16:24:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, "Paolo Abeni"
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net-next 00/12] ipv4: fib: Convert RTM_NEWROUTE and
 RTM_DELROUTE to per-netns RTNL.
Message-ID: <20250225162448.3a3c4133@kernel.org>
In-Reply-To: <20250225182250.74650-1-kuniyu@amazon.com>
References: <20250225182250.74650-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Feb 2025 10:22:38 -0800 Kuniyuki Iwashima wrote:
> Patch 1 is a misc cleanup.
> Patch 2 ~ 8 converts two fib_info hash tables to per-netns.
> Patch 9 ~ 12 converts rtnl_lock() to rtnl_net_lcok().

Breaks quite a few tests :(

unreferenced object 0xffff88800bfc6800 (size 256):
  comm "ip", pid 577, jiffies 4294699578
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 0):
    __kmalloc_node_noprof+0x35d/0x4a0
    fib4_semantics_init+0x25/0xf0
    fib_net_init+0x17e/0x340
    ops_init+0x189/0x550
    setup_net+0x189/0x750
    copy_net_ns+0x1f7/0x340
    create_new_namespaces+0x35f/0x920
    unshare_nsproxy_namespaces+0x8d/0x130
    ksys_unshare+0x2a9/0x660
    __x64_sys_unshare+0x31/0x40
    do_syscall_64+0xc1/0x1d0
    entry_SYSCALL_64_after_hwframe+0x77/0x7f
-- 
pw-bot: cr

