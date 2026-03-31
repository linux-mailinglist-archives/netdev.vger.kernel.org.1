Return-Path: <netdev+bounces-273410-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qACULLIZy2lrDwYAu9opvQ
	(envelope-from <netdev+bounces-273410-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:47:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 188AC362D1C
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA519305F7C1
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B0029B8CF;
	Tue, 31 Mar 2026 00:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/Q0c2Ba"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DA228727D;
	Tue, 31 Mar 2026 00:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774917623; cv=none; b=dS0KJNHjh38+h66zaCxBjJvYU5avjWYRITkzOFZCbdqnauSMXU6ChC/tSEtw8PWdKrd2iBeEViM0R4msnB7wdsEP+IVrSvSXDTBfJX+Oik/osjtcE+pp2Q96ovt9bAD7V1ecCq80IpyntFRN0b9SLP4DaNrM+4o3zWYTE8ewa1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774917623; c=relaxed/simple;
	bh=YP3+hNUq+Nu+rrNQH3mxpsUfk41MmwADEDI/aTwd2vo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GVQ6iDPOQKx2K/8Pmmdo+P23OxjEWizDFFuMuKS9wjoKn+dxWvLnWPlm3dbJVoI3HOgkC9ieRZN08ShRFpzBYKHwxQSWP+yR6L7uvWGC08edMlqx2I7Tk9aeQ/7NTV0dIgsTrYl32gLqh/d18Xnzn3gZ+KD/YPycxm/gbAB5uIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/Q0c2Ba; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98890C4CEF7;
	Tue, 31 Mar 2026 00:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774917623;
	bh=YP3+hNUq+Nu+rrNQH3mxpsUfk41MmwADEDI/aTwd2vo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s/Q0c2BabcpahstSseJGDP7oiCxSbsNWvtobCbZpFLHweUlgMK4sOBIWFXkerPwAw
	 i+6fX7jF4sllaqaEC6nqwfJDyTZCejBqJ+wQ9PhNwbM2GLt8z2CoEI2EJRxkZKgJmt
	 v7R0P4FERfPn87+5b4fp9VHu5rMdDc/aWj4O3OiNhQ9QCqRzdTvjXglhocM9dh15Zt
	 AXURgamUa7nKE93dsIcPfOqm7RSJLM9WLPT9aPNPSzGy3Qc67URO/3gHrZ/8evnPND
	 93Ary04ptadl7B25+Chgv7S9hc/CEzYaO8fEkEHLIVO4ylIoRWeJ3T7eIvGP74AclL
	 cylclgbbFOtLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E2D392FF85;
	Tue, 31 Mar 2026 00:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v7] net: use skb_header_pointer() for TCPv4 GSO
 frag_off
 check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177491760753.2032642.18276185751372950060.git-patchwork-notify@kernel.org>
Date: Tue, 31 Mar 2026 00:40:07 +0000
References: <20260327153507.39742-1-yss2813483011xxl@gmail.com>
In-Reply-To: <20260327153507.39742-1-yss2813483011xxl@gmail.com>
To: Guoyu Su <yss2813483011xxl@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org,
 horms@kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com,
 syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org,googlegroups.com,syzkaller.appspotmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273410-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,1543a7d954d9c6d00407];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 188AC362D1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Mar 2026 23:35:07 +0800 you wrote:
> Syzbot reported a KMSAN uninit-value warning in gso_features_check()
> called from netif_skb_features() [1].
> 
> gso_features_check() reads iph->frag_off to decide whether to clear
> mangleid_features. Accessing the IPv4 header via ip_hdr()/inner_ip_hdr()
> can rely on skb header offsets that are not always safe for direct
> dereference on packets injected from PF_PACKET paths.
> 
> [...]

Here is the summary with links:
  - [net,v7] net: use skb_header_pointer() for TCPv4 GSO frag_off check
    https://git.kernel.org/netdev/net/c/ddc748a391dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



