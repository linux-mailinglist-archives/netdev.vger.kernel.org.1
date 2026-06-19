Return-Path: <netdev+bounces-300573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p3mOCImZNGrocQYAu9opvQ
	(envelope-from <netdev+bounces-300573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 03:21:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C58E6A388A
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 03:21:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=kernel.org header.s=k20260515 header.b=YTH3kP4J;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300573-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300573-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=reject ("signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0297630A11C7
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 01:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BD9329C60;
	Fri, 19 Jun 2026 01:20:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2906E3242BD;
	Fri, 19 Jun 2026 01:20:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781832026; cv=none; b=tUmd0LvDGgK6O96LbBmtQOHZFG7Eg3NSbAmBauIIEgFDtjZdrREyDp0stZdVLbce8qJz0fLXO4BXThfBtXIWupek+9gpwjQERZZq5rJ6bcFtXnih/aUOqmlje9gdZ7MVHT/+lpo5HucRYylcXXYE/I+US5LV8fLYeIneLS8UeTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781832026; c=relaxed/simple;
	bh=hQUczRwOmbjYC4tFqEfwOkYndz61ojVndcNt9FFLpD4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C0iqdAvfvmzc8CMQJ61gIyw+sHRqvyKtm2lny6wKtdwzXhPzThZ2UXkrKx6ixgZu+vVtdPK7ubEIaBJxoFyxNlqp40QWNlwpitrx7ENObksaQRsd+Zn5dvVT1+7Vky5J8FkOjkxxKhl8azN3+ljaipktlaJITEWgElA7GUK8Hvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTH3kP4J; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFCE1F000E9;
	Fri, 19 Jun 2026 01:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781832024;
	bh=+jQSNOHQcOXCNEdd+v97Y9Ht9FIDk9xAn+OUeDiAeCQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YTH3kP4JLNbwSDo2G01w9Pf4DJ15qZ+Us/isz0DW2Is85BXq58t4QaMzd4K5EOn0B
	 QBlgHr8lhfSsjuYP0xIXMU4o17iN36K8JYJsPxxagOuU+ODV9aHFV4ufGpRvZ2hB5G
	 nQDE1dVyTQwGMg+i75xGZNy4vANXHMn5O3ipLwF21/KnCe875ladrj4UVMZRMQjow9
	 ABIEm8PpM0gyBIdV1mZaI1bmmyGgWOr0X4eZ2nEHpmTInrBWRHfCPBw10rXLeENuKp
	 N5EV0arp7sujZ0gLeZ+2W5BZyojQyitojyewXyPhS/6RG55GiDnv1ClG1IFarRzVg7
	 YlqIHbIOOFYsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568BC3A78A7C;
	Fri, 19 Jun 2026 01:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] flow_dissector: check device type before reading
 ETH_ADDRS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178183201788.3150917.7342180302629791951.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jun 2026 01:20:17 +0000
References: <20260616123057.482154-1-yun.zhou@windriver.com>
In-Reply-To: <20260616123057.482154-1-yun.zhou@windriver.com>
To: Zhou@codeaurora.org, Yun <yun.zhou@windriver.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, qingfang.deng@linux.dev
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20260515];
	DKIM_TRACE(0.00)[kernel.org:-];
	TAGGED_FROM(0.00)[bounces-300573-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS(0.00)[m:Zhou@codeaurora.org,m:yun.zhou@windriver.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:qingfang.deng@linux.dev,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C58E6A388A

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Jun 2026 20:30:57 +0800 you wrote:
> __skb_flow_dissect() unconditionally reads 12 bytes from eth_hdr(skb)
> when FLOW_DISSECTOR_KEY_ETH_ADDRS is requested. This assumes the skb
> has a valid Ethernet header at mac_header, which is not always the case.
> 
> The problem can be triggered by:
>  1. Creating a TUN device in L3 mode (IFF_TUN, hard_header_len=0)
>  2. Attaching a multiq qdisc with a flower filter matching on eth_src
>  3. Sending a packet through AF_PACKET
> 
> [...]

Here is the summary with links:
  - [v4] flow_dissector: check device type before reading ETH_ADDRS
    https://git.kernel.org/netdev/net/c/bf6e8af2c8be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



