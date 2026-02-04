Return-Path: <netdev+bounces-256522-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCx3Nz6xgmn/YAMAu9opvQ
	(envelope-from <netdev+bounces-256522-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 03:38:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5D7E0EC5
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 03:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49C92307B08D
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 02:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFB32BD02A;
	Wed,  4 Feb 2026 02:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sC/AsGzx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8800F231842;
	Wed,  4 Feb 2026 02:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770172698; cv=none; b=rJ70LQd3cmeoNKNVORV7tun1p2QqF2GHNFq8XkWVem2UUnsY0Pd8WUm9ZNEUHsIZ+TB05MuZTbrVJ+dCTaoaDOpI3OJBKf0ab8sMgaxdeIeUNLNbC2VSZy9wipsFBnOBlxy5cQU43qBvdl+y5kGcXgs/7gBBOiLC0Y1NfcTzPXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770172698; c=relaxed/simple;
	bh=G2VSSNpwXmf7g1sFP46ogxcG7BeVML6goWr8A13QQ10=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l+aSvqND4YAzaRge3Hu2LCRyKFyBD/8Ldd5v0BGO6Dgq74C/ybrR6uac5bIumDXun2KE+NBG6cR5dju+jF85jdR91xjfJDTBByv37PplsQEl73tJOWgfLnOpX66pkgekXsNsaC3wKa7nixn4u+MCjtZHrYQ6eQTkn8XsNAXYhHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sC/AsGzx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B664C116D0;
	Wed,  4 Feb 2026 02:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770172698;
	bh=G2VSSNpwXmf7g1sFP46ogxcG7BeVML6goWr8A13QQ10=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sC/AsGzx1hH/xiUDBh6Gga9FpRcqSs7pvPu7rU7Sa7GZ52mP9xJUUdcsV5la7E6fa
	 +/t96hTNVQzWj4l1NdrJy+hhPQ8qLkUpSFYFtOkT4ne2HZGpm2bruCIlclABxM1JXx
	 qTLvBDnD8vqpLMDDHn9An8GvI0odkE4TdFSU8Z2NG+jgFFMzVFccp+hkqFnloaLy+J
	 i98Mhwgx1EYuyhVi24SXI1EwFwTgyyt4QTI4DUMkmwwBepLJd2sEjCLk5qejdQ1Z+7
	 29PlRhyjuo4P9s9jQV8UDYPeEts3ZNqyvfaTgtd3vK8Bsp/qka00yakUIFQlU9KBgz
	 3X6qCZ8Q9BHgA==
Date: Tue, 3 Feb 2026 18:38:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <shenjian15@huawei.com>,
 <liuyonglong@huawei.com>, <chenhao418@huawei.com>, <lantao5@huawei.com>,
 <huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
 <jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: hns3: fix double free issue for tx spare
 buffer
Message-ID: <20260203183816.3bb02543@kernel.org>
In-Reply-To: <20260202105837.1909444-1-shaojijie@huawei.com>
References: <20260202105837.1909444-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-256522-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D5D7E0EC5
X-Rspamd-Action: no action

On Mon, 2 Feb 2026 18:58:37 +0800 Jijie Shao wrote:
> The driver missed to clear ring->tx_spare to NULL when
> fail to initialize tx spare buffer. And it will try to
> free the tx spare buffer in hns3_fini_ring() if tx_spare
> is not NULL. So it may cause double free issue.

Please update this commit message so that reviewers don't have 
to do as much research. 

