Return-Path: <netdev+bounces-269724-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGOFGBuOvGkQ0gIAu9opvQ
	(envelope-from <netdev+bounces-269724-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 01:00:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6777D2D4567
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 01:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E3C73017023
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 00:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ED913B7AE;
	Fri, 20 Mar 2026 00:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CK3hB3CE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E73B40DFD4
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 00:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773964821; cv=none; b=PIIP1K6xthZAbV/QqyfKBK8F7JVEaOLlcXsxQBWqjQHlUuTYOYgrA/AGheoZ0QHfiQGlnddex1Z86ZPZJc9Fsf8ZN5hu+wyGslXaRyZdQWDX081GbVNVB/JdCY1YxfF/VM1CkG9bJHrrmDgsPy4YFU7wzvtYZfYxcw7qQkrKDvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773964821; c=relaxed/simple;
	bh=uOhgITQKlY5lefJDu438KIPH6Hq306EvwjoFminv3X4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZkoSDMjBNWhvkWU1H+vhBEfZFVSMXY+ncYJL0t0cZE5nOffsyOelP51Fc2ssf/thb3BwgFoEi0k3G9yk+L4CITswjgNcbPZA8nYfe07tdGRi8BlzLX/evlYYzRCP2b+VOgwAoxxMTib5X16xKxsiwsCMAjk929ggccgo2zh+T8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CK3hB3CE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EADC19424;
	Fri, 20 Mar 2026 00:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773964820;
	bh=uOhgITQKlY5lefJDu438KIPH6Hq306EvwjoFminv3X4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CK3hB3CEWbBw8QnWXM20XMGARe9ZhQ3kkyohE7hRkgyUiLUasSWgvVKHfQvHRzfoF
	 PTfrThGqNy/YyhtjgwjVr3D2AXL2c0YlGkH1nfVuFF0e+x9EU2stmtwXq+n2A8FA35
	 gRRW0N8a9hkgEc4DTZrLhtQT1l8G0tyck4ElQl1hykQNL+Mbd1Rmh2OOS6ihAxjlWr
	 qzT2jmCJym5hLJF3ijw7VVRnU62JEwCtsGEI+bo8wNDMVcBx/BdCdx+FCs0121c59J
	 CYX6B2E1vt7DrCXSqseJs8qTWT4QS+VGu+IOkwotwK/hcGqSuimX0RovYA9P+AlTOV
	 TupJseKCPZUcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE7A39302F6;
	Fri, 20 Mar 2026 00:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] nfc: nci: fix circular locking dependency in
 nci_close_device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177396481004.1855248.7295559798392102074.git-patchwork-notify@kernel.org>
Date: Fri, 20 Mar 2026 00:00:10 +0000
References: <20260317193334.988609-1-kuba@kernel.org>
In-Reply-To: <20260317193334.988609-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 ian.ray@gehealthcare.com, ilane@ti.com, linville@tuxdriver.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269724-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6777D2D4567
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Mar 2026 12:33:34 -0700 you wrote:
> nci_close_device() flushes rx_wq and tx_wq while holding req_lock.
> This causes a circular locking dependency because nci_rx_work()
> running on rx_wq can end up taking req_lock too:
> 
>   nci_rx_work -> nci_rx_data_packet -> nci_data_exchange_complete
>     -> __sk_destruct -> rawsock_destruct -> nfc_deactivate_target
>     -> nci_deactivate_target -> nci_request -> mutex_lock(&ndev->req_lock)
> 
> [...]

Here is the summary with links:
  - [net] nfc: nci: fix circular locking dependency in nci_close_device
    https://git.kernel.org/netdev/net/c/4527025d440c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



