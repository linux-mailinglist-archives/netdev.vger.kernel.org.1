Return-Path: <netdev+bounces-284179-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHllOyNZ+Wk68AIAu9opvQ
	(envelope-from <netdev+bounces-284179-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 04:42:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F134C60D1
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 04:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79266303FAD6
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 02:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE113A169F;
	Tue,  5 May 2026 02:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jr9jNaSp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC8D39DBC4
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 02:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777948869; cv=none; b=GemkxD+EO5LY9Ec0eYGr86pz7vfeH9z2watHHaOXOTqqGh7Z1c5zFxC5W4ze//RjtgGI8HzkXqU/NGeoSE2Gem4Dt0Wmx1y+/XhPySw5TPqhLcPTxbNw2vSnot7RVcnJji1t00kGnPCRTLluuitjkmcVb1o8LydWnexCxX4M3xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777948869; c=relaxed/simple;
	bh=EdqPuaDiqOxiu4Pm1cc9IkgEx+MzC9d6COE2s0kE8+A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gi6xlMBNnzHp8Ky9NZRKUqzzXl5/QBt65PlCQ6raKGyWO2pvzNlL3SYvXKqSENxLgZYAXLY1fNPhdKO/HCAfVYo6Ka/aRQuK/uty12QwmJDU1g7JGV9pdWtkUPL6Jg6o//YwsAZEogJFg+d/bjzYap2jNig+DNW+XtzXNqAOLhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jr9jNaSp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3A5C2BCB8;
	Tue,  5 May 2026 02:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777948869;
	bh=EdqPuaDiqOxiu4Pm1cc9IkgEx+MzC9d6COE2s0kE8+A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Jr9jNaSpOBH5p/6Iu+iulmmt9QBt+8/gw3b88tVRIV1k+97SI191IWIfQBQ+SOJ/5
	 ecqJskcaOPLFSbm+YMOlehFNHvVg5pWd4UBBoUjPVrxz+dGtN7hqAEN01YcmWbUR5s
	 kU4hXy559PhXQ5PR6gFsdMxcB2C0KsvnjOzFop4t7rEskzCAFm4W9CdywPof1ogmcP
	 yBHfoFw6wk1kDhUC3O3li75arLh2GY4LV1oDsiOqUsVFsDdI2l45XK3XcqX8w+gNiP
	 Lg7SUDDyPFVoV6OtApJwcaNnHIXi6VE8GnrGsr9NUQTsHt9/vYT5u+WM2INIzctqh5
	 sWbWupCY7K2fA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FBFE39301A2;
	Tue,  5 May 2026 02:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/sched: speedup tc_dump_qdisc() when
 tcm_handle
 is provided
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177794882004.1397274.13628832774580358402.git-patchwork-notify@kernel.org>
Date: Tue, 05 May 2026 02:40:20 +0000
References: <20260503114515.2460477-1-edumazet@google.com>
In-Reply-To: <20260503114515.2460477-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Rspamd-Queue-Id: 55F134C60D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-284179-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  3 May 2026 11:45:15 +0000 you wrote:
> "tc qdisc show ... handle xxx" filtering can be done by the kernel.
> 
> A followup patch can do the same for tcm_parent.
> 
> iproute2/tc needs a small companion patch.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net/sched: speedup tc_dump_qdisc() when tcm_handle is provided
    https://git.kernel.org/netdev/net-next/c/c1e5127b577c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



