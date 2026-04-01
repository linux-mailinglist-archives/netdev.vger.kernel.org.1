Return-Path: <netdev+bounces-273830-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFk/NaR+zGl/TQYAu9opvQ
	(envelope-from <netdev+bounces-273830-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 04:10:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FF8373A6E
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 04:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FD5D30758B8
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 02:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96F6309F1B;
	Wed,  1 Apr 2026 02:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Usr7hN7Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853192FFDDE;
	Wed,  1 Apr 2026 02:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775009423; cv=none; b=YQHmcSa+EwO6NVi1Sy6SwiB6Zqy8i55iCJiFiip8RZLYCb42jgQ7gmKJ3D1nBEFiX70Ryp8sA2jwUq9XNGF057+UKvvCpEhiv3c+PmBlxx1XLdTFHkpyQjfUCCpKyMF//ZnrDGOTufm54lZL/gdLR6DY9k36HwHbOwFfULEoaeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775009423; c=relaxed/simple;
	bh=+jxMg1qsMcBV0u4Wg5vSJPEqLgk1GDyHqJomtJ8pxjw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ckjl4ll07HmI9+Qp0ol0Np1V6KGEu4YvwGj4dzhIbRQB+wyXpNJ/00DRIdb/20v6jGhu/j9yCMfRAGAI9s3NOgNN/gKLe+T85oUq8SytVN4kFz3qvGdVVOujgFIhvIGB0BnciDxq1FYzYWC8yCN+vsMj7739cLOutt0WVs+WBks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Usr7hN7Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FFFC19423;
	Wed,  1 Apr 2026 02:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775009423;
	bh=+jxMg1qsMcBV0u4Wg5vSJPEqLgk1GDyHqJomtJ8pxjw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Usr7hN7QIxhZ+5HTtbudJ8t22L0QiKGS0PQEQ4uRVYD2MI+KBFs+QZLDqFHAuM69f
	 H18TQM3L1Z75dthlnv3u/1lasfsP6UGltFYxcmw8AJilSgyszWTzyXjMQfCsGvOxxP
	 quUAarzhHUnFjP+6y73NDh+kWQ2ZlT6LDgU5JPPKkVt8FYrSFmtFyINxs92E6TDVyj
	 b5HE3VCc3xvVHsp85Zfh9MWLI4WQZzg6oN2wN/Rdw2J2llS+sAonIyiq94R5KBg2Uv
	 SUhj8oUpD9vwPsyV6F4NTd2zCxYZ9Ro5gbAj3kXunMSHCWYHS6BwcV6wQ+0pDL8dnr
	 Tk6inBw8ou/4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEA63808203;
	Wed,  1 Apr 2026 02:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] mptcp: fix soft lockup in mptcp_recvmsg()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177500940629.3032542.11284521898968939164.git-patchwork-notify@kernel.org>
Date: Wed, 01 Apr 2026 02:10:06 +0000
References: <20260330120335.659027-1-lixiasong1@huawei.com>
In-Reply-To: <20260330120335.659027-1-lixiasong1@huawei.com>
To: Li Xiasong <lixiasong1@huawei.com>
Cc: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com, weiyongjun1@huawei.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273830-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 58FF8373A6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Mar 2026 20:03:35 +0800 you wrote:
> syzbot reported a soft lockup in mptcp_recvmsg() [0].
> 
> When receiving data with MSG_PEEK | MSG_WAITALL flags, the skb is not
> removed from the sk_receive_queue. This causes sk_wait_data() to always
> find available data and never perform actual waiting, leading to a soft
> lockup.
> 
> [...]

Here is the summary with links:
  - [net,v4] mptcp: fix soft lockup in mptcp_recvmsg()
    https://git.kernel.org/netdev/net/c/5dd8025a49c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



