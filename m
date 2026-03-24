Return-Path: <netdev+bounces-271098-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIYPB6Ggwmm3fQQAu9opvQ
	(envelope-from <netdev+bounces-271098-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:33:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F96D30A358
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 98B77300186A
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104833845DE;
	Tue, 24 Mar 2026 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsiu0R3+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E206A384254
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774362650; cv=none; b=iJGHsnFB1kzCVEYr0tRBPJFQrWcnru6PJbdcvw6g1h8SQCavvdx5SdFbNNdri4eU7A25fgq7ALo5l851LlcJ88XiU45LzQNxSNIqHi1DjWAJfOg6lzgVL/dLobi5ZKFAMCrQ7KXxBcfPeEsydnH0Qmhuy7XAJ6f2SLUwDfS/+uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774362650; c=relaxed/simple;
	bh=w48rIrpbfAb4vGXPhzcK2xgC889Wl9LvRP2zpYJSQ0w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C7xyn4bzOxHmOK/d30PBsTnLHiIz0iNEtHJC8K3A4sqLAyaDffZwAkzWNuFlb50tvON2VUgfnjblRfvIiMu/uQoNo0iyjbnIDhb0BGhzYFoho/w6uOPYBiGl3Hz6YoPlHnJNcM0K7EoV95t3FRMrHIpgXT56Yh9uGx9klMFh7SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsiu0R3+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEE8C19424;
	Tue, 24 Mar 2026 14:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774362649;
	bh=w48rIrpbfAb4vGXPhzcK2xgC889Wl9LvRP2zpYJSQ0w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gsiu0R3+px1GHYMfyiG77EYgyPlXCSYvMHIsrOuWH9NicyXhFmeK1olMM+WEFzXmq
	 IwYUP4U2FqF8/o3MfYFUb5UWui83W95M1LgPOGq8GC4m/fTvVF1I23zY+/HJ+AAU7+
	 pvsylT+tPcQfaB2ihhQ17uQzX4sdG69rBNIZrQ+hHzktOLlzyMhcCWlgXwnQc4Dt9+
	 BiPt34MClh/c1kDep7u50ghlokFkM3nbmS2s7iSP+BEkldAJJTklIQsNkS1TJ7K//q
	 ZrAAhPCPEiom8VMfXHYh3PrylVfLyyJM3A82nph4MNGjX69pOnTspq4HWyT4xYHM94
	 fFI0kVAif5ppA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D08A3808200;
	Tue, 24 Mar 2026 14:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 01/20] xfrm: add missing extack for XFRMA_SA_PCPU in
 add_acquire and allocspi
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177436263730.711955.14005087796995324209.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 14:30:37 +0000
References: <20260323083440.2741292-2-steffen.klassert@secunet.com>
In-Reply-To: <20260323083440.2741292-2-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271098-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,queasysnail.net:email]
X-Rspamd-Queue-Id: 0F96D30A358
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Mon, 23 Mar 2026 09:33:42 +0100 you wrote:
> From: Sabrina Dubroca <sd@queasysnail.net>
> 
> We're returning an error caused by invalid user input without setting
> an extack. Add one.
> 
> Fixes: 1ddf9916ac09 ("xfrm: Add support for per cpu xfrm state handling.")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> 
> [...]

Here is the summary with links:
  - [01/20] xfrm: add missing extack for XFRMA_SA_PCPU in add_acquire and allocspi
    https://git.kernel.org/netdev/net/c/aa8a3f3c6723
  - [02/20] xfrm: fix the condition on x->pcpu_num in xfrm_sa_len
    https://git.kernel.org/netdev/net/c/b57defcf8f10
  - [03/20] xfrm: call xdo_dev_state_delete during state update
    https://git.kernel.org/netdev/net/c/7d2fc41f91bc
  - [04/20] esp: fix skb leak with espintcp and async crypto
    https://git.kernel.org/netdev/net/c/0c0eef8ccd24
  - [05/20] xfrm: iptfs: validate inner IPv4 header length in IPTFS payload
    https://git.kernel.org/netdev/net/c/0d10393d5eac
  - [06/20] xfrm: iptfs: fix skb_put() panic on non-linear skb during reassembly
    https://git.kernel.org/netdev/net/c/0b352f83cabf
  - [07/20] xfrm: state: fix sparse warnings on xfrm_state_hold_rcu
    https://git.kernel.org/netdev/net/c/9f455aac17db
  - [08/20] xfrm: state: fix sparse warnings in xfrm_state_init
    https://git.kernel.org/netdev/net/c/e2f845f67278
  - [09/20] xfrm: state: fix sparse warnings around XFRM_STATE_INSERT
    https://git.kernel.org/netdev/net/c/55b5bc03148b
  - [10/20] xfrm: state: add xfrm_state_deref_prot to state_by* walk under lock
    https://git.kernel.org/netdev/net/c/33cefb76a8ed
  - [11/20] xfrm: remove rcu/state_hold from xfrm_state_lookup_spi_proto
    https://git.kernel.org/netdev/net/c/f468fdd52b97
  - [12/20] xfrm: state: silence sparse warnings during netns exit
    https://git.kernel.org/netdev/net/c/05b8673963c4
  - [13/20] xfrm: policy: fix sparse warnings in xfrm_policy_{init,fini}
    https://git.kernel.org/netdev/net/c/b1f9c67781ef
  - [14/20] xfrm: policy: silence sparse warning in xfrm_policy_unregister_afinfo
    https://git.kernel.org/netdev/net/c/2da6901866e7
  - [15/20] xfrm: add rcu_access_pointer to silence sparse warning for xfrm_input_afinfo
    https://git.kernel.org/netdev/net/c/103b4f5b4007
  - [16/20] xfrm: avoid RCU warnings around the per-netns netlink socket
    https://git.kernel.org/netdev/net/c/d87f8bc47fbf
  - [17/20] xfrm: Fix work re-schedule after cancel in xfrm_nat_keepalive_net_fini()
    https://git.kernel.org/netdev/net/c/daf8e3b253aa
  - [18/20] xfrm: prevent policy_hthresh.work from racing with netns teardown
    https://git.kernel.org/netdev/net/c/29fe3a61bcdc
  - [19/20] af_key: validate families in pfkey_send_migrate()
    https://git.kernel.org/netdev/net/c/eb2d16a7d599
  - [20/20] xfrm: iptfs: only publish mode_data after clone setup
    https://git.kernel.org/netdev/net/c/d849a2f7309f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



