Return-Path: <netdev+bounces-285078-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PYhBODM+2nZEwAAu9opvQ
	(envelope-from <netdev+bounces-285078-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 01:21:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E294E17B0
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 01:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D64D43007AF5
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 23:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64A7361DDA;
	Wed,  6 May 2026 23:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGs1Cono"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F913043BE
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 23:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778109659; cv=none; b=ipeBSijvqIRo0XP+LyiBjgLNRxpsX1Awbord7MHUpvN1ZKuAq2Dz0Eg6AHqGoFkQpG83P+8ZJToG4Bxa1cLkZW/a9pJWo7pO6W4yDpKW/Bo5jUBFEOuzCU30xRUP4yLOFMRYrquw6+AXnLtnnthFklnbiHVi9lHxO3DDo8xvuww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778109659; c=relaxed/simple;
	bh=RhqNrHkkzQOn7SAXCZviEW7MCvVIB7D1xLMjV1XbhEA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XHhj45JHWHqvd5cT29wVItqHggdnTnOvqb9hdJEPrCc/1rOyjT8MVqxki27tlYpzVI+79KbqjwAkSJ7TUR8IzsF7kMVMTgeOVH6r+Arl3Z0YaIG3Vpizq6W7jcPBGwjIdKdPjpm7nxcm0dedqhnEYECJZnJ7Wq+82mk4WaKXaas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGs1Cono; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DFCC2BCB0;
	Wed,  6 May 2026 23:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778109659;
	bh=RhqNrHkkzQOn7SAXCZviEW7MCvVIB7D1xLMjV1XbhEA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QGs1ConojzZ27jq7bZ04DcypnIqVj4hpd9V1zdgqK4uZL2BDyxJKTNK1X/9BXt9cQ
	 0DzCj5+ij7nEnzhAr0QtFBlDZ11HYh7AQKoPsnJ8MfYf7/z7JCRXs/B6XD+5DNQ9td
	 dTI2I1AxbgQwIH19X7BXNrobHL7cGo9J04Q9obVeH6rQCZNj8pe5S3zQzVVa8trp7v
	 dsZA5EwEw52Ov6eSAFgzEOIGQwIZ7hOMbcKtBSgqh1c7BUFL7ouT+bUDiZ4P4mTsNh
	 dHQ/eJbKkizWPZr8MZi+3z+uERJbvRR8QPs1M3p6YAO81PmHdjQsaPL2gFnaR0kGNR
	 BtynBj6VXFJ/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02EA5393089F;
	Wed,  6 May 2026 23:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/3] ovpn: reset MAC header before passing skb up
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177810960855.3261050.17877311688844142773.git-patchwork-notify@kernel.org>
Date: Wed, 06 May 2026 23:20:08 +0000
References: <20260504230305.2681646-2-antonio@openvpn.net>
In-Reply-To: <20260504230305.2681646-2-antonio@openvpn.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, edumazet@google.com, sd@queasysnail.net,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, ralf@mandelbit.com,
 qingfang.deng@linux.dev, andrew+netdev@lunn.ch, ptpt52@gmail.com
X-Rspamd-Queue-Id: 58E294E17B0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-285078-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,queasysnail.net,davemloft.net,kernel.org,redhat.com,mandelbit.com,linux.dev,lunn.ch,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Antonio Quartulli <antonio@openvpn.net>:

On Tue,  5 May 2026 01:03:03 +0200 you wrote:
> From: Qingfang Deng <qingfang.deng@linux.dev>
> 
> After decapsulating a packet, the skb->mac_header still points to the
> outer transport header.
> 
> Fix this by calling skb_reset_mac_header() in ovpn_netdev_write() to
> ensure the MAC header points to the beginning of
> the inner IP/network packet, as expected by the rest of the stack.
> 
> [...]

Here is the summary with links:
  - [net,1/3] ovpn: reset MAC header before passing skb up
    https://git.kernel.org/netdev/net/c/a200cdbf9593
  - [net,2/3] ovpn: ensure packet delivery happens with BH disabled
    https://git.kernel.org/netdev/net/c/c539cb30f93f
  - [net,3/3] selftests: ovpn: reduce ping count in test.sh
    https://git.kernel.org/netdev/net/c/201ba706318d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



