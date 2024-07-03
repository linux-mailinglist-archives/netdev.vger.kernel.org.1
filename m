Return-Path: <netdev+bounces-108800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B919258CF
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 12:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5B1A1F262BB
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 10:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFF316EBF2;
	Wed,  3 Jul 2024 10:36:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail114-241.sinamail.sina.com.cn (mail114-241.sinamail.sina.com.cn [218.30.114.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2762313D61B
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 10:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002972; cv=none; b=ji9dc+kpnGgg6fTCANgKamU29e6/0LpckczZmhQuYnKeWhjisMMoL43b3Gnqgpqk9+4LRLYtIoRlMtTifbnp4EHjxlOnwVrPoElH2vUT5tb2Jn4TJZCHwOwCJHV4mB1pSnyxPQtKgESBTnP76J+eapCe/CAKidmvephL2KTA6yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002972; c=relaxed/simple;
	bh=Oj2XBv/HMF5uB8m1GDKSCwlLjhQ8YPZdw9ShmXnxVMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fi2klp8QOi780VtPy70nPUWiX5mwrYW51WcR5N1jUHvIsv6m5mc5gn2Q7laFkybxx7lnzCO4qD66n1PvY8fyzyBGvsBrW9A6g3RbXXK667QCW6T25WkOi3AaBONXJ4AwajpDmR5k8eH05MnRkLIrjE/so3tD+618h9tP47P3hW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.67])
	by sina.com (10.185.250.23) with ESMTP
	id 6685298A00004CBD; Wed, 3 Jul 2024 18:35:56 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9998688913377
X-SMAIL-UIID: 64AC182C870D4FF98CF825E46BB7D733-20240703-183556-1
From: Hillf Danton <hdanton@sina.com>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+4fd66a69358fc15ae2ad@syzkaller.appspotmail.com
Subject: Re: [PATCH nf] netfilter: nf_tables: unconditionally flush pending work before notifier
Date: Wed,  3 Jul 2024 18:35:44 +0800
Message-Id: <20240703103544.2872-1-hdanton@sina.com>
In-Reply-To: <20240702140841.3337-1-fw@strlen.de>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  2 Jul 2024 16:08:14 +0200 Florian Westphal <fw@strlen.de>
> syzbot reports:
> 
> KASAN: slab-uaf in nft_ctx_update include/net/netfilter/nf_tables.h:1831
> KASAN: slab-uaf in nft_commit_release net/netfilter/nf_tables_api.c:9530
> KASAN: slab-uaf int nf_tables_trans_destroy_work+0x152b/0x1750 net/netfilter/nf_tables_api.c:9597
> Read of size 2 at addr ffff88802b0051c4 by task kworker/1:1/45
> [..]
> Workqueue: events nf_tables_trans_destroy_work
> Call Trace:
>  nft_ctx_update include/net/netfilter/nf_tables.h:1831 [inline]
>  nft_commit_release net/netfilter/nf_tables_api.c:9530 [inline]
>  nf_tables_trans_destroy_work+0x152b/0x1750 net/netfilter/nf_tables_api.c:9597
> 
> Problem is that the notifier does a conditional flush, but its possible
> that the table-to-be-removed is still referenced by transactions being
> processed by the worker, so we need to flush unconditionally.
> 
Given trans->table goes thru the lifespan of trans, your proposal is a bandaid
if trans outlives table.

