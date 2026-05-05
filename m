Return-Path: <netdev+bounces-284178-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHSbIdNY+Wk68AIAu9opvQ
	(envelope-from <netdev+bounces-284178-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 04:41:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0420E4C60C2
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 04:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BA9A3022938
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 02:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972F0399369;
	Tue,  5 May 2026 02:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQ69q06G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BE83932CC
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 02:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777948866; cv=none; b=ugkzAR6FMYvf/SY9UL0lOWm2F9EQb+TaA7Gv3W0jmFF0IHg2Lu0hRPBlIurBTGgCkamkTiUUj7xqioCWZPSqKDZuHvwYxV0Pe5lSXh/KMFPQSFUYsjsrl4UYVMqRN5YjPnOXYJYrm02EBuPkXHUPl7UnPWzZQ5CZA9xk1OMv+p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777948866; c=relaxed/simple;
	bh=JPA34X8gT60efwV2x2+oQQcQFxFTT5boWVyrp/QWQXM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m1gHt9TdbRq7yRUxuGbrCiro0Uw9p2csYB+2ZFdEnJs/uwYVUuteWgZ4Xzy4Nw+ov7mm+QrsKXZxYBZxN/LzakQw29pDj75SZMGj7zxM4JQlXOVJEXM5qYAUl/jPfY1rA3bBs/fowX0kPDMH3B7TRg+eGVenbb5xlncFXGaqtvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQ69q06G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F1CC2BCC4;
	Tue,  5 May 2026 02:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777948864;
	bh=JPA34X8gT60efwV2x2+oQQcQFxFTT5boWVyrp/QWQXM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FQ69q06G/VxxedFes0lOE9O9i+3RTuCNVx1XUyOXd0XC69+bZ9uXmflquTvaNxQuS
	 hcmFWxs4pm1w+p+aemCfjJ4x5sidd4zPmDyRvkbPgHFG7Bc74+L6wyDMXjs74UBp0g
	 3dVPTigGe7F3VohUyS/H8WqHCaH7jtPH6+nyrDVqbaz/LDV0uXobU1vqSWMzzxhlf6
	 53ea64s3izvffgqe/1iROl5w+fE2Co0OxqY5MbZq9IWd8xfEmZ1tLd3iD2Gi+ik53y
	 Dn1vAzNpO6w7zDYPEUNV0EKOmi26ls7BE8avcY11bgCS96DlFK8VKkkeLWc2t2WHSK
	 zIh6iVNQfY4dQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C4939301A2;
	Tue,  5 May 2026 02:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: prevent possible UAF in rtnl_prop_list_size()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177794881454.1397274.9486403503330101886.git-patchwork-notify@kernel.org>
Date: Tue, 05 May 2026 02:40:14 +0000
References: <20260502124102.499204-1-edumazet@google.com>
In-Reply-To: <20260502124102.499204-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
X-Rspamd-Queue-Id: 0420E4C60C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-284178-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  2 May 2026 12:41:02 +0000 you wrote:
> I was mistaken by synchronize_rcu() [1] call in netdev_name_node_alt_destroy(),
> giving a false sense of RCU safety at delete times.
> 
> We have to use list_del_rcu() to not confuse potential readers
> in rtnl_prop_list_size().
> 
> [1] This synchronize_rcu() call was later removed in commit 723de3ebef03
> ("net: free altname using an RCU callback").
> 
> [...]

Here is the summary with links:
  - [net] net: prevent possible UAF in rtnl_prop_list_size()
    https://git.kernel.org/netdev/net/c/ac0841d7d202

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



